#include "fifo.h"

#include "param.h"
#include "types.h"
#include "memlayout.h"
#include "riscv.h"
#include "spinlock.h"
#include "defs.h"
#include "proc.h"

// FIXME LRU 要為 pin 更改順序
// 正確來說是 pin 就是一種存取就要改順序，但是對 FIFO 來說就不用改順序
// LRU 最近存取最晚換出去

void q_init(queue_t *q){
	q->size = 0;
    for (int i = 0; i < PG_BUF_SIZE; i++) {
        q->bucket[i] = 0;
    }
}

int q_push(queue_t *q, uint64 e){
	if (q->size < PG_BUF_SIZE) {
        q->bucket[q->size] = e;
        q->size++;
        return 1; // Success
    } else {
        // Queue is full, attempt to find a non-pinned page to replace.
        for (int i = 0; i < q->size; i++) {
            if ((*((pte_t*)q->bucket[i]) & PTE_P) == 0) { // FIXME pte_t *
                // Found a non-pinned page; replace it.
                q_pop_idx(q, i);
                q->bucket[q->size] = e;
                q->size++;
                return 1; // Success
            }
        }
    }
    // Failure: Queue is full and no non-pinned pages found.
    return 0;
}

uint64 q_pop_idx(queue_t *q, int idx){
    if (idx >= 0 && idx < q->size) {
        uint64 element = q->bucket[idx];
        // Shift elements down one position to fill the gap.
        for (int i = idx; i < q->size - 1; i++) {
            q->bucket[i] = q->bucket[i + 1];
        }
        q->size--;
        q->bucket[q->size] = 0; // Clear the now-unused last element.
        return element;
    }
    return 0; // Failure or invalid index
}

int q_empty(queue_t *q){
	return q->size == 0;
}

int q_full(queue_t *q){
	return q->size == PG_BUF_SIZE;
}

int q_clear(queue_t *q){
	q->size = 0;
    for (int i = 0; i < PG_BUF_SIZE; i++) {
        q->bucket[i] = 0;
    }
    return 1; // Indicate success
}

int q_find(queue_t *q, uint64 e){
	for (int i = 0; i < q->size; i++) {
        if (q->bucket[i] == e) {
            return i;
        }
    }
    return -1; // Element not found
}
