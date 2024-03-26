#include "fifo.h"

#include "param.h"
#include "types.h"
#include "memlayout.h"
#include "riscv.h"
#include "spinlock.h"
#include "defs.h"
#include "proc.h"

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
    }
    return 0; // Failure: Queue is full
}

uint64 q_pop_idx(queue_t *q, int idx){
	if (idx >= 0 && idx < q->size) {
        uint64 element = q->bucket[idx];
        for (int i = idx; i < q->size - 1; i++) {
            q->bucket[i] = q->bucket[i + 1];
        }
        q->size--;
        q->bucket[q->size] = 0; // Clear the last element
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
