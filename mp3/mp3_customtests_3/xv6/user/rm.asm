
user/_rm:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
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
    fprintf(2, "Usage: rm files...\n");
      20:	00002597          	auipc	a1,0x2
      24:	a5858593          	addi	a1,a1,-1448 # 1a78 <schedule_dm+0x1f8>
      28:	4509                	li	a0,2
      2a:	00001097          	auipc	ra,0x1
      2e:	9fe080e7          	jalr	-1538(ra) # a28 <fprintf>
    exit(1);
      32:	4505                	li	a0,1
      34:	00000097          	auipc	ra,0x0
      38:	506080e7          	jalr	1286(ra) # 53a <exit>
  }

  for(i = 1; i < argc; i++){
      3c:	4785                	li	a5,1
      3e:	fef42623          	sw	a5,-20(s0)
      42:	a0b9                	j	90 <main+0x90>
    if(unlink(argv[i]) < 0){
      44:	fec42783          	lw	a5,-20(s0)
      48:	078e                	slli	a5,a5,0x3
      4a:	fd043703          	ld	a4,-48(s0)
      4e:	97ba                	add	a5,a5,a4
      50:	639c                	ld	a5,0(a5)
      52:	853e                	mv	a0,a5
      54:	00000097          	auipc	ra,0x0
      58:	536080e7          	jalr	1334(ra) # 58a <unlink>
      5c:	87aa                	mv	a5,a0
      5e:	0207d463          	bgez	a5,86 <main+0x86>
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
      62:	fec42783          	lw	a5,-20(s0)
      66:	078e                	slli	a5,a5,0x3
      68:	fd043703          	ld	a4,-48(s0)
      6c:	97ba                	add	a5,a5,a4
      6e:	639c                	ld	a5,0(a5)
      70:	863e                	mv	a2,a5
      72:	00002597          	auipc	a1,0x2
      76:	a1e58593          	addi	a1,a1,-1506 # 1a90 <schedule_dm+0x210>
      7a:	4509                	li	a0,2
      7c:	00001097          	auipc	ra,0x1
      80:	9ac080e7          	jalr	-1620(ra) # a28 <fprintf>
      break;
      84:	a831                	j	a0 <main+0xa0>
  for(i = 1; i < argc; i++){
      86:	fec42783          	lw	a5,-20(s0)
      8a:	2785                	addiw	a5,a5,1
      8c:	fef42623          	sw	a5,-20(s0)
      90:	fec42703          	lw	a4,-20(s0)
      94:	fdc42783          	lw	a5,-36(s0)
      98:	2701                	sext.w	a4,a4
      9a:	2781                	sext.w	a5,a5
      9c:	faf744e3          	blt	a4,a5,44 <main+0x44>
    }
  }

  exit(0);
      a0:	4501                	li	a0,0
      a2:	00000097          	auipc	ra,0x0
      a6:	498080e7          	jalr	1176(ra) # 53a <exit>

00000000000000aa <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
      aa:	7179                	addi	sp,sp,-48
      ac:	f422                	sd	s0,40(sp)
      ae:	1800                	addi	s0,sp,48
      b0:	fca43c23          	sd	a0,-40(s0)
      b4:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
      b8:	fd843783          	ld	a5,-40(s0)
      bc:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
      c0:	0001                	nop
      c2:	fd043703          	ld	a4,-48(s0)
      c6:	00170793          	addi	a5,a4,1
      ca:	fcf43823          	sd	a5,-48(s0)
      ce:	fd843783          	ld	a5,-40(s0)
      d2:	00178693          	addi	a3,a5,1
      d6:	fcd43c23          	sd	a3,-40(s0)
      da:	00074703          	lbu	a4,0(a4)
      de:	00e78023          	sb	a4,0(a5)
      e2:	0007c783          	lbu	a5,0(a5)
      e6:	fff1                	bnez	a5,c2 <strcpy+0x18>
    ;
  return os;
      e8:	fe843783          	ld	a5,-24(s0)
}
      ec:	853e                	mv	a0,a5
      ee:	7422                	ld	s0,40(sp)
      f0:	6145                	addi	sp,sp,48
      f2:	8082                	ret

00000000000000f4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      f4:	1101                	addi	sp,sp,-32
      f6:	ec22                	sd	s0,24(sp)
      f8:	1000                	addi	s0,sp,32
      fa:	fea43423          	sd	a0,-24(s0)
      fe:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     102:	a819                	j	118 <strcmp+0x24>
    p++, q++;
     104:	fe843783          	ld	a5,-24(s0)
     108:	0785                	addi	a5,a5,1
     10a:	fef43423          	sd	a5,-24(s0)
     10e:	fe043783          	ld	a5,-32(s0)
     112:	0785                	addi	a5,a5,1
     114:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     118:	fe843783          	ld	a5,-24(s0)
     11c:	0007c783          	lbu	a5,0(a5)
     120:	cb99                	beqz	a5,136 <strcmp+0x42>
     122:	fe843783          	ld	a5,-24(s0)
     126:	0007c703          	lbu	a4,0(a5)
     12a:	fe043783          	ld	a5,-32(s0)
     12e:	0007c783          	lbu	a5,0(a5)
     132:	fcf709e3          	beq	a4,a5,104 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     136:	fe843783          	ld	a5,-24(s0)
     13a:	0007c783          	lbu	a5,0(a5)
     13e:	0007871b          	sext.w	a4,a5
     142:	fe043783          	ld	a5,-32(s0)
     146:	0007c783          	lbu	a5,0(a5)
     14a:	2781                	sext.w	a5,a5
     14c:	40f707bb          	subw	a5,a4,a5
     150:	2781                	sext.w	a5,a5
}
     152:	853e                	mv	a0,a5
     154:	6462                	ld	s0,24(sp)
     156:	6105                	addi	sp,sp,32
     158:	8082                	ret

000000000000015a <strlen>:

uint
strlen(const char *s)
{
     15a:	7179                	addi	sp,sp,-48
     15c:	f422                	sd	s0,40(sp)
     15e:	1800                	addi	s0,sp,48
     160:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     164:	fe042623          	sw	zero,-20(s0)
     168:	a031                	j	174 <strlen+0x1a>
     16a:	fec42783          	lw	a5,-20(s0)
     16e:	2785                	addiw	a5,a5,1
     170:	fef42623          	sw	a5,-20(s0)
     174:	fec42783          	lw	a5,-20(s0)
     178:	fd843703          	ld	a4,-40(s0)
     17c:	97ba                	add	a5,a5,a4
     17e:	0007c783          	lbu	a5,0(a5)
     182:	f7e5                	bnez	a5,16a <strlen+0x10>
    ;
  return n;
     184:	fec42783          	lw	a5,-20(s0)
}
     188:	853e                	mv	a0,a5
     18a:	7422                	ld	s0,40(sp)
     18c:	6145                	addi	sp,sp,48
     18e:	8082                	ret

0000000000000190 <memset>:

void*
memset(void *dst, int c, uint n)
{
     190:	7179                	addi	sp,sp,-48
     192:	f422                	sd	s0,40(sp)
     194:	1800                	addi	s0,sp,48
     196:	fca43c23          	sd	a0,-40(s0)
     19a:	87ae                	mv	a5,a1
     19c:	8732                	mv	a4,a2
     19e:	fcf42a23          	sw	a5,-44(s0)
     1a2:	87ba                	mv	a5,a4
     1a4:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     1a8:	fd843783          	ld	a5,-40(s0)
     1ac:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     1b0:	fe042623          	sw	zero,-20(s0)
     1b4:	a00d                	j	1d6 <memset+0x46>
    cdst[i] = c;
     1b6:	fec42783          	lw	a5,-20(s0)
     1ba:	fe043703          	ld	a4,-32(s0)
     1be:	97ba                	add	a5,a5,a4
     1c0:	fd442703          	lw	a4,-44(s0)
     1c4:	0ff77713          	andi	a4,a4,255
     1c8:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     1cc:	fec42783          	lw	a5,-20(s0)
     1d0:	2785                	addiw	a5,a5,1
     1d2:	fef42623          	sw	a5,-20(s0)
     1d6:	fec42703          	lw	a4,-20(s0)
     1da:	fd042783          	lw	a5,-48(s0)
     1de:	2781                	sext.w	a5,a5
     1e0:	fcf76be3          	bltu	a4,a5,1b6 <memset+0x26>
  }
  return dst;
     1e4:	fd843783          	ld	a5,-40(s0)
}
     1e8:	853e                	mv	a0,a5
     1ea:	7422                	ld	s0,40(sp)
     1ec:	6145                	addi	sp,sp,48
     1ee:	8082                	ret

00000000000001f0 <strchr>:

char*
strchr(const char *s, char c)
{
     1f0:	1101                	addi	sp,sp,-32
     1f2:	ec22                	sd	s0,24(sp)
     1f4:	1000                	addi	s0,sp,32
     1f6:	fea43423          	sd	a0,-24(s0)
     1fa:	87ae                	mv	a5,a1
     1fc:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     200:	a01d                	j	226 <strchr+0x36>
    if(*s == c)
     202:	fe843783          	ld	a5,-24(s0)
     206:	0007c703          	lbu	a4,0(a5)
     20a:	fe744783          	lbu	a5,-25(s0)
     20e:	0ff7f793          	andi	a5,a5,255
     212:	00e79563          	bne	a5,a4,21c <strchr+0x2c>
      return (char*)s;
     216:	fe843783          	ld	a5,-24(s0)
     21a:	a821                	j	232 <strchr+0x42>
  for(; *s; s++)
     21c:	fe843783          	ld	a5,-24(s0)
     220:	0785                	addi	a5,a5,1
     222:	fef43423          	sd	a5,-24(s0)
     226:	fe843783          	ld	a5,-24(s0)
     22a:	0007c783          	lbu	a5,0(a5)
     22e:	fbf1                	bnez	a5,202 <strchr+0x12>
  return 0;
     230:	4781                	li	a5,0
}
     232:	853e                	mv	a0,a5
     234:	6462                	ld	s0,24(sp)
     236:	6105                	addi	sp,sp,32
     238:	8082                	ret

000000000000023a <gets>:

char*
gets(char *buf, int max)
{
     23a:	7179                	addi	sp,sp,-48
     23c:	f406                	sd	ra,40(sp)
     23e:	f022                	sd	s0,32(sp)
     240:	1800                	addi	s0,sp,48
     242:	fca43c23          	sd	a0,-40(s0)
     246:	87ae                	mv	a5,a1
     248:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     24c:	fe042623          	sw	zero,-20(s0)
     250:	a8a1                	j	2a8 <gets+0x6e>
    cc = read(0, &c, 1);
     252:	fe740793          	addi	a5,s0,-25
     256:	4605                	li	a2,1
     258:	85be                	mv	a1,a5
     25a:	4501                	li	a0,0
     25c:	00000097          	auipc	ra,0x0
     260:	2f6080e7          	jalr	758(ra) # 552 <read>
     264:	87aa                	mv	a5,a0
     266:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     26a:	fe842783          	lw	a5,-24(s0)
     26e:	2781                	sext.w	a5,a5
     270:	04f05763          	blez	a5,2be <gets+0x84>
      break;
    buf[i++] = c;
     274:	fec42783          	lw	a5,-20(s0)
     278:	0017871b          	addiw	a4,a5,1
     27c:	fee42623          	sw	a4,-20(s0)
     280:	873e                	mv	a4,a5
     282:	fd843783          	ld	a5,-40(s0)
     286:	97ba                	add	a5,a5,a4
     288:	fe744703          	lbu	a4,-25(s0)
     28c:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     290:	fe744783          	lbu	a5,-25(s0)
     294:	873e                	mv	a4,a5
     296:	47a9                	li	a5,10
     298:	02f70463          	beq	a4,a5,2c0 <gets+0x86>
     29c:	fe744783          	lbu	a5,-25(s0)
     2a0:	873e                	mv	a4,a5
     2a2:	47b5                	li	a5,13
     2a4:	00f70e63          	beq	a4,a5,2c0 <gets+0x86>
  for(i=0; i+1 < max; ){
     2a8:	fec42783          	lw	a5,-20(s0)
     2ac:	2785                	addiw	a5,a5,1
     2ae:	0007871b          	sext.w	a4,a5
     2b2:	fd442783          	lw	a5,-44(s0)
     2b6:	2781                	sext.w	a5,a5
     2b8:	f8f74de3          	blt	a4,a5,252 <gets+0x18>
     2bc:	a011                	j	2c0 <gets+0x86>
      break;
     2be:	0001                	nop
      break;
  }
  buf[i] = '\0';
     2c0:	fec42783          	lw	a5,-20(s0)
     2c4:	fd843703          	ld	a4,-40(s0)
     2c8:	97ba                	add	a5,a5,a4
     2ca:	00078023          	sb	zero,0(a5)
  return buf;
     2ce:	fd843783          	ld	a5,-40(s0)
}
     2d2:	853e                	mv	a0,a5
     2d4:	70a2                	ld	ra,40(sp)
     2d6:	7402                	ld	s0,32(sp)
     2d8:	6145                	addi	sp,sp,48
     2da:	8082                	ret

00000000000002dc <stat>:

int
stat(const char *n, struct stat *st)
{
     2dc:	7179                	addi	sp,sp,-48
     2de:	f406                	sd	ra,40(sp)
     2e0:	f022                	sd	s0,32(sp)
     2e2:	1800                	addi	s0,sp,48
     2e4:	fca43c23          	sd	a0,-40(s0)
     2e8:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     2ec:	4581                	li	a1,0
     2ee:	fd843503          	ld	a0,-40(s0)
     2f2:	00000097          	auipc	ra,0x0
     2f6:	288080e7          	jalr	648(ra) # 57a <open>
     2fa:	87aa                	mv	a5,a0
     2fc:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     300:	fec42783          	lw	a5,-20(s0)
     304:	2781                	sext.w	a5,a5
     306:	0007d463          	bgez	a5,30e <stat+0x32>
    return -1;
     30a:	57fd                	li	a5,-1
     30c:	a035                	j	338 <stat+0x5c>
  r = fstat(fd, st);
     30e:	fec42783          	lw	a5,-20(s0)
     312:	fd043583          	ld	a1,-48(s0)
     316:	853e                	mv	a0,a5
     318:	00000097          	auipc	ra,0x0
     31c:	27a080e7          	jalr	634(ra) # 592 <fstat>
     320:	87aa                	mv	a5,a0
     322:	fef42423          	sw	a5,-24(s0)
  close(fd);
     326:	fec42783          	lw	a5,-20(s0)
     32a:	853e                	mv	a0,a5
     32c:	00000097          	auipc	ra,0x0
     330:	236080e7          	jalr	566(ra) # 562 <close>
  return r;
     334:	fe842783          	lw	a5,-24(s0)
}
     338:	853e                	mv	a0,a5
     33a:	70a2                	ld	ra,40(sp)
     33c:	7402                	ld	s0,32(sp)
     33e:	6145                	addi	sp,sp,48
     340:	8082                	ret

0000000000000342 <atoi>:

int
atoi(const char *s)
{
     342:	7179                	addi	sp,sp,-48
     344:	f422                	sd	s0,40(sp)
     346:	1800                	addi	s0,sp,48
     348:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     34c:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     350:	a815                	j	384 <atoi+0x42>
    n = n*10 + *s++ - '0';
     352:	fec42703          	lw	a4,-20(s0)
     356:	87ba                	mv	a5,a4
     358:	0027979b          	slliw	a5,a5,0x2
     35c:	9fb9                	addw	a5,a5,a4
     35e:	0017979b          	slliw	a5,a5,0x1
     362:	0007871b          	sext.w	a4,a5
     366:	fd843783          	ld	a5,-40(s0)
     36a:	00178693          	addi	a3,a5,1
     36e:	fcd43c23          	sd	a3,-40(s0)
     372:	0007c783          	lbu	a5,0(a5)
     376:	2781                	sext.w	a5,a5
     378:	9fb9                	addw	a5,a5,a4
     37a:	2781                	sext.w	a5,a5
     37c:	fd07879b          	addiw	a5,a5,-48
     380:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     384:	fd843783          	ld	a5,-40(s0)
     388:	0007c783          	lbu	a5,0(a5)
     38c:	873e                	mv	a4,a5
     38e:	02f00793          	li	a5,47
     392:	00e7fb63          	bgeu	a5,a4,3a8 <atoi+0x66>
     396:	fd843783          	ld	a5,-40(s0)
     39a:	0007c783          	lbu	a5,0(a5)
     39e:	873e                	mv	a4,a5
     3a0:	03900793          	li	a5,57
     3a4:	fae7f7e3          	bgeu	a5,a4,352 <atoi+0x10>
  return n;
     3a8:	fec42783          	lw	a5,-20(s0)
}
     3ac:	853e                	mv	a0,a5
     3ae:	7422                	ld	s0,40(sp)
     3b0:	6145                	addi	sp,sp,48
     3b2:	8082                	ret

00000000000003b4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     3b4:	7139                	addi	sp,sp,-64
     3b6:	fc22                	sd	s0,56(sp)
     3b8:	0080                	addi	s0,sp,64
     3ba:	fca43c23          	sd	a0,-40(s0)
     3be:	fcb43823          	sd	a1,-48(s0)
     3c2:	87b2                	mv	a5,a2
     3c4:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     3c8:	fd843783          	ld	a5,-40(s0)
     3cc:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     3d0:	fd043783          	ld	a5,-48(s0)
     3d4:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     3d8:	fe043703          	ld	a4,-32(s0)
     3dc:	fe843783          	ld	a5,-24(s0)
     3e0:	02e7fc63          	bgeu	a5,a4,418 <memmove+0x64>
    while(n-- > 0)
     3e4:	a00d                	j	406 <memmove+0x52>
      *dst++ = *src++;
     3e6:	fe043703          	ld	a4,-32(s0)
     3ea:	00170793          	addi	a5,a4,1
     3ee:	fef43023          	sd	a5,-32(s0)
     3f2:	fe843783          	ld	a5,-24(s0)
     3f6:	00178693          	addi	a3,a5,1
     3fa:	fed43423          	sd	a3,-24(s0)
     3fe:	00074703          	lbu	a4,0(a4)
     402:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     406:	fcc42783          	lw	a5,-52(s0)
     40a:	fff7871b          	addiw	a4,a5,-1
     40e:	fce42623          	sw	a4,-52(s0)
     412:	fcf04ae3          	bgtz	a5,3e6 <memmove+0x32>
     416:	a891                	j	46a <memmove+0xb6>
  } else {
    dst += n;
     418:	fcc42783          	lw	a5,-52(s0)
     41c:	fe843703          	ld	a4,-24(s0)
     420:	97ba                	add	a5,a5,a4
     422:	fef43423          	sd	a5,-24(s0)
    src += n;
     426:	fcc42783          	lw	a5,-52(s0)
     42a:	fe043703          	ld	a4,-32(s0)
     42e:	97ba                	add	a5,a5,a4
     430:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     434:	a01d                	j	45a <memmove+0xa6>
      *--dst = *--src;
     436:	fe043783          	ld	a5,-32(s0)
     43a:	17fd                	addi	a5,a5,-1
     43c:	fef43023          	sd	a5,-32(s0)
     440:	fe843783          	ld	a5,-24(s0)
     444:	17fd                	addi	a5,a5,-1
     446:	fef43423          	sd	a5,-24(s0)
     44a:	fe043783          	ld	a5,-32(s0)
     44e:	0007c703          	lbu	a4,0(a5)
     452:	fe843783          	ld	a5,-24(s0)
     456:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     45a:	fcc42783          	lw	a5,-52(s0)
     45e:	fff7871b          	addiw	a4,a5,-1
     462:	fce42623          	sw	a4,-52(s0)
     466:	fcf048e3          	bgtz	a5,436 <memmove+0x82>
  }
  return vdst;
     46a:	fd843783          	ld	a5,-40(s0)
}
     46e:	853e                	mv	a0,a5
     470:	7462                	ld	s0,56(sp)
     472:	6121                	addi	sp,sp,64
     474:	8082                	ret

0000000000000476 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     476:	7139                	addi	sp,sp,-64
     478:	fc22                	sd	s0,56(sp)
     47a:	0080                	addi	s0,sp,64
     47c:	fca43c23          	sd	a0,-40(s0)
     480:	fcb43823          	sd	a1,-48(s0)
     484:	87b2                	mv	a5,a2
     486:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     48a:	fd843783          	ld	a5,-40(s0)
     48e:	fef43423          	sd	a5,-24(s0)
     492:	fd043783          	ld	a5,-48(s0)
     496:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     49a:	a0a1                	j	4e2 <memcmp+0x6c>
    if (*p1 != *p2) {
     49c:	fe843783          	ld	a5,-24(s0)
     4a0:	0007c703          	lbu	a4,0(a5)
     4a4:	fe043783          	ld	a5,-32(s0)
     4a8:	0007c783          	lbu	a5,0(a5)
     4ac:	02f70163          	beq	a4,a5,4ce <memcmp+0x58>
      return *p1 - *p2;
     4b0:	fe843783          	ld	a5,-24(s0)
     4b4:	0007c783          	lbu	a5,0(a5)
     4b8:	0007871b          	sext.w	a4,a5
     4bc:	fe043783          	ld	a5,-32(s0)
     4c0:	0007c783          	lbu	a5,0(a5)
     4c4:	2781                	sext.w	a5,a5
     4c6:	40f707bb          	subw	a5,a4,a5
     4ca:	2781                	sext.w	a5,a5
     4cc:	a01d                	j	4f2 <memcmp+0x7c>
    }
    p1++;
     4ce:	fe843783          	ld	a5,-24(s0)
     4d2:	0785                	addi	a5,a5,1
     4d4:	fef43423          	sd	a5,-24(s0)
    p2++;
     4d8:	fe043783          	ld	a5,-32(s0)
     4dc:	0785                	addi	a5,a5,1
     4de:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     4e2:	fcc42783          	lw	a5,-52(s0)
     4e6:	fff7871b          	addiw	a4,a5,-1
     4ea:	fce42623          	sw	a4,-52(s0)
     4ee:	f7dd                	bnez	a5,49c <memcmp+0x26>
  }
  return 0;
     4f0:	4781                	li	a5,0
}
     4f2:	853e                	mv	a0,a5
     4f4:	7462                	ld	s0,56(sp)
     4f6:	6121                	addi	sp,sp,64
     4f8:	8082                	ret

00000000000004fa <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     4fa:	7179                	addi	sp,sp,-48
     4fc:	f406                	sd	ra,40(sp)
     4fe:	f022                	sd	s0,32(sp)
     500:	1800                	addi	s0,sp,48
     502:	fea43423          	sd	a0,-24(s0)
     506:	feb43023          	sd	a1,-32(s0)
     50a:	87b2                	mv	a5,a2
     50c:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     510:	fdc42783          	lw	a5,-36(s0)
     514:	863e                	mv	a2,a5
     516:	fe043583          	ld	a1,-32(s0)
     51a:	fe843503          	ld	a0,-24(s0)
     51e:	00000097          	auipc	ra,0x0
     522:	e96080e7          	jalr	-362(ra) # 3b4 <memmove>
     526:	87aa                	mv	a5,a0
}
     528:	853e                	mv	a0,a5
     52a:	70a2                	ld	ra,40(sp)
     52c:	7402                	ld	s0,32(sp)
     52e:	6145                	addi	sp,sp,48
     530:	8082                	ret

0000000000000532 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     532:	4885                	li	a7,1
 ecall
     534:	00000073          	ecall
 ret
     538:	8082                	ret

000000000000053a <exit>:
.global exit
exit:
 li a7, SYS_exit
     53a:	4889                	li	a7,2
 ecall
     53c:	00000073          	ecall
 ret
     540:	8082                	ret

0000000000000542 <wait>:
.global wait
wait:
 li a7, SYS_wait
     542:	488d                	li	a7,3
 ecall
     544:	00000073          	ecall
 ret
     548:	8082                	ret

000000000000054a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     54a:	4891                	li	a7,4
 ecall
     54c:	00000073          	ecall
 ret
     550:	8082                	ret

0000000000000552 <read>:
.global read
read:
 li a7, SYS_read
     552:	4895                	li	a7,5
 ecall
     554:	00000073          	ecall
 ret
     558:	8082                	ret

000000000000055a <write>:
.global write
write:
 li a7, SYS_write
     55a:	48c1                	li	a7,16
 ecall
     55c:	00000073          	ecall
 ret
     560:	8082                	ret

0000000000000562 <close>:
.global close
close:
 li a7, SYS_close
     562:	48d5                	li	a7,21
 ecall
     564:	00000073          	ecall
 ret
     568:	8082                	ret

000000000000056a <kill>:
.global kill
kill:
 li a7, SYS_kill
     56a:	4899                	li	a7,6
 ecall
     56c:	00000073          	ecall
 ret
     570:	8082                	ret

0000000000000572 <exec>:
.global exec
exec:
 li a7, SYS_exec
     572:	489d                	li	a7,7
 ecall
     574:	00000073          	ecall
 ret
     578:	8082                	ret

000000000000057a <open>:
.global open
open:
 li a7, SYS_open
     57a:	48bd                	li	a7,15
 ecall
     57c:	00000073          	ecall
 ret
     580:	8082                	ret

0000000000000582 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     582:	48c5                	li	a7,17
 ecall
     584:	00000073          	ecall
 ret
     588:	8082                	ret

000000000000058a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     58a:	48c9                	li	a7,18
 ecall
     58c:	00000073          	ecall
 ret
     590:	8082                	ret

0000000000000592 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     592:	48a1                	li	a7,8
 ecall
     594:	00000073          	ecall
 ret
     598:	8082                	ret

000000000000059a <link>:
.global link
link:
 li a7, SYS_link
     59a:	48cd                	li	a7,19
 ecall
     59c:	00000073          	ecall
 ret
     5a0:	8082                	ret

00000000000005a2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     5a2:	48d1                	li	a7,20
 ecall
     5a4:	00000073          	ecall
 ret
     5a8:	8082                	ret

00000000000005aa <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     5aa:	48a5                	li	a7,9
 ecall
     5ac:	00000073          	ecall
 ret
     5b0:	8082                	ret

00000000000005b2 <dup>:
.global dup
dup:
 li a7, SYS_dup
     5b2:	48a9                	li	a7,10
 ecall
     5b4:	00000073          	ecall
 ret
     5b8:	8082                	ret

00000000000005ba <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     5ba:	48ad                	li	a7,11
 ecall
     5bc:	00000073          	ecall
 ret
     5c0:	8082                	ret

00000000000005c2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     5c2:	48b1                	li	a7,12
 ecall
     5c4:	00000073          	ecall
 ret
     5c8:	8082                	ret

00000000000005ca <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     5ca:	48b5                	li	a7,13
 ecall
     5cc:	00000073          	ecall
 ret
     5d0:	8082                	ret

00000000000005d2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     5d2:	48b9                	li	a7,14
 ecall
     5d4:	00000073          	ecall
 ret
     5d8:	8082                	ret

00000000000005da <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     5da:	48d9                	li	a7,22
 ecall
     5dc:	00000073          	ecall
 ret
     5e0:	8082                	ret

00000000000005e2 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     5e2:	48dd                	li	a7,23
 ecall
     5e4:	00000073          	ecall
 ret
     5e8:	8082                	ret

00000000000005ea <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     5ea:	48e1                	li	a7,24
 ecall
     5ec:	00000073          	ecall
 ret
     5f0:	8082                	ret

00000000000005f2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     5f2:	1101                	addi	sp,sp,-32
     5f4:	ec06                	sd	ra,24(sp)
     5f6:	e822                	sd	s0,16(sp)
     5f8:	1000                	addi	s0,sp,32
     5fa:	87aa                	mv	a5,a0
     5fc:	872e                	mv	a4,a1
     5fe:	fef42623          	sw	a5,-20(s0)
     602:	87ba                	mv	a5,a4
     604:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     608:	feb40713          	addi	a4,s0,-21
     60c:	fec42783          	lw	a5,-20(s0)
     610:	4605                	li	a2,1
     612:	85ba                	mv	a1,a4
     614:	853e                	mv	a0,a5
     616:	00000097          	auipc	ra,0x0
     61a:	f44080e7          	jalr	-188(ra) # 55a <write>
}
     61e:	0001                	nop
     620:	60e2                	ld	ra,24(sp)
     622:	6442                	ld	s0,16(sp)
     624:	6105                	addi	sp,sp,32
     626:	8082                	ret

0000000000000628 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     628:	7139                	addi	sp,sp,-64
     62a:	fc06                	sd	ra,56(sp)
     62c:	f822                	sd	s0,48(sp)
     62e:	0080                	addi	s0,sp,64
     630:	87aa                	mv	a5,a0
     632:	8736                	mv	a4,a3
     634:	fcf42623          	sw	a5,-52(s0)
     638:	87ae                	mv	a5,a1
     63a:	fcf42423          	sw	a5,-56(s0)
     63e:	87b2                	mv	a5,a2
     640:	fcf42223          	sw	a5,-60(s0)
     644:	87ba                	mv	a5,a4
     646:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     64a:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     64e:	fc042783          	lw	a5,-64(s0)
     652:	2781                	sext.w	a5,a5
     654:	c38d                	beqz	a5,676 <printint+0x4e>
     656:	fc842783          	lw	a5,-56(s0)
     65a:	2781                	sext.w	a5,a5
     65c:	0007dd63          	bgez	a5,676 <printint+0x4e>
    neg = 1;
     660:	4785                	li	a5,1
     662:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     666:	fc842783          	lw	a5,-56(s0)
     66a:	40f007bb          	negw	a5,a5
     66e:	2781                	sext.w	a5,a5
     670:	fef42223          	sw	a5,-28(s0)
     674:	a029                	j	67e <printint+0x56>
  } else {
    x = xx;
     676:	fc842783          	lw	a5,-56(s0)
     67a:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     67e:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     682:	fc442783          	lw	a5,-60(s0)
     686:	fe442703          	lw	a4,-28(s0)
     68a:	02f777bb          	remuw	a5,a4,a5
     68e:	0007861b          	sext.w	a2,a5
     692:	fec42783          	lw	a5,-20(s0)
     696:	0017871b          	addiw	a4,a5,1
     69a:	fee42623          	sw	a4,-20(s0)
     69e:	00001697          	auipc	a3,0x1
     6a2:	41a68693          	addi	a3,a3,1050 # 1ab8 <digits>
     6a6:	02061713          	slli	a4,a2,0x20
     6aa:	9301                	srli	a4,a4,0x20
     6ac:	9736                	add	a4,a4,a3
     6ae:	00074703          	lbu	a4,0(a4)
     6b2:	ff040693          	addi	a3,s0,-16
     6b6:	97b6                	add	a5,a5,a3
     6b8:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     6bc:	fc442783          	lw	a5,-60(s0)
     6c0:	fe442703          	lw	a4,-28(s0)
     6c4:	02f757bb          	divuw	a5,a4,a5
     6c8:	fef42223          	sw	a5,-28(s0)
     6cc:	fe442783          	lw	a5,-28(s0)
     6d0:	2781                	sext.w	a5,a5
     6d2:	fbc5                	bnez	a5,682 <printint+0x5a>
  if(neg)
     6d4:	fe842783          	lw	a5,-24(s0)
     6d8:	2781                	sext.w	a5,a5
     6da:	cf95                	beqz	a5,716 <printint+0xee>
    buf[i++] = '-';
     6dc:	fec42783          	lw	a5,-20(s0)
     6e0:	0017871b          	addiw	a4,a5,1
     6e4:	fee42623          	sw	a4,-20(s0)
     6e8:	ff040713          	addi	a4,s0,-16
     6ec:	97ba                	add	a5,a5,a4
     6ee:	02d00713          	li	a4,45
     6f2:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     6f6:	a005                	j	716 <printint+0xee>
    putc(fd, buf[i]);
     6f8:	fec42783          	lw	a5,-20(s0)
     6fc:	ff040713          	addi	a4,s0,-16
     700:	97ba                	add	a5,a5,a4
     702:	fe07c703          	lbu	a4,-32(a5)
     706:	fcc42783          	lw	a5,-52(s0)
     70a:	85ba                	mv	a1,a4
     70c:	853e                	mv	a0,a5
     70e:	00000097          	auipc	ra,0x0
     712:	ee4080e7          	jalr	-284(ra) # 5f2 <putc>
  while(--i >= 0)
     716:	fec42783          	lw	a5,-20(s0)
     71a:	37fd                	addiw	a5,a5,-1
     71c:	fef42623          	sw	a5,-20(s0)
     720:	fec42783          	lw	a5,-20(s0)
     724:	2781                	sext.w	a5,a5
     726:	fc07d9e3          	bgez	a5,6f8 <printint+0xd0>
}
     72a:	0001                	nop
     72c:	0001                	nop
     72e:	70e2                	ld	ra,56(sp)
     730:	7442                	ld	s0,48(sp)
     732:	6121                	addi	sp,sp,64
     734:	8082                	ret

0000000000000736 <printptr>:

static void
printptr(int fd, uint64 x) {
     736:	7179                	addi	sp,sp,-48
     738:	f406                	sd	ra,40(sp)
     73a:	f022                	sd	s0,32(sp)
     73c:	1800                	addi	s0,sp,48
     73e:	87aa                	mv	a5,a0
     740:	fcb43823          	sd	a1,-48(s0)
     744:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     748:	fdc42783          	lw	a5,-36(s0)
     74c:	03000593          	li	a1,48
     750:	853e                	mv	a0,a5
     752:	00000097          	auipc	ra,0x0
     756:	ea0080e7          	jalr	-352(ra) # 5f2 <putc>
  putc(fd, 'x');
     75a:	fdc42783          	lw	a5,-36(s0)
     75e:	07800593          	li	a1,120
     762:	853e                	mv	a0,a5
     764:	00000097          	auipc	ra,0x0
     768:	e8e080e7          	jalr	-370(ra) # 5f2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     76c:	fe042623          	sw	zero,-20(s0)
     770:	a82d                	j	7aa <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     772:	fd043783          	ld	a5,-48(s0)
     776:	93f1                	srli	a5,a5,0x3c
     778:	00001717          	auipc	a4,0x1
     77c:	34070713          	addi	a4,a4,832 # 1ab8 <digits>
     780:	97ba                	add	a5,a5,a4
     782:	0007c703          	lbu	a4,0(a5)
     786:	fdc42783          	lw	a5,-36(s0)
     78a:	85ba                	mv	a1,a4
     78c:	853e                	mv	a0,a5
     78e:	00000097          	auipc	ra,0x0
     792:	e64080e7          	jalr	-412(ra) # 5f2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     796:	fec42783          	lw	a5,-20(s0)
     79a:	2785                	addiw	a5,a5,1
     79c:	fef42623          	sw	a5,-20(s0)
     7a0:	fd043783          	ld	a5,-48(s0)
     7a4:	0792                	slli	a5,a5,0x4
     7a6:	fcf43823          	sd	a5,-48(s0)
     7aa:	fec42783          	lw	a5,-20(s0)
     7ae:	873e                	mv	a4,a5
     7b0:	47bd                	li	a5,15
     7b2:	fce7f0e3          	bgeu	a5,a4,772 <printptr+0x3c>
}
     7b6:	0001                	nop
     7b8:	0001                	nop
     7ba:	70a2                	ld	ra,40(sp)
     7bc:	7402                	ld	s0,32(sp)
     7be:	6145                	addi	sp,sp,48
     7c0:	8082                	ret

00000000000007c2 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     7c2:	715d                	addi	sp,sp,-80
     7c4:	e486                	sd	ra,72(sp)
     7c6:	e0a2                	sd	s0,64(sp)
     7c8:	0880                	addi	s0,sp,80
     7ca:	87aa                	mv	a5,a0
     7cc:	fcb43023          	sd	a1,-64(s0)
     7d0:	fac43c23          	sd	a2,-72(s0)
     7d4:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     7d8:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     7dc:	fe042223          	sw	zero,-28(s0)
     7e0:	a42d                	j	a0a <vprintf+0x248>
    c = fmt[i] & 0xff;
     7e2:	fe442783          	lw	a5,-28(s0)
     7e6:	fc043703          	ld	a4,-64(s0)
     7ea:	97ba                	add	a5,a5,a4
     7ec:	0007c783          	lbu	a5,0(a5)
     7f0:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     7f4:	fe042783          	lw	a5,-32(s0)
     7f8:	2781                	sext.w	a5,a5
     7fa:	eb9d                	bnez	a5,830 <vprintf+0x6e>
      if(c == '%'){
     7fc:	fdc42783          	lw	a5,-36(s0)
     800:	0007871b          	sext.w	a4,a5
     804:	02500793          	li	a5,37
     808:	00f71763          	bne	a4,a5,816 <vprintf+0x54>
        state = '%';
     80c:	02500793          	li	a5,37
     810:	fef42023          	sw	a5,-32(s0)
     814:	a2f5                	j	a00 <vprintf+0x23e>
      } else {
        putc(fd, c);
     816:	fdc42783          	lw	a5,-36(s0)
     81a:	0ff7f713          	andi	a4,a5,255
     81e:	fcc42783          	lw	a5,-52(s0)
     822:	85ba                	mv	a1,a4
     824:	853e                	mv	a0,a5
     826:	00000097          	auipc	ra,0x0
     82a:	dcc080e7          	jalr	-564(ra) # 5f2 <putc>
     82e:	aac9                	j	a00 <vprintf+0x23e>
      }
    } else if(state == '%'){
     830:	fe042783          	lw	a5,-32(s0)
     834:	0007871b          	sext.w	a4,a5
     838:	02500793          	li	a5,37
     83c:	1cf71263          	bne	a4,a5,a00 <vprintf+0x23e>
      if(c == 'd'){
     840:	fdc42783          	lw	a5,-36(s0)
     844:	0007871b          	sext.w	a4,a5
     848:	06400793          	li	a5,100
     84c:	02f71463          	bne	a4,a5,874 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     850:	fb843783          	ld	a5,-72(s0)
     854:	00878713          	addi	a4,a5,8
     858:	fae43c23          	sd	a4,-72(s0)
     85c:	4398                	lw	a4,0(a5)
     85e:	fcc42783          	lw	a5,-52(s0)
     862:	4685                	li	a3,1
     864:	4629                	li	a2,10
     866:	85ba                	mv	a1,a4
     868:	853e                	mv	a0,a5
     86a:	00000097          	auipc	ra,0x0
     86e:	dbe080e7          	jalr	-578(ra) # 628 <printint>
     872:	a269                	j	9fc <vprintf+0x23a>
      } else if(c == 'l') {
     874:	fdc42783          	lw	a5,-36(s0)
     878:	0007871b          	sext.w	a4,a5
     87c:	06c00793          	li	a5,108
     880:	02f71663          	bne	a4,a5,8ac <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     884:	fb843783          	ld	a5,-72(s0)
     888:	00878713          	addi	a4,a5,8
     88c:	fae43c23          	sd	a4,-72(s0)
     890:	639c                	ld	a5,0(a5)
     892:	0007871b          	sext.w	a4,a5
     896:	fcc42783          	lw	a5,-52(s0)
     89a:	4681                	li	a3,0
     89c:	4629                	li	a2,10
     89e:	85ba                	mv	a1,a4
     8a0:	853e                	mv	a0,a5
     8a2:	00000097          	auipc	ra,0x0
     8a6:	d86080e7          	jalr	-634(ra) # 628 <printint>
     8aa:	aa89                	j	9fc <vprintf+0x23a>
      } else if(c == 'x') {
     8ac:	fdc42783          	lw	a5,-36(s0)
     8b0:	0007871b          	sext.w	a4,a5
     8b4:	07800793          	li	a5,120
     8b8:	02f71463          	bne	a4,a5,8e0 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     8bc:	fb843783          	ld	a5,-72(s0)
     8c0:	00878713          	addi	a4,a5,8
     8c4:	fae43c23          	sd	a4,-72(s0)
     8c8:	4398                	lw	a4,0(a5)
     8ca:	fcc42783          	lw	a5,-52(s0)
     8ce:	4681                	li	a3,0
     8d0:	4641                	li	a2,16
     8d2:	85ba                	mv	a1,a4
     8d4:	853e                	mv	a0,a5
     8d6:	00000097          	auipc	ra,0x0
     8da:	d52080e7          	jalr	-686(ra) # 628 <printint>
     8de:	aa39                	j	9fc <vprintf+0x23a>
      } else if(c == 'p') {
     8e0:	fdc42783          	lw	a5,-36(s0)
     8e4:	0007871b          	sext.w	a4,a5
     8e8:	07000793          	li	a5,112
     8ec:	02f71263          	bne	a4,a5,910 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     8f0:	fb843783          	ld	a5,-72(s0)
     8f4:	00878713          	addi	a4,a5,8
     8f8:	fae43c23          	sd	a4,-72(s0)
     8fc:	6398                	ld	a4,0(a5)
     8fe:	fcc42783          	lw	a5,-52(s0)
     902:	85ba                	mv	a1,a4
     904:	853e                	mv	a0,a5
     906:	00000097          	auipc	ra,0x0
     90a:	e30080e7          	jalr	-464(ra) # 736 <printptr>
     90e:	a0fd                	j	9fc <vprintf+0x23a>
      } else if(c == 's'){
     910:	fdc42783          	lw	a5,-36(s0)
     914:	0007871b          	sext.w	a4,a5
     918:	07300793          	li	a5,115
     91c:	04f71c63          	bne	a4,a5,974 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     920:	fb843783          	ld	a5,-72(s0)
     924:	00878713          	addi	a4,a5,8
     928:	fae43c23          	sd	a4,-72(s0)
     92c:	639c                	ld	a5,0(a5)
     92e:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     932:	fe843783          	ld	a5,-24(s0)
     936:	eb8d                	bnez	a5,968 <vprintf+0x1a6>
          s = "(null)";
     938:	00001797          	auipc	a5,0x1
     93c:	17878793          	addi	a5,a5,376 # 1ab0 <schedule_dm+0x230>
     940:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     944:	a015                	j	968 <vprintf+0x1a6>
          putc(fd, *s);
     946:	fe843783          	ld	a5,-24(s0)
     94a:	0007c703          	lbu	a4,0(a5)
     94e:	fcc42783          	lw	a5,-52(s0)
     952:	85ba                	mv	a1,a4
     954:	853e                	mv	a0,a5
     956:	00000097          	auipc	ra,0x0
     95a:	c9c080e7          	jalr	-868(ra) # 5f2 <putc>
          s++;
     95e:	fe843783          	ld	a5,-24(s0)
     962:	0785                	addi	a5,a5,1
     964:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     968:	fe843783          	ld	a5,-24(s0)
     96c:	0007c783          	lbu	a5,0(a5)
     970:	fbf9                	bnez	a5,946 <vprintf+0x184>
     972:	a069                	j	9fc <vprintf+0x23a>
        }
      } else if(c == 'c'){
     974:	fdc42783          	lw	a5,-36(s0)
     978:	0007871b          	sext.w	a4,a5
     97c:	06300793          	li	a5,99
     980:	02f71463          	bne	a4,a5,9a8 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     984:	fb843783          	ld	a5,-72(s0)
     988:	00878713          	addi	a4,a5,8
     98c:	fae43c23          	sd	a4,-72(s0)
     990:	439c                	lw	a5,0(a5)
     992:	0ff7f713          	andi	a4,a5,255
     996:	fcc42783          	lw	a5,-52(s0)
     99a:	85ba                	mv	a1,a4
     99c:	853e                	mv	a0,a5
     99e:	00000097          	auipc	ra,0x0
     9a2:	c54080e7          	jalr	-940(ra) # 5f2 <putc>
     9a6:	a899                	j	9fc <vprintf+0x23a>
      } else if(c == '%'){
     9a8:	fdc42783          	lw	a5,-36(s0)
     9ac:	0007871b          	sext.w	a4,a5
     9b0:	02500793          	li	a5,37
     9b4:	00f71f63          	bne	a4,a5,9d2 <vprintf+0x210>
        putc(fd, c);
     9b8:	fdc42783          	lw	a5,-36(s0)
     9bc:	0ff7f713          	andi	a4,a5,255
     9c0:	fcc42783          	lw	a5,-52(s0)
     9c4:	85ba                	mv	a1,a4
     9c6:	853e                	mv	a0,a5
     9c8:	00000097          	auipc	ra,0x0
     9cc:	c2a080e7          	jalr	-982(ra) # 5f2 <putc>
     9d0:	a035                	j	9fc <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     9d2:	fcc42783          	lw	a5,-52(s0)
     9d6:	02500593          	li	a1,37
     9da:	853e                	mv	a0,a5
     9dc:	00000097          	auipc	ra,0x0
     9e0:	c16080e7          	jalr	-1002(ra) # 5f2 <putc>
        putc(fd, c);
     9e4:	fdc42783          	lw	a5,-36(s0)
     9e8:	0ff7f713          	andi	a4,a5,255
     9ec:	fcc42783          	lw	a5,-52(s0)
     9f0:	85ba                	mv	a1,a4
     9f2:	853e                	mv	a0,a5
     9f4:	00000097          	auipc	ra,0x0
     9f8:	bfe080e7          	jalr	-1026(ra) # 5f2 <putc>
      }
      state = 0;
     9fc:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     a00:	fe442783          	lw	a5,-28(s0)
     a04:	2785                	addiw	a5,a5,1
     a06:	fef42223          	sw	a5,-28(s0)
     a0a:	fe442783          	lw	a5,-28(s0)
     a0e:	fc043703          	ld	a4,-64(s0)
     a12:	97ba                	add	a5,a5,a4
     a14:	0007c783          	lbu	a5,0(a5)
     a18:	dc0795e3          	bnez	a5,7e2 <vprintf+0x20>
    }
  }
}
     a1c:	0001                	nop
     a1e:	0001                	nop
     a20:	60a6                	ld	ra,72(sp)
     a22:	6406                	ld	s0,64(sp)
     a24:	6161                	addi	sp,sp,80
     a26:	8082                	ret

0000000000000a28 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     a28:	7159                	addi	sp,sp,-112
     a2a:	fc06                	sd	ra,56(sp)
     a2c:	f822                	sd	s0,48(sp)
     a2e:	0080                	addi	s0,sp,64
     a30:	fcb43823          	sd	a1,-48(s0)
     a34:	e010                	sd	a2,0(s0)
     a36:	e414                	sd	a3,8(s0)
     a38:	e818                	sd	a4,16(s0)
     a3a:	ec1c                	sd	a5,24(s0)
     a3c:	03043023          	sd	a6,32(s0)
     a40:	03143423          	sd	a7,40(s0)
     a44:	87aa                	mv	a5,a0
     a46:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     a4a:	03040793          	addi	a5,s0,48
     a4e:	fcf43423          	sd	a5,-56(s0)
     a52:	fc843783          	ld	a5,-56(s0)
     a56:	fd078793          	addi	a5,a5,-48
     a5a:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     a5e:	fe843703          	ld	a4,-24(s0)
     a62:	fdc42783          	lw	a5,-36(s0)
     a66:	863a                	mv	a2,a4
     a68:	fd043583          	ld	a1,-48(s0)
     a6c:	853e                	mv	a0,a5
     a6e:	00000097          	auipc	ra,0x0
     a72:	d54080e7          	jalr	-684(ra) # 7c2 <vprintf>
}
     a76:	0001                	nop
     a78:	70e2                	ld	ra,56(sp)
     a7a:	7442                	ld	s0,48(sp)
     a7c:	6165                	addi	sp,sp,112
     a7e:	8082                	ret

0000000000000a80 <printf>:

void
printf(const char *fmt, ...)
{
     a80:	7159                	addi	sp,sp,-112
     a82:	f406                	sd	ra,40(sp)
     a84:	f022                	sd	s0,32(sp)
     a86:	1800                	addi	s0,sp,48
     a88:	fca43c23          	sd	a0,-40(s0)
     a8c:	e40c                	sd	a1,8(s0)
     a8e:	e810                	sd	a2,16(s0)
     a90:	ec14                	sd	a3,24(s0)
     a92:	f018                	sd	a4,32(s0)
     a94:	f41c                	sd	a5,40(s0)
     a96:	03043823          	sd	a6,48(s0)
     a9a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     a9e:	04040793          	addi	a5,s0,64
     aa2:	fcf43823          	sd	a5,-48(s0)
     aa6:	fd043783          	ld	a5,-48(s0)
     aaa:	fc878793          	addi	a5,a5,-56
     aae:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     ab2:	fe843783          	ld	a5,-24(s0)
     ab6:	863e                	mv	a2,a5
     ab8:	fd843583          	ld	a1,-40(s0)
     abc:	4505                	li	a0,1
     abe:	00000097          	auipc	ra,0x0
     ac2:	d04080e7          	jalr	-764(ra) # 7c2 <vprintf>
}
     ac6:	0001                	nop
     ac8:	70a2                	ld	ra,40(sp)
     aca:	7402                	ld	s0,32(sp)
     acc:	6165                	addi	sp,sp,112
     ace:	8082                	ret

0000000000000ad0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     ad0:	7179                	addi	sp,sp,-48
     ad2:	f422                	sd	s0,40(sp)
     ad4:	1800                	addi	s0,sp,48
     ad6:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     ada:	fd843783          	ld	a5,-40(s0)
     ade:	17c1                	addi	a5,a5,-16
     ae0:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     ae4:	00001797          	auipc	a5,0x1
     ae8:	ffc78793          	addi	a5,a5,-4 # 1ae0 <freep>
     aec:	639c                	ld	a5,0(a5)
     aee:	fef43423          	sd	a5,-24(s0)
     af2:	a815                	j	b26 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     af4:	fe843783          	ld	a5,-24(s0)
     af8:	639c                	ld	a5,0(a5)
     afa:	fe843703          	ld	a4,-24(s0)
     afe:	00f76f63          	bltu	a4,a5,b1c <free+0x4c>
     b02:	fe043703          	ld	a4,-32(s0)
     b06:	fe843783          	ld	a5,-24(s0)
     b0a:	02e7eb63          	bltu	a5,a4,b40 <free+0x70>
     b0e:	fe843783          	ld	a5,-24(s0)
     b12:	639c                	ld	a5,0(a5)
     b14:	fe043703          	ld	a4,-32(s0)
     b18:	02f76463          	bltu	a4,a5,b40 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b1c:	fe843783          	ld	a5,-24(s0)
     b20:	639c                	ld	a5,0(a5)
     b22:	fef43423          	sd	a5,-24(s0)
     b26:	fe043703          	ld	a4,-32(s0)
     b2a:	fe843783          	ld	a5,-24(s0)
     b2e:	fce7f3e3          	bgeu	a5,a4,af4 <free+0x24>
     b32:	fe843783          	ld	a5,-24(s0)
     b36:	639c                	ld	a5,0(a5)
     b38:	fe043703          	ld	a4,-32(s0)
     b3c:	faf77ce3          	bgeu	a4,a5,af4 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     b40:	fe043783          	ld	a5,-32(s0)
     b44:	479c                	lw	a5,8(a5)
     b46:	1782                	slli	a5,a5,0x20
     b48:	9381                	srli	a5,a5,0x20
     b4a:	0792                	slli	a5,a5,0x4
     b4c:	fe043703          	ld	a4,-32(s0)
     b50:	973e                	add	a4,a4,a5
     b52:	fe843783          	ld	a5,-24(s0)
     b56:	639c                	ld	a5,0(a5)
     b58:	02f71763          	bne	a4,a5,b86 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     b5c:	fe043783          	ld	a5,-32(s0)
     b60:	4798                	lw	a4,8(a5)
     b62:	fe843783          	ld	a5,-24(s0)
     b66:	639c                	ld	a5,0(a5)
     b68:	479c                	lw	a5,8(a5)
     b6a:	9fb9                	addw	a5,a5,a4
     b6c:	0007871b          	sext.w	a4,a5
     b70:	fe043783          	ld	a5,-32(s0)
     b74:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     b76:	fe843783          	ld	a5,-24(s0)
     b7a:	639c                	ld	a5,0(a5)
     b7c:	6398                	ld	a4,0(a5)
     b7e:	fe043783          	ld	a5,-32(s0)
     b82:	e398                	sd	a4,0(a5)
     b84:	a039                	j	b92 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     b86:	fe843783          	ld	a5,-24(s0)
     b8a:	6398                	ld	a4,0(a5)
     b8c:	fe043783          	ld	a5,-32(s0)
     b90:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     b92:	fe843783          	ld	a5,-24(s0)
     b96:	479c                	lw	a5,8(a5)
     b98:	1782                	slli	a5,a5,0x20
     b9a:	9381                	srli	a5,a5,0x20
     b9c:	0792                	slli	a5,a5,0x4
     b9e:	fe843703          	ld	a4,-24(s0)
     ba2:	97ba                	add	a5,a5,a4
     ba4:	fe043703          	ld	a4,-32(s0)
     ba8:	02f71563          	bne	a4,a5,bd2 <free+0x102>
    p->s.size += bp->s.size;
     bac:	fe843783          	ld	a5,-24(s0)
     bb0:	4798                	lw	a4,8(a5)
     bb2:	fe043783          	ld	a5,-32(s0)
     bb6:	479c                	lw	a5,8(a5)
     bb8:	9fb9                	addw	a5,a5,a4
     bba:	0007871b          	sext.w	a4,a5
     bbe:	fe843783          	ld	a5,-24(s0)
     bc2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     bc4:	fe043783          	ld	a5,-32(s0)
     bc8:	6398                	ld	a4,0(a5)
     bca:	fe843783          	ld	a5,-24(s0)
     bce:	e398                	sd	a4,0(a5)
     bd0:	a031                	j	bdc <free+0x10c>
  } else
    p->s.ptr = bp;
     bd2:	fe843783          	ld	a5,-24(s0)
     bd6:	fe043703          	ld	a4,-32(s0)
     bda:	e398                	sd	a4,0(a5)
  freep = p;
     bdc:	00001797          	auipc	a5,0x1
     be0:	f0478793          	addi	a5,a5,-252 # 1ae0 <freep>
     be4:	fe843703          	ld	a4,-24(s0)
     be8:	e398                	sd	a4,0(a5)
}
     bea:	0001                	nop
     bec:	7422                	ld	s0,40(sp)
     bee:	6145                	addi	sp,sp,48
     bf0:	8082                	ret

0000000000000bf2 <morecore>:

static Header*
morecore(uint nu)
{
     bf2:	7179                	addi	sp,sp,-48
     bf4:	f406                	sd	ra,40(sp)
     bf6:	f022                	sd	s0,32(sp)
     bf8:	1800                	addi	s0,sp,48
     bfa:	87aa                	mv	a5,a0
     bfc:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     c00:	fdc42783          	lw	a5,-36(s0)
     c04:	0007871b          	sext.w	a4,a5
     c08:	6785                	lui	a5,0x1
     c0a:	00f77563          	bgeu	a4,a5,c14 <morecore+0x22>
    nu = 4096;
     c0e:	6785                	lui	a5,0x1
     c10:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     c14:	fdc42783          	lw	a5,-36(s0)
     c18:	0047979b          	slliw	a5,a5,0x4
     c1c:	2781                	sext.w	a5,a5
     c1e:	2781                	sext.w	a5,a5
     c20:	853e                	mv	a0,a5
     c22:	00000097          	auipc	ra,0x0
     c26:	9a0080e7          	jalr	-1632(ra) # 5c2 <sbrk>
     c2a:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     c2e:	fe843703          	ld	a4,-24(s0)
     c32:	57fd                	li	a5,-1
     c34:	00f71463          	bne	a4,a5,c3c <morecore+0x4a>
    return 0;
     c38:	4781                	li	a5,0
     c3a:	a03d                	j	c68 <morecore+0x76>
  hp = (Header*)p;
     c3c:	fe843783          	ld	a5,-24(s0)
     c40:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     c44:	fe043783          	ld	a5,-32(s0)
     c48:	fdc42703          	lw	a4,-36(s0)
     c4c:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     c4e:	fe043783          	ld	a5,-32(s0)
     c52:	07c1                	addi	a5,a5,16
     c54:	853e                	mv	a0,a5
     c56:	00000097          	auipc	ra,0x0
     c5a:	e7a080e7          	jalr	-390(ra) # ad0 <free>
  return freep;
     c5e:	00001797          	auipc	a5,0x1
     c62:	e8278793          	addi	a5,a5,-382 # 1ae0 <freep>
     c66:	639c                	ld	a5,0(a5)
}
     c68:	853e                	mv	a0,a5
     c6a:	70a2                	ld	ra,40(sp)
     c6c:	7402                	ld	s0,32(sp)
     c6e:	6145                	addi	sp,sp,48
     c70:	8082                	ret

0000000000000c72 <malloc>:

void*
malloc(uint nbytes)
{
     c72:	7139                	addi	sp,sp,-64
     c74:	fc06                	sd	ra,56(sp)
     c76:	f822                	sd	s0,48(sp)
     c78:	0080                	addi	s0,sp,64
     c7a:	87aa                	mv	a5,a0
     c7c:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     c80:	fcc46783          	lwu	a5,-52(s0)
     c84:	07bd                	addi	a5,a5,15
     c86:	8391                	srli	a5,a5,0x4
     c88:	2781                	sext.w	a5,a5
     c8a:	2785                	addiw	a5,a5,1
     c8c:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     c90:	00001797          	auipc	a5,0x1
     c94:	e5078793          	addi	a5,a5,-432 # 1ae0 <freep>
     c98:	639c                	ld	a5,0(a5)
     c9a:	fef43023          	sd	a5,-32(s0)
     c9e:	fe043783          	ld	a5,-32(s0)
     ca2:	ef95                	bnez	a5,cde <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     ca4:	00001797          	auipc	a5,0x1
     ca8:	e2c78793          	addi	a5,a5,-468 # 1ad0 <base>
     cac:	fef43023          	sd	a5,-32(s0)
     cb0:	00001797          	auipc	a5,0x1
     cb4:	e3078793          	addi	a5,a5,-464 # 1ae0 <freep>
     cb8:	fe043703          	ld	a4,-32(s0)
     cbc:	e398                	sd	a4,0(a5)
     cbe:	00001797          	auipc	a5,0x1
     cc2:	e2278793          	addi	a5,a5,-478 # 1ae0 <freep>
     cc6:	6398                	ld	a4,0(a5)
     cc8:	00001797          	auipc	a5,0x1
     ccc:	e0878793          	addi	a5,a5,-504 # 1ad0 <base>
     cd0:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     cd2:	00001797          	auipc	a5,0x1
     cd6:	dfe78793          	addi	a5,a5,-514 # 1ad0 <base>
     cda:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     cde:	fe043783          	ld	a5,-32(s0)
     ce2:	639c                	ld	a5,0(a5)
     ce4:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     ce8:	fe843783          	ld	a5,-24(s0)
     cec:	4798                	lw	a4,8(a5)
     cee:	fdc42783          	lw	a5,-36(s0)
     cf2:	2781                	sext.w	a5,a5
     cf4:	06f76863          	bltu	a4,a5,d64 <malloc+0xf2>
      if(p->s.size == nunits)
     cf8:	fe843783          	ld	a5,-24(s0)
     cfc:	4798                	lw	a4,8(a5)
     cfe:	fdc42783          	lw	a5,-36(s0)
     d02:	2781                	sext.w	a5,a5
     d04:	00e79963          	bne	a5,a4,d16 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     d08:	fe843783          	ld	a5,-24(s0)
     d0c:	6398                	ld	a4,0(a5)
     d0e:	fe043783          	ld	a5,-32(s0)
     d12:	e398                	sd	a4,0(a5)
     d14:	a82d                	j	d4e <malloc+0xdc>
      else {
        p->s.size -= nunits;
     d16:	fe843783          	ld	a5,-24(s0)
     d1a:	4798                	lw	a4,8(a5)
     d1c:	fdc42783          	lw	a5,-36(s0)
     d20:	40f707bb          	subw	a5,a4,a5
     d24:	0007871b          	sext.w	a4,a5
     d28:	fe843783          	ld	a5,-24(s0)
     d2c:	c798                	sw	a4,8(a5)
        p += p->s.size;
     d2e:	fe843783          	ld	a5,-24(s0)
     d32:	479c                	lw	a5,8(a5)
     d34:	1782                	slli	a5,a5,0x20
     d36:	9381                	srli	a5,a5,0x20
     d38:	0792                	slli	a5,a5,0x4
     d3a:	fe843703          	ld	a4,-24(s0)
     d3e:	97ba                	add	a5,a5,a4
     d40:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     d44:	fe843783          	ld	a5,-24(s0)
     d48:	fdc42703          	lw	a4,-36(s0)
     d4c:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     d4e:	00001797          	auipc	a5,0x1
     d52:	d9278793          	addi	a5,a5,-622 # 1ae0 <freep>
     d56:	fe043703          	ld	a4,-32(s0)
     d5a:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     d5c:	fe843783          	ld	a5,-24(s0)
     d60:	07c1                	addi	a5,a5,16
     d62:	a091                	j	da6 <malloc+0x134>
    }
    if(p == freep)
     d64:	00001797          	auipc	a5,0x1
     d68:	d7c78793          	addi	a5,a5,-644 # 1ae0 <freep>
     d6c:	639c                	ld	a5,0(a5)
     d6e:	fe843703          	ld	a4,-24(s0)
     d72:	02f71063          	bne	a4,a5,d92 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     d76:	fdc42783          	lw	a5,-36(s0)
     d7a:	853e                	mv	a0,a5
     d7c:	00000097          	auipc	ra,0x0
     d80:	e76080e7          	jalr	-394(ra) # bf2 <morecore>
     d84:	fea43423          	sd	a0,-24(s0)
     d88:	fe843783          	ld	a5,-24(s0)
     d8c:	e399                	bnez	a5,d92 <malloc+0x120>
        return 0;
     d8e:	4781                	li	a5,0
     d90:	a819                	j	da6 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     d92:	fe843783          	ld	a5,-24(s0)
     d96:	fef43023          	sd	a5,-32(s0)
     d9a:	fe843783          	ld	a5,-24(s0)
     d9e:	639c                	ld	a5,0(a5)
     da0:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     da4:	b791                	j	ce8 <malloc+0x76>
  }
}
     da6:	853e                	mv	a0,a5
     da8:	70e2                	ld	ra,56(sp)
     daa:	7442                	ld	s0,48(sp)
     dac:	6121                	addi	sp,sp,64
     dae:	8082                	ret

0000000000000db0 <setjmp>:
     db0:	e100                	sd	s0,0(a0)
     db2:	e504                	sd	s1,8(a0)
     db4:	01253823          	sd	s2,16(a0)
     db8:	01353c23          	sd	s3,24(a0)
     dbc:	03453023          	sd	s4,32(a0)
     dc0:	03553423          	sd	s5,40(a0)
     dc4:	03653823          	sd	s6,48(a0)
     dc8:	03753c23          	sd	s7,56(a0)
     dcc:	05853023          	sd	s8,64(a0)
     dd0:	05953423          	sd	s9,72(a0)
     dd4:	05a53823          	sd	s10,80(a0)
     dd8:	05b53c23          	sd	s11,88(a0)
     ddc:	06153023          	sd	ra,96(a0)
     de0:	06253423          	sd	sp,104(a0)
     de4:	4501                	li	a0,0
     de6:	8082                	ret

0000000000000de8 <longjmp>:
     de8:	6100                	ld	s0,0(a0)
     dea:	6504                	ld	s1,8(a0)
     dec:	01053903          	ld	s2,16(a0)
     df0:	01853983          	ld	s3,24(a0)
     df4:	02053a03          	ld	s4,32(a0)
     df8:	02853a83          	ld	s5,40(a0)
     dfc:	03053b03          	ld	s6,48(a0)
     e00:	03853b83          	ld	s7,56(a0)
     e04:	04053c03          	ld	s8,64(a0)
     e08:	04853c83          	ld	s9,72(a0)
     e0c:	05053d03          	ld	s10,80(a0)
     e10:	05853d83          	ld	s11,88(a0)
     e14:	06053083          	ld	ra,96(a0)
     e18:	06853103          	ld	sp,104(a0)
     e1c:	c199                	beqz	a1,e22 <longjmp_1>
     e1e:	852e                	mv	a0,a1
     e20:	8082                	ret

0000000000000e22 <longjmp_1>:
     e22:	4505                	li	a0,1
     e24:	8082                	ret

0000000000000e26 <schedule_default>:
#define INT_MAX 2147483647
#define TIME_QUANTUM 2  // Define a base time quantum for the round-robin

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
     e26:	715d                	addi	sp,sp,-80
     e28:	e4a2                	sd	s0,72(sp)
     e2a:	e0a6                	sd	s1,64(sp)
     e2c:	0880                	addi	s0,sp,80
     e2e:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
     e30:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
     e34:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     e38:	649c                	ld	a5,8(s1)
     e3a:	639c                	ld	a5,0(a5)
     e3c:	fcf43c23          	sd	a5,-40(s0)
     e40:	fd843783          	ld	a5,-40(s0)
     e44:	fd878793          	addi	a5,a5,-40
     e48:	fef43023          	sd	a5,-32(s0)
     e4c:	a81d                	j	e82 <schedule_default+0x5c>
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
     e4e:	fe843783          	ld	a5,-24(s0)
     e52:	cb89                	beqz	a5,e64 <schedule_default+0x3e>
     e54:	fe043783          	ld	a5,-32(s0)
     e58:	5fd8                	lw	a4,60(a5)
     e5a:	fe843783          	ld	a5,-24(s0)
     e5e:	5fdc                	lw	a5,60(a5)
     e60:	00f75663          	bge	a4,a5,e6c <schedule_default+0x46>
            thread_with_smallest_id = th;
     e64:	fe043783          	ld	a5,-32(s0)
     e68:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     e6c:	fe043783          	ld	a5,-32(s0)
     e70:	779c                	ld	a5,40(a5)
     e72:	fcf43823          	sd	a5,-48(s0)
     e76:	fd043783          	ld	a5,-48(s0)
     e7a:	fd878793          	addi	a5,a5,-40
     e7e:	fef43023          	sd	a5,-32(s0)
     e82:	fe043783          	ld	a5,-32(s0)
     e86:	02878713          	addi	a4,a5,40
     e8a:	649c                	ld	a5,8(s1)
     e8c:	fcf711e3          	bne	a4,a5,e4e <schedule_default+0x28>
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
     e90:	fe843783          	ld	a5,-24(s0)
     e94:	cf89                	beqz	a5,eae <schedule_default+0x88>
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
     e96:	fe843783          	ld	a5,-24(s0)
     e9a:	02878793          	addi	a5,a5,40
     e9e:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
     ea2:	fe843783          	ld	a5,-24(s0)
     ea6:	4fbc                	lw	a5,88(a5)
     ea8:	faf42c23          	sw	a5,-72(s0)
     eac:	a039                	j	eba <schedule_default+0x94>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
     eae:	649c                	ld	a5,8(s1)
     eb0:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
     eb4:	4785                	li	a5,1
     eb6:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
     eba:	fb043783          	ld	a5,-80(s0)
     ebe:	fcf43023          	sd	a5,-64(s0)
     ec2:	fb843783          	ld	a5,-72(s0)
     ec6:	fcf43423          	sd	a5,-56(s0)
     eca:	4701                	li	a4,0
     ecc:	fc043703          	ld	a4,-64(s0)
     ed0:	4781                	li	a5,0
     ed2:	fc843783          	ld	a5,-56(s0)
     ed6:	863a                	mv	a2,a4
     ed8:	86be                	mv	a3,a5
     eda:	8732                	mv	a4,a2
     edc:	87b6                	mv	a5,a3
}
     ede:	853a                	mv	a0,a4
     ee0:	85be                	mv	a1,a5
     ee2:	6426                	ld	s0,72(sp)
     ee4:	6486                	ld	s1,64(sp)
     ee6:	6161                	addi	sp,sp,80
     ee8:	8082                	ret

0000000000000eea <find_next_release_time>:

int find_next_release_time(struct list_head *release_queue, int current_time) {
     eea:	7139                	addi	sp,sp,-64
     eec:	fc22                	sd	s0,56(sp)
     eee:	0080                	addi	s0,sp,64
     ef0:	fca43423          	sd	a0,-56(s0)
     ef4:	87ae                	mv	a5,a1
     ef6:	fcf42223          	sw	a5,-60(s0)
    struct release_queue_entry *next_release = NULL;
     efa:	fe043423          	sd	zero,-24(s0)
    int next_release_time = INT_MAX;
     efe:	800007b7          	lui	a5,0x80000
     f02:	fff7c793          	not	a5,a5
     f06:	fef42223          	sw	a5,-28(s0)

    list_for_each_entry(next_release, release_queue, thread_list) {
     f0a:	fc843783          	ld	a5,-56(s0)
     f0e:	639c                	ld	a5,0(a5)
     f10:	fcf43c23          	sd	a5,-40(s0)
     f14:	fd843783          	ld	a5,-40(s0)
     f18:	17e1                	addi	a5,a5,-8
     f1a:	fef43423          	sd	a5,-24(s0)
     f1e:	a081                	j	f5e <find_next_release_time+0x74>
        if (next_release->release_time > current_time && next_release->release_time < next_release_time) {
     f20:	fe843783          	ld	a5,-24(s0)
     f24:	4f98                	lw	a4,24(a5)
     f26:	fc442783          	lw	a5,-60(s0)
     f2a:	2781                	sext.w	a5,a5
     f2c:	00e7df63          	bge	a5,a4,f4a <find_next_release_time+0x60>
     f30:	fe843783          	ld	a5,-24(s0)
     f34:	4f98                	lw	a4,24(a5)
     f36:	fe442783          	lw	a5,-28(s0)
     f3a:	2781                	sext.w	a5,a5
     f3c:	00f75763          	bge	a4,a5,f4a <find_next_release_time+0x60>
            next_release_time = next_release->release_time;
     f40:	fe843783          	ld	a5,-24(s0)
     f44:	4f9c                	lw	a5,24(a5)
     f46:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(next_release, release_queue, thread_list) {
     f4a:	fe843783          	ld	a5,-24(s0)
     f4e:	679c                	ld	a5,8(a5)
     f50:	fcf43823          	sd	a5,-48(s0)
     f54:	fd043783          	ld	a5,-48(s0)
     f58:	17e1                	addi	a5,a5,-8
     f5a:	fef43423          	sd	a5,-24(s0)
     f5e:	fe843783          	ld	a5,-24(s0)
     f62:	07a1                	addi	a5,a5,8
     f64:	fc843703          	ld	a4,-56(s0)
     f68:	faf71ce3          	bne	a4,a5,f20 <find_next_release_time+0x36>
        }
    }

    if (next_release_time == INT_MAX)
     f6c:	fe442783          	lw	a5,-28(s0)
     f70:	0007871b          	sext.w	a4,a5
     f74:	800007b7          	lui	a5,0x80000
     f78:	fff7c793          	not	a5,a5
     f7c:	00f71463          	bne	a4,a5,f84 <find_next_release_time+0x9a>
        return -1; // No threads in the release queue
     f80:	57fd                	li	a5,-1
     f82:	a801                	j	f92 <find_next_release_time+0xa8>

    return next_release_time - current_time;
     f84:	fe442703          	lw	a4,-28(s0)
     f88:	fc442783          	lw	a5,-60(s0)
     f8c:	40f707bb          	subw	a5,a4,a5
     f90:	2781                	sext.w	a5,a5
}
     f92:	853e                	mv	a0,a5
     f94:	7462                	ld	s0,56(sp)
     f96:	6121                	addi	sp,sp,64
     f98:	8082                	ret

0000000000000f9a <schedule_wrr>:

/* MP3 Part 1 - Non-Real-Time Scheduling */
/* Weighted-Round-Robin Scheduling */
struct threads_sched_result schedule_wrr(struct threads_sched_args args)
{
     f9a:	7119                	addi	sp,sp,-128
     f9c:	fc86                	sd	ra,120(sp)
     f9e:	f8a2                	sd	s0,112(sp)
     fa0:	f4a6                	sd	s1,104(sp)
     fa2:	f0ca                	sd	s2,96(sp)
     fa4:	ecce                	sd	s3,88(sp)
     fa6:	0100                	addi	s0,sp,128
     fa8:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the weighted round-robin scheduling algorithm
    static struct thread *last_thread = NULL;
    struct thread *selected_thread = NULL;
     faa:	fc043423          	sd	zero,-56(s0)
    struct thread *candidate = NULL;
     fae:	fc043023          	sd	zero,-64(s0)

    // If last_thread is NULL or its remaining time is zero, reset the selection process
    if (last_thread == NULL || last_thread->remaining_time <= 0) {
     fb2:	00001797          	auipc	a5,0x1
     fb6:	b3678793          	addi	a5,a5,-1226 # 1ae8 <last_thread.1239>
     fba:	639c                	ld	a5,0(a5)
     fbc:	cb89                	beqz	a5,fce <schedule_wrr+0x34>
     fbe:	00001797          	auipc	a5,0x1
     fc2:	b2a78793          	addi	a5,a5,-1238 # 1ae8 <last_thread.1239>
     fc6:	639c                	ld	a5,0(a5)
     fc8:	4fbc                	lw	a5,88(a5)
     fca:	00f04863          	bgtz	a5,fda <schedule_wrr+0x40>
        last_thread = NULL;
     fce:	00001797          	auipc	a5,0x1
     fd2:	b1a78793          	addi	a5,a5,-1254 # 1ae8 <last_thread.1239>
     fd6:	0007b023          	sd	zero,0(a5)
    }

    // Find the first thread that is ready to run
    list_for_each_entry(candidate, args.run_queue, thread_list) {
     fda:	649c                	ld	a5,8(s1)
     fdc:	639c                	ld	a5,0(a5)
     fde:	faf43823          	sd	a5,-80(s0)
     fe2:	fb043783          	ld	a5,-80(s0)
     fe6:	fd878793          	addi	a5,a5,-40
     fea:	fcf43023          	sd	a5,-64(s0)
     fee:	a0a9                	j	1038 <schedule_wrr+0x9e>
        if (!last_thread && candidate->remaining_time > 0)
     ff0:	00001797          	auipc	a5,0x1
     ff4:	af878793          	addi	a5,a5,-1288 # 1ae8 <last_thread.1239>
     ff8:	639c                	ld	a5,0(a5)
     ffa:	eb91                	bnez	a5,100e <schedule_wrr+0x74>
     ffc:	fc043783          	ld	a5,-64(s0)
    1000:	4fbc                	lw	a5,88(a5)
    1002:	00f05663          	blez	a5,100e <schedule_wrr+0x74>
            selected_thread = candidate;
    1006:	fc043783          	ld	a5,-64(s0)
    100a:	fcf43423          	sd	a5,-56(s0)
        if (candidate->remaining_time > 0) {
    100e:	fc043783          	ld	a5,-64(s0)
    1012:	4fbc                	lw	a5,88(a5)
    1014:	00f05763          	blez	a5,1022 <schedule_wrr+0x88>
            selected_thread = candidate;
    1018:	fc043783          	ld	a5,-64(s0)
    101c:	fcf43423          	sd	a5,-56(s0)
            break;
    1020:	a01d                	j	1046 <schedule_wrr+0xac>
    list_for_each_entry(candidate, args.run_queue, thread_list) {
    1022:	fc043783          	ld	a5,-64(s0)
    1026:	779c                	ld	a5,40(a5)
    1028:	faf43423          	sd	a5,-88(s0)
    102c:	fa843783          	ld	a5,-88(s0)
    1030:	fd878793          	addi	a5,a5,-40
    1034:	fcf43023          	sd	a5,-64(s0)
    1038:	fc043783          	ld	a5,-64(s0)
    103c:	02878713          	addi	a4,a5,40
    1040:	649c                	ld	a5,8(s1)
    1042:	faf717e3          	bne	a4,a5,ff0 <schedule_wrr+0x56>
        }
    }

    // Fall back to the last_thread if no other thread is selected and it still has remaining time
    if (!selected_thread && last_thread && last_thread->remaining_time > 0) {
    1046:	fc843783          	ld	a5,-56(s0)
    104a:	e795                	bnez	a5,1076 <schedule_wrr+0xdc>
    104c:	00001797          	auipc	a5,0x1
    1050:	a9c78793          	addi	a5,a5,-1380 # 1ae8 <last_thread.1239>
    1054:	639c                	ld	a5,0(a5)
    1056:	c385                	beqz	a5,1076 <schedule_wrr+0xdc>
    1058:	00001797          	auipc	a5,0x1
    105c:	a9078793          	addi	a5,a5,-1392 # 1ae8 <last_thread.1239>
    1060:	639c                	ld	a5,0(a5)
    1062:	4fbc                	lw	a5,88(a5)
    1064:	00f05963          	blez	a5,1076 <schedule_wrr+0xdc>
        selected_thread = last_thread;
    1068:	00001797          	auipc	a5,0x1
    106c:	a8078793          	addi	a5,a5,-1408 # 1ae8 <last_thread.1239>
    1070:	639c                	ld	a5,0(a5)
    1072:	fcf43423          	sd	a5,-56(s0)
    }

    // Set the scheduling result
    if (selected_thread) {
    1076:	fc843783          	ld	a5,-56(s0)
    107a:	c7b9                	beqz	a5,10c8 <schedule_wrr+0x12e>
        int time_slice = selected_thread->weight * TIME_QUANTUM;
    107c:	fc843783          	ld	a5,-56(s0)
    1080:	47bc                	lw	a5,72(a5)
    1082:	0017979b          	slliw	a5,a5,0x1
    1086:	faf42e23          	sw	a5,-68(s0)
        if (time_slice > selected_thread->remaining_time) {
    108a:	fc843783          	ld	a5,-56(s0)
    108e:	4fb8                	lw	a4,88(a5)
    1090:	fbc42783          	lw	a5,-68(s0)
    1094:	2781                	sext.w	a5,a5
    1096:	00f75763          	bge	a4,a5,10a4 <schedule_wrr+0x10a>
            time_slice = selected_thread->remaining_time;
    109a:	fc843783          	ld	a5,-56(s0)
    109e:	4fbc                	lw	a5,88(a5)
    10a0:	faf42e23          	sw	a5,-68(s0)
        }
        r.scheduled_thread_list_member = &selected_thread->thread_list;
    10a4:	fc843783          	ld	a5,-56(s0)
    10a8:	02878793          	addi	a5,a5,40
    10ac:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = time_slice;
    10b0:	fbc42783          	lw	a5,-68(s0)
    10b4:	f8f42823          	sw	a5,-112(s0)
        last_thread = selected_thread;  // Update the last run thread
    10b8:	00001797          	auipc	a5,0x1
    10bc:	a3078793          	addi	a5,a5,-1488 # 1ae8 <last_thread.1239>
    10c0:	fc843703          	ld	a4,-56(s0)
    10c4:	e398                	sd	a4,0(a5)
    10c6:	a839                	j	10e4 <schedule_wrr+0x14a>
    } else {
        // Idle if no suitable thread is found
        r.scheduled_thread_list_member = args.run_queue;
    10c8:	649c                	ld	a5,8(s1)
    10ca:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    10ce:	689c                	ld	a5,16(s1)
    10d0:	4098                	lw	a4,0(s1)
    10d2:	85ba                	mv	a1,a4
    10d4:	853e                	mv	a0,a5
    10d6:	00000097          	auipc	ra,0x0
    10da:	e14080e7          	jalr	-492(ra) # eea <find_next_release_time>
    10de:	87aa                	mv	a5,a0
    10e0:	f8f42823          	sw	a5,-112(s0)
    }

    return r;
    10e4:	f8843783          	ld	a5,-120(s0)
    10e8:	f8f43c23          	sd	a5,-104(s0)
    10ec:	f9043783          	ld	a5,-112(s0)
    10f0:	faf43023          	sd	a5,-96(s0)
    10f4:	4701                	li	a4,0
    10f6:	f9843703          	ld	a4,-104(s0)
    10fa:	4781                	li	a5,0
    10fc:	fa043783          	ld	a5,-96(s0)
    1100:	893a                	mv	s2,a4
    1102:	89be                	mv	s3,a5
    1104:	874a                	mv	a4,s2
    1106:	87ce                	mv	a5,s3
}
    1108:	853a                	mv	a0,a4
    110a:	85be                	mv	a1,a5
    110c:	70e6                	ld	ra,120(sp)
    110e:	7446                	ld	s0,112(sp)
    1110:	74a6                	ld	s1,104(sp)
    1112:	7906                	ld	s2,96(sp)
    1114:	69e6                	ld	s3,88(sp)
    1116:	6109                	addi	sp,sp,128
    1118:	8082                	ret

000000000000111a <find_earliest_impactful_release_time>:


int find_earliest_impactful_release_time(struct list_head *release_queue, struct list_head *run_queue, int current_time) {
    111a:	7159                	addi	sp,sp,-112
    111c:	f4a2                	sd	s0,104(sp)
    111e:	1880                	addi	s0,sp,112
    1120:	faa43423          	sd	a0,-88(s0)
    1124:	fab43023          	sd	a1,-96(s0)
    1128:	87b2                	mv	a5,a2
    112a:	f8f42e23          	sw	a5,-100(s0)
    struct release_queue_entry *entry;
    int earliest_impactful_time = INT_MAX;
    112e:	800007b7          	lui	a5,0x80000
    1132:	fff7c793          	not	a5,a5
    1136:	fef42223          	sw	a5,-28(s0)
    int shortest_current_time = INT_MAX;
    113a:	800007b7          	lui	a5,0x80000
    113e:	fff7c793          	not	a5,a5
    1142:	fef42023          	sw	a5,-32(s0)
    // Find the shortest remaining time among currently running tasks
    struct thread *t;
    list_for_each_entry(t, run_queue, thread_list) {
    1146:	fa043783          	ld	a5,-96(s0)
    114a:	639c                	ld	a5,0(a5)
    114c:	fcf43823          	sd	a5,-48(s0)
    1150:	fd043783          	ld	a5,-48(s0)
    1154:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffdd20>
    1158:	fcf43c23          	sd	a5,-40(s0)
    115c:	a80d                	j	118e <find_earliest_impactful_release_time+0x74>
        if (t->remaining_time < shortest_current_time) {
    115e:	fd843783          	ld	a5,-40(s0)
    1162:	4fb8                	lw	a4,88(a5)
    1164:	fe042783          	lw	a5,-32(s0)
    1168:	2781                	sext.w	a5,a5
    116a:	00f75763          	bge	a4,a5,1178 <find_earliest_impactful_release_time+0x5e>
            shortest_current_time = t->remaining_time;
    116e:	fd843783          	ld	a5,-40(s0)
    1172:	4fbc                	lw	a5,88(a5)
    1174:	fef42023          	sw	a5,-32(s0)
    list_for_each_entry(t, run_queue, thread_list) {
    1178:	fd843783          	ld	a5,-40(s0)
    117c:	779c                	ld	a5,40(a5)
    117e:	faf43c23          	sd	a5,-72(s0)
    1182:	fb843783          	ld	a5,-72(s0)
    1186:	fd878793          	addi	a5,a5,-40
    118a:	fcf43c23          	sd	a5,-40(s0)
    118e:	fd843783          	ld	a5,-40(s0)
    1192:	02878793          	addi	a5,a5,40
    1196:	fa043703          	ld	a4,-96(s0)
    119a:	fcf712e3          	bne	a4,a5,115e <find_earliest_impactful_release_time+0x44>
        }
    }

    // Check the release queue for the next task that might preempt the current shortest job
    list_for_each_entry(entry, release_queue, thread_list) {
    119e:	fa843783          	ld	a5,-88(s0)
    11a2:	639c                	ld	a5,0(a5)
    11a4:	fcf43423          	sd	a5,-56(s0)
    11a8:	fc843783          	ld	a5,-56(s0)
    11ac:	17e1                	addi	a5,a5,-8
    11ae:	fef43423          	sd	a5,-24(s0)
    11b2:	a889                	j	1204 <find_earliest_impactful_release_time+0xea>
        if (entry->release_time > current_time && entry->release_time < earliest_impactful_time) {
    11b4:	fe843783          	ld	a5,-24(s0)
    11b8:	4f98                	lw	a4,24(a5)
    11ba:	f9c42783          	lw	a5,-100(s0)
    11be:	2781                	sext.w	a5,a5
    11c0:	02e7d863          	bge	a5,a4,11f0 <find_earliest_impactful_release_time+0xd6>
    11c4:	fe843783          	ld	a5,-24(s0)
    11c8:	4f98                	lw	a4,24(a5)
    11ca:	fe442783          	lw	a5,-28(s0)
    11ce:	2781                	sext.w	a5,a5
    11d0:	02f75063          	bge	a4,a5,11f0 <find_earliest_impactful_release_time+0xd6>
            if (entry->thrd->remaining_time < shortest_current_time) {
    11d4:	fe843783          	ld	a5,-24(s0)
    11d8:	639c                	ld	a5,0(a5)
    11da:	4fb8                	lw	a4,88(a5)
    11dc:	fe042783          	lw	a5,-32(s0)
    11e0:	2781                	sext.w	a5,a5
    11e2:	00f75763          	bge	a4,a5,11f0 <find_earliest_impactful_release_time+0xd6>
                earliest_impactful_time = entry->release_time;
    11e6:	fe843783          	ld	a5,-24(s0)
    11ea:	4f9c                	lw	a5,24(a5)
    11ec:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(entry, release_queue, thread_list) {
    11f0:	fe843783          	ld	a5,-24(s0)
    11f4:	679c                	ld	a5,8(a5)
    11f6:	fcf43023          	sd	a5,-64(s0)
    11fa:	fc043783          	ld	a5,-64(s0)
    11fe:	17e1                	addi	a5,a5,-8
    1200:	fef43423          	sd	a5,-24(s0)
    1204:	fe843783          	ld	a5,-24(s0)
    1208:	07a1                	addi	a5,a5,8
    120a:	fa843703          	ld	a4,-88(s0)
    120e:	faf713e3          	bne	a4,a5,11b4 <find_earliest_impactful_release_time+0x9a>
            }
        }
    }

    // Calculate the difference between the current time and the earliest impactful release time
    return earliest_impactful_time == INT_MAX ? -1 : earliest_impactful_time - current_time;
    1212:	fe442783          	lw	a5,-28(s0)
    1216:	0007871b          	sext.w	a4,a5
    121a:	800007b7          	lui	a5,0x80000
    121e:	fff7c793          	not	a5,a5
    1222:	00f70a63          	beq	a4,a5,1236 <find_earliest_impactful_release_time+0x11c>
    1226:	fe442703          	lw	a4,-28(s0)
    122a:	f9c42783          	lw	a5,-100(s0)
    122e:	40f707bb          	subw	a5,a4,a5
    1232:	2781                	sext.w	a5,a5
    1234:	a011                	j	1238 <find_earliest_impactful_release_time+0x11e>
    1236:	57fd                	li	a5,-1
}
    1238:	853e                	mv	a0,a5
    123a:	7426                	ld	s0,104(sp)
    123c:	6165                	addi	sp,sp,112
    123e:	8082                	ret

0000000000001240 <schedule_sjf>:


struct threads_sched_result schedule_sjf(struct threads_sched_args args) {
    1240:	7119                	addi	sp,sp,-128
    1242:	fc86                	sd	ra,120(sp)
    1244:	f8a2                	sd	s0,112(sp)
    1246:	f4a6                	sd	s1,104(sp)
    1248:	f0ca                	sd	s2,96(sp)
    124a:	ecce                	sd	s3,88(sp)
    124c:	0100                	addi	s0,sp,128
    124e:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *shortest_job = NULL;
    1250:	fc043423          	sd	zero,-56(s0)
    struct thread *current;
    int shortest_time = INT_MAX;
    1254:	800007b7          	lui	a5,0x80000
    1258:	fff7c793          	not	a5,a5
    125c:	faf42e23          	sw	a5,-68(s0)
    int earliest_impactful_time = find_earliest_impactful_release_time(args.release_queue, args.run_queue, args.current_time);
    1260:	689c                	ld	a5,16(s1)
    1262:	6498                	ld	a4,8(s1)
    1264:	4094                	lw	a3,0(s1)
    1266:	8636                	mv	a2,a3
    1268:	85ba                	mv	a1,a4
    126a:	853e                	mv	a0,a5
    126c:	00000097          	auipc	ra,0x0
    1270:	eae080e7          	jalr	-338(ra) # 111a <find_earliest_impactful_release_time>
    1274:	87aa                	mv	a5,a0
    1276:	faf42a23          	sw	a5,-76(s0)

    // Determine the shortest job from the run queue
    list_for_each_entry(current, args.run_queue, thread_list) {
    127a:	649c                	ld	a5,8(s1)
    127c:	639c                	ld	a5,0(a5)
    127e:	faf43423          	sd	a5,-88(s0)
    1282:	fa843783          	ld	a5,-88(s0)
    1286:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffdd20>
    128a:	fcf43023          	sd	a5,-64(s0)
    128e:	a82d                	j	12c8 <schedule_sjf+0x88>
        if (current->remaining_time < shortest_time) {
    1290:	fc043783          	ld	a5,-64(s0)
    1294:	4fb8                	lw	a4,88(a5)
    1296:	fbc42783          	lw	a5,-68(s0)
    129a:	2781                	sext.w	a5,a5
    129c:	00f75b63          	bge	a4,a5,12b2 <schedule_sjf+0x72>
            shortest_time = current->remaining_time;
    12a0:	fc043783          	ld	a5,-64(s0)
    12a4:	4fbc                	lw	a5,88(a5)
    12a6:	faf42e23          	sw	a5,-68(s0)
            shortest_job = current;
    12aa:	fc043783          	ld	a5,-64(s0)
    12ae:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(current, args.run_queue, thread_list) {
    12b2:	fc043783          	ld	a5,-64(s0)
    12b6:	779c                	ld	a5,40(a5)
    12b8:	faf43023          	sd	a5,-96(s0)
    12bc:	fa043783          	ld	a5,-96(s0)
    12c0:	fd878793          	addi	a5,a5,-40
    12c4:	fcf43023          	sd	a5,-64(s0)
    12c8:	fc043783          	ld	a5,-64(s0)
    12cc:	02878713          	addi	a4,a5,40
    12d0:	649c                	ld	a5,8(s1)
    12d2:	faf71fe3          	bne	a4,a5,1290 <schedule_sjf+0x50>
        }
    }

    if (shortest_job) {
    12d6:	fc843783          	ld	a5,-56(s0)
    12da:	c7a1                	beqz	a5,1322 <schedule_sjf+0xe2>
        int time_to_allocate = shortest_job->remaining_time;
    12dc:	fc843783          	ld	a5,-56(s0)
    12e0:	4fbc                	lw	a5,88(a5)
    12e2:	faf42c23          	sw	a5,-72(s0)
        // Reduce the time slice if an impactful task is arriving sooner
        if (earliest_impactful_time != -1 && earliest_impactful_time < time_to_allocate) {
    12e6:	fb442783          	lw	a5,-76(s0)
    12ea:	0007871b          	sext.w	a4,a5
    12ee:	57fd                	li	a5,-1
    12f0:	00f70e63          	beq	a4,a5,130c <schedule_sjf+0xcc>
    12f4:	fb442703          	lw	a4,-76(s0)
    12f8:	fb842783          	lw	a5,-72(s0)
    12fc:	2701                	sext.w	a4,a4
    12fe:	2781                	sext.w	a5,a5
    1300:	00f75663          	bge	a4,a5,130c <schedule_sjf+0xcc>
            time_to_allocate = earliest_impactful_time;
    1304:	fb442783          	lw	a5,-76(s0)
    1308:	faf42c23          	sw	a5,-72(s0)
        }

        r.scheduled_thread_list_member = &shortest_job->thread_list;
    130c:	fc843783          	ld	a5,-56(s0)
    1310:	02878793          	addi	a5,a5,40
    1314:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = time_to_allocate;
    1318:	fb842783          	lw	a5,-72(s0)
    131c:	f8f42423          	sw	a5,-120(s0)
    1320:	a80d                	j	1352 <schedule_sjf+0x112>
    } else {
        // If no current tasks are ready, wait for the next impactful task
        r.scheduled_thread_list_member = args.run_queue;
    1322:	649c                	ld	a5,8(s1)
    1324:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = earliest_impactful_time != -1 ? earliest_impactful_time : find_next_release_time(args.release_queue, args.current_time);
    1328:	fb442783          	lw	a5,-76(s0)
    132c:	0007871b          	sext.w	a4,a5
    1330:	57fd                	li	a5,-1
    1332:	00f71c63          	bne	a4,a5,134a <schedule_sjf+0x10a>
    1336:	689c                	ld	a5,16(s1)
    1338:	4098                	lw	a4,0(s1)
    133a:	85ba                	mv	a1,a4
    133c:	853e                	mv	a0,a5
    133e:	00000097          	auipc	ra,0x0
    1342:	bac080e7          	jalr	-1108(ra) # eea <find_next_release_time>
    1346:	87aa                	mv	a5,a0
    1348:	a019                	j	134e <schedule_sjf+0x10e>
    134a:	fb442783          	lw	a5,-76(s0)
    134e:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    1352:	f8043783          	ld	a5,-128(s0)
    1356:	f8f43823          	sd	a5,-112(s0)
    135a:	f8843783          	ld	a5,-120(s0)
    135e:	f8f43c23          	sd	a5,-104(s0)
    1362:	4701                	li	a4,0
    1364:	f9043703          	ld	a4,-112(s0)
    1368:	4781                	li	a5,0
    136a:	f9843783          	ld	a5,-104(s0)
    136e:	893a                	mv	s2,a4
    1370:	89be                	mv	s3,a5
    1372:	874a                	mv	a4,s2
    1374:	87ce                	mv	a5,s3
}
    1376:	853a                	mv	a0,a4
    1378:	85be                	mv	a1,a5
    137a:	70e6                	ld	ra,120(sp)
    137c:	7446                	ld	s0,112(sp)
    137e:	74a6                	ld	s1,104(sp)
    1380:	7906                	ld	s2,96(sp)
    1382:	69e6                	ld	s3,88(sp)
    1384:	6109                	addi	sp,sp,128
    1386:	8082                	ret

0000000000001388 <min>:

int min(int a, int b) {
    1388:	1101                	addi	sp,sp,-32
    138a:	ec22                	sd	s0,24(sp)
    138c:	1000                	addi	s0,sp,32
    138e:	87aa                	mv	a5,a0
    1390:	872e                	mv	a4,a1
    1392:	fef42623          	sw	a5,-20(s0)
    1396:	87ba                	mv	a5,a4
    1398:	fef42423          	sw	a5,-24(s0)
    return (a < b) ? a : b;
    139c:	fec42603          	lw	a2,-20(s0)
    13a0:	fe842783          	lw	a5,-24(s0)
    13a4:	0007869b          	sext.w	a3,a5
    13a8:	0006071b          	sext.w	a4,a2
    13ac:	00d75363          	bge	a4,a3,13b2 <min+0x2a>
    13b0:	87b2                	mv	a5,a2
    13b2:	2781                	sext.w	a5,a5
}
    13b4:	853e                	mv	a0,a5
    13b6:	6462                	ld	s0,24(sp)
    13b8:	6105                	addi	sp,sp,32
    13ba:	8082                	ret

00000000000013bc <schedule_lst>:

/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args) {
    13bc:	7115                	addi	sp,sp,-224
    13be:	ed86                	sd	ra,216(sp)
    13c0:	e9a2                	sd	s0,208(sp)
    13c2:	e5a6                	sd	s1,200(sp)
    13c4:	e1ca                	sd	s2,192(sp)
    13c6:	fd4e                	sd	s3,184(sp)
    13c8:	1180                	addi	s0,sp,224
    13ca:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *min_slack_thread = NULL;
    13cc:	fc043423          	sd	zero,-56(s0)
    int min_slack_time = INT_MAX;
    13d0:	800007b7          	lui	a5,0x80000
    13d4:	fff7c793          	not	a5,a5
    13d8:	fcf42223          	sw	a5,-60(s0)
    struct thread *t;

    // Determine the thread with the minimum slack time
    list_for_each_entry(t, args.run_queue, thread_list) {
    13dc:	649c                	ld	a5,8(s1)
    13de:	639c                	ld	a5,0(a5)
    13e0:	f8f43823          	sd	a5,-112(s0)
    13e4:	f9043783          	ld	a5,-112(s0)
    13e8:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffdd20>
    13ec:	faf43c23          	sd	a5,-72(s0)
    13f0:	a069                	j	147a <schedule_lst+0xbe>
        int slack_time = t->current_deadline - args.current_time - t->remaining_time;
    13f2:	fb843783          	ld	a5,-72(s0)
    13f6:	4ff8                	lw	a4,92(a5)
    13f8:	409c                	lw	a5,0(s1)
    13fa:	40f707bb          	subw	a5,a4,a5
    13fe:	0007871b          	sext.w	a4,a5
    1402:	fb843783          	ld	a5,-72(s0)
    1406:	4fbc                	lw	a5,88(a5)
    1408:	40f707bb          	subw	a5,a4,a5
    140c:	f4f42a23          	sw	a5,-172(s0)
        if (slack_time < min_slack_time || (slack_time == min_slack_time && t->ID < (min_slack_thread ? min_slack_thread->ID : INT_MAX))) {
    1410:	f5442703          	lw	a4,-172(s0)
    1414:	fc442783          	lw	a5,-60(s0)
    1418:	2701                	sext.w	a4,a4
    141a:	2781                	sext.w	a5,a5
    141c:	02f74c63          	blt	a4,a5,1454 <schedule_lst+0x98>
    1420:	f5442703          	lw	a4,-172(s0)
    1424:	fc442783          	lw	a5,-60(s0)
    1428:	2701                	sext.w	a4,a4
    142a:	2781                	sext.w	a5,a5
    142c:	02f71c63          	bne	a4,a5,1464 <schedule_lst+0xa8>
    1430:	fb843783          	ld	a5,-72(s0)
    1434:	5fd4                	lw	a3,60(a5)
    1436:	fc843783          	ld	a5,-56(s0)
    143a:	c789                	beqz	a5,1444 <schedule_lst+0x88>
    143c:	fc843783          	ld	a5,-56(s0)
    1440:	5fdc                	lw	a5,60(a5)
    1442:	a029                	j	144c <schedule_lst+0x90>
    1444:	800007b7          	lui	a5,0x80000
    1448:	fff7c793          	not	a5,a5
    144c:	873e                	mv	a4,a5
    144e:	87b6                	mv	a5,a3
    1450:	00e7da63          	bge	a5,a4,1464 <schedule_lst+0xa8>
            min_slack_thread = t;
    1454:	fb843783          	ld	a5,-72(s0)
    1458:	fcf43423          	sd	a5,-56(s0)
            min_slack_time = slack_time;
    145c:	f5442783          	lw	a5,-172(s0)
    1460:	fcf42223          	sw	a5,-60(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    1464:	fb843783          	ld	a5,-72(s0)
    1468:	779c                	ld	a5,40(a5)
    146a:	f4f43423          	sd	a5,-184(s0)
    146e:	f4843783          	ld	a5,-184(s0)
    1472:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffdd20>
    1476:	faf43c23          	sd	a5,-72(s0)
    147a:	fb843783          	ld	a5,-72(s0)
    147e:	02878713          	addi	a4,a5,40
    1482:	649c                	ld	a5,8(s1)
    1484:	f6f717e3          	bne	a4,a5,13f2 <schedule_lst+0x36>
        }
    }
    //printf("id %d, cur ddl %d, ddl,cur time %d, rem time %d, slack time %d\n", min_slack_thread->ID, min_slack_thread->current_deadline, args.current_time, min_slack_thread->remaining_time, min_slack_time);

    // Calculate the next event time, initially very large
    int next_significant_event_time = INT_MAX;
    1488:	800007b7          	lui	a5,0x80000
    148c:	fff7c793          	not	a5,a5
    1490:	faf42a23          	sw	a5,-76(s0)
    // Analyze each upcoming release to determine if and when they should preempt the current thread
    struct release_queue_entry *entry;
    list_for_each_entry(entry, args.release_queue, thread_list) {
    1494:	689c                	ld	a5,16(s1)
    1496:	639c                	ld	a5,0(a5)
    1498:	f8f43423          	sd	a5,-120(s0)
    149c:	f8843783          	ld	a5,-120(s0)
    14a0:	17e1                	addi	a5,a5,-8
    14a2:	faf43423          	sd	a5,-88(s0)
    14a6:	a0f1                	j	1572 <schedule_lst+0x1b6>
        if (entry->release_time > args.current_time) {
    14a8:	fa843783          	ld	a5,-88(s0)
    14ac:	4f98                	lw	a4,24(a5)
    14ae:	409c                	lw	a5,0(s1)
    14b0:	0ae7d763          	bge	a5,a4,155e <schedule_lst+0x1a2>
            struct thread *upcoming_thread = entry->thrd;
    14b4:	fa843783          	ld	a5,-88(s0)
    14b8:	639c                	ld	a5,0(a5)
    14ba:	f6f43423          	sd	a5,-152(s0)

            //printf("upcoming_thread->ID: %d ddl: %d release_time: %d remaining_time: %d\n", upcoming_thread->ID, upcoming_thread->current_deadline, entry->release_time, upcoming_thread->remaining_time);
            int upcoming_slack_time = upcoming_thread->current_deadline - entry->release_time - upcoming_thread->processing_time;
    14be:	f6843783          	ld	a5,-152(s0)
    14c2:	4ff8                	lw	a4,92(a5)
    14c4:	fa843783          	ld	a5,-88(s0)
    14c8:	4f9c                	lw	a5,24(a5)
    14ca:	40f707bb          	subw	a5,a4,a5
    14ce:	0007871b          	sext.w	a4,a5
    14d2:	f6843783          	ld	a5,-152(s0)
    14d6:	43fc                	lw	a5,68(a5)
    14d8:	40f707bb          	subw	a5,a4,a5
    14dc:	f6f42223          	sw	a5,-156(s0)
            // Check if this upcoming thread will impose an earlier preemption due to tighter slack time
            if (upcoming_slack_time < min_slack_time) {
    14e0:	f6442703          	lw	a4,-156(s0)
    14e4:	fc442783          	lw	a5,-60(s0)
    14e8:	2701                	sext.w	a4,a4
    14ea:	2781                	sext.w	a5,a5
    14ec:	02f75163          	bge	a4,a5,150e <schedule_lst+0x152>
                next_significant_event_time = min(next_significant_event_time, entry->release_time);
    14f0:	fa843783          	ld	a5,-88(s0)
    14f4:	4f98                	lw	a4,24(a5)
    14f6:	fb442783          	lw	a5,-76(s0)
    14fa:	85ba                	mv	a1,a4
    14fc:	853e                	mv	a0,a5
    14fe:	00000097          	auipc	ra,0x0
    1502:	e8a080e7          	jalr	-374(ra) # 1388 <min>
    1506:	87aa                	mv	a5,a0
    1508:	faf42a23          	sw	a5,-76(s0)
    150c:	a889                	j	155e <schedule_lst+0x1a2>
            } else if (upcoming_slack_time == min_slack_time && upcoming_thread->ID < (min_slack_thread ? min_slack_thread->ID : INT_MAX))
    150e:	f6442703          	lw	a4,-156(s0)
    1512:	fc442783          	lw	a5,-60(s0)
    1516:	2701                	sext.w	a4,a4
    1518:	2781                	sext.w	a5,a5
    151a:	04f71263          	bne	a4,a5,155e <schedule_lst+0x1a2>
    151e:	f6843783          	ld	a5,-152(s0)
    1522:	5fd4                	lw	a3,60(a5)
    1524:	fc843783          	ld	a5,-56(s0)
    1528:	c789                	beqz	a5,1532 <schedule_lst+0x176>
    152a:	fc843783          	ld	a5,-56(s0)
    152e:	5fdc                	lw	a5,60(a5)
    1530:	a029                	j	153a <schedule_lst+0x17e>
    1532:	800007b7          	lui	a5,0x80000
    1536:	fff7c793          	not	a5,a5
    153a:	873e                	mv	a4,a5
    153c:	87b6                	mv	a5,a3
    153e:	02e7d063          	bge	a5,a4,155e <schedule_lst+0x1a2>
                next_significant_event_time = min(next_significant_event_time, entry->release_time);
    1542:	fa843783          	ld	a5,-88(s0)
    1546:	4f98                	lw	a4,24(a5)
    1548:	fb442783          	lw	a5,-76(s0)
    154c:	85ba                	mv	a1,a4
    154e:	853e                	mv	a0,a5
    1550:	00000097          	auipc	ra,0x0
    1554:	e38080e7          	jalr	-456(ra) # 1388 <min>
    1558:	87aa                	mv	a5,a0
    155a:	faf42a23          	sw	a5,-76(s0)
    list_for_each_entry(entry, args.release_queue, thread_list) {
    155e:	fa843783          	ld	a5,-88(s0)
    1562:	679c                	ld	a5,8(a5)
    1564:	f4f43c23          	sd	a5,-168(s0)
    1568:	f5843783          	ld	a5,-168(s0)
    156c:	17e1                	addi	a5,a5,-8
    156e:	faf43423          	sd	a5,-88(s0)
    1572:	fa843783          	ld	a5,-88(s0)
    1576:	00878713          	addi	a4,a5,8 # ffffffff80000008 <__global_pointer$+0xffffffff7fffdd50>
    157a:	689c                	ld	a5,16(s1)
    157c:	f2f716e3          	bne	a4,a5,14a8 <schedule_lst+0xec>
        }
    }

    // Decide the allocated time based on current minimum slack or upcoming preemption needs
    if (min_slack_thread) {
    1580:	fc843783          	ld	a5,-56(s0)
    1584:	10078b63          	beqz	a5,169a <schedule_lst+0x2de>
        // Check if the thread has missed its deadline
        if (args.current_time >= min_slack_thread->current_deadline && min_slack_thread->remaining_time > 0) {
    1588:	4098                	lw	a4,0(s1)
    158a:	fc843783          	ld	a5,-56(s0)
    158e:	4ffc                	lw	a5,92(a5)
    1590:	08f74863          	blt	a4,a5,1620 <schedule_lst+0x264>
    1594:	fc843783          	ld	a5,-56(s0)
    1598:	4fbc                	lw	a5,88(a5)
    159a:	08f05363          	blez	a5,1620 <schedule_lst+0x264>
            struct thread *thread_with_smallest_id = min_slack_thread;
    159e:	fc843783          	ld	a5,-56(s0)
    15a2:	faf43023          	sd	a5,-96(s0)
            // Iterate again to find if there are other threads that also missed their deadlines and have smaller IDs
            list_for_each_entry(t, args.run_queue, thread_list) {
    15a6:	649c                	ld	a5,8(s1)
    15a8:	639c                	ld	a5,0(a5)
    15aa:	f8f43023          	sd	a5,-128(s0)
    15ae:	f8043783          	ld	a5,-128(s0)
    15b2:	fd878793          	addi	a5,a5,-40
    15b6:	faf43c23          	sd	a5,-72(s0)
    15ba:	a099                	j	1600 <schedule_lst+0x244>
                if (args.current_time >= t->current_deadline && t->remaining_time > 0 && t->ID < thread_with_smallest_id->ID) {
    15bc:	4098                	lw	a4,0(s1)
    15be:	fb843783          	ld	a5,-72(s0)
    15c2:	4ffc                	lw	a5,92(a5)
    15c4:	02f74363          	blt	a4,a5,15ea <schedule_lst+0x22e>
    15c8:	fb843783          	ld	a5,-72(s0)
    15cc:	4fbc                	lw	a5,88(a5)
    15ce:	00f05e63          	blez	a5,15ea <schedule_lst+0x22e>
    15d2:	fb843783          	ld	a5,-72(s0)
    15d6:	5fd8                	lw	a4,60(a5)
    15d8:	fa043783          	ld	a5,-96(s0)
    15dc:	5fdc                	lw	a5,60(a5)
    15de:	00f75663          	bge	a4,a5,15ea <schedule_lst+0x22e>
                    thread_with_smallest_id = t;
    15e2:	fb843783          	ld	a5,-72(s0)
    15e6:	faf43023          	sd	a5,-96(s0)
            list_for_each_entry(t, args.run_queue, thread_list) {
    15ea:	fb843783          	ld	a5,-72(s0)
    15ee:	779c                	ld	a5,40(a5)
    15f0:	f6f43c23          	sd	a5,-136(s0)
    15f4:	f7843783          	ld	a5,-136(s0)
    15f8:	fd878793          	addi	a5,a5,-40
    15fc:	faf43c23          	sd	a5,-72(s0)
    1600:	fb843783          	ld	a5,-72(s0)
    1604:	02878713          	addi	a4,a5,40
    1608:	649c                	ld	a5,8(s1)
    160a:	faf719e3          	bne	a4,a5,15bc <schedule_lst+0x200>
                }
            }
            r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
    160e:	fa043783          	ld	a5,-96(s0)
    1612:	02878793          	addi	a5,a5,40
    1616:	f2f43423          	sd	a5,-216(s0)
            r.allocated_time = 0;
    161a:	f2042823          	sw	zero,-208(s0)
        if (args.current_time >= min_slack_thread->current_deadline && min_slack_thread->remaining_time > 0) {
    161e:	a86d                	j	16d8 <schedule_lst+0x31c>
        } else {
            // Calculate time until the thread's deadline
            int time_until_deadline = min_slack_thread->current_deadline - args.current_time;
    1620:	fc843783          	ld	a5,-56(s0)
    1624:	4ff8                	lw	a4,92(a5)
    1626:	409c                	lw	a5,0(s1)
    1628:	40f707bb          	subw	a5,a4,a5
    162c:	f6f42a23          	sw	a5,-140(s0)
            
            // Decide the allocated time based on current minimum slack or upcoming preemption needs
            int allocated_time = min(min_slack_thread->remaining_time, time_until_deadline);
    1630:	fc843783          	ld	a5,-56(s0)
    1634:	4fbc                	lw	a5,88(a5)
    1636:	f7442703          	lw	a4,-140(s0)
    163a:	85ba                	mv	a1,a4
    163c:	853e                	mv	a0,a5
    163e:	00000097          	auipc	ra,0x0
    1642:	d4a080e7          	jalr	-694(ra) # 1388 <min>
    1646:	87aa                	mv	a5,a0
    1648:	f8f42e23          	sw	a5,-100(s0)
            if (next_significant_event_time != INT_MAX) {
    164c:	fb442783          	lw	a5,-76(s0)
    1650:	0007871b          	sext.w	a4,a5
    1654:	800007b7          	lui	a5,0x80000
    1658:	fff7c793          	not	a5,a5
    165c:	02f70463          	beq	a4,a5,1684 <schedule_lst+0x2c8>
                allocated_time = min(allocated_time, next_significant_event_time - args.current_time);
    1660:	409c                	lw	a5,0(s1)
    1662:	fb442703          	lw	a4,-76(s0)
    1666:	40f707bb          	subw	a5,a4,a5
    166a:	0007871b          	sext.w	a4,a5
    166e:	f9c42783          	lw	a5,-100(s0)
    1672:	85ba                	mv	a1,a4
    1674:	853e                	mv	a0,a5
    1676:	00000097          	auipc	ra,0x0
    167a:	d12080e7          	jalr	-750(ra) # 1388 <min>
    167e:	87aa                	mv	a5,a0
    1680:	f8f42e23          	sw	a5,-100(s0)
            }

            r.scheduled_thread_list_member = &min_slack_thread->thread_list;
    1684:	fc843783          	ld	a5,-56(s0)
    1688:	02878793          	addi	a5,a5,40 # ffffffff80000028 <__global_pointer$+0xffffffff7fffdd70>
    168c:	f2f43423          	sd	a5,-216(s0)
            r.allocated_time = allocated_time;
    1690:	f9c42783          	lw	a5,-100(s0)
    1694:	f2f42823          	sw	a5,-208(s0)
    1698:	a081                	j	16d8 <schedule_lst+0x31c>
        }
    } else {
        // No runnable threads, prepare to sleep or wait based on next known event
        r.scheduled_thread_list_member = args.run_queue;
    169a:	649c                	ld	a5,8(s1)
    169c:	f2f43423          	sd	a5,-216(s0)
        r.allocated_time = next_significant_event_time != INT_MAX ? next_significant_event_time - args.current_time : find_next_release_time(args.release_queue, args.current_time);
    16a0:	fb442783          	lw	a5,-76(s0)
    16a4:	0007871b          	sext.w	a4,a5
    16a8:	800007b7          	lui	a5,0x80000
    16ac:	fff7c793          	not	a5,a5
    16b0:	00f70963          	beq	a4,a5,16c2 <schedule_lst+0x306>
    16b4:	409c                	lw	a5,0(s1)
    16b6:	fb442703          	lw	a4,-76(s0)
    16ba:	40f707bb          	subw	a5,a4,a5
    16be:	2781                	sext.w	a5,a5
    16c0:	a811                	j	16d4 <schedule_lst+0x318>
    16c2:	689c                	ld	a5,16(s1)
    16c4:	4098                	lw	a4,0(s1)
    16c6:	85ba                	mv	a1,a4
    16c8:	853e                	mv	a0,a5
    16ca:	00000097          	auipc	ra,0x0
    16ce:	820080e7          	jalr	-2016(ra) # eea <find_next_release_time>
    16d2:	87aa                	mv	a5,a0
    16d4:	f2f42823          	sw	a5,-208(s0)
    }

    return r;
    16d8:	f2843783          	ld	a5,-216(s0)
    16dc:	f2f43c23          	sd	a5,-200(s0)
    16e0:	f3043783          	ld	a5,-208(s0)
    16e4:	f4f43023          	sd	a5,-192(s0)
    16e8:	4701                	li	a4,0
    16ea:	f3843703          	ld	a4,-200(s0)
    16ee:	4781                	li	a5,0
    16f0:	f4043783          	ld	a5,-192(s0)
    16f4:	893a                	mv	s2,a4
    16f6:	89be                	mv	s3,a5
    16f8:	874a                	mv	a4,s2
    16fa:	87ce                	mv	a5,s3
}
    16fc:	853a                	mv	a0,a4
    16fe:	85be                	mv	a1,a5
    1700:	60ee                	ld	ra,216(sp)
    1702:	644e                	ld	s0,208(sp)
    1704:	64ae                	ld	s1,200(sp)
    1706:	690e                	ld	s2,192(sp)
    1708:	79ea                	ld	s3,184(sp)
    170a:	612d                	addi	sp,sp,224
    170c:	8082                	ret

000000000000170e <find_earliest_impactful_release_time_dm>:
typedef struct {
    int earliest_impactful_event;
    struct thread *thread;
} ImpactfulEvent;

ImpactfulEvent find_earliest_impactful_release_time_dm(struct list_head *release_queue, struct list_head*run_queue, int current_time, int current_period, int current_thread_ID) {
    170e:	7119                	addi	sp,sp,-128
    1710:	fca2                	sd	s0,120(sp)
    1712:	0100                	addi	s0,sp,128
    1714:	f8a43c23          	sd	a0,-104(s0)
    1718:	f8b43823          	sd	a1,-112(s0)
    171c:	87b2                	mv	a5,a2
    171e:	f8f42623          	sw	a5,-116(s0)
    1722:	87b6                	mv	a5,a3
    1724:	f8f42423          	sw	a5,-120(s0)
    1728:	87ba                	mv	a5,a4
    172a:	f8f42223          	sw	a5,-124(s0)
    struct release_queue_entry *entry;
    struct thread *t;
    int earliest_impactful_event = INT_MAX;
    172e:	800007b7          	lui	a5,0x80000
    1732:	fff7c793          	not	a5,a5
    1736:	fcf42e23          	sw	a5,-36(s0)
    int earliest_impactful_thread_ID = current_thread_ID;    
    173a:	f8442783          	lw	a5,-124(s0)
    173e:	fcf42c23          	sw	a5,-40(s0)
    
    // Look for the smallest deadline that is less than the current task's deadline
    list_for_each_entry(entry, release_queue, thread_list) {
    1742:	f9843783          	ld	a5,-104(s0)
    1746:	639c                	ld	a5,0(a5)
    1748:	fcf43823          	sd	a5,-48(s0)
    174c:	fd043783          	ld	a5,-48(s0)
    1750:	17e1                	addi	a5,a5,-8
    1752:	fef43423          	sd	a5,-24(s0)
    1756:	a0f9                	j	1824 <find_earliest_impactful_release_time_dm+0x116>
        if (entry->release_time > current_time && entry->thrd->period < current_period) {
    1758:	fe843783          	ld	a5,-24(s0)
    175c:	4f98                	lw	a4,24(a5)
    175e:	f8c42783          	lw	a5,-116(s0)
    1762:	2781                	sext.w	a5,a5
    1764:	04e7d463          	bge	a5,a4,17ac <find_earliest_impactful_release_time_dm+0x9e>
    1768:	fe843783          	ld	a5,-24(s0)
    176c:	639c                	ld	a5,0(a5)
    176e:	4bb8                	lw	a4,80(a5)
    1770:	f8842783          	lw	a5,-120(s0)
    1774:	2781                	sext.w	a5,a5
    1776:	02f75b63          	bge	a4,a5,17ac <find_earliest_impactful_release_time_dm+0x9e>
            if (entry->release_time < earliest_impactful_event) {
    177a:	fe843783          	ld	a5,-24(s0)
    177e:	4f98                	lw	a4,24(a5)
    1780:	fdc42783          	lw	a5,-36(s0)
    1784:	2781                	sext.w	a5,a5
    1786:	08f75563          	bge	a4,a5,1810 <find_earliest_impactful_release_time_dm+0x102>
                earliest_impactful_event = entry->release_time;
    178a:	fe843783          	ld	a5,-24(s0)
    178e:	4f9c                	lw	a5,24(a5)
    1790:	fcf42e23          	sw	a5,-36(s0)
                t = entry->thrd;
    1794:	fe843783          	ld	a5,-24(s0)
    1798:	639c                	ld	a5,0(a5)
    179a:	fef43023          	sd	a5,-32(s0)
                earliest_impactful_thread_ID = entry->thrd->ID;
    179e:	fe843783          	ld	a5,-24(s0)
    17a2:	639c                	ld	a5,0(a5)
    17a4:	5fdc                	lw	a5,60(a5)
    17a6:	fcf42c23          	sw	a5,-40(s0)
            if (entry->release_time < earliest_impactful_event) {
    17aa:	a09d                	j	1810 <find_earliest_impactful_release_time_dm+0x102>
            }
        } 
        else if (entry->release_time > current_time && entry->thrd->period == current_period) {
    17ac:	fe843783          	ld	a5,-24(s0)
    17b0:	4f98                	lw	a4,24(a5)
    17b2:	f8c42783          	lw	a5,-116(s0)
    17b6:	2781                	sext.w	a5,a5
    17b8:	04e7dc63          	bge	a5,a4,1810 <find_earliest_impactful_release_time_dm+0x102>
    17bc:	fe843783          	ld	a5,-24(s0)
    17c0:	639c                	ld	a5,0(a5)
    17c2:	4bb8                	lw	a4,80(a5)
    17c4:	f8842783          	lw	a5,-120(s0)
    17c8:	2781                	sext.w	a5,a5
    17ca:	04e79363          	bne	a5,a4,1810 <find_earliest_impactful_release_time_dm+0x102>
            //printf("ID %d, entry release time: %d\n", entry->thrd->ID, entry->release_time);
            // or the smallest deadline that is equal to the current task's deadline but has a smaller ID
            if (entry->release_time <= earliest_impactful_event && entry->thrd->ID < earliest_impactful_thread_ID) {
    17ce:	fe843783          	ld	a5,-24(s0)
    17d2:	4f98                	lw	a4,24(a5)
    17d4:	fdc42783          	lw	a5,-36(s0)
    17d8:	2781                	sext.w	a5,a5
    17da:	02e7cb63          	blt	a5,a4,1810 <find_earliest_impactful_release_time_dm+0x102>
    17de:	fe843783          	ld	a5,-24(s0)
    17e2:	639c                	ld	a5,0(a5)
    17e4:	5fd8                	lw	a4,60(a5)
    17e6:	fd842783          	lw	a5,-40(s0)
    17ea:	2781                	sext.w	a5,a5
    17ec:	02f75263          	bge	a4,a5,1810 <find_earliest_impactful_release_time_dm+0x102>
                earliest_impactful_event = entry->release_time;
    17f0:	fe843783          	ld	a5,-24(s0)
    17f4:	4f9c                	lw	a5,24(a5)
    17f6:	fcf42e23          	sw	a5,-36(s0)
                t = entry->thrd;
    17fa:	fe843783          	ld	a5,-24(s0)
    17fe:	639c                	ld	a5,0(a5)
    1800:	fef43023          	sd	a5,-32(s0)
                earliest_impactful_thread_ID = entry->thrd->ID;
    1804:	fe843783          	ld	a5,-24(s0)
    1808:	639c                	ld	a5,0(a5)
    180a:	5fdc                	lw	a5,60(a5)
    180c:	fcf42c23          	sw	a5,-40(s0)
    list_for_each_entry(entry, release_queue, thread_list) {
    1810:	fe843783          	ld	a5,-24(s0)
    1814:	679c                	ld	a5,8(a5)
    1816:	fcf43423          	sd	a5,-56(s0)
    181a:	fc843783          	ld	a5,-56(s0)
    181e:	17e1                	addi	a5,a5,-8
    1820:	fef43423          	sd	a5,-24(s0)
    1824:	fe843783          	ld	a5,-24(s0)
    1828:	07a1                	addi	a5,a5,8
    182a:	f9843703          	ld	a4,-104(s0)
    182e:	f2f715e3          	bne	a4,a5,1758 <find_earliest_impactful_release_time_dm+0x4a>
            }
        }
    }
    //printf("earliest_impactful_event: %d\n", earliest_impactful_event);
    // If a task is found that might preempt the current task, determine when it will happen
    earliest_impactful_event = earliest_impactful_event == INT_MAX ? -1 : earliest_impactful_event;
    1832:	fdc42783          	lw	a5,-36(s0)
    1836:	0007871b          	sext.w	a4,a5
    183a:	800007b7          	lui	a5,0x80000
    183e:	fff7c793          	not	a5,a5
    1842:	00f70563          	beq	a4,a5,184c <find_earliest_impactful_release_time_dm+0x13e>
    1846:	fdc42783          	lw	a5,-36(s0)
    184a:	a011                	j	184e <find_earliest_impactful_release_time_dm+0x140>
    184c:	57fd                	li	a5,-1
    184e:	fcf42e23          	sw	a5,-36(s0)
    return (ImpactfulEvent) {earliest_impactful_event, t};
    1852:	fdc42783          	lw	a5,-36(s0)
    1856:	faf42c23          	sw	a5,-72(s0)
    185a:	fe043783          	ld	a5,-32(s0)
    185e:	fcf43023          	sd	a5,-64(s0)
    1862:	4701                	li	a4,0
    1864:	fb843703          	ld	a4,-72(s0)
    1868:	4781                	li	a5,0
    186a:	fc043783          	ld	a5,-64(s0)
    186e:	883a                	mv	a6,a4
    1870:	88be                	mv	a7,a5
    1872:	8742                	mv	a4,a6
    1874:	87c6                	mv	a5,a7
}
    1876:	853a                	mv	a0,a4
    1878:	85be                	mv	a1,a5
    187a:	7466                	ld	s0,120(sp)
    187c:	6109                	addi	sp,sp,128
    187e:	8082                	ret

0000000000001880 <schedule_dm>:


struct threads_sched_result schedule_dm(struct threads_sched_args args) {
    1880:	7135                	addi	sp,sp,-160
    1882:	ed06                	sd	ra,152(sp)
    1884:	e922                	sd	s0,144(sp)
    1886:	e526                	sd	s1,136(sp)
    1888:	e14a                	sd	s2,128(sp)
    188a:	fcce                	sd	s3,120(sp)
    188c:	1100                	addi	s0,sp,160
    188e:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *earliest_deadline_thread = NULL;
    1890:	fc043423          	sd	zero,-56(s0)
    struct thread *t;
    int earliest_deadline = INT_MAX;
    1894:	800007b7          	lui	a5,0x80000
    1898:	fff7c793          	not	a5,a5
    189c:	faf42e23          	sw	a5,-68(s0)
    int earliest_impactful_deadline; 
    
    // Determine the earliest deadline among current tasks
    list_for_each_entry(t, args.run_queue, thread_list) {
    18a0:	649c                	ld	a5,8(s1)
    18a2:	639c                	ld	a5,0(a5)
    18a4:	faf43823          	sd	a5,-80(s0)
    18a8:	fb043783          	ld	a5,-80(s0)
    18ac:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffdd20>
    18b0:	fcf43023          	sd	a5,-64(s0)
    18b4:	a8bd                	j	1932 <schedule_dm+0xb2>
        if (t->is_real_time && t->period < earliest_deadline) {
    18b6:	fc043783          	ld	a5,-64(s0)
    18ba:	43bc                	lw	a5,64(a5)
    18bc:	c39d                	beqz	a5,18e2 <schedule_dm+0x62>
    18be:	fc043783          	ld	a5,-64(s0)
    18c2:	4bb8                	lw	a4,80(a5)
    18c4:	fbc42783          	lw	a5,-68(s0)
    18c8:	2781                	sext.w	a5,a5
    18ca:	00f75c63          	bge	a4,a5,18e2 <schedule_dm+0x62>
            earliest_deadline_thread = t;
    18ce:	fc043783          	ld	a5,-64(s0)
    18d2:	fcf43423          	sd	a5,-56(s0)
            earliest_deadline = t->period;
    18d6:	fc043783          	ld	a5,-64(s0)
    18da:	4bbc                	lw	a5,80(a5)
    18dc:	faf42e23          	sw	a5,-68(s0)
    18e0:	a835                	j	191c <schedule_dm+0x9c>
        } else if (t->is_real_time && t->period == earliest_deadline && t->ID < earliest_deadline_thread->ID) {
    18e2:	fc043783          	ld	a5,-64(s0)
    18e6:	43bc                	lw	a5,64(a5)
    18e8:	cb95                	beqz	a5,191c <schedule_dm+0x9c>
    18ea:	fc043783          	ld	a5,-64(s0)
    18ee:	4bb8                	lw	a4,80(a5)
    18f0:	fbc42783          	lw	a5,-68(s0)
    18f4:	2781                	sext.w	a5,a5
    18f6:	02e79363          	bne	a5,a4,191c <schedule_dm+0x9c>
    18fa:	fc043783          	ld	a5,-64(s0)
    18fe:	5fd8                	lw	a4,60(a5)
    1900:	fc843783          	ld	a5,-56(s0)
    1904:	5fdc                	lw	a5,60(a5)
    1906:	00f75b63          	bge	a4,a5,191c <schedule_dm+0x9c>
            earliest_deadline_thread = t;
    190a:	fc043783          	ld	a5,-64(s0)
    190e:	fcf43423          	sd	a5,-56(s0)
            earliest_deadline = t->period;
    1912:	fc043783          	ld	a5,-64(s0)
    1916:	4bbc                	lw	a5,80(a5)
    1918:	faf42e23          	sw	a5,-68(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    191c:	fc043783          	ld	a5,-64(s0)
    1920:	779c                	ld	a5,40(a5)
    1922:	f8f43c23          	sd	a5,-104(s0)
    1926:	f9843783          	ld	a5,-104(s0)
    192a:	fd878793          	addi	a5,a5,-40
    192e:	fcf43023          	sd	a5,-64(s0)
    1932:	fc043783          	ld	a5,-64(s0)
    1936:	02878713          	addi	a4,a5,40
    193a:	649c                	ld	a5,8(s1)
    193c:	f6f71de3          	bne	a4,a5,18b6 <schedule_dm+0x36>
        }
    }

    // Find the earliest impactful deadline from other tasks
    ImpactfulEvent earliest_impactful_event = find_earliest_impactful_release_time_dm(args.release_queue, args.run_queue, args.current_time, earliest_deadline_thread ? earliest_deadline_thread->period : INT_MAX, earliest_deadline_thread->ID);
    1940:	6888                	ld	a0,16(s1)
    1942:	648c                	ld	a1,8(s1)
    1944:	4090                	lw	a2,0(s1)
    1946:	fc843783          	ld	a5,-56(s0)
    194a:	c789                	beqz	a5,1954 <schedule_dm+0xd4>
    194c:	fc843783          	ld	a5,-56(s0)
    1950:	4bbc                	lw	a5,80(a5)
    1952:	a029                	j	195c <schedule_dm+0xdc>
    1954:	800007b7          	lui	a5,0x80000
    1958:	fff7c793          	not	a5,a5
    195c:	fc843703          	ld	a4,-56(s0)
    1960:	5f58                	lw	a4,60(a4)
    1962:	86be                	mv	a3,a5
    1964:	00000097          	auipc	ra,0x0
    1968:	daa080e7          	jalr	-598(ra) # 170e <find_earliest_impactful_release_time_dm>
    196c:	872a                	mv	a4,a0
    196e:	87ae                	mv	a5,a1
    1970:	f6e43423          	sd	a4,-152(s0)
    1974:	f6f43823          	sd	a5,-144(s0)
    earliest_impactful_deadline = earliest_impactful_event.earliest_impactful_event;
    1978:	f6842783          	lw	a5,-152(s0)
    197c:	faf42623          	sw	a5,-84(s0)
    //printf("earliest_impactful_deadline: %d\n", earliest_impactful_deadline);
    if (earliest_deadline_thread) {
    1980:	fc843783          	ld	a5,-56(s0)
    1984:	cfd9                	beqz	a5,1a22 <schedule_dm+0x1a2>
        int time_to_deadline = earliest_deadline_thread->current_deadline - args.current_time;
    1986:	fc843783          	ld	a5,-56(s0)
    198a:	4ff8                	lw	a4,92(a5)
    198c:	409c                	lw	a5,0(s1)
    198e:	40f707bb          	subw	a5,a4,a5
    1992:	faf42423          	sw	a5,-88(s0)
        
        // If the thread is already past its deadline, allocate no time (handle deadline miss)
        if (time_to_deadline <= 0) {
    1996:	fa842783          	lw	a5,-88(s0)
    199a:	2781                	sext.w	a5,a5
    199c:	00f04b63          	bgtz	a5,19b2 <schedule_dm+0x132>
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    19a0:	fc843783          	ld	a5,-56(s0)
    19a4:	02878793          	addi	a5,a5,40 # ffffffff80000028 <__global_pointer$+0xffffffff7fffdd70>
    19a8:	f6f43c23          	sd	a5,-136(s0)
            r.allocated_time = 0;
    19ac:	f8042023          	sw	zero,-128(s0)
    19b0:	a079                	j	1a3e <schedule_dm+0x1be>
        } else {
            // Allocate time based on the smallest of the task's remaining time or the next impactful deadline
            int remaining_time = min(earliest_deadline_thread->remaining_time, time_to_deadline);
    19b2:	fc843783          	ld	a5,-56(s0)
    19b6:	4fbc                	lw	a5,88(a5)
    19b8:	fa842703          	lw	a4,-88(s0)
    19bc:	85ba                	mv	a1,a4
    19be:	853e                	mv	a0,a5
    19c0:	00000097          	auipc	ra,0x0
    19c4:	9c8080e7          	jalr	-1592(ra) # 1388 <min>
    19c8:	87aa                	mv	a5,a0
    19ca:	faf42223          	sw	a5,-92(s0)
            int allocated_time;
            if (earliest_impactful_deadline != -1 && (earliest_impactful_deadline - args.current_time) < remaining_time){
    19ce:	fac42783          	lw	a5,-84(s0)
    19d2:	0007871b          	sext.w	a4,a5
    19d6:	57fd                	li	a5,-1
    19d8:	02f70663          	beq	a4,a5,1a04 <schedule_dm+0x184>
    19dc:	409c                	lw	a5,0(s1)
    19de:	fac42703          	lw	a4,-84(s0)
    19e2:	40f707bb          	subw	a5,a4,a5
    19e6:	0007871b          	sext.w	a4,a5
    19ea:	fa442783          	lw	a5,-92(s0)
    19ee:	2781                	sext.w	a5,a5
    19f0:	00f75a63          	bge	a4,a5,1a04 <schedule_dm+0x184>
                allocated_time = earliest_impactful_deadline - args.current_time;
    19f4:	409c                	lw	a5,0(s1)
    19f6:	fac42703          	lw	a4,-84(s0)
    19fa:	40f707bb          	subw	a5,a4,a5
    19fe:	faf42c23          	sw	a5,-72(s0)
    1a02:	a029                	j	1a0c <schedule_dm+0x18c>
            } else {
                allocated_time = remaining_time;
    1a04:	fa442783          	lw	a5,-92(s0)
    1a08:	faf42c23          	sw	a5,-72(s0)
            }
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    1a0c:	fc843783          	ld	a5,-56(s0)
    1a10:	02878793          	addi	a5,a5,40
    1a14:	f6f43c23          	sd	a5,-136(s0)
            r.allocated_time = allocated_time;
    1a18:	fb842783          	lw	a5,-72(s0)
    1a1c:	f8f42023          	sw	a5,-128(s0)
    1a20:	a839                	j	1a3e <schedule_dm+0x1be>
        }
    } else {
        // If no immediate tasks, schedule the next possible task
        r.scheduled_thread_list_member = args.run_queue;
    1a22:	649c                	ld	a5,8(s1)
    1a24:	f6f43c23          	sd	a5,-136(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    1a28:	689c                	ld	a5,16(s1)
    1a2a:	4098                	lw	a4,0(s1)
    1a2c:	85ba                	mv	a1,a4
    1a2e:	853e                	mv	a0,a5
    1a30:	fffff097          	auipc	ra,0xfffff
    1a34:	4ba080e7          	jalr	1210(ra) # eea <find_next_release_time>
    1a38:	87aa                	mv	a5,a0
    1a3a:	f8f42023          	sw	a5,-128(s0)
    }

    return r;
    1a3e:	f7843783          	ld	a5,-136(s0)
    1a42:	f8f43423          	sd	a5,-120(s0)
    1a46:	f8043783          	ld	a5,-128(s0)
    1a4a:	f8f43823          	sd	a5,-112(s0)
    1a4e:	4701                	li	a4,0
    1a50:	f8843703          	ld	a4,-120(s0)
    1a54:	4781                	li	a5,0
    1a56:	f9043783          	ld	a5,-112(s0)
    1a5a:	893a                	mv	s2,a4
    1a5c:	89be                	mv	s3,a5
    1a5e:	874a                	mv	a4,s2
    1a60:	87ce                	mv	a5,s3
}
    1a62:	853a                	mv	a0,a4
    1a64:	85be                	mv	a1,a5
    1a66:	60ea                	ld	ra,152(sp)
    1a68:	644a                	ld	s0,144(sp)
    1a6a:	64aa                	ld	s1,136(sp)
    1a6c:	690a                	ld	s2,128(sp)
    1a6e:	79e6                	ld	s3,120(sp)
    1a70:	610d                	addi	sp,sp,160
    1a72:	8082                	ret
