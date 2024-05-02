
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
      20:	00001597          	auipc	a1,0x1
      24:	67858593          	addi	a1,a1,1656 # 1698 <schedule_dm+0x20e>
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
      72:	00001597          	auipc	a1,0x1
      76:	63e58593          	addi	a1,a1,1598 # 16b0 <schedule_dm+0x226>
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
     6a2:	03a68693          	addi	a3,a3,58 # 16d8 <digits>
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
     77c:	f6070713          	addi	a4,a4,-160 # 16d8 <digits>
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
     93c:	d9878793          	addi	a5,a5,-616 # 16d0 <schedule_dm+0x246>
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
     ae8:	c1c78793          	addi	a5,a5,-996 # 1700 <freep>
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
     be0:	b2478793          	addi	a5,a5,-1244 # 1700 <freep>
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
     c62:	aa278793          	addi	a5,a5,-1374 # 1700 <freep>
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
     c94:	a7078793          	addi	a5,a5,-1424 # 1700 <freep>
     c98:	639c                	ld	a5,0(a5)
     c9a:	fef43023          	sd	a5,-32(s0)
     c9e:	fe043783          	ld	a5,-32(s0)
     ca2:	ef95                	bnez	a5,cde <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     ca4:	00001797          	auipc	a5,0x1
     ca8:	a4c78793          	addi	a5,a5,-1460 # 16f0 <base>
     cac:	fef43023          	sd	a5,-32(s0)
     cb0:	00001797          	auipc	a5,0x1
     cb4:	a5078793          	addi	a5,a5,-1456 # 1700 <freep>
     cb8:	fe043703          	ld	a4,-32(s0)
     cbc:	e398                	sd	a4,0(a5)
     cbe:	00001797          	auipc	a5,0x1
     cc2:	a4278793          	addi	a5,a5,-1470 # 1700 <freep>
     cc6:	6398                	ld	a4,0(a5)
     cc8:	00001797          	auipc	a5,0x1
     ccc:	a2878793          	addi	a5,a5,-1496 # 16f0 <base>
     cd0:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     cd2:	00001797          	auipc	a5,0x1
     cd6:	a1e78793          	addi	a5,a5,-1506 # 16f0 <base>
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
     d52:	9b278793          	addi	a5,a5,-1614 # 1700 <freep>
     d56:	fe043703          	ld	a4,-32(s0)
     d5a:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     d5c:	fe843783          	ld	a5,-24(s0)
     d60:	07c1                	addi	a5,a5,16
     d62:	a091                	j	da6 <malloc+0x134>
    }
    if(p == freep)
     d64:	00001797          	auipc	a5,0x1
     d68:	99c78793          	addi	a5,a5,-1636 # 1700 <freep>
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

0000000000000eea <schedule_wrr>:

/* MP3 Part 1 - Non-Real-Time Scheduling */
/* Weighted-Round-Robin Scheduling */
struct threads_sched_result schedule_wrr(struct threads_sched_args args)
{
     eea:	711d                	addi	sp,sp,-96
     eec:	eca2                	sd	s0,88(sp)
     eee:	e8a6                	sd	s1,80(sp)
     ef0:	1080                	addi	s0,sp,96
     ef2:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the weighted round-robin scheduling algorithm
    static struct thread *last_thread = NULL;
    struct thread *selected_thread = NULL;
     ef4:	fe043423          	sd	zero,-24(s0)
    struct thread *candidate = NULL;
     ef8:	fe043023          	sd	zero,-32(s0)

    // If last_thread is NULL or its remaining time is zero, reset the selection process
    if (last_thread == NULL || last_thread->remaining_time <= 0) {
     efc:	00001797          	auipc	a5,0x1
     f00:	80c78793          	addi	a5,a5,-2036 # 1708 <last_thread.1226>
     f04:	639c                	ld	a5,0(a5)
     f06:	cb89                	beqz	a5,f18 <schedule_wrr+0x2e>
     f08:	00001797          	auipc	a5,0x1
     f0c:	80078793          	addi	a5,a5,-2048 # 1708 <last_thread.1226>
     f10:	639c                	ld	a5,0(a5)
     f12:	4fbc                	lw	a5,88(a5)
     f14:	00f04863          	bgtz	a5,f24 <schedule_wrr+0x3a>
        last_thread = NULL;
     f18:	00000797          	auipc	a5,0x0
     f1c:	7f078793          	addi	a5,a5,2032 # 1708 <last_thread.1226>
     f20:	0007b023          	sd	zero,0(a5)
    }

    // Find the first thread that is ready to run
    list_for_each_entry(candidate, args.run_queue, thread_list) {
     f24:	649c                	ld	a5,8(s1)
     f26:	639c                	ld	a5,0(a5)
     f28:	fcf43823          	sd	a5,-48(s0)
     f2c:	fd043783          	ld	a5,-48(s0)
     f30:	fd878793          	addi	a5,a5,-40
     f34:	fef43023          	sd	a5,-32(s0)
     f38:	a0a9                	j	f82 <schedule_wrr+0x98>
        if (!last_thread && candidate->remaining_time > 0)
     f3a:	00000797          	auipc	a5,0x0
     f3e:	7ce78793          	addi	a5,a5,1998 # 1708 <last_thread.1226>
     f42:	639c                	ld	a5,0(a5)
     f44:	eb91                	bnez	a5,f58 <schedule_wrr+0x6e>
     f46:	fe043783          	ld	a5,-32(s0)
     f4a:	4fbc                	lw	a5,88(a5)
     f4c:	00f05663          	blez	a5,f58 <schedule_wrr+0x6e>
            selected_thread = candidate;
     f50:	fe043783          	ld	a5,-32(s0)
     f54:	fef43423          	sd	a5,-24(s0)
        if (candidate->remaining_time > 0) {
     f58:	fe043783          	ld	a5,-32(s0)
     f5c:	4fbc                	lw	a5,88(a5)
     f5e:	00f05763          	blez	a5,f6c <schedule_wrr+0x82>
            selected_thread = candidate;
     f62:	fe043783          	ld	a5,-32(s0)
     f66:	fef43423          	sd	a5,-24(s0)
            break;
     f6a:	a01d                	j	f90 <schedule_wrr+0xa6>
    list_for_each_entry(candidate, args.run_queue, thread_list) {
     f6c:	fe043783          	ld	a5,-32(s0)
     f70:	779c                	ld	a5,40(a5)
     f72:	fcf43423          	sd	a5,-56(s0)
     f76:	fc843783          	ld	a5,-56(s0)
     f7a:	fd878793          	addi	a5,a5,-40
     f7e:	fef43023          	sd	a5,-32(s0)
     f82:	fe043783          	ld	a5,-32(s0)
     f86:	02878713          	addi	a4,a5,40
     f8a:	649c                	ld	a5,8(s1)
     f8c:	faf717e3          	bne	a4,a5,f3a <schedule_wrr+0x50>
        }
    }

    // Fall back to the last_thread if no other thread is selected and it still has remaining time
    if (!selected_thread && last_thread && last_thread->remaining_time > 0) {
     f90:	fe843783          	ld	a5,-24(s0)
     f94:	e795                	bnez	a5,fc0 <schedule_wrr+0xd6>
     f96:	00000797          	auipc	a5,0x0
     f9a:	77278793          	addi	a5,a5,1906 # 1708 <last_thread.1226>
     f9e:	639c                	ld	a5,0(a5)
     fa0:	c385                	beqz	a5,fc0 <schedule_wrr+0xd6>
     fa2:	00000797          	auipc	a5,0x0
     fa6:	76678793          	addi	a5,a5,1894 # 1708 <last_thread.1226>
     faa:	639c                	ld	a5,0(a5)
     fac:	4fbc                	lw	a5,88(a5)
     fae:	00f05963          	blez	a5,fc0 <schedule_wrr+0xd6>
        selected_thread = last_thread;
     fb2:	00000797          	auipc	a5,0x0
     fb6:	75678793          	addi	a5,a5,1878 # 1708 <last_thread.1226>
     fba:	639c                	ld	a5,0(a5)
     fbc:	fef43423          	sd	a5,-24(s0)
    }

    // Set the scheduling result
    if (selected_thread) {
     fc0:	fe843783          	ld	a5,-24(s0)
     fc4:	c7b9                	beqz	a5,1012 <schedule_wrr+0x128>
        int time_slice = selected_thread->weight * TIME_QUANTUM;
     fc6:	fe843783          	ld	a5,-24(s0)
     fca:	47bc                	lw	a5,72(a5)
     fcc:	0017979b          	slliw	a5,a5,0x1
     fd0:	fcf42e23          	sw	a5,-36(s0)
        if (time_slice > selected_thread->remaining_time) {
     fd4:	fe843783          	ld	a5,-24(s0)
     fd8:	4fb8                	lw	a4,88(a5)
     fda:	fdc42783          	lw	a5,-36(s0)
     fde:	2781                	sext.w	a5,a5
     fe0:	00f75763          	bge	a4,a5,fee <schedule_wrr+0x104>
            time_slice = selected_thread->remaining_time;
     fe4:	fe843783          	ld	a5,-24(s0)
     fe8:	4fbc                	lw	a5,88(a5)
     fea:	fcf42e23          	sw	a5,-36(s0)
        }
        r.scheduled_thread_list_member = &selected_thread->thread_list;
     fee:	fe843783          	ld	a5,-24(s0)
     ff2:	02878793          	addi	a5,a5,40
     ff6:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = time_slice;
     ffa:	fdc42783          	lw	a5,-36(s0)
     ffe:	faf42823          	sw	a5,-80(s0)
        last_thread = selected_thread;  // Update the last run thread
    1002:	00000797          	auipc	a5,0x0
    1006:	70678793          	addi	a5,a5,1798 # 1708 <last_thread.1226>
    100a:	fe843703          	ld	a4,-24(s0)
    100e:	e398                	sd	a4,0(a5)
    1010:	a039                	j	101e <schedule_wrr+0x134>
    } else {
        // Idle if no suitable thread is found
        r.scheduled_thread_list_member = args.run_queue;
    1012:	649c                	ld	a5,8(s1)
    1014:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = 1;
    1018:	4785                	li	a5,1
    101a:	faf42823          	sw	a5,-80(s0)
    }

    return r;
    101e:	fa843783          	ld	a5,-88(s0)
    1022:	faf43c23          	sd	a5,-72(s0)
    1026:	fb043783          	ld	a5,-80(s0)
    102a:	fcf43023          	sd	a5,-64(s0)
    102e:	4701                	li	a4,0
    1030:	fb843703          	ld	a4,-72(s0)
    1034:	4781                	li	a5,0
    1036:	fc043783          	ld	a5,-64(s0)
    103a:	863a                	mv	a2,a4
    103c:	86be                	mv	a3,a5
    103e:	8732                	mv	a4,a2
    1040:	87b6                	mv	a5,a3
}
    1042:	853a                	mv	a0,a4
    1044:	85be                	mv	a1,a5
    1046:	6466                	ld	s0,88(sp)
    1048:	64c6                	ld	s1,80(sp)
    104a:	6125                	addi	sp,sp,96
    104c:	8082                	ret

000000000000104e <find_next_release_time>:

int find_next_release_time(struct list_head *release_queue, int current_time) {
    104e:	7139                	addi	sp,sp,-64
    1050:	fc22                	sd	s0,56(sp)
    1052:	0080                	addi	s0,sp,64
    1054:	fca43423          	sd	a0,-56(s0)
    1058:	87ae                	mv	a5,a1
    105a:	fcf42223          	sw	a5,-60(s0)
    struct release_queue_entry *next_release = NULL;
    105e:	fe043423          	sd	zero,-24(s0)
    int next_release_time = INT_MAX;
    1062:	800007b7          	lui	a5,0x80000
    1066:	fff7c793          	not	a5,a5
    106a:	fef42223          	sw	a5,-28(s0)

    list_for_each_entry(next_release, release_queue, thread_list) {
    106e:	fc843783          	ld	a5,-56(s0)
    1072:	639c                	ld	a5,0(a5)
    1074:	fcf43c23          	sd	a5,-40(s0)
    1078:	fd843783          	ld	a5,-40(s0)
    107c:	17e1                	addi	a5,a5,-8
    107e:	fef43423          	sd	a5,-24(s0)
    1082:	a081                	j	10c2 <find_next_release_time+0x74>
        if (next_release->release_time > current_time && next_release->release_time < next_release_time) {
    1084:	fe843783          	ld	a5,-24(s0)
    1088:	4f98                	lw	a4,24(a5)
    108a:	fc442783          	lw	a5,-60(s0)
    108e:	2781                	sext.w	a5,a5
    1090:	00e7df63          	bge	a5,a4,10ae <find_next_release_time+0x60>
    1094:	fe843783          	ld	a5,-24(s0)
    1098:	4f98                	lw	a4,24(a5)
    109a:	fe442783          	lw	a5,-28(s0)
    109e:	2781                	sext.w	a5,a5
    10a0:	00f75763          	bge	a4,a5,10ae <find_next_release_time+0x60>
            next_release_time = next_release->release_time;
    10a4:	fe843783          	ld	a5,-24(s0)
    10a8:	4f9c                	lw	a5,24(a5)
    10aa:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(next_release, release_queue, thread_list) {
    10ae:	fe843783          	ld	a5,-24(s0)
    10b2:	679c                	ld	a5,8(a5)
    10b4:	fcf43823          	sd	a5,-48(s0)
    10b8:	fd043783          	ld	a5,-48(s0)
    10bc:	17e1                	addi	a5,a5,-8
    10be:	fef43423          	sd	a5,-24(s0)
    10c2:	fe843783          	ld	a5,-24(s0)
    10c6:	07a1                	addi	a5,a5,8
    10c8:	fc843703          	ld	a4,-56(s0)
    10cc:	faf71ce3          	bne	a4,a5,1084 <find_next_release_time+0x36>
        }
    }

    if (next_release_time == INT_MAX)
    10d0:	fe442783          	lw	a5,-28(s0)
    10d4:	0007871b          	sext.w	a4,a5
    10d8:	800007b7          	lui	a5,0x80000
    10dc:	fff7c793          	not	a5,a5
    10e0:	00f71463          	bne	a4,a5,10e8 <find_next_release_time+0x9a>
        return -1; // No threads in the release queue
    10e4:	57fd                	li	a5,-1
    10e6:	a801                	j	10f6 <find_next_release_time+0xa8>

    return next_release_time - current_time;
    10e8:	fe442703          	lw	a4,-28(s0)
    10ec:	fc442783          	lw	a5,-60(s0)
    10f0:	40f707bb          	subw	a5,a4,a5
    10f4:	2781                	sext.w	a5,a5
}
    10f6:	853e                	mv	a0,a5
    10f8:	7462                	ld	s0,56(sp)
    10fa:	6121                	addi	sp,sp,64
    10fc:	8082                	ret

00000000000010fe <find_earliest_impactful_release_time>:



int find_earliest_impactful_release_time(struct list_head *release_queue, struct list_head *run_queue, int current_time) {
    10fe:	7159                	addi	sp,sp,-112
    1100:	f4a2                	sd	s0,104(sp)
    1102:	1880                	addi	s0,sp,112
    1104:	faa43423          	sd	a0,-88(s0)
    1108:	fab43023          	sd	a1,-96(s0)
    110c:	87b2                	mv	a5,a2
    110e:	f8f42e23          	sw	a5,-100(s0)
    struct release_queue_entry *entry;
    int earliest_impactful_time = INT_MAX;
    1112:	800007b7          	lui	a5,0x80000
    1116:	fff7c793          	not	a5,a5
    111a:	fef42223          	sw	a5,-28(s0)
    int shortest_current_time = INT_MAX;
    111e:	800007b7          	lui	a5,0x80000
    1122:	fff7c793          	not	a5,a5
    1126:	fef42023          	sw	a5,-32(s0)

    // Find the shortest remaining time among currently running tasks
    struct thread *t;
    list_for_each_entry(t, run_queue, thread_list) {
    112a:	fa043783          	ld	a5,-96(s0)
    112e:	639c                	ld	a5,0(a5)
    1130:	fcf43823          	sd	a5,-48(s0)
    1134:	fd043783          	ld	a5,-48(s0)
    1138:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe100>
    113c:	fcf43c23          	sd	a5,-40(s0)
    1140:	a80d                	j	1172 <find_earliest_impactful_release_time+0x74>
        if (t->remaining_time < shortest_current_time) {
    1142:	fd843783          	ld	a5,-40(s0)
    1146:	4fb8                	lw	a4,88(a5)
    1148:	fe042783          	lw	a5,-32(s0)
    114c:	2781                	sext.w	a5,a5
    114e:	00f75763          	bge	a4,a5,115c <find_earliest_impactful_release_time+0x5e>
            shortest_current_time = t->remaining_time;
    1152:	fd843783          	ld	a5,-40(s0)
    1156:	4fbc                	lw	a5,88(a5)
    1158:	fef42023          	sw	a5,-32(s0)
    list_for_each_entry(t, run_queue, thread_list) {
    115c:	fd843783          	ld	a5,-40(s0)
    1160:	779c                	ld	a5,40(a5)
    1162:	faf43c23          	sd	a5,-72(s0)
    1166:	fb843783          	ld	a5,-72(s0)
    116a:	fd878793          	addi	a5,a5,-40
    116e:	fcf43c23          	sd	a5,-40(s0)
    1172:	fd843783          	ld	a5,-40(s0)
    1176:	02878793          	addi	a5,a5,40
    117a:	fa043703          	ld	a4,-96(s0)
    117e:	fcf712e3          	bne	a4,a5,1142 <find_earliest_impactful_release_time+0x44>
        }
    }

    // Check the release queue for the next task that might preempt the current shortest job
    list_for_each_entry(entry, release_queue, thread_list) {
    1182:	fa843783          	ld	a5,-88(s0)
    1186:	639c                	ld	a5,0(a5)
    1188:	fcf43423          	sd	a5,-56(s0)
    118c:	fc843783          	ld	a5,-56(s0)
    1190:	17e1                	addi	a5,a5,-8
    1192:	fef43423          	sd	a5,-24(s0)
    1196:	a889                	j	11e8 <find_earliest_impactful_release_time+0xea>
        if (entry->release_time > current_time && entry->release_time < earliest_impactful_time) {
    1198:	fe843783          	ld	a5,-24(s0)
    119c:	4f98                	lw	a4,24(a5)
    119e:	f9c42783          	lw	a5,-100(s0)
    11a2:	2781                	sext.w	a5,a5
    11a4:	02e7d863          	bge	a5,a4,11d4 <find_earliest_impactful_release_time+0xd6>
    11a8:	fe843783          	ld	a5,-24(s0)
    11ac:	4f98                	lw	a4,24(a5)
    11ae:	fe442783          	lw	a5,-28(s0)
    11b2:	2781                	sext.w	a5,a5
    11b4:	02f75063          	bge	a4,a5,11d4 <find_earliest_impactful_release_time+0xd6>
            if (entry->thrd->remaining_time < shortest_current_time) {
    11b8:	fe843783          	ld	a5,-24(s0)
    11bc:	639c                	ld	a5,0(a5)
    11be:	4fb8                	lw	a4,88(a5)
    11c0:	fe042783          	lw	a5,-32(s0)
    11c4:	2781                	sext.w	a5,a5
    11c6:	00f75763          	bge	a4,a5,11d4 <find_earliest_impactful_release_time+0xd6>
                earliest_impactful_time = entry->release_time;
    11ca:	fe843783          	ld	a5,-24(s0)
    11ce:	4f9c                	lw	a5,24(a5)
    11d0:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(entry, release_queue, thread_list) {
    11d4:	fe843783          	ld	a5,-24(s0)
    11d8:	679c                	ld	a5,8(a5)
    11da:	fcf43023          	sd	a5,-64(s0)
    11de:	fc043783          	ld	a5,-64(s0)
    11e2:	17e1                	addi	a5,a5,-8
    11e4:	fef43423          	sd	a5,-24(s0)
    11e8:	fe843783          	ld	a5,-24(s0)
    11ec:	07a1                	addi	a5,a5,8
    11ee:	fa843703          	ld	a4,-88(s0)
    11f2:	faf713e3          	bne	a4,a5,1198 <find_earliest_impactful_release_time+0x9a>
            }
        }
    }

    // Calculate the difference between the current time and the earliest impactful release time
    return earliest_impactful_time == INT_MAX ? -1 : earliest_impactful_time - current_time;
    11f6:	fe442783          	lw	a5,-28(s0)
    11fa:	0007871b          	sext.w	a4,a5
    11fe:	800007b7          	lui	a5,0x80000
    1202:	fff7c793          	not	a5,a5
    1206:	00f70a63          	beq	a4,a5,121a <find_earliest_impactful_release_time+0x11c>
    120a:	fe442703          	lw	a4,-28(s0)
    120e:	f9c42783          	lw	a5,-100(s0)
    1212:	40f707bb          	subw	a5,a4,a5
    1216:	2781                	sext.w	a5,a5
    1218:	a011                	j	121c <find_earliest_impactful_release_time+0x11e>
    121a:	57fd                	li	a5,-1
}
    121c:	853e                	mv	a0,a5
    121e:	7426                	ld	s0,104(sp)
    1220:	6165                	addi	sp,sp,112
    1222:	8082                	ret

0000000000001224 <schedule_sjf>:


struct threads_sched_result schedule_sjf(struct threads_sched_args args) {
    1224:	7119                	addi	sp,sp,-128
    1226:	fc86                	sd	ra,120(sp)
    1228:	f8a2                	sd	s0,112(sp)
    122a:	f4a6                	sd	s1,104(sp)
    122c:	f0ca                	sd	s2,96(sp)
    122e:	ecce                	sd	s3,88(sp)
    1230:	0100                	addi	s0,sp,128
    1232:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *shortest_job = NULL;
    1234:	fc043423          	sd	zero,-56(s0)
    struct thread *current;
    int shortest_time = INT_MAX;
    1238:	800007b7          	lui	a5,0x80000
    123c:	fff7c793          	not	a5,a5
    1240:	faf42e23          	sw	a5,-68(s0)
    int earliest_impactful_time = find_earliest_impactful_release_time(args.release_queue, args.run_queue, args.current_time);
    1244:	689c                	ld	a5,16(s1)
    1246:	6498                	ld	a4,8(s1)
    1248:	4094                	lw	a3,0(s1)
    124a:	8636                	mv	a2,a3
    124c:	85ba                	mv	a1,a4
    124e:	853e                	mv	a0,a5
    1250:	00000097          	auipc	ra,0x0
    1254:	eae080e7          	jalr	-338(ra) # 10fe <find_earliest_impactful_release_time>
    1258:	87aa                	mv	a5,a0
    125a:	faf42a23          	sw	a5,-76(s0)

    // Determine the shortest job from the run queue
    list_for_each_entry(current, args.run_queue, thread_list) {
    125e:	649c                	ld	a5,8(s1)
    1260:	639c                	ld	a5,0(a5)
    1262:	faf43423          	sd	a5,-88(s0)
    1266:	fa843783          	ld	a5,-88(s0)
    126a:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe100>
    126e:	fcf43023          	sd	a5,-64(s0)
    1272:	a82d                	j	12ac <schedule_sjf+0x88>
        if (current->remaining_time < shortest_time) {
    1274:	fc043783          	ld	a5,-64(s0)
    1278:	4fb8                	lw	a4,88(a5)
    127a:	fbc42783          	lw	a5,-68(s0)
    127e:	2781                	sext.w	a5,a5
    1280:	00f75b63          	bge	a4,a5,1296 <schedule_sjf+0x72>
            shortest_time = current->remaining_time;
    1284:	fc043783          	ld	a5,-64(s0)
    1288:	4fbc                	lw	a5,88(a5)
    128a:	faf42e23          	sw	a5,-68(s0)
            shortest_job = current;
    128e:	fc043783          	ld	a5,-64(s0)
    1292:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(current, args.run_queue, thread_list) {
    1296:	fc043783          	ld	a5,-64(s0)
    129a:	779c                	ld	a5,40(a5)
    129c:	faf43023          	sd	a5,-96(s0)
    12a0:	fa043783          	ld	a5,-96(s0)
    12a4:	fd878793          	addi	a5,a5,-40
    12a8:	fcf43023          	sd	a5,-64(s0)
    12ac:	fc043783          	ld	a5,-64(s0)
    12b0:	02878713          	addi	a4,a5,40
    12b4:	649c                	ld	a5,8(s1)
    12b6:	faf71fe3          	bne	a4,a5,1274 <schedule_sjf+0x50>
        }
    }

    if (shortest_job) {
    12ba:	fc843783          	ld	a5,-56(s0)
    12be:	c7a1                	beqz	a5,1306 <schedule_sjf+0xe2>
        int time_to_allocate = shortest_job->remaining_time;
    12c0:	fc843783          	ld	a5,-56(s0)
    12c4:	4fbc                	lw	a5,88(a5)
    12c6:	faf42c23          	sw	a5,-72(s0)
        // Reduce the time slice if an impactful task is arriving sooner
        if (earliest_impactful_time != -1 && earliest_impactful_time < time_to_allocate) {
    12ca:	fb442783          	lw	a5,-76(s0)
    12ce:	0007871b          	sext.w	a4,a5
    12d2:	57fd                	li	a5,-1
    12d4:	00f70e63          	beq	a4,a5,12f0 <schedule_sjf+0xcc>
    12d8:	fb442703          	lw	a4,-76(s0)
    12dc:	fb842783          	lw	a5,-72(s0)
    12e0:	2701                	sext.w	a4,a4
    12e2:	2781                	sext.w	a5,a5
    12e4:	00f75663          	bge	a4,a5,12f0 <schedule_sjf+0xcc>
            time_to_allocate = earliest_impactful_time;
    12e8:	fb442783          	lw	a5,-76(s0)
    12ec:	faf42c23          	sw	a5,-72(s0)
        }

        r.scheduled_thread_list_member = &shortest_job->thread_list;
    12f0:	fc843783          	ld	a5,-56(s0)
    12f4:	02878793          	addi	a5,a5,40
    12f8:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = time_to_allocate;
    12fc:	fb842783          	lw	a5,-72(s0)
    1300:	f8f42423          	sw	a5,-120(s0)
    1304:	a00d                	j	1326 <schedule_sjf+0x102>
    } else {
        // If no current tasks are ready, wait for the next impactful task
        r.scheduled_thread_list_member = args.run_queue;
    1306:	649c                	ld	a5,8(s1)
    1308:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = earliest_impactful_time != -1 ? earliest_impactful_time : 1;  // Minimal quantum if unsure
    130c:	fb442783          	lw	a5,-76(s0)
    1310:	0007871b          	sext.w	a4,a5
    1314:	57fd                	li	a5,-1
    1316:	00f70563          	beq	a4,a5,1320 <schedule_sjf+0xfc>
    131a:	fb442783          	lw	a5,-76(s0)
    131e:	a011                	j	1322 <schedule_sjf+0xfe>
    1320:	4785                	li	a5,1
    1322:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    1326:	f8043783          	ld	a5,-128(s0)
    132a:	f8f43823          	sd	a5,-112(s0)
    132e:	f8843783          	ld	a5,-120(s0)
    1332:	f8f43c23          	sd	a5,-104(s0)
    1336:	4701                	li	a4,0
    1338:	f9043703          	ld	a4,-112(s0)
    133c:	4781                	li	a5,0
    133e:	f9843783          	ld	a5,-104(s0)
    1342:	893a                	mv	s2,a4
    1344:	89be                	mv	s3,a5
    1346:	874a                	mv	a4,s2
    1348:	87ce                	mv	a5,s3
}
    134a:	853a                	mv	a0,a4
    134c:	85be                	mv	a1,a5
    134e:	70e6                	ld	ra,120(sp)
    1350:	7446                	ld	s0,112(sp)
    1352:	74a6                	ld	s1,104(sp)
    1354:	7906                	ld	s2,96(sp)
    1356:	69e6                	ld	s3,88(sp)
    1358:	6109                	addi	sp,sp,128
    135a:	8082                	ret

000000000000135c <schedule_lst>:


/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args)
{
    135c:	7119                	addi	sp,sp,-128
    135e:	fc86                	sd	ra,120(sp)
    1360:	f8a2                	sd	s0,112(sp)
    1362:	f4a6                	sd	s1,104(sp)
    1364:	f0ca                	sd	s2,96(sp)
    1366:	ecce                	sd	s3,88(sp)
    1368:	0100                	addi	s0,sp,128
    136a:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the least-slack-time scheduling algorithm
    struct thread *min_slack = NULL;
    136c:	fc043423          	sd	zero,-56(s0)
    int min_slack_time = INT_MAX;
    1370:	800007b7          	lui	a5,0x80000
    1374:	fff7c793          	not	a5,a5
    1378:	fcf42223          	sw	a5,-60(s0)
    struct thread *t;

    // Find the thread with the minimum slack time
    list_for_each_entry(t, args.run_queue, thread_list) {
    137c:	649c                	ld	a5,8(s1)
    137e:	639c                	ld	a5,0(a5)
    1380:	faf43823          	sd	a5,-80(s0)
    1384:	fb043783          	ld	a5,-80(s0)
    1388:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe100>
    138c:	faf43c23          	sd	a5,-72(s0)
    1390:	a8b5                	j	140c <schedule_lst+0xb0>
        int slack_time = t->deadline - args.current_time - t->remaining_time;
    1392:	fb843783          	ld	a5,-72(s0)
    1396:	47f8                	lw	a4,76(a5)
    1398:	409c                	lw	a5,0(s1)
    139a:	40f707bb          	subw	a5,a4,a5
    139e:	0007871b          	sext.w	a4,a5
    13a2:	fb843783          	ld	a5,-72(s0)
    13a6:	4fbc                	lw	a5,88(a5)
    13a8:	40f707bb          	subw	a5,a4,a5
    13ac:	faf42623          	sw	a5,-84(s0)
        if (min_slack == NULL || slack_time < min_slack_time ||
    13b0:	fc843783          	ld	a5,-56(s0)
    13b4:	cb8d                	beqz	a5,13e6 <schedule_lst+0x8a>
    13b6:	fac42703          	lw	a4,-84(s0)
    13ba:	fc442783          	lw	a5,-60(s0)
    13be:	2701                	sext.w	a4,a4
    13c0:	2781                	sext.w	a5,a5
    13c2:	02f74263          	blt	a4,a5,13e6 <schedule_lst+0x8a>
    13c6:	fac42703          	lw	a4,-84(s0)
    13ca:	fc442783          	lw	a5,-60(s0)
    13ce:	2701                	sext.w	a4,a4
    13d0:	2781                	sext.w	a5,a5
    13d2:	02f71263          	bne	a4,a5,13f6 <schedule_lst+0x9a>
            (slack_time == min_slack_time && t->ID < min_slack->ID)) {
    13d6:	fb843783          	ld	a5,-72(s0)
    13da:	5fd8                	lw	a4,60(a5)
    13dc:	fc843783          	ld	a5,-56(s0)
    13e0:	5fdc                	lw	a5,60(a5)
    13e2:	00f75a63          	bge	a4,a5,13f6 <schedule_lst+0x9a>
            min_slack = t;
    13e6:	fb843783          	ld	a5,-72(s0)
    13ea:	fcf43423          	sd	a5,-56(s0)
            min_slack_time = slack_time;
    13ee:	fac42783          	lw	a5,-84(s0)
    13f2:	fcf42223          	sw	a5,-60(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    13f6:	fb843783          	ld	a5,-72(s0)
    13fa:	779c                	ld	a5,40(a5)
    13fc:	faf43023          	sd	a5,-96(s0)
    1400:	fa043783          	ld	a5,-96(s0)
    1404:	fd878793          	addi	a5,a5,-40
    1408:	faf43c23          	sd	a5,-72(s0)
    140c:	fb843783          	ld	a5,-72(s0)
    1410:	02878713          	addi	a4,a5,40
    1414:	649c                	ld	a5,8(s1)
    1416:	f6f71ee3          	bne	a4,a5,1392 <schedule_lst+0x36>
        }
    }

    if (min_slack) {
    141a:	fc843783          	ld	a5,-56(s0)
    141e:	cf89                	beqz	a5,1438 <schedule_lst+0xdc>
        r.scheduled_thread_list_member = &min_slack->thread_list;
    1420:	fc843783          	ld	a5,-56(s0)
    1424:	02878793          	addi	a5,a5,40
    1428:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = min_slack->remaining_time;
    142c:	fc843783          	ld	a5,-56(s0)
    1430:	4fbc                	lw	a5,88(a5)
    1432:	f8f42423          	sw	a5,-120(s0)
    1436:	a839                	j	1454 <schedule_lst+0xf8>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
    1438:	649c                	ld	a5,8(s1)
    143a:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    143e:	689c                	ld	a5,16(s1)
    1440:	4098                	lw	a4,0(s1)
    1442:	85ba                	mv	a1,a4
    1444:	853e                	mv	a0,a5
    1446:	00000097          	auipc	ra,0x0
    144a:	c08080e7          	jalr	-1016(ra) # 104e <find_next_release_time>
    144e:	87aa                	mv	a5,a0
    1450:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    1454:	f8043783          	ld	a5,-128(s0)
    1458:	f8f43823          	sd	a5,-112(s0)
    145c:	f8843783          	ld	a5,-120(s0)
    1460:	f8f43c23          	sd	a5,-104(s0)
    1464:	4701                	li	a4,0
    1466:	f9043703          	ld	a4,-112(s0)
    146a:	4781                	li	a5,0
    146c:	f9843783          	ld	a5,-104(s0)
    1470:	893a                	mv	s2,a4
    1472:	89be                	mv	s3,a5
    1474:	874a                	mv	a4,s2
    1476:	87ce                	mv	a5,s3
}
    1478:	853a                	mv	a0,a4
    147a:	85be                	mv	a1,a5
    147c:	70e6                	ld	ra,120(sp)
    147e:	7446                	ld	s0,112(sp)
    1480:	74a6                	ld	s1,104(sp)
    1482:	7906                	ld	s2,96(sp)
    1484:	69e6                	ld	s3,88(sp)
    1486:	6109                	addi	sp,sp,128
    1488:	8082                	ret

000000000000148a <schedule_dm>:

/* Deadline-Monotonic Scheduling */
struct threads_sched_result schedule_dm(struct threads_sched_args args)
{
    148a:	7135                	addi	sp,sp,-160
    148c:	ed06                	sd	ra,152(sp)
    148e:	e922                	sd	s0,144(sp)
    1490:	e526                	sd	s1,136(sp)
    1492:	e14a                	sd	s2,128(sp)
    1494:	fcce                	sd	s3,120(sp)
    1496:	1100                	addi	s0,sp,160
    1498:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the deadline-monotonic scheduling algorithm
   struct thread *earliest_deadline_thread = NULL;
    149a:	fc043423          	sd	zero,-56(s0)
    struct thread *t;
    int earliest_deadline = INT_MAX;
    149e:	800007b7          	lui	a5,0x80000
    14a2:	fff7c793          	not	a5,a5
    14a6:	faf42e23          	sw	a5,-68(s0)

    // Find the earliest deadline real-time thread
    list_for_each_entry(t, args.run_queue, thread_list) {
    14aa:	649c                	ld	a5,8(s1)
    14ac:	639c                	ld	a5,0(a5)
    14ae:	faf43423          	sd	a5,-88(s0)
    14b2:	fa843783          	ld	a5,-88(s0)
    14b6:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe100>
    14ba:	fcf43023          	sd	a5,-64(s0)
    14be:	a841                	j	154e <schedule_dm+0xc4>
        if (t->is_real_time && t->period != -1 && t->current_deadline < earliest_deadline) {
    14c0:	fc043783          	ld	a5,-64(s0)
    14c4:	43bc                	lw	a5,64(a5)
    14c6:	cb95                	beqz	a5,14fa <schedule_dm+0x70>
    14c8:	fc043783          	ld	a5,-64(s0)
    14cc:	4bbc                	lw	a5,80(a5)
    14ce:	873e                	mv	a4,a5
    14d0:	57fd                	li	a5,-1
    14d2:	02f70463          	beq	a4,a5,14fa <schedule_dm+0x70>
    14d6:	fc043783          	ld	a5,-64(s0)
    14da:	4ff8                	lw	a4,92(a5)
    14dc:	fbc42783          	lw	a5,-68(s0)
    14e0:	2781                	sext.w	a5,a5
    14e2:	00f75c63          	bge	a4,a5,14fa <schedule_dm+0x70>
            earliest_deadline = t->current_deadline;
    14e6:	fc043783          	ld	a5,-64(s0)
    14ea:	4ffc                	lw	a5,92(a5)
    14ec:	faf42e23          	sw	a5,-68(s0)
            earliest_deadline_thread = t;
    14f0:	fc043783          	ld	a5,-64(s0)
    14f4:	fcf43423          	sd	a5,-56(s0)
    14f8:	a081                	j	1538 <schedule_dm+0xae>
        } else if (t->is_real_time && t->period != -1 && t->current_deadline == earliest_deadline && t->ID < earliest_deadline_thread->ID) {
    14fa:	fc043783          	ld	a5,-64(s0)
    14fe:	43bc                	lw	a5,64(a5)
    1500:	cf85                	beqz	a5,1538 <schedule_dm+0xae>
    1502:	fc043783          	ld	a5,-64(s0)
    1506:	4bbc                	lw	a5,80(a5)
    1508:	873e                	mv	a4,a5
    150a:	57fd                	li	a5,-1
    150c:	02f70663          	beq	a4,a5,1538 <schedule_dm+0xae>
    1510:	fc043783          	ld	a5,-64(s0)
    1514:	4ff8                	lw	a4,92(a5)
    1516:	fbc42783          	lw	a5,-68(s0)
    151a:	2781                	sext.w	a5,a5
    151c:	00e79e63          	bne	a5,a4,1538 <schedule_dm+0xae>
    1520:	fc043783          	ld	a5,-64(s0)
    1524:	5fd8                	lw	a4,60(a5)
    1526:	fc843783          	ld	a5,-56(s0)
    152a:	5fdc                	lw	a5,60(a5)
    152c:	00f75663          	bge	a4,a5,1538 <schedule_dm+0xae>
            earliest_deadline_thread = t;  // Tie-breaking by ID
    1530:	fc043783          	ld	a5,-64(s0)
    1534:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    1538:	fc043783          	ld	a5,-64(s0)
    153c:	779c                	ld	a5,40(a5)
    153e:	f8f43423          	sd	a5,-120(s0)
    1542:	f8843783          	ld	a5,-120(s0)
    1546:	fd878793          	addi	a5,a5,-40
    154a:	fcf43023          	sd	a5,-64(s0)
    154e:	fc043783          	ld	a5,-64(s0)
    1552:	02878713          	addi	a4,a5,40
    1556:	649c                	ld	a5,8(s1)
    1558:	f6f714e3          	bne	a4,a5,14c0 <schedule_dm+0x36>
        }
    }

    if (earliest_deadline_thread) {
    155c:	fc843783          	ld	a5,-56(s0)
    1560:	c7a5                	beqz	a5,15c8 <schedule_dm+0x13e>
        int time_to_deadline = earliest_deadline_thread->current_deadline - args.current_time;
    1562:	fc843783          	ld	a5,-56(s0)
    1566:	4ff8                	lw	a4,92(a5)
    1568:	409c                	lw	a5,0(s1)
    156a:	40f707bb          	subw	a5,a4,a5
    156e:	f8f42a23          	sw	a5,-108(s0)
        if (earliest_deadline_thread->remaining_time > time_to_deadline) {
    1572:	fc843783          	ld	a5,-56(s0)
    1576:	4fb8                	lw	a4,88(a5)
    1578:	f9442783          	lw	a5,-108(s0)
    157c:	2781                	sext.w	a5,a5
    157e:	00e7db63          	bge	a5,a4,1594 <schedule_dm+0x10a>
            // The real-time thread cannot complete before its deadline, so handle the deadline miss
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    1582:	fc843783          	ld	a5,-56(s0)
    1586:	02878793          	addi	a5,a5,40
    158a:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = 0; // Could set to minimal quantum to allow cleanup or logging
    158e:	f6042823          	sw	zero,-144(s0)
    1592:	a0f1                	j	165e <schedule_dm+0x1d4>
        } else {
            // Schedule the real-time thread normally if it hasn't missed its deadline
            int time_slice = (time_to_deadline < earliest_deadline_thread->remaining_time) ? time_to_deadline : earliest_deadline_thread->remaining_time;
    1594:	fc843783          	ld	a5,-56(s0)
    1598:	4fbc                	lw	a5,88(a5)
    159a:	863e                	mv	a2,a5
    159c:	f9442783          	lw	a5,-108(s0)
    15a0:	0007869b          	sext.w	a3,a5
    15a4:	0006071b          	sext.w	a4,a2
    15a8:	00d75363          	bge	a4,a3,15ae <schedule_dm+0x124>
    15ac:	87b2                	mv	a5,a2
    15ae:	f8f42823          	sw	a5,-112(s0)
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    15b2:	fc843783          	ld	a5,-56(s0)
    15b6:	02878793          	addi	a5,a5,40
    15ba:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = time_slice;
    15be:	f9042783          	lw	a5,-112(s0)
    15c2:	f6f42823          	sw	a5,-144(s0)
    15c6:	a861                	j	165e <schedule_dm+0x1d4>
        }
    } else {
        // If no real-time threads with a deadline are ready, find the thread with the smallest ID
        struct thread *smallest_id_thread = NULL;
    15c8:	fa043823          	sd	zero,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    15cc:	649c                	ld	a5,8(s1)
    15ce:	639c                	ld	a5,0(a5)
    15d0:	faf43023          	sd	a5,-96(s0)
    15d4:	fa043783          	ld	a5,-96(s0)
    15d8:	fd878793          	addi	a5,a5,-40
    15dc:	fcf43023          	sd	a5,-64(s0)
    15e0:	a81d                	j	1616 <schedule_dm+0x18c>
            if (smallest_id_thread == NULL || t->ID < smallest_id_thread->ID) {
    15e2:	fb043783          	ld	a5,-80(s0)
    15e6:	cb89                	beqz	a5,15f8 <schedule_dm+0x16e>
    15e8:	fc043783          	ld	a5,-64(s0)
    15ec:	5fd8                	lw	a4,60(a5)
    15ee:	fb043783          	ld	a5,-80(s0)
    15f2:	5fdc                	lw	a5,60(a5)
    15f4:	00f75663          	bge	a4,a5,1600 <schedule_dm+0x176>
                smallest_id_thread = t;
    15f8:	fc043783          	ld	a5,-64(s0)
    15fc:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    1600:	fc043783          	ld	a5,-64(s0)
    1604:	779c                	ld	a5,40(a5)
    1606:	f8f43c23          	sd	a5,-104(s0)
    160a:	f9843783          	ld	a5,-104(s0)
    160e:	fd878793          	addi	a5,a5,-40
    1612:	fcf43023          	sd	a5,-64(s0)
    1616:	fc043783          	ld	a5,-64(s0)
    161a:	02878713          	addi	a4,a5,40
    161e:	649c                	ld	a5,8(s1)
    1620:	fcf711e3          	bne	a4,a5,15e2 <schedule_dm+0x158>
            }
        }

        if (smallest_id_thread) {
    1624:	fb043783          	ld	a5,-80(s0)
    1628:	cf89                	beqz	a5,1642 <schedule_dm+0x1b8>
            r.scheduled_thread_list_member = &smallest_id_thread->thread_list;
    162a:	fb043783          	ld	a5,-80(s0)
    162e:	02878793          	addi	a5,a5,40
    1632:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = smallest_id_thread->remaining_time;
    1636:	fb043783          	ld	a5,-80(s0)
    163a:	4fbc                	lw	a5,88(a5)
    163c:	f6f42823          	sw	a5,-144(s0)
    1640:	a839                	j	165e <schedule_dm+0x1d4>
        } else {
            // If no thread is ready, perhaps idle or find the next release time
            r.scheduled_thread_list_member = args.run_queue;
    1642:	649c                	ld	a5,8(s1)
    1644:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    1648:	689c                	ld	a5,16(s1)
    164a:	4098                	lw	a4,0(s1)
    164c:	85ba                	mv	a1,a4
    164e:	853e                	mv	a0,a5
    1650:	00000097          	auipc	ra,0x0
    1654:	9fe080e7          	jalr	-1538(ra) # 104e <find_next_release_time>
    1658:	87aa                	mv	a5,a0
    165a:	f6f42823          	sw	a5,-144(s0)
        }
    }

    return r;
    165e:	f6843783          	ld	a5,-152(s0)
    1662:	f6f43c23          	sd	a5,-136(s0)
    1666:	f7043783          	ld	a5,-144(s0)
    166a:	f8f43023          	sd	a5,-128(s0)
    166e:	4701                	li	a4,0
    1670:	f7843703          	ld	a4,-136(s0)
    1674:	4781                	li	a5,0
    1676:	f8043783          	ld	a5,-128(s0)
    167a:	893a                	mv	s2,a4
    167c:	89be                	mv	s3,a5
    167e:	874a                	mv	a4,s2
    1680:	87ce                	mv	a5,s3
}
    1682:	853a                	mv	a0,a4
    1684:	85be                	mv	a1,a5
    1686:	60ea                	ld	ra,152(sp)
    1688:	644a                	ld	s0,144(sp)
    168a:	64aa                	ld	s1,136(sp)
    168c:	690a                	ld	s2,128(sp)
    168e:	79e6                	ld	s3,120(sp)
    1690:	610d                	addi	sp,sp,160
    1692:	8082                	ret
