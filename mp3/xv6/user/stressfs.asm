
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
       0:	dc010113          	addi	sp,sp,-576
       4:	22113c23          	sd	ra,568(sp)
       8:	22813823          	sd	s0,560(sp)
       c:	0480                	addi	s0,sp,576
       e:	87aa                	mv	a5,a0
      10:	dcb43023          	sd	a1,-576(s0)
      14:	dcf42623          	sw	a5,-564(s0)
  int fd, i;
  char path[] = "stressfs0";
      18:	00001797          	auipc	a5,0x1
      1c:	61878793          	addi	a5,a5,1560 # 1630 <schedule_dm+0x240>
      20:	6398                	ld	a4,0(a5)
      22:	fce43c23          	sd	a4,-40(s0)
      26:	0087d783          	lhu	a5,8(a5)
      2a:	fef41023          	sh	a5,-32(s0)
  char data[512];

  printf("stressfs starting\n");
      2e:	00001517          	auipc	a0,0x1
      32:	5d250513          	addi	a0,a0,1490 # 1600 <schedule_dm+0x210>
      36:	00001097          	auipc	ra,0x1
      3a:	b2a080e7          	jalr	-1238(ra) # b60 <printf>
  memset(data, 'a', sizeof(data));
      3e:	dd840793          	addi	a5,s0,-552
      42:	20000613          	li	a2,512
      46:	06100593          	li	a1,97
      4a:	853e                	mv	a0,a5
      4c:	00000097          	auipc	ra,0x0
      50:	224080e7          	jalr	548(ra) # 270 <memset>

  for(i = 0; i < 4; i++)
      54:	fe042623          	sw	zero,-20(s0)
      58:	a829                	j	72 <main+0x72>
    if(fork() > 0)
      5a:	00000097          	auipc	ra,0x0
      5e:	5b8080e7          	jalr	1464(ra) # 612 <fork>
      62:	87aa                	mv	a5,a0
      64:	00f04f63          	bgtz	a5,82 <main+0x82>
  for(i = 0; i < 4; i++)
      68:	fec42783          	lw	a5,-20(s0)
      6c:	2785                	addiw	a5,a5,1
      6e:	fef42623          	sw	a5,-20(s0)
      72:	fec42783          	lw	a5,-20(s0)
      76:	0007871b          	sext.w	a4,a5
      7a:	478d                	li	a5,3
      7c:	fce7dfe3          	bge	a5,a4,5a <main+0x5a>
      80:	a011                	j	84 <main+0x84>
      break;
      82:	0001                	nop

  printf("write %d\n", i);
      84:	fec42783          	lw	a5,-20(s0)
      88:	85be                	mv	a1,a5
      8a:	00001517          	auipc	a0,0x1
      8e:	58e50513          	addi	a0,a0,1422 # 1618 <schedule_dm+0x228>
      92:	00001097          	auipc	ra,0x1
      96:	ace080e7          	jalr	-1330(ra) # b60 <printf>

  path[8] += i;
      9a:	fe044703          	lbu	a4,-32(s0)
      9e:	fec42783          	lw	a5,-20(s0)
      a2:	0ff7f793          	andi	a5,a5,255
      a6:	9fb9                	addw	a5,a5,a4
      a8:	0ff7f793          	andi	a5,a5,255
      ac:	fef40023          	sb	a5,-32(s0)
  fd = open(path, O_CREATE | O_RDWR);
      b0:	fd840793          	addi	a5,s0,-40
      b4:	20200593          	li	a1,514
      b8:	853e                	mv	a0,a5
      ba:	00000097          	auipc	ra,0x0
      be:	5a0080e7          	jalr	1440(ra) # 65a <open>
      c2:	87aa                	mv	a5,a0
      c4:	fef42423          	sw	a5,-24(s0)
  for(i = 0; i < 20; i++)
      c8:	fe042623          	sw	zero,-20(s0)
      cc:	a015                	j	f0 <main+0xf0>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
      ce:	dd840713          	addi	a4,s0,-552
      d2:	fe842783          	lw	a5,-24(s0)
      d6:	20000613          	li	a2,512
      da:	85ba                	mv	a1,a4
      dc:	853e                	mv	a0,a5
      de:	00000097          	auipc	ra,0x0
      e2:	55c080e7          	jalr	1372(ra) # 63a <write>
  for(i = 0; i < 20; i++)
      e6:	fec42783          	lw	a5,-20(s0)
      ea:	2785                	addiw	a5,a5,1
      ec:	fef42623          	sw	a5,-20(s0)
      f0:	fec42783          	lw	a5,-20(s0)
      f4:	0007871b          	sext.w	a4,a5
      f8:	47cd                	li	a5,19
      fa:	fce7dae3          	bge	a5,a4,ce <main+0xce>
  close(fd);
      fe:	fe842783          	lw	a5,-24(s0)
     102:	853e                	mv	a0,a5
     104:	00000097          	auipc	ra,0x0
     108:	53e080e7          	jalr	1342(ra) # 642 <close>

  printf("read\n");
     10c:	00001517          	auipc	a0,0x1
     110:	51c50513          	addi	a0,a0,1308 # 1628 <schedule_dm+0x238>
     114:	00001097          	auipc	ra,0x1
     118:	a4c080e7          	jalr	-1460(ra) # b60 <printf>

  fd = open(path, O_RDONLY);
     11c:	fd840793          	addi	a5,s0,-40
     120:	4581                	li	a1,0
     122:	853e                	mv	a0,a5
     124:	00000097          	auipc	ra,0x0
     128:	536080e7          	jalr	1334(ra) # 65a <open>
     12c:	87aa                	mv	a5,a0
     12e:	fef42423          	sw	a5,-24(s0)
  for (i = 0; i < 20; i++)
     132:	fe042623          	sw	zero,-20(s0)
     136:	a015                	j	15a <main+0x15a>
    read(fd, data, sizeof(data));
     138:	dd840713          	addi	a4,s0,-552
     13c:	fe842783          	lw	a5,-24(s0)
     140:	20000613          	li	a2,512
     144:	85ba                	mv	a1,a4
     146:	853e                	mv	a0,a5
     148:	00000097          	auipc	ra,0x0
     14c:	4ea080e7          	jalr	1258(ra) # 632 <read>
  for (i = 0; i < 20; i++)
     150:	fec42783          	lw	a5,-20(s0)
     154:	2785                	addiw	a5,a5,1
     156:	fef42623          	sw	a5,-20(s0)
     15a:	fec42783          	lw	a5,-20(s0)
     15e:	0007871b          	sext.w	a4,a5
     162:	47cd                	li	a5,19
     164:	fce7dae3          	bge	a5,a4,138 <main+0x138>
  close(fd);
     168:	fe842783          	lw	a5,-24(s0)
     16c:	853e                	mv	a0,a5
     16e:	00000097          	auipc	ra,0x0
     172:	4d4080e7          	jalr	1236(ra) # 642 <close>

  wait(0);
     176:	4501                	li	a0,0
     178:	00000097          	auipc	ra,0x0
     17c:	4aa080e7          	jalr	1194(ra) # 622 <wait>

  exit(0);
     180:	4501                	li	a0,0
     182:	00000097          	auipc	ra,0x0
     186:	498080e7          	jalr	1176(ra) # 61a <exit>

000000000000018a <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     18a:	7179                	addi	sp,sp,-48
     18c:	f422                	sd	s0,40(sp)
     18e:	1800                	addi	s0,sp,48
     190:	fca43c23          	sd	a0,-40(s0)
     194:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     198:	fd843783          	ld	a5,-40(s0)
     19c:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     1a0:	0001                	nop
     1a2:	fd043703          	ld	a4,-48(s0)
     1a6:	00170793          	addi	a5,a4,1
     1aa:	fcf43823          	sd	a5,-48(s0)
     1ae:	fd843783          	ld	a5,-40(s0)
     1b2:	00178693          	addi	a3,a5,1
     1b6:	fcd43c23          	sd	a3,-40(s0)
     1ba:	00074703          	lbu	a4,0(a4)
     1be:	00e78023          	sb	a4,0(a5)
     1c2:	0007c783          	lbu	a5,0(a5)
     1c6:	fff1                	bnez	a5,1a2 <strcpy+0x18>
    ;
  return os;
     1c8:	fe843783          	ld	a5,-24(s0)
}
     1cc:	853e                	mv	a0,a5
     1ce:	7422                	ld	s0,40(sp)
     1d0:	6145                	addi	sp,sp,48
     1d2:	8082                	ret

00000000000001d4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     1d4:	1101                	addi	sp,sp,-32
     1d6:	ec22                	sd	s0,24(sp)
     1d8:	1000                	addi	s0,sp,32
     1da:	fea43423          	sd	a0,-24(s0)
     1de:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     1e2:	a819                	j	1f8 <strcmp+0x24>
    p++, q++;
     1e4:	fe843783          	ld	a5,-24(s0)
     1e8:	0785                	addi	a5,a5,1
     1ea:	fef43423          	sd	a5,-24(s0)
     1ee:	fe043783          	ld	a5,-32(s0)
     1f2:	0785                	addi	a5,a5,1
     1f4:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     1f8:	fe843783          	ld	a5,-24(s0)
     1fc:	0007c783          	lbu	a5,0(a5)
     200:	cb99                	beqz	a5,216 <strcmp+0x42>
     202:	fe843783          	ld	a5,-24(s0)
     206:	0007c703          	lbu	a4,0(a5)
     20a:	fe043783          	ld	a5,-32(s0)
     20e:	0007c783          	lbu	a5,0(a5)
     212:	fcf709e3          	beq	a4,a5,1e4 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     216:	fe843783          	ld	a5,-24(s0)
     21a:	0007c783          	lbu	a5,0(a5)
     21e:	0007871b          	sext.w	a4,a5
     222:	fe043783          	ld	a5,-32(s0)
     226:	0007c783          	lbu	a5,0(a5)
     22a:	2781                	sext.w	a5,a5
     22c:	40f707bb          	subw	a5,a4,a5
     230:	2781                	sext.w	a5,a5
}
     232:	853e                	mv	a0,a5
     234:	6462                	ld	s0,24(sp)
     236:	6105                	addi	sp,sp,32
     238:	8082                	ret

000000000000023a <strlen>:

uint
strlen(const char *s)
{
     23a:	7179                	addi	sp,sp,-48
     23c:	f422                	sd	s0,40(sp)
     23e:	1800                	addi	s0,sp,48
     240:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     244:	fe042623          	sw	zero,-20(s0)
     248:	a031                	j	254 <strlen+0x1a>
     24a:	fec42783          	lw	a5,-20(s0)
     24e:	2785                	addiw	a5,a5,1
     250:	fef42623          	sw	a5,-20(s0)
     254:	fec42783          	lw	a5,-20(s0)
     258:	fd843703          	ld	a4,-40(s0)
     25c:	97ba                	add	a5,a5,a4
     25e:	0007c783          	lbu	a5,0(a5)
     262:	f7e5                	bnez	a5,24a <strlen+0x10>
    ;
  return n;
     264:	fec42783          	lw	a5,-20(s0)
}
     268:	853e                	mv	a0,a5
     26a:	7422                	ld	s0,40(sp)
     26c:	6145                	addi	sp,sp,48
     26e:	8082                	ret

0000000000000270 <memset>:

void*
memset(void *dst, int c, uint n)
{
     270:	7179                	addi	sp,sp,-48
     272:	f422                	sd	s0,40(sp)
     274:	1800                	addi	s0,sp,48
     276:	fca43c23          	sd	a0,-40(s0)
     27a:	87ae                	mv	a5,a1
     27c:	8732                	mv	a4,a2
     27e:	fcf42a23          	sw	a5,-44(s0)
     282:	87ba                	mv	a5,a4
     284:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     288:	fd843783          	ld	a5,-40(s0)
     28c:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     290:	fe042623          	sw	zero,-20(s0)
     294:	a00d                	j	2b6 <memset+0x46>
    cdst[i] = c;
     296:	fec42783          	lw	a5,-20(s0)
     29a:	fe043703          	ld	a4,-32(s0)
     29e:	97ba                	add	a5,a5,a4
     2a0:	fd442703          	lw	a4,-44(s0)
     2a4:	0ff77713          	andi	a4,a4,255
     2a8:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     2ac:	fec42783          	lw	a5,-20(s0)
     2b0:	2785                	addiw	a5,a5,1
     2b2:	fef42623          	sw	a5,-20(s0)
     2b6:	fec42703          	lw	a4,-20(s0)
     2ba:	fd042783          	lw	a5,-48(s0)
     2be:	2781                	sext.w	a5,a5
     2c0:	fcf76be3          	bltu	a4,a5,296 <memset+0x26>
  }
  return dst;
     2c4:	fd843783          	ld	a5,-40(s0)
}
     2c8:	853e                	mv	a0,a5
     2ca:	7422                	ld	s0,40(sp)
     2cc:	6145                	addi	sp,sp,48
     2ce:	8082                	ret

00000000000002d0 <strchr>:

char*
strchr(const char *s, char c)
{
     2d0:	1101                	addi	sp,sp,-32
     2d2:	ec22                	sd	s0,24(sp)
     2d4:	1000                	addi	s0,sp,32
     2d6:	fea43423          	sd	a0,-24(s0)
     2da:	87ae                	mv	a5,a1
     2dc:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     2e0:	a01d                	j	306 <strchr+0x36>
    if(*s == c)
     2e2:	fe843783          	ld	a5,-24(s0)
     2e6:	0007c703          	lbu	a4,0(a5)
     2ea:	fe744783          	lbu	a5,-25(s0)
     2ee:	0ff7f793          	andi	a5,a5,255
     2f2:	00e79563          	bne	a5,a4,2fc <strchr+0x2c>
      return (char*)s;
     2f6:	fe843783          	ld	a5,-24(s0)
     2fa:	a821                	j	312 <strchr+0x42>
  for(; *s; s++)
     2fc:	fe843783          	ld	a5,-24(s0)
     300:	0785                	addi	a5,a5,1
     302:	fef43423          	sd	a5,-24(s0)
     306:	fe843783          	ld	a5,-24(s0)
     30a:	0007c783          	lbu	a5,0(a5)
     30e:	fbf1                	bnez	a5,2e2 <strchr+0x12>
  return 0;
     310:	4781                	li	a5,0
}
     312:	853e                	mv	a0,a5
     314:	6462                	ld	s0,24(sp)
     316:	6105                	addi	sp,sp,32
     318:	8082                	ret

000000000000031a <gets>:

char*
gets(char *buf, int max)
{
     31a:	7179                	addi	sp,sp,-48
     31c:	f406                	sd	ra,40(sp)
     31e:	f022                	sd	s0,32(sp)
     320:	1800                	addi	s0,sp,48
     322:	fca43c23          	sd	a0,-40(s0)
     326:	87ae                	mv	a5,a1
     328:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     32c:	fe042623          	sw	zero,-20(s0)
     330:	a8a1                	j	388 <gets+0x6e>
    cc = read(0, &c, 1);
     332:	fe740793          	addi	a5,s0,-25
     336:	4605                	li	a2,1
     338:	85be                	mv	a1,a5
     33a:	4501                	li	a0,0
     33c:	00000097          	auipc	ra,0x0
     340:	2f6080e7          	jalr	758(ra) # 632 <read>
     344:	87aa                	mv	a5,a0
     346:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     34a:	fe842783          	lw	a5,-24(s0)
     34e:	2781                	sext.w	a5,a5
     350:	04f05763          	blez	a5,39e <gets+0x84>
      break;
    buf[i++] = c;
     354:	fec42783          	lw	a5,-20(s0)
     358:	0017871b          	addiw	a4,a5,1
     35c:	fee42623          	sw	a4,-20(s0)
     360:	873e                	mv	a4,a5
     362:	fd843783          	ld	a5,-40(s0)
     366:	97ba                	add	a5,a5,a4
     368:	fe744703          	lbu	a4,-25(s0)
     36c:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     370:	fe744783          	lbu	a5,-25(s0)
     374:	873e                	mv	a4,a5
     376:	47a9                	li	a5,10
     378:	02f70463          	beq	a4,a5,3a0 <gets+0x86>
     37c:	fe744783          	lbu	a5,-25(s0)
     380:	873e                	mv	a4,a5
     382:	47b5                	li	a5,13
     384:	00f70e63          	beq	a4,a5,3a0 <gets+0x86>
  for(i=0; i+1 < max; ){
     388:	fec42783          	lw	a5,-20(s0)
     38c:	2785                	addiw	a5,a5,1
     38e:	0007871b          	sext.w	a4,a5
     392:	fd442783          	lw	a5,-44(s0)
     396:	2781                	sext.w	a5,a5
     398:	f8f74de3          	blt	a4,a5,332 <gets+0x18>
     39c:	a011                	j	3a0 <gets+0x86>
      break;
     39e:	0001                	nop
      break;
  }
  buf[i] = '\0';
     3a0:	fec42783          	lw	a5,-20(s0)
     3a4:	fd843703          	ld	a4,-40(s0)
     3a8:	97ba                	add	a5,a5,a4
     3aa:	00078023          	sb	zero,0(a5)
  return buf;
     3ae:	fd843783          	ld	a5,-40(s0)
}
     3b2:	853e                	mv	a0,a5
     3b4:	70a2                	ld	ra,40(sp)
     3b6:	7402                	ld	s0,32(sp)
     3b8:	6145                	addi	sp,sp,48
     3ba:	8082                	ret

00000000000003bc <stat>:

int
stat(const char *n, struct stat *st)
{
     3bc:	7179                	addi	sp,sp,-48
     3be:	f406                	sd	ra,40(sp)
     3c0:	f022                	sd	s0,32(sp)
     3c2:	1800                	addi	s0,sp,48
     3c4:	fca43c23          	sd	a0,-40(s0)
     3c8:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     3cc:	4581                	li	a1,0
     3ce:	fd843503          	ld	a0,-40(s0)
     3d2:	00000097          	auipc	ra,0x0
     3d6:	288080e7          	jalr	648(ra) # 65a <open>
     3da:	87aa                	mv	a5,a0
     3dc:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     3e0:	fec42783          	lw	a5,-20(s0)
     3e4:	2781                	sext.w	a5,a5
     3e6:	0007d463          	bgez	a5,3ee <stat+0x32>
    return -1;
     3ea:	57fd                	li	a5,-1
     3ec:	a035                	j	418 <stat+0x5c>
  r = fstat(fd, st);
     3ee:	fec42783          	lw	a5,-20(s0)
     3f2:	fd043583          	ld	a1,-48(s0)
     3f6:	853e                	mv	a0,a5
     3f8:	00000097          	auipc	ra,0x0
     3fc:	27a080e7          	jalr	634(ra) # 672 <fstat>
     400:	87aa                	mv	a5,a0
     402:	fef42423          	sw	a5,-24(s0)
  close(fd);
     406:	fec42783          	lw	a5,-20(s0)
     40a:	853e                	mv	a0,a5
     40c:	00000097          	auipc	ra,0x0
     410:	236080e7          	jalr	566(ra) # 642 <close>
  return r;
     414:	fe842783          	lw	a5,-24(s0)
}
     418:	853e                	mv	a0,a5
     41a:	70a2                	ld	ra,40(sp)
     41c:	7402                	ld	s0,32(sp)
     41e:	6145                	addi	sp,sp,48
     420:	8082                	ret

0000000000000422 <atoi>:

int
atoi(const char *s)
{
     422:	7179                	addi	sp,sp,-48
     424:	f422                	sd	s0,40(sp)
     426:	1800                	addi	s0,sp,48
     428:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     42c:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     430:	a815                	j	464 <atoi+0x42>
    n = n*10 + *s++ - '0';
     432:	fec42703          	lw	a4,-20(s0)
     436:	87ba                	mv	a5,a4
     438:	0027979b          	slliw	a5,a5,0x2
     43c:	9fb9                	addw	a5,a5,a4
     43e:	0017979b          	slliw	a5,a5,0x1
     442:	0007871b          	sext.w	a4,a5
     446:	fd843783          	ld	a5,-40(s0)
     44a:	00178693          	addi	a3,a5,1
     44e:	fcd43c23          	sd	a3,-40(s0)
     452:	0007c783          	lbu	a5,0(a5)
     456:	2781                	sext.w	a5,a5
     458:	9fb9                	addw	a5,a5,a4
     45a:	2781                	sext.w	a5,a5
     45c:	fd07879b          	addiw	a5,a5,-48
     460:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     464:	fd843783          	ld	a5,-40(s0)
     468:	0007c783          	lbu	a5,0(a5)
     46c:	873e                	mv	a4,a5
     46e:	02f00793          	li	a5,47
     472:	00e7fb63          	bgeu	a5,a4,488 <atoi+0x66>
     476:	fd843783          	ld	a5,-40(s0)
     47a:	0007c783          	lbu	a5,0(a5)
     47e:	873e                	mv	a4,a5
     480:	03900793          	li	a5,57
     484:	fae7f7e3          	bgeu	a5,a4,432 <atoi+0x10>
  return n;
     488:	fec42783          	lw	a5,-20(s0)
}
     48c:	853e                	mv	a0,a5
     48e:	7422                	ld	s0,40(sp)
     490:	6145                	addi	sp,sp,48
     492:	8082                	ret

0000000000000494 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     494:	7139                	addi	sp,sp,-64
     496:	fc22                	sd	s0,56(sp)
     498:	0080                	addi	s0,sp,64
     49a:	fca43c23          	sd	a0,-40(s0)
     49e:	fcb43823          	sd	a1,-48(s0)
     4a2:	87b2                	mv	a5,a2
     4a4:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     4a8:	fd843783          	ld	a5,-40(s0)
     4ac:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     4b0:	fd043783          	ld	a5,-48(s0)
     4b4:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     4b8:	fe043703          	ld	a4,-32(s0)
     4bc:	fe843783          	ld	a5,-24(s0)
     4c0:	02e7fc63          	bgeu	a5,a4,4f8 <memmove+0x64>
    while(n-- > 0)
     4c4:	a00d                	j	4e6 <memmove+0x52>
      *dst++ = *src++;
     4c6:	fe043703          	ld	a4,-32(s0)
     4ca:	00170793          	addi	a5,a4,1
     4ce:	fef43023          	sd	a5,-32(s0)
     4d2:	fe843783          	ld	a5,-24(s0)
     4d6:	00178693          	addi	a3,a5,1
     4da:	fed43423          	sd	a3,-24(s0)
     4de:	00074703          	lbu	a4,0(a4)
     4e2:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     4e6:	fcc42783          	lw	a5,-52(s0)
     4ea:	fff7871b          	addiw	a4,a5,-1
     4ee:	fce42623          	sw	a4,-52(s0)
     4f2:	fcf04ae3          	bgtz	a5,4c6 <memmove+0x32>
     4f6:	a891                	j	54a <memmove+0xb6>
  } else {
    dst += n;
     4f8:	fcc42783          	lw	a5,-52(s0)
     4fc:	fe843703          	ld	a4,-24(s0)
     500:	97ba                	add	a5,a5,a4
     502:	fef43423          	sd	a5,-24(s0)
    src += n;
     506:	fcc42783          	lw	a5,-52(s0)
     50a:	fe043703          	ld	a4,-32(s0)
     50e:	97ba                	add	a5,a5,a4
     510:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     514:	a01d                	j	53a <memmove+0xa6>
      *--dst = *--src;
     516:	fe043783          	ld	a5,-32(s0)
     51a:	17fd                	addi	a5,a5,-1
     51c:	fef43023          	sd	a5,-32(s0)
     520:	fe843783          	ld	a5,-24(s0)
     524:	17fd                	addi	a5,a5,-1
     526:	fef43423          	sd	a5,-24(s0)
     52a:	fe043783          	ld	a5,-32(s0)
     52e:	0007c703          	lbu	a4,0(a5)
     532:	fe843783          	ld	a5,-24(s0)
     536:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     53a:	fcc42783          	lw	a5,-52(s0)
     53e:	fff7871b          	addiw	a4,a5,-1
     542:	fce42623          	sw	a4,-52(s0)
     546:	fcf048e3          	bgtz	a5,516 <memmove+0x82>
  }
  return vdst;
     54a:	fd843783          	ld	a5,-40(s0)
}
     54e:	853e                	mv	a0,a5
     550:	7462                	ld	s0,56(sp)
     552:	6121                	addi	sp,sp,64
     554:	8082                	ret

0000000000000556 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     556:	7139                	addi	sp,sp,-64
     558:	fc22                	sd	s0,56(sp)
     55a:	0080                	addi	s0,sp,64
     55c:	fca43c23          	sd	a0,-40(s0)
     560:	fcb43823          	sd	a1,-48(s0)
     564:	87b2                	mv	a5,a2
     566:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     56a:	fd843783          	ld	a5,-40(s0)
     56e:	fef43423          	sd	a5,-24(s0)
     572:	fd043783          	ld	a5,-48(s0)
     576:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     57a:	a0a1                	j	5c2 <memcmp+0x6c>
    if (*p1 != *p2) {
     57c:	fe843783          	ld	a5,-24(s0)
     580:	0007c703          	lbu	a4,0(a5)
     584:	fe043783          	ld	a5,-32(s0)
     588:	0007c783          	lbu	a5,0(a5)
     58c:	02f70163          	beq	a4,a5,5ae <memcmp+0x58>
      return *p1 - *p2;
     590:	fe843783          	ld	a5,-24(s0)
     594:	0007c783          	lbu	a5,0(a5)
     598:	0007871b          	sext.w	a4,a5
     59c:	fe043783          	ld	a5,-32(s0)
     5a0:	0007c783          	lbu	a5,0(a5)
     5a4:	2781                	sext.w	a5,a5
     5a6:	40f707bb          	subw	a5,a4,a5
     5aa:	2781                	sext.w	a5,a5
     5ac:	a01d                	j	5d2 <memcmp+0x7c>
    }
    p1++;
     5ae:	fe843783          	ld	a5,-24(s0)
     5b2:	0785                	addi	a5,a5,1
     5b4:	fef43423          	sd	a5,-24(s0)
    p2++;
     5b8:	fe043783          	ld	a5,-32(s0)
     5bc:	0785                	addi	a5,a5,1
     5be:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     5c2:	fcc42783          	lw	a5,-52(s0)
     5c6:	fff7871b          	addiw	a4,a5,-1
     5ca:	fce42623          	sw	a4,-52(s0)
     5ce:	f7dd                	bnez	a5,57c <memcmp+0x26>
  }
  return 0;
     5d0:	4781                	li	a5,0
}
     5d2:	853e                	mv	a0,a5
     5d4:	7462                	ld	s0,56(sp)
     5d6:	6121                	addi	sp,sp,64
     5d8:	8082                	ret

00000000000005da <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     5da:	7179                	addi	sp,sp,-48
     5dc:	f406                	sd	ra,40(sp)
     5de:	f022                	sd	s0,32(sp)
     5e0:	1800                	addi	s0,sp,48
     5e2:	fea43423          	sd	a0,-24(s0)
     5e6:	feb43023          	sd	a1,-32(s0)
     5ea:	87b2                	mv	a5,a2
     5ec:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     5f0:	fdc42783          	lw	a5,-36(s0)
     5f4:	863e                	mv	a2,a5
     5f6:	fe043583          	ld	a1,-32(s0)
     5fa:	fe843503          	ld	a0,-24(s0)
     5fe:	00000097          	auipc	ra,0x0
     602:	e96080e7          	jalr	-362(ra) # 494 <memmove>
     606:	87aa                	mv	a5,a0
}
     608:	853e                	mv	a0,a5
     60a:	70a2                	ld	ra,40(sp)
     60c:	7402                	ld	s0,32(sp)
     60e:	6145                	addi	sp,sp,48
     610:	8082                	ret

0000000000000612 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     612:	4885                	li	a7,1
 ecall
     614:	00000073          	ecall
 ret
     618:	8082                	ret

000000000000061a <exit>:
.global exit
exit:
 li a7, SYS_exit
     61a:	4889                	li	a7,2
 ecall
     61c:	00000073          	ecall
 ret
     620:	8082                	ret

0000000000000622 <wait>:
.global wait
wait:
 li a7, SYS_wait
     622:	488d                	li	a7,3
 ecall
     624:	00000073          	ecall
 ret
     628:	8082                	ret

000000000000062a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     62a:	4891                	li	a7,4
 ecall
     62c:	00000073          	ecall
 ret
     630:	8082                	ret

0000000000000632 <read>:
.global read
read:
 li a7, SYS_read
     632:	4895                	li	a7,5
 ecall
     634:	00000073          	ecall
 ret
     638:	8082                	ret

000000000000063a <write>:
.global write
write:
 li a7, SYS_write
     63a:	48c1                	li	a7,16
 ecall
     63c:	00000073          	ecall
 ret
     640:	8082                	ret

0000000000000642 <close>:
.global close
close:
 li a7, SYS_close
     642:	48d5                	li	a7,21
 ecall
     644:	00000073          	ecall
 ret
     648:	8082                	ret

000000000000064a <kill>:
.global kill
kill:
 li a7, SYS_kill
     64a:	4899                	li	a7,6
 ecall
     64c:	00000073          	ecall
 ret
     650:	8082                	ret

0000000000000652 <exec>:
.global exec
exec:
 li a7, SYS_exec
     652:	489d                	li	a7,7
 ecall
     654:	00000073          	ecall
 ret
     658:	8082                	ret

000000000000065a <open>:
.global open
open:
 li a7, SYS_open
     65a:	48bd                	li	a7,15
 ecall
     65c:	00000073          	ecall
 ret
     660:	8082                	ret

0000000000000662 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     662:	48c5                	li	a7,17
 ecall
     664:	00000073          	ecall
 ret
     668:	8082                	ret

000000000000066a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     66a:	48c9                	li	a7,18
 ecall
     66c:	00000073          	ecall
 ret
     670:	8082                	ret

0000000000000672 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     672:	48a1                	li	a7,8
 ecall
     674:	00000073          	ecall
 ret
     678:	8082                	ret

000000000000067a <link>:
.global link
link:
 li a7, SYS_link
     67a:	48cd                	li	a7,19
 ecall
     67c:	00000073          	ecall
 ret
     680:	8082                	ret

0000000000000682 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     682:	48d1                	li	a7,20
 ecall
     684:	00000073          	ecall
 ret
     688:	8082                	ret

000000000000068a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     68a:	48a5                	li	a7,9
 ecall
     68c:	00000073          	ecall
 ret
     690:	8082                	ret

0000000000000692 <dup>:
.global dup
dup:
 li a7, SYS_dup
     692:	48a9                	li	a7,10
 ecall
     694:	00000073          	ecall
 ret
     698:	8082                	ret

000000000000069a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     69a:	48ad                	li	a7,11
 ecall
     69c:	00000073          	ecall
 ret
     6a0:	8082                	ret

00000000000006a2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     6a2:	48b1                	li	a7,12
 ecall
     6a4:	00000073          	ecall
 ret
     6a8:	8082                	ret

00000000000006aa <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     6aa:	48b5                	li	a7,13
 ecall
     6ac:	00000073          	ecall
 ret
     6b0:	8082                	ret

00000000000006b2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     6b2:	48b9                	li	a7,14
 ecall
     6b4:	00000073          	ecall
 ret
     6b8:	8082                	ret

00000000000006ba <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     6ba:	48d9                	li	a7,22
 ecall
     6bc:	00000073          	ecall
 ret
     6c0:	8082                	ret

00000000000006c2 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     6c2:	48dd                	li	a7,23
 ecall
     6c4:	00000073          	ecall
 ret
     6c8:	8082                	ret

00000000000006ca <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     6ca:	48e1                	li	a7,24
 ecall
     6cc:	00000073          	ecall
 ret
     6d0:	8082                	ret

00000000000006d2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     6d2:	1101                	addi	sp,sp,-32
     6d4:	ec06                	sd	ra,24(sp)
     6d6:	e822                	sd	s0,16(sp)
     6d8:	1000                	addi	s0,sp,32
     6da:	87aa                	mv	a5,a0
     6dc:	872e                	mv	a4,a1
     6de:	fef42623          	sw	a5,-20(s0)
     6e2:	87ba                	mv	a5,a4
     6e4:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     6e8:	feb40713          	addi	a4,s0,-21
     6ec:	fec42783          	lw	a5,-20(s0)
     6f0:	4605                	li	a2,1
     6f2:	85ba                	mv	a1,a4
     6f4:	853e                	mv	a0,a5
     6f6:	00000097          	auipc	ra,0x0
     6fa:	f44080e7          	jalr	-188(ra) # 63a <write>
}
     6fe:	0001                	nop
     700:	60e2                	ld	ra,24(sp)
     702:	6442                	ld	s0,16(sp)
     704:	6105                	addi	sp,sp,32
     706:	8082                	ret

0000000000000708 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     708:	7139                	addi	sp,sp,-64
     70a:	fc06                	sd	ra,56(sp)
     70c:	f822                	sd	s0,48(sp)
     70e:	0080                	addi	s0,sp,64
     710:	87aa                	mv	a5,a0
     712:	8736                	mv	a4,a3
     714:	fcf42623          	sw	a5,-52(s0)
     718:	87ae                	mv	a5,a1
     71a:	fcf42423          	sw	a5,-56(s0)
     71e:	87b2                	mv	a5,a2
     720:	fcf42223          	sw	a5,-60(s0)
     724:	87ba                	mv	a5,a4
     726:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     72a:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     72e:	fc042783          	lw	a5,-64(s0)
     732:	2781                	sext.w	a5,a5
     734:	c38d                	beqz	a5,756 <printint+0x4e>
     736:	fc842783          	lw	a5,-56(s0)
     73a:	2781                	sext.w	a5,a5
     73c:	0007dd63          	bgez	a5,756 <printint+0x4e>
    neg = 1;
     740:	4785                	li	a5,1
     742:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     746:	fc842783          	lw	a5,-56(s0)
     74a:	40f007bb          	negw	a5,a5
     74e:	2781                	sext.w	a5,a5
     750:	fef42223          	sw	a5,-28(s0)
     754:	a029                	j	75e <printint+0x56>
  } else {
    x = xx;
     756:	fc842783          	lw	a5,-56(s0)
     75a:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     75e:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     762:	fc442783          	lw	a5,-60(s0)
     766:	fe442703          	lw	a4,-28(s0)
     76a:	02f777bb          	remuw	a5,a4,a5
     76e:	0007861b          	sext.w	a2,a5
     772:	fec42783          	lw	a5,-20(s0)
     776:	0017871b          	addiw	a4,a5,1
     77a:	fee42623          	sw	a4,-20(s0)
     77e:	00001697          	auipc	a3,0x1
     782:	eca68693          	addi	a3,a3,-310 # 1648 <digits>
     786:	02061713          	slli	a4,a2,0x20
     78a:	9301                	srli	a4,a4,0x20
     78c:	9736                	add	a4,a4,a3
     78e:	00074703          	lbu	a4,0(a4)
     792:	ff040693          	addi	a3,s0,-16
     796:	97b6                	add	a5,a5,a3
     798:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     79c:	fc442783          	lw	a5,-60(s0)
     7a0:	fe442703          	lw	a4,-28(s0)
     7a4:	02f757bb          	divuw	a5,a4,a5
     7a8:	fef42223          	sw	a5,-28(s0)
     7ac:	fe442783          	lw	a5,-28(s0)
     7b0:	2781                	sext.w	a5,a5
     7b2:	fbc5                	bnez	a5,762 <printint+0x5a>
  if(neg)
     7b4:	fe842783          	lw	a5,-24(s0)
     7b8:	2781                	sext.w	a5,a5
     7ba:	cf95                	beqz	a5,7f6 <printint+0xee>
    buf[i++] = '-';
     7bc:	fec42783          	lw	a5,-20(s0)
     7c0:	0017871b          	addiw	a4,a5,1
     7c4:	fee42623          	sw	a4,-20(s0)
     7c8:	ff040713          	addi	a4,s0,-16
     7cc:	97ba                	add	a5,a5,a4
     7ce:	02d00713          	li	a4,45
     7d2:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     7d6:	a005                	j	7f6 <printint+0xee>
    putc(fd, buf[i]);
     7d8:	fec42783          	lw	a5,-20(s0)
     7dc:	ff040713          	addi	a4,s0,-16
     7e0:	97ba                	add	a5,a5,a4
     7e2:	fe07c703          	lbu	a4,-32(a5)
     7e6:	fcc42783          	lw	a5,-52(s0)
     7ea:	85ba                	mv	a1,a4
     7ec:	853e                	mv	a0,a5
     7ee:	00000097          	auipc	ra,0x0
     7f2:	ee4080e7          	jalr	-284(ra) # 6d2 <putc>
  while(--i >= 0)
     7f6:	fec42783          	lw	a5,-20(s0)
     7fa:	37fd                	addiw	a5,a5,-1
     7fc:	fef42623          	sw	a5,-20(s0)
     800:	fec42783          	lw	a5,-20(s0)
     804:	2781                	sext.w	a5,a5
     806:	fc07d9e3          	bgez	a5,7d8 <printint+0xd0>
}
     80a:	0001                	nop
     80c:	0001                	nop
     80e:	70e2                	ld	ra,56(sp)
     810:	7442                	ld	s0,48(sp)
     812:	6121                	addi	sp,sp,64
     814:	8082                	ret

0000000000000816 <printptr>:

static void
printptr(int fd, uint64 x) {
     816:	7179                	addi	sp,sp,-48
     818:	f406                	sd	ra,40(sp)
     81a:	f022                	sd	s0,32(sp)
     81c:	1800                	addi	s0,sp,48
     81e:	87aa                	mv	a5,a0
     820:	fcb43823          	sd	a1,-48(s0)
     824:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     828:	fdc42783          	lw	a5,-36(s0)
     82c:	03000593          	li	a1,48
     830:	853e                	mv	a0,a5
     832:	00000097          	auipc	ra,0x0
     836:	ea0080e7          	jalr	-352(ra) # 6d2 <putc>
  putc(fd, 'x');
     83a:	fdc42783          	lw	a5,-36(s0)
     83e:	07800593          	li	a1,120
     842:	853e                	mv	a0,a5
     844:	00000097          	auipc	ra,0x0
     848:	e8e080e7          	jalr	-370(ra) # 6d2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     84c:	fe042623          	sw	zero,-20(s0)
     850:	a82d                	j	88a <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     852:	fd043783          	ld	a5,-48(s0)
     856:	93f1                	srli	a5,a5,0x3c
     858:	00001717          	auipc	a4,0x1
     85c:	df070713          	addi	a4,a4,-528 # 1648 <digits>
     860:	97ba                	add	a5,a5,a4
     862:	0007c703          	lbu	a4,0(a5)
     866:	fdc42783          	lw	a5,-36(s0)
     86a:	85ba                	mv	a1,a4
     86c:	853e                	mv	a0,a5
     86e:	00000097          	auipc	ra,0x0
     872:	e64080e7          	jalr	-412(ra) # 6d2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     876:	fec42783          	lw	a5,-20(s0)
     87a:	2785                	addiw	a5,a5,1
     87c:	fef42623          	sw	a5,-20(s0)
     880:	fd043783          	ld	a5,-48(s0)
     884:	0792                	slli	a5,a5,0x4
     886:	fcf43823          	sd	a5,-48(s0)
     88a:	fec42783          	lw	a5,-20(s0)
     88e:	873e                	mv	a4,a5
     890:	47bd                	li	a5,15
     892:	fce7f0e3          	bgeu	a5,a4,852 <printptr+0x3c>
}
     896:	0001                	nop
     898:	0001                	nop
     89a:	70a2                	ld	ra,40(sp)
     89c:	7402                	ld	s0,32(sp)
     89e:	6145                	addi	sp,sp,48
     8a0:	8082                	ret

00000000000008a2 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     8a2:	715d                	addi	sp,sp,-80
     8a4:	e486                	sd	ra,72(sp)
     8a6:	e0a2                	sd	s0,64(sp)
     8a8:	0880                	addi	s0,sp,80
     8aa:	87aa                	mv	a5,a0
     8ac:	fcb43023          	sd	a1,-64(s0)
     8b0:	fac43c23          	sd	a2,-72(s0)
     8b4:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     8b8:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     8bc:	fe042223          	sw	zero,-28(s0)
     8c0:	a42d                	j	aea <vprintf+0x248>
    c = fmt[i] & 0xff;
     8c2:	fe442783          	lw	a5,-28(s0)
     8c6:	fc043703          	ld	a4,-64(s0)
     8ca:	97ba                	add	a5,a5,a4
     8cc:	0007c783          	lbu	a5,0(a5)
     8d0:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     8d4:	fe042783          	lw	a5,-32(s0)
     8d8:	2781                	sext.w	a5,a5
     8da:	eb9d                	bnez	a5,910 <vprintf+0x6e>
      if(c == '%'){
     8dc:	fdc42783          	lw	a5,-36(s0)
     8e0:	0007871b          	sext.w	a4,a5
     8e4:	02500793          	li	a5,37
     8e8:	00f71763          	bne	a4,a5,8f6 <vprintf+0x54>
        state = '%';
     8ec:	02500793          	li	a5,37
     8f0:	fef42023          	sw	a5,-32(s0)
     8f4:	a2f5                	j	ae0 <vprintf+0x23e>
      } else {
        putc(fd, c);
     8f6:	fdc42783          	lw	a5,-36(s0)
     8fa:	0ff7f713          	andi	a4,a5,255
     8fe:	fcc42783          	lw	a5,-52(s0)
     902:	85ba                	mv	a1,a4
     904:	853e                	mv	a0,a5
     906:	00000097          	auipc	ra,0x0
     90a:	dcc080e7          	jalr	-564(ra) # 6d2 <putc>
     90e:	aac9                	j	ae0 <vprintf+0x23e>
      }
    } else if(state == '%'){
     910:	fe042783          	lw	a5,-32(s0)
     914:	0007871b          	sext.w	a4,a5
     918:	02500793          	li	a5,37
     91c:	1cf71263          	bne	a4,a5,ae0 <vprintf+0x23e>
      if(c == 'd'){
     920:	fdc42783          	lw	a5,-36(s0)
     924:	0007871b          	sext.w	a4,a5
     928:	06400793          	li	a5,100
     92c:	02f71463          	bne	a4,a5,954 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     930:	fb843783          	ld	a5,-72(s0)
     934:	00878713          	addi	a4,a5,8
     938:	fae43c23          	sd	a4,-72(s0)
     93c:	4398                	lw	a4,0(a5)
     93e:	fcc42783          	lw	a5,-52(s0)
     942:	4685                	li	a3,1
     944:	4629                	li	a2,10
     946:	85ba                	mv	a1,a4
     948:	853e                	mv	a0,a5
     94a:	00000097          	auipc	ra,0x0
     94e:	dbe080e7          	jalr	-578(ra) # 708 <printint>
     952:	a269                	j	adc <vprintf+0x23a>
      } else if(c == 'l') {
     954:	fdc42783          	lw	a5,-36(s0)
     958:	0007871b          	sext.w	a4,a5
     95c:	06c00793          	li	a5,108
     960:	02f71663          	bne	a4,a5,98c <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     964:	fb843783          	ld	a5,-72(s0)
     968:	00878713          	addi	a4,a5,8
     96c:	fae43c23          	sd	a4,-72(s0)
     970:	639c                	ld	a5,0(a5)
     972:	0007871b          	sext.w	a4,a5
     976:	fcc42783          	lw	a5,-52(s0)
     97a:	4681                	li	a3,0
     97c:	4629                	li	a2,10
     97e:	85ba                	mv	a1,a4
     980:	853e                	mv	a0,a5
     982:	00000097          	auipc	ra,0x0
     986:	d86080e7          	jalr	-634(ra) # 708 <printint>
     98a:	aa89                	j	adc <vprintf+0x23a>
      } else if(c == 'x') {
     98c:	fdc42783          	lw	a5,-36(s0)
     990:	0007871b          	sext.w	a4,a5
     994:	07800793          	li	a5,120
     998:	02f71463          	bne	a4,a5,9c0 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     99c:	fb843783          	ld	a5,-72(s0)
     9a0:	00878713          	addi	a4,a5,8
     9a4:	fae43c23          	sd	a4,-72(s0)
     9a8:	4398                	lw	a4,0(a5)
     9aa:	fcc42783          	lw	a5,-52(s0)
     9ae:	4681                	li	a3,0
     9b0:	4641                	li	a2,16
     9b2:	85ba                	mv	a1,a4
     9b4:	853e                	mv	a0,a5
     9b6:	00000097          	auipc	ra,0x0
     9ba:	d52080e7          	jalr	-686(ra) # 708 <printint>
     9be:	aa39                	j	adc <vprintf+0x23a>
      } else if(c == 'p') {
     9c0:	fdc42783          	lw	a5,-36(s0)
     9c4:	0007871b          	sext.w	a4,a5
     9c8:	07000793          	li	a5,112
     9cc:	02f71263          	bne	a4,a5,9f0 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     9d0:	fb843783          	ld	a5,-72(s0)
     9d4:	00878713          	addi	a4,a5,8
     9d8:	fae43c23          	sd	a4,-72(s0)
     9dc:	6398                	ld	a4,0(a5)
     9de:	fcc42783          	lw	a5,-52(s0)
     9e2:	85ba                	mv	a1,a4
     9e4:	853e                	mv	a0,a5
     9e6:	00000097          	auipc	ra,0x0
     9ea:	e30080e7          	jalr	-464(ra) # 816 <printptr>
     9ee:	a0fd                	j	adc <vprintf+0x23a>
      } else if(c == 's'){
     9f0:	fdc42783          	lw	a5,-36(s0)
     9f4:	0007871b          	sext.w	a4,a5
     9f8:	07300793          	li	a5,115
     9fc:	04f71c63          	bne	a4,a5,a54 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     a00:	fb843783          	ld	a5,-72(s0)
     a04:	00878713          	addi	a4,a5,8
     a08:	fae43c23          	sd	a4,-72(s0)
     a0c:	639c                	ld	a5,0(a5)
     a0e:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     a12:	fe843783          	ld	a5,-24(s0)
     a16:	eb8d                	bnez	a5,a48 <vprintf+0x1a6>
          s = "(null)";
     a18:	00001797          	auipc	a5,0x1
     a1c:	c2878793          	addi	a5,a5,-984 # 1640 <schedule_dm+0x250>
     a20:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     a24:	a015                	j	a48 <vprintf+0x1a6>
          putc(fd, *s);
     a26:	fe843783          	ld	a5,-24(s0)
     a2a:	0007c703          	lbu	a4,0(a5)
     a2e:	fcc42783          	lw	a5,-52(s0)
     a32:	85ba                	mv	a1,a4
     a34:	853e                	mv	a0,a5
     a36:	00000097          	auipc	ra,0x0
     a3a:	c9c080e7          	jalr	-868(ra) # 6d2 <putc>
          s++;
     a3e:	fe843783          	ld	a5,-24(s0)
     a42:	0785                	addi	a5,a5,1
     a44:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     a48:	fe843783          	ld	a5,-24(s0)
     a4c:	0007c783          	lbu	a5,0(a5)
     a50:	fbf9                	bnez	a5,a26 <vprintf+0x184>
     a52:	a069                	j	adc <vprintf+0x23a>
        }
      } else if(c == 'c'){
     a54:	fdc42783          	lw	a5,-36(s0)
     a58:	0007871b          	sext.w	a4,a5
     a5c:	06300793          	li	a5,99
     a60:	02f71463          	bne	a4,a5,a88 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     a64:	fb843783          	ld	a5,-72(s0)
     a68:	00878713          	addi	a4,a5,8
     a6c:	fae43c23          	sd	a4,-72(s0)
     a70:	439c                	lw	a5,0(a5)
     a72:	0ff7f713          	andi	a4,a5,255
     a76:	fcc42783          	lw	a5,-52(s0)
     a7a:	85ba                	mv	a1,a4
     a7c:	853e                	mv	a0,a5
     a7e:	00000097          	auipc	ra,0x0
     a82:	c54080e7          	jalr	-940(ra) # 6d2 <putc>
     a86:	a899                	j	adc <vprintf+0x23a>
      } else if(c == '%'){
     a88:	fdc42783          	lw	a5,-36(s0)
     a8c:	0007871b          	sext.w	a4,a5
     a90:	02500793          	li	a5,37
     a94:	00f71f63          	bne	a4,a5,ab2 <vprintf+0x210>
        putc(fd, c);
     a98:	fdc42783          	lw	a5,-36(s0)
     a9c:	0ff7f713          	andi	a4,a5,255
     aa0:	fcc42783          	lw	a5,-52(s0)
     aa4:	85ba                	mv	a1,a4
     aa6:	853e                	mv	a0,a5
     aa8:	00000097          	auipc	ra,0x0
     aac:	c2a080e7          	jalr	-982(ra) # 6d2 <putc>
     ab0:	a035                	j	adc <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     ab2:	fcc42783          	lw	a5,-52(s0)
     ab6:	02500593          	li	a1,37
     aba:	853e                	mv	a0,a5
     abc:	00000097          	auipc	ra,0x0
     ac0:	c16080e7          	jalr	-1002(ra) # 6d2 <putc>
        putc(fd, c);
     ac4:	fdc42783          	lw	a5,-36(s0)
     ac8:	0ff7f713          	andi	a4,a5,255
     acc:	fcc42783          	lw	a5,-52(s0)
     ad0:	85ba                	mv	a1,a4
     ad2:	853e                	mv	a0,a5
     ad4:	00000097          	auipc	ra,0x0
     ad8:	bfe080e7          	jalr	-1026(ra) # 6d2 <putc>
      }
      state = 0;
     adc:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     ae0:	fe442783          	lw	a5,-28(s0)
     ae4:	2785                	addiw	a5,a5,1
     ae6:	fef42223          	sw	a5,-28(s0)
     aea:	fe442783          	lw	a5,-28(s0)
     aee:	fc043703          	ld	a4,-64(s0)
     af2:	97ba                	add	a5,a5,a4
     af4:	0007c783          	lbu	a5,0(a5)
     af8:	dc0795e3          	bnez	a5,8c2 <vprintf+0x20>
    }
  }
}
     afc:	0001                	nop
     afe:	0001                	nop
     b00:	60a6                	ld	ra,72(sp)
     b02:	6406                	ld	s0,64(sp)
     b04:	6161                	addi	sp,sp,80
     b06:	8082                	ret

0000000000000b08 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     b08:	7159                	addi	sp,sp,-112
     b0a:	fc06                	sd	ra,56(sp)
     b0c:	f822                	sd	s0,48(sp)
     b0e:	0080                	addi	s0,sp,64
     b10:	fcb43823          	sd	a1,-48(s0)
     b14:	e010                	sd	a2,0(s0)
     b16:	e414                	sd	a3,8(s0)
     b18:	e818                	sd	a4,16(s0)
     b1a:	ec1c                	sd	a5,24(s0)
     b1c:	03043023          	sd	a6,32(s0)
     b20:	03143423          	sd	a7,40(s0)
     b24:	87aa                	mv	a5,a0
     b26:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     b2a:	03040793          	addi	a5,s0,48
     b2e:	fcf43423          	sd	a5,-56(s0)
     b32:	fc843783          	ld	a5,-56(s0)
     b36:	fd078793          	addi	a5,a5,-48
     b3a:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     b3e:	fe843703          	ld	a4,-24(s0)
     b42:	fdc42783          	lw	a5,-36(s0)
     b46:	863a                	mv	a2,a4
     b48:	fd043583          	ld	a1,-48(s0)
     b4c:	853e                	mv	a0,a5
     b4e:	00000097          	auipc	ra,0x0
     b52:	d54080e7          	jalr	-684(ra) # 8a2 <vprintf>
}
     b56:	0001                	nop
     b58:	70e2                	ld	ra,56(sp)
     b5a:	7442                	ld	s0,48(sp)
     b5c:	6165                	addi	sp,sp,112
     b5e:	8082                	ret

0000000000000b60 <printf>:

void
printf(const char *fmt, ...)
{
     b60:	7159                	addi	sp,sp,-112
     b62:	f406                	sd	ra,40(sp)
     b64:	f022                	sd	s0,32(sp)
     b66:	1800                	addi	s0,sp,48
     b68:	fca43c23          	sd	a0,-40(s0)
     b6c:	e40c                	sd	a1,8(s0)
     b6e:	e810                	sd	a2,16(s0)
     b70:	ec14                	sd	a3,24(s0)
     b72:	f018                	sd	a4,32(s0)
     b74:	f41c                	sd	a5,40(s0)
     b76:	03043823          	sd	a6,48(s0)
     b7a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     b7e:	04040793          	addi	a5,s0,64
     b82:	fcf43823          	sd	a5,-48(s0)
     b86:	fd043783          	ld	a5,-48(s0)
     b8a:	fc878793          	addi	a5,a5,-56
     b8e:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     b92:	fe843783          	ld	a5,-24(s0)
     b96:	863e                	mv	a2,a5
     b98:	fd843583          	ld	a1,-40(s0)
     b9c:	4505                	li	a0,1
     b9e:	00000097          	auipc	ra,0x0
     ba2:	d04080e7          	jalr	-764(ra) # 8a2 <vprintf>
}
     ba6:	0001                	nop
     ba8:	70a2                	ld	ra,40(sp)
     baa:	7402                	ld	s0,32(sp)
     bac:	6165                	addi	sp,sp,112
     bae:	8082                	ret

0000000000000bb0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     bb0:	7179                	addi	sp,sp,-48
     bb2:	f422                	sd	s0,40(sp)
     bb4:	1800                	addi	s0,sp,48
     bb6:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     bba:	fd843783          	ld	a5,-40(s0)
     bbe:	17c1                	addi	a5,a5,-16
     bc0:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     bc4:	00001797          	auipc	a5,0x1
     bc8:	aac78793          	addi	a5,a5,-1364 # 1670 <freep>
     bcc:	639c                	ld	a5,0(a5)
     bce:	fef43423          	sd	a5,-24(s0)
     bd2:	a815                	j	c06 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     bd4:	fe843783          	ld	a5,-24(s0)
     bd8:	639c                	ld	a5,0(a5)
     bda:	fe843703          	ld	a4,-24(s0)
     bde:	00f76f63          	bltu	a4,a5,bfc <free+0x4c>
     be2:	fe043703          	ld	a4,-32(s0)
     be6:	fe843783          	ld	a5,-24(s0)
     bea:	02e7eb63          	bltu	a5,a4,c20 <free+0x70>
     bee:	fe843783          	ld	a5,-24(s0)
     bf2:	639c                	ld	a5,0(a5)
     bf4:	fe043703          	ld	a4,-32(s0)
     bf8:	02f76463          	bltu	a4,a5,c20 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     bfc:	fe843783          	ld	a5,-24(s0)
     c00:	639c                	ld	a5,0(a5)
     c02:	fef43423          	sd	a5,-24(s0)
     c06:	fe043703          	ld	a4,-32(s0)
     c0a:	fe843783          	ld	a5,-24(s0)
     c0e:	fce7f3e3          	bgeu	a5,a4,bd4 <free+0x24>
     c12:	fe843783          	ld	a5,-24(s0)
     c16:	639c                	ld	a5,0(a5)
     c18:	fe043703          	ld	a4,-32(s0)
     c1c:	faf77ce3          	bgeu	a4,a5,bd4 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     c20:	fe043783          	ld	a5,-32(s0)
     c24:	479c                	lw	a5,8(a5)
     c26:	1782                	slli	a5,a5,0x20
     c28:	9381                	srli	a5,a5,0x20
     c2a:	0792                	slli	a5,a5,0x4
     c2c:	fe043703          	ld	a4,-32(s0)
     c30:	973e                	add	a4,a4,a5
     c32:	fe843783          	ld	a5,-24(s0)
     c36:	639c                	ld	a5,0(a5)
     c38:	02f71763          	bne	a4,a5,c66 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     c3c:	fe043783          	ld	a5,-32(s0)
     c40:	4798                	lw	a4,8(a5)
     c42:	fe843783          	ld	a5,-24(s0)
     c46:	639c                	ld	a5,0(a5)
     c48:	479c                	lw	a5,8(a5)
     c4a:	9fb9                	addw	a5,a5,a4
     c4c:	0007871b          	sext.w	a4,a5
     c50:	fe043783          	ld	a5,-32(s0)
     c54:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     c56:	fe843783          	ld	a5,-24(s0)
     c5a:	639c                	ld	a5,0(a5)
     c5c:	6398                	ld	a4,0(a5)
     c5e:	fe043783          	ld	a5,-32(s0)
     c62:	e398                	sd	a4,0(a5)
     c64:	a039                	j	c72 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     c66:	fe843783          	ld	a5,-24(s0)
     c6a:	6398                	ld	a4,0(a5)
     c6c:	fe043783          	ld	a5,-32(s0)
     c70:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     c72:	fe843783          	ld	a5,-24(s0)
     c76:	479c                	lw	a5,8(a5)
     c78:	1782                	slli	a5,a5,0x20
     c7a:	9381                	srli	a5,a5,0x20
     c7c:	0792                	slli	a5,a5,0x4
     c7e:	fe843703          	ld	a4,-24(s0)
     c82:	97ba                	add	a5,a5,a4
     c84:	fe043703          	ld	a4,-32(s0)
     c88:	02f71563          	bne	a4,a5,cb2 <free+0x102>
    p->s.size += bp->s.size;
     c8c:	fe843783          	ld	a5,-24(s0)
     c90:	4798                	lw	a4,8(a5)
     c92:	fe043783          	ld	a5,-32(s0)
     c96:	479c                	lw	a5,8(a5)
     c98:	9fb9                	addw	a5,a5,a4
     c9a:	0007871b          	sext.w	a4,a5
     c9e:	fe843783          	ld	a5,-24(s0)
     ca2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     ca4:	fe043783          	ld	a5,-32(s0)
     ca8:	6398                	ld	a4,0(a5)
     caa:	fe843783          	ld	a5,-24(s0)
     cae:	e398                	sd	a4,0(a5)
     cb0:	a031                	j	cbc <free+0x10c>
  } else
    p->s.ptr = bp;
     cb2:	fe843783          	ld	a5,-24(s0)
     cb6:	fe043703          	ld	a4,-32(s0)
     cba:	e398                	sd	a4,0(a5)
  freep = p;
     cbc:	00001797          	auipc	a5,0x1
     cc0:	9b478793          	addi	a5,a5,-1612 # 1670 <freep>
     cc4:	fe843703          	ld	a4,-24(s0)
     cc8:	e398                	sd	a4,0(a5)
}
     cca:	0001                	nop
     ccc:	7422                	ld	s0,40(sp)
     cce:	6145                	addi	sp,sp,48
     cd0:	8082                	ret

0000000000000cd2 <morecore>:

static Header*
morecore(uint nu)
{
     cd2:	7179                	addi	sp,sp,-48
     cd4:	f406                	sd	ra,40(sp)
     cd6:	f022                	sd	s0,32(sp)
     cd8:	1800                	addi	s0,sp,48
     cda:	87aa                	mv	a5,a0
     cdc:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     ce0:	fdc42783          	lw	a5,-36(s0)
     ce4:	0007871b          	sext.w	a4,a5
     ce8:	6785                	lui	a5,0x1
     cea:	00f77563          	bgeu	a4,a5,cf4 <morecore+0x22>
    nu = 4096;
     cee:	6785                	lui	a5,0x1
     cf0:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     cf4:	fdc42783          	lw	a5,-36(s0)
     cf8:	0047979b          	slliw	a5,a5,0x4
     cfc:	2781                	sext.w	a5,a5
     cfe:	2781                	sext.w	a5,a5
     d00:	853e                	mv	a0,a5
     d02:	00000097          	auipc	ra,0x0
     d06:	9a0080e7          	jalr	-1632(ra) # 6a2 <sbrk>
     d0a:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     d0e:	fe843703          	ld	a4,-24(s0)
     d12:	57fd                	li	a5,-1
     d14:	00f71463          	bne	a4,a5,d1c <morecore+0x4a>
    return 0;
     d18:	4781                	li	a5,0
     d1a:	a03d                	j	d48 <morecore+0x76>
  hp = (Header*)p;
     d1c:	fe843783          	ld	a5,-24(s0)
     d20:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     d24:	fe043783          	ld	a5,-32(s0)
     d28:	fdc42703          	lw	a4,-36(s0)
     d2c:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     d2e:	fe043783          	ld	a5,-32(s0)
     d32:	07c1                	addi	a5,a5,16
     d34:	853e                	mv	a0,a5
     d36:	00000097          	auipc	ra,0x0
     d3a:	e7a080e7          	jalr	-390(ra) # bb0 <free>
  return freep;
     d3e:	00001797          	auipc	a5,0x1
     d42:	93278793          	addi	a5,a5,-1742 # 1670 <freep>
     d46:	639c                	ld	a5,0(a5)
}
     d48:	853e                	mv	a0,a5
     d4a:	70a2                	ld	ra,40(sp)
     d4c:	7402                	ld	s0,32(sp)
     d4e:	6145                	addi	sp,sp,48
     d50:	8082                	ret

0000000000000d52 <malloc>:

void*
malloc(uint nbytes)
{
     d52:	7139                	addi	sp,sp,-64
     d54:	fc06                	sd	ra,56(sp)
     d56:	f822                	sd	s0,48(sp)
     d58:	0080                	addi	s0,sp,64
     d5a:	87aa                	mv	a5,a0
     d5c:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     d60:	fcc46783          	lwu	a5,-52(s0)
     d64:	07bd                	addi	a5,a5,15
     d66:	8391                	srli	a5,a5,0x4
     d68:	2781                	sext.w	a5,a5
     d6a:	2785                	addiw	a5,a5,1
     d6c:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     d70:	00001797          	auipc	a5,0x1
     d74:	90078793          	addi	a5,a5,-1792 # 1670 <freep>
     d78:	639c                	ld	a5,0(a5)
     d7a:	fef43023          	sd	a5,-32(s0)
     d7e:	fe043783          	ld	a5,-32(s0)
     d82:	ef95                	bnez	a5,dbe <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     d84:	00001797          	auipc	a5,0x1
     d88:	8dc78793          	addi	a5,a5,-1828 # 1660 <base>
     d8c:	fef43023          	sd	a5,-32(s0)
     d90:	00001797          	auipc	a5,0x1
     d94:	8e078793          	addi	a5,a5,-1824 # 1670 <freep>
     d98:	fe043703          	ld	a4,-32(s0)
     d9c:	e398                	sd	a4,0(a5)
     d9e:	00001797          	auipc	a5,0x1
     da2:	8d278793          	addi	a5,a5,-1838 # 1670 <freep>
     da6:	6398                	ld	a4,0(a5)
     da8:	00001797          	auipc	a5,0x1
     dac:	8b878793          	addi	a5,a5,-1864 # 1660 <base>
     db0:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     db2:	00001797          	auipc	a5,0x1
     db6:	8ae78793          	addi	a5,a5,-1874 # 1660 <base>
     dba:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     dbe:	fe043783          	ld	a5,-32(s0)
     dc2:	639c                	ld	a5,0(a5)
     dc4:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     dc8:	fe843783          	ld	a5,-24(s0)
     dcc:	4798                	lw	a4,8(a5)
     dce:	fdc42783          	lw	a5,-36(s0)
     dd2:	2781                	sext.w	a5,a5
     dd4:	06f76863          	bltu	a4,a5,e44 <malloc+0xf2>
      if(p->s.size == nunits)
     dd8:	fe843783          	ld	a5,-24(s0)
     ddc:	4798                	lw	a4,8(a5)
     dde:	fdc42783          	lw	a5,-36(s0)
     de2:	2781                	sext.w	a5,a5
     de4:	00e79963          	bne	a5,a4,df6 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     de8:	fe843783          	ld	a5,-24(s0)
     dec:	6398                	ld	a4,0(a5)
     dee:	fe043783          	ld	a5,-32(s0)
     df2:	e398                	sd	a4,0(a5)
     df4:	a82d                	j	e2e <malloc+0xdc>
      else {
        p->s.size -= nunits;
     df6:	fe843783          	ld	a5,-24(s0)
     dfa:	4798                	lw	a4,8(a5)
     dfc:	fdc42783          	lw	a5,-36(s0)
     e00:	40f707bb          	subw	a5,a4,a5
     e04:	0007871b          	sext.w	a4,a5
     e08:	fe843783          	ld	a5,-24(s0)
     e0c:	c798                	sw	a4,8(a5)
        p += p->s.size;
     e0e:	fe843783          	ld	a5,-24(s0)
     e12:	479c                	lw	a5,8(a5)
     e14:	1782                	slli	a5,a5,0x20
     e16:	9381                	srli	a5,a5,0x20
     e18:	0792                	slli	a5,a5,0x4
     e1a:	fe843703          	ld	a4,-24(s0)
     e1e:	97ba                	add	a5,a5,a4
     e20:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     e24:	fe843783          	ld	a5,-24(s0)
     e28:	fdc42703          	lw	a4,-36(s0)
     e2c:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     e2e:	00001797          	auipc	a5,0x1
     e32:	84278793          	addi	a5,a5,-1982 # 1670 <freep>
     e36:	fe043703          	ld	a4,-32(s0)
     e3a:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     e3c:	fe843783          	ld	a5,-24(s0)
     e40:	07c1                	addi	a5,a5,16
     e42:	a091                	j	e86 <malloc+0x134>
    }
    if(p == freep)
     e44:	00001797          	auipc	a5,0x1
     e48:	82c78793          	addi	a5,a5,-2004 # 1670 <freep>
     e4c:	639c                	ld	a5,0(a5)
     e4e:	fe843703          	ld	a4,-24(s0)
     e52:	02f71063          	bne	a4,a5,e72 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     e56:	fdc42783          	lw	a5,-36(s0)
     e5a:	853e                	mv	a0,a5
     e5c:	00000097          	auipc	ra,0x0
     e60:	e76080e7          	jalr	-394(ra) # cd2 <morecore>
     e64:	fea43423          	sd	a0,-24(s0)
     e68:	fe843783          	ld	a5,-24(s0)
     e6c:	e399                	bnez	a5,e72 <malloc+0x120>
        return 0;
     e6e:	4781                	li	a5,0
     e70:	a819                	j	e86 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     e72:	fe843783          	ld	a5,-24(s0)
     e76:	fef43023          	sd	a5,-32(s0)
     e7a:	fe843783          	ld	a5,-24(s0)
     e7e:	639c                	ld	a5,0(a5)
     e80:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     e84:	b791                	j	dc8 <malloc+0x76>
  }
}
     e86:	853e                	mv	a0,a5
     e88:	70e2                	ld	ra,56(sp)
     e8a:	7442                	ld	s0,48(sp)
     e8c:	6121                	addi	sp,sp,64
     e8e:	8082                	ret

0000000000000e90 <setjmp>:
     e90:	e100                	sd	s0,0(a0)
     e92:	e504                	sd	s1,8(a0)
     e94:	01253823          	sd	s2,16(a0)
     e98:	01353c23          	sd	s3,24(a0)
     e9c:	03453023          	sd	s4,32(a0)
     ea0:	03553423          	sd	s5,40(a0)
     ea4:	03653823          	sd	s6,48(a0)
     ea8:	03753c23          	sd	s7,56(a0)
     eac:	05853023          	sd	s8,64(a0)
     eb0:	05953423          	sd	s9,72(a0)
     eb4:	05a53823          	sd	s10,80(a0)
     eb8:	05b53c23          	sd	s11,88(a0)
     ebc:	06153023          	sd	ra,96(a0)
     ec0:	06253423          	sd	sp,104(a0)
     ec4:	4501                	li	a0,0
     ec6:	8082                	ret

0000000000000ec8 <longjmp>:
     ec8:	6100                	ld	s0,0(a0)
     eca:	6504                	ld	s1,8(a0)
     ecc:	01053903          	ld	s2,16(a0)
     ed0:	01853983          	ld	s3,24(a0)
     ed4:	02053a03          	ld	s4,32(a0)
     ed8:	02853a83          	ld	s5,40(a0)
     edc:	03053b03          	ld	s6,48(a0)
     ee0:	03853b83          	ld	s7,56(a0)
     ee4:	04053c03          	ld	s8,64(a0)
     ee8:	04853c83          	ld	s9,72(a0)
     eec:	05053d03          	ld	s10,80(a0)
     ef0:	05853d83          	ld	s11,88(a0)
     ef4:	06053083          	ld	ra,96(a0)
     ef8:	06853103          	ld	sp,104(a0)
     efc:	c199                	beqz	a1,f02 <longjmp_1>
     efe:	852e                	mv	a0,a1
     f00:	8082                	ret

0000000000000f02 <longjmp_1>:
     f02:	4505                	li	a0,1
     f04:	8082                	ret

0000000000000f06 <schedule_default>:
#define INT_MAX 2147483647
#define TIME_QUANTUM 2  // Define a base time quantum for the round-robin

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
     f06:	715d                	addi	sp,sp,-80
     f08:	e4a2                	sd	s0,72(sp)
     f0a:	e0a6                	sd	s1,64(sp)
     f0c:	0880                	addi	s0,sp,80
     f0e:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
     f10:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
     f14:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     f18:	649c                	ld	a5,8(s1)
     f1a:	639c                	ld	a5,0(a5)
     f1c:	fcf43c23          	sd	a5,-40(s0)
     f20:	fd843783          	ld	a5,-40(s0)
     f24:	fd878793          	addi	a5,a5,-40
     f28:	fef43023          	sd	a5,-32(s0)
     f2c:	a81d                	j	f62 <schedule_default+0x5c>
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
     f2e:	fe843783          	ld	a5,-24(s0)
     f32:	cb89                	beqz	a5,f44 <schedule_default+0x3e>
     f34:	fe043783          	ld	a5,-32(s0)
     f38:	5fd8                	lw	a4,60(a5)
     f3a:	fe843783          	ld	a5,-24(s0)
     f3e:	5fdc                	lw	a5,60(a5)
     f40:	00f75663          	bge	a4,a5,f4c <schedule_default+0x46>
            thread_with_smallest_id = th;
     f44:	fe043783          	ld	a5,-32(s0)
     f48:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     f4c:	fe043783          	ld	a5,-32(s0)
     f50:	779c                	ld	a5,40(a5)
     f52:	fcf43823          	sd	a5,-48(s0)
     f56:	fd043783          	ld	a5,-48(s0)
     f5a:	fd878793          	addi	a5,a5,-40
     f5e:	fef43023          	sd	a5,-32(s0)
     f62:	fe043783          	ld	a5,-32(s0)
     f66:	02878713          	addi	a4,a5,40
     f6a:	649c                	ld	a5,8(s1)
     f6c:	fcf711e3          	bne	a4,a5,f2e <schedule_default+0x28>
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
     f70:	fe843783          	ld	a5,-24(s0)
     f74:	cf89                	beqz	a5,f8e <schedule_default+0x88>
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
     f76:	fe843783          	ld	a5,-24(s0)
     f7a:	02878793          	addi	a5,a5,40
     f7e:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
     f82:	fe843783          	ld	a5,-24(s0)
     f86:	4fbc                	lw	a5,88(a5)
     f88:	faf42c23          	sw	a5,-72(s0)
     f8c:	a039                	j	f9a <schedule_default+0x94>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
     f8e:	649c                	ld	a5,8(s1)
     f90:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
     f94:	4785                	li	a5,1
     f96:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
     f9a:	fb043783          	ld	a5,-80(s0)
     f9e:	fcf43023          	sd	a5,-64(s0)
     fa2:	fb843783          	ld	a5,-72(s0)
     fa6:	fcf43423          	sd	a5,-56(s0)
     faa:	4701                	li	a4,0
     fac:	fc043703          	ld	a4,-64(s0)
     fb0:	4781                	li	a5,0
     fb2:	fc843783          	ld	a5,-56(s0)
     fb6:	863a                	mv	a2,a4
     fb8:	86be                	mv	a3,a5
     fba:	8732                	mv	a4,a2
     fbc:	87b6                	mv	a5,a3
}
     fbe:	853a                	mv	a0,a4
     fc0:	85be                	mv	a1,a5
     fc2:	6426                	ld	s0,72(sp)
     fc4:	6486                	ld	s1,64(sp)
     fc6:	6161                	addi	sp,sp,80
     fc8:	8082                	ret

0000000000000fca <schedule_wrr>:

/* MP3 Part 1 - Non-Real-Time Scheduling */
/* Weighted-Round-Robin Scheduling */
struct threads_sched_result schedule_wrr(struct threads_sched_args args)
{
     fca:	7159                	addi	sp,sp,-112
     fcc:	f4a2                	sd	s0,104(sp)
     fce:	f0a6                	sd	s1,96(sp)
     fd0:	1880                	addi	s0,sp,112
     fd2:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the weighted round-robin scheduling algorithm
    static struct thread *last_thread = NULL;
    struct thread *selected_thread = NULL;
     fd4:	fe043423          	sd	zero,-24(s0)
    int max_priority = -1;
     fd8:	57fd                	li	a5,-1
     fda:	fef42223          	sw	a5,-28(s0)

    // If last_thread is NULL or its remaining time is zero, reset the selection process
    if (last_thread == NULL || last_thread->remaining_time <= 0) {
     fde:	00000797          	auipc	a5,0x0
     fe2:	69a78793          	addi	a5,a5,1690 # 1678 <last_thread.1226>
     fe6:	639c                	ld	a5,0(a5)
     fe8:	cb89                	beqz	a5,ffa <schedule_wrr+0x30>
     fea:	00000797          	auipc	a5,0x0
     fee:	68e78793          	addi	a5,a5,1678 # 1678 <last_thread.1226>
     ff2:	639c                	ld	a5,0(a5)
     ff4:	4fbc                	lw	a5,88(a5)
     ff6:	00f04863          	bgtz	a5,1006 <schedule_wrr+0x3c>
        last_thread = NULL;
     ffa:	00000797          	auipc	a5,0x0
     ffe:	67e78793          	addi	a5,a5,1662 # 1678 <last_thread.1226>
    1002:	0007b023          	sd	zero,0(a5)
    }

    struct thread *candidate = NULL;
    1006:	fc043c23          	sd	zero,-40(s0)
    // Select the next thread to run based on weight and ensure round-robin fairness
    list_for_each_entry(candidate, args.run_queue, thread_list) {
    100a:	649c                	ld	a5,8(s1)
    100c:	639c                	ld	a5,0(a5)
    100e:	fcf43423          	sd	a5,-56(s0)
    1012:	fc843783          	ld	a5,-56(s0)
    1016:	fd878793          	addi	a5,a5,-40
    101a:	fcf43c23          	sd	a5,-40(s0)
    101e:	a8a1                	j	1076 <schedule_wrr+0xac>
        if (candidate != last_thread) {
    1020:	00000797          	auipc	a5,0x0
    1024:	65878793          	addi	a5,a5,1624 # 1678 <last_thread.1226>
    1028:	639c                	ld	a5,0(a5)
    102a:	fd843703          	ld	a4,-40(s0)
    102e:	02f70963          	beq	a4,a5,1060 <schedule_wrr+0x96>
            int priority = candidate->weight * TIME_QUANTUM;
    1032:	fd843783          	ld	a5,-40(s0)
    1036:	47bc                	lw	a5,72(a5)
    1038:	0017979b          	slliw	a5,a5,0x1
    103c:	fcf42223          	sw	a5,-60(s0)
            if (priority > max_priority) {
    1040:	fc442703          	lw	a4,-60(s0)
    1044:	fe442783          	lw	a5,-28(s0)
    1048:	2701                	sext.w	a4,a4
    104a:	2781                	sext.w	a5,a5
    104c:	00e7da63          	bge	a5,a4,1060 <schedule_wrr+0x96>
                selected_thread = candidate;
    1050:	fd843783          	ld	a5,-40(s0)
    1054:	fef43423          	sd	a5,-24(s0)
                max_priority = priority;
    1058:	fc442783          	lw	a5,-60(s0)
    105c:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(candidate, args.run_queue, thread_list) {
    1060:	fd843783          	ld	a5,-40(s0)
    1064:	779c                	ld	a5,40(a5)
    1066:	faf43c23          	sd	a5,-72(s0)
    106a:	fb843783          	ld	a5,-72(s0)
    106e:	fd878793          	addi	a5,a5,-40
    1072:	fcf43c23          	sd	a5,-40(s0)
    1076:	fd843783          	ld	a5,-40(s0)
    107a:	02878713          	addi	a4,a5,40
    107e:	649c                	ld	a5,8(s1)
    1080:	faf710e3          	bne	a4,a5,1020 <schedule_wrr+0x56>
            }
        }
    }

    // Fall back to the last_thread if no other thread is selected and it still has remaining time
    if (!selected_thread && last_thread && last_thread->remaining_time > 0) {
    1084:	fe843783          	ld	a5,-24(s0)
    1088:	e795                	bnez	a5,10b4 <schedule_wrr+0xea>
    108a:	00000797          	auipc	a5,0x0
    108e:	5ee78793          	addi	a5,a5,1518 # 1678 <last_thread.1226>
    1092:	639c                	ld	a5,0(a5)
    1094:	c385                	beqz	a5,10b4 <schedule_wrr+0xea>
    1096:	00000797          	auipc	a5,0x0
    109a:	5e278793          	addi	a5,a5,1506 # 1678 <last_thread.1226>
    109e:	639c                	ld	a5,0(a5)
    10a0:	4fbc                	lw	a5,88(a5)
    10a2:	00f05963          	blez	a5,10b4 <schedule_wrr+0xea>
        selected_thread = last_thread;
    10a6:	00000797          	auipc	a5,0x0
    10aa:	5d278793          	addi	a5,a5,1490 # 1678 <last_thread.1226>
    10ae:	639c                	ld	a5,0(a5)
    10b0:	fef43423          	sd	a5,-24(s0)
    }

    // Set the scheduling result
    if (selected_thread) {
    10b4:	fe843783          	ld	a5,-24(s0)
    10b8:	c7b9                	beqz	a5,1106 <schedule_wrr+0x13c>
        int time_slice = selected_thread->weight * TIME_QUANTUM;
    10ba:	fe843783          	ld	a5,-24(s0)
    10be:	47bc                	lw	a5,72(a5)
    10c0:	0017979b          	slliw	a5,a5,0x1
    10c4:	fcf42a23          	sw	a5,-44(s0)
        if (time_slice > selected_thread->remaining_time) {
    10c8:	fe843783          	ld	a5,-24(s0)
    10cc:	4fb8                	lw	a4,88(a5)
    10ce:	fd442783          	lw	a5,-44(s0)
    10d2:	2781                	sext.w	a5,a5
    10d4:	00f75763          	bge	a4,a5,10e2 <schedule_wrr+0x118>
            time_slice = selected_thread->remaining_time;
    10d8:	fe843783          	ld	a5,-24(s0)
    10dc:	4fbc                	lw	a5,88(a5)
    10de:	fcf42a23          	sw	a5,-44(s0)
        }
        r.scheduled_thread_list_member = &selected_thread->thread_list;
    10e2:	fe843783          	ld	a5,-24(s0)
    10e6:	02878793          	addi	a5,a5,40
    10ea:	f8f43c23          	sd	a5,-104(s0)
        r.allocated_time = time_slice;
    10ee:	fd442783          	lw	a5,-44(s0)
    10f2:	faf42023          	sw	a5,-96(s0)
        last_thread = selected_thread;  // Update the last run thread
    10f6:	00000797          	auipc	a5,0x0
    10fa:	58278793          	addi	a5,a5,1410 # 1678 <last_thread.1226>
    10fe:	fe843703          	ld	a4,-24(s0)
    1102:	e398                	sd	a4,0(a5)
    1104:	a039                	j	1112 <schedule_wrr+0x148>
    } else {
        // Idle if no suitable thread is found
        r.scheduled_thread_list_member = args.run_queue;
    1106:	649c                	ld	a5,8(s1)
    1108:	f8f43c23          	sd	a5,-104(s0)
        r.allocated_time = 1;
    110c:	4785                	li	a5,1
    110e:	faf42023          	sw	a5,-96(s0)
    }

    return r;
    1112:	f9843783          	ld	a5,-104(s0)
    1116:	faf43423          	sd	a5,-88(s0)
    111a:	fa043783          	ld	a5,-96(s0)
    111e:	faf43823          	sd	a5,-80(s0)
    1122:	4701                	li	a4,0
    1124:	fa843703          	ld	a4,-88(s0)
    1128:	4781                	li	a5,0
    112a:	fb043783          	ld	a5,-80(s0)
    112e:	863a                	mv	a2,a4
    1130:	86be                	mv	a3,a5
    1132:	8732                	mv	a4,a2
    1134:	87b6                	mv	a5,a3
}
    1136:	853a                	mv	a0,a4
    1138:	85be                	mv	a1,a5
    113a:	7426                	ld	s0,104(sp)
    113c:	7486                	ld	s1,96(sp)
    113e:	6165                	addi	sp,sp,112
    1140:	8082                	ret

0000000000001142 <find_next_release_time>:

/* Shortest-Job-First Scheduling */
int find_next_release_time(struct list_head *release_queue, int current_time) {
    1142:	7139                	addi	sp,sp,-64
    1144:	fc22                	sd	s0,56(sp)
    1146:	0080                	addi	s0,sp,64
    1148:	fca43423          	sd	a0,-56(s0)
    114c:	87ae                	mv	a5,a1
    114e:	fcf42223          	sw	a5,-60(s0)
    struct release_queue_entry *next_release = NULL;
    1152:	fe043423          	sd	zero,-24(s0)
    int next_release_time = INT_MAX;
    1156:	800007b7          	lui	a5,0x80000
    115a:	fff7c793          	not	a5,a5
    115e:	fef42223          	sw	a5,-28(s0)

    list_for_each_entry(next_release, release_queue, thread_list) {
    1162:	fc843783          	ld	a5,-56(s0)
    1166:	639c                	ld	a5,0(a5)
    1168:	fcf43c23          	sd	a5,-40(s0)
    116c:	fd843783          	ld	a5,-40(s0)
    1170:	17e1                	addi	a5,a5,-8
    1172:	fef43423          	sd	a5,-24(s0)
    1176:	a081                	j	11b6 <find_next_release_time+0x74>
        if (next_release->release_time > current_time &&
    1178:	fe843783          	ld	a5,-24(s0)
    117c:	4f98                	lw	a4,24(a5)
    117e:	fc442783          	lw	a5,-60(s0)
    1182:	2781                	sext.w	a5,a5
    1184:	00e7df63          	bge	a5,a4,11a2 <find_next_release_time+0x60>
            next_release->release_time < next_release_time) {
    1188:	fe843783          	ld	a5,-24(s0)
    118c:	4f98                	lw	a4,24(a5)
        if (next_release->release_time > current_time &&
    118e:	fe442783          	lw	a5,-28(s0)
    1192:	2781                	sext.w	a5,a5
    1194:	00f75763          	bge	a4,a5,11a2 <find_next_release_time+0x60>
            next_release_time = next_release->release_time;
    1198:	fe843783          	ld	a5,-24(s0)
    119c:	4f9c                	lw	a5,24(a5)
    119e:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(next_release, release_queue, thread_list) {
    11a2:	fe843783          	ld	a5,-24(s0)
    11a6:	679c                	ld	a5,8(a5)
    11a8:	fcf43823          	sd	a5,-48(s0)
    11ac:	fd043783          	ld	a5,-48(s0)
    11b0:	17e1                	addi	a5,a5,-8
    11b2:	fef43423          	sd	a5,-24(s0)
    11b6:	fe843783          	ld	a5,-24(s0)
    11ba:	07a1                	addi	a5,a5,8
    11bc:	fc843703          	ld	a4,-56(s0)
    11c0:	faf71ce3          	bne	a4,a5,1178 <find_next_release_time+0x36>
        }
    }

    if (next_release_time == INT_MAX)
    11c4:	fe442783          	lw	a5,-28(s0)
    11c8:	0007871b          	sext.w	a4,a5
    11cc:	800007b7          	lui	a5,0x80000
    11d0:	fff7c793          	not	a5,a5
    11d4:	00f71463          	bne	a4,a5,11dc <find_next_release_time+0x9a>
        return -1; // No threads in the release queue
    11d8:	57fd                	li	a5,-1
    11da:	a801                	j	11ea <find_next_release_time+0xa8>

    return next_release_time - current_time;
    11dc:	fe442703          	lw	a4,-28(s0)
    11e0:	fc442783          	lw	a5,-60(s0)
    11e4:	40f707bb          	subw	a5,a4,a5
    11e8:	2781                	sext.w	a5,a5
}
    11ea:	853e                	mv	a0,a5
    11ec:	7462                	ld	s0,56(sp)
    11ee:	6121                	addi	sp,sp,64
    11f0:	8082                	ret

00000000000011f2 <schedule_sjf>:


struct threads_sched_result schedule_sjf(struct threads_sched_args args)
{
    11f2:	711d                	addi	sp,sp,-96
    11f4:	eca2                	sd	s0,88(sp)
    11f6:	e8a6                	sd	s1,80(sp)
    11f8:	1080                	addi	s0,sp,96
    11fa:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the shortest-job-first scheduling algorithm
    struct thread *shortest_job = NULL;
    11fc:	fe043423          	sd	zero,-24(s0)
    struct thread *t;
    int shortest_time = INT_MAX;
    1200:	800007b7          	lui	a5,0x80000
    1204:	fff7c793          	not	a5,a5
    1208:	fcf42e23          	sw	a5,-36(s0)

    // Find the thread with the shortest remaining time that is ready to run
    list_for_each_entry(t, args.run_queue, thread_list) {
    120c:	649c                	ld	a5,8(s1)
    120e:	639c                	ld	a5,0(a5)
    1210:	fcf43823          	sd	a5,-48(s0)
    1214:	fd043783          	ld	a5,-48(s0)
    1218:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe190>
    121c:	fef43023          	sd	a5,-32(s0)
    1220:	a82d                	j	125a <schedule_sjf+0x68>
        if (t->remaining_time < shortest_time) {
    1222:	fe043783          	ld	a5,-32(s0)
    1226:	4fb8                	lw	a4,88(a5)
    1228:	fdc42783          	lw	a5,-36(s0)
    122c:	2781                	sext.w	a5,a5
    122e:	00f75b63          	bge	a4,a5,1244 <schedule_sjf+0x52>
            shortest_time = t->remaining_time;
    1232:	fe043783          	ld	a5,-32(s0)
    1236:	4fbc                	lw	a5,88(a5)
    1238:	fcf42e23          	sw	a5,-36(s0)
            shortest_job = t;
    123c:	fe043783          	ld	a5,-32(s0)
    1240:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    1244:	fe043783          	ld	a5,-32(s0)
    1248:	779c                	ld	a5,40(a5)
    124a:	fcf43423          	sd	a5,-56(s0)
    124e:	fc843783          	ld	a5,-56(s0)
    1252:	fd878793          	addi	a5,a5,-40
    1256:	fef43023          	sd	a5,-32(s0)
    125a:	fe043783          	ld	a5,-32(s0)
    125e:	02878713          	addi	a4,a5,40
    1262:	649c                	ld	a5,8(s1)
    1264:	faf71fe3          	bne	a4,a5,1222 <schedule_sjf+0x30>
        }
    }

    if (shortest_job) {
    1268:	fe843783          	ld	a5,-24(s0)
    126c:	cf89                	beqz	a5,1286 <schedule_sjf+0x94>
        r.scheduled_thread_list_member = &shortest_job->thread_list;
    126e:	fe843783          	ld	a5,-24(s0)
    1272:	02878793          	addi	a5,a5,40
    1276:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = shortest_job->remaining_time;  // Allow the thread to run to completion
    127a:	fe843783          	ld	a5,-24(s0)
    127e:	4fbc                	lw	a5,88(a5)
    1280:	faf42823          	sw	a5,-80(s0)
    1284:	a039                	j	1292 <schedule_sjf+0xa0>
    } else {
        // If no threads are ready, find the next release time or idle
        r.scheduled_thread_list_member = args.run_queue;
    1286:	649c                	ld	a5,8(s1)
    1288:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = 1;  // Default minimal quantum if unsure
    128c:	4785                	li	a5,1
    128e:	faf42823          	sw	a5,-80(s0)
    }
    return r;
    1292:	fa843783          	ld	a5,-88(s0)
    1296:	faf43c23          	sd	a5,-72(s0)
    129a:	fb043783          	ld	a5,-80(s0)
    129e:	fcf43023          	sd	a5,-64(s0)
    12a2:	4701                	li	a4,0
    12a4:	fb843703          	ld	a4,-72(s0)
    12a8:	4781                	li	a5,0
    12aa:	fc043783          	ld	a5,-64(s0)
    12ae:	863a                	mv	a2,a4
    12b0:	86be                	mv	a3,a5
    12b2:	8732                	mv	a4,a2
    12b4:	87b6                	mv	a5,a3
}
    12b6:	853a                	mv	a0,a4
    12b8:	85be                	mv	a1,a5
    12ba:	6466                	ld	s0,88(sp)
    12bc:	64c6                	ld	s1,80(sp)
    12be:	6125                	addi	sp,sp,96
    12c0:	8082                	ret

00000000000012c2 <schedule_lst>:

/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args)
{
    12c2:	7119                	addi	sp,sp,-128
    12c4:	fc86                	sd	ra,120(sp)
    12c6:	f8a2                	sd	s0,112(sp)
    12c8:	f4a6                	sd	s1,104(sp)
    12ca:	f0ca                	sd	s2,96(sp)
    12cc:	ecce                	sd	s3,88(sp)
    12ce:	0100                	addi	s0,sp,128
    12d0:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the least-slack-time scheduling algorithm
    struct thread *min_slack = NULL;
    12d2:	fc043423          	sd	zero,-56(s0)
    int min_slack_time = INT_MAX;
    12d6:	800007b7          	lui	a5,0x80000
    12da:	fff7c793          	not	a5,a5
    12de:	fcf42223          	sw	a5,-60(s0)
    struct thread *t;

    // Find the thread with the minimum slack time
    list_for_each_entry(t, args.run_queue, thread_list) {
    12e2:	649c                	ld	a5,8(s1)
    12e4:	639c                	ld	a5,0(a5)
    12e6:	faf43823          	sd	a5,-80(s0)
    12ea:	fb043783          	ld	a5,-80(s0)
    12ee:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe190>
    12f2:	faf43c23          	sd	a5,-72(s0)
    12f6:	a8b5                	j	1372 <schedule_lst+0xb0>
        int slack_time = t->deadline - args.current_time - t->remaining_time;
    12f8:	fb843783          	ld	a5,-72(s0)
    12fc:	47f8                	lw	a4,76(a5)
    12fe:	409c                	lw	a5,0(s1)
    1300:	40f707bb          	subw	a5,a4,a5
    1304:	0007871b          	sext.w	a4,a5
    1308:	fb843783          	ld	a5,-72(s0)
    130c:	4fbc                	lw	a5,88(a5)
    130e:	40f707bb          	subw	a5,a4,a5
    1312:	faf42623          	sw	a5,-84(s0)
        if (min_slack == NULL || slack_time < min_slack_time ||
    1316:	fc843783          	ld	a5,-56(s0)
    131a:	cb8d                	beqz	a5,134c <schedule_lst+0x8a>
    131c:	fac42703          	lw	a4,-84(s0)
    1320:	fc442783          	lw	a5,-60(s0)
    1324:	2701                	sext.w	a4,a4
    1326:	2781                	sext.w	a5,a5
    1328:	02f74263          	blt	a4,a5,134c <schedule_lst+0x8a>
    132c:	fac42703          	lw	a4,-84(s0)
    1330:	fc442783          	lw	a5,-60(s0)
    1334:	2701                	sext.w	a4,a4
    1336:	2781                	sext.w	a5,a5
    1338:	02f71263          	bne	a4,a5,135c <schedule_lst+0x9a>
            (slack_time == min_slack_time && t->ID < min_slack->ID)) {
    133c:	fb843783          	ld	a5,-72(s0)
    1340:	5fd8                	lw	a4,60(a5)
    1342:	fc843783          	ld	a5,-56(s0)
    1346:	5fdc                	lw	a5,60(a5)
    1348:	00f75a63          	bge	a4,a5,135c <schedule_lst+0x9a>
            min_slack = t;
    134c:	fb843783          	ld	a5,-72(s0)
    1350:	fcf43423          	sd	a5,-56(s0)
            min_slack_time = slack_time;
    1354:	fac42783          	lw	a5,-84(s0)
    1358:	fcf42223          	sw	a5,-60(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    135c:	fb843783          	ld	a5,-72(s0)
    1360:	779c                	ld	a5,40(a5)
    1362:	faf43023          	sd	a5,-96(s0)
    1366:	fa043783          	ld	a5,-96(s0)
    136a:	fd878793          	addi	a5,a5,-40
    136e:	faf43c23          	sd	a5,-72(s0)
    1372:	fb843783          	ld	a5,-72(s0)
    1376:	02878713          	addi	a4,a5,40
    137a:	649c                	ld	a5,8(s1)
    137c:	f6f71ee3          	bne	a4,a5,12f8 <schedule_lst+0x36>
        }
    }

    if (min_slack) {
    1380:	fc843783          	ld	a5,-56(s0)
    1384:	cf89                	beqz	a5,139e <schedule_lst+0xdc>
        r.scheduled_thread_list_member = &min_slack->thread_list;
    1386:	fc843783          	ld	a5,-56(s0)
    138a:	02878793          	addi	a5,a5,40
    138e:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = min_slack->remaining_time;
    1392:	fc843783          	ld	a5,-56(s0)
    1396:	4fbc                	lw	a5,88(a5)
    1398:	f8f42423          	sw	a5,-120(s0)
    139c:	a839                	j	13ba <schedule_lst+0xf8>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
    139e:	649c                	ld	a5,8(s1)
    13a0:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    13a4:	689c                	ld	a5,16(s1)
    13a6:	4098                	lw	a4,0(s1)
    13a8:	85ba                	mv	a1,a4
    13aa:	853e                	mv	a0,a5
    13ac:	00000097          	auipc	ra,0x0
    13b0:	d96080e7          	jalr	-618(ra) # 1142 <find_next_release_time>
    13b4:	87aa                	mv	a5,a0
    13b6:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    13ba:	f8043783          	ld	a5,-128(s0)
    13be:	f8f43823          	sd	a5,-112(s0)
    13c2:	f8843783          	ld	a5,-120(s0)
    13c6:	f8f43c23          	sd	a5,-104(s0)
    13ca:	4701                	li	a4,0
    13cc:	f9043703          	ld	a4,-112(s0)
    13d0:	4781                	li	a5,0
    13d2:	f9843783          	ld	a5,-104(s0)
    13d6:	893a                	mv	s2,a4
    13d8:	89be                	mv	s3,a5
    13da:	874a                	mv	a4,s2
    13dc:	87ce                	mv	a5,s3
}
    13de:	853a                	mv	a0,a4
    13e0:	85be                	mv	a1,a5
    13e2:	70e6                	ld	ra,120(sp)
    13e4:	7446                	ld	s0,112(sp)
    13e6:	74a6                	ld	s1,104(sp)
    13e8:	7906                	ld	s2,96(sp)
    13ea:	69e6                	ld	s3,88(sp)
    13ec:	6109                	addi	sp,sp,128
    13ee:	8082                	ret

00000000000013f0 <schedule_dm>:

/* Deadline-Monotonic Scheduling */
struct threads_sched_result schedule_dm(struct threads_sched_args args)
{
    13f0:	7135                	addi	sp,sp,-160
    13f2:	ed06                	sd	ra,152(sp)
    13f4:	e922                	sd	s0,144(sp)
    13f6:	e526                	sd	s1,136(sp)
    13f8:	e14a                	sd	s2,128(sp)
    13fa:	fcce                	sd	s3,120(sp)
    13fc:	1100                	addi	s0,sp,160
    13fe:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the deadline-monotonic scheduling algorithm
   struct thread *earliest_deadline_thread = NULL;
    1400:	fc043423          	sd	zero,-56(s0)
    struct thread *t;
    int earliest_deadline = INT_MAX;
    1404:	800007b7          	lui	a5,0x80000
    1408:	fff7c793          	not	a5,a5
    140c:	faf42e23          	sw	a5,-68(s0)

    // Find the earliest deadline real-time thread
    list_for_each_entry(t, args.run_queue, thread_list) {
    1410:	649c                	ld	a5,8(s1)
    1412:	639c                	ld	a5,0(a5)
    1414:	faf43423          	sd	a5,-88(s0)
    1418:	fa843783          	ld	a5,-88(s0)
    141c:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe190>
    1420:	fcf43023          	sd	a5,-64(s0)
    1424:	a841                	j	14b4 <schedule_dm+0xc4>
        if (t->is_real_time && t->period != -1 && t->current_deadline < earliest_deadline) {
    1426:	fc043783          	ld	a5,-64(s0)
    142a:	43bc                	lw	a5,64(a5)
    142c:	cb95                	beqz	a5,1460 <schedule_dm+0x70>
    142e:	fc043783          	ld	a5,-64(s0)
    1432:	4bbc                	lw	a5,80(a5)
    1434:	873e                	mv	a4,a5
    1436:	57fd                	li	a5,-1
    1438:	02f70463          	beq	a4,a5,1460 <schedule_dm+0x70>
    143c:	fc043783          	ld	a5,-64(s0)
    1440:	4ff8                	lw	a4,92(a5)
    1442:	fbc42783          	lw	a5,-68(s0)
    1446:	2781                	sext.w	a5,a5
    1448:	00f75c63          	bge	a4,a5,1460 <schedule_dm+0x70>
            earliest_deadline = t->current_deadline;
    144c:	fc043783          	ld	a5,-64(s0)
    1450:	4ffc                	lw	a5,92(a5)
    1452:	faf42e23          	sw	a5,-68(s0)
            earliest_deadline_thread = t;
    1456:	fc043783          	ld	a5,-64(s0)
    145a:	fcf43423          	sd	a5,-56(s0)
    145e:	a081                	j	149e <schedule_dm+0xae>
        } else if (t->is_real_time && t->period != -1 && t->current_deadline == earliest_deadline && t->ID < earliest_deadline_thread->ID) {
    1460:	fc043783          	ld	a5,-64(s0)
    1464:	43bc                	lw	a5,64(a5)
    1466:	cf85                	beqz	a5,149e <schedule_dm+0xae>
    1468:	fc043783          	ld	a5,-64(s0)
    146c:	4bbc                	lw	a5,80(a5)
    146e:	873e                	mv	a4,a5
    1470:	57fd                	li	a5,-1
    1472:	02f70663          	beq	a4,a5,149e <schedule_dm+0xae>
    1476:	fc043783          	ld	a5,-64(s0)
    147a:	4ff8                	lw	a4,92(a5)
    147c:	fbc42783          	lw	a5,-68(s0)
    1480:	2781                	sext.w	a5,a5
    1482:	00e79e63          	bne	a5,a4,149e <schedule_dm+0xae>
    1486:	fc043783          	ld	a5,-64(s0)
    148a:	5fd8                	lw	a4,60(a5)
    148c:	fc843783          	ld	a5,-56(s0)
    1490:	5fdc                	lw	a5,60(a5)
    1492:	00f75663          	bge	a4,a5,149e <schedule_dm+0xae>
            earliest_deadline_thread = t;  // Tie-breaking by ID
    1496:	fc043783          	ld	a5,-64(s0)
    149a:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    149e:	fc043783          	ld	a5,-64(s0)
    14a2:	779c                	ld	a5,40(a5)
    14a4:	f8f43423          	sd	a5,-120(s0)
    14a8:	f8843783          	ld	a5,-120(s0)
    14ac:	fd878793          	addi	a5,a5,-40
    14b0:	fcf43023          	sd	a5,-64(s0)
    14b4:	fc043783          	ld	a5,-64(s0)
    14b8:	02878713          	addi	a4,a5,40
    14bc:	649c                	ld	a5,8(s1)
    14be:	f6f714e3          	bne	a4,a5,1426 <schedule_dm+0x36>
        }
    }

    if (earliest_deadline_thread) {
    14c2:	fc843783          	ld	a5,-56(s0)
    14c6:	c7a5                	beqz	a5,152e <schedule_dm+0x13e>
        int time_to_deadline = earliest_deadline_thread->current_deadline - args.current_time;
    14c8:	fc843783          	ld	a5,-56(s0)
    14cc:	4ff8                	lw	a4,92(a5)
    14ce:	409c                	lw	a5,0(s1)
    14d0:	40f707bb          	subw	a5,a4,a5
    14d4:	f8f42a23          	sw	a5,-108(s0)
        if (earliest_deadline_thread->remaining_time > time_to_deadline) {
    14d8:	fc843783          	ld	a5,-56(s0)
    14dc:	4fb8                	lw	a4,88(a5)
    14de:	f9442783          	lw	a5,-108(s0)
    14e2:	2781                	sext.w	a5,a5
    14e4:	00e7db63          	bge	a5,a4,14fa <schedule_dm+0x10a>
            // The real-time thread cannot complete before its deadline, so handle the deadline miss
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    14e8:	fc843783          	ld	a5,-56(s0)
    14ec:	02878793          	addi	a5,a5,40
    14f0:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = 0; // Could set to minimal quantum to allow cleanup or logging
    14f4:	f6042823          	sw	zero,-144(s0)
    14f8:	a0f1                	j	15c4 <schedule_dm+0x1d4>
        } else {
            // Schedule the real-time thread normally if it hasn't missed its deadline
            int time_slice = (time_to_deadline < earliest_deadline_thread->remaining_time) ? time_to_deadline : earliest_deadline_thread->remaining_time;
    14fa:	fc843783          	ld	a5,-56(s0)
    14fe:	4fbc                	lw	a5,88(a5)
    1500:	863e                	mv	a2,a5
    1502:	f9442783          	lw	a5,-108(s0)
    1506:	0007869b          	sext.w	a3,a5
    150a:	0006071b          	sext.w	a4,a2
    150e:	00d75363          	bge	a4,a3,1514 <schedule_dm+0x124>
    1512:	87b2                	mv	a5,a2
    1514:	f8f42823          	sw	a5,-112(s0)
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    1518:	fc843783          	ld	a5,-56(s0)
    151c:	02878793          	addi	a5,a5,40
    1520:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = time_slice;
    1524:	f9042783          	lw	a5,-112(s0)
    1528:	f6f42823          	sw	a5,-144(s0)
    152c:	a861                	j	15c4 <schedule_dm+0x1d4>
        }
    } else {
        // If no real-time threads with a deadline are ready, find the thread with the smallest ID
        struct thread *smallest_id_thread = NULL;
    152e:	fa043823          	sd	zero,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    1532:	649c                	ld	a5,8(s1)
    1534:	639c                	ld	a5,0(a5)
    1536:	faf43023          	sd	a5,-96(s0)
    153a:	fa043783          	ld	a5,-96(s0)
    153e:	fd878793          	addi	a5,a5,-40
    1542:	fcf43023          	sd	a5,-64(s0)
    1546:	a81d                	j	157c <schedule_dm+0x18c>
            if (smallest_id_thread == NULL || t->ID < smallest_id_thread->ID) {
    1548:	fb043783          	ld	a5,-80(s0)
    154c:	cb89                	beqz	a5,155e <schedule_dm+0x16e>
    154e:	fc043783          	ld	a5,-64(s0)
    1552:	5fd8                	lw	a4,60(a5)
    1554:	fb043783          	ld	a5,-80(s0)
    1558:	5fdc                	lw	a5,60(a5)
    155a:	00f75663          	bge	a4,a5,1566 <schedule_dm+0x176>
                smallest_id_thread = t;
    155e:	fc043783          	ld	a5,-64(s0)
    1562:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    1566:	fc043783          	ld	a5,-64(s0)
    156a:	779c                	ld	a5,40(a5)
    156c:	f8f43c23          	sd	a5,-104(s0)
    1570:	f9843783          	ld	a5,-104(s0)
    1574:	fd878793          	addi	a5,a5,-40
    1578:	fcf43023          	sd	a5,-64(s0)
    157c:	fc043783          	ld	a5,-64(s0)
    1580:	02878713          	addi	a4,a5,40
    1584:	649c                	ld	a5,8(s1)
    1586:	fcf711e3          	bne	a4,a5,1548 <schedule_dm+0x158>
            }
        }

        if (smallest_id_thread) {
    158a:	fb043783          	ld	a5,-80(s0)
    158e:	cf89                	beqz	a5,15a8 <schedule_dm+0x1b8>
            r.scheduled_thread_list_member = &smallest_id_thread->thread_list;
    1590:	fb043783          	ld	a5,-80(s0)
    1594:	02878793          	addi	a5,a5,40
    1598:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = smallest_id_thread->remaining_time;
    159c:	fb043783          	ld	a5,-80(s0)
    15a0:	4fbc                	lw	a5,88(a5)
    15a2:	f6f42823          	sw	a5,-144(s0)
    15a6:	a839                	j	15c4 <schedule_dm+0x1d4>
        } else {
            // If no thread is ready, perhaps idle or find the next release time
            r.scheduled_thread_list_member = args.run_queue;
    15a8:	649c                	ld	a5,8(s1)
    15aa:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    15ae:	689c                	ld	a5,16(s1)
    15b0:	4098                	lw	a4,0(s1)
    15b2:	85ba                	mv	a1,a4
    15b4:	853e                	mv	a0,a5
    15b6:	00000097          	auipc	ra,0x0
    15ba:	b8c080e7          	jalr	-1140(ra) # 1142 <find_next_release_time>
    15be:	87aa                	mv	a5,a0
    15c0:	f6f42823          	sw	a5,-144(s0)
        }
    }

    return r;
    15c4:	f6843783          	ld	a5,-152(s0)
    15c8:	f6f43c23          	sd	a5,-136(s0)
    15cc:	f7043783          	ld	a5,-144(s0)
    15d0:	f8f43023          	sd	a5,-128(s0)
    15d4:	4701                	li	a4,0
    15d6:	f7843703          	ld	a4,-136(s0)
    15da:	4781                	li	a5,0
    15dc:	f8043783          	ld	a5,-128(s0)
    15e0:	893a                	mv	s2,a4
    15e2:	89be                	mv	s3,a5
    15e4:	874a                	mv	a4,s2
    15e6:	87ce                	mv	a5,s3
}
    15e8:	853a                	mv	a0,a4
    15ea:	85be                	mv	a1,a5
    15ec:	60ea                	ld	ra,152(sp)
    15ee:	644a                	ld	s0,144(sp)
    15f0:	64aa                	ld	s1,136(sp)
    15f2:	690a                	ld	s2,128(sp)
    15f4:	79e6                	ld	s3,120(sp)
    15f6:	610d                	addi	sp,sp,160
    15f8:	8082                	ret
