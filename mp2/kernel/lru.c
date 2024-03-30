#include "lru.h"

#include "param.h"
#include "types.h"
#include "memlayout.h"
#include "riscv.h"
#include "spinlock.h"
#include "defs.h"
#include "proc.h"

void lru_init(lru_t *lru){
    lru->size = 0;
    for (int i = 0; i < PG_BUF_SIZE; i++) {
        lru->bucket[i] = 0;
    }
}

int lru_push(lru_t *lru, uint64 e){
	int idx = lru_find(lru, e);
    if (idx != -1) {
        // Page is already in the LRU, move it to the end to mark it as most recently used.
        uint64 temp = lru_pop(lru, idx);
        lru_push(lru, temp);
        return 1; // Already present, just updated.
    } else if (lru->size < PG_BUF_SIZE) {
        // Add new entry as the most recently used.
		lru->bucket[lru->size] = e;
        lru->size++;
        return 1; // Added new entry.
    } else {
        // LRU is full, attempt to find a non-pinned page to replace.
        for (int i = 0; i < lru->size; i++) {
            if ((*((pte_t*)lru->bucket[i]) & PTE_P) == 0) { // FIXME pte_t *
                // Found a non-pinned page; replace it.
                lru_pop(lru, i);
                lru->bucket[lru->size] = e;
                lru->size++;
                return 1; // Success
            }
        }
    }
	return -1; // Failure
}

uint64 lru_pop(lru_t *lru, int idx){
    if (idx >= 0 && idx < lru->size) {
        uint64 removed = lru->bucket[idx];
        for (int i = idx; i < lru->size - 1; i++) {
            lru->bucket[i] = lru->bucket[i + 1];
        }
        lru->size--;
        lru->bucket[lru->size] = 0; // Clear the removed spot.
        return removed;
    }
    return 0; // Invalid index.
}

int lru_empty(lru_t *lru){
    return lru->size == 0;
}

int lru_full(lru_t *lru){
    return lru->size == PG_BUF_SIZE;
}

int lru_clear(lru_t *lru){
    lru->size = 0;
    for (int i = 0; i < PG_BUF_SIZE; i++) {
        lru->bucket[i] = 0;
    }
    return 1; // Successfully cleared.
}

int lru_find(lru_t *lru, uint64 e){
    for (int i = 0; i < lru->size; i++) {
        if (lru->bucket[i] == e) {
            return i;
        }
    }
    return -1; // Not found.
}
