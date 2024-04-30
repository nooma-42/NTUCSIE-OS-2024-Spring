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
    candidate = list_entry(args.run_queue, struct thread, thread_list); // 
    if (!last_thread && candidate->remaining_time > 0)
        selected_thread = candidate;
    else
        list_for_each_entry(candidate, args.run_queue, thread_list) {
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

/* Shortest-Job-First Scheduling */
int find_next_release_time(struct list_head *release_queue, int current_time) {
    struct release_queue_entry *next_release = NULL;
    int next_release_time = INT_MAX;

    list_for_each_entry(next_release, release_queue, thread_list) {
        if (next_release->release_time > current_time &&
            next_release->release_time < next_release_time) {
            next_release_time = next_release->release_time;
        }
    }

    if (next_release_time == INT_MAX)
        return -1; // No threads in the release queue

    return next_release_time - current_time;
}


struct threads_sched_result schedule_sjf(struct threads_sched_args args)
{
    struct threads_sched_result r;
    // TODO: implement the shortest-job-first scheduling algorithm
    struct thread *shortest_job = NULL;
    struct thread *t;
    int shortest_time = INT_MAX;

    // Find the thread with the shortest remaining time that is ready to run
    list_for_each_entry(t, args.run_queue, thread_list) {
        if (t->remaining_time < shortest_time) {
            shortest_time = t->remaining_time;
            shortest_job = t;
        }
    }

    if (shortest_job) {
        r.scheduled_thread_list_member = &shortest_job->thread_list;
        r.allocated_time = shortest_job->remaining_time;  // Allow the thread to run to completion
    } else {
        // If no threads are ready, find the next release time or idle
        r.scheduled_thread_list_member = args.run_queue;
        r.allocated_time = 1;  // Default minimal quantum if unsure
    }
    return r;
}

/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args)
{
    struct threads_sched_result r;
    // TODO: implement the least-slack-time scheduling algorithm
    struct thread *min_slack = NULL;
    int min_slack_time = INT_MAX;
    struct thread *t;

    // Find the thread with the minimum slack time
    list_for_each_entry(t, args.run_queue, thread_list) {
        int slack_time = t->deadline - args.current_time - t->remaining_time;
        if (min_slack == NULL || slack_time < min_slack_time ||
            (slack_time == min_slack_time && t->ID < min_slack->ID)) {
            min_slack = t;
            min_slack_time = slack_time;
        }
    }

    if (min_slack) {
        r.scheduled_thread_list_member = &min_slack->thread_list;
        r.allocated_time = min_slack->remaining_time;
    } else {
        r.scheduled_thread_list_member = args.run_queue;
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
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
