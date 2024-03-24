
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	1141                	addi	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	addi	s0,sp,16
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       6:	611c                	ld	a5,0(a0)
       8:	80000737          	lui	a4,0x80000
       c:	ffe74713          	xori	a4,a4,-2
      10:	02e7f7b3          	remu	a5,a5,a4
      14:	0785                	addi	a5,a5,1
    hi = x / 127773;
    lo = x % 127773;
      16:	66fd                	lui	a3,0x1f
      18:	31d68693          	addi	a3,a3,797 # 1f31d <__global_pointer$+0x1d454>
      1c:	02d7e733          	rem	a4,a5,a3
    x = 16807 * lo - 2836 * hi;
      20:	6611                	lui	a2,0x4
      22:	1a760613          	addi	a2,a2,423 # 41a7 <__global_pointer$+0x22de>
      26:	02c70733          	mul	a4,a4,a2
    hi = x / 127773;
      2a:	02d7c7b3          	div	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      2e:	76fd                	lui	a3,0xfffff
      30:	4ec68693          	addi	a3,a3,1260 # fffffffffffff4ec <__global_pointer$+0xffffffffffffd623>
      34:	02d787b3          	mul	a5,a5,a3
      38:	97ba                	add	a5,a5,a4
    if (x < 0)
      3a:	0007c963          	bltz	a5,4c <do_rand+0x4c>
        x += 0x7fffffff;
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
      3e:	17fd                	addi	a5,a5,-1
    *ctx = x;
      40:	e11c                	sd	a5,0(a0)
    return (x);
}
      42:	0007851b          	sext.w	a0,a5
      46:	6422                	ld	s0,8(sp)
      48:	0141                	addi	sp,sp,16
      4a:	8082                	ret
        x += 0x7fffffff;
      4c:	80000737          	lui	a4,0x80000
      50:	fff74713          	not	a4,a4
      54:	97ba                	add	a5,a5,a4
      56:	b7e5                	j	3e <do_rand+0x3e>

0000000000000058 <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
      58:	1141                	addi	sp,sp,-16
      5a:	e406                	sd	ra,8(sp)
      5c:	e022                	sd	s0,0(sp)
      5e:	0800                	addi	s0,sp,16
    return (do_rand(&rand_next));
      60:	00001517          	auipc	a0,0x1
      64:	67050513          	addi	a0,a0,1648 # 16d0 <rand_next>
      68:	00000097          	auipc	ra,0x0
      6c:	f98080e7          	jalr	-104(ra) # 0 <do_rand>
}
      70:	60a2                	ld	ra,8(sp)
      72:	6402                	ld	s0,0(sp)
      74:	0141                	addi	sp,sp,16
      76:	8082                	ret

0000000000000078 <go>:

void
go(int which_child)
{
      78:	7159                	addi	sp,sp,-112
      7a:	f486                	sd	ra,104(sp)
      7c:	f0a2                	sd	s0,96(sp)
      7e:	eca6                	sd	s1,88(sp)
      80:	e8ca                	sd	s2,80(sp)
      82:	e4ce                	sd	s3,72(sp)
      84:	e0d2                	sd	s4,64(sp)
      86:	fc56                	sd	s5,56(sp)
      88:	f85a                	sd	s6,48(sp)
      8a:	1880                	addi	s0,sp,112
      8c:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      8e:	4501                	li	a0,0
      90:	00001097          	auipc	ra,0x1
      94:	e74080e7          	jalr	-396(ra) # f04 <sbrk>
      98:	8aaa                	mv	s5,a0
  uint64 iters = 0;

  mkdir("grindir");
      9a:	00001517          	auipc	a0,0x1
      9e:	32e50513          	addi	a0,a0,814 # 13c8 <malloc+0xea>
      a2:	00001097          	auipc	ra,0x1
      a6:	e42080e7          	jalr	-446(ra) # ee4 <mkdir>
  if(chdir("grindir") != 0){
      aa:	00001517          	auipc	a0,0x1
      ae:	31e50513          	addi	a0,a0,798 # 13c8 <malloc+0xea>
      b2:	00001097          	auipc	ra,0x1
      b6:	e3a080e7          	jalr	-454(ra) # eec <chdir>
      ba:	cd11                	beqz	a0,d6 <go+0x5e>
    printf("grind: chdir grindir failed\n");
      bc:	00001517          	auipc	a0,0x1
      c0:	31450513          	addi	a0,a0,788 # 13d0 <malloc+0xf2>
      c4:	00001097          	auipc	ra,0x1
      c8:	15c080e7          	jalr	348(ra) # 1220 <printf>
    exit(1);
      cc:	4505                	li	a0,1
      ce:	00001097          	auipc	ra,0x1
      d2:	dae080e7          	jalr	-594(ra) # e7c <exit>
  }
  chdir("/");
      d6:	00001517          	auipc	a0,0x1
      da:	31a50513          	addi	a0,a0,794 # 13f0 <malloc+0x112>
      de:	00001097          	auipc	ra,0x1
      e2:	e0e080e7          	jalr	-498(ra) # eec <chdir>
  
  while(1){
    iters++;
    if((iters % 500) == 0)
      e6:	00001997          	auipc	s3,0x1
      ea:	31a98993          	addi	s3,s3,794 # 1400 <malloc+0x122>
      ee:	c489                	beqz	s1,f8 <go+0x80>
      f0:	00001997          	auipc	s3,0x1
      f4:	30898993          	addi	s3,s3,776 # 13f8 <malloc+0x11a>
    iters++;
      f8:	4485                	li	s1,1
  int fd = -1;
      fa:	597d                	li	s2,-1
      close(fd);
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
    } else if(what == 7){
      write(fd, buf, sizeof(buf));
    } else if(what == 8){
      read(fd, buf, sizeof(buf));
      fc:	00001a17          	auipc	s4,0x1
     100:	5e4a0a13          	addi	s4,s4,1508 # 16e0 <buf.1255>
     104:	a825                	j	13c <go+0xc4>
      close(open("grindir/../a", O_CREATE|O_RDWR));
     106:	20200593          	li	a1,514
     10a:	00001517          	auipc	a0,0x1
     10e:	2fe50513          	addi	a0,a0,766 # 1408 <malloc+0x12a>
     112:	00001097          	auipc	ra,0x1
     116:	daa080e7          	jalr	-598(ra) # ebc <open>
     11a:	00001097          	auipc	ra,0x1
     11e:	d8a080e7          	jalr	-630(ra) # ea4 <close>
    iters++;
     122:	0485                	addi	s1,s1,1
    if((iters % 500) == 0)
     124:	1f400793          	li	a5,500
     128:	02f4f7b3          	remu	a5,s1,a5
     12c:	eb81                	bnez	a5,13c <go+0xc4>
      write(1, which_child?"B":"A", 1);
     12e:	4605                	li	a2,1
     130:	85ce                	mv	a1,s3
     132:	4505                	li	a0,1
     134:	00001097          	auipc	ra,0x1
     138:	d68080e7          	jalr	-664(ra) # e9c <write>
    int what = rand() % 23;
     13c:	00000097          	auipc	ra,0x0
     140:	f1c080e7          	jalr	-228(ra) # 58 <rand>
     144:	47dd                	li	a5,23
     146:	02f5653b          	remw	a0,a0,a5
    if(what == 1){
     14a:	4785                	li	a5,1
     14c:	faf50de3          	beq	a0,a5,106 <go+0x8e>
    } else if(what == 2){
     150:	4789                	li	a5,2
     152:	18f50563          	beq	a0,a5,2dc <go+0x264>
    } else if(what == 3){
     156:	478d                	li	a5,3
     158:	1af50163          	beq	a0,a5,2fa <go+0x282>
    } else if(what == 4){
     15c:	4791                	li	a5,4
     15e:	1af50763          	beq	a0,a5,30c <go+0x294>
    } else if(what == 5){
     162:	4795                	li	a5,5
     164:	1ef50b63          	beq	a0,a5,35a <go+0x2e2>
    } else if(what == 6){
     168:	4799                	li	a5,6
     16a:	20f50963          	beq	a0,a5,37c <go+0x304>
    } else if(what == 7){
     16e:	479d                	li	a5,7
     170:	22f50763          	beq	a0,a5,39e <go+0x326>
    } else if(what == 8){
     174:	47a1                	li	a5,8
     176:	22f50d63          	beq	a0,a5,3b0 <go+0x338>
    } else if(what == 9){
     17a:	47a5                	li	a5,9
     17c:	24f50363          	beq	a0,a5,3c2 <go+0x34a>
      mkdir("grindir/../a");
      close(open("a/../a/./a", O_CREATE|O_RDWR));
      unlink("a/a");
    } else if(what == 10){
     180:	47a9                	li	a5,10
     182:	26f50f63          	beq	a0,a5,400 <go+0x388>
      mkdir("/../b");
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
      unlink("b/b");
    } else if(what == 11){
     186:	47ad                	li	a5,11
     188:	2af50b63          	beq	a0,a5,43e <go+0x3c6>
      unlink("b");
      link("../grindir/./../a", "../b");
    } else if(what == 12){
     18c:	47b1                	li	a5,12
     18e:	2cf50d63          	beq	a0,a5,468 <go+0x3f0>
      unlink("../grindir/../a");
      link(".././b", "/grindir/../a");
    } else if(what == 13){
     192:	47b5                	li	a5,13
     194:	2ef50f63          	beq	a0,a5,492 <go+0x41a>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
    } else if(what == 14){
     198:	47b9                	li	a5,14
     19a:	32f50a63          	beq	a0,a5,4ce <go+0x456>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
    } else if(what == 15){
     19e:	47bd                	li	a5,15
     1a0:	36f50e63          	beq	a0,a5,51c <go+0x4a4>
      sbrk(6011);
    } else if(what == 16){
     1a4:	47c1                	li	a5,16
     1a6:	38f50363          	beq	a0,a5,52c <go+0x4b4>
      if(sbrk(0) > break0)
        sbrk(-(sbrk(0) - break0));
    } else if(what == 17){
     1aa:	47c5                	li	a5,17
     1ac:	3af50363          	beq	a0,a5,552 <go+0x4da>
        printf("grind: chdir failed\n");
        exit(1);
      }
      kill(pid);
      wait(0);
    } else if(what == 18){
     1b0:	47c9                	li	a5,18
     1b2:	42f50963          	beq	a0,a5,5e4 <go+0x56c>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
    } else if(what == 19){
     1b6:	47cd                	li	a5,19
     1b8:	46f50d63          	beq	a0,a5,632 <go+0x5ba>
        exit(1);
      }
      close(fds[0]);
      close(fds[1]);
      wait(0);
    } else if(what == 20){
     1bc:	47d1                	li	a5,20
     1be:	54f50e63          	beq	a0,a5,71a <go+0x6a2>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
    } else if(what == 21){
     1c2:	47d5                	li	a5,21
     1c4:	5ef50c63          	beq	a0,a5,7bc <go+0x744>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
        exit(1);
      }
      close(fd1);
      unlink("c");
    } else if(what == 22){
     1c8:	47d9                	li	a5,22
     1ca:	f4f51ce3          	bne	a0,a5,122 <go+0xaa>
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     1ce:	f9840513          	addi	a0,s0,-104
     1d2:	00001097          	auipc	ra,0x1
     1d6:	cba080e7          	jalr	-838(ra) # e8c <pipe>
     1da:	6e054563          	bltz	a0,8c4 <go+0x84c>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     1de:	fa040513          	addi	a0,s0,-96
     1e2:	00001097          	auipc	ra,0x1
     1e6:	caa080e7          	jalr	-854(ra) # e8c <pipe>
     1ea:	6e054b63          	bltz	a0,8e0 <go+0x868>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     1ee:	00001097          	auipc	ra,0x1
     1f2:	c86080e7          	jalr	-890(ra) # e74 <fork>
      if(pid1 == 0){
     1f6:	70050363          	beqz	a0,8fc <go+0x884>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
     1fa:	7a054b63          	bltz	a0,9b0 <go+0x938>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
     1fe:	00001097          	auipc	ra,0x1
     202:	c76080e7          	jalr	-906(ra) # e74 <fork>
      if(pid2 == 0){
     206:	7c050363          	beqz	a0,9cc <go+0x954>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
     20a:	08054fe3          	bltz	a0,aa8 <go+0xa30>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
     20e:	f9842503          	lw	a0,-104(s0)
     212:	00001097          	auipc	ra,0x1
     216:	c92080e7          	jalr	-878(ra) # ea4 <close>
      close(aa[1]);
     21a:	f9c42503          	lw	a0,-100(s0)
     21e:	00001097          	auipc	ra,0x1
     222:	c86080e7          	jalr	-890(ra) # ea4 <close>
      close(bb[1]);
     226:	fa442503          	lw	a0,-92(s0)
     22a:	00001097          	auipc	ra,0x1
     22e:	c7a080e7          	jalr	-902(ra) # ea4 <close>
      char buf[4] = { 0, 0, 0, 0 };
     232:	f8042823          	sw	zero,-112(s0)
      read(bb[0], buf+0, 1);
     236:	4605                	li	a2,1
     238:	f9040593          	addi	a1,s0,-112
     23c:	fa042503          	lw	a0,-96(s0)
     240:	00001097          	auipc	ra,0x1
     244:	c54080e7          	jalr	-940(ra) # e94 <read>
      read(bb[0], buf+1, 1);
     248:	4605                	li	a2,1
     24a:	f9140593          	addi	a1,s0,-111
     24e:	fa042503          	lw	a0,-96(s0)
     252:	00001097          	auipc	ra,0x1
     256:	c42080e7          	jalr	-958(ra) # e94 <read>
      read(bb[0], buf+2, 1);
     25a:	4605                	li	a2,1
     25c:	f9240593          	addi	a1,s0,-110
     260:	fa042503          	lw	a0,-96(s0)
     264:	00001097          	auipc	ra,0x1
     268:	c30080e7          	jalr	-976(ra) # e94 <read>
      close(bb[0]);
     26c:	fa042503          	lw	a0,-96(s0)
     270:	00001097          	auipc	ra,0x1
     274:	c34080e7          	jalr	-972(ra) # ea4 <close>
      int st1, st2;
      wait(&st1);
     278:	f9440513          	addi	a0,s0,-108
     27c:	00001097          	auipc	ra,0x1
     280:	c08080e7          	jalr	-1016(ra) # e84 <wait>
      wait(&st2);
     284:	fa840513          	addi	a0,s0,-88
     288:	00001097          	auipc	ra,0x1
     28c:	bfc080e7          	jalr	-1028(ra) # e84 <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     290:	f9442783          	lw	a5,-108(s0)
     294:	fa842703          	lw	a4,-88(s0)
     298:	8fd9                	or	a5,a5,a4
     29a:	2781                	sext.w	a5,a5
     29c:	ef89                	bnez	a5,2b6 <go+0x23e>
     29e:	00001597          	auipc	a1,0x1
     2a2:	3e258593          	addi	a1,a1,994 # 1680 <malloc+0x3a2>
     2a6:	f9040513          	addi	a0,s0,-112
     2aa:	00001097          	auipc	ra,0x1
     2ae:	962080e7          	jalr	-1694(ra) # c0c <strcmp>
     2b2:	e60508e3          	beqz	a0,122 <go+0xaa>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     2b6:	f9040693          	addi	a3,s0,-112
     2ba:	fa842603          	lw	a2,-88(s0)
     2be:	f9442583          	lw	a1,-108(s0)
     2c2:	00001517          	auipc	a0,0x1
     2c6:	3c650513          	addi	a0,a0,966 # 1688 <malloc+0x3aa>
     2ca:	00001097          	auipc	ra,0x1
     2ce:	f56080e7          	jalr	-170(ra) # 1220 <printf>
        exit(1);
     2d2:	4505                	li	a0,1
     2d4:	00001097          	auipc	ra,0x1
     2d8:	ba8080e7          	jalr	-1112(ra) # e7c <exit>
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     2dc:	20200593          	li	a1,514
     2e0:	00001517          	auipc	a0,0x1
     2e4:	13850513          	addi	a0,a0,312 # 1418 <malloc+0x13a>
     2e8:	00001097          	auipc	ra,0x1
     2ec:	bd4080e7          	jalr	-1068(ra) # ebc <open>
     2f0:	00001097          	auipc	ra,0x1
     2f4:	bb4080e7          	jalr	-1100(ra) # ea4 <close>
     2f8:	b52d                	j	122 <go+0xaa>
      unlink("grindir/../a");
     2fa:	00001517          	auipc	a0,0x1
     2fe:	10e50513          	addi	a0,a0,270 # 1408 <malloc+0x12a>
     302:	00001097          	auipc	ra,0x1
     306:	bca080e7          	jalr	-1078(ra) # ecc <unlink>
     30a:	bd21                	j	122 <go+0xaa>
      if(chdir("grindir") != 0){
     30c:	00001517          	auipc	a0,0x1
     310:	0bc50513          	addi	a0,a0,188 # 13c8 <malloc+0xea>
     314:	00001097          	auipc	ra,0x1
     318:	bd8080e7          	jalr	-1064(ra) # eec <chdir>
     31c:	e115                	bnez	a0,340 <go+0x2c8>
      unlink("../b");
     31e:	00001517          	auipc	a0,0x1
     322:	11250513          	addi	a0,a0,274 # 1430 <malloc+0x152>
     326:	00001097          	auipc	ra,0x1
     32a:	ba6080e7          	jalr	-1114(ra) # ecc <unlink>
      chdir("/");
     32e:	00001517          	auipc	a0,0x1
     332:	0c250513          	addi	a0,a0,194 # 13f0 <malloc+0x112>
     336:	00001097          	auipc	ra,0x1
     33a:	bb6080e7          	jalr	-1098(ra) # eec <chdir>
     33e:	b3d5                	j	122 <go+0xaa>
        printf("grind: chdir grindir failed\n");
     340:	00001517          	auipc	a0,0x1
     344:	09050513          	addi	a0,a0,144 # 13d0 <malloc+0xf2>
     348:	00001097          	auipc	ra,0x1
     34c:	ed8080e7          	jalr	-296(ra) # 1220 <printf>
        exit(1);
     350:	4505                	li	a0,1
     352:	00001097          	auipc	ra,0x1
     356:	b2a080e7          	jalr	-1238(ra) # e7c <exit>
      close(fd);
     35a:	854a                	mv	a0,s2
     35c:	00001097          	auipc	ra,0x1
     360:	b48080e7          	jalr	-1208(ra) # ea4 <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     364:	20200593          	li	a1,514
     368:	00001517          	auipc	a0,0x1
     36c:	0d050513          	addi	a0,a0,208 # 1438 <malloc+0x15a>
     370:	00001097          	auipc	ra,0x1
     374:	b4c080e7          	jalr	-1204(ra) # ebc <open>
     378:	892a                	mv	s2,a0
     37a:	b365                	j	122 <go+0xaa>
      close(fd);
     37c:	854a                	mv	a0,s2
     37e:	00001097          	auipc	ra,0x1
     382:	b26080e7          	jalr	-1242(ra) # ea4 <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     386:	20200593          	li	a1,514
     38a:	00001517          	auipc	a0,0x1
     38e:	0be50513          	addi	a0,a0,190 # 1448 <malloc+0x16a>
     392:	00001097          	auipc	ra,0x1
     396:	b2a080e7          	jalr	-1238(ra) # ebc <open>
     39a:	892a                	mv	s2,a0
     39c:	b359                	j	122 <go+0xaa>
      write(fd, buf, sizeof(buf));
     39e:	3e700613          	li	a2,999
     3a2:	85d2                	mv	a1,s4
     3a4:	854a                	mv	a0,s2
     3a6:	00001097          	auipc	ra,0x1
     3aa:	af6080e7          	jalr	-1290(ra) # e9c <write>
     3ae:	bb95                	j	122 <go+0xaa>
      read(fd, buf, sizeof(buf));
     3b0:	3e700613          	li	a2,999
     3b4:	85d2                	mv	a1,s4
     3b6:	854a                	mv	a0,s2
     3b8:	00001097          	auipc	ra,0x1
     3bc:	adc080e7          	jalr	-1316(ra) # e94 <read>
     3c0:	b38d                	j	122 <go+0xaa>
      mkdir("grindir/../a");
     3c2:	00001517          	auipc	a0,0x1
     3c6:	04650513          	addi	a0,a0,70 # 1408 <malloc+0x12a>
     3ca:	00001097          	auipc	ra,0x1
     3ce:	b1a080e7          	jalr	-1254(ra) # ee4 <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     3d2:	20200593          	li	a1,514
     3d6:	00001517          	auipc	a0,0x1
     3da:	08a50513          	addi	a0,a0,138 # 1460 <malloc+0x182>
     3de:	00001097          	auipc	ra,0x1
     3e2:	ade080e7          	jalr	-1314(ra) # ebc <open>
     3e6:	00001097          	auipc	ra,0x1
     3ea:	abe080e7          	jalr	-1346(ra) # ea4 <close>
      unlink("a/a");
     3ee:	00001517          	auipc	a0,0x1
     3f2:	08250513          	addi	a0,a0,130 # 1470 <malloc+0x192>
     3f6:	00001097          	auipc	ra,0x1
     3fa:	ad6080e7          	jalr	-1322(ra) # ecc <unlink>
     3fe:	b315                	j	122 <go+0xaa>
      mkdir("/../b");
     400:	00001517          	auipc	a0,0x1
     404:	07850513          	addi	a0,a0,120 # 1478 <malloc+0x19a>
     408:	00001097          	auipc	ra,0x1
     40c:	adc080e7          	jalr	-1316(ra) # ee4 <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     410:	20200593          	li	a1,514
     414:	00001517          	auipc	a0,0x1
     418:	06c50513          	addi	a0,a0,108 # 1480 <malloc+0x1a2>
     41c:	00001097          	auipc	ra,0x1
     420:	aa0080e7          	jalr	-1376(ra) # ebc <open>
     424:	00001097          	auipc	ra,0x1
     428:	a80080e7          	jalr	-1408(ra) # ea4 <close>
      unlink("b/b");
     42c:	00001517          	auipc	a0,0x1
     430:	06450513          	addi	a0,a0,100 # 1490 <malloc+0x1b2>
     434:	00001097          	auipc	ra,0x1
     438:	a98080e7          	jalr	-1384(ra) # ecc <unlink>
     43c:	b1dd                	j	122 <go+0xaa>
      unlink("b");
     43e:	00001517          	auipc	a0,0x1
     442:	01a50513          	addi	a0,a0,26 # 1458 <malloc+0x17a>
     446:	00001097          	auipc	ra,0x1
     44a:	a86080e7          	jalr	-1402(ra) # ecc <unlink>
      link("../grindir/./../a", "../b");
     44e:	00001597          	auipc	a1,0x1
     452:	fe258593          	addi	a1,a1,-30 # 1430 <malloc+0x152>
     456:	00001517          	auipc	a0,0x1
     45a:	04250513          	addi	a0,a0,66 # 1498 <malloc+0x1ba>
     45e:	00001097          	auipc	ra,0x1
     462:	a7e080e7          	jalr	-1410(ra) # edc <link>
     466:	b975                	j	122 <go+0xaa>
      unlink("../grindir/../a");
     468:	00001517          	auipc	a0,0x1
     46c:	04850513          	addi	a0,a0,72 # 14b0 <malloc+0x1d2>
     470:	00001097          	auipc	ra,0x1
     474:	a5c080e7          	jalr	-1444(ra) # ecc <unlink>
      link(".././b", "/grindir/../a");
     478:	00001597          	auipc	a1,0x1
     47c:	fc058593          	addi	a1,a1,-64 # 1438 <malloc+0x15a>
     480:	00001517          	auipc	a0,0x1
     484:	04050513          	addi	a0,a0,64 # 14c0 <malloc+0x1e2>
     488:	00001097          	auipc	ra,0x1
     48c:	a54080e7          	jalr	-1452(ra) # edc <link>
     490:	b949                	j	122 <go+0xaa>
      int pid = fork();
     492:	00001097          	auipc	ra,0x1
     496:	9e2080e7          	jalr	-1566(ra) # e74 <fork>
      if(pid == 0){
     49a:	c909                	beqz	a0,4ac <go+0x434>
      } else if(pid < 0){
     49c:	00054c63          	bltz	a0,4b4 <go+0x43c>
      wait(0);
     4a0:	4501                	li	a0,0
     4a2:	00001097          	auipc	ra,0x1
     4a6:	9e2080e7          	jalr	-1566(ra) # e84 <wait>
     4aa:	b9a5                	j	122 <go+0xaa>
        exit(0);
     4ac:	00001097          	auipc	ra,0x1
     4b0:	9d0080e7          	jalr	-1584(ra) # e7c <exit>
        printf("grind: fork failed\n");
     4b4:	00001517          	auipc	a0,0x1
     4b8:	01450513          	addi	a0,a0,20 # 14c8 <malloc+0x1ea>
     4bc:	00001097          	auipc	ra,0x1
     4c0:	d64080e7          	jalr	-668(ra) # 1220 <printf>
        exit(1);
     4c4:	4505                	li	a0,1
     4c6:	00001097          	auipc	ra,0x1
     4ca:	9b6080e7          	jalr	-1610(ra) # e7c <exit>
      int pid = fork();
     4ce:	00001097          	auipc	ra,0x1
     4d2:	9a6080e7          	jalr	-1626(ra) # e74 <fork>
      if(pid == 0){
     4d6:	c909                	beqz	a0,4e8 <go+0x470>
      } else if(pid < 0){
     4d8:	02054563          	bltz	a0,502 <go+0x48a>
      wait(0);
     4dc:	4501                	li	a0,0
     4de:	00001097          	auipc	ra,0x1
     4e2:	9a6080e7          	jalr	-1626(ra) # e84 <wait>
     4e6:	b935                	j	122 <go+0xaa>
        fork();
     4e8:	00001097          	auipc	ra,0x1
     4ec:	98c080e7          	jalr	-1652(ra) # e74 <fork>
        fork();
     4f0:	00001097          	auipc	ra,0x1
     4f4:	984080e7          	jalr	-1660(ra) # e74 <fork>
        exit(0);
     4f8:	4501                	li	a0,0
     4fa:	00001097          	auipc	ra,0x1
     4fe:	982080e7          	jalr	-1662(ra) # e7c <exit>
        printf("grind: fork failed\n");
     502:	00001517          	auipc	a0,0x1
     506:	fc650513          	addi	a0,a0,-58 # 14c8 <malloc+0x1ea>
     50a:	00001097          	auipc	ra,0x1
     50e:	d16080e7          	jalr	-746(ra) # 1220 <printf>
        exit(1);
     512:	4505                	li	a0,1
     514:	00001097          	auipc	ra,0x1
     518:	968080e7          	jalr	-1688(ra) # e7c <exit>
      sbrk(6011);
     51c:	6505                	lui	a0,0x1
     51e:	77b50513          	addi	a0,a0,1915 # 177b <buf.1255+0x9b>
     522:	00001097          	auipc	ra,0x1
     526:	9e2080e7          	jalr	-1566(ra) # f04 <sbrk>
     52a:	bee5                	j	122 <go+0xaa>
      if(sbrk(0) > break0)
     52c:	4501                	li	a0,0
     52e:	00001097          	auipc	ra,0x1
     532:	9d6080e7          	jalr	-1578(ra) # f04 <sbrk>
     536:	beaaf6e3          	bgeu	s5,a0,122 <go+0xaa>
        sbrk(-(sbrk(0) - break0));
     53a:	4501                	li	a0,0
     53c:	00001097          	auipc	ra,0x1
     540:	9c8080e7          	jalr	-1592(ra) # f04 <sbrk>
     544:	40aa853b          	subw	a0,s5,a0
     548:	00001097          	auipc	ra,0x1
     54c:	9bc080e7          	jalr	-1604(ra) # f04 <sbrk>
     550:	bec9                	j	122 <go+0xaa>
      int pid = fork();
     552:	00001097          	auipc	ra,0x1
     556:	922080e7          	jalr	-1758(ra) # e74 <fork>
     55a:	8b2a                	mv	s6,a0
      if(pid == 0){
     55c:	c51d                	beqz	a0,58a <go+0x512>
      } else if(pid < 0){
     55e:	04054963          	bltz	a0,5b0 <go+0x538>
      if(chdir("../grindir/..") != 0){
     562:	00001517          	auipc	a0,0x1
     566:	f7e50513          	addi	a0,a0,-130 # 14e0 <malloc+0x202>
     56a:	00001097          	auipc	ra,0x1
     56e:	982080e7          	jalr	-1662(ra) # eec <chdir>
     572:	ed21                	bnez	a0,5ca <go+0x552>
      kill(pid);
     574:	855a                	mv	a0,s6
     576:	00001097          	auipc	ra,0x1
     57a:	936080e7          	jalr	-1738(ra) # eac <kill>
      wait(0);
     57e:	4501                	li	a0,0
     580:	00001097          	auipc	ra,0x1
     584:	904080e7          	jalr	-1788(ra) # e84 <wait>
     588:	be69                	j	122 <go+0xaa>
        close(open("a", O_CREATE|O_RDWR));
     58a:	20200593          	li	a1,514
     58e:	00001517          	auipc	a0,0x1
     592:	f1a50513          	addi	a0,a0,-230 # 14a8 <malloc+0x1ca>
     596:	00001097          	auipc	ra,0x1
     59a:	926080e7          	jalr	-1754(ra) # ebc <open>
     59e:	00001097          	auipc	ra,0x1
     5a2:	906080e7          	jalr	-1786(ra) # ea4 <close>
        exit(0);
     5a6:	4501                	li	a0,0
     5a8:	00001097          	auipc	ra,0x1
     5ac:	8d4080e7          	jalr	-1836(ra) # e7c <exit>
        printf("grind: fork failed\n");
     5b0:	00001517          	auipc	a0,0x1
     5b4:	f1850513          	addi	a0,a0,-232 # 14c8 <malloc+0x1ea>
     5b8:	00001097          	auipc	ra,0x1
     5bc:	c68080e7          	jalr	-920(ra) # 1220 <printf>
        exit(1);
     5c0:	4505                	li	a0,1
     5c2:	00001097          	auipc	ra,0x1
     5c6:	8ba080e7          	jalr	-1862(ra) # e7c <exit>
        printf("grind: chdir failed\n");
     5ca:	00001517          	auipc	a0,0x1
     5ce:	f2650513          	addi	a0,a0,-218 # 14f0 <malloc+0x212>
     5d2:	00001097          	auipc	ra,0x1
     5d6:	c4e080e7          	jalr	-946(ra) # 1220 <printf>
        exit(1);
     5da:	4505                	li	a0,1
     5dc:	00001097          	auipc	ra,0x1
     5e0:	8a0080e7          	jalr	-1888(ra) # e7c <exit>
      int pid = fork();
     5e4:	00001097          	auipc	ra,0x1
     5e8:	890080e7          	jalr	-1904(ra) # e74 <fork>
      if(pid == 0){
     5ec:	c909                	beqz	a0,5fe <go+0x586>
      } else if(pid < 0){
     5ee:	02054563          	bltz	a0,618 <go+0x5a0>
      wait(0);
     5f2:	4501                	li	a0,0
     5f4:	00001097          	auipc	ra,0x1
     5f8:	890080e7          	jalr	-1904(ra) # e84 <wait>
     5fc:	b61d                	j	122 <go+0xaa>
        kill(getpid());
     5fe:	00001097          	auipc	ra,0x1
     602:	8fe080e7          	jalr	-1794(ra) # efc <getpid>
     606:	00001097          	auipc	ra,0x1
     60a:	8a6080e7          	jalr	-1882(ra) # eac <kill>
        exit(0);
     60e:	4501                	li	a0,0
     610:	00001097          	auipc	ra,0x1
     614:	86c080e7          	jalr	-1940(ra) # e7c <exit>
        printf("grind: fork failed\n");
     618:	00001517          	auipc	a0,0x1
     61c:	eb050513          	addi	a0,a0,-336 # 14c8 <malloc+0x1ea>
     620:	00001097          	auipc	ra,0x1
     624:	c00080e7          	jalr	-1024(ra) # 1220 <printf>
        exit(1);
     628:	4505                	li	a0,1
     62a:	00001097          	auipc	ra,0x1
     62e:	852080e7          	jalr	-1966(ra) # e7c <exit>
      if(pipe(fds) < 0){
     632:	fa840513          	addi	a0,s0,-88
     636:	00001097          	auipc	ra,0x1
     63a:	856080e7          	jalr	-1962(ra) # e8c <pipe>
     63e:	02054b63          	bltz	a0,674 <go+0x5fc>
      int pid = fork();
     642:	00001097          	auipc	ra,0x1
     646:	832080e7          	jalr	-1998(ra) # e74 <fork>
      if(pid == 0){
     64a:	c131                	beqz	a0,68e <go+0x616>
      } else if(pid < 0){
     64c:	0a054a63          	bltz	a0,700 <go+0x688>
      close(fds[0]);
     650:	fa842503          	lw	a0,-88(s0)
     654:	00001097          	auipc	ra,0x1
     658:	850080e7          	jalr	-1968(ra) # ea4 <close>
      close(fds[1]);
     65c:	fac42503          	lw	a0,-84(s0)
     660:	00001097          	auipc	ra,0x1
     664:	844080e7          	jalr	-1980(ra) # ea4 <close>
      wait(0);
     668:	4501                	li	a0,0
     66a:	00001097          	auipc	ra,0x1
     66e:	81a080e7          	jalr	-2022(ra) # e84 <wait>
     672:	bc45                	j	122 <go+0xaa>
        printf("grind: pipe failed\n");
     674:	00001517          	auipc	a0,0x1
     678:	e9450513          	addi	a0,a0,-364 # 1508 <malloc+0x22a>
     67c:	00001097          	auipc	ra,0x1
     680:	ba4080e7          	jalr	-1116(ra) # 1220 <printf>
        exit(1);
     684:	4505                	li	a0,1
     686:	00000097          	auipc	ra,0x0
     68a:	7f6080e7          	jalr	2038(ra) # e7c <exit>
        fork();
     68e:	00000097          	auipc	ra,0x0
     692:	7e6080e7          	jalr	2022(ra) # e74 <fork>
        fork();
     696:	00000097          	auipc	ra,0x0
     69a:	7de080e7          	jalr	2014(ra) # e74 <fork>
        if(write(fds[1], "x", 1) != 1)
     69e:	4605                	li	a2,1
     6a0:	00001597          	auipc	a1,0x1
     6a4:	e8058593          	addi	a1,a1,-384 # 1520 <malloc+0x242>
     6a8:	fac42503          	lw	a0,-84(s0)
     6ac:	00000097          	auipc	ra,0x0
     6b0:	7f0080e7          	jalr	2032(ra) # e9c <write>
     6b4:	4785                	li	a5,1
     6b6:	02f51363          	bne	a0,a5,6dc <go+0x664>
        if(read(fds[0], &c, 1) != 1)
     6ba:	4605                	li	a2,1
     6bc:	fa040593          	addi	a1,s0,-96
     6c0:	fa842503          	lw	a0,-88(s0)
     6c4:	00000097          	auipc	ra,0x0
     6c8:	7d0080e7          	jalr	2000(ra) # e94 <read>
     6cc:	4785                	li	a5,1
     6ce:	02f51063          	bne	a0,a5,6ee <go+0x676>
        exit(0);
     6d2:	4501                	li	a0,0
     6d4:	00000097          	auipc	ra,0x0
     6d8:	7a8080e7          	jalr	1960(ra) # e7c <exit>
          printf("grind: pipe write failed\n");
     6dc:	00001517          	auipc	a0,0x1
     6e0:	e4c50513          	addi	a0,a0,-436 # 1528 <malloc+0x24a>
     6e4:	00001097          	auipc	ra,0x1
     6e8:	b3c080e7          	jalr	-1220(ra) # 1220 <printf>
     6ec:	b7f9                	j	6ba <go+0x642>
          printf("grind: pipe read failed\n");
     6ee:	00001517          	auipc	a0,0x1
     6f2:	e5a50513          	addi	a0,a0,-422 # 1548 <malloc+0x26a>
     6f6:	00001097          	auipc	ra,0x1
     6fa:	b2a080e7          	jalr	-1238(ra) # 1220 <printf>
     6fe:	bfd1                	j	6d2 <go+0x65a>
        printf("grind: fork failed\n");
     700:	00001517          	auipc	a0,0x1
     704:	dc850513          	addi	a0,a0,-568 # 14c8 <malloc+0x1ea>
     708:	00001097          	auipc	ra,0x1
     70c:	b18080e7          	jalr	-1256(ra) # 1220 <printf>
        exit(1);
     710:	4505                	li	a0,1
     712:	00000097          	auipc	ra,0x0
     716:	76a080e7          	jalr	1898(ra) # e7c <exit>
      int pid = fork();
     71a:	00000097          	auipc	ra,0x0
     71e:	75a080e7          	jalr	1882(ra) # e74 <fork>
      if(pid == 0){
     722:	c909                	beqz	a0,734 <go+0x6bc>
      } else if(pid < 0){
     724:	06054f63          	bltz	a0,7a2 <go+0x72a>
      wait(0);
     728:	4501                	li	a0,0
     72a:	00000097          	auipc	ra,0x0
     72e:	75a080e7          	jalr	1882(ra) # e84 <wait>
     732:	bac5                	j	122 <go+0xaa>
        unlink("a");
     734:	00001517          	auipc	a0,0x1
     738:	d7450513          	addi	a0,a0,-652 # 14a8 <malloc+0x1ca>
     73c:	00000097          	auipc	ra,0x0
     740:	790080e7          	jalr	1936(ra) # ecc <unlink>
        mkdir("a");
     744:	00001517          	auipc	a0,0x1
     748:	d6450513          	addi	a0,a0,-668 # 14a8 <malloc+0x1ca>
     74c:	00000097          	auipc	ra,0x0
     750:	798080e7          	jalr	1944(ra) # ee4 <mkdir>
        chdir("a");
     754:	00001517          	auipc	a0,0x1
     758:	d5450513          	addi	a0,a0,-684 # 14a8 <malloc+0x1ca>
     75c:	00000097          	auipc	ra,0x0
     760:	790080e7          	jalr	1936(ra) # eec <chdir>
        unlink("../a");
     764:	00001517          	auipc	a0,0x1
     768:	cac50513          	addi	a0,a0,-852 # 1410 <malloc+0x132>
     76c:	00000097          	auipc	ra,0x0
     770:	760080e7          	jalr	1888(ra) # ecc <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     774:	20200593          	li	a1,514
     778:	00001517          	auipc	a0,0x1
     77c:	da850513          	addi	a0,a0,-600 # 1520 <malloc+0x242>
     780:	00000097          	auipc	ra,0x0
     784:	73c080e7          	jalr	1852(ra) # ebc <open>
        unlink("x");
     788:	00001517          	auipc	a0,0x1
     78c:	d9850513          	addi	a0,a0,-616 # 1520 <malloc+0x242>
     790:	00000097          	auipc	ra,0x0
     794:	73c080e7          	jalr	1852(ra) # ecc <unlink>
        exit(0);
     798:	4501                	li	a0,0
     79a:	00000097          	auipc	ra,0x0
     79e:	6e2080e7          	jalr	1762(ra) # e7c <exit>
        printf("grind: fork failed\n");
     7a2:	00001517          	auipc	a0,0x1
     7a6:	d2650513          	addi	a0,a0,-730 # 14c8 <malloc+0x1ea>
     7aa:	00001097          	auipc	ra,0x1
     7ae:	a76080e7          	jalr	-1418(ra) # 1220 <printf>
        exit(1);
     7b2:	4505                	li	a0,1
     7b4:	00000097          	auipc	ra,0x0
     7b8:	6c8080e7          	jalr	1736(ra) # e7c <exit>
      unlink("c");
     7bc:	00001517          	auipc	a0,0x1
     7c0:	dac50513          	addi	a0,a0,-596 # 1568 <malloc+0x28a>
     7c4:	00000097          	auipc	ra,0x0
     7c8:	708080e7          	jalr	1800(ra) # ecc <unlink>
      int fd1 = open("c", O_CREATE|O_RDWR);
     7cc:	20200593          	li	a1,514
     7d0:	00001517          	auipc	a0,0x1
     7d4:	d9850513          	addi	a0,a0,-616 # 1568 <malloc+0x28a>
     7d8:	00000097          	auipc	ra,0x0
     7dc:	6e4080e7          	jalr	1764(ra) # ebc <open>
     7e0:	8b2a                	mv	s6,a0
      if(fd1 < 0){
     7e2:	04054f63          	bltz	a0,840 <go+0x7c8>
      if(write(fd1, "x", 1) != 1){
     7e6:	4605                	li	a2,1
     7e8:	00001597          	auipc	a1,0x1
     7ec:	d3858593          	addi	a1,a1,-712 # 1520 <malloc+0x242>
     7f0:	00000097          	auipc	ra,0x0
     7f4:	6ac080e7          	jalr	1708(ra) # e9c <write>
     7f8:	4785                	li	a5,1
     7fa:	06f51063          	bne	a0,a5,85a <go+0x7e2>
      if(fstat(fd1, &st) != 0){
     7fe:	fa840593          	addi	a1,s0,-88
     802:	855a                	mv	a0,s6
     804:	00000097          	auipc	ra,0x0
     808:	6d0080e7          	jalr	1744(ra) # ed4 <fstat>
     80c:	e525                	bnez	a0,874 <go+0x7fc>
      if(st.size != 1){
     80e:	fb843583          	ld	a1,-72(s0)
     812:	4785                	li	a5,1
     814:	06f59d63          	bne	a1,a5,88e <go+0x816>
      if(st.ino > 200){
     818:	fac42583          	lw	a1,-84(s0)
     81c:	0c800793          	li	a5,200
     820:	08b7e563          	bltu	a5,a1,8aa <go+0x832>
      close(fd1);
     824:	855a                	mv	a0,s6
     826:	00000097          	auipc	ra,0x0
     82a:	67e080e7          	jalr	1662(ra) # ea4 <close>
      unlink("c");
     82e:	00001517          	auipc	a0,0x1
     832:	d3a50513          	addi	a0,a0,-710 # 1568 <malloc+0x28a>
     836:	00000097          	auipc	ra,0x0
     83a:	696080e7          	jalr	1686(ra) # ecc <unlink>
     83e:	b0d5                	j	122 <go+0xaa>
        printf("grind: create c failed\n");
     840:	00001517          	auipc	a0,0x1
     844:	d3050513          	addi	a0,a0,-720 # 1570 <malloc+0x292>
     848:	00001097          	auipc	ra,0x1
     84c:	9d8080e7          	jalr	-1576(ra) # 1220 <printf>
        exit(1);
     850:	4505                	li	a0,1
     852:	00000097          	auipc	ra,0x0
     856:	62a080e7          	jalr	1578(ra) # e7c <exit>
        printf("grind: write c failed\n");
     85a:	00001517          	auipc	a0,0x1
     85e:	d2e50513          	addi	a0,a0,-722 # 1588 <malloc+0x2aa>
     862:	00001097          	auipc	ra,0x1
     866:	9be080e7          	jalr	-1602(ra) # 1220 <printf>
        exit(1);
     86a:	4505                	li	a0,1
     86c:	00000097          	auipc	ra,0x0
     870:	610080e7          	jalr	1552(ra) # e7c <exit>
        printf("grind: fstat failed\n");
     874:	00001517          	auipc	a0,0x1
     878:	d2c50513          	addi	a0,a0,-724 # 15a0 <malloc+0x2c2>
     87c:	00001097          	auipc	ra,0x1
     880:	9a4080e7          	jalr	-1628(ra) # 1220 <printf>
        exit(1);
     884:	4505                	li	a0,1
     886:	00000097          	auipc	ra,0x0
     88a:	5f6080e7          	jalr	1526(ra) # e7c <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     88e:	2581                	sext.w	a1,a1
     890:	00001517          	auipc	a0,0x1
     894:	d2850513          	addi	a0,a0,-728 # 15b8 <malloc+0x2da>
     898:	00001097          	auipc	ra,0x1
     89c:	988080e7          	jalr	-1656(ra) # 1220 <printf>
        exit(1);
     8a0:	4505                	li	a0,1
     8a2:	00000097          	auipc	ra,0x0
     8a6:	5da080e7          	jalr	1498(ra) # e7c <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     8aa:	00001517          	auipc	a0,0x1
     8ae:	d3650513          	addi	a0,a0,-714 # 15e0 <malloc+0x302>
     8b2:	00001097          	auipc	ra,0x1
     8b6:	96e080e7          	jalr	-1682(ra) # 1220 <printf>
        exit(1);
     8ba:	4505                	li	a0,1
     8bc:	00000097          	auipc	ra,0x0
     8c0:	5c0080e7          	jalr	1472(ra) # e7c <exit>
        fprintf(2, "grind: pipe failed\n");
     8c4:	00001597          	auipc	a1,0x1
     8c8:	c4458593          	addi	a1,a1,-956 # 1508 <malloc+0x22a>
     8cc:	4509                	li	a0,2
     8ce:	00001097          	auipc	ra,0x1
     8d2:	924080e7          	jalr	-1756(ra) # 11f2 <fprintf>
        exit(1);
     8d6:	4505                	li	a0,1
     8d8:	00000097          	auipc	ra,0x0
     8dc:	5a4080e7          	jalr	1444(ra) # e7c <exit>
        fprintf(2, "grind: pipe failed\n");
     8e0:	00001597          	auipc	a1,0x1
     8e4:	c2858593          	addi	a1,a1,-984 # 1508 <malloc+0x22a>
     8e8:	4509                	li	a0,2
     8ea:	00001097          	auipc	ra,0x1
     8ee:	908080e7          	jalr	-1784(ra) # 11f2 <fprintf>
        exit(1);
     8f2:	4505                	li	a0,1
     8f4:	00000097          	auipc	ra,0x0
     8f8:	588080e7          	jalr	1416(ra) # e7c <exit>
        close(bb[0]);
     8fc:	fa042503          	lw	a0,-96(s0)
     900:	00000097          	auipc	ra,0x0
     904:	5a4080e7          	jalr	1444(ra) # ea4 <close>
        close(bb[1]);
     908:	fa442503          	lw	a0,-92(s0)
     90c:	00000097          	auipc	ra,0x0
     910:	598080e7          	jalr	1432(ra) # ea4 <close>
        close(aa[0]);
     914:	f9842503          	lw	a0,-104(s0)
     918:	00000097          	auipc	ra,0x0
     91c:	58c080e7          	jalr	1420(ra) # ea4 <close>
        close(1);
     920:	4505                	li	a0,1
     922:	00000097          	auipc	ra,0x0
     926:	582080e7          	jalr	1410(ra) # ea4 <close>
        if(dup(aa[1]) != 1){
     92a:	f9c42503          	lw	a0,-100(s0)
     92e:	00000097          	auipc	ra,0x0
     932:	5c6080e7          	jalr	1478(ra) # ef4 <dup>
     936:	4785                	li	a5,1
     938:	02f50063          	beq	a0,a5,958 <go+0x8e0>
          fprintf(2, "grind: dup failed\n");
     93c:	00001597          	auipc	a1,0x1
     940:	ccc58593          	addi	a1,a1,-820 # 1608 <malloc+0x32a>
     944:	4509                	li	a0,2
     946:	00001097          	auipc	ra,0x1
     94a:	8ac080e7          	jalr	-1876(ra) # 11f2 <fprintf>
          exit(1);
     94e:	4505                	li	a0,1
     950:	00000097          	auipc	ra,0x0
     954:	52c080e7          	jalr	1324(ra) # e7c <exit>
        close(aa[1]);
     958:	f9c42503          	lw	a0,-100(s0)
     95c:	00000097          	auipc	ra,0x0
     960:	548080e7          	jalr	1352(ra) # ea4 <close>
        char *args[3] = { "echo", "hi", 0 };
     964:	00001797          	auipc	a5,0x1
     968:	cbc78793          	addi	a5,a5,-836 # 1620 <malloc+0x342>
     96c:	faf43423          	sd	a5,-88(s0)
     970:	00001797          	auipc	a5,0x1
     974:	cb878793          	addi	a5,a5,-840 # 1628 <malloc+0x34a>
     978:	faf43823          	sd	a5,-80(s0)
     97c:	fa043c23          	sd	zero,-72(s0)
        exec("grindir/../echo", args);
     980:	fa840593          	addi	a1,s0,-88
     984:	00001517          	auipc	a0,0x1
     988:	cac50513          	addi	a0,a0,-852 # 1630 <malloc+0x352>
     98c:	00000097          	auipc	ra,0x0
     990:	528080e7          	jalr	1320(ra) # eb4 <exec>
        fprintf(2, "grind: echo: not found\n");
     994:	00001597          	auipc	a1,0x1
     998:	cac58593          	addi	a1,a1,-852 # 1640 <malloc+0x362>
     99c:	4509                	li	a0,2
     99e:	00001097          	auipc	ra,0x1
     9a2:	854080e7          	jalr	-1964(ra) # 11f2 <fprintf>
        exit(2);
     9a6:	4509                	li	a0,2
     9a8:	00000097          	auipc	ra,0x0
     9ac:	4d4080e7          	jalr	1236(ra) # e7c <exit>
        fprintf(2, "grind: fork failed\n");
     9b0:	00001597          	auipc	a1,0x1
     9b4:	b1858593          	addi	a1,a1,-1256 # 14c8 <malloc+0x1ea>
     9b8:	4509                	li	a0,2
     9ba:	00001097          	auipc	ra,0x1
     9be:	838080e7          	jalr	-1992(ra) # 11f2 <fprintf>
        exit(3);
     9c2:	450d                	li	a0,3
     9c4:	00000097          	auipc	ra,0x0
     9c8:	4b8080e7          	jalr	1208(ra) # e7c <exit>
        close(aa[1]);
     9cc:	f9c42503          	lw	a0,-100(s0)
     9d0:	00000097          	auipc	ra,0x0
     9d4:	4d4080e7          	jalr	1236(ra) # ea4 <close>
        close(bb[0]);
     9d8:	fa042503          	lw	a0,-96(s0)
     9dc:	00000097          	auipc	ra,0x0
     9e0:	4c8080e7          	jalr	1224(ra) # ea4 <close>
        close(0);
     9e4:	4501                	li	a0,0
     9e6:	00000097          	auipc	ra,0x0
     9ea:	4be080e7          	jalr	1214(ra) # ea4 <close>
        if(dup(aa[0]) != 0){
     9ee:	f9842503          	lw	a0,-104(s0)
     9f2:	00000097          	auipc	ra,0x0
     9f6:	502080e7          	jalr	1282(ra) # ef4 <dup>
     9fa:	cd19                	beqz	a0,a18 <go+0x9a0>
          fprintf(2, "grind: dup failed\n");
     9fc:	00001597          	auipc	a1,0x1
     a00:	c0c58593          	addi	a1,a1,-1012 # 1608 <malloc+0x32a>
     a04:	4509                	li	a0,2
     a06:	00000097          	auipc	ra,0x0
     a0a:	7ec080e7          	jalr	2028(ra) # 11f2 <fprintf>
          exit(4);
     a0e:	4511                	li	a0,4
     a10:	00000097          	auipc	ra,0x0
     a14:	46c080e7          	jalr	1132(ra) # e7c <exit>
        close(aa[0]);
     a18:	f9842503          	lw	a0,-104(s0)
     a1c:	00000097          	auipc	ra,0x0
     a20:	488080e7          	jalr	1160(ra) # ea4 <close>
        close(1);
     a24:	4505                	li	a0,1
     a26:	00000097          	auipc	ra,0x0
     a2a:	47e080e7          	jalr	1150(ra) # ea4 <close>
        if(dup(bb[1]) != 1){
     a2e:	fa442503          	lw	a0,-92(s0)
     a32:	00000097          	auipc	ra,0x0
     a36:	4c2080e7          	jalr	1218(ra) # ef4 <dup>
     a3a:	4785                	li	a5,1
     a3c:	02f50063          	beq	a0,a5,a5c <go+0x9e4>
          fprintf(2, "grind: dup failed\n");
     a40:	00001597          	auipc	a1,0x1
     a44:	bc858593          	addi	a1,a1,-1080 # 1608 <malloc+0x32a>
     a48:	4509                	li	a0,2
     a4a:	00000097          	auipc	ra,0x0
     a4e:	7a8080e7          	jalr	1960(ra) # 11f2 <fprintf>
          exit(5);
     a52:	4515                	li	a0,5
     a54:	00000097          	auipc	ra,0x0
     a58:	428080e7          	jalr	1064(ra) # e7c <exit>
        close(bb[1]);
     a5c:	fa442503          	lw	a0,-92(s0)
     a60:	00000097          	auipc	ra,0x0
     a64:	444080e7          	jalr	1092(ra) # ea4 <close>
        char *args[2] = { "cat", 0 };
     a68:	00001797          	auipc	a5,0x1
     a6c:	bf078793          	addi	a5,a5,-1040 # 1658 <malloc+0x37a>
     a70:	faf43423          	sd	a5,-88(s0)
     a74:	fa043823          	sd	zero,-80(s0)
        exec("/cat", args);
     a78:	fa840593          	addi	a1,s0,-88
     a7c:	00001517          	auipc	a0,0x1
     a80:	be450513          	addi	a0,a0,-1052 # 1660 <malloc+0x382>
     a84:	00000097          	auipc	ra,0x0
     a88:	430080e7          	jalr	1072(ra) # eb4 <exec>
        fprintf(2, "grind: cat: not found\n");
     a8c:	00001597          	auipc	a1,0x1
     a90:	bdc58593          	addi	a1,a1,-1060 # 1668 <malloc+0x38a>
     a94:	4509                	li	a0,2
     a96:	00000097          	auipc	ra,0x0
     a9a:	75c080e7          	jalr	1884(ra) # 11f2 <fprintf>
        exit(6);
     a9e:	4519                	li	a0,6
     aa0:	00000097          	auipc	ra,0x0
     aa4:	3dc080e7          	jalr	988(ra) # e7c <exit>
        fprintf(2, "grind: fork failed\n");
     aa8:	00001597          	auipc	a1,0x1
     aac:	a2058593          	addi	a1,a1,-1504 # 14c8 <malloc+0x1ea>
     ab0:	4509                	li	a0,2
     ab2:	00000097          	auipc	ra,0x0
     ab6:	740080e7          	jalr	1856(ra) # 11f2 <fprintf>
        exit(7);
     aba:	451d                	li	a0,7
     abc:	00000097          	auipc	ra,0x0
     ac0:	3c0080e7          	jalr	960(ra) # e7c <exit>

0000000000000ac4 <iter>:
  }
}

void
iter()
{
     ac4:	7179                	addi	sp,sp,-48
     ac6:	f406                	sd	ra,40(sp)
     ac8:	f022                	sd	s0,32(sp)
     aca:	ec26                	sd	s1,24(sp)
     acc:	e84a                	sd	s2,16(sp)
     ace:	1800                	addi	s0,sp,48
  unlink("a");
     ad0:	00001517          	auipc	a0,0x1
     ad4:	9d850513          	addi	a0,a0,-1576 # 14a8 <malloc+0x1ca>
     ad8:	00000097          	auipc	ra,0x0
     adc:	3f4080e7          	jalr	1012(ra) # ecc <unlink>
  unlink("b");
     ae0:	00001517          	auipc	a0,0x1
     ae4:	97850513          	addi	a0,a0,-1672 # 1458 <malloc+0x17a>
     ae8:	00000097          	auipc	ra,0x0
     aec:	3e4080e7          	jalr	996(ra) # ecc <unlink>
  
  int pid1 = fork();
     af0:	00000097          	auipc	ra,0x0
     af4:	384080e7          	jalr	900(ra) # e74 <fork>
  if(pid1 < 0){
     af8:	00054e63          	bltz	a0,b14 <iter+0x50>
     afc:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
     afe:	e905                	bnez	a0,b2e <iter+0x6a>
    rand_next = 31;
     b00:	47fd                	li	a5,31
     b02:	00001717          	auipc	a4,0x1
     b06:	bcf73723          	sd	a5,-1074(a4) # 16d0 <rand_next>
    go(0);
     b0a:	4501                	li	a0,0
     b0c:	fffff097          	auipc	ra,0xfffff
     b10:	56c080e7          	jalr	1388(ra) # 78 <go>
    printf("grind: fork failed\n");
     b14:	00001517          	auipc	a0,0x1
     b18:	9b450513          	addi	a0,a0,-1612 # 14c8 <malloc+0x1ea>
     b1c:	00000097          	auipc	ra,0x0
     b20:	704080e7          	jalr	1796(ra) # 1220 <printf>
    exit(1);
     b24:	4505                	li	a0,1
     b26:	00000097          	auipc	ra,0x0
     b2a:	356080e7          	jalr	854(ra) # e7c <exit>
    exit(0);
  }

  int pid2 = fork();
     b2e:	00000097          	auipc	ra,0x0
     b32:	346080e7          	jalr	838(ra) # e74 <fork>
     b36:	892a                	mv	s2,a0
  if(pid2 < 0){
     b38:	00054f63          	bltz	a0,b56 <iter+0x92>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
     b3c:	e915                	bnez	a0,b70 <iter+0xac>
    rand_next = 7177;
     b3e:	6789                	lui	a5,0x2
     b40:	c0978793          	addi	a5,a5,-1015 # 1c09 <__BSS_END__+0x131>
     b44:	00001717          	auipc	a4,0x1
     b48:	b8f73623          	sd	a5,-1140(a4) # 16d0 <rand_next>
    go(1);
     b4c:	4505                	li	a0,1
     b4e:	fffff097          	auipc	ra,0xfffff
     b52:	52a080e7          	jalr	1322(ra) # 78 <go>
    printf("grind: fork failed\n");
     b56:	00001517          	auipc	a0,0x1
     b5a:	97250513          	addi	a0,a0,-1678 # 14c8 <malloc+0x1ea>
     b5e:	00000097          	auipc	ra,0x0
     b62:	6c2080e7          	jalr	1730(ra) # 1220 <printf>
    exit(1);
     b66:	4505                	li	a0,1
     b68:	00000097          	auipc	ra,0x0
     b6c:	314080e7          	jalr	788(ra) # e7c <exit>
    exit(0);
  }

  int st1 = -1;
     b70:	57fd                	li	a5,-1
     b72:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     b76:	fdc40513          	addi	a0,s0,-36
     b7a:	00000097          	auipc	ra,0x0
     b7e:	30a080e7          	jalr	778(ra) # e84 <wait>
  if(st1 != 0){
     b82:	fdc42783          	lw	a5,-36(s0)
     b86:	ef99                	bnez	a5,ba4 <iter+0xe0>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     b88:	57fd                	li	a5,-1
     b8a:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2);
     b8e:	fd840513          	addi	a0,s0,-40
     b92:	00000097          	auipc	ra,0x0
     b96:	2f2080e7          	jalr	754(ra) # e84 <wait>

  exit(0);
     b9a:	4501                	li	a0,0
     b9c:	00000097          	auipc	ra,0x0
     ba0:	2e0080e7          	jalr	736(ra) # e7c <exit>
    kill(pid1);
     ba4:	8526                	mv	a0,s1
     ba6:	00000097          	auipc	ra,0x0
     baa:	306080e7          	jalr	774(ra) # eac <kill>
    kill(pid2);
     bae:	854a                	mv	a0,s2
     bb0:	00000097          	auipc	ra,0x0
     bb4:	2fc080e7          	jalr	764(ra) # eac <kill>
     bb8:	bfc1                	j	b88 <iter+0xc4>

0000000000000bba <main>:
}

int
main()
{
     bba:	1141                	addi	sp,sp,-16
     bbc:	e406                	sd	ra,8(sp)
     bbe:	e022                	sd	s0,0(sp)
     bc0:	0800                	addi	s0,sp,16
     bc2:	a811                	j	bd6 <main+0x1c>
  while(1){
    int pid = fork();
    if(pid == 0){
      iter();
     bc4:	00000097          	auipc	ra,0x0
     bc8:	f00080e7          	jalr	-256(ra) # ac4 <iter>
      exit(0);
    }
    if(pid > 0){
      wait(0);
    }
    sleep(20);
     bcc:	4551                	li	a0,20
     bce:	00000097          	auipc	ra,0x0
     bd2:	33e080e7          	jalr	830(ra) # f0c <sleep>
    int pid = fork();
     bd6:	00000097          	auipc	ra,0x0
     bda:	29e080e7          	jalr	670(ra) # e74 <fork>
    if(pid == 0){
     bde:	d17d                	beqz	a0,bc4 <main+0xa>
    if(pid > 0){
     be0:	fea056e3          	blez	a0,bcc <main+0x12>
      wait(0);
     be4:	4501                	li	a0,0
     be6:	00000097          	auipc	ra,0x0
     bea:	29e080e7          	jalr	670(ra) # e84 <wait>
     bee:	bff9                	j	bcc <main+0x12>

0000000000000bf0 <strcpy>:



char*
strcpy(char *s, const char *t)
{
     bf0:	1141                	addi	sp,sp,-16
     bf2:	e422                	sd	s0,8(sp)
     bf4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     bf6:	87aa                	mv	a5,a0
     bf8:	0585                	addi	a1,a1,1
     bfa:	0785                	addi	a5,a5,1
     bfc:	fff5c703          	lbu	a4,-1(a1)
     c00:	fee78fa3          	sb	a4,-1(a5)
     c04:	fb75                	bnez	a4,bf8 <strcpy+0x8>
    ;
  return os;
}
     c06:	6422                	ld	s0,8(sp)
     c08:	0141                	addi	sp,sp,16
     c0a:	8082                	ret

0000000000000c0c <strcmp>:

int
strcmp(const char *p, const char *q)
{
     c0c:	1141                	addi	sp,sp,-16
     c0e:	e422                	sd	s0,8(sp)
     c10:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     c12:	00054783          	lbu	a5,0(a0)
     c16:	cb91                	beqz	a5,c2a <strcmp+0x1e>
     c18:	0005c703          	lbu	a4,0(a1)
     c1c:	00f71763          	bne	a4,a5,c2a <strcmp+0x1e>
    p++, q++;
     c20:	0505                	addi	a0,a0,1
     c22:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     c24:	00054783          	lbu	a5,0(a0)
     c28:	fbe5                	bnez	a5,c18 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     c2a:	0005c503          	lbu	a0,0(a1)
}
     c2e:	40a7853b          	subw	a0,a5,a0
     c32:	6422                	ld	s0,8(sp)
     c34:	0141                	addi	sp,sp,16
     c36:	8082                	ret

0000000000000c38 <strlen>:

uint
strlen(const char *s)
{
     c38:	1141                	addi	sp,sp,-16
     c3a:	e422                	sd	s0,8(sp)
     c3c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     c3e:	00054783          	lbu	a5,0(a0)
     c42:	cf91                	beqz	a5,c5e <strlen+0x26>
     c44:	0505                	addi	a0,a0,1
     c46:	87aa                	mv	a5,a0
     c48:	4685                	li	a3,1
     c4a:	9e89                	subw	a3,a3,a0
     c4c:	00f6853b          	addw	a0,a3,a5
     c50:	0785                	addi	a5,a5,1
     c52:	fff7c703          	lbu	a4,-1(a5)
     c56:	fb7d                	bnez	a4,c4c <strlen+0x14>
    ;
  return n;
}
     c58:	6422                	ld	s0,8(sp)
     c5a:	0141                	addi	sp,sp,16
     c5c:	8082                	ret
  for(n = 0; s[n]; n++)
     c5e:	4501                	li	a0,0
     c60:	bfe5                	j	c58 <strlen+0x20>

0000000000000c62 <memset>:

void*
memset(void *dst, int c, uint n)
{
     c62:	1141                	addi	sp,sp,-16
     c64:	e422                	sd	s0,8(sp)
     c66:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     c68:	ce09                	beqz	a2,c82 <memset+0x20>
     c6a:	87aa                	mv	a5,a0
     c6c:	fff6071b          	addiw	a4,a2,-1
     c70:	1702                	slli	a4,a4,0x20
     c72:	9301                	srli	a4,a4,0x20
     c74:	0705                	addi	a4,a4,1
     c76:	972a                	add	a4,a4,a0
    cdst[i] = c;
     c78:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     c7c:	0785                	addi	a5,a5,1
     c7e:	fee79de3          	bne	a5,a4,c78 <memset+0x16>
  }
  return dst;
}
     c82:	6422                	ld	s0,8(sp)
     c84:	0141                	addi	sp,sp,16
     c86:	8082                	ret

0000000000000c88 <strchr>:

char*
strchr(const char *s, char c)
{
     c88:	1141                	addi	sp,sp,-16
     c8a:	e422                	sd	s0,8(sp)
     c8c:	0800                	addi	s0,sp,16
  for(; *s; s++)
     c8e:	00054783          	lbu	a5,0(a0)
     c92:	cb99                	beqz	a5,ca8 <strchr+0x20>
    if(*s == c)
     c94:	00f58763          	beq	a1,a5,ca2 <strchr+0x1a>
  for(; *s; s++)
     c98:	0505                	addi	a0,a0,1
     c9a:	00054783          	lbu	a5,0(a0)
     c9e:	fbfd                	bnez	a5,c94 <strchr+0xc>
      return (char*)s;
  return 0;
     ca0:	4501                	li	a0,0
}
     ca2:	6422                	ld	s0,8(sp)
     ca4:	0141                	addi	sp,sp,16
     ca6:	8082                	ret
  return 0;
     ca8:	4501                	li	a0,0
     caa:	bfe5                	j	ca2 <strchr+0x1a>

0000000000000cac <gets>:

char*
gets(char *buf, int max)
{
     cac:	711d                	addi	sp,sp,-96
     cae:	ec86                	sd	ra,88(sp)
     cb0:	e8a2                	sd	s0,80(sp)
     cb2:	e4a6                	sd	s1,72(sp)
     cb4:	e0ca                	sd	s2,64(sp)
     cb6:	fc4e                	sd	s3,56(sp)
     cb8:	f852                	sd	s4,48(sp)
     cba:	f456                	sd	s5,40(sp)
     cbc:	f05a                	sd	s6,32(sp)
     cbe:	ec5e                	sd	s7,24(sp)
     cc0:	1080                	addi	s0,sp,96
     cc2:	8baa                	mv	s7,a0
     cc4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     cc6:	892a                	mv	s2,a0
     cc8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     cca:	4aa9                	li	s5,10
     ccc:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     cce:	89a6                	mv	s3,s1
     cd0:	2485                	addiw	s1,s1,1
     cd2:	0344d863          	bge	s1,s4,d02 <gets+0x56>
    cc = read(0, &c, 1);
     cd6:	4605                	li	a2,1
     cd8:	faf40593          	addi	a1,s0,-81
     cdc:	4501                	li	a0,0
     cde:	00000097          	auipc	ra,0x0
     ce2:	1b6080e7          	jalr	438(ra) # e94 <read>
    if(cc < 1)
     ce6:	00a05e63          	blez	a0,d02 <gets+0x56>
    buf[i++] = c;
     cea:	faf44783          	lbu	a5,-81(s0)
     cee:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     cf2:	01578763          	beq	a5,s5,d00 <gets+0x54>
     cf6:	0905                	addi	s2,s2,1
     cf8:	fd679be3          	bne	a5,s6,cce <gets+0x22>
  for(i=0; i+1 < max; ){
     cfc:	89a6                	mv	s3,s1
     cfe:	a011                	j	d02 <gets+0x56>
     d00:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     d02:	99de                	add	s3,s3,s7
     d04:	00098023          	sb	zero,0(s3)
  return buf;
}
     d08:	855e                	mv	a0,s7
     d0a:	60e6                	ld	ra,88(sp)
     d0c:	6446                	ld	s0,80(sp)
     d0e:	64a6                	ld	s1,72(sp)
     d10:	6906                	ld	s2,64(sp)
     d12:	79e2                	ld	s3,56(sp)
     d14:	7a42                	ld	s4,48(sp)
     d16:	7aa2                	ld	s5,40(sp)
     d18:	7b02                	ld	s6,32(sp)
     d1a:	6be2                	ld	s7,24(sp)
     d1c:	6125                	addi	sp,sp,96
     d1e:	8082                	ret

0000000000000d20 <stat>:

int
stat(const char *n, struct stat *st)
{
     d20:	1101                	addi	sp,sp,-32
     d22:	ec06                	sd	ra,24(sp)
     d24:	e822                	sd	s0,16(sp)
     d26:	e426                	sd	s1,8(sp)
     d28:	e04a                	sd	s2,0(sp)
     d2a:	1000                	addi	s0,sp,32
     d2c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     d2e:	4581                	li	a1,0
     d30:	00000097          	auipc	ra,0x0
     d34:	18c080e7          	jalr	396(ra) # ebc <open>
  if(fd < 0)
     d38:	02054563          	bltz	a0,d62 <stat+0x42>
     d3c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     d3e:	85ca                	mv	a1,s2
     d40:	00000097          	auipc	ra,0x0
     d44:	194080e7          	jalr	404(ra) # ed4 <fstat>
     d48:	892a                	mv	s2,a0
  close(fd);
     d4a:	8526                	mv	a0,s1
     d4c:	00000097          	auipc	ra,0x0
     d50:	158080e7          	jalr	344(ra) # ea4 <close>
  return r;
}
     d54:	854a                	mv	a0,s2
     d56:	60e2                	ld	ra,24(sp)
     d58:	6442                	ld	s0,16(sp)
     d5a:	64a2                	ld	s1,8(sp)
     d5c:	6902                	ld	s2,0(sp)
     d5e:	6105                	addi	sp,sp,32
     d60:	8082                	ret
    return -1;
     d62:	597d                	li	s2,-1
     d64:	bfc5                	j	d54 <stat+0x34>

0000000000000d66 <atoi>:

int
atoi(const char *s)
{
     d66:	1141                	addi	sp,sp,-16
     d68:	e422                	sd	s0,8(sp)
     d6a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     d6c:	00054603          	lbu	a2,0(a0)
     d70:	fd06079b          	addiw	a5,a2,-48
     d74:	0ff7f793          	andi	a5,a5,255
     d78:	4725                	li	a4,9
     d7a:	02f76963          	bltu	a4,a5,dac <atoi+0x46>
     d7e:	86aa                	mv	a3,a0
  n = 0;
     d80:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
     d82:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
     d84:	0685                	addi	a3,a3,1
     d86:	0025179b          	slliw	a5,a0,0x2
     d8a:	9fa9                	addw	a5,a5,a0
     d8c:	0017979b          	slliw	a5,a5,0x1
     d90:	9fb1                	addw	a5,a5,a2
     d92:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     d96:	0006c603          	lbu	a2,0(a3)
     d9a:	fd06071b          	addiw	a4,a2,-48
     d9e:	0ff77713          	andi	a4,a4,255
     da2:	fee5f1e3          	bgeu	a1,a4,d84 <atoi+0x1e>
  return n;
}
     da6:	6422                	ld	s0,8(sp)
     da8:	0141                	addi	sp,sp,16
     daa:	8082                	ret
  n = 0;
     dac:	4501                	li	a0,0
     dae:	bfe5                	j	da6 <atoi+0x40>

0000000000000db0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     db0:	1141                	addi	sp,sp,-16
     db2:	e422                	sd	s0,8(sp)
     db4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     db6:	02b57663          	bgeu	a0,a1,de2 <memmove+0x32>
    while(n-- > 0)
     dba:	02c05163          	blez	a2,ddc <memmove+0x2c>
     dbe:	fff6079b          	addiw	a5,a2,-1
     dc2:	1782                	slli	a5,a5,0x20
     dc4:	9381                	srli	a5,a5,0x20
     dc6:	0785                	addi	a5,a5,1
     dc8:	97aa                	add	a5,a5,a0
  dst = vdst;
     dca:	872a                	mv	a4,a0
      *dst++ = *src++;
     dcc:	0585                	addi	a1,a1,1
     dce:	0705                	addi	a4,a4,1
     dd0:	fff5c683          	lbu	a3,-1(a1)
     dd4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     dd8:	fee79ae3          	bne	a5,a4,dcc <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     ddc:	6422                	ld	s0,8(sp)
     dde:	0141                	addi	sp,sp,16
     de0:	8082                	ret
    dst += n;
     de2:	00c50733          	add	a4,a0,a2
    src += n;
     de6:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     de8:	fec05ae3          	blez	a2,ddc <memmove+0x2c>
     dec:	fff6079b          	addiw	a5,a2,-1
     df0:	1782                	slli	a5,a5,0x20
     df2:	9381                	srli	a5,a5,0x20
     df4:	fff7c793          	not	a5,a5
     df8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     dfa:	15fd                	addi	a1,a1,-1
     dfc:	177d                	addi	a4,a4,-1
     dfe:	0005c683          	lbu	a3,0(a1)
     e02:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     e06:	fee79ae3          	bne	a5,a4,dfa <memmove+0x4a>
     e0a:	bfc9                	j	ddc <memmove+0x2c>

0000000000000e0c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     e0c:	1141                	addi	sp,sp,-16
     e0e:	e422                	sd	s0,8(sp)
     e10:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     e12:	ca05                	beqz	a2,e42 <memcmp+0x36>
     e14:	fff6069b          	addiw	a3,a2,-1
     e18:	1682                	slli	a3,a3,0x20
     e1a:	9281                	srli	a3,a3,0x20
     e1c:	0685                	addi	a3,a3,1
     e1e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     e20:	00054783          	lbu	a5,0(a0)
     e24:	0005c703          	lbu	a4,0(a1)
     e28:	00e79863          	bne	a5,a4,e38 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     e2c:	0505                	addi	a0,a0,1
    p2++;
     e2e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     e30:	fed518e3          	bne	a0,a3,e20 <memcmp+0x14>
  }
  return 0;
     e34:	4501                	li	a0,0
     e36:	a019                	j	e3c <memcmp+0x30>
      return *p1 - *p2;
     e38:	40e7853b          	subw	a0,a5,a4
}
     e3c:	6422                	ld	s0,8(sp)
     e3e:	0141                	addi	sp,sp,16
     e40:	8082                	ret
  return 0;
     e42:	4501                	li	a0,0
     e44:	bfe5                	j	e3c <memcmp+0x30>

0000000000000e46 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     e46:	1141                	addi	sp,sp,-16
     e48:	e406                	sd	ra,8(sp)
     e4a:	e022                	sd	s0,0(sp)
     e4c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     e4e:	00000097          	auipc	ra,0x0
     e52:	f62080e7          	jalr	-158(ra) # db0 <memmove>
}
     e56:	60a2                	ld	ra,8(sp)
     e58:	6402                	ld	s0,0(sp)
     e5a:	0141                	addi	sp,sp,16
     e5c:	8082                	ret

0000000000000e5e <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
     e5e:	1141                	addi	sp,sp,-16
     e60:	e422                	sd	s0,8(sp)
     e62:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
     e64:	040007b7          	lui	a5,0x4000
}
     e68:	17f5                	addi	a5,a5,-3
     e6a:	07b2                	slli	a5,a5,0xc
     e6c:	4388                	lw	a0,0(a5)
     e6e:	6422                	ld	s0,8(sp)
     e70:	0141                	addi	sp,sp,16
     e72:	8082                	ret

0000000000000e74 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     e74:	4885                	li	a7,1
 ecall
     e76:	00000073          	ecall
 ret
     e7a:	8082                	ret

0000000000000e7c <exit>:
.global exit
exit:
 li a7, SYS_exit
     e7c:	4889                	li	a7,2
 ecall
     e7e:	00000073          	ecall
 ret
     e82:	8082                	ret

0000000000000e84 <wait>:
.global wait
wait:
 li a7, SYS_wait
     e84:	488d                	li	a7,3
 ecall
     e86:	00000073          	ecall
 ret
     e8a:	8082                	ret

0000000000000e8c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     e8c:	4891                	li	a7,4
 ecall
     e8e:	00000073          	ecall
 ret
     e92:	8082                	ret

0000000000000e94 <read>:
.global read
read:
 li a7, SYS_read
     e94:	4895                	li	a7,5
 ecall
     e96:	00000073          	ecall
 ret
     e9a:	8082                	ret

0000000000000e9c <write>:
.global write
write:
 li a7, SYS_write
     e9c:	48c1                	li	a7,16
 ecall
     e9e:	00000073          	ecall
 ret
     ea2:	8082                	ret

0000000000000ea4 <close>:
.global close
close:
 li a7, SYS_close
     ea4:	48d5                	li	a7,21
 ecall
     ea6:	00000073          	ecall
 ret
     eaa:	8082                	ret

0000000000000eac <kill>:
.global kill
kill:
 li a7, SYS_kill
     eac:	4899                	li	a7,6
 ecall
     eae:	00000073          	ecall
 ret
     eb2:	8082                	ret

0000000000000eb4 <exec>:
.global exec
exec:
 li a7, SYS_exec
     eb4:	489d                	li	a7,7
 ecall
     eb6:	00000073          	ecall
 ret
     eba:	8082                	ret

0000000000000ebc <open>:
.global open
open:
 li a7, SYS_open
     ebc:	48bd                	li	a7,15
 ecall
     ebe:	00000073          	ecall
 ret
     ec2:	8082                	ret

0000000000000ec4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     ec4:	48c5                	li	a7,17
 ecall
     ec6:	00000073          	ecall
 ret
     eca:	8082                	ret

0000000000000ecc <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     ecc:	48c9                	li	a7,18
 ecall
     ece:	00000073          	ecall
 ret
     ed2:	8082                	ret

0000000000000ed4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     ed4:	48a1                	li	a7,8
 ecall
     ed6:	00000073          	ecall
 ret
     eda:	8082                	ret

0000000000000edc <link>:
.global link
link:
 li a7, SYS_link
     edc:	48cd                	li	a7,19
 ecall
     ede:	00000073          	ecall
 ret
     ee2:	8082                	ret

0000000000000ee4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     ee4:	48d1                	li	a7,20
 ecall
     ee6:	00000073          	ecall
 ret
     eea:	8082                	ret

0000000000000eec <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     eec:	48a5                	li	a7,9
 ecall
     eee:	00000073          	ecall
 ret
     ef2:	8082                	ret

0000000000000ef4 <dup>:
.global dup
dup:
 li a7, SYS_dup
     ef4:	48a9                	li	a7,10
 ecall
     ef6:	00000073          	ecall
 ret
     efa:	8082                	ret

0000000000000efc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     efc:	48ad                	li	a7,11
 ecall
     efe:	00000073          	ecall
 ret
     f02:	8082                	ret

0000000000000f04 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     f04:	48b1                	li	a7,12
 ecall
     f06:	00000073          	ecall
 ret
     f0a:	8082                	ret

0000000000000f0c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     f0c:	48b5                	li	a7,13
 ecall
     f0e:	00000073          	ecall
 ret
     f12:	8082                	ret

0000000000000f14 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     f14:	48b9                	li	a7,14
 ecall
     f16:	00000073          	ecall
 ret
     f1a:	8082                	ret

0000000000000f1c <connect>:
.global connect
connect:
 li a7, SYS_connect
     f1c:	48f5                	li	a7,29
 ecall
     f1e:	00000073          	ecall
 ret
     f22:	8082                	ret

0000000000000f24 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
     f24:	48f9                	li	a7,30
 ecall
     f26:	00000073          	ecall
 ret
     f2a:	8082                	ret

0000000000000f2c <vmprint>:
.global vmprint
vmprint:
 li a7, SYS_vmprint
     f2c:	48fd                	li	a7,31
 ecall
     f2e:	00000073          	ecall
 ret
     f32:	8082                	ret

0000000000000f34 <madvise>:
.global madvise
madvise:
 li a7, SYS_madvise
     f34:	02000893          	li	a7,32
 ecall
     f38:	00000073          	ecall
 ret
     f3c:	8082                	ret

0000000000000f3e <pgprint>:
.global pgprint
pgprint:
 li a7, SYS_pgprint
     f3e:	02100893          	li	a7,33
 ecall
     f42:	00000073          	ecall
 ret
     f46:	8082                	ret

0000000000000f48 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     f48:	1101                	addi	sp,sp,-32
     f4a:	ec06                	sd	ra,24(sp)
     f4c:	e822                	sd	s0,16(sp)
     f4e:	1000                	addi	s0,sp,32
     f50:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     f54:	4605                	li	a2,1
     f56:	fef40593          	addi	a1,s0,-17
     f5a:	00000097          	auipc	ra,0x0
     f5e:	f42080e7          	jalr	-190(ra) # e9c <write>
}
     f62:	60e2                	ld	ra,24(sp)
     f64:	6442                	ld	s0,16(sp)
     f66:	6105                	addi	sp,sp,32
     f68:	8082                	ret

0000000000000f6a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     f6a:	7139                	addi	sp,sp,-64
     f6c:	fc06                	sd	ra,56(sp)
     f6e:	f822                	sd	s0,48(sp)
     f70:	f426                	sd	s1,40(sp)
     f72:	f04a                	sd	s2,32(sp)
     f74:	ec4e                	sd	s3,24(sp)
     f76:	0080                	addi	s0,sp,64
     f78:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     f7a:	c299                	beqz	a3,f80 <printint+0x16>
     f7c:	0805c863          	bltz	a1,100c <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     f80:	2581                	sext.w	a1,a1
  neg = 0;
     f82:	4881                	li	a7,0
     f84:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
     f88:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     f8a:	2601                	sext.w	a2,a2
     f8c:	00000517          	auipc	a0,0x0
     f90:	72c50513          	addi	a0,a0,1836 # 16b8 <digits>
     f94:	883a                	mv	a6,a4
     f96:	2705                	addiw	a4,a4,1
     f98:	02c5f7bb          	remuw	a5,a1,a2
     f9c:	1782                	slli	a5,a5,0x20
     f9e:	9381                	srli	a5,a5,0x20
     fa0:	97aa                	add	a5,a5,a0
     fa2:	0007c783          	lbu	a5,0(a5) # 4000000 <__global_pointer$+0x3ffe137>
     fa6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     faa:	0005879b          	sext.w	a5,a1
     fae:	02c5d5bb          	divuw	a1,a1,a2
     fb2:	0685                	addi	a3,a3,1
     fb4:	fec7f0e3          	bgeu	a5,a2,f94 <printint+0x2a>
  if(neg)
     fb8:	00088b63          	beqz	a7,fce <printint+0x64>
    buf[i++] = '-';
     fbc:	fd040793          	addi	a5,s0,-48
     fc0:	973e                	add	a4,a4,a5
     fc2:	02d00793          	li	a5,45
     fc6:	fef70823          	sb	a5,-16(a4)
     fca:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
     fce:	02e05863          	blez	a4,ffe <printint+0x94>
     fd2:	fc040793          	addi	a5,s0,-64
     fd6:	00e78933          	add	s2,a5,a4
     fda:	fff78993          	addi	s3,a5,-1
     fde:	99ba                	add	s3,s3,a4
     fe0:	377d                	addiw	a4,a4,-1
     fe2:	1702                	slli	a4,a4,0x20
     fe4:	9301                	srli	a4,a4,0x20
     fe6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     fea:	fff94583          	lbu	a1,-1(s2)
     fee:	8526                	mv	a0,s1
     ff0:	00000097          	auipc	ra,0x0
     ff4:	f58080e7          	jalr	-168(ra) # f48 <putc>
  while(--i >= 0)
     ff8:	197d                	addi	s2,s2,-1
     ffa:	ff3918e3          	bne	s2,s3,fea <printint+0x80>
}
     ffe:	70e2                	ld	ra,56(sp)
    1000:	7442                	ld	s0,48(sp)
    1002:	74a2                	ld	s1,40(sp)
    1004:	7902                	ld	s2,32(sp)
    1006:	69e2                	ld	s3,24(sp)
    1008:	6121                	addi	sp,sp,64
    100a:	8082                	ret
    x = -xx;
    100c:	40b005bb          	negw	a1,a1
    neg = 1;
    1010:	4885                	li	a7,1
    x = -xx;
    1012:	bf8d                	j	f84 <printint+0x1a>

0000000000001014 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    1014:	7119                	addi	sp,sp,-128
    1016:	fc86                	sd	ra,120(sp)
    1018:	f8a2                	sd	s0,112(sp)
    101a:	f4a6                	sd	s1,104(sp)
    101c:	f0ca                	sd	s2,96(sp)
    101e:	ecce                	sd	s3,88(sp)
    1020:	e8d2                	sd	s4,80(sp)
    1022:	e4d6                	sd	s5,72(sp)
    1024:	e0da                	sd	s6,64(sp)
    1026:	fc5e                	sd	s7,56(sp)
    1028:	f862                	sd	s8,48(sp)
    102a:	f466                	sd	s9,40(sp)
    102c:	f06a                	sd	s10,32(sp)
    102e:	ec6e                	sd	s11,24(sp)
    1030:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    1032:	0005c903          	lbu	s2,0(a1)
    1036:	18090f63          	beqz	s2,11d4 <vprintf+0x1c0>
    103a:	8aaa                	mv	s5,a0
    103c:	8b32                	mv	s6,a2
    103e:	00158493          	addi	s1,a1,1
  state = 0;
    1042:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1044:	02500a13          	li	s4,37
      if(c == 'd'){
    1048:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    104c:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    1050:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    1054:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1058:	00000b97          	auipc	s7,0x0
    105c:	660b8b93          	addi	s7,s7,1632 # 16b8 <digits>
    1060:	a839                	j	107e <vprintf+0x6a>
        putc(fd, c);
    1062:	85ca                	mv	a1,s2
    1064:	8556                	mv	a0,s5
    1066:	00000097          	auipc	ra,0x0
    106a:	ee2080e7          	jalr	-286(ra) # f48 <putc>
    106e:	a019                	j	1074 <vprintf+0x60>
    } else if(state == '%'){
    1070:	01498f63          	beq	s3,s4,108e <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    1074:	0485                	addi	s1,s1,1
    1076:	fff4c903          	lbu	s2,-1(s1)
    107a:	14090d63          	beqz	s2,11d4 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    107e:	0009079b          	sext.w	a5,s2
    if(state == 0){
    1082:	fe0997e3          	bnez	s3,1070 <vprintf+0x5c>
      if(c == '%'){
    1086:	fd479ee3          	bne	a5,s4,1062 <vprintf+0x4e>
        state = '%';
    108a:	89be                	mv	s3,a5
    108c:	b7e5                	j	1074 <vprintf+0x60>
      if(c == 'd'){
    108e:	05878063          	beq	a5,s8,10ce <vprintf+0xba>
      } else if(c == 'l') {
    1092:	05978c63          	beq	a5,s9,10ea <vprintf+0xd6>
      } else if(c == 'x') {
    1096:	07a78863          	beq	a5,s10,1106 <vprintf+0xf2>
      } else if(c == 'p') {
    109a:	09b78463          	beq	a5,s11,1122 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    109e:	07300713          	li	a4,115
    10a2:	0ce78663          	beq	a5,a4,116e <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    10a6:	06300713          	li	a4,99
    10aa:	0ee78e63          	beq	a5,a4,11a6 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    10ae:	11478863          	beq	a5,s4,11be <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    10b2:	85d2                	mv	a1,s4
    10b4:	8556                	mv	a0,s5
    10b6:	00000097          	auipc	ra,0x0
    10ba:	e92080e7          	jalr	-366(ra) # f48 <putc>
        putc(fd, c);
    10be:	85ca                	mv	a1,s2
    10c0:	8556                	mv	a0,s5
    10c2:	00000097          	auipc	ra,0x0
    10c6:	e86080e7          	jalr	-378(ra) # f48 <putc>
      }
      state = 0;
    10ca:	4981                	li	s3,0
    10cc:	b765                	j	1074 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    10ce:	008b0913          	addi	s2,s6,8
    10d2:	4685                	li	a3,1
    10d4:	4629                	li	a2,10
    10d6:	000b2583          	lw	a1,0(s6)
    10da:	8556                	mv	a0,s5
    10dc:	00000097          	auipc	ra,0x0
    10e0:	e8e080e7          	jalr	-370(ra) # f6a <printint>
    10e4:	8b4a                	mv	s6,s2
      state = 0;
    10e6:	4981                	li	s3,0
    10e8:	b771                	j	1074 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    10ea:	008b0913          	addi	s2,s6,8
    10ee:	4681                	li	a3,0
    10f0:	4629                	li	a2,10
    10f2:	000b2583          	lw	a1,0(s6)
    10f6:	8556                	mv	a0,s5
    10f8:	00000097          	auipc	ra,0x0
    10fc:	e72080e7          	jalr	-398(ra) # f6a <printint>
    1100:	8b4a                	mv	s6,s2
      state = 0;
    1102:	4981                	li	s3,0
    1104:	bf85                	j	1074 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    1106:	008b0913          	addi	s2,s6,8
    110a:	4681                	li	a3,0
    110c:	4641                	li	a2,16
    110e:	000b2583          	lw	a1,0(s6)
    1112:	8556                	mv	a0,s5
    1114:	00000097          	auipc	ra,0x0
    1118:	e56080e7          	jalr	-426(ra) # f6a <printint>
    111c:	8b4a                	mv	s6,s2
      state = 0;
    111e:	4981                	li	s3,0
    1120:	bf91                	j	1074 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    1122:	008b0793          	addi	a5,s6,8
    1126:	f8f43423          	sd	a5,-120(s0)
    112a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    112e:	03000593          	li	a1,48
    1132:	8556                	mv	a0,s5
    1134:	00000097          	auipc	ra,0x0
    1138:	e14080e7          	jalr	-492(ra) # f48 <putc>
  putc(fd, 'x');
    113c:	85ea                	mv	a1,s10
    113e:	8556                	mv	a0,s5
    1140:	00000097          	auipc	ra,0x0
    1144:	e08080e7          	jalr	-504(ra) # f48 <putc>
    1148:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    114a:	03c9d793          	srli	a5,s3,0x3c
    114e:	97de                	add	a5,a5,s7
    1150:	0007c583          	lbu	a1,0(a5)
    1154:	8556                	mv	a0,s5
    1156:	00000097          	auipc	ra,0x0
    115a:	df2080e7          	jalr	-526(ra) # f48 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    115e:	0992                	slli	s3,s3,0x4
    1160:	397d                	addiw	s2,s2,-1
    1162:	fe0914e3          	bnez	s2,114a <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    1166:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    116a:	4981                	li	s3,0
    116c:	b721                	j	1074 <vprintf+0x60>
        s = va_arg(ap, char*);
    116e:	008b0993          	addi	s3,s6,8
    1172:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    1176:	02090163          	beqz	s2,1198 <vprintf+0x184>
        while(*s != 0){
    117a:	00094583          	lbu	a1,0(s2)
    117e:	c9a1                	beqz	a1,11ce <vprintf+0x1ba>
          putc(fd, *s);
    1180:	8556                	mv	a0,s5
    1182:	00000097          	auipc	ra,0x0
    1186:	dc6080e7          	jalr	-570(ra) # f48 <putc>
          s++;
    118a:	0905                	addi	s2,s2,1
        while(*s != 0){
    118c:	00094583          	lbu	a1,0(s2)
    1190:	f9e5                	bnez	a1,1180 <vprintf+0x16c>
        s = va_arg(ap, char*);
    1192:	8b4e                	mv	s6,s3
      state = 0;
    1194:	4981                	li	s3,0
    1196:	bdf9                	j	1074 <vprintf+0x60>
          s = "(null)";
    1198:	00000917          	auipc	s2,0x0
    119c:	51890913          	addi	s2,s2,1304 # 16b0 <malloc+0x3d2>
        while(*s != 0){
    11a0:	02800593          	li	a1,40
    11a4:	bff1                	j	1180 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    11a6:	008b0913          	addi	s2,s6,8
    11aa:	000b4583          	lbu	a1,0(s6)
    11ae:	8556                	mv	a0,s5
    11b0:	00000097          	auipc	ra,0x0
    11b4:	d98080e7          	jalr	-616(ra) # f48 <putc>
    11b8:	8b4a                	mv	s6,s2
      state = 0;
    11ba:	4981                	li	s3,0
    11bc:	bd65                	j	1074 <vprintf+0x60>
        putc(fd, c);
    11be:	85d2                	mv	a1,s4
    11c0:	8556                	mv	a0,s5
    11c2:	00000097          	auipc	ra,0x0
    11c6:	d86080e7          	jalr	-634(ra) # f48 <putc>
      state = 0;
    11ca:	4981                	li	s3,0
    11cc:	b565                	j	1074 <vprintf+0x60>
        s = va_arg(ap, char*);
    11ce:	8b4e                	mv	s6,s3
      state = 0;
    11d0:	4981                	li	s3,0
    11d2:	b54d                	j	1074 <vprintf+0x60>
    }
  }
}
    11d4:	70e6                	ld	ra,120(sp)
    11d6:	7446                	ld	s0,112(sp)
    11d8:	74a6                	ld	s1,104(sp)
    11da:	7906                	ld	s2,96(sp)
    11dc:	69e6                	ld	s3,88(sp)
    11de:	6a46                	ld	s4,80(sp)
    11e0:	6aa6                	ld	s5,72(sp)
    11e2:	6b06                	ld	s6,64(sp)
    11e4:	7be2                	ld	s7,56(sp)
    11e6:	7c42                	ld	s8,48(sp)
    11e8:	7ca2                	ld	s9,40(sp)
    11ea:	7d02                	ld	s10,32(sp)
    11ec:	6de2                	ld	s11,24(sp)
    11ee:	6109                	addi	sp,sp,128
    11f0:	8082                	ret

00000000000011f2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    11f2:	715d                	addi	sp,sp,-80
    11f4:	ec06                	sd	ra,24(sp)
    11f6:	e822                	sd	s0,16(sp)
    11f8:	1000                	addi	s0,sp,32
    11fa:	e010                	sd	a2,0(s0)
    11fc:	e414                	sd	a3,8(s0)
    11fe:	e818                	sd	a4,16(s0)
    1200:	ec1c                	sd	a5,24(s0)
    1202:	03043023          	sd	a6,32(s0)
    1206:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    120a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    120e:	8622                	mv	a2,s0
    1210:	00000097          	auipc	ra,0x0
    1214:	e04080e7          	jalr	-508(ra) # 1014 <vprintf>
}
    1218:	60e2                	ld	ra,24(sp)
    121a:	6442                	ld	s0,16(sp)
    121c:	6161                	addi	sp,sp,80
    121e:	8082                	ret

0000000000001220 <printf>:

void
printf(const char *fmt, ...)
{
    1220:	711d                	addi	sp,sp,-96
    1222:	ec06                	sd	ra,24(sp)
    1224:	e822                	sd	s0,16(sp)
    1226:	1000                	addi	s0,sp,32
    1228:	e40c                	sd	a1,8(s0)
    122a:	e810                	sd	a2,16(s0)
    122c:	ec14                	sd	a3,24(s0)
    122e:	f018                	sd	a4,32(s0)
    1230:	f41c                	sd	a5,40(s0)
    1232:	03043823          	sd	a6,48(s0)
    1236:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    123a:	00840613          	addi	a2,s0,8
    123e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1242:	85aa                	mv	a1,a0
    1244:	4505                	li	a0,1
    1246:	00000097          	auipc	ra,0x0
    124a:	dce080e7          	jalr	-562(ra) # 1014 <vprintf>
}
    124e:	60e2                	ld	ra,24(sp)
    1250:	6442                	ld	s0,16(sp)
    1252:	6125                	addi	sp,sp,96
    1254:	8082                	ret

0000000000001256 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1256:	1141                	addi	sp,sp,-16
    1258:	e422                	sd	s0,8(sp)
    125a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    125c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1260:	00000797          	auipc	a5,0x0
    1264:	4787b783          	ld	a5,1144(a5) # 16d8 <freep>
    1268:	a805                	j	1298 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    126a:	4618                	lw	a4,8(a2)
    126c:	9db9                	addw	a1,a1,a4
    126e:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1272:	6398                	ld	a4,0(a5)
    1274:	6318                	ld	a4,0(a4)
    1276:	fee53823          	sd	a4,-16(a0)
    127a:	a091                	j	12be <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    127c:	ff852703          	lw	a4,-8(a0)
    1280:	9e39                	addw	a2,a2,a4
    1282:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    1284:	ff053703          	ld	a4,-16(a0)
    1288:	e398                	sd	a4,0(a5)
    128a:	a099                	j	12d0 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    128c:	6398                	ld	a4,0(a5)
    128e:	00e7e463          	bltu	a5,a4,1296 <free+0x40>
    1292:	00e6ea63          	bltu	a3,a4,12a6 <free+0x50>
{
    1296:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1298:	fed7fae3          	bgeu	a5,a3,128c <free+0x36>
    129c:	6398                	ld	a4,0(a5)
    129e:	00e6e463          	bltu	a3,a4,12a6 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    12a2:	fee7eae3          	bltu	a5,a4,1296 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    12a6:	ff852583          	lw	a1,-8(a0)
    12aa:	6390                	ld	a2,0(a5)
    12ac:	02059713          	slli	a4,a1,0x20
    12b0:	9301                	srli	a4,a4,0x20
    12b2:	0712                	slli	a4,a4,0x4
    12b4:	9736                	add	a4,a4,a3
    12b6:	fae60ae3          	beq	a2,a4,126a <free+0x14>
    bp->s.ptr = p->s.ptr;
    12ba:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    12be:	4790                	lw	a2,8(a5)
    12c0:	02061713          	slli	a4,a2,0x20
    12c4:	9301                	srli	a4,a4,0x20
    12c6:	0712                	slli	a4,a4,0x4
    12c8:	973e                	add	a4,a4,a5
    12ca:	fae689e3          	beq	a3,a4,127c <free+0x26>
  } else
    p->s.ptr = bp;
    12ce:	e394                	sd	a3,0(a5)
  freep = p;
    12d0:	00000717          	auipc	a4,0x0
    12d4:	40f73423          	sd	a5,1032(a4) # 16d8 <freep>
}
    12d8:	6422                	ld	s0,8(sp)
    12da:	0141                	addi	sp,sp,16
    12dc:	8082                	ret

00000000000012de <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    12de:	7139                	addi	sp,sp,-64
    12e0:	fc06                	sd	ra,56(sp)
    12e2:	f822                	sd	s0,48(sp)
    12e4:	f426                	sd	s1,40(sp)
    12e6:	f04a                	sd	s2,32(sp)
    12e8:	ec4e                	sd	s3,24(sp)
    12ea:	e852                	sd	s4,16(sp)
    12ec:	e456                	sd	s5,8(sp)
    12ee:	e05a                	sd	s6,0(sp)
    12f0:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    12f2:	02051493          	slli	s1,a0,0x20
    12f6:	9081                	srli	s1,s1,0x20
    12f8:	04bd                	addi	s1,s1,15
    12fa:	8091                	srli	s1,s1,0x4
    12fc:	0014899b          	addiw	s3,s1,1
    1300:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    1302:	00000797          	auipc	a5,0x0
    1306:	3d67b783          	ld	a5,982(a5) # 16d8 <freep>
    130a:	c795                	beqz	a5,1336 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    130c:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
    130e:	4518                	lw	a4,8(a0)
    1310:	02977f63          	bgeu	a4,s1,134e <malloc+0x70>
    1314:	8a4e                	mv	s4,s3
    1316:	0009879b          	sext.w	a5,s3
    131a:	6705                	lui	a4,0x1
    131c:	00e7f363          	bgeu	a5,a4,1322 <malloc+0x44>
    1320:	6a05                	lui	s4,0x1
    1322:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1326:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p);
    }
    if(p == freep)
    132a:	00000917          	auipc	s2,0x0
    132e:	3ae90913          	addi	s2,s2,942 # 16d8 <freep>
  if(p == (char*)-1)
    1332:	5afd                	li	s5,-1
    1334:	a0bd                	j	13a2 <malloc+0xc4>
    base.s.ptr = freep = prevp = &base;
    1336:	00000517          	auipc	a0,0x0
    133a:	79250513          	addi	a0,a0,1938 # 1ac8 <base>
    133e:	00000797          	auipc	a5,0x0
    1342:	38a7bd23          	sd	a0,922(a5) # 16d8 <freep>
    1346:	e108                	sd	a0,0(a0)
    base.s.size = 0;
    1348:	00052423          	sw	zero,8(a0)
    if(p->s.size >= nunits){
    134c:	b7e1                	j	1314 <malloc+0x36>
      if(p->s.size == nunits)
    134e:	02e48963          	beq	s1,a4,1380 <malloc+0xa2>
        p->s.size -= nunits;
    1352:	4137073b          	subw	a4,a4,s3
    1356:	c518                	sw	a4,8(a0)
        p += p->s.size;
    1358:	1702                	slli	a4,a4,0x20
    135a:	9301                	srli	a4,a4,0x20
    135c:	0712                	slli	a4,a4,0x4
    135e:	953a                	add	a0,a0,a4
        p->s.size = nunits;
    1360:	01352423          	sw	s3,8(a0)
      freep = prevp;
    1364:	00000717          	auipc	a4,0x0
    1368:	36f73a23          	sd	a5,884(a4) # 16d8 <freep>
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    136c:	70e2                	ld	ra,56(sp)
    136e:	7442                	ld	s0,48(sp)
    1370:	74a2                	ld	s1,40(sp)
    1372:	7902                	ld	s2,32(sp)
    1374:	69e2                	ld	s3,24(sp)
    1376:	6a42                	ld	s4,16(sp)
    1378:	6aa2                	ld	s5,8(sp)
    137a:	6b02                	ld	s6,0(sp)
    137c:	6121                	addi	sp,sp,64
    137e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    1380:	6118                	ld	a4,0(a0)
    1382:	e398                	sd	a4,0(a5)
    1384:	b7c5                	j	1364 <malloc+0x86>
  hp->s.size = nu;
    1386:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    138a:	0541                	addi	a0,a0,16
    138c:	00000097          	auipc	ra,0x0
    1390:	eca080e7          	jalr	-310(ra) # 1256 <free>
  return freep;
    1394:	00093783          	ld	a5,0(s2)
      if((p = morecore(nunits)) == 0)
    1398:	c39d                	beqz	a5,13be <malloc+0xe0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    139a:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
    139c:	4518                	lw	a4,8(a0)
    139e:	fa9778e3          	bgeu	a4,s1,134e <malloc+0x70>
    if(p == freep)
    13a2:	00093703          	ld	a4,0(s2)
    13a6:	87aa                	mv	a5,a0
    13a8:	fea719e3          	bne	a4,a0,139a <malloc+0xbc>
  p = sbrk(nu * sizeof(Header));
    13ac:	8552                	mv	a0,s4
    13ae:	00000097          	auipc	ra,0x0
    13b2:	b56080e7          	jalr	-1194(ra) # f04 <sbrk>
  if(p == (char*)-1)
    13b6:	fd5518e3          	bne	a0,s5,1386 <malloc+0xa8>
        return 0;
    13ba:	4501                	li	a0,0
    13bc:	bf45                	j	136c <malloc+0x8e>
    13be:	853e                	mv	a0,a5
    13c0:	b775                	j	136c <malloc+0x8e>
