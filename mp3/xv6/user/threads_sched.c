#include "kernel/types.h"
#include "user/user.h"
#include "user/list.h"
#include "user/threads.h"
#include "user/threads_sched.h"

#define NULL 0
#define INT_MAX 2147483647
#define TIME_QUANTUM 2  // Define a base time quantum for the round-robin

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
    struct thread *thread_with_smallest_id = NULL;
    struct thread *th = NULL;
    list_for_each_entry(th, args.run_queue, thread_list) {
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
            thread_with_smallest_id = th;
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
        r.allocated_time = thread_with_smallest_id->remaining_time;
    } else {
        r.scheduled_thread_list_member = args.run_queue;
        r.allocated_time = 1;
    }

    return r;
}

/* MP3 Part 1 - Non-Real-Time Scheduling */
/* Weighted-Round-Robin Scheduling */
struct threads_sched_result schedule_wrr(struct threads_sched_args args)
{
    struct threads_sched_result r;
    // TODO: implement the weighted round-robin scheduling algorithm
    static struct thread *last_thread = NULL;
    struct thread *selected_thread = NULL;
    struct thread *candidate = NULL;

    // If last_thread is NULL or its remaining time is zero, reset the selection process
    if (last_thread == NULL || last_thread->remaining_time <= 0) {
        last_thread = NULL;
    }

    // Find the first thread that is ready to run
    list_for_each_entry(candidate, args.run_queue, thread_list) {
        if (!last_thread && candidate->remaining_time > 0)
            selected_thread = candidate;
        if (candidate->remaining_time > 0) {
            selected_thread = candidate;
            break;
        }
    }

    // Fall back to the last_thread if no other thread is selected and it still has remaining time
    if (!selected_thread && last_thread && last_thread->remaining_time > 0) {
        selected_thread = last_thread;
    }

    // Set the scheduling result
    if (selected_thread) {
        int time_slice = selected_thread->weight * TIME_QUANTUM;
        if (time_slice > selected_thread->remaining_time) {
            time_slice = selected_thread->remaining_time;
        }
        r.scheduled_thread_list_member = &selected_thread->thread_list;
        r.allocated_time = time_slice;
        last_thread = selected_thread;  // Update the last run thread
    } else {
        // Idle if no suitable thread is found
        r.scheduled_thread_list_member = args.run_queue;
        r.allocated_time = 1;
    }

    return r;
}

int find_next_release_time(struct list_head *release_queue, int current_time) {
    struct release_queue_entry *next_release = NULL;
    int next_release_time = INT_MAX;

    list_for_each_entry(next_release, release_queue, thread_list) {
        if (next_release->release_time > current_time && next_release->release_time < next_release_time) {
            next_release_time = next_release->release_time;
        }
    }

    if (next_release_time == INT_MAX)
        return -1; // No threads in the release queue

    return next_release_time - current_time;
}



int find_earliest_impactful_release_time(struct list_head *release_queue, struct list_head *run_queue, int current_time) {
    struct release_queue_entry *entry;
    int earliest_impactful_time = INT_MAX;
    int shortest_current_time = INT_MAX;

    // Find the shortest remaining time among currently running tasks
    struct thread *t;
    list_for_each_entry(t, run_queue, thread_list) {
        if (t->remaining_time < shortest_current_time) {
            shortest_current_time = t->remaining_time;
        }
    }

    // Check the release queue for the next task that might preempt the current shortest job
    list_for_each_entry(entry, release_queue, thread_list) {
        if (entry->release_time > current_time && entry->release_time < earliest_impactful_time) {
            if (entry->thrd->remaining_time < shortest_current_time) {
                earliest_impactful_time = entry->release_time;
            }
        }
    }

    // Calculate the difference between the current time and the earliest impactful release time
    return earliest_impactful_time == INT_MAX ? -1 : earliest_impactful_time - current_time;
}


struct threads_sched_result schedule_sjf(struct threads_sched_args args) {
    struct threads_sched_result r;
    struct thread *shortest_job = NULL;
    struct thread *current;
    int shortest_time = INT_MAX;
    int earliest_impactful_time = find_earliest_impactful_release_time(args.release_queue, args.run_queue, args.current_time);

    // Determine the shortest job from the run queue
    list_for_each_entry(current, args.run_queue, thread_list) {
        if (current->remaining_time < shortest_time) {
            shortest_time = current->remaining_time;
            shortest_job = current;
        }
    }

    if (shortest_job) {
        int time_to_allocate = shortest_job->remaining_time;
        // Reduce the time slice if an impactful task is arriving sooner
        if (earliest_impactful_time != -1 && earliest_impactful_time < time_to_allocate) {
            time_to_allocate = earliest_impactful_time;
        }

        r.scheduled_thread_list_member = &shortest_job->thread_list;
        r.allocated_time = time_to_allocate;
    } else {
        // If no current tasks are ready, wait for the next impactful task
        r.scheduled_thread_list_member = args.run_queue;
        r.allocated_time = earliest_impactful_time != -1 ? earliest_impactful_time : 1;  // Minimal quantum if unsure
    }

    return r;
}

int min(int a, int b) {
    return (a < b) ? a : b;
}

/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args) {
    struct threads_sched_result r;
    struct thread *min_slack_thread = NULL;
    int min_slack_time = INT_MAX;
    struct thread *t;
    // int ddl;
    // Determine the thread with the minimum slack time
    list_for_each_entry(t, args.run_queue, thread_list) {
        int slack_time = t->current_deadline - args.current_time - t->remaining_time;
        if (slack_time < min_slack_time || (slack_time == min_slack_time && t->ID < (min_slack_thread ? min_slack_thread->ID : INT_MAX))) {
            min_slack_thread = t;
            min_slack_time = slack_time;
            // ddl = t->current_deadline;
        }
    }

    // Calculate the next event time, initially very large
    int next_significant_event_time = INT_MAX;

    // Analyze each upcoming release to determine if and when they should preempt the current thread
    struct release_queue_entry *entry;
    list_for_each_entry(entry, args.release_queue, thread_list) {
        if (entry->release_time > args.current_time) {
            struct thread *upcoming_thread = entry->thrd;
            int upcoming_slack_time = upcoming_thread->current_deadline - entry->release_time - upcoming_thread->remaining_time;
            /* printf("current ddl: %d\n", ddl);
            printf("upcoming slack time: %d\n", upcoming_slack_time);
            printf("%d %d %d\n", upcoming_thread->current_deadline, args.current_time, upcoming_thread->remaining_time);
             */
            // Check if this upcoming thread will impose an earlier preemption due to tighter slack time
            if (upcoming_slack_time < min_slack_time) {
                next_significant_event_time = min(next_significant_event_time, entry->release_time);
            } else if (upcoming_slack_time == min_slack_time && upcoming_thread->ID < (min_slack_thread ? min_slack_thread->ID : INT_MAX))
                next_significant_event_time = min(next_significant_event_time, entry->release_time);
        }
    }

    // Decide the allocated time based on current minimum slack or upcoming preemption needs
    if (min_slack_thread) {
        int allocated_time = (next_significant_event_time == INT_MAX) ? min_slack_thread->remaining_time : next_significant_event_time - args.current_time;
        r.scheduled_thread_list_member = &min_slack_thread->thread_list;
        r.allocated_time = allocated_time;
    } else {
        // No runnable threads, prepare to sleep or wait based on next known event
        r.scheduled_thread_list_member = args.run_queue;
        r.allocated_time = next_significant_event_time != INT_MAX ? next_significant_event_time - args.current_time : 1;
    }

    return r;
}



/* Deadline-Monotonic Scheduling */
struct threads_sched_result schedule_dm(struct threads_sched_args args)
{
    struct threads_sched_result r;
    // TODO: implement the deadline-monotonic scheduling algorithm
   struct thread *earliest_deadline_thread = NULL;
    struct thread *t;
    int earliest_deadline = INT_MAX;

    // Find the earliest deadline real-time thread
    list_for_each_entry(t, args.run_queue, thread_list) {
        if (t->is_real_time && t->period != -1 && t->current_deadline < earliest_deadline) {
            earliest_deadline = t->current_deadline;
            earliest_deadline_thread = t;
        } else if (t->is_real_time && t->period != -1 && t->current_deadline == earliest_deadline && t->ID < earliest_deadline_thread->ID) {
            earliest_deadline_thread = t;  // Tie-breaking by ID
        }
    }

    if (earliest_deadline_thread) {
        int time_to_deadline = earliest_deadline_thread->current_deadline - args.current_time;
        if (earliest_deadline_thread->remaining_time > time_to_deadline) {
            // The real-time thread cannot complete before its deadline, so handle the deadline miss
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
            r.allocated_time = 0; // Could set to minimal quantum to allow cleanup or logging
        } else {
            // Schedule the real-time thread normally if it hasn't missed its deadline
            int time_slice = (time_to_deadline < earliest_deadline_thread->remaining_time) ? time_to_deadline : earliest_deadline_thread->remaining_time;
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
            r.allocated_time = time_slice;
        }
    } else {
        // If no real-time threads with a deadline are ready, find the thread with the smallest ID
        struct thread *smallest_id_thread = NULL;
        list_for_each_entry(t, args.run_queue, thread_list) {
            if (smallest_id_thread == NULL || t->ID < smallest_id_thread->ID) {
                smallest_id_thread = t;
            }
        }

        if (smallest_id_thread) {
            r.scheduled_thread_list_member = &smallest_id_thread->thread_list;
            r.allocated_time = smallest_id_thread->remaining_time;
        } else {
            // If no thread is ready, perhaps idle or find the next release time
            r.scheduled_thread_list_member = args.run_queue;
            r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
        }
    }

    return r;
}
