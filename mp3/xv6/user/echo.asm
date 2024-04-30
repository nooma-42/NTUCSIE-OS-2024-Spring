
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
       0:	7139                	addi	sp,sp,-64
       2:	fc06                	sd	ra,56(sp)
       4:	f822                	sd	s0,48(sp)
       6:	f426                	sd	s1,40(sp)
       8:	0080                	addi	s0,sp,64
       a:	87aa                	mv	a5,a0
       c:	fcb43023          	sd	a1,-64(s0)
      10:	fcf42623          	sw	a5,-52(s0)
  int i;

  for(i = 1; i < argc; i++){
      14:	4785                	li	a5,1
      16:	fcf42e23          	sw	a5,-36(s0)
      1a:	a051                	j	9e <main+0x9e>
    write(1, argv[i], strlen(argv[i]));
      1c:	fdc42783          	lw	a5,-36(s0)
      20:	078e                	slli	a5,a5,0x3
      22:	fc043703          	ld	a4,-64(s0)
      26:	97ba                	add	a5,a5,a4
      28:	6384                	ld	s1,0(a5)
      2a:	fdc42783          	lw	a5,-36(s0)
      2e:	078e                	slli	a5,a5,0x3
      30:	fc043703          	ld	a4,-64(s0)
      34:	97ba                	add	a5,a5,a4
      36:	639c                	ld	a5,0(a5)
      38:	853e                	mv	a0,a5
      3a:	00000097          	auipc	ra,0x0
      3e:	12e080e7          	jalr	302(ra) # 168 <strlen>
      42:	87aa                	mv	a5,a0
      44:	2781                	sext.w	a5,a5
      46:	2781                	sext.w	a5,a5
      48:	863e                	mv	a2,a5
      4a:	85a6                	mv	a1,s1
      4c:	4505                	li	a0,1
      4e:	00000097          	auipc	ra,0x0
      52:	51a080e7          	jalr	1306(ra) # 568 <write>
    if(i + 1 < argc){
      56:	fdc42783          	lw	a5,-36(s0)
      5a:	2785                	addiw	a5,a5,1
      5c:	0007871b          	sext.w	a4,a5
      60:	fcc42783          	lw	a5,-52(s0)
      64:	2781                	sext.w	a5,a5
      66:	00f75d63          	bge	a4,a5,80 <main+0x80>
      write(1, " ", 1);
      6a:	4605                	li	a2,1
      6c:	00001597          	auipc	a1,0x1
      70:	4bc58593          	addi	a1,a1,1212 # 1528 <schedule_dm+0x20c>
      74:	4505                	li	a0,1
      76:	00000097          	auipc	ra,0x0
      7a:	4f2080e7          	jalr	1266(ra) # 568 <write>
      7e:	a819                	j	94 <main+0x94>
    } else {
      write(1, "\n", 1);
      80:	4605                	li	a2,1
      82:	00001597          	auipc	a1,0x1
      86:	4ae58593          	addi	a1,a1,1198 # 1530 <schedule_dm+0x214>
      8a:	4505                	li	a0,1
      8c:	00000097          	auipc	ra,0x0
      90:	4dc080e7          	jalr	1244(ra) # 568 <write>
  for(i = 1; i < argc; i++){
      94:	fdc42783          	lw	a5,-36(s0)
      98:	2785                	addiw	a5,a5,1
      9a:	fcf42e23          	sw	a5,-36(s0)
      9e:	fdc42703          	lw	a4,-36(s0)
      a2:	fcc42783          	lw	a5,-52(s0)
      a6:	2701                	sext.w	a4,a4
      a8:	2781                	sext.w	a5,a5
      aa:	f6f749e3          	blt	a4,a5,1c <main+0x1c>
    }
  }
  exit(0);
      ae:	4501                	li	a0,0
      b0:	00000097          	auipc	ra,0x0
      b4:	498080e7          	jalr	1176(ra) # 548 <exit>

00000000000000b8 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
      b8:	7179                	addi	sp,sp,-48
      ba:	f422                	sd	s0,40(sp)
      bc:	1800                	addi	s0,sp,48
      be:	fca43c23          	sd	a0,-40(s0)
      c2:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
      c6:	fd843783          	ld	a5,-40(s0)
      ca:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
      ce:	0001                	nop
      d0:	fd043703          	ld	a4,-48(s0)
      d4:	00170793          	addi	a5,a4,1
      d8:	fcf43823          	sd	a5,-48(s0)
      dc:	fd843783          	ld	a5,-40(s0)
      e0:	00178693          	addi	a3,a5,1
      e4:	fcd43c23          	sd	a3,-40(s0)
      e8:	00074703          	lbu	a4,0(a4)
      ec:	00e78023          	sb	a4,0(a5)
      f0:	0007c783          	lbu	a5,0(a5)
      f4:	fff1                	bnez	a5,d0 <strcpy+0x18>
    ;
  return os;
      f6:	fe843783          	ld	a5,-24(s0)
}
      fa:	853e                	mv	a0,a5
      fc:	7422                	ld	s0,40(sp)
      fe:	6145                	addi	sp,sp,48
     100:	8082                	ret

0000000000000102 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     102:	1101                	addi	sp,sp,-32
     104:	ec22                	sd	s0,24(sp)
     106:	1000                	addi	s0,sp,32
     108:	fea43423          	sd	a0,-24(s0)
     10c:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     110:	a819                	j	126 <strcmp+0x24>
    p++, q++;
     112:	fe843783          	ld	a5,-24(s0)
     116:	0785                	addi	a5,a5,1
     118:	fef43423          	sd	a5,-24(s0)
     11c:	fe043783          	ld	a5,-32(s0)
     120:	0785                	addi	a5,a5,1
     122:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     126:	fe843783          	ld	a5,-24(s0)
     12a:	0007c783          	lbu	a5,0(a5)
     12e:	cb99                	beqz	a5,144 <strcmp+0x42>
     130:	fe843783          	ld	a5,-24(s0)
     134:	0007c703          	lbu	a4,0(a5)
     138:	fe043783          	ld	a5,-32(s0)
     13c:	0007c783          	lbu	a5,0(a5)
     140:	fcf709e3          	beq	a4,a5,112 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     144:	fe843783          	ld	a5,-24(s0)
     148:	0007c783          	lbu	a5,0(a5)
     14c:	0007871b          	sext.w	a4,a5
     150:	fe043783          	ld	a5,-32(s0)
     154:	0007c783          	lbu	a5,0(a5)
     158:	2781                	sext.w	a5,a5
     15a:	40f707bb          	subw	a5,a4,a5
     15e:	2781                	sext.w	a5,a5
}
     160:	853e                	mv	a0,a5
     162:	6462                	ld	s0,24(sp)
     164:	6105                	addi	sp,sp,32
     166:	8082                	ret

0000000000000168 <strlen>:

uint
strlen(const char *s)
{
     168:	7179                	addi	sp,sp,-48
     16a:	f422                	sd	s0,40(sp)
     16c:	1800                	addi	s0,sp,48
     16e:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     172:	fe042623          	sw	zero,-20(s0)
     176:	a031                	j	182 <strlen+0x1a>
     178:	fec42783          	lw	a5,-20(s0)
     17c:	2785                	addiw	a5,a5,1
     17e:	fef42623          	sw	a5,-20(s0)
     182:	fec42783          	lw	a5,-20(s0)
     186:	fd843703          	ld	a4,-40(s0)
     18a:	97ba                	add	a5,a5,a4
     18c:	0007c783          	lbu	a5,0(a5)
     190:	f7e5                	bnez	a5,178 <strlen+0x10>
    ;
  return n;
     192:	fec42783          	lw	a5,-20(s0)
}
     196:	853e                	mv	a0,a5
     198:	7422                	ld	s0,40(sp)
     19a:	6145                	addi	sp,sp,48
     19c:	8082                	ret

000000000000019e <memset>:

void*
memset(void *dst, int c, uint n)
{
     19e:	7179                	addi	sp,sp,-48
     1a0:	f422                	sd	s0,40(sp)
     1a2:	1800                	addi	s0,sp,48
     1a4:	fca43c23          	sd	a0,-40(s0)
     1a8:	87ae                	mv	a5,a1
     1aa:	8732                	mv	a4,a2
     1ac:	fcf42a23          	sw	a5,-44(s0)
     1b0:	87ba                	mv	a5,a4
     1b2:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     1b6:	fd843783          	ld	a5,-40(s0)
     1ba:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     1be:	fe042623          	sw	zero,-20(s0)
     1c2:	a00d                	j	1e4 <memset+0x46>
    cdst[i] = c;
     1c4:	fec42783          	lw	a5,-20(s0)
     1c8:	fe043703          	ld	a4,-32(s0)
     1cc:	97ba                	add	a5,a5,a4
     1ce:	fd442703          	lw	a4,-44(s0)
     1d2:	0ff77713          	andi	a4,a4,255
     1d6:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     1da:	fec42783          	lw	a5,-20(s0)
     1de:	2785                	addiw	a5,a5,1
     1e0:	fef42623          	sw	a5,-20(s0)
     1e4:	fec42703          	lw	a4,-20(s0)
     1e8:	fd042783          	lw	a5,-48(s0)
     1ec:	2781                	sext.w	a5,a5
     1ee:	fcf76be3          	bltu	a4,a5,1c4 <memset+0x26>
  }
  return dst;
     1f2:	fd843783          	ld	a5,-40(s0)
}
     1f6:	853e                	mv	a0,a5
     1f8:	7422                	ld	s0,40(sp)
     1fa:	6145                	addi	sp,sp,48
     1fc:	8082                	ret

00000000000001fe <strchr>:

char*
strchr(const char *s, char c)
{
     1fe:	1101                	addi	sp,sp,-32
     200:	ec22                	sd	s0,24(sp)
     202:	1000                	addi	s0,sp,32
     204:	fea43423          	sd	a0,-24(s0)
     208:	87ae                	mv	a5,a1
     20a:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     20e:	a01d                	j	234 <strchr+0x36>
    if(*s == c)
     210:	fe843783          	ld	a5,-24(s0)
     214:	0007c703          	lbu	a4,0(a5)
     218:	fe744783          	lbu	a5,-25(s0)
     21c:	0ff7f793          	andi	a5,a5,255
     220:	00e79563          	bne	a5,a4,22a <strchr+0x2c>
      return (char*)s;
     224:	fe843783          	ld	a5,-24(s0)
     228:	a821                	j	240 <strchr+0x42>
  for(; *s; s++)
     22a:	fe843783          	ld	a5,-24(s0)
     22e:	0785                	addi	a5,a5,1
     230:	fef43423          	sd	a5,-24(s0)
     234:	fe843783          	ld	a5,-24(s0)
     238:	0007c783          	lbu	a5,0(a5)
     23c:	fbf1                	bnez	a5,210 <strchr+0x12>
  return 0;
     23e:	4781                	li	a5,0
}
     240:	853e                	mv	a0,a5
     242:	6462                	ld	s0,24(sp)
     244:	6105                	addi	sp,sp,32
     246:	8082                	ret

0000000000000248 <gets>:

char*
gets(char *buf, int max)
{
     248:	7179                	addi	sp,sp,-48
     24a:	f406                	sd	ra,40(sp)
     24c:	f022                	sd	s0,32(sp)
     24e:	1800                	addi	s0,sp,48
     250:	fca43c23          	sd	a0,-40(s0)
     254:	87ae                	mv	a5,a1
     256:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     25a:	fe042623          	sw	zero,-20(s0)
     25e:	a8a1                	j	2b6 <gets+0x6e>
    cc = read(0, &c, 1);
     260:	fe740793          	addi	a5,s0,-25
     264:	4605                	li	a2,1
     266:	85be                	mv	a1,a5
     268:	4501                	li	a0,0
     26a:	00000097          	auipc	ra,0x0
     26e:	2f6080e7          	jalr	758(ra) # 560 <read>
     272:	87aa                	mv	a5,a0
     274:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     278:	fe842783          	lw	a5,-24(s0)
     27c:	2781                	sext.w	a5,a5
     27e:	04f05763          	blez	a5,2cc <gets+0x84>
      break;
    buf[i++] = c;
     282:	fec42783          	lw	a5,-20(s0)
     286:	0017871b          	addiw	a4,a5,1
     28a:	fee42623          	sw	a4,-20(s0)
     28e:	873e                	mv	a4,a5
     290:	fd843783          	ld	a5,-40(s0)
     294:	97ba                	add	a5,a5,a4
     296:	fe744703          	lbu	a4,-25(s0)
     29a:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     29e:	fe744783          	lbu	a5,-25(s0)
     2a2:	873e                	mv	a4,a5
     2a4:	47a9                	li	a5,10
     2a6:	02f70463          	beq	a4,a5,2ce <gets+0x86>
     2aa:	fe744783          	lbu	a5,-25(s0)
     2ae:	873e                	mv	a4,a5
     2b0:	47b5                	li	a5,13
     2b2:	00f70e63          	beq	a4,a5,2ce <gets+0x86>
  for(i=0; i+1 < max; ){
     2b6:	fec42783          	lw	a5,-20(s0)
     2ba:	2785                	addiw	a5,a5,1
     2bc:	0007871b          	sext.w	a4,a5
     2c0:	fd442783          	lw	a5,-44(s0)
     2c4:	2781                	sext.w	a5,a5
     2c6:	f8f74de3          	blt	a4,a5,260 <gets+0x18>
     2ca:	a011                	j	2ce <gets+0x86>
      break;
     2cc:	0001                	nop
      break;
  }
  buf[i] = '\0';
     2ce:	fec42783          	lw	a5,-20(s0)
     2d2:	fd843703          	ld	a4,-40(s0)
     2d6:	97ba                	add	a5,a5,a4
     2d8:	00078023          	sb	zero,0(a5)
  return buf;
     2dc:	fd843783          	ld	a5,-40(s0)
}
     2e0:	853e                	mv	a0,a5
     2e2:	70a2                	ld	ra,40(sp)
     2e4:	7402                	ld	s0,32(sp)
     2e6:	6145                	addi	sp,sp,48
     2e8:	8082                	ret

00000000000002ea <stat>:

int
stat(const char *n, struct stat *st)
{
     2ea:	7179                	addi	sp,sp,-48
     2ec:	f406                	sd	ra,40(sp)
     2ee:	f022                	sd	s0,32(sp)
     2f0:	1800                	addi	s0,sp,48
     2f2:	fca43c23          	sd	a0,-40(s0)
     2f6:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     2fa:	4581                	li	a1,0
     2fc:	fd843503          	ld	a0,-40(s0)
     300:	00000097          	auipc	ra,0x0
     304:	288080e7          	jalr	648(ra) # 588 <open>
     308:	87aa                	mv	a5,a0
     30a:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     30e:	fec42783          	lw	a5,-20(s0)
     312:	2781                	sext.w	a5,a5
     314:	0007d463          	bgez	a5,31c <stat+0x32>
    return -1;
     318:	57fd                	li	a5,-1
     31a:	a035                	j	346 <stat+0x5c>
  r = fstat(fd, st);
     31c:	fec42783          	lw	a5,-20(s0)
     320:	fd043583          	ld	a1,-48(s0)
     324:	853e                	mv	a0,a5
     326:	00000097          	auipc	ra,0x0
     32a:	27a080e7          	jalr	634(ra) # 5a0 <fstat>
     32e:	87aa                	mv	a5,a0
     330:	fef42423          	sw	a5,-24(s0)
  close(fd);
     334:	fec42783          	lw	a5,-20(s0)
     338:	853e                	mv	a0,a5
     33a:	00000097          	auipc	ra,0x0
     33e:	236080e7          	jalr	566(ra) # 570 <close>
  return r;
     342:	fe842783          	lw	a5,-24(s0)
}
     346:	853e                	mv	a0,a5
     348:	70a2                	ld	ra,40(sp)
     34a:	7402                	ld	s0,32(sp)
     34c:	6145                	addi	sp,sp,48
     34e:	8082                	ret

0000000000000350 <atoi>:

int
atoi(const char *s)
{
     350:	7179                	addi	sp,sp,-48
     352:	f422                	sd	s0,40(sp)
     354:	1800                	addi	s0,sp,48
     356:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     35a:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     35e:	a815                	j	392 <atoi+0x42>
    n = n*10 + *s++ - '0';
     360:	fec42703          	lw	a4,-20(s0)
     364:	87ba                	mv	a5,a4
     366:	0027979b          	slliw	a5,a5,0x2
     36a:	9fb9                	addw	a5,a5,a4
     36c:	0017979b          	slliw	a5,a5,0x1
     370:	0007871b          	sext.w	a4,a5
     374:	fd843783          	ld	a5,-40(s0)
     378:	00178693          	addi	a3,a5,1
     37c:	fcd43c23          	sd	a3,-40(s0)
     380:	0007c783          	lbu	a5,0(a5)
     384:	2781                	sext.w	a5,a5
     386:	9fb9                	addw	a5,a5,a4
     388:	2781                	sext.w	a5,a5
     38a:	fd07879b          	addiw	a5,a5,-48
     38e:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     392:	fd843783          	ld	a5,-40(s0)
     396:	0007c783          	lbu	a5,0(a5)
     39a:	873e                	mv	a4,a5
     39c:	02f00793          	li	a5,47
     3a0:	00e7fb63          	bgeu	a5,a4,3b6 <atoi+0x66>
     3a4:	fd843783          	ld	a5,-40(s0)
     3a8:	0007c783          	lbu	a5,0(a5)
     3ac:	873e                	mv	a4,a5
     3ae:	03900793          	li	a5,57
     3b2:	fae7f7e3          	bgeu	a5,a4,360 <atoi+0x10>
  return n;
     3b6:	fec42783          	lw	a5,-20(s0)
}
     3ba:	853e                	mv	a0,a5
     3bc:	7422                	ld	s0,40(sp)
     3be:	6145                	addi	sp,sp,48
     3c0:	8082                	ret

00000000000003c2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     3c2:	7139                	addi	sp,sp,-64
     3c4:	fc22                	sd	s0,56(sp)
     3c6:	0080                	addi	s0,sp,64
     3c8:	fca43c23          	sd	a0,-40(s0)
     3cc:	fcb43823          	sd	a1,-48(s0)
     3d0:	87b2                	mv	a5,a2
     3d2:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     3d6:	fd843783          	ld	a5,-40(s0)
     3da:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     3de:	fd043783          	ld	a5,-48(s0)
     3e2:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     3e6:	fe043703          	ld	a4,-32(s0)
     3ea:	fe843783          	ld	a5,-24(s0)
     3ee:	02e7fc63          	bgeu	a5,a4,426 <memmove+0x64>
    while(n-- > 0)
     3f2:	a00d                	j	414 <memmove+0x52>
      *dst++ = *src++;
     3f4:	fe043703          	ld	a4,-32(s0)
     3f8:	00170793          	addi	a5,a4,1
     3fc:	fef43023          	sd	a5,-32(s0)
     400:	fe843783          	ld	a5,-24(s0)
     404:	00178693          	addi	a3,a5,1
     408:	fed43423          	sd	a3,-24(s0)
     40c:	00074703          	lbu	a4,0(a4)
     410:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     414:	fcc42783          	lw	a5,-52(s0)
     418:	fff7871b          	addiw	a4,a5,-1
     41c:	fce42623          	sw	a4,-52(s0)
     420:	fcf04ae3          	bgtz	a5,3f4 <memmove+0x32>
     424:	a891                	j	478 <memmove+0xb6>
  } else {
    dst += n;
     426:	fcc42783          	lw	a5,-52(s0)
     42a:	fe843703          	ld	a4,-24(s0)
     42e:	97ba                	add	a5,a5,a4
     430:	fef43423          	sd	a5,-24(s0)
    src += n;
     434:	fcc42783          	lw	a5,-52(s0)
     438:	fe043703          	ld	a4,-32(s0)
     43c:	97ba                	add	a5,a5,a4
     43e:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     442:	a01d                	j	468 <memmove+0xa6>
      *--dst = *--src;
     444:	fe043783          	ld	a5,-32(s0)
     448:	17fd                	addi	a5,a5,-1
     44a:	fef43023          	sd	a5,-32(s0)
     44e:	fe843783          	ld	a5,-24(s0)
     452:	17fd                	addi	a5,a5,-1
     454:	fef43423          	sd	a5,-24(s0)
     458:	fe043783          	ld	a5,-32(s0)
     45c:	0007c703          	lbu	a4,0(a5)
     460:	fe843783          	ld	a5,-24(s0)
     464:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     468:	fcc42783          	lw	a5,-52(s0)
     46c:	fff7871b          	addiw	a4,a5,-1
     470:	fce42623          	sw	a4,-52(s0)
     474:	fcf048e3          	bgtz	a5,444 <memmove+0x82>
  }
  return vdst;
     478:	fd843783          	ld	a5,-40(s0)
}
     47c:	853e                	mv	a0,a5
     47e:	7462                	ld	s0,56(sp)
     480:	6121                	addi	sp,sp,64
     482:	8082                	ret

0000000000000484 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     484:	7139                	addi	sp,sp,-64
     486:	fc22                	sd	s0,56(sp)
     488:	0080                	addi	s0,sp,64
     48a:	fca43c23          	sd	a0,-40(s0)
     48e:	fcb43823          	sd	a1,-48(s0)
     492:	87b2                	mv	a5,a2
     494:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     498:	fd843783          	ld	a5,-40(s0)
     49c:	fef43423          	sd	a5,-24(s0)
     4a0:	fd043783          	ld	a5,-48(s0)
     4a4:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     4a8:	a0a1                	j	4f0 <memcmp+0x6c>
    if (*p1 != *p2) {
     4aa:	fe843783          	ld	a5,-24(s0)
     4ae:	0007c703          	lbu	a4,0(a5)
     4b2:	fe043783          	ld	a5,-32(s0)
     4b6:	0007c783          	lbu	a5,0(a5)
     4ba:	02f70163          	beq	a4,a5,4dc <memcmp+0x58>
      return *p1 - *p2;
     4be:	fe843783          	ld	a5,-24(s0)
     4c2:	0007c783          	lbu	a5,0(a5)
     4c6:	0007871b          	sext.w	a4,a5
     4ca:	fe043783          	ld	a5,-32(s0)
     4ce:	0007c783          	lbu	a5,0(a5)
     4d2:	2781                	sext.w	a5,a5
     4d4:	40f707bb          	subw	a5,a4,a5
     4d8:	2781                	sext.w	a5,a5
     4da:	a01d                	j	500 <memcmp+0x7c>
    }
    p1++;
     4dc:	fe843783          	ld	a5,-24(s0)
     4e0:	0785                	addi	a5,a5,1
     4e2:	fef43423          	sd	a5,-24(s0)
    p2++;
     4e6:	fe043783          	ld	a5,-32(s0)
     4ea:	0785                	addi	a5,a5,1
     4ec:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     4f0:	fcc42783          	lw	a5,-52(s0)
     4f4:	fff7871b          	addiw	a4,a5,-1
     4f8:	fce42623          	sw	a4,-52(s0)
     4fc:	f7dd                	bnez	a5,4aa <memcmp+0x26>
  }
  return 0;
     4fe:	4781                	li	a5,0
}
     500:	853e                	mv	a0,a5
     502:	7462                	ld	s0,56(sp)
     504:	6121                	addi	sp,sp,64
     506:	8082                	ret

0000000000000508 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     508:	7179                	addi	sp,sp,-48
     50a:	f406                	sd	ra,40(sp)
     50c:	f022                	sd	s0,32(sp)
     50e:	1800                	addi	s0,sp,48
     510:	fea43423          	sd	a0,-24(s0)
     514:	feb43023          	sd	a1,-32(s0)
     518:	87b2                	mv	a5,a2
     51a:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     51e:	fdc42783          	lw	a5,-36(s0)
     522:	863e                	mv	a2,a5
     524:	fe043583          	ld	a1,-32(s0)
     528:	fe843503          	ld	a0,-24(s0)
     52c:	00000097          	auipc	ra,0x0
     530:	e96080e7          	jalr	-362(ra) # 3c2 <memmove>
     534:	87aa                	mv	a5,a0
}
     536:	853e                	mv	a0,a5
     538:	70a2                	ld	ra,40(sp)
     53a:	7402                	ld	s0,32(sp)
     53c:	6145                	addi	sp,sp,48
     53e:	8082                	ret

0000000000000540 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     540:	4885                	li	a7,1
 ecall
     542:	00000073          	ecall
 ret
     546:	8082                	ret

0000000000000548 <exit>:
.global exit
exit:
 li a7, SYS_exit
     548:	4889                	li	a7,2
 ecall
     54a:	00000073          	ecall
 ret
     54e:	8082                	ret

0000000000000550 <wait>:
.global wait
wait:
 li a7, SYS_wait
     550:	488d                	li	a7,3
 ecall
     552:	00000073          	ecall
 ret
     556:	8082                	ret

0000000000000558 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     558:	4891                	li	a7,4
 ecall
     55a:	00000073          	ecall
 ret
     55e:	8082                	ret

0000000000000560 <read>:
.global read
read:
 li a7, SYS_read
     560:	4895                	li	a7,5
 ecall
     562:	00000073          	ecall
 ret
     566:	8082                	ret

0000000000000568 <write>:
.global write
write:
 li a7, SYS_write
     568:	48c1                	li	a7,16
 ecall
     56a:	00000073          	ecall
 ret
     56e:	8082                	ret

0000000000000570 <close>:
.global close
close:
 li a7, SYS_close
     570:	48d5                	li	a7,21
 ecall
     572:	00000073          	ecall
 ret
     576:	8082                	ret

0000000000000578 <kill>:
.global kill
kill:
 li a7, SYS_kill
     578:	4899                	li	a7,6
 ecall
     57a:	00000073          	ecall
 ret
     57e:	8082                	ret

0000000000000580 <exec>:
.global exec
exec:
 li a7, SYS_exec
     580:	489d                	li	a7,7
 ecall
     582:	00000073          	ecall
 ret
     586:	8082                	ret

0000000000000588 <open>:
.global open
open:
 li a7, SYS_open
     588:	48bd                	li	a7,15
 ecall
     58a:	00000073          	ecall
 ret
     58e:	8082                	ret

0000000000000590 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     590:	48c5                	li	a7,17
 ecall
     592:	00000073          	ecall
 ret
     596:	8082                	ret

0000000000000598 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     598:	48c9                	li	a7,18
 ecall
     59a:	00000073          	ecall
 ret
     59e:	8082                	ret

00000000000005a0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     5a0:	48a1                	li	a7,8
 ecall
     5a2:	00000073          	ecall
 ret
     5a6:	8082                	ret

00000000000005a8 <link>:
.global link
link:
 li a7, SYS_link
     5a8:	48cd                	li	a7,19
 ecall
     5aa:	00000073          	ecall
 ret
     5ae:	8082                	ret

00000000000005b0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     5b0:	48d1                	li	a7,20
 ecall
     5b2:	00000073          	ecall
 ret
     5b6:	8082                	ret

00000000000005b8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     5b8:	48a5                	li	a7,9
 ecall
     5ba:	00000073          	ecall
 ret
     5be:	8082                	ret

00000000000005c0 <dup>:
.global dup
dup:
 li a7, SYS_dup
     5c0:	48a9                	li	a7,10
 ecall
     5c2:	00000073          	ecall
 ret
     5c6:	8082                	ret

00000000000005c8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     5c8:	48ad                	li	a7,11
 ecall
     5ca:	00000073          	ecall
 ret
     5ce:	8082                	ret

00000000000005d0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     5d0:	48b1                	li	a7,12
 ecall
     5d2:	00000073          	ecall
 ret
     5d6:	8082                	ret

00000000000005d8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     5d8:	48b5                	li	a7,13
 ecall
     5da:	00000073          	ecall
 ret
     5de:	8082                	ret

00000000000005e0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     5e0:	48b9                	li	a7,14
 ecall
     5e2:	00000073          	ecall
 ret
     5e6:	8082                	ret

00000000000005e8 <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     5e8:	48d9                	li	a7,22
 ecall
     5ea:	00000073          	ecall
 ret
     5ee:	8082                	ret

00000000000005f0 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     5f0:	48dd                	li	a7,23
 ecall
     5f2:	00000073          	ecall
 ret
     5f6:	8082                	ret

00000000000005f8 <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     5f8:	48e1                	li	a7,24
 ecall
     5fa:	00000073          	ecall
 ret
     5fe:	8082                	ret

0000000000000600 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     600:	1101                	addi	sp,sp,-32
     602:	ec06                	sd	ra,24(sp)
     604:	e822                	sd	s0,16(sp)
     606:	1000                	addi	s0,sp,32
     608:	87aa                	mv	a5,a0
     60a:	872e                	mv	a4,a1
     60c:	fef42623          	sw	a5,-20(s0)
     610:	87ba                	mv	a5,a4
     612:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     616:	feb40713          	addi	a4,s0,-21
     61a:	fec42783          	lw	a5,-20(s0)
     61e:	4605                	li	a2,1
     620:	85ba                	mv	a1,a4
     622:	853e                	mv	a0,a5
     624:	00000097          	auipc	ra,0x0
     628:	f44080e7          	jalr	-188(ra) # 568 <write>
}
     62c:	0001                	nop
     62e:	60e2                	ld	ra,24(sp)
     630:	6442                	ld	s0,16(sp)
     632:	6105                	addi	sp,sp,32
     634:	8082                	ret

0000000000000636 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     636:	7139                	addi	sp,sp,-64
     638:	fc06                	sd	ra,56(sp)
     63a:	f822                	sd	s0,48(sp)
     63c:	0080                	addi	s0,sp,64
     63e:	87aa                	mv	a5,a0
     640:	8736                	mv	a4,a3
     642:	fcf42623          	sw	a5,-52(s0)
     646:	87ae                	mv	a5,a1
     648:	fcf42423          	sw	a5,-56(s0)
     64c:	87b2                	mv	a5,a2
     64e:	fcf42223          	sw	a5,-60(s0)
     652:	87ba                	mv	a5,a4
     654:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     658:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     65c:	fc042783          	lw	a5,-64(s0)
     660:	2781                	sext.w	a5,a5
     662:	c38d                	beqz	a5,684 <printint+0x4e>
     664:	fc842783          	lw	a5,-56(s0)
     668:	2781                	sext.w	a5,a5
     66a:	0007dd63          	bgez	a5,684 <printint+0x4e>
    neg = 1;
     66e:	4785                	li	a5,1
     670:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     674:	fc842783          	lw	a5,-56(s0)
     678:	40f007bb          	negw	a5,a5
     67c:	2781                	sext.w	a5,a5
     67e:	fef42223          	sw	a5,-28(s0)
     682:	a029                	j	68c <printint+0x56>
  } else {
    x = xx;
     684:	fc842783          	lw	a5,-56(s0)
     688:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     68c:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     690:	fc442783          	lw	a5,-60(s0)
     694:	fe442703          	lw	a4,-28(s0)
     698:	02f777bb          	remuw	a5,a4,a5
     69c:	0007861b          	sext.w	a2,a5
     6a0:	fec42783          	lw	a5,-20(s0)
     6a4:	0017871b          	addiw	a4,a5,1
     6a8:	fee42623          	sw	a4,-20(s0)
     6ac:	00001697          	auipc	a3,0x1
     6b0:	e9468693          	addi	a3,a3,-364 # 1540 <digits>
     6b4:	02061713          	slli	a4,a2,0x20
     6b8:	9301                	srli	a4,a4,0x20
     6ba:	9736                	add	a4,a4,a3
     6bc:	00074703          	lbu	a4,0(a4)
     6c0:	ff040693          	addi	a3,s0,-16
     6c4:	97b6                	add	a5,a5,a3
     6c6:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     6ca:	fc442783          	lw	a5,-60(s0)
     6ce:	fe442703          	lw	a4,-28(s0)
     6d2:	02f757bb          	divuw	a5,a4,a5
     6d6:	fef42223          	sw	a5,-28(s0)
     6da:	fe442783          	lw	a5,-28(s0)
     6de:	2781                	sext.w	a5,a5
     6e0:	fbc5                	bnez	a5,690 <printint+0x5a>
  if(neg)
     6e2:	fe842783          	lw	a5,-24(s0)
     6e6:	2781                	sext.w	a5,a5
     6e8:	cf95                	beqz	a5,724 <printint+0xee>
    buf[i++] = '-';
     6ea:	fec42783          	lw	a5,-20(s0)
     6ee:	0017871b          	addiw	a4,a5,1
     6f2:	fee42623          	sw	a4,-20(s0)
     6f6:	ff040713          	addi	a4,s0,-16
     6fa:	97ba                	add	a5,a5,a4
     6fc:	02d00713          	li	a4,45
     700:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     704:	a005                	j	724 <printint+0xee>
    putc(fd, buf[i]);
     706:	fec42783          	lw	a5,-20(s0)
     70a:	ff040713          	addi	a4,s0,-16
     70e:	97ba                	add	a5,a5,a4
     710:	fe07c703          	lbu	a4,-32(a5)
     714:	fcc42783          	lw	a5,-52(s0)
     718:	85ba                	mv	a1,a4
     71a:	853e                	mv	a0,a5
     71c:	00000097          	auipc	ra,0x0
     720:	ee4080e7          	jalr	-284(ra) # 600 <putc>
  while(--i >= 0)
     724:	fec42783          	lw	a5,-20(s0)
     728:	37fd                	addiw	a5,a5,-1
     72a:	fef42623          	sw	a5,-20(s0)
     72e:	fec42783          	lw	a5,-20(s0)
     732:	2781                	sext.w	a5,a5
     734:	fc07d9e3          	bgez	a5,706 <printint+0xd0>
}
     738:	0001                	nop
     73a:	0001                	nop
     73c:	70e2                	ld	ra,56(sp)
     73e:	7442                	ld	s0,48(sp)
     740:	6121                	addi	sp,sp,64
     742:	8082                	ret

0000000000000744 <printptr>:

static void
printptr(int fd, uint64 x) {
     744:	7179                	addi	sp,sp,-48
     746:	f406                	sd	ra,40(sp)
     748:	f022                	sd	s0,32(sp)
     74a:	1800                	addi	s0,sp,48
     74c:	87aa                	mv	a5,a0
     74e:	fcb43823          	sd	a1,-48(s0)
     752:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     756:	fdc42783          	lw	a5,-36(s0)
     75a:	03000593          	li	a1,48
     75e:	853e                	mv	a0,a5
     760:	00000097          	auipc	ra,0x0
     764:	ea0080e7          	jalr	-352(ra) # 600 <putc>
  putc(fd, 'x');
     768:	fdc42783          	lw	a5,-36(s0)
     76c:	07800593          	li	a1,120
     770:	853e                	mv	a0,a5
     772:	00000097          	auipc	ra,0x0
     776:	e8e080e7          	jalr	-370(ra) # 600 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     77a:	fe042623          	sw	zero,-20(s0)
     77e:	a82d                	j	7b8 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     780:	fd043783          	ld	a5,-48(s0)
     784:	93f1                	srli	a5,a5,0x3c
     786:	00001717          	auipc	a4,0x1
     78a:	dba70713          	addi	a4,a4,-582 # 1540 <digits>
     78e:	97ba                	add	a5,a5,a4
     790:	0007c703          	lbu	a4,0(a5)
     794:	fdc42783          	lw	a5,-36(s0)
     798:	85ba                	mv	a1,a4
     79a:	853e                	mv	a0,a5
     79c:	00000097          	auipc	ra,0x0
     7a0:	e64080e7          	jalr	-412(ra) # 600 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     7a4:	fec42783          	lw	a5,-20(s0)
     7a8:	2785                	addiw	a5,a5,1
     7aa:	fef42623          	sw	a5,-20(s0)
     7ae:	fd043783          	ld	a5,-48(s0)
     7b2:	0792                	slli	a5,a5,0x4
     7b4:	fcf43823          	sd	a5,-48(s0)
     7b8:	fec42783          	lw	a5,-20(s0)
     7bc:	873e                	mv	a4,a5
     7be:	47bd                	li	a5,15
     7c0:	fce7f0e3          	bgeu	a5,a4,780 <printptr+0x3c>
}
     7c4:	0001                	nop
     7c6:	0001                	nop
     7c8:	70a2                	ld	ra,40(sp)
     7ca:	7402                	ld	s0,32(sp)
     7cc:	6145                	addi	sp,sp,48
     7ce:	8082                	ret

00000000000007d0 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     7d0:	715d                	addi	sp,sp,-80
     7d2:	e486                	sd	ra,72(sp)
     7d4:	e0a2                	sd	s0,64(sp)
     7d6:	0880                	addi	s0,sp,80
     7d8:	87aa                	mv	a5,a0
     7da:	fcb43023          	sd	a1,-64(s0)
     7de:	fac43c23          	sd	a2,-72(s0)
     7e2:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     7e6:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     7ea:	fe042223          	sw	zero,-28(s0)
     7ee:	a42d                	j	a18 <vprintf+0x248>
    c = fmt[i] & 0xff;
     7f0:	fe442783          	lw	a5,-28(s0)
     7f4:	fc043703          	ld	a4,-64(s0)
     7f8:	97ba                	add	a5,a5,a4
     7fa:	0007c783          	lbu	a5,0(a5)
     7fe:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     802:	fe042783          	lw	a5,-32(s0)
     806:	2781                	sext.w	a5,a5
     808:	eb9d                	bnez	a5,83e <vprintf+0x6e>
      if(c == '%'){
     80a:	fdc42783          	lw	a5,-36(s0)
     80e:	0007871b          	sext.w	a4,a5
     812:	02500793          	li	a5,37
     816:	00f71763          	bne	a4,a5,824 <vprintf+0x54>
        state = '%';
     81a:	02500793          	li	a5,37
     81e:	fef42023          	sw	a5,-32(s0)
     822:	a2f5                	j	a0e <vprintf+0x23e>
      } else {
        putc(fd, c);
     824:	fdc42783          	lw	a5,-36(s0)
     828:	0ff7f713          	andi	a4,a5,255
     82c:	fcc42783          	lw	a5,-52(s0)
     830:	85ba                	mv	a1,a4
     832:	853e                	mv	a0,a5
     834:	00000097          	auipc	ra,0x0
     838:	dcc080e7          	jalr	-564(ra) # 600 <putc>
     83c:	aac9                	j	a0e <vprintf+0x23e>
      }
    } else if(state == '%'){
     83e:	fe042783          	lw	a5,-32(s0)
     842:	0007871b          	sext.w	a4,a5
     846:	02500793          	li	a5,37
     84a:	1cf71263          	bne	a4,a5,a0e <vprintf+0x23e>
      if(c == 'd'){
     84e:	fdc42783          	lw	a5,-36(s0)
     852:	0007871b          	sext.w	a4,a5
     856:	06400793          	li	a5,100
     85a:	02f71463          	bne	a4,a5,882 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     85e:	fb843783          	ld	a5,-72(s0)
     862:	00878713          	addi	a4,a5,8
     866:	fae43c23          	sd	a4,-72(s0)
     86a:	4398                	lw	a4,0(a5)
     86c:	fcc42783          	lw	a5,-52(s0)
     870:	4685                	li	a3,1
     872:	4629                	li	a2,10
     874:	85ba                	mv	a1,a4
     876:	853e                	mv	a0,a5
     878:	00000097          	auipc	ra,0x0
     87c:	dbe080e7          	jalr	-578(ra) # 636 <printint>
     880:	a269                	j	a0a <vprintf+0x23a>
      } else if(c == 'l') {
     882:	fdc42783          	lw	a5,-36(s0)
     886:	0007871b          	sext.w	a4,a5
     88a:	06c00793          	li	a5,108
     88e:	02f71663          	bne	a4,a5,8ba <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     892:	fb843783          	ld	a5,-72(s0)
     896:	00878713          	addi	a4,a5,8
     89a:	fae43c23          	sd	a4,-72(s0)
     89e:	639c                	ld	a5,0(a5)
     8a0:	0007871b          	sext.w	a4,a5
     8a4:	fcc42783          	lw	a5,-52(s0)
     8a8:	4681                	li	a3,0
     8aa:	4629                	li	a2,10
     8ac:	85ba                	mv	a1,a4
     8ae:	853e                	mv	a0,a5
     8b0:	00000097          	auipc	ra,0x0
     8b4:	d86080e7          	jalr	-634(ra) # 636 <printint>
     8b8:	aa89                	j	a0a <vprintf+0x23a>
      } else if(c == 'x') {
     8ba:	fdc42783          	lw	a5,-36(s0)
     8be:	0007871b          	sext.w	a4,a5
     8c2:	07800793          	li	a5,120
     8c6:	02f71463          	bne	a4,a5,8ee <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     8ca:	fb843783          	ld	a5,-72(s0)
     8ce:	00878713          	addi	a4,a5,8
     8d2:	fae43c23          	sd	a4,-72(s0)
     8d6:	4398                	lw	a4,0(a5)
     8d8:	fcc42783          	lw	a5,-52(s0)
     8dc:	4681                	li	a3,0
     8de:	4641                	li	a2,16
     8e0:	85ba                	mv	a1,a4
     8e2:	853e                	mv	a0,a5
     8e4:	00000097          	auipc	ra,0x0
     8e8:	d52080e7          	jalr	-686(ra) # 636 <printint>
     8ec:	aa39                	j	a0a <vprintf+0x23a>
      } else if(c == 'p') {
     8ee:	fdc42783          	lw	a5,-36(s0)
     8f2:	0007871b          	sext.w	a4,a5
     8f6:	07000793          	li	a5,112
     8fa:	02f71263          	bne	a4,a5,91e <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     8fe:	fb843783          	ld	a5,-72(s0)
     902:	00878713          	addi	a4,a5,8
     906:	fae43c23          	sd	a4,-72(s0)
     90a:	6398                	ld	a4,0(a5)
     90c:	fcc42783          	lw	a5,-52(s0)
     910:	85ba                	mv	a1,a4
     912:	853e                	mv	a0,a5
     914:	00000097          	auipc	ra,0x0
     918:	e30080e7          	jalr	-464(ra) # 744 <printptr>
     91c:	a0fd                	j	a0a <vprintf+0x23a>
      } else if(c == 's'){
     91e:	fdc42783          	lw	a5,-36(s0)
     922:	0007871b          	sext.w	a4,a5
     926:	07300793          	li	a5,115
     92a:	04f71c63          	bne	a4,a5,982 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     92e:	fb843783          	ld	a5,-72(s0)
     932:	00878713          	addi	a4,a5,8
     936:	fae43c23          	sd	a4,-72(s0)
     93a:	639c                	ld	a5,0(a5)
     93c:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     940:	fe843783          	ld	a5,-24(s0)
     944:	eb8d                	bnez	a5,976 <vprintf+0x1a6>
          s = "(null)";
     946:	00001797          	auipc	a5,0x1
     94a:	bf278793          	addi	a5,a5,-1038 # 1538 <schedule_dm+0x21c>
     94e:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     952:	a015                	j	976 <vprintf+0x1a6>
          putc(fd, *s);
     954:	fe843783          	ld	a5,-24(s0)
     958:	0007c703          	lbu	a4,0(a5)
     95c:	fcc42783          	lw	a5,-52(s0)
     960:	85ba                	mv	a1,a4
     962:	853e                	mv	a0,a5
     964:	00000097          	auipc	ra,0x0
     968:	c9c080e7          	jalr	-868(ra) # 600 <putc>
          s++;
     96c:	fe843783          	ld	a5,-24(s0)
     970:	0785                	addi	a5,a5,1
     972:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     976:	fe843783          	ld	a5,-24(s0)
     97a:	0007c783          	lbu	a5,0(a5)
     97e:	fbf9                	bnez	a5,954 <vprintf+0x184>
     980:	a069                	j	a0a <vprintf+0x23a>
        }
      } else if(c == 'c'){
     982:	fdc42783          	lw	a5,-36(s0)
     986:	0007871b          	sext.w	a4,a5
     98a:	06300793          	li	a5,99
     98e:	02f71463          	bne	a4,a5,9b6 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     992:	fb843783          	ld	a5,-72(s0)
     996:	00878713          	addi	a4,a5,8
     99a:	fae43c23          	sd	a4,-72(s0)
     99e:	439c                	lw	a5,0(a5)
     9a0:	0ff7f713          	andi	a4,a5,255
     9a4:	fcc42783          	lw	a5,-52(s0)
     9a8:	85ba                	mv	a1,a4
     9aa:	853e                	mv	a0,a5
     9ac:	00000097          	auipc	ra,0x0
     9b0:	c54080e7          	jalr	-940(ra) # 600 <putc>
     9b4:	a899                	j	a0a <vprintf+0x23a>
      } else if(c == '%'){
     9b6:	fdc42783          	lw	a5,-36(s0)
     9ba:	0007871b          	sext.w	a4,a5
     9be:	02500793          	li	a5,37
     9c2:	00f71f63          	bne	a4,a5,9e0 <vprintf+0x210>
        putc(fd, c);
     9c6:	fdc42783          	lw	a5,-36(s0)
     9ca:	0ff7f713          	andi	a4,a5,255
     9ce:	fcc42783          	lw	a5,-52(s0)
     9d2:	85ba                	mv	a1,a4
     9d4:	853e                	mv	a0,a5
     9d6:	00000097          	auipc	ra,0x0
     9da:	c2a080e7          	jalr	-982(ra) # 600 <putc>
     9de:	a035                	j	a0a <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     9e0:	fcc42783          	lw	a5,-52(s0)
     9e4:	02500593          	li	a1,37
     9e8:	853e                	mv	a0,a5
     9ea:	00000097          	auipc	ra,0x0
     9ee:	c16080e7          	jalr	-1002(ra) # 600 <putc>
        putc(fd, c);
     9f2:	fdc42783          	lw	a5,-36(s0)
     9f6:	0ff7f713          	andi	a4,a5,255
     9fa:	fcc42783          	lw	a5,-52(s0)
     9fe:	85ba                	mv	a1,a4
     a00:	853e                	mv	a0,a5
     a02:	00000097          	auipc	ra,0x0
     a06:	bfe080e7          	jalr	-1026(ra) # 600 <putc>
      }
      state = 0;
     a0a:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     a0e:	fe442783          	lw	a5,-28(s0)
     a12:	2785                	addiw	a5,a5,1
     a14:	fef42223          	sw	a5,-28(s0)
     a18:	fe442783          	lw	a5,-28(s0)
     a1c:	fc043703          	ld	a4,-64(s0)
     a20:	97ba                	add	a5,a5,a4
     a22:	0007c783          	lbu	a5,0(a5)
     a26:	dc0795e3          	bnez	a5,7f0 <vprintf+0x20>
    }
  }
}
     a2a:	0001                	nop
     a2c:	0001                	nop
     a2e:	60a6                	ld	ra,72(sp)
     a30:	6406                	ld	s0,64(sp)
     a32:	6161                	addi	sp,sp,80
     a34:	8082                	ret

0000000000000a36 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     a36:	7159                	addi	sp,sp,-112
     a38:	fc06                	sd	ra,56(sp)
     a3a:	f822                	sd	s0,48(sp)
     a3c:	0080                	addi	s0,sp,64
     a3e:	fcb43823          	sd	a1,-48(s0)
     a42:	e010                	sd	a2,0(s0)
     a44:	e414                	sd	a3,8(s0)
     a46:	e818                	sd	a4,16(s0)
     a48:	ec1c                	sd	a5,24(s0)
     a4a:	03043023          	sd	a6,32(s0)
     a4e:	03143423          	sd	a7,40(s0)
     a52:	87aa                	mv	a5,a0
     a54:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     a58:	03040793          	addi	a5,s0,48
     a5c:	fcf43423          	sd	a5,-56(s0)
     a60:	fc843783          	ld	a5,-56(s0)
     a64:	fd078793          	addi	a5,a5,-48
     a68:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     a6c:	fe843703          	ld	a4,-24(s0)
     a70:	fdc42783          	lw	a5,-36(s0)
     a74:	863a                	mv	a2,a4
     a76:	fd043583          	ld	a1,-48(s0)
     a7a:	853e                	mv	a0,a5
     a7c:	00000097          	auipc	ra,0x0
     a80:	d54080e7          	jalr	-684(ra) # 7d0 <vprintf>
}
     a84:	0001                	nop
     a86:	70e2                	ld	ra,56(sp)
     a88:	7442                	ld	s0,48(sp)
     a8a:	6165                	addi	sp,sp,112
     a8c:	8082                	ret

0000000000000a8e <printf>:

void
printf(const char *fmt, ...)
{
     a8e:	7159                	addi	sp,sp,-112
     a90:	f406                	sd	ra,40(sp)
     a92:	f022                	sd	s0,32(sp)
     a94:	1800                	addi	s0,sp,48
     a96:	fca43c23          	sd	a0,-40(s0)
     a9a:	e40c                	sd	a1,8(s0)
     a9c:	e810                	sd	a2,16(s0)
     a9e:	ec14                	sd	a3,24(s0)
     aa0:	f018                	sd	a4,32(s0)
     aa2:	f41c                	sd	a5,40(s0)
     aa4:	03043823          	sd	a6,48(s0)
     aa8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     aac:	04040793          	addi	a5,s0,64
     ab0:	fcf43823          	sd	a5,-48(s0)
     ab4:	fd043783          	ld	a5,-48(s0)
     ab8:	fc878793          	addi	a5,a5,-56
     abc:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     ac0:	fe843783          	ld	a5,-24(s0)
     ac4:	863e                	mv	a2,a5
     ac6:	fd843583          	ld	a1,-40(s0)
     aca:	4505                	li	a0,1
     acc:	00000097          	auipc	ra,0x0
     ad0:	d04080e7          	jalr	-764(ra) # 7d0 <vprintf>
}
     ad4:	0001                	nop
     ad6:	70a2                	ld	ra,40(sp)
     ad8:	7402                	ld	s0,32(sp)
     ada:	6165                	addi	sp,sp,112
     adc:	8082                	ret

0000000000000ade <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     ade:	7179                	addi	sp,sp,-48
     ae0:	f422                	sd	s0,40(sp)
     ae2:	1800                	addi	s0,sp,48
     ae4:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     ae8:	fd843783          	ld	a5,-40(s0)
     aec:	17c1                	addi	a5,a5,-16
     aee:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     af2:	00001797          	auipc	a5,0x1
     af6:	a7678793          	addi	a5,a5,-1418 # 1568 <freep>
     afa:	639c                	ld	a5,0(a5)
     afc:	fef43423          	sd	a5,-24(s0)
     b00:	a815                	j	b34 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     b02:	fe843783          	ld	a5,-24(s0)
     b06:	639c                	ld	a5,0(a5)
     b08:	fe843703          	ld	a4,-24(s0)
     b0c:	00f76f63          	bltu	a4,a5,b2a <free+0x4c>
     b10:	fe043703          	ld	a4,-32(s0)
     b14:	fe843783          	ld	a5,-24(s0)
     b18:	02e7eb63          	bltu	a5,a4,b4e <free+0x70>
     b1c:	fe843783          	ld	a5,-24(s0)
     b20:	639c                	ld	a5,0(a5)
     b22:	fe043703          	ld	a4,-32(s0)
     b26:	02f76463          	bltu	a4,a5,b4e <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b2a:	fe843783          	ld	a5,-24(s0)
     b2e:	639c                	ld	a5,0(a5)
     b30:	fef43423          	sd	a5,-24(s0)
     b34:	fe043703          	ld	a4,-32(s0)
     b38:	fe843783          	ld	a5,-24(s0)
     b3c:	fce7f3e3          	bgeu	a5,a4,b02 <free+0x24>
     b40:	fe843783          	ld	a5,-24(s0)
     b44:	639c                	ld	a5,0(a5)
     b46:	fe043703          	ld	a4,-32(s0)
     b4a:	faf77ce3          	bgeu	a4,a5,b02 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     b4e:	fe043783          	ld	a5,-32(s0)
     b52:	479c                	lw	a5,8(a5)
     b54:	1782                	slli	a5,a5,0x20
     b56:	9381                	srli	a5,a5,0x20
     b58:	0792                	slli	a5,a5,0x4
     b5a:	fe043703          	ld	a4,-32(s0)
     b5e:	973e                	add	a4,a4,a5
     b60:	fe843783          	ld	a5,-24(s0)
     b64:	639c                	ld	a5,0(a5)
     b66:	02f71763          	bne	a4,a5,b94 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     b6a:	fe043783          	ld	a5,-32(s0)
     b6e:	4798                	lw	a4,8(a5)
     b70:	fe843783          	ld	a5,-24(s0)
     b74:	639c                	ld	a5,0(a5)
     b76:	479c                	lw	a5,8(a5)
     b78:	9fb9                	addw	a5,a5,a4
     b7a:	0007871b          	sext.w	a4,a5
     b7e:	fe043783          	ld	a5,-32(s0)
     b82:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     b84:	fe843783          	ld	a5,-24(s0)
     b88:	639c                	ld	a5,0(a5)
     b8a:	6398                	ld	a4,0(a5)
     b8c:	fe043783          	ld	a5,-32(s0)
     b90:	e398                	sd	a4,0(a5)
     b92:	a039                	j	ba0 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     b94:	fe843783          	ld	a5,-24(s0)
     b98:	6398                	ld	a4,0(a5)
     b9a:	fe043783          	ld	a5,-32(s0)
     b9e:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     ba0:	fe843783          	ld	a5,-24(s0)
     ba4:	479c                	lw	a5,8(a5)
     ba6:	1782                	slli	a5,a5,0x20
     ba8:	9381                	srli	a5,a5,0x20
     baa:	0792                	slli	a5,a5,0x4
     bac:	fe843703          	ld	a4,-24(s0)
     bb0:	97ba                	add	a5,a5,a4
     bb2:	fe043703          	ld	a4,-32(s0)
     bb6:	02f71563          	bne	a4,a5,be0 <free+0x102>
    p->s.size += bp->s.size;
     bba:	fe843783          	ld	a5,-24(s0)
     bbe:	4798                	lw	a4,8(a5)
     bc0:	fe043783          	ld	a5,-32(s0)
     bc4:	479c                	lw	a5,8(a5)
     bc6:	9fb9                	addw	a5,a5,a4
     bc8:	0007871b          	sext.w	a4,a5
     bcc:	fe843783          	ld	a5,-24(s0)
     bd0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     bd2:	fe043783          	ld	a5,-32(s0)
     bd6:	6398                	ld	a4,0(a5)
     bd8:	fe843783          	ld	a5,-24(s0)
     bdc:	e398                	sd	a4,0(a5)
     bde:	a031                	j	bea <free+0x10c>
  } else
    p->s.ptr = bp;
     be0:	fe843783          	ld	a5,-24(s0)
     be4:	fe043703          	ld	a4,-32(s0)
     be8:	e398                	sd	a4,0(a5)
  freep = p;
     bea:	00001797          	auipc	a5,0x1
     bee:	97e78793          	addi	a5,a5,-1666 # 1568 <freep>
     bf2:	fe843703          	ld	a4,-24(s0)
     bf6:	e398                	sd	a4,0(a5)
}
     bf8:	0001                	nop
     bfa:	7422                	ld	s0,40(sp)
     bfc:	6145                	addi	sp,sp,48
     bfe:	8082                	ret

0000000000000c00 <morecore>:

static Header*
morecore(uint nu)
{
     c00:	7179                	addi	sp,sp,-48
     c02:	f406                	sd	ra,40(sp)
     c04:	f022                	sd	s0,32(sp)
     c06:	1800                	addi	s0,sp,48
     c08:	87aa                	mv	a5,a0
     c0a:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     c0e:	fdc42783          	lw	a5,-36(s0)
     c12:	0007871b          	sext.w	a4,a5
     c16:	6785                	lui	a5,0x1
     c18:	00f77563          	bgeu	a4,a5,c22 <morecore+0x22>
    nu = 4096;
     c1c:	6785                	lui	a5,0x1
     c1e:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     c22:	fdc42783          	lw	a5,-36(s0)
     c26:	0047979b          	slliw	a5,a5,0x4
     c2a:	2781                	sext.w	a5,a5
     c2c:	2781                	sext.w	a5,a5
     c2e:	853e                	mv	a0,a5
     c30:	00000097          	auipc	ra,0x0
     c34:	9a0080e7          	jalr	-1632(ra) # 5d0 <sbrk>
     c38:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     c3c:	fe843703          	ld	a4,-24(s0)
     c40:	57fd                	li	a5,-1
     c42:	00f71463          	bne	a4,a5,c4a <morecore+0x4a>
    return 0;
     c46:	4781                	li	a5,0
     c48:	a03d                	j	c76 <morecore+0x76>
  hp = (Header*)p;
     c4a:	fe843783          	ld	a5,-24(s0)
     c4e:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     c52:	fe043783          	ld	a5,-32(s0)
     c56:	fdc42703          	lw	a4,-36(s0)
     c5a:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     c5c:	fe043783          	ld	a5,-32(s0)
     c60:	07c1                	addi	a5,a5,16
     c62:	853e                	mv	a0,a5
     c64:	00000097          	auipc	ra,0x0
     c68:	e7a080e7          	jalr	-390(ra) # ade <free>
  return freep;
     c6c:	00001797          	auipc	a5,0x1
     c70:	8fc78793          	addi	a5,a5,-1796 # 1568 <freep>
     c74:	639c                	ld	a5,0(a5)
}
     c76:	853e                	mv	a0,a5
     c78:	70a2                	ld	ra,40(sp)
     c7a:	7402                	ld	s0,32(sp)
     c7c:	6145                	addi	sp,sp,48
     c7e:	8082                	ret

0000000000000c80 <malloc>:

void*
malloc(uint nbytes)
{
     c80:	7139                	addi	sp,sp,-64
     c82:	fc06                	sd	ra,56(sp)
     c84:	f822                	sd	s0,48(sp)
     c86:	0080                	addi	s0,sp,64
     c88:	87aa                	mv	a5,a0
     c8a:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     c8e:	fcc46783          	lwu	a5,-52(s0)
     c92:	07bd                	addi	a5,a5,15
     c94:	8391                	srli	a5,a5,0x4
     c96:	2781                	sext.w	a5,a5
     c98:	2785                	addiw	a5,a5,1
     c9a:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     c9e:	00001797          	auipc	a5,0x1
     ca2:	8ca78793          	addi	a5,a5,-1846 # 1568 <freep>
     ca6:	639c                	ld	a5,0(a5)
     ca8:	fef43023          	sd	a5,-32(s0)
     cac:	fe043783          	ld	a5,-32(s0)
     cb0:	ef95                	bnez	a5,cec <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     cb2:	00001797          	auipc	a5,0x1
     cb6:	8a678793          	addi	a5,a5,-1882 # 1558 <base>
     cba:	fef43023          	sd	a5,-32(s0)
     cbe:	00001797          	auipc	a5,0x1
     cc2:	8aa78793          	addi	a5,a5,-1878 # 1568 <freep>
     cc6:	fe043703          	ld	a4,-32(s0)
     cca:	e398                	sd	a4,0(a5)
     ccc:	00001797          	auipc	a5,0x1
     cd0:	89c78793          	addi	a5,a5,-1892 # 1568 <freep>
     cd4:	6398                	ld	a4,0(a5)
     cd6:	00001797          	auipc	a5,0x1
     cda:	88278793          	addi	a5,a5,-1918 # 1558 <base>
     cde:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     ce0:	00001797          	auipc	a5,0x1
     ce4:	87878793          	addi	a5,a5,-1928 # 1558 <base>
     ce8:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     cec:	fe043783          	ld	a5,-32(s0)
     cf0:	639c                	ld	a5,0(a5)
     cf2:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     cf6:	fe843783          	ld	a5,-24(s0)
     cfa:	4798                	lw	a4,8(a5)
     cfc:	fdc42783          	lw	a5,-36(s0)
     d00:	2781                	sext.w	a5,a5
     d02:	06f76863          	bltu	a4,a5,d72 <malloc+0xf2>
      if(p->s.size == nunits)
     d06:	fe843783          	ld	a5,-24(s0)
     d0a:	4798                	lw	a4,8(a5)
     d0c:	fdc42783          	lw	a5,-36(s0)
     d10:	2781                	sext.w	a5,a5
     d12:	00e79963          	bne	a5,a4,d24 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     d16:	fe843783          	ld	a5,-24(s0)
     d1a:	6398                	ld	a4,0(a5)
     d1c:	fe043783          	ld	a5,-32(s0)
     d20:	e398                	sd	a4,0(a5)
     d22:	a82d                	j	d5c <malloc+0xdc>
      else {
        p->s.size -= nunits;
     d24:	fe843783          	ld	a5,-24(s0)
     d28:	4798                	lw	a4,8(a5)
     d2a:	fdc42783          	lw	a5,-36(s0)
     d2e:	40f707bb          	subw	a5,a4,a5
     d32:	0007871b          	sext.w	a4,a5
     d36:	fe843783          	ld	a5,-24(s0)
     d3a:	c798                	sw	a4,8(a5)
        p += p->s.size;
     d3c:	fe843783          	ld	a5,-24(s0)
     d40:	479c                	lw	a5,8(a5)
     d42:	1782                	slli	a5,a5,0x20
     d44:	9381                	srli	a5,a5,0x20
     d46:	0792                	slli	a5,a5,0x4
     d48:	fe843703          	ld	a4,-24(s0)
     d4c:	97ba                	add	a5,a5,a4
     d4e:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     d52:	fe843783          	ld	a5,-24(s0)
     d56:	fdc42703          	lw	a4,-36(s0)
     d5a:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     d5c:	00001797          	auipc	a5,0x1
     d60:	80c78793          	addi	a5,a5,-2036 # 1568 <freep>
     d64:	fe043703          	ld	a4,-32(s0)
     d68:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     d6a:	fe843783          	ld	a5,-24(s0)
     d6e:	07c1                	addi	a5,a5,16
     d70:	a091                	j	db4 <malloc+0x134>
    }
    if(p == freep)
     d72:	00000797          	auipc	a5,0x0
     d76:	7f678793          	addi	a5,a5,2038 # 1568 <freep>
     d7a:	639c                	ld	a5,0(a5)
     d7c:	fe843703          	ld	a4,-24(s0)
     d80:	02f71063          	bne	a4,a5,da0 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     d84:	fdc42783          	lw	a5,-36(s0)
     d88:	853e                	mv	a0,a5
     d8a:	00000097          	auipc	ra,0x0
     d8e:	e76080e7          	jalr	-394(ra) # c00 <morecore>
     d92:	fea43423          	sd	a0,-24(s0)
     d96:	fe843783          	ld	a5,-24(s0)
     d9a:	e399                	bnez	a5,da0 <malloc+0x120>
        return 0;
     d9c:	4781                	li	a5,0
     d9e:	a819                	j	db4 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     da0:	fe843783          	ld	a5,-24(s0)
     da4:	fef43023          	sd	a5,-32(s0)
     da8:	fe843783          	ld	a5,-24(s0)
     dac:	639c                	ld	a5,0(a5)
     dae:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     db2:	b791                	j	cf6 <malloc+0x76>
  }
}
     db4:	853e                	mv	a0,a5
     db6:	70e2                	ld	ra,56(sp)
     db8:	7442                	ld	s0,48(sp)
     dba:	6121                	addi	sp,sp,64
     dbc:	8082                	ret

0000000000000dbe <setjmp>:
     dbe:	e100                	sd	s0,0(a0)
     dc0:	e504                	sd	s1,8(a0)
     dc2:	01253823          	sd	s2,16(a0)
     dc6:	01353c23          	sd	s3,24(a0)
     dca:	03453023          	sd	s4,32(a0)
     dce:	03553423          	sd	s5,40(a0)
     dd2:	03653823          	sd	s6,48(a0)
     dd6:	03753c23          	sd	s7,56(a0)
     dda:	05853023          	sd	s8,64(a0)
     dde:	05953423          	sd	s9,72(a0)
     de2:	05a53823          	sd	s10,80(a0)
     de6:	05b53c23          	sd	s11,88(a0)
     dea:	06153023          	sd	ra,96(a0)
     dee:	06253423          	sd	sp,104(a0)
     df2:	4501                	li	a0,0
     df4:	8082                	ret

0000000000000df6 <longjmp>:
     df6:	6100                	ld	s0,0(a0)
     df8:	6504                	ld	s1,8(a0)
     dfa:	01053903          	ld	s2,16(a0)
     dfe:	01853983          	ld	s3,24(a0)
     e02:	02053a03          	ld	s4,32(a0)
     e06:	02853a83          	ld	s5,40(a0)
     e0a:	03053b03          	ld	s6,48(a0)
     e0e:	03853b83          	ld	s7,56(a0)
     e12:	04053c03          	ld	s8,64(a0)
     e16:	04853c83          	ld	s9,72(a0)
     e1a:	05053d03          	ld	s10,80(a0)
     e1e:	05853d83          	ld	s11,88(a0)
     e22:	06053083          	ld	ra,96(a0)
     e26:	06853103          	ld	sp,104(a0)
     e2a:	c199                	beqz	a1,e30 <longjmp_1>
     e2c:	852e                	mv	a0,a1
     e2e:	8082                	ret

0000000000000e30 <longjmp_1>:
     e30:	4505                	li	a0,1
     e32:	8082                	ret

0000000000000e34 <schedule_default>:
#define INT_MAX 2147483647
#define TIME_QUANTUM 2  // Define a base time quantum for the round-robin

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
     e34:	715d                	addi	sp,sp,-80
     e36:	e4a2                	sd	s0,72(sp)
     e38:	e0a6                	sd	s1,64(sp)
     e3a:	0880                	addi	s0,sp,80
     e3c:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
     e3e:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
     e42:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     e46:	649c                	ld	a5,8(s1)
     e48:	639c                	ld	a5,0(a5)
     e4a:	fcf43c23          	sd	a5,-40(s0)
     e4e:	fd843783          	ld	a5,-40(s0)
     e52:	fd878793          	addi	a5,a5,-40
     e56:	fef43023          	sd	a5,-32(s0)
     e5a:	a81d                	j	e90 <schedule_default+0x5c>
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
     e5c:	fe843783          	ld	a5,-24(s0)
     e60:	cb89                	beqz	a5,e72 <schedule_default+0x3e>
     e62:	fe043783          	ld	a5,-32(s0)
     e66:	5fd8                	lw	a4,60(a5)
     e68:	fe843783          	ld	a5,-24(s0)
     e6c:	5fdc                	lw	a5,60(a5)
     e6e:	00f75663          	bge	a4,a5,e7a <schedule_default+0x46>
            thread_with_smallest_id = th;
     e72:	fe043783          	ld	a5,-32(s0)
     e76:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     e7a:	fe043783          	ld	a5,-32(s0)
     e7e:	779c                	ld	a5,40(a5)
     e80:	fcf43823          	sd	a5,-48(s0)
     e84:	fd043783          	ld	a5,-48(s0)
     e88:	fd878793          	addi	a5,a5,-40
     e8c:	fef43023          	sd	a5,-32(s0)
     e90:	fe043783          	ld	a5,-32(s0)
     e94:	02878713          	addi	a4,a5,40
     e98:	649c                	ld	a5,8(s1)
     e9a:	fcf711e3          	bne	a4,a5,e5c <schedule_default+0x28>
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
     e9e:	fe843783          	ld	a5,-24(s0)
     ea2:	cf89                	beqz	a5,ebc <schedule_default+0x88>
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
     ea4:	fe843783          	ld	a5,-24(s0)
     ea8:	02878793          	addi	a5,a5,40
     eac:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
     eb0:	fe843783          	ld	a5,-24(s0)
     eb4:	4fbc                	lw	a5,88(a5)
     eb6:	faf42c23          	sw	a5,-72(s0)
     eba:	a039                	j	ec8 <schedule_default+0x94>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
     ebc:	649c                	ld	a5,8(s1)
     ebe:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
     ec2:	4785                	li	a5,1
     ec4:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
     ec8:	fb043783          	ld	a5,-80(s0)
     ecc:	fcf43023          	sd	a5,-64(s0)
     ed0:	fb843783          	ld	a5,-72(s0)
     ed4:	fcf43423          	sd	a5,-56(s0)
     ed8:	4701                	li	a4,0
     eda:	fc043703          	ld	a4,-64(s0)
     ede:	4781                	li	a5,0
     ee0:	fc843783          	ld	a5,-56(s0)
     ee4:	863a                	mv	a2,a4
     ee6:	86be                	mv	a3,a5
     ee8:	8732                	mv	a4,a2
     eea:	87b6                	mv	a5,a3
}
     eec:	853a                	mv	a0,a4
     eee:	85be                	mv	a1,a5
     ef0:	6426                	ld	s0,72(sp)
     ef2:	6486                	ld	s1,64(sp)
     ef4:	6161                	addi	sp,sp,80
     ef6:	8082                	ret

0000000000000ef8 <schedule_wrr>:

/* MP3 Part 1 - Non-Real-Time Scheduling */
/* Weighted-Round-Robin Scheduling */
struct threads_sched_result schedule_wrr(struct threads_sched_args args)
{
     ef8:	711d                	addi	sp,sp,-96
     efa:	eca2                	sd	s0,88(sp)
     efc:	e8a6                	sd	s1,80(sp)
     efe:	1080                	addi	s0,sp,96
     f00:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the weighted round-robin scheduling algorithm
    static struct thread *last_thread = NULL;
    struct thread *selected_thread = NULL;
     f02:	fe043423          	sd	zero,-24(s0)
    struct thread *first_eligible_thread = NULL; 
     f06:	fe043023          	sd	zero,-32(s0)

    // If last_thread is NULL or its remaining time is zero, reset the selection process
    if (last_thread == NULL || last_thread->remaining_time <= 0) {
     f0a:	00000797          	auipc	a5,0x0
     f0e:	66678793          	addi	a5,a5,1638 # 1570 <last_thread.1226>
     f12:	639c                	ld	a5,0(a5)
     f14:	cb89                	beqz	a5,f26 <schedule_wrr+0x2e>
     f16:	00000797          	auipc	a5,0x0
     f1a:	65a78793          	addi	a5,a5,1626 # 1570 <last_thread.1226>
     f1e:	639c                	ld	a5,0(a5)
     f20:	4fbc                	lw	a5,88(a5)
     f22:	00f04863          	bgtz	a5,f32 <schedule_wrr+0x3a>
        last_thread = NULL;
     f26:	00000797          	auipc	a5,0x0
     f2a:	64a78793          	addi	a5,a5,1610 # 1570 <last_thread.1226>
     f2e:	0007b023          	sd	zero,0(a5)
    }

    struct thread *candidate = NULL;
     f32:	fc043c23          	sd	zero,-40(s0)
    // Select the next thread to run based on weight and ensure round-robin fairness
    list_for_each_entry(candidate, args.run_queue, thread_list) {
     f36:	649c                	ld	a5,8(s1)
     f38:	639c                	ld	a5,0(a5)
     f3a:	fcf43423          	sd	a5,-56(s0)
     f3e:	fc843783          	ld	a5,-56(s0)
     f42:	fd878793          	addi	a5,a5,-40
     f46:	fcf43c23          	sd	a5,-40(s0)
     f4a:	a8a1                	j	fa2 <schedule_wrr+0xaa>
        // Check for the first eligible thread to use as a fallback
        if (!first_eligible_thread && candidate->remaining_time > 0)
     f4c:	fe043783          	ld	a5,-32(s0)
     f50:	eb91                	bnez	a5,f64 <schedule_wrr+0x6c>
     f52:	fd843783          	ld	a5,-40(s0)
     f56:	4fbc                	lw	a5,88(a5)
     f58:	00f05663          	blez	a5,f64 <schedule_wrr+0x6c>
            first_eligible_thread = candidate;
     f5c:	fd843783          	ld	a5,-40(s0)
     f60:	fef43023          	sd	a5,-32(s0)
        if ((!selected_thread || candidate->ID > selected_thread->ID) && candidate->remaining_time > 0)
     f64:	fe843783          	ld	a5,-24(s0)
     f68:	cb89                	beqz	a5,f7a <schedule_wrr+0x82>
     f6a:	fd843783          	ld	a5,-40(s0)
     f6e:	5fd8                	lw	a4,60(a5)
     f70:	fe843783          	ld	a5,-24(s0)
     f74:	5fdc                	lw	a5,60(a5)
     f76:	00e7db63          	bge	a5,a4,f8c <schedule_wrr+0x94>
     f7a:	fd843783          	ld	a5,-40(s0)
     f7e:	4fbc                	lw	a5,88(a5)
     f80:	00f05663          	blez	a5,f8c <schedule_wrr+0x94>
            selected_thread = candidate;
     f84:	fd843783          	ld	a5,-40(s0)
     f88:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(candidate, args.run_queue, thread_list) {
     f8c:	fd843783          	ld	a5,-40(s0)
     f90:	779c                	ld	a5,40(a5)
     f92:	fcf43023          	sd	a5,-64(s0)
     f96:	fc043783          	ld	a5,-64(s0)
     f9a:	fd878793          	addi	a5,a5,-40
     f9e:	fcf43c23          	sd	a5,-40(s0)
     fa2:	fd843783          	ld	a5,-40(s0)
     fa6:	02878713          	addi	a4,a5,40
     faa:	649c                	ld	a5,8(s1)
     fac:	faf710e3          	bne	a4,a5,f4c <schedule_wrr+0x54>
    }
 
    // Fall back to the last_thread if no other thread is selected and it still has remaining time
    if (!selected_thread && last_thread && last_thread->remaining_time > 0) {
     fb0:	fe843783          	ld	a5,-24(s0)
     fb4:	e795                	bnez	a5,fe0 <schedule_wrr+0xe8>
     fb6:	00000797          	auipc	a5,0x0
     fba:	5ba78793          	addi	a5,a5,1466 # 1570 <last_thread.1226>
     fbe:	639c                	ld	a5,0(a5)
     fc0:	c385                	beqz	a5,fe0 <schedule_wrr+0xe8>
     fc2:	00000797          	auipc	a5,0x0
     fc6:	5ae78793          	addi	a5,a5,1454 # 1570 <last_thread.1226>
     fca:	639c                	ld	a5,0(a5)
     fcc:	4fbc                	lw	a5,88(a5)
     fce:	00f05963          	blez	a5,fe0 <schedule_wrr+0xe8>
        selected_thread = last_thread;
     fd2:	00000797          	auipc	a5,0x0
     fd6:	59e78793          	addi	a5,a5,1438 # 1570 <last_thread.1226>
     fda:	639c                	ld	a5,0(a5)
     fdc:	fef43423          	sd	a5,-24(s0)
    }

    // Set the scheduling result
    if (selected_thread) {
     fe0:	fe843783          	ld	a5,-24(s0)
     fe4:	c7b9                	beqz	a5,1032 <schedule_wrr+0x13a>
        int time_slice = selected_thread->weight * TIME_QUANTUM;
     fe6:	fe843783          	ld	a5,-24(s0)
     fea:	47bc                	lw	a5,72(a5)
     fec:	0017979b          	slliw	a5,a5,0x1
     ff0:	fcf42a23          	sw	a5,-44(s0)
        if (time_slice > selected_thread->remaining_time) {
     ff4:	fe843783          	ld	a5,-24(s0)
     ff8:	4fb8                	lw	a4,88(a5)
     ffa:	fd442783          	lw	a5,-44(s0)
     ffe:	2781                	sext.w	a5,a5
    1000:	00f75763          	bge	a4,a5,100e <schedule_wrr+0x116>
            time_slice = selected_thread->remaining_time;
    1004:	fe843783          	ld	a5,-24(s0)
    1008:	4fbc                	lw	a5,88(a5)
    100a:	fcf42a23          	sw	a5,-44(s0)
        }
        r.scheduled_thread_list_member = &selected_thread->thread_list;
    100e:	fe843783          	ld	a5,-24(s0)
    1012:	02878793          	addi	a5,a5,40
    1016:	faf43023          	sd	a5,-96(s0)
        r.allocated_time = time_slice;
    101a:	fd442783          	lw	a5,-44(s0)
    101e:	faf42423          	sw	a5,-88(s0)
        last_thread = selected_thread;  // Update the last run thread
    1022:	00000797          	auipc	a5,0x0
    1026:	54e78793          	addi	a5,a5,1358 # 1570 <last_thread.1226>
    102a:	fe843703          	ld	a4,-24(s0)
    102e:	e398                	sd	a4,0(a5)
    1030:	a039                	j	103e <schedule_wrr+0x146>
    } else {
        // Idle if no suitable thread is found
        r.scheduled_thread_list_member = args.run_queue;
    1032:	649c                	ld	a5,8(s1)
    1034:	faf43023          	sd	a5,-96(s0)
        r.allocated_time = 1;
    1038:	4785                	li	a5,1
    103a:	faf42423          	sw	a5,-88(s0)
    }

    return r;
    103e:	fa043783          	ld	a5,-96(s0)
    1042:	faf43823          	sd	a5,-80(s0)
    1046:	fa843783          	ld	a5,-88(s0)
    104a:	faf43c23          	sd	a5,-72(s0)
    104e:	4701                	li	a4,0
    1050:	fb043703          	ld	a4,-80(s0)
    1054:	4781                	li	a5,0
    1056:	fb843783          	ld	a5,-72(s0)
    105a:	863a                	mv	a2,a4
    105c:	86be                	mv	a3,a5
    105e:	8732                	mv	a4,a2
    1060:	87b6                	mv	a5,a3
}
    1062:	853a                	mv	a0,a4
    1064:	85be                	mv	a1,a5
    1066:	6466                	ld	s0,88(sp)
    1068:	64c6                	ld	s1,80(sp)
    106a:	6125                	addi	sp,sp,96
    106c:	8082                	ret

000000000000106e <find_next_release_time>:

/* Shortest-Job-First Scheduling */
int find_next_release_time(struct list_head *release_queue, int current_time) {
    106e:	7139                	addi	sp,sp,-64
    1070:	fc22                	sd	s0,56(sp)
    1072:	0080                	addi	s0,sp,64
    1074:	fca43423          	sd	a0,-56(s0)
    1078:	87ae                	mv	a5,a1
    107a:	fcf42223          	sw	a5,-60(s0)
    struct release_queue_entry *next_release = NULL;
    107e:	fe043423          	sd	zero,-24(s0)
    int next_release_time = INT_MAX;
    1082:	800007b7          	lui	a5,0x80000
    1086:	fff7c793          	not	a5,a5
    108a:	fef42223          	sw	a5,-28(s0)

    list_for_each_entry(next_release, release_queue, thread_list) {
    108e:	fc843783          	ld	a5,-56(s0)
    1092:	639c                	ld	a5,0(a5)
    1094:	fcf43c23          	sd	a5,-40(s0)
    1098:	fd843783          	ld	a5,-40(s0)
    109c:	17e1                	addi	a5,a5,-8
    109e:	fef43423          	sd	a5,-24(s0)
    10a2:	a081                	j	10e2 <find_next_release_time+0x74>
        if (next_release->release_time > current_time &&
    10a4:	fe843783          	ld	a5,-24(s0)
    10a8:	4f98                	lw	a4,24(a5)
    10aa:	fc442783          	lw	a5,-60(s0)
    10ae:	2781                	sext.w	a5,a5
    10b0:	00e7df63          	bge	a5,a4,10ce <find_next_release_time+0x60>
            next_release->release_time < next_release_time) {
    10b4:	fe843783          	ld	a5,-24(s0)
    10b8:	4f98                	lw	a4,24(a5)
        if (next_release->release_time > current_time &&
    10ba:	fe442783          	lw	a5,-28(s0)
    10be:	2781                	sext.w	a5,a5
    10c0:	00f75763          	bge	a4,a5,10ce <find_next_release_time+0x60>
            next_release_time = next_release->release_time;
    10c4:	fe843783          	ld	a5,-24(s0)
    10c8:	4f9c                	lw	a5,24(a5)
    10ca:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(next_release, release_queue, thread_list) {
    10ce:	fe843783          	ld	a5,-24(s0)
    10d2:	679c                	ld	a5,8(a5)
    10d4:	fcf43823          	sd	a5,-48(s0)
    10d8:	fd043783          	ld	a5,-48(s0)
    10dc:	17e1                	addi	a5,a5,-8
    10de:	fef43423          	sd	a5,-24(s0)
    10e2:	fe843783          	ld	a5,-24(s0)
    10e6:	07a1                	addi	a5,a5,8
    10e8:	fc843703          	ld	a4,-56(s0)
    10ec:	faf71ce3          	bne	a4,a5,10a4 <find_next_release_time+0x36>
        }
    }

    if (next_release_time == INT_MAX)
    10f0:	fe442783          	lw	a5,-28(s0)
    10f4:	0007871b          	sext.w	a4,a5
    10f8:	800007b7          	lui	a5,0x80000
    10fc:	fff7c793          	not	a5,a5
    1100:	00f71463          	bne	a4,a5,1108 <find_next_release_time+0x9a>
        return -1; // No threads in the release queue
    1104:	57fd                	li	a5,-1
    1106:	a801                	j	1116 <find_next_release_time+0xa8>

    return next_release_time - current_time;
    1108:	fe442703          	lw	a4,-28(s0)
    110c:	fc442783          	lw	a5,-60(s0)
    1110:	40f707bb          	subw	a5,a4,a5
    1114:	2781                	sext.w	a5,a5
}
    1116:	853e                	mv	a0,a5
    1118:	7462                	ld	s0,56(sp)
    111a:	6121                	addi	sp,sp,64
    111c:	8082                	ret

000000000000111e <schedule_sjf>:


struct threads_sched_result schedule_sjf(struct threads_sched_args args)
{
    111e:	711d                	addi	sp,sp,-96
    1120:	eca2                	sd	s0,88(sp)
    1122:	e8a6                	sd	s1,80(sp)
    1124:	1080                	addi	s0,sp,96
    1126:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the shortest-job-first scheduling algorithm
    struct thread *shortest_job = NULL;
    1128:	fe043423          	sd	zero,-24(s0)
    struct thread *t;
    int shortest_time = INT_MAX;
    112c:	800007b7          	lui	a5,0x80000
    1130:	fff7c793          	not	a5,a5
    1134:	fcf42e23          	sw	a5,-36(s0)

    // Find the thread with the shortest remaining time that is ready to run
    list_for_each_entry(t, args.run_queue, thread_list) {
    1138:	649c                	ld	a5,8(s1)
    113a:	639c                	ld	a5,0(a5)
    113c:	fcf43823          	sd	a5,-48(s0)
    1140:	fd043783          	ld	a5,-48(s0)
    1144:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe298>
    1148:	fef43023          	sd	a5,-32(s0)
    114c:	a82d                	j	1186 <schedule_sjf+0x68>
        if (t->remaining_time < shortest_time) {
    114e:	fe043783          	ld	a5,-32(s0)
    1152:	4fb8                	lw	a4,88(a5)
    1154:	fdc42783          	lw	a5,-36(s0)
    1158:	2781                	sext.w	a5,a5
    115a:	00f75b63          	bge	a4,a5,1170 <schedule_sjf+0x52>
            shortest_time = t->remaining_time;
    115e:	fe043783          	ld	a5,-32(s0)
    1162:	4fbc                	lw	a5,88(a5)
    1164:	fcf42e23          	sw	a5,-36(s0)
            shortest_job = t;
    1168:	fe043783          	ld	a5,-32(s0)
    116c:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    1170:	fe043783          	ld	a5,-32(s0)
    1174:	779c                	ld	a5,40(a5)
    1176:	fcf43423          	sd	a5,-56(s0)
    117a:	fc843783          	ld	a5,-56(s0)
    117e:	fd878793          	addi	a5,a5,-40
    1182:	fef43023          	sd	a5,-32(s0)
    1186:	fe043783          	ld	a5,-32(s0)
    118a:	02878713          	addi	a4,a5,40
    118e:	649c                	ld	a5,8(s1)
    1190:	faf71fe3          	bne	a4,a5,114e <schedule_sjf+0x30>
        }
    }

    if (shortest_job) {
    1194:	fe843783          	ld	a5,-24(s0)
    1198:	cf89                	beqz	a5,11b2 <schedule_sjf+0x94>
        r.scheduled_thread_list_member = &shortest_job->thread_list;
    119a:	fe843783          	ld	a5,-24(s0)
    119e:	02878793          	addi	a5,a5,40
    11a2:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = shortest_job->remaining_time;  // Allow the thread to run to completion
    11a6:	fe843783          	ld	a5,-24(s0)
    11aa:	4fbc                	lw	a5,88(a5)
    11ac:	faf42823          	sw	a5,-80(s0)
    11b0:	a039                	j	11be <schedule_sjf+0xa0>
    } else {
        // If no threads are ready, find the next release time or idle
        r.scheduled_thread_list_member = args.run_queue;
    11b2:	649c                	ld	a5,8(s1)
    11b4:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = 1;  // Default minimal quantum if unsure
    11b8:	4785                	li	a5,1
    11ba:	faf42823          	sw	a5,-80(s0)
    }
    return r;
    11be:	fa843783          	ld	a5,-88(s0)
    11c2:	faf43c23          	sd	a5,-72(s0)
    11c6:	fb043783          	ld	a5,-80(s0)
    11ca:	fcf43023          	sd	a5,-64(s0)
    11ce:	4701                	li	a4,0
    11d0:	fb843703          	ld	a4,-72(s0)
    11d4:	4781                	li	a5,0
    11d6:	fc043783          	ld	a5,-64(s0)
    11da:	863a                	mv	a2,a4
    11dc:	86be                	mv	a3,a5
    11de:	8732                	mv	a4,a2
    11e0:	87b6                	mv	a5,a3
}
    11e2:	853a                	mv	a0,a4
    11e4:	85be                	mv	a1,a5
    11e6:	6466                	ld	s0,88(sp)
    11e8:	64c6                	ld	s1,80(sp)
    11ea:	6125                	addi	sp,sp,96
    11ec:	8082                	ret

00000000000011ee <schedule_lst>:

/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args)
{
    11ee:	7119                	addi	sp,sp,-128
    11f0:	fc86                	sd	ra,120(sp)
    11f2:	f8a2                	sd	s0,112(sp)
    11f4:	f4a6                	sd	s1,104(sp)
    11f6:	f0ca                	sd	s2,96(sp)
    11f8:	ecce                	sd	s3,88(sp)
    11fa:	0100                	addi	s0,sp,128
    11fc:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the least-slack-time scheduling algorithm
    struct thread *min_slack = NULL;
    11fe:	fc043423          	sd	zero,-56(s0)
    int min_slack_time = INT_MAX;
    1202:	800007b7          	lui	a5,0x80000
    1206:	fff7c793          	not	a5,a5
    120a:	fcf42223          	sw	a5,-60(s0)
    struct thread *t;

    // Find the thread with the minimum slack time
    list_for_each_entry(t, args.run_queue, thread_list) {
    120e:	649c                	ld	a5,8(s1)
    1210:	639c                	ld	a5,0(a5)
    1212:	faf43823          	sd	a5,-80(s0)
    1216:	fb043783          	ld	a5,-80(s0)
    121a:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe298>
    121e:	faf43c23          	sd	a5,-72(s0)
    1222:	a8b5                	j	129e <schedule_lst+0xb0>
        int slack_time = t->deadline - args.current_time - t->remaining_time;
    1224:	fb843783          	ld	a5,-72(s0)
    1228:	47f8                	lw	a4,76(a5)
    122a:	409c                	lw	a5,0(s1)
    122c:	40f707bb          	subw	a5,a4,a5
    1230:	0007871b          	sext.w	a4,a5
    1234:	fb843783          	ld	a5,-72(s0)
    1238:	4fbc                	lw	a5,88(a5)
    123a:	40f707bb          	subw	a5,a4,a5
    123e:	faf42623          	sw	a5,-84(s0)
        if (min_slack == NULL || slack_time < min_slack_time ||
    1242:	fc843783          	ld	a5,-56(s0)
    1246:	cb8d                	beqz	a5,1278 <schedule_lst+0x8a>
    1248:	fac42703          	lw	a4,-84(s0)
    124c:	fc442783          	lw	a5,-60(s0)
    1250:	2701                	sext.w	a4,a4
    1252:	2781                	sext.w	a5,a5
    1254:	02f74263          	blt	a4,a5,1278 <schedule_lst+0x8a>
    1258:	fac42703          	lw	a4,-84(s0)
    125c:	fc442783          	lw	a5,-60(s0)
    1260:	2701                	sext.w	a4,a4
    1262:	2781                	sext.w	a5,a5
    1264:	02f71263          	bne	a4,a5,1288 <schedule_lst+0x9a>
            (slack_time == min_slack_time && t->ID < min_slack->ID)) {
    1268:	fb843783          	ld	a5,-72(s0)
    126c:	5fd8                	lw	a4,60(a5)
    126e:	fc843783          	ld	a5,-56(s0)
    1272:	5fdc                	lw	a5,60(a5)
    1274:	00f75a63          	bge	a4,a5,1288 <schedule_lst+0x9a>
            min_slack = t;
    1278:	fb843783          	ld	a5,-72(s0)
    127c:	fcf43423          	sd	a5,-56(s0)
            min_slack_time = slack_time;
    1280:	fac42783          	lw	a5,-84(s0)
    1284:	fcf42223          	sw	a5,-60(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    1288:	fb843783          	ld	a5,-72(s0)
    128c:	779c                	ld	a5,40(a5)
    128e:	faf43023          	sd	a5,-96(s0)
    1292:	fa043783          	ld	a5,-96(s0)
    1296:	fd878793          	addi	a5,a5,-40
    129a:	faf43c23          	sd	a5,-72(s0)
    129e:	fb843783          	ld	a5,-72(s0)
    12a2:	02878713          	addi	a4,a5,40
    12a6:	649c                	ld	a5,8(s1)
    12a8:	f6f71ee3          	bne	a4,a5,1224 <schedule_lst+0x36>
        }
    }

    if (min_slack) {
    12ac:	fc843783          	ld	a5,-56(s0)
    12b0:	cf89                	beqz	a5,12ca <schedule_lst+0xdc>
        r.scheduled_thread_list_member = &min_slack->thread_list;
    12b2:	fc843783          	ld	a5,-56(s0)
    12b6:	02878793          	addi	a5,a5,40
    12ba:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = min_slack->remaining_time;
    12be:	fc843783          	ld	a5,-56(s0)
    12c2:	4fbc                	lw	a5,88(a5)
    12c4:	f8f42423          	sw	a5,-120(s0)
    12c8:	a839                	j	12e6 <schedule_lst+0xf8>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
    12ca:	649c                	ld	a5,8(s1)
    12cc:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    12d0:	689c                	ld	a5,16(s1)
    12d2:	4098                	lw	a4,0(s1)
    12d4:	85ba                	mv	a1,a4
    12d6:	853e                	mv	a0,a5
    12d8:	00000097          	auipc	ra,0x0
    12dc:	d96080e7          	jalr	-618(ra) # 106e <find_next_release_time>
    12e0:	87aa                	mv	a5,a0
    12e2:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    12e6:	f8043783          	ld	a5,-128(s0)
    12ea:	f8f43823          	sd	a5,-112(s0)
    12ee:	f8843783          	ld	a5,-120(s0)
    12f2:	f8f43c23          	sd	a5,-104(s0)
    12f6:	4701                	li	a4,0
    12f8:	f9043703          	ld	a4,-112(s0)
    12fc:	4781                	li	a5,0
    12fe:	f9843783          	ld	a5,-104(s0)
    1302:	893a                	mv	s2,a4
    1304:	89be                	mv	s3,a5
    1306:	874a                	mv	a4,s2
    1308:	87ce                	mv	a5,s3
}
    130a:	853a                	mv	a0,a4
    130c:	85be                	mv	a1,a5
    130e:	70e6                	ld	ra,120(sp)
    1310:	7446                	ld	s0,112(sp)
    1312:	74a6                	ld	s1,104(sp)
    1314:	7906                	ld	s2,96(sp)
    1316:	69e6                	ld	s3,88(sp)
    1318:	6109                	addi	sp,sp,128
    131a:	8082                	ret

000000000000131c <schedule_dm>:

/* Deadline-Monotonic Scheduling */
struct threads_sched_result schedule_dm(struct threads_sched_args args)
{
    131c:	7135                	addi	sp,sp,-160
    131e:	ed06                	sd	ra,152(sp)
    1320:	e922                	sd	s0,144(sp)
    1322:	e526                	sd	s1,136(sp)
    1324:	e14a                	sd	s2,128(sp)
    1326:	fcce                	sd	s3,120(sp)
    1328:	1100                	addi	s0,sp,160
    132a:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the deadline-monotonic scheduling algorithm
   struct thread *earliest_deadline_thread = NULL;
    132c:	fc043423          	sd	zero,-56(s0)
    struct thread *t;
    int earliest_deadline = INT_MAX;
    1330:	800007b7          	lui	a5,0x80000
    1334:	fff7c793          	not	a5,a5
    1338:	faf42e23          	sw	a5,-68(s0)

    // Find the earliest deadline real-time thread
    list_for_each_entry(t, args.run_queue, thread_list) {
    133c:	649c                	ld	a5,8(s1)
    133e:	639c                	ld	a5,0(a5)
    1340:	faf43423          	sd	a5,-88(s0)
    1344:	fa843783          	ld	a5,-88(s0)
    1348:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe298>
    134c:	fcf43023          	sd	a5,-64(s0)
    1350:	a841                	j	13e0 <schedule_dm+0xc4>
        if (t->is_real_time && t->period != -1 && t->current_deadline < earliest_deadline) {
    1352:	fc043783          	ld	a5,-64(s0)
    1356:	43bc                	lw	a5,64(a5)
    1358:	cb95                	beqz	a5,138c <schedule_dm+0x70>
    135a:	fc043783          	ld	a5,-64(s0)
    135e:	4bbc                	lw	a5,80(a5)
    1360:	873e                	mv	a4,a5
    1362:	57fd                	li	a5,-1
    1364:	02f70463          	beq	a4,a5,138c <schedule_dm+0x70>
    1368:	fc043783          	ld	a5,-64(s0)
    136c:	4ff8                	lw	a4,92(a5)
    136e:	fbc42783          	lw	a5,-68(s0)
    1372:	2781                	sext.w	a5,a5
    1374:	00f75c63          	bge	a4,a5,138c <schedule_dm+0x70>
            earliest_deadline = t->current_deadline;
    1378:	fc043783          	ld	a5,-64(s0)
    137c:	4ffc                	lw	a5,92(a5)
    137e:	faf42e23          	sw	a5,-68(s0)
            earliest_deadline_thread = t;
    1382:	fc043783          	ld	a5,-64(s0)
    1386:	fcf43423          	sd	a5,-56(s0)
    138a:	a081                	j	13ca <schedule_dm+0xae>
        } else if (t->is_real_time && t->period != -1 && t->current_deadline == earliest_deadline && t->ID < earliest_deadline_thread->ID) {
    138c:	fc043783          	ld	a5,-64(s0)
    1390:	43bc                	lw	a5,64(a5)
    1392:	cf85                	beqz	a5,13ca <schedule_dm+0xae>
    1394:	fc043783          	ld	a5,-64(s0)
    1398:	4bbc                	lw	a5,80(a5)
    139a:	873e                	mv	a4,a5
    139c:	57fd                	li	a5,-1
    139e:	02f70663          	beq	a4,a5,13ca <schedule_dm+0xae>
    13a2:	fc043783          	ld	a5,-64(s0)
    13a6:	4ff8                	lw	a4,92(a5)
    13a8:	fbc42783          	lw	a5,-68(s0)
    13ac:	2781                	sext.w	a5,a5
    13ae:	00e79e63          	bne	a5,a4,13ca <schedule_dm+0xae>
    13b2:	fc043783          	ld	a5,-64(s0)
    13b6:	5fd8                	lw	a4,60(a5)
    13b8:	fc843783          	ld	a5,-56(s0)
    13bc:	5fdc                	lw	a5,60(a5)
    13be:	00f75663          	bge	a4,a5,13ca <schedule_dm+0xae>
            earliest_deadline_thread = t;  // Tie-breaking by ID
    13c2:	fc043783          	ld	a5,-64(s0)
    13c6:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    13ca:	fc043783          	ld	a5,-64(s0)
    13ce:	779c                	ld	a5,40(a5)
    13d0:	f8f43423          	sd	a5,-120(s0)
    13d4:	f8843783          	ld	a5,-120(s0)
    13d8:	fd878793          	addi	a5,a5,-40
    13dc:	fcf43023          	sd	a5,-64(s0)
    13e0:	fc043783          	ld	a5,-64(s0)
    13e4:	02878713          	addi	a4,a5,40
    13e8:	649c                	ld	a5,8(s1)
    13ea:	f6f714e3          	bne	a4,a5,1352 <schedule_dm+0x36>
        }
    }

    if (earliest_deadline_thread) {
    13ee:	fc843783          	ld	a5,-56(s0)
    13f2:	c7a5                	beqz	a5,145a <schedule_dm+0x13e>
        int time_to_deadline = earliest_deadline_thread->current_deadline - args.current_time;
    13f4:	fc843783          	ld	a5,-56(s0)
    13f8:	4ff8                	lw	a4,92(a5)
    13fa:	409c                	lw	a5,0(s1)
    13fc:	40f707bb          	subw	a5,a4,a5
    1400:	f8f42a23          	sw	a5,-108(s0)
        if (earliest_deadline_thread->remaining_time > time_to_deadline) {
    1404:	fc843783          	ld	a5,-56(s0)
    1408:	4fb8                	lw	a4,88(a5)
    140a:	f9442783          	lw	a5,-108(s0)
    140e:	2781                	sext.w	a5,a5
    1410:	00e7db63          	bge	a5,a4,1426 <schedule_dm+0x10a>
            // The real-time thread cannot complete before its deadline, so handle the deadline miss
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    1414:	fc843783          	ld	a5,-56(s0)
    1418:	02878793          	addi	a5,a5,40
    141c:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = 0; // Could set to minimal quantum to allow cleanup or logging
    1420:	f6042823          	sw	zero,-144(s0)
    1424:	a0f1                	j	14f0 <schedule_dm+0x1d4>
        } else {
            // Schedule the real-time thread normally if it hasn't missed its deadline
            int time_slice = (time_to_deadline < earliest_deadline_thread->remaining_time) ? time_to_deadline : earliest_deadline_thread->remaining_time;
    1426:	fc843783          	ld	a5,-56(s0)
    142a:	4fbc                	lw	a5,88(a5)
    142c:	863e                	mv	a2,a5
    142e:	f9442783          	lw	a5,-108(s0)
    1432:	0007869b          	sext.w	a3,a5
    1436:	0006071b          	sext.w	a4,a2
    143a:	00d75363          	bge	a4,a3,1440 <schedule_dm+0x124>
    143e:	87b2                	mv	a5,a2
    1440:	f8f42823          	sw	a5,-112(s0)
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    1444:	fc843783          	ld	a5,-56(s0)
    1448:	02878793          	addi	a5,a5,40
    144c:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = time_slice;
    1450:	f9042783          	lw	a5,-112(s0)
    1454:	f6f42823          	sw	a5,-144(s0)
    1458:	a861                	j	14f0 <schedule_dm+0x1d4>
        }
    } else {
        // If no real-time threads with a deadline are ready, find the thread with the smallest ID
        struct thread *smallest_id_thread = NULL;
    145a:	fa043823          	sd	zero,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    145e:	649c                	ld	a5,8(s1)
    1460:	639c                	ld	a5,0(a5)
    1462:	faf43023          	sd	a5,-96(s0)
    1466:	fa043783          	ld	a5,-96(s0)
    146a:	fd878793          	addi	a5,a5,-40
    146e:	fcf43023          	sd	a5,-64(s0)
    1472:	a81d                	j	14a8 <schedule_dm+0x18c>
            if (smallest_id_thread == NULL || t->ID < smallest_id_thread->ID) {
    1474:	fb043783          	ld	a5,-80(s0)
    1478:	cb89                	beqz	a5,148a <schedule_dm+0x16e>
    147a:	fc043783          	ld	a5,-64(s0)
    147e:	5fd8                	lw	a4,60(a5)
    1480:	fb043783          	ld	a5,-80(s0)
    1484:	5fdc                	lw	a5,60(a5)
    1486:	00f75663          	bge	a4,a5,1492 <schedule_dm+0x176>
                smallest_id_thread = t;
    148a:	fc043783          	ld	a5,-64(s0)
    148e:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    1492:	fc043783          	ld	a5,-64(s0)
    1496:	779c                	ld	a5,40(a5)
    1498:	f8f43c23          	sd	a5,-104(s0)
    149c:	f9843783          	ld	a5,-104(s0)
    14a0:	fd878793          	addi	a5,a5,-40
    14a4:	fcf43023          	sd	a5,-64(s0)
    14a8:	fc043783          	ld	a5,-64(s0)
    14ac:	02878713          	addi	a4,a5,40
    14b0:	649c                	ld	a5,8(s1)
    14b2:	fcf711e3          	bne	a4,a5,1474 <schedule_dm+0x158>
            }
        }

        if (smallest_id_thread) {
    14b6:	fb043783          	ld	a5,-80(s0)
    14ba:	cf89                	beqz	a5,14d4 <schedule_dm+0x1b8>
            r.scheduled_thread_list_member = &smallest_id_thread->thread_list;
    14bc:	fb043783          	ld	a5,-80(s0)
    14c0:	02878793          	addi	a5,a5,40
    14c4:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = smallest_id_thread->remaining_time;
    14c8:	fb043783          	ld	a5,-80(s0)
    14cc:	4fbc                	lw	a5,88(a5)
    14ce:	f6f42823          	sw	a5,-144(s0)
    14d2:	a839                	j	14f0 <schedule_dm+0x1d4>
        } else {
            // If no thread is ready, perhaps idle or find the next release time
            r.scheduled_thread_list_member = args.run_queue;
    14d4:	649c                	ld	a5,8(s1)
    14d6:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    14da:	689c                	ld	a5,16(s1)
    14dc:	4098                	lw	a4,0(s1)
    14de:	85ba                	mv	a1,a4
    14e0:	853e                	mv	a0,a5
    14e2:	00000097          	auipc	ra,0x0
    14e6:	b8c080e7          	jalr	-1140(ra) # 106e <find_next_release_time>
    14ea:	87aa                	mv	a5,a0
    14ec:	f6f42823          	sw	a5,-144(s0)
        }
    }

    return r;
    14f0:	f6843783          	ld	a5,-152(s0)
    14f4:	f6f43c23          	sd	a5,-136(s0)
    14f8:	f7043783          	ld	a5,-144(s0)
    14fc:	f8f43023          	sd	a5,-128(s0)
    1500:	4701                	li	a4,0
    1502:	f7843703          	ld	a4,-136(s0)
    1506:	4781                	li	a5,0
    1508:	f8043783          	ld	a5,-128(s0)
    150c:	893a                	mv	s2,a4
    150e:	89be                	mv	s3,a5
    1510:	874a                	mv	a4,s2
    1512:	87ce                	mv	a5,s3
}
    1514:	853a                	mv	a0,a4
    1516:	85be                	mv	a1,a5
    1518:	60ea                	ld	ra,152(sp)
    151a:	644a                	ld	s0,144(sp)
    151c:	64aa                	ld	s1,136(sp)
    151e:	690a                	ld	s2,128(sp)
    1520:	79e6                	ld	s3,120(sp)
    1522:	610d                	addi	sp,sp,160
    1524:	8082                	ret
