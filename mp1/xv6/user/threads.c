#include "kernel/types.h"
#include "user/setjmp.h"
#include "user/threads.h"
#include "user/user.h"
#define NULL 0

static struct thread* current_thread = NULL;
static int id = 1;
static int task_id = 1;
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
    //printf("let yield\n");
    jmp_buf *context = current_thread->tasks ? &current_thread->tasks->env : &current_thread->env;
    if (setjmp(*context) == 0) {
        schedule();
        dispatch();
    }
}
void dispatch(void) {
    // If there is a task, run the task
    while (current_thread->tasks != NULL) {
        struct task *current_task = current_thread->tasks;
        if (!current_task->buf_set && setjmp(current_task->env) == 0) {
            current_task->buf_set = 1;
            current_task->fp(current_task->arg);
        }
        task_exit();

        if (current_thread->tasks == NULL) {
            schedule();
            dispatch();
        }
    }
    if (current_thread->buf_set) {
        // printf("Test1\n");
        longjmp(current_thread->env, 1); // FIXME
    } else {
        if (setjmp(current_thread->env) == 0) {
            //printf("Test2\n");
            current_thread->buf_set = 1;
            current_thread->env->sp = (unsigned long) current_thread->stack_p;
            longjmp(current_thread->env, 1);
        }
        else {
            //printf("Test3\n");
            current_thread->fp(current_thread->arg);
            thread_exit();
        }
    }
}
void schedule(void){
    if (current_thread->tasks != NULL) {
        return;
    }
    if(current_thread->next != current_thread){
        current_thread = current_thread->next;
    }
}
void task_exit(void) {
    //printf("task_exit\n"); // FIXME
    if (current_thread->tasks->next == NULL) {
        free(current_thread->tasks->stack);
        free(current_thread->tasks);
        current_thread->tasks = NULL;
        return;
    } else {
        struct task* next_task = current_thread->tasks->next;
        free(current_thread->tasks->stack);
        free(current_thread->tasks);
        current_thread->tasks = next_task;
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
    task_exit(); // FIXME
}
void thread_start_threading(void){
    if(setjmp(env_st)) 
        return;
    schedule();
    dispatch();
}

// part 2
void thread_assign_task(struct thread *t, void (*func)(void *), void *arg) {
    struct task *new_task = (struct task*) malloc(sizeof(struct task));
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long) malloc(sizeof(unsigned long)*0x100);
    new_stack_p = new_stack +0x100*sizeof(unsigned long);
    
    new_task->fp = func;
    new_task->arg = arg;
    new_task->ID  = task_id;
    new_task->buf_set = 0;
    new_task->stack = (void*) new_stack;
    new_task->stack_p = (void*) new_stack_p;
    id++;
    new_task->next = t->tasks;
    t->tasks = new_task;
}