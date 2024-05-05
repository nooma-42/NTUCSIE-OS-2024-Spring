
user/_custom_rttask6:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <f>:
#define NULL 0

int k = 0;

void f(void *arg)
{
       0:	1101                	addi	sp,sp,-32
       2:	ec22                	sd	s0,24(sp)
       4:	1000                	addi	s0,sp,32
       6:	fea43423          	sd	a0,-24(s0)
    while (1) {
        k++;
       a:	00003797          	auipc	a5,0x3
       e:	8c678793          	addi	a5,a5,-1850 # 28d0 <k>
      12:	439c                	lw	a5,0(a5)
      14:	2785                	addiw	a5,a5,1
      16:	0007871b          	sext.w	a4,a5
      1a:	00003797          	auipc	a5,0x3
      1e:	8b678793          	addi	a5,a5,-1866 # 28d0 <k>
      22:	c398                	sw	a4,0(a5)
      24:	b7dd                	j	a <f+0xa>

0000000000000026 <main>:
}

// 15 threads arriving @ different times w same deadline

int main(int argc, char **argv)
{   
      26:	7139                	addi	sp,sp,-64
      28:	fc06                	sd	ra,56(sp)
      2a:	f822                	sd	s0,48(sp)
      2c:	0080                	addi	s0,sp,64
      2e:	87aa                	mv	a5,a0
      30:	fcb43023          	sd	a1,-64(s0)
      34:	fcf42623          	sw	a5,-52(s0)
    struct thread *t0 = thread_create(f, NULL, 1,6,6,1);
      38:	4785                	li	a5,1
      3a:	4719                	li	a4,6
      3c:	4699                	li	a3,6
      3e:	4605                	li	a2,1
      40:	4581                	li	a1,0
      42:	00000517          	auipc	a0,0x0
      46:	fbe50513          	addi	a0,a0,-66 # 0 <f>
      4a:	00001097          	auipc	ra,0x1
      4e:	f32080e7          	jalr	-206(ra) # f7c <thread_create>
      52:	fea43023          	sd	a0,-32(s0)
    thread_add_at(t0, 19);
      56:	45cd                	li	a1,19
      58:	fe043503          	ld	a0,-32(s0)
      5c:	00001097          	auipc	ra,0x1
      60:	04c080e7          	jalr	76(ra) # 10a8 <thread_add_at>
    for(int i=2;i<=15;i++){
      64:	4789                	li	a5,2
      66:	fef42623          	sw	a5,-20(s0)
      6a:	a891                	j	be <main+0x98>
        struct thread *t = thread_create(f, NULL, 1,23-(16-i),23-(16-i),1);
      6c:	fec42783          	lw	a5,-20(s0)
      70:	279d                	addiw	a5,a5,7
      72:	0007869b          	sext.w	a3,a5
      76:	fec42783          	lw	a5,-20(s0)
      7a:	279d                	addiw	a5,a5,7
      7c:	0007871b          	sext.w	a4,a5
      80:	4785                	li	a5,1
      82:	4605                	li	a2,1
      84:	4581                	li	a1,0
      86:	00000517          	auipc	a0,0x0
      8a:	f7a50513          	addi	a0,a0,-134 # 0 <f>
      8e:	00001097          	auipc	ra,0x1
      92:	eee080e7          	jalr	-274(ra) # f7c <thread_create>
      96:	fca43c23          	sd	a0,-40(s0)
        thread_add_at(t, 16-i);
      9a:	4741                	li	a4,16
      9c:	fec42783          	lw	a5,-20(s0)
      a0:	40f707bb          	subw	a5,a4,a5
      a4:	2781                	sext.w	a5,a5
      a6:	85be                	mv	a1,a5
      a8:	fd843503          	ld	a0,-40(s0)
      ac:	00001097          	auipc	ra,0x1
      b0:	ffc080e7          	jalr	-4(ra) # 10a8 <thread_add_at>
    for(int i=2;i<=15;i++){
      b4:	fec42783          	lw	a5,-20(s0)
      b8:	2785                	addiw	a5,a5,1
      ba:	fef42623          	sw	a5,-20(s0)
      be:	fec42783          	lw	a5,-20(s0)
      c2:	0007871b          	sext.w	a4,a5
      c6:	47bd                	li	a5,15
      c8:	fae7d2e3          	bge	a5,a4,6c <main+0x46>
    }
    thread_start_threading();
      cc:	00001097          	auipc	ra,0x1
      d0:	7ea080e7          	jalr	2026(ra) # 18b6 <thread_start_threading>
    printf("\nexited\n");
      d4:	00002517          	auipc	a0,0x2
      d8:	66450513          	addi	a0,a0,1636 # 2738 <schedule_dm+0x2d6>
      dc:	00001097          	auipc	ra,0x1
      e0:	9e8080e7          	jalr	-1560(ra) # ac4 <printf>
    exit(0);
      e4:	4501                	li	a0,0
      e6:	00000097          	auipc	ra,0x0
      ea:	498080e7          	jalr	1176(ra) # 57e <exit>

00000000000000ee <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
      ee:	7179                	addi	sp,sp,-48
      f0:	f422                	sd	s0,40(sp)
      f2:	1800                	addi	s0,sp,48
      f4:	fca43c23          	sd	a0,-40(s0)
      f8:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
      fc:	fd843783          	ld	a5,-40(s0)
     100:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     104:	0001                	nop
     106:	fd043703          	ld	a4,-48(s0)
     10a:	00170793          	addi	a5,a4,1
     10e:	fcf43823          	sd	a5,-48(s0)
     112:	fd843783          	ld	a5,-40(s0)
     116:	00178693          	addi	a3,a5,1
     11a:	fcd43c23          	sd	a3,-40(s0)
     11e:	00074703          	lbu	a4,0(a4)
     122:	00e78023          	sb	a4,0(a5)
     126:	0007c783          	lbu	a5,0(a5)
     12a:	fff1                	bnez	a5,106 <strcpy+0x18>
    ;
  return os;
     12c:	fe843783          	ld	a5,-24(s0)
}
     130:	853e                	mv	a0,a5
     132:	7422                	ld	s0,40(sp)
     134:	6145                	addi	sp,sp,48
     136:	8082                	ret

0000000000000138 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     138:	1101                	addi	sp,sp,-32
     13a:	ec22                	sd	s0,24(sp)
     13c:	1000                	addi	s0,sp,32
     13e:	fea43423          	sd	a0,-24(s0)
     142:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     146:	a819                	j	15c <strcmp+0x24>
    p++, q++;
     148:	fe843783          	ld	a5,-24(s0)
     14c:	0785                	addi	a5,a5,1
     14e:	fef43423          	sd	a5,-24(s0)
     152:	fe043783          	ld	a5,-32(s0)
     156:	0785                	addi	a5,a5,1
     158:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     15c:	fe843783          	ld	a5,-24(s0)
     160:	0007c783          	lbu	a5,0(a5)
     164:	cb99                	beqz	a5,17a <strcmp+0x42>
     166:	fe843783          	ld	a5,-24(s0)
     16a:	0007c703          	lbu	a4,0(a5)
     16e:	fe043783          	ld	a5,-32(s0)
     172:	0007c783          	lbu	a5,0(a5)
     176:	fcf709e3          	beq	a4,a5,148 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     17a:	fe843783          	ld	a5,-24(s0)
     17e:	0007c783          	lbu	a5,0(a5)
     182:	0007871b          	sext.w	a4,a5
     186:	fe043783          	ld	a5,-32(s0)
     18a:	0007c783          	lbu	a5,0(a5)
     18e:	2781                	sext.w	a5,a5
     190:	40f707bb          	subw	a5,a4,a5
     194:	2781                	sext.w	a5,a5
}
     196:	853e                	mv	a0,a5
     198:	6462                	ld	s0,24(sp)
     19a:	6105                	addi	sp,sp,32
     19c:	8082                	ret

000000000000019e <strlen>:

uint
strlen(const char *s)
{
     19e:	7179                	addi	sp,sp,-48
     1a0:	f422                	sd	s0,40(sp)
     1a2:	1800                	addi	s0,sp,48
     1a4:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     1a8:	fe042623          	sw	zero,-20(s0)
     1ac:	a031                	j	1b8 <strlen+0x1a>
     1ae:	fec42783          	lw	a5,-20(s0)
     1b2:	2785                	addiw	a5,a5,1
     1b4:	fef42623          	sw	a5,-20(s0)
     1b8:	fec42783          	lw	a5,-20(s0)
     1bc:	fd843703          	ld	a4,-40(s0)
     1c0:	97ba                	add	a5,a5,a4
     1c2:	0007c783          	lbu	a5,0(a5)
     1c6:	f7e5                	bnez	a5,1ae <strlen+0x10>
    ;
  return n;
     1c8:	fec42783          	lw	a5,-20(s0)
}
     1cc:	853e                	mv	a0,a5
     1ce:	7422                	ld	s0,40(sp)
     1d0:	6145                	addi	sp,sp,48
     1d2:	8082                	ret

00000000000001d4 <memset>:

void*
memset(void *dst, int c, uint n)
{
     1d4:	7179                	addi	sp,sp,-48
     1d6:	f422                	sd	s0,40(sp)
     1d8:	1800                	addi	s0,sp,48
     1da:	fca43c23          	sd	a0,-40(s0)
     1de:	87ae                	mv	a5,a1
     1e0:	8732                	mv	a4,a2
     1e2:	fcf42a23          	sw	a5,-44(s0)
     1e6:	87ba                	mv	a5,a4
     1e8:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     1ec:	fd843783          	ld	a5,-40(s0)
     1f0:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     1f4:	fe042623          	sw	zero,-20(s0)
     1f8:	a00d                	j	21a <memset+0x46>
    cdst[i] = c;
     1fa:	fec42783          	lw	a5,-20(s0)
     1fe:	fe043703          	ld	a4,-32(s0)
     202:	97ba                	add	a5,a5,a4
     204:	fd442703          	lw	a4,-44(s0)
     208:	0ff77713          	andi	a4,a4,255
     20c:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     210:	fec42783          	lw	a5,-20(s0)
     214:	2785                	addiw	a5,a5,1
     216:	fef42623          	sw	a5,-20(s0)
     21a:	fec42703          	lw	a4,-20(s0)
     21e:	fd042783          	lw	a5,-48(s0)
     222:	2781                	sext.w	a5,a5
     224:	fcf76be3          	bltu	a4,a5,1fa <memset+0x26>
  }
  return dst;
     228:	fd843783          	ld	a5,-40(s0)
}
     22c:	853e                	mv	a0,a5
     22e:	7422                	ld	s0,40(sp)
     230:	6145                	addi	sp,sp,48
     232:	8082                	ret

0000000000000234 <strchr>:

char*
strchr(const char *s, char c)
{
     234:	1101                	addi	sp,sp,-32
     236:	ec22                	sd	s0,24(sp)
     238:	1000                	addi	s0,sp,32
     23a:	fea43423          	sd	a0,-24(s0)
     23e:	87ae                	mv	a5,a1
     240:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     244:	a01d                	j	26a <strchr+0x36>
    if(*s == c)
     246:	fe843783          	ld	a5,-24(s0)
     24a:	0007c703          	lbu	a4,0(a5)
     24e:	fe744783          	lbu	a5,-25(s0)
     252:	0ff7f793          	andi	a5,a5,255
     256:	00e79563          	bne	a5,a4,260 <strchr+0x2c>
      return (char*)s;
     25a:	fe843783          	ld	a5,-24(s0)
     25e:	a821                	j	276 <strchr+0x42>
  for(; *s; s++)
     260:	fe843783          	ld	a5,-24(s0)
     264:	0785                	addi	a5,a5,1
     266:	fef43423          	sd	a5,-24(s0)
     26a:	fe843783          	ld	a5,-24(s0)
     26e:	0007c783          	lbu	a5,0(a5)
     272:	fbf1                	bnez	a5,246 <strchr+0x12>
  return 0;
     274:	4781                	li	a5,0
}
     276:	853e                	mv	a0,a5
     278:	6462                	ld	s0,24(sp)
     27a:	6105                	addi	sp,sp,32
     27c:	8082                	ret

000000000000027e <gets>:

char*
gets(char *buf, int max)
{
     27e:	7179                	addi	sp,sp,-48
     280:	f406                	sd	ra,40(sp)
     282:	f022                	sd	s0,32(sp)
     284:	1800                	addi	s0,sp,48
     286:	fca43c23          	sd	a0,-40(s0)
     28a:	87ae                	mv	a5,a1
     28c:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     290:	fe042623          	sw	zero,-20(s0)
     294:	a8a1                	j	2ec <gets+0x6e>
    cc = read(0, &c, 1);
     296:	fe740793          	addi	a5,s0,-25
     29a:	4605                	li	a2,1
     29c:	85be                	mv	a1,a5
     29e:	4501                	li	a0,0
     2a0:	00000097          	auipc	ra,0x0
     2a4:	2f6080e7          	jalr	758(ra) # 596 <read>
     2a8:	87aa                	mv	a5,a0
     2aa:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     2ae:	fe842783          	lw	a5,-24(s0)
     2b2:	2781                	sext.w	a5,a5
     2b4:	04f05763          	blez	a5,302 <gets+0x84>
      break;
    buf[i++] = c;
     2b8:	fec42783          	lw	a5,-20(s0)
     2bc:	0017871b          	addiw	a4,a5,1
     2c0:	fee42623          	sw	a4,-20(s0)
     2c4:	873e                	mv	a4,a5
     2c6:	fd843783          	ld	a5,-40(s0)
     2ca:	97ba                	add	a5,a5,a4
     2cc:	fe744703          	lbu	a4,-25(s0)
     2d0:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     2d4:	fe744783          	lbu	a5,-25(s0)
     2d8:	873e                	mv	a4,a5
     2da:	47a9                	li	a5,10
     2dc:	02f70463          	beq	a4,a5,304 <gets+0x86>
     2e0:	fe744783          	lbu	a5,-25(s0)
     2e4:	873e                	mv	a4,a5
     2e6:	47b5                	li	a5,13
     2e8:	00f70e63          	beq	a4,a5,304 <gets+0x86>
  for(i=0; i+1 < max; ){
     2ec:	fec42783          	lw	a5,-20(s0)
     2f0:	2785                	addiw	a5,a5,1
     2f2:	0007871b          	sext.w	a4,a5
     2f6:	fd442783          	lw	a5,-44(s0)
     2fa:	2781                	sext.w	a5,a5
     2fc:	f8f74de3          	blt	a4,a5,296 <gets+0x18>
     300:	a011                	j	304 <gets+0x86>
      break;
     302:	0001                	nop
      break;
  }
  buf[i] = '\0';
     304:	fec42783          	lw	a5,-20(s0)
     308:	fd843703          	ld	a4,-40(s0)
     30c:	97ba                	add	a5,a5,a4
     30e:	00078023          	sb	zero,0(a5)
  return buf;
     312:	fd843783          	ld	a5,-40(s0)
}
     316:	853e                	mv	a0,a5
     318:	70a2                	ld	ra,40(sp)
     31a:	7402                	ld	s0,32(sp)
     31c:	6145                	addi	sp,sp,48
     31e:	8082                	ret

0000000000000320 <stat>:

int
stat(const char *n, struct stat *st)
{
     320:	7179                	addi	sp,sp,-48
     322:	f406                	sd	ra,40(sp)
     324:	f022                	sd	s0,32(sp)
     326:	1800                	addi	s0,sp,48
     328:	fca43c23          	sd	a0,-40(s0)
     32c:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     330:	4581                	li	a1,0
     332:	fd843503          	ld	a0,-40(s0)
     336:	00000097          	auipc	ra,0x0
     33a:	288080e7          	jalr	648(ra) # 5be <open>
     33e:	87aa                	mv	a5,a0
     340:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     344:	fec42783          	lw	a5,-20(s0)
     348:	2781                	sext.w	a5,a5
     34a:	0007d463          	bgez	a5,352 <stat+0x32>
    return -1;
     34e:	57fd                	li	a5,-1
     350:	a035                	j	37c <stat+0x5c>
  r = fstat(fd, st);
     352:	fec42783          	lw	a5,-20(s0)
     356:	fd043583          	ld	a1,-48(s0)
     35a:	853e                	mv	a0,a5
     35c:	00000097          	auipc	ra,0x0
     360:	27a080e7          	jalr	634(ra) # 5d6 <fstat>
     364:	87aa                	mv	a5,a0
     366:	fef42423          	sw	a5,-24(s0)
  close(fd);
     36a:	fec42783          	lw	a5,-20(s0)
     36e:	853e                	mv	a0,a5
     370:	00000097          	auipc	ra,0x0
     374:	236080e7          	jalr	566(ra) # 5a6 <close>
  return r;
     378:	fe842783          	lw	a5,-24(s0)
}
     37c:	853e                	mv	a0,a5
     37e:	70a2                	ld	ra,40(sp)
     380:	7402                	ld	s0,32(sp)
     382:	6145                	addi	sp,sp,48
     384:	8082                	ret

0000000000000386 <atoi>:

int
atoi(const char *s)
{
     386:	7179                	addi	sp,sp,-48
     388:	f422                	sd	s0,40(sp)
     38a:	1800                	addi	s0,sp,48
     38c:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     390:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     394:	a815                	j	3c8 <atoi+0x42>
    n = n*10 + *s++ - '0';
     396:	fec42703          	lw	a4,-20(s0)
     39a:	87ba                	mv	a5,a4
     39c:	0027979b          	slliw	a5,a5,0x2
     3a0:	9fb9                	addw	a5,a5,a4
     3a2:	0017979b          	slliw	a5,a5,0x1
     3a6:	0007871b          	sext.w	a4,a5
     3aa:	fd843783          	ld	a5,-40(s0)
     3ae:	00178693          	addi	a3,a5,1
     3b2:	fcd43c23          	sd	a3,-40(s0)
     3b6:	0007c783          	lbu	a5,0(a5)
     3ba:	2781                	sext.w	a5,a5
     3bc:	9fb9                	addw	a5,a5,a4
     3be:	2781                	sext.w	a5,a5
     3c0:	fd07879b          	addiw	a5,a5,-48
     3c4:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     3c8:	fd843783          	ld	a5,-40(s0)
     3cc:	0007c783          	lbu	a5,0(a5)
     3d0:	873e                	mv	a4,a5
     3d2:	02f00793          	li	a5,47
     3d6:	00e7fb63          	bgeu	a5,a4,3ec <atoi+0x66>
     3da:	fd843783          	ld	a5,-40(s0)
     3de:	0007c783          	lbu	a5,0(a5)
     3e2:	873e                	mv	a4,a5
     3e4:	03900793          	li	a5,57
     3e8:	fae7f7e3          	bgeu	a5,a4,396 <atoi+0x10>
  return n;
     3ec:	fec42783          	lw	a5,-20(s0)
}
     3f0:	853e                	mv	a0,a5
     3f2:	7422                	ld	s0,40(sp)
     3f4:	6145                	addi	sp,sp,48
     3f6:	8082                	ret

00000000000003f8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     3f8:	7139                	addi	sp,sp,-64
     3fa:	fc22                	sd	s0,56(sp)
     3fc:	0080                	addi	s0,sp,64
     3fe:	fca43c23          	sd	a0,-40(s0)
     402:	fcb43823          	sd	a1,-48(s0)
     406:	87b2                	mv	a5,a2
     408:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     40c:	fd843783          	ld	a5,-40(s0)
     410:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     414:	fd043783          	ld	a5,-48(s0)
     418:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     41c:	fe043703          	ld	a4,-32(s0)
     420:	fe843783          	ld	a5,-24(s0)
     424:	02e7fc63          	bgeu	a5,a4,45c <memmove+0x64>
    while(n-- > 0)
     428:	a00d                	j	44a <memmove+0x52>
      *dst++ = *src++;
     42a:	fe043703          	ld	a4,-32(s0)
     42e:	00170793          	addi	a5,a4,1
     432:	fef43023          	sd	a5,-32(s0)
     436:	fe843783          	ld	a5,-24(s0)
     43a:	00178693          	addi	a3,a5,1
     43e:	fed43423          	sd	a3,-24(s0)
     442:	00074703          	lbu	a4,0(a4)
     446:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     44a:	fcc42783          	lw	a5,-52(s0)
     44e:	fff7871b          	addiw	a4,a5,-1
     452:	fce42623          	sw	a4,-52(s0)
     456:	fcf04ae3          	bgtz	a5,42a <memmove+0x32>
     45a:	a891                	j	4ae <memmove+0xb6>
  } else {
    dst += n;
     45c:	fcc42783          	lw	a5,-52(s0)
     460:	fe843703          	ld	a4,-24(s0)
     464:	97ba                	add	a5,a5,a4
     466:	fef43423          	sd	a5,-24(s0)
    src += n;
     46a:	fcc42783          	lw	a5,-52(s0)
     46e:	fe043703          	ld	a4,-32(s0)
     472:	97ba                	add	a5,a5,a4
     474:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     478:	a01d                	j	49e <memmove+0xa6>
      *--dst = *--src;
     47a:	fe043783          	ld	a5,-32(s0)
     47e:	17fd                	addi	a5,a5,-1
     480:	fef43023          	sd	a5,-32(s0)
     484:	fe843783          	ld	a5,-24(s0)
     488:	17fd                	addi	a5,a5,-1
     48a:	fef43423          	sd	a5,-24(s0)
     48e:	fe043783          	ld	a5,-32(s0)
     492:	0007c703          	lbu	a4,0(a5)
     496:	fe843783          	ld	a5,-24(s0)
     49a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     49e:	fcc42783          	lw	a5,-52(s0)
     4a2:	fff7871b          	addiw	a4,a5,-1
     4a6:	fce42623          	sw	a4,-52(s0)
     4aa:	fcf048e3          	bgtz	a5,47a <memmove+0x82>
  }
  return vdst;
     4ae:	fd843783          	ld	a5,-40(s0)
}
     4b2:	853e                	mv	a0,a5
     4b4:	7462                	ld	s0,56(sp)
     4b6:	6121                	addi	sp,sp,64
     4b8:	8082                	ret

00000000000004ba <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     4ba:	7139                	addi	sp,sp,-64
     4bc:	fc22                	sd	s0,56(sp)
     4be:	0080                	addi	s0,sp,64
     4c0:	fca43c23          	sd	a0,-40(s0)
     4c4:	fcb43823          	sd	a1,-48(s0)
     4c8:	87b2                	mv	a5,a2
     4ca:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     4ce:	fd843783          	ld	a5,-40(s0)
     4d2:	fef43423          	sd	a5,-24(s0)
     4d6:	fd043783          	ld	a5,-48(s0)
     4da:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     4de:	a0a1                	j	526 <memcmp+0x6c>
    if (*p1 != *p2) {
     4e0:	fe843783          	ld	a5,-24(s0)
     4e4:	0007c703          	lbu	a4,0(a5)
     4e8:	fe043783          	ld	a5,-32(s0)
     4ec:	0007c783          	lbu	a5,0(a5)
     4f0:	02f70163          	beq	a4,a5,512 <memcmp+0x58>
      return *p1 - *p2;
     4f4:	fe843783          	ld	a5,-24(s0)
     4f8:	0007c783          	lbu	a5,0(a5)
     4fc:	0007871b          	sext.w	a4,a5
     500:	fe043783          	ld	a5,-32(s0)
     504:	0007c783          	lbu	a5,0(a5)
     508:	2781                	sext.w	a5,a5
     50a:	40f707bb          	subw	a5,a4,a5
     50e:	2781                	sext.w	a5,a5
     510:	a01d                	j	536 <memcmp+0x7c>
    }
    p1++;
     512:	fe843783          	ld	a5,-24(s0)
     516:	0785                	addi	a5,a5,1
     518:	fef43423          	sd	a5,-24(s0)
    p2++;
     51c:	fe043783          	ld	a5,-32(s0)
     520:	0785                	addi	a5,a5,1
     522:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     526:	fcc42783          	lw	a5,-52(s0)
     52a:	fff7871b          	addiw	a4,a5,-1
     52e:	fce42623          	sw	a4,-52(s0)
     532:	f7dd                	bnez	a5,4e0 <memcmp+0x26>
  }
  return 0;
     534:	4781                	li	a5,0
}
     536:	853e                	mv	a0,a5
     538:	7462                	ld	s0,56(sp)
     53a:	6121                	addi	sp,sp,64
     53c:	8082                	ret

000000000000053e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     53e:	7179                	addi	sp,sp,-48
     540:	f406                	sd	ra,40(sp)
     542:	f022                	sd	s0,32(sp)
     544:	1800                	addi	s0,sp,48
     546:	fea43423          	sd	a0,-24(s0)
     54a:	feb43023          	sd	a1,-32(s0)
     54e:	87b2                	mv	a5,a2
     550:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     554:	fdc42783          	lw	a5,-36(s0)
     558:	863e                	mv	a2,a5
     55a:	fe043583          	ld	a1,-32(s0)
     55e:	fe843503          	ld	a0,-24(s0)
     562:	00000097          	auipc	ra,0x0
     566:	e96080e7          	jalr	-362(ra) # 3f8 <memmove>
     56a:	87aa                	mv	a5,a0
}
     56c:	853e                	mv	a0,a5
     56e:	70a2                	ld	ra,40(sp)
     570:	7402                	ld	s0,32(sp)
     572:	6145                	addi	sp,sp,48
     574:	8082                	ret

0000000000000576 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     576:	4885                	li	a7,1
 ecall
     578:	00000073          	ecall
 ret
     57c:	8082                	ret

000000000000057e <exit>:
.global exit
exit:
 li a7, SYS_exit
     57e:	4889                	li	a7,2
 ecall
     580:	00000073          	ecall
 ret
     584:	8082                	ret

0000000000000586 <wait>:
.global wait
wait:
 li a7, SYS_wait
     586:	488d                	li	a7,3
 ecall
     588:	00000073          	ecall
 ret
     58c:	8082                	ret

000000000000058e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     58e:	4891                	li	a7,4
 ecall
     590:	00000073          	ecall
 ret
     594:	8082                	ret

0000000000000596 <read>:
.global read
read:
 li a7, SYS_read
     596:	4895                	li	a7,5
 ecall
     598:	00000073          	ecall
 ret
     59c:	8082                	ret

000000000000059e <write>:
.global write
write:
 li a7, SYS_write
     59e:	48c1                	li	a7,16
 ecall
     5a0:	00000073          	ecall
 ret
     5a4:	8082                	ret

00000000000005a6 <close>:
.global close
close:
 li a7, SYS_close
     5a6:	48d5                	li	a7,21
 ecall
     5a8:	00000073          	ecall
 ret
     5ac:	8082                	ret

00000000000005ae <kill>:
.global kill
kill:
 li a7, SYS_kill
     5ae:	4899                	li	a7,6
 ecall
     5b0:	00000073          	ecall
 ret
     5b4:	8082                	ret

00000000000005b6 <exec>:
.global exec
exec:
 li a7, SYS_exec
     5b6:	489d                	li	a7,7
 ecall
     5b8:	00000073          	ecall
 ret
     5bc:	8082                	ret

00000000000005be <open>:
.global open
open:
 li a7, SYS_open
     5be:	48bd                	li	a7,15
 ecall
     5c0:	00000073          	ecall
 ret
     5c4:	8082                	ret

00000000000005c6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     5c6:	48c5                	li	a7,17
 ecall
     5c8:	00000073          	ecall
 ret
     5cc:	8082                	ret

00000000000005ce <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     5ce:	48c9                	li	a7,18
 ecall
     5d0:	00000073          	ecall
 ret
     5d4:	8082                	ret

00000000000005d6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     5d6:	48a1                	li	a7,8
 ecall
     5d8:	00000073          	ecall
 ret
     5dc:	8082                	ret

00000000000005de <link>:
.global link
link:
 li a7, SYS_link
     5de:	48cd                	li	a7,19
 ecall
     5e0:	00000073          	ecall
 ret
     5e4:	8082                	ret

00000000000005e6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     5e6:	48d1                	li	a7,20
 ecall
     5e8:	00000073          	ecall
 ret
     5ec:	8082                	ret

00000000000005ee <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     5ee:	48a5                	li	a7,9
 ecall
     5f0:	00000073          	ecall
 ret
     5f4:	8082                	ret

00000000000005f6 <dup>:
.global dup
dup:
 li a7, SYS_dup
     5f6:	48a9                	li	a7,10
 ecall
     5f8:	00000073          	ecall
 ret
     5fc:	8082                	ret

00000000000005fe <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     5fe:	48ad                	li	a7,11
 ecall
     600:	00000073          	ecall
 ret
     604:	8082                	ret

0000000000000606 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     606:	48b1                	li	a7,12
 ecall
     608:	00000073          	ecall
 ret
     60c:	8082                	ret

000000000000060e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     60e:	48b5                	li	a7,13
 ecall
     610:	00000073          	ecall
 ret
     614:	8082                	ret

0000000000000616 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     616:	48b9                	li	a7,14
 ecall
     618:	00000073          	ecall
 ret
     61c:	8082                	ret

000000000000061e <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     61e:	48d9                	li	a7,22
 ecall
     620:	00000073          	ecall
 ret
     624:	8082                	ret

0000000000000626 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     626:	48dd                	li	a7,23
 ecall
     628:	00000073          	ecall
 ret
     62c:	8082                	ret

000000000000062e <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     62e:	48e1                	li	a7,24
 ecall
     630:	00000073          	ecall
 ret
     634:	8082                	ret

0000000000000636 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     636:	1101                	addi	sp,sp,-32
     638:	ec06                	sd	ra,24(sp)
     63a:	e822                	sd	s0,16(sp)
     63c:	1000                	addi	s0,sp,32
     63e:	87aa                	mv	a5,a0
     640:	872e                	mv	a4,a1
     642:	fef42623          	sw	a5,-20(s0)
     646:	87ba                	mv	a5,a4
     648:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     64c:	feb40713          	addi	a4,s0,-21
     650:	fec42783          	lw	a5,-20(s0)
     654:	4605                	li	a2,1
     656:	85ba                	mv	a1,a4
     658:	853e                	mv	a0,a5
     65a:	00000097          	auipc	ra,0x0
     65e:	f44080e7          	jalr	-188(ra) # 59e <write>
}
     662:	0001                	nop
     664:	60e2                	ld	ra,24(sp)
     666:	6442                	ld	s0,16(sp)
     668:	6105                	addi	sp,sp,32
     66a:	8082                	ret

000000000000066c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     66c:	7139                	addi	sp,sp,-64
     66e:	fc06                	sd	ra,56(sp)
     670:	f822                	sd	s0,48(sp)
     672:	0080                	addi	s0,sp,64
     674:	87aa                	mv	a5,a0
     676:	8736                	mv	a4,a3
     678:	fcf42623          	sw	a5,-52(s0)
     67c:	87ae                	mv	a5,a1
     67e:	fcf42423          	sw	a5,-56(s0)
     682:	87b2                	mv	a5,a2
     684:	fcf42223          	sw	a5,-60(s0)
     688:	87ba                	mv	a5,a4
     68a:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     68e:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     692:	fc042783          	lw	a5,-64(s0)
     696:	2781                	sext.w	a5,a5
     698:	c38d                	beqz	a5,6ba <printint+0x4e>
     69a:	fc842783          	lw	a5,-56(s0)
     69e:	2781                	sext.w	a5,a5
     6a0:	0007dd63          	bgez	a5,6ba <printint+0x4e>
    neg = 1;
     6a4:	4785                	li	a5,1
     6a6:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     6aa:	fc842783          	lw	a5,-56(s0)
     6ae:	40f007bb          	negw	a5,a5
     6b2:	2781                	sext.w	a5,a5
     6b4:	fef42223          	sw	a5,-28(s0)
     6b8:	a029                	j	6c2 <printint+0x56>
  } else {
    x = xx;
     6ba:	fc842783          	lw	a5,-56(s0)
     6be:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     6c2:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     6c6:	fc442783          	lw	a5,-60(s0)
     6ca:	fe442703          	lw	a4,-28(s0)
     6ce:	02f777bb          	remuw	a5,a4,a5
     6d2:	0007861b          	sext.w	a2,a5
     6d6:	fec42783          	lw	a5,-20(s0)
     6da:	0017871b          	addiw	a4,a5,1
     6de:	fee42623          	sw	a4,-20(s0)
     6e2:	00002697          	auipc	a3,0x2
     6e6:	1ae68693          	addi	a3,a3,430 # 2890 <digits>
     6ea:	02061713          	slli	a4,a2,0x20
     6ee:	9301                	srli	a4,a4,0x20
     6f0:	9736                	add	a4,a4,a3
     6f2:	00074703          	lbu	a4,0(a4)
     6f6:	ff040693          	addi	a3,s0,-16
     6fa:	97b6                	add	a5,a5,a3
     6fc:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     700:	fc442783          	lw	a5,-60(s0)
     704:	fe442703          	lw	a4,-28(s0)
     708:	02f757bb          	divuw	a5,a4,a5
     70c:	fef42223          	sw	a5,-28(s0)
     710:	fe442783          	lw	a5,-28(s0)
     714:	2781                	sext.w	a5,a5
     716:	fbc5                	bnez	a5,6c6 <printint+0x5a>
  if(neg)
     718:	fe842783          	lw	a5,-24(s0)
     71c:	2781                	sext.w	a5,a5
     71e:	cf95                	beqz	a5,75a <printint+0xee>
    buf[i++] = '-';
     720:	fec42783          	lw	a5,-20(s0)
     724:	0017871b          	addiw	a4,a5,1
     728:	fee42623          	sw	a4,-20(s0)
     72c:	ff040713          	addi	a4,s0,-16
     730:	97ba                	add	a5,a5,a4
     732:	02d00713          	li	a4,45
     736:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     73a:	a005                	j	75a <printint+0xee>
    putc(fd, buf[i]);
     73c:	fec42783          	lw	a5,-20(s0)
     740:	ff040713          	addi	a4,s0,-16
     744:	97ba                	add	a5,a5,a4
     746:	fe07c703          	lbu	a4,-32(a5)
     74a:	fcc42783          	lw	a5,-52(s0)
     74e:	85ba                	mv	a1,a4
     750:	853e                	mv	a0,a5
     752:	00000097          	auipc	ra,0x0
     756:	ee4080e7          	jalr	-284(ra) # 636 <putc>
  while(--i >= 0)
     75a:	fec42783          	lw	a5,-20(s0)
     75e:	37fd                	addiw	a5,a5,-1
     760:	fef42623          	sw	a5,-20(s0)
     764:	fec42783          	lw	a5,-20(s0)
     768:	2781                	sext.w	a5,a5
     76a:	fc07d9e3          	bgez	a5,73c <printint+0xd0>
}
     76e:	0001                	nop
     770:	0001                	nop
     772:	70e2                	ld	ra,56(sp)
     774:	7442                	ld	s0,48(sp)
     776:	6121                	addi	sp,sp,64
     778:	8082                	ret

000000000000077a <printptr>:

static void
printptr(int fd, uint64 x) {
     77a:	7179                	addi	sp,sp,-48
     77c:	f406                	sd	ra,40(sp)
     77e:	f022                	sd	s0,32(sp)
     780:	1800                	addi	s0,sp,48
     782:	87aa                	mv	a5,a0
     784:	fcb43823          	sd	a1,-48(s0)
     788:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     78c:	fdc42783          	lw	a5,-36(s0)
     790:	03000593          	li	a1,48
     794:	853e                	mv	a0,a5
     796:	00000097          	auipc	ra,0x0
     79a:	ea0080e7          	jalr	-352(ra) # 636 <putc>
  putc(fd, 'x');
     79e:	fdc42783          	lw	a5,-36(s0)
     7a2:	07800593          	li	a1,120
     7a6:	853e                	mv	a0,a5
     7a8:	00000097          	auipc	ra,0x0
     7ac:	e8e080e7          	jalr	-370(ra) # 636 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     7b0:	fe042623          	sw	zero,-20(s0)
     7b4:	a82d                	j	7ee <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     7b6:	fd043783          	ld	a5,-48(s0)
     7ba:	93f1                	srli	a5,a5,0x3c
     7bc:	00002717          	auipc	a4,0x2
     7c0:	0d470713          	addi	a4,a4,212 # 2890 <digits>
     7c4:	97ba                	add	a5,a5,a4
     7c6:	0007c703          	lbu	a4,0(a5)
     7ca:	fdc42783          	lw	a5,-36(s0)
     7ce:	85ba                	mv	a1,a4
     7d0:	853e                	mv	a0,a5
     7d2:	00000097          	auipc	ra,0x0
     7d6:	e64080e7          	jalr	-412(ra) # 636 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     7da:	fec42783          	lw	a5,-20(s0)
     7de:	2785                	addiw	a5,a5,1
     7e0:	fef42623          	sw	a5,-20(s0)
     7e4:	fd043783          	ld	a5,-48(s0)
     7e8:	0792                	slli	a5,a5,0x4
     7ea:	fcf43823          	sd	a5,-48(s0)
     7ee:	fec42783          	lw	a5,-20(s0)
     7f2:	873e                	mv	a4,a5
     7f4:	47bd                	li	a5,15
     7f6:	fce7f0e3          	bgeu	a5,a4,7b6 <printptr+0x3c>
}
     7fa:	0001                	nop
     7fc:	0001                	nop
     7fe:	70a2                	ld	ra,40(sp)
     800:	7402                	ld	s0,32(sp)
     802:	6145                	addi	sp,sp,48
     804:	8082                	ret

0000000000000806 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     806:	715d                	addi	sp,sp,-80
     808:	e486                	sd	ra,72(sp)
     80a:	e0a2                	sd	s0,64(sp)
     80c:	0880                	addi	s0,sp,80
     80e:	87aa                	mv	a5,a0
     810:	fcb43023          	sd	a1,-64(s0)
     814:	fac43c23          	sd	a2,-72(s0)
     818:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     81c:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     820:	fe042223          	sw	zero,-28(s0)
     824:	a42d                	j	a4e <vprintf+0x248>
    c = fmt[i] & 0xff;
     826:	fe442783          	lw	a5,-28(s0)
     82a:	fc043703          	ld	a4,-64(s0)
     82e:	97ba                	add	a5,a5,a4
     830:	0007c783          	lbu	a5,0(a5)
     834:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     838:	fe042783          	lw	a5,-32(s0)
     83c:	2781                	sext.w	a5,a5
     83e:	eb9d                	bnez	a5,874 <vprintf+0x6e>
      if(c == '%'){
     840:	fdc42783          	lw	a5,-36(s0)
     844:	0007871b          	sext.w	a4,a5
     848:	02500793          	li	a5,37
     84c:	00f71763          	bne	a4,a5,85a <vprintf+0x54>
        state = '%';
     850:	02500793          	li	a5,37
     854:	fef42023          	sw	a5,-32(s0)
     858:	a2f5                	j	a44 <vprintf+0x23e>
      } else {
        putc(fd, c);
     85a:	fdc42783          	lw	a5,-36(s0)
     85e:	0ff7f713          	andi	a4,a5,255
     862:	fcc42783          	lw	a5,-52(s0)
     866:	85ba                	mv	a1,a4
     868:	853e                	mv	a0,a5
     86a:	00000097          	auipc	ra,0x0
     86e:	dcc080e7          	jalr	-564(ra) # 636 <putc>
     872:	aac9                	j	a44 <vprintf+0x23e>
      }
    } else if(state == '%'){
     874:	fe042783          	lw	a5,-32(s0)
     878:	0007871b          	sext.w	a4,a5
     87c:	02500793          	li	a5,37
     880:	1cf71263          	bne	a4,a5,a44 <vprintf+0x23e>
      if(c == 'd'){
     884:	fdc42783          	lw	a5,-36(s0)
     888:	0007871b          	sext.w	a4,a5
     88c:	06400793          	li	a5,100
     890:	02f71463          	bne	a4,a5,8b8 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     894:	fb843783          	ld	a5,-72(s0)
     898:	00878713          	addi	a4,a5,8
     89c:	fae43c23          	sd	a4,-72(s0)
     8a0:	4398                	lw	a4,0(a5)
     8a2:	fcc42783          	lw	a5,-52(s0)
     8a6:	4685                	li	a3,1
     8a8:	4629                	li	a2,10
     8aa:	85ba                	mv	a1,a4
     8ac:	853e                	mv	a0,a5
     8ae:	00000097          	auipc	ra,0x0
     8b2:	dbe080e7          	jalr	-578(ra) # 66c <printint>
     8b6:	a269                	j	a40 <vprintf+0x23a>
      } else if(c == 'l') {
     8b8:	fdc42783          	lw	a5,-36(s0)
     8bc:	0007871b          	sext.w	a4,a5
     8c0:	06c00793          	li	a5,108
     8c4:	02f71663          	bne	a4,a5,8f0 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     8c8:	fb843783          	ld	a5,-72(s0)
     8cc:	00878713          	addi	a4,a5,8
     8d0:	fae43c23          	sd	a4,-72(s0)
     8d4:	639c                	ld	a5,0(a5)
     8d6:	0007871b          	sext.w	a4,a5
     8da:	fcc42783          	lw	a5,-52(s0)
     8de:	4681                	li	a3,0
     8e0:	4629                	li	a2,10
     8e2:	85ba                	mv	a1,a4
     8e4:	853e                	mv	a0,a5
     8e6:	00000097          	auipc	ra,0x0
     8ea:	d86080e7          	jalr	-634(ra) # 66c <printint>
     8ee:	aa89                	j	a40 <vprintf+0x23a>
      } else if(c == 'x') {
     8f0:	fdc42783          	lw	a5,-36(s0)
     8f4:	0007871b          	sext.w	a4,a5
     8f8:	07800793          	li	a5,120
     8fc:	02f71463          	bne	a4,a5,924 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     900:	fb843783          	ld	a5,-72(s0)
     904:	00878713          	addi	a4,a5,8
     908:	fae43c23          	sd	a4,-72(s0)
     90c:	4398                	lw	a4,0(a5)
     90e:	fcc42783          	lw	a5,-52(s0)
     912:	4681                	li	a3,0
     914:	4641                	li	a2,16
     916:	85ba                	mv	a1,a4
     918:	853e                	mv	a0,a5
     91a:	00000097          	auipc	ra,0x0
     91e:	d52080e7          	jalr	-686(ra) # 66c <printint>
     922:	aa39                	j	a40 <vprintf+0x23a>
      } else if(c == 'p') {
     924:	fdc42783          	lw	a5,-36(s0)
     928:	0007871b          	sext.w	a4,a5
     92c:	07000793          	li	a5,112
     930:	02f71263          	bne	a4,a5,954 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     934:	fb843783          	ld	a5,-72(s0)
     938:	00878713          	addi	a4,a5,8
     93c:	fae43c23          	sd	a4,-72(s0)
     940:	6398                	ld	a4,0(a5)
     942:	fcc42783          	lw	a5,-52(s0)
     946:	85ba                	mv	a1,a4
     948:	853e                	mv	a0,a5
     94a:	00000097          	auipc	ra,0x0
     94e:	e30080e7          	jalr	-464(ra) # 77a <printptr>
     952:	a0fd                	j	a40 <vprintf+0x23a>
      } else if(c == 's'){
     954:	fdc42783          	lw	a5,-36(s0)
     958:	0007871b          	sext.w	a4,a5
     95c:	07300793          	li	a5,115
     960:	04f71c63          	bne	a4,a5,9b8 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     964:	fb843783          	ld	a5,-72(s0)
     968:	00878713          	addi	a4,a5,8
     96c:	fae43c23          	sd	a4,-72(s0)
     970:	639c                	ld	a5,0(a5)
     972:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     976:	fe843783          	ld	a5,-24(s0)
     97a:	eb8d                	bnez	a5,9ac <vprintf+0x1a6>
          s = "(null)";
     97c:	00002797          	auipc	a5,0x2
     980:	dcc78793          	addi	a5,a5,-564 # 2748 <schedule_dm+0x2e6>
     984:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     988:	a015                	j	9ac <vprintf+0x1a6>
          putc(fd, *s);
     98a:	fe843783          	ld	a5,-24(s0)
     98e:	0007c703          	lbu	a4,0(a5)
     992:	fcc42783          	lw	a5,-52(s0)
     996:	85ba                	mv	a1,a4
     998:	853e                	mv	a0,a5
     99a:	00000097          	auipc	ra,0x0
     99e:	c9c080e7          	jalr	-868(ra) # 636 <putc>
          s++;
     9a2:	fe843783          	ld	a5,-24(s0)
     9a6:	0785                	addi	a5,a5,1
     9a8:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     9ac:	fe843783          	ld	a5,-24(s0)
     9b0:	0007c783          	lbu	a5,0(a5)
     9b4:	fbf9                	bnez	a5,98a <vprintf+0x184>
     9b6:	a069                	j	a40 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     9b8:	fdc42783          	lw	a5,-36(s0)
     9bc:	0007871b          	sext.w	a4,a5
     9c0:	06300793          	li	a5,99
     9c4:	02f71463          	bne	a4,a5,9ec <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     9c8:	fb843783          	ld	a5,-72(s0)
     9cc:	00878713          	addi	a4,a5,8
     9d0:	fae43c23          	sd	a4,-72(s0)
     9d4:	439c                	lw	a5,0(a5)
     9d6:	0ff7f713          	andi	a4,a5,255
     9da:	fcc42783          	lw	a5,-52(s0)
     9de:	85ba                	mv	a1,a4
     9e0:	853e                	mv	a0,a5
     9e2:	00000097          	auipc	ra,0x0
     9e6:	c54080e7          	jalr	-940(ra) # 636 <putc>
     9ea:	a899                	j	a40 <vprintf+0x23a>
      } else if(c == '%'){
     9ec:	fdc42783          	lw	a5,-36(s0)
     9f0:	0007871b          	sext.w	a4,a5
     9f4:	02500793          	li	a5,37
     9f8:	00f71f63          	bne	a4,a5,a16 <vprintf+0x210>
        putc(fd, c);
     9fc:	fdc42783          	lw	a5,-36(s0)
     a00:	0ff7f713          	andi	a4,a5,255
     a04:	fcc42783          	lw	a5,-52(s0)
     a08:	85ba                	mv	a1,a4
     a0a:	853e                	mv	a0,a5
     a0c:	00000097          	auipc	ra,0x0
     a10:	c2a080e7          	jalr	-982(ra) # 636 <putc>
     a14:	a035                	j	a40 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     a16:	fcc42783          	lw	a5,-52(s0)
     a1a:	02500593          	li	a1,37
     a1e:	853e                	mv	a0,a5
     a20:	00000097          	auipc	ra,0x0
     a24:	c16080e7          	jalr	-1002(ra) # 636 <putc>
        putc(fd, c);
     a28:	fdc42783          	lw	a5,-36(s0)
     a2c:	0ff7f713          	andi	a4,a5,255
     a30:	fcc42783          	lw	a5,-52(s0)
     a34:	85ba                	mv	a1,a4
     a36:	853e                	mv	a0,a5
     a38:	00000097          	auipc	ra,0x0
     a3c:	bfe080e7          	jalr	-1026(ra) # 636 <putc>
      }
      state = 0;
     a40:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     a44:	fe442783          	lw	a5,-28(s0)
     a48:	2785                	addiw	a5,a5,1
     a4a:	fef42223          	sw	a5,-28(s0)
     a4e:	fe442783          	lw	a5,-28(s0)
     a52:	fc043703          	ld	a4,-64(s0)
     a56:	97ba                	add	a5,a5,a4
     a58:	0007c783          	lbu	a5,0(a5)
     a5c:	dc0795e3          	bnez	a5,826 <vprintf+0x20>
    }
  }
}
     a60:	0001                	nop
     a62:	0001                	nop
     a64:	60a6                	ld	ra,72(sp)
     a66:	6406                	ld	s0,64(sp)
     a68:	6161                	addi	sp,sp,80
     a6a:	8082                	ret

0000000000000a6c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     a6c:	7159                	addi	sp,sp,-112
     a6e:	fc06                	sd	ra,56(sp)
     a70:	f822                	sd	s0,48(sp)
     a72:	0080                	addi	s0,sp,64
     a74:	fcb43823          	sd	a1,-48(s0)
     a78:	e010                	sd	a2,0(s0)
     a7a:	e414                	sd	a3,8(s0)
     a7c:	e818                	sd	a4,16(s0)
     a7e:	ec1c                	sd	a5,24(s0)
     a80:	03043023          	sd	a6,32(s0)
     a84:	03143423          	sd	a7,40(s0)
     a88:	87aa                	mv	a5,a0
     a8a:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     a8e:	03040793          	addi	a5,s0,48
     a92:	fcf43423          	sd	a5,-56(s0)
     a96:	fc843783          	ld	a5,-56(s0)
     a9a:	fd078793          	addi	a5,a5,-48
     a9e:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     aa2:	fe843703          	ld	a4,-24(s0)
     aa6:	fdc42783          	lw	a5,-36(s0)
     aaa:	863a                	mv	a2,a4
     aac:	fd043583          	ld	a1,-48(s0)
     ab0:	853e                	mv	a0,a5
     ab2:	00000097          	auipc	ra,0x0
     ab6:	d54080e7          	jalr	-684(ra) # 806 <vprintf>
}
     aba:	0001                	nop
     abc:	70e2                	ld	ra,56(sp)
     abe:	7442                	ld	s0,48(sp)
     ac0:	6165                	addi	sp,sp,112
     ac2:	8082                	ret

0000000000000ac4 <printf>:

void
printf(const char *fmt, ...)
{
     ac4:	7159                	addi	sp,sp,-112
     ac6:	f406                	sd	ra,40(sp)
     ac8:	f022                	sd	s0,32(sp)
     aca:	1800                	addi	s0,sp,48
     acc:	fca43c23          	sd	a0,-40(s0)
     ad0:	e40c                	sd	a1,8(s0)
     ad2:	e810                	sd	a2,16(s0)
     ad4:	ec14                	sd	a3,24(s0)
     ad6:	f018                	sd	a4,32(s0)
     ad8:	f41c                	sd	a5,40(s0)
     ada:	03043823          	sd	a6,48(s0)
     ade:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     ae2:	04040793          	addi	a5,s0,64
     ae6:	fcf43823          	sd	a5,-48(s0)
     aea:	fd043783          	ld	a5,-48(s0)
     aee:	fc878793          	addi	a5,a5,-56
     af2:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     af6:	fe843783          	ld	a5,-24(s0)
     afa:	863e                	mv	a2,a5
     afc:	fd843583          	ld	a1,-40(s0)
     b00:	4505                	li	a0,1
     b02:	00000097          	auipc	ra,0x0
     b06:	d04080e7          	jalr	-764(ra) # 806 <vprintf>
}
     b0a:	0001                	nop
     b0c:	70a2                	ld	ra,40(sp)
     b0e:	7402                	ld	s0,32(sp)
     b10:	6165                	addi	sp,sp,112
     b12:	8082                	ret

0000000000000b14 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     b14:	7179                	addi	sp,sp,-48
     b16:	f422                	sd	s0,40(sp)
     b18:	1800                	addi	s0,sp,48
     b1a:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     b1e:	fd843783          	ld	a5,-40(s0)
     b22:	17c1                	addi	a5,a5,-16
     b24:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b28:	00002797          	auipc	a5,0x2
     b2c:	dc078793          	addi	a5,a5,-576 # 28e8 <freep>
     b30:	639c                	ld	a5,0(a5)
     b32:	fef43423          	sd	a5,-24(s0)
     b36:	a815                	j	b6a <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     b38:	fe843783          	ld	a5,-24(s0)
     b3c:	639c                	ld	a5,0(a5)
     b3e:	fe843703          	ld	a4,-24(s0)
     b42:	00f76f63          	bltu	a4,a5,b60 <free+0x4c>
     b46:	fe043703          	ld	a4,-32(s0)
     b4a:	fe843783          	ld	a5,-24(s0)
     b4e:	02e7eb63          	bltu	a5,a4,b84 <free+0x70>
     b52:	fe843783          	ld	a5,-24(s0)
     b56:	639c                	ld	a5,0(a5)
     b58:	fe043703          	ld	a4,-32(s0)
     b5c:	02f76463          	bltu	a4,a5,b84 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b60:	fe843783          	ld	a5,-24(s0)
     b64:	639c                	ld	a5,0(a5)
     b66:	fef43423          	sd	a5,-24(s0)
     b6a:	fe043703          	ld	a4,-32(s0)
     b6e:	fe843783          	ld	a5,-24(s0)
     b72:	fce7f3e3          	bgeu	a5,a4,b38 <free+0x24>
     b76:	fe843783          	ld	a5,-24(s0)
     b7a:	639c                	ld	a5,0(a5)
     b7c:	fe043703          	ld	a4,-32(s0)
     b80:	faf77ce3          	bgeu	a4,a5,b38 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     b84:	fe043783          	ld	a5,-32(s0)
     b88:	479c                	lw	a5,8(a5)
     b8a:	1782                	slli	a5,a5,0x20
     b8c:	9381                	srli	a5,a5,0x20
     b8e:	0792                	slli	a5,a5,0x4
     b90:	fe043703          	ld	a4,-32(s0)
     b94:	973e                	add	a4,a4,a5
     b96:	fe843783          	ld	a5,-24(s0)
     b9a:	639c                	ld	a5,0(a5)
     b9c:	02f71763          	bne	a4,a5,bca <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     ba0:	fe043783          	ld	a5,-32(s0)
     ba4:	4798                	lw	a4,8(a5)
     ba6:	fe843783          	ld	a5,-24(s0)
     baa:	639c                	ld	a5,0(a5)
     bac:	479c                	lw	a5,8(a5)
     bae:	9fb9                	addw	a5,a5,a4
     bb0:	0007871b          	sext.w	a4,a5
     bb4:	fe043783          	ld	a5,-32(s0)
     bb8:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     bba:	fe843783          	ld	a5,-24(s0)
     bbe:	639c                	ld	a5,0(a5)
     bc0:	6398                	ld	a4,0(a5)
     bc2:	fe043783          	ld	a5,-32(s0)
     bc6:	e398                	sd	a4,0(a5)
     bc8:	a039                	j	bd6 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     bca:	fe843783          	ld	a5,-24(s0)
     bce:	6398                	ld	a4,0(a5)
     bd0:	fe043783          	ld	a5,-32(s0)
     bd4:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     bd6:	fe843783          	ld	a5,-24(s0)
     bda:	479c                	lw	a5,8(a5)
     bdc:	1782                	slli	a5,a5,0x20
     bde:	9381                	srli	a5,a5,0x20
     be0:	0792                	slli	a5,a5,0x4
     be2:	fe843703          	ld	a4,-24(s0)
     be6:	97ba                	add	a5,a5,a4
     be8:	fe043703          	ld	a4,-32(s0)
     bec:	02f71563          	bne	a4,a5,c16 <free+0x102>
    p->s.size += bp->s.size;
     bf0:	fe843783          	ld	a5,-24(s0)
     bf4:	4798                	lw	a4,8(a5)
     bf6:	fe043783          	ld	a5,-32(s0)
     bfa:	479c                	lw	a5,8(a5)
     bfc:	9fb9                	addw	a5,a5,a4
     bfe:	0007871b          	sext.w	a4,a5
     c02:	fe843783          	ld	a5,-24(s0)
     c06:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     c08:	fe043783          	ld	a5,-32(s0)
     c0c:	6398                	ld	a4,0(a5)
     c0e:	fe843783          	ld	a5,-24(s0)
     c12:	e398                	sd	a4,0(a5)
     c14:	a031                	j	c20 <free+0x10c>
  } else
    p->s.ptr = bp;
     c16:	fe843783          	ld	a5,-24(s0)
     c1a:	fe043703          	ld	a4,-32(s0)
     c1e:	e398                	sd	a4,0(a5)
  freep = p;
     c20:	00002797          	auipc	a5,0x2
     c24:	cc878793          	addi	a5,a5,-824 # 28e8 <freep>
     c28:	fe843703          	ld	a4,-24(s0)
     c2c:	e398                	sd	a4,0(a5)
}
     c2e:	0001                	nop
     c30:	7422                	ld	s0,40(sp)
     c32:	6145                	addi	sp,sp,48
     c34:	8082                	ret

0000000000000c36 <morecore>:

static Header*
morecore(uint nu)
{
     c36:	7179                	addi	sp,sp,-48
     c38:	f406                	sd	ra,40(sp)
     c3a:	f022                	sd	s0,32(sp)
     c3c:	1800                	addi	s0,sp,48
     c3e:	87aa                	mv	a5,a0
     c40:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     c44:	fdc42783          	lw	a5,-36(s0)
     c48:	0007871b          	sext.w	a4,a5
     c4c:	6785                	lui	a5,0x1
     c4e:	00f77563          	bgeu	a4,a5,c58 <morecore+0x22>
    nu = 4096;
     c52:	6785                	lui	a5,0x1
     c54:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     c58:	fdc42783          	lw	a5,-36(s0)
     c5c:	0047979b          	slliw	a5,a5,0x4
     c60:	2781                	sext.w	a5,a5
     c62:	2781                	sext.w	a5,a5
     c64:	853e                	mv	a0,a5
     c66:	00000097          	auipc	ra,0x0
     c6a:	9a0080e7          	jalr	-1632(ra) # 606 <sbrk>
     c6e:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     c72:	fe843703          	ld	a4,-24(s0)
     c76:	57fd                	li	a5,-1
     c78:	00f71463          	bne	a4,a5,c80 <morecore+0x4a>
    return 0;
     c7c:	4781                	li	a5,0
     c7e:	a03d                	j	cac <morecore+0x76>
  hp = (Header*)p;
     c80:	fe843783          	ld	a5,-24(s0)
     c84:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     c88:	fe043783          	ld	a5,-32(s0)
     c8c:	fdc42703          	lw	a4,-36(s0)
     c90:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     c92:	fe043783          	ld	a5,-32(s0)
     c96:	07c1                	addi	a5,a5,16
     c98:	853e                	mv	a0,a5
     c9a:	00000097          	auipc	ra,0x0
     c9e:	e7a080e7          	jalr	-390(ra) # b14 <free>
  return freep;
     ca2:	00002797          	auipc	a5,0x2
     ca6:	c4678793          	addi	a5,a5,-954 # 28e8 <freep>
     caa:	639c                	ld	a5,0(a5)
}
     cac:	853e                	mv	a0,a5
     cae:	70a2                	ld	ra,40(sp)
     cb0:	7402                	ld	s0,32(sp)
     cb2:	6145                	addi	sp,sp,48
     cb4:	8082                	ret

0000000000000cb6 <malloc>:

void*
malloc(uint nbytes)
{
     cb6:	7139                	addi	sp,sp,-64
     cb8:	fc06                	sd	ra,56(sp)
     cba:	f822                	sd	s0,48(sp)
     cbc:	0080                	addi	s0,sp,64
     cbe:	87aa                	mv	a5,a0
     cc0:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     cc4:	fcc46783          	lwu	a5,-52(s0)
     cc8:	07bd                	addi	a5,a5,15
     cca:	8391                	srli	a5,a5,0x4
     ccc:	2781                	sext.w	a5,a5
     cce:	2785                	addiw	a5,a5,1
     cd0:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     cd4:	00002797          	auipc	a5,0x2
     cd8:	c1478793          	addi	a5,a5,-1004 # 28e8 <freep>
     cdc:	639c                	ld	a5,0(a5)
     cde:	fef43023          	sd	a5,-32(s0)
     ce2:	fe043783          	ld	a5,-32(s0)
     ce6:	ef95                	bnez	a5,d22 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     ce8:	00002797          	auipc	a5,0x2
     cec:	bf078793          	addi	a5,a5,-1040 # 28d8 <base>
     cf0:	fef43023          	sd	a5,-32(s0)
     cf4:	00002797          	auipc	a5,0x2
     cf8:	bf478793          	addi	a5,a5,-1036 # 28e8 <freep>
     cfc:	fe043703          	ld	a4,-32(s0)
     d00:	e398                	sd	a4,0(a5)
     d02:	00002797          	auipc	a5,0x2
     d06:	be678793          	addi	a5,a5,-1050 # 28e8 <freep>
     d0a:	6398                	ld	a4,0(a5)
     d0c:	00002797          	auipc	a5,0x2
     d10:	bcc78793          	addi	a5,a5,-1076 # 28d8 <base>
     d14:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     d16:	00002797          	auipc	a5,0x2
     d1a:	bc278793          	addi	a5,a5,-1086 # 28d8 <base>
     d1e:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     d22:	fe043783          	ld	a5,-32(s0)
     d26:	639c                	ld	a5,0(a5)
     d28:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     d2c:	fe843783          	ld	a5,-24(s0)
     d30:	4798                	lw	a4,8(a5)
     d32:	fdc42783          	lw	a5,-36(s0)
     d36:	2781                	sext.w	a5,a5
     d38:	06f76863          	bltu	a4,a5,da8 <malloc+0xf2>
      if(p->s.size == nunits)
     d3c:	fe843783          	ld	a5,-24(s0)
     d40:	4798                	lw	a4,8(a5)
     d42:	fdc42783          	lw	a5,-36(s0)
     d46:	2781                	sext.w	a5,a5
     d48:	00e79963          	bne	a5,a4,d5a <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     d4c:	fe843783          	ld	a5,-24(s0)
     d50:	6398                	ld	a4,0(a5)
     d52:	fe043783          	ld	a5,-32(s0)
     d56:	e398                	sd	a4,0(a5)
     d58:	a82d                	j	d92 <malloc+0xdc>
      else {
        p->s.size -= nunits;
     d5a:	fe843783          	ld	a5,-24(s0)
     d5e:	4798                	lw	a4,8(a5)
     d60:	fdc42783          	lw	a5,-36(s0)
     d64:	40f707bb          	subw	a5,a4,a5
     d68:	0007871b          	sext.w	a4,a5
     d6c:	fe843783          	ld	a5,-24(s0)
     d70:	c798                	sw	a4,8(a5)
        p += p->s.size;
     d72:	fe843783          	ld	a5,-24(s0)
     d76:	479c                	lw	a5,8(a5)
     d78:	1782                	slli	a5,a5,0x20
     d7a:	9381                	srli	a5,a5,0x20
     d7c:	0792                	slli	a5,a5,0x4
     d7e:	fe843703          	ld	a4,-24(s0)
     d82:	97ba                	add	a5,a5,a4
     d84:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     d88:	fe843783          	ld	a5,-24(s0)
     d8c:	fdc42703          	lw	a4,-36(s0)
     d90:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     d92:	00002797          	auipc	a5,0x2
     d96:	b5678793          	addi	a5,a5,-1194 # 28e8 <freep>
     d9a:	fe043703          	ld	a4,-32(s0)
     d9e:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     da0:	fe843783          	ld	a5,-24(s0)
     da4:	07c1                	addi	a5,a5,16
     da6:	a091                	j	dea <malloc+0x134>
    }
    if(p == freep)
     da8:	00002797          	auipc	a5,0x2
     dac:	b4078793          	addi	a5,a5,-1216 # 28e8 <freep>
     db0:	639c                	ld	a5,0(a5)
     db2:	fe843703          	ld	a4,-24(s0)
     db6:	02f71063          	bne	a4,a5,dd6 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     dba:	fdc42783          	lw	a5,-36(s0)
     dbe:	853e                	mv	a0,a5
     dc0:	00000097          	auipc	ra,0x0
     dc4:	e76080e7          	jalr	-394(ra) # c36 <morecore>
     dc8:	fea43423          	sd	a0,-24(s0)
     dcc:	fe843783          	ld	a5,-24(s0)
     dd0:	e399                	bnez	a5,dd6 <malloc+0x120>
        return 0;
     dd2:	4781                	li	a5,0
     dd4:	a819                	j	dea <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     dd6:	fe843783          	ld	a5,-24(s0)
     dda:	fef43023          	sd	a5,-32(s0)
     dde:	fe843783          	ld	a5,-24(s0)
     de2:	639c                	ld	a5,0(a5)
     de4:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     de8:	b791                	j	d2c <malloc+0x76>
  }
}
     dea:	853e                	mv	a0,a5
     dec:	70e2                	ld	ra,56(sp)
     dee:	7442                	ld	s0,48(sp)
     df0:	6121                	addi	sp,sp,64
     df2:	8082                	ret

0000000000000df4 <setjmp>:
     df4:	e100                	sd	s0,0(a0)
     df6:	e504                	sd	s1,8(a0)
     df8:	01253823          	sd	s2,16(a0)
     dfc:	01353c23          	sd	s3,24(a0)
     e00:	03453023          	sd	s4,32(a0)
     e04:	03553423          	sd	s5,40(a0)
     e08:	03653823          	sd	s6,48(a0)
     e0c:	03753c23          	sd	s7,56(a0)
     e10:	05853023          	sd	s8,64(a0)
     e14:	05953423          	sd	s9,72(a0)
     e18:	05a53823          	sd	s10,80(a0)
     e1c:	05b53c23          	sd	s11,88(a0)
     e20:	06153023          	sd	ra,96(a0)
     e24:	06253423          	sd	sp,104(a0)
     e28:	4501                	li	a0,0
     e2a:	8082                	ret

0000000000000e2c <longjmp>:
     e2c:	6100                	ld	s0,0(a0)
     e2e:	6504                	ld	s1,8(a0)
     e30:	01053903          	ld	s2,16(a0)
     e34:	01853983          	ld	s3,24(a0)
     e38:	02053a03          	ld	s4,32(a0)
     e3c:	02853a83          	ld	s5,40(a0)
     e40:	03053b03          	ld	s6,48(a0)
     e44:	03853b83          	ld	s7,56(a0)
     e48:	04053c03          	ld	s8,64(a0)
     e4c:	04853c83          	ld	s9,72(a0)
     e50:	05053d03          	ld	s10,80(a0)
     e54:	05853d83          	ld	s11,88(a0)
     e58:	06053083          	ld	ra,96(a0)
     e5c:	06853103          	ld	sp,104(a0)
     e60:	c199                	beqz	a1,e66 <longjmp_1>
     e62:	852e                	mv	a0,a1
     e64:	8082                	ret

0000000000000e66 <longjmp_1>:
     e66:	4505                	li	a0,1
     e68:	8082                	ret

0000000000000e6a <__list_add>:
 * the prev/next entries already!
 */
static inline void __list_add(struct list_head *new_entry,
                              struct list_head *prev,
                              struct list_head *next)
{
     e6a:	7179                	addi	sp,sp,-48
     e6c:	f422                	sd	s0,40(sp)
     e6e:	1800                	addi	s0,sp,48
     e70:	fea43423          	sd	a0,-24(s0)
     e74:	feb43023          	sd	a1,-32(s0)
     e78:	fcc43c23          	sd	a2,-40(s0)
    next->prev = new_entry;
     e7c:	fd843783          	ld	a5,-40(s0)
     e80:	fe843703          	ld	a4,-24(s0)
     e84:	e798                	sd	a4,8(a5)
    new_entry->next = next;
     e86:	fe843783          	ld	a5,-24(s0)
     e8a:	fd843703          	ld	a4,-40(s0)
     e8e:	e398                	sd	a4,0(a5)
    new_entry->prev = prev;
     e90:	fe843783          	ld	a5,-24(s0)
     e94:	fe043703          	ld	a4,-32(s0)
     e98:	e798                	sd	a4,8(a5)
    prev->next = new_entry;
     e9a:	fe043783          	ld	a5,-32(s0)
     e9e:	fe843703          	ld	a4,-24(s0)
     ea2:	e398                	sd	a4,0(a5)
}
     ea4:	0001                	nop
     ea6:	7422                	ld	s0,40(sp)
     ea8:	6145                	addi	sp,sp,48
     eaa:	8082                	ret

0000000000000eac <list_add_tail>:
 *
 * Insert a new entry before the specified head.
 * This is useful for implementing queues.
 */
static inline void list_add_tail(struct list_head *new_entry, struct list_head *head)
{
     eac:	1101                	addi	sp,sp,-32
     eae:	ec06                	sd	ra,24(sp)
     eb0:	e822                	sd	s0,16(sp)
     eb2:	1000                	addi	s0,sp,32
     eb4:	fea43423          	sd	a0,-24(s0)
     eb8:	feb43023          	sd	a1,-32(s0)
    __list_add(new_entry, head->prev, head);
     ebc:	fe043783          	ld	a5,-32(s0)
     ec0:	679c                	ld	a5,8(a5)
     ec2:	fe043603          	ld	a2,-32(s0)
     ec6:	85be                	mv	a1,a5
     ec8:	fe843503          	ld	a0,-24(s0)
     ecc:	00000097          	auipc	ra,0x0
     ed0:	f9e080e7          	jalr	-98(ra) # e6a <__list_add>
}
     ed4:	0001                	nop
     ed6:	60e2                	ld	ra,24(sp)
     ed8:	6442                	ld	s0,16(sp)
     eda:	6105                	addi	sp,sp,32
     edc:	8082                	ret

0000000000000ede <__list_del>:
 *
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 */
static inline void __list_del(struct list_head *prev, struct list_head *next)
{
     ede:	1101                	addi	sp,sp,-32
     ee0:	ec22                	sd	s0,24(sp)
     ee2:	1000                	addi	s0,sp,32
     ee4:	fea43423          	sd	a0,-24(s0)
     ee8:	feb43023          	sd	a1,-32(s0)
    next->prev = prev;
     eec:	fe043783          	ld	a5,-32(s0)
     ef0:	fe843703          	ld	a4,-24(s0)
     ef4:	e798                	sd	a4,8(a5)
    prev->next = next;
     ef6:	fe843783          	ld	a5,-24(s0)
     efa:	fe043703          	ld	a4,-32(s0)
     efe:	e398                	sd	a4,0(a5)
}
     f00:	0001                	nop
     f02:	6462                	ld	s0,24(sp)
     f04:	6105                	addi	sp,sp,32
     f06:	8082                	ret

0000000000000f08 <list_del>:
 * @entry: the element to delete from the list.
 * Note: list_empty on entry does not return true after this, the entry is
 * in an undefined state.
 */
static inline void list_del(struct list_head *entry)
{
     f08:	1101                	addi	sp,sp,-32
     f0a:	ec06                	sd	ra,24(sp)
     f0c:	e822                	sd	s0,16(sp)
     f0e:	1000                	addi	s0,sp,32
     f10:	fea43423          	sd	a0,-24(s0)
    __list_del(entry->prev, entry->next);
     f14:	fe843783          	ld	a5,-24(s0)
     f18:	6798                	ld	a4,8(a5)
     f1a:	fe843783          	ld	a5,-24(s0)
     f1e:	639c                	ld	a5,0(a5)
     f20:	85be                	mv	a1,a5
     f22:	853a                	mv	a0,a4
     f24:	00000097          	auipc	ra,0x0
     f28:	fba080e7          	jalr	-70(ra) # ede <__list_del>
    entry->next = LIST_POISON1;
     f2c:	fe843783          	ld	a5,-24(s0)
     f30:	00100737          	lui	a4,0x100
     f34:	10070713          	addi	a4,a4,256 # 100100 <__global_pointer$+0xfd070>
     f38:	e398                	sd	a4,0(a5)
    entry->prev = LIST_POISON2;
     f3a:	fe843783          	ld	a5,-24(s0)
     f3e:	00200737          	lui	a4,0x200
     f42:	20070713          	addi	a4,a4,512 # 200200 <__global_pointer$+0x1fd170>
     f46:	e798                	sd	a4,8(a5)
}
     f48:	0001                	nop
     f4a:	60e2                	ld	ra,24(sp)
     f4c:	6442                	ld	s0,16(sp)
     f4e:	6105                	addi	sp,sp,32
     f50:	8082                	ret

0000000000000f52 <list_empty>:
/**
 * list_empty - tests whether a list is empty
 * @head: the list to test.
 */
static inline int list_empty(const struct list_head *head)
{
     f52:	1101                	addi	sp,sp,-32
     f54:	ec22                	sd	s0,24(sp)
     f56:	1000                	addi	s0,sp,32
     f58:	fea43423          	sd	a0,-24(s0)
    return head->next == head;
     f5c:	fe843783          	ld	a5,-24(s0)
     f60:	639c                	ld	a5,0(a5)
     f62:	fe843703          	ld	a4,-24(s0)
     f66:	40f707b3          	sub	a5,a4,a5
     f6a:	0017b793          	seqz	a5,a5
     f6e:	0ff7f793          	andi	a5,a5,255
     f72:	2781                	sext.w	a5,a5
}
     f74:	853e                	mv	a0,a5
     f76:	6462                	ld	s0,24(sp)
     f78:	6105                	addi	sp,sp,32
     f7a:	8082                	ret

0000000000000f7c <thread_create>:

void __dispatch(void);
void __schedule(void);

struct thread *thread_create(void (*f)(void *), void *arg, int is_real_time, int processing_time, int period, int n)
{
     f7c:	715d                	addi	sp,sp,-80
     f7e:	e486                	sd	ra,72(sp)
     f80:	e0a2                	sd	s0,64(sp)
     f82:	0880                	addi	s0,sp,80
     f84:	fca43423          	sd	a0,-56(s0)
     f88:	fcb43023          	sd	a1,-64(s0)
     f8c:	85b2                	mv	a1,a2
     f8e:	8636                	mv	a2,a3
     f90:	86ba                	mv	a3,a4
     f92:	873e                	mv	a4,a5
     f94:	87ae                	mv	a5,a1
     f96:	faf42e23          	sw	a5,-68(s0)
     f9a:	87b2                	mv	a5,a2
     f9c:	faf42c23          	sw	a5,-72(s0)
     fa0:	87b6                	mv	a5,a3
     fa2:	faf42a23          	sw	a5,-76(s0)
     fa6:	87ba                	mv	a5,a4
     fa8:	faf42823          	sw	a5,-80(s0)
    static int _id = 1;
    struct thread *t = (struct thread *)malloc(sizeof(struct thread));
     fac:	06000513          	li	a0,96
     fb0:	00000097          	auipc	ra,0x0
     fb4:	d06080e7          	jalr	-762(ra) # cb6 <malloc>
     fb8:	fea43423          	sd	a0,-24(s0)
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long)malloc(sizeof(unsigned long) * 0x200);
     fbc:	6505                	lui	a0,0x1
     fbe:	00000097          	auipc	ra,0x0
     fc2:	cf8080e7          	jalr	-776(ra) # cb6 <malloc>
     fc6:	87aa                	mv	a5,a0
     fc8:	fef43023          	sd	a5,-32(s0)
    new_stack_p = new_stack + 0x200 * 8 - 0x2 * 8;
     fcc:	fe043703          	ld	a4,-32(s0)
     fd0:	6785                	lui	a5,0x1
     fd2:	17c1                	addi	a5,a5,-16
     fd4:	97ba                	add	a5,a5,a4
     fd6:	fcf43c23          	sd	a5,-40(s0)
    t->fp = f;
     fda:	fe843783          	ld	a5,-24(s0)
     fde:	fc843703          	ld	a4,-56(s0)
     fe2:	e398                	sd	a4,0(a5)
    t->arg = arg;
     fe4:	fe843783          	ld	a5,-24(s0)
     fe8:	fc043703          	ld	a4,-64(s0)
     fec:	e798                	sd	a4,8(a5)
    t->ID = _id++;
     fee:	00002797          	auipc	a5,0x2
     ff2:	8de78793          	addi	a5,a5,-1826 # 28cc <_id.1229>
     ff6:	439c                	lw	a5,0(a5)
     ff8:	0017871b          	addiw	a4,a5,1
     ffc:	0007069b          	sext.w	a3,a4
    1000:	00002717          	auipc	a4,0x2
    1004:	8cc70713          	addi	a4,a4,-1844 # 28cc <_id.1229>
    1008:	c314                	sw	a3,0(a4)
    100a:	fe843703          	ld	a4,-24(s0)
    100e:	df5c                	sw	a5,60(a4)
    t->buf_set = 0;
    1010:	fe843783          	ld	a5,-24(s0)
    1014:	0207a023          	sw	zero,32(a5)
    t->stack = (void *)new_stack;
    1018:	fe043703          	ld	a4,-32(s0)
    101c:	fe843783          	ld	a5,-24(s0)
    1020:	eb98                	sd	a4,16(a5)
    t->stack_p = (void *)new_stack_p;
    1022:	fd843703          	ld	a4,-40(s0)
    1026:	fe843783          	ld	a5,-24(s0)
    102a:	ef98                	sd	a4,24(a5)

    t->processing_time = processing_time;
    102c:	fe843783          	ld	a5,-24(s0)
    1030:	fb842703          	lw	a4,-72(s0)
    1034:	c3f8                	sw	a4,68(a5)
    t->period = period;
    1036:	fe843783          	ld	a5,-24(s0)
    103a:	fb442703          	lw	a4,-76(s0)
    103e:	cbb8                	sw	a4,80(a5)
    t->deadline = period;
    1040:	fe843783          	ld	a5,-24(s0)
    1044:	fb442703          	lw	a4,-76(s0)
    1048:	c7f8                	sw	a4,76(a5)
    t->n = n;
    104a:	fe843783          	ld	a5,-24(s0)
    104e:	fb042703          	lw	a4,-80(s0)
    1052:	cbf8                	sw	a4,84(a5)
    t->is_real_time = is_real_time;
    1054:	fe843783          	ld	a5,-24(s0)
    1058:	fbc42703          	lw	a4,-68(s0)
    105c:	c3b8                	sw	a4,64(a5)
    t->weight = 1;
    105e:	fe843783          	ld	a5,-24(s0)
    1062:	4705                	li	a4,1
    1064:	c7b8                	sw	a4,72(a5)
    t->remaining_time = processing_time;
    1066:	fe843783          	ld	a5,-24(s0)
    106a:	fb842703          	lw	a4,-72(s0)
    106e:	cfb8                	sw	a4,88(a5)
    t->current_deadline = 0;
    1070:	fe843783          	ld	a5,-24(s0)
    1074:	0407ae23          	sw	zero,92(a5)
    return t;
    1078:	fe843783          	ld	a5,-24(s0)
}
    107c:	853e                	mv	a0,a5
    107e:	60a6                	ld	ra,72(sp)
    1080:	6406                	ld	s0,64(sp)
    1082:	6161                	addi	sp,sp,80
    1084:	8082                	ret

0000000000001086 <thread_set_weight>:

void thread_set_weight(struct thread *t, int weight)
{
    1086:	1101                	addi	sp,sp,-32
    1088:	ec22                	sd	s0,24(sp)
    108a:	1000                	addi	s0,sp,32
    108c:	fea43423          	sd	a0,-24(s0)
    1090:	87ae                	mv	a5,a1
    1092:	fef42223          	sw	a5,-28(s0)
    t->weight = weight;
    1096:	fe843783          	ld	a5,-24(s0)
    109a:	fe442703          	lw	a4,-28(s0)
    109e:	c7b8                	sw	a4,72(a5)
}
    10a0:	0001                	nop
    10a2:	6462                	ld	s0,24(sp)
    10a4:	6105                	addi	sp,sp,32
    10a6:	8082                	ret

00000000000010a8 <thread_add_at>:

void thread_add_at(struct thread *t, int arrival_time)
{
    10a8:	7179                	addi	sp,sp,-48
    10aa:	f406                	sd	ra,40(sp)
    10ac:	f022                	sd	s0,32(sp)
    10ae:	1800                	addi	s0,sp,48
    10b0:	fca43c23          	sd	a0,-40(s0)
    10b4:	87ae                	mv	a5,a1
    10b6:	fcf42a23          	sw	a5,-44(s0)
    struct release_queue_entry *new_entry = (struct release_queue_entry *)malloc(sizeof(struct release_queue_entry));
    10ba:	02000513          	li	a0,32
    10be:	00000097          	auipc	ra,0x0
    10c2:	bf8080e7          	jalr	-1032(ra) # cb6 <malloc>
    10c6:	fea43423          	sd	a0,-24(s0)
    new_entry->thrd = t;
    10ca:	fe843783          	ld	a5,-24(s0)
    10ce:	fd843703          	ld	a4,-40(s0)
    10d2:	e398                	sd	a4,0(a5)
    new_entry->release_time = arrival_time;
    10d4:	fe843783          	ld	a5,-24(s0)
    10d8:	fd442703          	lw	a4,-44(s0)
    10dc:	cf98                	sw	a4,24(a5)
    if (t->is_real_time) {
    10de:	fd843783          	ld	a5,-40(s0)
    10e2:	43bc                	lw	a5,64(a5)
    10e4:	c38d                	beqz	a5,1106 <thread_add_at+0x5e>
        t->current_deadline = arrival_time;
    10e6:	fd843783          	ld	a5,-40(s0)
    10ea:	fd442703          	lw	a4,-44(s0)
    10ee:	cff8                	sw	a4,92(a5)
        t->current_deadline = arrival_time + t->deadline;
    10f0:	fd843783          	ld	a5,-40(s0)
    10f4:	47fc                	lw	a5,76(a5)
    10f6:	fd442703          	lw	a4,-44(s0)
    10fa:	9fb9                	addw	a5,a5,a4
    10fc:	0007871b          	sext.w	a4,a5
    1100:	fd843783          	ld	a5,-40(s0)
    1104:	cff8                	sw	a4,92(a5)
    }
    list_add_tail(&new_entry->thread_list, &release_queue);
    1106:	fe843783          	ld	a5,-24(s0)
    110a:	07a1                	addi	a5,a5,8
    110c:	00001597          	auipc	a1,0x1
    1110:	7ac58593          	addi	a1,a1,1964 # 28b8 <release_queue>
    1114:	853e                	mv	a0,a5
    1116:	00000097          	auipc	ra,0x0
    111a:	d96080e7          	jalr	-618(ra) # eac <list_add_tail>
}
    111e:	0001                	nop
    1120:	70a2                	ld	ra,40(sp)
    1122:	7402                	ld	s0,32(sp)
    1124:	6145                	addi	sp,sp,48
    1126:	8082                	ret

0000000000001128 <__release>:

void __release()
{
    1128:	7139                	addi	sp,sp,-64
    112a:	fc06                	sd	ra,56(sp)
    112c:	f822                	sd	s0,48(sp)
    112e:	0080                	addi	s0,sp,64
    struct release_queue_entry *cur, *nxt;
    list_for_each_entry_safe(cur, nxt, &release_queue, thread_list) {
    1130:	00001797          	auipc	a5,0x1
    1134:	78878793          	addi	a5,a5,1928 # 28b8 <release_queue>
    1138:	639c                	ld	a5,0(a5)
    113a:	fcf43c23          	sd	a5,-40(s0)
    113e:	fd843783          	ld	a5,-40(s0)
    1142:	17e1                	addi	a5,a5,-8
    1144:	fef43423          	sd	a5,-24(s0)
    1148:	fe843783          	ld	a5,-24(s0)
    114c:	679c                	ld	a5,8(a5)
    114e:	fcf43823          	sd	a5,-48(s0)
    1152:	fd043783          	ld	a5,-48(s0)
    1156:	17e1                	addi	a5,a5,-8
    1158:	fef43023          	sd	a5,-32(s0)
    115c:	a851                	j	11f0 <__release+0xc8>
        if (threading_system_time >= cur->release_time) {
    115e:	fe843783          	ld	a5,-24(s0)
    1162:	4f98                	lw	a4,24(a5)
    1164:	00001797          	auipc	a5,0x1
    1168:	79478793          	addi	a5,a5,1940 # 28f8 <threading_system_time>
    116c:	439c                	lw	a5,0(a5)
    116e:	06e7c363          	blt	a5,a4,11d4 <__release+0xac>
            cur->thrd->remaining_time = cur->thrd->processing_time;
    1172:	fe843783          	ld	a5,-24(s0)
    1176:	6398                	ld	a4,0(a5)
    1178:	fe843783          	ld	a5,-24(s0)
    117c:	639c                	ld	a5,0(a5)
    117e:	4378                	lw	a4,68(a4)
    1180:	cfb8                	sw	a4,88(a5)
            cur->thrd->current_deadline = cur->release_time + cur->thrd->deadline;
    1182:	fe843783          	ld	a5,-24(s0)
    1186:	4f94                	lw	a3,24(a5)
    1188:	fe843783          	ld	a5,-24(s0)
    118c:	639c                	ld	a5,0(a5)
    118e:	47f8                	lw	a4,76(a5)
    1190:	fe843783          	ld	a5,-24(s0)
    1194:	639c                	ld	a5,0(a5)
    1196:	9f35                	addw	a4,a4,a3
    1198:	2701                	sext.w	a4,a4
    119a:	cff8                	sw	a4,92(a5)
            list_add_tail(&cur->thrd->thread_list, &run_queue);
    119c:	fe843783          	ld	a5,-24(s0)
    11a0:	639c                	ld	a5,0(a5)
    11a2:	02878793          	addi	a5,a5,40
    11a6:	00001597          	auipc	a1,0x1
    11aa:	70258593          	addi	a1,a1,1794 # 28a8 <run_queue>
    11ae:	853e                	mv	a0,a5
    11b0:	00000097          	auipc	ra,0x0
    11b4:	cfc080e7          	jalr	-772(ra) # eac <list_add_tail>
            list_del(&cur->thread_list);
    11b8:	fe843783          	ld	a5,-24(s0)
    11bc:	07a1                	addi	a5,a5,8
    11be:	853e                	mv	a0,a5
    11c0:	00000097          	auipc	ra,0x0
    11c4:	d48080e7          	jalr	-696(ra) # f08 <list_del>
            free(cur);
    11c8:	fe843503          	ld	a0,-24(s0)
    11cc:	00000097          	auipc	ra,0x0
    11d0:	948080e7          	jalr	-1720(ra) # b14 <free>
    list_for_each_entry_safe(cur, nxt, &release_queue, thread_list) {
    11d4:	fe043783          	ld	a5,-32(s0)
    11d8:	fef43423          	sd	a5,-24(s0)
    11dc:	fe043783          	ld	a5,-32(s0)
    11e0:	679c                	ld	a5,8(a5)
    11e2:	fcf43423          	sd	a5,-56(s0)
    11e6:	fc843783          	ld	a5,-56(s0)
    11ea:	17e1                	addi	a5,a5,-8
    11ec:	fef43023          	sd	a5,-32(s0)
    11f0:	fe843783          	ld	a5,-24(s0)
    11f4:	00878713          	addi	a4,a5,8
    11f8:	00001797          	auipc	a5,0x1
    11fc:	6c078793          	addi	a5,a5,1728 # 28b8 <release_queue>
    1200:	f4f71fe3          	bne	a4,a5,115e <__release+0x36>
        }
    }
}
    1204:	0001                	nop
    1206:	0001                	nop
    1208:	70e2                	ld	ra,56(sp)
    120a:	7442                	ld	s0,48(sp)
    120c:	6121                	addi	sp,sp,64
    120e:	8082                	ret

0000000000001210 <__thread_exit>:

void __thread_exit(struct thread *to_remove)
{
    1210:	1101                	addi	sp,sp,-32
    1212:	ec06                	sd	ra,24(sp)
    1214:	e822                	sd	s0,16(sp)
    1216:	1000                	addi	s0,sp,32
    1218:	fea43423          	sd	a0,-24(s0)
    current = to_remove->thread_list.prev;
    121c:	fe843783          	ld	a5,-24(s0)
    1220:	7b98                	ld	a4,48(a5)
    1222:	00001797          	auipc	a5,0x1
    1226:	6ce78793          	addi	a5,a5,1742 # 28f0 <current>
    122a:	e398                	sd	a4,0(a5)
    list_del(&to_remove->thread_list);
    122c:	fe843783          	ld	a5,-24(s0)
    1230:	02878793          	addi	a5,a5,40
    1234:	853e                	mv	a0,a5
    1236:	00000097          	auipc	ra,0x0
    123a:	cd2080e7          	jalr	-814(ra) # f08 <list_del>

    free(to_remove->stack);
    123e:	fe843783          	ld	a5,-24(s0)
    1242:	6b9c                	ld	a5,16(a5)
    1244:	853e                	mv	a0,a5
    1246:	00000097          	auipc	ra,0x0
    124a:	8ce080e7          	jalr	-1842(ra) # b14 <free>
    free(to_remove);
    124e:	fe843503          	ld	a0,-24(s0)
    1252:	00000097          	auipc	ra,0x0
    1256:	8c2080e7          	jalr	-1854(ra) # b14 <free>

    __schedule();
    125a:	00000097          	auipc	ra,0x0
    125e:	572080e7          	jalr	1394(ra) # 17cc <__schedule>
    __dispatch();
    1262:	00000097          	auipc	ra,0x0
    1266:	3da080e7          	jalr	986(ra) # 163c <__dispatch>
    thrdresume(main_thrd_id);
    126a:	00001797          	auipc	a5,0x1
    126e:	65e78793          	addi	a5,a5,1630 # 28c8 <main_thrd_id>
    1272:	439c                	lw	a5,0(a5)
    1274:	853e                	mv	a0,a5
    1276:	fffff097          	auipc	ra,0xfffff
    127a:	3b0080e7          	jalr	944(ra) # 626 <thrdresume>
}
    127e:	0001                	nop
    1280:	60e2                	ld	ra,24(sp)
    1282:	6442                	ld	s0,16(sp)
    1284:	6105                	addi	sp,sp,32
    1286:	8082                	ret

0000000000001288 <thread_exit>:

void thread_exit(void)
{
    1288:	7179                	addi	sp,sp,-48
    128a:	f406                	sd	ra,40(sp)
    128c:	f022                	sd	s0,32(sp)
    128e:	1800                	addi	s0,sp,48
    if (current == &run_queue) {
    1290:	00001797          	auipc	a5,0x1
    1294:	66078793          	addi	a5,a5,1632 # 28f0 <current>
    1298:	6398                	ld	a4,0(a5)
    129a:	00001797          	auipc	a5,0x1
    129e:	60e78793          	addi	a5,a5,1550 # 28a8 <run_queue>
    12a2:	02f71063          	bne	a4,a5,12c2 <thread_exit+0x3a>
        fprintf(2, "[FATAL] thread_exit is called on a nonexistent thread\n");
    12a6:	00001597          	auipc	a1,0x1
    12aa:	4aa58593          	addi	a1,a1,1194 # 2750 <schedule_dm+0x2ee>
    12ae:	4509                	li	a0,2
    12b0:	fffff097          	auipc	ra,0xfffff
    12b4:	7bc080e7          	jalr	1980(ra) # a6c <fprintf>
        exit(1);
    12b8:	4505                	li	a0,1
    12ba:	fffff097          	auipc	ra,0xfffff
    12be:	2c4080e7          	jalr	708(ra) # 57e <exit>
    }

    struct thread *to_remove = list_entry(current, struct thread, thread_list);
    12c2:	00001797          	auipc	a5,0x1
    12c6:	62e78793          	addi	a5,a5,1582 # 28f0 <current>
    12ca:	639c                	ld	a5,0(a5)
    12cc:	fef43423          	sd	a5,-24(s0)
    12d0:	fe843783          	ld	a5,-24(s0)
    12d4:	fd878793          	addi	a5,a5,-40
    12d8:	fef43023          	sd	a5,-32(s0)
    int consume_ticks = cancelthrdstop(to_remove->thrdstop_context_id, 1);
    12dc:	fe043783          	ld	a5,-32(s0)
    12e0:	5f9c                	lw	a5,56(a5)
    12e2:	4585                	li	a1,1
    12e4:	853e                	mv	a0,a5
    12e6:	fffff097          	auipc	ra,0xfffff
    12ea:	348080e7          	jalr	840(ra) # 62e <cancelthrdstop>
    12ee:	87aa                	mv	a5,a0
    12f0:	fcf42e23          	sw	a5,-36(s0)
    threading_system_time += consume_ticks;
    12f4:	00001797          	auipc	a5,0x1
    12f8:	60478793          	addi	a5,a5,1540 # 28f8 <threading_system_time>
    12fc:	439c                	lw	a5,0(a5)
    12fe:	fdc42703          	lw	a4,-36(s0)
    1302:	9fb9                	addw	a5,a5,a4
    1304:	0007871b          	sext.w	a4,a5
    1308:	00001797          	auipc	a5,0x1
    130c:	5f078793          	addi	a5,a5,1520 # 28f8 <threading_system_time>
    1310:	c398                	sw	a4,0(a5)

    __release();
    1312:	00000097          	auipc	ra,0x0
    1316:	e16080e7          	jalr	-490(ra) # 1128 <__release>
    __thread_exit(to_remove);
    131a:	fe043503          	ld	a0,-32(s0)
    131e:	00000097          	auipc	ra,0x0
    1322:	ef2080e7          	jalr	-270(ra) # 1210 <__thread_exit>
}
    1326:	0001                	nop
    1328:	70a2                	ld	ra,40(sp)
    132a:	7402                	ld	s0,32(sp)
    132c:	6145                	addi	sp,sp,48
    132e:	8082                	ret

0000000000001330 <__finish_current>:

void __finish_current()
{
    1330:	7179                	addi	sp,sp,-48
    1332:	f406                	sd	ra,40(sp)
    1334:	f022                	sd	s0,32(sp)
    1336:	1800                	addi	s0,sp,48
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    1338:	00001797          	auipc	a5,0x1
    133c:	5b878793          	addi	a5,a5,1464 # 28f0 <current>
    1340:	639c                	ld	a5,0(a5)
    1342:	fef43423          	sd	a5,-24(s0)
    1346:	fe843783          	ld	a5,-24(s0)
    134a:	fd878793          	addi	a5,a5,-40
    134e:	fef43023          	sd	a5,-32(s0)
    --current_thread->n;
    1352:	fe043783          	ld	a5,-32(s0)
    1356:	4bfc                	lw	a5,84(a5)
    1358:	37fd                	addiw	a5,a5,-1
    135a:	0007871b          	sext.w	a4,a5
    135e:	fe043783          	ld	a5,-32(s0)
    1362:	cbf8                	sw	a4,84(a5)

    printf("thread#%d finish at %d\n",
    1364:	fe043783          	ld	a5,-32(s0)
    1368:	5fd8                	lw	a4,60(a5)
    136a:	00001797          	auipc	a5,0x1
    136e:	58e78793          	addi	a5,a5,1422 # 28f8 <threading_system_time>
    1372:	4390                	lw	a2,0(a5)
    1374:	fe043783          	ld	a5,-32(s0)
    1378:	4bfc                	lw	a5,84(a5)
    137a:	86be                	mv	a3,a5
    137c:	85ba                	mv	a1,a4
    137e:	00001517          	auipc	a0,0x1
    1382:	40a50513          	addi	a0,a0,1034 # 2788 <schedule_dm+0x326>
    1386:	fffff097          	auipc	ra,0xfffff
    138a:	73e080e7          	jalr	1854(ra) # ac4 <printf>
           current_thread->ID, threading_system_time, current_thread->n);

    if (current_thread->n > 0) {
    138e:	fe043783          	ld	a5,-32(s0)
    1392:	4bfc                	lw	a5,84(a5)
    1394:	04f05563          	blez	a5,13de <__finish_current+0xae>
        struct list_head *to_remove = current;
    1398:	00001797          	auipc	a5,0x1
    139c:	55878793          	addi	a5,a5,1368 # 28f0 <current>
    13a0:	639c                	ld	a5,0(a5)
    13a2:	fcf43c23          	sd	a5,-40(s0)
        current = current->prev;
    13a6:	00001797          	auipc	a5,0x1
    13aa:	54a78793          	addi	a5,a5,1354 # 28f0 <current>
    13ae:	639c                	ld	a5,0(a5)
    13b0:	6798                	ld	a4,8(a5)
    13b2:	00001797          	auipc	a5,0x1
    13b6:	53e78793          	addi	a5,a5,1342 # 28f0 <current>
    13ba:	e398                	sd	a4,0(a5)
        list_del(to_remove);
    13bc:	fd843503          	ld	a0,-40(s0)
    13c0:	00000097          	auipc	ra,0x0
    13c4:	b48080e7          	jalr	-1208(ra) # f08 <list_del>
        thread_add_at(current_thread, current_thread->current_deadline);
    13c8:	fe043783          	ld	a5,-32(s0)
    13cc:	4ffc                	lw	a5,92(a5)
    13ce:	85be                	mv	a1,a5
    13d0:	fe043503          	ld	a0,-32(s0)
    13d4:	00000097          	auipc	ra,0x0
    13d8:	cd4080e7          	jalr	-812(ra) # 10a8 <thread_add_at>
    } else {
        __thread_exit(current_thread);
    }
}
    13dc:	a039                	j	13ea <__finish_current+0xba>
        __thread_exit(current_thread);
    13de:	fe043503          	ld	a0,-32(s0)
    13e2:	00000097          	auipc	ra,0x0
    13e6:	e2e080e7          	jalr	-466(ra) # 1210 <__thread_exit>
}
    13ea:	0001                	nop
    13ec:	70a2                	ld	ra,40(sp)
    13ee:	7402                	ld	s0,32(sp)
    13f0:	6145                	addi	sp,sp,48
    13f2:	8082                	ret

00000000000013f4 <__rt_finish_current>:
void __rt_finish_current()
{
    13f4:	7179                	addi	sp,sp,-48
    13f6:	f406                	sd	ra,40(sp)
    13f8:	f022                	sd	s0,32(sp)
    13fa:	1800                	addi	s0,sp,48
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    13fc:	00001797          	auipc	a5,0x1
    1400:	4f478793          	addi	a5,a5,1268 # 28f0 <current>
    1404:	639c                	ld	a5,0(a5)
    1406:	fef43423          	sd	a5,-24(s0)
    140a:	fe843783          	ld	a5,-24(s0)
    140e:	fd878793          	addi	a5,a5,-40
    1412:	fef43023          	sd	a5,-32(s0)
    --current_thread->n;
    1416:	fe043783          	ld	a5,-32(s0)
    141a:	4bfc                	lw	a5,84(a5)
    141c:	37fd                	addiw	a5,a5,-1
    141e:	0007871b          	sext.w	a4,a5
    1422:	fe043783          	ld	a5,-32(s0)
    1426:	cbf8                	sw	a4,84(a5)

    printf("thread#%d finish one cycle at %d: %d cycles left\n",
    1428:	fe043783          	ld	a5,-32(s0)
    142c:	5fd8                	lw	a4,60(a5)
    142e:	00001797          	auipc	a5,0x1
    1432:	4ca78793          	addi	a5,a5,1226 # 28f8 <threading_system_time>
    1436:	4390                	lw	a2,0(a5)
    1438:	fe043783          	ld	a5,-32(s0)
    143c:	4bfc                	lw	a5,84(a5)
    143e:	86be                	mv	a3,a5
    1440:	85ba                	mv	a1,a4
    1442:	00001517          	auipc	a0,0x1
    1446:	35e50513          	addi	a0,a0,862 # 27a0 <schedule_dm+0x33e>
    144a:	fffff097          	auipc	ra,0xfffff
    144e:	67a080e7          	jalr	1658(ra) # ac4 <printf>
           current_thread->ID, threading_system_time, current_thread->n);

    if (current_thread->n > 0) {
    1452:	fe043783          	ld	a5,-32(s0)
    1456:	4bfc                	lw	a5,84(a5)
    1458:	04f05563          	blez	a5,14a2 <__rt_finish_current+0xae>
        struct list_head *to_remove = current;
    145c:	00001797          	auipc	a5,0x1
    1460:	49478793          	addi	a5,a5,1172 # 28f0 <current>
    1464:	639c                	ld	a5,0(a5)
    1466:	fcf43c23          	sd	a5,-40(s0)
        current = current->prev;
    146a:	00001797          	auipc	a5,0x1
    146e:	48678793          	addi	a5,a5,1158 # 28f0 <current>
    1472:	639c                	ld	a5,0(a5)
    1474:	6798                	ld	a4,8(a5)
    1476:	00001797          	auipc	a5,0x1
    147a:	47a78793          	addi	a5,a5,1146 # 28f0 <current>
    147e:	e398                	sd	a4,0(a5)
        list_del(to_remove);
    1480:	fd843503          	ld	a0,-40(s0)
    1484:	00000097          	auipc	ra,0x0
    1488:	a84080e7          	jalr	-1404(ra) # f08 <list_del>
        thread_add_at(current_thread, current_thread->current_deadline);
    148c:	fe043783          	ld	a5,-32(s0)
    1490:	4ffc                	lw	a5,92(a5)
    1492:	85be                	mv	a1,a5
    1494:	fe043503          	ld	a0,-32(s0)
    1498:	00000097          	auipc	ra,0x0
    149c:	c10080e7          	jalr	-1008(ra) # 10a8 <thread_add_at>
    } else {
        __thread_exit(current_thread);
    }
}
    14a0:	a039                	j	14ae <__rt_finish_current+0xba>
        __thread_exit(current_thread);
    14a2:	fe043503          	ld	a0,-32(s0)
    14a6:	00000097          	auipc	ra,0x0
    14aa:	d6a080e7          	jalr	-662(ra) # 1210 <__thread_exit>
}
    14ae:	0001                	nop
    14b0:	70a2                	ld	ra,40(sp)
    14b2:	7402                	ld	s0,32(sp)
    14b4:	6145                	addi	sp,sp,48
    14b6:	8082                	ret

00000000000014b8 <switch_handler>:

void switch_handler(void *arg)
{
    14b8:	7139                	addi	sp,sp,-64
    14ba:	fc06                	sd	ra,56(sp)
    14bc:	f822                	sd	s0,48(sp)
    14be:	0080                	addi	s0,sp,64
    14c0:	fca43423          	sd	a0,-56(s0)
    uint64 elapsed_time = (uint64)arg;
    14c4:	fc843783          	ld	a5,-56(s0)
    14c8:	fef43423          	sd	a5,-24(s0)
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    14cc:	00001797          	auipc	a5,0x1
    14d0:	42478793          	addi	a5,a5,1060 # 28f0 <current>
    14d4:	639c                	ld	a5,0(a5)
    14d6:	fef43023          	sd	a5,-32(s0)
    14da:	fe043783          	ld	a5,-32(s0)
    14de:	fd878793          	addi	a5,a5,-40
    14e2:	fcf43c23          	sd	a5,-40(s0)

    threading_system_time += elapsed_time;
    14e6:	fe843783          	ld	a5,-24(s0)
    14ea:	0007871b          	sext.w	a4,a5
    14ee:	00001797          	auipc	a5,0x1
    14f2:	40a78793          	addi	a5,a5,1034 # 28f8 <threading_system_time>
    14f6:	439c                	lw	a5,0(a5)
    14f8:	2781                	sext.w	a5,a5
    14fa:	9fb9                	addw	a5,a5,a4
    14fc:	2781                	sext.w	a5,a5
    14fe:	0007871b          	sext.w	a4,a5
    1502:	00001797          	auipc	a5,0x1
    1506:	3f678793          	addi	a5,a5,1014 # 28f8 <threading_system_time>
    150a:	c398                	sw	a4,0(a5)
     __release();
    150c:	00000097          	auipc	ra,0x0
    1510:	c1c080e7          	jalr	-996(ra) # 1128 <__release>
    current_thread->remaining_time -= elapsed_time;
    1514:	fd843783          	ld	a5,-40(s0)
    1518:	4fbc                	lw	a5,88(a5)
    151a:	0007871b          	sext.w	a4,a5
    151e:	fe843783          	ld	a5,-24(s0)
    1522:	2781                	sext.w	a5,a5
    1524:	40f707bb          	subw	a5,a4,a5
    1528:	2781                	sext.w	a5,a5
    152a:	0007871b          	sext.w	a4,a5
    152e:	fd843783          	ld	a5,-40(s0)
    1532:	cfb8                	sw	a4,88(a5)

    if (current_thread->is_real_time)
    1534:	fd843783          	ld	a5,-40(s0)
    1538:	43bc                	lw	a5,64(a5)
    153a:	c3ad                	beqz	a5,159c <switch_handler+0xe4>
        if (threading_system_time > current_thread->current_deadline || 
    153c:	fd843783          	ld	a5,-40(s0)
    1540:	4ff8                	lw	a4,92(a5)
    1542:	00001797          	auipc	a5,0x1
    1546:	3b678793          	addi	a5,a5,950 # 28f8 <threading_system_time>
    154a:	439c                	lw	a5,0(a5)
    154c:	02f74163          	blt	a4,a5,156e <switch_handler+0xb6>
            (threading_system_time == current_thread->current_deadline && current_thread->remaining_time > 0)) {
    1550:	fd843783          	ld	a5,-40(s0)
    1554:	4ff8                	lw	a4,92(a5)
    1556:	00001797          	auipc	a5,0x1
    155a:	3a278793          	addi	a5,a5,930 # 28f8 <threading_system_time>
    155e:	439c                	lw	a5,0(a5)
        if (threading_system_time > current_thread->current_deadline || 
    1560:	02f71e63          	bne	a4,a5,159c <switch_handler+0xe4>
            (threading_system_time == current_thread->current_deadline && current_thread->remaining_time > 0)) {
    1564:	fd843783          	ld	a5,-40(s0)
    1568:	4fbc                	lw	a5,88(a5)
    156a:	02f05963          	blez	a5,159c <switch_handler+0xe4>
            printf("thread#%d misses a deadline at %d\n", current_thread->ID, threading_system_time);
    156e:	fd843783          	ld	a5,-40(s0)
    1572:	5fd8                	lw	a4,60(a5)
    1574:	00001797          	auipc	a5,0x1
    1578:	38478793          	addi	a5,a5,900 # 28f8 <threading_system_time>
    157c:	439c                	lw	a5,0(a5)
    157e:	863e                	mv	a2,a5
    1580:	85ba                	mv	a1,a4
    1582:	00001517          	auipc	a0,0x1
    1586:	25650513          	addi	a0,a0,598 # 27d8 <schedule_dm+0x376>
    158a:	fffff097          	auipc	ra,0xfffff
    158e:	53a080e7          	jalr	1338(ra) # ac4 <printf>
            exit(0);
    1592:	4501                	li	a0,0
    1594:	fffff097          	auipc	ra,0xfffff
    1598:	fea080e7          	jalr	-22(ra) # 57e <exit>
        }

    if (current_thread->remaining_time <= 0) {
    159c:	fd843783          	ld	a5,-40(s0)
    15a0:	4fbc                	lw	a5,88(a5)
    15a2:	02f04063          	bgtz	a5,15c2 <switch_handler+0x10a>
        if (current_thread->is_real_time)
    15a6:	fd843783          	ld	a5,-40(s0)
    15aa:	43bc                	lw	a5,64(a5)
    15ac:	c791                	beqz	a5,15b8 <switch_handler+0x100>
            __rt_finish_current();
    15ae:	00000097          	auipc	ra,0x0
    15b2:	e46080e7          	jalr	-442(ra) # 13f4 <__rt_finish_current>
    15b6:	a881                	j	1606 <switch_handler+0x14e>
        else
            __finish_current();
    15b8:	00000097          	auipc	ra,0x0
    15bc:	d78080e7          	jalr	-648(ra) # 1330 <__finish_current>
    15c0:	a099                	j	1606 <switch_handler+0x14e>
    } else {
        // move the current thread to the end of the run_queue
        struct list_head *to_remove = current;
    15c2:	00001797          	auipc	a5,0x1
    15c6:	32e78793          	addi	a5,a5,814 # 28f0 <current>
    15ca:	639c                	ld	a5,0(a5)
    15cc:	fcf43823          	sd	a5,-48(s0)
        current = current->prev;
    15d0:	00001797          	auipc	a5,0x1
    15d4:	32078793          	addi	a5,a5,800 # 28f0 <current>
    15d8:	639c                	ld	a5,0(a5)
    15da:	6798                	ld	a4,8(a5)
    15dc:	00001797          	auipc	a5,0x1
    15e0:	31478793          	addi	a5,a5,788 # 28f0 <current>
    15e4:	e398                	sd	a4,0(a5)
        list_del(to_remove);
    15e6:	fd043503          	ld	a0,-48(s0)
    15ea:	00000097          	auipc	ra,0x0
    15ee:	91e080e7          	jalr	-1762(ra) # f08 <list_del>
        list_add_tail(to_remove, &run_queue);
    15f2:	00001597          	auipc	a1,0x1
    15f6:	2b658593          	addi	a1,a1,694 # 28a8 <run_queue>
    15fa:	fd043503          	ld	a0,-48(s0)
    15fe:	00000097          	auipc	ra,0x0
    1602:	8ae080e7          	jalr	-1874(ra) # eac <list_add_tail>
    }

    __release();
    1606:	00000097          	auipc	ra,0x0
    160a:	b22080e7          	jalr	-1246(ra) # 1128 <__release>
    __schedule();
    160e:	00000097          	auipc	ra,0x0
    1612:	1be080e7          	jalr	446(ra) # 17cc <__schedule>
    __dispatch();
    1616:	00000097          	auipc	ra,0x0
    161a:	026080e7          	jalr	38(ra) # 163c <__dispatch>
    thrdresume(main_thrd_id);
    161e:	00001797          	auipc	a5,0x1
    1622:	2aa78793          	addi	a5,a5,682 # 28c8 <main_thrd_id>
    1626:	439c                	lw	a5,0(a5)
    1628:	853e                	mv	a0,a5
    162a:	fffff097          	auipc	ra,0xfffff
    162e:	ffc080e7          	jalr	-4(ra) # 626 <thrdresume>
}
    1632:	0001                	nop
    1634:	70e2                	ld	ra,56(sp)
    1636:	7442                	ld	s0,48(sp)
    1638:	6121                	addi	sp,sp,64
    163a:	8082                	ret

000000000000163c <__dispatch>:

void __dispatch()
{
    163c:	7179                	addi	sp,sp,-48
    163e:	f406                	sd	ra,40(sp)
    1640:	f022                	sd	s0,32(sp)
    1642:	1800                	addi	s0,sp,48
    if (current == &run_queue) {
    1644:	00001797          	auipc	a5,0x1
    1648:	2ac78793          	addi	a5,a5,684 # 28f0 <current>
    164c:	6398                	ld	a4,0(a5)
    164e:	00001797          	auipc	a5,0x1
    1652:	25a78793          	addi	a5,a5,602 # 28a8 <run_queue>
    1656:	16f70663          	beq	a4,a5,17c2 <__dispatch+0x186>
    if (allocated_time < 0) {
        fprintf(2, "[FATAL] allocated_time is negative\n");
        exit(1);
    }

    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    165a:	00001797          	auipc	a5,0x1
    165e:	29678793          	addi	a5,a5,662 # 28f0 <current>
    1662:	639c                	ld	a5,0(a5)
    1664:	fef43423          	sd	a5,-24(s0)
    1668:	fe843783          	ld	a5,-24(s0)
    166c:	fd878793          	addi	a5,a5,-40
    1670:	fef43023          	sd	a5,-32(s0)
    if (current_thread->is_real_time && allocated_time == 0) { // miss deadline, abort
    1674:	fe043783          	ld	a5,-32(s0)
    1678:	43bc                	lw	a5,64(a5)
    167a:	cf85                	beqz	a5,16b2 <__dispatch+0x76>
    167c:	00001797          	auipc	a5,0x1
    1680:	28478793          	addi	a5,a5,644 # 2900 <allocated_time>
    1684:	639c                	ld	a5,0(a5)
    1686:	e795                	bnez	a5,16b2 <__dispatch+0x76>
        printf("thread#%d misses a deadline at %d\n", current_thread->ID, current_thread->current_deadline);
    1688:	fe043783          	ld	a5,-32(s0)
    168c:	5fd8                	lw	a4,60(a5)
    168e:	fe043783          	ld	a5,-32(s0)
    1692:	4ffc                	lw	a5,92(a5)
    1694:	863e                	mv	a2,a5
    1696:	85ba                	mv	a1,a4
    1698:	00001517          	auipc	a0,0x1
    169c:	14050513          	addi	a0,a0,320 # 27d8 <schedule_dm+0x376>
    16a0:	fffff097          	auipc	ra,0xfffff
    16a4:	424080e7          	jalr	1060(ra) # ac4 <printf>
        exit(0);
    16a8:	4501                	li	a0,0
    16aa:	fffff097          	auipc	ra,0xfffff
    16ae:	ed4080e7          	jalr	-300(ra) # 57e <exit>
    }

    printf("dispatch thread#%d at %d: allocated_time=%d\n", current_thread->ID, threading_system_time, allocated_time);
    16b2:	fe043783          	ld	a5,-32(s0)
    16b6:	5fd8                	lw	a4,60(a5)
    16b8:	00001797          	auipc	a5,0x1
    16bc:	24078793          	addi	a5,a5,576 # 28f8 <threading_system_time>
    16c0:	4390                	lw	a2,0(a5)
    16c2:	00001797          	auipc	a5,0x1
    16c6:	23e78793          	addi	a5,a5,574 # 2900 <allocated_time>
    16ca:	639c                	ld	a5,0(a5)
    16cc:	86be                	mv	a3,a5
    16ce:	85ba                	mv	a1,a4
    16d0:	00001517          	auipc	a0,0x1
    16d4:	13050513          	addi	a0,a0,304 # 2800 <schedule_dm+0x39e>
    16d8:	fffff097          	auipc	ra,0xfffff
    16dc:	3ec080e7          	jalr	1004(ra) # ac4 <printf>

    if (current_thread->buf_set) {
    16e0:	fe043783          	ld	a5,-32(s0)
    16e4:	539c                	lw	a5,32(a5)
    16e6:	c7a1                	beqz	a5,172e <__dispatch+0xf2>
        thrdstop(allocated_time, &(current_thread->thrdstop_context_id), switch_handler, (void *)allocated_time);
    16e8:	00001797          	auipc	a5,0x1
    16ec:	21878793          	addi	a5,a5,536 # 2900 <allocated_time>
    16f0:	639c                	ld	a5,0(a5)
    16f2:	0007871b          	sext.w	a4,a5
    16f6:	fe043783          	ld	a5,-32(s0)
    16fa:	03878593          	addi	a1,a5,56
    16fe:	00001797          	auipc	a5,0x1
    1702:	20278793          	addi	a5,a5,514 # 2900 <allocated_time>
    1706:	639c                	ld	a5,0(a5)
    1708:	86be                	mv	a3,a5
    170a:	00000617          	auipc	a2,0x0
    170e:	dae60613          	addi	a2,a2,-594 # 14b8 <switch_handler>
    1712:	853a                	mv	a0,a4
    1714:	fffff097          	auipc	ra,0xfffff
    1718:	f0a080e7          	jalr	-246(ra) # 61e <thrdstop>
        thrdresume(current_thread->thrdstop_context_id);
    171c:	fe043783          	ld	a5,-32(s0)
    1720:	5f9c                	lw	a5,56(a5)
    1722:	853e                	mv	a0,a5
    1724:	fffff097          	auipc	ra,0xfffff
    1728:	f02080e7          	jalr	-254(ra) # 626 <thrdresume>
    172c:	a071                	j	17b8 <__dispatch+0x17c>
    } else {
        current_thread->buf_set = 1;
    172e:	fe043783          	ld	a5,-32(s0)
    1732:	4705                	li	a4,1
    1734:	d398                	sw	a4,32(a5)
        unsigned long new_stack_p = (unsigned long)current_thread->stack_p;
    1736:	fe043783          	ld	a5,-32(s0)
    173a:	6f9c                	ld	a5,24(a5)
    173c:	fcf43c23          	sd	a5,-40(s0)
        current_thread->thrdstop_context_id = -1;
    1740:	fe043783          	ld	a5,-32(s0)
    1744:	577d                	li	a4,-1
    1746:	df98                	sw	a4,56(a5)
        thrdstop(allocated_time, &(current_thread->thrdstop_context_id), switch_handler, (void *)allocated_time);
    1748:	00001797          	auipc	a5,0x1
    174c:	1b878793          	addi	a5,a5,440 # 2900 <allocated_time>
    1750:	639c                	ld	a5,0(a5)
    1752:	0007871b          	sext.w	a4,a5
    1756:	fe043783          	ld	a5,-32(s0)
    175a:	03878593          	addi	a1,a5,56
    175e:	00001797          	auipc	a5,0x1
    1762:	1a278793          	addi	a5,a5,418 # 2900 <allocated_time>
    1766:	639c                	ld	a5,0(a5)
    1768:	86be                	mv	a3,a5
    176a:	00000617          	auipc	a2,0x0
    176e:	d4e60613          	addi	a2,a2,-690 # 14b8 <switch_handler>
    1772:	853a                	mv	a0,a4
    1774:	fffff097          	auipc	ra,0xfffff
    1778:	eaa080e7          	jalr	-342(ra) # 61e <thrdstop>
        if (current_thread->thrdstop_context_id < 0) {
    177c:	fe043783          	ld	a5,-32(s0)
    1780:	5f9c                	lw	a5,56(a5)
    1782:	0207d063          	bgez	a5,17a2 <__dispatch+0x166>
            fprintf(2, "[ERROR] number of threads may exceed MAX_THRD_NUM\n");
    1786:	00001597          	auipc	a1,0x1
    178a:	0aa58593          	addi	a1,a1,170 # 2830 <schedule_dm+0x3ce>
    178e:	4509                	li	a0,2
    1790:	fffff097          	auipc	ra,0xfffff
    1794:	2dc080e7          	jalr	732(ra) # a6c <fprintf>
            exit(1);
    1798:	4505                	li	a0,1
    179a:	fffff097          	auipc	ra,0xfffff
    179e:	de4080e7          	jalr	-540(ra) # 57e <exit>
        }

        // set sp to stack pointer of current thread.
        asm volatile("mv sp, %0"
    17a2:	fd843783          	ld	a5,-40(s0)
    17a6:	813e                	mv	sp,a5
                     :
                     : "r"(new_stack_p));
        current_thread->fp(current_thread->arg);
    17a8:	fe043783          	ld	a5,-32(s0)
    17ac:	6398                	ld	a4,0(a5)
    17ae:	fe043783          	ld	a5,-32(s0)
    17b2:	679c                	ld	a5,8(a5)
    17b4:	853e                	mv	a0,a5
    17b6:	9702                	jalr	a4
    }
    thread_exit();
    17b8:	00000097          	auipc	ra,0x0
    17bc:	ad0080e7          	jalr	-1328(ra) # 1288 <thread_exit>
    17c0:	a011                	j	17c4 <__dispatch+0x188>
        return;
    17c2:	0001                	nop
}
    17c4:	70a2                	ld	ra,40(sp)
    17c6:	7402                	ld	s0,32(sp)
    17c8:	6145                	addi	sp,sp,48
    17ca:	8082                	ret

00000000000017cc <__schedule>:

void __schedule()
{
    17cc:	711d                	addi	sp,sp,-96
    17ce:	ec86                	sd	ra,88(sp)
    17d0:	e8a2                	sd	s0,80(sp)
    17d2:	1080                	addi	s0,sp,96
    struct threads_sched_args args = {
    17d4:	00001797          	auipc	a5,0x1
    17d8:	12478793          	addi	a5,a5,292 # 28f8 <threading_system_time>
    17dc:	439c                	lw	a5,0(a5)
    17de:	fcf42c23          	sw	a5,-40(s0)
    17e2:	4789                	li	a5,2
    17e4:	fcf42e23          	sw	a5,-36(s0)
    17e8:	00001797          	auipc	a5,0x1
    17ec:	0c078793          	addi	a5,a5,192 # 28a8 <run_queue>
    17f0:	fef43023          	sd	a5,-32(s0)
    17f4:	00001797          	auipc	a5,0x1
    17f8:	0c478793          	addi	a5,a5,196 # 28b8 <release_queue>
    17fc:	fef43423          	sd	a5,-24(s0)
#ifdef THREAD_SCHEDULER_LST
    r = schedule_lst(args);
#endif

#ifdef THREAD_SCHEDULER_DM
    r = schedule_dm(args);
    1800:	fd843783          	ld	a5,-40(s0)
    1804:	faf43023          	sd	a5,-96(s0)
    1808:	fe043783          	ld	a5,-32(s0)
    180c:	faf43423          	sd	a5,-88(s0)
    1810:	fe843783          	ld	a5,-24(s0)
    1814:	faf43823          	sd	a5,-80(s0)
    1818:	fa040793          	addi	a5,s0,-96
    181c:	853e                	mv	a0,a5
    181e:	00001097          	auipc	ra,0x1
    1822:	c44080e7          	jalr	-956(ra) # 2462 <schedule_dm>
    1826:	872a                	mv	a4,a0
    1828:	87ae                	mv	a5,a1
    182a:	fce43423          	sd	a4,-56(s0)
    182e:	fcf43823          	sd	a5,-48(s0)
#endif

    current = r.scheduled_thread_list_member;
    1832:	fc843703          	ld	a4,-56(s0)
    1836:	00001797          	auipc	a5,0x1
    183a:	0ba78793          	addi	a5,a5,186 # 28f0 <current>
    183e:	e398                	sd	a4,0(a5)
    allocated_time = r.allocated_time;
    1840:	fd042783          	lw	a5,-48(s0)
    1844:	873e                	mv	a4,a5
    1846:	00001797          	auipc	a5,0x1
    184a:	0ba78793          	addi	a5,a5,186 # 2900 <allocated_time>
    184e:	e398                	sd	a4,0(a5)
}
    1850:	0001                	nop
    1852:	60e6                	ld	ra,88(sp)
    1854:	6446                	ld	s0,80(sp)
    1856:	6125                	addi	sp,sp,96
    1858:	8082                	ret

000000000000185a <back_to_main_handler>:

void back_to_main_handler(void *arg)
{
    185a:	1101                	addi	sp,sp,-32
    185c:	ec06                	sd	ra,24(sp)
    185e:	e822                	sd	s0,16(sp)
    1860:	1000                	addi	s0,sp,32
    1862:	fea43423          	sd	a0,-24(s0)
    sleeping = 0;
    1866:	00001797          	auipc	a5,0x1
    186a:	09678793          	addi	a5,a5,150 # 28fc <sleeping>
    186e:	0007a023          	sw	zero,0(a5)
    threading_system_time += (uint64)arg;
    1872:	fe843783          	ld	a5,-24(s0)
    1876:	0007871b          	sext.w	a4,a5
    187a:	00001797          	auipc	a5,0x1
    187e:	07e78793          	addi	a5,a5,126 # 28f8 <threading_system_time>
    1882:	439c                	lw	a5,0(a5)
    1884:	2781                	sext.w	a5,a5
    1886:	9fb9                	addw	a5,a5,a4
    1888:	2781                	sext.w	a5,a5
    188a:	0007871b          	sext.w	a4,a5
    188e:	00001797          	auipc	a5,0x1
    1892:	06a78793          	addi	a5,a5,106 # 28f8 <threading_system_time>
    1896:	c398                	sw	a4,0(a5)
    thrdresume(main_thrd_id);
    1898:	00001797          	auipc	a5,0x1
    189c:	03078793          	addi	a5,a5,48 # 28c8 <main_thrd_id>
    18a0:	439c                	lw	a5,0(a5)
    18a2:	853e                	mv	a0,a5
    18a4:	fffff097          	auipc	ra,0xfffff
    18a8:	d82080e7          	jalr	-638(ra) # 626 <thrdresume>
}
    18ac:	0001                	nop
    18ae:	60e2                	ld	ra,24(sp)
    18b0:	6442                	ld	s0,16(sp)
    18b2:	6105                	addi	sp,sp,32
    18b4:	8082                	ret

00000000000018b6 <thread_start_threading>:

void thread_start_threading()
{
    18b6:	1141                	addi	sp,sp,-16
    18b8:	e406                	sd	ra,8(sp)
    18ba:	e022                	sd	s0,0(sp)
    18bc:	0800                	addi	s0,sp,16
    threading_system_time = 0;
    18be:	00001797          	auipc	a5,0x1
    18c2:	03a78793          	addi	a5,a5,58 # 28f8 <threading_system_time>
    18c6:	0007a023          	sw	zero,0(a5)
    current = &run_queue;
    18ca:	00001797          	auipc	a5,0x1
    18ce:	02678793          	addi	a5,a5,38 # 28f0 <current>
    18d2:	00001717          	auipc	a4,0x1
    18d6:	fd670713          	addi	a4,a4,-42 # 28a8 <run_queue>
    18da:	e398                	sd	a4,0(a5)

    // call thrdstop just for obtain an ID
    thrdstop(1000, &main_thrd_id, back_to_main_handler, (void *)0);
    18dc:	4681                	li	a3,0
    18de:	00000617          	auipc	a2,0x0
    18e2:	f7c60613          	addi	a2,a2,-132 # 185a <back_to_main_handler>
    18e6:	00001597          	auipc	a1,0x1
    18ea:	fe258593          	addi	a1,a1,-30 # 28c8 <main_thrd_id>
    18ee:	3e800513          	li	a0,1000
    18f2:	fffff097          	auipc	ra,0xfffff
    18f6:	d2c080e7          	jalr	-724(ra) # 61e <thrdstop>
    cancelthrdstop(main_thrd_id, 0);
    18fa:	00001797          	auipc	a5,0x1
    18fe:	fce78793          	addi	a5,a5,-50 # 28c8 <main_thrd_id>
    1902:	439c                	lw	a5,0(a5)
    1904:	4581                	li	a1,0
    1906:	853e                	mv	a0,a5
    1908:	fffff097          	auipc	ra,0xfffff
    190c:	d26080e7          	jalr	-730(ra) # 62e <cancelthrdstop>

    while (!list_empty(&run_queue) || !list_empty(&release_queue)) {
    1910:	a0c9                	j	19d2 <thread_start_threading+0x11c>
        __release();
    1912:	00000097          	auipc	ra,0x0
    1916:	816080e7          	jalr	-2026(ra) # 1128 <__release>
        __schedule();
    191a:	00000097          	auipc	ra,0x0
    191e:	eb2080e7          	jalr	-334(ra) # 17cc <__schedule>
        cancelthrdstop(main_thrd_id, 0);
    1922:	00001797          	auipc	a5,0x1
    1926:	fa678793          	addi	a5,a5,-90 # 28c8 <main_thrd_id>
    192a:	439c                	lw	a5,0(a5)
    192c:	4581                	li	a1,0
    192e:	853e                	mv	a0,a5
    1930:	fffff097          	auipc	ra,0xfffff
    1934:	cfe080e7          	jalr	-770(ra) # 62e <cancelthrdstop>
        __dispatch();
    1938:	00000097          	auipc	ra,0x0
    193c:	d04080e7          	jalr	-764(ra) # 163c <__dispatch>

        if (list_empty(&run_queue) && list_empty(&release_queue)) {
    1940:	00001517          	auipc	a0,0x1
    1944:	f6850513          	addi	a0,a0,-152 # 28a8 <run_queue>
    1948:	fffff097          	auipc	ra,0xfffff
    194c:	60a080e7          	jalr	1546(ra) # f52 <list_empty>
    1950:	87aa                	mv	a5,a0
    1952:	cb99                	beqz	a5,1968 <thread_start_threading+0xb2>
    1954:	00001517          	auipc	a0,0x1
    1958:	f6450513          	addi	a0,a0,-156 # 28b8 <release_queue>
    195c:	fffff097          	auipc	ra,0xfffff
    1960:	5f6080e7          	jalr	1526(ra) # f52 <list_empty>
    1964:	87aa                	mv	a5,a0
    1966:	ebd9                	bnez	a5,19fc <thread_start_threading+0x146>
            break;
        }

        // no thread in run_queue, release_queue not empty
        printf("run_queue is empty, sleep for %d ticks\n", allocated_time);
    1968:	00001797          	auipc	a5,0x1
    196c:	f9878793          	addi	a5,a5,-104 # 2900 <allocated_time>
    1970:	639c                	ld	a5,0(a5)
    1972:	85be                	mv	a1,a5
    1974:	00001517          	auipc	a0,0x1
    1978:	ef450513          	addi	a0,a0,-268 # 2868 <schedule_dm+0x406>
    197c:	fffff097          	auipc	ra,0xfffff
    1980:	148080e7          	jalr	328(ra) # ac4 <printf>
        sleeping = 1;
    1984:	00001797          	auipc	a5,0x1
    1988:	f7878793          	addi	a5,a5,-136 # 28fc <sleeping>
    198c:	4705                	li	a4,1
    198e:	c398                	sw	a4,0(a5)
        thrdstop(allocated_time, &main_thrd_id, back_to_main_handler, (void *)allocated_time);
    1990:	00001797          	auipc	a5,0x1
    1994:	f7078793          	addi	a5,a5,-144 # 2900 <allocated_time>
    1998:	639c                	ld	a5,0(a5)
    199a:	0007871b          	sext.w	a4,a5
    199e:	00001797          	auipc	a5,0x1
    19a2:	f6278793          	addi	a5,a5,-158 # 2900 <allocated_time>
    19a6:	639c                	ld	a5,0(a5)
    19a8:	86be                	mv	a3,a5
    19aa:	00000617          	auipc	a2,0x0
    19ae:	eb060613          	addi	a2,a2,-336 # 185a <back_to_main_handler>
    19b2:	00001597          	auipc	a1,0x1
    19b6:	f1658593          	addi	a1,a1,-234 # 28c8 <main_thrd_id>
    19ba:	853a                	mv	a0,a4
    19bc:	fffff097          	auipc	ra,0xfffff
    19c0:	c62080e7          	jalr	-926(ra) # 61e <thrdstop>
        while (sleeping) {
    19c4:	0001                	nop
    19c6:	00001797          	auipc	a5,0x1
    19ca:	f3678793          	addi	a5,a5,-202 # 28fc <sleeping>
    19ce:	439c                	lw	a5,0(a5)
    19d0:	fbfd                	bnez	a5,19c6 <thread_start_threading+0x110>
    while (!list_empty(&run_queue) || !list_empty(&release_queue)) {
    19d2:	00001517          	auipc	a0,0x1
    19d6:	ed650513          	addi	a0,a0,-298 # 28a8 <run_queue>
    19da:	fffff097          	auipc	ra,0xfffff
    19de:	578080e7          	jalr	1400(ra) # f52 <list_empty>
    19e2:	87aa                	mv	a5,a0
    19e4:	d79d                	beqz	a5,1912 <thread_start_threading+0x5c>
    19e6:	00001517          	auipc	a0,0x1
    19ea:	ed250513          	addi	a0,a0,-302 # 28b8 <release_queue>
    19ee:	fffff097          	auipc	ra,0xfffff
    19f2:	564080e7          	jalr	1380(ra) # f52 <list_empty>
    19f6:	87aa                	mv	a5,a0
    19f8:	df89                	beqz	a5,1912 <thread_start_threading+0x5c>
            // zzz...
        }
    }
}
    19fa:	a011                	j	19fe <thread_start_threading+0x148>
            break;
    19fc:	0001                	nop
}
    19fe:	0001                	nop
    1a00:	60a2                	ld	ra,8(sp)
    1a02:	6402                	ld	s0,0(sp)
    1a04:	0141                	addi	sp,sp,16
    1a06:	8082                	ret

0000000000001a08 <schedule_default>:
#define INT_MAX 2147483647
#define TIME_QUANTUM 2  // Define a base time quantum for the round-robin

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
    1a08:	715d                	addi	sp,sp,-80
    1a0a:	e4a2                	sd	s0,72(sp)
    1a0c:	e0a6                	sd	s1,64(sp)
    1a0e:	0880                	addi	s0,sp,80
    1a10:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
    1a12:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
    1a16:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
    1a1a:	649c                	ld	a5,8(s1)
    1a1c:	639c                	ld	a5,0(a5)
    1a1e:	fcf43c23          	sd	a5,-40(s0)
    1a22:	fd843783          	ld	a5,-40(s0)
    1a26:	fd878793          	addi	a5,a5,-40
    1a2a:	fef43023          	sd	a5,-32(s0)
    1a2e:	a81d                	j	1a64 <schedule_default+0x5c>
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
    1a30:	fe843783          	ld	a5,-24(s0)
    1a34:	cb89                	beqz	a5,1a46 <schedule_default+0x3e>
    1a36:	fe043783          	ld	a5,-32(s0)
    1a3a:	5fd8                	lw	a4,60(a5)
    1a3c:	fe843783          	ld	a5,-24(s0)
    1a40:	5fdc                	lw	a5,60(a5)
    1a42:	00f75663          	bge	a4,a5,1a4e <schedule_default+0x46>
            thread_with_smallest_id = th;
    1a46:	fe043783          	ld	a5,-32(s0)
    1a4a:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
    1a4e:	fe043783          	ld	a5,-32(s0)
    1a52:	779c                	ld	a5,40(a5)
    1a54:	fcf43823          	sd	a5,-48(s0)
    1a58:	fd043783          	ld	a5,-48(s0)
    1a5c:	fd878793          	addi	a5,a5,-40
    1a60:	fef43023          	sd	a5,-32(s0)
    1a64:	fe043783          	ld	a5,-32(s0)
    1a68:	02878713          	addi	a4,a5,40
    1a6c:	649c                	ld	a5,8(s1)
    1a6e:	fcf711e3          	bne	a4,a5,1a30 <schedule_default+0x28>
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
    1a72:	fe843783          	ld	a5,-24(s0)
    1a76:	cf89                	beqz	a5,1a90 <schedule_default+0x88>
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
    1a78:	fe843783          	ld	a5,-24(s0)
    1a7c:	02878793          	addi	a5,a5,40
    1a80:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
    1a84:	fe843783          	ld	a5,-24(s0)
    1a88:	4fbc                	lw	a5,88(a5)
    1a8a:	faf42c23          	sw	a5,-72(s0)
    1a8e:	a039                	j	1a9c <schedule_default+0x94>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
    1a90:	649c                	ld	a5,8(s1)
    1a92:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
    1a96:	4785                	li	a5,1
    1a98:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
    1a9c:	fb043783          	ld	a5,-80(s0)
    1aa0:	fcf43023          	sd	a5,-64(s0)
    1aa4:	fb843783          	ld	a5,-72(s0)
    1aa8:	fcf43423          	sd	a5,-56(s0)
    1aac:	4701                	li	a4,0
    1aae:	fc043703          	ld	a4,-64(s0)
    1ab2:	4781                	li	a5,0
    1ab4:	fc843783          	ld	a5,-56(s0)
    1ab8:	863a                	mv	a2,a4
    1aba:	86be                	mv	a3,a5
    1abc:	8732                	mv	a4,a2
    1abe:	87b6                	mv	a5,a3
}
    1ac0:	853a                	mv	a0,a4
    1ac2:	85be                	mv	a1,a5
    1ac4:	6426                	ld	s0,72(sp)
    1ac6:	6486                	ld	s1,64(sp)
    1ac8:	6161                	addi	sp,sp,80
    1aca:	8082                	ret

0000000000001acc <find_next_release_time>:

int find_next_release_time(struct list_head *release_queue, int current_time) {
    1acc:	7139                	addi	sp,sp,-64
    1ace:	fc22                	sd	s0,56(sp)
    1ad0:	0080                	addi	s0,sp,64
    1ad2:	fca43423          	sd	a0,-56(s0)
    1ad6:	87ae                	mv	a5,a1
    1ad8:	fcf42223          	sw	a5,-60(s0)
    struct release_queue_entry *next_release = NULL;
    1adc:	fe043423          	sd	zero,-24(s0)
    int next_release_time = INT_MAX;
    1ae0:	800007b7          	lui	a5,0x80000
    1ae4:	fff7c793          	not	a5,a5
    1ae8:	fef42223          	sw	a5,-28(s0)

    list_for_each_entry(next_release, release_queue, thread_list) {
    1aec:	fc843783          	ld	a5,-56(s0)
    1af0:	639c                	ld	a5,0(a5)
    1af2:	fcf43c23          	sd	a5,-40(s0)
    1af6:	fd843783          	ld	a5,-40(s0)
    1afa:	17e1                	addi	a5,a5,-8
    1afc:	fef43423          	sd	a5,-24(s0)
    1b00:	a081                	j	1b40 <find_next_release_time+0x74>
        if (next_release->release_time > current_time && next_release->release_time < next_release_time) {
    1b02:	fe843783          	ld	a5,-24(s0)
    1b06:	4f98                	lw	a4,24(a5)
    1b08:	fc442783          	lw	a5,-60(s0)
    1b0c:	2781                	sext.w	a5,a5
    1b0e:	00e7df63          	bge	a5,a4,1b2c <find_next_release_time+0x60>
    1b12:	fe843783          	ld	a5,-24(s0)
    1b16:	4f98                	lw	a4,24(a5)
    1b18:	fe442783          	lw	a5,-28(s0)
    1b1c:	2781                	sext.w	a5,a5
    1b1e:	00f75763          	bge	a4,a5,1b2c <find_next_release_time+0x60>
            next_release_time = next_release->release_time;
    1b22:	fe843783          	ld	a5,-24(s0)
    1b26:	4f9c                	lw	a5,24(a5)
    1b28:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(next_release, release_queue, thread_list) {
    1b2c:	fe843783          	ld	a5,-24(s0)
    1b30:	679c                	ld	a5,8(a5)
    1b32:	fcf43823          	sd	a5,-48(s0)
    1b36:	fd043783          	ld	a5,-48(s0)
    1b3a:	17e1                	addi	a5,a5,-8
    1b3c:	fef43423          	sd	a5,-24(s0)
    1b40:	fe843783          	ld	a5,-24(s0)
    1b44:	07a1                	addi	a5,a5,8
    1b46:	fc843703          	ld	a4,-56(s0)
    1b4a:	faf71ce3          	bne	a4,a5,1b02 <find_next_release_time+0x36>
        }
    }

    if (next_release_time == INT_MAX)
    1b4e:	fe442783          	lw	a5,-28(s0)
    1b52:	0007871b          	sext.w	a4,a5
    1b56:	800007b7          	lui	a5,0x80000
    1b5a:	fff7c793          	not	a5,a5
    1b5e:	00f71463          	bne	a4,a5,1b66 <find_next_release_time+0x9a>
        return -1; // No threads in the release queue
    1b62:	57fd                	li	a5,-1
    1b64:	a801                	j	1b74 <find_next_release_time+0xa8>

    return next_release_time - current_time;
    1b66:	fe442703          	lw	a4,-28(s0)
    1b6a:	fc442783          	lw	a5,-60(s0)
    1b6e:	40f707bb          	subw	a5,a4,a5
    1b72:	2781                	sext.w	a5,a5
}
    1b74:	853e                	mv	a0,a5
    1b76:	7462                	ld	s0,56(sp)
    1b78:	6121                	addi	sp,sp,64
    1b7a:	8082                	ret

0000000000001b7c <schedule_wrr>:

/* MP3 Part 1 - Non-Real-Time Scheduling */
/* Weighted-Round-Robin Scheduling */
struct threads_sched_result schedule_wrr(struct threads_sched_args args)
{
    1b7c:	7119                	addi	sp,sp,-128
    1b7e:	fc86                	sd	ra,120(sp)
    1b80:	f8a2                	sd	s0,112(sp)
    1b82:	f4a6                	sd	s1,104(sp)
    1b84:	f0ca                	sd	s2,96(sp)
    1b86:	ecce                	sd	s3,88(sp)
    1b88:	0100                	addi	s0,sp,128
    1b8a:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the weighted round-robin scheduling algorithm
    static struct thread *last_thread = NULL;
    struct thread *selected_thread = NULL;
    1b8c:	fc043423          	sd	zero,-56(s0)
    struct thread *candidate = NULL;
    1b90:	fc043023          	sd	zero,-64(s0)

    // If last_thread is NULL or its remaining time is zero, reset the selection process
    if (last_thread == NULL || last_thread->remaining_time <= 0) {
    1b94:	00001797          	auipc	a5,0x1
    1b98:	d7478793          	addi	a5,a5,-652 # 2908 <last_thread.1239>
    1b9c:	639c                	ld	a5,0(a5)
    1b9e:	cb89                	beqz	a5,1bb0 <schedule_wrr+0x34>
    1ba0:	00001797          	auipc	a5,0x1
    1ba4:	d6878793          	addi	a5,a5,-664 # 2908 <last_thread.1239>
    1ba8:	639c                	ld	a5,0(a5)
    1baa:	4fbc                	lw	a5,88(a5)
    1bac:	00f04863          	bgtz	a5,1bbc <schedule_wrr+0x40>
        last_thread = NULL;
    1bb0:	00001797          	auipc	a5,0x1
    1bb4:	d5878793          	addi	a5,a5,-680 # 2908 <last_thread.1239>
    1bb8:	0007b023          	sd	zero,0(a5)
    }

    // Find the first thread that is ready to run
    list_for_each_entry(candidate, args.run_queue, thread_list) {
    1bbc:	649c                	ld	a5,8(s1)
    1bbe:	639c                	ld	a5,0(a5)
    1bc0:	faf43823          	sd	a5,-80(s0)
    1bc4:	fb043783          	ld	a5,-80(s0)
    1bc8:	fd878793          	addi	a5,a5,-40
    1bcc:	fcf43023          	sd	a5,-64(s0)
    1bd0:	a0a9                	j	1c1a <schedule_wrr+0x9e>
        if (!last_thread && candidate->remaining_time > 0)
    1bd2:	00001797          	auipc	a5,0x1
    1bd6:	d3678793          	addi	a5,a5,-714 # 2908 <last_thread.1239>
    1bda:	639c                	ld	a5,0(a5)
    1bdc:	eb91                	bnez	a5,1bf0 <schedule_wrr+0x74>
    1bde:	fc043783          	ld	a5,-64(s0)
    1be2:	4fbc                	lw	a5,88(a5)
    1be4:	00f05663          	blez	a5,1bf0 <schedule_wrr+0x74>
            selected_thread = candidate;
    1be8:	fc043783          	ld	a5,-64(s0)
    1bec:	fcf43423          	sd	a5,-56(s0)
        if (candidate->remaining_time > 0) {
    1bf0:	fc043783          	ld	a5,-64(s0)
    1bf4:	4fbc                	lw	a5,88(a5)
    1bf6:	00f05763          	blez	a5,1c04 <schedule_wrr+0x88>
            selected_thread = candidate;
    1bfa:	fc043783          	ld	a5,-64(s0)
    1bfe:	fcf43423          	sd	a5,-56(s0)
            break;
    1c02:	a01d                	j	1c28 <schedule_wrr+0xac>
    list_for_each_entry(candidate, args.run_queue, thread_list) {
    1c04:	fc043783          	ld	a5,-64(s0)
    1c08:	779c                	ld	a5,40(a5)
    1c0a:	faf43423          	sd	a5,-88(s0)
    1c0e:	fa843783          	ld	a5,-88(s0)
    1c12:	fd878793          	addi	a5,a5,-40
    1c16:	fcf43023          	sd	a5,-64(s0)
    1c1a:	fc043783          	ld	a5,-64(s0)
    1c1e:	02878713          	addi	a4,a5,40
    1c22:	649c                	ld	a5,8(s1)
    1c24:	faf717e3          	bne	a4,a5,1bd2 <schedule_wrr+0x56>
        }
    }

    // Fall back to the last_thread if no other thread is selected and it still has remaining time
    if (!selected_thread && last_thread && last_thread->remaining_time > 0) {
    1c28:	fc843783          	ld	a5,-56(s0)
    1c2c:	e795                	bnez	a5,1c58 <schedule_wrr+0xdc>
    1c2e:	00001797          	auipc	a5,0x1
    1c32:	cda78793          	addi	a5,a5,-806 # 2908 <last_thread.1239>
    1c36:	639c                	ld	a5,0(a5)
    1c38:	c385                	beqz	a5,1c58 <schedule_wrr+0xdc>
    1c3a:	00001797          	auipc	a5,0x1
    1c3e:	cce78793          	addi	a5,a5,-818 # 2908 <last_thread.1239>
    1c42:	639c                	ld	a5,0(a5)
    1c44:	4fbc                	lw	a5,88(a5)
    1c46:	00f05963          	blez	a5,1c58 <schedule_wrr+0xdc>
        selected_thread = last_thread;
    1c4a:	00001797          	auipc	a5,0x1
    1c4e:	cbe78793          	addi	a5,a5,-834 # 2908 <last_thread.1239>
    1c52:	639c                	ld	a5,0(a5)
    1c54:	fcf43423          	sd	a5,-56(s0)
    }

    // Set the scheduling result
    if (selected_thread) {
    1c58:	fc843783          	ld	a5,-56(s0)
    1c5c:	c7b9                	beqz	a5,1caa <schedule_wrr+0x12e>
        int time_slice = selected_thread->weight * TIME_QUANTUM;
    1c5e:	fc843783          	ld	a5,-56(s0)
    1c62:	47bc                	lw	a5,72(a5)
    1c64:	0017979b          	slliw	a5,a5,0x1
    1c68:	faf42e23          	sw	a5,-68(s0)
        if (time_slice > selected_thread->remaining_time) {
    1c6c:	fc843783          	ld	a5,-56(s0)
    1c70:	4fb8                	lw	a4,88(a5)
    1c72:	fbc42783          	lw	a5,-68(s0)
    1c76:	2781                	sext.w	a5,a5
    1c78:	00f75763          	bge	a4,a5,1c86 <schedule_wrr+0x10a>
            time_slice = selected_thread->remaining_time;
    1c7c:	fc843783          	ld	a5,-56(s0)
    1c80:	4fbc                	lw	a5,88(a5)
    1c82:	faf42e23          	sw	a5,-68(s0)
        }
        r.scheduled_thread_list_member = &selected_thread->thread_list;
    1c86:	fc843783          	ld	a5,-56(s0)
    1c8a:	02878793          	addi	a5,a5,40
    1c8e:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = time_slice;
    1c92:	fbc42783          	lw	a5,-68(s0)
    1c96:	f8f42823          	sw	a5,-112(s0)
        last_thread = selected_thread;  // Update the last run thread
    1c9a:	00001797          	auipc	a5,0x1
    1c9e:	c6e78793          	addi	a5,a5,-914 # 2908 <last_thread.1239>
    1ca2:	fc843703          	ld	a4,-56(s0)
    1ca6:	e398                	sd	a4,0(a5)
    1ca8:	a839                	j	1cc6 <schedule_wrr+0x14a>
    } else {
        // Idle if no suitable thread is found
        r.scheduled_thread_list_member = args.run_queue;
    1caa:	649c                	ld	a5,8(s1)
    1cac:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    1cb0:	689c                	ld	a5,16(s1)
    1cb2:	4098                	lw	a4,0(s1)
    1cb4:	85ba                	mv	a1,a4
    1cb6:	853e                	mv	a0,a5
    1cb8:	00000097          	auipc	ra,0x0
    1cbc:	e14080e7          	jalr	-492(ra) # 1acc <find_next_release_time>
    1cc0:	87aa                	mv	a5,a0
    1cc2:	f8f42823          	sw	a5,-112(s0)
    }

    return r;
    1cc6:	f8843783          	ld	a5,-120(s0)
    1cca:	f8f43c23          	sd	a5,-104(s0)
    1cce:	f9043783          	ld	a5,-112(s0)
    1cd2:	faf43023          	sd	a5,-96(s0)
    1cd6:	4701                	li	a4,0
    1cd8:	f9843703          	ld	a4,-104(s0)
    1cdc:	4781                	li	a5,0
    1cde:	fa043783          	ld	a5,-96(s0)
    1ce2:	893a                	mv	s2,a4
    1ce4:	89be                	mv	s3,a5
    1ce6:	874a                	mv	a4,s2
    1ce8:	87ce                	mv	a5,s3
}
    1cea:	853a                	mv	a0,a4
    1cec:	85be                	mv	a1,a5
    1cee:	70e6                	ld	ra,120(sp)
    1cf0:	7446                	ld	s0,112(sp)
    1cf2:	74a6                	ld	s1,104(sp)
    1cf4:	7906                	ld	s2,96(sp)
    1cf6:	69e6                	ld	s3,88(sp)
    1cf8:	6109                	addi	sp,sp,128
    1cfa:	8082                	ret

0000000000001cfc <find_earliest_impactful_release_time>:


int find_earliest_impactful_release_time(struct list_head *release_queue, struct list_head *run_queue, int current_time) {
    1cfc:	7159                	addi	sp,sp,-112
    1cfe:	f4a2                	sd	s0,104(sp)
    1d00:	1880                	addi	s0,sp,112
    1d02:	faa43423          	sd	a0,-88(s0)
    1d06:	fab43023          	sd	a1,-96(s0)
    1d0a:	87b2                	mv	a5,a2
    1d0c:	f8f42e23          	sw	a5,-100(s0)
    struct release_queue_entry *entry;
    int earliest_impactful_time = INT_MAX;
    1d10:	800007b7          	lui	a5,0x80000
    1d14:	fff7c793          	not	a5,a5
    1d18:	fef42223          	sw	a5,-28(s0)
    int shortest_current_time = INT_MAX;
    1d1c:	800007b7          	lui	a5,0x80000
    1d20:	fff7c793          	not	a5,a5
    1d24:	fef42023          	sw	a5,-32(s0)
    // Find the shortest remaining time among currently running tasks
    struct thread *t;
    list_for_each_entry(t, run_queue, thread_list) {
    1d28:	fa043783          	ld	a5,-96(s0)
    1d2c:	639c                	ld	a5,0(a5)
    1d2e:	fcf43823          	sd	a5,-48(s0)
    1d32:	fd043783          	ld	a5,-48(s0)
    1d36:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffcf48>
    1d3a:	fcf43c23          	sd	a5,-40(s0)
    1d3e:	a80d                	j	1d70 <find_earliest_impactful_release_time+0x74>
        if (t->remaining_time < shortest_current_time) {
    1d40:	fd843783          	ld	a5,-40(s0)
    1d44:	4fb8                	lw	a4,88(a5)
    1d46:	fe042783          	lw	a5,-32(s0)
    1d4a:	2781                	sext.w	a5,a5
    1d4c:	00f75763          	bge	a4,a5,1d5a <find_earliest_impactful_release_time+0x5e>
            shortest_current_time = t->remaining_time;
    1d50:	fd843783          	ld	a5,-40(s0)
    1d54:	4fbc                	lw	a5,88(a5)
    1d56:	fef42023          	sw	a5,-32(s0)
    list_for_each_entry(t, run_queue, thread_list) {
    1d5a:	fd843783          	ld	a5,-40(s0)
    1d5e:	779c                	ld	a5,40(a5)
    1d60:	faf43c23          	sd	a5,-72(s0)
    1d64:	fb843783          	ld	a5,-72(s0)
    1d68:	fd878793          	addi	a5,a5,-40
    1d6c:	fcf43c23          	sd	a5,-40(s0)
    1d70:	fd843783          	ld	a5,-40(s0)
    1d74:	02878793          	addi	a5,a5,40
    1d78:	fa043703          	ld	a4,-96(s0)
    1d7c:	fcf712e3          	bne	a4,a5,1d40 <find_earliest_impactful_release_time+0x44>
        }
    }

    // Check the release queue for the next task that might preempt the current shortest job
    list_for_each_entry(entry, release_queue, thread_list) {
    1d80:	fa843783          	ld	a5,-88(s0)
    1d84:	639c                	ld	a5,0(a5)
    1d86:	fcf43423          	sd	a5,-56(s0)
    1d8a:	fc843783          	ld	a5,-56(s0)
    1d8e:	17e1                	addi	a5,a5,-8
    1d90:	fef43423          	sd	a5,-24(s0)
    1d94:	a889                	j	1de6 <find_earliest_impactful_release_time+0xea>
        if (entry->release_time > current_time && entry->release_time < earliest_impactful_time) {
    1d96:	fe843783          	ld	a5,-24(s0)
    1d9a:	4f98                	lw	a4,24(a5)
    1d9c:	f9c42783          	lw	a5,-100(s0)
    1da0:	2781                	sext.w	a5,a5
    1da2:	02e7d863          	bge	a5,a4,1dd2 <find_earliest_impactful_release_time+0xd6>
    1da6:	fe843783          	ld	a5,-24(s0)
    1daa:	4f98                	lw	a4,24(a5)
    1dac:	fe442783          	lw	a5,-28(s0)
    1db0:	2781                	sext.w	a5,a5
    1db2:	02f75063          	bge	a4,a5,1dd2 <find_earliest_impactful_release_time+0xd6>
            if (entry->thrd->remaining_time < shortest_current_time) {
    1db6:	fe843783          	ld	a5,-24(s0)
    1dba:	639c                	ld	a5,0(a5)
    1dbc:	4fb8                	lw	a4,88(a5)
    1dbe:	fe042783          	lw	a5,-32(s0)
    1dc2:	2781                	sext.w	a5,a5
    1dc4:	00f75763          	bge	a4,a5,1dd2 <find_earliest_impactful_release_time+0xd6>
                earliest_impactful_time = entry->release_time;
    1dc8:	fe843783          	ld	a5,-24(s0)
    1dcc:	4f9c                	lw	a5,24(a5)
    1dce:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(entry, release_queue, thread_list) {
    1dd2:	fe843783          	ld	a5,-24(s0)
    1dd6:	679c                	ld	a5,8(a5)
    1dd8:	fcf43023          	sd	a5,-64(s0)
    1ddc:	fc043783          	ld	a5,-64(s0)
    1de0:	17e1                	addi	a5,a5,-8
    1de2:	fef43423          	sd	a5,-24(s0)
    1de6:	fe843783          	ld	a5,-24(s0)
    1dea:	07a1                	addi	a5,a5,8
    1dec:	fa843703          	ld	a4,-88(s0)
    1df0:	faf713e3          	bne	a4,a5,1d96 <find_earliest_impactful_release_time+0x9a>
            }
        }
    }

    // Calculate the difference between the current time and the earliest impactful release time
    return earliest_impactful_time == INT_MAX ? -1 : earliest_impactful_time - current_time;
    1df4:	fe442783          	lw	a5,-28(s0)
    1df8:	0007871b          	sext.w	a4,a5
    1dfc:	800007b7          	lui	a5,0x80000
    1e00:	fff7c793          	not	a5,a5
    1e04:	00f70a63          	beq	a4,a5,1e18 <find_earliest_impactful_release_time+0x11c>
    1e08:	fe442703          	lw	a4,-28(s0)
    1e0c:	f9c42783          	lw	a5,-100(s0)
    1e10:	40f707bb          	subw	a5,a4,a5
    1e14:	2781                	sext.w	a5,a5
    1e16:	a011                	j	1e1a <find_earliest_impactful_release_time+0x11e>
    1e18:	57fd                	li	a5,-1
}
    1e1a:	853e                	mv	a0,a5
    1e1c:	7426                	ld	s0,104(sp)
    1e1e:	6165                	addi	sp,sp,112
    1e20:	8082                	ret

0000000000001e22 <schedule_sjf>:


struct threads_sched_result schedule_sjf(struct threads_sched_args args) {
    1e22:	7119                	addi	sp,sp,-128
    1e24:	fc86                	sd	ra,120(sp)
    1e26:	f8a2                	sd	s0,112(sp)
    1e28:	f4a6                	sd	s1,104(sp)
    1e2a:	f0ca                	sd	s2,96(sp)
    1e2c:	ecce                	sd	s3,88(sp)
    1e2e:	0100                	addi	s0,sp,128
    1e30:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *shortest_job = NULL;
    1e32:	fc043423          	sd	zero,-56(s0)
    struct thread *current;
    int shortest_time = INT_MAX;
    1e36:	800007b7          	lui	a5,0x80000
    1e3a:	fff7c793          	not	a5,a5
    1e3e:	faf42e23          	sw	a5,-68(s0)
    int earliest_impactful_time = find_earliest_impactful_release_time(args.release_queue, args.run_queue, args.current_time);
    1e42:	689c                	ld	a5,16(s1)
    1e44:	6498                	ld	a4,8(s1)
    1e46:	4094                	lw	a3,0(s1)
    1e48:	8636                	mv	a2,a3
    1e4a:	85ba                	mv	a1,a4
    1e4c:	853e                	mv	a0,a5
    1e4e:	00000097          	auipc	ra,0x0
    1e52:	eae080e7          	jalr	-338(ra) # 1cfc <find_earliest_impactful_release_time>
    1e56:	87aa                	mv	a5,a0
    1e58:	faf42a23          	sw	a5,-76(s0)

    // Determine the shortest job from the run queue
    list_for_each_entry(current, args.run_queue, thread_list) {
    1e5c:	649c                	ld	a5,8(s1)
    1e5e:	639c                	ld	a5,0(a5)
    1e60:	faf43423          	sd	a5,-88(s0)
    1e64:	fa843783          	ld	a5,-88(s0)
    1e68:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffcf48>
    1e6c:	fcf43023          	sd	a5,-64(s0)
    1e70:	a82d                	j	1eaa <schedule_sjf+0x88>
        if (current->remaining_time < shortest_time) {
    1e72:	fc043783          	ld	a5,-64(s0)
    1e76:	4fb8                	lw	a4,88(a5)
    1e78:	fbc42783          	lw	a5,-68(s0)
    1e7c:	2781                	sext.w	a5,a5
    1e7e:	00f75b63          	bge	a4,a5,1e94 <schedule_sjf+0x72>
            shortest_time = current->remaining_time;
    1e82:	fc043783          	ld	a5,-64(s0)
    1e86:	4fbc                	lw	a5,88(a5)
    1e88:	faf42e23          	sw	a5,-68(s0)
            shortest_job = current;
    1e8c:	fc043783          	ld	a5,-64(s0)
    1e90:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(current, args.run_queue, thread_list) {
    1e94:	fc043783          	ld	a5,-64(s0)
    1e98:	779c                	ld	a5,40(a5)
    1e9a:	faf43023          	sd	a5,-96(s0)
    1e9e:	fa043783          	ld	a5,-96(s0)
    1ea2:	fd878793          	addi	a5,a5,-40
    1ea6:	fcf43023          	sd	a5,-64(s0)
    1eaa:	fc043783          	ld	a5,-64(s0)
    1eae:	02878713          	addi	a4,a5,40
    1eb2:	649c                	ld	a5,8(s1)
    1eb4:	faf71fe3          	bne	a4,a5,1e72 <schedule_sjf+0x50>
        }
    }

    if (shortest_job) {
    1eb8:	fc843783          	ld	a5,-56(s0)
    1ebc:	c7a1                	beqz	a5,1f04 <schedule_sjf+0xe2>
        int time_to_allocate = shortest_job->remaining_time;
    1ebe:	fc843783          	ld	a5,-56(s0)
    1ec2:	4fbc                	lw	a5,88(a5)
    1ec4:	faf42c23          	sw	a5,-72(s0)
        // Reduce the time slice if an impactful task is arriving sooner
        if (earliest_impactful_time != -1 && earliest_impactful_time < time_to_allocate) {
    1ec8:	fb442783          	lw	a5,-76(s0)
    1ecc:	0007871b          	sext.w	a4,a5
    1ed0:	57fd                	li	a5,-1
    1ed2:	00f70e63          	beq	a4,a5,1eee <schedule_sjf+0xcc>
    1ed6:	fb442703          	lw	a4,-76(s0)
    1eda:	fb842783          	lw	a5,-72(s0)
    1ede:	2701                	sext.w	a4,a4
    1ee0:	2781                	sext.w	a5,a5
    1ee2:	00f75663          	bge	a4,a5,1eee <schedule_sjf+0xcc>
            time_to_allocate = earliest_impactful_time;
    1ee6:	fb442783          	lw	a5,-76(s0)
    1eea:	faf42c23          	sw	a5,-72(s0)
        }

        r.scheduled_thread_list_member = &shortest_job->thread_list;
    1eee:	fc843783          	ld	a5,-56(s0)
    1ef2:	02878793          	addi	a5,a5,40
    1ef6:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = time_to_allocate;
    1efa:	fb842783          	lw	a5,-72(s0)
    1efe:	f8f42423          	sw	a5,-120(s0)
    1f02:	a80d                	j	1f34 <schedule_sjf+0x112>
    } else {
        // If no current tasks are ready, wait for the next impactful task
        r.scheduled_thread_list_member = args.run_queue;
    1f04:	649c                	ld	a5,8(s1)
    1f06:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = earliest_impactful_time != -1 ? earliest_impactful_time : find_next_release_time(args.release_queue, args.current_time);
    1f0a:	fb442783          	lw	a5,-76(s0)
    1f0e:	0007871b          	sext.w	a4,a5
    1f12:	57fd                	li	a5,-1
    1f14:	00f71c63          	bne	a4,a5,1f2c <schedule_sjf+0x10a>
    1f18:	689c                	ld	a5,16(s1)
    1f1a:	4098                	lw	a4,0(s1)
    1f1c:	85ba                	mv	a1,a4
    1f1e:	853e                	mv	a0,a5
    1f20:	00000097          	auipc	ra,0x0
    1f24:	bac080e7          	jalr	-1108(ra) # 1acc <find_next_release_time>
    1f28:	87aa                	mv	a5,a0
    1f2a:	a019                	j	1f30 <schedule_sjf+0x10e>
    1f2c:	fb442783          	lw	a5,-76(s0)
    1f30:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    1f34:	f8043783          	ld	a5,-128(s0)
    1f38:	f8f43823          	sd	a5,-112(s0)
    1f3c:	f8843783          	ld	a5,-120(s0)
    1f40:	f8f43c23          	sd	a5,-104(s0)
    1f44:	4701                	li	a4,0
    1f46:	f9043703          	ld	a4,-112(s0)
    1f4a:	4781                	li	a5,0
    1f4c:	f9843783          	ld	a5,-104(s0)
    1f50:	893a                	mv	s2,a4
    1f52:	89be                	mv	s3,a5
    1f54:	874a                	mv	a4,s2
    1f56:	87ce                	mv	a5,s3
}
    1f58:	853a                	mv	a0,a4
    1f5a:	85be                	mv	a1,a5
    1f5c:	70e6                	ld	ra,120(sp)
    1f5e:	7446                	ld	s0,112(sp)
    1f60:	74a6                	ld	s1,104(sp)
    1f62:	7906                	ld	s2,96(sp)
    1f64:	69e6                	ld	s3,88(sp)
    1f66:	6109                	addi	sp,sp,128
    1f68:	8082                	ret

0000000000001f6a <min>:

int min(int a, int b) {
    1f6a:	1101                	addi	sp,sp,-32
    1f6c:	ec22                	sd	s0,24(sp)
    1f6e:	1000                	addi	s0,sp,32
    1f70:	87aa                	mv	a5,a0
    1f72:	872e                	mv	a4,a1
    1f74:	fef42623          	sw	a5,-20(s0)
    1f78:	87ba                	mv	a5,a4
    1f7a:	fef42423          	sw	a5,-24(s0)
    return (a < b) ? a : b;
    1f7e:	fec42603          	lw	a2,-20(s0)
    1f82:	fe842783          	lw	a5,-24(s0)
    1f86:	0007869b          	sext.w	a3,a5
    1f8a:	0006071b          	sext.w	a4,a2
    1f8e:	00d75363          	bge	a4,a3,1f94 <min+0x2a>
    1f92:	87b2                	mv	a5,a2
    1f94:	2781                	sext.w	a5,a5
}
    1f96:	853e                	mv	a0,a5
    1f98:	6462                	ld	s0,24(sp)
    1f9a:	6105                	addi	sp,sp,32
    1f9c:	8082                	ret

0000000000001f9e <schedule_lst>:

/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args) {
    1f9e:	7115                	addi	sp,sp,-224
    1fa0:	ed86                	sd	ra,216(sp)
    1fa2:	e9a2                	sd	s0,208(sp)
    1fa4:	e5a6                	sd	s1,200(sp)
    1fa6:	e1ca                	sd	s2,192(sp)
    1fa8:	fd4e                	sd	s3,184(sp)
    1faa:	1180                	addi	s0,sp,224
    1fac:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *min_slack_thread = NULL;
    1fae:	fc043423          	sd	zero,-56(s0)
    int min_slack_time = INT_MAX;
    1fb2:	800007b7          	lui	a5,0x80000
    1fb6:	fff7c793          	not	a5,a5
    1fba:	fcf42223          	sw	a5,-60(s0)
    struct thread *t;

    // Determine the thread with the minimum slack time
    list_for_each_entry(t, args.run_queue, thread_list) {
    1fbe:	649c                	ld	a5,8(s1)
    1fc0:	639c                	ld	a5,0(a5)
    1fc2:	f8f43823          	sd	a5,-112(s0)
    1fc6:	f9043783          	ld	a5,-112(s0)
    1fca:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffcf48>
    1fce:	faf43c23          	sd	a5,-72(s0)
    1fd2:	a069                	j	205c <schedule_lst+0xbe>
        int slack_time = t->current_deadline - args.current_time - t->remaining_time;
    1fd4:	fb843783          	ld	a5,-72(s0)
    1fd8:	4ff8                	lw	a4,92(a5)
    1fda:	409c                	lw	a5,0(s1)
    1fdc:	40f707bb          	subw	a5,a4,a5
    1fe0:	0007871b          	sext.w	a4,a5
    1fe4:	fb843783          	ld	a5,-72(s0)
    1fe8:	4fbc                	lw	a5,88(a5)
    1fea:	40f707bb          	subw	a5,a4,a5
    1fee:	f4f42a23          	sw	a5,-172(s0)
        if (slack_time < min_slack_time || (slack_time == min_slack_time && t->ID < (min_slack_thread ? min_slack_thread->ID : INT_MAX))) {
    1ff2:	f5442703          	lw	a4,-172(s0)
    1ff6:	fc442783          	lw	a5,-60(s0)
    1ffa:	2701                	sext.w	a4,a4
    1ffc:	2781                	sext.w	a5,a5
    1ffe:	02f74c63          	blt	a4,a5,2036 <schedule_lst+0x98>
    2002:	f5442703          	lw	a4,-172(s0)
    2006:	fc442783          	lw	a5,-60(s0)
    200a:	2701                	sext.w	a4,a4
    200c:	2781                	sext.w	a5,a5
    200e:	02f71c63          	bne	a4,a5,2046 <schedule_lst+0xa8>
    2012:	fb843783          	ld	a5,-72(s0)
    2016:	5fd4                	lw	a3,60(a5)
    2018:	fc843783          	ld	a5,-56(s0)
    201c:	c789                	beqz	a5,2026 <schedule_lst+0x88>
    201e:	fc843783          	ld	a5,-56(s0)
    2022:	5fdc                	lw	a5,60(a5)
    2024:	a029                	j	202e <schedule_lst+0x90>
    2026:	800007b7          	lui	a5,0x80000
    202a:	fff7c793          	not	a5,a5
    202e:	873e                	mv	a4,a5
    2030:	87b6                	mv	a5,a3
    2032:	00e7da63          	bge	a5,a4,2046 <schedule_lst+0xa8>
            min_slack_thread = t;
    2036:	fb843783          	ld	a5,-72(s0)
    203a:	fcf43423          	sd	a5,-56(s0)
            min_slack_time = slack_time;
    203e:	f5442783          	lw	a5,-172(s0)
    2042:	fcf42223          	sw	a5,-60(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    2046:	fb843783          	ld	a5,-72(s0)
    204a:	779c                	ld	a5,40(a5)
    204c:	f4f43423          	sd	a5,-184(s0)
    2050:	f4843783          	ld	a5,-184(s0)
    2054:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffcf48>
    2058:	faf43c23          	sd	a5,-72(s0)
    205c:	fb843783          	ld	a5,-72(s0)
    2060:	02878713          	addi	a4,a5,40
    2064:	649c                	ld	a5,8(s1)
    2066:	f6f717e3          	bne	a4,a5,1fd4 <schedule_lst+0x36>
        }
    }
    //printf("id %d, cur ddl %d, ddl,cur time %d, rem time %d, slack time %d\n", min_slack_thread->ID, min_slack_thread->current_deadline, args.current_time, min_slack_thread->remaining_time, min_slack_time);

    // Calculate the next event time, initially very large
    int next_significant_event_time = INT_MAX;
    206a:	800007b7          	lui	a5,0x80000
    206e:	fff7c793          	not	a5,a5
    2072:	faf42a23          	sw	a5,-76(s0)
    // Analyze each upcoming release to determine if and when they should preempt the current thread
    struct release_queue_entry *entry;
    list_for_each_entry(entry, args.release_queue, thread_list) {
    2076:	689c                	ld	a5,16(s1)
    2078:	639c                	ld	a5,0(a5)
    207a:	f8f43423          	sd	a5,-120(s0)
    207e:	f8843783          	ld	a5,-120(s0)
    2082:	17e1                	addi	a5,a5,-8
    2084:	faf43423          	sd	a5,-88(s0)
    2088:	a0f1                	j	2154 <schedule_lst+0x1b6>
        if (entry->release_time > args.current_time) {
    208a:	fa843783          	ld	a5,-88(s0)
    208e:	4f98                	lw	a4,24(a5)
    2090:	409c                	lw	a5,0(s1)
    2092:	0ae7d763          	bge	a5,a4,2140 <schedule_lst+0x1a2>
            struct thread *upcoming_thread = entry->thrd;
    2096:	fa843783          	ld	a5,-88(s0)
    209a:	639c                	ld	a5,0(a5)
    209c:	f6f43423          	sd	a5,-152(s0)

            //printf("upcoming_thread->ID: %d ddl: %d release_time: %d remaining_time: %d\n", upcoming_thread->ID, upcoming_thread->current_deadline, entry->release_time, upcoming_thread->remaining_time);
            int upcoming_slack_time = upcoming_thread->current_deadline - entry->release_time - upcoming_thread->processing_time;
    20a0:	f6843783          	ld	a5,-152(s0)
    20a4:	4ff8                	lw	a4,92(a5)
    20a6:	fa843783          	ld	a5,-88(s0)
    20aa:	4f9c                	lw	a5,24(a5)
    20ac:	40f707bb          	subw	a5,a4,a5
    20b0:	0007871b          	sext.w	a4,a5
    20b4:	f6843783          	ld	a5,-152(s0)
    20b8:	43fc                	lw	a5,68(a5)
    20ba:	40f707bb          	subw	a5,a4,a5
    20be:	f6f42223          	sw	a5,-156(s0)
            // Check if this upcoming thread will impose an earlier preemption due to tighter slack time
            if (upcoming_slack_time < min_slack_time) {
    20c2:	f6442703          	lw	a4,-156(s0)
    20c6:	fc442783          	lw	a5,-60(s0)
    20ca:	2701                	sext.w	a4,a4
    20cc:	2781                	sext.w	a5,a5
    20ce:	02f75163          	bge	a4,a5,20f0 <schedule_lst+0x152>
                next_significant_event_time = min(next_significant_event_time, entry->release_time);
    20d2:	fa843783          	ld	a5,-88(s0)
    20d6:	4f98                	lw	a4,24(a5)
    20d8:	fb442783          	lw	a5,-76(s0)
    20dc:	85ba                	mv	a1,a4
    20de:	853e                	mv	a0,a5
    20e0:	00000097          	auipc	ra,0x0
    20e4:	e8a080e7          	jalr	-374(ra) # 1f6a <min>
    20e8:	87aa                	mv	a5,a0
    20ea:	faf42a23          	sw	a5,-76(s0)
    20ee:	a889                	j	2140 <schedule_lst+0x1a2>
            } else if (upcoming_slack_time == min_slack_time && upcoming_thread->ID < (min_slack_thread ? min_slack_thread->ID : INT_MAX))
    20f0:	f6442703          	lw	a4,-156(s0)
    20f4:	fc442783          	lw	a5,-60(s0)
    20f8:	2701                	sext.w	a4,a4
    20fa:	2781                	sext.w	a5,a5
    20fc:	04f71263          	bne	a4,a5,2140 <schedule_lst+0x1a2>
    2100:	f6843783          	ld	a5,-152(s0)
    2104:	5fd4                	lw	a3,60(a5)
    2106:	fc843783          	ld	a5,-56(s0)
    210a:	c789                	beqz	a5,2114 <schedule_lst+0x176>
    210c:	fc843783          	ld	a5,-56(s0)
    2110:	5fdc                	lw	a5,60(a5)
    2112:	a029                	j	211c <schedule_lst+0x17e>
    2114:	800007b7          	lui	a5,0x80000
    2118:	fff7c793          	not	a5,a5
    211c:	873e                	mv	a4,a5
    211e:	87b6                	mv	a5,a3
    2120:	02e7d063          	bge	a5,a4,2140 <schedule_lst+0x1a2>
                next_significant_event_time = min(next_significant_event_time, entry->release_time);
    2124:	fa843783          	ld	a5,-88(s0)
    2128:	4f98                	lw	a4,24(a5)
    212a:	fb442783          	lw	a5,-76(s0)
    212e:	85ba                	mv	a1,a4
    2130:	853e                	mv	a0,a5
    2132:	00000097          	auipc	ra,0x0
    2136:	e38080e7          	jalr	-456(ra) # 1f6a <min>
    213a:	87aa                	mv	a5,a0
    213c:	faf42a23          	sw	a5,-76(s0)
    list_for_each_entry(entry, args.release_queue, thread_list) {
    2140:	fa843783          	ld	a5,-88(s0)
    2144:	679c                	ld	a5,8(a5)
    2146:	f4f43c23          	sd	a5,-168(s0)
    214a:	f5843783          	ld	a5,-168(s0)
    214e:	17e1                	addi	a5,a5,-8
    2150:	faf43423          	sd	a5,-88(s0)
    2154:	fa843783          	ld	a5,-88(s0)
    2158:	00878713          	addi	a4,a5,8 # ffffffff80000008 <__global_pointer$+0xffffffff7fffcf78>
    215c:	689c                	ld	a5,16(s1)
    215e:	f2f716e3          	bne	a4,a5,208a <schedule_lst+0xec>
        }
    }

    // Decide the allocated time based on current minimum slack or upcoming preemption needs
    if (min_slack_thread) {
    2162:	fc843783          	ld	a5,-56(s0)
    2166:	10078b63          	beqz	a5,227c <schedule_lst+0x2de>
        // Check if the thread has missed its deadline
        if (args.current_time >= min_slack_thread->current_deadline && min_slack_thread->remaining_time > 0) {
    216a:	4098                	lw	a4,0(s1)
    216c:	fc843783          	ld	a5,-56(s0)
    2170:	4ffc                	lw	a5,92(a5)
    2172:	08f74863          	blt	a4,a5,2202 <schedule_lst+0x264>
    2176:	fc843783          	ld	a5,-56(s0)
    217a:	4fbc                	lw	a5,88(a5)
    217c:	08f05363          	blez	a5,2202 <schedule_lst+0x264>
            struct thread *thread_with_smallest_id = min_slack_thread;
    2180:	fc843783          	ld	a5,-56(s0)
    2184:	faf43023          	sd	a5,-96(s0)
            // Iterate again to find if there are other threads that also missed their deadlines and have smaller IDs
            list_for_each_entry(t, args.run_queue, thread_list) {
    2188:	649c                	ld	a5,8(s1)
    218a:	639c                	ld	a5,0(a5)
    218c:	f8f43023          	sd	a5,-128(s0)
    2190:	f8043783          	ld	a5,-128(s0)
    2194:	fd878793          	addi	a5,a5,-40
    2198:	faf43c23          	sd	a5,-72(s0)
    219c:	a099                	j	21e2 <schedule_lst+0x244>
                if (args.current_time >= t->current_deadline && t->remaining_time > 0 && t->ID < thread_with_smallest_id->ID) {
    219e:	4098                	lw	a4,0(s1)
    21a0:	fb843783          	ld	a5,-72(s0)
    21a4:	4ffc                	lw	a5,92(a5)
    21a6:	02f74363          	blt	a4,a5,21cc <schedule_lst+0x22e>
    21aa:	fb843783          	ld	a5,-72(s0)
    21ae:	4fbc                	lw	a5,88(a5)
    21b0:	00f05e63          	blez	a5,21cc <schedule_lst+0x22e>
    21b4:	fb843783          	ld	a5,-72(s0)
    21b8:	5fd8                	lw	a4,60(a5)
    21ba:	fa043783          	ld	a5,-96(s0)
    21be:	5fdc                	lw	a5,60(a5)
    21c0:	00f75663          	bge	a4,a5,21cc <schedule_lst+0x22e>
                    thread_with_smallest_id = t;
    21c4:	fb843783          	ld	a5,-72(s0)
    21c8:	faf43023          	sd	a5,-96(s0)
            list_for_each_entry(t, args.run_queue, thread_list) {
    21cc:	fb843783          	ld	a5,-72(s0)
    21d0:	779c                	ld	a5,40(a5)
    21d2:	f6f43c23          	sd	a5,-136(s0)
    21d6:	f7843783          	ld	a5,-136(s0)
    21da:	fd878793          	addi	a5,a5,-40
    21de:	faf43c23          	sd	a5,-72(s0)
    21e2:	fb843783          	ld	a5,-72(s0)
    21e6:	02878713          	addi	a4,a5,40
    21ea:	649c                	ld	a5,8(s1)
    21ec:	faf719e3          	bne	a4,a5,219e <schedule_lst+0x200>
                }
            }
            r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
    21f0:	fa043783          	ld	a5,-96(s0)
    21f4:	02878793          	addi	a5,a5,40
    21f8:	f2f43423          	sd	a5,-216(s0)
            r.allocated_time = 0;
    21fc:	f2042823          	sw	zero,-208(s0)
        if (args.current_time >= min_slack_thread->current_deadline && min_slack_thread->remaining_time > 0) {
    2200:	a86d                	j	22ba <schedule_lst+0x31c>
        } else {
            // Calculate time until the thread's deadline
            int time_until_deadline = min_slack_thread->current_deadline - args.current_time;
    2202:	fc843783          	ld	a5,-56(s0)
    2206:	4ff8                	lw	a4,92(a5)
    2208:	409c                	lw	a5,0(s1)
    220a:	40f707bb          	subw	a5,a4,a5
    220e:	f6f42a23          	sw	a5,-140(s0)
            
            // Decide the allocated time based on current minimum slack or upcoming preemption needs
            int allocated_time = min(min_slack_thread->remaining_time, time_until_deadline);
    2212:	fc843783          	ld	a5,-56(s0)
    2216:	4fbc                	lw	a5,88(a5)
    2218:	f7442703          	lw	a4,-140(s0)
    221c:	85ba                	mv	a1,a4
    221e:	853e                	mv	a0,a5
    2220:	00000097          	auipc	ra,0x0
    2224:	d4a080e7          	jalr	-694(ra) # 1f6a <min>
    2228:	87aa                	mv	a5,a0
    222a:	f8f42e23          	sw	a5,-100(s0)
            if (next_significant_event_time != INT_MAX) {
    222e:	fb442783          	lw	a5,-76(s0)
    2232:	0007871b          	sext.w	a4,a5
    2236:	800007b7          	lui	a5,0x80000
    223a:	fff7c793          	not	a5,a5
    223e:	02f70463          	beq	a4,a5,2266 <schedule_lst+0x2c8>
                allocated_time = min(allocated_time, next_significant_event_time - args.current_time);
    2242:	409c                	lw	a5,0(s1)
    2244:	fb442703          	lw	a4,-76(s0)
    2248:	40f707bb          	subw	a5,a4,a5
    224c:	0007871b          	sext.w	a4,a5
    2250:	f9c42783          	lw	a5,-100(s0)
    2254:	85ba                	mv	a1,a4
    2256:	853e                	mv	a0,a5
    2258:	00000097          	auipc	ra,0x0
    225c:	d12080e7          	jalr	-750(ra) # 1f6a <min>
    2260:	87aa                	mv	a5,a0
    2262:	f8f42e23          	sw	a5,-100(s0)
            }

            r.scheduled_thread_list_member = &min_slack_thread->thread_list;
    2266:	fc843783          	ld	a5,-56(s0)
    226a:	02878793          	addi	a5,a5,40 # ffffffff80000028 <__global_pointer$+0xffffffff7fffcf98>
    226e:	f2f43423          	sd	a5,-216(s0)
            r.allocated_time = allocated_time;
    2272:	f9c42783          	lw	a5,-100(s0)
    2276:	f2f42823          	sw	a5,-208(s0)
    227a:	a081                	j	22ba <schedule_lst+0x31c>
        }
    } else {
        // No runnable threads, prepare to sleep or wait based on next known event
        r.scheduled_thread_list_member = args.run_queue;
    227c:	649c                	ld	a5,8(s1)
    227e:	f2f43423          	sd	a5,-216(s0)
        r.allocated_time = next_significant_event_time != INT_MAX ? next_significant_event_time - args.current_time : find_next_release_time(args.release_queue, args.current_time);
    2282:	fb442783          	lw	a5,-76(s0)
    2286:	0007871b          	sext.w	a4,a5
    228a:	800007b7          	lui	a5,0x80000
    228e:	fff7c793          	not	a5,a5
    2292:	00f70963          	beq	a4,a5,22a4 <schedule_lst+0x306>
    2296:	409c                	lw	a5,0(s1)
    2298:	fb442703          	lw	a4,-76(s0)
    229c:	40f707bb          	subw	a5,a4,a5
    22a0:	2781                	sext.w	a5,a5
    22a2:	a811                	j	22b6 <schedule_lst+0x318>
    22a4:	689c                	ld	a5,16(s1)
    22a6:	4098                	lw	a4,0(s1)
    22a8:	85ba                	mv	a1,a4
    22aa:	853e                	mv	a0,a5
    22ac:	00000097          	auipc	ra,0x0
    22b0:	820080e7          	jalr	-2016(ra) # 1acc <find_next_release_time>
    22b4:	87aa                	mv	a5,a0
    22b6:	f2f42823          	sw	a5,-208(s0)
    }

    return r;
    22ba:	f2843783          	ld	a5,-216(s0)
    22be:	f2f43c23          	sd	a5,-200(s0)
    22c2:	f3043783          	ld	a5,-208(s0)
    22c6:	f4f43023          	sd	a5,-192(s0)
    22ca:	4701                	li	a4,0
    22cc:	f3843703          	ld	a4,-200(s0)
    22d0:	4781                	li	a5,0
    22d2:	f4043783          	ld	a5,-192(s0)
    22d6:	893a                	mv	s2,a4
    22d8:	89be                	mv	s3,a5
    22da:	874a                	mv	a4,s2
    22dc:	87ce                	mv	a5,s3
}
    22de:	853a                	mv	a0,a4
    22e0:	85be                	mv	a1,a5
    22e2:	60ee                	ld	ra,216(sp)
    22e4:	644e                	ld	s0,208(sp)
    22e6:	64ae                	ld	s1,200(sp)
    22e8:	690e                	ld	s2,192(sp)
    22ea:	79ea                	ld	s3,184(sp)
    22ec:	612d                	addi	sp,sp,224
    22ee:	8082                	ret

00000000000022f0 <find_earliest_impactful_release_time_dm>:
typedef struct {
    int earliest_impactful_event;
    struct thread *thread;
} ImpactfulEvent;

ImpactfulEvent find_earliest_impactful_release_time_dm(struct list_head *release_queue, struct list_head*run_queue, int current_time, int current_period, int current_thread_ID) {
    22f0:	7119                	addi	sp,sp,-128
    22f2:	fca2                	sd	s0,120(sp)
    22f4:	0100                	addi	s0,sp,128
    22f6:	f8a43c23          	sd	a0,-104(s0)
    22fa:	f8b43823          	sd	a1,-112(s0)
    22fe:	87b2                	mv	a5,a2
    2300:	f8f42623          	sw	a5,-116(s0)
    2304:	87b6                	mv	a5,a3
    2306:	f8f42423          	sw	a5,-120(s0)
    230a:	87ba                	mv	a5,a4
    230c:	f8f42223          	sw	a5,-124(s0)
    struct release_queue_entry *entry;
    struct thread *t;
    int earliest_impactful_event = INT_MAX;
    2310:	800007b7          	lui	a5,0x80000
    2314:	fff7c793          	not	a5,a5
    2318:	fcf42e23          	sw	a5,-36(s0)
    int earliest_impactful_thread_ID = current_thread_ID;    
    231c:	f8442783          	lw	a5,-124(s0)
    2320:	fcf42c23          	sw	a5,-40(s0)
    
    // Look for the smallest deadline that is less than the current task's deadline
    list_for_each_entry(entry, release_queue, thread_list) {
    2324:	f9843783          	ld	a5,-104(s0)
    2328:	639c                	ld	a5,0(a5)
    232a:	fcf43823          	sd	a5,-48(s0)
    232e:	fd043783          	ld	a5,-48(s0)
    2332:	17e1                	addi	a5,a5,-8
    2334:	fef43423          	sd	a5,-24(s0)
    2338:	a0f9                	j	2406 <find_earliest_impactful_release_time_dm+0x116>
        if (entry->release_time > current_time && entry->thrd->period < current_period) {
    233a:	fe843783          	ld	a5,-24(s0)
    233e:	4f98                	lw	a4,24(a5)
    2340:	f8c42783          	lw	a5,-116(s0)
    2344:	2781                	sext.w	a5,a5
    2346:	04e7d463          	bge	a5,a4,238e <find_earliest_impactful_release_time_dm+0x9e>
    234a:	fe843783          	ld	a5,-24(s0)
    234e:	639c                	ld	a5,0(a5)
    2350:	4bb8                	lw	a4,80(a5)
    2352:	f8842783          	lw	a5,-120(s0)
    2356:	2781                	sext.w	a5,a5
    2358:	02f75b63          	bge	a4,a5,238e <find_earliest_impactful_release_time_dm+0x9e>
            if (entry->release_time < earliest_impactful_event) {
    235c:	fe843783          	ld	a5,-24(s0)
    2360:	4f98                	lw	a4,24(a5)
    2362:	fdc42783          	lw	a5,-36(s0)
    2366:	2781                	sext.w	a5,a5
    2368:	08f75563          	bge	a4,a5,23f2 <find_earliest_impactful_release_time_dm+0x102>
                earliest_impactful_event = entry->release_time;
    236c:	fe843783          	ld	a5,-24(s0)
    2370:	4f9c                	lw	a5,24(a5)
    2372:	fcf42e23          	sw	a5,-36(s0)
                t = entry->thrd;
    2376:	fe843783          	ld	a5,-24(s0)
    237a:	639c                	ld	a5,0(a5)
    237c:	fef43023          	sd	a5,-32(s0)
                earliest_impactful_thread_ID = entry->thrd->ID;
    2380:	fe843783          	ld	a5,-24(s0)
    2384:	639c                	ld	a5,0(a5)
    2386:	5fdc                	lw	a5,60(a5)
    2388:	fcf42c23          	sw	a5,-40(s0)
            if (entry->release_time < earliest_impactful_event) {
    238c:	a09d                	j	23f2 <find_earliest_impactful_release_time_dm+0x102>
            }
        } 
        else if (entry->release_time > current_time && entry->thrd->period == current_period) {
    238e:	fe843783          	ld	a5,-24(s0)
    2392:	4f98                	lw	a4,24(a5)
    2394:	f8c42783          	lw	a5,-116(s0)
    2398:	2781                	sext.w	a5,a5
    239a:	04e7dc63          	bge	a5,a4,23f2 <find_earliest_impactful_release_time_dm+0x102>
    239e:	fe843783          	ld	a5,-24(s0)
    23a2:	639c                	ld	a5,0(a5)
    23a4:	4bb8                	lw	a4,80(a5)
    23a6:	f8842783          	lw	a5,-120(s0)
    23aa:	2781                	sext.w	a5,a5
    23ac:	04e79363          	bne	a5,a4,23f2 <find_earliest_impactful_release_time_dm+0x102>
            //printf("ID %d, entry release time: %d\n", entry->thrd->ID, entry->release_time);
            // or the smallest deadline that is equal to the current task's deadline but has a smaller ID
            if (entry->release_time <= earliest_impactful_event && entry->thrd->ID < earliest_impactful_thread_ID) {
    23b0:	fe843783          	ld	a5,-24(s0)
    23b4:	4f98                	lw	a4,24(a5)
    23b6:	fdc42783          	lw	a5,-36(s0)
    23ba:	2781                	sext.w	a5,a5
    23bc:	02e7cb63          	blt	a5,a4,23f2 <find_earliest_impactful_release_time_dm+0x102>
    23c0:	fe843783          	ld	a5,-24(s0)
    23c4:	639c                	ld	a5,0(a5)
    23c6:	5fd8                	lw	a4,60(a5)
    23c8:	fd842783          	lw	a5,-40(s0)
    23cc:	2781                	sext.w	a5,a5
    23ce:	02f75263          	bge	a4,a5,23f2 <find_earliest_impactful_release_time_dm+0x102>
                earliest_impactful_event = entry->release_time;
    23d2:	fe843783          	ld	a5,-24(s0)
    23d6:	4f9c                	lw	a5,24(a5)
    23d8:	fcf42e23          	sw	a5,-36(s0)
                t = entry->thrd;
    23dc:	fe843783          	ld	a5,-24(s0)
    23e0:	639c                	ld	a5,0(a5)
    23e2:	fef43023          	sd	a5,-32(s0)
                earliest_impactful_thread_ID = entry->thrd->ID;
    23e6:	fe843783          	ld	a5,-24(s0)
    23ea:	639c                	ld	a5,0(a5)
    23ec:	5fdc                	lw	a5,60(a5)
    23ee:	fcf42c23          	sw	a5,-40(s0)
    list_for_each_entry(entry, release_queue, thread_list) {
    23f2:	fe843783          	ld	a5,-24(s0)
    23f6:	679c                	ld	a5,8(a5)
    23f8:	fcf43423          	sd	a5,-56(s0)
    23fc:	fc843783          	ld	a5,-56(s0)
    2400:	17e1                	addi	a5,a5,-8
    2402:	fef43423          	sd	a5,-24(s0)
    2406:	fe843783          	ld	a5,-24(s0)
    240a:	07a1                	addi	a5,a5,8
    240c:	f9843703          	ld	a4,-104(s0)
    2410:	f2f715e3          	bne	a4,a5,233a <find_earliest_impactful_release_time_dm+0x4a>
            }
        }
    }
    //printf("earliest_impactful_event: %d\n", earliest_impactful_event);
    // If a task is found that might preempt the current task, determine when it will happen
    earliest_impactful_event = earliest_impactful_event == INT_MAX ? -1 : earliest_impactful_event;
    2414:	fdc42783          	lw	a5,-36(s0)
    2418:	0007871b          	sext.w	a4,a5
    241c:	800007b7          	lui	a5,0x80000
    2420:	fff7c793          	not	a5,a5
    2424:	00f70563          	beq	a4,a5,242e <find_earliest_impactful_release_time_dm+0x13e>
    2428:	fdc42783          	lw	a5,-36(s0)
    242c:	a011                	j	2430 <find_earliest_impactful_release_time_dm+0x140>
    242e:	57fd                	li	a5,-1
    2430:	fcf42e23          	sw	a5,-36(s0)
    return (ImpactfulEvent) {earliest_impactful_event, t};
    2434:	fdc42783          	lw	a5,-36(s0)
    2438:	faf42c23          	sw	a5,-72(s0)
    243c:	fe043783          	ld	a5,-32(s0)
    2440:	fcf43023          	sd	a5,-64(s0)
    2444:	4701                	li	a4,0
    2446:	fb843703          	ld	a4,-72(s0)
    244a:	4781                	li	a5,0
    244c:	fc043783          	ld	a5,-64(s0)
    2450:	883a                	mv	a6,a4
    2452:	88be                	mv	a7,a5
    2454:	8742                	mv	a4,a6
    2456:	87c6                	mv	a5,a7
}
    2458:	853a                	mv	a0,a4
    245a:	85be                	mv	a1,a5
    245c:	7466                	ld	s0,120(sp)
    245e:	6109                	addi	sp,sp,128
    2460:	8082                	ret

0000000000002462 <schedule_dm>:


struct threads_sched_result schedule_dm(struct threads_sched_args args) {
    2462:	7155                	addi	sp,sp,-208
    2464:	e586                	sd	ra,200(sp)
    2466:	e1a2                	sd	s0,192(sp)
    2468:	fd26                	sd	s1,184(sp)
    246a:	f94a                	sd	s2,176(sp)
    246c:	f54e                	sd	s3,168(sp)
    246e:	0980                	addi	s0,sp,208
    2470:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *earliest_deadline_thread = NULL;
    2472:	fc043423          	sd	zero,-56(s0)
    struct thread *t;
    int earliest_deadline = INT_MAX;
    2476:	800007b7          	lui	a5,0x80000
    247a:	fff7c793          	not	a5,a5
    247e:	faf42e23          	sw	a5,-68(s0)
    int earliest_impactful_deadline; 
    
    // Check if any thread has passed its deadline and choose the one with the smallest ID
    list_for_each_entry(t, args.run_queue, thread_list) {
    2482:	649c                	ld	a5,8(s1)
    2484:	639c                	ld	a5,0(a5)
    2486:	faf43023          	sd	a5,-96(s0)
    248a:	fa043783          	ld	a5,-96(s0)
    248e:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffcf48>
    2492:	fcf43023          	sd	a5,-64(s0)
    2496:	a875                	j	2552 <schedule_dm+0xf0>
        if (t->is_real_time && args.current_time >= t->current_deadline) {
    2498:	fc043783          	ld	a5,-64(s0)
    249c:	43bc                	lw	a5,64(a5)
    249e:	cfd9                	beqz	a5,253c <schedule_dm+0xda>
    24a0:	4098                	lw	a4,0(s1)
    24a2:	fc043783          	ld	a5,-64(s0)
    24a6:	4ffc                	lw	a5,92(a5)
    24a8:	08f74a63          	blt	a4,a5,253c <schedule_dm+0xda>
            struct thread *thread_with_smallest_id = t;
    24ac:	fc043783          	ld	a5,-64(s0)
    24b0:	faf43823          	sd	a5,-80(s0)
            list_for_each_entry(t, args.run_queue, thread_list) {
    24b4:	649c                	ld	a5,8(s1)
    24b6:	639c                	ld	a5,0(a5)
    24b8:	f6f43c23          	sd	a5,-136(s0)
    24bc:	f7843783          	ld	a5,-136(s0)
    24c0:	fd878793          	addi	a5,a5,-40
    24c4:	fcf43023          	sd	a5,-64(s0)
    24c8:	a091                	j	250c <schedule_dm+0xaa>
                if (t->is_real_time && args.current_time >= t->current_deadline && t->ID < thread_with_smallest_id->ID) {
    24ca:	fc043783          	ld	a5,-64(s0)
    24ce:	43bc                	lw	a5,64(a5)
    24d0:	c39d                	beqz	a5,24f6 <schedule_dm+0x94>
    24d2:	4098                	lw	a4,0(s1)
    24d4:	fc043783          	ld	a5,-64(s0)
    24d8:	4ffc                	lw	a5,92(a5)
    24da:	00f74e63          	blt	a4,a5,24f6 <schedule_dm+0x94>
    24de:	fc043783          	ld	a5,-64(s0)
    24e2:	5fd8                	lw	a4,60(a5)
    24e4:	fb043783          	ld	a5,-80(s0)
    24e8:	5fdc                	lw	a5,60(a5)
    24ea:	00f75663          	bge	a4,a5,24f6 <schedule_dm+0x94>
                    thread_with_smallest_id = t;
    24ee:	fc043783          	ld	a5,-64(s0)
    24f2:	faf43823          	sd	a5,-80(s0)
            list_for_each_entry(t, args.run_queue, thread_list) {
    24f6:	fc043783          	ld	a5,-64(s0)
    24fa:	779c                	ld	a5,40(a5)
    24fc:	f6f43823          	sd	a5,-144(s0)
    2500:	f7043783          	ld	a5,-144(s0)
    2504:	fd878793          	addi	a5,a5,-40
    2508:	fcf43023          	sd	a5,-64(s0)
    250c:	fc043783          	ld	a5,-64(s0)
    2510:	02878713          	addi	a4,a5,40
    2514:	649c                	ld	a5,8(s1)
    2516:	faf71ae3          	bne	a4,a5,24ca <schedule_dm+0x68>
                }
            }
            r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
    251a:	fb043783          	ld	a5,-80(s0)
    251e:	02878793          	addi	a5,a5,40
    2522:	f4f43423          	sd	a5,-184(s0)
            r.allocated_time = 0;
    2526:	f4042823          	sw	zero,-176(s0)
            return r;
    252a:	f4843783          	ld	a5,-184(s0)
    252e:	f4f43c23          	sd	a5,-168(s0)
    2532:	f5043783          	ld	a5,-176(s0)
    2536:	f6f43023          	sd	a5,-160(s0)
    253a:	aad1                	j	270e <schedule_dm+0x2ac>
    list_for_each_entry(t, args.run_queue, thread_list) {
    253c:	fc043783          	ld	a5,-64(s0)
    2540:	779c                	ld	a5,40(a5)
    2542:	f6f43423          	sd	a5,-152(s0)
    2546:	f6843783          	ld	a5,-152(s0)
    254a:	fd878793          	addi	a5,a5,-40
    254e:	fcf43023          	sd	a5,-64(s0)
    2552:	fc043783          	ld	a5,-64(s0)
    2556:	02878713          	addi	a4,a5,40
    255a:	649c                	ld	a5,8(s1)
    255c:	f2f71ee3          	bne	a4,a5,2498 <schedule_dm+0x36>
        }
    }

    // Determine the earliest deadline among current tasks
    list_for_each_entry(t, args.run_queue, thread_list) {
    2560:	649c                	ld	a5,8(s1)
    2562:	639c                	ld	a5,0(a5)
    2564:	f8f43c23          	sd	a5,-104(s0)
    2568:	f9843783          	ld	a5,-104(s0)
    256c:	fd878793          	addi	a5,a5,-40
    2570:	fcf43023          	sd	a5,-64(s0)
    2574:	a8bd                	j	25f2 <schedule_dm+0x190>
        if (t->is_real_time && t->period < earliest_deadline) {
    2576:	fc043783          	ld	a5,-64(s0)
    257a:	43bc                	lw	a5,64(a5)
    257c:	c39d                	beqz	a5,25a2 <schedule_dm+0x140>
    257e:	fc043783          	ld	a5,-64(s0)
    2582:	4bb8                	lw	a4,80(a5)
    2584:	fbc42783          	lw	a5,-68(s0)
    2588:	2781                	sext.w	a5,a5
    258a:	00f75c63          	bge	a4,a5,25a2 <schedule_dm+0x140>
            earliest_deadline_thread = t;
    258e:	fc043783          	ld	a5,-64(s0)
    2592:	fcf43423          	sd	a5,-56(s0)
            earliest_deadline = t->period;
    2596:	fc043783          	ld	a5,-64(s0)
    259a:	4bbc                	lw	a5,80(a5)
    259c:	faf42e23          	sw	a5,-68(s0)
    25a0:	a835                	j	25dc <schedule_dm+0x17a>
        } else if (t->is_real_time && t->period == earliest_deadline && t->ID < earliest_deadline_thread->ID) {
    25a2:	fc043783          	ld	a5,-64(s0)
    25a6:	43bc                	lw	a5,64(a5)
    25a8:	cb95                	beqz	a5,25dc <schedule_dm+0x17a>
    25aa:	fc043783          	ld	a5,-64(s0)
    25ae:	4bb8                	lw	a4,80(a5)
    25b0:	fbc42783          	lw	a5,-68(s0)
    25b4:	2781                	sext.w	a5,a5
    25b6:	02e79363          	bne	a5,a4,25dc <schedule_dm+0x17a>
    25ba:	fc043783          	ld	a5,-64(s0)
    25be:	5fd8                	lw	a4,60(a5)
    25c0:	fc843783          	ld	a5,-56(s0)
    25c4:	5fdc                	lw	a5,60(a5)
    25c6:	00f75b63          	bge	a4,a5,25dc <schedule_dm+0x17a>
            earliest_deadline_thread = t;
    25ca:	fc043783          	ld	a5,-64(s0)
    25ce:	fcf43423          	sd	a5,-56(s0)
            earliest_deadline = t->period;
    25d2:	fc043783          	ld	a5,-64(s0)
    25d6:	4bbc                	lw	a5,80(a5)
    25d8:	faf42e23          	sw	a5,-68(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    25dc:	fc043783          	ld	a5,-64(s0)
    25e0:	779c                	ld	a5,40(a5)
    25e2:	f8f43023          	sd	a5,-128(s0)
    25e6:	f8043783          	ld	a5,-128(s0)
    25ea:	fd878793          	addi	a5,a5,-40
    25ee:	fcf43023          	sd	a5,-64(s0)
    25f2:	fc043783          	ld	a5,-64(s0)
    25f6:	02878713          	addi	a4,a5,40
    25fa:	649c                	ld	a5,8(s1)
    25fc:	f6f71de3          	bne	a4,a5,2576 <schedule_dm+0x114>
        }
    }

    // Find the earliest impactful deadline from other tasks
    ImpactfulEvent earliest_impactful_event = find_earliest_impactful_release_time_dm(args.release_queue, args.run_queue, args.current_time, earliest_deadline_thread ? earliest_deadline_thread->period : INT_MAX, earliest_deadline_thread->ID);
    2600:	6888                	ld	a0,16(s1)
    2602:	648c                	ld	a1,8(s1)
    2604:	4090                	lw	a2,0(s1)
    2606:	fc843783          	ld	a5,-56(s0)
    260a:	c789                	beqz	a5,2614 <schedule_dm+0x1b2>
    260c:	fc843783          	ld	a5,-56(s0)
    2610:	4bbc                	lw	a5,80(a5)
    2612:	a029                	j	261c <schedule_dm+0x1ba>
    2614:	800007b7          	lui	a5,0x80000
    2618:	fff7c793          	not	a5,a5
    261c:	fc843703          	ld	a4,-56(s0)
    2620:	5f58                	lw	a4,60(a4)
    2622:	86be                	mv	a3,a5
    2624:	00000097          	auipc	ra,0x0
    2628:	ccc080e7          	jalr	-820(ra) # 22f0 <find_earliest_impactful_release_time_dm>
    262c:	872a                	mv	a4,a0
    262e:	87ae                	mv	a5,a1
    2630:	f2e43c23          	sd	a4,-200(s0)
    2634:	f4f43023          	sd	a5,-192(s0)
    earliest_impactful_deadline = earliest_impactful_event.earliest_impactful_event;
    2638:	f3842783          	lw	a5,-200(s0)
    263c:	f8f42a23          	sw	a5,-108(s0)
    //printf("earliest_impactful_deadline: %d\n", earliest_impactful_deadline);
    if (earliest_deadline_thread) {
    2640:	fc843783          	ld	a5,-56(s0)
    2644:	cfd9                	beqz	a5,26e2 <schedule_dm+0x280>
        int time_to_deadline = earliest_deadline_thread->current_deadline - args.current_time;
    2646:	fc843783          	ld	a5,-56(s0)
    264a:	4ff8                	lw	a4,92(a5)
    264c:	409c                	lw	a5,0(s1)
    264e:	40f707bb          	subw	a5,a4,a5
    2652:	f8f42823          	sw	a5,-112(s0)
        
        // If the thread is already past its deadline, allocate no time (handle deadline miss)
        if (time_to_deadline <= 0) {
    2656:	f9042783          	lw	a5,-112(s0)
    265a:	2781                	sext.w	a5,a5
    265c:	00f04b63          	bgtz	a5,2672 <schedule_dm+0x210>
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    2660:	fc843783          	ld	a5,-56(s0)
    2664:	02878793          	addi	a5,a5,40 # ffffffff80000028 <__global_pointer$+0xffffffff7fffcf98>
    2668:	f4f43423          	sd	a5,-184(s0)
            r.allocated_time = 0;
    266c:	f4042823          	sw	zero,-176(s0)
    2670:	a079                	j	26fe <schedule_dm+0x29c>
        } else {
            // Allocate time based on the smallest of the task's remaining time or the next impactful deadline
            int remaining_time = min(earliest_deadline_thread->remaining_time, time_to_deadline);
    2672:	fc843783          	ld	a5,-56(s0)
    2676:	4fbc                	lw	a5,88(a5)
    2678:	f9042703          	lw	a4,-112(s0)
    267c:	85ba                	mv	a1,a4
    267e:	853e                	mv	a0,a5
    2680:	00000097          	auipc	ra,0x0
    2684:	8ea080e7          	jalr	-1814(ra) # 1f6a <min>
    2688:	87aa                	mv	a5,a0
    268a:	f8f42623          	sw	a5,-116(s0)
            int allocated_time;
            if (earliest_impactful_deadline != -1 && (earliest_impactful_deadline - args.current_time) < remaining_time){
    268e:	f9442783          	lw	a5,-108(s0)
    2692:	0007871b          	sext.w	a4,a5
    2696:	57fd                	li	a5,-1
    2698:	02f70663          	beq	a4,a5,26c4 <schedule_dm+0x262>
    269c:	409c                	lw	a5,0(s1)
    269e:	f9442703          	lw	a4,-108(s0)
    26a2:	40f707bb          	subw	a5,a4,a5
    26a6:	0007871b          	sext.w	a4,a5
    26aa:	f8c42783          	lw	a5,-116(s0)
    26ae:	2781                	sext.w	a5,a5
    26b0:	00f75a63          	bge	a4,a5,26c4 <schedule_dm+0x262>
                allocated_time = earliest_impactful_deadline - args.current_time;
    26b4:	409c                	lw	a5,0(s1)
    26b6:	f9442703          	lw	a4,-108(s0)
    26ba:	40f707bb          	subw	a5,a4,a5
    26be:	faf42623          	sw	a5,-84(s0)
    26c2:	a029                	j	26cc <schedule_dm+0x26a>
            } else {
                allocated_time = remaining_time;
    26c4:	f8c42783          	lw	a5,-116(s0)
    26c8:	faf42623          	sw	a5,-84(s0)
            }
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    26cc:	fc843783          	ld	a5,-56(s0)
    26d0:	02878793          	addi	a5,a5,40
    26d4:	f4f43423          	sd	a5,-184(s0)
            r.allocated_time = allocated_time;
    26d8:	fac42783          	lw	a5,-84(s0)
    26dc:	f4f42823          	sw	a5,-176(s0)
    26e0:	a839                	j	26fe <schedule_dm+0x29c>
        }
    } else {
        // If no immediate tasks, schedule the next possible task
        r.scheduled_thread_list_member = args.run_queue;
    26e2:	649c                	ld	a5,8(s1)
    26e4:	f4f43423          	sd	a5,-184(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    26e8:	689c                	ld	a5,16(s1)
    26ea:	4098                	lw	a4,0(s1)
    26ec:	85ba                	mv	a1,a4
    26ee:	853e                	mv	a0,a5
    26f0:	fffff097          	auipc	ra,0xfffff
    26f4:	3dc080e7          	jalr	988(ra) # 1acc <find_next_release_time>
    26f8:	87aa                	mv	a5,a0
    26fa:	f4f42823          	sw	a5,-176(s0)
    }

    return r;
    26fe:	f4843783          	ld	a5,-184(s0)
    2702:	f4f43c23          	sd	a5,-168(s0)
    2706:	f5043783          	ld	a5,-176(s0)
    270a:	f6f43023          	sd	a5,-160(s0)
    270e:	4701                	li	a4,0
    2710:	f5843703          	ld	a4,-168(s0)
    2714:	4781                	li	a5,0
    2716:	f6043783          	ld	a5,-160(s0)
    271a:	893a                	mv	s2,a4
    271c:	89be                	mv	s3,a5
    271e:	874a                	mv	a4,s2
    2720:	87ce                	mv	a5,s3
}
    2722:	853a                	mv	a0,a4
    2724:	85be                	mv	a1,a5
    2726:	60ae                	ld	ra,200(sp)
    2728:	640e                	ld	s0,192(sp)
    272a:	74ea                	ld	s1,184(sp)
    272c:	794a                	ld	s2,176(sp)
    272e:	79aa                	ld	s3,168(sp)
    2730:	6169                	addi	sp,sp,208
    2732:	8082                	ret
