
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
      16:	00002597          	auipc	a1,0x2
      1a:	b9a58593          	addi	a1,a1,-1126 # 1bb0 <buf>
      1e:	4505                	li	a0,1
      20:	00000097          	auipc	ra,0x0
      24:	60e080e7          	jalr	1550(ra) # 62e <write>
      28:	87aa                	mv	a5,a0
      2a:	873e                	mv	a4,a5
      2c:	fec42783          	lw	a5,-20(s0)
      30:	2781                	sext.w	a5,a5
      32:	02e78063          	beq	a5,a4,52 <cat+0x52>
      fprintf(2, "cat: write error\n");
      36:	00002597          	auipc	a1,0x2
      3a:	b1258593          	addi	a1,a1,-1262 # 1b48 <schedule_dm+0x1f4>
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
      5a:	00002597          	auipc	a1,0x2
      5e:	b5658593          	addi	a1,a1,-1194 # 1bb0 <buf>
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
      86:	00002597          	auipc	a1,0x2
      8a:	ada58593          	addi	a1,a1,-1318 # 1b60 <schedule_dm+0x20c>
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
     122:	00002597          	auipc	a1,0x2
     126:	a5658593          	addi	a1,a1,-1450 # 1b78 <schedule_dm+0x224>
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
     776:	42668693          	addi	a3,a3,1062 # 1b98 <digits>
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
     850:	34c70713          	addi	a4,a4,844 # 1b98 <digits>
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
     a10:	18478793          	addi	a5,a5,388 # 1b90 <schedule_dm+0x23c>
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
     bbc:	20878793          	addi	a5,a5,520 # 1dc0 <freep>
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
     cb4:	11078793          	addi	a5,a5,272 # 1dc0 <freep>
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
     d36:	08e78793          	addi	a5,a5,142 # 1dc0 <freep>
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
     d68:	05c78793          	addi	a5,a5,92 # 1dc0 <freep>
     d6c:	639c                	ld	a5,0(a5)
     d6e:	fef43023          	sd	a5,-32(s0)
     d72:	fe043783          	ld	a5,-32(s0)
     d76:	ef95                	bnez	a5,db2 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     d78:	00001797          	auipc	a5,0x1
     d7c:	03878793          	addi	a5,a5,56 # 1db0 <base>
     d80:	fef43023          	sd	a5,-32(s0)
     d84:	00001797          	auipc	a5,0x1
     d88:	03c78793          	addi	a5,a5,60 # 1dc0 <freep>
     d8c:	fe043703          	ld	a4,-32(s0)
     d90:	e398                	sd	a4,0(a5)
     d92:	00001797          	auipc	a5,0x1
     d96:	02e78793          	addi	a5,a5,46 # 1dc0 <freep>
     d9a:	6398                	ld	a4,0(a5)
     d9c:	00001797          	auipc	a5,0x1
     da0:	01478793          	addi	a5,a5,20 # 1db0 <base>
     da4:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     da6:	00001797          	auipc	a5,0x1
     daa:	00a78793          	addi	a5,a5,10 # 1db0 <base>
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
     e26:	f9e78793          	addi	a5,a5,-98 # 1dc0 <freep>
     e2a:	fe043703          	ld	a4,-32(s0)
     e2e:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     e30:	fe843783          	ld	a5,-24(s0)
     e34:	07c1                	addi	a5,a5,16
     e36:	a091                	j	e7a <malloc+0x134>
    }
    if(p == freep)
     e38:	00001797          	auipc	a5,0x1
     e3c:	f8878793          	addi	a5,a5,-120 # 1dc0 <freep>
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

0000000000000fbe <find_next_release_time>:

int find_next_release_time(struct list_head *release_queue, int current_time) {
     fbe:	7139                	addi	sp,sp,-64
     fc0:	fc22                	sd	s0,56(sp)
     fc2:	0080                	addi	s0,sp,64
     fc4:	fca43423          	sd	a0,-56(s0)
     fc8:	87ae                	mv	a5,a1
     fca:	fcf42223          	sw	a5,-60(s0)
    struct release_queue_entry *next_release = NULL;
     fce:	fe043423          	sd	zero,-24(s0)
    int next_release_time = INT_MAX;
     fd2:	800007b7          	lui	a5,0x80000
     fd6:	fff7c793          	not	a5,a5
     fda:	fef42223          	sw	a5,-28(s0)

    list_for_each_entry(next_release, release_queue, thread_list) {
     fde:	fc843783          	ld	a5,-56(s0)
     fe2:	639c                	ld	a5,0(a5)
     fe4:	fcf43c23          	sd	a5,-40(s0)
     fe8:	fd843783          	ld	a5,-40(s0)
     fec:	17e1                	addi	a5,a5,-8
     fee:	fef43423          	sd	a5,-24(s0)
     ff2:	a081                	j	1032 <find_next_release_time+0x74>
        if (next_release->release_time > current_time && next_release->release_time < next_release_time) {
     ff4:	fe843783          	ld	a5,-24(s0)
     ff8:	4f98                	lw	a4,24(a5)
     ffa:	fc442783          	lw	a5,-60(s0)
     ffe:	2781                	sext.w	a5,a5
    1000:	00e7df63          	bge	a5,a4,101e <find_next_release_time+0x60>
    1004:	fe843783          	ld	a5,-24(s0)
    1008:	4f98                	lw	a4,24(a5)
    100a:	fe442783          	lw	a5,-28(s0)
    100e:	2781                	sext.w	a5,a5
    1010:	00f75763          	bge	a4,a5,101e <find_next_release_time+0x60>
            next_release_time = next_release->release_time;
    1014:	fe843783          	ld	a5,-24(s0)
    1018:	4f9c                	lw	a5,24(a5)
    101a:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(next_release, release_queue, thread_list) {
    101e:	fe843783          	ld	a5,-24(s0)
    1022:	679c                	ld	a5,8(a5)
    1024:	fcf43823          	sd	a5,-48(s0)
    1028:	fd043783          	ld	a5,-48(s0)
    102c:	17e1                	addi	a5,a5,-8
    102e:	fef43423          	sd	a5,-24(s0)
    1032:	fe843783          	ld	a5,-24(s0)
    1036:	07a1                	addi	a5,a5,8
    1038:	fc843703          	ld	a4,-56(s0)
    103c:	faf71ce3          	bne	a4,a5,ff4 <find_next_release_time+0x36>
        }
    }

    if (next_release_time == INT_MAX)
    1040:	fe442783          	lw	a5,-28(s0)
    1044:	0007871b          	sext.w	a4,a5
    1048:	800007b7          	lui	a5,0x80000
    104c:	fff7c793          	not	a5,a5
    1050:	00f71463          	bne	a4,a5,1058 <find_next_release_time+0x9a>
        return -1; // No threads in the release queue
    1054:	57fd                	li	a5,-1
    1056:	a801                	j	1066 <find_next_release_time+0xa8>

    return next_release_time - current_time;
    1058:	fe442703          	lw	a4,-28(s0)
    105c:	fc442783          	lw	a5,-60(s0)
    1060:	40f707bb          	subw	a5,a4,a5
    1064:	2781                	sext.w	a5,a5
}
    1066:	853e                	mv	a0,a5
    1068:	7462                	ld	s0,56(sp)
    106a:	6121                	addi	sp,sp,64
    106c:	8082                	ret

000000000000106e <schedule_wrr>:

/* MP3 Part 1 - Non-Real-Time Scheduling */
/* Weighted-Round-Robin Scheduling */
struct threads_sched_result schedule_wrr(struct threads_sched_args args)
{
    106e:	7119                	addi	sp,sp,-128
    1070:	fc86                	sd	ra,120(sp)
    1072:	f8a2                	sd	s0,112(sp)
    1074:	f4a6                	sd	s1,104(sp)
    1076:	f0ca                	sd	s2,96(sp)
    1078:	ecce                	sd	s3,88(sp)
    107a:	0100                	addi	s0,sp,128
    107c:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the weighted round-robin scheduling algorithm
    static struct thread *last_thread = NULL;
    struct thread *selected_thread = NULL;
    107e:	fc043423          	sd	zero,-56(s0)
    struct thread *candidate = NULL;
    1082:	fc043023          	sd	zero,-64(s0)

    // If last_thread is NULL or its remaining time is zero, reset the selection process
    if (last_thread == NULL || last_thread->remaining_time <= 0) {
    1086:	00001797          	auipc	a5,0x1
    108a:	d4278793          	addi	a5,a5,-702 # 1dc8 <last_thread.1239>
    108e:	639c                	ld	a5,0(a5)
    1090:	cb89                	beqz	a5,10a2 <schedule_wrr+0x34>
    1092:	00001797          	auipc	a5,0x1
    1096:	d3678793          	addi	a5,a5,-714 # 1dc8 <last_thread.1239>
    109a:	639c                	ld	a5,0(a5)
    109c:	4fbc                	lw	a5,88(a5)
    109e:	00f04863          	bgtz	a5,10ae <schedule_wrr+0x40>
        last_thread = NULL;
    10a2:	00001797          	auipc	a5,0x1
    10a6:	d2678793          	addi	a5,a5,-730 # 1dc8 <last_thread.1239>
    10aa:	0007b023          	sd	zero,0(a5)
    }

    // Find the first thread that is ready to run
    list_for_each_entry(candidate, args.run_queue, thread_list) {
    10ae:	649c                	ld	a5,8(s1)
    10b0:	639c                	ld	a5,0(a5)
    10b2:	faf43823          	sd	a5,-80(s0)
    10b6:	fb043783          	ld	a5,-80(s0)
    10ba:	fd878793          	addi	a5,a5,-40
    10be:	fcf43023          	sd	a5,-64(s0)
    10c2:	a0a9                	j	110c <schedule_wrr+0x9e>
        if (!last_thread && candidate->remaining_time > 0)
    10c4:	00001797          	auipc	a5,0x1
    10c8:	d0478793          	addi	a5,a5,-764 # 1dc8 <last_thread.1239>
    10cc:	639c                	ld	a5,0(a5)
    10ce:	eb91                	bnez	a5,10e2 <schedule_wrr+0x74>
    10d0:	fc043783          	ld	a5,-64(s0)
    10d4:	4fbc                	lw	a5,88(a5)
    10d6:	00f05663          	blez	a5,10e2 <schedule_wrr+0x74>
            selected_thread = candidate;
    10da:	fc043783          	ld	a5,-64(s0)
    10de:	fcf43423          	sd	a5,-56(s0)
        if (candidate->remaining_time > 0) {
    10e2:	fc043783          	ld	a5,-64(s0)
    10e6:	4fbc                	lw	a5,88(a5)
    10e8:	00f05763          	blez	a5,10f6 <schedule_wrr+0x88>
            selected_thread = candidate;
    10ec:	fc043783          	ld	a5,-64(s0)
    10f0:	fcf43423          	sd	a5,-56(s0)
            break;
    10f4:	a01d                	j	111a <schedule_wrr+0xac>
    list_for_each_entry(candidate, args.run_queue, thread_list) {
    10f6:	fc043783          	ld	a5,-64(s0)
    10fa:	779c                	ld	a5,40(a5)
    10fc:	faf43423          	sd	a5,-88(s0)
    1100:	fa843783          	ld	a5,-88(s0)
    1104:	fd878793          	addi	a5,a5,-40
    1108:	fcf43023          	sd	a5,-64(s0)
    110c:	fc043783          	ld	a5,-64(s0)
    1110:	02878713          	addi	a4,a5,40
    1114:	649c                	ld	a5,8(s1)
    1116:	faf717e3          	bne	a4,a5,10c4 <schedule_wrr+0x56>
        }
    }

    // Fall back to the last_thread if no other thread is selected and it still has remaining time
    if (!selected_thread && last_thread && last_thread->remaining_time > 0) {
    111a:	fc843783          	ld	a5,-56(s0)
    111e:	e795                	bnez	a5,114a <schedule_wrr+0xdc>
    1120:	00001797          	auipc	a5,0x1
    1124:	ca878793          	addi	a5,a5,-856 # 1dc8 <last_thread.1239>
    1128:	639c                	ld	a5,0(a5)
    112a:	c385                	beqz	a5,114a <schedule_wrr+0xdc>
    112c:	00001797          	auipc	a5,0x1
    1130:	c9c78793          	addi	a5,a5,-868 # 1dc8 <last_thread.1239>
    1134:	639c                	ld	a5,0(a5)
    1136:	4fbc                	lw	a5,88(a5)
    1138:	00f05963          	blez	a5,114a <schedule_wrr+0xdc>
        selected_thread = last_thread;
    113c:	00001797          	auipc	a5,0x1
    1140:	c8c78793          	addi	a5,a5,-884 # 1dc8 <last_thread.1239>
    1144:	639c                	ld	a5,0(a5)
    1146:	fcf43423          	sd	a5,-56(s0)
    }

    // Set the scheduling result
    if (selected_thread) {
    114a:	fc843783          	ld	a5,-56(s0)
    114e:	c7b9                	beqz	a5,119c <schedule_wrr+0x12e>
        int time_slice = selected_thread->weight * TIME_QUANTUM;
    1150:	fc843783          	ld	a5,-56(s0)
    1154:	47bc                	lw	a5,72(a5)
    1156:	0017979b          	slliw	a5,a5,0x1
    115a:	faf42e23          	sw	a5,-68(s0)
        if (time_slice > selected_thread->remaining_time) {
    115e:	fc843783          	ld	a5,-56(s0)
    1162:	4fb8                	lw	a4,88(a5)
    1164:	fbc42783          	lw	a5,-68(s0)
    1168:	2781                	sext.w	a5,a5
    116a:	00f75763          	bge	a4,a5,1178 <schedule_wrr+0x10a>
            time_slice = selected_thread->remaining_time;
    116e:	fc843783          	ld	a5,-56(s0)
    1172:	4fbc                	lw	a5,88(a5)
    1174:	faf42e23          	sw	a5,-68(s0)
        }
        r.scheduled_thread_list_member = &selected_thread->thread_list;
    1178:	fc843783          	ld	a5,-56(s0)
    117c:	02878793          	addi	a5,a5,40
    1180:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = time_slice;
    1184:	fbc42783          	lw	a5,-68(s0)
    1188:	f8f42823          	sw	a5,-112(s0)
        last_thread = selected_thread;  // Update the last run thread
    118c:	00001797          	auipc	a5,0x1
    1190:	c3c78793          	addi	a5,a5,-964 # 1dc8 <last_thread.1239>
    1194:	fc843703          	ld	a4,-56(s0)
    1198:	e398                	sd	a4,0(a5)
    119a:	a839                	j	11b8 <schedule_wrr+0x14a>
    } else {
        // Idle if no suitable thread is found
        r.scheduled_thread_list_member = args.run_queue;
    119c:	649c                	ld	a5,8(s1)
    119e:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    11a2:	689c                	ld	a5,16(s1)
    11a4:	4098                	lw	a4,0(s1)
    11a6:	85ba                	mv	a1,a4
    11a8:	853e                	mv	a0,a5
    11aa:	00000097          	auipc	ra,0x0
    11ae:	e14080e7          	jalr	-492(ra) # fbe <find_next_release_time>
    11b2:	87aa                	mv	a5,a0
    11b4:	f8f42823          	sw	a5,-112(s0)
    }

    return r;
    11b8:	f8843783          	ld	a5,-120(s0)
    11bc:	f8f43c23          	sd	a5,-104(s0)
    11c0:	f9043783          	ld	a5,-112(s0)
    11c4:	faf43023          	sd	a5,-96(s0)
    11c8:	4701                	li	a4,0
    11ca:	f9843703          	ld	a4,-104(s0)
    11ce:	4781                	li	a5,0
    11d0:	fa043783          	ld	a5,-96(s0)
    11d4:	893a                	mv	s2,a4
    11d6:	89be                	mv	s3,a5
    11d8:	874a                	mv	a4,s2
    11da:	87ce                	mv	a5,s3
}
    11dc:	853a                	mv	a0,a4
    11de:	85be                	mv	a1,a5
    11e0:	70e6                	ld	ra,120(sp)
    11e2:	7446                	ld	s0,112(sp)
    11e4:	74a6                	ld	s1,104(sp)
    11e6:	7906                	ld	s2,96(sp)
    11e8:	69e6                	ld	s3,88(sp)
    11ea:	6109                	addi	sp,sp,128
    11ec:	8082                	ret

00000000000011ee <find_earliest_impactful_release_time>:


int find_earliest_impactful_release_time(struct list_head *release_queue, struct list_head *run_queue, int current_time) {
    11ee:	7159                	addi	sp,sp,-112
    11f0:	f4a2                	sd	s0,104(sp)
    11f2:	1880                	addi	s0,sp,112
    11f4:	faa43423          	sd	a0,-88(s0)
    11f8:	fab43023          	sd	a1,-96(s0)
    11fc:	87b2                	mv	a5,a2
    11fe:	f8f42e23          	sw	a5,-100(s0)
    struct release_queue_entry *entry;
    int earliest_impactful_time = INT_MAX;
    1202:	800007b7          	lui	a5,0x80000
    1206:	fff7c793          	not	a5,a5
    120a:	fef42223          	sw	a5,-28(s0)
    int shortest_current_time = INT_MAX;
    120e:	800007b7          	lui	a5,0x80000
    1212:	fff7c793          	not	a5,a5
    1216:	fef42023          	sw	a5,-32(s0)
    // Find the shortest remaining time among currently running tasks
    struct thread *t;
    list_for_each_entry(t, run_queue, thread_list) {
    121a:	fa043783          	ld	a5,-96(s0)
    121e:	639c                	ld	a5,0(a5)
    1220:	fcf43823          	sd	a5,-48(s0)
    1224:	fd043783          	ld	a5,-48(s0)
    1228:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffdc40>
    122c:	fcf43c23          	sd	a5,-40(s0)
    1230:	a80d                	j	1262 <find_earliest_impactful_release_time+0x74>
        if (t->remaining_time < shortest_current_time) {
    1232:	fd843783          	ld	a5,-40(s0)
    1236:	4fb8                	lw	a4,88(a5)
    1238:	fe042783          	lw	a5,-32(s0)
    123c:	2781                	sext.w	a5,a5
    123e:	00f75763          	bge	a4,a5,124c <find_earliest_impactful_release_time+0x5e>
            shortest_current_time = t->remaining_time;
    1242:	fd843783          	ld	a5,-40(s0)
    1246:	4fbc                	lw	a5,88(a5)
    1248:	fef42023          	sw	a5,-32(s0)
    list_for_each_entry(t, run_queue, thread_list) {
    124c:	fd843783          	ld	a5,-40(s0)
    1250:	779c                	ld	a5,40(a5)
    1252:	faf43c23          	sd	a5,-72(s0)
    1256:	fb843783          	ld	a5,-72(s0)
    125a:	fd878793          	addi	a5,a5,-40
    125e:	fcf43c23          	sd	a5,-40(s0)
    1262:	fd843783          	ld	a5,-40(s0)
    1266:	02878793          	addi	a5,a5,40
    126a:	fa043703          	ld	a4,-96(s0)
    126e:	fcf712e3          	bne	a4,a5,1232 <find_earliest_impactful_release_time+0x44>
        }
    }

    // Check the release queue for the next task that might preempt the current shortest job
    list_for_each_entry(entry, release_queue, thread_list) {
    1272:	fa843783          	ld	a5,-88(s0)
    1276:	639c                	ld	a5,0(a5)
    1278:	fcf43423          	sd	a5,-56(s0)
    127c:	fc843783          	ld	a5,-56(s0)
    1280:	17e1                	addi	a5,a5,-8
    1282:	fef43423          	sd	a5,-24(s0)
    1286:	a889                	j	12d8 <find_earliest_impactful_release_time+0xea>
        if (entry->release_time > current_time && entry->release_time < earliest_impactful_time) {
    1288:	fe843783          	ld	a5,-24(s0)
    128c:	4f98                	lw	a4,24(a5)
    128e:	f9c42783          	lw	a5,-100(s0)
    1292:	2781                	sext.w	a5,a5
    1294:	02e7d863          	bge	a5,a4,12c4 <find_earliest_impactful_release_time+0xd6>
    1298:	fe843783          	ld	a5,-24(s0)
    129c:	4f98                	lw	a4,24(a5)
    129e:	fe442783          	lw	a5,-28(s0)
    12a2:	2781                	sext.w	a5,a5
    12a4:	02f75063          	bge	a4,a5,12c4 <find_earliest_impactful_release_time+0xd6>
            if (entry->thrd->remaining_time < shortest_current_time) {
    12a8:	fe843783          	ld	a5,-24(s0)
    12ac:	639c                	ld	a5,0(a5)
    12ae:	4fb8                	lw	a4,88(a5)
    12b0:	fe042783          	lw	a5,-32(s0)
    12b4:	2781                	sext.w	a5,a5
    12b6:	00f75763          	bge	a4,a5,12c4 <find_earliest_impactful_release_time+0xd6>
                earliest_impactful_time = entry->release_time;
    12ba:	fe843783          	ld	a5,-24(s0)
    12be:	4f9c                	lw	a5,24(a5)
    12c0:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(entry, release_queue, thread_list) {
    12c4:	fe843783          	ld	a5,-24(s0)
    12c8:	679c                	ld	a5,8(a5)
    12ca:	fcf43023          	sd	a5,-64(s0)
    12ce:	fc043783          	ld	a5,-64(s0)
    12d2:	17e1                	addi	a5,a5,-8
    12d4:	fef43423          	sd	a5,-24(s0)
    12d8:	fe843783          	ld	a5,-24(s0)
    12dc:	07a1                	addi	a5,a5,8
    12de:	fa843703          	ld	a4,-88(s0)
    12e2:	faf713e3          	bne	a4,a5,1288 <find_earliest_impactful_release_time+0x9a>
            }
        }
    }

    // Calculate the difference between the current time and the earliest impactful release time
    return earliest_impactful_time == INT_MAX ? -1 : earliest_impactful_time - current_time;
    12e6:	fe442783          	lw	a5,-28(s0)
    12ea:	0007871b          	sext.w	a4,a5
    12ee:	800007b7          	lui	a5,0x80000
    12f2:	fff7c793          	not	a5,a5
    12f6:	00f70a63          	beq	a4,a5,130a <find_earliest_impactful_release_time+0x11c>
    12fa:	fe442703          	lw	a4,-28(s0)
    12fe:	f9c42783          	lw	a5,-100(s0)
    1302:	40f707bb          	subw	a5,a4,a5
    1306:	2781                	sext.w	a5,a5
    1308:	a011                	j	130c <find_earliest_impactful_release_time+0x11e>
    130a:	57fd                	li	a5,-1
}
    130c:	853e                	mv	a0,a5
    130e:	7426                	ld	s0,104(sp)
    1310:	6165                	addi	sp,sp,112
    1312:	8082                	ret

0000000000001314 <schedule_sjf>:


struct threads_sched_result schedule_sjf(struct threads_sched_args args) {
    1314:	7119                	addi	sp,sp,-128
    1316:	fc86                	sd	ra,120(sp)
    1318:	f8a2                	sd	s0,112(sp)
    131a:	f4a6                	sd	s1,104(sp)
    131c:	f0ca                	sd	s2,96(sp)
    131e:	ecce                	sd	s3,88(sp)
    1320:	0100                	addi	s0,sp,128
    1322:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *shortest_job = NULL;
    1324:	fc043423          	sd	zero,-56(s0)
    struct thread *current;
    int shortest_time = INT_MAX;
    1328:	800007b7          	lui	a5,0x80000
    132c:	fff7c793          	not	a5,a5
    1330:	faf42e23          	sw	a5,-68(s0)
    int earliest_impactful_time = find_earliest_impactful_release_time(args.release_queue, args.run_queue, args.current_time);
    1334:	689c                	ld	a5,16(s1)
    1336:	6498                	ld	a4,8(s1)
    1338:	4094                	lw	a3,0(s1)
    133a:	8636                	mv	a2,a3
    133c:	85ba                	mv	a1,a4
    133e:	853e                	mv	a0,a5
    1340:	00000097          	auipc	ra,0x0
    1344:	eae080e7          	jalr	-338(ra) # 11ee <find_earliest_impactful_release_time>
    1348:	87aa                	mv	a5,a0
    134a:	faf42a23          	sw	a5,-76(s0)

    // Determine the shortest job from the run queue
    list_for_each_entry(current, args.run_queue, thread_list) {
    134e:	649c                	ld	a5,8(s1)
    1350:	639c                	ld	a5,0(a5)
    1352:	faf43423          	sd	a5,-88(s0)
    1356:	fa843783          	ld	a5,-88(s0)
    135a:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffdc40>
    135e:	fcf43023          	sd	a5,-64(s0)
    1362:	a82d                	j	139c <schedule_sjf+0x88>
        if (current->remaining_time < shortest_time) {
    1364:	fc043783          	ld	a5,-64(s0)
    1368:	4fb8                	lw	a4,88(a5)
    136a:	fbc42783          	lw	a5,-68(s0)
    136e:	2781                	sext.w	a5,a5
    1370:	00f75b63          	bge	a4,a5,1386 <schedule_sjf+0x72>
            shortest_time = current->remaining_time;
    1374:	fc043783          	ld	a5,-64(s0)
    1378:	4fbc                	lw	a5,88(a5)
    137a:	faf42e23          	sw	a5,-68(s0)
            shortest_job = current;
    137e:	fc043783          	ld	a5,-64(s0)
    1382:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(current, args.run_queue, thread_list) {
    1386:	fc043783          	ld	a5,-64(s0)
    138a:	779c                	ld	a5,40(a5)
    138c:	faf43023          	sd	a5,-96(s0)
    1390:	fa043783          	ld	a5,-96(s0)
    1394:	fd878793          	addi	a5,a5,-40
    1398:	fcf43023          	sd	a5,-64(s0)
    139c:	fc043783          	ld	a5,-64(s0)
    13a0:	02878713          	addi	a4,a5,40
    13a4:	649c                	ld	a5,8(s1)
    13a6:	faf71fe3          	bne	a4,a5,1364 <schedule_sjf+0x50>
        }
    }

    if (shortest_job) {
    13aa:	fc843783          	ld	a5,-56(s0)
    13ae:	c7a1                	beqz	a5,13f6 <schedule_sjf+0xe2>
        int time_to_allocate = shortest_job->remaining_time;
    13b0:	fc843783          	ld	a5,-56(s0)
    13b4:	4fbc                	lw	a5,88(a5)
    13b6:	faf42c23          	sw	a5,-72(s0)
        // Reduce the time slice if an impactful task is arriving sooner
        if (earliest_impactful_time != -1 && earliest_impactful_time < time_to_allocate) {
    13ba:	fb442783          	lw	a5,-76(s0)
    13be:	0007871b          	sext.w	a4,a5
    13c2:	57fd                	li	a5,-1
    13c4:	00f70e63          	beq	a4,a5,13e0 <schedule_sjf+0xcc>
    13c8:	fb442703          	lw	a4,-76(s0)
    13cc:	fb842783          	lw	a5,-72(s0)
    13d0:	2701                	sext.w	a4,a4
    13d2:	2781                	sext.w	a5,a5
    13d4:	00f75663          	bge	a4,a5,13e0 <schedule_sjf+0xcc>
            time_to_allocate = earliest_impactful_time;
    13d8:	fb442783          	lw	a5,-76(s0)
    13dc:	faf42c23          	sw	a5,-72(s0)
        }

        r.scheduled_thread_list_member = &shortest_job->thread_list;
    13e0:	fc843783          	ld	a5,-56(s0)
    13e4:	02878793          	addi	a5,a5,40
    13e8:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = time_to_allocate;
    13ec:	fb842783          	lw	a5,-72(s0)
    13f0:	f8f42423          	sw	a5,-120(s0)
    13f4:	a80d                	j	1426 <schedule_sjf+0x112>
    } else {
        // If no current tasks are ready, wait for the next impactful task
        r.scheduled_thread_list_member = args.run_queue;
    13f6:	649c                	ld	a5,8(s1)
    13f8:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = earliest_impactful_time != -1 ? earliest_impactful_time : find_next_release_time(args.release_queue, args.current_time);
    13fc:	fb442783          	lw	a5,-76(s0)
    1400:	0007871b          	sext.w	a4,a5
    1404:	57fd                	li	a5,-1
    1406:	00f71c63          	bne	a4,a5,141e <schedule_sjf+0x10a>
    140a:	689c                	ld	a5,16(s1)
    140c:	4098                	lw	a4,0(s1)
    140e:	85ba                	mv	a1,a4
    1410:	853e                	mv	a0,a5
    1412:	00000097          	auipc	ra,0x0
    1416:	bac080e7          	jalr	-1108(ra) # fbe <find_next_release_time>
    141a:	87aa                	mv	a5,a0
    141c:	a019                	j	1422 <schedule_sjf+0x10e>
    141e:	fb442783          	lw	a5,-76(s0)
    1422:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    1426:	f8043783          	ld	a5,-128(s0)
    142a:	f8f43823          	sd	a5,-112(s0)
    142e:	f8843783          	ld	a5,-120(s0)
    1432:	f8f43c23          	sd	a5,-104(s0)
    1436:	4701                	li	a4,0
    1438:	f9043703          	ld	a4,-112(s0)
    143c:	4781                	li	a5,0
    143e:	f9843783          	ld	a5,-104(s0)
    1442:	893a                	mv	s2,a4
    1444:	89be                	mv	s3,a5
    1446:	874a                	mv	a4,s2
    1448:	87ce                	mv	a5,s3
}
    144a:	853a                	mv	a0,a4
    144c:	85be                	mv	a1,a5
    144e:	70e6                	ld	ra,120(sp)
    1450:	7446                	ld	s0,112(sp)
    1452:	74a6                	ld	s1,104(sp)
    1454:	7906                	ld	s2,96(sp)
    1456:	69e6                	ld	s3,88(sp)
    1458:	6109                	addi	sp,sp,128
    145a:	8082                	ret

000000000000145c <min>:

int min(int a, int b) {
    145c:	1101                	addi	sp,sp,-32
    145e:	ec22                	sd	s0,24(sp)
    1460:	1000                	addi	s0,sp,32
    1462:	87aa                	mv	a5,a0
    1464:	872e                	mv	a4,a1
    1466:	fef42623          	sw	a5,-20(s0)
    146a:	87ba                	mv	a5,a4
    146c:	fef42423          	sw	a5,-24(s0)
    return (a < b) ? a : b;
    1470:	fec42603          	lw	a2,-20(s0)
    1474:	fe842783          	lw	a5,-24(s0)
    1478:	0007869b          	sext.w	a3,a5
    147c:	0006071b          	sext.w	a4,a2
    1480:	00d75363          	bge	a4,a3,1486 <min+0x2a>
    1484:	87b2                	mv	a5,a2
    1486:	2781                	sext.w	a5,a5
}
    1488:	853e                	mv	a0,a5
    148a:	6462                	ld	s0,24(sp)
    148c:	6105                	addi	sp,sp,32
    148e:	8082                	ret

0000000000001490 <schedule_lst>:

/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args) {
    1490:	7115                	addi	sp,sp,-224
    1492:	ed86                	sd	ra,216(sp)
    1494:	e9a2                	sd	s0,208(sp)
    1496:	e5a6                	sd	s1,200(sp)
    1498:	e1ca                	sd	s2,192(sp)
    149a:	fd4e                	sd	s3,184(sp)
    149c:	1180                	addi	s0,sp,224
    149e:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *min_slack_thread = NULL;
    14a0:	fc043423          	sd	zero,-56(s0)
    int min_slack_time = INT_MAX;
    14a4:	800007b7          	lui	a5,0x80000
    14a8:	fff7c793          	not	a5,a5
    14ac:	fcf42223          	sw	a5,-60(s0)
    struct thread *t;

    // Determine the thread with the minimum slack time
    list_for_each_entry(t, args.run_queue, thread_list) {
    14b0:	649c                	ld	a5,8(s1)
    14b2:	639c                	ld	a5,0(a5)
    14b4:	f8f43823          	sd	a5,-112(s0)
    14b8:	f9043783          	ld	a5,-112(s0)
    14bc:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffdc40>
    14c0:	faf43c23          	sd	a5,-72(s0)
    14c4:	a069                	j	154e <schedule_lst+0xbe>
        int slack_time = t->current_deadline - args.current_time - t->remaining_time;
    14c6:	fb843783          	ld	a5,-72(s0)
    14ca:	4ff8                	lw	a4,92(a5)
    14cc:	409c                	lw	a5,0(s1)
    14ce:	40f707bb          	subw	a5,a4,a5
    14d2:	0007871b          	sext.w	a4,a5
    14d6:	fb843783          	ld	a5,-72(s0)
    14da:	4fbc                	lw	a5,88(a5)
    14dc:	40f707bb          	subw	a5,a4,a5
    14e0:	f4f42a23          	sw	a5,-172(s0)
        if (slack_time < min_slack_time || (slack_time == min_slack_time && t->ID < (min_slack_thread ? min_slack_thread->ID : INT_MAX))) {
    14e4:	f5442703          	lw	a4,-172(s0)
    14e8:	fc442783          	lw	a5,-60(s0)
    14ec:	2701                	sext.w	a4,a4
    14ee:	2781                	sext.w	a5,a5
    14f0:	02f74c63          	blt	a4,a5,1528 <schedule_lst+0x98>
    14f4:	f5442703          	lw	a4,-172(s0)
    14f8:	fc442783          	lw	a5,-60(s0)
    14fc:	2701                	sext.w	a4,a4
    14fe:	2781                	sext.w	a5,a5
    1500:	02f71c63          	bne	a4,a5,1538 <schedule_lst+0xa8>
    1504:	fb843783          	ld	a5,-72(s0)
    1508:	5fd4                	lw	a3,60(a5)
    150a:	fc843783          	ld	a5,-56(s0)
    150e:	c789                	beqz	a5,1518 <schedule_lst+0x88>
    1510:	fc843783          	ld	a5,-56(s0)
    1514:	5fdc                	lw	a5,60(a5)
    1516:	a029                	j	1520 <schedule_lst+0x90>
    1518:	800007b7          	lui	a5,0x80000
    151c:	fff7c793          	not	a5,a5
    1520:	873e                	mv	a4,a5
    1522:	87b6                	mv	a5,a3
    1524:	00e7da63          	bge	a5,a4,1538 <schedule_lst+0xa8>
            min_slack_thread = t;
    1528:	fb843783          	ld	a5,-72(s0)
    152c:	fcf43423          	sd	a5,-56(s0)
            min_slack_time = slack_time;
    1530:	f5442783          	lw	a5,-172(s0)
    1534:	fcf42223          	sw	a5,-60(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    1538:	fb843783          	ld	a5,-72(s0)
    153c:	779c                	ld	a5,40(a5)
    153e:	f4f43423          	sd	a5,-184(s0)
    1542:	f4843783          	ld	a5,-184(s0)
    1546:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffdc40>
    154a:	faf43c23          	sd	a5,-72(s0)
    154e:	fb843783          	ld	a5,-72(s0)
    1552:	02878713          	addi	a4,a5,40
    1556:	649c                	ld	a5,8(s1)
    1558:	f6f717e3          	bne	a4,a5,14c6 <schedule_lst+0x36>
        }
    }
    //printf("id %d, cur ddl %d, ddl,cur time %d, rem time %d, slack time %d\n", min_slack_thread->ID, min_slack_thread->current_deadline, args.current_time, min_slack_thread->remaining_time, min_slack_time);

    // Calculate the next event time, initially very large
    int next_significant_event_time = INT_MAX;
    155c:	800007b7          	lui	a5,0x80000
    1560:	fff7c793          	not	a5,a5
    1564:	faf42a23          	sw	a5,-76(s0)
    // Analyze each upcoming release to determine if and when they should preempt the current thread
    struct release_queue_entry *entry;
    list_for_each_entry(entry, args.release_queue, thread_list) {
    1568:	689c                	ld	a5,16(s1)
    156a:	639c                	ld	a5,0(a5)
    156c:	f8f43423          	sd	a5,-120(s0)
    1570:	f8843783          	ld	a5,-120(s0)
    1574:	17e1                	addi	a5,a5,-8
    1576:	faf43423          	sd	a5,-88(s0)
    157a:	a0f1                	j	1646 <schedule_lst+0x1b6>
        if (entry->release_time > args.current_time) {
    157c:	fa843783          	ld	a5,-88(s0)
    1580:	4f98                	lw	a4,24(a5)
    1582:	409c                	lw	a5,0(s1)
    1584:	0ae7d763          	bge	a5,a4,1632 <schedule_lst+0x1a2>
            struct thread *upcoming_thread = entry->thrd;
    1588:	fa843783          	ld	a5,-88(s0)
    158c:	639c                	ld	a5,0(a5)
    158e:	f6f43423          	sd	a5,-152(s0)

            //printf("upcoming_thread->ID: %d ddl: %d release_time: %d remaining_time: %d\n", upcoming_thread->ID, upcoming_thread->current_deadline, entry->release_time, upcoming_thread->remaining_time);
            int upcoming_slack_time = upcoming_thread->current_deadline - entry->release_time - upcoming_thread->processing_time;
    1592:	f6843783          	ld	a5,-152(s0)
    1596:	4ff8                	lw	a4,92(a5)
    1598:	fa843783          	ld	a5,-88(s0)
    159c:	4f9c                	lw	a5,24(a5)
    159e:	40f707bb          	subw	a5,a4,a5
    15a2:	0007871b          	sext.w	a4,a5
    15a6:	f6843783          	ld	a5,-152(s0)
    15aa:	43fc                	lw	a5,68(a5)
    15ac:	40f707bb          	subw	a5,a4,a5
    15b0:	f6f42223          	sw	a5,-156(s0)
            // Check if this upcoming thread will impose an earlier preemption due to tighter slack time
            if (upcoming_slack_time < min_slack_time) {
    15b4:	f6442703          	lw	a4,-156(s0)
    15b8:	fc442783          	lw	a5,-60(s0)
    15bc:	2701                	sext.w	a4,a4
    15be:	2781                	sext.w	a5,a5
    15c0:	02f75163          	bge	a4,a5,15e2 <schedule_lst+0x152>
                next_significant_event_time = min(next_significant_event_time, entry->release_time);
    15c4:	fa843783          	ld	a5,-88(s0)
    15c8:	4f98                	lw	a4,24(a5)
    15ca:	fb442783          	lw	a5,-76(s0)
    15ce:	85ba                	mv	a1,a4
    15d0:	853e                	mv	a0,a5
    15d2:	00000097          	auipc	ra,0x0
    15d6:	e8a080e7          	jalr	-374(ra) # 145c <min>
    15da:	87aa                	mv	a5,a0
    15dc:	faf42a23          	sw	a5,-76(s0)
    15e0:	a889                	j	1632 <schedule_lst+0x1a2>
            } else if (upcoming_slack_time == min_slack_time && upcoming_thread->ID < (min_slack_thread ? min_slack_thread->ID : INT_MAX))
    15e2:	f6442703          	lw	a4,-156(s0)
    15e6:	fc442783          	lw	a5,-60(s0)
    15ea:	2701                	sext.w	a4,a4
    15ec:	2781                	sext.w	a5,a5
    15ee:	04f71263          	bne	a4,a5,1632 <schedule_lst+0x1a2>
    15f2:	f6843783          	ld	a5,-152(s0)
    15f6:	5fd4                	lw	a3,60(a5)
    15f8:	fc843783          	ld	a5,-56(s0)
    15fc:	c789                	beqz	a5,1606 <schedule_lst+0x176>
    15fe:	fc843783          	ld	a5,-56(s0)
    1602:	5fdc                	lw	a5,60(a5)
    1604:	a029                	j	160e <schedule_lst+0x17e>
    1606:	800007b7          	lui	a5,0x80000
    160a:	fff7c793          	not	a5,a5
    160e:	873e                	mv	a4,a5
    1610:	87b6                	mv	a5,a3
    1612:	02e7d063          	bge	a5,a4,1632 <schedule_lst+0x1a2>
                next_significant_event_time = min(next_significant_event_time, entry->release_time);
    1616:	fa843783          	ld	a5,-88(s0)
    161a:	4f98                	lw	a4,24(a5)
    161c:	fb442783          	lw	a5,-76(s0)
    1620:	85ba                	mv	a1,a4
    1622:	853e                	mv	a0,a5
    1624:	00000097          	auipc	ra,0x0
    1628:	e38080e7          	jalr	-456(ra) # 145c <min>
    162c:	87aa                	mv	a5,a0
    162e:	faf42a23          	sw	a5,-76(s0)
    list_for_each_entry(entry, args.release_queue, thread_list) {
    1632:	fa843783          	ld	a5,-88(s0)
    1636:	679c                	ld	a5,8(a5)
    1638:	f4f43c23          	sd	a5,-168(s0)
    163c:	f5843783          	ld	a5,-168(s0)
    1640:	17e1                	addi	a5,a5,-8
    1642:	faf43423          	sd	a5,-88(s0)
    1646:	fa843783          	ld	a5,-88(s0)
    164a:	00878713          	addi	a4,a5,8 # ffffffff80000008 <__global_pointer$+0xffffffff7fffdc70>
    164e:	689c                	ld	a5,16(s1)
    1650:	f2f716e3          	bne	a4,a5,157c <schedule_lst+0xec>
        }
    }

    // Decide the allocated time based on current minimum slack or upcoming preemption needs
    if (min_slack_thread) {
    1654:	fc843783          	ld	a5,-56(s0)
    1658:	10078b63          	beqz	a5,176e <schedule_lst+0x2de>
        // Check if the thread has missed its deadline
        if (args.current_time >= min_slack_thread->current_deadline && min_slack_thread->remaining_time > 0) {
    165c:	4098                	lw	a4,0(s1)
    165e:	fc843783          	ld	a5,-56(s0)
    1662:	4ffc                	lw	a5,92(a5)
    1664:	08f74863          	blt	a4,a5,16f4 <schedule_lst+0x264>
    1668:	fc843783          	ld	a5,-56(s0)
    166c:	4fbc                	lw	a5,88(a5)
    166e:	08f05363          	blez	a5,16f4 <schedule_lst+0x264>
            struct thread *thread_with_smallest_id = min_slack_thread;
    1672:	fc843783          	ld	a5,-56(s0)
    1676:	faf43023          	sd	a5,-96(s0)
            // Iterate again to find if there are other threads that also missed their deadlines and have smaller IDs
            list_for_each_entry(t, args.run_queue, thread_list) {
    167a:	649c                	ld	a5,8(s1)
    167c:	639c                	ld	a5,0(a5)
    167e:	f8f43023          	sd	a5,-128(s0)
    1682:	f8043783          	ld	a5,-128(s0)
    1686:	fd878793          	addi	a5,a5,-40
    168a:	faf43c23          	sd	a5,-72(s0)
    168e:	a099                	j	16d4 <schedule_lst+0x244>
                if (args.current_time >= t->current_deadline && t->remaining_time > 0 && t->ID < thread_with_smallest_id->ID) {
    1690:	4098                	lw	a4,0(s1)
    1692:	fb843783          	ld	a5,-72(s0)
    1696:	4ffc                	lw	a5,92(a5)
    1698:	02f74363          	blt	a4,a5,16be <schedule_lst+0x22e>
    169c:	fb843783          	ld	a5,-72(s0)
    16a0:	4fbc                	lw	a5,88(a5)
    16a2:	00f05e63          	blez	a5,16be <schedule_lst+0x22e>
    16a6:	fb843783          	ld	a5,-72(s0)
    16aa:	5fd8                	lw	a4,60(a5)
    16ac:	fa043783          	ld	a5,-96(s0)
    16b0:	5fdc                	lw	a5,60(a5)
    16b2:	00f75663          	bge	a4,a5,16be <schedule_lst+0x22e>
                    thread_with_smallest_id = t;
    16b6:	fb843783          	ld	a5,-72(s0)
    16ba:	faf43023          	sd	a5,-96(s0)
            list_for_each_entry(t, args.run_queue, thread_list) {
    16be:	fb843783          	ld	a5,-72(s0)
    16c2:	779c                	ld	a5,40(a5)
    16c4:	f6f43c23          	sd	a5,-136(s0)
    16c8:	f7843783          	ld	a5,-136(s0)
    16cc:	fd878793          	addi	a5,a5,-40
    16d0:	faf43c23          	sd	a5,-72(s0)
    16d4:	fb843783          	ld	a5,-72(s0)
    16d8:	02878713          	addi	a4,a5,40
    16dc:	649c                	ld	a5,8(s1)
    16de:	faf719e3          	bne	a4,a5,1690 <schedule_lst+0x200>
                }
            }
            r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
    16e2:	fa043783          	ld	a5,-96(s0)
    16e6:	02878793          	addi	a5,a5,40
    16ea:	f2f43423          	sd	a5,-216(s0)
            r.allocated_time = 0;
    16ee:	f2042823          	sw	zero,-208(s0)
        if (args.current_time >= min_slack_thread->current_deadline && min_slack_thread->remaining_time > 0) {
    16f2:	a86d                	j	17ac <schedule_lst+0x31c>
        } else {
            // Calculate time until the thread's deadline
            int time_until_deadline = min_slack_thread->current_deadline - args.current_time;
    16f4:	fc843783          	ld	a5,-56(s0)
    16f8:	4ff8                	lw	a4,92(a5)
    16fa:	409c                	lw	a5,0(s1)
    16fc:	40f707bb          	subw	a5,a4,a5
    1700:	f6f42a23          	sw	a5,-140(s0)
            
            // Decide the allocated time based on current minimum slack or upcoming preemption needs
            int allocated_time = min(min_slack_thread->remaining_time, time_until_deadline);
    1704:	fc843783          	ld	a5,-56(s0)
    1708:	4fbc                	lw	a5,88(a5)
    170a:	f7442703          	lw	a4,-140(s0)
    170e:	85ba                	mv	a1,a4
    1710:	853e                	mv	a0,a5
    1712:	00000097          	auipc	ra,0x0
    1716:	d4a080e7          	jalr	-694(ra) # 145c <min>
    171a:	87aa                	mv	a5,a0
    171c:	f8f42e23          	sw	a5,-100(s0)
            if (next_significant_event_time != INT_MAX) {
    1720:	fb442783          	lw	a5,-76(s0)
    1724:	0007871b          	sext.w	a4,a5
    1728:	800007b7          	lui	a5,0x80000
    172c:	fff7c793          	not	a5,a5
    1730:	02f70463          	beq	a4,a5,1758 <schedule_lst+0x2c8>
                allocated_time = min(allocated_time, next_significant_event_time - args.current_time);
    1734:	409c                	lw	a5,0(s1)
    1736:	fb442703          	lw	a4,-76(s0)
    173a:	40f707bb          	subw	a5,a4,a5
    173e:	0007871b          	sext.w	a4,a5
    1742:	f9c42783          	lw	a5,-100(s0)
    1746:	85ba                	mv	a1,a4
    1748:	853e                	mv	a0,a5
    174a:	00000097          	auipc	ra,0x0
    174e:	d12080e7          	jalr	-750(ra) # 145c <min>
    1752:	87aa                	mv	a5,a0
    1754:	f8f42e23          	sw	a5,-100(s0)
            }

            r.scheduled_thread_list_member = &min_slack_thread->thread_list;
    1758:	fc843783          	ld	a5,-56(s0)
    175c:	02878793          	addi	a5,a5,40 # ffffffff80000028 <__global_pointer$+0xffffffff7fffdc90>
    1760:	f2f43423          	sd	a5,-216(s0)
            r.allocated_time = allocated_time;
    1764:	f9c42783          	lw	a5,-100(s0)
    1768:	f2f42823          	sw	a5,-208(s0)
    176c:	a081                	j	17ac <schedule_lst+0x31c>
        }
    } else {
        // No runnable threads, prepare to sleep or wait based on next known event
        r.scheduled_thread_list_member = args.run_queue;
    176e:	649c                	ld	a5,8(s1)
    1770:	f2f43423          	sd	a5,-216(s0)
        r.allocated_time = next_significant_event_time != INT_MAX ? next_significant_event_time - args.current_time : find_next_release_time(args.release_queue, args.current_time);
    1774:	fb442783          	lw	a5,-76(s0)
    1778:	0007871b          	sext.w	a4,a5
    177c:	800007b7          	lui	a5,0x80000
    1780:	fff7c793          	not	a5,a5
    1784:	00f70963          	beq	a4,a5,1796 <schedule_lst+0x306>
    1788:	409c                	lw	a5,0(s1)
    178a:	fb442703          	lw	a4,-76(s0)
    178e:	40f707bb          	subw	a5,a4,a5
    1792:	2781                	sext.w	a5,a5
    1794:	a811                	j	17a8 <schedule_lst+0x318>
    1796:	689c                	ld	a5,16(s1)
    1798:	4098                	lw	a4,0(s1)
    179a:	85ba                	mv	a1,a4
    179c:	853e                	mv	a0,a5
    179e:	00000097          	auipc	ra,0x0
    17a2:	820080e7          	jalr	-2016(ra) # fbe <find_next_release_time>
    17a6:	87aa                	mv	a5,a0
    17a8:	f2f42823          	sw	a5,-208(s0)
    }

    return r;
    17ac:	f2843783          	ld	a5,-216(s0)
    17b0:	f2f43c23          	sd	a5,-200(s0)
    17b4:	f3043783          	ld	a5,-208(s0)
    17b8:	f4f43023          	sd	a5,-192(s0)
    17bc:	4701                	li	a4,0
    17be:	f3843703          	ld	a4,-200(s0)
    17c2:	4781                	li	a5,0
    17c4:	f4043783          	ld	a5,-192(s0)
    17c8:	893a                	mv	s2,a4
    17ca:	89be                	mv	s3,a5
    17cc:	874a                	mv	a4,s2
    17ce:	87ce                	mv	a5,s3
}
    17d0:	853a                	mv	a0,a4
    17d2:	85be                	mv	a1,a5
    17d4:	60ee                	ld	ra,216(sp)
    17d6:	644e                	ld	s0,208(sp)
    17d8:	64ae                	ld	s1,200(sp)
    17da:	690e                	ld	s2,192(sp)
    17dc:	79ea                	ld	s3,184(sp)
    17de:	612d                	addi	sp,sp,224
    17e0:	8082                	ret

00000000000017e2 <find_earliest_impactful_release_time_dm>:
typedef struct {
    int earliest_impactful_event;
    struct thread *thread;
} ImpactfulEvent;

ImpactfulEvent find_earliest_impactful_release_time_dm(struct list_head *release_queue, struct list_head*run_queue, int current_time, int current_period, int current_thread_ID) {
    17e2:	7119                	addi	sp,sp,-128
    17e4:	fca2                	sd	s0,120(sp)
    17e6:	0100                	addi	s0,sp,128
    17e8:	f8a43c23          	sd	a0,-104(s0)
    17ec:	f8b43823          	sd	a1,-112(s0)
    17f0:	87b2                	mv	a5,a2
    17f2:	f8f42623          	sw	a5,-116(s0)
    17f6:	87b6                	mv	a5,a3
    17f8:	f8f42423          	sw	a5,-120(s0)
    17fc:	87ba                	mv	a5,a4
    17fe:	f8f42223          	sw	a5,-124(s0)
    struct release_queue_entry *entry;
    struct thread *t;
    int earliest_impactful_event = INT_MAX;
    1802:	800007b7          	lui	a5,0x80000
    1806:	fff7c793          	not	a5,a5
    180a:	fcf42e23          	sw	a5,-36(s0)
    int earliest_impactful_thread_ID = current_thread_ID;    
    180e:	f8442783          	lw	a5,-124(s0)
    1812:	fcf42c23          	sw	a5,-40(s0)
    
    // Look for the smallest deadline that is less than the current task's deadline
    list_for_each_entry(entry, release_queue, thread_list) {
    1816:	f9843783          	ld	a5,-104(s0)
    181a:	639c                	ld	a5,0(a5)
    181c:	fcf43823          	sd	a5,-48(s0)
    1820:	fd043783          	ld	a5,-48(s0)
    1824:	17e1                	addi	a5,a5,-8
    1826:	fef43423          	sd	a5,-24(s0)
    182a:	a0f9                	j	18f8 <find_earliest_impactful_release_time_dm+0x116>
        if (entry->release_time > current_time && entry->thrd->period < current_period) {
    182c:	fe843783          	ld	a5,-24(s0)
    1830:	4f98                	lw	a4,24(a5)
    1832:	f8c42783          	lw	a5,-116(s0)
    1836:	2781                	sext.w	a5,a5
    1838:	04e7d463          	bge	a5,a4,1880 <find_earliest_impactful_release_time_dm+0x9e>
    183c:	fe843783          	ld	a5,-24(s0)
    1840:	639c                	ld	a5,0(a5)
    1842:	4bb8                	lw	a4,80(a5)
    1844:	f8842783          	lw	a5,-120(s0)
    1848:	2781                	sext.w	a5,a5
    184a:	02f75b63          	bge	a4,a5,1880 <find_earliest_impactful_release_time_dm+0x9e>
            if (entry->release_time < earliest_impactful_event) {
    184e:	fe843783          	ld	a5,-24(s0)
    1852:	4f98                	lw	a4,24(a5)
    1854:	fdc42783          	lw	a5,-36(s0)
    1858:	2781                	sext.w	a5,a5
    185a:	08f75563          	bge	a4,a5,18e4 <find_earliest_impactful_release_time_dm+0x102>
                earliest_impactful_event = entry->release_time;
    185e:	fe843783          	ld	a5,-24(s0)
    1862:	4f9c                	lw	a5,24(a5)
    1864:	fcf42e23          	sw	a5,-36(s0)
                t = entry->thrd;
    1868:	fe843783          	ld	a5,-24(s0)
    186c:	639c                	ld	a5,0(a5)
    186e:	fef43023          	sd	a5,-32(s0)
                earliest_impactful_thread_ID = entry->thrd->ID;
    1872:	fe843783          	ld	a5,-24(s0)
    1876:	639c                	ld	a5,0(a5)
    1878:	5fdc                	lw	a5,60(a5)
    187a:	fcf42c23          	sw	a5,-40(s0)
            if (entry->release_time < earliest_impactful_event) {
    187e:	a09d                	j	18e4 <find_earliest_impactful_release_time_dm+0x102>
            }
        } 
        else if (entry->release_time > current_time && entry->thrd->period == current_period) {
    1880:	fe843783          	ld	a5,-24(s0)
    1884:	4f98                	lw	a4,24(a5)
    1886:	f8c42783          	lw	a5,-116(s0)
    188a:	2781                	sext.w	a5,a5
    188c:	04e7dc63          	bge	a5,a4,18e4 <find_earliest_impactful_release_time_dm+0x102>
    1890:	fe843783          	ld	a5,-24(s0)
    1894:	639c                	ld	a5,0(a5)
    1896:	4bb8                	lw	a4,80(a5)
    1898:	f8842783          	lw	a5,-120(s0)
    189c:	2781                	sext.w	a5,a5
    189e:	04e79363          	bne	a5,a4,18e4 <find_earliest_impactful_release_time_dm+0x102>
            //printf("ID %d, entry release time: %d\n", entry->thrd->ID, entry->release_time);
            // or the smallest deadline that is equal to the current task's deadline but has a smaller ID
            if (entry->release_time <= earliest_impactful_event && entry->thrd->ID < earliest_impactful_thread_ID) {
    18a2:	fe843783          	ld	a5,-24(s0)
    18a6:	4f98                	lw	a4,24(a5)
    18a8:	fdc42783          	lw	a5,-36(s0)
    18ac:	2781                	sext.w	a5,a5
    18ae:	02e7cb63          	blt	a5,a4,18e4 <find_earliest_impactful_release_time_dm+0x102>
    18b2:	fe843783          	ld	a5,-24(s0)
    18b6:	639c                	ld	a5,0(a5)
    18b8:	5fd8                	lw	a4,60(a5)
    18ba:	fd842783          	lw	a5,-40(s0)
    18be:	2781                	sext.w	a5,a5
    18c0:	02f75263          	bge	a4,a5,18e4 <find_earliest_impactful_release_time_dm+0x102>
                earliest_impactful_event = entry->release_time;
    18c4:	fe843783          	ld	a5,-24(s0)
    18c8:	4f9c                	lw	a5,24(a5)
    18ca:	fcf42e23          	sw	a5,-36(s0)
                t = entry->thrd;
    18ce:	fe843783          	ld	a5,-24(s0)
    18d2:	639c                	ld	a5,0(a5)
    18d4:	fef43023          	sd	a5,-32(s0)
                earliest_impactful_thread_ID = entry->thrd->ID;
    18d8:	fe843783          	ld	a5,-24(s0)
    18dc:	639c                	ld	a5,0(a5)
    18de:	5fdc                	lw	a5,60(a5)
    18e0:	fcf42c23          	sw	a5,-40(s0)
    list_for_each_entry(entry, release_queue, thread_list) {
    18e4:	fe843783          	ld	a5,-24(s0)
    18e8:	679c                	ld	a5,8(a5)
    18ea:	fcf43423          	sd	a5,-56(s0)
    18ee:	fc843783          	ld	a5,-56(s0)
    18f2:	17e1                	addi	a5,a5,-8
    18f4:	fef43423          	sd	a5,-24(s0)
    18f8:	fe843783          	ld	a5,-24(s0)
    18fc:	07a1                	addi	a5,a5,8
    18fe:	f9843703          	ld	a4,-104(s0)
    1902:	f2f715e3          	bne	a4,a5,182c <find_earliest_impactful_release_time_dm+0x4a>
            }
        }
    }
    //printf("earliest_impactful_event: %d\n", earliest_impactful_event);
    // If a task is found that might preempt the current task, determine when it will happen
    earliest_impactful_event = earliest_impactful_event == INT_MAX ? -1 : earliest_impactful_event;
    1906:	fdc42783          	lw	a5,-36(s0)
    190a:	0007871b          	sext.w	a4,a5
    190e:	800007b7          	lui	a5,0x80000
    1912:	fff7c793          	not	a5,a5
    1916:	00f70563          	beq	a4,a5,1920 <find_earliest_impactful_release_time_dm+0x13e>
    191a:	fdc42783          	lw	a5,-36(s0)
    191e:	a011                	j	1922 <find_earliest_impactful_release_time_dm+0x140>
    1920:	57fd                	li	a5,-1
    1922:	fcf42e23          	sw	a5,-36(s0)
    return (ImpactfulEvent) {earliest_impactful_event, t};
    1926:	fdc42783          	lw	a5,-36(s0)
    192a:	faf42c23          	sw	a5,-72(s0)
    192e:	fe043783          	ld	a5,-32(s0)
    1932:	fcf43023          	sd	a5,-64(s0)
    1936:	4701                	li	a4,0
    1938:	fb843703          	ld	a4,-72(s0)
    193c:	4781                	li	a5,0
    193e:	fc043783          	ld	a5,-64(s0)
    1942:	883a                	mv	a6,a4
    1944:	88be                	mv	a7,a5
    1946:	8742                	mv	a4,a6
    1948:	87c6                	mv	a5,a7
}
    194a:	853a                	mv	a0,a4
    194c:	85be                	mv	a1,a5
    194e:	7466                	ld	s0,120(sp)
    1950:	6109                	addi	sp,sp,128
    1952:	8082                	ret

0000000000001954 <schedule_dm>:


struct threads_sched_result schedule_dm(struct threads_sched_args args) {
    1954:	7135                	addi	sp,sp,-160
    1956:	ed06                	sd	ra,152(sp)
    1958:	e922                	sd	s0,144(sp)
    195a:	e526                	sd	s1,136(sp)
    195c:	e14a                	sd	s2,128(sp)
    195e:	fcce                	sd	s3,120(sp)
    1960:	1100                	addi	s0,sp,160
    1962:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *earliest_deadline_thread = NULL;
    1964:	fc043423          	sd	zero,-56(s0)
    struct thread *t;
    int earliest_deadline = INT_MAX;
    1968:	800007b7          	lui	a5,0x80000
    196c:	fff7c793          	not	a5,a5
    1970:	faf42e23          	sw	a5,-68(s0)
    int earliest_impactful_deadline; 
    
    // Determine the earliest deadline among current tasks
    list_for_each_entry(t, args.run_queue, thread_list) {
    1974:	649c                	ld	a5,8(s1)
    1976:	639c                	ld	a5,0(a5)
    1978:	faf43823          	sd	a5,-80(s0)
    197c:	fb043783          	ld	a5,-80(s0)
    1980:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffdc40>
    1984:	fcf43023          	sd	a5,-64(s0)
    1988:	a8bd                	j	1a06 <schedule_dm+0xb2>
        if (t->is_real_time && t->period < earliest_deadline) {
    198a:	fc043783          	ld	a5,-64(s0)
    198e:	43bc                	lw	a5,64(a5)
    1990:	c39d                	beqz	a5,19b6 <schedule_dm+0x62>
    1992:	fc043783          	ld	a5,-64(s0)
    1996:	4bb8                	lw	a4,80(a5)
    1998:	fbc42783          	lw	a5,-68(s0)
    199c:	2781                	sext.w	a5,a5
    199e:	00f75c63          	bge	a4,a5,19b6 <schedule_dm+0x62>
            earliest_deadline_thread = t;
    19a2:	fc043783          	ld	a5,-64(s0)
    19a6:	fcf43423          	sd	a5,-56(s0)
            earliest_deadline = t->period;
    19aa:	fc043783          	ld	a5,-64(s0)
    19ae:	4bbc                	lw	a5,80(a5)
    19b0:	faf42e23          	sw	a5,-68(s0)
    19b4:	a835                	j	19f0 <schedule_dm+0x9c>
        } else if (t->is_real_time && t->period == earliest_deadline && t->ID < earliest_deadline_thread->ID) {
    19b6:	fc043783          	ld	a5,-64(s0)
    19ba:	43bc                	lw	a5,64(a5)
    19bc:	cb95                	beqz	a5,19f0 <schedule_dm+0x9c>
    19be:	fc043783          	ld	a5,-64(s0)
    19c2:	4bb8                	lw	a4,80(a5)
    19c4:	fbc42783          	lw	a5,-68(s0)
    19c8:	2781                	sext.w	a5,a5
    19ca:	02e79363          	bne	a5,a4,19f0 <schedule_dm+0x9c>
    19ce:	fc043783          	ld	a5,-64(s0)
    19d2:	5fd8                	lw	a4,60(a5)
    19d4:	fc843783          	ld	a5,-56(s0)
    19d8:	5fdc                	lw	a5,60(a5)
    19da:	00f75b63          	bge	a4,a5,19f0 <schedule_dm+0x9c>
            earliest_deadline_thread = t;
    19de:	fc043783          	ld	a5,-64(s0)
    19e2:	fcf43423          	sd	a5,-56(s0)
            earliest_deadline = t->period;
    19e6:	fc043783          	ld	a5,-64(s0)
    19ea:	4bbc                	lw	a5,80(a5)
    19ec:	faf42e23          	sw	a5,-68(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    19f0:	fc043783          	ld	a5,-64(s0)
    19f4:	779c                	ld	a5,40(a5)
    19f6:	f8f43c23          	sd	a5,-104(s0)
    19fa:	f9843783          	ld	a5,-104(s0)
    19fe:	fd878793          	addi	a5,a5,-40
    1a02:	fcf43023          	sd	a5,-64(s0)
    1a06:	fc043783          	ld	a5,-64(s0)
    1a0a:	02878713          	addi	a4,a5,40
    1a0e:	649c                	ld	a5,8(s1)
    1a10:	f6f71de3          	bne	a4,a5,198a <schedule_dm+0x36>
        }
    }

    // Find the earliest impactful deadline from other tasks
    ImpactfulEvent earliest_impactful_event = find_earliest_impactful_release_time_dm(args.release_queue, args.run_queue, args.current_time, earliest_deadline_thread ? earliest_deadline_thread->period : INT_MAX, earliest_deadline_thread->ID);
    1a14:	6888                	ld	a0,16(s1)
    1a16:	648c                	ld	a1,8(s1)
    1a18:	4090                	lw	a2,0(s1)
    1a1a:	fc843783          	ld	a5,-56(s0)
    1a1e:	c789                	beqz	a5,1a28 <schedule_dm+0xd4>
    1a20:	fc843783          	ld	a5,-56(s0)
    1a24:	4bbc                	lw	a5,80(a5)
    1a26:	a029                	j	1a30 <schedule_dm+0xdc>
    1a28:	800007b7          	lui	a5,0x80000
    1a2c:	fff7c793          	not	a5,a5
    1a30:	fc843703          	ld	a4,-56(s0)
    1a34:	5f58                	lw	a4,60(a4)
    1a36:	86be                	mv	a3,a5
    1a38:	00000097          	auipc	ra,0x0
    1a3c:	daa080e7          	jalr	-598(ra) # 17e2 <find_earliest_impactful_release_time_dm>
    1a40:	872a                	mv	a4,a0
    1a42:	87ae                	mv	a5,a1
    1a44:	f6e43423          	sd	a4,-152(s0)
    1a48:	f6f43823          	sd	a5,-144(s0)
    earliest_impactful_deadline = earliest_impactful_event.earliest_impactful_event;
    1a4c:	f6842783          	lw	a5,-152(s0)
    1a50:	faf42623          	sw	a5,-84(s0)
    //printf("earliest_impactful_deadline: %d\n", earliest_impactful_deadline);
    if (earliest_deadline_thread) {
    1a54:	fc843783          	ld	a5,-56(s0)
    1a58:	cfd9                	beqz	a5,1af6 <schedule_dm+0x1a2>
        int time_to_deadline = earliest_deadline_thread->current_deadline - args.current_time;
    1a5a:	fc843783          	ld	a5,-56(s0)
    1a5e:	4ff8                	lw	a4,92(a5)
    1a60:	409c                	lw	a5,0(s1)
    1a62:	40f707bb          	subw	a5,a4,a5
    1a66:	faf42423          	sw	a5,-88(s0)
        
        // If the thread is already past its deadline, allocate no time (handle deadline miss)
        if (time_to_deadline <= 0) {
    1a6a:	fa842783          	lw	a5,-88(s0)
    1a6e:	2781                	sext.w	a5,a5
    1a70:	00f04b63          	bgtz	a5,1a86 <schedule_dm+0x132>
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    1a74:	fc843783          	ld	a5,-56(s0)
    1a78:	02878793          	addi	a5,a5,40 # ffffffff80000028 <__global_pointer$+0xffffffff7fffdc90>
    1a7c:	f6f43c23          	sd	a5,-136(s0)
            r.allocated_time = 0;
    1a80:	f8042023          	sw	zero,-128(s0)
    1a84:	a079                	j	1b12 <schedule_dm+0x1be>
        } else {
            // Allocate time based on the smallest of the task's remaining time or the next impactful deadline
            int remaining_time = min(earliest_deadline_thread->remaining_time, time_to_deadline);
    1a86:	fc843783          	ld	a5,-56(s0)
    1a8a:	4fbc                	lw	a5,88(a5)
    1a8c:	fa842703          	lw	a4,-88(s0)
    1a90:	85ba                	mv	a1,a4
    1a92:	853e                	mv	a0,a5
    1a94:	00000097          	auipc	ra,0x0
    1a98:	9c8080e7          	jalr	-1592(ra) # 145c <min>
    1a9c:	87aa                	mv	a5,a0
    1a9e:	faf42223          	sw	a5,-92(s0)
            int allocated_time;
            if (earliest_impactful_deadline != -1 && (earliest_impactful_deadline - args.current_time) < remaining_time){
    1aa2:	fac42783          	lw	a5,-84(s0)
    1aa6:	0007871b          	sext.w	a4,a5
    1aaa:	57fd                	li	a5,-1
    1aac:	02f70663          	beq	a4,a5,1ad8 <schedule_dm+0x184>
    1ab0:	409c                	lw	a5,0(s1)
    1ab2:	fac42703          	lw	a4,-84(s0)
    1ab6:	40f707bb          	subw	a5,a4,a5
    1aba:	0007871b          	sext.w	a4,a5
    1abe:	fa442783          	lw	a5,-92(s0)
    1ac2:	2781                	sext.w	a5,a5
    1ac4:	00f75a63          	bge	a4,a5,1ad8 <schedule_dm+0x184>
                allocated_time = earliest_impactful_deadline - args.current_time;
    1ac8:	409c                	lw	a5,0(s1)
    1aca:	fac42703          	lw	a4,-84(s0)
    1ace:	40f707bb          	subw	a5,a4,a5
    1ad2:	faf42c23          	sw	a5,-72(s0)
    1ad6:	a029                	j	1ae0 <schedule_dm+0x18c>
            } else {
                allocated_time = remaining_time;
    1ad8:	fa442783          	lw	a5,-92(s0)
    1adc:	faf42c23          	sw	a5,-72(s0)
            }
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    1ae0:	fc843783          	ld	a5,-56(s0)
    1ae4:	02878793          	addi	a5,a5,40
    1ae8:	f6f43c23          	sd	a5,-136(s0)
            r.allocated_time = allocated_time;
    1aec:	fb842783          	lw	a5,-72(s0)
    1af0:	f8f42023          	sw	a5,-128(s0)
    1af4:	a839                	j	1b12 <schedule_dm+0x1be>
        }
    } else {
        // If no immediate tasks, schedule the next possible task
        r.scheduled_thread_list_member = args.run_queue;
    1af6:	649c                	ld	a5,8(s1)
    1af8:	f6f43c23          	sd	a5,-136(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    1afc:	689c                	ld	a5,16(s1)
    1afe:	4098                	lw	a4,0(s1)
    1b00:	85ba                	mv	a1,a4
    1b02:	853e                	mv	a0,a5
    1b04:	fffff097          	auipc	ra,0xfffff
    1b08:	4ba080e7          	jalr	1210(ra) # fbe <find_next_release_time>
    1b0c:	87aa                	mv	a5,a0
    1b0e:	f8f42023          	sw	a5,-128(s0)
    }

    return r;
    1b12:	f7843783          	ld	a5,-136(s0)
    1b16:	f8f43423          	sd	a5,-120(s0)
    1b1a:	f8043783          	ld	a5,-128(s0)
    1b1e:	f8f43823          	sd	a5,-112(s0)
    1b22:	4701                	li	a4,0
    1b24:	f8843703          	ld	a4,-120(s0)
    1b28:	4781                	li	a5,0
    1b2a:	f9043783          	ld	a5,-112(s0)
    1b2e:	893a                	mv	s2,a4
    1b30:	89be                	mv	s3,a5
    1b32:	874a                	mv	a4,s2
    1b34:	87ce                	mv	a5,s3
}
    1b36:	853a                	mv	a0,a4
    1b38:	85be                	mv	a1,a5
    1b3a:	60ea                	ld	ra,152(sp)
    1b3c:	644a                	ld	s0,144(sp)
    1b3e:	64aa                	ld	s1,136(sp)
    1b40:	690a                	ld	s2,128(sp)
    1b42:	79e6                	ld	s3,120(sp)
    1b44:	610d                	addi	sp,sp,160
    1b46:	8082                	ret
