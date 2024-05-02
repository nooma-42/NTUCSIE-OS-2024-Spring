
user/_kill:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
       0:	7179                	addi	sp,sp,-48
       2:	f406                	sd	ra,40(sp)
       4:	f022                	sd	s0,32(sp)
       6:	1800                	addi	s0,sp,48
       8:	87aa                	mv	a5,a0
       a:	fcb43823          	sd	a1,-48(s0)
       e:	fcf42e23          	sw	a5,-36(s0)
  int i;

  if(argc < 2){
      12:	fdc42783          	lw	a5,-36(s0)
      16:	0007871b          	sext.w	a4,a5
      1a:	4785                	li	a5,1
      1c:	02e7c063          	blt	a5,a4,3c <main+0x3c>
    fprintf(2, "usage: kill pid...\n");
      20:	00001597          	auipc	a1,0x1
      24:	65858593          	addi	a1,a1,1624 # 1678 <schedule_dm+0x20c>
      28:	4509                	li	a0,2
      2a:	00001097          	auipc	ra,0x1
      2e:	9e0080e7          	jalr	-1568(ra) # a0a <fprintf>
    exit(1);
      32:	4505                	li	a0,1
      34:	00000097          	auipc	ra,0x0
      38:	4e8080e7          	jalr	1256(ra) # 51c <exit>
  }
  for(i=1; i<argc; i++)
      3c:	4785                	li	a5,1
      3e:	fef42623          	sw	a5,-20(s0)
      42:	a805                	j	72 <main+0x72>
    kill(atoi(argv[i]));
      44:	fec42783          	lw	a5,-20(s0)
      48:	078e                	slli	a5,a5,0x3
      4a:	fd043703          	ld	a4,-48(s0)
      4e:	97ba                	add	a5,a5,a4
      50:	639c                	ld	a5,0(a5)
      52:	853e                	mv	a0,a5
      54:	00000097          	auipc	ra,0x0
      58:	2d0080e7          	jalr	720(ra) # 324 <atoi>
      5c:	87aa                	mv	a5,a0
      5e:	853e                	mv	a0,a5
      60:	00000097          	auipc	ra,0x0
      64:	4ec080e7          	jalr	1260(ra) # 54c <kill>
  for(i=1; i<argc; i++)
      68:	fec42783          	lw	a5,-20(s0)
      6c:	2785                	addiw	a5,a5,1
      6e:	fef42623          	sw	a5,-20(s0)
      72:	fec42703          	lw	a4,-20(s0)
      76:	fdc42783          	lw	a5,-36(s0)
      7a:	2701                	sext.w	a4,a4
      7c:	2781                	sext.w	a5,a5
      7e:	fcf743e3          	blt	a4,a5,44 <main+0x44>
  exit(0);
      82:	4501                	li	a0,0
      84:	00000097          	auipc	ra,0x0
      88:	498080e7          	jalr	1176(ra) # 51c <exit>

000000000000008c <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
      8c:	7179                	addi	sp,sp,-48
      8e:	f422                	sd	s0,40(sp)
      90:	1800                	addi	s0,sp,48
      92:	fca43c23          	sd	a0,-40(s0)
      96:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
      9a:	fd843783          	ld	a5,-40(s0)
      9e:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
      a2:	0001                	nop
      a4:	fd043703          	ld	a4,-48(s0)
      a8:	00170793          	addi	a5,a4,1
      ac:	fcf43823          	sd	a5,-48(s0)
      b0:	fd843783          	ld	a5,-40(s0)
      b4:	00178693          	addi	a3,a5,1
      b8:	fcd43c23          	sd	a3,-40(s0)
      bc:	00074703          	lbu	a4,0(a4)
      c0:	00e78023          	sb	a4,0(a5)
      c4:	0007c783          	lbu	a5,0(a5)
      c8:	fff1                	bnez	a5,a4 <strcpy+0x18>
    ;
  return os;
      ca:	fe843783          	ld	a5,-24(s0)
}
      ce:	853e                	mv	a0,a5
      d0:	7422                	ld	s0,40(sp)
      d2:	6145                	addi	sp,sp,48
      d4:	8082                	ret

00000000000000d6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      d6:	1101                	addi	sp,sp,-32
      d8:	ec22                	sd	s0,24(sp)
      da:	1000                	addi	s0,sp,32
      dc:	fea43423          	sd	a0,-24(s0)
      e0:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
      e4:	a819                	j	fa <strcmp+0x24>
    p++, q++;
      e6:	fe843783          	ld	a5,-24(s0)
      ea:	0785                	addi	a5,a5,1
      ec:	fef43423          	sd	a5,-24(s0)
      f0:	fe043783          	ld	a5,-32(s0)
      f4:	0785                	addi	a5,a5,1
      f6:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
      fa:	fe843783          	ld	a5,-24(s0)
      fe:	0007c783          	lbu	a5,0(a5)
     102:	cb99                	beqz	a5,118 <strcmp+0x42>
     104:	fe843783          	ld	a5,-24(s0)
     108:	0007c703          	lbu	a4,0(a5)
     10c:	fe043783          	ld	a5,-32(s0)
     110:	0007c783          	lbu	a5,0(a5)
     114:	fcf709e3          	beq	a4,a5,e6 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     118:	fe843783          	ld	a5,-24(s0)
     11c:	0007c783          	lbu	a5,0(a5)
     120:	0007871b          	sext.w	a4,a5
     124:	fe043783          	ld	a5,-32(s0)
     128:	0007c783          	lbu	a5,0(a5)
     12c:	2781                	sext.w	a5,a5
     12e:	40f707bb          	subw	a5,a4,a5
     132:	2781                	sext.w	a5,a5
}
     134:	853e                	mv	a0,a5
     136:	6462                	ld	s0,24(sp)
     138:	6105                	addi	sp,sp,32
     13a:	8082                	ret

000000000000013c <strlen>:

uint
strlen(const char *s)
{
     13c:	7179                	addi	sp,sp,-48
     13e:	f422                	sd	s0,40(sp)
     140:	1800                	addi	s0,sp,48
     142:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     146:	fe042623          	sw	zero,-20(s0)
     14a:	a031                	j	156 <strlen+0x1a>
     14c:	fec42783          	lw	a5,-20(s0)
     150:	2785                	addiw	a5,a5,1
     152:	fef42623          	sw	a5,-20(s0)
     156:	fec42783          	lw	a5,-20(s0)
     15a:	fd843703          	ld	a4,-40(s0)
     15e:	97ba                	add	a5,a5,a4
     160:	0007c783          	lbu	a5,0(a5)
     164:	f7e5                	bnez	a5,14c <strlen+0x10>
    ;
  return n;
     166:	fec42783          	lw	a5,-20(s0)
}
     16a:	853e                	mv	a0,a5
     16c:	7422                	ld	s0,40(sp)
     16e:	6145                	addi	sp,sp,48
     170:	8082                	ret

0000000000000172 <memset>:

void*
memset(void *dst, int c, uint n)
{
     172:	7179                	addi	sp,sp,-48
     174:	f422                	sd	s0,40(sp)
     176:	1800                	addi	s0,sp,48
     178:	fca43c23          	sd	a0,-40(s0)
     17c:	87ae                	mv	a5,a1
     17e:	8732                	mv	a4,a2
     180:	fcf42a23          	sw	a5,-44(s0)
     184:	87ba                	mv	a5,a4
     186:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     18a:	fd843783          	ld	a5,-40(s0)
     18e:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     192:	fe042623          	sw	zero,-20(s0)
     196:	a00d                	j	1b8 <memset+0x46>
    cdst[i] = c;
     198:	fec42783          	lw	a5,-20(s0)
     19c:	fe043703          	ld	a4,-32(s0)
     1a0:	97ba                	add	a5,a5,a4
     1a2:	fd442703          	lw	a4,-44(s0)
     1a6:	0ff77713          	andi	a4,a4,255
     1aa:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     1ae:	fec42783          	lw	a5,-20(s0)
     1b2:	2785                	addiw	a5,a5,1
     1b4:	fef42623          	sw	a5,-20(s0)
     1b8:	fec42703          	lw	a4,-20(s0)
     1bc:	fd042783          	lw	a5,-48(s0)
     1c0:	2781                	sext.w	a5,a5
     1c2:	fcf76be3          	bltu	a4,a5,198 <memset+0x26>
  }
  return dst;
     1c6:	fd843783          	ld	a5,-40(s0)
}
     1ca:	853e                	mv	a0,a5
     1cc:	7422                	ld	s0,40(sp)
     1ce:	6145                	addi	sp,sp,48
     1d0:	8082                	ret

00000000000001d2 <strchr>:

char*
strchr(const char *s, char c)
{
     1d2:	1101                	addi	sp,sp,-32
     1d4:	ec22                	sd	s0,24(sp)
     1d6:	1000                	addi	s0,sp,32
     1d8:	fea43423          	sd	a0,-24(s0)
     1dc:	87ae                	mv	a5,a1
     1de:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     1e2:	a01d                	j	208 <strchr+0x36>
    if(*s == c)
     1e4:	fe843783          	ld	a5,-24(s0)
     1e8:	0007c703          	lbu	a4,0(a5)
     1ec:	fe744783          	lbu	a5,-25(s0)
     1f0:	0ff7f793          	andi	a5,a5,255
     1f4:	00e79563          	bne	a5,a4,1fe <strchr+0x2c>
      return (char*)s;
     1f8:	fe843783          	ld	a5,-24(s0)
     1fc:	a821                	j	214 <strchr+0x42>
  for(; *s; s++)
     1fe:	fe843783          	ld	a5,-24(s0)
     202:	0785                	addi	a5,a5,1
     204:	fef43423          	sd	a5,-24(s0)
     208:	fe843783          	ld	a5,-24(s0)
     20c:	0007c783          	lbu	a5,0(a5)
     210:	fbf1                	bnez	a5,1e4 <strchr+0x12>
  return 0;
     212:	4781                	li	a5,0
}
     214:	853e                	mv	a0,a5
     216:	6462                	ld	s0,24(sp)
     218:	6105                	addi	sp,sp,32
     21a:	8082                	ret

000000000000021c <gets>:

char*
gets(char *buf, int max)
{
     21c:	7179                	addi	sp,sp,-48
     21e:	f406                	sd	ra,40(sp)
     220:	f022                	sd	s0,32(sp)
     222:	1800                	addi	s0,sp,48
     224:	fca43c23          	sd	a0,-40(s0)
     228:	87ae                	mv	a5,a1
     22a:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     22e:	fe042623          	sw	zero,-20(s0)
     232:	a8a1                	j	28a <gets+0x6e>
    cc = read(0, &c, 1);
     234:	fe740793          	addi	a5,s0,-25
     238:	4605                	li	a2,1
     23a:	85be                	mv	a1,a5
     23c:	4501                	li	a0,0
     23e:	00000097          	auipc	ra,0x0
     242:	2f6080e7          	jalr	758(ra) # 534 <read>
     246:	87aa                	mv	a5,a0
     248:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     24c:	fe842783          	lw	a5,-24(s0)
     250:	2781                	sext.w	a5,a5
     252:	04f05763          	blez	a5,2a0 <gets+0x84>
      break;
    buf[i++] = c;
     256:	fec42783          	lw	a5,-20(s0)
     25a:	0017871b          	addiw	a4,a5,1
     25e:	fee42623          	sw	a4,-20(s0)
     262:	873e                	mv	a4,a5
     264:	fd843783          	ld	a5,-40(s0)
     268:	97ba                	add	a5,a5,a4
     26a:	fe744703          	lbu	a4,-25(s0)
     26e:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     272:	fe744783          	lbu	a5,-25(s0)
     276:	873e                	mv	a4,a5
     278:	47a9                	li	a5,10
     27a:	02f70463          	beq	a4,a5,2a2 <gets+0x86>
     27e:	fe744783          	lbu	a5,-25(s0)
     282:	873e                	mv	a4,a5
     284:	47b5                	li	a5,13
     286:	00f70e63          	beq	a4,a5,2a2 <gets+0x86>
  for(i=0; i+1 < max; ){
     28a:	fec42783          	lw	a5,-20(s0)
     28e:	2785                	addiw	a5,a5,1
     290:	0007871b          	sext.w	a4,a5
     294:	fd442783          	lw	a5,-44(s0)
     298:	2781                	sext.w	a5,a5
     29a:	f8f74de3          	blt	a4,a5,234 <gets+0x18>
     29e:	a011                	j	2a2 <gets+0x86>
      break;
     2a0:	0001                	nop
      break;
  }
  buf[i] = '\0';
     2a2:	fec42783          	lw	a5,-20(s0)
     2a6:	fd843703          	ld	a4,-40(s0)
     2aa:	97ba                	add	a5,a5,a4
     2ac:	00078023          	sb	zero,0(a5)
  return buf;
     2b0:	fd843783          	ld	a5,-40(s0)
}
     2b4:	853e                	mv	a0,a5
     2b6:	70a2                	ld	ra,40(sp)
     2b8:	7402                	ld	s0,32(sp)
     2ba:	6145                	addi	sp,sp,48
     2bc:	8082                	ret

00000000000002be <stat>:

int
stat(const char *n, struct stat *st)
{
     2be:	7179                	addi	sp,sp,-48
     2c0:	f406                	sd	ra,40(sp)
     2c2:	f022                	sd	s0,32(sp)
     2c4:	1800                	addi	s0,sp,48
     2c6:	fca43c23          	sd	a0,-40(s0)
     2ca:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     2ce:	4581                	li	a1,0
     2d0:	fd843503          	ld	a0,-40(s0)
     2d4:	00000097          	auipc	ra,0x0
     2d8:	288080e7          	jalr	648(ra) # 55c <open>
     2dc:	87aa                	mv	a5,a0
     2de:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     2e2:	fec42783          	lw	a5,-20(s0)
     2e6:	2781                	sext.w	a5,a5
     2e8:	0007d463          	bgez	a5,2f0 <stat+0x32>
    return -1;
     2ec:	57fd                	li	a5,-1
     2ee:	a035                	j	31a <stat+0x5c>
  r = fstat(fd, st);
     2f0:	fec42783          	lw	a5,-20(s0)
     2f4:	fd043583          	ld	a1,-48(s0)
     2f8:	853e                	mv	a0,a5
     2fa:	00000097          	auipc	ra,0x0
     2fe:	27a080e7          	jalr	634(ra) # 574 <fstat>
     302:	87aa                	mv	a5,a0
     304:	fef42423          	sw	a5,-24(s0)
  close(fd);
     308:	fec42783          	lw	a5,-20(s0)
     30c:	853e                	mv	a0,a5
     30e:	00000097          	auipc	ra,0x0
     312:	236080e7          	jalr	566(ra) # 544 <close>
  return r;
     316:	fe842783          	lw	a5,-24(s0)
}
     31a:	853e                	mv	a0,a5
     31c:	70a2                	ld	ra,40(sp)
     31e:	7402                	ld	s0,32(sp)
     320:	6145                	addi	sp,sp,48
     322:	8082                	ret

0000000000000324 <atoi>:

int
atoi(const char *s)
{
     324:	7179                	addi	sp,sp,-48
     326:	f422                	sd	s0,40(sp)
     328:	1800                	addi	s0,sp,48
     32a:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     32e:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     332:	a815                	j	366 <atoi+0x42>
    n = n*10 + *s++ - '0';
     334:	fec42703          	lw	a4,-20(s0)
     338:	87ba                	mv	a5,a4
     33a:	0027979b          	slliw	a5,a5,0x2
     33e:	9fb9                	addw	a5,a5,a4
     340:	0017979b          	slliw	a5,a5,0x1
     344:	0007871b          	sext.w	a4,a5
     348:	fd843783          	ld	a5,-40(s0)
     34c:	00178693          	addi	a3,a5,1
     350:	fcd43c23          	sd	a3,-40(s0)
     354:	0007c783          	lbu	a5,0(a5)
     358:	2781                	sext.w	a5,a5
     35a:	9fb9                	addw	a5,a5,a4
     35c:	2781                	sext.w	a5,a5
     35e:	fd07879b          	addiw	a5,a5,-48
     362:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     366:	fd843783          	ld	a5,-40(s0)
     36a:	0007c783          	lbu	a5,0(a5)
     36e:	873e                	mv	a4,a5
     370:	02f00793          	li	a5,47
     374:	00e7fb63          	bgeu	a5,a4,38a <atoi+0x66>
     378:	fd843783          	ld	a5,-40(s0)
     37c:	0007c783          	lbu	a5,0(a5)
     380:	873e                	mv	a4,a5
     382:	03900793          	li	a5,57
     386:	fae7f7e3          	bgeu	a5,a4,334 <atoi+0x10>
  return n;
     38a:	fec42783          	lw	a5,-20(s0)
}
     38e:	853e                	mv	a0,a5
     390:	7422                	ld	s0,40(sp)
     392:	6145                	addi	sp,sp,48
     394:	8082                	ret

0000000000000396 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     396:	7139                	addi	sp,sp,-64
     398:	fc22                	sd	s0,56(sp)
     39a:	0080                	addi	s0,sp,64
     39c:	fca43c23          	sd	a0,-40(s0)
     3a0:	fcb43823          	sd	a1,-48(s0)
     3a4:	87b2                	mv	a5,a2
     3a6:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     3aa:	fd843783          	ld	a5,-40(s0)
     3ae:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     3b2:	fd043783          	ld	a5,-48(s0)
     3b6:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     3ba:	fe043703          	ld	a4,-32(s0)
     3be:	fe843783          	ld	a5,-24(s0)
     3c2:	02e7fc63          	bgeu	a5,a4,3fa <memmove+0x64>
    while(n-- > 0)
     3c6:	a00d                	j	3e8 <memmove+0x52>
      *dst++ = *src++;
     3c8:	fe043703          	ld	a4,-32(s0)
     3cc:	00170793          	addi	a5,a4,1
     3d0:	fef43023          	sd	a5,-32(s0)
     3d4:	fe843783          	ld	a5,-24(s0)
     3d8:	00178693          	addi	a3,a5,1
     3dc:	fed43423          	sd	a3,-24(s0)
     3e0:	00074703          	lbu	a4,0(a4)
     3e4:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     3e8:	fcc42783          	lw	a5,-52(s0)
     3ec:	fff7871b          	addiw	a4,a5,-1
     3f0:	fce42623          	sw	a4,-52(s0)
     3f4:	fcf04ae3          	bgtz	a5,3c8 <memmove+0x32>
     3f8:	a891                	j	44c <memmove+0xb6>
  } else {
    dst += n;
     3fa:	fcc42783          	lw	a5,-52(s0)
     3fe:	fe843703          	ld	a4,-24(s0)
     402:	97ba                	add	a5,a5,a4
     404:	fef43423          	sd	a5,-24(s0)
    src += n;
     408:	fcc42783          	lw	a5,-52(s0)
     40c:	fe043703          	ld	a4,-32(s0)
     410:	97ba                	add	a5,a5,a4
     412:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     416:	a01d                	j	43c <memmove+0xa6>
      *--dst = *--src;
     418:	fe043783          	ld	a5,-32(s0)
     41c:	17fd                	addi	a5,a5,-1
     41e:	fef43023          	sd	a5,-32(s0)
     422:	fe843783          	ld	a5,-24(s0)
     426:	17fd                	addi	a5,a5,-1
     428:	fef43423          	sd	a5,-24(s0)
     42c:	fe043783          	ld	a5,-32(s0)
     430:	0007c703          	lbu	a4,0(a5)
     434:	fe843783          	ld	a5,-24(s0)
     438:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     43c:	fcc42783          	lw	a5,-52(s0)
     440:	fff7871b          	addiw	a4,a5,-1
     444:	fce42623          	sw	a4,-52(s0)
     448:	fcf048e3          	bgtz	a5,418 <memmove+0x82>
  }
  return vdst;
     44c:	fd843783          	ld	a5,-40(s0)
}
     450:	853e                	mv	a0,a5
     452:	7462                	ld	s0,56(sp)
     454:	6121                	addi	sp,sp,64
     456:	8082                	ret

0000000000000458 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     458:	7139                	addi	sp,sp,-64
     45a:	fc22                	sd	s0,56(sp)
     45c:	0080                	addi	s0,sp,64
     45e:	fca43c23          	sd	a0,-40(s0)
     462:	fcb43823          	sd	a1,-48(s0)
     466:	87b2                	mv	a5,a2
     468:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     46c:	fd843783          	ld	a5,-40(s0)
     470:	fef43423          	sd	a5,-24(s0)
     474:	fd043783          	ld	a5,-48(s0)
     478:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     47c:	a0a1                	j	4c4 <memcmp+0x6c>
    if (*p1 != *p2) {
     47e:	fe843783          	ld	a5,-24(s0)
     482:	0007c703          	lbu	a4,0(a5)
     486:	fe043783          	ld	a5,-32(s0)
     48a:	0007c783          	lbu	a5,0(a5)
     48e:	02f70163          	beq	a4,a5,4b0 <memcmp+0x58>
      return *p1 - *p2;
     492:	fe843783          	ld	a5,-24(s0)
     496:	0007c783          	lbu	a5,0(a5)
     49a:	0007871b          	sext.w	a4,a5
     49e:	fe043783          	ld	a5,-32(s0)
     4a2:	0007c783          	lbu	a5,0(a5)
     4a6:	2781                	sext.w	a5,a5
     4a8:	40f707bb          	subw	a5,a4,a5
     4ac:	2781                	sext.w	a5,a5
     4ae:	a01d                	j	4d4 <memcmp+0x7c>
    }
    p1++;
     4b0:	fe843783          	ld	a5,-24(s0)
     4b4:	0785                	addi	a5,a5,1
     4b6:	fef43423          	sd	a5,-24(s0)
    p2++;
     4ba:	fe043783          	ld	a5,-32(s0)
     4be:	0785                	addi	a5,a5,1
     4c0:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     4c4:	fcc42783          	lw	a5,-52(s0)
     4c8:	fff7871b          	addiw	a4,a5,-1
     4cc:	fce42623          	sw	a4,-52(s0)
     4d0:	f7dd                	bnez	a5,47e <memcmp+0x26>
  }
  return 0;
     4d2:	4781                	li	a5,0
}
     4d4:	853e                	mv	a0,a5
     4d6:	7462                	ld	s0,56(sp)
     4d8:	6121                	addi	sp,sp,64
     4da:	8082                	ret

00000000000004dc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     4dc:	7179                	addi	sp,sp,-48
     4de:	f406                	sd	ra,40(sp)
     4e0:	f022                	sd	s0,32(sp)
     4e2:	1800                	addi	s0,sp,48
     4e4:	fea43423          	sd	a0,-24(s0)
     4e8:	feb43023          	sd	a1,-32(s0)
     4ec:	87b2                	mv	a5,a2
     4ee:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     4f2:	fdc42783          	lw	a5,-36(s0)
     4f6:	863e                	mv	a2,a5
     4f8:	fe043583          	ld	a1,-32(s0)
     4fc:	fe843503          	ld	a0,-24(s0)
     500:	00000097          	auipc	ra,0x0
     504:	e96080e7          	jalr	-362(ra) # 396 <memmove>
     508:	87aa                	mv	a5,a0
}
     50a:	853e                	mv	a0,a5
     50c:	70a2                	ld	ra,40(sp)
     50e:	7402                	ld	s0,32(sp)
     510:	6145                	addi	sp,sp,48
     512:	8082                	ret

0000000000000514 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     514:	4885                	li	a7,1
 ecall
     516:	00000073          	ecall
 ret
     51a:	8082                	ret

000000000000051c <exit>:
.global exit
exit:
 li a7, SYS_exit
     51c:	4889                	li	a7,2
 ecall
     51e:	00000073          	ecall
 ret
     522:	8082                	ret

0000000000000524 <wait>:
.global wait
wait:
 li a7, SYS_wait
     524:	488d                	li	a7,3
 ecall
     526:	00000073          	ecall
 ret
     52a:	8082                	ret

000000000000052c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     52c:	4891                	li	a7,4
 ecall
     52e:	00000073          	ecall
 ret
     532:	8082                	ret

0000000000000534 <read>:
.global read
read:
 li a7, SYS_read
     534:	4895                	li	a7,5
 ecall
     536:	00000073          	ecall
 ret
     53a:	8082                	ret

000000000000053c <write>:
.global write
write:
 li a7, SYS_write
     53c:	48c1                	li	a7,16
 ecall
     53e:	00000073          	ecall
 ret
     542:	8082                	ret

0000000000000544 <close>:
.global close
close:
 li a7, SYS_close
     544:	48d5                	li	a7,21
 ecall
     546:	00000073          	ecall
 ret
     54a:	8082                	ret

000000000000054c <kill>:
.global kill
kill:
 li a7, SYS_kill
     54c:	4899                	li	a7,6
 ecall
     54e:	00000073          	ecall
 ret
     552:	8082                	ret

0000000000000554 <exec>:
.global exec
exec:
 li a7, SYS_exec
     554:	489d                	li	a7,7
 ecall
     556:	00000073          	ecall
 ret
     55a:	8082                	ret

000000000000055c <open>:
.global open
open:
 li a7, SYS_open
     55c:	48bd                	li	a7,15
 ecall
     55e:	00000073          	ecall
 ret
     562:	8082                	ret

0000000000000564 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     564:	48c5                	li	a7,17
 ecall
     566:	00000073          	ecall
 ret
     56a:	8082                	ret

000000000000056c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     56c:	48c9                	li	a7,18
 ecall
     56e:	00000073          	ecall
 ret
     572:	8082                	ret

0000000000000574 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     574:	48a1                	li	a7,8
 ecall
     576:	00000073          	ecall
 ret
     57a:	8082                	ret

000000000000057c <link>:
.global link
link:
 li a7, SYS_link
     57c:	48cd                	li	a7,19
 ecall
     57e:	00000073          	ecall
 ret
     582:	8082                	ret

0000000000000584 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     584:	48d1                	li	a7,20
 ecall
     586:	00000073          	ecall
 ret
     58a:	8082                	ret

000000000000058c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     58c:	48a5                	li	a7,9
 ecall
     58e:	00000073          	ecall
 ret
     592:	8082                	ret

0000000000000594 <dup>:
.global dup
dup:
 li a7, SYS_dup
     594:	48a9                	li	a7,10
 ecall
     596:	00000073          	ecall
 ret
     59a:	8082                	ret

000000000000059c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     59c:	48ad                	li	a7,11
 ecall
     59e:	00000073          	ecall
 ret
     5a2:	8082                	ret

00000000000005a4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     5a4:	48b1                	li	a7,12
 ecall
     5a6:	00000073          	ecall
 ret
     5aa:	8082                	ret

00000000000005ac <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     5ac:	48b5                	li	a7,13
 ecall
     5ae:	00000073          	ecall
 ret
     5b2:	8082                	ret

00000000000005b4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     5b4:	48b9                	li	a7,14
 ecall
     5b6:	00000073          	ecall
 ret
     5ba:	8082                	ret

00000000000005bc <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     5bc:	48d9                	li	a7,22
 ecall
     5be:	00000073          	ecall
 ret
     5c2:	8082                	ret

00000000000005c4 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     5c4:	48dd                	li	a7,23
 ecall
     5c6:	00000073          	ecall
 ret
     5ca:	8082                	ret

00000000000005cc <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     5cc:	48e1                	li	a7,24
 ecall
     5ce:	00000073          	ecall
 ret
     5d2:	8082                	ret

00000000000005d4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     5d4:	1101                	addi	sp,sp,-32
     5d6:	ec06                	sd	ra,24(sp)
     5d8:	e822                	sd	s0,16(sp)
     5da:	1000                	addi	s0,sp,32
     5dc:	87aa                	mv	a5,a0
     5de:	872e                	mv	a4,a1
     5e0:	fef42623          	sw	a5,-20(s0)
     5e4:	87ba                	mv	a5,a4
     5e6:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     5ea:	feb40713          	addi	a4,s0,-21
     5ee:	fec42783          	lw	a5,-20(s0)
     5f2:	4605                	li	a2,1
     5f4:	85ba                	mv	a1,a4
     5f6:	853e                	mv	a0,a5
     5f8:	00000097          	auipc	ra,0x0
     5fc:	f44080e7          	jalr	-188(ra) # 53c <write>
}
     600:	0001                	nop
     602:	60e2                	ld	ra,24(sp)
     604:	6442                	ld	s0,16(sp)
     606:	6105                	addi	sp,sp,32
     608:	8082                	ret

000000000000060a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     60a:	7139                	addi	sp,sp,-64
     60c:	fc06                	sd	ra,56(sp)
     60e:	f822                	sd	s0,48(sp)
     610:	0080                	addi	s0,sp,64
     612:	87aa                	mv	a5,a0
     614:	8736                	mv	a4,a3
     616:	fcf42623          	sw	a5,-52(s0)
     61a:	87ae                	mv	a5,a1
     61c:	fcf42423          	sw	a5,-56(s0)
     620:	87b2                	mv	a5,a2
     622:	fcf42223          	sw	a5,-60(s0)
     626:	87ba                	mv	a5,a4
     628:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     62c:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     630:	fc042783          	lw	a5,-64(s0)
     634:	2781                	sext.w	a5,a5
     636:	c38d                	beqz	a5,658 <printint+0x4e>
     638:	fc842783          	lw	a5,-56(s0)
     63c:	2781                	sext.w	a5,a5
     63e:	0007dd63          	bgez	a5,658 <printint+0x4e>
    neg = 1;
     642:	4785                	li	a5,1
     644:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     648:	fc842783          	lw	a5,-56(s0)
     64c:	40f007bb          	negw	a5,a5
     650:	2781                	sext.w	a5,a5
     652:	fef42223          	sw	a5,-28(s0)
     656:	a029                	j	660 <printint+0x56>
  } else {
    x = xx;
     658:	fc842783          	lw	a5,-56(s0)
     65c:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     660:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     664:	fc442783          	lw	a5,-60(s0)
     668:	fe442703          	lw	a4,-28(s0)
     66c:	02f777bb          	remuw	a5,a4,a5
     670:	0007861b          	sext.w	a2,a5
     674:	fec42783          	lw	a5,-20(s0)
     678:	0017871b          	addiw	a4,a5,1
     67c:	fee42623          	sw	a4,-20(s0)
     680:	00001697          	auipc	a3,0x1
     684:	01868693          	addi	a3,a3,24 # 1698 <digits>
     688:	02061713          	slli	a4,a2,0x20
     68c:	9301                	srli	a4,a4,0x20
     68e:	9736                	add	a4,a4,a3
     690:	00074703          	lbu	a4,0(a4)
     694:	ff040693          	addi	a3,s0,-16
     698:	97b6                	add	a5,a5,a3
     69a:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     69e:	fc442783          	lw	a5,-60(s0)
     6a2:	fe442703          	lw	a4,-28(s0)
     6a6:	02f757bb          	divuw	a5,a4,a5
     6aa:	fef42223          	sw	a5,-28(s0)
     6ae:	fe442783          	lw	a5,-28(s0)
     6b2:	2781                	sext.w	a5,a5
     6b4:	fbc5                	bnez	a5,664 <printint+0x5a>
  if(neg)
     6b6:	fe842783          	lw	a5,-24(s0)
     6ba:	2781                	sext.w	a5,a5
     6bc:	cf95                	beqz	a5,6f8 <printint+0xee>
    buf[i++] = '-';
     6be:	fec42783          	lw	a5,-20(s0)
     6c2:	0017871b          	addiw	a4,a5,1
     6c6:	fee42623          	sw	a4,-20(s0)
     6ca:	ff040713          	addi	a4,s0,-16
     6ce:	97ba                	add	a5,a5,a4
     6d0:	02d00713          	li	a4,45
     6d4:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     6d8:	a005                	j	6f8 <printint+0xee>
    putc(fd, buf[i]);
     6da:	fec42783          	lw	a5,-20(s0)
     6de:	ff040713          	addi	a4,s0,-16
     6e2:	97ba                	add	a5,a5,a4
     6e4:	fe07c703          	lbu	a4,-32(a5)
     6e8:	fcc42783          	lw	a5,-52(s0)
     6ec:	85ba                	mv	a1,a4
     6ee:	853e                	mv	a0,a5
     6f0:	00000097          	auipc	ra,0x0
     6f4:	ee4080e7          	jalr	-284(ra) # 5d4 <putc>
  while(--i >= 0)
     6f8:	fec42783          	lw	a5,-20(s0)
     6fc:	37fd                	addiw	a5,a5,-1
     6fe:	fef42623          	sw	a5,-20(s0)
     702:	fec42783          	lw	a5,-20(s0)
     706:	2781                	sext.w	a5,a5
     708:	fc07d9e3          	bgez	a5,6da <printint+0xd0>
}
     70c:	0001                	nop
     70e:	0001                	nop
     710:	70e2                	ld	ra,56(sp)
     712:	7442                	ld	s0,48(sp)
     714:	6121                	addi	sp,sp,64
     716:	8082                	ret

0000000000000718 <printptr>:

static void
printptr(int fd, uint64 x) {
     718:	7179                	addi	sp,sp,-48
     71a:	f406                	sd	ra,40(sp)
     71c:	f022                	sd	s0,32(sp)
     71e:	1800                	addi	s0,sp,48
     720:	87aa                	mv	a5,a0
     722:	fcb43823          	sd	a1,-48(s0)
     726:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     72a:	fdc42783          	lw	a5,-36(s0)
     72e:	03000593          	li	a1,48
     732:	853e                	mv	a0,a5
     734:	00000097          	auipc	ra,0x0
     738:	ea0080e7          	jalr	-352(ra) # 5d4 <putc>
  putc(fd, 'x');
     73c:	fdc42783          	lw	a5,-36(s0)
     740:	07800593          	li	a1,120
     744:	853e                	mv	a0,a5
     746:	00000097          	auipc	ra,0x0
     74a:	e8e080e7          	jalr	-370(ra) # 5d4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     74e:	fe042623          	sw	zero,-20(s0)
     752:	a82d                	j	78c <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     754:	fd043783          	ld	a5,-48(s0)
     758:	93f1                	srli	a5,a5,0x3c
     75a:	00001717          	auipc	a4,0x1
     75e:	f3e70713          	addi	a4,a4,-194 # 1698 <digits>
     762:	97ba                	add	a5,a5,a4
     764:	0007c703          	lbu	a4,0(a5)
     768:	fdc42783          	lw	a5,-36(s0)
     76c:	85ba                	mv	a1,a4
     76e:	853e                	mv	a0,a5
     770:	00000097          	auipc	ra,0x0
     774:	e64080e7          	jalr	-412(ra) # 5d4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     778:	fec42783          	lw	a5,-20(s0)
     77c:	2785                	addiw	a5,a5,1
     77e:	fef42623          	sw	a5,-20(s0)
     782:	fd043783          	ld	a5,-48(s0)
     786:	0792                	slli	a5,a5,0x4
     788:	fcf43823          	sd	a5,-48(s0)
     78c:	fec42783          	lw	a5,-20(s0)
     790:	873e                	mv	a4,a5
     792:	47bd                	li	a5,15
     794:	fce7f0e3          	bgeu	a5,a4,754 <printptr+0x3c>
}
     798:	0001                	nop
     79a:	0001                	nop
     79c:	70a2                	ld	ra,40(sp)
     79e:	7402                	ld	s0,32(sp)
     7a0:	6145                	addi	sp,sp,48
     7a2:	8082                	ret

00000000000007a4 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     7a4:	715d                	addi	sp,sp,-80
     7a6:	e486                	sd	ra,72(sp)
     7a8:	e0a2                	sd	s0,64(sp)
     7aa:	0880                	addi	s0,sp,80
     7ac:	87aa                	mv	a5,a0
     7ae:	fcb43023          	sd	a1,-64(s0)
     7b2:	fac43c23          	sd	a2,-72(s0)
     7b6:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     7ba:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     7be:	fe042223          	sw	zero,-28(s0)
     7c2:	a42d                	j	9ec <vprintf+0x248>
    c = fmt[i] & 0xff;
     7c4:	fe442783          	lw	a5,-28(s0)
     7c8:	fc043703          	ld	a4,-64(s0)
     7cc:	97ba                	add	a5,a5,a4
     7ce:	0007c783          	lbu	a5,0(a5)
     7d2:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     7d6:	fe042783          	lw	a5,-32(s0)
     7da:	2781                	sext.w	a5,a5
     7dc:	eb9d                	bnez	a5,812 <vprintf+0x6e>
      if(c == '%'){
     7de:	fdc42783          	lw	a5,-36(s0)
     7e2:	0007871b          	sext.w	a4,a5
     7e6:	02500793          	li	a5,37
     7ea:	00f71763          	bne	a4,a5,7f8 <vprintf+0x54>
        state = '%';
     7ee:	02500793          	li	a5,37
     7f2:	fef42023          	sw	a5,-32(s0)
     7f6:	a2f5                	j	9e2 <vprintf+0x23e>
      } else {
        putc(fd, c);
     7f8:	fdc42783          	lw	a5,-36(s0)
     7fc:	0ff7f713          	andi	a4,a5,255
     800:	fcc42783          	lw	a5,-52(s0)
     804:	85ba                	mv	a1,a4
     806:	853e                	mv	a0,a5
     808:	00000097          	auipc	ra,0x0
     80c:	dcc080e7          	jalr	-564(ra) # 5d4 <putc>
     810:	aac9                	j	9e2 <vprintf+0x23e>
      }
    } else if(state == '%'){
     812:	fe042783          	lw	a5,-32(s0)
     816:	0007871b          	sext.w	a4,a5
     81a:	02500793          	li	a5,37
     81e:	1cf71263          	bne	a4,a5,9e2 <vprintf+0x23e>
      if(c == 'd'){
     822:	fdc42783          	lw	a5,-36(s0)
     826:	0007871b          	sext.w	a4,a5
     82a:	06400793          	li	a5,100
     82e:	02f71463          	bne	a4,a5,856 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     832:	fb843783          	ld	a5,-72(s0)
     836:	00878713          	addi	a4,a5,8
     83a:	fae43c23          	sd	a4,-72(s0)
     83e:	4398                	lw	a4,0(a5)
     840:	fcc42783          	lw	a5,-52(s0)
     844:	4685                	li	a3,1
     846:	4629                	li	a2,10
     848:	85ba                	mv	a1,a4
     84a:	853e                	mv	a0,a5
     84c:	00000097          	auipc	ra,0x0
     850:	dbe080e7          	jalr	-578(ra) # 60a <printint>
     854:	a269                	j	9de <vprintf+0x23a>
      } else if(c == 'l') {
     856:	fdc42783          	lw	a5,-36(s0)
     85a:	0007871b          	sext.w	a4,a5
     85e:	06c00793          	li	a5,108
     862:	02f71663          	bne	a4,a5,88e <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     866:	fb843783          	ld	a5,-72(s0)
     86a:	00878713          	addi	a4,a5,8
     86e:	fae43c23          	sd	a4,-72(s0)
     872:	639c                	ld	a5,0(a5)
     874:	0007871b          	sext.w	a4,a5
     878:	fcc42783          	lw	a5,-52(s0)
     87c:	4681                	li	a3,0
     87e:	4629                	li	a2,10
     880:	85ba                	mv	a1,a4
     882:	853e                	mv	a0,a5
     884:	00000097          	auipc	ra,0x0
     888:	d86080e7          	jalr	-634(ra) # 60a <printint>
     88c:	aa89                	j	9de <vprintf+0x23a>
      } else if(c == 'x') {
     88e:	fdc42783          	lw	a5,-36(s0)
     892:	0007871b          	sext.w	a4,a5
     896:	07800793          	li	a5,120
     89a:	02f71463          	bne	a4,a5,8c2 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     89e:	fb843783          	ld	a5,-72(s0)
     8a2:	00878713          	addi	a4,a5,8
     8a6:	fae43c23          	sd	a4,-72(s0)
     8aa:	4398                	lw	a4,0(a5)
     8ac:	fcc42783          	lw	a5,-52(s0)
     8b0:	4681                	li	a3,0
     8b2:	4641                	li	a2,16
     8b4:	85ba                	mv	a1,a4
     8b6:	853e                	mv	a0,a5
     8b8:	00000097          	auipc	ra,0x0
     8bc:	d52080e7          	jalr	-686(ra) # 60a <printint>
     8c0:	aa39                	j	9de <vprintf+0x23a>
      } else if(c == 'p') {
     8c2:	fdc42783          	lw	a5,-36(s0)
     8c6:	0007871b          	sext.w	a4,a5
     8ca:	07000793          	li	a5,112
     8ce:	02f71263          	bne	a4,a5,8f2 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     8d2:	fb843783          	ld	a5,-72(s0)
     8d6:	00878713          	addi	a4,a5,8
     8da:	fae43c23          	sd	a4,-72(s0)
     8de:	6398                	ld	a4,0(a5)
     8e0:	fcc42783          	lw	a5,-52(s0)
     8e4:	85ba                	mv	a1,a4
     8e6:	853e                	mv	a0,a5
     8e8:	00000097          	auipc	ra,0x0
     8ec:	e30080e7          	jalr	-464(ra) # 718 <printptr>
     8f0:	a0fd                	j	9de <vprintf+0x23a>
      } else if(c == 's'){
     8f2:	fdc42783          	lw	a5,-36(s0)
     8f6:	0007871b          	sext.w	a4,a5
     8fa:	07300793          	li	a5,115
     8fe:	04f71c63          	bne	a4,a5,956 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     902:	fb843783          	ld	a5,-72(s0)
     906:	00878713          	addi	a4,a5,8
     90a:	fae43c23          	sd	a4,-72(s0)
     90e:	639c                	ld	a5,0(a5)
     910:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     914:	fe843783          	ld	a5,-24(s0)
     918:	eb8d                	bnez	a5,94a <vprintf+0x1a6>
          s = "(null)";
     91a:	00001797          	auipc	a5,0x1
     91e:	d7678793          	addi	a5,a5,-650 # 1690 <schedule_dm+0x224>
     922:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     926:	a015                	j	94a <vprintf+0x1a6>
          putc(fd, *s);
     928:	fe843783          	ld	a5,-24(s0)
     92c:	0007c703          	lbu	a4,0(a5)
     930:	fcc42783          	lw	a5,-52(s0)
     934:	85ba                	mv	a1,a4
     936:	853e                	mv	a0,a5
     938:	00000097          	auipc	ra,0x0
     93c:	c9c080e7          	jalr	-868(ra) # 5d4 <putc>
          s++;
     940:	fe843783          	ld	a5,-24(s0)
     944:	0785                	addi	a5,a5,1
     946:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     94a:	fe843783          	ld	a5,-24(s0)
     94e:	0007c783          	lbu	a5,0(a5)
     952:	fbf9                	bnez	a5,928 <vprintf+0x184>
     954:	a069                	j	9de <vprintf+0x23a>
        }
      } else if(c == 'c'){
     956:	fdc42783          	lw	a5,-36(s0)
     95a:	0007871b          	sext.w	a4,a5
     95e:	06300793          	li	a5,99
     962:	02f71463          	bne	a4,a5,98a <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     966:	fb843783          	ld	a5,-72(s0)
     96a:	00878713          	addi	a4,a5,8
     96e:	fae43c23          	sd	a4,-72(s0)
     972:	439c                	lw	a5,0(a5)
     974:	0ff7f713          	andi	a4,a5,255
     978:	fcc42783          	lw	a5,-52(s0)
     97c:	85ba                	mv	a1,a4
     97e:	853e                	mv	a0,a5
     980:	00000097          	auipc	ra,0x0
     984:	c54080e7          	jalr	-940(ra) # 5d4 <putc>
     988:	a899                	j	9de <vprintf+0x23a>
      } else if(c == '%'){
     98a:	fdc42783          	lw	a5,-36(s0)
     98e:	0007871b          	sext.w	a4,a5
     992:	02500793          	li	a5,37
     996:	00f71f63          	bne	a4,a5,9b4 <vprintf+0x210>
        putc(fd, c);
     99a:	fdc42783          	lw	a5,-36(s0)
     99e:	0ff7f713          	andi	a4,a5,255
     9a2:	fcc42783          	lw	a5,-52(s0)
     9a6:	85ba                	mv	a1,a4
     9a8:	853e                	mv	a0,a5
     9aa:	00000097          	auipc	ra,0x0
     9ae:	c2a080e7          	jalr	-982(ra) # 5d4 <putc>
     9b2:	a035                	j	9de <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     9b4:	fcc42783          	lw	a5,-52(s0)
     9b8:	02500593          	li	a1,37
     9bc:	853e                	mv	a0,a5
     9be:	00000097          	auipc	ra,0x0
     9c2:	c16080e7          	jalr	-1002(ra) # 5d4 <putc>
        putc(fd, c);
     9c6:	fdc42783          	lw	a5,-36(s0)
     9ca:	0ff7f713          	andi	a4,a5,255
     9ce:	fcc42783          	lw	a5,-52(s0)
     9d2:	85ba                	mv	a1,a4
     9d4:	853e                	mv	a0,a5
     9d6:	00000097          	auipc	ra,0x0
     9da:	bfe080e7          	jalr	-1026(ra) # 5d4 <putc>
      }
      state = 0;
     9de:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     9e2:	fe442783          	lw	a5,-28(s0)
     9e6:	2785                	addiw	a5,a5,1
     9e8:	fef42223          	sw	a5,-28(s0)
     9ec:	fe442783          	lw	a5,-28(s0)
     9f0:	fc043703          	ld	a4,-64(s0)
     9f4:	97ba                	add	a5,a5,a4
     9f6:	0007c783          	lbu	a5,0(a5)
     9fa:	dc0795e3          	bnez	a5,7c4 <vprintf+0x20>
    }
  }
}
     9fe:	0001                	nop
     a00:	0001                	nop
     a02:	60a6                	ld	ra,72(sp)
     a04:	6406                	ld	s0,64(sp)
     a06:	6161                	addi	sp,sp,80
     a08:	8082                	ret

0000000000000a0a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     a0a:	7159                	addi	sp,sp,-112
     a0c:	fc06                	sd	ra,56(sp)
     a0e:	f822                	sd	s0,48(sp)
     a10:	0080                	addi	s0,sp,64
     a12:	fcb43823          	sd	a1,-48(s0)
     a16:	e010                	sd	a2,0(s0)
     a18:	e414                	sd	a3,8(s0)
     a1a:	e818                	sd	a4,16(s0)
     a1c:	ec1c                	sd	a5,24(s0)
     a1e:	03043023          	sd	a6,32(s0)
     a22:	03143423          	sd	a7,40(s0)
     a26:	87aa                	mv	a5,a0
     a28:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     a2c:	03040793          	addi	a5,s0,48
     a30:	fcf43423          	sd	a5,-56(s0)
     a34:	fc843783          	ld	a5,-56(s0)
     a38:	fd078793          	addi	a5,a5,-48
     a3c:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     a40:	fe843703          	ld	a4,-24(s0)
     a44:	fdc42783          	lw	a5,-36(s0)
     a48:	863a                	mv	a2,a4
     a4a:	fd043583          	ld	a1,-48(s0)
     a4e:	853e                	mv	a0,a5
     a50:	00000097          	auipc	ra,0x0
     a54:	d54080e7          	jalr	-684(ra) # 7a4 <vprintf>
}
     a58:	0001                	nop
     a5a:	70e2                	ld	ra,56(sp)
     a5c:	7442                	ld	s0,48(sp)
     a5e:	6165                	addi	sp,sp,112
     a60:	8082                	ret

0000000000000a62 <printf>:

void
printf(const char *fmt, ...)
{
     a62:	7159                	addi	sp,sp,-112
     a64:	f406                	sd	ra,40(sp)
     a66:	f022                	sd	s0,32(sp)
     a68:	1800                	addi	s0,sp,48
     a6a:	fca43c23          	sd	a0,-40(s0)
     a6e:	e40c                	sd	a1,8(s0)
     a70:	e810                	sd	a2,16(s0)
     a72:	ec14                	sd	a3,24(s0)
     a74:	f018                	sd	a4,32(s0)
     a76:	f41c                	sd	a5,40(s0)
     a78:	03043823          	sd	a6,48(s0)
     a7c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     a80:	04040793          	addi	a5,s0,64
     a84:	fcf43823          	sd	a5,-48(s0)
     a88:	fd043783          	ld	a5,-48(s0)
     a8c:	fc878793          	addi	a5,a5,-56
     a90:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     a94:	fe843783          	ld	a5,-24(s0)
     a98:	863e                	mv	a2,a5
     a9a:	fd843583          	ld	a1,-40(s0)
     a9e:	4505                	li	a0,1
     aa0:	00000097          	auipc	ra,0x0
     aa4:	d04080e7          	jalr	-764(ra) # 7a4 <vprintf>
}
     aa8:	0001                	nop
     aaa:	70a2                	ld	ra,40(sp)
     aac:	7402                	ld	s0,32(sp)
     aae:	6165                	addi	sp,sp,112
     ab0:	8082                	ret

0000000000000ab2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     ab2:	7179                	addi	sp,sp,-48
     ab4:	f422                	sd	s0,40(sp)
     ab6:	1800                	addi	s0,sp,48
     ab8:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     abc:	fd843783          	ld	a5,-40(s0)
     ac0:	17c1                	addi	a5,a5,-16
     ac2:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     ac6:	00001797          	auipc	a5,0x1
     aca:	bfa78793          	addi	a5,a5,-1030 # 16c0 <freep>
     ace:	639c                	ld	a5,0(a5)
     ad0:	fef43423          	sd	a5,-24(s0)
     ad4:	a815                	j	b08 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     ad6:	fe843783          	ld	a5,-24(s0)
     ada:	639c                	ld	a5,0(a5)
     adc:	fe843703          	ld	a4,-24(s0)
     ae0:	00f76f63          	bltu	a4,a5,afe <free+0x4c>
     ae4:	fe043703          	ld	a4,-32(s0)
     ae8:	fe843783          	ld	a5,-24(s0)
     aec:	02e7eb63          	bltu	a5,a4,b22 <free+0x70>
     af0:	fe843783          	ld	a5,-24(s0)
     af4:	639c                	ld	a5,0(a5)
     af6:	fe043703          	ld	a4,-32(s0)
     afa:	02f76463          	bltu	a4,a5,b22 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     afe:	fe843783          	ld	a5,-24(s0)
     b02:	639c                	ld	a5,0(a5)
     b04:	fef43423          	sd	a5,-24(s0)
     b08:	fe043703          	ld	a4,-32(s0)
     b0c:	fe843783          	ld	a5,-24(s0)
     b10:	fce7f3e3          	bgeu	a5,a4,ad6 <free+0x24>
     b14:	fe843783          	ld	a5,-24(s0)
     b18:	639c                	ld	a5,0(a5)
     b1a:	fe043703          	ld	a4,-32(s0)
     b1e:	faf77ce3          	bgeu	a4,a5,ad6 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     b22:	fe043783          	ld	a5,-32(s0)
     b26:	479c                	lw	a5,8(a5)
     b28:	1782                	slli	a5,a5,0x20
     b2a:	9381                	srli	a5,a5,0x20
     b2c:	0792                	slli	a5,a5,0x4
     b2e:	fe043703          	ld	a4,-32(s0)
     b32:	973e                	add	a4,a4,a5
     b34:	fe843783          	ld	a5,-24(s0)
     b38:	639c                	ld	a5,0(a5)
     b3a:	02f71763          	bne	a4,a5,b68 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     b3e:	fe043783          	ld	a5,-32(s0)
     b42:	4798                	lw	a4,8(a5)
     b44:	fe843783          	ld	a5,-24(s0)
     b48:	639c                	ld	a5,0(a5)
     b4a:	479c                	lw	a5,8(a5)
     b4c:	9fb9                	addw	a5,a5,a4
     b4e:	0007871b          	sext.w	a4,a5
     b52:	fe043783          	ld	a5,-32(s0)
     b56:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     b58:	fe843783          	ld	a5,-24(s0)
     b5c:	639c                	ld	a5,0(a5)
     b5e:	6398                	ld	a4,0(a5)
     b60:	fe043783          	ld	a5,-32(s0)
     b64:	e398                	sd	a4,0(a5)
     b66:	a039                	j	b74 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     b68:	fe843783          	ld	a5,-24(s0)
     b6c:	6398                	ld	a4,0(a5)
     b6e:	fe043783          	ld	a5,-32(s0)
     b72:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     b74:	fe843783          	ld	a5,-24(s0)
     b78:	479c                	lw	a5,8(a5)
     b7a:	1782                	slli	a5,a5,0x20
     b7c:	9381                	srli	a5,a5,0x20
     b7e:	0792                	slli	a5,a5,0x4
     b80:	fe843703          	ld	a4,-24(s0)
     b84:	97ba                	add	a5,a5,a4
     b86:	fe043703          	ld	a4,-32(s0)
     b8a:	02f71563          	bne	a4,a5,bb4 <free+0x102>
    p->s.size += bp->s.size;
     b8e:	fe843783          	ld	a5,-24(s0)
     b92:	4798                	lw	a4,8(a5)
     b94:	fe043783          	ld	a5,-32(s0)
     b98:	479c                	lw	a5,8(a5)
     b9a:	9fb9                	addw	a5,a5,a4
     b9c:	0007871b          	sext.w	a4,a5
     ba0:	fe843783          	ld	a5,-24(s0)
     ba4:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     ba6:	fe043783          	ld	a5,-32(s0)
     baa:	6398                	ld	a4,0(a5)
     bac:	fe843783          	ld	a5,-24(s0)
     bb0:	e398                	sd	a4,0(a5)
     bb2:	a031                	j	bbe <free+0x10c>
  } else
    p->s.ptr = bp;
     bb4:	fe843783          	ld	a5,-24(s0)
     bb8:	fe043703          	ld	a4,-32(s0)
     bbc:	e398                	sd	a4,0(a5)
  freep = p;
     bbe:	00001797          	auipc	a5,0x1
     bc2:	b0278793          	addi	a5,a5,-1278 # 16c0 <freep>
     bc6:	fe843703          	ld	a4,-24(s0)
     bca:	e398                	sd	a4,0(a5)
}
     bcc:	0001                	nop
     bce:	7422                	ld	s0,40(sp)
     bd0:	6145                	addi	sp,sp,48
     bd2:	8082                	ret

0000000000000bd4 <morecore>:

static Header*
morecore(uint nu)
{
     bd4:	7179                	addi	sp,sp,-48
     bd6:	f406                	sd	ra,40(sp)
     bd8:	f022                	sd	s0,32(sp)
     bda:	1800                	addi	s0,sp,48
     bdc:	87aa                	mv	a5,a0
     bde:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     be2:	fdc42783          	lw	a5,-36(s0)
     be6:	0007871b          	sext.w	a4,a5
     bea:	6785                	lui	a5,0x1
     bec:	00f77563          	bgeu	a4,a5,bf6 <morecore+0x22>
    nu = 4096;
     bf0:	6785                	lui	a5,0x1
     bf2:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     bf6:	fdc42783          	lw	a5,-36(s0)
     bfa:	0047979b          	slliw	a5,a5,0x4
     bfe:	2781                	sext.w	a5,a5
     c00:	2781                	sext.w	a5,a5
     c02:	853e                	mv	a0,a5
     c04:	00000097          	auipc	ra,0x0
     c08:	9a0080e7          	jalr	-1632(ra) # 5a4 <sbrk>
     c0c:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     c10:	fe843703          	ld	a4,-24(s0)
     c14:	57fd                	li	a5,-1
     c16:	00f71463          	bne	a4,a5,c1e <morecore+0x4a>
    return 0;
     c1a:	4781                	li	a5,0
     c1c:	a03d                	j	c4a <morecore+0x76>
  hp = (Header*)p;
     c1e:	fe843783          	ld	a5,-24(s0)
     c22:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     c26:	fe043783          	ld	a5,-32(s0)
     c2a:	fdc42703          	lw	a4,-36(s0)
     c2e:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     c30:	fe043783          	ld	a5,-32(s0)
     c34:	07c1                	addi	a5,a5,16
     c36:	853e                	mv	a0,a5
     c38:	00000097          	auipc	ra,0x0
     c3c:	e7a080e7          	jalr	-390(ra) # ab2 <free>
  return freep;
     c40:	00001797          	auipc	a5,0x1
     c44:	a8078793          	addi	a5,a5,-1408 # 16c0 <freep>
     c48:	639c                	ld	a5,0(a5)
}
     c4a:	853e                	mv	a0,a5
     c4c:	70a2                	ld	ra,40(sp)
     c4e:	7402                	ld	s0,32(sp)
     c50:	6145                	addi	sp,sp,48
     c52:	8082                	ret

0000000000000c54 <malloc>:

void*
malloc(uint nbytes)
{
     c54:	7139                	addi	sp,sp,-64
     c56:	fc06                	sd	ra,56(sp)
     c58:	f822                	sd	s0,48(sp)
     c5a:	0080                	addi	s0,sp,64
     c5c:	87aa                	mv	a5,a0
     c5e:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     c62:	fcc46783          	lwu	a5,-52(s0)
     c66:	07bd                	addi	a5,a5,15
     c68:	8391                	srli	a5,a5,0x4
     c6a:	2781                	sext.w	a5,a5
     c6c:	2785                	addiw	a5,a5,1
     c6e:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     c72:	00001797          	auipc	a5,0x1
     c76:	a4e78793          	addi	a5,a5,-1458 # 16c0 <freep>
     c7a:	639c                	ld	a5,0(a5)
     c7c:	fef43023          	sd	a5,-32(s0)
     c80:	fe043783          	ld	a5,-32(s0)
     c84:	ef95                	bnez	a5,cc0 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     c86:	00001797          	auipc	a5,0x1
     c8a:	a2a78793          	addi	a5,a5,-1494 # 16b0 <base>
     c8e:	fef43023          	sd	a5,-32(s0)
     c92:	00001797          	auipc	a5,0x1
     c96:	a2e78793          	addi	a5,a5,-1490 # 16c0 <freep>
     c9a:	fe043703          	ld	a4,-32(s0)
     c9e:	e398                	sd	a4,0(a5)
     ca0:	00001797          	auipc	a5,0x1
     ca4:	a2078793          	addi	a5,a5,-1504 # 16c0 <freep>
     ca8:	6398                	ld	a4,0(a5)
     caa:	00001797          	auipc	a5,0x1
     cae:	a0678793          	addi	a5,a5,-1530 # 16b0 <base>
     cb2:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     cb4:	00001797          	auipc	a5,0x1
     cb8:	9fc78793          	addi	a5,a5,-1540 # 16b0 <base>
     cbc:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     cc0:	fe043783          	ld	a5,-32(s0)
     cc4:	639c                	ld	a5,0(a5)
     cc6:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     cca:	fe843783          	ld	a5,-24(s0)
     cce:	4798                	lw	a4,8(a5)
     cd0:	fdc42783          	lw	a5,-36(s0)
     cd4:	2781                	sext.w	a5,a5
     cd6:	06f76863          	bltu	a4,a5,d46 <malloc+0xf2>
      if(p->s.size == nunits)
     cda:	fe843783          	ld	a5,-24(s0)
     cde:	4798                	lw	a4,8(a5)
     ce0:	fdc42783          	lw	a5,-36(s0)
     ce4:	2781                	sext.w	a5,a5
     ce6:	00e79963          	bne	a5,a4,cf8 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     cea:	fe843783          	ld	a5,-24(s0)
     cee:	6398                	ld	a4,0(a5)
     cf0:	fe043783          	ld	a5,-32(s0)
     cf4:	e398                	sd	a4,0(a5)
     cf6:	a82d                	j	d30 <malloc+0xdc>
      else {
        p->s.size -= nunits;
     cf8:	fe843783          	ld	a5,-24(s0)
     cfc:	4798                	lw	a4,8(a5)
     cfe:	fdc42783          	lw	a5,-36(s0)
     d02:	40f707bb          	subw	a5,a4,a5
     d06:	0007871b          	sext.w	a4,a5
     d0a:	fe843783          	ld	a5,-24(s0)
     d0e:	c798                	sw	a4,8(a5)
        p += p->s.size;
     d10:	fe843783          	ld	a5,-24(s0)
     d14:	479c                	lw	a5,8(a5)
     d16:	1782                	slli	a5,a5,0x20
     d18:	9381                	srli	a5,a5,0x20
     d1a:	0792                	slli	a5,a5,0x4
     d1c:	fe843703          	ld	a4,-24(s0)
     d20:	97ba                	add	a5,a5,a4
     d22:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     d26:	fe843783          	ld	a5,-24(s0)
     d2a:	fdc42703          	lw	a4,-36(s0)
     d2e:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     d30:	00001797          	auipc	a5,0x1
     d34:	99078793          	addi	a5,a5,-1648 # 16c0 <freep>
     d38:	fe043703          	ld	a4,-32(s0)
     d3c:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     d3e:	fe843783          	ld	a5,-24(s0)
     d42:	07c1                	addi	a5,a5,16
     d44:	a091                	j	d88 <malloc+0x134>
    }
    if(p == freep)
     d46:	00001797          	auipc	a5,0x1
     d4a:	97a78793          	addi	a5,a5,-1670 # 16c0 <freep>
     d4e:	639c                	ld	a5,0(a5)
     d50:	fe843703          	ld	a4,-24(s0)
     d54:	02f71063          	bne	a4,a5,d74 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     d58:	fdc42783          	lw	a5,-36(s0)
     d5c:	853e                	mv	a0,a5
     d5e:	00000097          	auipc	ra,0x0
     d62:	e76080e7          	jalr	-394(ra) # bd4 <morecore>
     d66:	fea43423          	sd	a0,-24(s0)
     d6a:	fe843783          	ld	a5,-24(s0)
     d6e:	e399                	bnez	a5,d74 <malloc+0x120>
        return 0;
     d70:	4781                	li	a5,0
     d72:	a819                	j	d88 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     d74:	fe843783          	ld	a5,-24(s0)
     d78:	fef43023          	sd	a5,-32(s0)
     d7c:	fe843783          	ld	a5,-24(s0)
     d80:	639c                	ld	a5,0(a5)
     d82:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     d86:	b791                	j	cca <malloc+0x76>
  }
}
     d88:	853e                	mv	a0,a5
     d8a:	70e2                	ld	ra,56(sp)
     d8c:	7442                	ld	s0,48(sp)
     d8e:	6121                	addi	sp,sp,64
     d90:	8082                	ret

0000000000000d92 <setjmp>:
     d92:	e100                	sd	s0,0(a0)
     d94:	e504                	sd	s1,8(a0)
     d96:	01253823          	sd	s2,16(a0)
     d9a:	01353c23          	sd	s3,24(a0)
     d9e:	03453023          	sd	s4,32(a0)
     da2:	03553423          	sd	s5,40(a0)
     da6:	03653823          	sd	s6,48(a0)
     daa:	03753c23          	sd	s7,56(a0)
     dae:	05853023          	sd	s8,64(a0)
     db2:	05953423          	sd	s9,72(a0)
     db6:	05a53823          	sd	s10,80(a0)
     dba:	05b53c23          	sd	s11,88(a0)
     dbe:	06153023          	sd	ra,96(a0)
     dc2:	06253423          	sd	sp,104(a0)
     dc6:	4501                	li	a0,0
     dc8:	8082                	ret

0000000000000dca <longjmp>:
     dca:	6100                	ld	s0,0(a0)
     dcc:	6504                	ld	s1,8(a0)
     dce:	01053903          	ld	s2,16(a0)
     dd2:	01853983          	ld	s3,24(a0)
     dd6:	02053a03          	ld	s4,32(a0)
     dda:	02853a83          	ld	s5,40(a0)
     dde:	03053b03          	ld	s6,48(a0)
     de2:	03853b83          	ld	s7,56(a0)
     de6:	04053c03          	ld	s8,64(a0)
     dea:	04853c83          	ld	s9,72(a0)
     dee:	05053d03          	ld	s10,80(a0)
     df2:	05853d83          	ld	s11,88(a0)
     df6:	06053083          	ld	ra,96(a0)
     dfa:	06853103          	ld	sp,104(a0)
     dfe:	c199                	beqz	a1,e04 <longjmp_1>
     e00:	852e                	mv	a0,a1
     e02:	8082                	ret

0000000000000e04 <longjmp_1>:
     e04:	4505                	li	a0,1
     e06:	8082                	ret

0000000000000e08 <schedule_default>:
#define INT_MAX 2147483647
#define TIME_QUANTUM 2  // Define a base time quantum for the round-robin

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
     e08:	715d                	addi	sp,sp,-80
     e0a:	e4a2                	sd	s0,72(sp)
     e0c:	e0a6                	sd	s1,64(sp)
     e0e:	0880                	addi	s0,sp,80
     e10:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
     e12:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
     e16:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     e1a:	649c                	ld	a5,8(s1)
     e1c:	639c                	ld	a5,0(a5)
     e1e:	fcf43c23          	sd	a5,-40(s0)
     e22:	fd843783          	ld	a5,-40(s0)
     e26:	fd878793          	addi	a5,a5,-40
     e2a:	fef43023          	sd	a5,-32(s0)
     e2e:	a81d                	j	e64 <schedule_default+0x5c>
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
     e30:	fe843783          	ld	a5,-24(s0)
     e34:	cb89                	beqz	a5,e46 <schedule_default+0x3e>
     e36:	fe043783          	ld	a5,-32(s0)
     e3a:	5fd8                	lw	a4,60(a5)
     e3c:	fe843783          	ld	a5,-24(s0)
     e40:	5fdc                	lw	a5,60(a5)
     e42:	00f75663          	bge	a4,a5,e4e <schedule_default+0x46>
            thread_with_smallest_id = th;
     e46:	fe043783          	ld	a5,-32(s0)
     e4a:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     e4e:	fe043783          	ld	a5,-32(s0)
     e52:	779c                	ld	a5,40(a5)
     e54:	fcf43823          	sd	a5,-48(s0)
     e58:	fd043783          	ld	a5,-48(s0)
     e5c:	fd878793          	addi	a5,a5,-40
     e60:	fef43023          	sd	a5,-32(s0)
     e64:	fe043783          	ld	a5,-32(s0)
     e68:	02878713          	addi	a4,a5,40
     e6c:	649c                	ld	a5,8(s1)
     e6e:	fcf711e3          	bne	a4,a5,e30 <schedule_default+0x28>
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
     e72:	fe843783          	ld	a5,-24(s0)
     e76:	cf89                	beqz	a5,e90 <schedule_default+0x88>
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
     e78:	fe843783          	ld	a5,-24(s0)
     e7c:	02878793          	addi	a5,a5,40
     e80:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
     e84:	fe843783          	ld	a5,-24(s0)
     e88:	4fbc                	lw	a5,88(a5)
     e8a:	faf42c23          	sw	a5,-72(s0)
     e8e:	a039                	j	e9c <schedule_default+0x94>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
     e90:	649c                	ld	a5,8(s1)
     e92:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
     e96:	4785                	li	a5,1
     e98:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
     e9c:	fb043783          	ld	a5,-80(s0)
     ea0:	fcf43023          	sd	a5,-64(s0)
     ea4:	fb843783          	ld	a5,-72(s0)
     ea8:	fcf43423          	sd	a5,-56(s0)
     eac:	4701                	li	a4,0
     eae:	fc043703          	ld	a4,-64(s0)
     eb2:	4781                	li	a5,0
     eb4:	fc843783          	ld	a5,-56(s0)
     eb8:	863a                	mv	a2,a4
     eba:	86be                	mv	a3,a5
     ebc:	8732                	mv	a4,a2
     ebe:	87b6                	mv	a5,a3
}
     ec0:	853a                	mv	a0,a4
     ec2:	85be                	mv	a1,a5
     ec4:	6426                	ld	s0,72(sp)
     ec6:	6486                	ld	s1,64(sp)
     ec8:	6161                	addi	sp,sp,80
     eca:	8082                	ret

0000000000000ecc <schedule_wrr>:

/* MP3 Part 1 - Non-Real-Time Scheduling */
/* Weighted-Round-Robin Scheduling */
struct threads_sched_result schedule_wrr(struct threads_sched_args args)
{
     ecc:	711d                	addi	sp,sp,-96
     ece:	eca2                	sd	s0,88(sp)
     ed0:	e8a6                	sd	s1,80(sp)
     ed2:	1080                	addi	s0,sp,96
     ed4:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the weighted round-robin scheduling algorithm
    static struct thread *last_thread = NULL;
    struct thread *selected_thread = NULL;
     ed6:	fe043423          	sd	zero,-24(s0)
    struct thread *candidate = NULL;
     eda:	fe043023          	sd	zero,-32(s0)

    // If last_thread is NULL or its remaining time is zero, reset the selection process
    if (last_thread == NULL || last_thread->remaining_time <= 0) {
     ede:	00000797          	auipc	a5,0x0
     ee2:	7ea78793          	addi	a5,a5,2026 # 16c8 <last_thread.1226>
     ee6:	639c                	ld	a5,0(a5)
     ee8:	cb89                	beqz	a5,efa <schedule_wrr+0x2e>
     eea:	00000797          	auipc	a5,0x0
     eee:	7de78793          	addi	a5,a5,2014 # 16c8 <last_thread.1226>
     ef2:	639c                	ld	a5,0(a5)
     ef4:	4fbc                	lw	a5,88(a5)
     ef6:	00f04863          	bgtz	a5,f06 <schedule_wrr+0x3a>
        last_thread = NULL;
     efa:	00000797          	auipc	a5,0x0
     efe:	7ce78793          	addi	a5,a5,1998 # 16c8 <last_thread.1226>
     f02:	0007b023          	sd	zero,0(a5)
    }

    // Find the first thread that is ready to run
    list_for_each_entry(candidate, args.run_queue, thread_list) {
     f06:	649c                	ld	a5,8(s1)
     f08:	639c                	ld	a5,0(a5)
     f0a:	fcf43823          	sd	a5,-48(s0)
     f0e:	fd043783          	ld	a5,-48(s0)
     f12:	fd878793          	addi	a5,a5,-40
     f16:	fef43023          	sd	a5,-32(s0)
     f1a:	a0a9                	j	f64 <schedule_wrr+0x98>
        if (!last_thread && candidate->remaining_time > 0)
     f1c:	00000797          	auipc	a5,0x0
     f20:	7ac78793          	addi	a5,a5,1964 # 16c8 <last_thread.1226>
     f24:	639c                	ld	a5,0(a5)
     f26:	eb91                	bnez	a5,f3a <schedule_wrr+0x6e>
     f28:	fe043783          	ld	a5,-32(s0)
     f2c:	4fbc                	lw	a5,88(a5)
     f2e:	00f05663          	blez	a5,f3a <schedule_wrr+0x6e>
            selected_thread = candidate;
     f32:	fe043783          	ld	a5,-32(s0)
     f36:	fef43423          	sd	a5,-24(s0)
        if (candidate->remaining_time > 0) {
     f3a:	fe043783          	ld	a5,-32(s0)
     f3e:	4fbc                	lw	a5,88(a5)
     f40:	00f05763          	blez	a5,f4e <schedule_wrr+0x82>
            selected_thread = candidate;
     f44:	fe043783          	ld	a5,-32(s0)
     f48:	fef43423          	sd	a5,-24(s0)
            break;
     f4c:	a01d                	j	f72 <schedule_wrr+0xa6>
    list_for_each_entry(candidate, args.run_queue, thread_list) {
     f4e:	fe043783          	ld	a5,-32(s0)
     f52:	779c                	ld	a5,40(a5)
     f54:	fcf43423          	sd	a5,-56(s0)
     f58:	fc843783          	ld	a5,-56(s0)
     f5c:	fd878793          	addi	a5,a5,-40
     f60:	fef43023          	sd	a5,-32(s0)
     f64:	fe043783          	ld	a5,-32(s0)
     f68:	02878713          	addi	a4,a5,40
     f6c:	649c                	ld	a5,8(s1)
     f6e:	faf717e3          	bne	a4,a5,f1c <schedule_wrr+0x50>
        }
    }

    // Fall back to the last_thread if no other thread is selected and it still has remaining time
    if (!selected_thread && last_thread && last_thread->remaining_time > 0) {
     f72:	fe843783          	ld	a5,-24(s0)
     f76:	e795                	bnez	a5,fa2 <schedule_wrr+0xd6>
     f78:	00000797          	auipc	a5,0x0
     f7c:	75078793          	addi	a5,a5,1872 # 16c8 <last_thread.1226>
     f80:	639c                	ld	a5,0(a5)
     f82:	c385                	beqz	a5,fa2 <schedule_wrr+0xd6>
     f84:	00000797          	auipc	a5,0x0
     f88:	74478793          	addi	a5,a5,1860 # 16c8 <last_thread.1226>
     f8c:	639c                	ld	a5,0(a5)
     f8e:	4fbc                	lw	a5,88(a5)
     f90:	00f05963          	blez	a5,fa2 <schedule_wrr+0xd6>
        selected_thread = last_thread;
     f94:	00000797          	auipc	a5,0x0
     f98:	73478793          	addi	a5,a5,1844 # 16c8 <last_thread.1226>
     f9c:	639c                	ld	a5,0(a5)
     f9e:	fef43423          	sd	a5,-24(s0)
    }

    // Set the scheduling result
    if (selected_thread) {
     fa2:	fe843783          	ld	a5,-24(s0)
     fa6:	c7b9                	beqz	a5,ff4 <schedule_wrr+0x128>
        int time_slice = selected_thread->weight * TIME_QUANTUM;
     fa8:	fe843783          	ld	a5,-24(s0)
     fac:	47bc                	lw	a5,72(a5)
     fae:	0017979b          	slliw	a5,a5,0x1
     fb2:	fcf42e23          	sw	a5,-36(s0)
        if (time_slice > selected_thread->remaining_time) {
     fb6:	fe843783          	ld	a5,-24(s0)
     fba:	4fb8                	lw	a4,88(a5)
     fbc:	fdc42783          	lw	a5,-36(s0)
     fc0:	2781                	sext.w	a5,a5
     fc2:	00f75763          	bge	a4,a5,fd0 <schedule_wrr+0x104>
            time_slice = selected_thread->remaining_time;
     fc6:	fe843783          	ld	a5,-24(s0)
     fca:	4fbc                	lw	a5,88(a5)
     fcc:	fcf42e23          	sw	a5,-36(s0)
        }
        r.scheduled_thread_list_member = &selected_thread->thread_list;
     fd0:	fe843783          	ld	a5,-24(s0)
     fd4:	02878793          	addi	a5,a5,40
     fd8:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = time_slice;
     fdc:	fdc42783          	lw	a5,-36(s0)
     fe0:	faf42823          	sw	a5,-80(s0)
        last_thread = selected_thread;  // Update the last run thread
     fe4:	00000797          	auipc	a5,0x0
     fe8:	6e478793          	addi	a5,a5,1764 # 16c8 <last_thread.1226>
     fec:	fe843703          	ld	a4,-24(s0)
     ff0:	e398                	sd	a4,0(a5)
     ff2:	a039                	j	1000 <schedule_wrr+0x134>
    } else {
        // Idle if no suitable thread is found
        r.scheduled_thread_list_member = args.run_queue;
     ff4:	649c                	ld	a5,8(s1)
     ff6:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = 1;
     ffa:	4785                	li	a5,1
     ffc:	faf42823          	sw	a5,-80(s0)
    }

    return r;
    1000:	fa843783          	ld	a5,-88(s0)
    1004:	faf43c23          	sd	a5,-72(s0)
    1008:	fb043783          	ld	a5,-80(s0)
    100c:	fcf43023          	sd	a5,-64(s0)
    1010:	4701                	li	a4,0
    1012:	fb843703          	ld	a4,-72(s0)
    1016:	4781                	li	a5,0
    1018:	fc043783          	ld	a5,-64(s0)
    101c:	863a                	mv	a2,a4
    101e:	86be                	mv	a3,a5
    1020:	8732                	mv	a4,a2
    1022:	87b6                	mv	a5,a3
}
    1024:	853a                	mv	a0,a4
    1026:	85be                	mv	a1,a5
    1028:	6466                	ld	s0,88(sp)
    102a:	64c6                	ld	s1,80(sp)
    102c:	6125                	addi	sp,sp,96
    102e:	8082                	ret

0000000000001030 <find_next_release_time>:

int find_next_release_time(struct list_head *release_queue, int current_time) {
    1030:	7139                	addi	sp,sp,-64
    1032:	fc22                	sd	s0,56(sp)
    1034:	0080                	addi	s0,sp,64
    1036:	fca43423          	sd	a0,-56(s0)
    103a:	87ae                	mv	a5,a1
    103c:	fcf42223          	sw	a5,-60(s0)
    struct release_queue_entry *next_release = NULL;
    1040:	fe043423          	sd	zero,-24(s0)
    int next_release_time = INT_MAX;
    1044:	800007b7          	lui	a5,0x80000
    1048:	fff7c793          	not	a5,a5
    104c:	fef42223          	sw	a5,-28(s0)

    list_for_each_entry(next_release, release_queue, thread_list) {
    1050:	fc843783          	ld	a5,-56(s0)
    1054:	639c                	ld	a5,0(a5)
    1056:	fcf43c23          	sd	a5,-40(s0)
    105a:	fd843783          	ld	a5,-40(s0)
    105e:	17e1                	addi	a5,a5,-8
    1060:	fef43423          	sd	a5,-24(s0)
    1064:	a081                	j	10a4 <find_next_release_time+0x74>
        if (next_release->release_time > current_time && next_release->release_time < next_release_time) {
    1066:	fe843783          	ld	a5,-24(s0)
    106a:	4f98                	lw	a4,24(a5)
    106c:	fc442783          	lw	a5,-60(s0)
    1070:	2781                	sext.w	a5,a5
    1072:	00e7df63          	bge	a5,a4,1090 <find_next_release_time+0x60>
    1076:	fe843783          	ld	a5,-24(s0)
    107a:	4f98                	lw	a4,24(a5)
    107c:	fe442783          	lw	a5,-28(s0)
    1080:	2781                	sext.w	a5,a5
    1082:	00f75763          	bge	a4,a5,1090 <find_next_release_time+0x60>
            next_release_time = next_release->release_time;
    1086:	fe843783          	ld	a5,-24(s0)
    108a:	4f9c                	lw	a5,24(a5)
    108c:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(next_release, release_queue, thread_list) {
    1090:	fe843783          	ld	a5,-24(s0)
    1094:	679c                	ld	a5,8(a5)
    1096:	fcf43823          	sd	a5,-48(s0)
    109a:	fd043783          	ld	a5,-48(s0)
    109e:	17e1                	addi	a5,a5,-8
    10a0:	fef43423          	sd	a5,-24(s0)
    10a4:	fe843783          	ld	a5,-24(s0)
    10a8:	07a1                	addi	a5,a5,8
    10aa:	fc843703          	ld	a4,-56(s0)
    10ae:	faf71ce3          	bne	a4,a5,1066 <find_next_release_time+0x36>
        }
    }

    if (next_release_time == INT_MAX)
    10b2:	fe442783          	lw	a5,-28(s0)
    10b6:	0007871b          	sext.w	a4,a5
    10ba:	800007b7          	lui	a5,0x80000
    10be:	fff7c793          	not	a5,a5
    10c2:	00f71463          	bne	a4,a5,10ca <find_next_release_time+0x9a>
        return -1; // No threads in the release queue
    10c6:	57fd                	li	a5,-1
    10c8:	a801                	j	10d8 <find_next_release_time+0xa8>

    return next_release_time - current_time;
    10ca:	fe442703          	lw	a4,-28(s0)
    10ce:	fc442783          	lw	a5,-60(s0)
    10d2:	40f707bb          	subw	a5,a4,a5
    10d6:	2781                	sext.w	a5,a5
}
    10d8:	853e                	mv	a0,a5
    10da:	7462                	ld	s0,56(sp)
    10dc:	6121                	addi	sp,sp,64
    10de:	8082                	ret

00000000000010e0 <find_earliest_impactful_release_time>:



int find_earliest_impactful_release_time(struct list_head *release_queue, struct list_head *run_queue, int current_time) {
    10e0:	7159                	addi	sp,sp,-112
    10e2:	f4a2                	sd	s0,104(sp)
    10e4:	1880                	addi	s0,sp,112
    10e6:	faa43423          	sd	a0,-88(s0)
    10ea:	fab43023          	sd	a1,-96(s0)
    10ee:	87b2                	mv	a5,a2
    10f0:	f8f42e23          	sw	a5,-100(s0)
    struct release_queue_entry *entry;
    int earliest_impactful_time = INT_MAX;
    10f4:	800007b7          	lui	a5,0x80000
    10f8:	fff7c793          	not	a5,a5
    10fc:	fef42223          	sw	a5,-28(s0)
    int shortest_current_time = INT_MAX;
    1100:	800007b7          	lui	a5,0x80000
    1104:	fff7c793          	not	a5,a5
    1108:	fef42023          	sw	a5,-32(s0)

    // Find the shortest remaining time among currently running tasks
    struct thread *t;
    list_for_each_entry(t, run_queue, thread_list) {
    110c:	fa043783          	ld	a5,-96(s0)
    1110:	639c                	ld	a5,0(a5)
    1112:	fcf43823          	sd	a5,-48(s0)
    1116:	fd043783          	ld	a5,-48(s0)
    111a:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe140>
    111e:	fcf43c23          	sd	a5,-40(s0)
    1122:	a80d                	j	1154 <find_earliest_impactful_release_time+0x74>
        if (t->remaining_time < shortest_current_time) {
    1124:	fd843783          	ld	a5,-40(s0)
    1128:	4fb8                	lw	a4,88(a5)
    112a:	fe042783          	lw	a5,-32(s0)
    112e:	2781                	sext.w	a5,a5
    1130:	00f75763          	bge	a4,a5,113e <find_earliest_impactful_release_time+0x5e>
            shortest_current_time = t->remaining_time;
    1134:	fd843783          	ld	a5,-40(s0)
    1138:	4fbc                	lw	a5,88(a5)
    113a:	fef42023          	sw	a5,-32(s0)
    list_for_each_entry(t, run_queue, thread_list) {
    113e:	fd843783          	ld	a5,-40(s0)
    1142:	779c                	ld	a5,40(a5)
    1144:	faf43c23          	sd	a5,-72(s0)
    1148:	fb843783          	ld	a5,-72(s0)
    114c:	fd878793          	addi	a5,a5,-40
    1150:	fcf43c23          	sd	a5,-40(s0)
    1154:	fd843783          	ld	a5,-40(s0)
    1158:	02878793          	addi	a5,a5,40
    115c:	fa043703          	ld	a4,-96(s0)
    1160:	fcf712e3          	bne	a4,a5,1124 <find_earliest_impactful_release_time+0x44>
        }
    }

    // Check the release queue for the next task that might preempt the current shortest job
    list_for_each_entry(entry, release_queue, thread_list) {
    1164:	fa843783          	ld	a5,-88(s0)
    1168:	639c                	ld	a5,0(a5)
    116a:	fcf43423          	sd	a5,-56(s0)
    116e:	fc843783          	ld	a5,-56(s0)
    1172:	17e1                	addi	a5,a5,-8
    1174:	fef43423          	sd	a5,-24(s0)
    1178:	a889                	j	11ca <find_earliest_impactful_release_time+0xea>
        if (entry->release_time > current_time && entry->release_time < earliest_impactful_time) {
    117a:	fe843783          	ld	a5,-24(s0)
    117e:	4f98                	lw	a4,24(a5)
    1180:	f9c42783          	lw	a5,-100(s0)
    1184:	2781                	sext.w	a5,a5
    1186:	02e7d863          	bge	a5,a4,11b6 <find_earliest_impactful_release_time+0xd6>
    118a:	fe843783          	ld	a5,-24(s0)
    118e:	4f98                	lw	a4,24(a5)
    1190:	fe442783          	lw	a5,-28(s0)
    1194:	2781                	sext.w	a5,a5
    1196:	02f75063          	bge	a4,a5,11b6 <find_earliest_impactful_release_time+0xd6>
            if (entry->thrd->remaining_time < shortest_current_time) {
    119a:	fe843783          	ld	a5,-24(s0)
    119e:	639c                	ld	a5,0(a5)
    11a0:	4fb8                	lw	a4,88(a5)
    11a2:	fe042783          	lw	a5,-32(s0)
    11a6:	2781                	sext.w	a5,a5
    11a8:	00f75763          	bge	a4,a5,11b6 <find_earliest_impactful_release_time+0xd6>
                earliest_impactful_time = entry->release_time;
    11ac:	fe843783          	ld	a5,-24(s0)
    11b0:	4f9c                	lw	a5,24(a5)
    11b2:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(entry, release_queue, thread_list) {
    11b6:	fe843783          	ld	a5,-24(s0)
    11ba:	679c                	ld	a5,8(a5)
    11bc:	fcf43023          	sd	a5,-64(s0)
    11c0:	fc043783          	ld	a5,-64(s0)
    11c4:	17e1                	addi	a5,a5,-8
    11c6:	fef43423          	sd	a5,-24(s0)
    11ca:	fe843783          	ld	a5,-24(s0)
    11ce:	07a1                	addi	a5,a5,8
    11d0:	fa843703          	ld	a4,-88(s0)
    11d4:	faf713e3          	bne	a4,a5,117a <find_earliest_impactful_release_time+0x9a>
            }
        }
    }

    // Calculate the difference between the current time and the earliest impactful release time
    return earliest_impactful_time == INT_MAX ? -1 : earliest_impactful_time - current_time;
    11d8:	fe442783          	lw	a5,-28(s0)
    11dc:	0007871b          	sext.w	a4,a5
    11e0:	800007b7          	lui	a5,0x80000
    11e4:	fff7c793          	not	a5,a5
    11e8:	00f70a63          	beq	a4,a5,11fc <find_earliest_impactful_release_time+0x11c>
    11ec:	fe442703          	lw	a4,-28(s0)
    11f0:	f9c42783          	lw	a5,-100(s0)
    11f4:	40f707bb          	subw	a5,a4,a5
    11f8:	2781                	sext.w	a5,a5
    11fa:	a011                	j	11fe <find_earliest_impactful_release_time+0x11e>
    11fc:	57fd                	li	a5,-1
}
    11fe:	853e                	mv	a0,a5
    1200:	7426                	ld	s0,104(sp)
    1202:	6165                	addi	sp,sp,112
    1204:	8082                	ret

0000000000001206 <schedule_sjf>:


struct threads_sched_result schedule_sjf(struct threads_sched_args args) {
    1206:	7119                	addi	sp,sp,-128
    1208:	fc86                	sd	ra,120(sp)
    120a:	f8a2                	sd	s0,112(sp)
    120c:	f4a6                	sd	s1,104(sp)
    120e:	f0ca                	sd	s2,96(sp)
    1210:	ecce                	sd	s3,88(sp)
    1212:	0100                	addi	s0,sp,128
    1214:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *shortest_job = NULL;
    1216:	fc043423          	sd	zero,-56(s0)
    struct thread *current;
    int shortest_time = INT_MAX;
    121a:	800007b7          	lui	a5,0x80000
    121e:	fff7c793          	not	a5,a5
    1222:	faf42e23          	sw	a5,-68(s0)
    int earliest_impactful_time = find_earliest_impactful_release_time(args.release_queue, args.run_queue, args.current_time);
    1226:	689c                	ld	a5,16(s1)
    1228:	6498                	ld	a4,8(s1)
    122a:	4094                	lw	a3,0(s1)
    122c:	8636                	mv	a2,a3
    122e:	85ba                	mv	a1,a4
    1230:	853e                	mv	a0,a5
    1232:	00000097          	auipc	ra,0x0
    1236:	eae080e7          	jalr	-338(ra) # 10e0 <find_earliest_impactful_release_time>
    123a:	87aa                	mv	a5,a0
    123c:	faf42a23          	sw	a5,-76(s0)

    // Determine the shortest job from the run queue
    list_for_each_entry(current, args.run_queue, thread_list) {
    1240:	649c                	ld	a5,8(s1)
    1242:	639c                	ld	a5,0(a5)
    1244:	faf43423          	sd	a5,-88(s0)
    1248:	fa843783          	ld	a5,-88(s0)
    124c:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe140>
    1250:	fcf43023          	sd	a5,-64(s0)
    1254:	a82d                	j	128e <schedule_sjf+0x88>
        if (current->remaining_time < shortest_time) {
    1256:	fc043783          	ld	a5,-64(s0)
    125a:	4fb8                	lw	a4,88(a5)
    125c:	fbc42783          	lw	a5,-68(s0)
    1260:	2781                	sext.w	a5,a5
    1262:	00f75b63          	bge	a4,a5,1278 <schedule_sjf+0x72>
            shortest_time = current->remaining_time;
    1266:	fc043783          	ld	a5,-64(s0)
    126a:	4fbc                	lw	a5,88(a5)
    126c:	faf42e23          	sw	a5,-68(s0)
            shortest_job = current;
    1270:	fc043783          	ld	a5,-64(s0)
    1274:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(current, args.run_queue, thread_list) {
    1278:	fc043783          	ld	a5,-64(s0)
    127c:	779c                	ld	a5,40(a5)
    127e:	faf43023          	sd	a5,-96(s0)
    1282:	fa043783          	ld	a5,-96(s0)
    1286:	fd878793          	addi	a5,a5,-40
    128a:	fcf43023          	sd	a5,-64(s0)
    128e:	fc043783          	ld	a5,-64(s0)
    1292:	02878713          	addi	a4,a5,40
    1296:	649c                	ld	a5,8(s1)
    1298:	faf71fe3          	bne	a4,a5,1256 <schedule_sjf+0x50>
        }
    }

    if (shortest_job) {
    129c:	fc843783          	ld	a5,-56(s0)
    12a0:	c7a1                	beqz	a5,12e8 <schedule_sjf+0xe2>
        int time_to_allocate = shortest_job->remaining_time;
    12a2:	fc843783          	ld	a5,-56(s0)
    12a6:	4fbc                	lw	a5,88(a5)
    12a8:	faf42c23          	sw	a5,-72(s0)
        // Reduce the time slice if an impactful task is arriving sooner
        if (earliest_impactful_time != -1 && earliest_impactful_time < time_to_allocate) {
    12ac:	fb442783          	lw	a5,-76(s0)
    12b0:	0007871b          	sext.w	a4,a5
    12b4:	57fd                	li	a5,-1
    12b6:	00f70e63          	beq	a4,a5,12d2 <schedule_sjf+0xcc>
    12ba:	fb442703          	lw	a4,-76(s0)
    12be:	fb842783          	lw	a5,-72(s0)
    12c2:	2701                	sext.w	a4,a4
    12c4:	2781                	sext.w	a5,a5
    12c6:	00f75663          	bge	a4,a5,12d2 <schedule_sjf+0xcc>
            time_to_allocate = earliest_impactful_time;
    12ca:	fb442783          	lw	a5,-76(s0)
    12ce:	faf42c23          	sw	a5,-72(s0)
        }

        r.scheduled_thread_list_member = &shortest_job->thread_list;
    12d2:	fc843783          	ld	a5,-56(s0)
    12d6:	02878793          	addi	a5,a5,40
    12da:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = time_to_allocate;
    12de:	fb842783          	lw	a5,-72(s0)
    12e2:	f8f42423          	sw	a5,-120(s0)
    12e6:	a00d                	j	1308 <schedule_sjf+0x102>
    } else {
        // If no current tasks are ready, wait for the next impactful task
        r.scheduled_thread_list_member = args.run_queue;
    12e8:	649c                	ld	a5,8(s1)
    12ea:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = earliest_impactful_time != -1 ? earliest_impactful_time : 1;  // Minimal quantum if unsure
    12ee:	fb442783          	lw	a5,-76(s0)
    12f2:	0007871b          	sext.w	a4,a5
    12f6:	57fd                	li	a5,-1
    12f8:	00f70563          	beq	a4,a5,1302 <schedule_sjf+0xfc>
    12fc:	fb442783          	lw	a5,-76(s0)
    1300:	a011                	j	1304 <schedule_sjf+0xfe>
    1302:	4785                	li	a5,1
    1304:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    1308:	f8043783          	ld	a5,-128(s0)
    130c:	f8f43823          	sd	a5,-112(s0)
    1310:	f8843783          	ld	a5,-120(s0)
    1314:	f8f43c23          	sd	a5,-104(s0)
    1318:	4701                	li	a4,0
    131a:	f9043703          	ld	a4,-112(s0)
    131e:	4781                	li	a5,0
    1320:	f9843783          	ld	a5,-104(s0)
    1324:	893a                	mv	s2,a4
    1326:	89be                	mv	s3,a5
    1328:	874a                	mv	a4,s2
    132a:	87ce                	mv	a5,s3
}
    132c:	853a                	mv	a0,a4
    132e:	85be                	mv	a1,a5
    1330:	70e6                	ld	ra,120(sp)
    1332:	7446                	ld	s0,112(sp)
    1334:	74a6                	ld	s1,104(sp)
    1336:	7906                	ld	s2,96(sp)
    1338:	69e6                	ld	s3,88(sp)
    133a:	6109                	addi	sp,sp,128
    133c:	8082                	ret

000000000000133e <schedule_lst>:


/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args)
{
    133e:	7119                	addi	sp,sp,-128
    1340:	fc86                	sd	ra,120(sp)
    1342:	f8a2                	sd	s0,112(sp)
    1344:	f4a6                	sd	s1,104(sp)
    1346:	f0ca                	sd	s2,96(sp)
    1348:	ecce                	sd	s3,88(sp)
    134a:	0100                	addi	s0,sp,128
    134c:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the least-slack-time scheduling algorithm
    struct thread *min_slack = NULL;
    134e:	fc043423          	sd	zero,-56(s0)
    int min_slack_time = INT_MAX;
    1352:	800007b7          	lui	a5,0x80000
    1356:	fff7c793          	not	a5,a5
    135a:	fcf42223          	sw	a5,-60(s0)
    struct thread *t;

    // Find the thread with the minimum slack time
    list_for_each_entry(t, args.run_queue, thread_list) {
    135e:	649c                	ld	a5,8(s1)
    1360:	639c                	ld	a5,0(a5)
    1362:	faf43823          	sd	a5,-80(s0)
    1366:	fb043783          	ld	a5,-80(s0)
    136a:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe140>
    136e:	faf43c23          	sd	a5,-72(s0)
    1372:	a8b5                	j	13ee <schedule_lst+0xb0>
        int slack_time = t->deadline - args.current_time - t->remaining_time;
    1374:	fb843783          	ld	a5,-72(s0)
    1378:	47f8                	lw	a4,76(a5)
    137a:	409c                	lw	a5,0(s1)
    137c:	40f707bb          	subw	a5,a4,a5
    1380:	0007871b          	sext.w	a4,a5
    1384:	fb843783          	ld	a5,-72(s0)
    1388:	4fbc                	lw	a5,88(a5)
    138a:	40f707bb          	subw	a5,a4,a5
    138e:	faf42623          	sw	a5,-84(s0)
        if (min_slack == NULL || slack_time < min_slack_time ||
    1392:	fc843783          	ld	a5,-56(s0)
    1396:	cb8d                	beqz	a5,13c8 <schedule_lst+0x8a>
    1398:	fac42703          	lw	a4,-84(s0)
    139c:	fc442783          	lw	a5,-60(s0)
    13a0:	2701                	sext.w	a4,a4
    13a2:	2781                	sext.w	a5,a5
    13a4:	02f74263          	blt	a4,a5,13c8 <schedule_lst+0x8a>
    13a8:	fac42703          	lw	a4,-84(s0)
    13ac:	fc442783          	lw	a5,-60(s0)
    13b0:	2701                	sext.w	a4,a4
    13b2:	2781                	sext.w	a5,a5
    13b4:	02f71263          	bne	a4,a5,13d8 <schedule_lst+0x9a>
            (slack_time == min_slack_time && t->ID < min_slack->ID)) {
    13b8:	fb843783          	ld	a5,-72(s0)
    13bc:	5fd8                	lw	a4,60(a5)
    13be:	fc843783          	ld	a5,-56(s0)
    13c2:	5fdc                	lw	a5,60(a5)
    13c4:	00f75a63          	bge	a4,a5,13d8 <schedule_lst+0x9a>
            min_slack = t;
    13c8:	fb843783          	ld	a5,-72(s0)
    13cc:	fcf43423          	sd	a5,-56(s0)
            min_slack_time = slack_time;
    13d0:	fac42783          	lw	a5,-84(s0)
    13d4:	fcf42223          	sw	a5,-60(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    13d8:	fb843783          	ld	a5,-72(s0)
    13dc:	779c                	ld	a5,40(a5)
    13de:	faf43023          	sd	a5,-96(s0)
    13e2:	fa043783          	ld	a5,-96(s0)
    13e6:	fd878793          	addi	a5,a5,-40
    13ea:	faf43c23          	sd	a5,-72(s0)
    13ee:	fb843783          	ld	a5,-72(s0)
    13f2:	02878713          	addi	a4,a5,40
    13f6:	649c                	ld	a5,8(s1)
    13f8:	f6f71ee3          	bne	a4,a5,1374 <schedule_lst+0x36>
        }
    }

    if (min_slack) {
    13fc:	fc843783          	ld	a5,-56(s0)
    1400:	cf89                	beqz	a5,141a <schedule_lst+0xdc>
        r.scheduled_thread_list_member = &min_slack->thread_list;
    1402:	fc843783          	ld	a5,-56(s0)
    1406:	02878793          	addi	a5,a5,40
    140a:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = min_slack->remaining_time;
    140e:	fc843783          	ld	a5,-56(s0)
    1412:	4fbc                	lw	a5,88(a5)
    1414:	f8f42423          	sw	a5,-120(s0)
    1418:	a839                	j	1436 <schedule_lst+0xf8>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
    141a:	649c                	ld	a5,8(s1)
    141c:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    1420:	689c                	ld	a5,16(s1)
    1422:	4098                	lw	a4,0(s1)
    1424:	85ba                	mv	a1,a4
    1426:	853e                	mv	a0,a5
    1428:	00000097          	auipc	ra,0x0
    142c:	c08080e7          	jalr	-1016(ra) # 1030 <find_next_release_time>
    1430:	87aa                	mv	a5,a0
    1432:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    1436:	f8043783          	ld	a5,-128(s0)
    143a:	f8f43823          	sd	a5,-112(s0)
    143e:	f8843783          	ld	a5,-120(s0)
    1442:	f8f43c23          	sd	a5,-104(s0)
    1446:	4701                	li	a4,0
    1448:	f9043703          	ld	a4,-112(s0)
    144c:	4781                	li	a5,0
    144e:	f9843783          	ld	a5,-104(s0)
    1452:	893a                	mv	s2,a4
    1454:	89be                	mv	s3,a5
    1456:	874a                	mv	a4,s2
    1458:	87ce                	mv	a5,s3
}
    145a:	853a                	mv	a0,a4
    145c:	85be                	mv	a1,a5
    145e:	70e6                	ld	ra,120(sp)
    1460:	7446                	ld	s0,112(sp)
    1462:	74a6                	ld	s1,104(sp)
    1464:	7906                	ld	s2,96(sp)
    1466:	69e6                	ld	s3,88(sp)
    1468:	6109                	addi	sp,sp,128
    146a:	8082                	ret

000000000000146c <schedule_dm>:

/* Deadline-Monotonic Scheduling */
struct threads_sched_result schedule_dm(struct threads_sched_args args)
{
    146c:	7135                	addi	sp,sp,-160
    146e:	ed06                	sd	ra,152(sp)
    1470:	e922                	sd	s0,144(sp)
    1472:	e526                	sd	s1,136(sp)
    1474:	e14a                	sd	s2,128(sp)
    1476:	fcce                	sd	s3,120(sp)
    1478:	1100                	addi	s0,sp,160
    147a:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the deadline-monotonic scheduling algorithm
   struct thread *earliest_deadline_thread = NULL;
    147c:	fc043423          	sd	zero,-56(s0)
    struct thread *t;
    int earliest_deadline = INT_MAX;
    1480:	800007b7          	lui	a5,0x80000
    1484:	fff7c793          	not	a5,a5
    1488:	faf42e23          	sw	a5,-68(s0)

    // Find the earliest deadline real-time thread
    list_for_each_entry(t, args.run_queue, thread_list) {
    148c:	649c                	ld	a5,8(s1)
    148e:	639c                	ld	a5,0(a5)
    1490:	faf43423          	sd	a5,-88(s0)
    1494:	fa843783          	ld	a5,-88(s0)
    1498:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe140>
    149c:	fcf43023          	sd	a5,-64(s0)
    14a0:	a841                	j	1530 <schedule_dm+0xc4>
        if (t->is_real_time && t->period != -1 && t->current_deadline < earliest_deadline) {
    14a2:	fc043783          	ld	a5,-64(s0)
    14a6:	43bc                	lw	a5,64(a5)
    14a8:	cb95                	beqz	a5,14dc <schedule_dm+0x70>
    14aa:	fc043783          	ld	a5,-64(s0)
    14ae:	4bbc                	lw	a5,80(a5)
    14b0:	873e                	mv	a4,a5
    14b2:	57fd                	li	a5,-1
    14b4:	02f70463          	beq	a4,a5,14dc <schedule_dm+0x70>
    14b8:	fc043783          	ld	a5,-64(s0)
    14bc:	4ff8                	lw	a4,92(a5)
    14be:	fbc42783          	lw	a5,-68(s0)
    14c2:	2781                	sext.w	a5,a5
    14c4:	00f75c63          	bge	a4,a5,14dc <schedule_dm+0x70>
            earliest_deadline = t->current_deadline;
    14c8:	fc043783          	ld	a5,-64(s0)
    14cc:	4ffc                	lw	a5,92(a5)
    14ce:	faf42e23          	sw	a5,-68(s0)
            earliest_deadline_thread = t;
    14d2:	fc043783          	ld	a5,-64(s0)
    14d6:	fcf43423          	sd	a5,-56(s0)
    14da:	a081                	j	151a <schedule_dm+0xae>
        } else if (t->is_real_time && t->period != -1 && t->current_deadline == earliest_deadline && t->ID < earliest_deadline_thread->ID) {
    14dc:	fc043783          	ld	a5,-64(s0)
    14e0:	43bc                	lw	a5,64(a5)
    14e2:	cf85                	beqz	a5,151a <schedule_dm+0xae>
    14e4:	fc043783          	ld	a5,-64(s0)
    14e8:	4bbc                	lw	a5,80(a5)
    14ea:	873e                	mv	a4,a5
    14ec:	57fd                	li	a5,-1
    14ee:	02f70663          	beq	a4,a5,151a <schedule_dm+0xae>
    14f2:	fc043783          	ld	a5,-64(s0)
    14f6:	4ff8                	lw	a4,92(a5)
    14f8:	fbc42783          	lw	a5,-68(s0)
    14fc:	2781                	sext.w	a5,a5
    14fe:	00e79e63          	bne	a5,a4,151a <schedule_dm+0xae>
    1502:	fc043783          	ld	a5,-64(s0)
    1506:	5fd8                	lw	a4,60(a5)
    1508:	fc843783          	ld	a5,-56(s0)
    150c:	5fdc                	lw	a5,60(a5)
    150e:	00f75663          	bge	a4,a5,151a <schedule_dm+0xae>
            earliest_deadline_thread = t;  // Tie-breaking by ID
    1512:	fc043783          	ld	a5,-64(s0)
    1516:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    151a:	fc043783          	ld	a5,-64(s0)
    151e:	779c                	ld	a5,40(a5)
    1520:	f8f43423          	sd	a5,-120(s0)
    1524:	f8843783          	ld	a5,-120(s0)
    1528:	fd878793          	addi	a5,a5,-40
    152c:	fcf43023          	sd	a5,-64(s0)
    1530:	fc043783          	ld	a5,-64(s0)
    1534:	02878713          	addi	a4,a5,40
    1538:	649c                	ld	a5,8(s1)
    153a:	f6f714e3          	bne	a4,a5,14a2 <schedule_dm+0x36>
        }
    }

    if (earliest_deadline_thread) {
    153e:	fc843783          	ld	a5,-56(s0)
    1542:	c7a5                	beqz	a5,15aa <schedule_dm+0x13e>
        int time_to_deadline = earliest_deadline_thread->current_deadline - args.current_time;
    1544:	fc843783          	ld	a5,-56(s0)
    1548:	4ff8                	lw	a4,92(a5)
    154a:	409c                	lw	a5,0(s1)
    154c:	40f707bb          	subw	a5,a4,a5
    1550:	f8f42a23          	sw	a5,-108(s0)
        if (earliest_deadline_thread->remaining_time > time_to_deadline) {
    1554:	fc843783          	ld	a5,-56(s0)
    1558:	4fb8                	lw	a4,88(a5)
    155a:	f9442783          	lw	a5,-108(s0)
    155e:	2781                	sext.w	a5,a5
    1560:	00e7db63          	bge	a5,a4,1576 <schedule_dm+0x10a>
            // The real-time thread cannot complete before its deadline, so handle the deadline miss
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    1564:	fc843783          	ld	a5,-56(s0)
    1568:	02878793          	addi	a5,a5,40
    156c:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = 0; // Could set to minimal quantum to allow cleanup or logging
    1570:	f6042823          	sw	zero,-144(s0)
    1574:	a0f1                	j	1640 <schedule_dm+0x1d4>
        } else {
            // Schedule the real-time thread normally if it hasn't missed its deadline
            int time_slice = (time_to_deadline < earliest_deadline_thread->remaining_time) ? time_to_deadline : earliest_deadline_thread->remaining_time;
    1576:	fc843783          	ld	a5,-56(s0)
    157a:	4fbc                	lw	a5,88(a5)
    157c:	863e                	mv	a2,a5
    157e:	f9442783          	lw	a5,-108(s0)
    1582:	0007869b          	sext.w	a3,a5
    1586:	0006071b          	sext.w	a4,a2
    158a:	00d75363          	bge	a4,a3,1590 <schedule_dm+0x124>
    158e:	87b2                	mv	a5,a2
    1590:	f8f42823          	sw	a5,-112(s0)
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    1594:	fc843783          	ld	a5,-56(s0)
    1598:	02878793          	addi	a5,a5,40
    159c:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = time_slice;
    15a0:	f9042783          	lw	a5,-112(s0)
    15a4:	f6f42823          	sw	a5,-144(s0)
    15a8:	a861                	j	1640 <schedule_dm+0x1d4>
        }
    } else {
        // If no real-time threads with a deadline are ready, find the thread with the smallest ID
        struct thread *smallest_id_thread = NULL;
    15aa:	fa043823          	sd	zero,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    15ae:	649c                	ld	a5,8(s1)
    15b0:	639c                	ld	a5,0(a5)
    15b2:	faf43023          	sd	a5,-96(s0)
    15b6:	fa043783          	ld	a5,-96(s0)
    15ba:	fd878793          	addi	a5,a5,-40
    15be:	fcf43023          	sd	a5,-64(s0)
    15c2:	a81d                	j	15f8 <schedule_dm+0x18c>
            if (smallest_id_thread == NULL || t->ID < smallest_id_thread->ID) {
    15c4:	fb043783          	ld	a5,-80(s0)
    15c8:	cb89                	beqz	a5,15da <schedule_dm+0x16e>
    15ca:	fc043783          	ld	a5,-64(s0)
    15ce:	5fd8                	lw	a4,60(a5)
    15d0:	fb043783          	ld	a5,-80(s0)
    15d4:	5fdc                	lw	a5,60(a5)
    15d6:	00f75663          	bge	a4,a5,15e2 <schedule_dm+0x176>
                smallest_id_thread = t;
    15da:	fc043783          	ld	a5,-64(s0)
    15de:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    15e2:	fc043783          	ld	a5,-64(s0)
    15e6:	779c                	ld	a5,40(a5)
    15e8:	f8f43c23          	sd	a5,-104(s0)
    15ec:	f9843783          	ld	a5,-104(s0)
    15f0:	fd878793          	addi	a5,a5,-40
    15f4:	fcf43023          	sd	a5,-64(s0)
    15f8:	fc043783          	ld	a5,-64(s0)
    15fc:	02878713          	addi	a4,a5,40
    1600:	649c                	ld	a5,8(s1)
    1602:	fcf711e3          	bne	a4,a5,15c4 <schedule_dm+0x158>
            }
        }

        if (smallest_id_thread) {
    1606:	fb043783          	ld	a5,-80(s0)
    160a:	cf89                	beqz	a5,1624 <schedule_dm+0x1b8>
            r.scheduled_thread_list_member = &smallest_id_thread->thread_list;
    160c:	fb043783          	ld	a5,-80(s0)
    1610:	02878793          	addi	a5,a5,40
    1614:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = smallest_id_thread->remaining_time;
    1618:	fb043783          	ld	a5,-80(s0)
    161c:	4fbc                	lw	a5,88(a5)
    161e:	f6f42823          	sw	a5,-144(s0)
    1622:	a839                	j	1640 <schedule_dm+0x1d4>
        } else {
            // If no thread is ready, perhaps idle or find the next release time
            r.scheduled_thread_list_member = args.run_queue;
    1624:	649c                	ld	a5,8(s1)
    1626:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    162a:	689c                	ld	a5,16(s1)
    162c:	4098                	lw	a4,0(s1)
    162e:	85ba                	mv	a1,a4
    1630:	853e                	mv	a0,a5
    1632:	00000097          	auipc	ra,0x0
    1636:	9fe080e7          	jalr	-1538(ra) # 1030 <find_next_release_time>
    163a:	87aa                	mv	a5,a0
    163c:	f6f42823          	sw	a5,-144(s0)
        }
    }

    return r;
    1640:	f6843783          	ld	a5,-152(s0)
    1644:	f6f43c23          	sd	a5,-136(s0)
    1648:	f7043783          	ld	a5,-144(s0)
    164c:	f8f43023          	sd	a5,-128(s0)
    1650:	4701                	li	a4,0
    1652:	f7843703          	ld	a4,-136(s0)
    1656:	4781                	li	a5,0
    1658:	f8043783          	ld	a5,-128(s0)
    165c:	893a                	mv	s2,a4
    165e:	89be                	mv	s3,a5
    1660:	874a                	mv	a4,s2
    1662:	87ce                	mv	a5,s3
}
    1664:	853a                	mv	a0,a4
    1666:	85be                	mv	a1,a5
    1668:	60ea                	ld	ra,152(sp)
    166a:	644a                	ld	s0,144(sp)
    166c:	64aa                	ld	s1,136(sp)
    166e:	690a                	ld	s2,128(sp)
    1670:	79e6                	ld	s3,120(sp)
    1672:	610d                	addi	sp,sp,160
    1674:	8082                	ret
