
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
       0:	1141                	addi	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	addi	s0,sp,16
  if(fork() > 0)
       8:	00000097          	auipc	ra,0x0
       c:	4aa080e7          	jalr	1194(ra) # 4b2 <fork>
      10:	87aa                	mv	a5,a0
      12:	00f05763          	blez	a5,20 <main+0x20>
    sleep(5);  // Let child exit before parent.
      16:	4515                	li	a0,5
      18:	00000097          	auipc	ra,0x0
      1c:	532080e7          	jalr	1330(ra) # 54a <sleep>
  exit(0);
      20:	4501                	li	a0,0
      22:	00000097          	auipc	ra,0x0
      26:	498080e7          	jalr	1176(ra) # 4ba <exit>

000000000000002a <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
      2a:	7179                	addi	sp,sp,-48
      2c:	f422                	sd	s0,40(sp)
      2e:	1800                	addi	s0,sp,48
      30:	fca43c23          	sd	a0,-40(s0)
      34:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
      38:	fd843783          	ld	a5,-40(s0)
      3c:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
      40:	0001                	nop
      42:	fd043703          	ld	a4,-48(s0)
      46:	00170793          	addi	a5,a4,1
      4a:	fcf43823          	sd	a5,-48(s0)
      4e:	fd843783          	ld	a5,-40(s0)
      52:	00178693          	addi	a3,a5,1
      56:	fcd43c23          	sd	a3,-40(s0)
      5a:	00074703          	lbu	a4,0(a4)
      5e:	00e78023          	sb	a4,0(a5)
      62:	0007c783          	lbu	a5,0(a5)
      66:	fff1                	bnez	a5,42 <strcpy+0x18>
    ;
  return os;
      68:	fe843783          	ld	a5,-24(s0)
}
      6c:	853e                	mv	a0,a5
      6e:	7422                	ld	s0,40(sp)
      70:	6145                	addi	sp,sp,48
      72:	8082                	ret

0000000000000074 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      74:	1101                	addi	sp,sp,-32
      76:	ec22                	sd	s0,24(sp)
      78:	1000                	addi	s0,sp,32
      7a:	fea43423          	sd	a0,-24(s0)
      7e:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
      82:	a819                	j	98 <strcmp+0x24>
    p++, q++;
      84:	fe843783          	ld	a5,-24(s0)
      88:	0785                	addi	a5,a5,1
      8a:	fef43423          	sd	a5,-24(s0)
      8e:	fe043783          	ld	a5,-32(s0)
      92:	0785                	addi	a5,a5,1
      94:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
      98:	fe843783          	ld	a5,-24(s0)
      9c:	0007c783          	lbu	a5,0(a5)
      a0:	cb99                	beqz	a5,b6 <strcmp+0x42>
      a2:	fe843783          	ld	a5,-24(s0)
      a6:	0007c703          	lbu	a4,0(a5)
      aa:	fe043783          	ld	a5,-32(s0)
      ae:	0007c783          	lbu	a5,0(a5)
      b2:	fcf709e3          	beq	a4,a5,84 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
      b6:	fe843783          	ld	a5,-24(s0)
      ba:	0007c783          	lbu	a5,0(a5)
      be:	0007871b          	sext.w	a4,a5
      c2:	fe043783          	ld	a5,-32(s0)
      c6:	0007c783          	lbu	a5,0(a5)
      ca:	2781                	sext.w	a5,a5
      cc:	40f707bb          	subw	a5,a4,a5
      d0:	2781                	sext.w	a5,a5
}
      d2:	853e                	mv	a0,a5
      d4:	6462                	ld	s0,24(sp)
      d6:	6105                	addi	sp,sp,32
      d8:	8082                	ret

00000000000000da <strlen>:

uint
strlen(const char *s)
{
      da:	7179                	addi	sp,sp,-48
      dc:	f422                	sd	s0,40(sp)
      de:	1800                	addi	s0,sp,48
      e0:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
      e4:	fe042623          	sw	zero,-20(s0)
      e8:	a031                	j	f4 <strlen+0x1a>
      ea:	fec42783          	lw	a5,-20(s0)
      ee:	2785                	addiw	a5,a5,1
      f0:	fef42623          	sw	a5,-20(s0)
      f4:	fec42783          	lw	a5,-20(s0)
      f8:	fd843703          	ld	a4,-40(s0)
      fc:	97ba                	add	a5,a5,a4
      fe:	0007c783          	lbu	a5,0(a5)
     102:	f7e5                	bnez	a5,ea <strlen+0x10>
    ;
  return n;
     104:	fec42783          	lw	a5,-20(s0)
}
     108:	853e                	mv	a0,a5
     10a:	7422                	ld	s0,40(sp)
     10c:	6145                	addi	sp,sp,48
     10e:	8082                	ret

0000000000000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
     110:	7179                	addi	sp,sp,-48
     112:	f422                	sd	s0,40(sp)
     114:	1800                	addi	s0,sp,48
     116:	fca43c23          	sd	a0,-40(s0)
     11a:	87ae                	mv	a5,a1
     11c:	8732                	mv	a4,a2
     11e:	fcf42a23          	sw	a5,-44(s0)
     122:	87ba                	mv	a5,a4
     124:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     128:	fd843783          	ld	a5,-40(s0)
     12c:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     130:	fe042623          	sw	zero,-20(s0)
     134:	a00d                	j	156 <memset+0x46>
    cdst[i] = c;
     136:	fec42783          	lw	a5,-20(s0)
     13a:	fe043703          	ld	a4,-32(s0)
     13e:	97ba                	add	a5,a5,a4
     140:	fd442703          	lw	a4,-44(s0)
     144:	0ff77713          	andi	a4,a4,255
     148:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     14c:	fec42783          	lw	a5,-20(s0)
     150:	2785                	addiw	a5,a5,1
     152:	fef42623          	sw	a5,-20(s0)
     156:	fec42703          	lw	a4,-20(s0)
     15a:	fd042783          	lw	a5,-48(s0)
     15e:	2781                	sext.w	a5,a5
     160:	fcf76be3          	bltu	a4,a5,136 <memset+0x26>
  }
  return dst;
     164:	fd843783          	ld	a5,-40(s0)
}
     168:	853e                	mv	a0,a5
     16a:	7422                	ld	s0,40(sp)
     16c:	6145                	addi	sp,sp,48
     16e:	8082                	ret

0000000000000170 <strchr>:

char*
strchr(const char *s, char c)
{
     170:	1101                	addi	sp,sp,-32
     172:	ec22                	sd	s0,24(sp)
     174:	1000                	addi	s0,sp,32
     176:	fea43423          	sd	a0,-24(s0)
     17a:	87ae                	mv	a5,a1
     17c:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     180:	a01d                	j	1a6 <strchr+0x36>
    if(*s == c)
     182:	fe843783          	ld	a5,-24(s0)
     186:	0007c703          	lbu	a4,0(a5)
     18a:	fe744783          	lbu	a5,-25(s0)
     18e:	0ff7f793          	andi	a5,a5,255
     192:	00e79563          	bne	a5,a4,19c <strchr+0x2c>
      return (char*)s;
     196:	fe843783          	ld	a5,-24(s0)
     19a:	a821                	j	1b2 <strchr+0x42>
  for(; *s; s++)
     19c:	fe843783          	ld	a5,-24(s0)
     1a0:	0785                	addi	a5,a5,1
     1a2:	fef43423          	sd	a5,-24(s0)
     1a6:	fe843783          	ld	a5,-24(s0)
     1aa:	0007c783          	lbu	a5,0(a5)
     1ae:	fbf1                	bnez	a5,182 <strchr+0x12>
  return 0;
     1b0:	4781                	li	a5,0
}
     1b2:	853e                	mv	a0,a5
     1b4:	6462                	ld	s0,24(sp)
     1b6:	6105                	addi	sp,sp,32
     1b8:	8082                	ret

00000000000001ba <gets>:

char*
gets(char *buf, int max)
{
     1ba:	7179                	addi	sp,sp,-48
     1bc:	f406                	sd	ra,40(sp)
     1be:	f022                	sd	s0,32(sp)
     1c0:	1800                	addi	s0,sp,48
     1c2:	fca43c23          	sd	a0,-40(s0)
     1c6:	87ae                	mv	a5,a1
     1c8:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     1cc:	fe042623          	sw	zero,-20(s0)
     1d0:	a8a1                	j	228 <gets+0x6e>
    cc = read(0, &c, 1);
     1d2:	fe740793          	addi	a5,s0,-25
     1d6:	4605                	li	a2,1
     1d8:	85be                	mv	a1,a5
     1da:	4501                	li	a0,0
     1dc:	00000097          	auipc	ra,0x0
     1e0:	2f6080e7          	jalr	758(ra) # 4d2 <read>
     1e4:	87aa                	mv	a5,a0
     1e6:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     1ea:	fe842783          	lw	a5,-24(s0)
     1ee:	2781                	sext.w	a5,a5
     1f0:	04f05763          	blez	a5,23e <gets+0x84>
      break;
    buf[i++] = c;
     1f4:	fec42783          	lw	a5,-20(s0)
     1f8:	0017871b          	addiw	a4,a5,1
     1fc:	fee42623          	sw	a4,-20(s0)
     200:	873e                	mv	a4,a5
     202:	fd843783          	ld	a5,-40(s0)
     206:	97ba                	add	a5,a5,a4
     208:	fe744703          	lbu	a4,-25(s0)
     20c:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     210:	fe744783          	lbu	a5,-25(s0)
     214:	873e                	mv	a4,a5
     216:	47a9                	li	a5,10
     218:	02f70463          	beq	a4,a5,240 <gets+0x86>
     21c:	fe744783          	lbu	a5,-25(s0)
     220:	873e                	mv	a4,a5
     222:	47b5                	li	a5,13
     224:	00f70e63          	beq	a4,a5,240 <gets+0x86>
  for(i=0; i+1 < max; ){
     228:	fec42783          	lw	a5,-20(s0)
     22c:	2785                	addiw	a5,a5,1
     22e:	0007871b          	sext.w	a4,a5
     232:	fd442783          	lw	a5,-44(s0)
     236:	2781                	sext.w	a5,a5
     238:	f8f74de3          	blt	a4,a5,1d2 <gets+0x18>
     23c:	a011                	j	240 <gets+0x86>
      break;
     23e:	0001                	nop
      break;
  }
  buf[i] = '\0';
     240:	fec42783          	lw	a5,-20(s0)
     244:	fd843703          	ld	a4,-40(s0)
     248:	97ba                	add	a5,a5,a4
     24a:	00078023          	sb	zero,0(a5)
  return buf;
     24e:	fd843783          	ld	a5,-40(s0)
}
     252:	853e                	mv	a0,a5
     254:	70a2                	ld	ra,40(sp)
     256:	7402                	ld	s0,32(sp)
     258:	6145                	addi	sp,sp,48
     25a:	8082                	ret

000000000000025c <stat>:

int
stat(const char *n, struct stat *st)
{
     25c:	7179                	addi	sp,sp,-48
     25e:	f406                	sd	ra,40(sp)
     260:	f022                	sd	s0,32(sp)
     262:	1800                	addi	s0,sp,48
     264:	fca43c23          	sd	a0,-40(s0)
     268:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     26c:	4581                	li	a1,0
     26e:	fd843503          	ld	a0,-40(s0)
     272:	00000097          	auipc	ra,0x0
     276:	288080e7          	jalr	648(ra) # 4fa <open>
     27a:	87aa                	mv	a5,a0
     27c:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     280:	fec42783          	lw	a5,-20(s0)
     284:	2781                	sext.w	a5,a5
     286:	0007d463          	bgez	a5,28e <stat+0x32>
    return -1;
     28a:	57fd                	li	a5,-1
     28c:	a035                	j	2b8 <stat+0x5c>
  r = fstat(fd, st);
     28e:	fec42783          	lw	a5,-20(s0)
     292:	fd043583          	ld	a1,-48(s0)
     296:	853e                	mv	a0,a5
     298:	00000097          	auipc	ra,0x0
     29c:	27a080e7          	jalr	634(ra) # 512 <fstat>
     2a0:	87aa                	mv	a5,a0
     2a2:	fef42423          	sw	a5,-24(s0)
  close(fd);
     2a6:	fec42783          	lw	a5,-20(s0)
     2aa:	853e                	mv	a0,a5
     2ac:	00000097          	auipc	ra,0x0
     2b0:	236080e7          	jalr	566(ra) # 4e2 <close>
  return r;
     2b4:	fe842783          	lw	a5,-24(s0)
}
     2b8:	853e                	mv	a0,a5
     2ba:	70a2                	ld	ra,40(sp)
     2bc:	7402                	ld	s0,32(sp)
     2be:	6145                	addi	sp,sp,48
     2c0:	8082                	ret

00000000000002c2 <atoi>:

int
atoi(const char *s)
{
     2c2:	7179                	addi	sp,sp,-48
     2c4:	f422                	sd	s0,40(sp)
     2c6:	1800                	addi	s0,sp,48
     2c8:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     2cc:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     2d0:	a815                	j	304 <atoi+0x42>
    n = n*10 + *s++ - '0';
     2d2:	fec42703          	lw	a4,-20(s0)
     2d6:	87ba                	mv	a5,a4
     2d8:	0027979b          	slliw	a5,a5,0x2
     2dc:	9fb9                	addw	a5,a5,a4
     2de:	0017979b          	slliw	a5,a5,0x1
     2e2:	0007871b          	sext.w	a4,a5
     2e6:	fd843783          	ld	a5,-40(s0)
     2ea:	00178693          	addi	a3,a5,1
     2ee:	fcd43c23          	sd	a3,-40(s0)
     2f2:	0007c783          	lbu	a5,0(a5)
     2f6:	2781                	sext.w	a5,a5
     2f8:	9fb9                	addw	a5,a5,a4
     2fa:	2781                	sext.w	a5,a5
     2fc:	fd07879b          	addiw	a5,a5,-48
     300:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     304:	fd843783          	ld	a5,-40(s0)
     308:	0007c783          	lbu	a5,0(a5)
     30c:	873e                	mv	a4,a5
     30e:	02f00793          	li	a5,47
     312:	00e7fb63          	bgeu	a5,a4,328 <atoi+0x66>
     316:	fd843783          	ld	a5,-40(s0)
     31a:	0007c783          	lbu	a5,0(a5)
     31e:	873e                	mv	a4,a5
     320:	03900793          	li	a5,57
     324:	fae7f7e3          	bgeu	a5,a4,2d2 <atoi+0x10>
  return n;
     328:	fec42783          	lw	a5,-20(s0)
}
     32c:	853e                	mv	a0,a5
     32e:	7422                	ld	s0,40(sp)
     330:	6145                	addi	sp,sp,48
     332:	8082                	ret

0000000000000334 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     334:	7139                	addi	sp,sp,-64
     336:	fc22                	sd	s0,56(sp)
     338:	0080                	addi	s0,sp,64
     33a:	fca43c23          	sd	a0,-40(s0)
     33e:	fcb43823          	sd	a1,-48(s0)
     342:	87b2                	mv	a5,a2
     344:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     348:	fd843783          	ld	a5,-40(s0)
     34c:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     350:	fd043783          	ld	a5,-48(s0)
     354:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     358:	fe043703          	ld	a4,-32(s0)
     35c:	fe843783          	ld	a5,-24(s0)
     360:	02e7fc63          	bgeu	a5,a4,398 <memmove+0x64>
    while(n-- > 0)
     364:	a00d                	j	386 <memmove+0x52>
      *dst++ = *src++;
     366:	fe043703          	ld	a4,-32(s0)
     36a:	00170793          	addi	a5,a4,1
     36e:	fef43023          	sd	a5,-32(s0)
     372:	fe843783          	ld	a5,-24(s0)
     376:	00178693          	addi	a3,a5,1
     37a:	fed43423          	sd	a3,-24(s0)
     37e:	00074703          	lbu	a4,0(a4)
     382:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     386:	fcc42783          	lw	a5,-52(s0)
     38a:	fff7871b          	addiw	a4,a5,-1
     38e:	fce42623          	sw	a4,-52(s0)
     392:	fcf04ae3          	bgtz	a5,366 <memmove+0x32>
     396:	a891                	j	3ea <memmove+0xb6>
  } else {
    dst += n;
     398:	fcc42783          	lw	a5,-52(s0)
     39c:	fe843703          	ld	a4,-24(s0)
     3a0:	97ba                	add	a5,a5,a4
     3a2:	fef43423          	sd	a5,-24(s0)
    src += n;
     3a6:	fcc42783          	lw	a5,-52(s0)
     3aa:	fe043703          	ld	a4,-32(s0)
     3ae:	97ba                	add	a5,a5,a4
     3b0:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     3b4:	a01d                	j	3da <memmove+0xa6>
      *--dst = *--src;
     3b6:	fe043783          	ld	a5,-32(s0)
     3ba:	17fd                	addi	a5,a5,-1
     3bc:	fef43023          	sd	a5,-32(s0)
     3c0:	fe843783          	ld	a5,-24(s0)
     3c4:	17fd                	addi	a5,a5,-1
     3c6:	fef43423          	sd	a5,-24(s0)
     3ca:	fe043783          	ld	a5,-32(s0)
     3ce:	0007c703          	lbu	a4,0(a5)
     3d2:	fe843783          	ld	a5,-24(s0)
     3d6:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     3da:	fcc42783          	lw	a5,-52(s0)
     3de:	fff7871b          	addiw	a4,a5,-1
     3e2:	fce42623          	sw	a4,-52(s0)
     3e6:	fcf048e3          	bgtz	a5,3b6 <memmove+0x82>
  }
  return vdst;
     3ea:	fd843783          	ld	a5,-40(s0)
}
     3ee:	853e                	mv	a0,a5
     3f0:	7462                	ld	s0,56(sp)
     3f2:	6121                	addi	sp,sp,64
     3f4:	8082                	ret

00000000000003f6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     3f6:	7139                	addi	sp,sp,-64
     3f8:	fc22                	sd	s0,56(sp)
     3fa:	0080                	addi	s0,sp,64
     3fc:	fca43c23          	sd	a0,-40(s0)
     400:	fcb43823          	sd	a1,-48(s0)
     404:	87b2                	mv	a5,a2
     406:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     40a:	fd843783          	ld	a5,-40(s0)
     40e:	fef43423          	sd	a5,-24(s0)
     412:	fd043783          	ld	a5,-48(s0)
     416:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     41a:	a0a1                	j	462 <memcmp+0x6c>
    if (*p1 != *p2) {
     41c:	fe843783          	ld	a5,-24(s0)
     420:	0007c703          	lbu	a4,0(a5)
     424:	fe043783          	ld	a5,-32(s0)
     428:	0007c783          	lbu	a5,0(a5)
     42c:	02f70163          	beq	a4,a5,44e <memcmp+0x58>
      return *p1 - *p2;
     430:	fe843783          	ld	a5,-24(s0)
     434:	0007c783          	lbu	a5,0(a5)
     438:	0007871b          	sext.w	a4,a5
     43c:	fe043783          	ld	a5,-32(s0)
     440:	0007c783          	lbu	a5,0(a5)
     444:	2781                	sext.w	a5,a5
     446:	40f707bb          	subw	a5,a4,a5
     44a:	2781                	sext.w	a5,a5
     44c:	a01d                	j	472 <memcmp+0x7c>
    }
    p1++;
     44e:	fe843783          	ld	a5,-24(s0)
     452:	0785                	addi	a5,a5,1
     454:	fef43423          	sd	a5,-24(s0)
    p2++;
     458:	fe043783          	ld	a5,-32(s0)
     45c:	0785                	addi	a5,a5,1
     45e:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     462:	fcc42783          	lw	a5,-52(s0)
     466:	fff7871b          	addiw	a4,a5,-1
     46a:	fce42623          	sw	a4,-52(s0)
     46e:	f7dd                	bnez	a5,41c <memcmp+0x26>
  }
  return 0;
     470:	4781                	li	a5,0
}
     472:	853e                	mv	a0,a5
     474:	7462                	ld	s0,56(sp)
     476:	6121                	addi	sp,sp,64
     478:	8082                	ret

000000000000047a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     47a:	7179                	addi	sp,sp,-48
     47c:	f406                	sd	ra,40(sp)
     47e:	f022                	sd	s0,32(sp)
     480:	1800                	addi	s0,sp,48
     482:	fea43423          	sd	a0,-24(s0)
     486:	feb43023          	sd	a1,-32(s0)
     48a:	87b2                	mv	a5,a2
     48c:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     490:	fdc42783          	lw	a5,-36(s0)
     494:	863e                	mv	a2,a5
     496:	fe043583          	ld	a1,-32(s0)
     49a:	fe843503          	ld	a0,-24(s0)
     49e:	00000097          	auipc	ra,0x0
     4a2:	e96080e7          	jalr	-362(ra) # 334 <memmove>
     4a6:	87aa                	mv	a5,a0
}
     4a8:	853e                	mv	a0,a5
     4aa:	70a2                	ld	ra,40(sp)
     4ac:	7402                	ld	s0,32(sp)
     4ae:	6145                	addi	sp,sp,48
     4b0:	8082                	ret

00000000000004b2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     4b2:	4885                	li	a7,1
 ecall
     4b4:	00000073          	ecall
 ret
     4b8:	8082                	ret

00000000000004ba <exit>:
.global exit
exit:
 li a7, SYS_exit
     4ba:	4889                	li	a7,2
 ecall
     4bc:	00000073          	ecall
 ret
     4c0:	8082                	ret

00000000000004c2 <wait>:
.global wait
wait:
 li a7, SYS_wait
     4c2:	488d                	li	a7,3
 ecall
     4c4:	00000073          	ecall
 ret
     4c8:	8082                	ret

00000000000004ca <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     4ca:	4891                	li	a7,4
 ecall
     4cc:	00000073          	ecall
 ret
     4d0:	8082                	ret

00000000000004d2 <read>:
.global read
read:
 li a7, SYS_read
     4d2:	4895                	li	a7,5
 ecall
     4d4:	00000073          	ecall
 ret
     4d8:	8082                	ret

00000000000004da <write>:
.global write
write:
 li a7, SYS_write
     4da:	48c1                	li	a7,16
 ecall
     4dc:	00000073          	ecall
 ret
     4e0:	8082                	ret

00000000000004e2 <close>:
.global close
close:
 li a7, SYS_close
     4e2:	48d5                	li	a7,21
 ecall
     4e4:	00000073          	ecall
 ret
     4e8:	8082                	ret

00000000000004ea <kill>:
.global kill
kill:
 li a7, SYS_kill
     4ea:	4899                	li	a7,6
 ecall
     4ec:	00000073          	ecall
 ret
     4f0:	8082                	ret

00000000000004f2 <exec>:
.global exec
exec:
 li a7, SYS_exec
     4f2:	489d                	li	a7,7
 ecall
     4f4:	00000073          	ecall
 ret
     4f8:	8082                	ret

00000000000004fa <open>:
.global open
open:
 li a7, SYS_open
     4fa:	48bd                	li	a7,15
 ecall
     4fc:	00000073          	ecall
 ret
     500:	8082                	ret

0000000000000502 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     502:	48c5                	li	a7,17
 ecall
     504:	00000073          	ecall
 ret
     508:	8082                	ret

000000000000050a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     50a:	48c9                	li	a7,18
 ecall
     50c:	00000073          	ecall
 ret
     510:	8082                	ret

0000000000000512 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     512:	48a1                	li	a7,8
 ecall
     514:	00000073          	ecall
 ret
     518:	8082                	ret

000000000000051a <link>:
.global link
link:
 li a7, SYS_link
     51a:	48cd                	li	a7,19
 ecall
     51c:	00000073          	ecall
 ret
     520:	8082                	ret

0000000000000522 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     522:	48d1                	li	a7,20
 ecall
     524:	00000073          	ecall
 ret
     528:	8082                	ret

000000000000052a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     52a:	48a5                	li	a7,9
 ecall
     52c:	00000073          	ecall
 ret
     530:	8082                	ret

0000000000000532 <dup>:
.global dup
dup:
 li a7, SYS_dup
     532:	48a9                	li	a7,10
 ecall
     534:	00000073          	ecall
 ret
     538:	8082                	ret

000000000000053a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     53a:	48ad                	li	a7,11
 ecall
     53c:	00000073          	ecall
 ret
     540:	8082                	ret

0000000000000542 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     542:	48b1                	li	a7,12
 ecall
     544:	00000073          	ecall
 ret
     548:	8082                	ret

000000000000054a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     54a:	48b5                	li	a7,13
 ecall
     54c:	00000073          	ecall
 ret
     550:	8082                	ret

0000000000000552 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     552:	48b9                	li	a7,14
 ecall
     554:	00000073          	ecall
 ret
     558:	8082                	ret

000000000000055a <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     55a:	48d9                	li	a7,22
 ecall
     55c:	00000073          	ecall
 ret
     560:	8082                	ret

0000000000000562 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     562:	48dd                	li	a7,23
 ecall
     564:	00000073          	ecall
 ret
     568:	8082                	ret

000000000000056a <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     56a:	48e1                	li	a7,24
 ecall
     56c:	00000073          	ecall
 ret
     570:	8082                	ret

0000000000000572 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     572:	1101                	addi	sp,sp,-32
     574:	ec06                	sd	ra,24(sp)
     576:	e822                	sd	s0,16(sp)
     578:	1000                	addi	s0,sp,32
     57a:	87aa                	mv	a5,a0
     57c:	872e                	mv	a4,a1
     57e:	fef42623          	sw	a5,-20(s0)
     582:	87ba                	mv	a5,a4
     584:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     588:	feb40713          	addi	a4,s0,-21
     58c:	fec42783          	lw	a5,-20(s0)
     590:	4605                	li	a2,1
     592:	85ba                	mv	a1,a4
     594:	853e                	mv	a0,a5
     596:	00000097          	auipc	ra,0x0
     59a:	f44080e7          	jalr	-188(ra) # 4da <write>
}
     59e:	0001                	nop
     5a0:	60e2                	ld	ra,24(sp)
     5a2:	6442                	ld	s0,16(sp)
     5a4:	6105                	addi	sp,sp,32
     5a6:	8082                	ret

00000000000005a8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     5a8:	7139                	addi	sp,sp,-64
     5aa:	fc06                	sd	ra,56(sp)
     5ac:	f822                	sd	s0,48(sp)
     5ae:	0080                	addi	s0,sp,64
     5b0:	87aa                	mv	a5,a0
     5b2:	8736                	mv	a4,a3
     5b4:	fcf42623          	sw	a5,-52(s0)
     5b8:	87ae                	mv	a5,a1
     5ba:	fcf42423          	sw	a5,-56(s0)
     5be:	87b2                	mv	a5,a2
     5c0:	fcf42223          	sw	a5,-60(s0)
     5c4:	87ba                	mv	a5,a4
     5c6:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     5ca:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     5ce:	fc042783          	lw	a5,-64(s0)
     5d2:	2781                	sext.w	a5,a5
     5d4:	c38d                	beqz	a5,5f6 <printint+0x4e>
     5d6:	fc842783          	lw	a5,-56(s0)
     5da:	2781                	sext.w	a5,a5
     5dc:	0007dd63          	bgez	a5,5f6 <printint+0x4e>
    neg = 1;
     5e0:	4785                	li	a5,1
     5e2:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     5e6:	fc842783          	lw	a5,-56(s0)
     5ea:	40f007bb          	negw	a5,a5
     5ee:	2781                	sext.w	a5,a5
     5f0:	fef42223          	sw	a5,-28(s0)
     5f4:	a029                	j	5fe <printint+0x56>
  } else {
    x = xx;
     5f6:	fc842783          	lw	a5,-56(s0)
     5fa:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     5fe:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     602:	fc442783          	lw	a5,-60(s0)
     606:	fe442703          	lw	a4,-28(s0)
     60a:	02f777bb          	remuw	a5,a4,a5
     60e:	0007861b          	sext.w	a2,a5
     612:	fec42783          	lw	a5,-20(s0)
     616:	0017871b          	addiw	a4,a5,1
     61a:	fee42623          	sw	a4,-20(s0)
     61e:	00001697          	auipc	a3,0x1
     622:	e8a68693          	addi	a3,a3,-374 # 14a8 <digits>
     626:	02061713          	slli	a4,a2,0x20
     62a:	9301                	srli	a4,a4,0x20
     62c:	9736                	add	a4,a4,a3
     62e:	00074703          	lbu	a4,0(a4)
     632:	ff040693          	addi	a3,s0,-16
     636:	97b6                	add	a5,a5,a3
     638:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     63c:	fc442783          	lw	a5,-60(s0)
     640:	fe442703          	lw	a4,-28(s0)
     644:	02f757bb          	divuw	a5,a4,a5
     648:	fef42223          	sw	a5,-28(s0)
     64c:	fe442783          	lw	a5,-28(s0)
     650:	2781                	sext.w	a5,a5
     652:	fbc5                	bnez	a5,602 <printint+0x5a>
  if(neg)
     654:	fe842783          	lw	a5,-24(s0)
     658:	2781                	sext.w	a5,a5
     65a:	cf95                	beqz	a5,696 <printint+0xee>
    buf[i++] = '-';
     65c:	fec42783          	lw	a5,-20(s0)
     660:	0017871b          	addiw	a4,a5,1
     664:	fee42623          	sw	a4,-20(s0)
     668:	ff040713          	addi	a4,s0,-16
     66c:	97ba                	add	a5,a5,a4
     66e:	02d00713          	li	a4,45
     672:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     676:	a005                	j	696 <printint+0xee>
    putc(fd, buf[i]);
     678:	fec42783          	lw	a5,-20(s0)
     67c:	ff040713          	addi	a4,s0,-16
     680:	97ba                	add	a5,a5,a4
     682:	fe07c703          	lbu	a4,-32(a5)
     686:	fcc42783          	lw	a5,-52(s0)
     68a:	85ba                	mv	a1,a4
     68c:	853e                	mv	a0,a5
     68e:	00000097          	auipc	ra,0x0
     692:	ee4080e7          	jalr	-284(ra) # 572 <putc>
  while(--i >= 0)
     696:	fec42783          	lw	a5,-20(s0)
     69a:	37fd                	addiw	a5,a5,-1
     69c:	fef42623          	sw	a5,-20(s0)
     6a0:	fec42783          	lw	a5,-20(s0)
     6a4:	2781                	sext.w	a5,a5
     6a6:	fc07d9e3          	bgez	a5,678 <printint+0xd0>
}
     6aa:	0001                	nop
     6ac:	0001                	nop
     6ae:	70e2                	ld	ra,56(sp)
     6b0:	7442                	ld	s0,48(sp)
     6b2:	6121                	addi	sp,sp,64
     6b4:	8082                	ret

00000000000006b6 <printptr>:

static void
printptr(int fd, uint64 x) {
     6b6:	7179                	addi	sp,sp,-48
     6b8:	f406                	sd	ra,40(sp)
     6ba:	f022                	sd	s0,32(sp)
     6bc:	1800                	addi	s0,sp,48
     6be:	87aa                	mv	a5,a0
     6c0:	fcb43823          	sd	a1,-48(s0)
     6c4:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     6c8:	fdc42783          	lw	a5,-36(s0)
     6cc:	03000593          	li	a1,48
     6d0:	853e                	mv	a0,a5
     6d2:	00000097          	auipc	ra,0x0
     6d6:	ea0080e7          	jalr	-352(ra) # 572 <putc>
  putc(fd, 'x');
     6da:	fdc42783          	lw	a5,-36(s0)
     6de:	07800593          	li	a1,120
     6e2:	853e                	mv	a0,a5
     6e4:	00000097          	auipc	ra,0x0
     6e8:	e8e080e7          	jalr	-370(ra) # 572 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     6ec:	fe042623          	sw	zero,-20(s0)
     6f0:	a82d                	j	72a <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     6f2:	fd043783          	ld	a5,-48(s0)
     6f6:	93f1                	srli	a5,a5,0x3c
     6f8:	00001717          	auipc	a4,0x1
     6fc:	db070713          	addi	a4,a4,-592 # 14a8 <digits>
     700:	97ba                	add	a5,a5,a4
     702:	0007c703          	lbu	a4,0(a5)
     706:	fdc42783          	lw	a5,-36(s0)
     70a:	85ba                	mv	a1,a4
     70c:	853e                	mv	a0,a5
     70e:	00000097          	auipc	ra,0x0
     712:	e64080e7          	jalr	-412(ra) # 572 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     716:	fec42783          	lw	a5,-20(s0)
     71a:	2785                	addiw	a5,a5,1
     71c:	fef42623          	sw	a5,-20(s0)
     720:	fd043783          	ld	a5,-48(s0)
     724:	0792                	slli	a5,a5,0x4
     726:	fcf43823          	sd	a5,-48(s0)
     72a:	fec42783          	lw	a5,-20(s0)
     72e:	873e                	mv	a4,a5
     730:	47bd                	li	a5,15
     732:	fce7f0e3          	bgeu	a5,a4,6f2 <printptr+0x3c>
}
     736:	0001                	nop
     738:	0001                	nop
     73a:	70a2                	ld	ra,40(sp)
     73c:	7402                	ld	s0,32(sp)
     73e:	6145                	addi	sp,sp,48
     740:	8082                	ret

0000000000000742 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     742:	715d                	addi	sp,sp,-80
     744:	e486                	sd	ra,72(sp)
     746:	e0a2                	sd	s0,64(sp)
     748:	0880                	addi	s0,sp,80
     74a:	87aa                	mv	a5,a0
     74c:	fcb43023          	sd	a1,-64(s0)
     750:	fac43c23          	sd	a2,-72(s0)
     754:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     758:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     75c:	fe042223          	sw	zero,-28(s0)
     760:	a42d                	j	98a <vprintf+0x248>
    c = fmt[i] & 0xff;
     762:	fe442783          	lw	a5,-28(s0)
     766:	fc043703          	ld	a4,-64(s0)
     76a:	97ba                	add	a5,a5,a4
     76c:	0007c783          	lbu	a5,0(a5)
     770:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     774:	fe042783          	lw	a5,-32(s0)
     778:	2781                	sext.w	a5,a5
     77a:	eb9d                	bnez	a5,7b0 <vprintf+0x6e>
      if(c == '%'){
     77c:	fdc42783          	lw	a5,-36(s0)
     780:	0007871b          	sext.w	a4,a5
     784:	02500793          	li	a5,37
     788:	00f71763          	bne	a4,a5,796 <vprintf+0x54>
        state = '%';
     78c:	02500793          	li	a5,37
     790:	fef42023          	sw	a5,-32(s0)
     794:	a2f5                	j	980 <vprintf+0x23e>
      } else {
        putc(fd, c);
     796:	fdc42783          	lw	a5,-36(s0)
     79a:	0ff7f713          	andi	a4,a5,255
     79e:	fcc42783          	lw	a5,-52(s0)
     7a2:	85ba                	mv	a1,a4
     7a4:	853e                	mv	a0,a5
     7a6:	00000097          	auipc	ra,0x0
     7aa:	dcc080e7          	jalr	-564(ra) # 572 <putc>
     7ae:	aac9                	j	980 <vprintf+0x23e>
      }
    } else if(state == '%'){
     7b0:	fe042783          	lw	a5,-32(s0)
     7b4:	0007871b          	sext.w	a4,a5
     7b8:	02500793          	li	a5,37
     7bc:	1cf71263          	bne	a4,a5,980 <vprintf+0x23e>
      if(c == 'd'){
     7c0:	fdc42783          	lw	a5,-36(s0)
     7c4:	0007871b          	sext.w	a4,a5
     7c8:	06400793          	li	a5,100
     7cc:	02f71463          	bne	a4,a5,7f4 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     7d0:	fb843783          	ld	a5,-72(s0)
     7d4:	00878713          	addi	a4,a5,8
     7d8:	fae43c23          	sd	a4,-72(s0)
     7dc:	4398                	lw	a4,0(a5)
     7de:	fcc42783          	lw	a5,-52(s0)
     7e2:	4685                	li	a3,1
     7e4:	4629                	li	a2,10
     7e6:	85ba                	mv	a1,a4
     7e8:	853e                	mv	a0,a5
     7ea:	00000097          	auipc	ra,0x0
     7ee:	dbe080e7          	jalr	-578(ra) # 5a8 <printint>
     7f2:	a269                	j	97c <vprintf+0x23a>
      } else if(c == 'l') {
     7f4:	fdc42783          	lw	a5,-36(s0)
     7f8:	0007871b          	sext.w	a4,a5
     7fc:	06c00793          	li	a5,108
     800:	02f71663          	bne	a4,a5,82c <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     804:	fb843783          	ld	a5,-72(s0)
     808:	00878713          	addi	a4,a5,8
     80c:	fae43c23          	sd	a4,-72(s0)
     810:	639c                	ld	a5,0(a5)
     812:	0007871b          	sext.w	a4,a5
     816:	fcc42783          	lw	a5,-52(s0)
     81a:	4681                	li	a3,0
     81c:	4629                	li	a2,10
     81e:	85ba                	mv	a1,a4
     820:	853e                	mv	a0,a5
     822:	00000097          	auipc	ra,0x0
     826:	d86080e7          	jalr	-634(ra) # 5a8 <printint>
     82a:	aa89                	j	97c <vprintf+0x23a>
      } else if(c == 'x') {
     82c:	fdc42783          	lw	a5,-36(s0)
     830:	0007871b          	sext.w	a4,a5
     834:	07800793          	li	a5,120
     838:	02f71463          	bne	a4,a5,860 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     83c:	fb843783          	ld	a5,-72(s0)
     840:	00878713          	addi	a4,a5,8
     844:	fae43c23          	sd	a4,-72(s0)
     848:	4398                	lw	a4,0(a5)
     84a:	fcc42783          	lw	a5,-52(s0)
     84e:	4681                	li	a3,0
     850:	4641                	li	a2,16
     852:	85ba                	mv	a1,a4
     854:	853e                	mv	a0,a5
     856:	00000097          	auipc	ra,0x0
     85a:	d52080e7          	jalr	-686(ra) # 5a8 <printint>
     85e:	aa39                	j	97c <vprintf+0x23a>
      } else if(c == 'p') {
     860:	fdc42783          	lw	a5,-36(s0)
     864:	0007871b          	sext.w	a4,a5
     868:	07000793          	li	a5,112
     86c:	02f71263          	bne	a4,a5,890 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     870:	fb843783          	ld	a5,-72(s0)
     874:	00878713          	addi	a4,a5,8
     878:	fae43c23          	sd	a4,-72(s0)
     87c:	6398                	ld	a4,0(a5)
     87e:	fcc42783          	lw	a5,-52(s0)
     882:	85ba                	mv	a1,a4
     884:	853e                	mv	a0,a5
     886:	00000097          	auipc	ra,0x0
     88a:	e30080e7          	jalr	-464(ra) # 6b6 <printptr>
     88e:	a0fd                	j	97c <vprintf+0x23a>
      } else if(c == 's'){
     890:	fdc42783          	lw	a5,-36(s0)
     894:	0007871b          	sext.w	a4,a5
     898:	07300793          	li	a5,115
     89c:	04f71c63          	bne	a4,a5,8f4 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     8a0:	fb843783          	ld	a5,-72(s0)
     8a4:	00878713          	addi	a4,a5,8
     8a8:	fae43c23          	sd	a4,-72(s0)
     8ac:	639c                	ld	a5,0(a5)
     8ae:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     8b2:	fe843783          	ld	a5,-24(s0)
     8b6:	eb8d                	bnez	a5,8e8 <vprintf+0x1a6>
          s = "(null)";
     8b8:	00001797          	auipc	a5,0x1
     8bc:	be878793          	addi	a5,a5,-1048 # 14a0 <schedule_dm+0x210>
     8c0:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     8c4:	a015                	j	8e8 <vprintf+0x1a6>
          putc(fd, *s);
     8c6:	fe843783          	ld	a5,-24(s0)
     8ca:	0007c703          	lbu	a4,0(a5)
     8ce:	fcc42783          	lw	a5,-52(s0)
     8d2:	85ba                	mv	a1,a4
     8d4:	853e                	mv	a0,a5
     8d6:	00000097          	auipc	ra,0x0
     8da:	c9c080e7          	jalr	-868(ra) # 572 <putc>
          s++;
     8de:	fe843783          	ld	a5,-24(s0)
     8e2:	0785                	addi	a5,a5,1
     8e4:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     8e8:	fe843783          	ld	a5,-24(s0)
     8ec:	0007c783          	lbu	a5,0(a5)
     8f0:	fbf9                	bnez	a5,8c6 <vprintf+0x184>
     8f2:	a069                	j	97c <vprintf+0x23a>
        }
      } else if(c == 'c'){
     8f4:	fdc42783          	lw	a5,-36(s0)
     8f8:	0007871b          	sext.w	a4,a5
     8fc:	06300793          	li	a5,99
     900:	02f71463          	bne	a4,a5,928 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     904:	fb843783          	ld	a5,-72(s0)
     908:	00878713          	addi	a4,a5,8
     90c:	fae43c23          	sd	a4,-72(s0)
     910:	439c                	lw	a5,0(a5)
     912:	0ff7f713          	andi	a4,a5,255
     916:	fcc42783          	lw	a5,-52(s0)
     91a:	85ba                	mv	a1,a4
     91c:	853e                	mv	a0,a5
     91e:	00000097          	auipc	ra,0x0
     922:	c54080e7          	jalr	-940(ra) # 572 <putc>
     926:	a899                	j	97c <vprintf+0x23a>
      } else if(c == '%'){
     928:	fdc42783          	lw	a5,-36(s0)
     92c:	0007871b          	sext.w	a4,a5
     930:	02500793          	li	a5,37
     934:	00f71f63          	bne	a4,a5,952 <vprintf+0x210>
        putc(fd, c);
     938:	fdc42783          	lw	a5,-36(s0)
     93c:	0ff7f713          	andi	a4,a5,255
     940:	fcc42783          	lw	a5,-52(s0)
     944:	85ba                	mv	a1,a4
     946:	853e                	mv	a0,a5
     948:	00000097          	auipc	ra,0x0
     94c:	c2a080e7          	jalr	-982(ra) # 572 <putc>
     950:	a035                	j	97c <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     952:	fcc42783          	lw	a5,-52(s0)
     956:	02500593          	li	a1,37
     95a:	853e                	mv	a0,a5
     95c:	00000097          	auipc	ra,0x0
     960:	c16080e7          	jalr	-1002(ra) # 572 <putc>
        putc(fd, c);
     964:	fdc42783          	lw	a5,-36(s0)
     968:	0ff7f713          	andi	a4,a5,255
     96c:	fcc42783          	lw	a5,-52(s0)
     970:	85ba                	mv	a1,a4
     972:	853e                	mv	a0,a5
     974:	00000097          	auipc	ra,0x0
     978:	bfe080e7          	jalr	-1026(ra) # 572 <putc>
      }
      state = 0;
     97c:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     980:	fe442783          	lw	a5,-28(s0)
     984:	2785                	addiw	a5,a5,1
     986:	fef42223          	sw	a5,-28(s0)
     98a:	fe442783          	lw	a5,-28(s0)
     98e:	fc043703          	ld	a4,-64(s0)
     992:	97ba                	add	a5,a5,a4
     994:	0007c783          	lbu	a5,0(a5)
     998:	dc0795e3          	bnez	a5,762 <vprintf+0x20>
    }
  }
}
     99c:	0001                	nop
     99e:	0001                	nop
     9a0:	60a6                	ld	ra,72(sp)
     9a2:	6406                	ld	s0,64(sp)
     9a4:	6161                	addi	sp,sp,80
     9a6:	8082                	ret

00000000000009a8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     9a8:	7159                	addi	sp,sp,-112
     9aa:	fc06                	sd	ra,56(sp)
     9ac:	f822                	sd	s0,48(sp)
     9ae:	0080                	addi	s0,sp,64
     9b0:	fcb43823          	sd	a1,-48(s0)
     9b4:	e010                	sd	a2,0(s0)
     9b6:	e414                	sd	a3,8(s0)
     9b8:	e818                	sd	a4,16(s0)
     9ba:	ec1c                	sd	a5,24(s0)
     9bc:	03043023          	sd	a6,32(s0)
     9c0:	03143423          	sd	a7,40(s0)
     9c4:	87aa                	mv	a5,a0
     9c6:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     9ca:	03040793          	addi	a5,s0,48
     9ce:	fcf43423          	sd	a5,-56(s0)
     9d2:	fc843783          	ld	a5,-56(s0)
     9d6:	fd078793          	addi	a5,a5,-48
     9da:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     9de:	fe843703          	ld	a4,-24(s0)
     9e2:	fdc42783          	lw	a5,-36(s0)
     9e6:	863a                	mv	a2,a4
     9e8:	fd043583          	ld	a1,-48(s0)
     9ec:	853e                	mv	a0,a5
     9ee:	00000097          	auipc	ra,0x0
     9f2:	d54080e7          	jalr	-684(ra) # 742 <vprintf>
}
     9f6:	0001                	nop
     9f8:	70e2                	ld	ra,56(sp)
     9fa:	7442                	ld	s0,48(sp)
     9fc:	6165                	addi	sp,sp,112
     9fe:	8082                	ret

0000000000000a00 <printf>:

void
printf(const char *fmt, ...)
{
     a00:	7159                	addi	sp,sp,-112
     a02:	f406                	sd	ra,40(sp)
     a04:	f022                	sd	s0,32(sp)
     a06:	1800                	addi	s0,sp,48
     a08:	fca43c23          	sd	a0,-40(s0)
     a0c:	e40c                	sd	a1,8(s0)
     a0e:	e810                	sd	a2,16(s0)
     a10:	ec14                	sd	a3,24(s0)
     a12:	f018                	sd	a4,32(s0)
     a14:	f41c                	sd	a5,40(s0)
     a16:	03043823          	sd	a6,48(s0)
     a1a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     a1e:	04040793          	addi	a5,s0,64
     a22:	fcf43823          	sd	a5,-48(s0)
     a26:	fd043783          	ld	a5,-48(s0)
     a2a:	fc878793          	addi	a5,a5,-56
     a2e:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     a32:	fe843783          	ld	a5,-24(s0)
     a36:	863e                	mv	a2,a5
     a38:	fd843583          	ld	a1,-40(s0)
     a3c:	4505                	li	a0,1
     a3e:	00000097          	auipc	ra,0x0
     a42:	d04080e7          	jalr	-764(ra) # 742 <vprintf>
}
     a46:	0001                	nop
     a48:	70a2                	ld	ra,40(sp)
     a4a:	7402                	ld	s0,32(sp)
     a4c:	6165                	addi	sp,sp,112
     a4e:	8082                	ret

0000000000000a50 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     a50:	7179                	addi	sp,sp,-48
     a52:	f422                	sd	s0,40(sp)
     a54:	1800                	addi	s0,sp,48
     a56:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     a5a:	fd843783          	ld	a5,-40(s0)
     a5e:	17c1                	addi	a5,a5,-16
     a60:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     a64:	00001797          	auipc	a5,0x1
     a68:	a6c78793          	addi	a5,a5,-1428 # 14d0 <freep>
     a6c:	639c                	ld	a5,0(a5)
     a6e:	fef43423          	sd	a5,-24(s0)
     a72:	a815                	j	aa6 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     a74:	fe843783          	ld	a5,-24(s0)
     a78:	639c                	ld	a5,0(a5)
     a7a:	fe843703          	ld	a4,-24(s0)
     a7e:	00f76f63          	bltu	a4,a5,a9c <free+0x4c>
     a82:	fe043703          	ld	a4,-32(s0)
     a86:	fe843783          	ld	a5,-24(s0)
     a8a:	02e7eb63          	bltu	a5,a4,ac0 <free+0x70>
     a8e:	fe843783          	ld	a5,-24(s0)
     a92:	639c                	ld	a5,0(a5)
     a94:	fe043703          	ld	a4,-32(s0)
     a98:	02f76463          	bltu	a4,a5,ac0 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     a9c:	fe843783          	ld	a5,-24(s0)
     aa0:	639c                	ld	a5,0(a5)
     aa2:	fef43423          	sd	a5,-24(s0)
     aa6:	fe043703          	ld	a4,-32(s0)
     aaa:	fe843783          	ld	a5,-24(s0)
     aae:	fce7f3e3          	bgeu	a5,a4,a74 <free+0x24>
     ab2:	fe843783          	ld	a5,-24(s0)
     ab6:	639c                	ld	a5,0(a5)
     ab8:	fe043703          	ld	a4,-32(s0)
     abc:	faf77ce3          	bgeu	a4,a5,a74 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     ac0:	fe043783          	ld	a5,-32(s0)
     ac4:	479c                	lw	a5,8(a5)
     ac6:	1782                	slli	a5,a5,0x20
     ac8:	9381                	srli	a5,a5,0x20
     aca:	0792                	slli	a5,a5,0x4
     acc:	fe043703          	ld	a4,-32(s0)
     ad0:	973e                	add	a4,a4,a5
     ad2:	fe843783          	ld	a5,-24(s0)
     ad6:	639c                	ld	a5,0(a5)
     ad8:	02f71763          	bne	a4,a5,b06 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     adc:	fe043783          	ld	a5,-32(s0)
     ae0:	4798                	lw	a4,8(a5)
     ae2:	fe843783          	ld	a5,-24(s0)
     ae6:	639c                	ld	a5,0(a5)
     ae8:	479c                	lw	a5,8(a5)
     aea:	9fb9                	addw	a5,a5,a4
     aec:	0007871b          	sext.w	a4,a5
     af0:	fe043783          	ld	a5,-32(s0)
     af4:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     af6:	fe843783          	ld	a5,-24(s0)
     afa:	639c                	ld	a5,0(a5)
     afc:	6398                	ld	a4,0(a5)
     afe:	fe043783          	ld	a5,-32(s0)
     b02:	e398                	sd	a4,0(a5)
     b04:	a039                	j	b12 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     b06:	fe843783          	ld	a5,-24(s0)
     b0a:	6398                	ld	a4,0(a5)
     b0c:	fe043783          	ld	a5,-32(s0)
     b10:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     b12:	fe843783          	ld	a5,-24(s0)
     b16:	479c                	lw	a5,8(a5)
     b18:	1782                	slli	a5,a5,0x20
     b1a:	9381                	srli	a5,a5,0x20
     b1c:	0792                	slli	a5,a5,0x4
     b1e:	fe843703          	ld	a4,-24(s0)
     b22:	97ba                	add	a5,a5,a4
     b24:	fe043703          	ld	a4,-32(s0)
     b28:	02f71563          	bne	a4,a5,b52 <free+0x102>
    p->s.size += bp->s.size;
     b2c:	fe843783          	ld	a5,-24(s0)
     b30:	4798                	lw	a4,8(a5)
     b32:	fe043783          	ld	a5,-32(s0)
     b36:	479c                	lw	a5,8(a5)
     b38:	9fb9                	addw	a5,a5,a4
     b3a:	0007871b          	sext.w	a4,a5
     b3e:	fe843783          	ld	a5,-24(s0)
     b42:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     b44:	fe043783          	ld	a5,-32(s0)
     b48:	6398                	ld	a4,0(a5)
     b4a:	fe843783          	ld	a5,-24(s0)
     b4e:	e398                	sd	a4,0(a5)
     b50:	a031                	j	b5c <free+0x10c>
  } else
    p->s.ptr = bp;
     b52:	fe843783          	ld	a5,-24(s0)
     b56:	fe043703          	ld	a4,-32(s0)
     b5a:	e398                	sd	a4,0(a5)
  freep = p;
     b5c:	00001797          	auipc	a5,0x1
     b60:	97478793          	addi	a5,a5,-1676 # 14d0 <freep>
     b64:	fe843703          	ld	a4,-24(s0)
     b68:	e398                	sd	a4,0(a5)
}
     b6a:	0001                	nop
     b6c:	7422                	ld	s0,40(sp)
     b6e:	6145                	addi	sp,sp,48
     b70:	8082                	ret

0000000000000b72 <morecore>:

static Header*
morecore(uint nu)
{
     b72:	7179                	addi	sp,sp,-48
     b74:	f406                	sd	ra,40(sp)
     b76:	f022                	sd	s0,32(sp)
     b78:	1800                	addi	s0,sp,48
     b7a:	87aa                	mv	a5,a0
     b7c:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     b80:	fdc42783          	lw	a5,-36(s0)
     b84:	0007871b          	sext.w	a4,a5
     b88:	6785                	lui	a5,0x1
     b8a:	00f77563          	bgeu	a4,a5,b94 <morecore+0x22>
    nu = 4096;
     b8e:	6785                	lui	a5,0x1
     b90:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     b94:	fdc42783          	lw	a5,-36(s0)
     b98:	0047979b          	slliw	a5,a5,0x4
     b9c:	2781                	sext.w	a5,a5
     b9e:	2781                	sext.w	a5,a5
     ba0:	853e                	mv	a0,a5
     ba2:	00000097          	auipc	ra,0x0
     ba6:	9a0080e7          	jalr	-1632(ra) # 542 <sbrk>
     baa:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     bae:	fe843703          	ld	a4,-24(s0)
     bb2:	57fd                	li	a5,-1
     bb4:	00f71463          	bne	a4,a5,bbc <morecore+0x4a>
    return 0;
     bb8:	4781                	li	a5,0
     bba:	a03d                	j	be8 <morecore+0x76>
  hp = (Header*)p;
     bbc:	fe843783          	ld	a5,-24(s0)
     bc0:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     bc4:	fe043783          	ld	a5,-32(s0)
     bc8:	fdc42703          	lw	a4,-36(s0)
     bcc:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     bce:	fe043783          	ld	a5,-32(s0)
     bd2:	07c1                	addi	a5,a5,16
     bd4:	853e                	mv	a0,a5
     bd6:	00000097          	auipc	ra,0x0
     bda:	e7a080e7          	jalr	-390(ra) # a50 <free>
  return freep;
     bde:	00001797          	auipc	a5,0x1
     be2:	8f278793          	addi	a5,a5,-1806 # 14d0 <freep>
     be6:	639c                	ld	a5,0(a5)
}
     be8:	853e                	mv	a0,a5
     bea:	70a2                	ld	ra,40(sp)
     bec:	7402                	ld	s0,32(sp)
     bee:	6145                	addi	sp,sp,48
     bf0:	8082                	ret

0000000000000bf2 <malloc>:

void*
malloc(uint nbytes)
{
     bf2:	7139                	addi	sp,sp,-64
     bf4:	fc06                	sd	ra,56(sp)
     bf6:	f822                	sd	s0,48(sp)
     bf8:	0080                	addi	s0,sp,64
     bfa:	87aa                	mv	a5,a0
     bfc:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     c00:	fcc46783          	lwu	a5,-52(s0)
     c04:	07bd                	addi	a5,a5,15
     c06:	8391                	srli	a5,a5,0x4
     c08:	2781                	sext.w	a5,a5
     c0a:	2785                	addiw	a5,a5,1
     c0c:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     c10:	00001797          	auipc	a5,0x1
     c14:	8c078793          	addi	a5,a5,-1856 # 14d0 <freep>
     c18:	639c                	ld	a5,0(a5)
     c1a:	fef43023          	sd	a5,-32(s0)
     c1e:	fe043783          	ld	a5,-32(s0)
     c22:	ef95                	bnez	a5,c5e <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     c24:	00001797          	auipc	a5,0x1
     c28:	89c78793          	addi	a5,a5,-1892 # 14c0 <base>
     c2c:	fef43023          	sd	a5,-32(s0)
     c30:	00001797          	auipc	a5,0x1
     c34:	8a078793          	addi	a5,a5,-1888 # 14d0 <freep>
     c38:	fe043703          	ld	a4,-32(s0)
     c3c:	e398                	sd	a4,0(a5)
     c3e:	00001797          	auipc	a5,0x1
     c42:	89278793          	addi	a5,a5,-1902 # 14d0 <freep>
     c46:	6398                	ld	a4,0(a5)
     c48:	00001797          	auipc	a5,0x1
     c4c:	87878793          	addi	a5,a5,-1928 # 14c0 <base>
     c50:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     c52:	00001797          	auipc	a5,0x1
     c56:	86e78793          	addi	a5,a5,-1938 # 14c0 <base>
     c5a:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     c5e:	fe043783          	ld	a5,-32(s0)
     c62:	639c                	ld	a5,0(a5)
     c64:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     c68:	fe843783          	ld	a5,-24(s0)
     c6c:	4798                	lw	a4,8(a5)
     c6e:	fdc42783          	lw	a5,-36(s0)
     c72:	2781                	sext.w	a5,a5
     c74:	06f76863          	bltu	a4,a5,ce4 <malloc+0xf2>
      if(p->s.size == nunits)
     c78:	fe843783          	ld	a5,-24(s0)
     c7c:	4798                	lw	a4,8(a5)
     c7e:	fdc42783          	lw	a5,-36(s0)
     c82:	2781                	sext.w	a5,a5
     c84:	00e79963          	bne	a5,a4,c96 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     c88:	fe843783          	ld	a5,-24(s0)
     c8c:	6398                	ld	a4,0(a5)
     c8e:	fe043783          	ld	a5,-32(s0)
     c92:	e398                	sd	a4,0(a5)
     c94:	a82d                	j	cce <malloc+0xdc>
      else {
        p->s.size -= nunits;
     c96:	fe843783          	ld	a5,-24(s0)
     c9a:	4798                	lw	a4,8(a5)
     c9c:	fdc42783          	lw	a5,-36(s0)
     ca0:	40f707bb          	subw	a5,a4,a5
     ca4:	0007871b          	sext.w	a4,a5
     ca8:	fe843783          	ld	a5,-24(s0)
     cac:	c798                	sw	a4,8(a5)
        p += p->s.size;
     cae:	fe843783          	ld	a5,-24(s0)
     cb2:	479c                	lw	a5,8(a5)
     cb4:	1782                	slli	a5,a5,0x20
     cb6:	9381                	srli	a5,a5,0x20
     cb8:	0792                	slli	a5,a5,0x4
     cba:	fe843703          	ld	a4,-24(s0)
     cbe:	97ba                	add	a5,a5,a4
     cc0:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     cc4:	fe843783          	ld	a5,-24(s0)
     cc8:	fdc42703          	lw	a4,-36(s0)
     ccc:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     cce:	00001797          	auipc	a5,0x1
     cd2:	80278793          	addi	a5,a5,-2046 # 14d0 <freep>
     cd6:	fe043703          	ld	a4,-32(s0)
     cda:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     cdc:	fe843783          	ld	a5,-24(s0)
     ce0:	07c1                	addi	a5,a5,16
     ce2:	a091                	j	d26 <malloc+0x134>
    }
    if(p == freep)
     ce4:	00000797          	auipc	a5,0x0
     ce8:	7ec78793          	addi	a5,a5,2028 # 14d0 <freep>
     cec:	639c                	ld	a5,0(a5)
     cee:	fe843703          	ld	a4,-24(s0)
     cf2:	02f71063          	bne	a4,a5,d12 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     cf6:	fdc42783          	lw	a5,-36(s0)
     cfa:	853e                	mv	a0,a5
     cfc:	00000097          	auipc	ra,0x0
     d00:	e76080e7          	jalr	-394(ra) # b72 <morecore>
     d04:	fea43423          	sd	a0,-24(s0)
     d08:	fe843783          	ld	a5,-24(s0)
     d0c:	e399                	bnez	a5,d12 <malloc+0x120>
        return 0;
     d0e:	4781                	li	a5,0
     d10:	a819                	j	d26 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     d12:	fe843783          	ld	a5,-24(s0)
     d16:	fef43023          	sd	a5,-32(s0)
     d1a:	fe843783          	ld	a5,-24(s0)
     d1e:	639c                	ld	a5,0(a5)
     d20:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     d24:	b791                	j	c68 <malloc+0x76>
  }
}
     d26:	853e                	mv	a0,a5
     d28:	70e2                	ld	ra,56(sp)
     d2a:	7442                	ld	s0,48(sp)
     d2c:	6121                	addi	sp,sp,64
     d2e:	8082                	ret

0000000000000d30 <setjmp>:
     d30:	e100                	sd	s0,0(a0)
     d32:	e504                	sd	s1,8(a0)
     d34:	01253823          	sd	s2,16(a0)
     d38:	01353c23          	sd	s3,24(a0)
     d3c:	03453023          	sd	s4,32(a0)
     d40:	03553423          	sd	s5,40(a0)
     d44:	03653823          	sd	s6,48(a0)
     d48:	03753c23          	sd	s7,56(a0)
     d4c:	05853023          	sd	s8,64(a0)
     d50:	05953423          	sd	s9,72(a0)
     d54:	05a53823          	sd	s10,80(a0)
     d58:	05b53c23          	sd	s11,88(a0)
     d5c:	06153023          	sd	ra,96(a0)
     d60:	06253423          	sd	sp,104(a0)
     d64:	4501                	li	a0,0
     d66:	8082                	ret

0000000000000d68 <longjmp>:
     d68:	6100                	ld	s0,0(a0)
     d6a:	6504                	ld	s1,8(a0)
     d6c:	01053903          	ld	s2,16(a0)
     d70:	01853983          	ld	s3,24(a0)
     d74:	02053a03          	ld	s4,32(a0)
     d78:	02853a83          	ld	s5,40(a0)
     d7c:	03053b03          	ld	s6,48(a0)
     d80:	03853b83          	ld	s7,56(a0)
     d84:	04053c03          	ld	s8,64(a0)
     d88:	04853c83          	ld	s9,72(a0)
     d8c:	05053d03          	ld	s10,80(a0)
     d90:	05853d83          	ld	s11,88(a0)
     d94:	06053083          	ld	ra,96(a0)
     d98:	06853103          	ld	sp,104(a0)
     d9c:	c199                	beqz	a1,da2 <longjmp_1>
     d9e:	852e                	mv	a0,a1
     da0:	8082                	ret

0000000000000da2 <longjmp_1>:
     da2:	4505                	li	a0,1
     da4:	8082                	ret

0000000000000da6 <schedule_default>:
#define INT_MAX 2147483647
#define TIME_QUANTUM 2  // Define a base time quantum for the round-robin

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
     da6:	715d                	addi	sp,sp,-80
     da8:	e4a2                	sd	s0,72(sp)
     daa:	e0a6                	sd	s1,64(sp)
     dac:	0880                	addi	s0,sp,80
     dae:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
     db0:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
     db4:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     db8:	649c                	ld	a5,8(s1)
     dba:	639c                	ld	a5,0(a5)
     dbc:	fcf43c23          	sd	a5,-40(s0)
     dc0:	fd843783          	ld	a5,-40(s0)
     dc4:	fd878793          	addi	a5,a5,-40
     dc8:	fef43023          	sd	a5,-32(s0)
     dcc:	a81d                	j	e02 <schedule_default+0x5c>
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
     dce:	fe843783          	ld	a5,-24(s0)
     dd2:	cb89                	beqz	a5,de4 <schedule_default+0x3e>
     dd4:	fe043783          	ld	a5,-32(s0)
     dd8:	5fd8                	lw	a4,60(a5)
     dda:	fe843783          	ld	a5,-24(s0)
     dde:	5fdc                	lw	a5,60(a5)
     de0:	00f75663          	bge	a4,a5,dec <schedule_default+0x46>
            thread_with_smallest_id = th;
     de4:	fe043783          	ld	a5,-32(s0)
     de8:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     dec:	fe043783          	ld	a5,-32(s0)
     df0:	779c                	ld	a5,40(a5)
     df2:	fcf43823          	sd	a5,-48(s0)
     df6:	fd043783          	ld	a5,-48(s0)
     dfa:	fd878793          	addi	a5,a5,-40
     dfe:	fef43023          	sd	a5,-32(s0)
     e02:	fe043783          	ld	a5,-32(s0)
     e06:	02878713          	addi	a4,a5,40
     e0a:	649c                	ld	a5,8(s1)
     e0c:	fcf711e3          	bne	a4,a5,dce <schedule_default+0x28>
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
     e10:	fe843783          	ld	a5,-24(s0)
     e14:	cf89                	beqz	a5,e2e <schedule_default+0x88>
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
     e16:	fe843783          	ld	a5,-24(s0)
     e1a:	02878793          	addi	a5,a5,40
     e1e:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
     e22:	fe843783          	ld	a5,-24(s0)
     e26:	4fbc                	lw	a5,88(a5)
     e28:	faf42c23          	sw	a5,-72(s0)
     e2c:	a039                	j	e3a <schedule_default+0x94>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
     e2e:	649c                	ld	a5,8(s1)
     e30:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
     e34:	4785                	li	a5,1
     e36:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
     e3a:	fb043783          	ld	a5,-80(s0)
     e3e:	fcf43023          	sd	a5,-64(s0)
     e42:	fb843783          	ld	a5,-72(s0)
     e46:	fcf43423          	sd	a5,-56(s0)
     e4a:	4701                	li	a4,0
     e4c:	fc043703          	ld	a4,-64(s0)
     e50:	4781                	li	a5,0
     e52:	fc843783          	ld	a5,-56(s0)
     e56:	863a                	mv	a2,a4
     e58:	86be                	mv	a3,a5
     e5a:	8732                	mv	a4,a2
     e5c:	87b6                	mv	a5,a3
}
     e5e:	853a                	mv	a0,a4
     e60:	85be                	mv	a1,a5
     e62:	6426                	ld	s0,72(sp)
     e64:	6486                	ld	s1,64(sp)
     e66:	6161                	addi	sp,sp,80
     e68:	8082                	ret

0000000000000e6a <schedule_wrr>:

/* MP3 Part 1 - Non-Real-Time Scheduling */
/* Weighted-Round-Robin Scheduling */
struct threads_sched_result schedule_wrr(struct threads_sched_args args)
{
     e6a:	7159                	addi	sp,sp,-112
     e6c:	f4a2                	sd	s0,104(sp)
     e6e:	f0a6                	sd	s1,96(sp)
     e70:	1880                	addi	s0,sp,112
     e72:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the weighted round-robin scheduling algorithm
    static struct thread *last_thread = NULL;
    struct thread *selected_thread = NULL;
     e74:	fe043423          	sd	zero,-24(s0)
    int max_priority = -1;
     e78:	57fd                	li	a5,-1
     e7a:	fef42223          	sw	a5,-28(s0)

    // If last_thread is NULL or its remaining time is zero, reset the selection process
    if (last_thread == NULL || last_thread->remaining_time <= 0) {
     e7e:	00000797          	auipc	a5,0x0
     e82:	65a78793          	addi	a5,a5,1626 # 14d8 <last_thread.1226>
     e86:	639c                	ld	a5,0(a5)
     e88:	cb89                	beqz	a5,e9a <schedule_wrr+0x30>
     e8a:	00000797          	auipc	a5,0x0
     e8e:	64e78793          	addi	a5,a5,1614 # 14d8 <last_thread.1226>
     e92:	639c                	ld	a5,0(a5)
     e94:	4fbc                	lw	a5,88(a5)
     e96:	00f04863          	bgtz	a5,ea6 <schedule_wrr+0x3c>
        last_thread = NULL;
     e9a:	00000797          	auipc	a5,0x0
     e9e:	63e78793          	addi	a5,a5,1598 # 14d8 <last_thread.1226>
     ea2:	0007b023          	sd	zero,0(a5)
    }

    struct thread *candidate = NULL;
     ea6:	fc043c23          	sd	zero,-40(s0)
    // Select the next thread to run based on weight and ensure round-robin fairness
    list_for_each_entry(candidate, args.run_queue, thread_list) {
     eaa:	649c                	ld	a5,8(s1)
     eac:	639c                	ld	a5,0(a5)
     eae:	fcf43423          	sd	a5,-56(s0)
     eb2:	fc843783          	ld	a5,-56(s0)
     eb6:	fd878793          	addi	a5,a5,-40
     eba:	fcf43c23          	sd	a5,-40(s0)
     ebe:	a8a1                	j	f16 <schedule_wrr+0xac>
        if (candidate != last_thread) {
     ec0:	00000797          	auipc	a5,0x0
     ec4:	61878793          	addi	a5,a5,1560 # 14d8 <last_thread.1226>
     ec8:	639c                	ld	a5,0(a5)
     eca:	fd843703          	ld	a4,-40(s0)
     ece:	02f70963          	beq	a4,a5,f00 <schedule_wrr+0x96>
            int priority = candidate->weight * TIME_QUANTUM;
     ed2:	fd843783          	ld	a5,-40(s0)
     ed6:	47bc                	lw	a5,72(a5)
     ed8:	0017979b          	slliw	a5,a5,0x1
     edc:	fcf42223          	sw	a5,-60(s0)
            if (priority > max_priority) {
     ee0:	fc442703          	lw	a4,-60(s0)
     ee4:	fe442783          	lw	a5,-28(s0)
     ee8:	2701                	sext.w	a4,a4
     eea:	2781                	sext.w	a5,a5
     eec:	00e7da63          	bge	a5,a4,f00 <schedule_wrr+0x96>
                selected_thread = candidate;
     ef0:	fd843783          	ld	a5,-40(s0)
     ef4:	fef43423          	sd	a5,-24(s0)
                max_priority = priority;
     ef8:	fc442783          	lw	a5,-60(s0)
     efc:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(candidate, args.run_queue, thread_list) {
     f00:	fd843783          	ld	a5,-40(s0)
     f04:	779c                	ld	a5,40(a5)
     f06:	faf43c23          	sd	a5,-72(s0)
     f0a:	fb843783          	ld	a5,-72(s0)
     f0e:	fd878793          	addi	a5,a5,-40
     f12:	fcf43c23          	sd	a5,-40(s0)
     f16:	fd843783          	ld	a5,-40(s0)
     f1a:	02878713          	addi	a4,a5,40
     f1e:	649c                	ld	a5,8(s1)
     f20:	faf710e3          	bne	a4,a5,ec0 <schedule_wrr+0x56>
            }
        }
    }

    // Fall back to the last_thread if no other thread is selected and it still has remaining time
    if (!selected_thread && last_thread && last_thread->remaining_time > 0) {
     f24:	fe843783          	ld	a5,-24(s0)
     f28:	e795                	bnez	a5,f54 <schedule_wrr+0xea>
     f2a:	00000797          	auipc	a5,0x0
     f2e:	5ae78793          	addi	a5,a5,1454 # 14d8 <last_thread.1226>
     f32:	639c                	ld	a5,0(a5)
     f34:	c385                	beqz	a5,f54 <schedule_wrr+0xea>
     f36:	00000797          	auipc	a5,0x0
     f3a:	5a278793          	addi	a5,a5,1442 # 14d8 <last_thread.1226>
     f3e:	639c                	ld	a5,0(a5)
     f40:	4fbc                	lw	a5,88(a5)
     f42:	00f05963          	blez	a5,f54 <schedule_wrr+0xea>
        selected_thread = last_thread;
     f46:	00000797          	auipc	a5,0x0
     f4a:	59278793          	addi	a5,a5,1426 # 14d8 <last_thread.1226>
     f4e:	639c                	ld	a5,0(a5)
     f50:	fef43423          	sd	a5,-24(s0)
    }

    // Set the scheduling result
    if (selected_thread) {
     f54:	fe843783          	ld	a5,-24(s0)
     f58:	c7b9                	beqz	a5,fa6 <schedule_wrr+0x13c>
        int time_slice = selected_thread->weight * TIME_QUANTUM;
     f5a:	fe843783          	ld	a5,-24(s0)
     f5e:	47bc                	lw	a5,72(a5)
     f60:	0017979b          	slliw	a5,a5,0x1
     f64:	fcf42a23          	sw	a5,-44(s0)
        if (time_slice > selected_thread->remaining_time) {
     f68:	fe843783          	ld	a5,-24(s0)
     f6c:	4fb8                	lw	a4,88(a5)
     f6e:	fd442783          	lw	a5,-44(s0)
     f72:	2781                	sext.w	a5,a5
     f74:	00f75763          	bge	a4,a5,f82 <schedule_wrr+0x118>
            time_slice = selected_thread->remaining_time;
     f78:	fe843783          	ld	a5,-24(s0)
     f7c:	4fbc                	lw	a5,88(a5)
     f7e:	fcf42a23          	sw	a5,-44(s0)
        }
        r.scheduled_thread_list_member = &selected_thread->thread_list;
     f82:	fe843783          	ld	a5,-24(s0)
     f86:	02878793          	addi	a5,a5,40
     f8a:	f8f43c23          	sd	a5,-104(s0)
        r.allocated_time = time_slice;
     f8e:	fd442783          	lw	a5,-44(s0)
     f92:	faf42023          	sw	a5,-96(s0)
        last_thread = selected_thread;  // Update the last run thread
     f96:	00000797          	auipc	a5,0x0
     f9a:	54278793          	addi	a5,a5,1346 # 14d8 <last_thread.1226>
     f9e:	fe843703          	ld	a4,-24(s0)
     fa2:	e398                	sd	a4,0(a5)
     fa4:	a039                	j	fb2 <schedule_wrr+0x148>
    } else {
        // Idle if no suitable thread is found
        r.scheduled_thread_list_member = args.run_queue;
     fa6:	649c                	ld	a5,8(s1)
     fa8:	f8f43c23          	sd	a5,-104(s0)
        r.allocated_time = 1;
     fac:	4785                	li	a5,1
     fae:	faf42023          	sw	a5,-96(s0)
    }

    return r;
     fb2:	f9843783          	ld	a5,-104(s0)
     fb6:	faf43423          	sd	a5,-88(s0)
     fba:	fa043783          	ld	a5,-96(s0)
     fbe:	faf43823          	sd	a5,-80(s0)
     fc2:	4701                	li	a4,0
     fc4:	fa843703          	ld	a4,-88(s0)
     fc8:	4781                	li	a5,0
     fca:	fb043783          	ld	a5,-80(s0)
     fce:	863a                	mv	a2,a4
     fd0:	86be                	mv	a3,a5
     fd2:	8732                	mv	a4,a2
     fd4:	87b6                	mv	a5,a3
}
     fd6:	853a                	mv	a0,a4
     fd8:	85be                	mv	a1,a5
     fda:	7426                	ld	s0,104(sp)
     fdc:	7486                	ld	s1,96(sp)
     fde:	6165                	addi	sp,sp,112
     fe0:	8082                	ret

0000000000000fe2 <find_next_release_time>:

/* Shortest-Job-First Scheduling */
int find_next_release_time(struct list_head *release_queue, int current_time) {
     fe2:	7139                	addi	sp,sp,-64
     fe4:	fc22                	sd	s0,56(sp)
     fe6:	0080                	addi	s0,sp,64
     fe8:	fca43423          	sd	a0,-56(s0)
     fec:	87ae                	mv	a5,a1
     fee:	fcf42223          	sw	a5,-60(s0)
    struct release_queue_entry *next_release = NULL;
     ff2:	fe043423          	sd	zero,-24(s0)
    int next_release_time = INT_MAX;
     ff6:	800007b7          	lui	a5,0x80000
     ffa:	fff7c793          	not	a5,a5
     ffe:	fef42223          	sw	a5,-28(s0)

    list_for_each_entry(next_release, release_queue, thread_list) {
    1002:	fc843783          	ld	a5,-56(s0)
    1006:	639c                	ld	a5,0(a5)
    1008:	fcf43c23          	sd	a5,-40(s0)
    100c:	fd843783          	ld	a5,-40(s0)
    1010:	17e1                	addi	a5,a5,-8
    1012:	fef43423          	sd	a5,-24(s0)
    1016:	a081                	j	1056 <find_next_release_time+0x74>
        if (next_release->release_time > current_time &&
    1018:	fe843783          	ld	a5,-24(s0)
    101c:	4f98                	lw	a4,24(a5)
    101e:	fc442783          	lw	a5,-60(s0)
    1022:	2781                	sext.w	a5,a5
    1024:	00e7df63          	bge	a5,a4,1042 <find_next_release_time+0x60>
            next_release->release_time < next_release_time) {
    1028:	fe843783          	ld	a5,-24(s0)
    102c:	4f98                	lw	a4,24(a5)
        if (next_release->release_time > current_time &&
    102e:	fe442783          	lw	a5,-28(s0)
    1032:	2781                	sext.w	a5,a5
    1034:	00f75763          	bge	a4,a5,1042 <find_next_release_time+0x60>
            next_release_time = next_release->release_time;
    1038:	fe843783          	ld	a5,-24(s0)
    103c:	4f9c                	lw	a5,24(a5)
    103e:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(next_release, release_queue, thread_list) {
    1042:	fe843783          	ld	a5,-24(s0)
    1046:	679c                	ld	a5,8(a5)
    1048:	fcf43823          	sd	a5,-48(s0)
    104c:	fd043783          	ld	a5,-48(s0)
    1050:	17e1                	addi	a5,a5,-8
    1052:	fef43423          	sd	a5,-24(s0)
    1056:	fe843783          	ld	a5,-24(s0)
    105a:	07a1                	addi	a5,a5,8
    105c:	fc843703          	ld	a4,-56(s0)
    1060:	faf71ce3          	bne	a4,a5,1018 <find_next_release_time+0x36>
        }
    }

    if (next_release_time == INT_MAX)
    1064:	fe442783          	lw	a5,-28(s0)
    1068:	0007871b          	sext.w	a4,a5
    106c:	800007b7          	lui	a5,0x80000
    1070:	fff7c793          	not	a5,a5
    1074:	00f71463          	bne	a4,a5,107c <find_next_release_time+0x9a>
        return -1; // No threads in the release queue
    1078:	57fd                	li	a5,-1
    107a:	a801                	j	108a <find_next_release_time+0xa8>

    return next_release_time - current_time;
    107c:	fe442703          	lw	a4,-28(s0)
    1080:	fc442783          	lw	a5,-60(s0)
    1084:	40f707bb          	subw	a5,a4,a5
    1088:	2781                	sext.w	a5,a5
}
    108a:	853e                	mv	a0,a5
    108c:	7462                	ld	s0,56(sp)
    108e:	6121                	addi	sp,sp,64
    1090:	8082                	ret

0000000000001092 <schedule_sjf>:


struct threads_sched_result schedule_sjf(struct threads_sched_args args)
{
    1092:	711d                	addi	sp,sp,-96
    1094:	eca2                	sd	s0,88(sp)
    1096:	e8a6                	sd	s1,80(sp)
    1098:	1080                	addi	s0,sp,96
    109a:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the shortest-job-first scheduling algorithm
    struct thread *shortest_job = NULL;
    109c:	fe043423          	sd	zero,-24(s0)
    struct thread *t;
    int shortest_time = INT_MAX;
    10a0:	800007b7          	lui	a5,0x80000
    10a4:	fff7c793          	not	a5,a5
    10a8:	fcf42e23          	sw	a5,-36(s0)

    // Find the thread with the shortest remaining time that is ready to run
    list_for_each_entry(t, args.run_queue, thread_list) {
    10ac:	649c                	ld	a5,8(s1)
    10ae:	639c                	ld	a5,0(a5)
    10b0:	fcf43823          	sd	a5,-48(s0)
    10b4:	fd043783          	ld	a5,-48(s0)
    10b8:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe330>
    10bc:	fef43023          	sd	a5,-32(s0)
    10c0:	a82d                	j	10fa <schedule_sjf+0x68>
        if (t->remaining_time < shortest_time) {
    10c2:	fe043783          	ld	a5,-32(s0)
    10c6:	4fb8                	lw	a4,88(a5)
    10c8:	fdc42783          	lw	a5,-36(s0)
    10cc:	2781                	sext.w	a5,a5
    10ce:	00f75b63          	bge	a4,a5,10e4 <schedule_sjf+0x52>
            shortest_time = t->remaining_time;
    10d2:	fe043783          	ld	a5,-32(s0)
    10d6:	4fbc                	lw	a5,88(a5)
    10d8:	fcf42e23          	sw	a5,-36(s0)
            shortest_job = t;
    10dc:	fe043783          	ld	a5,-32(s0)
    10e0:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    10e4:	fe043783          	ld	a5,-32(s0)
    10e8:	779c                	ld	a5,40(a5)
    10ea:	fcf43423          	sd	a5,-56(s0)
    10ee:	fc843783          	ld	a5,-56(s0)
    10f2:	fd878793          	addi	a5,a5,-40
    10f6:	fef43023          	sd	a5,-32(s0)
    10fa:	fe043783          	ld	a5,-32(s0)
    10fe:	02878713          	addi	a4,a5,40
    1102:	649c                	ld	a5,8(s1)
    1104:	faf71fe3          	bne	a4,a5,10c2 <schedule_sjf+0x30>
        }
    }

    if (shortest_job) {
    1108:	fe843783          	ld	a5,-24(s0)
    110c:	cf89                	beqz	a5,1126 <schedule_sjf+0x94>
        r.scheduled_thread_list_member = &shortest_job->thread_list;
    110e:	fe843783          	ld	a5,-24(s0)
    1112:	02878793          	addi	a5,a5,40
    1116:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = shortest_job->remaining_time;  // Allow the thread to run to completion
    111a:	fe843783          	ld	a5,-24(s0)
    111e:	4fbc                	lw	a5,88(a5)
    1120:	faf42823          	sw	a5,-80(s0)
    1124:	a039                	j	1132 <schedule_sjf+0xa0>
    } else {
        // If no threads are ready, find the next release time or idle
        r.scheduled_thread_list_member = args.run_queue;
    1126:	649c                	ld	a5,8(s1)
    1128:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = 1;  // Default minimal quantum if unsure
    112c:	4785                	li	a5,1
    112e:	faf42823          	sw	a5,-80(s0)
    }
    return r;
    1132:	fa843783          	ld	a5,-88(s0)
    1136:	faf43c23          	sd	a5,-72(s0)
    113a:	fb043783          	ld	a5,-80(s0)
    113e:	fcf43023          	sd	a5,-64(s0)
    1142:	4701                	li	a4,0
    1144:	fb843703          	ld	a4,-72(s0)
    1148:	4781                	li	a5,0
    114a:	fc043783          	ld	a5,-64(s0)
    114e:	863a                	mv	a2,a4
    1150:	86be                	mv	a3,a5
    1152:	8732                	mv	a4,a2
    1154:	87b6                	mv	a5,a3
}
    1156:	853a                	mv	a0,a4
    1158:	85be                	mv	a1,a5
    115a:	6466                	ld	s0,88(sp)
    115c:	64c6                	ld	s1,80(sp)
    115e:	6125                	addi	sp,sp,96
    1160:	8082                	ret

0000000000001162 <schedule_lst>:

/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args)
{
    1162:	7119                	addi	sp,sp,-128
    1164:	fc86                	sd	ra,120(sp)
    1166:	f8a2                	sd	s0,112(sp)
    1168:	f4a6                	sd	s1,104(sp)
    116a:	f0ca                	sd	s2,96(sp)
    116c:	ecce                	sd	s3,88(sp)
    116e:	0100                	addi	s0,sp,128
    1170:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the least-slack-time scheduling algorithm
    struct thread *min_slack = NULL;
    1172:	fc043423          	sd	zero,-56(s0)
    int min_slack_time = INT_MAX;
    1176:	800007b7          	lui	a5,0x80000
    117a:	fff7c793          	not	a5,a5
    117e:	fcf42223          	sw	a5,-60(s0)
    struct thread *t;

    // Find the thread with the minimum slack time
    list_for_each_entry(t, args.run_queue, thread_list) {
    1182:	649c                	ld	a5,8(s1)
    1184:	639c                	ld	a5,0(a5)
    1186:	faf43823          	sd	a5,-80(s0)
    118a:	fb043783          	ld	a5,-80(s0)
    118e:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe330>
    1192:	faf43c23          	sd	a5,-72(s0)
    1196:	a8b5                	j	1212 <schedule_lst+0xb0>
        int slack_time = t->deadline - args.current_time - t->remaining_time;
    1198:	fb843783          	ld	a5,-72(s0)
    119c:	47f8                	lw	a4,76(a5)
    119e:	409c                	lw	a5,0(s1)
    11a0:	40f707bb          	subw	a5,a4,a5
    11a4:	0007871b          	sext.w	a4,a5
    11a8:	fb843783          	ld	a5,-72(s0)
    11ac:	4fbc                	lw	a5,88(a5)
    11ae:	40f707bb          	subw	a5,a4,a5
    11b2:	faf42623          	sw	a5,-84(s0)
        if (min_slack == NULL || slack_time < min_slack_time ||
    11b6:	fc843783          	ld	a5,-56(s0)
    11ba:	cb8d                	beqz	a5,11ec <schedule_lst+0x8a>
    11bc:	fac42703          	lw	a4,-84(s0)
    11c0:	fc442783          	lw	a5,-60(s0)
    11c4:	2701                	sext.w	a4,a4
    11c6:	2781                	sext.w	a5,a5
    11c8:	02f74263          	blt	a4,a5,11ec <schedule_lst+0x8a>
    11cc:	fac42703          	lw	a4,-84(s0)
    11d0:	fc442783          	lw	a5,-60(s0)
    11d4:	2701                	sext.w	a4,a4
    11d6:	2781                	sext.w	a5,a5
    11d8:	02f71263          	bne	a4,a5,11fc <schedule_lst+0x9a>
            (slack_time == min_slack_time && t->ID < min_slack->ID)) {
    11dc:	fb843783          	ld	a5,-72(s0)
    11e0:	5fd8                	lw	a4,60(a5)
    11e2:	fc843783          	ld	a5,-56(s0)
    11e6:	5fdc                	lw	a5,60(a5)
    11e8:	00f75a63          	bge	a4,a5,11fc <schedule_lst+0x9a>
            min_slack = t;
    11ec:	fb843783          	ld	a5,-72(s0)
    11f0:	fcf43423          	sd	a5,-56(s0)
            min_slack_time = slack_time;
    11f4:	fac42783          	lw	a5,-84(s0)
    11f8:	fcf42223          	sw	a5,-60(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    11fc:	fb843783          	ld	a5,-72(s0)
    1200:	779c                	ld	a5,40(a5)
    1202:	faf43023          	sd	a5,-96(s0)
    1206:	fa043783          	ld	a5,-96(s0)
    120a:	fd878793          	addi	a5,a5,-40
    120e:	faf43c23          	sd	a5,-72(s0)
    1212:	fb843783          	ld	a5,-72(s0)
    1216:	02878713          	addi	a4,a5,40
    121a:	649c                	ld	a5,8(s1)
    121c:	f6f71ee3          	bne	a4,a5,1198 <schedule_lst+0x36>
        }
    }

    if (min_slack) {
    1220:	fc843783          	ld	a5,-56(s0)
    1224:	cf89                	beqz	a5,123e <schedule_lst+0xdc>
        r.scheduled_thread_list_member = &min_slack->thread_list;
    1226:	fc843783          	ld	a5,-56(s0)
    122a:	02878793          	addi	a5,a5,40
    122e:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = min_slack->remaining_time;
    1232:	fc843783          	ld	a5,-56(s0)
    1236:	4fbc                	lw	a5,88(a5)
    1238:	f8f42423          	sw	a5,-120(s0)
    123c:	a839                	j	125a <schedule_lst+0xf8>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
    123e:	649c                	ld	a5,8(s1)
    1240:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    1244:	689c                	ld	a5,16(s1)
    1246:	4098                	lw	a4,0(s1)
    1248:	85ba                	mv	a1,a4
    124a:	853e                	mv	a0,a5
    124c:	00000097          	auipc	ra,0x0
    1250:	d96080e7          	jalr	-618(ra) # fe2 <find_next_release_time>
    1254:	87aa                	mv	a5,a0
    1256:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    125a:	f8043783          	ld	a5,-128(s0)
    125e:	f8f43823          	sd	a5,-112(s0)
    1262:	f8843783          	ld	a5,-120(s0)
    1266:	f8f43c23          	sd	a5,-104(s0)
    126a:	4701                	li	a4,0
    126c:	f9043703          	ld	a4,-112(s0)
    1270:	4781                	li	a5,0
    1272:	f9843783          	ld	a5,-104(s0)
    1276:	893a                	mv	s2,a4
    1278:	89be                	mv	s3,a5
    127a:	874a                	mv	a4,s2
    127c:	87ce                	mv	a5,s3
}
    127e:	853a                	mv	a0,a4
    1280:	85be                	mv	a1,a5
    1282:	70e6                	ld	ra,120(sp)
    1284:	7446                	ld	s0,112(sp)
    1286:	74a6                	ld	s1,104(sp)
    1288:	7906                	ld	s2,96(sp)
    128a:	69e6                	ld	s3,88(sp)
    128c:	6109                	addi	sp,sp,128
    128e:	8082                	ret

0000000000001290 <schedule_dm>:

/* Deadline-Monotonic Scheduling */
struct threads_sched_result schedule_dm(struct threads_sched_args args)
{
    1290:	7135                	addi	sp,sp,-160
    1292:	ed06                	sd	ra,152(sp)
    1294:	e922                	sd	s0,144(sp)
    1296:	e526                	sd	s1,136(sp)
    1298:	e14a                	sd	s2,128(sp)
    129a:	fcce                	sd	s3,120(sp)
    129c:	1100                	addi	s0,sp,160
    129e:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the deadline-monotonic scheduling algorithm
   struct thread *earliest_deadline_thread = NULL;
    12a0:	fc043423          	sd	zero,-56(s0)
    struct thread *t;
    int earliest_deadline = INT_MAX;
    12a4:	800007b7          	lui	a5,0x80000
    12a8:	fff7c793          	not	a5,a5
    12ac:	faf42e23          	sw	a5,-68(s0)

    // Find the earliest deadline real-time thread
    list_for_each_entry(t, args.run_queue, thread_list) {
    12b0:	649c                	ld	a5,8(s1)
    12b2:	639c                	ld	a5,0(a5)
    12b4:	faf43423          	sd	a5,-88(s0)
    12b8:	fa843783          	ld	a5,-88(s0)
    12bc:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe330>
    12c0:	fcf43023          	sd	a5,-64(s0)
    12c4:	a841                	j	1354 <schedule_dm+0xc4>
        if (t->is_real_time && t->period != -1 && t->current_deadline < earliest_deadline) {
    12c6:	fc043783          	ld	a5,-64(s0)
    12ca:	43bc                	lw	a5,64(a5)
    12cc:	cb95                	beqz	a5,1300 <schedule_dm+0x70>
    12ce:	fc043783          	ld	a5,-64(s0)
    12d2:	4bbc                	lw	a5,80(a5)
    12d4:	873e                	mv	a4,a5
    12d6:	57fd                	li	a5,-1
    12d8:	02f70463          	beq	a4,a5,1300 <schedule_dm+0x70>
    12dc:	fc043783          	ld	a5,-64(s0)
    12e0:	4ff8                	lw	a4,92(a5)
    12e2:	fbc42783          	lw	a5,-68(s0)
    12e6:	2781                	sext.w	a5,a5
    12e8:	00f75c63          	bge	a4,a5,1300 <schedule_dm+0x70>
            earliest_deadline = t->current_deadline;
    12ec:	fc043783          	ld	a5,-64(s0)
    12f0:	4ffc                	lw	a5,92(a5)
    12f2:	faf42e23          	sw	a5,-68(s0)
            earliest_deadline_thread = t;
    12f6:	fc043783          	ld	a5,-64(s0)
    12fa:	fcf43423          	sd	a5,-56(s0)
    12fe:	a081                	j	133e <schedule_dm+0xae>
        } else if (t->is_real_time && t->period != -1 && t->current_deadline == earliest_deadline && t->ID < earliest_deadline_thread->ID) {
    1300:	fc043783          	ld	a5,-64(s0)
    1304:	43bc                	lw	a5,64(a5)
    1306:	cf85                	beqz	a5,133e <schedule_dm+0xae>
    1308:	fc043783          	ld	a5,-64(s0)
    130c:	4bbc                	lw	a5,80(a5)
    130e:	873e                	mv	a4,a5
    1310:	57fd                	li	a5,-1
    1312:	02f70663          	beq	a4,a5,133e <schedule_dm+0xae>
    1316:	fc043783          	ld	a5,-64(s0)
    131a:	4ff8                	lw	a4,92(a5)
    131c:	fbc42783          	lw	a5,-68(s0)
    1320:	2781                	sext.w	a5,a5
    1322:	00e79e63          	bne	a5,a4,133e <schedule_dm+0xae>
    1326:	fc043783          	ld	a5,-64(s0)
    132a:	5fd8                	lw	a4,60(a5)
    132c:	fc843783          	ld	a5,-56(s0)
    1330:	5fdc                	lw	a5,60(a5)
    1332:	00f75663          	bge	a4,a5,133e <schedule_dm+0xae>
            earliest_deadline_thread = t;  // Tie-breaking by ID
    1336:	fc043783          	ld	a5,-64(s0)
    133a:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    133e:	fc043783          	ld	a5,-64(s0)
    1342:	779c                	ld	a5,40(a5)
    1344:	f8f43423          	sd	a5,-120(s0)
    1348:	f8843783          	ld	a5,-120(s0)
    134c:	fd878793          	addi	a5,a5,-40
    1350:	fcf43023          	sd	a5,-64(s0)
    1354:	fc043783          	ld	a5,-64(s0)
    1358:	02878713          	addi	a4,a5,40
    135c:	649c                	ld	a5,8(s1)
    135e:	f6f714e3          	bne	a4,a5,12c6 <schedule_dm+0x36>
        }
    }

    if (earliest_deadline_thread) {
    1362:	fc843783          	ld	a5,-56(s0)
    1366:	c7a5                	beqz	a5,13ce <schedule_dm+0x13e>
        int time_to_deadline = earliest_deadline_thread->current_deadline - args.current_time;
    1368:	fc843783          	ld	a5,-56(s0)
    136c:	4ff8                	lw	a4,92(a5)
    136e:	409c                	lw	a5,0(s1)
    1370:	40f707bb          	subw	a5,a4,a5
    1374:	f8f42a23          	sw	a5,-108(s0)
        if (earliest_deadline_thread->remaining_time > time_to_deadline) {
    1378:	fc843783          	ld	a5,-56(s0)
    137c:	4fb8                	lw	a4,88(a5)
    137e:	f9442783          	lw	a5,-108(s0)
    1382:	2781                	sext.w	a5,a5
    1384:	00e7db63          	bge	a5,a4,139a <schedule_dm+0x10a>
            // The real-time thread cannot complete before its deadline, so handle the deadline miss
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    1388:	fc843783          	ld	a5,-56(s0)
    138c:	02878793          	addi	a5,a5,40
    1390:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = 0; // Could set to minimal quantum to allow cleanup or logging
    1394:	f6042823          	sw	zero,-144(s0)
    1398:	a0f1                	j	1464 <schedule_dm+0x1d4>
        } else {
            // Schedule the real-time thread normally if it hasn't missed its deadline
            int time_slice = (time_to_deadline < earliest_deadline_thread->remaining_time) ? time_to_deadline : earliest_deadline_thread->remaining_time;
    139a:	fc843783          	ld	a5,-56(s0)
    139e:	4fbc                	lw	a5,88(a5)
    13a0:	863e                	mv	a2,a5
    13a2:	f9442783          	lw	a5,-108(s0)
    13a6:	0007869b          	sext.w	a3,a5
    13aa:	0006071b          	sext.w	a4,a2
    13ae:	00d75363          	bge	a4,a3,13b4 <schedule_dm+0x124>
    13b2:	87b2                	mv	a5,a2
    13b4:	f8f42823          	sw	a5,-112(s0)
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    13b8:	fc843783          	ld	a5,-56(s0)
    13bc:	02878793          	addi	a5,a5,40
    13c0:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = time_slice;
    13c4:	f9042783          	lw	a5,-112(s0)
    13c8:	f6f42823          	sw	a5,-144(s0)
    13cc:	a861                	j	1464 <schedule_dm+0x1d4>
        }
    } else {
        // If no real-time threads with a deadline are ready, find the thread with the smallest ID
        struct thread *smallest_id_thread = NULL;
    13ce:	fa043823          	sd	zero,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    13d2:	649c                	ld	a5,8(s1)
    13d4:	639c                	ld	a5,0(a5)
    13d6:	faf43023          	sd	a5,-96(s0)
    13da:	fa043783          	ld	a5,-96(s0)
    13de:	fd878793          	addi	a5,a5,-40
    13e2:	fcf43023          	sd	a5,-64(s0)
    13e6:	a81d                	j	141c <schedule_dm+0x18c>
            if (smallest_id_thread == NULL || t->ID < smallest_id_thread->ID) {
    13e8:	fb043783          	ld	a5,-80(s0)
    13ec:	cb89                	beqz	a5,13fe <schedule_dm+0x16e>
    13ee:	fc043783          	ld	a5,-64(s0)
    13f2:	5fd8                	lw	a4,60(a5)
    13f4:	fb043783          	ld	a5,-80(s0)
    13f8:	5fdc                	lw	a5,60(a5)
    13fa:	00f75663          	bge	a4,a5,1406 <schedule_dm+0x176>
                smallest_id_thread = t;
    13fe:	fc043783          	ld	a5,-64(s0)
    1402:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    1406:	fc043783          	ld	a5,-64(s0)
    140a:	779c                	ld	a5,40(a5)
    140c:	f8f43c23          	sd	a5,-104(s0)
    1410:	f9843783          	ld	a5,-104(s0)
    1414:	fd878793          	addi	a5,a5,-40
    1418:	fcf43023          	sd	a5,-64(s0)
    141c:	fc043783          	ld	a5,-64(s0)
    1420:	02878713          	addi	a4,a5,40
    1424:	649c                	ld	a5,8(s1)
    1426:	fcf711e3          	bne	a4,a5,13e8 <schedule_dm+0x158>
            }
        }

        if (smallest_id_thread) {
    142a:	fb043783          	ld	a5,-80(s0)
    142e:	cf89                	beqz	a5,1448 <schedule_dm+0x1b8>
            r.scheduled_thread_list_member = &smallest_id_thread->thread_list;
    1430:	fb043783          	ld	a5,-80(s0)
    1434:	02878793          	addi	a5,a5,40
    1438:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = smallest_id_thread->remaining_time;
    143c:	fb043783          	ld	a5,-80(s0)
    1440:	4fbc                	lw	a5,88(a5)
    1442:	f6f42823          	sw	a5,-144(s0)
    1446:	a839                	j	1464 <schedule_dm+0x1d4>
        } else {
            // If no thread is ready, perhaps idle or find the next release time
            r.scheduled_thread_list_member = args.run_queue;
    1448:	649c                	ld	a5,8(s1)
    144a:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    144e:	689c                	ld	a5,16(s1)
    1450:	4098                	lw	a4,0(s1)
    1452:	85ba                	mv	a1,a4
    1454:	853e                	mv	a0,a5
    1456:	00000097          	auipc	ra,0x0
    145a:	b8c080e7          	jalr	-1140(ra) # fe2 <find_next_release_time>
    145e:	87aa                	mv	a5,a0
    1460:	f6f42823          	sw	a5,-144(s0)
        }
    }

    return r;
    1464:	f6843783          	ld	a5,-152(s0)
    1468:	f6f43c23          	sd	a5,-136(s0)
    146c:	f7043783          	ld	a5,-144(s0)
    1470:	f8f43023          	sd	a5,-128(s0)
    1474:	4701                	li	a4,0
    1476:	f7843703          	ld	a4,-136(s0)
    147a:	4781                	li	a5,0
    147c:	f8043783          	ld	a5,-128(s0)
    1480:	893a                	mv	s2,a4
    1482:	89be                	mv	s3,a5
    1484:	874a                	mv	a4,s2
    1486:	87ce                	mv	a5,s3
}
    1488:	853a                	mv	a0,a4
    148a:	85be                	mv	a1,a5
    148c:	60ea                	ld	ra,152(sp)
    148e:	644a                	ld	s0,144(sp)
    1490:	64aa                	ld	s1,136(sp)
    1492:	690a                	ld	s2,128(sp)
    1494:	79e6                	ld	s3,120(sp)
    1496:	610d                	addi	sp,sp,160
    1498:	8082                	ret
