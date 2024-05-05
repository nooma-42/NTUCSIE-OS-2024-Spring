
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
       0:	7139                	addi	sp,sp,-64
       2:	fc06                	sd	ra,56(sp)
       4:	f822                	sd	s0,48(sp)
       6:	f426                	sd	s1,40(sp)
       8:	0080                	addi	s0,sp,64
       a:	fca43423          	sd	a0,-56(s0)
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
       e:	fc843503          	ld	a0,-56(s0)
      12:	00000097          	auipc	ra,0x0
      16:	42e080e7          	jalr	1070(ra) # 440 <strlen>
      1a:	87aa                	mv	a5,a0
      1c:	2781                	sext.w	a5,a5
      1e:	1782                	slli	a5,a5,0x20
      20:	9381                	srli	a5,a5,0x20
      22:	fc843703          	ld	a4,-56(s0)
      26:	97ba                	add	a5,a5,a4
      28:	fcf43c23          	sd	a5,-40(s0)
      2c:	a031                	j	38 <fmtname+0x38>
      2e:	fd843783          	ld	a5,-40(s0)
      32:	17fd                	addi	a5,a5,-1
      34:	fcf43c23          	sd	a5,-40(s0)
      38:	fd843703          	ld	a4,-40(s0)
      3c:	fc843783          	ld	a5,-56(s0)
      40:	00f76b63          	bltu	a4,a5,56 <fmtname+0x56>
      44:	fd843783          	ld	a5,-40(s0)
      48:	0007c783          	lbu	a5,0(a5)
      4c:	873e                	mv	a4,a5
      4e:	02f00793          	li	a5,47
      52:	fcf71ee3          	bne	a4,a5,2e <fmtname+0x2e>
    ;
  p++;
      56:	fd843783          	ld	a5,-40(s0)
      5a:	0785                	addi	a5,a5,1
      5c:	fcf43c23          	sd	a5,-40(s0)

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
      60:	fd843503          	ld	a0,-40(s0)
      64:	00000097          	auipc	ra,0x0
      68:	3dc080e7          	jalr	988(ra) # 440 <strlen>
      6c:	87aa                	mv	a5,a0
      6e:	2781                	sext.w	a5,a5
      70:	873e                	mv	a4,a5
      72:	47b5                	li	a5,13
      74:	00e7f563          	bgeu	a5,a4,7e <fmtname+0x7e>
    return p;
      78:	fd843783          	ld	a5,-40(s0)
      7c:	a8b5                	j	f8 <fmtname+0xf8>
  memmove(buf, p, strlen(p));
      7e:	fd843503          	ld	a0,-40(s0)
      82:	00000097          	auipc	ra,0x0
      86:	3be080e7          	jalr	958(ra) # 440 <strlen>
      8a:	87aa                	mv	a5,a0
      8c:	2781                	sext.w	a5,a5
      8e:	2781                	sext.w	a5,a5
      90:	863e                	mv	a2,a5
      92:	fd843583          	ld	a1,-40(s0)
      96:	00002517          	auipc	a0,0x2
      9a:	cc250513          	addi	a0,a0,-830 # 1d58 <buf.1118>
      9e:	00000097          	auipc	ra,0x0
      a2:	5fc080e7          	jalr	1532(ra) # 69a <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
      a6:	fd843503          	ld	a0,-40(s0)
      aa:	00000097          	auipc	ra,0x0
      ae:	396080e7          	jalr	918(ra) # 440 <strlen>
      b2:	87aa                	mv	a5,a0
      b4:	2781                	sext.w	a5,a5
      b6:	02079713          	slli	a4,a5,0x20
      ba:	9301                	srli	a4,a4,0x20
      bc:	00002797          	auipc	a5,0x2
      c0:	c9c78793          	addi	a5,a5,-868 # 1d58 <buf.1118>
      c4:	00f704b3          	add	s1,a4,a5
      c8:	fd843503          	ld	a0,-40(s0)
      cc:	00000097          	auipc	ra,0x0
      d0:	374080e7          	jalr	884(ra) # 440 <strlen>
      d4:	87aa                	mv	a5,a0
      d6:	2781                	sext.w	a5,a5
      d8:	4739                	li	a4,14
      da:	40f707bb          	subw	a5,a4,a5
      de:	2781                	sext.w	a5,a5
      e0:	863e                	mv	a2,a5
      e2:	02000593          	li	a1,32
      e6:	8526                	mv	a0,s1
      e8:	00000097          	auipc	ra,0x0
      ec:	38e080e7          	jalr	910(ra) # 476 <memset>
  return buf;
      f0:	00002797          	auipc	a5,0x2
      f4:	c6878793          	addi	a5,a5,-920 # 1d58 <buf.1118>
}
      f8:	853e                	mv	a0,a5
      fa:	70e2                	ld	ra,56(sp)
      fc:	7442                	ld	s0,48(sp)
      fe:	74a2                	ld	s1,40(sp)
     100:	6121                	addi	sp,sp,64
     102:	8082                	ret

0000000000000104 <ls>:

void
ls(char *path)
{
     104:	da010113          	addi	sp,sp,-608
     108:	24113c23          	sd	ra,600(sp)
     10c:	24813823          	sd	s0,592(sp)
     110:	1480                	addi	s0,sp,608
     112:	daa43423          	sd	a0,-600(s0)
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
     116:	4581                	li	a1,0
     118:	da843503          	ld	a0,-600(s0)
     11c:	00000097          	auipc	ra,0x0
     120:	744080e7          	jalr	1860(ra) # 860 <open>
     124:	87aa                	mv	a5,a0
     126:	fef42623          	sw	a5,-20(s0)
     12a:	fec42783          	lw	a5,-20(s0)
     12e:	2781                	sext.w	a5,a5
     130:	0007de63          	bgez	a5,14c <ls+0x48>
    fprintf(2, "ls: cannot open %s\n", path);
     134:	da843603          	ld	a2,-600(s0)
     138:	00002597          	auipc	a1,0x2
     13c:	b9058593          	addi	a1,a1,-1136 # 1cc8 <schedule_dm+0x1da>
     140:	4509                	li	a0,2
     142:	00001097          	auipc	ra,0x1
     146:	bcc080e7          	jalr	-1076(ra) # d0e <fprintf>
    return;
     14a:	aa6d                	j	304 <ls+0x200>
  }

  if(fstat(fd, &st) < 0){
     14c:	db840713          	addi	a4,s0,-584
     150:	fec42783          	lw	a5,-20(s0)
     154:	85ba                	mv	a1,a4
     156:	853e                	mv	a0,a5
     158:	00000097          	auipc	ra,0x0
     15c:	720080e7          	jalr	1824(ra) # 878 <fstat>
     160:	87aa                	mv	a5,a0
     162:	0207d563          	bgez	a5,18c <ls+0x88>
    fprintf(2, "ls: cannot stat %s\n", path);
     166:	da843603          	ld	a2,-600(s0)
     16a:	00002597          	auipc	a1,0x2
     16e:	b7658593          	addi	a1,a1,-1162 # 1ce0 <schedule_dm+0x1f2>
     172:	4509                	li	a0,2
     174:	00001097          	auipc	ra,0x1
     178:	b9a080e7          	jalr	-1126(ra) # d0e <fprintf>
    close(fd);
     17c:	fec42783          	lw	a5,-20(s0)
     180:	853e                	mv	a0,a5
     182:	00000097          	auipc	ra,0x0
     186:	6c6080e7          	jalr	1734(ra) # 848 <close>
    return;
     18a:	aaad                	j	304 <ls+0x200>
  }

  switch(st.type){
     18c:	dc041783          	lh	a5,-576(s0)
     190:	0007871b          	sext.w	a4,a5
     194:	86ba                	mv	a3,a4
     196:	4785                	li	a5,1
     198:	02f68d63          	beq	a3,a5,1d2 <ls+0xce>
     19c:	4789                	li	a5,2
     19e:	14f71c63          	bne	a4,a5,2f6 <ls+0x1f2>
  case T_FILE:
    printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);
     1a2:	da843503          	ld	a0,-600(s0)
     1a6:	00000097          	auipc	ra,0x0
     1aa:	e5a080e7          	jalr	-422(ra) # 0 <fmtname>
     1ae:	85aa                	mv	a1,a0
     1b0:	dc041783          	lh	a5,-576(s0)
     1b4:	2781                	sext.w	a5,a5
     1b6:	dbc42683          	lw	a3,-580(s0)
     1ba:	dc843703          	ld	a4,-568(s0)
     1be:	863e                	mv	a2,a5
     1c0:	00002517          	auipc	a0,0x2
     1c4:	b3850513          	addi	a0,a0,-1224 # 1cf8 <schedule_dm+0x20a>
     1c8:	00001097          	auipc	ra,0x1
     1cc:	b9e080e7          	jalr	-1122(ra) # d66 <printf>
    break;
     1d0:	a21d                	j	2f6 <ls+0x1f2>

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
     1d2:	da843503          	ld	a0,-600(s0)
     1d6:	00000097          	auipc	ra,0x0
     1da:	26a080e7          	jalr	618(ra) # 440 <strlen>
     1de:	87aa                	mv	a5,a0
     1e0:	2781                	sext.w	a5,a5
     1e2:	27c1                	addiw	a5,a5,16
     1e4:	2781                	sext.w	a5,a5
     1e6:	873e                	mv	a4,a5
     1e8:	20000793          	li	a5,512
     1ec:	00e7fb63          	bgeu	a5,a4,202 <ls+0xfe>
      printf("ls: path too long\n");
     1f0:	00002517          	auipc	a0,0x2
     1f4:	b1850513          	addi	a0,a0,-1256 # 1d08 <schedule_dm+0x21a>
     1f8:	00001097          	auipc	ra,0x1
     1fc:	b6e080e7          	jalr	-1170(ra) # d66 <printf>
      break;
     200:	a8dd                	j	2f6 <ls+0x1f2>
    }
    strcpy(buf, path);
     202:	de040793          	addi	a5,s0,-544
     206:	da843583          	ld	a1,-600(s0)
     20a:	853e                	mv	a0,a5
     20c:	00000097          	auipc	ra,0x0
     210:	184080e7          	jalr	388(ra) # 390 <strcpy>
    p = buf+strlen(buf);
     214:	de040793          	addi	a5,s0,-544
     218:	853e                	mv	a0,a5
     21a:	00000097          	auipc	ra,0x0
     21e:	226080e7          	jalr	550(ra) # 440 <strlen>
     222:	87aa                	mv	a5,a0
     224:	2781                	sext.w	a5,a5
     226:	1782                	slli	a5,a5,0x20
     228:	9381                	srli	a5,a5,0x20
     22a:	de040713          	addi	a4,s0,-544
     22e:	97ba                	add	a5,a5,a4
     230:	fef43023          	sd	a5,-32(s0)
    *p++ = '/';
     234:	fe043783          	ld	a5,-32(s0)
     238:	00178713          	addi	a4,a5,1
     23c:	fee43023          	sd	a4,-32(s0)
     240:	02f00713          	li	a4,47
     244:	00e78023          	sb	a4,0(a5)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     248:	a071                	j	2d4 <ls+0x1d0>
      if(de.inum == 0)
     24a:	dd045783          	lhu	a5,-560(s0)
     24e:	e391                	bnez	a5,252 <ls+0x14e>
        continue;
     250:	a051                	j	2d4 <ls+0x1d0>
      memmove(p, de.name, DIRSIZ);
     252:	dd040793          	addi	a5,s0,-560
     256:	0789                	addi	a5,a5,2
     258:	4639                	li	a2,14
     25a:	85be                	mv	a1,a5
     25c:	fe043503          	ld	a0,-32(s0)
     260:	00000097          	auipc	ra,0x0
     264:	43a080e7          	jalr	1082(ra) # 69a <memmove>
      p[DIRSIZ] = 0;
     268:	fe043783          	ld	a5,-32(s0)
     26c:	07b9                	addi	a5,a5,14
     26e:	00078023          	sb	zero,0(a5)
      if(stat(buf, &st) < 0){
     272:	db840713          	addi	a4,s0,-584
     276:	de040793          	addi	a5,s0,-544
     27a:	85ba                	mv	a1,a4
     27c:	853e                	mv	a0,a5
     27e:	00000097          	auipc	ra,0x0
     282:	344080e7          	jalr	836(ra) # 5c2 <stat>
     286:	87aa                	mv	a5,a0
     288:	0007de63          	bgez	a5,2a4 <ls+0x1a0>
        printf("ls: cannot stat %s\n", buf);
     28c:	de040793          	addi	a5,s0,-544
     290:	85be                	mv	a1,a5
     292:	00002517          	auipc	a0,0x2
     296:	a4e50513          	addi	a0,a0,-1458 # 1ce0 <schedule_dm+0x1f2>
     29a:	00001097          	auipc	ra,0x1
     29e:	acc080e7          	jalr	-1332(ra) # d66 <printf>
        continue;
     2a2:	a80d                	j	2d4 <ls+0x1d0>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
     2a4:	de040793          	addi	a5,s0,-544
     2a8:	853e                	mv	a0,a5
     2aa:	00000097          	auipc	ra,0x0
     2ae:	d56080e7          	jalr	-682(ra) # 0 <fmtname>
     2b2:	85aa                	mv	a1,a0
     2b4:	dc041783          	lh	a5,-576(s0)
     2b8:	2781                	sext.w	a5,a5
     2ba:	dbc42683          	lw	a3,-580(s0)
     2be:	dc843703          	ld	a4,-568(s0)
     2c2:	863e                	mv	a2,a5
     2c4:	00002517          	auipc	a0,0x2
     2c8:	a5c50513          	addi	a0,a0,-1444 # 1d20 <schedule_dm+0x232>
     2cc:	00001097          	auipc	ra,0x1
     2d0:	a9a080e7          	jalr	-1382(ra) # d66 <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     2d4:	dd040713          	addi	a4,s0,-560
     2d8:	fec42783          	lw	a5,-20(s0)
     2dc:	4641                	li	a2,16
     2de:	85ba                	mv	a1,a4
     2e0:	853e                	mv	a0,a5
     2e2:	00000097          	auipc	ra,0x0
     2e6:	556080e7          	jalr	1366(ra) # 838 <read>
     2ea:	87aa                	mv	a5,a0
     2ec:	873e                	mv	a4,a5
     2ee:	47c1                	li	a5,16
     2f0:	f4f70de3          	beq	a4,a5,24a <ls+0x146>
    }
    break;
     2f4:	0001                	nop
  }
  close(fd);
     2f6:	fec42783          	lw	a5,-20(s0)
     2fa:	853e                	mv	a0,a5
     2fc:	00000097          	auipc	ra,0x0
     300:	54c080e7          	jalr	1356(ra) # 848 <close>
}
     304:	25813083          	ld	ra,600(sp)
     308:	25013403          	ld	s0,592(sp)
     30c:	26010113          	addi	sp,sp,608
     310:	8082                	ret

0000000000000312 <main>:

int
main(int argc, char *argv[])
{
     312:	7179                	addi	sp,sp,-48
     314:	f406                	sd	ra,40(sp)
     316:	f022                	sd	s0,32(sp)
     318:	1800                	addi	s0,sp,48
     31a:	87aa                	mv	a5,a0
     31c:	fcb43823          	sd	a1,-48(s0)
     320:	fcf42e23          	sw	a5,-36(s0)
  int i;

  if(argc < 2){
     324:	fdc42783          	lw	a5,-36(s0)
     328:	0007871b          	sext.w	a4,a5
     32c:	4785                	li	a5,1
     32e:	00e7cf63          	blt	a5,a4,34c <main+0x3a>
    ls(".");
     332:	00002517          	auipc	a0,0x2
     336:	9fe50513          	addi	a0,a0,-1538 # 1d30 <schedule_dm+0x242>
     33a:	00000097          	auipc	ra,0x0
     33e:	dca080e7          	jalr	-566(ra) # 104 <ls>
    exit(0);
     342:	4501                	li	a0,0
     344:	00000097          	auipc	ra,0x0
     348:	4dc080e7          	jalr	1244(ra) # 820 <exit>
  }
  for(i=1; i<argc; i++)
     34c:	4785                	li	a5,1
     34e:	fef42623          	sw	a5,-20(s0)
     352:	a015                	j	376 <main+0x64>
    ls(argv[i]);
     354:	fec42783          	lw	a5,-20(s0)
     358:	078e                	slli	a5,a5,0x3
     35a:	fd043703          	ld	a4,-48(s0)
     35e:	97ba                	add	a5,a5,a4
     360:	639c                	ld	a5,0(a5)
     362:	853e                	mv	a0,a5
     364:	00000097          	auipc	ra,0x0
     368:	da0080e7          	jalr	-608(ra) # 104 <ls>
  for(i=1; i<argc; i++)
     36c:	fec42783          	lw	a5,-20(s0)
     370:	2785                	addiw	a5,a5,1
     372:	fef42623          	sw	a5,-20(s0)
     376:	fec42703          	lw	a4,-20(s0)
     37a:	fdc42783          	lw	a5,-36(s0)
     37e:	2701                	sext.w	a4,a4
     380:	2781                	sext.w	a5,a5
     382:	fcf749e3          	blt	a4,a5,354 <main+0x42>
  exit(0);
     386:	4501                	li	a0,0
     388:	00000097          	auipc	ra,0x0
     38c:	498080e7          	jalr	1176(ra) # 820 <exit>

0000000000000390 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     390:	7179                	addi	sp,sp,-48
     392:	f422                	sd	s0,40(sp)
     394:	1800                	addi	s0,sp,48
     396:	fca43c23          	sd	a0,-40(s0)
     39a:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     39e:	fd843783          	ld	a5,-40(s0)
     3a2:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     3a6:	0001                	nop
     3a8:	fd043703          	ld	a4,-48(s0)
     3ac:	00170793          	addi	a5,a4,1
     3b0:	fcf43823          	sd	a5,-48(s0)
     3b4:	fd843783          	ld	a5,-40(s0)
     3b8:	00178693          	addi	a3,a5,1
     3bc:	fcd43c23          	sd	a3,-40(s0)
     3c0:	00074703          	lbu	a4,0(a4)
     3c4:	00e78023          	sb	a4,0(a5)
     3c8:	0007c783          	lbu	a5,0(a5)
     3cc:	fff1                	bnez	a5,3a8 <strcpy+0x18>
    ;
  return os;
     3ce:	fe843783          	ld	a5,-24(s0)
}
     3d2:	853e                	mv	a0,a5
     3d4:	7422                	ld	s0,40(sp)
     3d6:	6145                	addi	sp,sp,48
     3d8:	8082                	ret

00000000000003da <strcmp>:

int
strcmp(const char *p, const char *q)
{
     3da:	1101                	addi	sp,sp,-32
     3dc:	ec22                	sd	s0,24(sp)
     3de:	1000                	addi	s0,sp,32
     3e0:	fea43423          	sd	a0,-24(s0)
     3e4:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     3e8:	a819                	j	3fe <strcmp+0x24>
    p++, q++;
     3ea:	fe843783          	ld	a5,-24(s0)
     3ee:	0785                	addi	a5,a5,1
     3f0:	fef43423          	sd	a5,-24(s0)
     3f4:	fe043783          	ld	a5,-32(s0)
     3f8:	0785                	addi	a5,a5,1
     3fa:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     3fe:	fe843783          	ld	a5,-24(s0)
     402:	0007c783          	lbu	a5,0(a5)
     406:	cb99                	beqz	a5,41c <strcmp+0x42>
     408:	fe843783          	ld	a5,-24(s0)
     40c:	0007c703          	lbu	a4,0(a5)
     410:	fe043783          	ld	a5,-32(s0)
     414:	0007c783          	lbu	a5,0(a5)
     418:	fcf709e3          	beq	a4,a5,3ea <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     41c:	fe843783          	ld	a5,-24(s0)
     420:	0007c783          	lbu	a5,0(a5)
     424:	0007871b          	sext.w	a4,a5
     428:	fe043783          	ld	a5,-32(s0)
     42c:	0007c783          	lbu	a5,0(a5)
     430:	2781                	sext.w	a5,a5
     432:	40f707bb          	subw	a5,a4,a5
     436:	2781                	sext.w	a5,a5
}
     438:	853e                	mv	a0,a5
     43a:	6462                	ld	s0,24(sp)
     43c:	6105                	addi	sp,sp,32
     43e:	8082                	ret

0000000000000440 <strlen>:

uint
strlen(const char *s)
{
     440:	7179                	addi	sp,sp,-48
     442:	f422                	sd	s0,40(sp)
     444:	1800                	addi	s0,sp,48
     446:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     44a:	fe042623          	sw	zero,-20(s0)
     44e:	a031                	j	45a <strlen+0x1a>
     450:	fec42783          	lw	a5,-20(s0)
     454:	2785                	addiw	a5,a5,1
     456:	fef42623          	sw	a5,-20(s0)
     45a:	fec42783          	lw	a5,-20(s0)
     45e:	fd843703          	ld	a4,-40(s0)
     462:	97ba                	add	a5,a5,a4
     464:	0007c783          	lbu	a5,0(a5)
     468:	f7e5                	bnez	a5,450 <strlen+0x10>
    ;
  return n;
     46a:	fec42783          	lw	a5,-20(s0)
}
     46e:	853e                	mv	a0,a5
     470:	7422                	ld	s0,40(sp)
     472:	6145                	addi	sp,sp,48
     474:	8082                	ret

0000000000000476 <memset>:

void*
memset(void *dst, int c, uint n)
{
     476:	7179                	addi	sp,sp,-48
     478:	f422                	sd	s0,40(sp)
     47a:	1800                	addi	s0,sp,48
     47c:	fca43c23          	sd	a0,-40(s0)
     480:	87ae                	mv	a5,a1
     482:	8732                	mv	a4,a2
     484:	fcf42a23          	sw	a5,-44(s0)
     488:	87ba                	mv	a5,a4
     48a:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     48e:	fd843783          	ld	a5,-40(s0)
     492:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     496:	fe042623          	sw	zero,-20(s0)
     49a:	a00d                	j	4bc <memset+0x46>
    cdst[i] = c;
     49c:	fec42783          	lw	a5,-20(s0)
     4a0:	fe043703          	ld	a4,-32(s0)
     4a4:	97ba                	add	a5,a5,a4
     4a6:	fd442703          	lw	a4,-44(s0)
     4aa:	0ff77713          	andi	a4,a4,255
     4ae:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     4b2:	fec42783          	lw	a5,-20(s0)
     4b6:	2785                	addiw	a5,a5,1
     4b8:	fef42623          	sw	a5,-20(s0)
     4bc:	fec42703          	lw	a4,-20(s0)
     4c0:	fd042783          	lw	a5,-48(s0)
     4c4:	2781                	sext.w	a5,a5
     4c6:	fcf76be3          	bltu	a4,a5,49c <memset+0x26>
  }
  return dst;
     4ca:	fd843783          	ld	a5,-40(s0)
}
     4ce:	853e                	mv	a0,a5
     4d0:	7422                	ld	s0,40(sp)
     4d2:	6145                	addi	sp,sp,48
     4d4:	8082                	ret

00000000000004d6 <strchr>:

char*
strchr(const char *s, char c)
{
     4d6:	1101                	addi	sp,sp,-32
     4d8:	ec22                	sd	s0,24(sp)
     4da:	1000                	addi	s0,sp,32
     4dc:	fea43423          	sd	a0,-24(s0)
     4e0:	87ae                	mv	a5,a1
     4e2:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     4e6:	a01d                	j	50c <strchr+0x36>
    if(*s == c)
     4e8:	fe843783          	ld	a5,-24(s0)
     4ec:	0007c703          	lbu	a4,0(a5)
     4f0:	fe744783          	lbu	a5,-25(s0)
     4f4:	0ff7f793          	andi	a5,a5,255
     4f8:	00e79563          	bne	a5,a4,502 <strchr+0x2c>
      return (char*)s;
     4fc:	fe843783          	ld	a5,-24(s0)
     500:	a821                	j	518 <strchr+0x42>
  for(; *s; s++)
     502:	fe843783          	ld	a5,-24(s0)
     506:	0785                	addi	a5,a5,1
     508:	fef43423          	sd	a5,-24(s0)
     50c:	fe843783          	ld	a5,-24(s0)
     510:	0007c783          	lbu	a5,0(a5)
     514:	fbf1                	bnez	a5,4e8 <strchr+0x12>
  return 0;
     516:	4781                	li	a5,0
}
     518:	853e                	mv	a0,a5
     51a:	6462                	ld	s0,24(sp)
     51c:	6105                	addi	sp,sp,32
     51e:	8082                	ret

0000000000000520 <gets>:

char*
gets(char *buf, int max)
{
     520:	7179                	addi	sp,sp,-48
     522:	f406                	sd	ra,40(sp)
     524:	f022                	sd	s0,32(sp)
     526:	1800                	addi	s0,sp,48
     528:	fca43c23          	sd	a0,-40(s0)
     52c:	87ae                	mv	a5,a1
     52e:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     532:	fe042623          	sw	zero,-20(s0)
     536:	a8a1                	j	58e <gets+0x6e>
    cc = read(0, &c, 1);
     538:	fe740793          	addi	a5,s0,-25
     53c:	4605                	li	a2,1
     53e:	85be                	mv	a1,a5
     540:	4501                	li	a0,0
     542:	00000097          	auipc	ra,0x0
     546:	2f6080e7          	jalr	758(ra) # 838 <read>
     54a:	87aa                	mv	a5,a0
     54c:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     550:	fe842783          	lw	a5,-24(s0)
     554:	2781                	sext.w	a5,a5
     556:	04f05763          	blez	a5,5a4 <gets+0x84>
      break;
    buf[i++] = c;
     55a:	fec42783          	lw	a5,-20(s0)
     55e:	0017871b          	addiw	a4,a5,1
     562:	fee42623          	sw	a4,-20(s0)
     566:	873e                	mv	a4,a5
     568:	fd843783          	ld	a5,-40(s0)
     56c:	97ba                	add	a5,a5,a4
     56e:	fe744703          	lbu	a4,-25(s0)
     572:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     576:	fe744783          	lbu	a5,-25(s0)
     57a:	873e                	mv	a4,a5
     57c:	47a9                	li	a5,10
     57e:	02f70463          	beq	a4,a5,5a6 <gets+0x86>
     582:	fe744783          	lbu	a5,-25(s0)
     586:	873e                	mv	a4,a5
     588:	47b5                	li	a5,13
     58a:	00f70e63          	beq	a4,a5,5a6 <gets+0x86>
  for(i=0; i+1 < max; ){
     58e:	fec42783          	lw	a5,-20(s0)
     592:	2785                	addiw	a5,a5,1
     594:	0007871b          	sext.w	a4,a5
     598:	fd442783          	lw	a5,-44(s0)
     59c:	2781                	sext.w	a5,a5
     59e:	f8f74de3          	blt	a4,a5,538 <gets+0x18>
     5a2:	a011                	j	5a6 <gets+0x86>
      break;
     5a4:	0001                	nop
      break;
  }
  buf[i] = '\0';
     5a6:	fec42783          	lw	a5,-20(s0)
     5aa:	fd843703          	ld	a4,-40(s0)
     5ae:	97ba                	add	a5,a5,a4
     5b0:	00078023          	sb	zero,0(a5)
  return buf;
     5b4:	fd843783          	ld	a5,-40(s0)
}
     5b8:	853e                	mv	a0,a5
     5ba:	70a2                	ld	ra,40(sp)
     5bc:	7402                	ld	s0,32(sp)
     5be:	6145                	addi	sp,sp,48
     5c0:	8082                	ret

00000000000005c2 <stat>:

int
stat(const char *n, struct stat *st)
{
     5c2:	7179                	addi	sp,sp,-48
     5c4:	f406                	sd	ra,40(sp)
     5c6:	f022                	sd	s0,32(sp)
     5c8:	1800                	addi	s0,sp,48
     5ca:	fca43c23          	sd	a0,-40(s0)
     5ce:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     5d2:	4581                	li	a1,0
     5d4:	fd843503          	ld	a0,-40(s0)
     5d8:	00000097          	auipc	ra,0x0
     5dc:	288080e7          	jalr	648(ra) # 860 <open>
     5e0:	87aa                	mv	a5,a0
     5e2:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     5e6:	fec42783          	lw	a5,-20(s0)
     5ea:	2781                	sext.w	a5,a5
     5ec:	0007d463          	bgez	a5,5f4 <stat+0x32>
    return -1;
     5f0:	57fd                	li	a5,-1
     5f2:	a035                	j	61e <stat+0x5c>
  r = fstat(fd, st);
     5f4:	fec42783          	lw	a5,-20(s0)
     5f8:	fd043583          	ld	a1,-48(s0)
     5fc:	853e                	mv	a0,a5
     5fe:	00000097          	auipc	ra,0x0
     602:	27a080e7          	jalr	634(ra) # 878 <fstat>
     606:	87aa                	mv	a5,a0
     608:	fef42423          	sw	a5,-24(s0)
  close(fd);
     60c:	fec42783          	lw	a5,-20(s0)
     610:	853e                	mv	a0,a5
     612:	00000097          	auipc	ra,0x0
     616:	236080e7          	jalr	566(ra) # 848 <close>
  return r;
     61a:	fe842783          	lw	a5,-24(s0)
}
     61e:	853e                	mv	a0,a5
     620:	70a2                	ld	ra,40(sp)
     622:	7402                	ld	s0,32(sp)
     624:	6145                	addi	sp,sp,48
     626:	8082                	ret

0000000000000628 <atoi>:

int
atoi(const char *s)
{
     628:	7179                	addi	sp,sp,-48
     62a:	f422                	sd	s0,40(sp)
     62c:	1800                	addi	s0,sp,48
     62e:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     632:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     636:	a815                	j	66a <atoi+0x42>
    n = n*10 + *s++ - '0';
     638:	fec42703          	lw	a4,-20(s0)
     63c:	87ba                	mv	a5,a4
     63e:	0027979b          	slliw	a5,a5,0x2
     642:	9fb9                	addw	a5,a5,a4
     644:	0017979b          	slliw	a5,a5,0x1
     648:	0007871b          	sext.w	a4,a5
     64c:	fd843783          	ld	a5,-40(s0)
     650:	00178693          	addi	a3,a5,1
     654:	fcd43c23          	sd	a3,-40(s0)
     658:	0007c783          	lbu	a5,0(a5)
     65c:	2781                	sext.w	a5,a5
     65e:	9fb9                	addw	a5,a5,a4
     660:	2781                	sext.w	a5,a5
     662:	fd07879b          	addiw	a5,a5,-48
     666:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     66a:	fd843783          	ld	a5,-40(s0)
     66e:	0007c783          	lbu	a5,0(a5)
     672:	873e                	mv	a4,a5
     674:	02f00793          	li	a5,47
     678:	00e7fb63          	bgeu	a5,a4,68e <atoi+0x66>
     67c:	fd843783          	ld	a5,-40(s0)
     680:	0007c783          	lbu	a5,0(a5)
     684:	873e                	mv	a4,a5
     686:	03900793          	li	a5,57
     68a:	fae7f7e3          	bgeu	a5,a4,638 <atoi+0x10>
  return n;
     68e:	fec42783          	lw	a5,-20(s0)
}
     692:	853e                	mv	a0,a5
     694:	7422                	ld	s0,40(sp)
     696:	6145                	addi	sp,sp,48
     698:	8082                	ret

000000000000069a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     69a:	7139                	addi	sp,sp,-64
     69c:	fc22                	sd	s0,56(sp)
     69e:	0080                	addi	s0,sp,64
     6a0:	fca43c23          	sd	a0,-40(s0)
     6a4:	fcb43823          	sd	a1,-48(s0)
     6a8:	87b2                	mv	a5,a2
     6aa:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     6ae:	fd843783          	ld	a5,-40(s0)
     6b2:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     6b6:	fd043783          	ld	a5,-48(s0)
     6ba:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     6be:	fe043703          	ld	a4,-32(s0)
     6c2:	fe843783          	ld	a5,-24(s0)
     6c6:	02e7fc63          	bgeu	a5,a4,6fe <memmove+0x64>
    while(n-- > 0)
     6ca:	a00d                	j	6ec <memmove+0x52>
      *dst++ = *src++;
     6cc:	fe043703          	ld	a4,-32(s0)
     6d0:	00170793          	addi	a5,a4,1
     6d4:	fef43023          	sd	a5,-32(s0)
     6d8:	fe843783          	ld	a5,-24(s0)
     6dc:	00178693          	addi	a3,a5,1
     6e0:	fed43423          	sd	a3,-24(s0)
     6e4:	00074703          	lbu	a4,0(a4)
     6e8:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     6ec:	fcc42783          	lw	a5,-52(s0)
     6f0:	fff7871b          	addiw	a4,a5,-1
     6f4:	fce42623          	sw	a4,-52(s0)
     6f8:	fcf04ae3          	bgtz	a5,6cc <memmove+0x32>
     6fc:	a891                	j	750 <memmove+0xb6>
  } else {
    dst += n;
     6fe:	fcc42783          	lw	a5,-52(s0)
     702:	fe843703          	ld	a4,-24(s0)
     706:	97ba                	add	a5,a5,a4
     708:	fef43423          	sd	a5,-24(s0)
    src += n;
     70c:	fcc42783          	lw	a5,-52(s0)
     710:	fe043703          	ld	a4,-32(s0)
     714:	97ba                	add	a5,a5,a4
     716:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     71a:	a01d                	j	740 <memmove+0xa6>
      *--dst = *--src;
     71c:	fe043783          	ld	a5,-32(s0)
     720:	17fd                	addi	a5,a5,-1
     722:	fef43023          	sd	a5,-32(s0)
     726:	fe843783          	ld	a5,-24(s0)
     72a:	17fd                	addi	a5,a5,-1
     72c:	fef43423          	sd	a5,-24(s0)
     730:	fe043783          	ld	a5,-32(s0)
     734:	0007c703          	lbu	a4,0(a5)
     738:	fe843783          	ld	a5,-24(s0)
     73c:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     740:	fcc42783          	lw	a5,-52(s0)
     744:	fff7871b          	addiw	a4,a5,-1
     748:	fce42623          	sw	a4,-52(s0)
     74c:	fcf048e3          	bgtz	a5,71c <memmove+0x82>
  }
  return vdst;
     750:	fd843783          	ld	a5,-40(s0)
}
     754:	853e                	mv	a0,a5
     756:	7462                	ld	s0,56(sp)
     758:	6121                	addi	sp,sp,64
     75a:	8082                	ret

000000000000075c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     75c:	7139                	addi	sp,sp,-64
     75e:	fc22                	sd	s0,56(sp)
     760:	0080                	addi	s0,sp,64
     762:	fca43c23          	sd	a0,-40(s0)
     766:	fcb43823          	sd	a1,-48(s0)
     76a:	87b2                	mv	a5,a2
     76c:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     770:	fd843783          	ld	a5,-40(s0)
     774:	fef43423          	sd	a5,-24(s0)
     778:	fd043783          	ld	a5,-48(s0)
     77c:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     780:	a0a1                	j	7c8 <memcmp+0x6c>
    if (*p1 != *p2) {
     782:	fe843783          	ld	a5,-24(s0)
     786:	0007c703          	lbu	a4,0(a5)
     78a:	fe043783          	ld	a5,-32(s0)
     78e:	0007c783          	lbu	a5,0(a5)
     792:	02f70163          	beq	a4,a5,7b4 <memcmp+0x58>
      return *p1 - *p2;
     796:	fe843783          	ld	a5,-24(s0)
     79a:	0007c783          	lbu	a5,0(a5)
     79e:	0007871b          	sext.w	a4,a5
     7a2:	fe043783          	ld	a5,-32(s0)
     7a6:	0007c783          	lbu	a5,0(a5)
     7aa:	2781                	sext.w	a5,a5
     7ac:	40f707bb          	subw	a5,a4,a5
     7b0:	2781                	sext.w	a5,a5
     7b2:	a01d                	j	7d8 <memcmp+0x7c>
    }
    p1++;
     7b4:	fe843783          	ld	a5,-24(s0)
     7b8:	0785                	addi	a5,a5,1
     7ba:	fef43423          	sd	a5,-24(s0)
    p2++;
     7be:	fe043783          	ld	a5,-32(s0)
     7c2:	0785                	addi	a5,a5,1
     7c4:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     7c8:	fcc42783          	lw	a5,-52(s0)
     7cc:	fff7871b          	addiw	a4,a5,-1
     7d0:	fce42623          	sw	a4,-52(s0)
     7d4:	f7dd                	bnez	a5,782 <memcmp+0x26>
  }
  return 0;
     7d6:	4781                	li	a5,0
}
     7d8:	853e                	mv	a0,a5
     7da:	7462                	ld	s0,56(sp)
     7dc:	6121                	addi	sp,sp,64
     7de:	8082                	ret

00000000000007e0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     7e0:	7179                	addi	sp,sp,-48
     7e2:	f406                	sd	ra,40(sp)
     7e4:	f022                	sd	s0,32(sp)
     7e6:	1800                	addi	s0,sp,48
     7e8:	fea43423          	sd	a0,-24(s0)
     7ec:	feb43023          	sd	a1,-32(s0)
     7f0:	87b2                	mv	a5,a2
     7f2:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     7f6:	fdc42783          	lw	a5,-36(s0)
     7fa:	863e                	mv	a2,a5
     7fc:	fe043583          	ld	a1,-32(s0)
     800:	fe843503          	ld	a0,-24(s0)
     804:	00000097          	auipc	ra,0x0
     808:	e96080e7          	jalr	-362(ra) # 69a <memmove>
     80c:	87aa                	mv	a5,a0
}
     80e:	853e                	mv	a0,a5
     810:	70a2                	ld	ra,40(sp)
     812:	7402                	ld	s0,32(sp)
     814:	6145                	addi	sp,sp,48
     816:	8082                	ret

0000000000000818 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     818:	4885                	li	a7,1
 ecall
     81a:	00000073          	ecall
 ret
     81e:	8082                	ret

0000000000000820 <exit>:
.global exit
exit:
 li a7, SYS_exit
     820:	4889                	li	a7,2
 ecall
     822:	00000073          	ecall
 ret
     826:	8082                	ret

0000000000000828 <wait>:
.global wait
wait:
 li a7, SYS_wait
     828:	488d                	li	a7,3
 ecall
     82a:	00000073          	ecall
 ret
     82e:	8082                	ret

0000000000000830 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     830:	4891                	li	a7,4
 ecall
     832:	00000073          	ecall
 ret
     836:	8082                	ret

0000000000000838 <read>:
.global read
read:
 li a7, SYS_read
     838:	4895                	li	a7,5
 ecall
     83a:	00000073          	ecall
 ret
     83e:	8082                	ret

0000000000000840 <write>:
.global write
write:
 li a7, SYS_write
     840:	48c1                	li	a7,16
 ecall
     842:	00000073          	ecall
 ret
     846:	8082                	ret

0000000000000848 <close>:
.global close
close:
 li a7, SYS_close
     848:	48d5                	li	a7,21
 ecall
     84a:	00000073          	ecall
 ret
     84e:	8082                	ret

0000000000000850 <kill>:
.global kill
kill:
 li a7, SYS_kill
     850:	4899                	li	a7,6
 ecall
     852:	00000073          	ecall
 ret
     856:	8082                	ret

0000000000000858 <exec>:
.global exec
exec:
 li a7, SYS_exec
     858:	489d                	li	a7,7
 ecall
     85a:	00000073          	ecall
 ret
     85e:	8082                	ret

0000000000000860 <open>:
.global open
open:
 li a7, SYS_open
     860:	48bd                	li	a7,15
 ecall
     862:	00000073          	ecall
 ret
     866:	8082                	ret

0000000000000868 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     868:	48c5                	li	a7,17
 ecall
     86a:	00000073          	ecall
 ret
     86e:	8082                	ret

0000000000000870 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     870:	48c9                	li	a7,18
 ecall
     872:	00000073          	ecall
 ret
     876:	8082                	ret

0000000000000878 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     878:	48a1                	li	a7,8
 ecall
     87a:	00000073          	ecall
 ret
     87e:	8082                	ret

0000000000000880 <link>:
.global link
link:
 li a7, SYS_link
     880:	48cd                	li	a7,19
 ecall
     882:	00000073          	ecall
 ret
     886:	8082                	ret

0000000000000888 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     888:	48d1                	li	a7,20
 ecall
     88a:	00000073          	ecall
 ret
     88e:	8082                	ret

0000000000000890 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     890:	48a5                	li	a7,9
 ecall
     892:	00000073          	ecall
 ret
     896:	8082                	ret

0000000000000898 <dup>:
.global dup
dup:
 li a7, SYS_dup
     898:	48a9                	li	a7,10
 ecall
     89a:	00000073          	ecall
 ret
     89e:	8082                	ret

00000000000008a0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     8a0:	48ad                	li	a7,11
 ecall
     8a2:	00000073          	ecall
 ret
     8a6:	8082                	ret

00000000000008a8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     8a8:	48b1                	li	a7,12
 ecall
     8aa:	00000073          	ecall
 ret
     8ae:	8082                	ret

00000000000008b0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     8b0:	48b5                	li	a7,13
 ecall
     8b2:	00000073          	ecall
 ret
     8b6:	8082                	ret

00000000000008b8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     8b8:	48b9                	li	a7,14
 ecall
     8ba:	00000073          	ecall
 ret
     8be:	8082                	ret

00000000000008c0 <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     8c0:	48d9                	li	a7,22
 ecall
     8c2:	00000073          	ecall
 ret
     8c6:	8082                	ret

00000000000008c8 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     8c8:	48dd                	li	a7,23
 ecall
     8ca:	00000073          	ecall
 ret
     8ce:	8082                	ret

00000000000008d0 <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     8d0:	48e1                	li	a7,24
 ecall
     8d2:	00000073          	ecall
 ret
     8d6:	8082                	ret

00000000000008d8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     8d8:	1101                	addi	sp,sp,-32
     8da:	ec06                	sd	ra,24(sp)
     8dc:	e822                	sd	s0,16(sp)
     8de:	1000                	addi	s0,sp,32
     8e0:	87aa                	mv	a5,a0
     8e2:	872e                	mv	a4,a1
     8e4:	fef42623          	sw	a5,-20(s0)
     8e8:	87ba                	mv	a5,a4
     8ea:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     8ee:	feb40713          	addi	a4,s0,-21
     8f2:	fec42783          	lw	a5,-20(s0)
     8f6:	4605                	li	a2,1
     8f8:	85ba                	mv	a1,a4
     8fa:	853e                	mv	a0,a5
     8fc:	00000097          	auipc	ra,0x0
     900:	f44080e7          	jalr	-188(ra) # 840 <write>
}
     904:	0001                	nop
     906:	60e2                	ld	ra,24(sp)
     908:	6442                	ld	s0,16(sp)
     90a:	6105                	addi	sp,sp,32
     90c:	8082                	ret

000000000000090e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     90e:	7139                	addi	sp,sp,-64
     910:	fc06                	sd	ra,56(sp)
     912:	f822                	sd	s0,48(sp)
     914:	0080                	addi	s0,sp,64
     916:	87aa                	mv	a5,a0
     918:	8736                	mv	a4,a3
     91a:	fcf42623          	sw	a5,-52(s0)
     91e:	87ae                	mv	a5,a1
     920:	fcf42423          	sw	a5,-56(s0)
     924:	87b2                	mv	a5,a2
     926:	fcf42223          	sw	a5,-60(s0)
     92a:	87ba                	mv	a5,a4
     92c:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     930:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     934:	fc042783          	lw	a5,-64(s0)
     938:	2781                	sext.w	a5,a5
     93a:	c38d                	beqz	a5,95c <printint+0x4e>
     93c:	fc842783          	lw	a5,-56(s0)
     940:	2781                	sext.w	a5,a5
     942:	0007dd63          	bgez	a5,95c <printint+0x4e>
    neg = 1;
     946:	4785                	li	a5,1
     948:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     94c:	fc842783          	lw	a5,-56(s0)
     950:	40f007bb          	negw	a5,a5
     954:	2781                	sext.w	a5,a5
     956:	fef42223          	sw	a5,-28(s0)
     95a:	a029                	j	964 <printint+0x56>
  } else {
    x = xx;
     95c:	fc842783          	lw	a5,-56(s0)
     960:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     964:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     968:	fc442783          	lw	a5,-60(s0)
     96c:	fe442703          	lw	a4,-28(s0)
     970:	02f777bb          	remuw	a5,a4,a5
     974:	0007861b          	sext.w	a2,a5
     978:	fec42783          	lw	a5,-20(s0)
     97c:	0017871b          	addiw	a4,a5,1
     980:	fee42623          	sw	a4,-20(s0)
     984:	00001697          	auipc	a3,0x1
     988:	3bc68693          	addi	a3,a3,956 # 1d40 <digits>
     98c:	02061713          	slli	a4,a2,0x20
     990:	9301                	srli	a4,a4,0x20
     992:	9736                	add	a4,a4,a3
     994:	00074703          	lbu	a4,0(a4)
     998:	ff040693          	addi	a3,s0,-16
     99c:	97b6                	add	a5,a5,a3
     99e:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     9a2:	fc442783          	lw	a5,-60(s0)
     9a6:	fe442703          	lw	a4,-28(s0)
     9aa:	02f757bb          	divuw	a5,a4,a5
     9ae:	fef42223          	sw	a5,-28(s0)
     9b2:	fe442783          	lw	a5,-28(s0)
     9b6:	2781                	sext.w	a5,a5
     9b8:	fbc5                	bnez	a5,968 <printint+0x5a>
  if(neg)
     9ba:	fe842783          	lw	a5,-24(s0)
     9be:	2781                	sext.w	a5,a5
     9c0:	cf95                	beqz	a5,9fc <printint+0xee>
    buf[i++] = '-';
     9c2:	fec42783          	lw	a5,-20(s0)
     9c6:	0017871b          	addiw	a4,a5,1
     9ca:	fee42623          	sw	a4,-20(s0)
     9ce:	ff040713          	addi	a4,s0,-16
     9d2:	97ba                	add	a5,a5,a4
     9d4:	02d00713          	li	a4,45
     9d8:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     9dc:	a005                	j	9fc <printint+0xee>
    putc(fd, buf[i]);
     9de:	fec42783          	lw	a5,-20(s0)
     9e2:	ff040713          	addi	a4,s0,-16
     9e6:	97ba                	add	a5,a5,a4
     9e8:	fe07c703          	lbu	a4,-32(a5)
     9ec:	fcc42783          	lw	a5,-52(s0)
     9f0:	85ba                	mv	a1,a4
     9f2:	853e                	mv	a0,a5
     9f4:	00000097          	auipc	ra,0x0
     9f8:	ee4080e7          	jalr	-284(ra) # 8d8 <putc>
  while(--i >= 0)
     9fc:	fec42783          	lw	a5,-20(s0)
     a00:	37fd                	addiw	a5,a5,-1
     a02:	fef42623          	sw	a5,-20(s0)
     a06:	fec42783          	lw	a5,-20(s0)
     a0a:	2781                	sext.w	a5,a5
     a0c:	fc07d9e3          	bgez	a5,9de <printint+0xd0>
}
     a10:	0001                	nop
     a12:	0001                	nop
     a14:	70e2                	ld	ra,56(sp)
     a16:	7442                	ld	s0,48(sp)
     a18:	6121                	addi	sp,sp,64
     a1a:	8082                	ret

0000000000000a1c <printptr>:

static void
printptr(int fd, uint64 x) {
     a1c:	7179                	addi	sp,sp,-48
     a1e:	f406                	sd	ra,40(sp)
     a20:	f022                	sd	s0,32(sp)
     a22:	1800                	addi	s0,sp,48
     a24:	87aa                	mv	a5,a0
     a26:	fcb43823          	sd	a1,-48(s0)
     a2a:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     a2e:	fdc42783          	lw	a5,-36(s0)
     a32:	03000593          	li	a1,48
     a36:	853e                	mv	a0,a5
     a38:	00000097          	auipc	ra,0x0
     a3c:	ea0080e7          	jalr	-352(ra) # 8d8 <putc>
  putc(fd, 'x');
     a40:	fdc42783          	lw	a5,-36(s0)
     a44:	07800593          	li	a1,120
     a48:	853e                	mv	a0,a5
     a4a:	00000097          	auipc	ra,0x0
     a4e:	e8e080e7          	jalr	-370(ra) # 8d8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     a52:	fe042623          	sw	zero,-20(s0)
     a56:	a82d                	j	a90 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     a58:	fd043783          	ld	a5,-48(s0)
     a5c:	93f1                	srli	a5,a5,0x3c
     a5e:	00001717          	auipc	a4,0x1
     a62:	2e270713          	addi	a4,a4,738 # 1d40 <digits>
     a66:	97ba                	add	a5,a5,a4
     a68:	0007c703          	lbu	a4,0(a5)
     a6c:	fdc42783          	lw	a5,-36(s0)
     a70:	85ba                	mv	a1,a4
     a72:	853e                	mv	a0,a5
     a74:	00000097          	auipc	ra,0x0
     a78:	e64080e7          	jalr	-412(ra) # 8d8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     a7c:	fec42783          	lw	a5,-20(s0)
     a80:	2785                	addiw	a5,a5,1
     a82:	fef42623          	sw	a5,-20(s0)
     a86:	fd043783          	ld	a5,-48(s0)
     a8a:	0792                	slli	a5,a5,0x4
     a8c:	fcf43823          	sd	a5,-48(s0)
     a90:	fec42783          	lw	a5,-20(s0)
     a94:	873e                	mv	a4,a5
     a96:	47bd                	li	a5,15
     a98:	fce7f0e3          	bgeu	a5,a4,a58 <printptr+0x3c>
}
     a9c:	0001                	nop
     a9e:	0001                	nop
     aa0:	70a2                	ld	ra,40(sp)
     aa2:	7402                	ld	s0,32(sp)
     aa4:	6145                	addi	sp,sp,48
     aa6:	8082                	ret

0000000000000aa8 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     aa8:	715d                	addi	sp,sp,-80
     aaa:	e486                	sd	ra,72(sp)
     aac:	e0a2                	sd	s0,64(sp)
     aae:	0880                	addi	s0,sp,80
     ab0:	87aa                	mv	a5,a0
     ab2:	fcb43023          	sd	a1,-64(s0)
     ab6:	fac43c23          	sd	a2,-72(s0)
     aba:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     abe:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     ac2:	fe042223          	sw	zero,-28(s0)
     ac6:	a42d                	j	cf0 <vprintf+0x248>
    c = fmt[i] & 0xff;
     ac8:	fe442783          	lw	a5,-28(s0)
     acc:	fc043703          	ld	a4,-64(s0)
     ad0:	97ba                	add	a5,a5,a4
     ad2:	0007c783          	lbu	a5,0(a5)
     ad6:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     ada:	fe042783          	lw	a5,-32(s0)
     ade:	2781                	sext.w	a5,a5
     ae0:	eb9d                	bnez	a5,b16 <vprintf+0x6e>
      if(c == '%'){
     ae2:	fdc42783          	lw	a5,-36(s0)
     ae6:	0007871b          	sext.w	a4,a5
     aea:	02500793          	li	a5,37
     aee:	00f71763          	bne	a4,a5,afc <vprintf+0x54>
        state = '%';
     af2:	02500793          	li	a5,37
     af6:	fef42023          	sw	a5,-32(s0)
     afa:	a2f5                	j	ce6 <vprintf+0x23e>
      } else {
        putc(fd, c);
     afc:	fdc42783          	lw	a5,-36(s0)
     b00:	0ff7f713          	andi	a4,a5,255
     b04:	fcc42783          	lw	a5,-52(s0)
     b08:	85ba                	mv	a1,a4
     b0a:	853e                	mv	a0,a5
     b0c:	00000097          	auipc	ra,0x0
     b10:	dcc080e7          	jalr	-564(ra) # 8d8 <putc>
     b14:	aac9                	j	ce6 <vprintf+0x23e>
      }
    } else if(state == '%'){
     b16:	fe042783          	lw	a5,-32(s0)
     b1a:	0007871b          	sext.w	a4,a5
     b1e:	02500793          	li	a5,37
     b22:	1cf71263          	bne	a4,a5,ce6 <vprintf+0x23e>
      if(c == 'd'){
     b26:	fdc42783          	lw	a5,-36(s0)
     b2a:	0007871b          	sext.w	a4,a5
     b2e:	06400793          	li	a5,100
     b32:	02f71463          	bne	a4,a5,b5a <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     b36:	fb843783          	ld	a5,-72(s0)
     b3a:	00878713          	addi	a4,a5,8
     b3e:	fae43c23          	sd	a4,-72(s0)
     b42:	4398                	lw	a4,0(a5)
     b44:	fcc42783          	lw	a5,-52(s0)
     b48:	4685                	li	a3,1
     b4a:	4629                	li	a2,10
     b4c:	85ba                	mv	a1,a4
     b4e:	853e                	mv	a0,a5
     b50:	00000097          	auipc	ra,0x0
     b54:	dbe080e7          	jalr	-578(ra) # 90e <printint>
     b58:	a269                	j	ce2 <vprintf+0x23a>
      } else if(c == 'l') {
     b5a:	fdc42783          	lw	a5,-36(s0)
     b5e:	0007871b          	sext.w	a4,a5
     b62:	06c00793          	li	a5,108
     b66:	02f71663          	bne	a4,a5,b92 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     b6a:	fb843783          	ld	a5,-72(s0)
     b6e:	00878713          	addi	a4,a5,8
     b72:	fae43c23          	sd	a4,-72(s0)
     b76:	639c                	ld	a5,0(a5)
     b78:	0007871b          	sext.w	a4,a5
     b7c:	fcc42783          	lw	a5,-52(s0)
     b80:	4681                	li	a3,0
     b82:	4629                	li	a2,10
     b84:	85ba                	mv	a1,a4
     b86:	853e                	mv	a0,a5
     b88:	00000097          	auipc	ra,0x0
     b8c:	d86080e7          	jalr	-634(ra) # 90e <printint>
     b90:	aa89                	j	ce2 <vprintf+0x23a>
      } else if(c == 'x') {
     b92:	fdc42783          	lw	a5,-36(s0)
     b96:	0007871b          	sext.w	a4,a5
     b9a:	07800793          	li	a5,120
     b9e:	02f71463          	bne	a4,a5,bc6 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     ba2:	fb843783          	ld	a5,-72(s0)
     ba6:	00878713          	addi	a4,a5,8
     baa:	fae43c23          	sd	a4,-72(s0)
     bae:	4398                	lw	a4,0(a5)
     bb0:	fcc42783          	lw	a5,-52(s0)
     bb4:	4681                	li	a3,0
     bb6:	4641                	li	a2,16
     bb8:	85ba                	mv	a1,a4
     bba:	853e                	mv	a0,a5
     bbc:	00000097          	auipc	ra,0x0
     bc0:	d52080e7          	jalr	-686(ra) # 90e <printint>
     bc4:	aa39                	j	ce2 <vprintf+0x23a>
      } else if(c == 'p') {
     bc6:	fdc42783          	lw	a5,-36(s0)
     bca:	0007871b          	sext.w	a4,a5
     bce:	07000793          	li	a5,112
     bd2:	02f71263          	bne	a4,a5,bf6 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     bd6:	fb843783          	ld	a5,-72(s0)
     bda:	00878713          	addi	a4,a5,8
     bde:	fae43c23          	sd	a4,-72(s0)
     be2:	6398                	ld	a4,0(a5)
     be4:	fcc42783          	lw	a5,-52(s0)
     be8:	85ba                	mv	a1,a4
     bea:	853e                	mv	a0,a5
     bec:	00000097          	auipc	ra,0x0
     bf0:	e30080e7          	jalr	-464(ra) # a1c <printptr>
     bf4:	a0fd                	j	ce2 <vprintf+0x23a>
      } else if(c == 's'){
     bf6:	fdc42783          	lw	a5,-36(s0)
     bfa:	0007871b          	sext.w	a4,a5
     bfe:	07300793          	li	a5,115
     c02:	04f71c63          	bne	a4,a5,c5a <vprintf+0x1b2>
        s = va_arg(ap, char*);
     c06:	fb843783          	ld	a5,-72(s0)
     c0a:	00878713          	addi	a4,a5,8
     c0e:	fae43c23          	sd	a4,-72(s0)
     c12:	639c                	ld	a5,0(a5)
     c14:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     c18:	fe843783          	ld	a5,-24(s0)
     c1c:	eb8d                	bnez	a5,c4e <vprintf+0x1a6>
          s = "(null)";
     c1e:	00001797          	auipc	a5,0x1
     c22:	11a78793          	addi	a5,a5,282 # 1d38 <schedule_dm+0x24a>
     c26:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     c2a:	a015                	j	c4e <vprintf+0x1a6>
          putc(fd, *s);
     c2c:	fe843783          	ld	a5,-24(s0)
     c30:	0007c703          	lbu	a4,0(a5)
     c34:	fcc42783          	lw	a5,-52(s0)
     c38:	85ba                	mv	a1,a4
     c3a:	853e                	mv	a0,a5
     c3c:	00000097          	auipc	ra,0x0
     c40:	c9c080e7          	jalr	-868(ra) # 8d8 <putc>
          s++;
     c44:	fe843783          	ld	a5,-24(s0)
     c48:	0785                	addi	a5,a5,1
     c4a:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     c4e:	fe843783          	ld	a5,-24(s0)
     c52:	0007c783          	lbu	a5,0(a5)
     c56:	fbf9                	bnez	a5,c2c <vprintf+0x184>
     c58:	a069                	j	ce2 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     c5a:	fdc42783          	lw	a5,-36(s0)
     c5e:	0007871b          	sext.w	a4,a5
     c62:	06300793          	li	a5,99
     c66:	02f71463          	bne	a4,a5,c8e <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     c6a:	fb843783          	ld	a5,-72(s0)
     c6e:	00878713          	addi	a4,a5,8
     c72:	fae43c23          	sd	a4,-72(s0)
     c76:	439c                	lw	a5,0(a5)
     c78:	0ff7f713          	andi	a4,a5,255
     c7c:	fcc42783          	lw	a5,-52(s0)
     c80:	85ba                	mv	a1,a4
     c82:	853e                	mv	a0,a5
     c84:	00000097          	auipc	ra,0x0
     c88:	c54080e7          	jalr	-940(ra) # 8d8 <putc>
     c8c:	a899                	j	ce2 <vprintf+0x23a>
      } else if(c == '%'){
     c8e:	fdc42783          	lw	a5,-36(s0)
     c92:	0007871b          	sext.w	a4,a5
     c96:	02500793          	li	a5,37
     c9a:	00f71f63          	bne	a4,a5,cb8 <vprintf+0x210>
        putc(fd, c);
     c9e:	fdc42783          	lw	a5,-36(s0)
     ca2:	0ff7f713          	andi	a4,a5,255
     ca6:	fcc42783          	lw	a5,-52(s0)
     caa:	85ba                	mv	a1,a4
     cac:	853e                	mv	a0,a5
     cae:	00000097          	auipc	ra,0x0
     cb2:	c2a080e7          	jalr	-982(ra) # 8d8 <putc>
     cb6:	a035                	j	ce2 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     cb8:	fcc42783          	lw	a5,-52(s0)
     cbc:	02500593          	li	a1,37
     cc0:	853e                	mv	a0,a5
     cc2:	00000097          	auipc	ra,0x0
     cc6:	c16080e7          	jalr	-1002(ra) # 8d8 <putc>
        putc(fd, c);
     cca:	fdc42783          	lw	a5,-36(s0)
     cce:	0ff7f713          	andi	a4,a5,255
     cd2:	fcc42783          	lw	a5,-52(s0)
     cd6:	85ba                	mv	a1,a4
     cd8:	853e                	mv	a0,a5
     cda:	00000097          	auipc	ra,0x0
     cde:	bfe080e7          	jalr	-1026(ra) # 8d8 <putc>
      }
      state = 0;
     ce2:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     ce6:	fe442783          	lw	a5,-28(s0)
     cea:	2785                	addiw	a5,a5,1
     cec:	fef42223          	sw	a5,-28(s0)
     cf0:	fe442783          	lw	a5,-28(s0)
     cf4:	fc043703          	ld	a4,-64(s0)
     cf8:	97ba                	add	a5,a5,a4
     cfa:	0007c783          	lbu	a5,0(a5)
     cfe:	dc0795e3          	bnez	a5,ac8 <vprintf+0x20>
    }
  }
}
     d02:	0001                	nop
     d04:	0001                	nop
     d06:	60a6                	ld	ra,72(sp)
     d08:	6406                	ld	s0,64(sp)
     d0a:	6161                	addi	sp,sp,80
     d0c:	8082                	ret

0000000000000d0e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     d0e:	7159                	addi	sp,sp,-112
     d10:	fc06                	sd	ra,56(sp)
     d12:	f822                	sd	s0,48(sp)
     d14:	0080                	addi	s0,sp,64
     d16:	fcb43823          	sd	a1,-48(s0)
     d1a:	e010                	sd	a2,0(s0)
     d1c:	e414                	sd	a3,8(s0)
     d1e:	e818                	sd	a4,16(s0)
     d20:	ec1c                	sd	a5,24(s0)
     d22:	03043023          	sd	a6,32(s0)
     d26:	03143423          	sd	a7,40(s0)
     d2a:	87aa                	mv	a5,a0
     d2c:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     d30:	03040793          	addi	a5,s0,48
     d34:	fcf43423          	sd	a5,-56(s0)
     d38:	fc843783          	ld	a5,-56(s0)
     d3c:	fd078793          	addi	a5,a5,-48
     d40:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     d44:	fe843703          	ld	a4,-24(s0)
     d48:	fdc42783          	lw	a5,-36(s0)
     d4c:	863a                	mv	a2,a4
     d4e:	fd043583          	ld	a1,-48(s0)
     d52:	853e                	mv	a0,a5
     d54:	00000097          	auipc	ra,0x0
     d58:	d54080e7          	jalr	-684(ra) # aa8 <vprintf>
}
     d5c:	0001                	nop
     d5e:	70e2                	ld	ra,56(sp)
     d60:	7442                	ld	s0,48(sp)
     d62:	6165                	addi	sp,sp,112
     d64:	8082                	ret

0000000000000d66 <printf>:

void
printf(const char *fmt, ...)
{
     d66:	7159                	addi	sp,sp,-112
     d68:	f406                	sd	ra,40(sp)
     d6a:	f022                	sd	s0,32(sp)
     d6c:	1800                	addi	s0,sp,48
     d6e:	fca43c23          	sd	a0,-40(s0)
     d72:	e40c                	sd	a1,8(s0)
     d74:	e810                	sd	a2,16(s0)
     d76:	ec14                	sd	a3,24(s0)
     d78:	f018                	sd	a4,32(s0)
     d7a:	f41c                	sd	a5,40(s0)
     d7c:	03043823          	sd	a6,48(s0)
     d80:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     d84:	04040793          	addi	a5,s0,64
     d88:	fcf43823          	sd	a5,-48(s0)
     d8c:	fd043783          	ld	a5,-48(s0)
     d90:	fc878793          	addi	a5,a5,-56
     d94:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     d98:	fe843783          	ld	a5,-24(s0)
     d9c:	863e                	mv	a2,a5
     d9e:	fd843583          	ld	a1,-40(s0)
     da2:	4505                	li	a0,1
     da4:	00000097          	auipc	ra,0x0
     da8:	d04080e7          	jalr	-764(ra) # aa8 <vprintf>
}
     dac:	0001                	nop
     dae:	70a2                	ld	ra,40(sp)
     db0:	7402                	ld	s0,32(sp)
     db2:	6165                	addi	sp,sp,112
     db4:	8082                	ret

0000000000000db6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     db6:	7179                	addi	sp,sp,-48
     db8:	f422                	sd	s0,40(sp)
     dba:	1800                	addi	s0,sp,48
     dbc:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     dc0:	fd843783          	ld	a5,-40(s0)
     dc4:	17c1                	addi	a5,a5,-16
     dc6:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     dca:	00001797          	auipc	a5,0x1
     dce:	fae78793          	addi	a5,a5,-82 # 1d78 <freep>
     dd2:	639c                	ld	a5,0(a5)
     dd4:	fef43423          	sd	a5,-24(s0)
     dd8:	a815                	j	e0c <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     dda:	fe843783          	ld	a5,-24(s0)
     dde:	639c                	ld	a5,0(a5)
     de0:	fe843703          	ld	a4,-24(s0)
     de4:	00f76f63          	bltu	a4,a5,e02 <free+0x4c>
     de8:	fe043703          	ld	a4,-32(s0)
     dec:	fe843783          	ld	a5,-24(s0)
     df0:	02e7eb63          	bltu	a5,a4,e26 <free+0x70>
     df4:	fe843783          	ld	a5,-24(s0)
     df8:	639c                	ld	a5,0(a5)
     dfa:	fe043703          	ld	a4,-32(s0)
     dfe:	02f76463          	bltu	a4,a5,e26 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e02:	fe843783          	ld	a5,-24(s0)
     e06:	639c                	ld	a5,0(a5)
     e08:	fef43423          	sd	a5,-24(s0)
     e0c:	fe043703          	ld	a4,-32(s0)
     e10:	fe843783          	ld	a5,-24(s0)
     e14:	fce7f3e3          	bgeu	a5,a4,dda <free+0x24>
     e18:	fe843783          	ld	a5,-24(s0)
     e1c:	639c                	ld	a5,0(a5)
     e1e:	fe043703          	ld	a4,-32(s0)
     e22:	faf77ce3          	bgeu	a4,a5,dda <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     e26:	fe043783          	ld	a5,-32(s0)
     e2a:	479c                	lw	a5,8(a5)
     e2c:	1782                	slli	a5,a5,0x20
     e2e:	9381                	srli	a5,a5,0x20
     e30:	0792                	slli	a5,a5,0x4
     e32:	fe043703          	ld	a4,-32(s0)
     e36:	973e                	add	a4,a4,a5
     e38:	fe843783          	ld	a5,-24(s0)
     e3c:	639c                	ld	a5,0(a5)
     e3e:	02f71763          	bne	a4,a5,e6c <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     e42:	fe043783          	ld	a5,-32(s0)
     e46:	4798                	lw	a4,8(a5)
     e48:	fe843783          	ld	a5,-24(s0)
     e4c:	639c                	ld	a5,0(a5)
     e4e:	479c                	lw	a5,8(a5)
     e50:	9fb9                	addw	a5,a5,a4
     e52:	0007871b          	sext.w	a4,a5
     e56:	fe043783          	ld	a5,-32(s0)
     e5a:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     e5c:	fe843783          	ld	a5,-24(s0)
     e60:	639c                	ld	a5,0(a5)
     e62:	6398                	ld	a4,0(a5)
     e64:	fe043783          	ld	a5,-32(s0)
     e68:	e398                	sd	a4,0(a5)
     e6a:	a039                	j	e78 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     e6c:	fe843783          	ld	a5,-24(s0)
     e70:	6398                	ld	a4,0(a5)
     e72:	fe043783          	ld	a5,-32(s0)
     e76:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     e78:	fe843783          	ld	a5,-24(s0)
     e7c:	479c                	lw	a5,8(a5)
     e7e:	1782                	slli	a5,a5,0x20
     e80:	9381                	srli	a5,a5,0x20
     e82:	0792                	slli	a5,a5,0x4
     e84:	fe843703          	ld	a4,-24(s0)
     e88:	97ba                	add	a5,a5,a4
     e8a:	fe043703          	ld	a4,-32(s0)
     e8e:	02f71563          	bne	a4,a5,eb8 <free+0x102>
    p->s.size += bp->s.size;
     e92:	fe843783          	ld	a5,-24(s0)
     e96:	4798                	lw	a4,8(a5)
     e98:	fe043783          	ld	a5,-32(s0)
     e9c:	479c                	lw	a5,8(a5)
     e9e:	9fb9                	addw	a5,a5,a4
     ea0:	0007871b          	sext.w	a4,a5
     ea4:	fe843783          	ld	a5,-24(s0)
     ea8:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     eaa:	fe043783          	ld	a5,-32(s0)
     eae:	6398                	ld	a4,0(a5)
     eb0:	fe843783          	ld	a5,-24(s0)
     eb4:	e398                	sd	a4,0(a5)
     eb6:	a031                	j	ec2 <free+0x10c>
  } else
    p->s.ptr = bp;
     eb8:	fe843783          	ld	a5,-24(s0)
     ebc:	fe043703          	ld	a4,-32(s0)
     ec0:	e398                	sd	a4,0(a5)
  freep = p;
     ec2:	00001797          	auipc	a5,0x1
     ec6:	eb678793          	addi	a5,a5,-330 # 1d78 <freep>
     eca:	fe843703          	ld	a4,-24(s0)
     ece:	e398                	sd	a4,0(a5)
}
     ed0:	0001                	nop
     ed2:	7422                	ld	s0,40(sp)
     ed4:	6145                	addi	sp,sp,48
     ed6:	8082                	ret

0000000000000ed8 <morecore>:

static Header*
morecore(uint nu)
{
     ed8:	7179                	addi	sp,sp,-48
     eda:	f406                	sd	ra,40(sp)
     edc:	f022                	sd	s0,32(sp)
     ede:	1800                	addi	s0,sp,48
     ee0:	87aa                	mv	a5,a0
     ee2:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     ee6:	fdc42783          	lw	a5,-36(s0)
     eea:	0007871b          	sext.w	a4,a5
     eee:	6785                	lui	a5,0x1
     ef0:	00f77563          	bgeu	a4,a5,efa <morecore+0x22>
    nu = 4096;
     ef4:	6785                	lui	a5,0x1
     ef6:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     efa:	fdc42783          	lw	a5,-36(s0)
     efe:	0047979b          	slliw	a5,a5,0x4
     f02:	2781                	sext.w	a5,a5
     f04:	2781                	sext.w	a5,a5
     f06:	853e                	mv	a0,a5
     f08:	00000097          	auipc	ra,0x0
     f0c:	9a0080e7          	jalr	-1632(ra) # 8a8 <sbrk>
     f10:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     f14:	fe843703          	ld	a4,-24(s0)
     f18:	57fd                	li	a5,-1
     f1a:	00f71463          	bne	a4,a5,f22 <morecore+0x4a>
    return 0;
     f1e:	4781                	li	a5,0
     f20:	a03d                	j	f4e <morecore+0x76>
  hp = (Header*)p;
     f22:	fe843783          	ld	a5,-24(s0)
     f26:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     f2a:	fe043783          	ld	a5,-32(s0)
     f2e:	fdc42703          	lw	a4,-36(s0)
     f32:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     f34:	fe043783          	ld	a5,-32(s0)
     f38:	07c1                	addi	a5,a5,16
     f3a:	853e                	mv	a0,a5
     f3c:	00000097          	auipc	ra,0x0
     f40:	e7a080e7          	jalr	-390(ra) # db6 <free>
  return freep;
     f44:	00001797          	auipc	a5,0x1
     f48:	e3478793          	addi	a5,a5,-460 # 1d78 <freep>
     f4c:	639c                	ld	a5,0(a5)
}
     f4e:	853e                	mv	a0,a5
     f50:	70a2                	ld	ra,40(sp)
     f52:	7402                	ld	s0,32(sp)
     f54:	6145                	addi	sp,sp,48
     f56:	8082                	ret

0000000000000f58 <malloc>:

void*
malloc(uint nbytes)
{
     f58:	7139                	addi	sp,sp,-64
     f5a:	fc06                	sd	ra,56(sp)
     f5c:	f822                	sd	s0,48(sp)
     f5e:	0080                	addi	s0,sp,64
     f60:	87aa                	mv	a5,a0
     f62:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     f66:	fcc46783          	lwu	a5,-52(s0)
     f6a:	07bd                	addi	a5,a5,15
     f6c:	8391                	srli	a5,a5,0x4
     f6e:	2781                	sext.w	a5,a5
     f70:	2785                	addiw	a5,a5,1
     f72:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     f76:	00001797          	auipc	a5,0x1
     f7a:	e0278793          	addi	a5,a5,-510 # 1d78 <freep>
     f7e:	639c                	ld	a5,0(a5)
     f80:	fef43023          	sd	a5,-32(s0)
     f84:	fe043783          	ld	a5,-32(s0)
     f88:	ef95                	bnez	a5,fc4 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     f8a:	00001797          	auipc	a5,0x1
     f8e:	dde78793          	addi	a5,a5,-546 # 1d68 <base>
     f92:	fef43023          	sd	a5,-32(s0)
     f96:	00001797          	auipc	a5,0x1
     f9a:	de278793          	addi	a5,a5,-542 # 1d78 <freep>
     f9e:	fe043703          	ld	a4,-32(s0)
     fa2:	e398                	sd	a4,0(a5)
     fa4:	00001797          	auipc	a5,0x1
     fa8:	dd478793          	addi	a5,a5,-556 # 1d78 <freep>
     fac:	6398                	ld	a4,0(a5)
     fae:	00001797          	auipc	a5,0x1
     fb2:	dba78793          	addi	a5,a5,-582 # 1d68 <base>
     fb6:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     fb8:	00001797          	auipc	a5,0x1
     fbc:	db078793          	addi	a5,a5,-592 # 1d68 <base>
     fc0:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     fc4:	fe043783          	ld	a5,-32(s0)
     fc8:	639c                	ld	a5,0(a5)
     fca:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     fce:	fe843783          	ld	a5,-24(s0)
     fd2:	4798                	lw	a4,8(a5)
     fd4:	fdc42783          	lw	a5,-36(s0)
     fd8:	2781                	sext.w	a5,a5
     fda:	06f76863          	bltu	a4,a5,104a <malloc+0xf2>
      if(p->s.size == nunits)
     fde:	fe843783          	ld	a5,-24(s0)
     fe2:	4798                	lw	a4,8(a5)
     fe4:	fdc42783          	lw	a5,-36(s0)
     fe8:	2781                	sext.w	a5,a5
     fea:	00e79963          	bne	a5,a4,ffc <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     fee:	fe843783          	ld	a5,-24(s0)
     ff2:	6398                	ld	a4,0(a5)
     ff4:	fe043783          	ld	a5,-32(s0)
     ff8:	e398                	sd	a4,0(a5)
     ffa:	a82d                	j	1034 <malloc+0xdc>
      else {
        p->s.size -= nunits;
     ffc:	fe843783          	ld	a5,-24(s0)
    1000:	4798                	lw	a4,8(a5)
    1002:	fdc42783          	lw	a5,-36(s0)
    1006:	40f707bb          	subw	a5,a4,a5
    100a:	0007871b          	sext.w	a4,a5
    100e:	fe843783          	ld	a5,-24(s0)
    1012:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1014:	fe843783          	ld	a5,-24(s0)
    1018:	479c                	lw	a5,8(a5)
    101a:	1782                	slli	a5,a5,0x20
    101c:	9381                	srli	a5,a5,0x20
    101e:	0792                	slli	a5,a5,0x4
    1020:	fe843703          	ld	a4,-24(s0)
    1024:	97ba                	add	a5,a5,a4
    1026:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    102a:	fe843783          	ld	a5,-24(s0)
    102e:	fdc42703          	lw	a4,-36(s0)
    1032:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    1034:	00001797          	auipc	a5,0x1
    1038:	d4478793          	addi	a5,a5,-700 # 1d78 <freep>
    103c:	fe043703          	ld	a4,-32(s0)
    1040:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1042:	fe843783          	ld	a5,-24(s0)
    1046:	07c1                	addi	a5,a5,16
    1048:	a091                	j	108c <malloc+0x134>
    }
    if(p == freep)
    104a:	00001797          	auipc	a5,0x1
    104e:	d2e78793          	addi	a5,a5,-722 # 1d78 <freep>
    1052:	639c                	ld	a5,0(a5)
    1054:	fe843703          	ld	a4,-24(s0)
    1058:	02f71063          	bne	a4,a5,1078 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
    105c:	fdc42783          	lw	a5,-36(s0)
    1060:	853e                	mv	a0,a5
    1062:	00000097          	auipc	ra,0x0
    1066:	e76080e7          	jalr	-394(ra) # ed8 <morecore>
    106a:	fea43423          	sd	a0,-24(s0)
    106e:	fe843783          	ld	a5,-24(s0)
    1072:	e399                	bnez	a5,1078 <malloc+0x120>
        return 0;
    1074:	4781                	li	a5,0
    1076:	a819                	j	108c <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1078:	fe843783          	ld	a5,-24(s0)
    107c:	fef43023          	sd	a5,-32(s0)
    1080:	fe843783          	ld	a5,-24(s0)
    1084:	639c                	ld	a5,0(a5)
    1086:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    108a:	b791                	j	fce <malloc+0x76>
  }
}
    108c:	853e                	mv	a0,a5
    108e:	70e2                	ld	ra,56(sp)
    1090:	7442                	ld	s0,48(sp)
    1092:	6121                	addi	sp,sp,64
    1094:	8082                	ret

0000000000001096 <setjmp>:
    1096:	e100                	sd	s0,0(a0)
    1098:	e504                	sd	s1,8(a0)
    109a:	01253823          	sd	s2,16(a0)
    109e:	01353c23          	sd	s3,24(a0)
    10a2:	03453023          	sd	s4,32(a0)
    10a6:	03553423          	sd	s5,40(a0)
    10aa:	03653823          	sd	s6,48(a0)
    10ae:	03753c23          	sd	s7,56(a0)
    10b2:	05853023          	sd	s8,64(a0)
    10b6:	05953423          	sd	s9,72(a0)
    10ba:	05a53823          	sd	s10,80(a0)
    10be:	05b53c23          	sd	s11,88(a0)
    10c2:	06153023          	sd	ra,96(a0)
    10c6:	06253423          	sd	sp,104(a0)
    10ca:	4501                	li	a0,0
    10cc:	8082                	ret

00000000000010ce <longjmp>:
    10ce:	6100                	ld	s0,0(a0)
    10d0:	6504                	ld	s1,8(a0)
    10d2:	01053903          	ld	s2,16(a0)
    10d6:	01853983          	ld	s3,24(a0)
    10da:	02053a03          	ld	s4,32(a0)
    10de:	02853a83          	ld	s5,40(a0)
    10e2:	03053b03          	ld	s6,48(a0)
    10e6:	03853b83          	ld	s7,56(a0)
    10ea:	04053c03          	ld	s8,64(a0)
    10ee:	04853c83          	ld	s9,72(a0)
    10f2:	05053d03          	ld	s10,80(a0)
    10f6:	05853d83          	ld	s11,88(a0)
    10fa:	06053083          	ld	ra,96(a0)
    10fe:	06853103          	ld	sp,104(a0)
    1102:	c199                	beqz	a1,1108 <longjmp_1>
    1104:	852e                	mv	a0,a1
    1106:	8082                	ret

0000000000001108 <longjmp_1>:
    1108:	4505                	li	a0,1
    110a:	8082                	ret

000000000000110c <schedule_default>:
#define INT_MAX 2147483647
#define TIME_QUANTUM 2  // Define a base time quantum for the round-robin

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
    110c:	715d                	addi	sp,sp,-80
    110e:	e4a2                	sd	s0,72(sp)
    1110:	e0a6                	sd	s1,64(sp)
    1112:	0880                	addi	s0,sp,80
    1114:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
    1116:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
    111a:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
    111e:	649c                	ld	a5,8(s1)
    1120:	639c                	ld	a5,0(a5)
    1122:	fcf43c23          	sd	a5,-40(s0)
    1126:	fd843783          	ld	a5,-40(s0)
    112a:	fd878793          	addi	a5,a5,-40
    112e:	fef43023          	sd	a5,-32(s0)
    1132:	a81d                	j	1168 <schedule_default+0x5c>
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
    1134:	fe843783          	ld	a5,-24(s0)
    1138:	cb89                	beqz	a5,114a <schedule_default+0x3e>
    113a:	fe043783          	ld	a5,-32(s0)
    113e:	5fd8                	lw	a4,60(a5)
    1140:	fe843783          	ld	a5,-24(s0)
    1144:	5fdc                	lw	a5,60(a5)
    1146:	00f75663          	bge	a4,a5,1152 <schedule_default+0x46>
            thread_with_smallest_id = th;
    114a:	fe043783          	ld	a5,-32(s0)
    114e:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
    1152:	fe043783          	ld	a5,-32(s0)
    1156:	779c                	ld	a5,40(a5)
    1158:	fcf43823          	sd	a5,-48(s0)
    115c:	fd043783          	ld	a5,-48(s0)
    1160:	fd878793          	addi	a5,a5,-40
    1164:	fef43023          	sd	a5,-32(s0)
    1168:	fe043783          	ld	a5,-32(s0)
    116c:	02878713          	addi	a4,a5,40
    1170:	649c                	ld	a5,8(s1)
    1172:	fcf711e3          	bne	a4,a5,1134 <schedule_default+0x28>
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
    1176:	fe843783          	ld	a5,-24(s0)
    117a:	cf89                	beqz	a5,1194 <schedule_default+0x88>
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
    117c:	fe843783          	ld	a5,-24(s0)
    1180:	02878793          	addi	a5,a5,40
    1184:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
    1188:	fe843783          	ld	a5,-24(s0)
    118c:	4fbc                	lw	a5,88(a5)
    118e:	faf42c23          	sw	a5,-72(s0)
    1192:	a039                	j	11a0 <schedule_default+0x94>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
    1194:	649c                	ld	a5,8(s1)
    1196:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
    119a:	4785                	li	a5,1
    119c:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
    11a0:	fb043783          	ld	a5,-80(s0)
    11a4:	fcf43023          	sd	a5,-64(s0)
    11a8:	fb843783          	ld	a5,-72(s0)
    11ac:	fcf43423          	sd	a5,-56(s0)
    11b0:	4701                	li	a4,0
    11b2:	fc043703          	ld	a4,-64(s0)
    11b6:	4781                	li	a5,0
    11b8:	fc843783          	ld	a5,-56(s0)
    11bc:	863a                	mv	a2,a4
    11be:	86be                	mv	a3,a5
    11c0:	8732                	mv	a4,a2
    11c2:	87b6                	mv	a5,a3
}
    11c4:	853a                	mv	a0,a4
    11c6:	85be                	mv	a1,a5
    11c8:	6426                	ld	s0,72(sp)
    11ca:	6486                	ld	s1,64(sp)
    11cc:	6161                	addi	sp,sp,80
    11ce:	8082                	ret

00000000000011d0 <find_next_release_time>:

int find_next_release_time(struct list_head *release_queue, int current_time) {
    11d0:	7139                	addi	sp,sp,-64
    11d2:	fc22                	sd	s0,56(sp)
    11d4:	0080                	addi	s0,sp,64
    11d6:	fca43423          	sd	a0,-56(s0)
    11da:	87ae                	mv	a5,a1
    11dc:	fcf42223          	sw	a5,-60(s0)
    struct release_queue_entry *next_release = NULL;
    11e0:	fe043423          	sd	zero,-24(s0)
    int next_release_time = INT_MAX;
    11e4:	800007b7          	lui	a5,0x80000
    11e8:	fff7c793          	not	a5,a5
    11ec:	fef42223          	sw	a5,-28(s0)

    list_for_each_entry(next_release, release_queue, thread_list) {
    11f0:	fc843783          	ld	a5,-56(s0)
    11f4:	639c                	ld	a5,0(a5)
    11f6:	fcf43c23          	sd	a5,-40(s0)
    11fa:	fd843783          	ld	a5,-40(s0)
    11fe:	17e1                	addi	a5,a5,-8
    1200:	fef43423          	sd	a5,-24(s0)
    1204:	a081                	j	1244 <find_next_release_time+0x74>
        if (next_release->release_time > current_time && next_release->release_time < next_release_time) {
    1206:	fe843783          	ld	a5,-24(s0)
    120a:	4f98                	lw	a4,24(a5)
    120c:	fc442783          	lw	a5,-60(s0)
    1210:	2781                	sext.w	a5,a5
    1212:	00e7df63          	bge	a5,a4,1230 <find_next_release_time+0x60>
    1216:	fe843783          	ld	a5,-24(s0)
    121a:	4f98                	lw	a4,24(a5)
    121c:	fe442783          	lw	a5,-28(s0)
    1220:	2781                	sext.w	a5,a5
    1222:	00f75763          	bge	a4,a5,1230 <find_next_release_time+0x60>
            next_release_time = next_release->release_time;
    1226:	fe843783          	ld	a5,-24(s0)
    122a:	4f9c                	lw	a5,24(a5)
    122c:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(next_release, release_queue, thread_list) {
    1230:	fe843783          	ld	a5,-24(s0)
    1234:	679c                	ld	a5,8(a5)
    1236:	fcf43823          	sd	a5,-48(s0)
    123a:	fd043783          	ld	a5,-48(s0)
    123e:	17e1                	addi	a5,a5,-8
    1240:	fef43423          	sd	a5,-24(s0)
    1244:	fe843783          	ld	a5,-24(s0)
    1248:	07a1                	addi	a5,a5,8
    124a:	fc843703          	ld	a4,-56(s0)
    124e:	faf71ce3          	bne	a4,a5,1206 <find_next_release_time+0x36>
        }
    }

    if (next_release_time == INT_MAX)
    1252:	fe442783          	lw	a5,-28(s0)
    1256:	0007871b          	sext.w	a4,a5
    125a:	800007b7          	lui	a5,0x80000
    125e:	fff7c793          	not	a5,a5
    1262:	00f71463          	bne	a4,a5,126a <find_next_release_time+0x9a>
        return -1; // No threads in the release queue
    1266:	57fd                	li	a5,-1
    1268:	a801                	j	1278 <find_next_release_time+0xa8>

    return next_release_time - current_time;
    126a:	fe442703          	lw	a4,-28(s0)
    126e:	fc442783          	lw	a5,-60(s0)
    1272:	40f707bb          	subw	a5,a4,a5
    1276:	2781                	sext.w	a5,a5
}
    1278:	853e                	mv	a0,a5
    127a:	7462                	ld	s0,56(sp)
    127c:	6121                	addi	sp,sp,64
    127e:	8082                	ret

0000000000001280 <schedule_wrr>:

/* MP3 Part 1 - Non-Real-Time Scheduling */
/* Weighted-Round-Robin Scheduling */
struct threads_sched_result schedule_wrr(struct threads_sched_args args)
{
    1280:	7119                	addi	sp,sp,-128
    1282:	fc86                	sd	ra,120(sp)
    1284:	f8a2                	sd	s0,112(sp)
    1286:	f4a6                	sd	s1,104(sp)
    1288:	f0ca                	sd	s2,96(sp)
    128a:	ecce                	sd	s3,88(sp)
    128c:	0100                	addi	s0,sp,128
    128e:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the weighted round-robin scheduling algorithm
    static struct thread *last_thread = NULL;
    struct thread *selected_thread = NULL;
    1290:	fc043423          	sd	zero,-56(s0)
    struct thread *candidate = NULL;
    1294:	fc043023          	sd	zero,-64(s0)

    // If last_thread is NULL or its remaining time is zero, reset the selection process
    if (last_thread == NULL || last_thread->remaining_time <= 0) {
    1298:	00001797          	auipc	a5,0x1
    129c:	ae878793          	addi	a5,a5,-1304 # 1d80 <last_thread.1239>
    12a0:	639c                	ld	a5,0(a5)
    12a2:	cb89                	beqz	a5,12b4 <schedule_wrr+0x34>
    12a4:	00001797          	auipc	a5,0x1
    12a8:	adc78793          	addi	a5,a5,-1316 # 1d80 <last_thread.1239>
    12ac:	639c                	ld	a5,0(a5)
    12ae:	4fbc                	lw	a5,88(a5)
    12b0:	00f04863          	bgtz	a5,12c0 <schedule_wrr+0x40>
        last_thread = NULL;
    12b4:	00001797          	auipc	a5,0x1
    12b8:	acc78793          	addi	a5,a5,-1332 # 1d80 <last_thread.1239>
    12bc:	0007b023          	sd	zero,0(a5)
    }

    // Find the first thread that is ready to run
    list_for_each_entry(candidate, args.run_queue, thread_list) {
    12c0:	649c                	ld	a5,8(s1)
    12c2:	639c                	ld	a5,0(a5)
    12c4:	faf43823          	sd	a5,-80(s0)
    12c8:	fb043783          	ld	a5,-80(s0)
    12cc:	fd878793          	addi	a5,a5,-40
    12d0:	fcf43023          	sd	a5,-64(s0)
    12d4:	a0a9                	j	131e <schedule_wrr+0x9e>
        if (!last_thread && candidate->remaining_time > 0)
    12d6:	00001797          	auipc	a5,0x1
    12da:	aaa78793          	addi	a5,a5,-1366 # 1d80 <last_thread.1239>
    12de:	639c                	ld	a5,0(a5)
    12e0:	eb91                	bnez	a5,12f4 <schedule_wrr+0x74>
    12e2:	fc043783          	ld	a5,-64(s0)
    12e6:	4fbc                	lw	a5,88(a5)
    12e8:	00f05663          	blez	a5,12f4 <schedule_wrr+0x74>
            selected_thread = candidate;
    12ec:	fc043783          	ld	a5,-64(s0)
    12f0:	fcf43423          	sd	a5,-56(s0)
        if (candidate->remaining_time > 0) {
    12f4:	fc043783          	ld	a5,-64(s0)
    12f8:	4fbc                	lw	a5,88(a5)
    12fa:	00f05763          	blez	a5,1308 <schedule_wrr+0x88>
            selected_thread = candidate;
    12fe:	fc043783          	ld	a5,-64(s0)
    1302:	fcf43423          	sd	a5,-56(s0)
            break;
    1306:	a01d                	j	132c <schedule_wrr+0xac>
    list_for_each_entry(candidate, args.run_queue, thread_list) {
    1308:	fc043783          	ld	a5,-64(s0)
    130c:	779c                	ld	a5,40(a5)
    130e:	faf43423          	sd	a5,-88(s0)
    1312:	fa843783          	ld	a5,-88(s0)
    1316:	fd878793          	addi	a5,a5,-40
    131a:	fcf43023          	sd	a5,-64(s0)
    131e:	fc043783          	ld	a5,-64(s0)
    1322:	02878713          	addi	a4,a5,40
    1326:	649c                	ld	a5,8(s1)
    1328:	faf717e3          	bne	a4,a5,12d6 <schedule_wrr+0x56>
        }
    }

    // Fall back to the last_thread if no other thread is selected and it still has remaining time
    if (!selected_thread && last_thread && last_thread->remaining_time > 0) {
    132c:	fc843783          	ld	a5,-56(s0)
    1330:	e795                	bnez	a5,135c <schedule_wrr+0xdc>
    1332:	00001797          	auipc	a5,0x1
    1336:	a4e78793          	addi	a5,a5,-1458 # 1d80 <last_thread.1239>
    133a:	639c                	ld	a5,0(a5)
    133c:	c385                	beqz	a5,135c <schedule_wrr+0xdc>
    133e:	00001797          	auipc	a5,0x1
    1342:	a4278793          	addi	a5,a5,-1470 # 1d80 <last_thread.1239>
    1346:	639c                	ld	a5,0(a5)
    1348:	4fbc                	lw	a5,88(a5)
    134a:	00f05963          	blez	a5,135c <schedule_wrr+0xdc>
        selected_thread = last_thread;
    134e:	00001797          	auipc	a5,0x1
    1352:	a3278793          	addi	a5,a5,-1486 # 1d80 <last_thread.1239>
    1356:	639c                	ld	a5,0(a5)
    1358:	fcf43423          	sd	a5,-56(s0)
    }

    // Set the scheduling result
    if (selected_thread) {
    135c:	fc843783          	ld	a5,-56(s0)
    1360:	c7b9                	beqz	a5,13ae <schedule_wrr+0x12e>
        int time_slice = selected_thread->weight * TIME_QUANTUM;
    1362:	fc843783          	ld	a5,-56(s0)
    1366:	47bc                	lw	a5,72(a5)
    1368:	0017979b          	slliw	a5,a5,0x1
    136c:	faf42e23          	sw	a5,-68(s0)
        if (time_slice > selected_thread->remaining_time) {
    1370:	fc843783          	ld	a5,-56(s0)
    1374:	4fb8                	lw	a4,88(a5)
    1376:	fbc42783          	lw	a5,-68(s0)
    137a:	2781                	sext.w	a5,a5
    137c:	00f75763          	bge	a4,a5,138a <schedule_wrr+0x10a>
            time_slice = selected_thread->remaining_time;
    1380:	fc843783          	ld	a5,-56(s0)
    1384:	4fbc                	lw	a5,88(a5)
    1386:	faf42e23          	sw	a5,-68(s0)
        }
        r.scheduled_thread_list_member = &selected_thread->thread_list;
    138a:	fc843783          	ld	a5,-56(s0)
    138e:	02878793          	addi	a5,a5,40
    1392:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = time_slice;
    1396:	fbc42783          	lw	a5,-68(s0)
    139a:	f8f42823          	sw	a5,-112(s0)
        last_thread = selected_thread;  // Update the last run thread
    139e:	00001797          	auipc	a5,0x1
    13a2:	9e278793          	addi	a5,a5,-1566 # 1d80 <last_thread.1239>
    13a6:	fc843703          	ld	a4,-56(s0)
    13aa:	e398                	sd	a4,0(a5)
    13ac:	a839                	j	13ca <schedule_wrr+0x14a>
    } else {
        // Idle if no suitable thread is found
        r.scheduled_thread_list_member = args.run_queue;
    13ae:	649c                	ld	a5,8(s1)
    13b0:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    13b4:	689c                	ld	a5,16(s1)
    13b6:	4098                	lw	a4,0(s1)
    13b8:	85ba                	mv	a1,a4
    13ba:	853e                	mv	a0,a5
    13bc:	00000097          	auipc	ra,0x0
    13c0:	e14080e7          	jalr	-492(ra) # 11d0 <find_next_release_time>
    13c4:	87aa                	mv	a5,a0
    13c6:	f8f42823          	sw	a5,-112(s0)
    }

    return r;
    13ca:	f8843783          	ld	a5,-120(s0)
    13ce:	f8f43c23          	sd	a5,-104(s0)
    13d2:	f9043783          	ld	a5,-112(s0)
    13d6:	faf43023          	sd	a5,-96(s0)
    13da:	4701                	li	a4,0
    13dc:	f9843703          	ld	a4,-104(s0)
    13e0:	4781                	li	a5,0
    13e2:	fa043783          	ld	a5,-96(s0)
    13e6:	893a                	mv	s2,a4
    13e8:	89be                	mv	s3,a5
    13ea:	874a                	mv	a4,s2
    13ec:	87ce                	mv	a5,s3
}
    13ee:	853a                	mv	a0,a4
    13f0:	85be                	mv	a1,a5
    13f2:	70e6                	ld	ra,120(sp)
    13f4:	7446                	ld	s0,112(sp)
    13f6:	74a6                	ld	s1,104(sp)
    13f8:	7906                	ld	s2,96(sp)
    13fa:	69e6                	ld	s3,88(sp)
    13fc:	6109                	addi	sp,sp,128
    13fe:	8082                	ret

0000000000001400 <find_earliest_impactful_release_time>:


int find_earliest_impactful_release_time(struct list_head *release_queue, struct list_head *run_queue, int current_time) {
    1400:	7159                	addi	sp,sp,-112
    1402:	f4a2                	sd	s0,104(sp)
    1404:	1880                	addi	s0,sp,112
    1406:	faa43423          	sd	a0,-88(s0)
    140a:	fab43023          	sd	a1,-96(s0)
    140e:	87b2                	mv	a5,a2
    1410:	f8f42e23          	sw	a5,-100(s0)
    struct release_queue_entry *entry;
    int earliest_impactful_time = INT_MAX;
    1414:	800007b7          	lui	a5,0x80000
    1418:	fff7c793          	not	a5,a5
    141c:	fef42223          	sw	a5,-28(s0)
    int shortest_current_time = INT_MAX;
    1420:	800007b7          	lui	a5,0x80000
    1424:	fff7c793          	not	a5,a5
    1428:	fef42023          	sw	a5,-32(s0)
    // Find the shortest remaining time among currently running tasks
    struct thread *t;
    list_for_each_entry(t, run_queue, thread_list) {
    142c:	fa043783          	ld	a5,-96(s0)
    1430:	639c                	ld	a5,0(a5)
    1432:	fcf43823          	sd	a5,-48(s0)
    1436:	fd043783          	ld	a5,-48(s0)
    143a:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffda98>
    143e:	fcf43c23          	sd	a5,-40(s0)
    1442:	a80d                	j	1474 <find_earliest_impactful_release_time+0x74>
        if (t->remaining_time < shortest_current_time) {
    1444:	fd843783          	ld	a5,-40(s0)
    1448:	4fb8                	lw	a4,88(a5)
    144a:	fe042783          	lw	a5,-32(s0)
    144e:	2781                	sext.w	a5,a5
    1450:	00f75763          	bge	a4,a5,145e <find_earliest_impactful_release_time+0x5e>
            shortest_current_time = t->remaining_time;
    1454:	fd843783          	ld	a5,-40(s0)
    1458:	4fbc                	lw	a5,88(a5)
    145a:	fef42023          	sw	a5,-32(s0)
    list_for_each_entry(t, run_queue, thread_list) {
    145e:	fd843783          	ld	a5,-40(s0)
    1462:	779c                	ld	a5,40(a5)
    1464:	faf43c23          	sd	a5,-72(s0)
    1468:	fb843783          	ld	a5,-72(s0)
    146c:	fd878793          	addi	a5,a5,-40
    1470:	fcf43c23          	sd	a5,-40(s0)
    1474:	fd843783          	ld	a5,-40(s0)
    1478:	02878793          	addi	a5,a5,40
    147c:	fa043703          	ld	a4,-96(s0)
    1480:	fcf712e3          	bne	a4,a5,1444 <find_earliest_impactful_release_time+0x44>
        }
    }

    // Check the release queue for the next task that might preempt the current shortest job
    list_for_each_entry(entry, release_queue, thread_list) {
    1484:	fa843783          	ld	a5,-88(s0)
    1488:	639c                	ld	a5,0(a5)
    148a:	fcf43423          	sd	a5,-56(s0)
    148e:	fc843783          	ld	a5,-56(s0)
    1492:	17e1                	addi	a5,a5,-8
    1494:	fef43423          	sd	a5,-24(s0)
    1498:	a889                	j	14ea <find_earliest_impactful_release_time+0xea>
        if (entry->release_time > current_time && entry->release_time < earliest_impactful_time) {
    149a:	fe843783          	ld	a5,-24(s0)
    149e:	4f98                	lw	a4,24(a5)
    14a0:	f9c42783          	lw	a5,-100(s0)
    14a4:	2781                	sext.w	a5,a5
    14a6:	02e7d863          	bge	a5,a4,14d6 <find_earliest_impactful_release_time+0xd6>
    14aa:	fe843783          	ld	a5,-24(s0)
    14ae:	4f98                	lw	a4,24(a5)
    14b0:	fe442783          	lw	a5,-28(s0)
    14b4:	2781                	sext.w	a5,a5
    14b6:	02f75063          	bge	a4,a5,14d6 <find_earliest_impactful_release_time+0xd6>
            if (entry->thrd->remaining_time < shortest_current_time) {
    14ba:	fe843783          	ld	a5,-24(s0)
    14be:	639c                	ld	a5,0(a5)
    14c0:	4fb8                	lw	a4,88(a5)
    14c2:	fe042783          	lw	a5,-32(s0)
    14c6:	2781                	sext.w	a5,a5
    14c8:	00f75763          	bge	a4,a5,14d6 <find_earliest_impactful_release_time+0xd6>
                earliest_impactful_time = entry->release_time;
    14cc:	fe843783          	ld	a5,-24(s0)
    14d0:	4f9c                	lw	a5,24(a5)
    14d2:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(entry, release_queue, thread_list) {
    14d6:	fe843783          	ld	a5,-24(s0)
    14da:	679c                	ld	a5,8(a5)
    14dc:	fcf43023          	sd	a5,-64(s0)
    14e0:	fc043783          	ld	a5,-64(s0)
    14e4:	17e1                	addi	a5,a5,-8
    14e6:	fef43423          	sd	a5,-24(s0)
    14ea:	fe843783          	ld	a5,-24(s0)
    14ee:	07a1                	addi	a5,a5,8
    14f0:	fa843703          	ld	a4,-88(s0)
    14f4:	faf713e3          	bne	a4,a5,149a <find_earliest_impactful_release_time+0x9a>
            }
        }
    }

    // Calculate the difference between the current time and the earliest impactful release time
    return earliest_impactful_time == INT_MAX ? -1 : earliest_impactful_time - current_time;
    14f8:	fe442783          	lw	a5,-28(s0)
    14fc:	0007871b          	sext.w	a4,a5
    1500:	800007b7          	lui	a5,0x80000
    1504:	fff7c793          	not	a5,a5
    1508:	00f70a63          	beq	a4,a5,151c <find_earliest_impactful_release_time+0x11c>
    150c:	fe442703          	lw	a4,-28(s0)
    1510:	f9c42783          	lw	a5,-100(s0)
    1514:	40f707bb          	subw	a5,a4,a5
    1518:	2781                	sext.w	a5,a5
    151a:	a011                	j	151e <find_earliest_impactful_release_time+0x11e>
    151c:	57fd                	li	a5,-1
}
    151e:	853e                	mv	a0,a5
    1520:	7426                	ld	s0,104(sp)
    1522:	6165                	addi	sp,sp,112
    1524:	8082                	ret

0000000000001526 <schedule_sjf>:


struct threads_sched_result schedule_sjf(struct threads_sched_args args) {
    1526:	7119                	addi	sp,sp,-128
    1528:	fc86                	sd	ra,120(sp)
    152a:	f8a2                	sd	s0,112(sp)
    152c:	f4a6                	sd	s1,104(sp)
    152e:	f0ca                	sd	s2,96(sp)
    1530:	ecce                	sd	s3,88(sp)
    1532:	0100                	addi	s0,sp,128
    1534:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *shortest_job = NULL;
    1536:	fc043423          	sd	zero,-56(s0)
    struct thread *current;
    int shortest_time = INT_MAX;
    153a:	800007b7          	lui	a5,0x80000
    153e:	fff7c793          	not	a5,a5
    1542:	faf42e23          	sw	a5,-68(s0)
    int earliest_impactful_time = find_earliest_impactful_release_time(args.release_queue, args.run_queue, args.current_time);
    1546:	689c                	ld	a5,16(s1)
    1548:	6498                	ld	a4,8(s1)
    154a:	4094                	lw	a3,0(s1)
    154c:	8636                	mv	a2,a3
    154e:	85ba                	mv	a1,a4
    1550:	853e                	mv	a0,a5
    1552:	00000097          	auipc	ra,0x0
    1556:	eae080e7          	jalr	-338(ra) # 1400 <find_earliest_impactful_release_time>
    155a:	87aa                	mv	a5,a0
    155c:	faf42a23          	sw	a5,-76(s0)

    // Determine the shortest job from the run queue
    list_for_each_entry(current, args.run_queue, thread_list) {
    1560:	649c                	ld	a5,8(s1)
    1562:	639c                	ld	a5,0(a5)
    1564:	faf43423          	sd	a5,-88(s0)
    1568:	fa843783          	ld	a5,-88(s0)
    156c:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffda98>
    1570:	fcf43023          	sd	a5,-64(s0)
    1574:	a82d                	j	15ae <schedule_sjf+0x88>
        if (current->remaining_time < shortest_time) {
    1576:	fc043783          	ld	a5,-64(s0)
    157a:	4fb8                	lw	a4,88(a5)
    157c:	fbc42783          	lw	a5,-68(s0)
    1580:	2781                	sext.w	a5,a5
    1582:	00f75b63          	bge	a4,a5,1598 <schedule_sjf+0x72>
            shortest_time = current->remaining_time;
    1586:	fc043783          	ld	a5,-64(s0)
    158a:	4fbc                	lw	a5,88(a5)
    158c:	faf42e23          	sw	a5,-68(s0)
            shortest_job = current;
    1590:	fc043783          	ld	a5,-64(s0)
    1594:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(current, args.run_queue, thread_list) {
    1598:	fc043783          	ld	a5,-64(s0)
    159c:	779c                	ld	a5,40(a5)
    159e:	faf43023          	sd	a5,-96(s0)
    15a2:	fa043783          	ld	a5,-96(s0)
    15a6:	fd878793          	addi	a5,a5,-40
    15aa:	fcf43023          	sd	a5,-64(s0)
    15ae:	fc043783          	ld	a5,-64(s0)
    15b2:	02878713          	addi	a4,a5,40
    15b6:	649c                	ld	a5,8(s1)
    15b8:	faf71fe3          	bne	a4,a5,1576 <schedule_sjf+0x50>
        }
    }

    if (shortest_job) {
    15bc:	fc843783          	ld	a5,-56(s0)
    15c0:	c7a1                	beqz	a5,1608 <schedule_sjf+0xe2>
        int time_to_allocate = shortest_job->remaining_time;
    15c2:	fc843783          	ld	a5,-56(s0)
    15c6:	4fbc                	lw	a5,88(a5)
    15c8:	faf42c23          	sw	a5,-72(s0)
        // Reduce the time slice if an impactful task is arriving sooner
        if (earliest_impactful_time != -1 && earliest_impactful_time < time_to_allocate) {
    15cc:	fb442783          	lw	a5,-76(s0)
    15d0:	0007871b          	sext.w	a4,a5
    15d4:	57fd                	li	a5,-1
    15d6:	00f70e63          	beq	a4,a5,15f2 <schedule_sjf+0xcc>
    15da:	fb442703          	lw	a4,-76(s0)
    15de:	fb842783          	lw	a5,-72(s0)
    15e2:	2701                	sext.w	a4,a4
    15e4:	2781                	sext.w	a5,a5
    15e6:	00f75663          	bge	a4,a5,15f2 <schedule_sjf+0xcc>
            time_to_allocate = earliest_impactful_time;
    15ea:	fb442783          	lw	a5,-76(s0)
    15ee:	faf42c23          	sw	a5,-72(s0)
        }

        r.scheduled_thread_list_member = &shortest_job->thread_list;
    15f2:	fc843783          	ld	a5,-56(s0)
    15f6:	02878793          	addi	a5,a5,40
    15fa:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = time_to_allocate;
    15fe:	fb842783          	lw	a5,-72(s0)
    1602:	f8f42423          	sw	a5,-120(s0)
    1606:	a80d                	j	1638 <schedule_sjf+0x112>
    } else {
        // If no current tasks are ready, wait for the next impactful task
        r.scheduled_thread_list_member = args.run_queue;
    1608:	649c                	ld	a5,8(s1)
    160a:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = earliest_impactful_time != -1 ? earliest_impactful_time : find_next_release_time(args.release_queue, args.current_time);
    160e:	fb442783          	lw	a5,-76(s0)
    1612:	0007871b          	sext.w	a4,a5
    1616:	57fd                	li	a5,-1
    1618:	00f71c63          	bne	a4,a5,1630 <schedule_sjf+0x10a>
    161c:	689c                	ld	a5,16(s1)
    161e:	4098                	lw	a4,0(s1)
    1620:	85ba                	mv	a1,a4
    1622:	853e                	mv	a0,a5
    1624:	00000097          	auipc	ra,0x0
    1628:	bac080e7          	jalr	-1108(ra) # 11d0 <find_next_release_time>
    162c:	87aa                	mv	a5,a0
    162e:	a019                	j	1634 <schedule_sjf+0x10e>
    1630:	fb442783          	lw	a5,-76(s0)
    1634:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    1638:	f8043783          	ld	a5,-128(s0)
    163c:	f8f43823          	sd	a5,-112(s0)
    1640:	f8843783          	ld	a5,-120(s0)
    1644:	f8f43c23          	sd	a5,-104(s0)
    1648:	4701                	li	a4,0
    164a:	f9043703          	ld	a4,-112(s0)
    164e:	4781                	li	a5,0
    1650:	f9843783          	ld	a5,-104(s0)
    1654:	893a                	mv	s2,a4
    1656:	89be                	mv	s3,a5
    1658:	874a                	mv	a4,s2
    165a:	87ce                	mv	a5,s3
}
    165c:	853a                	mv	a0,a4
    165e:	85be                	mv	a1,a5
    1660:	70e6                	ld	ra,120(sp)
    1662:	7446                	ld	s0,112(sp)
    1664:	74a6                	ld	s1,104(sp)
    1666:	7906                	ld	s2,96(sp)
    1668:	69e6                	ld	s3,88(sp)
    166a:	6109                	addi	sp,sp,128
    166c:	8082                	ret

000000000000166e <min>:

int min(int a, int b) {
    166e:	1101                	addi	sp,sp,-32
    1670:	ec22                	sd	s0,24(sp)
    1672:	1000                	addi	s0,sp,32
    1674:	87aa                	mv	a5,a0
    1676:	872e                	mv	a4,a1
    1678:	fef42623          	sw	a5,-20(s0)
    167c:	87ba                	mv	a5,a4
    167e:	fef42423          	sw	a5,-24(s0)
    return (a < b) ? a : b;
    1682:	fec42603          	lw	a2,-20(s0)
    1686:	fe842783          	lw	a5,-24(s0)
    168a:	0007869b          	sext.w	a3,a5
    168e:	0006071b          	sext.w	a4,a2
    1692:	00d75363          	bge	a4,a3,1698 <min+0x2a>
    1696:	87b2                	mv	a5,a2
    1698:	2781                	sext.w	a5,a5
}
    169a:	853e                	mv	a0,a5
    169c:	6462                	ld	s0,24(sp)
    169e:	6105                	addi	sp,sp,32
    16a0:	8082                	ret

00000000000016a2 <schedule_lst>:

/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args) {
    16a2:	7131                	addi	sp,sp,-192
    16a4:	fd06                	sd	ra,184(sp)
    16a6:	f922                	sd	s0,176(sp)
    16a8:	f526                	sd	s1,168(sp)
    16aa:	f14a                	sd	s2,160(sp)
    16ac:	ed4e                	sd	s3,152(sp)
    16ae:	0180                	addi	s0,sp,192
    16b0:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *min_slack_thread = NULL;
    16b2:	fc043423          	sd	zero,-56(s0)
    int min_slack_time = INT_MAX;
    16b6:	800007b7          	lui	a5,0x80000
    16ba:	fff7c793          	not	a5,a5
    16be:	fcf42223          	sw	a5,-60(s0)
    struct thread *t;
    // int ddl;
    // Determine the thread with the minimum slack time
    list_for_each_entry(t, args.run_queue, thread_list) {
    16c2:	649c                	ld	a5,8(s1)
    16c4:	639c                	ld	a5,0(a5)
    16c6:	faf43023          	sd	a5,-96(s0)
    16ca:	fa043783          	ld	a5,-96(s0)
    16ce:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffda98>
    16d2:	faf43c23          	sd	a5,-72(s0)
    16d6:	a069                	j	1760 <schedule_lst+0xbe>
        int slack_time = t->current_deadline - args.current_time - t->remaining_time;
    16d8:	fb843783          	ld	a5,-72(s0)
    16dc:	4ff8                	lw	a4,92(a5)
    16de:	409c                	lw	a5,0(s1)
    16e0:	40f707bb          	subw	a5,a4,a5
    16e4:	0007871b          	sext.w	a4,a5
    16e8:	fb843783          	ld	a5,-72(s0)
    16ec:	4fbc                	lw	a5,88(a5)
    16ee:	40f707bb          	subw	a5,a4,a5
    16f2:	f6f42a23          	sw	a5,-140(s0)
        if (slack_time < min_slack_time || (slack_time == min_slack_time && t->ID < (min_slack_thread ? min_slack_thread->ID : INT_MAX))) {
    16f6:	f7442703          	lw	a4,-140(s0)
    16fa:	fc442783          	lw	a5,-60(s0)
    16fe:	2701                	sext.w	a4,a4
    1700:	2781                	sext.w	a5,a5
    1702:	02f74c63          	blt	a4,a5,173a <schedule_lst+0x98>
    1706:	f7442703          	lw	a4,-140(s0)
    170a:	fc442783          	lw	a5,-60(s0)
    170e:	2701                	sext.w	a4,a4
    1710:	2781                	sext.w	a5,a5
    1712:	02f71c63          	bne	a4,a5,174a <schedule_lst+0xa8>
    1716:	fb843783          	ld	a5,-72(s0)
    171a:	5fd4                	lw	a3,60(a5)
    171c:	fc843783          	ld	a5,-56(s0)
    1720:	c789                	beqz	a5,172a <schedule_lst+0x88>
    1722:	fc843783          	ld	a5,-56(s0)
    1726:	5fdc                	lw	a5,60(a5)
    1728:	a029                	j	1732 <schedule_lst+0x90>
    172a:	800007b7          	lui	a5,0x80000
    172e:	fff7c793          	not	a5,a5
    1732:	873e                	mv	a4,a5
    1734:	87b6                	mv	a5,a3
    1736:	00e7da63          	bge	a5,a4,174a <schedule_lst+0xa8>
            min_slack_thread = t;
    173a:	fb843783          	ld	a5,-72(s0)
    173e:	fcf43423          	sd	a5,-56(s0)
            min_slack_time = slack_time;
    1742:	f7442783          	lw	a5,-140(s0)
    1746:	fcf42223          	sw	a5,-60(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    174a:	fb843783          	ld	a5,-72(s0)
    174e:	779c                	ld	a5,40(a5)
    1750:	f6f43423          	sd	a5,-152(s0)
    1754:	f6843783          	ld	a5,-152(s0)
    1758:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffda98>
    175c:	faf43c23          	sd	a5,-72(s0)
    1760:	fb843783          	ld	a5,-72(s0)
    1764:	02878713          	addi	a4,a5,40
    1768:	649c                	ld	a5,8(s1)
    176a:	f6f717e3          	bne	a4,a5,16d8 <schedule_lst+0x36>
        }
    }

    // Calculate the next event time, initially very large
    int next_significant_event_time = INT_MAX;
    176e:	800007b7          	lui	a5,0x80000
    1772:	fff7c793          	not	a5,a5
    1776:	faf42a23          	sw	a5,-76(s0)

    // Analyze each upcoming release to determine if and when they should preempt the current thread
    struct release_queue_entry *entry;
    list_for_each_entry(entry, args.release_queue, thread_list) {
    177a:	689c                	ld	a5,16(s1)
    177c:	639c                	ld	a5,0(a5)
    177e:	f8f43c23          	sd	a5,-104(s0)
    1782:	f9843783          	ld	a5,-104(s0)
    1786:	17e1                	addi	a5,a5,-8
    1788:	faf43423          	sd	a5,-88(s0)
    178c:	a0f1                	j	1858 <schedule_lst+0x1b6>
        if (entry->release_time > args.current_time) {
    178e:	fa843783          	ld	a5,-88(s0)
    1792:	4f98                	lw	a4,24(a5)
    1794:	409c                	lw	a5,0(s1)
    1796:	0ae7d763          	bge	a5,a4,1844 <schedule_lst+0x1a2>
            struct thread *upcoming_thread = entry->thrd;
    179a:	fa843783          	ld	a5,-88(s0)
    179e:	639c                	ld	a5,0(a5)
    17a0:	f8f43423          	sd	a5,-120(s0)
            int upcoming_slack_time = upcoming_thread->current_deadline - entry->release_time - upcoming_thread->remaining_time;
    17a4:	f8843783          	ld	a5,-120(s0)
    17a8:	4ff8                	lw	a4,92(a5)
    17aa:	fa843783          	ld	a5,-88(s0)
    17ae:	4f9c                	lw	a5,24(a5)
    17b0:	40f707bb          	subw	a5,a4,a5
    17b4:	0007871b          	sext.w	a4,a5
    17b8:	f8843783          	ld	a5,-120(s0)
    17bc:	4fbc                	lw	a5,88(a5)
    17be:	40f707bb          	subw	a5,a4,a5
    17c2:	f8f42223          	sw	a5,-124(s0)
            // Check if this upcoming thread will impose an earlier preemption due to tighter slack time
            if (upcoming_slack_time < min_slack_time) {
    17c6:	f8442703          	lw	a4,-124(s0)
    17ca:	fc442783          	lw	a5,-60(s0)
    17ce:	2701                	sext.w	a4,a4
    17d0:	2781                	sext.w	a5,a5
    17d2:	02f75163          	bge	a4,a5,17f4 <schedule_lst+0x152>
                next_significant_event_time = min(next_significant_event_time, entry->release_time);
    17d6:	fa843783          	ld	a5,-88(s0)
    17da:	4f98                	lw	a4,24(a5)
    17dc:	fb442783          	lw	a5,-76(s0)
    17e0:	85ba                	mv	a1,a4
    17e2:	853e                	mv	a0,a5
    17e4:	00000097          	auipc	ra,0x0
    17e8:	e8a080e7          	jalr	-374(ra) # 166e <min>
    17ec:	87aa                	mv	a5,a0
    17ee:	faf42a23          	sw	a5,-76(s0)
    17f2:	a889                	j	1844 <schedule_lst+0x1a2>
            } else if (upcoming_slack_time == min_slack_time && upcoming_thread->ID < (min_slack_thread ? min_slack_thread->ID : INT_MAX))
    17f4:	f8442703          	lw	a4,-124(s0)
    17f8:	fc442783          	lw	a5,-60(s0)
    17fc:	2701                	sext.w	a4,a4
    17fe:	2781                	sext.w	a5,a5
    1800:	04f71263          	bne	a4,a5,1844 <schedule_lst+0x1a2>
    1804:	f8843783          	ld	a5,-120(s0)
    1808:	5fd4                	lw	a3,60(a5)
    180a:	fc843783          	ld	a5,-56(s0)
    180e:	c789                	beqz	a5,1818 <schedule_lst+0x176>
    1810:	fc843783          	ld	a5,-56(s0)
    1814:	5fdc                	lw	a5,60(a5)
    1816:	a029                	j	1820 <schedule_lst+0x17e>
    1818:	800007b7          	lui	a5,0x80000
    181c:	fff7c793          	not	a5,a5
    1820:	873e                	mv	a4,a5
    1822:	87b6                	mv	a5,a3
    1824:	02e7d063          	bge	a5,a4,1844 <schedule_lst+0x1a2>
                next_significant_event_time = min(next_significant_event_time, entry->release_time);
    1828:	fa843783          	ld	a5,-88(s0)
    182c:	4f98                	lw	a4,24(a5)
    182e:	fb442783          	lw	a5,-76(s0)
    1832:	85ba                	mv	a1,a4
    1834:	853e                	mv	a0,a5
    1836:	00000097          	auipc	ra,0x0
    183a:	e38080e7          	jalr	-456(ra) # 166e <min>
    183e:	87aa                	mv	a5,a0
    1840:	faf42a23          	sw	a5,-76(s0)
    list_for_each_entry(entry, args.release_queue, thread_list) {
    1844:	fa843783          	ld	a5,-88(s0)
    1848:	679c                	ld	a5,8(a5)
    184a:	f6f43c23          	sd	a5,-136(s0)
    184e:	f7843783          	ld	a5,-136(s0)
    1852:	17e1                	addi	a5,a5,-8
    1854:	faf43423          	sd	a5,-88(s0)
    1858:	fa843783          	ld	a5,-88(s0)
    185c:	00878713          	addi	a4,a5,8 # ffffffff80000008 <__global_pointer$+0xffffffff7fffdac8>
    1860:	689c                	ld	a5,16(s1)
    1862:	f2f716e3          	bne	a4,a5,178e <schedule_lst+0xec>
        }
    }

    // Decide the allocated time based on current minimum slack or upcoming preemption needs
    if (min_slack_thread) {
    1866:	fc843783          	ld	a5,-56(s0)
    186a:	c7b5                	beqz	a5,18d6 <schedule_lst+0x234>
        // Check if the thread has missed its deadline
        if (args.current_time >= min_slack_thread->current_deadline && min_slack_thread->remaining_time > 0) {
    186c:	4098                	lw	a4,0(s1)
    186e:	fc843783          	ld	a5,-56(s0)
    1872:	4ffc                	lw	a5,92(a5)
    1874:	02f74063          	blt	a4,a5,1894 <schedule_lst+0x1f2>
    1878:	fc843783          	ld	a5,-56(s0)
    187c:	4fbc                	lw	a5,88(a5)
    187e:	00f05b63          	blez	a5,1894 <schedule_lst+0x1f2>
            r.scheduled_thread_list_member = &min_slack_thread->thread_list;
    1882:	fc843783          	ld	a5,-56(s0)
    1886:	02878793          	addi	a5,a5,40
    188a:	f4f43423          	sd	a5,-184(s0)
            r.allocated_time = 0;  // Set to 0 to handle missed deadline
    188e:	f4042823          	sw	zero,-176(s0)
    1892:	a049                	j	1914 <schedule_lst+0x272>
        } else {
            // Decide the allocated time based on current minimum slack or upcoming preemption needs
            int allocated_time = (next_significant_event_time == INT_MAX) ? min_slack_thread->remaining_time : next_significant_event_time - args.current_time;
    1894:	fb442783          	lw	a5,-76(s0)
    1898:	0007871b          	sext.w	a4,a5
    189c:	800007b7          	lui	a5,0x80000
    18a0:	fff7c793          	not	a5,a5
    18a4:	00f71663          	bne	a4,a5,18b0 <schedule_lst+0x20e>
    18a8:	fc843783          	ld	a5,-56(s0)
    18ac:	4fbc                	lw	a5,88(a5)
    18ae:	a039                	j	18bc <schedule_lst+0x21a>
    18b0:	409c                	lw	a5,0(s1)
    18b2:	fb442703          	lw	a4,-76(s0)
    18b6:	40f707bb          	subw	a5,a4,a5
    18ba:	2781                	sext.w	a5,a5
    18bc:	f8f42a23          	sw	a5,-108(s0)
            r.scheduled_thread_list_member = &min_slack_thread->thread_list;
    18c0:	fc843783          	ld	a5,-56(s0)
    18c4:	02878793          	addi	a5,a5,40 # ffffffff80000028 <__global_pointer$+0xffffffff7fffdae8>
    18c8:	f4f43423          	sd	a5,-184(s0)
            r.allocated_time = allocated_time;
    18cc:	f9442783          	lw	a5,-108(s0)
    18d0:	f4f42823          	sw	a5,-176(s0)
    18d4:	a081                	j	1914 <schedule_lst+0x272>
        }
    } else {
        // No runnable threads, prepare to sleep or wait based on next known event
        r.scheduled_thread_list_member = args.run_queue;
    18d6:	649c                	ld	a5,8(s1)
    18d8:	f4f43423          	sd	a5,-184(s0)
        r.allocated_time = next_significant_event_time != INT_MAX ? next_significant_event_time - args.current_time : find_next_release_time(args.release_queue, args.current_time);
    18dc:	fb442783          	lw	a5,-76(s0)
    18e0:	0007871b          	sext.w	a4,a5
    18e4:	800007b7          	lui	a5,0x80000
    18e8:	fff7c793          	not	a5,a5
    18ec:	00f70963          	beq	a4,a5,18fe <schedule_lst+0x25c>
    18f0:	409c                	lw	a5,0(s1)
    18f2:	fb442703          	lw	a4,-76(s0)
    18f6:	40f707bb          	subw	a5,a4,a5
    18fa:	2781                	sext.w	a5,a5
    18fc:	a811                	j	1910 <schedule_lst+0x26e>
    18fe:	689c                	ld	a5,16(s1)
    1900:	4098                	lw	a4,0(s1)
    1902:	85ba                	mv	a1,a4
    1904:	853e                	mv	a0,a5
    1906:	00000097          	auipc	ra,0x0
    190a:	8ca080e7          	jalr	-1846(ra) # 11d0 <find_next_release_time>
    190e:	87aa                	mv	a5,a0
    1910:	f4f42823          	sw	a5,-176(s0)
    }

    return r;
    1914:	f4843783          	ld	a5,-184(s0)
    1918:	f4f43c23          	sd	a5,-168(s0)
    191c:	f5043783          	ld	a5,-176(s0)
    1920:	f6f43023          	sd	a5,-160(s0)
    1924:	4701                	li	a4,0
    1926:	f5843703          	ld	a4,-168(s0)
    192a:	4781                	li	a5,0
    192c:	f6043783          	ld	a5,-160(s0)
    1930:	893a                	mv	s2,a4
    1932:	89be                	mv	s3,a5
    1934:	874a                	mv	a4,s2
    1936:	87ce                	mv	a5,s3
}
    1938:	853a                	mv	a0,a4
    193a:	85be                	mv	a1,a5
    193c:	70ea                	ld	ra,184(sp)
    193e:	744a                	ld	s0,176(sp)
    1940:	74aa                	ld	s1,168(sp)
    1942:	790a                	ld	s2,160(sp)
    1944:	69ea                	ld	s3,152(sp)
    1946:	6129                	addi	sp,sp,192
    1948:	8082                	ret

000000000000194a <find_earliest_impactful_release_time_dm>:
typedef struct {
    int earliest_impactful_event;
    struct thread *thread;
} ImpactfulEvent;

ImpactfulEvent find_earliest_impactful_release_time_dm(struct list_head *release_queue, struct list_head*run_queue, int current_time, int current_period) {
    194a:	7119                	addi	sp,sp,-128
    194c:	fca2                	sd	s0,120(sp)
    194e:	0100                	addi	s0,sp,128
    1950:	f8a43c23          	sd	a0,-104(s0)
    1954:	f8b43823          	sd	a1,-112(s0)
    1958:	87b2                	mv	a5,a2
    195a:	8736                	mv	a4,a3
    195c:	f8f42623          	sw	a5,-116(s0)
    1960:	87ba                	mv	a5,a4
    1962:	f8f42423          	sw	a5,-120(s0)
    struct release_queue_entry *entry;
    struct thread *t;
    int earliest_impactful_event = INT_MAX;
    1966:	800007b7          	lui	a5,0x80000
    196a:	fff7c793          	not	a5,a5
    196e:	fcf42e23          	sw	a5,-36(s0)
    int earliest_impactful_thread_ID = INT_MAX;    
    1972:	800007b7          	lui	a5,0x80000
    1976:	fff7c793          	not	a5,a5
    197a:	fcf42c23          	sw	a5,-40(s0)
    
    // Look for the smallest deadline that is less than the current task's deadline
    list_for_each_entry(entry, release_queue, thread_list) {
    197e:	f9843783          	ld	a5,-104(s0)
    1982:	639c                	ld	a5,0(a5)
    1984:	fcf43823          	sd	a5,-48(s0)
    1988:	fd043783          	ld	a5,-48(s0)
    198c:	17e1                	addi	a5,a5,-8
    198e:	fef43423          	sd	a5,-24(s0)
    1992:	a201                	j	1a92 <find_earliest_impactful_release_time_dm+0x148>
        if (entry->release_time > current_time && entry->thrd->period < current_period) {
    1994:	fe843783          	ld	a5,-24(s0)
    1998:	4f98                	lw	a4,24(a5)
    199a:	f8c42783          	lw	a5,-116(s0)
    199e:	2781                	sext.w	a5,a5
    19a0:	04e7d463          	bge	a5,a4,19e8 <find_earliest_impactful_release_time_dm+0x9e>
    19a4:	fe843783          	ld	a5,-24(s0)
    19a8:	639c                	ld	a5,0(a5)
    19aa:	4bb8                	lw	a4,80(a5)
    19ac:	f8842783          	lw	a5,-120(s0)
    19b0:	2781                	sext.w	a5,a5
    19b2:	02f75b63          	bge	a4,a5,19e8 <find_earliest_impactful_release_time_dm+0x9e>
            if (entry->release_time < earliest_impactful_event) {
    19b6:	fe843783          	ld	a5,-24(s0)
    19ba:	4f98                	lw	a4,24(a5)
    19bc:	fdc42783          	lw	a5,-36(s0)
    19c0:	2781                	sext.w	a5,a5
    19c2:	0af75e63          	bge	a4,a5,1a7e <find_earliest_impactful_release_time_dm+0x134>
                earliest_impactful_event = entry->release_time;
    19c6:	fe843783          	ld	a5,-24(s0)
    19ca:	4f9c                	lw	a5,24(a5)
    19cc:	fcf42e23          	sw	a5,-36(s0)
                t = entry->thrd;
    19d0:	fe843783          	ld	a5,-24(s0)
    19d4:	639c                	ld	a5,0(a5)
    19d6:	fef43023          	sd	a5,-32(s0)
                earliest_impactful_thread_ID = entry->thrd->ID;
    19da:	fe843783          	ld	a5,-24(s0)
    19de:	639c                	ld	a5,0(a5)
    19e0:	5fdc                	lw	a5,60(a5)
    19e2:	fcf42c23          	sw	a5,-40(s0)
            if (entry->release_time < earliest_impactful_event) {
    19e6:	a861                	j	1a7e <find_earliest_impactful_release_time_dm+0x134>
            }
        } 
        // or the smallest deadline that is equal to the current task's deadline but has a smaller ID
        else if (entry->release_time > current_time && entry->thrd->period == current_period) {
    19e8:	fe843783          	ld	a5,-24(s0)
    19ec:	4f98                	lw	a4,24(a5)
    19ee:	f8c42783          	lw	a5,-116(s0)
    19f2:	2781                	sext.w	a5,a5
    19f4:	08e7d563          	bge	a5,a4,1a7e <find_earliest_impactful_release_time_dm+0x134>
    19f8:	fe843783          	ld	a5,-24(s0)
    19fc:	639c                	ld	a5,0(a5)
    19fe:	4bb8                	lw	a4,80(a5)
    1a00:	f8842783          	lw	a5,-120(s0)
    1a04:	2781                	sext.w	a5,a5
    1a06:	06e79c63          	bne	a5,a4,1a7e <find_earliest_impactful_release_time_dm+0x134>
            
            //printf("ID %d, entry release time: %d\n", entry->thrd->ID, entry->release_time);
            if (entry->release_time < earliest_impactful_event) {
    1a0a:	fe843783          	ld	a5,-24(s0)
    1a0e:	4f98                	lw	a4,24(a5)
    1a10:	fdc42783          	lw	a5,-36(s0)
    1a14:	2781                	sext.w	a5,a5
    1a16:	02f75363          	bge	a4,a5,1a3c <find_earliest_impactful_release_time_dm+0xf2>
                earliest_impactful_event = entry->release_time;
    1a1a:	fe843783          	ld	a5,-24(s0)
    1a1e:	4f9c                	lw	a5,24(a5)
    1a20:	fcf42e23          	sw	a5,-36(s0)
                t = entry->thrd;
    1a24:	fe843783          	ld	a5,-24(s0)
    1a28:	639c                	ld	a5,0(a5)
    1a2a:	fef43023          	sd	a5,-32(s0)
                earliest_impactful_thread_ID = entry->thrd->ID;
    1a2e:	fe843783          	ld	a5,-24(s0)
    1a32:	639c                	ld	a5,0(a5)
    1a34:	5fdc                	lw	a5,60(a5)
    1a36:	fcf42c23          	sw	a5,-40(s0)
    1a3a:	a091                	j	1a7e <find_earliest_impactful_release_time_dm+0x134>
            } else if (entry->release_time == earliest_impactful_event && entry->thrd->ID < earliest_impactful_thread_ID) {
    1a3c:	fe843783          	ld	a5,-24(s0)
    1a40:	4f98                	lw	a4,24(a5)
    1a42:	fdc42783          	lw	a5,-36(s0)
    1a46:	2781                	sext.w	a5,a5
    1a48:	02e79b63          	bne	a5,a4,1a7e <find_earliest_impactful_release_time_dm+0x134>
    1a4c:	fe843783          	ld	a5,-24(s0)
    1a50:	639c                	ld	a5,0(a5)
    1a52:	5fd8                	lw	a4,60(a5)
    1a54:	fd842783          	lw	a5,-40(s0)
    1a58:	2781                	sext.w	a5,a5
    1a5a:	02f75263          	bge	a4,a5,1a7e <find_earliest_impactful_release_time_dm+0x134>
                earliest_impactful_event = entry->release_time;
    1a5e:	fe843783          	ld	a5,-24(s0)
    1a62:	4f9c                	lw	a5,24(a5)
    1a64:	fcf42e23          	sw	a5,-36(s0)
                t = entry->thrd;
    1a68:	fe843783          	ld	a5,-24(s0)
    1a6c:	639c                	ld	a5,0(a5)
    1a6e:	fef43023          	sd	a5,-32(s0)
                earliest_impactful_thread_ID = entry->thrd->ID;
    1a72:	fe843783          	ld	a5,-24(s0)
    1a76:	639c                	ld	a5,0(a5)
    1a78:	5fdc                	lw	a5,60(a5)
    1a7a:	fcf42c23          	sw	a5,-40(s0)
    list_for_each_entry(entry, release_queue, thread_list) {
    1a7e:	fe843783          	ld	a5,-24(s0)
    1a82:	679c                	ld	a5,8(a5)
    1a84:	fcf43423          	sd	a5,-56(s0)
    1a88:	fc843783          	ld	a5,-56(s0)
    1a8c:	17e1                	addi	a5,a5,-8
    1a8e:	fef43423          	sd	a5,-24(s0)
    1a92:	fe843783          	ld	a5,-24(s0)
    1a96:	07a1                	addi	a5,a5,8
    1a98:	f9843703          	ld	a4,-104(s0)
    1a9c:	eef71ce3          	bne	a4,a5,1994 <find_earliest_impactful_release_time_dm+0x4a>
            }
        }
    }
    //printf("earliest_impactful_event: %d\n", earliest_impactful_event);
    // If a task is found that might preempt the current task, determine when it will happen
    earliest_impactful_event = earliest_impactful_event == INT_MAX ? -1 : earliest_impactful_event;
    1aa0:	fdc42783          	lw	a5,-36(s0)
    1aa4:	0007871b          	sext.w	a4,a5
    1aa8:	800007b7          	lui	a5,0x80000
    1aac:	fff7c793          	not	a5,a5
    1ab0:	00f70563          	beq	a4,a5,1aba <find_earliest_impactful_release_time_dm+0x170>
    1ab4:	fdc42783          	lw	a5,-36(s0)
    1ab8:	a011                	j	1abc <find_earliest_impactful_release_time_dm+0x172>
    1aba:	57fd                	li	a5,-1
    1abc:	fcf42e23          	sw	a5,-36(s0)
    return (ImpactfulEvent) {earliest_impactful_event, t};
    1ac0:	fdc42783          	lw	a5,-36(s0)
    1ac4:	faf42c23          	sw	a5,-72(s0)
    1ac8:	fe043783          	ld	a5,-32(s0)
    1acc:	fcf43023          	sd	a5,-64(s0)
    1ad0:	4701                	li	a4,0
    1ad2:	fb843703          	ld	a4,-72(s0)
    1ad6:	4781                	li	a5,0
    1ad8:	fc043783          	ld	a5,-64(s0)
    1adc:	883a                	mv	a6,a4
    1ade:	88be                	mv	a7,a5
    1ae0:	8742                	mv	a4,a6
    1ae2:	87c6                	mv	a5,a7
}
    1ae4:	853a                	mv	a0,a4
    1ae6:	85be                	mv	a1,a5
    1ae8:	7466                	ld	s0,120(sp)
    1aea:	6109                	addi	sp,sp,128
    1aec:	8082                	ret

0000000000001aee <schedule_dm>:


struct threads_sched_result schedule_dm(struct threads_sched_args args) {
    1aee:	7175                	addi	sp,sp,-144
    1af0:	e506                	sd	ra,136(sp)
    1af2:	e122                	sd	s0,128(sp)
    1af4:	fca6                	sd	s1,120(sp)
    1af6:	f8ca                	sd	s2,112(sp)
    1af8:	f4ce                	sd	s3,104(sp)
    1afa:	0900                	addi	s0,sp,144
    1afc:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *earliest_deadline_thread = NULL;
    1afe:	fc043423          	sd	zero,-56(s0)
    struct thread *t;
    int earliest_deadline = INT_MAX;
    1b02:	800007b7          	lui	a5,0x80000
    1b06:	fff7c793          	not	a5,a5
    1b0a:	faf42e23          	sw	a5,-68(s0)
    int earliest_impactful_deadline; 
    
    // Determine the earliest deadline among current tasks
    list_for_each_entry(t, args.run_queue, thread_list) {
    1b0e:	649c                	ld	a5,8(s1)
    1b10:	639c                	ld	a5,0(a5)
    1b12:	faf43823          	sd	a5,-80(s0)
    1b16:	fb043783          	ld	a5,-80(s0)
    1b1a:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffda98>
    1b1e:	fcf43023          	sd	a5,-64(s0)
    1b22:	a8bd                	j	1ba0 <schedule_dm+0xb2>
        if (t->is_real_time && t->period < earliest_deadline) {
    1b24:	fc043783          	ld	a5,-64(s0)
    1b28:	43bc                	lw	a5,64(a5)
    1b2a:	c39d                	beqz	a5,1b50 <schedule_dm+0x62>
    1b2c:	fc043783          	ld	a5,-64(s0)
    1b30:	4bb8                	lw	a4,80(a5)
    1b32:	fbc42783          	lw	a5,-68(s0)
    1b36:	2781                	sext.w	a5,a5
    1b38:	00f75c63          	bge	a4,a5,1b50 <schedule_dm+0x62>
            earliest_deadline_thread = t;
    1b3c:	fc043783          	ld	a5,-64(s0)
    1b40:	fcf43423          	sd	a5,-56(s0)
            earliest_deadline = t->period;
    1b44:	fc043783          	ld	a5,-64(s0)
    1b48:	4bbc                	lw	a5,80(a5)
    1b4a:	faf42e23          	sw	a5,-68(s0)
    1b4e:	a835                	j	1b8a <schedule_dm+0x9c>
        } else if (t->is_real_time && t->period == earliest_deadline && t->ID < earliest_deadline_thread->ID) {
    1b50:	fc043783          	ld	a5,-64(s0)
    1b54:	43bc                	lw	a5,64(a5)
    1b56:	cb95                	beqz	a5,1b8a <schedule_dm+0x9c>
    1b58:	fc043783          	ld	a5,-64(s0)
    1b5c:	4bb8                	lw	a4,80(a5)
    1b5e:	fbc42783          	lw	a5,-68(s0)
    1b62:	2781                	sext.w	a5,a5
    1b64:	02e79363          	bne	a5,a4,1b8a <schedule_dm+0x9c>
    1b68:	fc043783          	ld	a5,-64(s0)
    1b6c:	5fd8                	lw	a4,60(a5)
    1b6e:	fc843783          	ld	a5,-56(s0)
    1b72:	5fdc                	lw	a5,60(a5)
    1b74:	00f75b63          	bge	a4,a5,1b8a <schedule_dm+0x9c>
            earliest_deadline_thread = t;
    1b78:	fc043783          	ld	a5,-64(s0)
    1b7c:	fcf43423          	sd	a5,-56(s0)
            earliest_deadline = t->period;
    1b80:	fc043783          	ld	a5,-64(s0)
    1b84:	4bbc                	lw	a5,80(a5)
    1b86:	faf42e23          	sw	a5,-68(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    1b8a:	fc043783          	ld	a5,-64(s0)
    1b8e:	779c                	ld	a5,40(a5)
    1b90:	faf43023          	sd	a5,-96(s0)
    1b94:	fa043783          	ld	a5,-96(s0)
    1b98:	fd878793          	addi	a5,a5,-40
    1b9c:	fcf43023          	sd	a5,-64(s0)
    1ba0:	fc043783          	ld	a5,-64(s0)
    1ba4:	02878713          	addi	a4,a5,40
    1ba8:	649c                	ld	a5,8(s1)
    1baa:	f6f71de3          	bne	a4,a5,1b24 <schedule_dm+0x36>
        }
    }

    // Find the earliest impactful deadline from other tasks
    ImpactfulEvent earliest_impactful_event = find_earliest_impactful_release_time_dm(args.release_queue, args.run_queue, args.current_time, earliest_deadline_thread ? earliest_deadline_thread->period : INT_MAX);
    1bae:	6898                	ld	a4,16(s1)
    1bb0:	648c                	ld	a1,8(s1)
    1bb2:	4090                	lw	a2,0(s1)
    1bb4:	fc843783          	ld	a5,-56(s0)
    1bb8:	c789                	beqz	a5,1bc2 <schedule_dm+0xd4>
    1bba:	fc843783          	ld	a5,-56(s0)
    1bbe:	4bbc                	lw	a5,80(a5)
    1bc0:	a029                	j	1bca <schedule_dm+0xdc>
    1bc2:	800007b7          	lui	a5,0x80000
    1bc6:	fff7c793          	not	a5,a5
    1bca:	86be                	mv	a3,a5
    1bcc:	853a                	mv	a0,a4
    1bce:	00000097          	auipc	ra,0x0
    1bd2:	d7c080e7          	jalr	-644(ra) # 194a <find_earliest_impactful_release_time_dm>
    1bd6:	872a                	mv	a4,a0
    1bd8:	87ae                	mv	a5,a1
    1bda:	f6e43823          	sd	a4,-144(s0)
    1bde:	f6f43c23          	sd	a5,-136(s0)
    earliest_impactful_deadline = earliest_impactful_event.earliest_impactful_event;
    1be2:	f7042783          	lw	a5,-144(s0)
    1be6:	faf42623          	sw	a5,-84(s0)

    if (earliest_deadline_thread) {
    1bea:	fc843783          	ld	a5,-56(s0)
    1bee:	c3d1                	beqz	a5,1c72 <schedule_dm+0x184>
        int time_to_deadline = earliest_deadline_thread->current_deadline - args.current_time;
    1bf0:	fc843783          	ld	a5,-56(s0)
    1bf4:	4ff8                	lw	a4,92(a5)
    1bf6:	409c                	lw	a5,0(s1)
    1bf8:	40f707bb          	subw	a5,a4,a5
    1bfc:	faf42423          	sw	a5,-88(s0)
        
        // If the thread is already past its deadline, allocate no time (handle deadline miss)
        if (time_to_deadline <= 0) {
    1c00:	fa842783          	lw	a5,-88(s0)
    1c04:	2781                	sext.w	a5,a5
    1c06:	00f04b63          	bgtz	a5,1c1c <schedule_dm+0x12e>
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    1c0a:	fc843783          	ld	a5,-56(s0)
    1c0e:	02878793          	addi	a5,a5,40 # ffffffff80000028 <__global_pointer$+0xffffffff7fffdae8>
    1c12:	f8f43023          	sd	a5,-128(s0)
            r.allocated_time = 0;
    1c16:	f8042423          	sw	zero,-120(s0)
    1c1a:	a895                	j	1c8e <schedule_dm+0x1a0>
        } else {
            // Allocate time based on the smallest of the task's remaining time or the next impactful deadline
            int allocated_time;
            if (earliest_impactful_deadline != -1 && (earliest_impactful_deadline - args.current_time) < earliest_deadline_thread->remaining_time){
    1c1c:	fac42783          	lw	a5,-84(s0)
    1c20:	0007871b          	sext.w	a4,a5
    1c24:	57fd                	li	a5,-1
    1c26:	02f70663          	beq	a4,a5,1c52 <schedule_dm+0x164>
    1c2a:	409c                	lw	a5,0(s1)
    1c2c:	fac42703          	lw	a4,-84(s0)
    1c30:	40f707bb          	subw	a5,a4,a5
    1c34:	0007871b          	sext.w	a4,a5
    1c38:	fc843783          	ld	a5,-56(s0)
    1c3c:	4fbc                	lw	a5,88(a5)
    1c3e:	00f75a63          	bge	a4,a5,1c52 <schedule_dm+0x164>
                allocated_time = earliest_impactful_deadline - args.current_time;
    1c42:	409c                	lw	a5,0(s1)
    1c44:	fac42703          	lw	a4,-84(s0)
    1c48:	40f707bb          	subw	a5,a4,a5
    1c4c:	faf42c23          	sw	a5,-72(s0)
    1c50:	a031                	j	1c5c <schedule_dm+0x16e>
            } else {
                allocated_time = earliest_deadline_thread->remaining_time;
    1c52:	fc843783          	ld	a5,-56(s0)
    1c56:	4fbc                	lw	a5,88(a5)
    1c58:	faf42c23          	sw	a5,-72(s0)
            }
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    1c5c:	fc843783          	ld	a5,-56(s0)
    1c60:	02878793          	addi	a5,a5,40
    1c64:	f8f43023          	sd	a5,-128(s0)
            r.allocated_time = allocated_time;
    1c68:	fb842783          	lw	a5,-72(s0)
    1c6c:	f8f42423          	sw	a5,-120(s0)
    1c70:	a839                	j	1c8e <schedule_dm+0x1a0>
        }
    } else {
        // If no immediate tasks, schedule the next possible task
        r.scheduled_thread_list_member = args.run_queue;
    1c72:	649c                	ld	a5,8(s1)
    1c74:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    1c78:	689c                	ld	a5,16(s1)
    1c7a:	4098                	lw	a4,0(s1)
    1c7c:	85ba                	mv	a1,a4
    1c7e:	853e                	mv	a0,a5
    1c80:	fffff097          	auipc	ra,0xfffff
    1c84:	550080e7          	jalr	1360(ra) # 11d0 <find_next_release_time>
    1c88:	87aa                	mv	a5,a0
    1c8a:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    1c8e:	f8043783          	ld	a5,-128(s0)
    1c92:	f8f43823          	sd	a5,-112(s0)
    1c96:	f8843783          	ld	a5,-120(s0)
    1c9a:	f8f43c23          	sd	a5,-104(s0)
    1c9e:	4701                	li	a4,0
    1ca0:	f9043703          	ld	a4,-112(s0)
    1ca4:	4781                	li	a5,0
    1ca6:	f9843783          	ld	a5,-104(s0)
    1caa:	893a                	mv	s2,a4
    1cac:	89be                	mv	s3,a5
    1cae:	874a                	mv	a4,s2
    1cb0:	87ce                	mv	a5,s3
}
    1cb2:	853a                	mv	a0,a4
    1cb4:	85be                	mv	a1,a5
    1cb6:	60aa                	ld	ra,136(sp)
    1cb8:	640a                	ld	s0,128(sp)
    1cba:	74e6                	ld	s1,120(sp)
    1cbc:	7946                	ld	s2,112(sp)
    1cbe:	79a6                	ld	s3,104(sp)
    1cc0:	6149                	addi	sp,sp,144
    1cc2:	8082                	ret
