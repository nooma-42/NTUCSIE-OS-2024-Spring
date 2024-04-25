
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
       0:	1101                	addi	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	1000                	addi	s0,sp,32
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
       8:	4589                	li	a1,2
       a:	00001517          	auipc	a0,0x1
       e:	58e50513          	addi	a0,a0,1422 # 1598 <schedule_dm+0x214>
      12:	00000097          	auipc	ra,0x0
      16:	5dc080e7          	jalr	1500(ra) # 5ee <open>
      1a:	87aa                	mv	a5,a0
      1c:	0207d563          	bgez	a5,46 <main+0x46>
    mknod("console", CONSOLE, 0);
      20:	4601                	li	a2,0
      22:	4585                	li	a1,1
      24:	00001517          	auipc	a0,0x1
      28:	57450513          	addi	a0,a0,1396 # 1598 <schedule_dm+0x214>
      2c:	00000097          	auipc	ra,0x0
      30:	5ca080e7          	jalr	1482(ra) # 5f6 <mknod>
    open("console", O_RDWR);
      34:	4589                	li	a1,2
      36:	00001517          	auipc	a0,0x1
      3a:	56250513          	addi	a0,a0,1378 # 1598 <schedule_dm+0x214>
      3e:	00000097          	auipc	ra,0x0
      42:	5b0080e7          	jalr	1456(ra) # 5ee <open>
  }
  dup(0);  // stdout
      46:	4501                	li	a0,0
      48:	00000097          	auipc	ra,0x0
      4c:	5de080e7          	jalr	1502(ra) # 626 <dup>
  dup(0);  // stderr
      50:	4501                	li	a0,0
      52:	00000097          	auipc	ra,0x0
      56:	5d4080e7          	jalr	1492(ra) # 626 <dup>

  for(;;){
    printf("init: starting sh\n");
      5a:	00001517          	auipc	a0,0x1
      5e:	54650513          	addi	a0,a0,1350 # 15a0 <schedule_dm+0x21c>
      62:	00001097          	auipc	ra,0x1
      66:	a92080e7          	jalr	-1390(ra) # af4 <printf>
    pid = fork();
      6a:	00000097          	auipc	ra,0x0
      6e:	53c080e7          	jalr	1340(ra) # 5a6 <fork>
      72:	87aa                	mv	a5,a0
      74:	fef42623          	sw	a5,-20(s0)
    if(pid < 0){
      78:	fec42783          	lw	a5,-20(s0)
      7c:	2781                	sext.w	a5,a5
      7e:	0007df63          	bgez	a5,9c <main+0x9c>
      printf("init: fork failed\n");
      82:	00001517          	auipc	a0,0x1
      86:	53650513          	addi	a0,a0,1334 # 15b8 <schedule_dm+0x234>
      8a:	00001097          	auipc	ra,0x1
      8e:	a6a080e7          	jalr	-1430(ra) # af4 <printf>
      exit(1);
      92:	4505                	li	a0,1
      94:	00000097          	auipc	ra,0x0
      98:	51a080e7          	jalr	1306(ra) # 5ae <exit>
    }
    if(pid == 0){
      9c:	fec42783          	lw	a5,-20(s0)
      a0:	2781                	sext.w	a5,a5
      a2:	eb95                	bnez	a5,d6 <main+0xd6>
      exec("sh", argv);
      a4:	00001597          	auipc	a1,0x1
      a8:	56c58593          	addi	a1,a1,1388 # 1610 <argv>
      ac:	00001517          	auipc	a0,0x1
      b0:	4e450513          	addi	a0,a0,1252 # 1590 <schedule_dm+0x20c>
      b4:	00000097          	auipc	ra,0x0
      b8:	532080e7          	jalr	1330(ra) # 5e6 <exec>
      printf("init: exec sh failed\n");
      bc:	00001517          	auipc	a0,0x1
      c0:	51450513          	addi	a0,a0,1300 # 15d0 <schedule_dm+0x24c>
      c4:	00001097          	auipc	ra,0x1
      c8:	a30080e7          	jalr	-1488(ra) # af4 <printf>
      exit(1);
      cc:	4505                	li	a0,1
      ce:	00000097          	auipc	ra,0x0
      d2:	4e0080e7          	jalr	1248(ra) # 5ae <exit>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
      d6:	4501                	li	a0,0
      d8:	00000097          	auipc	ra,0x0
      dc:	4de080e7          	jalr	1246(ra) # 5b6 <wait>
      e0:	87aa                	mv	a5,a0
      e2:	fef42423          	sw	a5,-24(s0)
      if(wpid == pid){
      e6:	fe842703          	lw	a4,-24(s0)
      ea:	fec42783          	lw	a5,-20(s0)
      ee:	2701                	sext.w	a4,a4
      f0:	2781                	sext.w	a5,a5
      f2:	02f70463          	beq	a4,a5,11a <main+0x11a>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
      f6:	fe842783          	lw	a5,-24(s0)
      fa:	2781                	sext.w	a5,a5
      fc:	fc07dde3          	bgez	a5,d6 <main+0xd6>
        printf("init: wait returned an error\n");
     100:	00001517          	auipc	a0,0x1
     104:	4e850513          	addi	a0,a0,1256 # 15e8 <schedule_dm+0x264>
     108:	00001097          	auipc	ra,0x1
     10c:	9ec080e7          	jalr	-1556(ra) # af4 <printf>
        exit(1);
     110:	4505                	li	a0,1
     112:	00000097          	auipc	ra,0x0
     116:	49c080e7          	jalr	1180(ra) # 5ae <exit>
        break;
     11a:	0001                	nop
    printf("init: starting sh\n");
     11c:	bf3d                	j	5a <main+0x5a>

000000000000011e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     11e:	7179                	addi	sp,sp,-48
     120:	f422                	sd	s0,40(sp)
     122:	1800                	addi	s0,sp,48
     124:	fca43c23          	sd	a0,-40(s0)
     128:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     12c:	fd843783          	ld	a5,-40(s0)
     130:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     134:	0001                	nop
     136:	fd043703          	ld	a4,-48(s0)
     13a:	00170793          	addi	a5,a4,1
     13e:	fcf43823          	sd	a5,-48(s0)
     142:	fd843783          	ld	a5,-40(s0)
     146:	00178693          	addi	a3,a5,1
     14a:	fcd43c23          	sd	a3,-40(s0)
     14e:	00074703          	lbu	a4,0(a4)
     152:	00e78023          	sb	a4,0(a5)
     156:	0007c783          	lbu	a5,0(a5)
     15a:	fff1                	bnez	a5,136 <strcpy+0x18>
    ;
  return os;
     15c:	fe843783          	ld	a5,-24(s0)
}
     160:	853e                	mv	a0,a5
     162:	7422                	ld	s0,40(sp)
     164:	6145                	addi	sp,sp,48
     166:	8082                	ret

0000000000000168 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     168:	1101                	addi	sp,sp,-32
     16a:	ec22                	sd	s0,24(sp)
     16c:	1000                	addi	s0,sp,32
     16e:	fea43423          	sd	a0,-24(s0)
     172:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     176:	a819                	j	18c <strcmp+0x24>
    p++, q++;
     178:	fe843783          	ld	a5,-24(s0)
     17c:	0785                	addi	a5,a5,1
     17e:	fef43423          	sd	a5,-24(s0)
     182:	fe043783          	ld	a5,-32(s0)
     186:	0785                	addi	a5,a5,1
     188:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     18c:	fe843783          	ld	a5,-24(s0)
     190:	0007c783          	lbu	a5,0(a5)
     194:	cb99                	beqz	a5,1aa <strcmp+0x42>
     196:	fe843783          	ld	a5,-24(s0)
     19a:	0007c703          	lbu	a4,0(a5)
     19e:	fe043783          	ld	a5,-32(s0)
     1a2:	0007c783          	lbu	a5,0(a5)
     1a6:	fcf709e3          	beq	a4,a5,178 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     1aa:	fe843783          	ld	a5,-24(s0)
     1ae:	0007c783          	lbu	a5,0(a5)
     1b2:	0007871b          	sext.w	a4,a5
     1b6:	fe043783          	ld	a5,-32(s0)
     1ba:	0007c783          	lbu	a5,0(a5)
     1be:	2781                	sext.w	a5,a5
     1c0:	40f707bb          	subw	a5,a4,a5
     1c4:	2781                	sext.w	a5,a5
}
     1c6:	853e                	mv	a0,a5
     1c8:	6462                	ld	s0,24(sp)
     1ca:	6105                	addi	sp,sp,32
     1cc:	8082                	ret

00000000000001ce <strlen>:

uint
strlen(const char *s)
{
     1ce:	7179                	addi	sp,sp,-48
     1d0:	f422                	sd	s0,40(sp)
     1d2:	1800                	addi	s0,sp,48
     1d4:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     1d8:	fe042623          	sw	zero,-20(s0)
     1dc:	a031                	j	1e8 <strlen+0x1a>
     1de:	fec42783          	lw	a5,-20(s0)
     1e2:	2785                	addiw	a5,a5,1
     1e4:	fef42623          	sw	a5,-20(s0)
     1e8:	fec42783          	lw	a5,-20(s0)
     1ec:	fd843703          	ld	a4,-40(s0)
     1f0:	97ba                	add	a5,a5,a4
     1f2:	0007c783          	lbu	a5,0(a5)
     1f6:	f7e5                	bnez	a5,1de <strlen+0x10>
    ;
  return n;
     1f8:	fec42783          	lw	a5,-20(s0)
}
     1fc:	853e                	mv	a0,a5
     1fe:	7422                	ld	s0,40(sp)
     200:	6145                	addi	sp,sp,48
     202:	8082                	ret

0000000000000204 <memset>:

void*
memset(void *dst, int c, uint n)
{
     204:	7179                	addi	sp,sp,-48
     206:	f422                	sd	s0,40(sp)
     208:	1800                	addi	s0,sp,48
     20a:	fca43c23          	sd	a0,-40(s0)
     20e:	87ae                	mv	a5,a1
     210:	8732                	mv	a4,a2
     212:	fcf42a23          	sw	a5,-44(s0)
     216:	87ba                	mv	a5,a4
     218:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     21c:	fd843783          	ld	a5,-40(s0)
     220:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     224:	fe042623          	sw	zero,-20(s0)
     228:	a00d                	j	24a <memset+0x46>
    cdst[i] = c;
     22a:	fec42783          	lw	a5,-20(s0)
     22e:	fe043703          	ld	a4,-32(s0)
     232:	97ba                	add	a5,a5,a4
     234:	fd442703          	lw	a4,-44(s0)
     238:	0ff77713          	andi	a4,a4,255
     23c:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     240:	fec42783          	lw	a5,-20(s0)
     244:	2785                	addiw	a5,a5,1
     246:	fef42623          	sw	a5,-20(s0)
     24a:	fec42703          	lw	a4,-20(s0)
     24e:	fd042783          	lw	a5,-48(s0)
     252:	2781                	sext.w	a5,a5
     254:	fcf76be3          	bltu	a4,a5,22a <memset+0x26>
  }
  return dst;
     258:	fd843783          	ld	a5,-40(s0)
}
     25c:	853e                	mv	a0,a5
     25e:	7422                	ld	s0,40(sp)
     260:	6145                	addi	sp,sp,48
     262:	8082                	ret

0000000000000264 <strchr>:

char*
strchr(const char *s, char c)
{
     264:	1101                	addi	sp,sp,-32
     266:	ec22                	sd	s0,24(sp)
     268:	1000                	addi	s0,sp,32
     26a:	fea43423          	sd	a0,-24(s0)
     26e:	87ae                	mv	a5,a1
     270:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     274:	a01d                	j	29a <strchr+0x36>
    if(*s == c)
     276:	fe843783          	ld	a5,-24(s0)
     27a:	0007c703          	lbu	a4,0(a5)
     27e:	fe744783          	lbu	a5,-25(s0)
     282:	0ff7f793          	andi	a5,a5,255
     286:	00e79563          	bne	a5,a4,290 <strchr+0x2c>
      return (char*)s;
     28a:	fe843783          	ld	a5,-24(s0)
     28e:	a821                	j	2a6 <strchr+0x42>
  for(; *s; s++)
     290:	fe843783          	ld	a5,-24(s0)
     294:	0785                	addi	a5,a5,1
     296:	fef43423          	sd	a5,-24(s0)
     29a:	fe843783          	ld	a5,-24(s0)
     29e:	0007c783          	lbu	a5,0(a5)
     2a2:	fbf1                	bnez	a5,276 <strchr+0x12>
  return 0;
     2a4:	4781                	li	a5,0
}
     2a6:	853e                	mv	a0,a5
     2a8:	6462                	ld	s0,24(sp)
     2aa:	6105                	addi	sp,sp,32
     2ac:	8082                	ret

00000000000002ae <gets>:

char*
gets(char *buf, int max)
{
     2ae:	7179                	addi	sp,sp,-48
     2b0:	f406                	sd	ra,40(sp)
     2b2:	f022                	sd	s0,32(sp)
     2b4:	1800                	addi	s0,sp,48
     2b6:	fca43c23          	sd	a0,-40(s0)
     2ba:	87ae                	mv	a5,a1
     2bc:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     2c0:	fe042623          	sw	zero,-20(s0)
     2c4:	a8a1                	j	31c <gets+0x6e>
    cc = read(0, &c, 1);
     2c6:	fe740793          	addi	a5,s0,-25
     2ca:	4605                	li	a2,1
     2cc:	85be                	mv	a1,a5
     2ce:	4501                	li	a0,0
     2d0:	00000097          	auipc	ra,0x0
     2d4:	2f6080e7          	jalr	758(ra) # 5c6 <read>
     2d8:	87aa                	mv	a5,a0
     2da:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     2de:	fe842783          	lw	a5,-24(s0)
     2e2:	2781                	sext.w	a5,a5
     2e4:	04f05763          	blez	a5,332 <gets+0x84>
      break;
    buf[i++] = c;
     2e8:	fec42783          	lw	a5,-20(s0)
     2ec:	0017871b          	addiw	a4,a5,1
     2f0:	fee42623          	sw	a4,-20(s0)
     2f4:	873e                	mv	a4,a5
     2f6:	fd843783          	ld	a5,-40(s0)
     2fa:	97ba                	add	a5,a5,a4
     2fc:	fe744703          	lbu	a4,-25(s0)
     300:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     304:	fe744783          	lbu	a5,-25(s0)
     308:	873e                	mv	a4,a5
     30a:	47a9                	li	a5,10
     30c:	02f70463          	beq	a4,a5,334 <gets+0x86>
     310:	fe744783          	lbu	a5,-25(s0)
     314:	873e                	mv	a4,a5
     316:	47b5                	li	a5,13
     318:	00f70e63          	beq	a4,a5,334 <gets+0x86>
  for(i=0; i+1 < max; ){
     31c:	fec42783          	lw	a5,-20(s0)
     320:	2785                	addiw	a5,a5,1
     322:	0007871b          	sext.w	a4,a5
     326:	fd442783          	lw	a5,-44(s0)
     32a:	2781                	sext.w	a5,a5
     32c:	f8f74de3          	blt	a4,a5,2c6 <gets+0x18>
     330:	a011                	j	334 <gets+0x86>
      break;
     332:	0001                	nop
      break;
  }
  buf[i] = '\0';
     334:	fec42783          	lw	a5,-20(s0)
     338:	fd843703          	ld	a4,-40(s0)
     33c:	97ba                	add	a5,a5,a4
     33e:	00078023          	sb	zero,0(a5)
  return buf;
     342:	fd843783          	ld	a5,-40(s0)
}
     346:	853e                	mv	a0,a5
     348:	70a2                	ld	ra,40(sp)
     34a:	7402                	ld	s0,32(sp)
     34c:	6145                	addi	sp,sp,48
     34e:	8082                	ret

0000000000000350 <stat>:

int
stat(const char *n, struct stat *st)
{
     350:	7179                	addi	sp,sp,-48
     352:	f406                	sd	ra,40(sp)
     354:	f022                	sd	s0,32(sp)
     356:	1800                	addi	s0,sp,48
     358:	fca43c23          	sd	a0,-40(s0)
     35c:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     360:	4581                	li	a1,0
     362:	fd843503          	ld	a0,-40(s0)
     366:	00000097          	auipc	ra,0x0
     36a:	288080e7          	jalr	648(ra) # 5ee <open>
     36e:	87aa                	mv	a5,a0
     370:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     374:	fec42783          	lw	a5,-20(s0)
     378:	2781                	sext.w	a5,a5
     37a:	0007d463          	bgez	a5,382 <stat+0x32>
    return -1;
     37e:	57fd                	li	a5,-1
     380:	a035                	j	3ac <stat+0x5c>
  r = fstat(fd, st);
     382:	fec42783          	lw	a5,-20(s0)
     386:	fd043583          	ld	a1,-48(s0)
     38a:	853e                	mv	a0,a5
     38c:	00000097          	auipc	ra,0x0
     390:	27a080e7          	jalr	634(ra) # 606 <fstat>
     394:	87aa                	mv	a5,a0
     396:	fef42423          	sw	a5,-24(s0)
  close(fd);
     39a:	fec42783          	lw	a5,-20(s0)
     39e:	853e                	mv	a0,a5
     3a0:	00000097          	auipc	ra,0x0
     3a4:	236080e7          	jalr	566(ra) # 5d6 <close>
  return r;
     3a8:	fe842783          	lw	a5,-24(s0)
}
     3ac:	853e                	mv	a0,a5
     3ae:	70a2                	ld	ra,40(sp)
     3b0:	7402                	ld	s0,32(sp)
     3b2:	6145                	addi	sp,sp,48
     3b4:	8082                	ret

00000000000003b6 <atoi>:

int
atoi(const char *s)
{
     3b6:	7179                	addi	sp,sp,-48
     3b8:	f422                	sd	s0,40(sp)
     3ba:	1800                	addi	s0,sp,48
     3bc:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     3c0:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     3c4:	a815                	j	3f8 <atoi+0x42>
    n = n*10 + *s++ - '0';
     3c6:	fec42703          	lw	a4,-20(s0)
     3ca:	87ba                	mv	a5,a4
     3cc:	0027979b          	slliw	a5,a5,0x2
     3d0:	9fb9                	addw	a5,a5,a4
     3d2:	0017979b          	slliw	a5,a5,0x1
     3d6:	0007871b          	sext.w	a4,a5
     3da:	fd843783          	ld	a5,-40(s0)
     3de:	00178693          	addi	a3,a5,1
     3e2:	fcd43c23          	sd	a3,-40(s0)
     3e6:	0007c783          	lbu	a5,0(a5)
     3ea:	2781                	sext.w	a5,a5
     3ec:	9fb9                	addw	a5,a5,a4
     3ee:	2781                	sext.w	a5,a5
     3f0:	fd07879b          	addiw	a5,a5,-48
     3f4:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     3f8:	fd843783          	ld	a5,-40(s0)
     3fc:	0007c783          	lbu	a5,0(a5)
     400:	873e                	mv	a4,a5
     402:	02f00793          	li	a5,47
     406:	00e7fb63          	bgeu	a5,a4,41c <atoi+0x66>
     40a:	fd843783          	ld	a5,-40(s0)
     40e:	0007c783          	lbu	a5,0(a5)
     412:	873e                	mv	a4,a5
     414:	03900793          	li	a5,57
     418:	fae7f7e3          	bgeu	a5,a4,3c6 <atoi+0x10>
  return n;
     41c:	fec42783          	lw	a5,-20(s0)
}
     420:	853e                	mv	a0,a5
     422:	7422                	ld	s0,40(sp)
     424:	6145                	addi	sp,sp,48
     426:	8082                	ret

0000000000000428 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     428:	7139                	addi	sp,sp,-64
     42a:	fc22                	sd	s0,56(sp)
     42c:	0080                	addi	s0,sp,64
     42e:	fca43c23          	sd	a0,-40(s0)
     432:	fcb43823          	sd	a1,-48(s0)
     436:	87b2                	mv	a5,a2
     438:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     43c:	fd843783          	ld	a5,-40(s0)
     440:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     444:	fd043783          	ld	a5,-48(s0)
     448:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     44c:	fe043703          	ld	a4,-32(s0)
     450:	fe843783          	ld	a5,-24(s0)
     454:	02e7fc63          	bgeu	a5,a4,48c <memmove+0x64>
    while(n-- > 0)
     458:	a00d                	j	47a <memmove+0x52>
      *dst++ = *src++;
     45a:	fe043703          	ld	a4,-32(s0)
     45e:	00170793          	addi	a5,a4,1
     462:	fef43023          	sd	a5,-32(s0)
     466:	fe843783          	ld	a5,-24(s0)
     46a:	00178693          	addi	a3,a5,1
     46e:	fed43423          	sd	a3,-24(s0)
     472:	00074703          	lbu	a4,0(a4)
     476:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     47a:	fcc42783          	lw	a5,-52(s0)
     47e:	fff7871b          	addiw	a4,a5,-1
     482:	fce42623          	sw	a4,-52(s0)
     486:	fcf04ae3          	bgtz	a5,45a <memmove+0x32>
     48a:	a891                	j	4de <memmove+0xb6>
  } else {
    dst += n;
     48c:	fcc42783          	lw	a5,-52(s0)
     490:	fe843703          	ld	a4,-24(s0)
     494:	97ba                	add	a5,a5,a4
     496:	fef43423          	sd	a5,-24(s0)
    src += n;
     49a:	fcc42783          	lw	a5,-52(s0)
     49e:	fe043703          	ld	a4,-32(s0)
     4a2:	97ba                	add	a5,a5,a4
     4a4:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     4a8:	a01d                	j	4ce <memmove+0xa6>
      *--dst = *--src;
     4aa:	fe043783          	ld	a5,-32(s0)
     4ae:	17fd                	addi	a5,a5,-1
     4b0:	fef43023          	sd	a5,-32(s0)
     4b4:	fe843783          	ld	a5,-24(s0)
     4b8:	17fd                	addi	a5,a5,-1
     4ba:	fef43423          	sd	a5,-24(s0)
     4be:	fe043783          	ld	a5,-32(s0)
     4c2:	0007c703          	lbu	a4,0(a5)
     4c6:	fe843783          	ld	a5,-24(s0)
     4ca:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     4ce:	fcc42783          	lw	a5,-52(s0)
     4d2:	fff7871b          	addiw	a4,a5,-1
     4d6:	fce42623          	sw	a4,-52(s0)
     4da:	fcf048e3          	bgtz	a5,4aa <memmove+0x82>
  }
  return vdst;
     4de:	fd843783          	ld	a5,-40(s0)
}
     4e2:	853e                	mv	a0,a5
     4e4:	7462                	ld	s0,56(sp)
     4e6:	6121                	addi	sp,sp,64
     4e8:	8082                	ret

00000000000004ea <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     4ea:	7139                	addi	sp,sp,-64
     4ec:	fc22                	sd	s0,56(sp)
     4ee:	0080                	addi	s0,sp,64
     4f0:	fca43c23          	sd	a0,-40(s0)
     4f4:	fcb43823          	sd	a1,-48(s0)
     4f8:	87b2                	mv	a5,a2
     4fa:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     4fe:	fd843783          	ld	a5,-40(s0)
     502:	fef43423          	sd	a5,-24(s0)
     506:	fd043783          	ld	a5,-48(s0)
     50a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     50e:	a0a1                	j	556 <memcmp+0x6c>
    if (*p1 != *p2) {
     510:	fe843783          	ld	a5,-24(s0)
     514:	0007c703          	lbu	a4,0(a5)
     518:	fe043783          	ld	a5,-32(s0)
     51c:	0007c783          	lbu	a5,0(a5)
     520:	02f70163          	beq	a4,a5,542 <memcmp+0x58>
      return *p1 - *p2;
     524:	fe843783          	ld	a5,-24(s0)
     528:	0007c783          	lbu	a5,0(a5)
     52c:	0007871b          	sext.w	a4,a5
     530:	fe043783          	ld	a5,-32(s0)
     534:	0007c783          	lbu	a5,0(a5)
     538:	2781                	sext.w	a5,a5
     53a:	40f707bb          	subw	a5,a4,a5
     53e:	2781                	sext.w	a5,a5
     540:	a01d                	j	566 <memcmp+0x7c>
    }
    p1++;
     542:	fe843783          	ld	a5,-24(s0)
     546:	0785                	addi	a5,a5,1
     548:	fef43423          	sd	a5,-24(s0)
    p2++;
     54c:	fe043783          	ld	a5,-32(s0)
     550:	0785                	addi	a5,a5,1
     552:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     556:	fcc42783          	lw	a5,-52(s0)
     55a:	fff7871b          	addiw	a4,a5,-1
     55e:	fce42623          	sw	a4,-52(s0)
     562:	f7dd                	bnez	a5,510 <memcmp+0x26>
  }
  return 0;
     564:	4781                	li	a5,0
}
     566:	853e                	mv	a0,a5
     568:	7462                	ld	s0,56(sp)
     56a:	6121                	addi	sp,sp,64
     56c:	8082                	ret

000000000000056e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     56e:	7179                	addi	sp,sp,-48
     570:	f406                	sd	ra,40(sp)
     572:	f022                	sd	s0,32(sp)
     574:	1800                	addi	s0,sp,48
     576:	fea43423          	sd	a0,-24(s0)
     57a:	feb43023          	sd	a1,-32(s0)
     57e:	87b2                	mv	a5,a2
     580:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     584:	fdc42783          	lw	a5,-36(s0)
     588:	863e                	mv	a2,a5
     58a:	fe043583          	ld	a1,-32(s0)
     58e:	fe843503          	ld	a0,-24(s0)
     592:	00000097          	auipc	ra,0x0
     596:	e96080e7          	jalr	-362(ra) # 428 <memmove>
     59a:	87aa                	mv	a5,a0
}
     59c:	853e                	mv	a0,a5
     59e:	70a2                	ld	ra,40(sp)
     5a0:	7402                	ld	s0,32(sp)
     5a2:	6145                	addi	sp,sp,48
     5a4:	8082                	ret

00000000000005a6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     5a6:	4885                	li	a7,1
 ecall
     5a8:	00000073          	ecall
 ret
     5ac:	8082                	ret

00000000000005ae <exit>:
.global exit
exit:
 li a7, SYS_exit
     5ae:	4889                	li	a7,2
 ecall
     5b0:	00000073          	ecall
 ret
     5b4:	8082                	ret

00000000000005b6 <wait>:
.global wait
wait:
 li a7, SYS_wait
     5b6:	488d                	li	a7,3
 ecall
     5b8:	00000073          	ecall
 ret
     5bc:	8082                	ret

00000000000005be <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     5be:	4891                	li	a7,4
 ecall
     5c0:	00000073          	ecall
 ret
     5c4:	8082                	ret

00000000000005c6 <read>:
.global read
read:
 li a7, SYS_read
     5c6:	4895                	li	a7,5
 ecall
     5c8:	00000073          	ecall
 ret
     5cc:	8082                	ret

00000000000005ce <write>:
.global write
write:
 li a7, SYS_write
     5ce:	48c1                	li	a7,16
 ecall
     5d0:	00000073          	ecall
 ret
     5d4:	8082                	ret

00000000000005d6 <close>:
.global close
close:
 li a7, SYS_close
     5d6:	48d5                	li	a7,21
 ecall
     5d8:	00000073          	ecall
 ret
     5dc:	8082                	ret

00000000000005de <kill>:
.global kill
kill:
 li a7, SYS_kill
     5de:	4899                	li	a7,6
 ecall
     5e0:	00000073          	ecall
 ret
     5e4:	8082                	ret

00000000000005e6 <exec>:
.global exec
exec:
 li a7, SYS_exec
     5e6:	489d                	li	a7,7
 ecall
     5e8:	00000073          	ecall
 ret
     5ec:	8082                	ret

00000000000005ee <open>:
.global open
open:
 li a7, SYS_open
     5ee:	48bd                	li	a7,15
 ecall
     5f0:	00000073          	ecall
 ret
     5f4:	8082                	ret

00000000000005f6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     5f6:	48c5                	li	a7,17
 ecall
     5f8:	00000073          	ecall
 ret
     5fc:	8082                	ret

00000000000005fe <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     5fe:	48c9                	li	a7,18
 ecall
     600:	00000073          	ecall
 ret
     604:	8082                	ret

0000000000000606 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     606:	48a1                	li	a7,8
 ecall
     608:	00000073          	ecall
 ret
     60c:	8082                	ret

000000000000060e <link>:
.global link
link:
 li a7, SYS_link
     60e:	48cd                	li	a7,19
 ecall
     610:	00000073          	ecall
 ret
     614:	8082                	ret

0000000000000616 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     616:	48d1                	li	a7,20
 ecall
     618:	00000073          	ecall
 ret
     61c:	8082                	ret

000000000000061e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     61e:	48a5                	li	a7,9
 ecall
     620:	00000073          	ecall
 ret
     624:	8082                	ret

0000000000000626 <dup>:
.global dup
dup:
 li a7, SYS_dup
     626:	48a9                	li	a7,10
 ecall
     628:	00000073          	ecall
 ret
     62c:	8082                	ret

000000000000062e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     62e:	48ad                	li	a7,11
 ecall
     630:	00000073          	ecall
 ret
     634:	8082                	ret

0000000000000636 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     636:	48b1                	li	a7,12
 ecall
     638:	00000073          	ecall
 ret
     63c:	8082                	ret

000000000000063e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     63e:	48b5                	li	a7,13
 ecall
     640:	00000073          	ecall
 ret
     644:	8082                	ret

0000000000000646 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     646:	48b9                	li	a7,14
 ecall
     648:	00000073          	ecall
 ret
     64c:	8082                	ret

000000000000064e <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     64e:	48d9                	li	a7,22
 ecall
     650:	00000073          	ecall
 ret
     654:	8082                	ret

0000000000000656 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     656:	48dd                	li	a7,23
 ecall
     658:	00000073          	ecall
 ret
     65c:	8082                	ret

000000000000065e <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     65e:	48e1                	li	a7,24
 ecall
     660:	00000073          	ecall
 ret
     664:	8082                	ret

0000000000000666 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     666:	1101                	addi	sp,sp,-32
     668:	ec06                	sd	ra,24(sp)
     66a:	e822                	sd	s0,16(sp)
     66c:	1000                	addi	s0,sp,32
     66e:	87aa                	mv	a5,a0
     670:	872e                	mv	a4,a1
     672:	fef42623          	sw	a5,-20(s0)
     676:	87ba                	mv	a5,a4
     678:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     67c:	feb40713          	addi	a4,s0,-21
     680:	fec42783          	lw	a5,-20(s0)
     684:	4605                	li	a2,1
     686:	85ba                	mv	a1,a4
     688:	853e                	mv	a0,a5
     68a:	00000097          	auipc	ra,0x0
     68e:	f44080e7          	jalr	-188(ra) # 5ce <write>
}
     692:	0001                	nop
     694:	60e2                	ld	ra,24(sp)
     696:	6442                	ld	s0,16(sp)
     698:	6105                	addi	sp,sp,32
     69a:	8082                	ret

000000000000069c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     69c:	7139                	addi	sp,sp,-64
     69e:	fc06                	sd	ra,56(sp)
     6a0:	f822                	sd	s0,48(sp)
     6a2:	0080                	addi	s0,sp,64
     6a4:	87aa                	mv	a5,a0
     6a6:	8736                	mv	a4,a3
     6a8:	fcf42623          	sw	a5,-52(s0)
     6ac:	87ae                	mv	a5,a1
     6ae:	fcf42423          	sw	a5,-56(s0)
     6b2:	87b2                	mv	a5,a2
     6b4:	fcf42223          	sw	a5,-60(s0)
     6b8:	87ba                	mv	a5,a4
     6ba:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     6be:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     6c2:	fc042783          	lw	a5,-64(s0)
     6c6:	2781                	sext.w	a5,a5
     6c8:	c38d                	beqz	a5,6ea <printint+0x4e>
     6ca:	fc842783          	lw	a5,-56(s0)
     6ce:	2781                	sext.w	a5,a5
     6d0:	0007dd63          	bgez	a5,6ea <printint+0x4e>
    neg = 1;
     6d4:	4785                	li	a5,1
     6d6:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     6da:	fc842783          	lw	a5,-56(s0)
     6de:	40f007bb          	negw	a5,a5
     6e2:	2781                	sext.w	a5,a5
     6e4:	fef42223          	sw	a5,-28(s0)
     6e8:	a029                	j	6f2 <printint+0x56>
  } else {
    x = xx;
     6ea:	fc842783          	lw	a5,-56(s0)
     6ee:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     6f2:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     6f6:	fc442783          	lw	a5,-60(s0)
     6fa:	fe442703          	lw	a4,-28(s0)
     6fe:	02f777bb          	remuw	a5,a4,a5
     702:	0007861b          	sext.w	a2,a5
     706:	fec42783          	lw	a5,-20(s0)
     70a:	0017871b          	addiw	a4,a5,1
     70e:	fee42623          	sw	a4,-20(s0)
     712:	00001697          	auipc	a3,0x1
     716:	f0e68693          	addi	a3,a3,-242 # 1620 <digits>
     71a:	02061713          	slli	a4,a2,0x20
     71e:	9301                	srli	a4,a4,0x20
     720:	9736                	add	a4,a4,a3
     722:	00074703          	lbu	a4,0(a4)
     726:	ff040693          	addi	a3,s0,-16
     72a:	97b6                	add	a5,a5,a3
     72c:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     730:	fc442783          	lw	a5,-60(s0)
     734:	fe442703          	lw	a4,-28(s0)
     738:	02f757bb          	divuw	a5,a4,a5
     73c:	fef42223          	sw	a5,-28(s0)
     740:	fe442783          	lw	a5,-28(s0)
     744:	2781                	sext.w	a5,a5
     746:	fbc5                	bnez	a5,6f6 <printint+0x5a>
  if(neg)
     748:	fe842783          	lw	a5,-24(s0)
     74c:	2781                	sext.w	a5,a5
     74e:	cf95                	beqz	a5,78a <printint+0xee>
    buf[i++] = '-';
     750:	fec42783          	lw	a5,-20(s0)
     754:	0017871b          	addiw	a4,a5,1
     758:	fee42623          	sw	a4,-20(s0)
     75c:	ff040713          	addi	a4,s0,-16
     760:	97ba                	add	a5,a5,a4
     762:	02d00713          	li	a4,45
     766:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     76a:	a005                	j	78a <printint+0xee>
    putc(fd, buf[i]);
     76c:	fec42783          	lw	a5,-20(s0)
     770:	ff040713          	addi	a4,s0,-16
     774:	97ba                	add	a5,a5,a4
     776:	fe07c703          	lbu	a4,-32(a5)
     77a:	fcc42783          	lw	a5,-52(s0)
     77e:	85ba                	mv	a1,a4
     780:	853e                	mv	a0,a5
     782:	00000097          	auipc	ra,0x0
     786:	ee4080e7          	jalr	-284(ra) # 666 <putc>
  while(--i >= 0)
     78a:	fec42783          	lw	a5,-20(s0)
     78e:	37fd                	addiw	a5,a5,-1
     790:	fef42623          	sw	a5,-20(s0)
     794:	fec42783          	lw	a5,-20(s0)
     798:	2781                	sext.w	a5,a5
     79a:	fc07d9e3          	bgez	a5,76c <printint+0xd0>
}
     79e:	0001                	nop
     7a0:	0001                	nop
     7a2:	70e2                	ld	ra,56(sp)
     7a4:	7442                	ld	s0,48(sp)
     7a6:	6121                	addi	sp,sp,64
     7a8:	8082                	ret

00000000000007aa <printptr>:

static void
printptr(int fd, uint64 x) {
     7aa:	7179                	addi	sp,sp,-48
     7ac:	f406                	sd	ra,40(sp)
     7ae:	f022                	sd	s0,32(sp)
     7b0:	1800                	addi	s0,sp,48
     7b2:	87aa                	mv	a5,a0
     7b4:	fcb43823          	sd	a1,-48(s0)
     7b8:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     7bc:	fdc42783          	lw	a5,-36(s0)
     7c0:	03000593          	li	a1,48
     7c4:	853e                	mv	a0,a5
     7c6:	00000097          	auipc	ra,0x0
     7ca:	ea0080e7          	jalr	-352(ra) # 666 <putc>
  putc(fd, 'x');
     7ce:	fdc42783          	lw	a5,-36(s0)
     7d2:	07800593          	li	a1,120
     7d6:	853e                	mv	a0,a5
     7d8:	00000097          	auipc	ra,0x0
     7dc:	e8e080e7          	jalr	-370(ra) # 666 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     7e0:	fe042623          	sw	zero,-20(s0)
     7e4:	a82d                	j	81e <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     7e6:	fd043783          	ld	a5,-48(s0)
     7ea:	93f1                	srli	a5,a5,0x3c
     7ec:	00001717          	auipc	a4,0x1
     7f0:	e3470713          	addi	a4,a4,-460 # 1620 <digits>
     7f4:	97ba                	add	a5,a5,a4
     7f6:	0007c703          	lbu	a4,0(a5)
     7fa:	fdc42783          	lw	a5,-36(s0)
     7fe:	85ba                	mv	a1,a4
     800:	853e                	mv	a0,a5
     802:	00000097          	auipc	ra,0x0
     806:	e64080e7          	jalr	-412(ra) # 666 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     80a:	fec42783          	lw	a5,-20(s0)
     80e:	2785                	addiw	a5,a5,1
     810:	fef42623          	sw	a5,-20(s0)
     814:	fd043783          	ld	a5,-48(s0)
     818:	0792                	slli	a5,a5,0x4
     81a:	fcf43823          	sd	a5,-48(s0)
     81e:	fec42783          	lw	a5,-20(s0)
     822:	873e                	mv	a4,a5
     824:	47bd                	li	a5,15
     826:	fce7f0e3          	bgeu	a5,a4,7e6 <printptr+0x3c>
}
     82a:	0001                	nop
     82c:	0001                	nop
     82e:	70a2                	ld	ra,40(sp)
     830:	7402                	ld	s0,32(sp)
     832:	6145                	addi	sp,sp,48
     834:	8082                	ret

0000000000000836 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     836:	715d                	addi	sp,sp,-80
     838:	e486                	sd	ra,72(sp)
     83a:	e0a2                	sd	s0,64(sp)
     83c:	0880                	addi	s0,sp,80
     83e:	87aa                	mv	a5,a0
     840:	fcb43023          	sd	a1,-64(s0)
     844:	fac43c23          	sd	a2,-72(s0)
     848:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     84c:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     850:	fe042223          	sw	zero,-28(s0)
     854:	a42d                	j	a7e <vprintf+0x248>
    c = fmt[i] & 0xff;
     856:	fe442783          	lw	a5,-28(s0)
     85a:	fc043703          	ld	a4,-64(s0)
     85e:	97ba                	add	a5,a5,a4
     860:	0007c783          	lbu	a5,0(a5)
     864:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     868:	fe042783          	lw	a5,-32(s0)
     86c:	2781                	sext.w	a5,a5
     86e:	eb9d                	bnez	a5,8a4 <vprintf+0x6e>
      if(c == '%'){
     870:	fdc42783          	lw	a5,-36(s0)
     874:	0007871b          	sext.w	a4,a5
     878:	02500793          	li	a5,37
     87c:	00f71763          	bne	a4,a5,88a <vprintf+0x54>
        state = '%';
     880:	02500793          	li	a5,37
     884:	fef42023          	sw	a5,-32(s0)
     888:	a2f5                	j	a74 <vprintf+0x23e>
      } else {
        putc(fd, c);
     88a:	fdc42783          	lw	a5,-36(s0)
     88e:	0ff7f713          	andi	a4,a5,255
     892:	fcc42783          	lw	a5,-52(s0)
     896:	85ba                	mv	a1,a4
     898:	853e                	mv	a0,a5
     89a:	00000097          	auipc	ra,0x0
     89e:	dcc080e7          	jalr	-564(ra) # 666 <putc>
     8a2:	aac9                	j	a74 <vprintf+0x23e>
      }
    } else if(state == '%'){
     8a4:	fe042783          	lw	a5,-32(s0)
     8a8:	0007871b          	sext.w	a4,a5
     8ac:	02500793          	li	a5,37
     8b0:	1cf71263          	bne	a4,a5,a74 <vprintf+0x23e>
      if(c == 'd'){
     8b4:	fdc42783          	lw	a5,-36(s0)
     8b8:	0007871b          	sext.w	a4,a5
     8bc:	06400793          	li	a5,100
     8c0:	02f71463          	bne	a4,a5,8e8 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     8c4:	fb843783          	ld	a5,-72(s0)
     8c8:	00878713          	addi	a4,a5,8
     8cc:	fae43c23          	sd	a4,-72(s0)
     8d0:	4398                	lw	a4,0(a5)
     8d2:	fcc42783          	lw	a5,-52(s0)
     8d6:	4685                	li	a3,1
     8d8:	4629                	li	a2,10
     8da:	85ba                	mv	a1,a4
     8dc:	853e                	mv	a0,a5
     8de:	00000097          	auipc	ra,0x0
     8e2:	dbe080e7          	jalr	-578(ra) # 69c <printint>
     8e6:	a269                	j	a70 <vprintf+0x23a>
      } else if(c == 'l') {
     8e8:	fdc42783          	lw	a5,-36(s0)
     8ec:	0007871b          	sext.w	a4,a5
     8f0:	06c00793          	li	a5,108
     8f4:	02f71663          	bne	a4,a5,920 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     8f8:	fb843783          	ld	a5,-72(s0)
     8fc:	00878713          	addi	a4,a5,8
     900:	fae43c23          	sd	a4,-72(s0)
     904:	639c                	ld	a5,0(a5)
     906:	0007871b          	sext.w	a4,a5
     90a:	fcc42783          	lw	a5,-52(s0)
     90e:	4681                	li	a3,0
     910:	4629                	li	a2,10
     912:	85ba                	mv	a1,a4
     914:	853e                	mv	a0,a5
     916:	00000097          	auipc	ra,0x0
     91a:	d86080e7          	jalr	-634(ra) # 69c <printint>
     91e:	aa89                	j	a70 <vprintf+0x23a>
      } else if(c == 'x') {
     920:	fdc42783          	lw	a5,-36(s0)
     924:	0007871b          	sext.w	a4,a5
     928:	07800793          	li	a5,120
     92c:	02f71463          	bne	a4,a5,954 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     930:	fb843783          	ld	a5,-72(s0)
     934:	00878713          	addi	a4,a5,8
     938:	fae43c23          	sd	a4,-72(s0)
     93c:	4398                	lw	a4,0(a5)
     93e:	fcc42783          	lw	a5,-52(s0)
     942:	4681                	li	a3,0
     944:	4641                	li	a2,16
     946:	85ba                	mv	a1,a4
     948:	853e                	mv	a0,a5
     94a:	00000097          	auipc	ra,0x0
     94e:	d52080e7          	jalr	-686(ra) # 69c <printint>
     952:	aa39                	j	a70 <vprintf+0x23a>
      } else if(c == 'p') {
     954:	fdc42783          	lw	a5,-36(s0)
     958:	0007871b          	sext.w	a4,a5
     95c:	07000793          	li	a5,112
     960:	02f71263          	bne	a4,a5,984 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     964:	fb843783          	ld	a5,-72(s0)
     968:	00878713          	addi	a4,a5,8
     96c:	fae43c23          	sd	a4,-72(s0)
     970:	6398                	ld	a4,0(a5)
     972:	fcc42783          	lw	a5,-52(s0)
     976:	85ba                	mv	a1,a4
     978:	853e                	mv	a0,a5
     97a:	00000097          	auipc	ra,0x0
     97e:	e30080e7          	jalr	-464(ra) # 7aa <printptr>
     982:	a0fd                	j	a70 <vprintf+0x23a>
      } else if(c == 's'){
     984:	fdc42783          	lw	a5,-36(s0)
     988:	0007871b          	sext.w	a4,a5
     98c:	07300793          	li	a5,115
     990:	04f71c63          	bne	a4,a5,9e8 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     994:	fb843783          	ld	a5,-72(s0)
     998:	00878713          	addi	a4,a5,8
     99c:	fae43c23          	sd	a4,-72(s0)
     9a0:	639c                	ld	a5,0(a5)
     9a2:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     9a6:	fe843783          	ld	a5,-24(s0)
     9aa:	eb8d                	bnez	a5,9dc <vprintf+0x1a6>
          s = "(null)";
     9ac:	00001797          	auipc	a5,0x1
     9b0:	c5c78793          	addi	a5,a5,-932 # 1608 <schedule_dm+0x284>
     9b4:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     9b8:	a015                	j	9dc <vprintf+0x1a6>
          putc(fd, *s);
     9ba:	fe843783          	ld	a5,-24(s0)
     9be:	0007c703          	lbu	a4,0(a5)
     9c2:	fcc42783          	lw	a5,-52(s0)
     9c6:	85ba                	mv	a1,a4
     9c8:	853e                	mv	a0,a5
     9ca:	00000097          	auipc	ra,0x0
     9ce:	c9c080e7          	jalr	-868(ra) # 666 <putc>
          s++;
     9d2:	fe843783          	ld	a5,-24(s0)
     9d6:	0785                	addi	a5,a5,1
     9d8:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     9dc:	fe843783          	ld	a5,-24(s0)
     9e0:	0007c783          	lbu	a5,0(a5)
     9e4:	fbf9                	bnez	a5,9ba <vprintf+0x184>
     9e6:	a069                	j	a70 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     9e8:	fdc42783          	lw	a5,-36(s0)
     9ec:	0007871b          	sext.w	a4,a5
     9f0:	06300793          	li	a5,99
     9f4:	02f71463          	bne	a4,a5,a1c <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     9f8:	fb843783          	ld	a5,-72(s0)
     9fc:	00878713          	addi	a4,a5,8
     a00:	fae43c23          	sd	a4,-72(s0)
     a04:	439c                	lw	a5,0(a5)
     a06:	0ff7f713          	andi	a4,a5,255
     a0a:	fcc42783          	lw	a5,-52(s0)
     a0e:	85ba                	mv	a1,a4
     a10:	853e                	mv	a0,a5
     a12:	00000097          	auipc	ra,0x0
     a16:	c54080e7          	jalr	-940(ra) # 666 <putc>
     a1a:	a899                	j	a70 <vprintf+0x23a>
      } else if(c == '%'){
     a1c:	fdc42783          	lw	a5,-36(s0)
     a20:	0007871b          	sext.w	a4,a5
     a24:	02500793          	li	a5,37
     a28:	00f71f63          	bne	a4,a5,a46 <vprintf+0x210>
        putc(fd, c);
     a2c:	fdc42783          	lw	a5,-36(s0)
     a30:	0ff7f713          	andi	a4,a5,255
     a34:	fcc42783          	lw	a5,-52(s0)
     a38:	85ba                	mv	a1,a4
     a3a:	853e                	mv	a0,a5
     a3c:	00000097          	auipc	ra,0x0
     a40:	c2a080e7          	jalr	-982(ra) # 666 <putc>
     a44:	a035                	j	a70 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     a46:	fcc42783          	lw	a5,-52(s0)
     a4a:	02500593          	li	a1,37
     a4e:	853e                	mv	a0,a5
     a50:	00000097          	auipc	ra,0x0
     a54:	c16080e7          	jalr	-1002(ra) # 666 <putc>
        putc(fd, c);
     a58:	fdc42783          	lw	a5,-36(s0)
     a5c:	0ff7f713          	andi	a4,a5,255
     a60:	fcc42783          	lw	a5,-52(s0)
     a64:	85ba                	mv	a1,a4
     a66:	853e                	mv	a0,a5
     a68:	00000097          	auipc	ra,0x0
     a6c:	bfe080e7          	jalr	-1026(ra) # 666 <putc>
      }
      state = 0;
     a70:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     a74:	fe442783          	lw	a5,-28(s0)
     a78:	2785                	addiw	a5,a5,1
     a7a:	fef42223          	sw	a5,-28(s0)
     a7e:	fe442783          	lw	a5,-28(s0)
     a82:	fc043703          	ld	a4,-64(s0)
     a86:	97ba                	add	a5,a5,a4
     a88:	0007c783          	lbu	a5,0(a5)
     a8c:	dc0795e3          	bnez	a5,856 <vprintf+0x20>
    }
  }
}
     a90:	0001                	nop
     a92:	0001                	nop
     a94:	60a6                	ld	ra,72(sp)
     a96:	6406                	ld	s0,64(sp)
     a98:	6161                	addi	sp,sp,80
     a9a:	8082                	ret

0000000000000a9c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     a9c:	7159                	addi	sp,sp,-112
     a9e:	fc06                	sd	ra,56(sp)
     aa0:	f822                	sd	s0,48(sp)
     aa2:	0080                	addi	s0,sp,64
     aa4:	fcb43823          	sd	a1,-48(s0)
     aa8:	e010                	sd	a2,0(s0)
     aaa:	e414                	sd	a3,8(s0)
     aac:	e818                	sd	a4,16(s0)
     aae:	ec1c                	sd	a5,24(s0)
     ab0:	03043023          	sd	a6,32(s0)
     ab4:	03143423          	sd	a7,40(s0)
     ab8:	87aa                	mv	a5,a0
     aba:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     abe:	03040793          	addi	a5,s0,48
     ac2:	fcf43423          	sd	a5,-56(s0)
     ac6:	fc843783          	ld	a5,-56(s0)
     aca:	fd078793          	addi	a5,a5,-48
     ace:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     ad2:	fe843703          	ld	a4,-24(s0)
     ad6:	fdc42783          	lw	a5,-36(s0)
     ada:	863a                	mv	a2,a4
     adc:	fd043583          	ld	a1,-48(s0)
     ae0:	853e                	mv	a0,a5
     ae2:	00000097          	auipc	ra,0x0
     ae6:	d54080e7          	jalr	-684(ra) # 836 <vprintf>
}
     aea:	0001                	nop
     aec:	70e2                	ld	ra,56(sp)
     aee:	7442                	ld	s0,48(sp)
     af0:	6165                	addi	sp,sp,112
     af2:	8082                	ret

0000000000000af4 <printf>:

void
printf(const char *fmt, ...)
{
     af4:	7159                	addi	sp,sp,-112
     af6:	f406                	sd	ra,40(sp)
     af8:	f022                	sd	s0,32(sp)
     afa:	1800                	addi	s0,sp,48
     afc:	fca43c23          	sd	a0,-40(s0)
     b00:	e40c                	sd	a1,8(s0)
     b02:	e810                	sd	a2,16(s0)
     b04:	ec14                	sd	a3,24(s0)
     b06:	f018                	sd	a4,32(s0)
     b08:	f41c                	sd	a5,40(s0)
     b0a:	03043823          	sd	a6,48(s0)
     b0e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     b12:	04040793          	addi	a5,s0,64
     b16:	fcf43823          	sd	a5,-48(s0)
     b1a:	fd043783          	ld	a5,-48(s0)
     b1e:	fc878793          	addi	a5,a5,-56
     b22:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     b26:	fe843783          	ld	a5,-24(s0)
     b2a:	863e                	mv	a2,a5
     b2c:	fd843583          	ld	a1,-40(s0)
     b30:	4505                	li	a0,1
     b32:	00000097          	auipc	ra,0x0
     b36:	d04080e7          	jalr	-764(ra) # 836 <vprintf>
}
     b3a:	0001                	nop
     b3c:	70a2                	ld	ra,40(sp)
     b3e:	7402                	ld	s0,32(sp)
     b40:	6165                	addi	sp,sp,112
     b42:	8082                	ret

0000000000000b44 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     b44:	7179                	addi	sp,sp,-48
     b46:	f422                	sd	s0,40(sp)
     b48:	1800                	addi	s0,sp,48
     b4a:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     b4e:	fd843783          	ld	a5,-40(s0)
     b52:	17c1                	addi	a5,a5,-16
     b54:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b58:	00001797          	auipc	a5,0x1
     b5c:	af078793          	addi	a5,a5,-1296 # 1648 <freep>
     b60:	639c                	ld	a5,0(a5)
     b62:	fef43423          	sd	a5,-24(s0)
     b66:	a815                	j	b9a <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     b68:	fe843783          	ld	a5,-24(s0)
     b6c:	639c                	ld	a5,0(a5)
     b6e:	fe843703          	ld	a4,-24(s0)
     b72:	00f76f63          	bltu	a4,a5,b90 <free+0x4c>
     b76:	fe043703          	ld	a4,-32(s0)
     b7a:	fe843783          	ld	a5,-24(s0)
     b7e:	02e7eb63          	bltu	a5,a4,bb4 <free+0x70>
     b82:	fe843783          	ld	a5,-24(s0)
     b86:	639c                	ld	a5,0(a5)
     b88:	fe043703          	ld	a4,-32(s0)
     b8c:	02f76463          	bltu	a4,a5,bb4 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b90:	fe843783          	ld	a5,-24(s0)
     b94:	639c                	ld	a5,0(a5)
     b96:	fef43423          	sd	a5,-24(s0)
     b9a:	fe043703          	ld	a4,-32(s0)
     b9e:	fe843783          	ld	a5,-24(s0)
     ba2:	fce7f3e3          	bgeu	a5,a4,b68 <free+0x24>
     ba6:	fe843783          	ld	a5,-24(s0)
     baa:	639c                	ld	a5,0(a5)
     bac:	fe043703          	ld	a4,-32(s0)
     bb0:	faf77ce3          	bgeu	a4,a5,b68 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     bb4:	fe043783          	ld	a5,-32(s0)
     bb8:	479c                	lw	a5,8(a5)
     bba:	1782                	slli	a5,a5,0x20
     bbc:	9381                	srli	a5,a5,0x20
     bbe:	0792                	slli	a5,a5,0x4
     bc0:	fe043703          	ld	a4,-32(s0)
     bc4:	973e                	add	a4,a4,a5
     bc6:	fe843783          	ld	a5,-24(s0)
     bca:	639c                	ld	a5,0(a5)
     bcc:	02f71763          	bne	a4,a5,bfa <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     bd0:	fe043783          	ld	a5,-32(s0)
     bd4:	4798                	lw	a4,8(a5)
     bd6:	fe843783          	ld	a5,-24(s0)
     bda:	639c                	ld	a5,0(a5)
     bdc:	479c                	lw	a5,8(a5)
     bde:	9fb9                	addw	a5,a5,a4
     be0:	0007871b          	sext.w	a4,a5
     be4:	fe043783          	ld	a5,-32(s0)
     be8:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     bea:	fe843783          	ld	a5,-24(s0)
     bee:	639c                	ld	a5,0(a5)
     bf0:	6398                	ld	a4,0(a5)
     bf2:	fe043783          	ld	a5,-32(s0)
     bf6:	e398                	sd	a4,0(a5)
     bf8:	a039                	j	c06 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     bfa:	fe843783          	ld	a5,-24(s0)
     bfe:	6398                	ld	a4,0(a5)
     c00:	fe043783          	ld	a5,-32(s0)
     c04:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     c06:	fe843783          	ld	a5,-24(s0)
     c0a:	479c                	lw	a5,8(a5)
     c0c:	1782                	slli	a5,a5,0x20
     c0e:	9381                	srli	a5,a5,0x20
     c10:	0792                	slli	a5,a5,0x4
     c12:	fe843703          	ld	a4,-24(s0)
     c16:	97ba                	add	a5,a5,a4
     c18:	fe043703          	ld	a4,-32(s0)
     c1c:	02f71563          	bne	a4,a5,c46 <free+0x102>
    p->s.size += bp->s.size;
     c20:	fe843783          	ld	a5,-24(s0)
     c24:	4798                	lw	a4,8(a5)
     c26:	fe043783          	ld	a5,-32(s0)
     c2a:	479c                	lw	a5,8(a5)
     c2c:	9fb9                	addw	a5,a5,a4
     c2e:	0007871b          	sext.w	a4,a5
     c32:	fe843783          	ld	a5,-24(s0)
     c36:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     c38:	fe043783          	ld	a5,-32(s0)
     c3c:	6398                	ld	a4,0(a5)
     c3e:	fe843783          	ld	a5,-24(s0)
     c42:	e398                	sd	a4,0(a5)
     c44:	a031                	j	c50 <free+0x10c>
  } else
    p->s.ptr = bp;
     c46:	fe843783          	ld	a5,-24(s0)
     c4a:	fe043703          	ld	a4,-32(s0)
     c4e:	e398                	sd	a4,0(a5)
  freep = p;
     c50:	00001797          	auipc	a5,0x1
     c54:	9f878793          	addi	a5,a5,-1544 # 1648 <freep>
     c58:	fe843703          	ld	a4,-24(s0)
     c5c:	e398                	sd	a4,0(a5)
}
     c5e:	0001                	nop
     c60:	7422                	ld	s0,40(sp)
     c62:	6145                	addi	sp,sp,48
     c64:	8082                	ret

0000000000000c66 <morecore>:

static Header*
morecore(uint nu)
{
     c66:	7179                	addi	sp,sp,-48
     c68:	f406                	sd	ra,40(sp)
     c6a:	f022                	sd	s0,32(sp)
     c6c:	1800                	addi	s0,sp,48
     c6e:	87aa                	mv	a5,a0
     c70:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     c74:	fdc42783          	lw	a5,-36(s0)
     c78:	0007871b          	sext.w	a4,a5
     c7c:	6785                	lui	a5,0x1
     c7e:	00f77563          	bgeu	a4,a5,c88 <morecore+0x22>
    nu = 4096;
     c82:	6785                	lui	a5,0x1
     c84:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     c88:	fdc42783          	lw	a5,-36(s0)
     c8c:	0047979b          	slliw	a5,a5,0x4
     c90:	2781                	sext.w	a5,a5
     c92:	2781                	sext.w	a5,a5
     c94:	853e                	mv	a0,a5
     c96:	00000097          	auipc	ra,0x0
     c9a:	9a0080e7          	jalr	-1632(ra) # 636 <sbrk>
     c9e:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     ca2:	fe843703          	ld	a4,-24(s0)
     ca6:	57fd                	li	a5,-1
     ca8:	00f71463          	bne	a4,a5,cb0 <morecore+0x4a>
    return 0;
     cac:	4781                	li	a5,0
     cae:	a03d                	j	cdc <morecore+0x76>
  hp = (Header*)p;
     cb0:	fe843783          	ld	a5,-24(s0)
     cb4:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     cb8:	fe043783          	ld	a5,-32(s0)
     cbc:	fdc42703          	lw	a4,-36(s0)
     cc0:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     cc2:	fe043783          	ld	a5,-32(s0)
     cc6:	07c1                	addi	a5,a5,16
     cc8:	853e                	mv	a0,a5
     cca:	00000097          	auipc	ra,0x0
     cce:	e7a080e7          	jalr	-390(ra) # b44 <free>
  return freep;
     cd2:	00001797          	auipc	a5,0x1
     cd6:	97678793          	addi	a5,a5,-1674 # 1648 <freep>
     cda:	639c                	ld	a5,0(a5)
}
     cdc:	853e                	mv	a0,a5
     cde:	70a2                	ld	ra,40(sp)
     ce0:	7402                	ld	s0,32(sp)
     ce2:	6145                	addi	sp,sp,48
     ce4:	8082                	ret

0000000000000ce6 <malloc>:

void*
malloc(uint nbytes)
{
     ce6:	7139                	addi	sp,sp,-64
     ce8:	fc06                	sd	ra,56(sp)
     cea:	f822                	sd	s0,48(sp)
     cec:	0080                	addi	s0,sp,64
     cee:	87aa                	mv	a5,a0
     cf0:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     cf4:	fcc46783          	lwu	a5,-52(s0)
     cf8:	07bd                	addi	a5,a5,15
     cfa:	8391                	srli	a5,a5,0x4
     cfc:	2781                	sext.w	a5,a5
     cfe:	2785                	addiw	a5,a5,1
     d00:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     d04:	00001797          	auipc	a5,0x1
     d08:	94478793          	addi	a5,a5,-1724 # 1648 <freep>
     d0c:	639c                	ld	a5,0(a5)
     d0e:	fef43023          	sd	a5,-32(s0)
     d12:	fe043783          	ld	a5,-32(s0)
     d16:	ef95                	bnez	a5,d52 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     d18:	00001797          	auipc	a5,0x1
     d1c:	92078793          	addi	a5,a5,-1760 # 1638 <base>
     d20:	fef43023          	sd	a5,-32(s0)
     d24:	00001797          	auipc	a5,0x1
     d28:	92478793          	addi	a5,a5,-1756 # 1648 <freep>
     d2c:	fe043703          	ld	a4,-32(s0)
     d30:	e398                	sd	a4,0(a5)
     d32:	00001797          	auipc	a5,0x1
     d36:	91678793          	addi	a5,a5,-1770 # 1648 <freep>
     d3a:	6398                	ld	a4,0(a5)
     d3c:	00001797          	auipc	a5,0x1
     d40:	8fc78793          	addi	a5,a5,-1796 # 1638 <base>
     d44:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     d46:	00001797          	auipc	a5,0x1
     d4a:	8f278793          	addi	a5,a5,-1806 # 1638 <base>
     d4e:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     d52:	fe043783          	ld	a5,-32(s0)
     d56:	639c                	ld	a5,0(a5)
     d58:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     d5c:	fe843783          	ld	a5,-24(s0)
     d60:	4798                	lw	a4,8(a5)
     d62:	fdc42783          	lw	a5,-36(s0)
     d66:	2781                	sext.w	a5,a5
     d68:	06f76863          	bltu	a4,a5,dd8 <malloc+0xf2>
      if(p->s.size == nunits)
     d6c:	fe843783          	ld	a5,-24(s0)
     d70:	4798                	lw	a4,8(a5)
     d72:	fdc42783          	lw	a5,-36(s0)
     d76:	2781                	sext.w	a5,a5
     d78:	00e79963          	bne	a5,a4,d8a <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     d7c:	fe843783          	ld	a5,-24(s0)
     d80:	6398                	ld	a4,0(a5)
     d82:	fe043783          	ld	a5,-32(s0)
     d86:	e398                	sd	a4,0(a5)
     d88:	a82d                	j	dc2 <malloc+0xdc>
      else {
        p->s.size -= nunits;
     d8a:	fe843783          	ld	a5,-24(s0)
     d8e:	4798                	lw	a4,8(a5)
     d90:	fdc42783          	lw	a5,-36(s0)
     d94:	40f707bb          	subw	a5,a4,a5
     d98:	0007871b          	sext.w	a4,a5
     d9c:	fe843783          	ld	a5,-24(s0)
     da0:	c798                	sw	a4,8(a5)
        p += p->s.size;
     da2:	fe843783          	ld	a5,-24(s0)
     da6:	479c                	lw	a5,8(a5)
     da8:	1782                	slli	a5,a5,0x20
     daa:	9381                	srli	a5,a5,0x20
     dac:	0792                	slli	a5,a5,0x4
     dae:	fe843703          	ld	a4,-24(s0)
     db2:	97ba                	add	a5,a5,a4
     db4:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     db8:	fe843783          	ld	a5,-24(s0)
     dbc:	fdc42703          	lw	a4,-36(s0)
     dc0:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     dc2:	00001797          	auipc	a5,0x1
     dc6:	88678793          	addi	a5,a5,-1914 # 1648 <freep>
     dca:	fe043703          	ld	a4,-32(s0)
     dce:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     dd0:	fe843783          	ld	a5,-24(s0)
     dd4:	07c1                	addi	a5,a5,16
     dd6:	a091                	j	e1a <malloc+0x134>
    }
    if(p == freep)
     dd8:	00001797          	auipc	a5,0x1
     ddc:	87078793          	addi	a5,a5,-1936 # 1648 <freep>
     de0:	639c                	ld	a5,0(a5)
     de2:	fe843703          	ld	a4,-24(s0)
     de6:	02f71063          	bne	a4,a5,e06 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     dea:	fdc42783          	lw	a5,-36(s0)
     dee:	853e                	mv	a0,a5
     df0:	00000097          	auipc	ra,0x0
     df4:	e76080e7          	jalr	-394(ra) # c66 <morecore>
     df8:	fea43423          	sd	a0,-24(s0)
     dfc:	fe843783          	ld	a5,-24(s0)
     e00:	e399                	bnez	a5,e06 <malloc+0x120>
        return 0;
     e02:	4781                	li	a5,0
     e04:	a819                	j	e1a <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     e06:	fe843783          	ld	a5,-24(s0)
     e0a:	fef43023          	sd	a5,-32(s0)
     e0e:	fe843783          	ld	a5,-24(s0)
     e12:	639c                	ld	a5,0(a5)
     e14:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     e18:	b791                	j	d5c <malloc+0x76>
  }
}
     e1a:	853e                	mv	a0,a5
     e1c:	70e2                	ld	ra,56(sp)
     e1e:	7442                	ld	s0,48(sp)
     e20:	6121                	addi	sp,sp,64
     e22:	8082                	ret

0000000000000e24 <setjmp>:
     e24:	e100                	sd	s0,0(a0)
     e26:	e504                	sd	s1,8(a0)
     e28:	01253823          	sd	s2,16(a0)
     e2c:	01353c23          	sd	s3,24(a0)
     e30:	03453023          	sd	s4,32(a0)
     e34:	03553423          	sd	s5,40(a0)
     e38:	03653823          	sd	s6,48(a0)
     e3c:	03753c23          	sd	s7,56(a0)
     e40:	05853023          	sd	s8,64(a0)
     e44:	05953423          	sd	s9,72(a0)
     e48:	05a53823          	sd	s10,80(a0)
     e4c:	05b53c23          	sd	s11,88(a0)
     e50:	06153023          	sd	ra,96(a0)
     e54:	06253423          	sd	sp,104(a0)
     e58:	4501                	li	a0,0
     e5a:	8082                	ret

0000000000000e5c <longjmp>:
     e5c:	6100                	ld	s0,0(a0)
     e5e:	6504                	ld	s1,8(a0)
     e60:	01053903          	ld	s2,16(a0)
     e64:	01853983          	ld	s3,24(a0)
     e68:	02053a03          	ld	s4,32(a0)
     e6c:	02853a83          	ld	s5,40(a0)
     e70:	03053b03          	ld	s6,48(a0)
     e74:	03853b83          	ld	s7,56(a0)
     e78:	04053c03          	ld	s8,64(a0)
     e7c:	04853c83          	ld	s9,72(a0)
     e80:	05053d03          	ld	s10,80(a0)
     e84:	05853d83          	ld	s11,88(a0)
     e88:	06053083          	ld	ra,96(a0)
     e8c:	06853103          	ld	sp,104(a0)
     e90:	c199                	beqz	a1,e96 <longjmp_1>
     e92:	852e                	mv	a0,a1
     e94:	8082                	ret

0000000000000e96 <longjmp_1>:
     e96:	4505                	li	a0,1
     e98:	8082                	ret

0000000000000e9a <schedule_default>:
#define INT_MAX 2147483647
#define TIME_QUANTUM 2  // Define a base time quantum for the round-robin

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
     e9a:	715d                	addi	sp,sp,-80
     e9c:	e4a2                	sd	s0,72(sp)
     e9e:	e0a6                	sd	s1,64(sp)
     ea0:	0880                	addi	s0,sp,80
     ea2:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
     ea4:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
     ea8:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     eac:	649c                	ld	a5,8(s1)
     eae:	639c                	ld	a5,0(a5)
     eb0:	fcf43c23          	sd	a5,-40(s0)
     eb4:	fd843783          	ld	a5,-40(s0)
     eb8:	fd878793          	addi	a5,a5,-40
     ebc:	fef43023          	sd	a5,-32(s0)
     ec0:	a81d                	j	ef6 <schedule_default+0x5c>
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
     ec2:	fe843783          	ld	a5,-24(s0)
     ec6:	cb89                	beqz	a5,ed8 <schedule_default+0x3e>
     ec8:	fe043783          	ld	a5,-32(s0)
     ecc:	5fd8                	lw	a4,60(a5)
     ece:	fe843783          	ld	a5,-24(s0)
     ed2:	5fdc                	lw	a5,60(a5)
     ed4:	00f75663          	bge	a4,a5,ee0 <schedule_default+0x46>
            thread_with_smallest_id = th;
     ed8:	fe043783          	ld	a5,-32(s0)
     edc:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     ee0:	fe043783          	ld	a5,-32(s0)
     ee4:	779c                	ld	a5,40(a5)
     ee6:	fcf43823          	sd	a5,-48(s0)
     eea:	fd043783          	ld	a5,-48(s0)
     eee:	fd878793          	addi	a5,a5,-40
     ef2:	fef43023          	sd	a5,-32(s0)
     ef6:	fe043783          	ld	a5,-32(s0)
     efa:	02878713          	addi	a4,a5,40
     efe:	649c                	ld	a5,8(s1)
     f00:	fcf711e3          	bne	a4,a5,ec2 <schedule_default+0x28>
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
     f04:	fe843783          	ld	a5,-24(s0)
     f08:	cf89                	beqz	a5,f22 <schedule_default+0x88>
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
     f0a:	fe843783          	ld	a5,-24(s0)
     f0e:	02878793          	addi	a5,a5,40
     f12:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
     f16:	fe843783          	ld	a5,-24(s0)
     f1a:	4fbc                	lw	a5,88(a5)
     f1c:	faf42c23          	sw	a5,-72(s0)
     f20:	a039                	j	f2e <schedule_default+0x94>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
     f22:	649c                	ld	a5,8(s1)
     f24:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
     f28:	4785                	li	a5,1
     f2a:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
     f2e:	fb043783          	ld	a5,-80(s0)
     f32:	fcf43023          	sd	a5,-64(s0)
     f36:	fb843783          	ld	a5,-72(s0)
     f3a:	fcf43423          	sd	a5,-56(s0)
     f3e:	4701                	li	a4,0
     f40:	fc043703          	ld	a4,-64(s0)
     f44:	4781                	li	a5,0
     f46:	fc843783          	ld	a5,-56(s0)
     f4a:	863a                	mv	a2,a4
     f4c:	86be                	mv	a3,a5
     f4e:	8732                	mv	a4,a2
     f50:	87b6                	mv	a5,a3
}
     f52:	853a                	mv	a0,a4
     f54:	85be                	mv	a1,a5
     f56:	6426                	ld	s0,72(sp)
     f58:	6486                	ld	s1,64(sp)
     f5a:	6161                	addi	sp,sp,80
     f5c:	8082                	ret

0000000000000f5e <schedule_wrr>:

/* MP3 Part 1 - Non-Real-Time Scheduling */
/* Weighted-Round-Robin Scheduling */
struct threads_sched_result schedule_wrr(struct threads_sched_args args)
{
     f5e:	7159                	addi	sp,sp,-112
     f60:	f4a2                	sd	s0,104(sp)
     f62:	f0a6                	sd	s1,96(sp)
     f64:	1880                	addi	s0,sp,112
     f66:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the weighted round-robin scheduling algorithm
    static struct thread *last_thread = NULL;
    struct thread *selected_thread = NULL;
     f68:	fe043423          	sd	zero,-24(s0)
    int max_priority = -1;
     f6c:	57fd                	li	a5,-1
     f6e:	fef42223          	sw	a5,-28(s0)

    // If last_thread is NULL or its remaining time is zero, reset the selection process
    if (last_thread == NULL || last_thread->remaining_time <= 0) {
     f72:	00000797          	auipc	a5,0x0
     f76:	6de78793          	addi	a5,a5,1758 # 1650 <last_thread.1226>
     f7a:	639c                	ld	a5,0(a5)
     f7c:	cb89                	beqz	a5,f8e <schedule_wrr+0x30>
     f7e:	00000797          	auipc	a5,0x0
     f82:	6d278793          	addi	a5,a5,1746 # 1650 <last_thread.1226>
     f86:	639c                	ld	a5,0(a5)
     f88:	4fbc                	lw	a5,88(a5)
     f8a:	00f04863          	bgtz	a5,f9a <schedule_wrr+0x3c>
        last_thread = NULL;
     f8e:	00000797          	auipc	a5,0x0
     f92:	6c278793          	addi	a5,a5,1730 # 1650 <last_thread.1226>
     f96:	0007b023          	sd	zero,0(a5)
    }

    struct thread *candidate = NULL;
     f9a:	fc043c23          	sd	zero,-40(s0)
    // Select the next thread to run based on weight and ensure round-robin fairness
    list_for_each_entry(candidate, args.run_queue, thread_list) {
     f9e:	649c                	ld	a5,8(s1)
     fa0:	639c                	ld	a5,0(a5)
     fa2:	fcf43423          	sd	a5,-56(s0)
     fa6:	fc843783          	ld	a5,-56(s0)
     faa:	fd878793          	addi	a5,a5,-40
     fae:	fcf43c23          	sd	a5,-40(s0)
     fb2:	a8a1                	j	100a <schedule_wrr+0xac>
        if (candidate != last_thread) {
     fb4:	00000797          	auipc	a5,0x0
     fb8:	69c78793          	addi	a5,a5,1692 # 1650 <last_thread.1226>
     fbc:	639c                	ld	a5,0(a5)
     fbe:	fd843703          	ld	a4,-40(s0)
     fc2:	02f70963          	beq	a4,a5,ff4 <schedule_wrr+0x96>
            int priority = candidate->weight * TIME_QUANTUM;
     fc6:	fd843783          	ld	a5,-40(s0)
     fca:	47bc                	lw	a5,72(a5)
     fcc:	0017979b          	slliw	a5,a5,0x1
     fd0:	fcf42223          	sw	a5,-60(s0)
            if (priority > max_priority) {
     fd4:	fc442703          	lw	a4,-60(s0)
     fd8:	fe442783          	lw	a5,-28(s0)
     fdc:	2701                	sext.w	a4,a4
     fde:	2781                	sext.w	a5,a5
     fe0:	00e7da63          	bge	a5,a4,ff4 <schedule_wrr+0x96>
                selected_thread = candidate;
     fe4:	fd843783          	ld	a5,-40(s0)
     fe8:	fef43423          	sd	a5,-24(s0)
                max_priority = priority;
     fec:	fc442783          	lw	a5,-60(s0)
     ff0:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(candidate, args.run_queue, thread_list) {
     ff4:	fd843783          	ld	a5,-40(s0)
     ff8:	779c                	ld	a5,40(a5)
     ffa:	faf43c23          	sd	a5,-72(s0)
     ffe:	fb843783          	ld	a5,-72(s0)
    1002:	fd878793          	addi	a5,a5,-40
    1006:	fcf43c23          	sd	a5,-40(s0)
    100a:	fd843783          	ld	a5,-40(s0)
    100e:	02878713          	addi	a4,a5,40
    1012:	649c                	ld	a5,8(s1)
    1014:	faf710e3          	bne	a4,a5,fb4 <schedule_wrr+0x56>
            }
        }
    }

    // Fall back to the last_thread if no other thread is selected and it still has remaining time
    if (!selected_thread && last_thread && last_thread->remaining_time > 0) {
    1018:	fe843783          	ld	a5,-24(s0)
    101c:	e795                	bnez	a5,1048 <schedule_wrr+0xea>
    101e:	00000797          	auipc	a5,0x0
    1022:	63278793          	addi	a5,a5,1586 # 1650 <last_thread.1226>
    1026:	639c                	ld	a5,0(a5)
    1028:	c385                	beqz	a5,1048 <schedule_wrr+0xea>
    102a:	00000797          	auipc	a5,0x0
    102e:	62678793          	addi	a5,a5,1574 # 1650 <last_thread.1226>
    1032:	639c                	ld	a5,0(a5)
    1034:	4fbc                	lw	a5,88(a5)
    1036:	00f05963          	blez	a5,1048 <schedule_wrr+0xea>
        selected_thread = last_thread;
    103a:	00000797          	auipc	a5,0x0
    103e:	61678793          	addi	a5,a5,1558 # 1650 <last_thread.1226>
    1042:	639c                	ld	a5,0(a5)
    1044:	fef43423          	sd	a5,-24(s0)
    }

    // Set the scheduling result
    if (selected_thread) {
    1048:	fe843783          	ld	a5,-24(s0)
    104c:	c7b9                	beqz	a5,109a <schedule_wrr+0x13c>
        int time_slice = selected_thread->weight * TIME_QUANTUM;
    104e:	fe843783          	ld	a5,-24(s0)
    1052:	47bc                	lw	a5,72(a5)
    1054:	0017979b          	slliw	a5,a5,0x1
    1058:	fcf42a23          	sw	a5,-44(s0)
        if (time_slice > selected_thread->remaining_time) {
    105c:	fe843783          	ld	a5,-24(s0)
    1060:	4fb8                	lw	a4,88(a5)
    1062:	fd442783          	lw	a5,-44(s0)
    1066:	2781                	sext.w	a5,a5
    1068:	00f75763          	bge	a4,a5,1076 <schedule_wrr+0x118>
            time_slice = selected_thread->remaining_time;
    106c:	fe843783          	ld	a5,-24(s0)
    1070:	4fbc                	lw	a5,88(a5)
    1072:	fcf42a23          	sw	a5,-44(s0)
        }
        r.scheduled_thread_list_member = &selected_thread->thread_list;
    1076:	fe843783          	ld	a5,-24(s0)
    107a:	02878793          	addi	a5,a5,40
    107e:	f8f43c23          	sd	a5,-104(s0)
        r.allocated_time = time_slice;
    1082:	fd442783          	lw	a5,-44(s0)
    1086:	faf42023          	sw	a5,-96(s0)
        last_thread = selected_thread;  // Update the last run thread
    108a:	00000797          	auipc	a5,0x0
    108e:	5c678793          	addi	a5,a5,1478 # 1650 <last_thread.1226>
    1092:	fe843703          	ld	a4,-24(s0)
    1096:	e398                	sd	a4,0(a5)
    1098:	a039                	j	10a6 <schedule_wrr+0x148>
    } else {
        // Idle if no suitable thread is found
        r.scheduled_thread_list_member = args.run_queue;
    109a:	649c                	ld	a5,8(s1)
    109c:	f8f43c23          	sd	a5,-104(s0)
        r.allocated_time = 1;
    10a0:	4785                	li	a5,1
    10a2:	faf42023          	sw	a5,-96(s0)
    }

    return r;
    10a6:	f9843783          	ld	a5,-104(s0)
    10aa:	faf43423          	sd	a5,-88(s0)
    10ae:	fa043783          	ld	a5,-96(s0)
    10b2:	faf43823          	sd	a5,-80(s0)
    10b6:	4701                	li	a4,0
    10b8:	fa843703          	ld	a4,-88(s0)
    10bc:	4781                	li	a5,0
    10be:	fb043783          	ld	a5,-80(s0)
    10c2:	863a                	mv	a2,a4
    10c4:	86be                	mv	a3,a5
    10c6:	8732                	mv	a4,a2
    10c8:	87b6                	mv	a5,a3
}
    10ca:	853a                	mv	a0,a4
    10cc:	85be                	mv	a1,a5
    10ce:	7426                	ld	s0,104(sp)
    10d0:	7486                	ld	s1,96(sp)
    10d2:	6165                	addi	sp,sp,112
    10d4:	8082                	ret

00000000000010d6 <find_next_release_time>:

/* Shortest-Job-First Scheduling */
int find_next_release_time(struct list_head *release_queue, int current_time) {
    10d6:	7139                	addi	sp,sp,-64
    10d8:	fc22                	sd	s0,56(sp)
    10da:	0080                	addi	s0,sp,64
    10dc:	fca43423          	sd	a0,-56(s0)
    10e0:	87ae                	mv	a5,a1
    10e2:	fcf42223          	sw	a5,-60(s0)
    struct release_queue_entry *next_release = NULL;
    10e6:	fe043423          	sd	zero,-24(s0)
    int next_release_time = INT_MAX;
    10ea:	800007b7          	lui	a5,0x80000
    10ee:	fff7c793          	not	a5,a5
    10f2:	fef42223          	sw	a5,-28(s0)

    list_for_each_entry(next_release, release_queue, thread_list) {
    10f6:	fc843783          	ld	a5,-56(s0)
    10fa:	639c                	ld	a5,0(a5)
    10fc:	fcf43c23          	sd	a5,-40(s0)
    1100:	fd843783          	ld	a5,-40(s0)
    1104:	17e1                	addi	a5,a5,-8
    1106:	fef43423          	sd	a5,-24(s0)
    110a:	a081                	j	114a <find_next_release_time+0x74>
        if (next_release->release_time > current_time &&
    110c:	fe843783          	ld	a5,-24(s0)
    1110:	4f98                	lw	a4,24(a5)
    1112:	fc442783          	lw	a5,-60(s0)
    1116:	2781                	sext.w	a5,a5
    1118:	00e7df63          	bge	a5,a4,1136 <find_next_release_time+0x60>
            next_release->release_time < next_release_time) {
    111c:	fe843783          	ld	a5,-24(s0)
    1120:	4f98                	lw	a4,24(a5)
        if (next_release->release_time > current_time &&
    1122:	fe442783          	lw	a5,-28(s0)
    1126:	2781                	sext.w	a5,a5
    1128:	00f75763          	bge	a4,a5,1136 <find_next_release_time+0x60>
            next_release_time = next_release->release_time;
    112c:	fe843783          	ld	a5,-24(s0)
    1130:	4f9c                	lw	a5,24(a5)
    1132:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(next_release, release_queue, thread_list) {
    1136:	fe843783          	ld	a5,-24(s0)
    113a:	679c                	ld	a5,8(a5)
    113c:	fcf43823          	sd	a5,-48(s0)
    1140:	fd043783          	ld	a5,-48(s0)
    1144:	17e1                	addi	a5,a5,-8
    1146:	fef43423          	sd	a5,-24(s0)
    114a:	fe843783          	ld	a5,-24(s0)
    114e:	07a1                	addi	a5,a5,8
    1150:	fc843703          	ld	a4,-56(s0)
    1154:	faf71ce3          	bne	a4,a5,110c <find_next_release_time+0x36>
        }
    }

    if (next_release_time == INT_MAX)
    1158:	fe442783          	lw	a5,-28(s0)
    115c:	0007871b          	sext.w	a4,a5
    1160:	800007b7          	lui	a5,0x80000
    1164:	fff7c793          	not	a5,a5
    1168:	00f71463          	bne	a4,a5,1170 <find_next_release_time+0x9a>
        return -1; // No threads in the release queue
    116c:	57fd                	li	a5,-1
    116e:	a801                	j	117e <find_next_release_time+0xa8>

    return next_release_time - current_time;
    1170:	fe442703          	lw	a4,-28(s0)
    1174:	fc442783          	lw	a5,-60(s0)
    1178:	40f707bb          	subw	a5,a4,a5
    117c:	2781                	sext.w	a5,a5
}
    117e:	853e                	mv	a0,a5
    1180:	7462                	ld	s0,56(sp)
    1182:	6121                	addi	sp,sp,64
    1184:	8082                	ret

0000000000001186 <schedule_sjf>:


struct threads_sched_result schedule_sjf(struct threads_sched_args args)
{
    1186:	711d                	addi	sp,sp,-96
    1188:	eca2                	sd	s0,88(sp)
    118a:	e8a6                	sd	s1,80(sp)
    118c:	1080                	addi	s0,sp,96
    118e:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the shortest-job-first scheduling algorithm
    struct thread *shortest_job = NULL;
    1190:	fe043423          	sd	zero,-24(s0)
    struct thread *t;
    int shortest_time = INT_MAX;
    1194:	800007b7          	lui	a5,0x80000
    1198:	fff7c793          	not	a5,a5
    119c:	fcf42e23          	sw	a5,-36(s0)

    // Find the thread with the shortest remaining time that is ready to run
    list_for_each_entry(t, args.run_queue, thread_list) {
    11a0:	649c                	ld	a5,8(s1)
    11a2:	639c                	ld	a5,0(a5)
    11a4:	fcf43823          	sd	a5,-48(s0)
    11a8:	fd043783          	ld	a5,-48(s0)
    11ac:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe1c8>
    11b0:	fef43023          	sd	a5,-32(s0)
    11b4:	a82d                	j	11ee <schedule_sjf+0x68>
        if (t->remaining_time < shortest_time) {
    11b6:	fe043783          	ld	a5,-32(s0)
    11ba:	4fb8                	lw	a4,88(a5)
    11bc:	fdc42783          	lw	a5,-36(s0)
    11c0:	2781                	sext.w	a5,a5
    11c2:	00f75b63          	bge	a4,a5,11d8 <schedule_sjf+0x52>
            shortest_time = t->remaining_time;
    11c6:	fe043783          	ld	a5,-32(s0)
    11ca:	4fbc                	lw	a5,88(a5)
    11cc:	fcf42e23          	sw	a5,-36(s0)
            shortest_job = t;
    11d0:	fe043783          	ld	a5,-32(s0)
    11d4:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    11d8:	fe043783          	ld	a5,-32(s0)
    11dc:	779c                	ld	a5,40(a5)
    11de:	fcf43423          	sd	a5,-56(s0)
    11e2:	fc843783          	ld	a5,-56(s0)
    11e6:	fd878793          	addi	a5,a5,-40
    11ea:	fef43023          	sd	a5,-32(s0)
    11ee:	fe043783          	ld	a5,-32(s0)
    11f2:	02878713          	addi	a4,a5,40
    11f6:	649c                	ld	a5,8(s1)
    11f8:	faf71fe3          	bne	a4,a5,11b6 <schedule_sjf+0x30>
        }
    }

    if (shortest_job) {
    11fc:	fe843783          	ld	a5,-24(s0)
    1200:	cf89                	beqz	a5,121a <schedule_sjf+0x94>
        r.scheduled_thread_list_member = &shortest_job->thread_list;
    1202:	fe843783          	ld	a5,-24(s0)
    1206:	02878793          	addi	a5,a5,40
    120a:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = shortest_job->remaining_time;  // Allow the thread to run to completion
    120e:	fe843783          	ld	a5,-24(s0)
    1212:	4fbc                	lw	a5,88(a5)
    1214:	faf42823          	sw	a5,-80(s0)
    1218:	a039                	j	1226 <schedule_sjf+0xa0>
    } else {
        // If no threads are ready, find the next release time or idle
        r.scheduled_thread_list_member = args.run_queue;
    121a:	649c                	ld	a5,8(s1)
    121c:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = 1;  // Default minimal quantum if unsure
    1220:	4785                	li	a5,1
    1222:	faf42823          	sw	a5,-80(s0)
    }
    return r;
    1226:	fa843783          	ld	a5,-88(s0)
    122a:	faf43c23          	sd	a5,-72(s0)
    122e:	fb043783          	ld	a5,-80(s0)
    1232:	fcf43023          	sd	a5,-64(s0)
    1236:	4701                	li	a4,0
    1238:	fb843703          	ld	a4,-72(s0)
    123c:	4781                	li	a5,0
    123e:	fc043783          	ld	a5,-64(s0)
    1242:	863a                	mv	a2,a4
    1244:	86be                	mv	a3,a5
    1246:	8732                	mv	a4,a2
    1248:	87b6                	mv	a5,a3
}
    124a:	853a                	mv	a0,a4
    124c:	85be                	mv	a1,a5
    124e:	6466                	ld	s0,88(sp)
    1250:	64c6                	ld	s1,80(sp)
    1252:	6125                	addi	sp,sp,96
    1254:	8082                	ret

0000000000001256 <schedule_lst>:

/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args)
{
    1256:	7119                	addi	sp,sp,-128
    1258:	fc86                	sd	ra,120(sp)
    125a:	f8a2                	sd	s0,112(sp)
    125c:	f4a6                	sd	s1,104(sp)
    125e:	f0ca                	sd	s2,96(sp)
    1260:	ecce                	sd	s3,88(sp)
    1262:	0100                	addi	s0,sp,128
    1264:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the least-slack-time scheduling algorithm
    struct thread *min_slack = NULL;
    1266:	fc043423          	sd	zero,-56(s0)
    int min_slack_time = INT_MAX;
    126a:	800007b7          	lui	a5,0x80000
    126e:	fff7c793          	not	a5,a5
    1272:	fcf42223          	sw	a5,-60(s0)
    struct thread *t;

    // Find the thread with the minimum slack time
    list_for_each_entry(t, args.run_queue, thread_list) {
    1276:	649c                	ld	a5,8(s1)
    1278:	639c                	ld	a5,0(a5)
    127a:	faf43823          	sd	a5,-80(s0)
    127e:	fb043783          	ld	a5,-80(s0)
    1282:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe1c8>
    1286:	faf43c23          	sd	a5,-72(s0)
    128a:	a8b5                	j	1306 <schedule_lst+0xb0>
        int slack_time = t->deadline - args.current_time - t->remaining_time;
    128c:	fb843783          	ld	a5,-72(s0)
    1290:	47f8                	lw	a4,76(a5)
    1292:	409c                	lw	a5,0(s1)
    1294:	40f707bb          	subw	a5,a4,a5
    1298:	0007871b          	sext.w	a4,a5
    129c:	fb843783          	ld	a5,-72(s0)
    12a0:	4fbc                	lw	a5,88(a5)
    12a2:	40f707bb          	subw	a5,a4,a5
    12a6:	faf42623          	sw	a5,-84(s0)
        if (min_slack == NULL || slack_time < min_slack_time ||
    12aa:	fc843783          	ld	a5,-56(s0)
    12ae:	cb8d                	beqz	a5,12e0 <schedule_lst+0x8a>
    12b0:	fac42703          	lw	a4,-84(s0)
    12b4:	fc442783          	lw	a5,-60(s0)
    12b8:	2701                	sext.w	a4,a4
    12ba:	2781                	sext.w	a5,a5
    12bc:	02f74263          	blt	a4,a5,12e0 <schedule_lst+0x8a>
    12c0:	fac42703          	lw	a4,-84(s0)
    12c4:	fc442783          	lw	a5,-60(s0)
    12c8:	2701                	sext.w	a4,a4
    12ca:	2781                	sext.w	a5,a5
    12cc:	02f71263          	bne	a4,a5,12f0 <schedule_lst+0x9a>
            (slack_time == min_slack_time && t->ID < min_slack->ID)) {
    12d0:	fb843783          	ld	a5,-72(s0)
    12d4:	5fd8                	lw	a4,60(a5)
    12d6:	fc843783          	ld	a5,-56(s0)
    12da:	5fdc                	lw	a5,60(a5)
    12dc:	00f75a63          	bge	a4,a5,12f0 <schedule_lst+0x9a>
            min_slack = t;
    12e0:	fb843783          	ld	a5,-72(s0)
    12e4:	fcf43423          	sd	a5,-56(s0)
            min_slack_time = slack_time;
    12e8:	fac42783          	lw	a5,-84(s0)
    12ec:	fcf42223          	sw	a5,-60(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    12f0:	fb843783          	ld	a5,-72(s0)
    12f4:	779c                	ld	a5,40(a5)
    12f6:	faf43023          	sd	a5,-96(s0)
    12fa:	fa043783          	ld	a5,-96(s0)
    12fe:	fd878793          	addi	a5,a5,-40
    1302:	faf43c23          	sd	a5,-72(s0)
    1306:	fb843783          	ld	a5,-72(s0)
    130a:	02878713          	addi	a4,a5,40
    130e:	649c                	ld	a5,8(s1)
    1310:	f6f71ee3          	bne	a4,a5,128c <schedule_lst+0x36>
        }
    }

    if (min_slack) {
    1314:	fc843783          	ld	a5,-56(s0)
    1318:	cf89                	beqz	a5,1332 <schedule_lst+0xdc>
        r.scheduled_thread_list_member = &min_slack->thread_list;
    131a:	fc843783          	ld	a5,-56(s0)
    131e:	02878793          	addi	a5,a5,40
    1322:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = min_slack->remaining_time;
    1326:	fc843783          	ld	a5,-56(s0)
    132a:	4fbc                	lw	a5,88(a5)
    132c:	f8f42423          	sw	a5,-120(s0)
    1330:	a839                	j	134e <schedule_lst+0xf8>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
    1332:	649c                	ld	a5,8(s1)
    1334:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    1338:	689c                	ld	a5,16(s1)
    133a:	4098                	lw	a4,0(s1)
    133c:	85ba                	mv	a1,a4
    133e:	853e                	mv	a0,a5
    1340:	00000097          	auipc	ra,0x0
    1344:	d96080e7          	jalr	-618(ra) # 10d6 <find_next_release_time>
    1348:	87aa                	mv	a5,a0
    134a:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    134e:	f8043783          	ld	a5,-128(s0)
    1352:	f8f43823          	sd	a5,-112(s0)
    1356:	f8843783          	ld	a5,-120(s0)
    135a:	f8f43c23          	sd	a5,-104(s0)
    135e:	4701                	li	a4,0
    1360:	f9043703          	ld	a4,-112(s0)
    1364:	4781                	li	a5,0
    1366:	f9843783          	ld	a5,-104(s0)
    136a:	893a                	mv	s2,a4
    136c:	89be                	mv	s3,a5
    136e:	874a                	mv	a4,s2
    1370:	87ce                	mv	a5,s3
}
    1372:	853a                	mv	a0,a4
    1374:	85be                	mv	a1,a5
    1376:	70e6                	ld	ra,120(sp)
    1378:	7446                	ld	s0,112(sp)
    137a:	74a6                	ld	s1,104(sp)
    137c:	7906                	ld	s2,96(sp)
    137e:	69e6                	ld	s3,88(sp)
    1380:	6109                	addi	sp,sp,128
    1382:	8082                	ret

0000000000001384 <schedule_dm>:

/* Deadline-Monotonic Scheduling */
struct threads_sched_result schedule_dm(struct threads_sched_args args)
{
    1384:	7135                	addi	sp,sp,-160
    1386:	ed06                	sd	ra,152(sp)
    1388:	e922                	sd	s0,144(sp)
    138a:	e526                	sd	s1,136(sp)
    138c:	e14a                	sd	s2,128(sp)
    138e:	fcce                	sd	s3,120(sp)
    1390:	1100                	addi	s0,sp,160
    1392:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the deadline-monotonic scheduling algorithm
   struct thread *earliest_deadline_thread = NULL;
    1394:	fc043423          	sd	zero,-56(s0)
    struct thread *t;
    int earliest_deadline = INT_MAX;
    1398:	800007b7          	lui	a5,0x80000
    139c:	fff7c793          	not	a5,a5
    13a0:	faf42e23          	sw	a5,-68(s0)

    // Find the earliest deadline real-time thread
    list_for_each_entry(t, args.run_queue, thread_list) {
    13a4:	649c                	ld	a5,8(s1)
    13a6:	639c                	ld	a5,0(a5)
    13a8:	faf43423          	sd	a5,-88(s0)
    13ac:	fa843783          	ld	a5,-88(s0)
    13b0:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe1c8>
    13b4:	fcf43023          	sd	a5,-64(s0)
    13b8:	a841                	j	1448 <schedule_dm+0xc4>
        if (t->is_real_time && t->period != -1 && t->current_deadline < earliest_deadline) {
    13ba:	fc043783          	ld	a5,-64(s0)
    13be:	43bc                	lw	a5,64(a5)
    13c0:	cb95                	beqz	a5,13f4 <schedule_dm+0x70>
    13c2:	fc043783          	ld	a5,-64(s0)
    13c6:	4bbc                	lw	a5,80(a5)
    13c8:	873e                	mv	a4,a5
    13ca:	57fd                	li	a5,-1
    13cc:	02f70463          	beq	a4,a5,13f4 <schedule_dm+0x70>
    13d0:	fc043783          	ld	a5,-64(s0)
    13d4:	4ff8                	lw	a4,92(a5)
    13d6:	fbc42783          	lw	a5,-68(s0)
    13da:	2781                	sext.w	a5,a5
    13dc:	00f75c63          	bge	a4,a5,13f4 <schedule_dm+0x70>
            earliest_deadline = t->current_deadline;
    13e0:	fc043783          	ld	a5,-64(s0)
    13e4:	4ffc                	lw	a5,92(a5)
    13e6:	faf42e23          	sw	a5,-68(s0)
            earliest_deadline_thread = t;
    13ea:	fc043783          	ld	a5,-64(s0)
    13ee:	fcf43423          	sd	a5,-56(s0)
    13f2:	a081                	j	1432 <schedule_dm+0xae>
        } else if (t->is_real_time && t->period != -1 && t->current_deadline == earliest_deadline && t->ID < earliest_deadline_thread->ID) {
    13f4:	fc043783          	ld	a5,-64(s0)
    13f8:	43bc                	lw	a5,64(a5)
    13fa:	cf85                	beqz	a5,1432 <schedule_dm+0xae>
    13fc:	fc043783          	ld	a5,-64(s0)
    1400:	4bbc                	lw	a5,80(a5)
    1402:	873e                	mv	a4,a5
    1404:	57fd                	li	a5,-1
    1406:	02f70663          	beq	a4,a5,1432 <schedule_dm+0xae>
    140a:	fc043783          	ld	a5,-64(s0)
    140e:	4ff8                	lw	a4,92(a5)
    1410:	fbc42783          	lw	a5,-68(s0)
    1414:	2781                	sext.w	a5,a5
    1416:	00e79e63          	bne	a5,a4,1432 <schedule_dm+0xae>
    141a:	fc043783          	ld	a5,-64(s0)
    141e:	5fd8                	lw	a4,60(a5)
    1420:	fc843783          	ld	a5,-56(s0)
    1424:	5fdc                	lw	a5,60(a5)
    1426:	00f75663          	bge	a4,a5,1432 <schedule_dm+0xae>
            earliest_deadline_thread = t;  // Tie-breaking by ID
    142a:	fc043783          	ld	a5,-64(s0)
    142e:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    1432:	fc043783          	ld	a5,-64(s0)
    1436:	779c                	ld	a5,40(a5)
    1438:	f8f43423          	sd	a5,-120(s0)
    143c:	f8843783          	ld	a5,-120(s0)
    1440:	fd878793          	addi	a5,a5,-40
    1444:	fcf43023          	sd	a5,-64(s0)
    1448:	fc043783          	ld	a5,-64(s0)
    144c:	02878713          	addi	a4,a5,40
    1450:	649c                	ld	a5,8(s1)
    1452:	f6f714e3          	bne	a4,a5,13ba <schedule_dm+0x36>
        }
    }

    if (earliest_deadline_thread) {
    1456:	fc843783          	ld	a5,-56(s0)
    145a:	c7a5                	beqz	a5,14c2 <schedule_dm+0x13e>
        int time_to_deadline = earliest_deadline_thread->current_deadline - args.current_time;
    145c:	fc843783          	ld	a5,-56(s0)
    1460:	4ff8                	lw	a4,92(a5)
    1462:	409c                	lw	a5,0(s1)
    1464:	40f707bb          	subw	a5,a4,a5
    1468:	f8f42a23          	sw	a5,-108(s0)
        if (earliest_deadline_thread->remaining_time > time_to_deadline) {
    146c:	fc843783          	ld	a5,-56(s0)
    1470:	4fb8                	lw	a4,88(a5)
    1472:	f9442783          	lw	a5,-108(s0)
    1476:	2781                	sext.w	a5,a5
    1478:	00e7db63          	bge	a5,a4,148e <schedule_dm+0x10a>
            // The real-time thread cannot complete before its deadline, so handle the deadline miss
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    147c:	fc843783          	ld	a5,-56(s0)
    1480:	02878793          	addi	a5,a5,40
    1484:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = 0; // Could set to minimal quantum to allow cleanup or logging
    1488:	f6042823          	sw	zero,-144(s0)
    148c:	a0f1                	j	1558 <schedule_dm+0x1d4>
        } else {
            // Schedule the real-time thread normally if it hasn't missed its deadline
            int time_slice = (time_to_deadline < earliest_deadline_thread->remaining_time) ? time_to_deadline : earliest_deadline_thread->remaining_time;
    148e:	fc843783          	ld	a5,-56(s0)
    1492:	4fbc                	lw	a5,88(a5)
    1494:	863e                	mv	a2,a5
    1496:	f9442783          	lw	a5,-108(s0)
    149a:	0007869b          	sext.w	a3,a5
    149e:	0006071b          	sext.w	a4,a2
    14a2:	00d75363          	bge	a4,a3,14a8 <schedule_dm+0x124>
    14a6:	87b2                	mv	a5,a2
    14a8:	f8f42823          	sw	a5,-112(s0)
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    14ac:	fc843783          	ld	a5,-56(s0)
    14b0:	02878793          	addi	a5,a5,40
    14b4:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = time_slice;
    14b8:	f9042783          	lw	a5,-112(s0)
    14bc:	f6f42823          	sw	a5,-144(s0)
    14c0:	a861                	j	1558 <schedule_dm+0x1d4>
        }
    } else {
        // If no real-time threads with a deadline are ready, find the thread with the smallest ID
        struct thread *smallest_id_thread = NULL;
    14c2:	fa043823          	sd	zero,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    14c6:	649c                	ld	a5,8(s1)
    14c8:	639c                	ld	a5,0(a5)
    14ca:	faf43023          	sd	a5,-96(s0)
    14ce:	fa043783          	ld	a5,-96(s0)
    14d2:	fd878793          	addi	a5,a5,-40
    14d6:	fcf43023          	sd	a5,-64(s0)
    14da:	a81d                	j	1510 <schedule_dm+0x18c>
            if (smallest_id_thread == NULL || t->ID < smallest_id_thread->ID) {
    14dc:	fb043783          	ld	a5,-80(s0)
    14e0:	cb89                	beqz	a5,14f2 <schedule_dm+0x16e>
    14e2:	fc043783          	ld	a5,-64(s0)
    14e6:	5fd8                	lw	a4,60(a5)
    14e8:	fb043783          	ld	a5,-80(s0)
    14ec:	5fdc                	lw	a5,60(a5)
    14ee:	00f75663          	bge	a4,a5,14fa <schedule_dm+0x176>
                smallest_id_thread = t;
    14f2:	fc043783          	ld	a5,-64(s0)
    14f6:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    14fa:	fc043783          	ld	a5,-64(s0)
    14fe:	779c                	ld	a5,40(a5)
    1500:	f8f43c23          	sd	a5,-104(s0)
    1504:	f9843783          	ld	a5,-104(s0)
    1508:	fd878793          	addi	a5,a5,-40
    150c:	fcf43023          	sd	a5,-64(s0)
    1510:	fc043783          	ld	a5,-64(s0)
    1514:	02878713          	addi	a4,a5,40
    1518:	649c                	ld	a5,8(s1)
    151a:	fcf711e3          	bne	a4,a5,14dc <schedule_dm+0x158>
            }
        }

        if (smallest_id_thread) {
    151e:	fb043783          	ld	a5,-80(s0)
    1522:	cf89                	beqz	a5,153c <schedule_dm+0x1b8>
            r.scheduled_thread_list_member = &smallest_id_thread->thread_list;
    1524:	fb043783          	ld	a5,-80(s0)
    1528:	02878793          	addi	a5,a5,40
    152c:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = smallest_id_thread->remaining_time;
    1530:	fb043783          	ld	a5,-80(s0)
    1534:	4fbc                	lw	a5,88(a5)
    1536:	f6f42823          	sw	a5,-144(s0)
    153a:	a839                	j	1558 <schedule_dm+0x1d4>
        } else {
            // If no thread is ready, perhaps idle or find the next release time
            r.scheduled_thread_list_member = args.run_queue;
    153c:	649c                	ld	a5,8(s1)
    153e:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    1542:	689c                	ld	a5,16(s1)
    1544:	4098                	lw	a4,0(s1)
    1546:	85ba                	mv	a1,a4
    1548:	853e                	mv	a0,a5
    154a:	00000097          	auipc	ra,0x0
    154e:	b8c080e7          	jalr	-1140(ra) # 10d6 <find_next_release_time>
    1552:	87aa                	mv	a5,a0
    1554:	f6f42823          	sw	a5,-144(s0)
        }
    }

    return r;
    1558:	f6843783          	ld	a5,-152(s0)
    155c:	f6f43c23          	sd	a5,-136(s0)
    1560:	f7043783          	ld	a5,-144(s0)
    1564:	f8f43023          	sd	a5,-128(s0)
    1568:	4701                	li	a4,0
    156a:	f7843703          	ld	a4,-136(s0)
    156e:	4781                	li	a5,0
    1570:	f8043783          	ld	a5,-128(s0)
    1574:	893a                	mv	s2,a4
    1576:	89be                	mv	s3,a5
    1578:	874a                	mv	a4,s2
    157a:	87ce                	mv	a5,s3
}
    157c:	853a                	mv	a0,a4
    157e:	85be                	mv	a1,a5
    1580:	60ea                	ld	ra,152(sp)
    1582:	644a                	ld	s0,144(sp)
    1584:	64aa                	ld	s1,136(sp)
    1586:	690a                	ld	s2,128(sp)
    1588:	79e6                	ld	s3,120(sp)
    158a:	610d                	addi	sp,sp,160
    158c:	8082                	ret
