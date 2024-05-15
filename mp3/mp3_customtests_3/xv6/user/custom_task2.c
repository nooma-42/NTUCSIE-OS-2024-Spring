#include "kernel/types.h"
#include "user/user.h"
#include "user/threads.h"

#define NULL 0

int k = 0;

void f(void *arg)
{
    while (1) {
        k++;
    }
}

// 15 threads of processing time 1 arrive at different times

int main(int argc, char **argv)
{
    for(int i=1;i<=15;i++){
        struct thread *t = thread_create(f, NULL, 0, 1, -1, 1);
        thread_set_weight(t, i);
        thread_add_at(t, 4*i+i%2);
    }
    thread_start_threading();
    printf("\nexited\n");
    exit(0);
}
