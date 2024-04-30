
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
       0:	7179                	addi	sp,sp,-48
       2:	f406                	sd	ra,40(sp)
       4:	f022                	sd	s0,32(sp)
       6:	1800                	addi	s0,sp,48
       8:	87aa                	mv	a5,a0
       a:	fcf42e23          	sw	a5,-36(s0)
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
       e:	a091                	j	52 <cat+0x52>
    if (write(1, buf, n) != n) {
      10:	fec42783          	lw	a5,-20(s0)
      14:	863e                	mv	a2,a5
      16:	00001597          	auipc	a1,0x1
      1a:	68258593          	addi	a1,a1,1666 # 1698 <buf>
      1e:	4505                	li	a0,1
      20:	00000097          	auipc	ra,0x0
      24:	60e080e7          	jalr	1550(ra) # 62e <write>
      28:	87aa                	mv	a5,a0
      2a:	873e                	mv	a4,a5
      2c:	fec42783          	lw	a5,-20(s0)
      30:	2781                	sext.w	a5,a5
      32:	02e78063          	beq	a5,a4,52 <cat+0x52>
      fprintf(2, "cat: write error\n");
      36:	00001597          	auipc	a1,0x1
      3a:	5d258593          	addi	a1,a1,1490 # 1608 <schedule_dm+0x20c>
      3e:	4509                	li	a0,2
      40:	00001097          	auipc	ra,0x1
      44:	abc080e7          	jalr	-1348(ra) # afc <fprintf>
      exit(1);
      48:	4505                	li	a0,1
      4a:	00000097          	auipc	ra,0x0
      4e:	5c4080e7          	jalr	1476(ra) # 60e <exit>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
      52:	fdc42783          	lw	a5,-36(s0)
      56:	20000613          	li	a2,512
      5a:	00001597          	auipc	a1,0x1
      5e:	63e58593          	addi	a1,a1,1598 # 1698 <buf>
      62:	853e                	mv	a0,a5
      64:	00000097          	auipc	ra,0x0
      68:	5c2080e7          	jalr	1474(ra) # 626 <read>
      6c:	87aa                	mv	a5,a0
      6e:	fef42623          	sw	a5,-20(s0)
      72:	fec42783          	lw	a5,-20(s0)
      76:	2781                	sext.w	a5,a5
      78:	f8f04ce3          	bgtz	a5,10 <cat+0x10>
    }
  }
  if(n < 0){
      7c:	fec42783          	lw	a5,-20(s0)
      80:	2781                	sext.w	a5,a5
      82:	0207d063          	bgez	a5,a2 <cat+0xa2>
    fprintf(2, "cat: read error\n");
      86:	00001597          	auipc	a1,0x1
      8a:	59a58593          	addi	a1,a1,1434 # 1620 <schedule_dm+0x224>
      8e:	4509                	li	a0,2
      90:	00001097          	auipc	ra,0x1
      94:	a6c080e7          	jalr	-1428(ra) # afc <fprintf>
    exit(1);
      98:	4505                	li	a0,1
      9a:	00000097          	auipc	ra,0x0
      9e:	574080e7          	jalr	1396(ra) # 60e <exit>
  }
}
      a2:	0001                	nop
      a4:	70a2                	ld	ra,40(sp)
      a6:	7402                	ld	s0,32(sp)
      a8:	6145                	addi	sp,sp,48
      aa:	8082                	ret

00000000000000ac <main>:

int
main(int argc, char *argv[])
{
      ac:	7179                	addi	sp,sp,-48
      ae:	f406                	sd	ra,40(sp)
      b0:	f022                	sd	s0,32(sp)
      b2:	1800                	addi	s0,sp,48
      b4:	87aa                	mv	a5,a0
      b6:	fcb43823          	sd	a1,-48(s0)
      ba:	fcf42e23          	sw	a5,-36(s0)
  int fd, i;

  if(argc <= 1){
      be:	fdc42783          	lw	a5,-36(s0)
      c2:	0007871b          	sext.w	a4,a5
      c6:	4785                	li	a5,1
      c8:	00e7cc63          	blt	a5,a4,e0 <main+0x34>
    cat(0);
      cc:	4501                	li	a0,0
      ce:	00000097          	auipc	ra,0x0
      d2:	f32080e7          	jalr	-206(ra) # 0 <cat>
    exit(0);
      d6:	4501                	li	a0,0
      d8:	00000097          	auipc	ra,0x0
      dc:	536080e7          	jalr	1334(ra) # 60e <exit>
  }

  for(i = 1; i < argc; i++){
      e0:	4785                	li	a5,1
      e2:	fef42623          	sw	a5,-20(s0)
      e6:	a8bd                	j	164 <main+0xb8>
    if((fd = open(argv[i], 0)) < 0){
      e8:	fec42783          	lw	a5,-20(s0)
      ec:	078e                	slli	a5,a5,0x3
      ee:	fd043703          	ld	a4,-48(s0)
      f2:	97ba                	add	a5,a5,a4
      f4:	639c                	ld	a5,0(a5)
      f6:	4581                	li	a1,0
      f8:	853e                	mv	a0,a5
      fa:	00000097          	auipc	ra,0x0
      fe:	554080e7          	jalr	1364(ra) # 64e <open>
     102:	87aa                	mv	a5,a0
     104:	fef42423          	sw	a5,-24(s0)
     108:	fe842783          	lw	a5,-24(s0)
     10c:	2781                	sext.w	a5,a5
     10e:	0207d863          	bgez	a5,13e <main+0x92>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
     112:	fec42783          	lw	a5,-20(s0)
     116:	078e                	slli	a5,a5,0x3
     118:	fd043703          	ld	a4,-48(s0)
     11c:	97ba                	add	a5,a5,a4
     11e:	639c                	ld	a5,0(a5)
     120:	863e                	mv	a2,a5
     122:	00001597          	auipc	a1,0x1
     126:	51658593          	addi	a1,a1,1302 # 1638 <schedule_dm+0x23c>
     12a:	4509                	li	a0,2
     12c:	00001097          	auipc	ra,0x1
     130:	9d0080e7          	jalr	-1584(ra) # afc <fprintf>
      exit(1);
     134:	4505                	li	a0,1
     136:	00000097          	auipc	ra,0x0
     13a:	4d8080e7          	jalr	1240(ra) # 60e <exit>
    }
    cat(fd);
     13e:	fe842783          	lw	a5,-24(s0)
     142:	853e                	mv	a0,a5
     144:	00000097          	auipc	ra,0x0
     148:	ebc080e7          	jalr	-324(ra) # 0 <cat>
    close(fd);
     14c:	fe842783          	lw	a5,-24(s0)
     150:	853e                	mv	a0,a5
     152:	00000097          	auipc	ra,0x0
     156:	4e4080e7          	jalr	1252(ra) # 636 <close>
  for(i = 1; i < argc; i++){
     15a:	fec42783          	lw	a5,-20(s0)
     15e:	2785                	addiw	a5,a5,1
     160:	fef42623          	sw	a5,-20(s0)
     164:	fec42703          	lw	a4,-20(s0)
     168:	fdc42783          	lw	a5,-36(s0)
     16c:	2701                	sext.w	a4,a4
     16e:	2781                	sext.w	a5,a5
     170:	f6f74ce3          	blt	a4,a5,e8 <main+0x3c>
  }
  exit(0);
     174:	4501                	li	a0,0
     176:	00000097          	auipc	ra,0x0
     17a:	498080e7          	jalr	1176(ra) # 60e <exit>

000000000000017e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     17e:	7179                	addi	sp,sp,-48
     180:	f422                	sd	s0,40(sp)
     182:	1800                	addi	s0,sp,48
     184:	fca43c23          	sd	a0,-40(s0)
     188:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     18c:	fd843783          	ld	a5,-40(s0)
     190:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     194:	0001                	nop
     196:	fd043703          	ld	a4,-48(s0)
     19a:	00170793          	addi	a5,a4,1
     19e:	fcf43823          	sd	a5,-48(s0)
     1a2:	fd843783          	ld	a5,-40(s0)
     1a6:	00178693          	addi	a3,a5,1
     1aa:	fcd43c23          	sd	a3,-40(s0)
     1ae:	00074703          	lbu	a4,0(a4)
     1b2:	00e78023          	sb	a4,0(a5)
     1b6:	0007c783          	lbu	a5,0(a5)
     1ba:	fff1                	bnez	a5,196 <strcpy+0x18>
    ;
  return os;
     1bc:	fe843783          	ld	a5,-24(s0)
}
     1c0:	853e                	mv	a0,a5
     1c2:	7422                	ld	s0,40(sp)
     1c4:	6145                	addi	sp,sp,48
     1c6:	8082                	ret

00000000000001c8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     1c8:	1101                	addi	sp,sp,-32
     1ca:	ec22                	sd	s0,24(sp)
     1cc:	1000                	addi	s0,sp,32
     1ce:	fea43423          	sd	a0,-24(s0)
     1d2:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     1d6:	a819                	j	1ec <strcmp+0x24>
    p++, q++;
     1d8:	fe843783          	ld	a5,-24(s0)
     1dc:	0785                	addi	a5,a5,1
     1de:	fef43423          	sd	a5,-24(s0)
     1e2:	fe043783          	ld	a5,-32(s0)
     1e6:	0785                	addi	a5,a5,1
     1e8:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     1ec:	fe843783          	ld	a5,-24(s0)
     1f0:	0007c783          	lbu	a5,0(a5)
     1f4:	cb99                	beqz	a5,20a <strcmp+0x42>
     1f6:	fe843783          	ld	a5,-24(s0)
     1fa:	0007c703          	lbu	a4,0(a5)
     1fe:	fe043783          	ld	a5,-32(s0)
     202:	0007c783          	lbu	a5,0(a5)
     206:	fcf709e3          	beq	a4,a5,1d8 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     20a:	fe843783          	ld	a5,-24(s0)
     20e:	0007c783          	lbu	a5,0(a5)
     212:	0007871b          	sext.w	a4,a5
     216:	fe043783          	ld	a5,-32(s0)
     21a:	0007c783          	lbu	a5,0(a5)
     21e:	2781                	sext.w	a5,a5
     220:	40f707bb          	subw	a5,a4,a5
     224:	2781                	sext.w	a5,a5
}
     226:	853e                	mv	a0,a5
     228:	6462                	ld	s0,24(sp)
     22a:	6105                	addi	sp,sp,32
     22c:	8082                	ret

000000000000022e <strlen>:

uint
strlen(const char *s)
{
     22e:	7179                	addi	sp,sp,-48
     230:	f422                	sd	s0,40(sp)
     232:	1800                	addi	s0,sp,48
     234:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     238:	fe042623          	sw	zero,-20(s0)
     23c:	a031                	j	248 <strlen+0x1a>
     23e:	fec42783          	lw	a5,-20(s0)
     242:	2785                	addiw	a5,a5,1
     244:	fef42623          	sw	a5,-20(s0)
     248:	fec42783          	lw	a5,-20(s0)
     24c:	fd843703          	ld	a4,-40(s0)
     250:	97ba                	add	a5,a5,a4
     252:	0007c783          	lbu	a5,0(a5)
     256:	f7e5                	bnez	a5,23e <strlen+0x10>
    ;
  return n;
     258:	fec42783          	lw	a5,-20(s0)
}
     25c:	853e                	mv	a0,a5
     25e:	7422                	ld	s0,40(sp)
     260:	6145                	addi	sp,sp,48
     262:	8082                	ret

0000000000000264 <memset>:

void*
memset(void *dst, int c, uint n)
{
     264:	7179                	addi	sp,sp,-48
     266:	f422                	sd	s0,40(sp)
     268:	1800                	addi	s0,sp,48
     26a:	fca43c23          	sd	a0,-40(s0)
     26e:	87ae                	mv	a5,a1
     270:	8732                	mv	a4,a2
     272:	fcf42a23          	sw	a5,-44(s0)
     276:	87ba                	mv	a5,a4
     278:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     27c:	fd843783          	ld	a5,-40(s0)
     280:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     284:	fe042623          	sw	zero,-20(s0)
     288:	a00d                	j	2aa <memset+0x46>
    cdst[i] = c;
     28a:	fec42783          	lw	a5,-20(s0)
     28e:	fe043703          	ld	a4,-32(s0)
     292:	97ba                	add	a5,a5,a4
     294:	fd442703          	lw	a4,-44(s0)
     298:	0ff77713          	andi	a4,a4,255
     29c:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     2a0:	fec42783          	lw	a5,-20(s0)
     2a4:	2785                	addiw	a5,a5,1
     2a6:	fef42623          	sw	a5,-20(s0)
     2aa:	fec42703          	lw	a4,-20(s0)
     2ae:	fd042783          	lw	a5,-48(s0)
     2b2:	2781                	sext.w	a5,a5
     2b4:	fcf76be3          	bltu	a4,a5,28a <memset+0x26>
  }
  return dst;
     2b8:	fd843783          	ld	a5,-40(s0)
}
     2bc:	853e                	mv	a0,a5
     2be:	7422                	ld	s0,40(sp)
     2c0:	6145                	addi	sp,sp,48
     2c2:	8082                	ret

00000000000002c4 <strchr>:

char*
strchr(const char *s, char c)
{
     2c4:	1101                	addi	sp,sp,-32
     2c6:	ec22                	sd	s0,24(sp)
     2c8:	1000                	addi	s0,sp,32
     2ca:	fea43423          	sd	a0,-24(s0)
     2ce:	87ae                	mv	a5,a1
     2d0:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     2d4:	a01d                	j	2fa <strchr+0x36>
    if(*s == c)
     2d6:	fe843783          	ld	a5,-24(s0)
     2da:	0007c703          	lbu	a4,0(a5)
     2de:	fe744783          	lbu	a5,-25(s0)
     2e2:	0ff7f793          	andi	a5,a5,255
     2e6:	00e79563          	bne	a5,a4,2f0 <strchr+0x2c>
      return (char*)s;
     2ea:	fe843783          	ld	a5,-24(s0)
     2ee:	a821                	j	306 <strchr+0x42>
  for(; *s; s++)
     2f0:	fe843783          	ld	a5,-24(s0)
     2f4:	0785                	addi	a5,a5,1
     2f6:	fef43423          	sd	a5,-24(s0)
     2fa:	fe843783          	ld	a5,-24(s0)
     2fe:	0007c783          	lbu	a5,0(a5)
     302:	fbf1                	bnez	a5,2d6 <strchr+0x12>
  return 0;
     304:	4781                	li	a5,0
}
     306:	853e                	mv	a0,a5
     308:	6462                	ld	s0,24(sp)
     30a:	6105                	addi	sp,sp,32
     30c:	8082                	ret

000000000000030e <gets>:

char*
gets(char *buf, int max)
{
     30e:	7179                	addi	sp,sp,-48
     310:	f406                	sd	ra,40(sp)
     312:	f022                	sd	s0,32(sp)
     314:	1800                	addi	s0,sp,48
     316:	fca43c23          	sd	a0,-40(s0)
     31a:	87ae                	mv	a5,a1
     31c:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     320:	fe042623          	sw	zero,-20(s0)
     324:	a8a1                	j	37c <gets+0x6e>
    cc = read(0, &c, 1);
     326:	fe740793          	addi	a5,s0,-25
     32a:	4605                	li	a2,1
     32c:	85be                	mv	a1,a5
     32e:	4501                	li	a0,0
     330:	00000097          	auipc	ra,0x0
     334:	2f6080e7          	jalr	758(ra) # 626 <read>
     338:	87aa                	mv	a5,a0
     33a:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     33e:	fe842783          	lw	a5,-24(s0)
     342:	2781                	sext.w	a5,a5
     344:	04f05763          	blez	a5,392 <gets+0x84>
      break;
    buf[i++] = c;
     348:	fec42783          	lw	a5,-20(s0)
     34c:	0017871b          	addiw	a4,a5,1
     350:	fee42623          	sw	a4,-20(s0)
     354:	873e                	mv	a4,a5
     356:	fd843783          	ld	a5,-40(s0)
     35a:	97ba                	add	a5,a5,a4
     35c:	fe744703          	lbu	a4,-25(s0)
     360:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     364:	fe744783          	lbu	a5,-25(s0)
     368:	873e                	mv	a4,a5
     36a:	47a9                	li	a5,10
     36c:	02f70463          	beq	a4,a5,394 <gets+0x86>
     370:	fe744783          	lbu	a5,-25(s0)
     374:	873e                	mv	a4,a5
     376:	47b5                	li	a5,13
     378:	00f70e63          	beq	a4,a5,394 <gets+0x86>
  for(i=0; i+1 < max; ){
     37c:	fec42783          	lw	a5,-20(s0)
     380:	2785                	addiw	a5,a5,1
     382:	0007871b          	sext.w	a4,a5
     386:	fd442783          	lw	a5,-44(s0)
     38a:	2781                	sext.w	a5,a5
     38c:	f8f74de3          	blt	a4,a5,326 <gets+0x18>
     390:	a011                	j	394 <gets+0x86>
      break;
     392:	0001                	nop
      break;
  }
  buf[i] = '\0';
     394:	fec42783          	lw	a5,-20(s0)
     398:	fd843703          	ld	a4,-40(s0)
     39c:	97ba                	add	a5,a5,a4
     39e:	00078023          	sb	zero,0(a5)
  return buf;
     3a2:	fd843783          	ld	a5,-40(s0)
}
     3a6:	853e                	mv	a0,a5
     3a8:	70a2                	ld	ra,40(sp)
     3aa:	7402                	ld	s0,32(sp)
     3ac:	6145                	addi	sp,sp,48
     3ae:	8082                	ret

00000000000003b0 <stat>:

int
stat(const char *n, struct stat *st)
{
     3b0:	7179                	addi	sp,sp,-48
     3b2:	f406                	sd	ra,40(sp)
     3b4:	f022                	sd	s0,32(sp)
     3b6:	1800                	addi	s0,sp,48
     3b8:	fca43c23          	sd	a0,-40(s0)
     3bc:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     3c0:	4581                	li	a1,0
     3c2:	fd843503          	ld	a0,-40(s0)
     3c6:	00000097          	auipc	ra,0x0
     3ca:	288080e7          	jalr	648(ra) # 64e <open>
     3ce:	87aa                	mv	a5,a0
     3d0:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     3d4:	fec42783          	lw	a5,-20(s0)
     3d8:	2781                	sext.w	a5,a5
     3da:	0007d463          	bgez	a5,3e2 <stat+0x32>
    return -1;
     3de:	57fd                	li	a5,-1
     3e0:	a035                	j	40c <stat+0x5c>
  r = fstat(fd, st);
     3e2:	fec42783          	lw	a5,-20(s0)
     3e6:	fd043583          	ld	a1,-48(s0)
     3ea:	853e                	mv	a0,a5
     3ec:	00000097          	auipc	ra,0x0
     3f0:	27a080e7          	jalr	634(ra) # 666 <fstat>
     3f4:	87aa                	mv	a5,a0
     3f6:	fef42423          	sw	a5,-24(s0)
  close(fd);
     3fa:	fec42783          	lw	a5,-20(s0)
     3fe:	853e                	mv	a0,a5
     400:	00000097          	auipc	ra,0x0
     404:	236080e7          	jalr	566(ra) # 636 <close>
  return r;
     408:	fe842783          	lw	a5,-24(s0)
}
     40c:	853e                	mv	a0,a5
     40e:	70a2                	ld	ra,40(sp)
     410:	7402                	ld	s0,32(sp)
     412:	6145                	addi	sp,sp,48
     414:	8082                	ret

0000000000000416 <atoi>:

int
atoi(const char *s)
{
     416:	7179                	addi	sp,sp,-48
     418:	f422                	sd	s0,40(sp)
     41a:	1800                	addi	s0,sp,48
     41c:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     420:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     424:	a815                	j	458 <atoi+0x42>
    n = n*10 + *s++ - '0';
     426:	fec42703          	lw	a4,-20(s0)
     42a:	87ba                	mv	a5,a4
     42c:	0027979b          	slliw	a5,a5,0x2
     430:	9fb9                	addw	a5,a5,a4
     432:	0017979b          	slliw	a5,a5,0x1
     436:	0007871b          	sext.w	a4,a5
     43a:	fd843783          	ld	a5,-40(s0)
     43e:	00178693          	addi	a3,a5,1
     442:	fcd43c23          	sd	a3,-40(s0)
     446:	0007c783          	lbu	a5,0(a5)
     44a:	2781                	sext.w	a5,a5
     44c:	9fb9                	addw	a5,a5,a4
     44e:	2781                	sext.w	a5,a5
     450:	fd07879b          	addiw	a5,a5,-48
     454:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     458:	fd843783          	ld	a5,-40(s0)
     45c:	0007c783          	lbu	a5,0(a5)
     460:	873e                	mv	a4,a5
     462:	02f00793          	li	a5,47
     466:	00e7fb63          	bgeu	a5,a4,47c <atoi+0x66>
     46a:	fd843783          	ld	a5,-40(s0)
     46e:	0007c783          	lbu	a5,0(a5)
     472:	873e                	mv	a4,a5
     474:	03900793          	li	a5,57
     478:	fae7f7e3          	bgeu	a5,a4,426 <atoi+0x10>
  return n;
     47c:	fec42783          	lw	a5,-20(s0)
}
     480:	853e                	mv	a0,a5
     482:	7422                	ld	s0,40(sp)
     484:	6145                	addi	sp,sp,48
     486:	8082                	ret

0000000000000488 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     488:	7139                	addi	sp,sp,-64
     48a:	fc22                	sd	s0,56(sp)
     48c:	0080                	addi	s0,sp,64
     48e:	fca43c23          	sd	a0,-40(s0)
     492:	fcb43823          	sd	a1,-48(s0)
     496:	87b2                	mv	a5,a2
     498:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     49c:	fd843783          	ld	a5,-40(s0)
     4a0:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     4a4:	fd043783          	ld	a5,-48(s0)
     4a8:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     4ac:	fe043703          	ld	a4,-32(s0)
     4b0:	fe843783          	ld	a5,-24(s0)
     4b4:	02e7fc63          	bgeu	a5,a4,4ec <memmove+0x64>
    while(n-- > 0)
     4b8:	a00d                	j	4da <memmove+0x52>
      *dst++ = *src++;
     4ba:	fe043703          	ld	a4,-32(s0)
     4be:	00170793          	addi	a5,a4,1
     4c2:	fef43023          	sd	a5,-32(s0)
     4c6:	fe843783          	ld	a5,-24(s0)
     4ca:	00178693          	addi	a3,a5,1
     4ce:	fed43423          	sd	a3,-24(s0)
     4d2:	00074703          	lbu	a4,0(a4)
     4d6:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     4da:	fcc42783          	lw	a5,-52(s0)
     4de:	fff7871b          	addiw	a4,a5,-1
     4e2:	fce42623          	sw	a4,-52(s0)
     4e6:	fcf04ae3          	bgtz	a5,4ba <memmove+0x32>
     4ea:	a891                	j	53e <memmove+0xb6>
  } else {
    dst += n;
     4ec:	fcc42783          	lw	a5,-52(s0)
     4f0:	fe843703          	ld	a4,-24(s0)
     4f4:	97ba                	add	a5,a5,a4
     4f6:	fef43423          	sd	a5,-24(s0)
    src += n;
     4fa:	fcc42783          	lw	a5,-52(s0)
     4fe:	fe043703          	ld	a4,-32(s0)
     502:	97ba                	add	a5,a5,a4
     504:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     508:	a01d                	j	52e <memmove+0xa6>
      *--dst = *--src;
     50a:	fe043783          	ld	a5,-32(s0)
     50e:	17fd                	addi	a5,a5,-1
     510:	fef43023          	sd	a5,-32(s0)
     514:	fe843783          	ld	a5,-24(s0)
     518:	17fd                	addi	a5,a5,-1
     51a:	fef43423          	sd	a5,-24(s0)
     51e:	fe043783          	ld	a5,-32(s0)
     522:	0007c703          	lbu	a4,0(a5)
     526:	fe843783          	ld	a5,-24(s0)
     52a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     52e:	fcc42783          	lw	a5,-52(s0)
     532:	fff7871b          	addiw	a4,a5,-1
     536:	fce42623          	sw	a4,-52(s0)
     53a:	fcf048e3          	bgtz	a5,50a <memmove+0x82>
  }
  return vdst;
     53e:	fd843783          	ld	a5,-40(s0)
}
     542:	853e                	mv	a0,a5
     544:	7462                	ld	s0,56(sp)
     546:	6121                	addi	sp,sp,64
     548:	8082                	ret

000000000000054a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     54a:	7139                	addi	sp,sp,-64
     54c:	fc22                	sd	s0,56(sp)
     54e:	0080                	addi	s0,sp,64
     550:	fca43c23          	sd	a0,-40(s0)
     554:	fcb43823          	sd	a1,-48(s0)
     558:	87b2                	mv	a5,a2
     55a:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     55e:	fd843783          	ld	a5,-40(s0)
     562:	fef43423          	sd	a5,-24(s0)
     566:	fd043783          	ld	a5,-48(s0)
     56a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     56e:	a0a1                	j	5b6 <memcmp+0x6c>
    if (*p1 != *p2) {
     570:	fe843783          	ld	a5,-24(s0)
     574:	0007c703          	lbu	a4,0(a5)
     578:	fe043783          	ld	a5,-32(s0)
     57c:	0007c783          	lbu	a5,0(a5)
     580:	02f70163          	beq	a4,a5,5a2 <memcmp+0x58>
      return *p1 - *p2;
     584:	fe843783          	ld	a5,-24(s0)
     588:	0007c783          	lbu	a5,0(a5)
     58c:	0007871b          	sext.w	a4,a5
     590:	fe043783          	ld	a5,-32(s0)
     594:	0007c783          	lbu	a5,0(a5)
     598:	2781                	sext.w	a5,a5
     59a:	40f707bb          	subw	a5,a4,a5
     59e:	2781                	sext.w	a5,a5
     5a0:	a01d                	j	5c6 <memcmp+0x7c>
    }
    p1++;
     5a2:	fe843783          	ld	a5,-24(s0)
     5a6:	0785                	addi	a5,a5,1
     5a8:	fef43423          	sd	a5,-24(s0)
    p2++;
     5ac:	fe043783          	ld	a5,-32(s0)
     5b0:	0785                	addi	a5,a5,1
     5b2:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     5b6:	fcc42783          	lw	a5,-52(s0)
     5ba:	fff7871b          	addiw	a4,a5,-1
     5be:	fce42623          	sw	a4,-52(s0)
     5c2:	f7dd                	bnez	a5,570 <memcmp+0x26>
  }
  return 0;
     5c4:	4781                	li	a5,0
}
     5c6:	853e                	mv	a0,a5
     5c8:	7462                	ld	s0,56(sp)
     5ca:	6121                	addi	sp,sp,64
     5cc:	8082                	ret

00000000000005ce <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     5ce:	7179                	addi	sp,sp,-48
     5d0:	f406                	sd	ra,40(sp)
     5d2:	f022                	sd	s0,32(sp)
     5d4:	1800                	addi	s0,sp,48
     5d6:	fea43423          	sd	a0,-24(s0)
     5da:	feb43023          	sd	a1,-32(s0)
     5de:	87b2                	mv	a5,a2
     5e0:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     5e4:	fdc42783          	lw	a5,-36(s0)
     5e8:	863e                	mv	a2,a5
     5ea:	fe043583          	ld	a1,-32(s0)
     5ee:	fe843503          	ld	a0,-24(s0)
     5f2:	00000097          	auipc	ra,0x0
     5f6:	e96080e7          	jalr	-362(ra) # 488 <memmove>
     5fa:	87aa                	mv	a5,a0
}
     5fc:	853e                	mv	a0,a5
     5fe:	70a2                	ld	ra,40(sp)
     600:	7402                	ld	s0,32(sp)
     602:	6145                	addi	sp,sp,48
     604:	8082                	ret

0000000000000606 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     606:	4885                	li	a7,1
 ecall
     608:	00000073          	ecall
 ret
     60c:	8082                	ret

000000000000060e <exit>:
.global exit
exit:
 li a7, SYS_exit
     60e:	4889                	li	a7,2
 ecall
     610:	00000073          	ecall
 ret
     614:	8082                	ret

0000000000000616 <wait>:
.global wait
wait:
 li a7, SYS_wait
     616:	488d                	li	a7,3
 ecall
     618:	00000073          	ecall
 ret
     61c:	8082                	ret

000000000000061e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     61e:	4891                	li	a7,4
 ecall
     620:	00000073          	ecall
 ret
     624:	8082                	ret

0000000000000626 <read>:
.global read
read:
 li a7, SYS_read
     626:	4895                	li	a7,5
 ecall
     628:	00000073          	ecall
 ret
     62c:	8082                	ret

000000000000062e <write>:
.global write
write:
 li a7, SYS_write
     62e:	48c1                	li	a7,16
 ecall
     630:	00000073          	ecall
 ret
     634:	8082                	ret

0000000000000636 <close>:
.global close
close:
 li a7, SYS_close
     636:	48d5                	li	a7,21
 ecall
     638:	00000073          	ecall
 ret
     63c:	8082                	ret

000000000000063e <kill>:
.global kill
kill:
 li a7, SYS_kill
     63e:	4899                	li	a7,6
 ecall
     640:	00000073          	ecall
 ret
     644:	8082                	ret

0000000000000646 <exec>:
.global exec
exec:
 li a7, SYS_exec
     646:	489d                	li	a7,7
 ecall
     648:	00000073          	ecall
 ret
     64c:	8082                	ret

000000000000064e <open>:
.global open
open:
 li a7, SYS_open
     64e:	48bd                	li	a7,15
 ecall
     650:	00000073          	ecall
 ret
     654:	8082                	ret

0000000000000656 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     656:	48c5                	li	a7,17
 ecall
     658:	00000073          	ecall
 ret
     65c:	8082                	ret

000000000000065e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     65e:	48c9                	li	a7,18
 ecall
     660:	00000073          	ecall
 ret
     664:	8082                	ret

0000000000000666 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     666:	48a1                	li	a7,8
 ecall
     668:	00000073          	ecall
 ret
     66c:	8082                	ret

000000000000066e <link>:
.global link
link:
 li a7, SYS_link
     66e:	48cd                	li	a7,19
 ecall
     670:	00000073          	ecall
 ret
     674:	8082                	ret

0000000000000676 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     676:	48d1                	li	a7,20
 ecall
     678:	00000073          	ecall
 ret
     67c:	8082                	ret

000000000000067e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     67e:	48a5                	li	a7,9
 ecall
     680:	00000073          	ecall
 ret
     684:	8082                	ret

0000000000000686 <dup>:
.global dup
dup:
 li a7, SYS_dup
     686:	48a9                	li	a7,10
 ecall
     688:	00000073          	ecall
 ret
     68c:	8082                	ret

000000000000068e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     68e:	48ad                	li	a7,11
 ecall
     690:	00000073          	ecall
 ret
     694:	8082                	ret

0000000000000696 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     696:	48b1                	li	a7,12
 ecall
     698:	00000073          	ecall
 ret
     69c:	8082                	ret

000000000000069e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     69e:	48b5                	li	a7,13
 ecall
     6a0:	00000073          	ecall
 ret
     6a4:	8082                	ret

00000000000006a6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     6a6:	48b9                	li	a7,14
 ecall
     6a8:	00000073          	ecall
 ret
     6ac:	8082                	ret

00000000000006ae <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     6ae:	48d9                	li	a7,22
 ecall
     6b0:	00000073          	ecall
 ret
     6b4:	8082                	ret

00000000000006b6 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     6b6:	48dd                	li	a7,23
 ecall
     6b8:	00000073          	ecall
 ret
     6bc:	8082                	ret

00000000000006be <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     6be:	48e1                	li	a7,24
 ecall
     6c0:	00000073          	ecall
 ret
     6c4:	8082                	ret

00000000000006c6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     6c6:	1101                	addi	sp,sp,-32
     6c8:	ec06                	sd	ra,24(sp)
     6ca:	e822                	sd	s0,16(sp)
     6cc:	1000                	addi	s0,sp,32
     6ce:	87aa                	mv	a5,a0
     6d0:	872e                	mv	a4,a1
     6d2:	fef42623          	sw	a5,-20(s0)
     6d6:	87ba                	mv	a5,a4
     6d8:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     6dc:	feb40713          	addi	a4,s0,-21
     6e0:	fec42783          	lw	a5,-20(s0)
     6e4:	4605                	li	a2,1
     6e6:	85ba                	mv	a1,a4
     6e8:	853e                	mv	a0,a5
     6ea:	00000097          	auipc	ra,0x0
     6ee:	f44080e7          	jalr	-188(ra) # 62e <write>
}
     6f2:	0001                	nop
     6f4:	60e2                	ld	ra,24(sp)
     6f6:	6442                	ld	s0,16(sp)
     6f8:	6105                	addi	sp,sp,32
     6fa:	8082                	ret

00000000000006fc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     6fc:	7139                	addi	sp,sp,-64
     6fe:	fc06                	sd	ra,56(sp)
     700:	f822                	sd	s0,48(sp)
     702:	0080                	addi	s0,sp,64
     704:	87aa                	mv	a5,a0
     706:	8736                	mv	a4,a3
     708:	fcf42623          	sw	a5,-52(s0)
     70c:	87ae                	mv	a5,a1
     70e:	fcf42423          	sw	a5,-56(s0)
     712:	87b2                	mv	a5,a2
     714:	fcf42223          	sw	a5,-60(s0)
     718:	87ba                	mv	a5,a4
     71a:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     71e:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     722:	fc042783          	lw	a5,-64(s0)
     726:	2781                	sext.w	a5,a5
     728:	c38d                	beqz	a5,74a <printint+0x4e>
     72a:	fc842783          	lw	a5,-56(s0)
     72e:	2781                	sext.w	a5,a5
     730:	0007dd63          	bgez	a5,74a <printint+0x4e>
    neg = 1;
     734:	4785                	li	a5,1
     736:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     73a:	fc842783          	lw	a5,-56(s0)
     73e:	40f007bb          	negw	a5,a5
     742:	2781                	sext.w	a5,a5
     744:	fef42223          	sw	a5,-28(s0)
     748:	a029                	j	752 <printint+0x56>
  } else {
    x = xx;
     74a:	fc842783          	lw	a5,-56(s0)
     74e:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     752:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     756:	fc442783          	lw	a5,-60(s0)
     75a:	fe442703          	lw	a4,-28(s0)
     75e:	02f777bb          	remuw	a5,a4,a5
     762:	0007861b          	sext.w	a2,a5
     766:	fec42783          	lw	a5,-20(s0)
     76a:	0017871b          	addiw	a4,a5,1
     76e:	fee42623          	sw	a4,-20(s0)
     772:	00001697          	auipc	a3,0x1
     776:	f0e68693          	addi	a3,a3,-242 # 1680 <digits>
     77a:	02061713          	slli	a4,a2,0x20
     77e:	9301                	srli	a4,a4,0x20
     780:	9736                	add	a4,a4,a3
     782:	00074703          	lbu	a4,0(a4)
     786:	ff040693          	addi	a3,s0,-16
     78a:	97b6                	add	a5,a5,a3
     78c:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     790:	fc442783          	lw	a5,-60(s0)
     794:	fe442703          	lw	a4,-28(s0)
     798:	02f757bb          	divuw	a5,a4,a5
     79c:	fef42223          	sw	a5,-28(s0)
     7a0:	fe442783          	lw	a5,-28(s0)
     7a4:	2781                	sext.w	a5,a5
     7a6:	fbc5                	bnez	a5,756 <printint+0x5a>
  if(neg)
     7a8:	fe842783          	lw	a5,-24(s0)
     7ac:	2781                	sext.w	a5,a5
     7ae:	cf95                	beqz	a5,7ea <printint+0xee>
    buf[i++] = '-';
     7b0:	fec42783          	lw	a5,-20(s0)
     7b4:	0017871b          	addiw	a4,a5,1
     7b8:	fee42623          	sw	a4,-20(s0)
     7bc:	ff040713          	addi	a4,s0,-16
     7c0:	97ba                	add	a5,a5,a4
     7c2:	02d00713          	li	a4,45
     7c6:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     7ca:	a005                	j	7ea <printint+0xee>
    putc(fd, buf[i]);
     7cc:	fec42783          	lw	a5,-20(s0)
     7d0:	ff040713          	addi	a4,s0,-16
     7d4:	97ba                	add	a5,a5,a4
     7d6:	fe07c703          	lbu	a4,-32(a5)
     7da:	fcc42783          	lw	a5,-52(s0)
     7de:	85ba                	mv	a1,a4
     7e0:	853e                	mv	a0,a5
     7e2:	00000097          	auipc	ra,0x0
     7e6:	ee4080e7          	jalr	-284(ra) # 6c6 <putc>
  while(--i >= 0)
     7ea:	fec42783          	lw	a5,-20(s0)
     7ee:	37fd                	addiw	a5,a5,-1
     7f0:	fef42623          	sw	a5,-20(s0)
     7f4:	fec42783          	lw	a5,-20(s0)
     7f8:	2781                	sext.w	a5,a5
     7fa:	fc07d9e3          	bgez	a5,7cc <printint+0xd0>
}
     7fe:	0001                	nop
     800:	0001                	nop
     802:	70e2                	ld	ra,56(sp)
     804:	7442                	ld	s0,48(sp)
     806:	6121                	addi	sp,sp,64
     808:	8082                	ret

000000000000080a <printptr>:

static void
printptr(int fd, uint64 x) {
     80a:	7179                	addi	sp,sp,-48
     80c:	f406                	sd	ra,40(sp)
     80e:	f022                	sd	s0,32(sp)
     810:	1800                	addi	s0,sp,48
     812:	87aa                	mv	a5,a0
     814:	fcb43823          	sd	a1,-48(s0)
     818:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     81c:	fdc42783          	lw	a5,-36(s0)
     820:	03000593          	li	a1,48
     824:	853e                	mv	a0,a5
     826:	00000097          	auipc	ra,0x0
     82a:	ea0080e7          	jalr	-352(ra) # 6c6 <putc>
  putc(fd, 'x');
     82e:	fdc42783          	lw	a5,-36(s0)
     832:	07800593          	li	a1,120
     836:	853e                	mv	a0,a5
     838:	00000097          	auipc	ra,0x0
     83c:	e8e080e7          	jalr	-370(ra) # 6c6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     840:	fe042623          	sw	zero,-20(s0)
     844:	a82d                	j	87e <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     846:	fd043783          	ld	a5,-48(s0)
     84a:	93f1                	srli	a5,a5,0x3c
     84c:	00001717          	auipc	a4,0x1
     850:	e3470713          	addi	a4,a4,-460 # 1680 <digits>
     854:	97ba                	add	a5,a5,a4
     856:	0007c703          	lbu	a4,0(a5)
     85a:	fdc42783          	lw	a5,-36(s0)
     85e:	85ba                	mv	a1,a4
     860:	853e                	mv	a0,a5
     862:	00000097          	auipc	ra,0x0
     866:	e64080e7          	jalr	-412(ra) # 6c6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     86a:	fec42783          	lw	a5,-20(s0)
     86e:	2785                	addiw	a5,a5,1
     870:	fef42623          	sw	a5,-20(s0)
     874:	fd043783          	ld	a5,-48(s0)
     878:	0792                	slli	a5,a5,0x4
     87a:	fcf43823          	sd	a5,-48(s0)
     87e:	fec42783          	lw	a5,-20(s0)
     882:	873e                	mv	a4,a5
     884:	47bd                	li	a5,15
     886:	fce7f0e3          	bgeu	a5,a4,846 <printptr+0x3c>
}
     88a:	0001                	nop
     88c:	0001                	nop
     88e:	70a2                	ld	ra,40(sp)
     890:	7402                	ld	s0,32(sp)
     892:	6145                	addi	sp,sp,48
     894:	8082                	ret

0000000000000896 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     896:	715d                	addi	sp,sp,-80
     898:	e486                	sd	ra,72(sp)
     89a:	e0a2                	sd	s0,64(sp)
     89c:	0880                	addi	s0,sp,80
     89e:	87aa                	mv	a5,a0
     8a0:	fcb43023          	sd	a1,-64(s0)
     8a4:	fac43c23          	sd	a2,-72(s0)
     8a8:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     8ac:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     8b0:	fe042223          	sw	zero,-28(s0)
     8b4:	a42d                	j	ade <vprintf+0x248>
    c = fmt[i] & 0xff;
     8b6:	fe442783          	lw	a5,-28(s0)
     8ba:	fc043703          	ld	a4,-64(s0)
     8be:	97ba                	add	a5,a5,a4
     8c0:	0007c783          	lbu	a5,0(a5)
     8c4:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     8c8:	fe042783          	lw	a5,-32(s0)
     8cc:	2781                	sext.w	a5,a5
     8ce:	eb9d                	bnez	a5,904 <vprintf+0x6e>
      if(c == '%'){
     8d0:	fdc42783          	lw	a5,-36(s0)
     8d4:	0007871b          	sext.w	a4,a5
     8d8:	02500793          	li	a5,37
     8dc:	00f71763          	bne	a4,a5,8ea <vprintf+0x54>
        state = '%';
     8e0:	02500793          	li	a5,37
     8e4:	fef42023          	sw	a5,-32(s0)
     8e8:	a2f5                	j	ad4 <vprintf+0x23e>
      } else {
        putc(fd, c);
     8ea:	fdc42783          	lw	a5,-36(s0)
     8ee:	0ff7f713          	andi	a4,a5,255
     8f2:	fcc42783          	lw	a5,-52(s0)
     8f6:	85ba                	mv	a1,a4
     8f8:	853e                	mv	a0,a5
     8fa:	00000097          	auipc	ra,0x0
     8fe:	dcc080e7          	jalr	-564(ra) # 6c6 <putc>
     902:	aac9                	j	ad4 <vprintf+0x23e>
      }
    } else if(state == '%'){
     904:	fe042783          	lw	a5,-32(s0)
     908:	0007871b          	sext.w	a4,a5
     90c:	02500793          	li	a5,37
     910:	1cf71263          	bne	a4,a5,ad4 <vprintf+0x23e>
      if(c == 'd'){
     914:	fdc42783          	lw	a5,-36(s0)
     918:	0007871b          	sext.w	a4,a5
     91c:	06400793          	li	a5,100
     920:	02f71463          	bne	a4,a5,948 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     924:	fb843783          	ld	a5,-72(s0)
     928:	00878713          	addi	a4,a5,8
     92c:	fae43c23          	sd	a4,-72(s0)
     930:	4398                	lw	a4,0(a5)
     932:	fcc42783          	lw	a5,-52(s0)
     936:	4685                	li	a3,1
     938:	4629                	li	a2,10
     93a:	85ba                	mv	a1,a4
     93c:	853e                	mv	a0,a5
     93e:	00000097          	auipc	ra,0x0
     942:	dbe080e7          	jalr	-578(ra) # 6fc <printint>
     946:	a269                	j	ad0 <vprintf+0x23a>
      } else if(c == 'l') {
     948:	fdc42783          	lw	a5,-36(s0)
     94c:	0007871b          	sext.w	a4,a5
     950:	06c00793          	li	a5,108
     954:	02f71663          	bne	a4,a5,980 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     958:	fb843783          	ld	a5,-72(s0)
     95c:	00878713          	addi	a4,a5,8
     960:	fae43c23          	sd	a4,-72(s0)
     964:	639c                	ld	a5,0(a5)
     966:	0007871b          	sext.w	a4,a5
     96a:	fcc42783          	lw	a5,-52(s0)
     96e:	4681                	li	a3,0
     970:	4629                	li	a2,10
     972:	85ba                	mv	a1,a4
     974:	853e                	mv	a0,a5
     976:	00000097          	auipc	ra,0x0
     97a:	d86080e7          	jalr	-634(ra) # 6fc <printint>
     97e:	aa89                	j	ad0 <vprintf+0x23a>
      } else if(c == 'x') {
     980:	fdc42783          	lw	a5,-36(s0)
     984:	0007871b          	sext.w	a4,a5
     988:	07800793          	li	a5,120
     98c:	02f71463          	bne	a4,a5,9b4 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     990:	fb843783          	ld	a5,-72(s0)
     994:	00878713          	addi	a4,a5,8
     998:	fae43c23          	sd	a4,-72(s0)
     99c:	4398                	lw	a4,0(a5)
     99e:	fcc42783          	lw	a5,-52(s0)
     9a2:	4681                	li	a3,0
     9a4:	4641                	li	a2,16
     9a6:	85ba                	mv	a1,a4
     9a8:	853e                	mv	a0,a5
     9aa:	00000097          	auipc	ra,0x0
     9ae:	d52080e7          	jalr	-686(ra) # 6fc <printint>
     9b2:	aa39                	j	ad0 <vprintf+0x23a>
      } else if(c == 'p') {
     9b4:	fdc42783          	lw	a5,-36(s0)
     9b8:	0007871b          	sext.w	a4,a5
     9bc:	07000793          	li	a5,112
     9c0:	02f71263          	bne	a4,a5,9e4 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     9c4:	fb843783          	ld	a5,-72(s0)
     9c8:	00878713          	addi	a4,a5,8
     9cc:	fae43c23          	sd	a4,-72(s0)
     9d0:	6398                	ld	a4,0(a5)
     9d2:	fcc42783          	lw	a5,-52(s0)
     9d6:	85ba                	mv	a1,a4
     9d8:	853e                	mv	a0,a5
     9da:	00000097          	auipc	ra,0x0
     9de:	e30080e7          	jalr	-464(ra) # 80a <printptr>
     9e2:	a0fd                	j	ad0 <vprintf+0x23a>
      } else if(c == 's'){
     9e4:	fdc42783          	lw	a5,-36(s0)
     9e8:	0007871b          	sext.w	a4,a5
     9ec:	07300793          	li	a5,115
     9f0:	04f71c63          	bne	a4,a5,a48 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     9f4:	fb843783          	ld	a5,-72(s0)
     9f8:	00878713          	addi	a4,a5,8
     9fc:	fae43c23          	sd	a4,-72(s0)
     a00:	639c                	ld	a5,0(a5)
     a02:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     a06:	fe843783          	ld	a5,-24(s0)
     a0a:	eb8d                	bnez	a5,a3c <vprintf+0x1a6>
          s = "(null)";
     a0c:	00001797          	auipc	a5,0x1
     a10:	c4478793          	addi	a5,a5,-956 # 1650 <schedule_dm+0x254>
     a14:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     a18:	a015                	j	a3c <vprintf+0x1a6>
          putc(fd, *s);
     a1a:	fe843783          	ld	a5,-24(s0)
     a1e:	0007c703          	lbu	a4,0(a5)
     a22:	fcc42783          	lw	a5,-52(s0)
     a26:	85ba                	mv	a1,a4
     a28:	853e                	mv	a0,a5
     a2a:	00000097          	auipc	ra,0x0
     a2e:	c9c080e7          	jalr	-868(ra) # 6c6 <putc>
          s++;
     a32:	fe843783          	ld	a5,-24(s0)
     a36:	0785                	addi	a5,a5,1
     a38:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     a3c:	fe843783          	ld	a5,-24(s0)
     a40:	0007c783          	lbu	a5,0(a5)
     a44:	fbf9                	bnez	a5,a1a <vprintf+0x184>
     a46:	a069                	j	ad0 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     a48:	fdc42783          	lw	a5,-36(s0)
     a4c:	0007871b          	sext.w	a4,a5
     a50:	06300793          	li	a5,99
     a54:	02f71463          	bne	a4,a5,a7c <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     a58:	fb843783          	ld	a5,-72(s0)
     a5c:	00878713          	addi	a4,a5,8
     a60:	fae43c23          	sd	a4,-72(s0)
     a64:	439c                	lw	a5,0(a5)
     a66:	0ff7f713          	andi	a4,a5,255
     a6a:	fcc42783          	lw	a5,-52(s0)
     a6e:	85ba                	mv	a1,a4
     a70:	853e                	mv	a0,a5
     a72:	00000097          	auipc	ra,0x0
     a76:	c54080e7          	jalr	-940(ra) # 6c6 <putc>
     a7a:	a899                	j	ad0 <vprintf+0x23a>
      } else if(c == '%'){
     a7c:	fdc42783          	lw	a5,-36(s0)
     a80:	0007871b          	sext.w	a4,a5
     a84:	02500793          	li	a5,37
     a88:	00f71f63          	bne	a4,a5,aa6 <vprintf+0x210>
        putc(fd, c);
     a8c:	fdc42783          	lw	a5,-36(s0)
     a90:	0ff7f713          	andi	a4,a5,255
     a94:	fcc42783          	lw	a5,-52(s0)
     a98:	85ba                	mv	a1,a4
     a9a:	853e                	mv	a0,a5
     a9c:	00000097          	auipc	ra,0x0
     aa0:	c2a080e7          	jalr	-982(ra) # 6c6 <putc>
     aa4:	a035                	j	ad0 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     aa6:	fcc42783          	lw	a5,-52(s0)
     aaa:	02500593          	li	a1,37
     aae:	853e                	mv	a0,a5
     ab0:	00000097          	auipc	ra,0x0
     ab4:	c16080e7          	jalr	-1002(ra) # 6c6 <putc>
        putc(fd, c);
     ab8:	fdc42783          	lw	a5,-36(s0)
     abc:	0ff7f713          	andi	a4,a5,255
     ac0:	fcc42783          	lw	a5,-52(s0)
     ac4:	85ba                	mv	a1,a4
     ac6:	853e                	mv	a0,a5
     ac8:	00000097          	auipc	ra,0x0
     acc:	bfe080e7          	jalr	-1026(ra) # 6c6 <putc>
      }
      state = 0;
     ad0:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     ad4:	fe442783          	lw	a5,-28(s0)
     ad8:	2785                	addiw	a5,a5,1
     ada:	fef42223          	sw	a5,-28(s0)
     ade:	fe442783          	lw	a5,-28(s0)
     ae2:	fc043703          	ld	a4,-64(s0)
     ae6:	97ba                	add	a5,a5,a4
     ae8:	0007c783          	lbu	a5,0(a5)
     aec:	dc0795e3          	bnez	a5,8b6 <vprintf+0x20>
    }
  }
}
     af0:	0001                	nop
     af2:	0001                	nop
     af4:	60a6                	ld	ra,72(sp)
     af6:	6406                	ld	s0,64(sp)
     af8:	6161                	addi	sp,sp,80
     afa:	8082                	ret

0000000000000afc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     afc:	7159                	addi	sp,sp,-112
     afe:	fc06                	sd	ra,56(sp)
     b00:	f822                	sd	s0,48(sp)
     b02:	0080                	addi	s0,sp,64
     b04:	fcb43823          	sd	a1,-48(s0)
     b08:	e010                	sd	a2,0(s0)
     b0a:	e414                	sd	a3,8(s0)
     b0c:	e818                	sd	a4,16(s0)
     b0e:	ec1c                	sd	a5,24(s0)
     b10:	03043023          	sd	a6,32(s0)
     b14:	03143423          	sd	a7,40(s0)
     b18:	87aa                	mv	a5,a0
     b1a:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     b1e:	03040793          	addi	a5,s0,48
     b22:	fcf43423          	sd	a5,-56(s0)
     b26:	fc843783          	ld	a5,-56(s0)
     b2a:	fd078793          	addi	a5,a5,-48
     b2e:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     b32:	fe843703          	ld	a4,-24(s0)
     b36:	fdc42783          	lw	a5,-36(s0)
     b3a:	863a                	mv	a2,a4
     b3c:	fd043583          	ld	a1,-48(s0)
     b40:	853e                	mv	a0,a5
     b42:	00000097          	auipc	ra,0x0
     b46:	d54080e7          	jalr	-684(ra) # 896 <vprintf>
}
     b4a:	0001                	nop
     b4c:	70e2                	ld	ra,56(sp)
     b4e:	7442                	ld	s0,48(sp)
     b50:	6165                	addi	sp,sp,112
     b52:	8082                	ret

0000000000000b54 <printf>:

void
printf(const char *fmt, ...)
{
     b54:	7159                	addi	sp,sp,-112
     b56:	f406                	sd	ra,40(sp)
     b58:	f022                	sd	s0,32(sp)
     b5a:	1800                	addi	s0,sp,48
     b5c:	fca43c23          	sd	a0,-40(s0)
     b60:	e40c                	sd	a1,8(s0)
     b62:	e810                	sd	a2,16(s0)
     b64:	ec14                	sd	a3,24(s0)
     b66:	f018                	sd	a4,32(s0)
     b68:	f41c                	sd	a5,40(s0)
     b6a:	03043823          	sd	a6,48(s0)
     b6e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     b72:	04040793          	addi	a5,s0,64
     b76:	fcf43823          	sd	a5,-48(s0)
     b7a:	fd043783          	ld	a5,-48(s0)
     b7e:	fc878793          	addi	a5,a5,-56
     b82:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     b86:	fe843783          	ld	a5,-24(s0)
     b8a:	863e                	mv	a2,a5
     b8c:	fd843583          	ld	a1,-40(s0)
     b90:	4505                	li	a0,1
     b92:	00000097          	auipc	ra,0x0
     b96:	d04080e7          	jalr	-764(ra) # 896 <vprintf>
}
     b9a:	0001                	nop
     b9c:	70a2                	ld	ra,40(sp)
     b9e:	7402                	ld	s0,32(sp)
     ba0:	6165                	addi	sp,sp,112
     ba2:	8082                	ret

0000000000000ba4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     ba4:	7179                	addi	sp,sp,-48
     ba6:	f422                	sd	s0,40(sp)
     ba8:	1800                	addi	s0,sp,48
     baa:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     bae:	fd843783          	ld	a5,-40(s0)
     bb2:	17c1                	addi	a5,a5,-16
     bb4:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     bb8:	00001797          	auipc	a5,0x1
     bbc:	cf078793          	addi	a5,a5,-784 # 18a8 <freep>
     bc0:	639c                	ld	a5,0(a5)
     bc2:	fef43423          	sd	a5,-24(s0)
     bc6:	a815                	j	bfa <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     bc8:	fe843783          	ld	a5,-24(s0)
     bcc:	639c                	ld	a5,0(a5)
     bce:	fe843703          	ld	a4,-24(s0)
     bd2:	00f76f63          	bltu	a4,a5,bf0 <free+0x4c>
     bd6:	fe043703          	ld	a4,-32(s0)
     bda:	fe843783          	ld	a5,-24(s0)
     bde:	02e7eb63          	bltu	a5,a4,c14 <free+0x70>
     be2:	fe843783          	ld	a5,-24(s0)
     be6:	639c                	ld	a5,0(a5)
     be8:	fe043703          	ld	a4,-32(s0)
     bec:	02f76463          	bltu	a4,a5,c14 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     bf0:	fe843783          	ld	a5,-24(s0)
     bf4:	639c                	ld	a5,0(a5)
     bf6:	fef43423          	sd	a5,-24(s0)
     bfa:	fe043703          	ld	a4,-32(s0)
     bfe:	fe843783          	ld	a5,-24(s0)
     c02:	fce7f3e3          	bgeu	a5,a4,bc8 <free+0x24>
     c06:	fe843783          	ld	a5,-24(s0)
     c0a:	639c                	ld	a5,0(a5)
     c0c:	fe043703          	ld	a4,-32(s0)
     c10:	faf77ce3          	bgeu	a4,a5,bc8 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     c14:	fe043783          	ld	a5,-32(s0)
     c18:	479c                	lw	a5,8(a5)
     c1a:	1782                	slli	a5,a5,0x20
     c1c:	9381                	srli	a5,a5,0x20
     c1e:	0792                	slli	a5,a5,0x4
     c20:	fe043703          	ld	a4,-32(s0)
     c24:	973e                	add	a4,a4,a5
     c26:	fe843783          	ld	a5,-24(s0)
     c2a:	639c                	ld	a5,0(a5)
     c2c:	02f71763          	bne	a4,a5,c5a <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     c30:	fe043783          	ld	a5,-32(s0)
     c34:	4798                	lw	a4,8(a5)
     c36:	fe843783          	ld	a5,-24(s0)
     c3a:	639c                	ld	a5,0(a5)
     c3c:	479c                	lw	a5,8(a5)
     c3e:	9fb9                	addw	a5,a5,a4
     c40:	0007871b          	sext.w	a4,a5
     c44:	fe043783          	ld	a5,-32(s0)
     c48:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     c4a:	fe843783          	ld	a5,-24(s0)
     c4e:	639c                	ld	a5,0(a5)
     c50:	6398                	ld	a4,0(a5)
     c52:	fe043783          	ld	a5,-32(s0)
     c56:	e398                	sd	a4,0(a5)
     c58:	a039                	j	c66 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     c5a:	fe843783          	ld	a5,-24(s0)
     c5e:	6398                	ld	a4,0(a5)
     c60:	fe043783          	ld	a5,-32(s0)
     c64:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     c66:	fe843783          	ld	a5,-24(s0)
     c6a:	479c                	lw	a5,8(a5)
     c6c:	1782                	slli	a5,a5,0x20
     c6e:	9381                	srli	a5,a5,0x20
     c70:	0792                	slli	a5,a5,0x4
     c72:	fe843703          	ld	a4,-24(s0)
     c76:	97ba                	add	a5,a5,a4
     c78:	fe043703          	ld	a4,-32(s0)
     c7c:	02f71563          	bne	a4,a5,ca6 <free+0x102>
    p->s.size += bp->s.size;
     c80:	fe843783          	ld	a5,-24(s0)
     c84:	4798                	lw	a4,8(a5)
     c86:	fe043783          	ld	a5,-32(s0)
     c8a:	479c                	lw	a5,8(a5)
     c8c:	9fb9                	addw	a5,a5,a4
     c8e:	0007871b          	sext.w	a4,a5
     c92:	fe843783          	ld	a5,-24(s0)
     c96:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     c98:	fe043783          	ld	a5,-32(s0)
     c9c:	6398                	ld	a4,0(a5)
     c9e:	fe843783          	ld	a5,-24(s0)
     ca2:	e398                	sd	a4,0(a5)
     ca4:	a031                	j	cb0 <free+0x10c>
  } else
    p->s.ptr = bp;
     ca6:	fe843783          	ld	a5,-24(s0)
     caa:	fe043703          	ld	a4,-32(s0)
     cae:	e398                	sd	a4,0(a5)
  freep = p;
     cb0:	00001797          	auipc	a5,0x1
     cb4:	bf878793          	addi	a5,a5,-1032 # 18a8 <freep>
     cb8:	fe843703          	ld	a4,-24(s0)
     cbc:	e398                	sd	a4,0(a5)
}
     cbe:	0001                	nop
     cc0:	7422                	ld	s0,40(sp)
     cc2:	6145                	addi	sp,sp,48
     cc4:	8082                	ret

0000000000000cc6 <morecore>:

static Header*
morecore(uint nu)
{
     cc6:	7179                	addi	sp,sp,-48
     cc8:	f406                	sd	ra,40(sp)
     cca:	f022                	sd	s0,32(sp)
     ccc:	1800                	addi	s0,sp,48
     cce:	87aa                	mv	a5,a0
     cd0:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     cd4:	fdc42783          	lw	a5,-36(s0)
     cd8:	0007871b          	sext.w	a4,a5
     cdc:	6785                	lui	a5,0x1
     cde:	00f77563          	bgeu	a4,a5,ce8 <morecore+0x22>
    nu = 4096;
     ce2:	6785                	lui	a5,0x1
     ce4:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     ce8:	fdc42783          	lw	a5,-36(s0)
     cec:	0047979b          	slliw	a5,a5,0x4
     cf0:	2781                	sext.w	a5,a5
     cf2:	2781                	sext.w	a5,a5
     cf4:	853e                	mv	a0,a5
     cf6:	00000097          	auipc	ra,0x0
     cfa:	9a0080e7          	jalr	-1632(ra) # 696 <sbrk>
     cfe:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     d02:	fe843703          	ld	a4,-24(s0)
     d06:	57fd                	li	a5,-1
     d08:	00f71463          	bne	a4,a5,d10 <morecore+0x4a>
    return 0;
     d0c:	4781                	li	a5,0
     d0e:	a03d                	j	d3c <morecore+0x76>
  hp = (Header*)p;
     d10:	fe843783          	ld	a5,-24(s0)
     d14:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     d18:	fe043783          	ld	a5,-32(s0)
     d1c:	fdc42703          	lw	a4,-36(s0)
     d20:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     d22:	fe043783          	ld	a5,-32(s0)
     d26:	07c1                	addi	a5,a5,16
     d28:	853e                	mv	a0,a5
     d2a:	00000097          	auipc	ra,0x0
     d2e:	e7a080e7          	jalr	-390(ra) # ba4 <free>
  return freep;
     d32:	00001797          	auipc	a5,0x1
     d36:	b7678793          	addi	a5,a5,-1162 # 18a8 <freep>
     d3a:	639c                	ld	a5,0(a5)
}
     d3c:	853e                	mv	a0,a5
     d3e:	70a2                	ld	ra,40(sp)
     d40:	7402                	ld	s0,32(sp)
     d42:	6145                	addi	sp,sp,48
     d44:	8082                	ret

0000000000000d46 <malloc>:

void*
malloc(uint nbytes)
{
     d46:	7139                	addi	sp,sp,-64
     d48:	fc06                	sd	ra,56(sp)
     d4a:	f822                	sd	s0,48(sp)
     d4c:	0080                	addi	s0,sp,64
     d4e:	87aa                	mv	a5,a0
     d50:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     d54:	fcc46783          	lwu	a5,-52(s0)
     d58:	07bd                	addi	a5,a5,15
     d5a:	8391                	srli	a5,a5,0x4
     d5c:	2781                	sext.w	a5,a5
     d5e:	2785                	addiw	a5,a5,1
     d60:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     d64:	00001797          	auipc	a5,0x1
     d68:	b4478793          	addi	a5,a5,-1212 # 18a8 <freep>
     d6c:	639c                	ld	a5,0(a5)
     d6e:	fef43023          	sd	a5,-32(s0)
     d72:	fe043783          	ld	a5,-32(s0)
     d76:	ef95                	bnez	a5,db2 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     d78:	00001797          	auipc	a5,0x1
     d7c:	b2078793          	addi	a5,a5,-1248 # 1898 <base>
     d80:	fef43023          	sd	a5,-32(s0)
     d84:	00001797          	auipc	a5,0x1
     d88:	b2478793          	addi	a5,a5,-1244 # 18a8 <freep>
     d8c:	fe043703          	ld	a4,-32(s0)
     d90:	e398                	sd	a4,0(a5)
     d92:	00001797          	auipc	a5,0x1
     d96:	b1678793          	addi	a5,a5,-1258 # 18a8 <freep>
     d9a:	6398                	ld	a4,0(a5)
     d9c:	00001797          	auipc	a5,0x1
     da0:	afc78793          	addi	a5,a5,-1284 # 1898 <base>
     da4:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     da6:	00001797          	auipc	a5,0x1
     daa:	af278793          	addi	a5,a5,-1294 # 1898 <base>
     dae:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     db2:	fe043783          	ld	a5,-32(s0)
     db6:	639c                	ld	a5,0(a5)
     db8:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     dbc:	fe843783          	ld	a5,-24(s0)
     dc0:	4798                	lw	a4,8(a5)
     dc2:	fdc42783          	lw	a5,-36(s0)
     dc6:	2781                	sext.w	a5,a5
     dc8:	06f76863          	bltu	a4,a5,e38 <malloc+0xf2>
      if(p->s.size == nunits)
     dcc:	fe843783          	ld	a5,-24(s0)
     dd0:	4798                	lw	a4,8(a5)
     dd2:	fdc42783          	lw	a5,-36(s0)
     dd6:	2781                	sext.w	a5,a5
     dd8:	00e79963          	bne	a5,a4,dea <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     ddc:	fe843783          	ld	a5,-24(s0)
     de0:	6398                	ld	a4,0(a5)
     de2:	fe043783          	ld	a5,-32(s0)
     de6:	e398                	sd	a4,0(a5)
     de8:	a82d                	j	e22 <malloc+0xdc>
      else {
        p->s.size -= nunits;
     dea:	fe843783          	ld	a5,-24(s0)
     dee:	4798                	lw	a4,8(a5)
     df0:	fdc42783          	lw	a5,-36(s0)
     df4:	40f707bb          	subw	a5,a4,a5
     df8:	0007871b          	sext.w	a4,a5
     dfc:	fe843783          	ld	a5,-24(s0)
     e00:	c798                	sw	a4,8(a5)
        p += p->s.size;
     e02:	fe843783          	ld	a5,-24(s0)
     e06:	479c                	lw	a5,8(a5)
     e08:	1782                	slli	a5,a5,0x20
     e0a:	9381                	srli	a5,a5,0x20
     e0c:	0792                	slli	a5,a5,0x4
     e0e:	fe843703          	ld	a4,-24(s0)
     e12:	97ba                	add	a5,a5,a4
     e14:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     e18:	fe843783          	ld	a5,-24(s0)
     e1c:	fdc42703          	lw	a4,-36(s0)
     e20:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     e22:	00001797          	auipc	a5,0x1
     e26:	a8678793          	addi	a5,a5,-1402 # 18a8 <freep>
     e2a:	fe043703          	ld	a4,-32(s0)
     e2e:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     e30:	fe843783          	ld	a5,-24(s0)
     e34:	07c1                	addi	a5,a5,16
     e36:	a091                	j	e7a <malloc+0x134>
    }
    if(p == freep)
     e38:	00001797          	auipc	a5,0x1
     e3c:	a7078793          	addi	a5,a5,-1424 # 18a8 <freep>
     e40:	639c                	ld	a5,0(a5)
     e42:	fe843703          	ld	a4,-24(s0)
     e46:	02f71063          	bne	a4,a5,e66 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     e4a:	fdc42783          	lw	a5,-36(s0)
     e4e:	853e                	mv	a0,a5
     e50:	00000097          	auipc	ra,0x0
     e54:	e76080e7          	jalr	-394(ra) # cc6 <morecore>
     e58:	fea43423          	sd	a0,-24(s0)
     e5c:	fe843783          	ld	a5,-24(s0)
     e60:	e399                	bnez	a5,e66 <malloc+0x120>
        return 0;
     e62:	4781                	li	a5,0
     e64:	a819                	j	e7a <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     e66:	fe843783          	ld	a5,-24(s0)
     e6a:	fef43023          	sd	a5,-32(s0)
     e6e:	fe843783          	ld	a5,-24(s0)
     e72:	639c                	ld	a5,0(a5)
     e74:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     e78:	b791                	j	dbc <malloc+0x76>
  }
}
     e7a:	853e                	mv	a0,a5
     e7c:	70e2                	ld	ra,56(sp)
     e7e:	7442                	ld	s0,48(sp)
     e80:	6121                	addi	sp,sp,64
     e82:	8082                	ret

0000000000000e84 <setjmp>:
     e84:	e100                	sd	s0,0(a0)
     e86:	e504                	sd	s1,8(a0)
     e88:	01253823          	sd	s2,16(a0)
     e8c:	01353c23          	sd	s3,24(a0)
     e90:	03453023          	sd	s4,32(a0)
     e94:	03553423          	sd	s5,40(a0)
     e98:	03653823          	sd	s6,48(a0)
     e9c:	03753c23          	sd	s7,56(a0)
     ea0:	05853023          	sd	s8,64(a0)
     ea4:	05953423          	sd	s9,72(a0)
     ea8:	05a53823          	sd	s10,80(a0)
     eac:	05b53c23          	sd	s11,88(a0)
     eb0:	06153023          	sd	ra,96(a0)
     eb4:	06253423          	sd	sp,104(a0)
     eb8:	4501                	li	a0,0
     eba:	8082                	ret

0000000000000ebc <longjmp>:
     ebc:	6100                	ld	s0,0(a0)
     ebe:	6504                	ld	s1,8(a0)
     ec0:	01053903          	ld	s2,16(a0)
     ec4:	01853983          	ld	s3,24(a0)
     ec8:	02053a03          	ld	s4,32(a0)
     ecc:	02853a83          	ld	s5,40(a0)
     ed0:	03053b03          	ld	s6,48(a0)
     ed4:	03853b83          	ld	s7,56(a0)
     ed8:	04053c03          	ld	s8,64(a0)
     edc:	04853c83          	ld	s9,72(a0)
     ee0:	05053d03          	ld	s10,80(a0)
     ee4:	05853d83          	ld	s11,88(a0)
     ee8:	06053083          	ld	ra,96(a0)
     eec:	06853103          	ld	sp,104(a0)
     ef0:	c199                	beqz	a1,ef6 <longjmp_1>
     ef2:	852e                	mv	a0,a1
     ef4:	8082                	ret

0000000000000ef6 <longjmp_1>:
     ef6:	4505                	li	a0,1
     ef8:	8082                	ret

0000000000000efa <schedule_default>:
#define INT_MAX 2147483647
#define TIME_QUANTUM 2  // Define a base time quantum for the round-robin

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
     efa:	715d                	addi	sp,sp,-80
     efc:	e4a2                	sd	s0,72(sp)
     efe:	e0a6                	sd	s1,64(sp)
     f00:	0880                	addi	s0,sp,80
     f02:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
     f04:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
     f08:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     f0c:	649c                	ld	a5,8(s1)
     f0e:	639c                	ld	a5,0(a5)
     f10:	fcf43c23          	sd	a5,-40(s0)
     f14:	fd843783          	ld	a5,-40(s0)
     f18:	fd878793          	addi	a5,a5,-40
     f1c:	fef43023          	sd	a5,-32(s0)
     f20:	a81d                	j	f56 <schedule_default+0x5c>
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
     f22:	fe843783          	ld	a5,-24(s0)
     f26:	cb89                	beqz	a5,f38 <schedule_default+0x3e>
     f28:	fe043783          	ld	a5,-32(s0)
     f2c:	5fd8                	lw	a4,60(a5)
     f2e:	fe843783          	ld	a5,-24(s0)
     f32:	5fdc                	lw	a5,60(a5)
     f34:	00f75663          	bge	a4,a5,f40 <schedule_default+0x46>
            thread_with_smallest_id = th;
     f38:	fe043783          	ld	a5,-32(s0)
     f3c:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     f40:	fe043783          	ld	a5,-32(s0)
     f44:	779c                	ld	a5,40(a5)
     f46:	fcf43823          	sd	a5,-48(s0)
     f4a:	fd043783          	ld	a5,-48(s0)
     f4e:	fd878793          	addi	a5,a5,-40
     f52:	fef43023          	sd	a5,-32(s0)
     f56:	fe043783          	ld	a5,-32(s0)
     f5a:	02878713          	addi	a4,a5,40
     f5e:	649c                	ld	a5,8(s1)
     f60:	fcf711e3          	bne	a4,a5,f22 <schedule_default+0x28>
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
     f64:	fe843783          	ld	a5,-24(s0)
     f68:	cf89                	beqz	a5,f82 <schedule_default+0x88>
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
     f6a:	fe843783          	ld	a5,-24(s0)
     f6e:	02878793          	addi	a5,a5,40
     f72:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
     f76:	fe843783          	ld	a5,-24(s0)
     f7a:	4fbc                	lw	a5,88(a5)
     f7c:	faf42c23          	sw	a5,-72(s0)
     f80:	a039                	j	f8e <schedule_default+0x94>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
     f82:	649c                	ld	a5,8(s1)
     f84:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
     f88:	4785                	li	a5,1
     f8a:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
     f8e:	fb043783          	ld	a5,-80(s0)
     f92:	fcf43023          	sd	a5,-64(s0)
     f96:	fb843783          	ld	a5,-72(s0)
     f9a:	fcf43423          	sd	a5,-56(s0)
     f9e:	4701                	li	a4,0
     fa0:	fc043703          	ld	a4,-64(s0)
     fa4:	4781                	li	a5,0
     fa6:	fc843783          	ld	a5,-56(s0)
     faa:	863a                	mv	a2,a4
     fac:	86be                	mv	a3,a5
     fae:	8732                	mv	a4,a2
     fb0:	87b6                	mv	a5,a3
}
     fb2:	853a                	mv	a0,a4
     fb4:	85be                	mv	a1,a5
     fb6:	6426                	ld	s0,72(sp)
     fb8:	6486                	ld	s1,64(sp)
     fba:	6161                	addi	sp,sp,80
     fbc:	8082                	ret

0000000000000fbe <schedule_wrr>:

/* MP3 Part 1 - Non-Real-Time Scheduling */
/* Weighted-Round-Robin Scheduling */
struct threads_sched_result schedule_wrr(struct threads_sched_args args)
{
     fbe:	711d                	addi	sp,sp,-96
     fc0:	eca2                	sd	s0,88(sp)
     fc2:	e8a6                	sd	s1,80(sp)
     fc4:	1080                	addi	s0,sp,96
     fc6:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the weighted round-robin scheduling algorithm
    static struct thread *last_thread = NULL;
    struct thread *selected_thread = NULL;
     fc8:	fe043423          	sd	zero,-24(s0)
    struct thread *candidate = NULL;
     fcc:	fe043023          	sd	zero,-32(s0)

    // If last_thread is NULL or its remaining time is zero, reset the selection process
    if (last_thread == NULL || last_thread->remaining_time <= 0) {
     fd0:	00001797          	auipc	a5,0x1
     fd4:	8e078793          	addi	a5,a5,-1824 # 18b0 <last_thread.1226>
     fd8:	639c                	ld	a5,0(a5)
     fda:	cb89                	beqz	a5,fec <schedule_wrr+0x2e>
     fdc:	00001797          	auipc	a5,0x1
     fe0:	8d478793          	addi	a5,a5,-1836 # 18b0 <last_thread.1226>
     fe4:	639c                	ld	a5,0(a5)
     fe6:	4fbc                	lw	a5,88(a5)
     fe8:	00f04863          	bgtz	a5,ff8 <schedule_wrr+0x3a>
        last_thread = NULL;
     fec:	00001797          	auipc	a5,0x1
     ff0:	8c478793          	addi	a5,a5,-1852 # 18b0 <last_thread.1226>
     ff4:	0007b023          	sd	zero,0(a5)
    }

    // Find the first thread that is ready to run
    list_for_each_entry(candidate, args.run_queue, thread_list) {
     ff8:	649c                	ld	a5,8(s1)
     ffa:	639c                	ld	a5,0(a5)
     ffc:	fcf43823          	sd	a5,-48(s0)
    1000:	fd043783          	ld	a5,-48(s0)
    1004:	fd878793          	addi	a5,a5,-40
    1008:	fef43023          	sd	a5,-32(s0)
    100c:	a0a9                	j	1056 <schedule_wrr+0x98>
        if (!last_thread && candidate->remaining_time > 0)
    100e:	00001797          	auipc	a5,0x1
    1012:	8a278793          	addi	a5,a5,-1886 # 18b0 <last_thread.1226>
    1016:	639c                	ld	a5,0(a5)
    1018:	eb91                	bnez	a5,102c <schedule_wrr+0x6e>
    101a:	fe043783          	ld	a5,-32(s0)
    101e:	4fbc                	lw	a5,88(a5)
    1020:	00f05663          	blez	a5,102c <schedule_wrr+0x6e>
            selected_thread = candidate;
    1024:	fe043783          	ld	a5,-32(s0)
    1028:	fef43423          	sd	a5,-24(s0)
        if (candidate->remaining_time > 0) {
    102c:	fe043783          	ld	a5,-32(s0)
    1030:	4fbc                	lw	a5,88(a5)
    1032:	00f05763          	blez	a5,1040 <schedule_wrr+0x82>
            selected_thread = candidate;
    1036:	fe043783          	ld	a5,-32(s0)
    103a:	fef43423          	sd	a5,-24(s0)
            break;
    103e:	a01d                	j	1064 <schedule_wrr+0xa6>
    list_for_each_entry(candidate, args.run_queue, thread_list) {
    1040:	fe043783          	ld	a5,-32(s0)
    1044:	779c                	ld	a5,40(a5)
    1046:	fcf43423          	sd	a5,-56(s0)
    104a:	fc843783          	ld	a5,-56(s0)
    104e:	fd878793          	addi	a5,a5,-40
    1052:	fef43023          	sd	a5,-32(s0)
    1056:	fe043783          	ld	a5,-32(s0)
    105a:	02878713          	addi	a4,a5,40
    105e:	649c                	ld	a5,8(s1)
    1060:	faf717e3          	bne	a4,a5,100e <schedule_wrr+0x50>
        }
    }

    // Fall back to the last_thread if no other thread is selected and it still has remaining time
    if (!selected_thread && last_thread && last_thread->remaining_time > 0) {
    1064:	fe843783          	ld	a5,-24(s0)
    1068:	e795                	bnez	a5,1094 <schedule_wrr+0xd6>
    106a:	00001797          	auipc	a5,0x1
    106e:	84678793          	addi	a5,a5,-1978 # 18b0 <last_thread.1226>
    1072:	639c                	ld	a5,0(a5)
    1074:	c385                	beqz	a5,1094 <schedule_wrr+0xd6>
    1076:	00001797          	auipc	a5,0x1
    107a:	83a78793          	addi	a5,a5,-1990 # 18b0 <last_thread.1226>
    107e:	639c                	ld	a5,0(a5)
    1080:	4fbc                	lw	a5,88(a5)
    1082:	00f05963          	blez	a5,1094 <schedule_wrr+0xd6>
        selected_thread = last_thread;
    1086:	00001797          	auipc	a5,0x1
    108a:	82a78793          	addi	a5,a5,-2006 # 18b0 <last_thread.1226>
    108e:	639c                	ld	a5,0(a5)
    1090:	fef43423          	sd	a5,-24(s0)
    }

    // Set the scheduling result
    if (selected_thread) {
    1094:	fe843783          	ld	a5,-24(s0)
    1098:	c7b9                	beqz	a5,10e6 <schedule_wrr+0x128>
        int time_slice = selected_thread->weight * TIME_QUANTUM;
    109a:	fe843783          	ld	a5,-24(s0)
    109e:	47bc                	lw	a5,72(a5)
    10a0:	0017979b          	slliw	a5,a5,0x1
    10a4:	fcf42e23          	sw	a5,-36(s0)
        if (time_slice > selected_thread->remaining_time) {
    10a8:	fe843783          	ld	a5,-24(s0)
    10ac:	4fb8                	lw	a4,88(a5)
    10ae:	fdc42783          	lw	a5,-36(s0)
    10b2:	2781                	sext.w	a5,a5
    10b4:	00f75763          	bge	a4,a5,10c2 <schedule_wrr+0x104>
            time_slice = selected_thread->remaining_time;
    10b8:	fe843783          	ld	a5,-24(s0)
    10bc:	4fbc                	lw	a5,88(a5)
    10be:	fcf42e23          	sw	a5,-36(s0)
        }
        r.scheduled_thread_list_member = &selected_thread->thread_list;
    10c2:	fe843783          	ld	a5,-24(s0)
    10c6:	02878793          	addi	a5,a5,40
    10ca:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = time_slice;
    10ce:	fdc42783          	lw	a5,-36(s0)
    10d2:	faf42823          	sw	a5,-80(s0)
        last_thread = selected_thread;  // Update the last run thread
    10d6:	00000797          	auipc	a5,0x0
    10da:	7da78793          	addi	a5,a5,2010 # 18b0 <last_thread.1226>
    10de:	fe843703          	ld	a4,-24(s0)
    10e2:	e398                	sd	a4,0(a5)
    10e4:	a039                	j	10f2 <schedule_wrr+0x134>
    } else {
        // Idle if no suitable thread is found
        r.scheduled_thread_list_member = args.run_queue;
    10e6:	649c                	ld	a5,8(s1)
    10e8:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = 1;
    10ec:	4785                	li	a5,1
    10ee:	faf42823          	sw	a5,-80(s0)
    }

    return r;
    10f2:	fa843783          	ld	a5,-88(s0)
    10f6:	faf43c23          	sd	a5,-72(s0)
    10fa:	fb043783          	ld	a5,-80(s0)
    10fe:	fcf43023          	sd	a5,-64(s0)
    1102:	4701                	li	a4,0
    1104:	fb843703          	ld	a4,-72(s0)
    1108:	4781                	li	a5,0
    110a:	fc043783          	ld	a5,-64(s0)
    110e:	863a                	mv	a2,a4
    1110:	86be                	mv	a3,a5
    1112:	8732                	mv	a4,a2
    1114:	87b6                	mv	a5,a3
}
    1116:	853a                	mv	a0,a4
    1118:	85be                	mv	a1,a5
    111a:	6466                	ld	s0,88(sp)
    111c:	64c6                	ld	s1,80(sp)
    111e:	6125                	addi	sp,sp,96
    1120:	8082                	ret

0000000000001122 <schedule_sjf>:

struct threads_sched_result schedule_sjf(struct threads_sched_args args)
{
    1122:	7119                	addi	sp,sp,-128
    1124:	fc86                	sd	ra,120(sp)
    1126:	f8a2                	sd	s0,112(sp)
    1128:	f4a6                	sd	s1,104(sp)
    112a:	f0ca                	sd	s2,96(sp)
    112c:	ecce                	sd	s3,88(sp)
    112e:	0100                	addi	s0,sp,128
    1130:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the shortest-job-first scheduling algorithm
    struct thread *shortest_job = NULL;
    1132:	fc043423          	sd	zero,-56(s0)
    struct thread *t;
    int shortest_time = INT_MAX;
    1136:	800007b7          	lui	a5,0x80000
    113a:	fff7c793          	not	a5,a5
    113e:	faf42e23          	sw	a5,-68(s0)

    // Find the thread with the shortest remaining time that is ready to run
    list_for_each_entry(t, args.run_queue, thread_list) {
    1142:	649c                	ld	a5,8(s1)
    1144:	639c                	ld	a5,0(a5)
    1146:	faf43823          	sd	a5,-80(s0)
    114a:	fb043783          	ld	a5,-80(s0)
    114e:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe158>
    1152:	fcf43023          	sd	a5,-64(s0)
    1156:	a8a9                	j	11b0 <schedule_sjf+0x8e>
        printf("Thread ID: %d, Remaining Time: %d\n", t->ID, t->remaining_time);
    1158:	fc043783          	ld	a5,-64(s0)
    115c:	5fd8                	lw	a4,60(a5)
    115e:	fc043783          	ld	a5,-64(s0)
    1162:	4fbc                	lw	a5,88(a5)
    1164:	863e                	mv	a2,a5
    1166:	85ba                	mv	a1,a4
    1168:	00000517          	auipc	a0,0x0
    116c:	4f050513          	addi	a0,a0,1264 # 1658 <schedule_dm+0x25c>
    1170:	00000097          	auipc	ra,0x0
    1174:	9e4080e7          	jalr	-1564(ra) # b54 <printf>
        if (t->remaining_time < shortest_time) {
    1178:	fc043783          	ld	a5,-64(s0)
    117c:	4fb8                	lw	a4,88(a5)
    117e:	fbc42783          	lw	a5,-68(s0)
    1182:	2781                	sext.w	a5,a5
    1184:	00f75b63          	bge	a4,a5,119a <schedule_sjf+0x78>
            shortest_time = t->remaining_time;
    1188:	fc043783          	ld	a5,-64(s0)
    118c:	4fbc                	lw	a5,88(a5)
    118e:	faf42e23          	sw	a5,-68(s0)
            shortest_job = t;
    1192:	fc043783          	ld	a5,-64(s0)
    1196:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    119a:	fc043783          	ld	a5,-64(s0)
    119e:	779c                	ld	a5,40(a5)
    11a0:	faf43423          	sd	a5,-88(s0)
    11a4:	fa843783          	ld	a5,-88(s0)
    11a8:	fd878793          	addi	a5,a5,-40
    11ac:	fcf43023          	sd	a5,-64(s0)
    11b0:	fc043783          	ld	a5,-64(s0)
    11b4:	02878713          	addi	a4,a5,40
    11b8:	649c                	ld	a5,8(s1)
    11ba:	f8f71fe3          	bne	a4,a5,1158 <schedule_sjf+0x36>
        }
    }

    if (shortest_job) {
    11be:	fc843783          	ld	a5,-56(s0)
    11c2:	cf89                	beqz	a5,11dc <schedule_sjf+0xba>
        r.scheduled_thread_list_member = &shortest_job->thread_list;
    11c4:	fc843783          	ld	a5,-56(s0)
    11c8:	02878793          	addi	a5,a5,40
    11cc:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = shortest_job->remaining_time;  // Allow the thread to run to completion
    11d0:	fc843783          	ld	a5,-56(s0)
    11d4:	4fbc                	lw	a5,88(a5)
    11d6:	f8f42823          	sw	a5,-112(s0)
    11da:	a039                	j	11e8 <schedule_sjf+0xc6>
    } else {
        // If no threads are ready, find the next release time or idle
        r.scheduled_thread_list_member = args.run_queue;
    11dc:	649c                	ld	a5,8(s1)
    11de:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = 1;  // Default minimal quantum if unsure
    11e2:	4785                	li	a5,1
    11e4:	f8f42823          	sw	a5,-112(s0)
    }
    return r;
    11e8:	f8843783          	ld	a5,-120(s0)
    11ec:	f8f43c23          	sd	a5,-104(s0)
    11f0:	f9043783          	ld	a5,-112(s0)
    11f4:	faf43023          	sd	a5,-96(s0)
    11f8:	4701                	li	a4,0
    11fa:	f9843703          	ld	a4,-104(s0)
    11fe:	4781                	li	a5,0
    1200:	fa043783          	ld	a5,-96(s0)
    1204:	893a                	mv	s2,a4
    1206:	89be                	mv	s3,a5
    1208:	874a                	mv	a4,s2
    120a:	87ce                	mv	a5,s3
}
    120c:	853a                	mv	a0,a4
    120e:	85be                	mv	a1,a5
    1210:	70e6                	ld	ra,120(sp)
    1212:	7446                	ld	s0,112(sp)
    1214:	74a6                	ld	s1,104(sp)
    1216:	7906                	ld	s2,96(sp)
    1218:	69e6                	ld	s3,88(sp)
    121a:	6109                	addi	sp,sp,128
    121c:	8082                	ret

000000000000121e <find_next_release_time>:

int find_next_release_time(struct list_head *release_queue, int current_time) {
    121e:	7139                	addi	sp,sp,-64
    1220:	fc22                	sd	s0,56(sp)
    1222:	0080                	addi	s0,sp,64
    1224:	fca43423          	sd	a0,-56(s0)
    1228:	87ae                	mv	a5,a1
    122a:	fcf42223          	sw	a5,-60(s0)
    struct release_queue_entry *next_release = NULL;
    122e:	fe043423          	sd	zero,-24(s0)
    int next_release_time = INT_MAX;
    1232:	800007b7          	lui	a5,0x80000
    1236:	fff7c793          	not	a5,a5
    123a:	fef42223          	sw	a5,-28(s0)

    list_for_each_entry(next_release, release_queue, thread_list) {
    123e:	fc843783          	ld	a5,-56(s0)
    1242:	639c                	ld	a5,0(a5)
    1244:	fcf43c23          	sd	a5,-40(s0)
    1248:	fd843783          	ld	a5,-40(s0)
    124c:	17e1                	addi	a5,a5,-8
    124e:	fef43423          	sd	a5,-24(s0)
    1252:	a081                	j	1292 <find_next_release_time+0x74>
        if (next_release->release_time > current_time &&
    1254:	fe843783          	ld	a5,-24(s0)
    1258:	4f98                	lw	a4,24(a5)
    125a:	fc442783          	lw	a5,-60(s0)
    125e:	2781                	sext.w	a5,a5
    1260:	00e7df63          	bge	a5,a4,127e <find_next_release_time+0x60>
            next_release->release_time < next_release_time) {
    1264:	fe843783          	ld	a5,-24(s0)
    1268:	4f98                	lw	a4,24(a5)
        if (next_release->release_time > current_time &&
    126a:	fe442783          	lw	a5,-28(s0)
    126e:	2781                	sext.w	a5,a5
    1270:	00f75763          	bge	a4,a5,127e <find_next_release_time+0x60>
            next_release_time = next_release->release_time;
    1274:	fe843783          	ld	a5,-24(s0)
    1278:	4f9c                	lw	a5,24(a5)
    127a:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(next_release, release_queue, thread_list) {
    127e:	fe843783          	ld	a5,-24(s0)
    1282:	679c                	ld	a5,8(a5)
    1284:	fcf43823          	sd	a5,-48(s0)
    1288:	fd043783          	ld	a5,-48(s0)
    128c:	17e1                	addi	a5,a5,-8
    128e:	fef43423          	sd	a5,-24(s0)
    1292:	fe843783          	ld	a5,-24(s0)
    1296:	07a1                	addi	a5,a5,8
    1298:	fc843703          	ld	a4,-56(s0)
    129c:	faf71ce3          	bne	a4,a5,1254 <find_next_release_time+0x36>
        }
    }

    if (next_release_time == INT_MAX)
    12a0:	fe442783          	lw	a5,-28(s0)
    12a4:	0007871b          	sext.w	a4,a5
    12a8:	800007b7          	lui	a5,0x80000
    12ac:	fff7c793          	not	a5,a5
    12b0:	00f71463          	bne	a4,a5,12b8 <find_next_release_time+0x9a>
        return -1; // No threads in the release queue
    12b4:	57fd                	li	a5,-1
    12b6:	a801                	j	12c6 <find_next_release_time+0xa8>

    return next_release_time - current_time;
    12b8:	fe442703          	lw	a4,-28(s0)
    12bc:	fc442783          	lw	a5,-60(s0)
    12c0:	40f707bb          	subw	a5,a4,a5
    12c4:	2781                	sext.w	a5,a5
}
    12c6:	853e                	mv	a0,a5
    12c8:	7462                	ld	s0,56(sp)
    12ca:	6121                	addi	sp,sp,64
    12cc:	8082                	ret

00000000000012ce <schedule_lst>:

/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args)
{
    12ce:	7119                	addi	sp,sp,-128
    12d0:	fc86                	sd	ra,120(sp)
    12d2:	f8a2                	sd	s0,112(sp)
    12d4:	f4a6                	sd	s1,104(sp)
    12d6:	f0ca                	sd	s2,96(sp)
    12d8:	ecce                	sd	s3,88(sp)
    12da:	0100                	addi	s0,sp,128
    12dc:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the least-slack-time scheduling algorithm
    struct thread *min_slack = NULL;
    12de:	fc043423          	sd	zero,-56(s0)
    int min_slack_time = INT_MAX;
    12e2:	800007b7          	lui	a5,0x80000
    12e6:	fff7c793          	not	a5,a5
    12ea:	fcf42223          	sw	a5,-60(s0)
    struct thread *t;

    // Find the thread with the minimum slack time
    list_for_each_entry(t, args.run_queue, thread_list) {
    12ee:	649c                	ld	a5,8(s1)
    12f0:	639c                	ld	a5,0(a5)
    12f2:	faf43823          	sd	a5,-80(s0)
    12f6:	fb043783          	ld	a5,-80(s0)
    12fa:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe158>
    12fe:	faf43c23          	sd	a5,-72(s0)
    1302:	a8b5                	j	137e <schedule_lst+0xb0>
        int slack_time = t->deadline - args.current_time - t->remaining_time;
    1304:	fb843783          	ld	a5,-72(s0)
    1308:	47f8                	lw	a4,76(a5)
    130a:	409c                	lw	a5,0(s1)
    130c:	40f707bb          	subw	a5,a4,a5
    1310:	0007871b          	sext.w	a4,a5
    1314:	fb843783          	ld	a5,-72(s0)
    1318:	4fbc                	lw	a5,88(a5)
    131a:	40f707bb          	subw	a5,a4,a5
    131e:	faf42623          	sw	a5,-84(s0)
        if (min_slack == NULL || slack_time < min_slack_time ||
    1322:	fc843783          	ld	a5,-56(s0)
    1326:	cb8d                	beqz	a5,1358 <schedule_lst+0x8a>
    1328:	fac42703          	lw	a4,-84(s0)
    132c:	fc442783          	lw	a5,-60(s0)
    1330:	2701                	sext.w	a4,a4
    1332:	2781                	sext.w	a5,a5
    1334:	02f74263          	blt	a4,a5,1358 <schedule_lst+0x8a>
    1338:	fac42703          	lw	a4,-84(s0)
    133c:	fc442783          	lw	a5,-60(s0)
    1340:	2701                	sext.w	a4,a4
    1342:	2781                	sext.w	a5,a5
    1344:	02f71263          	bne	a4,a5,1368 <schedule_lst+0x9a>
            (slack_time == min_slack_time && t->ID < min_slack->ID)) {
    1348:	fb843783          	ld	a5,-72(s0)
    134c:	5fd8                	lw	a4,60(a5)
    134e:	fc843783          	ld	a5,-56(s0)
    1352:	5fdc                	lw	a5,60(a5)
    1354:	00f75a63          	bge	a4,a5,1368 <schedule_lst+0x9a>
            min_slack = t;
    1358:	fb843783          	ld	a5,-72(s0)
    135c:	fcf43423          	sd	a5,-56(s0)
            min_slack_time = slack_time;
    1360:	fac42783          	lw	a5,-84(s0)
    1364:	fcf42223          	sw	a5,-60(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    1368:	fb843783          	ld	a5,-72(s0)
    136c:	779c                	ld	a5,40(a5)
    136e:	faf43023          	sd	a5,-96(s0)
    1372:	fa043783          	ld	a5,-96(s0)
    1376:	fd878793          	addi	a5,a5,-40
    137a:	faf43c23          	sd	a5,-72(s0)
    137e:	fb843783          	ld	a5,-72(s0)
    1382:	02878713          	addi	a4,a5,40
    1386:	649c                	ld	a5,8(s1)
    1388:	f6f71ee3          	bne	a4,a5,1304 <schedule_lst+0x36>
        }
    }

    if (min_slack) {
    138c:	fc843783          	ld	a5,-56(s0)
    1390:	cf89                	beqz	a5,13aa <schedule_lst+0xdc>
        r.scheduled_thread_list_member = &min_slack->thread_list;
    1392:	fc843783          	ld	a5,-56(s0)
    1396:	02878793          	addi	a5,a5,40
    139a:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = min_slack->remaining_time;
    139e:	fc843783          	ld	a5,-56(s0)
    13a2:	4fbc                	lw	a5,88(a5)
    13a4:	f8f42423          	sw	a5,-120(s0)
    13a8:	a839                	j	13c6 <schedule_lst+0xf8>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
    13aa:	649c                	ld	a5,8(s1)
    13ac:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    13b0:	689c                	ld	a5,16(s1)
    13b2:	4098                	lw	a4,0(s1)
    13b4:	85ba                	mv	a1,a4
    13b6:	853e                	mv	a0,a5
    13b8:	00000097          	auipc	ra,0x0
    13bc:	e66080e7          	jalr	-410(ra) # 121e <find_next_release_time>
    13c0:	87aa                	mv	a5,a0
    13c2:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    13c6:	f8043783          	ld	a5,-128(s0)
    13ca:	f8f43823          	sd	a5,-112(s0)
    13ce:	f8843783          	ld	a5,-120(s0)
    13d2:	f8f43c23          	sd	a5,-104(s0)
    13d6:	4701                	li	a4,0
    13d8:	f9043703          	ld	a4,-112(s0)
    13dc:	4781                	li	a5,0
    13de:	f9843783          	ld	a5,-104(s0)
    13e2:	893a                	mv	s2,a4
    13e4:	89be                	mv	s3,a5
    13e6:	874a                	mv	a4,s2
    13e8:	87ce                	mv	a5,s3
}
    13ea:	853a                	mv	a0,a4
    13ec:	85be                	mv	a1,a5
    13ee:	70e6                	ld	ra,120(sp)
    13f0:	7446                	ld	s0,112(sp)
    13f2:	74a6                	ld	s1,104(sp)
    13f4:	7906                	ld	s2,96(sp)
    13f6:	69e6                	ld	s3,88(sp)
    13f8:	6109                	addi	sp,sp,128
    13fa:	8082                	ret

00000000000013fc <schedule_dm>:

/* Deadline-Monotonic Scheduling */
struct threads_sched_result schedule_dm(struct threads_sched_args args)
{
    13fc:	7135                	addi	sp,sp,-160
    13fe:	ed06                	sd	ra,152(sp)
    1400:	e922                	sd	s0,144(sp)
    1402:	e526                	sd	s1,136(sp)
    1404:	e14a                	sd	s2,128(sp)
    1406:	fcce                	sd	s3,120(sp)
    1408:	1100                	addi	s0,sp,160
    140a:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the deadline-monotonic scheduling algorithm
   struct thread *earliest_deadline_thread = NULL;
    140c:	fc043423          	sd	zero,-56(s0)
    struct thread *t;
    int earliest_deadline = INT_MAX;
    1410:	800007b7          	lui	a5,0x80000
    1414:	fff7c793          	not	a5,a5
    1418:	faf42e23          	sw	a5,-68(s0)

    // Find the earliest deadline real-time thread
    list_for_each_entry(t, args.run_queue, thread_list) {
    141c:	649c                	ld	a5,8(s1)
    141e:	639c                	ld	a5,0(a5)
    1420:	faf43423          	sd	a5,-88(s0)
    1424:	fa843783          	ld	a5,-88(s0)
    1428:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe158>
    142c:	fcf43023          	sd	a5,-64(s0)
    1430:	a841                	j	14c0 <schedule_dm+0xc4>
        if (t->is_real_time && t->period != -1 && t->current_deadline < earliest_deadline) {
    1432:	fc043783          	ld	a5,-64(s0)
    1436:	43bc                	lw	a5,64(a5)
    1438:	cb95                	beqz	a5,146c <schedule_dm+0x70>
    143a:	fc043783          	ld	a5,-64(s0)
    143e:	4bbc                	lw	a5,80(a5)
    1440:	873e                	mv	a4,a5
    1442:	57fd                	li	a5,-1
    1444:	02f70463          	beq	a4,a5,146c <schedule_dm+0x70>
    1448:	fc043783          	ld	a5,-64(s0)
    144c:	4ff8                	lw	a4,92(a5)
    144e:	fbc42783          	lw	a5,-68(s0)
    1452:	2781                	sext.w	a5,a5
    1454:	00f75c63          	bge	a4,a5,146c <schedule_dm+0x70>
            earliest_deadline = t->current_deadline;
    1458:	fc043783          	ld	a5,-64(s0)
    145c:	4ffc                	lw	a5,92(a5)
    145e:	faf42e23          	sw	a5,-68(s0)
            earliest_deadline_thread = t;
    1462:	fc043783          	ld	a5,-64(s0)
    1466:	fcf43423          	sd	a5,-56(s0)
    146a:	a081                	j	14aa <schedule_dm+0xae>
        } else if (t->is_real_time && t->period != -1 && t->current_deadline == earliest_deadline && t->ID < earliest_deadline_thread->ID) {
    146c:	fc043783          	ld	a5,-64(s0)
    1470:	43bc                	lw	a5,64(a5)
    1472:	cf85                	beqz	a5,14aa <schedule_dm+0xae>
    1474:	fc043783          	ld	a5,-64(s0)
    1478:	4bbc                	lw	a5,80(a5)
    147a:	873e                	mv	a4,a5
    147c:	57fd                	li	a5,-1
    147e:	02f70663          	beq	a4,a5,14aa <schedule_dm+0xae>
    1482:	fc043783          	ld	a5,-64(s0)
    1486:	4ff8                	lw	a4,92(a5)
    1488:	fbc42783          	lw	a5,-68(s0)
    148c:	2781                	sext.w	a5,a5
    148e:	00e79e63          	bne	a5,a4,14aa <schedule_dm+0xae>
    1492:	fc043783          	ld	a5,-64(s0)
    1496:	5fd8                	lw	a4,60(a5)
    1498:	fc843783          	ld	a5,-56(s0)
    149c:	5fdc                	lw	a5,60(a5)
    149e:	00f75663          	bge	a4,a5,14aa <schedule_dm+0xae>
            earliest_deadline_thread = t;  // Tie-breaking by ID
    14a2:	fc043783          	ld	a5,-64(s0)
    14a6:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    14aa:	fc043783          	ld	a5,-64(s0)
    14ae:	779c                	ld	a5,40(a5)
    14b0:	f8f43423          	sd	a5,-120(s0)
    14b4:	f8843783          	ld	a5,-120(s0)
    14b8:	fd878793          	addi	a5,a5,-40
    14bc:	fcf43023          	sd	a5,-64(s0)
    14c0:	fc043783          	ld	a5,-64(s0)
    14c4:	02878713          	addi	a4,a5,40
    14c8:	649c                	ld	a5,8(s1)
    14ca:	f6f714e3          	bne	a4,a5,1432 <schedule_dm+0x36>
        }
    }

    if (earliest_deadline_thread) {
    14ce:	fc843783          	ld	a5,-56(s0)
    14d2:	c7a5                	beqz	a5,153a <schedule_dm+0x13e>
        int time_to_deadline = earliest_deadline_thread->current_deadline - args.current_time;
    14d4:	fc843783          	ld	a5,-56(s0)
    14d8:	4ff8                	lw	a4,92(a5)
    14da:	409c                	lw	a5,0(s1)
    14dc:	40f707bb          	subw	a5,a4,a5
    14e0:	f8f42a23          	sw	a5,-108(s0)
        if (earliest_deadline_thread->remaining_time > time_to_deadline) {
    14e4:	fc843783          	ld	a5,-56(s0)
    14e8:	4fb8                	lw	a4,88(a5)
    14ea:	f9442783          	lw	a5,-108(s0)
    14ee:	2781                	sext.w	a5,a5
    14f0:	00e7db63          	bge	a5,a4,1506 <schedule_dm+0x10a>
            // The real-time thread cannot complete before its deadline, so handle the deadline miss
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    14f4:	fc843783          	ld	a5,-56(s0)
    14f8:	02878793          	addi	a5,a5,40
    14fc:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = 0; // Could set to minimal quantum to allow cleanup or logging
    1500:	f6042823          	sw	zero,-144(s0)
    1504:	a0f1                	j	15d0 <schedule_dm+0x1d4>
        } else {
            // Schedule the real-time thread normally if it hasn't missed its deadline
            int time_slice = (time_to_deadline < earliest_deadline_thread->remaining_time) ? time_to_deadline : earliest_deadline_thread->remaining_time;
    1506:	fc843783          	ld	a5,-56(s0)
    150a:	4fbc                	lw	a5,88(a5)
    150c:	863e                	mv	a2,a5
    150e:	f9442783          	lw	a5,-108(s0)
    1512:	0007869b          	sext.w	a3,a5
    1516:	0006071b          	sext.w	a4,a2
    151a:	00d75363          	bge	a4,a3,1520 <schedule_dm+0x124>
    151e:	87b2                	mv	a5,a2
    1520:	f8f42823          	sw	a5,-112(s0)
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    1524:	fc843783          	ld	a5,-56(s0)
    1528:	02878793          	addi	a5,a5,40
    152c:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = time_slice;
    1530:	f9042783          	lw	a5,-112(s0)
    1534:	f6f42823          	sw	a5,-144(s0)
    1538:	a861                	j	15d0 <schedule_dm+0x1d4>
        }
    } else {
        // If no real-time threads with a deadline are ready, find the thread with the smallest ID
        struct thread *smallest_id_thread = NULL;
    153a:	fa043823          	sd	zero,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    153e:	649c                	ld	a5,8(s1)
    1540:	639c                	ld	a5,0(a5)
    1542:	faf43023          	sd	a5,-96(s0)
    1546:	fa043783          	ld	a5,-96(s0)
    154a:	fd878793          	addi	a5,a5,-40
    154e:	fcf43023          	sd	a5,-64(s0)
    1552:	a81d                	j	1588 <schedule_dm+0x18c>
            if (smallest_id_thread == NULL || t->ID < smallest_id_thread->ID) {
    1554:	fb043783          	ld	a5,-80(s0)
    1558:	cb89                	beqz	a5,156a <schedule_dm+0x16e>
    155a:	fc043783          	ld	a5,-64(s0)
    155e:	5fd8                	lw	a4,60(a5)
    1560:	fb043783          	ld	a5,-80(s0)
    1564:	5fdc                	lw	a5,60(a5)
    1566:	00f75663          	bge	a4,a5,1572 <schedule_dm+0x176>
                smallest_id_thread = t;
    156a:	fc043783          	ld	a5,-64(s0)
    156e:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    1572:	fc043783          	ld	a5,-64(s0)
    1576:	779c                	ld	a5,40(a5)
    1578:	f8f43c23          	sd	a5,-104(s0)
    157c:	f9843783          	ld	a5,-104(s0)
    1580:	fd878793          	addi	a5,a5,-40
    1584:	fcf43023          	sd	a5,-64(s0)
    1588:	fc043783          	ld	a5,-64(s0)
    158c:	02878713          	addi	a4,a5,40
    1590:	649c                	ld	a5,8(s1)
    1592:	fcf711e3          	bne	a4,a5,1554 <schedule_dm+0x158>
            }
        }

        if (smallest_id_thread) {
    1596:	fb043783          	ld	a5,-80(s0)
    159a:	cf89                	beqz	a5,15b4 <schedule_dm+0x1b8>
            r.scheduled_thread_list_member = &smallest_id_thread->thread_list;
    159c:	fb043783          	ld	a5,-80(s0)
    15a0:	02878793          	addi	a5,a5,40
    15a4:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = smallest_id_thread->remaining_time;
    15a8:	fb043783          	ld	a5,-80(s0)
    15ac:	4fbc                	lw	a5,88(a5)
    15ae:	f6f42823          	sw	a5,-144(s0)
    15b2:	a839                	j	15d0 <schedule_dm+0x1d4>
        } else {
            // If no thread is ready, perhaps idle or find the next release time
            r.scheduled_thread_list_member = args.run_queue;
    15b4:	649c                	ld	a5,8(s1)
    15b6:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    15ba:	689c                	ld	a5,16(s1)
    15bc:	4098                	lw	a4,0(s1)
    15be:	85ba                	mv	a1,a4
    15c0:	853e                	mv	a0,a5
    15c2:	00000097          	auipc	ra,0x0
    15c6:	c5c080e7          	jalr	-932(ra) # 121e <find_next_release_time>
    15ca:	87aa                	mv	a5,a0
    15cc:	f6f42823          	sw	a5,-144(s0)
        }
    }

    return r;
    15d0:	f6843783          	ld	a5,-152(s0)
    15d4:	f6f43c23          	sd	a5,-136(s0)
    15d8:	f7043783          	ld	a5,-144(s0)
    15dc:	f8f43023          	sd	a5,-128(s0)
    15e0:	4701                	li	a4,0
    15e2:	f7843703          	ld	a4,-136(s0)
    15e6:	4781                	li	a5,0
    15e8:	f8043783          	ld	a5,-128(s0)
    15ec:	893a                	mv	s2,a4
    15ee:	89be                	mv	s3,a5
    15f0:	874a                	mv	a4,s2
    15f2:	87ce                	mv	a5,s3
}
    15f4:	853a                	mv	a0,a4
    15f6:	85be                	mv	a1,a5
    15f8:	60ea                	ld	ra,152(sp)
    15fa:	644a                	ld	s0,144(sp)
    15fc:	64aa                	ld	s1,136(sp)
    15fe:	690a                	ld	s2,128(sp)
    1600:	79e6                	ld	s3,120(sp)
    1602:	610d                	addi	sp,sp,160
    1604:	8082                	ret
