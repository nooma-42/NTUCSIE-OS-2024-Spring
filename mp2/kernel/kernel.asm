
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	a6013103          	ld	sp,-1440(sp) # 80008a60 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	60b050ef          	jal	ra,80005e20 <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec06                	sd	ra,24(sp)
    80000020:	e822                	sd	s0,16(sp)
    80000022:	e426                	sd	s1,8(sp)
    80000024:	e04a                	sd	s2,0(sp)
    80000026:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000028:	03451793          	slli	a5,a0,0x34
    8000002c:	ebb9                	bnez	a5,80000082 <kfree+0x66>
    8000002e:	84aa                	mv	s1,a0
    80000030:	00026797          	auipc	a5,0x26
    80000034:	21078793          	addi	a5,a5,528 # 80026240 <end>
    80000038:	04f56563          	bltu	a0,a5,80000082 <kfree+0x66>
    8000003c:	47c5                	li	a5,17
    8000003e:	07ee                	slli	a5,a5,0x1b
    80000040:	04f57163          	bgeu	a0,a5,80000082 <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000044:	6605                	lui	a2,0x1
    80000046:	4585                	li	a1,1
    80000048:	00000097          	auipc	ra,0x0
    8000004c:	130080e7          	jalr	304(ra) # 80000178 <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000050:	00009917          	auipc	s2,0x9
    80000054:	fe090913          	addi	s2,s2,-32 # 80009030 <kmem>
    80000058:	854a                	mv	a0,s2
    8000005a:	00006097          	auipc	ra,0x6
    8000005e:	7c0080e7          	jalr	1984(ra) # 8000681a <acquire>
  r->next = kmem.freelist;
    80000062:	01893783          	ld	a5,24(s2)
    80000066:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000068:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    8000006c:	854a                	mv	a0,s2
    8000006e:	00007097          	auipc	ra,0x7
    80000072:	860080e7          	jalr	-1952(ra) # 800068ce <release>
}
    80000076:	60e2                	ld	ra,24(sp)
    80000078:	6442                	ld	s0,16(sp)
    8000007a:	64a2                	ld	s1,8(sp)
    8000007c:	6902                	ld	s2,0(sp)
    8000007e:	6105                	addi	sp,sp,32
    80000080:	8082                	ret
    panic("kfree");
    80000082:	00008517          	auipc	a0,0x8
    80000086:	f8e50513          	addi	a0,a0,-114 # 80008010 <etext+0x10>
    8000008a:	00006097          	auipc	ra,0x6
    8000008e:	246080e7          	jalr	582(ra) # 800062d0 <panic>

0000000080000092 <freerange>:
{
    80000092:	7179                	addi	sp,sp,-48
    80000094:	f406                	sd	ra,40(sp)
    80000096:	f022                	sd	s0,32(sp)
    80000098:	ec26                	sd	s1,24(sp)
    8000009a:	e84a                	sd	s2,16(sp)
    8000009c:	e44e                	sd	s3,8(sp)
    8000009e:	e052                	sd	s4,0(sp)
    800000a0:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    800000a2:	6785                	lui	a5,0x1
    800000a4:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800000a8:	94aa                	add	s1,s1,a0
    800000aa:	757d                	lui	a0,0xfffff
    800000ac:	8ce9                	and	s1,s1,a0
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000ae:	94be                	add	s1,s1,a5
    800000b0:	0095ee63          	bltu	a1,s1,800000cc <freerange+0x3a>
    800000b4:	892e                	mv	s2,a1
    kfree(p);
    800000b6:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000b8:	6985                	lui	s3,0x1
    kfree(p);
    800000ba:	01448533          	add	a0,s1,s4
    800000be:	00000097          	auipc	ra,0x0
    800000c2:	f5e080e7          	jalr	-162(ra) # 8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000c6:	94ce                	add	s1,s1,s3
    800000c8:	fe9979e3          	bgeu	s2,s1,800000ba <freerange+0x28>
}
    800000cc:	70a2                	ld	ra,40(sp)
    800000ce:	7402                	ld	s0,32(sp)
    800000d0:	64e2                	ld	s1,24(sp)
    800000d2:	6942                	ld	s2,16(sp)
    800000d4:	69a2                	ld	s3,8(sp)
    800000d6:	6a02                	ld	s4,0(sp)
    800000d8:	6145                	addi	sp,sp,48
    800000da:	8082                	ret

00000000800000dc <kinit>:
{
    800000dc:	1141                	addi	sp,sp,-16
    800000de:	e406                	sd	ra,8(sp)
    800000e0:	e022                	sd	s0,0(sp)
    800000e2:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800000e4:	00008597          	auipc	a1,0x8
    800000e8:	f3458593          	addi	a1,a1,-204 # 80008018 <etext+0x18>
    800000ec:	00009517          	auipc	a0,0x9
    800000f0:	f4450513          	addi	a0,a0,-188 # 80009030 <kmem>
    800000f4:	00006097          	auipc	ra,0x6
    800000f8:	696080e7          	jalr	1686(ra) # 8000678a <initlock>
  freerange(end, (void*)PHYSTOP);
    800000fc:	45c5                	li	a1,17
    800000fe:	05ee                	slli	a1,a1,0x1b
    80000100:	00026517          	auipc	a0,0x26
    80000104:	14050513          	addi	a0,a0,320 # 80026240 <end>
    80000108:	00000097          	auipc	ra,0x0
    8000010c:	f8a080e7          	jalr	-118(ra) # 80000092 <freerange>
}
    80000110:	60a2                	ld	ra,8(sp)
    80000112:	6402                	ld	s0,0(sp)
    80000114:	0141                	addi	sp,sp,16
    80000116:	8082                	ret

0000000080000118 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000118:	1101                	addi	sp,sp,-32
    8000011a:	ec06                	sd	ra,24(sp)
    8000011c:	e822                	sd	s0,16(sp)
    8000011e:	e426                	sd	s1,8(sp)
    80000120:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000122:	00009497          	auipc	s1,0x9
    80000126:	f0e48493          	addi	s1,s1,-242 # 80009030 <kmem>
    8000012a:	8526                	mv	a0,s1
    8000012c:	00006097          	auipc	ra,0x6
    80000130:	6ee080e7          	jalr	1774(ra) # 8000681a <acquire>
  r = kmem.freelist;
    80000134:	6c84                	ld	s1,24(s1)
  if(r)
    80000136:	c885                	beqz	s1,80000166 <kalloc+0x4e>
    kmem.freelist = r->next;
    80000138:	609c                	ld	a5,0(s1)
    8000013a:	00009517          	auipc	a0,0x9
    8000013e:	ef650513          	addi	a0,a0,-266 # 80009030 <kmem>
    80000142:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000144:	00006097          	auipc	ra,0x6
    80000148:	78a080e7          	jalr	1930(ra) # 800068ce <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    8000014c:	6605                	lui	a2,0x1
    8000014e:	4595                	li	a1,5
    80000150:	8526                	mv	a0,s1
    80000152:	00000097          	auipc	ra,0x0
    80000156:	026080e7          	jalr	38(ra) # 80000178 <memset>
  return (void*)r;
}
    8000015a:	8526                	mv	a0,s1
    8000015c:	60e2                	ld	ra,24(sp)
    8000015e:	6442                	ld	s0,16(sp)
    80000160:	64a2                	ld	s1,8(sp)
    80000162:	6105                	addi	sp,sp,32
    80000164:	8082                	ret
  release(&kmem.lock);
    80000166:	00009517          	auipc	a0,0x9
    8000016a:	eca50513          	addi	a0,a0,-310 # 80009030 <kmem>
    8000016e:	00006097          	auipc	ra,0x6
    80000172:	760080e7          	jalr	1888(ra) # 800068ce <release>
  if(r)
    80000176:	b7d5                	j	8000015a <kalloc+0x42>

0000000080000178 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    80000178:	1141                	addi	sp,sp,-16
    8000017a:	e422                	sd	s0,8(sp)
    8000017c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    8000017e:	ce09                	beqz	a2,80000198 <memset+0x20>
    80000180:	87aa                	mv	a5,a0
    80000182:	fff6071b          	addiw	a4,a2,-1
    80000186:	1702                	slli	a4,a4,0x20
    80000188:	9301                	srli	a4,a4,0x20
    8000018a:	0705                	addi	a4,a4,1
    8000018c:	972a                	add	a4,a4,a0
    cdst[i] = c;
    8000018e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000192:	0785                	addi	a5,a5,1
    80000194:	fee79de3          	bne	a5,a4,8000018e <memset+0x16>
  }
  return dst;
}
    80000198:	6422                	ld	s0,8(sp)
    8000019a:	0141                	addi	sp,sp,16
    8000019c:	8082                	ret

000000008000019e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    8000019e:	1141                	addi	sp,sp,-16
    800001a0:	e422                	sd	s0,8(sp)
    800001a2:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    800001a4:	ca05                	beqz	a2,800001d4 <memcmp+0x36>
    800001a6:	fff6069b          	addiw	a3,a2,-1
    800001aa:	1682                	slli	a3,a3,0x20
    800001ac:	9281                	srli	a3,a3,0x20
    800001ae:	0685                	addi	a3,a3,1
    800001b0:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    800001b2:	00054783          	lbu	a5,0(a0)
    800001b6:	0005c703          	lbu	a4,0(a1)
    800001ba:	00e79863          	bne	a5,a4,800001ca <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    800001be:	0505                	addi	a0,a0,1
    800001c0:	0585                	addi	a1,a1,1
  while(n-- > 0){
    800001c2:	fed518e3          	bne	a0,a3,800001b2 <memcmp+0x14>
  }

  return 0;
    800001c6:	4501                	li	a0,0
    800001c8:	a019                	j	800001ce <memcmp+0x30>
      return *s1 - *s2;
    800001ca:	40e7853b          	subw	a0,a5,a4
}
    800001ce:	6422                	ld	s0,8(sp)
    800001d0:	0141                	addi	sp,sp,16
    800001d2:	8082                	ret
  return 0;
    800001d4:	4501                	li	a0,0
    800001d6:	bfe5                	j	800001ce <memcmp+0x30>

00000000800001d8 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800001d8:	1141                	addi	sp,sp,-16
    800001da:	e422                	sd	s0,8(sp)
    800001dc:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    800001de:	ca0d                	beqz	a2,80000210 <memmove+0x38>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    800001e0:	00a5f963          	bgeu	a1,a0,800001f2 <memmove+0x1a>
    800001e4:	02061693          	slli	a3,a2,0x20
    800001e8:	9281                	srli	a3,a3,0x20
    800001ea:	00d58733          	add	a4,a1,a3
    800001ee:	02e56463          	bltu	a0,a4,80000216 <memmove+0x3e>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800001f2:	fff6079b          	addiw	a5,a2,-1
    800001f6:	1782                	slli	a5,a5,0x20
    800001f8:	9381                	srli	a5,a5,0x20
    800001fa:	0785                	addi	a5,a5,1
    800001fc:	97ae                	add	a5,a5,a1
    800001fe:	872a                	mv	a4,a0
      *d++ = *s++;
    80000200:	0585                	addi	a1,a1,1
    80000202:	0705                	addi	a4,a4,1
    80000204:	fff5c683          	lbu	a3,-1(a1)
    80000208:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    8000020c:	fef59ae3          	bne	a1,a5,80000200 <memmove+0x28>

  return dst;
}
    80000210:	6422                	ld	s0,8(sp)
    80000212:	0141                	addi	sp,sp,16
    80000214:	8082                	ret
    d += n;
    80000216:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    80000218:	fff6079b          	addiw	a5,a2,-1
    8000021c:	1782                	slli	a5,a5,0x20
    8000021e:	9381                	srli	a5,a5,0x20
    80000220:	fff7c793          	not	a5,a5
    80000224:	97ba                	add	a5,a5,a4
      *--d = *--s;
    80000226:	177d                	addi	a4,a4,-1
    80000228:	16fd                	addi	a3,a3,-1
    8000022a:	00074603          	lbu	a2,0(a4)
    8000022e:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    80000232:	fef71ae3          	bne	a4,a5,80000226 <memmove+0x4e>
    80000236:	bfe9                	j	80000210 <memmove+0x38>

0000000080000238 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000238:	1141                	addi	sp,sp,-16
    8000023a:	e406                	sd	ra,8(sp)
    8000023c:	e022                	sd	s0,0(sp)
    8000023e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80000240:	00000097          	auipc	ra,0x0
    80000244:	f98080e7          	jalr	-104(ra) # 800001d8 <memmove>
}
    80000248:	60a2                	ld	ra,8(sp)
    8000024a:	6402                	ld	s0,0(sp)
    8000024c:	0141                	addi	sp,sp,16
    8000024e:	8082                	ret

0000000080000250 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000250:	1141                	addi	sp,sp,-16
    80000252:	e422                	sd	s0,8(sp)
    80000254:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000256:	ce11                	beqz	a2,80000272 <strncmp+0x22>
    80000258:	00054783          	lbu	a5,0(a0)
    8000025c:	cf89                	beqz	a5,80000276 <strncmp+0x26>
    8000025e:	0005c703          	lbu	a4,0(a1)
    80000262:	00f71a63          	bne	a4,a5,80000276 <strncmp+0x26>
    n--, p++, q++;
    80000266:	367d                	addiw	a2,a2,-1
    80000268:	0505                	addi	a0,a0,1
    8000026a:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    8000026c:	f675                	bnez	a2,80000258 <strncmp+0x8>
  if(n == 0)
    return 0;
    8000026e:	4501                	li	a0,0
    80000270:	a809                	j	80000282 <strncmp+0x32>
    80000272:	4501                	li	a0,0
    80000274:	a039                	j	80000282 <strncmp+0x32>
  if(n == 0)
    80000276:	ca09                	beqz	a2,80000288 <strncmp+0x38>
  return (uchar)*p - (uchar)*q;
    80000278:	00054503          	lbu	a0,0(a0)
    8000027c:	0005c783          	lbu	a5,0(a1)
    80000280:	9d1d                	subw	a0,a0,a5
}
    80000282:	6422                	ld	s0,8(sp)
    80000284:	0141                	addi	sp,sp,16
    80000286:	8082                	ret
    return 0;
    80000288:	4501                	li	a0,0
    8000028a:	bfe5                	j	80000282 <strncmp+0x32>

000000008000028c <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    8000028c:	1141                	addi	sp,sp,-16
    8000028e:	e422                	sd	s0,8(sp)
    80000290:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000292:	872a                	mv	a4,a0
    80000294:	8832                	mv	a6,a2
    80000296:	367d                	addiw	a2,a2,-1
    80000298:	01005963          	blez	a6,800002aa <strncpy+0x1e>
    8000029c:	0705                	addi	a4,a4,1
    8000029e:	0005c783          	lbu	a5,0(a1)
    800002a2:	fef70fa3          	sb	a5,-1(a4)
    800002a6:	0585                	addi	a1,a1,1
    800002a8:	f7f5                	bnez	a5,80000294 <strncpy+0x8>
    ;
  while(n-- > 0)
    800002aa:	00c05d63          	blez	a2,800002c4 <strncpy+0x38>
    800002ae:	86ba                	mv	a3,a4
    *s++ = 0;
    800002b0:	0685                	addi	a3,a3,1
    800002b2:	fe068fa3          	sb	zero,-1(a3)
  while(n-- > 0)
    800002b6:	fff6c793          	not	a5,a3
    800002ba:	9fb9                	addw	a5,a5,a4
    800002bc:	010787bb          	addw	a5,a5,a6
    800002c0:	fef048e3          	bgtz	a5,800002b0 <strncpy+0x24>
  return os;
}
    800002c4:	6422                	ld	s0,8(sp)
    800002c6:	0141                	addi	sp,sp,16
    800002c8:	8082                	ret

00000000800002ca <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    800002ca:	1141                	addi	sp,sp,-16
    800002cc:	e422                	sd	s0,8(sp)
    800002ce:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    800002d0:	02c05363          	blez	a2,800002f6 <safestrcpy+0x2c>
    800002d4:	fff6069b          	addiw	a3,a2,-1
    800002d8:	1682                	slli	a3,a3,0x20
    800002da:	9281                	srli	a3,a3,0x20
    800002dc:	96ae                	add	a3,a3,a1
    800002de:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800002e0:	00d58963          	beq	a1,a3,800002f2 <safestrcpy+0x28>
    800002e4:	0585                	addi	a1,a1,1
    800002e6:	0785                	addi	a5,a5,1
    800002e8:	fff5c703          	lbu	a4,-1(a1)
    800002ec:	fee78fa3          	sb	a4,-1(a5)
    800002f0:	fb65                	bnez	a4,800002e0 <safestrcpy+0x16>
    ;
  *s = 0;
    800002f2:	00078023          	sb	zero,0(a5)
  return os;
}
    800002f6:	6422                	ld	s0,8(sp)
    800002f8:	0141                	addi	sp,sp,16
    800002fa:	8082                	ret

00000000800002fc <strlen>:

int
strlen(const char *s)
{
    800002fc:	1141                	addi	sp,sp,-16
    800002fe:	e422                	sd	s0,8(sp)
    80000300:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    80000302:	00054783          	lbu	a5,0(a0)
    80000306:	cf91                	beqz	a5,80000322 <strlen+0x26>
    80000308:	0505                	addi	a0,a0,1
    8000030a:	87aa                	mv	a5,a0
    8000030c:	4685                	li	a3,1
    8000030e:	9e89                	subw	a3,a3,a0
    80000310:	00f6853b          	addw	a0,a3,a5
    80000314:	0785                	addi	a5,a5,1
    80000316:	fff7c703          	lbu	a4,-1(a5)
    8000031a:	fb7d                	bnez	a4,80000310 <strlen+0x14>
    ;
  return n;
}
    8000031c:	6422                	ld	s0,8(sp)
    8000031e:	0141                	addi	sp,sp,16
    80000320:	8082                	ret
  for(n = 0; s[n]; n++)
    80000322:	4501                	li	a0,0
    80000324:	bfe5                	j	8000031c <strlen+0x20>

0000000080000326 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000326:	1141                	addi	sp,sp,-16
    80000328:	e406                	sd	ra,8(sp)
    8000032a:	e022                	sd	s0,0(sp)
    8000032c:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    8000032e:	00001097          	auipc	ra,0x1
    80000332:	e06080e7          	jalr	-506(ra) # 80001134 <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000336:	00009717          	auipc	a4,0x9
    8000033a:	cca70713          	addi	a4,a4,-822 # 80009000 <started>
  if(cpuid() == 0){
    8000033e:	c139                	beqz	a0,80000384 <main+0x5e>
    while(started == 0)
    80000340:	431c                	lw	a5,0(a4)
    80000342:	2781                	sext.w	a5,a5
    80000344:	dff5                	beqz	a5,80000340 <main+0x1a>
      ;
    __sync_synchronize();
    80000346:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    8000034a:	00001097          	auipc	ra,0x1
    8000034e:	dea080e7          	jalr	-534(ra) # 80001134 <cpuid>
    80000352:	85aa                	mv	a1,a0
    80000354:	00008517          	auipc	a0,0x8
    80000358:	ce450513          	addi	a0,a0,-796 # 80008038 <etext+0x38>
    8000035c:	00006097          	auipc	ra,0x6
    80000360:	fbe080e7          	jalr	-66(ra) # 8000631a <printf>
    kvminithart();    // turn on paging
    80000364:	00000097          	auipc	ra,0x0
    80000368:	0d8080e7          	jalr	216(ra) # 8000043c <kvminithart>
    trapinithart();   // install kernel trap vector
    8000036c:	00002097          	auipc	ra,0x2
    80000370:	a40080e7          	jalr	-1472(ra) # 80001dac <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000374:	00005097          	auipc	ra,0x5
    80000378:	1fc080e7          	jalr	508(ra) # 80005570 <plicinithart>
  }

  scheduler();
    8000037c:	00001097          	auipc	ra,0x1
    80000380:	2ee080e7          	jalr	750(ra) # 8000166a <scheduler>
    consoleinit();
    80000384:	00006097          	auipc	ra,0x6
    80000388:	e5e080e7          	jalr	-418(ra) # 800061e2 <consoleinit>
    printfinit();
    8000038c:	00006097          	auipc	ra,0x6
    80000390:	174080e7          	jalr	372(ra) # 80006500 <printfinit>
    printf("\n");
    80000394:	00008517          	auipc	a0,0x8
    80000398:	cb450513          	addi	a0,a0,-844 # 80008048 <etext+0x48>
    8000039c:	00006097          	auipc	ra,0x6
    800003a0:	f7e080e7          	jalr	-130(ra) # 8000631a <printf>
    printf("xv6 kernel is booting\n");
    800003a4:	00008517          	auipc	a0,0x8
    800003a8:	c7c50513          	addi	a0,a0,-900 # 80008020 <etext+0x20>
    800003ac:	00006097          	auipc	ra,0x6
    800003b0:	f6e080e7          	jalr	-146(ra) # 8000631a <printf>
    printf("\n");
    800003b4:	00008517          	auipc	a0,0x8
    800003b8:	c9450513          	addi	a0,a0,-876 # 80008048 <etext+0x48>
    800003bc:	00006097          	auipc	ra,0x6
    800003c0:	f5e080e7          	jalr	-162(ra) # 8000631a <printf>
    kinit();         // physical page allocator
    800003c4:	00000097          	auipc	ra,0x0
    800003c8:	d18080e7          	jalr	-744(ra) # 800000dc <kinit>
    kvminit();       // create kernel page table
    800003cc:	00000097          	auipc	ra,0x0
    800003d0:	322080e7          	jalr	802(ra) # 800006ee <kvminit>
    kvminithart();   // turn on paging
    800003d4:	00000097          	auipc	ra,0x0
    800003d8:	068080e7          	jalr	104(ra) # 8000043c <kvminithart>
    procinit();      // process table
    800003dc:	00001097          	auipc	ra,0x1
    800003e0:	caa080e7          	jalr	-854(ra) # 80001086 <procinit>
    trapinit();      // trap vectors
    800003e4:	00002097          	auipc	ra,0x2
    800003e8:	9a0080e7          	jalr	-1632(ra) # 80001d84 <trapinit>
    trapinithart();  // install kernel trap vector
    800003ec:	00002097          	auipc	ra,0x2
    800003f0:	9c0080e7          	jalr	-1600(ra) # 80001dac <trapinithart>
    plicinit();      // set up interrupt controller
    800003f4:	00005097          	auipc	ra,0x5
    800003f8:	166080e7          	jalr	358(ra) # 8000555a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    800003fc:	00005097          	auipc	ra,0x5
    80000400:	174080e7          	jalr	372(ra) # 80005570 <plicinithart>
    binit();         // buffer cache
    80000404:	00002097          	auipc	ra,0x2
    80000408:	1ee080e7          	jalr	494(ra) # 800025f2 <binit>
    iinit();         // inode table
    8000040c:	00003097          	auipc	ra,0x3
    80000410:	86e080e7          	jalr	-1938(ra) # 80002c7a <iinit>
    fileinit();      // file table
    80000414:	00004097          	auipc	ra,0x4
    80000418:	98e080e7          	jalr	-1650(ra) # 80003da2 <fileinit>
    virtio_disk_init(); // emulated hard disk
    8000041c:	00005097          	auipc	ra,0x5
    80000420:	276080e7          	jalr	630(ra) # 80005692 <virtio_disk_init>
    userinit();      // first user process
    80000424:	00001097          	auipc	ra,0x1
    80000428:	014080e7          	jalr	20(ra) # 80001438 <userinit>
    __sync_synchronize();
    8000042c:	0ff0000f          	fence
    started = 1;
    80000430:	4785                	li	a5,1
    80000432:	00009717          	auipc	a4,0x9
    80000436:	bcf72723          	sw	a5,-1074(a4) # 80009000 <started>
    8000043a:	b789                	j	8000037c <main+0x56>

000000008000043c <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    8000043c:	1141                	addi	sp,sp,-16
    8000043e:	e422                	sd	s0,8(sp)
    80000440:	0800                	addi	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    80000442:	00009797          	auipc	a5,0x9
    80000446:	bc67b783          	ld	a5,-1082(a5) # 80009008 <kernel_pagetable>
    8000044a:	83b1                	srli	a5,a5,0xc
    8000044c:	577d                	li	a4,-1
    8000044e:	177e                	slli	a4,a4,0x3f
    80000450:	8fd9                	or	a5,a5,a4
// supervisor address translation and protection;
// holds the address of the page table.
static inline void
w_satp(uint64 x)
{
  asm volatile("csrw satp, %0" : : "r" (x));
    80000452:	18079073          	csrw	satp,a5
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80000456:	12000073          	sfence.vma
  sfence_vma();
}
    8000045a:	6422                	ld	s0,8(sp)
    8000045c:	0141                	addi	sp,sp,16
    8000045e:	8082                	ret

0000000080000460 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80000460:	7139                	addi	sp,sp,-64
    80000462:	fc06                	sd	ra,56(sp)
    80000464:	f822                	sd	s0,48(sp)
    80000466:	f426                	sd	s1,40(sp)
    80000468:	f04a                	sd	s2,32(sp)
    8000046a:	ec4e                	sd	s3,24(sp)
    8000046c:	e852                	sd	s4,16(sp)
    8000046e:	e456                	sd	s5,8(sp)
    80000470:	e05a                	sd	s6,0(sp)
    80000472:	0080                	addi	s0,sp,64
    80000474:	84aa                	mv	s1,a0
    80000476:	89ae                	mv	s3,a1
    80000478:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    8000047a:	57fd                	li	a5,-1
    8000047c:	83e9                	srli	a5,a5,0x1a
    8000047e:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80000480:	4b31                	li	s6,12
  if(va >= MAXVA)
    80000482:	04b7f263          	bgeu	a5,a1,800004c6 <walk+0x66>
    panic("walk");
    80000486:	00008517          	auipc	a0,0x8
    8000048a:	bca50513          	addi	a0,a0,-1078 # 80008050 <etext+0x50>
    8000048e:	00006097          	auipc	ra,0x6
    80000492:	e42080e7          	jalr	-446(ra) # 800062d0 <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80000496:	060a8663          	beqz	s5,80000502 <walk+0xa2>
    8000049a:	00000097          	auipc	ra,0x0
    8000049e:	c7e080e7          	jalr	-898(ra) # 80000118 <kalloc>
    800004a2:	84aa                	mv	s1,a0
    800004a4:	c529                	beqz	a0,800004ee <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    800004a6:	6605                	lui	a2,0x1
    800004a8:	4581                	li	a1,0
    800004aa:	00000097          	auipc	ra,0x0
    800004ae:	cce080e7          	jalr	-818(ra) # 80000178 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    800004b2:	00c4d793          	srli	a5,s1,0xc
    800004b6:	07aa                	slli	a5,a5,0xa
    800004b8:	0017e793          	ori	a5,a5,1
    800004bc:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    800004c0:	3a5d                	addiw	s4,s4,-9
    800004c2:	036a0063          	beq	s4,s6,800004e2 <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    800004c6:	0149d933          	srl	s2,s3,s4
    800004ca:	1ff97913          	andi	s2,s2,511
    800004ce:	090e                	slli	s2,s2,0x3
    800004d0:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    800004d2:	00093483          	ld	s1,0(s2)
    800004d6:	0014f793          	andi	a5,s1,1
    800004da:	dfd5                	beqz	a5,80000496 <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    800004dc:	80a9                	srli	s1,s1,0xa
    800004de:	04b2                	slli	s1,s1,0xc
    800004e0:	b7c5                	j	800004c0 <walk+0x60>
    }
  }

  pte_t *pte = &pagetable[PX(0, va)];
    800004e2:	00c9d513          	srli	a0,s3,0xc
    800004e6:	1ff57513          	andi	a0,a0,511
    800004ea:	050e                	slli	a0,a0,0x3
    800004ec:	9526                	add	a0,a0,s1
// TODO
#elif defined(PG_REPLACEMENT_USE_FIFO)
// TODO
#endif
  return pte;
}
    800004ee:	70e2                	ld	ra,56(sp)
    800004f0:	7442                	ld	s0,48(sp)
    800004f2:	74a2                	ld	s1,40(sp)
    800004f4:	7902                	ld	s2,32(sp)
    800004f6:	69e2                	ld	s3,24(sp)
    800004f8:	6a42                	ld	s4,16(sp)
    800004fa:	6aa2                	ld	s5,8(sp)
    800004fc:	6b02                	ld	s6,0(sp)
    800004fe:	6121                	addi	sp,sp,64
    80000500:	8082                	ret
        return 0;
    80000502:	4501                	li	a0,0
    80000504:	b7ed                	j	800004ee <walk+0x8e>

0000000080000506 <walkaddr>:
uint64
walkaddr(pagetable_t pagetable, uint64 va) {
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80000506:	57fd                	li	a5,-1
    80000508:	83e9                	srli	a5,a5,0x1a
    8000050a:	00b7f463          	bgeu	a5,a1,80000512 <walkaddr+0xc>
    return 0;
    8000050e:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80000510:	8082                	ret
walkaddr(pagetable_t pagetable, uint64 va) {
    80000512:	1141                	addi	sp,sp,-16
    80000514:	e406                	sd	ra,8(sp)
    80000516:	e022                	sd	s0,0(sp)
    80000518:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    8000051a:	4601                	li	a2,0
    8000051c:	00000097          	auipc	ra,0x0
    80000520:	f44080e7          	jalr	-188(ra) # 80000460 <walk>
  if(pte == 0)
    80000524:	c105                	beqz	a0,80000544 <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    80000526:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    80000528:	0117f693          	andi	a3,a5,17
    8000052c:	4745                	li	a4,17
    return 0;
    8000052e:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    80000530:	00e68663          	beq	a3,a4,8000053c <walkaddr+0x36>
}
    80000534:	60a2                	ld	ra,8(sp)
    80000536:	6402                	ld	s0,0(sp)
    80000538:	0141                	addi	sp,sp,16
    8000053a:	8082                	ret
  pa = PTE2PA(*pte);
    8000053c:	00a7d513          	srli	a0,a5,0xa
    80000540:	0532                	slli	a0,a0,0xc
  return pa;
    80000542:	bfcd                	j	80000534 <walkaddr+0x2e>
    return 0;
    80000544:	4501                	li	a0,0
    80000546:	b7fd                	j	80000534 <walkaddr+0x2e>

0000000080000548 <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80000548:	715d                	addi	sp,sp,-80
    8000054a:	e486                	sd	ra,72(sp)
    8000054c:	e0a2                	sd	s0,64(sp)
    8000054e:	fc26                	sd	s1,56(sp)
    80000550:	f84a                	sd	s2,48(sp)
    80000552:	f44e                	sd	s3,40(sp)
    80000554:	f052                	sd	s4,32(sp)
    80000556:	ec56                	sd	s5,24(sp)
    80000558:	e85a                	sd	s6,16(sp)
    8000055a:	e45e                	sd	s7,8(sp)
    8000055c:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    8000055e:	c205                	beqz	a2,8000057e <mappages+0x36>
    80000560:	8aaa                	mv	s5,a0
    80000562:	8b3a                	mv	s6,a4
    panic("mappages: size");
  a = PGROUNDDOWN(va);
    80000564:	77fd                	lui	a5,0xfffff
    80000566:	00f5fa33          	and	s4,a1,a5
  last = PGROUNDDOWN(va + size - 1);
    8000056a:	15fd                	addi	a1,a1,-1
    8000056c:	00c589b3          	add	s3,a1,a2
    80000570:	00f9f9b3          	and	s3,s3,a5
  a = PGROUNDDOWN(va);
    80000574:	8952                	mv	s2,s4
    80000576:	41468a33          	sub	s4,a3,s4
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    8000057a:	6b85                	lui	s7,0x1
    8000057c:	a015                	j	800005a0 <mappages+0x58>
    panic("mappages: size");
    8000057e:	00008517          	auipc	a0,0x8
    80000582:	ada50513          	addi	a0,a0,-1318 # 80008058 <etext+0x58>
    80000586:	00006097          	auipc	ra,0x6
    8000058a:	d4a080e7          	jalr	-694(ra) # 800062d0 <panic>
      panic("mappages: remap");
    8000058e:	00008517          	auipc	a0,0x8
    80000592:	ada50513          	addi	a0,a0,-1318 # 80008068 <etext+0x68>
    80000596:	00006097          	auipc	ra,0x6
    8000059a:	d3a080e7          	jalr	-710(ra) # 800062d0 <panic>
    a += PGSIZE;
    8000059e:	995e                	add	s2,s2,s7
  for(;;){
    800005a0:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    800005a4:	4605                	li	a2,1
    800005a6:	85ca                	mv	a1,s2
    800005a8:	8556                	mv	a0,s5
    800005aa:	00000097          	auipc	ra,0x0
    800005ae:	eb6080e7          	jalr	-330(ra) # 80000460 <walk>
    800005b2:	cd19                	beqz	a0,800005d0 <mappages+0x88>
    if(*pte & PTE_V)
    800005b4:	611c                	ld	a5,0(a0)
    800005b6:	8b85                	andi	a5,a5,1
    800005b8:	fbf9                	bnez	a5,8000058e <mappages+0x46>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800005ba:	80b1                	srli	s1,s1,0xc
    800005bc:	04aa                	slli	s1,s1,0xa
    800005be:	0164e4b3          	or	s1,s1,s6
    800005c2:	0014e493          	ori	s1,s1,1
    800005c6:	e104                	sd	s1,0(a0)
    if(a == last)
    800005c8:	fd391be3          	bne	s2,s3,8000059e <mappages+0x56>
    pa += PGSIZE;
  }
  return 0;
    800005cc:	4501                	li	a0,0
    800005ce:	a011                	j	800005d2 <mappages+0x8a>
      return -1;
    800005d0:	557d                	li	a0,-1
}
    800005d2:	60a6                	ld	ra,72(sp)
    800005d4:	6406                	ld	s0,64(sp)
    800005d6:	74e2                	ld	s1,56(sp)
    800005d8:	7942                	ld	s2,48(sp)
    800005da:	79a2                	ld	s3,40(sp)
    800005dc:	7a02                	ld	s4,32(sp)
    800005de:	6ae2                	ld	s5,24(sp)
    800005e0:	6b42                	ld	s6,16(sp)
    800005e2:	6ba2                	ld	s7,8(sp)
    800005e4:	6161                	addi	sp,sp,80
    800005e6:	8082                	ret

00000000800005e8 <kvmmap>:
{
    800005e8:	1141                	addi	sp,sp,-16
    800005ea:	e406                	sd	ra,8(sp)
    800005ec:	e022                	sd	s0,0(sp)
    800005ee:	0800                	addi	s0,sp,16
    800005f0:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    800005f2:	86b2                	mv	a3,a2
    800005f4:	863e                	mv	a2,a5
    800005f6:	00000097          	auipc	ra,0x0
    800005fa:	f52080e7          	jalr	-174(ra) # 80000548 <mappages>
    800005fe:	e509                	bnez	a0,80000608 <kvmmap+0x20>
}
    80000600:	60a2                	ld	ra,8(sp)
    80000602:	6402                	ld	s0,0(sp)
    80000604:	0141                	addi	sp,sp,16
    80000606:	8082                	ret
    panic("kvmmap");
    80000608:	00008517          	auipc	a0,0x8
    8000060c:	a7050513          	addi	a0,a0,-1424 # 80008078 <etext+0x78>
    80000610:	00006097          	auipc	ra,0x6
    80000614:	cc0080e7          	jalr	-832(ra) # 800062d0 <panic>

0000000080000618 <kvmmake>:
{
    80000618:	1101                	addi	sp,sp,-32
    8000061a:	ec06                	sd	ra,24(sp)
    8000061c:	e822                	sd	s0,16(sp)
    8000061e:	e426                	sd	s1,8(sp)
    80000620:	e04a                	sd	s2,0(sp)
    80000622:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    80000624:	00000097          	auipc	ra,0x0
    80000628:	af4080e7          	jalr	-1292(ra) # 80000118 <kalloc>
    8000062c:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    8000062e:	6605                	lui	a2,0x1
    80000630:	4581                	li	a1,0
    80000632:	00000097          	auipc	ra,0x0
    80000636:	b46080e7          	jalr	-1210(ra) # 80000178 <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    8000063a:	4719                	li	a4,6
    8000063c:	6685                	lui	a3,0x1
    8000063e:	10000637          	lui	a2,0x10000
    80000642:	100005b7          	lui	a1,0x10000
    80000646:	8526                	mv	a0,s1
    80000648:	00000097          	auipc	ra,0x0
    8000064c:	fa0080e7          	jalr	-96(ra) # 800005e8 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    80000650:	4719                	li	a4,6
    80000652:	6685                	lui	a3,0x1
    80000654:	10001637          	lui	a2,0x10001
    80000658:	100015b7          	lui	a1,0x10001
    8000065c:	8526                	mv	a0,s1
    8000065e:	00000097          	auipc	ra,0x0
    80000662:	f8a080e7          	jalr	-118(ra) # 800005e8 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    80000666:	4719                	li	a4,6
    80000668:	004006b7          	lui	a3,0x400
    8000066c:	0c000637          	lui	a2,0xc000
    80000670:	0c0005b7          	lui	a1,0xc000
    80000674:	8526                	mv	a0,s1
    80000676:	00000097          	auipc	ra,0x0
    8000067a:	f72080e7          	jalr	-142(ra) # 800005e8 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    8000067e:	00008917          	auipc	s2,0x8
    80000682:	98290913          	addi	s2,s2,-1662 # 80008000 <etext>
    80000686:	4729                	li	a4,10
    80000688:	80008697          	auipc	a3,0x80008
    8000068c:	97868693          	addi	a3,a3,-1672 # 8000 <_entry-0x7fff8000>
    80000690:	4605                	li	a2,1
    80000692:	067e                	slli	a2,a2,0x1f
    80000694:	85b2                	mv	a1,a2
    80000696:	8526                	mv	a0,s1
    80000698:	00000097          	auipc	ra,0x0
    8000069c:	f50080e7          	jalr	-176(ra) # 800005e8 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800006a0:	4719                	li	a4,6
    800006a2:	46c5                	li	a3,17
    800006a4:	06ee                	slli	a3,a3,0x1b
    800006a6:	412686b3          	sub	a3,a3,s2
    800006aa:	864a                	mv	a2,s2
    800006ac:	85ca                	mv	a1,s2
    800006ae:	8526                	mv	a0,s1
    800006b0:	00000097          	auipc	ra,0x0
    800006b4:	f38080e7          	jalr	-200(ra) # 800005e8 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800006b8:	4729                	li	a4,10
    800006ba:	6685                	lui	a3,0x1
    800006bc:	00007617          	auipc	a2,0x7
    800006c0:	94460613          	addi	a2,a2,-1724 # 80007000 <_trampoline>
    800006c4:	040005b7          	lui	a1,0x4000
    800006c8:	15fd                	addi	a1,a1,-1
    800006ca:	05b2                	slli	a1,a1,0xc
    800006cc:	8526                	mv	a0,s1
    800006ce:	00000097          	auipc	ra,0x0
    800006d2:	f1a080e7          	jalr	-230(ra) # 800005e8 <kvmmap>
  proc_mapstacks(kpgtbl);
    800006d6:	8526                	mv	a0,s1
    800006d8:	00001097          	auipc	ra,0x1
    800006dc:	91a080e7          	jalr	-1766(ra) # 80000ff2 <proc_mapstacks>
}
    800006e0:	8526                	mv	a0,s1
    800006e2:	60e2                	ld	ra,24(sp)
    800006e4:	6442                	ld	s0,16(sp)
    800006e6:	64a2                	ld	s1,8(sp)
    800006e8:	6902                	ld	s2,0(sp)
    800006ea:	6105                	addi	sp,sp,32
    800006ec:	8082                	ret

00000000800006ee <kvminit>:
{
    800006ee:	1141                	addi	sp,sp,-16
    800006f0:	e406                	sd	ra,8(sp)
    800006f2:	e022                	sd	s0,0(sp)
    800006f4:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    800006f6:	00000097          	auipc	ra,0x0
    800006fa:	f22080e7          	jalr	-222(ra) # 80000618 <kvmmake>
    800006fe:	00009797          	auipc	a5,0x9
    80000702:	90a7b523          	sd	a0,-1782(a5) # 80009008 <kernel_pagetable>
}
    80000706:	60a2                	ld	ra,8(sp)
    80000708:	6402                	ld	s0,0(sp)
    8000070a:	0141                	addi	sp,sp,16
    8000070c:	8082                	ret

000000008000070e <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    8000070e:	715d                	addi	sp,sp,-80
    80000710:	e486                	sd	ra,72(sp)
    80000712:	e0a2                	sd	s0,64(sp)
    80000714:	fc26                	sd	s1,56(sp)
    80000716:	f84a                	sd	s2,48(sp)
    80000718:	f44e                	sd	s3,40(sp)
    8000071a:	f052                	sd	s4,32(sp)
    8000071c:	ec56                	sd	s5,24(sp)
    8000071e:	e85a                	sd	s6,16(sp)
    80000720:	e45e                	sd	s7,8(sp)
    80000722:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80000724:	03459793          	slli	a5,a1,0x34
    80000728:	e795                	bnez	a5,80000754 <uvmunmap+0x46>
    8000072a:	8a2a                	mv	s4,a0
    8000072c:	892e                	mv	s2,a1
    8000072e:	8b36                	mv	s6,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000730:	0632                	slli	a2,a2,0xc
    80000732:	00b609b3          	add	s3,a2,a1
    }

    if((*pte & PTE_V) == 0)
      continue;

    if(PTE_FLAGS(*pte) == PTE_V)
    80000736:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000738:	6a85                	lui	s5,0x1
    8000073a:	0735e163          	bltu	a1,s3,8000079c <uvmunmap+0x8e>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    8000073e:	60a6                	ld	ra,72(sp)
    80000740:	6406                	ld	s0,64(sp)
    80000742:	74e2                	ld	s1,56(sp)
    80000744:	7942                	ld	s2,48(sp)
    80000746:	79a2                	ld	s3,40(sp)
    80000748:	7a02                	ld	s4,32(sp)
    8000074a:	6ae2                	ld	s5,24(sp)
    8000074c:	6b42                	ld	s6,16(sp)
    8000074e:	6ba2                	ld	s7,8(sp)
    80000750:	6161                	addi	sp,sp,80
    80000752:	8082                	ret
    panic("uvmunmap: not aligned");
    80000754:	00008517          	auipc	a0,0x8
    80000758:	92c50513          	addi	a0,a0,-1748 # 80008080 <etext+0x80>
    8000075c:	00006097          	auipc	ra,0x6
    80000760:	b74080e7          	jalr	-1164(ra) # 800062d0 <panic>
      panic("uvmunmap: walk");
    80000764:	00008517          	auipc	a0,0x8
    80000768:	93450513          	addi	a0,a0,-1740 # 80008098 <etext+0x98>
    8000076c:	00006097          	auipc	ra,0x6
    80000770:	b64080e7          	jalr	-1180(ra) # 800062d0 <panic>
      panic("uvmunmap: not a leaf");
    80000774:	00008517          	auipc	a0,0x8
    80000778:	93450513          	addi	a0,a0,-1740 # 800080a8 <etext+0xa8>
    8000077c:	00006097          	auipc	ra,0x6
    80000780:	b54080e7          	jalr	-1196(ra) # 800062d0 <panic>
      uint64 pa = PTE2PA(*pte);
    80000784:	83a9                	srli	a5,a5,0xa
      kfree((void*)pa);
    80000786:	00c79513          	slli	a0,a5,0xc
    8000078a:	00000097          	auipc	ra,0x0
    8000078e:	892080e7          	jalr	-1902(ra) # 8000001c <kfree>
    *pte = 0;
    80000792:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000796:	9956                	add	s2,s2,s5
    80000798:	fb3973e3          	bgeu	s2,s3,8000073e <uvmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    8000079c:	4601                	li	a2,0
    8000079e:	85ca                	mv	a1,s2
    800007a0:	8552                	mv	a0,s4
    800007a2:	00000097          	auipc	ra,0x0
    800007a6:	cbe080e7          	jalr	-834(ra) # 80000460 <walk>
    800007aa:	84aa                	mv	s1,a0
    800007ac:	dd45                	beqz	a0,80000764 <uvmunmap+0x56>
    if(*pte & PTE_S) {
    800007ae:	611c                	ld	a5,0(a0)
    800007b0:	2007f713          	andi	a4,a5,512
    800007b4:	f36d                	bnez	a4,80000796 <uvmunmap+0x88>
    if((*pte & PTE_V) == 0)
    800007b6:	0017f713          	andi	a4,a5,1
    800007ba:	df71                	beqz	a4,80000796 <uvmunmap+0x88>
    if(PTE_FLAGS(*pte) == PTE_V)
    800007bc:	3ff7f713          	andi	a4,a5,1023
    800007c0:	fb770ae3          	beq	a4,s7,80000774 <uvmunmap+0x66>
    if(do_free){
    800007c4:	fc0b07e3          	beqz	s6,80000792 <uvmunmap+0x84>
    800007c8:	bf75                	j	80000784 <uvmunmap+0x76>

00000000800007ca <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    800007ca:	1101                	addi	sp,sp,-32
    800007cc:	ec06                	sd	ra,24(sp)
    800007ce:	e822                	sd	s0,16(sp)
    800007d0:	e426                	sd	s1,8(sp)
    800007d2:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    800007d4:	00000097          	auipc	ra,0x0
    800007d8:	944080e7          	jalr	-1724(ra) # 80000118 <kalloc>
    800007dc:	84aa                	mv	s1,a0
  if(pagetable == 0)
    800007de:	c519                	beqz	a0,800007ec <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    800007e0:	6605                	lui	a2,0x1
    800007e2:	4581                	li	a1,0
    800007e4:	00000097          	auipc	ra,0x0
    800007e8:	994080e7          	jalr	-1644(ra) # 80000178 <memset>
  return pagetable;
}
    800007ec:	8526                	mv	a0,s1
    800007ee:	60e2                	ld	ra,24(sp)
    800007f0:	6442                	ld	s0,16(sp)
    800007f2:	64a2                	ld	s1,8(sp)
    800007f4:	6105                	addi	sp,sp,32
    800007f6:	8082                	ret

00000000800007f8 <uvminit>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvminit(pagetable_t pagetable, uchar *src, uint sz)
{
    800007f8:	7179                	addi	sp,sp,-48
    800007fa:	f406                	sd	ra,40(sp)
    800007fc:	f022                	sd	s0,32(sp)
    800007fe:	ec26                	sd	s1,24(sp)
    80000800:	e84a                	sd	s2,16(sp)
    80000802:	e44e                	sd	s3,8(sp)
    80000804:	e052                	sd	s4,0(sp)
    80000806:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    80000808:	6785                	lui	a5,0x1
    8000080a:	04f67863          	bgeu	a2,a5,8000085a <uvminit+0x62>
    8000080e:	8a2a                	mv	s4,a0
    80000810:	89ae                	mv	s3,a1
    80000812:	84b2                	mv	s1,a2
    panic("inituvm: more than a page");
  mem = kalloc();
    80000814:	00000097          	auipc	ra,0x0
    80000818:	904080e7          	jalr	-1788(ra) # 80000118 <kalloc>
    8000081c:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    8000081e:	6605                	lui	a2,0x1
    80000820:	4581                	li	a1,0
    80000822:	00000097          	auipc	ra,0x0
    80000826:	956080e7          	jalr	-1706(ra) # 80000178 <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    8000082a:	4779                	li	a4,30
    8000082c:	86ca                	mv	a3,s2
    8000082e:	6605                	lui	a2,0x1
    80000830:	4581                	li	a1,0
    80000832:	8552                	mv	a0,s4
    80000834:	00000097          	auipc	ra,0x0
    80000838:	d14080e7          	jalr	-748(ra) # 80000548 <mappages>
  memmove(mem, src, sz);
    8000083c:	8626                	mv	a2,s1
    8000083e:	85ce                	mv	a1,s3
    80000840:	854a                	mv	a0,s2
    80000842:	00000097          	auipc	ra,0x0
    80000846:	996080e7          	jalr	-1642(ra) # 800001d8 <memmove>
}
    8000084a:	70a2                	ld	ra,40(sp)
    8000084c:	7402                	ld	s0,32(sp)
    8000084e:	64e2                	ld	s1,24(sp)
    80000850:	6942                	ld	s2,16(sp)
    80000852:	69a2                	ld	s3,8(sp)
    80000854:	6a02                	ld	s4,0(sp)
    80000856:	6145                	addi	sp,sp,48
    80000858:	8082                	ret
    panic("inituvm: more than a page");
    8000085a:	00008517          	auipc	a0,0x8
    8000085e:	86650513          	addi	a0,a0,-1946 # 800080c0 <etext+0xc0>
    80000862:	00006097          	auipc	ra,0x6
    80000866:	a6e080e7          	jalr	-1426(ra) # 800062d0 <panic>

000000008000086a <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    8000086a:	1101                	addi	sp,sp,-32
    8000086c:	ec06                	sd	ra,24(sp)
    8000086e:	e822                	sd	s0,16(sp)
    80000870:	e426                	sd	s1,8(sp)
    80000872:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    80000874:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    80000876:	00b67d63          	bgeu	a2,a1,80000890 <uvmdealloc+0x26>
    8000087a:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    8000087c:	6785                	lui	a5,0x1
    8000087e:	17fd                	addi	a5,a5,-1
    80000880:	00f60733          	add	a4,a2,a5
    80000884:	767d                	lui	a2,0xfffff
    80000886:	8f71                	and	a4,a4,a2
    80000888:	97ae                	add	a5,a5,a1
    8000088a:	8ff1                	and	a5,a5,a2
    8000088c:	00f76863          	bltu	a4,a5,8000089c <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    80000890:	8526                	mv	a0,s1
    80000892:	60e2                	ld	ra,24(sp)
    80000894:	6442                	ld	s0,16(sp)
    80000896:	64a2                	ld	s1,8(sp)
    80000898:	6105                	addi	sp,sp,32
    8000089a:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    8000089c:	8f99                	sub	a5,a5,a4
    8000089e:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    800008a0:	4685                	li	a3,1
    800008a2:	0007861b          	sext.w	a2,a5
    800008a6:	85ba                	mv	a1,a4
    800008a8:	00000097          	auipc	ra,0x0
    800008ac:	e66080e7          	jalr	-410(ra) # 8000070e <uvmunmap>
    800008b0:	b7c5                	j	80000890 <uvmdealloc+0x26>

00000000800008b2 <uvmalloc>:
  if(newsz < oldsz)
    800008b2:	0ab66163          	bltu	a2,a1,80000954 <uvmalloc+0xa2>
{
    800008b6:	7139                	addi	sp,sp,-64
    800008b8:	fc06                	sd	ra,56(sp)
    800008ba:	f822                	sd	s0,48(sp)
    800008bc:	f426                	sd	s1,40(sp)
    800008be:	f04a                	sd	s2,32(sp)
    800008c0:	ec4e                	sd	s3,24(sp)
    800008c2:	e852                	sd	s4,16(sp)
    800008c4:	e456                	sd	s5,8(sp)
    800008c6:	0080                	addi	s0,sp,64
    800008c8:	8aaa                	mv	s5,a0
    800008ca:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    800008cc:	6985                	lui	s3,0x1
    800008ce:	19fd                	addi	s3,s3,-1
    800008d0:	95ce                	add	a1,a1,s3
    800008d2:	79fd                	lui	s3,0xfffff
    800008d4:	0135f9b3          	and	s3,a1,s3
  for(a = oldsz; a < newsz; a += PGSIZE){
    800008d8:	08c9f063          	bgeu	s3,a2,80000958 <uvmalloc+0xa6>
    800008dc:	894e                	mv	s2,s3
    mem = kalloc();
    800008de:	00000097          	auipc	ra,0x0
    800008e2:	83a080e7          	jalr	-1990(ra) # 80000118 <kalloc>
    800008e6:	84aa                	mv	s1,a0
    if(mem == 0){
    800008e8:	c51d                	beqz	a0,80000916 <uvmalloc+0x64>
    memset(mem, 0, PGSIZE);
    800008ea:	6605                	lui	a2,0x1
    800008ec:	4581                	li	a1,0
    800008ee:	00000097          	auipc	ra,0x0
    800008f2:	88a080e7          	jalr	-1910(ra) # 80000178 <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    800008f6:	4779                	li	a4,30
    800008f8:	86a6                	mv	a3,s1
    800008fa:	6605                	lui	a2,0x1
    800008fc:	85ca                	mv	a1,s2
    800008fe:	8556                	mv	a0,s5
    80000900:	00000097          	auipc	ra,0x0
    80000904:	c48080e7          	jalr	-952(ra) # 80000548 <mappages>
    80000908:	e905                	bnez	a0,80000938 <uvmalloc+0x86>
  for(a = oldsz; a < newsz; a += PGSIZE){
    8000090a:	6785                	lui	a5,0x1
    8000090c:	993e                	add	s2,s2,a5
    8000090e:	fd4968e3          	bltu	s2,s4,800008de <uvmalloc+0x2c>
  return newsz;
    80000912:	8552                	mv	a0,s4
    80000914:	a809                	j	80000926 <uvmalloc+0x74>
      uvmdealloc(pagetable, a, oldsz);
    80000916:	864e                	mv	a2,s3
    80000918:	85ca                	mv	a1,s2
    8000091a:	8556                	mv	a0,s5
    8000091c:	00000097          	auipc	ra,0x0
    80000920:	f4e080e7          	jalr	-178(ra) # 8000086a <uvmdealloc>
      return 0;
    80000924:	4501                	li	a0,0
}
    80000926:	70e2                	ld	ra,56(sp)
    80000928:	7442                	ld	s0,48(sp)
    8000092a:	74a2                	ld	s1,40(sp)
    8000092c:	7902                	ld	s2,32(sp)
    8000092e:	69e2                	ld	s3,24(sp)
    80000930:	6a42                	ld	s4,16(sp)
    80000932:	6aa2                	ld	s5,8(sp)
    80000934:	6121                	addi	sp,sp,64
    80000936:	8082                	ret
      kfree(mem);
    80000938:	8526                	mv	a0,s1
    8000093a:	fffff097          	auipc	ra,0xfffff
    8000093e:	6e2080e7          	jalr	1762(ra) # 8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80000942:	864e                	mv	a2,s3
    80000944:	85ca                	mv	a1,s2
    80000946:	8556                	mv	a0,s5
    80000948:	00000097          	auipc	ra,0x0
    8000094c:	f22080e7          	jalr	-222(ra) # 8000086a <uvmdealloc>
      return 0;
    80000950:	4501                	li	a0,0
    80000952:	bfd1                	j	80000926 <uvmalloc+0x74>
    return oldsz;
    80000954:	852e                	mv	a0,a1
}
    80000956:	8082                	ret
  return newsz;
    80000958:	8532                	mv	a0,a2
    8000095a:	b7f1                	j	80000926 <uvmalloc+0x74>

000000008000095c <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    8000095c:	7179                	addi	sp,sp,-48
    8000095e:	f406                	sd	ra,40(sp)
    80000960:	f022                	sd	s0,32(sp)
    80000962:	ec26                	sd	s1,24(sp)
    80000964:	e84a                	sd	s2,16(sp)
    80000966:	e44e                	sd	s3,8(sp)
    80000968:	e052                	sd	s4,0(sp)
    8000096a:	1800                	addi	s0,sp,48
    8000096c:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    8000096e:	84aa                	mv	s1,a0
    80000970:	6905                	lui	s2,0x1
    80000972:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000974:	4985                	li	s3,1
    80000976:	a821                	j	8000098e <freewalk+0x32>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    80000978:	8129                	srli	a0,a0,0xa
      freewalk((pagetable_t)child);
    8000097a:	0532                	slli	a0,a0,0xc
    8000097c:	00000097          	auipc	ra,0x0
    80000980:	fe0080e7          	jalr	-32(ra) # 8000095c <freewalk>
      pagetable[i] = 0;
    80000984:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    80000988:	04a1                	addi	s1,s1,8
    8000098a:	03248163          	beq	s1,s2,800009ac <freewalk+0x50>
    pte_t pte = pagetable[i];
    8000098e:	6088                	ld	a0,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000990:	00f57793          	andi	a5,a0,15
    80000994:	ff3782e3          	beq	a5,s3,80000978 <freewalk+0x1c>
    } else if(pte & PTE_V){
    80000998:	8905                	andi	a0,a0,1
    8000099a:	d57d                	beqz	a0,80000988 <freewalk+0x2c>
      panic("freewalk: leaf");
    8000099c:	00007517          	auipc	a0,0x7
    800009a0:	74450513          	addi	a0,a0,1860 # 800080e0 <etext+0xe0>
    800009a4:	00006097          	auipc	ra,0x6
    800009a8:	92c080e7          	jalr	-1748(ra) # 800062d0 <panic>
    }
  }
  kfree((void*)pagetable);
    800009ac:	8552                	mv	a0,s4
    800009ae:	fffff097          	auipc	ra,0xfffff
    800009b2:	66e080e7          	jalr	1646(ra) # 8000001c <kfree>
}
    800009b6:	70a2                	ld	ra,40(sp)
    800009b8:	7402                	ld	s0,32(sp)
    800009ba:	64e2                	ld	s1,24(sp)
    800009bc:	6942                	ld	s2,16(sp)
    800009be:	69a2                	ld	s3,8(sp)
    800009c0:	6a02                	ld	s4,0(sp)
    800009c2:	6145                	addi	sp,sp,48
    800009c4:	8082                	ret

00000000800009c6 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    800009c6:	1101                	addi	sp,sp,-32
    800009c8:	ec06                	sd	ra,24(sp)
    800009ca:	e822                	sd	s0,16(sp)
    800009cc:	e426                	sd	s1,8(sp)
    800009ce:	1000                	addi	s0,sp,32
    800009d0:	84aa                	mv	s1,a0
  if(sz > 0)
    800009d2:	e999                	bnez	a1,800009e8 <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    800009d4:	8526                	mv	a0,s1
    800009d6:	00000097          	auipc	ra,0x0
    800009da:	f86080e7          	jalr	-122(ra) # 8000095c <freewalk>
}
    800009de:	60e2                	ld	ra,24(sp)
    800009e0:	6442                	ld	s0,16(sp)
    800009e2:	64a2                	ld	s1,8(sp)
    800009e4:	6105                	addi	sp,sp,32
    800009e6:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    800009e8:	6605                	lui	a2,0x1
    800009ea:	167d                	addi	a2,a2,-1
    800009ec:	962e                	add	a2,a2,a1
    800009ee:	4685                	li	a3,1
    800009f0:	8231                	srli	a2,a2,0xc
    800009f2:	4581                	li	a1,0
    800009f4:	00000097          	auipc	ra,0x0
    800009f8:	d1a080e7          	jalr	-742(ra) # 8000070e <uvmunmap>
    800009fc:	bfe1                	j	800009d4 <uvmfree+0xe>

00000000800009fe <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    800009fe:	c679                	beqz	a2,80000acc <uvmcopy+0xce>
{
    80000a00:	715d                	addi	sp,sp,-80
    80000a02:	e486                	sd	ra,72(sp)
    80000a04:	e0a2                	sd	s0,64(sp)
    80000a06:	fc26                	sd	s1,56(sp)
    80000a08:	f84a                	sd	s2,48(sp)
    80000a0a:	f44e                	sd	s3,40(sp)
    80000a0c:	f052                	sd	s4,32(sp)
    80000a0e:	ec56                	sd	s5,24(sp)
    80000a10:	e85a                	sd	s6,16(sp)
    80000a12:	e45e                	sd	s7,8(sp)
    80000a14:	0880                	addi	s0,sp,80
    80000a16:	8b2a                	mv	s6,a0
    80000a18:	8aae                	mv	s5,a1
    80000a1a:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    80000a1c:	4981                	li	s3,0
    if((pte = walk(old, i, 0)) == 0)
    80000a1e:	4601                	li	a2,0
    80000a20:	85ce                	mv	a1,s3
    80000a22:	855a                	mv	a0,s6
    80000a24:	00000097          	auipc	ra,0x0
    80000a28:	a3c080e7          	jalr	-1476(ra) # 80000460 <walk>
    80000a2c:	c531                	beqz	a0,80000a78 <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    80000a2e:	6118                	ld	a4,0(a0)
    80000a30:	00177793          	andi	a5,a4,1
    80000a34:	cbb1                	beqz	a5,80000a88 <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    80000a36:	00a75593          	srli	a1,a4,0xa
    80000a3a:	00c59b93          	slli	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    80000a3e:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == 0)
    80000a42:	fffff097          	auipc	ra,0xfffff
    80000a46:	6d6080e7          	jalr	1750(ra) # 80000118 <kalloc>
    80000a4a:	892a                	mv	s2,a0
    80000a4c:	c939                	beqz	a0,80000aa2 <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    80000a4e:	6605                	lui	a2,0x1
    80000a50:	85de                	mv	a1,s7
    80000a52:	fffff097          	auipc	ra,0xfffff
    80000a56:	786080e7          	jalr	1926(ra) # 800001d8 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80000a5a:	8726                	mv	a4,s1
    80000a5c:	86ca                	mv	a3,s2
    80000a5e:	6605                	lui	a2,0x1
    80000a60:	85ce                	mv	a1,s3
    80000a62:	8556                	mv	a0,s5
    80000a64:	00000097          	auipc	ra,0x0
    80000a68:	ae4080e7          	jalr	-1308(ra) # 80000548 <mappages>
    80000a6c:	e515                	bnez	a0,80000a98 <uvmcopy+0x9a>
  for(i = 0; i < sz; i += PGSIZE){
    80000a6e:	6785                	lui	a5,0x1
    80000a70:	99be                	add	s3,s3,a5
    80000a72:	fb49e6e3          	bltu	s3,s4,80000a1e <uvmcopy+0x20>
    80000a76:	a081                	j	80000ab6 <uvmcopy+0xb8>
      panic("uvmcopy: pte should exist");
    80000a78:	00007517          	auipc	a0,0x7
    80000a7c:	67850513          	addi	a0,a0,1656 # 800080f0 <etext+0xf0>
    80000a80:	00006097          	auipc	ra,0x6
    80000a84:	850080e7          	jalr	-1968(ra) # 800062d0 <panic>
      panic("uvmcopy: page not present");
    80000a88:	00007517          	auipc	a0,0x7
    80000a8c:	68850513          	addi	a0,a0,1672 # 80008110 <etext+0x110>
    80000a90:	00006097          	auipc	ra,0x6
    80000a94:	840080e7          	jalr	-1984(ra) # 800062d0 <panic>
      kfree(mem);
    80000a98:	854a                	mv	a0,s2
    80000a9a:	fffff097          	auipc	ra,0xfffff
    80000a9e:	582080e7          	jalr	1410(ra) # 8000001c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80000aa2:	4685                	li	a3,1
    80000aa4:	00c9d613          	srli	a2,s3,0xc
    80000aa8:	4581                	li	a1,0
    80000aaa:	8556                	mv	a0,s5
    80000aac:	00000097          	auipc	ra,0x0
    80000ab0:	c62080e7          	jalr	-926(ra) # 8000070e <uvmunmap>
  return -1;
    80000ab4:	557d                	li	a0,-1
}
    80000ab6:	60a6                	ld	ra,72(sp)
    80000ab8:	6406                	ld	s0,64(sp)
    80000aba:	74e2                	ld	s1,56(sp)
    80000abc:	7942                	ld	s2,48(sp)
    80000abe:	79a2                	ld	s3,40(sp)
    80000ac0:	7a02                	ld	s4,32(sp)
    80000ac2:	6ae2                	ld	s5,24(sp)
    80000ac4:	6b42                	ld	s6,16(sp)
    80000ac6:	6ba2                	ld	s7,8(sp)
    80000ac8:	6161                	addi	sp,sp,80
    80000aca:	8082                	ret
  return 0;
    80000acc:	4501                	li	a0,0
}
    80000ace:	8082                	ret

0000000080000ad0 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80000ad0:	1141                	addi	sp,sp,-16
    80000ad2:	e406                	sd	ra,8(sp)
    80000ad4:	e022                	sd	s0,0(sp)
    80000ad6:	0800                	addi	s0,sp,16
  pte_t *pte;
  pte = walk(pagetable, va, 0);
    80000ad8:	4601                	li	a2,0
    80000ada:	00000097          	auipc	ra,0x0
    80000ade:	986080e7          	jalr	-1658(ra) # 80000460 <walk>
  if(pte == 0)
    80000ae2:	c901                	beqz	a0,80000af2 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000ae4:	611c                	ld	a5,0(a0)
    80000ae6:	9bbd                	andi	a5,a5,-17
    80000ae8:	e11c                	sd	a5,0(a0)
}
    80000aea:	60a2                	ld	ra,8(sp)
    80000aec:	6402                	ld	s0,0(sp)
    80000aee:	0141                	addi	sp,sp,16
    80000af0:	8082                	ret
    panic("uvmclear");
    80000af2:	00007517          	auipc	a0,0x7
    80000af6:	63e50513          	addi	a0,a0,1598 # 80008130 <etext+0x130>
    80000afa:	00005097          	auipc	ra,0x5
    80000afe:	7d6080e7          	jalr	2006(ra) # 800062d0 <panic>

0000000080000b02 <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000b02:	c6bd                	beqz	a3,80000b70 <copyout+0x6e>
{
    80000b04:	715d                	addi	sp,sp,-80
    80000b06:	e486                	sd	ra,72(sp)
    80000b08:	e0a2                	sd	s0,64(sp)
    80000b0a:	fc26                	sd	s1,56(sp)
    80000b0c:	f84a                	sd	s2,48(sp)
    80000b0e:	f44e                	sd	s3,40(sp)
    80000b10:	f052                	sd	s4,32(sp)
    80000b12:	ec56                	sd	s5,24(sp)
    80000b14:	e85a                	sd	s6,16(sp)
    80000b16:	e45e                	sd	s7,8(sp)
    80000b18:	e062                	sd	s8,0(sp)
    80000b1a:	0880                	addi	s0,sp,80
    80000b1c:	8b2a                	mv	s6,a0
    80000b1e:	8c2e                	mv	s8,a1
    80000b20:	8a32                	mv	s4,a2
    80000b22:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    80000b24:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    80000b26:	6a85                	lui	s5,0x1
    80000b28:	a015                	j	80000b4c <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000b2a:	9562                	add	a0,a0,s8
    80000b2c:	0004861b          	sext.w	a2,s1
    80000b30:	85d2                	mv	a1,s4
    80000b32:	41250533          	sub	a0,a0,s2
    80000b36:	fffff097          	auipc	ra,0xfffff
    80000b3a:	6a2080e7          	jalr	1698(ra) # 800001d8 <memmove>

    len -= n;
    80000b3e:	409989b3          	sub	s3,s3,s1
    src += n;
    80000b42:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    80000b44:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000b48:	02098263          	beqz	s3,80000b6c <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    80000b4c:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000b50:	85ca                	mv	a1,s2
    80000b52:	855a                	mv	a0,s6
    80000b54:	00000097          	auipc	ra,0x0
    80000b58:	9b2080e7          	jalr	-1614(ra) # 80000506 <walkaddr>
    if(pa0 == 0)
    80000b5c:	cd01                	beqz	a0,80000b74 <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    80000b5e:	418904b3          	sub	s1,s2,s8
    80000b62:	94d6                	add	s1,s1,s5
    if(n > len)
    80000b64:	fc99f3e3          	bgeu	s3,s1,80000b2a <copyout+0x28>
    80000b68:	84ce                	mv	s1,s3
    80000b6a:	b7c1                	j	80000b2a <copyout+0x28>
  }
  return 0;
    80000b6c:	4501                	li	a0,0
    80000b6e:	a021                	j	80000b76 <copyout+0x74>
    80000b70:	4501                	li	a0,0
}
    80000b72:	8082                	ret
      return -1;
    80000b74:	557d                	li	a0,-1
}
    80000b76:	60a6                	ld	ra,72(sp)
    80000b78:	6406                	ld	s0,64(sp)
    80000b7a:	74e2                	ld	s1,56(sp)
    80000b7c:	7942                	ld	s2,48(sp)
    80000b7e:	79a2                	ld	s3,40(sp)
    80000b80:	7a02                	ld	s4,32(sp)
    80000b82:	6ae2                	ld	s5,24(sp)
    80000b84:	6b42                	ld	s6,16(sp)
    80000b86:	6ba2                	ld	s7,8(sp)
    80000b88:	6c02                	ld	s8,0(sp)
    80000b8a:	6161                	addi	sp,sp,80
    80000b8c:	8082                	ret

0000000080000b8e <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000b8e:	c6bd                	beqz	a3,80000bfc <copyin+0x6e>
{
    80000b90:	715d                	addi	sp,sp,-80
    80000b92:	e486                	sd	ra,72(sp)
    80000b94:	e0a2                	sd	s0,64(sp)
    80000b96:	fc26                	sd	s1,56(sp)
    80000b98:	f84a                	sd	s2,48(sp)
    80000b9a:	f44e                	sd	s3,40(sp)
    80000b9c:	f052                	sd	s4,32(sp)
    80000b9e:	ec56                	sd	s5,24(sp)
    80000ba0:	e85a                	sd	s6,16(sp)
    80000ba2:	e45e                	sd	s7,8(sp)
    80000ba4:	e062                	sd	s8,0(sp)
    80000ba6:	0880                	addi	s0,sp,80
    80000ba8:	8b2a                	mv	s6,a0
    80000baa:	8a2e                	mv	s4,a1
    80000bac:	8c32                	mv	s8,a2
    80000bae:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000bb0:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000bb2:	6a85                	lui	s5,0x1
    80000bb4:	a015                	j	80000bd8 <copyin+0x4a>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000bb6:	9562                	add	a0,a0,s8
    80000bb8:	0004861b          	sext.w	a2,s1
    80000bbc:	412505b3          	sub	a1,a0,s2
    80000bc0:	8552                	mv	a0,s4
    80000bc2:	fffff097          	auipc	ra,0xfffff
    80000bc6:	616080e7          	jalr	1558(ra) # 800001d8 <memmove>

    len -= n;
    80000bca:	409989b3          	sub	s3,s3,s1
    dst += n;
    80000bce:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80000bd0:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000bd4:	02098263          	beqz	s3,80000bf8 <copyin+0x6a>
    va0 = PGROUNDDOWN(srcva);
    80000bd8:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000bdc:	85ca                	mv	a1,s2
    80000bde:	855a                	mv	a0,s6
    80000be0:	00000097          	auipc	ra,0x0
    80000be4:	926080e7          	jalr	-1754(ra) # 80000506 <walkaddr>
    if(pa0 == 0)
    80000be8:	cd01                	beqz	a0,80000c00 <copyin+0x72>
    n = PGSIZE - (srcva - va0);
    80000bea:	418904b3          	sub	s1,s2,s8
    80000bee:	94d6                	add	s1,s1,s5
    if(n > len)
    80000bf0:	fc99f3e3          	bgeu	s3,s1,80000bb6 <copyin+0x28>
    80000bf4:	84ce                	mv	s1,s3
    80000bf6:	b7c1                	j	80000bb6 <copyin+0x28>
  }
  return 0;
    80000bf8:	4501                	li	a0,0
    80000bfa:	a021                	j	80000c02 <copyin+0x74>
    80000bfc:	4501                	li	a0,0
}
    80000bfe:	8082                	ret
      return -1;
    80000c00:	557d                	li	a0,-1
}
    80000c02:	60a6                	ld	ra,72(sp)
    80000c04:	6406                	ld	s0,64(sp)
    80000c06:	74e2                	ld	s1,56(sp)
    80000c08:	7942                	ld	s2,48(sp)
    80000c0a:	79a2                	ld	s3,40(sp)
    80000c0c:	7a02                	ld	s4,32(sp)
    80000c0e:	6ae2                	ld	s5,24(sp)
    80000c10:	6b42                	ld	s6,16(sp)
    80000c12:	6ba2                	ld	s7,8(sp)
    80000c14:	6c02                	ld	s8,0(sp)
    80000c16:	6161                	addi	sp,sp,80
    80000c18:	8082                	ret

0000000080000c1a <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80000c1a:	c6c5                	beqz	a3,80000cc2 <copyinstr+0xa8>
{
    80000c1c:	715d                	addi	sp,sp,-80
    80000c1e:	e486                	sd	ra,72(sp)
    80000c20:	e0a2                	sd	s0,64(sp)
    80000c22:	fc26                	sd	s1,56(sp)
    80000c24:	f84a                	sd	s2,48(sp)
    80000c26:	f44e                	sd	s3,40(sp)
    80000c28:	f052                	sd	s4,32(sp)
    80000c2a:	ec56                	sd	s5,24(sp)
    80000c2c:	e85a                	sd	s6,16(sp)
    80000c2e:	e45e                	sd	s7,8(sp)
    80000c30:	0880                	addi	s0,sp,80
    80000c32:	8a2a                	mv	s4,a0
    80000c34:	8b2e                	mv	s6,a1
    80000c36:	8bb2                	mv	s7,a2
    80000c38:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    80000c3a:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000c3c:	6985                	lui	s3,0x1
    80000c3e:	a035                	j	80000c6a <copyinstr+0x50>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000c40:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    80000c44:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80000c46:	0017b793          	seqz	a5,a5
    80000c4a:	40f00533          	neg	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000c4e:	60a6                	ld	ra,72(sp)
    80000c50:	6406                	ld	s0,64(sp)
    80000c52:	74e2                	ld	s1,56(sp)
    80000c54:	7942                	ld	s2,48(sp)
    80000c56:	79a2                	ld	s3,40(sp)
    80000c58:	7a02                	ld	s4,32(sp)
    80000c5a:	6ae2                	ld	s5,24(sp)
    80000c5c:	6b42                	ld	s6,16(sp)
    80000c5e:	6ba2                	ld	s7,8(sp)
    80000c60:	6161                	addi	sp,sp,80
    80000c62:	8082                	ret
    srcva = va0 + PGSIZE;
    80000c64:	01390bb3          	add	s7,s2,s3
  while(got_null == 0 && max > 0){
    80000c68:	c8a9                	beqz	s1,80000cba <copyinstr+0xa0>
    va0 = PGROUNDDOWN(srcva);
    80000c6a:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    80000c6e:	85ca                	mv	a1,s2
    80000c70:	8552                	mv	a0,s4
    80000c72:	00000097          	auipc	ra,0x0
    80000c76:	894080e7          	jalr	-1900(ra) # 80000506 <walkaddr>
    if(pa0 == 0)
    80000c7a:	c131                	beqz	a0,80000cbe <copyinstr+0xa4>
    n = PGSIZE - (srcva - va0);
    80000c7c:	41790833          	sub	a6,s2,s7
    80000c80:	984e                	add	a6,a6,s3
    if(n > max)
    80000c82:	0104f363          	bgeu	s1,a6,80000c88 <copyinstr+0x6e>
    80000c86:	8826                	mv	a6,s1
    char *p = (char *) (pa0 + (srcva - va0));
    80000c88:	955e                	add	a0,a0,s7
    80000c8a:	41250533          	sub	a0,a0,s2
    while(n > 0){
    80000c8e:	fc080be3          	beqz	a6,80000c64 <copyinstr+0x4a>
    80000c92:	985a                	add	a6,a6,s6
    80000c94:	87da                	mv	a5,s6
      if(*p == '\0'){
    80000c96:	41650633          	sub	a2,a0,s6
    80000c9a:	14fd                	addi	s1,s1,-1
    80000c9c:	9b26                	add	s6,s6,s1
    80000c9e:	00f60733          	add	a4,a2,a5
    80000ca2:	00074703          	lbu	a4,0(a4)
    80000ca6:	df49                	beqz	a4,80000c40 <copyinstr+0x26>
        *dst = *p;
    80000ca8:	00e78023          	sb	a4,0(a5)
      --max;
    80000cac:	40fb04b3          	sub	s1,s6,a5
      dst++;
    80000cb0:	0785                	addi	a5,a5,1
    while(n > 0){
    80000cb2:	ff0796e3          	bne	a5,a6,80000c9e <copyinstr+0x84>
      dst++;
    80000cb6:	8b42                	mv	s6,a6
    80000cb8:	b775                	j	80000c64 <copyinstr+0x4a>
    80000cba:	4781                	li	a5,0
    80000cbc:	b769                	j	80000c46 <copyinstr+0x2c>
      return -1;
    80000cbe:	557d                	li	a0,-1
    80000cc0:	b779                	j	80000c4e <copyinstr+0x34>
  int got_null = 0;
    80000cc2:	4781                	li	a5,0
  if(got_null){
    80000cc4:	0017b793          	seqz	a5,a5
    80000cc8:	40f00533          	neg	a0,a5
}
    80000ccc:	8082                	ret

0000000080000cce <madvise>:

/* NTU OS 2024 */
/* Map pages to physical memory or swap space. */
int madvise(uint64 base, uint64 len, int advice) {
    80000cce:	7179                	addi	sp,sp,-48
    80000cd0:	f406                	sd	ra,40(sp)
    80000cd2:	f022                	sd	s0,32(sp)
    80000cd4:	ec26                	sd	s1,24(sp)
    80000cd6:	e84a                	sd	s2,16(sp)
    80000cd8:	e44e                	sd	s3,8(sp)
    80000cda:	e052                	sd	s4,0(sp)
    80000cdc:	1800                	addi	s0,sp,48
    80000cde:	84aa                	mv	s1,a0
    80000ce0:	892e                	mv	s2,a1
    80000ce2:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80000ce4:	00000097          	auipc	ra,0x0
    80000ce8:	47c080e7          	jalr	1148(ra) # 80001160 <myproc>
  pagetable_t pgtbl = p->pagetable;

  if (base > p->sz || (base + len) > p->sz) {
    80000cec:	6538                	ld	a4,72(a0)
    80000cee:	08976b63          	bltu	a4,s1,80000d84 <madvise+0xb6>
    80000cf2:	87aa                	mv	a5,a0
    80000cf4:	012486b3          	add	a3,s1,s2
    return -1;
    80000cf8:	557d                	li	a0,-1
  if (base > p->sz || (base + len) > p->sz) {
    80000cfa:	08d76663          	bltu	a4,a3,80000d86 <madvise+0xb8>
  }

  if (len == 0) {
    return 0;
    80000cfe:	4501                	li	a0,0
  if (len == 0) {
    80000d00:	08090363          	beqz	s2,80000d86 <madvise+0xb8>
  }

  uint64 begin = PGROUNDDOWN(base);
  uint64 last = PGROUNDDOWN(base + len - 1);

  if (advice == MADV_NORMAL) {
    80000d04:	0009871b          	sext.w	a4,s3
    80000d08:	4605                	li	a2,1
    80000d0a:	06e67e63          	bgeu	a2,a4,80000d86 <madvise+0xb8>
    // TODO
  } else if (advice == MADV_WILLNEED) {
    // TODO
  } else if (advice == MADV_DONTNEED) {
    80000d0e:	4609                	li	a2,2
    80000d10:	00c98663          	beq	s3,a2,80000d1c <madvise+0x4e>
    #endif

    end_op();
    return 0;

  } else if(advice == MADV_PIN) {
    80000d14:	3775                	addiw	a4,a4,-3
    80000d16:	4785                	li	a5,1
    // TODO
  } else if(advice == MADV_UNPIN) {
    // TODO
  }
  else {
    return -1;
    80000d18:	557d                	li	a0,-1
    80000d1a:	a0b5                	j	80000d86 <madvise+0xb8>
  pagetable_t pgtbl = p->pagetable;
    80000d1c:	0507b983          	ld	s3,80(a5)
  uint64 begin = PGROUNDDOWN(base);
    80000d20:	797d                	lui	s2,0xfffff
    80000d22:	0124f4b3          	and	s1,s1,s2
  uint64 last = PGROUNDDOWN(base + len - 1);
    80000d26:	16fd                	addi	a3,a3,-1
    80000d28:	0126f933          	and	s2,a3,s2
    begin_op();
    80000d2c:	00003097          	auipc	ra,0x3
    80000d30:	c8e080e7          	jalr	-882(ra) # 800039ba <begin_op>
    for (uint64 va = begin; va <= last; va += PGSIZE) {
    80000d34:	04996263          	bltu	s2,s1,80000d78 <madvise+0xaa>
    80000d38:	6a05                	lui	s4,0x1
    80000d3a:	a811                	j	80000d4e <madvise+0x80>
          end_op();
    80000d3c:	00003097          	auipc	ra,0x3
    80000d40:	cfe080e7          	jalr	-770(ra) # 80003a3a <end_op>
          return -1;
    80000d44:	557d                	li	a0,-1
    80000d46:	a081                	j	80000d86 <madvise+0xb8>
    for (uint64 va = begin; va <= last; va += PGSIZE) {
    80000d48:	94d2                	add	s1,s1,s4
    80000d4a:	02996763          	bltu	s2,s1,80000d78 <madvise+0xaa>
      pte = walk(pgtbl, va, 0);
    80000d4e:	4601                	li	a2,0
    80000d50:	85a6                	mv	a1,s1
    80000d52:	854e                	mv	a0,s3
    80000d54:	fffff097          	auipc	ra,0xfffff
    80000d58:	70c080e7          	jalr	1804(ra) # 80000460 <walk>
      if (pte != 0 && (*pte & PTE_V)) {
    80000d5c:	d575                	beqz	a0,80000d48 <madvise+0x7a>
    80000d5e:	611c                	ld	a5,0(a0)
    80000d60:	8b85                	andi	a5,a5,1
    80000d62:	d3fd                	beqz	a5,80000d48 <madvise+0x7a>
        char *pa = (char*) swap_page_from_pte(pte);
    80000d64:	00005097          	auipc	ra,0x5
    80000d68:	e12080e7          	jalr	-494(ra) # 80005b76 <swap_page_from_pte>
        if (pa == 0) {
    80000d6c:	d961                	beqz	a0,80000d3c <madvise+0x6e>
        kfree(pa);
    80000d6e:	fffff097          	auipc	ra,0xfffff
    80000d72:	2ae080e7          	jalr	686(ra) # 8000001c <kfree>
    80000d76:	bfc9                	j	80000d48 <madvise+0x7a>
    end_op();
    80000d78:	00003097          	auipc	ra,0x3
    80000d7c:	cc2080e7          	jalr	-830(ra) # 80003a3a <end_op>
    return 0;
    80000d80:	4501                	li	a0,0
    80000d82:	a011                	j	80000d86 <madvise+0xb8>
    return -1;
    80000d84:	557d                	li	a0,-1
  }
}
    80000d86:	70a2                	ld	ra,40(sp)
    80000d88:	7402                	ld	s0,32(sp)
    80000d8a:	64e2                	ld	s1,24(sp)
    80000d8c:	6942                	ld	s2,16(sp)
    80000d8e:	69a2                	ld	s3,8(sp)
    80000d90:	6a02                	ld	s4,0(sp)
    80000d92:	6145                	addi	sp,sp,48
    80000d94:	8082                	ret

0000000080000d96 <pgprint>:

/* NTU OS 2024 */
/* print pages from page replacement buffers */
#if defined(PG_REPLACEMENT_USE_LRU) || defined(PG_REPLACEMENT_USE_FIFO)
void pgprint() {
    80000d96:	1141                	addi	sp,sp,-16
    80000d98:	e406                	sd	ra,8(sp)
    80000d9a:	e022                	sd	s0,0(sp)
    80000d9c:	0800                	addi	s0,sp,16
  #ifdef PG_REPLACEMENT_USE_LRU
  // TODO
  #elif defined(PG_REPLACEMENT_USE_FIFO)
  // TODO
  #endif
  panic("not implemented yet\n");
    80000d9e:	00007517          	auipc	a0,0x7
    80000da2:	3a250513          	addi	a0,a0,930 # 80008140 <etext+0x140>
    80000da6:	00005097          	auipc	ra,0x5
    80000daa:	52a080e7          	jalr	1322(ra) # 800062d0 <panic>

0000000080000dae <pteprint>:
}
#endif

void pteprint(pagetable_t PGTBL, unsigned long counter, int level) {
    80000dae:	7119                	addi	sp,sp,-128
    80000db0:	fc86                	sd	ra,120(sp)
    80000db2:	f8a2                	sd	s0,112(sp)
    80000db4:	f4a6                	sd	s1,104(sp)
    80000db6:	f0ca                	sd	s2,96(sp)
    80000db8:	ecce                	sd	s3,88(sp)
    80000dba:	e8d2                	sd	s4,80(sp)
    80000dbc:	e4d6                	sd	s5,72(sp)
    80000dbe:	e0da                	sd	s6,64(sp)
    80000dc0:	fc5e                	sd	s7,56(sp)
    80000dc2:	f862                	sd	s8,48(sp)
    80000dc4:	f466                	sd	s9,40(sp)
    80000dc6:	f06a                	sd	s10,32(sp)
    80000dc8:	ec6e                	sd	s11,24(sp)
    80000dca:	0100                	addi	s0,sp,128
    80000dcc:	8d2e                	mv	s10,a1
    80000dce:	8b32                	mv	s6,a2
  pte_t *pte;
  for (int i = 0; i < MAX_IDX; i++) {
    80000dd0:	8aaa                	mv	s5,a0
void pteprint(pagetable_t PGTBL, unsigned long counter, int level) {
    80000dd2:	4981                	li	s3,0
      if (*pte & PTE_W) { printf(" W"); }
      if (*pte & PTE_X) { printf(" X"); }
      if (*pte & PTE_U) { printf(" U"); }
      if (*pte & PTE_S) { printf(" S"); }
      if (*pte & PTE_D) { printf(" D"); }
      printf("\n");
    80000dd4:	00007d97          	auipc	s11,0x7
    80000dd8:	274d8d93          	addi	s11,s11,628 # 80008048 <etext+0x48>

      // if only valid mem addr -> it's a child table
      if ((*pte & PTE_V) && (*pte & (PTE_R | PTE_W | PTE_X | PTE_U)) == 0) {
    80000ddc:	4c85                	li	s9,1
        pagetable_t childPGTBL = (pagetable_t)PTE2PA(*pte);
        pteprint(childPGTBL, cur_va, level + 1);
    80000dde:	0016079b          	addiw	a5,a2,1
    80000de2:	f8f43423          	sd	a5,-120(s0)
        for (int j = 0; j < level; j++) { printf("    "); }
    80000de6:	00007a17          	auipc	s4,0x7
    80000dea:	37aa0a13          	addi	s4,s4,890 # 80008160 <etext+0x160>
    80000dee:	fff60b9b          	addiw	s7,a2,-1
    80000df2:	a2a5                	j	80000f5a <pteprint+0x1ac>
    80000df4:	4481                	li	s1,0
    80000df6:	8552                	mv	a0,s4
    80000df8:	00005097          	auipc	ra,0x5
    80000dfc:	522080e7          	jalr	1314(ra) # 8000631a <printf>
    80000e00:	2485                	addiw	s1,s1,1
    80000e02:	fe9b1ae3          	bne	s6,s1,80000df6 <pteprint+0x48>
      else if (level == 1) {
    80000e06:	019b0563          	beq	s6,s9,80000e10 <pteprint+0x62>
        cur_va = counter + i;
    80000e0a:	01a984b3          	add	s1,s3,s10
    80000e0e:	a0dd                	j	80000ef4 <pteprint+0x146>
        cur_va = counter + i * MAX_IDX;
    80000e10:	00999493          	slli	s1,s3,0x9
    80000e14:	94ea                	add	s1,s1,s10
    80000e16:	a8f9                	j	80000ef4 <pteprint+0x146>
        printf("+-- %d: pte=%p va=%p pa=%p", i, pte, cur_va * PGSIZE, PTE2PA(*pte));
    80000e18:	8329                	srli	a4,a4,0xa
    80000e1a:	0732                	slli	a4,a4,0xc
    80000e1c:	00c49693          	slli	a3,s1,0xc
    80000e20:	864a                	mv	a2,s2
    80000e22:	85e2                	mv	a1,s8
    80000e24:	00007517          	auipc	a0,0x7
    80000e28:	34450513          	addi	a0,a0,836 # 80008168 <etext+0x168>
    80000e2c:	00005097          	auipc	ra,0x5
    80000e30:	4ee080e7          	jalr	1262(ra) # 8000631a <printf>
      if (*pte & PTE_V) { printf(" V"); }
    80000e34:	00093783          	ld	a5,0(s2) # fffffffffffff000 <end+0xffffffff7ffd8dc0>
    80000e38:	8b85                	andi	a5,a5,1
    80000e3a:	c7e9                	beqz	a5,80000f04 <pteprint+0x156>
    80000e3c:	00007517          	auipc	a0,0x7
    80000e40:	36c50513          	addi	a0,a0,876 # 800081a8 <etext+0x1a8>
    80000e44:	00005097          	auipc	ra,0x5
    80000e48:	4d6080e7          	jalr	1238(ra) # 8000631a <printf>
    80000e4c:	a865                	j	80000f04 <pteprint+0x156>
        printf("+-- %d: pte=%p va=%p blockno=%p", i, pte, cur_va * PGSIZE, PTE2BLOCKNO(*pte));
    80000e4e:	8329                	srli	a4,a4,0xa
    80000e50:	00c49693          	slli	a3,s1,0xc
    80000e54:	864a                	mv	a2,s2
    80000e56:	85e2                	mv	a1,s8
    80000e58:	00007517          	auipc	a0,0x7
    80000e5c:	33050513          	addi	a0,a0,816 # 80008188 <etext+0x188>
    80000e60:	00005097          	auipc	ra,0x5
    80000e64:	4ba080e7          	jalr	1210(ra) # 8000631a <printf>
    80000e68:	b7f1                	j	80000e34 <pteprint+0x86>
      if (*pte & PTE_R) { printf(" R"); }
    80000e6a:	00007517          	auipc	a0,0x7
    80000e6e:	34650513          	addi	a0,a0,838 # 800081b0 <etext+0x1b0>
    80000e72:	00005097          	auipc	ra,0x5
    80000e76:	4a8080e7          	jalr	1192(ra) # 8000631a <printf>
    80000e7a:	a849                	j	80000f0c <pteprint+0x15e>
      if (*pte & PTE_W) { printf(" W"); }
    80000e7c:	00007517          	auipc	a0,0x7
    80000e80:	33c50513          	addi	a0,a0,828 # 800081b8 <etext+0x1b8>
    80000e84:	00005097          	auipc	ra,0x5
    80000e88:	496080e7          	jalr	1174(ra) # 8000631a <printf>
    80000e8c:	a061                	j	80000f14 <pteprint+0x166>
      if (*pte & PTE_X) { printf(" X"); }
    80000e8e:	00007517          	auipc	a0,0x7
    80000e92:	33250513          	addi	a0,a0,818 # 800081c0 <etext+0x1c0>
    80000e96:	00005097          	auipc	ra,0x5
    80000e9a:	484080e7          	jalr	1156(ra) # 8000631a <printf>
    80000e9e:	a8bd                	j	80000f1c <pteprint+0x16e>
      if (*pte & PTE_U) { printf(" U"); }
    80000ea0:	00007517          	auipc	a0,0x7
    80000ea4:	32850513          	addi	a0,a0,808 # 800081c8 <etext+0x1c8>
    80000ea8:	00005097          	auipc	ra,0x5
    80000eac:	472080e7          	jalr	1138(ra) # 8000631a <printf>
    80000eb0:	a895                	j	80000f24 <pteprint+0x176>
      if (*pte & PTE_S) { printf(" S"); }
    80000eb2:	00007517          	auipc	a0,0x7
    80000eb6:	31e50513          	addi	a0,a0,798 # 800081d0 <etext+0x1d0>
    80000eba:	00005097          	auipc	ra,0x5
    80000ebe:	460080e7          	jalr	1120(ra) # 8000631a <printf>
    80000ec2:	a0b5                	j	80000f2e <pteprint+0x180>
      if (*pte & PTE_D) { printf(" D"); }
    80000ec4:	00007517          	auipc	a0,0x7
    80000ec8:	31450513          	addi	a0,a0,788 # 800081d8 <etext+0x1d8>
    80000ecc:	00005097          	auipc	ra,0x5
    80000ed0:	44e080e7          	jalr	1102(ra) # 8000631a <printf>
    80000ed4:	a095                	j	80000f38 <pteprint+0x18a>
        pagetable_t childPGTBL = (pagetable_t)PTE2PA(*pte);
    80000ed6:	8129                	srli	a0,a0,0xa
        pteprint(childPGTBL, cur_va, level + 1);
    80000ed8:	f8843603          	ld	a2,-120(s0)
    80000edc:	85a6                	mv	a1,s1
    80000ede:	0532                	slli	a0,a0,0xc
    80000ee0:	00000097          	auipc	ra,0x0
    80000ee4:	ece080e7          	jalr	-306(ra) # 80000dae <pteprint>
    80000ee8:	a09d                	j	80000f4e <pteprint+0x1a0>
        cur_va = counter + i * MAX_IDX * MAX_IDX;
    80000eea:	01299493          	slli	s1,s3,0x12
    80000eee:	94ea                	add	s1,s1,s10
      if (level == 0) {
    80000ef0:	f00b1de3          	bnez	s6,80000e0a <pteprint+0x5c>
      if (*pte & PTE_V) {
    80000ef4:	00093703          	ld	a4,0(s2)
    80000ef8:	00177793          	andi	a5,a4,1
    80000efc:	ff91                	bnez	a5,80000e18 <pteprint+0x6a>
      else if (*pte & PTE_S) {
    80000efe:	20077793          	andi	a5,a4,512
    80000f02:	f7b1                	bnez	a5,80000e4e <pteprint+0xa0>
      if (*pte & PTE_R) { printf(" R"); }
    80000f04:	00093783          	ld	a5,0(s2)
    80000f08:	8b89                	andi	a5,a5,2
    80000f0a:	f3a5                	bnez	a5,80000e6a <pteprint+0xbc>
      if (*pte & PTE_W) { printf(" W"); }
    80000f0c:	00093783          	ld	a5,0(s2)
    80000f10:	8b91                	andi	a5,a5,4
    80000f12:	f7ad                	bnez	a5,80000e7c <pteprint+0xce>
      if (*pte & PTE_X) { printf(" X"); }
    80000f14:	00093783          	ld	a5,0(s2)
    80000f18:	8ba1                	andi	a5,a5,8
    80000f1a:	fbb5                	bnez	a5,80000e8e <pteprint+0xe0>
      if (*pte & PTE_U) { printf(" U"); }
    80000f1c:	00093783          	ld	a5,0(s2)
    80000f20:	8bc1                	andi	a5,a5,16
    80000f22:	ffbd                	bnez	a5,80000ea0 <pteprint+0xf2>
      if (*pte & PTE_S) { printf(" S"); }
    80000f24:	00093783          	ld	a5,0(s2)
    80000f28:	2007f793          	andi	a5,a5,512
    80000f2c:	f3d9                	bnez	a5,80000eb2 <pteprint+0x104>
      if (*pte & PTE_D) { printf(" D"); }
    80000f2e:	00093783          	ld	a5,0(s2)
    80000f32:	0807f793          	andi	a5,a5,128
    80000f36:	f7d9                	bnez	a5,80000ec4 <pteprint+0x116>
      printf("\n");
    80000f38:	856e                	mv	a0,s11
    80000f3a:	00005097          	auipc	ra,0x5
    80000f3e:	3e0080e7          	jalr	992(ra) # 8000631a <printf>
      if ((*pte & PTE_V) && (*pte & (PTE_R | PTE_W | PTE_X | PTE_U)) == 0) {
    80000f42:	00093503          	ld	a0,0(s2)
    80000f46:	01f57793          	andi	a5,a0,31
    80000f4a:	f99786e3          	beq	a5,s9,80000ed6 <pteprint+0x128>
  for (int i = 0; i < MAX_IDX; i++) {
    80000f4e:	0985                	addi	s3,s3,1
    80000f50:	0aa1                	addi	s5,s5,8
    80000f52:	20000793          	li	a5,512
    80000f56:	04f98463          	beq	s3,a5,80000f9e <pteprint+0x1f0>
    80000f5a:	00098c1b          	sext.w	s8,s3
    pte = &PGTBL[i];
    80000f5e:	8956                	mv	s2,s5
    if ((*pte & (PTE_V | PTE_S)) != 0) {
    80000f60:	000ab783          	ld	a5,0(s5) # fffffffffffff000 <end+0xffffffff7ffd8dc0>
    80000f64:	2017f793          	andi	a5,a5,513
    80000f68:	d3fd                	beqz	a5,80000f4e <pteprint+0x1a0>
      if (level > 0 && i < 256) {
    80000f6a:	f96050e3          	blez	s6,80000eea <pteprint+0x13c>
    80000f6e:	0ff00713          	li	a4,255
    80000f72:	e98741e3          	blt	a4,s8,80000df4 <pteprint+0x46>
        printf("|   ");
    80000f76:	00007517          	auipc	a0,0x7
    80000f7a:	1e250513          	addi	a0,a0,482 # 80008158 <etext+0x158>
    80000f7e:	00005097          	auipc	ra,0x5
    80000f82:	39c080e7          	jalr	924(ra) # 8000631a <printf>
        for (int j = 0; j < level-1; j++) { printf("    "); }  
    80000f86:	e96cd0e3          	bge	s9,s6,80000e06 <pteprint+0x58>
    80000f8a:	4481                	li	s1,0
    80000f8c:	8552                	mv	a0,s4
    80000f8e:	00005097          	auipc	ra,0x5
    80000f92:	38c080e7          	jalr	908(ra) # 8000631a <printf>
    80000f96:	2485                	addiw	s1,s1,1
    80000f98:	fe9b9ae3          	bne	s7,s1,80000f8c <pteprint+0x1de>
    80000f9c:	b5ad                	j	80000e06 <pteprint+0x58>
      }
    }
  }
}
    80000f9e:	70e6                	ld	ra,120(sp)
    80000fa0:	7446                	ld	s0,112(sp)
    80000fa2:	74a6                	ld	s1,104(sp)
    80000fa4:	7906                	ld	s2,96(sp)
    80000fa6:	69e6                	ld	s3,88(sp)
    80000fa8:	6a46                	ld	s4,80(sp)
    80000faa:	6aa6                	ld	s5,72(sp)
    80000fac:	6b06                	ld	s6,64(sp)
    80000fae:	7be2                	ld	s7,56(sp)
    80000fb0:	7c42                	ld	s8,48(sp)
    80000fb2:	7ca2                	ld	s9,40(sp)
    80000fb4:	7d02                	ld	s10,32(sp)
    80000fb6:	6de2                	ld	s11,24(sp)
    80000fb8:	6109                	addi	sp,sp,128
    80000fba:	8082                	ret

0000000080000fbc <vmprint>:

/* NTU OS 2024 */
/* Print multi layer page table. */
void vmprint(pagetable_t pagetable) {
    80000fbc:	1101                	addi	sp,sp,-32
    80000fbe:	ec06                	sd	ra,24(sp)
    80000fc0:	e822                	sd	s0,16(sp)
    80000fc2:	e426                	sd	s1,8(sp)
    80000fc4:	1000                	addi	s0,sp,32
    80000fc6:	84aa                	mv	s1,a0
  /* TODO */
  // panic("not implemented yet\n");
  printf("page table %p\n", pagetable);
    80000fc8:	85aa                	mv	a1,a0
    80000fca:	00007517          	auipc	a0,0x7
    80000fce:	21650513          	addi	a0,a0,534 # 800081e0 <etext+0x1e0>
    80000fd2:	00005097          	auipc	ra,0x5
    80000fd6:	348080e7          	jalr	840(ra) # 8000631a <printf>
  pteprint(pagetable, 0, 0);
    80000fda:	4601                	li	a2,0
    80000fdc:	4581                	li	a1,0
    80000fde:	8526                	mv	a0,s1
    80000fe0:	00000097          	auipc	ra,0x0
    80000fe4:	dce080e7          	jalr	-562(ra) # 80000dae <pteprint>
}
    80000fe8:	60e2                	ld	ra,24(sp)
    80000fea:	6442                	ld	s0,16(sp)
    80000fec:	64a2                	ld	s1,8(sp)
    80000fee:	6105                	addi	sp,sp,32
    80000ff0:	8082                	ret

0000000080000ff2 <proc_mapstacks>:

// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl) {
    80000ff2:	7139                	addi	sp,sp,-64
    80000ff4:	fc06                	sd	ra,56(sp)
    80000ff6:	f822                	sd	s0,48(sp)
    80000ff8:	f426                	sd	s1,40(sp)
    80000ffa:	f04a                	sd	s2,32(sp)
    80000ffc:	ec4e                	sd	s3,24(sp)
    80000ffe:	e852                	sd	s4,16(sp)
    80001000:	e456                	sd	s5,8(sp)
    80001002:	e05a                	sd	s6,0(sp)
    80001004:	0080                	addi	s0,sp,64
    80001006:	89aa                	mv	s3,a0
  struct proc *p;
  for(p = proc; p < &proc[NPROC]; p++) {
    80001008:	00008497          	auipc	s1,0x8
    8000100c:	47848493          	addi	s1,s1,1144 # 80009480 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80001010:	8b26                	mv	s6,s1
    80001012:	00007a97          	auipc	s5,0x7
    80001016:	feea8a93          	addi	s5,s5,-18 # 80008000 <etext>
    8000101a:	01000937          	lui	s2,0x1000
    8000101e:	197d                	addi	s2,s2,-1
    80001020:	093a                	slli	s2,s2,0xe
  for(p = proc; p < &proc[NPROC]; p++) {
    80001022:	0000ea17          	auipc	s4,0xe
    80001026:	e5ea0a13          	addi	s4,s4,-418 # 8000ee80 <tickslock>
    char *pa = kalloc();
    8000102a:	fffff097          	auipc	ra,0xfffff
    8000102e:	0ee080e7          	jalr	238(ra) # 80000118 <kalloc>
    80001032:	862a                	mv	a2,a0
    if(pa == 0)
    80001034:	c129                	beqz	a0,80001076 <proc_mapstacks+0x84>
    uint64 va = KSTACK((int) (p - proc));
    80001036:	416485b3          	sub	a1,s1,s6
    8000103a:	858d                	srai	a1,a1,0x3
    8000103c:	000ab783          	ld	a5,0(s5)
    80001040:	02f585b3          	mul	a1,a1,a5
    80001044:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80001048:	4719                	li	a4,6
    8000104a:	6685                	lui	a3,0x1
    8000104c:	40b905b3          	sub	a1,s2,a1
    80001050:	854e                	mv	a0,s3
    80001052:	fffff097          	auipc	ra,0xfffff
    80001056:	596080e7          	jalr	1430(ra) # 800005e8 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    8000105a:	16848493          	addi	s1,s1,360
    8000105e:	fd4496e3          	bne	s1,s4,8000102a <proc_mapstacks+0x38>
  }
}
    80001062:	70e2                	ld	ra,56(sp)
    80001064:	7442                	ld	s0,48(sp)
    80001066:	74a2                	ld	s1,40(sp)
    80001068:	7902                	ld	s2,32(sp)
    8000106a:	69e2                	ld	s3,24(sp)
    8000106c:	6a42                	ld	s4,16(sp)
    8000106e:	6aa2                	ld	s5,8(sp)
    80001070:	6b02                	ld	s6,0(sp)
    80001072:	6121                	addi	sp,sp,64
    80001074:	8082                	ret
      panic("kalloc");
    80001076:	00007517          	auipc	a0,0x7
    8000107a:	17a50513          	addi	a0,a0,378 # 800081f0 <etext+0x1f0>
    8000107e:	00005097          	auipc	ra,0x5
    80001082:	252080e7          	jalr	594(ra) # 800062d0 <panic>

0000000080001086 <procinit>:

// initialize the proc table at boot time.
void
procinit(void)
{
    80001086:	7139                	addi	sp,sp,-64
    80001088:	fc06                	sd	ra,56(sp)
    8000108a:	f822                	sd	s0,48(sp)
    8000108c:	f426                	sd	s1,40(sp)
    8000108e:	f04a                	sd	s2,32(sp)
    80001090:	ec4e                	sd	s3,24(sp)
    80001092:	e852                	sd	s4,16(sp)
    80001094:	e456                	sd	s5,8(sp)
    80001096:	e05a                	sd	s6,0(sp)
    80001098:	0080                	addi	s0,sp,64
  struct proc *p;
  initlock(&pid_lock, "nextpid");
    8000109a:	00007597          	auipc	a1,0x7
    8000109e:	15e58593          	addi	a1,a1,350 # 800081f8 <etext+0x1f8>
    800010a2:	00008517          	auipc	a0,0x8
    800010a6:	fae50513          	addi	a0,a0,-82 # 80009050 <pid_lock>
    800010aa:	00005097          	auipc	ra,0x5
    800010ae:	6e0080e7          	jalr	1760(ra) # 8000678a <initlock>
  initlock(&wait_lock, "wait_lock");
    800010b2:	00007597          	auipc	a1,0x7
    800010b6:	14e58593          	addi	a1,a1,334 # 80008200 <etext+0x200>
    800010ba:	00008517          	auipc	a0,0x8
    800010be:	fae50513          	addi	a0,a0,-82 # 80009068 <wait_lock>
    800010c2:	00005097          	auipc	ra,0x5
    800010c6:	6c8080e7          	jalr	1736(ra) # 8000678a <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    800010ca:	00008497          	auipc	s1,0x8
    800010ce:	3b648493          	addi	s1,s1,950 # 80009480 <proc>
      initlock(&p->lock, "proc");
    800010d2:	00007b17          	auipc	s6,0x7
    800010d6:	13eb0b13          	addi	s6,s6,318 # 80008210 <etext+0x210>
      p->kstack = KSTACK((int) (p - proc));
    800010da:	8aa6                	mv	s5,s1
    800010dc:	00007a17          	auipc	s4,0x7
    800010e0:	f24a0a13          	addi	s4,s4,-220 # 80008000 <etext>
    800010e4:	01000937          	lui	s2,0x1000
    800010e8:	197d                	addi	s2,s2,-1
    800010ea:	093a                	slli	s2,s2,0xe
  for(p = proc; p < &proc[NPROC]; p++) {
    800010ec:	0000e997          	auipc	s3,0xe
    800010f0:	d9498993          	addi	s3,s3,-620 # 8000ee80 <tickslock>
      initlock(&p->lock, "proc");
    800010f4:	85da                	mv	a1,s6
    800010f6:	8526                	mv	a0,s1
    800010f8:	00005097          	auipc	ra,0x5
    800010fc:	692080e7          	jalr	1682(ra) # 8000678a <initlock>
      p->kstack = KSTACK((int) (p - proc));
    80001100:	415487b3          	sub	a5,s1,s5
    80001104:	878d                	srai	a5,a5,0x3
    80001106:	000a3703          	ld	a4,0(s4)
    8000110a:	02e787b3          	mul	a5,a5,a4
    8000110e:	00d7979b          	slliw	a5,a5,0xd
    80001112:	40f907b3          	sub	a5,s2,a5
    80001116:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80001118:	16848493          	addi	s1,s1,360
    8000111c:	fd349ce3          	bne	s1,s3,800010f4 <procinit+0x6e>
  }
}
    80001120:	70e2                	ld	ra,56(sp)
    80001122:	7442                	ld	s0,48(sp)
    80001124:	74a2                	ld	s1,40(sp)
    80001126:	7902                	ld	s2,32(sp)
    80001128:	69e2                	ld	s3,24(sp)
    8000112a:	6a42                	ld	s4,16(sp)
    8000112c:	6aa2                	ld	s5,8(sp)
    8000112e:	6b02                	ld	s6,0(sp)
    80001130:	6121                	addi	sp,sp,64
    80001132:	8082                	ret

0000000080001134 <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80001134:	1141                	addi	sp,sp,-16
    80001136:	e422                	sd	s0,8(sp)
    80001138:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    8000113a:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    8000113c:	2501                	sext.w	a0,a0
    8000113e:	6422                	ld	s0,8(sp)
    80001140:	0141                	addi	sp,sp,16
    80001142:	8082                	ret

0000000080001144 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void) {
    80001144:	1141                	addi	sp,sp,-16
    80001146:	e422                	sd	s0,8(sp)
    80001148:	0800                	addi	s0,sp,16
    8000114a:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    8000114c:	2781                	sext.w	a5,a5
    8000114e:	079e                	slli	a5,a5,0x7
  return c;
}
    80001150:	00008517          	auipc	a0,0x8
    80001154:	f3050513          	addi	a0,a0,-208 # 80009080 <cpus>
    80001158:	953e                	add	a0,a0,a5
    8000115a:	6422                	ld	s0,8(sp)
    8000115c:	0141                	addi	sp,sp,16
    8000115e:	8082                	ret

0000000080001160 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void) {
    80001160:	1101                	addi	sp,sp,-32
    80001162:	ec06                	sd	ra,24(sp)
    80001164:	e822                	sd	s0,16(sp)
    80001166:	e426                	sd	s1,8(sp)
    80001168:	1000                	addi	s0,sp,32
  push_off();
    8000116a:	00005097          	auipc	ra,0x5
    8000116e:	664080e7          	jalr	1636(ra) # 800067ce <push_off>
    80001172:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80001174:	2781                	sext.w	a5,a5
    80001176:	079e                	slli	a5,a5,0x7
    80001178:	00008717          	auipc	a4,0x8
    8000117c:	ed870713          	addi	a4,a4,-296 # 80009050 <pid_lock>
    80001180:	97ba                	add	a5,a5,a4
    80001182:	7b84                	ld	s1,48(a5)
  pop_off();
    80001184:	00005097          	auipc	ra,0x5
    80001188:	6ea080e7          	jalr	1770(ra) # 8000686e <pop_off>
  return p;
}
    8000118c:	8526                	mv	a0,s1
    8000118e:	60e2                	ld	ra,24(sp)
    80001190:	6442                	ld	s0,16(sp)
    80001192:	64a2                	ld	s1,8(sp)
    80001194:	6105                	addi	sp,sp,32
    80001196:	8082                	ret

0000000080001198 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80001198:	1141                	addi	sp,sp,-16
    8000119a:	e406                	sd	ra,8(sp)
    8000119c:	e022                	sd	s0,0(sp)
    8000119e:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    800011a0:	00000097          	auipc	ra,0x0
    800011a4:	fc0080e7          	jalr	-64(ra) # 80001160 <myproc>
    800011a8:	00005097          	auipc	ra,0x5
    800011ac:	726080e7          	jalr	1830(ra) # 800068ce <release>

  if (first) {
    800011b0:	00008797          	auipc	a5,0x8
    800011b4:	8607a783          	lw	a5,-1952(a5) # 80008a10 <first.1768>
    800011b8:	eb89                	bnez	a5,800011ca <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    800011ba:	00001097          	auipc	ra,0x1
    800011be:	c0a080e7          	jalr	-1014(ra) # 80001dc4 <usertrapret>
}
    800011c2:	60a2                	ld	ra,8(sp)
    800011c4:	6402                	ld	s0,0(sp)
    800011c6:	0141                	addi	sp,sp,16
    800011c8:	8082                	ret
    first = 0;
    800011ca:	00008797          	auipc	a5,0x8
    800011ce:	8407a323          	sw	zero,-1978(a5) # 80008a10 <first.1768>
    fsinit(ROOTDEV);
    800011d2:	4505                	li	a0,1
    800011d4:	00002097          	auipc	ra,0x2
    800011d8:	a26080e7          	jalr	-1498(ra) # 80002bfa <fsinit>
    800011dc:	bff9                	j	800011ba <forkret+0x22>

00000000800011de <allocpid>:
allocpid() {
    800011de:	1101                	addi	sp,sp,-32
    800011e0:	ec06                	sd	ra,24(sp)
    800011e2:	e822                	sd	s0,16(sp)
    800011e4:	e426                	sd	s1,8(sp)
    800011e6:	e04a                	sd	s2,0(sp)
    800011e8:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    800011ea:	00008917          	auipc	s2,0x8
    800011ee:	e6690913          	addi	s2,s2,-410 # 80009050 <pid_lock>
    800011f2:	854a                	mv	a0,s2
    800011f4:	00005097          	auipc	ra,0x5
    800011f8:	626080e7          	jalr	1574(ra) # 8000681a <acquire>
  pid = nextpid;
    800011fc:	00008797          	auipc	a5,0x8
    80001200:	81878793          	addi	a5,a5,-2024 # 80008a14 <nextpid>
    80001204:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80001206:	0014871b          	addiw	a4,s1,1
    8000120a:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    8000120c:	854a                	mv	a0,s2
    8000120e:	00005097          	auipc	ra,0x5
    80001212:	6c0080e7          	jalr	1728(ra) # 800068ce <release>
}
    80001216:	8526                	mv	a0,s1
    80001218:	60e2                	ld	ra,24(sp)
    8000121a:	6442                	ld	s0,16(sp)
    8000121c:	64a2                	ld	s1,8(sp)
    8000121e:	6902                	ld	s2,0(sp)
    80001220:	6105                	addi	sp,sp,32
    80001222:	8082                	ret

0000000080001224 <proc_pagetable>:
{
    80001224:	1101                	addi	sp,sp,-32
    80001226:	ec06                	sd	ra,24(sp)
    80001228:	e822                	sd	s0,16(sp)
    8000122a:	e426                	sd	s1,8(sp)
    8000122c:	e04a                	sd	s2,0(sp)
    8000122e:	1000                	addi	s0,sp,32
    80001230:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80001232:	fffff097          	auipc	ra,0xfffff
    80001236:	598080e7          	jalr	1432(ra) # 800007ca <uvmcreate>
    8000123a:	84aa                	mv	s1,a0
  if(pagetable == 0)
    8000123c:	c121                	beqz	a0,8000127c <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    8000123e:	4729                	li	a4,10
    80001240:	00006697          	auipc	a3,0x6
    80001244:	dc068693          	addi	a3,a3,-576 # 80007000 <_trampoline>
    80001248:	6605                	lui	a2,0x1
    8000124a:	040005b7          	lui	a1,0x4000
    8000124e:	15fd                	addi	a1,a1,-1
    80001250:	05b2                	slli	a1,a1,0xc
    80001252:	fffff097          	auipc	ra,0xfffff
    80001256:	2f6080e7          	jalr	758(ra) # 80000548 <mappages>
    8000125a:	02054863          	bltz	a0,8000128a <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    8000125e:	4719                	li	a4,6
    80001260:	05893683          	ld	a3,88(s2)
    80001264:	6605                	lui	a2,0x1
    80001266:	020005b7          	lui	a1,0x2000
    8000126a:	15fd                	addi	a1,a1,-1
    8000126c:	05b6                	slli	a1,a1,0xd
    8000126e:	8526                	mv	a0,s1
    80001270:	fffff097          	auipc	ra,0xfffff
    80001274:	2d8080e7          	jalr	728(ra) # 80000548 <mappages>
    80001278:	02054163          	bltz	a0,8000129a <proc_pagetable+0x76>
}
    8000127c:	8526                	mv	a0,s1
    8000127e:	60e2                	ld	ra,24(sp)
    80001280:	6442                	ld	s0,16(sp)
    80001282:	64a2                	ld	s1,8(sp)
    80001284:	6902                	ld	s2,0(sp)
    80001286:	6105                	addi	sp,sp,32
    80001288:	8082                	ret
    uvmfree(pagetable, 0);
    8000128a:	4581                	li	a1,0
    8000128c:	8526                	mv	a0,s1
    8000128e:	fffff097          	auipc	ra,0xfffff
    80001292:	738080e7          	jalr	1848(ra) # 800009c6 <uvmfree>
    return 0;
    80001296:	4481                	li	s1,0
    80001298:	b7d5                	j	8000127c <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    8000129a:	4681                	li	a3,0
    8000129c:	4605                	li	a2,1
    8000129e:	040005b7          	lui	a1,0x4000
    800012a2:	15fd                	addi	a1,a1,-1
    800012a4:	05b2                	slli	a1,a1,0xc
    800012a6:	8526                	mv	a0,s1
    800012a8:	fffff097          	auipc	ra,0xfffff
    800012ac:	466080e7          	jalr	1126(ra) # 8000070e <uvmunmap>
    uvmfree(pagetable, 0);
    800012b0:	4581                	li	a1,0
    800012b2:	8526                	mv	a0,s1
    800012b4:	fffff097          	auipc	ra,0xfffff
    800012b8:	712080e7          	jalr	1810(ra) # 800009c6 <uvmfree>
    return 0;
    800012bc:	4481                	li	s1,0
    800012be:	bf7d                	j	8000127c <proc_pagetable+0x58>

00000000800012c0 <proc_freepagetable>:
{
    800012c0:	1101                	addi	sp,sp,-32
    800012c2:	ec06                	sd	ra,24(sp)
    800012c4:	e822                	sd	s0,16(sp)
    800012c6:	e426                	sd	s1,8(sp)
    800012c8:	e04a                	sd	s2,0(sp)
    800012ca:	1000                	addi	s0,sp,32
    800012cc:	84aa                	mv	s1,a0
    800012ce:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    800012d0:	4681                	li	a3,0
    800012d2:	4605                	li	a2,1
    800012d4:	040005b7          	lui	a1,0x4000
    800012d8:	15fd                	addi	a1,a1,-1
    800012da:	05b2                	slli	a1,a1,0xc
    800012dc:	fffff097          	auipc	ra,0xfffff
    800012e0:	432080e7          	jalr	1074(ra) # 8000070e <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    800012e4:	4681                	li	a3,0
    800012e6:	4605                	li	a2,1
    800012e8:	020005b7          	lui	a1,0x2000
    800012ec:	15fd                	addi	a1,a1,-1
    800012ee:	05b6                	slli	a1,a1,0xd
    800012f0:	8526                	mv	a0,s1
    800012f2:	fffff097          	auipc	ra,0xfffff
    800012f6:	41c080e7          	jalr	1052(ra) # 8000070e <uvmunmap>
  uvmfree(pagetable, sz);
    800012fa:	85ca                	mv	a1,s2
    800012fc:	8526                	mv	a0,s1
    800012fe:	fffff097          	auipc	ra,0xfffff
    80001302:	6c8080e7          	jalr	1736(ra) # 800009c6 <uvmfree>
}
    80001306:	60e2                	ld	ra,24(sp)
    80001308:	6442                	ld	s0,16(sp)
    8000130a:	64a2                	ld	s1,8(sp)
    8000130c:	6902                	ld	s2,0(sp)
    8000130e:	6105                	addi	sp,sp,32
    80001310:	8082                	ret

0000000080001312 <freeproc>:
{
    80001312:	1101                	addi	sp,sp,-32
    80001314:	ec06                	sd	ra,24(sp)
    80001316:	e822                	sd	s0,16(sp)
    80001318:	e426                	sd	s1,8(sp)
    8000131a:	1000                	addi	s0,sp,32
    8000131c:	84aa                	mv	s1,a0
  if(p->trapframe)
    8000131e:	6d28                	ld	a0,88(a0)
    80001320:	c509                	beqz	a0,8000132a <freeproc+0x18>
    kfree((void*)p->trapframe);
    80001322:	fffff097          	auipc	ra,0xfffff
    80001326:	cfa080e7          	jalr	-774(ra) # 8000001c <kfree>
  p->trapframe = 0;
    8000132a:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    8000132e:	68a8                	ld	a0,80(s1)
    80001330:	c511                	beqz	a0,8000133c <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    80001332:	64ac                	ld	a1,72(s1)
    80001334:	00000097          	auipc	ra,0x0
    80001338:	f8c080e7          	jalr	-116(ra) # 800012c0 <proc_freepagetable>
  p->pagetable = 0;
    8000133c:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80001340:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80001344:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80001348:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    8000134c:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80001350:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80001354:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80001358:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    8000135c:	0004ac23          	sw	zero,24(s1)
}
    80001360:	60e2                	ld	ra,24(sp)
    80001362:	6442                	ld	s0,16(sp)
    80001364:	64a2                	ld	s1,8(sp)
    80001366:	6105                	addi	sp,sp,32
    80001368:	8082                	ret

000000008000136a <allocproc>:
{
    8000136a:	1101                	addi	sp,sp,-32
    8000136c:	ec06                	sd	ra,24(sp)
    8000136e:	e822                	sd	s0,16(sp)
    80001370:	e426                	sd	s1,8(sp)
    80001372:	e04a                	sd	s2,0(sp)
    80001374:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    80001376:	00008497          	auipc	s1,0x8
    8000137a:	10a48493          	addi	s1,s1,266 # 80009480 <proc>
    8000137e:	0000e917          	auipc	s2,0xe
    80001382:	b0290913          	addi	s2,s2,-1278 # 8000ee80 <tickslock>
    acquire(&p->lock);
    80001386:	8526                	mv	a0,s1
    80001388:	00005097          	auipc	ra,0x5
    8000138c:	492080e7          	jalr	1170(ra) # 8000681a <acquire>
    if(p->state == UNUSED) {
    80001390:	4c9c                	lw	a5,24(s1)
    80001392:	cf81                	beqz	a5,800013aa <allocproc+0x40>
      release(&p->lock);
    80001394:	8526                	mv	a0,s1
    80001396:	00005097          	auipc	ra,0x5
    8000139a:	538080e7          	jalr	1336(ra) # 800068ce <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    8000139e:	16848493          	addi	s1,s1,360
    800013a2:	ff2492e3          	bne	s1,s2,80001386 <allocproc+0x1c>
  return 0;
    800013a6:	4481                	li	s1,0
    800013a8:	a889                	j	800013fa <allocproc+0x90>
  p->pid = allocpid();
    800013aa:	00000097          	auipc	ra,0x0
    800013ae:	e34080e7          	jalr	-460(ra) # 800011de <allocpid>
    800013b2:	d888                	sw	a0,48(s1)
  p->state = USED;
    800013b4:	4785                	li	a5,1
    800013b6:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    800013b8:	fffff097          	auipc	ra,0xfffff
    800013bc:	d60080e7          	jalr	-672(ra) # 80000118 <kalloc>
    800013c0:	892a                	mv	s2,a0
    800013c2:	eca8                	sd	a0,88(s1)
    800013c4:	c131                	beqz	a0,80001408 <allocproc+0x9e>
  p->pagetable = proc_pagetable(p);
    800013c6:	8526                	mv	a0,s1
    800013c8:	00000097          	auipc	ra,0x0
    800013cc:	e5c080e7          	jalr	-420(ra) # 80001224 <proc_pagetable>
    800013d0:	892a                	mv	s2,a0
    800013d2:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    800013d4:	c531                	beqz	a0,80001420 <allocproc+0xb6>
  memset(&p->context, 0, sizeof(p->context));
    800013d6:	07000613          	li	a2,112
    800013da:	4581                	li	a1,0
    800013dc:	06048513          	addi	a0,s1,96
    800013e0:	fffff097          	auipc	ra,0xfffff
    800013e4:	d98080e7          	jalr	-616(ra) # 80000178 <memset>
  p->context.ra = (uint64)forkret;
    800013e8:	00000797          	auipc	a5,0x0
    800013ec:	db078793          	addi	a5,a5,-592 # 80001198 <forkret>
    800013f0:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    800013f2:	60bc                	ld	a5,64(s1)
    800013f4:	6705                	lui	a4,0x1
    800013f6:	97ba                	add	a5,a5,a4
    800013f8:	f4bc                	sd	a5,104(s1)
}
    800013fa:	8526                	mv	a0,s1
    800013fc:	60e2                	ld	ra,24(sp)
    800013fe:	6442                	ld	s0,16(sp)
    80001400:	64a2                	ld	s1,8(sp)
    80001402:	6902                	ld	s2,0(sp)
    80001404:	6105                	addi	sp,sp,32
    80001406:	8082                	ret
    freeproc(p);
    80001408:	8526                	mv	a0,s1
    8000140a:	00000097          	auipc	ra,0x0
    8000140e:	f08080e7          	jalr	-248(ra) # 80001312 <freeproc>
    release(&p->lock);
    80001412:	8526                	mv	a0,s1
    80001414:	00005097          	auipc	ra,0x5
    80001418:	4ba080e7          	jalr	1210(ra) # 800068ce <release>
    return 0;
    8000141c:	84ca                	mv	s1,s2
    8000141e:	bff1                	j	800013fa <allocproc+0x90>
    freeproc(p);
    80001420:	8526                	mv	a0,s1
    80001422:	00000097          	auipc	ra,0x0
    80001426:	ef0080e7          	jalr	-272(ra) # 80001312 <freeproc>
    release(&p->lock);
    8000142a:	8526                	mv	a0,s1
    8000142c:	00005097          	auipc	ra,0x5
    80001430:	4a2080e7          	jalr	1186(ra) # 800068ce <release>
    return 0;
    80001434:	84ca                	mv	s1,s2
    80001436:	b7d1                	j	800013fa <allocproc+0x90>

0000000080001438 <userinit>:
{
    80001438:	1101                	addi	sp,sp,-32
    8000143a:	ec06                	sd	ra,24(sp)
    8000143c:	e822                	sd	s0,16(sp)
    8000143e:	e426                	sd	s1,8(sp)
    80001440:	1000                	addi	s0,sp,32
  p = allocproc();
    80001442:	00000097          	auipc	ra,0x0
    80001446:	f28080e7          	jalr	-216(ra) # 8000136a <allocproc>
    8000144a:	84aa                	mv	s1,a0
  initproc = p;
    8000144c:	00008797          	auipc	a5,0x8
    80001450:	bca7b223          	sd	a0,-1084(a5) # 80009010 <initproc>
  uvminit(p->pagetable, initcode, sizeof(initcode));
    80001454:	03400613          	li	a2,52
    80001458:	00007597          	auipc	a1,0x7
    8000145c:	5c858593          	addi	a1,a1,1480 # 80008a20 <initcode>
    80001460:	6928                	ld	a0,80(a0)
    80001462:	fffff097          	auipc	ra,0xfffff
    80001466:	396080e7          	jalr	918(ra) # 800007f8 <uvminit>
  p->sz = PGSIZE;
    8000146a:	6785                	lui	a5,0x1
    8000146c:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    8000146e:	6cb8                	ld	a4,88(s1)
    80001470:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80001474:	6cb8                	ld	a4,88(s1)
    80001476:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80001478:	4641                	li	a2,16
    8000147a:	00007597          	auipc	a1,0x7
    8000147e:	d9e58593          	addi	a1,a1,-610 # 80008218 <etext+0x218>
    80001482:	15848513          	addi	a0,s1,344
    80001486:	fffff097          	auipc	ra,0xfffff
    8000148a:	e44080e7          	jalr	-444(ra) # 800002ca <safestrcpy>
  p->cwd = namei("/");
    8000148e:	00007517          	auipc	a0,0x7
    80001492:	d9a50513          	addi	a0,a0,-614 # 80008228 <etext+0x228>
    80001496:	00002097          	auipc	ra,0x2
    8000149a:	176080e7          	jalr	374(ra) # 8000360c <namei>
    8000149e:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    800014a2:	478d                	li	a5,3
    800014a4:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    800014a6:	8526                	mv	a0,s1
    800014a8:	00005097          	auipc	ra,0x5
    800014ac:	426080e7          	jalr	1062(ra) # 800068ce <release>
}
    800014b0:	60e2                	ld	ra,24(sp)
    800014b2:	6442                	ld	s0,16(sp)
    800014b4:	64a2                	ld	s1,8(sp)
    800014b6:	6105                	addi	sp,sp,32
    800014b8:	8082                	ret

00000000800014ba <growproc>:
{
    800014ba:	1101                	addi	sp,sp,-32
    800014bc:	ec06                	sd	ra,24(sp)
    800014be:	e822                	sd	s0,16(sp)
    800014c0:	e426                	sd	s1,8(sp)
    800014c2:	e04a                	sd	s2,0(sp)
    800014c4:	1000                	addi	s0,sp,32
    800014c6:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    800014c8:	00000097          	auipc	ra,0x0
    800014cc:	c98080e7          	jalr	-872(ra) # 80001160 <myproc>
    800014d0:	892a                	mv	s2,a0
  sz = p->sz;
    800014d2:	652c                	ld	a1,72(a0)
    800014d4:	0005861b          	sext.w	a2,a1
  if(n > 0){
    800014d8:	00904f63          	bgtz	s1,800014f6 <growproc+0x3c>
  } else if(n < 0){
    800014dc:	0204cc63          	bltz	s1,80001514 <growproc+0x5a>
  p->sz = sz;
    800014e0:	1602                	slli	a2,a2,0x20
    800014e2:	9201                	srli	a2,a2,0x20
    800014e4:	04c93423          	sd	a2,72(s2)
  return 0;
    800014e8:	4501                	li	a0,0
}
    800014ea:	60e2                	ld	ra,24(sp)
    800014ec:	6442                	ld	s0,16(sp)
    800014ee:	64a2                	ld	s1,8(sp)
    800014f0:	6902                	ld	s2,0(sp)
    800014f2:	6105                	addi	sp,sp,32
    800014f4:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    800014f6:	9e25                	addw	a2,a2,s1
    800014f8:	1602                	slli	a2,a2,0x20
    800014fa:	9201                	srli	a2,a2,0x20
    800014fc:	1582                	slli	a1,a1,0x20
    800014fe:	9181                	srli	a1,a1,0x20
    80001500:	6928                	ld	a0,80(a0)
    80001502:	fffff097          	auipc	ra,0xfffff
    80001506:	3b0080e7          	jalr	944(ra) # 800008b2 <uvmalloc>
    8000150a:	0005061b          	sext.w	a2,a0
    8000150e:	fa69                	bnez	a2,800014e0 <growproc+0x26>
      return -1;
    80001510:	557d                	li	a0,-1
    80001512:	bfe1                	j	800014ea <growproc+0x30>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80001514:	9e25                	addw	a2,a2,s1
    80001516:	1602                	slli	a2,a2,0x20
    80001518:	9201                	srli	a2,a2,0x20
    8000151a:	1582                	slli	a1,a1,0x20
    8000151c:	9181                	srli	a1,a1,0x20
    8000151e:	6928                	ld	a0,80(a0)
    80001520:	fffff097          	auipc	ra,0xfffff
    80001524:	34a080e7          	jalr	842(ra) # 8000086a <uvmdealloc>
    80001528:	0005061b          	sext.w	a2,a0
    8000152c:	bf55                	j	800014e0 <growproc+0x26>

000000008000152e <fork>:
{
    8000152e:	7179                	addi	sp,sp,-48
    80001530:	f406                	sd	ra,40(sp)
    80001532:	f022                	sd	s0,32(sp)
    80001534:	ec26                	sd	s1,24(sp)
    80001536:	e84a                	sd	s2,16(sp)
    80001538:	e44e                	sd	s3,8(sp)
    8000153a:	e052                	sd	s4,0(sp)
    8000153c:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    8000153e:	00000097          	auipc	ra,0x0
    80001542:	c22080e7          	jalr	-990(ra) # 80001160 <myproc>
    80001546:	892a                	mv	s2,a0
  if((np = allocproc()) == 0){
    80001548:	00000097          	auipc	ra,0x0
    8000154c:	e22080e7          	jalr	-478(ra) # 8000136a <allocproc>
    80001550:	10050b63          	beqz	a0,80001666 <fork+0x138>
    80001554:	89aa                	mv	s3,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80001556:	04893603          	ld	a2,72(s2)
    8000155a:	692c                	ld	a1,80(a0)
    8000155c:	05093503          	ld	a0,80(s2)
    80001560:	fffff097          	auipc	ra,0xfffff
    80001564:	49e080e7          	jalr	1182(ra) # 800009fe <uvmcopy>
    80001568:	04054663          	bltz	a0,800015b4 <fork+0x86>
  np->sz = p->sz;
    8000156c:	04893783          	ld	a5,72(s2)
    80001570:	04f9b423          	sd	a5,72(s3)
  *(np->trapframe) = *(p->trapframe);
    80001574:	05893683          	ld	a3,88(s2)
    80001578:	87b6                	mv	a5,a3
    8000157a:	0589b703          	ld	a4,88(s3)
    8000157e:	12068693          	addi	a3,a3,288
    80001582:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    80001586:	6788                	ld	a0,8(a5)
    80001588:	6b8c                	ld	a1,16(a5)
    8000158a:	6f90                	ld	a2,24(a5)
    8000158c:	01073023          	sd	a6,0(a4)
    80001590:	e708                	sd	a0,8(a4)
    80001592:	eb0c                	sd	a1,16(a4)
    80001594:	ef10                	sd	a2,24(a4)
    80001596:	02078793          	addi	a5,a5,32
    8000159a:	02070713          	addi	a4,a4,32
    8000159e:	fed792e3          	bne	a5,a3,80001582 <fork+0x54>
  np->trapframe->a0 = 0;
    800015a2:	0589b783          	ld	a5,88(s3)
    800015a6:	0607b823          	sd	zero,112(a5)
    800015aa:	0d000493          	li	s1,208
  for(i = 0; i < NOFILE; i++)
    800015ae:	15000a13          	li	s4,336
    800015b2:	a03d                	j	800015e0 <fork+0xb2>
    freeproc(np);
    800015b4:	854e                	mv	a0,s3
    800015b6:	00000097          	auipc	ra,0x0
    800015ba:	d5c080e7          	jalr	-676(ra) # 80001312 <freeproc>
    release(&np->lock);
    800015be:	854e                	mv	a0,s3
    800015c0:	00005097          	auipc	ra,0x5
    800015c4:	30e080e7          	jalr	782(ra) # 800068ce <release>
    return -1;
    800015c8:	5a7d                	li	s4,-1
    800015ca:	a069                	j	80001654 <fork+0x126>
      np->ofile[i] = filedup(p->ofile[i]);
    800015cc:	00003097          	auipc	ra,0x3
    800015d0:	868080e7          	jalr	-1944(ra) # 80003e34 <filedup>
    800015d4:	009987b3          	add	a5,s3,s1
    800015d8:	e388                	sd	a0,0(a5)
  for(i = 0; i < NOFILE; i++)
    800015da:	04a1                	addi	s1,s1,8
    800015dc:	01448763          	beq	s1,s4,800015ea <fork+0xbc>
    if(p->ofile[i])
    800015e0:	009907b3          	add	a5,s2,s1
    800015e4:	6388                	ld	a0,0(a5)
    800015e6:	f17d                	bnez	a0,800015cc <fork+0x9e>
    800015e8:	bfcd                	j	800015da <fork+0xac>
  np->cwd = idup(p->cwd);
    800015ea:	15093503          	ld	a0,336(s2)
    800015ee:	00002097          	auipc	ra,0x2
    800015f2:	834080e7          	jalr	-1996(ra) # 80002e22 <idup>
    800015f6:	14a9b823          	sd	a0,336(s3)
  safestrcpy(np->name, p->name, sizeof(p->name));
    800015fa:	4641                	li	a2,16
    800015fc:	15890593          	addi	a1,s2,344
    80001600:	15898513          	addi	a0,s3,344
    80001604:	fffff097          	auipc	ra,0xfffff
    80001608:	cc6080e7          	jalr	-826(ra) # 800002ca <safestrcpy>
  pid = np->pid;
    8000160c:	0309aa03          	lw	s4,48(s3)
  release(&np->lock);
    80001610:	854e                	mv	a0,s3
    80001612:	00005097          	auipc	ra,0x5
    80001616:	2bc080e7          	jalr	700(ra) # 800068ce <release>
  acquire(&wait_lock);
    8000161a:	00008497          	auipc	s1,0x8
    8000161e:	a4e48493          	addi	s1,s1,-1458 # 80009068 <wait_lock>
    80001622:	8526                	mv	a0,s1
    80001624:	00005097          	auipc	ra,0x5
    80001628:	1f6080e7          	jalr	502(ra) # 8000681a <acquire>
  np->parent = p;
    8000162c:	0329bc23          	sd	s2,56(s3)
  release(&wait_lock);
    80001630:	8526                	mv	a0,s1
    80001632:	00005097          	auipc	ra,0x5
    80001636:	29c080e7          	jalr	668(ra) # 800068ce <release>
  acquire(&np->lock);
    8000163a:	854e                	mv	a0,s3
    8000163c:	00005097          	auipc	ra,0x5
    80001640:	1de080e7          	jalr	478(ra) # 8000681a <acquire>
  np->state = RUNNABLE;
    80001644:	478d                	li	a5,3
    80001646:	00f9ac23          	sw	a5,24(s3)
  release(&np->lock);
    8000164a:	854e                	mv	a0,s3
    8000164c:	00005097          	auipc	ra,0x5
    80001650:	282080e7          	jalr	642(ra) # 800068ce <release>
}
    80001654:	8552                	mv	a0,s4
    80001656:	70a2                	ld	ra,40(sp)
    80001658:	7402                	ld	s0,32(sp)
    8000165a:	64e2                	ld	s1,24(sp)
    8000165c:	6942                	ld	s2,16(sp)
    8000165e:	69a2                	ld	s3,8(sp)
    80001660:	6a02                	ld	s4,0(sp)
    80001662:	6145                	addi	sp,sp,48
    80001664:	8082                	ret
    return -1;
    80001666:	5a7d                	li	s4,-1
    80001668:	b7f5                	j	80001654 <fork+0x126>

000000008000166a <scheduler>:
{
    8000166a:	7139                	addi	sp,sp,-64
    8000166c:	fc06                	sd	ra,56(sp)
    8000166e:	f822                	sd	s0,48(sp)
    80001670:	f426                	sd	s1,40(sp)
    80001672:	f04a                	sd	s2,32(sp)
    80001674:	ec4e                	sd	s3,24(sp)
    80001676:	e852                	sd	s4,16(sp)
    80001678:	e456                	sd	s5,8(sp)
    8000167a:	e05a                	sd	s6,0(sp)
    8000167c:	0080                	addi	s0,sp,64
    8000167e:	8792                	mv	a5,tp
  int id = r_tp();
    80001680:	2781                	sext.w	a5,a5
  c->proc = 0;
    80001682:	00779a93          	slli	s5,a5,0x7
    80001686:	00008717          	auipc	a4,0x8
    8000168a:	9ca70713          	addi	a4,a4,-1590 # 80009050 <pid_lock>
    8000168e:	9756                	add	a4,a4,s5
    80001690:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    80001694:	00008717          	auipc	a4,0x8
    80001698:	9f470713          	addi	a4,a4,-1548 # 80009088 <cpus+0x8>
    8000169c:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    8000169e:	498d                	li	s3,3
        p->state = RUNNING;
    800016a0:	4b11                	li	s6,4
        c->proc = p;
    800016a2:	079e                	slli	a5,a5,0x7
    800016a4:	00008a17          	auipc	s4,0x8
    800016a8:	9aca0a13          	addi	s4,s4,-1620 # 80009050 <pid_lock>
    800016ac:	9a3e                	add	s4,s4,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    800016ae:	0000d917          	auipc	s2,0xd
    800016b2:	7d290913          	addi	s2,s2,2002 # 8000ee80 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800016b6:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800016ba:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800016be:	10079073          	csrw	sstatus,a5
    800016c2:	00008497          	auipc	s1,0x8
    800016c6:	dbe48493          	addi	s1,s1,-578 # 80009480 <proc>
    800016ca:	a03d                	j	800016f8 <scheduler+0x8e>
        p->state = RUNNING;
    800016cc:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    800016d0:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    800016d4:	06048593          	addi	a1,s1,96
    800016d8:	8556                	mv	a0,s5
    800016da:	00000097          	auipc	ra,0x0
    800016de:	640080e7          	jalr	1600(ra) # 80001d1a <swtch>
        c->proc = 0;
    800016e2:	020a3823          	sd	zero,48(s4)
      release(&p->lock);
    800016e6:	8526                	mv	a0,s1
    800016e8:	00005097          	auipc	ra,0x5
    800016ec:	1e6080e7          	jalr	486(ra) # 800068ce <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    800016f0:	16848493          	addi	s1,s1,360
    800016f4:	fd2481e3          	beq	s1,s2,800016b6 <scheduler+0x4c>
      acquire(&p->lock);
    800016f8:	8526                	mv	a0,s1
    800016fa:	00005097          	auipc	ra,0x5
    800016fe:	120080e7          	jalr	288(ra) # 8000681a <acquire>
      if(p->state == RUNNABLE) {
    80001702:	4c9c                	lw	a5,24(s1)
    80001704:	ff3791e3          	bne	a5,s3,800016e6 <scheduler+0x7c>
    80001708:	b7d1                	j	800016cc <scheduler+0x62>

000000008000170a <sched>:
{
    8000170a:	7179                	addi	sp,sp,-48
    8000170c:	f406                	sd	ra,40(sp)
    8000170e:	f022                	sd	s0,32(sp)
    80001710:	ec26                	sd	s1,24(sp)
    80001712:	e84a                	sd	s2,16(sp)
    80001714:	e44e                	sd	s3,8(sp)
    80001716:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001718:	00000097          	auipc	ra,0x0
    8000171c:	a48080e7          	jalr	-1464(ra) # 80001160 <myproc>
    80001720:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    80001722:	00005097          	auipc	ra,0x5
    80001726:	07e080e7          	jalr	126(ra) # 800067a0 <holding>
    8000172a:	c93d                	beqz	a0,800017a0 <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    8000172c:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    8000172e:	2781                	sext.w	a5,a5
    80001730:	079e                	slli	a5,a5,0x7
    80001732:	00008717          	auipc	a4,0x8
    80001736:	91e70713          	addi	a4,a4,-1762 # 80009050 <pid_lock>
    8000173a:	97ba                	add	a5,a5,a4
    8000173c:	0a87a703          	lw	a4,168(a5)
    80001740:	4785                	li	a5,1
    80001742:	06f71763          	bne	a4,a5,800017b0 <sched+0xa6>
  if(p->state == RUNNING)
    80001746:	4c98                	lw	a4,24(s1)
    80001748:	4791                	li	a5,4
    8000174a:	06f70b63          	beq	a4,a5,800017c0 <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000174e:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001752:	8b89                	andi	a5,a5,2
  if(intr_get())
    80001754:	efb5                	bnez	a5,800017d0 <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001756:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80001758:	00008917          	auipc	s2,0x8
    8000175c:	8f890913          	addi	s2,s2,-1800 # 80009050 <pid_lock>
    80001760:	2781                	sext.w	a5,a5
    80001762:	079e                	slli	a5,a5,0x7
    80001764:	97ca                	add	a5,a5,s2
    80001766:	0ac7a983          	lw	s3,172(a5)
    8000176a:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    8000176c:	2781                	sext.w	a5,a5
    8000176e:	079e                	slli	a5,a5,0x7
    80001770:	00008597          	auipc	a1,0x8
    80001774:	91858593          	addi	a1,a1,-1768 # 80009088 <cpus+0x8>
    80001778:	95be                	add	a1,a1,a5
    8000177a:	06048513          	addi	a0,s1,96
    8000177e:	00000097          	auipc	ra,0x0
    80001782:	59c080e7          	jalr	1436(ra) # 80001d1a <swtch>
    80001786:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80001788:	2781                	sext.w	a5,a5
    8000178a:	079e                	slli	a5,a5,0x7
    8000178c:	97ca                	add	a5,a5,s2
    8000178e:	0b37a623          	sw	s3,172(a5)
}
    80001792:	70a2                	ld	ra,40(sp)
    80001794:	7402                	ld	s0,32(sp)
    80001796:	64e2                	ld	s1,24(sp)
    80001798:	6942                	ld	s2,16(sp)
    8000179a:	69a2                	ld	s3,8(sp)
    8000179c:	6145                	addi	sp,sp,48
    8000179e:	8082                	ret
    panic("sched p->lock");
    800017a0:	00007517          	auipc	a0,0x7
    800017a4:	a9050513          	addi	a0,a0,-1392 # 80008230 <etext+0x230>
    800017a8:	00005097          	auipc	ra,0x5
    800017ac:	b28080e7          	jalr	-1240(ra) # 800062d0 <panic>
    panic("sched locks");
    800017b0:	00007517          	auipc	a0,0x7
    800017b4:	a9050513          	addi	a0,a0,-1392 # 80008240 <etext+0x240>
    800017b8:	00005097          	auipc	ra,0x5
    800017bc:	b18080e7          	jalr	-1256(ra) # 800062d0 <panic>
    panic("sched running");
    800017c0:	00007517          	auipc	a0,0x7
    800017c4:	a9050513          	addi	a0,a0,-1392 # 80008250 <etext+0x250>
    800017c8:	00005097          	auipc	ra,0x5
    800017cc:	b08080e7          	jalr	-1272(ra) # 800062d0 <panic>
    panic("sched interruptible");
    800017d0:	00007517          	auipc	a0,0x7
    800017d4:	a9050513          	addi	a0,a0,-1392 # 80008260 <etext+0x260>
    800017d8:	00005097          	auipc	ra,0x5
    800017dc:	af8080e7          	jalr	-1288(ra) # 800062d0 <panic>

00000000800017e0 <yield>:
{
    800017e0:	1101                	addi	sp,sp,-32
    800017e2:	ec06                	sd	ra,24(sp)
    800017e4:	e822                	sd	s0,16(sp)
    800017e6:	e426                	sd	s1,8(sp)
    800017e8:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    800017ea:	00000097          	auipc	ra,0x0
    800017ee:	976080e7          	jalr	-1674(ra) # 80001160 <myproc>
    800017f2:	84aa                	mv	s1,a0
  acquire(&p->lock);
    800017f4:	00005097          	auipc	ra,0x5
    800017f8:	026080e7          	jalr	38(ra) # 8000681a <acquire>
  p->state = RUNNABLE;
    800017fc:	478d                	li	a5,3
    800017fe:	cc9c                	sw	a5,24(s1)
  sched();
    80001800:	00000097          	auipc	ra,0x0
    80001804:	f0a080e7          	jalr	-246(ra) # 8000170a <sched>
  release(&p->lock);
    80001808:	8526                	mv	a0,s1
    8000180a:	00005097          	auipc	ra,0x5
    8000180e:	0c4080e7          	jalr	196(ra) # 800068ce <release>
}
    80001812:	60e2                	ld	ra,24(sp)
    80001814:	6442                	ld	s0,16(sp)
    80001816:	64a2                	ld	s1,8(sp)
    80001818:	6105                	addi	sp,sp,32
    8000181a:	8082                	ret

000000008000181c <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    8000181c:	7179                	addi	sp,sp,-48
    8000181e:	f406                	sd	ra,40(sp)
    80001820:	f022                	sd	s0,32(sp)
    80001822:	ec26                	sd	s1,24(sp)
    80001824:	e84a                	sd	s2,16(sp)
    80001826:	e44e                	sd	s3,8(sp)
    80001828:	1800                	addi	s0,sp,48
    8000182a:	89aa                	mv	s3,a0
    8000182c:	892e                	mv	s2,a1
  struct proc *p = myproc();
    8000182e:	00000097          	auipc	ra,0x0
    80001832:	932080e7          	jalr	-1742(ra) # 80001160 <myproc>
    80001836:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    80001838:	00005097          	auipc	ra,0x5
    8000183c:	fe2080e7          	jalr	-30(ra) # 8000681a <acquire>
  release(lk);
    80001840:	854a                	mv	a0,s2
    80001842:	00005097          	auipc	ra,0x5
    80001846:	08c080e7          	jalr	140(ra) # 800068ce <release>

  // Go to sleep.
  p->chan = chan;
    8000184a:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    8000184e:	4789                	li	a5,2
    80001850:	cc9c                	sw	a5,24(s1)

  sched();
    80001852:	00000097          	auipc	ra,0x0
    80001856:	eb8080e7          	jalr	-328(ra) # 8000170a <sched>

  // Tidy up.
  p->chan = 0;
    8000185a:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    8000185e:	8526                	mv	a0,s1
    80001860:	00005097          	auipc	ra,0x5
    80001864:	06e080e7          	jalr	110(ra) # 800068ce <release>
  acquire(lk);
    80001868:	854a                	mv	a0,s2
    8000186a:	00005097          	auipc	ra,0x5
    8000186e:	fb0080e7          	jalr	-80(ra) # 8000681a <acquire>
}
    80001872:	70a2                	ld	ra,40(sp)
    80001874:	7402                	ld	s0,32(sp)
    80001876:	64e2                	ld	s1,24(sp)
    80001878:	6942                	ld	s2,16(sp)
    8000187a:	69a2                	ld	s3,8(sp)
    8000187c:	6145                	addi	sp,sp,48
    8000187e:	8082                	ret

0000000080001880 <wait>:
{
    80001880:	715d                	addi	sp,sp,-80
    80001882:	e486                	sd	ra,72(sp)
    80001884:	e0a2                	sd	s0,64(sp)
    80001886:	fc26                	sd	s1,56(sp)
    80001888:	f84a                	sd	s2,48(sp)
    8000188a:	f44e                	sd	s3,40(sp)
    8000188c:	f052                	sd	s4,32(sp)
    8000188e:	ec56                	sd	s5,24(sp)
    80001890:	e85a                	sd	s6,16(sp)
    80001892:	e45e                	sd	s7,8(sp)
    80001894:	e062                	sd	s8,0(sp)
    80001896:	0880                	addi	s0,sp,80
    80001898:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    8000189a:	00000097          	auipc	ra,0x0
    8000189e:	8c6080e7          	jalr	-1850(ra) # 80001160 <myproc>
    800018a2:	892a                	mv	s2,a0
  acquire(&wait_lock);
    800018a4:	00007517          	auipc	a0,0x7
    800018a8:	7c450513          	addi	a0,a0,1988 # 80009068 <wait_lock>
    800018ac:	00005097          	auipc	ra,0x5
    800018b0:	f6e080e7          	jalr	-146(ra) # 8000681a <acquire>
    havekids = 0;
    800018b4:	4b81                	li	s7,0
        if(np->state == ZOMBIE){
    800018b6:	4a15                	li	s4,5
    for(np = proc; np < &proc[NPROC]; np++){
    800018b8:	0000d997          	auipc	s3,0xd
    800018bc:	5c898993          	addi	s3,s3,1480 # 8000ee80 <tickslock>
        havekids = 1;
    800018c0:	4a85                	li	s5,1
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800018c2:	00007c17          	auipc	s8,0x7
    800018c6:	7a6c0c13          	addi	s8,s8,1958 # 80009068 <wait_lock>
    havekids = 0;
    800018ca:	875e                	mv	a4,s7
    for(np = proc; np < &proc[NPROC]; np++){
    800018cc:	00008497          	auipc	s1,0x8
    800018d0:	bb448493          	addi	s1,s1,-1100 # 80009480 <proc>
    800018d4:	a0bd                	j	80001942 <wait+0xc2>
          pid = np->pid;
    800018d6:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    800018da:	000b0e63          	beqz	s6,800018f6 <wait+0x76>
    800018de:	4691                	li	a3,4
    800018e0:	02c48613          	addi	a2,s1,44
    800018e4:	85da                	mv	a1,s6
    800018e6:	05093503          	ld	a0,80(s2)
    800018ea:	fffff097          	auipc	ra,0xfffff
    800018ee:	218080e7          	jalr	536(ra) # 80000b02 <copyout>
    800018f2:	02054563          	bltz	a0,8000191c <wait+0x9c>
          freeproc(np);
    800018f6:	8526                	mv	a0,s1
    800018f8:	00000097          	auipc	ra,0x0
    800018fc:	a1a080e7          	jalr	-1510(ra) # 80001312 <freeproc>
          release(&np->lock);
    80001900:	8526                	mv	a0,s1
    80001902:	00005097          	auipc	ra,0x5
    80001906:	fcc080e7          	jalr	-52(ra) # 800068ce <release>
          release(&wait_lock);
    8000190a:	00007517          	auipc	a0,0x7
    8000190e:	75e50513          	addi	a0,a0,1886 # 80009068 <wait_lock>
    80001912:	00005097          	auipc	ra,0x5
    80001916:	fbc080e7          	jalr	-68(ra) # 800068ce <release>
          return pid;
    8000191a:	a09d                	j	80001980 <wait+0x100>
            release(&np->lock);
    8000191c:	8526                	mv	a0,s1
    8000191e:	00005097          	auipc	ra,0x5
    80001922:	fb0080e7          	jalr	-80(ra) # 800068ce <release>
            release(&wait_lock);
    80001926:	00007517          	auipc	a0,0x7
    8000192a:	74250513          	addi	a0,a0,1858 # 80009068 <wait_lock>
    8000192e:	00005097          	auipc	ra,0x5
    80001932:	fa0080e7          	jalr	-96(ra) # 800068ce <release>
            return -1;
    80001936:	59fd                	li	s3,-1
    80001938:	a0a1                	j	80001980 <wait+0x100>
    for(np = proc; np < &proc[NPROC]; np++){
    8000193a:	16848493          	addi	s1,s1,360
    8000193e:	03348463          	beq	s1,s3,80001966 <wait+0xe6>
      if(np->parent == p){
    80001942:	7c9c                	ld	a5,56(s1)
    80001944:	ff279be3          	bne	a5,s2,8000193a <wait+0xba>
        acquire(&np->lock);
    80001948:	8526                	mv	a0,s1
    8000194a:	00005097          	auipc	ra,0x5
    8000194e:	ed0080e7          	jalr	-304(ra) # 8000681a <acquire>
        if(np->state == ZOMBIE){
    80001952:	4c9c                	lw	a5,24(s1)
    80001954:	f94781e3          	beq	a5,s4,800018d6 <wait+0x56>
        release(&np->lock);
    80001958:	8526                	mv	a0,s1
    8000195a:	00005097          	auipc	ra,0x5
    8000195e:	f74080e7          	jalr	-140(ra) # 800068ce <release>
        havekids = 1;
    80001962:	8756                	mv	a4,s5
    80001964:	bfd9                	j	8000193a <wait+0xba>
    if(!havekids || p->killed){
    80001966:	c701                	beqz	a4,8000196e <wait+0xee>
    80001968:	02892783          	lw	a5,40(s2)
    8000196c:	c79d                	beqz	a5,8000199a <wait+0x11a>
      release(&wait_lock);
    8000196e:	00007517          	auipc	a0,0x7
    80001972:	6fa50513          	addi	a0,a0,1786 # 80009068 <wait_lock>
    80001976:	00005097          	auipc	ra,0x5
    8000197a:	f58080e7          	jalr	-168(ra) # 800068ce <release>
      return -1;
    8000197e:	59fd                	li	s3,-1
}
    80001980:	854e                	mv	a0,s3
    80001982:	60a6                	ld	ra,72(sp)
    80001984:	6406                	ld	s0,64(sp)
    80001986:	74e2                	ld	s1,56(sp)
    80001988:	7942                	ld	s2,48(sp)
    8000198a:	79a2                	ld	s3,40(sp)
    8000198c:	7a02                	ld	s4,32(sp)
    8000198e:	6ae2                	ld	s5,24(sp)
    80001990:	6b42                	ld	s6,16(sp)
    80001992:	6ba2                	ld	s7,8(sp)
    80001994:	6c02                	ld	s8,0(sp)
    80001996:	6161                	addi	sp,sp,80
    80001998:	8082                	ret
    sleep(p, &wait_lock);  //DOC: wait-sleep
    8000199a:	85e2                	mv	a1,s8
    8000199c:	854a                	mv	a0,s2
    8000199e:	00000097          	auipc	ra,0x0
    800019a2:	e7e080e7          	jalr	-386(ra) # 8000181c <sleep>
    havekids = 0;
    800019a6:	b715                	j	800018ca <wait+0x4a>

00000000800019a8 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    800019a8:	7139                	addi	sp,sp,-64
    800019aa:	fc06                	sd	ra,56(sp)
    800019ac:	f822                	sd	s0,48(sp)
    800019ae:	f426                	sd	s1,40(sp)
    800019b0:	f04a                	sd	s2,32(sp)
    800019b2:	ec4e                	sd	s3,24(sp)
    800019b4:	e852                	sd	s4,16(sp)
    800019b6:	e456                	sd	s5,8(sp)
    800019b8:	0080                	addi	s0,sp,64
    800019ba:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800019bc:	00008497          	auipc	s1,0x8
    800019c0:	ac448493          	addi	s1,s1,-1340 # 80009480 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    800019c4:	4989                	li	s3,2
        p->state = RUNNABLE;
    800019c6:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    800019c8:	0000d917          	auipc	s2,0xd
    800019cc:	4b890913          	addi	s2,s2,1208 # 8000ee80 <tickslock>
    800019d0:	a821                	j	800019e8 <wakeup+0x40>
        p->state = RUNNABLE;
    800019d2:	0154ac23          	sw	s5,24(s1)
      }
      release(&p->lock);
    800019d6:	8526                	mv	a0,s1
    800019d8:	00005097          	auipc	ra,0x5
    800019dc:	ef6080e7          	jalr	-266(ra) # 800068ce <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800019e0:	16848493          	addi	s1,s1,360
    800019e4:	03248463          	beq	s1,s2,80001a0c <wakeup+0x64>
    if(p != myproc()){
    800019e8:	fffff097          	auipc	ra,0xfffff
    800019ec:	778080e7          	jalr	1912(ra) # 80001160 <myproc>
    800019f0:	fea488e3          	beq	s1,a0,800019e0 <wakeup+0x38>
      acquire(&p->lock);
    800019f4:	8526                	mv	a0,s1
    800019f6:	00005097          	auipc	ra,0x5
    800019fa:	e24080e7          	jalr	-476(ra) # 8000681a <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    800019fe:	4c9c                	lw	a5,24(s1)
    80001a00:	fd379be3          	bne	a5,s3,800019d6 <wakeup+0x2e>
    80001a04:	709c                	ld	a5,32(s1)
    80001a06:	fd4798e3          	bne	a5,s4,800019d6 <wakeup+0x2e>
    80001a0a:	b7e1                	j	800019d2 <wakeup+0x2a>
    }
  }
}
    80001a0c:	70e2                	ld	ra,56(sp)
    80001a0e:	7442                	ld	s0,48(sp)
    80001a10:	74a2                	ld	s1,40(sp)
    80001a12:	7902                	ld	s2,32(sp)
    80001a14:	69e2                	ld	s3,24(sp)
    80001a16:	6a42                	ld	s4,16(sp)
    80001a18:	6aa2                	ld	s5,8(sp)
    80001a1a:	6121                	addi	sp,sp,64
    80001a1c:	8082                	ret

0000000080001a1e <reparent>:
{
    80001a1e:	7179                	addi	sp,sp,-48
    80001a20:	f406                	sd	ra,40(sp)
    80001a22:	f022                	sd	s0,32(sp)
    80001a24:	ec26                	sd	s1,24(sp)
    80001a26:	e84a                	sd	s2,16(sp)
    80001a28:	e44e                	sd	s3,8(sp)
    80001a2a:	e052                	sd	s4,0(sp)
    80001a2c:	1800                	addi	s0,sp,48
    80001a2e:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001a30:	00008497          	auipc	s1,0x8
    80001a34:	a5048493          	addi	s1,s1,-1456 # 80009480 <proc>
      pp->parent = initproc;
    80001a38:	00007a17          	auipc	s4,0x7
    80001a3c:	5d8a0a13          	addi	s4,s4,1496 # 80009010 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001a40:	0000d997          	auipc	s3,0xd
    80001a44:	44098993          	addi	s3,s3,1088 # 8000ee80 <tickslock>
    80001a48:	a029                	j	80001a52 <reparent+0x34>
    80001a4a:	16848493          	addi	s1,s1,360
    80001a4e:	01348d63          	beq	s1,s3,80001a68 <reparent+0x4a>
    if(pp->parent == p){
    80001a52:	7c9c                	ld	a5,56(s1)
    80001a54:	ff279be3          	bne	a5,s2,80001a4a <reparent+0x2c>
      pp->parent = initproc;
    80001a58:	000a3503          	ld	a0,0(s4)
    80001a5c:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    80001a5e:	00000097          	auipc	ra,0x0
    80001a62:	f4a080e7          	jalr	-182(ra) # 800019a8 <wakeup>
    80001a66:	b7d5                	j	80001a4a <reparent+0x2c>
}
    80001a68:	70a2                	ld	ra,40(sp)
    80001a6a:	7402                	ld	s0,32(sp)
    80001a6c:	64e2                	ld	s1,24(sp)
    80001a6e:	6942                	ld	s2,16(sp)
    80001a70:	69a2                	ld	s3,8(sp)
    80001a72:	6a02                	ld	s4,0(sp)
    80001a74:	6145                	addi	sp,sp,48
    80001a76:	8082                	ret

0000000080001a78 <exit>:
{
    80001a78:	7179                	addi	sp,sp,-48
    80001a7a:	f406                	sd	ra,40(sp)
    80001a7c:	f022                	sd	s0,32(sp)
    80001a7e:	ec26                	sd	s1,24(sp)
    80001a80:	e84a                	sd	s2,16(sp)
    80001a82:	e44e                	sd	s3,8(sp)
    80001a84:	e052                	sd	s4,0(sp)
    80001a86:	1800                	addi	s0,sp,48
    80001a88:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    80001a8a:	fffff097          	auipc	ra,0xfffff
    80001a8e:	6d6080e7          	jalr	1750(ra) # 80001160 <myproc>
    80001a92:	89aa                	mv	s3,a0
  if(p == initproc)
    80001a94:	00007797          	auipc	a5,0x7
    80001a98:	57c7b783          	ld	a5,1404(a5) # 80009010 <initproc>
    80001a9c:	0d050493          	addi	s1,a0,208
    80001aa0:	15050913          	addi	s2,a0,336
    80001aa4:	02a79363          	bne	a5,a0,80001aca <exit+0x52>
    panic("init exiting");
    80001aa8:	00006517          	auipc	a0,0x6
    80001aac:	7d050513          	addi	a0,a0,2000 # 80008278 <etext+0x278>
    80001ab0:	00005097          	auipc	ra,0x5
    80001ab4:	820080e7          	jalr	-2016(ra) # 800062d0 <panic>
      fileclose(f);
    80001ab8:	00002097          	auipc	ra,0x2
    80001abc:	3ce080e7          	jalr	974(ra) # 80003e86 <fileclose>
      p->ofile[fd] = 0;
    80001ac0:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    80001ac4:	04a1                	addi	s1,s1,8
    80001ac6:	01248563          	beq	s1,s2,80001ad0 <exit+0x58>
    if(p->ofile[fd]){
    80001aca:	6088                	ld	a0,0(s1)
    80001acc:	f575                	bnez	a0,80001ab8 <exit+0x40>
    80001ace:	bfdd                	j	80001ac4 <exit+0x4c>
  begin_op();
    80001ad0:	00002097          	auipc	ra,0x2
    80001ad4:	eea080e7          	jalr	-278(ra) # 800039ba <begin_op>
  iput(p->cwd);
    80001ad8:	1509b503          	ld	a0,336(s3)
    80001adc:	00001097          	auipc	ra,0x1
    80001ae0:	53e080e7          	jalr	1342(ra) # 8000301a <iput>
  end_op();
    80001ae4:	00002097          	auipc	ra,0x2
    80001ae8:	f56080e7          	jalr	-170(ra) # 80003a3a <end_op>
  p->cwd = 0;
    80001aec:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    80001af0:	00007497          	auipc	s1,0x7
    80001af4:	57848493          	addi	s1,s1,1400 # 80009068 <wait_lock>
    80001af8:	8526                	mv	a0,s1
    80001afa:	00005097          	auipc	ra,0x5
    80001afe:	d20080e7          	jalr	-736(ra) # 8000681a <acquire>
  reparent(p);
    80001b02:	854e                	mv	a0,s3
    80001b04:	00000097          	auipc	ra,0x0
    80001b08:	f1a080e7          	jalr	-230(ra) # 80001a1e <reparent>
  wakeup(p->parent);
    80001b0c:	0389b503          	ld	a0,56(s3)
    80001b10:	00000097          	auipc	ra,0x0
    80001b14:	e98080e7          	jalr	-360(ra) # 800019a8 <wakeup>
  acquire(&p->lock);
    80001b18:	854e                	mv	a0,s3
    80001b1a:	00005097          	auipc	ra,0x5
    80001b1e:	d00080e7          	jalr	-768(ra) # 8000681a <acquire>
  p->xstate = status;
    80001b22:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    80001b26:	4795                	li	a5,5
    80001b28:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    80001b2c:	8526                	mv	a0,s1
    80001b2e:	00005097          	auipc	ra,0x5
    80001b32:	da0080e7          	jalr	-608(ra) # 800068ce <release>
  sched();
    80001b36:	00000097          	auipc	ra,0x0
    80001b3a:	bd4080e7          	jalr	-1068(ra) # 8000170a <sched>
  panic("zombie exit");
    80001b3e:	00006517          	auipc	a0,0x6
    80001b42:	74a50513          	addi	a0,a0,1866 # 80008288 <etext+0x288>
    80001b46:	00004097          	auipc	ra,0x4
    80001b4a:	78a080e7          	jalr	1930(ra) # 800062d0 <panic>

0000000080001b4e <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80001b4e:	7179                	addi	sp,sp,-48
    80001b50:	f406                	sd	ra,40(sp)
    80001b52:	f022                	sd	s0,32(sp)
    80001b54:	ec26                	sd	s1,24(sp)
    80001b56:	e84a                	sd	s2,16(sp)
    80001b58:	e44e                	sd	s3,8(sp)
    80001b5a:	1800                	addi	s0,sp,48
    80001b5c:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80001b5e:	00008497          	auipc	s1,0x8
    80001b62:	92248493          	addi	s1,s1,-1758 # 80009480 <proc>
    80001b66:	0000d997          	auipc	s3,0xd
    80001b6a:	31a98993          	addi	s3,s3,794 # 8000ee80 <tickslock>
    acquire(&p->lock);
    80001b6e:	8526                	mv	a0,s1
    80001b70:	00005097          	auipc	ra,0x5
    80001b74:	caa080e7          	jalr	-854(ra) # 8000681a <acquire>
    if(p->pid == pid){
    80001b78:	589c                	lw	a5,48(s1)
    80001b7a:	01278d63          	beq	a5,s2,80001b94 <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80001b7e:	8526                	mv	a0,s1
    80001b80:	00005097          	auipc	ra,0x5
    80001b84:	d4e080e7          	jalr	-690(ra) # 800068ce <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80001b88:	16848493          	addi	s1,s1,360
    80001b8c:	ff3491e3          	bne	s1,s3,80001b6e <kill+0x20>
  }
  return -1;
    80001b90:	557d                	li	a0,-1
    80001b92:	a829                	j	80001bac <kill+0x5e>
      p->killed = 1;
    80001b94:	4785                	li	a5,1
    80001b96:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    80001b98:	4c98                	lw	a4,24(s1)
    80001b9a:	4789                	li	a5,2
    80001b9c:	00f70f63          	beq	a4,a5,80001bba <kill+0x6c>
      release(&p->lock);
    80001ba0:	8526                	mv	a0,s1
    80001ba2:	00005097          	auipc	ra,0x5
    80001ba6:	d2c080e7          	jalr	-724(ra) # 800068ce <release>
      return 0;
    80001baa:	4501                	li	a0,0
}
    80001bac:	70a2                	ld	ra,40(sp)
    80001bae:	7402                	ld	s0,32(sp)
    80001bb0:	64e2                	ld	s1,24(sp)
    80001bb2:	6942                	ld	s2,16(sp)
    80001bb4:	69a2                	ld	s3,8(sp)
    80001bb6:	6145                	addi	sp,sp,48
    80001bb8:	8082                	ret
        p->state = RUNNABLE;
    80001bba:	478d                	li	a5,3
    80001bbc:	cc9c                	sw	a5,24(s1)
    80001bbe:	b7cd                	j	80001ba0 <kill+0x52>

0000000080001bc0 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80001bc0:	7179                	addi	sp,sp,-48
    80001bc2:	f406                	sd	ra,40(sp)
    80001bc4:	f022                	sd	s0,32(sp)
    80001bc6:	ec26                	sd	s1,24(sp)
    80001bc8:	e84a                	sd	s2,16(sp)
    80001bca:	e44e                	sd	s3,8(sp)
    80001bcc:	e052                	sd	s4,0(sp)
    80001bce:	1800                	addi	s0,sp,48
    80001bd0:	84aa                	mv	s1,a0
    80001bd2:	892e                	mv	s2,a1
    80001bd4:	89b2                	mv	s3,a2
    80001bd6:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001bd8:	fffff097          	auipc	ra,0xfffff
    80001bdc:	588080e7          	jalr	1416(ra) # 80001160 <myproc>
  if(user_dst){
    80001be0:	c08d                	beqz	s1,80001c02 <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    80001be2:	86d2                	mv	a3,s4
    80001be4:	864e                	mv	a2,s3
    80001be6:	85ca                	mv	a1,s2
    80001be8:	6928                	ld	a0,80(a0)
    80001bea:	fffff097          	auipc	ra,0xfffff
    80001bee:	f18080e7          	jalr	-232(ra) # 80000b02 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    80001bf2:	70a2                	ld	ra,40(sp)
    80001bf4:	7402                	ld	s0,32(sp)
    80001bf6:	64e2                	ld	s1,24(sp)
    80001bf8:	6942                	ld	s2,16(sp)
    80001bfa:	69a2                	ld	s3,8(sp)
    80001bfc:	6a02                	ld	s4,0(sp)
    80001bfe:	6145                	addi	sp,sp,48
    80001c00:	8082                	ret
    memmove((char *)dst, src, len);
    80001c02:	000a061b          	sext.w	a2,s4
    80001c06:	85ce                	mv	a1,s3
    80001c08:	854a                	mv	a0,s2
    80001c0a:	ffffe097          	auipc	ra,0xffffe
    80001c0e:	5ce080e7          	jalr	1486(ra) # 800001d8 <memmove>
    return 0;
    80001c12:	8526                	mv	a0,s1
    80001c14:	bff9                	j	80001bf2 <either_copyout+0x32>

0000000080001c16 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80001c16:	7179                	addi	sp,sp,-48
    80001c18:	f406                	sd	ra,40(sp)
    80001c1a:	f022                	sd	s0,32(sp)
    80001c1c:	ec26                	sd	s1,24(sp)
    80001c1e:	e84a                	sd	s2,16(sp)
    80001c20:	e44e                	sd	s3,8(sp)
    80001c22:	e052                	sd	s4,0(sp)
    80001c24:	1800                	addi	s0,sp,48
    80001c26:	892a                	mv	s2,a0
    80001c28:	84ae                	mv	s1,a1
    80001c2a:	89b2                	mv	s3,a2
    80001c2c:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001c2e:	fffff097          	auipc	ra,0xfffff
    80001c32:	532080e7          	jalr	1330(ra) # 80001160 <myproc>
  if(user_src){
    80001c36:	c08d                	beqz	s1,80001c58 <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    80001c38:	86d2                	mv	a3,s4
    80001c3a:	864e                	mv	a2,s3
    80001c3c:	85ca                	mv	a1,s2
    80001c3e:	6928                	ld	a0,80(a0)
    80001c40:	fffff097          	auipc	ra,0xfffff
    80001c44:	f4e080e7          	jalr	-178(ra) # 80000b8e <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80001c48:	70a2                	ld	ra,40(sp)
    80001c4a:	7402                	ld	s0,32(sp)
    80001c4c:	64e2                	ld	s1,24(sp)
    80001c4e:	6942                	ld	s2,16(sp)
    80001c50:	69a2                	ld	s3,8(sp)
    80001c52:	6a02                	ld	s4,0(sp)
    80001c54:	6145                	addi	sp,sp,48
    80001c56:	8082                	ret
    memmove(dst, (char*)src, len);
    80001c58:	000a061b          	sext.w	a2,s4
    80001c5c:	85ce                	mv	a1,s3
    80001c5e:	854a                	mv	a0,s2
    80001c60:	ffffe097          	auipc	ra,0xffffe
    80001c64:	578080e7          	jalr	1400(ra) # 800001d8 <memmove>
    return 0;
    80001c68:	8526                	mv	a0,s1
    80001c6a:	bff9                	j	80001c48 <either_copyin+0x32>

0000000080001c6c <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80001c6c:	715d                	addi	sp,sp,-80
    80001c6e:	e486                	sd	ra,72(sp)
    80001c70:	e0a2                	sd	s0,64(sp)
    80001c72:	fc26                	sd	s1,56(sp)
    80001c74:	f84a                	sd	s2,48(sp)
    80001c76:	f44e                	sd	s3,40(sp)
    80001c78:	f052                	sd	s4,32(sp)
    80001c7a:	ec56                	sd	s5,24(sp)
    80001c7c:	e85a                	sd	s6,16(sp)
    80001c7e:	e45e                	sd	s7,8(sp)
    80001c80:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80001c82:	00006517          	auipc	a0,0x6
    80001c86:	3c650513          	addi	a0,a0,966 # 80008048 <etext+0x48>
    80001c8a:	00004097          	auipc	ra,0x4
    80001c8e:	690080e7          	jalr	1680(ra) # 8000631a <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001c92:	00008497          	auipc	s1,0x8
    80001c96:	94648493          	addi	s1,s1,-1722 # 800095d8 <proc+0x158>
    80001c9a:	0000d917          	auipc	s2,0xd
    80001c9e:	33e90913          	addi	s2,s2,830 # 8000efd8 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001ca2:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80001ca4:	00006997          	auipc	s3,0x6
    80001ca8:	5f498993          	addi	s3,s3,1524 # 80008298 <etext+0x298>
    printf("%d %s %s", p->pid, state, p->name);
    80001cac:	00006a97          	auipc	s5,0x6
    80001cb0:	5f4a8a93          	addi	s5,s5,1524 # 800082a0 <etext+0x2a0>
    printf("\n");
    80001cb4:	00006a17          	auipc	s4,0x6
    80001cb8:	394a0a13          	addi	s4,s4,916 # 80008048 <etext+0x48>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001cbc:	00006b97          	auipc	s7,0x6
    80001cc0:	61cb8b93          	addi	s7,s7,1564 # 800082d8 <states.1805>
    80001cc4:	a00d                	j	80001ce6 <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    80001cc6:	ed86a583          	lw	a1,-296(a3)
    80001cca:	8556                	mv	a0,s5
    80001ccc:	00004097          	auipc	ra,0x4
    80001cd0:	64e080e7          	jalr	1614(ra) # 8000631a <printf>
    printf("\n");
    80001cd4:	8552                	mv	a0,s4
    80001cd6:	00004097          	auipc	ra,0x4
    80001cda:	644080e7          	jalr	1604(ra) # 8000631a <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001cde:	16848493          	addi	s1,s1,360
    80001ce2:	03248163          	beq	s1,s2,80001d04 <procdump+0x98>
    if(p->state == UNUSED)
    80001ce6:	86a6                	mv	a3,s1
    80001ce8:	ec04a783          	lw	a5,-320(s1)
    80001cec:	dbed                	beqz	a5,80001cde <procdump+0x72>
      state = "???";
    80001cee:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001cf0:	fcfb6be3          	bltu	s6,a5,80001cc6 <procdump+0x5a>
    80001cf4:	1782                	slli	a5,a5,0x20
    80001cf6:	9381                	srli	a5,a5,0x20
    80001cf8:	078e                	slli	a5,a5,0x3
    80001cfa:	97de                	add	a5,a5,s7
    80001cfc:	6390                	ld	a2,0(a5)
    80001cfe:	f661                	bnez	a2,80001cc6 <procdump+0x5a>
      state = "???";
    80001d00:	864e                	mv	a2,s3
    80001d02:	b7d1                	j	80001cc6 <procdump+0x5a>
  }
}
    80001d04:	60a6                	ld	ra,72(sp)
    80001d06:	6406                	ld	s0,64(sp)
    80001d08:	74e2                	ld	s1,56(sp)
    80001d0a:	7942                	ld	s2,48(sp)
    80001d0c:	79a2                	ld	s3,40(sp)
    80001d0e:	7a02                	ld	s4,32(sp)
    80001d10:	6ae2                	ld	s5,24(sp)
    80001d12:	6b42                	ld	s6,16(sp)
    80001d14:	6ba2                	ld	s7,8(sp)
    80001d16:	6161                	addi	sp,sp,80
    80001d18:	8082                	ret

0000000080001d1a <swtch>:
    80001d1a:	00153023          	sd	ra,0(a0)
    80001d1e:	00253423          	sd	sp,8(a0)
    80001d22:	e900                	sd	s0,16(a0)
    80001d24:	ed04                	sd	s1,24(a0)
    80001d26:	03253023          	sd	s2,32(a0)
    80001d2a:	03353423          	sd	s3,40(a0)
    80001d2e:	03453823          	sd	s4,48(a0)
    80001d32:	03553c23          	sd	s5,56(a0)
    80001d36:	05653023          	sd	s6,64(a0)
    80001d3a:	05753423          	sd	s7,72(a0)
    80001d3e:	05853823          	sd	s8,80(a0)
    80001d42:	05953c23          	sd	s9,88(a0)
    80001d46:	07a53023          	sd	s10,96(a0)
    80001d4a:	07b53423          	sd	s11,104(a0)
    80001d4e:	0005b083          	ld	ra,0(a1)
    80001d52:	0085b103          	ld	sp,8(a1)
    80001d56:	6980                	ld	s0,16(a1)
    80001d58:	6d84                	ld	s1,24(a1)
    80001d5a:	0205b903          	ld	s2,32(a1)
    80001d5e:	0285b983          	ld	s3,40(a1)
    80001d62:	0305ba03          	ld	s4,48(a1)
    80001d66:	0385ba83          	ld	s5,56(a1)
    80001d6a:	0405bb03          	ld	s6,64(a1)
    80001d6e:	0485bb83          	ld	s7,72(a1)
    80001d72:	0505bc03          	ld	s8,80(a1)
    80001d76:	0585bc83          	ld	s9,88(a1)
    80001d7a:	0605bd03          	ld	s10,96(a1)
    80001d7e:	0685bd83          	ld	s11,104(a1)
    80001d82:	8082                	ret

0000000080001d84 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001d84:	1141                	addi	sp,sp,-16
    80001d86:	e406                	sd	ra,8(sp)
    80001d88:	e022                	sd	s0,0(sp)
    80001d8a:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001d8c:	00006597          	auipc	a1,0x6
    80001d90:	57c58593          	addi	a1,a1,1404 # 80008308 <states.1805+0x30>
    80001d94:	0000d517          	auipc	a0,0xd
    80001d98:	0ec50513          	addi	a0,a0,236 # 8000ee80 <tickslock>
    80001d9c:	00005097          	auipc	ra,0x5
    80001da0:	9ee080e7          	jalr	-1554(ra) # 8000678a <initlock>
}
    80001da4:	60a2                	ld	ra,8(sp)
    80001da6:	6402                	ld	s0,0(sp)
    80001da8:	0141                	addi	sp,sp,16
    80001daa:	8082                	ret

0000000080001dac <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001dac:	1141                	addi	sp,sp,-16
    80001dae:	e422                	sd	s0,8(sp)
    80001db0:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001db2:	00003797          	auipc	a5,0x3
    80001db6:	6ee78793          	addi	a5,a5,1774 # 800054a0 <kernelvec>
    80001dba:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001dbe:	6422                	ld	s0,8(sp)
    80001dc0:	0141                	addi	sp,sp,16
    80001dc2:	8082                	ret

0000000080001dc4 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80001dc4:	1141                	addi	sp,sp,-16
    80001dc6:	e406                	sd	ra,8(sp)
    80001dc8:	e022                	sd	s0,0(sp)
    80001dca:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80001dcc:	fffff097          	auipc	ra,0xfffff
    80001dd0:	394080e7          	jalr	916(ra) # 80001160 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001dd4:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001dd8:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001dda:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    80001dde:	00005617          	auipc	a2,0x5
    80001de2:	22260613          	addi	a2,a2,546 # 80007000 <_trampoline>
    80001de6:	00005697          	auipc	a3,0x5
    80001dea:	21a68693          	addi	a3,a3,538 # 80007000 <_trampoline>
    80001dee:	8e91                	sub	a3,a3,a2
    80001df0:	040007b7          	lui	a5,0x4000
    80001df4:	17fd                	addi	a5,a5,-1
    80001df6:	07b2                	slli	a5,a5,0xc
    80001df8:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001dfa:	10569073          	csrw	stvec,a3

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80001dfe:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80001e00:	180026f3          	csrr	a3,satp
    80001e04:	e314                	sd	a3,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80001e06:	6d38                	ld	a4,88(a0)
    80001e08:	6134                	ld	a3,64(a0)
    80001e0a:	6585                	lui	a1,0x1
    80001e0c:	96ae                	add	a3,a3,a1
    80001e0e:	e714                	sd	a3,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80001e10:	6d38                	ld	a4,88(a0)
    80001e12:	00000697          	auipc	a3,0x0
    80001e16:	13868693          	addi	a3,a3,312 # 80001f4a <usertrap>
    80001e1a:	eb14                	sd	a3,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80001e1c:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80001e1e:	8692                	mv	a3,tp
    80001e20:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001e22:	100026f3          	csrr	a3,sstatus

  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80001e26:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80001e2a:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001e2e:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001e32:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001e34:	6f18                	ld	a4,24(a4)
    80001e36:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80001e3a:	692c                	ld	a1,80(a0)
    80001e3c:	81b1                	srli	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    80001e3e:	00005717          	auipc	a4,0x5
    80001e42:	25270713          	addi	a4,a4,594 # 80007090 <userret>
    80001e46:	8f11                	sub	a4,a4,a2
    80001e48:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80001e4a:	577d                	li	a4,-1
    80001e4c:	177e                	slli	a4,a4,0x3f
    80001e4e:	8dd9                	or	a1,a1,a4
    80001e50:	02000537          	lui	a0,0x2000
    80001e54:	157d                	addi	a0,a0,-1
    80001e56:	0536                	slli	a0,a0,0xd
    80001e58:	9782                	jalr	a5
}
    80001e5a:	60a2                	ld	ra,8(sp)
    80001e5c:	6402                	ld	s0,0(sp)
    80001e5e:	0141                	addi	sp,sp,16
    80001e60:	8082                	ret

0000000080001e62 <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80001e62:	1101                	addi	sp,sp,-32
    80001e64:	ec06                	sd	ra,24(sp)
    80001e66:	e822                	sd	s0,16(sp)
    80001e68:	e426                	sd	s1,8(sp)
    80001e6a:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    80001e6c:	0000d497          	auipc	s1,0xd
    80001e70:	01448493          	addi	s1,s1,20 # 8000ee80 <tickslock>
    80001e74:	8526                	mv	a0,s1
    80001e76:	00005097          	auipc	ra,0x5
    80001e7a:	9a4080e7          	jalr	-1628(ra) # 8000681a <acquire>
  ticks++;
    80001e7e:	00007517          	auipc	a0,0x7
    80001e82:	19a50513          	addi	a0,a0,410 # 80009018 <ticks>
    80001e86:	411c                	lw	a5,0(a0)
    80001e88:	2785                	addiw	a5,a5,1
    80001e8a:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80001e8c:	00000097          	auipc	ra,0x0
    80001e90:	b1c080e7          	jalr	-1252(ra) # 800019a8 <wakeup>
  release(&tickslock);
    80001e94:	8526                	mv	a0,s1
    80001e96:	00005097          	auipc	ra,0x5
    80001e9a:	a38080e7          	jalr	-1480(ra) # 800068ce <release>
}
    80001e9e:	60e2                	ld	ra,24(sp)
    80001ea0:	6442                	ld	s0,16(sp)
    80001ea2:	64a2                	ld	s1,8(sp)
    80001ea4:	6105                	addi	sp,sp,32
    80001ea6:	8082                	ret

0000000080001ea8 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80001ea8:	1101                	addi	sp,sp,-32
    80001eaa:	ec06                	sd	ra,24(sp)
    80001eac:	e822                	sd	s0,16(sp)
    80001eae:	e426                	sd	s1,8(sp)
    80001eb0:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001eb2:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    80001eb6:	00074d63          	bltz	a4,80001ed0 <devintr+0x28>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000001L){
    80001eba:	57fd                	li	a5,-1
    80001ebc:	17fe                	slli	a5,a5,0x3f
    80001ebe:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80001ec0:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80001ec2:	06f70363          	beq	a4,a5,80001f28 <devintr+0x80>
  }
}
    80001ec6:	60e2                	ld	ra,24(sp)
    80001ec8:	6442                	ld	s0,16(sp)
    80001eca:	64a2                	ld	s1,8(sp)
    80001ecc:	6105                	addi	sp,sp,32
    80001ece:	8082                	ret
     (scause & 0xff) == 9){
    80001ed0:	0ff77793          	andi	a5,a4,255
  if((scause & 0x8000000000000000L) &&
    80001ed4:	46a5                	li	a3,9
    80001ed6:	fed792e3          	bne	a5,a3,80001eba <devintr+0x12>
    int irq = plic_claim();
    80001eda:	00003097          	auipc	ra,0x3
    80001ede:	6ce080e7          	jalr	1742(ra) # 800055a8 <plic_claim>
    80001ee2:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80001ee4:	47a9                	li	a5,10
    80001ee6:	02f50763          	beq	a0,a5,80001f14 <devintr+0x6c>
    } else if(irq == VIRTIO0_IRQ){
    80001eea:	4785                	li	a5,1
    80001eec:	02f50963          	beq	a0,a5,80001f1e <devintr+0x76>
    return 1;
    80001ef0:	4505                	li	a0,1
    } else if(irq){
    80001ef2:	d8f1                	beqz	s1,80001ec6 <devintr+0x1e>
      printf("unexpected interrupt irq=%d\n", irq);
    80001ef4:	85a6                	mv	a1,s1
    80001ef6:	00006517          	auipc	a0,0x6
    80001efa:	41a50513          	addi	a0,a0,1050 # 80008310 <states.1805+0x38>
    80001efe:	00004097          	auipc	ra,0x4
    80001f02:	41c080e7          	jalr	1052(ra) # 8000631a <printf>
      plic_complete(irq);
    80001f06:	8526                	mv	a0,s1
    80001f08:	00003097          	auipc	ra,0x3
    80001f0c:	6c4080e7          	jalr	1732(ra) # 800055cc <plic_complete>
    return 1;
    80001f10:	4505                	li	a0,1
    80001f12:	bf55                	j	80001ec6 <devintr+0x1e>
      uartintr();
    80001f14:	00005097          	auipc	ra,0x5
    80001f18:	826080e7          	jalr	-2010(ra) # 8000673a <uartintr>
    80001f1c:	b7ed                	j	80001f06 <devintr+0x5e>
      virtio_disk_intr();
    80001f1e:	00004097          	auipc	ra,0x4
    80001f22:	b8e080e7          	jalr	-1138(ra) # 80005aac <virtio_disk_intr>
    80001f26:	b7c5                	j	80001f06 <devintr+0x5e>
    if(cpuid() == 0){
    80001f28:	fffff097          	auipc	ra,0xfffff
    80001f2c:	20c080e7          	jalr	524(ra) # 80001134 <cpuid>
    80001f30:	c901                	beqz	a0,80001f40 <devintr+0x98>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80001f32:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80001f36:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80001f38:	14479073          	csrw	sip,a5
    return 2;
    80001f3c:	4509                	li	a0,2
    80001f3e:	b761                	j	80001ec6 <devintr+0x1e>
      clockintr();
    80001f40:	00000097          	auipc	ra,0x0
    80001f44:	f22080e7          	jalr	-222(ra) # 80001e62 <clockintr>
    80001f48:	b7ed                	j	80001f32 <devintr+0x8a>

0000000080001f4a <usertrap>:
{
    80001f4a:	1101                	addi	sp,sp,-32
    80001f4c:	ec06                	sd	ra,24(sp)
    80001f4e:	e822                	sd	s0,16(sp)
    80001f50:	e426                	sd	s1,8(sp)
    80001f52:	e04a                	sd	s2,0(sp)
    80001f54:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001f56:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80001f5a:	1007f793          	andi	a5,a5,256
    80001f5e:	ebb9                	bnez	a5,80001fb4 <usertrap+0x6a>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001f60:	00003797          	auipc	a5,0x3
    80001f64:	54078793          	addi	a5,a5,1344 # 800054a0 <kernelvec>
    80001f68:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001f6c:	fffff097          	auipc	ra,0xfffff
    80001f70:	1f4080e7          	jalr	500(ra) # 80001160 <myproc>
    80001f74:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001f76:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001f78:	14102773          	csrr	a4,sepc
    80001f7c:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001f7e:	142027f3          	csrr	a5,scause
  if (scause == 13 || scause == 15) { // Page fault load or store
    80001f82:	ffd7f693          	andi	a3,a5,-3
    80001f86:	4735                	li	a4,13
    80001f88:	02e68e63          	beq	a3,a4,80001fc4 <usertrap+0x7a>
  else if(scause == 8) {
    80001f8c:	4721                	li	a4,8
    80001f8e:	06e79363          	bne	a5,a4,80001ff4 <usertrap+0xaa>
    if(p->killed)
    80001f92:	551c                	lw	a5,40(a0)
    80001f94:	ebb1                	bnez	a5,80001fe8 <usertrap+0x9e>
    p->trapframe->epc += 4;
    80001f96:	6cb8                	ld	a4,88(s1)
    80001f98:	6f1c                	ld	a5,24(a4)
    80001f9a:	0791                	addi	a5,a5,4
    80001f9c:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001f9e:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001fa2:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001fa6:	10079073          	csrw	sstatus,a5
    syscall();
    80001faa:	00000097          	auipc	ra,0x0
    80001fae:	2ee080e7          	jalr	750(ra) # 80002298 <syscall>
    80001fb2:	a839                	j	80001fd0 <usertrap+0x86>
    panic("usertrap: not from user mode");
    80001fb4:	00006517          	auipc	a0,0x6
    80001fb8:	37c50513          	addi	a0,a0,892 # 80008330 <states.1805+0x58>
    80001fbc:	00004097          	auipc	ra,0x4
    80001fc0:	314080e7          	jalr	788(ra) # 800062d0 <panic>
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001fc4:	14302573          	csrr	a0,stval
      handle_pgfault(va); // Handle the page fault
    80001fc8:	00004097          	auipc	ra,0x4
    80001fcc:	c0e080e7          	jalr	-1010(ra) # 80005bd6 <handle_pgfault>
  if(p->killed)
    80001fd0:	549c                	lw	a5,40(s1)
    80001fd2:	e7a5                	bnez	a5,8000203a <usertrap+0xf0>
  usertrapret();
    80001fd4:	00000097          	auipc	ra,0x0
    80001fd8:	df0080e7          	jalr	-528(ra) # 80001dc4 <usertrapret>
}
    80001fdc:	60e2                	ld	ra,24(sp)
    80001fde:	6442                	ld	s0,16(sp)
    80001fe0:	64a2                	ld	s1,8(sp)
    80001fe2:	6902                	ld	s2,0(sp)
    80001fe4:	6105                	addi	sp,sp,32
    80001fe6:	8082                	ret
      exit(-1);
    80001fe8:	557d                	li	a0,-1
    80001fea:	00000097          	auipc	ra,0x0
    80001fee:	a8e080e7          	jalr	-1394(ra) # 80001a78 <exit>
    80001ff2:	b755                	j	80001f96 <usertrap+0x4c>
  } else if ((which_dev = devintr()) != 0) {
    80001ff4:	00000097          	auipc	ra,0x0
    80001ff8:	eb4080e7          	jalr	-332(ra) # 80001ea8 <devintr>
    80001ffc:	892a                	mv	s2,a0
    80001ffe:	c501                	beqz	a0,80002006 <usertrap+0xbc>
  if(p->killed)
    80002000:	549c                	lw	a5,40(s1)
    80002002:	c3b1                	beqz	a5,80002046 <usertrap+0xfc>
    80002004:	a825                	j	8000203c <usertrap+0xf2>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002006:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    8000200a:	5890                	lw	a2,48(s1)
    8000200c:	00006517          	auipc	a0,0x6
    80002010:	34450513          	addi	a0,a0,836 # 80008350 <states.1805+0x78>
    80002014:	00004097          	auipc	ra,0x4
    80002018:	306080e7          	jalr	774(ra) # 8000631a <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    8000201c:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002020:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002024:	00006517          	auipc	a0,0x6
    80002028:	35c50513          	addi	a0,a0,860 # 80008380 <states.1805+0xa8>
    8000202c:	00004097          	auipc	ra,0x4
    80002030:	2ee080e7          	jalr	750(ra) # 8000631a <printf>
    p->killed = 1;
    80002034:	4785                	li	a5,1
    80002036:	d49c                	sw	a5,40(s1)
  if(p->killed)
    80002038:	a011                	j	8000203c <usertrap+0xf2>
    8000203a:	4901                	li	s2,0
    exit(-1);
    8000203c:	557d                	li	a0,-1
    8000203e:	00000097          	auipc	ra,0x0
    80002042:	a3a080e7          	jalr	-1478(ra) # 80001a78 <exit>
  if(which_dev == 2)
    80002046:	4789                	li	a5,2
    80002048:	f8f916e3          	bne	s2,a5,80001fd4 <usertrap+0x8a>
    yield();
    8000204c:	fffff097          	auipc	ra,0xfffff
    80002050:	794080e7          	jalr	1940(ra) # 800017e0 <yield>
    80002054:	b741                	j	80001fd4 <usertrap+0x8a>

0000000080002056 <kerneltrap>:
{
    80002056:	7179                	addi	sp,sp,-48
    80002058:	f406                	sd	ra,40(sp)
    8000205a:	f022                	sd	s0,32(sp)
    8000205c:	ec26                	sd	s1,24(sp)
    8000205e:	e84a                	sd	s2,16(sp)
    80002060:	e44e                	sd	s3,8(sp)
    80002062:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002064:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002068:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    8000206c:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80002070:	1004f793          	andi	a5,s1,256
    80002074:	cb85                	beqz	a5,800020a4 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002076:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8000207a:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    8000207c:	ef85                	bnez	a5,800020b4 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    8000207e:	00000097          	auipc	ra,0x0
    80002082:	e2a080e7          	jalr	-470(ra) # 80001ea8 <devintr>
    80002086:	cd1d                	beqz	a0,800020c4 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002088:	4789                	li	a5,2
    8000208a:	06f50a63          	beq	a0,a5,800020fe <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    8000208e:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002092:	10049073          	csrw	sstatus,s1
}
    80002096:	70a2                	ld	ra,40(sp)
    80002098:	7402                	ld	s0,32(sp)
    8000209a:	64e2                	ld	s1,24(sp)
    8000209c:	6942                	ld	s2,16(sp)
    8000209e:	69a2                	ld	s3,8(sp)
    800020a0:	6145                	addi	sp,sp,48
    800020a2:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    800020a4:	00006517          	auipc	a0,0x6
    800020a8:	2fc50513          	addi	a0,a0,764 # 800083a0 <states.1805+0xc8>
    800020ac:	00004097          	auipc	ra,0x4
    800020b0:	224080e7          	jalr	548(ra) # 800062d0 <panic>
    panic("kerneltrap: interrupts enabled");
    800020b4:	00006517          	auipc	a0,0x6
    800020b8:	31450513          	addi	a0,a0,788 # 800083c8 <states.1805+0xf0>
    800020bc:	00004097          	auipc	ra,0x4
    800020c0:	214080e7          	jalr	532(ra) # 800062d0 <panic>
    printf("scause %p\n", scause);
    800020c4:	85ce                	mv	a1,s3
    800020c6:	00006517          	auipc	a0,0x6
    800020ca:	32250513          	addi	a0,a0,802 # 800083e8 <states.1805+0x110>
    800020ce:	00004097          	auipc	ra,0x4
    800020d2:	24c080e7          	jalr	588(ra) # 8000631a <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800020d6:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    800020da:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    800020de:	00006517          	auipc	a0,0x6
    800020e2:	31a50513          	addi	a0,a0,794 # 800083f8 <states.1805+0x120>
    800020e6:	00004097          	auipc	ra,0x4
    800020ea:	234080e7          	jalr	564(ra) # 8000631a <printf>
    panic("kerneltrap");
    800020ee:	00006517          	auipc	a0,0x6
    800020f2:	32250513          	addi	a0,a0,802 # 80008410 <states.1805+0x138>
    800020f6:	00004097          	auipc	ra,0x4
    800020fa:	1da080e7          	jalr	474(ra) # 800062d0 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    800020fe:	fffff097          	auipc	ra,0xfffff
    80002102:	062080e7          	jalr	98(ra) # 80001160 <myproc>
    80002106:	d541                	beqz	a0,8000208e <kerneltrap+0x38>
    80002108:	fffff097          	auipc	ra,0xfffff
    8000210c:	058080e7          	jalr	88(ra) # 80001160 <myproc>
    80002110:	4d18                	lw	a4,24(a0)
    80002112:	4791                	li	a5,4
    80002114:	f6f71de3          	bne	a4,a5,8000208e <kerneltrap+0x38>
    yield();
    80002118:	fffff097          	auipc	ra,0xfffff
    8000211c:	6c8080e7          	jalr	1736(ra) # 800017e0 <yield>
    80002120:	b7bd                	j	8000208e <kerneltrap+0x38>

0000000080002122 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80002122:	1101                	addi	sp,sp,-32
    80002124:	ec06                	sd	ra,24(sp)
    80002126:	e822                	sd	s0,16(sp)
    80002128:	e426                	sd	s1,8(sp)
    8000212a:	1000                	addi	s0,sp,32
    8000212c:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    8000212e:	fffff097          	auipc	ra,0xfffff
    80002132:	032080e7          	jalr	50(ra) # 80001160 <myproc>
  switch (n) {
    80002136:	4795                	li	a5,5
    80002138:	0497e163          	bltu	a5,s1,8000217a <argraw+0x58>
    8000213c:	048a                	slli	s1,s1,0x2
    8000213e:	00006717          	auipc	a4,0x6
    80002142:	30a70713          	addi	a4,a4,778 # 80008448 <states.1805+0x170>
    80002146:	94ba                	add	s1,s1,a4
    80002148:	409c                	lw	a5,0(s1)
    8000214a:	97ba                	add	a5,a5,a4
    8000214c:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    8000214e:	6d3c                	ld	a5,88(a0)
    80002150:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80002152:	60e2                	ld	ra,24(sp)
    80002154:	6442                	ld	s0,16(sp)
    80002156:	64a2                	ld	s1,8(sp)
    80002158:	6105                	addi	sp,sp,32
    8000215a:	8082                	ret
    return p->trapframe->a1;
    8000215c:	6d3c                	ld	a5,88(a0)
    8000215e:	7fa8                	ld	a0,120(a5)
    80002160:	bfcd                	j	80002152 <argraw+0x30>
    return p->trapframe->a2;
    80002162:	6d3c                	ld	a5,88(a0)
    80002164:	63c8                	ld	a0,128(a5)
    80002166:	b7f5                	j	80002152 <argraw+0x30>
    return p->trapframe->a3;
    80002168:	6d3c                	ld	a5,88(a0)
    8000216a:	67c8                	ld	a0,136(a5)
    8000216c:	b7dd                	j	80002152 <argraw+0x30>
    return p->trapframe->a4;
    8000216e:	6d3c                	ld	a5,88(a0)
    80002170:	6bc8                	ld	a0,144(a5)
    80002172:	b7c5                	j	80002152 <argraw+0x30>
    return p->trapframe->a5;
    80002174:	6d3c                	ld	a5,88(a0)
    80002176:	6fc8                	ld	a0,152(a5)
    80002178:	bfe9                	j	80002152 <argraw+0x30>
  panic("argraw");
    8000217a:	00006517          	auipc	a0,0x6
    8000217e:	2a650513          	addi	a0,a0,678 # 80008420 <states.1805+0x148>
    80002182:	00004097          	auipc	ra,0x4
    80002186:	14e080e7          	jalr	334(ra) # 800062d0 <panic>

000000008000218a <fetchaddr>:
{
    8000218a:	1101                	addi	sp,sp,-32
    8000218c:	ec06                	sd	ra,24(sp)
    8000218e:	e822                	sd	s0,16(sp)
    80002190:	e426                	sd	s1,8(sp)
    80002192:	e04a                	sd	s2,0(sp)
    80002194:	1000                	addi	s0,sp,32
    80002196:	84aa                	mv	s1,a0
    80002198:	892e                	mv	s2,a1
  struct proc *p = myproc();
    8000219a:	fffff097          	auipc	ra,0xfffff
    8000219e:	fc6080e7          	jalr	-58(ra) # 80001160 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    800021a2:	653c                	ld	a5,72(a0)
    800021a4:	02f4f863          	bgeu	s1,a5,800021d4 <fetchaddr+0x4a>
    800021a8:	00848713          	addi	a4,s1,8
    800021ac:	02e7e663          	bltu	a5,a4,800021d8 <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    800021b0:	46a1                	li	a3,8
    800021b2:	8626                	mv	a2,s1
    800021b4:	85ca                	mv	a1,s2
    800021b6:	6928                	ld	a0,80(a0)
    800021b8:	fffff097          	auipc	ra,0xfffff
    800021bc:	9d6080e7          	jalr	-1578(ra) # 80000b8e <copyin>
    800021c0:	00a03533          	snez	a0,a0
    800021c4:	40a00533          	neg	a0,a0
}
    800021c8:	60e2                	ld	ra,24(sp)
    800021ca:	6442                	ld	s0,16(sp)
    800021cc:	64a2                	ld	s1,8(sp)
    800021ce:	6902                	ld	s2,0(sp)
    800021d0:	6105                	addi	sp,sp,32
    800021d2:	8082                	ret
    return -1;
    800021d4:	557d                	li	a0,-1
    800021d6:	bfcd                	j	800021c8 <fetchaddr+0x3e>
    800021d8:	557d                	li	a0,-1
    800021da:	b7fd                	j	800021c8 <fetchaddr+0x3e>

00000000800021dc <fetchstr>:
{
    800021dc:	7179                	addi	sp,sp,-48
    800021de:	f406                	sd	ra,40(sp)
    800021e0:	f022                	sd	s0,32(sp)
    800021e2:	ec26                	sd	s1,24(sp)
    800021e4:	e84a                	sd	s2,16(sp)
    800021e6:	e44e                	sd	s3,8(sp)
    800021e8:	1800                	addi	s0,sp,48
    800021ea:	892a                	mv	s2,a0
    800021ec:	84ae                	mv	s1,a1
    800021ee:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    800021f0:	fffff097          	auipc	ra,0xfffff
    800021f4:	f70080e7          	jalr	-144(ra) # 80001160 <myproc>
  int err = copyinstr(p->pagetable, buf, addr, max);
    800021f8:	86ce                	mv	a3,s3
    800021fa:	864a                	mv	a2,s2
    800021fc:	85a6                	mv	a1,s1
    800021fe:	6928                	ld	a0,80(a0)
    80002200:	fffff097          	auipc	ra,0xfffff
    80002204:	a1a080e7          	jalr	-1510(ra) # 80000c1a <copyinstr>
  if(err < 0)
    80002208:	00054763          	bltz	a0,80002216 <fetchstr+0x3a>
  return strlen(buf);
    8000220c:	8526                	mv	a0,s1
    8000220e:	ffffe097          	auipc	ra,0xffffe
    80002212:	0ee080e7          	jalr	238(ra) # 800002fc <strlen>
}
    80002216:	70a2                	ld	ra,40(sp)
    80002218:	7402                	ld	s0,32(sp)
    8000221a:	64e2                	ld	s1,24(sp)
    8000221c:	6942                	ld	s2,16(sp)
    8000221e:	69a2                	ld	s3,8(sp)
    80002220:	6145                	addi	sp,sp,48
    80002222:	8082                	ret

0000000080002224 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    80002224:	1101                	addi	sp,sp,-32
    80002226:	ec06                	sd	ra,24(sp)
    80002228:	e822                	sd	s0,16(sp)
    8000222a:	e426                	sd	s1,8(sp)
    8000222c:	1000                	addi	s0,sp,32
    8000222e:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002230:	00000097          	auipc	ra,0x0
    80002234:	ef2080e7          	jalr	-270(ra) # 80002122 <argraw>
    80002238:	c088                	sw	a0,0(s1)
  return 0;
}
    8000223a:	4501                	li	a0,0
    8000223c:	60e2                	ld	ra,24(sp)
    8000223e:	6442                	ld	s0,16(sp)
    80002240:	64a2                	ld	s1,8(sp)
    80002242:	6105                	addi	sp,sp,32
    80002244:	8082                	ret

0000000080002246 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    80002246:	1101                	addi	sp,sp,-32
    80002248:	ec06                	sd	ra,24(sp)
    8000224a:	e822                	sd	s0,16(sp)
    8000224c:	e426                	sd	s1,8(sp)
    8000224e:	1000                	addi	s0,sp,32
    80002250:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002252:	00000097          	auipc	ra,0x0
    80002256:	ed0080e7          	jalr	-304(ra) # 80002122 <argraw>
    8000225a:	e088                	sd	a0,0(s1)
  return 0;
}
    8000225c:	4501                	li	a0,0
    8000225e:	60e2                	ld	ra,24(sp)
    80002260:	6442                	ld	s0,16(sp)
    80002262:	64a2                	ld	s1,8(sp)
    80002264:	6105                	addi	sp,sp,32
    80002266:	8082                	ret

0000000080002268 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80002268:	1101                	addi	sp,sp,-32
    8000226a:	ec06                	sd	ra,24(sp)
    8000226c:	e822                	sd	s0,16(sp)
    8000226e:	e426                	sd	s1,8(sp)
    80002270:	e04a                	sd	s2,0(sp)
    80002272:	1000                	addi	s0,sp,32
    80002274:	84ae                	mv	s1,a1
    80002276:	8932                	mv	s2,a2
  *ip = argraw(n);
    80002278:	00000097          	auipc	ra,0x0
    8000227c:	eaa080e7          	jalr	-342(ra) # 80002122 <argraw>
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    return -1;
  return fetchstr(addr, buf, max);
    80002280:	864a                	mv	a2,s2
    80002282:	85a6                	mv	a1,s1
    80002284:	00000097          	auipc	ra,0x0
    80002288:	f58080e7          	jalr	-168(ra) # 800021dc <fetchstr>
}
    8000228c:	60e2                	ld	ra,24(sp)
    8000228e:	6442                	ld	s0,16(sp)
    80002290:	64a2                	ld	s1,8(sp)
    80002292:	6902                	ld	s2,0(sp)
    80002294:	6105                	addi	sp,sp,32
    80002296:	8082                	ret

0000000080002298 <syscall>:



void
syscall(void)
{
    80002298:	1101                	addi	sp,sp,-32
    8000229a:	ec06                	sd	ra,24(sp)
    8000229c:	e822                	sd	s0,16(sp)
    8000229e:	e426                	sd	s1,8(sp)
    800022a0:	e04a                	sd	s2,0(sp)
    800022a2:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    800022a4:	fffff097          	auipc	ra,0xfffff
    800022a8:	ebc080e7          	jalr	-324(ra) # 80001160 <myproc>
    800022ac:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    800022ae:	05853903          	ld	s2,88(a0)
    800022b2:	0a893783          	ld	a5,168(s2)
    800022b6:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    800022ba:	37fd                	addiw	a5,a5,-1
    800022bc:	02000713          	li	a4,32
    800022c0:	00f76f63          	bltu	a4,a5,800022de <syscall+0x46>
    800022c4:	00369713          	slli	a4,a3,0x3
    800022c8:	00006797          	auipc	a5,0x6
    800022cc:	19878793          	addi	a5,a5,408 # 80008460 <syscalls>
    800022d0:	97ba                	add	a5,a5,a4
    800022d2:	639c                	ld	a5,0(a5)
    800022d4:	c789                	beqz	a5,800022de <syscall+0x46>
    p->trapframe->a0 = syscalls[num]();
    800022d6:	9782                	jalr	a5
    800022d8:	06a93823          	sd	a0,112(s2)
    800022dc:	a839                	j	800022fa <syscall+0x62>
  } else {
    printf("%d %s: unknown sys call %d\n",
    800022de:	15848613          	addi	a2,s1,344
    800022e2:	588c                	lw	a1,48(s1)
    800022e4:	00006517          	auipc	a0,0x6
    800022e8:	14450513          	addi	a0,a0,324 # 80008428 <states.1805+0x150>
    800022ec:	00004097          	auipc	ra,0x4
    800022f0:	02e080e7          	jalr	46(ra) # 8000631a <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    800022f4:	6cbc                	ld	a5,88(s1)
    800022f6:	577d                	li	a4,-1
    800022f8:	fbb8                	sd	a4,112(a5)
  }
}
    800022fa:	60e2                	ld	ra,24(sp)
    800022fc:	6442                	ld	s0,16(sp)
    800022fe:	64a2                	ld	s1,8(sp)
    80002300:	6902                	ld	s2,0(sp)
    80002302:	6105                	addi	sp,sp,32
    80002304:	8082                	ret

0000000080002306 <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    80002306:	1101                	addi	sp,sp,-32
    80002308:	ec06                	sd	ra,24(sp)
    8000230a:	e822                	sd	s0,16(sp)
    8000230c:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    8000230e:	fec40593          	addi	a1,s0,-20
    80002312:	4501                	li	a0,0
    80002314:	00000097          	auipc	ra,0x0
    80002318:	f10080e7          	jalr	-240(ra) # 80002224 <argint>
    return -1;
    8000231c:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    8000231e:	00054963          	bltz	a0,80002330 <sys_exit+0x2a>
  exit(n);
    80002322:	fec42503          	lw	a0,-20(s0)
    80002326:	fffff097          	auipc	ra,0xfffff
    8000232a:	752080e7          	jalr	1874(ra) # 80001a78 <exit>
  return 0;  // not reached
    8000232e:	4781                	li	a5,0
}
    80002330:	853e                	mv	a0,a5
    80002332:	60e2                	ld	ra,24(sp)
    80002334:	6442                	ld	s0,16(sp)
    80002336:	6105                	addi	sp,sp,32
    80002338:	8082                	ret

000000008000233a <sys_getpid>:

uint64
sys_getpid(void)
{
    8000233a:	1141                	addi	sp,sp,-16
    8000233c:	e406                	sd	ra,8(sp)
    8000233e:	e022                	sd	s0,0(sp)
    80002340:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80002342:	fffff097          	auipc	ra,0xfffff
    80002346:	e1e080e7          	jalr	-482(ra) # 80001160 <myproc>
}
    8000234a:	5908                	lw	a0,48(a0)
    8000234c:	60a2                	ld	ra,8(sp)
    8000234e:	6402                	ld	s0,0(sp)
    80002350:	0141                	addi	sp,sp,16
    80002352:	8082                	ret

0000000080002354 <sys_fork>:

uint64
sys_fork(void)
{
    80002354:	1141                	addi	sp,sp,-16
    80002356:	e406                	sd	ra,8(sp)
    80002358:	e022                	sd	s0,0(sp)
    8000235a:	0800                	addi	s0,sp,16
  return fork();
    8000235c:	fffff097          	auipc	ra,0xfffff
    80002360:	1d2080e7          	jalr	466(ra) # 8000152e <fork>
}
    80002364:	60a2                	ld	ra,8(sp)
    80002366:	6402                	ld	s0,0(sp)
    80002368:	0141                	addi	sp,sp,16
    8000236a:	8082                	ret

000000008000236c <sys_wait>:

uint64
sys_wait(void)
{
    8000236c:	1101                	addi	sp,sp,-32
    8000236e:	ec06                	sd	ra,24(sp)
    80002370:	e822                	sd	s0,16(sp)
    80002372:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    80002374:	fe840593          	addi	a1,s0,-24
    80002378:	4501                	li	a0,0
    8000237a:	00000097          	auipc	ra,0x0
    8000237e:	ecc080e7          	jalr	-308(ra) # 80002246 <argaddr>
    80002382:	87aa                	mv	a5,a0
    return -1;
    80002384:	557d                	li	a0,-1
  if(argaddr(0, &p) < 0)
    80002386:	0007c863          	bltz	a5,80002396 <sys_wait+0x2a>
  return wait(p);
    8000238a:	fe843503          	ld	a0,-24(s0)
    8000238e:	fffff097          	auipc	ra,0xfffff
    80002392:	4f2080e7          	jalr	1266(ra) # 80001880 <wait>
}
    80002396:	60e2                	ld	ra,24(sp)
    80002398:	6442                	ld	s0,16(sp)
    8000239a:	6105                	addi	sp,sp,32
    8000239c:	8082                	ret

000000008000239e <sys_sbrk>:

uint64
sys_sbrk(void)
{
    8000239e:	7179                	addi	sp,sp,-48
    800023a0:	f406                	sd	ra,40(sp)
    800023a2:	f022                	sd	s0,32(sp)
    800023a4:	ec26                	sd	s1,24(sp)
    800023a6:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    800023a8:	fdc40593          	addi	a1,s0,-36
    800023ac:	4501                	li	a0,0
    800023ae:	00000097          	auipc	ra,0x0
    800023b2:	e76080e7          	jalr	-394(ra) # 80002224 <argint>
    800023b6:	87aa                	mv	a5,a0
    return -1;
    800023b8:	557d                	li	a0,-1
  if(argint(0, &n) < 0)
    800023ba:	0207c063          	bltz	a5,800023da <sys_sbrk+0x3c>
  
  addr = myproc()->sz;
    800023be:	fffff097          	auipc	ra,0xfffff
    800023c2:	da2080e7          	jalr	-606(ra) # 80001160 <myproc>
    800023c6:	4524                	lw	s1,72(a0)
  if(growproc(n) < 0)
    800023c8:	fdc42503          	lw	a0,-36(s0)
    800023cc:	fffff097          	auipc	ra,0xfffff
    800023d0:	0ee080e7          	jalr	238(ra) # 800014ba <growproc>
    800023d4:	00054863          	bltz	a0,800023e4 <sys_sbrk+0x46>
    return -1;
  return addr;
    800023d8:	8526                	mv	a0,s1
}
    800023da:	70a2                	ld	ra,40(sp)
    800023dc:	7402                	ld	s0,32(sp)
    800023de:	64e2                	ld	s1,24(sp)
    800023e0:	6145                	addi	sp,sp,48
    800023e2:	8082                	ret
    return -1;
    800023e4:	557d                	li	a0,-1
    800023e6:	bfd5                	j	800023da <sys_sbrk+0x3c>

00000000800023e8 <sys_sleep>:

uint64
sys_sleep(void)
{
    800023e8:	7139                	addi	sp,sp,-64
    800023ea:	fc06                	sd	ra,56(sp)
    800023ec:	f822                	sd	s0,48(sp)
    800023ee:	f426                	sd	s1,40(sp)
    800023f0:	f04a                	sd	s2,32(sp)
    800023f2:	ec4e                	sd	s3,24(sp)
    800023f4:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;


  if(argint(0, &n) < 0)
    800023f6:	fcc40593          	addi	a1,s0,-52
    800023fa:	4501                	li	a0,0
    800023fc:	00000097          	auipc	ra,0x0
    80002400:	e28080e7          	jalr	-472(ra) # 80002224 <argint>
    return -1;
    80002404:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80002406:	06054563          	bltz	a0,80002470 <sys_sleep+0x88>
  acquire(&tickslock);
    8000240a:	0000d517          	auipc	a0,0xd
    8000240e:	a7650513          	addi	a0,a0,-1418 # 8000ee80 <tickslock>
    80002412:	00004097          	auipc	ra,0x4
    80002416:	408080e7          	jalr	1032(ra) # 8000681a <acquire>
  ticks0 = ticks;
    8000241a:	00007917          	auipc	s2,0x7
    8000241e:	bfe92903          	lw	s2,-1026(s2) # 80009018 <ticks>
  while(ticks - ticks0 < n){
    80002422:	fcc42783          	lw	a5,-52(s0)
    80002426:	cf85                	beqz	a5,8000245e <sys_sleep+0x76>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80002428:	0000d997          	auipc	s3,0xd
    8000242c:	a5898993          	addi	s3,s3,-1448 # 8000ee80 <tickslock>
    80002430:	00007497          	auipc	s1,0x7
    80002434:	be848493          	addi	s1,s1,-1048 # 80009018 <ticks>
    if(myproc()->killed){
    80002438:	fffff097          	auipc	ra,0xfffff
    8000243c:	d28080e7          	jalr	-728(ra) # 80001160 <myproc>
    80002440:	551c                	lw	a5,40(a0)
    80002442:	ef9d                	bnez	a5,80002480 <sys_sleep+0x98>
    sleep(&ticks, &tickslock);
    80002444:	85ce                	mv	a1,s3
    80002446:	8526                	mv	a0,s1
    80002448:	fffff097          	auipc	ra,0xfffff
    8000244c:	3d4080e7          	jalr	980(ra) # 8000181c <sleep>
  while(ticks - ticks0 < n){
    80002450:	409c                	lw	a5,0(s1)
    80002452:	412787bb          	subw	a5,a5,s2
    80002456:	fcc42703          	lw	a4,-52(s0)
    8000245a:	fce7efe3          	bltu	a5,a4,80002438 <sys_sleep+0x50>
  }
  release(&tickslock);
    8000245e:	0000d517          	auipc	a0,0xd
    80002462:	a2250513          	addi	a0,a0,-1502 # 8000ee80 <tickslock>
    80002466:	00004097          	auipc	ra,0x4
    8000246a:	468080e7          	jalr	1128(ra) # 800068ce <release>
  return 0;
    8000246e:	4781                	li	a5,0
}
    80002470:	853e                	mv	a0,a5
    80002472:	70e2                	ld	ra,56(sp)
    80002474:	7442                	ld	s0,48(sp)
    80002476:	74a2                	ld	s1,40(sp)
    80002478:	7902                	ld	s2,32(sp)
    8000247a:	69e2                	ld	s3,24(sp)
    8000247c:	6121                	addi	sp,sp,64
    8000247e:	8082                	ret
      release(&tickslock);
    80002480:	0000d517          	auipc	a0,0xd
    80002484:	a0050513          	addi	a0,a0,-1536 # 8000ee80 <tickslock>
    80002488:	00004097          	auipc	ra,0x4
    8000248c:	446080e7          	jalr	1094(ra) # 800068ce <release>
      return -1;
    80002490:	57fd                	li	a5,-1
    80002492:	bff9                	j	80002470 <sys_sleep+0x88>

0000000080002494 <sys_pgaccess>:


#ifdef LAB_PGTBL
int
sys_pgaccess(void)
{
    80002494:	1141                	addi	sp,sp,-16
    80002496:	e422                	sd	s0,8(sp)
    80002498:	0800                	addi	s0,sp,16
  // lab pgtbl: your code here.
  return 0;
}
    8000249a:	4501                	li	a0,0
    8000249c:	6422                	ld	s0,8(sp)
    8000249e:	0141                	addi	sp,sp,16
    800024a0:	8082                	ret

00000000800024a2 <sys_kill>:
#endif

uint64
sys_kill(void)
{
    800024a2:	1101                	addi	sp,sp,-32
    800024a4:	ec06                	sd	ra,24(sp)
    800024a6:	e822                	sd	s0,16(sp)
    800024a8:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    800024aa:	fec40593          	addi	a1,s0,-20
    800024ae:	4501                	li	a0,0
    800024b0:	00000097          	auipc	ra,0x0
    800024b4:	d74080e7          	jalr	-652(ra) # 80002224 <argint>
    800024b8:	87aa                	mv	a5,a0
    return -1;
    800024ba:	557d                	li	a0,-1
  if(argint(0, &pid) < 0)
    800024bc:	0007c863          	bltz	a5,800024cc <sys_kill+0x2a>
  return kill(pid);
    800024c0:	fec42503          	lw	a0,-20(s0)
    800024c4:	fffff097          	auipc	ra,0xfffff
    800024c8:	68a080e7          	jalr	1674(ra) # 80001b4e <kill>
}
    800024cc:	60e2                	ld	ra,24(sp)
    800024ce:	6442                	ld	s0,16(sp)
    800024d0:	6105                	addi	sp,sp,32
    800024d2:	8082                	ret

00000000800024d4 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    800024d4:	1101                	addi	sp,sp,-32
    800024d6:	ec06                	sd	ra,24(sp)
    800024d8:	e822                	sd	s0,16(sp)
    800024da:	e426                	sd	s1,8(sp)
    800024dc:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    800024de:	0000d517          	auipc	a0,0xd
    800024e2:	9a250513          	addi	a0,a0,-1630 # 8000ee80 <tickslock>
    800024e6:	00004097          	auipc	ra,0x4
    800024ea:	334080e7          	jalr	820(ra) # 8000681a <acquire>
  xticks = ticks;
    800024ee:	00007497          	auipc	s1,0x7
    800024f2:	b2a4a483          	lw	s1,-1238(s1) # 80009018 <ticks>
  release(&tickslock);
    800024f6:	0000d517          	auipc	a0,0xd
    800024fa:	98a50513          	addi	a0,a0,-1654 # 8000ee80 <tickslock>
    800024fe:	00004097          	auipc	ra,0x4
    80002502:	3d0080e7          	jalr	976(ra) # 800068ce <release>
  return xticks;
}
    80002506:	02049513          	slli	a0,s1,0x20
    8000250a:	9101                	srli	a0,a0,0x20
    8000250c:	60e2                	ld	ra,24(sp)
    8000250e:	6442                	ld	s0,16(sp)
    80002510:	64a2                	ld	s1,8(sp)
    80002512:	6105                	addi	sp,sp,32
    80002514:	8082                	ret

0000000080002516 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
    80002516:	7179                	addi	sp,sp,-48
    80002518:	f406                	sd	ra,40(sp)
    8000251a:	f022                	sd	s0,32(sp)
    8000251c:	ec26                	sd	s1,24(sp)
    8000251e:	e84a                	sd	s2,16(sp)
    80002520:	e44e                	sd	s3,8(sp)
    80002522:	1800                	addi	s0,sp,48
    80002524:	892a                	mv	s2,a0
    80002526:	89ae                	mv	s3,a1
  struct buf *b;

  acquire(&bcache.lock);
    80002528:	0000d517          	auipc	a0,0xd
    8000252c:	97050513          	addi	a0,a0,-1680 # 8000ee98 <bcache>
    80002530:	00004097          	auipc	ra,0x4
    80002534:	2ea080e7          	jalr	746(ra) # 8000681a <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80002538:	00015497          	auipc	s1,0x15
    8000253c:	c184b483          	ld	s1,-1000(s1) # 80017150 <bcache+0x82b8>
    80002540:	00015797          	auipc	a5,0x15
    80002544:	bc078793          	addi	a5,a5,-1088 # 80017100 <bcache+0x8268>
    80002548:	02f48f63          	beq	s1,a5,80002586 <bget+0x70>
    8000254c:	873e                	mv	a4,a5
    8000254e:	a021                	j	80002556 <bget+0x40>
    80002550:	68a4                	ld	s1,80(s1)
    80002552:	02e48a63          	beq	s1,a4,80002586 <bget+0x70>
    if(b->dev == dev && b->blockno == blockno){
    80002556:	449c                	lw	a5,8(s1)
    80002558:	ff279ce3          	bne	a5,s2,80002550 <bget+0x3a>
    8000255c:	44dc                	lw	a5,12(s1)
    8000255e:	ff3799e3          	bne	a5,s3,80002550 <bget+0x3a>
      b->refcnt++;
    80002562:	40bc                	lw	a5,64(s1)
    80002564:	2785                	addiw	a5,a5,1
    80002566:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002568:	0000d517          	auipc	a0,0xd
    8000256c:	93050513          	addi	a0,a0,-1744 # 8000ee98 <bcache>
    80002570:	00004097          	auipc	ra,0x4
    80002574:	35e080e7          	jalr	862(ra) # 800068ce <release>
      acquiresleep(&b->lock);
    80002578:	01048513          	addi	a0,s1,16
    8000257c:	00001097          	auipc	ra,0x1
    80002580:	736080e7          	jalr	1846(ra) # 80003cb2 <acquiresleep>
      return b;
    80002584:	a8b9                	j	800025e2 <bget+0xcc>
    }
  }

  // Not cached.
  // Recycle the least recently used (LRU) unused buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002586:	00015497          	auipc	s1,0x15
    8000258a:	bc24b483          	ld	s1,-1086(s1) # 80017148 <bcache+0x82b0>
    8000258e:	00015797          	auipc	a5,0x15
    80002592:	b7278793          	addi	a5,a5,-1166 # 80017100 <bcache+0x8268>
    80002596:	00f48863          	beq	s1,a5,800025a6 <bget+0x90>
    8000259a:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    8000259c:	40bc                	lw	a5,64(s1)
    8000259e:	cf81                	beqz	a5,800025b6 <bget+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800025a0:	64a4                	ld	s1,72(s1)
    800025a2:	fee49de3          	bne	s1,a4,8000259c <bget+0x86>
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
    800025a6:	00006517          	auipc	a0,0x6
    800025aa:	fca50513          	addi	a0,a0,-54 # 80008570 <syscalls+0x110>
    800025ae:	00004097          	auipc	ra,0x4
    800025b2:	d22080e7          	jalr	-734(ra) # 800062d0 <panic>
      b->dev = dev;
    800025b6:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    800025ba:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    800025be:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    800025c2:	4785                	li	a5,1
    800025c4:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800025c6:	0000d517          	auipc	a0,0xd
    800025ca:	8d250513          	addi	a0,a0,-1838 # 8000ee98 <bcache>
    800025ce:	00004097          	auipc	ra,0x4
    800025d2:	300080e7          	jalr	768(ra) # 800068ce <release>
      acquiresleep(&b->lock);
    800025d6:	01048513          	addi	a0,s1,16
    800025da:	00001097          	auipc	ra,0x1
    800025de:	6d8080e7          	jalr	1752(ra) # 80003cb2 <acquiresleep>
}
    800025e2:	8526                	mv	a0,s1
    800025e4:	70a2                	ld	ra,40(sp)
    800025e6:	7402                	ld	s0,32(sp)
    800025e8:	64e2                	ld	s1,24(sp)
    800025ea:	6942                	ld	s2,16(sp)
    800025ec:	69a2                	ld	s3,8(sp)
    800025ee:	6145                	addi	sp,sp,48
    800025f0:	8082                	ret

00000000800025f2 <binit>:
{
    800025f2:	7179                	addi	sp,sp,-48
    800025f4:	f406                	sd	ra,40(sp)
    800025f6:	f022                	sd	s0,32(sp)
    800025f8:	ec26                	sd	s1,24(sp)
    800025fa:	e84a                	sd	s2,16(sp)
    800025fc:	e44e                	sd	s3,8(sp)
    800025fe:	e052                	sd	s4,0(sp)
    80002600:	1800                	addi	s0,sp,48
  initlock(&bcache.lock, "bcache");
    80002602:	00006597          	auipc	a1,0x6
    80002606:	f8658593          	addi	a1,a1,-122 # 80008588 <syscalls+0x128>
    8000260a:	0000d517          	auipc	a0,0xd
    8000260e:	88e50513          	addi	a0,a0,-1906 # 8000ee98 <bcache>
    80002612:	00004097          	auipc	ra,0x4
    80002616:	178080e7          	jalr	376(ra) # 8000678a <initlock>
  bcache.head.prev = &bcache.head;
    8000261a:	00015797          	auipc	a5,0x15
    8000261e:	87e78793          	addi	a5,a5,-1922 # 80016e98 <bcache+0x8000>
    80002622:	00015717          	auipc	a4,0x15
    80002626:	ade70713          	addi	a4,a4,-1314 # 80017100 <bcache+0x8268>
    8000262a:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    8000262e:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002632:	0000d497          	auipc	s1,0xd
    80002636:	87e48493          	addi	s1,s1,-1922 # 8000eeb0 <bcache+0x18>
    b->next = bcache.head.next;
    8000263a:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    8000263c:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    8000263e:	00006a17          	auipc	s4,0x6
    80002642:	f52a0a13          	addi	s4,s4,-174 # 80008590 <syscalls+0x130>
    b->next = bcache.head.next;
    80002646:	2b893783          	ld	a5,696(s2)
    8000264a:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    8000264c:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80002650:	85d2                	mv	a1,s4
    80002652:	01048513          	addi	a0,s1,16
    80002656:	00001097          	auipc	ra,0x1
    8000265a:	622080e7          	jalr	1570(ra) # 80003c78 <initsleeplock>
    bcache.head.next->prev = b;
    8000265e:	2b893783          	ld	a5,696(s2)
    80002662:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80002664:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002668:	45848493          	addi	s1,s1,1112
    8000266c:	fd349de3          	bne	s1,s3,80002646 <binit+0x54>
}
    80002670:	70a2                	ld	ra,40(sp)
    80002672:	7402                	ld	s0,32(sp)
    80002674:	64e2                	ld	s1,24(sp)
    80002676:	6942                	ld	s2,16(sp)
    80002678:	69a2                	ld	s3,8(sp)
    8000267a:	6a02                	ld	s4,0(sp)
    8000267c:	6145                	addi	sp,sp,48
    8000267e:	8082                	ret

0000000080002680 <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80002680:	1101                	addi	sp,sp,-32
    80002682:	ec06                	sd	ra,24(sp)
    80002684:	e822                	sd	s0,16(sp)
    80002686:	e426                	sd	s1,8(sp)
    80002688:	1000                	addi	s0,sp,32
  struct buf *b;

  b = bget(dev, blockno);
    8000268a:	00000097          	auipc	ra,0x0
    8000268e:	e8c080e7          	jalr	-372(ra) # 80002516 <bget>
    80002692:	84aa                	mv	s1,a0
  if(!b->valid) {
    80002694:	411c                	lw	a5,0(a0)
    80002696:	c799                	beqz	a5,800026a4 <bread+0x24>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    80002698:	8526                	mv	a0,s1
    8000269a:	60e2                	ld	ra,24(sp)
    8000269c:	6442                	ld	s0,16(sp)
    8000269e:	64a2                	ld	s1,8(sp)
    800026a0:	6105                	addi	sp,sp,32
    800026a2:	8082                	ret
    virtio_disk_rw(b, 0);
    800026a4:	4581                	li	a1,0
    800026a6:	00003097          	auipc	ra,0x3
    800026aa:	130080e7          	jalr	304(ra) # 800057d6 <virtio_disk_rw>
    b->valid = 1;
    800026ae:	4785                	li	a5,1
    800026b0:	c09c                	sw	a5,0(s1)
  return b;
    800026b2:	b7dd                	j	80002698 <bread+0x18>

00000000800026b4 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    800026b4:	1101                	addi	sp,sp,-32
    800026b6:	ec06                	sd	ra,24(sp)
    800026b8:	e822                	sd	s0,16(sp)
    800026ba:	e426                	sd	s1,8(sp)
    800026bc:	1000                	addi	s0,sp,32
    800026be:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800026c0:	0541                	addi	a0,a0,16
    800026c2:	00001097          	auipc	ra,0x1
    800026c6:	68a080e7          	jalr	1674(ra) # 80003d4c <holdingsleep>
    800026ca:	cd01                	beqz	a0,800026e2 <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    800026cc:	4585                	li	a1,1
    800026ce:	8526                	mv	a0,s1
    800026d0:	00003097          	auipc	ra,0x3
    800026d4:	106080e7          	jalr	262(ra) # 800057d6 <virtio_disk_rw>
}
    800026d8:	60e2                	ld	ra,24(sp)
    800026da:	6442                	ld	s0,16(sp)
    800026dc:	64a2                	ld	s1,8(sp)
    800026de:	6105                	addi	sp,sp,32
    800026e0:	8082                	ret
    panic("bwrite");
    800026e2:	00006517          	auipc	a0,0x6
    800026e6:	eb650513          	addi	a0,a0,-330 # 80008598 <syscalls+0x138>
    800026ea:	00004097          	auipc	ra,0x4
    800026ee:	be6080e7          	jalr	-1050(ra) # 800062d0 <panic>

00000000800026f2 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    800026f2:	1101                	addi	sp,sp,-32
    800026f4:	ec06                	sd	ra,24(sp)
    800026f6:	e822                	sd	s0,16(sp)
    800026f8:	e426                	sd	s1,8(sp)
    800026fa:	e04a                	sd	s2,0(sp)
    800026fc:	1000                	addi	s0,sp,32
    800026fe:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002700:	01050913          	addi	s2,a0,16
    80002704:	854a                	mv	a0,s2
    80002706:	00001097          	auipc	ra,0x1
    8000270a:	646080e7          	jalr	1606(ra) # 80003d4c <holdingsleep>
    8000270e:	c92d                	beqz	a0,80002780 <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    80002710:	854a                	mv	a0,s2
    80002712:	00001097          	auipc	ra,0x1
    80002716:	5f6080e7          	jalr	1526(ra) # 80003d08 <releasesleep>

  acquire(&bcache.lock);
    8000271a:	0000c517          	auipc	a0,0xc
    8000271e:	77e50513          	addi	a0,a0,1918 # 8000ee98 <bcache>
    80002722:	00004097          	auipc	ra,0x4
    80002726:	0f8080e7          	jalr	248(ra) # 8000681a <acquire>
  b->refcnt--;
    8000272a:	40bc                	lw	a5,64(s1)
    8000272c:	37fd                	addiw	a5,a5,-1
    8000272e:	0007871b          	sext.w	a4,a5
    80002732:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    80002734:	eb05                	bnez	a4,80002764 <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80002736:	68bc                	ld	a5,80(s1)
    80002738:	64b8                	ld	a4,72(s1)
    8000273a:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    8000273c:	64bc                	ld	a5,72(s1)
    8000273e:	68b8                	ld	a4,80(s1)
    80002740:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80002742:	00014797          	auipc	a5,0x14
    80002746:	75678793          	addi	a5,a5,1878 # 80016e98 <bcache+0x8000>
    8000274a:	2b87b703          	ld	a4,696(a5)
    8000274e:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    80002750:	00015717          	auipc	a4,0x15
    80002754:	9b070713          	addi	a4,a4,-1616 # 80017100 <bcache+0x8268>
    80002758:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    8000275a:	2b87b703          	ld	a4,696(a5)
    8000275e:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    80002760:	2a97bc23          	sd	s1,696(a5)
  }

  release(&bcache.lock);
    80002764:	0000c517          	auipc	a0,0xc
    80002768:	73450513          	addi	a0,a0,1844 # 8000ee98 <bcache>
    8000276c:	00004097          	auipc	ra,0x4
    80002770:	162080e7          	jalr	354(ra) # 800068ce <release>
}
    80002774:	60e2                	ld	ra,24(sp)
    80002776:	6442                	ld	s0,16(sp)
    80002778:	64a2                	ld	s1,8(sp)
    8000277a:	6902                	ld	s2,0(sp)
    8000277c:	6105                	addi	sp,sp,32
    8000277e:	8082                	ret
    panic("brelse");
    80002780:	00006517          	auipc	a0,0x6
    80002784:	e2050513          	addi	a0,a0,-480 # 800085a0 <syscalls+0x140>
    80002788:	00004097          	auipc	ra,0x4
    8000278c:	b48080e7          	jalr	-1208(ra) # 800062d0 <panic>

0000000080002790 <bpin>:

void
bpin(struct buf *b) {
    80002790:	1101                	addi	sp,sp,-32
    80002792:	ec06                	sd	ra,24(sp)
    80002794:	e822                	sd	s0,16(sp)
    80002796:	e426                	sd	s1,8(sp)
    80002798:	1000                	addi	s0,sp,32
    8000279a:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    8000279c:	0000c517          	auipc	a0,0xc
    800027a0:	6fc50513          	addi	a0,a0,1788 # 8000ee98 <bcache>
    800027a4:	00004097          	auipc	ra,0x4
    800027a8:	076080e7          	jalr	118(ra) # 8000681a <acquire>
  b->refcnt++;
    800027ac:	40bc                	lw	a5,64(s1)
    800027ae:	2785                	addiw	a5,a5,1
    800027b0:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800027b2:	0000c517          	auipc	a0,0xc
    800027b6:	6e650513          	addi	a0,a0,1766 # 8000ee98 <bcache>
    800027ba:	00004097          	auipc	ra,0x4
    800027be:	114080e7          	jalr	276(ra) # 800068ce <release>
}
    800027c2:	60e2                	ld	ra,24(sp)
    800027c4:	6442                	ld	s0,16(sp)
    800027c6:	64a2                	ld	s1,8(sp)
    800027c8:	6105                	addi	sp,sp,32
    800027ca:	8082                	ret

00000000800027cc <bunpin>:

void
bunpin(struct buf *b) {
    800027cc:	1101                	addi	sp,sp,-32
    800027ce:	ec06                	sd	ra,24(sp)
    800027d0:	e822                	sd	s0,16(sp)
    800027d2:	e426                	sd	s1,8(sp)
    800027d4:	1000                	addi	s0,sp,32
    800027d6:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800027d8:	0000c517          	auipc	a0,0xc
    800027dc:	6c050513          	addi	a0,a0,1728 # 8000ee98 <bcache>
    800027e0:	00004097          	auipc	ra,0x4
    800027e4:	03a080e7          	jalr	58(ra) # 8000681a <acquire>
  b->refcnt--;
    800027e8:	40bc                	lw	a5,64(s1)
    800027ea:	37fd                	addiw	a5,a5,-1
    800027ec:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800027ee:	0000c517          	auipc	a0,0xc
    800027f2:	6aa50513          	addi	a0,a0,1706 # 8000ee98 <bcache>
    800027f6:	00004097          	auipc	ra,0x4
    800027fa:	0d8080e7          	jalr	216(ra) # 800068ce <release>
}
    800027fe:	60e2                	ld	ra,24(sp)
    80002800:	6442                	ld	s0,16(sp)
    80002802:	64a2                	ld	s1,8(sp)
    80002804:	6105                	addi	sp,sp,32
    80002806:	8082                	ret

0000000080002808 <write_page_to_disk>:

/* NTU OS 2024 */
/* Write 4096 bytes page to the eight consecutive 512-byte blocks starting at blk. */
void write_page_to_disk(uint dev, char *page, uint blk) {
    80002808:	7179                	addi	sp,sp,-48
    8000280a:	f406                	sd	ra,40(sp)
    8000280c:	f022                	sd	s0,32(sp)
    8000280e:	ec26                	sd	s1,24(sp)
    80002810:	e84a                	sd	s2,16(sp)
    80002812:	e44e                	sd	s3,8(sp)
    80002814:	e052                	sd	s4,0(sp)
    80002816:	1800                	addi	s0,sp,48
    80002818:	89b2                	mv	s3,a2
  for (int i = 0; i < 8; i++) {
    8000281a:	892e                	mv	s2,a1
    8000281c:	6a05                	lui	s4,0x1
    8000281e:	9a2e                	add	s4,s4,a1
    // disk
    int offset = i * 512;
    int blk_idx = blk + i;
    struct buf *buffer = bget(ROOTDEV, blk_idx);
    80002820:	85ce                	mv	a1,s3
    80002822:	4505                	li	a0,1
    80002824:	00000097          	auipc	ra,0x0
    80002828:	cf2080e7          	jalr	-782(ra) # 80002516 <bget>
    8000282c:	84aa                	mv	s1,a0
    memmove(buffer->data, page + offset, 512);
    8000282e:	20000613          	li	a2,512
    80002832:	85ca                	mv	a1,s2
    80002834:	05850513          	addi	a0,a0,88
    80002838:	ffffe097          	auipc	ra,0xffffe
    8000283c:	9a0080e7          	jalr	-1632(ra) # 800001d8 <memmove>
    bwrite(buffer);
    80002840:	8526                	mv	a0,s1
    80002842:	00000097          	auipc	ra,0x0
    80002846:	e72080e7          	jalr	-398(ra) # 800026b4 <bwrite>
    brelse(buffer);
    8000284a:	8526                	mv	a0,s1
    8000284c:	00000097          	auipc	ra,0x0
    80002850:	ea6080e7          	jalr	-346(ra) # 800026f2 <brelse>
  for (int i = 0; i < 8; i++) {
    80002854:	2985                	addiw	s3,s3,1
    80002856:	20090913          	addi	s2,s2,512
    8000285a:	fd4913e3          	bne	s2,s4,80002820 <write_page_to_disk+0x18>
  }
}
    8000285e:	70a2                	ld	ra,40(sp)
    80002860:	7402                	ld	s0,32(sp)
    80002862:	64e2                	ld	s1,24(sp)
    80002864:	6942                	ld	s2,16(sp)
    80002866:	69a2                	ld	s3,8(sp)
    80002868:	6a02                	ld	s4,0(sp)
    8000286a:	6145                	addi	sp,sp,48
    8000286c:	8082                	ret

000000008000286e <read_page_from_disk>:

/* NTU OS 2024 */
/* Read 4096 bytes from the eight consecutive 512-byte blocks starting at blk into page. */
void read_page_from_disk(uint dev, char *page, uint blk) {
    8000286e:	7179                	addi	sp,sp,-48
    80002870:	f406                	sd	ra,40(sp)
    80002872:	f022                	sd	s0,32(sp)
    80002874:	ec26                	sd	s1,24(sp)
    80002876:	e84a                	sd	s2,16(sp)
    80002878:	e44e                	sd	s3,8(sp)
    8000287a:	e052                	sd	s4,0(sp)
    8000287c:	1800                	addi	s0,sp,48
    8000287e:	89b2                	mv	s3,a2
  for (int i = 0; i < 8; i++) {
    80002880:	892e                	mv	s2,a1
    80002882:	6a05                	lui	s4,0x1
    80002884:	9a2e                	add	s4,s4,a1
    int offset = i * 512;
    int blk_idx = blk + i;
    struct buf *buffer = bread(ROOTDEV, blk_idx);
    80002886:	85ce                	mv	a1,s3
    80002888:	4505                	li	a0,1
    8000288a:	00000097          	auipc	ra,0x0
    8000288e:	df6080e7          	jalr	-522(ra) # 80002680 <bread>
    80002892:	84aa                	mv	s1,a0
    memmove(page + offset, buffer->data, 512);
    80002894:	20000613          	li	a2,512
    80002898:	05850593          	addi	a1,a0,88
    8000289c:	854a                	mv	a0,s2
    8000289e:	ffffe097          	auipc	ra,0xffffe
    800028a2:	93a080e7          	jalr	-1734(ra) # 800001d8 <memmove>
    brelse(buffer);
    800028a6:	8526                	mv	a0,s1
    800028a8:	00000097          	auipc	ra,0x0
    800028ac:	e4a080e7          	jalr	-438(ra) # 800026f2 <brelse>
  for (int i = 0; i < 8; i++) {
    800028b0:	2985                	addiw	s3,s3,1
    800028b2:	20090913          	addi	s2,s2,512
    800028b6:	fd4918e3          	bne	s2,s4,80002886 <read_page_from_disk+0x18>
  }
}
    800028ba:	70a2                	ld	ra,40(sp)
    800028bc:	7402                	ld	s0,32(sp)
    800028be:	64e2                	ld	s1,24(sp)
    800028c0:	6942                	ld	s2,16(sp)
    800028c2:	69a2                	ld	s3,8(sp)
    800028c4:	6a02                	ld	s4,0(sp)
    800028c6:	6145                	addi	sp,sp,48
    800028c8:	8082                	ret

00000000800028ca <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    800028ca:	1101                	addi	sp,sp,-32
    800028cc:	ec06                	sd	ra,24(sp)
    800028ce:	e822                	sd	s0,16(sp)
    800028d0:	e426                	sd	s1,8(sp)
    800028d2:	1000                	addi	s0,sp,32
    800028d4:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    800028d6:	00d5d59b          	srliw	a1,a1,0xd
    800028da:	00015797          	auipc	a5,0x15
    800028de:	c9a7a783          	lw	a5,-870(a5) # 80017574 <sb+0x1c>
    800028e2:	9dbd                	addw	a1,a1,a5
    800028e4:	00000097          	auipc	ra,0x0
    800028e8:	d9c080e7          	jalr	-612(ra) # 80002680 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    800028ec:	0074f713          	andi	a4,s1,7
    800028f0:	4785                	li	a5,1
    800028f2:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    800028f6:	14ce                	slli	s1,s1,0x33
    800028f8:	90d9                	srli	s1,s1,0x36
    800028fa:	00950733          	add	a4,a0,s1
    800028fe:	05874703          	lbu	a4,88(a4)
    80002902:	00e7f6b3          	and	a3,a5,a4
    80002906:	c285                	beqz	a3,80002926 <bfree+0x5c>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    80002908:	94aa                	add	s1,s1,a0
    8000290a:	fff7c793          	not	a5,a5
    8000290e:	8ff9                	and	a5,a5,a4
    80002910:	04f48c23          	sb	a5,88(s1)
  //log_write(bp);
  brelse(bp);
    80002914:	00000097          	auipc	ra,0x0
    80002918:	dde080e7          	jalr	-546(ra) # 800026f2 <brelse>
}
    8000291c:	60e2                	ld	ra,24(sp)
    8000291e:	6442                	ld	s0,16(sp)
    80002920:	64a2                	ld	s1,8(sp)
    80002922:	6105                	addi	sp,sp,32
    80002924:	8082                	ret
    panic("freeing free block");
    80002926:	00006517          	auipc	a0,0x6
    8000292a:	c8250513          	addi	a0,a0,-894 # 800085a8 <syscalls+0x148>
    8000292e:	00004097          	auipc	ra,0x4
    80002932:	9a2080e7          	jalr	-1630(ra) # 800062d0 <panic>

0000000080002936 <bzero>:
{
    80002936:	1101                	addi	sp,sp,-32
    80002938:	ec06                	sd	ra,24(sp)
    8000293a:	e822                	sd	s0,16(sp)
    8000293c:	e426                	sd	s1,8(sp)
    8000293e:	1000                	addi	s0,sp,32
  bp = bread(dev, bno);
    80002940:	00000097          	auipc	ra,0x0
    80002944:	d40080e7          	jalr	-704(ra) # 80002680 <bread>
    80002948:	84aa                	mv	s1,a0
  memset(bp->data, 0, BSIZE);
    8000294a:	40000613          	li	a2,1024
    8000294e:	4581                	li	a1,0
    80002950:	05850513          	addi	a0,a0,88
    80002954:	ffffe097          	auipc	ra,0xffffe
    80002958:	824080e7          	jalr	-2012(ra) # 80000178 <memset>
  brelse(bp);
    8000295c:	8526                	mv	a0,s1
    8000295e:	00000097          	auipc	ra,0x0
    80002962:	d94080e7          	jalr	-620(ra) # 800026f2 <brelse>
}
    80002966:	60e2                	ld	ra,24(sp)
    80002968:	6442                	ld	s0,16(sp)
    8000296a:	64a2                	ld	s1,8(sp)
    8000296c:	6105                	addi	sp,sp,32
    8000296e:	8082                	ret

0000000080002970 <balloc>:
{
    80002970:	711d                	addi	sp,sp,-96
    80002972:	ec86                	sd	ra,88(sp)
    80002974:	e8a2                	sd	s0,80(sp)
    80002976:	e4a6                	sd	s1,72(sp)
    80002978:	e0ca                	sd	s2,64(sp)
    8000297a:	fc4e                	sd	s3,56(sp)
    8000297c:	f852                	sd	s4,48(sp)
    8000297e:	f456                	sd	s5,40(sp)
    80002980:	f05a                	sd	s6,32(sp)
    80002982:	ec5e                	sd	s7,24(sp)
    80002984:	e862                	sd	s8,16(sp)
    80002986:	e466                	sd	s9,8(sp)
    80002988:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    8000298a:	00015797          	auipc	a5,0x15
    8000298e:	bd27a783          	lw	a5,-1070(a5) # 8001755c <sb+0x4>
    80002992:	cbd1                	beqz	a5,80002a26 <balloc+0xb6>
    80002994:	8baa                	mv	s7,a0
    80002996:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80002998:	00015b17          	auipc	s6,0x15
    8000299c:	bc0b0b13          	addi	s6,s6,-1088 # 80017558 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800029a0:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    800029a2:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800029a4:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    800029a6:	6c89                	lui	s9,0x2
    800029a8:	a829                	j	800029c2 <balloc+0x52>
    brelse(bp);
    800029aa:	00000097          	auipc	ra,0x0
    800029ae:	d48080e7          	jalr	-696(ra) # 800026f2 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    800029b2:	015c87bb          	addw	a5,s9,s5
    800029b6:	00078a9b          	sext.w	s5,a5
    800029ba:	004b2703          	lw	a4,4(s6)
    800029be:	06eaf463          	bgeu	s5,a4,80002a26 <balloc+0xb6>
    bp = bread(dev, BBLOCK(b, sb));
    800029c2:	41fad79b          	sraiw	a5,s5,0x1f
    800029c6:	0137d79b          	srliw	a5,a5,0x13
    800029ca:	015787bb          	addw	a5,a5,s5
    800029ce:	40d7d79b          	sraiw	a5,a5,0xd
    800029d2:	01cb2583          	lw	a1,28(s6)
    800029d6:	9dbd                	addw	a1,a1,a5
    800029d8:	855e                	mv	a0,s7
    800029da:	00000097          	auipc	ra,0x0
    800029de:	ca6080e7          	jalr	-858(ra) # 80002680 <bread>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800029e2:	004b2803          	lw	a6,4(s6)
    800029e6:	000a849b          	sext.w	s1,s5
    800029ea:	8662                	mv	a2,s8
    800029ec:	0004891b          	sext.w	s2,s1
    800029f0:	fb04fde3          	bgeu	s1,a6,800029aa <balloc+0x3a>
      m = 1 << (bi % 8);
    800029f4:	41f6579b          	sraiw	a5,a2,0x1f
    800029f8:	01d7d69b          	srliw	a3,a5,0x1d
    800029fc:	00c6873b          	addw	a4,a3,a2
    80002a00:	00777793          	andi	a5,a4,7
    80002a04:	9f95                	subw	a5,a5,a3
    80002a06:	00f997bb          	sllw	a5,s3,a5
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80002a0a:	4037571b          	sraiw	a4,a4,0x3
    80002a0e:	00e506b3          	add	a3,a0,a4
    80002a12:	0586c683          	lbu	a3,88(a3)
    80002a16:	00d7f5b3          	and	a1,a5,a3
    80002a1a:	cd91                	beqz	a1,80002a36 <balloc+0xc6>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002a1c:	2605                	addiw	a2,a2,1
    80002a1e:	2485                	addiw	s1,s1,1
    80002a20:	fd4616e3          	bne	a2,s4,800029ec <balloc+0x7c>
    80002a24:	b759                	j	800029aa <balloc+0x3a>
  panic("balloc: out of blocks");
    80002a26:	00006517          	auipc	a0,0x6
    80002a2a:	b9a50513          	addi	a0,a0,-1126 # 800085c0 <syscalls+0x160>
    80002a2e:	00004097          	auipc	ra,0x4
    80002a32:	8a2080e7          	jalr	-1886(ra) # 800062d0 <panic>
        bp->data[bi/8] |= m;  // Mark block in use.
    80002a36:	972a                	add	a4,a4,a0
    80002a38:	8fd5                	or	a5,a5,a3
    80002a3a:	04f70c23          	sb	a5,88(a4)
        brelse(bp);
    80002a3e:	00000097          	auipc	ra,0x0
    80002a42:	cb4080e7          	jalr	-844(ra) # 800026f2 <brelse>
        bzero(dev, b + bi);
    80002a46:	85ca                	mv	a1,s2
    80002a48:	855e                	mv	a0,s7
    80002a4a:	00000097          	auipc	ra,0x0
    80002a4e:	eec080e7          	jalr	-276(ra) # 80002936 <bzero>
}
    80002a52:	8526                	mv	a0,s1
    80002a54:	60e6                	ld	ra,88(sp)
    80002a56:	6446                	ld	s0,80(sp)
    80002a58:	64a6                	ld	s1,72(sp)
    80002a5a:	6906                	ld	s2,64(sp)
    80002a5c:	79e2                	ld	s3,56(sp)
    80002a5e:	7a42                	ld	s4,48(sp)
    80002a60:	7aa2                	ld	s5,40(sp)
    80002a62:	7b02                	ld	s6,32(sp)
    80002a64:	6be2                	ld	s7,24(sp)
    80002a66:	6c42                	ld	s8,16(sp)
    80002a68:	6ca2                	ld	s9,8(sp)
    80002a6a:	6125                	addi	sp,sp,96
    80002a6c:	8082                	ret

0000000080002a6e <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    80002a6e:	7179                	addi	sp,sp,-48
    80002a70:	f406                	sd	ra,40(sp)
    80002a72:	f022                	sd	s0,32(sp)
    80002a74:	ec26                	sd	s1,24(sp)
    80002a76:	e84a                	sd	s2,16(sp)
    80002a78:	e44e                	sd	s3,8(sp)
    80002a7a:	e052                	sd	s4,0(sp)
    80002a7c:	1800                	addi	s0,sp,48
    80002a7e:	892a                	mv	s2,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80002a80:	47ad                	li	a5,11
    80002a82:	04b7fe63          	bgeu	a5,a1,80002ade <bmap+0x70>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
    80002a86:	ff45849b          	addiw	s1,a1,-12
    80002a8a:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    80002a8e:	0ff00793          	li	a5,255
    80002a92:	08e7ee63          	bltu	a5,a4,80002b2e <bmap+0xc0>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    80002a96:	08052583          	lw	a1,128(a0)
    80002a9a:	c5ad                	beqz	a1,80002b04 <bmap+0x96>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    80002a9c:	00092503          	lw	a0,0(s2)
    80002aa0:	00000097          	auipc	ra,0x0
    80002aa4:	be0080e7          	jalr	-1056(ra) # 80002680 <bread>
    80002aa8:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80002aaa:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    80002aae:	02049593          	slli	a1,s1,0x20
    80002ab2:	9181                	srli	a1,a1,0x20
    80002ab4:	058a                	slli	a1,a1,0x2
    80002ab6:	00b784b3          	add	s1,a5,a1
    80002aba:	0004a983          	lw	s3,0(s1)
    80002abe:	04098d63          	beqz	s3,80002b18 <bmap+0xaa>
      a[bn] = addr = balloc(ip->dev);
      //log_write(bp);
    }
    brelse(bp);
    80002ac2:	8552                	mv	a0,s4
    80002ac4:	00000097          	auipc	ra,0x0
    80002ac8:	c2e080e7          	jalr	-978(ra) # 800026f2 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    80002acc:	854e                	mv	a0,s3
    80002ace:	70a2                	ld	ra,40(sp)
    80002ad0:	7402                	ld	s0,32(sp)
    80002ad2:	64e2                	ld	s1,24(sp)
    80002ad4:	6942                	ld	s2,16(sp)
    80002ad6:	69a2                	ld	s3,8(sp)
    80002ad8:	6a02                	ld	s4,0(sp)
    80002ada:	6145                	addi	sp,sp,48
    80002adc:	8082                	ret
    if((addr = ip->addrs[bn]) == 0)
    80002ade:	02059493          	slli	s1,a1,0x20
    80002ae2:	9081                	srli	s1,s1,0x20
    80002ae4:	048a                	slli	s1,s1,0x2
    80002ae6:	94aa                	add	s1,s1,a0
    80002ae8:	0504a983          	lw	s3,80(s1)
    80002aec:	fe0990e3          	bnez	s3,80002acc <bmap+0x5e>
      ip->addrs[bn] = addr = balloc(ip->dev);
    80002af0:	4108                	lw	a0,0(a0)
    80002af2:	00000097          	auipc	ra,0x0
    80002af6:	e7e080e7          	jalr	-386(ra) # 80002970 <balloc>
    80002afa:	0005099b          	sext.w	s3,a0
    80002afe:	0534a823          	sw	s3,80(s1)
    80002b02:	b7e9                	j	80002acc <bmap+0x5e>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    80002b04:	4108                	lw	a0,0(a0)
    80002b06:	00000097          	auipc	ra,0x0
    80002b0a:	e6a080e7          	jalr	-406(ra) # 80002970 <balloc>
    80002b0e:	0005059b          	sext.w	a1,a0
    80002b12:	08b92023          	sw	a1,128(s2)
    80002b16:	b759                	j	80002a9c <bmap+0x2e>
      a[bn] = addr = balloc(ip->dev);
    80002b18:	00092503          	lw	a0,0(s2)
    80002b1c:	00000097          	auipc	ra,0x0
    80002b20:	e54080e7          	jalr	-428(ra) # 80002970 <balloc>
    80002b24:	0005099b          	sext.w	s3,a0
    80002b28:	0134a023          	sw	s3,0(s1)
    80002b2c:	bf59                	j	80002ac2 <bmap+0x54>
  panic("bmap: out of range");
    80002b2e:	00006517          	auipc	a0,0x6
    80002b32:	aaa50513          	addi	a0,a0,-1366 # 800085d8 <syscalls+0x178>
    80002b36:	00003097          	auipc	ra,0x3
    80002b3a:	79a080e7          	jalr	1946(ra) # 800062d0 <panic>

0000000080002b3e <iget>:
{
    80002b3e:	7179                	addi	sp,sp,-48
    80002b40:	f406                	sd	ra,40(sp)
    80002b42:	f022                	sd	s0,32(sp)
    80002b44:	ec26                	sd	s1,24(sp)
    80002b46:	e84a                	sd	s2,16(sp)
    80002b48:	e44e                	sd	s3,8(sp)
    80002b4a:	e052                	sd	s4,0(sp)
    80002b4c:	1800                	addi	s0,sp,48
    80002b4e:	89aa                	mv	s3,a0
    80002b50:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    80002b52:	00015517          	auipc	a0,0x15
    80002b56:	a2650513          	addi	a0,a0,-1498 # 80017578 <itable>
    80002b5a:	00004097          	auipc	ra,0x4
    80002b5e:	cc0080e7          	jalr	-832(ra) # 8000681a <acquire>
  empty = 0;
    80002b62:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002b64:	00015497          	auipc	s1,0x15
    80002b68:	a2c48493          	addi	s1,s1,-1492 # 80017590 <itable+0x18>
    80002b6c:	00016697          	auipc	a3,0x16
    80002b70:	4b468693          	addi	a3,a3,1204 # 80019020 <log>
    80002b74:	a039                	j	80002b82 <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002b76:	02090b63          	beqz	s2,80002bac <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002b7a:	08848493          	addi	s1,s1,136
    80002b7e:	02d48a63          	beq	s1,a3,80002bb2 <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80002b82:	449c                	lw	a5,8(s1)
    80002b84:	fef059e3          	blez	a5,80002b76 <iget+0x38>
    80002b88:	4098                	lw	a4,0(s1)
    80002b8a:	ff3716e3          	bne	a4,s3,80002b76 <iget+0x38>
    80002b8e:	40d8                	lw	a4,4(s1)
    80002b90:	ff4713e3          	bne	a4,s4,80002b76 <iget+0x38>
      ip->ref++;
    80002b94:	2785                	addiw	a5,a5,1
    80002b96:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    80002b98:	00015517          	auipc	a0,0x15
    80002b9c:	9e050513          	addi	a0,a0,-1568 # 80017578 <itable>
    80002ba0:	00004097          	auipc	ra,0x4
    80002ba4:	d2e080e7          	jalr	-722(ra) # 800068ce <release>
      return ip;
    80002ba8:	8926                	mv	s2,s1
    80002baa:	a03d                	j	80002bd8 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002bac:	f7f9                	bnez	a5,80002b7a <iget+0x3c>
    80002bae:	8926                	mv	s2,s1
    80002bb0:	b7e9                	j	80002b7a <iget+0x3c>
  if(empty == 0)
    80002bb2:	02090c63          	beqz	s2,80002bea <iget+0xac>
  ip->dev = dev;
    80002bb6:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80002bba:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    80002bbe:	4785                	li	a5,1
    80002bc0:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80002bc4:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    80002bc8:	00015517          	auipc	a0,0x15
    80002bcc:	9b050513          	addi	a0,a0,-1616 # 80017578 <itable>
    80002bd0:	00004097          	auipc	ra,0x4
    80002bd4:	cfe080e7          	jalr	-770(ra) # 800068ce <release>
}
    80002bd8:	854a                	mv	a0,s2
    80002bda:	70a2                	ld	ra,40(sp)
    80002bdc:	7402                	ld	s0,32(sp)
    80002bde:	64e2                	ld	s1,24(sp)
    80002be0:	6942                	ld	s2,16(sp)
    80002be2:	69a2                	ld	s3,8(sp)
    80002be4:	6a02                	ld	s4,0(sp)
    80002be6:	6145                	addi	sp,sp,48
    80002be8:	8082                	ret
    panic("iget: no inodes");
    80002bea:	00006517          	auipc	a0,0x6
    80002bee:	a0650513          	addi	a0,a0,-1530 # 800085f0 <syscalls+0x190>
    80002bf2:	00003097          	auipc	ra,0x3
    80002bf6:	6de080e7          	jalr	1758(ra) # 800062d0 <panic>

0000000080002bfa <fsinit>:
fsinit(int dev) {
    80002bfa:	7179                	addi	sp,sp,-48
    80002bfc:	f406                	sd	ra,40(sp)
    80002bfe:	f022                	sd	s0,32(sp)
    80002c00:	ec26                	sd	s1,24(sp)
    80002c02:	e84a                	sd	s2,16(sp)
    80002c04:	e44e                	sd	s3,8(sp)
    80002c06:	1800                	addi	s0,sp,48
    80002c08:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80002c0a:	4585                	li	a1,1
    80002c0c:	00000097          	auipc	ra,0x0
    80002c10:	a74080e7          	jalr	-1420(ra) # 80002680 <bread>
    80002c14:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80002c16:	00015997          	auipc	s3,0x15
    80002c1a:	94298993          	addi	s3,s3,-1726 # 80017558 <sb>
    80002c1e:	02000613          	li	a2,32
    80002c22:	05850593          	addi	a1,a0,88
    80002c26:	854e                	mv	a0,s3
    80002c28:	ffffd097          	auipc	ra,0xffffd
    80002c2c:	5b0080e7          	jalr	1456(ra) # 800001d8 <memmove>
  brelse(bp);
    80002c30:	8526                	mv	a0,s1
    80002c32:	00000097          	auipc	ra,0x0
    80002c36:	ac0080e7          	jalr	-1344(ra) # 800026f2 <brelse>
  if(sb.magic != FSMAGIC)
    80002c3a:	0009a703          	lw	a4,0(s3)
    80002c3e:	102037b7          	lui	a5,0x10203
    80002c42:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80002c46:	02f71263          	bne	a4,a5,80002c6a <fsinit+0x70>
  initlog(dev, &sb);
    80002c4a:	00015597          	auipc	a1,0x15
    80002c4e:	90e58593          	addi	a1,a1,-1778 # 80017558 <sb>
    80002c52:	854a                	mv	a0,s2
    80002c54:	00001097          	auipc	ra,0x1
    80002c58:	cc2080e7          	jalr	-830(ra) # 80003916 <initlog>
}
    80002c5c:	70a2                	ld	ra,40(sp)
    80002c5e:	7402                	ld	s0,32(sp)
    80002c60:	64e2                	ld	s1,24(sp)
    80002c62:	6942                	ld	s2,16(sp)
    80002c64:	69a2                	ld	s3,8(sp)
    80002c66:	6145                	addi	sp,sp,48
    80002c68:	8082                	ret
    panic("invalid file system");
    80002c6a:	00006517          	auipc	a0,0x6
    80002c6e:	99650513          	addi	a0,a0,-1642 # 80008600 <syscalls+0x1a0>
    80002c72:	00003097          	auipc	ra,0x3
    80002c76:	65e080e7          	jalr	1630(ra) # 800062d0 <panic>

0000000080002c7a <iinit>:
{
    80002c7a:	7179                	addi	sp,sp,-48
    80002c7c:	f406                	sd	ra,40(sp)
    80002c7e:	f022                	sd	s0,32(sp)
    80002c80:	ec26                	sd	s1,24(sp)
    80002c82:	e84a                	sd	s2,16(sp)
    80002c84:	e44e                	sd	s3,8(sp)
    80002c86:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    80002c88:	00006597          	auipc	a1,0x6
    80002c8c:	99058593          	addi	a1,a1,-1648 # 80008618 <syscalls+0x1b8>
    80002c90:	00015517          	auipc	a0,0x15
    80002c94:	8e850513          	addi	a0,a0,-1816 # 80017578 <itable>
    80002c98:	00004097          	auipc	ra,0x4
    80002c9c:	af2080e7          	jalr	-1294(ra) # 8000678a <initlock>
  for(i = 0; i < NINODE; i++) {
    80002ca0:	00015497          	auipc	s1,0x15
    80002ca4:	90048493          	addi	s1,s1,-1792 # 800175a0 <itable+0x28>
    80002ca8:	00016997          	auipc	s3,0x16
    80002cac:	38898993          	addi	s3,s3,904 # 80019030 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    80002cb0:	00006917          	auipc	s2,0x6
    80002cb4:	97090913          	addi	s2,s2,-1680 # 80008620 <syscalls+0x1c0>
    80002cb8:	85ca                	mv	a1,s2
    80002cba:	8526                	mv	a0,s1
    80002cbc:	00001097          	auipc	ra,0x1
    80002cc0:	fbc080e7          	jalr	-68(ra) # 80003c78 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80002cc4:	08848493          	addi	s1,s1,136
    80002cc8:	ff3498e3          	bne	s1,s3,80002cb8 <iinit+0x3e>
}
    80002ccc:	70a2                	ld	ra,40(sp)
    80002cce:	7402                	ld	s0,32(sp)
    80002cd0:	64e2                	ld	s1,24(sp)
    80002cd2:	6942                	ld	s2,16(sp)
    80002cd4:	69a2                	ld	s3,8(sp)
    80002cd6:	6145                	addi	sp,sp,48
    80002cd8:	8082                	ret

0000000080002cda <ialloc>:
{
    80002cda:	715d                	addi	sp,sp,-80
    80002cdc:	e486                	sd	ra,72(sp)
    80002cde:	e0a2                	sd	s0,64(sp)
    80002ce0:	fc26                	sd	s1,56(sp)
    80002ce2:	f84a                	sd	s2,48(sp)
    80002ce4:	f44e                	sd	s3,40(sp)
    80002ce6:	f052                	sd	s4,32(sp)
    80002ce8:	ec56                	sd	s5,24(sp)
    80002cea:	e85a                	sd	s6,16(sp)
    80002cec:	e45e                	sd	s7,8(sp)
    80002cee:	0880                	addi	s0,sp,80
  for(inum = 1; inum < sb.ninodes; inum++){
    80002cf0:	00015717          	auipc	a4,0x15
    80002cf4:	87472703          	lw	a4,-1932(a4) # 80017564 <sb+0xc>
    80002cf8:	4785                	li	a5,1
    80002cfa:	04e7fa63          	bgeu	a5,a4,80002d4e <ialloc+0x74>
    80002cfe:	8aaa                	mv	s5,a0
    80002d00:	8bae                	mv	s7,a1
    80002d02:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    80002d04:	00015a17          	auipc	s4,0x15
    80002d08:	854a0a13          	addi	s4,s4,-1964 # 80017558 <sb>
    80002d0c:	00048b1b          	sext.w	s6,s1
    80002d10:	0044d593          	srli	a1,s1,0x4
    80002d14:	018a2783          	lw	a5,24(s4)
    80002d18:	9dbd                	addw	a1,a1,a5
    80002d1a:	8556                	mv	a0,s5
    80002d1c:	00000097          	auipc	ra,0x0
    80002d20:	964080e7          	jalr	-1692(ra) # 80002680 <bread>
    80002d24:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80002d26:	05850993          	addi	s3,a0,88
    80002d2a:	00f4f793          	andi	a5,s1,15
    80002d2e:	079a                	slli	a5,a5,0x6
    80002d30:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    80002d32:	00099783          	lh	a5,0(s3)
    80002d36:	c785                	beqz	a5,80002d5e <ialloc+0x84>
    brelse(bp);
    80002d38:	00000097          	auipc	ra,0x0
    80002d3c:	9ba080e7          	jalr	-1606(ra) # 800026f2 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80002d40:	0485                	addi	s1,s1,1
    80002d42:	00ca2703          	lw	a4,12(s4)
    80002d46:	0004879b          	sext.w	a5,s1
    80002d4a:	fce7e1e3          	bltu	a5,a4,80002d0c <ialloc+0x32>
  panic("ialloc: no inodes");
    80002d4e:	00006517          	auipc	a0,0x6
    80002d52:	8da50513          	addi	a0,a0,-1830 # 80008628 <syscalls+0x1c8>
    80002d56:	00003097          	auipc	ra,0x3
    80002d5a:	57a080e7          	jalr	1402(ra) # 800062d0 <panic>
      memset(dip, 0, sizeof(*dip));
    80002d5e:	04000613          	li	a2,64
    80002d62:	4581                	li	a1,0
    80002d64:	854e                	mv	a0,s3
    80002d66:	ffffd097          	auipc	ra,0xffffd
    80002d6a:	412080e7          	jalr	1042(ra) # 80000178 <memset>
      dip->type = type;
    80002d6e:	01799023          	sh	s7,0(s3)
      brelse(bp);
    80002d72:	854a                	mv	a0,s2
    80002d74:	00000097          	auipc	ra,0x0
    80002d78:	97e080e7          	jalr	-1666(ra) # 800026f2 <brelse>
      return iget(dev, inum);
    80002d7c:	85da                	mv	a1,s6
    80002d7e:	8556                	mv	a0,s5
    80002d80:	00000097          	auipc	ra,0x0
    80002d84:	dbe080e7          	jalr	-578(ra) # 80002b3e <iget>
}
    80002d88:	60a6                	ld	ra,72(sp)
    80002d8a:	6406                	ld	s0,64(sp)
    80002d8c:	74e2                	ld	s1,56(sp)
    80002d8e:	7942                	ld	s2,48(sp)
    80002d90:	79a2                	ld	s3,40(sp)
    80002d92:	7a02                	ld	s4,32(sp)
    80002d94:	6ae2                	ld	s5,24(sp)
    80002d96:	6b42                	ld	s6,16(sp)
    80002d98:	6ba2                	ld	s7,8(sp)
    80002d9a:	6161                	addi	sp,sp,80
    80002d9c:	8082                	ret

0000000080002d9e <iupdate>:
{
    80002d9e:	1101                	addi	sp,sp,-32
    80002da0:	ec06                	sd	ra,24(sp)
    80002da2:	e822                	sd	s0,16(sp)
    80002da4:	e426                	sd	s1,8(sp)
    80002da6:	e04a                	sd	s2,0(sp)
    80002da8:	1000                	addi	s0,sp,32
    80002daa:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002dac:	415c                	lw	a5,4(a0)
    80002dae:	0047d79b          	srliw	a5,a5,0x4
    80002db2:	00014597          	auipc	a1,0x14
    80002db6:	7be5a583          	lw	a1,1982(a1) # 80017570 <sb+0x18>
    80002dba:	9dbd                	addw	a1,a1,a5
    80002dbc:	4108                	lw	a0,0(a0)
    80002dbe:	00000097          	auipc	ra,0x0
    80002dc2:	8c2080e7          	jalr	-1854(ra) # 80002680 <bread>
    80002dc6:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002dc8:	05850793          	addi	a5,a0,88
    80002dcc:	40d8                	lw	a4,4(s1)
    80002dce:	8b3d                	andi	a4,a4,15
    80002dd0:	071a                	slli	a4,a4,0x6
    80002dd2:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    80002dd4:	04449703          	lh	a4,68(s1)
    80002dd8:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80002ddc:	04649703          	lh	a4,70(s1)
    80002de0:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80002de4:	04849703          	lh	a4,72(s1)
    80002de8:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80002dec:	04a49703          	lh	a4,74(s1)
    80002df0:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80002df4:	44f8                	lw	a4,76(s1)
    80002df6:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002df8:	03400613          	li	a2,52
    80002dfc:	05048593          	addi	a1,s1,80
    80002e00:	00c78513          	addi	a0,a5,12
    80002e04:	ffffd097          	auipc	ra,0xffffd
    80002e08:	3d4080e7          	jalr	980(ra) # 800001d8 <memmove>
  brelse(bp);
    80002e0c:	854a                	mv	a0,s2
    80002e0e:	00000097          	auipc	ra,0x0
    80002e12:	8e4080e7          	jalr	-1820(ra) # 800026f2 <brelse>
}
    80002e16:	60e2                	ld	ra,24(sp)
    80002e18:	6442                	ld	s0,16(sp)
    80002e1a:	64a2                	ld	s1,8(sp)
    80002e1c:	6902                	ld	s2,0(sp)
    80002e1e:	6105                	addi	sp,sp,32
    80002e20:	8082                	ret

0000000080002e22 <idup>:
{
    80002e22:	1101                	addi	sp,sp,-32
    80002e24:	ec06                	sd	ra,24(sp)
    80002e26:	e822                	sd	s0,16(sp)
    80002e28:	e426                	sd	s1,8(sp)
    80002e2a:	1000                	addi	s0,sp,32
    80002e2c:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002e2e:	00014517          	auipc	a0,0x14
    80002e32:	74a50513          	addi	a0,a0,1866 # 80017578 <itable>
    80002e36:	00004097          	auipc	ra,0x4
    80002e3a:	9e4080e7          	jalr	-1564(ra) # 8000681a <acquire>
  ip->ref++;
    80002e3e:	449c                	lw	a5,8(s1)
    80002e40:	2785                	addiw	a5,a5,1
    80002e42:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002e44:	00014517          	auipc	a0,0x14
    80002e48:	73450513          	addi	a0,a0,1844 # 80017578 <itable>
    80002e4c:	00004097          	auipc	ra,0x4
    80002e50:	a82080e7          	jalr	-1406(ra) # 800068ce <release>
}
    80002e54:	8526                	mv	a0,s1
    80002e56:	60e2                	ld	ra,24(sp)
    80002e58:	6442                	ld	s0,16(sp)
    80002e5a:	64a2                	ld	s1,8(sp)
    80002e5c:	6105                	addi	sp,sp,32
    80002e5e:	8082                	ret

0000000080002e60 <ilock>:
{
    80002e60:	1101                	addi	sp,sp,-32
    80002e62:	ec06                	sd	ra,24(sp)
    80002e64:	e822                	sd	s0,16(sp)
    80002e66:	e426                	sd	s1,8(sp)
    80002e68:	e04a                	sd	s2,0(sp)
    80002e6a:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80002e6c:	c115                	beqz	a0,80002e90 <ilock+0x30>
    80002e6e:	84aa                	mv	s1,a0
    80002e70:	451c                	lw	a5,8(a0)
    80002e72:	00f05f63          	blez	a5,80002e90 <ilock+0x30>
  acquiresleep(&ip->lock);
    80002e76:	0541                	addi	a0,a0,16
    80002e78:	00001097          	auipc	ra,0x1
    80002e7c:	e3a080e7          	jalr	-454(ra) # 80003cb2 <acquiresleep>
  if(ip->valid == 0){
    80002e80:	40bc                	lw	a5,64(s1)
    80002e82:	cf99                	beqz	a5,80002ea0 <ilock+0x40>
}
    80002e84:	60e2                	ld	ra,24(sp)
    80002e86:	6442                	ld	s0,16(sp)
    80002e88:	64a2                	ld	s1,8(sp)
    80002e8a:	6902                	ld	s2,0(sp)
    80002e8c:	6105                	addi	sp,sp,32
    80002e8e:	8082                	ret
    panic("ilock");
    80002e90:	00005517          	auipc	a0,0x5
    80002e94:	7b050513          	addi	a0,a0,1968 # 80008640 <syscalls+0x1e0>
    80002e98:	00003097          	auipc	ra,0x3
    80002e9c:	438080e7          	jalr	1080(ra) # 800062d0 <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002ea0:	40dc                	lw	a5,4(s1)
    80002ea2:	0047d79b          	srliw	a5,a5,0x4
    80002ea6:	00014597          	auipc	a1,0x14
    80002eaa:	6ca5a583          	lw	a1,1738(a1) # 80017570 <sb+0x18>
    80002eae:	9dbd                	addw	a1,a1,a5
    80002eb0:	4088                	lw	a0,0(s1)
    80002eb2:	fffff097          	auipc	ra,0xfffff
    80002eb6:	7ce080e7          	jalr	1998(ra) # 80002680 <bread>
    80002eba:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002ebc:	05850593          	addi	a1,a0,88
    80002ec0:	40dc                	lw	a5,4(s1)
    80002ec2:	8bbd                	andi	a5,a5,15
    80002ec4:	079a                	slli	a5,a5,0x6
    80002ec6:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80002ec8:	00059783          	lh	a5,0(a1)
    80002ecc:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80002ed0:	00259783          	lh	a5,2(a1)
    80002ed4:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80002ed8:	00459783          	lh	a5,4(a1)
    80002edc:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80002ee0:	00659783          	lh	a5,6(a1)
    80002ee4:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80002ee8:	459c                	lw	a5,8(a1)
    80002eea:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002eec:	03400613          	li	a2,52
    80002ef0:	05b1                	addi	a1,a1,12
    80002ef2:	05048513          	addi	a0,s1,80
    80002ef6:	ffffd097          	auipc	ra,0xffffd
    80002efa:	2e2080e7          	jalr	738(ra) # 800001d8 <memmove>
    brelse(bp);
    80002efe:	854a                	mv	a0,s2
    80002f00:	fffff097          	auipc	ra,0xfffff
    80002f04:	7f2080e7          	jalr	2034(ra) # 800026f2 <brelse>
    ip->valid = 1;
    80002f08:	4785                	li	a5,1
    80002f0a:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80002f0c:	04449783          	lh	a5,68(s1)
    80002f10:	fbb5                	bnez	a5,80002e84 <ilock+0x24>
      panic("ilock: no type");
    80002f12:	00005517          	auipc	a0,0x5
    80002f16:	73650513          	addi	a0,a0,1846 # 80008648 <syscalls+0x1e8>
    80002f1a:	00003097          	auipc	ra,0x3
    80002f1e:	3b6080e7          	jalr	950(ra) # 800062d0 <panic>

0000000080002f22 <iunlock>:
{
    80002f22:	1101                	addi	sp,sp,-32
    80002f24:	ec06                	sd	ra,24(sp)
    80002f26:	e822                	sd	s0,16(sp)
    80002f28:	e426                	sd	s1,8(sp)
    80002f2a:	e04a                	sd	s2,0(sp)
    80002f2c:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80002f2e:	c905                	beqz	a0,80002f5e <iunlock+0x3c>
    80002f30:	84aa                	mv	s1,a0
    80002f32:	01050913          	addi	s2,a0,16
    80002f36:	854a                	mv	a0,s2
    80002f38:	00001097          	auipc	ra,0x1
    80002f3c:	e14080e7          	jalr	-492(ra) # 80003d4c <holdingsleep>
    80002f40:	cd19                	beqz	a0,80002f5e <iunlock+0x3c>
    80002f42:	449c                	lw	a5,8(s1)
    80002f44:	00f05d63          	blez	a5,80002f5e <iunlock+0x3c>
  releasesleep(&ip->lock);
    80002f48:	854a                	mv	a0,s2
    80002f4a:	00001097          	auipc	ra,0x1
    80002f4e:	dbe080e7          	jalr	-578(ra) # 80003d08 <releasesleep>
}
    80002f52:	60e2                	ld	ra,24(sp)
    80002f54:	6442                	ld	s0,16(sp)
    80002f56:	64a2                	ld	s1,8(sp)
    80002f58:	6902                	ld	s2,0(sp)
    80002f5a:	6105                	addi	sp,sp,32
    80002f5c:	8082                	ret
    panic("iunlock");
    80002f5e:	00005517          	auipc	a0,0x5
    80002f62:	6fa50513          	addi	a0,a0,1786 # 80008658 <syscalls+0x1f8>
    80002f66:	00003097          	auipc	ra,0x3
    80002f6a:	36a080e7          	jalr	874(ra) # 800062d0 <panic>

0000000080002f6e <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80002f6e:	7179                	addi	sp,sp,-48
    80002f70:	f406                	sd	ra,40(sp)
    80002f72:	f022                	sd	s0,32(sp)
    80002f74:	ec26                	sd	s1,24(sp)
    80002f76:	e84a                	sd	s2,16(sp)
    80002f78:	e44e                	sd	s3,8(sp)
    80002f7a:	e052                	sd	s4,0(sp)
    80002f7c:	1800                	addi	s0,sp,48
    80002f7e:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80002f80:	05050493          	addi	s1,a0,80
    80002f84:	08050913          	addi	s2,a0,128
    80002f88:	a021                	j	80002f90 <itrunc+0x22>
    80002f8a:	0491                	addi	s1,s1,4
    80002f8c:	01248d63          	beq	s1,s2,80002fa6 <itrunc+0x38>
    if(ip->addrs[i]){
    80002f90:	408c                	lw	a1,0(s1)
    80002f92:	dde5                	beqz	a1,80002f8a <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    80002f94:	0009a503          	lw	a0,0(s3)
    80002f98:	00000097          	auipc	ra,0x0
    80002f9c:	932080e7          	jalr	-1742(ra) # 800028ca <bfree>
      ip->addrs[i] = 0;
    80002fa0:	0004a023          	sw	zero,0(s1)
    80002fa4:	b7dd                	j	80002f8a <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    80002fa6:	0809a583          	lw	a1,128(s3)
    80002faa:	e185                	bnez	a1,80002fca <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80002fac:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80002fb0:	854e                	mv	a0,s3
    80002fb2:	00000097          	auipc	ra,0x0
    80002fb6:	dec080e7          	jalr	-532(ra) # 80002d9e <iupdate>
}
    80002fba:	70a2                	ld	ra,40(sp)
    80002fbc:	7402                	ld	s0,32(sp)
    80002fbe:	64e2                	ld	s1,24(sp)
    80002fc0:	6942                	ld	s2,16(sp)
    80002fc2:	69a2                	ld	s3,8(sp)
    80002fc4:	6a02                	ld	s4,0(sp)
    80002fc6:	6145                	addi	sp,sp,48
    80002fc8:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80002fca:	0009a503          	lw	a0,0(s3)
    80002fce:	fffff097          	auipc	ra,0xfffff
    80002fd2:	6b2080e7          	jalr	1714(ra) # 80002680 <bread>
    80002fd6:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80002fd8:	05850493          	addi	s1,a0,88
    80002fdc:	45850913          	addi	s2,a0,1112
    80002fe0:	a811                	j	80002ff4 <itrunc+0x86>
        bfree(ip->dev, a[j]);
    80002fe2:	0009a503          	lw	a0,0(s3)
    80002fe6:	00000097          	auipc	ra,0x0
    80002fea:	8e4080e7          	jalr	-1820(ra) # 800028ca <bfree>
    for(j = 0; j < NINDIRECT; j++){
    80002fee:	0491                	addi	s1,s1,4
    80002ff0:	01248563          	beq	s1,s2,80002ffa <itrunc+0x8c>
      if(a[j])
    80002ff4:	408c                	lw	a1,0(s1)
    80002ff6:	dde5                	beqz	a1,80002fee <itrunc+0x80>
    80002ff8:	b7ed                	j	80002fe2 <itrunc+0x74>
    brelse(bp);
    80002ffa:	8552                	mv	a0,s4
    80002ffc:	fffff097          	auipc	ra,0xfffff
    80003000:	6f6080e7          	jalr	1782(ra) # 800026f2 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80003004:	0809a583          	lw	a1,128(s3)
    80003008:	0009a503          	lw	a0,0(s3)
    8000300c:	00000097          	auipc	ra,0x0
    80003010:	8be080e7          	jalr	-1858(ra) # 800028ca <bfree>
    ip->addrs[NDIRECT] = 0;
    80003014:	0809a023          	sw	zero,128(s3)
    80003018:	bf51                	j	80002fac <itrunc+0x3e>

000000008000301a <iput>:
{
    8000301a:	1101                	addi	sp,sp,-32
    8000301c:	ec06                	sd	ra,24(sp)
    8000301e:	e822                	sd	s0,16(sp)
    80003020:	e426                	sd	s1,8(sp)
    80003022:	e04a                	sd	s2,0(sp)
    80003024:	1000                	addi	s0,sp,32
    80003026:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80003028:	00014517          	auipc	a0,0x14
    8000302c:	55050513          	addi	a0,a0,1360 # 80017578 <itable>
    80003030:	00003097          	auipc	ra,0x3
    80003034:	7ea080e7          	jalr	2026(ra) # 8000681a <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80003038:	4498                	lw	a4,8(s1)
    8000303a:	4785                	li	a5,1
    8000303c:	02f70363          	beq	a4,a5,80003062 <iput+0x48>
  ip->ref--;
    80003040:	449c                	lw	a5,8(s1)
    80003042:	37fd                	addiw	a5,a5,-1
    80003044:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80003046:	00014517          	auipc	a0,0x14
    8000304a:	53250513          	addi	a0,a0,1330 # 80017578 <itable>
    8000304e:	00004097          	auipc	ra,0x4
    80003052:	880080e7          	jalr	-1920(ra) # 800068ce <release>
}
    80003056:	60e2                	ld	ra,24(sp)
    80003058:	6442                	ld	s0,16(sp)
    8000305a:	64a2                	ld	s1,8(sp)
    8000305c:	6902                	ld	s2,0(sp)
    8000305e:	6105                	addi	sp,sp,32
    80003060:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80003062:	40bc                	lw	a5,64(s1)
    80003064:	dff1                	beqz	a5,80003040 <iput+0x26>
    80003066:	04a49783          	lh	a5,74(s1)
    8000306a:	fbf9                	bnez	a5,80003040 <iput+0x26>
    acquiresleep(&ip->lock);
    8000306c:	01048913          	addi	s2,s1,16
    80003070:	854a                	mv	a0,s2
    80003072:	00001097          	auipc	ra,0x1
    80003076:	c40080e7          	jalr	-960(ra) # 80003cb2 <acquiresleep>
    release(&itable.lock);
    8000307a:	00014517          	auipc	a0,0x14
    8000307e:	4fe50513          	addi	a0,a0,1278 # 80017578 <itable>
    80003082:	00004097          	auipc	ra,0x4
    80003086:	84c080e7          	jalr	-1972(ra) # 800068ce <release>
    itrunc(ip);
    8000308a:	8526                	mv	a0,s1
    8000308c:	00000097          	auipc	ra,0x0
    80003090:	ee2080e7          	jalr	-286(ra) # 80002f6e <itrunc>
    ip->type = 0;
    80003094:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80003098:	8526                	mv	a0,s1
    8000309a:	00000097          	auipc	ra,0x0
    8000309e:	d04080e7          	jalr	-764(ra) # 80002d9e <iupdate>
    ip->valid = 0;
    800030a2:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    800030a6:	854a                	mv	a0,s2
    800030a8:	00001097          	auipc	ra,0x1
    800030ac:	c60080e7          	jalr	-928(ra) # 80003d08 <releasesleep>
    acquire(&itable.lock);
    800030b0:	00014517          	auipc	a0,0x14
    800030b4:	4c850513          	addi	a0,a0,1224 # 80017578 <itable>
    800030b8:	00003097          	auipc	ra,0x3
    800030bc:	762080e7          	jalr	1890(ra) # 8000681a <acquire>
    800030c0:	b741                	j	80003040 <iput+0x26>

00000000800030c2 <iunlockput>:
{
    800030c2:	1101                	addi	sp,sp,-32
    800030c4:	ec06                	sd	ra,24(sp)
    800030c6:	e822                	sd	s0,16(sp)
    800030c8:	e426                	sd	s1,8(sp)
    800030ca:	1000                	addi	s0,sp,32
    800030cc:	84aa                	mv	s1,a0
  iunlock(ip);
    800030ce:	00000097          	auipc	ra,0x0
    800030d2:	e54080e7          	jalr	-428(ra) # 80002f22 <iunlock>
  iput(ip);
    800030d6:	8526                	mv	a0,s1
    800030d8:	00000097          	auipc	ra,0x0
    800030dc:	f42080e7          	jalr	-190(ra) # 8000301a <iput>
}
    800030e0:	60e2                	ld	ra,24(sp)
    800030e2:	6442                	ld	s0,16(sp)
    800030e4:	64a2                	ld	s1,8(sp)
    800030e6:	6105                	addi	sp,sp,32
    800030e8:	8082                	ret

00000000800030ea <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    800030ea:	1141                	addi	sp,sp,-16
    800030ec:	e422                	sd	s0,8(sp)
    800030ee:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    800030f0:	411c                	lw	a5,0(a0)
    800030f2:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    800030f4:	415c                	lw	a5,4(a0)
    800030f6:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    800030f8:	04451783          	lh	a5,68(a0)
    800030fc:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80003100:	04a51783          	lh	a5,74(a0)
    80003104:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80003108:	04c56783          	lwu	a5,76(a0)
    8000310c:	e99c                	sd	a5,16(a1)
}
    8000310e:	6422                	ld	s0,8(sp)
    80003110:	0141                	addi	sp,sp,16
    80003112:	8082                	ret

0000000080003114 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003114:	457c                	lw	a5,76(a0)
    80003116:	0ed7e963          	bltu	a5,a3,80003208 <readi+0xf4>
{
    8000311a:	7159                	addi	sp,sp,-112
    8000311c:	f486                	sd	ra,104(sp)
    8000311e:	f0a2                	sd	s0,96(sp)
    80003120:	eca6                	sd	s1,88(sp)
    80003122:	e8ca                	sd	s2,80(sp)
    80003124:	e4ce                	sd	s3,72(sp)
    80003126:	e0d2                	sd	s4,64(sp)
    80003128:	fc56                	sd	s5,56(sp)
    8000312a:	f85a                	sd	s6,48(sp)
    8000312c:	f45e                	sd	s7,40(sp)
    8000312e:	f062                	sd	s8,32(sp)
    80003130:	ec66                	sd	s9,24(sp)
    80003132:	e86a                	sd	s10,16(sp)
    80003134:	e46e                	sd	s11,8(sp)
    80003136:	1880                	addi	s0,sp,112
    80003138:	8baa                	mv	s7,a0
    8000313a:	8c2e                	mv	s8,a1
    8000313c:	8ab2                	mv	s5,a2
    8000313e:	84b6                	mv	s1,a3
    80003140:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80003142:	9f35                	addw	a4,a4,a3
    return 0;
    80003144:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80003146:	0ad76063          	bltu	a4,a3,800031e6 <readi+0xd2>
  if(off + n > ip->size)
    8000314a:	00e7f463          	bgeu	a5,a4,80003152 <readi+0x3e>
    n = ip->size - off;
    8000314e:	40d78b3b          	subw	s6,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003152:	0a0b0963          	beqz	s6,80003204 <readi+0xf0>
    80003156:	4981                	li	s3,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80003158:	40000d13          	li	s10,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    8000315c:	5cfd                	li	s9,-1
    8000315e:	a82d                	j	80003198 <readi+0x84>
    80003160:	020a1d93          	slli	s11,s4,0x20
    80003164:	020ddd93          	srli	s11,s11,0x20
    80003168:	05890613          	addi	a2,s2,88
    8000316c:	86ee                	mv	a3,s11
    8000316e:	963a                	add	a2,a2,a4
    80003170:	85d6                	mv	a1,s5
    80003172:	8562                	mv	a0,s8
    80003174:	fffff097          	auipc	ra,0xfffff
    80003178:	a4c080e7          	jalr	-1460(ra) # 80001bc0 <either_copyout>
    8000317c:	05950d63          	beq	a0,s9,800031d6 <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80003180:	854a                	mv	a0,s2
    80003182:	fffff097          	auipc	ra,0xfffff
    80003186:	570080e7          	jalr	1392(ra) # 800026f2 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    8000318a:	013a09bb          	addw	s3,s4,s3
    8000318e:	009a04bb          	addw	s1,s4,s1
    80003192:	9aee                	add	s5,s5,s11
    80003194:	0569f763          	bgeu	s3,s6,800031e2 <readi+0xce>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80003198:	000ba903          	lw	s2,0(s7)
    8000319c:	00a4d59b          	srliw	a1,s1,0xa
    800031a0:	855e                	mv	a0,s7
    800031a2:	00000097          	auipc	ra,0x0
    800031a6:	8cc080e7          	jalr	-1844(ra) # 80002a6e <bmap>
    800031aa:	0005059b          	sext.w	a1,a0
    800031ae:	854a                	mv	a0,s2
    800031b0:	fffff097          	auipc	ra,0xfffff
    800031b4:	4d0080e7          	jalr	1232(ra) # 80002680 <bread>
    800031b8:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    800031ba:	3ff4f713          	andi	a4,s1,1023
    800031be:	40ed07bb          	subw	a5,s10,a4
    800031c2:	413b06bb          	subw	a3,s6,s3
    800031c6:	8a3e                	mv	s4,a5
    800031c8:	2781                	sext.w	a5,a5
    800031ca:	0006861b          	sext.w	a2,a3
    800031ce:	f8f679e3          	bgeu	a2,a5,80003160 <readi+0x4c>
    800031d2:	8a36                	mv	s4,a3
    800031d4:	b771                	j	80003160 <readi+0x4c>
      brelse(bp);
    800031d6:	854a                	mv	a0,s2
    800031d8:	fffff097          	auipc	ra,0xfffff
    800031dc:	51a080e7          	jalr	1306(ra) # 800026f2 <brelse>
      tot = -1;
    800031e0:	59fd                	li	s3,-1
  }
  return tot;
    800031e2:	0009851b          	sext.w	a0,s3
}
    800031e6:	70a6                	ld	ra,104(sp)
    800031e8:	7406                	ld	s0,96(sp)
    800031ea:	64e6                	ld	s1,88(sp)
    800031ec:	6946                	ld	s2,80(sp)
    800031ee:	69a6                	ld	s3,72(sp)
    800031f0:	6a06                	ld	s4,64(sp)
    800031f2:	7ae2                	ld	s5,56(sp)
    800031f4:	7b42                	ld	s6,48(sp)
    800031f6:	7ba2                	ld	s7,40(sp)
    800031f8:	7c02                	ld	s8,32(sp)
    800031fa:	6ce2                	ld	s9,24(sp)
    800031fc:	6d42                	ld	s10,16(sp)
    800031fe:	6da2                	ld	s11,8(sp)
    80003200:	6165                	addi	sp,sp,112
    80003202:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003204:	89da                	mv	s3,s6
    80003206:	bff1                	j	800031e2 <readi+0xce>
    return 0;
    80003208:	4501                	li	a0,0
}
    8000320a:	8082                	ret

000000008000320c <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    8000320c:	457c                	lw	a5,76(a0)
    8000320e:	10d7e363          	bltu	a5,a3,80003314 <writei+0x108>
{
    80003212:	7159                	addi	sp,sp,-112
    80003214:	f486                	sd	ra,104(sp)
    80003216:	f0a2                	sd	s0,96(sp)
    80003218:	eca6                	sd	s1,88(sp)
    8000321a:	e8ca                	sd	s2,80(sp)
    8000321c:	e4ce                	sd	s3,72(sp)
    8000321e:	e0d2                	sd	s4,64(sp)
    80003220:	fc56                	sd	s5,56(sp)
    80003222:	f85a                	sd	s6,48(sp)
    80003224:	f45e                	sd	s7,40(sp)
    80003226:	f062                	sd	s8,32(sp)
    80003228:	ec66                	sd	s9,24(sp)
    8000322a:	e86a                	sd	s10,16(sp)
    8000322c:	e46e                	sd	s11,8(sp)
    8000322e:	1880                	addi	s0,sp,112
    80003230:	8b2a                	mv	s6,a0
    80003232:	8c2e                	mv	s8,a1
    80003234:	8ab2                	mv	s5,a2
    80003236:	8936                	mv	s2,a3
    80003238:	8bba                	mv	s7,a4
  if(off > ip->size || off + n < off)
    8000323a:	00e687bb          	addw	a5,a3,a4
    8000323e:	0cd7ed63          	bltu	a5,a3,80003318 <writei+0x10c>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80003242:	00043737          	lui	a4,0x43
    80003246:	0cf76b63          	bltu	a4,a5,8000331c <writei+0x110>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    8000324a:	0c0b8363          	beqz	s7,80003310 <writei+0x104>
    8000324e:	4a01                	li	s4,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80003250:	40000d13          	li	s10,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80003254:	5cfd                	li	s9,-1
    80003256:	a82d                	j	80003290 <writei+0x84>
    80003258:	02099d93          	slli	s11,s3,0x20
    8000325c:	020ddd93          	srli	s11,s11,0x20
    80003260:	05848513          	addi	a0,s1,88
    80003264:	86ee                	mv	a3,s11
    80003266:	8656                	mv	a2,s5
    80003268:	85e2                	mv	a1,s8
    8000326a:	953a                	add	a0,a0,a4
    8000326c:	fffff097          	auipc	ra,0xfffff
    80003270:	9aa080e7          	jalr	-1622(ra) # 80001c16 <either_copyin>
    80003274:	05950d63          	beq	a0,s9,800032ce <writei+0xc2>
      brelse(bp);
      break;
    }
    //log_write(bp);
    brelse(bp);
    80003278:	8526                	mv	a0,s1
    8000327a:	fffff097          	auipc	ra,0xfffff
    8000327e:	478080e7          	jalr	1144(ra) # 800026f2 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003282:	01498a3b          	addw	s4,s3,s4
    80003286:	0129893b          	addw	s2,s3,s2
    8000328a:	9aee                	add	s5,s5,s11
    8000328c:	057a7663          	bgeu	s4,s7,800032d8 <writei+0xcc>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80003290:	000b2483          	lw	s1,0(s6)
    80003294:	00a9559b          	srliw	a1,s2,0xa
    80003298:	855a                	mv	a0,s6
    8000329a:	fffff097          	auipc	ra,0xfffff
    8000329e:	7d4080e7          	jalr	2004(ra) # 80002a6e <bmap>
    800032a2:	0005059b          	sext.w	a1,a0
    800032a6:	8526                	mv	a0,s1
    800032a8:	fffff097          	auipc	ra,0xfffff
    800032ac:	3d8080e7          	jalr	984(ra) # 80002680 <bread>
    800032b0:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    800032b2:	3ff97713          	andi	a4,s2,1023
    800032b6:	40ed07bb          	subw	a5,s10,a4
    800032ba:	414b86bb          	subw	a3,s7,s4
    800032be:	89be                	mv	s3,a5
    800032c0:	2781                	sext.w	a5,a5
    800032c2:	0006861b          	sext.w	a2,a3
    800032c6:	f8f679e3          	bgeu	a2,a5,80003258 <writei+0x4c>
    800032ca:	89b6                	mv	s3,a3
    800032cc:	b771                	j	80003258 <writei+0x4c>
      brelse(bp);
    800032ce:	8526                	mv	a0,s1
    800032d0:	fffff097          	auipc	ra,0xfffff
    800032d4:	422080e7          	jalr	1058(ra) # 800026f2 <brelse>
  }

  if(off > ip->size)
    800032d8:	04cb2783          	lw	a5,76(s6)
    800032dc:	0127f463          	bgeu	a5,s2,800032e4 <writei+0xd8>
    ip->size = off;
    800032e0:	052b2623          	sw	s2,76(s6)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    800032e4:	855a                	mv	a0,s6
    800032e6:	00000097          	auipc	ra,0x0
    800032ea:	ab8080e7          	jalr	-1352(ra) # 80002d9e <iupdate>

  return tot;
    800032ee:	000a051b          	sext.w	a0,s4
}
    800032f2:	70a6                	ld	ra,104(sp)
    800032f4:	7406                	ld	s0,96(sp)
    800032f6:	64e6                	ld	s1,88(sp)
    800032f8:	6946                	ld	s2,80(sp)
    800032fa:	69a6                	ld	s3,72(sp)
    800032fc:	6a06                	ld	s4,64(sp)
    800032fe:	7ae2                	ld	s5,56(sp)
    80003300:	7b42                	ld	s6,48(sp)
    80003302:	7ba2                	ld	s7,40(sp)
    80003304:	7c02                	ld	s8,32(sp)
    80003306:	6ce2                	ld	s9,24(sp)
    80003308:	6d42                	ld	s10,16(sp)
    8000330a:	6da2                	ld	s11,8(sp)
    8000330c:	6165                	addi	sp,sp,112
    8000330e:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003310:	8a5e                	mv	s4,s7
    80003312:	bfc9                	j	800032e4 <writei+0xd8>
    return -1;
    80003314:	557d                	li	a0,-1
}
    80003316:	8082                	ret
    return -1;
    80003318:	557d                	li	a0,-1
    8000331a:	bfe1                	j	800032f2 <writei+0xe6>
    return -1;
    8000331c:	557d                	li	a0,-1
    8000331e:	bfd1                	j	800032f2 <writei+0xe6>

0000000080003320 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80003320:	1141                	addi	sp,sp,-16
    80003322:	e406                	sd	ra,8(sp)
    80003324:	e022                	sd	s0,0(sp)
    80003326:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80003328:	4639                	li	a2,14
    8000332a:	ffffd097          	auipc	ra,0xffffd
    8000332e:	f26080e7          	jalr	-218(ra) # 80000250 <strncmp>
}
    80003332:	60a2                	ld	ra,8(sp)
    80003334:	6402                	ld	s0,0(sp)
    80003336:	0141                	addi	sp,sp,16
    80003338:	8082                	ret

000000008000333a <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    8000333a:	7139                	addi	sp,sp,-64
    8000333c:	fc06                	sd	ra,56(sp)
    8000333e:	f822                	sd	s0,48(sp)
    80003340:	f426                	sd	s1,40(sp)
    80003342:	f04a                	sd	s2,32(sp)
    80003344:	ec4e                	sd	s3,24(sp)
    80003346:	e852                	sd	s4,16(sp)
    80003348:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    8000334a:	04451703          	lh	a4,68(a0)
    8000334e:	4785                	li	a5,1
    80003350:	00f71a63          	bne	a4,a5,80003364 <dirlookup+0x2a>
    80003354:	892a                	mv	s2,a0
    80003356:	89ae                	mv	s3,a1
    80003358:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    8000335a:	457c                	lw	a5,76(a0)
    8000335c:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    8000335e:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003360:	e79d                	bnez	a5,8000338e <dirlookup+0x54>
    80003362:	a8a5                	j	800033da <dirlookup+0xa0>
    panic("dirlookup not DIR");
    80003364:	00005517          	auipc	a0,0x5
    80003368:	2fc50513          	addi	a0,a0,764 # 80008660 <syscalls+0x200>
    8000336c:	00003097          	auipc	ra,0x3
    80003370:	f64080e7          	jalr	-156(ra) # 800062d0 <panic>
      panic("dirlookup read");
    80003374:	00005517          	auipc	a0,0x5
    80003378:	30450513          	addi	a0,a0,772 # 80008678 <syscalls+0x218>
    8000337c:	00003097          	auipc	ra,0x3
    80003380:	f54080e7          	jalr	-172(ra) # 800062d0 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003384:	24c1                	addiw	s1,s1,16
    80003386:	04c92783          	lw	a5,76(s2)
    8000338a:	04f4f763          	bgeu	s1,a5,800033d8 <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000338e:	4741                	li	a4,16
    80003390:	86a6                	mv	a3,s1
    80003392:	fc040613          	addi	a2,s0,-64
    80003396:	4581                	li	a1,0
    80003398:	854a                	mv	a0,s2
    8000339a:	00000097          	auipc	ra,0x0
    8000339e:	d7a080e7          	jalr	-646(ra) # 80003114 <readi>
    800033a2:	47c1                	li	a5,16
    800033a4:	fcf518e3          	bne	a0,a5,80003374 <dirlookup+0x3a>
    if(de.inum == 0)
    800033a8:	fc045783          	lhu	a5,-64(s0)
    800033ac:	dfe1                	beqz	a5,80003384 <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    800033ae:	fc240593          	addi	a1,s0,-62
    800033b2:	854e                	mv	a0,s3
    800033b4:	00000097          	auipc	ra,0x0
    800033b8:	f6c080e7          	jalr	-148(ra) # 80003320 <namecmp>
    800033bc:	f561                	bnez	a0,80003384 <dirlookup+0x4a>
      if(poff)
    800033be:	000a0463          	beqz	s4,800033c6 <dirlookup+0x8c>
        *poff = off;
    800033c2:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    800033c6:	fc045583          	lhu	a1,-64(s0)
    800033ca:	00092503          	lw	a0,0(s2)
    800033ce:	fffff097          	auipc	ra,0xfffff
    800033d2:	770080e7          	jalr	1904(ra) # 80002b3e <iget>
    800033d6:	a011                	j	800033da <dirlookup+0xa0>
  return 0;
    800033d8:	4501                	li	a0,0
}
    800033da:	70e2                	ld	ra,56(sp)
    800033dc:	7442                	ld	s0,48(sp)
    800033de:	74a2                	ld	s1,40(sp)
    800033e0:	7902                	ld	s2,32(sp)
    800033e2:	69e2                	ld	s3,24(sp)
    800033e4:	6a42                	ld	s4,16(sp)
    800033e6:	6121                	addi	sp,sp,64
    800033e8:	8082                	ret

00000000800033ea <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    800033ea:	711d                	addi	sp,sp,-96
    800033ec:	ec86                	sd	ra,88(sp)
    800033ee:	e8a2                	sd	s0,80(sp)
    800033f0:	e4a6                	sd	s1,72(sp)
    800033f2:	e0ca                	sd	s2,64(sp)
    800033f4:	fc4e                	sd	s3,56(sp)
    800033f6:	f852                	sd	s4,48(sp)
    800033f8:	f456                	sd	s5,40(sp)
    800033fa:	f05a                	sd	s6,32(sp)
    800033fc:	ec5e                	sd	s7,24(sp)
    800033fe:	e862                	sd	s8,16(sp)
    80003400:	e466                	sd	s9,8(sp)
    80003402:	1080                	addi	s0,sp,96
    80003404:	84aa                	mv	s1,a0
    80003406:	8b2e                	mv	s6,a1
    80003408:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    8000340a:	00054703          	lbu	a4,0(a0)
    8000340e:	02f00793          	li	a5,47
    80003412:	02f70363          	beq	a4,a5,80003438 <namex+0x4e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80003416:	ffffe097          	auipc	ra,0xffffe
    8000341a:	d4a080e7          	jalr	-694(ra) # 80001160 <myproc>
    8000341e:	15053503          	ld	a0,336(a0)
    80003422:	00000097          	auipc	ra,0x0
    80003426:	a00080e7          	jalr	-1536(ra) # 80002e22 <idup>
    8000342a:	89aa                	mv	s3,a0
  while(*path == '/')
    8000342c:	02f00913          	li	s2,47
  len = path - s;
    80003430:	4b81                	li	s7,0
  if(len >= DIRSIZ)
    80003432:	4cb5                	li	s9,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80003434:	4c05                	li	s8,1
    80003436:	a865                	j	800034ee <namex+0x104>
    ip = iget(ROOTDEV, ROOTINO);
    80003438:	4585                	li	a1,1
    8000343a:	4505                	li	a0,1
    8000343c:	fffff097          	auipc	ra,0xfffff
    80003440:	702080e7          	jalr	1794(ra) # 80002b3e <iget>
    80003444:	89aa                	mv	s3,a0
    80003446:	b7dd                	j	8000342c <namex+0x42>
      iunlockput(ip);
    80003448:	854e                	mv	a0,s3
    8000344a:	00000097          	auipc	ra,0x0
    8000344e:	c78080e7          	jalr	-904(ra) # 800030c2 <iunlockput>
      return 0;
    80003452:	4981                	li	s3,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80003454:	854e                	mv	a0,s3
    80003456:	60e6                	ld	ra,88(sp)
    80003458:	6446                	ld	s0,80(sp)
    8000345a:	64a6                	ld	s1,72(sp)
    8000345c:	6906                	ld	s2,64(sp)
    8000345e:	79e2                	ld	s3,56(sp)
    80003460:	7a42                	ld	s4,48(sp)
    80003462:	7aa2                	ld	s5,40(sp)
    80003464:	7b02                	ld	s6,32(sp)
    80003466:	6be2                	ld	s7,24(sp)
    80003468:	6c42                	ld	s8,16(sp)
    8000346a:	6ca2                	ld	s9,8(sp)
    8000346c:	6125                	addi	sp,sp,96
    8000346e:	8082                	ret
      iunlock(ip);
    80003470:	854e                	mv	a0,s3
    80003472:	00000097          	auipc	ra,0x0
    80003476:	ab0080e7          	jalr	-1360(ra) # 80002f22 <iunlock>
      return ip;
    8000347a:	bfe9                	j	80003454 <namex+0x6a>
      iunlockput(ip);
    8000347c:	854e                	mv	a0,s3
    8000347e:	00000097          	auipc	ra,0x0
    80003482:	c44080e7          	jalr	-956(ra) # 800030c2 <iunlockput>
      return 0;
    80003486:	89d2                	mv	s3,s4
    80003488:	b7f1                	j	80003454 <namex+0x6a>
  len = path - s;
    8000348a:	40b48633          	sub	a2,s1,a1
    8000348e:	00060a1b          	sext.w	s4,a2
  if(len >= DIRSIZ)
    80003492:	094cd463          	bge	s9,s4,8000351a <namex+0x130>
    memmove(name, s, DIRSIZ);
    80003496:	4639                	li	a2,14
    80003498:	8556                	mv	a0,s5
    8000349a:	ffffd097          	auipc	ra,0xffffd
    8000349e:	d3e080e7          	jalr	-706(ra) # 800001d8 <memmove>
  while(*path == '/')
    800034a2:	0004c783          	lbu	a5,0(s1)
    800034a6:	01279763          	bne	a5,s2,800034b4 <namex+0xca>
    path++;
    800034aa:	0485                	addi	s1,s1,1
  while(*path == '/')
    800034ac:	0004c783          	lbu	a5,0(s1)
    800034b0:	ff278de3          	beq	a5,s2,800034aa <namex+0xc0>
    ilock(ip);
    800034b4:	854e                	mv	a0,s3
    800034b6:	00000097          	auipc	ra,0x0
    800034ba:	9aa080e7          	jalr	-1622(ra) # 80002e60 <ilock>
    if(ip->type != T_DIR){
    800034be:	04499783          	lh	a5,68(s3)
    800034c2:	f98793e3          	bne	a5,s8,80003448 <namex+0x5e>
    if(nameiparent && *path == '\0'){
    800034c6:	000b0563          	beqz	s6,800034d0 <namex+0xe6>
    800034ca:	0004c783          	lbu	a5,0(s1)
    800034ce:	d3cd                	beqz	a5,80003470 <namex+0x86>
    if((next = dirlookup(ip, name, 0)) == 0){
    800034d0:	865e                	mv	a2,s7
    800034d2:	85d6                	mv	a1,s5
    800034d4:	854e                	mv	a0,s3
    800034d6:	00000097          	auipc	ra,0x0
    800034da:	e64080e7          	jalr	-412(ra) # 8000333a <dirlookup>
    800034de:	8a2a                	mv	s4,a0
    800034e0:	dd51                	beqz	a0,8000347c <namex+0x92>
    iunlockput(ip);
    800034e2:	854e                	mv	a0,s3
    800034e4:	00000097          	auipc	ra,0x0
    800034e8:	bde080e7          	jalr	-1058(ra) # 800030c2 <iunlockput>
    ip = next;
    800034ec:	89d2                	mv	s3,s4
  while(*path == '/')
    800034ee:	0004c783          	lbu	a5,0(s1)
    800034f2:	05279763          	bne	a5,s2,80003540 <namex+0x156>
    path++;
    800034f6:	0485                	addi	s1,s1,1
  while(*path == '/')
    800034f8:	0004c783          	lbu	a5,0(s1)
    800034fc:	ff278de3          	beq	a5,s2,800034f6 <namex+0x10c>
  if(*path == 0)
    80003500:	c79d                	beqz	a5,8000352e <namex+0x144>
    path++;
    80003502:	85a6                	mv	a1,s1
  len = path - s;
    80003504:	8a5e                	mv	s4,s7
    80003506:	865e                	mv	a2,s7
  while(*path != '/' && *path != 0)
    80003508:	01278963          	beq	a5,s2,8000351a <namex+0x130>
    8000350c:	dfbd                	beqz	a5,8000348a <namex+0xa0>
    path++;
    8000350e:	0485                	addi	s1,s1,1
  while(*path != '/' && *path != 0)
    80003510:	0004c783          	lbu	a5,0(s1)
    80003514:	ff279ce3          	bne	a5,s2,8000350c <namex+0x122>
    80003518:	bf8d                	j	8000348a <namex+0xa0>
    memmove(name, s, len);
    8000351a:	2601                	sext.w	a2,a2
    8000351c:	8556                	mv	a0,s5
    8000351e:	ffffd097          	auipc	ra,0xffffd
    80003522:	cba080e7          	jalr	-838(ra) # 800001d8 <memmove>
    name[len] = 0;
    80003526:	9a56                	add	s4,s4,s5
    80003528:	000a0023          	sb	zero,0(s4)
    8000352c:	bf9d                	j	800034a2 <namex+0xb8>
  if(nameiparent){
    8000352e:	f20b03e3          	beqz	s6,80003454 <namex+0x6a>
    iput(ip);
    80003532:	854e                	mv	a0,s3
    80003534:	00000097          	auipc	ra,0x0
    80003538:	ae6080e7          	jalr	-1306(ra) # 8000301a <iput>
    return 0;
    8000353c:	4981                	li	s3,0
    8000353e:	bf19                	j	80003454 <namex+0x6a>
  if(*path == 0)
    80003540:	d7fd                	beqz	a5,8000352e <namex+0x144>
  while(*path != '/' && *path != 0)
    80003542:	0004c783          	lbu	a5,0(s1)
    80003546:	85a6                	mv	a1,s1
    80003548:	b7d1                	j	8000350c <namex+0x122>

000000008000354a <dirlink>:
{
    8000354a:	7139                	addi	sp,sp,-64
    8000354c:	fc06                	sd	ra,56(sp)
    8000354e:	f822                	sd	s0,48(sp)
    80003550:	f426                	sd	s1,40(sp)
    80003552:	f04a                	sd	s2,32(sp)
    80003554:	ec4e                	sd	s3,24(sp)
    80003556:	e852                	sd	s4,16(sp)
    80003558:	0080                	addi	s0,sp,64
    8000355a:	892a                	mv	s2,a0
    8000355c:	8a2e                	mv	s4,a1
    8000355e:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80003560:	4601                	li	a2,0
    80003562:	00000097          	auipc	ra,0x0
    80003566:	dd8080e7          	jalr	-552(ra) # 8000333a <dirlookup>
    8000356a:	e93d                	bnez	a0,800035e0 <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000356c:	04c92483          	lw	s1,76(s2)
    80003570:	c49d                	beqz	s1,8000359e <dirlink+0x54>
    80003572:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003574:	4741                	li	a4,16
    80003576:	86a6                	mv	a3,s1
    80003578:	fc040613          	addi	a2,s0,-64
    8000357c:	4581                	li	a1,0
    8000357e:	854a                	mv	a0,s2
    80003580:	00000097          	auipc	ra,0x0
    80003584:	b94080e7          	jalr	-1132(ra) # 80003114 <readi>
    80003588:	47c1                	li	a5,16
    8000358a:	06f51163          	bne	a0,a5,800035ec <dirlink+0xa2>
    if(de.inum == 0)
    8000358e:	fc045783          	lhu	a5,-64(s0)
    80003592:	c791                	beqz	a5,8000359e <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003594:	24c1                	addiw	s1,s1,16
    80003596:	04c92783          	lw	a5,76(s2)
    8000359a:	fcf4ede3          	bltu	s1,a5,80003574 <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    8000359e:	4639                	li	a2,14
    800035a0:	85d2                	mv	a1,s4
    800035a2:	fc240513          	addi	a0,s0,-62
    800035a6:	ffffd097          	auipc	ra,0xffffd
    800035aa:	ce6080e7          	jalr	-794(ra) # 8000028c <strncpy>
  de.inum = inum;
    800035ae:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800035b2:	4741                	li	a4,16
    800035b4:	86a6                	mv	a3,s1
    800035b6:	fc040613          	addi	a2,s0,-64
    800035ba:	4581                	li	a1,0
    800035bc:	854a                	mv	a0,s2
    800035be:	00000097          	auipc	ra,0x0
    800035c2:	c4e080e7          	jalr	-946(ra) # 8000320c <writei>
    800035c6:	872a                	mv	a4,a0
    800035c8:	47c1                	li	a5,16
  return 0;
    800035ca:	4501                	li	a0,0
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800035cc:	02f71863          	bne	a4,a5,800035fc <dirlink+0xb2>
}
    800035d0:	70e2                	ld	ra,56(sp)
    800035d2:	7442                	ld	s0,48(sp)
    800035d4:	74a2                	ld	s1,40(sp)
    800035d6:	7902                	ld	s2,32(sp)
    800035d8:	69e2                	ld	s3,24(sp)
    800035da:	6a42                	ld	s4,16(sp)
    800035dc:	6121                	addi	sp,sp,64
    800035de:	8082                	ret
    iput(ip);
    800035e0:	00000097          	auipc	ra,0x0
    800035e4:	a3a080e7          	jalr	-1478(ra) # 8000301a <iput>
    return -1;
    800035e8:	557d                	li	a0,-1
    800035ea:	b7dd                	j	800035d0 <dirlink+0x86>
      panic("dirlink read");
    800035ec:	00005517          	auipc	a0,0x5
    800035f0:	09c50513          	addi	a0,a0,156 # 80008688 <syscalls+0x228>
    800035f4:	00003097          	auipc	ra,0x3
    800035f8:	cdc080e7          	jalr	-804(ra) # 800062d0 <panic>
    panic("dirlink");
    800035fc:	00005517          	auipc	a0,0x5
    80003600:	23450513          	addi	a0,a0,564 # 80008830 <syscalls+0x3d0>
    80003604:	00003097          	auipc	ra,0x3
    80003608:	ccc080e7          	jalr	-820(ra) # 800062d0 <panic>

000000008000360c <namei>:

struct inode*
namei(char *path)
{
    8000360c:	1101                	addi	sp,sp,-32
    8000360e:	ec06                	sd	ra,24(sp)
    80003610:	e822                	sd	s0,16(sp)
    80003612:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80003614:	fe040613          	addi	a2,s0,-32
    80003618:	4581                	li	a1,0
    8000361a:	00000097          	auipc	ra,0x0
    8000361e:	dd0080e7          	jalr	-560(ra) # 800033ea <namex>
}
    80003622:	60e2                	ld	ra,24(sp)
    80003624:	6442                	ld	s0,16(sp)
    80003626:	6105                	addi	sp,sp,32
    80003628:	8082                	ret

000000008000362a <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    8000362a:	1141                	addi	sp,sp,-16
    8000362c:	e406                	sd	ra,8(sp)
    8000362e:	e022                	sd	s0,0(sp)
    80003630:	0800                	addi	s0,sp,16
    80003632:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80003634:	4585                	li	a1,1
    80003636:	00000097          	auipc	ra,0x0
    8000363a:	db4080e7          	jalr	-588(ra) # 800033ea <namex>
}
    8000363e:	60a2                	ld	ra,8(sp)
    80003640:	6402                	ld	s0,0(sp)
    80003642:	0141                	addi	sp,sp,16
    80003644:	8082                	ret

0000000080003646 <balloc_page>:

/* NTU OS 2024 */
/* Similar to balloc, except allocates eight consecutive free blocks. */
uint balloc_page(uint dev) {
    80003646:	715d                	addi	sp,sp,-80
    80003648:	e486                	sd	ra,72(sp)
    8000364a:	e0a2                	sd	s0,64(sp)
    8000364c:	fc26                	sd	s1,56(sp)
    8000364e:	f84a                	sd	s2,48(sp)
    80003650:	f44e                	sd	s3,40(sp)
    80003652:	f052                	sd	s4,32(sp)
    80003654:	ec56                	sd	s5,24(sp)
    80003656:	e85a                	sd	s6,16(sp)
    80003658:	e45e                	sd	s7,8(sp)
    8000365a:	0880                	addi	s0,sp,80
  for (int b = 0; b < sb.size; b += BPB) {
    8000365c:	00014797          	auipc	a5,0x14
    80003660:	f007a783          	lw	a5,-256(a5) # 8001755c <sb+0x4>
    80003664:	c3e9                	beqz	a5,80003726 <balloc_page+0xe0>
    80003666:	89aa                	mv	s3,a0
    80003668:	4a01                	li	s4,0
    struct buf *bp = bread(dev, BBLOCK(b, sb));
    8000366a:	00014a97          	auipc	s5,0x14
    8000366e:	eeea8a93          	addi	s5,s5,-274 # 80017558 <sb>

    for (int bi = 0; bi < BPB && b + bi < sb.size; bi += 8) {
    80003672:	4b01                	li	s6,0
    80003674:	6909                	lui	s2,0x2
  for (int b = 0; b < sb.size; b += BPB) {
    80003676:	6b89                	lui	s7,0x2
    80003678:	a8b9                	j	800036d6 <balloc_page+0x90>
      uchar *bits = &bp->data[bi / 8];
      if (*bits == 0) {
        *bits |= 0xff; // Mark 8 consecutive blocks in use.
    8000367a:	97aa                	add	a5,a5,a0
    8000367c:	577d                	li	a4,-1
    8000367e:	04e78c23          	sb	a4,88(a5)
        //log_write(bp);
        brelse(bp);
    80003682:	fffff097          	auipc	ra,0xfffff
    80003686:	070080e7          	jalr	112(ra) # 800026f2 <brelse>

        for (int i = 0; i < 8; i += 1) {
    8000368a:	00848a1b          	addiw	s4,s1,8
        brelse(bp);
    8000368e:	8926                	mv	s2,s1
          bzero(dev, b + bi + i);
    80003690:	2981                	sext.w	s3,s3
    80003692:	0009059b          	sext.w	a1,s2
    80003696:	854e                	mv	a0,s3
    80003698:	fffff097          	auipc	ra,0xfffff
    8000369c:	29e080e7          	jalr	670(ra) # 80002936 <bzero>
        for (int i = 0; i < 8; i += 1) {
    800036a0:	2905                	addiw	s2,s2,1
    800036a2:	ff4918e3          	bne	s2,s4,80003692 <balloc_page+0x4c>
    }

    brelse(bp);
  }
  panic("balloc_page: out of blocks");
}
    800036a6:	8526                	mv	a0,s1
    800036a8:	60a6                	ld	ra,72(sp)
    800036aa:	6406                	ld	s0,64(sp)
    800036ac:	74e2                	ld	s1,56(sp)
    800036ae:	7942                	ld	s2,48(sp)
    800036b0:	79a2                	ld	s3,40(sp)
    800036b2:	7a02                	ld	s4,32(sp)
    800036b4:	6ae2                	ld	s5,24(sp)
    800036b6:	6b42                	ld	s6,16(sp)
    800036b8:	6ba2                	ld	s7,8(sp)
    800036ba:	6161                	addi	sp,sp,80
    800036bc:	8082                	ret
    brelse(bp);
    800036be:	fffff097          	auipc	ra,0xfffff
    800036c2:	034080e7          	jalr	52(ra) # 800026f2 <brelse>
  for (int b = 0; b < sb.size; b += BPB) {
    800036c6:	014b87bb          	addw	a5,s7,s4
    800036ca:	00078a1b          	sext.w	s4,a5
    800036ce:	004aa703          	lw	a4,4(s5)
    800036d2:	04ea7a63          	bgeu	s4,a4,80003726 <balloc_page+0xe0>
    struct buf *bp = bread(dev, BBLOCK(b, sb));
    800036d6:	41fa579b          	sraiw	a5,s4,0x1f
    800036da:	0137d79b          	srliw	a5,a5,0x13
    800036de:	014787bb          	addw	a5,a5,s4
    800036e2:	40d7d79b          	sraiw	a5,a5,0xd
    800036e6:	01caa583          	lw	a1,28(s5)
    800036ea:	9dbd                	addw	a1,a1,a5
    800036ec:	854e                	mv	a0,s3
    800036ee:	fffff097          	auipc	ra,0xfffff
    800036f2:	f92080e7          	jalr	-110(ra) # 80002680 <bread>
    for (int bi = 0; bi < BPB && b + bi < sb.size; bi += 8) {
    800036f6:	004aa603          	lw	a2,4(s5)
    800036fa:	000a049b          	sext.w	s1,s4
    800036fe:	875a                	mv	a4,s6
    80003700:	fac4ffe3          	bgeu	s1,a2,800036be <balloc_page+0x78>
      uchar *bits = &bp->data[bi / 8];
    80003704:	41f7579b          	sraiw	a5,a4,0x1f
    80003708:	01d7d79b          	srliw	a5,a5,0x1d
    8000370c:	9fb9                	addw	a5,a5,a4
    8000370e:	4037d79b          	sraiw	a5,a5,0x3
      if (*bits == 0) {
    80003712:	00f506b3          	add	a3,a0,a5
    80003716:	0586c683          	lbu	a3,88(a3)
    8000371a:	d2a5                	beqz	a3,8000367a <balloc_page+0x34>
    for (int bi = 0; bi < BPB && b + bi < sb.size; bi += 8) {
    8000371c:	2721                	addiw	a4,a4,8
    8000371e:	24a1                	addiw	s1,s1,8
    80003720:	ff2710e3          	bne	a4,s2,80003700 <balloc_page+0xba>
    80003724:	bf69                	j	800036be <balloc_page+0x78>
  panic("balloc_page: out of blocks");
    80003726:	00005517          	auipc	a0,0x5
    8000372a:	f7250513          	addi	a0,a0,-142 # 80008698 <syscalls+0x238>
    8000372e:	00003097          	auipc	ra,0x3
    80003732:	ba2080e7          	jalr	-1118(ra) # 800062d0 <panic>

0000000080003736 <bfree_page>:

/* NTU OS 2024 */
/* Free 8 disk blocks allocated from balloc_page(). */
void bfree_page(int dev, uint blockno) {
    80003736:	1101                	addi	sp,sp,-32
    80003738:	ec06                	sd	ra,24(sp)
    8000373a:	e822                	sd	s0,16(sp)
    8000373c:	e426                	sd	s1,8(sp)
    8000373e:	1000                	addi	s0,sp,32
  if (blockno + 8 > sb.size) {
    80003740:	0085871b          	addiw	a4,a1,8
    80003744:	00014797          	auipc	a5,0x14
    80003748:	e187a783          	lw	a5,-488(a5) # 8001755c <sb+0x4>
    8000374c:	04e7ee63          	bltu	a5,a4,800037a8 <bfree_page+0x72>
    panic("bfree_page: blockno out of bound");
  }

  if ((blockno % 8) != 0) {
    80003750:	0075f793          	andi	a5,a1,7
    80003754:	e3b5                	bnez	a5,800037b8 <bfree_page+0x82>
    panic("bfree_page: blockno is not aligned");
  }

  int bi = blockno % BPB;
    80003756:	03359493          	slli	s1,a1,0x33
    8000375a:	90cd                	srli	s1,s1,0x33
  int b = blockno - bi;
    8000375c:	9d85                	subw	a1,a1,s1
  struct buf *bp = bread(dev, BBLOCK(b, sb));
    8000375e:	41f5d79b          	sraiw	a5,a1,0x1f
    80003762:	0137d79b          	srliw	a5,a5,0x13
    80003766:	9dbd                	addw	a1,a1,a5
    80003768:	40d5d59b          	sraiw	a1,a1,0xd
    8000376c:	00014797          	auipc	a5,0x14
    80003770:	e087a783          	lw	a5,-504(a5) # 80017574 <sb+0x1c>
    80003774:	9dbd                	addw	a1,a1,a5
    80003776:	fffff097          	auipc	ra,0xfffff
    8000377a:	f0a080e7          	jalr	-246(ra) # 80002680 <bread>
  uchar *bits = &bp->data[bi / 8];
    8000377e:	808d                	srli	s1,s1,0x3

  if (*bits != 0xff) {
    80003780:	009507b3          	add	a5,a0,s1
    80003784:	0587c703          	lbu	a4,88(a5)
    80003788:	0ff00793          	li	a5,255
    8000378c:	02f71e63          	bne	a4,a5,800037c8 <bfree_page+0x92>
    panic("bfree_page: data bits are invalid");
  }

  *bits = 0;
    80003790:	94aa                	add	s1,s1,a0
    80003792:	04048c23          	sb	zero,88(s1)
  //log_write(bp);
  brelse(bp);
    80003796:	fffff097          	auipc	ra,0xfffff
    8000379a:	f5c080e7          	jalr	-164(ra) # 800026f2 <brelse>
}
    8000379e:	60e2                	ld	ra,24(sp)
    800037a0:	6442                	ld	s0,16(sp)
    800037a2:	64a2                	ld	s1,8(sp)
    800037a4:	6105                	addi	sp,sp,32
    800037a6:	8082                	ret
    panic("bfree_page: blockno out of bound");
    800037a8:	00005517          	auipc	a0,0x5
    800037ac:	f1050513          	addi	a0,a0,-240 # 800086b8 <syscalls+0x258>
    800037b0:	00003097          	auipc	ra,0x3
    800037b4:	b20080e7          	jalr	-1248(ra) # 800062d0 <panic>
    panic("bfree_page: blockno is not aligned");
    800037b8:	00005517          	auipc	a0,0x5
    800037bc:	f2850513          	addi	a0,a0,-216 # 800086e0 <syscalls+0x280>
    800037c0:	00003097          	auipc	ra,0x3
    800037c4:	b10080e7          	jalr	-1264(ra) # 800062d0 <panic>
    panic("bfree_page: data bits are invalid");
    800037c8:	00005517          	auipc	a0,0x5
    800037cc:	f4050513          	addi	a0,a0,-192 # 80008708 <syscalls+0x2a8>
    800037d0:	00003097          	auipc	ra,0x3
    800037d4:	b00080e7          	jalr	-1280(ra) # 800062d0 <panic>

00000000800037d8 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    800037d8:	1101                	addi	sp,sp,-32
    800037da:	ec06                	sd	ra,24(sp)
    800037dc:	e822                	sd	s0,16(sp)
    800037de:	e426                	sd	s1,8(sp)
    800037e0:	e04a                	sd	s2,0(sp)
    800037e2:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    800037e4:	00016917          	auipc	s2,0x16
    800037e8:	83c90913          	addi	s2,s2,-1988 # 80019020 <log>
    800037ec:	01892583          	lw	a1,24(s2)
    800037f0:	02892503          	lw	a0,40(s2)
    800037f4:	fffff097          	auipc	ra,0xfffff
    800037f8:	e8c080e7          	jalr	-372(ra) # 80002680 <bread>
    800037fc:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    800037fe:	02c92683          	lw	a3,44(s2)
    80003802:	cd34                	sw	a3,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    80003804:	02d05763          	blez	a3,80003832 <write_head+0x5a>
    80003808:	00016797          	auipc	a5,0x16
    8000380c:	84878793          	addi	a5,a5,-1976 # 80019050 <log+0x30>
    80003810:	05c50713          	addi	a4,a0,92
    80003814:	36fd                	addiw	a3,a3,-1
    80003816:	1682                	slli	a3,a3,0x20
    80003818:	9281                	srli	a3,a3,0x20
    8000381a:	068a                	slli	a3,a3,0x2
    8000381c:	00016617          	auipc	a2,0x16
    80003820:	83860613          	addi	a2,a2,-1992 # 80019054 <log+0x34>
    80003824:	96b2                	add	a3,a3,a2
    hb->block[i] = log.lh.block[i];
    80003826:	4390                	lw	a2,0(a5)
    80003828:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    8000382a:	0791                	addi	a5,a5,4
    8000382c:	0711                	addi	a4,a4,4
    8000382e:	fed79ce3          	bne	a5,a3,80003826 <write_head+0x4e>
  }
  bwrite(buf);
    80003832:	8526                	mv	a0,s1
    80003834:	fffff097          	auipc	ra,0xfffff
    80003838:	e80080e7          	jalr	-384(ra) # 800026b4 <bwrite>
  brelse(buf);
    8000383c:	8526                	mv	a0,s1
    8000383e:	fffff097          	auipc	ra,0xfffff
    80003842:	eb4080e7          	jalr	-332(ra) # 800026f2 <brelse>
}
    80003846:	60e2                	ld	ra,24(sp)
    80003848:	6442                	ld	s0,16(sp)
    8000384a:	64a2                	ld	s1,8(sp)
    8000384c:	6902                	ld	s2,0(sp)
    8000384e:	6105                	addi	sp,sp,32
    80003850:	8082                	ret

0000000080003852 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    80003852:	00015797          	auipc	a5,0x15
    80003856:	7fa7a783          	lw	a5,2042(a5) # 8001904c <log+0x2c>
    8000385a:	0af05d63          	blez	a5,80003914 <install_trans+0xc2>
{
    8000385e:	7139                	addi	sp,sp,-64
    80003860:	fc06                	sd	ra,56(sp)
    80003862:	f822                	sd	s0,48(sp)
    80003864:	f426                	sd	s1,40(sp)
    80003866:	f04a                	sd	s2,32(sp)
    80003868:	ec4e                	sd	s3,24(sp)
    8000386a:	e852                	sd	s4,16(sp)
    8000386c:	e456                	sd	s5,8(sp)
    8000386e:	e05a                	sd	s6,0(sp)
    80003870:	0080                	addi	s0,sp,64
    80003872:	8b2a                	mv	s6,a0
    80003874:	00015a97          	auipc	s5,0x15
    80003878:	7dca8a93          	addi	s5,s5,2012 # 80019050 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000387c:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    8000387e:	00015997          	auipc	s3,0x15
    80003882:	7a298993          	addi	s3,s3,1954 # 80019020 <log>
    80003886:	a035                	j	800038b2 <install_trans+0x60>
      bunpin(dbuf);
    80003888:	8526                	mv	a0,s1
    8000388a:	fffff097          	auipc	ra,0xfffff
    8000388e:	f42080e7          	jalr	-190(ra) # 800027cc <bunpin>
    brelse(lbuf);
    80003892:	854a                	mv	a0,s2
    80003894:	fffff097          	auipc	ra,0xfffff
    80003898:	e5e080e7          	jalr	-418(ra) # 800026f2 <brelse>
    brelse(dbuf);
    8000389c:	8526                	mv	a0,s1
    8000389e:	fffff097          	auipc	ra,0xfffff
    800038a2:	e54080e7          	jalr	-428(ra) # 800026f2 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800038a6:	2a05                	addiw	s4,s4,1
    800038a8:	0a91                	addi	s5,s5,4
    800038aa:	02c9a783          	lw	a5,44(s3)
    800038ae:	04fa5963          	bge	s4,a5,80003900 <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    800038b2:	0189a583          	lw	a1,24(s3)
    800038b6:	014585bb          	addw	a1,a1,s4
    800038ba:	2585                	addiw	a1,a1,1
    800038bc:	0289a503          	lw	a0,40(s3)
    800038c0:	fffff097          	auipc	ra,0xfffff
    800038c4:	dc0080e7          	jalr	-576(ra) # 80002680 <bread>
    800038c8:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    800038ca:	000aa583          	lw	a1,0(s5)
    800038ce:	0289a503          	lw	a0,40(s3)
    800038d2:	fffff097          	auipc	ra,0xfffff
    800038d6:	dae080e7          	jalr	-594(ra) # 80002680 <bread>
    800038da:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    800038dc:	40000613          	li	a2,1024
    800038e0:	05890593          	addi	a1,s2,88
    800038e4:	05850513          	addi	a0,a0,88
    800038e8:	ffffd097          	auipc	ra,0xffffd
    800038ec:	8f0080e7          	jalr	-1808(ra) # 800001d8 <memmove>
    bwrite(dbuf);  // write dst to disk
    800038f0:	8526                	mv	a0,s1
    800038f2:	fffff097          	auipc	ra,0xfffff
    800038f6:	dc2080e7          	jalr	-574(ra) # 800026b4 <bwrite>
    if(recovering == 0)
    800038fa:	f80b1ce3          	bnez	s6,80003892 <install_trans+0x40>
    800038fe:	b769                	j	80003888 <install_trans+0x36>
}
    80003900:	70e2                	ld	ra,56(sp)
    80003902:	7442                	ld	s0,48(sp)
    80003904:	74a2                	ld	s1,40(sp)
    80003906:	7902                	ld	s2,32(sp)
    80003908:	69e2                	ld	s3,24(sp)
    8000390a:	6a42                	ld	s4,16(sp)
    8000390c:	6aa2                	ld	s5,8(sp)
    8000390e:	6b02                	ld	s6,0(sp)
    80003910:	6121                	addi	sp,sp,64
    80003912:	8082                	ret
    80003914:	8082                	ret

0000000080003916 <initlog>:
{
    80003916:	7179                	addi	sp,sp,-48
    80003918:	f406                	sd	ra,40(sp)
    8000391a:	f022                	sd	s0,32(sp)
    8000391c:	ec26                	sd	s1,24(sp)
    8000391e:	e84a                	sd	s2,16(sp)
    80003920:	e44e                	sd	s3,8(sp)
    80003922:	1800                	addi	s0,sp,48
    80003924:	892a                	mv	s2,a0
    80003926:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80003928:	00015497          	auipc	s1,0x15
    8000392c:	6f848493          	addi	s1,s1,1784 # 80019020 <log>
    80003930:	00005597          	auipc	a1,0x5
    80003934:	e0058593          	addi	a1,a1,-512 # 80008730 <syscalls+0x2d0>
    80003938:	8526                	mv	a0,s1
    8000393a:	00003097          	auipc	ra,0x3
    8000393e:	e50080e7          	jalr	-432(ra) # 8000678a <initlock>
  log.start = sb->logstart;
    80003942:	0149a583          	lw	a1,20(s3)
    80003946:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    80003948:	0109a783          	lw	a5,16(s3)
    8000394c:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    8000394e:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    80003952:	854a                	mv	a0,s2
    80003954:	fffff097          	auipc	ra,0xfffff
    80003958:	d2c080e7          	jalr	-724(ra) # 80002680 <bread>
  log.lh.n = lh->n;
    8000395c:	4d3c                	lw	a5,88(a0)
    8000395e:	d4dc                	sw	a5,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    80003960:	02f05563          	blez	a5,8000398a <initlog+0x74>
    80003964:	05c50713          	addi	a4,a0,92
    80003968:	00015697          	auipc	a3,0x15
    8000396c:	6e868693          	addi	a3,a3,1768 # 80019050 <log+0x30>
    80003970:	37fd                	addiw	a5,a5,-1
    80003972:	1782                	slli	a5,a5,0x20
    80003974:	9381                	srli	a5,a5,0x20
    80003976:	078a                	slli	a5,a5,0x2
    80003978:	06050613          	addi	a2,a0,96
    8000397c:	97b2                	add	a5,a5,a2
    log.lh.block[i] = lh->block[i];
    8000397e:	4310                	lw	a2,0(a4)
    80003980:	c290                	sw	a2,0(a3)
  for (i = 0; i < log.lh.n; i++) {
    80003982:	0711                	addi	a4,a4,4
    80003984:	0691                	addi	a3,a3,4
    80003986:	fef71ce3          	bne	a4,a5,8000397e <initlog+0x68>
  brelse(buf);
    8000398a:	fffff097          	auipc	ra,0xfffff
    8000398e:	d68080e7          	jalr	-664(ra) # 800026f2 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    80003992:	4505                	li	a0,1
    80003994:	00000097          	auipc	ra,0x0
    80003998:	ebe080e7          	jalr	-322(ra) # 80003852 <install_trans>
  log.lh.n = 0;
    8000399c:	00015797          	auipc	a5,0x15
    800039a0:	6a07a823          	sw	zero,1712(a5) # 8001904c <log+0x2c>
  write_head(); // clear the log
    800039a4:	00000097          	auipc	ra,0x0
    800039a8:	e34080e7          	jalr	-460(ra) # 800037d8 <write_head>
}
    800039ac:	70a2                	ld	ra,40(sp)
    800039ae:	7402                	ld	s0,32(sp)
    800039b0:	64e2                	ld	s1,24(sp)
    800039b2:	6942                	ld	s2,16(sp)
    800039b4:	69a2                	ld	s3,8(sp)
    800039b6:	6145                	addi	sp,sp,48
    800039b8:	8082                	ret

00000000800039ba <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    800039ba:	1101                	addi	sp,sp,-32
    800039bc:	ec06                	sd	ra,24(sp)
    800039be:	e822                	sd	s0,16(sp)
    800039c0:	e426                	sd	s1,8(sp)
    800039c2:	e04a                	sd	s2,0(sp)
    800039c4:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    800039c6:	00015517          	auipc	a0,0x15
    800039ca:	65a50513          	addi	a0,a0,1626 # 80019020 <log>
    800039ce:	00003097          	auipc	ra,0x3
    800039d2:	e4c080e7          	jalr	-436(ra) # 8000681a <acquire>
  while(1){
    if(log.committing){
    800039d6:	00015497          	auipc	s1,0x15
    800039da:	64a48493          	addi	s1,s1,1610 # 80019020 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    800039de:	4979                	li	s2,30
    800039e0:	a039                	j	800039ee <begin_op+0x34>
      sleep(&log, &log.lock);
    800039e2:	85a6                	mv	a1,s1
    800039e4:	8526                	mv	a0,s1
    800039e6:	ffffe097          	auipc	ra,0xffffe
    800039ea:	e36080e7          	jalr	-458(ra) # 8000181c <sleep>
    if(log.committing){
    800039ee:	50dc                	lw	a5,36(s1)
    800039f0:	fbed                	bnez	a5,800039e2 <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    800039f2:	509c                	lw	a5,32(s1)
    800039f4:	0017871b          	addiw	a4,a5,1
    800039f8:	0007069b          	sext.w	a3,a4
    800039fc:	0027179b          	slliw	a5,a4,0x2
    80003a00:	9fb9                	addw	a5,a5,a4
    80003a02:	0017979b          	slliw	a5,a5,0x1
    80003a06:	54d8                	lw	a4,44(s1)
    80003a08:	9fb9                	addw	a5,a5,a4
    80003a0a:	00f95963          	bge	s2,a5,80003a1c <begin_op+0x62>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80003a0e:	85a6                	mv	a1,s1
    80003a10:	8526                	mv	a0,s1
    80003a12:	ffffe097          	auipc	ra,0xffffe
    80003a16:	e0a080e7          	jalr	-502(ra) # 8000181c <sleep>
    80003a1a:	bfd1                	j	800039ee <begin_op+0x34>
    } else {
      log.outstanding += 1;
    80003a1c:	00015517          	auipc	a0,0x15
    80003a20:	60450513          	addi	a0,a0,1540 # 80019020 <log>
    80003a24:	d114                	sw	a3,32(a0)
      release(&log.lock);
    80003a26:	00003097          	auipc	ra,0x3
    80003a2a:	ea8080e7          	jalr	-344(ra) # 800068ce <release>
      break;
    }
  }
}
    80003a2e:	60e2                	ld	ra,24(sp)
    80003a30:	6442                	ld	s0,16(sp)
    80003a32:	64a2                	ld	s1,8(sp)
    80003a34:	6902                	ld	s2,0(sp)
    80003a36:	6105                	addi	sp,sp,32
    80003a38:	8082                	ret

0000000080003a3a <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80003a3a:	7139                	addi	sp,sp,-64
    80003a3c:	fc06                	sd	ra,56(sp)
    80003a3e:	f822                	sd	s0,48(sp)
    80003a40:	f426                	sd	s1,40(sp)
    80003a42:	f04a                	sd	s2,32(sp)
    80003a44:	ec4e                	sd	s3,24(sp)
    80003a46:	e852                	sd	s4,16(sp)
    80003a48:	e456                	sd	s5,8(sp)
    80003a4a:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80003a4c:	00015497          	auipc	s1,0x15
    80003a50:	5d448493          	addi	s1,s1,1492 # 80019020 <log>
    80003a54:	8526                	mv	a0,s1
    80003a56:	00003097          	auipc	ra,0x3
    80003a5a:	dc4080e7          	jalr	-572(ra) # 8000681a <acquire>
  log.outstanding -= 1;
    80003a5e:	509c                	lw	a5,32(s1)
    80003a60:	37fd                	addiw	a5,a5,-1
    80003a62:	0007891b          	sext.w	s2,a5
    80003a66:	d09c                	sw	a5,32(s1)
  if(log.committing)
    80003a68:	50dc                	lw	a5,36(s1)
    80003a6a:	efb9                	bnez	a5,80003ac8 <end_op+0x8e>
    panic("log.committing");
  if(log.outstanding == 0){
    80003a6c:	06091663          	bnez	s2,80003ad8 <end_op+0x9e>
    do_commit = 1;
    log.committing = 1;
    80003a70:	00015497          	auipc	s1,0x15
    80003a74:	5b048493          	addi	s1,s1,1456 # 80019020 <log>
    80003a78:	4785                	li	a5,1
    80003a7a:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    80003a7c:	8526                	mv	a0,s1
    80003a7e:	00003097          	auipc	ra,0x3
    80003a82:	e50080e7          	jalr	-432(ra) # 800068ce <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    80003a86:	54dc                	lw	a5,44(s1)
    80003a88:	06f04763          	bgtz	a5,80003af6 <end_op+0xbc>
    acquire(&log.lock);
    80003a8c:	00015497          	auipc	s1,0x15
    80003a90:	59448493          	addi	s1,s1,1428 # 80019020 <log>
    80003a94:	8526                	mv	a0,s1
    80003a96:	00003097          	auipc	ra,0x3
    80003a9a:	d84080e7          	jalr	-636(ra) # 8000681a <acquire>
    log.committing = 0;
    80003a9e:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    80003aa2:	8526                	mv	a0,s1
    80003aa4:	ffffe097          	auipc	ra,0xffffe
    80003aa8:	f04080e7          	jalr	-252(ra) # 800019a8 <wakeup>
    release(&log.lock);
    80003aac:	8526                	mv	a0,s1
    80003aae:	00003097          	auipc	ra,0x3
    80003ab2:	e20080e7          	jalr	-480(ra) # 800068ce <release>
}
    80003ab6:	70e2                	ld	ra,56(sp)
    80003ab8:	7442                	ld	s0,48(sp)
    80003aba:	74a2                	ld	s1,40(sp)
    80003abc:	7902                	ld	s2,32(sp)
    80003abe:	69e2                	ld	s3,24(sp)
    80003ac0:	6a42                	ld	s4,16(sp)
    80003ac2:	6aa2                	ld	s5,8(sp)
    80003ac4:	6121                	addi	sp,sp,64
    80003ac6:	8082                	ret
    panic("log.committing");
    80003ac8:	00005517          	auipc	a0,0x5
    80003acc:	c7050513          	addi	a0,a0,-912 # 80008738 <syscalls+0x2d8>
    80003ad0:	00003097          	auipc	ra,0x3
    80003ad4:	800080e7          	jalr	-2048(ra) # 800062d0 <panic>
    wakeup(&log);
    80003ad8:	00015497          	auipc	s1,0x15
    80003adc:	54848493          	addi	s1,s1,1352 # 80019020 <log>
    80003ae0:	8526                	mv	a0,s1
    80003ae2:	ffffe097          	auipc	ra,0xffffe
    80003ae6:	ec6080e7          	jalr	-314(ra) # 800019a8 <wakeup>
  release(&log.lock);
    80003aea:	8526                	mv	a0,s1
    80003aec:	00003097          	auipc	ra,0x3
    80003af0:	de2080e7          	jalr	-542(ra) # 800068ce <release>
  if(do_commit){
    80003af4:	b7c9                	j	80003ab6 <end_op+0x7c>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003af6:	00015a97          	auipc	s5,0x15
    80003afa:	55aa8a93          	addi	s5,s5,1370 # 80019050 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80003afe:	00015a17          	auipc	s4,0x15
    80003b02:	522a0a13          	addi	s4,s4,1314 # 80019020 <log>
    80003b06:	018a2583          	lw	a1,24(s4)
    80003b0a:	012585bb          	addw	a1,a1,s2
    80003b0e:	2585                	addiw	a1,a1,1
    80003b10:	028a2503          	lw	a0,40(s4)
    80003b14:	fffff097          	auipc	ra,0xfffff
    80003b18:	b6c080e7          	jalr	-1172(ra) # 80002680 <bread>
    80003b1c:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    80003b1e:	000aa583          	lw	a1,0(s5)
    80003b22:	028a2503          	lw	a0,40(s4)
    80003b26:	fffff097          	auipc	ra,0xfffff
    80003b2a:	b5a080e7          	jalr	-1190(ra) # 80002680 <bread>
    80003b2e:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    80003b30:	40000613          	li	a2,1024
    80003b34:	05850593          	addi	a1,a0,88
    80003b38:	05848513          	addi	a0,s1,88
    80003b3c:	ffffc097          	auipc	ra,0xffffc
    80003b40:	69c080e7          	jalr	1692(ra) # 800001d8 <memmove>
    bwrite(to);  // write the log
    80003b44:	8526                	mv	a0,s1
    80003b46:	fffff097          	auipc	ra,0xfffff
    80003b4a:	b6e080e7          	jalr	-1170(ra) # 800026b4 <bwrite>
    brelse(from);
    80003b4e:	854e                	mv	a0,s3
    80003b50:	fffff097          	auipc	ra,0xfffff
    80003b54:	ba2080e7          	jalr	-1118(ra) # 800026f2 <brelse>
    brelse(to);
    80003b58:	8526                	mv	a0,s1
    80003b5a:	fffff097          	auipc	ra,0xfffff
    80003b5e:	b98080e7          	jalr	-1128(ra) # 800026f2 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003b62:	2905                	addiw	s2,s2,1
    80003b64:	0a91                	addi	s5,s5,4
    80003b66:	02ca2783          	lw	a5,44(s4)
    80003b6a:	f8f94ee3          	blt	s2,a5,80003b06 <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    80003b6e:	00000097          	auipc	ra,0x0
    80003b72:	c6a080e7          	jalr	-918(ra) # 800037d8 <write_head>
    install_trans(0); // Now install writes to home locations
    80003b76:	4501                	li	a0,0
    80003b78:	00000097          	auipc	ra,0x0
    80003b7c:	cda080e7          	jalr	-806(ra) # 80003852 <install_trans>
    log.lh.n = 0;
    80003b80:	00015797          	auipc	a5,0x15
    80003b84:	4c07a623          	sw	zero,1228(a5) # 8001904c <log+0x2c>
    write_head();    // Erase the transaction from the log
    80003b88:	00000097          	auipc	ra,0x0
    80003b8c:	c50080e7          	jalr	-944(ra) # 800037d8 <write_head>
    80003b90:	bdf5                	j	80003a8c <end_op+0x52>

0000000080003b92 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    80003b92:	1101                	addi	sp,sp,-32
    80003b94:	ec06                	sd	ra,24(sp)
    80003b96:	e822                	sd	s0,16(sp)
    80003b98:	e426                	sd	s1,8(sp)
    80003b9a:	e04a                	sd	s2,0(sp)
    80003b9c:	1000                	addi	s0,sp,32
    80003b9e:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    80003ba0:	00015917          	auipc	s2,0x15
    80003ba4:	48090913          	addi	s2,s2,1152 # 80019020 <log>
    80003ba8:	854a                	mv	a0,s2
    80003baa:	00003097          	auipc	ra,0x3
    80003bae:	c70080e7          	jalr	-912(ra) # 8000681a <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    80003bb2:	02c92603          	lw	a2,44(s2)
    80003bb6:	47f5                	li	a5,29
    80003bb8:	06c7c563          	blt	a5,a2,80003c22 <log_write+0x90>
    80003bbc:	00015797          	auipc	a5,0x15
    80003bc0:	4807a783          	lw	a5,1152(a5) # 8001903c <log+0x1c>
    80003bc4:	37fd                	addiw	a5,a5,-1
    80003bc6:	04f65e63          	bge	a2,a5,80003c22 <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    80003bca:	00015797          	auipc	a5,0x15
    80003bce:	4767a783          	lw	a5,1142(a5) # 80019040 <log+0x20>
    80003bd2:	06f05063          	blez	a5,80003c32 <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    80003bd6:	4781                	li	a5,0
    80003bd8:	06c05563          	blez	a2,80003c42 <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003bdc:	44cc                	lw	a1,12(s1)
    80003bde:	00015717          	auipc	a4,0x15
    80003be2:	47270713          	addi	a4,a4,1138 # 80019050 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    80003be6:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003be8:	4314                	lw	a3,0(a4)
    80003bea:	04b68c63          	beq	a3,a1,80003c42 <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    80003bee:	2785                	addiw	a5,a5,1
    80003bf0:	0711                	addi	a4,a4,4
    80003bf2:	fef61be3          	bne	a2,a5,80003be8 <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    80003bf6:	0621                	addi	a2,a2,8
    80003bf8:	060a                	slli	a2,a2,0x2
    80003bfa:	00015797          	auipc	a5,0x15
    80003bfe:	42678793          	addi	a5,a5,1062 # 80019020 <log>
    80003c02:	963e                	add	a2,a2,a5
    80003c04:	44dc                	lw	a5,12(s1)
    80003c06:	ca1c                	sw	a5,16(a2)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    80003c08:	8526                	mv	a0,s1
    80003c0a:	fffff097          	auipc	ra,0xfffff
    80003c0e:	b86080e7          	jalr	-1146(ra) # 80002790 <bpin>
    log.lh.n++;
    80003c12:	00015717          	auipc	a4,0x15
    80003c16:	40e70713          	addi	a4,a4,1038 # 80019020 <log>
    80003c1a:	575c                	lw	a5,44(a4)
    80003c1c:	2785                	addiw	a5,a5,1
    80003c1e:	d75c                	sw	a5,44(a4)
    80003c20:	a835                	j	80003c5c <log_write+0xca>
    panic("too big a transaction");
    80003c22:	00005517          	auipc	a0,0x5
    80003c26:	b2650513          	addi	a0,a0,-1242 # 80008748 <syscalls+0x2e8>
    80003c2a:	00002097          	auipc	ra,0x2
    80003c2e:	6a6080e7          	jalr	1702(ra) # 800062d0 <panic>
    panic("log_write outside of trans");
    80003c32:	00005517          	auipc	a0,0x5
    80003c36:	b2e50513          	addi	a0,a0,-1234 # 80008760 <syscalls+0x300>
    80003c3a:	00002097          	auipc	ra,0x2
    80003c3e:	696080e7          	jalr	1686(ra) # 800062d0 <panic>
  log.lh.block[i] = b->blockno;
    80003c42:	00878713          	addi	a4,a5,8
    80003c46:	00271693          	slli	a3,a4,0x2
    80003c4a:	00015717          	auipc	a4,0x15
    80003c4e:	3d670713          	addi	a4,a4,982 # 80019020 <log>
    80003c52:	9736                	add	a4,a4,a3
    80003c54:	44d4                	lw	a3,12(s1)
    80003c56:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    80003c58:	faf608e3          	beq	a2,a5,80003c08 <log_write+0x76>
  }
  release(&log.lock);
    80003c5c:	00015517          	auipc	a0,0x15
    80003c60:	3c450513          	addi	a0,a0,964 # 80019020 <log>
    80003c64:	00003097          	auipc	ra,0x3
    80003c68:	c6a080e7          	jalr	-918(ra) # 800068ce <release>
}
    80003c6c:	60e2                	ld	ra,24(sp)
    80003c6e:	6442                	ld	s0,16(sp)
    80003c70:	64a2                	ld	s1,8(sp)
    80003c72:	6902                	ld	s2,0(sp)
    80003c74:	6105                	addi	sp,sp,32
    80003c76:	8082                	ret

0000000080003c78 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80003c78:	1101                	addi	sp,sp,-32
    80003c7a:	ec06                	sd	ra,24(sp)
    80003c7c:	e822                	sd	s0,16(sp)
    80003c7e:	e426                	sd	s1,8(sp)
    80003c80:	e04a                	sd	s2,0(sp)
    80003c82:	1000                	addi	s0,sp,32
    80003c84:	84aa                	mv	s1,a0
    80003c86:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80003c88:	00005597          	auipc	a1,0x5
    80003c8c:	af858593          	addi	a1,a1,-1288 # 80008780 <syscalls+0x320>
    80003c90:	0521                	addi	a0,a0,8
    80003c92:	00003097          	auipc	ra,0x3
    80003c96:	af8080e7          	jalr	-1288(ra) # 8000678a <initlock>
  lk->name = name;
    80003c9a:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    80003c9e:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003ca2:	0204a423          	sw	zero,40(s1)
}
    80003ca6:	60e2                	ld	ra,24(sp)
    80003ca8:	6442                	ld	s0,16(sp)
    80003caa:	64a2                	ld	s1,8(sp)
    80003cac:	6902                	ld	s2,0(sp)
    80003cae:	6105                	addi	sp,sp,32
    80003cb0:	8082                	ret

0000000080003cb2 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80003cb2:	1101                	addi	sp,sp,-32
    80003cb4:	ec06                	sd	ra,24(sp)
    80003cb6:	e822                	sd	s0,16(sp)
    80003cb8:	e426                	sd	s1,8(sp)
    80003cba:	e04a                	sd	s2,0(sp)
    80003cbc:	1000                	addi	s0,sp,32
    80003cbe:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003cc0:	00850913          	addi	s2,a0,8
    80003cc4:	854a                	mv	a0,s2
    80003cc6:	00003097          	auipc	ra,0x3
    80003cca:	b54080e7          	jalr	-1196(ra) # 8000681a <acquire>
  while (lk->locked) {
    80003cce:	409c                	lw	a5,0(s1)
    80003cd0:	cb89                	beqz	a5,80003ce2 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    80003cd2:	85ca                	mv	a1,s2
    80003cd4:	8526                	mv	a0,s1
    80003cd6:	ffffe097          	auipc	ra,0xffffe
    80003cda:	b46080e7          	jalr	-1210(ra) # 8000181c <sleep>
  while (lk->locked) {
    80003cde:	409c                	lw	a5,0(s1)
    80003ce0:	fbed                	bnez	a5,80003cd2 <acquiresleep+0x20>
  }
  lk->locked = 1;
    80003ce2:	4785                	li	a5,1
    80003ce4:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80003ce6:	ffffd097          	auipc	ra,0xffffd
    80003cea:	47a080e7          	jalr	1146(ra) # 80001160 <myproc>
    80003cee:	591c                	lw	a5,48(a0)
    80003cf0:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    80003cf2:	854a                	mv	a0,s2
    80003cf4:	00003097          	auipc	ra,0x3
    80003cf8:	bda080e7          	jalr	-1062(ra) # 800068ce <release>
}
    80003cfc:	60e2                	ld	ra,24(sp)
    80003cfe:	6442                	ld	s0,16(sp)
    80003d00:	64a2                	ld	s1,8(sp)
    80003d02:	6902                	ld	s2,0(sp)
    80003d04:	6105                	addi	sp,sp,32
    80003d06:	8082                	ret

0000000080003d08 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80003d08:	1101                	addi	sp,sp,-32
    80003d0a:	ec06                	sd	ra,24(sp)
    80003d0c:	e822                	sd	s0,16(sp)
    80003d0e:	e426                	sd	s1,8(sp)
    80003d10:	e04a                	sd	s2,0(sp)
    80003d12:	1000                	addi	s0,sp,32
    80003d14:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003d16:	00850913          	addi	s2,a0,8
    80003d1a:	854a                	mv	a0,s2
    80003d1c:	00003097          	auipc	ra,0x3
    80003d20:	afe080e7          	jalr	-1282(ra) # 8000681a <acquire>
  lk->locked = 0;
    80003d24:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003d28:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80003d2c:	8526                	mv	a0,s1
    80003d2e:	ffffe097          	auipc	ra,0xffffe
    80003d32:	c7a080e7          	jalr	-902(ra) # 800019a8 <wakeup>
  release(&lk->lk);
    80003d36:	854a                	mv	a0,s2
    80003d38:	00003097          	auipc	ra,0x3
    80003d3c:	b96080e7          	jalr	-1130(ra) # 800068ce <release>
}
    80003d40:	60e2                	ld	ra,24(sp)
    80003d42:	6442                	ld	s0,16(sp)
    80003d44:	64a2                	ld	s1,8(sp)
    80003d46:	6902                	ld	s2,0(sp)
    80003d48:	6105                	addi	sp,sp,32
    80003d4a:	8082                	ret

0000000080003d4c <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80003d4c:	7179                	addi	sp,sp,-48
    80003d4e:	f406                	sd	ra,40(sp)
    80003d50:	f022                	sd	s0,32(sp)
    80003d52:	ec26                	sd	s1,24(sp)
    80003d54:	e84a                	sd	s2,16(sp)
    80003d56:	e44e                	sd	s3,8(sp)
    80003d58:	1800                	addi	s0,sp,48
    80003d5a:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80003d5c:	00850913          	addi	s2,a0,8
    80003d60:	854a                	mv	a0,s2
    80003d62:	00003097          	auipc	ra,0x3
    80003d66:	ab8080e7          	jalr	-1352(ra) # 8000681a <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80003d6a:	409c                	lw	a5,0(s1)
    80003d6c:	ef99                	bnez	a5,80003d8a <holdingsleep+0x3e>
    80003d6e:	4481                	li	s1,0
  release(&lk->lk);
    80003d70:	854a                	mv	a0,s2
    80003d72:	00003097          	auipc	ra,0x3
    80003d76:	b5c080e7          	jalr	-1188(ra) # 800068ce <release>
  return r;
}
    80003d7a:	8526                	mv	a0,s1
    80003d7c:	70a2                	ld	ra,40(sp)
    80003d7e:	7402                	ld	s0,32(sp)
    80003d80:	64e2                	ld	s1,24(sp)
    80003d82:	6942                	ld	s2,16(sp)
    80003d84:	69a2                	ld	s3,8(sp)
    80003d86:	6145                	addi	sp,sp,48
    80003d88:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    80003d8a:	0284a983          	lw	s3,40(s1)
    80003d8e:	ffffd097          	auipc	ra,0xffffd
    80003d92:	3d2080e7          	jalr	978(ra) # 80001160 <myproc>
    80003d96:	5904                	lw	s1,48(a0)
    80003d98:	413484b3          	sub	s1,s1,s3
    80003d9c:	0014b493          	seqz	s1,s1
    80003da0:	bfc1                	j	80003d70 <holdingsleep+0x24>

0000000080003da2 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80003da2:	1141                	addi	sp,sp,-16
    80003da4:	e406                	sd	ra,8(sp)
    80003da6:	e022                	sd	s0,0(sp)
    80003da8:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003daa:	00005597          	auipc	a1,0x5
    80003dae:	9e658593          	addi	a1,a1,-1562 # 80008790 <syscalls+0x330>
    80003db2:	00015517          	auipc	a0,0x15
    80003db6:	3b650513          	addi	a0,a0,950 # 80019168 <ftable>
    80003dba:	00003097          	auipc	ra,0x3
    80003dbe:	9d0080e7          	jalr	-1584(ra) # 8000678a <initlock>
}
    80003dc2:	60a2                	ld	ra,8(sp)
    80003dc4:	6402                	ld	s0,0(sp)
    80003dc6:	0141                	addi	sp,sp,16
    80003dc8:	8082                	ret

0000000080003dca <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80003dca:	1101                	addi	sp,sp,-32
    80003dcc:	ec06                	sd	ra,24(sp)
    80003dce:	e822                	sd	s0,16(sp)
    80003dd0:	e426                	sd	s1,8(sp)
    80003dd2:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80003dd4:	00015517          	auipc	a0,0x15
    80003dd8:	39450513          	addi	a0,a0,916 # 80019168 <ftable>
    80003ddc:	00003097          	auipc	ra,0x3
    80003de0:	a3e080e7          	jalr	-1474(ra) # 8000681a <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003de4:	00015497          	auipc	s1,0x15
    80003de8:	39c48493          	addi	s1,s1,924 # 80019180 <ftable+0x18>
    80003dec:	00016717          	auipc	a4,0x16
    80003df0:	33470713          	addi	a4,a4,820 # 8001a120 <ftable+0xfb8>
    if(f->ref == 0){
    80003df4:	40dc                	lw	a5,4(s1)
    80003df6:	cf99                	beqz	a5,80003e14 <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003df8:	02848493          	addi	s1,s1,40
    80003dfc:	fee49ce3          	bne	s1,a4,80003df4 <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80003e00:	00015517          	auipc	a0,0x15
    80003e04:	36850513          	addi	a0,a0,872 # 80019168 <ftable>
    80003e08:	00003097          	auipc	ra,0x3
    80003e0c:	ac6080e7          	jalr	-1338(ra) # 800068ce <release>
  return 0;
    80003e10:	4481                	li	s1,0
    80003e12:	a819                	j	80003e28 <filealloc+0x5e>
      f->ref = 1;
    80003e14:	4785                	li	a5,1
    80003e16:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80003e18:	00015517          	auipc	a0,0x15
    80003e1c:	35050513          	addi	a0,a0,848 # 80019168 <ftable>
    80003e20:	00003097          	auipc	ra,0x3
    80003e24:	aae080e7          	jalr	-1362(ra) # 800068ce <release>
}
    80003e28:	8526                	mv	a0,s1
    80003e2a:	60e2                	ld	ra,24(sp)
    80003e2c:	6442                	ld	s0,16(sp)
    80003e2e:	64a2                	ld	s1,8(sp)
    80003e30:	6105                	addi	sp,sp,32
    80003e32:	8082                	ret

0000000080003e34 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80003e34:	1101                	addi	sp,sp,-32
    80003e36:	ec06                	sd	ra,24(sp)
    80003e38:	e822                	sd	s0,16(sp)
    80003e3a:	e426                	sd	s1,8(sp)
    80003e3c:	1000                	addi	s0,sp,32
    80003e3e:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80003e40:	00015517          	auipc	a0,0x15
    80003e44:	32850513          	addi	a0,a0,808 # 80019168 <ftable>
    80003e48:	00003097          	auipc	ra,0x3
    80003e4c:	9d2080e7          	jalr	-1582(ra) # 8000681a <acquire>
  if(f->ref < 1)
    80003e50:	40dc                	lw	a5,4(s1)
    80003e52:	02f05263          	blez	a5,80003e76 <filedup+0x42>
    panic("filedup");
  f->ref++;
    80003e56:	2785                	addiw	a5,a5,1
    80003e58:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80003e5a:	00015517          	auipc	a0,0x15
    80003e5e:	30e50513          	addi	a0,a0,782 # 80019168 <ftable>
    80003e62:	00003097          	auipc	ra,0x3
    80003e66:	a6c080e7          	jalr	-1428(ra) # 800068ce <release>
  return f;
}
    80003e6a:	8526                	mv	a0,s1
    80003e6c:	60e2                	ld	ra,24(sp)
    80003e6e:	6442                	ld	s0,16(sp)
    80003e70:	64a2                	ld	s1,8(sp)
    80003e72:	6105                	addi	sp,sp,32
    80003e74:	8082                	ret
    panic("filedup");
    80003e76:	00005517          	auipc	a0,0x5
    80003e7a:	92250513          	addi	a0,a0,-1758 # 80008798 <syscalls+0x338>
    80003e7e:	00002097          	auipc	ra,0x2
    80003e82:	452080e7          	jalr	1106(ra) # 800062d0 <panic>

0000000080003e86 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80003e86:	7139                	addi	sp,sp,-64
    80003e88:	fc06                	sd	ra,56(sp)
    80003e8a:	f822                	sd	s0,48(sp)
    80003e8c:	f426                	sd	s1,40(sp)
    80003e8e:	f04a                	sd	s2,32(sp)
    80003e90:	ec4e                	sd	s3,24(sp)
    80003e92:	e852                	sd	s4,16(sp)
    80003e94:	e456                	sd	s5,8(sp)
    80003e96:	0080                	addi	s0,sp,64
    80003e98:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80003e9a:	00015517          	auipc	a0,0x15
    80003e9e:	2ce50513          	addi	a0,a0,718 # 80019168 <ftable>
    80003ea2:	00003097          	auipc	ra,0x3
    80003ea6:	978080e7          	jalr	-1672(ra) # 8000681a <acquire>
  if(f->ref < 1)
    80003eaa:	40dc                	lw	a5,4(s1)
    80003eac:	06f05163          	blez	a5,80003f0e <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    80003eb0:	37fd                	addiw	a5,a5,-1
    80003eb2:	0007871b          	sext.w	a4,a5
    80003eb6:	c0dc                	sw	a5,4(s1)
    80003eb8:	06e04363          	bgtz	a4,80003f1e <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80003ebc:	0004a903          	lw	s2,0(s1)
    80003ec0:	0094ca83          	lbu	s5,9(s1)
    80003ec4:	0104ba03          	ld	s4,16(s1)
    80003ec8:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80003ecc:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80003ed0:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80003ed4:	00015517          	auipc	a0,0x15
    80003ed8:	29450513          	addi	a0,a0,660 # 80019168 <ftable>
    80003edc:	00003097          	auipc	ra,0x3
    80003ee0:	9f2080e7          	jalr	-1550(ra) # 800068ce <release>

  if(ff.type == FD_PIPE){
    80003ee4:	4785                	li	a5,1
    80003ee6:	04f90d63          	beq	s2,a5,80003f40 <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003eea:	3979                	addiw	s2,s2,-2
    80003eec:	4785                	li	a5,1
    80003eee:	0527e063          	bltu	a5,s2,80003f2e <fileclose+0xa8>
    begin_op();
    80003ef2:	00000097          	auipc	ra,0x0
    80003ef6:	ac8080e7          	jalr	-1336(ra) # 800039ba <begin_op>
    iput(ff.ip);
    80003efa:	854e                	mv	a0,s3
    80003efc:	fffff097          	auipc	ra,0xfffff
    80003f00:	11e080e7          	jalr	286(ra) # 8000301a <iput>
    end_op();
    80003f04:	00000097          	auipc	ra,0x0
    80003f08:	b36080e7          	jalr	-1226(ra) # 80003a3a <end_op>
    80003f0c:	a00d                	j	80003f2e <fileclose+0xa8>
    panic("fileclose");
    80003f0e:	00005517          	auipc	a0,0x5
    80003f12:	89250513          	addi	a0,a0,-1902 # 800087a0 <syscalls+0x340>
    80003f16:	00002097          	auipc	ra,0x2
    80003f1a:	3ba080e7          	jalr	954(ra) # 800062d0 <panic>
    release(&ftable.lock);
    80003f1e:	00015517          	auipc	a0,0x15
    80003f22:	24a50513          	addi	a0,a0,586 # 80019168 <ftable>
    80003f26:	00003097          	auipc	ra,0x3
    80003f2a:	9a8080e7          	jalr	-1624(ra) # 800068ce <release>
  }
}
    80003f2e:	70e2                	ld	ra,56(sp)
    80003f30:	7442                	ld	s0,48(sp)
    80003f32:	74a2                	ld	s1,40(sp)
    80003f34:	7902                	ld	s2,32(sp)
    80003f36:	69e2                	ld	s3,24(sp)
    80003f38:	6a42                	ld	s4,16(sp)
    80003f3a:	6aa2                	ld	s5,8(sp)
    80003f3c:	6121                	addi	sp,sp,64
    80003f3e:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80003f40:	85d6                	mv	a1,s5
    80003f42:	8552                	mv	a0,s4
    80003f44:	00000097          	auipc	ra,0x0
    80003f48:	34c080e7          	jalr	844(ra) # 80004290 <pipeclose>
    80003f4c:	b7cd                	j	80003f2e <fileclose+0xa8>

0000000080003f4e <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003f4e:	715d                	addi	sp,sp,-80
    80003f50:	e486                	sd	ra,72(sp)
    80003f52:	e0a2                	sd	s0,64(sp)
    80003f54:	fc26                	sd	s1,56(sp)
    80003f56:	f84a                	sd	s2,48(sp)
    80003f58:	f44e                	sd	s3,40(sp)
    80003f5a:	0880                	addi	s0,sp,80
    80003f5c:	84aa                	mv	s1,a0
    80003f5e:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80003f60:	ffffd097          	auipc	ra,0xffffd
    80003f64:	200080e7          	jalr	512(ra) # 80001160 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80003f68:	409c                	lw	a5,0(s1)
    80003f6a:	37f9                	addiw	a5,a5,-2
    80003f6c:	4705                	li	a4,1
    80003f6e:	04f76763          	bltu	a4,a5,80003fbc <filestat+0x6e>
    80003f72:	892a                	mv	s2,a0
    ilock(f->ip);
    80003f74:	6c88                	ld	a0,24(s1)
    80003f76:	fffff097          	auipc	ra,0xfffff
    80003f7a:	eea080e7          	jalr	-278(ra) # 80002e60 <ilock>
    stati(f->ip, &st);
    80003f7e:	fb840593          	addi	a1,s0,-72
    80003f82:	6c88                	ld	a0,24(s1)
    80003f84:	fffff097          	auipc	ra,0xfffff
    80003f88:	166080e7          	jalr	358(ra) # 800030ea <stati>
    iunlock(f->ip);
    80003f8c:	6c88                	ld	a0,24(s1)
    80003f8e:	fffff097          	auipc	ra,0xfffff
    80003f92:	f94080e7          	jalr	-108(ra) # 80002f22 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80003f96:	46e1                	li	a3,24
    80003f98:	fb840613          	addi	a2,s0,-72
    80003f9c:	85ce                	mv	a1,s3
    80003f9e:	05093503          	ld	a0,80(s2)
    80003fa2:	ffffd097          	auipc	ra,0xffffd
    80003fa6:	b60080e7          	jalr	-1184(ra) # 80000b02 <copyout>
    80003faa:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    80003fae:	60a6                	ld	ra,72(sp)
    80003fb0:	6406                	ld	s0,64(sp)
    80003fb2:	74e2                	ld	s1,56(sp)
    80003fb4:	7942                	ld	s2,48(sp)
    80003fb6:	79a2                	ld	s3,40(sp)
    80003fb8:	6161                	addi	sp,sp,80
    80003fba:	8082                	ret
  return -1;
    80003fbc:	557d                	li	a0,-1
    80003fbe:	bfc5                	j	80003fae <filestat+0x60>

0000000080003fc0 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80003fc0:	7179                	addi	sp,sp,-48
    80003fc2:	f406                	sd	ra,40(sp)
    80003fc4:	f022                	sd	s0,32(sp)
    80003fc6:	ec26                	sd	s1,24(sp)
    80003fc8:	e84a                	sd	s2,16(sp)
    80003fca:	e44e                	sd	s3,8(sp)
    80003fcc:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80003fce:	00854783          	lbu	a5,8(a0)
    80003fd2:	c3d5                	beqz	a5,80004076 <fileread+0xb6>
    80003fd4:	84aa                	mv	s1,a0
    80003fd6:	89ae                	mv	s3,a1
    80003fd8:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80003fda:	411c                	lw	a5,0(a0)
    80003fdc:	4705                	li	a4,1
    80003fde:	04e78963          	beq	a5,a4,80004030 <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003fe2:	470d                	li	a4,3
    80003fe4:	04e78d63          	beq	a5,a4,8000403e <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80003fe8:	4709                	li	a4,2
    80003fea:	06e79e63          	bne	a5,a4,80004066 <fileread+0xa6>
    ilock(f->ip);
    80003fee:	6d08                	ld	a0,24(a0)
    80003ff0:	fffff097          	auipc	ra,0xfffff
    80003ff4:	e70080e7          	jalr	-400(ra) # 80002e60 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80003ff8:	874a                	mv	a4,s2
    80003ffa:	5094                	lw	a3,32(s1)
    80003ffc:	864e                	mv	a2,s3
    80003ffe:	4585                	li	a1,1
    80004000:	6c88                	ld	a0,24(s1)
    80004002:	fffff097          	auipc	ra,0xfffff
    80004006:	112080e7          	jalr	274(ra) # 80003114 <readi>
    8000400a:	892a                	mv	s2,a0
    8000400c:	00a05563          	blez	a0,80004016 <fileread+0x56>
      f->off += r;
    80004010:	509c                	lw	a5,32(s1)
    80004012:	9fa9                	addw	a5,a5,a0
    80004014:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80004016:	6c88                	ld	a0,24(s1)
    80004018:	fffff097          	auipc	ra,0xfffff
    8000401c:	f0a080e7          	jalr	-246(ra) # 80002f22 <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    80004020:	854a                	mv	a0,s2
    80004022:	70a2                	ld	ra,40(sp)
    80004024:	7402                	ld	s0,32(sp)
    80004026:	64e2                	ld	s1,24(sp)
    80004028:	6942                	ld	s2,16(sp)
    8000402a:	69a2                	ld	s3,8(sp)
    8000402c:	6145                	addi	sp,sp,48
    8000402e:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80004030:	6908                	ld	a0,16(a0)
    80004032:	00000097          	auipc	ra,0x0
    80004036:	3c8080e7          	jalr	968(ra) # 800043fa <piperead>
    8000403a:	892a                	mv	s2,a0
    8000403c:	b7d5                	j	80004020 <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    8000403e:	02451783          	lh	a5,36(a0)
    80004042:	03079693          	slli	a3,a5,0x30
    80004046:	92c1                	srli	a3,a3,0x30
    80004048:	4725                	li	a4,9
    8000404a:	02d76863          	bltu	a4,a3,8000407a <fileread+0xba>
    8000404e:	0792                	slli	a5,a5,0x4
    80004050:	00015717          	auipc	a4,0x15
    80004054:	07870713          	addi	a4,a4,120 # 800190c8 <devsw>
    80004058:	97ba                	add	a5,a5,a4
    8000405a:	639c                	ld	a5,0(a5)
    8000405c:	c38d                	beqz	a5,8000407e <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    8000405e:	4505                	li	a0,1
    80004060:	9782                	jalr	a5
    80004062:	892a                	mv	s2,a0
    80004064:	bf75                	j	80004020 <fileread+0x60>
    panic("fileread");
    80004066:	00004517          	auipc	a0,0x4
    8000406a:	74a50513          	addi	a0,a0,1866 # 800087b0 <syscalls+0x350>
    8000406e:	00002097          	auipc	ra,0x2
    80004072:	262080e7          	jalr	610(ra) # 800062d0 <panic>
    return -1;
    80004076:	597d                	li	s2,-1
    80004078:	b765                	j	80004020 <fileread+0x60>
      return -1;
    8000407a:	597d                	li	s2,-1
    8000407c:	b755                	j	80004020 <fileread+0x60>
    8000407e:	597d                	li	s2,-1
    80004080:	b745                	j	80004020 <fileread+0x60>

0000000080004082 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80004082:	715d                	addi	sp,sp,-80
    80004084:	e486                	sd	ra,72(sp)
    80004086:	e0a2                	sd	s0,64(sp)
    80004088:	fc26                	sd	s1,56(sp)
    8000408a:	f84a                	sd	s2,48(sp)
    8000408c:	f44e                	sd	s3,40(sp)
    8000408e:	f052                	sd	s4,32(sp)
    80004090:	ec56                	sd	s5,24(sp)
    80004092:	e85a                	sd	s6,16(sp)
    80004094:	e45e                	sd	s7,8(sp)
    80004096:	e062                	sd	s8,0(sp)
    80004098:	0880                	addi	s0,sp,80
  int r, ret = 0;

  if(f->writable == 0)
    8000409a:	00954783          	lbu	a5,9(a0)
    8000409e:	10078663          	beqz	a5,800041aa <filewrite+0x128>
    800040a2:	892a                	mv	s2,a0
    800040a4:	8aae                	mv	s5,a1
    800040a6:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    800040a8:	411c                	lw	a5,0(a0)
    800040aa:	4705                	li	a4,1
    800040ac:	02e78263          	beq	a5,a4,800040d0 <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    800040b0:	470d                	li	a4,3
    800040b2:	02e78663          	beq	a5,a4,800040de <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    800040b6:	4709                	li	a4,2
    800040b8:	0ee79163          	bne	a5,a4,8000419a <filewrite+0x118>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    800040bc:	0ac05d63          	blez	a2,80004176 <filewrite+0xf4>
    int i = 0;
    800040c0:	4981                	li	s3,0
    800040c2:	6b05                	lui	s6,0x1
    800040c4:	c00b0b13          	addi	s6,s6,-1024 # c00 <_entry-0x7ffff400>
    800040c8:	6b85                	lui	s7,0x1
    800040ca:	c00b8b9b          	addiw	s7,s7,-1024
    800040ce:	a861                	j	80004166 <filewrite+0xe4>
    ret = pipewrite(f->pipe, addr, n);
    800040d0:	6908                	ld	a0,16(a0)
    800040d2:	00000097          	auipc	ra,0x0
    800040d6:	22e080e7          	jalr	558(ra) # 80004300 <pipewrite>
    800040da:	8a2a                	mv	s4,a0
    800040dc:	a045                	j	8000417c <filewrite+0xfa>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    800040de:	02451783          	lh	a5,36(a0)
    800040e2:	03079693          	slli	a3,a5,0x30
    800040e6:	92c1                	srli	a3,a3,0x30
    800040e8:	4725                	li	a4,9
    800040ea:	0cd76263          	bltu	a4,a3,800041ae <filewrite+0x12c>
    800040ee:	0792                	slli	a5,a5,0x4
    800040f0:	00015717          	auipc	a4,0x15
    800040f4:	fd870713          	addi	a4,a4,-40 # 800190c8 <devsw>
    800040f8:	97ba                	add	a5,a5,a4
    800040fa:	679c                	ld	a5,8(a5)
    800040fc:	cbdd                	beqz	a5,800041b2 <filewrite+0x130>
    ret = devsw[f->major].write(1, addr, n);
    800040fe:	4505                	li	a0,1
    80004100:	9782                	jalr	a5
    80004102:	8a2a                	mv	s4,a0
    80004104:	a8a5                	j	8000417c <filewrite+0xfa>
    80004106:	00048c1b          	sext.w	s8,s1
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
    8000410a:	00000097          	auipc	ra,0x0
    8000410e:	8b0080e7          	jalr	-1872(ra) # 800039ba <begin_op>
      ilock(f->ip);
    80004112:	01893503          	ld	a0,24(s2)
    80004116:	fffff097          	auipc	ra,0xfffff
    8000411a:	d4a080e7          	jalr	-694(ra) # 80002e60 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    8000411e:	8762                	mv	a4,s8
    80004120:	02092683          	lw	a3,32(s2)
    80004124:	01598633          	add	a2,s3,s5
    80004128:	4585                	li	a1,1
    8000412a:	01893503          	ld	a0,24(s2)
    8000412e:	fffff097          	auipc	ra,0xfffff
    80004132:	0de080e7          	jalr	222(ra) # 8000320c <writei>
    80004136:	84aa                	mv	s1,a0
    80004138:	00a05763          	blez	a0,80004146 <filewrite+0xc4>
        f->off += r;
    8000413c:	02092783          	lw	a5,32(s2)
    80004140:	9fa9                	addw	a5,a5,a0
    80004142:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80004146:	01893503          	ld	a0,24(s2)
    8000414a:	fffff097          	auipc	ra,0xfffff
    8000414e:	dd8080e7          	jalr	-552(ra) # 80002f22 <iunlock>
      end_op();
    80004152:	00000097          	auipc	ra,0x0
    80004156:	8e8080e7          	jalr	-1816(ra) # 80003a3a <end_op>

      if(r != n1){
    8000415a:	009c1f63          	bne	s8,s1,80004178 <filewrite+0xf6>
        // error from writei
        break;
      }
      i += r;
    8000415e:	013489bb          	addw	s3,s1,s3
    while(i < n){
    80004162:	0149db63          	bge	s3,s4,80004178 <filewrite+0xf6>
      int n1 = n - i;
    80004166:	413a07bb          	subw	a5,s4,s3
      if(n1 > max)
    8000416a:	84be                	mv	s1,a5
    8000416c:	2781                	sext.w	a5,a5
    8000416e:	f8fb5ce3          	bge	s6,a5,80004106 <filewrite+0x84>
    80004172:	84de                	mv	s1,s7
    80004174:	bf49                	j	80004106 <filewrite+0x84>
    int i = 0;
    80004176:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    80004178:	013a1f63          	bne	s4,s3,80004196 <filewrite+0x114>
  } else {
    panic("filewrite");
  }

  return ret;
}
    8000417c:	8552                	mv	a0,s4
    8000417e:	60a6                	ld	ra,72(sp)
    80004180:	6406                	ld	s0,64(sp)
    80004182:	74e2                	ld	s1,56(sp)
    80004184:	7942                	ld	s2,48(sp)
    80004186:	79a2                	ld	s3,40(sp)
    80004188:	7a02                	ld	s4,32(sp)
    8000418a:	6ae2                	ld	s5,24(sp)
    8000418c:	6b42                	ld	s6,16(sp)
    8000418e:	6ba2                	ld	s7,8(sp)
    80004190:	6c02                	ld	s8,0(sp)
    80004192:	6161                	addi	sp,sp,80
    80004194:	8082                	ret
    ret = (i == n ? n : -1);
    80004196:	5a7d                	li	s4,-1
    80004198:	b7d5                	j	8000417c <filewrite+0xfa>
    panic("filewrite");
    8000419a:	00004517          	auipc	a0,0x4
    8000419e:	62650513          	addi	a0,a0,1574 # 800087c0 <syscalls+0x360>
    800041a2:	00002097          	auipc	ra,0x2
    800041a6:	12e080e7          	jalr	302(ra) # 800062d0 <panic>
    return -1;
    800041aa:	5a7d                	li	s4,-1
    800041ac:	bfc1                	j	8000417c <filewrite+0xfa>
      return -1;
    800041ae:	5a7d                	li	s4,-1
    800041b0:	b7f1                	j	8000417c <filewrite+0xfa>
    800041b2:	5a7d                	li	s4,-1
    800041b4:	b7e1                	j	8000417c <filewrite+0xfa>

00000000800041b6 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    800041b6:	7179                	addi	sp,sp,-48
    800041b8:	f406                	sd	ra,40(sp)
    800041ba:	f022                	sd	s0,32(sp)
    800041bc:	ec26                	sd	s1,24(sp)
    800041be:	e84a                	sd	s2,16(sp)
    800041c0:	e44e                	sd	s3,8(sp)
    800041c2:	e052                	sd	s4,0(sp)
    800041c4:	1800                	addi	s0,sp,48
    800041c6:	84aa                	mv	s1,a0
    800041c8:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    800041ca:	0005b023          	sd	zero,0(a1)
    800041ce:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    800041d2:	00000097          	auipc	ra,0x0
    800041d6:	bf8080e7          	jalr	-1032(ra) # 80003dca <filealloc>
    800041da:	e088                	sd	a0,0(s1)
    800041dc:	c551                	beqz	a0,80004268 <pipealloc+0xb2>
    800041de:	00000097          	auipc	ra,0x0
    800041e2:	bec080e7          	jalr	-1044(ra) # 80003dca <filealloc>
    800041e6:	00aa3023          	sd	a0,0(s4)
    800041ea:	c92d                	beqz	a0,8000425c <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    800041ec:	ffffc097          	auipc	ra,0xffffc
    800041f0:	f2c080e7          	jalr	-212(ra) # 80000118 <kalloc>
    800041f4:	892a                	mv	s2,a0
    800041f6:	c125                	beqz	a0,80004256 <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    800041f8:	4985                	li	s3,1
    800041fa:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    800041fe:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80004202:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80004206:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    8000420a:	00004597          	auipc	a1,0x4
    8000420e:	5c658593          	addi	a1,a1,1478 # 800087d0 <syscalls+0x370>
    80004212:	00002097          	auipc	ra,0x2
    80004216:	578080e7          	jalr	1400(ra) # 8000678a <initlock>
  (*f0)->type = FD_PIPE;
    8000421a:	609c                	ld	a5,0(s1)
    8000421c:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80004220:	609c                	ld	a5,0(s1)
    80004222:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80004226:	609c                	ld	a5,0(s1)
    80004228:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    8000422c:	609c                	ld	a5,0(s1)
    8000422e:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80004232:	000a3783          	ld	a5,0(s4)
    80004236:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    8000423a:	000a3783          	ld	a5,0(s4)
    8000423e:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80004242:	000a3783          	ld	a5,0(s4)
    80004246:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    8000424a:	000a3783          	ld	a5,0(s4)
    8000424e:	0127b823          	sd	s2,16(a5)
  return 0;
    80004252:	4501                	li	a0,0
    80004254:	a025                	j	8000427c <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80004256:	6088                	ld	a0,0(s1)
    80004258:	e501                	bnez	a0,80004260 <pipealloc+0xaa>
    8000425a:	a039                	j	80004268 <pipealloc+0xb2>
    8000425c:	6088                	ld	a0,0(s1)
    8000425e:	c51d                	beqz	a0,8000428c <pipealloc+0xd6>
    fileclose(*f0);
    80004260:	00000097          	auipc	ra,0x0
    80004264:	c26080e7          	jalr	-986(ra) # 80003e86 <fileclose>
  if(*f1)
    80004268:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    8000426c:	557d                	li	a0,-1
  if(*f1)
    8000426e:	c799                	beqz	a5,8000427c <pipealloc+0xc6>
    fileclose(*f1);
    80004270:	853e                	mv	a0,a5
    80004272:	00000097          	auipc	ra,0x0
    80004276:	c14080e7          	jalr	-1004(ra) # 80003e86 <fileclose>
  return -1;
    8000427a:	557d                	li	a0,-1
}
    8000427c:	70a2                	ld	ra,40(sp)
    8000427e:	7402                	ld	s0,32(sp)
    80004280:	64e2                	ld	s1,24(sp)
    80004282:	6942                	ld	s2,16(sp)
    80004284:	69a2                	ld	s3,8(sp)
    80004286:	6a02                	ld	s4,0(sp)
    80004288:	6145                	addi	sp,sp,48
    8000428a:	8082                	ret
  return -1;
    8000428c:	557d                	li	a0,-1
    8000428e:	b7fd                	j	8000427c <pipealloc+0xc6>

0000000080004290 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80004290:	1101                	addi	sp,sp,-32
    80004292:	ec06                	sd	ra,24(sp)
    80004294:	e822                	sd	s0,16(sp)
    80004296:	e426                	sd	s1,8(sp)
    80004298:	e04a                	sd	s2,0(sp)
    8000429a:	1000                	addi	s0,sp,32
    8000429c:	84aa                	mv	s1,a0
    8000429e:	892e                	mv	s2,a1
  acquire(&pi->lock);
    800042a0:	00002097          	auipc	ra,0x2
    800042a4:	57a080e7          	jalr	1402(ra) # 8000681a <acquire>
  if(writable){
    800042a8:	02090d63          	beqz	s2,800042e2 <pipeclose+0x52>
    pi->writeopen = 0;
    800042ac:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    800042b0:	21848513          	addi	a0,s1,536
    800042b4:	ffffd097          	auipc	ra,0xffffd
    800042b8:	6f4080e7          	jalr	1780(ra) # 800019a8 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    800042bc:	2204b783          	ld	a5,544(s1)
    800042c0:	eb95                	bnez	a5,800042f4 <pipeclose+0x64>
    release(&pi->lock);
    800042c2:	8526                	mv	a0,s1
    800042c4:	00002097          	auipc	ra,0x2
    800042c8:	60a080e7          	jalr	1546(ra) # 800068ce <release>
    kfree((char*)pi);
    800042cc:	8526                	mv	a0,s1
    800042ce:	ffffc097          	auipc	ra,0xffffc
    800042d2:	d4e080e7          	jalr	-690(ra) # 8000001c <kfree>
  } else
    release(&pi->lock);
}
    800042d6:	60e2                	ld	ra,24(sp)
    800042d8:	6442                	ld	s0,16(sp)
    800042da:	64a2                	ld	s1,8(sp)
    800042dc:	6902                	ld	s2,0(sp)
    800042de:	6105                	addi	sp,sp,32
    800042e0:	8082                	ret
    pi->readopen = 0;
    800042e2:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    800042e6:	21c48513          	addi	a0,s1,540
    800042ea:	ffffd097          	auipc	ra,0xffffd
    800042ee:	6be080e7          	jalr	1726(ra) # 800019a8 <wakeup>
    800042f2:	b7e9                	j	800042bc <pipeclose+0x2c>
    release(&pi->lock);
    800042f4:	8526                	mv	a0,s1
    800042f6:	00002097          	auipc	ra,0x2
    800042fa:	5d8080e7          	jalr	1496(ra) # 800068ce <release>
}
    800042fe:	bfe1                	j	800042d6 <pipeclose+0x46>

0000000080004300 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80004300:	7159                	addi	sp,sp,-112
    80004302:	f486                	sd	ra,104(sp)
    80004304:	f0a2                	sd	s0,96(sp)
    80004306:	eca6                	sd	s1,88(sp)
    80004308:	e8ca                	sd	s2,80(sp)
    8000430a:	e4ce                	sd	s3,72(sp)
    8000430c:	e0d2                	sd	s4,64(sp)
    8000430e:	fc56                	sd	s5,56(sp)
    80004310:	f85a                	sd	s6,48(sp)
    80004312:	f45e                	sd	s7,40(sp)
    80004314:	f062                	sd	s8,32(sp)
    80004316:	ec66                	sd	s9,24(sp)
    80004318:	1880                	addi	s0,sp,112
    8000431a:	84aa                	mv	s1,a0
    8000431c:	8aae                	mv	s5,a1
    8000431e:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80004320:	ffffd097          	auipc	ra,0xffffd
    80004324:	e40080e7          	jalr	-448(ra) # 80001160 <myproc>
    80004328:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    8000432a:	8526                	mv	a0,s1
    8000432c:	00002097          	auipc	ra,0x2
    80004330:	4ee080e7          	jalr	1262(ra) # 8000681a <acquire>
  while(i < n){
    80004334:	0d405163          	blez	s4,800043f6 <pipewrite+0xf6>
    80004338:	8ba6                	mv	s7,s1
  int i = 0;
    8000433a:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    8000433c:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    8000433e:	21848c93          	addi	s9,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80004342:	21c48c13          	addi	s8,s1,540
    80004346:	a08d                	j	800043a8 <pipewrite+0xa8>
      release(&pi->lock);
    80004348:	8526                	mv	a0,s1
    8000434a:	00002097          	auipc	ra,0x2
    8000434e:	584080e7          	jalr	1412(ra) # 800068ce <release>
      return -1;
    80004352:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80004354:	854a                	mv	a0,s2
    80004356:	70a6                	ld	ra,104(sp)
    80004358:	7406                	ld	s0,96(sp)
    8000435a:	64e6                	ld	s1,88(sp)
    8000435c:	6946                	ld	s2,80(sp)
    8000435e:	69a6                	ld	s3,72(sp)
    80004360:	6a06                	ld	s4,64(sp)
    80004362:	7ae2                	ld	s5,56(sp)
    80004364:	7b42                	ld	s6,48(sp)
    80004366:	7ba2                	ld	s7,40(sp)
    80004368:	7c02                	ld	s8,32(sp)
    8000436a:	6ce2                	ld	s9,24(sp)
    8000436c:	6165                	addi	sp,sp,112
    8000436e:	8082                	ret
      wakeup(&pi->nread);
    80004370:	8566                	mv	a0,s9
    80004372:	ffffd097          	auipc	ra,0xffffd
    80004376:	636080e7          	jalr	1590(ra) # 800019a8 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    8000437a:	85de                	mv	a1,s7
    8000437c:	8562                	mv	a0,s8
    8000437e:	ffffd097          	auipc	ra,0xffffd
    80004382:	49e080e7          	jalr	1182(ra) # 8000181c <sleep>
    80004386:	a839                	j	800043a4 <pipewrite+0xa4>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80004388:	21c4a783          	lw	a5,540(s1)
    8000438c:	0017871b          	addiw	a4,a5,1
    80004390:	20e4ae23          	sw	a4,540(s1)
    80004394:	1ff7f793          	andi	a5,a5,511
    80004398:	97a6                	add	a5,a5,s1
    8000439a:	f9f44703          	lbu	a4,-97(s0)
    8000439e:	00e78c23          	sb	a4,24(a5)
      i++;
    800043a2:	2905                	addiw	s2,s2,1
  while(i < n){
    800043a4:	03495d63          	bge	s2,s4,800043de <pipewrite+0xde>
    if(pi->readopen == 0 || pr->killed){
    800043a8:	2204a783          	lw	a5,544(s1)
    800043ac:	dfd1                	beqz	a5,80004348 <pipewrite+0x48>
    800043ae:	0289a783          	lw	a5,40(s3)
    800043b2:	fbd9                	bnez	a5,80004348 <pipewrite+0x48>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    800043b4:	2184a783          	lw	a5,536(s1)
    800043b8:	21c4a703          	lw	a4,540(s1)
    800043bc:	2007879b          	addiw	a5,a5,512
    800043c0:	faf708e3          	beq	a4,a5,80004370 <pipewrite+0x70>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    800043c4:	4685                	li	a3,1
    800043c6:	01590633          	add	a2,s2,s5
    800043ca:	f9f40593          	addi	a1,s0,-97
    800043ce:	0509b503          	ld	a0,80(s3)
    800043d2:	ffffc097          	auipc	ra,0xffffc
    800043d6:	7bc080e7          	jalr	1980(ra) # 80000b8e <copyin>
    800043da:	fb6517e3          	bne	a0,s6,80004388 <pipewrite+0x88>
  wakeup(&pi->nread);
    800043de:	21848513          	addi	a0,s1,536
    800043e2:	ffffd097          	auipc	ra,0xffffd
    800043e6:	5c6080e7          	jalr	1478(ra) # 800019a8 <wakeup>
  release(&pi->lock);
    800043ea:	8526                	mv	a0,s1
    800043ec:	00002097          	auipc	ra,0x2
    800043f0:	4e2080e7          	jalr	1250(ra) # 800068ce <release>
  return i;
    800043f4:	b785                	j	80004354 <pipewrite+0x54>
  int i = 0;
    800043f6:	4901                	li	s2,0
    800043f8:	b7dd                	j	800043de <pipewrite+0xde>

00000000800043fa <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    800043fa:	715d                	addi	sp,sp,-80
    800043fc:	e486                	sd	ra,72(sp)
    800043fe:	e0a2                	sd	s0,64(sp)
    80004400:	fc26                	sd	s1,56(sp)
    80004402:	f84a                	sd	s2,48(sp)
    80004404:	f44e                	sd	s3,40(sp)
    80004406:	f052                	sd	s4,32(sp)
    80004408:	ec56                	sd	s5,24(sp)
    8000440a:	e85a                	sd	s6,16(sp)
    8000440c:	0880                	addi	s0,sp,80
    8000440e:	84aa                	mv	s1,a0
    80004410:	892e                	mv	s2,a1
    80004412:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80004414:	ffffd097          	auipc	ra,0xffffd
    80004418:	d4c080e7          	jalr	-692(ra) # 80001160 <myproc>
    8000441c:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    8000441e:	8b26                	mv	s6,s1
    80004420:	8526                	mv	a0,s1
    80004422:	00002097          	auipc	ra,0x2
    80004426:	3f8080e7          	jalr	1016(ra) # 8000681a <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    8000442a:	2184a703          	lw	a4,536(s1)
    8000442e:	21c4a783          	lw	a5,540(s1)
    if(pr->killed){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004432:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004436:	02f71463          	bne	a4,a5,8000445e <piperead+0x64>
    8000443a:	2244a783          	lw	a5,548(s1)
    8000443e:	c385                	beqz	a5,8000445e <piperead+0x64>
    if(pr->killed){
    80004440:	028a2783          	lw	a5,40(s4)
    80004444:	ebc1                	bnez	a5,800044d4 <piperead+0xda>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004446:	85da                	mv	a1,s6
    80004448:	854e                	mv	a0,s3
    8000444a:	ffffd097          	auipc	ra,0xffffd
    8000444e:	3d2080e7          	jalr	978(ra) # 8000181c <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004452:	2184a703          	lw	a4,536(s1)
    80004456:	21c4a783          	lw	a5,540(s1)
    8000445a:	fef700e3          	beq	a4,a5,8000443a <piperead+0x40>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000445e:	09505263          	blez	s5,800044e2 <piperead+0xe8>
    80004462:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004464:	5b7d                	li	s6,-1
    if(pi->nread == pi->nwrite)
    80004466:	2184a783          	lw	a5,536(s1)
    8000446a:	21c4a703          	lw	a4,540(s1)
    8000446e:	02f70d63          	beq	a4,a5,800044a8 <piperead+0xae>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80004472:	0017871b          	addiw	a4,a5,1
    80004476:	20e4ac23          	sw	a4,536(s1)
    8000447a:	1ff7f793          	andi	a5,a5,511
    8000447e:	97a6                	add	a5,a5,s1
    80004480:	0187c783          	lbu	a5,24(a5)
    80004484:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004488:	4685                	li	a3,1
    8000448a:	fbf40613          	addi	a2,s0,-65
    8000448e:	85ca                	mv	a1,s2
    80004490:	050a3503          	ld	a0,80(s4)
    80004494:	ffffc097          	auipc	ra,0xffffc
    80004498:	66e080e7          	jalr	1646(ra) # 80000b02 <copyout>
    8000449c:	01650663          	beq	a0,s6,800044a8 <piperead+0xae>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800044a0:	2985                	addiw	s3,s3,1
    800044a2:	0905                	addi	s2,s2,1
    800044a4:	fd3a91e3          	bne	s5,s3,80004466 <piperead+0x6c>
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    800044a8:	21c48513          	addi	a0,s1,540
    800044ac:	ffffd097          	auipc	ra,0xffffd
    800044b0:	4fc080e7          	jalr	1276(ra) # 800019a8 <wakeup>
  release(&pi->lock);
    800044b4:	8526                	mv	a0,s1
    800044b6:	00002097          	auipc	ra,0x2
    800044ba:	418080e7          	jalr	1048(ra) # 800068ce <release>
  return i;
}
    800044be:	854e                	mv	a0,s3
    800044c0:	60a6                	ld	ra,72(sp)
    800044c2:	6406                	ld	s0,64(sp)
    800044c4:	74e2                	ld	s1,56(sp)
    800044c6:	7942                	ld	s2,48(sp)
    800044c8:	79a2                	ld	s3,40(sp)
    800044ca:	7a02                	ld	s4,32(sp)
    800044cc:	6ae2                	ld	s5,24(sp)
    800044ce:	6b42                	ld	s6,16(sp)
    800044d0:	6161                	addi	sp,sp,80
    800044d2:	8082                	ret
      release(&pi->lock);
    800044d4:	8526                	mv	a0,s1
    800044d6:	00002097          	auipc	ra,0x2
    800044da:	3f8080e7          	jalr	1016(ra) # 800068ce <release>
      return -1;
    800044de:	59fd                	li	s3,-1
    800044e0:	bff9                	j	800044be <piperead+0xc4>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800044e2:	4981                	li	s3,0
    800044e4:	b7d1                	j	800044a8 <piperead+0xae>

00000000800044e6 <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    800044e6:	df010113          	addi	sp,sp,-528
    800044ea:	20113423          	sd	ra,520(sp)
    800044ee:	20813023          	sd	s0,512(sp)
    800044f2:	ffa6                	sd	s1,504(sp)
    800044f4:	fbca                	sd	s2,496(sp)
    800044f6:	f7ce                	sd	s3,488(sp)
    800044f8:	f3d2                	sd	s4,480(sp)
    800044fa:	efd6                	sd	s5,472(sp)
    800044fc:	ebda                	sd	s6,464(sp)
    800044fe:	e7de                	sd	s7,456(sp)
    80004500:	e3e2                	sd	s8,448(sp)
    80004502:	ff66                	sd	s9,440(sp)
    80004504:	fb6a                	sd	s10,432(sp)
    80004506:	f76e                	sd	s11,424(sp)
    80004508:	0c00                	addi	s0,sp,528
    8000450a:	84aa                	mv	s1,a0
    8000450c:	dea43c23          	sd	a0,-520(s0)
    80004510:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80004514:	ffffd097          	auipc	ra,0xffffd
    80004518:	c4c080e7          	jalr	-948(ra) # 80001160 <myproc>
    8000451c:	892a                	mv	s2,a0

  begin_op();
    8000451e:	fffff097          	auipc	ra,0xfffff
    80004522:	49c080e7          	jalr	1180(ra) # 800039ba <begin_op>

  if((ip = namei(path)) == 0){
    80004526:	8526                	mv	a0,s1
    80004528:	fffff097          	auipc	ra,0xfffff
    8000452c:	0e4080e7          	jalr	228(ra) # 8000360c <namei>
    80004530:	c92d                	beqz	a0,800045a2 <exec+0xbc>
    80004532:	84aa                	mv	s1,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80004534:	fffff097          	auipc	ra,0xfffff
    80004538:	92c080e7          	jalr	-1748(ra) # 80002e60 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    8000453c:	04000713          	li	a4,64
    80004540:	4681                	li	a3,0
    80004542:	e5040613          	addi	a2,s0,-432
    80004546:	4581                	li	a1,0
    80004548:	8526                	mv	a0,s1
    8000454a:	fffff097          	auipc	ra,0xfffff
    8000454e:	bca080e7          	jalr	-1078(ra) # 80003114 <readi>
    80004552:	04000793          	li	a5,64
    80004556:	00f51a63          	bne	a0,a5,8000456a <exec+0x84>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    8000455a:	e5042703          	lw	a4,-432(s0)
    8000455e:	464c47b7          	lui	a5,0x464c4
    80004562:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80004566:	04f70463          	beq	a4,a5,800045ae <exec+0xc8>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    8000456a:	8526                	mv	a0,s1
    8000456c:	fffff097          	auipc	ra,0xfffff
    80004570:	b56080e7          	jalr	-1194(ra) # 800030c2 <iunlockput>
    end_op();
    80004574:	fffff097          	auipc	ra,0xfffff
    80004578:	4c6080e7          	jalr	1222(ra) # 80003a3a <end_op>
  }
  return -1;
    8000457c:	557d                	li	a0,-1
}
    8000457e:	20813083          	ld	ra,520(sp)
    80004582:	20013403          	ld	s0,512(sp)
    80004586:	74fe                	ld	s1,504(sp)
    80004588:	795e                	ld	s2,496(sp)
    8000458a:	79be                	ld	s3,488(sp)
    8000458c:	7a1e                	ld	s4,480(sp)
    8000458e:	6afe                	ld	s5,472(sp)
    80004590:	6b5e                	ld	s6,464(sp)
    80004592:	6bbe                	ld	s7,456(sp)
    80004594:	6c1e                	ld	s8,448(sp)
    80004596:	7cfa                	ld	s9,440(sp)
    80004598:	7d5a                	ld	s10,432(sp)
    8000459a:	7dba                	ld	s11,424(sp)
    8000459c:	21010113          	addi	sp,sp,528
    800045a0:	8082                	ret
    end_op();
    800045a2:	fffff097          	auipc	ra,0xfffff
    800045a6:	498080e7          	jalr	1176(ra) # 80003a3a <end_op>
    return -1;
    800045aa:	557d                	li	a0,-1
    800045ac:	bfc9                	j	8000457e <exec+0x98>
  if((pagetable = proc_pagetable(p)) == 0)
    800045ae:	854a                	mv	a0,s2
    800045b0:	ffffd097          	auipc	ra,0xffffd
    800045b4:	c74080e7          	jalr	-908(ra) # 80001224 <proc_pagetable>
    800045b8:	8baa                	mv	s7,a0
    800045ba:	d945                	beqz	a0,8000456a <exec+0x84>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800045bc:	e7042983          	lw	s3,-400(s0)
    800045c0:	e8845783          	lhu	a5,-376(s0)
    800045c4:	c7ad                	beqz	a5,8000462e <exec+0x148>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    800045c6:	4901                	li	s2,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800045c8:	4b01                	li	s6,0
    if((ph.vaddr % PGSIZE) != 0)
    800045ca:	6c85                	lui	s9,0x1
    800045cc:	fffc8793          	addi	a5,s9,-1 # fff <_entry-0x7ffff001>
    800045d0:	def43823          	sd	a5,-528(s0)
    800045d4:	a42d                	j	800047fe <exec+0x318>
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    800045d6:	00004517          	auipc	a0,0x4
    800045da:	20250513          	addi	a0,a0,514 # 800087d8 <syscalls+0x378>
    800045de:	00002097          	auipc	ra,0x2
    800045e2:	cf2080e7          	jalr	-782(ra) # 800062d0 <panic>
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    800045e6:	8756                	mv	a4,s5
    800045e8:	012d86bb          	addw	a3,s11,s2
    800045ec:	4581                	li	a1,0
    800045ee:	8526                	mv	a0,s1
    800045f0:	fffff097          	auipc	ra,0xfffff
    800045f4:	b24080e7          	jalr	-1244(ra) # 80003114 <readi>
    800045f8:	2501                	sext.w	a0,a0
    800045fa:	1aaa9963          	bne	s5,a0,800047ac <exec+0x2c6>
  for(i = 0; i < sz; i += PGSIZE){
    800045fe:	6785                	lui	a5,0x1
    80004600:	0127893b          	addw	s2,a5,s2
    80004604:	77fd                	lui	a5,0xfffff
    80004606:	01478a3b          	addw	s4,a5,s4
    8000460a:	1f897163          	bgeu	s2,s8,800047ec <exec+0x306>
    pa = walkaddr(pagetable, va + i);
    8000460e:	02091593          	slli	a1,s2,0x20
    80004612:	9181                	srli	a1,a1,0x20
    80004614:	95ea                	add	a1,a1,s10
    80004616:	855e                	mv	a0,s7
    80004618:	ffffc097          	auipc	ra,0xffffc
    8000461c:	eee080e7          	jalr	-274(ra) # 80000506 <walkaddr>
    80004620:	862a                	mv	a2,a0
    if(pa == 0)
    80004622:	d955                	beqz	a0,800045d6 <exec+0xf0>
      n = PGSIZE;
    80004624:	8ae6                	mv	s5,s9
    if(sz - i < PGSIZE)
    80004626:	fd9a70e3          	bgeu	s4,s9,800045e6 <exec+0x100>
      n = sz - i;
    8000462a:	8ad2                	mv	s5,s4
    8000462c:	bf6d                	j	800045e6 <exec+0x100>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    8000462e:	4901                	li	s2,0
  iunlockput(ip);
    80004630:	8526                	mv	a0,s1
    80004632:	fffff097          	auipc	ra,0xfffff
    80004636:	a90080e7          	jalr	-1392(ra) # 800030c2 <iunlockput>
  end_op();
    8000463a:	fffff097          	auipc	ra,0xfffff
    8000463e:	400080e7          	jalr	1024(ra) # 80003a3a <end_op>
  p = myproc();
    80004642:	ffffd097          	auipc	ra,0xffffd
    80004646:	b1e080e7          	jalr	-1250(ra) # 80001160 <myproc>
    8000464a:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    8000464c:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    80004650:	6785                	lui	a5,0x1
    80004652:	17fd                	addi	a5,a5,-1
    80004654:	993e                	add	s2,s2,a5
    80004656:	757d                	lui	a0,0xfffff
    80004658:	00a977b3          	and	a5,s2,a0
    8000465c:	e0f43423          	sd	a5,-504(s0)
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80004660:	6609                	lui	a2,0x2
    80004662:	963e                	add	a2,a2,a5
    80004664:	85be                	mv	a1,a5
    80004666:	855e                	mv	a0,s7
    80004668:	ffffc097          	auipc	ra,0xffffc
    8000466c:	24a080e7          	jalr	586(ra) # 800008b2 <uvmalloc>
    80004670:	8b2a                	mv	s6,a0
  ip = 0;
    80004672:	4481                	li	s1,0
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80004674:	12050c63          	beqz	a0,800047ac <exec+0x2c6>
  uvmclear(pagetable, sz-2*PGSIZE);
    80004678:	75f9                	lui	a1,0xffffe
    8000467a:	95aa                	add	a1,a1,a0
    8000467c:	855e                	mv	a0,s7
    8000467e:	ffffc097          	auipc	ra,0xffffc
    80004682:	452080e7          	jalr	1106(ra) # 80000ad0 <uvmclear>
  stackbase = sp - PGSIZE;
    80004686:	7c7d                	lui	s8,0xfffff
    80004688:	9c5a                	add	s8,s8,s6
  for(argc = 0; argv[argc]; argc++) {
    8000468a:	e0043783          	ld	a5,-512(s0)
    8000468e:	6388                	ld	a0,0(a5)
    80004690:	c535                	beqz	a0,800046fc <exec+0x216>
    80004692:	e9040993          	addi	s3,s0,-368
    80004696:	f9040c93          	addi	s9,s0,-112
  sp = sz;
    8000469a:	895a                	mv	s2,s6
    sp -= strlen(argv[argc]) + 1;
    8000469c:	ffffc097          	auipc	ra,0xffffc
    800046a0:	c60080e7          	jalr	-928(ra) # 800002fc <strlen>
    800046a4:	2505                	addiw	a0,a0,1
    800046a6:	40a90933          	sub	s2,s2,a0
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    800046aa:	ff097913          	andi	s2,s2,-16
    if(sp < stackbase)
    800046ae:	13896363          	bltu	s2,s8,800047d4 <exec+0x2ee>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    800046b2:	e0043d83          	ld	s11,-512(s0)
    800046b6:	000dba03          	ld	s4,0(s11)
    800046ba:	8552                	mv	a0,s4
    800046bc:	ffffc097          	auipc	ra,0xffffc
    800046c0:	c40080e7          	jalr	-960(ra) # 800002fc <strlen>
    800046c4:	0015069b          	addiw	a3,a0,1
    800046c8:	8652                	mv	a2,s4
    800046ca:	85ca                	mv	a1,s2
    800046cc:	855e                	mv	a0,s7
    800046ce:	ffffc097          	auipc	ra,0xffffc
    800046d2:	434080e7          	jalr	1076(ra) # 80000b02 <copyout>
    800046d6:	10054363          	bltz	a0,800047dc <exec+0x2f6>
    ustack[argc] = sp;
    800046da:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    800046de:	0485                	addi	s1,s1,1
    800046e0:	008d8793          	addi	a5,s11,8
    800046e4:	e0f43023          	sd	a5,-512(s0)
    800046e8:	008db503          	ld	a0,8(s11)
    800046ec:	c911                	beqz	a0,80004700 <exec+0x21a>
    if(argc >= MAXARG)
    800046ee:	09a1                	addi	s3,s3,8
    800046f0:	fb3c96e3          	bne	s9,s3,8000469c <exec+0x1b6>
  sz = sz1;
    800046f4:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800046f8:	4481                	li	s1,0
    800046fa:	a84d                	j	800047ac <exec+0x2c6>
  sp = sz;
    800046fc:	895a                	mv	s2,s6
  for(argc = 0; argv[argc]; argc++) {
    800046fe:	4481                	li	s1,0
  ustack[argc] = 0;
    80004700:	00349793          	slli	a5,s1,0x3
    80004704:	f9040713          	addi	a4,s0,-112
    80004708:	97ba                	add	a5,a5,a4
    8000470a:	f007b023          	sd	zero,-256(a5) # f00 <_entry-0x7ffff100>
  sp -= (argc+1) * sizeof(uint64);
    8000470e:	00148693          	addi	a3,s1,1
    80004712:	068e                	slli	a3,a3,0x3
    80004714:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80004718:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    8000471c:	01897663          	bgeu	s2,s8,80004728 <exec+0x242>
  sz = sz1;
    80004720:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    80004724:	4481                	li	s1,0
    80004726:	a059                	j	800047ac <exec+0x2c6>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80004728:	e9040613          	addi	a2,s0,-368
    8000472c:	85ca                	mv	a1,s2
    8000472e:	855e                	mv	a0,s7
    80004730:	ffffc097          	auipc	ra,0xffffc
    80004734:	3d2080e7          	jalr	978(ra) # 80000b02 <copyout>
    80004738:	0a054663          	bltz	a0,800047e4 <exec+0x2fe>
  p->trapframe->a1 = sp;
    8000473c:	058ab783          	ld	a5,88(s5)
    80004740:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    80004744:	df843783          	ld	a5,-520(s0)
    80004748:	0007c703          	lbu	a4,0(a5)
    8000474c:	cf11                	beqz	a4,80004768 <exec+0x282>
    8000474e:	0785                	addi	a5,a5,1
    if(*s == '/')
    80004750:	02f00693          	li	a3,47
    80004754:	a039                	j	80004762 <exec+0x27c>
      last = s+1;
    80004756:	def43c23          	sd	a5,-520(s0)
  for(last=s=path; *s; s++)
    8000475a:	0785                	addi	a5,a5,1
    8000475c:	fff7c703          	lbu	a4,-1(a5)
    80004760:	c701                	beqz	a4,80004768 <exec+0x282>
    if(*s == '/')
    80004762:	fed71ce3          	bne	a4,a3,8000475a <exec+0x274>
    80004766:	bfc5                	j	80004756 <exec+0x270>
  safestrcpy(p->name, last, sizeof(p->name));
    80004768:	4641                	li	a2,16
    8000476a:	df843583          	ld	a1,-520(s0)
    8000476e:	158a8513          	addi	a0,s5,344
    80004772:	ffffc097          	auipc	ra,0xffffc
    80004776:	b58080e7          	jalr	-1192(ra) # 800002ca <safestrcpy>
  oldpagetable = p->pagetable;
    8000477a:	050ab503          	ld	a0,80(s5)
  p->pagetable = pagetable;
    8000477e:	057ab823          	sd	s7,80(s5)
  p->sz = sz;
    80004782:	056ab423          	sd	s6,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80004786:	058ab783          	ld	a5,88(s5)
    8000478a:	e6843703          	ld	a4,-408(s0)
    8000478e:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80004790:	058ab783          	ld	a5,88(s5)
    80004794:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80004798:	85ea                	mv	a1,s10
    8000479a:	ffffd097          	auipc	ra,0xffffd
    8000479e:	b26080e7          	jalr	-1242(ra) # 800012c0 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    800047a2:	0004851b          	sext.w	a0,s1
    800047a6:	bbe1                	j	8000457e <exec+0x98>
    800047a8:	e1243423          	sd	s2,-504(s0)
    proc_freepagetable(pagetable, sz);
    800047ac:	e0843583          	ld	a1,-504(s0)
    800047b0:	855e                	mv	a0,s7
    800047b2:	ffffd097          	auipc	ra,0xffffd
    800047b6:	b0e080e7          	jalr	-1266(ra) # 800012c0 <proc_freepagetable>
  if(ip){
    800047ba:	da0498e3          	bnez	s1,8000456a <exec+0x84>
  return -1;
    800047be:	557d                	li	a0,-1
    800047c0:	bb7d                	j	8000457e <exec+0x98>
    800047c2:	e1243423          	sd	s2,-504(s0)
    800047c6:	b7dd                	j	800047ac <exec+0x2c6>
    800047c8:	e1243423          	sd	s2,-504(s0)
    800047cc:	b7c5                	j	800047ac <exec+0x2c6>
    800047ce:	e1243423          	sd	s2,-504(s0)
    800047d2:	bfe9                	j	800047ac <exec+0x2c6>
  sz = sz1;
    800047d4:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800047d8:	4481                	li	s1,0
    800047da:	bfc9                	j	800047ac <exec+0x2c6>
  sz = sz1;
    800047dc:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800047e0:	4481                	li	s1,0
    800047e2:	b7e9                	j	800047ac <exec+0x2c6>
  sz = sz1;
    800047e4:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800047e8:	4481                	li	s1,0
    800047ea:	b7c9                	j	800047ac <exec+0x2c6>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    800047ec:	e0843903          	ld	s2,-504(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800047f0:	2b05                	addiw	s6,s6,1
    800047f2:	0389899b          	addiw	s3,s3,56
    800047f6:	e8845783          	lhu	a5,-376(s0)
    800047fa:	e2fb5be3          	bge	s6,a5,80004630 <exec+0x14a>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    800047fe:	2981                	sext.w	s3,s3
    80004800:	03800713          	li	a4,56
    80004804:	86ce                	mv	a3,s3
    80004806:	e1840613          	addi	a2,s0,-488
    8000480a:	4581                	li	a1,0
    8000480c:	8526                	mv	a0,s1
    8000480e:	fffff097          	auipc	ra,0xfffff
    80004812:	906080e7          	jalr	-1786(ra) # 80003114 <readi>
    80004816:	03800793          	li	a5,56
    8000481a:	f8f517e3          	bne	a0,a5,800047a8 <exec+0x2c2>
    if(ph.type != ELF_PROG_LOAD)
    8000481e:	e1842783          	lw	a5,-488(s0)
    80004822:	4705                	li	a4,1
    80004824:	fce796e3          	bne	a5,a4,800047f0 <exec+0x30a>
    if(ph.memsz < ph.filesz)
    80004828:	e4043603          	ld	a2,-448(s0)
    8000482c:	e3843783          	ld	a5,-456(s0)
    80004830:	f8f669e3          	bltu	a2,a5,800047c2 <exec+0x2dc>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80004834:	e2843783          	ld	a5,-472(s0)
    80004838:	963e                	add	a2,a2,a5
    8000483a:	f8f667e3          	bltu	a2,a5,800047c8 <exec+0x2e2>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    8000483e:	85ca                	mv	a1,s2
    80004840:	855e                	mv	a0,s7
    80004842:	ffffc097          	auipc	ra,0xffffc
    80004846:	070080e7          	jalr	112(ra) # 800008b2 <uvmalloc>
    8000484a:	e0a43423          	sd	a0,-504(s0)
    8000484e:	d141                	beqz	a0,800047ce <exec+0x2e8>
    if((ph.vaddr % PGSIZE) != 0)
    80004850:	e2843d03          	ld	s10,-472(s0)
    80004854:	df043783          	ld	a5,-528(s0)
    80004858:	00fd77b3          	and	a5,s10,a5
    8000485c:	fba1                	bnez	a5,800047ac <exec+0x2c6>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    8000485e:	e2042d83          	lw	s11,-480(s0)
    80004862:	e3842c03          	lw	s8,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80004866:	f80c03e3          	beqz	s8,800047ec <exec+0x306>
    8000486a:	8a62                	mv	s4,s8
    8000486c:	4901                	li	s2,0
    8000486e:	b345                	j	8000460e <exec+0x128>

0000000080004870 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80004870:	7179                	addi	sp,sp,-48
    80004872:	f406                	sd	ra,40(sp)
    80004874:	f022                	sd	s0,32(sp)
    80004876:	ec26                	sd	s1,24(sp)
    80004878:	e84a                	sd	s2,16(sp)
    8000487a:	1800                	addi	s0,sp,48
    8000487c:	892e                	mv	s2,a1
    8000487e:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    80004880:	fdc40593          	addi	a1,s0,-36
    80004884:	ffffe097          	auipc	ra,0xffffe
    80004888:	9a0080e7          	jalr	-1632(ra) # 80002224 <argint>
    8000488c:	04054063          	bltz	a0,800048cc <argfd+0x5c>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80004890:	fdc42703          	lw	a4,-36(s0)
    80004894:	47bd                	li	a5,15
    80004896:	02e7ed63          	bltu	a5,a4,800048d0 <argfd+0x60>
    8000489a:	ffffd097          	auipc	ra,0xffffd
    8000489e:	8c6080e7          	jalr	-1850(ra) # 80001160 <myproc>
    800048a2:	fdc42703          	lw	a4,-36(s0)
    800048a6:	01a70793          	addi	a5,a4,26
    800048aa:	078e                	slli	a5,a5,0x3
    800048ac:	953e                	add	a0,a0,a5
    800048ae:	611c                	ld	a5,0(a0)
    800048b0:	c395                	beqz	a5,800048d4 <argfd+0x64>
    return -1;
  if(pfd)
    800048b2:	00090463          	beqz	s2,800048ba <argfd+0x4a>
    *pfd = fd;
    800048b6:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    800048ba:	4501                	li	a0,0
  if(pf)
    800048bc:	c091                	beqz	s1,800048c0 <argfd+0x50>
    *pf = f;
    800048be:	e09c                	sd	a5,0(s1)
}
    800048c0:	70a2                	ld	ra,40(sp)
    800048c2:	7402                	ld	s0,32(sp)
    800048c4:	64e2                	ld	s1,24(sp)
    800048c6:	6942                	ld	s2,16(sp)
    800048c8:	6145                	addi	sp,sp,48
    800048ca:	8082                	ret
    return -1;
    800048cc:	557d                	li	a0,-1
    800048ce:	bfcd                	j	800048c0 <argfd+0x50>
    return -1;
    800048d0:	557d                	li	a0,-1
    800048d2:	b7fd                	j	800048c0 <argfd+0x50>
    800048d4:	557d                	li	a0,-1
    800048d6:	b7ed                	j	800048c0 <argfd+0x50>

00000000800048d8 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    800048d8:	1101                	addi	sp,sp,-32
    800048da:	ec06                	sd	ra,24(sp)
    800048dc:	e822                	sd	s0,16(sp)
    800048de:	e426                	sd	s1,8(sp)
    800048e0:	1000                	addi	s0,sp,32
    800048e2:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    800048e4:	ffffd097          	auipc	ra,0xffffd
    800048e8:	87c080e7          	jalr	-1924(ra) # 80001160 <myproc>
    800048ec:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    800048ee:	0d050793          	addi	a5,a0,208 # fffffffffffff0d0 <end+0xffffffff7ffd8e90>
    800048f2:	4501                	li	a0,0
    800048f4:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    800048f6:	6398                	ld	a4,0(a5)
    800048f8:	cb19                	beqz	a4,8000490e <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    800048fa:	2505                	addiw	a0,a0,1
    800048fc:	07a1                	addi	a5,a5,8
    800048fe:	fed51ce3          	bne	a0,a3,800048f6 <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80004902:	557d                	li	a0,-1
}
    80004904:	60e2                	ld	ra,24(sp)
    80004906:	6442                	ld	s0,16(sp)
    80004908:	64a2                	ld	s1,8(sp)
    8000490a:	6105                	addi	sp,sp,32
    8000490c:	8082                	ret
      p->ofile[fd] = f;
    8000490e:	01a50793          	addi	a5,a0,26
    80004912:	078e                	slli	a5,a5,0x3
    80004914:	963e                	add	a2,a2,a5
    80004916:	e204                	sd	s1,0(a2)
      return fd;
    80004918:	b7f5                	j	80004904 <fdalloc+0x2c>

000000008000491a <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    8000491a:	715d                	addi	sp,sp,-80
    8000491c:	e486                	sd	ra,72(sp)
    8000491e:	e0a2                	sd	s0,64(sp)
    80004920:	fc26                	sd	s1,56(sp)
    80004922:	f84a                	sd	s2,48(sp)
    80004924:	f44e                	sd	s3,40(sp)
    80004926:	f052                	sd	s4,32(sp)
    80004928:	ec56                	sd	s5,24(sp)
    8000492a:	0880                	addi	s0,sp,80
    8000492c:	89ae                	mv	s3,a1
    8000492e:	8ab2                	mv	s5,a2
    80004930:	8a36                	mv	s4,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80004932:	fb040593          	addi	a1,s0,-80
    80004936:	fffff097          	auipc	ra,0xfffff
    8000493a:	cf4080e7          	jalr	-780(ra) # 8000362a <nameiparent>
    8000493e:	892a                	mv	s2,a0
    80004940:	12050f63          	beqz	a0,80004a7e <create+0x164>
    return 0;

  ilock(dp);
    80004944:	ffffe097          	auipc	ra,0xffffe
    80004948:	51c080e7          	jalr	1308(ra) # 80002e60 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    8000494c:	4601                	li	a2,0
    8000494e:	fb040593          	addi	a1,s0,-80
    80004952:	854a                	mv	a0,s2
    80004954:	fffff097          	auipc	ra,0xfffff
    80004958:	9e6080e7          	jalr	-1562(ra) # 8000333a <dirlookup>
    8000495c:	84aa                	mv	s1,a0
    8000495e:	c921                	beqz	a0,800049ae <create+0x94>
    iunlockput(dp);
    80004960:	854a                	mv	a0,s2
    80004962:	ffffe097          	auipc	ra,0xffffe
    80004966:	760080e7          	jalr	1888(ra) # 800030c2 <iunlockput>
    ilock(ip);
    8000496a:	8526                	mv	a0,s1
    8000496c:	ffffe097          	auipc	ra,0xffffe
    80004970:	4f4080e7          	jalr	1268(ra) # 80002e60 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80004974:	2981                	sext.w	s3,s3
    80004976:	4789                	li	a5,2
    80004978:	02f99463          	bne	s3,a5,800049a0 <create+0x86>
    8000497c:	0444d783          	lhu	a5,68(s1)
    80004980:	37f9                	addiw	a5,a5,-2
    80004982:	17c2                	slli	a5,a5,0x30
    80004984:	93c1                	srli	a5,a5,0x30
    80004986:	4705                	li	a4,1
    80004988:	00f76c63          	bltu	a4,a5,800049a0 <create+0x86>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
    8000498c:	8526                	mv	a0,s1
    8000498e:	60a6                	ld	ra,72(sp)
    80004990:	6406                	ld	s0,64(sp)
    80004992:	74e2                	ld	s1,56(sp)
    80004994:	7942                	ld	s2,48(sp)
    80004996:	79a2                	ld	s3,40(sp)
    80004998:	7a02                	ld	s4,32(sp)
    8000499a:	6ae2                	ld	s5,24(sp)
    8000499c:	6161                	addi	sp,sp,80
    8000499e:	8082                	ret
    iunlockput(ip);
    800049a0:	8526                	mv	a0,s1
    800049a2:	ffffe097          	auipc	ra,0xffffe
    800049a6:	720080e7          	jalr	1824(ra) # 800030c2 <iunlockput>
    return 0;
    800049aa:	4481                	li	s1,0
    800049ac:	b7c5                	j	8000498c <create+0x72>
  if((ip = ialloc(dp->dev, type)) == 0)
    800049ae:	85ce                	mv	a1,s3
    800049b0:	00092503          	lw	a0,0(s2)
    800049b4:	ffffe097          	auipc	ra,0xffffe
    800049b8:	326080e7          	jalr	806(ra) # 80002cda <ialloc>
    800049bc:	84aa                	mv	s1,a0
    800049be:	c529                	beqz	a0,80004a08 <create+0xee>
  ilock(ip);
    800049c0:	ffffe097          	auipc	ra,0xffffe
    800049c4:	4a0080e7          	jalr	1184(ra) # 80002e60 <ilock>
  ip->major = major;
    800049c8:	05549323          	sh	s5,70(s1)
  ip->minor = minor;
    800049cc:	05449423          	sh	s4,72(s1)
  ip->nlink = 1;
    800049d0:	4785                	li	a5,1
    800049d2:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800049d6:	8526                	mv	a0,s1
    800049d8:	ffffe097          	auipc	ra,0xffffe
    800049dc:	3c6080e7          	jalr	966(ra) # 80002d9e <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    800049e0:	2981                	sext.w	s3,s3
    800049e2:	4785                	li	a5,1
    800049e4:	02f98a63          	beq	s3,a5,80004a18 <create+0xfe>
  if(dirlink(dp, name, ip->inum) < 0)
    800049e8:	40d0                	lw	a2,4(s1)
    800049ea:	fb040593          	addi	a1,s0,-80
    800049ee:	854a                	mv	a0,s2
    800049f0:	fffff097          	auipc	ra,0xfffff
    800049f4:	b5a080e7          	jalr	-1190(ra) # 8000354a <dirlink>
    800049f8:	06054b63          	bltz	a0,80004a6e <create+0x154>
  iunlockput(dp);
    800049fc:	854a                	mv	a0,s2
    800049fe:	ffffe097          	auipc	ra,0xffffe
    80004a02:	6c4080e7          	jalr	1732(ra) # 800030c2 <iunlockput>
  return ip;
    80004a06:	b759                	j	8000498c <create+0x72>
    panic("create: ialloc");
    80004a08:	00004517          	auipc	a0,0x4
    80004a0c:	df050513          	addi	a0,a0,-528 # 800087f8 <syscalls+0x398>
    80004a10:	00002097          	auipc	ra,0x2
    80004a14:	8c0080e7          	jalr	-1856(ra) # 800062d0 <panic>
    dp->nlink++;  // for ".."
    80004a18:	04a95783          	lhu	a5,74(s2)
    80004a1c:	2785                	addiw	a5,a5,1
    80004a1e:	04f91523          	sh	a5,74(s2)
    iupdate(dp);
    80004a22:	854a                	mv	a0,s2
    80004a24:	ffffe097          	auipc	ra,0xffffe
    80004a28:	37a080e7          	jalr	890(ra) # 80002d9e <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80004a2c:	40d0                	lw	a2,4(s1)
    80004a2e:	00004597          	auipc	a1,0x4
    80004a32:	dda58593          	addi	a1,a1,-550 # 80008808 <syscalls+0x3a8>
    80004a36:	8526                	mv	a0,s1
    80004a38:	fffff097          	auipc	ra,0xfffff
    80004a3c:	b12080e7          	jalr	-1262(ra) # 8000354a <dirlink>
    80004a40:	00054f63          	bltz	a0,80004a5e <create+0x144>
    80004a44:	00492603          	lw	a2,4(s2)
    80004a48:	00004597          	auipc	a1,0x4
    80004a4c:	dc858593          	addi	a1,a1,-568 # 80008810 <syscalls+0x3b0>
    80004a50:	8526                	mv	a0,s1
    80004a52:	fffff097          	auipc	ra,0xfffff
    80004a56:	af8080e7          	jalr	-1288(ra) # 8000354a <dirlink>
    80004a5a:	f80557e3          	bgez	a0,800049e8 <create+0xce>
      panic("create dots");
    80004a5e:	00004517          	auipc	a0,0x4
    80004a62:	dba50513          	addi	a0,a0,-582 # 80008818 <syscalls+0x3b8>
    80004a66:	00002097          	auipc	ra,0x2
    80004a6a:	86a080e7          	jalr	-1942(ra) # 800062d0 <panic>
    panic("create: dirlink");
    80004a6e:	00004517          	auipc	a0,0x4
    80004a72:	dba50513          	addi	a0,a0,-582 # 80008828 <syscalls+0x3c8>
    80004a76:	00002097          	auipc	ra,0x2
    80004a7a:	85a080e7          	jalr	-1958(ra) # 800062d0 <panic>
    return 0;
    80004a7e:	84aa                	mv	s1,a0
    80004a80:	b731                	j	8000498c <create+0x72>

0000000080004a82 <sys_dup>:
{
    80004a82:	7179                	addi	sp,sp,-48
    80004a84:	f406                	sd	ra,40(sp)
    80004a86:	f022                	sd	s0,32(sp)
    80004a88:	ec26                	sd	s1,24(sp)
    80004a8a:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80004a8c:	fd840613          	addi	a2,s0,-40
    80004a90:	4581                	li	a1,0
    80004a92:	4501                	li	a0,0
    80004a94:	00000097          	auipc	ra,0x0
    80004a98:	ddc080e7          	jalr	-548(ra) # 80004870 <argfd>
    return -1;
    80004a9c:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    80004a9e:	02054363          	bltz	a0,80004ac4 <sys_dup+0x42>
  if((fd=fdalloc(f)) < 0)
    80004aa2:	fd843503          	ld	a0,-40(s0)
    80004aa6:	00000097          	auipc	ra,0x0
    80004aaa:	e32080e7          	jalr	-462(ra) # 800048d8 <fdalloc>
    80004aae:	84aa                	mv	s1,a0
    return -1;
    80004ab0:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    80004ab2:	00054963          	bltz	a0,80004ac4 <sys_dup+0x42>
  filedup(f);
    80004ab6:	fd843503          	ld	a0,-40(s0)
    80004aba:	fffff097          	auipc	ra,0xfffff
    80004abe:	37a080e7          	jalr	890(ra) # 80003e34 <filedup>
  return fd;
    80004ac2:	87a6                	mv	a5,s1
}
    80004ac4:	853e                	mv	a0,a5
    80004ac6:	70a2                	ld	ra,40(sp)
    80004ac8:	7402                	ld	s0,32(sp)
    80004aca:	64e2                	ld	s1,24(sp)
    80004acc:	6145                	addi	sp,sp,48
    80004ace:	8082                	ret

0000000080004ad0 <sys_read>:
{
    80004ad0:	7179                	addi	sp,sp,-48
    80004ad2:	f406                	sd	ra,40(sp)
    80004ad4:	f022                	sd	s0,32(sp)
    80004ad6:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004ad8:	fe840613          	addi	a2,s0,-24
    80004adc:	4581                	li	a1,0
    80004ade:	4501                	li	a0,0
    80004ae0:	00000097          	auipc	ra,0x0
    80004ae4:	d90080e7          	jalr	-624(ra) # 80004870 <argfd>
    return -1;
    80004ae8:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004aea:	04054163          	bltz	a0,80004b2c <sys_read+0x5c>
    80004aee:	fe440593          	addi	a1,s0,-28
    80004af2:	4509                	li	a0,2
    80004af4:	ffffd097          	auipc	ra,0xffffd
    80004af8:	730080e7          	jalr	1840(ra) # 80002224 <argint>
    return -1;
    80004afc:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004afe:	02054763          	bltz	a0,80004b2c <sys_read+0x5c>
    80004b02:	fd840593          	addi	a1,s0,-40
    80004b06:	4505                	li	a0,1
    80004b08:	ffffd097          	auipc	ra,0xffffd
    80004b0c:	73e080e7          	jalr	1854(ra) # 80002246 <argaddr>
    return -1;
    80004b10:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004b12:	00054d63          	bltz	a0,80004b2c <sys_read+0x5c>
  return fileread(f, p, n);
    80004b16:	fe442603          	lw	a2,-28(s0)
    80004b1a:	fd843583          	ld	a1,-40(s0)
    80004b1e:	fe843503          	ld	a0,-24(s0)
    80004b22:	fffff097          	auipc	ra,0xfffff
    80004b26:	49e080e7          	jalr	1182(ra) # 80003fc0 <fileread>
    80004b2a:	87aa                	mv	a5,a0
}
    80004b2c:	853e                	mv	a0,a5
    80004b2e:	70a2                	ld	ra,40(sp)
    80004b30:	7402                	ld	s0,32(sp)
    80004b32:	6145                	addi	sp,sp,48
    80004b34:	8082                	ret

0000000080004b36 <sys_write>:
{
    80004b36:	7179                	addi	sp,sp,-48
    80004b38:	f406                	sd	ra,40(sp)
    80004b3a:	f022                	sd	s0,32(sp)
    80004b3c:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004b3e:	fe840613          	addi	a2,s0,-24
    80004b42:	4581                	li	a1,0
    80004b44:	4501                	li	a0,0
    80004b46:	00000097          	auipc	ra,0x0
    80004b4a:	d2a080e7          	jalr	-726(ra) # 80004870 <argfd>
    return -1;
    80004b4e:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004b50:	04054163          	bltz	a0,80004b92 <sys_write+0x5c>
    80004b54:	fe440593          	addi	a1,s0,-28
    80004b58:	4509                	li	a0,2
    80004b5a:	ffffd097          	auipc	ra,0xffffd
    80004b5e:	6ca080e7          	jalr	1738(ra) # 80002224 <argint>
    return -1;
    80004b62:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004b64:	02054763          	bltz	a0,80004b92 <sys_write+0x5c>
    80004b68:	fd840593          	addi	a1,s0,-40
    80004b6c:	4505                	li	a0,1
    80004b6e:	ffffd097          	auipc	ra,0xffffd
    80004b72:	6d8080e7          	jalr	1752(ra) # 80002246 <argaddr>
    return -1;
    80004b76:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004b78:	00054d63          	bltz	a0,80004b92 <sys_write+0x5c>
  return filewrite(f, p, n);
    80004b7c:	fe442603          	lw	a2,-28(s0)
    80004b80:	fd843583          	ld	a1,-40(s0)
    80004b84:	fe843503          	ld	a0,-24(s0)
    80004b88:	fffff097          	auipc	ra,0xfffff
    80004b8c:	4fa080e7          	jalr	1274(ra) # 80004082 <filewrite>
    80004b90:	87aa                	mv	a5,a0
}
    80004b92:	853e                	mv	a0,a5
    80004b94:	70a2                	ld	ra,40(sp)
    80004b96:	7402                	ld	s0,32(sp)
    80004b98:	6145                	addi	sp,sp,48
    80004b9a:	8082                	ret

0000000080004b9c <sys_close>:
{
    80004b9c:	1101                	addi	sp,sp,-32
    80004b9e:	ec06                	sd	ra,24(sp)
    80004ba0:	e822                	sd	s0,16(sp)
    80004ba2:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    80004ba4:	fe040613          	addi	a2,s0,-32
    80004ba8:	fec40593          	addi	a1,s0,-20
    80004bac:	4501                	li	a0,0
    80004bae:	00000097          	auipc	ra,0x0
    80004bb2:	cc2080e7          	jalr	-830(ra) # 80004870 <argfd>
    return -1;
    80004bb6:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80004bb8:	02054463          	bltz	a0,80004be0 <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    80004bbc:	ffffc097          	auipc	ra,0xffffc
    80004bc0:	5a4080e7          	jalr	1444(ra) # 80001160 <myproc>
    80004bc4:	fec42783          	lw	a5,-20(s0)
    80004bc8:	07e9                	addi	a5,a5,26
    80004bca:	078e                	slli	a5,a5,0x3
    80004bcc:	97aa                	add	a5,a5,a0
    80004bce:	0007b023          	sd	zero,0(a5)
  fileclose(f);
    80004bd2:	fe043503          	ld	a0,-32(s0)
    80004bd6:	fffff097          	auipc	ra,0xfffff
    80004bda:	2b0080e7          	jalr	688(ra) # 80003e86 <fileclose>
  return 0;
    80004bde:	4781                	li	a5,0
}
    80004be0:	853e                	mv	a0,a5
    80004be2:	60e2                	ld	ra,24(sp)
    80004be4:	6442                	ld	s0,16(sp)
    80004be6:	6105                	addi	sp,sp,32
    80004be8:	8082                	ret

0000000080004bea <sys_fstat>:
{
    80004bea:	1101                	addi	sp,sp,-32
    80004bec:	ec06                	sd	ra,24(sp)
    80004bee:	e822                	sd	s0,16(sp)
    80004bf0:	1000                	addi	s0,sp,32
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004bf2:	fe840613          	addi	a2,s0,-24
    80004bf6:	4581                	li	a1,0
    80004bf8:	4501                	li	a0,0
    80004bfa:	00000097          	auipc	ra,0x0
    80004bfe:	c76080e7          	jalr	-906(ra) # 80004870 <argfd>
    return -1;
    80004c02:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004c04:	02054563          	bltz	a0,80004c2e <sys_fstat+0x44>
    80004c08:	fe040593          	addi	a1,s0,-32
    80004c0c:	4505                	li	a0,1
    80004c0e:	ffffd097          	auipc	ra,0xffffd
    80004c12:	638080e7          	jalr	1592(ra) # 80002246 <argaddr>
    return -1;
    80004c16:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004c18:	00054b63          	bltz	a0,80004c2e <sys_fstat+0x44>
  return filestat(f, st);
    80004c1c:	fe043583          	ld	a1,-32(s0)
    80004c20:	fe843503          	ld	a0,-24(s0)
    80004c24:	fffff097          	auipc	ra,0xfffff
    80004c28:	32a080e7          	jalr	810(ra) # 80003f4e <filestat>
    80004c2c:	87aa                	mv	a5,a0
}
    80004c2e:	853e                	mv	a0,a5
    80004c30:	60e2                	ld	ra,24(sp)
    80004c32:	6442                	ld	s0,16(sp)
    80004c34:	6105                	addi	sp,sp,32
    80004c36:	8082                	ret

0000000080004c38 <sys_link>:
{
    80004c38:	7169                	addi	sp,sp,-304
    80004c3a:	f606                	sd	ra,296(sp)
    80004c3c:	f222                	sd	s0,288(sp)
    80004c3e:	ee26                	sd	s1,280(sp)
    80004c40:	ea4a                	sd	s2,272(sp)
    80004c42:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004c44:	08000613          	li	a2,128
    80004c48:	ed040593          	addi	a1,s0,-304
    80004c4c:	4501                	li	a0,0
    80004c4e:	ffffd097          	auipc	ra,0xffffd
    80004c52:	61a080e7          	jalr	1562(ra) # 80002268 <argstr>
    return -1;
    80004c56:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004c58:	10054e63          	bltz	a0,80004d74 <sys_link+0x13c>
    80004c5c:	08000613          	li	a2,128
    80004c60:	f5040593          	addi	a1,s0,-176
    80004c64:	4505                	li	a0,1
    80004c66:	ffffd097          	auipc	ra,0xffffd
    80004c6a:	602080e7          	jalr	1538(ra) # 80002268 <argstr>
    return -1;
    80004c6e:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004c70:	10054263          	bltz	a0,80004d74 <sys_link+0x13c>
  begin_op();
    80004c74:	fffff097          	auipc	ra,0xfffff
    80004c78:	d46080e7          	jalr	-698(ra) # 800039ba <begin_op>
  if((ip = namei(old)) == 0){
    80004c7c:	ed040513          	addi	a0,s0,-304
    80004c80:	fffff097          	auipc	ra,0xfffff
    80004c84:	98c080e7          	jalr	-1652(ra) # 8000360c <namei>
    80004c88:	84aa                	mv	s1,a0
    80004c8a:	c551                	beqz	a0,80004d16 <sys_link+0xde>
  ilock(ip);
    80004c8c:	ffffe097          	auipc	ra,0xffffe
    80004c90:	1d4080e7          	jalr	468(ra) # 80002e60 <ilock>
  if(ip->type == T_DIR){
    80004c94:	04449703          	lh	a4,68(s1)
    80004c98:	4785                	li	a5,1
    80004c9a:	08f70463          	beq	a4,a5,80004d22 <sys_link+0xea>
  ip->nlink++;
    80004c9e:	04a4d783          	lhu	a5,74(s1)
    80004ca2:	2785                	addiw	a5,a5,1
    80004ca4:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004ca8:	8526                	mv	a0,s1
    80004caa:	ffffe097          	auipc	ra,0xffffe
    80004cae:	0f4080e7          	jalr	244(ra) # 80002d9e <iupdate>
  iunlock(ip);
    80004cb2:	8526                	mv	a0,s1
    80004cb4:	ffffe097          	auipc	ra,0xffffe
    80004cb8:	26e080e7          	jalr	622(ra) # 80002f22 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80004cbc:	fd040593          	addi	a1,s0,-48
    80004cc0:	f5040513          	addi	a0,s0,-176
    80004cc4:	fffff097          	auipc	ra,0xfffff
    80004cc8:	966080e7          	jalr	-1690(ra) # 8000362a <nameiparent>
    80004ccc:	892a                	mv	s2,a0
    80004cce:	c935                	beqz	a0,80004d42 <sys_link+0x10a>
  ilock(dp);
    80004cd0:	ffffe097          	auipc	ra,0xffffe
    80004cd4:	190080e7          	jalr	400(ra) # 80002e60 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80004cd8:	00092703          	lw	a4,0(s2)
    80004cdc:	409c                	lw	a5,0(s1)
    80004cde:	04f71d63          	bne	a4,a5,80004d38 <sys_link+0x100>
    80004ce2:	40d0                	lw	a2,4(s1)
    80004ce4:	fd040593          	addi	a1,s0,-48
    80004ce8:	854a                	mv	a0,s2
    80004cea:	fffff097          	auipc	ra,0xfffff
    80004cee:	860080e7          	jalr	-1952(ra) # 8000354a <dirlink>
    80004cf2:	04054363          	bltz	a0,80004d38 <sys_link+0x100>
  iunlockput(dp);
    80004cf6:	854a                	mv	a0,s2
    80004cf8:	ffffe097          	auipc	ra,0xffffe
    80004cfc:	3ca080e7          	jalr	970(ra) # 800030c2 <iunlockput>
  iput(ip);
    80004d00:	8526                	mv	a0,s1
    80004d02:	ffffe097          	auipc	ra,0xffffe
    80004d06:	318080e7          	jalr	792(ra) # 8000301a <iput>
  end_op();
    80004d0a:	fffff097          	auipc	ra,0xfffff
    80004d0e:	d30080e7          	jalr	-720(ra) # 80003a3a <end_op>
  return 0;
    80004d12:	4781                	li	a5,0
    80004d14:	a085                	j	80004d74 <sys_link+0x13c>
    end_op();
    80004d16:	fffff097          	auipc	ra,0xfffff
    80004d1a:	d24080e7          	jalr	-732(ra) # 80003a3a <end_op>
    return -1;
    80004d1e:	57fd                	li	a5,-1
    80004d20:	a891                	j	80004d74 <sys_link+0x13c>
    iunlockput(ip);
    80004d22:	8526                	mv	a0,s1
    80004d24:	ffffe097          	auipc	ra,0xffffe
    80004d28:	39e080e7          	jalr	926(ra) # 800030c2 <iunlockput>
    end_op();
    80004d2c:	fffff097          	auipc	ra,0xfffff
    80004d30:	d0e080e7          	jalr	-754(ra) # 80003a3a <end_op>
    return -1;
    80004d34:	57fd                	li	a5,-1
    80004d36:	a83d                	j	80004d74 <sys_link+0x13c>
    iunlockput(dp);
    80004d38:	854a                	mv	a0,s2
    80004d3a:	ffffe097          	auipc	ra,0xffffe
    80004d3e:	388080e7          	jalr	904(ra) # 800030c2 <iunlockput>
  ilock(ip);
    80004d42:	8526                	mv	a0,s1
    80004d44:	ffffe097          	auipc	ra,0xffffe
    80004d48:	11c080e7          	jalr	284(ra) # 80002e60 <ilock>
  ip->nlink--;
    80004d4c:	04a4d783          	lhu	a5,74(s1)
    80004d50:	37fd                	addiw	a5,a5,-1
    80004d52:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004d56:	8526                	mv	a0,s1
    80004d58:	ffffe097          	auipc	ra,0xffffe
    80004d5c:	046080e7          	jalr	70(ra) # 80002d9e <iupdate>
  iunlockput(ip);
    80004d60:	8526                	mv	a0,s1
    80004d62:	ffffe097          	auipc	ra,0xffffe
    80004d66:	360080e7          	jalr	864(ra) # 800030c2 <iunlockput>
  end_op();
    80004d6a:	fffff097          	auipc	ra,0xfffff
    80004d6e:	cd0080e7          	jalr	-816(ra) # 80003a3a <end_op>
  return -1;
    80004d72:	57fd                	li	a5,-1
}
    80004d74:	853e                	mv	a0,a5
    80004d76:	70b2                	ld	ra,296(sp)
    80004d78:	7412                	ld	s0,288(sp)
    80004d7a:	64f2                	ld	s1,280(sp)
    80004d7c:	6952                	ld	s2,272(sp)
    80004d7e:	6155                	addi	sp,sp,304
    80004d80:	8082                	ret

0000000080004d82 <sys_unlink>:
{
    80004d82:	7151                	addi	sp,sp,-240
    80004d84:	f586                	sd	ra,232(sp)
    80004d86:	f1a2                	sd	s0,224(sp)
    80004d88:	eda6                	sd	s1,216(sp)
    80004d8a:	e9ca                	sd	s2,208(sp)
    80004d8c:	e5ce                	sd	s3,200(sp)
    80004d8e:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80004d90:	08000613          	li	a2,128
    80004d94:	f3040593          	addi	a1,s0,-208
    80004d98:	4501                	li	a0,0
    80004d9a:	ffffd097          	auipc	ra,0xffffd
    80004d9e:	4ce080e7          	jalr	1230(ra) # 80002268 <argstr>
    80004da2:	18054163          	bltz	a0,80004f24 <sys_unlink+0x1a2>
  begin_op();
    80004da6:	fffff097          	auipc	ra,0xfffff
    80004daa:	c14080e7          	jalr	-1004(ra) # 800039ba <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80004dae:	fb040593          	addi	a1,s0,-80
    80004db2:	f3040513          	addi	a0,s0,-208
    80004db6:	fffff097          	auipc	ra,0xfffff
    80004dba:	874080e7          	jalr	-1932(ra) # 8000362a <nameiparent>
    80004dbe:	84aa                	mv	s1,a0
    80004dc0:	c979                	beqz	a0,80004e96 <sys_unlink+0x114>
  ilock(dp);
    80004dc2:	ffffe097          	auipc	ra,0xffffe
    80004dc6:	09e080e7          	jalr	158(ra) # 80002e60 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80004dca:	00004597          	auipc	a1,0x4
    80004dce:	a3e58593          	addi	a1,a1,-1474 # 80008808 <syscalls+0x3a8>
    80004dd2:	fb040513          	addi	a0,s0,-80
    80004dd6:	ffffe097          	auipc	ra,0xffffe
    80004dda:	54a080e7          	jalr	1354(ra) # 80003320 <namecmp>
    80004dde:	14050a63          	beqz	a0,80004f32 <sys_unlink+0x1b0>
    80004de2:	00004597          	auipc	a1,0x4
    80004de6:	a2e58593          	addi	a1,a1,-1490 # 80008810 <syscalls+0x3b0>
    80004dea:	fb040513          	addi	a0,s0,-80
    80004dee:	ffffe097          	auipc	ra,0xffffe
    80004df2:	532080e7          	jalr	1330(ra) # 80003320 <namecmp>
    80004df6:	12050e63          	beqz	a0,80004f32 <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    80004dfa:	f2c40613          	addi	a2,s0,-212
    80004dfe:	fb040593          	addi	a1,s0,-80
    80004e02:	8526                	mv	a0,s1
    80004e04:	ffffe097          	auipc	ra,0xffffe
    80004e08:	536080e7          	jalr	1334(ra) # 8000333a <dirlookup>
    80004e0c:	892a                	mv	s2,a0
    80004e0e:	12050263          	beqz	a0,80004f32 <sys_unlink+0x1b0>
  ilock(ip);
    80004e12:	ffffe097          	auipc	ra,0xffffe
    80004e16:	04e080e7          	jalr	78(ra) # 80002e60 <ilock>
  if(ip->nlink < 1)
    80004e1a:	04a91783          	lh	a5,74(s2)
    80004e1e:	08f05263          	blez	a5,80004ea2 <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80004e22:	04491703          	lh	a4,68(s2)
    80004e26:	4785                	li	a5,1
    80004e28:	08f70563          	beq	a4,a5,80004eb2 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    80004e2c:	4641                	li	a2,16
    80004e2e:	4581                	li	a1,0
    80004e30:	fc040513          	addi	a0,s0,-64
    80004e34:	ffffb097          	auipc	ra,0xffffb
    80004e38:	344080e7          	jalr	836(ra) # 80000178 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004e3c:	4741                	li	a4,16
    80004e3e:	f2c42683          	lw	a3,-212(s0)
    80004e42:	fc040613          	addi	a2,s0,-64
    80004e46:	4581                	li	a1,0
    80004e48:	8526                	mv	a0,s1
    80004e4a:	ffffe097          	auipc	ra,0xffffe
    80004e4e:	3c2080e7          	jalr	962(ra) # 8000320c <writei>
    80004e52:	47c1                	li	a5,16
    80004e54:	0af51563          	bne	a0,a5,80004efe <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    80004e58:	04491703          	lh	a4,68(s2)
    80004e5c:	4785                	li	a5,1
    80004e5e:	0af70863          	beq	a4,a5,80004f0e <sys_unlink+0x18c>
  iunlockput(dp);
    80004e62:	8526                	mv	a0,s1
    80004e64:	ffffe097          	auipc	ra,0xffffe
    80004e68:	25e080e7          	jalr	606(ra) # 800030c2 <iunlockput>
  ip->nlink--;
    80004e6c:	04a95783          	lhu	a5,74(s2)
    80004e70:	37fd                	addiw	a5,a5,-1
    80004e72:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80004e76:	854a                	mv	a0,s2
    80004e78:	ffffe097          	auipc	ra,0xffffe
    80004e7c:	f26080e7          	jalr	-218(ra) # 80002d9e <iupdate>
  iunlockput(ip);
    80004e80:	854a                	mv	a0,s2
    80004e82:	ffffe097          	auipc	ra,0xffffe
    80004e86:	240080e7          	jalr	576(ra) # 800030c2 <iunlockput>
  end_op();
    80004e8a:	fffff097          	auipc	ra,0xfffff
    80004e8e:	bb0080e7          	jalr	-1104(ra) # 80003a3a <end_op>
  return 0;
    80004e92:	4501                	li	a0,0
    80004e94:	a84d                	j	80004f46 <sys_unlink+0x1c4>
    end_op();
    80004e96:	fffff097          	auipc	ra,0xfffff
    80004e9a:	ba4080e7          	jalr	-1116(ra) # 80003a3a <end_op>
    return -1;
    80004e9e:	557d                	li	a0,-1
    80004ea0:	a05d                	j	80004f46 <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    80004ea2:	00004517          	auipc	a0,0x4
    80004ea6:	99650513          	addi	a0,a0,-1642 # 80008838 <syscalls+0x3d8>
    80004eaa:	00001097          	auipc	ra,0x1
    80004eae:	426080e7          	jalr	1062(ra) # 800062d0 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004eb2:	04c92703          	lw	a4,76(s2)
    80004eb6:	02000793          	li	a5,32
    80004eba:	f6e7f9e3          	bgeu	a5,a4,80004e2c <sys_unlink+0xaa>
    80004ebe:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004ec2:	4741                	li	a4,16
    80004ec4:	86ce                	mv	a3,s3
    80004ec6:	f1840613          	addi	a2,s0,-232
    80004eca:	4581                	li	a1,0
    80004ecc:	854a                	mv	a0,s2
    80004ece:	ffffe097          	auipc	ra,0xffffe
    80004ed2:	246080e7          	jalr	582(ra) # 80003114 <readi>
    80004ed6:	47c1                	li	a5,16
    80004ed8:	00f51b63          	bne	a0,a5,80004eee <sys_unlink+0x16c>
    if(de.inum != 0)
    80004edc:	f1845783          	lhu	a5,-232(s0)
    80004ee0:	e7a1                	bnez	a5,80004f28 <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004ee2:	29c1                	addiw	s3,s3,16
    80004ee4:	04c92783          	lw	a5,76(s2)
    80004ee8:	fcf9ede3          	bltu	s3,a5,80004ec2 <sys_unlink+0x140>
    80004eec:	b781                	j	80004e2c <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80004eee:	00004517          	auipc	a0,0x4
    80004ef2:	96250513          	addi	a0,a0,-1694 # 80008850 <syscalls+0x3f0>
    80004ef6:	00001097          	auipc	ra,0x1
    80004efa:	3da080e7          	jalr	986(ra) # 800062d0 <panic>
    panic("unlink: writei");
    80004efe:	00004517          	auipc	a0,0x4
    80004f02:	96a50513          	addi	a0,a0,-1686 # 80008868 <syscalls+0x408>
    80004f06:	00001097          	auipc	ra,0x1
    80004f0a:	3ca080e7          	jalr	970(ra) # 800062d0 <panic>
    dp->nlink--;
    80004f0e:	04a4d783          	lhu	a5,74(s1)
    80004f12:	37fd                	addiw	a5,a5,-1
    80004f14:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004f18:	8526                	mv	a0,s1
    80004f1a:	ffffe097          	auipc	ra,0xffffe
    80004f1e:	e84080e7          	jalr	-380(ra) # 80002d9e <iupdate>
    80004f22:	b781                	j	80004e62 <sys_unlink+0xe0>
    return -1;
    80004f24:	557d                	li	a0,-1
    80004f26:	a005                	j	80004f46 <sys_unlink+0x1c4>
    iunlockput(ip);
    80004f28:	854a                	mv	a0,s2
    80004f2a:	ffffe097          	auipc	ra,0xffffe
    80004f2e:	198080e7          	jalr	408(ra) # 800030c2 <iunlockput>
  iunlockput(dp);
    80004f32:	8526                	mv	a0,s1
    80004f34:	ffffe097          	auipc	ra,0xffffe
    80004f38:	18e080e7          	jalr	398(ra) # 800030c2 <iunlockput>
  end_op();
    80004f3c:	fffff097          	auipc	ra,0xfffff
    80004f40:	afe080e7          	jalr	-1282(ra) # 80003a3a <end_op>
  return -1;
    80004f44:	557d                	li	a0,-1
}
    80004f46:	70ae                	ld	ra,232(sp)
    80004f48:	740e                	ld	s0,224(sp)
    80004f4a:	64ee                	ld	s1,216(sp)
    80004f4c:	694e                	ld	s2,208(sp)
    80004f4e:	69ae                	ld	s3,200(sp)
    80004f50:	616d                	addi	sp,sp,240
    80004f52:	8082                	ret

0000000080004f54 <sys_open>:

uint64
sys_open(void)
{
    80004f54:	7131                	addi	sp,sp,-192
    80004f56:	fd06                	sd	ra,184(sp)
    80004f58:	f922                	sd	s0,176(sp)
    80004f5a:	f526                	sd	s1,168(sp)
    80004f5c:	f14a                	sd	s2,160(sp)
    80004f5e:	ed4e                	sd	s3,152(sp)
    80004f60:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80004f62:	08000613          	li	a2,128
    80004f66:	f5040593          	addi	a1,s0,-176
    80004f6a:	4501                	li	a0,0
    80004f6c:	ffffd097          	auipc	ra,0xffffd
    80004f70:	2fc080e7          	jalr	764(ra) # 80002268 <argstr>
    return -1;
    80004f74:	54fd                	li	s1,-1
  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80004f76:	0c054163          	bltz	a0,80005038 <sys_open+0xe4>
    80004f7a:	f4c40593          	addi	a1,s0,-180
    80004f7e:	4505                	li	a0,1
    80004f80:	ffffd097          	auipc	ra,0xffffd
    80004f84:	2a4080e7          	jalr	676(ra) # 80002224 <argint>
    80004f88:	0a054863          	bltz	a0,80005038 <sys_open+0xe4>

  begin_op();
    80004f8c:	fffff097          	auipc	ra,0xfffff
    80004f90:	a2e080e7          	jalr	-1490(ra) # 800039ba <begin_op>

  if(omode & O_CREATE){
    80004f94:	f4c42783          	lw	a5,-180(s0)
    80004f98:	2007f793          	andi	a5,a5,512
    80004f9c:	cbdd                	beqz	a5,80005052 <sys_open+0xfe>
    ip = create(path, T_FILE, 0, 0);
    80004f9e:	4681                	li	a3,0
    80004fa0:	4601                	li	a2,0
    80004fa2:	4589                	li	a1,2
    80004fa4:	f5040513          	addi	a0,s0,-176
    80004fa8:	00000097          	auipc	ra,0x0
    80004fac:	972080e7          	jalr	-1678(ra) # 8000491a <create>
    80004fb0:	892a                	mv	s2,a0
    if(ip == 0){
    80004fb2:	c959                	beqz	a0,80005048 <sys_open+0xf4>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80004fb4:	04491703          	lh	a4,68(s2)
    80004fb8:	478d                	li	a5,3
    80004fba:	00f71763          	bne	a4,a5,80004fc8 <sys_open+0x74>
    80004fbe:	04695703          	lhu	a4,70(s2)
    80004fc2:	47a5                	li	a5,9
    80004fc4:	0ce7ec63          	bltu	a5,a4,8000509c <sys_open+0x148>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80004fc8:	fffff097          	auipc	ra,0xfffff
    80004fcc:	e02080e7          	jalr	-510(ra) # 80003dca <filealloc>
    80004fd0:	89aa                	mv	s3,a0
    80004fd2:	10050263          	beqz	a0,800050d6 <sys_open+0x182>
    80004fd6:	00000097          	auipc	ra,0x0
    80004fda:	902080e7          	jalr	-1790(ra) # 800048d8 <fdalloc>
    80004fde:	84aa                	mv	s1,a0
    80004fe0:	0e054663          	bltz	a0,800050cc <sys_open+0x178>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004fe4:	04491703          	lh	a4,68(s2)
    80004fe8:	478d                	li	a5,3
    80004fea:	0cf70463          	beq	a4,a5,800050b2 <sys_open+0x15e>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004fee:	4789                	li	a5,2
    80004ff0:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    80004ff4:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    80004ff8:	0129bc23          	sd	s2,24(s3)
  f->readable = !(omode & O_WRONLY);
    80004ffc:	f4c42783          	lw	a5,-180(s0)
    80005000:	0017c713          	xori	a4,a5,1
    80005004:	8b05                	andi	a4,a4,1
    80005006:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    8000500a:	0037f713          	andi	a4,a5,3
    8000500e:	00e03733          	snez	a4,a4
    80005012:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80005016:	4007f793          	andi	a5,a5,1024
    8000501a:	c791                	beqz	a5,80005026 <sys_open+0xd2>
    8000501c:	04491703          	lh	a4,68(s2)
    80005020:	4789                	li	a5,2
    80005022:	08f70f63          	beq	a4,a5,800050c0 <sys_open+0x16c>
    itrunc(ip);
  }

  iunlock(ip);
    80005026:	854a                	mv	a0,s2
    80005028:	ffffe097          	auipc	ra,0xffffe
    8000502c:	efa080e7          	jalr	-262(ra) # 80002f22 <iunlock>
  end_op();
    80005030:	fffff097          	auipc	ra,0xfffff
    80005034:	a0a080e7          	jalr	-1526(ra) # 80003a3a <end_op>

  return fd;
}
    80005038:	8526                	mv	a0,s1
    8000503a:	70ea                	ld	ra,184(sp)
    8000503c:	744a                	ld	s0,176(sp)
    8000503e:	74aa                	ld	s1,168(sp)
    80005040:	790a                	ld	s2,160(sp)
    80005042:	69ea                	ld	s3,152(sp)
    80005044:	6129                	addi	sp,sp,192
    80005046:	8082                	ret
      end_op();
    80005048:	fffff097          	auipc	ra,0xfffff
    8000504c:	9f2080e7          	jalr	-1550(ra) # 80003a3a <end_op>
      return -1;
    80005050:	b7e5                	j	80005038 <sys_open+0xe4>
    if((ip = namei(path)) == 0){
    80005052:	f5040513          	addi	a0,s0,-176
    80005056:	ffffe097          	auipc	ra,0xffffe
    8000505a:	5b6080e7          	jalr	1462(ra) # 8000360c <namei>
    8000505e:	892a                	mv	s2,a0
    80005060:	c905                	beqz	a0,80005090 <sys_open+0x13c>
    ilock(ip);
    80005062:	ffffe097          	auipc	ra,0xffffe
    80005066:	dfe080e7          	jalr	-514(ra) # 80002e60 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    8000506a:	04491703          	lh	a4,68(s2)
    8000506e:	4785                	li	a5,1
    80005070:	f4f712e3          	bne	a4,a5,80004fb4 <sys_open+0x60>
    80005074:	f4c42783          	lw	a5,-180(s0)
    80005078:	dba1                	beqz	a5,80004fc8 <sys_open+0x74>
      iunlockput(ip);
    8000507a:	854a                	mv	a0,s2
    8000507c:	ffffe097          	auipc	ra,0xffffe
    80005080:	046080e7          	jalr	70(ra) # 800030c2 <iunlockput>
      end_op();
    80005084:	fffff097          	auipc	ra,0xfffff
    80005088:	9b6080e7          	jalr	-1610(ra) # 80003a3a <end_op>
      return -1;
    8000508c:	54fd                	li	s1,-1
    8000508e:	b76d                	j	80005038 <sys_open+0xe4>
      end_op();
    80005090:	fffff097          	auipc	ra,0xfffff
    80005094:	9aa080e7          	jalr	-1622(ra) # 80003a3a <end_op>
      return -1;
    80005098:	54fd                	li	s1,-1
    8000509a:	bf79                	j	80005038 <sys_open+0xe4>
    iunlockput(ip);
    8000509c:	854a                	mv	a0,s2
    8000509e:	ffffe097          	auipc	ra,0xffffe
    800050a2:	024080e7          	jalr	36(ra) # 800030c2 <iunlockput>
    end_op();
    800050a6:	fffff097          	auipc	ra,0xfffff
    800050aa:	994080e7          	jalr	-1644(ra) # 80003a3a <end_op>
    return -1;
    800050ae:	54fd                	li	s1,-1
    800050b0:	b761                	j	80005038 <sys_open+0xe4>
    f->type = FD_DEVICE;
    800050b2:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    800050b6:	04691783          	lh	a5,70(s2)
    800050ba:	02f99223          	sh	a5,36(s3)
    800050be:	bf2d                	j	80004ff8 <sys_open+0xa4>
    itrunc(ip);
    800050c0:	854a                	mv	a0,s2
    800050c2:	ffffe097          	auipc	ra,0xffffe
    800050c6:	eac080e7          	jalr	-340(ra) # 80002f6e <itrunc>
    800050ca:	bfb1                	j	80005026 <sys_open+0xd2>
      fileclose(f);
    800050cc:	854e                	mv	a0,s3
    800050ce:	fffff097          	auipc	ra,0xfffff
    800050d2:	db8080e7          	jalr	-584(ra) # 80003e86 <fileclose>
    iunlockput(ip);
    800050d6:	854a                	mv	a0,s2
    800050d8:	ffffe097          	auipc	ra,0xffffe
    800050dc:	fea080e7          	jalr	-22(ra) # 800030c2 <iunlockput>
    end_op();
    800050e0:	fffff097          	auipc	ra,0xfffff
    800050e4:	95a080e7          	jalr	-1702(ra) # 80003a3a <end_op>
    return -1;
    800050e8:	54fd                	li	s1,-1
    800050ea:	b7b9                	j	80005038 <sys_open+0xe4>

00000000800050ec <sys_mkdir>:

uint64
sys_mkdir(void)
{
    800050ec:	7175                	addi	sp,sp,-144
    800050ee:	e506                	sd	ra,136(sp)
    800050f0:	e122                	sd	s0,128(sp)
    800050f2:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    800050f4:	fffff097          	auipc	ra,0xfffff
    800050f8:	8c6080e7          	jalr	-1850(ra) # 800039ba <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    800050fc:	08000613          	li	a2,128
    80005100:	f7040593          	addi	a1,s0,-144
    80005104:	4501                	li	a0,0
    80005106:	ffffd097          	auipc	ra,0xffffd
    8000510a:	162080e7          	jalr	354(ra) # 80002268 <argstr>
    8000510e:	02054963          	bltz	a0,80005140 <sys_mkdir+0x54>
    80005112:	4681                	li	a3,0
    80005114:	4601                	li	a2,0
    80005116:	4585                	li	a1,1
    80005118:	f7040513          	addi	a0,s0,-144
    8000511c:	fffff097          	auipc	ra,0xfffff
    80005120:	7fe080e7          	jalr	2046(ra) # 8000491a <create>
    80005124:	cd11                	beqz	a0,80005140 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80005126:	ffffe097          	auipc	ra,0xffffe
    8000512a:	f9c080e7          	jalr	-100(ra) # 800030c2 <iunlockput>
  end_op();
    8000512e:	fffff097          	auipc	ra,0xfffff
    80005132:	90c080e7          	jalr	-1780(ra) # 80003a3a <end_op>
  return 0;
    80005136:	4501                	li	a0,0
}
    80005138:	60aa                	ld	ra,136(sp)
    8000513a:	640a                	ld	s0,128(sp)
    8000513c:	6149                	addi	sp,sp,144
    8000513e:	8082                	ret
    end_op();
    80005140:	fffff097          	auipc	ra,0xfffff
    80005144:	8fa080e7          	jalr	-1798(ra) # 80003a3a <end_op>
    return -1;
    80005148:	557d                	li	a0,-1
    8000514a:	b7fd                	j	80005138 <sys_mkdir+0x4c>

000000008000514c <sys_mknod>:

uint64
sys_mknod(void)
{
    8000514c:	7135                	addi	sp,sp,-160
    8000514e:	ed06                	sd	ra,152(sp)
    80005150:	e922                	sd	s0,144(sp)
    80005152:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80005154:	fffff097          	auipc	ra,0xfffff
    80005158:	866080e7          	jalr	-1946(ra) # 800039ba <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    8000515c:	08000613          	li	a2,128
    80005160:	f7040593          	addi	a1,s0,-144
    80005164:	4501                	li	a0,0
    80005166:	ffffd097          	auipc	ra,0xffffd
    8000516a:	102080e7          	jalr	258(ra) # 80002268 <argstr>
    8000516e:	04054a63          	bltz	a0,800051c2 <sys_mknod+0x76>
     argint(1, &major) < 0 ||
    80005172:	f6c40593          	addi	a1,s0,-148
    80005176:	4505                	li	a0,1
    80005178:	ffffd097          	auipc	ra,0xffffd
    8000517c:	0ac080e7          	jalr	172(ra) # 80002224 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80005180:	04054163          	bltz	a0,800051c2 <sys_mknod+0x76>
     argint(2, &minor) < 0 ||
    80005184:	f6840593          	addi	a1,s0,-152
    80005188:	4509                	li	a0,2
    8000518a:	ffffd097          	auipc	ra,0xffffd
    8000518e:	09a080e7          	jalr	154(ra) # 80002224 <argint>
     argint(1, &major) < 0 ||
    80005192:	02054863          	bltz	a0,800051c2 <sys_mknod+0x76>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80005196:	f6841683          	lh	a3,-152(s0)
    8000519a:	f6c41603          	lh	a2,-148(s0)
    8000519e:	458d                	li	a1,3
    800051a0:	f7040513          	addi	a0,s0,-144
    800051a4:	fffff097          	auipc	ra,0xfffff
    800051a8:	776080e7          	jalr	1910(ra) # 8000491a <create>
     argint(2, &minor) < 0 ||
    800051ac:	c919                	beqz	a0,800051c2 <sys_mknod+0x76>
    end_op();
    return -1;
  }
  iunlockput(ip);
    800051ae:	ffffe097          	auipc	ra,0xffffe
    800051b2:	f14080e7          	jalr	-236(ra) # 800030c2 <iunlockput>
  end_op();
    800051b6:	fffff097          	auipc	ra,0xfffff
    800051ba:	884080e7          	jalr	-1916(ra) # 80003a3a <end_op>
  return 0;
    800051be:	4501                	li	a0,0
    800051c0:	a031                	j	800051cc <sys_mknod+0x80>
    end_op();
    800051c2:	fffff097          	auipc	ra,0xfffff
    800051c6:	878080e7          	jalr	-1928(ra) # 80003a3a <end_op>
    return -1;
    800051ca:	557d                	li	a0,-1
}
    800051cc:	60ea                	ld	ra,152(sp)
    800051ce:	644a                	ld	s0,144(sp)
    800051d0:	610d                	addi	sp,sp,160
    800051d2:	8082                	ret

00000000800051d4 <sys_chdir>:

uint64
sys_chdir(void)
{
    800051d4:	7135                	addi	sp,sp,-160
    800051d6:	ed06                	sd	ra,152(sp)
    800051d8:	e922                	sd	s0,144(sp)
    800051da:	e526                	sd	s1,136(sp)
    800051dc:	e14a                	sd	s2,128(sp)
    800051de:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    800051e0:	ffffc097          	auipc	ra,0xffffc
    800051e4:	f80080e7          	jalr	-128(ra) # 80001160 <myproc>
    800051e8:	892a                	mv	s2,a0
  
  begin_op();
    800051ea:	ffffe097          	auipc	ra,0xffffe
    800051ee:	7d0080e7          	jalr	2000(ra) # 800039ba <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    800051f2:	08000613          	li	a2,128
    800051f6:	f6040593          	addi	a1,s0,-160
    800051fa:	4501                	li	a0,0
    800051fc:	ffffd097          	auipc	ra,0xffffd
    80005200:	06c080e7          	jalr	108(ra) # 80002268 <argstr>
    80005204:	04054b63          	bltz	a0,8000525a <sys_chdir+0x86>
    80005208:	f6040513          	addi	a0,s0,-160
    8000520c:	ffffe097          	auipc	ra,0xffffe
    80005210:	400080e7          	jalr	1024(ra) # 8000360c <namei>
    80005214:	84aa                	mv	s1,a0
    80005216:	c131                	beqz	a0,8000525a <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80005218:	ffffe097          	auipc	ra,0xffffe
    8000521c:	c48080e7          	jalr	-952(ra) # 80002e60 <ilock>
  if(ip->type != T_DIR){
    80005220:	04449703          	lh	a4,68(s1)
    80005224:	4785                	li	a5,1
    80005226:	04f71063          	bne	a4,a5,80005266 <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    8000522a:	8526                	mv	a0,s1
    8000522c:	ffffe097          	auipc	ra,0xffffe
    80005230:	cf6080e7          	jalr	-778(ra) # 80002f22 <iunlock>
  iput(p->cwd);
    80005234:	15093503          	ld	a0,336(s2)
    80005238:	ffffe097          	auipc	ra,0xffffe
    8000523c:	de2080e7          	jalr	-542(ra) # 8000301a <iput>
  end_op();
    80005240:	ffffe097          	auipc	ra,0xffffe
    80005244:	7fa080e7          	jalr	2042(ra) # 80003a3a <end_op>
  p->cwd = ip;
    80005248:	14993823          	sd	s1,336(s2)
  return 0;
    8000524c:	4501                	li	a0,0
}
    8000524e:	60ea                	ld	ra,152(sp)
    80005250:	644a                	ld	s0,144(sp)
    80005252:	64aa                	ld	s1,136(sp)
    80005254:	690a                	ld	s2,128(sp)
    80005256:	610d                	addi	sp,sp,160
    80005258:	8082                	ret
    end_op();
    8000525a:	ffffe097          	auipc	ra,0xffffe
    8000525e:	7e0080e7          	jalr	2016(ra) # 80003a3a <end_op>
    return -1;
    80005262:	557d                	li	a0,-1
    80005264:	b7ed                	j	8000524e <sys_chdir+0x7a>
    iunlockput(ip);
    80005266:	8526                	mv	a0,s1
    80005268:	ffffe097          	auipc	ra,0xffffe
    8000526c:	e5a080e7          	jalr	-422(ra) # 800030c2 <iunlockput>
    end_op();
    80005270:	ffffe097          	auipc	ra,0xffffe
    80005274:	7ca080e7          	jalr	1994(ra) # 80003a3a <end_op>
    return -1;
    80005278:	557d                	li	a0,-1
    8000527a:	bfd1                	j	8000524e <sys_chdir+0x7a>

000000008000527c <sys_exec>:

uint64
sys_exec(void)
{
    8000527c:	7145                	addi	sp,sp,-464
    8000527e:	e786                	sd	ra,456(sp)
    80005280:	e3a2                	sd	s0,448(sp)
    80005282:	ff26                	sd	s1,440(sp)
    80005284:	fb4a                	sd	s2,432(sp)
    80005286:	f74e                	sd	s3,424(sp)
    80005288:	f352                	sd	s4,416(sp)
    8000528a:	ef56                	sd	s5,408(sp)
    8000528c:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    8000528e:	08000613          	li	a2,128
    80005292:	f4040593          	addi	a1,s0,-192
    80005296:	4501                	li	a0,0
    80005298:	ffffd097          	auipc	ra,0xffffd
    8000529c:	fd0080e7          	jalr	-48(ra) # 80002268 <argstr>
    return -1;
    800052a0:	597d                	li	s2,-1
  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    800052a2:	0c054a63          	bltz	a0,80005376 <sys_exec+0xfa>
    800052a6:	e3840593          	addi	a1,s0,-456
    800052aa:	4505                	li	a0,1
    800052ac:	ffffd097          	auipc	ra,0xffffd
    800052b0:	f9a080e7          	jalr	-102(ra) # 80002246 <argaddr>
    800052b4:	0c054163          	bltz	a0,80005376 <sys_exec+0xfa>
  }
  memset(argv, 0, sizeof(argv));
    800052b8:	10000613          	li	a2,256
    800052bc:	4581                	li	a1,0
    800052be:	e4040513          	addi	a0,s0,-448
    800052c2:	ffffb097          	auipc	ra,0xffffb
    800052c6:	eb6080e7          	jalr	-330(ra) # 80000178 <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    800052ca:	e4040493          	addi	s1,s0,-448
  memset(argv, 0, sizeof(argv));
    800052ce:	89a6                	mv	s3,s1
    800052d0:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    800052d2:	02000a13          	li	s4,32
    800052d6:	00090a9b          	sext.w	s5,s2
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    800052da:	00391513          	slli	a0,s2,0x3
    800052de:	e3040593          	addi	a1,s0,-464
    800052e2:	e3843783          	ld	a5,-456(s0)
    800052e6:	953e                	add	a0,a0,a5
    800052e8:	ffffd097          	auipc	ra,0xffffd
    800052ec:	ea2080e7          	jalr	-350(ra) # 8000218a <fetchaddr>
    800052f0:	02054a63          	bltz	a0,80005324 <sys_exec+0xa8>
      goto bad;
    }
    if(uarg == 0){
    800052f4:	e3043783          	ld	a5,-464(s0)
    800052f8:	c3b9                	beqz	a5,8000533e <sys_exec+0xc2>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    800052fa:	ffffb097          	auipc	ra,0xffffb
    800052fe:	e1e080e7          	jalr	-482(ra) # 80000118 <kalloc>
    80005302:	85aa                	mv	a1,a0
    80005304:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80005308:	cd11                	beqz	a0,80005324 <sys_exec+0xa8>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    8000530a:	6605                	lui	a2,0x1
    8000530c:	e3043503          	ld	a0,-464(s0)
    80005310:	ffffd097          	auipc	ra,0xffffd
    80005314:	ecc080e7          	jalr	-308(ra) # 800021dc <fetchstr>
    80005318:	00054663          	bltz	a0,80005324 <sys_exec+0xa8>
    if(i >= NELEM(argv)){
    8000531c:	0905                	addi	s2,s2,1
    8000531e:	09a1                	addi	s3,s3,8
    80005320:	fb491be3          	bne	s2,s4,800052d6 <sys_exec+0x5a>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005324:	10048913          	addi	s2,s1,256
    80005328:	6088                	ld	a0,0(s1)
    8000532a:	c529                	beqz	a0,80005374 <sys_exec+0xf8>
    kfree(argv[i]);
    8000532c:	ffffb097          	auipc	ra,0xffffb
    80005330:	cf0080e7          	jalr	-784(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005334:	04a1                	addi	s1,s1,8
    80005336:	ff2499e3          	bne	s1,s2,80005328 <sys_exec+0xac>
  return -1;
    8000533a:	597d                	li	s2,-1
    8000533c:	a82d                	j	80005376 <sys_exec+0xfa>
      argv[i] = 0;
    8000533e:	0a8e                	slli	s5,s5,0x3
    80005340:	fc040793          	addi	a5,s0,-64
    80005344:	9abe                	add	s5,s5,a5
    80005346:	e80ab023          	sd	zero,-384(s5)
  int ret = exec(path, argv);
    8000534a:	e4040593          	addi	a1,s0,-448
    8000534e:	f4040513          	addi	a0,s0,-192
    80005352:	fffff097          	auipc	ra,0xfffff
    80005356:	194080e7          	jalr	404(ra) # 800044e6 <exec>
    8000535a:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000535c:	10048993          	addi	s3,s1,256
    80005360:	6088                	ld	a0,0(s1)
    80005362:	c911                	beqz	a0,80005376 <sys_exec+0xfa>
    kfree(argv[i]);
    80005364:	ffffb097          	auipc	ra,0xffffb
    80005368:	cb8080e7          	jalr	-840(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000536c:	04a1                	addi	s1,s1,8
    8000536e:	ff3499e3          	bne	s1,s3,80005360 <sys_exec+0xe4>
    80005372:	a011                	j	80005376 <sys_exec+0xfa>
  return -1;
    80005374:	597d                	li	s2,-1
}
    80005376:	854a                	mv	a0,s2
    80005378:	60be                	ld	ra,456(sp)
    8000537a:	641e                	ld	s0,448(sp)
    8000537c:	74fa                	ld	s1,440(sp)
    8000537e:	795a                	ld	s2,432(sp)
    80005380:	79ba                	ld	s3,424(sp)
    80005382:	7a1a                	ld	s4,416(sp)
    80005384:	6afa                	ld	s5,408(sp)
    80005386:	6179                	addi	sp,sp,464
    80005388:	8082                	ret

000000008000538a <sys_pipe>:

uint64
sys_pipe(void)
{
    8000538a:	7139                	addi	sp,sp,-64
    8000538c:	fc06                	sd	ra,56(sp)
    8000538e:	f822                	sd	s0,48(sp)
    80005390:	f426                	sd	s1,40(sp)
    80005392:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80005394:	ffffc097          	auipc	ra,0xffffc
    80005398:	dcc080e7          	jalr	-564(ra) # 80001160 <myproc>
    8000539c:	84aa                	mv	s1,a0

  if(argaddr(0, &fdarray) < 0)
    8000539e:	fd840593          	addi	a1,s0,-40
    800053a2:	4501                	li	a0,0
    800053a4:	ffffd097          	auipc	ra,0xffffd
    800053a8:	ea2080e7          	jalr	-350(ra) # 80002246 <argaddr>
    return -1;
    800053ac:	57fd                	li	a5,-1
  if(argaddr(0, &fdarray) < 0)
    800053ae:	0e054063          	bltz	a0,8000548e <sys_pipe+0x104>
  if(pipealloc(&rf, &wf) < 0)
    800053b2:	fc840593          	addi	a1,s0,-56
    800053b6:	fd040513          	addi	a0,s0,-48
    800053ba:	fffff097          	auipc	ra,0xfffff
    800053be:	dfc080e7          	jalr	-516(ra) # 800041b6 <pipealloc>
    return -1;
    800053c2:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    800053c4:	0c054563          	bltz	a0,8000548e <sys_pipe+0x104>
  fd0 = -1;
    800053c8:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    800053cc:	fd043503          	ld	a0,-48(s0)
    800053d0:	fffff097          	auipc	ra,0xfffff
    800053d4:	508080e7          	jalr	1288(ra) # 800048d8 <fdalloc>
    800053d8:	fca42223          	sw	a0,-60(s0)
    800053dc:	08054c63          	bltz	a0,80005474 <sys_pipe+0xea>
    800053e0:	fc843503          	ld	a0,-56(s0)
    800053e4:	fffff097          	auipc	ra,0xfffff
    800053e8:	4f4080e7          	jalr	1268(ra) # 800048d8 <fdalloc>
    800053ec:	fca42023          	sw	a0,-64(s0)
    800053f0:	06054863          	bltz	a0,80005460 <sys_pipe+0xd6>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800053f4:	4691                	li	a3,4
    800053f6:	fc440613          	addi	a2,s0,-60
    800053fa:	fd843583          	ld	a1,-40(s0)
    800053fe:	68a8                	ld	a0,80(s1)
    80005400:	ffffb097          	auipc	ra,0xffffb
    80005404:	702080e7          	jalr	1794(ra) # 80000b02 <copyout>
    80005408:	02054063          	bltz	a0,80005428 <sys_pipe+0x9e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    8000540c:	4691                	li	a3,4
    8000540e:	fc040613          	addi	a2,s0,-64
    80005412:	fd843583          	ld	a1,-40(s0)
    80005416:	0591                	addi	a1,a1,4
    80005418:	68a8                	ld	a0,80(s1)
    8000541a:	ffffb097          	auipc	ra,0xffffb
    8000541e:	6e8080e7          	jalr	1768(ra) # 80000b02 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80005422:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005424:	06055563          	bgez	a0,8000548e <sys_pipe+0x104>
    p->ofile[fd0] = 0;
    80005428:	fc442783          	lw	a5,-60(s0)
    8000542c:	07e9                	addi	a5,a5,26
    8000542e:	078e                	slli	a5,a5,0x3
    80005430:	97a6                	add	a5,a5,s1
    80005432:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80005436:	fc042503          	lw	a0,-64(s0)
    8000543a:	0569                	addi	a0,a0,26
    8000543c:	050e                	slli	a0,a0,0x3
    8000543e:	9526                	add	a0,a0,s1
    80005440:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    80005444:	fd043503          	ld	a0,-48(s0)
    80005448:	fffff097          	auipc	ra,0xfffff
    8000544c:	a3e080e7          	jalr	-1474(ra) # 80003e86 <fileclose>
    fileclose(wf);
    80005450:	fc843503          	ld	a0,-56(s0)
    80005454:	fffff097          	auipc	ra,0xfffff
    80005458:	a32080e7          	jalr	-1486(ra) # 80003e86 <fileclose>
    return -1;
    8000545c:	57fd                	li	a5,-1
    8000545e:	a805                	j	8000548e <sys_pipe+0x104>
    if(fd0 >= 0)
    80005460:	fc442783          	lw	a5,-60(s0)
    80005464:	0007c863          	bltz	a5,80005474 <sys_pipe+0xea>
      p->ofile[fd0] = 0;
    80005468:	01a78513          	addi	a0,a5,26
    8000546c:	050e                	slli	a0,a0,0x3
    8000546e:	9526                	add	a0,a0,s1
    80005470:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    80005474:	fd043503          	ld	a0,-48(s0)
    80005478:	fffff097          	auipc	ra,0xfffff
    8000547c:	a0e080e7          	jalr	-1522(ra) # 80003e86 <fileclose>
    fileclose(wf);
    80005480:	fc843503          	ld	a0,-56(s0)
    80005484:	fffff097          	auipc	ra,0xfffff
    80005488:	a02080e7          	jalr	-1534(ra) # 80003e86 <fileclose>
    return -1;
    8000548c:	57fd                	li	a5,-1
}
    8000548e:	853e                	mv	a0,a5
    80005490:	70e2                	ld	ra,56(sp)
    80005492:	7442                	ld	s0,48(sp)
    80005494:	74a2                	ld	s1,40(sp)
    80005496:	6121                	addi	sp,sp,64
    80005498:	8082                	ret
    8000549a:	0000                	unimp
    8000549c:	0000                	unimp
	...

00000000800054a0 <kernelvec>:
    800054a0:	7111                	addi	sp,sp,-256
    800054a2:	e006                	sd	ra,0(sp)
    800054a4:	e40a                	sd	sp,8(sp)
    800054a6:	e80e                	sd	gp,16(sp)
    800054a8:	ec12                	sd	tp,24(sp)
    800054aa:	f016                	sd	t0,32(sp)
    800054ac:	f41a                	sd	t1,40(sp)
    800054ae:	f81e                	sd	t2,48(sp)
    800054b0:	fc22                	sd	s0,56(sp)
    800054b2:	e0a6                	sd	s1,64(sp)
    800054b4:	e4aa                	sd	a0,72(sp)
    800054b6:	e8ae                	sd	a1,80(sp)
    800054b8:	ecb2                	sd	a2,88(sp)
    800054ba:	f0b6                	sd	a3,96(sp)
    800054bc:	f4ba                	sd	a4,104(sp)
    800054be:	f8be                	sd	a5,112(sp)
    800054c0:	fcc2                	sd	a6,120(sp)
    800054c2:	e146                	sd	a7,128(sp)
    800054c4:	e54a                	sd	s2,136(sp)
    800054c6:	e94e                	sd	s3,144(sp)
    800054c8:	ed52                	sd	s4,152(sp)
    800054ca:	f156                	sd	s5,160(sp)
    800054cc:	f55a                	sd	s6,168(sp)
    800054ce:	f95e                	sd	s7,176(sp)
    800054d0:	fd62                	sd	s8,184(sp)
    800054d2:	e1e6                	sd	s9,192(sp)
    800054d4:	e5ea                	sd	s10,200(sp)
    800054d6:	e9ee                	sd	s11,208(sp)
    800054d8:	edf2                	sd	t3,216(sp)
    800054da:	f1f6                	sd	t4,224(sp)
    800054dc:	f5fa                	sd	t5,232(sp)
    800054de:	f9fe                	sd	t6,240(sp)
    800054e0:	b77fc0ef          	jal	ra,80002056 <kerneltrap>
    800054e4:	6082                	ld	ra,0(sp)
    800054e6:	6122                	ld	sp,8(sp)
    800054e8:	61c2                	ld	gp,16(sp)
    800054ea:	7282                	ld	t0,32(sp)
    800054ec:	7322                	ld	t1,40(sp)
    800054ee:	73c2                	ld	t2,48(sp)
    800054f0:	7462                	ld	s0,56(sp)
    800054f2:	6486                	ld	s1,64(sp)
    800054f4:	6526                	ld	a0,72(sp)
    800054f6:	65c6                	ld	a1,80(sp)
    800054f8:	6666                	ld	a2,88(sp)
    800054fa:	7686                	ld	a3,96(sp)
    800054fc:	7726                	ld	a4,104(sp)
    800054fe:	77c6                	ld	a5,112(sp)
    80005500:	7866                	ld	a6,120(sp)
    80005502:	688a                	ld	a7,128(sp)
    80005504:	692a                	ld	s2,136(sp)
    80005506:	69ca                	ld	s3,144(sp)
    80005508:	6a6a                	ld	s4,152(sp)
    8000550a:	7a8a                	ld	s5,160(sp)
    8000550c:	7b2a                	ld	s6,168(sp)
    8000550e:	7bca                	ld	s7,176(sp)
    80005510:	7c6a                	ld	s8,184(sp)
    80005512:	6c8e                	ld	s9,192(sp)
    80005514:	6d2e                	ld	s10,200(sp)
    80005516:	6dce                	ld	s11,208(sp)
    80005518:	6e6e                	ld	t3,216(sp)
    8000551a:	7e8e                	ld	t4,224(sp)
    8000551c:	7f2e                	ld	t5,232(sp)
    8000551e:	7fce                	ld	t6,240(sp)
    80005520:	6111                	addi	sp,sp,256
    80005522:	10200073          	sret
    80005526:	00000013          	nop
    8000552a:	00000013          	nop
    8000552e:	0001                	nop

0000000080005530 <timervec>:
    80005530:	34051573          	csrrw	a0,mscratch,a0
    80005534:	e10c                	sd	a1,0(a0)
    80005536:	e510                	sd	a2,8(a0)
    80005538:	e914                	sd	a3,16(a0)
    8000553a:	6d0c                	ld	a1,24(a0)
    8000553c:	7110                	ld	a2,32(a0)
    8000553e:	6194                	ld	a3,0(a1)
    80005540:	96b2                	add	a3,a3,a2
    80005542:	e194                	sd	a3,0(a1)
    80005544:	4589                	li	a1,2
    80005546:	14459073          	csrw	sip,a1
    8000554a:	6914                	ld	a3,16(a0)
    8000554c:	6510                	ld	a2,8(a0)
    8000554e:	610c                	ld	a1,0(a0)
    80005550:	34051573          	csrrw	a0,mscratch,a0
    80005554:	30200073          	mret
	...

000000008000555a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000555a:	1141                	addi	sp,sp,-16
    8000555c:	e422                	sd	s0,8(sp)
    8000555e:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80005560:	0c0007b7          	lui	a5,0xc000
    80005564:	4705                	li	a4,1
    80005566:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80005568:	c3d8                	sw	a4,4(a5)
}
    8000556a:	6422                	ld	s0,8(sp)
    8000556c:	0141                	addi	sp,sp,16
    8000556e:	8082                	ret

0000000080005570 <plicinithart>:

void
plicinithart(void)
{
    80005570:	1141                	addi	sp,sp,-16
    80005572:	e406                	sd	ra,8(sp)
    80005574:	e022                	sd	s0,0(sp)
    80005576:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005578:	ffffc097          	auipc	ra,0xffffc
    8000557c:	bbc080e7          	jalr	-1092(ra) # 80001134 <cpuid>
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005580:	0085171b          	slliw	a4,a0,0x8
    80005584:	0c0027b7          	lui	a5,0xc002
    80005588:	97ba                	add	a5,a5,a4
    8000558a:	40200713          	li	a4,1026
    8000558e:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005592:	00d5151b          	slliw	a0,a0,0xd
    80005596:	0c2017b7          	lui	a5,0xc201
    8000559a:	953e                	add	a0,a0,a5
    8000559c:	00052023          	sw	zero,0(a0)
}
    800055a0:	60a2                	ld	ra,8(sp)
    800055a2:	6402                	ld	s0,0(sp)
    800055a4:	0141                	addi	sp,sp,16
    800055a6:	8082                	ret

00000000800055a8 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    800055a8:	1141                	addi	sp,sp,-16
    800055aa:	e406                	sd	ra,8(sp)
    800055ac:	e022                	sd	s0,0(sp)
    800055ae:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800055b0:	ffffc097          	auipc	ra,0xffffc
    800055b4:	b84080e7          	jalr	-1148(ra) # 80001134 <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    800055b8:	00d5179b          	slliw	a5,a0,0xd
    800055bc:	0c201537          	lui	a0,0xc201
    800055c0:	953e                	add	a0,a0,a5
  return irq;
}
    800055c2:	4148                	lw	a0,4(a0)
    800055c4:	60a2                	ld	ra,8(sp)
    800055c6:	6402                	ld	s0,0(sp)
    800055c8:	0141                	addi	sp,sp,16
    800055ca:	8082                	ret

00000000800055cc <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    800055cc:	1101                	addi	sp,sp,-32
    800055ce:	ec06                	sd	ra,24(sp)
    800055d0:	e822                	sd	s0,16(sp)
    800055d2:	e426                	sd	s1,8(sp)
    800055d4:	1000                	addi	s0,sp,32
    800055d6:	84aa                	mv	s1,a0
  int hart = cpuid();
    800055d8:	ffffc097          	auipc	ra,0xffffc
    800055dc:	b5c080e7          	jalr	-1188(ra) # 80001134 <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    800055e0:	00d5151b          	slliw	a0,a0,0xd
    800055e4:	0c2017b7          	lui	a5,0xc201
    800055e8:	97aa                	add	a5,a5,a0
    800055ea:	c3c4                	sw	s1,4(a5)
}
    800055ec:	60e2                	ld	ra,24(sp)
    800055ee:	6442                	ld	s0,16(sp)
    800055f0:	64a2                	ld	s1,8(sp)
    800055f2:	6105                	addi	sp,sp,32
    800055f4:	8082                	ret

00000000800055f6 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    800055f6:	1141                	addi	sp,sp,-16
    800055f8:	e406                	sd	ra,8(sp)
    800055fa:	e022                	sd	s0,0(sp)
    800055fc:	0800                	addi	s0,sp,16
  if(i >= NUM)
    800055fe:	479d                	li	a5,7
    80005600:	06a7c963          	blt	a5,a0,80005672 <free_desc+0x7c>
    panic("free_desc 1");
  if(disk.free[i])
    80005604:	00016797          	auipc	a5,0x16
    80005608:	9fc78793          	addi	a5,a5,-1540 # 8001b000 <disk>
    8000560c:	00a78733          	add	a4,a5,a0
    80005610:	6789                	lui	a5,0x2
    80005612:	97ba                	add	a5,a5,a4
    80005614:	0187c783          	lbu	a5,24(a5) # 2018 <_entry-0x7fffdfe8>
    80005618:	e7ad                	bnez	a5,80005682 <free_desc+0x8c>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    8000561a:	00451793          	slli	a5,a0,0x4
    8000561e:	00018717          	auipc	a4,0x18
    80005622:	9e270713          	addi	a4,a4,-1566 # 8001d000 <disk+0x2000>
    80005626:	6314                	ld	a3,0(a4)
    80005628:	96be                	add	a3,a3,a5
    8000562a:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    8000562e:	6314                	ld	a3,0(a4)
    80005630:	96be                	add	a3,a3,a5
    80005632:	0006a423          	sw	zero,8(a3)
  disk.desc[i].flags = 0;
    80005636:	6314                	ld	a3,0(a4)
    80005638:	96be                	add	a3,a3,a5
    8000563a:	00069623          	sh	zero,12(a3)
  disk.desc[i].next = 0;
    8000563e:	6318                	ld	a4,0(a4)
    80005640:	97ba                	add	a5,a5,a4
    80005642:	00079723          	sh	zero,14(a5)
  disk.free[i] = 1;
    80005646:	00016797          	auipc	a5,0x16
    8000564a:	9ba78793          	addi	a5,a5,-1606 # 8001b000 <disk>
    8000564e:	97aa                	add	a5,a5,a0
    80005650:	6509                	lui	a0,0x2
    80005652:	953e                	add	a0,a0,a5
    80005654:	4785                	li	a5,1
    80005656:	00f50c23          	sb	a5,24(a0) # 2018 <_entry-0x7fffdfe8>
  wakeup(&disk.free[0]);
    8000565a:	00018517          	auipc	a0,0x18
    8000565e:	9be50513          	addi	a0,a0,-1602 # 8001d018 <disk+0x2018>
    80005662:	ffffc097          	auipc	ra,0xffffc
    80005666:	346080e7          	jalr	838(ra) # 800019a8 <wakeup>
}
    8000566a:	60a2                	ld	ra,8(sp)
    8000566c:	6402                	ld	s0,0(sp)
    8000566e:	0141                	addi	sp,sp,16
    80005670:	8082                	ret
    panic("free_desc 1");
    80005672:	00003517          	auipc	a0,0x3
    80005676:	20650513          	addi	a0,a0,518 # 80008878 <syscalls+0x418>
    8000567a:	00001097          	auipc	ra,0x1
    8000567e:	c56080e7          	jalr	-938(ra) # 800062d0 <panic>
    panic("free_desc 2");
    80005682:	00003517          	auipc	a0,0x3
    80005686:	20650513          	addi	a0,a0,518 # 80008888 <syscalls+0x428>
    8000568a:	00001097          	auipc	ra,0x1
    8000568e:	c46080e7          	jalr	-954(ra) # 800062d0 <panic>

0000000080005692 <virtio_disk_init>:
{
    80005692:	1101                	addi	sp,sp,-32
    80005694:	ec06                	sd	ra,24(sp)
    80005696:	e822                	sd	s0,16(sp)
    80005698:	e426                	sd	s1,8(sp)
    8000569a:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    8000569c:	00003597          	auipc	a1,0x3
    800056a0:	1fc58593          	addi	a1,a1,508 # 80008898 <syscalls+0x438>
    800056a4:	00018517          	auipc	a0,0x18
    800056a8:	a8450513          	addi	a0,a0,-1404 # 8001d128 <disk+0x2128>
    800056ac:	00001097          	auipc	ra,0x1
    800056b0:	0de080e7          	jalr	222(ra) # 8000678a <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800056b4:	100017b7          	lui	a5,0x10001
    800056b8:	4398                	lw	a4,0(a5)
    800056ba:	2701                	sext.w	a4,a4
    800056bc:	747277b7          	lui	a5,0x74727
    800056c0:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    800056c4:	0ef71163          	bne	a4,a5,800057a6 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    800056c8:	100017b7          	lui	a5,0x10001
    800056cc:	43dc                	lw	a5,4(a5)
    800056ce:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800056d0:	4705                	li	a4,1
    800056d2:	0ce79a63          	bne	a5,a4,800057a6 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800056d6:	100017b7          	lui	a5,0x10001
    800056da:	479c                	lw	a5,8(a5)
    800056dc:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    800056de:	4709                	li	a4,2
    800056e0:	0ce79363          	bne	a5,a4,800057a6 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    800056e4:	100017b7          	lui	a5,0x10001
    800056e8:	47d8                	lw	a4,12(a5)
    800056ea:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800056ec:	554d47b7          	lui	a5,0x554d4
    800056f0:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    800056f4:	0af71963          	bne	a4,a5,800057a6 <virtio_disk_init+0x114>
  *R(VIRTIO_MMIO_STATUS) = status;
    800056f8:	100017b7          	lui	a5,0x10001
    800056fc:	4705                	li	a4,1
    800056fe:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005700:	470d                	li	a4,3
    80005702:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80005704:	4b94                	lw	a3,16(a5)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80005706:	c7ffe737          	lui	a4,0xc7ffe
    8000570a:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fd851f>
    8000570e:	8f75                	and	a4,a4,a3
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80005710:	2701                	sext.w	a4,a4
    80005712:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005714:	472d                	li	a4,11
    80005716:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005718:	473d                	li	a4,15
    8000571a:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    8000571c:	6705                	lui	a4,0x1
    8000571e:	d798                	sw	a4,40(a5)
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80005720:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80005724:	5bdc                	lw	a5,52(a5)
    80005726:	2781                	sext.w	a5,a5
  if(max == 0)
    80005728:	c7d9                	beqz	a5,800057b6 <virtio_disk_init+0x124>
  if(max < NUM)
    8000572a:	471d                	li	a4,7
    8000572c:	08f77d63          	bgeu	a4,a5,800057c6 <virtio_disk_init+0x134>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80005730:	100014b7          	lui	s1,0x10001
    80005734:	47a1                	li	a5,8
    80005736:	dc9c                	sw	a5,56(s1)
  memset(disk.pages, 0, sizeof(disk.pages));
    80005738:	6609                	lui	a2,0x2
    8000573a:	4581                	li	a1,0
    8000573c:	00016517          	auipc	a0,0x16
    80005740:	8c450513          	addi	a0,a0,-1852 # 8001b000 <disk>
    80005744:	ffffb097          	auipc	ra,0xffffb
    80005748:	a34080e7          	jalr	-1484(ra) # 80000178 <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    8000574c:	00016717          	auipc	a4,0x16
    80005750:	8b470713          	addi	a4,a4,-1868 # 8001b000 <disk>
    80005754:	00c75793          	srli	a5,a4,0xc
    80005758:	2781                	sext.w	a5,a5
    8000575a:	c0bc                	sw	a5,64(s1)
  disk.desc = (struct virtq_desc *) disk.pages;
    8000575c:	00018797          	auipc	a5,0x18
    80005760:	8a478793          	addi	a5,a5,-1884 # 8001d000 <disk+0x2000>
    80005764:	e398                	sd	a4,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    80005766:	00016717          	auipc	a4,0x16
    8000576a:	91a70713          	addi	a4,a4,-1766 # 8001b080 <disk+0x80>
    8000576e:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    80005770:	00017717          	auipc	a4,0x17
    80005774:	89070713          	addi	a4,a4,-1904 # 8001c000 <disk+0x1000>
    80005778:	eb98                	sd	a4,16(a5)
    disk.free[i] = 1;
    8000577a:	4705                	li	a4,1
    8000577c:	00e78c23          	sb	a4,24(a5)
    80005780:	00e78ca3          	sb	a4,25(a5)
    80005784:	00e78d23          	sb	a4,26(a5)
    80005788:	00e78da3          	sb	a4,27(a5)
    8000578c:	00e78e23          	sb	a4,28(a5)
    80005790:	00e78ea3          	sb	a4,29(a5)
    80005794:	00e78f23          	sb	a4,30(a5)
    80005798:	00e78fa3          	sb	a4,31(a5)
}
    8000579c:	60e2                	ld	ra,24(sp)
    8000579e:	6442                	ld	s0,16(sp)
    800057a0:	64a2                	ld	s1,8(sp)
    800057a2:	6105                	addi	sp,sp,32
    800057a4:	8082                	ret
    panic("could not find virtio disk");
    800057a6:	00003517          	auipc	a0,0x3
    800057aa:	10250513          	addi	a0,a0,258 # 800088a8 <syscalls+0x448>
    800057ae:	00001097          	auipc	ra,0x1
    800057b2:	b22080e7          	jalr	-1246(ra) # 800062d0 <panic>
    panic("virtio disk has no queue 0");
    800057b6:	00003517          	auipc	a0,0x3
    800057ba:	11250513          	addi	a0,a0,274 # 800088c8 <syscalls+0x468>
    800057be:	00001097          	auipc	ra,0x1
    800057c2:	b12080e7          	jalr	-1262(ra) # 800062d0 <panic>
    panic("virtio disk max queue too short");
    800057c6:	00003517          	auipc	a0,0x3
    800057ca:	12250513          	addi	a0,a0,290 # 800088e8 <syscalls+0x488>
    800057ce:	00001097          	auipc	ra,0x1
    800057d2:	b02080e7          	jalr	-1278(ra) # 800062d0 <panic>

00000000800057d6 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    800057d6:	7159                	addi	sp,sp,-112
    800057d8:	f486                	sd	ra,104(sp)
    800057da:	f0a2                	sd	s0,96(sp)
    800057dc:	eca6                	sd	s1,88(sp)
    800057de:	e8ca                	sd	s2,80(sp)
    800057e0:	e4ce                	sd	s3,72(sp)
    800057e2:	e0d2                	sd	s4,64(sp)
    800057e4:	fc56                	sd	s5,56(sp)
    800057e6:	f85a                	sd	s6,48(sp)
    800057e8:	f45e                	sd	s7,40(sp)
    800057ea:	f062                	sd	s8,32(sp)
    800057ec:	ec66                	sd	s9,24(sp)
    800057ee:	e86a                	sd	s10,16(sp)
    800057f0:	1880                	addi	s0,sp,112
    800057f2:	892a                	mv	s2,a0
    800057f4:	8d2e                	mv	s10,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    800057f6:	00c52c83          	lw	s9,12(a0)
    800057fa:	001c9c9b          	slliw	s9,s9,0x1
    800057fe:	1c82                	slli	s9,s9,0x20
    80005800:	020cdc93          	srli	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    80005804:	00018517          	auipc	a0,0x18
    80005808:	92450513          	addi	a0,a0,-1756 # 8001d128 <disk+0x2128>
    8000580c:	00001097          	auipc	ra,0x1
    80005810:	00e080e7          	jalr	14(ra) # 8000681a <acquire>
  for(int i = 0; i < 3; i++){
    80005814:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    80005816:	4c21                	li	s8,8
      disk.free[i] = 0;
    80005818:	00015b97          	auipc	s7,0x15
    8000581c:	7e8b8b93          	addi	s7,s7,2024 # 8001b000 <disk>
    80005820:	6b09                	lui	s6,0x2
  for(int i = 0; i < 3; i++){
    80005822:	4a8d                	li	s5,3
  for(int i = 0; i < NUM; i++){
    80005824:	8a4e                	mv	s4,s3
    80005826:	a051                	j	800058aa <virtio_disk_rw+0xd4>
      disk.free[i] = 0;
    80005828:	00fb86b3          	add	a3,s7,a5
    8000582c:	96da                	add	a3,a3,s6
    8000582e:	00068c23          	sb	zero,24(a3)
    idx[i] = alloc_desc();
    80005832:	c21c                	sw	a5,0(a2)
    if(idx[i] < 0){
    80005834:	0207c563          	bltz	a5,8000585e <virtio_disk_rw+0x88>
  for(int i = 0; i < 3; i++){
    80005838:	2485                	addiw	s1,s1,1
    8000583a:	0711                	addi	a4,a4,4
    8000583c:	25548063          	beq	s1,s5,80005a7c <virtio_disk_rw+0x2a6>
    idx[i] = alloc_desc();
    80005840:	863a                	mv	a2,a4
  for(int i = 0; i < NUM; i++){
    80005842:	00017697          	auipc	a3,0x17
    80005846:	7d668693          	addi	a3,a3,2006 # 8001d018 <disk+0x2018>
    8000584a:	87d2                	mv	a5,s4
    if(disk.free[i]){
    8000584c:	0006c583          	lbu	a1,0(a3)
    80005850:	fde1                	bnez	a1,80005828 <virtio_disk_rw+0x52>
  for(int i = 0; i < NUM; i++){
    80005852:	2785                	addiw	a5,a5,1
    80005854:	0685                	addi	a3,a3,1
    80005856:	ff879be3          	bne	a5,s8,8000584c <virtio_disk_rw+0x76>
    idx[i] = alloc_desc();
    8000585a:	57fd                	li	a5,-1
    8000585c:	c21c                	sw	a5,0(a2)
      for(int j = 0; j < i; j++)
    8000585e:	02905a63          	blez	s1,80005892 <virtio_disk_rw+0xbc>
        free_desc(idx[j]);
    80005862:	f9042503          	lw	a0,-112(s0)
    80005866:	00000097          	auipc	ra,0x0
    8000586a:	d90080e7          	jalr	-624(ra) # 800055f6 <free_desc>
      for(int j = 0; j < i; j++)
    8000586e:	4785                	li	a5,1
    80005870:	0297d163          	bge	a5,s1,80005892 <virtio_disk_rw+0xbc>
        free_desc(idx[j]);
    80005874:	f9442503          	lw	a0,-108(s0)
    80005878:	00000097          	auipc	ra,0x0
    8000587c:	d7e080e7          	jalr	-642(ra) # 800055f6 <free_desc>
      for(int j = 0; j < i; j++)
    80005880:	4789                	li	a5,2
    80005882:	0097d863          	bge	a5,s1,80005892 <virtio_disk_rw+0xbc>
        free_desc(idx[j]);
    80005886:	f9842503          	lw	a0,-104(s0)
    8000588a:	00000097          	auipc	ra,0x0
    8000588e:	d6c080e7          	jalr	-660(ra) # 800055f6 <free_desc>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80005892:	00018597          	auipc	a1,0x18
    80005896:	89658593          	addi	a1,a1,-1898 # 8001d128 <disk+0x2128>
    8000589a:	00017517          	auipc	a0,0x17
    8000589e:	77e50513          	addi	a0,a0,1918 # 8001d018 <disk+0x2018>
    800058a2:	ffffc097          	auipc	ra,0xffffc
    800058a6:	f7a080e7          	jalr	-134(ra) # 8000181c <sleep>
  for(int i = 0; i < 3; i++){
    800058aa:	f9040713          	addi	a4,s0,-112
    800058ae:	84ce                	mv	s1,s3
    800058b0:	bf41                	j	80005840 <virtio_disk_rw+0x6a>
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];

  if(write)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    800058b2:	20058713          	addi	a4,a1,512
    800058b6:	00471693          	slli	a3,a4,0x4
    800058ba:	00015717          	auipc	a4,0x15
    800058be:	74670713          	addi	a4,a4,1862 # 8001b000 <disk>
    800058c2:	9736                	add	a4,a4,a3
    800058c4:	4685                	li	a3,1
    800058c6:	0ad72423          	sw	a3,168(a4)
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    800058ca:	20058713          	addi	a4,a1,512
    800058ce:	00471693          	slli	a3,a4,0x4
    800058d2:	00015717          	auipc	a4,0x15
    800058d6:	72e70713          	addi	a4,a4,1838 # 8001b000 <disk>
    800058da:	9736                	add	a4,a4,a3
    800058dc:	0a072623          	sw	zero,172(a4)
  buf0->sector = sector;
    800058e0:	0b973823          	sd	s9,176(a4)

  disk.desc[idx[0]].addr = (uint64) buf0;
    800058e4:	7679                	lui	a2,0xffffe
    800058e6:	963e                	add	a2,a2,a5
    800058e8:	00017697          	auipc	a3,0x17
    800058ec:	71868693          	addi	a3,a3,1816 # 8001d000 <disk+0x2000>
    800058f0:	6298                	ld	a4,0(a3)
    800058f2:	9732                	add	a4,a4,a2
    800058f4:	e308                	sd	a0,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    800058f6:	6298                	ld	a4,0(a3)
    800058f8:	9732                	add	a4,a4,a2
    800058fa:	4541                	li	a0,16
    800058fc:	c708                	sw	a0,8(a4)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    800058fe:	6298                	ld	a4,0(a3)
    80005900:	9732                	add	a4,a4,a2
    80005902:	4505                	li	a0,1
    80005904:	00a71623          	sh	a0,12(a4)
  disk.desc[idx[0]].next = idx[1];
    80005908:	f9442703          	lw	a4,-108(s0)
    8000590c:	6288                	ld	a0,0(a3)
    8000590e:	962a                	add	a2,a2,a0
    80005910:	00e61723          	sh	a4,14(a2) # ffffffffffffe00e <end+0xffffffff7ffd7dce>

  disk.desc[idx[1]].addr = (uint64) b->data;
    80005914:	0712                	slli	a4,a4,0x4
    80005916:	6290                	ld	a2,0(a3)
    80005918:	963a                	add	a2,a2,a4
    8000591a:	05890513          	addi	a0,s2,88
    8000591e:	e208                	sd	a0,0(a2)
  disk.desc[idx[1]].len = BSIZE;
    80005920:	6294                	ld	a3,0(a3)
    80005922:	96ba                	add	a3,a3,a4
    80005924:	40000613          	li	a2,1024
    80005928:	c690                	sw	a2,8(a3)
  if(write)
    8000592a:	140d0063          	beqz	s10,80005a6a <virtio_disk_rw+0x294>
    disk.desc[idx[1]].flags = 0; // device reads b->data
    8000592e:	00017697          	auipc	a3,0x17
    80005932:	6d26b683          	ld	a3,1746(a3) # 8001d000 <disk+0x2000>
    80005936:	96ba                	add	a3,a3,a4
    80005938:	00069623          	sh	zero,12(a3)
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    8000593c:	00015817          	auipc	a6,0x15
    80005940:	6c480813          	addi	a6,a6,1732 # 8001b000 <disk>
    80005944:	00017517          	auipc	a0,0x17
    80005948:	6bc50513          	addi	a0,a0,1724 # 8001d000 <disk+0x2000>
    8000594c:	6114                	ld	a3,0(a0)
    8000594e:	96ba                	add	a3,a3,a4
    80005950:	00c6d603          	lhu	a2,12(a3)
    80005954:	00166613          	ori	a2,a2,1
    80005958:	00c69623          	sh	a2,12(a3)
  disk.desc[idx[1]].next = idx[2];
    8000595c:	f9842683          	lw	a3,-104(s0)
    80005960:	6110                	ld	a2,0(a0)
    80005962:	9732                	add	a4,a4,a2
    80005964:	00d71723          	sh	a3,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80005968:	20058613          	addi	a2,a1,512
    8000596c:	0612                	slli	a2,a2,0x4
    8000596e:	9642                	add	a2,a2,a6
    80005970:	577d                	li	a4,-1
    80005972:	02e60823          	sb	a4,48(a2)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80005976:	00469713          	slli	a4,a3,0x4
    8000597a:	6114                	ld	a3,0(a0)
    8000597c:	96ba                	add	a3,a3,a4
    8000597e:	03078793          	addi	a5,a5,48
    80005982:	97c2                	add	a5,a5,a6
    80005984:	e29c                	sd	a5,0(a3)
  disk.desc[idx[2]].len = 1;
    80005986:	611c                	ld	a5,0(a0)
    80005988:	97ba                	add	a5,a5,a4
    8000598a:	4685                	li	a3,1
    8000598c:	c794                	sw	a3,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    8000598e:	611c                	ld	a5,0(a0)
    80005990:	97ba                	add	a5,a5,a4
    80005992:	4809                	li	a6,2
    80005994:	01079623          	sh	a6,12(a5)
  disk.desc[idx[2]].next = 0;
    80005998:	611c                	ld	a5,0(a0)
    8000599a:	973e                	add	a4,a4,a5
    8000599c:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    800059a0:	00d92223          	sw	a3,4(s2)
  disk.info[idx[0]].b = b;
    800059a4:	03263423          	sd	s2,40(a2)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    800059a8:	6518                	ld	a4,8(a0)
    800059aa:	00275783          	lhu	a5,2(a4)
    800059ae:	8b9d                	andi	a5,a5,7
    800059b0:	0786                	slli	a5,a5,0x1
    800059b2:	97ba                	add	a5,a5,a4
    800059b4:	00b79223          	sh	a1,4(a5)

  __sync_synchronize();
    800059b8:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    800059bc:	6518                	ld	a4,8(a0)
    800059be:	00275783          	lhu	a5,2(a4)
    800059c2:	2785                	addiw	a5,a5,1
    800059c4:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    800059c8:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    800059cc:	100017b7          	lui	a5,0x10001
    800059d0:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    800059d4:	00492703          	lw	a4,4(s2)
    800059d8:	4785                	li	a5,1
    800059da:	02f71163          	bne	a4,a5,800059fc <virtio_disk_rw+0x226>
    sleep(b, &disk.vdisk_lock);
    800059de:	00017997          	auipc	s3,0x17
    800059e2:	74a98993          	addi	s3,s3,1866 # 8001d128 <disk+0x2128>
  while(b->disk == 1) {
    800059e6:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    800059e8:	85ce                	mv	a1,s3
    800059ea:	854a                	mv	a0,s2
    800059ec:	ffffc097          	auipc	ra,0xffffc
    800059f0:	e30080e7          	jalr	-464(ra) # 8000181c <sleep>
  while(b->disk == 1) {
    800059f4:	00492783          	lw	a5,4(s2)
    800059f8:	fe9788e3          	beq	a5,s1,800059e8 <virtio_disk_rw+0x212>
  }

  disk.info[idx[0]].b = 0;
    800059fc:	f9042903          	lw	s2,-112(s0)
    80005a00:	20090793          	addi	a5,s2,512
    80005a04:	00479713          	slli	a4,a5,0x4
    80005a08:	00015797          	auipc	a5,0x15
    80005a0c:	5f878793          	addi	a5,a5,1528 # 8001b000 <disk>
    80005a10:	97ba                	add	a5,a5,a4
    80005a12:	0207b423          	sd	zero,40(a5)
    int flag = disk.desc[i].flags;
    80005a16:	00017997          	auipc	s3,0x17
    80005a1a:	5ea98993          	addi	s3,s3,1514 # 8001d000 <disk+0x2000>
    80005a1e:	00491713          	slli	a4,s2,0x4
    80005a22:	0009b783          	ld	a5,0(s3)
    80005a26:	97ba                	add	a5,a5,a4
    80005a28:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80005a2c:	854a                	mv	a0,s2
    80005a2e:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80005a32:	00000097          	auipc	ra,0x0
    80005a36:	bc4080e7          	jalr	-1084(ra) # 800055f6 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80005a3a:	8885                	andi	s1,s1,1
    80005a3c:	f0ed                	bnez	s1,80005a1e <virtio_disk_rw+0x248>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80005a3e:	00017517          	auipc	a0,0x17
    80005a42:	6ea50513          	addi	a0,a0,1770 # 8001d128 <disk+0x2128>
    80005a46:	00001097          	auipc	ra,0x1
    80005a4a:	e88080e7          	jalr	-376(ra) # 800068ce <release>
}
    80005a4e:	70a6                	ld	ra,104(sp)
    80005a50:	7406                	ld	s0,96(sp)
    80005a52:	64e6                	ld	s1,88(sp)
    80005a54:	6946                	ld	s2,80(sp)
    80005a56:	69a6                	ld	s3,72(sp)
    80005a58:	6a06                	ld	s4,64(sp)
    80005a5a:	7ae2                	ld	s5,56(sp)
    80005a5c:	7b42                	ld	s6,48(sp)
    80005a5e:	7ba2                	ld	s7,40(sp)
    80005a60:	7c02                	ld	s8,32(sp)
    80005a62:	6ce2                	ld	s9,24(sp)
    80005a64:	6d42                	ld	s10,16(sp)
    80005a66:	6165                	addi	sp,sp,112
    80005a68:	8082                	ret
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    80005a6a:	00017697          	auipc	a3,0x17
    80005a6e:	5966b683          	ld	a3,1430(a3) # 8001d000 <disk+0x2000>
    80005a72:	96ba                	add	a3,a3,a4
    80005a74:	4609                	li	a2,2
    80005a76:	00c69623          	sh	a2,12(a3)
    80005a7a:	b5c9                	j	8000593c <virtio_disk_rw+0x166>
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80005a7c:	f9042583          	lw	a1,-112(s0)
    80005a80:	20058793          	addi	a5,a1,512
    80005a84:	0792                	slli	a5,a5,0x4
    80005a86:	00015517          	auipc	a0,0x15
    80005a8a:	62250513          	addi	a0,a0,1570 # 8001b0a8 <disk+0xa8>
    80005a8e:	953e                	add	a0,a0,a5
  if(write)
    80005a90:	e20d11e3          	bnez	s10,800058b2 <virtio_disk_rw+0xdc>
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
    80005a94:	20058713          	addi	a4,a1,512
    80005a98:	00471693          	slli	a3,a4,0x4
    80005a9c:	00015717          	auipc	a4,0x15
    80005aa0:	56470713          	addi	a4,a4,1380 # 8001b000 <disk>
    80005aa4:	9736                	add	a4,a4,a3
    80005aa6:	0a072423          	sw	zero,168(a4)
    80005aaa:	b505                	j	800058ca <virtio_disk_rw+0xf4>

0000000080005aac <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80005aac:	1101                	addi	sp,sp,-32
    80005aae:	ec06                	sd	ra,24(sp)
    80005ab0:	e822                	sd	s0,16(sp)
    80005ab2:	e426                	sd	s1,8(sp)
    80005ab4:	e04a                	sd	s2,0(sp)
    80005ab6:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80005ab8:	00017517          	auipc	a0,0x17
    80005abc:	67050513          	addi	a0,a0,1648 # 8001d128 <disk+0x2128>
    80005ac0:	00001097          	auipc	ra,0x1
    80005ac4:	d5a080e7          	jalr	-678(ra) # 8000681a <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80005ac8:	10001737          	lui	a4,0x10001
    80005acc:	533c                	lw	a5,96(a4)
    80005ace:	8b8d                	andi	a5,a5,3
    80005ad0:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    80005ad2:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80005ad6:	00017797          	auipc	a5,0x17
    80005ada:	52a78793          	addi	a5,a5,1322 # 8001d000 <disk+0x2000>
    80005ade:	6b94                	ld	a3,16(a5)
    80005ae0:	0207d703          	lhu	a4,32(a5)
    80005ae4:	0026d783          	lhu	a5,2(a3)
    80005ae8:	06f70163          	beq	a4,a5,80005b4a <virtio_disk_intr+0x9e>
    __sync_synchronize();
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80005aec:	00015917          	auipc	s2,0x15
    80005af0:	51490913          	addi	s2,s2,1300 # 8001b000 <disk>
    80005af4:	00017497          	auipc	s1,0x17
    80005af8:	50c48493          	addi	s1,s1,1292 # 8001d000 <disk+0x2000>
    __sync_synchronize();
    80005afc:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80005b00:	6898                	ld	a4,16(s1)
    80005b02:	0204d783          	lhu	a5,32(s1)
    80005b06:	8b9d                	andi	a5,a5,7
    80005b08:	078e                	slli	a5,a5,0x3
    80005b0a:	97ba                	add	a5,a5,a4
    80005b0c:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80005b0e:	20078713          	addi	a4,a5,512
    80005b12:	0712                	slli	a4,a4,0x4
    80005b14:	974a                	add	a4,a4,s2
    80005b16:	03074703          	lbu	a4,48(a4) # 10001030 <_entry-0x6fffefd0>
    80005b1a:	e731                	bnez	a4,80005b66 <virtio_disk_intr+0xba>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80005b1c:	20078793          	addi	a5,a5,512
    80005b20:	0792                	slli	a5,a5,0x4
    80005b22:	97ca                	add	a5,a5,s2
    80005b24:	7788                	ld	a0,40(a5)
    b->disk = 0;   // disk is done with buf
    80005b26:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80005b2a:	ffffc097          	auipc	ra,0xffffc
    80005b2e:	e7e080e7          	jalr	-386(ra) # 800019a8 <wakeup>

    disk.used_idx += 1;
    80005b32:	0204d783          	lhu	a5,32(s1)
    80005b36:	2785                	addiw	a5,a5,1
    80005b38:	17c2                	slli	a5,a5,0x30
    80005b3a:	93c1                	srli	a5,a5,0x30
    80005b3c:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80005b40:	6898                	ld	a4,16(s1)
    80005b42:	00275703          	lhu	a4,2(a4)
    80005b46:	faf71be3          	bne	a4,a5,80005afc <virtio_disk_intr+0x50>
  }

  release(&disk.vdisk_lock);
    80005b4a:	00017517          	auipc	a0,0x17
    80005b4e:	5de50513          	addi	a0,a0,1502 # 8001d128 <disk+0x2128>
    80005b52:	00001097          	auipc	ra,0x1
    80005b56:	d7c080e7          	jalr	-644(ra) # 800068ce <release>
}
    80005b5a:	60e2                	ld	ra,24(sp)
    80005b5c:	6442                	ld	s0,16(sp)
    80005b5e:	64a2                	ld	s1,8(sp)
    80005b60:	6902                	ld	s2,0(sp)
    80005b62:	6105                	addi	sp,sp,32
    80005b64:	8082                	ret
      panic("virtio_disk_intr status");
    80005b66:	00003517          	auipc	a0,0x3
    80005b6a:	da250513          	addi	a0,a0,-606 # 80008908 <syscalls+0x4a8>
    80005b6e:	00000097          	auipc	ra,0x0
    80005b72:	762080e7          	jalr	1890(ra) # 800062d0 <panic>

0000000080005b76 <swap_page_from_pte>:
/* NTU OS 2024 */
/* Allocate eight consecutive disk blocks. */
/* Save the content of the physical page in the pte */
/* to the disk blocks and save the block-id into the */
/* pte. */
char *swap_page_from_pte(pte_t *pte) {
    80005b76:	7179                	addi	sp,sp,-48
    80005b78:	f406                	sd	ra,40(sp)
    80005b7a:	f022                	sd	s0,32(sp)
    80005b7c:	ec26                	sd	s1,24(sp)
    80005b7e:	e84a                	sd	s2,16(sp)
    80005b80:	e44e                	sd	s3,8(sp)
    80005b82:	1800                	addi	s0,sp,48
    80005b84:	89aa                	mv	s3,a0
  char *pa = (char*) PTE2PA(*pte);
    80005b86:	00053903          	ld	s2,0(a0)
    80005b8a:	00a95913          	srli	s2,s2,0xa
    80005b8e:	0932                	slli	s2,s2,0xc
  uint dp = balloc_page(ROOTDEV);
    80005b90:	4505                	li	a0,1
    80005b92:	ffffe097          	auipc	ra,0xffffe
    80005b96:	ab4080e7          	jalr	-1356(ra) # 80003646 <balloc_page>
    80005b9a:	0005049b          	sext.w	s1,a0

  write_page_to_disk(ROOTDEV, pa, dp); // write this page to disk
    80005b9e:	8626                	mv	a2,s1
    80005ba0:	85ca                	mv	a1,s2
    80005ba2:	4505                	li	a0,1
    80005ba4:	ffffd097          	auipc	ra,0xffffd
    80005ba8:	c64080e7          	jalr	-924(ra) # 80002808 <write_page_to_disk>
  *pte = (BLOCKNO2PTE(dp) | PTE_FLAGS(*pte) | PTE_S) & ~PTE_V;
    80005bac:	0009b783          	ld	a5,0(s3)
    80005bb0:	00a4949b          	slliw	s1,s1,0xa
    80005bb4:	1482                	slli	s1,s1,0x20
    80005bb6:	9081                	srli	s1,s1,0x20
    80005bb8:	1fe7f793          	andi	a5,a5,510
    80005bbc:	8cdd                	or	s1,s1,a5
    80005bbe:	2004e493          	ori	s1,s1,512
    80005bc2:	0099b023          	sd	s1,0(s3)

  return pa;
}
    80005bc6:	854a                	mv	a0,s2
    80005bc8:	70a2                	ld	ra,40(sp)
    80005bca:	7402                	ld	s0,32(sp)
    80005bcc:	64e2                	ld	s1,24(sp)
    80005bce:	6942                	ld	s2,16(sp)
    80005bd0:	69a2                	ld	s3,8(sp)
    80005bd2:	6145                	addi	sp,sp,48
    80005bd4:	8082                	ret

0000000080005bd6 <handle_pgfault>:

/* NTU OS 2024 */
/* Page fault handler */
int handle_pgfault(uint64 va) {
    80005bd6:	7179                	addi	sp,sp,-48
    80005bd8:	f406                	sd	ra,40(sp)
    80005bda:	f022                	sd	s0,32(sp)
    80005bdc:	ec26                	sd	s1,24(sp)
    80005bde:	e84a                	sd	s2,16(sp)
    80005be0:	e44e                	sd	s3,8(sp)
    80005be2:	1800                	addi	s0,sp,48
    80005be4:	84aa                	mv	s1,a0
  /* Find the address that caused the fault */
  /* uint64 va = r_stval(); */

  /* TODO */
  struct proc *p = myproc();
    80005be6:	ffffb097          	auipc	ra,0xffffb
    80005bea:	57a080e7          	jalr	1402(ra) # 80001160 <myproc>
  pagetable_t pagetable = p->pagetable;
    80005bee:	05053983          	ld	s3,80(a0)
  va = PGROUNDDOWN(va); // Align to page boundary
    80005bf2:	797d                	lui	s2,0xfffff
    80005bf4:	0124f933          	and	s2,s1,s2

  // Allocate a new physical page
  char *mem = kalloc();
    80005bf8:	ffffa097          	auipc	ra,0xffffa
    80005bfc:	520080e7          	jalr	1312(ra) # 80000118 <kalloc>
  if(mem == 0) {
    80005c00:	c90d                	beqz	a0,80005c32 <handle_pgfault+0x5c>
    80005c02:	84aa                	mv	s1,a0
      panic("handle_page_fault: kalloc failed");
  }

  // Zero out the new page
  memset(mem, 0, PGSIZE);
    80005c04:	6605                	lui	a2,0x1
    80005c06:	4581                	li	a1,0
    80005c08:	ffffa097          	auipc	ra,0xffffa
    80005c0c:	570080e7          	jalr	1392(ra) # 80000178 <memset>

  // Map the faulting virtual address to the new physical page
  if(mappages(pagetable, va, PGSIZE, (uint64)mem, PTE_U|PTE_R|PTE_W|PTE_X) != 0) {
    80005c10:	4779                	li	a4,30
    80005c12:	86a6                	mv	a3,s1
    80005c14:	6605                	lui	a2,0x1
    80005c16:	85ca                	mv	a1,s2
    80005c18:	854e                	mv	a0,s3
    80005c1a:	ffffb097          	auipc	ra,0xffffb
    80005c1e:	92e080e7          	jalr	-1746(ra) # 80000548 <mappages>
    80005c22:	e105                	bnez	a0,80005c42 <handle_pgfault+0x6c>
      kfree(mem);
      panic("handle_page_fault: mappages failed");
  }
}
    80005c24:	70a2                	ld	ra,40(sp)
    80005c26:	7402                	ld	s0,32(sp)
    80005c28:	64e2                	ld	s1,24(sp)
    80005c2a:	6942                	ld	s2,16(sp)
    80005c2c:	69a2                	ld	s3,8(sp)
    80005c2e:	6145                	addi	sp,sp,48
    80005c30:	8082                	ret
      panic("handle_page_fault: kalloc failed");
    80005c32:	00003517          	auipc	a0,0x3
    80005c36:	cee50513          	addi	a0,a0,-786 # 80008920 <syscalls+0x4c0>
    80005c3a:	00000097          	auipc	ra,0x0
    80005c3e:	696080e7          	jalr	1686(ra) # 800062d0 <panic>
      kfree(mem);
    80005c42:	8526                	mv	a0,s1
    80005c44:	ffffa097          	auipc	ra,0xffffa
    80005c48:	3d8080e7          	jalr	984(ra) # 8000001c <kfree>
      panic("handle_page_fault: mappages failed");
    80005c4c:	00003517          	auipc	a0,0x3
    80005c50:	cfc50513          	addi	a0,a0,-772 # 80008948 <syscalls+0x4e8>
    80005c54:	00000097          	auipc	ra,0x0
    80005c58:	67c080e7          	jalr	1660(ra) # 800062d0 <panic>

0000000080005c5c <sys_vmprint>:

/* NTU OS 2024 */
/* Entry of vmprint() syscall. */
uint64
sys_vmprint(void)
{
    80005c5c:	1141                	addi	sp,sp,-16
    80005c5e:	e406                	sd	ra,8(sp)
    80005c60:	e022                	sd	s0,0(sp)
    80005c62:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80005c64:	ffffb097          	auipc	ra,0xffffb
    80005c68:	4fc080e7          	jalr	1276(ra) # 80001160 <myproc>
  vmprint(p->pagetable);
    80005c6c:	6928                	ld	a0,80(a0)
    80005c6e:	ffffb097          	auipc	ra,0xffffb
    80005c72:	34e080e7          	jalr	846(ra) # 80000fbc <vmprint>
  return 0;
}
    80005c76:	4501                	li	a0,0
    80005c78:	60a2                	ld	ra,8(sp)
    80005c7a:	6402                	ld	s0,0(sp)
    80005c7c:	0141                	addi	sp,sp,16
    80005c7e:	8082                	ret

0000000080005c80 <sys_madvise>:

/* NTU OS 2024 */
/* Entry of madvise() syscall. */
uint64
sys_madvise(void)
{
    80005c80:	1101                	addi	sp,sp,-32
    80005c82:	ec06                	sd	ra,24(sp)
    80005c84:	e822                	sd	s0,16(sp)
    80005c86:	1000                	addi	s0,sp,32

  uint64 addr;
  int length;
  int advise;

  if (argaddr(0, &addr) < 0) return -1;
    80005c88:	fe840593          	addi	a1,s0,-24
    80005c8c:	4501                	li	a0,0
    80005c8e:	ffffc097          	auipc	ra,0xffffc
    80005c92:	5b8080e7          	jalr	1464(ra) # 80002246 <argaddr>
    80005c96:	57fd                	li	a5,-1
    80005c98:	04054163          	bltz	a0,80005cda <sys_madvise+0x5a>
  if (argint(1, &length) < 0) return -1;
    80005c9c:	fe440593          	addi	a1,s0,-28
    80005ca0:	4505                	li	a0,1
    80005ca2:	ffffc097          	auipc	ra,0xffffc
    80005ca6:	582080e7          	jalr	1410(ra) # 80002224 <argint>
    80005caa:	57fd                	li	a5,-1
    80005cac:	02054763          	bltz	a0,80005cda <sys_madvise+0x5a>
  if (argint(2, &advise) < 0) return -1;
    80005cb0:	fe040593          	addi	a1,s0,-32
    80005cb4:	4509                	li	a0,2
    80005cb6:	ffffc097          	auipc	ra,0xffffc
    80005cba:	56e080e7          	jalr	1390(ra) # 80002224 <argint>
    80005cbe:	57fd                	li	a5,-1
    80005cc0:	00054d63          	bltz	a0,80005cda <sys_madvise+0x5a>

  int ret = madvise(addr, length, advise);
    80005cc4:	fe042603          	lw	a2,-32(s0)
    80005cc8:	fe442583          	lw	a1,-28(s0)
    80005ccc:	fe843503          	ld	a0,-24(s0)
    80005cd0:	ffffb097          	auipc	ra,0xffffb
    80005cd4:	ffe080e7          	jalr	-2(ra) # 80000cce <madvise>
  return ret;
    80005cd8:	87aa                	mv	a5,a0
}
    80005cda:	853e                	mv	a0,a5
    80005cdc:	60e2                	ld	ra,24(sp)
    80005cde:	6442                	ld	s0,16(sp)
    80005ce0:	6105                	addi	sp,sp,32
    80005ce2:	8082                	ret

0000000080005ce4 <sys_pgprint>:
#if defined(PG_REPLACEMENT_USE_FIFO) || defined(PG_REPLACEMENT_USE_LRU)
/* NTU OS 2024 */
/* Entry of pgprint() syscall. */
uint64
sys_pgprint(void)
{
    80005ce4:	1141                	addi	sp,sp,-16
    80005ce6:	e406                	sd	ra,8(sp)
    80005ce8:	e022                	sd	s0,0(sp)
    80005cea:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80005cec:	ffffb097          	auipc	ra,0xffffb
    80005cf0:	474080e7          	jalr	1140(ra) # 80001160 <myproc>
  pgprint();
    80005cf4:	ffffb097          	auipc	ra,0xffffb
    80005cf8:	0a2080e7          	jalr	162(ra) # 80000d96 <pgprint>
  return 0;
}
    80005cfc:	4501                	li	a0,0
    80005cfe:	60a2                	ld	ra,8(sp)
    80005d00:	6402                	ld	s0,0(sp)
    80005d02:	0141                	addi	sp,sp,16
    80005d04:	8082                	ret

0000000080005d06 <q_init>:
#include "riscv.h"
#include "spinlock.h"
#include "defs.h"
#include "proc.h"

void q_init(queue_t *q){
    80005d06:	1141                	addi	sp,sp,-16
    80005d08:	e406                	sd	ra,8(sp)
    80005d0a:	e022                	sd	s0,0(sp)
    80005d0c:	0800                	addi	s0,sp,16
	panic("Not implemented yet\n");
    80005d0e:	00003517          	auipc	a0,0x3
    80005d12:	c6250513          	addi	a0,a0,-926 # 80008970 <syscalls+0x510>
    80005d16:	00000097          	auipc	ra,0x0
    80005d1a:	5ba080e7          	jalr	1466(ra) # 800062d0 <panic>

0000000080005d1e <q_push>:
}

int q_push(queue_t *q, uint64 e){
    80005d1e:	1141                	addi	sp,sp,-16
    80005d20:	e406                	sd	ra,8(sp)
    80005d22:	e022                	sd	s0,0(sp)
    80005d24:	0800                	addi	s0,sp,16
	panic("Not implemented yet\n");
    80005d26:	00003517          	auipc	a0,0x3
    80005d2a:	c4a50513          	addi	a0,a0,-950 # 80008970 <syscalls+0x510>
    80005d2e:	00000097          	auipc	ra,0x0
    80005d32:	5a2080e7          	jalr	1442(ra) # 800062d0 <panic>

0000000080005d36 <q_pop_idx>:
}

uint64 q_pop_idx(queue_t *q, int idx){
    80005d36:	1141                	addi	sp,sp,-16
    80005d38:	e406                	sd	ra,8(sp)
    80005d3a:	e022                	sd	s0,0(sp)
    80005d3c:	0800                	addi	s0,sp,16
	panic("Not implemented yet\n");
    80005d3e:	00003517          	auipc	a0,0x3
    80005d42:	c3250513          	addi	a0,a0,-974 # 80008970 <syscalls+0x510>
    80005d46:	00000097          	auipc	ra,0x0
    80005d4a:	58a080e7          	jalr	1418(ra) # 800062d0 <panic>

0000000080005d4e <q_empty>:
}

int q_empty(queue_t *q){
    80005d4e:	1141                	addi	sp,sp,-16
    80005d50:	e406                	sd	ra,8(sp)
    80005d52:	e022                	sd	s0,0(sp)
    80005d54:	0800                	addi	s0,sp,16
	panic("Not implemented yet\n");
    80005d56:	00003517          	auipc	a0,0x3
    80005d5a:	c1a50513          	addi	a0,a0,-998 # 80008970 <syscalls+0x510>
    80005d5e:	00000097          	auipc	ra,0x0
    80005d62:	572080e7          	jalr	1394(ra) # 800062d0 <panic>

0000000080005d66 <q_full>:
}

int q_full(queue_t *q){
    80005d66:	1141                	addi	sp,sp,-16
    80005d68:	e406                	sd	ra,8(sp)
    80005d6a:	e022                	sd	s0,0(sp)
    80005d6c:	0800                	addi	s0,sp,16
	panic("Not implemented yet\n");
    80005d6e:	00003517          	auipc	a0,0x3
    80005d72:	c0250513          	addi	a0,a0,-1022 # 80008970 <syscalls+0x510>
    80005d76:	00000097          	auipc	ra,0x0
    80005d7a:	55a080e7          	jalr	1370(ra) # 800062d0 <panic>

0000000080005d7e <q_clear>:
}

int q_clear(queue_t *q){
    80005d7e:	1141                	addi	sp,sp,-16
    80005d80:	e406                	sd	ra,8(sp)
    80005d82:	e022                	sd	s0,0(sp)
    80005d84:	0800                	addi	s0,sp,16
	panic("Not implemented yet\n");
    80005d86:	00003517          	auipc	a0,0x3
    80005d8a:	bea50513          	addi	a0,a0,-1046 # 80008970 <syscalls+0x510>
    80005d8e:	00000097          	auipc	ra,0x0
    80005d92:	542080e7          	jalr	1346(ra) # 800062d0 <panic>

0000000080005d96 <q_find>:
}

int q_find(queue_t *q, uint64 e){
    80005d96:	1141                	addi	sp,sp,-16
    80005d98:	e406                	sd	ra,8(sp)
    80005d9a:	e022                	sd	s0,0(sp)
    80005d9c:	0800                	addi	s0,sp,16
	panic("Not implemented yet\n");
    80005d9e:	00003517          	auipc	a0,0x3
    80005da2:	bd250513          	addi	a0,a0,-1070 # 80008970 <syscalls+0x510>
    80005da6:	00000097          	auipc	ra,0x0
    80005daa:	52a080e7          	jalr	1322(ra) # 800062d0 <panic>

0000000080005dae <timerinit>:
// which arrive at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    80005dae:	1141                	addi	sp,sp,-16
    80005db0:	e422                	sd	s0,8(sp)
    80005db2:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005db4:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    80005db8:	0007869b          	sext.w	a3,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    80005dbc:	0037979b          	slliw	a5,a5,0x3
    80005dc0:	02004737          	lui	a4,0x2004
    80005dc4:	97ba                	add	a5,a5,a4
    80005dc6:	0200c737          	lui	a4,0x200c
    80005dca:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005dce:	000f4637          	lui	a2,0xf4
    80005dd2:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005dd6:	95b2                	add	a1,a1,a2
    80005dd8:	e38c                	sd	a1,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    80005dda:	00269713          	slli	a4,a3,0x2
    80005dde:	9736                	add	a4,a4,a3
    80005de0:	00371693          	slli	a3,a4,0x3
    80005de4:	00018717          	auipc	a4,0x18
    80005de8:	21c70713          	addi	a4,a4,540 # 8001e000 <timer_scratch>
    80005dec:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    80005dee:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    80005df0:	f310                	sd	a2,32(a4)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    80005df2:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    80005df6:	fffff797          	auipc	a5,0xfffff
    80005dfa:	73a78793          	addi	a5,a5,1850 # 80005530 <timervec>
    80005dfe:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005e02:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80005e06:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005e0a:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    80005e0e:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80005e12:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    80005e16:	30479073          	csrw	mie,a5
}
    80005e1a:	6422                	ld	s0,8(sp)
    80005e1c:	0141                	addi	sp,sp,16
    80005e1e:	8082                	ret

0000000080005e20 <start>:
{
    80005e20:	1141                	addi	sp,sp,-16
    80005e22:	e406                	sd	ra,8(sp)
    80005e24:	e022                	sd	s0,0(sp)
    80005e26:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005e28:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80005e2c:	7779                	lui	a4,0xffffe
    80005e2e:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffd85bf>
    80005e32:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    80005e34:	6705                	lui	a4,0x1
    80005e36:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005e3a:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005e3c:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    80005e40:	ffffa797          	auipc	a5,0xffffa
    80005e44:	4e678793          	addi	a5,a5,1254 # 80000326 <main>
    80005e48:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    80005e4c:	4781                	li	a5,0
    80005e4e:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80005e52:	67c1                	lui	a5,0x10
    80005e54:	17fd                	addi	a5,a5,-1
    80005e56:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80005e5a:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80005e5e:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80005e62:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80005e66:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    80005e6a:	57fd                	li	a5,-1
    80005e6c:	83a9                	srli	a5,a5,0xa
    80005e6e:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80005e72:	47bd                	li	a5,15
    80005e74:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    80005e78:	00000097          	auipc	ra,0x0
    80005e7c:	f36080e7          	jalr	-202(ra) # 80005dae <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005e80:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    80005e84:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    80005e86:	823e                	mv	tp,a5
  asm volatile("mret");
    80005e88:	30200073          	mret
}
    80005e8c:	60a2                	ld	ra,8(sp)
    80005e8e:	6402                	ld	s0,0(sp)
    80005e90:	0141                	addi	sp,sp,16
    80005e92:	8082                	ret

0000000080005e94 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80005e94:	715d                	addi	sp,sp,-80
    80005e96:	e486                	sd	ra,72(sp)
    80005e98:	e0a2                	sd	s0,64(sp)
    80005e9a:	fc26                	sd	s1,56(sp)
    80005e9c:	f84a                	sd	s2,48(sp)
    80005e9e:	f44e                	sd	s3,40(sp)
    80005ea0:	f052                	sd	s4,32(sp)
    80005ea2:	ec56                	sd	s5,24(sp)
    80005ea4:	0880                	addi	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    80005ea6:	04c05663          	blez	a2,80005ef2 <consolewrite+0x5e>
    80005eaa:	8a2a                	mv	s4,a0
    80005eac:	84ae                	mv	s1,a1
    80005eae:	89b2                	mv	s3,a2
    80005eb0:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80005eb2:	5afd                	li	s5,-1
    80005eb4:	4685                	li	a3,1
    80005eb6:	8626                	mv	a2,s1
    80005eb8:	85d2                	mv	a1,s4
    80005eba:	fbf40513          	addi	a0,s0,-65
    80005ebe:	ffffc097          	auipc	ra,0xffffc
    80005ec2:	d58080e7          	jalr	-680(ra) # 80001c16 <either_copyin>
    80005ec6:	01550c63          	beq	a0,s5,80005ede <consolewrite+0x4a>
      break;
    uartputc(c);
    80005eca:	fbf44503          	lbu	a0,-65(s0)
    80005ece:	00000097          	auipc	ra,0x0
    80005ed2:	78e080e7          	jalr	1934(ra) # 8000665c <uartputc>
  for(i = 0; i < n; i++){
    80005ed6:	2905                	addiw	s2,s2,1
    80005ed8:	0485                	addi	s1,s1,1
    80005eda:	fd299de3          	bne	s3,s2,80005eb4 <consolewrite+0x20>
  }

  return i;
}
    80005ede:	854a                	mv	a0,s2
    80005ee0:	60a6                	ld	ra,72(sp)
    80005ee2:	6406                	ld	s0,64(sp)
    80005ee4:	74e2                	ld	s1,56(sp)
    80005ee6:	7942                	ld	s2,48(sp)
    80005ee8:	79a2                	ld	s3,40(sp)
    80005eea:	7a02                	ld	s4,32(sp)
    80005eec:	6ae2                	ld	s5,24(sp)
    80005eee:	6161                	addi	sp,sp,80
    80005ef0:	8082                	ret
  for(i = 0; i < n; i++){
    80005ef2:	4901                	li	s2,0
    80005ef4:	b7ed                	j	80005ede <consolewrite+0x4a>

0000000080005ef6 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80005ef6:	7119                	addi	sp,sp,-128
    80005ef8:	fc86                	sd	ra,120(sp)
    80005efa:	f8a2                	sd	s0,112(sp)
    80005efc:	f4a6                	sd	s1,104(sp)
    80005efe:	f0ca                	sd	s2,96(sp)
    80005f00:	ecce                	sd	s3,88(sp)
    80005f02:	e8d2                	sd	s4,80(sp)
    80005f04:	e4d6                	sd	s5,72(sp)
    80005f06:	e0da                	sd	s6,64(sp)
    80005f08:	fc5e                	sd	s7,56(sp)
    80005f0a:	f862                	sd	s8,48(sp)
    80005f0c:	f466                	sd	s9,40(sp)
    80005f0e:	f06a                	sd	s10,32(sp)
    80005f10:	ec6e                	sd	s11,24(sp)
    80005f12:	0100                	addi	s0,sp,128
    80005f14:	8b2a                	mv	s6,a0
    80005f16:	8aae                	mv	s5,a1
    80005f18:	8a32                	mv	s4,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80005f1a:	00060b9b          	sext.w	s7,a2
  acquire(&cons.lock);
    80005f1e:	00020517          	auipc	a0,0x20
    80005f22:	22250513          	addi	a0,a0,546 # 80026140 <cons>
    80005f26:	00001097          	auipc	ra,0x1
    80005f2a:	8f4080e7          	jalr	-1804(ra) # 8000681a <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80005f2e:	00020497          	auipc	s1,0x20
    80005f32:	21248493          	addi	s1,s1,530 # 80026140 <cons>
      if(myproc()->killed){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80005f36:	89a6                	mv	s3,s1
    80005f38:	00020917          	auipc	s2,0x20
    80005f3c:	2a090913          	addi	s2,s2,672 # 800261d8 <cons+0x98>
    }

    c = cons.buf[cons.r++ % INPUT_BUF];

    if(c == C('D')){  // end-of-file
    80005f40:	4c91                	li	s9,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005f42:	5d7d                	li	s10,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    80005f44:	4da9                	li	s11,10
  while(n > 0){
    80005f46:	07405863          	blez	s4,80005fb6 <consoleread+0xc0>
    while(cons.r == cons.w){
    80005f4a:	0984a783          	lw	a5,152(s1)
    80005f4e:	09c4a703          	lw	a4,156(s1)
    80005f52:	02f71463          	bne	a4,a5,80005f7a <consoleread+0x84>
      if(myproc()->killed){
    80005f56:	ffffb097          	auipc	ra,0xffffb
    80005f5a:	20a080e7          	jalr	522(ra) # 80001160 <myproc>
    80005f5e:	551c                	lw	a5,40(a0)
    80005f60:	e7b5                	bnez	a5,80005fcc <consoleread+0xd6>
      sleep(&cons.r, &cons.lock);
    80005f62:	85ce                	mv	a1,s3
    80005f64:	854a                	mv	a0,s2
    80005f66:	ffffc097          	auipc	ra,0xffffc
    80005f6a:	8b6080e7          	jalr	-1866(ra) # 8000181c <sleep>
    while(cons.r == cons.w){
    80005f6e:	0984a783          	lw	a5,152(s1)
    80005f72:	09c4a703          	lw	a4,156(s1)
    80005f76:	fef700e3          	beq	a4,a5,80005f56 <consoleread+0x60>
    c = cons.buf[cons.r++ % INPUT_BUF];
    80005f7a:	0017871b          	addiw	a4,a5,1
    80005f7e:	08e4ac23          	sw	a4,152(s1)
    80005f82:	07f7f713          	andi	a4,a5,127
    80005f86:	9726                	add	a4,a4,s1
    80005f88:	01874703          	lbu	a4,24(a4)
    80005f8c:	00070c1b          	sext.w	s8,a4
    if(c == C('D')){  // end-of-file
    80005f90:	079c0663          	beq	s8,s9,80005ffc <consoleread+0x106>
    cbuf = c;
    80005f94:	f8e407a3          	sb	a4,-113(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005f98:	4685                	li	a3,1
    80005f9a:	f8f40613          	addi	a2,s0,-113
    80005f9e:	85d6                	mv	a1,s5
    80005fa0:	855a                	mv	a0,s6
    80005fa2:	ffffc097          	auipc	ra,0xffffc
    80005fa6:	c1e080e7          	jalr	-994(ra) # 80001bc0 <either_copyout>
    80005faa:	01a50663          	beq	a0,s10,80005fb6 <consoleread+0xc0>
    dst++;
    80005fae:	0a85                	addi	s5,s5,1
    --n;
    80005fb0:	3a7d                	addiw	s4,s4,-1
    if(c == '\n'){
    80005fb2:	f9bc1ae3          	bne	s8,s11,80005f46 <consoleread+0x50>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80005fb6:	00020517          	auipc	a0,0x20
    80005fba:	18a50513          	addi	a0,a0,394 # 80026140 <cons>
    80005fbe:	00001097          	auipc	ra,0x1
    80005fc2:	910080e7          	jalr	-1776(ra) # 800068ce <release>

  return target - n;
    80005fc6:	414b853b          	subw	a0,s7,s4
    80005fca:	a811                	j	80005fde <consoleread+0xe8>
        release(&cons.lock);
    80005fcc:	00020517          	auipc	a0,0x20
    80005fd0:	17450513          	addi	a0,a0,372 # 80026140 <cons>
    80005fd4:	00001097          	auipc	ra,0x1
    80005fd8:	8fa080e7          	jalr	-1798(ra) # 800068ce <release>
        return -1;
    80005fdc:	557d                	li	a0,-1
}
    80005fde:	70e6                	ld	ra,120(sp)
    80005fe0:	7446                	ld	s0,112(sp)
    80005fe2:	74a6                	ld	s1,104(sp)
    80005fe4:	7906                	ld	s2,96(sp)
    80005fe6:	69e6                	ld	s3,88(sp)
    80005fe8:	6a46                	ld	s4,80(sp)
    80005fea:	6aa6                	ld	s5,72(sp)
    80005fec:	6b06                	ld	s6,64(sp)
    80005fee:	7be2                	ld	s7,56(sp)
    80005ff0:	7c42                	ld	s8,48(sp)
    80005ff2:	7ca2                	ld	s9,40(sp)
    80005ff4:	7d02                	ld	s10,32(sp)
    80005ff6:	6de2                	ld	s11,24(sp)
    80005ff8:	6109                	addi	sp,sp,128
    80005ffa:	8082                	ret
      if(n < target){
    80005ffc:	000a071b          	sext.w	a4,s4
    80006000:	fb777be3          	bgeu	a4,s7,80005fb6 <consoleread+0xc0>
        cons.r--;
    80006004:	00020717          	auipc	a4,0x20
    80006008:	1cf72a23          	sw	a5,468(a4) # 800261d8 <cons+0x98>
    8000600c:	b76d                	j	80005fb6 <consoleread+0xc0>

000000008000600e <consputc>:
{
    8000600e:	1141                	addi	sp,sp,-16
    80006010:	e406                	sd	ra,8(sp)
    80006012:	e022                	sd	s0,0(sp)
    80006014:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80006016:	10000793          	li	a5,256
    8000601a:	00f50a63          	beq	a0,a5,8000602e <consputc+0x20>
    uartputc_sync(c);
    8000601e:	00000097          	auipc	ra,0x0
    80006022:	564080e7          	jalr	1380(ra) # 80006582 <uartputc_sync>
}
    80006026:	60a2                	ld	ra,8(sp)
    80006028:	6402                	ld	s0,0(sp)
    8000602a:	0141                	addi	sp,sp,16
    8000602c:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    8000602e:	4521                	li	a0,8
    80006030:	00000097          	auipc	ra,0x0
    80006034:	552080e7          	jalr	1362(ra) # 80006582 <uartputc_sync>
    80006038:	02000513          	li	a0,32
    8000603c:	00000097          	auipc	ra,0x0
    80006040:	546080e7          	jalr	1350(ra) # 80006582 <uartputc_sync>
    80006044:	4521                	li	a0,8
    80006046:	00000097          	auipc	ra,0x0
    8000604a:	53c080e7          	jalr	1340(ra) # 80006582 <uartputc_sync>
    8000604e:	bfe1                	j	80006026 <consputc+0x18>

0000000080006050 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80006050:	1101                	addi	sp,sp,-32
    80006052:	ec06                	sd	ra,24(sp)
    80006054:	e822                	sd	s0,16(sp)
    80006056:	e426                	sd	s1,8(sp)
    80006058:	e04a                	sd	s2,0(sp)
    8000605a:	1000                	addi	s0,sp,32
    8000605c:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    8000605e:	00020517          	auipc	a0,0x20
    80006062:	0e250513          	addi	a0,a0,226 # 80026140 <cons>
    80006066:	00000097          	auipc	ra,0x0
    8000606a:	7b4080e7          	jalr	1972(ra) # 8000681a <acquire>

  switch(c){
    8000606e:	47d5                	li	a5,21
    80006070:	0af48663          	beq	s1,a5,8000611c <consoleintr+0xcc>
    80006074:	0297ca63          	blt	a5,s1,800060a8 <consoleintr+0x58>
    80006078:	47a1                	li	a5,8
    8000607a:	0ef48763          	beq	s1,a5,80006168 <consoleintr+0x118>
    8000607e:	47c1                	li	a5,16
    80006080:	10f49a63          	bne	s1,a5,80006194 <consoleintr+0x144>
  case C('P'):  // Print process list.
    procdump();
    80006084:	ffffc097          	auipc	ra,0xffffc
    80006088:	be8080e7          	jalr	-1048(ra) # 80001c6c <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    8000608c:	00020517          	auipc	a0,0x20
    80006090:	0b450513          	addi	a0,a0,180 # 80026140 <cons>
    80006094:	00001097          	auipc	ra,0x1
    80006098:	83a080e7          	jalr	-1990(ra) # 800068ce <release>
}
    8000609c:	60e2                	ld	ra,24(sp)
    8000609e:	6442                	ld	s0,16(sp)
    800060a0:	64a2                	ld	s1,8(sp)
    800060a2:	6902                	ld	s2,0(sp)
    800060a4:	6105                	addi	sp,sp,32
    800060a6:	8082                	ret
  switch(c){
    800060a8:	07f00793          	li	a5,127
    800060ac:	0af48e63          	beq	s1,a5,80006168 <consoleintr+0x118>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    800060b0:	00020717          	auipc	a4,0x20
    800060b4:	09070713          	addi	a4,a4,144 # 80026140 <cons>
    800060b8:	0a072783          	lw	a5,160(a4)
    800060bc:	09872703          	lw	a4,152(a4)
    800060c0:	9f99                	subw	a5,a5,a4
    800060c2:	07f00713          	li	a4,127
    800060c6:	fcf763e3          	bltu	a4,a5,8000608c <consoleintr+0x3c>
      c = (c == '\r') ? '\n' : c;
    800060ca:	47b5                	li	a5,13
    800060cc:	0cf48763          	beq	s1,a5,8000619a <consoleintr+0x14a>
      consputc(c);
    800060d0:	8526                	mv	a0,s1
    800060d2:	00000097          	auipc	ra,0x0
    800060d6:	f3c080e7          	jalr	-196(ra) # 8000600e <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    800060da:	00020797          	auipc	a5,0x20
    800060de:	06678793          	addi	a5,a5,102 # 80026140 <cons>
    800060e2:	0a07a703          	lw	a4,160(a5)
    800060e6:	0017069b          	addiw	a3,a4,1
    800060ea:	0006861b          	sext.w	a2,a3
    800060ee:	0ad7a023          	sw	a3,160(a5)
    800060f2:	07f77713          	andi	a4,a4,127
    800060f6:	97ba                	add	a5,a5,a4
    800060f8:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    800060fc:	47a9                	li	a5,10
    800060fe:	0cf48563          	beq	s1,a5,800061c8 <consoleintr+0x178>
    80006102:	4791                	li	a5,4
    80006104:	0cf48263          	beq	s1,a5,800061c8 <consoleintr+0x178>
    80006108:	00020797          	auipc	a5,0x20
    8000610c:	0d07a783          	lw	a5,208(a5) # 800261d8 <cons+0x98>
    80006110:	0807879b          	addiw	a5,a5,128
    80006114:	f6f61ce3          	bne	a2,a5,8000608c <consoleintr+0x3c>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80006118:	863e                	mv	a2,a5
    8000611a:	a07d                	j	800061c8 <consoleintr+0x178>
    while(cons.e != cons.w &&
    8000611c:	00020717          	auipc	a4,0x20
    80006120:	02470713          	addi	a4,a4,36 # 80026140 <cons>
    80006124:	0a072783          	lw	a5,160(a4)
    80006128:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    8000612c:	00020497          	auipc	s1,0x20
    80006130:	01448493          	addi	s1,s1,20 # 80026140 <cons>
    while(cons.e != cons.w &&
    80006134:	4929                	li	s2,10
    80006136:	f4f70be3          	beq	a4,a5,8000608c <consoleintr+0x3c>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    8000613a:	37fd                	addiw	a5,a5,-1
    8000613c:	07f7f713          	andi	a4,a5,127
    80006140:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    80006142:	01874703          	lbu	a4,24(a4)
    80006146:	f52703e3          	beq	a4,s2,8000608c <consoleintr+0x3c>
      cons.e--;
    8000614a:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    8000614e:	10000513          	li	a0,256
    80006152:	00000097          	auipc	ra,0x0
    80006156:	ebc080e7          	jalr	-324(ra) # 8000600e <consputc>
    while(cons.e != cons.w &&
    8000615a:	0a04a783          	lw	a5,160(s1)
    8000615e:	09c4a703          	lw	a4,156(s1)
    80006162:	fcf71ce3          	bne	a4,a5,8000613a <consoleintr+0xea>
    80006166:	b71d                	j	8000608c <consoleintr+0x3c>
    if(cons.e != cons.w){
    80006168:	00020717          	auipc	a4,0x20
    8000616c:	fd870713          	addi	a4,a4,-40 # 80026140 <cons>
    80006170:	0a072783          	lw	a5,160(a4)
    80006174:	09c72703          	lw	a4,156(a4)
    80006178:	f0f70ae3          	beq	a4,a5,8000608c <consoleintr+0x3c>
      cons.e--;
    8000617c:	37fd                	addiw	a5,a5,-1
    8000617e:	00020717          	auipc	a4,0x20
    80006182:	06f72123          	sw	a5,98(a4) # 800261e0 <cons+0xa0>
      consputc(BACKSPACE);
    80006186:	10000513          	li	a0,256
    8000618a:	00000097          	auipc	ra,0x0
    8000618e:	e84080e7          	jalr	-380(ra) # 8000600e <consputc>
    80006192:	bded                	j	8000608c <consoleintr+0x3c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80006194:	ee048ce3          	beqz	s1,8000608c <consoleintr+0x3c>
    80006198:	bf21                	j	800060b0 <consoleintr+0x60>
      consputc(c);
    8000619a:	4529                	li	a0,10
    8000619c:	00000097          	auipc	ra,0x0
    800061a0:	e72080e7          	jalr	-398(ra) # 8000600e <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    800061a4:	00020797          	auipc	a5,0x20
    800061a8:	f9c78793          	addi	a5,a5,-100 # 80026140 <cons>
    800061ac:	0a07a703          	lw	a4,160(a5)
    800061b0:	0017069b          	addiw	a3,a4,1
    800061b4:	0006861b          	sext.w	a2,a3
    800061b8:	0ad7a023          	sw	a3,160(a5)
    800061bc:	07f77713          	andi	a4,a4,127
    800061c0:	97ba                	add	a5,a5,a4
    800061c2:	4729                	li	a4,10
    800061c4:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    800061c8:	00020797          	auipc	a5,0x20
    800061cc:	00c7aa23          	sw	a2,20(a5) # 800261dc <cons+0x9c>
        wakeup(&cons.r);
    800061d0:	00020517          	auipc	a0,0x20
    800061d4:	00850513          	addi	a0,a0,8 # 800261d8 <cons+0x98>
    800061d8:	ffffb097          	auipc	ra,0xffffb
    800061dc:	7d0080e7          	jalr	2000(ra) # 800019a8 <wakeup>
    800061e0:	b575                	j	8000608c <consoleintr+0x3c>

00000000800061e2 <consoleinit>:

void
consoleinit(void)
{
    800061e2:	1141                	addi	sp,sp,-16
    800061e4:	e406                	sd	ra,8(sp)
    800061e6:	e022                	sd	s0,0(sp)
    800061e8:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    800061ea:	00002597          	auipc	a1,0x2
    800061ee:	79e58593          	addi	a1,a1,1950 # 80008988 <syscalls+0x528>
    800061f2:	00020517          	auipc	a0,0x20
    800061f6:	f4e50513          	addi	a0,a0,-178 # 80026140 <cons>
    800061fa:	00000097          	auipc	ra,0x0
    800061fe:	590080e7          	jalr	1424(ra) # 8000678a <initlock>

  uartinit();
    80006202:	00000097          	auipc	ra,0x0
    80006206:	330080e7          	jalr	816(ra) # 80006532 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    8000620a:	00013797          	auipc	a5,0x13
    8000620e:	ebe78793          	addi	a5,a5,-322 # 800190c8 <devsw>
    80006212:	00000717          	auipc	a4,0x0
    80006216:	ce470713          	addi	a4,a4,-796 # 80005ef6 <consoleread>
    8000621a:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    8000621c:	00000717          	auipc	a4,0x0
    80006220:	c7870713          	addi	a4,a4,-904 # 80005e94 <consolewrite>
    80006224:	ef98                	sd	a4,24(a5)
}
    80006226:	60a2                	ld	ra,8(sp)
    80006228:	6402                	ld	s0,0(sp)
    8000622a:	0141                	addi	sp,sp,16
    8000622c:	8082                	ret

000000008000622e <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    8000622e:	7179                	addi	sp,sp,-48
    80006230:	f406                	sd	ra,40(sp)
    80006232:	f022                	sd	s0,32(sp)
    80006234:	ec26                	sd	s1,24(sp)
    80006236:	e84a                	sd	s2,16(sp)
    80006238:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    8000623a:	c219                	beqz	a2,80006240 <printint+0x12>
    8000623c:	08054663          	bltz	a0,800062c8 <printint+0x9a>
    x = -xx;
  else
    x = xx;
    80006240:	2501                	sext.w	a0,a0
    80006242:	4881                	li	a7,0
    80006244:	fd040693          	addi	a3,s0,-48

  i = 0;
    80006248:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    8000624a:	2581                	sext.w	a1,a1
    8000624c:	00002617          	auipc	a2,0x2
    80006250:	76c60613          	addi	a2,a2,1900 # 800089b8 <digits>
    80006254:	883a                	mv	a6,a4
    80006256:	2705                	addiw	a4,a4,1
    80006258:	02b577bb          	remuw	a5,a0,a1
    8000625c:	1782                	slli	a5,a5,0x20
    8000625e:	9381                	srli	a5,a5,0x20
    80006260:	97b2                	add	a5,a5,a2
    80006262:	0007c783          	lbu	a5,0(a5)
    80006266:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    8000626a:	0005079b          	sext.w	a5,a0
    8000626e:	02b5553b          	divuw	a0,a0,a1
    80006272:	0685                	addi	a3,a3,1
    80006274:	feb7f0e3          	bgeu	a5,a1,80006254 <printint+0x26>

  if(sign)
    80006278:	00088b63          	beqz	a7,8000628e <printint+0x60>
    buf[i++] = '-';
    8000627c:	fe040793          	addi	a5,s0,-32
    80006280:	973e                	add	a4,a4,a5
    80006282:	02d00793          	li	a5,45
    80006286:	fef70823          	sb	a5,-16(a4)
    8000628a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    8000628e:	02e05763          	blez	a4,800062bc <printint+0x8e>
    80006292:	fd040793          	addi	a5,s0,-48
    80006296:	00e784b3          	add	s1,a5,a4
    8000629a:	fff78913          	addi	s2,a5,-1
    8000629e:	993a                	add	s2,s2,a4
    800062a0:	377d                	addiw	a4,a4,-1
    800062a2:	1702                	slli	a4,a4,0x20
    800062a4:	9301                	srli	a4,a4,0x20
    800062a6:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    800062aa:	fff4c503          	lbu	a0,-1(s1)
    800062ae:	00000097          	auipc	ra,0x0
    800062b2:	d60080e7          	jalr	-672(ra) # 8000600e <consputc>
  while(--i >= 0)
    800062b6:	14fd                	addi	s1,s1,-1
    800062b8:	ff2499e3          	bne	s1,s2,800062aa <printint+0x7c>
}
    800062bc:	70a2                	ld	ra,40(sp)
    800062be:	7402                	ld	s0,32(sp)
    800062c0:	64e2                	ld	s1,24(sp)
    800062c2:	6942                	ld	s2,16(sp)
    800062c4:	6145                	addi	sp,sp,48
    800062c6:	8082                	ret
    x = -xx;
    800062c8:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    800062cc:	4885                	li	a7,1
    x = -xx;
    800062ce:	bf9d                	j	80006244 <printint+0x16>

00000000800062d0 <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    800062d0:	1101                	addi	sp,sp,-32
    800062d2:	ec06                	sd	ra,24(sp)
    800062d4:	e822                	sd	s0,16(sp)
    800062d6:	e426                	sd	s1,8(sp)
    800062d8:	1000                	addi	s0,sp,32
    800062da:	84aa                	mv	s1,a0
  pr.locking = 0;
    800062dc:	00020797          	auipc	a5,0x20
    800062e0:	f207a223          	sw	zero,-220(a5) # 80026200 <pr+0x18>
  printf("panic: ");
    800062e4:	00002517          	auipc	a0,0x2
    800062e8:	6ac50513          	addi	a0,a0,1708 # 80008990 <syscalls+0x530>
    800062ec:	00000097          	auipc	ra,0x0
    800062f0:	02e080e7          	jalr	46(ra) # 8000631a <printf>
  printf(s);
    800062f4:	8526                	mv	a0,s1
    800062f6:	00000097          	auipc	ra,0x0
    800062fa:	024080e7          	jalr	36(ra) # 8000631a <printf>
  printf("\n");
    800062fe:	00002517          	auipc	a0,0x2
    80006302:	d4a50513          	addi	a0,a0,-694 # 80008048 <etext+0x48>
    80006306:	00000097          	auipc	ra,0x0
    8000630a:	014080e7          	jalr	20(ra) # 8000631a <printf>
  panicked = 1; // freeze uart output from other CPUs
    8000630e:	4785                	li	a5,1
    80006310:	00003717          	auipc	a4,0x3
    80006314:	d0f72623          	sw	a5,-756(a4) # 8000901c <panicked>
  for(;;)
    80006318:	a001                	j	80006318 <panic+0x48>

000000008000631a <printf>:
{
    8000631a:	7131                	addi	sp,sp,-192
    8000631c:	fc86                	sd	ra,120(sp)
    8000631e:	f8a2                	sd	s0,112(sp)
    80006320:	f4a6                	sd	s1,104(sp)
    80006322:	f0ca                	sd	s2,96(sp)
    80006324:	ecce                	sd	s3,88(sp)
    80006326:	e8d2                	sd	s4,80(sp)
    80006328:	e4d6                	sd	s5,72(sp)
    8000632a:	e0da                	sd	s6,64(sp)
    8000632c:	fc5e                	sd	s7,56(sp)
    8000632e:	f862                	sd	s8,48(sp)
    80006330:	f466                	sd	s9,40(sp)
    80006332:	f06a                	sd	s10,32(sp)
    80006334:	ec6e                	sd	s11,24(sp)
    80006336:	0100                	addi	s0,sp,128
    80006338:	8a2a                	mv	s4,a0
    8000633a:	e40c                	sd	a1,8(s0)
    8000633c:	e810                	sd	a2,16(s0)
    8000633e:	ec14                	sd	a3,24(s0)
    80006340:	f018                	sd	a4,32(s0)
    80006342:	f41c                	sd	a5,40(s0)
    80006344:	03043823          	sd	a6,48(s0)
    80006348:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    8000634c:	00020d97          	auipc	s11,0x20
    80006350:	eb4dad83          	lw	s11,-332(s11) # 80026200 <pr+0x18>
  if(locking)
    80006354:	020d9b63          	bnez	s11,8000638a <printf+0x70>
  if (fmt == 0)
    80006358:	040a0263          	beqz	s4,8000639c <printf+0x82>
  va_start(ap, fmt);
    8000635c:	00840793          	addi	a5,s0,8
    80006360:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80006364:	000a4503          	lbu	a0,0(s4)
    80006368:	16050263          	beqz	a0,800064cc <printf+0x1b2>
    8000636c:	4481                	li	s1,0
    if(c != '%'){
    8000636e:	02500a93          	li	s5,37
    switch(c){
    80006372:	07000b13          	li	s6,112
  consputc('x');
    80006376:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80006378:	00002b97          	auipc	s7,0x2
    8000637c:	640b8b93          	addi	s7,s7,1600 # 800089b8 <digits>
    switch(c){
    80006380:	07300c93          	li	s9,115
    80006384:	06400c13          	li	s8,100
    80006388:	a82d                	j	800063c2 <printf+0xa8>
    acquire(&pr.lock);
    8000638a:	00020517          	auipc	a0,0x20
    8000638e:	e5e50513          	addi	a0,a0,-418 # 800261e8 <pr>
    80006392:	00000097          	auipc	ra,0x0
    80006396:	488080e7          	jalr	1160(ra) # 8000681a <acquire>
    8000639a:	bf7d                	j	80006358 <printf+0x3e>
    panic("null fmt");
    8000639c:	00002517          	auipc	a0,0x2
    800063a0:	60450513          	addi	a0,a0,1540 # 800089a0 <syscalls+0x540>
    800063a4:	00000097          	auipc	ra,0x0
    800063a8:	f2c080e7          	jalr	-212(ra) # 800062d0 <panic>
      consputc(c);
    800063ac:	00000097          	auipc	ra,0x0
    800063b0:	c62080e7          	jalr	-926(ra) # 8000600e <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    800063b4:	2485                	addiw	s1,s1,1
    800063b6:	009a07b3          	add	a5,s4,s1
    800063ba:	0007c503          	lbu	a0,0(a5)
    800063be:	10050763          	beqz	a0,800064cc <printf+0x1b2>
    if(c != '%'){
    800063c2:	ff5515e3          	bne	a0,s5,800063ac <printf+0x92>
    c = fmt[++i] & 0xff;
    800063c6:	2485                	addiw	s1,s1,1
    800063c8:	009a07b3          	add	a5,s4,s1
    800063cc:	0007c783          	lbu	a5,0(a5)
    800063d0:	0007891b          	sext.w	s2,a5
    if(c == 0)
    800063d4:	cfe5                	beqz	a5,800064cc <printf+0x1b2>
    switch(c){
    800063d6:	05678a63          	beq	a5,s6,8000642a <printf+0x110>
    800063da:	02fb7663          	bgeu	s6,a5,80006406 <printf+0xec>
    800063de:	09978963          	beq	a5,s9,80006470 <printf+0x156>
    800063e2:	07800713          	li	a4,120
    800063e6:	0ce79863          	bne	a5,a4,800064b6 <printf+0x19c>
      printint(va_arg(ap, int), 16, 1);
    800063ea:	f8843783          	ld	a5,-120(s0)
    800063ee:	00878713          	addi	a4,a5,8
    800063f2:	f8e43423          	sd	a4,-120(s0)
    800063f6:	4605                	li	a2,1
    800063f8:	85ea                	mv	a1,s10
    800063fa:	4388                	lw	a0,0(a5)
    800063fc:	00000097          	auipc	ra,0x0
    80006400:	e32080e7          	jalr	-462(ra) # 8000622e <printint>
      break;
    80006404:	bf45                	j	800063b4 <printf+0x9a>
    switch(c){
    80006406:	0b578263          	beq	a5,s5,800064aa <printf+0x190>
    8000640a:	0b879663          	bne	a5,s8,800064b6 <printf+0x19c>
      printint(va_arg(ap, int), 10, 1);
    8000640e:	f8843783          	ld	a5,-120(s0)
    80006412:	00878713          	addi	a4,a5,8
    80006416:	f8e43423          	sd	a4,-120(s0)
    8000641a:	4605                	li	a2,1
    8000641c:	45a9                	li	a1,10
    8000641e:	4388                	lw	a0,0(a5)
    80006420:	00000097          	auipc	ra,0x0
    80006424:	e0e080e7          	jalr	-498(ra) # 8000622e <printint>
      break;
    80006428:	b771                	j	800063b4 <printf+0x9a>
      printptr(va_arg(ap, uint64));
    8000642a:	f8843783          	ld	a5,-120(s0)
    8000642e:	00878713          	addi	a4,a5,8
    80006432:	f8e43423          	sd	a4,-120(s0)
    80006436:	0007b983          	ld	s3,0(a5)
  consputc('0');
    8000643a:	03000513          	li	a0,48
    8000643e:	00000097          	auipc	ra,0x0
    80006442:	bd0080e7          	jalr	-1072(ra) # 8000600e <consputc>
  consputc('x');
    80006446:	07800513          	li	a0,120
    8000644a:	00000097          	auipc	ra,0x0
    8000644e:	bc4080e7          	jalr	-1084(ra) # 8000600e <consputc>
    80006452:	896a                	mv	s2,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80006454:	03c9d793          	srli	a5,s3,0x3c
    80006458:	97de                	add	a5,a5,s7
    8000645a:	0007c503          	lbu	a0,0(a5)
    8000645e:	00000097          	auipc	ra,0x0
    80006462:	bb0080e7          	jalr	-1104(ra) # 8000600e <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80006466:	0992                	slli	s3,s3,0x4
    80006468:	397d                	addiw	s2,s2,-1
    8000646a:	fe0915e3          	bnez	s2,80006454 <printf+0x13a>
    8000646e:	b799                	j	800063b4 <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    80006470:	f8843783          	ld	a5,-120(s0)
    80006474:	00878713          	addi	a4,a5,8
    80006478:	f8e43423          	sd	a4,-120(s0)
    8000647c:	0007b903          	ld	s2,0(a5)
    80006480:	00090e63          	beqz	s2,8000649c <printf+0x182>
      for(; *s; s++)
    80006484:	00094503          	lbu	a0,0(s2)
    80006488:	d515                	beqz	a0,800063b4 <printf+0x9a>
        consputc(*s);
    8000648a:	00000097          	auipc	ra,0x0
    8000648e:	b84080e7          	jalr	-1148(ra) # 8000600e <consputc>
      for(; *s; s++)
    80006492:	0905                	addi	s2,s2,1
    80006494:	00094503          	lbu	a0,0(s2)
    80006498:	f96d                	bnez	a0,8000648a <printf+0x170>
    8000649a:	bf29                	j	800063b4 <printf+0x9a>
        s = "(null)";
    8000649c:	00002917          	auipc	s2,0x2
    800064a0:	4fc90913          	addi	s2,s2,1276 # 80008998 <syscalls+0x538>
      for(; *s; s++)
    800064a4:	02800513          	li	a0,40
    800064a8:	b7cd                	j	8000648a <printf+0x170>
      consputc('%');
    800064aa:	8556                	mv	a0,s5
    800064ac:	00000097          	auipc	ra,0x0
    800064b0:	b62080e7          	jalr	-1182(ra) # 8000600e <consputc>
      break;
    800064b4:	b701                	j	800063b4 <printf+0x9a>
      consputc('%');
    800064b6:	8556                	mv	a0,s5
    800064b8:	00000097          	auipc	ra,0x0
    800064bc:	b56080e7          	jalr	-1194(ra) # 8000600e <consputc>
      consputc(c);
    800064c0:	854a                	mv	a0,s2
    800064c2:	00000097          	auipc	ra,0x0
    800064c6:	b4c080e7          	jalr	-1204(ra) # 8000600e <consputc>
      break;
    800064ca:	b5ed                	j	800063b4 <printf+0x9a>
  if(locking)
    800064cc:	020d9163          	bnez	s11,800064ee <printf+0x1d4>
}
    800064d0:	70e6                	ld	ra,120(sp)
    800064d2:	7446                	ld	s0,112(sp)
    800064d4:	74a6                	ld	s1,104(sp)
    800064d6:	7906                	ld	s2,96(sp)
    800064d8:	69e6                	ld	s3,88(sp)
    800064da:	6a46                	ld	s4,80(sp)
    800064dc:	6aa6                	ld	s5,72(sp)
    800064de:	6b06                	ld	s6,64(sp)
    800064e0:	7be2                	ld	s7,56(sp)
    800064e2:	7c42                	ld	s8,48(sp)
    800064e4:	7ca2                	ld	s9,40(sp)
    800064e6:	7d02                	ld	s10,32(sp)
    800064e8:	6de2                	ld	s11,24(sp)
    800064ea:	6129                	addi	sp,sp,192
    800064ec:	8082                	ret
    release(&pr.lock);
    800064ee:	00020517          	auipc	a0,0x20
    800064f2:	cfa50513          	addi	a0,a0,-774 # 800261e8 <pr>
    800064f6:	00000097          	auipc	ra,0x0
    800064fa:	3d8080e7          	jalr	984(ra) # 800068ce <release>
}
    800064fe:	bfc9                	j	800064d0 <printf+0x1b6>

0000000080006500 <printfinit>:
    ;
}

void
printfinit(void)
{
    80006500:	1101                	addi	sp,sp,-32
    80006502:	ec06                	sd	ra,24(sp)
    80006504:	e822                	sd	s0,16(sp)
    80006506:	e426                	sd	s1,8(sp)
    80006508:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    8000650a:	00020497          	auipc	s1,0x20
    8000650e:	cde48493          	addi	s1,s1,-802 # 800261e8 <pr>
    80006512:	00002597          	auipc	a1,0x2
    80006516:	49e58593          	addi	a1,a1,1182 # 800089b0 <syscalls+0x550>
    8000651a:	8526                	mv	a0,s1
    8000651c:	00000097          	auipc	ra,0x0
    80006520:	26e080e7          	jalr	622(ra) # 8000678a <initlock>
  pr.locking = 1;
    80006524:	4785                	li	a5,1
    80006526:	cc9c                	sw	a5,24(s1)
}
    80006528:	60e2                	ld	ra,24(sp)
    8000652a:	6442                	ld	s0,16(sp)
    8000652c:	64a2                	ld	s1,8(sp)
    8000652e:	6105                	addi	sp,sp,32
    80006530:	8082                	ret

0000000080006532 <uartinit>:

void uartstart();

void
uartinit(void)
{
    80006532:	1141                	addi	sp,sp,-16
    80006534:	e406                	sd	ra,8(sp)
    80006536:	e022                	sd	s0,0(sp)
    80006538:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    8000653a:	100007b7          	lui	a5,0x10000
    8000653e:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80006542:	f8000713          	li	a4,-128
    80006546:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    8000654a:	470d                	li	a4,3
    8000654c:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80006550:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80006554:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80006558:	469d                	li	a3,7
    8000655a:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    8000655e:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    80006562:	00002597          	auipc	a1,0x2
    80006566:	46e58593          	addi	a1,a1,1134 # 800089d0 <digits+0x18>
    8000656a:	00020517          	auipc	a0,0x20
    8000656e:	c9e50513          	addi	a0,a0,-866 # 80026208 <uart_tx_lock>
    80006572:	00000097          	auipc	ra,0x0
    80006576:	218080e7          	jalr	536(ra) # 8000678a <initlock>
}
    8000657a:	60a2                	ld	ra,8(sp)
    8000657c:	6402                	ld	s0,0(sp)
    8000657e:	0141                	addi	sp,sp,16
    80006580:	8082                	ret

0000000080006582 <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    80006582:	1101                	addi	sp,sp,-32
    80006584:	ec06                	sd	ra,24(sp)
    80006586:	e822                	sd	s0,16(sp)
    80006588:	e426                	sd	s1,8(sp)
    8000658a:	1000                	addi	s0,sp,32
    8000658c:	84aa                	mv	s1,a0
  push_off();
    8000658e:	00000097          	auipc	ra,0x0
    80006592:	240080e7          	jalr	576(ra) # 800067ce <push_off>

  if(panicked){
    80006596:	00003797          	auipc	a5,0x3
    8000659a:	a867a783          	lw	a5,-1402(a5) # 8000901c <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    8000659e:	10000737          	lui	a4,0x10000
  if(panicked){
    800065a2:	c391                	beqz	a5,800065a6 <uartputc_sync+0x24>
    for(;;)
    800065a4:	a001                	j	800065a4 <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    800065a6:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800065aa:	0ff7f793          	andi	a5,a5,255
    800065ae:	0207f793          	andi	a5,a5,32
    800065b2:	dbf5                	beqz	a5,800065a6 <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    800065b4:	0ff4f793          	andi	a5,s1,255
    800065b8:	10000737          	lui	a4,0x10000
    800065bc:	00f70023          	sb	a5,0(a4) # 10000000 <_entry-0x70000000>

  pop_off();
    800065c0:	00000097          	auipc	ra,0x0
    800065c4:	2ae080e7          	jalr	686(ra) # 8000686e <pop_off>
}
    800065c8:	60e2                	ld	ra,24(sp)
    800065ca:	6442                	ld	s0,16(sp)
    800065cc:	64a2                	ld	s1,8(sp)
    800065ce:	6105                	addi	sp,sp,32
    800065d0:	8082                	ret

00000000800065d2 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    800065d2:	00003717          	auipc	a4,0x3
    800065d6:	a4e73703          	ld	a4,-1458(a4) # 80009020 <uart_tx_r>
    800065da:	00003797          	auipc	a5,0x3
    800065de:	a4e7b783          	ld	a5,-1458(a5) # 80009028 <uart_tx_w>
    800065e2:	06e78c63          	beq	a5,a4,8000665a <uartstart+0x88>
{
    800065e6:	7139                	addi	sp,sp,-64
    800065e8:	fc06                	sd	ra,56(sp)
    800065ea:	f822                	sd	s0,48(sp)
    800065ec:	f426                	sd	s1,40(sp)
    800065ee:	f04a                	sd	s2,32(sp)
    800065f0:	ec4e                	sd	s3,24(sp)
    800065f2:	e852                	sd	s4,16(sp)
    800065f4:	e456                	sd	s5,8(sp)
    800065f6:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    800065f8:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    800065fc:	00020a17          	auipc	s4,0x20
    80006600:	c0ca0a13          	addi	s4,s4,-1012 # 80026208 <uart_tx_lock>
    uart_tx_r += 1;
    80006604:	00003497          	auipc	s1,0x3
    80006608:	a1c48493          	addi	s1,s1,-1508 # 80009020 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    8000660c:	00003997          	auipc	s3,0x3
    80006610:	a1c98993          	addi	s3,s3,-1508 # 80009028 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80006614:	00594783          	lbu	a5,5(s2) # 10000005 <_entry-0x6ffffffb>
    80006618:	0ff7f793          	andi	a5,a5,255
    8000661c:	0207f793          	andi	a5,a5,32
    80006620:	c785                	beqz	a5,80006648 <uartstart+0x76>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80006622:	01f77793          	andi	a5,a4,31
    80006626:	97d2                	add	a5,a5,s4
    80006628:	0187ca83          	lbu	s5,24(a5)
    uart_tx_r += 1;
    8000662c:	0705                	addi	a4,a4,1
    8000662e:	e098                	sd	a4,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    80006630:	8526                	mv	a0,s1
    80006632:	ffffb097          	auipc	ra,0xffffb
    80006636:	376080e7          	jalr	886(ra) # 800019a8 <wakeup>
    
    WriteReg(THR, c);
    8000663a:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    8000663e:	6098                	ld	a4,0(s1)
    80006640:	0009b783          	ld	a5,0(s3)
    80006644:	fce798e3          	bne	a5,a4,80006614 <uartstart+0x42>
  }
}
    80006648:	70e2                	ld	ra,56(sp)
    8000664a:	7442                	ld	s0,48(sp)
    8000664c:	74a2                	ld	s1,40(sp)
    8000664e:	7902                	ld	s2,32(sp)
    80006650:	69e2                	ld	s3,24(sp)
    80006652:	6a42                	ld	s4,16(sp)
    80006654:	6aa2                	ld	s5,8(sp)
    80006656:	6121                	addi	sp,sp,64
    80006658:	8082                	ret
    8000665a:	8082                	ret

000000008000665c <uartputc>:
{
    8000665c:	7179                	addi	sp,sp,-48
    8000665e:	f406                	sd	ra,40(sp)
    80006660:	f022                	sd	s0,32(sp)
    80006662:	ec26                	sd	s1,24(sp)
    80006664:	e84a                	sd	s2,16(sp)
    80006666:	e44e                	sd	s3,8(sp)
    80006668:	e052                	sd	s4,0(sp)
    8000666a:	1800                	addi	s0,sp,48
    8000666c:	89aa                	mv	s3,a0
  acquire(&uart_tx_lock);
    8000666e:	00020517          	auipc	a0,0x20
    80006672:	b9a50513          	addi	a0,a0,-1126 # 80026208 <uart_tx_lock>
    80006676:	00000097          	auipc	ra,0x0
    8000667a:	1a4080e7          	jalr	420(ra) # 8000681a <acquire>
  if(panicked){
    8000667e:	00003797          	auipc	a5,0x3
    80006682:	99e7a783          	lw	a5,-1634(a5) # 8000901c <panicked>
    80006686:	c391                	beqz	a5,8000668a <uartputc+0x2e>
    for(;;)
    80006688:	a001                	j	80006688 <uartputc+0x2c>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    8000668a:	00003797          	auipc	a5,0x3
    8000668e:	99e7b783          	ld	a5,-1634(a5) # 80009028 <uart_tx_w>
    80006692:	00003717          	auipc	a4,0x3
    80006696:	98e73703          	ld	a4,-1650(a4) # 80009020 <uart_tx_r>
    8000669a:	02070713          	addi	a4,a4,32
    8000669e:	02f71b63          	bne	a4,a5,800066d4 <uartputc+0x78>
      sleep(&uart_tx_r, &uart_tx_lock);
    800066a2:	00020a17          	auipc	s4,0x20
    800066a6:	b66a0a13          	addi	s4,s4,-1178 # 80026208 <uart_tx_lock>
    800066aa:	00003497          	auipc	s1,0x3
    800066ae:	97648493          	addi	s1,s1,-1674 # 80009020 <uart_tx_r>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800066b2:	00003917          	auipc	s2,0x3
    800066b6:	97690913          	addi	s2,s2,-1674 # 80009028 <uart_tx_w>
      sleep(&uart_tx_r, &uart_tx_lock);
    800066ba:	85d2                	mv	a1,s4
    800066bc:	8526                	mv	a0,s1
    800066be:	ffffb097          	auipc	ra,0xffffb
    800066c2:	15e080e7          	jalr	350(ra) # 8000181c <sleep>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800066c6:	00093783          	ld	a5,0(s2)
    800066ca:	6098                	ld	a4,0(s1)
    800066cc:	02070713          	addi	a4,a4,32
    800066d0:	fef705e3          	beq	a4,a5,800066ba <uartputc+0x5e>
      uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    800066d4:	00020497          	auipc	s1,0x20
    800066d8:	b3448493          	addi	s1,s1,-1228 # 80026208 <uart_tx_lock>
    800066dc:	01f7f713          	andi	a4,a5,31
    800066e0:	9726                	add	a4,a4,s1
    800066e2:	01370c23          	sb	s3,24(a4)
      uart_tx_w += 1;
    800066e6:	0785                	addi	a5,a5,1
    800066e8:	00003717          	auipc	a4,0x3
    800066ec:	94f73023          	sd	a5,-1728(a4) # 80009028 <uart_tx_w>
      uartstart();
    800066f0:	00000097          	auipc	ra,0x0
    800066f4:	ee2080e7          	jalr	-286(ra) # 800065d2 <uartstart>
      release(&uart_tx_lock);
    800066f8:	8526                	mv	a0,s1
    800066fa:	00000097          	auipc	ra,0x0
    800066fe:	1d4080e7          	jalr	468(ra) # 800068ce <release>
}
    80006702:	70a2                	ld	ra,40(sp)
    80006704:	7402                	ld	s0,32(sp)
    80006706:	64e2                	ld	s1,24(sp)
    80006708:	6942                	ld	s2,16(sp)
    8000670a:	69a2                	ld	s3,8(sp)
    8000670c:	6a02                	ld	s4,0(sp)
    8000670e:	6145                	addi	sp,sp,48
    80006710:	8082                	ret

0000000080006712 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80006712:	1141                	addi	sp,sp,-16
    80006714:	e422                	sd	s0,8(sp)
    80006716:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80006718:	100007b7          	lui	a5,0x10000
    8000671c:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006720:	8b85                	andi	a5,a5,1
    80006722:	cb91                	beqz	a5,80006736 <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    80006724:	100007b7          	lui	a5,0x10000
    80006728:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
    8000672c:	0ff57513          	andi	a0,a0,255
  } else {
    return -1;
  }
}
    80006730:	6422                	ld	s0,8(sp)
    80006732:	0141                	addi	sp,sp,16
    80006734:	8082                	ret
    return -1;
    80006736:	557d                	li	a0,-1
    80006738:	bfe5                	j	80006730 <uartgetc+0x1e>

000000008000673a <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from trap.c.
void
uartintr(void)
{
    8000673a:	1101                	addi	sp,sp,-32
    8000673c:	ec06                	sd	ra,24(sp)
    8000673e:	e822                	sd	s0,16(sp)
    80006740:	e426                	sd	s1,8(sp)
    80006742:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    80006744:	54fd                	li	s1,-1
    int c = uartgetc();
    80006746:	00000097          	auipc	ra,0x0
    8000674a:	fcc080e7          	jalr	-52(ra) # 80006712 <uartgetc>
    if(c == -1)
    8000674e:	00950763          	beq	a0,s1,8000675c <uartintr+0x22>
      break;
    consoleintr(c);
    80006752:	00000097          	auipc	ra,0x0
    80006756:	8fe080e7          	jalr	-1794(ra) # 80006050 <consoleintr>
  while(1){
    8000675a:	b7f5                	j	80006746 <uartintr+0xc>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    8000675c:	00020497          	auipc	s1,0x20
    80006760:	aac48493          	addi	s1,s1,-1364 # 80026208 <uart_tx_lock>
    80006764:	8526                	mv	a0,s1
    80006766:	00000097          	auipc	ra,0x0
    8000676a:	0b4080e7          	jalr	180(ra) # 8000681a <acquire>
  uartstart();
    8000676e:	00000097          	auipc	ra,0x0
    80006772:	e64080e7          	jalr	-412(ra) # 800065d2 <uartstart>
  release(&uart_tx_lock);
    80006776:	8526                	mv	a0,s1
    80006778:	00000097          	auipc	ra,0x0
    8000677c:	156080e7          	jalr	342(ra) # 800068ce <release>
}
    80006780:	60e2                	ld	ra,24(sp)
    80006782:	6442                	ld	s0,16(sp)
    80006784:	64a2                	ld	s1,8(sp)
    80006786:	6105                	addi	sp,sp,32
    80006788:	8082                	ret

000000008000678a <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    8000678a:	1141                	addi	sp,sp,-16
    8000678c:	e422                	sd	s0,8(sp)
    8000678e:	0800                	addi	s0,sp,16
  lk->name = name;
    80006790:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80006792:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80006796:	00053823          	sd	zero,16(a0)
}
    8000679a:	6422                	ld	s0,8(sp)
    8000679c:	0141                	addi	sp,sp,16
    8000679e:	8082                	ret

00000000800067a0 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    800067a0:	411c                	lw	a5,0(a0)
    800067a2:	e399                	bnez	a5,800067a8 <holding+0x8>
    800067a4:	4501                	li	a0,0
  return r;
}
    800067a6:	8082                	ret
{
    800067a8:	1101                	addi	sp,sp,-32
    800067aa:	ec06                	sd	ra,24(sp)
    800067ac:	e822                	sd	s0,16(sp)
    800067ae:	e426                	sd	s1,8(sp)
    800067b0:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    800067b2:	6904                	ld	s1,16(a0)
    800067b4:	ffffb097          	auipc	ra,0xffffb
    800067b8:	990080e7          	jalr	-1648(ra) # 80001144 <mycpu>
    800067bc:	40a48533          	sub	a0,s1,a0
    800067c0:	00153513          	seqz	a0,a0
}
    800067c4:	60e2                	ld	ra,24(sp)
    800067c6:	6442                	ld	s0,16(sp)
    800067c8:	64a2                	ld	s1,8(sp)
    800067ca:	6105                	addi	sp,sp,32
    800067cc:	8082                	ret

00000000800067ce <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    800067ce:	1101                	addi	sp,sp,-32
    800067d0:	ec06                	sd	ra,24(sp)
    800067d2:	e822                	sd	s0,16(sp)
    800067d4:	e426                	sd	s1,8(sp)
    800067d6:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800067d8:	100024f3          	csrr	s1,sstatus
    800067dc:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800067e0:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800067e2:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    800067e6:	ffffb097          	auipc	ra,0xffffb
    800067ea:	95e080e7          	jalr	-1698(ra) # 80001144 <mycpu>
    800067ee:	5d3c                	lw	a5,120(a0)
    800067f0:	cf89                	beqz	a5,8000680a <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    800067f2:	ffffb097          	auipc	ra,0xffffb
    800067f6:	952080e7          	jalr	-1710(ra) # 80001144 <mycpu>
    800067fa:	5d3c                	lw	a5,120(a0)
    800067fc:	2785                	addiw	a5,a5,1
    800067fe:	dd3c                	sw	a5,120(a0)
}
    80006800:	60e2                	ld	ra,24(sp)
    80006802:	6442                	ld	s0,16(sp)
    80006804:	64a2                	ld	s1,8(sp)
    80006806:	6105                	addi	sp,sp,32
    80006808:	8082                	ret
    mycpu()->intena = old;
    8000680a:	ffffb097          	auipc	ra,0xffffb
    8000680e:	93a080e7          	jalr	-1734(ra) # 80001144 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80006812:	8085                	srli	s1,s1,0x1
    80006814:	8885                	andi	s1,s1,1
    80006816:	dd64                	sw	s1,124(a0)
    80006818:	bfe9                	j	800067f2 <push_off+0x24>

000000008000681a <acquire>:
{
    8000681a:	1101                	addi	sp,sp,-32
    8000681c:	ec06                	sd	ra,24(sp)
    8000681e:	e822                	sd	s0,16(sp)
    80006820:	e426                	sd	s1,8(sp)
    80006822:	1000                	addi	s0,sp,32
    80006824:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80006826:	00000097          	auipc	ra,0x0
    8000682a:	fa8080e7          	jalr	-88(ra) # 800067ce <push_off>
  if(holding(lk))
    8000682e:	8526                	mv	a0,s1
    80006830:	00000097          	auipc	ra,0x0
    80006834:	f70080e7          	jalr	-144(ra) # 800067a0 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80006838:	4705                	li	a4,1
  if(holding(lk))
    8000683a:	e115                	bnez	a0,8000685e <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    8000683c:	87ba                	mv	a5,a4
    8000683e:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006842:	2781                	sext.w	a5,a5
    80006844:	ffe5                	bnez	a5,8000683c <acquire+0x22>
  __sync_synchronize();
    80006846:	0ff0000f          	fence
  lk->cpu = mycpu();
    8000684a:	ffffb097          	auipc	ra,0xffffb
    8000684e:	8fa080e7          	jalr	-1798(ra) # 80001144 <mycpu>
    80006852:	e888                	sd	a0,16(s1)
}
    80006854:	60e2                	ld	ra,24(sp)
    80006856:	6442                	ld	s0,16(sp)
    80006858:	64a2                	ld	s1,8(sp)
    8000685a:	6105                	addi	sp,sp,32
    8000685c:	8082                	ret
    panic("acquire");
    8000685e:	00002517          	auipc	a0,0x2
    80006862:	17a50513          	addi	a0,a0,378 # 800089d8 <digits+0x20>
    80006866:	00000097          	auipc	ra,0x0
    8000686a:	a6a080e7          	jalr	-1430(ra) # 800062d0 <panic>

000000008000686e <pop_off>:

void
pop_off(void)
{
    8000686e:	1141                	addi	sp,sp,-16
    80006870:	e406                	sd	ra,8(sp)
    80006872:	e022                	sd	s0,0(sp)
    80006874:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80006876:	ffffb097          	auipc	ra,0xffffb
    8000687a:	8ce080e7          	jalr	-1842(ra) # 80001144 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000687e:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80006882:	8b89                	andi	a5,a5,2
  if(intr_get())
    80006884:	e78d                	bnez	a5,800068ae <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80006886:	5d3c                	lw	a5,120(a0)
    80006888:	02f05b63          	blez	a5,800068be <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    8000688c:	37fd                	addiw	a5,a5,-1
    8000688e:	0007871b          	sext.w	a4,a5
    80006892:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80006894:	eb09                	bnez	a4,800068a6 <pop_off+0x38>
    80006896:	5d7c                	lw	a5,124(a0)
    80006898:	c799                	beqz	a5,800068a6 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000689a:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000689e:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800068a2:	10079073          	csrw	sstatus,a5
    intr_on();
}
    800068a6:	60a2                	ld	ra,8(sp)
    800068a8:	6402                	ld	s0,0(sp)
    800068aa:	0141                	addi	sp,sp,16
    800068ac:	8082                	ret
    panic("pop_off - interruptible");
    800068ae:	00002517          	auipc	a0,0x2
    800068b2:	13250513          	addi	a0,a0,306 # 800089e0 <digits+0x28>
    800068b6:	00000097          	auipc	ra,0x0
    800068ba:	a1a080e7          	jalr	-1510(ra) # 800062d0 <panic>
    panic("pop_off");
    800068be:	00002517          	auipc	a0,0x2
    800068c2:	13a50513          	addi	a0,a0,314 # 800089f8 <digits+0x40>
    800068c6:	00000097          	auipc	ra,0x0
    800068ca:	a0a080e7          	jalr	-1526(ra) # 800062d0 <panic>

00000000800068ce <release>:
{
    800068ce:	1101                	addi	sp,sp,-32
    800068d0:	ec06                	sd	ra,24(sp)
    800068d2:	e822                	sd	s0,16(sp)
    800068d4:	e426                	sd	s1,8(sp)
    800068d6:	1000                	addi	s0,sp,32
    800068d8:	84aa                	mv	s1,a0
  if(!holding(lk))
    800068da:	00000097          	auipc	ra,0x0
    800068de:	ec6080e7          	jalr	-314(ra) # 800067a0 <holding>
    800068e2:	c115                	beqz	a0,80006906 <release+0x38>
  lk->cpu = 0;
    800068e4:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    800068e8:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    800068ec:	0f50000f          	fence	iorw,ow
    800068f0:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    800068f4:	00000097          	auipc	ra,0x0
    800068f8:	f7a080e7          	jalr	-134(ra) # 8000686e <pop_off>
}
    800068fc:	60e2                	ld	ra,24(sp)
    800068fe:	6442                	ld	s0,16(sp)
    80006900:	64a2                	ld	s1,8(sp)
    80006902:	6105                	addi	sp,sp,32
    80006904:	8082                	ret
    panic("release");
    80006906:	00002517          	auipc	a0,0x2
    8000690a:	0fa50513          	addi	a0,a0,250 # 80008a00 <digits+0x48>
    8000690e:	00000097          	auipc	ra,0x0
    80006912:	9c2080e7          	jalr	-1598(ra) # 800062d0 <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051573          	csrrw	a0,sscratch,a0
    80007004:	02153423          	sd	ra,40(a0)
    80007008:	02253823          	sd	sp,48(a0)
    8000700c:	02353c23          	sd	gp,56(a0)
    80007010:	04453023          	sd	tp,64(a0)
    80007014:	04553423          	sd	t0,72(a0)
    80007018:	04653823          	sd	t1,80(a0)
    8000701c:	04753c23          	sd	t2,88(a0)
    80007020:	f120                	sd	s0,96(a0)
    80007022:	f524                	sd	s1,104(a0)
    80007024:	fd2c                	sd	a1,120(a0)
    80007026:	e150                	sd	a2,128(a0)
    80007028:	e554                	sd	a3,136(a0)
    8000702a:	e958                	sd	a4,144(a0)
    8000702c:	ed5c                	sd	a5,152(a0)
    8000702e:	0b053023          	sd	a6,160(a0)
    80007032:	0b153423          	sd	a7,168(a0)
    80007036:	0b253823          	sd	s2,176(a0)
    8000703a:	0b353c23          	sd	s3,184(a0)
    8000703e:	0d453023          	sd	s4,192(a0)
    80007042:	0d553423          	sd	s5,200(a0)
    80007046:	0d653823          	sd	s6,208(a0)
    8000704a:	0d753c23          	sd	s7,216(a0)
    8000704e:	0f853023          	sd	s8,224(a0)
    80007052:	0f953423          	sd	s9,232(a0)
    80007056:	0fa53823          	sd	s10,240(a0)
    8000705a:	0fb53c23          	sd	s11,248(a0)
    8000705e:	11c53023          	sd	t3,256(a0)
    80007062:	11d53423          	sd	t4,264(a0)
    80007066:	11e53823          	sd	t5,272(a0)
    8000706a:	11f53c23          	sd	t6,280(a0)
    8000706e:	140022f3          	csrr	t0,sscratch
    80007072:	06553823          	sd	t0,112(a0)
    80007076:	00853103          	ld	sp,8(a0)
    8000707a:	02053203          	ld	tp,32(a0)
    8000707e:	01053283          	ld	t0,16(a0)
    80007082:	00053303          	ld	t1,0(a0)
    80007086:	18031073          	csrw	satp,t1
    8000708a:	12000073          	sfence.vma
    8000708e:	8282                	jr	t0

0000000080007090 <userret>:
    80007090:	18059073          	csrw	satp,a1
    80007094:	12000073          	sfence.vma
    80007098:	07053283          	ld	t0,112(a0)
    8000709c:	14029073          	csrw	sscratch,t0
    800070a0:	02853083          	ld	ra,40(a0)
    800070a4:	03053103          	ld	sp,48(a0)
    800070a8:	03853183          	ld	gp,56(a0)
    800070ac:	04053203          	ld	tp,64(a0)
    800070b0:	04853283          	ld	t0,72(a0)
    800070b4:	05053303          	ld	t1,80(a0)
    800070b8:	05853383          	ld	t2,88(a0)
    800070bc:	7120                	ld	s0,96(a0)
    800070be:	7524                	ld	s1,104(a0)
    800070c0:	7d2c                	ld	a1,120(a0)
    800070c2:	6150                	ld	a2,128(a0)
    800070c4:	6554                	ld	a3,136(a0)
    800070c6:	6958                	ld	a4,144(a0)
    800070c8:	6d5c                	ld	a5,152(a0)
    800070ca:	0a053803          	ld	a6,160(a0)
    800070ce:	0a853883          	ld	a7,168(a0)
    800070d2:	0b053903          	ld	s2,176(a0)
    800070d6:	0b853983          	ld	s3,184(a0)
    800070da:	0c053a03          	ld	s4,192(a0)
    800070de:	0c853a83          	ld	s5,200(a0)
    800070e2:	0d053b03          	ld	s6,208(a0)
    800070e6:	0d853b83          	ld	s7,216(a0)
    800070ea:	0e053c03          	ld	s8,224(a0)
    800070ee:	0e853c83          	ld	s9,232(a0)
    800070f2:	0f053d03          	ld	s10,240(a0)
    800070f6:	0f853d83          	ld	s11,248(a0)
    800070fa:	10053e03          	ld	t3,256(a0)
    800070fe:	10853e83          	ld	t4,264(a0)
    80007102:	11053f03          	ld	t5,272(a0)
    80007106:	11853f83          	ld	t6,280(a0)
    8000710a:	14051573          	csrrw	a0,sscratch,a0
    8000710e:	10200073          	sret
	...
