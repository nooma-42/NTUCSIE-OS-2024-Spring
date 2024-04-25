
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
       0:	7139                	addi	sp,sp,-64
       2:	fc06                	sd	ra,56(sp)
       4:	f822                	sd	s0,48(sp)
       6:	0080                	addi	s0,sp,64
       8:	fca43423          	sd	a0,-56(s0)
       c:	87ae                	mv	a5,a1
       e:	fcf42223          	sw	a5,-60(s0)
  int n, m;
  char *p, *q;

  m = 0;
      12:	fe042623          	sw	zero,-20(s0)
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
      16:	a8f9                	j	f4 <grep+0xf4>
    m += n;
      18:	fec42703          	lw	a4,-20(s0)
      1c:	fdc42783          	lw	a5,-36(s0)
      20:	9fb9                	addw	a5,a5,a4
      22:	fef42623          	sw	a5,-20(s0)
    buf[m] = '\0';
      26:	00002717          	auipc	a4,0x2
      2a:	8ba70713          	addi	a4,a4,-1862 # 18e0 <buf>
      2e:	fec42783          	lw	a5,-20(s0)
      32:	97ba                	add	a5,a5,a4
      34:	00078023          	sb	zero,0(a5)
    p = buf;
      38:	00002797          	auipc	a5,0x2
      3c:	8a878793          	addi	a5,a5,-1880 # 18e0 <buf>
      40:	fef43023          	sd	a5,-32(s0)
    while((q = strchr(p, '\n')) != 0){
      44:	a891                	j	98 <grep+0x98>
      *q = 0;
      46:	fd043783          	ld	a5,-48(s0)
      4a:	00078023          	sb	zero,0(a5)
      if(match(pattern, p)){
      4e:	fe043583          	ld	a1,-32(s0)
      52:	fc843503          	ld	a0,-56(s0)
      56:	00000097          	auipc	ra,0x0
      5a:	1fa080e7          	jalr	506(ra) # 250 <match>
      5e:	87aa                	mv	a5,a0
      60:	c79d                	beqz	a5,8e <grep+0x8e>
        *q = '\n';
      62:	fd043783          	ld	a5,-48(s0)
      66:	4729                	li	a4,10
      68:	00e78023          	sb	a4,0(a5)
        write(1, p, q+1 - p);
      6c:	fd043783          	ld	a5,-48(s0)
      70:	00178713          	addi	a4,a5,1
      74:	fe043783          	ld	a5,-32(s0)
      78:	40f707b3          	sub	a5,a4,a5
      7c:	2781                	sext.w	a5,a5
      7e:	863e                	mv	a2,a5
      80:	fe043583          	ld	a1,-32(s0)
      84:	4505                	li	a0,1
      86:	00001097          	auipc	ra,0x1
      8a:	842080e7          	jalr	-1982(ra) # 8c8 <write>
      }
      p = q+1;
      8e:	fd043783          	ld	a5,-48(s0)
      92:	0785                	addi	a5,a5,1
      94:	fef43023          	sd	a5,-32(s0)
    while((q = strchr(p, '\n')) != 0){
      98:	45a9                	li	a1,10
      9a:	fe043503          	ld	a0,-32(s0)
      9e:	00000097          	auipc	ra,0x0
      a2:	4c0080e7          	jalr	1216(ra) # 55e <strchr>
      a6:	fca43823          	sd	a0,-48(s0)
      aa:	fd043783          	ld	a5,-48(s0)
      ae:	ffc1                	bnez	a5,46 <grep+0x46>
    }
    if(m > 0){
      b0:	fec42783          	lw	a5,-20(s0)
      b4:	2781                	sext.w	a5,a5
      b6:	02f05f63          	blez	a5,f4 <grep+0xf4>
      m -= p - buf;
      ba:	fec42703          	lw	a4,-20(s0)
      be:	fe043683          	ld	a3,-32(s0)
      c2:	00002797          	auipc	a5,0x2
      c6:	81e78793          	addi	a5,a5,-2018 # 18e0 <buf>
      ca:	40f687b3          	sub	a5,a3,a5
      ce:	2781                	sext.w	a5,a5
      d0:	40f707bb          	subw	a5,a4,a5
      d4:	2781                	sext.w	a5,a5
      d6:	fef42623          	sw	a5,-20(s0)
      memmove(buf, p, m);
      da:	fec42783          	lw	a5,-20(s0)
      de:	863e                	mv	a2,a5
      e0:	fe043583          	ld	a1,-32(s0)
      e4:	00001517          	auipc	a0,0x1
      e8:	7fc50513          	addi	a0,a0,2044 # 18e0 <buf>
      ec:	00000097          	auipc	ra,0x0
      f0:	636080e7          	jalr	1590(ra) # 722 <memmove>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
      f4:	fec42703          	lw	a4,-20(s0)
      f8:	00001797          	auipc	a5,0x1
      fc:	7e878793          	addi	a5,a5,2024 # 18e0 <buf>
     100:	00f706b3          	add	a3,a4,a5
     104:	fec42783          	lw	a5,-20(s0)
     108:	3ff00713          	li	a4,1023
     10c:	40f707bb          	subw	a5,a4,a5
     110:	2781                	sext.w	a5,a5
     112:	0007871b          	sext.w	a4,a5
     116:	fc442783          	lw	a5,-60(s0)
     11a:	863a                	mv	a2,a4
     11c:	85b6                	mv	a1,a3
     11e:	853e                	mv	a0,a5
     120:	00000097          	auipc	ra,0x0
     124:	7a0080e7          	jalr	1952(ra) # 8c0 <read>
     128:	87aa                	mv	a5,a0
     12a:	fcf42e23          	sw	a5,-36(s0)
     12e:	fdc42783          	lw	a5,-36(s0)
     132:	2781                	sext.w	a5,a5
     134:	eef042e3          	bgtz	a5,18 <grep+0x18>
    }
  }
}
     138:	0001                	nop
     13a:	0001                	nop
     13c:	70e2                	ld	ra,56(sp)
     13e:	7442                	ld	s0,48(sp)
     140:	6121                	addi	sp,sp,64
     142:	8082                	ret

0000000000000144 <main>:

int
main(int argc, char *argv[])
{
     144:	7139                	addi	sp,sp,-64
     146:	fc06                	sd	ra,56(sp)
     148:	f822                	sd	s0,48(sp)
     14a:	0080                	addi	s0,sp,64
     14c:	87aa                	mv	a5,a0
     14e:	fcb43023          	sd	a1,-64(s0)
     152:	fcf42623          	sw	a5,-52(s0)
  int fd, i;
  char *pattern;

  if(argc <= 1){
     156:	fcc42783          	lw	a5,-52(s0)
     15a:	0007871b          	sext.w	a4,a5
     15e:	4785                	li	a5,1
     160:	02e7c063          	blt	a5,a4,180 <main+0x3c>
    fprintf(2, "usage: grep pattern [file ...]\n");
     164:	00001597          	auipc	a1,0x1
     168:	72458593          	addi	a1,a1,1828 # 1888 <schedule_dm+0x20a>
     16c:	4509                	li	a0,2
     16e:	00001097          	auipc	ra,0x1
     172:	c28080e7          	jalr	-984(ra) # d96 <fprintf>
    exit(1);
     176:	4505                	li	a0,1
     178:	00000097          	auipc	ra,0x0
     17c:	730080e7          	jalr	1840(ra) # 8a8 <exit>
  }
  pattern = argv[1];
     180:	fc043783          	ld	a5,-64(s0)
     184:	679c                	ld	a5,8(a5)
     186:	fef43023          	sd	a5,-32(s0)

  if(argc <= 2){
     18a:	fcc42783          	lw	a5,-52(s0)
     18e:	0007871b          	sext.w	a4,a5
     192:	4789                	li	a5,2
     194:	00e7ce63          	blt	a5,a4,1b0 <main+0x6c>
    grep(pattern, 0);
     198:	4581                	li	a1,0
     19a:	fe043503          	ld	a0,-32(s0)
     19e:	00000097          	auipc	ra,0x0
     1a2:	e62080e7          	jalr	-414(ra) # 0 <grep>
    exit(0);
     1a6:	4501                	li	a0,0
     1a8:	00000097          	auipc	ra,0x0
     1ac:	700080e7          	jalr	1792(ra) # 8a8 <exit>
  }

  for(i = 2; i < argc; i++){
     1b0:	4789                	li	a5,2
     1b2:	fef42623          	sw	a5,-20(s0)
     1b6:	a041                	j	236 <main+0xf2>
    if((fd = open(argv[i], 0)) < 0){
     1b8:	fec42783          	lw	a5,-20(s0)
     1bc:	078e                	slli	a5,a5,0x3
     1be:	fc043703          	ld	a4,-64(s0)
     1c2:	97ba                	add	a5,a5,a4
     1c4:	639c                	ld	a5,0(a5)
     1c6:	4581                	li	a1,0
     1c8:	853e                	mv	a0,a5
     1ca:	00000097          	auipc	ra,0x0
     1ce:	71e080e7          	jalr	1822(ra) # 8e8 <open>
     1d2:	87aa                	mv	a5,a0
     1d4:	fcf42e23          	sw	a5,-36(s0)
     1d8:	fdc42783          	lw	a5,-36(s0)
     1dc:	2781                	sext.w	a5,a5
     1de:	0207d763          	bgez	a5,20c <main+0xc8>
      printf("grep: cannot open %s\n", argv[i]);
     1e2:	fec42783          	lw	a5,-20(s0)
     1e6:	078e                	slli	a5,a5,0x3
     1e8:	fc043703          	ld	a4,-64(s0)
     1ec:	97ba                	add	a5,a5,a4
     1ee:	639c                	ld	a5,0(a5)
     1f0:	85be                	mv	a1,a5
     1f2:	00001517          	auipc	a0,0x1
     1f6:	6b650513          	addi	a0,a0,1718 # 18a8 <schedule_dm+0x22a>
     1fa:	00001097          	auipc	ra,0x1
     1fe:	bf4080e7          	jalr	-1036(ra) # dee <printf>
      exit(1);
     202:	4505                	li	a0,1
     204:	00000097          	auipc	ra,0x0
     208:	6a4080e7          	jalr	1700(ra) # 8a8 <exit>
    }
    grep(pattern, fd);
     20c:	fdc42783          	lw	a5,-36(s0)
     210:	85be                	mv	a1,a5
     212:	fe043503          	ld	a0,-32(s0)
     216:	00000097          	auipc	ra,0x0
     21a:	dea080e7          	jalr	-534(ra) # 0 <grep>
    close(fd);
     21e:	fdc42783          	lw	a5,-36(s0)
     222:	853e                	mv	a0,a5
     224:	00000097          	auipc	ra,0x0
     228:	6ac080e7          	jalr	1708(ra) # 8d0 <close>
  for(i = 2; i < argc; i++){
     22c:	fec42783          	lw	a5,-20(s0)
     230:	2785                	addiw	a5,a5,1
     232:	fef42623          	sw	a5,-20(s0)
     236:	fec42703          	lw	a4,-20(s0)
     23a:	fcc42783          	lw	a5,-52(s0)
     23e:	2701                	sext.w	a4,a4
     240:	2781                	sext.w	a5,a5
     242:	f6f74be3          	blt	a4,a5,1b8 <main+0x74>
  }
  exit(0);
     246:	4501                	li	a0,0
     248:	00000097          	auipc	ra,0x0
     24c:	660080e7          	jalr	1632(ra) # 8a8 <exit>

0000000000000250 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
     250:	1101                	addi	sp,sp,-32
     252:	ec06                	sd	ra,24(sp)
     254:	e822                	sd	s0,16(sp)
     256:	1000                	addi	s0,sp,32
     258:	fea43423          	sd	a0,-24(s0)
     25c:	feb43023          	sd	a1,-32(s0)
  if(re[0] == '^')
     260:	fe843783          	ld	a5,-24(s0)
     264:	0007c783          	lbu	a5,0(a5)
     268:	873e                	mv	a4,a5
     26a:	05e00793          	li	a5,94
     26e:	00f71e63          	bne	a4,a5,28a <match+0x3a>
    return matchhere(re+1, text);
     272:	fe843783          	ld	a5,-24(s0)
     276:	0785                	addi	a5,a5,1
     278:	fe043583          	ld	a1,-32(s0)
     27c:	853e                	mv	a0,a5
     27e:	00000097          	auipc	ra,0x0
     282:	042080e7          	jalr	66(ra) # 2c0 <matchhere>
     286:	87aa                	mv	a5,a0
     288:	a03d                	j	2b6 <match+0x66>
  do{  // must look at empty string
    if(matchhere(re, text))
     28a:	fe043583          	ld	a1,-32(s0)
     28e:	fe843503          	ld	a0,-24(s0)
     292:	00000097          	auipc	ra,0x0
     296:	02e080e7          	jalr	46(ra) # 2c0 <matchhere>
     29a:	87aa                	mv	a5,a0
     29c:	c399                	beqz	a5,2a2 <match+0x52>
      return 1;
     29e:	4785                	li	a5,1
     2a0:	a819                	j	2b6 <match+0x66>
  }while(*text++ != '\0');
     2a2:	fe043783          	ld	a5,-32(s0)
     2a6:	00178713          	addi	a4,a5,1
     2aa:	fee43023          	sd	a4,-32(s0)
     2ae:	0007c783          	lbu	a5,0(a5)
     2b2:	ffe1                	bnez	a5,28a <match+0x3a>
  return 0;
     2b4:	4781                	li	a5,0
}
     2b6:	853e                	mv	a0,a5
     2b8:	60e2                	ld	ra,24(sp)
     2ba:	6442                	ld	s0,16(sp)
     2bc:	6105                	addi	sp,sp,32
     2be:	8082                	ret

00000000000002c0 <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
     2c0:	1101                	addi	sp,sp,-32
     2c2:	ec06                	sd	ra,24(sp)
     2c4:	e822                	sd	s0,16(sp)
     2c6:	1000                	addi	s0,sp,32
     2c8:	fea43423          	sd	a0,-24(s0)
     2cc:	feb43023          	sd	a1,-32(s0)
  if(re[0] == '\0')
     2d0:	fe843783          	ld	a5,-24(s0)
     2d4:	0007c783          	lbu	a5,0(a5)
     2d8:	e399                	bnez	a5,2de <matchhere+0x1e>
    return 1;
     2da:	4785                	li	a5,1
     2dc:	a0c1                	j	39c <matchhere+0xdc>
  if(re[1] == '*')
     2de:	fe843783          	ld	a5,-24(s0)
     2e2:	0785                	addi	a5,a5,1
     2e4:	0007c783          	lbu	a5,0(a5)
     2e8:	873e                	mv	a4,a5
     2ea:	02a00793          	li	a5,42
     2ee:	02f71563          	bne	a4,a5,318 <matchhere+0x58>
    return matchstar(re[0], re+2, text);
     2f2:	fe843783          	ld	a5,-24(s0)
     2f6:	0007c783          	lbu	a5,0(a5)
     2fa:	0007871b          	sext.w	a4,a5
     2fe:	fe843783          	ld	a5,-24(s0)
     302:	0789                	addi	a5,a5,2
     304:	fe043603          	ld	a2,-32(s0)
     308:	85be                	mv	a1,a5
     30a:	853a                	mv	a0,a4
     30c:	00000097          	auipc	ra,0x0
     310:	09a080e7          	jalr	154(ra) # 3a6 <matchstar>
     314:	87aa                	mv	a5,a0
     316:	a059                	j	39c <matchhere+0xdc>
  if(re[0] == '$' && re[1] == '\0')
     318:	fe843783          	ld	a5,-24(s0)
     31c:	0007c783          	lbu	a5,0(a5)
     320:	873e                	mv	a4,a5
     322:	02400793          	li	a5,36
     326:	02f71363          	bne	a4,a5,34c <matchhere+0x8c>
     32a:	fe843783          	ld	a5,-24(s0)
     32e:	0785                	addi	a5,a5,1
     330:	0007c783          	lbu	a5,0(a5)
     334:	ef81                	bnez	a5,34c <matchhere+0x8c>
    return *text == '\0';
     336:	fe043783          	ld	a5,-32(s0)
     33a:	0007c783          	lbu	a5,0(a5)
     33e:	2781                	sext.w	a5,a5
     340:	0017b793          	seqz	a5,a5
     344:	0ff7f793          	andi	a5,a5,255
     348:	2781                	sext.w	a5,a5
     34a:	a889                	j	39c <matchhere+0xdc>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
     34c:	fe043783          	ld	a5,-32(s0)
     350:	0007c783          	lbu	a5,0(a5)
     354:	c3b9                	beqz	a5,39a <matchhere+0xda>
     356:	fe843783          	ld	a5,-24(s0)
     35a:	0007c783          	lbu	a5,0(a5)
     35e:	873e                	mv	a4,a5
     360:	02e00793          	li	a5,46
     364:	00f70c63          	beq	a4,a5,37c <matchhere+0xbc>
     368:	fe843783          	ld	a5,-24(s0)
     36c:	0007c703          	lbu	a4,0(a5)
     370:	fe043783          	ld	a5,-32(s0)
     374:	0007c783          	lbu	a5,0(a5)
     378:	02f71163          	bne	a4,a5,39a <matchhere+0xda>
    return matchhere(re+1, text+1);
     37c:	fe843783          	ld	a5,-24(s0)
     380:	00178713          	addi	a4,a5,1
     384:	fe043783          	ld	a5,-32(s0)
     388:	0785                	addi	a5,a5,1
     38a:	85be                	mv	a1,a5
     38c:	853a                	mv	a0,a4
     38e:	00000097          	auipc	ra,0x0
     392:	f32080e7          	jalr	-206(ra) # 2c0 <matchhere>
     396:	87aa                	mv	a5,a0
     398:	a011                	j	39c <matchhere+0xdc>
  return 0;
     39a:	4781                	li	a5,0
}
     39c:	853e                	mv	a0,a5
     39e:	60e2                	ld	ra,24(sp)
     3a0:	6442                	ld	s0,16(sp)
     3a2:	6105                	addi	sp,sp,32
     3a4:	8082                	ret

00000000000003a6 <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
     3a6:	7179                	addi	sp,sp,-48
     3a8:	f406                	sd	ra,40(sp)
     3aa:	f022                	sd	s0,32(sp)
     3ac:	1800                	addi	s0,sp,48
     3ae:	87aa                	mv	a5,a0
     3b0:	feb43023          	sd	a1,-32(s0)
     3b4:	fcc43c23          	sd	a2,-40(s0)
     3b8:	fef42623          	sw	a5,-20(s0)
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
     3bc:	fd843583          	ld	a1,-40(s0)
     3c0:	fe043503          	ld	a0,-32(s0)
     3c4:	00000097          	auipc	ra,0x0
     3c8:	efc080e7          	jalr	-260(ra) # 2c0 <matchhere>
     3cc:	87aa                	mv	a5,a0
     3ce:	c399                	beqz	a5,3d4 <matchstar+0x2e>
      return 1;
     3d0:	4785                	li	a5,1
     3d2:	a835                	j	40e <matchstar+0x68>
  }while(*text!='\0' && (*text++==c || c=='.'));
     3d4:	fd843783          	ld	a5,-40(s0)
     3d8:	0007c783          	lbu	a5,0(a5)
     3dc:	cb85                	beqz	a5,40c <matchstar+0x66>
     3de:	fd843783          	ld	a5,-40(s0)
     3e2:	00178713          	addi	a4,a5,1
     3e6:	fce43c23          	sd	a4,-40(s0)
     3ea:	0007c783          	lbu	a5,0(a5)
     3ee:	0007871b          	sext.w	a4,a5
     3f2:	fec42783          	lw	a5,-20(s0)
     3f6:	2781                	sext.w	a5,a5
     3f8:	fce782e3          	beq	a5,a4,3bc <matchstar+0x16>
     3fc:	fec42783          	lw	a5,-20(s0)
     400:	0007871b          	sext.w	a4,a5
     404:	02e00793          	li	a5,46
     408:	faf70ae3          	beq	a4,a5,3bc <matchstar+0x16>
  return 0;
     40c:	4781                	li	a5,0
}
     40e:	853e                	mv	a0,a5
     410:	70a2                	ld	ra,40(sp)
     412:	7402                	ld	s0,32(sp)
     414:	6145                	addi	sp,sp,48
     416:	8082                	ret

0000000000000418 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     418:	7179                	addi	sp,sp,-48
     41a:	f422                	sd	s0,40(sp)
     41c:	1800                	addi	s0,sp,48
     41e:	fca43c23          	sd	a0,-40(s0)
     422:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     426:	fd843783          	ld	a5,-40(s0)
     42a:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     42e:	0001                	nop
     430:	fd043703          	ld	a4,-48(s0)
     434:	00170793          	addi	a5,a4,1
     438:	fcf43823          	sd	a5,-48(s0)
     43c:	fd843783          	ld	a5,-40(s0)
     440:	00178693          	addi	a3,a5,1
     444:	fcd43c23          	sd	a3,-40(s0)
     448:	00074703          	lbu	a4,0(a4)
     44c:	00e78023          	sb	a4,0(a5)
     450:	0007c783          	lbu	a5,0(a5)
     454:	fff1                	bnez	a5,430 <strcpy+0x18>
    ;
  return os;
     456:	fe843783          	ld	a5,-24(s0)
}
     45a:	853e                	mv	a0,a5
     45c:	7422                	ld	s0,40(sp)
     45e:	6145                	addi	sp,sp,48
     460:	8082                	ret

0000000000000462 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     462:	1101                	addi	sp,sp,-32
     464:	ec22                	sd	s0,24(sp)
     466:	1000                	addi	s0,sp,32
     468:	fea43423          	sd	a0,-24(s0)
     46c:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     470:	a819                	j	486 <strcmp+0x24>
    p++, q++;
     472:	fe843783          	ld	a5,-24(s0)
     476:	0785                	addi	a5,a5,1
     478:	fef43423          	sd	a5,-24(s0)
     47c:	fe043783          	ld	a5,-32(s0)
     480:	0785                	addi	a5,a5,1
     482:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     486:	fe843783          	ld	a5,-24(s0)
     48a:	0007c783          	lbu	a5,0(a5)
     48e:	cb99                	beqz	a5,4a4 <strcmp+0x42>
     490:	fe843783          	ld	a5,-24(s0)
     494:	0007c703          	lbu	a4,0(a5)
     498:	fe043783          	ld	a5,-32(s0)
     49c:	0007c783          	lbu	a5,0(a5)
     4a0:	fcf709e3          	beq	a4,a5,472 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     4a4:	fe843783          	ld	a5,-24(s0)
     4a8:	0007c783          	lbu	a5,0(a5)
     4ac:	0007871b          	sext.w	a4,a5
     4b0:	fe043783          	ld	a5,-32(s0)
     4b4:	0007c783          	lbu	a5,0(a5)
     4b8:	2781                	sext.w	a5,a5
     4ba:	40f707bb          	subw	a5,a4,a5
     4be:	2781                	sext.w	a5,a5
}
     4c0:	853e                	mv	a0,a5
     4c2:	6462                	ld	s0,24(sp)
     4c4:	6105                	addi	sp,sp,32
     4c6:	8082                	ret

00000000000004c8 <strlen>:

uint
strlen(const char *s)
{
     4c8:	7179                	addi	sp,sp,-48
     4ca:	f422                	sd	s0,40(sp)
     4cc:	1800                	addi	s0,sp,48
     4ce:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     4d2:	fe042623          	sw	zero,-20(s0)
     4d6:	a031                	j	4e2 <strlen+0x1a>
     4d8:	fec42783          	lw	a5,-20(s0)
     4dc:	2785                	addiw	a5,a5,1
     4de:	fef42623          	sw	a5,-20(s0)
     4e2:	fec42783          	lw	a5,-20(s0)
     4e6:	fd843703          	ld	a4,-40(s0)
     4ea:	97ba                	add	a5,a5,a4
     4ec:	0007c783          	lbu	a5,0(a5)
     4f0:	f7e5                	bnez	a5,4d8 <strlen+0x10>
    ;
  return n;
     4f2:	fec42783          	lw	a5,-20(s0)
}
     4f6:	853e                	mv	a0,a5
     4f8:	7422                	ld	s0,40(sp)
     4fa:	6145                	addi	sp,sp,48
     4fc:	8082                	ret

00000000000004fe <memset>:

void*
memset(void *dst, int c, uint n)
{
     4fe:	7179                	addi	sp,sp,-48
     500:	f422                	sd	s0,40(sp)
     502:	1800                	addi	s0,sp,48
     504:	fca43c23          	sd	a0,-40(s0)
     508:	87ae                	mv	a5,a1
     50a:	8732                	mv	a4,a2
     50c:	fcf42a23          	sw	a5,-44(s0)
     510:	87ba                	mv	a5,a4
     512:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     516:	fd843783          	ld	a5,-40(s0)
     51a:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     51e:	fe042623          	sw	zero,-20(s0)
     522:	a00d                	j	544 <memset+0x46>
    cdst[i] = c;
     524:	fec42783          	lw	a5,-20(s0)
     528:	fe043703          	ld	a4,-32(s0)
     52c:	97ba                	add	a5,a5,a4
     52e:	fd442703          	lw	a4,-44(s0)
     532:	0ff77713          	andi	a4,a4,255
     536:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     53a:	fec42783          	lw	a5,-20(s0)
     53e:	2785                	addiw	a5,a5,1
     540:	fef42623          	sw	a5,-20(s0)
     544:	fec42703          	lw	a4,-20(s0)
     548:	fd042783          	lw	a5,-48(s0)
     54c:	2781                	sext.w	a5,a5
     54e:	fcf76be3          	bltu	a4,a5,524 <memset+0x26>
  }
  return dst;
     552:	fd843783          	ld	a5,-40(s0)
}
     556:	853e                	mv	a0,a5
     558:	7422                	ld	s0,40(sp)
     55a:	6145                	addi	sp,sp,48
     55c:	8082                	ret

000000000000055e <strchr>:

char*
strchr(const char *s, char c)
{
     55e:	1101                	addi	sp,sp,-32
     560:	ec22                	sd	s0,24(sp)
     562:	1000                	addi	s0,sp,32
     564:	fea43423          	sd	a0,-24(s0)
     568:	87ae                	mv	a5,a1
     56a:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     56e:	a01d                	j	594 <strchr+0x36>
    if(*s == c)
     570:	fe843783          	ld	a5,-24(s0)
     574:	0007c703          	lbu	a4,0(a5)
     578:	fe744783          	lbu	a5,-25(s0)
     57c:	0ff7f793          	andi	a5,a5,255
     580:	00e79563          	bne	a5,a4,58a <strchr+0x2c>
      return (char*)s;
     584:	fe843783          	ld	a5,-24(s0)
     588:	a821                	j	5a0 <strchr+0x42>
  for(; *s; s++)
     58a:	fe843783          	ld	a5,-24(s0)
     58e:	0785                	addi	a5,a5,1
     590:	fef43423          	sd	a5,-24(s0)
     594:	fe843783          	ld	a5,-24(s0)
     598:	0007c783          	lbu	a5,0(a5)
     59c:	fbf1                	bnez	a5,570 <strchr+0x12>
  return 0;
     59e:	4781                	li	a5,0
}
     5a0:	853e                	mv	a0,a5
     5a2:	6462                	ld	s0,24(sp)
     5a4:	6105                	addi	sp,sp,32
     5a6:	8082                	ret

00000000000005a8 <gets>:

char*
gets(char *buf, int max)
{
     5a8:	7179                	addi	sp,sp,-48
     5aa:	f406                	sd	ra,40(sp)
     5ac:	f022                	sd	s0,32(sp)
     5ae:	1800                	addi	s0,sp,48
     5b0:	fca43c23          	sd	a0,-40(s0)
     5b4:	87ae                	mv	a5,a1
     5b6:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     5ba:	fe042623          	sw	zero,-20(s0)
     5be:	a8a1                	j	616 <gets+0x6e>
    cc = read(0, &c, 1);
     5c0:	fe740793          	addi	a5,s0,-25
     5c4:	4605                	li	a2,1
     5c6:	85be                	mv	a1,a5
     5c8:	4501                	li	a0,0
     5ca:	00000097          	auipc	ra,0x0
     5ce:	2f6080e7          	jalr	758(ra) # 8c0 <read>
     5d2:	87aa                	mv	a5,a0
     5d4:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     5d8:	fe842783          	lw	a5,-24(s0)
     5dc:	2781                	sext.w	a5,a5
     5de:	04f05763          	blez	a5,62c <gets+0x84>
      break;
    buf[i++] = c;
     5e2:	fec42783          	lw	a5,-20(s0)
     5e6:	0017871b          	addiw	a4,a5,1
     5ea:	fee42623          	sw	a4,-20(s0)
     5ee:	873e                	mv	a4,a5
     5f0:	fd843783          	ld	a5,-40(s0)
     5f4:	97ba                	add	a5,a5,a4
     5f6:	fe744703          	lbu	a4,-25(s0)
     5fa:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     5fe:	fe744783          	lbu	a5,-25(s0)
     602:	873e                	mv	a4,a5
     604:	47a9                	li	a5,10
     606:	02f70463          	beq	a4,a5,62e <gets+0x86>
     60a:	fe744783          	lbu	a5,-25(s0)
     60e:	873e                	mv	a4,a5
     610:	47b5                	li	a5,13
     612:	00f70e63          	beq	a4,a5,62e <gets+0x86>
  for(i=0; i+1 < max; ){
     616:	fec42783          	lw	a5,-20(s0)
     61a:	2785                	addiw	a5,a5,1
     61c:	0007871b          	sext.w	a4,a5
     620:	fd442783          	lw	a5,-44(s0)
     624:	2781                	sext.w	a5,a5
     626:	f8f74de3          	blt	a4,a5,5c0 <gets+0x18>
     62a:	a011                	j	62e <gets+0x86>
      break;
     62c:	0001                	nop
      break;
  }
  buf[i] = '\0';
     62e:	fec42783          	lw	a5,-20(s0)
     632:	fd843703          	ld	a4,-40(s0)
     636:	97ba                	add	a5,a5,a4
     638:	00078023          	sb	zero,0(a5)
  return buf;
     63c:	fd843783          	ld	a5,-40(s0)
}
     640:	853e                	mv	a0,a5
     642:	70a2                	ld	ra,40(sp)
     644:	7402                	ld	s0,32(sp)
     646:	6145                	addi	sp,sp,48
     648:	8082                	ret

000000000000064a <stat>:

int
stat(const char *n, struct stat *st)
{
     64a:	7179                	addi	sp,sp,-48
     64c:	f406                	sd	ra,40(sp)
     64e:	f022                	sd	s0,32(sp)
     650:	1800                	addi	s0,sp,48
     652:	fca43c23          	sd	a0,-40(s0)
     656:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     65a:	4581                	li	a1,0
     65c:	fd843503          	ld	a0,-40(s0)
     660:	00000097          	auipc	ra,0x0
     664:	288080e7          	jalr	648(ra) # 8e8 <open>
     668:	87aa                	mv	a5,a0
     66a:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     66e:	fec42783          	lw	a5,-20(s0)
     672:	2781                	sext.w	a5,a5
     674:	0007d463          	bgez	a5,67c <stat+0x32>
    return -1;
     678:	57fd                	li	a5,-1
     67a:	a035                	j	6a6 <stat+0x5c>
  r = fstat(fd, st);
     67c:	fec42783          	lw	a5,-20(s0)
     680:	fd043583          	ld	a1,-48(s0)
     684:	853e                	mv	a0,a5
     686:	00000097          	auipc	ra,0x0
     68a:	27a080e7          	jalr	634(ra) # 900 <fstat>
     68e:	87aa                	mv	a5,a0
     690:	fef42423          	sw	a5,-24(s0)
  close(fd);
     694:	fec42783          	lw	a5,-20(s0)
     698:	853e                	mv	a0,a5
     69a:	00000097          	auipc	ra,0x0
     69e:	236080e7          	jalr	566(ra) # 8d0 <close>
  return r;
     6a2:	fe842783          	lw	a5,-24(s0)
}
     6a6:	853e                	mv	a0,a5
     6a8:	70a2                	ld	ra,40(sp)
     6aa:	7402                	ld	s0,32(sp)
     6ac:	6145                	addi	sp,sp,48
     6ae:	8082                	ret

00000000000006b0 <atoi>:

int
atoi(const char *s)
{
     6b0:	7179                	addi	sp,sp,-48
     6b2:	f422                	sd	s0,40(sp)
     6b4:	1800                	addi	s0,sp,48
     6b6:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     6ba:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     6be:	a815                	j	6f2 <atoi+0x42>
    n = n*10 + *s++ - '0';
     6c0:	fec42703          	lw	a4,-20(s0)
     6c4:	87ba                	mv	a5,a4
     6c6:	0027979b          	slliw	a5,a5,0x2
     6ca:	9fb9                	addw	a5,a5,a4
     6cc:	0017979b          	slliw	a5,a5,0x1
     6d0:	0007871b          	sext.w	a4,a5
     6d4:	fd843783          	ld	a5,-40(s0)
     6d8:	00178693          	addi	a3,a5,1
     6dc:	fcd43c23          	sd	a3,-40(s0)
     6e0:	0007c783          	lbu	a5,0(a5)
     6e4:	2781                	sext.w	a5,a5
     6e6:	9fb9                	addw	a5,a5,a4
     6e8:	2781                	sext.w	a5,a5
     6ea:	fd07879b          	addiw	a5,a5,-48
     6ee:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     6f2:	fd843783          	ld	a5,-40(s0)
     6f6:	0007c783          	lbu	a5,0(a5)
     6fa:	873e                	mv	a4,a5
     6fc:	02f00793          	li	a5,47
     700:	00e7fb63          	bgeu	a5,a4,716 <atoi+0x66>
     704:	fd843783          	ld	a5,-40(s0)
     708:	0007c783          	lbu	a5,0(a5)
     70c:	873e                	mv	a4,a5
     70e:	03900793          	li	a5,57
     712:	fae7f7e3          	bgeu	a5,a4,6c0 <atoi+0x10>
  return n;
     716:	fec42783          	lw	a5,-20(s0)
}
     71a:	853e                	mv	a0,a5
     71c:	7422                	ld	s0,40(sp)
     71e:	6145                	addi	sp,sp,48
     720:	8082                	ret

0000000000000722 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     722:	7139                	addi	sp,sp,-64
     724:	fc22                	sd	s0,56(sp)
     726:	0080                	addi	s0,sp,64
     728:	fca43c23          	sd	a0,-40(s0)
     72c:	fcb43823          	sd	a1,-48(s0)
     730:	87b2                	mv	a5,a2
     732:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     736:	fd843783          	ld	a5,-40(s0)
     73a:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     73e:	fd043783          	ld	a5,-48(s0)
     742:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     746:	fe043703          	ld	a4,-32(s0)
     74a:	fe843783          	ld	a5,-24(s0)
     74e:	02e7fc63          	bgeu	a5,a4,786 <memmove+0x64>
    while(n-- > 0)
     752:	a00d                	j	774 <memmove+0x52>
      *dst++ = *src++;
     754:	fe043703          	ld	a4,-32(s0)
     758:	00170793          	addi	a5,a4,1
     75c:	fef43023          	sd	a5,-32(s0)
     760:	fe843783          	ld	a5,-24(s0)
     764:	00178693          	addi	a3,a5,1
     768:	fed43423          	sd	a3,-24(s0)
     76c:	00074703          	lbu	a4,0(a4)
     770:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     774:	fcc42783          	lw	a5,-52(s0)
     778:	fff7871b          	addiw	a4,a5,-1
     77c:	fce42623          	sw	a4,-52(s0)
     780:	fcf04ae3          	bgtz	a5,754 <memmove+0x32>
     784:	a891                	j	7d8 <memmove+0xb6>
  } else {
    dst += n;
     786:	fcc42783          	lw	a5,-52(s0)
     78a:	fe843703          	ld	a4,-24(s0)
     78e:	97ba                	add	a5,a5,a4
     790:	fef43423          	sd	a5,-24(s0)
    src += n;
     794:	fcc42783          	lw	a5,-52(s0)
     798:	fe043703          	ld	a4,-32(s0)
     79c:	97ba                	add	a5,a5,a4
     79e:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     7a2:	a01d                	j	7c8 <memmove+0xa6>
      *--dst = *--src;
     7a4:	fe043783          	ld	a5,-32(s0)
     7a8:	17fd                	addi	a5,a5,-1
     7aa:	fef43023          	sd	a5,-32(s0)
     7ae:	fe843783          	ld	a5,-24(s0)
     7b2:	17fd                	addi	a5,a5,-1
     7b4:	fef43423          	sd	a5,-24(s0)
     7b8:	fe043783          	ld	a5,-32(s0)
     7bc:	0007c703          	lbu	a4,0(a5)
     7c0:	fe843783          	ld	a5,-24(s0)
     7c4:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     7c8:	fcc42783          	lw	a5,-52(s0)
     7cc:	fff7871b          	addiw	a4,a5,-1
     7d0:	fce42623          	sw	a4,-52(s0)
     7d4:	fcf048e3          	bgtz	a5,7a4 <memmove+0x82>
  }
  return vdst;
     7d8:	fd843783          	ld	a5,-40(s0)
}
     7dc:	853e                	mv	a0,a5
     7de:	7462                	ld	s0,56(sp)
     7e0:	6121                	addi	sp,sp,64
     7e2:	8082                	ret

00000000000007e4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     7e4:	7139                	addi	sp,sp,-64
     7e6:	fc22                	sd	s0,56(sp)
     7e8:	0080                	addi	s0,sp,64
     7ea:	fca43c23          	sd	a0,-40(s0)
     7ee:	fcb43823          	sd	a1,-48(s0)
     7f2:	87b2                	mv	a5,a2
     7f4:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     7f8:	fd843783          	ld	a5,-40(s0)
     7fc:	fef43423          	sd	a5,-24(s0)
     800:	fd043783          	ld	a5,-48(s0)
     804:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     808:	a0a1                	j	850 <memcmp+0x6c>
    if (*p1 != *p2) {
     80a:	fe843783          	ld	a5,-24(s0)
     80e:	0007c703          	lbu	a4,0(a5)
     812:	fe043783          	ld	a5,-32(s0)
     816:	0007c783          	lbu	a5,0(a5)
     81a:	02f70163          	beq	a4,a5,83c <memcmp+0x58>
      return *p1 - *p2;
     81e:	fe843783          	ld	a5,-24(s0)
     822:	0007c783          	lbu	a5,0(a5)
     826:	0007871b          	sext.w	a4,a5
     82a:	fe043783          	ld	a5,-32(s0)
     82e:	0007c783          	lbu	a5,0(a5)
     832:	2781                	sext.w	a5,a5
     834:	40f707bb          	subw	a5,a4,a5
     838:	2781                	sext.w	a5,a5
     83a:	a01d                	j	860 <memcmp+0x7c>
    }
    p1++;
     83c:	fe843783          	ld	a5,-24(s0)
     840:	0785                	addi	a5,a5,1
     842:	fef43423          	sd	a5,-24(s0)
    p2++;
     846:	fe043783          	ld	a5,-32(s0)
     84a:	0785                	addi	a5,a5,1
     84c:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     850:	fcc42783          	lw	a5,-52(s0)
     854:	fff7871b          	addiw	a4,a5,-1
     858:	fce42623          	sw	a4,-52(s0)
     85c:	f7dd                	bnez	a5,80a <memcmp+0x26>
  }
  return 0;
     85e:	4781                	li	a5,0
}
     860:	853e                	mv	a0,a5
     862:	7462                	ld	s0,56(sp)
     864:	6121                	addi	sp,sp,64
     866:	8082                	ret

0000000000000868 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     868:	7179                	addi	sp,sp,-48
     86a:	f406                	sd	ra,40(sp)
     86c:	f022                	sd	s0,32(sp)
     86e:	1800                	addi	s0,sp,48
     870:	fea43423          	sd	a0,-24(s0)
     874:	feb43023          	sd	a1,-32(s0)
     878:	87b2                	mv	a5,a2
     87a:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     87e:	fdc42783          	lw	a5,-36(s0)
     882:	863e                	mv	a2,a5
     884:	fe043583          	ld	a1,-32(s0)
     888:	fe843503          	ld	a0,-24(s0)
     88c:	00000097          	auipc	ra,0x0
     890:	e96080e7          	jalr	-362(ra) # 722 <memmove>
     894:	87aa                	mv	a5,a0
}
     896:	853e                	mv	a0,a5
     898:	70a2                	ld	ra,40(sp)
     89a:	7402                	ld	s0,32(sp)
     89c:	6145                	addi	sp,sp,48
     89e:	8082                	ret

00000000000008a0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     8a0:	4885                	li	a7,1
 ecall
     8a2:	00000073          	ecall
 ret
     8a6:	8082                	ret

00000000000008a8 <exit>:
.global exit
exit:
 li a7, SYS_exit
     8a8:	4889                	li	a7,2
 ecall
     8aa:	00000073          	ecall
 ret
     8ae:	8082                	ret

00000000000008b0 <wait>:
.global wait
wait:
 li a7, SYS_wait
     8b0:	488d                	li	a7,3
 ecall
     8b2:	00000073          	ecall
 ret
     8b6:	8082                	ret

00000000000008b8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     8b8:	4891                	li	a7,4
 ecall
     8ba:	00000073          	ecall
 ret
     8be:	8082                	ret

00000000000008c0 <read>:
.global read
read:
 li a7, SYS_read
     8c0:	4895                	li	a7,5
 ecall
     8c2:	00000073          	ecall
 ret
     8c6:	8082                	ret

00000000000008c8 <write>:
.global write
write:
 li a7, SYS_write
     8c8:	48c1                	li	a7,16
 ecall
     8ca:	00000073          	ecall
 ret
     8ce:	8082                	ret

00000000000008d0 <close>:
.global close
close:
 li a7, SYS_close
     8d0:	48d5                	li	a7,21
 ecall
     8d2:	00000073          	ecall
 ret
     8d6:	8082                	ret

00000000000008d8 <kill>:
.global kill
kill:
 li a7, SYS_kill
     8d8:	4899                	li	a7,6
 ecall
     8da:	00000073          	ecall
 ret
     8de:	8082                	ret

00000000000008e0 <exec>:
.global exec
exec:
 li a7, SYS_exec
     8e0:	489d                	li	a7,7
 ecall
     8e2:	00000073          	ecall
 ret
     8e6:	8082                	ret

00000000000008e8 <open>:
.global open
open:
 li a7, SYS_open
     8e8:	48bd                	li	a7,15
 ecall
     8ea:	00000073          	ecall
 ret
     8ee:	8082                	ret

00000000000008f0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     8f0:	48c5                	li	a7,17
 ecall
     8f2:	00000073          	ecall
 ret
     8f6:	8082                	ret

00000000000008f8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     8f8:	48c9                	li	a7,18
 ecall
     8fa:	00000073          	ecall
 ret
     8fe:	8082                	ret

0000000000000900 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     900:	48a1                	li	a7,8
 ecall
     902:	00000073          	ecall
 ret
     906:	8082                	ret

0000000000000908 <link>:
.global link
link:
 li a7, SYS_link
     908:	48cd                	li	a7,19
 ecall
     90a:	00000073          	ecall
 ret
     90e:	8082                	ret

0000000000000910 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     910:	48d1                	li	a7,20
 ecall
     912:	00000073          	ecall
 ret
     916:	8082                	ret

0000000000000918 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     918:	48a5                	li	a7,9
 ecall
     91a:	00000073          	ecall
 ret
     91e:	8082                	ret

0000000000000920 <dup>:
.global dup
dup:
 li a7, SYS_dup
     920:	48a9                	li	a7,10
 ecall
     922:	00000073          	ecall
 ret
     926:	8082                	ret

0000000000000928 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     928:	48ad                	li	a7,11
 ecall
     92a:	00000073          	ecall
 ret
     92e:	8082                	ret

0000000000000930 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     930:	48b1                	li	a7,12
 ecall
     932:	00000073          	ecall
 ret
     936:	8082                	ret

0000000000000938 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     938:	48b5                	li	a7,13
 ecall
     93a:	00000073          	ecall
 ret
     93e:	8082                	ret

0000000000000940 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     940:	48b9                	li	a7,14
 ecall
     942:	00000073          	ecall
 ret
     946:	8082                	ret

0000000000000948 <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     948:	48d9                	li	a7,22
 ecall
     94a:	00000073          	ecall
 ret
     94e:	8082                	ret

0000000000000950 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     950:	48dd                	li	a7,23
 ecall
     952:	00000073          	ecall
 ret
     956:	8082                	ret

0000000000000958 <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     958:	48e1                	li	a7,24
 ecall
     95a:	00000073          	ecall
 ret
     95e:	8082                	ret

0000000000000960 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     960:	1101                	addi	sp,sp,-32
     962:	ec06                	sd	ra,24(sp)
     964:	e822                	sd	s0,16(sp)
     966:	1000                	addi	s0,sp,32
     968:	87aa                	mv	a5,a0
     96a:	872e                	mv	a4,a1
     96c:	fef42623          	sw	a5,-20(s0)
     970:	87ba                	mv	a5,a4
     972:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     976:	feb40713          	addi	a4,s0,-21
     97a:	fec42783          	lw	a5,-20(s0)
     97e:	4605                	li	a2,1
     980:	85ba                	mv	a1,a4
     982:	853e                	mv	a0,a5
     984:	00000097          	auipc	ra,0x0
     988:	f44080e7          	jalr	-188(ra) # 8c8 <write>
}
     98c:	0001                	nop
     98e:	60e2                	ld	ra,24(sp)
     990:	6442                	ld	s0,16(sp)
     992:	6105                	addi	sp,sp,32
     994:	8082                	ret

0000000000000996 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     996:	7139                	addi	sp,sp,-64
     998:	fc06                	sd	ra,56(sp)
     99a:	f822                	sd	s0,48(sp)
     99c:	0080                	addi	s0,sp,64
     99e:	87aa                	mv	a5,a0
     9a0:	8736                	mv	a4,a3
     9a2:	fcf42623          	sw	a5,-52(s0)
     9a6:	87ae                	mv	a5,a1
     9a8:	fcf42423          	sw	a5,-56(s0)
     9ac:	87b2                	mv	a5,a2
     9ae:	fcf42223          	sw	a5,-60(s0)
     9b2:	87ba                	mv	a5,a4
     9b4:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     9b8:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     9bc:	fc042783          	lw	a5,-64(s0)
     9c0:	2781                	sext.w	a5,a5
     9c2:	c38d                	beqz	a5,9e4 <printint+0x4e>
     9c4:	fc842783          	lw	a5,-56(s0)
     9c8:	2781                	sext.w	a5,a5
     9ca:	0007dd63          	bgez	a5,9e4 <printint+0x4e>
    neg = 1;
     9ce:	4785                	li	a5,1
     9d0:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     9d4:	fc842783          	lw	a5,-56(s0)
     9d8:	40f007bb          	negw	a5,a5
     9dc:	2781                	sext.w	a5,a5
     9de:	fef42223          	sw	a5,-28(s0)
     9e2:	a029                	j	9ec <printint+0x56>
  } else {
    x = xx;
     9e4:	fc842783          	lw	a5,-56(s0)
     9e8:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     9ec:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     9f0:	fc442783          	lw	a5,-60(s0)
     9f4:	fe442703          	lw	a4,-28(s0)
     9f8:	02f777bb          	remuw	a5,a4,a5
     9fc:	0007861b          	sext.w	a2,a5
     a00:	fec42783          	lw	a5,-20(s0)
     a04:	0017871b          	addiw	a4,a5,1
     a08:	fee42623          	sw	a4,-20(s0)
     a0c:	00001697          	auipc	a3,0x1
     a10:	ebc68693          	addi	a3,a3,-324 # 18c8 <digits>
     a14:	02061713          	slli	a4,a2,0x20
     a18:	9301                	srli	a4,a4,0x20
     a1a:	9736                	add	a4,a4,a3
     a1c:	00074703          	lbu	a4,0(a4)
     a20:	ff040693          	addi	a3,s0,-16
     a24:	97b6                	add	a5,a5,a3
     a26:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     a2a:	fc442783          	lw	a5,-60(s0)
     a2e:	fe442703          	lw	a4,-28(s0)
     a32:	02f757bb          	divuw	a5,a4,a5
     a36:	fef42223          	sw	a5,-28(s0)
     a3a:	fe442783          	lw	a5,-28(s0)
     a3e:	2781                	sext.w	a5,a5
     a40:	fbc5                	bnez	a5,9f0 <printint+0x5a>
  if(neg)
     a42:	fe842783          	lw	a5,-24(s0)
     a46:	2781                	sext.w	a5,a5
     a48:	cf95                	beqz	a5,a84 <printint+0xee>
    buf[i++] = '-';
     a4a:	fec42783          	lw	a5,-20(s0)
     a4e:	0017871b          	addiw	a4,a5,1
     a52:	fee42623          	sw	a4,-20(s0)
     a56:	ff040713          	addi	a4,s0,-16
     a5a:	97ba                	add	a5,a5,a4
     a5c:	02d00713          	li	a4,45
     a60:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     a64:	a005                	j	a84 <printint+0xee>
    putc(fd, buf[i]);
     a66:	fec42783          	lw	a5,-20(s0)
     a6a:	ff040713          	addi	a4,s0,-16
     a6e:	97ba                	add	a5,a5,a4
     a70:	fe07c703          	lbu	a4,-32(a5)
     a74:	fcc42783          	lw	a5,-52(s0)
     a78:	85ba                	mv	a1,a4
     a7a:	853e                	mv	a0,a5
     a7c:	00000097          	auipc	ra,0x0
     a80:	ee4080e7          	jalr	-284(ra) # 960 <putc>
  while(--i >= 0)
     a84:	fec42783          	lw	a5,-20(s0)
     a88:	37fd                	addiw	a5,a5,-1
     a8a:	fef42623          	sw	a5,-20(s0)
     a8e:	fec42783          	lw	a5,-20(s0)
     a92:	2781                	sext.w	a5,a5
     a94:	fc07d9e3          	bgez	a5,a66 <printint+0xd0>
}
     a98:	0001                	nop
     a9a:	0001                	nop
     a9c:	70e2                	ld	ra,56(sp)
     a9e:	7442                	ld	s0,48(sp)
     aa0:	6121                	addi	sp,sp,64
     aa2:	8082                	ret

0000000000000aa4 <printptr>:

static void
printptr(int fd, uint64 x) {
     aa4:	7179                	addi	sp,sp,-48
     aa6:	f406                	sd	ra,40(sp)
     aa8:	f022                	sd	s0,32(sp)
     aaa:	1800                	addi	s0,sp,48
     aac:	87aa                	mv	a5,a0
     aae:	fcb43823          	sd	a1,-48(s0)
     ab2:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     ab6:	fdc42783          	lw	a5,-36(s0)
     aba:	03000593          	li	a1,48
     abe:	853e                	mv	a0,a5
     ac0:	00000097          	auipc	ra,0x0
     ac4:	ea0080e7          	jalr	-352(ra) # 960 <putc>
  putc(fd, 'x');
     ac8:	fdc42783          	lw	a5,-36(s0)
     acc:	07800593          	li	a1,120
     ad0:	853e                	mv	a0,a5
     ad2:	00000097          	auipc	ra,0x0
     ad6:	e8e080e7          	jalr	-370(ra) # 960 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     ada:	fe042623          	sw	zero,-20(s0)
     ade:	a82d                	j	b18 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     ae0:	fd043783          	ld	a5,-48(s0)
     ae4:	93f1                	srli	a5,a5,0x3c
     ae6:	00001717          	auipc	a4,0x1
     aea:	de270713          	addi	a4,a4,-542 # 18c8 <digits>
     aee:	97ba                	add	a5,a5,a4
     af0:	0007c703          	lbu	a4,0(a5)
     af4:	fdc42783          	lw	a5,-36(s0)
     af8:	85ba                	mv	a1,a4
     afa:	853e                	mv	a0,a5
     afc:	00000097          	auipc	ra,0x0
     b00:	e64080e7          	jalr	-412(ra) # 960 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     b04:	fec42783          	lw	a5,-20(s0)
     b08:	2785                	addiw	a5,a5,1
     b0a:	fef42623          	sw	a5,-20(s0)
     b0e:	fd043783          	ld	a5,-48(s0)
     b12:	0792                	slli	a5,a5,0x4
     b14:	fcf43823          	sd	a5,-48(s0)
     b18:	fec42783          	lw	a5,-20(s0)
     b1c:	873e                	mv	a4,a5
     b1e:	47bd                	li	a5,15
     b20:	fce7f0e3          	bgeu	a5,a4,ae0 <printptr+0x3c>
}
     b24:	0001                	nop
     b26:	0001                	nop
     b28:	70a2                	ld	ra,40(sp)
     b2a:	7402                	ld	s0,32(sp)
     b2c:	6145                	addi	sp,sp,48
     b2e:	8082                	ret

0000000000000b30 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     b30:	715d                	addi	sp,sp,-80
     b32:	e486                	sd	ra,72(sp)
     b34:	e0a2                	sd	s0,64(sp)
     b36:	0880                	addi	s0,sp,80
     b38:	87aa                	mv	a5,a0
     b3a:	fcb43023          	sd	a1,-64(s0)
     b3e:	fac43c23          	sd	a2,-72(s0)
     b42:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     b46:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     b4a:	fe042223          	sw	zero,-28(s0)
     b4e:	a42d                	j	d78 <vprintf+0x248>
    c = fmt[i] & 0xff;
     b50:	fe442783          	lw	a5,-28(s0)
     b54:	fc043703          	ld	a4,-64(s0)
     b58:	97ba                	add	a5,a5,a4
     b5a:	0007c783          	lbu	a5,0(a5)
     b5e:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     b62:	fe042783          	lw	a5,-32(s0)
     b66:	2781                	sext.w	a5,a5
     b68:	eb9d                	bnez	a5,b9e <vprintf+0x6e>
      if(c == '%'){
     b6a:	fdc42783          	lw	a5,-36(s0)
     b6e:	0007871b          	sext.w	a4,a5
     b72:	02500793          	li	a5,37
     b76:	00f71763          	bne	a4,a5,b84 <vprintf+0x54>
        state = '%';
     b7a:	02500793          	li	a5,37
     b7e:	fef42023          	sw	a5,-32(s0)
     b82:	a2f5                	j	d6e <vprintf+0x23e>
      } else {
        putc(fd, c);
     b84:	fdc42783          	lw	a5,-36(s0)
     b88:	0ff7f713          	andi	a4,a5,255
     b8c:	fcc42783          	lw	a5,-52(s0)
     b90:	85ba                	mv	a1,a4
     b92:	853e                	mv	a0,a5
     b94:	00000097          	auipc	ra,0x0
     b98:	dcc080e7          	jalr	-564(ra) # 960 <putc>
     b9c:	aac9                	j	d6e <vprintf+0x23e>
      }
    } else if(state == '%'){
     b9e:	fe042783          	lw	a5,-32(s0)
     ba2:	0007871b          	sext.w	a4,a5
     ba6:	02500793          	li	a5,37
     baa:	1cf71263          	bne	a4,a5,d6e <vprintf+0x23e>
      if(c == 'd'){
     bae:	fdc42783          	lw	a5,-36(s0)
     bb2:	0007871b          	sext.w	a4,a5
     bb6:	06400793          	li	a5,100
     bba:	02f71463          	bne	a4,a5,be2 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     bbe:	fb843783          	ld	a5,-72(s0)
     bc2:	00878713          	addi	a4,a5,8
     bc6:	fae43c23          	sd	a4,-72(s0)
     bca:	4398                	lw	a4,0(a5)
     bcc:	fcc42783          	lw	a5,-52(s0)
     bd0:	4685                	li	a3,1
     bd2:	4629                	li	a2,10
     bd4:	85ba                	mv	a1,a4
     bd6:	853e                	mv	a0,a5
     bd8:	00000097          	auipc	ra,0x0
     bdc:	dbe080e7          	jalr	-578(ra) # 996 <printint>
     be0:	a269                	j	d6a <vprintf+0x23a>
      } else if(c == 'l') {
     be2:	fdc42783          	lw	a5,-36(s0)
     be6:	0007871b          	sext.w	a4,a5
     bea:	06c00793          	li	a5,108
     bee:	02f71663          	bne	a4,a5,c1a <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     bf2:	fb843783          	ld	a5,-72(s0)
     bf6:	00878713          	addi	a4,a5,8
     bfa:	fae43c23          	sd	a4,-72(s0)
     bfe:	639c                	ld	a5,0(a5)
     c00:	0007871b          	sext.w	a4,a5
     c04:	fcc42783          	lw	a5,-52(s0)
     c08:	4681                	li	a3,0
     c0a:	4629                	li	a2,10
     c0c:	85ba                	mv	a1,a4
     c0e:	853e                	mv	a0,a5
     c10:	00000097          	auipc	ra,0x0
     c14:	d86080e7          	jalr	-634(ra) # 996 <printint>
     c18:	aa89                	j	d6a <vprintf+0x23a>
      } else if(c == 'x') {
     c1a:	fdc42783          	lw	a5,-36(s0)
     c1e:	0007871b          	sext.w	a4,a5
     c22:	07800793          	li	a5,120
     c26:	02f71463          	bne	a4,a5,c4e <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     c2a:	fb843783          	ld	a5,-72(s0)
     c2e:	00878713          	addi	a4,a5,8
     c32:	fae43c23          	sd	a4,-72(s0)
     c36:	4398                	lw	a4,0(a5)
     c38:	fcc42783          	lw	a5,-52(s0)
     c3c:	4681                	li	a3,0
     c3e:	4641                	li	a2,16
     c40:	85ba                	mv	a1,a4
     c42:	853e                	mv	a0,a5
     c44:	00000097          	auipc	ra,0x0
     c48:	d52080e7          	jalr	-686(ra) # 996 <printint>
     c4c:	aa39                	j	d6a <vprintf+0x23a>
      } else if(c == 'p') {
     c4e:	fdc42783          	lw	a5,-36(s0)
     c52:	0007871b          	sext.w	a4,a5
     c56:	07000793          	li	a5,112
     c5a:	02f71263          	bne	a4,a5,c7e <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     c5e:	fb843783          	ld	a5,-72(s0)
     c62:	00878713          	addi	a4,a5,8
     c66:	fae43c23          	sd	a4,-72(s0)
     c6a:	6398                	ld	a4,0(a5)
     c6c:	fcc42783          	lw	a5,-52(s0)
     c70:	85ba                	mv	a1,a4
     c72:	853e                	mv	a0,a5
     c74:	00000097          	auipc	ra,0x0
     c78:	e30080e7          	jalr	-464(ra) # aa4 <printptr>
     c7c:	a0fd                	j	d6a <vprintf+0x23a>
      } else if(c == 's'){
     c7e:	fdc42783          	lw	a5,-36(s0)
     c82:	0007871b          	sext.w	a4,a5
     c86:	07300793          	li	a5,115
     c8a:	04f71c63          	bne	a4,a5,ce2 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     c8e:	fb843783          	ld	a5,-72(s0)
     c92:	00878713          	addi	a4,a5,8
     c96:	fae43c23          	sd	a4,-72(s0)
     c9a:	639c                	ld	a5,0(a5)
     c9c:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     ca0:	fe843783          	ld	a5,-24(s0)
     ca4:	eb8d                	bnez	a5,cd6 <vprintf+0x1a6>
          s = "(null)";
     ca6:	00001797          	auipc	a5,0x1
     caa:	c1a78793          	addi	a5,a5,-998 # 18c0 <schedule_dm+0x242>
     cae:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     cb2:	a015                	j	cd6 <vprintf+0x1a6>
          putc(fd, *s);
     cb4:	fe843783          	ld	a5,-24(s0)
     cb8:	0007c703          	lbu	a4,0(a5)
     cbc:	fcc42783          	lw	a5,-52(s0)
     cc0:	85ba                	mv	a1,a4
     cc2:	853e                	mv	a0,a5
     cc4:	00000097          	auipc	ra,0x0
     cc8:	c9c080e7          	jalr	-868(ra) # 960 <putc>
          s++;
     ccc:	fe843783          	ld	a5,-24(s0)
     cd0:	0785                	addi	a5,a5,1
     cd2:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     cd6:	fe843783          	ld	a5,-24(s0)
     cda:	0007c783          	lbu	a5,0(a5)
     cde:	fbf9                	bnez	a5,cb4 <vprintf+0x184>
     ce0:	a069                	j	d6a <vprintf+0x23a>
        }
      } else if(c == 'c'){
     ce2:	fdc42783          	lw	a5,-36(s0)
     ce6:	0007871b          	sext.w	a4,a5
     cea:	06300793          	li	a5,99
     cee:	02f71463          	bne	a4,a5,d16 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     cf2:	fb843783          	ld	a5,-72(s0)
     cf6:	00878713          	addi	a4,a5,8
     cfa:	fae43c23          	sd	a4,-72(s0)
     cfe:	439c                	lw	a5,0(a5)
     d00:	0ff7f713          	andi	a4,a5,255
     d04:	fcc42783          	lw	a5,-52(s0)
     d08:	85ba                	mv	a1,a4
     d0a:	853e                	mv	a0,a5
     d0c:	00000097          	auipc	ra,0x0
     d10:	c54080e7          	jalr	-940(ra) # 960 <putc>
     d14:	a899                	j	d6a <vprintf+0x23a>
      } else if(c == '%'){
     d16:	fdc42783          	lw	a5,-36(s0)
     d1a:	0007871b          	sext.w	a4,a5
     d1e:	02500793          	li	a5,37
     d22:	00f71f63          	bne	a4,a5,d40 <vprintf+0x210>
        putc(fd, c);
     d26:	fdc42783          	lw	a5,-36(s0)
     d2a:	0ff7f713          	andi	a4,a5,255
     d2e:	fcc42783          	lw	a5,-52(s0)
     d32:	85ba                	mv	a1,a4
     d34:	853e                	mv	a0,a5
     d36:	00000097          	auipc	ra,0x0
     d3a:	c2a080e7          	jalr	-982(ra) # 960 <putc>
     d3e:	a035                	j	d6a <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     d40:	fcc42783          	lw	a5,-52(s0)
     d44:	02500593          	li	a1,37
     d48:	853e                	mv	a0,a5
     d4a:	00000097          	auipc	ra,0x0
     d4e:	c16080e7          	jalr	-1002(ra) # 960 <putc>
        putc(fd, c);
     d52:	fdc42783          	lw	a5,-36(s0)
     d56:	0ff7f713          	andi	a4,a5,255
     d5a:	fcc42783          	lw	a5,-52(s0)
     d5e:	85ba                	mv	a1,a4
     d60:	853e                	mv	a0,a5
     d62:	00000097          	auipc	ra,0x0
     d66:	bfe080e7          	jalr	-1026(ra) # 960 <putc>
      }
      state = 0;
     d6a:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     d6e:	fe442783          	lw	a5,-28(s0)
     d72:	2785                	addiw	a5,a5,1
     d74:	fef42223          	sw	a5,-28(s0)
     d78:	fe442783          	lw	a5,-28(s0)
     d7c:	fc043703          	ld	a4,-64(s0)
     d80:	97ba                	add	a5,a5,a4
     d82:	0007c783          	lbu	a5,0(a5)
     d86:	dc0795e3          	bnez	a5,b50 <vprintf+0x20>
    }
  }
}
     d8a:	0001                	nop
     d8c:	0001                	nop
     d8e:	60a6                	ld	ra,72(sp)
     d90:	6406                	ld	s0,64(sp)
     d92:	6161                	addi	sp,sp,80
     d94:	8082                	ret

0000000000000d96 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     d96:	7159                	addi	sp,sp,-112
     d98:	fc06                	sd	ra,56(sp)
     d9a:	f822                	sd	s0,48(sp)
     d9c:	0080                	addi	s0,sp,64
     d9e:	fcb43823          	sd	a1,-48(s0)
     da2:	e010                	sd	a2,0(s0)
     da4:	e414                	sd	a3,8(s0)
     da6:	e818                	sd	a4,16(s0)
     da8:	ec1c                	sd	a5,24(s0)
     daa:	03043023          	sd	a6,32(s0)
     dae:	03143423          	sd	a7,40(s0)
     db2:	87aa                	mv	a5,a0
     db4:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     db8:	03040793          	addi	a5,s0,48
     dbc:	fcf43423          	sd	a5,-56(s0)
     dc0:	fc843783          	ld	a5,-56(s0)
     dc4:	fd078793          	addi	a5,a5,-48
     dc8:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     dcc:	fe843703          	ld	a4,-24(s0)
     dd0:	fdc42783          	lw	a5,-36(s0)
     dd4:	863a                	mv	a2,a4
     dd6:	fd043583          	ld	a1,-48(s0)
     dda:	853e                	mv	a0,a5
     ddc:	00000097          	auipc	ra,0x0
     de0:	d54080e7          	jalr	-684(ra) # b30 <vprintf>
}
     de4:	0001                	nop
     de6:	70e2                	ld	ra,56(sp)
     de8:	7442                	ld	s0,48(sp)
     dea:	6165                	addi	sp,sp,112
     dec:	8082                	ret

0000000000000dee <printf>:

void
printf(const char *fmt, ...)
{
     dee:	7159                	addi	sp,sp,-112
     df0:	f406                	sd	ra,40(sp)
     df2:	f022                	sd	s0,32(sp)
     df4:	1800                	addi	s0,sp,48
     df6:	fca43c23          	sd	a0,-40(s0)
     dfa:	e40c                	sd	a1,8(s0)
     dfc:	e810                	sd	a2,16(s0)
     dfe:	ec14                	sd	a3,24(s0)
     e00:	f018                	sd	a4,32(s0)
     e02:	f41c                	sd	a5,40(s0)
     e04:	03043823          	sd	a6,48(s0)
     e08:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     e0c:	04040793          	addi	a5,s0,64
     e10:	fcf43823          	sd	a5,-48(s0)
     e14:	fd043783          	ld	a5,-48(s0)
     e18:	fc878793          	addi	a5,a5,-56
     e1c:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     e20:	fe843783          	ld	a5,-24(s0)
     e24:	863e                	mv	a2,a5
     e26:	fd843583          	ld	a1,-40(s0)
     e2a:	4505                	li	a0,1
     e2c:	00000097          	auipc	ra,0x0
     e30:	d04080e7          	jalr	-764(ra) # b30 <vprintf>
}
     e34:	0001                	nop
     e36:	70a2                	ld	ra,40(sp)
     e38:	7402                	ld	s0,32(sp)
     e3a:	6165                	addi	sp,sp,112
     e3c:	8082                	ret

0000000000000e3e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     e3e:	7179                	addi	sp,sp,-48
     e40:	f422                	sd	s0,40(sp)
     e42:	1800                	addi	s0,sp,48
     e44:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     e48:	fd843783          	ld	a5,-40(s0)
     e4c:	17c1                	addi	a5,a5,-16
     e4e:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e52:	00001797          	auipc	a5,0x1
     e56:	e9e78793          	addi	a5,a5,-354 # 1cf0 <freep>
     e5a:	639c                	ld	a5,0(a5)
     e5c:	fef43423          	sd	a5,-24(s0)
     e60:	a815                	j	e94 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     e62:	fe843783          	ld	a5,-24(s0)
     e66:	639c                	ld	a5,0(a5)
     e68:	fe843703          	ld	a4,-24(s0)
     e6c:	00f76f63          	bltu	a4,a5,e8a <free+0x4c>
     e70:	fe043703          	ld	a4,-32(s0)
     e74:	fe843783          	ld	a5,-24(s0)
     e78:	02e7eb63          	bltu	a5,a4,eae <free+0x70>
     e7c:	fe843783          	ld	a5,-24(s0)
     e80:	639c                	ld	a5,0(a5)
     e82:	fe043703          	ld	a4,-32(s0)
     e86:	02f76463          	bltu	a4,a5,eae <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e8a:	fe843783          	ld	a5,-24(s0)
     e8e:	639c                	ld	a5,0(a5)
     e90:	fef43423          	sd	a5,-24(s0)
     e94:	fe043703          	ld	a4,-32(s0)
     e98:	fe843783          	ld	a5,-24(s0)
     e9c:	fce7f3e3          	bgeu	a5,a4,e62 <free+0x24>
     ea0:	fe843783          	ld	a5,-24(s0)
     ea4:	639c                	ld	a5,0(a5)
     ea6:	fe043703          	ld	a4,-32(s0)
     eaa:	faf77ce3          	bgeu	a4,a5,e62 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     eae:	fe043783          	ld	a5,-32(s0)
     eb2:	479c                	lw	a5,8(a5)
     eb4:	1782                	slli	a5,a5,0x20
     eb6:	9381                	srli	a5,a5,0x20
     eb8:	0792                	slli	a5,a5,0x4
     eba:	fe043703          	ld	a4,-32(s0)
     ebe:	973e                	add	a4,a4,a5
     ec0:	fe843783          	ld	a5,-24(s0)
     ec4:	639c                	ld	a5,0(a5)
     ec6:	02f71763          	bne	a4,a5,ef4 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     eca:	fe043783          	ld	a5,-32(s0)
     ece:	4798                	lw	a4,8(a5)
     ed0:	fe843783          	ld	a5,-24(s0)
     ed4:	639c                	ld	a5,0(a5)
     ed6:	479c                	lw	a5,8(a5)
     ed8:	9fb9                	addw	a5,a5,a4
     eda:	0007871b          	sext.w	a4,a5
     ede:	fe043783          	ld	a5,-32(s0)
     ee2:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     ee4:	fe843783          	ld	a5,-24(s0)
     ee8:	639c                	ld	a5,0(a5)
     eea:	6398                	ld	a4,0(a5)
     eec:	fe043783          	ld	a5,-32(s0)
     ef0:	e398                	sd	a4,0(a5)
     ef2:	a039                	j	f00 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     ef4:	fe843783          	ld	a5,-24(s0)
     ef8:	6398                	ld	a4,0(a5)
     efa:	fe043783          	ld	a5,-32(s0)
     efe:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     f00:	fe843783          	ld	a5,-24(s0)
     f04:	479c                	lw	a5,8(a5)
     f06:	1782                	slli	a5,a5,0x20
     f08:	9381                	srli	a5,a5,0x20
     f0a:	0792                	slli	a5,a5,0x4
     f0c:	fe843703          	ld	a4,-24(s0)
     f10:	97ba                	add	a5,a5,a4
     f12:	fe043703          	ld	a4,-32(s0)
     f16:	02f71563          	bne	a4,a5,f40 <free+0x102>
    p->s.size += bp->s.size;
     f1a:	fe843783          	ld	a5,-24(s0)
     f1e:	4798                	lw	a4,8(a5)
     f20:	fe043783          	ld	a5,-32(s0)
     f24:	479c                	lw	a5,8(a5)
     f26:	9fb9                	addw	a5,a5,a4
     f28:	0007871b          	sext.w	a4,a5
     f2c:	fe843783          	ld	a5,-24(s0)
     f30:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     f32:	fe043783          	ld	a5,-32(s0)
     f36:	6398                	ld	a4,0(a5)
     f38:	fe843783          	ld	a5,-24(s0)
     f3c:	e398                	sd	a4,0(a5)
     f3e:	a031                	j	f4a <free+0x10c>
  } else
    p->s.ptr = bp;
     f40:	fe843783          	ld	a5,-24(s0)
     f44:	fe043703          	ld	a4,-32(s0)
     f48:	e398                	sd	a4,0(a5)
  freep = p;
     f4a:	00001797          	auipc	a5,0x1
     f4e:	da678793          	addi	a5,a5,-602 # 1cf0 <freep>
     f52:	fe843703          	ld	a4,-24(s0)
     f56:	e398                	sd	a4,0(a5)
}
     f58:	0001                	nop
     f5a:	7422                	ld	s0,40(sp)
     f5c:	6145                	addi	sp,sp,48
     f5e:	8082                	ret

0000000000000f60 <morecore>:

static Header*
morecore(uint nu)
{
     f60:	7179                	addi	sp,sp,-48
     f62:	f406                	sd	ra,40(sp)
     f64:	f022                	sd	s0,32(sp)
     f66:	1800                	addi	s0,sp,48
     f68:	87aa                	mv	a5,a0
     f6a:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     f6e:	fdc42783          	lw	a5,-36(s0)
     f72:	0007871b          	sext.w	a4,a5
     f76:	6785                	lui	a5,0x1
     f78:	00f77563          	bgeu	a4,a5,f82 <morecore+0x22>
    nu = 4096;
     f7c:	6785                	lui	a5,0x1
     f7e:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     f82:	fdc42783          	lw	a5,-36(s0)
     f86:	0047979b          	slliw	a5,a5,0x4
     f8a:	2781                	sext.w	a5,a5
     f8c:	2781                	sext.w	a5,a5
     f8e:	853e                	mv	a0,a5
     f90:	00000097          	auipc	ra,0x0
     f94:	9a0080e7          	jalr	-1632(ra) # 930 <sbrk>
     f98:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     f9c:	fe843703          	ld	a4,-24(s0)
     fa0:	57fd                	li	a5,-1
     fa2:	00f71463          	bne	a4,a5,faa <morecore+0x4a>
    return 0;
     fa6:	4781                	li	a5,0
     fa8:	a03d                	j	fd6 <morecore+0x76>
  hp = (Header*)p;
     faa:	fe843783          	ld	a5,-24(s0)
     fae:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     fb2:	fe043783          	ld	a5,-32(s0)
     fb6:	fdc42703          	lw	a4,-36(s0)
     fba:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     fbc:	fe043783          	ld	a5,-32(s0)
     fc0:	07c1                	addi	a5,a5,16
     fc2:	853e                	mv	a0,a5
     fc4:	00000097          	auipc	ra,0x0
     fc8:	e7a080e7          	jalr	-390(ra) # e3e <free>
  return freep;
     fcc:	00001797          	auipc	a5,0x1
     fd0:	d2478793          	addi	a5,a5,-732 # 1cf0 <freep>
     fd4:	639c                	ld	a5,0(a5)
}
     fd6:	853e                	mv	a0,a5
     fd8:	70a2                	ld	ra,40(sp)
     fda:	7402                	ld	s0,32(sp)
     fdc:	6145                	addi	sp,sp,48
     fde:	8082                	ret

0000000000000fe0 <malloc>:

void*
malloc(uint nbytes)
{
     fe0:	7139                	addi	sp,sp,-64
     fe2:	fc06                	sd	ra,56(sp)
     fe4:	f822                	sd	s0,48(sp)
     fe6:	0080                	addi	s0,sp,64
     fe8:	87aa                	mv	a5,a0
     fea:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     fee:	fcc46783          	lwu	a5,-52(s0)
     ff2:	07bd                	addi	a5,a5,15
     ff4:	8391                	srli	a5,a5,0x4
     ff6:	2781                	sext.w	a5,a5
     ff8:	2785                	addiw	a5,a5,1
     ffa:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     ffe:	00001797          	auipc	a5,0x1
    1002:	cf278793          	addi	a5,a5,-782 # 1cf0 <freep>
    1006:	639c                	ld	a5,0(a5)
    1008:	fef43023          	sd	a5,-32(s0)
    100c:	fe043783          	ld	a5,-32(s0)
    1010:	ef95                	bnez	a5,104c <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    1012:	00001797          	auipc	a5,0x1
    1016:	cce78793          	addi	a5,a5,-818 # 1ce0 <base>
    101a:	fef43023          	sd	a5,-32(s0)
    101e:	00001797          	auipc	a5,0x1
    1022:	cd278793          	addi	a5,a5,-814 # 1cf0 <freep>
    1026:	fe043703          	ld	a4,-32(s0)
    102a:	e398                	sd	a4,0(a5)
    102c:	00001797          	auipc	a5,0x1
    1030:	cc478793          	addi	a5,a5,-828 # 1cf0 <freep>
    1034:	6398                	ld	a4,0(a5)
    1036:	00001797          	auipc	a5,0x1
    103a:	caa78793          	addi	a5,a5,-854 # 1ce0 <base>
    103e:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    1040:	00001797          	auipc	a5,0x1
    1044:	ca078793          	addi	a5,a5,-864 # 1ce0 <base>
    1048:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    104c:	fe043783          	ld	a5,-32(s0)
    1050:	639c                	ld	a5,0(a5)
    1052:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1056:	fe843783          	ld	a5,-24(s0)
    105a:	4798                	lw	a4,8(a5)
    105c:	fdc42783          	lw	a5,-36(s0)
    1060:	2781                	sext.w	a5,a5
    1062:	06f76863          	bltu	a4,a5,10d2 <malloc+0xf2>
      if(p->s.size == nunits)
    1066:	fe843783          	ld	a5,-24(s0)
    106a:	4798                	lw	a4,8(a5)
    106c:	fdc42783          	lw	a5,-36(s0)
    1070:	2781                	sext.w	a5,a5
    1072:	00e79963          	bne	a5,a4,1084 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    1076:	fe843783          	ld	a5,-24(s0)
    107a:	6398                	ld	a4,0(a5)
    107c:	fe043783          	ld	a5,-32(s0)
    1080:	e398                	sd	a4,0(a5)
    1082:	a82d                	j	10bc <malloc+0xdc>
      else {
        p->s.size -= nunits;
    1084:	fe843783          	ld	a5,-24(s0)
    1088:	4798                	lw	a4,8(a5)
    108a:	fdc42783          	lw	a5,-36(s0)
    108e:	40f707bb          	subw	a5,a4,a5
    1092:	0007871b          	sext.w	a4,a5
    1096:	fe843783          	ld	a5,-24(s0)
    109a:	c798                	sw	a4,8(a5)
        p += p->s.size;
    109c:	fe843783          	ld	a5,-24(s0)
    10a0:	479c                	lw	a5,8(a5)
    10a2:	1782                	slli	a5,a5,0x20
    10a4:	9381                	srli	a5,a5,0x20
    10a6:	0792                	slli	a5,a5,0x4
    10a8:	fe843703          	ld	a4,-24(s0)
    10ac:	97ba                	add	a5,a5,a4
    10ae:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    10b2:	fe843783          	ld	a5,-24(s0)
    10b6:	fdc42703          	lw	a4,-36(s0)
    10ba:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    10bc:	00001797          	auipc	a5,0x1
    10c0:	c3478793          	addi	a5,a5,-972 # 1cf0 <freep>
    10c4:	fe043703          	ld	a4,-32(s0)
    10c8:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    10ca:	fe843783          	ld	a5,-24(s0)
    10ce:	07c1                	addi	a5,a5,16
    10d0:	a091                	j	1114 <malloc+0x134>
    }
    if(p == freep)
    10d2:	00001797          	auipc	a5,0x1
    10d6:	c1e78793          	addi	a5,a5,-994 # 1cf0 <freep>
    10da:	639c                	ld	a5,0(a5)
    10dc:	fe843703          	ld	a4,-24(s0)
    10e0:	02f71063          	bne	a4,a5,1100 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
    10e4:	fdc42783          	lw	a5,-36(s0)
    10e8:	853e                	mv	a0,a5
    10ea:	00000097          	auipc	ra,0x0
    10ee:	e76080e7          	jalr	-394(ra) # f60 <morecore>
    10f2:	fea43423          	sd	a0,-24(s0)
    10f6:	fe843783          	ld	a5,-24(s0)
    10fa:	e399                	bnez	a5,1100 <malloc+0x120>
        return 0;
    10fc:	4781                	li	a5,0
    10fe:	a819                	j	1114 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1100:	fe843783          	ld	a5,-24(s0)
    1104:	fef43023          	sd	a5,-32(s0)
    1108:	fe843783          	ld	a5,-24(s0)
    110c:	639c                	ld	a5,0(a5)
    110e:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1112:	b791                	j	1056 <malloc+0x76>
  }
}
    1114:	853e                	mv	a0,a5
    1116:	70e2                	ld	ra,56(sp)
    1118:	7442                	ld	s0,48(sp)
    111a:	6121                	addi	sp,sp,64
    111c:	8082                	ret

000000000000111e <setjmp>:
    111e:	e100                	sd	s0,0(a0)
    1120:	e504                	sd	s1,8(a0)
    1122:	01253823          	sd	s2,16(a0)
    1126:	01353c23          	sd	s3,24(a0)
    112a:	03453023          	sd	s4,32(a0)
    112e:	03553423          	sd	s5,40(a0)
    1132:	03653823          	sd	s6,48(a0)
    1136:	03753c23          	sd	s7,56(a0)
    113a:	05853023          	sd	s8,64(a0)
    113e:	05953423          	sd	s9,72(a0)
    1142:	05a53823          	sd	s10,80(a0)
    1146:	05b53c23          	sd	s11,88(a0)
    114a:	06153023          	sd	ra,96(a0)
    114e:	06253423          	sd	sp,104(a0)
    1152:	4501                	li	a0,0
    1154:	8082                	ret

0000000000001156 <longjmp>:
    1156:	6100                	ld	s0,0(a0)
    1158:	6504                	ld	s1,8(a0)
    115a:	01053903          	ld	s2,16(a0)
    115e:	01853983          	ld	s3,24(a0)
    1162:	02053a03          	ld	s4,32(a0)
    1166:	02853a83          	ld	s5,40(a0)
    116a:	03053b03          	ld	s6,48(a0)
    116e:	03853b83          	ld	s7,56(a0)
    1172:	04053c03          	ld	s8,64(a0)
    1176:	04853c83          	ld	s9,72(a0)
    117a:	05053d03          	ld	s10,80(a0)
    117e:	05853d83          	ld	s11,88(a0)
    1182:	06053083          	ld	ra,96(a0)
    1186:	06853103          	ld	sp,104(a0)
    118a:	c199                	beqz	a1,1190 <longjmp_1>
    118c:	852e                	mv	a0,a1
    118e:	8082                	ret

0000000000001190 <longjmp_1>:
    1190:	4505                	li	a0,1
    1192:	8082                	ret

0000000000001194 <schedule_default>:
#define INT_MAX 2147483647
#define TIME_QUANTUM 2  // Define a base time quantum for the round-robin

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
    1194:	715d                	addi	sp,sp,-80
    1196:	e4a2                	sd	s0,72(sp)
    1198:	e0a6                	sd	s1,64(sp)
    119a:	0880                	addi	s0,sp,80
    119c:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
    119e:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
    11a2:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
    11a6:	649c                	ld	a5,8(s1)
    11a8:	639c                	ld	a5,0(a5)
    11aa:	fcf43c23          	sd	a5,-40(s0)
    11ae:	fd843783          	ld	a5,-40(s0)
    11b2:	fd878793          	addi	a5,a5,-40
    11b6:	fef43023          	sd	a5,-32(s0)
    11ba:	a81d                	j	11f0 <schedule_default+0x5c>
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
    11bc:	fe843783          	ld	a5,-24(s0)
    11c0:	cb89                	beqz	a5,11d2 <schedule_default+0x3e>
    11c2:	fe043783          	ld	a5,-32(s0)
    11c6:	5fd8                	lw	a4,60(a5)
    11c8:	fe843783          	ld	a5,-24(s0)
    11cc:	5fdc                	lw	a5,60(a5)
    11ce:	00f75663          	bge	a4,a5,11da <schedule_default+0x46>
            thread_with_smallest_id = th;
    11d2:	fe043783          	ld	a5,-32(s0)
    11d6:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
    11da:	fe043783          	ld	a5,-32(s0)
    11de:	779c                	ld	a5,40(a5)
    11e0:	fcf43823          	sd	a5,-48(s0)
    11e4:	fd043783          	ld	a5,-48(s0)
    11e8:	fd878793          	addi	a5,a5,-40
    11ec:	fef43023          	sd	a5,-32(s0)
    11f0:	fe043783          	ld	a5,-32(s0)
    11f4:	02878713          	addi	a4,a5,40
    11f8:	649c                	ld	a5,8(s1)
    11fa:	fcf711e3          	bne	a4,a5,11bc <schedule_default+0x28>
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
    11fe:	fe843783          	ld	a5,-24(s0)
    1202:	cf89                	beqz	a5,121c <schedule_default+0x88>
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
    1204:	fe843783          	ld	a5,-24(s0)
    1208:	02878793          	addi	a5,a5,40
    120c:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
    1210:	fe843783          	ld	a5,-24(s0)
    1214:	4fbc                	lw	a5,88(a5)
    1216:	faf42c23          	sw	a5,-72(s0)
    121a:	a039                	j	1228 <schedule_default+0x94>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
    121c:	649c                	ld	a5,8(s1)
    121e:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
    1222:	4785                	li	a5,1
    1224:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
    1228:	fb043783          	ld	a5,-80(s0)
    122c:	fcf43023          	sd	a5,-64(s0)
    1230:	fb843783          	ld	a5,-72(s0)
    1234:	fcf43423          	sd	a5,-56(s0)
    1238:	4701                	li	a4,0
    123a:	fc043703          	ld	a4,-64(s0)
    123e:	4781                	li	a5,0
    1240:	fc843783          	ld	a5,-56(s0)
    1244:	863a                	mv	a2,a4
    1246:	86be                	mv	a3,a5
    1248:	8732                	mv	a4,a2
    124a:	87b6                	mv	a5,a3
}
    124c:	853a                	mv	a0,a4
    124e:	85be                	mv	a1,a5
    1250:	6426                	ld	s0,72(sp)
    1252:	6486                	ld	s1,64(sp)
    1254:	6161                	addi	sp,sp,80
    1256:	8082                	ret

0000000000001258 <schedule_wrr>:

/* MP3 Part 1 - Non-Real-Time Scheduling */
/* Weighted-Round-Robin Scheduling */
struct threads_sched_result schedule_wrr(struct threads_sched_args args)
{
    1258:	7159                	addi	sp,sp,-112
    125a:	f4a2                	sd	s0,104(sp)
    125c:	f0a6                	sd	s1,96(sp)
    125e:	1880                	addi	s0,sp,112
    1260:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the weighted round-robin scheduling algorithm
    static struct thread *last_thread = NULL;
    struct thread *selected_thread = NULL;
    1262:	fe043423          	sd	zero,-24(s0)
    int max_priority = -1;
    1266:	57fd                	li	a5,-1
    1268:	fef42223          	sw	a5,-28(s0)

    // If last_thread is NULL or its remaining time is zero, reset the selection process
    if (last_thread == NULL || last_thread->remaining_time <= 0) {
    126c:	00001797          	auipc	a5,0x1
    1270:	a8c78793          	addi	a5,a5,-1396 # 1cf8 <last_thread.1226>
    1274:	639c                	ld	a5,0(a5)
    1276:	cb89                	beqz	a5,1288 <schedule_wrr+0x30>
    1278:	00001797          	auipc	a5,0x1
    127c:	a8078793          	addi	a5,a5,-1408 # 1cf8 <last_thread.1226>
    1280:	639c                	ld	a5,0(a5)
    1282:	4fbc                	lw	a5,88(a5)
    1284:	00f04863          	bgtz	a5,1294 <schedule_wrr+0x3c>
        last_thread = NULL;
    1288:	00001797          	auipc	a5,0x1
    128c:	a7078793          	addi	a5,a5,-1424 # 1cf8 <last_thread.1226>
    1290:	0007b023          	sd	zero,0(a5)
    }

    struct thread *candidate = NULL;
    1294:	fc043c23          	sd	zero,-40(s0)
    // Select the next thread to run based on weight and ensure round-robin fairness
    list_for_each_entry(candidate, args.run_queue, thread_list) {
    1298:	649c                	ld	a5,8(s1)
    129a:	639c                	ld	a5,0(a5)
    129c:	fcf43423          	sd	a5,-56(s0)
    12a0:	fc843783          	ld	a5,-56(s0)
    12a4:	fd878793          	addi	a5,a5,-40
    12a8:	fcf43c23          	sd	a5,-40(s0)
    12ac:	a8a1                	j	1304 <schedule_wrr+0xac>
        if (candidate != last_thread) {
    12ae:	00001797          	auipc	a5,0x1
    12b2:	a4a78793          	addi	a5,a5,-1462 # 1cf8 <last_thread.1226>
    12b6:	639c                	ld	a5,0(a5)
    12b8:	fd843703          	ld	a4,-40(s0)
    12bc:	02f70963          	beq	a4,a5,12ee <schedule_wrr+0x96>
            int priority = candidate->weight * TIME_QUANTUM;
    12c0:	fd843783          	ld	a5,-40(s0)
    12c4:	47bc                	lw	a5,72(a5)
    12c6:	0017979b          	slliw	a5,a5,0x1
    12ca:	fcf42223          	sw	a5,-60(s0)
            if (priority > max_priority) {
    12ce:	fc442703          	lw	a4,-60(s0)
    12d2:	fe442783          	lw	a5,-28(s0)
    12d6:	2701                	sext.w	a4,a4
    12d8:	2781                	sext.w	a5,a5
    12da:	00e7da63          	bge	a5,a4,12ee <schedule_wrr+0x96>
                selected_thread = candidate;
    12de:	fd843783          	ld	a5,-40(s0)
    12e2:	fef43423          	sd	a5,-24(s0)
                max_priority = priority;
    12e6:	fc442783          	lw	a5,-60(s0)
    12ea:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(candidate, args.run_queue, thread_list) {
    12ee:	fd843783          	ld	a5,-40(s0)
    12f2:	779c                	ld	a5,40(a5)
    12f4:	faf43c23          	sd	a5,-72(s0)
    12f8:	fb843783          	ld	a5,-72(s0)
    12fc:	fd878793          	addi	a5,a5,-40
    1300:	fcf43c23          	sd	a5,-40(s0)
    1304:	fd843783          	ld	a5,-40(s0)
    1308:	02878713          	addi	a4,a5,40
    130c:	649c                	ld	a5,8(s1)
    130e:	faf710e3          	bne	a4,a5,12ae <schedule_wrr+0x56>
            }
        }
    }

    // Fall back to the last_thread if no other thread is selected and it still has remaining time
    if (!selected_thread && last_thread && last_thread->remaining_time > 0) {
    1312:	fe843783          	ld	a5,-24(s0)
    1316:	e795                	bnez	a5,1342 <schedule_wrr+0xea>
    1318:	00001797          	auipc	a5,0x1
    131c:	9e078793          	addi	a5,a5,-1568 # 1cf8 <last_thread.1226>
    1320:	639c                	ld	a5,0(a5)
    1322:	c385                	beqz	a5,1342 <schedule_wrr+0xea>
    1324:	00001797          	auipc	a5,0x1
    1328:	9d478793          	addi	a5,a5,-1580 # 1cf8 <last_thread.1226>
    132c:	639c                	ld	a5,0(a5)
    132e:	4fbc                	lw	a5,88(a5)
    1330:	00f05963          	blez	a5,1342 <schedule_wrr+0xea>
        selected_thread = last_thread;
    1334:	00001797          	auipc	a5,0x1
    1338:	9c478793          	addi	a5,a5,-1596 # 1cf8 <last_thread.1226>
    133c:	639c                	ld	a5,0(a5)
    133e:	fef43423          	sd	a5,-24(s0)
    }

    // Set the scheduling result
    if (selected_thread) {
    1342:	fe843783          	ld	a5,-24(s0)
    1346:	c7b9                	beqz	a5,1394 <schedule_wrr+0x13c>
        int time_slice = selected_thread->weight * TIME_QUANTUM;
    1348:	fe843783          	ld	a5,-24(s0)
    134c:	47bc                	lw	a5,72(a5)
    134e:	0017979b          	slliw	a5,a5,0x1
    1352:	fcf42a23          	sw	a5,-44(s0)
        if (time_slice > selected_thread->remaining_time) {
    1356:	fe843783          	ld	a5,-24(s0)
    135a:	4fb8                	lw	a4,88(a5)
    135c:	fd442783          	lw	a5,-44(s0)
    1360:	2781                	sext.w	a5,a5
    1362:	00f75763          	bge	a4,a5,1370 <schedule_wrr+0x118>
            time_slice = selected_thread->remaining_time;
    1366:	fe843783          	ld	a5,-24(s0)
    136a:	4fbc                	lw	a5,88(a5)
    136c:	fcf42a23          	sw	a5,-44(s0)
        }
        r.scheduled_thread_list_member = &selected_thread->thread_list;
    1370:	fe843783          	ld	a5,-24(s0)
    1374:	02878793          	addi	a5,a5,40
    1378:	f8f43c23          	sd	a5,-104(s0)
        r.allocated_time = time_slice;
    137c:	fd442783          	lw	a5,-44(s0)
    1380:	faf42023          	sw	a5,-96(s0)
        last_thread = selected_thread;  // Update the last run thread
    1384:	00001797          	auipc	a5,0x1
    1388:	97478793          	addi	a5,a5,-1676 # 1cf8 <last_thread.1226>
    138c:	fe843703          	ld	a4,-24(s0)
    1390:	e398                	sd	a4,0(a5)
    1392:	a039                	j	13a0 <schedule_wrr+0x148>
    } else {
        // Idle if no suitable thread is found
        r.scheduled_thread_list_member = args.run_queue;
    1394:	649c                	ld	a5,8(s1)
    1396:	f8f43c23          	sd	a5,-104(s0)
        r.allocated_time = 1;
    139a:	4785                	li	a5,1
    139c:	faf42023          	sw	a5,-96(s0)
    }

    return r;
    13a0:	f9843783          	ld	a5,-104(s0)
    13a4:	faf43423          	sd	a5,-88(s0)
    13a8:	fa043783          	ld	a5,-96(s0)
    13ac:	faf43823          	sd	a5,-80(s0)
    13b0:	4701                	li	a4,0
    13b2:	fa843703          	ld	a4,-88(s0)
    13b6:	4781                	li	a5,0
    13b8:	fb043783          	ld	a5,-80(s0)
    13bc:	863a                	mv	a2,a4
    13be:	86be                	mv	a3,a5
    13c0:	8732                	mv	a4,a2
    13c2:	87b6                	mv	a5,a3
}
    13c4:	853a                	mv	a0,a4
    13c6:	85be                	mv	a1,a5
    13c8:	7426                	ld	s0,104(sp)
    13ca:	7486                	ld	s1,96(sp)
    13cc:	6165                	addi	sp,sp,112
    13ce:	8082                	ret

00000000000013d0 <find_next_release_time>:

/* Shortest-Job-First Scheduling */
int find_next_release_time(struct list_head *release_queue, int current_time) {
    13d0:	7139                	addi	sp,sp,-64
    13d2:	fc22                	sd	s0,56(sp)
    13d4:	0080                	addi	s0,sp,64
    13d6:	fca43423          	sd	a0,-56(s0)
    13da:	87ae                	mv	a5,a1
    13dc:	fcf42223          	sw	a5,-60(s0)
    struct release_queue_entry *next_release = NULL;
    13e0:	fe043423          	sd	zero,-24(s0)
    int next_release_time = INT_MAX;
    13e4:	800007b7          	lui	a5,0x80000
    13e8:	fff7c793          	not	a5,a5
    13ec:	fef42223          	sw	a5,-28(s0)

    list_for_each_entry(next_release, release_queue, thread_list) {
    13f0:	fc843783          	ld	a5,-56(s0)
    13f4:	639c                	ld	a5,0(a5)
    13f6:	fcf43c23          	sd	a5,-40(s0)
    13fa:	fd843783          	ld	a5,-40(s0)
    13fe:	17e1                	addi	a5,a5,-8
    1400:	fef43423          	sd	a5,-24(s0)
    1404:	a081                	j	1444 <find_next_release_time+0x74>
        if (next_release->release_time > current_time &&
    1406:	fe843783          	ld	a5,-24(s0)
    140a:	4f98                	lw	a4,24(a5)
    140c:	fc442783          	lw	a5,-60(s0)
    1410:	2781                	sext.w	a5,a5
    1412:	00e7df63          	bge	a5,a4,1430 <find_next_release_time+0x60>
            next_release->release_time < next_release_time) {
    1416:	fe843783          	ld	a5,-24(s0)
    141a:	4f98                	lw	a4,24(a5)
        if (next_release->release_time > current_time &&
    141c:	fe442783          	lw	a5,-28(s0)
    1420:	2781                	sext.w	a5,a5
    1422:	00f75763          	bge	a4,a5,1430 <find_next_release_time+0x60>
            next_release_time = next_release->release_time;
    1426:	fe843783          	ld	a5,-24(s0)
    142a:	4f9c                	lw	a5,24(a5)
    142c:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(next_release, release_queue, thread_list) {
    1430:	fe843783          	ld	a5,-24(s0)
    1434:	679c                	ld	a5,8(a5)
    1436:	fcf43823          	sd	a5,-48(s0)
    143a:	fd043783          	ld	a5,-48(s0)
    143e:	17e1                	addi	a5,a5,-8
    1440:	fef43423          	sd	a5,-24(s0)
    1444:	fe843783          	ld	a5,-24(s0)
    1448:	07a1                	addi	a5,a5,8
    144a:	fc843703          	ld	a4,-56(s0)
    144e:	faf71ce3          	bne	a4,a5,1406 <find_next_release_time+0x36>
        }
    }

    if (next_release_time == INT_MAX)
    1452:	fe442783          	lw	a5,-28(s0)
    1456:	0007871b          	sext.w	a4,a5
    145a:	800007b7          	lui	a5,0x80000
    145e:	fff7c793          	not	a5,a5
    1462:	00f71463          	bne	a4,a5,146a <find_next_release_time+0x9a>
        return -1; // No threads in the release queue
    1466:	57fd                	li	a5,-1
    1468:	a801                	j	1478 <find_next_release_time+0xa8>

    return next_release_time - current_time;
    146a:	fe442703          	lw	a4,-28(s0)
    146e:	fc442783          	lw	a5,-60(s0)
    1472:	40f707bb          	subw	a5,a4,a5
    1476:	2781                	sext.w	a5,a5
}
    1478:	853e                	mv	a0,a5
    147a:	7462                	ld	s0,56(sp)
    147c:	6121                	addi	sp,sp,64
    147e:	8082                	ret

0000000000001480 <schedule_sjf>:


struct threads_sched_result schedule_sjf(struct threads_sched_args args)
{
    1480:	711d                	addi	sp,sp,-96
    1482:	eca2                	sd	s0,88(sp)
    1484:	e8a6                	sd	s1,80(sp)
    1486:	1080                	addi	s0,sp,96
    1488:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the shortest-job-first scheduling algorithm
    struct thread *shortest_job = NULL;
    148a:	fe043423          	sd	zero,-24(s0)
    struct thread *t;
    int shortest_time = INT_MAX;
    148e:	800007b7          	lui	a5,0x80000
    1492:	fff7c793          	not	a5,a5
    1496:	fcf42e23          	sw	a5,-36(s0)

    // Find the thread with the shortest remaining time that is ready to run
    list_for_each_entry(t, args.run_queue, thread_list) {
    149a:	649c                	ld	a5,8(s1)
    149c:	639c                	ld	a5,0(a5)
    149e:	fcf43823          	sd	a5,-48(s0)
    14a2:	fd043783          	ld	a5,-48(s0)
    14a6:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffdf10>
    14aa:	fef43023          	sd	a5,-32(s0)
    14ae:	a82d                	j	14e8 <schedule_sjf+0x68>
        if (t->remaining_time < shortest_time) {
    14b0:	fe043783          	ld	a5,-32(s0)
    14b4:	4fb8                	lw	a4,88(a5)
    14b6:	fdc42783          	lw	a5,-36(s0)
    14ba:	2781                	sext.w	a5,a5
    14bc:	00f75b63          	bge	a4,a5,14d2 <schedule_sjf+0x52>
            shortest_time = t->remaining_time;
    14c0:	fe043783          	ld	a5,-32(s0)
    14c4:	4fbc                	lw	a5,88(a5)
    14c6:	fcf42e23          	sw	a5,-36(s0)
            shortest_job = t;
    14ca:	fe043783          	ld	a5,-32(s0)
    14ce:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    14d2:	fe043783          	ld	a5,-32(s0)
    14d6:	779c                	ld	a5,40(a5)
    14d8:	fcf43423          	sd	a5,-56(s0)
    14dc:	fc843783          	ld	a5,-56(s0)
    14e0:	fd878793          	addi	a5,a5,-40
    14e4:	fef43023          	sd	a5,-32(s0)
    14e8:	fe043783          	ld	a5,-32(s0)
    14ec:	02878713          	addi	a4,a5,40
    14f0:	649c                	ld	a5,8(s1)
    14f2:	faf71fe3          	bne	a4,a5,14b0 <schedule_sjf+0x30>
        }
    }

    if (shortest_job) {
    14f6:	fe843783          	ld	a5,-24(s0)
    14fa:	cf89                	beqz	a5,1514 <schedule_sjf+0x94>
        r.scheduled_thread_list_member = &shortest_job->thread_list;
    14fc:	fe843783          	ld	a5,-24(s0)
    1500:	02878793          	addi	a5,a5,40
    1504:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = shortest_job->remaining_time;  // Allow the thread to run to completion
    1508:	fe843783          	ld	a5,-24(s0)
    150c:	4fbc                	lw	a5,88(a5)
    150e:	faf42823          	sw	a5,-80(s0)
    1512:	a039                	j	1520 <schedule_sjf+0xa0>
    } else {
        // If no threads are ready, find the next release time or idle
        r.scheduled_thread_list_member = args.run_queue;
    1514:	649c                	ld	a5,8(s1)
    1516:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = 1;  // Default minimal quantum if unsure
    151a:	4785                	li	a5,1
    151c:	faf42823          	sw	a5,-80(s0)
    }
    return r;
    1520:	fa843783          	ld	a5,-88(s0)
    1524:	faf43c23          	sd	a5,-72(s0)
    1528:	fb043783          	ld	a5,-80(s0)
    152c:	fcf43023          	sd	a5,-64(s0)
    1530:	4701                	li	a4,0
    1532:	fb843703          	ld	a4,-72(s0)
    1536:	4781                	li	a5,0
    1538:	fc043783          	ld	a5,-64(s0)
    153c:	863a                	mv	a2,a4
    153e:	86be                	mv	a3,a5
    1540:	8732                	mv	a4,a2
    1542:	87b6                	mv	a5,a3
}
    1544:	853a                	mv	a0,a4
    1546:	85be                	mv	a1,a5
    1548:	6466                	ld	s0,88(sp)
    154a:	64c6                	ld	s1,80(sp)
    154c:	6125                	addi	sp,sp,96
    154e:	8082                	ret

0000000000001550 <schedule_lst>:

/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args)
{
    1550:	7119                	addi	sp,sp,-128
    1552:	fc86                	sd	ra,120(sp)
    1554:	f8a2                	sd	s0,112(sp)
    1556:	f4a6                	sd	s1,104(sp)
    1558:	f0ca                	sd	s2,96(sp)
    155a:	ecce                	sd	s3,88(sp)
    155c:	0100                	addi	s0,sp,128
    155e:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the least-slack-time scheduling algorithm
    struct thread *min_slack = NULL;
    1560:	fc043423          	sd	zero,-56(s0)
    int min_slack_time = INT_MAX;
    1564:	800007b7          	lui	a5,0x80000
    1568:	fff7c793          	not	a5,a5
    156c:	fcf42223          	sw	a5,-60(s0)
    struct thread *t;

    // Find the thread with the minimum slack time
    list_for_each_entry(t, args.run_queue, thread_list) {
    1570:	649c                	ld	a5,8(s1)
    1572:	639c                	ld	a5,0(a5)
    1574:	faf43823          	sd	a5,-80(s0)
    1578:	fb043783          	ld	a5,-80(s0)
    157c:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffdf10>
    1580:	faf43c23          	sd	a5,-72(s0)
    1584:	a8b5                	j	1600 <schedule_lst+0xb0>
        int slack_time = t->deadline - args.current_time - t->remaining_time;
    1586:	fb843783          	ld	a5,-72(s0)
    158a:	47f8                	lw	a4,76(a5)
    158c:	409c                	lw	a5,0(s1)
    158e:	40f707bb          	subw	a5,a4,a5
    1592:	0007871b          	sext.w	a4,a5
    1596:	fb843783          	ld	a5,-72(s0)
    159a:	4fbc                	lw	a5,88(a5)
    159c:	40f707bb          	subw	a5,a4,a5
    15a0:	faf42623          	sw	a5,-84(s0)
        if (min_slack == NULL || slack_time < min_slack_time ||
    15a4:	fc843783          	ld	a5,-56(s0)
    15a8:	cb8d                	beqz	a5,15da <schedule_lst+0x8a>
    15aa:	fac42703          	lw	a4,-84(s0)
    15ae:	fc442783          	lw	a5,-60(s0)
    15b2:	2701                	sext.w	a4,a4
    15b4:	2781                	sext.w	a5,a5
    15b6:	02f74263          	blt	a4,a5,15da <schedule_lst+0x8a>
    15ba:	fac42703          	lw	a4,-84(s0)
    15be:	fc442783          	lw	a5,-60(s0)
    15c2:	2701                	sext.w	a4,a4
    15c4:	2781                	sext.w	a5,a5
    15c6:	02f71263          	bne	a4,a5,15ea <schedule_lst+0x9a>
            (slack_time == min_slack_time && t->ID < min_slack->ID)) {
    15ca:	fb843783          	ld	a5,-72(s0)
    15ce:	5fd8                	lw	a4,60(a5)
    15d0:	fc843783          	ld	a5,-56(s0)
    15d4:	5fdc                	lw	a5,60(a5)
    15d6:	00f75a63          	bge	a4,a5,15ea <schedule_lst+0x9a>
            min_slack = t;
    15da:	fb843783          	ld	a5,-72(s0)
    15de:	fcf43423          	sd	a5,-56(s0)
            min_slack_time = slack_time;
    15e2:	fac42783          	lw	a5,-84(s0)
    15e6:	fcf42223          	sw	a5,-60(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    15ea:	fb843783          	ld	a5,-72(s0)
    15ee:	779c                	ld	a5,40(a5)
    15f0:	faf43023          	sd	a5,-96(s0)
    15f4:	fa043783          	ld	a5,-96(s0)
    15f8:	fd878793          	addi	a5,a5,-40
    15fc:	faf43c23          	sd	a5,-72(s0)
    1600:	fb843783          	ld	a5,-72(s0)
    1604:	02878713          	addi	a4,a5,40
    1608:	649c                	ld	a5,8(s1)
    160a:	f6f71ee3          	bne	a4,a5,1586 <schedule_lst+0x36>
        }
    }

    if (min_slack) {
    160e:	fc843783          	ld	a5,-56(s0)
    1612:	cf89                	beqz	a5,162c <schedule_lst+0xdc>
        r.scheduled_thread_list_member = &min_slack->thread_list;
    1614:	fc843783          	ld	a5,-56(s0)
    1618:	02878793          	addi	a5,a5,40
    161c:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = min_slack->remaining_time;
    1620:	fc843783          	ld	a5,-56(s0)
    1624:	4fbc                	lw	a5,88(a5)
    1626:	f8f42423          	sw	a5,-120(s0)
    162a:	a839                	j	1648 <schedule_lst+0xf8>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
    162c:	649c                	ld	a5,8(s1)
    162e:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    1632:	689c                	ld	a5,16(s1)
    1634:	4098                	lw	a4,0(s1)
    1636:	85ba                	mv	a1,a4
    1638:	853e                	mv	a0,a5
    163a:	00000097          	auipc	ra,0x0
    163e:	d96080e7          	jalr	-618(ra) # 13d0 <find_next_release_time>
    1642:	87aa                	mv	a5,a0
    1644:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    1648:	f8043783          	ld	a5,-128(s0)
    164c:	f8f43823          	sd	a5,-112(s0)
    1650:	f8843783          	ld	a5,-120(s0)
    1654:	f8f43c23          	sd	a5,-104(s0)
    1658:	4701                	li	a4,0
    165a:	f9043703          	ld	a4,-112(s0)
    165e:	4781                	li	a5,0
    1660:	f9843783          	ld	a5,-104(s0)
    1664:	893a                	mv	s2,a4
    1666:	89be                	mv	s3,a5
    1668:	874a                	mv	a4,s2
    166a:	87ce                	mv	a5,s3
}
    166c:	853a                	mv	a0,a4
    166e:	85be                	mv	a1,a5
    1670:	70e6                	ld	ra,120(sp)
    1672:	7446                	ld	s0,112(sp)
    1674:	74a6                	ld	s1,104(sp)
    1676:	7906                	ld	s2,96(sp)
    1678:	69e6                	ld	s3,88(sp)
    167a:	6109                	addi	sp,sp,128
    167c:	8082                	ret

000000000000167e <schedule_dm>:

/* Deadline-Monotonic Scheduling */
struct threads_sched_result schedule_dm(struct threads_sched_args args)
{
    167e:	7135                	addi	sp,sp,-160
    1680:	ed06                	sd	ra,152(sp)
    1682:	e922                	sd	s0,144(sp)
    1684:	e526                	sd	s1,136(sp)
    1686:	e14a                	sd	s2,128(sp)
    1688:	fcce                	sd	s3,120(sp)
    168a:	1100                	addi	s0,sp,160
    168c:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the deadline-monotonic scheduling algorithm
   struct thread *earliest_deadline_thread = NULL;
    168e:	fc043423          	sd	zero,-56(s0)
    struct thread *t;
    int earliest_deadline = INT_MAX;
    1692:	800007b7          	lui	a5,0x80000
    1696:	fff7c793          	not	a5,a5
    169a:	faf42e23          	sw	a5,-68(s0)

    // Find the earliest deadline real-time thread
    list_for_each_entry(t, args.run_queue, thread_list) {
    169e:	649c                	ld	a5,8(s1)
    16a0:	639c                	ld	a5,0(a5)
    16a2:	faf43423          	sd	a5,-88(s0)
    16a6:	fa843783          	ld	a5,-88(s0)
    16aa:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffdf10>
    16ae:	fcf43023          	sd	a5,-64(s0)
    16b2:	a841                	j	1742 <schedule_dm+0xc4>
        if (t->is_real_time && t->period != -1 && t->current_deadline < earliest_deadline) {
    16b4:	fc043783          	ld	a5,-64(s0)
    16b8:	43bc                	lw	a5,64(a5)
    16ba:	cb95                	beqz	a5,16ee <schedule_dm+0x70>
    16bc:	fc043783          	ld	a5,-64(s0)
    16c0:	4bbc                	lw	a5,80(a5)
    16c2:	873e                	mv	a4,a5
    16c4:	57fd                	li	a5,-1
    16c6:	02f70463          	beq	a4,a5,16ee <schedule_dm+0x70>
    16ca:	fc043783          	ld	a5,-64(s0)
    16ce:	4ff8                	lw	a4,92(a5)
    16d0:	fbc42783          	lw	a5,-68(s0)
    16d4:	2781                	sext.w	a5,a5
    16d6:	00f75c63          	bge	a4,a5,16ee <schedule_dm+0x70>
            earliest_deadline = t->current_deadline;
    16da:	fc043783          	ld	a5,-64(s0)
    16de:	4ffc                	lw	a5,92(a5)
    16e0:	faf42e23          	sw	a5,-68(s0)
            earliest_deadline_thread = t;
    16e4:	fc043783          	ld	a5,-64(s0)
    16e8:	fcf43423          	sd	a5,-56(s0)
    16ec:	a081                	j	172c <schedule_dm+0xae>
        } else if (t->is_real_time && t->period != -1 && t->current_deadline == earliest_deadline && t->ID < earliest_deadline_thread->ID) {
    16ee:	fc043783          	ld	a5,-64(s0)
    16f2:	43bc                	lw	a5,64(a5)
    16f4:	cf85                	beqz	a5,172c <schedule_dm+0xae>
    16f6:	fc043783          	ld	a5,-64(s0)
    16fa:	4bbc                	lw	a5,80(a5)
    16fc:	873e                	mv	a4,a5
    16fe:	57fd                	li	a5,-1
    1700:	02f70663          	beq	a4,a5,172c <schedule_dm+0xae>
    1704:	fc043783          	ld	a5,-64(s0)
    1708:	4ff8                	lw	a4,92(a5)
    170a:	fbc42783          	lw	a5,-68(s0)
    170e:	2781                	sext.w	a5,a5
    1710:	00e79e63          	bne	a5,a4,172c <schedule_dm+0xae>
    1714:	fc043783          	ld	a5,-64(s0)
    1718:	5fd8                	lw	a4,60(a5)
    171a:	fc843783          	ld	a5,-56(s0)
    171e:	5fdc                	lw	a5,60(a5)
    1720:	00f75663          	bge	a4,a5,172c <schedule_dm+0xae>
            earliest_deadline_thread = t;  // Tie-breaking by ID
    1724:	fc043783          	ld	a5,-64(s0)
    1728:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    172c:	fc043783          	ld	a5,-64(s0)
    1730:	779c                	ld	a5,40(a5)
    1732:	f8f43423          	sd	a5,-120(s0)
    1736:	f8843783          	ld	a5,-120(s0)
    173a:	fd878793          	addi	a5,a5,-40
    173e:	fcf43023          	sd	a5,-64(s0)
    1742:	fc043783          	ld	a5,-64(s0)
    1746:	02878713          	addi	a4,a5,40
    174a:	649c                	ld	a5,8(s1)
    174c:	f6f714e3          	bne	a4,a5,16b4 <schedule_dm+0x36>
        }
    }

    if (earliest_deadline_thread) {
    1750:	fc843783          	ld	a5,-56(s0)
    1754:	c7a5                	beqz	a5,17bc <schedule_dm+0x13e>
        int time_to_deadline = earliest_deadline_thread->current_deadline - args.current_time;
    1756:	fc843783          	ld	a5,-56(s0)
    175a:	4ff8                	lw	a4,92(a5)
    175c:	409c                	lw	a5,0(s1)
    175e:	40f707bb          	subw	a5,a4,a5
    1762:	f8f42a23          	sw	a5,-108(s0)
        if (earliest_deadline_thread->remaining_time > time_to_deadline) {
    1766:	fc843783          	ld	a5,-56(s0)
    176a:	4fb8                	lw	a4,88(a5)
    176c:	f9442783          	lw	a5,-108(s0)
    1770:	2781                	sext.w	a5,a5
    1772:	00e7db63          	bge	a5,a4,1788 <schedule_dm+0x10a>
            // The real-time thread cannot complete before its deadline, so handle the deadline miss
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    1776:	fc843783          	ld	a5,-56(s0)
    177a:	02878793          	addi	a5,a5,40
    177e:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = 0; // Could set to minimal quantum to allow cleanup or logging
    1782:	f6042823          	sw	zero,-144(s0)
    1786:	a0f1                	j	1852 <schedule_dm+0x1d4>
        } else {
            // Schedule the real-time thread normally if it hasn't missed its deadline
            int time_slice = (time_to_deadline < earliest_deadline_thread->remaining_time) ? time_to_deadline : earliest_deadline_thread->remaining_time;
    1788:	fc843783          	ld	a5,-56(s0)
    178c:	4fbc                	lw	a5,88(a5)
    178e:	863e                	mv	a2,a5
    1790:	f9442783          	lw	a5,-108(s0)
    1794:	0007869b          	sext.w	a3,a5
    1798:	0006071b          	sext.w	a4,a2
    179c:	00d75363          	bge	a4,a3,17a2 <schedule_dm+0x124>
    17a0:	87b2                	mv	a5,a2
    17a2:	f8f42823          	sw	a5,-112(s0)
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    17a6:	fc843783          	ld	a5,-56(s0)
    17aa:	02878793          	addi	a5,a5,40
    17ae:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = time_slice;
    17b2:	f9042783          	lw	a5,-112(s0)
    17b6:	f6f42823          	sw	a5,-144(s0)
    17ba:	a861                	j	1852 <schedule_dm+0x1d4>
        }
    } else {
        // If no real-time threads with a deadline are ready, find the thread with the smallest ID
        struct thread *smallest_id_thread = NULL;
    17bc:	fa043823          	sd	zero,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    17c0:	649c                	ld	a5,8(s1)
    17c2:	639c                	ld	a5,0(a5)
    17c4:	faf43023          	sd	a5,-96(s0)
    17c8:	fa043783          	ld	a5,-96(s0)
    17cc:	fd878793          	addi	a5,a5,-40
    17d0:	fcf43023          	sd	a5,-64(s0)
    17d4:	a81d                	j	180a <schedule_dm+0x18c>
            if (smallest_id_thread == NULL || t->ID < smallest_id_thread->ID) {
    17d6:	fb043783          	ld	a5,-80(s0)
    17da:	cb89                	beqz	a5,17ec <schedule_dm+0x16e>
    17dc:	fc043783          	ld	a5,-64(s0)
    17e0:	5fd8                	lw	a4,60(a5)
    17e2:	fb043783          	ld	a5,-80(s0)
    17e6:	5fdc                	lw	a5,60(a5)
    17e8:	00f75663          	bge	a4,a5,17f4 <schedule_dm+0x176>
                smallest_id_thread = t;
    17ec:	fc043783          	ld	a5,-64(s0)
    17f0:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    17f4:	fc043783          	ld	a5,-64(s0)
    17f8:	779c                	ld	a5,40(a5)
    17fa:	f8f43c23          	sd	a5,-104(s0)
    17fe:	f9843783          	ld	a5,-104(s0)
    1802:	fd878793          	addi	a5,a5,-40
    1806:	fcf43023          	sd	a5,-64(s0)
    180a:	fc043783          	ld	a5,-64(s0)
    180e:	02878713          	addi	a4,a5,40
    1812:	649c                	ld	a5,8(s1)
    1814:	fcf711e3          	bne	a4,a5,17d6 <schedule_dm+0x158>
            }
        }

        if (smallest_id_thread) {
    1818:	fb043783          	ld	a5,-80(s0)
    181c:	cf89                	beqz	a5,1836 <schedule_dm+0x1b8>
            r.scheduled_thread_list_member = &smallest_id_thread->thread_list;
    181e:	fb043783          	ld	a5,-80(s0)
    1822:	02878793          	addi	a5,a5,40
    1826:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = smallest_id_thread->remaining_time;
    182a:	fb043783          	ld	a5,-80(s0)
    182e:	4fbc                	lw	a5,88(a5)
    1830:	f6f42823          	sw	a5,-144(s0)
    1834:	a839                	j	1852 <schedule_dm+0x1d4>
        } else {
            // If no thread is ready, perhaps idle or find the next release time
            r.scheduled_thread_list_member = args.run_queue;
    1836:	649c                	ld	a5,8(s1)
    1838:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    183c:	689c                	ld	a5,16(s1)
    183e:	4098                	lw	a4,0(s1)
    1840:	85ba                	mv	a1,a4
    1842:	853e                	mv	a0,a5
    1844:	00000097          	auipc	ra,0x0
    1848:	b8c080e7          	jalr	-1140(ra) # 13d0 <find_next_release_time>
    184c:	87aa                	mv	a5,a0
    184e:	f6f42823          	sw	a5,-144(s0)
        }
    }

    return r;
    1852:	f6843783          	ld	a5,-152(s0)
    1856:	f6f43c23          	sd	a5,-136(s0)
    185a:	f7043783          	ld	a5,-144(s0)
    185e:	f8f43023          	sd	a5,-128(s0)
    1862:	4701                	li	a4,0
    1864:	f7843703          	ld	a4,-136(s0)
    1868:	4781                	li	a5,0
    186a:	f8043783          	ld	a5,-128(s0)
    186e:	893a                	mv	s2,a4
    1870:	89be                	mv	s3,a5
    1872:	874a                	mv	a4,s2
    1874:	87ce                	mv	a5,s3
}
    1876:	853a                	mv	a0,a4
    1878:	85be                	mv	a1,a5
    187a:	60ea                	ld	ra,152(sp)
    187c:	644a                	ld	s0,144(sp)
    187e:	64aa                	ld	s1,136(sp)
    1880:	690a                	ld	s2,128(sp)
    1882:	79e6                	ld	s3,120(sp)
    1884:	610d                	addi	sp,sp,160
    1886:	8082                	ret
