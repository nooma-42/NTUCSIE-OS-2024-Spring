
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
     66e:	e4e68693          	addi	a3,a3,-434 # 14b8 <digits>
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
     748:	d7470713          	addi	a4,a4,-652 # 14b8 <digits>
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
     908:	b8478793          	addi	a5,a5,-1148 # 1488 <schedule_dm+0x20a>
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
     ab4:	a3078793          	addi	a5,a5,-1488 # 14e0 <freep>
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
     bac:	93878793          	addi	a5,a5,-1736 # 14e0 <freep>
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
     c2e:	8b678793          	addi	a5,a5,-1866 # 14e0 <freep>
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
     c60:	88478793          	addi	a5,a5,-1916 # 14e0 <freep>
     c64:	639c                	ld	a5,0(a5)
     c66:	fef43023          	sd	a5,-32(s0)
     c6a:	fe043783          	ld	a5,-32(s0)
     c6e:	ef95                	bnez	a5,caa <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     c70:	00001797          	auipc	a5,0x1
     c74:	86078793          	addi	a5,a5,-1952 # 14d0 <base>
     c78:	fef43023          	sd	a5,-32(s0)
     c7c:	00001797          	auipc	a5,0x1
     c80:	86478793          	addi	a5,a5,-1948 # 14e0 <freep>
     c84:	fe043703          	ld	a4,-32(s0)
     c88:	e398                	sd	a4,0(a5)
     c8a:	00001797          	auipc	a5,0x1
     c8e:	85678793          	addi	a5,a5,-1962 # 14e0 <freep>
     c92:	6398                	ld	a4,0(a5)
     c94:	00001797          	auipc	a5,0x1
     c98:	83c78793          	addi	a5,a5,-1988 # 14d0 <base>
     c9c:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     c9e:	00001797          	auipc	a5,0x1
     ca2:	83278793          	addi	a5,a5,-1998 # 14d0 <base>
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
     d1a:	00000797          	auipc	a5,0x0
     d1e:	7c678793          	addi	a5,a5,1990 # 14e0 <freep>
     d22:	fe043703          	ld	a4,-32(s0)
     d26:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     d28:	fe843783          	ld	a5,-24(s0)
     d2c:	07c1                	addi	a5,a5,16
     d2e:	a091                	j	d72 <malloc+0x134>
    }
    if(p == freep)
     d30:	00000797          	auipc	a5,0x0
     d34:	7b078793          	addi	a5,a5,1968 # 14e0 <freep>
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

0000000000000e40 <schedule_wrr>:

/* MP3 Part 1 - Non-Real-Time Scheduling */
/* Weighted-Round-Robin Scheduling */
struct threads_sched_result schedule_wrr(struct threads_sched_args args)
{
     e40:	711d                	addi	sp,sp,-96
     e42:	eca2                	sd	s0,88(sp)
     e44:	e8a6                	sd	s1,80(sp)
     e46:	1080                	addi	s0,sp,96
     e48:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the weighted round-robin scheduling algorithm
    static struct thread *last_thread = NULL;
    struct thread *selected_thread = NULL;
     e4a:	fe043423          	sd	zero,-24(s0)
    struct thread *candidate = NULL;
     e4e:	fe043023          	sd	zero,-32(s0)

    // If last_thread is NULL or its remaining time is zero, reset the selection process
    if (last_thread == NULL || last_thread->remaining_time <= 0) {
     e52:	00000797          	auipc	a5,0x0
     e56:	69678793          	addi	a5,a5,1686 # 14e8 <last_thread.1226>
     e5a:	639c                	ld	a5,0(a5)
     e5c:	cb89                	beqz	a5,e6e <schedule_wrr+0x2e>
     e5e:	00000797          	auipc	a5,0x0
     e62:	68a78793          	addi	a5,a5,1674 # 14e8 <last_thread.1226>
     e66:	639c                	ld	a5,0(a5)
     e68:	4fbc                	lw	a5,88(a5)
     e6a:	00f04863          	bgtz	a5,e7a <schedule_wrr+0x3a>
        last_thread = NULL;
     e6e:	00000797          	auipc	a5,0x0
     e72:	67a78793          	addi	a5,a5,1658 # 14e8 <last_thread.1226>
     e76:	0007b023          	sd	zero,0(a5)
    }

    // Find the first thread that is ready to run
    list_for_each_entry(candidate, args.run_queue, thread_list) {
     e7a:	649c                	ld	a5,8(s1)
     e7c:	639c                	ld	a5,0(a5)
     e7e:	fcf43823          	sd	a5,-48(s0)
     e82:	fd043783          	ld	a5,-48(s0)
     e86:	fd878793          	addi	a5,a5,-40
     e8a:	fef43023          	sd	a5,-32(s0)
     e8e:	a0a9                	j	ed8 <schedule_wrr+0x98>
        if (!last_thread && candidate->remaining_time > 0)
     e90:	00000797          	auipc	a5,0x0
     e94:	65878793          	addi	a5,a5,1624 # 14e8 <last_thread.1226>
     e98:	639c                	ld	a5,0(a5)
     e9a:	eb91                	bnez	a5,eae <schedule_wrr+0x6e>
     e9c:	fe043783          	ld	a5,-32(s0)
     ea0:	4fbc                	lw	a5,88(a5)
     ea2:	00f05663          	blez	a5,eae <schedule_wrr+0x6e>
            selected_thread = candidate;
     ea6:	fe043783          	ld	a5,-32(s0)
     eaa:	fef43423          	sd	a5,-24(s0)
        if (candidate->remaining_time > 0) {
     eae:	fe043783          	ld	a5,-32(s0)
     eb2:	4fbc                	lw	a5,88(a5)
     eb4:	00f05763          	blez	a5,ec2 <schedule_wrr+0x82>
            selected_thread = candidate;
     eb8:	fe043783          	ld	a5,-32(s0)
     ebc:	fef43423          	sd	a5,-24(s0)
            break;
     ec0:	a01d                	j	ee6 <schedule_wrr+0xa6>
    list_for_each_entry(candidate, args.run_queue, thread_list) {
     ec2:	fe043783          	ld	a5,-32(s0)
     ec6:	779c                	ld	a5,40(a5)
     ec8:	fcf43423          	sd	a5,-56(s0)
     ecc:	fc843783          	ld	a5,-56(s0)
     ed0:	fd878793          	addi	a5,a5,-40
     ed4:	fef43023          	sd	a5,-32(s0)
     ed8:	fe043783          	ld	a5,-32(s0)
     edc:	02878713          	addi	a4,a5,40
     ee0:	649c                	ld	a5,8(s1)
     ee2:	faf717e3          	bne	a4,a5,e90 <schedule_wrr+0x50>
        }
    }

    // Fall back to the last_thread if no other thread is selected and it still has remaining time
    if (!selected_thread && last_thread && last_thread->remaining_time > 0) {
     ee6:	fe843783          	ld	a5,-24(s0)
     eea:	e795                	bnez	a5,f16 <schedule_wrr+0xd6>
     eec:	00000797          	auipc	a5,0x0
     ef0:	5fc78793          	addi	a5,a5,1532 # 14e8 <last_thread.1226>
     ef4:	639c                	ld	a5,0(a5)
     ef6:	c385                	beqz	a5,f16 <schedule_wrr+0xd6>
     ef8:	00000797          	auipc	a5,0x0
     efc:	5f078793          	addi	a5,a5,1520 # 14e8 <last_thread.1226>
     f00:	639c                	ld	a5,0(a5)
     f02:	4fbc                	lw	a5,88(a5)
     f04:	00f05963          	blez	a5,f16 <schedule_wrr+0xd6>
        selected_thread = last_thread;
     f08:	00000797          	auipc	a5,0x0
     f0c:	5e078793          	addi	a5,a5,1504 # 14e8 <last_thread.1226>
     f10:	639c                	ld	a5,0(a5)
     f12:	fef43423          	sd	a5,-24(s0)
    }

    // Set the scheduling result
    if (selected_thread) {
     f16:	fe843783          	ld	a5,-24(s0)
     f1a:	c7b9                	beqz	a5,f68 <schedule_wrr+0x128>
        int time_slice = selected_thread->weight * TIME_QUANTUM;
     f1c:	fe843783          	ld	a5,-24(s0)
     f20:	47bc                	lw	a5,72(a5)
     f22:	0017979b          	slliw	a5,a5,0x1
     f26:	fcf42e23          	sw	a5,-36(s0)
        if (time_slice > selected_thread->remaining_time) {
     f2a:	fe843783          	ld	a5,-24(s0)
     f2e:	4fb8                	lw	a4,88(a5)
     f30:	fdc42783          	lw	a5,-36(s0)
     f34:	2781                	sext.w	a5,a5
     f36:	00f75763          	bge	a4,a5,f44 <schedule_wrr+0x104>
            time_slice = selected_thread->remaining_time;
     f3a:	fe843783          	ld	a5,-24(s0)
     f3e:	4fbc                	lw	a5,88(a5)
     f40:	fcf42e23          	sw	a5,-36(s0)
        }
        r.scheduled_thread_list_member = &selected_thread->thread_list;
     f44:	fe843783          	ld	a5,-24(s0)
     f48:	02878793          	addi	a5,a5,40
     f4c:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = time_slice;
     f50:	fdc42783          	lw	a5,-36(s0)
     f54:	faf42823          	sw	a5,-80(s0)
        last_thread = selected_thread;  // Update the last run thread
     f58:	00000797          	auipc	a5,0x0
     f5c:	59078793          	addi	a5,a5,1424 # 14e8 <last_thread.1226>
     f60:	fe843703          	ld	a4,-24(s0)
     f64:	e398                	sd	a4,0(a5)
     f66:	a039                	j	f74 <schedule_wrr+0x134>
    } else {
        // Idle if no suitable thread is found
        r.scheduled_thread_list_member = args.run_queue;
     f68:	649c                	ld	a5,8(s1)
     f6a:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = 1;
     f6e:	4785                	li	a5,1
     f70:	faf42823          	sw	a5,-80(s0)
    }

    return r;
     f74:	fa843783          	ld	a5,-88(s0)
     f78:	faf43c23          	sd	a5,-72(s0)
     f7c:	fb043783          	ld	a5,-80(s0)
     f80:	fcf43023          	sd	a5,-64(s0)
     f84:	4701                	li	a4,0
     f86:	fb843703          	ld	a4,-72(s0)
     f8a:	4781                	li	a5,0
     f8c:	fc043783          	ld	a5,-64(s0)
     f90:	863a                	mv	a2,a4
     f92:	86be                	mv	a3,a5
     f94:	8732                	mv	a4,a2
     f96:	87b6                	mv	a5,a3
}
     f98:	853a                	mv	a0,a4
     f9a:	85be                	mv	a1,a5
     f9c:	6466                	ld	s0,88(sp)
     f9e:	64c6                	ld	s1,80(sp)
     fa0:	6125                	addi	sp,sp,96
     fa2:	8082                	ret

0000000000000fa4 <schedule_sjf>:

struct threads_sched_result schedule_sjf(struct threads_sched_args args)
{
     fa4:	7119                	addi	sp,sp,-128
     fa6:	fc86                	sd	ra,120(sp)
     fa8:	f8a2                	sd	s0,112(sp)
     faa:	f4a6                	sd	s1,104(sp)
     fac:	f0ca                	sd	s2,96(sp)
     fae:	ecce                	sd	s3,88(sp)
     fb0:	0100                	addi	s0,sp,128
     fb2:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the shortest-job-first scheduling algorithm
    struct thread *shortest_job = NULL;
     fb4:	fc043423          	sd	zero,-56(s0)
    struct thread *t;
    int shortest_time = INT_MAX;
     fb8:	800007b7          	lui	a5,0x80000
     fbc:	fff7c793          	not	a5,a5
     fc0:	faf42e23          	sw	a5,-68(s0)

    // Find the thread with the shortest remaining time that is ready to run
    list_for_each_entry(t, args.run_queue, thread_list) {
     fc4:	649c                	ld	a5,8(s1)
     fc6:	639c                	ld	a5,0(a5)
     fc8:	faf43823          	sd	a5,-80(s0)
     fcc:	fb043783          	ld	a5,-80(s0)
     fd0:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe320>
     fd4:	fcf43023          	sd	a5,-64(s0)
     fd8:	a8a9                	j	1032 <schedule_sjf+0x8e>
        printf("Thread ID: %d, Remaining Time: %d\n", t->ID, t->remaining_time);
     fda:	fc043783          	ld	a5,-64(s0)
     fde:	5fd8                	lw	a4,60(a5)
     fe0:	fc043783          	ld	a5,-64(s0)
     fe4:	4fbc                	lw	a5,88(a5)
     fe6:	863e                	mv	a2,a5
     fe8:	85ba                	mv	a1,a4
     fea:	00000517          	auipc	a0,0x0
     fee:	4a650513          	addi	a0,a0,1190 # 1490 <schedule_dm+0x212>
     ff2:	00000097          	auipc	ra,0x0
     ff6:	a5a080e7          	jalr	-1446(ra) # a4c <printf>
        if (t->remaining_time < shortest_time) {
     ffa:	fc043783          	ld	a5,-64(s0)
     ffe:	4fb8                	lw	a4,88(a5)
    1000:	fbc42783          	lw	a5,-68(s0)
    1004:	2781                	sext.w	a5,a5
    1006:	00f75b63          	bge	a4,a5,101c <schedule_sjf+0x78>
            shortest_time = t->remaining_time;
    100a:	fc043783          	ld	a5,-64(s0)
    100e:	4fbc                	lw	a5,88(a5)
    1010:	faf42e23          	sw	a5,-68(s0)
            shortest_job = t;
    1014:	fc043783          	ld	a5,-64(s0)
    1018:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    101c:	fc043783          	ld	a5,-64(s0)
    1020:	779c                	ld	a5,40(a5)
    1022:	faf43423          	sd	a5,-88(s0)
    1026:	fa843783          	ld	a5,-88(s0)
    102a:	fd878793          	addi	a5,a5,-40
    102e:	fcf43023          	sd	a5,-64(s0)
    1032:	fc043783          	ld	a5,-64(s0)
    1036:	02878713          	addi	a4,a5,40
    103a:	649c                	ld	a5,8(s1)
    103c:	f8f71fe3          	bne	a4,a5,fda <schedule_sjf+0x36>
        }
    }

    if (shortest_job) {
    1040:	fc843783          	ld	a5,-56(s0)
    1044:	cf89                	beqz	a5,105e <schedule_sjf+0xba>
        r.scheduled_thread_list_member = &shortest_job->thread_list;
    1046:	fc843783          	ld	a5,-56(s0)
    104a:	02878793          	addi	a5,a5,40
    104e:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = shortest_job->remaining_time;  // Allow the thread to run to completion
    1052:	fc843783          	ld	a5,-56(s0)
    1056:	4fbc                	lw	a5,88(a5)
    1058:	f8f42823          	sw	a5,-112(s0)
    105c:	a039                	j	106a <schedule_sjf+0xc6>
    } else {
        // If no threads are ready, find the next release time or idle
        r.scheduled_thread_list_member = args.run_queue;
    105e:	649c                	ld	a5,8(s1)
    1060:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = 1;  // Default minimal quantum if unsure
    1064:	4785                	li	a5,1
    1066:	f8f42823          	sw	a5,-112(s0)
    }
    return r;
    106a:	f8843783          	ld	a5,-120(s0)
    106e:	f8f43c23          	sd	a5,-104(s0)
    1072:	f9043783          	ld	a5,-112(s0)
    1076:	faf43023          	sd	a5,-96(s0)
    107a:	4701                	li	a4,0
    107c:	f9843703          	ld	a4,-104(s0)
    1080:	4781                	li	a5,0
    1082:	fa043783          	ld	a5,-96(s0)
    1086:	893a                	mv	s2,a4
    1088:	89be                	mv	s3,a5
    108a:	874a                	mv	a4,s2
    108c:	87ce                	mv	a5,s3
}
    108e:	853a                	mv	a0,a4
    1090:	85be                	mv	a1,a5
    1092:	70e6                	ld	ra,120(sp)
    1094:	7446                	ld	s0,112(sp)
    1096:	74a6                	ld	s1,104(sp)
    1098:	7906                	ld	s2,96(sp)
    109a:	69e6                	ld	s3,88(sp)
    109c:	6109                	addi	sp,sp,128
    109e:	8082                	ret

00000000000010a0 <find_next_release_time>:

int find_next_release_time(struct list_head *release_queue, int current_time) {
    10a0:	7139                	addi	sp,sp,-64
    10a2:	fc22                	sd	s0,56(sp)
    10a4:	0080                	addi	s0,sp,64
    10a6:	fca43423          	sd	a0,-56(s0)
    10aa:	87ae                	mv	a5,a1
    10ac:	fcf42223          	sw	a5,-60(s0)
    struct release_queue_entry *next_release = NULL;
    10b0:	fe043423          	sd	zero,-24(s0)
    int next_release_time = INT_MAX;
    10b4:	800007b7          	lui	a5,0x80000
    10b8:	fff7c793          	not	a5,a5
    10bc:	fef42223          	sw	a5,-28(s0)

    list_for_each_entry(next_release, release_queue, thread_list) {
    10c0:	fc843783          	ld	a5,-56(s0)
    10c4:	639c                	ld	a5,0(a5)
    10c6:	fcf43c23          	sd	a5,-40(s0)
    10ca:	fd843783          	ld	a5,-40(s0)
    10ce:	17e1                	addi	a5,a5,-8
    10d0:	fef43423          	sd	a5,-24(s0)
    10d4:	a081                	j	1114 <find_next_release_time+0x74>
        if (next_release->release_time > current_time &&
    10d6:	fe843783          	ld	a5,-24(s0)
    10da:	4f98                	lw	a4,24(a5)
    10dc:	fc442783          	lw	a5,-60(s0)
    10e0:	2781                	sext.w	a5,a5
    10e2:	00e7df63          	bge	a5,a4,1100 <find_next_release_time+0x60>
            next_release->release_time < next_release_time) {
    10e6:	fe843783          	ld	a5,-24(s0)
    10ea:	4f98                	lw	a4,24(a5)
        if (next_release->release_time > current_time &&
    10ec:	fe442783          	lw	a5,-28(s0)
    10f0:	2781                	sext.w	a5,a5
    10f2:	00f75763          	bge	a4,a5,1100 <find_next_release_time+0x60>
            next_release_time = next_release->release_time;
    10f6:	fe843783          	ld	a5,-24(s0)
    10fa:	4f9c                	lw	a5,24(a5)
    10fc:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(next_release, release_queue, thread_list) {
    1100:	fe843783          	ld	a5,-24(s0)
    1104:	679c                	ld	a5,8(a5)
    1106:	fcf43823          	sd	a5,-48(s0)
    110a:	fd043783          	ld	a5,-48(s0)
    110e:	17e1                	addi	a5,a5,-8
    1110:	fef43423          	sd	a5,-24(s0)
    1114:	fe843783          	ld	a5,-24(s0)
    1118:	07a1                	addi	a5,a5,8
    111a:	fc843703          	ld	a4,-56(s0)
    111e:	faf71ce3          	bne	a4,a5,10d6 <find_next_release_time+0x36>
        }
    }

    if (next_release_time == INT_MAX)
    1122:	fe442783          	lw	a5,-28(s0)
    1126:	0007871b          	sext.w	a4,a5
    112a:	800007b7          	lui	a5,0x80000
    112e:	fff7c793          	not	a5,a5
    1132:	00f71463          	bne	a4,a5,113a <find_next_release_time+0x9a>
        return -1; // No threads in the release queue
    1136:	57fd                	li	a5,-1
    1138:	a801                	j	1148 <find_next_release_time+0xa8>

    return next_release_time - current_time;
    113a:	fe442703          	lw	a4,-28(s0)
    113e:	fc442783          	lw	a5,-60(s0)
    1142:	40f707bb          	subw	a5,a4,a5
    1146:	2781                	sext.w	a5,a5
}
    1148:	853e                	mv	a0,a5
    114a:	7462                	ld	s0,56(sp)
    114c:	6121                	addi	sp,sp,64
    114e:	8082                	ret

0000000000001150 <schedule_lst>:

/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args)
{
    1150:	7119                	addi	sp,sp,-128
    1152:	fc86                	sd	ra,120(sp)
    1154:	f8a2                	sd	s0,112(sp)
    1156:	f4a6                	sd	s1,104(sp)
    1158:	f0ca                	sd	s2,96(sp)
    115a:	ecce                	sd	s3,88(sp)
    115c:	0100                	addi	s0,sp,128
    115e:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the least-slack-time scheduling algorithm
    struct thread *min_slack = NULL;
    1160:	fc043423          	sd	zero,-56(s0)
    int min_slack_time = INT_MAX;
    1164:	800007b7          	lui	a5,0x80000
    1168:	fff7c793          	not	a5,a5
    116c:	fcf42223          	sw	a5,-60(s0)
    struct thread *t;

    // Find the thread with the minimum slack time
    list_for_each_entry(t, args.run_queue, thread_list) {
    1170:	649c                	ld	a5,8(s1)
    1172:	639c                	ld	a5,0(a5)
    1174:	faf43823          	sd	a5,-80(s0)
    1178:	fb043783          	ld	a5,-80(s0)
    117c:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe320>
    1180:	faf43c23          	sd	a5,-72(s0)
    1184:	a8b5                	j	1200 <schedule_lst+0xb0>
        int slack_time = t->deadline - args.current_time - t->remaining_time;
    1186:	fb843783          	ld	a5,-72(s0)
    118a:	47f8                	lw	a4,76(a5)
    118c:	409c                	lw	a5,0(s1)
    118e:	40f707bb          	subw	a5,a4,a5
    1192:	0007871b          	sext.w	a4,a5
    1196:	fb843783          	ld	a5,-72(s0)
    119a:	4fbc                	lw	a5,88(a5)
    119c:	40f707bb          	subw	a5,a4,a5
    11a0:	faf42623          	sw	a5,-84(s0)
        if (min_slack == NULL || slack_time < min_slack_time ||
    11a4:	fc843783          	ld	a5,-56(s0)
    11a8:	cb8d                	beqz	a5,11da <schedule_lst+0x8a>
    11aa:	fac42703          	lw	a4,-84(s0)
    11ae:	fc442783          	lw	a5,-60(s0)
    11b2:	2701                	sext.w	a4,a4
    11b4:	2781                	sext.w	a5,a5
    11b6:	02f74263          	blt	a4,a5,11da <schedule_lst+0x8a>
    11ba:	fac42703          	lw	a4,-84(s0)
    11be:	fc442783          	lw	a5,-60(s0)
    11c2:	2701                	sext.w	a4,a4
    11c4:	2781                	sext.w	a5,a5
    11c6:	02f71263          	bne	a4,a5,11ea <schedule_lst+0x9a>
            (slack_time == min_slack_time && t->ID < min_slack->ID)) {
    11ca:	fb843783          	ld	a5,-72(s0)
    11ce:	5fd8                	lw	a4,60(a5)
    11d0:	fc843783          	ld	a5,-56(s0)
    11d4:	5fdc                	lw	a5,60(a5)
    11d6:	00f75a63          	bge	a4,a5,11ea <schedule_lst+0x9a>
            min_slack = t;
    11da:	fb843783          	ld	a5,-72(s0)
    11de:	fcf43423          	sd	a5,-56(s0)
            min_slack_time = slack_time;
    11e2:	fac42783          	lw	a5,-84(s0)
    11e6:	fcf42223          	sw	a5,-60(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    11ea:	fb843783          	ld	a5,-72(s0)
    11ee:	779c                	ld	a5,40(a5)
    11f0:	faf43023          	sd	a5,-96(s0)
    11f4:	fa043783          	ld	a5,-96(s0)
    11f8:	fd878793          	addi	a5,a5,-40
    11fc:	faf43c23          	sd	a5,-72(s0)
    1200:	fb843783          	ld	a5,-72(s0)
    1204:	02878713          	addi	a4,a5,40
    1208:	649c                	ld	a5,8(s1)
    120a:	f6f71ee3          	bne	a4,a5,1186 <schedule_lst+0x36>
        }
    }

    if (min_slack) {
    120e:	fc843783          	ld	a5,-56(s0)
    1212:	cf89                	beqz	a5,122c <schedule_lst+0xdc>
        r.scheduled_thread_list_member = &min_slack->thread_list;
    1214:	fc843783          	ld	a5,-56(s0)
    1218:	02878793          	addi	a5,a5,40
    121c:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = min_slack->remaining_time;
    1220:	fc843783          	ld	a5,-56(s0)
    1224:	4fbc                	lw	a5,88(a5)
    1226:	f8f42423          	sw	a5,-120(s0)
    122a:	a839                	j	1248 <schedule_lst+0xf8>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
    122c:	649c                	ld	a5,8(s1)
    122e:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    1232:	689c                	ld	a5,16(s1)
    1234:	4098                	lw	a4,0(s1)
    1236:	85ba                	mv	a1,a4
    1238:	853e                	mv	a0,a5
    123a:	00000097          	auipc	ra,0x0
    123e:	e66080e7          	jalr	-410(ra) # 10a0 <find_next_release_time>
    1242:	87aa                	mv	a5,a0
    1244:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    1248:	f8043783          	ld	a5,-128(s0)
    124c:	f8f43823          	sd	a5,-112(s0)
    1250:	f8843783          	ld	a5,-120(s0)
    1254:	f8f43c23          	sd	a5,-104(s0)
    1258:	4701                	li	a4,0
    125a:	f9043703          	ld	a4,-112(s0)
    125e:	4781                	li	a5,0
    1260:	f9843783          	ld	a5,-104(s0)
    1264:	893a                	mv	s2,a4
    1266:	89be                	mv	s3,a5
    1268:	874a                	mv	a4,s2
    126a:	87ce                	mv	a5,s3
}
    126c:	853a                	mv	a0,a4
    126e:	85be                	mv	a1,a5
    1270:	70e6                	ld	ra,120(sp)
    1272:	7446                	ld	s0,112(sp)
    1274:	74a6                	ld	s1,104(sp)
    1276:	7906                	ld	s2,96(sp)
    1278:	69e6                	ld	s3,88(sp)
    127a:	6109                	addi	sp,sp,128
    127c:	8082                	ret

000000000000127e <schedule_dm>:

/* Deadline-Monotonic Scheduling */
struct threads_sched_result schedule_dm(struct threads_sched_args args)
{
    127e:	7135                	addi	sp,sp,-160
    1280:	ed06                	sd	ra,152(sp)
    1282:	e922                	sd	s0,144(sp)
    1284:	e526                	sd	s1,136(sp)
    1286:	e14a                	sd	s2,128(sp)
    1288:	fcce                	sd	s3,120(sp)
    128a:	1100                	addi	s0,sp,160
    128c:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the deadline-monotonic scheduling algorithm
   struct thread *earliest_deadline_thread = NULL;
    128e:	fc043423          	sd	zero,-56(s0)
    struct thread *t;
    int earliest_deadline = INT_MAX;
    1292:	800007b7          	lui	a5,0x80000
    1296:	fff7c793          	not	a5,a5
    129a:	faf42e23          	sw	a5,-68(s0)

    // Find the earliest deadline real-time thread
    list_for_each_entry(t, args.run_queue, thread_list) {
    129e:	649c                	ld	a5,8(s1)
    12a0:	639c                	ld	a5,0(a5)
    12a2:	faf43423          	sd	a5,-88(s0)
    12a6:	fa843783          	ld	a5,-88(s0)
    12aa:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffe320>
    12ae:	fcf43023          	sd	a5,-64(s0)
    12b2:	a841                	j	1342 <schedule_dm+0xc4>
        if (t->is_real_time && t->period != -1 && t->current_deadline < earliest_deadline) {
    12b4:	fc043783          	ld	a5,-64(s0)
    12b8:	43bc                	lw	a5,64(a5)
    12ba:	cb95                	beqz	a5,12ee <schedule_dm+0x70>
    12bc:	fc043783          	ld	a5,-64(s0)
    12c0:	4bbc                	lw	a5,80(a5)
    12c2:	873e                	mv	a4,a5
    12c4:	57fd                	li	a5,-1
    12c6:	02f70463          	beq	a4,a5,12ee <schedule_dm+0x70>
    12ca:	fc043783          	ld	a5,-64(s0)
    12ce:	4ff8                	lw	a4,92(a5)
    12d0:	fbc42783          	lw	a5,-68(s0)
    12d4:	2781                	sext.w	a5,a5
    12d6:	00f75c63          	bge	a4,a5,12ee <schedule_dm+0x70>
            earliest_deadline = t->current_deadline;
    12da:	fc043783          	ld	a5,-64(s0)
    12de:	4ffc                	lw	a5,92(a5)
    12e0:	faf42e23          	sw	a5,-68(s0)
            earliest_deadline_thread = t;
    12e4:	fc043783          	ld	a5,-64(s0)
    12e8:	fcf43423          	sd	a5,-56(s0)
    12ec:	a081                	j	132c <schedule_dm+0xae>
        } else if (t->is_real_time && t->period != -1 && t->current_deadline == earliest_deadline && t->ID < earliest_deadline_thread->ID) {
    12ee:	fc043783          	ld	a5,-64(s0)
    12f2:	43bc                	lw	a5,64(a5)
    12f4:	cf85                	beqz	a5,132c <schedule_dm+0xae>
    12f6:	fc043783          	ld	a5,-64(s0)
    12fa:	4bbc                	lw	a5,80(a5)
    12fc:	873e                	mv	a4,a5
    12fe:	57fd                	li	a5,-1
    1300:	02f70663          	beq	a4,a5,132c <schedule_dm+0xae>
    1304:	fc043783          	ld	a5,-64(s0)
    1308:	4ff8                	lw	a4,92(a5)
    130a:	fbc42783          	lw	a5,-68(s0)
    130e:	2781                	sext.w	a5,a5
    1310:	00e79e63          	bne	a5,a4,132c <schedule_dm+0xae>
    1314:	fc043783          	ld	a5,-64(s0)
    1318:	5fd8                	lw	a4,60(a5)
    131a:	fc843783          	ld	a5,-56(s0)
    131e:	5fdc                	lw	a5,60(a5)
    1320:	00f75663          	bge	a4,a5,132c <schedule_dm+0xae>
            earliest_deadline_thread = t;  // Tie-breaking by ID
    1324:	fc043783          	ld	a5,-64(s0)
    1328:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    132c:	fc043783          	ld	a5,-64(s0)
    1330:	779c                	ld	a5,40(a5)
    1332:	f8f43423          	sd	a5,-120(s0)
    1336:	f8843783          	ld	a5,-120(s0)
    133a:	fd878793          	addi	a5,a5,-40
    133e:	fcf43023          	sd	a5,-64(s0)
    1342:	fc043783          	ld	a5,-64(s0)
    1346:	02878713          	addi	a4,a5,40
    134a:	649c                	ld	a5,8(s1)
    134c:	f6f714e3          	bne	a4,a5,12b4 <schedule_dm+0x36>
        }
    }

    if (earliest_deadline_thread) {
    1350:	fc843783          	ld	a5,-56(s0)
    1354:	c7a5                	beqz	a5,13bc <schedule_dm+0x13e>
        int time_to_deadline = earliest_deadline_thread->current_deadline - args.current_time;
    1356:	fc843783          	ld	a5,-56(s0)
    135a:	4ff8                	lw	a4,92(a5)
    135c:	409c                	lw	a5,0(s1)
    135e:	40f707bb          	subw	a5,a4,a5
    1362:	f8f42a23          	sw	a5,-108(s0)
        if (earliest_deadline_thread->remaining_time > time_to_deadline) {
    1366:	fc843783          	ld	a5,-56(s0)
    136a:	4fb8                	lw	a4,88(a5)
    136c:	f9442783          	lw	a5,-108(s0)
    1370:	2781                	sext.w	a5,a5
    1372:	00e7db63          	bge	a5,a4,1388 <schedule_dm+0x10a>
            // The real-time thread cannot complete before its deadline, so handle the deadline miss
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    1376:	fc843783          	ld	a5,-56(s0)
    137a:	02878793          	addi	a5,a5,40
    137e:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = 0; // Could set to minimal quantum to allow cleanup or logging
    1382:	f6042823          	sw	zero,-144(s0)
    1386:	a0f1                	j	1452 <schedule_dm+0x1d4>
        } else {
            // Schedule the real-time thread normally if it hasn't missed its deadline
            int time_slice = (time_to_deadline < earliest_deadline_thread->remaining_time) ? time_to_deadline : earliest_deadline_thread->remaining_time;
    1388:	fc843783          	ld	a5,-56(s0)
    138c:	4fbc                	lw	a5,88(a5)
    138e:	863e                	mv	a2,a5
    1390:	f9442783          	lw	a5,-108(s0)
    1394:	0007869b          	sext.w	a3,a5
    1398:	0006071b          	sext.w	a4,a2
    139c:	00d75363          	bge	a4,a3,13a2 <schedule_dm+0x124>
    13a0:	87b2                	mv	a5,a2
    13a2:	f8f42823          	sw	a5,-112(s0)
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    13a6:	fc843783          	ld	a5,-56(s0)
    13aa:	02878793          	addi	a5,a5,40
    13ae:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = time_slice;
    13b2:	f9042783          	lw	a5,-112(s0)
    13b6:	f6f42823          	sw	a5,-144(s0)
    13ba:	a861                	j	1452 <schedule_dm+0x1d4>
        }
    } else {
        // If no real-time threads with a deadline are ready, find the thread with the smallest ID
        struct thread *smallest_id_thread = NULL;
    13bc:	fa043823          	sd	zero,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    13c0:	649c                	ld	a5,8(s1)
    13c2:	639c                	ld	a5,0(a5)
    13c4:	faf43023          	sd	a5,-96(s0)
    13c8:	fa043783          	ld	a5,-96(s0)
    13cc:	fd878793          	addi	a5,a5,-40
    13d0:	fcf43023          	sd	a5,-64(s0)
    13d4:	a81d                	j	140a <schedule_dm+0x18c>
            if (smallest_id_thread == NULL || t->ID < smallest_id_thread->ID) {
    13d6:	fb043783          	ld	a5,-80(s0)
    13da:	cb89                	beqz	a5,13ec <schedule_dm+0x16e>
    13dc:	fc043783          	ld	a5,-64(s0)
    13e0:	5fd8                	lw	a4,60(a5)
    13e2:	fb043783          	ld	a5,-80(s0)
    13e6:	5fdc                	lw	a5,60(a5)
    13e8:	00f75663          	bge	a4,a5,13f4 <schedule_dm+0x176>
                smallest_id_thread = t;
    13ec:	fc043783          	ld	a5,-64(s0)
    13f0:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    13f4:	fc043783          	ld	a5,-64(s0)
    13f8:	779c                	ld	a5,40(a5)
    13fa:	f8f43c23          	sd	a5,-104(s0)
    13fe:	f9843783          	ld	a5,-104(s0)
    1402:	fd878793          	addi	a5,a5,-40
    1406:	fcf43023          	sd	a5,-64(s0)
    140a:	fc043783          	ld	a5,-64(s0)
    140e:	02878713          	addi	a4,a5,40
    1412:	649c                	ld	a5,8(s1)
    1414:	fcf711e3          	bne	a4,a5,13d6 <schedule_dm+0x158>
            }
        }

        if (smallest_id_thread) {
    1418:	fb043783          	ld	a5,-80(s0)
    141c:	cf89                	beqz	a5,1436 <schedule_dm+0x1b8>
            r.scheduled_thread_list_member = &smallest_id_thread->thread_list;
    141e:	fb043783          	ld	a5,-80(s0)
    1422:	02878793          	addi	a5,a5,40
    1426:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = smallest_id_thread->remaining_time;
    142a:	fb043783          	ld	a5,-80(s0)
    142e:	4fbc                	lw	a5,88(a5)
    1430:	f6f42823          	sw	a5,-144(s0)
    1434:	a839                	j	1452 <schedule_dm+0x1d4>
        } else {
            // If no thread is ready, perhaps idle or find the next release time
            r.scheduled_thread_list_member = args.run_queue;
    1436:	649c                	ld	a5,8(s1)
    1438:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    143c:	689c                	ld	a5,16(s1)
    143e:	4098                	lw	a4,0(s1)
    1440:	85ba                	mv	a1,a4
    1442:	853e                	mv	a0,a5
    1444:	00000097          	auipc	ra,0x0
    1448:	c5c080e7          	jalr	-932(ra) # 10a0 <find_next_release_time>
    144c:	87aa                	mv	a5,a0
    144e:	f6f42823          	sw	a5,-144(s0)
        }
    }

    return r;
    1452:	f6843783          	ld	a5,-152(s0)
    1456:	f6f43c23          	sd	a5,-136(s0)
    145a:	f7043783          	ld	a5,-144(s0)
    145e:	f8f43023          	sd	a5,-128(s0)
    1462:	4701                	li	a4,0
    1464:	f7843703          	ld	a4,-136(s0)
    1468:	4781                	li	a5,0
    146a:	f8043783          	ld	a5,-128(s0)
    146e:	893a                	mv	s2,a4
    1470:	89be                	mv	s3,a5
    1472:	874a                	mv	a4,s2
    1474:	87ce                	mv	a5,s3
}
    1476:	853a                	mv	a0,a4
    1478:	85be                	mv	a1,a5
    147a:	60ea                	ld	ra,152(sp)
    147c:	644a                	ld	s0,144(sp)
    147e:	64aa                	ld	s1,136(sp)
    1480:	690a                	ld	s2,128(sp)
    1482:	79e6                	ld	s3,120(sp)
    1484:	610d                	addi	sp,sp,160
    1486:	8082                	ret
