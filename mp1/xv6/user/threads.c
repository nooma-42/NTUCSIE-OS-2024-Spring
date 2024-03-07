#include "kernel/types.h"
#include "user/setjmp.h"
#include "user/threads.h"
#include "user/user.h"
#define NULL 0

static struct thread* current_thread = NULL;
static int id = 1;
//static jmp_buf env_st;
//static jmp_buf env_tmp;

struct thread *thread_create(void (*f)(void *), void *arg){
    struct thread *t = (struct thread*) malloc(sizeof(struct thread));
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long) malloc(sizeof(unsigned long)*0x100);
    new_stack_p = new_stack +0x100*8-0x2*8;
    t->fp = f;
    t->arg = arg;
    t->ID  = id;
    t->buf_set = 0;
    t->stack = (void*) new_stack;
    t->stack_p = (void*) new_stack_p;
    id++;
    return t;
}
void thread_add_runqueue(struct thread *t){
    if (current_thread == NULL) {
        current_thread = t;
        t->next = t->previous = t;
    } else {
        t->next = current_thread;
        t->previous = current_thread->previous;
        current_thread->previous->next = t;
        current_thread->previous = t;
    }
}
void thread_yield(void){
    if (current_thread != NULL && setjmp(current_thread->env) == 0) {
        current_thread->buf_set = 1; // Mark context as saved
        schedule();
        dispatch();
    }
}
void dispatch(void) {
    if (current_thread->buf_set) {
        longjmp(current_thread->env, 1);
    } else {
        // Setup initial context for new thread
        // Instead of direct SP manipulation, rely on longjmp to set up the stack
        if (setjmp(current_thread->env) == 0) {
            current_thread->buf_set = 1;
            // Simulate the "return" from longjmp for the new thread
            current_thread->fp(current_thread->arg);
        }
        // If the thread function returns, it means it's completed execution
        thread_exit();
    }
}
void schedule(void){
    if (current_thread == NULL || current_thread->next == current_thread) {
        // No more threads to schedule, set current_thread to NULL
        current_thread = NULL;
    } else {
        // Normal scheduling logic
        current_thread = current_thread->next;
    }
}
void thread_exit(void){
    struct thread *temp = current_thread;
    
    if (current_thread->next != current_thread) {
        //printf("Thread %d is next\n", current_thread->next->ID);
        current_thread->previous->next = current_thread->next;
        current_thread->next->previous = current_thread->previous;
        current_thread = current_thread->next;
        free(temp->stack);
        free(temp);
        dispatch();
    } else {
        // Last thread
        free(current_thread->stack);
        free(current_thread);
    }
}
void thread_start_threading(void){
    if (current_thread != NULL) {
        dispatch(); // Start executing threads
    }
}

// part 2
void thread_assign_task(struct thread *t, void (*f)(void *), void *arg){
    // TODO
}
