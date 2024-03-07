
user/_threads:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <thread_create>:
static struct thread* current_thread = NULL;
static int id = 1;
//static jmp_buf env_st;
//static jmp_buf env_tmp;

struct thread *thread_create(void (*f)(void *), void *arg){
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	89aa                	mv	s3,a0
  10:	892e                	mv	s2,a1
    struct thread *t = (struct thread*) malloc(sizeof(struct thread));
  12:	0a800513          	li	a0,168
  16:	00001097          	auipc	ra,0x1
  1a:	894080e7          	jalr	-1900(ra) # 8aa <malloc>
  1e:	84aa                	mv	s1,a0
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long) malloc(sizeof(unsigned long)*0x100);
  20:	6505                	lui	a0,0x1
  22:	80050513          	addi	a0,a0,-2048 # 800 <printf+0x14>
  26:	00001097          	auipc	ra,0x1
  2a:	884080e7          	jalr	-1916(ra) # 8aa <malloc>
    new_stack_p = new_stack +0x100*8-0x2*8;
    t->fp = f;
  2e:	0134b023          	sd	s3,0(s1)
    t->arg = arg;
  32:	0124b423          	sd	s2,8(s1)
    t->ID  = id;
  36:	00001717          	auipc	a4,0x1
  3a:	9ee70713          	addi	a4,a4,-1554 # a24 <id>
  3e:	431c                	lw	a5,0(a4)
  40:	08f4aa23          	sw	a5,148(s1)
    t->buf_set = 0;
  44:	0804a823          	sw	zero,144(s1)
    t->stack = (void*) new_stack;
  48:	e888                	sd	a0,16(s1)
    new_stack_p = new_stack +0x100*8-0x2*8;
  4a:	7f050513          	addi	a0,a0,2032
    t->stack_p = (void*) new_stack_p;
  4e:	ec88                	sd	a0,24(s1)
    id++;
  50:	2785                	addiw	a5,a5,1
  52:	c31c                	sw	a5,0(a4)
    return t;
}
  54:	8526                	mv	a0,s1
  56:	70a2                	ld	ra,40(sp)
  58:	7402                	ld	s0,32(sp)
  5a:	64e2                	ld	s1,24(sp)
  5c:	6942                	ld	s2,16(sp)
  5e:	69a2                	ld	s3,8(sp)
  60:	6145                	addi	sp,sp,48
  62:	8082                	ret

0000000000000064 <thread_add_runqueue>:
void thread_add_runqueue(struct thread *t){
  64:	1141                	addi	sp,sp,-16
  66:	e422                	sd	s0,8(sp)
  68:	0800                	addi	s0,sp,16
    if (current_thread == NULL) {
  6a:	00001797          	auipc	a5,0x1
  6e:	9be7b783          	ld	a5,-1602(a5) # a28 <current_thread>
  72:	cb89                	beqz	a5,84 <thread_add_runqueue+0x20>
        current_thread = t;
        t->next = t->previous = t;
    } else {
        t->next = current_thread;
  74:	f15c                	sd	a5,160(a0)
        t->previous = current_thread->previous;
  76:	6fd8                	ld	a4,152(a5)
  78:	ed58                	sd	a4,152(a0)
        current_thread->previous->next = t;
  7a:	f348                	sd	a0,160(a4)
        current_thread->previous = t;
  7c:	efc8                	sd	a0,152(a5)
    }
}
  7e:	6422                	ld	s0,8(sp)
  80:	0141                	addi	sp,sp,16
  82:	8082                	ret
        current_thread = t;
  84:	00001797          	auipc	a5,0x1
  88:	9aa7b223          	sd	a0,-1628(a5) # a28 <current_thread>
        t->next = t->previous = t;
  8c:	ed48                	sd	a0,152(a0)
  8e:	f148                	sd	a0,160(a0)
  90:	b7fd                	j	7e <thread_add_runqueue+0x1a>

0000000000000092 <schedule>:
        }
        // If the thread function returns, it means it's completed execution
        thread_exit();
    }
}
void schedule(void){
  92:	1141                	addi	sp,sp,-16
  94:	e422                	sd	s0,8(sp)
  96:	0800                	addi	s0,sp,16
    if (current_thread == NULL || current_thread->next == current_thread) {
  98:	00001797          	auipc	a5,0x1
  9c:	9907b783          	ld	a5,-1648(a5) # a28 <current_thread>
  a0:	cb89                	beqz	a5,b2 <schedule+0x20>
  a2:	73d8                	ld	a4,160(a5)
  a4:	00e78763          	beq	a5,a4,b2 <schedule+0x20>
        // No more threads to schedule, set current_thread to NULL
        current_thread = NULL;
    } else {
        // Normal scheduling logic
        current_thread = current_thread->next;
  a8:	00001797          	auipc	a5,0x1
  ac:	98e7b023          	sd	a4,-1664(a5) # a28 <current_thread>
    }
}
  b0:	a029                	j	ba <schedule+0x28>
        current_thread = NULL;
  b2:	00001797          	auipc	a5,0x1
  b6:	9607bb23          	sd	zero,-1674(a5) # a28 <current_thread>
}
  ba:	6422                	ld	s0,8(sp)
  bc:	0141                	addi	sp,sp,16
  be:	8082                	ret

00000000000000c0 <thread_exit>:
void thread_exit(void){
  c0:	1101                	addi	sp,sp,-32
  c2:	ec06                	sd	ra,24(sp)
  c4:	e822                	sd	s0,16(sp)
  c6:	e426                	sd	s1,8(sp)
  c8:	1000                	addi	s0,sp,32
    struct thread *temp = current_thread;
  ca:	00001497          	auipc	s1,0x1
  ce:	95e4b483          	ld	s1,-1698(s1) # a28 <current_thread>
    
    if (current_thread->next != current_thread) {
  d2:	70dc                	ld	a5,160(s1)
  d4:	02978e63          	beq	a5,s1,110 <thread_exit+0x50>
        //printf("Thread %d is next\n", current_thread->next->ID);
        current_thread->previous->next = current_thread->next;
  d8:	6cd8                	ld	a4,152(s1)
  da:	f35c                	sd	a5,160(a4)
        current_thread->next->previous = current_thread->previous;
  dc:	6cd8                	ld	a4,152(s1)
  de:	efd8                	sd	a4,152(a5)
        current_thread = current_thread->next;
  e0:	70dc                	ld	a5,160(s1)
  e2:	00001717          	auipc	a4,0x1
  e6:	94f73323          	sd	a5,-1722(a4) # a28 <current_thread>
        free(temp->stack);
  ea:	6888                	ld	a0,16(s1)
  ec:	00000097          	auipc	ra,0x0
  f0:	736080e7          	jalr	1846(ra) # 822 <free>
        free(temp);
  f4:	8526                	mv	a0,s1
  f6:	00000097          	auipc	ra,0x0
  fa:	72c080e7          	jalr	1836(ra) # 822 <free>
        dispatch();
  fe:	00000097          	auipc	ra,0x0
 102:	02e080e7          	jalr	46(ra) # 12c <dispatch>
    } else {
        // Last thread
        free(current_thread->stack);
        free(current_thread);
    }
}
 106:	60e2                	ld	ra,24(sp)
 108:	6442                	ld	s0,16(sp)
 10a:	64a2                	ld	s1,8(sp)
 10c:	6105                	addi	sp,sp,32
 10e:	8082                	ret
        free(current_thread->stack);
 110:	6888                	ld	a0,16(s1)
 112:	00000097          	auipc	ra,0x0
 116:	710080e7          	jalr	1808(ra) # 822 <free>
        free(current_thread);
 11a:	00001517          	auipc	a0,0x1
 11e:	90e53503          	ld	a0,-1778(a0) # a28 <current_thread>
 122:	00000097          	auipc	ra,0x0
 126:	700080e7          	jalr	1792(ra) # 822 <free>
}
 12a:	bff1                	j	106 <thread_exit+0x46>

000000000000012c <dispatch>:
void dispatch(void) {
 12c:	1141                	addi	sp,sp,-16
 12e:	e406                	sd	ra,8(sp)
 130:	e022                	sd	s0,0(sp)
 132:	0800                	addi	s0,sp,16
    if (current_thread->buf_set) {
 134:	00001517          	auipc	a0,0x1
 138:	8f453503          	ld	a0,-1804(a0) # a28 <current_thread>
 13c:	09052783          	lw	a5,144(a0)
 140:	eb95                	bnez	a5,174 <dispatch+0x48>
        if (setjmp(current_thread->env) == 0) {
 142:	02050513          	addi	a0,a0,32
 146:	00001097          	auipc	ra,0x1
 14a:	848080e7          	jalr	-1976(ra) # 98e <setjmp>
 14e:	e919                	bnez	a0,164 <dispatch+0x38>
            current_thread->buf_set = 1;
 150:	00001797          	auipc	a5,0x1
 154:	8d87b783          	ld	a5,-1832(a5) # a28 <current_thread>
 158:	4705                	li	a4,1
 15a:	08e7a823          	sw	a4,144(a5)
            current_thread->fp(current_thread->arg);
 15e:	6398                	ld	a4,0(a5)
 160:	6788                	ld	a0,8(a5)
 162:	9702                	jalr	a4
        thread_exit();
 164:	00000097          	auipc	ra,0x0
 168:	f5c080e7          	jalr	-164(ra) # c0 <thread_exit>
}
 16c:	60a2                	ld	ra,8(sp)
 16e:	6402                	ld	s0,0(sp)
 170:	0141                	addi	sp,sp,16
 172:	8082                	ret
        longjmp(current_thread->env, 1);
 174:	4585                	li	a1,1
 176:	02050513          	addi	a0,a0,32
 17a:	00001097          	auipc	ra,0x1
 17e:	84c080e7          	jalr	-1972(ra) # 9c6 <longjmp>
 182:	b7ed                	j	16c <dispatch+0x40>

0000000000000184 <thread_yield>:
    if (current_thread != NULL && setjmp(current_thread->env) == 0) {
 184:	00001517          	auipc	a0,0x1
 188:	8a453503          	ld	a0,-1884(a0) # a28 <current_thread>
 18c:	c121                	beqz	a0,1cc <thread_yield+0x48>
void thread_yield(void){
 18e:	1141                	addi	sp,sp,-16
 190:	e406                	sd	ra,8(sp)
 192:	e022                	sd	s0,0(sp)
 194:	0800                	addi	s0,sp,16
    if (current_thread != NULL && setjmp(current_thread->env) == 0) {
 196:	02050513          	addi	a0,a0,32
 19a:	00000097          	auipc	ra,0x0
 19e:	7f4080e7          	jalr	2036(ra) # 98e <setjmp>
 1a2:	c509                	beqz	a0,1ac <thread_yield+0x28>
}
 1a4:	60a2                	ld	ra,8(sp)
 1a6:	6402                	ld	s0,0(sp)
 1a8:	0141                	addi	sp,sp,16
 1aa:	8082                	ret
        current_thread->buf_set = 1; // Mark context as saved
 1ac:	00001797          	auipc	a5,0x1
 1b0:	87c7b783          	ld	a5,-1924(a5) # a28 <current_thread>
 1b4:	4705                	li	a4,1
 1b6:	08e7a823          	sw	a4,144(a5)
        schedule();
 1ba:	00000097          	auipc	ra,0x0
 1be:	ed8080e7          	jalr	-296(ra) # 92 <schedule>
        dispatch();
 1c2:	00000097          	auipc	ra,0x0
 1c6:	f6a080e7          	jalr	-150(ra) # 12c <dispatch>
}
 1ca:	bfe9                	j	1a4 <thread_yield+0x20>
 1cc:	8082                	ret

00000000000001ce <thread_start_threading>:
void thread_start_threading(void){
    if (current_thread != NULL) {
 1ce:	00001797          	auipc	a5,0x1
 1d2:	85a7b783          	ld	a5,-1958(a5) # a28 <current_thread>
 1d6:	cf89                	beqz	a5,1f0 <thread_start_threading+0x22>
void thread_start_threading(void){
 1d8:	1141                	addi	sp,sp,-16
 1da:	e406                	sd	ra,8(sp)
 1dc:	e022                	sd	s0,0(sp)
 1de:	0800                	addi	s0,sp,16
        dispatch(); // Start executing threads
 1e0:	00000097          	auipc	ra,0x0
 1e4:	f4c080e7          	jalr	-180(ra) # 12c <dispatch>
    }
}
 1e8:	60a2                	ld	ra,8(sp)
 1ea:	6402                	ld	s0,0(sp)
 1ec:	0141                	addi	sp,sp,16
 1ee:	8082                	ret
 1f0:	8082                	ret

00000000000001f2 <thread_assign_task>:

// part 2
void thread_assign_task(struct thread *t, void (*f)(void *), void *arg){
 1f2:	1141                	addi	sp,sp,-16
 1f4:	e422                	sd	s0,8(sp)
 1f6:	0800                	addi	s0,sp,16
    // TODO
}
 1f8:	6422                	ld	s0,8(sp)
 1fa:	0141                	addi	sp,sp,16
 1fc:	8082                	ret

00000000000001fe <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 1fe:	1141                	addi	sp,sp,-16
 200:	e422                	sd	s0,8(sp)
 202:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 204:	87aa                	mv	a5,a0
 206:	0585                	addi	a1,a1,1
 208:	0785                	addi	a5,a5,1
 20a:	fff5c703          	lbu	a4,-1(a1)
 20e:	fee78fa3          	sb	a4,-1(a5)
 212:	fb75                	bnez	a4,206 <strcpy+0x8>
    ;
  return os;
}
 214:	6422                	ld	s0,8(sp)
 216:	0141                	addi	sp,sp,16
 218:	8082                	ret

000000000000021a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 21a:	1141                	addi	sp,sp,-16
 21c:	e422                	sd	s0,8(sp)
 21e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 220:	00054783          	lbu	a5,0(a0)
 224:	cb91                	beqz	a5,238 <strcmp+0x1e>
 226:	0005c703          	lbu	a4,0(a1)
 22a:	00f71763          	bne	a4,a5,238 <strcmp+0x1e>
    p++, q++;
 22e:	0505                	addi	a0,a0,1
 230:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 232:	00054783          	lbu	a5,0(a0)
 236:	fbe5                	bnez	a5,226 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 238:	0005c503          	lbu	a0,0(a1)
}
 23c:	40a7853b          	subw	a0,a5,a0
 240:	6422                	ld	s0,8(sp)
 242:	0141                	addi	sp,sp,16
 244:	8082                	ret

0000000000000246 <strlen>:

uint
strlen(const char *s)
{
 246:	1141                	addi	sp,sp,-16
 248:	e422                	sd	s0,8(sp)
 24a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 24c:	00054783          	lbu	a5,0(a0)
 250:	cf91                	beqz	a5,26c <strlen+0x26>
 252:	0505                	addi	a0,a0,1
 254:	87aa                	mv	a5,a0
 256:	4685                	li	a3,1
 258:	9e89                	subw	a3,a3,a0
 25a:	00f6853b          	addw	a0,a3,a5
 25e:	0785                	addi	a5,a5,1
 260:	fff7c703          	lbu	a4,-1(a5)
 264:	fb7d                	bnez	a4,25a <strlen+0x14>
    ;
  return n;
}
 266:	6422                	ld	s0,8(sp)
 268:	0141                	addi	sp,sp,16
 26a:	8082                	ret
  for(n = 0; s[n]; n++)
 26c:	4501                	li	a0,0
 26e:	bfe5                	j	266 <strlen+0x20>

0000000000000270 <memset>:

void*
memset(void *dst, int c, uint n)
{
 270:	1141                	addi	sp,sp,-16
 272:	e422                	sd	s0,8(sp)
 274:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 276:	ce09                	beqz	a2,290 <memset+0x20>
 278:	87aa                	mv	a5,a0
 27a:	fff6071b          	addiw	a4,a2,-1
 27e:	1702                	slli	a4,a4,0x20
 280:	9301                	srli	a4,a4,0x20
 282:	0705                	addi	a4,a4,1
 284:	972a                	add	a4,a4,a0
    cdst[i] = c;
 286:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 28a:	0785                	addi	a5,a5,1
 28c:	fee79de3          	bne	a5,a4,286 <memset+0x16>
  }
  return dst;
}
 290:	6422                	ld	s0,8(sp)
 292:	0141                	addi	sp,sp,16
 294:	8082                	ret

0000000000000296 <strchr>:

char*
strchr(const char *s, char c)
{
 296:	1141                	addi	sp,sp,-16
 298:	e422                	sd	s0,8(sp)
 29a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 29c:	00054783          	lbu	a5,0(a0)
 2a0:	cb99                	beqz	a5,2b6 <strchr+0x20>
    if(*s == c)
 2a2:	00f58763          	beq	a1,a5,2b0 <strchr+0x1a>
  for(; *s; s++)
 2a6:	0505                	addi	a0,a0,1
 2a8:	00054783          	lbu	a5,0(a0)
 2ac:	fbfd                	bnez	a5,2a2 <strchr+0xc>
      return (char*)s;
  return 0;
 2ae:	4501                	li	a0,0
}
 2b0:	6422                	ld	s0,8(sp)
 2b2:	0141                	addi	sp,sp,16
 2b4:	8082                	ret
  return 0;
 2b6:	4501                	li	a0,0
 2b8:	bfe5                	j	2b0 <strchr+0x1a>

00000000000002ba <gets>:

char*
gets(char *buf, int max)
{
 2ba:	711d                	addi	sp,sp,-96
 2bc:	ec86                	sd	ra,88(sp)
 2be:	e8a2                	sd	s0,80(sp)
 2c0:	e4a6                	sd	s1,72(sp)
 2c2:	e0ca                	sd	s2,64(sp)
 2c4:	fc4e                	sd	s3,56(sp)
 2c6:	f852                	sd	s4,48(sp)
 2c8:	f456                	sd	s5,40(sp)
 2ca:	f05a                	sd	s6,32(sp)
 2cc:	ec5e                	sd	s7,24(sp)
 2ce:	1080                	addi	s0,sp,96
 2d0:	8baa                	mv	s7,a0
 2d2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2d4:	892a                	mv	s2,a0
 2d6:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2d8:	4aa9                	li	s5,10
 2da:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2dc:	89a6                	mv	s3,s1
 2de:	2485                	addiw	s1,s1,1
 2e0:	0344d863          	bge	s1,s4,310 <gets+0x56>
    cc = read(0, &c, 1);
 2e4:	4605                	li	a2,1
 2e6:	faf40593          	addi	a1,s0,-81
 2ea:	4501                	li	a0,0
 2ec:	00000097          	auipc	ra,0x0
 2f0:	1a0080e7          	jalr	416(ra) # 48c <read>
    if(cc < 1)
 2f4:	00a05e63          	blez	a0,310 <gets+0x56>
    buf[i++] = c;
 2f8:	faf44783          	lbu	a5,-81(s0)
 2fc:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 300:	01578763          	beq	a5,s5,30e <gets+0x54>
 304:	0905                	addi	s2,s2,1
 306:	fd679be3          	bne	a5,s6,2dc <gets+0x22>
  for(i=0; i+1 < max; ){
 30a:	89a6                	mv	s3,s1
 30c:	a011                	j	310 <gets+0x56>
 30e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 310:	99de                	add	s3,s3,s7
 312:	00098023          	sb	zero,0(s3)
  return buf;
}
 316:	855e                	mv	a0,s7
 318:	60e6                	ld	ra,88(sp)
 31a:	6446                	ld	s0,80(sp)
 31c:	64a6                	ld	s1,72(sp)
 31e:	6906                	ld	s2,64(sp)
 320:	79e2                	ld	s3,56(sp)
 322:	7a42                	ld	s4,48(sp)
 324:	7aa2                	ld	s5,40(sp)
 326:	7b02                	ld	s6,32(sp)
 328:	6be2                	ld	s7,24(sp)
 32a:	6125                	addi	sp,sp,96
 32c:	8082                	ret

000000000000032e <stat>:

int
stat(const char *n, struct stat *st)
{
 32e:	1101                	addi	sp,sp,-32
 330:	ec06                	sd	ra,24(sp)
 332:	e822                	sd	s0,16(sp)
 334:	e426                	sd	s1,8(sp)
 336:	e04a                	sd	s2,0(sp)
 338:	1000                	addi	s0,sp,32
 33a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 33c:	4581                	li	a1,0
 33e:	00000097          	auipc	ra,0x0
 342:	176080e7          	jalr	374(ra) # 4b4 <open>
  if(fd < 0)
 346:	02054563          	bltz	a0,370 <stat+0x42>
 34a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 34c:	85ca                	mv	a1,s2
 34e:	00000097          	auipc	ra,0x0
 352:	17e080e7          	jalr	382(ra) # 4cc <fstat>
 356:	892a                	mv	s2,a0
  close(fd);
 358:	8526                	mv	a0,s1
 35a:	00000097          	auipc	ra,0x0
 35e:	142080e7          	jalr	322(ra) # 49c <close>
  return r;
}
 362:	854a                	mv	a0,s2
 364:	60e2                	ld	ra,24(sp)
 366:	6442                	ld	s0,16(sp)
 368:	64a2                	ld	s1,8(sp)
 36a:	6902                	ld	s2,0(sp)
 36c:	6105                	addi	sp,sp,32
 36e:	8082                	ret
    return -1;
 370:	597d                	li	s2,-1
 372:	bfc5                	j	362 <stat+0x34>

0000000000000374 <atoi>:

int
atoi(const char *s)
{
 374:	1141                	addi	sp,sp,-16
 376:	e422                	sd	s0,8(sp)
 378:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 37a:	00054603          	lbu	a2,0(a0)
 37e:	fd06079b          	addiw	a5,a2,-48
 382:	0ff7f793          	andi	a5,a5,255
 386:	4725                	li	a4,9
 388:	02f76963          	bltu	a4,a5,3ba <atoi+0x46>
 38c:	86aa                	mv	a3,a0
  n = 0;
 38e:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 390:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 392:	0685                	addi	a3,a3,1
 394:	0025179b          	slliw	a5,a0,0x2
 398:	9fa9                	addw	a5,a5,a0
 39a:	0017979b          	slliw	a5,a5,0x1
 39e:	9fb1                	addw	a5,a5,a2
 3a0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3a4:	0006c603          	lbu	a2,0(a3)
 3a8:	fd06071b          	addiw	a4,a2,-48
 3ac:	0ff77713          	andi	a4,a4,255
 3b0:	fee5f1e3          	bgeu	a1,a4,392 <atoi+0x1e>
  return n;
}
 3b4:	6422                	ld	s0,8(sp)
 3b6:	0141                	addi	sp,sp,16
 3b8:	8082                	ret
  n = 0;
 3ba:	4501                	li	a0,0
 3bc:	bfe5                	j	3b4 <atoi+0x40>

00000000000003be <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3be:	1141                	addi	sp,sp,-16
 3c0:	e422                	sd	s0,8(sp)
 3c2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3c4:	02b57663          	bgeu	a0,a1,3f0 <memmove+0x32>
    while(n-- > 0)
 3c8:	02c05163          	blez	a2,3ea <memmove+0x2c>
 3cc:	fff6079b          	addiw	a5,a2,-1
 3d0:	1782                	slli	a5,a5,0x20
 3d2:	9381                	srli	a5,a5,0x20
 3d4:	0785                	addi	a5,a5,1
 3d6:	97aa                	add	a5,a5,a0
  dst = vdst;
 3d8:	872a                	mv	a4,a0
      *dst++ = *src++;
 3da:	0585                	addi	a1,a1,1
 3dc:	0705                	addi	a4,a4,1
 3de:	fff5c683          	lbu	a3,-1(a1)
 3e2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3e6:	fee79ae3          	bne	a5,a4,3da <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3ea:	6422                	ld	s0,8(sp)
 3ec:	0141                	addi	sp,sp,16
 3ee:	8082                	ret
    dst += n;
 3f0:	00c50733          	add	a4,a0,a2
    src += n;
 3f4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3f6:	fec05ae3          	blez	a2,3ea <memmove+0x2c>
 3fa:	fff6079b          	addiw	a5,a2,-1
 3fe:	1782                	slli	a5,a5,0x20
 400:	9381                	srli	a5,a5,0x20
 402:	fff7c793          	not	a5,a5
 406:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 408:	15fd                	addi	a1,a1,-1
 40a:	177d                	addi	a4,a4,-1
 40c:	0005c683          	lbu	a3,0(a1)
 410:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 414:	fee79ae3          	bne	a5,a4,408 <memmove+0x4a>
 418:	bfc9                	j	3ea <memmove+0x2c>

000000000000041a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 41a:	1141                	addi	sp,sp,-16
 41c:	e422                	sd	s0,8(sp)
 41e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 420:	ca05                	beqz	a2,450 <memcmp+0x36>
 422:	fff6069b          	addiw	a3,a2,-1
 426:	1682                	slli	a3,a3,0x20
 428:	9281                	srli	a3,a3,0x20
 42a:	0685                	addi	a3,a3,1
 42c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 42e:	00054783          	lbu	a5,0(a0)
 432:	0005c703          	lbu	a4,0(a1)
 436:	00e79863          	bne	a5,a4,446 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 43a:	0505                	addi	a0,a0,1
    p2++;
 43c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 43e:	fed518e3          	bne	a0,a3,42e <memcmp+0x14>
  }
  return 0;
 442:	4501                	li	a0,0
 444:	a019                	j	44a <memcmp+0x30>
      return *p1 - *p2;
 446:	40e7853b          	subw	a0,a5,a4
}
 44a:	6422                	ld	s0,8(sp)
 44c:	0141                	addi	sp,sp,16
 44e:	8082                	ret
  return 0;
 450:	4501                	li	a0,0
 452:	bfe5                	j	44a <memcmp+0x30>

0000000000000454 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 454:	1141                	addi	sp,sp,-16
 456:	e406                	sd	ra,8(sp)
 458:	e022                	sd	s0,0(sp)
 45a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 45c:	00000097          	auipc	ra,0x0
 460:	f62080e7          	jalr	-158(ra) # 3be <memmove>
}
 464:	60a2                	ld	ra,8(sp)
 466:	6402                	ld	s0,0(sp)
 468:	0141                	addi	sp,sp,16
 46a:	8082                	ret

000000000000046c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 46c:	4885                	li	a7,1
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <exit>:
.global exit
exit:
 li a7, SYS_exit
 474:	4889                	li	a7,2
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <wait>:
.global wait
wait:
 li a7, SYS_wait
 47c:	488d                	li	a7,3
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 484:	4891                	li	a7,4
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <read>:
.global read
read:
 li a7, SYS_read
 48c:	4895                	li	a7,5
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <write>:
.global write
write:
 li a7, SYS_write
 494:	48c1                	li	a7,16
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <close>:
.global close
close:
 li a7, SYS_close
 49c:	48d5                	li	a7,21
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4a4:	4899                	li	a7,6
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <exec>:
.global exec
exec:
 li a7, SYS_exec
 4ac:	489d                	li	a7,7
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <open>:
.global open
open:
 li a7, SYS_open
 4b4:	48bd                	li	a7,15
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4bc:	48c5                	li	a7,17
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4c4:	48c9                	li	a7,18
 ecall
 4c6:	00000073          	ecall
 ret
 4ca:	8082                	ret

00000000000004cc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4cc:	48a1                	li	a7,8
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <link>:
.global link
link:
 li a7, SYS_link
 4d4:	48cd                	li	a7,19
 ecall
 4d6:	00000073          	ecall
 ret
 4da:	8082                	ret

00000000000004dc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4dc:	48d1                	li	a7,20
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4e4:	48a5                	li	a7,9
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <dup>:
.global dup
dup:
 li a7, SYS_dup
 4ec:	48a9                	li	a7,10
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4f4:	48ad                	li	a7,11
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4fc:	48b1                	li	a7,12
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 504:	48b5                	li	a7,13
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 50c:	48b9                	li	a7,14
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 514:	1101                	addi	sp,sp,-32
 516:	ec06                	sd	ra,24(sp)
 518:	e822                	sd	s0,16(sp)
 51a:	1000                	addi	s0,sp,32
 51c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 520:	4605                	li	a2,1
 522:	fef40593          	addi	a1,s0,-17
 526:	00000097          	auipc	ra,0x0
 52a:	f6e080e7          	jalr	-146(ra) # 494 <write>
}
 52e:	60e2                	ld	ra,24(sp)
 530:	6442                	ld	s0,16(sp)
 532:	6105                	addi	sp,sp,32
 534:	8082                	ret

0000000000000536 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 536:	7139                	addi	sp,sp,-64
 538:	fc06                	sd	ra,56(sp)
 53a:	f822                	sd	s0,48(sp)
 53c:	f426                	sd	s1,40(sp)
 53e:	f04a                	sd	s2,32(sp)
 540:	ec4e                	sd	s3,24(sp)
 542:	0080                	addi	s0,sp,64
 544:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 546:	c299                	beqz	a3,54c <printint+0x16>
 548:	0805c863          	bltz	a1,5d8 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 54c:	2581                	sext.w	a1,a1
  neg = 0;
 54e:	4881                	li	a7,0
 550:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 554:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 556:	2601                	sext.w	a2,a2
 558:	00000517          	auipc	a0,0x0
 55c:	4b850513          	addi	a0,a0,1208 # a10 <digits>
 560:	883a                	mv	a6,a4
 562:	2705                	addiw	a4,a4,1
 564:	02c5f7bb          	remuw	a5,a1,a2
 568:	1782                	slli	a5,a5,0x20
 56a:	9381                	srli	a5,a5,0x20
 56c:	97aa                	add	a5,a5,a0
 56e:	0007c783          	lbu	a5,0(a5)
 572:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 576:	0005879b          	sext.w	a5,a1
 57a:	02c5d5bb          	divuw	a1,a1,a2
 57e:	0685                	addi	a3,a3,1
 580:	fec7f0e3          	bgeu	a5,a2,560 <printint+0x2a>
  if(neg)
 584:	00088b63          	beqz	a7,59a <printint+0x64>
    buf[i++] = '-';
 588:	fd040793          	addi	a5,s0,-48
 58c:	973e                	add	a4,a4,a5
 58e:	02d00793          	li	a5,45
 592:	fef70823          	sb	a5,-16(a4)
 596:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 59a:	02e05863          	blez	a4,5ca <printint+0x94>
 59e:	fc040793          	addi	a5,s0,-64
 5a2:	00e78933          	add	s2,a5,a4
 5a6:	fff78993          	addi	s3,a5,-1
 5aa:	99ba                	add	s3,s3,a4
 5ac:	377d                	addiw	a4,a4,-1
 5ae:	1702                	slli	a4,a4,0x20
 5b0:	9301                	srli	a4,a4,0x20
 5b2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5b6:	fff94583          	lbu	a1,-1(s2)
 5ba:	8526                	mv	a0,s1
 5bc:	00000097          	auipc	ra,0x0
 5c0:	f58080e7          	jalr	-168(ra) # 514 <putc>
  while(--i >= 0)
 5c4:	197d                	addi	s2,s2,-1
 5c6:	ff3918e3          	bne	s2,s3,5b6 <printint+0x80>
}
 5ca:	70e2                	ld	ra,56(sp)
 5cc:	7442                	ld	s0,48(sp)
 5ce:	74a2                	ld	s1,40(sp)
 5d0:	7902                	ld	s2,32(sp)
 5d2:	69e2                	ld	s3,24(sp)
 5d4:	6121                	addi	sp,sp,64
 5d6:	8082                	ret
    x = -xx;
 5d8:	40b005bb          	negw	a1,a1
    neg = 1;
 5dc:	4885                	li	a7,1
    x = -xx;
 5de:	bf8d                	j	550 <printint+0x1a>

00000000000005e0 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5e0:	7119                	addi	sp,sp,-128
 5e2:	fc86                	sd	ra,120(sp)
 5e4:	f8a2                	sd	s0,112(sp)
 5e6:	f4a6                	sd	s1,104(sp)
 5e8:	f0ca                	sd	s2,96(sp)
 5ea:	ecce                	sd	s3,88(sp)
 5ec:	e8d2                	sd	s4,80(sp)
 5ee:	e4d6                	sd	s5,72(sp)
 5f0:	e0da                	sd	s6,64(sp)
 5f2:	fc5e                	sd	s7,56(sp)
 5f4:	f862                	sd	s8,48(sp)
 5f6:	f466                	sd	s9,40(sp)
 5f8:	f06a                	sd	s10,32(sp)
 5fa:	ec6e                	sd	s11,24(sp)
 5fc:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5fe:	0005c903          	lbu	s2,0(a1)
 602:	18090f63          	beqz	s2,7a0 <vprintf+0x1c0>
 606:	8aaa                	mv	s5,a0
 608:	8b32                	mv	s6,a2
 60a:	00158493          	addi	s1,a1,1
  state = 0;
 60e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 610:	02500a13          	li	s4,37
      if(c == 'd'){
 614:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 618:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 61c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 620:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 624:	00000b97          	auipc	s7,0x0
 628:	3ecb8b93          	addi	s7,s7,1004 # a10 <digits>
 62c:	a839                	j	64a <vprintf+0x6a>
        putc(fd, c);
 62e:	85ca                	mv	a1,s2
 630:	8556                	mv	a0,s5
 632:	00000097          	auipc	ra,0x0
 636:	ee2080e7          	jalr	-286(ra) # 514 <putc>
 63a:	a019                	j	640 <vprintf+0x60>
    } else if(state == '%'){
 63c:	01498f63          	beq	s3,s4,65a <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 640:	0485                	addi	s1,s1,1
 642:	fff4c903          	lbu	s2,-1(s1)
 646:	14090d63          	beqz	s2,7a0 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 64a:	0009079b          	sext.w	a5,s2
    if(state == 0){
 64e:	fe0997e3          	bnez	s3,63c <vprintf+0x5c>
      if(c == '%'){
 652:	fd479ee3          	bne	a5,s4,62e <vprintf+0x4e>
        state = '%';
 656:	89be                	mv	s3,a5
 658:	b7e5                	j	640 <vprintf+0x60>
      if(c == 'd'){
 65a:	05878063          	beq	a5,s8,69a <vprintf+0xba>
      } else if(c == 'l') {
 65e:	05978c63          	beq	a5,s9,6b6 <vprintf+0xd6>
      } else if(c == 'x') {
 662:	07a78863          	beq	a5,s10,6d2 <vprintf+0xf2>
      } else if(c == 'p') {
 666:	09b78463          	beq	a5,s11,6ee <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 66a:	07300713          	li	a4,115
 66e:	0ce78663          	beq	a5,a4,73a <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 672:	06300713          	li	a4,99
 676:	0ee78e63          	beq	a5,a4,772 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 67a:	11478863          	beq	a5,s4,78a <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 67e:	85d2                	mv	a1,s4
 680:	8556                	mv	a0,s5
 682:	00000097          	auipc	ra,0x0
 686:	e92080e7          	jalr	-366(ra) # 514 <putc>
        putc(fd, c);
 68a:	85ca                	mv	a1,s2
 68c:	8556                	mv	a0,s5
 68e:	00000097          	auipc	ra,0x0
 692:	e86080e7          	jalr	-378(ra) # 514 <putc>
      }
      state = 0;
 696:	4981                	li	s3,0
 698:	b765                	j	640 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 69a:	008b0913          	addi	s2,s6,8
 69e:	4685                	li	a3,1
 6a0:	4629                	li	a2,10
 6a2:	000b2583          	lw	a1,0(s6)
 6a6:	8556                	mv	a0,s5
 6a8:	00000097          	auipc	ra,0x0
 6ac:	e8e080e7          	jalr	-370(ra) # 536 <printint>
 6b0:	8b4a                	mv	s6,s2
      state = 0;
 6b2:	4981                	li	s3,0
 6b4:	b771                	j	640 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6b6:	008b0913          	addi	s2,s6,8
 6ba:	4681                	li	a3,0
 6bc:	4629                	li	a2,10
 6be:	000b2583          	lw	a1,0(s6)
 6c2:	8556                	mv	a0,s5
 6c4:	00000097          	auipc	ra,0x0
 6c8:	e72080e7          	jalr	-398(ra) # 536 <printint>
 6cc:	8b4a                	mv	s6,s2
      state = 0;
 6ce:	4981                	li	s3,0
 6d0:	bf85                	j	640 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6d2:	008b0913          	addi	s2,s6,8
 6d6:	4681                	li	a3,0
 6d8:	4641                	li	a2,16
 6da:	000b2583          	lw	a1,0(s6)
 6de:	8556                	mv	a0,s5
 6e0:	00000097          	auipc	ra,0x0
 6e4:	e56080e7          	jalr	-426(ra) # 536 <printint>
 6e8:	8b4a                	mv	s6,s2
      state = 0;
 6ea:	4981                	li	s3,0
 6ec:	bf91                	j	640 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6ee:	008b0793          	addi	a5,s6,8
 6f2:	f8f43423          	sd	a5,-120(s0)
 6f6:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6fa:	03000593          	li	a1,48
 6fe:	8556                	mv	a0,s5
 700:	00000097          	auipc	ra,0x0
 704:	e14080e7          	jalr	-492(ra) # 514 <putc>
  putc(fd, 'x');
 708:	85ea                	mv	a1,s10
 70a:	8556                	mv	a0,s5
 70c:	00000097          	auipc	ra,0x0
 710:	e08080e7          	jalr	-504(ra) # 514 <putc>
 714:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 716:	03c9d793          	srli	a5,s3,0x3c
 71a:	97de                	add	a5,a5,s7
 71c:	0007c583          	lbu	a1,0(a5)
 720:	8556                	mv	a0,s5
 722:	00000097          	auipc	ra,0x0
 726:	df2080e7          	jalr	-526(ra) # 514 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 72a:	0992                	slli	s3,s3,0x4
 72c:	397d                	addiw	s2,s2,-1
 72e:	fe0914e3          	bnez	s2,716 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 732:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 736:	4981                	li	s3,0
 738:	b721                	j	640 <vprintf+0x60>
        s = va_arg(ap, char*);
 73a:	008b0993          	addi	s3,s6,8
 73e:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 742:	02090163          	beqz	s2,764 <vprintf+0x184>
        while(*s != 0){
 746:	00094583          	lbu	a1,0(s2)
 74a:	c9a1                	beqz	a1,79a <vprintf+0x1ba>
          putc(fd, *s);
 74c:	8556                	mv	a0,s5
 74e:	00000097          	auipc	ra,0x0
 752:	dc6080e7          	jalr	-570(ra) # 514 <putc>
          s++;
 756:	0905                	addi	s2,s2,1
        while(*s != 0){
 758:	00094583          	lbu	a1,0(s2)
 75c:	f9e5                	bnez	a1,74c <vprintf+0x16c>
        s = va_arg(ap, char*);
 75e:	8b4e                	mv	s6,s3
      state = 0;
 760:	4981                	li	s3,0
 762:	bdf9                	j	640 <vprintf+0x60>
          s = "(null)";
 764:	00000917          	auipc	s2,0x0
 768:	2a490913          	addi	s2,s2,676 # a08 <longjmp_1+0x8>
        while(*s != 0){
 76c:	02800593          	li	a1,40
 770:	bff1                	j	74c <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 772:	008b0913          	addi	s2,s6,8
 776:	000b4583          	lbu	a1,0(s6)
 77a:	8556                	mv	a0,s5
 77c:	00000097          	auipc	ra,0x0
 780:	d98080e7          	jalr	-616(ra) # 514 <putc>
 784:	8b4a                	mv	s6,s2
      state = 0;
 786:	4981                	li	s3,0
 788:	bd65                	j	640 <vprintf+0x60>
        putc(fd, c);
 78a:	85d2                	mv	a1,s4
 78c:	8556                	mv	a0,s5
 78e:	00000097          	auipc	ra,0x0
 792:	d86080e7          	jalr	-634(ra) # 514 <putc>
      state = 0;
 796:	4981                	li	s3,0
 798:	b565                	j	640 <vprintf+0x60>
        s = va_arg(ap, char*);
 79a:	8b4e                	mv	s6,s3
      state = 0;
 79c:	4981                	li	s3,0
 79e:	b54d                	j	640 <vprintf+0x60>
    }
  }
}
 7a0:	70e6                	ld	ra,120(sp)
 7a2:	7446                	ld	s0,112(sp)
 7a4:	74a6                	ld	s1,104(sp)
 7a6:	7906                	ld	s2,96(sp)
 7a8:	69e6                	ld	s3,88(sp)
 7aa:	6a46                	ld	s4,80(sp)
 7ac:	6aa6                	ld	s5,72(sp)
 7ae:	6b06                	ld	s6,64(sp)
 7b0:	7be2                	ld	s7,56(sp)
 7b2:	7c42                	ld	s8,48(sp)
 7b4:	7ca2                	ld	s9,40(sp)
 7b6:	7d02                	ld	s10,32(sp)
 7b8:	6de2                	ld	s11,24(sp)
 7ba:	6109                	addi	sp,sp,128
 7bc:	8082                	ret

00000000000007be <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7be:	715d                	addi	sp,sp,-80
 7c0:	ec06                	sd	ra,24(sp)
 7c2:	e822                	sd	s0,16(sp)
 7c4:	1000                	addi	s0,sp,32
 7c6:	e010                	sd	a2,0(s0)
 7c8:	e414                	sd	a3,8(s0)
 7ca:	e818                	sd	a4,16(s0)
 7cc:	ec1c                	sd	a5,24(s0)
 7ce:	03043023          	sd	a6,32(s0)
 7d2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7d6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7da:	8622                	mv	a2,s0
 7dc:	00000097          	auipc	ra,0x0
 7e0:	e04080e7          	jalr	-508(ra) # 5e0 <vprintf>
}
 7e4:	60e2                	ld	ra,24(sp)
 7e6:	6442                	ld	s0,16(sp)
 7e8:	6161                	addi	sp,sp,80
 7ea:	8082                	ret

00000000000007ec <printf>:

void
printf(const char *fmt, ...)
{
 7ec:	711d                	addi	sp,sp,-96
 7ee:	ec06                	sd	ra,24(sp)
 7f0:	e822                	sd	s0,16(sp)
 7f2:	1000                	addi	s0,sp,32
 7f4:	e40c                	sd	a1,8(s0)
 7f6:	e810                	sd	a2,16(s0)
 7f8:	ec14                	sd	a3,24(s0)
 7fa:	f018                	sd	a4,32(s0)
 7fc:	f41c                	sd	a5,40(s0)
 7fe:	03043823          	sd	a6,48(s0)
 802:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 806:	00840613          	addi	a2,s0,8
 80a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 80e:	85aa                	mv	a1,a0
 810:	4505                	li	a0,1
 812:	00000097          	auipc	ra,0x0
 816:	dce080e7          	jalr	-562(ra) # 5e0 <vprintf>
}
 81a:	60e2                	ld	ra,24(sp)
 81c:	6442                	ld	s0,16(sp)
 81e:	6125                	addi	sp,sp,96
 820:	8082                	ret

0000000000000822 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 822:	1141                	addi	sp,sp,-16
 824:	e422                	sd	s0,8(sp)
 826:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 828:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 82c:	00000797          	auipc	a5,0x0
 830:	2047b783          	ld	a5,516(a5) # a30 <freep>
 834:	a805                	j	864 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 836:	4618                	lw	a4,8(a2)
 838:	9db9                	addw	a1,a1,a4
 83a:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 83e:	6398                	ld	a4,0(a5)
 840:	6318                	ld	a4,0(a4)
 842:	fee53823          	sd	a4,-16(a0)
 846:	a091                	j	88a <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 848:	ff852703          	lw	a4,-8(a0)
 84c:	9e39                	addw	a2,a2,a4
 84e:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 850:	ff053703          	ld	a4,-16(a0)
 854:	e398                	sd	a4,0(a5)
 856:	a099                	j	89c <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 858:	6398                	ld	a4,0(a5)
 85a:	00e7e463          	bltu	a5,a4,862 <free+0x40>
 85e:	00e6ea63          	bltu	a3,a4,872 <free+0x50>
{
 862:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 864:	fed7fae3          	bgeu	a5,a3,858 <free+0x36>
 868:	6398                	ld	a4,0(a5)
 86a:	00e6e463          	bltu	a3,a4,872 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 86e:	fee7eae3          	bltu	a5,a4,862 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 872:	ff852583          	lw	a1,-8(a0)
 876:	6390                	ld	a2,0(a5)
 878:	02059713          	slli	a4,a1,0x20
 87c:	9301                	srli	a4,a4,0x20
 87e:	0712                	slli	a4,a4,0x4
 880:	9736                	add	a4,a4,a3
 882:	fae60ae3          	beq	a2,a4,836 <free+0x14>
    bp->s.ptr = p->s.ptr;
 886:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 88a:	4790                	lw	a2,8(a5)
 88c:	02061713          	slli	a4,a2,0x20
 890:	9301                	srli	a4,a4,0x20
 892:	0712                	slli	a4,a4,0x4
 894:	973e                	add	a4,a4,a5
 896:	fae689e3          	beq	a3,a4,848 <free+0x26>
  } else
    p->s.ptr = bp;
 89a:	e394                	sd	a3,0(a5)
  freep = p;
 89c:	00000717          	auipc	a4,0x0
 8a0:	18f73a23          	sd	a5,404(a4) # a30 <freep>
}
 8a4:	6422                	ld	s0,8(sp)
 8a6:	0141                	addi	sp,sp,16
 8a8:	8082                	ret

00000000000008aa <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8aa:	7139                	addi	sp,sp,-64
 8ac:	fc06                	sd	ra,56(sp)
 8ae:	f822                	sd	s0,48(sp)
 8b0:	f426                	sd	s1,40(sp)
 8b2:	f04a                	sd	s2,32(sp)
 8b4:	ec4e                	sd	s3,24(sp)
 8b6:	e852                	sd	s4,16(sp)
 8b8:	e456                	sd	s5,8(sp)
 8ba:	e05a                	sd	s6,0(sp)
 8bc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8be:	02051493          	slli	s1,a0,0x20
 8c2:	9081                	srli	s1,s1,0x20
 8c4:	04bd                	addi	s1,s1,15
 8c6:	8091                	srli	s1,s1,0x4
 8c8:	0014899b          	addiw	s3,s1,1
 8cc:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8ce:	00000517          	auipc	a0,0x0
 8d2:	16253503          	ld	a0,354(a0) # a30 <freep>
 8d6:	c515                	beqz	a0,902 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8da:	4798                	lw	a4,8(a5)
 8dc:	02977f63          	bgeu	a4,s1,91a <malloc+0x70>
 8e0:	8a4e                	mv	s4,s3
 8e2:	0009871b          	sext.w	a4,s3
 8e6:	6685                	lui	a3,0x1
 8e8:	00d77363          	bgeu	a4,a3,8ee <malloc+0x44>
 8ec:	6a05                	lui	s4,0x1
 8ee:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8f2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8f6:	00000917          	auipc	s2,0x0
 8fa:	13a90913          	addi	s2,s2,314 # a30 <freep>
  if(p == (char*)-1)
 8fe:	5afd                	li	s5,-1
 900:	a88d                	j	972 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 902:	00000797          	auipc	a5,0x0
 906:	13678793          	addi	a5,a5,310 # a38 <base>
 90a:	00000717          	auipc	a4,0x0
 90e:	12f73323          	sd	a5,294(a4) # a30 <freep>
 912:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 914:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 918:	b7e1                	j	8e0 <malloc+0x36>
      if(p->s.size == nunits)
 91a:	02e48b63          	beq	s1,a4,950 <malloc+0xa6>
        p->s.size -= nunits;
 91e:	4137073b          	subw	a4,a4,s3
 922:	c798                	sw	a4,8(a5)
        p += p->s.size;
 924:	1702                	slli	a4,a4,0x20
 926:	9301                	srli	a4,a4,0x20
 928:	0712                	slli	a4,a4,0x4
 92a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 92c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 930:	00000717          	auipc	a4,0x0
 934:	10a73023          	sd	a0,256(a4) # a30 <freep>
      return (void*)(p + 1);
 938:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 93c:	70e2                	ld	ra,56(sp)
 93e:	7442                	ld	s0,48(sp)
 940:	74a2                	ld	s1,40(sp)
 942:	7902                	ld	s2,32(sp)
 944:	69e2                	ld	s3,24(sp)
 946:	6a42                	ld	s4,16(sp)
 948:	6aa2                	ld	s5,8(sp)
 94a:	6b02                	ld	s6,0(sp)
 94c:	6121                	addi	sp,sp,64
 94e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 950:	6398                	ld	a4,0(a5)
 952:	e118                	sd	a4,0(a0)
 954:	bff1                	j	930 <malloc+0x86>
  hp->s.size = nu;
 956:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 95a:	0541                	addi	a0,a0,16
 95c:	00000097          	auipc	ra,0x0
 960:	ec6080e7          	jalr	-314(ra) # 822 <free>
  return freep;
 964:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 968:	d971                	beqz	a0,93c <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 96a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 96c:	4798                	lw	a4,8(a5)
 96e:	fa9776e3          	bgeu	a4,s1,91a <malloc+0x70>
    if(p == freep)
 972:	00093703          	ld	a4,0(s2)
 976:	853e                	mv	a0,a5
 978:	fef719e3          	bne	a4,a5,96a <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 97c:	8552                	mv	a0,s4
 97e:	00000097          	auipc	ra,0x0
 982:	b7e080e7          	jalr	-1154(ra) # 4fc <sbrk>
  if(p == (char*)-1)
 986:	fd5518e3          	bne	a0,s5,956 <malloc+0xac>
        return 0;
 98a:	4501                	li	a0,0
 98c:	bf45                	j	93c <malloc+0x92>

000000000000098e <setjmp>:
 98e:	e100                	sd	s0,0(a0)
 990:	e504                	sd	s1,8(a0)
 992:	01253823          	sd	s2,16(a0)
 996:	01353c23          	sd	s3,24(a0)
 99a:	03453023          	sd	s4,32(a0)
 99e:	03553423          	sd	s5,40(a0)
 9a2:	03653823          	sd	s6,48(a0)
 9a6:	03753c23          	sd	s7,56(a0)
 9aa:	05853023          	sd	s8,64(a0)
 9ae:	05953423          	sd	s9,72(a0)
 9b2:	05a53823          	sd	s10,80(a0)
 9b6:	05b53c23          	sd	s11,88(a0)
 9ba:	06153023          	sd	ra,96(a0)
 9be:	06253423          	sd	sp,104(a0)
 9c2:	4501                	li	a0,0
 9c4:	8082                	ret

00000000000009c6 <longjmp>:
 9c6:	6100                	ld	s0,0(a0)
 9c8:	6504                	ld	s1,8(a0)
 9ca:	01053903          	ld	s2,16(a0)
 9ce:	01853983          	ld	s3,24(a0)
 9d2:	02053a03          	ld	s4,32(a0)
 9d6:	02853a83          	ld	s5,40(a0)
 9da:	03053b03          	ld	s6,48(a0)
 9de:	03853b83          	ld	s7,56(a0)
 9e2:	04053c03          	ld	s8,64(a0)
 9e6:	04853c83          	ld	s9,72(a0)
 9ea:	05053d03          	ld	s10,80(a0)
 9ee:	05853d83          	ld	s11,88(a0)
 9f2:	06053083          	ld	ra,96(a0)
 9f6:	06853103          	ld	sp,104(a0)
 9fa:	c199                	beqz	a1,a00 <longjmp_1>
 9fc:	852e                	mv	a0,a1
 9fe:	8082                	ret

0000000000000a00 <longjmp_1>:
 a00:	4505                	li	a0,1
 a02:	8082                	ret
