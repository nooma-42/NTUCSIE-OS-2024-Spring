#include "param.h"
#include "types.h"
#include "memlayout.h"
#include "riscv.h"
#include "spinlock.h"
#include "defs.h"
#include "proc.h"

/* NTU OS 2024 */
/* Allocate eight consecutive disk blocks. */
/* Save the content of the physical page in the pte */
/* to the disk blocks and save the block-id into the */
/* pte. */
char *swap_page_from_pte(pte_t *pte) {
  char *pa = (char*) PTE2PA(*pte);
  uint dp = balloc_page(ROOTDEV);

  write_page_to_disk(ROOTDEV, pa, dp); // write this page to disk
  *pte = (BLOCKNO2PTE(dp) | PTE_FLAGS(*pte) | PTE_S) & ~PTE_V;

  return pa;
}

/* 
disk 裡的資料儲存單位是 block，取得block空間要用balloc_page，free block空間要用bfree_page；
physical memory 裡的資料儲存單位是 page，取得page空間要用kalloc，free page空間要用kfree
https://cool.ntu.edu.tw/courses/33481/discussion_topics/284670
*/

/* NTU OS 2024 */
/* Page fault handler */
int handle_pgfault(uint64 va) {
  /* Find the address that caused the fault */
  /* uint64 va = r_stval(); */
  struct proc *p = myproc();
  pagetable_t pagetable = p->pagetable;

  // Align the faulting address to the page boundary
  va = PGROUNDDOWN(va); // 取得這個 page 記憶體的最底部。把這個值拿去 mappages()。

  // Find or create a PTE for the faulting address
  // walk可以藉由virtual address(va) 找到對應的page table entry (pte)，
  // 並且若在過程中遇到有需要的page table沒被kalloc，walk會幫忙弄好。
  // 至於memset則是可以在用kalloc分配一塊page(physical memory)給pa後，把那塊空間初始化，避免之前的資料干擾。
  // ref: https://cool.ntu.edu.tw/courses/33481/discussion_topics/284670
  pte_t *pte = walk(pagetable, va, 1);
  if (!pte) {
    panic("handle_pgfault: walk failed");
  }

  /* TODO */
  // Check if the page has been swapped out
  if (*pte & PTE_S && !(*pte & PTE_V)) {
    // Handle the case where the page is swapped out

    // Allocate a new physical page
    char *mem = kalloc();
    if (mem == 0) {
      panic("handle_pgfault: kalloc failed for swapped out page");
    }
    memset(mem, 0, PGSIZE);

    // Read the page from disk into the new physical memory
    uint64 blockno = PTE2BLOCKNO(*pte);
    read_page_from_disk(ROOTDEV, mem, blockno);

    // Update the PTE to point to the new physical page, marking it valid
    *pte = PA2PTE(mem) | PTE_FLAGS(*pte) | PTE_V | PTE_U | PTE_R | PTE_W | PTE_X;
    *pte &= ~PTE_S; // Clear the swapped-out flag

    // Free the disk block that was previously used to store the page
    bfree_page(ROOTDEV, blockno);
  } else if (!(*pte & PTE_V)) {
    // Handle the case where the page has never been initialized (not mapped)

    // Allocate a new physical page for the uninitialized address
    char *mem = kalloc();
    if (mem == 0) {
      panic("handle_pgfault: kalloc failed for uninitialized page");
    }
    memset(mem, 0, PGSIZE);

    // Map the faulting virtual address to the new physical page with appropriate flags
    if (mappages(pagetable, va, PGSIZE, (uint64)mem, PTE_U | PTE_R | PTE_W | PTE_X) != 0) {
      kfree(mem);
      panic("handle_pgfault: mappages failed for uninitialized page");
    }
  } else {
    // This case should not happen if the page is already mapped and valid
    panic("handle_pgfault: unexpected page fault scenario");
  }

  return 0; // Successfully handled the page fault
}
