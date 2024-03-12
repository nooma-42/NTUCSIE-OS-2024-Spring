#include "kernel/types.h"
#include "user/setjmp.h"
#include "user/threads.h"
#include "user/user.h"
#define NULL 0

static struct thread* current_thread = NULL;
static int id = 1;
static jmp_buf env_st;
// static jmp_buf env_tmp;

struct thread *thread_create(void (*f)(void *), void *arg){
    struct thread *t = (struct thread*) malloc(sizeof(struct thread));
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long) malloc(sizeof(unsigned long)*0x1000);
    new_stack_p = new_stack +0x1000*sizeof(unsigned long);
    
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
        // printf("Test3\n");
        schedule();
        dispatch();
    }
    // printf("Test2\n");
}
void dispatch(void) {
    if (current_thread->buf_set) {
        // printf("Test1\n");
        longjmp(current_thread->env, 1); // FIXME
    } else {
        if (setjmp(current_thread->env) == 0) {
            // printf("Test\n");
            current_thread->buf_set = 1;
            current_thread->env->sp = (unsigned long) current_thread->stack_p;
            longjmp(current_thread->env, 1);
        }
        else {
            // printf("Run\n");
            current_thread->fp(current_thread->arg);
            thread_exit();
        }
    }
}
void schedule(void){
    if(current_thread->next != current_thread){
        current_thread = current_thread->next;
    }
}
void thread_exit(void) {
    if (current_thread->next == current_thread) {
        free(current_thread->stack);
        free(current_thread);
        current_thread = NULL;
        longjmp(env_st, 1);
    } else {
        struct thread* prev_thread = current_thread->previous;
        struct thread* next_thread = current_thread->next;
        prev_thread->next = next_thread;
        next_thread->previous = prev_thread;
        free(current_thread->stack);
        free(current_thread);
        current_thread = next_thread;
        dispatch();
    }
}
void thread_start_threading(void){
    if(setjmp(env_st)) 
        return;
    schedule();
    dispatch();
}

// part 2
void thread_assign_task(struct thread *t, void (*f)(void *), void *arg){
    // TODO
}
