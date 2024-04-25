
user/_threads:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <__list_add>:
 * the prev/next entries already!
 */
static inline void __list_add(struct list_head *new_entry,
                              struct list_head *prev,
                              struct list_head *next)
{
       0:	7179                	addi	sp,sp,-48
       2:	f422                	sd	s0,40(sp)
       4:	1800                	addi	s0,sp,48
       6:	fea43423          	sd	a0,-24(s0)
       a:	feb43023          	sd	a1,-32(s0)
       e:	fcc43c23          	sd	a2,-40(s0)
    next->prev = new_entry;
      12:	fd843783          	ld	a5,-40(s0)
      16:	fe843703          	ld	a4,-24(s0)
      1a:	e798                	sd	a4,8(a5)
    new_entry->next = next;
      1c:	fe843783          	ld	a5,-24(s0)
      20:	fd843703          	ld	a4,-40(s0)
      24:	e398                	sd	a4,0(a5)
    new_entry->prev = prev;
      26:	fe843783          	ld	a5,-24(s0)
      2a:	fe043703          	ld	a4,-32(s0)
      2e:	e798                	sd	a4,8(a5)
    prev->next = new_entry;
      30:	fe043783          	ld	a5,-32(s0)
      34:	fe843703          	ld	a4,-24(s0)
      38:	e398                	sd	a4,0(a5)
}
      3a:	0001                	nop
      3c:	7422                	ld	s0,40(sp)
      3e:	6145                	addi	sp,sp,48
      40:	8082                	ret

0000000000000042 <list_add_tail>:
 *
 * Insert a new entry before the specified head.
 * This is useful for implementing queues.
 */
static inline void list_add_tail(struct list_head *new_entry, struct list_head *head)
{
      42:	1101                	addi	sp,sp,-32
      44:	ec06                	sd	ra,24(sp)
      46:	e822                	sd	s0,16(sp)
      48:	1000                	addi	s0,sp,32
      4a:	fea43423          	sd	a0,-24(s0)
      4e:	feb43023          	sd	a1,-32(s0)
    __list_add(new_entry, head->prev, head);
      52:	fe043783          	ld	a5,-32(s0)
      56:	679c                	ld	a5,8(a5)
      58:	fe043603          	ld	a2,-32(s0)
      5c:	85be                	mv	a1,a5
      5e:	fe843503          	ld	a0,-24(s0)
      62:	00000097          	auipc	ra,0x0
      66:	f9e080e7          	jalr	-98(ra) # 0 <__list_add>
}
      6a:	0001                	nop
      6c:	60e2                	ld	ra,24(sp)
      6e:	6442                	ld	s0,16(sp)
      70:	6105                	addi	sp,sp,32
      72:	8082                	ret

0000000000000074 <__list_del>:
 *
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 */
static inline void __list_del(struct list_head *prev, struct list_head *next)
{
      74:	1101                	addi	sp,sp,-32
      76:	ec22                	sd	s0,24(sp)
      78:	1000                	addi	s0,sp,32
      7a:	fea43423          	sd	a0,-24(s0)
      7e:	feb43023          	sd	a1,-32(s0)
    next->prev = prev;
      82:	fe043783          	ld	a5,-32(s0)
      86:	fe843703          	ld	a4,-24(s0)
      8a:	e798                	sd	a4,8(a5)
    prev->next = next;
      8c:	fe843783          	ld	a5,-24(s0)
      90:	fe043703          	ld	a4,-32(s0)
      94:	e398                	sd	a4,0(a5)
}
      96:	0001                	nop
      98:	6462                	ld	s0,24(sp)
      9a:	6105                	addi	sp,sp,32
      9c:	8082                	ret

000000000000009e <list_del>:
 * @entry: the element to delete from the list.
 * Note: list_empty on entry does not return true after this, the entry is
 * in an undefined state.
 */
static inline void list_del(struct list_head *entry)
{
      9e:	1101                	addi	sp,sp,-32
      a0:	ec06                	sd	ra,24(sp)
      a2:	e822                	sd	s0,16(sp)
      a4:	1000                	addi	s0,sp,32
      a6:	fea43423          	sd	a0,-24(s0)
    __list_del(entry->prev, entry->next);
      aa:	fe843783          	ld	a5,-24(s0)
      ae:	6798                	ld	a4,8(a5)
      b0:	fe843783          	ld	a5,-24(s0)
      b4:	639c                	ld	a5,0(a5)
      b6:	85be                	mv	a1,a5
      b8:	853a                	mv	a0,a4
      ba:	00000097          	auipc	ra,0x0
      be:	fba080e7          	jalr	-70(ra) # 74 <__list_del>
    entry->next = LIST_POISON1;
      c2:	fe843783          	ld	a5,-24(s0)
      c6:	00100737          	lui	a4,0x100
      ca:	10070713          	addi	a4,a4,256 # 100100 <__global_pointer$+0xfd7a8>
      ce:	e398                	sd	a4,0(a5)
    entry->prev = LIST_POISON2;
      d0:	fe843783          	ld	a5,-24(s0)
      d4:	00200737          	lui	a4,0x200
      d8:	20070713          	addi	a4,a4,512 # 200200 <__global_pointer$+0x1fd8a8>
      dc:	e798                	sd	a4,8(a5)
}
      de:	0001                	nop
      e0:	60e2                	ld	ra,24(sp)
      e2:	6442                	ld	s0,16(sp)
      e4:	6105                	addi	sp,sp,32
      e6:	8082                	ret

00000000000000e8 <list_empty>:
/**
 * list_empty - tests whether a list is empty
 * @head: the list to test.
 */
static inline int list_empty(const struct list_head *head)
{
      e8:	1101                	addi	sp,sp,-32
      ea:	ec22                	sd	s0,24(sp)
      ec:	1000                	addi	s0,sp,32
      ee:	fea43423          	sd	a0,-24(s0)
    return head->next == head;
      f2:	fe843783          	ld	a5,-24(s0)
      f6:	639c                	ld	a5,0(a5)
      f8:	fe843703          	ld	a4,-24(s0)
      fc:	40f707b3          	sub	a5,a4,a5
     100:	0017b793          	seqz	a5,a5
     104:	0ff7f793          	andi	a5,a5,255
     108:	2781                	sext.w	a5,a5
}
     10a:	853e                	mv	a0,a5
     10c:	6462                	ld	s0,24(sp)
     10e:	6105                	addi	sp,sp,32
     110:	8082                	ret

0000000000000112 <thread_create>:

void __dispatch(void);
void __schedule(void);

struct thread *thread_create(void (*f)(void *), void *arg, int is_real_time, int processing_time, int period, int n)
{
     112:	715d                	addi	sp,sp,-80
     114:	e486                	sd	ra,72(sp)
     116:	e0a2                	sd	s0,64(sp)
     118:	0880                	addi	s0,sp,80
     11a:	fca43423          	sd	a0,-56(s0)
     11e:	fcb43023          	sd	a1,-64(s0)
     122:	85b2                	mv	a1,a2
     124:	8636                	mv	a2,a3
     126:	86ba                	mv	a3,a4
     128:	873e                	mv	a4,a5
     12a:	87ae                	mv	a5,a1
     12c:	faf42e23          	sw	a5,-68(s0)
     130:	87b2                	mv	a5,a2
     132:	faf42c23          	sw	a5,-72(s0)
     136:	87b6                	mv	a5,a3
     138:	faf42a23          	sw	a5,-76(s0)
     13c:	87ba                	mv	a5,a4
     13e:	faf42823          	sw	a5,-80(s0)
    static int _id = 1;
    struct thread *t = (struct thread *)malloc(sizeof(struct thread));
     142:	06000513          	li	a0,96
     146:	00001097          	auipc	ra,0x1
     14a:	620080e7          	jalr	1568(ra) # 1766 <malloc>
     14e:	fea43423          	sd	a0,-24(s0)
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long)malloc(sizeof(unsigned long) * 0x200);
     152:	6505                	lui	a0,0x1
     154:	00001097          	auipc	ra,0x1
     158:	612080e7          	jalr	1554(ra) # 1766 <malloc>
     15c:	87aa                	mv	a5,a0
     15e:	fef43023          	sd	a5,-32(s0)
    new_stack_p = new_stack + 0x200 * 8 - 0x2 * 8;
     162:	fe043703          	ld	a4,-32(s0)
     166:	6785                	lui	a5,0x1
     168:	17c1                	addi	a5,a5,-16
     16a:	97ba                	add	a5,a5,a4
     16c:	fcf43c23          	sd	a5,-40(s0)
    t->fp = f;
     170:	fe843783          	ld	a5,-24(s0)
     174:	fc843703          	ld	a4,-56(s0)
     178:	e398                	sd	a4,0(a5)
    t->arg = arg;
     17a:	fe843783          	ld	a5,-24(s0)
     17e:	fc043703          	ld	a4,-64(s0)
     182:	e798                	sd	a4,8(a5)
    t->ID = _id++;
     184:	00002797          	auipc	a5,0x2
     188:	00c78793          	addi	a5,a5,12 # 2190 <_id.1229>
     18c:	439c                	lw	a5,0(a5)
     18e:	0017871b          	addiw	a4,a5,1
     192:	0007069b          	sext.w	a3,a4
     196:	00002717          	auipc	a4,0x2
     19a:	ffa70713          	addi	a4,a4,-6 # 2190 <_id.1229>
     19e:	c314                	sw	a3,0(a4)
     1a0:	fe843703          	ld	a4,-24(s0)
     1a4:	df5c                	sw	a5,60(a4)
    t->buf_set = 0;
     1a6:	fe843783          	ld	a5,-24(s0)
     1aa:	0207a023          	sw	zero,32(a5)
    t->stack = (void *)new_stack;
     1ae:	fe043703          	ld	a4,-32(s0)
     1b2:	fe843783          	ld	a5,-24(s0)
     1b6:	eb98                	sd	a4,16(a5)
    t->stack_p = (void *)new_stack_p;
     1b8:	fd843703          	ld	a4,-40(s0)
     1bc:	fe843783          	ld	a5,-24(s0)
     1c0:	ef98                	sd	a4,24(a5)

    t->processing_time = processing_time;
     1c2:	fe843783          	ld	a5,-24(s0)
     1c6:	fb842703          	lw	a4,-72(s0)
     1ca:	c3f8                	sw	a4,68(a5)
    t->period = period;
     1cc:	fe843783          	ld	a5,-24(s0)
     1d0:	fb442703          	lw	a4,-76(s0)
     1d4:	cbb8                	sw	a4,80(a5)
    t->deadline = period;
     1d6:	fe843783          	ld	a5,-24(s0)
     1da:	fb442703          	lw	a4,-76(s0)
     1de:	c7f8                	sw	a4,76(a5)
    t->n = n;
     1e0:	fe843783          	ld	a5,-24(s0)
     1e4:	fb042703          	lw	a4,-80(s0)
     1e8:	cbf8                	sw	a4,84(a5)
    t->is_real_time = is_real_time;
     1ea:	fe843783          	ld	a5,-24(s0)
     1ee:	fbc42703          	lw	a4,-68(s0)
     1f2:	c3b8                	sw	a4,64(a5)
    t->weight = 1;
     1f4:	fe843783          	ld	a5,-24(s0)
     1f8:	4705                	li	a4,1
     1fa:	c7b8                	sw	a4,72(a5)
    t->remaining_time = processing_time;
     1fc:	fe843783          	ld	a5,-24(s0)
     200:	fb842703          	lw	a4,-72(s0)
     204:	cfb8                	sw	a4,88(a5)
    t->current_deadline = 0;
     206:	fe843783          	ld	a5,-24(s0)
     20a:	0407ae23          	sw	zero,92(a5)
    return t;
     20e:	fe843783          	ld	a5,-24(s0)
}
     212:	853e                	mv	a0,a5
     214:	60a6                	ld	ra,72(sp)
     216:	6406                	ld	s0,64(sp)
     218:	6161                	addi	sp,sp,80
     21a:	8082                	ret

000000000000021c <thread_set_weight>:

void thread_set_weight(struct thread *t, int weight)
{
     21c:	1101                	addi	sp,sp,-32
     21e:	ec22                	sd	s0,24(sp)
     220:	1000                	addi	s0,sp,32
     222:	fea43423          	sd	a0,-24(s0)
     226:	87ae                	mv	a5,a1
     228:	fef42223          	sw	a5,-28(s0)
    t->weight = weight;
     22c:	fe843783          	ld	a5,-24(s0)
     230:	fe442703          	lw	a4,-28(s0)
     234:	c7b8                	sw	a4,72(a5)
}
     236:	0001                	nop
     238:	6462                	ld	s0,24(sp)
     23a:	6105                	addi	sp,sp,32
     23c:	8082                	ret

000000000000023e <thread_add_at>:

void thread_add_at(struct thread *t, int arrival_time)
{
     23e:	7179                	addi	sp,sp,-48
     240:	f406                	sd	ra,40(sp)
     242:	f022                	sd	s0,32(sp)
     244:	1800                	addi	s0,sp,48
     246:	fca43c23          	sd	a0,-40(s0)
     24a:	87ae                	mv	a5,a1
     24c:	fcf42a23          	sw	a5,-44(s0)
    struct release_queue_entry *new_entry = (struct release_queue_entry *)malloc(sizeof(struct release_queue_entry));
     250:	02000513          	li	a0,32
     254:	00001097          	auipc	ra,0x1
     258:	512080e7          	jalr	1298(ra) # 1766 <malloc>
     25c:	fea43423          	sd	a0,-24(s0)
    new_entry->thrd = t;
     260:	fe843783          	ld	a5,-24(s0)
     264:	fd843703          	ld	a4,-40(s0)
     268:	e398                	sd	a4,0(a5)
    new_entry->release_time = arrival_time;
     26a:	fe843783          	ld	a5,-24(s0)
     26e:	fd442703          	lw	a4,-44(s0)
     272:	cf98                	sw	a4,24(a5)
    if (t->is_real_time) {
     274:	fd843783          	ld	a5,-40(s0)
     278:	43bc                	lw	a5,64(a5)
     27a:	c38d                	beqz	a5,29c <thread_add_at+0x5e>
        t->current_deadline = arrival_time;
     27c:	fd843783          	ld	a5,-40(s0)
     280:	fd442703          	lw	a4,-44(s0)
     284:	cff8                	sw	a4,92(a5)
        t->current_deadline = arrival_time + t->deadline;
     286:	fd843783          	ld	a5,-40(s0)
     28a:	47fc                	lw	a5,76(a5)
     28c:	fd442703          	lw	a4,-44(s0)
     290:	9fb9                	addw	a5,a5,a4
     292:	0007871b          	sext.w	a4,a5
     296:	fd843783          	ld	a5,-40(s0)
     29a:	cff8                	sw	a4,92(a5)
    }
    list_add_tail(&new_entry->thread_list, &release_queue);
     29c:	fe843783          	ld	a5,-24(s0)
     2a0:	07a1                	addi	a5,a5,8
     2a2:	00002597          	auipc	a1,0x2
     2a6:	ec658593          	addi	a1,a1,-314 # 2168 <release_queue>
     2aa:	853e                	mv	a0,a5
     2ac:	00000097          	auipc	ra,0x0
     2b0:	d96080e7          	jalr	-618(ra) # 42 <list_add_tail>
}
     2b4:	0001                	nop
     2b6:	70a2                	ld	ra,40(sp)
     2b8:	7402                	ld	s0,32(sp)
     2ba:	6145                	addi	sp,sp,48
     2bc:	8082                	ret

00000000000002be <__release>:

void __release()
{
     2be:	7139                	addi	sp,sp,-64
     2c0:	fc06                	sd	ra,56(sp)
     2c2:	f822                	sd	s0,48(sp)
     2c4:	0080                	addi	s0,sp,64
    struct release_queue_entry *cur, *nxt;
    list_for_each_entry_safe(cur, nxt, &release_queue, thread_list) {
     2c6:	00002797          	auipc	a5,0x2
     2ca:	ea278793          	addi	a5,a5,-350 # 2168 <release_queue>
     2ce:	639c                	ld	a5,0(a5)
     2d0:	fcf43c23          	sd	a5,-40(s0)
     2d4:	fd843783          	ld	a5,-40(s0)
     2d8:	17e1                	addi	a5,a5,-8
     2da:	fef43423          	sd	a5,-24(s0)
     2de:	fe843783          	ld	a5,-24(s0)
     2e2:	679c                	ld	a5,8(a5)
     2e4:	fcf43823          	sd	a5,-48(s0)
     2e8:	fd043783          	ld	a5,-48(s0)
     2ec:	17e1                	addi	a5,a5,-8
     2ee:	fef43023          	sd	a5,-32(s0)
     2f2:	a851                	j	386 <__release+0xc8>
        if (threading_system_time >= cur->release_time) {
     2f4:	fe843783          	ld	a5,-24(s0)
     2f8:	4f98                	lw	a4,24(a5)
     2fa:	00002797          	auipc	a5,0x2
     2fe:	ea678793          	addi	a5,a5,-346 # 21a0 <threading_system_time>
     302:	439c                	lw	a5,0(a5)
     304:	06e7c363          	blt	a5,a4,36a <__release+0xac>
            cur->thrd->remaining_time = cur->thrd->processing_time;
     308:	fe843783          	ld	a5,-24(s0)
     30c:	6398                	ld	a4,0(a5)
     30e:	fe843783          	ld	a5,-24(s0)
     312:	639c                	ld	a5,0(a5)
     314:	4378                	lw	a4,68(a4)
     316:	cfb8                	sw	a4,88(a5)
            cur->thrd->current_deadline = cur->release_time + cur->thrd->deadline;
     318:	fe843783          	ld	a5,-24(s0)
     31c:	4f94                	lw	a3,24(a5)
     31e:	fe843783          	ld	a5,-24(s0)
     322:	639c                	ld	a5,0(a5)
     324:	47f8                	lw	a4,76(a5)
     326:	fe843783          	ld	a5,-24(s0)
     32a:	639c                	ld	a5,0(a5)
     32c:	9f35                	addw	a4,a4,a3
     32e:	2701                	sext.w	a4,a4
     330:	cff8                	sw	a4,92(a5)
            list_add_tail(&cur->thrd->thread_list, &run_queue);
     332:	fe843783          	ld	a5,-24(s0)
     336:	639c                	ld	a5,0(a5)
     338:	02878793          	addi	a5,a5,40
     33c:	00002597          	auipc	a1,0x2
     340:	e1c58593          	addi	a1,a1,-484 # 2158 <run_queue>
     344:	853e                	mv	a0,a5
     346:	00000097          	auipc	ra,0x0
     34a:	cfc080e7          	jalr	-772(ra) # 42 <list_add_tail>
            list_del(&cur->thread_list);
     34e:	fe843783          	ld	a5,-24(s0)
     352:	07a1                	addi	a5,a5,8
     354:	853e                	mv	a0,a5
     356:	00000097          	auipc	ra,0x0
     35a:	d48080e7          	jalr	-696(ra) # 9e <list_del>
            free(cur);
     35e:	fe843503          	ld	a0,-24(s0)
     362:	00001097          	auipc	ra,0x1
     366:	262080e7          	jalr	610(ra) # 15c4 <free>
    list_for_each_entry_safe(cur, nxt, &release_queue, thread_list) {
     36a:	fe043783          	ld	a5,-32(s0)
     36e:	fef43423          	sd	a5,-24(s0)
     372:	fe043783          	ld	a5,-32(s0)
     376:	679c                	ld	a5,8(a5)
     378:	fcf43423          	sd	a5,-56(s0)
     37c:	fc843783          	ld	a5,-56(s0)
     380:	17e1                	addi	a5,a5,-8
     382:	fef43023          	sd	a5,-32(s0)
     386:	fe843783          	ld	a5,-24(s0)
     38a:	00878713          	addi	a4,a5,8
     38e:	00002797          	auipc	a5,0x2
     392:	dda78793          	addi	a5,a5,-550 # 2168 <release_queue>
     396:	f4f71fe3          	bne	a4,a5,2f4 <__release+0x36>
        }
    }
}
     39a:	0001                	nop
     39c:	0001                	nop
     39e:	70e2                	ld	ra,56(sp)
     3a0:	7442                	ld	s0,48(sp)
     3a2:	6121                	addi	sp,sp,64
     3a4:	8082                	ret

00000000000003a6 <__thread_exit>:

void __thread_exit(struct thread *to_remove)
{
     3a6:	1101                	addi	sp,sp,-32
     3a8:	ec06                	sd	ra,24(sp)
     3aa:	e822                	sd	s0,16(sp)
     3ac:	1000                	addi	s0,sp,32
     3ae:	fea43423          	sd	a0,-24(s0)
    current = to_remove->thread_list.prev;
     3b2:	fe843783          	ld	a5,-24(s0)
     3b6:	7b98                	ld	a4,48(a5)
     3b8:	00002797          	auipc	a5,0x2
     3bc:	de078793          	addi	a5,a5,-544 # 2198 <current>
     3c0:	e398                	sd	a4,0(a5)
    list_del(&to_remove->thread_list);
     3c2:	fe843783          	ld	a5,-24(s0)
     3c6:	02878793          	addi	a5,a5,40
     3ca:	853e                	mv	a0,a5
     3cc:	00000097          	auipc	ra,0x0
     3d0:	cd2080e7          	jalr	-814(ra) # 9e <list_del>

    free(to_remove->stack);
     3d4:	fe843783          	ld	a5,-24(s0)
     3d8:	6b9c                	ld	a5,16(a5)
     3da:	853e                	mv	a0,a5
     3dc:	00001097          	auipc	ra,0x1
     3e0:	1e8080e7          	jalr	488(ra) # 15c4 <free>
    free(to_remove);
     3e4:	fe843503          	ld	a0,-24(s0)
     3e8:	00001097          	auipc	ra,0x1
     3ec:	1dc080e7          	jalr	476(ra) # 15c4 <free>

    __schedule();
     3f0:	00000097          	auipc	ra,0x0
     3f4:	572080e7          	jalr	1394(ra) # 962 <__schedule>
    __dispatch();
     3f8:	00000097          	auipc	ra,0x0
     3fc:	3da080e7          	jalr	986(ra) # 7d2 <__dispatch>
    thrdresume(main_thrd_id);
     400:	00002797          	auipc	a5,0x2
     404:	d8c78793          	addi	a5,a5,-628 # 218c <main_thrd_id>
     408:	439c                	lw	a5,0(a5)
     40a:	853e                	mv	a0,a5
     40c:	00001097          	auipc	ra,0x1
     410:	cca080e7          	jalr	-822(ra) # 10d6 <thrdresume>
}
     414:	0001                	nop
     416:	60e2                	ld	ra,24(sp)
     418:	6442                	ld	s0,16(sp)
     41a:	6105                	addi	sp,sp,32
     41c:	8082                	ret

000000000000041e <thread_exit>:

void thread_exit(void)
{
     41e:	7179                	addi	sp,sp,-48
     420:	f406                	sd	ra,40(sp)
     422:	f022                	sd	s0,32(sp)
     424:	1800                	addi	s0,sp,48
    if (current == &run_queue) {
     426:	00002797          	auipc	a5,0x2
     42a:	d7278793          	addi	a5,a5,-654 # 2198 <current>
     42e:	6398                	ld	a4,0(a5)
     430:	00002797          	auipc	a5,0x2
     434:	d2878793          	addi	a5,a5,-728 # 2158 <run_queue>
     438:	02f71063          	bne	a4,a5,458 <thread_exit+0x3a>
        fprintf(2, "[FATAL] thread_exit is called on a nonexistent thread\n");
     43c:	00002597          	auipc	a1,0x2
     440:	bd458593          	addi	a1,a1,-1068 # 2010 <schedule_dm+0x20c>
     444:	4509                	li	a0,2
     446:	00001097          	auipc	ra,0x1
     44a:	0d6080e7          	jalr	214(ra) # 151c <fprintf>
        exit(1);
     44e:	4505                	li	a0,1
     450:	00001097          	auipc	ra,0x1
     454:	bde080e7          	jalr	-1058(ra) # 102e <exit>
    }

    struct thread *to_remove = list_entry(current, struct thread, thread_list);
     458:	00002797          	auipc	a5,0x2
     45c:	d4078793          	addi	a5,a5,-704 # 2198 <current>
     460:	639c                	ld	a5,0(a5)
     462:	fef43423          	sd	a5,-24(s0)
     466:	fe843783          	ld	a5,-24(s0)
     46a:	fd878793          	addi	a5,a5,-40
     46e:	fef43023          	sd	a5,-32(s0)
    int consume_ticks = cancelthrdstop(to_remove->thrdstop_context_id, 1);
     472:	fe043783          	ld	a5,-32(s0)
     476:	5f9c                	lw	a5,56(a5)
     478:	4585                	li	a1,1
     47a:	853e                	mv	a0,a5
     47c:	00001097          	auipc	ra,0x1
     480:	c62080e7          	jalr	-926(ra) # 10de <cancelthrdstop>
     484:	87aa                	mv	a5,a0
     486:	fcf42e23          	sw	a5,-36(s0)
    threading_system_time += consume_ticks;
     48a:	00002797          	auipc	a5,0x2
     48e:	d1678793          	addi	a5,a5,-746 # 21a0 <threading_system_time>
     492:	439c                	lw	a5,0(a5)
     494:	fdc42703          	lw	a4,-36(s0)
     498:	9fb9                	addw	a5,a5,a4
     49a:	0007871b          	sext.w	a4,a5
     49e:	00002797          	auipc	a5,0x2
     4a2:	d0278793          	addi	a5,a5,-766 # 21a0 <threading_system_time>
     4a6:	c398                	sw	a4,0(a5)

    __release();
     4a8:	00000097          	auipc	ra,0x0
     4ac:	e16080e7          	jalr	-490(ra) # 2be <__release>
    __thread_exit(to_remove);
     4b0:	fe043503          	ld	a0,-32(s0)
     4b4:	00000097          	auipc	ra,0x0
     4b8:	ef2080e7          	jalr	-270(ra) # 3a6 <__thread_exit>
}
     4bc:	0001                	nop
     4be:	70a2                	ld	ra,40(sp)
     4c0:	7402                	ld	s0,32(sp)
     4c2:	6145                	addi	sp,sp,48
     4c4:	8082                	ret

00000000000004c6 <__finish_current>:

void __finish_current()
{
     4c6:	7179                	addi	sp,sp,-48
     4c8:	f406                	sd	ra,40(sp)
     4ca:	f022                	sd	s0,32(sp)
     4cc:	1800                	addi	s0,sp,48
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
     4ce:	00002797          	auipc	a5,0x2
     4d2:	cca78793          	addi	a5,a5,-822 # 2198 <current>
     4d6:	639c                	ld	a5,0(a5)
     4d8:	fef43423          	sd	a5,-24(s0)
     4dc:	fe843783          	ld	a5,-24(s0)
     4e0:	fd878793          	addi	a5,a5,-40
     4e4:	fef43023          	sd	a5,-32(s0)
    --current_thread->n;
     4e8:	fe043783          	ld	a5,-32(s0)
     4ec:	4bfc                	lw	a5,84(a5)
     4ee:	37fd                	addiw	a5,a5,-1
     4f0:	0007871b          	sext.w	a4,a5
     4f4:	fe043783          	ld	a5,-32(s0)
     4f8:	cbf8                	sw	a4,84(a5)

    printf("thread#%d finish at %d\n",
     4fa:	fe043783          	ld	a5,-32(s0)
     4fe:	5fd8                	lw	a4,60(a5)
     500:	00002797          	auipc	a5,0x2
     504:	ca078793          	addi	a5,a5,-864 # 21a0 <threading_system_time>
     508:	4390                	lw	a2,0(a5)
     50a:	fe043783          	ld	a5,-32(s0)
     50e:	4bfc                	lw	a5,84(a5)
     510:	86be                	mv	a3,a5
     512:	85ba                	mv	a1,a4
     514:	00002517          	auipc	a0,0x2
     518:	b3450513          	addi	a0,a0,-1228 # 2048 <schedule_dm+0x244>
     51c:	00001097          	auipc	ra,0x1
     520:	058080e7          	jalr	88(ra) # 1574 <printf>
           current_thread->ID, threading_system_time, current_thread->n);

    if (current_thread->n > 0) {
     524:	fe043783          	ld	a5,-32(s0)
     528:	4bfc                	lw	a5,84(a5)
     52a:	04f05563          	blez	a5,574 <__finish_current+0xae>
        struct list_head *to_remove = current;
     52e:	00002797          	auipc	a5,0x2
     532:	c6a78793          	addi	a5,a5,-918 # 2198 <current>
     536:	639c                	ld	a5,0(a5)
     538:	fcf43c23          	sd	a5,-40(s0)
        current = current->prev;
     53c:	00002797          	auipc	a5,0x2
     540:	c5c78793          	addi	a5,a5,-932 # 2198 <current>
     544:	639c                	ld	a5,0(a5)
     546:	6798                	ld	a4,8(a5)
     548:	00002797          	auipc	a5,0x2
     54c:	c5078793          	addi	a5,a5,-944 # 2198 <current>
     550:	e398                	sd	a4,0(a5)
        list_del(to_remove);
     552:	fd843503          	ld	a0,-40(s0)
     556:	00000097          	auipc	ra,0x0
     55a:	b48080e7          	jalr	-1208(ra) # 9e <list_del>
        thread_add_at(current_thread, current_thread->current_deadline);
     55e:	fe043783          	ld	a5,-32(s0)
     562:	4ffc                	lw	a5,92(a5)
     564:	85be                	mv	a1,a5
     566:	fe043503          	ld	a0,-32(s0)
     56a:	00000097          	auipc	ra,0x0
     56e:	cd4080e7          	jalr	-812(ra) # 23e <thread_add_at>
    } else {
        __thread_exit(current_thread);
    }
}
     572:	a039                	j	580 <__finish_current+0xba>
        __thread_exit(current_thread);
     574:	fe043503          	ld	a0,-32(s0)
     578:	00000097          	auipc	ra,0x0
     57c:	e2e080e7          	jalr	-466(ra) # 3a6 <__thread_exit>
}
     580:	0001                	nop
     582:	70a2                	ld	ra,40(sp)
     584:	7402                	ld	s0,32(sp)
     586:	6145                	addi	sp,sp,48
     588:	8082                	ret

000000000000058a <__rt_finish_current>:
void __rt_finish_current()
{
     58a:	7179                	addi	sp,sp,-48
     58c:	f406                	sd	ra,40(sp)
     58e:	f022                	sd	s0,32(sp)
     590:	1800                	addi	s0,sp,48
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
     592:	00002797          	auipc	a5,0x2
     596:	c0678793          	addi	a5,a5,-1018 # 2198 <current>
     59a:	639c                	ld	a5,0(a5)
     59c:	fef43423          	sd	a5,-24(s0)
     5a0:	fe843783          	ld	a5,-24(s0)
     5a4:	fd878793          	addi	a5,a5,-40
     5a8:	fef43023          	sd	a5,-32(s0)
    --current_thread->n;
     5ac:	fe043783          	ld	a5,-32(s0)
     5b0:	4bfc                	lw	a5,84(a5)
     5b2:	37fd                	addiw	a5,a5,-1
     5b4:	0007871b          	sext.w	a4,a5
     5b8:	fe043783          	ld	a5,-32(s0)
     5bc:	cbf8                	sw	a4,84(a5)

    printf("thread#%d finish one cycle at %d: %d cycles left\n",
     5be:	fe043783          	ld	a5,-32(s0)
     5c2:	5fd8                	lw	a4,60(a5)
     5c4:	00002797          	auipc	a5,0x2
     5c8:	bdc78793          	addi	a5,a5,-1060 # 21a0 <threading_system_time>
     5cc:	4390                	lw	a2,0(a5)
     5ce:	fe043783          	ld	a5,-32(s0)
     5d2:	4bfc                	lw	a5,84(a5)
     5d4:	86be                	mv	a3,a5
     5d6:	85ba                	mv	a1,a4
     5d8:	00002517          	auipc	a0,0x2
     5dc:	a8850513          	addi	a0,a0,-1400 # 2060 <schedule_dm+0x25c>
     5e0:	00001097          	auipc	ra,0x1
     5e4:	f94080e7          	jalr	-108(ra) # 1574 <printf>
           current_thread->ID, threading_system_time, current_thread->n);

    if (current_thread->n > 0) {
     5e8:	fe043783          	ld	a5,-32(s0)
     5ec:	4bfc                	lw	a5,84(a5)
     5ee:	04f05563          	blez	a5,638 <__rt_finish_current+0xae>
        struct list_head *to_remove = current;
     5f2:	00002797          	auipc	a5,0x2
     5f6:	ba678793          	addi	a5,a5,-1114 # 2198 <current>
     5fa:	639c                	ld	a5,0(a5)
     5fc:	fcf43c23          	sd	a5,-40(s0)
        current = current->prev;
     600:	00002797          	auipc	a5,0x2
     604:	b9878793          	addi	a5,a5,-1128 # 2198 <current>
     608:	639c                	ld	a5,0(a5)
     60a:	6798                	ld	a4,8(a5)
     60c:	00002797          	auipc	a5,0x2
     610:	b8c78793          	addi	a5,a5,-1140 # 2198 <current>
     614:	e398                	sd	a4,0(a5)
        list_del(to_remove);
     616:	fd843503          	ld	a0,-40(s0)
     61a:	00000097          	auipc	ra,0x0
     61e:	a84080e7          	jalr	-1404(ra) # 9e <list_del>
        thread_add_at(current_thread, current_thread->current_deadline);
     622:	fe043783          	ld	a5,-32(s0)
     626:	4ffc                	lw	a5,92(a5)
     628:	85be                	mv	a1,a5
     62a:	fe043503          	ld	a0,-32(s0)
     62e:	00000097          	auipc	ra,0x0
     632:	c10080e7          	jalr	-1008(ra) # 23e <thread_add_at>
    } else {
        __thread_exit(current_thread);
    }
}
     636:	a039                	j	644 <__rt_finish_current+0xba>
        __thread_exit(current_thread);
     638:	fe043503          	ld	a0,-32(s0)
     63c:	00000097          	auipc	ra,0x0
     640:	d6a080e7          	jalr	-662(ra) # 3a6 <__thread_exit>
}
     644:	0001                	nop
     646:	70a2                	ld	ra,40(sp)
     648:	7402                	ld	s0,32(sp)
     64a:	6145                	addi	sp,sp,48
     64c:	8082                	ret

000000000000064e <switch_handler>:

void switch_handler(void *arg)
{
     64e:	7139                	addi	sp,sp,-64
     650:	fc06                	sd	ra,56(sp)
     652:	f822                	sd	s0,48(sp)
     654:	0080                	addi	s0,sp,64
     656:	fca43423          	sd	a0,-56(s0)
    uint64 elapsed_time = (uint64)arg;
     65a:	fc843783          	ld	a5,-56(s0)
     65e:	fef43423          	sd	a5,-24(s0)
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
     662:	00002797          	auipc	a5,0x2
     666:	b3678793          	addi	a5,a5,-1226 # 2198 <current>
     66a:	639c                	ld	a5,0(a5)
     66c:	fef43023          	sd	a5,-32(s0)
     670:	fe043783          	ld	a5,-32(s0)
     674:	fd878793          	addi	a5,a5,-40
     678:	fcf43c23          	sd	a5,-40(s0)

    threading_system_time += elapsed_time;
     67c:	fe843783          	ld	a5,-24(s0)
     680:	0007871b          	sext.w	a4,a5
     684:	00002797          	auipc	a5,0x2
     688:	b1c78793          	addi	a5,a5,-1252 # 21a0 <threading_system_time>
     68c:	439c                	lw	a5,0(a5)
     68e:	2781                	sext.w	a5,a5
     690:	9fb9                	addw	a5,a5,a4
     692:	2781                	sext.w	a5,a5
     694:	0007871b          	sext.w	a4,a5
     698:	00002797          	auipc	a5,0x2
     69c:	b0878793          	addi	a5,a5,-1272 # 21a0 <threading_system_time>
     6a0:	c398                	sw	a4,0(a5)
     __release();
     6a2:	00000097          	auipc	ra,0x0
     6a6:	c1c080e7          	jalr	-996(ra) # 2be <__release>
    current_thread->remaining_time -= elapsed_time;
     6aa:	fd843783          	ld	a5,-40(s0)
     6ae:	4fbc                	lw	a5,88(a5)
     6b0:	0007871b          	sext.w	a4,a5
     6b4:	fe843783          	ld	a5,-24(s0)
     6b8:	2781                	sext.w	a5,a5
     6ba:	40f707bb          	subw	a5,a4,a5
     6be:	2781                	sext.w	a5,a5
     6c0:	0007871b          	sext.w	a4,a5
     6c4:	fd843783          	ld	a5,-40(s0)
     6c8:	cfb8                	sw	a4,88(a5)

    if (current_thread->is_real_time)
     6ca:	fd843783          	ld	a5,-40(s0)
     6ce:	43bc                	lw	a5,64(a5)
     6d0:	c3ad                	beqz	a5,732 <switch_handler+0xe4>
        if (threading_system_time > current_thread->current_deadline || 
     6d2:	fd843783          	ld	a5,-40(s0)
     6d6:	4ff8                	lw	a4,92(a5)
     6d8:	00002797          	auipc	a5,0x2
     6dc:	ac878793          	addi	a5,a5,-1336 # 21a0 <threading_system_time>
     6e0:	439c                	lw	a5,0(a5)
     6e2:	02f74163          	blt	a4,a5,704 <switch_handler+0xb6>
            (threading_system_time == current_thread->current_deadline && current_thread->remaining_time > 0)) {
     6e6:	fd843783          	ld	a5,-40(s0)
     6ea:	4ff8                	lw	a4,92(a5)
     6ec:	00002797          	auipc	a5,0x2
     6f0:	ab478793          	addi	a5,a5,-1356 # 21a0 <threading_system_time>
     6f4:	439c                	lw	a5,0(a5)
        if (threading_system_time > current_thread->current_deadline || 
     6f6:	02f71e63          	bne	a4,a5,732 <switch_handler+0xe4>
            (threading_system_time == current_thread->current_deadline && current_thread->remaining_time > 0)) {
     6fa:	fd843783          	ld	a5,-40(s0)
     6fe:	4fbc                	lw	a5,88(a5)
     700:	02f05963          	blez	a5,732 <switch_handler+0xe4>
            printf("thread#%d misses a deadline at %d\n", current_thread->ID, threading_system_time);
     704:	fd843783          	ld	a5,-40(s0)
     708:	5fd8                	lw	a4,60(a5)
     70a:	00002797          	auipc	a5,0x2
     70e:	a9678793          	addi	a5,a5,-1386 # 21a0 <threading_system_time>
     712:	439c                	lw	a5,0(a5)
     714:	863e                	mv	a2,a5
     716:	85ba                	mv	a1,a4
     718:	00002517          	auipc	a0,0x2
     71c:	98050513          	addi	a0,a0,-1664 # 2098 <schedule_dm+0x294>
     720:	00001097          	auipc	ra,0x1
     724:	e54080e7          	jalr	-428(ra) # 1574 <printf>
            exit(0);
     728:	4501                	li	a0,0
     72a:	00001097          	auipc	ra,0x1
     72e:	904080e7          	jalr	-1788(ra) # 102e <exit>
        }

    if (current_thread->remaining_time <= 0) {
     732:	fd843783          	ld	a5,-40(s0)
     736:	4fbc                	lw	a5,88(a5)
     738:	02f04063          	bgtz	a5,758 <switch_handler+0x10a>
        if (current_thread->is_real_time)
     73c:	fd843783          	ld	a5,-40(s0)
     740:	43bc                	lw	a5,64(a5)
     742:	c791                	beqz	a5,74e <switch_handler+0x100>
            __rt_finish_current();
     744:	00000097          	auipc	ra,0x0
     748:	e46080e7          	jalr	-442(ra) # 58a <__rt_finish_current>
     74c:	a881                	j	79c <switch_handler+0x14e>
        else
            __finish_current();
     74e:	00000097          	auipc	ra,0x0
     752:	d78080e7          	jalr	-648(ra) # 4c6 <__finish_current>
     756:	a099                	j	79c <switch_handler+0x14e>
    } else {
        // move the current thread to the end of the run_queue
        struct list_head *to_remove = current;
     758:	00002797          	auipc	a5,0x2
     75c:	a4078793          	addi	a5,a5,-1472 # 2198 <current>
     760:	639c                	ld	a5,0(a5)
     762:	fcf43823          	sd	a5,-48(s0)
        current = current->prev;
     766:	00002797          	auipc	a5,0x2
     76a:	a3278793          	addi	a5,a5,-1486 # 2198 <current>
     76e:	639c                	ld	a5,0(a5)
     770:	6798                	ld	a4,8(a5)
     772:	00002797          	auipc	a5,0x2
     776:	a2678793          	addi	a5,a5,-1498 # 2198 <current>
     77a:	e398                	sd	a4,0(a5)
        list_del(to_remove);
     77c:	fd043503          	ld	a0,-48(s0)
     780:	00000097          	auipc	ra,0x0
     784:	91e080e7          	jalr	-1762(ra) # 9e <list_del>
        list_add_tail(to_remove, &run_queue);
     788:	00002597          	auipc	a1,0x2
     78c:	9d058593          	addi	a1,a1,-1584 # 2158 <run_queue>
     790:	fd043503          	ld	a0,-48(s0)
     794:	00000097          	auipc	ra,0x0
     798:	8ae080e7          	jalr	-1874(ra) # 42 <list_add_tail>
    }

    __release();
     79c:	00000097          	auipc	ra,0x0
     7a0:	b22080e7          	jalr	-1246(ra) # 2be <__release>
    __schedule();
     7a4:	00000097          	auipc	ra,0x0
     7a8:	1be080e7          	jalr	446(ra) # 962 <__schedule>
    __dispatch();
     7ac:	00000097          	auipc	ra,0x0
     7b0:	026080e7          	jalr	38(ra) # 7d2 <__dispatch>
    thrdresume(main_thrd_id);
     7b4:	00002797          	auipc	a5,0x2
     7b8:	9d878793          	addi	a5,a5,-1576 # 218c <main_thrd_id>
     7bc:	439c                	lw	a5,0(a5)
     7be:	853e                	mv	a0,a5
     7c0:	00001097          	auipc	ra,0x1
     7c4:	916080e7          	jalr	-1770(ra) # 10d6 <thrdresume>
}
     7c8:	0001                	nop
     7ca:	70e2                	ld	ra,56(sp)
     7cc:	7442                	ld	s0,48(sp)
     7ce:	6121                	addi	sp,sp,64
     7d0:	8082                	ret

00000000000007d2 <__dispatch>:

void __dispatch()
{
     7d2:	7179                	addi	sp,sp,-48
     7d4:	f406                	sd	ra,40(sp)
     7d6:	f022                	sd	s0,32(sp)
     7d8:	1800                	addi	s0,sp,48
    if (current == &run_queue) {
     7da:	00002797          	auipc	a5,0x2
     7de:	9be78793          	addi	a5,a5,-1602 # 2198 <current>
     7e2:	6398                	ld	a4,0(a5)
     7e4:	00002797          	auipc	a5,0x2
     7e8:	97478793          	addi	a5,a5,-1676 # 2158 <run_queue>
     7ec:	16f70663          	beq	a4,a5,958 <__dispatch+0x186>
    if (allocated_time < 0) {
        fprintf(2, "[FATAL] allocated_time is negative\n");
        exit(1);
    }

    struct thread *current_thread = list_entry(current, struct thread, thread_list);
     7f0:	00002797          	auipc	a5,0x2
     7f4:	9a878793          	addi	a5,a5,-1624 # 2198 <current>
     7f8:	639c                	ld	a5,0(a5)
     7fa:	fef43423          	sd	a5,-24(s0)
     7fe:	fe843783          	ld	a5,-24(s0)
     802:	fd878793          	addi	a5,a5,-40
     806:	fef43023          	sd	a5,-32(s0)
    if (current_thread->is_real_time && allocated_time == 0) { // miss deadline, abort
     80a:	fe043783          	ld	a5,-32(s0)
     80e:	43bc                	lw	a5,64(a5)
     810:	cf85                	beqz	a5,848 <__dispatch+0x76>
     812:	00002797          	auipc	a5,0x2
     816:	99678793          	addi	a5,a5,-1642 # 21a8 <allocated_time>
     81a:	639c                	ld	a5,0(a5)
     81c:	e795                	bnez	a5,848 <__dispatch+0x76>
        printf("thread#%d misses a deadline at %d\n", current_thread->ID, current_thread->current_deadline);
     81e:	fe043783          	ld	a5,-32(s0)
     822:	5fd8                	lw	a4,60(a5)
     824:	fe043783          	ld	a5,-32(s0)
     828:	4ffc                	lw	a5,92(a5)
     82a:	863e                	mv	a2,a5
     82c:	85ba                	mv	a1,a4
     82e:	00002517          	auipc	a0,0x2
     832:	86a50513          	addi	a0,a0,-1942 # 2098 <schedule_dm+0x294>
     836:	00001097          	auipc	ra,0x1
     83a:	d3e080e7          	jalr	-706(ra) # 1574 <printf>
        exit(0);
     83e:	4501                	li	a0,0
     840:	00000097          	auipc	ra,0x0
     844:	7ee080e7          	jalr	2030(ra) # 102e <exit>
    }

    printf("dispatch thread#%d at %d: allocated_time=%d\n", current_thread->ID, threading_system_time, allocated_time);
     848:	fe043783          	ld	a5,-32(s0)
     84c:	5fd8                	lw	a4,60(a5)
     84e:	00002797          	auipc	a5,0x2
     852:	95278793          	addi	a5,a5,-1710 # 21a0 <threading_system_time>
     856:	4390                	lw	a2,0(a5)
     858:	00002797          	auipc	a5,0x2
     85c:	95078793          	addi	a5,a5,-1712 # 21a8 <allocated_time>
     860:	639c                	ld	a5,0(a5)
     862:	86be                	mv	a3,a5
     864:	85ba                	mv	a1,a4
     866:	00002517          	auipc	a0,0x2
     86a:	85a50513          	addi	a0,a0,-1958 # 20c0 <schedule_dm+0x2bc>
     86e:	00001097          	auipc	ra,0x1
     872:	d06080e7          	jalr	-762(ra) # 1574 <printf>

    if (current_thread->buf_set) {
     876:	fe043783          	ld	a5,-32(s0)
     87a:	539c                	lw	a5,32(a5)
     87c:	c7a1                	beqz	a5,8c4 <__dispatch+0xf2>
        thrdstop(allocated_time, &(current_thread->thrdstop_context_id), switch_handler, (void *)allocated_time);
     87e:	00002797          	auipc	a5,0x2
     882:	92a78793          	addi	a5,a5,-1750 # 21a8 <allocated_time>
     886:	639c                	ld	a5,0(a5)
     888:	0007871b          	sext.w	a4,a5
     88c:	fe043783          	ld	a5,-32(s0)
     890:	03878593          	addi	a1,a5,56
     894:	00002797          	auipc	a5,0x2
     898:	91478793          	addi	a5,a5,-1772 # 21a8 <allocated_time>
     89c:	639c                	ld	a5,0(a5)
     89e:	86be                	mv	a3,a5
     8a0:	00000617          	auipc	a2,0x0
     8a4:	dae60613          	addi	a2,a2,-594 # 64e <switch_handler>
     8a8:	853a                	mv	a0,a4
     8aa:	00001097          	auipc	ra,0x1
     8ae:	824080e7          	jalr	-2012(ra) # 10ce <thrdstop>
        thrdresume(current_thread->thrdstop_context_id);
     8b2:	fe043783          	ld	a5,-32(s0)
     8b6:	5f9c                	lw	a5,56(a5)
     8b8:	853e                	mv	a0,a5
     8ba:	00001097          	auipc	ra,0x1
     8be:	81c080e7          	jalr	-2020(ra) # 10d6 <thrdresume>
     8c2:	a071                	j	94e <__dispatch+0x17c>
    } else {
        current_thread->buf_set = 1;
     8c4:	fe043783          	ld	a5,-32(s0)
     8c8:	4705                	li	a4,1
     8ca:	d398                	sw	a4,32(a5)
        unsigned long new_stack_p = (unsigned long)current_thread->stack_p;
     8cc:	fe043783          	ld	a5,-32(s0)
     8d0:	6f9c                	ld	a5,24(a5)
     8d2:	fcf43c23          	sd	a5,-40(s0)
        current_thread->thrdstop_context_id = -1;
     8d6:	fe043783          	ld	a5,-32(s0)
     8da:	577d                	li	a4,-1
     8dc:	df98                	sw	a4,56(a5)
        thrdstop(allocated_time, &(current_thread->thrdstop_context_id), switch_handler, (void *)allocated_time);
     8de:	00002797          	auipc	a5,0x2
     8e2:	8ca78793          	addi	a5,a5,-1846 # 21a8 <allocated_time>
     8e6:	639c                	ld	a5,0(a5)
     8e8:	0007871b          	sext.w	a4,a5
     8ec:	fe043783          	ld	a5,-32(s0)
     8f0:	03878593          	addi	a1,a5,56
     8f4:	00002797          	auipc	a5,0x2
     8f8:	8b478793          	addi	a5,a5,-1868 # 21a8 <allocated_time>
     8fc:	639c                	ld	a5,0(a5)
     8fe:	86be                	mv	a3,a5
     900:	00000617          	auipc	a2,0x0
     904:	d4e60613          	addi	a2,a2,-690 # 64e <switch_handler>
     908:	853a                	mv	a0,a4
     90a:	00000097          	auipc	ra,0x0
     90e:	7c4080e7          	jalr	1988(ra) # 10ce <thrdstop>
        if (current_thread->thrdstop_context_id < 0) {
     912:	fe043783          	ld	a5,-32(s0)
     916:	5f9c                	lw	a5,56(a5)
     918:	0207d063          	bgez	a5,938 <__dispatch+0x166>
            fprintf(2, "[ERROR] number of threads may exceed MAX_THRD_NUM\n");
     91c:	00001597          	auipc	a1,0x1
     920:	7d458593          	addi	a1,a1,2004 # 20f0 <schedule_dm+0x2ec>
     924:	4509                	li	a0,2
     926:	00001097          	auipc	ra,0x1
     92a:	bf6080e7          	jalr	-1034(ra) # 151c <fprintf>
            exit(1);
     92e:	4505                	li	a0,1
     930:	00000097          	auipc	ra,0x0
     934:	6fe080e7          	jalr	1790(ra) # 102e <exit>
        }

        // set sp to stack pointer of current thread.
        asm volatile("mv sp, %0"
     938:	fd843783          	ld	a5,-40(s0)
     93c:	813e                	mv	sp,a5
                     :
                     : "r"(new_stack_p));
        current_thread->fp(current_thread->arg);
     93e:	fe043783          	ld	a5,-32(s0)
     942:	6398                	ld	a4,0(a5)
     944:	fe043783          	ld	a5,-32(s0)
     948:	679c                	ld	a5,8(a5)
     94a:	853e                	mv	a0,a5
     94c:	9702                	jalr	a4
    }
    thread_exit();
     94e:	00000097          	auipc	ra,0x0
     952:	ad0080e7          	jalr	-1328(ra) # 41e <thread_exit>
     956:	a011                	j	95a <__dispatch+0x188>
        return;
     958:	0001                	nop
}
     95a:	70a2                	ld	ra,40(sp)
     95c:	7402                	ld	s0,32(sp)
     95e:	6145                	addi	sp,sp,48
     960:	8082                	ret

0000000000000962 <__schedule>:

void __schedule()
{
     962:	711d                	addi	sp,sp,-96
     964:	ec86                	sd	ra,88(sp)
     966:	e8a2                	sd	s0,80(sp)
     968:	1080                	addi	s0,sp,96
    struct threads_sched_args args = {
     96a:	00002797          	auipc	a5,0x2
     96e:	83678793          	addi	a5,a5,-1994 # 21a0 <threading_system_time>
     972:	439c                	lw	a5,0(a5)
     974:	fcf42c23          	sw	a5,-40(s0)
     978:	4789                	li	a5,2
     97a:	fcf42e23          	sw	a5,-36(s0)
     97e:	00001797          	auipc	a5,0x1
     982:	7da78793          	addi	a5,a5,2010 # 2158 <run_queue>
     986:	fef43023          	sd	a5,-32(s0)
     98a:	00001797          	auipc	a5,0x1
     98e:	7de78793          	addi	a5,a5,2014 # 2168 <release_queue>
     992:	fef43423          	sd	a5,-24(s0)
#ifdef THREAD_SCHEDULER_LST
    r = schedule_lst(args);
#endif

#ifdef THREAD_SCHEDULER_DM
    r = schedule_dm(args);
     996:	fd843783          	ld	a5,-40(s0)
     99a:	faf43023          	sd	a5,-96(s0)
     99e:	fe043783          	ld	a5,-32(s0)
     9a2:	faf43423          	sd	a5,-88(s0)
     9a6:	fe843783          	ld	a5,-24(s0)
     9aa:	faf43823          	sd	a5,-80(s0)
     9ae:	fa040793          	addi	a5,s0,-96
     9b2:	853e                	mv	a0,a5
     9b4:	00001097          	auipc	ra,0x1
     9b8:	450080e7          	jalr	1104(ra) # 1e04 <schedule_dm>
     9bc:	872a                	mv	a4,a0
     9be:	87ae                	mv	a5,a1
     9c0:	fce43423          	sd	a4,-56(s0)
     9c4:	fcf43823          	sd	a5,-48(s0)
#endif

    current = r.scheduled_thread_list_member;
     9c8:	fc843703          	ld	a4,-56(s0)
     9cc:	00001797          	auipc	a5,0x1
     9d0:	7cc78793          	addi	a5,a5,1996 # 2198 <current>
     9d4:	e398                	sd	a4,0(a5)
    allocated_time = r.allocated_time;
     9d6:	fd042783          	lw	a5,-48(s0)
     9da:	873e                	mv	a4,a5
     9dc:	00001797          	auipc	a5,0x1
     9e0:	7cc78793          	addi	a5,a5,1996 # 21a8 <allocated_time>
     9e4:	e398                	sd	a4,0(a5)
}
     9e6:	0001                	nop
     9e8:	60e6                	ld	ra,88(sp)
     9ea:	6446                	ld	s0,80(sp)
     9ec:	6125                	addi	sp,sp,96
     9ee:	8082                	ret

00000000000009f0 <back_to_main_handler>:

void back_to_main_handler(void *arg)
{
     9f0:	1101                	addi	sp,sp,-32
     9f2:	ec06                	sd	ra,24(sp)
     9f4:	e822                	sd	s0,16(sp)
     9f6:	1000                	addi	s0,sp,32
     9f8:	fea43423          	sd	a0,-24(s0)
    sleeping = 0;
     9fc:	00001797          	auipc	a5,0x1
     a00:	7a878793          	addi	a5,a5,1960 # 21a4 <sleeping>
     a04:	0007a023          	sw	zero,0(a5)
    threading_system_time += (uint64)arg;
     a08:	fe843783          	ld	a5,-24(s0)
     a0c:	0007871b          	sext.w	a4,a5
     a10:	00001797          	auipc	a5,0x1
     a14:	79078793          	addi	a5,a5,1936 # 21a0 <threading_system_time>
     a18:	439c                	lw	a5,0(a5)
     a1a:	2781                	sext.w	a5,a5
     a1c:	9fb9                	addw	a5,a5,a4
     a1e:	2781                	sext.w	a5,a5
     a20:	0007871b          	sext.w	a4,a5
     a24:	00001797          	auipc	a5,0x1
     a28:	77c78793          	addi	a5,a5,1916 # 21a0 <threading_system_time>
     a2c:	c398                	sw	a4,0(a5)
    thrdresume(main_thrd_id);
     a2e:	00001797          	auipc	a5,0x1
     a32:	75e78793          	addi	a5,a5,1886 # 218c <main_thrd_id>
     a36:	439c                	lw	a5,0(a5)
     a38:	853e                	mv	a0,a5
     a3a:	00000097          	auipc	ra,0x0
     a3e:	69c080e7          	jalr	1692(ra) # 10d6 <thrdresume>
}
     a42:	0001                	nop
     a44:	60e2                	ld	ra,24(sp)
     a46:	6442                	ld	s0,16(sp)
     a48:	6105                	addi	sp,sp,32
     a4a:	8082                	ret

0000000000000a4c <thread_start_threading>:

void thread_start_threading()
{
     a4c:	1141                	addi	sp,sp,-16
     a4e:	e406                	sd	ra,8(sp)
     a50:	e022                	sd	s0,0(sp)
     a52:	0800                	addi	s0,sp,16
    threading_system_time = 0;
     a54:	00001797          	auipc	a5,0x1
     a58:	74c78793          	addi	a5,a5,1868 # 21a0 <threading_system_time>
     a5c:	0007a023          	sw	zero,0(a5)
    current = &run_queue;
     a60:	00001797          	auipc	a5,0x1
     a64:	73878793          	addi	a5,a5,1848 # 2198 <current>
     a68:	00001717          	auipc	a4,0x1
     a6c:	6f070713          	addi	a4,a4,1776 # 2158 <run_queue>
     a70:	e398                	sd	a4,0(a5)

    // call thrdstop just for obtain an ID
    thrdstop(1000, &main_thrd_id, back_to_main_handler, (void *)0);
     a72:	4681                	li	a3,0
     a74:	00000617          	auipc	a2,0x0
     a78:	f7c60613          	addi	a2,a2,-132 # 9f0 <back_to_main_handler>
     a7c:	00001597          	auipc	a1,0x1
     a80:	71058593          	addi	a1,a1,1808 # 218c <main_thrd_id>
     a84:	3e800513          	li	a0,1000
     a88:	00000097          	auipc	ra,0x0
     a8c:	646080e7          	jalr	1606(ra) # 10ce <thrdstop>
    cancelthrdstop(main_thrd_id, 0);
     a90:	00001797          	auipc	a5,0x1
     a94:	6fc78793          	addi	a5,a5,1788 # 218c <main_thrd_id>
     a98:	439c                	lw	a5,0(a5)
     a9a:	4581                	li	a1,0
     a9c:	853e                	mv	a0,a5
     a9e:	00000097          	auipc	ra,0x0
     aa2:	640080e7          	jalr	1600(ra) # 10de <cancelthrdstop>

    while (!list_empty(&run_queue) || !list_empty(&release_queue)) {
     aa6:	a0c9                	j	b68 <thread_start_threading+0x11c>
        __release();
     aa8:	00000097          	auipc	ra,0x0
     aac:	816080e7          	jalr	-2026(ra) # 2be <__release>
        __schedule();
     ab0:	00000097          	auipc	ra,0x0
     ab4:	eb2080e7          	jalr	-334(ra) # 962 <__schedule>
        cancelthrdstop(main_thrd_id, 0);
     ab8:	00001797          	auipc	a5,0x1
     abc:	6d478793          	addi	a5,a5,1748 # 218c <main_thrd_id>
     ac0:	439c                	lw	a5,0(a5)
     ac2:	4581                	li	a1,0
     ac4:	853e                	mv	a0,a5
     ac6:	00000097          	auipc	ra,0x0
     aca:	618080e7          	jalr	1560(ra) # 10de <cancelthrdstop>
        __dispatch();
     ace:	00000097          	auipc	ra,0x0
     ad2:	d04080e7          	jalr	-764(ra) # 7d2 <__dispatch>

        if (list_empty(&run_queue) && list_empty(&release_queue)) {
     ad6:	00001517          	auipc	a0,0x1
     ada:	68250513          	addi	a0,a0,1666 # 2158 <run_queue>
     ade:	fffff097          	auipc	ra,0xfffff
     ae2:	60a080e7          	jalr	1546(ra) # e8 <list_empty>
     ae6:	87aa                	mv	a5,a0
     ae8:	cb99                	beqz	a5,afe <thread_start_threading+0xb2>
     aea:	00001517          	auipc	a0,0x1
     aee:	67e50513          	addi	a0,a0,1662 # 2168 <release_queue>
     af2:	fffff097          	auipc	ra,0xfffff
     af6:	5f6080e7          	jalr	1526(ra) # e8 <list_empty>
     afa:	87aa                	mv	a5,a0
     afc:	ebd9                	bnez	a5,b92 <thread_start_threading+0x146>
            break;
        }

        // no thread in run_queue, release_queue not empty
        printf("run_queue is empty, sleep for %d ticks\n", allocated_time);
     afe:	00001797          	auipc	a5,0x1
     b02:	6aa78793          	addi	a5,a5,1706 # 21a8 <allocated_time>
     b06:	639c                	ld	a5,0(a5)
     b08:	85be                	mv	a1,a5
     b0a:	00001517          	auipc	a0,0x1
     b0e:	61e50513          	addi	a0,a0,1566 # 2128 <schedule_dm+0x324>
     b12:	00001097          	auipc	ra,0x1
     b16:	a62080e7          	jalr	-1438(ra) # 1574 <printf>
        sleeping = 1;
     b1a:	00001797          	auipc	a5,0x1
     b1e:	68a78793          	addi	a5,a5,1674 # 21a4 <sleeping>
     b22:	4705                	li	a4,1
     b24:	c398                	sw	a4,0(a5)
        thrdstop(allocated_time, &main_thrd_id, back_to_main_handler, (void *)allocated_time);
     b26:	00001797          	auipc	a5,0x1
     b2a:	68278793          	addi	a5,a5,1666 # 21a8 <allocated_time>
     b2e:	639c                	ld	a5,0(a5)
     b30:	0007871b          	sext.w	a4,a5
     b34:	00001797          	auipc	a5,0x1
     b38:	67478793          	addi	a5,a5,1652 # 21a8 <allocated_time>
     b3c:	639c                	ld	a5,0(a5)
     b3e:	86be                	mv	a3,a5
     b40:	00000617          	auipc	a2,0x0
     b44:	eb060613          	addi	a2,a2,-336 # 9f0 <back_to_main_handler>
     b48:	00001597          	auipc	a1,0x1
     b4c:	64458593          	addi	a1,a1,1604 # 218c <main_thrd_id>
     b50:	853a                	mv	a0,a4
     b52:	00000097          	auipc	ra,0x0
     b56:	57c080e7          	jalr	1404(ra) # 10ce <thrdstop>
        while (sleeping) {
     b5a:	0001                	nop
     b5c:	00001797          	auipc	a5,0x1
     b60:	64878793          	addi	a5,a5,1608 # 21a4 <sleeping>
     b64:	439c                	lw	a5,0(a5)
     b66:	fbfd                	bnez	a5,b5c <thread_start_threading+0x110>
    while (!list_empty(&run_queue) || !list_empty(&release_queue)) {
     b68:	00001517          	auipc	a0,0x1
     b6c:	5f050513          	addi	a0,a0,1520 # 2158 <run_queue>
     b70:	fffff097          	auipc	ra,0xfffff
     b74:	578080e7          	jalr	1400(ra) # e8 <list_empty>
     b78:	87aa                	mv	a5,a0
     b7a:	d79d                	beqz	a5,aa8 <thread_start_threading+0x5c>
     b7c:	00001517          	auipc	a0,0x1
     b80:	5ec50513          	addi	a0,a0,1516 # 2168 <release_queue>
     b84:	fffff097          	auipc	ra,0xfffff
     b88:	564080e7          	jalr	1380(ra) # e8 <list_empty>
     b8c:	87aa                	mv	a5,a0
     b8e:	df89                	beqz	a5,aa8 <thread_start_threading+0x5c>
            // zzz...
        }
    }
}
     b90:	a011                	j	b94 <thread_start_threading+0x148>
            break;
     b92:	0001                	nop
}
     b94:	0001                	nop
     b96:	60a2                	ld	ra,8(sp)
     b98:	6402                	ld	s0,0(sp)
     b9a:	0141                	addi	sp,sp,16
     b9c:	8082                	ret

0000000000000b9e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     b9e:	7179                	addi	sp,sp,-48
     ba0:	f422                	sd	s0,40(sp)
     ba2:	1800                	addi	s0,sp,48
     ba4:	fca43c23          	sd	a0,-40(s0)
     ba8:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     bac:	fd843783          	ld	a5,-40(s0)
     bb0:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     bb4:	0001                	nop
     bb6:	fd043703          	ld	a4,-48(s0)
     bba:	00170793          	addi	a5,a4,1
     bbe:	fcf43823          	sd	a5,-48(s0)
     bc2:	fd843783          	ld	a5,-40(s0)
     bc6:	00178693          	addi	a3,a5,1
     bca:	fcd43c23          	sd	a3,-40(s0)
     bce:	00074703          	lbu	a4,0(a4)
     bd2:	00e78023          	sb	a4,0(a5)
     bd6:	0007c783          	lbu	a5,0(a5)
     bda:	fff1                	bnez	a5,bb6 <strcpy+0x18>
    ;
  return os;
     bdc:	fe843783          	ld	a5,-24(s0)
}
     be0:	853e                	mv	a0,a5
     be2:	7422                	ld	s0,40(sp)
     be4:	6145                	addi	sp,sp,48
     be6:	8082                	ret

0000000000000be8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     be8:	1101                	addi	sp,sp,-32
     bea:	ec22                	sd	s0,24(sp)
     bec:	1000                	addi	s0,sp,32
     bee:	fea43423          	sd	a0,-24(s0)
     bf2:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     bf6:	a819                	j	c0c <strcmp+0x24>
    p++, q++;
     bf8:	fe843783          	ld	a5,-24(s0)
     bfc:	0785                	addi	a5,a5,1
     bfe:	fef43423          	sd	a5,-24(s0)
     c02:	fe043783          	ld	a5,-32(s0)
     c06:	0785                	addi	a5,a5,1
     c08:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     c0c:	fe843783          	ld	a5,-24(s0)
     c10:	0007c783          	lbu	a5,0(a5)
     c14:	cb99                	beqz	a5,c2a <strcmp+0x42>
     c16:	fe843783          	ld	a5,-24(s0)
     c1a:	0007c703          	lbu	a4,0(a5)
     c1e:	fe043783          	ld	a5,-32(s0)
     c22:	0007c783          	lbu	a5,0(a5)
     c26:	fcf709e3          	beq	a4,a5,bf8 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     c2a:	fe843783          	ld	a5,-24(s0)
     c2e:	0007c783          	lbu	a5,0(a5)
     c32:	0007871b          	sext.w	a4,a5
     c36:	fe043783          	ld	a5,-32(s0)
     c3a:	0007c783          	lbu	a5,0(a5)
     c3e:	2781                	sext.w	a5,a5
     c40:	40f707bb          	subw	a5,a4,a5
     c44:	2781                	sext.w	a5,a5
}
     c46:	853e                	mv	a0,a5
     c48:	6462                	ld	s0,24(sp)
     c4a:	6105                	addi	sp,sp,32
     c4c:	8082                	ret

0000000000000c4e <strlen>:

uint
strlen(const char *s)
{
     c4e:	7179                	addi	sp,sp,-48
     c50:	f422                	sd	s0,40(sp)
     c52:	1800                	addi	s0,sp,48
     c54:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     c58:	fe042623          	sw	zero,-20(s0)
     c5c:	a031                	j	c68 <strlen+0x1a>
     c5e:	fec42783          	lw	a5,-20(s0)
     c62:	2785                	addiw	a5,a5,1
     c64:	fef42623          	sw	a5,-20(s0)
     c68:	fec42783          	lw	a5,-20(s0)
     c6c:	fd843703          	ld	a4,-40(s0)
     c70:	97ba                	add	a5,a5,a4
     c72:	0007c783          	lbu	a5,0(a5)
     c76:	f7e5                	bnez	a5,c5e <strlen+0x10>
    ;
  return n;
     c78:	fec42783          	lw	a5,-20(s0)
}
     c7c:	853e                	mv	a0,a5
     c7e:	7422                	ld	s0,40(sp)
     c80:	6145                	addi	sp,sp,48
     c82:	8082                	ret

0000000000000c84 <memset>:

void*
memset(void *dst, int c, uint n)
{
     c84:	7179                	addi	sp,sp,-48
     c86:	f422                	sd	s0,40(sp)
     c88:	1800                	addi	s0,sp,48
     c8a:	fca43c23          	sd	a0,-40(s0)
     c8e:	87ae                	mv	a5,a1
     c90:	8732                	mv	a4,a2
     c92:	fcf42a23          	sw	a5,-44(s0)
     c96:	87ba                	mv	a5,a4
     c98:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     c9c:	fd843783          	ld	a5,-40(s0)
     ca0:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     ca4:	fe042623          	sw	zero,-20(s0)
     ca8:	a00d                	j	cca <memset+0x46>
    cdst[i] = c;
     caa:	fec42783          	lw	a5,-20(s0)
     cae:	fe043703          	ld	a4,-32(s0)
     cb2:	97ba                	add	a5,a5,a4
     cb4:	fd442703          	lw	a4,-44(s0)
     cb8:	0ff77713          	andi	a4,a4,255
     cbc:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     cc0:	fec42783          	lw	a5,-20(s0)
     cc4:	2785                	addiw	a5,a5,1
     cc6:	fef42623          	sw	a5,-20(s0)
     cca:	fec42703          	lw	a4,-20(s0)
     cce:	fd042783          	lw	a5,-48(s0)
     cd2:	2781                	sext.w	a5,a5
     cd4:	fcf76be3          	bltu	a4,a5,caa <memset+0x26>
  }
  return dst;
     cd8:	fd843783          	ld	a5,-40(s0)
}
     cdc:	853e                	mv	a0,a5
     cde:	7422                	ld	s0,40(sp)
     ce0:	6145                	addi	sp,sp,48
     ce2:	8082                	ret

0000000000000ce4 <strchr>:

char*
strchr(const char *s, char c)
{
     ce4:	1101                	addi	sp,sp,-32
     ce6:	ec22                	sd	s0,24(sp)
     ce8:	1000                	addi	s0,sp,32
     cea:	fea43423          	sd	a0,-24(s0)
     cee:	87ae                	mv	a5,a1
     cf0:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     cf4:	a01d                	j	d1a <strchr+0x36>
    if(*s == c)
     cf6:	fe843783          	ld	a5,-24(s0)
     cfa:	0007c703          	lbu	a4,0(a5)
     cfe:	fe744783          	lbu	a5,-25(s0)
     d02:	0ff7f793          	andi	a5,a5,255
     d06:	00e79563          	bne	a5,a4,d10 <strchr+0x2c>
      return (char*)s;
     d0a:	fe843783          	ld	a5,-24(s0)
     d0e:	a821                	j	d26 <strchr+0x42>
  for(; *s; s++)
     d10:	fe843783          	ld	a5,-24(s0)
     d14:	0785                	addi	a5,a5,1
     d16:	fef43423          	sd	a5,-24(s0)
     d1a:	fe843783          	ld	a5,-24(s0)
     d1e:	0007c783          	lbu	a5,0(a5)
     d22:	fbf1                	bnez	a5,cf6 <strchr+0x12>
  return 0;
     d24:	4781                	li	a5,0
}
     d26:	853e                	mv	a0,a5
     d28:	6462                	ld	s0,24(sp)
     d2a:	6105                	addi	sp,sp,32
     d2c:	8082                	ret

0000000000000d2e <gets>:

char*
gets(char *buf, int max)
{
     d2e:	7179                	addi	sp,sp,-48
     d30:	f406                	sd	ra,40(sp)
     d32:	f022                	sd	s0,32(sp)
     d34:	1800                	addi	s0,sp,48
     d36:	fca43c23          	sd	a0,-40(s0)
     d3a:	87ae                	mv	a5,a1
     d3c:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     d40:	fe042623          	sw	zero,-20(s0)
     d44:	a8a1                	j	d9c <gets+0x6e>
    cc = read(0, &c, 1);
     d46:	fe740793          	addi	a5,s0,-25
     d4a:	4605                	li	a2,1
     d4c:	85be                	mv	a1,a5
     d4e:	4501                	li	a0,0
     d50:	00000097          	auipc	ra,0x0
     d54:	2f6080e7          	jalr	758(ra) # 1046 <read>
     d58:	87aa                	mv	a5,a0
     d5a:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     d5e:	fe842783          	lw	a5,-24(s0)
     d62:	2781                	sext.w	a5,a5
     d64:	04f05763          	blez	a5,db2 <gets+0x84>
      break;
    buf[i++] = c;
     d68:	fec42783          	lw	a5,-20(s0)
     d6c:	0017871b          	addiw	a4,a5,1
     d70:	fee42623          	sw	a4,-20(s0)
     d74:	873e                	mv	a4,a5
     d76:	fd843783          	ld	a5,-40(s0)
     d7a:	97ba                	add	a5,a5,a4
     d7c:	fe744703          	lbu	a4,-25(s0)
     d80:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     d84:	fe744783          	lbu	a5,-25(s0)
     d88:	873e                	mv	a4,a5
     d8a:	47a9                	li	a5,10
     d8c:	02f70463          	beq	a4,a5,db4 <gets+0x86>
     d90:	fe744783          	lbu	a5,-25(s0)
     d94:	873e                	mv	a4,a5
     d96:	47b5                	li	a5,13
     d98:	00f70e63          	beq	a4,a5,db4 <gets+0x86>
  for(i=0; i+1 < max; ){
     d9c:	fec42783          	lw	a5,-20(s0)
     da0:	2785                	addiw	a5,a5,1
     da2:	0007871b          	sext.w	a4,a5
     da6:	fd442783          	lw	a5,-44(s0)
     daa:	2781                	sext.w	a5,a5
     dac:	f8f74de3          	blt	a4,a5,d46 <gets+0x18>
     db0:	a011                	j	db4 <gets+0x86>
      break;
     db2:	0001                	nop
      break;
  }
  buf[i] = '\0';
     db4:	fec42783          	lw	a5,-20(s0)
     db8:	fd843703          	ld	a4,-40(s0)
     dbc:	97ba                	add	a5,a5,a4
     dbe:	00078023          	sb	zero,0(a5)
  return buf;
     dc2:	fd843783          	ld	a5,-40(s0)
}
     dc6:	853e                	mv	a0,a5
     dc8:	70a2                	ld	ra,40(sp)
     dca:	7402                	ld	s0,32(sp)
     dcc:	6145                	addi	sp,sp,48
     dce:	8082                	ret

0000000000000dd0 <stat>:

int
stat(const char *n, struct stat *st)
{
     dd0:	7179                	addi	sp,sp,-48
     dd2:	f406                	sd	ra,40(sp)
     dd4:	f022                	sd	s0,32(sp)
     dd6:	1800                	addi	s0,sp,48
     dd8:	fca43c23          	sd	a0,-40(s0)
     ddc:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     de0:	4581                	li	a1,0
     de2:	fd843503          	ld	a0,-40(s0)
     de6:	00000097          	auipc	ra,0x0
     dea:	288080e7          	jalr	648(ra) # 106e <open>
     dee:	87aa                	mv	a5,a0
     df0:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     df4:	fec42783          	lw	a5,-20(s0)
     df8:	2781                	sext.w	a5,a5
     dfa:	0007d463          	bgez	a5,e02 <stat+0x32>
    return -1;
     dfe:	57fd                	li	a5,-1
     e00:	a035                	j	e2c <stat+0x5c>
  r = fstat(fd, st);
     e02:	fec42783          	lw	a5,-20(s0)
     e06:	fd043583          	ld	a1,-48(s0)
     e0a:	853e                	mv	a0,a5
     e0c:	00000097          	auipc	ra,0x0
     e10:	27a080e7          	jalr	634(ra) # 1086 <fstat>
     e14:	87aa                	mv	a5,a0
     e16:	fef42423          	sw	a5,-24(s0)
  close(fd);
     e1a:	fec42783          	lw	a5,-20(s0)
     e1e:	853e                	mv	a0,a5
     e20:	00000097          	auipc	ra,0x0
     e24:	236080e7          	jalr	566(ra) # 1056 <close>
  return r;
     e28:	fe842783          	lw	a5,-24(s0)
}
     e2c:	853e                	mv	a0,a5
     e2e:	70a2                	ld	ra,40(sp)
     e30:	7402                	ld	s0,32(sp)
     e32:	6145                	addi	sp,sp,48
     e34:	8082                	ret

0000000000000e36 <atoi>:

int
atoi(const char *s)
{
     e36:	7179                	addi	sp,sp,-48
     e38:	f422                	sd	s0,40(sp)
     e3a:	1800                	addi	s0,sp,48
     e3c:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     e40:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     e44:	a815                	j	e78 <atoi+0x42>
    n = n*10 + *s++ - '0';
     e46:	fec42703          	lw	a4,-20(s0)
     e4a:	87ba                	mv	a5,a4
     e4c:	0027979b          	slliw	a5,a5,0x2
     e50:	9fb9                	addw	a5,a5,a4
     e52:	0017979b          	slliw	a5,a5,0x1
     e56:	0007871b          	sext.w	a4,a5
     e5a:	fd843783          	ld	a5,-40(s0)
     e5e:	00178693          	addi	a3,a5,1
     e62:	fcd43c23          	sd	a3,-40(s0)
     e66:	0007c783          	lbu	a5,0(a5)
     e6a:	2781                	sext.w	a5,a5
     e6c:	9fb9                	addw	a5,a5,a4
     e6e:	2781                	sext.w	a5,a5
     e70:	fd07879b          	addiw	a5,a5,-48
     e74:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     e78:	fd843783          	ld	a5,-40(s0)
     e7c:	0007c783          	lbu	a5,0(a5)
     e80:	873e                	mv	a4,a5
     e82:	02f00793          	li	a5,47
     e86:	00e7fb63          	bgeu	a5,a4,e9c <atoi+0x66>
     e8a:	fd843783          	ld	a5,-40(s0)
     e8e:	0007c783          	lbu	a5,0(a5)
     e92:	873e                	mv	a4,a5
     e94:	03900793          	li	a5,57
     e98:	fae7f7e3          	bgeu	a5,a4,e46 <atoi+0x10>
  return n;
     e9c:	fec42783          	lw	a5,-20(s0)
}
     ea0:	853e                	mv	a0,a5
     ea2:	7422                	ld	s0,40(sp)
     ea4:	6145                	addi	sp,sp,48
     ea6:	8082                	ret

0000000000000ea8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     ea8:	7139                	addi	sp,sp,-64
     eaa:	fc22                	sd	s0,56(sp)
     eac:	0080                	addi	s0,sp,64
     eae:	fca43c23          	sd	a0,-40(s0)
     eb2:	fcb43823          	sd	a1,-48(s0)
     eb6:	87b2                	mv	a5,a2
     eb8:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     ebc:	fd843783          	ld	a5,-40(s0)
     ec0:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     ec4:	fd043783          	ld	a5,-48(s0)
     ec8:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     ecc:	fe043703          	ld	a4,-32(s0)
     ed0:	fe843783          	ld	a5,-24(s0)
     ed4:	02e7fc63          	bgeu	a5,a4,f0c <memmove+0x64>
    while(n-- > 0)
     ed8:	a00d                	j	efa <memmove+0x52>
      *dst++ = *src++;
     eda:	fe043703          	ld	a4,-32(s0)
     ede:	00170793          	addi	a5,a4,1
     ee2:	fef43023          	sd	a5,-32(s0)
     ee6:	fe843783          	ld	a5,-24(s0)
     eea:	00178693          	addi	a3,a5,1
     eee:	fed43423          	sd	a3,-24(s0)
     ef2:	00074703          	lbu	a4,0(a4)
     ef6:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     efa:	fcc42783          	lw	a5,-52(s0)
     efe:	fff7871b          	addiw	a4,a5,-1
     f02:	fce42623          	sw	a4,-52(s0)
     f06:	fcf04ae3          	bgtz	a5,eda <memmove+0x32>
     f0a:	a891                	j	f5e <memmove+0xb6>
  } else {
    dst += n;
     f0c:	fcc42783          	lw	a5,-52(s0)
     f10:	fe843703          	ld	a4,-24(s0)
     f14:	97ba                	add	a5,a5,a4
     f16:	fef43423          	sd	a5,-24(s0)
    src += n;
     f1a:	fcc42783          	lw	a5,-52(s0)
     f1e:	fe043703          	ld	a4,-32(s0)
     f22:	97ba                	add	a5,a5,a4
     f24:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     f28:	a01d                	j	f4e <memmove+0xa6>
      *--dst = *--src;
     f2a:	fe043783          	ld	a5,-32(s0)
     f2e:	17fd                	addi	a5,a5,-1
     f30:	fef43023          	sd	a5,-32(s0)
     f34:	fe843783          	ld	a5,-24(s0)
     f38:	17fd                	addi	a5,a5,-1
     f3a:	fef43423          	sd	a5,-24(s0)
     f3e:	fe043783          	ld	a5,-32(s0)
     f42:	0007c703          	lbu	a4,0(a5)
     f46:	fe843783          	ld	a5,-24(s0)
     f4a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     f4e:	fcc42783          	lw	a5,-52(s0)
     f52:	fff7871b          	addiw	a4,a5,-1
     f56:	fce42623          	sw	a4,-52(s0)
     f5a:	fcf048e3          	bgtz	a5,f2a <memmove+0x82>
  }
  return vdst;
     f5e:	fd843783          	ld	a5,-40(s0)
}
     f62:	853e                	mv	a0,a5
     f64:	7462                	ld	s0,56(sp)
     f66:	6121                	addi	sp,sp,64
     f68:	8082                	ret

0000000000000f6a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     f6a:	7139                	addi	sp,sp,-64
     f6c:	fc22                	sd	s0,56(sp)
     f6e:	0080                	addi	s0,sp,64
     f70:	fca43c23          	sd	a0,-40(s0)
     f74:	fcb43823          	sd	a1,-48(s0)
     f78:	87b2                	mv	a5,a2
     f7a:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     f7e:	fd843783          	ld	a5,-40(s0)
     f82:	fef43423          	sd	a5,-24(s0)
     f86:	fd043783          	ld	a5,-48(s0)
     f8a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     f8e:	a0a1                	j	fd6 <memcmp+0x6c>
    if (*p1 != *p2) {
     f90:	fe843783          	ld	a5,-24(s0)
     f94:	0007c703          	lbu	a4,0(a5)
     f98:	fe043783          	ld	a5,-32(s0)
     f9c:	0007c783          	lbu	a5,0(a5)
     fa0:	02f70163          	beq	a4,a5,fc2 <memcmp+0x58>
      return *p1 - *p2;
     fa4:	fe843783          	ld	a5,-24(s0)
     fa8:	0007c783          	lbu	a5,0(a5)
     fac:	0007871b          	sext.w	a4,a5
     fb0:	fe043783          	ld	a5,-32(s0)
     fb4:	0007c783          	lbu	a5,0(a5)
     fb8:	2781                	sext.w	a5,a5
     fba:	40f707bb          	subw	a5,a4,a5
     fbe:	2781                	sext.w	a5,a5
     fc0:	a01d                	j	fe6 <memcmp+0x7c>
    }
    p1++;
     fc2:	fe843783          	ld	a5,-24(s0)
     fc6:	0785                	addi	a5,a5,1
     fc8:	fef43423          	sd	a5,-24(s0)
    p2++;
     fcc:	fe043783          	ld	a5,-32(s0)
     fd0:	0785                	addi	a5,a5,1
     fd2:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     fd6:	fcc42783          	lw	a5,-52(s0)
     fda:	fff7871b          	addiw	a4,a5,-1
     fde:	fce42623          	sw	a4,-52(s0)
     fe2:	f7dd                	bnez	a5,f90 <memcmp+0x26>
  }
  return 0;
     fe4:	4781                	li	a5,0
}
     fe6:	853e                	mv	a0,a5
     fe8:	7462                	ld	s0,56(sp)
     fea:	6121                	addi	sp,sp,64
     fec:	8082                	ret

0000000000000fee <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     fee:	7179                	addi	sp,sp,-48
     ff0:	f406                	sd	ra,40(sp)
     ff2:	f022                	sd	s0,32(sp)
     ff4:	1800                	addi	s0,sp,48
     ff6:	fea43423          	sd	a0,-24(s0)
     ffa:	feb43023          	sd	a1,-32(s0)
     ffe:	87b2                	mv	a5,a2
    1000:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
    1004:	fdc42783          	lw	a5,-36(s0)
    1008:	863e                	mv	a2,a5
    100a:	fe043583          	ld	a1,-32(s0)
    100e:	fe843503          	ld	a0,-24(s0)
    1012:	00000097          	auipc	ra,0x0
    1016:	e96080e7          	jalr	-362(ra) # ea8 <memmove>
    101a:	87aa                	mv	a5,a0
}
    101c:	853e                	mv	a0,a5
    101e:	70a2                	ld	ra,40(sp)
    1020:	7402                	ld	s0,32(sp)
    1022:	6145                	addi	sp,sp,48
    1024:	8082                	ret

0000000000001026 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    1026:	4885                	li	a7,1
 ecall
    1028:	00000073          	ecall
 ret
    102c:	8082                	ret

000000000000102e <exit>:
.global exit
exit:
 li a7, SYS_exit
    102e:	4889                	li	a7,2
 ecall
    1030:	00000073          	ecall
 ret
    1034:	8082                	ret

0000000000001036 <wait>:
.global wait
wait:
 li a7, SYS_wait
    1036:	488d                	li	a7,3
 ecall
    1038:	00000073          	ecall
 ret
    103c:	8082                	ret

000000000000103e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    103e:	4891                	li	a7,4
 ecall
    1040:	00000073          	ecall
 ret
    1044:	8082                	ret

0000000000001046 <read>:
.global read
read:
 li a7, SYS_read
    1046:	4895                	li	a7,5
 ecall
    1048:	00000073          	ecall
 ret
    104c:	8082                	ret

000000000000104e <write>:
.global write
write:
 li a7, SYS_write
    104e:	48c1                	li	a7,16
 ecall
    1050:	00000073          	ecall
 ret
    1054:	8082                	ret

0000000000001056 <close>:
.global close
close:
 li a7, SYS_close
    1056:	48d5                	li	a7,21
 ecall
    1058:	00000073          	ecall
 ret
    105c:	8082                	ret

000000000000105e <kill>:
.global kill
kill:
 li a7, SYS_kill
    105e:	4899                	li	a7,6
 ecall
    1060:	00000073          	ecall
 ret
    1064:	8082                	ret

0000000000001066 <exec>:
.global exec
exec:
 li a7, SYS_exec
    1066:	489d                	li	a7,7
 ecall
    1068:	00000073          	ecall
 ret
    106c:	8082                	ret

000000000000106e <open>:
.global open
open:
 li a7, SYS_open
    106e:	48bd                	li	a7,15
 ecall
    1070:	00000073          	ecall
 ret
    1074:	8082                	ret

0000000000001076 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    1076:	48c5                	li	a7,17
 ecall
    1078:	00000073          	ecall
 ret
    107c:	8082                	ret

000000000000107e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    107e:	48c9                	li	a7,18
 ecall
    1080:	00000073          	ecall
 ret
    1084:	8082                	ret

0000000000001086 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    1086:	48a1                	li	a7,8
 ecall
    1088:	00000073          	ecall
 ret
    108c:	8082                	ret

000000000000108e <link>:
.global link
link:
 li a7, SYS_link
    108e:	48cd                	li	a7,19
 ecall
    1090:	00000073          	ecall
 ret
    1094:	8082                	ret

0000000000001096 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    1096:	48d1                	li	a7,20
 ecall
    1098:	00000073          	ecall
 ret
    109c:	8082                	ret

000000000000109e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    109e:	48a5                	li	a7,9
 ecall
    10a0:	00000073          	ecall
 ret
    10a4:	8082                	ret

00000000000010a6 <dup>:
.global dup
dup:
 li a7, SYS_dup
    10a6:	48a9                	li	a7,10
 ecall
    10a8:	00000073          	ecall
 ret
    10ac:	8082                	ret

00000000000010ae <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    10ae:	48ad                	li	a7,11
 ecall
    10b0:	00000073          	ecall
 ret
    10b4:	8082                	ret

00000000000010b6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    10b6:	48b1                	li	a7,12
 ecall
    10b8:	00000073          	ecall
 ret
    10bc:	8082                	ret

00000000000010be <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    10be:	48b5                	li	a7,13
 ecall
    10c0:	00000073          	ecall
 ret
    10c4:	8082                	ret

00000000000010c6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    10c6:	48b9                	li	a7,14
 ecall
    10c8:	00000073          	ecall
 ret
    10cc:	8082                	ret

00000000000010ce <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
    10ce:	48d9                	li	a7,22
 ecall
    10d0:	00000073          	ecall
 ret
    10d4:	8082                	ret

00000000000010d6 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
    10d6:	48dd                	li	a7,23
 ecall
    10d8:	00000073          	ecall
 ret
    10dc:	8082                	ret

00000000000010de <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
    10de:	48e1                	li	a7,24
 ecall
    10e0:	00000073          	ecall
 ret
    10e4:	8082                	ret

00000000000010e6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    10e6:	1101                	addi	sp,sp,-32
    10e8:	ec06                	sd	ra,24(sp)
    10ea:	e822                	sd	s0,16(sp)
    10ec:	1000                	addi	s0,sp,32
    10ee:	87aa                	mv	a5,a0
    10f0:	872e                	mv	a4,a1
    10f2:	fef42623          	sw	a5,-20(s0)
    10f6:	87ba                	mv	a5,a4
    10f8:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
    10fc:	feb40713          	addi	a4,s0,-21
    1100:	fec42783          	lw	a5,-20(s0)
    1104:	4605                	li	a2,1
    1106:	85ba                	mv	a1,a4
    1108:	853e                	mv	a0,a5
    110a:	00000097          	auipc	ra,0x0
    110e:	f44080e7          	jalr	-188(ra) # 104e <write>
}
    1112:	0001                	nop
    1114:	60e2                	ld	ra,24(sp)
    1116:	6442                	ld	s0,16(sp)
    1118:	6105                	addi	sp,sp,32
    111a:	8082                	ret

000000000000111c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    111c:	7139                	addi	sp,sp,-64
    111e:	fc06                	sd	ra,56(sp)
    1120:	f822                	sd	s0,48(sp)
    1122:	0080                	addi	s0,sp,64
    1124:	87aa                	mv	a5,a0
    1126:	8736                	mv	a4,a3
    1128:	fcf42623          	sw	a5,-52(s0)
    112c:	87ae                	mv	a5,a1
    112e:	fcf42423          	sw	a5,-56(s0)
    1132:	87b2                	mv	a5,a2
    1134:	fcf42223          	sw	a5,-60(s0)
    1138:	87ba                	mv	a5,a4
    113a:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    113e:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
    1142:	fc042783          	lw	a5,-64(s0)
    1146:	2781                	sext.w	a5,a5
    1148:	c38d                	beqz	a5,116a <printint+0x4e>
    114a:	fc842783          	lw	a5,-56(s0)
    114e:	2781                	sext.w	a5,a5
    1150:	0007dd63          	bgez	a5,116a <printint+0x4e>
    neg = 1;
    1154:	4785                	li	a5,1
    1156:	fef42423          	sw	a5,-24(s0)
    x = -xx;
    115a:	fc842783          	lw	a5,-56(s0)
    115e:	40f007bb          	negw	a5,a5
    1162:	2781                	sext.w	a5,a5
    1164:	fef42223          	sw	a5,-28(s0)
    1168:	a029                	j	1172 <printint+0x56>
  } else {
    x = xx;
    116a:	fc842783          	lw	a5,-56(s0)
    116e:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
    1172:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
    1176:	fc442783          	lw	a5,-60(s0)
    117a:	fe442703          	lw	a4,-28(s0)
    117e:	02f777bb          	remuw	a5,a4,a5
    1182:	0007861b          	sext.w	a2,a5
    1186:	fec42783          	lw	a5,-20(s0)
    118a:	0017871b          	addiw	a4,a5,1
    118e:	fee42623          	sw	a4,-20(s0)
    1192:	00001697          	auipc	a3,0x1
    1196:	fe668693          	addi	a3,a3,-26 # 2178 <digits>
    119a:	02061713          	slli	a4,a2,0x20
    119e:	9301                	srli	a4,a4,0x20
    11a0:	9736                	add	a4,a4,a3
    11a2:	00074703          	lbu	a4,0(a4)
    11a6:	ff040693          	addi	a3,s0,-16
    11aa:	97b6                	add	a5,a5,a3
    11ac:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
    11b0:	fc442783          	lw	a5,-60(s0)
    11b4:	fe442703          	lw	a4,-28(s0)
    11b8:	02f757bb          	divuw	a5,a4,a5
    11bc:	fef42223          	sw	a5,-28(s0)
    11c0:	fe442783          	lw	a5,-28(s0)
    11c4:	2781                	sext.w	a5,a5
    11c6:	fbc5                	bnez	a5,1176 <printint+0x5a>
  if(neg)
    11c8:	fe842783          	lw	a5,-24(s0)
    11cc:	2781                	sext.w	a5,a5
    11ce:	cf95                	beqz	a5,120a <printint+0xee>
    buf[i++] = '-';
    11d0:	fec42783          	lw	a5,-20(s0)
    11d4:	0017871b          	addiw	a4,a5,1
    11d8:	fee42623          	sw	a4,-20(s0)
    11dc:	ff040713          	addi	a4,s0,-16
    11e0:	97ba                	add	a5,a5,a4
    11e2:	02d00713          	li	a4,45
    11e6:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
    11ea:	a005                	j	120a <printint+0xee>
    putc(fd, buf[i]);
    11ec:	fec42783          	lw	a5,-20(s0)
    11f0:	ff040713          	addi	a4,s0,-16
    11f4:	97ba                	add	a5,a5,a4
    11f6:	fe07c703          	lbu	a4,-32(a5)
    11fa:	fcc42783          	lw	a5,-52(s0)
    11fe:	85ba                	mv	a1,a4
    1200:	853e                	mv	a0,a5
    1202:	00000097          	auipc	ra,0x0
    1206:	ee4080e7          	jalr	-284(ra) # 10e6 <putc>
  while(--i >= 0)
    120a:	fec42783          	lw	a5,-20(s0)
    120e:	37fd                	addiw	a5,a5,-1
    1210:	fef42623          	sw	a5,-20(s0)
    1214:	fec42783          	lw	a5,-20(s0)
    1218:	2781                	sext.w	a5,a5
    121a:	fc07d9e3          	bgez	a5,11ec <printint+0xd0>
}
    121e:	0001                	nop
    1220:	0001                	nop
    1222:	70e2                	ld	ra,56(sp)
    1224:	7442                	ld	s0,48(sp)
    1226:	6121                	addi	sp,sp,64
    1228:	8082                	ret

000000000000122a <printptr>:

static void
printptr(int fd, uint64 x) {
    122a:	7179                	addi	sp,sp,-48
    122c:	f406                	sd	ra,40(sp)
    122e:	f022                	sd	s0,32(sp)
    1230:	1800                	addi	s0,sp,48
    1232:	87aa                	mv	a5,a0
    1234:	fcb43823          	sd	a1,-48(s0)
    1238:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
    123c:	fdc42783          	lw	a5,-36(s0)
    1240:	03000593          	li	a1,48
    1244:	853e                	mv	a0,a5
    1246:	00000097          	auipc	ra,0x0
    124a:	ea0080e7          	jalr	-352(ra) # 10e6 <putc>
  putc(fd, 'x');
    124e:	fdc42783          	lw	a5,-36(s0)
    1252:	07800593          	li	a1,120
    1256:	853e                	mv	a0,a5
    1258:	00000097          	auipc	ra,0x0
    125c:	e8e080e7          	jalr	-370(ra) # 10e6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1260:	fe042623          	sw	zero,-20(s0)
    1264:	a82d                	j	129e <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1266:	fd043783          	ld	a5,-48(s0)
    126a:	93f1                	srli	a5,a5,0x3c
    126c:	00001717          	auipc	a4,0x1
    1270:	f0c70713          	addi	a4,a4,-244 # 2178 <digits>
    1274:	97ba                	add	a5,a5,a4
    1276:	0007c703          	lbu	a4,0(a5)
    127a:	fdc42783          	lw	a5,-36(s0)
    127e:	85ba                	mv	a1,a4
    1280:	853e                	mv	a0,a5
    1282:	00000097          	auipc	ra,0x0
    1286:	e64080e7          	jalr	-412(ra) # 10e6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    128a:	fec42783          	lw	a5,-20(s0)
    128e:	2785                	addiw	a5,a5,1
    1290:	fef42623          	sw	a5,-20(s0)
    1294:	fd043783          	ld	a5,-48(s0)
    1298:	0792                	slli	a5,a5,0x4
    129a:	fcf43823          	sd	a5,-48(s0)
    129e:	fec42783          	lw	a5,-20(s0)
    12a2:	873e                	mv	a4,a5
    12a4:	47bd                	li	a5,15
    12a6:	fce7f0e3          	bgeu	a5,a4,1266 <printptr+0x3c>
}
    12aa:	0001                	nop
    12ac:	0001                	nop
    12ae:	70a2                	ld	ra,40(sp)
    12b0:	7402                	ld	s0,32(sp)
    12b2:	6145                	addi	sp,sp,48
    12b4:	8082                	ret

00000000000012b6 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    12b6:	715d                	addi	sp,sp,-80
    12b8:	e486                	sd	ra,72(sp)
    12ba:	e0a2                	sd	s0,64(sp)
    12bc:	0880                	addi	s0,sp,80
    12be:	87aa                	mv	a5,a0
    12c0:	fcb43023          	sd	a1,-64(s0)
    12c4:	fac43c23          	sd	a2,-72(s0)
    12c8:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
    12cc:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    12d0:	fe042223          	sw	zero,-28(s0)
    12d4:	a42d                	j	14fe <vprintf+0x248>
    c = fmt[i] & 0xff;
    12d6:	fe442783          	lw	a5,-28(s0)
    12da:	fc043703          	ld	a4,-64(s0)
    12de:	97ba                	add	a5,a5,a4
    12e0:	0007c783          	lbu	a5,0(a5)
    12e4:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
    12e8:	fe042783          	lw	a5,-32(s0)
    12ec:	2781                	sext.w	a5,a5
    12ee:	eb9d                	bnez	a5,1324 <vprintf+0x6e>
      if(c == '%'){
    12f0:	fdc42783          	lw	a5,-36(s0)
    12f4:	0007871b          	sext.w	a4,a5
    12f8:	02500793          	li	a5,37
    12fc:	00f71763          	bne	a4,a5,130a <vprintf+0x54>
        state = '%';
    1300:	02500793          	li	a5,37
    1304:	fef42023          	sw	a5,-32(s0)
    1308:	a2f5                	j	14f4 <vprintf+0x23e>
      } else {
        putc(fd, c);
    130a:	fdc42783          	lw	a5,-36(s0)
    130e:	0ff7f713          	andi	a4,a5,255
    1312:	fcc42783          	lw	a5,-52(s0)
    1316:	85ba                	mv	a1,a4
    1318:	853e                	mv	a0,a5
    131a:	00000097          	auipc	ra,0x0
    131e:	dcc080e7          	jalr	-564(ra) # 10e6 <putc>
    1322:	aac9                	j	14f4 <vprintf+0x23e>
      }
    } else if(state == '%'){
    1324:	fe042783          	lw	a5,-32(s0)
    1328:	0007871b          	sext.w	a4,a5
    132c:	02500793          	li	a5,37
    1330:	1cf71263          	bne	a4,a5,14f4 <vprintf+0x23e>
      if(c == 'd'){
    1334:	fdc42783          	lw	a5,-36(s0)
    1338:	0007871b          	sext.w	a4,a5
    133c:	06400793          	li	a5,100
    1340:	02f71463          	bne	a4,a5,1368 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
    1344:	fb843783          	ld	a5,-72(s0)
    1348:	00878713          	addi	a4,a5,8
    134c:	fae43c23          	sd	a4,-72(s0)
    1350:	4398                	lw	a4,0(a5)
    1352:	fcc42783          	lw	a5,-52(s0)
    1356:	4685                	li	a3,1
    1358:	4629                	li	a2,10
    135a:	85ba                	mv	a1,a4
    135c:	853e                	mv	a0,a5
    135e:	00000097          	auipc	ra,0x0
    1362:	dbe080e7          	jalr	-578(ra) # 111c <printint>
    1366:	a269                	j	14f0 <vprintf+0x23a>
      } else if(c == 'l') {
    1368:	fdc42783          	lw	a5,-36(s0)
    136c:	0007871b          	sext.w	a4,a5
    1370:	06c00793          	li	a5,108
    1374:	02f71663          	bne	a4,a5,13a0 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1378:	fb843783          	ld	a5,-72(s0)
    137c:	00878713          	addi	a4,a5,8
    1380:	fae43c23          	sd	a4,-72(s0)
    1384:	639c                	ld	a5,0(a5)
    1386:	0007871b          	sext.w	a4,a5
    138a:	fcc42783          	lw	a5,-52(s0)
    138e:	4681                	li	a3,0
    1390:	4629                	li	a2,10
    1392:	85ba                	mv	a1,a4
    1394:	853e                	mv	a0,a5
    1396:	00000097          	auipc	ra,0x0
    139a:	d86080e7          	jalr	-634(ra) # 111c <printint>
    139e:	aa89                	j	14f0 <vprintf+0x23a>
      } else if(c == 'x') {
    13a0:	fdc42783          	lw	a5,-36(s0)
    13a4:	0007871b          	sext.w	a4,a5
    13a8:	07800793          	li	a5,120
    13ac:	02f71463          	bne	a4,a5,13d4 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
    13b0:	fb843783          	ld	a5,-72(s0)
    13b4:	00878713          	addi	a4,a5,8
    13b8:	fae43c23          	sd	a4,-72(s0)
    13bc:	4398                	lw	a4,0(a5)
    13be:	fcc42783          	lw	a5,-52(s0)
    13c2:	4681                	li	a3,0
    13c4:	4641                	li	a2,16
    13c6:	85ba                	mv	a1,a4
    13c8:	853e                	mv	a0,a5
    13ca:	00000097          	auipc	ra,0x0
    13ce:	d52080e7          	jalr	-686(ra) # 111c <printint>
    13d2:	aa39                	j	14f0 <vprintf+0x23a>
      } else if(c == 'p') {
    13d4:	fdc42783          	lw	a5,-36(s0)
    13d8:	0007871b          	sext.w	a4,a5
    13dc:	07000793          	li	a5,112
    13e0:	02f71263          	bne	a4,a5,1404 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
    13e4:	fb843783          	ld	a5,-72(s0)
    13e8:	00878713          	addi	a4,a5,8
    13ec:	fae43c23          	sd	a4,-72(s0)
    13f0:	6398                	ld	a4,0(a5)
    13f2:	fcc42783          	lw	a5,-52(s0)
    13f6:	85ba                	mv	a1,a4
    13f8:	853e                	mv	a0,a5
    13fa:	00000097          	auipc	ra,0x0
    13fe:	e30080e7          	jalr	-464(ra) # 122a <printptr>
    1402:	a0fd                	j	14f0 <vprintf+0x23a>
      } else if(c == 's'){
    1404:	fdc42783          	lw	a5,-36(s0)
    1408:	0007871b          	sext.w	a4,a5
    140c:	07300793          	li	a5,115
    1410:	04f71c63          	bne	a4,a5,1468 <vprintf+0x1b2>
        s = va_arg(ap, char*);
    1414:	fb843783          	ld	a5,-72(s0)
    1418:	00878713          	addi	a4,a5,8
    141c:	fae43c23          	sd	a4,-72(s0)
    1420:	639c                	ld	a5,0(a5)
    1422:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
    1426:	fe843783          	ld	a5,-24(s0)
    142a:	eb8d                	bnez	a5,145c <vprintf+0x1a6>
          s = "(null)";
    142c:	00001797          	auipc	a5,0x1
    1430:	d2478793          	addi	a5,a5,-732 # 2150 <schedule_dm+0x34c>
    1434:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    1438:	a015                	j	145c <vprintf+0x1a6>
          putc(fd, *s);
    143a:	fe843783          	ld	a5,-24(s0)
    143e:	0007c703          	lbu	a4,0(a5)
    1442:	fcc42783          	lw	a5,-52(s0)
    1446:	85ba                	mv	a1,a4
    1448:	853e                	mv	a0,a5
    144a:	00000097          	auipc	ra,0x0
    144e:	c9c080e7          	jalr	-868(ra) # 10e6 <putc>
          s++;
    1452:	fe843783          	ld	a5,-24(s0)
    1456:	0785                	addi	a5,a5,1
    1458:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    145c:	fe843783          	ld	a5,-24(s0)
    1460:	0007c783          	lbu	a5,0(a5)
    1464:	fbf9                	bnez	a5,143a <vprintf+0x184>
    1466:	a069                	j	14f0 <vprintf+0x23a>
        }
      } else if(c == 'c'){
    1468:	fdc42783          	lw	a5,-36(s0)
    146c:	0007871b          	sext.w	a4,a5
    1470:	06300793          	li	a5,99
    1474:	02f71463          	bne	a4,a5,149c <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
    1478:	fb843783          	ld	a5,-72(s0)
    147c:	00878713          	addi	a4,a5,8
    1480:	fae43c23          	sd	a4,-72(s0)
    1484:	439c                	lw	a5,0(a5)
    1486:	0ff7f713          	andi	a4,a5,255
    148a:	fcc42783          	lw	a5,-52(s0)
    148e:	85ba                	mv	a1,a4
    1490:	853e                	mv	a0,a5
    1492:	00000097          	auipc	ra,0x0
    1496:	c54080e7          	jalr	-940(ra) # 10e6 <putc>
    149a:	a899                	j	14f0 <vprintf+0x23a>
      } else if(c == '%'){
    149c:	fdc42783          	lw	a5,-36(s0)
    14a0:	0007871b          	sext.w	a4,a5
    14a4:	02500793          	li	a5,37
    14a8:	00f71f63          	bne	a4,a5,14c6 <vprintf+0x210>
        putc(fd, c);
    14ac:	fdc42783          	lw	a5,-36(s0)
    14b0:	0ff7f713          	andi	a4,a5,255
    14b4:	fcc42783          	lw	a5,-52(s0)
    14b8:	85ba                	mv	a1,a4
    14ba:	853e                	mv	a0,a5
    14bc:	00000097          	auipc	ra,0x0
    14c0:	c2a080e7          	jalr	-982(ra) # 10e6 <putc>
    14c4:	a035                	j	14f0 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    14c6:	fcc42783          	lw	a5,-52(s0)
    14ca:	02500593          	li	a1,37
    14ce:	853e                	mv	a0,a5
    14d0:	00000097          	auipc	ra,0x0
    14d4:	c16080e7          	jalr	-1002(ra) # 10e6 <putc>
        putc(fd, c);
    14d8:	fdc42783          	lw	a5,-36(s0)
    14dc:	0ff7f713          	andi	a4,a5,255
    14e0:	fcc42783          	lw	a5,-52(s0)
    14e4:	85ba                	mv	a1,a4
    14e6:	853e                	mv	a0,a5
    14e8:	00000097          	auipc	ra,0x0
    14ec:	bfe080e7          	jalr	-1026(ra) # 10e6 <putc>
      }
      state = 0;
    14f0:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    14f4:	fe442783          	lw	a5,-28(s0)
    14f8:	2785                	addiw	a5,a5,1
    14fa:	fef42223          	sw	a5,-28(s0)
    14fe:	fe442783          	lw	a5,-28(s0)
    1502:	fc043703          	ld	a4,-64(s0)
    1506:	97ba                	add	a5,a5,a4
    1508:	0007c783          	lbu	a5,0(a5)
    150c:	dc0795e3          	bnez	a5,12d6 <vprintf+0x20>
    }
  }
}
    1510:	0001                	nop
    1512:	0001                	nop
    1514:	60a6                	ld	ra,72(sp)
    1516:	6406                	ld	s0,64(sp)
    1518:	6161                	addi	sp,sp,80
    151a:	8082                	ret

000000000000151c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    151c:	7159                	addi	sp,sp,-112
    151e:	fc06                	sd	ra,56(sp)
    1520:	f822                	sd	s0,48(sp)
    1522:	0080                	addi	s0,sp,64
    1524:	fcb43823          	sd	a1,-48(s0)
    1528:	e010                	sd	a2,0(s0)
    152a:	e414                	sd	a3,8(s0)
    152c:	e818                	sd	a4,16(s0)
    152e:	ec1c                	sd	a5,24(s0)
    1530:	03043023          	sd	a6,32(s0)
    1534:	03143423          	sd	a7,40(s0)
    1538:	87aa                	mv	a5,a0
    153a:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
    153e:	03040793          	addi	a5,s0,48
    1542:	fcf43423          	sd	a5,-56(s0)
    1546:	fc843783          	ld	a5,-56(s0)
    154a:	fd078793          	addi	a5,a5,-48
    154e:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
    1552:	fe843703          	ld	a4,-24(s0)
    1556:	fdc42783          	lw	a5,-36(s0)
    155a:	863a                	mv	a2,a4
    155c:	fd043583          	ld	a1,-48(s0)
    1560:	853e                	mv	a0,a5
    1562:	00000097          	auipc	ra,0x0
    1566:	d54080e7          	jalr	-684(ra) # 12b6 <vprintf>
}
    156a:	0001                	nop
    156c:	70e2                	ld	ra,56(sp)
    156e:	7442                	ld	s0,48(sp)
    1570:	6165                	addi	sp,sp,112
    1572:	8082                	ret

0000000000001574 <printf>:

void
printf(const char *fmt, ...)
{
    1574:	7159                	addi	sp,sp,-112
    1576:	f406                	sd	ra,40(sp)
    1578:	f022                	sd	s0,32(sp)
    157a:	1800                	addi	s0,sp,48
    157c:	fca43c23          	sd	a0,-40(s0)
    1580:	e40c                	sd	a1,8(s0)
    1582:	e810                	sd	a2,16(s0)
    1584:	ec14                	sd	a3,24(s0)
    1586:	f018                	sd	a4,32(s0)
    1588:	f41c                	sd	a5,40(s0)
    158a:	03043823          	sd	a6,48(s0)
    158e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1592:	04040793          	addi	a5,s0,64
    1596:	fcf43823          	sd	a5,-48(s0)
    159a:	fd043783          	ld	a5,-48(s0)
    159e:	fc878793          	addi	a5,a5,-56
    15a2:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
    15a6:	fe843783          	ld	a5,-24(s0)
    15aa:	863e                	mv	a2,a5
    15ac:	fd843583          	ld	a1,-40(s0)
    15b0:	4505                	li	a0,1
    15b2:	00000097          	auipc	ra,0x0
    15b6:	d04080e7          	jalr	-764(ra) # 12b6 <vprintf>
}
    15ba:	0001                	nop
    15bc:	70a2                	ld	ra,40(sp)
    15be:	7402                	ld	s0,32(sp)
    15c0:	6165                	addi	sp,sp,112
    15c2:	8082                	ret

00000000000015c4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    15c4:	7179                	addi	sp,sp,-48
    15c6:	f422                	sd	s0,40(sp)
    15c8:	1800                	addi	s0,sp,48
    15ca:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    15ce:	fd843783          	ld	a5,-40(s0)
    15d2:	17c1                	addi	a5,a5,-16
    15d4:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15d8:	00001797          	auipc	a5,0x1
    15dc:	be878793          	addi	a5,a5,-1048 # 21c0 <freep>
    15e0:	639c                	ld	a5,0(a5)
    15e2:	fef43423          	sd	a5,-24(s0)
    15e6:	a815                	j	161a <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15e8:	fe843783          	ld	a5,-24(s0)
    15ec:	639c                	ld	a5,0(a5)
    15ee:	fe843703          	ld	a4,-24(s0)
    15f2:	00f76f63          	bltu	a4,a5,1610 <free+0x4c>
    15f6:	fe043703          	ld	a4,-32(s0)
    15fa:	fe843783          	ld	a5,-24(s0)
    15fe:	02e7eb63          	bltu	a5,a4,1634 <free+0x70>
    1602:	fe843783          	ld	a5,-24(s0)
    1606:	639c                	ld	a5,0(a5)
    1608:	fe043703          	ld	a4,-32(s0)
    160c:	02f76463          	bltu	a4,a5,1634 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1610:	fe843783          	ld	a5,-24(s0)
    1614:	639c                	ld	a5,0(a5)
    1616:	fef43423          	sd	a5,-24(s0)
    161a:	fe043703          	ld	a4,-32(s0)
    161e:	fe843783          	ld	a5,-24(s0)
    1622:	fce7f3e3          	bgeu	a5,a4,15e8 <free+0x24>
    1626:	fe843783          	ld	a5,-24(s0)
    162a:	639c                	ld	a5,0(a5)
    162c:	fe043703          	ld	a4,-32(s0)
    1630:	faf77ce3          	bgeu	a4,a5,15e8 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1634:	fe043783          	ld	a5,-32(s0)
    1638:	479c                	lw	a5,8(a5)
    163a:	1782                	slli	a5,a5,0x20
    163c:	9381                	srli	a5,a5,0x20
    163e:	0792                	slli	a5,a5,0x4
    1640:	fe043703          	ld	a4,-32(s0)
    1644:	973e                	add	a4,a4,a5
    1646:	fe843783          	ld	a5,-24(s0)
    164a:	639c                	ld	a5,0(a5)
    164c:	02f71763          	bne	a4,a5,167a <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
    1650:	fe043783          	ld	a5,-32(s0)
    1654:	4798                	lw	a4,8(a5)
    1656:	fe843783          	ld	a5,-24(s0)
    165a:	639c                	ld	a5,0(a5)
    165c:	479c                	lw	a5,8(a5)
    165e:	9fb9                	addw	a5,a5,a4
    1660:	0007871b          	sext.w	a4,a5
    1664:	fe043783          	ld	a5,-32(s0)
    1668:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
    166a:	fe843783          	ld	a5,-24(s0)
    166e:	639c                	ld	a5,0(a5)
    1670:	6398                	ld	a4,0(a5)
    1672:	fe043783          	ld	a5,-32(s0)
    1676:	e398                	sd	a4,0(a5)
    1678:	a039                	j	1686 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
    167a:	fe843783          	ld	a5,-24(s0)
    167e:	6398                	ld	a4,0(a5)
    1680:	fe043783          	ld	a5,-32(s0)
    1684:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
    1686:	fe843783          	ld	a5,-24(s0)
    168a:	479c                	lw	a5,8(a5)
    168c:	1782                	slli	a5,a5,0x20
    168e:	9381                	srli	a5,a5,0x20
    1690:	0792                	slli	a5,a5,0x4
    1692:	fe843703          	ld	a4,-24(s0)
    1696:	97ba                	add	a5,a5,a4
    1698:	fe043703          	ld	a4,-32(s0)
    169c:	02f71563          	bne	a4,a5,16c6 <free+0x102>
    p->s.size += bp->s.size;
    16a0:	fe843783          	ld	a5,-24(s0)
    16a4:	4798                	lw	a4,8(a5)
    16a6:	fe043783          	ld	a5,-32(s0)
    16aa:	479c                	lw	a5,8(a5)
    16ac:	9fb9                	addw	a5,a5,a4
    16ae:	0007871b          	sext.w	a4,a5
    16b2:	fe843783          	ld	a5,-24(s0)
    16b6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    16b8:	fe043783          	ld	a5,-32(s0)
    16bc:	6398                	ld	a4,0(a5)
    16be:	fe843783          	ld	a5,-24(s0)
    16c2:	e398                	sd	a4,0(a5)
    16c4:	a031                	j	16d0 <free+0x10c>
  } else
    p->s.ptr = bp;
    16c6:	fe843783          	ld	a5,-24(s0)
    16ca:	fe043703          	ld	a4,-32(s0)
    16ce:	e398                	sd	a4,0(a5)
  freep = p;
    16d0:	00001797          	auipc	a5,0x1
    16d4:	af078793          	addi	a5,a5,-1296 # 21c0 <freep>
    16d8:	fe843703          	ld	a4,-24(s0)
    16dc:	e398                	sd	a4,0(a5)
}
    16de:	0001                	nop
    16e0:	7422                	ld	s0,40(sp)
    16e2:	6145                	addi	sp,sp,48
    16e4:	8082                	ret

00000000000016e6 <morecore>:

static Header*
morecore(uint nu)
{
    16e6:	7179                	addi	sp,sp,-48
    16e8:	f406                	sd	ra,40(sp)
    16ea:	f022                	sd	s0,32(sp)
    16ec:	1800                	addi	s0,sp,48
    16ee:	87aa                	mv	a5,a0
    16f0:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    16f4:	fdc42783          	lw	a5,-36(s0)
    16f8:	0007871b          	sext.w	a4,a5
    16fc:	6785                	lui	a5,0x1
    16fe:	00f77563          	bgeu	a4,a5,1708 <morecore+0x22>
    nu = 4096;
    1702:	6785                	lui	a5,0x1
    1704:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    1708:	fdc42783          	lw	a5,-36(s0)
    170c:	0047979b          	slliw	a5,a5,0x4
    1710:	2781                	sext.w	a5,a5
    1712:	2781                	sext.w	a5,a5
    1714:	853e                	mv	a0,a5
    1716:	00000097          	auipc	ra,0x0
    171a:	9a0080e7          	jalr	-1632(ra) # 10b6 <sbrk>
    171e:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
    1722:	fe843703          	ld	a4,-24(s0)
    1726:	57fd                	li	a5,-1
    1728:	00f71463          	bne	a4,a5,1730 <morecore+0x4a>
    return 0;
    172c:	4781                	li	a5,0
    172e:	a03d                	j	175c <morecore+0x76>
  hp = (Header*)p;
    1730:	fe843783          	ld	a5,-24(s0)
    1734:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    1738:	fe043783          	ld	a5,-32(s0)
    173c:	fdc42703          	lw	a4,-36(s0)
    1740:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    1742:	fe043783          	ld	a5,-32(s0)
    1746:	07c1                	addi	a5,a5,16
    1748:	853e                	mv	a0,a5
    174a:	00000097          	auipc	ra,0x0
    174e:	e7a080e7          	jalr	-390(ra) # 15c4 <free>
  return freep;
    1752:	00001797          	auipc	a5,0x1
    1756:	a6e78793          	addi	a5,a5,-1426 # 21c0 <freep>
    175a:	639c                	ld	a5,0(a5)
}
    175c:	853e                	mv	a0,a5
    175e:	70a2                	ld	ra,40(sp)
    1760:	7402                	ld	s0,32(sp)
    1762:	6145                	addi	sp,sp,48
    1764:	8082                	ret

0000000000001766 <malloc>:

void*
malloc(uint nbytes)
{
    1766:	7139                	addi	sp,sp,-64
    1768:	fc06                	sd	ra,56(sp)
    176a:	f822                	sd	s0,48(sp)
    176c:	0080                	addi	s0,sp,64
    176e:	87aa                	mv	a5,a0
    1770:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1774:	fcc46783          	lwu	a5,-52(s0)
    1778:	07bd                	addi	a5,a5,15
    177a:	8391                	srli	a5,a5,0x4
    177c:	2781                	sext.w	a5,a5
    177e:	2785                	addiw	a5,a5,1
    1780:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    1784:	00001797          	auipc	a5,0x1
    1788:	a3c78793          	addi	a5,a5,-1476 # 21c0 <freep>
    178c:	639c                	ld	a5,0(a5)
    178e:	fef43023          	sd	a5,-32(s0)
    1792:	fe043783          	ld	a5,-32(s0)
    1796:	ef95                	bnez	a5,17d2 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    1798:	00001797          	auipc	a5,0x1
    179c:	a1878793          	addi	a5,a5,-1512 # 21b0 <base>
    17a0:	fef43023          	sd	a5,-32(s0)
    17a4:	00001797          	auipc	a5,0x1
    17a8:	a1c78793          	addi	a5,a5,-1508 # 21c0 <freep>
    17ac:	fe043703          	ld	a4,-32(s0)
    17b0:	e398                	sd	a4,0(a5)
    17b2:	00001797          	auipc	a5,0x1
    17b6:	a0e78793          	addi	a5,a5,-1522 # 21c0 <freep>
    17ba:	6398                	ld	a4,0(a5)
    17bc:	00001797          	auipc	a5,0x1
    17c0:	9f478793          	addi	a5,a5,-1548 # 21b0 <base>
    17c4:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    17c6:	00001797          	auipc	a5,0x1
    17ca:	9ea78793          	addi	a5,a5,-1558 # 21b0 <base>
    17ce:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17d2:	fe043783          	ld	a5,-32(s0)
    17d6:	639c                	ld	a5,0(a5)
    17d8:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    17dc:	fe843783          	ld	a5,-24(s0)
    17e0:	4798                	lw	a4,8(a5)
    17e2:	fdc42783          	lw	a5,-36(s0)
    17e6:	2781                	sext.w	a5,a5
    17e8:	06f76863          	bltu	a4,a5,1858 <malloc+0xf2>
      if(p->s.size == nunits)
    17ec:	fe843783          	ld	a5,-24(s0)
    17f0:	4798                	lw	a4,8(a5)
    17f2:	fdc42783          	lw	a5,-36(s0)
    17f6:	2781                	sext.w	a5,a5
    17f8:	00e79963          	bne	a5,a4,180a <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    17fc:	fe843783          	ld	a5,-24(s0)
    1800:	6398                	ld	a4,0(a5)
    1802:	fe043783          	ld	a5,-32(s0)
    1806:	e398                	sd	a4,0(a5)
    1808:	a82d                	j	1842 <malloc+0xdc>
      else {
        p->s.size -= nunits;
    180a:	fe843783          	ld	a5,-24(s0)
    180e:	4798                	lw	a4,8(a5)
    1810:	fdc42783          	lw	a5,-36(s0)
    1814:	40f707bb          	subw	a5,a4,a5
    1818:	0007871b          	sext.w	a4,a5
    181c:	fe843783          	ld	a5,-24(s0)
    1820:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1822:	fe843783          	ld	a5,-24(s0)
    1826:	479c                	lw	a5,8(a5)
    1828:	1782                	slli	a5,a5,0x20
    182a:	9381                	srli	a5,a5,0x20
    182c:	0792                	slli	a5,a5,0x4
    182e:	fe843703          	ld	a4,-24(s0)
    1832:	97ba                	add	a5,a5,a4
    1834:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    1838:	fe843783          	ld	a5,-24(s0)
    183c:	fdc42703          	lw	a4,-36(s0)
    1840:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    1842:	00001797          	auipc	a5,0x1
    1846:	97e78793          	addi	a5,a5,-1666 # 21c0 <freep>
    184a:	fe043703          	ld	a4,-32(s0)
    184e:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1850:	fe843783          	ld	a5,-24(s0)
    1854:	07c1                	addi	a5,a5,16
    1856:	a091                	j	189a <malloc+0x134>
    }
    if(p == freep)
    1858:	00001797          	auipc	a5,0x1
    185c:	96878793          	addi	a5,a5,-1688 # 21c0 <freep>
    1860:	639c                	ld	a5,0(a5)
    1862:	fe843703          	ld	a4,-24(s0)
    1866:	02f71063          	bne	a4,a5,1886 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
    186a:	fdc42783          	lw	a5,-36(s0)
    186e:	853e                	mv	a0,a5
    1870:	00000097          	auipc	ra,0x0
    1874:	e76080e7          	jalr	-394(ra) # 16e6 <morecore>
    1878:	fea43423          	sd	a0,-24(s0)
    187c:	fe843783          	ld	a5,-24(s0)
    1880:	e399                	bnez	a5,1886 <malloc+0x120>
        return 0;
    1882:	4781                	li	a5,0
    1884:	a819                	j	189a <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1886:	fe843783          	ld	a5,-24(s0)
    188a:	fef43023          	sd	a5,-32(s0)
    188e:	fe843783          	ld	a5,-24(s0)
    1892:	639c                	ld	a5,0(a5)
    1894:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1898:	b791                	j	17dc <malloc+0x76>
  }
}
    189a:	853e                	mv	a0,a5
    189c:	70e2                	ld	ra,56(sp)
    189e:	7442                	ld	s0,48(sp)
    18a0:	6121                	addi	sp,sp,64
    18a2:	8082                	ret

00000000000018a4 <setjmp>:
    18a4:	e100                	sd	s0,0(a0)
    18a6:	e504                	sd	s1,8(a0)
    18a8:	01253823          	sd	s2,16(a0)
    18ac:	01353c23          	sd	s3,24(a0)
    18b0:	03453023          	sd	s4,32(a0)
    18b4:	03553423          	sd	s5,40(a0)
    18b8:	03653823          	sd	s6,48(a0)
    18bc:	03753c23          	sd	s7,56(a0)
    18c0:	05853023          	sd	s8,64(a0)
    18c4:	05953423          	sd	s9,72(a0)
    18c8:	05a53823          	sd	s10,80(a0)
    18cc:	05b53c23          	sd	s11,88(a0)
    18d0:	06153023          	sd	ra,96(a0)
    18d4:	06253423          	sd	sp,104(a0)
    18d8:	4501                	li	a0,0
    18da:	8082                	ret

00000000000018dc <longjmp>:
    18dc:	6100                	ld	s0,0(a0)
    18de:	6504                	ld	s1,8(a0)
    18e0:	01053903          	ld	s2,16(a0)
    18e4:	01853983          	ld	s3,24(a0)
    18e8:	02053a03          	ld	s4,32(a0)
    18ec:	02853a83          	ld	s5,40(a0)
    18f0:	03053b03          	ld	s6,48(a0)
    18f4:	03853b83          	ld	s7,56(a0)
    18f8:	04053c03          	ld	s8,64(a0)
    18fc:	04853c83          	ld	s9,72(a0)
    1900:	05053d03          	ld	s10,80(a0)
    1904:	05853d83          	ld	s11,88(a0)
    1908:	06053083          	ld	ra,96(a0)
    190c:	06853103          	ld	sp,104(a0)
    1910:	c199                	beqz	a1,1916 <longjmp_1>
    1912:	852e                	mv	a0,a1
    1914:	8082                	ret

0000000000001916 <longjmp_1>:
    1916:	4505                	li	a0,1
    1918:	8082                	ret

000000000000191a <schedule_default>:
#define INT_MAX 2147483647
#define TIME_QUANTUM 2  // Define a base time quantum for the round-robin

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
    191a:	715d                	addi	sp,sp,-80
    191c:	e4a2                	sd	s0,72(sp)
    191e:	e0a6                	sd	s1,64(sp)
    1920:	0880                	addi	s0,sp,80
    1922:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
    1924:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
    1928:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
    192c:	649c                	ld	a5,8(s1)
    192e:	639c                	ld	a5,0(a5)
    1930:	fcf43c23          	sd	a5,-40(s0)
    1934:	fd843783          	ld	a5,-40(s0)
    1938:	fd878793          	addi	a5,a5,-40
    193c:	fef43023          	sd	a5,-32(s0)
    1940:	a81d                	j	1976 <schedule_default+0x5c>
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
    1942:	fe843783          	ld	a5,-24(s0)
    1946:	cb89                	beqz	a5,1958 <schedule_default+0x3e>
    1948:	fe043783          	ld	a5,-32(s0)
    194c:	5fd8                	lw	a4,60(a5)
    194e:	fe843783          	ld	a5,-24(s0)
    1952:	5fdc                	lw	a5,60(a5)
    1954:	00f75663          	bge	a4,a5,1960 <schedule_default+0x46>
            thread_with_smallest_id = th;
    1958:	fe043783          	ld	a5,-32(s0)
    195c:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
    1960:	fe043783          	ld	a5,-32(s0)
    1964:	779c                	ld	a5,40(a5)
    1966:	fcf43823          	sd	a5,-48(s0)
    196a:	fd043783          	ld	a5,-48(s0)
    196e:	fd878793          	addi	a5,a5,-40
    1972:	fef43023          	sd	a5,-32(s0)
    1976:	fe043783          	ld	a5,-32(s0)
    197a:	02878713          	addi	a4,a5,40
    197e:	649c                	ld	a5,8(s1)
    1980:	fcf711e3          	bne	a4,a5,1942 <schedule_default+0x28>
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
    1984:	fe843783          	ld	a5,-24(s0)
    1988:	cf89                	beqz	a5,19a2 <schedule_default+0x88>
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
    198a:	fe843783          	ld	a5,-24(s0)
    198e:	02878793          	addi	a5,a5,40
    1992:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
    1996:	fe843783          	ld	a5,-24(s0)
    199a:	4fbc                	lw	a5,88(a5)
    199c:	faf42c23          	sw	a5,-72(s0)
    19a0:	a039                	j	19ae <schedule_default+0x94>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
    19a2:	649c                	ld	a5,8(s1)
    19a4:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
    19a8:	4785                	li	a5,1
    19aa:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
    19ae:	fb043783          	ld	a5,-80(s0)
    19b2:	fcf43023          	sd	a5,-64(s0)
    19b6:	fb843783          	ld	a5,-72(s0)
    19ba:	fcf43423          	sd	a5,-56(s0)
    19be:	4701                	li	a4,0
    19c0:	fc043703          	ld	a4,-64(s0)
    19c4:	4781                	li	a5,0
    19c6:	fc843783          	ld	a5,-56(s0)
    19ca:	863a                	mv	a2,a4
    19cc:	86be                	mv	a3,a5
    19ce:	8732                	mv	a4,a2
    19d0:	87b6                	mv	a5,a3
}
    19d2:	853a                	mv	a0,a4
    19d4:	85be                	mv	a1,a5
    19d6:	6426                	ld	s0,72(sp)
    19d8:	6486                	ld	s1,64(sp)
    19da:	6161                	addi	sp,sp,80
    19dc:	8082                	ret

00000000000019de <schedule_wrr>:

/* MP3 Part 1 - Non-Real-Time Scheduling */
/* Weighted-Round-Robin Scheduling */
struct threads_sched_result schedule_wrr(struct threads_sched_args args)
{
    19de:	7159                	addi	sp,sp,-112
    19e0:	f4a2                	sd	s0,104(sp)
    19e2:	f0a6                	sd	s1,96(sp)
    19e4:	1880                	addi	s0,sp,112
    19e6:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the weighted round-robin scheduling algorithm
    static struct thread *last_thread = NULL;
    struct thread *selected_thread = NULL;
    19e8:	fe043423          	sd	zero,-24(s0)
    int max_priority = -1;
    19ec:	57fd                	li	a5,-1
    19ee:	fef42223          	sw	a5,-28(s0)

    // If last_thread is NULL or its remaining time is zero, reset the selection process
    if (last_thread == NULL || last_thread->remaining_time <= 0) {
    19f2:	00000797          	auipc	a5,0x0
    19f6:	7d678793          	addi	a5,a5,2006 # 21c8 <last_thread.1226>
    19fa:	639c                	ld	a5,0(a5)
    19fc:	cb89                	beqz	a5,1a0e <schedule_wrr+0x30>
    19fe:	00000797          	auipc	a5,0x0
    1a02:	7ca78793          	addi	a5,a5,1994 # 21c8 <last_thread.1226>
    1a06:	639c                	ld	a5,0(a5)
    1a08:	4fbc                	lw	a5,88(a5)
    1a0a:	00f04863          	bgtz	a5,1a1a <schedule_wrr+0x3c>
        last_thread = NULL;
    1a0e:	00000797          	auipc	a5,0x0
    1a12:	7ba78793          	addi	a5,a5,1978 # 21c8 <last_thread.1226>
    1a16:	0007b023          	sd	zero,0(a5)
    }

    struct thread *candidate = NULL;
    1a1a:	fc043c23          	sd	zero,-40(s0)
    // Select the next thread to run based on weight and ensure round-robin fairness
    list_for_each_entry(candidate, args.run_queue, thread_list) {
    1a1e:	649c                	ld	a5,8(s1)
    1a20:	639c                	ld	a5,0(a5)
    1a22:	fcf43423          	sd	a5,-56(s0)
    1a26:	fc843783          	ld	a5,-56(s0)
    1a2a:	fd878793          	addi	a5,a5,-40
    1a2e:	fcf43c23          	sd	a5,-40(s0)
    1a32:	a8a1                	j	1a8a <schedule_wrr+0xac>
        if (candidate != last_thread) {
    1a34:	00000797          	auipc	a5,0x0
    1a38:	79478793          	addi	a5,a5,1940 # 21c8 <last_thread.1226>
    1a3c:	639c                	ld	a5,0(a5)
    1a3e:	fd843703          	ld	a4,-40(s0)
    1a42:	02f70963          	beq	a4,a5,1a74 <schedule_wrr+0x96>
            int priority = candidate->weight * TIME_QUANTUM;
    1a46:	fd843783          	ld	a5,-40(s0)
    1a4a:	47bc                	lw	a5,72(a5)
    1a4c:	0017979b          	slliw	a5,a5,0x1
    1a50:	fcf42223          	sw	a5,-60(s0)
            if (priority > max_priority) {
    1a54:	fc442703          	lw	a4,-60(s0)
    1a58:	fe442783          	lw	a5,-28(s0)
    1a5c:	2701                	sext.w	a4,a4
    1a5e:	2781                	sext.w	a5,a5
    1a60:	00e7da63          	bge	a5,a4,1a74 <schedule_wrr+0x96>
                selected_thread = candidate;
    1a64:	fd843783          	ld	a5,-40(s0)
    1a68:	fef43423          	sd	a5,-24(s0)
                max_priority = priority;
    1a6c:	fc442783          	lw	a5,-60(s0)
    1a70:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(candidate, args.run_queue, thread_list) {
    1a74:	fd843783          	ld	a5,-40(s0)
    1a78:	779c                	ld	a5,40(a5)
    1a7a:	faf43c23          	sd	a5,-72(s0)
    1a7e:	fb843783          	ld	a5,-72(s0)
    1a82:	fd878793          	addi	a5,a5,-40
    1a86:	fcf43c23          	sd	a5,-40(s0)
    1a8a:	fd843783          	ld	a5,-40(s0)
    1a8e:	02878713          	addi	a4,a5,40
    1a92:	649c                	ld	a5,8(s1)
    1a94:	faf710e3          	bne	a4,a5,1a34 <schedule_wrr+0x56>
            }
        }
    }

    // Fall back to the last_thread if no other thread is selected and it still has remaining time
    if (!selected_thread && last_thread && last_thread->remaining_time > 0) {
    1a98:	fe843783          	ld	a5,-24(s0)
    1a9c:	e795                	bnez	a5,1ac8 <schedule_wrr+0xea>
    1a9e:	00000797          	auipc	a5,0x0
    1aa2:	72a78793          	addi	a5,a5,1834 # 21c8 <last_thread.1226>
    1aa6:	639c                	ld	a5,0(a5)
    1aa8:	c385                	beqz	a5,1ac8 <schedule_wrr+0xea>
    1aaa:	00000797          	auipc	a5,0x0
    1aae:	71e78793          	addi	a5,a5,1822 # 21c8 <last_thread.1226>
    1ab2:	639c                	ld	a5,0(a5)
    1ab4:	4fbc                	lw	a5,88(a5)
    1ab6:	00f05963          	blez	a5,1ac8 <schedule_wrr+0xea>
        selected_thread = last_thread;
    1aba:	00000797          	auipc	a5,0x0
    1abe:	70e78793          	addi	a5,a5,1806 # 21c8 <last_thread.1226>
    1ac2:	639c                	ld	a5,0(a5)
    1ac4:	fef43423          	sd	a5,-24(s0)
    }

    // Set the scheduling result
    if (selected_thread) {
    1ac8:	fe843783          	ld	a5,-24(s0)
    1acc:	c7b9                	beqz	a5,1b1a <schedule_wrr+0x13c>
        int time_slice = selected_thread->weight * TIME_QUANTUM;
    1ace:	fe843783          	ld	a5,-24(s0)
    1ad2:	47bc                	lw	a5,72(a5)
    1ad4:	0017979b          	slliw	a5,a5,0x1
    1ad8:	fcf42a23          	sw	a5,-44(s0)
        if (time_slice > selected_thread->remaining_time) {
    1adc:	fe843783          	ld	a5,-24(s0)
    1ae0:	4fb8                	lw	a4,88(a5)
    1ae2:	fd442783          	lw	a5,-44(s0)
    1ae6:	2781                	sext.w	a5,a5
    1ae8:	00f75763          	bge	a4,a5,1af6 <schedule_wrr+0x118>
            time_slice = selected_thread->remaining_time;
    1aec:	fe843783          	ld	a5,-24(s0)
    1af0:	4fbc                	lw	a5,88(a5)
    1af2:	fcf42a23          	sw	a5,-44(s0)
        }
        r.scheduled_thread_list_member = &selected_thread->thread_list;
    1af6:	fe843783          	ld	a5,-24(s0)
    1afa:	02878793          	addi	a5,a5,40
    1afe:	f8f43c23          	sd	a5,-104(s0)
        r.allocated_time = time_slice;
    1b02:	fd442783          	lw	a5,-44(s0)
    1b06:	faf42023          	sw	a5,-96(s0)
        last_thread = selected_thread;  // Update the last run thread
    1b0a:	00000797          	auipc	a5,0x0
    1b0e:	6be78793          	addi	a5,a5,1726 # 21c8 <last_thread.1226>
    1b12:	fe843703          	ld	a4,-24(s0)
    1b16:	e398                	sd	a4,0(a5)
    1b18:	a039                	j	1b26 <schedule_wrr+0x148>
    } else {
        // Idle if no suitable thread is found
        r.scheduled_thread_list_member = args.run_queue;
    1b1a:	649c                	ld	a5,8(s1)
    1b1c:	f8f43c23          	sd	a5,-104(s0)
        r.allocated_time = 1;
    1b20:	4785                	li	a5,1
    1b22:	faf42023          	sw	a5,-96(s0)
    }

    return r;
    1b26:	f9843783          	ld	a5,-104(s0)
    1b2a:	faf43423          	sd	a5,-88(s0)
    1b2e:	fa043783          	ld	a5,-96(s0)
    1b32:	faf43823          	sd	a5,-80(s0)
    1b36:	4701                	li	a4,0
    1b38:	fa843703          	ld	a4,-88(s0)
    1b3c:	4781                	li	a5,0
    1b3e:	fb043783          	ld	a5,-80(s0)
    1b42:	863a                	mv	a2,a4
    1b44:	86be                	mv	a3,a5
    1b46:	8732                	mv	a4,a2
    1b48:	87b6                	mv	a5,a3
}
    1b4a:	853a                	mv	a0,a4
    1b4c:	85be                	mv	a1,a5
    1b4e:	7426                	ld	s0,104(sp)
    1b50:	7486                	ld	s1,96(sp)
    1b52:	6165                	addi	sp,sp,112
    1b54:	8082                	ret

0000000000001b56 <find_next_release_time>:

/* Shortest-Job-First Scheduling */
int find_next_release_time(struct list_head *release_queue, int current_time) {
    1b56:	7139                	addi	sp,sp,-64
    1b58:	fc22                	sd	s0,56(sp)
    1b5a:	0080                	addi	s0,sp,64
    1b5c:	fca43423          	sd	a0,-56(s0)
    1b60:	87ae                	mv	a5,a1
    1b62:	fcf42223          	sw	a5,-60(s0)
    struct release_queue_entry *next_release = NULL;
    1b66:	fe043423          	sd	zero,-24(s0)
    int next_release_time = INT_MAX;
    1b6a:	800007b7          	lui	a5,0x80000
    1b6e:	fff7c793          	not	a5,a5
    1b72:	fef42223          	sw	a5,-28(s0)

    list_for_each_entry(next_release, release_queue, thread_list) {
    1b76:	fc843783          	ld	a5,-56(s0)
    1b7a:	639c                	ld	a5,0(a5)
    1b7c:	fcf43c23          	sd	a5,-40(s0)
    1b80:	fd843783          	ld	a5,-40(s0)
    1b84:	17e1                	addi	a5,a5,-8
    1b86:	fef43423          	sd	a5,-24(s0)
    1b8a:	a081                	j	1bca <find_next_release_time+0x74>
        if (next_release->release_time > current_time &&
    1b8c:	fe843783          	ld	a5,-24(s0)
    1b90:	4f98                	lw	a4,24(a5)
    1b92:	fc442783          	lw	a5,-60(s0)
    1b96:	2781                	sext.w	a5,a5
    1b98:	00e7df63          	bge	a5,a4,1bb6 <find_next_release_time+0x60>
            next_release->release_time < next_release_time) {
    1b9c:	fe843783          	ld	a5,-24(s0)
    1ba0:	4f98                	lw	a4,24(a5)
        if (next_release->release_time > current_time &&
    1ba2:	fe442783          	lw	a5,-28(s0)
    1ba6:	2781                	sext.w	a5,a5
    1ba8:	00f75763          	bge	a4,a5,1bb6 <find_next_release_time+0x60>
            next_release_time = next_release->release_time;
    1bac:	fe843783          	ld	a5,-24(s0)
    1bb0:	4f9c                	lw	a5,24(a5)
    1bb2:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(next_release, release_queue, thread_list) {
    1bb6:	fe843783          	ld	a5,-24(s0)
    1bba:	679c                	ld	a5,8(a5)
    1bbc:	fcf43823          	sd	a5,-48(s0)
    1bc0:	fd043783          	ld	a5,-48(s0)
    1bc4:	17e1                	addi	a5,a5,-8
    1bc6:	fef43423          	sd	a5,-24(s0)
    1bca:	fe843783          	ld	a5,-24(s0)
    1bce:	07a1                	addi	a5,a5,8
    1bd0:	fc843703          	ld	a4,-56(s0)
    1bd4:	faf71ce3          	bne	a4,a5,1b8c <find_next_release_time+0x36>
        }
    }

    if (next_release_time == INT_MAX)
    1bd8:	fe442783          	lw	a5,-28(s0)
    1bdc:	0007871b          	sext.w	a4,a5
    1be0:	800007b7          	lui	a5,0x80000
    1be4:	fff7c793          	not	a5,a5
    1be8:	00f71463          	bne	a4,a5,1bf0 <find_next_release_time+0x9a>
        return -1; // No threads in the release queue
    1bec:	57fd                	li	a5,-1
    1bee:	a801                	j	1bfe <find_next_release_time+0xa8>

    return next_release_time - current_time;
    1bf0:	fe442703          	lw	a4,-28(s0)
    1bf4:	fc442783          	lw	a5,-60(s0)
    1bf8:	40f707bb          	subw	a5,a4,a5
    1bfc:	2781                	sext.w	a5,a5
}
    1bfe:	853e                	mv	a0,a5
    1c00:	7462                	ld	s0,56(sp)
    1c02:	6121                	addi	sp,sp,64
    1c04:	8082                	ret

0000000000001c06 <schedule_sjf>:


struct threads_sched_result schedule_sjf(struct threads_sched_args args)
{
    1c06:	711d                	addi	sp,sp,-96
    1c08:	eca2                	sd	s0,88(sp)
    1c0a:	e8a6                	sd	s1,80(sp)
    1c0c:	1080                	addi	s0,sp,96
    1c0e:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the shortest-job-first scheduling algorithm
    struct thread *shortest_job = NULL;
    1c10:	fe043423          	sd	zero,-24(s0)
    struct thread *t;
    int shortest_time = INT_MAX;
    1c14:	800007b7          	lui	a5,0x80000
    1c18:	fff7c793          	not	a5,a5
    1c1c:	fcf42e23          	sw	a5,-36(s0)

    // Find the thread with the shortest remaining time that is ready to run
    list_for_each_entry(t, args.run_queue, thread_list) {
    1c20:	649c                	ld	a5,8(s1)
    1c22:	639c                	ld	a5,0(a5)
    1c24:	fcf43823          	sd	a5,-48(s0)
    1c28:	fd043783          	ld	a5,-48(s0)
    1c2c:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffd680>
    1c30:	fef43023          	sd	a5,-32(s0)
    1c34:	a82d                	j	1c6e <schedule_sjf+0x68>
        if (t->remaining_time < shortest_time) {
    1c36:	fe043783          	ld	a5,-32(s0)
    1c3a:	4fb8                	lw	a4,88(a5)
    1c3c:	fdc42783          	lw	a5,-36(s0)
    1c40:	2781                	sext.w	a5,a5
    1c42:	00f75b63          	bge	a4,a5,1c58 <schedule_sjf+0x52>
            shortest_time = t->remaining_time;
    1c46:	fe043783          	ld	a5,-32(s0)
    1c4a:	4fbc                	lw	a5,88(a5)
    1c4c:	fcf42e23          	sw	a5,-36(s0)
            shortest_job = t;
    1c50:	fe043783          	ld	a5,-32(s0)
    1c54:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    1c58:	fe043783          	ld	a5,-32(s0)
    1c5c:	779c                	ld	a5,40(a5)
    1c5e:	fcf43423          	sd	a5,-56(s0)
    1c62:	fc843783          	ld	a5,-56(s0)
    1c66:	fd878793          	addi	a5,a5,-40
    1c6a:	fef43023          	sd	a5,-32(s0)
    1c6e:	fe043783          	ld	a5,-32(s0)
    1c72:	02878713          	addi	a4,a5,40
    1c76:	649c                	ld	a5,8(s1)
    1c78:	faf71fe3          	bne	a4,a5,1c36 <schedule_sjf+0x30>
        }
    }

    if (shortest_job) {
    1c7c:	fe843783          	ld	a5,-24(s0)
    1c80:	cf89                	beqz	a5,1c9a <schedule_sjf+0x94>
        r.scheduled_thread_list_member = &shortest_job->thread_list;
    1c82:	fe843783          	ld	a5,-24(s0)
    1c86:	02878793          	addi	a5,a5,40
    1c8a:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = shortest_job->remaining_time;  // Allow the thread to run to completion
    1c8e:	fe843783          	ld	a5,-24(s0)
    1c92:	4fbc                	lw	a5,88(a5)
    1c94:	faf42823          	sw	a5,-80(s0)
    1c98:	a039                	j	1ca6 <schedule_sjf+0xa0>
    } else {
        // If no threads are ready, find the next release time or idle
        r.scheduled_thread_list_member = args.run_queue;
    1c9a:	649c                	ld	a5,8(s1)
    1c9c:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = 1;  // Default minimal quantum if unsure
    1ca0:	4785                	li	a5,1
    1ca2:	faf42823          	sw	a5,-80(s0)
    }
    return r;
    1ca6:	fa843783          	ld	a5,-88(s0)
    1caa:	faf43c23          	sd	a5,-72(s0)
    1cae:	fb043783          	ld	a5,-80(s0)
    1cb2:	fcf43023          	sd	a5,-64(s0)
    1cb6:	4701                	li	a4,0
    1cb8:	fb843703          	ld	a4,-72(s0)
    1cbc:	4781                	li	a5,0
    1cbe:	fc043783          	ld	a5,-64(s0)
    1cc2:	863a                	mv	a2,a4
    1cc4:	86be                	mv	a3,a5
    1cc6:	8732                	mv	a4,a2
    1cc8:	87b6                	mv	a5,a3
}
    1cca:	853a                	mv	a0,a4
    1ccc:	85be                	mv	a1,a5
    1cce:	6466                	ld	s0,88(sp)
    1cd0:	64c6                	ld	s1,80(sp)
    1cd2:	6125                	addi	sp,sp,96
    1cd4:	8082                	ret

0000000000001cd6 <schedule_lst>:

/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args)
{
    1cd6:	7119                	addi	sp,sp,-128
    1cd8:	fc86                	sd	ra,120(sp)
    1cda:	f8a2                	sd	s0,112(sp)
    1cdc:	f4a6                	sd	s1,104(sp)
    1cde:	f0ca                	sd	s2,96(sp)
    1ce0:	ecce                	sd	s3,88(sp)
    1ce2:	0100                	addi	s0,sp,128
    1ce4:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the least-slack-time scheduling algorithm
    struct thread *min_slack = NULL;
    1ce6:	fc043423          	sd	zero,-56(s0)
    int min_slack_time = INT_MAX;
    1cea:	800007b7          	lui	a5,0x80000
    1cee:	fff7c793          	not	a5,a5
    1cf2:	fcf42223          	sw	a5,-60(s0)
    struct thread *t;

    // Find the thread with the minimum slack time
    list_for_each_entry(t, args.run_queue, thread_list) {
    1cf6:	649c                	ld	a5,8(s1)
    1cf8:	639c                	ld	a5,0(a5)
    1cfa:	faf43823          	sd	a5,-80(s0)
    1cfe:	fb043783          	ld	a5,-80(s0)
    1d02:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffd680>
    1d06:	faf43c23          	sd	a5,-72(s0)
    1d0a:	a8b5                	j	1d86 <schedule_lst+0xb0>
        int slack_time = t->deadline - args.current_time - t->remaining_time;
    1d0c:	fb843783          	ld	a5,-72(s0)
    1d10:	47f8                	lw	a4,76(a5)
    1d12:	409c                	lw	a5,0(s1)
    1d14:	40f707bb          	subw	a5,a4,a5
    1d18:	0007871b          	sext.w	a4,a5
    1d1c:	fb843783          	ld	a5,-72(s0)
    1d20:	4fbc                	lw	a5,88(a5)
    1d22:	40f707bb          	subw	a5,a4,a5
    1d26:	faf42623          	sw	a5,-84(s0)
        if (min_slack == NULL || slack_time < min_slack_time ||
    1d2a:	fc843783          	ld	a5,-56(s0)
    1d2e:	cb8d                	beqz	a5,1d60 <schedule_lst+0x8a>
    1d30:	fac42703          	lw	a4,-84(s0)
    1d34:	fc442783          	lw	a5,-60(s0)
    1d38:	2701                	sext.w	a4,a4
    1d3a:	2781                	sext.w	a5,a5
    1d3c:	02f74263          	blt	a4,a5,1d60 <schedule_lst+0x8a>
    1d40:	fac42703          	lw	a4,-84(s0)
    1d44:	fc442783          	lw	a5,-60(s0)
    1d48:	2701                	sext.w	a4,a4
    1d4a:	2781                	sext.w	a5,a5
    1d4c:	02f71263          	bne	a4,a5,1d70 <schedule_lst+0x9a>
            (slack_time == min_slack_time && t->ID < min_slack->ID)) {
    1d50:	fb843783          	ld	a5,-72(s0)
    1d54:	5fd8                	lw	a4,60(a5)
    1d56:	fc843783          	ld	a5,-56(s0)
    1d5a:	5fdc                	lw	a5,60(a5)
    1d5c:	00f75a63          	bge	a4,a5,1d70 <schedule_lst+0x9a>
            min_slack = t;
    1d60:	fb843783          	ld	a5,-72(s0)
    1d64:	fcf43423          	sd	a5,-56(s0)
            min_slack_time = slack_time;
    1d68:	fac42783          	lw	a5,-84(s0)
    1d6c:	fcf42223          	sw	a5,-60(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    1d70:	fb843783          	ld	a5,-72(s0)
    1d74:	779c                	ld	a5,40(a5)
    1d76:	faf43023          	sd	a5,-96(s0)
    1d7a:	fa043783          	ld	a5,-96(s0)
    1d7e:	fd878793          	addi	a5,a5,-40
    1d82:	faf43c23          	sd	a5,-72(s0)
    1d86:	fb843783          	ld	a5,-72(s0)
    1d8a:	02878713          	addi	a4,a5,40
    1d8e:	649c                	ld	a5,8(s1)
    1d90:	f6f71ee3          	bne	a4,a5,1d0c <schedule_lst+0x36>
        }
    }

    if (min_slack) {
    1d94:	fc843783          	ld	a5,-56(s0)
    1d98:	cf89                	beqz	a5,1db2 <schedule_lst+0xdc>
        r.scheduled_thread_list_member = &min_slack->thread_list;
    1d9a:	fc843783          	ld	a5,-56(s0)
    1d9e:	02878793          	addi	a5,a5,40
    1da2:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = min_slack->remaining_time;
    1da6:	fc843783          	ld	a5,-56(s0)
    1daa:	4fbc                	lw	a5,88(a5)
    1dac:	f8f42423          	sw	a5,-120(s0)
    1db0:	a839                	j	1dce <schedule_lst+0xf8>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
    1db2:	649c                	ld	a5,8(s1)
    1db4:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    1db8:	689c                	ld	a5,16(s1)
    1dba:	4098                	lw	a4,0(s1)
    1dbc:	85ba                	mv	a1,a4
    1dbe:	853e                	mv	a0,a5
    1dc0:	00000097          	auipc	ra,0x0
    1dc4:	d96080e7          	jalr	-618(ra) # 1b56 <find_next_release_time>
    1dc8:	87aa                	mv	a5,a0
    1dca:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    1dce:	f8043783          	ld	a5,-128(s0)
    1dd2:	f8f43823          	sd	a5,-112(s0)
    1dd6:	f8843783          	ld	a5,-120(s0)
    1dda:	f8f43c23          	sd	a5,-104(s0)
    1dde:	4701                	li	a4,0
    1de0:	f9043703          	ld	a4,-112(s0)
    1de4:	4781                	li	a5,0
    1de6:	f9843783          	ld	a5,-104(s0)
    1dea:	893a                	mv	s2,a4
    1dec:	89be                	mv	s3,a5
    1dee:	874a                	mv	a4,s2
    1df0:	87ce                	mv	a5,s3
}
    1df2:	853a                	mv	a0,a4
    1df4:	85be                	mv	a1,a5
    1df6:	70e6                	ld	ra,120(sp)
    1df8:	7446                	ld	s0,112(sp)
    1dfa:	74a6                	ld	s1,104(sp)
    1dfc:	7906                	ld	s2,96(sp)
    1dfe:	69e6                	ld	s3,88(sp)
    1e00:	6109                	addi	sp,sp,128
    1e02:	8082                	ret

0000000000001e04 <schedule_dm>:

/* Deadline-Monotonic Scheduling */
struct threads_sched_result schedule_dm(struct threads_sched_args args)
{
    1e04:	7135                	addi	sp,sp,-160
    1e06:	ed06                	sd	ra,152(sp)
    1e08:	e922                	sd	s0,144(sp)
    1e0a:	e526                	sd	s1,136(sp)
    1e0c:	e14a                	sd	s2,128(sp)
    1e0e:	fcce                	sd	s3,120(sp)
    1e10:	1100                	addi	s0,sp,160
    1e12:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the deadline-monotonic scheduling algorithm
   struct thread *earliest_deadline_thread = NULL;
    1e14:	fc043423          	sd	zero,-56(s0)
    struct thread *t;
    int earliest_deadline = INT_MAX;
    1e18:	800007b7          	lui	a5,0x80000
    1e1c:	fff7c793          	not	a5,a5
    1e20:	faf42e23          	sw	a5,-68(s0)

    // Find the earliest deadline real-time thread
    list_for_each_entry(t, args.run_queue, thread_list) {
    1e24:	649c                	ld	a5,8(s1)
    1e26:	639c                	ld	a5,0(a5)
    1e28:	faf43423          	sd	a5,-88(s0)
    1e2c:	fa843783          	ld	a5,-88(s0)
    1e30:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffd680>
    1e34:	fcf43023          	sd	a5,-64(s0)
    1e38:	a841                	j	1ec8 <schedule_dm+0xc4>
        if (t->is_real_time && t->period != -1 && t->current_deadline < earliest_deadline) {
    1e3a:	fc043783          	ld	a5,-64(s0)
    1e3e:	43bc                	lw	a5,64(a5)
    1e40:	cb95                	beqz	a5,1e74 <schedule_dm+0x70>
    1e42:	fc043783          	ld	a5,-64(s0)
    1e46:	4bbc                	lw	a5,80(a5)
    1e48:	873e                	mv	a4,a5
    1e4a:	57fd                	li	a5,-1
    1e4c:	02f70463          	beq	a4,a5,1e74 <schedule_dm+0x70>
    1e50:	fc043783          	ld	a5,-64(s0)
    1e54:	4ff8                	lw	a4,92(a5)
    1e56:	fbc42783          	lw	a5,-68(s0)
    1e5a:	2781                	sext.w	a5,a5
    1e5c:	00f75c63          	bge	a4,a5,1e74 <schedule_dm+0x70>
            earliest_deadline = t->current_deadline;
    1e60:	fc043783          	ld	a5,-64(s0)
    1e64:	4ffc                	lw	a5,92(a5)
    1e66:	faf42e23          	sw	a5,-68(s0)
            earliest_deadline_thread = t;
    1e6a:	fc043783          	ld	a5,-64(s0)
    1e6e:	fcf43423          	sd	a5,-56(s0)
    1e72:	a081                	j	1eb2 <schedule_dm+0xae>
        } else if (t->is_real_time && t->period != -1 && t->current_deadline == earliest_deadline && t->ID < earliest_deadline_thread->ID) {
    1e74:	fc043783          	ld	a5,-64(s0)
    1e78:	43bc                	lw	a5,64(a5)
    1e7a:	cf85                	beqz	a5,1eb2 <schedule_dm+0xae>
    1e7c:	fc043783          	ld	a5,-64(s0)
    1e80:	4bbc                	lw	a5,80(a5)
    1e82:	873e                	mv	a4,a5
    1e84:	57fd                	li	a5,-1
    1e86:	02f70663          	beq	a4,a5,1eb2 <schedule_dm+0xae>
    1e8a:	fc043783          	ld	a5,-64(s0)
    1e8e:	4ff8                	lw	a4,92(a5)
    1e90:	fbc42783          	lw	a5,-68(s0)
    1e94:	2781                	sext.w	a5,a5
    1e96:	00e79e63          	bne	a5,a4,1eb2 <schedule_dm+0xae>
    1e9a:	fc043783          	ld	a5,-64(s0)
    1e9e:	5fd8                	lw	a4,60(a5)
    1ea0:	fc843783          	ld	a5,-56(s0)
    1ea4:	5fdc                	lw	a5,60(a5)
    1ea6:	00f75663          	bge	a4,a5,1eb2 <schedule_dm+0xae>
            earliest_deadline_thread = t;  // Tie-breaking by ID
    1eaa:	fc043783          	ld	a5,-64(s0)
    1eae:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    1eb2:	fc043783          	ld	a5,-64(s0)
    1eb6:	779c                	ld	a5,40(a5)
    1eb8:	f8f43423          	sd	a5,-120(s0)
    1ebc:	f8843783          	ld	a5,-120(s0)
    1ec0:	fd878793          	addi	a5,a5,-40
    1ec4:	fcf43023          	sd	a5,-64(s0)
    1ec8:	fc043783          	ld	a5,-64(s0)
    1ecc:	02878713          	addi	a4,a5,40
    1ed0:	649c                	ld	a5,8(s1)
    1ed2:	f6f714e3          	bne	a4,a5,1e3a <schedule_dm+0x36>
        }
    }

    if (earliest_deadline_thread) {
    1ed6:	fc843783          	ld	a5,-56(s0)
    1eda:	c7a5                	beqz	a5,1f42 <schedule_dm+0x13e>
        int time_to_deadline = earliest_deadline_thread->current_deadline - args.current_time;
    1edc:	fc843783          	ld	a5,-56(s0)
    1ee0:	4ff8                	lw	a4,92(a5)
    1ee2:	409c                	lw	a5,0(s1)
    1ee4:	40f707bb          	subw	a5,a4,a5
    1ee8:	f8f42a23          	sw	a5,-108(s0)
        if (earliest_deadline_thread->remaining_time > time_to_deadline) {
    1eec:	fc843783          	ld	a5,-56(s0)
    1ef0:	4fb8                	lw	a4,88(a5)
    1ef2:	f9442783          	lw	a5,-108(s0)
    1ef6:	2781                	sext.w	a5,a5
    1ef8:	00e7db63          	bge	a5,a4,1f0e <schedule_dm+0x10a>
            // The real-time thread cannot complete before its deadline, so handle the deadline miss
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    1efc:	fc843783          	ld	a5,-56(s0)
    1f00:	02878793          	addi	a5,a5,40
    1f04:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = 0; // Could set to minimal quantum to allow cleanup or logging
    1f08:	f6042823          	sw	zero,-144(s0)
    1f0c:	a0f1                	j	1fd8 <schedule_dm+0x1d4>
        } else {
            // Schedule the real-time thread normally if it hasn't missed its deadline
            int time_slice = (time_to_deadline < earliest_deadline_thread->remaining_time) ? time_to_deadline : earliest_deadline_thread->remaining_time;
    1f0e:	fc843783          	ld	a5,-56(s0)
    1f12:	4fbc                	lw	a5,88(a5)
    1f14:	863e                	mv	a2,a5
    1f16:	f9442783          	lw	a5,-108(s0)
    1f1a:	0007869b          	sext.w	a3,a5
    1f1e:	0006071b          	sext.w	a4,a2
    1f22:	00d75363          	bge	a4,a3,1f28 <schedule_dm+0x124>
    1f26:	87b2                	mv	a5,a2
    1f28:	f8f42823          	sw	a5,-112(s0)
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    1f2c:	fc843783          	ld	a5,-56(s0)
    1f30:	02878793          	addi	a5,a5,40
    1f34:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = time_slice;
    1f38:	f9042783          	lw	a5,-112(s0)
    1f3c:	f6f42823          	sw	a5,-144(s0)
    1f40:	a861                	j	1fd8 <schedule_dm+0x1d4>
        }
    } else {
        // If no real-time threads with a deadline are ready, find the thread with the smallest ID
        struct thread *smallest_id_thread = NULL;
    1f42:	fa043823          	sd	zero,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    1f46:	649c                	ld	a5,8(s1)
    1f48:	639c                	ld	a5,0(a5)
    1f4a:	faf43023          	sd	a5,-96(s0)
    1f4e:	fa043783          	ld	a5,-96(s0)
    1f52:	fd878793          	addi	a5,a5,-40
    1f56:	fcf43023          	sd	a5,-64(s0)
    1f5a:	a81d                	j	1f90 <schedule_dm+0x18c>
            if (smallest_id_thread == NULL || t->ID < smallest_id_thread->ID) {
    1f5c:	fb043783          	ld	a5,-80(s0)
    1f60:	cb89                	beqz	a5,1f72 <schedule_dm+0x16e>
    1f62:	fc043783          	ld	a5,-64(s0)
    1f66:	5fd8                	lw	a4,60(a5)
    1f68:	fb043783          	ld	a5,-80(s0)
    1f6c:	5fdc                	lw	a5,60(a5)
    1f6e:	00f75663          	bge	a4,a5,1f7a <schedule_dm+0x176>
                smallest_id_thread = t;
    1f72:	fc043783          	ld	a5,-64(s0)
    1f76:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    1f7a:	fc043783          	ld	a5,-64(s0)
    1f7e:	779c                	ld	a5,40(a5)
    1f80:	f8f43c23          	sd	a5,-104(s0)
    1f84:	f9843783          	ld	a5,-104(s0)
    1f88:	fd878793          	addi	a5,a5,-40
    1f8c:	fcf43023          	sd	a5,-64(s0)
    1f90:	fc043783          	ld	a5,-64(s0)
    1f94:	02878713          	addi	a4,a5,40
    1f98:	649c                	ld	a5,8(s1)
    1f9a:	fcf711e3          	bne	a4,a5,1f5c <schedule_dm+0x158>
            }
        }

        if (smallest_id_thread) {
    1f9e:	fb043783          	ld	a5,-80(s0)
    1fa2:	cf89                	beqz	a5,1fbc <schedule_dm+0x1b8>
            r.scheduled_thread_list_member = &smallest_id_thread->thread_list;
    1fa4:	fb043783          	ld	a5,-80(s0)
    1fa8:	02878793          	addi	a5,a5,40
    1fac:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = smallest_id_thread->remaining_time;
    1fb0:	fb043783          	ld	a5,-80(s0)
    1fb4:	4fbc                	lw	a5,88(a5)
    1fb6:	f6f42823          	sw	a5,-144(s0)
    1fba:	a839                	j	1fd8 <schedule_dm+0x1d4>
        } else {
            // If no thread is ready, perhaps idle or find the next release time
            r.scheduled_thread_list_member = args.run_queue;
    1fbc:	649c                	ld	a5,8(s1)
    1fbe:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    1fc2:	689c                	ld	a5,16(s1)
    1fc4:	4098                	lw	a4,0(s1)
    1fc6:	85ba                	mv	a1,a4
    1fc8:	853e                	mv	a0,a5
    1fca:	00000097          	auipc	ra,0x0
    1fce:	b8c080e7          	jalr	-1140(ra) # 1b56 <find_next_release_time>
    1fd2:	87aa                	mv	a5,a0
    1fd4:	f6f42823          	sw	a5,-144(s0)
        }
    }

    return r;
    1fd8:	f6843783          	ld	a5,-152(s0)
    1fdc:	f6f43c23          	sd	a5,-136(s0)
    1fe0:	f7043783          	ld	a5,-144(s0)
    1fe4:	f8f43023          	sd	a5,-128(s0)
    1fe8:	4701                	li	a4,0
    1fea:	f7843703          	ld	a4,-136(s0)
    1fee:	4781                	li	a5,0
    1ff0:	f8043783          	ld	a5,-128(s0)
    1ff4:	893a                	mv	s2,a4
    1ff6:	89be                	mv	s3,a5
    1ff8:	874a                	mv	a4,s2
    1ffa:	87ce                	mv	a5,s3
}
    1ffc:	853a                	mv	a0,a4
    1ffe:	85be                	mv	a1,a5
    2000:	60ea                	ld	ra,152(sp)
    2002:	644a                	ld	s0,144(sp)
    2004:	64aa                	ld	s1,136(sp)
    2006:	690a                	ld	s2,128(sp)
    2008:	79e6                	ld	s3,120(sp)
    200a:	610d                	addi	sp,sp,160
    200c:	8082                	ret
