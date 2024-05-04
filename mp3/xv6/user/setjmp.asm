
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
     66e:	1b668693          	addi	a3,a3,438 # 1820 <digits>
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
     748:	0dc70713          	addi	a4,a4,220 # 1820 <digits>
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
     908:	f1478793          	addi	a5,a5,-236 # 1818 <schedule_dm+0x17a>
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
     ab4:	d9878793          	addi	a5,a5,-616 # 1848 <freep>
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
     bac:	ca078793          	addi	a5,a5,-864 # 1848 <freep>
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
     c2e:	c1e78793          	addi	a5,a5,-994 # 1848 <freep>
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
     c60:	bec78793          	addi	a5,a5,-1044 # 1848 <freep>
     c64:	639c                	ld	a5,0(a5)
     c66:	fef43023          	sd	a5,-32(s0)
     c6a:	fe043783          	ld	a5,-32(s0)
     c6e:	ef95                	bnez	a5,caa <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     c70:	00001797          	auipc	a5,0x1
     c74:	bc878793          	addi	a5,a5,-1080 # 1838 <base>
     c78:	fef43023          	sd	a5,-32(s0)
     c7c:	00001797          	auipc	a5,0x1
     c80:	bcc78793          	addi	a5,a5,-1076 # 1848 <freep>
     c84:	fe043703          	ld	a4,-32(s0)
     c88:	e398                	sd	a4,0(a5)
     c8a:	00001797          	auipc	a5,0x1
     c8e:	bbe78793          	addi	a5,a5,-1090 # 1848 <freep>
     c92:	6398                	ld	a4,0(a5)
     c94:	00001797          	auipc	a5,0x1
     c98:	ba478793          	addi	a5,a5,-1116 # 1838 <base>
     c9c:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     c9e:	00001797          	auipc	a5,0x1
     ca2:	b9a78793          	addi	a5,a5,-1126 # 1838 <base>
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
     d1e:	b2e78793          	addi	a5,a5,-1234 # 1848 <freep>
     d22:	fe043703          	ld	a4,-32(s0)
     d26:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     d28:	fe843783          	ld	a5,-24(s0)
     d2c:	07c1                	addi	a5,a5,16
     d2e:	a091                	j	d72 <malloc+0x134>
    }
    if(p == freep)
     d30:	00001797          	auipc	a5,0x1
     d34:	b1878793          	addi	a5,a5,-1256 # 1848 <freep>
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
     e52:	00001797          	auipc	a5,0x1
     e56:	9fe78793          	addi	a5,a5,-1538 # 1850 <last_thread.1226>
     e5a:	639c                	ld	a5,0(a5)
     e5c:	cb89                	beqz	a5,e6e <schedule_wrr+0x2e>
     e5e:	00001797          	auipc	a5,0x1
     e62:	9f278793          	addi	a5,a5,-1550 # 1850 <last_thread.1226>
     e66:	639c                	ld	a5,0(a5)
     e68:	4fbc                	lw	a5,88(a5)
     e6a:	00f04863          	bgtz	a5,e7a <schedule_wrr+0x3a>
        last_thread = NULL;
     e6e:	00001797          	auipc	a5,0x1
     e72:	9e278793          	addi	a5,a5,-1566 # 1850 <last_thread.1226>
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
     e90:	00001797          	auipc	a5,0x1
     e94:	9c078793          	addi	a5,a5,-1600 # 1850 <last_thread.1226>
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
     eec:	00001797          	auipc	a5,0x1
     ef0:	96478793          	addi	a5,a5,-1692 # 1850 <last_thread.1226>
     ef4:	639c                	ld	a5,0(a5)
     ef6:	c385                	beqz	a5,f16 <schedule_wrr+0xd6>
     ef8:	00001797          	auipc	a5,0x1
     efc:	95878793          	addi	a5,a5,-1704 # 1850 <last_thread.1226>
     f00:	639c                	ld	a5,0(a5)
     f02:	4fbc                	lw	a5,88(a5)
     f04:	00f05963          	blez	a5,f16 <schedule_wrr+0xd6>
        selected_thread = last_thread;
     f08:	00001797          	auipc	a5,0x1
     f0c:	94878793          	addi	a5,a5,-1720 # 1850 <last_thread.1226>
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
     f58:	00001797          	auipc	a5,0x1
     f5c:	8f878793          	addi	a5,a5,-1800 # 1850 <last_thread.1226>
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

0000000000000fa4 <find_next_release_time>:

int find_next_release_time(struct list_head *release_queue, int current_time) {
     fa4:	7139                	addi	sp,sp,-64
     fa6:	fc22                	sd	s0,56(sp)
     fa8:	0080                	addi	s0,sp,64
     faa:	fca43423          	sd	a0,-56(s0)
     fae:	87ae                	mv	a5,a1
     fb0:	fcf42223          	sw	a5,-60(s0)
    struct release_queue_entry *next_release = NULL;
     fb4:	fe043423          	sd	zero,-24(s0)
    int next_release_time = INT_MAX;
     fb8:	800007b7          	lui	a5,0x80000
     fbc:	fff7c793          	not	a5,a5
     fc0:	fef42223          	sw	a5,-28(s0)

    list_for_each_entry(next_release, release_queue, thread_list) {
     fc4:	fc843783          	ld	a5,-56(s0)
     fc8:	639c                	ld	a5,0(a5)
     fca:	fcf43c23          	sd	a5,-40(s0)
     fce:	fd843783          	ld	a5,-40(s0)
     fd2:	17e1                	addi	a5,a5,-8
     fd4:	fef43423          	sd	a5,-24(s0)
     fd8:	a081                	j	1018 <find_next_release_time+0x74>
        if (next_release->release_time > current_time && next_release->release_time < next_release_time) {
     fda:	fe843783          	ld	a5,-24(s0)
     fde:	4f98                	lw	a4,24(a5)
     fe0:	fc442783          	lw	a5,-60(s0)
     fe4:	2781                	sext.w	a5,a5
     fe6:	00e7df63          	bge	a5,a4,1004 <find_next_release_time+0x60>
     fea:	fe843783          	ld	a5,-24(s0)
     fee:	4f98                	lw	a4,24(a5)
     ff0:	fe442783          	lw	a5,-28(s0)
     ff4:	2781                	sext.w	a5,a5
     ff6:	00f75763          	bge	a4,a5,1004 <find_next_release_time+0x60>
            next_release_time = next_release->release_time;
     ffa:	fe843783          	ld	a5,-24(s0)
     ffe:	4f9c                	lw	a5,24(a5)
    1000:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(next_release, release_queue, thread_list) {
    1004:	fe843783          	ld	a5,-24(s0)
    1008:	679c                	ld	a5,8(a5)
    100a:	fcf43823          	sd	a5,-48(s0)
    100e:	fd043783          	ld	a5,-48(s0)
    1012:	17e1                	addi	a5,a5,-8
    1014:	fef43423          	sd	a5,-24(s0)
    1018:	fe843783          	ld	a5,-24(s0)
    101c:	07a1                	addi	a5,a5,8
    101e:	fc843703          	ld	a4,-56(s0)
    1022:	faf71ce3          	bne	a4,a5,fda <find_next_release_time+0x36>
        }
    }

    if (next_release_time == INT_MAX)
    1026:	fe442783          	lw	a5,-28(s0)
    102a:	0007871b          	sext.w	a4,a5
    102e:	800007b7          	lui	a5,0x80000
    1032:	fff7c793          	not	a5,a5
    1036:	00f71463          	bne	a4,a5,103e <find_next_release_time+0x9a>
        return -1; // No threads in the release queue
    103a:	57fd                	li	a5,-1
    103c:	a801                	j	104c <find_next_release_time+0xa8>

    return next_release_time - current_time;
    103e:	fe442703          	lw	a4,-28(s0)
    1042:	fc442783          	lw	a5,-60(s0)
    1046:	40f707bb          	subw	a5,a4,a5
    104a:	2781                	sext.w	a5,a5
}
    104c:	853e                	mv	a0,a5
    104e:	7462                	ld	s0,56(sp)
    1050:	6121                	addi	sp,sp,64
    1052:	8082                	ret

0000000000001054 <find_earliest_impactful_release_time>:



int find_earliest_impactful_release_time(struct list_head *release_queue, struct list_head *run_queue, int current_time) {
    1054:	7159                	addi	sp,sp,-112
    1056:	f4a2                	sd	s0,104(sp)
    1058:	1880                	addi	s0,sp,112
    105a:	faa43423          	sd	a0,-88(s0)
    105e:	fab43023          	sd	a1,-96(s0)
    1062:	87b2                	mv	a5,a2
    1064:	f8f42e23          	sw	a5,-100(s0)
    struct release_queue_entry *entry;
    int earliest_impactful_time = INT_MAX;
    1068:	800007b7          	lui	a5,0x80000
    106c:	fff7c793          	not	a5,a5
    1070:	fef42223          	sw	a5,-28(s0)
    int shortest_current_time = INT_MAX;
    1074:	800007b7          	lui	a5,0x80000
    1078:	fff7c793          	not	a5,a5
    107c:	fef42023          	sw	a5,-32(s0)

    // Find the shortest remaining time among currently running tasks
    struct thread *t;
    list_for_each_entry(t, run_queue, thread_list) {
    1080:	fa043783          	ld	a5,-96(s0)
    1084:	639c                	ld	a5,0(a5)
    1086:	fcf43823          	sd	a5,-48(s0)
    108a:	fd043783          	ld	a5,-48(s0)
    108e:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffdfb8>
    1092:	fcf43c23          	sd	a5,-40(s0)
    1096:	a80d                	j	10c8 <find_earliest_impactful_release_time+0x74>
        if (t->remaining_time < shortest_current_time) {
    1098:	fd843783          	ld	a5,-40(s0)
    109c:	4fb8                	lw	a4,88(a5)
    109e:	fe042783          	lw	a5,-32(s0)
    10a2:	2781                	sext.w	a5,a5
    10a4:	00f75763          	bge	a4,a5,10b2 <find_earliest_impactful_release_time+0x5e>
            shortest_current_time = t->remaining_time;
    10a8:	fd843783          	ld	a5,-40(s0)
    10ac:	4fbc                	lw	a5,88(a5)
    10ae:	fef42023          	sw	a5,-32(s0)
    list_for_each_entry(t, run_queue, thread_list) {
    10b2:	fd843783          	ld	a5,-40(s0)
    10b6:	779c                	ld	a5,40(a5)
    10b8:	faf43c23          	sd	a5,-72(s0)
    10bc:	fb843783          	ld	a5,-72(s0)
    10c0:	fd878793          	addi	a5,a5,-40
    10c4:	fcf43c23          	sd	a5,-40(s0)
    10c8:	fd843783          	ld	a5,-40(s0)
    10cc:	02878793          	addi	a5,a5,40
    10d0:	fa043703          	ld	a4,-96(s0)
    10d4:	fcf712e3          	bne	a4,a5,1098 <find_earliest_impactful_release_time+0x44>
        }
    }

    // Check the release queue for the next task that might preempt the current shortest job
    list_for_each_entry(entry, release_queue, thread_list) {
    10d8:	fa843783          	ld	a5,-88(s0)
    10dc:	639c                	ld	a5,0(a5)
    10de:	fcf43423          	sd	a5,-56(s0)
    10e2:	fc843783          	ld	a5,-56(s0)
    10e6:	17e1                	addi	a5,a5,-8
    10e8:	fef43423          	sd	a5,-24(s0)
    10ec:	a889                	j	113e <find_earliest_impactful_release_time+0xea>
        if (entry->release_time > current_time && entry->release_time < earliest_impactful_time) {
    10ee:	fe843783          	ld	a5,-24(s0)
    10f2:	4f98                	lw	a4,24(a5)
    10f4:	f9c42783          	lw	a5,-100(s0)
    10f8:	2781                	sext.w	a5,a5
    10fa:	02e7d863          	bge	a5,a4,112a <find_earliest_impactful_release_time+0xd6>
    10fe:	fe843783          	ld	a5,-24(s0)
    1102:	4f98                	lw	a4,24(a5)
    1104:	fe442783          	lw	a5,-28(s0)
    1108:	2781                	sext.w	a5,a5
    110a:	02f75063          	bge	a4,a5,112a <find_earliest_impactful_release_time+0xd6>
            if (entry->thrd->remaining_time < shortest_current_time) {
    110e:	fe843783          	ld	a5,-24(s0)
    1112:	639c                	ld	a5,0(a5)
    1114:	4fb8                	lw	a4,88(a5)
    1116:	fe042783          	lw	a5,-32(s0)
    111a:	2781                	sext.w	a5,a5
    111c:	00f75763          	bge	a4,a5,112a <find_earliest_impactful_release_time+0xd6>
                earliest_impactful_time = entry->release_time;
    1120:	fe843783          	ld	a5,-24(s0)
    1124:	4f9c                	lw	a5,24(a5)
    1126:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(entry, release_queue, thread_list) {
    112a:	fe843783          	ld	a5,-24(s0)
    112e:	679c                	ld	a5,8(a5)
    1130:	fcf43023          	sd	a5,-64(s0)
    1134:	fc043783          	ld	a5,-64(s0)
    1138:	17e1                	addi	a5,a5,-8
    113a:	fef43423          	sd	a5,-24(s0)
    113e:	fe843783          	ld	a5,-24(s0)
    1142:	07a1                	addi	a5,a5,8
    1144:	fa843703          	ld	a4,-88(s0)
    1148:	faf713e3          	bne	a4,a5,10ee <find_earliest_impactful_release_time+0x9a>
            }
        }
    }

    // Calculate the difference between the current time and the earliest impactful release time
    return earliest_impactful_time == INT_MAX ? -1 : earliest_impactful_time - current_time;
    114c:	fe442783          	lw	a5,-28(s0)
    1150:	0007871b          	sext.w	a4,a5
    1154:	800007b7          	lui	a5,0x80000
    1158:	fff7c793          	not	a5,a5
    115c:	00f70a63          	beq	a4,a5,1170 <find_earliest_impactful_release_time+0x11c>
    1160:	fe442703          	lw	a4,-28(s0)
    1164:	f9c42783          	lw	a5,-100(s0)
    1168:	40f707bb          	subw	a5,a4,a5
    116c:	2781                	sext.w	a5,a5
    116e:	a011                	j	1172 <find_earliest_impactful_release_time+0x11e>
    1170:	57fd                	li	a5,-1
}
    1172:	853e                	mv	a0,a5
    1174:	7426                	ld	s0,104(sp)
    1176:	6165                	addi	sp,sp,112
    1178:	8082                	ret

000000000000117a <schedule_sjf>:


struct threads_sched_result schedule_sjf(struct threads_sched_args args) {
    117a:	7119                	addi	sp,sp,-128
    117c:	fc86                	sd	ra,120(sp)
    117e:	f8a2                	sd	s0,112(sp)
    1180:	f4a6                	sd	s1,104(sp)
    1182:	f0ca                	sd	s2,96(sp)
    1184:	ecce                	sd	s3,88(sp)
    1186:	0100                	addi	s0,sp,128
    1188:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *shortest_job = NULL;
    118a:	fc043423          	sd	zero,-56(s0)
    struct thread *current;
    int shortest_time = INT_MAX;
    118e:	800007b7          	lui	a5,0x80000
    1192:	fff7c793          	not	a5,a5
    1196:	faf42e23          	sw	a5,-68(s0)
    int earliest_impactful_time = find_earliest_impactful_release_time(args.release_queue, args.run_queue, args.current_time);
    119a:	689c                	ld	a5,16(s1)
    119c:	6498                	ld	a4,8(s1)
    119e:	4094                	lw	a3,0(s1)
    11a0:	8636                	mv	a2,a3
    11a2:	85ba                	mv	a1,a4
    11a4:	853e                	mv	a0,a5
    11a6:	00000097          	auipc	ra,0x0
    11aa:	eae080e7          	jalr	-338(ra) # 1054 <find_earliest_impactful_release_time>
    11ae:	87aa                	mv	a5,a0
    11b0:	faf42a23          	sw	a5,-76(s0)

    // Determine the shortest job from the run queue
    list_for_each_entry(current, args.run_queue, thread_list) {
    11b4:	649c                	ld	a5,8(s1)
    11b6:	639c                	ld	a5,0(a5)
    11b8:	faf43423          	sd	a5,-88(s0)
    11bc:	fa843783          	ld	a5,-88(s0)
    11c0:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffdfb8>
    11c4:	fcf43023          	sd	a5,-64(s0)
    11c8:	a82d                	j	1202 <schedule_sjf+0x88>
        if (current->remaining_time < shortest_time) {
    11ca:	fc043783          	ld	a5,-64(s0)
    11ce:	4fb8                	lw	a4,88(a5)
    11d0:	fbc42783          	lw	a5,-68(s0)
    11d4:	2781                	sext.w	a5,a5
    11d6:	00f75b63          	bge	a4,a5,11ec <schedule_sjf+0x72>
            shortest_time = current->remaining_time;
    11da:	fc043783          	ld	a5,-64(s0)
    11de:	4fbc                	lw	a5,88(a5)
    11e0:	faf42e23          	sw	a5,-68(s0)
            shortest_job = current;
    11e4:	fc043783          	ld	a5,-64(s0)
    11e8:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(current, args.run_queue, thread_list) {
    11ec:	fc043783          	ld	a5,-64(s0)
    11f0:	779c                	ld	a5,40(a5)
    11f2:	faf43023          	sd	a5,-96(s0)
    11f6:	fa043783          	ld	a5,-96(s0)
    11fa:	fd878793          	addi	a5,a5,-40
    11fe:	fcf43023          	sd	a5,-64(s0)
    1202:	fc043783          	ld	a5,-64(s0)
    1206:	02878713          	addi	a4,a5,40
    120a:	649c                	ld	a5,8(s1)
    120c:	faf71fe3          	bne	a4,a5,11ca <schedule_sjf+0x50>
        }
    }

    if (shortest_job) {
    1210:	fc843783          	ld	a5,-56(s0)
    1214:	c7a1                	beqz	a5,125c <schedule_sjf+0xe2>
        int time_to_allocate = shortest_job->remaining_time;
    1216:	fc843783          	ld	a5,-56(s0)
    121a:	4fbc                	lw	a5,88(a5)
    121c:	faf42c23          	sw	a5,-72(s0)
        // Reduce the time slice if an impactful task is arriving sooner
        if (earliest_impactful_time != -1 && earliest_impactful_time < time_to_allocate) {
    1220:	fb442783          	lw	a5,-76(s0)
    1224:	0007871b          	sext.w	a4,a5
    1228:	57fd                	li	a5,-1
    122a:	00f70e63          	beq	a4,a5,1246 <schedule_sjf+0xcc>
    122e:	fb442703          	lw	a4,-76(s0)
    1232:	fb842783          	lw	a5,-72(s0)
    1236:	2701                	sext.w	a4,a4
    1238:	2781                	sext.w	a5,a5
    123a:	00f75663          	bge	a4,a5,1246 <schedule_sjf+0xcc>
            time_to_allocate = earliest_impactful_time;
    123e:	fb442783          	lw	a5,-76(s0)
    1242:	faf42c23          	sw	a5,-72(s0)
        }

        r.scheduled_thread_list_member = &shortest_job->thread_list;
    1246:	fc843783          	ld	a5,-56(s0)
    124a:	02878793          	addi	a5,a5,40
    124e:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = time_to_allocate;
    1252:	fb842783          	lw	a5,-72(s0)
    1256:	f8f42423          	sw	a5,-120(s0)
    125a:	a80d                	j	128c <schedule_sjf+0x112>
    } else {
        // If no current tasks are ready, wait for the next impactful task
        r.scheduled_thread_list_member = args.run_queue;
    125c:	649c                	ld	a5,8(s1)
    125e:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = earliest_impactful_time != -1 ? earliest_impactful_time : find_next_release_time(args.release_queue, args.current_time);
    1262:	fb442783          	lw	a5,-76(s0)
    1266:	0007871b          	sext.w	a4,a5
    126a:	57fd                	li	a5,-1
    126c:	00f71c63          	bne	a4,a5,1284 <schedule_sjf+0x10a>
    1270:	689c                	ld	a5,16(s1)
    1272:	4098                	lw	a4,0(s1)
    1274:	85ba                	mv	a1,a4
    1276:	853e                	mv	a0,a5
    1278:	00000097          	auipc	ra,0x0
    127c:	d2c080e7          	jalr	-724(ra) # fa4 <find_next_release_time>
    1280:	87aa                	mv	a5,a0
    1282:	a019                	j	1288 <schedule_sjf+0x10e>
    1284:	fb442783          	lw	a5,-76(s0)
    1288:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    128c:	f8043783          	ld	a5,-128(s0)
    1290:	f8f43823          	sd	a5,-112(s0)
    1294:	f8843783          	ld	a5,-120(s0)
    1298:	f8f43c23          	sd	a5,-104(s0)
    129c:	4701                	li	a4,0
    129e:	f9043703          	ld	a4,-112(s0)
    12a2:	4781                	li	a5,0
    12a4:	f9843783          	ld	a5,-104(s0)
    12a8:	893a                	mv	s2,a4
    12aa:	89be                	mv	s3,a5
    12ac:	874a                	mv	a4,s2
    12ae:	87ce                	mv	a5,s3
}
    12b0:	853a                	mv	a0,a4
    12b2:	85be                	mv	a1,a5
    12b4:	70e6                	ld	ra,120(sp)
    12b6:	7446                	ld	s0,112(sp)
    12b8:	74a6                	ld	s1,104(sp)
    12ba:	7906                	ld	s2,96(sp)
    12bc:	69e6                	ld	s3,88(sp)
    12be:	6109                	addi	sp,sp,128
    12c0:	8082                	ret

00000000000012c2 <min>:

int min(int a, int b) {
    12c2:	1101                	addi	sp,sp,-32
    12c4:	ec22                	sd	s0,24(sp)
    12c6:	1000                	addi	s0,sp,32
    12c8:	87aa                	mv	a5,a0
    12ca:	872e                	mv	a4,a1
    12cc:	fef42623          	sw	a5,-20(s0)
    12d0:	87ba                	mv	a5,a4
    12d2:	fef42423          	sw	a5,-24(s0)
    return (a < b) ? a : b;
    12d6:	fec42603          	lw	a2,-20(s0)
    12da:	fe842783          	lw	a5,-24(s0)
    12de:	0007869b          	sext.w	a3,a5
    12e2:	0006071b          	sext.w	a4,a2
    12e6:	00d75363          	bge	a4,a3,12ec <min+0x2a>
    12ea:	87b2                	mv	a5,a2
    12ec:	2781                	sext.w	a5,a5
}
    12ee:	853e                	mv	a0,a5
    12f0:	6462                	ld	s0,24(sp)
    12f2:	6105                	addi	sp,sp,32
    12f4:	8082                	ret

00000000000012f6 <schedule_lst>:

/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args) {
    12f6:	7131                	addi	sp,sp,-192
    12f8:	fd06                	sd	ra,184(sp)
    12fa:	f922                	sd	s0,176(sp)
    12fc:	f526                	sd	s1,168(sp)
    12fe:	f14a                	sd	s2,160(sp)
    1300:	ed4e                	sd	s3,152(sp)
    1302:	0180                	addi	s0,sp,192
    1304:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *min_slack_thread = NULL;
    1306:	fc043423          	sd	zero,-56(s0)
    int min_slack_time = INT_MAX;
    130a:	800007b7          	lui	a5,0x80000
    130e:	fff7c793          	not	a5,a5
    1312:	fcf42223          	sw	a5,-60(s0)
    struct thread *t;
    // int ddl;
    // Determine the thread with the minimum slack time
    list_for_each_entry(t, args.run_queue, thread_list) {
    1316:	649c                	ld	a5,8(s1)
    1318:	639c                	ld	a5,0(a5)
    131a:	faf43023          	sd	a5,-96(s0)
    131e:	fa043783          	ld	a5,-96(s0)
    1322:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffdfb8>
    1326:	faf43c23          	sd	a5,-72(s0)
    132a:	a069                	j	13b4 <schedule_lst+0xbe>
        int slack_time = t->current_deadline - args.current_time - t->remaining_time;
    132c:	fb843783          	ld	a5,-72(s0)
    1330:	4ff8                	lw	a4,92(a5)
    1332:	409c                	lw	a5,0(s1)
    1334:	40f707bb          	subw	a5,a4,a5
    1338:	0007871b          	sext.w	a4,a5
    133c:	fb843783          	ld	a5,-72(s0)
    1340:	4fbc                	lw	a5,88(a5)
    1342:	40f707bb          	subw	a5,a4,a5
    1346:	f6f42a23          	sw	a5,-140(s0)
        if (slack_time < min_slack_time || (slack_time == min_slack_time && t->ID < (min_slack_thread ? min_slack_thread->ID : INT_MAX))) {
    134a:	f7442703          	lw	a4,-140(s0)
    134e:	fc442783          	lw	a5,-60(s0)
    1352:	2701                	sext.w	a4,a4
    1354:	2781                	sext.w	a5,a5
    1356:	02f74c63          	blt	a4,a5,138e <schedule_lst+0x98>
    135a:	f7442703          	lw	a4,-140(s0)
    135e:	fc442783          	lw	a5,-60(s0)
    1362:	2701                	sext.w	a4,a4
    1364:	2781                	sext.w	a5,a5
    1366:	02f71c63          	bne	a4,a5,139e <schedule_lst+0xa8>
    136a:	fb843783          	ld	a5,-72(s0)
    136e:	5fd4                	lw	a3,60(a5)
    1370:	fc843783          	ld	a5,-56(s0)
    1374:	c789                	beqz	a5,137e <schedule_lst+0x88>
    1376:	fc843783          	ld	a5,-56(s0)
    137a:	5fdc                	lw	a5,60(a5)
    137c:	a029                	j	1386 <schedule_lst+0x90>
    137e:	800007b7          	lui	a5,0x80000
    1382:	fff7c793          	not	a5,a5
    1386:	873e                	mv	a4,a5
    1388:	87b6                	mv	a5,a3
    138a:	00e7da63          	bge	a5,a4,139e <schedule_lst+0xa8>
            min_slack_thread = t;
    138e:	fb843783          	ld	a5,-72(s0)
    1392:	fcf43423          	sd	a5,-56(s0)
            min_slack_time = slack_time;
    1396:	f7442783          	lw	a5,-140(s0)
    139a:	fcf42223          	sw	a5,-60(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    139e:	fb843783          	ld	a5,-72(s0)
    13a2:	779c                	ld	a5,40(a5)
    13a4:	f6f43423          	sd	a5,-152(s0)
    13a8:	f6843783          	ld	a5,-152(s0)
    13ac:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffdfb8>
    13b0:	faf43c23          	sd	a5,-72(s0)
    13b4:	fb843783          	ld	a5,-72(s0)
    13b8:	02878713          	addi	a4,a5,40
    13bc:	649c                	ld	a5,8(s1)
    13be:	f6f717e3          	bne	a4,a5,132c <schedule_lst+0x36>
            // ddl = t->current_deadline;
        }
    }

    // Calculate the next event time, initially very large
    int next_significant_event_time = INT_MAX;
    13c2:	800007b7          	lui	a5,0x80000
    13c6:	fff7c793          	not	a5,a5
    13ca:	faf42a23          	sw	a5,-76(s0)

    // Analyze each upcoming release to determine if and when they should preempt the current thread
    struct release_queue_entry *entry;
    list_for_each_entry(entry, args.release_queue, thread_list) {
    13ce:	689c                	ld	a5,16(s1)
    13d0:	639c                	ld	a5,0(a5)
    13d2:	f8f43c23          	sd	a5,-104(s0)
    13d6:	f9843783          	ld	a5,-104(s0)
    13da:	17e1                	addi	a5,a5,-8
    13dc:	faf43423          	sd	a5,-88(s0)
    13e0:	a0f1                	j	14ac <schedule_lst+0x1b6>
        if (entry->release_time > args.current_time) {
    13e2:	fa843783          	ld	a5,-88(s0)
    13e6:	4f98                	lw	a4,24(a5)
    13e8:	409c                	lw	a5,0(s1)
    13ea:	0ae7d763          	bge	a5,a4,1498 <schedule_lst+0x1a2>
            struct thread *upcoming_thread = entry->thrd;
    13ee:	fa843783          	ld	a5,-88(s0)
    13f2:	639c                	ld	a5,0(a5)
    13f4:	f8f43423          	sd	a5,-120(s0)
            int upcoming_slack_time = upcoming_thread->current_deadline - entry->release_time - upcoming_thread->remaining_time;
    13f8:	f8843783          	ld	a5,-120(s0)
    13fc:	4ff8                	lw	a4,92(a5)
    13fe:	fa843783          	ld	a5,-88(s0)
    1402:	4f9c                	lw	a5,24(a5)
    1404:	40f707bb          	subw	a5,a4,a5
    1408:	0007871b          	sext.w	a4,a5
    140c:	f8843783          	ld	a5,-120(s0)
    1410:	4fbc                	lw	a5,88(a5)
    1412:	40f707bb          	subw	a5,a4,a5
    1416:	f8f42223          	sw	a5,-124(s0)
            /* printf("current ddl: %d\n", ddl);
            printf("upcoming slack time: %d\n", upcoming_slack_time);
            printf("%d %d %d\n", upcoming_thread->current_deadline, args.current_time, upcoming_thread->remaining_time);
             */
            // Check if this upcoming thread will impose an earlier preemption due to tighter slack time
            if (upcoming_slack_time < min_slack_time) {
    141a:	f8442703          	lw	a4,-124(s0)
    141e:	fc442783          	lw	a5,-60(s0)
    1422:	2701                	sext.w	a4,a4
    1424:	2781                	sext.w	a5,a5
    1426:	02f75163          	bge	a4,a5,1448 <schedule_lst+0x152>
                next_significant_event_time = min(next_significant_event_time, entry->release_time);
    142a:	fa843783          	ld	a5,-88(s0)
    142e:	4f98                	lw	a4,24(a5)
    1430:	fb442783          	lw	a5,-76(s0)
    1434:	85ba                	mv	a1,a4
    1436:	853e                	mv	a0,a5
    1438:	00000097          	auipc	ra,0x0
    143c:	e8a080e7          	jalr	-374(ra) # 12c2 <min>
    1440:	87aa                	mv	a5,a0
    1442:	faf42a23          	sw	a5,-76(s0)
    1446:	a889                	j	1498 <schedule_lst+0x1a2>
            } else if (upcoming_slack_time == min_slack_time && upcoming_thread->ID < (min_slack_thread ? min_slack_thread->ID : INT_MAX))
    1448:	f8442703          	lw	a4,-124(s0)
    144c:	fc442783          	lw	a5,-60(s0)
    1450:	2701                	sext.w	a4,a4
    1452:	2781                	sext.w	a5,a5
    1454:	04f71263          	bne	a4,a5,1498 <schedule_lst+0x1a2>
    1458:	f8843783          	ld	a5,-120(s0)
    145c:	5fd4                	lw	a3,60(a5)
    145e:	fc843783          	ld	a5,-56(s0)
    1462:	c789                	beqz	a5,146c <schedule_lst+0x176>
    1464:	fc843783          	ld	a5,-56(s0)
    1468:	5fdc                	lw	a5,60(a5)
    146a:	a029                	j	1474 <schedule_lst+0x17e>
    146c:	800007b7          	lui	a5,0x80000
    1470:	fff7c793          	not	a5,a5
    1474:	873e                	mv	a4,a5
    1476:	87b6                	mv	a5,a3
    1478:	02e7d063          	bge	a5,a4,1498 <schedule_lst+0x1a2>
                next_significant_event_time = min(next_significant_event_time, entry->release_time);
    147c:	fa843783          	ld	a5,-88(s0)
    1480:	4f98                	lw	a4,24(a5)
    1482:	fb442783          	lw	a5,-76(s0)
    1486:	85ba                	mv	a1,a4
    1488:	853e                	mv	a0,a5
    148a:	00000097          	auipc	ra,0x0
    148e:	e38080e7          	jalr	-456(ra) # 12c2 <min>
    1492:	87aa                	mv	a5,a0
    1494:	faf42a23          	sw	a5,-76(s0)
    list_for_each_entry(entry, args.release_queue, thread_list) {
    1498:	fa843783          	ld	a5,-88(s0)
    149c:	679c                	ld	a5,8(a5)
    149e:	f6f43c23          	sd	a5,-136(s0)
    14a2:	f7843783          	ld	a5,-136(s0)
    14a6:	17e1                	addi	a5,a5,-8
    14a8:	faf43423          	sd	a5,-88(s0)
    14ac:	fa843783          	ld	a5,-88(s0)
    14b0:	00878713          	addi	a4,a5,8 # ffffffff80000008 <__global_pointer$+0xffffffff7fffdfe8>
    14b4:	689c                	ld	a5,16(s1)
    14b6:	f2f716e3          	bne	a4,a5,13e2 <schedule_lst+0xec>
        }
    }

    // Decide the allocated time based on current minimum slack or upcoming preemption needs
    if (min_slack_thread) {
    14ba:	fc843783          	ld	a5,-56(s0)
    14be:	c3b1                	beqz	a5,1502 <schedule_lst+0x20c>
        int allocated_time = (next_significant_event_time == INT_MAX) ? min_slack_thread->remaining_time : next_significant_event_time - args.current_time;
    14c0:	fb442783          	lw	a5,-76(s0)
    14c4:	0007871b          	sext.w	a4,a5
    14c8:	800007b7          	lui	a5,0x80000
    14cc:	fff7c793          	not	a5,a5
    14d0:	00f71663          	bne	a4,a5,14dc <schedule_lst+0x1e6>
    14d4:	fc843783          	ld	a5,-56(s0)
    14d8:	4fbc                	lw	a5,88(a5)
    14da:	a039                	j	14e8 <schedule_lst+0x1f2>
    14dc:	409c                	lw	a5,0(s1)
    14de:	fb442703          	lw	a4,-76(s0)
    14e2:	40f707bb          	subw	a5,a4,a5
    14e6:	2781                	sext.w	a5,a5
    14e8:	f8f42a23          	sw	a5,-108(s0)
        r.scheduled_thread_list_member = &min_slack_thread->thread_list;
    14ec:	fc843783          	ld	a5,-56(s0)
    14f0:	02878793          	addi	a5,a5,40 # ffffffff80000028 <__global_pointer$+0xffffffff7fffe008>
    14f4:	f4f43423          	sd	a5,-184(s0)
        r.allocated_time = allocated_time;
    14f8:	f9442783          	lw	a5,-108(s0)
    14fc:	f4f42823          	sw	a5,-176(s0)
    1500:	a081                	j	1540 <schedule_lst+0x24a>
    } else {
        // No runnable threads, prepare to sleep or wait based on next known event
        r.scheduled_thread_list_member = args.run_queue;
    1502:	649c                	ld	a5,8(s1)
    1504:	f4f43423          	sd	a5,-184(s0)
        r.allocated_time = next_significant_event_time != INT_MAX ? next_significant_event_time - args.current_time : find_next_release_time(args.release_queue, args.current_time);
    1508:	fb442783          	lw	a5,-76(s0)
    150c:	0007871b          	sext.w	a4,a5
    1510:	800007b7          	lui	a5,0x80000
    1514:	fff7c793          	not	a5,a5
    1518:	00f70963          	beq	a4,a5,152a <schedule_lst+0x234>
    151c:	409c                	lw	a5,0(s1)
    151e:	fb442703          	lw	a4,-76(s0)
    1522:	40f707bb          	subw	a5,a4,a5
    1526:	2781                	sext.w	a5,a5
    1528:	a811                	j	153c <schedule_lst+0x246>
    152a:	689c                	ld	a5,16(s1)
    152c:	4098                	lw	a4,0(s1)
    152e:	85ba                	mv	a1,a4
    1530:	853e                	mv	a0,a5
    1532:	00000097          	auipc	ra,0x0
    1536:	a72080e7          	jalr	-1422(ra) # fa4 <find_next_release_time>
    153a:	87aa                	mv	a5,a0
    153c:	f4f42823          	sw	a5,-176(s0)
    }

    return r;
    1540:	f4843783          	ld	a5,-184(s0)
    1544:	f4f43c23          	sd	a5,-168(s0)
    1548:	f5043783          	ld	a5,-176(s0)
    154c:	f6f43023          	sd	a5,-160(s0)
    1550:	4701                	li	a4,0
    1552:	f5843703          	ld	a4,-168(s0)
    1556:	4781                	li	a5,0
    1558:	f6043783          	ld	a5,-160(s0)
    155c:	893a                	mv	s2,a4
    155e:	89be                	mv	s3,a5
    1560:	874a                	mv	a4,s2
    1562:	87ce                	mv	a5,s3
}
    1564:	853a                	mv	a0,a4
    1566:	85be                	mv	a1,a5
    1568:	70ea                	ld	ra,184(sp)
    156a:	744a                	ld	s0,176(sp)
    156c:	74aa                	ld	s1,168(sp)
    156e:	790a                	ld	s2,160(sp)
    1570:	69ea                	ld	s3,152(sp)
    1572:	6129                	addi	sp,sp,192
    1574:	8082                	ret

0000000000001576 <find_earliest_impactful_release_time_dm>:

int find_earliest_impactful_release_time_dm(struct list_head *release_queue, int current_time, int current_deadline) {
    1576:	715d                	addi	sp,sp,-80
    1578:	e4a2                	sd	s0,72(sp)
    157a:	0880                	addi	s0,sp,80
    157c:	faa43c23          	sd	a0,-72(s0)
    1580:	87ae                	mv	a5,a1
    1582:	8732                	mv	a4,a2
    1584:	faf42a23          	sw	a5,-76(s0)
    1588:	87ba                	mv	a5,a4
    158a:	faf42823          	sw	a5,-80(s0)
    struct release_queue_entry *entry;
    int earliest_impactful_event = INT_MAX;
    158e:	800007b7          	lui	a5,0x80000
    1592:	fff7c793          	not	a5,a5
    1596:	fef42223          	sw	a5,-28(s0)
    struct thread *earliest_deadline_thread = NULL;
    159a:	fc043c23          	sd	zero,-40(s0)
    earliest_deadline_thread->ID = INT_MAX;
    159e:	fd843783          	ld	a5,-40(s0)
    15a2:	80000737          	lui	a4,0x80000
    15a6:	fff74713          	not	a4,a4
    15aa:	dfd8                	sw	a4,60(a5)

    // Look for the smallest deadline that is less than the current task's deadline
    list_for_each_entry(entry, release_queue, thread_list) {
    15ac:	fb843783          	ld	a5,-72(s0)
    15b0:	639c                	ld	a5,0(a5)
    15b2:	fcf43823          	sd	a5,-48(s0)
    15b6:	fd043783          	ld	a5,-48(s0)
    15ba:	17e1                	addi	a5,a5,-8
    15bc:	fef43423          	sd	a5,-24(s0)
    15c0:	a075                	j	166c <find_earliest_impactful_release_time_dm+0xf6>
        if (entry->release_time > current_time && entry->thrd->period < current_deadline) {
    15c2:	fe843783          	ld	a5,-24(s0)
    15c6:	4f98                	lw	a4,24(a5)
    15c8:	fb442783          	lw	a5,-76(s0)
    15cc:	2781                	sext.w	a5,a5
    15ce:	02e7d963          	bge	a5,a4,1600 <find_earliest_impactful_release_time_dm+0x8a>
    15d2:	fe843783          	ld	a5,-24(s0)
    15d6:	639c                	ld	a5,0(a5)
    15d8:	4bb8                	lw	a4,80(a5)
    15da:	fb042783          	lw	a5,-80(s0)
    15de:	2781                	sext.w	a5,a5
    15e0:	02f75063          	bge	a4,a5,1600 <find_earliest_impactful_release_time_dm+0x8a>
            if (entry->release_time < earliest_impactful_event) {
    15e4:	fe843783          	ld	a5,-24(s0)
    15e8:	4f98                	lw	a4,24(a5)
    15ea:	fe442783          	lw	a5,-28(s0)
    15ee:	2781                	sext.w	a5,a5
    15f0:	06f75463          	bge	a4,a5,1658 <find_earliest_impactful_release_time_dm+0xe2>
                earliest_impactful_event = entry->release_time;
    15f4:	fe843783          	ld	a5,-24(s0)
    15f8:	4f9c                	lw	a5,24(a5)
    15fa:	fef42223          	sw	a5,-28(s0)
            if (entry->release_time < earliest_impactful_event) {
    15fe:	a8a9                	j	1658 <find_earliest_impactful_release_time_dm+0xe2>
            }
        } 
        // or the smallest deadline that is equal to the current task's deadline but has a smaller ID
        else if (entry->release_time > current_time && entry->thrd->period == current_deadline) {
    1600:	fe843783          	ld	a5,-24(s0)
    1604:	4f98                	lw	a4,24(a5)
    1606:	fb442783          	lw	a5,-76(s0)
    160a:	2781                	sext.w	a5,a5
    160c:	04e7d663          	bge	a5,a4,1658 <find_earliest_impactful_release_time_dm+0xe2>
    1610:	fe843783          	ld	a5,-24(s0)
    1614:	639c                	ld	a5,0(a5)
    1616:	4bb8                	lw	a4,80(a5)
    1618:	fb042783          	lw	a5,-80(s0)
    161c:	2781                	sext.w	a5,a5
    161e:	02e79d63          	bne	a5,a4,1658 <find_earliest_impactful_release_time_dm+0xe2>
            if (entry->release_time < earliest_impactful_event && entry->thrd->ID < earliest_deadline_thread->ID) {
    1622:	fe843783          	ld	a5,-24(s0)
    1626:	4f98                	lw	a4,24(a5)
    1628:	fe442783          	lw	a5,-28(s0)
    162c:	2781                	sext.w	a5,a5
    162e:	02f75563          	bge	a4,a5,1658 <find_earliest_impactful_release_time_dm+0xe2>
    1632:	fe843783          	ld	a5,-24(s0)
    1636:	639c                	ld	a5,0(a5)
    1638:	5fd8                	lw	a4,60(a5)
    163a:	fd843783          	ld	a5,-40(s0)
    163e:	5fdc                	lw	a5,60(a5)
    1640:	00f75c63          	bge	a4,a5,1658 <find_earliest_impactful_release_time_dm+0xe2>
                earliest_impactful_event = entry->release_time;
    1644:	fe843783          	ld	a5,-24(s0)
    1648:	4f9c                	lw	a5,24(a5)
    164a:	fef42223          	sw	a5,-28(s0)
                earliest_deadline_thread = entry->thrd;
    164e:	fe843783          	ld	a5,-24(s0)
    1652:	639c                	ld	a5,0(a5)
    1654:	fcf43c23          	sd	a5,-40(s0)
    list_for_each_entry(entry, release_queue, thread_list) {
    1658:	fe843783          	ld	a5,-24(s0)
    165c:	679c                	ld	a5,8(a5)
    165e:	fcf43423          	sd	a5,-56(s0)
    1662:	fc843783          	ld	a5,-56(s0)
    1666:	17e1                	addi	a5,a5,-8
    1668:	fef43423          	sd	a5,-24(s0)
    166c:	fe843783          	ld	a5,-24(s0)
    1670:	07a1                	addi	a5,a5,8
    1672:	fb843703          	ld	a4,-72(s0)
    1676:	f4f716e3          	bne	a4,a5,15c2 <find_earliest_impactful_release_time_dm+0x4c>
            }
        }
    }

    // If a task is found that might preempt the current task, determine when it will happen
    return earliest_impactful_event == INT_MAX ? -1 : earliest_impactful_event;
    167a:	fe442783          	lw	a5,-28(s0)
    167e:	0007871b          	sext.w	a4,a5
    1682:	800007b7          	lui	a5,0x80000
    1686:	fff7c793          	not	a5,a5
    168a:	00f70563          	beq	a4,a5,1694 <find_earliest_impactful_release_time_dm+0x11e>
    168e:	fe442783          	lw	a5,-28(s0)
    1692:	a011                	j	1696 <find_earliest_impactful_release_time_dm+0x120>
    1694:	57fd                	li	a5,-1
}
    1696:	853e                	mv	a0,a5
    1698:	6426                	ld	s0,72(sp)
    169a:	6161                	addi	sp,sp,80
    169c:	8082                	ret

000000000000169e <schedule_dm>:


struct threads_sched_result schedule_dm(struct threads_sched_args args) {
    169e:	7175                	addi	sp,sp,-144
    16a0:	e506                	sd	ra,136(sp)
    16a2:	e122                	sd	s0,128(sp)
    16a4:	fca6                	sd	s1,120(sp)
    16a6:	f8ca                	sd	s2,112(sp)
    16a8:	f4ce                	sd	s3,104(sp)
    16aa:	0900                	addi	s0,sp,144
    16ac:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    struct thread *earliest_deadline_thread = NULL;
    16ae:	fc043423          	sd	zero,-56(s0)
    struct thread *t;
    int earliest_deadline = INT_MAX;
    16b2:	800007b7          	lui	a5,0x80000
    16b6:	fff7c793          	not	a5,a5
    16ba:	faf42e23          	sw	a5,-68(s0)

    // Determine the earliest deadline among current tasks
    list_for_each_entry(t, args.run_queue, thread_list) {
    16be:	649c                	ld	a5,8(s1)
    16c0:	639c                	ld	a5,0(a5)
    16c2:	faf43823          	sd	a5,-80(s0)
    16c6:	fb043783          	ld	a5,-80(s0)
    16ca:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffdfb8>
    16ce:	fcf43023          	sd	a5,-64(s0)
    16d2:	a089                	j	1714 <schedule_dm+0x76>
        if (t->is_real_time && t->period < earliest_deadline) {
    16d4:	fc043783          	ld	a5,-64(s0)
    16d8:	43bc                	lw	a5,64(a5)
    16da:	c395                	beqz	a5,16fe <schedule_dm+0x60>
    16dc:	fc043783          	ld	a5,-64(s0)
    16e0:	4bb8                	lw	a4,80(a5)
    16e2:	fbc42783          	lw	a5,-68(s0)
    16e6:	2781                	sext.w	a5,a5
    16e8:	00f75b63          	bge	a4,a5,16fe <schedule_dm+0x60>
            earliest_deadline_thread = t;
    16ec:	fc043783          	ld	a5,-64(s0)
    16f0:	fcf43423          	sd	a5,-56(s0)
            earliest_deadline = t->period;
    16f4:	fc043783          	ld	a5,-64(s0)
    16f8:	4bbc                	lw	a5,80(a5)
    16fa:	faf42e23          	sw	a5,-68(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    16fe:	fc043783          	ld	a5,-64(s0)
    1702:	779c                	ld	a5,40(a5)
    1704:	f8f43c23          	sd	a5,-104(s0)
    1708:	f9843783          	ld	a5,-104(s0)
    170c:	fd878793          	addi	a5,a5,-40
    1710:	fcf43023          	sd	a5,-64(s0)
    1714:	fc043783          	ld	a5,-64(s0)
    1718:	02878713          	addi	a4,a5,40
    171c:	649c                	ld	a5,8(s1)
    171e:	faf71be3          	bne	a4,a5,16d4 <schedule_dm+0x36>
        }
    }

    // Find the earliest impactful deadline from other tasks
    int earliest_impactful_deadline = find_earliest_impactful_release_time_dm(args.release_queue, args.current_time, earliest_deadline);
    1722:	689c                	ld	a5,16(s1)
    1724:	4098                	lw	a4,0(s1)
    1726:	fbc42683          	lw	a3,-68(s0)
    172a:	8636                	mv	a2,a3
    172c:	85ba                	mv	a1,a4
    172e:	853e                	mv	a0,a5
    1730:	00000097          	auipc	ra,0x0
    1734:	e46080e7          	jalr	-442(ra) # 1576 <find_earliest_impactful_release_time_dm>
    1738:	87aa                	mv	a5,a0
    173a:	faf42623          	sw	a5,-84(s0)

    if (earliest_deadline_thread) {
    173e:	fc843783          	ld	a5,-56(s0)
    1742:	c3c9                	beqz	a5,17c4 <schedule_dm+0x126>
        int time_to_deadline = earliest_deadline_thread->current_deadline - args.current_time;
    1744:	fc843783          	ld	a5,-56(s0)
    1748:	4ff8                	lw	a4,92(a5)
    174a:	409c                	lw	a5,0(s1)
    174c:	40f707bb          	subw	a5,a4,a5
    1750:	faf42423          	sw	a5,-88(s0)
        
        // If the thread is already past its deadline, allocate no time (handle deadline miss)
        if (time_to_deadline < 0) {
    1754:	fa842783          	lw	a5,-88(s0)
    1758:	2781                	sext.w	a5,a5
    175a:	0007db63          	bgez	a5,1770 <schedule_dm+0xd2>
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    175e:	fc843783          	ld	a5,-56(s0)
    1762:	02878793          	addi	a5,a5,40
    1766:	f6f43c23          	sd	a5,-136(s0)
            r.allocated_time = 0;
    176a:	f8042023          	sw	zero,-128(s0)
    176e:	a88d                	j	17e0 <schedule_dm+0x142>
        } else {
            // Allocate time based on the smallest of the task's remaining time or the next impactful deadline
            int allocated_time = (earliest_impactful_deadline != -1 && (earliest_impactful_deadline - args.current_time) < earliest_deadline_thread->remaining_time) ? earliest_impactful_deadline - args.current_time : earliest_deadline_thread->remaining_time;
    1770:	fac42783          	lw	a5,-84(s0)
    1774:	0007871b          	sext.w	a4,a5
    1778:	57fd                	li	a5,-1
    177a:	02f70563          	beq	a4,a5,17a4 <schedule_dm+0x106>
    177e:	409c                	lw	a5,0(s1)
    1780:	fac42703          	lw	a4,-84(s0)
    1784:	40f707bb          	subw	a5,a4,a5
    1788:	0007871b          	sext.w	a4,a5
    178c:	fc843783          	ld	a5,-56(s0)
    1790:	4fbc                	lw	a5,88(a5)
    1792:	00f75963          	bge	a4,a5,17a4 <schedule_dm+0x106>
    1796:	409c                	lw	a5,0(s1)
    1798:	fac42703          	lw	a4,-84(s0)
    179c:	40f707bb          	subw	a5,a4,a5
    17a0:	2781                	sext.w	a5,a5
    17a2:	a021                	j	17aa <schedule_dm+0x10c>
    17a4:	fc843783          	ld	a5,-56(s0)
    17a8:	4fbc                	lw	a5,88(a5)
    17aa:	faf42223          	sw	a5,-92(s0)
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    17ae:	fc843783          	ld	a5,-56(s0)
    17b2:	02878793          	addi	a5,a5,40
    17b6:	f6f43c23          	sd	a5,-136(s0)
            r.allocated_time = allocated_time;
    17ba:	fa442783          	lw	a5,-92(s0)
    17be:	f8f42023          	sw	a5,-128(s0)
    17c2:	a839                	j	17e0 <schedule_dm+0x142>
        }
    } else {
        // If no immediate tasks, schedule the next possible task
        r.scheduled_thread_list_member = args.run_queue;
    17c4:	649c                	ld	a5,8(s1)
    17c6:	f6f43c23          	sd	a5,-136(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    17ca:	689c                	ld	a5,16(s1)
    17cc:	4098                	lw	a4,0(s1)
    17ce:	85ba                	mv	a1,a4
    17d0:	853e                	mv	a0,a5
    17d2:	fffff097          	auipc	ra,0xfffff
    17d6:	7d2080e7          	jalr	2002(ra) # fa4 <find_next_release_time>
    17da:	87aa                	mv	a5,a0
    17dc:	f8f42023          	sw	a5,-128(s0)
    }

    return r;
    17e0:	f7843783          	ld	a5,-136(s0)
    17e4:	f8f43423          	sd	a5,-120(s0)
    17e8:	f8043783          	ld	a5,-128(s0)
    17ec:	f8f43823          	sd	a5,-112(s0)
    17f0:	4701                	li	a4,0
    17f2:	f8843703          	ld	a4,-120(s0)
    17f6:	4781                	li	a5,0
    17f8:	f9043783          	ld	a5,-112(s0)
    17fc:	893a                	mv	s2,a4
    17fe:	89be                	mv	s3,a5
    1800:	874a                	mv	a4,s2
    1802:	87ce                	mv	a5,s3
}
    1804:	853a                	mv	a0,a4
    1806:	85be                	mv	a1,a5
    1808:	60aa                	ld	ra,136(sp)
    180a:	640a                	ld	s0,128(sp)
    180c:	74e6                	ld	s1,120(sp)
    180e:	7946                	ld	s2,112(sp)
    1810:	79a6                	ld	s3,104(sp)
    1812:	6149                	addi	sp,sp,144
    1814:	8082                	ret
