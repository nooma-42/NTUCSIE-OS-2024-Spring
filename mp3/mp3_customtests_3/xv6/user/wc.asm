
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
       0:	7139                	addi	sp,sp,-64
       2:	fc06                	sd	ra,56(sp)
       4:	f822                	sd	s0,48(sp)
       6:	0080                	addi	s0,sp,64
       8:	87aa                	mv	a5,a0
       a:	fcb43023          	sd	a1,-64(s0)
       e:	fcf42623          	sw	a5,-52(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
      12:	fe042023          	sw	zero,-32(s0)
      16:	fe042783          	lw	a5,-32(s0)
      1a:	fef42223          	sw	a5,-28(s0)
      1e:	fe442783          	lw	a5,-28(s0)
      22:	fef42423          	sw	a5,-24(s0)
  inword = 0;
      26:	fc042e23          	sw	zero,-36(s0)
  while((n = read(fd, buf, sizeof(buf))) > 0){
      2a:	a859                	j	c0 <wc+0xc0>
    for(i=0; i<n; i++){
      2c:	fe042623          	sw	zero,-20(s0)
      30:	a041                	j	b0 <wc+0xb0>
      c++;
      32:	fe042783          	lw	a5,-32(s0)
      36:	2785                	addiw	a5,a5,1
      38:	fef42023          	sw	a5,-32(s0)
      if(buf[i] == '\n')
      3c:	00002717          	auipc	a4,0x2
      40:	b8470713          	addi	a4,a4,-1148 # 1bc0 <buf>
      44:	fec42783          	lw	a5,-20(s0)
      48:	97ba                	add	a5,a5,a4
      4a:	0007c783          	lbu	a5,0(a5)
      4e:	873e                	mv	a4,a5
      50:	47a9                	li	a5,10
      52:	00f71763          	bne	a4,a5,60 <wc+0x60>
        l++;
      56:	fe842783          	lw	a5,-24(s0)
      5a:	2785                	addiw	a5,a5,1
      5c:	fef42423          	sw	a5,-24(s0)
      if(strchr(" \r\t\n\v", buf[i]))
      60:	00002717          	auipc	a4,0x2
      64:	b6070713          	addi	a4,a4,-1184 # 1bc0 <buf>
      68:	fec42783          	lw	a5,-20(s0)
      6c:	97ba                	add	a5,a5,a4
      6e:	0007c783          	lbu	a5,0(a5)
      72:	85be                	mv	a1,a5
      74:	00002517          	auipc	a0,0x2
      78:	ae450513          	addi	a0,a0,-1308 # 1b58 <schedule_dm+0x1d8>
      7c:	00000097          	auipc	ra,0x0
      80:	2ec080e7          	jalr	748(ra) # 368 <strchr>
      84:	87aa                	mv	a5,a0
      86:	c781                	beqz	a5,8e <wc+0x8e>
        inword = 0;
      88:	fc042e23          	sw	zero,-36(s0)
      8c:	a829                	j	a6 <wc+0xa6>
      else if(!inword){
      8e:	fdc42783          	lw	a5,-36(s0)
      92:	2781                	sext.w	a5,a5
      94:	eb89                	bnez	a5,a6 <wc+0xa6>
        w++;
      96:	fe442783          	lw	a5,-28(s0)
      9a:	2785                	addiw	a5,a5,1
      9c:	fef42223          	sw	a5,-28(s0)
        inword = 1;
      a0:	4785                	li	a5,1
      a2:	fcf42e23          	sw	a5,-36(s0)
    for(i=0; i<n; i++){
      a6:	fec42783          	lw	a5,-20(s0)
      aa:	2785                	addiw	a5,a5,1
      ac:	fef42623          	sw	a5,-20(s0)
      b0:	fec42703          	lw	a4,-20(s0)
      b4:	fd842783          	lw	a5,-40(s0)
      b8:	2701                	sext.w	a4,a4
      ba:	2781                	sext.w	a5,a5
      bc:	f6f74be3          	blt	a4,a5,32 <wc+0x32>
  while((n = read(fd, buf, sizeof(buf))) > 0){
      c0:	fcc42783          	lw	a5,-52(s0)
      c4:	20000613          	li	a2,512
      c8:	00002597          	auipc	a1,0x2
      cc:	af858593          	addi	a1,a1,-1288 # 1bc0 <buf>
      d0:	853e                	mv	a0,a5
      d2:	00000097          	auipc	ra,0x0
      d6:	5f8080e7          	jalr	1528(ra) # 6ca <read>
      da:	87aa                	mv	a5,a0
      dc:	fcf42c23          	sw	a5,-40(s0)
      e0:	fd842783          	lw	a5,-40(s0)
      e4:	2781                	sext.w	a5,a5
      e6:	f4f043e3          	bgtz	a5,2c <wc+0x2c>
      }
    }
  }
  if(n < 0){
      ea:	fd842783          	lw	a5,-40(s0)
      ee:	2781                	sext.w	a5,a5
      f0:	0007df63          	bgez	a5,10e <wc+0x10e>
    printf("wc: read error\n");
      f4:	00002517          	auipc	a0,0x2
      f8:	a6c50513          	addi	a0,a0,-1428 # 1b60 <schedule_dm+0x1e0>
      fc:	00001097          	auipc	ra,0x1
     100:	afc080e7          	jalr	-1284(ra) # bf8 <printf>
    exit(1);
     104:	4505                	li	a0,1
     106:	00000097          	auipc	ra,0x0
     10a:	5ac080e7          	jalr	1452(ra) # 6b2 <exit>
  }
  printf("%d %d %d %s\n", l, w, c, name);
     10e:	fe042683          	lw	a3,-32(s0)
     112:	fe442603          	lw	a2,-28(s0)
     116:	fe842783          	lw	a5,-24(s0)
     11a:	fc043703          	ld	a4,-64(s0)
     11e:	85be                	mv	a1,a5
     120:	00002517          	auipc	a0,0x2
     124:	a5050513          	addi	a0,a0,-1456 # 1b70 <schedule_dm+0x1f0>
     128:	00001097          	auipc	ra,0x1
     12c:	ad0080e7          	jalr	-1328(ra) # bf8 <printf>
}
     130:	0001                	nop
     132:	70e2                	ld	ra,56(sp)
     134:	7442                	ld	s0,48(sp)
     136:	6121                	addi	sp,sp,64
     138:	8082                	ret

000000000000013a <main>:

int
main(int argc, char *argv[])
{
     13a:	7179                	addi	sp,sp,-48
     13c:	f406                	sd	ra,40(sp)
     13e:	f022                	sd	s0,32(sp)
     140:	1800                	addi	s0,sp,48
     142:	87aa                	mv	a5,a0
     144:	fcb43823          	sd	a1,-48(s0)
     148:	fcf42e23          	sw	a5,-36(s0)
  int fd, i;

  if(argc <= 1){
     14c:	fdc42783          	lw	a5,-36(s0)
     150:	0007871b          	sext.w	a4,a5
     154:	4785                	li	a5,1
     156:	02e7c063          	blt	a5,a4,176 <main+0x3c>
    wc(0, "");
     15a:	00002597          	auipc	a1,0x2
     15e:	a2658593          	addi	a1,a1,-1498 # 1b80 <schedule_dm+0x200>
     162:	4501                	li	a0,0
     164:	00000097          	auipc	ra,0x0
     168:	e9c080e7          	jalr	-356(ra) # 0 <wc>
    exit(0);
     16c:	4501                	li	a0,0
     16e:	00000097          	auipc	ra,0x0
     172:	544080e7          	jalr	1348(ra) # 6b2 <exit>
  }

  for(i = 1; i < argc; i++){
     176:	4785                	li	a5,1
     178:	fef42623          	sw	a5,-20(s0)
     17c:	a071                	j	208 <main+0xce>
    if((fd = open(argv[i], 0)) < 0){
     17e:	fec42783          	lw	a5,-20(s0)
     182:	078e                	slli	a5,a5,0x3
     184:	fd043703          	ld	a4,-48(s0)
     188:	97ba                	add	a5,a5,a4
     18a:	639c                	ld	a5,0(a5)
     18c:	4581                	li	a1,0
     18e:	853e                	mv	a0,a5
     190:	00000097          	auipc	ra,0x0
     194:	562080e7          	jalr	1378(ra) # 6f2 <open>
     198:	87aa                	mv	a5,a0
     19a:	fef42423          	sw	a5,-24(s0)
     19e:	fe842783          	lw	a5,-24(s0)
     1a2:	2781                	sext.w	a5,a5
     1a4:	0207d763          	bgez	a5,1d2 <main+0x98>
      printf("wc: cannot open %s\n", argv[i]);
     1a8:	fec42783          	lw	a5,-20(s0)
     1ac:	078e                	slli	a5,a5,0x3
     1ae:	fd043703          	ld	a4,-48(s0)
     1b2:	97ba                	add	a5,a5,a4
     1b4:	639c                	ld	a5,0(a5)
     1b6:	85be                	mv	a1,a5
     1b8:	00002517          	auipc	a0,0x2
     1bc:	9d050513          	addi	a0,a0,-1584 # 1b88 <schedule_dm+0x208>
     1c0:	00001097          	auipc	ra,0x1
     1c4:	a38080e7          	jalr	-1480(ra) # bf8 <printf>
      exit(1);
     1c8:	4505                	li	a0,1
     1ca:	00000097          	auipc	ra,0x0
     1ce:	4e8080e7          	jalr	1256(ra) # 6b2 <exit>
    }
    wc(fd, argv[i]);
     1d2:	fec42783          	lw	a5,-20(s0)
     1d6:	078e                	slli	a5,a5,0x3
     1d8:	fd043703          	ld	a4,-48(s0)
     1dc:	97ba                	add	a5,a5,a4
     1de:	6398                	ld	a4,0(a5)
     1e0:	fe842783          	lw	a5,-24(s0)
     1e4:	85ba                	mv	a1,a4
     1e6:	853e                	mv	a0,a5
     1e8:	00000097          	auipc	ra,0x0
     1ec:	e18080e7          	jalr	-488(ra) # 0 <wc>
    close(fd);
     1f0:	fe842783          	lw	a5,-24(s0)
     1f4:	853e                	mv	a0,a5
     1f6:	00000097          	auipc	ra,0x0
     1fa:	4e4080e7          	jalr	1252(ra) # 6da <close>
  for(i = 1; i < argc; i++){
     1fe:	fec42783          	lw	a5,-20(s0)
     202:	2785                	addiw	a5,a5,1
     204:	fef42623          	sw	a5,-20(s0)
     208:	fec42703          	lw	a4,-20(s0)
     20c:	fdc42783          	lw	a5,-36(s0)
     210:	2701                	sext.w	a4,a4
     212:	2781                	sext.w	a5,a5
     214:	f6f745e3          	blt	a4,a5,17e <main+0x44>
  }
  exit(0);
     218:	4501                	li	a0,0
     21a:	00000097          	auipc	ra,0x0
     21e:	498080e7          	jalr	1176(ra) # 6b2 <exit>

0000000000000222 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     222:	7179                	addi	sp,sp,-48
     224:	f422                	sd	s0,40(sp)
     226:	1800                	addi	s0,sp,48
     228:	fca43c23          	sd	a0,-40(s0)
     22c:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     230:	fd843783          	ld	a5,-40(s0)
     234:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     238:	0001                	nop
     23a:	fd043703          	ld	a4,-48(s0)
     23e:	00170793          	addi	a5,a4,1
     242:	fcf43823          	sd	a5,-48(s0)
     246:	fd843783          	ld	a5,-40(s0)
     24a:	00178693          	addi	a3,a5,1
     24e:	fcd43c23          	sd	a3,-40(s0)
     252:	00074703          	lbu	a4,0(a4)
     256:	00e78023          	sb	a4,0(a5)
     25a:	0007c783          	lbu	a5,0(a5)
     25e:	fff1                	bnez	a5,23a <strcpy+0x18>
    ;
  return os;
     260:	fe843783          	ld	a5,-24(s0)
}
     264:	853e                	mv	a0,a5
     266:	7422                	ld	s0,40(sp)
     268:	6145                	addi	sp,sp,48
     26a:	8082                	ret

000000000000026c <strcmp>:

int
strcmp(const char *p, const char *q)
{
     26c:	1101                	addi	sp,sp,-32
     26e:	ec22                	sd	s0,24(sp)
     270:	1000                	addi	s0,sp,32
     272:	fea43423          	sd	a0,-24(s0)
     276:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     27a:	a819                	j	290 <strcmp+0x24>
    p++, q++;
     27c:	fe843783          	ld	a5,-24(s0)
     280:	0785                	addi	a5,a5,1
     282:	fef43423          	sd	a5,-24(s0)
     286:	fe043783          	ld	a5,-32(s0)
     28a:	0785                	addi	a5,a5,1
     28c:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     290:	fe843783          	ld	a5,-24(s0)
     294:	0007c783          	lbu	a5,0(a5)
     298:	cb99                	beqz	a5,2ae <strcmp+0x42>
     29a:	fe843783          	ld	a5,-24(s0)
     29e:	0007c703          	lbu	a4,0(a5)
     2a2:	fe043783          	ld	a5,-32(s0)
     2a6:	0007c783          	lbu	a5,0(a5)
     2aa:	fcf709e3          	beq	a4,a5,27c <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     2ae:	fe843783          	ld	a5,-24(s0)
     2b2:	0007c783          	lbu	a5,0(a5)
     2b6:	0007871b          	sext.w	a4,a5
     2ba:	fe043783          	ld	a5,-32(s0)
     2be:	0007c783          	lbu	a5,0(a5)
     2c2:	2781                	sext.w	a5,a5
     2c4:	40f707bb          	subw	a5,a4,a5
     2c8:	2781                	sext.w	a5,a5
}
     2ca:	853e                	mv	a0,a5
     2cc:	6462                	ld	s0,24(sp)
     2ce:	6105                	addi	sp,sp,32
     2d0:	8082                	ret

00000000000002d2 <strlen>:

uint
strlen(const char *s)
{
     2d2:	7179                	addi	sp,sp,-48
     2d4:	f422                	sd	s0,40(sp)
     2d6:	1800                	addi	s0,sp,48
     2d8:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     2dc:	fe042623          	sw	zero,-20(s0)
     2e0:	a031                	j	2ec <strlen+0x1a>
     2e2:	fec42783          	lw	a5,-20(s0)
     2e6:	2785                	addiw	a5,a5,1
     2e8:	fef42623          	sw	a5,-20(s0)
     2ec:	fec42783          	lw	a5,-20(s0)
     2f0:	fd843703          	ld	a4,-40(s0)
     2f4:	97ba                	add	a5,a5,a4
     2f6:	0007c783          	lbu	a5,0(a5)
     2fa:	f7e5                	bnez	a5,2e2 <strlen+0x10>
    ;
  return n;
     2fc:	fec42783          	lw	a5,-20(s0)
}
     300:	853e                	mv	a0,a5
     302:	7422                	ld	s0,40(sp)
     304:	6145                	addi	sp,sp,48
     306:	8082                	ret

0000000000000308 <memset>:

void*
memset(void *dst, int c, uint n)
{
     308:	7179                	addi	sp,sp,-48
     30a:	f422                	sd	s0,40(sp)
     30c:	1800                	addi	s0,sp,48
     30e:	fca43c23          	sd	a0,-40(s0)
     312:	87ae                	mv	a5,a1
     314:	8732                	mv	a4,a2
     316:	fcf42a23          	sw	a5,-44(s0)
     31a:	87ba                	mv	a5,a4
     31c:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     320:	fd843783          	ld	a5,-40(s0)
     324:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     328:	fe042623          	sw	zero,-20(s0)
     32c:	a00d                	j	34e <memset+0x46>
    cdst[i] = c;
     32e:	fec42783          	lw	a5,-20(s0)
     332:	fe043703          	ld	a4,-32(s0)
     336:	97ba                	add	a5,a5,a4
     338:	fd442703          	lw	a4,-44(s0)
     33c:	0ff77713          	andi	a4,a4,255
     340:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     344:	fec42783          	lw	a5,-20(s0)
     348:	2785                	addiw	a5,a5,1
     34a:	fef42623          	sw	a5,-20(s0)
     34e:	fec42703          	lw	a4,-20(s0)
     352:	fd042783          	lw	a5,-48(s0)
     356:	2781                	sext.w	a5,a5
     358:	fcf76be3          	bltu	a4,a5,32e <memset+0x26>
  }
  return dst;
     35c:	fd843783          	ld	a5,-40(s0)
}
     360:	853e                	mv	a0,a5
     362:	7422                	ld	s0,40(sp)
     364:	6145                	addi	sp,sp,48
     366:	8082                	ret

0000000000000368 <strchr>:

char*
strchr(const char *s, char c)
{
     368:	1101                	addi	sp,sp,-32
     36a:	ec22                	sd	s0,24(sp)
     36c:	1000                	addi	s0,sp,32
     36e:	fea43423          	sd	a0,-24(s0)
     372:	87ae                	mv	a5,a1
     374:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     378:	a01d                	j	39e <strchr+0x36>
    if(*s == c)
     37a:	fe843783          	ld	a5,-24(s0)
     37e:	0007c703          	lbu	a4,0(a5)
     382:	fe744783          	lbu	a5,-25(s0)
     386:	0ff7f793          	andi	a5,a5,255
     38a:	00e79563          	bne	a5,a4,394 <strchr+0x2c>
      return (char*)s;
     38e:	fe843783          	ld	a5,-24(s0)
     392:	a821                	j	3aa <strchr+0x42>
  for(; *s; s++)
     394:	fe843783          	ld	a5,-24(s0)
     398:	0785                	addi	a5,a5,1
     39a:	fef43423          	sd	a5,-24(s0)
     39e:	fe843783          	ld	a5,-24(s0)
     3a2:	0007c783          	lbu	a5,0(a5)
     3a6:	fbf1                	bnez	a5,37a <strchr+0x12>
  return 0;
     3a8:	4781                	li	a5,0
}
     3aa:	853e                	mv	a0,a5
     3ac:	6462                	ld	s0,24(sp)
     3ae:	6105                	addi	sp,sp,32
     3b0:	8082                	ret

00000000000003b2 <gets>:

char*
gets(char *buf, int max)
{
     3b2:	7179                	addi	sp,sp,-48
     3b4:	f406                	sd	ra,40(sp)
     3b6:	f022                	sd	s0,32(sp)
     3b8:	1800                	addi	s0,sp,48
     3ba:	fca43c23          	sd	a0,-40(s0)
     3be:	87ae                	mv	a5,a1
     3c0:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     3c4:	fe042623          	sw	zero,-20(s0)
     3c8:	a8a1                	j	420 <gets+0x6e>
    cc = read(0, &c, 1);
     3ca:	fe740793          	addi	a5,s0,-25
     3ce:	4605                	li	a2,1
     3d0:	85be                	mv	a1,a5
     3d2:	4501                	li	a0,0
     3d4:	00000097          	auipc	ra,0x0
     3d8:	2f6080e7          	jalr	758(ra) # 6ca <read>
     3dc:	87aa                	mv	a5,a0
     3de:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     3e2:	fe842783          	lw	a5,-24(s0)
     3e6:	2781                	sext.w	a5,a5
     3e8:	04f05763          	blez	a5,436 <gets+0x84>
      break;
    buf[i++] = c;
     3ec:	fec42783          	lw	a5,-20(s0)
     3f0:	0017871b          	addiw	a4,a5,1
     3f4:	fee42623          	sw	a4,-20(s0)
     3f8:	873e                	mv	a4,a5
     3fa:	fd843783          	ld	a5,-40(s0)
     3fe:	97ba                	add	a5,a5,a4
     400:	fe744703          	lbu	a4,-25(s0)
     404:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     408:	fe744783          	lbu	a5,-25(s0)
     40c:	873e                	mv	a4,a5
     40e:	47a9                	li	a5,10
     410:	02f70463          	beq	a4,a5,438 <gets+0x86>
     414:	fe744783          	lbu	a5,-25(s0)
     418:	873e                	mv	a4,a5
     41a:	47b5                	li	a5,13
     41c:	00f70e63          	beq	a4,a5,438 <gets+0x86>
  for(i=0; i+1 < max; ){
     420:	fec42783          	lw	a5,-20(s0)
     424:	2785                	addiw	a5,a5,1
     426:	0007871b          	sext.w	a4,a5
     42a:	fd442783          	lw	a5,-44(s0)
     42e:	2781                	sext.w	a5,a5
     430:	f8f74de3          	blt	a4,a5,3ca <gets+0x18>
     434:	a011                	j	438 <gets+0x86>
      break;
     436:	0001                	nop
      break;
  }
  buf[i] = '\0';
     438:	fec42783          	lw	a5,-20(s0)
     43c:	fd843703          	ld	a4,-40(s0)
     440:	97ba                	add	a5,a5,a4
     442:	00078023          	sb	zero,0(a5)
  return buf;
     446:	fd843783          	ld	a5,-40(s0)
}
     44a:	853e                	mv	a0,a5
     44c:	70a2                	ld	ra,40(sp)
     44e:	7402                	ld	s0,32(sp)
     450:	6145                	addi	sp,sp,48
     452:	8082                	ret

0000000000000454 <stat>:

int
stat(const char *n, struct stat *st)
{
     454:	7179                	addi	sp,sp,-48
     456:	f406                	sd	ra,40(sp)
     458:	f022                	sd	s0,32(sp)
     45a:	1800                	addi	s0,sp,48
     45c:	fca43c23          	sd	a0,-40(s0)
     460:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     464:	4581                	li	a1,0
     466:	fd843503          	ld	a0,-40(s0)
     46a:	00000097          	auipc	ra,0x0
     46e:	288080e7          	jalr	648(ra) # 6f2 <open>
     472:	87aa                	mv	a5,a0
     474:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     478:	fec42783          	lw	a5,-20(s0)
     47c:	2781                	sext.w	a5,a5
     47e:	0007d463          	bgez	a5,486 <stat+0x32>
    return -1;
     482:	57fd                	li	a5,-1
     484:	a035                	j	4b0 <stat+0x5c>
  r = fstat(fd, st);
     486:	fec42783          	lw	a5,-20(s0)
     48a:	fd043583          	ld	a1,-48(s0)
     48e:	853e                	mv	a0,a5
     490:	00000097          	auipc	ra,0x0
     494:	27a080e7          	jalr	634(ra) # 70a <fstat>
     498:	87aa                	mv	a5,a0
     49a:	fef42423          	sw	a5,-24(s0)
  close(fd);
     49e:	fec42783          	lw	a5,-20(s0)
     4a2:	853e                	mv	a0,a5
     4a4:	00000097          	auipc	ra,0x0
     4a8:	236080e7          	jalr	566(ra) # 6da <close>
  return r;
     4ac:	fe842783          	lw	a5,-24(s0)
}
     4b0:	853e                	mv	a0,a5
     4b2:	70a2                	ld	ra,40(sp)
     4b4:	7402                	ld	s0,32(sp)
     4b6:	6145                	addi	sp,sp,48
     4b8:	8082                	ret

00000000000004ba <atoi>:

int
atoi(const char *s)
{
     4ba:	7179                	addi	sp,sp,-48
     4bc:	f422                	sd	s0,40(sp)
     4be:	1800                	addi	s0,sp,48
     4c0:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     4c4:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     4c8:	a815                	j	4fc <atoi+0x42>
    n = n*10 + *s++ - '0';
     4ca:	fec42703          	lw	a4,-20(s0)
     4ce:	87ba                	mv	a5,a4
     4d0:	0027979b          	slliw	a5,a5,0x2
     4d4:	9fb9                	addw	a5,a5,a4
     4d6:	0017979b          	slliw	a5,a5,0x1
     4da:	0007871b          	sext.w	a4,a5
     4de:	fd843783          	ld	a5,-40(s0)
     4e2:	00178693          	addi	a3,a5,1
     4e6:	fcd43c23          	sd	a3,-40(s0)
     4ea:	0007c783          	lbu	a5,0(a5)
     4ee:	2781                	sext.w	a5,a5
     4f0:	9fb9                	addw	a5,a5,a4
     4f2:	2781                	sext.w	a5,a5
     4f4:	fd07879b          	addiw	a5,a5,-48
     4f8:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     4fc:	fd843783          	ld	a5,-40(s0)
     500:	0007c783          	lbu	a5,0(a5)
     504:	873e                	mv	a4,a5
     506:	02f00793          	li	a5,47
     50a:	00e7fb63          	bgeu	a5,a4,520 <atoi+0x66>
     50e:	fd843783          	ld	a5,-40(s0)
     512:	0007c783          	lbu	a5,0(a5)
     516:	873e                	mv	a4,a5
     518:	03900793          	li	a5,57
     51c:	fae7f7e3          	bgeu	a5,a4,4ca <atoi+0x10>
  return n;
     520:	fec42783          	lw	a5,-20(s0)
}
     524:	853e                	mv	a0,a5
     526:	7422                	ld	s0,40(sp)
     528:	6145                	addi	sp,sp,48
     52a:	8082                	ret

000000000000052c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     52c:	7139                	addi	sp,sp,-64
     52e:	fc22                	sd	s0,56(sp)
     530:	0080                	addi	s0,sp,64
     532:	fca43c23          	sd	a0,-40(s0)
     536:	fcb43823          	sd	a1,-48(s0)
     53a:	87b2                	mv	a5,a2
     53c:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     540:	fd843783          	ld	a5,-40(s0)
     544:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     548:	fd043783          	ld	a5,-48(s0)
     54c:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     550:	fe043703          	ld	a4,-32(s0)
     554:	fe843783          	ld	a5,-24(s0)
     558:	02e7fc63          	bgeu	a5,a4,590 <memmove+0x64>
    while(n-- > 0)
     55c:	a00d                	j	57e <memmove+0x52>
      *dst++ = *src++;
     55e:	fe043703          	ld	a4,-32(s0)
     562:	00170793          	addi	a5,a4,1
     566:	fef43023          	sd	a5,-32(s0)
     56a:	fe843783          	ld	a5,-24(s0)
     56e:	00178693          	addi	a3,a5,1
     572:	fed43423          	sd	a3,-24(s0)
     576:	00074703          	lbu	a4,0(a4)
     57a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     57e:	fcc42783          	lw	a5,-52(s0)
     582:	fff7871b          	addiw	a4,a5,-1
     586:	fce42623          	sw	a4,-52(s0)
     58a:	fcf04ae3          	bgtz	a5,55e <memmove+0x32>
     58e:	a891                	j	5e2 <memmove+0xb6>
  } else {
    dst += n;
     590:	fcc42783          	lw	a5,-52(s0)
     594:	fe843703          	ld	a4,-24(s0)
     598:	97ba                	add	a5,a5,a4
     59a:	fef43423          	sd	a5,-24(s0)
    src += n;
     59e:	fcc42783          	lw	a5,-52(s0)
     5a2:	fe043703          	ld	a4,-32(s0)
     5a6:	97ba                	add	a5,a5,a4
     5a8:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     5ac:	a01d                	j	5d2 <memmove+0xa6>
      *--dst = *--src;
     5ae:	fe043783          	ld	a5,-32(s0)
     5b2:	17fd                	addi	a5,a5,-1
     5b4:	fef43023          	sd	a5,-32(s0)
     5b8:	fe843783          	ld	a5,-24(s0)
     5bc:	17fd                	addi	a5,a5,-1
     5be:	fef43423          	sd	a5,-24(s0)
     5c2:	fe043783          	ld	a5,-32(s0)
     5c6:	0007c703          	lbu	a4,0(a5)
     5ca:	fe843783          	ld	a5,-24(s0)
     5ce:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     5d2:	fcc42783          	lw	a5,-52(s0)
     5d6:	fff7871b          	addiw	a4,a5,-1
     5da:	fce42623          	sw	a4,-52(s0)
     5de:	fcf048e3          	bgtz	a5,5ae <memmove+0x82>
  }
  return vdst;
     5e2:	fd843783          	ld	a5,-40(s0)
}
     5e6:	853e                	mv	a0,a5
     5e8:	7462                	ld	s0,56(sp)
     5ea:	6121                	addi	sp,sp,64
     5ec:	8082                	ret

00000000000005ee <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     5ee:	7139                	addi	sp,sp,-64
     5f0:	fc22                	sd	s0,56(sp)
     5f2:	0080                	addi	s0,sp,64
     5f4:	fca43c23          	sd	a0,-40(s0)
     5f8:	fcb43823          	sd	a1,-48(s0)
     5fc:	87b2                	mv	a5,a2
     5fe:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     602:	fd843783          	ld	a5,-40(s0)
     606:	fef43423          	sd	a5,-24(s0)
     60a:	fd043783          	ld	a5,-48(s0)
     60e:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     612:	a0a1                	j	65a <memcmp+0x6c>
    if (*p1 != *p2) {
     614:	fe843783          	ld	a5,-24(s0)
     618:	0007c703          	lbu	a4,0(a5)
     61c:	fe043783          	ld	a5,-32(s0)
     620:	0007c783          	lbu	a5,0(a5)
     624:	02f70163          	beq	a4,a5,646 <memcmp+0x58>
      return *p1 - *p2;
     628:	fe843783          	ld	a5,-24(s0)
     62c:	0007c783          	lbu	a5,0(a5)
     630:	0007871b          	sext.w	a4,a5
     634:	fe043783          	ld	a5,-32(s0)
     638:	0007c783          	lbu	a5,0(a5)
     63c:	2781                	sext.w	a5,a5
     63e:	40f707bb          	subw	a5,a4,a5
     642:	2781                	sext.w	a5,a5
     644:	a01d                	j	66a <memcmp+0x7c>
    }
    p1++;
     646:	fe843783          	ld	a5,-24(s0)
     64a:	0785                	addi	a5,a5,1
     64c:	fef43423          	sd	a5,-24(s0)
    p2++;
     650:	fe043783          	ld	a5,-32(s0)
     654:	0785                	addi	a5,a5,1
     656:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     65a:	fcc42783          	lw	a5,-52(s0)
     65e:	fff7871b          	addiw	a4,a5,-1
     662:	fce42623          	sw	a4,-52(s0)
     666:	f7dd                	bnez	a5,614 <memcmp+0x26>
  }
  return 0;
     668:	4781                	li	a5,0
}
     66a:	853e                	mv	a0,a5
     66c:	7462                	ld	s0,56(sp)
     66e:	6121                	addi	sp,sp,64
     670:	8082                	ret

0000000000000672 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     672:	7179                	addi	sp,sp,-48
     674:	f406                	sd	ra,40(sp)
     676:	f022                	sd	s0,32(sp)
     678:	1800                	addi	s0,sp,48
     67a:	fea43423          	sd	a0,-24(s0)
     67e:	feb43023          	sd	a1,-32(s0)
     682:	87b2                	mv	a5,a2
     684:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     688:	fdc42783          	lw	a5,-36(s0)
     68c:	863e                	mv	a2,a5
     68e:	fe043583          	ld	a1,-32(s0)
     692:	fe843503          	ld	a0,-24(s0)
     696:	00000097          	auipc	ra,0x0
     69a:	e96080e7          	jalr	-362(ra) # 52c <memmove>
     69e:	87aa                	mv	a5,a0
}
     6a0:	853e                	mv	a0,a5
     6a2:	70a2                	ld	ra,40(sp)
     6a4:	7402                	ld	s0,32(sp)
     6a6:	6145                	addi	sp,sp,48
     6a8:	8082                	ret

00000000000006aa <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     6aa:	4885                	li	a7,1
 ecall
     6ac:	00000073          	ecall
 ret
     6b0:	8082                	ret

00000000000006b2 <exit>:
.global exit
exit:
 li a7, SYS_exit
     6b2:	4889                	li	a7,2
 ecall
     6b4:	00000073          	ecall
 ret
     6b8:	8082                	ret

00000000000006ba <wait>:
.global wait
wait:
 li a7, SYS_wait
     6ba:	488d                	li	a7,3
 ecall
     6bc:	00000073          	ecall
 ret
     6c0:	8082                	ret

00000000000006c2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     6c2:	4891                	li	a7,4
 ecall
     6c4:	00000073          	ecall
 ret
     6c8:	8082                	ret

00000000000006ca <read>:
.global read
read:
 li a7, SYS_read
     6ca:	4895                	li	a7,5
 ecall
     6cc:	00000073          	ecall
 ret
     6d0:	8082                	ret

00000000000006d2 <write>:
.global write
write:
 li a7, SYS_write
     6d2:	48c1                	li	a7,16
 ecall
     6d4:	00000073          	ecall
 ret
     6d8:	8082                	ret

00000000000006da <close>:
.global close
close:
 li a7, SYS_close
     6da:	48d5                	li	a7,21
 ecall
     6dc:	00000073          	ecall
 ret
     6e0:	8082                	ret

00000000000006e2 <kill>:
.global kill
kill:
 li a7, SYS_kill
     6e2:	4899                	li	a7,6
 ecall
     6e4:	00000073          	ecall
 ret
     6e8:	8082                	ret

00000000000006ea <exec>:
.global exec
exec:
 li a7, SYS_exec
     6ea:	489d                	li	a7,7
 ecall
     6ec:	00000073          	ecall
 ret
     6f0:	8082                	ret

00000000000006f2 <open>:
.global open
open:
 li a7, SYS_open
     6f2:	48bd                	li	a7,15
 ecall
     6f4:	00000073          	ecall
 ret
     6f8:	8082                	ret

00000000000006fa <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     6fa:	48c5                	li	a7,17
 ecall
     6fc:	00000073          	ecall
 ret
     700:	8082                	ret

0000000000000702 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     702:	48c9                	li	a7,18
 ecall
     704:	00000073          	ecall
 ret
     708:	8082                	ret

000000000000070a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     70a:	48a1                	li	a7,8
 ecall
     70c:	00000073          	ecall
 ret
     710:	8082                	ret

0000000000000712 <link>:
.global link
link:
 li a7, SYS_link
     712:	48cd                	li	a7,19
 ecall
     714:	00000073          	ecall
 ret
     718:	8082                	ret

000000000000071a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     71a:	48d1                	li	a7,20
 ecall
     71c:	00000073          	ecall
 ret
     720:	8082                	ret

0000000000000722 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     722:	48a5                	li	a7,9
 ecall
     724:	00000073          	ecall
 ret
     728:	8082                	ret

000000000000072a <dup>:
.global dup
dup:
 li a7, SYS_dup
     72a:	48a9                	li	a7,10
 ecall
     72c:	00000073          	ecall
 ret
     730:	8082                	ret

0000000000000732 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     732:	48ad                	li	a7,11
 ecall
     734:	00000073          	ecall
 ret
     738:	8082                	ret

000000000000073a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     73a:	48b1                	li	a7,12
 ecall
     73c:	00000073          	ecall
 ret
     740:	8082                	ret

0000000000000742 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     742:	48b5                	li	a7,13
 ecall
     744:	00000073          	ecall
 ret
     748:	8082                	ret

000000000000074a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     74a:	48b9                	li	a7,14
 ecall
     74c:	00000073          	ecall
 ret
     750:	8082                	ret

0000000000000752 <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     752:	48d9                	li	a7,22
 ecall
     754:	00000073          	ecall
 ret
     758:	8082                	ret

000000000000075a <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     75a:	48dd                	li	a7,23
 ecall
     75c:	00000073          	ecall
 ret
     760:	8082                	ret

0000000000000762 <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     762:	48e1                	li	a7,24
 ecall
     764:	00000073          	ecall
 ret
     768:	8082                	ret

000000000000076a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     76a:	1101                	addi	sp,sp,-32
     76c:	ec06                	sd	ra,24(sp)
     76e:	e822                	sd	s0,16(sp)
     770:	1000                	addi	s0,sp,32
     772:	87aa                	mv	a5,a0
     774:	872e                	mv	a4,a1
     776:	fef42623          	sw	a5,-20(s0)
     77a:	87ba                	mv	a5,a4
     77c:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     780:	feb40713          	addi	a4,s0,-21
     784:	fec42783          	lw	a5,-20(s0)
     788:	4605                	li	a2,1
     78a:	85ba                	mv	a1,a4
     78c:	853e                	mv	a0,a5
     78e:	00000097          	auipc	ra,0x0
     792:	f44080e7          	jalr	-188(ra) # 6d2 <write>
}
     796:	0001                	nop
     798:	60e2                	ld	ra,24(sp)
     79a:	6442                	ld	s0,16(sp)
     79c:	6105                	addi	sp,sp,32
     79e:	8082                	ret

00000000000007a0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     7a0:	7139                	addi	sp,sp,-64
     7a2:	fc06                	sd	ra,56(sp)
     7a4:	f822                	sd	s0,48(sp)
     7a6:	0080                	addi	s0,sp,64
     7a8:	87aa                	mv	a5,a0
     7aa:	8736                	mv	a4,a3
     7ac:	fcf42623          	sw	a5,-52(s0)
     7b0:	87ae                	mv	a5,a1
     7b2:	fcf42423          	sw	a5,-56(s0)
     7b6:	87b2                	mv	a5,a2
     7b8:	fcf42223          	sw	a5,-60(s0)
     7bc:	87ba                	mv	a5,a4
     7be:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     7c2:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     7c6:	fc042783          	lw	a5,-64(s0)
     7ca:	2781                	sext.w	a5,a5
     7cc:	c38d                	beqz	a5,7ee <printint+0x4e>
     7ce:	fc842783          	lw	a5,-56(s0)
     7d2:	2781                	sext.w	a5,a5
     7d4:	0007dd63          	bgez	a5,7ee <printint+0x4e>
    neg = 1;
     7d8:	4785                	li	a5,1
     7da:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     7de:	fc842783          	lw	a5,-56(s0)
     7e2:	40f007bb          	negw	a5,a5
     7e6:	2781                	sext.w	a5,a5
     7e8:	fef42223          	sw	a5,-28(s0)
     7ec:	a029                	j	7f6 <printint+0x56>
  } else {
    x = xx;
     7ee:	fc842783          	lw	a5,-56(s0)
     7f2:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     7f6:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     7fa:	fc442783          	lw	a5,-60(s0)
     7fe:	fe442703          	lw	a4,-28(s0)
     802:	02f777bb          	remuw	a5,a4,a5
     806:	0007861b          	sext.w	a2,a5
     80a:	fec42783          	lw	a5,-20(s0)
     80e:	0017871b          	addiw	a4,a5,1
     812:	fee42623          	sw	a4,-20(s0)
     816:	00001697          	auipc	a3,0x1
     81a:	39268693          	addi	a3,a3,914 # 1ba8 <digits>
     81e:	02061713          	slli	a4,a2,0x20
     822:	9301                	srli	a4,a4,0x20
     824:	9736                	add	a4,a4,a3
     826:	00074703          	lbu	a4,0(a4)
     82a:	ff040693          	addi	a3,s0,-16
     82e:	97b6                	add	a5,a5,a3
     830:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     834:	fc442783          	lw	a5,-60(s0)
     838:	fe442703          	lw	a4,-28(s0)
     83c:	02f757bb          	divuw	a5,a4,a5
     840:	fef42223          	sw	a5,-28(s0)
     844:	fe442783          	lw	a5,-28(s0)
     848:	2781                	sext.w	a5,a5
     84a:	fbc5                	bnez	a5,7fa <printint+0x5a>
  if(neg)
     84c:	fe842783          	lw	a5,-24(s0)
     850:	2781                	sext.w	a5,a5
     852:	cf95                	beqz	a5,88e <printint+0xee>
    buf[i++] = '-';
     854:	fec42783          	lw	a5,-20(s0)
     858:	0017871b          	addiw	a4,a5,1
     85c:	fee42623          	sw	a4,-20(s0)
     860:	ff040713          	addi	a4,s0,-16
     864:	97ba                	add	a5,a5,a4
     866:	02d00713          	li	a4,45
     86a:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     86e:	a005                	j	88e <printint+0xee>
    putc(fd, buf[i]);
     870:	fec42783          	lw	a5,-20(s0)
     874:	ff040713          	addi	a4,s0,-16
     878:	97ba                	add	a5,a5,a4
     87a:	fe07c703          	lbu	a4,-32(a5)
     87e:	fcc42783          	lw	a5,-52(s0)
     882:	85ba                	mv	a1,a4
     884:	853e                	mv	a0,a5
     886:	00000097          	auipc	ra,0x0
     88a:	ee4080e7          	jalr	-284(ra) # 76a <putc>
  while(--i >= 0)
     88e:	fec42783          	lw	a5,-20(s0)
     892:	37fd                	addiw	a5,a5,-1
     894:	fef42623          	sw	a5,-20(s0)
     898:	fec42783          	lw	a5,-20(s0)
     89c:	2781                	sext.w	a5,a5
     89e:	fc07d9e3          	bgez	a5,870 <printint+0xd0>
}
     8a2:	0001                	nop
     8a4:	0001                	nop
     8a6:	70e2                	ld	ra,56(sp)
     8a8:	7442                	ld	s0,48(sp)
     8aa:	6121                	addi	sp,sp,64
     8ac:	8082                	ret

00000000000008ae <printptr>:

static void
printptr(int fd, uint64 x) {
     8ae:	7179                	addi	sp,sp,-48
     8b0:	f406                	sd	ra,40(sp)
     8b2:	f022                	sd	s0,32(sp)
     8b4:	1800                	addi	s0,sp,48
     8b6:	87aa                	mv	a5,a0
     8b8:	fcb43823          	sd	a1,-48(s0)
     8bc:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     8c0:	fdc42783          	lw	a5,-36(s0)
     8c4:	03000593          	li	a1,48
     8c8:	853e                	mv	a0,a5
     8ca:	00000097          	auipc	ra,0x0
     8ce:	ea0080e7          	jalr	-352(ra) # 76a <putc>
  putc(fd, 'x');
     8d2:	fdc42783          	lw	a5,-36(s0)
     8d6:	07800593          	li	a1,120
     8da:	853e                	mv	a0,a5
     8dc:	00000097          	auipc	ra,0x0
     8e0:	e8e080e7          	jalr	-370(ra) # 76a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     8e4:	fe042623          	sw	zero,-20(s0)
     8e8:	a82d                	j	922 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     8ea:	fd043783          	ld	a5,-48(s0)
     8ee:	93f1                	srli	a5,a5,0x3c
     8f0:	00001717          	auipc	a4,0x1
     8f4:	2b870713          	addi	a4,a4,696 # 1ba8 <digits>
     8f8:	97ba                	add	a5,a5,a4
     8fa:	0007c703          	lbu	a4,0(a5)
     8fe:	fdc42783          	lw	a5,-36(s0)
     902:	85ba                	mv	a1,a4
     904:	853e                	mv	a0,a5
     906:	00000097          	auipc	ra,0x0
     90a:	e64080e7          	jalr	-412(ra) # 76a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     90e:	fec42783          	lw	a5,-20(s0)
     912:	2785                	addiw	a5,a5,1
     914:	fef42623          	sw	a5,-20(s0)
     918:	fd043783          	ld	a5,-48(s0)
     91c:	0792                	slli	a5,a5,0x4
     91e:	fcf43823          	sd	a5,-48(s0)
     922:	fec42783          	lw	a5,-20(s0)
     926:	873e                	mv	a4,a5
     928:	47bd                	li	a5,15
     92a:	fce7f0e3          	bgeu	a5,a4,8ea <printptr+0x3c>
}
     92e:	0001                	nop
     930:	0001                	nop
     932:	70a2                	ld	ra,40(sp)
     934:	7402                	ld	s0,32(sp)
     936:	6145                	addi	sp,sp,48
     938:	8082                	ret

000000000000093a <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     93a:	715d                	addi	sp,sp,-80
     93c:	e486                	sd	ra,72(sp)
     93e:	e0a2                	sd	s0,64(sp)
     940:	0880                	addi	s0,sp,80
     942:	87aa                	mv	a5,a0
     944:	fcb43023          	sd	a1,-64(s0)
     948:	fac43c23          	sd	a2,-72(s0)
     94c:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     950:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     954:	fe042223          	sw	zero,-28(s0)
     958:	a42d                	j	b82 <vprintf+0x248>
    c = fmt[i] & 0xff;
     95a:	fe442783          	lw	a5,-28(s0)
     95e:	fc043703          	ld	a4,-64(s0)
     962:	97ba                	add	a5,a5,a4
     964:	0007c783          	lbu	a5,0(a5)
     968:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     96c:	fe042783          	lw	a5,-32(s0)
     970:	2781                	sext.w	a5,a5
     972:	eb9d                	bnez	a5,9a8 <vprintf+0x6e>
      if(c == '%'){
     974:	fdc42783          	lw	a5,-36(s0)
     978:	0007871b          	sext.w	a4,a5
     97c:	02500793          	li	a5,37
     980:	00f71763          	bne	a4,a5,98e <vprintf+0x54>
        state = '%';
     984:	02500793          	li	a5,37
     988:	fef42023          	sw	a5,-32(s0)
     98c:	a2f5                	j	b78 <vprintf+0x23e>
      } else {
        putc(fd, c);
     98e:	fdc42783          	lw	a5,-36(s0)
     992:	0ff7f713          	andi	a4,a5,255
     996:	fcc42783          	lw	a5,-52(s0)
     99a:	85ba                	mv	a1,a4
     99c:	853e                	mv	a0,a5
     99e:	00000097          	auipc	ra,0x0
     9a2:	dcc080e7          	jalr	-564(ra) # 76a <putc>
     9a6:	aac9                	j	b78 <vprintf+0x23e>
      }
    } else if(state == '%'){
     9a8:	fe042783          	lw	a5,-32(s0)
     9ac:	0007871b          	sext.w	a4,a5
     9b0:	02500793          	li	a5,37
     9b4:	1cf71263          	bne	a4,a5,b78 <vprintf+0x23e>
      if(c == 'd'){
     9b8:	fdc42783          	lw	a5,-36(s0)
     9bc:	0007871b          	sext.w	a4,a5
     9c0:	06400793          	li	a5,100
     9c4:	02f71463          	bne	a4,a5,9ec <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     9c8:	fb843783          	ld	a5,-72(s0)
     9cc:	00878713          	addi	a4,a5,8
     9d0:	fae43c23          	sd	a4,-72(s0)
     9d4:	4398                	lw	a4,0(a5)
     9d6:	fcc42783          	lw	a5,-52(s0)
     9da:	4685                	li	a3,1
     9dc:	4629                	li	a2,10
     9de:	85ba                	mv	a1,a4
     9e0:	853e                	mv	a0,a5
     9e2:	00000097          	auipc	ra,0x0
     9e6:	dbe080e7          	jalr	-578(ra) # 7a0 <printint>
     9ea:	a269                	j	b74 <vprintf+0x23a>
      } else if(c == 'l') {
     9ec:	fdc42783          	lw	a5,-36(s0)
     9f0:	0007871b          	sext.w	a4,a5
     9f4:	06c00793          	li	a5,108
     9f8:	02f71663          	bne	a4,a5,a24 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     9fc:	fb843783          	ld	a5,-72(s0)
     a00:	00878713          	addi	a4,a5,8
     a04:	fae43c23          	sd	a4,-72(s0)
     a08:	639c                	ld	a5,0(a5)
     a0a:	0007871b          	sext.w	a4,a5
     a0e:	fcc42783          	lw	a5,-52(s0)
     a12:	4681                	li	a3,0
     a14:	4629                	li	a2,10
     a16:	85ba                	mv	a1,a4
     a18:	853e                	mv	a0,a5
     a1a:	00000097          	auipc	ra,0x0
     a1e:	d86080e7          	jalr	-634(ra) # 7a0 <printint>
     a22:	aa89                	j	b74 <vprintf+0x23a>
      } else if(c == 'x') {
     a24:	fdc42783          	lw	a5,-36(s0)
     a28:	0007871b          	sext.w	a4,a5
     a2c:	07800793          	li	a5,120
     a30:	02f71463          	bne	a4,a5,a58 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     a34:	fb843783          	ld	a5,-72(s0)
     a38:	00878713          	addi	a4,a5,8
     a3c:	fae43c23          	sd	a4,-72(s0)
     a40:	4398                	lw	a4,0(a5)
     a42:	fcc42783          	lw	a5,-52(s0)
     a46:	4681                	li	a3,0
     a48:	4641                	li	a2,16
     a4a:	85ba                	mv	a1,a4
     a4c:	853e                	mv	a0,a5
     a4e:	00000097          	auipc	ra,0x0
     a52:	d52080e7          	jalr	-686(ra) # 7a0 <printint>
     a56:	aa39                	j	b74 <vprintf+0x23a>
      } else if(c == 'p') {
     a58:	fdc42783          	lw	a5,-36(s0)
     a5c:	0007871b          	sext.w	a4,a5
     a60:	07000793          	li	a5,112
     a64:	02f71263          	bne	a4,a5,a88 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     a68:	fb843783          	ld	a5,-72(s0)
     a6c:	00878713          	addi	a4,a5,8
     a70:	fae43c23          	sd	a4,-72(s0)
     a74:	6398                	ld	a4,0(a5)
     a76:	fcc42783          	lw	a5,-52(s0)
     a7a:	85ba                	mv	a1,a4
     a7c:	853e                	mv	a0,a5
     a7e:	00000097          	auipc	ra,0x0
     a82:	e30080e7          	jalr	-464(ra) # 8ae <printptr>
     a86:	a0fd                	j	b74 <vprintf+0x23a>
      } else if(c == 's'){
     a88:	fdc42783          	lw	a5,-36(s0)
     a8c:	0007871b          	sext.w	a4,a5
     a90:	07300793          	li	a5,115
     a94:	04f71c63          	bne	a4,a5,aec <vprintf+0x1b2>
        s = va_arg(ap, char*);
     a98:	fb843783          	ld	a5,-72(s0)
     a9c:	00878713          	addi	a4,a5,8
     aa0:	fae43c23          	sd	a4,-72(s0)
     aa4:	639c                	ld	a5,0(a5)
     aa6:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     aaa:	fe843783          	ld	a5,-24(s0)
     aae:	eb8d                	bnez	a5,ae0 <vprintf+0x1a6>
          s = "(null)";
     ab0:	00001797          	auipc	a5,0x1
     ab4:	0f078793          	addi	a5,a5,240 # 1ba0 <schedule_dm+0x220>
     ab8:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     abc:	a015                	j	ae0 <vprintf+0x1a6>
          putc(fd, *s);
     abe:	fe843783          	ld	a5,-24(s0)
     ac2:	0007c703          	lbu	a4,0(a5)
     ac6:	fcc42783          	lw	a5,-52(s0)
     aca:	85ba                	mv	a1,a4
     acc:	853e                	mv	a0,a5
     ace:	00000097          	auipc	ra,0x0
     ad2:	c9c080e7          	jalr	-868(ra) # 76a <putc>
          s++;
     ad6:	fe843783          	ld	a5,-24(s0)
     ada:	0785                	addi	a5,a5,1
     adc:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     ae0:	fe843783          	ld	a5,-24(s0)
     ae4:	0007c783          	lbu	a5,0(a5)
     ae8:	fbf9                	bnez	a5,abe <vprintf+0x184>
     aea:	a069                	j	b74 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     aec:	fdc42783          	lw	a5,-36(s0)
     af0:	0007871b          	sext.w	a4,a5
     af4:	06300793          	li	a5,99
     af8:	02f71463          	bne	a4,a5,b20 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     afc:	fb843783          	ld	a5,-72(s0)
     b00:	00878713          	addi	a4,a5,8
     b04:	fae43c23          	sd	a4,-72(s0)
     b08:	439c                	lw	a5,0(a5)
     b0a:	0ff7f713          	andi	a4,a5,255
     b0e:	fcc42783          	lw	a5,-52(s0)
     b12:	85ba                	mv	a1,a4
     b14:	853e                	mv	a0,a5
     b16:	00000097          	auipc	ra,0x0
     b1a:	c54080e7          	jalr	-940(ra) # 76a <putc>
     b1e:	a899                	j	b74 <vprintf+0x23a>
      } else if(c == '%'){
     b20:	fdc42783          	lw	a5,-36(s0)
     b24:	0007871b          	sext.w	a4,a5
     b28:	02500793          	li	a5,37
     b2c:	00f71f63          	bne	a4,a5,b4a <vprintf+0x210>
        putc(fd, c);
     b30:	fdc42783          	lw	a5,-36(s0)
     b34:	0ff7f713          	andi	a4,a5,255
     b38:	fcc42783          	lw	a5,-52(s0)
     b3c:	85ba                	mv	a1,a4
     b3e:	853e                	mv	a0,a5
     b40:	00000097          	auipc	ra,0x0
     b44:	c2a080e7          	jalr	-982(ra) # 76a <putc>
     b48:	a035                	j	b74 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     b4a:	fcc42783          	lw	a5,-52(s0)
     b4e:	02500593          	li	a1,37
     b52:	853e                	mv	a0,a5
     b54:	00000097          	auipc	ra,0x0
     b58:	c16080e7          	jalr	-1002(ra) # 76a <putc>
        putc(fd, c);
     b5c:	fdc42783          	lw	a5,-36(s0)
     b60:	0ff7f713          	andi	a4,a5,255
     b64:	fcc42783          	lw	a5,-52(s0)
     b68:	85ba                	mv	a1,a4
     b6a:	853e                	mv	a0,a5
     b6c:	00000097          	auipc	ra,0x0
     b70:	bfe080e7          	jalr	-1026(ra) # 76a <putc>
      }
      state = 0;
     b74:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     b78:	fe442783          	lw	a5,-28(s0)
     b7c:	2785                	addiw	a5,a5,1
     b7e:	fef42223          	sw	a5,-28(s0)
     b82:	fe442783          	lw	a5,-28(s0)
     b86:	fc043703          	ld	a4,-64(s0)
     b8a:	97ba                	add	a5,a5,a4
     b8c:	0007c783          	lbu	a5,0(a5)
     b90:	dc0795e3          	bnez	a5,95a <vprintf+0x20>
    }
  }
}
     b94:	0001                	nop
     b96:	0001                	nop
     b98:	60a6                	ld	ra,72(sp)
     b9a:	6406                	ld	s0,64(sp)
     b9c:	6161                	addi	sp,sp,80
     b9e:	8082                	ret

0000000000000ba0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     ba0:	7159                	addi	sp,sp,-112
     ba2:	fc06                	sd	ra,56(sp)
     ba4:	f822                	sd	s0,48(sp)
     ba6:	0080                	addi	s0,sp,64
     ba8:	fcb43823          	sd	a1,-48(s0)
     bac:	e010                	sd	a2,0(s0)
     bae:	e414                	sd	a3,8(s0)
     bb0:	e818                	sd	a4,16(s0)
     bb2:	ec1c                	sd	a5,24(s0)
     bb4:	03043023          	sd	a6,32(s0)
     bb8:	03143423          	sd	a7,40(s0)
     bbc:	87aa                	mv	a5,a0
     bbe:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     bc2:	03040793          	addi	a5,s0,48
     bc6:	fcf43423          	sd	a5,-56(s0)
     bca:	fc843783          	ld	a5,-56(s0)
     bce:	fd078793          	addi	a5,a5,-48
     bd2:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     bd6:	fe843703          	ld	a4,-24(s0)
     bda:	fdc42783          	lw	a5,-36(s0)
     bde:	863a                	mv	a2,a4
     be0:	fd043583          	ld	a1,-48(s0)
     be4:	853e                	mv	a0,a5
     be6:	00000097          	auipc	ra,0x0
     bea:	d54080e7          	jalr	-684(ra) # 93a <vprintf>
}
     bee:	0001                	nop
     bf0:	70e2                	ld	ra,56(sp)
     bf2:	7442                	ld	s0,48(sp)
     bf4:	6165                	addi	sp,sp,112
     bf6:	8082                	ret

0000000000000bf8 <printf>:

void
printf(const char *fmt, ...)
{
     bf8:	7159                	addi	sp,sp,-112
     bfa:	f406                	sd	ra,40(sp)
     bfc:	f022                	sd	s0,32(sp)
     bfe:	1800                	addi	s0,sp,48
     c00:	fca43c23          	sd	a0,-40(s0)
     c04:	e40c                	sd	a1,8(s0)
     c06:	e810                	sd	a2,16(s0)
     c08:	ec14                	sd	a3,24(s0)
     c0a:	f018                	sd	a4,32(s0)
     c0c:	f41c                	sd	a5,40(s0)
     c0e:	03043823          	sd	a6,48(s0)
     c12:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     c16:	04040793          	addi	a5,s0,64
     c1a:	fcf43823          	sd	a5,-48(s0)
     c1e:	fd043783          	ld	a5,-48(s0)
     c22:	fc878793          	addi	a5,a5,-56
     c26:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     c2a:	fe843783          	ld	a5,-24(s0)
     c2e:	863e                	mv	a2,a5
     c30:	fd843583          	ld	a1,-40(s0)
     c34:	4505                	li	a0,1
     c36:	00000097          	auipc	ra,0x0
     c3a:	d04080e7          	jalr	-764(ra) # 93a <vprintf>
}
     c3e:	0001                	nop
     c40:	70a2                	ld	ra,40(sp)
     c42:	7402                	ld	s0,32(sp)
     c44:	6165                	addi	sp,sp,112
     c46:	8082                	ret

0000000000000c48 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     c48:	7179                	addi	sp,sp,-48
     c4a:	f422                	sd	s0,40(sp)
     c4c:	1800                	addi	s0,sp,48
     c4e:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     c52:	fd843783          	ld	a5,-40(s0)
     c56:	17c1                	addi	a5,a5,-16
     c58:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     c5c:	00001797          	auipc	a5,0x1
     c60:	17478793          	addi	a5,a5,372 # 1dd0 <freep>
     c64:	639c                	ld	a5,0(a5)
     c66:	fef43423          	sd	a5,-24(s0)
     c6a:	a815                	j	c9e <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     c6c:	fe843783          	ld	a5,-24(s0)
     c70:	639c                	ld	a5,0(a5)
     c72:	fe843703          	ld	a4,-24(s0)
     c76:	00f76f63          	bltu	a4,a5,c94 <free+0x4c>
     c7a:	fe043703          	ld	a4,-32(s0)
     c7e:	fe843783          	ld	a5,-24(s0)
     c82:	02e7eb63          	bltu	a5,a4,cb8 <free+0x70>
     c86:	fe843783          	ld	a5,-24(s0)
     c8a:	639c                	ld	a5,0(a5)
     c8c:	fe043703          	ld	a4,-32(s0)
     c90:	02f76463          	bltu	a4,a5,cb8 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     c94:	fe843783          	ld	a5,-24(s0)
     c98:	639c                	ld	a5,0(a5)
     c9a:	fef43423          	sd	a5,-24(s0)
     c9e:	fe043703          	ld	a4,-32(s0)
     ca2:	fe843783          	ld	a5,-24(s0)
     ca6:	fce7f3e3          	bgeu	a5,a4,c6c <free+0x24>
     caa:	fe843783          	ld	a5,-24(s0)
     cae:	639c                	ld	a5,0(a5)
     cb0:	fe043703          	ld	a4,-32(s0)
     cb4:	faf77ce3          	bgeu	a4,a5,c6c <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     cb8:	fe043783          	ld	a5,-32(s0)
     cbc:	479c                	lw	a5,8(a5)
     cbe:	1782                	slli	a5,a5,0x20
     cc0:	9381                	srli	a5,a5,0x20
     cc2:	0792                	slli	a5,a5,0x4
     cc4:	fe043703          	ld	a4,-32(s0)
     cc8:	973e                	add	a4,a4,a5
     cca:	fe843783          	ld	a5,-24(s0)
     cce:	639c                	ld	a5,0(a5)
     cd0:	02f71763          	bne	a4,a5,cfe <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     cd4:	fe043783          	ld	a5,-32(s0)
     cd8:	4798                	lw	a4,8(a5)
     cda:	fe843783          	ld	a5,-24(s0)
     cde:	639c                	ld	a5,0(a5)
     ce0:	479c                	lw	a5,8(a5)
     ce2:	9fb9                	addw	a5,a5,a4
     ce4:	0007871b          	sext.w	a4,a5
     ce8:	fe043783          	ld	a5,-32(s0)
     cec:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     cee:	fe843783          	ld	a5,-24(s0)
     cf2:	639c                	ld	a5,0(a5)
     cf4:	6398                	ld	a4,0(a5)
     cf6:	fe043783          	ld	a5,-32(s0)
     cfa:	e398                	sd	a4,0(a5)
     cfc:	a039                	j	d0a <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     cfe:	fe843783          	ld	a5,-24(s0)
     d02:	6398                	ld	a4,0(a5)
     d04:	fe043783          	ld	a5,-32(s0)
     d08:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     d0a:	fe843783          	ld	a5,-24(s0)
     d0e:	479c                	lw	a5,8(a5)
     d10:	1782                	slli	a5,a5,0x20
     d12:	9381                	srli	a5,a5,0x20
     d14:	0792                	slli	a5,a5,0x4
     d16:	fe843703          	ld	a4,-24(s0)
     d1a:	97ba                	add	a5,a5,a4
     d1c:	fe043703          	ld	a4,-32(s0)
     d20:	02f71563          	bne	a4,a5,d4a <free+0x102>
    p->s.size += bp->s.size;
     d24:	fe843783          	ld	a5,-24(s0)
     d28:	4798                	lw	a4,8(a5)
     d2a:	fe043783          	ld	a5,-32(s0)
     d2e:	479c                	lw	a5,8(a5)
     d30:	9fb9                	addw	a5,a5,a4
     d32:	0007871b          	sext.w	a4,a5
     d36:	fe843783          	ld	a5,-24(s0)
     d3a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     d3c:	fe043783          	ld	a5,-32(s0)
     d40:	6398                	ld	a4,0(a5)
     d42:	fe843783          	ld	a5,-24(s0)
     d46:	e398                	sd	a4,0(a5)
     d48:	a031                	j	d54 <free+0x10c>
  } else
    p->s.ptr = bp;
     d4a:	fe843783          	ld	a5,-24(s0)
     d4e:	fe043703          	ld	a4,-32(s0)
     d52:	e398                	sd	a4,0(a5)
  freep = p;
     d54:	00001797          	auipc	a5,0x1
     d58:	07c78793          	addi	a5,a5,124 # 1dd0 <freep>
     d5c:	fe843703          	ld	a4,-24(s0)
     d60:	e398                	sd	a4,0(a5)
}
     d62:	0001                	nop
     d64:	7422                	ld	s0,40(sp)
     d66:	6145                	addi	sp,sp,48
     d68:	8082                	ret

0000000000000d6a <morecore>:

static Header*
morecore(uint nu)
{
     d6a:	7179                	addi	sp,sp,-48
     d6c:	f406                	sd	ra,40(sp)
     d6e:	f022                	sd	s0,32(sp)
     d70:	1800                	addi	s0,sp,48
     d72:	87aa                	mv	a5,a0
     d74:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     d78:	fdc42783          	lw	a5,-36(s0)
     d7c:	0007871b          	sext.w	a4,a5
     d80:	6785                	lui	a5,0x1
     d82:	00f77563          	bgeu	a4,a5,d8c <morecore+0x22>
    nu = 4096;
     d86:	6785                	lui	a5,0x1
     d88:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     d8c:	fdc42783          	lw	a5,-36(s0)
     d90:	0047979b          	slliw	a5,a5,0x4
     d94:	2781                	sext.w	a5,a5
     d96:	2781                	sext.w	a5,a5
     d98:	853e                	mv	a0,a5
     d9a:	00000097          	auipc	ra,0x0
     d9e:	9a0080e7          	jalr	-1632(ra) # 73a <sbrk>
     da2:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     da6:	fe843703          	ld	a4,-24(s0)
     daa:	57fd                	li	a5,-1
     dac:	00f71463          	bne	a4,a5,db4 <morecore+0x4a>
    return 0;
     db0:	4781                	li	a5,0
     db2:	a03d                	j	de0 <morecore+0x76>
  hp = (Header*)p;
     db4:	fe843783          	ld	a5,-24(s0)
     db8:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     dbc:	fe043783          	ld	a5,-32(s0)
     dc0:	fdc42703          	lw	a4,-36(s0)
     dc4:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     dc6:	fe043783          	ld	a5,-32(s0)
     dca:	07c1                	addi	a5,a5,16
     dcc:	853e                	mv	a0,a5
     dce:	00000097          	auipc	ra,0x0
     dd2:	e7a080e7          	jalr	-390(ra) # c48 <free>
  return freep;
     dd6:	00001797          	auipc	a5,0x1
     dda:	ffa78793          	addi	a5,a5,-6 # 1dd0 <freep>
     dde:	639c                	ld	a5,0(a5)
}
     de0:	853e                	mv	a0,a5
     de2:	70a2                	ld	ra,40(sp)
     de4:	7402                	ld	s0,32(sp)
     de6:	6145                	addi	sp,sp,48
     de8:	8082                	ret

0000000000000dea <malloc>:

void*
malloc(uint nbytes)
{
     dea:	7139                	addi	sp,sp,-64
     dec:	fc06                	sd	ra,56(sp)
     dee:	f822                	sd	s0,48(sp)
     df0:	0080                	addi	s0,sp,64
     df2:	87aa                	mv	a5,a0
     df4:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     df8:	fcc46783          	lwu	a5,-52(s0)
     dfc:	07bd                	addi	a5,a5,15
     dfe:	8391                	srli	a5,a5,0x4
     e00:	2781                	sext.w	a5,a5
     e02:	2785                	addiw	a5,a5,1
     e04:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     e08:	00001797          	auipc	a5,0x1
     e0c:	fc878793          	addi	a5,a5,-56 # 1dd0 <freep>
     e10:	639c                	ld	a5,0(a5)
     e12:	fef43023          	sd	a5,-32(s0)
     e16:	fe043783          	ld	a5,-32(s0)
     e1a:	ef95                	bnez	a5,e56 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     e1c:	00001797          	auipc	a5,0x1
     e20:	fa478793          	addi	a5,a5,-92 # 1dc0 <base>
     e24:	fef43023          	sd	a5,-32(s0)
     e28:	00001797          	auipc	a5,0x1
     e2c:	fa878793          	addi	a5,a5,-88 # 1dd0 <freep>
     e30:	fe043703          	ld	a4,-32(s0)
     e34:	e398                	sd	a4,0(a5)
     e36:	00001797          	auipc	a5,0x1
     e3a:	f9a78793          	addi	a5,a5,-102 # 1dd0 <freep>
     e3e:	6398                	ld	a4,0(a5)
     e40:	00001797          	auipc	a5,0x1
     e44:	f8078793          	addi	a5,a5,-128 # 1dc0 <base>
     e48:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     e4a:	00001797          	auipc	a5,0x1
     e4e:	f7678793          	addi	a5,a5,-138 # 1dc0 <base>
     e52:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     e56:	fe043783          	ld	a5,-32(s0)
     e5a:	639c                	ld	a5,0(a5)
     e5c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     e60:	fe843783          	ld	a5,-24(s0)
     e64:	4798                	lw	a4,8(a5)
     e66:	fdc42783          	lw	a5,-36(s0)
     e6a:	2781                	sext.w	a5,a5
     e6c:	06f76863          	bltu	a4,a5,edc <malloc+0xf2>
      if(p->s.size == nunits)
     e70:	fe843783          	ld	a5,-24(s0)
     e74:	4798                	lw	a4,8(a5)
     e76:	fdc42783          	lw	a5,-36(s0)
     e7a:	2781                	sext.w	a5,a5
     e7c:	00e79963          	bne	a5,a4,e8e <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     e80:	fe843783          	ld	a5,-24(s0)
     e84:	6398                	ld	a4,0(a5)
     e86:	fe043783          	ld	a5,-32(s0)
     e8a:	e398                	sd	a4,0(a5)
     e8c:	a82d                	j	ec6 <malloc+0xdc>
      else {
        p->s.size -= nunits;
     e8e:	fe843783          	ld	a5,-24(s0)
     e92:	4798                	lw	a4,8(a5)
     e94:	fdc42783          	lw	a5,-36(s0)
     e98:	40f707bb          	subw	a5,a4,a5
     e9c:	0007871b          	sext.w	a4,a5
     ea0:	fe843783          	ld	a5,-24(s0)
     ea4:	c798                	sw	a4,8(a5)
        p += p->s.size;
     ea6:	fe843783          	ld	a5,-24(s0)
     eaa:	479c                	lw	a5,8(a5)
     eac:	1782                	slli	a5,a5,0x20
     eae:	9381                	srli	a5,a5,0x20
     eb0:	0792                	slli	a5,a5,0x4
     eb2:	fe843703          	ld	a4,-24(s0)
     eb6:	97ba                	add	a5,a5,a4
     eb8:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     ebc:	fe843783          	ld	a5,-24(s0)
     ec0:	fdc42703          	lw	a4,-36(s0)
     ec4:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     ec6:	00001797          	auipc	a5,0x1
     eca:	f0a78793          	addi	a5,a5,-246 # 1dd0 <freep>
     ece:	fe043703          	ld	a4,-32(s0)
     ed2:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     ed4:	fe843783          	ld	a5,-24(s0)
     ed8:	07c1                	addi	a5,a5,16
     eda:	a091                	j	f1e <malloc+0x134>
    }
    if(p == freep)
     edc:	00001797          	auipc	a5,0x1
     ee0:	ef478793          	addi	a5,a5,-268 # 1dd0 <freep>
     ee4:	639c                	ld	a5,0(a5)
     ee6:	fe843703          	ld	a4,-24(s0)
     eea:	02f71063          	bne	a4,a5,f0a <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     eee:	fdc42783          	lw	a5,-36(s0)
     ef2:	853e                	mv	a0,a5
     ef4:	00000097          	auipc	ra,0x0
     ef8:	e76080e7          	jalr	-394(ra) # d6a <morecore>
     efc:	fea43423          	sd	a0,-24(s0)
     f00:	fe843783          	ld	a5,-24(s0)
     f04:	e399                	bnez	a5,f0a <malloc+0x120>
        return 0;
     f06:	4781                	li	a5,0
     f08:	a819                	j	f1e <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     f0a:	fe843783          	ld	a5,-24(s0)
     f0e:	fef43023          	sd	a5,-32(s0)
     f12:	fe843783          	ld	a5,-24(s0)
     f16:	639c                	ld	a5,0(a5)
     f18:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     f1c:	b791                	j	e60 <malloc+0x76>
  }
}
     f1e:	853e                	mv	a0,a5
     f20:	70e2                	ld	ra,56(sp)
     f22:	7442                	ld	s0,48(sp)
     f24:	6121                	addi	sp,sp,64
     f26:	8082                	ret

0000000000000f28 <setjmp>:
     f28:	e100                	sd	s0,0(a0)
     f2a:	e504                	sd	s1,8(a0)
     f2c:	01253823          	sd	s2,16(a0)
     f30:	01353c23          	sd	s3,24(a0)
     f34:	03453023          	sd	s4,32(a0)
     f38:	03553423          	sd	s5,40(a0)
     f3c:	03653823          	sd	s6,48(a0)
     f40:	03753c23          	sd	s7,56(a0)
     f44:	05853023          	sd	s8,64(a0)
     f48:	05953423          	sd	s9,72(a0)
     f4c:	05a53823          	sd	s10,80(a0)
     f50:	05b53c23          	sd	s11,88(a0)
     f54:	06153023          	sd	ra,96(a0)
     f58:	06253423          	sd	sp,104(a0)
     f5c:	4501                	li	a0,0
     f5e:	8082                	ret

0000000000000f60 <longjmp>:
     f60:	6100                	ld	s0,0(a0)
     f62:	6504                	ld	s1,8(a0)
     f64:	01053903          	ld	s2,16(a0)
     f68:	01853983          	ld	s3,24(a0)
     f6c:	02053a03          	ld	s4,32(a0)
     f70:	02853a83          	ld	s5,40(a0)
     f74:	03053b03          	ld	s6,48(a0)
     f78:	03853b83          	ld	s7,56(a0)
     f7c:	04053c03          	ld	s8,64(a0)
     f80:	04853c83          	ld	s9,72(a0)
     f84:	05053d03          	ld	s10,80(a0)
     f88:	05853d83          	ld	s11,88(a0)
     f8c:	06053083          	ld	ra,96(a0)
     f90:	06853103          	ld	sp,104(a0)
     f94:	c199                	beqz	a1,f9a <longjmp_1>
     f96:	852e                	mv	a0,a1
     f98:	8082                	ret

0000000000000f9a <longjmp_1>:
     f9a:	4505                	li	a0,1
     f9c:	8082                	ret

0000000000000f9e <schedule_default>:
#define INT_MAX 2147483647
#define TIME_QUANTUM 2  // Define a base time quantum for the round-robin

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
     f9e:	715d                	addi	sp,sp,-80
     fa0:	e4a2                	sd	s0,72(sp)
     fa2:	e0a6                	sd	s1,64(sp)
     fa4:	0880                	addi	s0,sp,80
     fa6:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
     fa8:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
     fac:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     fb0:	649c                	ld	a5,8(s1)
     fb2:	639c                	ld	a5,0(a5)
     fb4:	fcf43c23          	sd	a5,-40(s0)
     fb8:	fd843783          	ld	a5,-40(s0)
     fbc:	fd878793          	addi	a5,a5,-40
     fc0:	fef43023          	sd	a5,-32(s0)
     fc4:	a81d                	j	ffa <schedule_default+0x5c>
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
     fc6:	fe843783          	ld	a5,-24(s0)
     fca:	cb89                	beqz	a5,fdc <schedule_default+0x3e>
     fcc:	fe043783          	ld	a5,-32(s0)
     fd0:	5fd8                	lw	a4,60(a5)
     fd2:	fe843783          	ld	a5,-24(s0)
     fd6:	5fdc                	lw	a5,60(a5)
     fd8:	00f75663          	bge	a4,a5,fe4 <schedule_default+0x46>
            thread_with_smallest_id = th;
     fdc:	fe043783          	ld	a5,-32(s0)
     fe0:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     fe4:	fe043783          	ld	a5,-32(s0)
     fe8:	779c                	ld	a5,40(a5)
     fea:	fcf43823          	sd	a5,-48(s0)
     fee:	fd043783          	ld	a5,-48(s0)
     ff2:	fd878793          	addi	a5,a5,-40
     ff6:	fef43023          	sd	a5,-32(s0)
     ffa:	fe043783          	ld	a5,-32(s0)
     ffe:	02878713          	addi	a4,a5,40
    1002:	649c                	ld	a5,8(s1)
    1004:	fcf711e3          	bne	a4,a5,fc6 <schedule_default+0x28>
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
    1008:	fe843783          	ld	a5,-24(s0)
    100c:	cf89                	beqz	a5,1026 <schedule_default+0x88>
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
    100e:	fe843783          	ld	a5,-24(s0)
    1012:	02878793          	addi	a5,a5,40
    1016:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
    101a:	fe843783          	ld	a5,-24(s0)
    101e:	4fbc                	lw	a5,88(a5)
    1020:	faf42c23          	sw	a5,-72(s0)
    1024:	a039                	j	1032 <schedule_default+0x94>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
    1026:	649c                	ld	a5,8(s1)
    1028:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
    102c:	4785                	li	a5,1
    102e:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
    1032:	fb043783          	ld	a5,-80(s0)
    1036:	fcf43023          	sd	a5,-64(s0)
    103a:	fb843783          	ld	a5,-72(s0)
    103e:	fcf43423          	sd	a5,-56(s0)
    1042:	4701                	li	a4,0
    1044:	fc043703          	ld	a4,-64(s0)
    1048:	4781                	li	a5,0
    104a:	fc843783          	ld	a5,-56(s0)
    104e:	863a                	mv	a2,a4
    1050:	86be                	mv	a3,a5
    1052:	8732                	mv	a4,a2
    1054:	87b6                	mv	a5,a3
}
    1056:	853a                	mv	a0,a4
    1058:	85be                	mv	a1,a5
    105a:	6426                	ld	s0,72(sp)
    105c:	6486                	ld	s1,64(sp)
    105e:	6161                	addi	sp,sp,80
    1060:	8082                	ret

0000000000001062 <find_next_release_time>:

int find_next_release_time(struct list_head *release_queue, int current_time) {
    1062:	7139                	addi	sp,sp,-64
    1064:	fc22                	sd	s0,56(sp)
    1066:	0080                	addi	s0,sp,64
    1068:	fca43423          	sd	a0,-56(s0)
    106c:	87ae                	mv	a5,a1
    106e:	fcf42223          	sw	a5,-60(s0)
    struct release_queue_entry *next_release = NULL;
    1072:	fe043423          	sd	zero,-24(s0)
    int next_release_time = INT_MAX;
    1076:	800007b7          	lui	a5,0x80000
    107a:	fff7c793          	not	a5,a5
    107e:	fef42223          	sw	a5,-28(s0)

    list_for_each_entry(next_release, release_queue, thread_list) {
    1082:	fc843783          	ld	a5,-56(s0)
    1086:	639c                	ld	a5,0(a5)
    1088:	fcf43c23          	sd	a5,-40(s0)
    108c:	fd843783          	ld	a5,-40(s0)
    1090:	17e1                	addi	a5,a5,-8
    1092:	fef43423          	sd	a5,-24(s0)
    1096:	a081                	j	10d6 <find_next_release_time+0x74>
        if (next_release->release_time > current_time && next_release->release_time < next_release_time) {
    1098:	fe843783          	ld	a5,-24(s0)
    109c:	4f98                	lw	a4,24(a5)
    109e:	fc442783          	lw	a5,-60(s0)
    10a2:	2781                	sext.w	a5,a5
    10a4:	00e7df63          	bge	a5,a4,10c2 <find_next_release_time+0x60>
    10a8:	fe843783          	ld	a5,-24(s0)
    10ac:	4f98                	lw	a4,24(a5)
    10ae:	fe442783          	lw	a5,-28(s0)
    10b2:	2781                	sext.w	a5,a5
    10b4:	00f75763          	bge	a4,a5,10c2 <find_next_release_time+0x60>
            next_release_time = next_release->release_time;
    10b8:	fe843783          	ld	a5,-24(s0)
    10bc:	4f9c                	lw	a5,24(a5)
    10be:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(next_release, release_queue, thread_list) {
    10c2:	fe843783          	ld	a5,-24(s0)
    10c6:	679c                	ld	a5,8(a5)
    10c8:	fcf43823          	sd	a5,-48(s0)
    10cc:	fd043783          	ld	a5,-48(s0)
    10d0:	17e1                	addi	a5,a5,-8
    10d2:	fef43423          	sd	a5,-24(s0)
    10d6:	fe843783          	ld	a5,-24(s0)
    10da:	07a1                	addi	a5,a5,8
    10dc:	fc843703          	ld	a4,-56(s0)
    10e0:	faf71ce3          	bne	a4,a5,1098 <find_next_release_time+0x36>
        }
    }

    if (next_release_time == INT_MAX)
    10e4:	fe442783          	lw	a5,-28(s0)
    10e8:	0007871b          	sext.w	a4,a5
    10ec:	800007b7          	lui	a5,0x80000
    10f0:	fff7c793          	not	a5,a5
    10f4:	00f71463          	bne	a4,a5,10fc <find_next_release_time+0x9a>
        return -1; // No threads in the release queue
    10f8:	57fd                	li	a5,-1
    10fa:	a801                	j	110a <find_next_release_time+0xa8>

    return next_release_time - current_time;
    10fc:	fe442703          	lw	a4,-28(s0)
    1100:	fc442783          	lw	a5,-60(s0)
    1104:	40f707bb          	subw	a5,a4,a5
    1108:	2781                	sext.w	a5,a5
}
    110a:	853e                	mv	a0,a5
    110c:	7462                	ld	s0,56(sp)
    110e:	6121                	addi	sp,sp,64
    1110:	8082                	ret

0000000000001112 <schedule_wrr>:

/* MP3 Part 1 - Non-Real-Time Scheduling */
/* Weighted-Round-Robin Scheduling */
struct threads_sched_result schedule_wrr(struct threads_sched_args args)
{
    1112:	7119                	addi	sp,sp,-128
    1114:	fc86                	sd	ra,120(sp)
    1116:	f8a2                	sd	s0,112(sp)
    1118:	f4a6                	sd	s1,104(sp)
    111a:	f0ca                	sd	s2,96(sp)
    111c:	ecce                	sd	s3,88(sp)
    111e:	0100                	addi	s0,sp,128
    1120:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the weighted round-robin scheduling algorithm
    static struct thread *last_thread = NULL;
    struct thread *selected_thread = NULL;
    1122:	fc043423          	sd	zero,-56(s0)
    struct thread *candidate = NULL;
    1126:	fc043023          	sd	zero,-64(s0)

    // If last_thread is NULL or its remaining time is zero, reset the selection process
    if (last_thread == NULL || last_thread->remaining_time <= 0) {
    112a:	00001797          	auipc	a5,0x1
    112e:	cae78793          	addi	a5,a5,-850 # 1dd8 <last_thread.1239>
    1132:	639c                	ld	a5,0(a5)
    1134:	cb89                	beqz	a5,1146 <schedule_wrr+0x34>
    1136:	00001797          	auipc	a5,0x1
    113a:	ca278793          	addi	a5,a5,-862 # 1dd8 <last_thread.1239>
    113e:	639c                	ld	a5,0(a5)
    1140:	4fbc                	lw	a5,88(a5)
    1142:	00f04863          	bgtz	a5,1152 <schedule_wrr+0x40>
        last_thread = NULL;
    1146:	00001797          	auipc	a5,0x1
    114a:	c9278793          	addi	a5,a5,-878 # 1dd8 <last_thread.1239>
    114e:	0007b023          	sd	zero,0(a5)
    }

    // Find the first thread that is ready to run
    list_for_each_entry(candidate, args.run_queue, thread_list) {
    1152:	649c                	ld	a5,8(s1)
    1154:	639c                	ld	a5,0(a5)
    1156:	faf43823          	sd	a5,-80(s0)
    115a:	fb043783          	ld	a5,-80(s0)
    115e:	fd878793          	addi	a5,a5,-40
    1162:	fcf43023          	sd	a5,-64(s0)
    1166:	a0a9                	j	11b0 <schedule_wrr+0x9e>
        if (!last_thread && candidate->remaining_time > 0)
    1168:	00001797          	auipc	a5,0x1
    116c:	c7078793          	addi	a5,a5,-912 # 1dd8 <last_thread.1239>
    1170:	639c                	ld	a5,0(a5)
    1172:	eb91                	bnez	a5,1186 <schedule_wrr+0x74>
    1174:	fc043783          	ld	a5,-64(s0)
    1178:	4fbc                	lw	a5,88(a5)
    117a:	00f05663          	blez	a5,1186 <schedule_wrr+0x74>
            selected_thread = candidate;
    117e:	fc043783          	ld	a5,-64(s0)
    1182:	fcf43423          	sd	a5,-56(s0)
        if (candidate->remaining_time > 0) {
    1186:	fc043783          	ld	a5,-64(s0)
    118a:	4fbc                	lw	a5,88(a5)
    118c:	00f05763          	blez	a5,119a <schedule_wrr+0x88>
            selected_thread = candidate;
    1190:	fc043783          	ld	a5,-64(s0)
    1194:	fcf43423          	sd	a5,-56(s0)
            break;
    1198:	a01d                	j	11be <schedule_wrr+0xac>
    list_for_each_entry(candidate, args.run_queue, thread_list) {
    119a:	fc043783          	ld	a5,-64(s0)
    119e:	779c                	ld	a5,40(a5)
    11a0:	faf43423          	sd	a5,-88(s0)
    11a4:	fa843783          	ld	a5,-88(s0)
    11a8:	fd878793          	addi	a5,a5,-40
    11ac:	fcf43023          	sd	a5,-64(s0)
    11b0:	fc043783          	ld	a5,-64(s0)
    11b4:	02878713          	addi	a4,a5,40
    11b8:	649c                	ld	a5,8(s1)
    11ba:	faf717e3          	bne	a4,a5,1168 <schedule_wrr+0x56>
        }
    }

    // Fall back to the last_thread if no other thread is selected and it still has remaining time
    if (!selected_thread && last_thread && last_thread->remaining_time > 0) {
    11be:	fc843783          	ld	a5,-56(s0)
    11c2:	e795                	bnez	a5,11ee <schedule_wrr+0xdc>
    11c4:	00001797          	auipc	a5,0x1
    11c8:	c1478793          	addi	a5,a5,-1004 # 1dd8 <last_thread.1239>
    11cc:	639c                	ld	a5,0(a5)
    11ce:	c385                	beqz	a5,11ee <schedule_wrr+0xdc>
    11d0:	00001797          	auipc	a5,0x1
    11d4:	c0878793          	addi	a5,a5,-1016 # 1dd8 <last_thread.1239>
    11d8:	639c                	ld	a5,0(a5)
    11da:	4fbc                	lw	a5,88(a5)
    11dc:	00f05963          	blez	a5,11ee <schedule_wrr+0xdc>
        selected_thread = last_thread;
    11e0:	00001797          	auipc	a5,0x1
    11e4:	bf878793          	addi	a5,a5,-1032 # 1dd8 <last_thread.1239>
    11e8:	639c                	ld	a5,0(a5)
    11ea:	fcf43423          	sd	a5,-56(s0)
    }

    // Set the scheduling result
    if (selected_thread) {
    11ee:	fc843783          	ld	a5,-56(s0)
    11f2:	c7b9                	beqz	a5,1240 <schedule_wrr+0x12e>
        int time_slice = selected_thread->weight * TIME_QUANTUM;
    11f4:	fc843783          	ld	a5,-56(s0)
    11f8:	47bc                	lw	a5,72(a5)
    11fa:	0017979b          	slliw	a5,a5,0x1
    11fe:	faf42e23          	sw	a5,-68(s0)
        if (time_slice > selected_thread->remaining_time) {
    1202:	fc843783          	ld	a5,-56(s0)
    1206:	4fb8                	lw	a4,88(a5)
    1208:	fbc42783          	lw	a5,-68(s0)
    120c:	2781                	sext.w	a5,a5
    120e:	00f75763          	bge	a4,a5,121c <schedule_wrr+0x10a>
            time_slice = selected_thread->remaining_time;
    1212:	fc843783          	ld	a5,-56(s0)
    1216:	4fbc                	lw	a5,88(a5)
    1218:	faf42e23          	sw	a5,-68(s0)
        }
        r.scheduled_thread_list_member = &selected_thread->thread_list;
    121c:	fc843783          	ld	a5,-56(s0)
    1220:	02878793          	addi	a5,a5,40
    1224:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = time_slice;
    1228:	fbc42783          	lw	a5,-68(s0)
    122c:	f8f42823          	sw	a5,-112(s0)
        last_thread = selected_thread;  // Update the last run thread
    1230:	00001797          	auipc	a5,0x1
    1234:	ba878793          	addi	a5,a5,-1112 # 1dd8 <last_thread.1239>
    1238:	fc843703          	ld	a4,-56(s0)
    123c:	e398                	sd	a4,0(a5)
    123e:	a839                	j	125c <schedule_wrr+0x14a>
    } else {
        // Idle if no suitable thread is found
        r.scheduled_thread_list_member = args.run_queue;
    1240:	649c                	ld	a5,8(s1)
    1242:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    1246:	689c                	ld	a5,16(s1)
    1248:	4098                	lw	a4,0(s1)
    124a:	85ba                	mv	a1,a4
    124c:	853e                	mv	a0,a5
    124e:	00000097          	auipc	ra,0x0
    1252:	e14080e7          	jalr	-492(ra) # 1062 <find_next_release_time>
    1256:	87aa                	mv	a5,a0
    1258:	f8f42823          	sw	a5,-112(s0)
    }

    return r;
    125c:	f8843783          	ld	a5,-120(s0)
    1260:	f8f43c23          	sd	a5,-104(s0)
    1264:	f9043783          	ld	a5,-112(s0)
    1268:	faf43023          	sd	a5,-96(s0)
    126c:	4701                	li	a4,0
    126e:	f9843703          	ld	a4,-104(s0)
    1272:	4781                	li	a5,0
    1274:	fa043783          	ld	a5,-96(s0)
    1278:	893a                	mv	s2,a4
    127a:	89be                	mv	s3,a5
    127c:	874a                	mv	a4,s2
    127e:	87ce                	mv	a5,s3
}
    1280:	853a                	mv	a0,a4
    1282:	85be                	mv	a1,a5
    1284:	70e6                	ld	ra,120(sp)
    1286:	7446                	ld	s0,112(sp)
    1288:	74a6                	ld	s1,104(sp)
    128a:	7906                	ld	s2,96(sp)
    128c:	69e6                	ld	s3,88(sp)
    128e:	6109                	addi	sp,sp,128
    1290:	8082                	ret

0000000000001292 <find_earliest_impactful_release_time>:


int find_earliest_impactful_release_time(struct list_head *release_queue, struct list_head *run_queue, int current_time) {
    1292:	7159                	addi	sp,sp,-112
    1294:	f4a2                	sd	s0,104(sp)
    1296:	1880                	addi	s0,sp,112
    1298:	faa43423          	sd	a0,-88(s0)
    129c:	fab43023          	sd	a1,-96(s0)
    12a0:	87b2                	mv	a5,a2
    12a2:	f8f42e23          	sw	a5,-100(s0)
    struct release_queue_entry *entry;
    int earliest_impactful_time = INT_MAX;
    12a6:	800007b7          	lui	a5,0x80000
    12aa:	fff7c793          	not	a5,a5
    12ae:	fef42223          	sw	a5,-28(s0)
    int shortest_current_time = INT_MAX;
    12b2:	800007b7          	lui	a5,0x80000
    12b6:	fff7c793          	not	a5,a5
    12ba:	fef42023          	sw	a5,-32(s0)
    // Find the shortest remaining time among currently running tasks
    struct thread *t;
    list_for_each_entry(t, run_queue, thread_list) {
    12be:	fa043783          	ld	a5,-96(s0)
    12c2:	639c                	ld	a5,0(a5)
    12c4:	fcf43823          	sd	a5,-48(s0)
    12c8:	fd043783          	ld	a5,-48(s0)
    12cc:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffdc30>
    12d0:	fcf43c23          	sd	a5,-40(s0)
    12d4:	a80d                	j	1306 <find_earliest_impactful_release_time+0x74>
        if (t->remaining_time < shortest_current_time) {
    12d6:	fd843783          	ld	a5,-40(s0)
    12da:	4fb8                	lw	a4,88(a5)
    12dc:	fe042783          	lw	a5,-32(s0)
    12e0:	2781                	sext.w	a5,a5
    12e2:	00f75763          	bge	a4,a5,12f0 <find_earliest_impactful_release_time+0x5e>
            shortest_current_time = t->remaining_time;
    12e6:	fd843783          	ld	a5,-40(s0)
    12ea:	4fbc                	lw	a5,88(a5)
    12ec:	fef42023          	sw	a5,-32(s0)
    list_for_each_entry(t, run_queue, thread_list) {
    12f0:	fd843783          	ld	a5,-40(s0)
    12f4:	779c                	ld	a5,40(a5)
    12f6:	faf43c23          	sd	a5,-72(s0)
    12fa:	fb843783          	ld	a5,-72(s0)
    12fe:	fd878793          	addi	a5,a5,-40
    1302:	fcf43c23          	sd	a5,-40(s0)
    1306:	fd843783          	ld	a5,-40(s0)
    130a:	02878793          	addi	a5,a5,40
    130e:	fa043703          	ld	a4,-96(s0)
    1312:	fcf712e3          	bne	a4,a5,12d6 <find_earliest_impactful_release_time+0x44>
        }
    }

    // Check the release queue for the next task that might preempt the current shortest job
    list_for_each_entry(entry, release_queue, thread_list) {
    1316:	fa843783          	ld	a5,-88(s0)
    131a:	639c                	ld	a5,0(a5)
    131c:	fcf43423          	sd	a5,-56(s0)
    1320:	fc843783          	ld	a5,-56(s0)
    1324:	17e1                	addi	a5,a5,-8
    1326:	fef43423          	sd	a5,-24(s0)
    132a:	a889                	j	137c <find_earliest_impactful_release_time+0xea>
        if (entry->release_time > current_time && entry->release_time < earliest_impactful_time) {
    132c:	fe843783          	ld	a5,-24(s0)
    1330:	4f98                	lw	a4,24(a5)
    1332:	f9c42783          	lw	a5,-100(s0)
    1336:	2781                	sext.w	a5,a5
    1338:	02e7d863          	bge	a5,a4,1368 <find_earliest_impactful_release_time+0xd6>
    133c:	fe843783          	ld	a5,-24(s0)
    1340:	4f98                	lw	a4,24(a5)
    1342:	fe442783          	lw	a5,-28(s0)
    1346:	2781                	sext.w	a5,a5
    1348:	02f75063          	bge	a4,a5,1368 <find_earliest_impactful_release_time+0xd6>
            if (entry->thrd->remaining_time < shortest_current_time) {
    134c:	fe843783          	ld	a5,-24(s0)
    1350:	639c                	ld	a5,0(a5)
    1352:	4fb8                	lw	a4,88(a5)
    1354:	fe042783          	lw	a5,-32(s0)
    1358:	2781                	sext.w	a5,a5
    135a:	00f75763          	bge	a4,a5,1368 <find_earliest_impactful_release_time+0xd6>
                earliest_impactful_time = entry->release_time;
    135e:	fe843783          	ld	a5,-24(s0)
    1362:	4f9c                	lw	a5,24(a5)
    1364:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(entry, release_queue, thread_list) {
    1368:	fe843783          	ld	a5,-24(s0)
    136c:	679c                	ld	a5,8(a5)
    136e:	fcf43023          	sd	a5,-64(s0)
    1372:	fc043783          	ld	a5,-64(s0)
    1376:	17e1                	addi	a5,a5,-8
    1378:	fef43423          	sd	a5,-24(s0)
    137c:	fe843783          	ld	a5,-24(s0)
    1380:	07a1                	addi	a5,a5,8
    1382:	fa843703          	ld	a4,-88(s0)
    1386:	faf713e3          	bne	a4,a5,132c <find_earliest_impactful_release_time+0x9a>
            }
        }
    }

    // Calculate the difference between the current time and the earliest impactful release time
    return earliest_impactful_time == INT_MAX ? -1 : earliest_impactful_time - current_time;
    138a:	fe442783          	lw	a5,-28(s0)
    138e:	0007871b          	sext.w	a4,a5
    1392:	800007b7          	lui	a5,0x80000
    1396:	fff7c793          	not	a5,a5
    139a:	00f70a63          	beq	a4,a5,13ae <find_earliest_impactful_release_time+0x11c>
    139e:	fe442703          	lw	a4,-28(s0)
    13a2:	f9c42783          	lw	a5,-100(s0)
    13a6:	40f707bb          	subw	a5,a4,a5
    13aa:	2781                	sext.w	a5,a5
    13ac:	a011                	j	13b0 <find_earliest_impactful_release_time+0x11e>
    13ae:	57fd                	li	a5,-1
}
    13b0:	853e                	mv	a0,a5
    13b2:	7426                	ld	s0,104(sp)
    13b4:	6165                	addi	sp,sp,112
    13b6:	8082                	ret

00000000000013b8 <schedule_sjf>:


struct threads_sched_result schedule_sjf(struct threads_sched_args args) {
    13b8:	7119                	addi	sp,sp,-128
    13ba:	fc86                	sd	ra,120(sp)
    13bc:	f8a2                	sd	s0,112(sp)
    13be:	f4a6                	sd	s1,104(sp)
    13c0:	f0ca                	sd	s2,96(sp)
    13c2:	ecce                	sd	s3,88(sp)
    13c4:	0100                	addi	s0,sp,128
    13c6:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *shortest_job = NULL;
    13c8:	fc043423          	sd	zero,-56(s0)
    struct thread *current;
    int shortest_time = INT_MAX;
    13cc:	800007b7          	lui	a5,0x80000
    13d0:	fff7c793          	not	a5,a5
    13d4:	faf42e23          	sw	a5,-68(s0)
    int earliest_impactful_time = find_earliest_impactful_release_time(args.release_queue, args.run_queue, args.current_time);
    13d8:	689c                	ld	a5,16(s1)
    13da:	6498                	ld	a4,8(s1)
    13dc:	4094                	lw	a3,0(s1)
    13de:	8636                	mv	a2,a3
    13e0:	85ba                	mv	a1,a4
    13e2:	853e                	mv	a0,a5
    13e4:	00000097          	auipc	ra,0x0
    13e8:	eae080e7          	jalr	-338(ra) # 1292 <find_earliest_impactful_release_time>
    13ec:	87aa                	mv	a5,a0
    13ee:	faf42a23          	sw	a5,-76(s0)

    // Determine the shortest job from the run queue
    list_for_each_entry(current, args.run_queue, thread_list) {
    13f2:	649c                	ld	a5,8(s1)
    13f4:	639c                	ld	a5,0(a5)
    13f6:	faf43423          	sd	a5,-88(s0)
    13fa:	fa843783          	ld	a5,-88(s0)
    13fe:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffdc30>
    1402:	fcf43023          	sd	a5,-64(s0)
    1406:	a82d                	j	1440 <schedule_sjf+0x88>
        if (current->remaining_time < shortest_time) {
    1408:	fc043783          	ld	a5,-64(s0)
    140c:	4fb8                	lw	a4,88(a5)
    140e:	fbc42783          	lw	a5,-68(s0)
    1412:	2781                	sext.w	a5,a5
    1414:	00f75b63          	bge	a4,a5,142a <schedule_sjf+0x72>
            shortest_time = current->remaining_time;
    1418:	fc043783          	ld	a5,-64(s0)
    141c:	4fbc                	lw	a5,88(a5)
    141e:	faf42e23          	sw	a5,-68(s0)
            shortest_job = current;
    1422:	fc043783          	ld	a5,-64(s0)
    1426:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(current, args.run_queue, thread_list) {
    142a:	fc043783          	ld	a5,-64(s0)
    142e:	779c                	ld	a5,40(a5)
    1430:	faf43023          	sd	a5,-96(s0)
    1434:	fa043783          	ld	a5,-96(s0)
    1438:	fd878793          	addi	a5,a5,-40
    143c:	fcf43023          	sd	a5,-64(s0)
    1440:	fc043783          	ld	a5,-64(s0)
    1444:	02878713          	addi	a4,a5,40
    1448:	649c                	ld	a5,8(s1)
    144a:	faf71fe3          	bne	a4,a5,1408 <schedule_sjf+0x50>
        }
    }

    if (shortest_job) {
    144e:	fc843783          	ld	a5,-56(s0)
    1452:	c7a1                	beqz	a5,149a <schedule_sjf+0xe2>
        int time_to_allocate = shortest_job->remaining_time;
    1454:	fc843783          	ld	a5,-56(s0)
    1458:	4fbc                	lw	a5,88(a5)
    145a:	faf42c23          	sw	a5,-72(s0)
        // Reduce the time slice if an impactful task is arriving sooner
        if (earliest_impactful_time != -1 && earliest_impactful_time < time_to_allocate) {
    145e:	fb442783          	lw	a5,-76(s0)
    1462:	0007871b          	sext.w	a4,a5
    1466:	57fd                	li	a5,-1
    1468:	00f70e63          	beq	a4,a5,1484 <schedule_sjf+0xcc>
    146c:	fb442703          	lw	a4,-76(s0)
    1470:	fb842783          	lw	a5,-72(s0)
    1474:	2701                	sext.w	a4,a4
    1476:	2781                	sext.w	a5,a5
    1478:	00f75663          	bge	a4,a5,1484 <schedule_sjf+0xcc>
            time_to_allocate = earliest_impactful_time;
    147c:	fb442783          	lw	a5,-76(s0)
    1480:	faf42c23          	sw	a5,-72(s0)
        }

        r.scheduled_thread_list_member = &shortest_job->thread_list;
    1484:	fc843783          	ld	a5,-56(s0)
    1488:	02878793          	addi	a5,a5,40
    148c:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = time_to_allocate;
    1490:	fb842783          	lw	a5,-72(s0)
    1494:	f8f42423          	sw	a5,-120(s0)
    1498:	a80d                	j	14ca <schedule_sjf+0x112>
    } else {
        // If no current tasks are ready, wait for the next impactful task
        r.scheduled_thread_list_member = args.run_queue;
    149a:	649c                	ld	a5,8(s1)
    149c:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = earliest_impactful_time != -1 ? earliest_impactful_time : find_next_release_time(args.release_queue, args.current_time);
    14a0:	fb442783          	lw	a5,-76(s0)
    14a4:	0007871b          	sext.w	a4,a5
    14a8:	57fd                	li	a5,-1
    14aa:	00f71c63          	bne	a4,a5,14c2 <schedule_sjf+0x10a>
    14ae:	689c                	ld	a5,16(s1)
    14b0:	4098                	lw	a4,0(s1)
    14b2:	85ba                	mv	a1,a4
    14b4:	853e                	mv	a0,a5
    14b6:	00000097          	auipc	ra,0x0
    14ba:	bac080e7          	jalr	-1108(ra) # 1062 <find_next_release_time>
    14be:	87aa                	mv	a5,a0
    14c0:	a019                	j	14c6 <schedule_sjf+0x10e>
    14c2:	fb442783          	lw	a5,-76(s0)
    14c6:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    14ca:	f8043783          	ld	a5,-128(s0)
    14ce:	f8f43823          	sd	a5,-112(s0)
    14d2:	f8843783          	ld	a5,-120(s0)
    14d6:	f8f43c23          	sd	a5,-104(s0)
    14da:	4701                	li	a4,0
    14dc:	f9043703          	ld	a4,-112(s0)
    14e0:	4781                	li	a5,0
    14e2:	f9843783          	ld	a5,-104(s0)
    14e6:	893a                	mv	s2,a4
    14e8:	89be                	mv	s3,a5
    14ea:	874a                	mv	a4,s2
    14ec:	87ce                	mv	a5,s3
}
    14ee:	853a                	mv	a0,a4
    14f0:	85be                	mv	a1,a5
    14f2:	70e6                	ld	ra,120(sp)
    14f4:	7446                	ld	s0,112(sp)
    14f6:	74a6                	ld	s1,104(sp)
    14f8:	7906                	ld	s2,96(sp)
    14fa:	69e6                	ld	s3,88(sp)
    14fc:	6109                	addi	sp,sp,128
    14fe:	8082                	ret

0000000000001500 <min>:

int min(int a, int b) {
    1500:	1101                	addi	sp,sp,-32
    1502:	ec22                	sd	s0,24(sp)
    1504:	1000                	addi	s0,sp,32
    1506:	87aa                	mv	a5,a0
    1508:	872e                	mv	a4,a1
    150a:	fef42623          	sw	a5,-20(s0)
    150e:	87ba                	mv	a5,a4
    1510:	fef42423          	sw	a5,-24(s0)
    return (a < b) ? a : b;
    1514:	fec42603          	lw	a2,-20(s0)
    1518:	fe842783          	lw	a5,-24(s0)
    151c:	0007869b          	sext.w	a3,a5
    1520:	0006071b          	sext.w	a4,a2
    1524:	00d75363          	bge	a4,a3,152a <min+0x2a>
    1528:	87b2                	mv	a5,a2
    152a:	2781                	sext.w	a5,a5
}
    152c:	853e                	mv	a0,a5
    152e:	6462                	ld	s0,24(sp)
    1530:	6105                	addi	sp,sp,32
    1532:	8082                	ret

0000000000001534 <schedule_lst>:

/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args) {
    1534:	7131                	addi	sp,sp,-192
    1536:	fd06                	sd	ra,184(sp)
    1538:	f922                	sd	s0,176(sp)
    153a:	f526                	sd	s1,168(sp)
    153c:	f14a                	sd	s2,160(sp)
    153e:	ed4e                	sd	s3,152(sp)
    1540:	0180                	addi	s0,sp,192
    1542:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *min_slack_thread = NULL;
    1544:	fc043423          	sd	zero,-56(s0)
    int min_slack_time = INT_MAX;
    1548:	800007b7          	lui	a5,0x80000
    154c:	fff7c793          	not	a5,a5
    1550:	fcf42223          	sw	a5,-60(s0)
    struct thread *t;
    // int ddl;
    // Determine the thread with the minimum slack time
    list_for_each_entry(t, args.run_queue, thread_list) {
    1554:	649c                	ld	a5,8(s1)
    1556:	639c                	ld	a5,0(a5)
    1558:	faf43023          	sd	a5,-96(s0)
    155c:	fa043783          	ld	a5,-96(s0)
    1560:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffdc30>
    1564:	faf43c23          	sd	a5,-72(s0)
    1568:	a069                	j	15f2 <schedule_lst+0xbe>
        int slack_time = t->current_deadline - args.current_time - t->remaining_time;
    156a:	fb843783          	ld	a5,-72(s0)
    156e:	4ff8                	lw	a4,92(a5)
    1570:	409c                	lw	a5,0(s1)
    1572:	40f707bb          	subw	a5,a4,a5
    1576:	0007871b          	sext.w	a4,a5
    157a:	fb843783          	ld	a5,-72(s0)
    157e:	4fbc                	lw	a5,88(a5)
    1580:	40f707bb          	subw	a5,a4,a5
    1584:	f6f42a23          	sw	a5,-140(s0)
        if (slack_time < min_slack_time || (slack_time == min_slack_time && t->ID < (min_slack_thread ? min_slack_thread->ID : INT_MAX))) {
    1588:	f7442703          	lw	a4,-140(s0)
    158c:	fc442783          	lw	a5,-60(s0)
    1590:	2701                	sext.w	a4,a4
    1592:	2781                	sext.w	a5,a5
    1594:	02f74c63          	blt	a4,a5,15cc <schedule_lst+0x98>
    1598:	f7442703          	lw	a4,-140(s0)
    159c:	fc442783          	lw	a5,-60(s0)
    15a0:	2701                	sext.w	a4,a4
    15a2:	2781                	sext.w	a5,a5
    15a4:	02f71c63          	bne	a4,a5,15dc <schedule_lst+0xa8>
    15a8:	fb843783          	ld	a5,-72(s0)
    15ac:	5fd4                	lw	a3,60(a5)
    15ae:	fc843783          	ld	a5,-56(s0)
    15b2:	c789                	beqz	a5,15bc <schedule_lst+0x88>
    15b4:	fc843783          	ld	a5,-56(s0)
    15b8:	5fdc                	lw	a5,60(a5)
    15ba:	a029                	j	15c4 <schedule_lst+0x90>
    15bc:	800007b7          	lui	a5,0x80000
    15c0:	fff7c793          	not	a5,a5
    15c4:	873e                	mv	a4,a5
    15c6:	87b6                	mv	a5,a3
    15c8:	00e7da63          	bge	a5,a4,15dc <schedule_lst+0xa8>
            min_slack_thread = t;
    15cc:	fb843783          	ld	a5,-72(s0)
    15d0:	fcf43423          	sd	a5,-56(s0)
            min_slack_time = slack_time;
    15d4:	f7442783          	lw	a5,-140(s0)
    15d8:	fcf42223          	sw	a5,-60(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    15dc:	fb843783          	ld	a5,-72(s0)
    15e0:	779c                	ld	a5,40(a5)
    15e2:	f6f43423          	sd	a5,-152(s0)
    15e6:	f6843783          	ld	a5,-152(s0)
    15ea:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffdc30>
    15ee:	faf43c23          	sd	a5,-72(s0)
    15f2:	fb843783          	ld	a5,-72(s0)
    15f6:	02878713          	addi	a4,a5,40
    15fa:	649c                	ld	a5,8(s1)
    15fc:	f6f717e3          	bne	a4,a5,156a <schedule_lst+0x36>
        }
    }

    // Calculate the next event time, initially very large
    int next_significant_event_time = INT_MAX;
    1600:	800007b7          	lui	a5,0x80000
    1604:	fff7c793          	not	a5,a5
    1608:	faf42a23          	sw	a5,-76(s0)

    // Analyze each upcoming release to determine if and when they should preempt the current thread
    struct release_queue_entry *entry;
    list_for_each_entry(entry, args.release_queue, thread_list) {
    160c:	689c                	ld	a5,16(s1)
    160e:	639c                	ld	a5,0(a5)
    1610:	f8f43c23          	sd	a5,-104(s0)
    1614:	f9843783          	ld	a5,-104(s0)
    1618:	17e1                	addi	a5,a5,-8
    161a:	faf43423          	sd	a5,-88(s0)
    161e:	a0f1                	j	16ea <schedule_lst+0x1b6>
        if (entry->release_time > args.current_time) {
    1620:	fa843783          	ld	a5,-88(s0)
    1624:	4f98                	lw	a4,24(a5)
    1626:	409c                	lw	a5,0(s1)
    1628:	0ae7d763          	bge	a5,a4,16d6 <schedule_lst+0x1a2>
            struct thread *upcoming_thread = entry->thrd;
    162c:	fa843783          	ld	a5,-88(s0)
    1630:	639c                	ld	a5,0(a5)
    1632:	f8f43423          	sd	a5,-120(s0)
            int upcoming_slack_time = upcoming_thread->current_deadline - entry->release_time - upcoming_thread->remaining_time;
    1636:	f8843783          	ld	a5,-120(s0)
    163a:	4ff8                	lw	a4,92(a5)
    163c:	fa843783          	ld	a5,-88(s0)
    1640:	4f9c                	lw	a5,24(a5)
    1642:	40f707bb          	subw	a5,a4,a5
    1646:	0007871b          	sext.w	a4,a5
    164a:	f8843783          	ld	a5,-120(s0)
    164e:	4fbc                	lw	a5,88(a5)
    1650:	40f707bb          	subw	a5,a4,a5
    1654:	f8f42223          	sw	a5,-124(s0)
            // Check if this upcoming thread will impose an earlier preemption due to tighter slack time
            if (upcoming_slack_time < min_slack_time) {
    1658:	f8442703          	lw	a4,-124(s0)
    165c:	fc442783          	lw	a5,-60(s0)
    1660:	2701                	sext.w	a4,a4
    1662:	2781                	sext.w	a5,a5
    1664:	02f75163          	bge	a4,a5,1686 <schedule_lst+0x152>
                next_significant_event_time = min(next_significant_event_time, entry->release_time);
    1668:	fa843783          	ld	a5,-88(s0)
    166c:	4f98                	lw	a4,24(a5)
    166e:	fb442783          	lw	a5,-76(s0)
    1672:	85ba                	mv	a1,a4
    1674:	853e                	mv	a0,a5
    1676:	00000097          	auipc	ra,0x0
    167a:	e8a080e7          	jalr	-374(ra) # 1500 <min>
    167e:	87aa                	mv	a5,a0
    1680:	faf42a23          	sw	a5,-76(s0)
    1684:	a889                	j	16d6 <schedule_lst+0x1a2>
            } else if (upcoming_slack_time == min_slack_time && upcoming_thread->ID < (min_slack_thread ? min_slack_thread->ID : INT_MAX))
    1686:	f8442703          	lw	a4,-124(s0)
    168a:	fc442783          	lw	a5,-60(s0)
    168e:	2701                	sext.w	a4,a4
    1690:	2781                	sext.w	a5,a5
    1692:	04f71263          	bne	a4,a5,16d6 <schedule_lst+0x1a2>
    1696:	f8843783          	ld	a5,-120(s0)
    169a:	5fd4                	lw	a3,60(a5)
    169c:	fc843783          	ld	a5,-56(s0)
    16a0:	c789                	beqz	a5,16aa <schedule_lst+0x176>
    16a2:	fc843783          	ld	a5,-56(s0)
    16a6:	5fdc                	lw	a5,60(a5)
    16a8:	a029                	j	16b2 <schedule_lst+0x17e>
    16aa:	800007b7          	lui	a5,0x80000
    16ae:	fff7c793          	not	a5,a5
    16b2:	873e                	mv	a4,a5
    16b4:	87b6                	mv	a5,a3
    16b6:	02e7d063          	bge	a5,a4,16d6 <schedule_lst+0x1a2>
                next_significant_event_time = min(next_significant_event_time, entry->release_time);
    16ba:	fa843783          	ld	a5,-88(s0)
    16be:	4f98                	lw	a4,24(a5)
    16c0:	fb442783          	lw	a5,-76(s0)
    16c4:	85ba                	mv	a1,a4
    16c6:	853e                	mv	a0,a5
    16c8:	00000097          	auipc	ra,0x0
    16cc:	e38080e7          	jalr	-456(ra) # 1500 <min>
    16d0:	87aa                	mv	a5,a0
    16d2:	faf42a23          	sw	a5,-76(s0)
    list_for_each_entry(entry, args.release_queue, thread_list) {
    16d6:	fa843783          	ld	a5,-88(s0)
    16da:	679c                	ld	a5,8(a5)
    16dc:	f6f43c23          	sd	a5,-136(s0)
    16e0:	f7843783          	ld	a5,-136(s0)
    16e4:	17e1                	addi	a5,a5,-8
    16e6:	faf43423          	sd	a5,-88(s0)
    16ea:	fa843783          	ld	a5,-88(s0)
    16ee:	00878713          	addi	a4,a5,8 # ffffffff80000008 <__global_pointer$+0xffffffff7fffdc60>
    16f2:	689c                	ld	a5,16(s1)
    16f4:	f2f716e3          	bne	a4,a5,1620 <schedule_lst+0xec>
        }
    }

    // Decide the allocated time based on current minimum slack or upcoming preemption needs
    if (min_slack_thread) {
    16f8:	fc843783          	ld	a5,-56(s0)
    16fc:	c7b5                	beqz	a5,1768 <schedule_lst+0x234>
        // Check if the thread has missed its deadline
        if (args.current_time >= min_slack_thread->current_deadline && min_slack_thread->remaining_time > 0) {
    16fe:	4098                	lw	a4,0(s1)
    1700:	fc843783          	ld	a5,-56(s0)
    1704:	4ffc                	lw	a5,92(a5)
    1706:	02f74063          	blt	a4,a5,1726 <schedule_lst+0x1f2>
    170a:	fc843783          	ld	a5,-56(s0)
    170e:	4fbc                	lw	a5,88(a5)
    1710:	00f05b63          	blez	a5,1726 <schedule_lst+0x1f2>
            r.scheduled_thread_list_member = &min_slack_thread->thread_list;
    1714:	fc843783          	ld	a5,-56(s0)
    1718:	02878793          	addi	a5,a5,40
    171c:	f4f43423          	sd	a5,-184(s0)
            r.allocated_time = 0;  // Set to 0 to handle missed deadline
    1720:	f4042823          	sw	zero,-176(s0)
    1724:	a049                	j	17a6 <schedule_lst+0x272>
        } else {
            // Decide the allocated time based on current minimum slack or upcoming preemption needs
            int allocated_time = (next_significant_event_time == INT_MAX) ? min_slack_thread->remaining_time : next_significant_event_time - args.current_time;
    1726:	fb442783          	lw	a5,-76(s0)
    172a:	0007871b          	sext.w	a4,a5
    172e:	800007b7          	lui	a5,0x80000
    1732:	fff7c793          	not	a5,a5
    1736:	00f71663          	bne	a4,a5,1742 <schedule_lst+0x20e>
    173a:	fc843783          	ld	a5,-56(s0)
    173e:	4fbc                	lw	a5,88(a5)
    1740:	a039                	j	174e <schedule_lst+0x21a>
    1742:	409c                	lw	a5,0(s1)
    1744:	fb442703          	lw	a4,-76(s0)
    1748:	40f707bb          	subw	a5,a4,a5
    174c:	2781                	sext.w	a5,a5
    174e:	f8f42a23          	sw	a5,-108(s0)
            r.scheduled_thread_list_member = &min_slack_thread->thread_list;
    1752:	fc843783          	ld	a5,-56(s0)
    1756:	02878793          	addi	a5,a5,40 # ffffffff80000028 <__global_pointer$+0xffffffff7fffdc80>
    175a:	f4f43423          	sd	a5,-184(s0)
            r.allocated_time = allocated_time;
    175e:	f9442783          	lw	a5,-108(s0)
    1762:	f4f42823          	sw	a5,-176(s0)
    1766:	a081                	j	17a6 <schedule_lst+0x272>
        }
    } else {
        // No runnable threads, prepare to sleep or wait based on next known event
        r.scheduled_thread_list_member = args.run_queue;
    1768:	649c                	ld	a5,8(s1)
    176a:	f4f43423          	sd	a5,-184(s0)
        r.allocated_time = next_significant_event_time != INT_MAX ? next_significant_event_time - args.current_time : find_next_release_time(args.release_queue, args.current_time);
    176e:	fb442783          	lw	a5,-76(s0)
    1772:	0007871b          	sext.w	a4,a5
    1776:	800007b7          	lui	a5,0x80000
    177a:	fff7c793          	not	a5,a5
    177e:	00f70963          	beq	a4,a5,1790 <schedule_lst+0x25c>
    1782:	409c                	lw	a5,0(s1)
    1784:	fb442703          	lw	a4,-76(s0)
    1788:	40f707bb          	subw	a5,a4,a5
    178c:	2781                	sext.w	a5,a5
    178e:	a811                	j	17a2 <schedule_lst+0x26e>
    1790:	689c                	ld	a5,16(s1)
    1792:	4098                	lw	a4,0(s1)
    1794:	85ba                	mv	a1,a4
    1796:	853e                	mv	a0,a5
    1798:	00000097          	auipc	ra,0x0
    179c:	8ca080e7          	jalr	-1846(ra) # 1062 <find_next_release_time>
    17a0:	87aa                	mv	a5,a0
    17a2:	f4f42823          	sw	a5,-176(s0)
    }

    return r;
    17a6:	f4843783          	ld	a5,-184(s0)
    17aa:	f4f43c23          	sd	a5,-168(s0)
    17ae:	f5043783          	ld	a5,-176(s0)
    17b2:	f6f43023          	sd	a5,-160(s0)
    17b6:	4701                	li	a4,0
    17b8:	f5843703          	ld	a4,-168(s0)
    17bc:	4781                	li	a5,0
    17be:	f6043783          	ld	a5,-160(s0)
    17c2:	893a                	mv	s2,a4
    17c4:	89be                	mv	s3,a5
    17c6:	874a                	mv	a4,s2
    17c8:	87ce                	mv	a5,s3
}
    17ca:	853a                	mv	a0,a4
    17cc:	85be                	mv	a1,a5
    17ce:	70ea                	ld	ra,184(sp)
    17d0:	744a                	ld	s0,176(sp)
    17d2:	74aa                	ld	s1,168(sp)
    17d4:	790a                	ld	s2,160(sp)
    17d6:	69ea                	ld	s3,152(sp)
    17d8:	6129                	addi	sp,sp,192
    17da:	8082                	ret

00000000000017dc <find_earliest_impactful_release_time_dm>:
typedef struct {
    int earliest_impactful_event;
    struct thread *thread;
} ImpactfulEvent;

ImpactfulEvent find_earliest_impactful_release_time_dm(struct list_head *release_queue, struct list_head*run_queue, int current_time, int current_period) {
    17dc:	7119                	addi	sp,sp,-128
    17de:	fca2                	sd	s0,120(sp)
    17e0:	0100                	addi	s0,sp,128
    17e2:	f8a43c23          	sd	a0,-104(s0)
    17e6:	f8b43823          	sd	a1,-112(s0)
    17ea:	87b2                	mv	a5,a2
    17ec:	8736                	mv	a4,a3
    17ee:	f8f42623          	sw	a5,-116(s0)
    17f2:	87ba                	mv	a5,a4
    17f4:	f8f42423          	sw	a5,-120(s0)
    struct release_queue_entry *entry;
    struct thread *t;
    int earliest_impactful_event = INT_MAX;
    17f8:	800007b7          	lui	a5,0x80000
    17fc:	fff7c793          	not	a5,a5
    1800:	fcf42e23          	sw	a5,-36(s0)
    int earliest_impactful_thread_ID = INT_MAX;    
    1804:	800007b7          	lui	a5,0x80000
    1808:	fff7c793          	not	a5,a5
    180c:	fcf42c23          	sw	a5,-40(s0)
    
    // Look for the smallest deadline that is less than the current task's deadline
    list_for_each_entry(entry, release_queue, thread_list) {
    1810:	f9843783          	ld	a5,-104(s0)
    1814:	639c                	ld	a5,0(a5)
    1816:	fcf43823          	sd	a5,-48(s0)
    181a:	fd043783          	ld	a5,-48(s0)
    181e:	17e1                	addi	a5,a5,-8
    1820:	fef43423          	sd	a5,-24(s0)
    1824:	a201                	j	1924 <find_earliest_impactful_release_time_dm+0x148>
        if (entry->release_time > current_time && entry->thrd->period < current_period) {
    1826:	fe843783          	ld	a5,-24(s0)
    182a:	4f98                	lw	a4,24(a5)
    182c:	f8c42783          	lw	a5,-116(s0)
    1830:	2781                	sext.w	a5,a5
    1832:	04e7d463          	bge	a5,a4,187a <find_earliest_impactful_release_time_dm+0x9e>
    1836:	fe843783          	ld	a5,-24(s0)
    183a:	639c                	ld	a5,0(a5)
    183c:	4bb8                	lw	a4,80(a5)
    183e:	f8842783          	lw	a5,-120(s0)
    1842:	2781                	sext.w	a5,a5
    1844:	02f75b63          	bge	a4,a5,187a <find_earliest_impactful_release_time_dm+0x9e>
            if (entry->release_time < earliest_impactful_event) {
    1848:	fe843783          	ld	a5,-24(s0)
    184c:	4f98                	lw	a4,24(a5)
    184e:	fdc42783          	lw	a5,-36(s0)
    1852:	2781                	sext.w	a5,a5
    1854:	0af75e63          	bge	a4,a5,1910 <find_earliest_impactful_release_time_dm+0x134>
                earliest_impactful_event = entry->release_time;
    1858:	fe843783          	ld	a5,-24(s0)
    185c:	4f9c                	lw	a5,24(a5)
    185e:	fcf42e23          	sw	a5,-36(s0)
                t = entry->thrd;
    1862:	fe843783          	ld	a5,-24(s0)
    1866:	639c                	ld	a5,0(a5)
    1868:	fef43023          	sd	a5,-32(s0)
                earliest_impactful_thread_ID = entry->thrd->ID;
    186c:	fe843783          	ld	a5,-24(s0)
    1870:	639c                	ld	a5,0(a5)
    1872:	5fdc                	lw	a5,60(a5)
    1874:	fcf42c23          	sw	a5,-40(s0)
            if (entry->release_time < earliest_impactful_event) {
    1878:	a861                	j	1910 <find_earliest_impactful_release_time_dm+0x134>
            }
        } 
        // or the smallest deadline that is equal to the current task's deadline but has a smaller ID
        else if (entry->release_time > current_time && entry->thrd->period == current_period) {
    187a:	fe843783          	ld	a5,-24(s0)
    187e:	4f98                	lw	a4,24(a5)
    1880:	f8c42783          	lw	a5,-116(s0)
    1884:	2781                	sext.w	a5,a5
    1886:	08e7d563          	bge	a5,a4,1910 <find_earliest_impactful_release_time_dm+0x134>
    188a:	fe843783          	ld	a5,-24(s0)
    188e:	639c                	ld	a5,0(a5)
    1890:	4bb8                	lw	a4,80(a5)
    1892:	f8842783          	lw	a5,-120(s0)
    1896:	2781                	sext.w	a5,a5
    1898:	06e79c63          	bne	a5,a4,1910 <find_earliest_impactful_release_time_dm+0x134>
            
            //printf("ID %d, entry release time: %d\n", entry->thrd->ID, entry->release_time);
            if (entry->release_time < earliest_impactful_event) {
    189c:	fe843783          	ld	a5,-24(s0)
    18a0:	4f98                	lw	a4,24(a5)
    18a2:	fdc42783          	lw	a5,-36(s0)
    18a6:	2781                	sext.w	a5,a5
    18a8:	02f75363          	bge	a4,a5,18ce <find_earliest_impactful_release_time_dm+0xf2>
                earliest_impactful_event = entry->release_time;
    18ac:	fe843783          	ld	a5,-24(s0)
    18b0:	4f9c                	lw	a5,24(a5)
    18b2:	fcf42e23          	sw	a5,-36(s0)
                t = entry->thrd;
    18b6:	fe843783          	ld	a5,-24(s0)
    18ba:	639c                	ld	a5,0(a5)
    18bc:	fef43023          	sd	a5,-32(s0)
                earliest_impactful_thread_ID = entry->thrd->ID;
    18c0:	fe843783          	ld	a5,-24(s0)
    18c4:	639c                	ld	a5,0(a5)
    18c6:	5fdc                	lw	a5,60(a5)
    18c8:	fcf42c23          	sw	a5,-40(s0)
    18cc:	a091                	j	1910 <find_earliest_impactful_release_time_dm+0x134>
            } else if (entry->release_time == earliest_impactful_event && entry->thrd->ID < earliest_impactful_thread_ID) {
    18ce:	fe843783          	ld	a5,-24(s0)
    18d2:	4f98                	lw	a4,24(a5)
    18d4:	fdc42783          	lw	a5,-36(s0)
    18d8:	2781                	sext.w	a5,a5
    18da:	02e79b63          	bne	a5,a4,1910 <find_earliest_impactful_release_time_dm+0x134>
    18de:	fe843783          	ld	a5,-24(s0)
    18e2:	639c                	ld	a5,0(a5)
    18e4:	5fd8                	lw	a4,60(a5)
    18e6:	fd842783          	lw	a5,-40(s0)
    18ea:	2781                	sext.w	a5,a5
    18ec:	02f75263          	bge	a4,a5,1910 <find_earliest_impactful_release_time_dm+0x134>
                earliest_impactful_event = entry->release_time;
    18f0:	fe843783          	ld	a5,-24(s0)
    18f4:	4f9c                	lw	a5,24(a5)
    18f6:	fcf42e23          	sw	a5,-36(s0)
                t = entry->thrd;
    18fa:	fe843783          	ld	a5,-24(s0)
    18fe:	639c                	ld	a5,0(a5)
    1900:	fef43023          	sd	a5,-32(s0)
                earliest_impactful_thread_ID = entry->thrd->ID;
    1904:	fe843783          	ld	a5,-24(s0)
    1908:	639c                	ld	a5,0(a5)
    190a:	5fdc                	lw	a5,60(a5)
    190c:	fcf42c23          	sw	a5,-40(s0)
    list_for_each_entry(entry, release_queue, thread_list) {
    1910:	fe843783          	ld	a5,-24(s0)
    1914:	679c                	ld	a5,8(a5)
    1916:	fcf43423          	sd	a5,-56(s0)
    191a:	fc843783          	ld	a5,-56(s0)
    191e:	17e1                	addi	a5,a5,-8
    1920:	fef43423          	sd	a5,-24(s0)
    1924:	fe843783          	ld	a5,-24(s0)
    1928:	07a1                	addi	a5,a5,8
    192a:	f9843703          	ld	a4,-104(s0)
    192e:	eef71ce3          	bne	a4,a5,1826 <find_earliest_impactful_release_time_dm+0x4a>
            }
        }
    }
    //printf("earliest_impactful_event: %d\n", earliest_impactful_event);
    // If a task is found that might preempt the current task, determine when it will happen
    earliest_impactful_event = earliest_impactful_event == INT_MAX ? -1 : earliest_impactful_event;
    1932:	fdc42783          	lw	a5,-36(s0)
    1936:	0007871b          	sext.w	a4,a5
    193a:	800007b7          	lui	a5,0x80000
    193e:	fff7c793          	not	a5,a5
    1942:	00f70563          	beq	a4,a5,194c <find_earliest_impactful_release_time_dm+0x170>
    1946:	fdc42783          	lw	a5,-36(s0)
    194a:	a011                	j	194e <find_earliest_impactful_release_time_dm+0x172>
    194c:	57fd                	li	a5,-1
    194e:	fcf42e23          	sw	a5,-36(s0)
    return (ImpactfulEvent) {earliest_impactful_event, t};
    1952:	fdc42783          	lw	a5,-36(s0)
    1956:	faf42c23          	sw	a5,-72(s0)
    195a:	fe043783          	ld	a5,-32(s0)
    195e:	fcf43023          	sd	a5,-64(s0)
    1962:	4701                	li	a4,0
    1964:	fb843703          	ld	a4,-72(s0)
    1968:	4781                	li	a5,0
    196a:	fc043783          	ld	a5,-64(s0)
    196e:	883a                	mv	a6,a4
    1970:	88be                	mv	a7,a5
    1972:	8742                	mv	a4,a6
    1974:	87c6                	mv	a5,a7
}
    1976:	853a                	mv	a0,a4
    1978:	85be                	mv	a1,a5
    197a:	7466                	ld	s0,120(sp)
    197c:	6109                	addi	sp,sp,128
    197e:	8082                	ret

0000000000001980 <schedule_dm>:


struct threads_sched_result schedule_dm(struct threads_sched_args args) {
    1980:	7175                	addi	sp,sp,-144
    1982:	e506                	sd	ra,136(sp)
    1984:	e122                	sd	s0,128(sp)
    1986:	fca6                	sd	s1,120(sp)
    1988:	f8ca                	sd	s2,112(sp)
    198a:	f4ce                	sd	s3,104(sp)
    198c:	0900                	addi	s0,sp,144
    198e:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *earliest_deadline_thread = NULL;
    1990:	fc043423          	sd	zero,-56(s0)
    struct thread *t;
    int earliest_deadline = INT_MAX;
    1994:	800007b7          	lui	a5,0x80000
    1998:	fff7c793          	not	a5,a5
    199c:	faf42e23          	sw	a5,-68(s0)
    int earliest_impactful_deadline; 
    
    // Determine the earliest deadline among current tasks
    list_for_each_entry(t, args.run_queue, thread_list) {
    19a0:	649c                	ld	a5,8(s1)
    19a2:	639c                	ld	a5,0(a5)
    19a4:	faf43823          	sd	a5,-80(s0)
    19a8:	fb043783          	ld	a5,-80(s0)
    19ac:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffdc30>
    19b0:	fcf43023          	sd	a5,-64(s0)
    19b4:	a8bd                	j	1a32 <schedule_dm+0xb2>
        if (t->is_real_time && t->period < earliest_deadline) {
    19b6:	fc043783          	ld	a5,-64(s0)
    19ba:	43bc                	lw	a5,64(a5)
    19bc:	c39d                	beqz	a5,19e2 <schedule_dm+0x62>
    19be:	fc043783          	ld	a5,-64(s0)
    19c2:	4bb8                	lw	a4,80(a5)
    19c4:	fbc42783          	lw	a5,-68(s0)
    19c8:	2781                	sext.w	a5,a5
    19ca:	00f75c63          	bge	a4,a5,19e2 <schedule_dm+0x62>
            earliest_deadline_thread = t;
    19ce:	fc043783          	ld	a5,-64(s0)
    19d2:	fcf43423          	sd	a5,-56(s0)
            earliest_deadline = t->period;
    19d6:	fc043783          	ld	a5,-64(s0)
    19da:	4bbc                	lw	a5,80(a5)
    19dc:	faf42e23          	sw	a5,-68(s0)
    19e0:	a835                	j	1a1c <schedule_dm+0x9c>
        } else if (t->is_real_time && t->period == earliest_deadline && t->ID < earliest_deadline_thread->ID) {
    19e2:	fc043783          	ld	a5,-64(s0)
    19e6:	43bc                	lw	a5,64(a5)
    19e8:	cb95                	beqz	a5,1a1c <schedule_dm+0x9c>
    19ea:	fc043783          	ld	a5,-64(s0)
    19ee:	4bb8                	lw	a4,80(a5)
    19f0:	fbc42783          	lw	a5,-68(s0)
    19f4:	2781                	sext.w	a5,a5
    19f6:	02e79363          	bne	a5,a4,1a1c <schedule_dm+0x9c>
    19fa:	fc043783          	ld	a5,-64(s0)
    19fe:	5fd8                	lw	a4,60(a5)
    1a00:	fc843783          	ld	a5,-56(s0)
    1a04:	5fdc                	lw	a5,60(a5)
    1a06:	00f75b63          	bge	a4,a5,1a1c <schedule_dm+0x9c>
            earliest_deadline_thread = t;
    1a0a:	fc043783          	ld	a5,-64(s0)
    1a0e:	fcf43423          	sd	a5,-56(s0)
            earliest_deadline = t->period;
    1a12:	fc043783          	ld	a5,-64(s0)
    1a16:	4bbc                	lw	a5,80(a5)
    1a18:	faf42e23          	sw	a5,-68(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    1a1c:	fc043783          	ld	a5,-64(s0)
    1a20:	779c                	ld	a5,40(a5)
    1a22:	faf43023          	sd	a5,-96(s0)
    1a26:	fa043783          	ld	a5,-96(s0)
    1a2a:	fd878793          	addi	a5,a5,-40
    1a2e:	fcf43023          	sd	a5,-64(s0)
    1a32:	fc043783          	ld	a5,-64(s0)
    1a36:	02878713          	addi	a4,a5,40
    1a3a:	649c                	ld	a5,8(s1)
    1a3c:	f6f71de3          	bne	a4,a5,19b6 <schedule_dm+0x36>
        }
    }

    // Find the earliest impactful deadline from other tasks
    ImpactfulEvent earliest_impactful_event = find_earliest_impactful_release_time_dm(args.release_queue, args.run_queue, args.current_time, earliest_deadline_thread ? earliest_deadline_thread->period : INT_MAX);
    1a40:	6898                	ld	a4,16(s1)
    1a42:	648c                	ld	a1,8(s1)
    1a44:	4090                	lw	a2,0(s1)
    1a46:	fc843783          	ld	a5,-56(s0)
    1a4a:	c789                	beqz	a5,1a54 <schedule_dm+0xd4>
    1a4c:	fc843783          	ld	a5,-56(s0)
    1a50:	4bbc                	lw	a5,80(a5)
    1a52:	a029                	j	1a5c <schedule_dm+0xdc>
    1a54:	800007b7          	lui	a5,0x80000
    1a58:	fff7c793          	not	a5,a5
    1a5c:	86be                	mv	a3,a5
    1a5e:	853a                	mv	a0,a4
    1a60:	00000097          	auipc	ra,0x0
    1a64:	d7c080e7          	jalr	-644(ra) # 17dc <find_earliest_impactful_release_time_dm>
    1a68:	872a                	mv	a4,a0
    1a6a:	87ae                	mv	a5,a1
    1a6c:	f6e43823          	sd	a4,-144(s0)
    1a70:	f6f43c23          	sd	a5,-136(s0)
    earliest_impactful_deadline = earliest_impactful_event.earliest_impactful_event;
    1a74:	f7042783          	lw	a5,-144(s0)
    1a78:	faf42623          	sw	a5,-84(s0)

    if (earliest_deadline_thread) {
    1a7c:	fc843783          	ld	a5,-56(s0)
    1a80:	c3d1                	beqz	a5,1b04 <schedule_dm+0x184>
        int time_to_deadline = earliest_deadline_thread->current_deadline - args.current_time;
    1a82:	fc843783          	ld	a5,-56(s0)
    1a86:	4ff8                	lw	a4,92(a5)
    1a88:	409c                	lw	a5,0(s1)
    1a8a:	40f707bb          	subw	a5,a4,a5
    1a8e:	faf42423          	sw	a5,-88(s0)
        
        // If the thread is already past its deadline, allocate no time (handle deadline miss)
        if (time_to_deadline <= 0) {
    1a92:	fa842783          	lw	a5,-88(s0)
    1a96:	2781                	sext.w	a5,a5
    1a98:	00f04b63          	bgtz	a5,1aae <schedule_dm+0x12e>
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    1a9c:	fc843783          	ld	a5,-56(s0)
    1aa0:	02878793          	addi	a5,a5,40 # ffffffff80000028 <__global_pointer$+0xffffffff7fffdc80>
    1aa4:	f8f43023          	sd	a5,-128(s0)
            r.allocated_time = 0;
    1aa8:	f8042423          	sw	zero,-120(s0)
    1aac:	a895                	j	1b20 <schedule_dm+0x1a0>
        } else {
            // Allocate time based on the smallest of the task's remaining time or the next impactful deadline
            int allocated_time;
            if (earliest_impactful_deadline != -1 && (earliest_impactful_deadline - args.current_time) < earliest_deadline_thread->remaining_time){
    1aae:	fac42783          	lw	a5,-84(s0)
    1ab2:	0007871b          	sext.w	a4,a5
    1ab6:	57fd                	li	a5,-1
    1ab8:	02f70663          	beq	a4,a5,1ae4 <schedule_dm+0x164>
    1abc:	409c                	lw	a5,0(s1)
    1abe:	fac42703          	lw	a4,-84(s0)
    1ac2:	40f707bb          	subw	a5,a4,a5
    1ac6:	0007871b          	sext.w	a4,a5
    1aca:	fc843783          	ld	a5,-56(s0)
    1ace:	4fbc                	lw	a5,88(a5)
    1ad0:	00f75a63          	bge	a4,a5,1ae4 <schedule_dm+0x164>
                allocated_time = earliest_impactful_deadline - args.current_time;
    1ad4:	409c                	lw	a5,0(s1)
    1ad6:	fac42703          	lw	a4,-84(s0)
    1ada:	40f707bb          	subw	a5,a4,a5
    1ade:	faf42c23          	sw	a5,-72(s0)
    1ae2:	a031                	j	1aee <schedule_dm+0x16e>
            } else {
                allocated_time = earliest_deadline_thread->remaining_time;
    1ae4:	fc843783          	ld	a5,-56(s0)
    1ae8:	4fbc                	lw	a5,88(a5)
    1aea:	faf42c23          	sw	a5,-72(s0)
            }
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    1aee:	fc843783          	ld	a5,-56(s0)
    1af2:	02878793          	addi	a5,a5,40
    1af6:	f8f43023          	sd	a5,-128(s0)
            r.allocated_time = allocated_time;
    1afa:	fb842783          	lw	a5,-72(s0)
    1afe:	f8f42423          	sw	a5,-120(s0)
    1b02:	a839                	j	1b20 <schedule_dm+0x1a0>
        }
    } else {
        // If no immediate tasks, schedule the next possible task
        r.scheduled_thread_list_member = args.run_queue;
    1b04:	649c                	ld	a5,8(s1)
    1b06:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    1b0a:	689c                	ld	a5,16(s1)
    1b0c:	4098                	lw	a4,0(s1)
    1b0e:	85ba                	mv	a1,a4
    1b10:	853e                	mv	a0,a5
    1b12:	fffff097          	auipc	ra,0xfffff
    1b16:	550080e7          	jalr	1360(ra) # 1062 <find_next_release_time>
    1b1a:	87aa                	mv	a5,a0
    1b1c:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    1b20:	f8043783          	ld	a5,-128(s0)
    1b24:	f8f43823          	sd	a5,-112(s0)
    1b28:	f8843783          	ld	a5,-120(s0)
    1b2c:	f8f43c23          	sd	a5,-104(s0)
    1b30:	4701                	li	a4,0
    1b32:	f9043703          	ld	a4,-112(s0)
    1b36:	4781                	li	a5,0
    1b38:	f9843783          	ld	a5,-104(s0)
    1b3c:	893a                	mv	s2,a4
    1b3e:	89be                	mv	s3,a5
    1b40:	874a                	mv	a4,s2
    1b42:	87ce                	mv	a5,s3
}
    1b44:	853a                	mv	a0,a4
    1b46:	85be                	mv	a1,a5
    1b48:	60aa                	ld	ra,136(sp)
    1b4a:	640a                	ld	s0,128(sp)
    1b4c:	74e6                	ld	s1,120(sp)
    1b4e:	7946                	ld	s2,112(sp)
    1b50:	79a6                	ld	s3,104(sp)
    1b52:	6149                	addi	sp,sp,144
    1b54:	8082                	ret
