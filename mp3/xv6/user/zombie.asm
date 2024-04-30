
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
     622:	eca68693          	addi	a3,a3,-310 # 14e8 <digits>
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
     6fc:	df070713          	addi	a4,a4,-528 # 14e8 <digits>
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
     8bc:	c0078793          	addi	a5,a5,-1024 # 14b8 <schedule_dm+0x210>
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
     a68:	aac78793          	addi	a5,a5,-1364 # 1510 <freep>
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
     b60:	9b478793          	addi	a5,a5,-1612 # 1510 <freep>
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
     be2:	93278793          	addi	a5,a5,-1742 # 1510 <freep>
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
     c14:	90078793          	addi	a5,a5,-1792 # 1510 <freep>
     c18:	639c                	ld	a5,0(a5)
     c1a:	fef43023          	sd	a5,-32(s0)
     c1e:	fe043783          	ld	a5,-32(s0)
     c22:	ef95                	bnez	a5,c5e <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     c24:	00001797          	auipc	a5,0x1
     c28:	8dc78793          	addi	a5,a5,-1828 # 1500 <base>
     c2c:	fef43023          	sd	a5,-32(s0)
     c30:	00001797          	auipc	a5,0x1
     c34:	8e078793          	addi	a5,a5,-1824 # 1510 <freep>
     c38:	fe043703          	ld	a4,-32(s0)
     c3c:	e398                	sd	a4,0(a5)
     c3e:	00001797          	auipc	a5,0x1
     c42:	8d278793          	addi	a5,a5,-1838 # 1510 <freep>
     c46:	6398                	ld	a4,0(a5)
     c48:	00001797          	auipc	a5,0x1
     c4c:	8b878793          	addi	a5,a5,-1864 # 1500 <base>
     c50:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     c52:	00001797          	auipc	a5,0x1
     c56:	8ae78793          	addi	a5,a5,-1874 # 1500 <base>
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
     cd2:	84278793          	addi	a5,a5,-1982 # 1510 <freep>
     cd6:	fe043703          	ld	a4,-32(s0)
     cda:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     cdc:	fe843783          	ld	a5,-24(s0)
     ce0:	07c1                	addi	a5,a5,16
     ce2:	a091                	j	d26 <malloc+0x134>
    }
    if(p == freep)
     ce4:	00001797          	auipc	a5,0x1
     ce8:	82c78793          	addi	a5,a5,-2004 # 1510 <freep>
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
     e6a:	711d                	addi	sp,sp,-96
     e6c:	eca2                	sd	s0,88(sp)
     e6e:	e8a6                	sd	s1,80(sp)
     e70:	1080                	addi	s0,sp,96
     e72:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the weighted round-robin scheduling algorithm
    static struct thread *last_thread = NULL;
    struct thread *selected_thread = NULL;
     e74:	fe043423          	sd	zero,-24(s0)
    struct thread *candidate = NULL;
     e78:	fe043023          	sd	zero,-32(s0)

    // If last_thread is NULL or its remaining time is zero, reset the selection process
    if (last_thread == NULL || last_thread->remaining_time <= 0) {
     e7c:	00000797          	auipc	a5,0x0
     e80:	69c78793          	addi	a5,a5,1692 # 1518 <last_thread.1226>
     e84:	639c                	ld	a5,0(a5)
     e86:	cb89                	beqz	a5,e98 <schedule_wrr+0x2e>
     e88:	00000797          	auipc	a5,0x0
     e8c:	69078793          	addi	a5,a5,1680 # 1518 <last_thread.1226>
     e90:	639c                	ld	a5,0(a5)
     e92:	4fbc                	lw	a5,88(a5)
     e94:	00f04863          	bgtz	a5,ea4 <schedule_wrr+0x3a>
        last_thread = NULL;
     e98:	00000797          	auipc	a5,0x0
     e9c:	68078793          	addi	a5,a5,1664 # 1518 <last_thread.1226>
     ea0:	0007b023          	sd	zero,0(a5)
    }

    // Find the first thread that is ready to run
    list_for_each_entry(candidate, args.run_queue, thread_list) {
     ea4:	649c                	ld	a5,8(s1)
     ea6:	639c                	ld	a5,0(a5)
     ea8:	fcf43823          	sd	a5,-48(s0)
     eac:	fd043783          	ld	a5,-48(s0)
     eb0:	fd878793          	addi	a5,a5,-40
     eb4:	fef43023          	sd	a5,-32(s0)
     eb8:	a0a9                	j	f02 <schedule_wrr+0x98>
        if (!last_thread && candidate->remaining_time > 0)
     eba:	00000797          	auipc	a5,0x0
     ebe:	65e78793          	addi	a5,a5,1630 # 1518 <last_thread.1226>
     ec2:	639c                	ld	a5,0(a5)
     ec4:	eb91                	bnez	a5,ed8 <schedule_wrr+0x6e>
     ec6:	fe043783          	ld	a5,-32(s0)
     eca:	4fbc                	lw	a5,88(a5)
     ecc:	00f05663          	blez	a5,ed8 <schedule_wrr+0x6e>
            selected_thread = candidate;
     ed0:	fe043783          	ld	a5,-32(s0)
     ed4:	fef43423          	sd	a5,-24(s0)
        if (candidate->remaining_time > 0) {
     ed8:	fe043783          	ld	a5,-32(s0)
     edc:	4fbc                	lw	a5,88(a5)
     ede:	00f05763          	blez	a5,eec <schedule_wrr+0x82>
            selected_thread = candidate;
     ee2:	fe043783          	ld	a5,-32(s0)
     ee6:	fef43423          	sd	a5,-24(s0)
            break;
     eea:	a01d                	j	f10 <schedule_wrr+0xa6>
    list_for_each_entry(candidate, args.run_queue, thread_list) {
     eec:	fe043783          	ld	a5,-32(s0)
     ef0:	779c                	ld	a5,40(a5)
     ef2:	fcf43423          	sd	a5,-56(s0)
     ef6:	fc843783          	ld	a5,-56(s0)
     efa:	fd878793          	addi	a5,a5,-40
     efe:	fef43023          	sd	a5,-32(s0)
     f02:	fe043783          	ld	a5,-32(s0)
     f06:	02878713          	addi	a4,a5,40
     f0a:	649c                	ld	a5,8(s1)
     f0c:	faf717e3          	bne	a4,a5,eba <schedule_wrr+0x50>
        }
    }

    // Fall back to the last_thread if no other thread is selected and it still has remaining time
    if (!selected_thread && last_thread && last_thread->remaining_time > 0) {
     f10:	fe843783          	ld	a5,-24(s0)
     f14:	e795                	bnez	a5,f40 <schedule_wrr+0xd6>
     f16:	00000797          	auipc	a5,0x0
     f1a:	60278793          	addi	a5,a5,1538 # 1518 <last_thread.1226>
     f1e:	639c                	ld	a5,0(a5)
     f20:	c385                	beqz	a5,f40 <schedule_wrr+0xd6>
     f22:	00000797          	auipc	a5,0x0
     f26:	5f678793          	addi	a5,a5,1526 # 1518 <last_thread.1226>
     f2a:	639c                	ld	a5,0(a5)
     f2c:	4fbc                	lw	a5,88(a5)
     f2e:	00f05963          	blez	a5,f40 <schedule_wrr+0xd6>
        selected_thread = last_thread;
     f32:	00000797          	auipc	a5,0x0
     f36:	5e678793          	addi	a5,a5,1510 # 1518 <last_thread.1226>
     f3a:	639c                	ld	a5,0(a5)
     f3c:	fef43423          	sd	a5,-24(s0)
    }

    // Set the scheduling result
    if (selected_thread) {
     f40:	fe843783          	ld	a5,-24(s0)
     f44:	c7b9                	beqz	a5,f92 <schedule_wrr+0x128>
        int time_slice = selected_thread->weight * TIME_QUANTUM;
     f46:	fe843783          	ld	a5,-24(s0)
     f4a:	47bc                	lw	a5,72(a5)
     f4c:	0017979b          	slliw	a5,a5,0x1
     f50:	fcf42e23          	sw	a5,-36(s0)
        if (time_slice > selected_thread->remaining_time) {
     f54:	fe843783          	ld	a5,-24(s0)
     f58:	4fb8                	lw	a4,88(a5)
     f5a:	fdc42783          	lw	a5,-36(s0)
     f5e:	2781                	sext.w	a5,a5
     f60:	00f75763          	bge	a4,a5,f6e <schedule_wrr+0x104>
            time_slice = selected_thread->remaining_time;
     f64:	fe843783          	ld	a5,-24(s0)
     f68:	4fbc                	lw	a5,88(a5)
     f6a:	fcf42e23          	sw	a5,-36(s0)
        }
        r.scheduled_thread_list_member = &selected_thread->thread_list;
     f6e:	fe843783          	ld	a5,-24(s0)
     f72:	02878793          	addi	a5,a5,40
     f76:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = time_slice;
     f7a:	fdc42783          	lw	a5,-36(s0)
     f7e:	faf42823          	sw	a5,-80(s0)
        last_thread = selected_thread;  // Update the last run thread
     f82:	00000797          	auipc	a5,0x0
     f86:	59678793          	addi	a5,a5,1430 # 1518 <last_thread.1226>
     f8a:	fe843703          	ld	a4,-24(s0)
     f8e:	e398                	sd	a4,0(a5)
     f90:	a039                	j	f9e <schedule_wrr+0x134>
    } else {
        // Idle if no suitable thread is found
        r.scheduled_thread_list_member = args.run_queue;
     f92:	649c                	ld	a5,8(s1)
     f94:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = 1;
     f98:	4785                	li	a5,1
     f9a:	faf42823          	sw	a5,-80(s0)
    }

    return r;
     f9e:	fa843783          	ld	a5,-88(s0)
     fa2:	faf43c23          	sd	a5,-72(s0)
     fa6:	fb043783          	ld	a5,-80(s0)
     faa:	fcf43023          	sd	a5,-64(s0)
     fae:	4701                	li	a4,0
     fb0:	fb843703          	ld	a4,-72(s0)
     fb4:	4781                	li	a5,0
     fb6:	fc043783          	ld	a5,-64(s0)
     fba:	863a                	mv	a2,a4
     fbc:	86be                	mv	a3,a5
     fbe:	8732                	mv	a4,a2
     fc0:	87b6                	mv	a5,a3
}
     fc2:	853a                	mv	a0,a4
     fc4:	85be                	mv	a1,a5
     fc6:	6466                	ld	s0,88(sp)
     fc8:	64c6                	ld	s1,80(sp)
     fca:	6125                	addi	sp,sp,96
     fcc:	8082                	ret

0000000000000fce <schedule_sjf>:

struct threads_sched_result schedule_sjf(struct threads_sched_args args)
{
     fce:	7119                	addi	sp,sp,-128
     fd0:	fc86                	sd	ra,120(sp)
     fd2:	f8a2                	sd	s0,112(sp)
     fd4:	f4a6                	sd	s1,104(sp)
     fd6:	f0ca                	sd	s2,96(sp)
     fd8:	ecce                	sd	s3,88(sp)
     fda:	0100                	addi	s0,sp,128
     fdc:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the shortest-job-first scheduling algorithm
    struct thread *shortest_job = NULL;
     fde:	fc043423          	sd	zero,-56(s0)
    struct thread *t;
    int shortest_time = INT_MAX;
     fe2:	800007b7          	lui	a5,0x80000
     fe6:	fff7c793          	not	a5,a5
     fea:	faf42e23          	sw	a5,-68(s0)

    // Find the thread with the shortest remaining time that is ready to run
    list_for_each_entry(t, args.run_queue, thread_list) {
     fee:	649c                	ld	a5,8(s1)
     ff0:	639c                	ld	a5,0(a5)
     ff2:	faf43823          	sd	a5,-80(s0)
     ff6:	fb043783          	ld	a5,-80(s0)
     ffa:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe2f0>
     ffe:	fcf43023          	sd	a5,-64(s0)
    1002:	a8a9                	j	105c <schedule_sjf+0x8e>
        printf("Thread ID: %d, Remaining Time: %d\n", t->ID, t->remaining_time);
    1004:	fc043783          	ld	a5,-64(s0)
    1008:	5fd8                	lw	a4,60(a5)
    100a:	fc043783          	ld	a5,-64(s0)
    100e:	4fbc                	lw	a5,88(a5)
    1010:	863e                	mv	a2,a5
    1012:	85ba                	mv	a1,a4
    1014:	00000517          	auipc	a0,0x0
    1018:	4ac50513          	addi	a0,a0,1196 # 14c0 <schedule_dm+0x218>
    101c:	00000097          	auipc	ra,0x0
    1020:	9e4080e7          	jalr	-1564(ra) # a00 <printf>
        if (t->remaining_time < shortest_time) {
    1024:	fc043783          	ld	a5,-64(s0)
    1028:	4fb8                	lw	a4,88(a5)
    102a:	fbc42783          	lw	a5,-68(s0)
    102e:	2781                	sext.w	a5,a5
    1030:	00f75b63          	bge	a4,a5,1046 <schedule_sjf+0x78>
            shortest_time = t->remaining_time;
    1034:	fc043783          	ld	a5,-64(s0)
    1038:	4fbc                	lw	a5,88(a5)
    103a:	faf42e23          	sw	a5,-68(s0)
            shortest_job = t;
    103e:	fc043783          	ld	a5,-64(s0)
    1042:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    1046:	fc043783          	ld	a5,-64(s0)
    104a:	779c                	ld	a5,40(a5)
    104c:	faf43423          	sd	a5,-88(s0)
    1050:	fa843783          	ld	a5,-88(s0)
    1054:	fd878793          	addi	a5,a5,-40
    1058:	fcf43023          	sd	a5,-64(s0)
    105c:	fc043783          	ld	a5,-64(s0)
    1060:	02878713          	addi	a4,a5,40
    1064:	649c                	ld	a5,8(s1)
    1066:	f8f71fe3          	bne	a4,a5,1004 <schedule_sjf+0x36>
        }
    }

    if (shortest_job) {
    106a:	fc843783          	ld	a5,-56(s0)
    106e:	cf89                	beqz	a5,1088 <schedule_sjf+0xba>
        r.scheduled_thread_list_member = &shortest_job->thread_list;
    1070:	fc843783          	ld	a5,-56(s0)
    1074:	02878793          	addi	a5,a5,40
    1078:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = shortest_job->remaining_time;  // Allow the thread to run to completion
    107c:	fc843783          	ld	a5,-56(s0)
    1080:	4fbc                	lw	a5,88(a5)
    1082:	f8f42823          	sw	a5,-112(s0)
    1086:	a039                	j	1094 <schedule_sjf+0xc6>
    } else {
        // If no threads are ready, find the next release time or idle
        r.scheduled_thread_list_member = args.run_queue;
    1088:	649c                	ld	a5,8(s1)
    108a:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = 1;  // Default minimal quantum if unsure
    108e:	4785                	li	a5,1
    1090:	f8f42823          	sw	a5,-112(s0)
    }
    return r;
    1094:	f8843783          	ld	a5,-120(s0)
    1098:	f8f43c23          	sd	a5,-104(s0)
    109c:	f9043783          	ld	a5,-112(s0)
    10a0:	faf43023          	sd	a5,-96(s0)
    10a4:	4701                	li	a4,0
    10a6:	f9843703          	ld	a4,-104(s0)
    10aa:	4781                	li	a5,0
    10ac:	fa043783          	ld	a5,-96(s0)
    10b0:	893a                	mv	s2,a4
    10b2:	89be                	mv	s3,a5
    10b4:	874a                	mv	a4,s2
    10b6:	87ce                	mv	a5,s3
}
    10b8:	853a                	mv	a0,a4
    10ba:	85be                	mv	a1,a5
    10bc:	70e6                	ld	ra,120(sp)
    10be:	7446                	ld	s0,112(sp)
    10c0:	74a6                	ld	s1,104(sp)
    10c2:	7906                	ld	s2,96(sp)
    10c4:	69e6                	ld	s3,88(sp)
    10c6:	6109                	addi	sp,sp,128
    10c8:	8082                	ret

00000000000010ca <find_next_release_time>:

int find_next_release_time(struct list_head *release_queue, int current_time) {
    10ca:	7139                	addi	sp,sp,-64
    10cc:	fc22                	sd	s0,56(sp)
    10ce:	0080                	addi	s0,sp,64
    10d0:	fca43423          	sd	a0,-56(s0)
    10d4:	87ae                	mv	a5,a1
    10d6:	fcf42223          	sw	a5,-60(s0)
    struct release_queue_entry *next_release = NULL;
    10da:	fe043423          	sd	zero,-24(s0)
    int next_release_time = INT_MAX;
    10de:	800007b7          	lui	a5,0x80000
    10e2:	fff7c793          	not	a5,a5
    10e6:	fef42223          	sw	a5,-28(s0)

    list_for_each_entry(next_release, release_queue, thread_list) {
    10ea:	fc843783          	ld	a5,-56(s0)
    10ee:	639c                	ld	a5,0(a5)
    10f0:	fcf43c23          	sd	a5,-40(s0)
    10f4:	fd843783          	ld	a5,-40(s0)
    10f8:	17e1                	addi	a5,a5,-8
    10fa:	fef43423          	sd	a5,-24(s0)
    10fe:	a081                	j	113e <find_next_release_time+0x74>
        if (next_release->release_time > current_time &&
    1100:	fe843783          	ld	a5,-24(s0)
    1104:	4f98                	lw	a4,24(a5)
    1106:	fc442783          	lw	a5,-60(s0)
    110a:	2781                	sext.w	a5,a5
    110c:	00e7df63          	bge	a5,a4,112a <find_next_release_time+0x60>
            next_release->release_time < next_release_time) {
    1110:	fe843783          	ld	a5,-24(s0)
    1114:	4f98                	lw	a4,24(a5)
        if (next_release->release_time > current_time &&
    1116:	fe442783          	lw	a5,-28(s0)
    111a:	2781                	sext.w	a5,a5
    111c:	00f75763          	bge	a4,a5,112a <find_next_release_time+0x60>
            next_release_time = next_release->release_time;
    1120:	fe843783          	ld	a5,-24(s0)
    1124:	4f9c                	lw	a5,24(a5)
    1126:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(next_release, release_queue, thread_list) {
    112a:	fe843783          	ld	a5,-24(s0)
    112e:	679c                	ld	a5,8(a5)
    1130:	fcf43823          	sd	a5,-48(s0)
    1134:	fd043783          	ld	a5,-48(s0)
    1138:	17e1                	addi	a5,a5,-8
    113a:	fef43423          	sd	a5,-24(s0)
    113e:	fe843783          	ld	a5,-24(s0)
    1142:	07a1                	addi	a5,a5,8
    1144:	fc843703          	ld	a4,-56(s0)
    1148:	faf71ce3          	bne	a4,a5,1100 <find_next_release_time+0x36>
        }
    }

    if (next_release_time == INT_MAX)
    114c:	fe442783          	lw	a5,-28(s0)
    1150:	0007871b          	sext.w	a4,a5
    1154:	800007b7          	lui	a5,0x80000
    1158:	fff7c793          	not	a5,a5
    115c:	00f71463          	bne	a4,a5,1164 <find_next_release_time+0x9a>
        return -1; // No threads in the release queue
    1160:	57fd                	li	a5,-1
    1162:	a801                	j	1172 <find_next_release_time+0xa8>

    return next_release_time - current_time;
    1164:	fe442703          	lw	a4,-28(s0)
    1168:	fc442783          	lw	a5,-60(s0)
    116c:	40f707bb          	subw	a5,a4,a5
    1170:	2781                	sext.w	a5,a5
}
    1172:	853e                	mv	a0,a5
    1174:	7462                	ld	s0,56(sp)
    1176:	6121                	addi	sp,sp,64
    1178:	8082                	ret

000000000000117a <schedule_lst>:

/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args)
{
    117a:	7119                	addi	sp,sp,-128
    117c:	fc86                	sd	ra,120(sp)
    117e:	f8a2                	sd	s0,112(sp)
    1180:	f4a6                	sd	s1,104(sp)
    1182:	f0ca                	sd	s2,96(sp)
    1184:	ecce                	sd	s3,88(sp)
    1186:	0100                	addi	s0,sp,128
    1188:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the least-slack-time scheduling algorithm
    struct thread *min_slack = NULL;
    118a:	fc043423          	sd	zero,-56(s0)
    int min_slack_time = INT_MAX;
    118e:	800007b7          	lui	a5,0x80000
    1192:	fff7c793          	not	a5,a5
    1196:	fcf42223          	sw	a5,-60(s0)
    struct thread *t;

    // Find the thread with the minimum slack time
    list_for_each_entry(t, args.run_queue, thread_list) {
    119a:	649c                	ld	a5,8(s1)
    119c:	639c                	ld	a5,0(a5)
    119e:	faf43823          	sd	a5,-80(s0)
    11a2:	fb043783          	ld	a5,-80(s0)
    11a6:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe2f0>
    11aa:	faf43c23          	sd	a5,-72(s0)
    11ae:	a8b5                	j	122a <schedule_lst+0xb0>
        int slack_time = t->deadline - args.current_time - t->remaining_time;
    11b0:	fb843783          	ld	a5,-72(s0)
    11b4:	47f8                	lw	a4,76(a5)
    11b6:	409c                	lw	a5,0(s1)
    11b8:	40f707bb          	subw	a5,a4,a5
    11bc:	0007871b          	sext.w	a4,a5
    11c0:	fb843783          	ld	a5,-72(s0)
    11c4:	4fbc                	lw	a5,88(a5)
    11c6:	40f707bb          	subw	a5,a4,a5
    11ca:	faf42623          	sw	a5,-84(s0)
        if (min_slack == NULL || slack_time < min_slack_time ||
    11ce:	fc843783          	ld	a5,-56(s0)
    11d2:	cb8d                	beqz	a5,1204 <schedule_lst+0x8a>
    11d4:	fac42703          	lw	a4,-84(s0)
    11d8:	fc442783          	lw	a5,-60(s0)
    11dc:	2701                	sext.w	a4,a4
    11de:	2781                	sext.w	a5,a5
    11e0:	02f74263          	blt	a4,a5,1204 <schedule_lst+0x8a>
    11e4:	fac42703          	lw	a4,-84(s0)
    11e8:	fc442783          	lw	a5,-60(s0)
    11ec:	2701                	sext.w	a4,a4
    11ee:	2781                	sext.w	a5,a5
    11f0:	02f71263          	bne	a4,a5,1214 <schedule_lst+0x9a>
            (slack_time == min_slack_time && t->ID < min_slack->ID)) {
    11f4:	fb843783          	ld	a5,-72(s0)
    11f8:	5fd8                	lw	a4,60(a5)
    11fa:	fc843783          	ld	a5,-56(s0)
    11fe:	5fdc                	lw	a5,60(a5)
    1200:	00f75a63          	bge	a4,a5,1214 <schedule_lst+0x9a>
            min_slack = t;
    1204:	fb843783          	ld	a5,-72(s0)
    1208:	fcf43423          	sd	a5,-56(s0)
            min_slack_time = slack_time;
    120c:	fac42783          	lw	a5,-84(s0)
    1210:	fcf42223          	sw	a5,-60(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    1214:	fb843783          	ld	a5,-72(s0)
    1218:	779c                	ld	a5,40(a5)
    121a:	faf43023          	sd	a5,-96(s0)
    121e:	fa043783          	ld	a5,-96(s0)
    1222:	fd878793          	addi	a5,a5,-40
    1226:	faf43c23          	sd	a5,-72(s0)
    122a:	fb843783          	ld	a5,-72(s0)
    122e:	02878713          	addi	a4,a5,40
    1232:	649c                	ld	a5,8(s1)
    1234:	f6f71ee3          	bne	a4,a5,11b0 <schedule_lst+0x36>
        }
    }

    if (min_slack) {
    1238:	fc843783          	ld	a5,-56(s0)
    123c:	cf89                	beqz	a5,1256 <schedule_lst+0xdc>
        r.scheduled_thread_list_member = &min_slack->thread_list;
    123e:	fc843783          	ld	a5,-56(s0)
    1242:	02878793          	addi	a5,a5,40
    1246:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = min_slack->remaining_time;
    124a:	fc843783          	ld	a5,-56(s0)
    124e:	4fbc                	lw	a5,88(a5)
    1250:	f8f42423          	sw	a5,-120(s0)
    1254:	a839                	j	1272 <schedule_lst+0xf8>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
    1256:	649c                	ld	a5,8(s1)
    1258:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    125c:	689c                	ld	a5,16(s1)
    125e:	4098                	lw	a4,0(s1)
    1260:	85ba                	mv	a1,a4
    1262:	853e                	mv	a0,a5
    1264:	00000097          	auipc	ra,0x0
    1268:	e66080e7          	jalr	-410(ra) # 10ca <find_next_release_time>
    126c:	87aa                	mv	a5,a0
    126e:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    1272:	f8043783          	ld	a5,-128(s0)
    1276:	f8f43823          	sd	a5,-112(s0)
    127a:	f8843783          	ld	a5,-120(s0)
    127e:	f8f43c23          	sd	a5,-104(s0)
    1282:	4701                	li	a4,0
    1284:	f9043703          	ld	a4,-112(s0)
    1288:	4781                	li	a5,0
    128a:	f9843783          	ld	a5,-104(s0)
    128e:	893a                	mv	s2,a4
    1290:	89be                	mv	s3,a5
    1292:	874a                	mv	a4,s2
    1294:	87ce                	mv	a5,s3
}
    1296:	853a                	mv	a0,a4
    1298:	85be                	mv	a1,a5
    129a:	70e6                	ld	ra,120(sp)
    129c:	7446                	ld	s0,112(sp)
    129e:	74a6                	ld	s1,104(sp)
    12a0:	7906                	ld	s2,96(sp)
    12a2:	69e6                	ld	s3,88(sp)
    12a4:	6109                	addi	sp,sp,128
    12a6:	8082                	ret

00000000000012a8 <schedule_dm>:

/* Deadline-Monotonic Scheduling */
struct threads_sched_result schedule_dm(struct threads_sched_args args)
{
    12a8:	7135                	addi	sp,sp,-160
    12aa:	ed06                	sd	ra,152(sp)
    12ac:	e922                	sd	s0,144(sp)
    12ae:	e526                	sd	s1,136(sp)
    12b0:	e14a                	sd	s2,128(sp)
    12b2:	fcce                	sd	s3,120(sp)
    12b4:	1100                	addi	s0,sp,160
    12b6:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the deadline-monotonic scheduling algorithm
   struct thread *earliest_deadline_thread = NULL;
    12b8:	fc043423          	sd	zero,-56(s0)
    struct thread *t;
    int earliest_deadline = INT_MAX;
    12bc:	800007b7          	lui	a5,0x80000
    12c0:	fff7c793          	not	a5,a5
    12c4:	faf42e23          	sw	a5,-68(s0)

    // Find the earliest deadline real-time thread
    list_for_each_entry(t, args.run_queue, thread_list) {
    12c8:	649c                	ld	a5,8(s1)
    12ca:	639c                	ld	a5,0(a5)
    12cc:	faf43423          	sd	a5,-88(s0)
    12d0:	fa843783          	ld	a5,-88(s0)
    12d4:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe2f0>
    12d8:	fcf43023          	sd	a5,-64(s0)
    12dc:	a841                	j	136c <schedule_dm+0xc4>
        if (t->is_real_time && t->period != -1 && t->current_deadline < earliest_deadline) {
    12de:	fc043783          	ld	a5,-64(s0)
    12e2:	43bc                	lw	a5,64(a5)
    12e4:	cb95                	beqz	a5,1318 <schedule_dm+0x70>
    12e6:	fc043783          	ld	a5,-64(s0)
    12ea:	4bbc                	lw	a5,80(a5)
    12ec:	873e                	mv	a4,a5
    12ee:	57fd                	li	a5,-1
    12f0:	02f70463          	beq	a4,a5,1318 <schedule_dm+0x70>
    12f4:	fc043783          	ld	a5,-64(s0)
    12f8:	4ff8                	lw	a4,92(a5)
    12fa:	fbc42783          	lw	a5,-68(s0)
    12fe:	2781                	sext.w	a5,a5
    1300:	00f75c63          	bge	a4,a5,1318 <schedule_dm+0x70>
            earliest_deadline = t->current_deadline;
    1304:	fc043783          	ld	a5,-64(s0)
    1308:	4ffc                	lw	a5,92(a5)
    130a:	faf42e23          	sw	a5,-68(s0)
            earliest_deadline_thread = t;
    130e:	fc043783          	ld	a5,-64(s0)
    1312:	fcf43423          	sd	a5,-56(s0)
    1316:	a081                	j	1356 <schedule_dm+0xae>
        } else if (t->is_real_time && t->period != -1 && t->current_deadline == earliest_deadline && t->ID < earliest_deadline_thread->ID) {
    1318:	fc043783          	ld	a5,-64(s0)
    131c:	43bc                	lw	a5,64(a5)
    131e:	cf85                	beqz	a5,1356 <schedule_dm+0xae>
    1320:	fc043783          	ld	a5,-64(s0)
    1324:	4bbc                	lw	a5,80(a5)
    1326:	873e                	mv	a4,a5
    1328:	57fd                	li	a5,-1
    132a:	02f70663          	beq	a4,a5,1356 <schedule_dm+0xae>
    132e:	fc043783          	ld	a5,-64(s0)
    1332:	4ff8                	lw	a4,92(a5)
    1334:	fbc42783          	lw	a5,-68(s0)
    1338:	2781                	sext.w	a5,a5
    133a:	00e79e63          	bne	a5,a4,1356 <schedule_dm+0xae>
    133e:	fc043783          	ld	a5,-64(s0)
    1342:	5fd8                	lw	a4,60(a5)
    1344:	fc843783          	ld	a5,-56(s0)
    1348:	5fdc                	lw	a5,60(a5)
    134a:	00f75663          	bge	a4,a5,1356 <schedule_dm+0xae>
            earliest_deadline_thread = t;  // Tie-breaking by ID
    134e:	fc043783          	ld	a5,-64(s0)
    1352:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    1356:	fc043783          	ld	a5,-64(s0)
    135a:	779c                	ld	a5,40(a5)
    135c:	f8f43423          	sd	a5,-120(s0)
    1360:	f8843783          	ld	a5,-120(s0)
    1364:	fd878793          	addi	a5,a5,-40
    1368:	fcf43023          	sd	a5,-64(s0)
    136c:	fc043783          	ld	a5,-64(s0)
    1370:	02878713          	addi	a4,a5,40
    1374:	649c                	ld	a5,8(s1)
    1376:	f6f714e3          	bne	a4,a5,12de <schedule_dm+0x36>
        }
    }

    if (earliest_deadline_thread) {
    137a:	fc843783          	ld	a5,-56(s0)
    137e:	c7a5                	beqz	a5,13e6 <schedule_dm+0x13e>
        int time_to_deadline = earliest_deadline_thread->current_deadline - args.current_time;
    1380:	fc843783          	ld	a5,-56(s0)
    1384:	4ff8                	lw	a4,92(a5)
    1386:	409c                	lw	a5,0(s1)
    1388:	40f707bb          	subw	a5,a4,a5
    138c:	f8f42a23          	sw	a5,-108(s0)
        if (earliest_deadline_thread->remaining_time > time_to_deadline) {
    1390:	fc843783          	ld	a5,-56(s0)
    1394:	4fb8                	lw	a4,88(a5)
    1396:	f9442783          	lw	a5,-108(s0)
    139a:	2781                	sext.w	a5,a5
    139c:	00e7db63          	bge	a5,a4,13b2 <schedule_dm+0x10a>
            // The real-time thread cannot complete before its deadline, so handle the deadline miss
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    13a0:	fc843783          	ld	a5,-56(s0)
    13a4:	02878793          	addi	a5,a5,40
    13a8:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = 0; // Could set to minimal quantum to allow cleanup or logging
    13ac:	f6042823          	sw	zero,-144(s0)
    13b0:	a0f1                	j	147c <schedule_dm+0x1d4>
        } else {
            // Schedule the real-time thread normally if it hasn't missed its deadline
            int time_slice = (time_to_deadline < earliest_deadline_thread->remaining_time) ? time_to_deadline : earliest_deadline_thread->remaining_time;
    13b2:	fc843783          	ld	a5,-56(s0)
    13b6:	4fbc                	lw	a5,88(a5)
    13b8:	863e                	mv	a2,a5
    13ba:	f9442783          	lw	a5,-108(s0)
    13be:	0007869b          	sext.w	a3,a5
    13c2:	0006071b          	sext.w	a4,a2
    13c6:	00d75363          	bge	a4,a3,13cc <schedule_dm+0x124>
    13ca:	87b2                	mv	a5,a2
    13cc:	f8f42823          	sw	a5,-112(s0)
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    13d0:	fc843783          	ld	a5,-56(s0)
    13d4:	02878793          	addi	a5,a5,40
    13d8:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = time_slice;
    13dc:	f9042783          	lw	a5,-112(s0)
    13e0:	f6f42823          	sw	a5,-144(s0)
    13e4:	a861                	j	147c <schedule_dm+0x1d4>
        }
    } else {
        // If no real-time threads with a deadline are ready, find the thread with the smallest ID
        struct thread *smallest_id_thread = NULL;
    13e6:	fa043823          	sd	zero,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    13ea:	649c                	ld	a5,8(s1)
    13ec:	639c                	ld	a5,0(a5)
    13ee:	faf43023          	sd	a5,-96(s0)
    13f2:	fa043783          	ld	a5,-96(s0)
    13f6:	fd878793          	addi	a5,a5,-40
    13fa:	fcf43023          	sd	a5,-64(s0)
    13fe:	a81d                	j	1434 <schedule_dm+0x18c>
            if (smallest_id_thread == NULL || t->ID < smallest_id_thread->ID) {
    1400:	fb043783          	ld	a5,-80(s0)
    1404:	cb89                	beqz	a5,1416 <schedule_dm+0x16e>
    1406:	fc043783          	ld	a5,-64(s0)
    140a:	5fd8                	lw	a4,60(a5)
    140c:	fb043783          	ld	a5,-80(s0)
    1410:	5fdc                	lw	a5,60(a5)
    1412:	00f75663          	bge	a4,a5,141e <schedule_dm+0x176>
                smallest_id_thread = t;
    1416:	fc043783          	ld	a5,-64(s0)
    141a:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    141e:	fc043783          	ld	a5,-64(s0)
    1422:	779c                	ld	a5,40(a5)
    1424:	f8f43c23          	sd	a5,-104(s0)
    1428:	f9843783          	ld	a5,-104(s0)
    142c:	fd878793          	addi	a5,a5,-40
    1430:	fcf43023          	sd	a5,-64(s0)
    1434:	fc043783          	ld	a5,-64(s0)
    1438:	02878713          	addi	a4,a5,40
    143c:	649c                	ld	a5,8(s1)
    143e:	fcf711e3          	bne	a4,a5,1400 <schedule_dm+0x158>
            }
        }

        if (smallest_id_thread) {
    1442:	fb043783          	ld	a5,-80(s0)
    1446:	cf89                	beqz	a5,1460 <schedule_dm+0x1b8>
            r.scheduled_thread_list_member = &smallest_id_thread->thread_list;
    1448:	fb043783          	ld	a5,-80(s0)
    144c:	02878793          	addi	a5,a5,40
    1450:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = smallest_id_thread->remaining_time;
    1454:	fb043783          	ld	a5,-80(s0)
    1458:	4fbc                	lw	a5,88(a5)
    145a:	f6f42823          	sw	a5,-144(s0)
    145e:	a839                	j	147c <schedule_dm+0x1d4>
        } else {
            // If no thread is ready, perhaps idle or find the next release time
            r.scheduled_thread_list_member = args.run_queue;
    1460:	649c                	ld	a5,8(s1)
    1462:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    1466:	689c                	ld	a5,16(s1)
    1468:	4098                	lw	a4,0(s1)
    146a:	85ba                	mv	a1,a4
    146c:	853e                	mv	a0,a5
    146e:	00000097          	auipc	ra,0x0
    1472:	c5c080e7          	jalr	-932(ra) # 10ca <find_next_release_time>
    1476:	87aa                	mv	a5,a0
    1478:	f6f42823          	sw	a5,-144(s0)
        }
    }

    return r;
    147c:	f6843783          	ld	a5,-152(s0)
    1480:	f6f43c23          	sd	a5,-136(s0)
    1484:	f7043783          	ld	a5,-144(s0)
    1488:	f8f43023          	sd	a5,-128(s0)
    148c:	4701                	li	a4,0
    148e:	f7843703          	ld	a4,-136(s0)
    1492:	4781                	li	a5,0
    1494:	f8043783          	ld	a5,-128(s0)
    1498:	893a                	mv	s2,a4
    149a:	89be                	mv	s3,a5
    149c:	874a                	mv	a4,s2
    149e:	87ce                	mv	a5,s3
}
    14a0:	853a                	mv	a0,a4
    14a2:	85be                	mv	a1,a5
    14a4:	60ea                	ld	ra,152(sp)
    14a6:	644a                	ld	s0,144(sp)
    14a8:	64aa                	ld	s1,136(sp)
    14aa:	690a                	ld	s2,128(sp)
    14ac:	79e6                	ld	s3,120(sp)
    14ae:	610d                	addi	sp,sp,160
    14b0:	8082                	ret
