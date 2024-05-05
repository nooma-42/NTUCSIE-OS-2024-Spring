
user/_setjmp:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <setjmp>:
       0:	e100                	sd	s0,0(a0)
       2:	e504                	sd	s1,8(a0)
       4:	01253823          	sd	s2,16(a0)
       8:	01353c23          	sd	s3,24(a0)
       c:	03453023          	sd	s4,32(a0)
      10:	03553423          	sd	s5,40(a0)
      14:	03653823          	sd	s6,48(a0)
      18:	03753c23          	sd	s7,56(a0)
      1c:	05853023          	sd	s8,64(a0)
      20:	05953423          	sd	s9,72(a0)
      24:	05a53823          	sd	s10,80(a0)
      28:	05b53c23          	sd	s11,88(a0)
      2c:	06153023          	sd	ra,96(a0)
      30:	06253423          	sd	sp,104(a0)
      34:	4501                	li	a0,0
      36:	8082                	ret

0000000000000038 <longjmp>:
      38:	6100                	ld	s0,0(a0)
      3a:	6504                	ld	s1,8(a0)
      3c:	01053903          	ld	s2,16(a0)
      40:	01853983          	ld	s3,24(a0)
      44:	02053a03          	ld	s4,32(a0)
      48:	02853a83          	ld	s5,40(a0)
      4c:	03053b03          	ld	s6,48(a0)
      50:	03853b83          	ld	s7,56(a0)
      54:	04053c03          	ld	s8,64(a0)
      58:	04853c83          	ld	s9,72(a0)
      5c:	05053d03          	ld	s10,80(a0)
      60:	05853d83          	ld	s11,88(a0)
      64:	06053083          	ld	ra,96(a0)
      68:	06853103          	ld	sp,104(a0)
      6c:	c199                	beqz	a1,72 <longjmp_1>
      6e:	852e                	mv	a0,a1
      70:	8082                	ret

0000000000000072 <longjmp_1>:
      72:	4505                	li	a0,1
      74:	8082                	ret

0000000000000076 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
      76:	7179                	addi	sp,sp,-48
      78:	f422                	sd	s0,40(sp)
      7a:	1800                	addi	s0,sp,48
      7c:	fca43c23          	sd	a0,-40(s0)
      80:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
      84:	fd843783          	ld	a5,-40(s0)
      88:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
      8c:	0001                	nop
      8e:	fd043703          	ld	a4,-48(s0)
      92:	00170793          	addi	a5,a4,1
      96:	fcf43823          	sd	a5,-48(s0)
      9a:	fd843783          	ld	a5,-40(s0)
      9e:	00178693          	addi	a3,a5,1
      a2:	fcd43c23          	sd	a3,-40(s0)
      a6:	00074703          	lbu	a4,0(a4)
      aa:	00e78023          	sb	a4,0(a5)
      ae:	0007c783          	lbu	a5,0(a5)
      b2:	fff1                	bnez	a5,8e <strcpy+0x18>
    ;
  return os;
      b4:	fe843783          	ld	a5,-24(s0)
}
      b8:	853e                	mv	a0,a5
      ba:	7422                	ld	s0,40(sp)
      bc:	6145                	addi	sp,sp,48
      be:	8082                	ret

00000000000000c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      c0:	1101                	addi	sp,sp,-32
      c2:	ec22                	sd	s0,24(sp)
      c4:	1000                	addi	s0,sp,32
      c6:	fea43423          	sd	a0,-24(s0)
      ca:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
      ce:	a819                	j	e4 <strcmp+0x24>
    p++, q++;
      d0:	fe843783          	ld	a5,-24(s0)
      d4:	0785                	addi	a5,a5,1
      d6:	fef43423          	sd	a5,-24(s0)
      da:	fe043783          	ld	a5,-32(s0)
      de:	0785                	addi	a5,a5,1
      e0:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
      e4:	fe843783          	ld	a5,-24(s0)
      e8:	0007c783          	lbu	a5,0(a5)
      ec:	cb99                	beqz	a5,102 <strcmp+0x42>
      ee:	fe843783          	ld	a5,-24(s0)
      f2:	0007c703          	lbu	a4,0(a5)
      f6:	fe043783          	ld	a5,-32(s0)
      fa:	0007c783          	lbu	a5,0(a5)
      fe:	fcf709e3          	beq	a4,a5,d0 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     102:	fe843783          	ld	a5,-24(s0)
     106:	0007c783          	lbu	a5,0(a5)
     10a:	0007871b          	sext.w	a4,a5
     10e:	fe043783          	ld	a5,-32(s0)
     112:	0007c783          	lbu	a5,0(a5)
     116:	2781                	sext.w	a5,a5
     118:	40f707bb          	subw	a5,a4,a5
     11c:	2781                	sext.w	a5,a5
}
     11e:	853e                	mv	a0,a5
     120:	6462                	ld	s0,24(sp)
     122:	6105                	addi	sp,sp,32
     124:	8082                	ret

0000000000000126 <strlen>:

uint
strlen(const char *s)
{
     126:	7179                	addi	sp,sp,-48
     128:	f422                	sd	s0,40(sp)
     12a:	1800                	addi	s0,sp,48
     12c:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     130:	fe042623          	sw	zero,-20(s0)
     134:	a031                	j	140 <strlen+0x1a>
     136:	fec42783          	lw	a5,-20(s0)
     13a:	2785                	addiw	a5,a5,1
     13c:	fef42623          	sw	a5,-20(s0)
     140:	fec42783          	lw	a5,-20(s0)
     144:	fd843703          	ld	a4,-40(s0)
     148:	97ba                	add	a5,a5,a4
     14a:	0007c783          	lbu	a5,0(a5)
     14e:	f7e5                	bnez	a5,136 <strlen+0x10>
    ;
  return n;
     150:	fec42783          	lw	a5,-20(s0)
}
     154:	853e                	mv	a0,a5
     156:	7422                	ld	s0,40(sp)
     158:	6145                	addi	sp,sp,48
     15a:	8082                	ret

000000000000015c <memset>:

void*
memset(void *dst, int c, uint n)
{
     15c:	7179                	addi	sp,sp,-48
     15e:	f422                	sd	s0,40(sp)
     160:	1800                	addi	s0,sp,48
     162:	fca43c23          	sd	a0,-40(s0)
     166:	87ae                	mv	a5,a1
     168:	8732                	mv	a4,a2
     16a:	fcf42a23          	sw	a5,-44(s0)
     16e:	87ba                	mv	a5,a4
     170:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     174:	fd843783          	ld	a5,-40(s0)
     178:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     17c:	fe042623          	sw	zero,-20(s0)
     180:	a00d                	j	1a2 <memset+0x46>
    cdst[i] = c;
     182:	fec42783          	lw	a5,-20(s0)
     186:	fe043703          	ld	a4,-32(s0)
     18a:	97ba                	add	a5,a5,a4
     18c:	fd442703          	lw	a4,-44(s0)
     190:	0ff77713          	andi	a4,a4,255
     194:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     198:	fec42783          	lw	a5,-20(s0)
     19c:	2785                	addiw	a5,a5,1
     19e:	fef42623          	sw	a5,-20(s0)
     1a2:	fec42703          	lw	a4,-20(s0)
     1a6:	fd042783          	lw	a5,-48(s0)
     1aa:	2781                	sext.w	a5,a5
     1ac:	fcf76be3          	bltu	a4,a5,182 <memset+0x26>
  }
  return dst;
     1b0:	fd843783          	ld	a5,-40(s0)
}
     1b4:	853e                	mv	a0,a5
     1b6:	7422                	ld	s0,40(sp)
     1b8:	6145                	addi	sp,sp,48
     1ba:	8082                	ret

00000000000001bc <strchr>:

char*
strchr(const char *s, char c)
{
     1bc:	1101                	addi	sp,sp,-32
     1be:	ec22                	sd	s0,24(sp)
     1c0:	1000                	addi	s0,sp,32
     1c2:	fea43423          	sd	a0,-24(s0)
     1c6:	87ae                	mv	a5,a1
     1c8:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     1cc:	a01d                	j	1f2 <strchr+0x36>
    if(*s == c)
     1ce:	fe843783          	ld	a5,-24(s0)
     1d2:	0007c703          	lbu	a4,0(a5)
     1d6:	fe744783          	lbu	a5,-25(s0)
     1da:	0ff7f793          	andi	a5,a5,255
     1de:	00e79563          	bne	a5,a4,1e8 <strchr+0x2c>
      return (char*)s;
     1e2:	fe843783          	ld	a5,-24(s0)
     1e6:	a821                	j	1fe <strchr+0x42>
  for(; *s; s++)
     1e8:	fe843783          	ld	a5,-24(s0)
     1ec:	0785                	addi	a5,a5,1
     1ee:	fef43423          	sd	a5,-24(s0)
     1f2:	fe843783          	ld	a5,-24(s0)
     1f6:	0007c783          	lbu	a5,0(a5)
     1fa:	fbf1                	bnez	a5,1ce <strchr+0x12>
  return 0;
     1fc:	4781                	li	a5,0
}
     1fe:	853e                	mv	a0,a5
     200:	6462                	ld	s0,24(sp)
     202:	6105                	addi	sp,sp,32
     204:	8082                	ret

0000000000000206 <gets>:

char*
gets(char *buf, int max)
{
     206:	7179                	addi	sp,sp,-48
     208:	f406                	sd	ra,40(sp)
     20a:	f022                	sd	s0,32(sp)
     20c:	1800                	addi	s0,sp,48
     20e:	fca43c23          	sd	a0,-40(s0)
     212:	87ae                	mv	a5,a1
     214:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     218:	fe042623          	sw	zero,-20(s0)
     21c:	a8a1                	j	274 <gets+0x6e>
    cc = read(0, &c, 1);
     21e:	fe740793          	addi	a5,s0,-25
     222:	4605                	li	a2,1
     224:	85be                	mv	a1,a5
     226:	4501                	li	a0,0
     228:	00000097          	auipc	ra,0x0
     22c:	2f6080e7          	jalr	758(ra) # 51e <read>
     230:	87aa                	mv	a5,a0
     232:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     236:	fe842783          	lw	a5,-24(s0)
     23a:	2781                	sext.w	a5,a5
     23c:	04f05763          	blez	a5,28a <gets+0x84>
      break;
    buf[i++] = c;
     240:	fec42783          	lw	a5,-20(s0)
     244:	0017871b          	addiw	a4,a5,1
     248:	fee42623          	sw	a4,-20(s0)
     24c:	873e                	mv	a4,a5
     24e:	fd843783          	ld	a5,-40(s0)
     252:	97ba                	add	a5,a5,a4
     254:	fe744703          	lbu	a4,-25(s0)
     258:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     25c:	fe744783          	lbu	a5,-25(s0)
     260:	873e                	mv	a4,a5
     262:	47a9                	li	a5,10
     264:	02f70463          	beq	a4,a5,28c <gets+0x86>
     268:	fe744783          	lbu	a5,-25(s0)
     26c:	873e                	mv	a4,a5
     26e:	47b5                	li	a5,13
     270:	00f70e63          	beq	a4,a5,28c <gets+0x86>
  for(i=0; i+1 < max; ){
     274:	fec42783          	lw	a5,-20(s0)
     278:	2785                	addiw	a5,a5,1
     27a:	0007871b          	sext.w	a4,a5
     27e:	fd442783          	lw	a5,-44(s0)
     282:	2781                	sext.w	a5,a5
     284:	f8f74de3          	blt	a4,a5,21e <gets+0x18>
     288:	a011                	j	28c <gets+0x86>
      break;
     28a:	0001                	nop
      break;
  }
  buf[i] = '\0';
     28c:	fec42783          	lw	a5,-20(s0)
     290:	fd843703          	ld	a4,-40(s0)
     294:	97ba                	add	a5,a5,a4
     296:	00078023          	sb	zero,0(a5)
  return buf;
     29a:	fd843783          	ld	a5,-40(s0)
}
     29e:	853e                	mv	a0,a5
     2a0:	70a2                	ld	ra,40(sp)
     2a2:	7402                	ld	s0,32(sp)
     2a4:	6145                	addi	sp,sp,48
     2a6:	8082                	ret

00000000000002a8 <stat>:

int
stat(const char *n, struct stat *st)
{
     2a8:	7179                	addi	sp,sp,-48
     2aa:	f406                	sd	ra,40(sp)
     2ac:	f022                	sd	s0,32(sp)
     2ae:	1800                	addi	s0,sp,48
     2b0:	fca43c23          	sd	a0,-40(s0)
     2b4:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     2b8:	4581                	li	a1,0
     2ba:	fd843503          	ld	a0,-40(s0)
     2be:	00000097          	auipc	ra,0x0
     2c2:	288080e7          	jalr	648(ra) # 546 <open>
     2c6:	87aa                	mv	a5,a0
     2c8:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     2cc:	fec42783          	lw	a5,-20(s0)
     2d0:	2781                	sext.w	a5,a5
     2d2:	0007d463          	bgez	a5,2da <stat+0x32>
    return -1;
     2d6:	57fd                	li	a5,-1
     2d8:	a035                	j	304 <stat+0x5c>
  r = fstat(fd, st);
     2da:	fec42783          	lw	a5,-20(s0)
     2de:	fd043583          	ld	a1,-48(s0)
     2e2:	853e                	mv	a0,a5
     2e4:	00000097          	auipc	ra,0x0
     2e8:	27a080e7          	jalr	634(ra) # 55e <fstat>
     2ec:	87aa                	mv	a5,a0
     2ee:	fef42423          	sw	a5,-24(s0)
  close(fd);
     2f2:	fec42783          	lw	a5,-20(s0)
     2f6:	853e                	mv	a0,a5
     2f8:	00000097          	auipc	ra,0x0
     2fc:	236080e7          	jalr	566(ra) # 52e <close>
  return r;
     300:	fe842783          	lw	a5,-24(s0)
}
     304:	853e                	mv	a0,a5
     306:	70a2                	ld	ra,40(sp)
     308:	7402                	ld	s0,32(sp)
     30a:	6145                	addi	sp,sp,48
     30c:	8082                	ret

000000000000030e <atoi>:

int
atoi(const char *s)
{
     30e:	7179                	addi	sp,sp,-48
     310:	f422                	sd	s0,40(sp)
     312:	1800                	addi	s0,sp,48
     314:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     318:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     31c:	a815                	j	350 <atoi+0x42>
    n = n*10 + *s++ - '0';
     31e:	fec42703          	lw	a4,-20(s0)
     322:	87ba                	mv	a5,a4
     324:	0027979b          	slliw	a5,a5,0x2
     328:	9fb9                	addw	a5,a5,a4
     32a:	0017979b          	slliw	a5,a5,0x1
     32e:	0007871b          	sext.w	a4,a5
     332:	fd843783          	ld	a5,-40(s0)
     336:	00178693          	addi	a3,a5,1
     33a:	fcd43c23          	sd	a3,-40(s0)
     33e:	0007c783          	lbu	a5,0(a5)
     342:	2781                	sext.w	a5,a5
     344:	9fb9                	addw	a5,a5,a4
     346:	2781                	sext.w	a5,a5
     348:	fd07879b          	addiw	a5,a5,-48
     34c:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     350:	fd843783          	ld	a5,-40(s0)
     354:	0007c783          	lbu	a5,0(a5)
     358:	873e                	mv	a4,a5
     35a:	02f00793          	li	a5,47
     35e:	00e7fb63          	bgeu	a5,a4,374 <atoi+0x66>
     362:	fd843783          	ld	a5,-40(s0)
     366:	0007c783          	lbu	a5,0(a5)
     36a:	873e                	mv	a4,a5
     36c:	03900793          	li	a5,57
     370:	fae7f7e3          	bgeu	a5,a4,31e <atoi+0x10>
  return n;
     374:	fec42783          	lw	a5,-20(s0)
}
     378:	853e                	mv	a0,a5
     37a:	7422                	ld	s0,40(sp)
     37c:	6145                	addi	sp,sp,48
     37e:	8082                	ret

0000000000000380 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     380:	7139                	addi	sp,sp,-64
     382:	fc22                	sd	s0,56(sp)
     384:	0080                	addi	s0,sp,64
     386:	fca43c23          	sd	a0,-40(s0)
     38a:	fcb43823          	sd	a1,-48(s0)
     38e:	87b2                	mv	a5,a2
     390:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     394:	fd843783          	ld	a5,-40(s0)
     398:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     39c:	fd043783          	ld	a5,-48(s0)
     3a0:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     3a4:	fe043703          	ld	a4,-32(s0)
     3a8:	fe843783          	ld	a5,-24(s0)
     3ac:	02e7fc63          	bgeu	a5,a4,3e4 <memmove+0x64>
    while(n-- > 0)
     3b0:	a00d                	j	3d2 <memmove+0x52>
      *dst++ = *src++;
     3b2:	fe043703          	ld	a4,-32(s0)
     3b6:	00170793          	addi	a5,a4,1
     3ba:	fef43023          	sd	a5,-32(s0)
     3be:	fe843783          	ld	a5,-24(s0)
     3c2:	00178693          	addi	a3,a5,1
     3c6:	fed43423          	sd	a3,-24(s0)
     3ca:	00074703          	lbu	a4,0(a4)
     3ce:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     3d2:	fcc42783          	lw	a5,-52(s0)
     3d6:	fff7871b          	addiw	a4,a5,-1
     3da:	fce42623          	sw	a4,-52(s0)
     3de:	fcf04ae3          	bgtz	a5,3b2 <memmove+0x32>
     3e2:	a891                	j	436 <memmove+0xb6>
  } else {
    dst += n;
     3e4:	fcc42783          	lw	a5,-52(s0)
     3e8:	fe843703          	ld	a4,-24(s0)
     3ec:	97ba                	add	a5,a5,a4
     3ee:	fef43423          	sd	a5,-24(s0)
    src += n;
     3f2:	fcc42783          	lw	a5,-52(s0)
     3f6:	fe043703          	ld	a4,-32(s0)
     3fa:	97ba                	add	a5,a5,a4
     3fc:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     400:	a01d                	j	426 <memmove+0xa6>
      *--dst = *--src;
     402:	fe043783          	ld	a5,-32(s0)
     406:	17fd                	addi	a5,a5,-1
     408:	fef43023          	sd	a5,-32(s0)
     40c:	fe843783          	ld	a5,-24(s0)
     410:	17fd                	addi	a5,a5,-1
     412:	fef43423          	sd	a5,-24(s0)
     416:	fe043783          	ld	a5,-32(s0)
     41a:	0007c703          	lbu	a4,0(a5)
     41e:	fe843783          	ld	a5,-24(s0)
     422:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     426:	fcc42783          	lw	a5,-52(s0)
     42a:	fff7871b          	addiw	a4,a5,-1
     42e:	fce42623          	sw	a4,-52(s0)
     432:	fcf048e3          	bgtz	a5,402 <memmove+0x82>
  }
  return vdst;
     436:	fd843783          	ld	a5,-40(s0)
}
     43a:	853e                	mv	a0,a5
     43c:	7462                	ld	s0,56(sp)
     43e:	6121                	addi	sp,sp,64
     440:	8082                	ret

0000000000000442 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     442:	7139                	addi	sp,sp,-64
     444:	fc22                	sd	s0,56(sp)
     446:	0080                	addi	s0,sp,64
     448:	fca43c23          	sd	a0,-40(s0)
     44c:	fcb43823          	sd	a1,-48(s0)
     450:	87b2                	mv	a5,a2
     452:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     456:	fd843783          	ld	a5,-40(s0)
     45a:	fef43423          	sd	a5,-24(s0)
     45e:	fd043783          	ld	a5,-48(s0)
     462:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     466:	a0a1                	j	4ae <memcmp+0x6c>
    if (*p1 != *p2) {
     468:	fe843783          	ld	a5,-24(s0)
     46c:	0007c703          	lbu	a4,0(a5)
     470:	fe043783          	ld	a5,-32(s0)
     474:	0007c783          	lbu	a5,0(a5)
     478:	02f70163          	beq	a4,a5,49a <memcmp+0x58>
      return *p1 - *p2;
     47c:	fe843783          	ld	a5,-24(s0)
     480:	0007c783          	lbu	a5,0(a5)
     484:	0007871b          	sext.w	a4,a5
     488:	fe043783          	ld	a5,-32(s0)
     48c:	0007c783          	lbu	a5,0(a5)
     490:	2781                	sext.w	a5,a5
     492:	40f707bb          	subw	a5,a4,a5
     496:	2781                	sext.w	a5,a5
     498:	a01d                	j	4be <memcmp+0x7c>
    }
    p1++;
     49a:	fe843783          	ld	a5,-24(s0)
     49e:	0785                	addi	a5,a5,1
     4a0:	fef43423          	sd	a5,-24(s0)
    p2++;
     4a4:	fe043783          	ld	a5,-32(s0)
     4a8:	0785                	addi	a5,a5,1
     4aa:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     4ae:	fcc42783          	lw	a5,-52(s0)
     4b2:	fff7871b          	addiw	a4,a5,-1
     4b6:	fce42623          	sw	a4,-52(s0)
     4ba:	f7dd                	bnez	a5,468 <memcmp+0x26>
  }
  return 0;
     4bc:	4781                	li	a5,0
}
     4be:	853e                	mv	a0,a5
     4c0:	7462                	ld	s0,56(sp)
     4c2:	6121                	addi	sp,sp,64
     4c4:	8082                	ret

00000000000004c6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     4c6:	7179                	addi	sp,sp,-48
     4c8:	f406                	sd	ra,40(sp)
     4ca:	f022                	sd	s0,32(sp)
     4cc:	1800                	addi	s0,sp,48
     4ce:	fea43423          	sd	a0,-24(s0)
     4d2:	feb43023          	sd	a1,-32(s0)
     4d6:	87b2                	mv	a5,a2
     4d8:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     4dc:	fdc42783          	lw	a5,-36(s0)
     4e0:	863e                	mv	a2,a5
     4e2:	fe043583          	ld	a1,-32(s0)
     4e6:	fe843503          	ld	a0,-24(s0)
     4ea:	00000097          	auipc	ra,0x0
     4ee:	e96080e7          	jalr	-362(ra) # 380 <memmove>
     4f2:	87aa                	mv	a5,a0
}
     4f4:	853e                	mv	a0,a5
     4f6:	70a2                	ld	ra,40(sp)
     4f8:	7402                	ld	s0,32(sp)
     4fa:	6145                	addi	sp,sp,48
     4fc:	8082                	ret

00000000000004fe <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     4fe:	4885                	li	a7,1
 ecall
     500:	00000073          	ecall
 ret
     504:	8082                	ret

0000000000000506 <exit>:
.global exit
exit:
 li a7, SYS_exit
     506:	4889                	li	a7,2
 ecall
     508:	00000073          	ecall
 ret
     50c:	8082                	ret

000000000000050e <wait>:
.global wait
wait:
 li a7, SYS_wait
     50e:	488d                	li	a7,3
 ecall
     510:	00000073          	ecall
 ret
     514:	8082                	ret

0000000000000516 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     516:	4891                	li	a7,4
 ecall
     518:	00000073          	ecall
 ret
     51c:	8082                	ret

000000000000051e <read>:
.global read
read:
 li a7, SYS_read
     51e:	4895                	li	a7,5
 ecall
     520:	00000073          	ecall
 ret
     524:	8082                	ret

0000000000000526 <write>:
.global write
write:
 li a7, SYS_write
     526:	48c1                	li	a7,16
 ecall
     528:	00000073          	ecall
 ret
     52c:	8082                	ret

000000000000052e <close>:
.global close
close:
 li a7, SYS_close
     52e:	48d5                	li	a7,21
 ecall
     530:	00000073          	ecall
 ret
     534:	8082                	ret

0000000000000536 <kill>:
.global kill
kill:
 li a7, SYS_kill
     536:	4899                	li	a7,6
 ecall
     538:	00000073          	ecall
 ret
     53c:	8082                	ret

000000000000053e <exec>:
.global exec
exec:
 li a7, SYS_exec
     53e:	489d                	li	a7,7
 ecall
     540:	00000073          	ecall
 ret
     544:	8082                	ret

0000000000000546 <open>:
.global open
open:
 li a7, SYS_open
     546:	48bd                	li	a7,15
 ecall
     548:	00000073          	ecall
 ret
     54c:	8082                	ret

000000000000054e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     54e:	48c5                	li	a7,17
 ecall
     550:	00000073          	ecall
 ret
     554:	8082                	ret

0000000000000556 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     556:	48c9                	li	a7,18
 ecall
     558:	00000073          	ecall
 ret
     55c:	8082                	ret

000000000000055e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     55e:	48a1                	li	a7,8
 ecall
     560:	00000073          	ecall
 ret
     564:	8082                	ret

0000000000000566 <link>:
.global link
link:
 li a7, SYS_link
     566:	48cd                	li	a7,19
 ecall
     568:	00000073          	ecall
 ret
     56c:	8082                	ret

000000000000056e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     56e:	48d1                	li	a7,20
 ecall
     570:	00000073          	ecall
 ret
     574:	8082                	ret

0000000000000576 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     576:	48a5                	li	a7,9
 ecall
     578:	00000073          	ecall
 ret
     57c:	8082                	ret

000000000000057e <dup>:
.global dup
dup:
 li a7, SYS_dup
     57e:	48a9                	li	a7,10
 ecall
     580:	00000073          	ecall
 ret
     584:	8082                	ret

0000000000000586 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     586:	48ad                	li	a7,11
 ecall
     588:	00000073          	ecall
 ret
     58c:	8082                	ret

000000000000058e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     58e:	48b1                	li	a7,12
 ecall
     590:	00000073          	ecall
 ret
     594:	8082                	ret

0000000000000596 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     596:	48b5                	li	a7,13
 ecall
     598:	00000073          	ecall
 ret
     59c:	8082                	ret

000000000000059e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     59e:	48b9                	li	a7,14
 ecall
     5a0:	00000073          	ecall
 ret
     5a4:	8082                	ret

00000000000005a6 <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     5a6:	48d9                	li	a7,22
 ecall
     5a8:	00000073          	ecall
 ret
     5ac:	8082                	ret

00000000000005ae <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     5ae:	48dd                	li	a7,23
 ecall
     5b0:	00000073          	ecall
 ret
     5b4:	8082                	ret

00000000000005b6 <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     5b6:	48e1                	li	a7,24
 ecall
     5b8:	00000073          	ecall
 ret
     5bc:	8082                	ret

00000000000005be <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     5be:	1101                	addi	sp,sp,-32
     5c0:	ec06                	sd	ra,24(sp)
     5c2:	e822                	sd	s0,16(sp)
     5c4:	1000                	addi	s0,sp,32
     5c6:	87aa                	mv	a5,a0
     5c8:	872e                	mv	a4,a1
     5ca:	fef42623          	sw	a5,-20(s0)
     5ce:	87ba                	mv	a5,a4
     5d0:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     5d4:	feb40713          	addi	a4,s0,-21
     5d8:	fec42783          	lw	a5,-20(s0)
     5dc:	4605                	li	a2,1
     5de:	85ba                	mv	a1,a4
     5e0:	853e                	mv	a0,a5
     5e2:	00000097          	auipc	ra,0x0
     5e6:	f44080e7          	jalr	-188(ra) # 526 <write>
}
     5ea:	0001                	nop
     5ec:	60e2                	ld	ra,24(sp)
     5ee:	6442                	ld	s0,16(sp)
     5f0:	6105                	addi	sp,sp,32
     5f2:	8082                	ret

00000000000005f4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     5f4:	7139                	addi	sp,sp,-64
     5f6:	fc06                	sd	ra,56(sp)
     5f8:	f822                	sd	s0,48(sp)
     5fa:	0080                	addi	s0,sp,64
     5fc:	87aa                	mv	a5,a0
     5fe:	8736                	mv	a4,a3
     600:	fcf42623          	sw	a5,-52(s0)
     604:	87ae                	mv	a5,a1
     606:	fcf42423          	sw	a5,-56(s0)
     60a:	87b2                	mv	a5,a2
     60c:	fcf42223          	sw	a5,-60(s0)
     610:	87ba                	mv	a5,a4
     612:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     616:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     61a:	fc042783          	lw	a5,-64(s0)
     61e:	2781                	sext.w	a5,a5
     620:	c38d                	beqz	a5,642 <printint+0x4e>
     622:	fc842783          	lw	a5,-56(s0)
     626:	2781                	sext.w	a5,a5
     628:	0007dd63          	bgez	a5,642 <printint+0x4e>
    neg = 1;
     62c:	4785                	li	a5,1
     62e:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     632:	fc842783          	lw	a5,-56(s0)
     636:	40f007bb          	negw	a5,a5
     63a:	2781                	sext.w	a5,a5
     63c:	fef42223          	sw	a5,-28(s0)
     640:	a029                	j	64a <printint+0x56>
  } else {
    x = xx;
     642:	fc842783          	lw	a5,-56(s0)
     646:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     64a:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     64e:	fc442783          	lw	a5,-60(s0)
     652:	fe442703          	lw	a4,-28(s0)
     656:	02f777bb          	remuw	a5,a4,a5
     65a:	0007861b          	sext.w	a2,a5
     65e:	fec42783          	lw	a5,-20(s0)
     662:	0017871b          	addiw	a4,a5,1
     666:	fee42623          	sw	a4,-20(s0)
     66a:	00001697          	auipc	a3,0x1
     66e:	2d668693          	addi	a3,a3,726 # 1940 <digits>
     672:	02061713          	slli	a4,a2,0x20
     676:	9301                	srli	a4,a4,0x20
     678:	9736                	add	a4,a4,a3
     67a:	00074703          	lbu	a4,0(a4)
     67e:	ff040693          	addi	a3,s0,-16
     682:	97b6                	add	a5,a5,a3
     684:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     688:	fc442783          	lw	a5,-60(s0)
     68c:	fe442703          	lw	a4,-28(s0)
     690:	02f757bb          	divuw	a5,a4,a5
     694:	fef42223          	sw	a5,-28(s0)
     698:	fe442783          	lw	a5,-28(s0)
     69c:	2781                	sext.w	a5,a5
     69e:	fbc5                	bnez	a5,64e <printint+0x5a>
  if(neg)
     6a0:	fe842783          	lw	a5,-24(s0)
     6a4:	2781                	sext.w	a5,a5
     6a6:	cf95                	beqz	a5,6e2 <printint+0xee>
    buf[i++] = '-';
     6a8:	fec42783          	lw	a5,-20(s0)
     6ac:	0017871b          	addiw	a4,a5,1
     6b0:	fee42623          	sw	a4,-20(s0)
     6b4:	ff040713          	addi	a4,s0,-16
     6b8:	97ba                	add	a5,a5,a4
     6ba:	02d00713          	li	a4,45
     6be:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     6c2:	a005                	j	6e2 <printint+0xee>
    putc(fd, buf[i]);
     6c4:	fec42783          	lw	a5,-20(s0)
     6c8:	ff040713          	addi	a4,s0,-16
     6cc:	97ba                	add	a5,a5,a4
     6ce:	fe07c703          	lbu	a4,-32(a5)
     6d2:	fcc42783          	lw	a5,-52(s0)
     6d6:	85ba                	mv	a1,a4
     6d8:	853e                	mv	a0,a5
     6da:	00000097          	auipc	ra,0x0
     6de:	ee4080e7          	jalr	-284(ra) # 5be <putc>
  while(--i >= 0)
     6e2:	fec42783          	lw	a5,-20(s0)
     6e6:	37fd                	addiw	a5,a5,-1
     6e8:	fef42623          	sw	a5,-20(s0)
     6ec:	fec42783          	lw	a5,-20(s0)
     6f0:	2781                	sext.w	a5,a5
     6f2:	fc07d9e3          	bgez	a5,6c4 <printint+0xd0>
}
     6f6:	0001                	nop
     6f8:	0001                	nop
     6fa:	70e2                	ld	ra,56(sp)
     6fc:	7442                	ld	s0,48(sp)
     6fe:	6121                	addi	sp,sp,64
     700:	8082                	ret

0000000000000702 <printptr>:

static void
printptr(int fd, uint64 x) {
     702:	7179                	addi	sp,sp,-48
     704:	f406                	sd	ra,40(sp)
     706:	f022                	sd	s0,32(sp)
     708:	1800                	addi	s0,sp,48
     70a:	87aa                	mv	a5,a0
     70c:	fcb43823          	sd	a1,-48(s0)
     710:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     714:	fdc42783          	lw	a5,-36(s0)
     718:	03000593          	li	a1,48
     71c:	853e                	mv	a0,a5
     71e:	00000097          	auipc	ra,0x0
     722:	ea0080e7          	jalr	-352(ra) # 5be <putc>
  putc(fd, 'x');
     726:	fdc42783          	lw	a5,-36(s0)
     72a:	07800593          	li	a1,120
     72e:	853e                	mv	a0,a5
     730:	00000097          	auipc	ra,0x0
     734:	e8e080e7          	jalr	-370(ra) # 5be <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     738:	fe042623          	sw	zero,-20(s0)
     73c:	a82d                	j	776 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     73e:	fd043783          	ld	a5,-48(s0)
     742:	93f1                	srli	a5,a5,0x3c
     744:	00001717          	auipc	a4,0x1
     748:	1fc70713          	addi	a4,a4,508 # 1940 <digits>
     74c:	97ba                	add	a5,a5,a4
     74e:	0007c703          	lbu	a4,0(a5)
     752:	fdc42783          	lw	a5,-36(s0)
     756:	85ba                	mv	a1,a4
     758:	853e                	mv	a0,a5
     75a:	00000097          	auipc	ra,0x0
     75e:	e64080e7          	jalr	-412(ra) # 5be <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     762:	fec42783          	lw	a5,-20(s0)
     766:	2785                	addiw	a5,a5,1
     768:	fef42623          	sw	a5,-20(s0)
     76c:	fd043783          	ld	a5,-48(s0)
     770:	0792                	slli	a5,a5,0x4
     772:	fcf43823          	sd	a5,-48(s0)
     776:	fec42783          	lw	a5,-20(s0)
     77a:	873e                	mv	a4,a5
     77c:	47bd                	li	a5,15
     77e:	fce7f0e3          	bgeu	a5,a4,73e <printptr+0x3c>
}
     782:	0001                	nop
     784:	0001                	nop
     786:	70a2                	ld	ra,40(sp)
     788:	7402                	ld	s0,32(sp)
     78a:	6145                	addi	sp,sp,48
     78c:	8082                	ret

000000000000078e <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     78e:	715d                	addi	sp,sp,-80
     790:	e486                	sd	ra,72(sp)
     792:	e0a2                	sd	s0,64(sp)
     794:	0880                	addi	s0,sp,80
     796:	87aa                	mv	a5,a0
     798:	fcb43023          	sd	a1,-64(s0)
     79c:	fac43c23          	sd	a2,-72(s0)
     7a0:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     7a4:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     7a8:	fe042223          	sw	zero,-28(s0)
     7ac:	a42d                	j	9d6 <vprintf+0x248>
    c = fmt[i] & 0xff;
     7ae:	fe442783          	lw	a5,-28(s0)
     7b2:	fc043703          	ld	a4,-64(s0)
     7b6:	97ba                	add	a5,a5,a4
     7b8:	0007c783          	lbu	a5,0(a5)
     7bc:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     7c0:	fe042783          	lw	a5,-32(s0)
     7c4:	2781                	sext.w	a5,a5
     7c6:	eb9d                	bnez	a5,7fc <vprintf+0x6e>
      if(c == '%'){
     7c8:	fdc42783          	lw	a5,-36(s0)
     7cc:	0007871b          	sext.w	a4,a5
     7d0:	02500793          	li	a5,37
     7d4:	00f71763          	bne	a4,a5,7e2 <vprintf+0x54>
        state = '%';
     7d8:	02500793          	li	a5,37
     7dc:	fef42023          	sw	a5,-32(s0)
     7e0:	a2f5                	j	9cc <vprintf+0x23e>
      } else {
        putc(fd, c);
     7e2:	fdc42783          	lw	a5,-36(s0)
     7e6:	0ff7f713          	andi	a4,a5,255
     7ea:	fcc42783          	lw	a5,-52(s0)
     7ee:	85ba                	mv	a1,a4
     7f0:	853e                	mv	a0,a5
     7f2:	00000097          	auipc	ra,0x0
     7f6:	dcc080e7          	jalr	-564(ra) # 5be <putc>
     7fa:	aac9                	j	9cc <vprintf+0x23e>
      }
    } else if(state == '%'){
     7fc:	fe042783          	lw	a5,-32(s0)
     800:	0007871b          	sext.w	a4,a5
     804:	02500793          	li	a5,37
     808:	1cf71263          	bne	a4,a5,9cc <vprintf+0x23e>
      if(c == 'd'){
     80c:	fdc42783          	lw	a5,-36(s0)
     810:	0007871b          	sext.w	a4,a5
     814:	06400793          	li	a5,100
     818:	02f71463          	bne	a4,a5,840 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     81c:	fb843783          	ld	a5,-72(s0)
     820:	00878713          	addi	a4,a5,8
     824:	fae43c23          	sd	a4,-72(s0)
     828:	4398                	lw	a4,0(a5)
     82a:	fcc42783          	lw	a5,-52(s0)
     82e:	4685                	li	a3,1
     830:	4629                	li	a2,10
     832:	85ba                	mv	a1,a4
     834:	853e                	mv	a0,a5
     836:	00000097          	auipc	ra,0x0
     83a:	dbe080e7          	jalr	-578(ra) # 5f4 <printint>
     83e:	a269                	j	9c8 <vprintf+0x23a>
      } else if(c == 'l') {
     840:	fdc42783          	lw	a5,-36(s0)
     844:	0007871b          	sext.w	a4,a5
     848:	06c00793          	li	a5,108
     84c:	02f71663          	bne	a4,a5,878 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     850:	fb843783          	ld	a5,-72(s0)
     854:	00878713          	addi	a4,a5,8
     858:	fae43c23          	sd	a4,-72(s0)
     85c:	639c                	ld	a5,0(a5)
     85e:	0007871b          	sext.w	a4,a5
     862:	fcc42783          	lw	a5,-52(s0)
     866:	4681                	li	a3,0
     868:	4629                	li	a2,10
     86a:	85ba                	mv	a1,a4
     86c:	853e                	mv	a0,a5
     86e:	00000097          	auipc	ra,0x0
     872:	d86080e7          	jalr	-634(ra) # 5f4 <printint>
     876:	aa89                	j	9c8 <vprintf+0x23a>
      } else if(c == 'x') {
     878:	fdc42783          	lw	a5,-36(s0)
     87c:	0007871b          	sext.w	a4,a5
     880:	07800793          	li	a5,120
     884:	02f71463          	bne	a4,a5,8ac <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     888:	fb843783          	ld	a5,-72(s0)
     88c:	00878713          	addi	a4,a5,8
     890:	fae43c23          	sd	a4,-72(s0)
     894:	4398                	lw	a4,0(a5)
     896:	fcc42783          	lw	a5,-52(s0)
     89a:	4681                	li	a3,0
     89c:	4641                	li	a2,16
     89e:	85ba                	mv	a1,a4
     8a0:	853e                	mv	a0,a5
     8a2:	00000097          	auipc	ra,0x0
     8a6:	d52080e7          	jalr	-686(ra) # 5f4 <printint>
     8aa:	aa39                	j	9c8 <vprintf+0x23a>
      } else if(c == 'p') {
     8ac:	fdc42783          	lw	a5,-36(s0)
     8b0:	0007871b          	sext.w	a4,a5
     8b4:	07000793          	li	a5,112
     8b8:	02f71263          	bne	a4,a5,8dc <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     8bc:	fb843783          	ld	a5,-72(s0)
     8c0:	00878713          	addi	a4,a5,8
     8c4:	fae43c23          	sd	a4,-72(s0)
     8c8:	6398                	ld	a4,0(a5)
     8ca:	fcc42783          	lw	a5,-52(s0)
     8ce:	85ba                	mv	a1,a4
     8d0:	853e                	mv	a0,a5
     8d2:	00000097          	auipc	ra,0x0
     8d6:	e30080e7          	jalr	-464(ra) # 702 <printptr>
     8da:	a0fd                	j	9c8 <vprintf+0x23a>
      } else if(c == 's'){
     8dc:	fdc42783          	lw	a5,-36(s0)
     8e0:	0007871b          	sext.w	a4,a5
     8e4:	07300793          	li	a5,115
     8e8:	04f71c63          	bne	a4,a5,940 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     8ec:	fb843783          	ld	a5,-72(s0)
     8f0:	00878713          	addi	a4,a5,8
     8f4:	fae43c23          	sd	a4,-72(s0)
     8f8:	639c                	ld	a5,0(a5)
     8fa:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     8fe:	fe843783          	ld	a5,-24(s0)
     902:	eb8d                	bnez	a5,934 <vprintf+0x1a6>
          s = "(null)";
     904:	00001797          	auipc	a5,0x1
     908:	03478793          	addi	a5,a5,52 # 1938 <schedule_dm+0x1da>
     90c:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     910:	a015                	j	934 <vprintf+0x1a6>
          putc(fd, *s);
     912:	fe843783          	ld	a5,-24(s0)
     916:	0007c703          	lbu	a4,0(a5)
     91a:	fcc42783          	lw	a5,-52(s0)
     91e:	85ba                	mv	a1,a4
     920:	853e                	mv	a0,a5
     922:	00000097          	auipc	ra,0x0
     926:	c9c080e7          	jalr	-868(ra) # 5be <putc>
          s++;
     92a:	fe843783          	ld	a5,-24(s0)
     92e:	0785                	addi	a5,a5,1
     930:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     934:	fe843783          	ld	a5,-24(s0)
     938:	0007c783          	lbu	a5,0(a5)
     93c:	fbf9                	bnez	a5,912 <vprintf+0x184>
     93e:	a069                	j	9c8 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     940:	fdc42783          	lw	a5,-36(s0)
     944:	0007871b          	sext.w	a4,a5
     948:	06300793          	li	a5,99
     94c:	02f71463          	bne	a4,a5,974 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     950:	fb843783          	ld	a5,-72(s0)
     954:	00878713          	addi	a4,a5,8
     958:	fae43c23          	sd	a4,-72(s0)
     95c:	439c                	lw	a5,0(a5)
     95e:	0ff7f713          	andi	a4,a5,255
     962:	fcc42783          	lw	a5,-52(s0)
     966:	85ba                	mv	a1,a4
     968:	853e                	mv	a0,a5
     96a:	00000097          	auipc	ra,0x0
     96e:	c54080e7          	jalr	-940(ra) # 5be <putc>
     972:	a899                	j	9c8 <vprintf+0x23a>
      } else if(c == '%'){
     974:	fdc42783          	lw	a5,-36(s0)
     978:	0007871b          	sext.w	a4,a5
     97c:	02500793          	li	a5,37
     980:	00f71f63          	bne	a4,a5,99e <vprintf+0x210>
        putc(fd, c);
     984:	fdc42783          	lw	a5,-36(s0)
     988:	0ff7f713          	andi	a4,a5,255
     98c:	fcc42783          	lw	a5,-52(s0)
     990:	85ba                	mv	a1,a4
     992:	853e                	mv	a0,a5
     994:	00000097          	auipc	ra,0x0
     998:	c2a080e7          	jalr	-982(ra) # 5be <putc>
     99c:	a035                	j	9c8 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     99e:	fcc42783          	lw	a5,-52(s0)
     9a2:	02500593          	li	a1,37
     9a6:	853e                	mv	a0,a5
     9a8:	00000097          	auipc	ra,0x0
     9ac:	c16080e7          	jalr	-1002(ra) # 5be <putc>
        putc(fd, c);
     9b0:	fdc42783          	lw	a5,-36(s0)
     9b4:	0ff7f713          	andi	a4,a5,255
     9b8:	fcc42783          	lw	a5,-52(s0)
     9bc:	85ba                	mv	a1,a4
     9be:	853e                	mv	a0,a5
     9c0:	00000097          	auipc	ra,0x0
     9c4:	bfe080e7          	jalr	-1026(ra) # 5be <putc>
      }
      state = 0;
     9c8:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     9cc:	fe442783          	lw	a5,-28(s0)
     9d0:	2785                	addiw	a5,a5,1
     9d2:	fef42223          	sw	a5,-28(s0)
     9d6:	fe442783          	lw	a5,-28(s0)
     9da:	fc043703          	ld	a4,-64(s0)
     9de:	97ba                	add	a5,a5,a4
     9e0:	0007c783          	lbu	a5,0(a5)
     9e4:	dc0795e3          	bnez	a5,7ae <vprintf+0x20>
    }
  }
}
     9e8:	0001                	nop
     9ea:	0001                	nop
     9ec:	60a6                	ld	ra,72(sp)
     9ee:	6406                	ld	s0,64(sp)
     9f0:	6161                	addi	sp,sp,80
     9f2:	8082                	ret

00000000000009f4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     9f4:	7159                	addi	sp,sp,-112
     9f6:	fc06                	sd	ra,56(sp)
     9f8:	f822                	sd	s0,48(sp)
     9fa:	0080                	addi	s0,sp,64
     9fc:	fcb43823          	sd	a1,-48(s0)
     a00:	e010                	sd	a2,0(s0)
     a02:	e414                	sd	a3,8(s0)
     a04:	e818                	sd	a4,16(s0)
     a06:	ec1c                	sd	a5,24(s0)
     a08:	03043023          	sd	a6,32(s0)
     a0c:	03143423          	sd	a7,40(s0)
     a10:	87aa                	mv	a5,a0
     a12:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     a16:	03040793          	addi	a5,s0,48
     a1a:	fcf43423          	sd	a5,-56(s0)
     a1e:	fc843783          	ld	a5,-56(s0)
     a22:	fd078793          	addi	a5,a5,-48
     a26:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     a2a:	fe843703          	ld	a4,-24(s0)
     a2e:	fdc42783          	lw	a5,-36(s0)
     a32:	863a                	mv	a2,a4
     a34:	fd043583          	ld	a1,-48(s0)
     a38:	853e                	mv	a0,a5
     a3a:	00000097          	auipc	ra,0x0
     a3e:	d54080e7          	jalr	-684(ra) # 78e <vprintf>
}
     a42:	0001                	nop
     a44:	70e2                	ld	ra,56(sp)
     a46:	7442                	ld	s0,48(sp)
     a48:	6165                	addi	sp,sp,112
     a4a:	8082                	ret

0000000000000a4c <printf>:

void
printf(const char *fmt, ...)
{
     a4c:	7159                	addi	sp,sp,-112
     a4e:	f406                	sd	ra,40(sp)
     a50:	f022                	sd	s0,32(sp)
     a52:	1800                	addi	s0,sp,48
     a54:	fca43c23          	sd	a0,-40(s0)
     a58:	e40c                	sd	a1,8(s0)
     a5a:	e810                	sd	a2,16(s0)
     a5c:	ec14                	sd	a3,24(s0)
     a5e:	f018                	sd	a4,32(s0)
     a60:	f41c                	sd	a5,40(s0)
     a62:	03043823          	sd	a6,48(s0)
     a66:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     a6a:	04040793          	addi	a5,s0,64
     a6e:	fcf43823          	sd	a5,-48(s0)
     a72:	fd043783          	ld	a5,-48(s0)
     a76:	fc878793          	addi	a5,a5,-56
     a7a:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     a7e:	fe843783          	ld	a5,-24(s0)
     a82:	863e                	mv	a2,a5
     a84:	fd843583          	ld	a1,-40(s0)
     a88:	4505                	li	a0,1
     a8a:	00000097          	auipc	ra,0x0
     a8e:	d04080e7          	jalr	-764(ra) # 78e <vprintf>
}
     a92:	0001                	nop
     a94:	70a2                	ld	ra,40(sp)
     a96:	7402                	ld	s0,32(sp)
     a98:	6165                	addi	sp,sp,112
     a9a:	8082                	ret

0000000000000a9c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     a9c:	7179                	addi	sp,sp,-48
     a9e:	f422                	sd	s0,40(sp)
     aa0:	1800                	addi	s0,sp,48
     aa2:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     aa6:	fd843783          	ld	a5,-40(s0)
     aaa:	17c1                	addi	a5,a5,-16
     aac:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     ab0:	00001797          	auipc	a5,0x1
     ab4:	eb878793          	addi	a5,a5,-328 # 1968 <freep>
     ab8:	639c                	ld	a5,0(a5)
     aba:	fef43423          	sd	a5,-24(s0)
     abe:	a815                	j	af2 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     ac0:	fe843783          	ld	a5,-24(s0)
     ac4:	639c                	ld	a5,0(a5)
     ac6:	fe843703          	ld	a4,-24(s0)
     aca:	00f76f63          	bltu	a4,a5,ae8 <free+0x4c>
     ace:	fe043703          	ld	a4,-32(s0)
     ad2:	fe843783          	ld	a5,-24(s0)
     ad6:	02e7eb63          	bltu	a5,a4,b0c <free+0x70>
     ada:	fe843783          	ld	a5,-24(s0)
     ade:	639c                	ld	a5,0(a5)
     ae0:	fe043703          	ld	a4,-32(s0)
     ae4:	02f76463          	bltu	a4,a5,b0c <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     ae8:	fe843783          	ld	a5,-24(s0)
     aec:	639c                	ld	a5,0(a5)
     aee:	fef43423          	sd	a5,-24(s0)
     af2:	fe043703          	ld	a4,-32(s0)
     af6:	fe843783          	ld	a5,-24(s0)
     afa:	fce7f3e3          	bgeu	a5,a4,ac0 <free+0x24>
     afe:	fe843783          	ld	a5,-24(s0)
     b02:	639c                	ld	a5,0(a5)
     b04:	fe043703          	ld	a4,-32(s0)
     b08:	faf77ce3          	bgeu	a4,a5,ac0 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     b0c:	fe043783          	ld	a5,-32(s0)
     b10:	479c                	lw	a5,8(a5)
     b12:	1782                	slli	a5,a5,0x20
     b14:	9381                	srli	a5,a5,0x20
     b16:	0792                	slli	a5,a5,0x4
     b18:	fe043703          	ld	a4,-32(s0)
     b1c:	973e                	add	a4,a4,a5
     b1e:	fe843783          	ld	a5,-24(s0)
     b22:	639c                	ld	a5,0(a5)
     b24:	02f71763          	bne	a4,a5,b52 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     b28:	fe043783          	ld	a5,-32(s0)
     b2c:	4798                	lw	a4,8(a5)
     b2e:	fe843783          	ld	a5,-24(s0)
     b32:	639c                	ld	a5,0(a5)
     b34:	479c                	lw	a5,8(a5)
     b36:	9fb9                	addw	a5,a5,a4
     b38:	0007871b          	sext.w	a4,a5
     b3c:	fe043783          	ld	a5,-32(s0)
     b40:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     b42:	fe843783          	ld	a5,-24(s0)
     b46:	639c                	ld	a5,0(a5)
     b48:	6398                	ld	a4,0(a5)
     b4a:	fe043783          	ld	a5,-32(s0)
     b4e:	e398                	sd	a4,0(a5)
     b50:	a039                	j	b5e <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     b52:	fe843783          	ld	a5,-24(s0)
     b56:	6398                	ld	a4,0(a5)
     b58:	fe043783          	ld	a5,-32(s0)
     b5c:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     b5e:	fe843783          	ld	a5,-24(s0)
     b62:	479c                	lw	a5,8(a5)
     b64:	1782                	slli	a5,a5,0x20
     b66:	9381                	srli	a5,a5,0x20
     b68:	0792                	slli	a5,a5,0x4
     b6a:	fe843703          	ld	a4,-24(s0)
     b6e:	97ba                	add	a5,a5,a4
     b70:	fe043703          	ld	a4,-32(s0)
     b74:	02f71563          	bne	a4,a5,b9e <free+0x102>
    p->s.size += bp->s.size;
     b78:	fe843783          	ld	a5,-24(s0)
     b7c:	4798                	lw	a4,8(a5)
     b7e:	fe043783          	ld	a5,-32(s0)
     b82:	479c                	lw	a5,8(a5)
     b84:	9fb9                	addw	a5,a5,a4
     b86:	0007871b          	sext.w	a4,a5
     b8a:	fe843783          	ld	a5,-24(s0)
     b8e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     b90:	fe043783          	ld	a5,-32(s0)
     b94:	6398                	ld	a4,0(a5)
     b96:	fe843783          	ld	a5,-24(s0)
     b9a:	e398                	sd	a4,0(a5)
     b9c:	a031                	j	ba8 <free+0x10c>
  } else
    p->s.ptr = bp;
     b9e:	fe843783          	ld	a5,-24(s0)
     ba2:	fe043703          	ld	a4,-32(s0)
     ba6:	e398                	sd	a4,0(a5)
  freep = p;
     ba8:	00001797          	auipc	a5,0x1
     bac:	dc078793          	addi	a5,a5,-576 # 1968 <freep>
     bb0:	fe843703          	ld	a4,-24(s0)
     bb4:	e398                	sd	a4,0(a5)
}
     bb6:	0001                	nop
     bb8:	7422                	ld	s0,40(sp)
     bba:	6145                	addi	sp,sp,48
     bbc:	8082                	ret

0000000000000bbe <morecore>:

static Header*
morecore(uint nu)
{
     bbe:	7179                	addi	sp,sp,-48
     bc0:	f406                	sd	ra,40(sp)
     bc2:	f022                	sd	s0,32(sp)
     bc4:	1800                	addi	s0,sp,48
     bc6:	87aa                	mv	a5,a0
     bc8:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     bcc:	fdc42783          	lw	a5,-36(s0)
     bd0:	0007871b          	sext.w	a4,a5
     bd4:	6785                	lui	a5,0x1
     bd6:	00f77563          	bgeu	a4,a5,be0 <morecore+0x22>
    nu = 4096;
     bda:	6785                	lui	a5,0x1
     bdc:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     be0:	fdc42783          	lw	a5,-36(s0)
     be4:	0047979b          	slliw	a5,a5,0x4
     be8:	2781                	sext.w	a5,a5
     bea:	2781                	sext.w	a5,a5
     bec:	853e                	mv	a0,a5
     bee:	00000097          	auipc	ra,0x0
     bf2:	9a0080e7          	jalr	-1632(ra) # 58e <sbrk>
     bf6:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     bfa:	fe843703          	ld	a4,-24(s0)
     bfe:	57fd                	li	a5,-1
     c00:	00f71463          	bne	a4,a5,c08 <morecore+0x4a>
    return 0;
     c04:	4781                	li	a5,0
     c06:	a03d                	j	c34 <morecore+0x76>
  hp = (Header*)p;
     c08:	fe843783          	ld	a5,-24(s0)
     c0c:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     c10:	fe043783          	ld	a5,-32(s0)
     c14:	fdc42703          	lw	a4,-36(s0)
     c18:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     c1a:	fe043783          	ld	a5,-32(s0)
     c1e:	07c1                	addi	a5,a5,16
     c20:	853e                	mv	a0,a5
     c22:	00000097          	auipc	ra,0x0
     c26:	e7a080e7          	jalr	-390(ra) # a9c <free>
  return freep;
     c2a:	00001797          	auipc	a5,0x1
     c2e:	d3e78793          	addi	a5,a5,-706 # 1968 <freep>
     c32:	639c                	ld	a5,0(a5)
}
     c34:	853e                	mv	a0,a5
     c36:	70a2                	ld	ra,40(sp)
     c38:	7402                	ld	s0,32(sp)
     c3a:	6145                	addi	sp,sp,48
     c3c:	8082                	ret

0000000000000c3e <malloc>:

void*
malloc(uint nbytes)
{
     c3e:	7139                	addi	sp,sp,-64
     c40:	fc06                	sd	ra,56(sp)
     c42:	f822                	sd	s0,48(sp)
     c44:	0080                	addi	s0,sp,64
     c46:	87aa                	mv	a5,a0
     c48:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     c4c:	fcc46783          	lwu	a5,-52(s0)
     c50:	07bd                	addi	a5,a5,15
     c52:	8391                	srli	a5,a5,0x4
     c54:	2781                	sext.w	a5,a5
     c56:	2785                	addiw	a5,a5,1
     c58:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     c5c:	00001797          	auipc	a5,0x1
     c60:	d0c78793          	addi	a5,a5,-756 # 1968 <freep>
     c64:	639c                	ld	a5,0(a5)
     c66:	fef43023          	sd	a5,-32(s0)
     c6a:	fe043783          	ld	a5,-32(s0)
     c6e:	ef95                	bnez	a5,caa <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     c70:	00001797          	auipc	a5,0x1
     c74:	ce878793          	addi	a5,a5,-792 # 1958 <base>
     c78:	fef43023          	sd	a5,-32(s0)
     c7c:	00001797          	auipc	a5,0x1
     c80:	cec78793          	addi	a5,a5,-788 # 1968 <freep>
     c84:	fe043703          	ld	a4,-32(s0)
     c88:	e398                	sd	a4,0(a5)
     c8a:	00001797          	auipc	a5,0x1
     c8e:	cde78793          	addi	a5,a5,-802 # 1968 <freep>
     c92:	6398                	ld	a4,0(a5)
     c94:	00001797          	auipc	a5,0x1
     c98:	cc478793          	addi	a5,a5,-828 # 1958 <base>
     c9c:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     c9e:	00001797          	auipc	a5,0x1
     ca2:	cba78793          	addi	a5,a5,-838 # 1958 <base>
     ca6:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     caa:	fe043783          	ld	a5,-32(s0)
     cae:	639c                	ld	a5,0(a5)
     cb0:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     cb4:	fe843783          	ld	a5,-24(s0)
     cb8:	4798                	lw	a4,8(a5)
     cba:	fdc42783          	lw	a5,-36(s0)
     cbe:	2781                	sext.w	a5,a5
     cc0:	06f76863          	bltu	a4,a5,d30 <malloc+0xf2>
      if(p->s.size == nunits)
     cc4:	fe843783          	ld	a5,-24(s0)
     cc8:	4798                	lw	a4,8(a5)
     cca:	fdc42783          	lw	a5,-36(s0)
     cce:	2781                	sext.w	a5,a5
     cd0:	00e79963          	bne	a5,a4,ce2 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     cd4:	fe843783          	ld	a5,-24(s0)
     cd8:	6398                	ld	a4,0(a5)
     cda:	fe043783          	ld	a5,-32(s0)
     cde:	e398                	sd	a4,0(a5)
     ce0:	a82d                	j	d1a <malloc+0xdc>
      else {
        p->s.size -= nunits;
     ce2:	fe843783          	ld	a5,-24(s0)
     ce6:	4798                	lw	a4,8(a5)
     ce8:	fdc42783          	lw	a5,-36(s0)
     cec:	40f707bb          	subw	a5,a4,a5
     cf0:	0007871b          	sext.w	a4,a5
     cf4:	fe843783          	ld	a5,-24(s0)
     cf8:	c798                	sw	a4,8(a5)
        p += p->s.size;
     cfa:	fe843783          	ld	a5,-24(s0)
     cfe:	479c                	lw	a5,8(a5)
     d00:	1782                	slli	a5,a5,0x20
     d02:	9381                	srli	a5,a5,0x20
     d04:	0792                	slli	a5,a5,0x4
     d06:	fe843703          	ld	a4,-24(s0)
     d0a:	97ba                	add	a5,a5,a4
     d0c:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     d10:	fe843783          	ld	a5,-24(s0)
     d14:	fdc42703          	lw	a4,-36(s0)
     d18:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     d1a:	00001797          	auipc	a5,0x1
     d1e:	c4e78793          	addi	a5,a5,-946 # 1968 <freep>
     d22:	fe043703          	ld	a4,-32(s0)
     d26:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     d28:	fe843783          	ld	a5,-24(s0)
     d2c:	07c1                	addi	a5,a5,16
     d2e:	a091                	j	d72 <malloc+0x134>
    }
    if(p == freep)
     d30:	00001797          	auipc	a5,0x1
     d34:	c3878793          	addi	a5,a5,-968 # 1968 <freep>
     d38:	639c                	ld	a5,0(a5)
     d3a:	fe843703          	ld	a4,-24(s0)
     d3e:	02f71063          	bne	a4,a5,d5e <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     d42:	fdc42783          	lw	a5,-36(s0)
     d46:	853e                	mv	a0,a5
     d48:	00000097          	auipc	ra,0x0
     d4c:	e76080e7          	jalr	-394(ra) # bbe <morecore>
     d50:	fea43423          	sd	a0,-24(s0)
     d54:	fe843783          	ld	a5,-24(s0)
     d58:	e399                	bnez	a5,d5e <malloc+0x120>
        return 0;
     d5a:	4781                	li	a5,0
     d5c:	a819                	j	d72 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     d5e:	fe843783          	ld	a5,-24(s0)
     d62:	fef43023          	sd	a5,-32(s0)
     d66:	fe843783          	ld	a5,-24(s0)
     d6a:	639c                	ld	a5,0(a5)
     d6c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     d70:	b791                	j	cb4 <malloc+0x76>
  }
}
     d72:	853e                	mv	a0,a5
     d74:	70e2                	ld	ra,56(sp)
     d76:	7442                	ld	s0,48(sp)
     d78:	6121                	addi	sp,sp,64
     d7a:	8082                	ret

0000000000000d7c <schedule_default>:
#define INT_MAX 2147483647
#define TIME_QUANTUM 2  // Define a base time quantum for the round-robin

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
     d7c:	715d                	addi	sp,sp,-80
     d7e:	e4a2                	sd	s0,72(sp)
     d80:	e0a6                	sd	s1,64(sp)
     d82:	0880                	addi	s0,sp,80
     d84:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
     d86:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
     d8a:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     d8e:	649c                	ld	a5,8(s1)
     d90:	639c                	ld	a5,0(a5)
     d92:	fcf43c23          	sd	a5,-40(s0)
     d96:	fd843783          	ld	a5,-40(s0)
     d9a:	fd878793          	addi	a5,a5,-40
     d9e:	fef43023          	sd	a5,-32(s0)
     da2:	a81d                	j	dd8 <schedule_default+0x5c>
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
     da4:	fe843783          	ld	a5,-24(s0)
     da8:	cb89                	beqz	a5,dba <schedule_default+0x3e>
     daa:	fe043783          	ld	a5,-32(s0)
     dae:	5fd8                	lw	a4,60(a5)
     db0:	fe843783          	ld	a5,-24(s0)
     db4:	5fdc                	lw	a5,60(a5)
     db6:	00f75663          	bge	a4,a5,dc2 <schedule_default+0x46>
            thread_with_smallest_id = th;
     dba:	fe043783          	ld	a5,-32(s0)
     dbe:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
     dc2:	fe043783          	ld	a5,-32(s0)
     dc6:	779c                	ld	a5,40(a5)
     dc8:	fcf43823          	sd	a5,-48(s0)
     dcc:	fd043783          	ld	a5,-48(s0)
     dd0:	fd878793          	addi	a5,a5,-40
     dd4:	fef43023          	sd	a5,-32(s0)
     dd8:	fe043783          	ld	a5,-32(s0)
     ddc:	02878713          	addi	a4,a5,40
     de0:	649c                	ld	a5,8(s1)
     de2:	fcf711e3          	bne	a4,a5,da4 <schedule_default+0x28>
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
     de6:	fe843783          	ld	a5,-24(s0)
     dea:	cf89                	beqz	a5,e04 <schedule_default+0x88>
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
     dec:	fe843783          	ld	a5,-24(s0)
     df0:	02878793          	addi	a5,a5,40
     df4:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
     df8:	fe843783          	ld	a5,-24(s0)
     dfc:	4fbc                	lw	a5,88(a5)
     dfe:	faf42c23          	sw	a5,-72(s0)
     e02:	a039                	j	e10 <schedule_default+0x94>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
     e04:	649c                	ld	a5,8(s1)
     e06:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
     e0a:	4785                	li	a5,1
     e0c:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
     e10:	fb043783          	ld	a5,-80(s0)
     e14:	fcf43023          	sd	a5,-64(s0)
     e18:	fb843783          	ld	a5,-72(s0)
     e1c:	fcf43423          	sd	a5,-56(s0)
     e20:	4701                	li	a4,0
     e22:	fc043703          	ld	a4,-64(s0)
     e26:	4781                	li	a5,0
     e28:	fc843783          	ld	a5,-56(s0)
     e2c:	863a                	mv	a2,a4
     e2e:	86be                	mv	a3,a5
     e30:	8732                	mv	a4,a2
     e32:	87b6                	mv	a5,a3
}
     e34:	853a                	mv	a0,a4
     e36:	85be                	mv	a1,a5
     e38:	6426                	ld	s0,72(sp)
     e3a:	6486                	ld	s1,64(sp)
     e3c:	6161                	addi	sp,sp,80
     e3e:	8082                	ret

0000000000000e40 <find_next_release_time>:

int find_next_release_time(struct list_head *release_queue, int current_time) {
     e40:	7139                	addi	sp,sp,-64
     e42:	fc22                	sd	s0,56(sp)
     e44:	0080                	addi	s0,sp,64
     e46:	fca43423          	sd	a0,-56(s0)
     e4a:	87ae                	mv	a5,a1
     e4c:	fcf42223          	sw	a5,-60(s0)
    struct release_queue_entry *next_release = NULL;
     e50:	fe043423          	sd	zero,-24(s0)
    int next_release_time = INT_MAX;
     e54:	800007b7          	lui	a5,0x80000
     e58:	fff7c793          	not	a5,a5
     e5c:	fef42223          	sw	a5,-28(s0)

    list_for_each_entry(next_release, release_queue, thread_list) {
     e60:	fc843783          	ld	a5,-56(s0)
     e64:	639c                	ld	a5,0(a5)
     e66:	fcf43c23          	sd	a5,-40(s0)
     e6a:	fd843783          	ld	a5,-40(s0)
     e6e:	17e1                	addi	a5,a5,-8
     e70:	fef43423          	sd	a5,-24(s0)
     e74:	a081                	j	eb4 <find_next_release_time+0x74>
        if (next_release->release_time > current_time && next_release->release_time < next_release_time) {
     e76:	fe843783          	ld	a5,-24(s0)
     e7a:	4f98                	lw	a4,24(a5)
     e7c:	fc442783          	lw	a5,-60(s0)
     e80:	2781                	sext.w	a5,a5
     e82:	00e7df63          	bge	a5,a4,ea0 <find_next_release_time+0x60>
     e86:	fe843783          	ld	a5,-24(s0)
     e8a:	4f98                	lw	a4,24(a5)
     e8c:	fe442783          	lw	a5,-28(s0)
     e90:	2781                	sext.w	a5,a5
     e92:	00f75763          	bge	a4,a5,ea0 <find_next_release_time+0x60>
            next_release_time = next_release->release_time;
     e96:	fe843783          	ld	a5,-24(s0)
     e9a:	4f9c                	lw	a5,24(a5)
     e9c:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(next_release, release_queue, thread_list) {
     ea0:	fe843783          	ld	a5,-24(s0)
     ea4:	679c                	ld	a5,8(a5)
     ea6:	fcf43823          	sd	a5,-48(s0)
     eaa:	fd043783          	ld	a5,-48(s0)
     eae:	17e1                	addi	a5,a5,-8
     eb0:	fef43423          	sd	a5,-24(s0)
     eb4:	fe843783          	ld	a5,-24(s0)
     eb8:	07a1                	addi	a5,a5,8
     eba:	fc843703          	ld	a4,-56(s0)
     ebe:	faf71ce3          	bne	a4,a5,e76 <find_next_release_time+0x36>
        }
    }

    if (next_release_time == INT_MAX)
     ec2:	fe442783          	lw	a5,-28(s0)
     ec6:	0007871b          	sext.w	a4,a5
     eca:	800007b7          	lui	a5,0x80000
     ece:	fff7c793          	not	a5,a5
     ed2:	00f71463          	bne	a4,a5,eda <find_next_release_time+0x9a>
        return -1; // No threads in the release queue
     ed6:	57fd                	li	a5,-1
     ed8:	a801                	j	ee8 <find_next_release_time+0xa8>

    return next_release_time - current_time;
     eda:	fe442703          	lw	a4,-28(s0)
     ede:	fc442783          	lw	a5,-60(s0)
     ee2:	40f707bb          	subw	a5,a4,a5
     ee6:	2781                	sext.w	a5,a5
}
     ee8:	853e                	mv	a0,a5
     eea:	7462                	ld	s0,56(sp)
     eec:	6121                	addi	sp,sp,64
     eee:	8082                	ret

0000000000000ef0 <schedule_wrr>:

/* MP3 Part 1 - Non-Real-Time Scheduling */
/* Weighted-Round-Robin Scheduling */
struct threads_sched_result schedule_wrr(struct threads_sched_args args)
{
     ef0:	7119                	addi	sp,sp,-128
     ef2:	fc86                	sd	ra,120(sp)
     ef4:	f8a2                	sd	s0,112(sp)
     ef6:	f4a6                	sd	s1,104(sp)
     ef8:	f0ca                	sd	s2,96(sp)
     efa:	ecce                	sd	s3,88(sp)
     efc:	0100                	addi	s0,sp,128
     efe:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the weighted round-robin scheduling algorithm
    static struct thread *last_thread = NULL;
    struct thread *selected_thread = NULL;
     f00:	fc043423          	sd	zero,-56(s0)
    struct thread *candidate = NULL;
     f04:	fc043023          	sd	zero,-64(s0)

    // If last_thread is NULL or its remaining time is zero, reset the selection process
    if (last_thread == NULL || last_thread->remaining_time <= 0) {
     f08:	00001797          	auipc	a5,0x1
     f0c:	a6878793          	addi	a5,a5,-1432 # 1970 <last_thread.1239>
     f10:	639c                	ld	a5,0(a5)
     f12:	cb89                	beqz	a5,f24 <schedule_wrr+0x34>
     f14:	00001797          	auipc	a5,0x1
     f18:	a5c78793          	addi	a5,a5,-1444 # 1970 <last_thread.1239>
     f1c:	639c                	ld	a5,0(a5)
     f1e:	4fbc                	lw	a5,88(a5)
     f20:	00f04863          	bgtz	a5,f30 <schedule_wrr+0x40>
        last_thread = NULL;
     f24:	00001797          	auipc	a5,0x1
     f28:	a4c78793          	addi	a5,a5,-1460 # 1970 <last_thread.1239>
     f2c:	0007b023          	sd	zero,0(a5)
    }

    // Find the first thread that is ready to run
    list_for_each_entry(candidate, args.run_queue, thread_list) {
     f30:	649c                	ld	a5,8(s1)
     f32:	639c                	ld	a5,0(a5)
     f34:	faf43823          	sd	a5,-80(s0)
     f38:	fb043783          	ld	a5,-80(s0)
     f3c:	fd878793          	addi	a5,a5,-40
     f40:	fcf43023          	sd	a5,-64(s0)
     f44:	a0a9                	j	f8e <schedule_wrr+0x9e>
        if (!last_thread && candidate->remaining_time > 0)
     f46:	00001797          	auipc	a5,0x1
     f4a:	a2a78793          	addi	a5,a5,-1494 # 1970 <last_thread.1239>
     f4e:	639c                	ld	a5,0(a5)
     f50:	eb91                	bnez	a5,f64 <schedule_wrr+0x74>
     f52:	fc043783          	ld	a5,-64(s0)
     f56:	4fbc                	lw	a5,88(a5)
     f58:	00f05663          	blez	a5,f64 <schedule_wrr+0x74>
            selected_thread = candidate;
     f5c:	fc043783          	ld	a5,-64(s0)
     f60:	fcf43423          	sd	a5,-56(s0)
        if (candidate->remaining_time > 0) {
     f64:	fc043783          	ld	a5,-64(s0)
     f68:	4fbc                	lw	a5,88(a5)
     f6a:	00f05763          	blez	a5,f78 <schedule_wrr+0x88>
            selected_thread = candidate;
     f6e:	fc043783          	ld	a5,-64(s0)
     f72:	fcf43423          	sd	a5,-56(s0)
            break;
     f76:	a01d                	j	f9c <schedule_wrr+0xac>
    list_for_each_entry(candidate, args.run_queue, thread_list) {
     f78:	fc043783          	ld	a5,-64(s0)
     f7c:	779c                	ld	a5,40(a5)
     f7e:	faf43423          	sd	a5,-88(s0)
     f82:	fa843783          	ld	a5,-88(s0)
     f86:	fd878793          	addi	a5,a5,-40
     f8a:	fcf43023          	sd	a5,-64(s0)
     f8e:	fc043783          	ld	a5,-64(s0)
     f92:	02878713          	addi	a4,a5,40
     f96:	649c                	ld	a5,8(s1)
     f98:	faf717e3          	bne	a4,a5,f46 <schedule_wrr+0x56>
        }
    }

    // Fall back to the last_thread if no other thread is selected and it still has remaining time
    if (!selected_thread && last_thread && last_thread->remaining_time > 0) {
     f9c:	fc843783          	ld	a5,-56(s0)
     fa0:	e795                	bnez	a5,fcc <schedule_wrr+0xdc>
     fa2:	00001797          	auipc	a5,0x1
     fa6:	9ce78793          	addi	a5,a5,-1586 # 1970 <last_thread.1239>
     faa:	639c                	ld	a5,0(a5)
     fac:	c385                	beqz	a5,fcc <schedule_wrr+0xdc>
     fae:	00001797          	auipc	a5,0x1
     fb2:	9c278793          	addi	a5,a5,-1598 # 1970 <last_thread.1239>
     fb6:	639c                	ld	a5,0(a5)
     fb8:	4fbc                	lw	a5,88(a5)
     fba:	00f05963          	blez	a5,fcc <schedule_wrr+0xdc>
        selected_thread = last_thread;
     fbe:	00001797          	auipc	a5,0x1
     fc2:	9b278793          	addi	a5,a5,-1614 # 1970 <last_thread.1239>
     fc6:	639c                	ld	a5,0(a5)
     fc8:	fcf43423          	sd	a5,-56(s0)
    }

    // Set the scheduling result
    if (selected_thread) {
     fcc:	fc843783          	ld	a5,-56(s0)
     fd0:	c7b9                	beqz	a5,101e <schedule_wrr+0x12e>
        int time_slice = selected_thread->weight * TIME_QUANTUM;
     fd2:	fc843783          	ld	a5,-56(s0)
     fd6:	47bc                	lw	a5,72(a5)
     fd8:	0017979b          	slliw	a5,a5,0x1
     fdc:	faf42e23          	sw	a5,-68(s0)
        if (time_slice > selected_thread->remaining_time) {
     fe0:	fc843783          	ld	a5,-56(s0)
     fe4:	4fb8                	lw	a4,88(a5)
     fe6:	fbc42783          	lw	a5,-68(s0)
     fea:	2781                	sext.w	a5,a5
     fec:	00f75763          	bge	a4,a5,ffa <schedule_wrr+0x10a>
            time_slice = selected_thread->remaining_time;
     ff0:	fc843783          	ld	a5,-56(s0)
     ff4:	4fbc                	lw	a5,88(a5)
     ff6:	faf42e23          	sw	a5,-68(s0)
        }
        r.scheduled_thread_list_member = &selected_thread->thread_list;
     ffa:	fc843783          	ld	a5,-56(s0)
     ffe:	02878793          	addi	a5,a5,40
    1002:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = time_slice;
    1006:	fbc42783          	lw	a5,-68(s0)
    100a:	f8f42823          	sw	a5,-112(s0)
        last_thread = selected_thread;  // Update the last run thread
    100e:	00001797          	auipc	a5,0x1
    1012:	96278793          	addi	a5,a5,-1694 # 1970 <last_thread.1239>
    1016:	fc843703          	ld	a4,-56(s0)
    101a:	e398                	sd	a4,0(a5)
    101c:	a839                	j	103a <schedule_wrr+0x14a>
    } else {
        // Idle if no suitable thread is found
        r.scheduled_thread_list_member = args.run_queue;
    101e:	649c                	ld	a5,8(s1)
    1020:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    1024:	689c                	ld	a5,16(s1)
    1026:	4098                	lw	a4,0(s1)
    1028:	85ba                	mv	a1,a4
    102a:	853e                	mv	a0,a5
    102c:	00000097          	auipc	ra,0x0
    1030:	e14080e7          	jalr	-492(ra) # e40 <find_next_release_time>
    1034:	87aa                	mv	a5,a0
    1036:	f8f42823          	sw	a5,-112(s0)
    }

    return r;
    103a:	f8843783          	ld	a5,-120(s0)
    103e:	f8f43c23          	sd	a5,-104(s0)
    1042:	f9043783          	ld	a5,-112(s0)
    1046:	faf43023          	sd	a5,-96(s0)
    104a:	4701                	li	a4,0
    104c:	f9843703          	ld	a4,-104(s0)
    1050:	4781                	li	a5,0
    1052:	fa043783          	ld	a5,-96(s0)
    1056:	893a                	mv	s2,a4
    1058:	89be                	mv	s3,a5
    105a:	874a                	mv	a4,s2
    105c:	87ce                	mv	a5,s3
}
    105e:	853a                	mv	a0,a4
    1060:	85be                	mv	a1,a5
    1062:	70e6                	ld	ra,120(sp)
    1064:	7446                	ld	s0,112(sp)
    1066:	74a6                	ld	s1,104(sp)
    1068:	7906                	ld	s2,96(sp)
    106a:	69e6                	ld	s3,88(sp)
    106c:	6109                	addi	sp,sp,128
    106e:	8082                	ret

0000000000001070 <find_earliest_impactful_release_time>:


int find_earliest_impactful_release_time(struct list_head *release_queue, struct list_head *run_queue, int current_time) {
    1070:	7159                	addi	sp,sp,-112
    1072:	f4a2                	sd	s0,104(sp)
    1074:	1880                	addi	s0,sp,112
    1076:	faa43423          	sd	a0,-88(s0)
    107a:	fab43023          	sd	a1,-96(s0)
    107e:	87b2                	mv	a5,a2
    1080:	f8f42e23          	sw	a5,-100(s0)
    struct release_queue_entry *entry;
    int earliest_impactful_time = INT_MAX;
    1084:	800007b7          	lui	a5,0x80000
    1088:	fff7c793          	not	a5,a5
    108c:	fef42223          	sw	a5,-28(s0)
    int shortest_current_time = INT_MAX;
    1090:	800007b7          	lui	a5,0x80000
    1094:	fff7c793          	not	a5,a5
    1098:	fef42023          	sw	a5,-32(s0)
    // Find the shortest remaining time among currently running tasks
    struct thread *t;
    list_for_each_entry(t, run_queue, thread_list) {
    109c:	fa043783          	ld	a5,-96(s0)
    10a0:	639c                	ld	a5,0(a5)
    10a2:	fcf43823          	sd	a5,-48(s0)
    10a6:	fd043783          	ld	a5,-48(s0)
    10aa:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffde98>
    10ae:	fcf43c23          	sd	a5,-40(s0)
    10b2:	a80d                	j	10e4 <find_earliest_impactful_release_time+0x74>
        if (t->remaining_time < shortest_current_time) {
    10b4:	fd843783          	ld	a5,-40(s0)
    10b8:	4fb8                	lw	a4,88(a5)
    10ba:	fe042783          	lw	a5,-32(s0)
    10be:	2781                	sext.w	a5,a5
    10c0:	00f75763          	bge	a4,a5,10ce <find_earliest_impactful_release_time+0x5e>
            shortest_current_time = t->remaining_time;
    10c4:	fd843783          	ld	a5,-40(s0)
    10c8:	4fbc                	lw	a5,88(a5)
    10ca:	fef42023          	sw	a5,-32(s0)
    list_for_each_entry(t, run_queue, thread_list) {
    10ce:	fd843783          	ld	a5,-40(s0)
    10d2:	779c                	ld	a5,40(a5)
    10d4:	faf43c23          	sd	a5,-72(s0)
    10d8:	fb843783          	ld	a5,-72(s0)
    10dc:	fd878793          	addi	a5,a5,-40
    10e0:	fcf43c23          	sd	a5,-40(s0)
    10e4:	fd843783          	ld	a5,-40(s0)
    10e8:	02878793          	addi	a5,a5,40
    10ec:	fa043703          	ld	a4,-96(s0)
    10f0:	fcf712e3          	bne	a4,a5,10b4 <find_earliest_impactful_release_time+0x44>
        }
    }

    // Check the release queue for the next task that might preempt the current shortest job
    list_for_each_entry(entry, release_queue, thread_list) {
    10f4:	fa843783          	ld	a5,-88(s0)
    10f8:	639c                	ld	a5,0(a5)
    10fa:	fcf43423          	sd	a5,-56(s0)
    10fe:	fc843783          	ld	a5,-56(s0)
    1102:	17e1                	addi	a5,a5,-8
    1104:	fef43423          	sd	a5,-24(s0)
    1108:	a889                	j	115a <find_earliest_impactful_release_time+0xea>
        if (entry->release_time > current_time && entry->release_time < earliest_impactful_time) {
    110a:	fe843783          	ld	a5,-24(s0)
    110e:	4f98                	lw	a4,24(a5)
    1110:	f9c42783          	lw	a5,-100(s0)
    1114:	2781                	sext.w	a5,a5
    1116:	02e7d863          	bge	a5,a4,1146 <find_earliest_impactful_release_time+0xd6>
    111a:	fe843783          	ld	a5,-24(s0)
    111e:	4f98                	lw	a4,24(a5)
    1120:	fe442783          	lw	a5,-28(s0)
    1124:	2781                	sext.w	a5,a5
    1126:	02f75063          	bge	a4,a5,1146 <find_earliest_impactful_release_time+0xd6>
            if (entry->thrd->remaining_time < shortest_current_time) {
    112a:	fe843783          	ld	a5,-24(s0)
    112e:	639c                	ld	a5,0(a5)
    1130:	4fb8                	lw	a4,88(a5)
    1132:	fe042783          	lw	a5,-32(s0)
    1136:	2781                	sext.w	a5,a5
    1138:	00f75763          	bge	a4,a5,1146 <find_earliest_impactful_release_time+0xd6>
                earliest_impactful_time = entry->release_time;
    113c:	fe843783          	ld	a5,-24(s0)
    1140:	4f9c                	lw	a5,24(a5)
    1142:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(entry, release_queue, thread_list) {
    1146:	fe843783          	ld	a5,-24(s0)
    114a:	679c                	ld	a5,8(a5)
    114c:	fcf43023          	sd	a5,-64(s0)
    1150:	fc043783          	ld	a5,-64(s0)
    1154:	17e1                	addi	a5,a5,-8
    1156:	fef43423          	sd	a5,-24(s0)
    115a:	fe843783          	ld	a5,-24(s0)
    115e:	07a1                	addi	a5,a5,8
    1160:	fa843703          	ld	a4,-88(s0)
    1164:	faf713e3          	bne	a4,a5,110a <find_earliest_impactful_release_time+0x9a>
            }
        }
    }

    // Calculate the difference between the current time and the earliest impactful release time
    return earliest_impactful_time == INT_MAX ? -1 : earliest_impactful_time - current_time;
    1168:	fe442783          	lw	a5,-28(s0)
    116c:	0007871b          	sext.w	a4,a5
    1170:	800007b7          	lui	a5,0x80000
    1174:	fff7c793          	not	a5,a5
    1178:	00f70a63          	beq	a4,a5,118c <find_earliest_impactful_release_time+0x11c>
    117c:	fe442703          	lw	a4,-28(s0)
    1180:	f9c42783          	lw	a5,-100(s0)
    1184:	40f707bb          	subw	a5,a4,a5
    1188:	2781                	sext.w	a5,a5
    118a:	a011                	j	118e <find_earliest_impactful_release_time+0x11e>
    118c:	57fd                	li	a5,-1
}
    118e:	853e                	mv	a0,a5
    1190:	7426                	ld	s0,104(sp)
    1192:	6165                	addi	sp,sp,112
    1194:	8082                	ret

0000000000001196 <schedule_sjf>:


struct threads_sched_result schedule_sjf(struct threads_sched_args args) {
    1196:	7119                	addi	sp,sp,-128
    1198:	fc86                	sd	ra,120(sp)
    119a:	f8a2                	sd	s0,112(sp)
    119c:	f4a6                	sd	s1,104(sp)
    119e:	f0ca                	sd	s2,96(sp)
    11a0:	ecce                	sd	s3,88(sp)
    11a2:	0100                	addi	s0,sp,128
    11a4:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *shortest_job = NULL;
    11a6:	fc043423          	sd	zero,-56(s0)
    struct thread *current;
    int shortest_time = INT_MAX;
    11aa:	800007b7          	lui	a5,0x80000
    11ae:	fff7c793          	not	a5,a5
    11b2:	faf42e23          	sw	a5,-68(s0)
    int earliest_impactful_time = find_earliest_impactful_release_time(args.release_queue, args.run_queue, args.current_time);
    11b6:	689c                	ld	a5,16(s1)
    11b8:	6498                	ld	a4,8(s1)
    11ba:	4094                	lw	a3,0(s1)
    11bc:	8636                	mv	a2,a3
    11be:	85ba                	mv	a1,a4
    11c0:	853e                	mv	a0,a5
    11c2:	00000097          	auipc	ra,0x0
    11c6:	eae080e7          	jalr	-338(ra) # 1070 <find_earliest_impactful_release_time>
    11ca:	87aa                	mv	a5,a0
    11cc:	faf42a23          	sw	a5,-76(s0)

    // Determine the shortest job from the run queue
    list_for_each_entry(current, args.run_queue, thread_list) {
    11d0:	649c                	ld	a5,8(s1)
    11d2:	639c                	ld	a5,0(a5)
    11d4:	faf43423          	sd	a5,-88(s0)
    11d8:	fa843783          	ld	a5,-88(s0)
    11dc:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffde98>
    11e0:	fcf43023          	sd	a5,-64(s0)
    11e4:	a82d                	j	121e <schedule_sjf+0x88>
        if (current->remaining_time < shortest_time) {
    11e6:	fc043783          	ld	a5,-64(s0)
    11ea:	4fb8                	lw	a4,88(a5)
    11ec:	fbc42783          	lw	a5,-68(s0)
    11f0:	2781                	sext.w	a5,a5
    11f2:	00f75b63          	bge	a4,a5,1208 <schedule_sjf+0x72>
            shortest_time = current->remaining_time;
    11f6:	fc043783          	ld	a5,-64(s0)
    11fa:	4fbc                	lw	a5,88(a5)
    11fc:	faf42e23          	sw	a5,-68(s0)
            shortest_job = current;
    1200:	fc043783          	ld	a5,-64(s0)
    1204:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(current, args.run_queue, thread_list) {
    1208:	fc043783          	ld	a5,-64(s0)
    120c:	779c                	ld	a5,40(a5)
    120e:	faf43023          	sd	a5,-96(s0)
    1212:	fa043783          	ld	a5,-96(s0)
    1216:	fd878793          	addi	a5,a5,-40
    121a:	fcf43023          	sd	a5,-64(s0)
    121e:	fc043783          	ld	a5,-64(s0)
    1222:	02878713          	addi	a4,a5,40
    1226:	649c                	ld	a5,8(s1)
    1228:	faf71fe3          	bne	a4,a5,11e6 <schedule_sjf+0x50>
        }
    }

    if (shortest_job) {
    122c:	fc843783          	ld	a5,-56(s0)
    1230:	c7a1                	beqz	a5,1278 <schedule_sjf+0xe2>
        int time_to_allocate = shortest_job->remaining_time;
    1232:	fc843783          	ld	a5,-56(s0)
    1236:	4fbc                	lw	a5,88(a5)
    1238:	faf42c23          	sw	a5,-72(s0)
        // Reduce the time slice if an impactful task is arriving sooner
        if (earliest_impactful_time != -1 && earliest_impactful_time < time_to_allocate) {
    123c:	fb442783          	lw	a5,-76(s0)
    1240:	0007871b          	sext.w	a4,a5
    1244:	57fd                	li	a5,-1
    1246:	00f70e63          	beq	a4,a5,1262 <schedule_sjf+0xcc>
    124a:	fb442703          	lw	a4,-76(s0)
    124e:	fb842783          	lw	a5,-72(s0)
    1252:	2701                	sext.w	a4,a4
    1254:	2781                	sext.w	a5,a5
    1256:	00f75663          	bge	a4,a5,1262 <schedule_sjf+0xcc>
            time_to_allocate = earliest_impactful_time;
    125a:	fb442783          	lw	a5,-76(s0)
    125e:	faf42c23          	sw	a5,-72(s0)
        }

        r.scheduled_thread_list_member = &shortest_job->thread_list;
    1262:	fc843783          	ld	a5,-56(s0)
    1266:	02878793          	addi	a5,a5,40
    126a:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = time_to_allocate;
    126e:	fb842783          	lw	a5,-72(s0)
    1272:	f8f42423          	sw	a5,-120(s0)
    1276:	a80d                	j	12a8 <schedule_sjf+0x112>
    } else {
        // If no current tasks are ready, wait for the next impactful task
        r.scheduled_thread_list_member = args.run_queue;
    1278:	649c                	ld	a5,8(s1)
    127a:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = earliest_impactful_time != -1 ? earliest_impactful_time : find_next_release_time(args.release_queue, args.current_time);
    127e:	fb442783          	lw	a5,-76(s0)
    1282:	0007871b          	sext.w	a4,a5
    1286:	57fd                	li	a5,-1
    1288:	00f71c63          	bne	a4,a5,12a0 <schedule_sjf+0x10a>
    128c:	689c                	ld	a5,16(s1)
    128e:	4098                	lw	a4,0(s1)
    1290:	85ba                	mv	a1,a4
    1292:	853e                	mv	a0,a5
    1294:	00000097          	auipc	ra,0x0
    1298:	bac080e7          	jalr	-1108(ra) # e40 <find_next_release_time>
    129c:	87aa                	mv	a5,a0
    129e:	a019                	j	12a4 <schedule_sjf+0x10e>
    12a0:	fb442783          	lw	a5,-76(s0)
    12a4:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    12a8:	f8043783          	ld	a5,-128(s0)
    12ac:	f8f43823          	sd	a5,-112(s0)
    12b0:	f8843783          	ld	a5,-120(s0)
    12b4:	f8f43c23          	sd	a5,-104(s0)
    12b8:	4701                	li	a4,0
    12ba:	f9043703          	ld	a4,-112(s0)
    12be:	4781                	li	a5,0
    12c0:	f9843783          	ld	a5,-104(s0)
    12c4:	893a                	mv	s2,a4
    12c6:	89be                	mv	s3,a5
    12c8:	874a                	mv	a4,s2
    12ca:	87ce                	mv	a5,s3
}
    12cc:	853a                	mv	a0,a4
    12ce:	85be                	mv	a1,a5
    12d0:	70e6                	ld	ra,120(sp)
    12d2:	7446                	ld	s0,112(sp)
    12d4:	74a6                	ld	s1,104(sp)
    12d6:	7906                	ld	s2,96(sp)
    12d8:	69e6                	ld	s3,88(sp)
    12da:	6109                	addi	sp,sp,128
    12dc:	8082                	ret

00000000000012de <min>:

int min(int a, int b) {
    12de:	1101                	addi	sp,sp,-32
    12e0:	ec22                	sd	s0,24(sp)
    12e2:	1000                	addi	s0,sp,32
    12e4:	87aa                	mv	a5,a0
    12e6:	872e                	mv	a4,a1
    12e8:	fef42623          	sw	a5,-20(s0)
    12ec:	87ba                	mv	a5,a4
    12ee:	fef42423          	sw	a5,-24(s0)
    return (a < b) ? a : b;
    12f2:	fec42603          	lw	a2,-20(s0)
    12f6:	fe842783          	lw	a5,-24(s0)
    12fa:	0007869b          	sext.w	a3,a5
    12fe:	0006071b          	sext.w	a4,a2
    1302:	00d75363          	bge	a4,a3,1308 <min+0x2a>
    1306:	87b2                	mv	a5,a2
    1308:	2781                	sext.w	a5,a5
}
    130a:	853e                	mv	a0,a5
    130c:	6462                	ld	s0,24(sp)
    130e:	6105                	addi	sp,sp,32
    1310:	8082                	ret

0000000000001312 <schedule_lst>:

/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args) {
    1312:	7131                	addi	sp,sp,-192
    1314:	fd06                	sd	ra,184(sp)
    1316:	f922                	sd	s0,176(sp)
    1318:	f526                	sd	s1,168(sp)
    131a:	f14a                	sd	s2,160(sp)
    131c:	ed4e                	sd	s3,152(sp)
    131e:	0180                	addi	s0,sp,192
    1320:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *min_slack_thread = NULL;
    1322:	fc043423          	sd	zero,-56(s0)
    int min_slack_time = INT_MAX;
    1326:	800007b7          	lui	a5,0x80000
    132a:	fff7c793          	not	a5,a5
    132e:	fcf42223          	sw	a5,-60(s0)
    struct thread *t;
    // int ddl;
    // Determine the thread with the minimum slack time
    list_for_each_entry(t, args.run_queue, thread_list) {
    1332:	649c                	ld	a5,8(s1)
    1334:	639c                	ld	a5,0(a5)
    1336:	faf43023          	sd	a5,-96(s0)
    133a:	fa043783          	ld	a5,-96(s0)
    133e:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffde98>
    1342:	faf43c23          	sd	a5,-72(s0)
    1346:	a069                	j	13d0 <schedule_lst+0xbe>
        int slack_time = t->current_deadline - args.current_time - t->remaining_time;
    1348:	fb843783          	ld	a5,-72(s0)
    134c:	4ff8                	lw	a4,92(a5)
    134e:	409c                	lw	a5,0(s1)
    1350:	40f707bb          	subw	a5,a4,a5
    1354:	0007871b          	sext.w	a4,a5
    1358:	fb843783          	ld	a5,-72(s0)
    135c:	4fbc                	lw	a5,88(a5)
    135e:	40f707bb          	subw	a5,a4,a5
    1362:	f6f42a23          	sw	a5,-140(s0)
        if (slack_time < min_slack_time || (slack_time == min_slack_time && t->ID < (min_slack_thread ? min_slack_thread->ID : INT_MAX))) {
    1366:	f7442703          	lw	a4,-140(s0)
    136a:	fc442783          	lw	a5,-60(s0)
    136e:	2701                	sext.w	a4,a4
    1370:	2781                	sext.w	a5,a5
    1372:	02f74c63          	blt	a4,a5,13aa <schedule_lst+0x98>
    1376:	f7442703          	lw	a4,-140(s0)
    137a:	fc442783          	lw	a5,-60(s0)
    137e:	2701                	sext.w	a4,a4
    1380:	2781                	sext.w	a5,a5
    1382:	02f71c63          	bne	a4,a5,13ba <schedule_lst+0xa8>
    1386:	fb843783          	ld	a5,-72(s0)
    138a:	5fd4                	lw	a3,60(a5)
    138c:	fc843783          	ld	a5,-56(s0)
    1390:	c789                	beqz	a5,139a <schedule_lst+0x88>
    1392:	fc843783          	ld	a5,-56(s0)
    1396:	5fdc                	lw	a5,60(a5)
    1398:	a029                	j	13a2 <schedule_lst+0x90>
    139a:	800007b7          	lui	a5,0x80000
    139e:	fff7c793          	not	a5,a5
    13a2:	873e                	mv	a4,a5
    13a4:	87b6                	mv	a5,a3
    13a6:	00e7da63          	bge	a5,a4,13ba <schedule_lst+0xa8>
            min_slack_thread = t;
    13aa:	fb843783          	ld	a5,-72(s0)
    13ae:	fcf43423          	sd	a5,-56(s0)
            min_slack_time = slack_time;
    13b2:	f7442783          	lw	a5,-140(s0)
    13b6:	fcf42223          	sw	a5,-60(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    13ba:	fb843783          	ld	a5,-72(s0)
    13be:	779c                	ld	a5,40(a5)
    13c0:	f6f43423          	sd	a5,-152(s0)
    13c4:	f6843783          	ld	a5,-152(s0)
    13c8:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffde98>
    13cc:	faf43c23          	sd	a5,-72(s0)
    13d0:	fb843783          	ld	a5,-72(s0)
    13d4:	02878713          	addi	a4,a5,40
    13d8:	649c                	ld	a5,8(s1)
    13da:	f6f717e3          	bne	a4,a5,1348 <schedule_lst+0x36>
        }
    }

    // Calculate the next event time, initially very large
    int next_significant_event_time = INT_MAX;
    13de:	800007b7          	lui	a5,0x80000
    13e2:	fff7c793          	not	a5,a5
    13e6:	faf42a23          	sw	a5,-76(s0)

    // Analyze each upcoming release to determine if and when they should preempt the current thread
    struct release_queue_entry *entry;
    list_for_each_entry(entry, args.release_queue, thread_list) {
    13ea:	689c                	ld	a5,16(s1)
    13ec:	639c                	ld	a5,0(a5)
    13ee:	f8f43c23          	sd	a5,-104(s0)
    13f2:	f9843783          	ld	a5,-104(s0)
    13f6:	17e1                	addi	a5,a5,-8
    13f8:	faf43423          	sd	a5,-88(s0)
    13fc:	a0f1                	j	14c8 <schedule_lst+0x1b6>
        if (entry->release_time > args.current_time) {
    13fe:	fa843783          	ld	a5,-88(s0)
    1402:	4f98                	lw	a4,24(a5)
    1404:	409c                	lw	a5,0(s1)
    1406:	0ae7d763          	bge	a5,a4,14b4 <schedule_lst+0x1a2>
            struct thread *upcoming_thread = entry->thrd;
    140a:	fa843783          	ld	a5,-88(s0)
    140e:	639c                	ld	a5,0(a5)
    1410:	f8f43423          	sd	a5,-120(s0)
            int upcoming_slack_time = upcoming_thread->current_deadline - entry->release_time - upcoming_thread->remaining_time;
    1414:	f8843783          	ld	a5,-120(s0)
    1418:	4ff8                	lw	a4,92(a5)
    141a:	fa843783          	ld	a5,-88(s0)
    141e:	4f9c                	lw	a5,24(a5)
    1420:	40f707bb          	subw	a5,a4,a5
    1424:	0007871b          	sext.w	a4,a5
    1428:	f8843783          	ld	a5,-120(s0)
    142c:	4fbc                	lw	a5,88(a5)
    142e:	40f707bb          	subw	a5,a4,a5
    1432:	f8f42223          	sw	a5,-124(s0)
            // Check if this upcoming thread will impose an earlier preemption due to tighter slack time
            if (upcoming_slack_time < min_slack_time) {
    1436:	f8442703          	lw	a4,-124(s0)
    143a:	fc442783          	lw	a5,-60(s0)
    143e:	2701                	sext.w	a4,a4
    1440:	2781                	sext.w	a5,a5
    1442:	02f75163          	bge	a4,a5,1464 <schedule_lst+0x152>
                next_significant_event_time = min(next_significant_event_time, entry->release_time);
    1446:	fa843783          	ld	a5,-88(s0)
    144a:	4f98                	lw	a4,24(a5)
    144c:	fb442783          	lw	a5,-76(s0)
    1450:	85ba                	mv	a1,a4
    1452:	853e                	mv	a0,a5
    1454:	00000097          	auipc	ra,0x0
    1458:	e8a080e7          	jalr	-374(ra) # 12de <min>
    145c:	87aa                	mv	a5,a0
    145e:	faf42a23          	sw	a5,-76(s0)
    1462:	a889                	j	14b4 <schedule_lst+0x1a2>
            } else if (upcoming_slack_time == min_slack_time && upcoming_thread->ID < (min_slack_thread ? min_slack_thread->ID : INT_MAX))
    1464:	f8442703          	lw	a4,-124(s0)
    1468:	fc442783          	lw	a5,-60(s0)
    146c:	2701                	sext.w	a4,a4
    146e:	2781                	sext.w	a5,a5
    1470:	04f71263          	bne	a4,a5,14b4 <schedule_lst+0x1a2>
    1474:	f8843783          	ld	a5,-120(s0)
    1478:	5fd4                	lw	a3,60(a5)
    147a:	fc843783          	ld	a5,-56(s0)
    147e:	c789                	beqz	a5,1488 <schedule_lst+0x176>
    1480:	fc843783          	ld	a5,-56(s0)
    1484:	5fdc                	lw	a5,60(a5)
    1486:	a029                	j	1490 <schedule_lst+0x17e>
    1488:	800007b7          	lui	a5,0x80000
    148c:	fff7c793          	not	a5,a5
    1490:	873e                	mv	a4,a5
    1492:	87b6                	mv	a5,a3
    1494:	02e7d063          	bge	a5,a4,14b4 <schedule_lst+0x1a2>
                next_significant_event_time = min(next_significant_event_time, entry->release_time);
    1498:	fa843783          	ld	a5,-88(s0)
    149c:	4f98                	lw	a4,24(a5)
    149e:	fb442783          	lw	a5,-76(s0)
    14a2:	85ba                	mv	a1,a4
    14a4:	853e                	mv	a0,a5
    14a6:	00000097          	auipc	ra,0x0
    14aa:	e38080e7          	jalr	-456(ra) # 12de <min>
    14ae:	87aa                	mv	a5,a0
    14b0:	faf42a23          	sw	a5,-76(s0)
    list_for_each_entry(entry, args.release_queue, thread_list) {
    14b4:	fa843783          	ld	a5,-88(s0)
    14b8:	679c                	ld	a5,8(a5)
    14ba:	f6f43c23          	sd	a5,-136(s0)
    14be:	f7843783          	ld	a5,-136(s0)
    14c2:	17e1                	addi	a5,a5,-8
    14c4:	faf43423          	sd	a5,-88(s0)
    14c8:	fa843783          	ld	a5,-88(s0)
    14cc:	00878713          	addi	a4,a5,8 # ffffffff80000008 <__global_pointer$+0xffffffff7fffdec8>
    14d0:	689c                	ld	a5,16(s1)
    14d2:	f2f716e3          	bne	a4,a5,13fe <schedule_lst+0xec>
        }
    }

    // Decide the allocated time based on current minimum slack or upcoming preemption needs
    if (min_slack_thread) {
    14d6:	fc843783          	ld	a5,-56(s0)
    14da:	c7b5                	beqz	a5,1546 <schedule_lst+0x234>
        // Check if the thread has missed its deadline
        if (args.current_time >= min_slack_thread->current_deadline && min_slack_thread->remaining_time > 0) {
    14dc:	4098                	lw	a4,0(s1)
    14de:	fc843783          	ld	a5,-56(s0)
    14e2:	4ffc                	lw	a5,92(a5)
    14e4:	02f74063          	blt	a4,a5,1504 <schedule_lst+0x1f2>
    14e8:	fc843783          	ld	a5,-56(s0)
    14ec:	4fbc                	lw	a5,88(a5)
    14ee:	00f05b63          	blez	a5,1504 <schedule_lst+0x1f2>
            r.scheduled_thread_list_member = &min_slack_thread->thread_list;
    14f2:	fc843783          	ld	a5,-56(s0)
    14f6:	02878793          	addi	a5,a5,40
    14fa:	f4f43423          	sd	a5,-184(s0)
            r.allocated_time = 0;  // Set to 0 to handle missed deadline
    14fe:	f4042823          	sw	zero,-176(s0)
    1502:	a049                	j	1584 <schedule_lst+0x272>
        } else {
            // Decide the allocated time based on current minimum slack or upcoming preemption needs
            int allocated_time = (next_significant_event_time == INT_MAX) ? min_slack_thread->remaining_time : next_significant_event_time - args.current_time;
    1504:	fb442783          	lw	a5,-76(s0)
    1508:	0007871b          	sext.w	a4,a5
    150c:	800007b7          	lui	a5,0x80000
    1510:	fff7c793          	not	a5,a5
    1514:	00f71663          	bne	a4,a5,1520 <schedule_lst+0x20e>
    1518:	fc843783          	ld	a5,-56(s0)
    151c:	4fbc                	lw	a5,88(a5)
    151e:	a039                	j	152c <schedule_lst+0x21a>
    1520:	409c                	lw	a5,0(s1)
    1522:	fb442703          	lw	a4,-76(s0)
    1526:	40f707bb          	subw	a5,a4,a5
    152a:	2781                	sext.w	a5,a5
    152c:	f8f42a23          	sw	a5,-108(s0)
            r.scheduled_thread_list_member = &min_slack_thread->thread_list;
    1530:	fc843783          	ld	a5,-56(s0)
    1534:	02878793          	addi	a5,a5,40 # ffffffff80000028 <__global_pointer$+0xffffffff7fffdee8>
    1538:	f4f43423          	sd	a5,-184(s0)
            r.allocated_time = allocated_time;
    153c:	f9442783          	lw	a5,-108(s0)
    1540:	f4f42823          	sw	a5,-176(s0)
    1544:	a081                	j	1584 <schedule_lst+0x272>
        }
    } else {
        // No runnable threads, prepare to sleep or wait based on next known event
        r.scheduled_thread_list_member = args.run_queue;
    1546:	649c                	ld	a5,8(s1)
    1548:	f4f43423          	sd	a5,-184(s0)
        r.allocated_time = next_significant_event_time != INT_MAX ? next_significant_event_time - args.current_time : find_next_release_time(args.release_queue, args.current_time);
    154c:	fb442783          	lw	a5,-76(s0)
    1550:	0007871b          	sext.w	a4,a5
    1554:	800007b7          	lui	a5,0x80000
    1558:	fff7c793          	not	a5,a5
    155c:	00f70963          	beq	a4,a5,156e <schedule_lst+0x25c>
    1560:	409c                	lw	a5,0(s1)
    1562:	fb442703          	lw	a4,-76(s0)
    1566:	40f707bb          	subw	a5,a4,a5
    156a:	2781                	sext.w	a5,a5
    156c:	a811                	j	1580 <schedule_lst+0x26e>
    156e:	689c                	ld	a5,16(s1)
    1570:	4098                	lw	a4,0(s1)
    1572:	85ba                	mv	a1,a4
    1574:	853e                	mv	a0,a5
    1576:	00000097          	auipc	ra,0x0
    157a:	8ca080e7          	jalr	-1846(ra) # e40 <find_next_release_time>
    157e:	87aa                	mv	a5,a0
    1580:	f4f42823          	sw	a5,-176(s0)
    }

    return r;
    1584:	f4843783          	ld	a5,-184(s0)
    1588:	f4f43c23          	sd	a5,-168(s0)
    158c:	f5043783          	ld	a5,-176(s0)
    1590:	f6f43023          	sd	a5,-160(s0)
    1594:	4701                	li	a4,0
    1596:	f5843703          	ld	a4,-168(s0)
    159a:	4781                	li	a5,0
    159c:	f6043783          	ld	a5,-160(s0)
    15a0:	893a                	mv	s2,a4
    15a2:	89be                	mv	s3,a5
    15a4:	874a                	mv	a4,s2
    15a6:	87ce                	mv	a5,s3
}
    15a8:	853a                	mv	a0,a4
    15aa:	85be                	mv	a1,a5
    15ac:	70ea                	ld	ra,184(sp)
    15ae:	744a                	ld	s0,176(sp)
    15b0:	74aa                	ld	s1,168(sp)
    15b2:	790a                	ld	s2,160(sp)
    15b4:	69ea                	ld	s3,152(sp)
    15b6:	6129                	addi	sp,sp,192
    15b8:	8082                	ret

00000000000015ba <find_earliest_impactful_release_time_dm>:
typedef struct {
    int earliest_impactful_event;
    struct thread *thread;
} ImpactfulEvent;

ImpactfulEvent find_earliest_impactful_release_time_dm(struct list_head *release_queue, struct list_head*run_queue, int current_time, int current_period) {
    15ba:	7119                	addi	sp,sp,-128
    15bc:	fca2                	sd	s0,120(sp)
    15be:	0100                	addi	s0,sp,128
    15c0:	f8a43c23          	sd	a0,-104(s0)
    15c4:	f8b43823          	sd	a1,-112(s0)
    15c8:	87b2                	mv	a5,a2
    15ca:	8736                	mv	a4,a3
    15cc:	f8f42623          	sw	a5,-116(s0)
    15d0:	87ba                	mv	a5,a4
    15d2:	f8f42423          	sw	a5,-120(s0)
    struct release_queue_entry *entry;
    struct thread *t;
    int earliest_impactful_event = INT_MAX;
    15d6:	800007b7          	lui	a5,0x80000
    15da:	fff7c793          	not	a5,a5
    15de:	fcf42e23          	sw	a5,-36(s0)
    int earliest_impactful_thread_ID = INT_MAX;    
    15e2:	800007b7          	lui	a5,0x80000
    15e6:	fff7c793          	not	a5,a5
    15ea:	fcf42c23          	sw	a5,-40(s0)
    
    // Look for the smallest deadline that is less than the current task's deadline
    list_for_each_entry(entry, release_queue, thread_list) {
    15ee:	f9843783          	ld	a5,-104(s0)
    15f2:	639c                	ld	a5,0(a5)
    15f4:	fcf43823          	sd	a5,-48(s0)
    15f8:	fd043783          	ld	a5,-48(s0)
    15fc:	17e1                	addi	a5,a5,-8
    15fe:	fef43423          	sd	a5,-24(s0)
    1602:	a201                	j	1702 <find_earliest_impactful_release_time_dm+0x148>
        if (entry->release_time > current_time && entry->thrd->period < current_period) {
    1604:	fe843783          	ld	a5,-24(s0)
    1608:	4f98                	lw	a4,24(a5)
    160a:	f8c42783          	lw	a5,-116(s0)
    160e:	2781                	sext.w	a5,a5
    1610:	04e7d463          	bge	a5,a4,1658 <find_earliest_impactful_release_time_dm+0x9e>
    1614:	fe843783          	ld	a5,-24(s0)
    1618:	639c                	ld	a5,0(a5)
    161a:	4bb8                	lw	a4,80(a5)
    161c:	f8842783          	lw	a5,-120(s0)
    1620:	2781                	sext.w	a5,a5
    1622:	02f75b63          	bge	a4,a5,1658 <find_earliest_impactful_release_time_dm+0x9e>
            if (entry->release_time < earliest_impactful_event) {
    1626:	fe843783          	ld	a5,-24(s0)
    162a:	4f98                	lw	a4,24(a5)
    162c:	fdc42783          	lw	a5,-36(s0)
    1630:	2781                	sext.w	a5,a5
    1632:	0af75e63          	bge	a4,a5,16ee <find_earliest_impactful_release_time_dm+0x134>
                earliest_impactful_event = entry->release_time;
    1636:	fe843783          	ld	a5,-24(s0)
    163a:	4f9c                	lw	a5,24(a5)
    163c:	fcf42e23          	sw	a5,-36(s0)
                t = entry->thrd;
    1640:	fe843783          	ld	a5,-24(s0)
    1644:	639c                	ld	a5,0(a5)
    1646:	fef43023          	sd	a5,-32(s0)
                earliest_impactful_thread_ID = entry->thrd->ID;
    164a:	fe843783          	ld	a5,-24(s0)
    164e:	639c                	ld	a5,0(a5)
    1650:	5fdc                	lw	a5,60(a5)
    1652:	fcf42c23          	sw	a5,-40(s0)
            if (entry->release_time < earliest_impactful_event) {
    1656:	a861                	j	16ee <find_earliest_impactful_release_time_dm+0x134>
            }
        } 
        // or the smallest deadline that is equal to the current task's deadline but has a smaller ID
        else if (entry->release_time > current_time && entry->thrd->period == current_period) {
    1658:	fe843783          	ld	a5,-24(s0)
    165c:	4f98                	lw	a4,24(a5)
    165e:	f8c42783          	lw	a5,-116(s0)
    1662:	2781                	sext.w	a5,a5
    1664:	08e7d563          	bge	a5,a4,16ee <find_earliest_impactful_release_time_dm+0x134>
    1668:	fe843783          	ld	a5,-24(s0)
    166c:	639c                	ld	a5,0(a5)
    166e:	4bb8                	lw	a4,80(a5)
    1670:	f8842783          	lw	a5,-120(s0)
    1674:	2781                	sext.w	a5,a5
    1676:	06e79c63          	bne	a5,a4,16ee <find_earliest_impactful_release_time_dm+0x134>
            
            //printf("ID %d, entry release time: %d\n", entry->thrd->ID, entry->release_time);
            if (entry->release_time < earliest_impactful_event) {
    167a:	fe843783          	ld	a5,-24(s0)
    167e:	4f98                	lw	a4,24(a5)
    1680:	fdc42783          	lw	a5,-36(s0)
    1684:	2781                	sext.w	a5,a5
    1686:	02f75363          	bge	a4,a5,16ac <find_earliest_impactful_release_time_dm+0xf2>
                earliest_impactful_event = entry->release_time;
    168a:	fe843783          	ld	a5,-24(s0)
    168e:	4f9c                	lw	a5,24(a5)
    1690:	fcf42e23          	sw	a5,-36(s0)
                t = entry->thrd;
    1694:	fe843783          	ld	a5,-24(s0)
    1698:	639c                	ld	a5,0(a5)
    169a:	fef43023          	sd	a5,-32(s0)
                earliest_impactful_thread_ID = entry->thrd->ID;
    169e:	fe843783          	ld	a5,-24(s0)
    16a2:	639c                	ld	a5,0(a5)
    16a4:	5fdc                	lw	a5,60(a5)
    16a6:	fcf42c23          	sw	a5,-40(s0)
    16aa:	a091                	j	16ee <find_earliest_impactful_release_time_dm+0x134>
            } else if (entry->release_time == earliest_impactful_event && entry->thrd->ID < earliest_impactful_thread_ID) {
    16ac:	fe843783          	ld	a5,-24(s0)
    16b0:	4f98                	lw	a4,24(a5)
    16b2:	fdc42783          	lw	a5,-36(s0)
    16b6:	2781                	sext.w	a5,a5
    16b8:	02e79b63          	bne	a5,a4,16ee <find_earliest_impactful_release_time_dm+0x134>
    16bc:	fe843783          	ld	a5,-24(s0)
    16c0:	639c                	ld	a5,0(a5)
    16c2:	5fd8                	lw	a4,60(a5)
    16c4:	fd842783          	lw	a5,-40(s0)
    16c8:	2781                	sext.w	a5,a5
    16ca:	02f75263          	bge	a4,a5,16ee <find_earliest_impactful_release_time_dm+0x134>
                earliest_impactful_event = entry->release_time;
    16ce:	fe843783          	ld	a5,-24(s0)
    16d2:	4f9c                	lw	a5,24(a5)
    16d4:	fcf42e23          	sw	a5,-36(s0)
                t = entry->thrd;
    16d8:	fe843783          	ld	a5,-24(s0)
    16dc:	639c                	ld	a5,0(a5)
    16de:	fef43023          	sd	a5,-32(s0)
                earliest_impactful_thread_ID = entry->thrd->ID;
    16e2:	fe843783          	ld	a5,-24(s0)
    16e6:	639c                	ld	a5,0(a5)
    16e8:	5fdc                	lw	a5,60(a5)
    16ea:	fcf42c23          	sw	a5,-40(s0)
    list_for_each_entry(entry, release_queue, thread_list) {
    16ee:	fe843783          	ld	a5,-24(s0)
    16f2:	679c                	ld	a5,8(a5)
    16f4:	fcf43423          	sd	a5,-56(s0)
    16f8:	fc843783          	ld	a5,-56(s0)
    16fc:	17e1                	addi	a5,a5,-8
    16fe:	fef43423          	sd	a5,-24(s0)
    1702:	fe843783          	ld	a5,-24(s0)
    1706:	07a1                	addi	a5,a5,8
    1708:	f9843703          	ld	a4,-104(s0)
    170c:	eef71ce3          	bne	a4,a5,1604 <find_earliest_impactful_release_time_dm+0x4a>
            }
        }
    }
    //printf("earliest_impactful_event: %d\n", earliest_impactful_event);
    // If a task is found that might preempt the current task, determine when it will happen
    earliest_impactful_event = earliest_impactful_event == INT_MAX ? -1 : earliest_impactful_event;
    1710:	fdc42783          	lw	a5,-36(s0)
    1714:	0007871b          	sext.w	a4,a5
    1718:	800007b7          	lui	a5,0x80000
    171c:	fff7c793          	not	a5,a5
    1720:	00f70563          	beq	a4,a5,172a <find_earliest_impactful_release_time_dm+0x170>
    1724:	fdc42783          	lw	a5,-36(s0)
    1728:	a011                	j	172c <find_earliest_impactful_release_time_dm+0x172>
    172a:	57fd                	li	a5,-1
    172c:	fcf42e23          	sw	a5,-36(s0)
    return (ImpactfulEvent) {earliest_impactful_event, t};
    1730:	fdc42783          	lw	a5,-36(s0)
    1734:	faf42c23          	sw	a5,-72(s0)
    1738:	fe043783          	ld	a5,-32(s0)
    173c:	fcf43023          	sd	a5,-64(s0)
    1740:	4701                	li	a4,0
    1742:	fb843703          	ld	a4,-72(s0)
    1746:	4781                	li	a5,0
    1748:	fc043783          	ld	a5,-64(s0)
    174c:	883a                	mv	a6,a4
    174e:	88be                	mv	a7,a5
    1750:	8742                	mv	a4,a6
    1752:	87c6                	mv	a5,a7
}
    1754:	853a                	mv	a0,a4
    1756:	85be                	mv	a1,a5
    1758:	7466                	ld	s0,120(sp)
    175a:	6109                	addi	sp,sp,128
    175c:	8082                	ret

000000000000175e <schedule_dm>:


struct threads_sched_result schedule_dm(struct threads_sched_args args) {
    175e:	7175                	addi	sp,sp,-144
    1760:	e506                	sd	ra,136(sp)
    1762:	e122                	sd	s0,128(sp)
    1764:	fca6                	sd	s1,120(sp)
    1766:	f8ca                	sd	s2,112(sp)
    1768:	f4ce                	sd	s3,104(sp)
    176a:	0900                	addi	s0,sp,144
    176c:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *earliest_deadline_thread = NULL;
    176e:	fc043423          	sd	zero,-56(s0)
    struct thread *t;
    int earliest_deadline = INT_MAX;
    1772:	800007b7          	lui	a5,0x80000
    1776:	fff7c793          	not	a5,a5
    177a:	faf42e23          	sw	a5,-68(s0)
    int earliest_impactful_deadline; 
    
    // Determine the earliest deadline among current tasks
    list_for_each_entry(t, args.run_queue, thread_list) {
    177e:	649c                	ld	a5,8(s1)
    1780:	639c                	ld	a5,0(a5)
    1782:	faf43823          	sd	a5,-80(s0)
    1786:	fb043783          	ld	a5,-80(s0)
    178a:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffde98>
    178e:	fcf43023          	sd	a5,-64(s0)
    1792:	a8bd                	j	1810 <schedule_dm+0xb2>
        if (t->is_real_time && t->period < earliest_deadline) {
    1794:	fc043783          	ld	a5,-64(s0)
    1798:	43bc                	lw	a5,64(a5)
    179a:	c39d                	beqz	a5,17c0 <schedule_dm+0x62>
    179c:	fc043783          	ld	a5,-64(s0)
    17a0:	4bb8                	lw	a4,80(a5)
    17a2:	fbc42783          	lw	a5,-68(s0)
    17a6:	2781                	sext.w	a5,a5
    17a8:	00f75c63          	bge	a4,a5,17c0 <schedule_dm+0x62>
            earliest_deadline_thread = t;
    17ac:	fc043783          	ld	a5,-64(s0)
    17b0:	fcf43423          	sd	a5,-56(s0)
            earliest_deadline = t->period;
    17b4:	fc043783          	ld	a5,-64(s0)
    17b8:	4bbc                	lw	a5,80(a5)
    17ba:	faf42e23          	sw	a5,-68(s0)
    17be:	a835                	j	17fa <schedule_dm+0x9c>
        } else if (t->is_real_time && t->period == earliest_deadline && t->ID < earliest_deadline_thread->ID) {
    17c0:	fc043783          	ld	a5,-64(s0)
    17c4:	43bc                	lw	a5,64(a5)
    17c6:	cb95                	beqz	a5,17fa <schedule_dm+0x9c>
    17c8:	fc043783          	ld	a5,-64(s0)
    17cc:	4bb8                	lw	a4,80(a5)
    17ce:	fbc42783          	lw	a5,-68(s0)
    17d2:	2781                	sext.w	a5,a5
    17d4:	02e79363          	bne	a5,a4,17fa <schedule_dm+0x9c>
    17d8:	fc043783          	ld	a5,-64(s0)
    17dc:	5fd8                	lw	a4,60(a5)
    17de:	fc843783          	ld	a5,-56(s0)
    17e2:	5fdc                	lw	a5,60(a5)
    17e4:	00f75b63          	bge	a4,a5,17fa <schedule_dm+0x9c>
            earliest_deadline_thread = t;
    17e8:	fc043783          	ld	a5,-64(s0)
    17ec:	fcf43423          	sd	a5,-56(s0)
            earliest_deadline = t->period;
    17f0:	fc043783          	ld	a5,-64(s0)
    17f4:	4bbc                	lw	a5,80(a5)
    17f6:	faf42e23          	sw	a5,-68(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    17fa:	fc043783          	ld	a5,-64(s0)
    17fe:	779c                	ld	a5,40(a5)
    1800:	faf43023          	sd	a5,-96(s0)
    1804:	fa043783          	ld	a5,-96(s0)
    1808:	fd878793          	addi	a5,a5,-40
    180c:	fcf43023          	sd	a5,-64(s0)
    1810:	fc043783          	ld	a5,-64(s0)
    1814:	02878713          	addi	a4,a5,40
    1818:	649c                	ld	a5,8(s1)
    181a:	f6f71de3          	bne	a4,a5,1794 <schedule_dm+0x36>
        }
    }

    // Find the earliest impactful deadline from other tasks
    ImpactfulEvent earliest_impactful_event = find_earliest_impactful_release_time_dm(args.release_queue, args.run_queue, args.current_time, earliest_deadline_thread ? earliest_deadline_thread->period : INT_MAX);
    181e:	6898                	ld	a4,16(s1)
    1820:	648c                	ld	a1,8(s1)
    1822:	4090                	lw	a2,0(s1)
    1824:	fc843783          	ld	a5,-56(s0)
    1828:	c789                	beqz	a5,1832 <schedule_dm+0xd4>
    182a:	fc843783          	ld	a5,-56(s0)
    182e:	4bbc                	lw	a5,80(a5)
    1830:	a029                	j	183a <schedule_dm+0xdc>
    1832:	800007b7          	lui	a5,0x80000
    1836:	fff7c793          	not	a5,a5
    183a:	86be                	mv	a3,a5
    183c:	853a                	mv	a0,a4
    183e:	00000097          	auipc	ra,0x0
    1842:	d7c080e7          	jalr	-644(ra) # 15ba <find_earliest_impactful_release_time_dm>
    1846:	872a                	mv	a4,a0
    1848:	87ae                	mv	a5,a1
    184a:	f6e43823          	sd	a4,-144(s0)
    184e:	f6f43c23          	sd	a5,-136(s0)
    earliest_impactful_deadline = earliest_impactful_event.earliest_impactful_event;
    1852:	f7042783          	lw	a5,-144(s0)
    1856:	faf42623          	sw	a5,-84(s0)

    if (earliest_deadline_thread) {
    185a:	fc843783          	ld	a5,-56(s0)
    185e:	c3d1                	beqz	a5,18e2 <schedule_dm+0x184>
        int time_to_deadline = earliest_deadline_thread->current_deadline - args.current_time;
    1860:	fc843783          	ld	a5,-56(s0)
    1864:	4ff8                	lw	a4,92(a5)
    1866:	409c                	lw	a5,0(s1)
    1868:	40f707bb          	subw	a5,a4,a5
    186c:	faf42423          	sw	a5,-88(s0)
        
        // If the thread is already past its deadline, allocate no time (handle deadline miss)
        if (time_to_deadline <= 0) {
    1870:	fa842783          	lw	a5,-88(s0)
    1874:	2781                	sext.w	a5,a5
    1876:	00f04b63          	bgtz	a5,188c <schedule_dm+0x12e>
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    187a:	fc843783          	ld	a5,-56(s0)
    187e:	02878793          	addi	a5,a5,40 # ffffffff80000028 <__global_pointer$+0xffffffff7fffdee8>
    1882:	f8f43023          	sd	a5,-128(s0)
            r.allocated_time = 0;
    1886:	f8042423          	sw	zero,-120(s0)
    188a:	a895                	j	18fe <schedule_dm+0x1a0>
        } else {
            // Allocate time based on the smallest of the task's remaining time or the next impactful deadline
            int allocated_time;
            if (earliest_impactful_deadline != -1 && (earliest_impactful_deadline - args.current_time) < earliest_deadline_thread->remaining_time){
    188c:	fac42783          	lw	a5,-84(s0)
    1890:	0007871b          	sext.w	a4,a5
    1894:	57fd                	li	a5,-1
    1896:	02f70663          	beq	a4,a5,18c2 <schedule_dm+0x164>
    189a:	409c                	lw	a5,0(s1)
    189c:	fac42703          	lw	a4,-84(s0)
    18a0:	40f707bb          	subw	a5,a4,a5
    18a4:	0007871b          	sext.w	a4,a5
    18a8:	fc843783          	ld	a5,-56(s0)
    18ac:	4fbc                	lw	a5,88(a5)
    18ae:	00f75a63          	bge	a4,a5,18c2 <schedule_dm+0x164>
                allocated_time = earliest_impactful_deadline - args.current_time;
    18b2:	409c                	lw	a5,0(s1)
    18b4:	fac42703          	lw	a4,-84(s0)
    18b8:	40f707bb          	subw	a5,a4,a5
    18bc:	faf42c23          	sw	a5,-72(s0)
    18c0:	a031                	j	18cc <schedule_dm+0x16e>
            } else {
                allocated_time = earliest_deadline_thread->remaining_time;
    18c2:	fc843783          	ld	a5,-56(s0)
    18c6:	4fbc                	lw	a5,88(a5)
    18c8:	faf42c23          	sw	a5,-72(s0)
            }
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    18cc:	fc843783          	ld	a5,-56(s0)
    18d0:	02878793          	addi	a5,a5,40
    18d4:	f8f43023          	sd	a5,-128(s0)
            r.allocated_time = allocated_time;
    18d8:	fb842783          	lw	a5,-72(s0)
    18dc:	f8f42423          	sw	a5,-120(s0)
    18e0:	a839                	j	18fe <schedule_dm+0x1a0>
        }
    } else {
        // If no immediate tasks, schedule the next possible task
        r.scheduled_thread_list_member = args.run_queue;
    18e2:	649c                	ld	a5,8(s1)
    18e4:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    18e8:	689c                	ld	a5,16(s1)
    18ea:	4098                	lw	a4,0(s1)
    18ec:	85ba                	mv	a1,a4
    18ee:	853e                	mv	a0,a5
    18f0:	fffff097          	auipc	ra,0xfffff
    18f4:	550080e7          	jalr	1360(ra) # e40 <find_next_release_time>
    18f8:	87aa                	mv	a5,a0
    18fa:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    18fe:	f8043783          	ld	a5,-128(s0)
    1902:	f8f43823          	sd	a5,-112(s0)
    1906:	f8843783          	ld	a5,-120(s0)
    190a:	f8f43c23          	sd	a5,-104(s0)
    190e:	4701                	li	a4,0
    1910:	f9043703          	ld	a4,-112(s0)
    1914:	4781                	li	a5,0
    1916:	f9843783          	ld	a5,-104(s0)
    191a:	893a                	mv	s2,a4
    191c:	89be                	mv	s3,a5
    191e:	874a                	mv	a4,s2
    1920:	87ce                	mv	a5,s3
}
    1922:	853a                	mv	a0,a4
    1924:	85be                	mv	a1,a5
    1926:	60aa                	ld	ra,136(sp)
    1928:	640a                	ld	s0,128(sp)
    192a:	74e6                	ld	s1,120(sp)
    192c:	7946                	ld	s2,112(sp)
    192e:	79a6                	ld	s3,104(sp)
    1930:	6149                	addi	sp,sp,144
    1932:	8082                	ret
