
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	7139                	addi	sp,sp,-64
       2:	fc22                	sd	s0,56(sp)
       4:	0080                	addi	s0,sp,64
       6:	fca43423          	sd	a0,-56(s0)
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       a:	fc843783          	ld	a5,-56(s0)
       e:	6398                	ld	a4,0(a5)
      10:	800007b7          	lui	a5,0x80000
      14:	ffe7c793          	xori	a5,a5,-2
      18:	02f777b3          	remu	a5,a4,a5
      1c:	0785                	addi	a5,a5,1
      1e:	fef43423          	sd	a5,-24(s0)
    hi = x / 127773;
      22:	fe843703          	ld	a4,-24(s0)
      26:	67fd                	lui	a5,0x1f
      28:	31d78793          	addi	a5,a5,797 # 1f31d <__global_pointer$+0x1c4ad>
      2c:	02f747b3          	div	a5,a4,a5
      30:	fef43023          	sd	a5,-32(s0)
    lo = x % 127773;
      34:	fe843703          	ld	a4,-24(s0)
      38:	67fd                	lui	a5,0x1f
      3a:	31d78793          	addi	a5,a5,797 # 1f31d <__global_pointer$+0x1c4ad>
      3e:	02f767b3          	rem	a5,a4,a5
      42:	fcf43c23          	sd	a5,-40(s0)
    x = 16807 * lo - 2836 * hi;
      46:	fd843703          	ld	a4,-40(s0)
      4a:	6791                	lui	a5,0x4
      4c:	1a778793          	addi	a5,a5,423 # 41a7 <__global_pointer$+0x1337>
      50:	02f70733          	mul	a4,a4,a5
      54:	fe043683          	ld	a3,-32(s0)
      58:	77fd                	lui	a5,0xfffff
      5a:	4ec78793          	addi	a5,a5,1260 # fffffffffffff4ec <__global_pointer$+0xffffffffffffc67c>
      5e:	02f687b3          	mul	a5,a3,a5
      62:	97ba                	add	a5,a5,a4
      64:	fef43423          	sd	a5,-24(s0)
    if (x < 0)
      68:	fe843783          	ld	a5,-24(s0)
      6c:	0007db63          	bgez	a5,82 <do_rand+0x82>
        x += 0x7fffffff;
      70:	fe843703          	ld	a4,-24(s0)
      74:	800007b7          	lui	a5,0x80000
      78:	fff7c793          	not	a5,a5
      7c:	97ba                	add	a5,a5,a4
      7e:	fef43423          	sd	a5,-24(s0)
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
      82:	fe843783          	ld	a5,-24(s0)
      86:	17fd                	addi	a5,a5,-1
      88:	fef43423          	sd	a5,-24(s0)
    *ctx = x;
      8c:	fe843703          	ld	a4,-24(s0)
      90:	fc843783          	ld	a5,-56(s0)
      94:	e398                	sd	a4,0(a5)
    return (x);
      96:	fe843783          	ld	a5,-24(s0)
      9a:	2781                	sext.w	a5,a5
}
      9c:	853e                	mv	a0,a5
      9e:	7462                	ld	s0,56(sp)
      a0:	6121                	addi	sp,sp,64
      a2:	8082                	ret

00000000000000a4 <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
      a4:	1141                	addi	sp,sp,-16
      a6:	e406                	sd	ra,8(sp)
      a8:	e022                	sd	s0,0(sp)
      aa:	0800                	addi	s0,sp,16
    return (do_rand(&rand_next));
      ac:	00002517          	auipc	a0,0x2
      b0:	5dc50513          	addi	a0,a0,1500 # 2688 <rand_next>
      b4:	00000097          	auipc	ra,0x0
      b8:	f4c080e7          	jalr	-180(ra) # 0 <do_rand>
      bc:	87aa                	mv	a5,a0
}
      be:	853e                	mv	a0,a5
      c0:	60a2                	ld	ra,8(sp)
      c2:	6402                	ld	s0,0(sp)
      c4:	0141                	addi	sp,sp,16
      c6:	8082                	ret

00000000000000c8 <go>:

void
go(int which_child)
{
      c8:	7155                	addi	sp,sp,-208
      ca:	e586                	sd	ra,200(sp)
      cc:	e1a2                	sd	s0,192(sp)
      ce:	0980                	addi	s0,sp,208
      d0:	87aa                	mv	a5,a0
      d2:	f2f42e23          	sw	a5,-196(s0)
  int fd = -1;
      d6:	57fd                	li	a5,-1
      d8:	fef42623          	sw	a5,-20(s0)
  static char buf[999];
  char *break0 = sbrk(0);
      dc:	4501                	li	a0,0
      de:	00001097          	auipc	ra,0x1
      e2:	2f8080e7          	jalr	760(ra) # 13d6 <sbrk>
      e6:	fca43c23          	sd	a0,-40(s0)
  uint64 iters = 0;
      ea:	fe043023          	sd	zero,-32(s0)

  mkdir("grindir");
      ee:	00002517          	auipc	a0,0x2
      f2:	25a50513          	addi	a0,a0,602 # 2348 <schedule_dm+0x20c>
      f6:	00001097          	auipc	ra,0x1
      fa:	2c0080e7          	jalr	704(ra) # 13b6 <mkdir>
  if(chdir("grindir") != 0){
      fe:	00002517          	auipc	a0,0x2
     102:	24a50513          	addi	a0,a0,586 # 2348 <schedule_dm+0x20c>
     106:	00001097          	auipc	ra,0x1
     10a:	2b8080e7          	jalr	696(ra) # 13be <chdir>
     10e:	87aa                	mv	a5,a0
     110:	cf91                	beqz	a5,12c <go+0x64>
    printf("grind: chdir grindir failed\n");
     112:	00002517          	auipc	a0,0x2
     116:	23e50513          	addi	a0,a0,574 # 2350 <schedule_dm+0x214>
     11a:	00001097          	auipc	ra,0x1
     11e:	77a080e7          	jalr	1914(ra) # 1894 <printf>
    exit(1);
     122:	4505                	li	a0,1
     124:	00001097          	auipc	ra,0x1
     128:	22a080e7          	jalr	554(ra) # 134e <exit>
  }
  chdir("/");
     12c:	00002517          	auipc	a0,0x2
     130:	24450513          	addi	a0,a0,580 # 2370 <schedule_dm+0x234>
     134:	00001097          	auipc	ra,0x1
     138:	28a080e7          	jalr	650(ra) # 13be <chdir>
  
  while(1){
    iters++;
     13c:	fe043783          	ld	a5,-32(s0)
     140:	0785                	addi	a5,a5,1
     142:	fef43023          	sd	a5,-32(s0)
    if((iters % 500) == 0)
     146:	fe043703          	ld	a4,-32(s0)
     14a:	1f400793          	li	a5,500
     14e:	02f777b3          	remu	a5,a4,a5
     152:	e78d                	bnez	a5,17c <go+0xb4>
      write(1, which_child?"B":"A", 1);
     154:	f3c42783          	lw	a5,-196(s0)
     158:	2781                	sext.w	a5,a5
     15a:	c791                	beqz	a5,166 <go+0x9e>
     15c:	00002797          	auipc	a5,0x2
     160:	21c78793          	addi	a5,a5,540 # 2378 <schedule_dm+0x23c>
     164:	a029                	j	16e <go+0xa6>
     166:	00002797          	auipc	a5,0x2
     16a:	21a78793          	addi	a5,a5,538 # 2380 <schedule_dm+0x244>
     16e:	4605                	li	a2,1
     170:	85be                	mv	a1,a5
     172:	4505                	li	a0,1
     174:	00001097          	auipc	ra,0x1
     178:	1fa080e7          	jalr	506(ra) # 136e <write>
    int what = rand() % 23;
     17c:	00000097          	auipc	ra,0x0
     180:	f28080e7          	jalr	-216(ra) # a4 <rand>
     184:	87aa                	mv	a5,a0
     186:	873e                	mv	a4,a5
     188:	47dd                	li	a5,23
     18a:	02f767bb          	remw	a5,a4,a5
     18e:	fcf42a23          	sw	a5,-44(s0)
    if(what == 1){
     192:	fd442783          	lw	a5,-44(s0)
     196:	0007871b          	sext.w	a4,a5
     19a:	4785                	li	a5,1
     19c:	02f71363          	bne	a4,a5,1c2 <go+0xfa>
      close(open("grindir/../a", O_CREATE|O_RDWR));
     1a0:	20200593          	li	a1,514
     1a4:	00002517          	auipc	a0,0x2
     1a8:	1e450513          	addi	a0,a0,484 # 2388 <schedule_dm+0x24c>
     1ac:	00001097          	auipc	ra,0x1
     1b0:	1e2080e7          	jalr	482(ra) # 138e <open>
     1b4:	87aa                	mv	a5,a0
     1b6:	853e                	mv	a0,a5
     1b8:	00001097          	auipc	ra,0x1
     1bc:	1be080e7          	jalr	446(ra) # 1376 <close>
     1c0:	bfb5                	j	13c <go+0x74>
    } else if(what == 2){
     1c2:	fd442783          	lw	a5,-44(s0)
     1c6:	0007871b          	sext.w	a4,a5
     1ca:	4789                	li	a5,2
     1cc:	02f71363          	bne	a4,a5,1f2 <go+0x12a>
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     1d0:	20200593          	li	a1,514
     1d4:	00002517          	auipc	a0,0x2
     1d8:	1c450513          	addi	a0,a0,452 # 2398 <schedule_dm+0x25c>
     1dc:	00001097          	auipc	ra,0x1
     1e0:	1b2080e7          	jalr	434(ra) # 138e <open>
     1e4:	87aa                	mv	a5,a0
     1e6:	853e                	mv	a0,a5
     1e8:	00001097          	auipc	ra,0x1
     1ec:	18e080e7          	jalr	398(ra) # 1376 <close>
     1f0:	b7b1                	j	13c <go+0x74>
    } else if(what == 3){
     1f2:	fd442783          	lw	a5,-44(s0)
     1f6:	0007871b          	sext.w	a4,a5
     1fa:	478d                	li	a5,3
     1fc:	00f71b63          	bne	a4,a5,212 <go+0x14a>
      unlink("grindir/../a");
     200:	00002517          	auipc	a0,0x2
     204:	18850513          	addi	a0,a0,392 # 2388 <schedule_dm+0x24c>
     208:	00001097          	auipc	ra,0x1
     20c:	196080e7          	jalr	406(ra) # 139e <unlink>
     210:	b735                	j	13c <go+0x74>
    } else if(what == 4){
     212:	fd442783          	lw	a5,-44(s0)
     216:	0007871b          	sext.w	a4,a5
     21a:	4791                	li	a5,4
     21c:	04f71a63          	bne	a4,a5,270 <go+0x1a8>
      if(chdir("grindir") != 0){
     220:	00002517          	auipc	a0,0x2
     224:	12850513          	addi	a0,a0,296 # 2348 <schedule_dm+0x20c>
     228:	00001097          	auipc	ra,0x1
     22c:	196080e7          	jalr	406(ra) # 13be <chdir>
     230:	87aa                	mv	a5,a0
     232:	cf91                	beqz	a5,24e <go+0x186>
        printf("grind: chdir grindir failed\n");
     234:	00002517          	auipc	a0,0x2
     238:	11c50513          	addi	a0,a0,284 # 2350 <schedule_dm+0x214>
     23c:	00001097          	auipc	ra,0x1
     240:	658080e7          	jalr	1624(ra) # 1894 <printf>
        exit(1);
     244:	4505                	li	a0,1
     246:	00001097          	auipc	ra,0x1
     24a:	108080e7          	jalr	264(ra) # 134e <exit>
      }
      unlink("../b");
     24e:	00002517          	auipc	a0,0x2
     252:	16250513          	addi	a0,a0,354 # 23b0 <schedule_dm+0x274>
     256:	00001097          	auipc	ra,0x1
     25a:	148080e7          	jalr	328(ra) # 139e <unlink>
      chdir("/");
     25e:	00002517          	auipc	a0,0x2
     262:	11250513          	addi	a0,a0,274 # 2370 <schedule_dm+0x234>
     266:	00001097          	auipc	ra,0x1
     26a:	158080e7          	jalr	344(ra) # 13be <chdir>
     26e:	b5f9                	j	13c <go+0x74>
    } else if(what == 5){
     270:	fd442783          	lw	a5,-44(s0)
     274:	0007871b          	sext.w	a4,a5
     278:	4795                	li	a5,5
     27a:	02f71763          	bne	a4,a5,2a8 <go+0x1e0>
      close(fd);
     27e:	fec42783          	lw	a5,-20(s0)
     282:	853e                	mv	a0,a5
     284:	00001097          	auipc	ra,0x1
     288:	0f2080e7          	jalr	242(ra) # 1376 <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     28c:	20200593          	li	a1,514
     290:	00002517          	auipc	a0,0x2
     294:	12850513          	addi	a0,a0,296 # 23b8 <schedule_dm+0x27c>
     298:	00001097          	auipc	ra,0x1
     29c:	0f6080e7          	jalr	246(ra) # 138e <open>
     2a0:	87aa                	mv	a5,a0
     2a2:	fef42623          	sw	a5,-20(s0)
     2a6:	bd59                	j	13c <go+0x74>
    } else if(what == 6){
     2a8:	fd442783          	lw	a5,-44(s0)
     2ac:	0007871b          	sext.w	a4,a5
     2b0:	4799                	li	a5,6
     2b2:	02f71763          	bne	a4,a5,2e0 <go+0x218>
      close(fd);
     2b6:	fec42783          	lw	a5,-20(s0)
     2ba:	853e                	mv	a0,a5
     2bc:	00001097          	auipc	ra,0x1
     2c0:	0ba080e7          	jalr	186(ra) # 1376 <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     2c4:	20200593          	li	a1,514
     2c8:	00002517          	auipc	a0,0x2
     2cc:	10050513          	addi	a0,a0,256 # 23c8 <schedule_dm+0x28c>
     2d0:	00001097          	auipc	ra,0x1
     2d4:	0be080e7          	jalr	190(ra) # 138e <open>
     2d8:	87aa                	mv	a5,a0
     2da:	fef42623          	sw	a5,-20(s0)
     2de:	bdb9                	j	13c <go+0x74>
    } else if(what == 7){
     2e0:	fd442783          	lw	a5,-44(s0)
     2e4:	0007871b          	sext.w	a4,a5
     2e8:	479d                	li	a5,7
     2ea:	02f71063          	bne	a4,a5,30a <go+0x242>
      write(fd, buf, sizeof(buf));
     2ee:	fec42783          	lw	a5,-20(s0)
     2f2:	3e700613          	li	a2,999
     2f6:	00002597          	auipc	a1,0x2
     2fa:	39a58593          	addi	a1,a1,922 # 2690 <buf.1242>
     2fe:	853e                	mv	a0,a5
     300:	00001097          	auipc	ra,0x1
     304:	06e080e7          	jalr	110(ra) # 136e <write>
     308:	bd15                	j	13c <go+0x74>
    } else if(what == 8){
     30a:	fd442783          	lw	a5,-44(s0)
     30e:	0007871b          	sext.w	a4,a5
     312:	47a1                	li	a5,8
     314:	02f71063          	bne	a4,a5,334 <go+0x26c>
      read(fd, buf, sizeof(buf));
     318:	fec42783          	lw	a5,-20(s0)
     31c:	3e700613          	li	a2,999
     320:	00002597          	auipc	a1,0x2
     324:	37058593          	addi	a1,a1,880 # 2690 <buf.1242>
     328:	853e                	mv	a0,a5
     32a:	00001097          	auipc	ra,0x1
     32e:	03c080e7          	jalr	60(ra) # 1366 <read>
     332:	b529                	j	13c <go+0x74>
    } else if(what == 9){
     334:	fd442783          	lw	a5,-44(s0)
     338:	0007871b          	sext.w	a4,a5
     33c:	47a5                	li	a5,9
     33e:	04f71363          	bne	a4,a5,384 <go+0x2bc>
      mkdir("grindir/../a");
     342:	00002517          	auipc	a0,0x2
     346:	04650513          	addi	a0,a0,70 # 2388 <schedule_dm+0x24c>
     34a:	00001097          	auipc	ra,0x1
     34e:	06c080e7          	jalr	108(ra) # 13b6 <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     352:	20200593          	li	a1,514
     356:	00002517          	auipc	a0,0x2
     35a:	08a50513          	addi	a0,a0,138 # 23e0 <schedule_dm+0x2a4>
     35e:	00001097          	auipc	ra,0x1
     362:	030080e7          	jalr	48(ra) # 138e <open>
     366:	87aa                	mv	a5,a0
     368:	853e                	mv	a0,a5
     36a:	00001097          	auipc	ra,0x1
     36e:	00c080e7          	jalr	12(ra) # 1376 <close>
      unlink("a/a");
     372:	00002517          	auipc	a0,0x2
     376:	07e50513          	addi	a0,a0,126 # 23f0 <schedule_dm+0x2b4>
     37a:	00001097          	auipc	ra,0x1
     37e:	024080e7          	jalr	36(ra) # 139e <unlink>
     382:	bb6d                	j	13c <go+0x74>
    } else if(what == 10){
     384:	fd442783          	lw	a5,-44(s0)
     388:	0007871b          	sext.w	a4,a5
     38c:	47a9                	li	a5,10
     38e:	04f71363          	bne	a4,a5,3d4 <go+0x30c>
      mkdir("/../b");
     392:	00002517          	auipc	a0,0x2
     396:	06650513          	addi	a0,a0,102 # 23f8 <schedule_dm+0x2bc>
     39a:	00001097          	auipc	ra,0x1
     39e:	01c080e7          	jalr	28(ra) # 13b6 <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     3a2:	20200593          	li	a1,514
     3a6:	00002517          	auipc	a0,0x2
     3aa:	05a50513          	addi	a0,a0,90 # 2400 <schedule_dm+0x2c4>
     3ae:	00001097          	auipc	ra,0x1
     3b2:	fe0080e7          	jalr	-32(ra) # 138e <open>
     3b6:	87aa                	mv	a5,a0
     3b8:	853e                	mv	a0,a5
     3ba:	00001097          	auipc	ra,0x1
     3be:	fbc080e7          	jalr	-68(ra) # 1376 <close>
      unlink("b/b");
     3c2:	00002517          	auipc	a0,0x2
     3c6:	04e50513          	addi	a0,a0,78 # 2410 <schedule_dm+0x2d4>
     3ca:	00001097          	auipc	ra,0x1
     3ce:	fd4080e7          	jalr	-44(ra) # 139e <unlink>
     3d2:	b3ad                	j	13c <go+0x74>
    } else if(what == 11){
     3d4:	fd442783          	lw	a5,-44(s0)
     3d8:	0007871b          	sext.w	a4,a5
     3dc:	47ad                	li	a5,11
     3de:	02f71763          	bne	a4,a5,40c <go+0x344>
      unlink("b");
     3e2:	00002517          	auipc	a0,0x2
     3e6:	03650513          	addi	a0,a0,54 # 2418 <schedule_dm+0x2dc>
     3ea:	00001097          	auipc	ra,0x1
     3ee:	fb4080e7          	jalr	-76(ra) # 139e <unlink>
      link("../grindir/./../a", "../b");
     3f2:	00002597          	auipc	a1,0x2
     3f6:	fbe58593          	addi	a1,a1,-66 # 23b0 <schedule_dm+0x274>
     3fa:	00002517          	auipc	a0,0x2
     3fe:	02650513          	addi	a0,a0,38 # 2420 <schedule_dm+0x2e4>
     402:	00001097          	auipc	ra,0x1
     406:	fac080e7          	jalr	-84(ra) # 13ae <link>
     40a:	bb0d                	j	13c <go+0x74>
    } else if(what == 12){
     40c:	fd442783          	lw	a5,-44(s0)
     410:	0007871b          	sext.w	a4,a5
     414:	47b1                	li	a5,12
     416:	02f71763          	bne	a4,a5,444 <go+0x37c>
      unlink("../grindir/../a");
     41a:	00002517          	auipc	a0,0x2
     41e:	01e50513          	addi	a0,a0,30 # 2438 <schedule_dm+0x2fc>
     422:	00001097          	auipc	ra,0x1
     426:	f7c080e7          	jalr	-132(ra) # 139e <unlink>
      link(".././b", "/grindir/../a");
     42a:	00002597          	auipc	a1,0x2
     42e:	f8e58593          	addi	a1,a1,-114 # 23b8 <schedule_dm+0x27c>
     432:	00002517          	auipc	a0,0x2
     436:	01650513          	addi	a0,a0,22 # 2448 <schedule_dm+0x30c>
     43a:	00001097          	auipc	ra,0x1
     43e:	f74080e7          	jalr	-140(ra) # 13ae <link>
     442:	b9ed                	j	13c <go+0x74>
    } else if(what == 13){
     444:	fd442783          	lw	a5,-44(s0)
     448:	0007871b          	sext.w	a4,a5
     44c:	47b5                	li	a5,13
     44e:	04f71a63          	bne	a4,a5,4a2 <go+0x3da>
      int pid = fork();
     452:	00001097          	auipc	ra,0x1
     456:	ef4080e7          	jalr	-268(ra) # 1346 <fork>
     45a:	87aa                	mv	a5,a0
     45c:	faf42823          	sw	a5,-80(s0)
      if(pid == 0){
     460:	fb042783          	lw	a5,-80(s0)
     464:	2781                	sext.w	a5,a5
     466:	e791                	bnez	a5,472 <go+0x3aa>
        exit(0);
     468:	4501                	li	a0,0
     46a:	00001097          	auipc	ra,0x1
     46e:	ee4080e7          	jalr	-284(ra) # 134e <exit>
      } else if(pid < 0){
     472:	fb042783          	lw	a5,-80(s0)
     476:	2781                	sext.w	a5,a5
     478:	0007df63          	bgez	a5,496 <go+0x3ce>
        printf("grind: fork failed\n");
     47c:	00002517          	auipc	a0,0x2
     480:	fd450513          	addi	a0,a0,-44 # 2450 <schedule_dm+0x314>
     484:	00001097          	auipc	ra,0x1
     488:	410080e7          	jalr	1040(ra) # 1894 <printf>
        exit(1);
     48c:	4505                	li	a0,1
     48e:	00001097          	auipc	ra,0x1
     492:	ec0080e7          	jalr	-320(ra) # 134e <exit>
      }
      wait(0);
     496:	4501                	li	a0,0
     498:	00001097          	auipc	ra,0x1
     49c:	ebe080e7          	jalr	-322(ra) # 1356 <wait>
     4a0:	b971                	j	13c <go+0x74>
    } else if(what == 14){
     4a2:	fd442783          	lw	a5,-44(s0)
     4a6:	0007871b          	sext.w	a4,a5
     4aa:	47b9                	li	a5,14
     4ac:	06f71263          	bne	a4,a5,510 <go+0x448>
      int pid = fork();
     4b0:	00001097          	auipc	ra,0x1
     4b4:	e96080e7          	jalr	-362(ra) # 1346 <fork>
     4b8:	87aa                	mv	a5,a0
     4ba:	faf42a23          	sw	a5,-76(s0)
      if(pid == 0){
     4be:	fb442783          	lw	a5,-76(s0)
     4c2:	2781                	sext.w	a5,a5
     4c4:	ef91                	bnez	a5,4e0 <go+0x418>
        fork();
     4c6:	00001097          	auipc	ra,0x1
     4ca:	e80080e7          	jalr	-384(ra) # 1346 <fork>
        fork();
     4ce:	00001097          	auipc	ra,0x1
     4d2:	e78080e7          	jalr	-392(ra) # 1346 <fork>
        exit(0);
     4d6:	4501                	li	a0,0
     4d8:	00001097          	auipc	ra,0x1
     4dc:	e76080e7          	jalr	-394(ra) # 134e <exit>
      } else if(pid < 0){
     4e0:	fb442783          	lw	a5,-76(s0)
     4e4:	2781                	sext.w	a5,a5
     4e6:	0007df63          	bgez	a5,504 <go+0x43c>
        printf("grind: fork failed\n");
     4ea:	00002517          	auipc	a0,0x2
     4ee:	f6650513          	addi	a0,a0,-154 # 2450 <schedule_dm+0x314>
     4f2:	00001097          	auipc	ra,0x1
     4f6:	3a2080e7          	jalr	930(ra) # 1894 <printf>
        exit(1);
     4fa:	4505                	li	a0,1
     4fc:	00001097          	auipc	ra,0x1
     500:	e52080e7          	jalr	-430(ra) # 134e <exit>
      }
      wait(0);
     504:	4501                	li	a0,0
     506:	00001097          	auipc	ra,0x1
     50a:	e50080e7          	jalr	-432(ra) # 1356 <wait>
     50e:	b13d                	j	13c <go+0x74>
    } else if(what == 15){
     510:	fd442783          	lw	a5,-44(s0)
     514:	0007871b          	sext.w	a4,a5
     518:	47bd                	li	a5,15
     51a:	00f71a63          	bne	a4,a5,52e <go+0x466>
      sbrk(6011);
     51e:	6785                	lui	a5,0x1
     520:	77b78513          	addi	a0,a5,1915 # 177b <vprintf+0x1a5>
     524:	00001097          	auipc	ra,0x1
     528:	eb2080e7          	jalr	-334(ra) # 13d6 <sbrk>
     52c:	b901                	j	13c <go+0x74>
    } else if(what == 16){
     52e:	fd442783          	lw	a5,-44(s0)
     532:	0007871b          	sext.w	a4,a5
     536:	47c1                	li	a5,16
     538:	02f71c63          	bne	a4,a5,570 <go+0x4a8>
      if(sbrk(0) > break0)
     53c:	4501                	li	a0,0
     53e:	00001097          	auipc	ra,0x1
     542:	e98080e7          	jalr	-360(ra) # 13d6 <sbrk>
     546:	872a                	mv	a4,a0
     548:	fd843783          	ld	a5,-40(s0)
     54c:	bee7f8e3          	bgeu	a5,a4,13c <go+0x74>
        sbrk(-(sbrk(0) - break0));
     550:	4501                	li	a0,0
     552:	00001097          	auipc	ra,0x1
     556:	e84080e7          	jalr	-380(ra) # 13d6 <sbrk>
     55a:	872a                	mv	a4,a0
     55c:	fd843783          	ld	a5,-40(s0)
     560:	8f99                	sub	a5,a5,a4
     562:	2781                	sext.w	a5,a5
     564:	853e                	mv	a0,a5
     566:	00001097          	auipc	ra,0x1
     56a:	e70080e7          	jalr	-400(ra) # 13d6 <sbrk>
     56e:	b6f9                	j	13c <go+0x74>
    } else if(what == 17){
     570:	fd442783          	lw	a5,-44(s0)
     574:	0007871b          	sext.w	a4,a5
     578:	47c5                	li	a5,17
     57a:	0af71863          	bne	a4,a5,62a <go+0x562>
      int pid = fork();
     57e:	00001097          	auipc	ra,0x1
     582:	dc8080e7          	jalr	-568(ra) # 1346 <fork>
     586:	87aa                	mv	a5,a0
     588:	faf42c23          	sw	a5,-72(s0)
      if(pid == 0){
     58c:	fb842783          	lw	a5,-72(s0)
     590:	2781                	sext.w	a5,a5
     592:	e795                	bnez	a5,5be <go+0x4f6>
        close(open("a", O_CREATE|O_RDWR));
     594:	20200593          	li	a1,514
     598:	00002517          	auipc	a0,0x2
     59c:	ed050513          	addi	a0,a0,-304 # 2468 <schedule_dm+0x32c>
     5a0:	00001097          	auipc	ra,0x1
     5a4:	dee080e7          	jalr	-530(ra) # 138e <open>
     5a8:	87aa                	mv	a5,a0
     5aa:	853e                	mv	a0,a5
     5ac:	00001097          	auipc	ra,0x1
     5b0:	dca080e7          	jalr	-566(ra) # 1376 <close>
        exit(0);
     5b4:	4501                	li	a0,0
     5b6:	00001097          	auipc	ra,0x1
     5ba:	d98080e7          	jalr	-616(ra) # 134e <exit>
      } else if(pid < 0){
     5be:	fb842783          	lw	a5,-72(s0)
     5c2:	2781                	sext.w	a5,a5
     5c4:	0007df63          	bgez	a5,5e2 <go+0x51a>
        printf("grind: fork failed\n");
     5c8:	00002517          	auipc	a0,0x2
     5cc:	e8850513          	addi	a0,a0,-376 # 2450 <schedule_dm+0x314>
     5d0:	00001097          	auipc	ra,0x1
     5d4:	2c4080e7          	jalr	708(ra) # 1894 <printf>
        exit(1);
     5d8:	4505                	li	a0,1
     5da:	00001097          	auipc	ra,0x1
     5de:	d74080e7          	jalr	-652(ra) # 134e <exit>
      }
      if(chdir("../grindir/..") != 0){
     5e2:	00002517          	auipc	a0,0x2
     5e6:	e8e50513          	addi	a0,a0,-370 # 2470 <schedule_dm+0x334>
     5ea:	00001097          	auipc	ra,0x1
     5ee:	dd4080e7          	jalr	-556(ra) # 13be <chdir>
     5f2:	87aa                	mv	a5,a0
     5f4:	cf91                	beqz	a5,610 <go+0x548>
        printf("grind: chdir failed\n");
     5f6:	00002517          	auipc	a0,0x2
     5fa:	e8a50513          	addi	a0,a0,-374 # 2480 <schedule_dm+0x344>
     5fe:	00001097          	auipc	ra,0x1
     602:	296080e7          	jalr	662(ra) # 1894 <printf>
        exit(1);
     606:	4505                	li	a0,1
     608:	00001097          	auipc	ra,0x1
     60c:	d46080e7          	jalr	-698(ra) # 134e <exit>
      }
      kill(pid);
     610:	fb842783          	lw	a5,-72(s0)
     614:	853e                	mv	a0,a5
     616:	00001097          	auipc	ra,0x1
     61a:	d68080e7          	jalr	-664(ra) # 137e <kill>
      wait(0);
     61e:	4501                	li	a0,0
     620:	00001097          	auipc	ra,0x1
     624:	d36080e7          	jalr	-714(ra) # 1356 <wait>
     628:	be11                	j	13c <go+0x74>
    } else if(what == 18){
     62a:	fd442783          	lw	a5,-44(s0)
     62e:	0007871b          	sext.w	a4,a5
     632:	47c9                	li	a5,18
     634:	06f71463          	bne	a4,a5,69c <go+0x5d4>
      int pid = fork();
     638:	00001097          	auipc	ra,0x1
     63c:	d0e080e7          	jalr	-754(ra) # 1346 <fork>
     640:	87aa                	mv	a5,a0
     642:	faf42e23          	sw	a5,-68(s0)
      if(pid == 0){
     646:	fbc42783          	lw	a5,-68(s0)
     64a:	2781                	sext.w	a5,a5
     64c:	e385                	bnez	a5,66c <go+0x5a4>
        kill(getpid());
     64e:	00001097          	auipc	ra,0x1
     652:	d80080e7          	jalr	-640(ra) # 13ce <getpid>
     656:	87aa                	mv	a5,a0
     658:	853e                	mv	a0,a5
     65a:	00001097          	auipc	ra,0x1
     65e:	d24080e7          	jalr	-732(ra) # 137e <kill>
        exit(0);
     662:	4501                	li	a0,0
     664:	00001097          	auipc	ra,0x1
     668:	cea080e7          	jalr	-790(ra) # 134e <exit>
      } else if(pid < 0){
     66c:	fbc42783          	lw	a5,-68(s0)
     670:	2781                	sext.w	a5,a5
     672:	0007df63          	bgez	a5,690 <go+0x5c8>
        printf("grind: fork failed\n");
     676:	00002517          	auipc	a0,0x2
     67a:	dda50513          	addi	a0,a0,-550 # 2450 <schedule_dm+0x314>
     67e:	00001097          	auipc	ra,0x1
     682:	216080e7          	jalr	534(ra) # 1894 <printf>
        exit(1);
     686:	4505                	li	a0,1
     688:	00001097          	auipc	ra,0x1
     68c:	cc6080e7          	jalr	-826(ra) # 134e <exit>
      }
      wait(0);
     690:	4501                	li	a0,0
     692:	00001097          	auipc	ra,0x1
     696:	cc4080e7          	jalr	-828(ra) # 1356 <wait>
     69a:	b44d                	j	13c <go+0x74>
    } else if(what == 19){
     69c:	fd442783          	lw	a5,-44(s0)
     6a0:	0007871b          	sext.w	a4,a5
     6a4:	47cd                	li	a5,19
     6a6:	10f71863          	bne	a4,a5,7b6 <go+0x6ee>
      int fds[2];
      if(pipe(fds) < 0){
     6aa:	fa840793          	addi	a5,s0,-88
     6ae:	853e                	mv	a0,a5
     6b0:	00001097          	auipc	ra,0x1
     6b4:	cae080e7          	jalr	-850(ra) # 135e <pipe>
     6b8:	87aa                	mv	a5,a0
     6ba:	0007df63          	bgez	a5,6d8 <go+0x610>
        printf("grind: pipe failed\n");
     6be:	00002517          	auipc	a0,0x2
     6c2:	dda50513          	addi	a0,a0,-550 # 2498 <schedule_dm+0x35c>
     6c6:	00001097          	auipc	ra,0x1
     6ca:	1ce080e7          	jalr	462(ra) # 1894 <printf>
        exit(1);
     6ce:	4505                	li	a0,1
     6d0:	00001097          	auipc	ra,0x1
     6d4:	c7e080e7          	jalr	-898(ra) # 134e <exit>
      }
      int pid = fork();
     6d8:	00001097          	auipc	ra,0x1
     6dc:	c6e080e7          	jalr	-914(ra) # 1346 <fork>
     6e0:	87aa                	mv	a5,a0
     6e2:	fcf42023          	sw	a5,-64(s0)
      if(pid == 0){
     6e6:	fc042783          	lw	a5,-64(s0)
     6ea:	2781                	sext.w	a5,a5
     6ec:	efbd                	bnez	a5,76a <go+0x6a2>
        fork();
     6ee:	00001097          	auipc	ra,0x1
     6f2:	c58080e7          	jalr	-936(ra) # 1346 <fork>
        fork();
     6f6:	00001097          	auipc	ra,0x1
     6fa:	c50080e7          	jalr	-944(ra) # 1346 <fork>
        if(write(fds[1], "x", 1) != 1)
     6fe:	fac42783          	lw	a5,-84(s0)
     702:	4605                	li	a2,1
     704:	00002597          	auipc	a1,0x2
     708:	dac58593          	addi	a1,a1,-596 # 24b0 <schedule_dm+0x374>
     70c:	853e                	mv	a0,a5
     70e:	00001097          	auipc	ra,0x1
     712:	c60080e7          	jalr	-928(ra) # 136e <write>
     716:	87aa                	mv	a5,a0
     718:	873e                	mv	a4,a5
     71a:	4785                	li	a5,1
     71c:	00f70a63          	beq	a4,a5,730 <go+0x668>
          printf("grind: pipe write failed\n");
     720:	00002517          	auipc	a0,0x2
     724:	d9850513          	addi	a0,a0,-616 # 24b8 <schedule_dm+0x37c>
     728:	00001097          	auipc	ra,0x1
     72c:	16c080e7          	jalr	364(ra) # 1894 <printf>
        char c;
        if(read(fds[0], &c, 1) != 1)
     730:	fa842783          	lw	a5,-88(s0)
     734:	fa740713          	addi	a4,s0,-89
     738:	4605                	li	a2,1
     73a:	85ba                	mv	a1,a4
     73c:	853e                	mv	a0,a5
     73e:	00001097          	auipc	ra,0x1
     742:	c28080e7          	jalr	-984(ra) # 1366 <read>
     746:	87aa                	mv	a5,a0
     748:	873e                	mv	a4,a5
     74a:	4785                	li	a5,1
     74c:	00f70a63          	beq	a4,a5,760 <go+0x698>
          printf("grind: pipe read failed\n");
     750:	00002517          	auipc	a0,0x2
     754:	d8850513          	addi	a0,a0,-632 # 24d8 <schedule_dm+0x39c>
     758:	00001097          	auipc	ra,0x1
     75c:	13c080e7          	jalr	316(ra) # 1894 <printf>
        exit(0);
     760:	4501                	li	a0,0
     762:	00001097          	auipc	ra,0x1
     766:	bec080e7          	jalr	-1044(ra) # 134e <exit>
      } else if(pid < 0){
     76a:	fc042783          	lw	a5,-64(s0)
     76e:	2781                	sext.w	a5,a5
     770:	0007df63          	bgez	a5,78e <go+0x6c6>
        printf("grind: fork failed\n");
     774:	00002517          	auipc	a0,0x2
     778:	cdc50513          	addi	a0,a0,-804 # 2450 <schedule_dm+0x314>
     77c:	00001097          	auipc	ra,0x1
     780:	118080e7          	jalr	280(ra) # 1894 <printf>
        exit(1);
     784:	4505                	li	a0,1
     786:	00001097          	auipc	ra,0x1
     78a:	bc8080e7          	jalr	-1080(ra) # 134e <exit>
      }
      close(fds[0]);
     78e:	fa842783          	lw	a5,-88(s0)
     792:	853e                	mv	a0,a5
     794:	00001097          	auipc	ra,0x1
     798:	be2080e7          	jalr	-1054(ra) # 1376 <close>
      close(fds[1]);
     79c:	fac42783          	lw	a5,-84(s0)
     7a0:	853e                	mv	a0,a5
     7a2:	00001097          	auipc	ra,0x1
     7a6:	bd4080e7          	jalr	-1068(ra) # 1376 <close>
      wait(0);
     7aa:	4501                	li	a0,0
     7ac:	00001097          	auipc	ra,0x1
     7b0:	baa080e7          	jalr	-1110(ra) # 1356 <wait>
     7b4:	b261                	j	13c <go+0x74>
    } else if(what == 20){
     7b6:	fd442783          	lw	a5,-44(s0)
     7ba:	0007871b          	sext.w	a4,a5
     7be:	47d1                	li	a5,20
     7c0:	0af71f63          	bne	a4,a5,87e <go+0x7b6>
      int pid = fork();
     7c4:	00001097          	auipc	ra,0x1
     7c8:	b82080e7          	jalr	-1150(ra) # 1346 <fork>
     7cc:	87aa                	mv	a5,a0
     7ce:	fcf42223          	sw	a5,-60(s0)
      if(pid == 0){
     7d2:	fc442783          	lw	a5,-60(s0)
     7d6:	2781                	sext.w	a5,a5
     7d8:	ebbd                	bnez	a5,84e <go+0x786>
        unlink("a");
     7da:	00002517          	auipc	a0,0x2
     7de:	c8e50513          	addi	a0,a0,-882 # 2468 <schedule_dm+0x32c>
     7e2:	00001097          	auipc	ra,0x1
     7e6:	bbc080e7          	jalr	-1092(ra) # 139e <unlink>
        mkdir("a");
     7ea:	00002517          	auipc	a0,0x2
     7ee:	c7e50513          	addi	a0,a0,-898 # 2468 <schedule_dm+0x32c>
     7f2:	00001097          	auipc	ra,0x1
     7f6:	bc4080e7          	jalr	-1084(ra) # 13b6 <mkdir>
        chdir("a");
     7fa:	00002517          	auipc	a0,0x2
     7fe:	c6e50513          	addi	a0,a0,-914 # 2468 <schedule_dm+0x32c>
     802:	00001097          	auipc	ra,0x1
     806:	bbc080e7          	jalr	-1092(ra) # 13be <chdir>
        unlink("../a");
     80a:	00002517          	auipc	a0,0x2
     80e:	cee50513          	addi	a0,a0,-786 # 24f8 <schedule_dm+0x3bc>
     812:	00001097          	auipc	ra,0x1
     816:	b8c080e7          	jalr	-1140(ra) # 139e <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     81a:	20200593          	li	a1,514
     81e:	00002517          	auipc	a0,0x2
     822:	c9250513          	addi	a0,a0,-878 # 24b0 <schedule_dm+0x374>
     826:	00001097          	auipc	ra,0x1
     82a:	b68080e7          	jalr	-1176(ra) # 138e <open>
     82e:	87aa                	mv	a5,a0
     830:	fef42623          	sw	a5,-20(s0)
        unlink("x");
     834:	00002517          	auipc	a0,0x2
     838:	c7c50513          	addi	a0,a0,-900 # 24b0 <schedule_dm+0x374>
     83c:	00001097          	auipc	ra,0x1
     840:	b62080e7          	jalr	-1182(ra) # 139e <unlink>
        exit(0);
     844:	4501                	li	a0,0
     846:	00001097          	auipc	ra,0x1
     84a:	b08080e7          	jalr	-1272(ra) # 134e <exit>
      } else if(pid < 0){
     84e:	fc442783          	lw	a5,-60(s0)
     852:	2781                	sext.w	a5,a5
     854:	0007df63          	bgez	a5,872 <go+0x7aa>
        printf("grind: fork failed\n");
     858:	00002517          	auipc	a0,0x2
     85c:	bf850513          	addi	a0,a0,-1032 # 2450 <schedule_dm+0x314>
     860:	00001097          	auipc	ra,0x1
     864:	034080e7          	jalr	52(ra) # 1894 <printf>
        exit(1);
     868:	4505                	li	a0,1
     86a:	00001097          	auipc	ra,0x1
     86e:	ae4080e7          	jalr	-1308(ra) # 134e <exit>
      }
      wait(0);
     872:	4501                	li	a0,0
     874:	00001097          	auipc	ra,0x1
     878:	ae2080e7          	jalr	-1310(ra) # 1356 <wait>
     87c:	b0c1                	j	13c <go+0x74>
    } else if(what == 21){
     87e:	fd442783          	lw	a5,-44(s0)
     882:	0007871b          	sext.w	a4,a5
     886:	47d5                	li	a5,21
     888:	12f71e63          	bne	a4,a5,9c4 <go+0x8fc>
      unlink("c");
     88c:	00002517          	auipc	a0,0x2
     890:	c7450513          	addi	a0,a0,-908 # 2500 <schedule_dm+0x3c4>
     894:	00001097          	auipc	ra,0x1
     898:	b0a080e7          	jalr	-1270(ra) # 139e <unlink>
      // should always succeed. check that there are free i-nodes,
      // file descriptors, blocks.
      int fd1 = open("c", O_CREATE|O_RDWR);
     89c:	20200593          	li	a1,514
     8a0:	00002517          	auipc	a0,0x2
     8a4:	c6050513          	addi	a0,a0,-928 # 2500 <schedule_dm+0x3c4>
     8a8:	00001097          	auipc	ra,0x1
     8ac:	ae6080e7          	jalr	-1306(ra) # 138e <open>
     8b0:	87aa                	mv	a5,a0
     8b2:	fcf42423          	sw	a5,-56(s0)
      if(fd1 < 0){
     8b6:	fc842783          	lw	a5,-56(s0)
     8ba:	2781                	sext.w	a5,a5
     8bc:	0007df63          	bgez	a5,8da <go+0x812>
        printf("grind: create c failed\n");
     8c0:	00002517          	auipc	a0,0x2
     8c4:	c4850513          	addi	a0,a0,-952 # 2508 <schedule_dm+0x3cc>
     8c8:	00001097          	auipc	ra,0x1
     8cc:	fcc080e7          	jalr	-52(ra) # 1894 <printf>
        exit(1);
     8d0:	4505                	li	a0,1
     8d2:	00001097          	auipc	ra,0x1
     8d6:	a7c080e7          	jalr	-1412(ra) # 134e <exit>
      }
      if(write(fd1, "x", 1) != 1){
     8da:	fc842783          	lw	a5,-56(s0)
     8de:	4605                	li	a2,1
     8e0:	00002597          	auipc	a1,0x2
     8e4:	bd058593          	addi	a1,a1,-1072 # 24b0 <schedule_dm+0x374>
     8e8:	853e                	mv	a0,a5
     8ea:	00001097          	auipc	ra,0x1
     8ee:	a84080e7          	jalr	-1404(ra) # 136e <write>
     8f2:	87aa                	mv	a5,a0
     8f4:	873e                	mv	a4,a5
     8f6:	4785                	li	a5,1
     8f8:	00f70f63          	beq	a4,a5,916 <go+0x84e>
        printf("grind: write c failed\n");
     8fc:	00002517          	auipc	a0,0x2
     900:	c2450513          	addi	a0,a0,-988 # 2520 <schedule_dm+0x3e4>
     904:	00001097          	auipc	ra,0x1
     908:	f90080e7          	jalr	-112(ra) # 1894 <printf>
        exit(1);
     90c:	4505                	li	a0,1
     90e:	00001097          	auipc	ra,0x1
     912:	a40080e7          	jalr	-1472(ra) # 134e <exit>
      }
      struct stat st;
      if(fstat(fd1, &st) != 0){
     916:	f8840713          	addi	a4,s0,-120
     91a:	fc842783          	lw	a5,-56(s0)
     91e:	85ba                	mv	a1,a4
     920:	853e                	mv	a0,a5
     922:	00001097          	auipc	ra,0x1
     926:	a84080e7          	jalr	-1404(ra) # 13a6 <fstat>
     92a:	87aa                	mv	a5,a0
     92c:	cf91                	beqz	a5,948 <go+0x880>
        printf("grind: fstat failed\n");
     92e:	00002517          	auipc	a0,0x2
     932:	c0a50513          	addi	a0,a0,-1014 # 2538 <schedule_dm+0x3fc>
     936:	00001097          	auipc	ra,0x1
     93a:	f5e080e7          	jalr	-162(ra) # 1894 <printf>
        exit(1);
     93e:	4505                	li	a0,1
     940:	00001097          	auipc	ra,0x1
     944:	a0e080e7          	jalr	-1522(ra) # 134e <exit>
      }
      if(st.size != 1){
     948:	f9843703          	ld	a4,-104(s0)
     94c:	4785                	li	a5,1
     94e:	02f70363          	beq	a4,a5,974 <go+0x8ac>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     952:	f9843783          	ld	a5,-104(s0)
     956:	2781                	sext.w	a5,a5
     958:	85be                	mv	a1,a5
     95a:	00002517          	auipc	a0,0x2
     95e:	bf650513          	addi	a0,a0,-1034 # 2550 <schedule_dm+0x414>
     962:	00001097          	auipc	ra,0x1
     966:	f32080e7          	jalr	-206(ra) # 1894 <printf>
        exit(1);
     96a:	4505                	li	a0,1
     96c:	00001097          	auipc	ra,0x1
     970:	9e2080e7          	jalr	-1566(ra) # 134e <exit>
      }
      if(st.ino > 200){
     974:	f8c42783          	lw	a5,-116(s0)
     978:	873e                	mv	a4,a5
     97a:	0c800793          	li	a5,200
     97e:	02e7f263          	bgeu	a5,a4,9a2 <go+0x8da>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     982:	f8c42783          	lw	a5,-116(s0)
     986:	85be                	mv	a1,a5
     988:	00002517          	auipc	a0,0x2
     98c:	bf050513          	addi	a0,a0,-1040 # 2578 <schedule_dm+0x43c>
     990:	00001097          	auipc	ra,0x1
     994:	f04080e7          	jalr	-252(ra) # 1894 <printf>
        exit(1);
     998:	4505                	li	a0,1
     99a:	00001097          	auipc	ra,0x1
     99e:	9b4080e7          	jalr	-1612(ra) # 134e <exit>
      }
      close(fd1);
     9a2:	fc842783          	lw	a5,-56(s0)
     9a6:	853e                	mv	a0,a5
     9a8:	00001097          	auipc	ra,0x1
     9ac:	9ce080e7          	jalr	-1586(ra) # 1376 <close>
      unlink("c");
     9b0:	00002517          	auipc	a0,0x2
     9b4:	b5050513          	addi	a0,a0,-1200 # 2500 <schedule_dm+0x3c4>
     9b8:	00001097          	auipc	ra,0x1
     9bc:	9e6080e7          	jalr	-1562(ra) # 139e <unlink>
     9c0:	f7cff06f          	j	13c <go+0x74>
    } else if(what == 22){
     9c4:	fd442783          	lw	a5,-44(s0)
     9c8:	0007871b          	sext.w	a4,a5
     9cc:	47d9                	li	a5,22
     9ce:	f6f71763          	bne	a4,a5,13c <go+0x74>
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     9d2:	f8040793          	addi	a5,s0,-128
     9d6:	853e                	mv	a0,a5
     9d8:	00001097          	auipc	ra,0x1
     9dc:	986080e7          	jalr	-1658(ra) # 135e <pipe>
     9e0:	87aa                	mv	a5,a0
     9e2:	0207d063          	bgez	a5,a02 <go+0x93a>
        fprintf(2, "grind: pipe failed\n");
     9e6:	00002597          	auipc	a1,0x2
     9ea:	ab258593          	addi	a1,a1,-1358 # 2498 <schedule_dm+0x35c>
     9ee:	4509                	li	a0,2
     9f0:	00001097          	auipc	ra,0x1
     9f4:	e4c080e7          	jalr	-436(ra) # 183c <fprintf>
        exit(1);
     9f8:	4505                	li	a0,1
     9fa:	00001097          	auipc	ra,0x1
     9fe:	954080e7          	jalr	-1708(ra) # 134e <exit>
      }
      if(pipe(bb) < 0){
     a02:	f7840793          	addi	a5,s0,-136
     a06:	853e                	mv	a0,a5
     a08:	00001097          	auipc	ra,0x1
     a0c:	956080e7          	jalr	-1706(ra) # 135e <pipe>
     a10:	87aa                	mv	a5,a0
     a12:	0207d063          	bgez	a5,a32 <go+0x96a>
        fprintf(2, "grind: pipe failed\n");
     a16:	00002597          	auipc	a1,0x2
     a1a:	a8258593          	addi	a1,a1,-1406 # 2498 <schedule_dm+0x35c>
     a1e:	4509                	li	a0,2
     a20:	00001097          	auipc	ra,0x1
     a24:	e1c080e7          	jalr	-484(ra) # 183c <fprintf>
        exit(1);
     a28:	4505                	li	a0,1
     a2a:	00001097          	auipc	ra,0x1
     a2e:	924080e7          	jalr	-1756(ra) # 134e <exit>
      }
      int pid1 = fork();
     a32:	00001097          	auipc	ra,0x1
     a36:	914080e7          	jalr	-1772(ra) # 1346 <fork>
     a3a:	87aa                	mv	a5,a0
     a3c:	fcf42823          	sw	a5,-48(s0)
      if(pid1 == 0){
     a40:	fd042783          	lw	a5,-48(s0)
     a44:	2781                	sext.w	a5,a5
     a46:	e3f9                	bnez	a5,b0c <go+0xa44>
        close(bb[0]);
     a48:	f7842783          	lw	a5,-136(s0)
     a4c:	853e                	mv	a0,a5
     a4e:	00001097          	auipc	ra,0x1
     a52:	928080e7          	jalr	-1752(ra) # 1376 <close>
        close(bb[1]);
     a56:	f7c42783          	lw	a5,-132(s0)
     a5a:	853e                	mv	a0,a5
     a5c:	00001097          	auipc	ra,0x1
     a60:	91a080e7          	jalr	-1766(ra) # 1376 <close>
        close(aa[0]);
     a64:	f8042783          	lw	a5,-128(s0)
     a68:	853e                	mv	a0,a5
     a6a:	00001097          	auipc	ra,0x1
     a6e:	90c080e7          	jalr	-1780(ra) # 1376 <close>
        close(1);
     a72:	4505                	li	a0,1
     a74:	00001097          	auipc	ra,0x1
     a78:	902080e7          	jalr	-1790(ra) # 1376 <close>
        if(dup(aa[1]) != 1){
     a7c:	f8442783          	lw	a5,-124(s0)
     a80:	853e                	mv	a0,a5
     a82:	00001097          	auipc	ra,0x1
     a86:	944080e7          	jalr	-1724(ra) # 13c6 <dup>
     a8a:	87aa                	mv	a5,a0
     a8c:	873e                	mv	a4,a5
     a8e:	4785                	li	a5,1
     a90:	02f70063          	beq	a4,a5,ab0 <go+0x9e8>
          fprintf(2, "grind: dup failed\n");
     a94:	00002597          	auipc	a1,0x2
     a98:	b0c58593          	addi	a1,a1,-1268 # 25a0 <schedule_dm+0x464>
     a9c:	4509                	li	a0,2
     a9e:	00001097          	auipc	ra,0x1
     aa2:	d9e080e7          	jalr	-610(ra) # 183c <fprintf>
          exit(1);
     aa6:	4505                	li	a0,1
     aa8:	00001097          	auipc	ra,0x1
     aac:	8a6080e7          	jalr	-1882(ra) # 134e <exit>
        }
        close(aa[1]);
     ab0:	f8442783          	lw	a5,-124(s0)
     ab4:	853e                	mv	a0,a5
     ab6:	00001097          	auipc	ra,0x1
     aba:	8c0080e7          	jalr	-1856(ra) # 1376 <close>
        char *args[3] = { "echo", "hi", 0 };
     abe:	00002797          	auipc	a5,0x2
     ac2:	afa78793          	addi	a5,a5,-1286 # 25b8 <schedule_dm+0x47c>
     ac6:	f4f43823          	sd	a5,-176(s0)
     aca:	00002797          	auipc	a5,0x2
     ace:	af678793          	addi	a5,a5,-1290 # 25c0 <schedule_dm+0x484>
     ad2:	f4f43c23          	sd	a5,-168(s0)
     ad6:	f6043023          	sd	zero,-160(s0)
        exec("grindir/../echo", args);
     ada:	f5040793          	addi	a5,s0,-176
     ade:	85be                	mv	a1,a5
     ae0:	00002517          	auipc	a0,0x2
     ae4:	ae850513          	addi	a0,a0,-1304 # 25c8 <schedule_dm+0x48c>
     ae8:	00001097          	auipc	ra,0x1
     aec:	89e080e7          	jalr	-1890(ra) # 1386 <exec>
        fprintf(2, "grind: echo: not found\n");
     af0:	00002597          	auipc	a1,0x2
     af4:	ae858593          	addi	a1,a1,-1304 # 25d8 <schedule_dm+0x49c>
     af8:	4509                	li	a0,2
     afa:	00001097          	auipc	ra,0x1
     afe:	d42080e7          	jalr	-702(ra) # 183c <fprintf>
        exit(2);
     b02:	4509                	li	a0,2
     b04:	00001097          	auipc	ra,0x1
     b08:	84a080e7          	jalr	-1974(ra) # 134e <exit>
      } else if(pid1 < 0){
     b0c:	fd042783          	lw	a5,-48(s0)
     b10:	2781                	sext.w	a5,a5
     b12:	0207d063          	bgez	a5,b32 <go+0xa6a>
        fprintf(2, "grind: fork failed\n");
     b16:	00002597          	auipc	a1,0x2
     b1a:	93a58593          	addi	a1,a1,-1734 # 2450 <schedule_dm+0x314>
     b1e:	4509                	li	a0,2
     b20:	00001097          	auipc	ra,0x1
     b24:	d1c080e7          	jalr	-740(ra) # 183c <fprintf>
        exit(3);
     b28:	450d                	li	a0,3
     b2a:	00001097          	auipc	ra,0x1
     b2e:	824080e7          	jalr	-2012(ra) # 134e <exit>
      }
      int pid2 = fork();
     b32:	00001097          	auipc	ra,0x1
     b36:	814080e7          	jalr	-2028(ra) # 1346 <fork>
     b3a:	87aa                	mv	a5,a0
     b3c:	fcf42623          	sw	a5,-52(s0)
      if(pid2 == 0){
     b40:	fcc42783          	lw	a5,-52(s0)
     b44:	2781                	sext.w	a5,a5
     b46:	ebed                	bnez	a5,c38 <go+0xb70>
        close(aa[1]);
     b48:	f8442783          	lw	a5,-124(s0)
     b4c:	853e                	mv	a0,a5
     b4e:	00001097          	auipc	ra,0x1
     b52:	828080e7          	jalr	-2008(ra) # 1376 <close>
        close(bb[0]);
     b56:	f7842783          	lw	a5,-136(s0)
     b5a:	853e                	mv	a0,a5
     b5c:	00001097          	auipc	ra,0x1
     b60:	81a080e7          	jalr	-2022(ra) # 1376 <close>
        close(0);
     b64:	4501                	li	a0,0
     b66:	00001097          	auipc	ra,0x1
     b6a:	810080e7          	jalr	-2032(ra) # 1376 <close>
        if(dup(aa[0]) != 0){
     b6e:	f8042783          	lw	a5,-128(s0)
     b72:	853e                	mv	a0,a5
     b74:	00001097          	auipc	ra,0x1
     b78:	852080e7          	jalr	-1966(ra) # 13c6 <dup>
     b7c:	87aa                	mv	a5,a0
     b7e:	cf99                	beqz	a5,b9c <go+0xad4>
          fprintf(2, "grind: dup failed\n");
     b80:	00002597          	auipc	a1,0x2
     b84:	a2058593          	addi	a1,a1,-1504 # 25a0 <schedule_dm+0x464>
     b88:	4509                	li	a0,2
     b8a:	00001097          	auipc	ra,0x1
     b8e:	cb2080e7          	jalr	-846(ra) # 183c <fprintf>
          exit(4);
     b92:	4511                	li	a0,4
     b94:	00000097          	auipc	ra,0x0
     b98:	7ba080e7          	jalr	1978(ra) # 134e <exit>
        }
        close(aa[0]);
     b9c:	f8042783          	lw	a5,-128(s0)
     ba0:	853e                	mv	a0,a5
     ba2:	00000097          	auipc	ra,0x0
     ba6:	7d4080e7          	jalr	2004(ra) # 1376 <close>
        close(1);
     baa:	4505                	li	a0,1
     bac:	00000097          	auipc	ra,0x0
     bb0:	7ca080e7          	jalr	1994(ra) # 1376 <close>
        if(dup(bb[1]) != 1){
     bb4:	f7c42783          	lw	a5,-132(s0)
     bb8:	853e                	mv	a0,a5
     bba:	00001097          	auipc	ra,0x1
     bbe:	80c080e7          	jalr	-2036(ra) # 13c6 <dup>
     bc2:	87aa                	mv	a5,a0
     bc4:	873e                	mv	a4,a5
     bc6:	4785                	li	a5,1
     bc8:	02f70063          	beq	a4,a5,be8 <go+0xb20>
          fprintf(2, "grind: dup failed\n");
     bcc:	00002597          	auipc	a1,0x2
     bd0:	9d458593          	addi	a1,a1,-1580 # 25a0 <schedule_dm+0x464>
     bd4:	4509                	li	a0,2
     bd6:	00001097          	auipc	ra,0x1
     bda:	c66080e7          	jalr	-922(ra) # 183c <fprintf>
          exit(5);
     bde:	4515                	li	a0,5
     be0:	00000097          	auipc	ra,0x0
     be4:	76e080e7          	jalr	1902(ra) # 134e <exit>
        }
        close(bb[1]);
     be8:	f7c42783          	lw	a5,-132(s0)
     bec:	853e                	mv	a0,a5
     bee:	00000097          	auipc	ra,0x0
     bf2:	788080e7          	jalr	1928(ra) # 1376 <close>
        char *args[2] = { "cat", 0 };
     bf6:	00002797          	auipc	a5,0x2
     bfa:	9fa78793          	addi	a5,a5,-1542 # 25f0 <schedule_dm+0x4b4>
     bfe:	f4f43023          	sd	a5,-192(s0)
     c02:	f4043423          	sd	zero,-184(s0)
        exec("/cat", args);
     c06:	f4040793          	addi	a5,s0,-192
     c0a:	85be                	mv	a1,a5
     c0c:	00002517          	auipc	a0,0x2
     c10:	9ec50513          	addi	a0,a0,-1556 # 25f8 <schedule_dm+0x4bc>
     c14:	00000097          	auipc	ra,0x0
     c18:	772080e7          	jalr	1906(ra) # 1386 <exec>
        fprintf(2, "grind: cat: not found\n");
     c1c:	00002597          	auipc	a1,0x2
     c20:	9e458593          	addi	a1,a1,-1564 # 2600 <schedule_dm+0x4c4>
     c24:	4509                	li	a0,2
     c26:	00001097          	auipc	ra,0x1
     c2a:	c16080e7          	jalr	-1002(ra) # 183c <fprintf>
        exit(6);
     c2e:	4519                	li	a0,6
     c30:	00000097          	auipc	ra,0x0
     c34:	71e080e7          	jalr	1822(ra) # 134e <exit>
      } else if(pid2 < 0){
     c38:	fcc42783          	lw	a5,-52(s0)
     c3c:	2781                	sext.w	a5,a5
     c3e:	0207d063          	bgez	a5,c5e <go+0xb96>
        fprintf(2, "grind: fork failed\n");
     c42:	00002597          	auipc	a1,0x2
     c46:	80e58593          	addi	a1,a1,-2034 # 2450 <schedule_dm+0x314>
     c4a:	4509                	li	a0,2
     c4c:	00001097          	auipc	ra,0x1
     c50:	bf0080e7          	jalr	-1040(ra) # 183c <fprintf>
        exit(7);
     c54:	451d                	li	a0,7
     c56:	00000097          	auipc	ra,0x0
     c5a:	6f8080e7          	jalr	1784(ra) # 134e <exit>
      }
      close(aa[0]);
     c5e:	f8042783          	lw	a5,-128(s0)
     c62:	853e                	mv	a0,a5
     c64:	00000097          	auipc	ra,0x0
     c68:	712080e7          	jalr	1810(ra) # 1376 <close>
      close(aa[1]);
     c6c:	f8442783          	lw	a5,-124(s0)
     c70:	853e                	mv	a0,a5
     c72:	00000097          	auipc	ra,0x0
     c76:	704080e7          	jalr	1796(ra) # 1376 <close>
      close(bb[1]);
     c7a:	f7c42783          	lw	a5,-132(s0)
     c7e:	853e                	mv	a0,a5
     c80:	00000097          	auipc	ra,0x0
     c84:	6f6080e7          	jalr	1782(ra) # 1376 <close>
      char buf[3] = { 0, 0, 0 };
     c88:	f6041823          	sh	zero,-144(s0)
     c8c:	f6040923          	sb	zero,-142(s0)
      read(bb[0], buf+0, 1);
     c90:	f7842783          	lw	a5,-136(s0)
     c94:	f7040713          	addi	a4,s0,-144
     c98:	4605                	li	a2,1
     c9a:	85ba                	mv	a1,a4
     c9c:	853e                	mv	a0,a5
     c9e:	00000097          	auipc	ra,0x0
     ca2:	6c8080e7          	jalr	1736(ra) # 1366 <read>
      read(bb[0], buf+1, 1);
     ca6:	f7842703          	lw	a4,-136(s0)
     caa:	f7040793          	addi	a5,s0,-144
     cae:	0785                	addi	a5,a5,1
     cb0:	4605                	li	a2,1
     cb2:	85be                	mv	a1,a5
     cb4:	853a                	mv	a0,a4
     cb6:	00000097          	auipc	ra,0x0
     cba:	6b0080e7          	jalr	1712(ra) # 1366 <read>
      close(bb[0]);
     cbe:	f7842783          	lw	a5,-136(s0)
     cc2:	853e                	mv	a0,a5
     cc4:	00000097          	auipc	ra,0x0
     cc8:	6b2080e7          	jalr	1714(ra) # 1376 <close>
      int st1, st2;
      wait(&st1);
     ccc:	f6c40793          	addi	a5,s0,-148
     cd0:	853e                	mv	a0,a5
     cd2:	00000097          	auipc	ra,0x0
     cd6:	684080e7          	jalr	1668(ra) # 1356 <wait>
      wait(&st2);
     cda:	f6840793          	addi	a5,s0,-152
     cde:	853e                	mv	a0,a5
     ce0:	00000097          	auipc	ra,0x0
     ce4:	676080e7          	jalr	1654(ra) # 1356 <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi") != 0){
     ce8:	f6c42783          	lw	a5,-148(s0)
     cec:	e395                	bnez	a5,d10 <go+0xc48>
     cee:	f6842783          	lw	a5,-152(s0)
     cf2:	ef99                	bnez	a5,d10 <go+0xc48>
     cf4:	f7040793          	addi	a5,s0,-144
     cf8:	00002597          	auipc	a1,0x2
     cfc:	8c858593          	addi	a1,a1,-1848 # 25c0 <schedule_dm+0x484>
     d00:	853e                	mv	a0,a5
     d02:	00000097          	auipc	ra,0x0
     d06:	206080e7          	jalr	518(ra) # f08 <strcmp>
     d0a:	87aa                	mv	a5,a0
     d0c:	c2078863          	beqz	a5,13c <go+0x74>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     d10:	f6c42783          	lw	a5,-148(s0)
     d14:	f6842703          	lw	a4,-152(s0)
     d18:	f7040693          	addi	a3,s0,-144
     d1c:	863a                	mv	a2,a4
     d1e:	85be                	mv	a1,a5
     d20:	00002517          	auipc	a0,0x2
     d24:	8f850513          	addi	a0,a0,-1800 # 2618 <schedule_dm+0x4dc>
     d28:	00001097          	auipc	ra,0x1
     d2c:	b6c080e7          	jalr	-1172(ra) # 1894 <printf>
        exit(1);
     d30:	4505                	li	a0,1
     d32:	00000097          	auipc	ra,0x0
     d36:	61c080e7          	jalr	1564(ra) # 134e <exit>

0000000000000d3a <iter>:
  }
}

void
iter()
{
     d3a:	1101                	addi	sp,sp,-32
     d3c:	ec06                	sd	ra,24(sp)
     d3e:	e822                	sd	s0,16(sp)
     d40:	1000                	addi	s0,sp,32
  unlink("a");
     d42:	00001517          	auipc	a0,0x1
     d46:	72650513          	addi	a0,a0,1830 # 2468 <schedule_dm+0x32c>
     d4a:	00000097          	auipc	ra,0x0
     d4e:	654080e7          	jalr	1620(ra) # 139e <unlink>
  unlink("b");
     d52:	00001517          	auipc	a0,0x1
     d56:	6c650513          	addi	a0,a0,1734 # 2418 <schedule_dm+0x2dc>
     d5a:	00000097          	auipc	ra,0x0
     d5e:	644080e7          	jalr	1604(ra) # 139e <unlink>
  
  int pid1 = fork();
     d62:	00000097          	auipc	ra,0x0
     d66:	5e4080e7          	jalr	1508(ra) # 1346 <fork>
     d6a:	87aa                	mv	a5,a0
     d6c:	fef42623          	sw	a5,-20(s0)
  if(pid1 < 0){
     d70:	fec42783          	lw	a5,-20(s0)
     d74:	2781                	sext.w	a5,a5
     d76:	0007df63          	bgez	a5,d94 <iter+0x5a>
    printf("grind: fork failed\n");
     d7a:	00001517          	auipc	a0,0x1
     d7e:	6d650513          	addi	a0,a0,1750 # 2450 <schedule_dm+0x314>
     d82:	00001097          	auipc	ra,0x1
     d86:	b12080e7          	jalr	-1262(ra) # 1894 <printf>
    exit(1);
     d8a:	4505                	li	a0,1
     d8c:	00000097          	auipc	ra,0x0
     d90:	5c2080e7          	jalr	1474(ra) # 134e <exit>
  }
  if(pid1 == 0){
     d94:	fec42783          	lw	a5,-20(s0)
     d98:	2781                	sext.w	a5,a5
     d9a:	e38d                	bnez	a5,dbc <iter+0x82>
    rand_next = 31;
     d9c:	00002797          	auipc	a5,0x2
     da0:	8ec78793          	addi	a5,a5,-1812 # 2688 <rand_next>
     da4:	477d                	li	a4,31
     da6:	e398                	sd	a4,0(a5)
    go(0);
     da8:	4501                	li	a0,0
     daa:	fffff097          	auipc	ra,0xfffff
     dae:	31e080e7          	jalr	798(ra) # c8 <go>
    exit(0);
     db2:	4501                	li	a0,0
     db4:	00000097          	auipc	ra,0x0
     db8:	59a080e7          	jalr	1434(ra) # 134e <exit>
  }

  int pid2 = fork();
     dbc:	00000097          	auipc	ra,0x0
     dc0:	58a080e7          	jalr	1418(ra) # 1346 <fork>
     dc4:	87aa                	mv	a5,a0
     dc6:	fef42423          	sw	a5,-24(s0)
  if(pid2 < 0){
     dca:	fe842783          	lw	a5,-24(s0)
     dce:	2781                	sext.w	a5,a5
     dd0:	0007df63          	bgez	a5,dee <iter+0xb4>
    printf("grind: fork failed\n");
     dd4:	00001517          	auipc	a0,0x1
     dd8:	67c50513          	addi	a0,a0,1660 # 2450 <schedule_dm+0x314>
     ddc:	00001097          	auipc	ra,0x1
     de0:	ab8080e7          	jalr	-1352(ra) # 1894 <printf>
    exit(1);
     de4:	4505                	li	a0,1
     de6:	00000097          	auipc	ra,0x0
     dea:	568080e7          	jalr	1384(ra) # 134e <exit>
  }
  if(pid2 == 0){
     dee:	fe842783          	lw	a5,-24(s0)
     df2:	2781                	sext.w	a5,a5
     df4:	e39d                	bnez	a5,e1a <iter+0xe0>
    rand_next = 7177;
     df6:	00002797          	auipc	a5,0x2
     dfa:	89278793          	addi	a5,a5,-1902 # 2688 <rand_next>
     dfe:	6709                	lui	a4,0x2
     e00:	c0970713          	addi	a4,a4,-1015 # 1c09 <longjmp+0xd>
     e04:	e398                	sd	a4,0(a5)
    go(1);
     e06:	4505                	li	a0,1
     e08:	fffff097          	auipc	ra,0xfffff
     e0c:	2c0080e7          	jalr	704(ra) # c8 <go>
    exit(0);
     e10:	4501                	li	a0,0
     e12:	00000097          	auipc	ra,0x0
     e16:	53c080e7          	jalr	1340(ra) # 134e <exit>
  }

  int st1 = -1;
     e1a:	57fd                	li	a5,-1
     e1c:	fef42223          	sw	a5,-28(s0)
  wait(&st1);
     e20:	fe440793          	addi	a5,s0,-28
     e24:	853e                	mv	a0,a5
     e26:	00000097          	auipc	ra,0x0
     e2a:	530080e7          	jalr	1328(ra) # 1356 <wait>
  if(st1 != 0){
     e2e:	fe442783          	lw	a5,-28(s0)
     e32:	cf99                	beqz	a5,e50 <iter+0x116>
    kill(pid1);
     e34:	fec42783          	lw	a5,-20(s0)
     e38:	853e                	mv	a0,a5
     e3a:	00000097          	auipc	ra,0x0
     e3e:	544080e7          	jalr	1348(ra) # 137e <kill>
    kill(pid2);
     e42:	fe842783          	lw	a5,-24(s0)
     e46:	853e                	mv	a0,a5
     e48:	00000097          	auipc	ra,0x0
     e4c:	536080e7          	jalr	1334(ra) # 137e <kill>
  }
  int st2 = -1;
     e50:	57fd                	li	a5,-1
     e52:	fef42023          	sw	a5,-32(s0)
  wait(&st2);
     e56:	fe040793          	addi	a5,s0,-32
     e5a:	853e                	mv	a0,a5
     e5c:	00000097          	auipc	ra,0x0
     e60:	4fa080e7          	jalr	1274(ra) # 1356 <wait>

  exit(0);
     e64:	4501                	li	a0,0
     e66:	00000097          	auipc	ra,0x0
     e6a:	4e8080e7          	jalr	1256(ra) # 134e <exit>

0000000000000e6e <main>:
}

int
main()
{
     e6e:	1101                	addi	sp,sp,-32
     e70:	ec06                	sd	ra,24(sp)
     e72:	e822                	sd	s0,16(sp)
     e74:	1000                	addi	s0,sp,32
  while(1){
    int pid = fork();
     e76:	00000097          	auipc	ra,0x0
     e7a:	4d0080e7          	jalr	1232(ra) # 1346 <fork>
     e7e:	87aa                	mv	a5,a0
     e80:	fef42623          	sw	a5,-20(s0)
    if(pid == 0){
     e84:	fec42783          	lw	a5,-20(s0)
     e88:	2781                	sext.w	a5,a5
     e8a:	eb91                	bnez	a5,e9e <main+0x30>
      iter();
     e8c:	00000097          	auipc	ra,0x0
     e90:	eae080e7          	jalr	-338(ra) # d3a <iter>
      exit(0);
     e94:	4501                	li	a0,0
     e96:	00000097          	auipc	ra,0x0
     e9a:	4b8080e7          	jalr	1208(ra) # 134e <exit>
    }
    if(pid > 0){
     e9e:	fec42783          	lw	a5,-20(s0)
     ea2:	2781                	sext.w	a5,a5
     ea4:	00f05763          	blez	a5,eb2 <main+0x44>
      wait(0);
     ea8:	4501                	li	a0,0
     eaa:	00000097          	auipc	ra,0x0
     eae:	4ac080e7          	jalr	1196(ra) # 1356 <wait>
    }
    sleep(20);
     eb2:	4551                	li	a0,20
     eb4:	00000097          	auipc	ra,0x0
     eb8:	52a080e7          	jalr	1322(ra) # 13de <sleep>
  while(1){
     ebc:	bf6d                	j	e76 <main+0x8>

0000000000000ebe <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     ebe:	7179                	addi	sp,sp,-48
     ec0:	f422                	sd	s0,40(sp)
     ec2:	1800                	addi	s0,sp,48
     ec4:	fca43c23          	sd	a0,-40(s0)
     ec8:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     ecc:	fd843783          	ld	a5,-40(s0)
     ed0:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     ed4:	0001                	nop
     ed6:	fd043703          	ld	a4,-48(s0)
     eda:	00170793          	addi	a5,a4,1
     ede:	fcf43823          	sd	a5,-48(s0)
     ee2:	fd843783          	ld	a5,-40(s0)
     ee6:	00178693          	addi	a3,a5,1
     eea:	fcd43c23          	sd	a3,-40(s0)
     eee:	00074703          	lbu	a4,0(a4)
     ef2:	00e78023          	sb	a4,0(a5)
     ef6:	0007c783          	lbu	a5,0(a5)
     efa:	fff1                	bnez	a5,ed6 <strcpy+0x18>
    ;
  return os;
     efc:	fe843783          	ld	a5,-24(s0)
}
     f00:	853e                	mv	a0,a5
     f02:	7422                	ld	s0,40(sp)
     f04:	6145                	addi	sp,sp,48
     f06:	8082                	ret

0000000000000f08 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     f08:	1101                	addi	sp,sp,-32
     f0a:	ec22                	sd	s0,24(sp)
     f0c:	1000                	addi	s0,sp,32
     f0e:	fea43423          	sd	a0,-24(s0)
     f12:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     f16:	a819                	j	f2c <strcmp+0x24>
    p++, q++;
     f18:	fe843783          	ld	a5,-24(s0)
     f1c:	0785                	addi	a5,a5,1
     f1e:	fef43423          	sd	a5,-24(s0)
     f22:	fe043783          	ld	a5,-32(s0)
     f26:	0785                	addi	a5,a5,1
     f28:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     f2c:	fe843783          	ld	a5,-24(s0)
     f30:	0007c783          	lbu	a5,0(a5)
     f34:	cb99                	beqz	a5,f4a <strcmp+0x42>
     f36:	fe843783          	ld	a5,-24(s0)
     f3a:	0007c703          	lbu	a4,0(a5)
     f3e:	fe043783          	ld	a5,-32(s0)
     f42:	0007c783          	lbu	a5,0(a5)
     f46:	fcf709e3          	beq	a4,a5,f18 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     f4a:	fe843783          	ld	a5,-24(s0)
     f4e:	0007c783          	lbu	a5,0(a5)
     f52:	0007871b          	sext.w	a4,a5
     f56:	fe043783          	ld	a5,-32(s0)
     f5a:	0007c783          	lbu	a5,0(a5)
     f5e:	2781                	sext.w	a5,a5
     f60:	40f707bb          	subw	a5,a4,a5
     f64:	2781                	sext.w	a5,a5
}
     f66:	853e                	mv	a0,a5
     f68:	6462                	ld	s0,24(sp)
     f6a:	6105                	addi	sp,sp,32
     f6c:	8082                	ret

0000000000000f6e <strlen>:

uint
strlen(const char *s)
{
     f6e:	7179                	addi	sp,sp,-48
     f70:	f422                	sd	s0,40(sp)
     f72:	1800                	addi	s0,sp,48
     f74:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     f78:	fe042623          	sw	zero,-20(s0)
     f7c:	a031                	j	f88 <strlen+0x1a>
     f7e:	fec42783          	lw	a5,-20(s0)
     f82:	2785                	addiw	a5,a5,1
     f84:	fef42623          	sw	a5,-20(s0)
     f88:	fec42783          	lw	a5,-20(s0)
     f8c:	fd843703          	ld	a4,-40(s0)
     f90:	97ba                	add	a5,a5,a4
     f92:	0007c783          	lbu	a5,0(a5)
     f96:	f7e5                	bnez	a5,f7e <strlen+0x10>
    ;
  return n;
     f98:	fec42783          	lw	a5,-20(s0)
}
     f9c:	853e                	mv	a0,a5
     f9e:	7422                	ld	s0,40(sp)
     fa0:	6145                	addi	sp,sp,48
     fa2:	8082                	ret

0000000000000fa4 <memset>:

void*
memset(void *dst, int c, uint n)
{
     fa4:	7179                	addi	sp,sp,-48
     fa6:	f422                	sd	s0,40(sp)
     fa8:	1800                	addi	s0,sp,48
     faa:	fca43c23          	sd	a0,-40(s0)
     fae:	87ae                	mv	a5,a1
     fb0:	8732                	mv	a4,a2
     fb2:	fcf42a23          	sw	a5,-44(s0)
     fb6:	87ba                	mv	a5,a4
     fb8:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     fbc:	fd843783          	ld	a5,-40(s0)
     fc0:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     fc4:	fe042623          	sw	zero,-20(s0)
     fc8:	a00d                	j	fea <memset+0x46>
    cdst[i] = c;
     fca:	fec42783          	lw	a5,-20(s0)
     fce:	fe043703          	ld	a4,-32(s0)
     fd2:	97ba                	add	a5,a5,a4
     fd4:	fd442703          	lw	a4,-44(s0)
     fd8:	0ff77713          	andi	a4,a4,255
     fdc:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     fe0:	fec42783          	lw	a5,-20(s0)
     fe4:	2785                	addiw	a5,a5,1
     fe6:	fef42623          	sw	a5,-20(s0)
     fea:	fec42703          	lw	a4,-20(s0)
     fee:	fd042783          	lw	a5,-48(s0)
     ff2:	2781                	sext.w	a5,a5
     ff4:	fcf76be3          	bltu	a4,a5,fca <memset+0x26>
  }
  return dst;
     ff8:	fd843783          	ld	a5,-40(s0)
}
     ffc:	853e                	mv	a0,a5
     ffe:	7422                	ld	s0,40(sp)
    1000:	6145                	addi	sp,sp,48
    1002:	8082                	ret

0000000000001004 <strchr>:

char*
strchr(const char *s, char c)
{
    1004:	1101                	addi	sp,sp,-32
    1006:	ec22                	sd	s0,24(sp)
    1008:	1000                	addi	s0,sp,32
    100a:	fea43423          	sd	a0,-24(s0)
    100e:	87ae                	mv	a5,a1
    1010:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
    1014:	a01d                	j	103a <strchr+0x36>
    if(*s == c)
    1016:	fe843783          	ld	a5,-24(s0)
    101a:	0007c703          	lbu	a4,0(a5)
    101e:	fe744783          	lbu	a5,-25(s0)
    1022:	0ff7f793          	andi	a5,a5,255
    1026:	00e79563          	bne	a5,a4,1030 <strchr+0x2c>
      return (char*)s;
    102a:	fe843783          	ld	a5,-24(s0)
    102e:	a821                	j	1046 <strchr+0x42>
  for(; *s; s++)
    1030:	fe843783          	ld	a5,-24(s0)
    1034:	0785                	addi	a5,a5,1
    1036:	fef43423          	sd	a5,-24(s0)
    103a:	fe843783          	ld	a5,-24(s0)
    103e:	0007c783          	lbu	a5,0(a5)
    1042:	fbf1                	bnez	a5,1016 <strchr+0x12>
  return 0;
    1044:	4781                	li	a5,0
}
    1046:	853e                	mv	a0,a5
    1048:	6462                	ld	s0,24(sp)
    104a:	6105                	addi	sp,sp,32
    104c:	8082                	ret

000000000000104e <gets>:

char*
gets(char *buf, int max)
{
    104e:	7179                	addi	sp,sp,-48
    1050:	f406                	sd	ra,40(sp)
    1052:	f022                	sd	s0,32(sp)
    1054:	1800                	addi	s0,sp,48
    1056:	fca43c23          	sd	a0,-40(s0)
    105a:	87ae                	mv	a5,a1
    105c:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1060:	fe042623          	sw	zero,-20(s0)
    1064:	a8a1                	j	10bc <gets+0x6e>
    cc = read(0, &c, 1);
    1066:	fe740793          	addi	a5,s0,-25
    106a:	4605                	li	a2,1
    106c:	85be                	mv	a1,a5
    106e:	4501                	li	a0,0
    1070:	00000097          	auipc	ra,0x0
    1074:	2f6080e7          	jalr	758(ra) # 1366 <read>
    1078:	87aa                	mv	a5,a0
    107a:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
    107e:	fe842783          	lw	a5,-24(s0)
    1082:	2781                	sext.w	a5,a5
    1084:	04f05763          	blez	a5,10d2 <gets+0x84>
      break;
    buf[i++] = c;
    1088:	fec42783          	lw	a5,-20(s0)
    108c:	0017871b          	addiw	a4,a5,1
    1090:	fee42623          	sw	a4,-20(s0)
    1094:	873e                	mv	a4,a5
    1096:	fd843783          	ld	a5,-40(s0)
    109a:	97ba                	add	a5,a5,a4
    109c:	fe744703          	lbu	a4,-25(s0)
    10a0:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
    10a4:	fe744783          	lbu	a5,-25(s0)
    10a8:	873e                	mv	a4,a5
    10aa:	47a9                	li	a5,10
    10ac:	02f70463          	beq	a4,a5,10d4 <gets+0x86>
    10b0:	fe744783          	lbu	a5,-25(s0)
    10b4:	873e                	mv	a4,a5
    10b6:	47b5                	li	a5,13
    10b8:	00f70e63          	beq	a4,a5,10d4 <gets+0x86>
  for(i=0; i+1 < max; ){
    10bc:	fec42783          	lw	a5,-20(s0)
    10c0:	2785                	addiw	a5,a5,1
    10c2:	0007871b          	sext.w	a4,a5
    10c6:	fd442783          	lw	a5,-44(s0)
    10ca:	2781                	sext.w	a5,a5
    10cc:	f8f74de3          	blt	a4,a5,1066 <gets+0x18>
    10d0:	a011                	j	10d4 <gets+0x86>
      break;
    10d2:	0001                	nop
      break;
  }
  buf[i] = '\0';
    10d4:	fec42783          	lw	a5,-20(s0)
    10d8:	fd843703          	ld	a4,-40(s0)
    10dc:	97ba                	add	a5,a5,a4
    10de:	00078023          	sb	zero,0(a5)
  return buf;
    10e2:	fd843783          	ld	a5,-40(s0)
}
    10e6:	853e                	mv	a0,a5
    10e8:	70a2                	ld	ra,40(sp)
    10ea:	7402                	ld	s0,32(sp)
    10ec:	6145                	addi	sp,sp,48
    10ee:	8082                	ret

00000000000010f0 <stat>:

int
stat(const char *n, struct stat *st)
{
    10f0:	7179                	addi	sp,sp,-48
    10f2:	f406                	sd	ra,40(sp)
    10f4:	f022                	sd	s0,32(sp)
    10f6:	1800                	addi	s0,sp,48
    10f8:	fca43c23          	sd	a0,-40(s0)
    10fc:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1100:	4581                	li	a1,0
    1102:	fd843503          	ld	a0,-40(s0)
    1106:	00000097          	auipc	ra,0x0
    110a:	288080e7          	jalr	648(ra) # 138e <open>
    110e:	87aa                	mv	a5,a0
    1110:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
    1114:	fec42783          	lw	a5,-20(s0)
    1118:	2781                	sext.w	a5,a5
    111a:	0007d463          	bgez	a5,1122 <stat+0x32>
    return -1;
    111e:	57fd                	li	a5,-1
    1120:	a035                	j	114c <stat+0x5c>
  r = fstat(fd, st);
    1122:	fec42783          	lw	a5,-20(s0)
    1126:	fd043583          	ld	a1,-48(s0)
    112a:	853e                	mv	a0,a5
    112c:	00000097          	auipc	ra,0x0
    1130:	27a080e7          	jalr	634(ra) # 13a6 <fstat>
    1134:	87aa                	mv	a5,a0
    1136:	fef42423          	sw	a5,-24(s0)
  close(fd);
    113a:	fec42783          	lw	a5,-20(s0)
    113e:	853e                	mv	a0,a5
    1140:	00000097          	auipc	ra,0x0
    1144:	236080e7          	jalr	566(ra) # 1376 <close>
  return r;
    1148:	fe842783          	lw	a5,-24(s0)
}
    114c:	853e                	mv	a0,a5
    114e:	70a2                	ld	ra,40(sp)
    1150:	7402                	ld	s0,32(sp)
    1152:	6145                	addi	sp,sp,48
    1154:	8082                	ret

0000000000001156 <atoi>:

int
atoi(const char *s)
{
    1156:	7179                	addi	sp,sp,-48
    1158:	f422                	sd	s0,40(sp)
    115a:	1800                	addi	s0,sp,48
    115c:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
    1160:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
    1164:	a815                	j	1198 <atoi+0x42>
    n = n*10 + *s++ - '0';
    1166:	fec42703          	lw	a4,-20(s0)
    116a:	87ba                	mv	a5,a4
    116c:	0027979b          	slliw	a5,a5,0x2
    1170:	9fb9                	addw	a5,a5,a4
    1172:	0017979b          	slliw	a5,a5,0x1
    1176:	0007871b          	sext.w	a4,a5
    117a:	fd843783          	ld	a5,-40(s0)
    117e:	00178693          	addi	a3,a5,1
    1182:	fcd43c23          	sd	a3,-40(s0)
    1186:	0007c783          	lbu	a5,0(a5)
    118a:	2781                	sext.w	a5,a5
    118c:	9fb9                	addw	a5,a5,a4
    118e:	2781                	sext.w	a5,a5
    1190:	fd07879b          	addiw	a5,a5,-48
    1194:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
    1198:	fd843783          	ld	a5,-40(s0)
    119c:	0007c783          	lbu	a5,0(a5)
    11a0:	873e                	mv	a4,a5
    11a2:	02f00793          	li	a5,47
    11a6:	00e7fb63          	bgeu	a5,a4,11bc <atoi+0x66>
    11aa:	fd843783          	ld	a5,-40(s0)
    11ae:	0007c783          	lbu	a5,0(a5)
    11b2:	873e                	mv	a4,a5
    11b4:	03900793          	li	a5,57
    11b8:	fae7f7e3          	bgeu	a5,a4,1166 <atoi+0x10>
  return n;
    11bc:	fec42783          	lw	a5,-20(s0)
}
    11c0:	853e                	mv	a0,a5
    11c2:	7422                	ld	s0,40(sp)
    11c4:	6145                	addi	sp,sp,48
    11c6:	8082                	ret

00000000000011c8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    11c8:	7139                	addi	sp,sp,-64
    11ca:	fc22                	sd	s0,56(sp)
    11cc:	0080                	addi	s0,sp,64
    11ce:	fca43c23          	sd	a0,-40(s0)
    11d2:	fcb43823          	sd	a1,-48(s0)
    11d6:	87b2                	mv	a5,a2
    11d8:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
    11dc:	fd843783          	ld	a5,-40(s0)
    11e0:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
    11e4:	fd043783          	ld	a5,-48(s0)
    11e8:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
    11ec:	fe043703          	ld	a4,-32(s0)
    11f0:	fe843783          	ld	a5,-24(s0)
    11f4:	02e7fc63          	bgeu	a5,a4,122c <memmove+0x64>
    while(n-- > 0)
    11f8:	a00d                	j	121a <memmove+0x52>
      *dst++ = *src++;
    11fa:	fe043703          	ld	a4,-32(s0)
    11fe:	00170793          	addi	a5,a4,1
    1202:	fef43023          	sd	a5,-32(s0)
    1206:	fe843783          	ld	a5,-24(s0)
    120a:	00178693          	addi	a3,a5,1
    120e:	fed43423          	sd	a3,-24(s0)
    1212:	00074703          	lbu	a4,0(a4)
    1216:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    121a:	fcc42783          	lw	a5,-52(s0)
    121e:	fff7871b          	addiw	a4,a5,-1
    1222:	fce42623          	sw	a4,-52(s0)
    1226:	fcf04ae3          	bgtz	a5,11fa <memmove+0x32>
    122a:	a891                	j	127e <memmove+0xb6>
  } else {
    dst += n;
    122c:	fcc42783          	lw	a5,-52(s0)
    1230:	fe843703          	ld	a4,-24(s0)
    1234:	97ba                	add	a5,a5,a4
    1236:	fef43423          	sd	a5,-24(s0)
    src += n;
    123a:	fcc42783          	lw	a5,-52(s0)
    123e:	fe043703          	ld	a4,-32(s0)
    1242:	97ba                	add	a5,a5,a4
    1244:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
    1248:	a01d                	j	126e <memmove+0xa6>
      *--dst = *--src;
    124a:	fe043783          	ld	a5,-32(s0)
    124e:	17fd                	addi	a5,a5,-1
    1250:	fef43023          	sd	a5,-32(s0)
    1254:	fe843783          	ld	a5,-24(s0)
    1258:	17fd                	addi	a5,a5,-1
    125a:	fef43423          	sd	a5,-24(s0)
    125e:	fe043783          	ld	a5,-32(s0)
    1262:	0007c703          	lbu	a4,0(a5)
    1266:	fe843783          	ld	a5,-24(s0)
    126a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    126e:	fcc42783          	lw	a5,-52(s0)
    1272:	fff7871b          	addiw	a4,a5,-1
    1276:	fce42623          	sw	a4,-52(s0)
    127a:	fcf048e3          	bgtz	a5,124a <memmove+0x82>
  }
  return vdst;
    127e:	fd843783          	ld	a5,-40(s0)
}
    1282:	853e                	mv	a0,a5
    1284:	7462                	ld	s0,56(sp)
    1286:	6121                	addi	sp,sp,64
    1288:	8082                	ret

000000000000128a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    128a:	7139                	addi	sp,sp,-64
    128c:	fc22                	sd	s0,56(sp)
    128e:	0080                	addi	s0,sp,64
    1290:	fca43c23          	sd	a0,-40(s0)
    1294:	fcb43823          	sd	a1,-48(s0)
    1298:	87b2                	mv	a5,a2
    129a:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
    129e:	fd843783          	ld	a5,-40(s0)
    12a2:	fef43423          	sd	a5,-24(s0)
    12a6:	fd043783          	ld	a5,-48(s0)
    12aa:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    12ae:	a0a1                	j	12f6 <memcmp+0x6c>
    if (*p1 != *p2) {
    12b0:	fe843783          	ld	a5,-24(s0)
    12b4:	0007c703          	lbu	a4,0(a5)
    12b8:	fe043783          	ld	a5,-32(s0)
    12bc:	0007c783          	lbu	a5,0(a5)
    12c0:	02f70163          	beq	a4,a5,12e2 <memcmp+0x58>
      return *p1 - *p2;
    12c4:	fe843783          	ld	a5,-24(s0)
    12c8:	0007c783          	lbu	a5,0(a5)
    12cc:	0007871b          	sext.w	a4,a5
    12d0:	fe043783          	ld	a5,-32(s0)
    12d4:	0007c783          	lbu	a5,0(a5)
    12d8:	2781                	sext.w	a5,a5
    12da:	40f707bb          	subw	a5,a4,a5
    12de:	2781                	sext.w	a5,a5
    12e0:	a01d                	j	1306 <memcmp+0x7c>
    }
    p1++;
    12e2:	fe843783          	ld	a5,-24(s0)
    12e6:	0785                	addi	a5,a5,1
    12e8:	fef43423          	sd	a5,-24(s0)
    p2++;
    12ec:	fe043783          	ld	a5,-32(s0)
    12f0:	0785                	addi	a5,a5,1
    12f2:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
    12f6:	fcc42783          	lw	a5,-52(s0)
    12fa:	fff7871b          	addiw	a4,a5,-1
    12fe:	fce42623          	sw	a4,-52(s0)
    1302:	f7dd                	bnez	a5,12b0 <memcmp+0x26>
  }
  return 0;
    1304:	4781                	li	a5,0
}
    1306:	853e                	mv	a0,a5
    1308:	7462                	ld	s0,56(sp)
    130a:	6121                	addi	sp,sp,64
    130c:	8082                	ret

000000000000130e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    130e:	7179                	addi	sp,sp,-48
    1310:	f406                	sd	ra,40(sp)
    1312:	f022                	sd	s0,32(sp)
    1314:	1800                	addi	s0,sp,48
    1316:	fea43423          	sd	a0,-24(s0)
    131a:	feb43023          	sd	a1,-32(s0)
    131e:	87b2                	mv	a5,a2
    1320:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
    1324:	fdc42783          	lw	a5,-36(s0)
    1328:	863e                	mv	a2,a5
    132a:	fe043583          	ld	a1,-32(s0)
    132e:	fe843503          	ld	a0,-24(s0)
    1332:	00000097          	auipc	ra,0x0
    1336:	e96080e7          	jalr	-362(ra) # 11c8 <memmove>
    133a:	87aa                	mv	a5,a0
}
    133c:	853e                	mv	a0,a5
    133e:	70a2                	ld	ra,40(sp)
    1340:	7402                	ld	s0,32(sp)
    1342:	6145                	addi	sp,sp,48
    1344:	8082                	ret

0000000000001346 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    1346:	4885                	li	a7,1
 ecall
    1348:	00000073          	ecall
 ret
    134c:	8082                	ret

000000000000134e <exit>:
.global exit
exit:
 li a7, SYS_exit
    134e:	4889                	li	a7,2
 ecall
    1350:	00000073          	ecall
 ret
    1354:	8082                	ret

0000000000001356 <wait>:
.global wait
wait:
 li a7, SYS_wait
    1356:	488d                	li	a7,3
 ecall
    1358:	00000073          	ecall
 ret
    135c:	8082                	ret

000000000000135e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    135e:	4891                	li	a7,4
 ecall
    1360:	00000073          	ecall
 ret
    1364:	8082                	ret

0000000000001366 <read>:
.global read
read:
 li a7, SYS_read
    1366:	4895                	li	a7,5
 ecall
    1368:	00000073          	ecall
 ret
    136c:	8082                	ret

000000000000136e <write>:
.global write
write:
 li a7, SYS_write
    136e:	48c1                	li	a7,16
 ecall
    1370:	00000073          	ecall
 ret
    1374:	8082                	ret

0000000000001376 <close>:
.global close
close:
 li a7, SYS_close
    1376:	48d5                	li	a7,21
 ecall
    1378:	00000073          	ecall
 ret
    137c:	8082                	ret

000000000000137e <kill>:
.global kill
kill:
 li a7, SYS_kill
    137e:	4899                	li	a7,6
 ecall
    1380:	00000073          	ecall
 ret
    1384:	8082                	ret

0000000000001386 <exec>:
.global exec
exec:
 li a7, SYS_exec
    1386:	489d                	li	a7,7
 ecall
    1388:	00000073          	ecall
 ret
    138c:	8082                	ret

000000000000138e <open>:
.global open
open:
 li a7, SYS_open
    138e:	48bd                	li	a7,15
 ecall
    1390:	00000073          	ecall
 ret
    1394:	8082                	ret

0000000000001396 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    1396:	48c5                	li	a7,17
 ecall
    1398:	00000073          	ecall
 ret
    139c:	8082                	ret

000000000000139e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    139e:	48c9                	li	a7,18
 ecall
    13a0:	00000073          	ecall
 ret
    13a4:	8082                	ret

00000000000013a6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    13a6:	48a1                	li	a7,8
 ecall
    13a8:	00000073          	ecall
 ret
    13ac:	8082                	ret

00000000000013ae <link>:
.global link
link:
 li a7, SYS_link
    13ae:	48cd                	li	a7,19
 ecall
    13b0:	00000073          	ecall
 ret
    13b4:	8082                	ret

00000000000013b6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    13b6:	48d1                	li	a7,20
 ecall
    13b8:	00000073          	ecall
 ret
    13bc:	8082                	ret

00000000000013be <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    13be:	48a5                	li	a7,9
 ecall
    13c0:	00000073          	ecall
 ret
    13c4:	8082                	ret

00000000000013c6 <dup>:
.global dup
dup:
 li a7, SYS_dup
    13c6:	48a9                	li	a7,10
 ecall
    13c8:	00000073          	ecall
 ret
    13cc:	8082                	ret

00000000000013ce <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    13ce:	48ad                	li	a7,11
 ecall
    13d0:	00000073          	ecall
 ret
    13d4:	8082                	ret

00000000000013d6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    13d6:	48b1                	li	a7,12
 ecall
    13d8:	00000073          	ecall
 ret
    13dc:	8082                	ret

00000000000013de <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    13de:	48b5                	li	a7,13
 ecall
    13e0:	00000073          	ecall
 ret
    13e4:	8082                	ret

00000000000013e6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    13e6:	48b9                	li	a7,14
 ecall
    13e8:	00000073          	ecall
 ret
    13ec:	8082                	ret

00000000000013ee <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
    13ee:	48d9                	li	a7,22
 ecall
    13f0:	00000073          	ecall
 ret
    13f4:	8082                	ret

00000000000013f6 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
    13f6:	48dd                	li	a7,23
 ecall
    13f8:	00000073          	ecall
 ret
    13fc:	8082                	ret

00000000000013fe <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
    13fe:	48e1                	li	a7,24
 ecall
    1400:	00000073          	ecall
 ret
    1404:	8082                	ret

0000000000001406 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    1406:	1101                	addi	sp,sp,-32
    1408:	ec06                	sd	ra,24(sp)
    140a:	e822                	sd	s0,16(sp)
    140c:	1000                	addi	s0,sp,32
    140e:	87aa                	mv	a5,a0
    1410:	872e                	mv	a4,a1
    1412:	fef42623          	sw	a5,-20(s0)
    1416:	87ba                	mv	a5,a4
    1418:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
    141c:	feb40713          	addi	a4,s0,-21
    1420:	fec42783          	lw	a5,-20(s0)
    1424:	4605                	li	a2,1
    1426:	85ba                	mv	a1,a4
    1428:	853e                	mv	a0,a5
    142a:	00000097          	auipc	ra,0x0
    142e:	f44080e7          	jalr	-188(ra) # 136e <write>
}
    1432:	0001                	nop
    1434:	60e2                	ld	ra,24(sp)
    1436:	6442                	ld	s0,16(sp)
    1438:	6105                	addi	sp,sp,32
    143a:	8082                	ret

000000000000143c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    143c:	7139                	addi	sp,sp,-64
    143e:	fc06                	sd	ra,56(sp)
    1440:	f822                	sd	s0,48(sp)
    1442:	0080                	addi	s0,sp,64
    1444:	87aa                	mv	a5,a0
    1446:	8736                	mv	a4,a3
    1448:	fcf42623          	sw	a5,-52(s0)
    144c:	87ae                	mv	a5,a1
    144e:	fcf42423          	sw	a5,-56(s0)
    1452:	87b2                	mv	a5,a2
    1454:	fcf42223          	sw	a5,-60(s0)
    1458:	87ba                	mv	a5,a4
    145a:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    145e:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
    1462:	fc042783          	lw	a5,-64(s0)
    1466:	2781                	sext.w	a5,a5
    1468:	c38d                	beqz	a5,148a <printint+0x4e>
    146a:	fc842783          	lw	a5,-56(s0)
    146e:	2781                	sext.w	a5,a5
    1470:	0007dd63          	bgez	a5,148a <printint+0x4e>
    neg = 1;
    1474:	4785                	li	a5,1
    1476:	fef42423          	sw	a5,-24(s0)
    x = -xx;
    147a:	fc842783          	lw	a5,-56(s0)
    147e:	40f007bb          	negw	a5,a5
    1482:	2781                	sext.w	a5,a5
    1484:	fef42223          	sw	a5,-28(s0)
    1488:	a029                	j	1492 <printint+0x56>
  } else {
    x = xx;
    148a:	fc842783          	lw	a5,-56(s0)
    148e:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
    1492:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
    1496:	fc442783          	lw	a5,-60(s0)
    149a:	fe442703          	lw	a4,-28(s0)
    149e:	02f777bb          	remuw	a5,a4,a5
    14a2:	0007861b          	sext.w	a2,a5
    14a6:	fec42783          	lw	a5,-20(s0)
    14aa:	0017871b          	addiw	a4,a5,1
    14ae:	fee42623          	sw	a4,-20(s0)
    14b2:	00001697          	auipc	a3,0x1
    14b6:	1be68693          	addi	a3,a3,446 # 2670 <digits>
    14ba:	02061713          	slli	a4,a2,0x20
    14be:	9301                	srli	a4,a4,0x20
    14c0:	9736                	add	a4,a4,a3
    14c2:	00074703          	lbu	a4,0(a4)
    14c6:	ff040693          	addi	a3,s0,-16
    14ca:	97b6                	add	a5,a5,a3
    14cc:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
    14d0:	fc442783          	lw	a5,-60(s0)
    14d4:	fe442703          	lw	a4,-28(s0)
    14d8:	02f757bb          	divuw	a5,a4,a5
    14dc:	fef42223          	sw	a5,-28(s0)
    14e0:	fe442783          	lw	a5,-28(s0)
    14e4:	2781                	sext.w	a5,a5
    14e6:	fbc5                	bnez	a5,1496 <printint+0x5a>
  if(neg)
    14e8:	fe842783          	lw	a5,-24(s0)
    14ec:	2781                	sext.w	a5,a5
    14ee:	cf95                	beqz	a5,152a <printint+0xee>
    buf[i++] = '-';
    14f0:	fec42783          	lw	a5,-20(s0)
    14f4:	0017871b          	addiw	a4,a5,1
    14f8:	fee42623          	sw	a4,-20(s0)
    14fc:	ff040713          	addi	a4,s0,-16
    1500:	97ba                	add	a5,a5,a4
    1502:	02d00713          	li	a4,45
    1506:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
    150a:	a005                	j	152a <printint+0xee>
    putc(fd, buf[i]);
    150c:	fec42783          	lw	a5,-20(s0)
    1510:	ff040713          	addi	a4,s0,-16
    1514:	97ba                	add	a5,a5,a4
    1516:	fe07c703          	lbu	a4,-32(a5)
    151a:	fcc42783          	lw	a5,-52(s0)
    151e:	85ba                	mv	a1,a4
    1520:	853e                	mv	a0,a5
    1522:	00000097          	auipc	ra,0x0
    1526:	ee4080e7          	jalr	-284(ra) # 1406 <putc>
  while(--i >= 0)
    152a:	fec42783          	lw	a5,-20(s0)
    152e:	37fd                	addiw	a5,a5,-1
    1530:	fef42623          	sw	a5,-20(s0)
    1534:	fec42783          	lw	a5,-20(s0)
    1538:	2781                	sext.w	a5,a5
    153a:	fc07d9e3          	bgez	a5,150c <printint+0xd0>
}
    153e:	0001                	nop
    1540:	0001                	nop
    1542:	70e2                	ld	ra,56(sp)
    1544:	7442                	ld	s0,48(sp)
    1546:	6121                	addi	sp,sp,64
    1548:	8082                	ret

000000000000154a <printptr>:

static void
printptr(int fd, uint64 x) {
    154a:	7179                	addi	sp,sp,-48
    154c:	f406                	sd	ra,40(sp)
    154e:	f022                	sd	s0,32(sp)
    1550:	1800                	addi	s0,sp,48
    1552:	87aa                	mv	a5,a0
    1554:	fcb43823          	sd	a1,-48(s0)
    1558:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
    155c:	fdc42783          	lw	a5,-36(s0)
    1560:	03000593          	li	a1,48
    1564:	853e                	mv	a0,a5
    1566:	00000097          	auipc	ra,0x0
    156a:	ea0080e7          	jalr	-352(ra) # 1406 <putc>
  putc(fd, 'x');
    156e:	fdc42783          	lw	a5,-36(s0)
    1572:	07800593          	li	a1,120
    1576:	853e                	mv	a0,a5
    1578:	00000097          	auipc	ra,0x0
    157c:	e8e080e7          	jalr	-370(ra) # 1406 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1580:	fe042623          	sw	zero,-20(s0)
    1584:	a82d                	j	15be <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1586:	fd043783          	ld	a5,-48(s0)
    158a:	93f1                	srli	a5,a5,0x3c
    158c:	00001717          	auipc	a4,0x1
    1590:	0e470713          	addi	a4,a4,228 # 2670 <digits>
    1594:	97ba                	add	a5,a5,a4
    1596:	0007c703          	lbu	a4,0(a5)
    159a:	fdc42783          	lw	a5,-36(s0)
    159e:	85ba                	mv	a1,a4
    15a0:	853e                	mv	a0,a5
    15a2:	00000097          	auipc	ra,0x0
    15a6:	e64080e7          	jalr	-412(ra) # 1406 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    15aa:	fec42783          	lw	a5,-20(s0)
    15ae:	2785                	addiw	a5,a5,1
    15b0:	fef42623          	sw	a5,-20(s0)
    15b4:	fd043783          	ld	a5,-48(s0)
    15b8:	0792                	slli	a5,a5,0x4
    15ba:	fcf43823          	sd	a5,-48(s0)
    15be:	fec42783          	lw	a5,-20(s0)
    15c2:	873e                	mv	a4,a5
    15c4:	47bd                	li	a5,15
    15c6:	fce7f0e3          	bgeu	a5,a4,1586 <printptr+0x3c>
}
    15ca:	0001                	nop
    15cc:	0001                	nop
    15ce:	70a2                	ld	ra,40(sp)
    15d0:	7402                	ld	s0,32(sp)
    15d2:	6145                	addi	sp,sp,48
    15d4:	8082                	ret

00000000000015d6 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    15d6:	715d                	addi	sp,sp,-80
    15d8:	e486                	sd	ra,72(sp)
    15da:	e0a2                	sd	s0,64(sp)
    15dc:	0880                	addi	s0,sp,80
    15de:	87aa                	mv	a5,a0
    15e0:	fcb43023          	sd	a1,-64(s0)
    15e4:	fac43c23          	sd	a2,-72(s0)
    15e8:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
    15ec:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    15f0:	fe042223          	sw	zero,-28(s0)
    15f4:	a42d                	j	181e <vprintf+0x248>
    c = fmt[i] & 0xff;
    15f6:	fe442783          	lw	a5,-28(s0)
    15fa:	fc043703          	ld	a4,-64(s0)
    15fe:	97ba                	add	a5,a5,a4
    1600:	0007c783          	lbu	a5,0(a5)
    1604:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
    1608:	fe042783          	lw	a5,-32(s0)
    160c:	2781                	sext.w	a5,a5
    160e:	eb9d                	bnez	a5,1644 <vprintf+0x6e>
      if(c == '%'){
    1610:	fdc42783          	lw	a5,-36(s0)
    1614:	0007871b          	sext.w	a4,a5
    1618:	02500793          	li	a5,37
    161c:	00f71763          	bne	a4,a5,162a <vprintf+0x54>
        state = '%';
    1620:	02500793          	li	a5,37
    1624:	fef42023          	sw	a5,-32(s0)
    1628:	a2f5                	j	1814 <vprintf+0x23e>
      } else {
        putc(fd, c);
    162a:	fdc42783          	lw	a5,-36(s0)
    162e:	0ff7f713          	andi	a4,a5,255
    1632:	fcc42783          	lw	a5,-52(s0)
    1636:	85ba                	mv	a1,a4
    1638:	853e                	mv	a0,a5
    163a:	00000097          	auipc	ra,0x0
    163e:	dcc080e7          	jalr	-564(ra) # 1406 <putc>
    1642:	aac9                	j	1814 <vprintf+0x23e>
      }
    } else if(state == '%'){
    1644:	fe042783          	lw	a5,-32(s0)
    1648:	0007871b          	sext.w	a4,a5
    164c:	02500793          	li	a5,37
    1650:	1cf71263          	bne	a4,a5,1814 <vprintf+0x23e>
      if(c == 'd'){
    1654:	fdc42783          	lw	a5,-36(s0)
    1658:	0007871b          	sext.w	a4,a5
    165c:	06400793          	li	a5,100
    1660:	02f71463          	bne	a4,a5,1688 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
    1664:	fb843783          	ld	a5,-72(s0)
    1668:	00878713          	addi	a4,a5,8
    166c:	fae43c23          	sd	a4,-72(s0)
    1670:	4398                	lw	a4,0(a5)
    1672:	fcc42783          	lw	a5,-52(s0)
    1676:	4685                	li	a3,1
    1678:	4629                	li	a2,10
    167a:	85ba                	mv	a1,a4
    167c:	853e                	mv	a0,a5
    167e:	00000097          	auipc	ra,0x0
    1682:	dbe080e7          	jalr	-578(ra) # 143c <printint>
    1686:	a269                	j	1810 <vprintf+0x23a>
      } else if(c == 'l') {
    1688:	fdc42783          	lw	a5,-36(s0)
    168c:	0007871b          	sext.w	a4,a5
    1690:	06c00793          	li	a5,108
    1694:	02f71663          	bne	a4,a5,16c0 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1698:	fb843783          	ld	a5,-72(s0)
    169c:	00878713          	addi	a4,a5,8
    16a0:	fae43c23          	sd	a4,-72(s0)
    16a4:	639c                	ld	a5,0(a5)
    16a6:	0007871b          	sext.w	a4,a5
    16aa:	fcc42783          	lw	a5,-52(s0)
    16ae:	4681                	li	a3,0
    16b0:	4629                	li	a2,10
    16b2:	85ba                	mv	a1,a4
    16b4:	853e                	mv	a0,a5
    16b6:	00000097          	auipc	ra,0x0
    16ba:	d86080e7          	jalr	-634(ra) # 143c <printint>
    16be:	aa89                	j	1810 <vprintf+0x23a>
      } else if(c == 'x') {
    16c0:	fdc42783          	lw	a5,-36(s0)
    16c4:	0007871b          	sext.w	a4,a5
    16c8:	07800793          	li	a5,120
    16cc:	02f71463          	bne	a4,a5,16f4 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
    16d0:	fb843783          	ld	a5,-72(s0)
    16d4:	00878713          	addi	a4,a5,8
    16d8:	fae43c23          	sd	a4,-72(s0)
    16dc:	4398                	lw	a4,0(a5)
    16de:	fcc42783          	lw	a5,-52(s0)
    16e2:	4681                	li	a3,0
    16e4:	4641                	li	a2,16
    16e6:	85ba                	mv	a1,a4
    16e8:	853e                	mv	a0,a5
    16ea:	00000097          	auipc	ra,0x0
    16ee:	d52080e7          	jalr	-686(ra) # 143c <printint>
    16f2:	aa39                	j	1810 <vprintf+0x23a>
      } else if(c == 'p') {
    16f4:	fdc42783          	lw	a5,-36(s0)
    16f8:	0007871b          	sext.w	a4,a5
    16fc:	07000793          	li	a5,112
    1700:	02f71263          	bne	a4,a5,1724 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
    1704:	fb843783          	ld	a5,-72(s0)
    1708:	00878713          	addi	a4,a5,8
    170c:	fae43c23          	sd	a4,-72(s0)
    1710:	6398                	ld	a4,0(a5)
    1712:	fcc42783          	lw	a5,-52(s0)
    1716:	85ba                	mv	a1,a4
    1718:	853e                	mv	a0,a5
    171a:	00000097          	auipc	ra,0x0
    171e:	e30080e7          	jalr	-464(ra) # 154a <printptr>
    1722:	a0fd                	j	1810 <vprintf+0x23a>
      } else if(c == 's'){
    1724:	fdc42783          	lw	a5,-36(s0)
    1728:	0007871b          	sext.w	a4,a5
    172c:	07300793          	li	a5,115
    1730:	04f71c63          	bne	a4,a5,1788 <vprintf+0x1b2>
        s = va_arg(ap, char*);
    1734:	fb843783          	ld	a5,-72(s0)
    1738:	00878713          	addi	a4,a5,8
    173c:	fae43c23          	sd	a4,-72(s0)
    1740:	639c                	ld	a5,0(a5)
    1742:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
    1746:	fe843783          	ld	a5,-24(s0)
    174a:	eb8d                	bnez	a5,177c <vprintf+0x1a6>
          s = "(null)";
    174c:	00001797          	auipc	a5,0x1
    1750:	ef478793          	addi	a5,a5,-268 # 2640 <schedule_dm+0x504>
    1754:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    1758:	a015                	j	177c <vprintf+0x1a6>
          putc(fd, *s);
    175a:	fe843783          	ld	a5,-24(s0)
    175e:	0007c703          	lbu	a4,0(a5)
    1762:	fcc42783          	lw	a5,-52(s0)
    1766:	85ba                	mv	a1,a4
    1768:	853e                	mv	a0,a5
    176a:	00000097          	auipc	ra,0x0
    176e:	c9c080e7          	jalr	-868(ra) # 1406 <putc>
          s++;
    1772:	fe843783          	ld	a5,-24(s0)
    1776:	0785                	addi	a5,a5,1
    1778:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
    177c:	fe843783          	ld	a5,-24(s0)
    1780:	0007c783          	lbu	a5,0(a5)
    1784:	fbf9                	bnez	a5,175a <vprintf+0x184>
    1786:	a069                	j	1810 <vprintf+0x23a>
        }
      } else if(c == 'c'){
    1788:	fdc42783          	lw	a5,-36(s0)
    178c:	0007871b          	sext.w	a4,a5
    1790:	06300793          	li	a5,99
    1794:	02f71463          	bne	a4,a5,17bc <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
    1798:	fb843783          	ld	a5,-72(s0)
    179c:	00878713          	addi	a4,a5,8
    17a0:	fae43c23          	sd	a4,-72(s0)
    17a4:	439c                	lw	a5,0(a5)
    17a6:	0ff7f713          	andi	a4,a5,255
    17aa:	fcc42783          	lw	a5,-52(s0)
    17ae:	85ba                	mv	a1,a4
    17b0:	853e                	mv	a0,a5
    17b2:	00000097          	auipc	ra,0x0
    17b6:	c54080e7          	jalr	-940(ra) # 1406 <putc>
    17ba:	a899                	j	1810 <vprintf+0x23a>
      } else if(c == '%'){
    17bc:	fdc42783          	lw	a5,-36(s0)
    17c0:	0007871b          	sext.w	a4,a5
    17c4:	02500793          	li	a5,37
    17c8:	00f71f63          	bne	a4,a5,17e6 <vprintf+0x210>
        putc(fd, c);
    17cc:	fdc42783          	lw	a5,-36(s0)
    17d0:	0ff7f713          	andi	a4,a5,255
    17d4:	fcc42783          	lw	a5,-52(s0)
    17d8:	85ba                	mv	a1,a4
    17da:	853e                	mv	a0,a5
    17dc:	00000097          	auipc	ra,0x0
    17e0:	c2a080e7          	jalr	-982(ra) # 1406 <putc>
    17e4:	a035                	j	1810 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    17e6:	fcc42783          	lw	a5,-52(s0)
    17ea:	02500593          	li	a1,37
    17ee:	853e                	mv	a0,a5
    17f0:	00000097          	auipc	ra,0x0
    17f4:	c16080e7          	jalr	-1002(ra) # 1406 <putc>
        putc(fd, c);
    17f8:	fdc42783          	lw	a5,-36(s0)
    17fc:	0ff7f713          	andi	a4,a5,255
    1800:	fcc42783          	lw	a5,-52(s0)
    1804:	85ba                	mv	a1,a4
    1806:	853e                	mv	a0,a5
    1808:	00000097          	auipc	ra,0x0
    180c:	bfe080e7          	jalr	-1026(ra) # 1406 <putc>
      }
      state = 0;
    1810:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
    1814:	fe442783          	lw	a5,-28(s0)
    1818:	2785                	addiw	a5,a5,1
    181a:	fef42223          	sw	a5,-28(s0)
    181e:	fe442783          	lw	a5,-28(s0)
    1822:	fc043703          	ld	a4,-64(s0)
    1826:	97ba                	add	a5,a5,a4
    1828:	0007c783          	lbu	a5,0(a5)
    182c:	dc0795e3          	bnez	a5,15f6 <vprintf+0x20>
    }
  }
}
    1830:	0001                	nop
    1832:	0001                	nop
    1834:	60a6                	ld	ra,72(sp)
    1836:	6406                	ld	s0,64(sp)
    1838:	6161                	addi	sp,sp,80
    183a:	8082                	ret

000000000000183c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    183c:	7159                	addi	sp,sp,-112
    183e:	fc06                	sd	ra,56(sp)
    1840:	f822                	sd	s0,48(sp)
    1842:	0080                	addi	s0,sp,64
    1844:	fcb43823          	sd	a1,-48(s0)
    1848:	e010                	sd	a2,0(s0)
    184a:	e414                	sd	a3,8(s0)
    184c:	e818                	sd	a4,16(s0)
    184e:	ec1c                	sd	a5,24(s0)
    1850:	03043023          	sd	a6,32(s0)
    1854:	03143423          	sd	a7,40(s0)
    1858:	87aa                	mv	a5,a0
    185a:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
    185e:	03040793          	addi	a5,s0,48
    1862:	fcf43423          	sd	a5,-56(s0)
    1866:	fc843783          	ld	a5,-56(s0)
    186a:	fd078793          	addi	a5,a5,-48
    186e:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
    1872:	fe843703          	ld	a4,-24(s0)
    1876:	fdc42783          	lw	a5,-36(s0)
    187a:	863a                	mv	a2,a4
    187c:	fd043583          	ld	a1,-48(s0)
    1880:	853e                	mv	a0,a5
    1882:	00000097          	auipc	ra,0x0
    1886:	d54080e7          	jalr	-684(ra) # 15d6 <vprintf>
}
    188a:	0001                	nop
    188c:	70e2                	ld	ra,56(sp)
    188e:	7442                	ld	s0,48(sp)
    1890:	6165                	addi	sp,sp,112
    1892:	8082                	ret

0000000000001894 <printf>:

void
printf(const char *fmt, ...)
{
    1894:	7159                	addi	sp,sp,-112
    1896:	f406                	sd	ra,40(sp)
    1898:	f022                	sd	s0,32(sp)
    189a:	1800                	addi	s0,sp,48
    189c:	fca43c23          	sd	a0,-40(s0)
    18a0:	e40c                	sd	a1,8(s0)
    18a2:	e810                	sd	a2,16(s0)
    18a4:	ec14                	sd	a3,24(s0)
    18a6:	f018                	sd	a4,32(s0)
    18a8:	f41c                	sd	a5,40(s0)
    18aa:	03043823          	sd	a6,48(s0)
    18ae:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    18b2:	04040793          	addi	a5,s0,64
    18b6:	fcf43823          	sd	a5,-48(s0)
    18ba:	fd043783          	ld	a5,-48(s0)
    18be:	fc878793          	addi	a5,a5,-56
    18c2:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
    18c6:	fe843783          	ld	a5,-24(s0)
    18ca:	863e                	mv	a2,a5
    18cc:	fd843583          	ld	a1,-40(s0)
    18d0:	4505                	li	a0,1
    18d2:	00000097          	auipc	ra,0x0
    18d6:	d04080e7          	jalr	-764(ra) # 15d6 <vprintf>
}
    18da:	0001                	nop
    18dc:	70a2                	ld	ra,40(sp)
    18de:	7402                	ld	s0,32(sp)
    18e0:	6165                	addi	sp,sp,112
    18e2:	8082                	ret

00000000000018e4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    18e4:	7179                	addi	sp,sp,-48
    18e6:	f422                	sd	s0,40(sp)
    18e8:	1800                	addi	s0,sp,48
    18ea:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    18ee:	fd843783          	ld	a5,-40(s0)
    18f2:	17c1                	addi	a5,a5,-16
    18f4:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    18f8:	00001797          	auipc	a5,0x1
    18fc:	19078793          	addi	a5,a5,400 # 2a88 <freep>
    1900:	639c                	ld	a5,0(a5)
    1902:	fef43423          	sd	a5,-24(s0)
    1906:	a815                	j	193a <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1908:	fe843783          	ld	a5,-24(s0)
    190c:	639c                	ld	a5,0(a5)
    190e:	fe843703          	ld	a4,-24(s0)
    1912:	00f76f63          	bltu	a4,a5,1930 <free+0x4c>
    1916:	fe043703          	ld	a4,-32(s0)
    191a:	fe843783          	ld	a5,-24(s0)
    191e:	02e7eb63          	bltu	a5,a4,1954 <free+0x70>
    1922:	fe843783          	ld	a5,-24(s0)
    1926:	639c                	ld	a5,0(a5)
    1928:	fe043703          	ld	a4,-32(s0)
    192c:	02f76463          	bltu	a4,a5,1954 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1930:	fe843783          	ld	a5,-24(s0)
    1934:	639c                	ld	a5,0(a5)
    1936:	fef43423          	sd	a5,-24(s0)
    193a:	fe043703          	ld	a4,-32(s0)
    193e:	fe843783          	ld	a5,-24(s0)
    1942:	fce7f3e3          	bgeu	a5,a4,1908 <free+0x24>
    1946:	fe843783          	ld	a5,-24(s0)
    194a:	639c                	ld	a5,0(a5)
    194c:	fe043703          	ld	a4,-32(s0)
    1950:	faf77ce3          	bgeu	a4,a5,1908 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1954:	fe043783          	ld	a5,-32(s0)
    1958:	479c                	lw	a5,8(a5)
    195a:	1782                	slli	a5,a5,0x20
    195c:	9381                	srli	a5,a5,0x20
    195e:	0792                	slli	a5,a5,0x4
    1960:	fe043703          	ld	a4,-32(s0)
    1964:	973e                	add	a4,a4,a5
    1966:	fe843783          	ld	a5,-24(s0)
    196a:	639c                	ld	a5,0(a5)
    196c:	02f71763          	bne	a4,a5,199a <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
    1970:	fe043783          	ld	a5,-32(s0)
    1974:	4798                	lw	a4,8(a5)
    1976:	fe843783          	ld	a5,-24(s0)
    197a:	639c                	ld	a5,0(a5)
    197c:	479c                	lw	a5,8(a5)
    197e:	9fb9                	addw	a5,a5,a4
    1980:	0007871b          	sext.w	a4,a5
    1984:	fe043783          	ld	a5,-32(s0)
    1988:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
    198a:	fe843783          	ld	a5,-24(s0)
    198e:	639c                	ld	a5,0(a5)
    1990:	6398                	ld	a4,0(a5)
    1992:	fe043783          	ld	a5,-32(s0)
    1996:	e398                	sd	a4,0(a5)
    1998:	a039                	j	19a6 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
    199a:	fe843783          	ld	a5,-24(s0)
    199e:	6398                	ld	a4,0(a5)
    19a0:	fe043783          	ld	a5,-32(s0)
    19a4:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
    19a6:	fe843783          	ld	a5,-24(s0)
    19aa:	479c                	lw	a5,8(a5)
    19ac:	1782                	slli	a5,a5,0x20
    19ae:	9381                	srli	a5,a5,0x20
    19b0:	0792                	slli	a5,a5,0x4
    19b2:	fe843703          	ld	a4,-24(s0)
    19b6:	97ba                	add	a5,a5,a4
    19b8:	fe043703          	ld	a4,-32(s0)
    19bc:	02f71563          	bne	a4,a5,19e6 <free+0x102>
    p->s.size += bp->s.size;
    19c0:	fe843783          	ld	a5,-24(s0)
    19c4:	4798                	lw	a4,8(a5)
    19c6:	fe043783          	ld	a5,-32(s0)
    19ca:	479c                	lw	a5,8(a5)
    19cc:	9fb9                	addw	a5,a5,a4
    19ce:	0007871b          	sext.w	a4,a5
    19d2:	fe843783          	ld	a5,-24(s0)
    19d6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    19d8:	fe043783          	ld	a5,-32(s0)
    19dc:	6398                	ld	a4,0(a5)
    19de:	fe843783          	ld	a5,-24(s0)
    19e2:	e398                	sd	a4,0(a5)
    19e4:	a031                	j	19f0 <free+0x10c>
  } else
    p->s.ptr = bp;
    19e6:	fe843783          	ld	a5,-24(s0)
    19ea:	fe043703          	ld	a4,-32(s0)
    19ee:	e398                	sd	a4,0(a5)
  freep = p;
    19f0:	00001797          	auipc	a5,0x1
    19f4:	09878793          	addi	a5,a5,152 # 2a88 <freep>
    19f8:	fe843703          	ld	a4,-24(s0)
    19fc:	e398                	sd	a4,0(a5)
}
    19fe:	0001                	nop
    1a00:	7422                	ld	s0,40(sp)
    1a02:	6145                	addi	sp,sp,48
    1a04:	8082                	ret

0000000000001a06 <morecore>:

static Header*
morecore(uint nu)
{
    1a06:	7179                	addi	sp,sp,-48
    1a08:	f406                	sd	ra,40(sp)
    1a0a:	f022                	sd	s0,32(sp)
    1a0c:	1800                	addi	s0,sp,48
    1a0e:	87aa                	mv	a5,a0
    1a10:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
    1a14:	fdc42783          	lw	a5,-36(s0)
    1a18:	0007871b          	sext.w	a4,a5
    1a1c:	6785                	lui	a5,0x1
    1a1e:	00f77563          	bgeu	a4,a5,1a28 <morecore+0x22>
    nu = 4096;
    1a22:	6785                	lui	a5,0x1
    1a24:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    1a28:	fdc42783          	lw	a5,-36(s0)
    1a2c:	0047979b          	slliw	a5,a5,0x4
    1a30:	2781                	sext.w	a5,a5
    1a32:	2781                	sext.w	a5,a5
    1a34:	853e                	mv	a0,a5
    1a36:	00000097          	auipc	ra,0x0
    1a3a:	9a0080e7          	jalr	-1632(ra) # 13d6 <sbrk>
    1a3e:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
    1a42:	fe843703          	ld	a4,-24(s0)
    1a46:	57fd                	li	a5,-1
    1a48:	00f71463          	bne	a4,a5,1a50 <morecore+0x4a>
    return 0;
    1a4c:	4781                	li	a5,0
    1a4e:	a03d                	j	1a7c <morecore+0x76>
  hp = (Header*)p;
    1a50:	fe843783          	ld	a5,-24(s0)
    1a54:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    1a58:	fe043783          	ld	a5,-32(s0)
    1a5c:	fdc42703          	lw	a4,-36(s0)
    1a60:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    1a62:	fe043783          	ld	a5,-32(s0)
    1a66:	07c1                	addi	a5,a5,16
    1a68:	853e                	mv	a0,a5
    1a6a:	00000097          	auipc	ra,0x0
    1a6e:	e7a080e7          	jalr	-390(ra) # 18e4 <free>
  return freep;
    1a72:	00001797          	auipc	a5,0x1
    1a76:	01678793          	addi	a5,a5,22 # 2a88 <freep>
    1a7a:	639c                	ld	a5,0(a5)
}
    1a7c:	853e                	mv	a0,a5
    1a7e:	70a2                	ld	ra,40(sp)
    1a80:	7402                	ld	s0,32(sp)
    1a82:	6145                	addi	sp,sp,48
    1a84:	8082                	ret

0000000000001a86 <malloc>:

void*
malloc(uint nbytes)
{
    1a86:	7139                	addi	sp,sp,-64
    1a88:	fc06                	sd	ra,56(sp)
    1a8a:	f822                	sd	s0,48(sp)
    1a8c:	0080                	addi	s0,sp,64
    1a8e:	87aa                	mv	a5,a0
    1a90:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1a94:	fcc46783          	lwu	a5,-52(s0)
    1a98:	07bd                	addi	a5,a5,15
    1a9a:	8391                	srli	a5,a5,0x4
    1a9c:	2781                	sext.w	a5,a5
    1a9e:	2785                	addiw	a5,a5,1
    1aa0:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    1aa4:	00001797          	auipc	a5,0x1
    1aa8:	fe478793          	addi	a5,a5,-28 # 2a88 <freep>
    1aac:	639c                	ld	a5,0(a5)
    1aae:	fef43023          	sd	a5,-32(s0)
    1ab2:	fe043783          	ld	a5,-32(s0)
    1ab6:	ef95                	bnez	a5,1af2 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    1ab8:	00001797          	auipc	a5,0x1
    1abc:	fc078793          	addi	a5,a5,-64 # 2a78 <base>
    1ac0:	fef43023          	sd	a5,-32(s0)
    1ac4:	00001797          	auipc	a5,0x1
    1ac8:	fc478793          	addi	a5,a5,-60 # 2a88 <freep>
    1acc:	fe043703          	ld	a4,-32(s0)
    1ad0:	e398                	sd	a4,0(a5)
    1ad2:	00001797          	auipc	a5,0x1
    1ad6:	fb678793          	addi	a5,a5,-74 # 2a88 <freep>
    1ada:	6398                	ld	a4,0(a5)
    1adc:	00001797          	auipc	a5,0x1
    1ae0:	f9c78793          	addi	a5,a5,-100 # 2a78 <base>
    1ae4:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    1ae6:	00001797          	auipc	a5,0x1
    1aea:	f9278793          	addi	a5,a5,-110 # 2a78 <base>
    1aee:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1af2:	fe043783          	ld	a5,-32(s0)
    1af6:	639c                	ld	a5,0(a5)
    1af8:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1afc:	fe843783          	ld	a5,-24(s0)
    1b00:	4798                	lw	a4,8(a5)
    1b02:	fdc42783          	lw	a5,-36(s0)
    1b06:	2781                	sext.w	a5,a5
    1b08:	06f76863          	bltu	a4,a5,1b78 <malloc+0xf2>
      if(p->s.size == nunits)
    1b0c:	fe843783          	ld	a5,-24(s0)
    1b10:	4798                	lw	a4,8(a5)
    1b12:	fdc42783          	lw	a5,-36(s0)
    1b16:	2781                	sext.w	a5,a5
    1b18:	00e79963          	bne	a5,a4,1b2a <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    1b1c:	fe843783          	ld	a5,-24(s0)
    1b20:	6398                	ld	a4,0(a5)
    1b22:	fe043783          	ld	a5,-32(s0)
    1b26:	e398                	sd	a4,0(a5)
    1b28:	a82d                	j	1b62 <malloc+0xdc>
      else {
        p->s.size -= nunits;
    1b2a:	fe843783          	ld	a5,-24(s0)
    1b2e:	4798                	lw	a4,8(a5)
    1b30:	fdc42783          	lw	a5,-36(s0)
    1b34:	40f707bb          	subw	a5,a4,a5
    1b38:	0007871b          	sext.w	a4,a5
    1b3c:	fe843783          	ld	a5,-24(s0)
    1b40:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1b42:	fe843783          	ld	a5,-24(s0)
    1b46:	479c                	lw	a5,8(a5)
    1b48:	1782                	slli	a5,a5,0x20
    1b4a:	9381                	srli	a5,a5,0x20
    1b4c:	0792                	slli	a5,a5,0x4
    1b4e:	fe843703          	ld	a4,-24(s0)
    1b52:	97ba                	add	a5,a5,a4
    1b54:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    1b58:	fe843783          	ld	a5,-24(s0)
    1b5c:	fdc42703          	lw	a4,-36(s0)
    1b60:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    1b62:	00001797          	auipc	a5,0x1
    1b66:	f2678793          	addi	a5,a5,-218 # 2a88 <freep>
    1b6a:	fe043703          	ld	a4,-32(s0)
    1b6e:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1b70:	fe843783          	ld	a5,-24(s0)
    1b74:	07c1                	addi	a5,a5,16
    1b76:	a091                	j	1bba <malloc+0x134>
    }
    if(p == freep)
    1b78:	00001797          	auipc	a5,0x1
    1b7c:	f1078793          	addi	a5,a5,-240 # 2a88 <freep>
    1b80:	639c                	ld	a5,0(a5)
    1b82:	fe843703          	ld	a4,-24(s0)
    1b86:	02f71063          	bne	a4,a5,1ba6 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
    1b8a:	fdc42783          	lw	a5,-36(s0)
    1b8e:	853e                	mv	a0,a5
    1b90:	00000097          	auipc	ra,0x0
    1b94:	e76080e7          	jalr	-394(ra) # 1a06 <morecore>
    1b98:	fea43423          	sd	a0,-24(s0)
    1b9c:	fe843783          	ld	a5,-24(s0)
    1ba0:	e399                	bnez	a5,1ba6 <malloc+0x120>
        return 0;
    1ba2:	4781                	li	a5,0
    1ba4:	a819                	j	1bba <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1ba6:	fe843783          	ld	a5,-24(s0)
    1baa:	fef43023          	sd	a5,-32(s0)
    1bae:	fe843783          	ld	a5,-24(s0)
    1bb2:	639c                	ld	a5,0(a5)
    1bb4:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1bb8:	b791                	j	1afc <malloc+0x76>
  }
}
    1bba:	853e                	mv	a0,a5
    1bbc:	70e2                	ld	ra,56(sp)
    1bbe:	7442                	ld	s0,48(sp)
    1bc0:	6121                	addi	sp,sp,64
    1bc2:	8082                	ret

0000000000001bc4 <setjmp>:
    1bc4:	e100                	sd	s0,0(a0)
    1bc6:	e504                	sd	s1,8(a0)
    1bc8:	01253823          	sd	s2,16(a0)
    1bcc:	01353c23          	sd	s3,24(a0)
    1bd0:	03453023          	sd	s4,32(a0)
    1bd4:	03553423          	sd	s5,40(a0)
    1bd8:	03653823          	sd	s6,48(a0)
    1bdc:	03753c23          	sd	s7,56(a0)
    1be0:	05853023          	sd	s8,64(a0)
    1be4:	05953423          	sd	s9,72(a0)
    1be8:	05a53823          	sd	s10,80(a0)
    1bec:	05b53c23          	sd	s11,88(a0)
    1bf0:	06153023          	sd	ra,96(a0)
    1bf4:	06253423          	sd	sp,104(a0)
    1bf8:	4501                	li	a0,0
    1bfa:	8082                	ret

0000000000001bfc <longjmp>:
    1bfc:	6100                	ld	s0,0(a0)
    1bfe:	6504                	ld	s1,8(a0)
    1c00:	01053903          	ld	s2,16(a0)
    1c04:	01853983          	ld	s3,24(a0)
    1c08:	02053a03          	ld	s4,32(a0)
    1c0c:	02853a83          	ld	s5,40(a0)
    1c10:	03053b03          	ld	s6,48(a0)
    1c14:	03853b83          	ld	s7,56(a0)
    1c18:	04053c03          	ld	s8,64(a0)
    1c1c:	04853c83          	ld	s9,72(a0)
    1c20:	05053d03          	ld	s10,80(a0)
    1c24:	05853d83          	ld	s11,88(a0)
    1c28:	06053083          	ld	ra,96(a0)
    1c2c:	06853103          	ld	sp,104(a0)
    1c30:	c199                	beqz	a1,1c36 <longjmp_1>
    1c32:	852e                	mv	a0,a1
    1c34:	8082                	ret

0000000000001c36 <longjmp_1>:
    1c36:	4505                	li	a0,1
    1c38:	8082                	ret

0000000000001c3a <schedule_default>:
#define INT_MAX 2147483647
#define TIME_QUANTUM 2  // Define a base time quantum for the round-robin

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
    1c3a:	715d                	addi	sp,sp,-80
    1c3c:	e4a2                	sd	s0,72(sp)
    1c3e:	e0a6                	sd	s1,64(sp)
    1c40:	0880                	addi	s0,sp,80
    1c42:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
    1c44:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
    1c48:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
    1c4c:	649c                	ld	a5,8(s1)
    1c4e:	639c                	ld	a5,0(a5)
    1c50:	fcf43c23          	sd	a5,-40(s0)
    1c54:	fd843783          	ld	a5,-40(s0)
    1c58:	fd878793          	addi	a5,a5,-40
    1c5c:	fef43023          	sd	a5,-32(s0)
    1c60:	a81d                	j	1c96 <schedule_default+0x5c>
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
    1c62:	fe843783          	ld	a5,-24(s0)
    1c66:	cb89                	beqz	a5,1c78 <schedule_default+0x3e>
    1c68:	fe043783          	ld	a5,-32(s0)
    1c6c:	5fd8                	lw	a4,60(a5)
    1c6e:	fe843783          	ld	a5,-24(s0)
    1c72:	5fdc                	lw	a5,60(a5)
    1c74:	00f75663          	bge	a4,a5,1c80 <schedule_default+0x46>
            thread_with_smallest_id = th;
    1c78:	fe043783          	ld	a5,-32(s0)
    1c7c:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
    1c80:	fe043783          	ld	a5,-32(s0)
    1c84:	779c                	ld	a5,40(a5)
    1c86:	fcf43823          	sd	a5,-48(s0)
    1c8a:	fd043783          	ld	a5,-48(s0)
    1c8e:	fd878793          	addi	a5,a5,-40
    1c92:	fef43023          	sd	a5,-32(s0)
    1c96:	fe043783          	ld	a5,-32(s0)
    1c9a:	02878713          	addi	a4,a5,40
    1c9e:	649c                	ld	a5,8(s1)
    1ca0:	fcf711e3          	bne	a4,a5,1c62 <schedule_default+0x28>
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
    1ca4:	fe843783          	ld	a5,-24(s0)
    1ca8:	cf89                	beqz	a5,1cc2 <schedule_default+0x88>
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
    1caa:	fe843783          	ld	a5,-24(s0)
    1cae:	02878793          	addi	a5,a5,40
    1cb2:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
    1cb6:	fe843783          	ld	a5,-24(s0)
    1cba:	4fbc                	lw	a5,88(a5)
    1cbc:	faf42c23          	sw	a5,-72(s0)
    1cc0:	a039                	j	1cce <schedule_default+0x94>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
    1cc2:	649c                	ld	a5,8(s1)
    1cc4:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
    1cc8:	4785                	li	a5,1
    1cca:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
    1cce:	fb043783          	ld	a5,-80(s0)
    1cd2:	fcf43023          	sd	a5,-64(s0)
    1cd6:	fb843783          	ld	a5,-72(s0)
    1cda:	fcf43423          	sd	a5,-56(s0)
    1cde:	4701                	li	a4,0
    1ce0:	fc043703          	ld	a4,-64(s0)
    1ce4:	4781                	li	a5,0
    1ce6:	fc843783          	ld	a5,-56(s0)
    1cea:	863a                	mv	a2,a4
    1cec:	86be                	mv	a3,a5
    1cee:	8732                	mv	a4,a2
    1cf0:	87b6                	mv	a5,a3
}
    1cf2:	853a                	mv	a0,a4
    1cf4:	85be                	mv	a1,a5
    1cf6:	6426                	ld	s0,72(sp)
    1cf8:	6486                	ld	s1,64(sp)
    1cfa:	6161                	addi	sp,sp,80
    1cfc:	8082                	ret

0000000000001cfe <schedule_wrr>:

/* MP3 Part 1 - Non-Real-Time Scheduling */
/* Weighted-Round-Robin Scheduling */
struct threads_sched_result schedule_wrr(struct threads_sched_args args)
{
    1cfe:	711d                	addi	sp,sp,-96
    1d00:	eca2                	sd	s0,88(sp)
    1d02:	e8a6                	sd	s1,80(sp)
    1d04:	1080                	addi	s0,sp,96
    1d06:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the weighted round-robin scheduling algorithm
    static struct thread *last_thread = NULL;
    struct thread *selected_thread = NULL;
    1d08:	fe043423          	sd	zero,-24(s0)
    struct thread *candidate = NULL;
    1d0c:	fe043023          	sd	zero,-32(s0)

    // If last_thread is NULL or its remaining time is zero, reset the selection process
    if (last_thread == NULL || last_thread->remaining_time <= 0) {
    1d10:	00001797          	auipc	a5,0x1
    1d14:	d8078793          	addi	a5,a5,-640 # 2a90 <last_thread.1226>
    1d18:	639c                	ld	a5,0(a5)
    1d1a:	cb89                	beqz	a5,1d2c <schedule_wrr+0x2e>
    1d1c:	00001797          	auipc	a5,0x1
    1d20:	d7478793          	addi	a5,a5,-652 # 2a90 <last_thread.1226>
    1d24:	639c                	ld	a5,0(a5)
    1d26:	4fbc                	lw	a5,88(a5)
    1d28:	00f04863          	bgtz	a5,1d38 <schedule_wrr+0x3a>
        last_thread = NULL;
    1d2c:	00001797          	auipc	a5,0x1
    1d30:	d6478793          	addi	a5,a5,-668 # 2a90 <last_thread.1226>
    1d34:	0007b023          	sd	zero,0(a5)
    }

    // Find the first thread that is ready to run
    list_for_each_entry(candidate, args.run_queue, thread_list) {
    1d38:	649c                	ld	a5,8(s1)
    1d3a:	639c                	ld	a5,0(a5)
    1d3c:	fcf43823          	sd	a5,-48(s0)
    1d40:	fd043783          	ld	a5,-48(s0)
    1d44:	fd878793          	addi	a5,a5,-40
    1d48:	fef43023          	sd	a5,-32(s0)
    1d4c:	a0a9                	j	1d96 <schedule_wrr+0x98>
        if (!last_thread && candidate->remaining_time > 0)
    1d4e:	00001797          	auipc	a5,0x1
    1d52:	d4278793          	addi	a5,a5,-702 # 2a90 <last_thread.1226>
    1d56:	639c                	ld	a5,0(a5)
    1d58:	eb91                	bnez	a5,1d6c <schedule_wrr+0x6e>
    1d5a:	fe043783          	ld	a5,-32(s0)
    1d5e:	4fbc                	lw	a5,88(a5)
    1d60:	00f05663          	blez	a5,1d6c <schedule_wrr+0x6e>
            selected_thread = candidate;
    1d64:	fe043783          	ld	a5,-32(s0)
    1d68:	fef43423          	sd	a5,-24(s0)
        if (candidate->remaining_time > 0) {
    1d6c:	fe043783          	ld	a5,-32(s0)
    1d70:	4fbc                	lw	a5,88(a5)
    1d72:	00f05763          	blez	a5,1d80 <schedule_wrr+0x82>
            selected_thread = candidate;
    1d76:	fe043783          	ld	a5,-32(s0)
    1d7a:	fef43423          	sd	a5,-24(s0)
            break;
    1d7e:	a01d                	j	1da4 <schedule_wrr+0xa6>
    list_for_each_entry(candidate, args.run_queue, thread_list) {
    1d80:	fe043783          	ld	a5,-32(s0)
    1d84:	779c                	ld	a5,40(a5)
    1d86:	fcf43423          	sd	a5,-56(s0)
    1d8a:	fc843783          	ld	a5,-56(s0)
    1d8e:	fd878793          	addi	a5,a5,-40
    1d92:	fef43023          	sd	a5,-32(s0)
    1d96:	fe043783          	ld	a5,-32(s0)
    1d9a:	02878713          	addi	a4,a5,40
    1d9e:	649c                	ld	a5,8(s1)
    1da0:	faf717e3          	bne	a4,a5,1d4e <schedule_wrr+0x50>
        }
    }

    // Fall back to the last_thread if no other thread is selected and it still has remaining time
    if (!selected_thread && last_thread && last_thread->remaining_time > 0) {
    1da4:	fe843783          	ld	a5,-24(s0)
    1da8:	e795                	bnez	a5,1dd4 <schedule_wrr+0xd6>
    1daa:	00001797          	auipc	a5,0x1
    1dae:	ce678793          	addi	a5,a5,-794 # 2a90 <last_thread.1226>
    1db2:	639c                	ld	a5,0(a5)
    1db4:	c385                	beqz	a5,1dd4 <schedule_wrr+0xd6>
    1db6:	00001797          	auipc	a5,0x1
    1dba:	cda78793          	addi	a5,a5,-806 # 2a90 <last_thread.1226>
    1dbe:	639c                	ld	a5,0(a5)
    1dc0:	4fbc                	lw	a5,88(a5)
    1dc2:	00f05963          	blez	a5,1dd4 <schedule_wrr+0xd6>
        selected_thread = last_thread;
    1dc6:	00001797          	auipc	a5,0x1
    1dca:	cca78793          	addi	a5,a5,-822 # 2a90 <last_thread.1226>
    1dce:	639c                	ld	a5,0(a5)
    1dd0:	fef43423          	sd	a5,-24(s0)
    }

    // Set the scheduling result
    if (selected_thread) {
    1dd4:	fe843783          	ld	a5,-24(s0)
    1dd8:	c7b9                	beqz	a5,1e26 <schedule_wrr+0x128>
        int time_slice = selected_thread->weight * TIME_QUANTUM;
    1dda:	fe843783          	ld	a5,-24(s0)
    1dde:	47bc                	lw	a5,72(a5)
    1de0:	0017979b          	slliw	a5,a5,0x1
    1de4:	fcf42e23          	sw	a5,-36(s0)
        if (time_slice > selected_thread->remaining_time) {
    1de8:	fe843783          	ld	a5,-24(s0)
    1dec:	4fb8                	lw	a4,88(a5)
    1dee:	fdc42783          	lw	a5,-36(s0)
    1df2:	2781                	sext.w	a5,a5
    1df4:	00f75763          	bge	a4,a5,1e02 <schedule_wrr+0x104>
            time_slice = selected_thread->remaining_time;
    1df8:	fe843783          	ld	a5,-24(s0)
    1dfc:	4fbc                	lw	a5,88(a5)
    1dfe:	fcf42e23          	sw	a5,-36(s0)
        }
        r.scheduled_thread_list_member = &selected_thread->thread_list;
    1e02:	fe843783          	ld	a5,-24(s0)
    1e06:	02878793          	addi	a5,a5,40
    1e0a:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = time_slice;
    1e0e:	fdc42783          	lw	a5,-36(s0)
    1e12:	faf42823          	sw	a5,-80(s0)
        last_thread = selected_thread;  // Update the last run thread
    1e16:	00001797          	auipc	a5,0x1
    1e1a:	c7a78793          	addi	a5,a5,-902 # 2a90 <last_thread.1226>
    1e1e:	fe843703          	ld	a4,-24(s0)
    1e22:	e398                	sd	a4,0(a5)
    1e24:	a039                	j	1e32 <schedule_wrr+0x134>
    } else {
        // Idle if no suitable thread is found
        r.scheduled_thread_list_member = args.run_queue;
    1e26:	649c                	ld	a5,8(s1)
    1e28:	faf43423          	sd	a5,-88(s0)
        r.allocated_time = 1;
    1e2c:	4785                	li	a5,1
    1e2e:	faf42823          	sw	a5,-80(s0)
    }

    return r;
    1e32:	fa843783          	ld	a5,-88(s0)
    1e36:	faf43c23          	sd	a5,-72(s0)
    1e3a:	fb043783          	ld	a5,-80(s0)
    1e3e:	fcf43023          	sd	a5,-64(s0)
    1e42:	4701                	li	a4,0
    1e44:	fb843703          	ld	a4,-72(s0)
    1e48:	4781                	li	a5,0
    1e4a:	fc043783          	ld	a5,-64(s0)
    1e4e:	863a                	mv	a2,a4
    1e50:	86be                	mv	a3,a5
    1e52:	8732                	mv	a4,a2
    1e54:	87b6                	mv	a5,a3
}
    1e56:	853a                	mv	a0,a4
    1e58:	85be                	mv	a1,a5
    1e5a:	6466                	ld	s0,88(sp)
    1e5c:	64c6                	ld	s1,80(sp)
    1e5e:	6125                	addi	sp,sp,96
    1e60:	8082                	ret

0000000000001e62 <schedule_sjf>:

struct threads_sched_result schedule_sjf(struct threads_sched_args args)
{
    1e62:	7119                	addi	sp,sp,-128
    1e64:	fc86                	sd	ra,120(sp)
    1e66:	f8a2                	sd	s0,112(sp)
    1e68:	f4a6                	sd	s1,104(sp)
    1e6a:	f0ca                	sd	s2,96(sp)
    1e6c:	ecce                	sd	s3,88(sp)
    1e6e:	0100                	addi	s0,sp,128
    1e70:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the shortest-job-first scheduling algorithm
    struct thread *shortest_job = NULL;
    1e72:	fc043423          	sd	zero,-56(s0)
    struct thread *t;
    int shortest_time = INT_MAX;
    1e76:	800007b7          	lui	a5,0x80000
    1e7a:	fff7c793          	not	a5,a5
    1e7e:	faf42e23          	sw	a5,-68(s0)

    // Find the thread with the shortest remaining time that is ready to run
    list_for_each_entry(t, args.run_queue, thread_list) {
    1e82:	649c                	ld	a5,8(s1)
    1e84:	639c                	ld	a5,0(a5)
    1e86:	faf43823          	sd	a5,-80(s0)
    1e8a:	fb043783          	ld	a5,-80(s0)
    1e8e:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffd168>
    1e92:	fcf43023          	sd	a5,-64(s0)
    1e96:	a8a9                	j	1ef0 <schedule_sjf+0x8e>
        printf("Thread ID: %d, Remaining Time: %d\n", t->ID, t->remaining_time);
    1e98:	fc043783          	ld	a5,-64(s0)
    1e9c:	5fd8                	lw	a4,60(a5)
    1e9e:	fc043783          	ld	a5,-64(s0)
    1ea2:	4fbc                	lw	a5,88(a5)
    1ea4:	863e                	mv	a2,a5
    1ea6:	85ba                	mv	a1,a4
    1ea8:	00000517          	auipc	a0,0x0
    1eac:	7a050513          	addi	a0,a0,1952 # 2648 <schedule_dm+0x50c>
    1eb0:	00000097          	auipc	ra,0x0
    1eb4:	9e4080e7          	jalr	-1564(ra) # 1894 <printf>
        if (t->remaining_time < shortest_time) {
    1eb8:	fc043783          	ld	a5,-64(s0)
    1ebc:	4fb8                	lw	a4,88(a5)
    1ebe:	fbc42783          	lw	a5,-68(s0)
    1ec2:	2781                	sext.w	a5,a5
    1ec4:	00f75b63          	bge	a4,a5,1eda <schedule_sjf+0x78>
            shortest_time = t->remaining_time;
    1ec8:	fc043783          	ld	a5,-64(s0)
    1ecc:	4fbc                	lw	a5,88(a5)
    1ece:	faf42e23          	sw	a5,-68(s0)
            shortest_job = t;
    1ed2:	fc043783          	ld	a5,-64(s0)
    1ed6:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    1eda:	fc043783          	ld	a5,-64(s0)
    1ede:	779c                	ld	a5,40(a5)
    1ee0:	faf43423          	sd	a5,-88(s0)
    1ee4:	fa843783          	ld	a5,-88(s0)
    1ee8:	fd878793          	addi	a5,a5,-40
    1eec:	fcf43023          	sd	a5,-64(s0)
    1ef0:	fc043783          	ld	a5,-64(s0)
    1ef4:	02878713          	addi	a4,a5,40
    1ef8:	649c                	ld	a5,8(s1)
    1efa:	f8f71fe3          	bne	a4,a5,1e98 <schedule_sjf+0x36>
        }
    }

    if (shortest_job) {
    1efe:	fc843783          	ld	a5,-56(s0)
    1f02:	cf89                	beqz	a5,1f1c <schedule_sjf+0xba>
        r.scheduled_thread_list_member = &shortest_job->thread_list;
    1f04:	fc843783          	ld	a5,-56(s0)
    1f08:	02878793          	addi	a5,a5,40
    1f0c:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = shortest_job->remaining_time;  // Allow the thread to run to completion
    1f10:	fc843783          	ld	a5,-56(s0)
    1f14:	4fbc                	lw	a5,88(a5)
    1f16:	f8f42823          	sw	a5,-112(s0)
    1f1a:	a039                	j	1f28 <schedule_sjf+0xc6>
    } else {
        // If no threads are ready, find the next release time or idle
        r.scheduled_thread_list_member = args.run_queue;
    1f1c:	649c                	ld	a5,8(s1)
    1f1e:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = 1;  // Default minimal quantum if unsure
    1f22:	4785                	li	a5,1
    1f24:	f8f42823          	sw	a5,-112(s0)
    }
    return r;
    1f28:	f8843783          	ld	a5,-120(s0)
    1f2c:	f8f43c23          	sd	a5,-104(s0)
    1f30:	f9043783          	ld	a5,-112(s0)
    1f34:	faf43023          	sd	a5,-96(s0)
    1f38:	4701                	li	a4,0
    1f3a:	f9843703          	ld	a4,-104(s0)
    1f3e:	4781                	li	a5,0
    1f40:	fa043783          	ld	a5,-96(s0)
    1f44:	893a                	mv	s2,a4
    1f46:	89be                	mv	s3,a5
    1f48:	874a                	mv	a4,s2
    1f4a:	87ce                	mv	a5,s3
}
    1f4c:	853a                	mv	a0,a4
    1f4e:	85be                	mv	a1,a5
    1f50:	70e6                	ld	ra,120(sp)
    1f52:	7446                	ld	s0,112(sp)
    1f54:	74a6                	ld	s1,104(sp)
    1f56:	7906                	ld	s2,96(sp)
    1f58:	69e6                	ld	s3,88(sp)
    1f5a:	6109                	addi	sp,sp,128
    1f5c:	8082                	ret

0000000000001f5e <find_next_release_time>:

int find_next_release_time(struct list_head *release_queue, int current_time) {
    1f5e:	7139                	addi	sp,sp,-64
    1f60:	fc22                	sd	s0,56(sp)
    1f62:	0080                	addi	s0,sp,64
    1f64:	fca43423          	sd	a0,-56(s0)
    1f68:	87ae                	mv	a5,a1
    1f6a:	fcf42223          	sw	a5,-60(s0)
    struct release_queue_entry *next_release = NULL;
    1f6e:	fe043423          	sd	zero,-24(s0)
    int next_release_time = INT_MAX;
    1f72:	800007b7          	lui	a5,0x80000
    1f76:	fff7c793          	not	a5,a5
    1f7a:	fef42223          	sw	a5,-28(s0)

    list_for_each_entry(next_release, release_queue, thread_list) {
    1f7e:	fc843783          	ld	a5,-56(s0)
    1f82:	639c                	ld	a5,0(a5)
    1f84:	fcf43c23          	sd	a5,-40(s0)
    1f88:	fd843783          	ld	a5,-40(s0)
    1f8c:	17e1                	addi	a5,a5,-8
    1f8e:	fef43423          	sd	a5,-24(s0)
    1f92:	a081                	j	1fd2 <find_next_release_time+0x74>
        if (next_release->release_time > current_time &&
    1f94:	fe843783          	ld	a5,-24(s0)
    1f98:	4f98                	lw	a4,24(a5)
    1f9a:	fc442783          	lw	a5,-60(s0)
    1f9e:	2781                	sext.w	a5,a5
    1fa0:	00e7df63          	bge	a5,a4,1fbe <find_next_release_time+0x60>
            next_release->release_time < next_release_time) {
    1fa4:	fe843783          	ld	a5,-24(s0)
    1fa8:	4f98                	lw	a4,24(a5)
        if (next_release->release_time > current_time &&
    1faa:	fe442783          	lw	a5,-28(s0)
    1fae:	2781                	sext.w	a5,a5
    1fb0:	00f75763          	bge	a4,a5,1fbe <find_next_release_time+0x60>
            next_release_time = next_release->release_time;
    1fb4:	fe843783          	ld	a5,-24(s0)
    1fb8:	4f9c                	lw	a5,24(a5)
    1fba:	fef42223          	sw	a5,-28(s0)
    list_for_each_entry(next_release, release_queue, thread_list) {
    1fbe:	fe843783          	ld	a5,-24(s0)
    1fc2:	679c                	ld	a5,8(a5)
    1fc4:	fcf43823          	sd	a5,-48(s0)
    1fc8:	fd043783          	ld	a5,-48(s0)
    1fcc:	17e1                	addi	a5,a5,-8
    1fce:	fef43423          	sd	a5,-24(s0)
    1fd2:	fe843783          	ld	a5,-24(s0)
    1fd6:	07a1                	addi	a5,a5,8
    1fd8:	fc843703          	ld	a4,-56(s0)
    1fdc:	faf71ce3          	bne	a4,a5,1f94 <find_next_release_time+0x36>
        }
    }

    if (next_release_time == INT_MAX)
    1fe0:	fe442783          	lw	a5,-28(s0)
    1fe4:	0007871b          	sext.w	a4,a5
    1fe8:	800007b7          	lui	a5,0x80000
    1fec:	fff7c793          	not	a5,a5
    1ff0:	00f71463          	bne	a4,a5,1ff8 <find_next_release_time+0x9a>
        return -1; // No threads in the release queue
    1ff4:	57fd                	li	a5,-1
    1ff6:	a801                	j	2006 <find_next_release_time+0xa8>

    return next_release_time - current_time;
    1ff8:	fe442703          	lw	a4,-28(s0)
    1ffc:	fc442783          	lw	a5,-60(s0)
    2000:	40f707bb          	subw	a5,a4,a5
    2004:	2781                	sext.w	a5,a5
}
    2006:	853e                	mv	a0,a5
    2008:	7462                	ld	s0,56(sp)
    200a:	6121                	addi	sp,sp,64
    200c:	8082                	ret

000000000000200e <schedule_lst>:

/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args)
{
    200e:	7119                	addi	sp,sp,-128
    2010:	fc86                	sd	ra,120(sp)
    2012:	f8a2                	sd	s0,112(sp)
    2014:	f4a6                	sd	s1,104(sp)
    2016:	f0ca                	sd	s2,96(sp)
    2018:	ecce                	sd	s3,88(sp)
    201a:	0100                	addi	s0,sp,128
    201c:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the least-slack-time scheduling algorithm
    struct thread *min_slack = NULL;
    201e:	fc043423          	sd	zero,-56(s0)
    int min_slack_time = INT_MAX;
    2022:	800007b7          	lui	a5,0x80000
    2026:	fff7c793          	not	a5,a5
    202a:	fcf42223          	sw	a5,-60(s0)
    struct thread *t;

    // Find the thread with the minimum slack time
    list_for_each_entry(t, args.run_queue, thread_list) {
    202e:	649c                	ld	a5,8(s1)
    2030:	639c                	ld	a5,0(a5)
    2032:	faf43823          	sd	a5,-80(s0)
    2036:	fb043783          	ld	a5,-80(s0)
    203a:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffd168>
    203e:	faf43c23          	sd	a5,-72(s0)
    2042:	a8b5                	j	20be <schedule_lst+0xb0>
        int slack_time = t->deadline - args.current_time - t->remaining_time;
    2044:	fb843783          	ld	a5,-72(s0)
    2048:	47f8                	lw	a4,76(a5)
    204a:	409c                	lw	a5,0(s1)
    204c:	40f707bb          	subw	a5,a4,a5
    2050:	0007871b          	sext.w	a4,a5
    2054:	fb843783          	ld	a5,-72(s0)
    2058:	4fbc                	lw	a5,88(a5)
    205a:	40f707bb          	subw	a5,a4,a5
    205e:	faf42623          	sw	a5,-84(s0)
        if (min_slack == NULL || slack_time < min_slack_time ||
    2062:	fc843783          	ld	a5,-56(s0)
    2066:	cb8d                	beqz	a5,2098 <schedule_lst+0x8a>
    2068:	fac42703          	lw	a4,-84(s0)
    206c:	fc442783          	lw	a5,-60(s0)
    2070:	2701                	sext.w	a4,a4
    2072:	2781                	sext.w	a5,a5
    2074:	02f74263          	blt	a4,a5,2098 <schedule_lst+0x8a>
    2078:	fac42703          	lw	a4,-84(s0)
    207c:	fc442783          	lw	a5,-60(s0)
    2080:	2701                	sext.w	a4,a4
    2082:	2781                	sext.w	a5,a5
    2084:	02f71263          	bne	a4,a5,20a8 <schedule_lst+0x9a>
            (slack_time == min_slack_time && t->ID < min_slack->ID)) {
    2088:	fb843783          	ld	a5,-72(s0)
    208c:	5fd8                	lw	a4,60(a5)
    208e:	fc843783          	ld	a5,-56(s0)
    2092:	5fdc                	lw	a5,60(a5)
    2094:	00f75a63          	bge	a4,a5,20a8 <schedule_lst+0x9a>
            min_slack = t;
    2098:	fb843783          	ld	a5,-72(s0)
    209c:	fcf43423          	sd	a5,-56(s0)
            min_slack_time = slack_time;
    20a0:	fac42783          	lw	a5,-84(s0)
    20a4:	fcf42223          	sw	a5,-60(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    20a8:	fb843783          	ld	a5,-72(s0)
    20ac:	779c                	ld	a5,40(a5)
    20ae:	faf43023          	sd	a5,-96(s0)
    20b2:	fa043783          	ld	a5,-96(s0)
    20b6:	fd878793          	addi	a5,a5,-40
    20ba:	faf43c23          	sd	a5,-72(s0)
    20be:	fb843783          	ld	a5,-72(s0)
    20c2:	02878713          	addi	a4,a5,40
    20c6:	649c                	ld	a5,8(s1)
    20c8:	f6f71ee3          	bne	a4,a5,2044 <schedule_lst+0x36>
        }
    }

    if (min_slack) {
    20cc:	fc843783          	ld	a5,-56(s0)
    20d0:	cf89                	beqz	a5,20ea <schedule_lst+0xdc>
        r.scheduled_thread_list_member = &min_slack->thread_list;
    20d2:	fc843783          	ld	a5,-56(s0)
    20d6:	02878793          	addi	a5,a5,40
    20da:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = min_slack->remaining_time;
    20de:	fc843783          	ld	a5,-56(s0)
    20e2:	4fbc                	lw	a5,88(a5)
    20e4:	f8f42423          	sw	a5,-120(s0)
    20e8:	a839                	j	2106 <schedule_lst+0xf8>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
    20ea:	649c                	ld	a5,8(s1)
    20ec:	f8f43023          	sd	a5,-128(s0)
        r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    20f0:	689c                	ld	a5,16(s1)
    20f2:	4098                	lw	a4,0(s1)
    20f4:	85ba                	mv	a1,a4
    20f6:	853e                	mv	a0,a5
    20f8:	00000097          	auipc	ra,0x0
    20fc:	e66080e7          	jalr	-410(ra) # 1f5e <find_next_release_time>
    2100:	87aa                	mv	a5,a0
    2102:	f8f42423          	sw	a5,-120(s0)
    }

    return r;
    2106:	f8043783          	ld	a5,-128(s0)
    210a:	f8f43823          	sd	a5,-112(s0)
    210e:	f8843783          	ld	a5,-120(s0)
    2112:	f8f43c23          	sd	a5,-104(s0)
    2116:	4701                	li	a4,0
    2118:	f9043703          	ld	a4,-112(s0)
    211c:	4781                	li	a5,0
    211e:	f9843783          	ld	a5,-104(s0)
    2122:	893a                	mv	s2,a4
    2124:	89be                	mv	s3,a5
    2126:	874a                	mv	a4,s2
    2128:	87ce                	mv	a5,s3
}
    212a:	853a                	mv	a0,a4
    212c:	85be                	mv	a1,a5
    212e:	70e6                	ld	ra,120(sp)
    2130:	7446                	ld	s0,112(sp)
    2132:	74a6                	ld	s1,104(sp)
    2134:	7906                	ld	s2,96(sp)
    2136:	69e6                	ld	s3,88(sp)
    2138:	6109                	addi	sp,sp,128
    213a:	8082                	ret

000000000000213c <schedule_dm>:

/* Deadline-Monotonic Scheduling */
struct threads_sched_result schedule_dm(struct threads_sched_args args)
{
    213c:	7135                	addi	sp,sp,-160
    213e:	ed06                	sd	ra,152(sp)
    2140:	e922                	sd	s0,144(sp)
    2142:	e526                	sd	s1,136(sp)
    2144:	e14a                	sd	s2,128(sp)
    2146:	fcce                	sd	s3,120(sp)
    2148:	1100                	addi	s0,sp,160
    214a:	84aa                	mv	s1,a0
    struct threads_sched_result r;
    // TODO: implement the deadline-monotonic scheduling algorithm
   struct thread *earliest_deadline_thread = NULL;
    214c:	fc043423          	sd	zero,-56(s0)
    struct thread *t;
    int earliest_deadline = INT_MAX;
    2150:	800007b7          	lui	a5,0x80000
    2154:	fff7c793          	not	a5,a5
    2158:	faf42e23          	sw	a5,-68(s0)

    // Find the earliest deadline real-time thread
    list_for_each_entry(t, args.run_queue, thread_list) {
    215c:	649c                	ld	a5,8(s1)
    215e:	639c                	ld	a5,0(a5)
    2160:	faf43423          	sd	a5,-88(s0)
    2164:	fa843783          	ld	a5,-88(s0)
    2168:	fd878793          	addi	a5,a5,-40 # ffffffff7fffffd8 <__global_pointer$+0xffffffff7fffd168>
    216c:	fcf43023          	sd	a5,-64(s0)
    2170:	a841                	j	2200 <schedule_dm+0xc4>
        if (t->is_real_time && t->period != -1 && t->current_deadline < earliest_deadline) {
    2172:	fc043783          	ld	a5,-64(s0)
    2176:	43bc                	lw	a5,64(a5)
    2178:	cb95                	beqz	a5,21ac <schedule_dm+0x70>
    217a:	fc043783          	ld	a5,-64(s0)
    217e:	4bbc                	lw	a5,80(a5)
    2180:	873e                	mv	a4,a5
    2182:	57fd                	li	a5,-1
    2184:	02f70463          	beq	a4,a5,21ac <schedule_dm+0x70>
    2188:	fc043783          	ld	a5,-64(s0)
    218c:	4ff8                	lw	a4,92(a5)
    218e:	fbc42783          	lw	a5,-68(s0)
    2192:	2781                	sext.w	a5,a5
    2194:	00f75c63          	bge	a4,a5,21ac <schedule_dm+0x70>
            earliest_deadline = t->current_deadline;
    2198:	fc043783          	ld	a5,-64(s0)
    219c:	4ffc                	lw	a5,92(a5)
    219e:	faf42e23          	sw	a5,-68(s0)
            earliest_deadline_thread = t;
    21a2:	fc043783          	ld	a5,-64(s0)
    21a6:	fcf43423          	sd	a5,-56(s0)
    21aa:	a081                	j	21ea <schedule_dm+0xae>
        } else if (t->is_real_time && t->period != -1 && t->current_deadline == earliest_deadline && t->ID < earliest_deadline_thread->ID) {
    21ac:	fc043783          	ld	a5,-64(s0)
    21b0:	43bc                	lw	a5,64(a5)
    21b2:	cf85                	beqz	a5,21ea <schedule_dm+0xae>
    21b4:	fc043783          	ld	a5,-64(s0)
    21b8:	4bbc                	lw	a5,80(a5)
    21ba:	873e                	mv	a4,a5
    21bc:	57fd                	li	a5,-1
    21be:	02f70663          	beq	a4,a5,21ea <schedule_dm+0xae>
    21c2:	fc043783          	ld	a5,-64(s0)
    21c6:	4ff8                	lw	a4,92(a5)
    21c8:	fbc42783          	lw	a5,-68(s0)
    21cc:	2781                	sext.w	a5,a5
    21ce:	00e79e63          	bne	a5,a4,21ea <schedule_dm+0xae>
    21d2:	fc043783          	ld	a5,-64(s0)
    21d6:	5fd8                	lw	a4,60(a5)
    21d8:	fc843783          	ld	a5,-56(s0)
    21dc:	5fdc                	lw	a5,60(a5)
    21de:	00f75663          	bge	a4,a5,21ea <schedule_dm+0xae>
            earliest_deadline_thread = t;  // Tie-breaking by ID
    21e2:	fc043783          	ld	a5,-64(s0)
    21e6:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(t, args.run_queue, thread_list) {
    21ea:	fc043783          	ld	a5,-64(s0)
    21ee:	779c                	ld	a5,40(a5)
    21f0:	f8f43423          	sd	a5,-120(s0)
    21f4:	f8843783          	ld	a5,-120(s0)
    21f8:	fd878793          	addi	a5,a5,-40
    21fc:	fcf43023          	sd	a5,-64(s0)
    2200:	fc043783          	ld	a5,-64(s0)
    2204:	02878713          	addi	a4,a5,40
    2208:	649c                	ld	a5,8(s1)
    220a:	f6f714e3          	bne	a4,a5,2172 <schedule_dm+0x36>
        }
    }

    if (earliest_deadline_thread) {
    220e:	fc843783          	ld	a5,-56(s0)
    2212:	c7a5                	beqz	a5,227a <schedule_dm+0x13e>
        int time_to_deadline = earliest_deadline_thread->current_deadline - args.current_time;
    2214:	fc843783          	ld	a5,-56(s0)
    2218:	4ff8                	lw	a4,92(a5)
    221a:	409c                	lw	a5,0(s1)
    221c:	40f707bb          	subw	a5,a4,a5
    2220:	f8f42a23          	sw	a5,-108(s0)
        if (earliest_deadline_thread->remaining_time > time_to_deadline) {
    2224:	fc843783          	ld	a5,-56(s0)
    2228:	4fb8                	lw	a4,88(a5)
    222a:	f9442783          	lw	a5,-108(s0)
    222e:	2781                	sext.w	a5,a5
    2230:	00e7db63          	bge	a5,a4,2246 <schedule_dm+0x10a>
            // The real-time thread cannot complete before its deadline, so handle the deadline miss
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    2234:	fc843783          	ld	a5,-56(s0)
    2238:	02878793          	addi	a5,a5,40
    223c:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = 0; // Could set to minimal quantum to allow cleanup or logging
    2240:	f6042823          	sw	zero,-144(s0)
    2244:	a0f1                	j	2310 <schedule_dm+0x1d4>
        } else {
            // Schedule the real-time thread normally if it hasn't missed its deadline
            int time_slice = (time_to_deadline < earliest_deadline_thread->remaining_time) ? time_to_deadline : earliest_deadline_thread->remaining_time;
    2246:	fc843783          	ld	a5,-56(s0)
    224a:	4fbc                	lw	a5,88(a5)
    224c:	863e                	mv	a2,a5
    224e:	f9442783          	lw	a5,-108(s0)
    2252:	0007869b          	sext.w	a3,a5
    2256:	0006071b          	sext.w	a4,a2
    225a:	00d75363          	bge	a4,a3,2260 <schedule_dm+0x124>
    225e:	87b2                	mv	a5,a2
    2260:	f8f42823          	sw	a5,-112(s0)
            r.scheduled_thread_list_member = &earliest_deadline_thread->thread_list;
    2264:	fc843783          	ld	a5,-56(s0)
    2268:	02878793          	addi	a5,a5,40
    226c:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = time_slice;
    2270:	f9042783          	lw	a5,-112(s0)
    2274:	f6f42823          	sw	a5,-144(s0)
    2278:	a861                	j	2310 <schedule_dm+0x1d4>
        }
    } else {
        // If no real-time threads with a deadline are ready, find the thread with the smallest ID
        struct thread *smallest_id_thread = NULL;
    227a:	fa043823          	sd	zero,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    227e:	649c                	ld	a5,8(s1)
    2280:	639c                	ld	a5,0(a5)
    2282:	faf43023          	sd	a5,-96(s0)
    2286:	fa043783          	ld	a5,-96(s0)
    228a:	fd878793          	addi	a5,a5,-40
    228e:	fcf43023          	sd	a5,-64(s0)
    2292:	a81d                	j	22c8 <schedule_dm+0x18c>
            if (smallest_id_thread == NULL || t->ID < smallest_id_thread->ID) {
    2294:	fb043783          	ld	a5,-80(s0)
    2298:	cb89                	beqz	a5,22aa <schedule_dm+0x16e>
    229a:	fc043783          	ld	a5,-64(s0)
    229e:	5fd8                	lw	a4,60(a5)
    22a0:	fb043783          	ld	a5,-80(s0)
    22a4:	5fdc                	lw	a5,60(a5)
    22a6:	00f75663          	bge	a4,a5,22b2 <schedule_dm+0x176>
                smallest_id_thread = t;
    22aa:	fc043783          	ld	a5,-64(s0)
    22ae:	faf43823          	sd	a5,-80(s0)
        list_for_each_entry(t, args.run_queue, thread_list) {
    22b2:	fc043783          	ld	a5,-64(s0)
    22b6:	779c                	ld	a5,40(a5)
    22b8:	f8f43c23          	sd	a5,-104(s0)
    22bc:	f9843783          	ld	a5,-104(s0)
    22c0:	fd878793          	addi	a5,a5,-40
    22c4:	fcf43023          	sd	a5,-64(s0)
    22c8:	fc043783          	ld	a5,-64(s0)
    22cc:	02878713          	addi	a4,a5,40
    22d0:	649c                	ld	a5,8(s1)
    22d2:	fcf711e3          	bne	a4,a5,2294 <schedule_dm+0x158>
            }
        }

        if (smallest_id_thread) {
    22d6:	fb043783          	ld	a5,-80(s0)
    22da:	cf89                	beqz	a5,22f4 <schedule_dm+0x1b8>
            r.scheduled_thread_list_member = &smallest_id_thread->thread_list;
    22dc:	fb043783          	ld	a5,-80(s0)
    22e0:	02878793          	addi	a5,a5,40
    22e4:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = smallest_id_thread->remaining_time;
    22e8:	fb043783          	ld	a5,-80(s0)
    22ec:	4fbc                	lw	a5,88(a5)
    22ee:	f6f42823          	sw	a5,-144(s0)
    22f2:	a839                	j	2310 <schedule_dm+0x1d4>
        } else {
            // If no thread is ready, perhaps idle or find the next release time
            r.scheduled_thread_list_member = args.run_queue;
    22f4:	649c                	ld	a5,8(s1)
    22f6:	f6f43423          	sd	a5,-152(s0)
            r.allocated_time = find_next_release_time(args.release_queue, args.current_time);
    22fa:	689c                	ld	a5,16(s1)
    22fc:	4098                	lw	a4,0(s1)
    22fe:	85ba                	mv	a1,a4
    2300:	853e                	mv	a0,a5
    2302:	00000097          	auipc	ra,0x0
    2306:	c5c080e7          	jalr	-932(ra) # 1f5e <find_next_release_time>
    230a:	87aa                	mv	a5,a0
    230c:	f6f42823          	sw	a5,-144(s0)
        }
    }

    return r;
    2310:	f6843783          	ld	a5,-152(s0)
    2314:	f6f43c23          	sd	a5,-136(s0)
    2318:	f7043783          	ld	a5,-144(s0)
    231c:	f8f43023          	sd	a5,-128(s0)
    2320:	4701                	li	a4,0
    2322:	f7843703          	ld	a4,-136(s0)
    2326:	4781                	li	a5,0
    2328:	f8043783          	ld	a5,-128(s0)
    232c:	893a                	mv	s2,a4
    232e:	89be                	mv	s3,a5
    2330:	874a                	mv	a4,s2
    2332:	87ce                	mv	a5,s3
}
    2334:	853a                	mv	a0,a4
    2336:	85be                	mv	a1,a5
    2338:	60ea                	ld	ra,152(sp)
    233a:	644a                	ld	s0,144(sp)
    233c:	64aa                	ld	s1,136(sp)
    233e:	690a                	ld	s2,128(sp)
    2340:	79e6                	ld	s3,120(sp)
    2342:	610d                	addi	sp,sp,160
    2344:	8082                	ret
