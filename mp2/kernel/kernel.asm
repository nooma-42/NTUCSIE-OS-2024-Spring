
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
    80000016:	79d050ef          	jal	ra,80005fb2 <start>

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
    8000005a:	00007097          	auipc	ra,0x7
    8000005e:	952080e7          	jalr	-1710(ra) # 800069ac <acquire>
  r->next = kmem.freelist;
    80000062:	01893783          	ld	a5,24(s2)
    80000066:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000068:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    8000006c:	854a                	mv	a0,s2
    8000006e:	00007097          	auipc	ra,0x7
    80000072:	9f2080e7          	jalr	-1550(ra) # 80006a60 <release>
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
    8000008e:	3d8080e7          	jalr	984(ra) # 80006462 <panic>

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
    800000f4:	00007097          	auipc	ra,0x7
    800000f8:	828080e7          	jalr	-2008(ra) # 8000691c <initlock>
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
    8000012c:	00007097          	auipc	ra,0x7
    80000130:	880080e7          	jalr	-1920(ra) # 800069ac <acquire>
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
    80000144:	00007097          	auipc	ra,0x7
    80000148:	91c080e7          	jalr	-1764(ra) # 80006a60 <release>

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
    8000016e:	00007097          	auipc	ra,0x7
    80000172:	8f2080e7          	jalr	-1806(ra) # 80006a60 <release>
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
    80000332:	f06080e7          	jalr	-250(ra) # 80001234 <cpuid>
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
    8000034e:	eea080e7          	jalr	-278(ra) # 80001234 <cpuid>
    80000352:	85aa                	mv	a1,a0
    80000354:	00008517          	auipc	a0,0x8
    80000358:	ce450513          	addi	a0,a0,-796 # 80008038 <etext+0x38>
    8000035c:	00006097          	auipc	ra,0x6
    80000360:	150080e7          	jalr	336(ra) # 800064ac <printf>
    kvminithart();    // turn on paging
    80000364:	00000097          	auipc	ra,0x0
    80000368:	0d8080e7          	jalr	216(ra) # 8000043c <kvminithart>
    trapinithart();   // install kernel trap vector
    8000036c:	00002097          	auipc	ra,0x2
    80000370:	b40080e7          	jalr	-1216(ra) # 80001eac <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000374:	00005097          	auipc	ra,0x5
    80000378:	2fc080e7          	jalr	764(ra) # 80005670 <plicinithart>
  }

  scheduler();
    8000037c:	00001097          	auipc	ra,0x1
    80000380:	3ee080e7          	jalr	1006(ra) # 8000176a <scheduler>
    consoleinit();
    80000384:	00006097          	auipc	ra,0x6
    80000388:	ff0080e7          	jalr	-16(ra) # 80006374 <consoleinit>
    printfinit();
    8000038c:	00006097          	auipc	ra,0x6
    80000390:	306080e7          	jalr	774(ra) # 80006692 <printfinit>
    printf("\n");
    80000394:	00008517          	auipc	a0,0x8
    80000398:	cb450513          	addi	a0,a0,-844 # 80008048 <etext+0x48>
    8000039c:	00006097          	auipc	ra,0x6
    800003a0:	110080e7          	jalr	272(ra) # 800064ac <printf>
    printf("xv6 kernel is booting\n");
    800003a4:	00008517          	auipc	a0,0x8
    800003a8:	c7c50513          	addi	a0,a0,-900 # 80008020 <etext+0x20>
    800003ac:	00006097          	auipc	ra,0x6
    800003b0:	100080e7          	jalr	256(ra) # 800064ac <printf>
    printf("\n");
    800003b4:	00008517          	auipc	a0,0x8
    800003b8:	c9450513          	addi	a0,a0,-876 # 80008048 <etext+0x48>
    800003bc:	00006097          	auipc	ra,0x6
    800003c0:	0f0080e7          	jalr	240(ra) # 800064ac <printf>
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
    800003e0:	daa080e7          	jalr	-598(ra) # 80001186 <procinit>
    trapinit();      // trap vectors
    800003e4:	00002097          	auipc	ra,0x2
    800003e8:	aa0080e7          	jalr	-1376(ra) # 80001e84 <trapinit>
    trapinithart();  // install kernel trap vector
    800003ec:	00002097          	auipc	ra,0x2
    800003f0:	ac0080e7          	jalr	-1344(ra) # 80001eac <trapinithart>
    plicinit();      // set up interrupt controller
    800003f4:	00005097          	auipc	ra,0x5
    800003f8:	266080e7          	jalr	614(ra) # 8000565a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    800003fc:	00005097          	auipc	ra,0x5
    80000400:	274080e7          	jalr	628(ra) # 80005670 <plicinithart>
    binit();         // buffer cache
    80000404:	00002097          	auipc	ra,0x2
    80000408:	2ee080e7          	jalr	750(ra) # 800026f2 <binit>
    iinit();         // inode table
    8000040c:	00003097          	auipc	ra,0x3
    80000410:	96e080e7          	jalr	-1682(ra) # 80002d7a <iinit>
    fileinit();      // file table
    80000414:	00004097          	auipc	ra,0x4
    80000418:	a8e080e7          	jalr	-1394(ra) # 80003ea2 <fileinit>
    virtio_disk_init(); // emulated hard disk
    8000041c:	00005097          	auipc	ra,0x5
    80000420:	376080e7          	jalr	886(ra) # 80005792 <virtio_disk_init>
    userinit();      // first user process
    80000424:	00001097          	auipc	ra,0x1
    80000428:	114080e7          	jalr	276(ra) # 80001538 <userinit>
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
    80000492:	fd4080e7          	jalr	-44(ra) # 80006462 <panic>
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
    8000058a:	edc080e7          	jalr	-292(ra) # 80006462 <panic>
      panic("mappages: remap");
    8000058e:	00008517          	auipc	a0,0x8
    80000592:	ada50513          	addi	a0,a0,-1318 # 80008068 <etext+0x68>
    80000596:	00006097          	auipc	ra,0x6
    8000059a:	ecc080e7          	jalr	-308(ra) # 80006462 <panic>
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
    80000614:	e52080e7          	jalr	-430(ra) # 80006462 <panic>

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
    800006dc:	a1a080e7          	jalr	-1510(ra) # 800010f2 <proc_mapstacks>
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
    80000760:	d06080e7          	jalr	-762(ra) # 80006462 <panic>
      panic("uvmunmap: walk");
    80000764:	00008517          	auipc	a0,0x8
    80000768:	93450513          	addi	a0,a0,-1740 # 80008098 <etext+0x98>
    8000076c:	00006097          	auipc	ra,0x6
    80000770:	cf6080e7          	jalr	-778(ra) # 80006462 <panic>
      panic("uvmunmap: not a leaf");
    80000774:	00008517          	auipc	a0,0x8
    80000778:	93450513          	addi	a0,a0,-1740 # 800080a8 <etext+0xa8>
    8000077c:	00006097          	auipc	ra,0x6
    80000780:	ce6080e7          	jalr	-794(ra) # 80006462 <panic>
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
    80000866:	c00080e7          	jalr	-1024(ra) # 80006462 <panic>

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
    800009a8:	abe080e7          	jalr	-1346(ra) # 80006462 <panic>
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
    80000a84:	9e2080e7          	jalr	-1566(ra) # 80006462 <panic>
      panic("uvmcopy: page not present");
    80000a88:	00007517          	auipc	a0,0x7
    80000a8c:	68850513          	addi	a0,a0,1672 # 80008110 <etext+0x110>
    80000a90:	00006097          	auipc	ra,0x6
    80000a94:	9d2080e7          	jalr	-1582(ra) # 80006462 <panic>
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
    80000afa:	00006097          	auipc	ra,0x6
    80000afe:	968080e7          	jalr	-1688(ra) # 80006462 <panic>

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
    80000cce:	715d                	addi	sp,sp,-80
    80000cd0:	e486                	sd	ra,72(sp)
    80000cd2:	e0a2                	sd	s0,64(sp)
    80000cd4:	fc26                	sd	s1,56(sp)
    80000cd6:	f84a                	sd	s2,48(sp)
    80000cd8:	f44e                	sd	s3,40(sp)
    80000cda:	f052                	sd	s4,32(sp)
    80000cdc:	ec56                	sd	s5,24(sp)
    80000cde:	e85a                	sd	s6,16(sp)
    80000ce0:	e45e                	sd	s7,8(sp)
    80000ce2:	e062                	sd	s8,0(sp)
    80000ce4:	0880                	addi	s0,sp,80
    80000ce6:	84aa                	mv	s1,a0
    80000ce8:	8a2e                	mv	s4,a1
    80000cea:	8932                	mv	s2,a2
  struct proc *p = myproc();
    80000cec:	00000097          	auipc	ra,0x0
    80000cf0:	574080e7          	jalr	1396(ra) # 80001260 <myproc>
  pagetable_t pgtbl = p->pagetable;

  if (base > p->sz || (base + len) > p->sz) {
    80000cf4:	6538                	ld	a4,72(a0)
    80000cf6:	16976563          	bltu	a4,s1,80000e60 <madvise+0x192>
    80000cfa:	014487b3          	add	a5,s1,s4
    80000cfe:	16f76363          	bltu	a4,a5,80000e64 <madvise+0x196>
    return -1;
  }

  if (len == 0) {
    80000d02:	160a0363          	beqz	s4,80000e68 <madvise+0x19a>
  }

  uint64 begin = PGROUNDDOWN(base);
  uint64 last = PGROUNDDOWN(base + len - 1);

  if (advice == MADV_NORMAL) {
    80000d06:	16090e63          	beqz	s2,80000e82 <madvise+0x1b4>
  pagetable_t pgtbl = p->pagetable;
    80000d0a:	05053a03          	ld	s4,80(a0)
  uint64 begin = PGROUNDDOWN(base);
    80000d0e:	79fd                	lui	s3,0xfffff
    80000d10:	0134f4b3          	and	s1,s1,s3
  uint64 last = PGROUNDDOWN(base + len - 1);
    80000d14:	17fd                	addi	a5,a5,-1
    80000d16:	0137f9b3          	and	s3,a5,s3
    // TODO
    return 0;  // FIXME
  } else if (advice == MADV_WILLNEED) {
    80000d1a:	4785                	li	a5,1
    80000d1c:	00f90f63          	beq	s2,a5,80000d3a <madvise+0x6c>
          // that was previously holding the swapped-out page. This could be something like:
          // bfree_page(ROOTDEV, blockno);
      }
    }
    return 0;
  } else if (advice == MADV_DONTNEED) {
    80000d20:	4789                	li	a5,2
    80000d22:	08f90b63          	beq	s2,a5,80000db8 <madvise+0xea>
    #endif

    end_op();
    return 0;

  } else if(advice == MADV_PIN) {
    80000d26:	478d                	li	a5,3
    80000d28:	0ef90463          	beq	s2,a5,80000e10 <madvise+0x142>
    for (uint64 va = begin; va <= last; va += PGSIZE) {
        pte_t *pte = walk(pgtbl, va, 1); // Ensure the PTE exists
        if (pte) *pte |= PTE_P; // Set a hypothetical PTE_P (pinned) flag
    }
    return 0;
  } else if(advice == MADV_UNPIN) {
    80000d2c:	4791                	li	a5,4
    80000d2e:	16f91063          	bne	s2,a5,80000e8e <madvise+0x1c0>
    // TODO
    // Unpins pages, allowing them to be swapped out again
    for (uint64 va = begin; va <= last; va += PGSIZE) {
    80000d32:	1699e063          	bltu	s3,s1,80000e92 <madvise+0x1c4>
    80000d36:	6905                	lui	s2,0x1
    80000d38:	a229                	j	80000e42 <madvise+0x174>
    for (uint64 va = begin; va <= last; va += PGSIZE) {
    80000d3a:	1499e663          	bltu	s3,s1,80000e86 <madvise+0x1b8>
      if (pte && (*pte & PTE_S) && !(*pte & PTE_V)) {
    80000d3e:	20000c13          	li	s8,512
    for (uint64 va = begin; va <= last; va += PGSIZE) {
    80000d42:	6b85                	lui	s7,0x1
    80000d44:	a821                	j	80000d5c <madvise+0x8e>
              panic("MADV_WILLNEED: kalloc failed");
    80000d46:	00007517          	auipc	a0,0x7
    80000d4a:	3fa50513          	addi	a0,a0,1018 # 80008140 <etext+0x140>
    80000d4e:	00005097          	auipc	ra,0x5
    80000d52:	714080e7          	jalr	1812(ra) # 80006462 <panic>
    for (uint64 va = begin; va <= last; va += PGSIZE) {
    80000d56:	94de                	add	s1,s1,s7
    80000d58:	0499ee63          	bltu	s3,s1,80000db4 <madvise+0xe6>
      pte_t *pte = walk(pgtbl, va, 0);
    80000d5c:	4601                	li	a2,0
    80000d5e:	85a6                	mv	a1,s1
    80000d60:	8552                	mv	a0,s4
    80000d62:	fffff097          	auipc	ra,0xfffff
    80000d66:	6fe080e7          	jalr	1790(ra) # 80000460 <walk>
    80000d6a:	892a                	mv	s2,a0
      if (pte && (*pte & PTE_S) && !(*pte & PTE_V)) {
    80000d6c:	d56d                	beqz	a0,80000d56 <madvise+0x88>
    80000d6e:	611c                	ld	a5,0(a0)
    80000d70:	2017f713          	andi	a4,a5,513
    80000d74:	ff8711e3          	bne	a4,s8,80000d56 <madvise+0x88>
          uint64 blockno = PTE2BLOCKNO(*pte);
    80000d78:	00a7da93          	srli	s5,a5,0xa
          char *pa = kalloc();
    80000d7c:	fffff097          	auipc	ra,0xfffff
    80000d80:	39c080e7          	jalr	924(ra) # 80000118 <kalloc>
    80000d84:	8b2a                	mv	s6,a0
          if (pa == 0) {
    80000d86:	d161                	beqz	a0,80000d46 <madvise+0x78>
          read_page_from_disk(ROOTDEV, pa, blockno);
    80000d88:	000a861b          	sext.w	a2,s5
    80000d8c:	85aa                	mv	a1,a0
    80000d8e:	4505                	li	a0,1
    80000d90:	00002097          	auipc	ra,0x2
    80000d94:	bde080e7          	jalr	-1058(ra) # 8000296e <read_page_from_disk>
          *pte = PA2PTE(pa) | PTE_FLAGS(*pte) | PTE_V;
    80000d98:	00cb5b13          	srli	s6,s6,0xc
    80000d9c:	0b2a                	slli	s6,s6,0xa
    80000d9e:	00093783          	ld	a5,0(s2) # 1000 <_entry-0x7ffff000>
    80000da2:	1ff7f793          	andi	a5,a5,511
          *pte &= ~PTE_S;
    80000da6:	0167eb33          	or	s6,a5,s6
    80000daa:	001b6b13          	ori	s6,s6,1
    80000dae:	01693023          	sd	s6,0(s2)
    80000db2:	b755                	j	80000d56 <madvise+0x88>
    return 0;
    80000db4:	4501                	li	a0,0
    80000db6:	a855                	j	80000e6a <madvise+0x19c>
    begin_op();
    80000db8:	00003097          	auipc	ra,0x3
    80000dbc:	d02080e7          	jalr	-766(ra) # 80003aba <begin_op>
    for (uint64 va = begin; va <= last; va += PGSIZE) {
    80000dc0:	0499e263          	bltu	s3,s1,80000e04 <madvise+0x136>
    80000dc4:	6905                	lui	s2,0x1
    80000dc6:	a811                	j	80000dda <madvise+0x10c>
          end_op();
    80000dc8:	00003097          	auipc	ra,0x3
    80000dcc:	d72080e7          	jalr	-654(ra) # 80003b3a <end_op>
          return -1;
    80000dd0:	557d                	li	a0,-1
    80000dd2:	a861                	j	80000e6a <madvise+0x19c>
    for (uint64 va = begin; va <= last; va += PGSIZE) {
    80000dd4:	94ca                	add	s1,s1,s2
    80000dd6:	0299e763          	bltu	s3,s1,80000e04 <madvise+0x136>
      pte = walk(pgtbl, va, 0);
    80000dda:	4601                	li	a2,0
    80000ddc:	85a6                	mv	a1,s1
    80000dde:	8552                	mv	a0,s4
    80000de0:	fffff097          	auipc	ra,0xfffff
    80000de4:	680080e7          	jalr	1664(ra) # 80000460 <walk>
      if (pte != 0 && (*pte & PTE_V)) {
    80000de8:	d575                	beqz	a0,80000dd4 <madvise+0x106>
    80000dea:	611c                	ld	a5,0(a0)
    80000dec:	8b85                	andi	a5,a5,1
    80000dee:	d3fd                	beqz	a5,80000dd4 <madvise+0x106>
        char *pa = (char*) swap_page_from_pte(pte);
    80000df0:	00005097          	auipc	ra,0x5
    80000df4:	e86080e7          	jalr	-378(ra) # 80005c76 <swap_page_from_pte>
        if (pa == 0) {
    80000df8:	d961                	beqz	a0,80000dc8 <madvise+0xfa>
        kfree(pa);
    80000dfa:	fffff097          	auipc	ra,0xfffff
    80000dfe:	222080e7          	jalr	546(ra) # 8000001c <kfree>
    80000e02:	bfc9                	j	80000dd4 <madvise+0x106>
    end_op();
    80000e04:	00003097          	auipc	ra,0x3
    80000e08:	d36080e7          	jalr	-714(ra) # 80003b3a <end_op>
    return 0;
    80000e0c:	4501                	li	a0,0
    80000e0e:	a8b1                	j	80000e6a <madvise+0x19c>
    for (uint64 va = begin; va <= last; va += PGSIZE) {
    80000e10:	0699ed63          	bltu	s3,s1,80000e8a <madvise+0x1bc>
    80000e14:	6905                	lui	s2,0x1
    80000e16:	a021                	j	80000e1e <madvise+0x150>
    80000e18:	94ca                	add	s1,s1,s2
    80000e1a:	0099ef63          	bltu	s3,s1,80000e38 <madvise+0x16a>
        pte_t *pte = walk(pgtbl, va, 1); // Ensure the PTE exists
    80000e1e:	4605                	li	a2,1
    80000e20:	85a6                	mv	a1,s1
    80000e22:	8552                	mv	a0,s4
    80000e24:	fffff097          	auipc	ra,0xfffff
    80000e28:	63c080e7          	jalr	1596(ra) # 80000460 <walk>
        if (pte) *pte |= PTE_P; // Set a hypothetical PTE_P (pinned) flag
    80000e2c:	d575                	beqz	a0,80000e18 <madvise+0x14a>
    80000e2e:	611c                	ld	a5,0(a0)
    80000e30:	1007e793          	ori	a5,a5,256
    80000e34:	e11c                	sd	a5,0(a0)
    80000e36:	b7cd                	j	80000e18 <madvise+0x14a>
    return 0;
    80000e38:	4501                	li	a0,0
    80000e3a:	a805                	j	80000e6a <madvise+0x19c>
    for (uint64 va = begin; va <= last; va += PGSIZE) {
    80000e3c:	94ca                	add	s1,s1,s2
    80000e3e:	0099ef63          	bltu	s3,s1,80000e5c <madvise+0x18e>
        pte_t *pte = walk(pgtbl, va, 0); // No need to allocate
    80000e42:	4601                	li	a2,0
    80000e44:	85a6                	mv	a1,s1
    80000e46:	8552                	mv	a0,s4
    80000e48:	fffff097          	auipc	ra,0xfffff
    80000e4c:	618080e7          	jalr	1560(ra) # 80000460 <walk>
        if (pte) *pte &= ~PTE_P; // Clear the PTE_P flag
    80000e50:	d575                	beqz	a0,80000e3c <madvise+0x16e>
    80000e52:	611c                	ld	a5,0(a0)
    80000e54:	eff7f793          	andi	a5,a5,-257
    80000e58:	e11c                	sd	a5,0(a0)
    80000e5a:	b7cd                	j	80000e3c <madvise+0x16e>
    }
    return 0;
    80000e5c:	4501                	li	a0,0
    80000e5e:	a031                	j	80000e6a <madvise+0x19c>
    return -1;
    80000e60:	557d                	li	a0,-1
    80000e62:	a021                	j	80000e6a <madvise+0x19c>
    80000e64:	557d                	li	a0,-1
    80000e66:	a011                	j	80000e6a <madvise+0x19c>
    return 0;
    80000e68:	4501                	li	a0,0
  }
  else {
    return -1;
  }
}
    80000e6a:	60a6                	ld	ra,72(sp)
    80000e6c:	6406                	ld	s0,64(sp)
    80000e6e:	74e2                	ld	s1,56(sp)
    80000e70:	7942                	ld	s2,48(sp)
    80000e72:	79a2                	ld	s3,40(sp)
    80000e74:	7a02                	ld	s4,32(sp)
    80000e76:	6ae2                	ld	s5,24(sp)
    80000e78:	6b42                	ld	s6,16(sp)
    80000e7a:	6ba2                	ld	s7,8(sp)
    80000e7c:	6c02                	ld	s8,0(sp)
    80000e7e:	6161                	addi	sp,sp,80
    80000e80:	8082                	ret
    return 0;  // FIXME
    80000e82:	854a                	mv	a0,s2
    80000e84:	b7dd                	j	80000e6a <madvise+0x19c>
    return 0;
    80000e86:	4501                	li	a0,0
    80000e88:	b7cd                	j	80000e6a <madvise+0x19c>
    return 0;
    80000e8a:	4501                	li	a0,0
    80000e8c:	bff9                	j	80000e6a <madvise+0x19c>
    return -1;
    80000e8e:	557d                	li	a0,-1
    80000e90:	bfe9                	j	80000e6a <madvise+0x19c>
    return 0;
    80000e92:	4501                	li	a0,0
    80000e94:	bfd9                	j	80000e6a <madvise+0x19c>

0000000080000e96 <pgprint>:

/* NTU OS 2024 */
/* print pages from page replacement buffers */
#if defined(PG_REPLACEMENT_USE_LRU) || defined(PG_REPLACEMENT_USE_FIFO)
void pgprint() {
    80000e96:	1141                	addi	sp,sp,-16
    80000e98:	e406                	sd	ra,8(sp)
    80000e9a:	e022                	sd	s0,0(sp)
    80000e9c:	0800                	addi	s0,sp,16
  #ifdef PG_REPLACEMENT_USE_LRU
  // TODO
  #elif defined(PG_REPLACEMENT_USE_FIFO)
  // TODO
  #endif
  panic("not implemented yet\n");
    80000e9e:	00007517          	auipc	a0,0x7
    80000ea2:	2c250513          	addi	a0,a0,706 # 80008160 <etext+0x160>
    80000ea6:	00005097          	auipc	ra,0x5
    80000eaa:	5bc080e7          	jalr	1468(ra) # 80006462 <panic>

0000000080000eae <pteprint>:
}
#endif

void pteprint(pagetable_t PGTBL, unsigned long counter, int level) {
    80000eae:	7119                	addi	sp,sp,-128
    80000eb0:	fc86                	sd	ra,120(sp)
    80000eb2:	f8a2                	sd	s0,112(sp)
    80000eb4:	f4a6                	sd	s1,104(sp)
    80000eb6:	f0ca                	sd	s2,96(sp)
    80000eb8:	ecce                	sd	s3,88(sp)
    80000eba:	e8d2                	sd	s4,80(sp)
    80000ebc:	e4d6                	sd	s5,72(sp)
    80000ebe:	e0da                	sd	s6,64(sp)
    80000ec0:	fc5e                	sd	s7,56(sp)
    80000ec2:	f862                	sd	s8,48(sp)
    80000ec4:	f466                	sd	s9,40(sp)
    80000ec6:	f06a                	sd	s10,32(sp)
    80000ec8:	ec6e                	sd	s11,24(sp)
    80000eca:	0100                	addi	s0,sp,128
    80000ecc:	8d2e                	mv	s10,a1
    80000ece:	8b32                	mv	s6,a2
  pte_t *pte;
  for (int i = 0; i < MAX_IDX; i++) {
    80000ed0:	8aaa                	mv	s5,a0
void pteprint(pagetable_t PGTBL, unsigned long counter, int level) {
    80000ed2:	4981                	li	s3,0
      if (*pte & PTE_W) { printf(" W"); }
      if (*pte & PTE_X) { printf(" X"); }
      if (*pte & PTE_U) { printf(" U"); }
      if (*pte & PTE_S) { printf(" S"); }
      if (*pte & PTE_D) { printf(" D"); }
      printf("\n");
    80000ed4:	00007d97          	auipc	s11,0x7
    80000ed8:	174d8d93          	addi	s11,s11,372 # 80008048 <etext+0x48>

      // if only valid mem addr -> it's a child table
      if ((*pte & PTE_V) && (*pte & (PTE_R | PTE_W | PTE_X | PTE_U)) == 0) {
    80000edc:	4c85                	li	s9,1
        pagetable_t childPGTBL = (pagetable_t)PTE2PA(*pte);
        pteprint(childPGTBL, cur_va, level + 1);
    80000ede:	0016079b          	addiw	a5,a2,1
    80000ee2:	f8f43423          	sd	a5,-120(s0)
        for (int j = 0; j < level; j++) { printf("    "); }
    80000ee6:	00007a17          	auipc	s4,0x7
    80000eea:	29aa0a13          	addi	s4,s4,666 # 80008180 <etext+0x180>
    80000eee:	fff60b9b          	addiw	s7,a2,-1
    80000ef2:	a2a5                	j	8000105a <pteprint+0x1ac>
    80000ef4:	4481                	li	s1,0
    80000ef6:	8552                	mv	a0,s4
    80000ef8:	00005097          	auipc	ra,0x5
    80000efc:	5b4080e7          	jalr	1460(ra) # 800064ac <printf>
    80000f00:	2485                	addiw	s1,s1,1
    80000f02:	fe9b1ae3          	bne	s6,s1,80000ef6 <pteprint+0x48>
      else if (level == 1) {
    80000f06:	019b0563          	beq	s6,s9,80000f10 <pteprint+0x62>
        cur_va = counter + i;
    80000f0a:	01a984b3          	add	s1,s3,s10
    80000f0e:	a0dd                	j	80000ff4 <pteprint+0x146>
        cur_va = counter + i * MAX_IDX;
    80000f10:	00999493          	slli	s1,s3,0x9
    80000f14:	94ea                	add	s1,s1,s10
    80000f16:	a8f9                	j	80000ff4 <pteprint+0x146>
        printf("+-- %d: pte=%p va=%p pa=%p", i, pte, cur_va * PGSIZE, PTE2PA(*pte));
    80000f18:	8329                	srli	a4,a4,0xa
    80000f1a:	0732                	slli	a4,a4,0xc
    80000f1c:	00c49693          	slli	a3,s1,0xc
    80000f20:	864a                	mv	a2,s2
    80000f22:	85e2                	mv	a1,s8
    80000f24:	00007517          	auipc	a0,0x7
    80000f28:	26450513          	addi	a0,a0,612 # 80008188 <etext+0x188>
    80000f2c:	00005097          	auipc	ra,0x5
    80000f30:	580080e7          	jalr	1408(ra) # 800064ac <printf>
      if (*pte & PTE_V) { printf(" V"); }
    80000f34:	00093783          	ld	a5,0(s2) # 1000 <_entry-0x7ffff000>
    80000f38:	8b85                	andi	a5,a5,1
    80000f3a:	c7e9                	beqz	a5,80001004 <pteprint+0x156>
    80000f3c:	00007517          	auipc	a0,0x7
    80000f40:	28c50513          	addi	a0,a0,652 # 800081c8 <etext+0x1c8>
    80000f44:	00005097          	auipc	ra,0x5
    80000f48:	568080e7          	jalr	1384(ra) # 800064ac <printf>
    80000f4c:	a865                	j	80001004 <pteprint+0x156>
        printf("+-- %d: pte=%p va=%p blockno=%p", i, pte, cur_va * PGSIZE, PTE2BLOCKNO(*pte));
    80000f4e:	8329                	srli	a4,a4,0xa
    80000f50:	00c49693          	slli	a3,s1,0xc
    80000f54:	864a                	mv	a2,s2
    80000f56:	85e2                	mv	a1,s8
    80000f58:	00007517          	auipc	a0,0x7
    80000f5c:	25050513          	addi	a0,a0,592 # 800081a8 <etext+0x1a8>
    80000f60:	00005097          	auipc	ra,0x5
    80000f64:	54c080e7          	jalr	1356(ra) # 800064ac <printf>
    80000f68:	b7f1                	j	80000f34 <pteprint+0x86>
      if (*pte & PTE_R) { printf(" R"); }
    80000f6a:	00007517          	auipc	a0,0x7
    80000f6e:	26650513          	addi	a0,a0,614 # 800081d0 <etext+0x1d0>
    80000f72:	00005097          	auipc	ra,0x5
    80000f76:	53a080e7          	jalr	1338(ra) # 800064ac <printf>
    80000f7a:	a849                	j	8000100c <pteprint+0x15e>
      if (*pte & PTE_W) { printf(" W"); }
    80000f7c:	00007517          	auipc	a0,0x7
    80000f80:	25c50513          	addi	a0,a0,604 # 800081d8 <etext+0x1d8>
    80000f84:	00005097          	auipc	ra,0x5
    80000f88:	528080e7          	jalr	1320(ra) # 800064ac <printf>
    80000f8c:	a061                	j	80001014 <pteprint+0x166>
      if (*pte & PTE_X) { printf(" X"); }
    80000f8e:	00007517          	auipc	a0,0x7
    80000f92:	25250513          	addi	a0,a0,594 # 800081e0 <etext+0x1e0>
    80000f96:	00005097          	auipc	ra,0x5
    80000f9a:	516080e7          	jalr	1302(ra) # 800064ac <printf>
    80000f9e:	a8bd                	j	8000101c <pteprint+0x16e>
      if (*pte & PTE_U) { printf(" U"); }
    80000fa0:	00007517          	auipc	a0,0x7
    80000fa4:	24850513          	addi	a0,a0,584 # 800081e8 <etext+0x1e8>
    80000fa8:	00005097          	auipc	ra,0x5
    80000fac:	504080e7          	jalr	1284(ra) # 800064ac <printf>
    80000fb0:	a895                	j	80001024 <pteprint+0x176>
      if (*pte & PTE_S) { printf(" S"); }
    80000fb2:	00007517          	auipc	a0,0x7
    80000fb6:	23e50513          	addi	a0,a0,574 # 800081f0 <etext+0x1f0>
    80000fba:	00005097          	auipc	ra,0x5
    80000fbe:	4f2080e7          	jalr	1266(ra) # 800064ac <printf>
    80000fc2:	a0b5                	j	8000102e <pteprint+0x180>
      if (*pte & PTE_D) { printf(" D"); }
    80000fc4:	00007517          	auipc	a0,0x7
    80000fc8:	23450513          	addi	a0,a0,564 # 800081f8 <etext+0x1f8>
    80000fcc:	00005097          	auipc	ra,0x5
    80000fd0:	4e0080e7          	jalr	1248(ra) # 800064ac <printf>
    80000fd4:	a095                	j	80001038 <pteprint+0x18a>
        pagetable_t childPGTBL = (pagetable_t)PTE2PA(*pte);
    80000fd6:	8129                	srli	a0,a0,0xa
        pteprint(childPGTBL, cur_va, level + 1);
    80000fd8:	f8843603          	ld	a2,-120(s0)
    80000fdc:	85a6                	mv	a1,s1
    80000fde:	0532                	slli	a0,a0,0xc
    80000fe0:	00000097          	auipc	ra,0x0
    80000fe4:	ece080e7          	jalr	-306(ra) # 80000eae <pteprint>
    80000fe8:	a09d                	j	8000104e <pteprint+0x1a0>
        cur_va = counter + i * MAX_IDX * MAX_IDX;
    80000fea:	01299493          	slli	s1,s3,0x12
    80000fee:	94ea                	add	s1,s1,s10
      if (level == 0) {
    80000ff0:	f00b1de3          	bnez	s6,80000f0a <pteprint+0x5c>
      if (*pte & PTE_V) {
    80000ff4:	00093703          	ld	a4,0(s2)
    80000ff8:	00177793          	andi	a5,a4,1
    80000ffc:	ff91                	bnez	a5,80000f18 <pteprint+0x6a>
      else if (*pte & PTE_S) {
    80000ffe:	20077793          	andi	a5,a4,512
    80001002:	f7b1                	bnez	a5,80000f4e <pteprint+0xa0>
      if (*pte & PTE_R) { printf(" R"); }
    80001004:	00093783          	ld	a5,0(s2)
    80001008:	8b89                	andi	a5,a5,2
    8000100a:	f3a5                	bnez	a5,80000f6a <pteprint+0xbc>
      if (*pte & PTE_W) { printf(" W"); }
    8000100c:	00093783          	ld	a5,0(s2)
    80001010:	8b91                	andi	a5,a5,4
    80001012:	f7ad                	bnez	a5,80000f7c <pteprint+0xce>
      if (*pte & PTE_X) { printf(" X"); }
    80001014:	00093783          	ld	a5,0(s2)
    80001018:	8ba1                	andi	a5,a5,8
    8000101a:	fbb5                	bnez	a5,80000f8e <pteprint+0xe0>
      if (*pte & PTE_U) { printf(" U"); }
    8000101c:	00093783          	ld	a5,0(s2)
    80001020:	8bc1                	andi	a5,a5,16
    80001022:	ffbd                	bnez	a5,80000fa0 <pteprint+0xf2>
      if (*pte & PTE_S) { printf(" S"); }
    80001024:	00093783          	ld	a5,0(s2)
    80001028:	2007f793          	andi	a5,a5,512
    8000102c:	f3d9                	bnez	a5,80000fb2 <pteprint+0x104>
      if (*pte & PTE_D) { printf(" D"); }
    8000102e:	00093783          	ld	a5,0(s2)
    80001032:	0807f793          	andi	a5,a5,128
    80001036:	f7d9                	bnez	a5,80000fc4 <pteprint+0x116>
      printf("\n");
    80001038:	856e                	mv	a0,s11
    8000103a:	00005097          	auipc	ra,0x5
    8000103e:	472080e7          	jalr	1138(ra) # 800064ac <printf>
      if ((*pte & PTE_V) && (*pte & (PTE_R | PTE_W | PTE_X | PTE_U)) == 0) {
    80001042:	00093503          	ld	a0,0(s2)
    80001046:	01f57793          	andi	a5,a0,31
    8000104a:	f99786e3          	beq	a5,s9,80000fd6 <pteprint+0x128>
  for (int i = 0; i < MAX_IDX; i++) {
    8000104e:	0985                	addi	s3,s3,1
    80001050:	0aa1                	addi	s5,s5,8
    80001052:	20000793          	li	a5,512
    80001056:	04f98463          	beq	s3,a5,8000109e <pteprint+0x1f0>
    8000105a:	00098c1b          	sext.w	s8,s3
    pte = &PGTBL[i];
    8000105e:	8956                	mv	s2,s5
    if ((*pte & (PTE_V | PTE_S)) != 0) {
    80001060:	000ab783          	ld	a5,0(s5) # fffffffffffff000 <end+0xffffffff7ffd8dc0>
    80001064:	2017f793          	andi	a5,a5,513
    80001068:	d3fd                	beqz	a5,8000104e <pteprint+0x1a0>
      if (level > 0 && i < 256) {
    8000106a:	f96050e3          	blez	s6,80000fea <pteprint+0x13c>
    8000106e:	0ff00713          	li	a4,255
    80001072:	e98741e3          	blt	a4,s8,80000ef4 <pteprint+0x46>
        printf("|   ");
    80001076:	00007517          	auipc	a0,0x7
    8000107a:	10250513          	addi	a0,a0,258 # 80008178 <etext+0x178>
    8000107e:	00005097          	auipc	ra,0x5
    80001082:	42e080e7          	jalr	1070(ra) # 800064ac <printf>
        for (int j = 0; j < level-1; j++) { printf("    "); }  
    80001086:	e96cd0e3          	bge	s9,s6,80000f06 <pteprint+0x58>
    8000108a:	4481                	li	s1,0
    8000108c:	8552                	mv	a0,s4
    8000108e:	00005097          	auipc	ra,0x5
    80001092:	41e080e7          	jalr	1054(ra) # 800064ac <printf>
    80001096:	2485                	addiw	s1,s1,1
    80001098:	fe9b9ae3          	bne	s7,s1,8000108c <pteprint+0x1de>
    8000109c:	b5ad                	j	80000f06 <pteprint+0x58>
      }
    }
  }
}
    8000109e:	70e6                	ld	ra,120(sp)
    800010a0:	7446                	ld	s0,112(sp)
    800010a2:	74a6                	ld	s1,104(sp)
    800010a4:	7906                	ld	s2,96(sp)
    800010a6:	69e6                	ld	s3,88(sp)
    800010a8:	6a46                	ld	s4,80(sp)
    800010aa:	6aa6                	ld	s5,72(sp)
    800010ac:	6b06                	ld	s6,64(sp)
    800010ae:	7be2                	ld	s7,56(sp)
    800010b0:	7c42                	ld	s8,48(sp)
    800010b2:	7ca2                	ld	s9,40(sp)
    800010b4:	7d02                	ld	s10,32(sp)
    800010b6:	6de2                	ld	s11,24(sp)
    800010b8:	6109                	addi	sp,sp,128
    800010ba:	8082                	ret

00000000800010bc <vmprint>:

/* NTU OS 2024 */
/* Print multi layer page table. */
void vmprint(pagetable_t pagetable) {
    800010bc:	1101                	addi	sp,sp,-32
    800010be:	ec06                	sd	ra,24(sp)
    800010c0:	e822                	sd	s0,16(sp)
    800010c2:	e426                	sd	s1,8(sp)
    800010c4:	1000                	addi	s0,sp,32
    800010c6:	84aa                	mv	s1,a0
  /* TODO */
  // panic("not implemented yet\n");
  printf("page table %p\n", pagetable);
    800010c8:	85aa                	mv	a1,a0
    800010ca:	00007517          	auipc	a0,0x7
    800010ce:	13650513          	addi	a0,a0,310 # 80008200 <etext+0x200>
    800010d2:	00005097          	auipc	ra,0x5
    800010d6:	3da080e7          	jalr	986(ra) # 800064ac <printf>
  pteprint(pagetable, 0, 0);
    800010da:	4601                	li	a2,0
    800010dc:	4581                	li	a1,0
    800010de:	8526                	mv	a0,s1
    800010e0:	00000097          	auipc	ra,0x0
    800010e4:	dce080e7          	jalr	-562(ra) # 80000eae <pteprint>
}
    800010e8:	60e2                	ld	ra,24(sp)
    800010ea:	6442                	ld	s0,16(sp)
    800010ec:	64a2                	ld	s1,8(sp)
    800010ee:	6105                	addi	sp,sp,32
    800010f0:	8082                	ret

00000000800010f2 <proc_mapstacks>:

// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl) {
    800010f2:	7139                	addi	sp,sp,-64
    800010f4:	fc06                	sd	ra,56(sp)
    800010f6:	f822                	sd	s0,48(sp)
    800010f8:	f426                	sd	s1,40(sp)
    800010fa:	f04a                	sd	s2,32(sp)
    800010fc:	ec4e                	sd	s3,24(sp)
    800010fe:	e852                	sd	s4,16(sp)
    80001100:	e456                	sd	s5,8(sp)
    80001102:	e05a                	sd	s6,0(sp)
    80001104:	0080                	addi	s0,sp,64
    80001106:	89aa                	mv	s3,a0
  struct proc *p;
  for(p = proc; p < &proc[NPROC]; p++) {
    80001108:	00008497          	auipc	s1,0x8
    8000110c:	37848493          	addi	s1,s1,888 # 80009480 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80001110:	8b26                	mv	s6,s1
    80001112:	00007a97          	auipc	s5,0x7
    80001116:	eeea8a93          	addi	s5,s5,-274 # 80008000 <etext>
    8000111a:	01000937          	lui	s2,0x1000
    8000111e:	197d                	addi	s2,s2,-1
    80001120:	093a                	slli	s2,s2,0xe
  for(p = proc; p < &proc[NPROC]; p++) {
    80001122:	0000ea17          	auipc	s4,0xe
    80001126:	d5ea0a13          	addi	s4,s4,-674 # 8000ee80 <tickslock>
    char *pa = kalloc();
    8000112a:	fffff097          	auipc	ra,0xfffff
    8000112e:	fee080e7          	jalr	-18(ra) # 80000118 <kalloc>
    80001132:	862a                	mv	a2,a0
    if(pa == 0)
    80001134:	c129                	beqz	a0,80001176 <proc_mapstacks+0x84>
    uint64 va = KSTACK((int) (p - proc));
    80001136:	416485b3          	sub	a1,s1,s6
    8000113a:	858d                	srai	a1,a1,0x3
    8000113c:	000ab783          	ld	a5,0(s5)
    80001140:	02f585b3          	mul	a1,a1,a5
    80001144:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80001148:	4719                	li	a4,6
    8000114a:	6685                	lui	a3,0x1
    8000114c:	40b905b3          	sub	a1,s2,a1
    80001150:	854e                	mv	a0,s3
    80001152:	fffff097          	auipc	ra,0xfffff
    80001156:	496080e7          	jalr	1174(ra) # 800005e8 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    8000115a:	16848493          	addi	s1,s1,360
    8000115e:	fd4496e3          	bne	s1,s4,8000112a <proc_mapstacks+0x38>
  }
}
    80001162:	70e2                	ld	ra,56(sp)
    80001164:	7442                	ld	s0,48(sp)
    80001166:	74a2                	ld	s1,40(sp)
    80001168:	7902                	ld	s2,32(sp)
    8000116a:	69e2                	ld	s3,24(sp)
    8000116c:	6a42                	ld	s4,16(sp)
    8000116e:	6aa2                	ld	s5,8(sp)
    80001170:	6b02                	ld	s6,0(sp)
    80001172:	6121                	addi	sp,sp,64
    80001174:	8082                	ret
      panic("kalloc");
    80001176:	00007517          	auipc	a0,0x7
    8000117a:	09a50513          	addi	a0,a0,154 # 80008210 <etext+0x210>
    8000117e:	00005097          	auipc	ra,0x5
    80001182:	2e4080e7          	jalr	740(ra) # 80006462 <panic>

0000000080001186 <procinit>:

// initialize the proc table at boot time.
void
procinit(void)
{
    80001186:	7139                	addi	sp,sp,-64
    80001188:	fc06                	sd	ra,56(sp)
    8000118a:	f822                	sd	s0,48(sp)
    8000118c:	f426                	sd	s1,40(sp)
    8000118e:	f04a                	sd	s2,32(sp)
    80001190:	ec4e                	sd	s3,24(sp)
    80001192:	e852                	sd	s4,16(sp)
    80001194:	e456                	sd	s5,8(sp)
    80001196:	e05a                	sd	s6,0(sp)
    80001198:	0080                	addi	s0,sp,64
  struct proc *p;
  initlock(&pid_lock, "nextpid");
    8000119a:	00007597          	auipc	a1,0x7
    8000119e:	07e58593          	addi	a1,a1,126 # 80008218 <etext+0x218>
    800011a2:	00008517          	auipc	a0,0x8
    800011a6:	eae50513          	addi	a0,a0,-338 # 80009050 <pid_lock>
    800011aa:	00005097          	auipc	ra,0x5
    800011ae:	772080e7          	jalr	1906(ra) # 8000691c <initlock>
  initlock(&wait_lock, "wait_lock");
    800011b2:	00007597          	auipc	a1,0x7
    800011b6:	06e58593          	addi	a1,a1,110 # 80008220 <etext+0x220>
    800011ba:	00008517          	auipc	a0,0x8
    800011be:	eae50513          	addi	a0,a0,-338 # 80009068 <wait_lock>
    800011c2:	00005097          	auipc	ra,0x5
    800011c6:	75a080e7          	jalr	1882(ra) # 8000691c <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    800011ca:	00008497          	auipc	s1,0x8
    800011ce:	2b648493          	addi	s1,s1,694 # 80009480 <proc>
      initlock(&p->lock, "proc");
    800011d2:	00007b17          	auipc	s6,0x7
    800011d6:	05eb0b13          	addi	s6,s6,94 # 80008230 <etext+0x230>
      p->kstack = KSTACK((int) (p - proc));
    800011da:	8aa6                	mv	s5,s1
    800011dc:	00007a17          	auipc	s4,0x7
    800011e0:	e24a0a13          	addi	s4,s4,-476 # 80008000 <etext>
    800011e4:	01000937          	lui	s2,0x1000
    800011e8:	197d                	addi	s2,s2,-1
    800011ea:	093a                	slli	s2,s2,0xe
  for(p = proc; p < &proc[NPROC]; p++) {
    800011ec:	0000e997          	auipc	s3,0xe
    800011f0:	c9498993          	addi	s3,s3,-876 # 8000ee80 <tickslock>
      initlock(&p->lock, "proc");
    800011f4:	85da                	mv	a1,s6
    800011f6:	8526                	mv	a0,s1
    800011f8:	00005097          	auipc	ra,0x5
    800011fc:	724080e7          	jalr	1828(ra) # 8000691c <initlock>
      p->kstack = KSTACK((int) (p - proc));
    80001200:	415487b3          	sub	a5,s1,s5
    80001204:	878d                	srai	a5,a5,0x3
    80001206:	000a3703          	ld	a4,0(s4)
    8000120a:	02e787b3          	mul	a5,a5,a4
    8000120e:	00d7979b          	slliw	a5,a5,0xd
    80001212:	40f907b3          	sub	a5,s2,a5
    80001216:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80001218:	16848493          	addi	s1,s1,360
    8000121c:	fd349ce3          	bne	s1,s3,800011f4 <procinit+0x6e>
  }
}
    80001220:	70e2                	ld	ra,56(sp)
    80001222:	7442                	ld	s0,48(sp)
    80001224:	74a2                	ld	s1,40(sp)
    80001226:	7902                	ld	s2,32(sp)
    80001228:	69e2                	ld	s3,24(sp)
    8000122a:	6a42                	ld	s4,16(sp)
    8000122c:	6aa2                	ld	s5,8(sp)
    8000122e:	6b02                	ld	s6,0(sp)
    80001230:	6121                	addi	sp,sp,64
    80001232:	8082                	ret

0000000080001234 <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80001234:	1141                	addi	sp,sp,-16
    80001236:	e422                	sd	s0,8(sp)
    80001238:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    8000123a:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    8000123c:	2501                	sext.w	a0,a0
    8000123e:	6422                	ld	s0,8(sp)
    80001240:	0141                	addi	sp,sp,16
    80001242:	8082                	ret

0000000080001244 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void) {
    80001244:	1141                	addi	sp,sp,-16
    80001246:	e422                	sd	s0,8(sp)
    80001248:	0800                	addi	s0,sp,16
    8000124a:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    8000124c:	2781                	sext.w	a5,a5
    8000124e:	079e                	slli	a5,a5,0x7
  return c;
}
    80001250:	00008517          	auipc	a0,0x8
    80001254:	e3050513          	addi	a0,a0,-464 # 80009080 <cpus>
    80001258:	953e                	add	a0,a0,a5
    8000125a:	6422                	ld	s0,8(sp)
    8000125c:	0141                	addi	sp,sp,16
    8000125e:	8082                	ret

0000000080001260 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void) {
    80001260:	1101                	addi	sp,sp,-32
    80001262:	ec06                	sd	ra,24(sp)
    80001264:	e822                	sd	s0,16(sp)
    80001266:	e426                	sd	s1,8(sp)
    80001268:	1000                	addi	s0,sp,32
  push_off();
    8000126a:	00005097          	auipc	ra,0x5
    8000126e:	6f6080e7          	jalr	1782(ra) # 80006960 <push_off>
    80001272:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80001274:	2781                	sext.w	a5,a5
    80001276:	079e                	slli	a5,a5,0x7
    80001278:	00008717          	auipc	a4,0x8
    8000127c:	dd870713          	addi	a4,a4,-552 # 80009050 <pid_lock>
    80001280:	97ba                	add	a5,a5,a4
    80001282:	7b84                	ld	s1,48(a5)
  pop_off();
    80001284:	00005097          	auipc	ra,0x5
    80001288:	77c080e7          	jalr	1916(ra) # 80006a00 <pop_off>
  return p;
}
    8000128c:	8526                	mv	a0,s1
    8000128e:	60e2                	ld	ra,24(sp)
    80001290:	6442                	ld	s0,16(sp)
    80001292:	64a2                	ld	s1,8(sp)
    80001294:	6105                	addi	sp,sp,32
    80001296:	8082                	ret

0000000080001298 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80001298:	1141                	addi	sp,sp,-16
    8000129a:	e406                	sd	ra,8(sp)
    8000129c:	e022                	sd	s0,0(sp)
    8000129e:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    800012a0:	00000097          	auipc	ra,0x0
    800012a4:	fc0080e7          	jalr	-64(ra) # 80001260 <myproc>
    800012a8:	00005097          	auipc	ra,0x5
    800012ac:	7b8080e7          	jalr	1976(ra) # 80006a60 <release>

  if (first) {
    800012b0:	00007797          	auipc	a5,0x7
    800012b4:	7607a783          	lw	a5,1888(a5) # 80008a10 <first.1768>
    800012b8:	eb89                	bnez	a5,800012ca <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    800012ba:	00001097          	auipc	ra,0x1
    800012be:	c0a080e7          	jalr	-1014(ra) # 80001ec4 <usertrapret>
}
    800012c2:	60a2                	ld	ra,8(sp)
    800012c4:	6402                	ld	s0,0(sp)
    800012c6:	0141                	addi	sp,sp,16
    800012c8:	8082                	ret
    first = 0;
    800012ca:	00007797          	auipc	a5,0x7
    800012ce:	7407a323          	sw	zero,1862(a5) # 80008a10 <first.1768>
    fsinit(ROOTDEV);
    800012d2:	4505                	li	a0,1
    800012d4:	00002097          	auipc	ra,0x2
    800012d8:	a26080e7          	jalr	-1498(ra) # 80002cfa <fsinit>
    800012dc:	bff9                	j	800012ba <forkret+0x22>

00000000800012de <allocpid>:
allocpid() {
    800012de:	1101                	addi	sp,sp,-32
    800012e0:	ec06                	sd	ra,24(sp)
    800012e2:	e822                	sd	s0,16(sp)
    800012e4:	e426                	sd	s1,8(sp)
    800012e6:	e04a                	sd	s2,0(sp)
    800012e8:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    800012ea:	00008917          	auipc	s2,0x8
    800012ee:	d6690913          	addi	s2,s2,-666 # 80009050 <pid_lock>
    800012f2:	854a                	mv	a0,s2
    800012f4:	00005097          	auipc	ra,0x5
    800012f8:	6b8080e7          	jalr	1720(ra) # 800069ac <acquire>
  pid = nextpid;
    800012fc:	00007797          	auipc	a5,0x7
    80001300:	71878793          	addi	a5,a5,1816 # 80008a14 <nextpid>
    80001304:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80001306:	0014871b          	addiw	a4,s1,1
    8000130a:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    8000130c:	854a                	mv	a0,s2
    8000130e:	00005097          	auipc	ra,0x5
    80001312:	752080e7          	jalr	1874(ra) # 80006a60 <release>
}
    80001316:	8526                	mv	a0,s1
    80001318:	60e2                	ld	ra,24(sp)
    8000131a:	6442                	ld	s0,16(sp)
    8000131c:	64a2                	ld	s1,8(sp)
    8000131e:	6902                	ld	s2,0(sp)
    80001320:	6105                	addi	sp,sp,32
    80001322:	8082                	ret

0000000080001324 <proc_pagetable>:
{
    80001324:	1101                	addi	sp,sp,-32
    80001326:	ec06                	sd	ra,24(sp)
    80001328:	e822                	sd	s0,16(sp)
    8000132a:	e426                	sd	s1,8(sp)
    8000132c:	e04a                	sd	s2,0(sp)
    8000132e:	1000                	addi	s0,sp,32
    80001330:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80001332:	fffff097          	auipc	ra,0xfffff
    80001336:	498080e7          	jalr	1176(ra) # 800007ca <uvmcreate>
    8000133a:	84aa                	mv	s1,a0
  if(pagetable == 0)
    8000133c:	c121                	beqz	a0,8000137c <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    8000133e:	4729                	li	a4,10
    80001340:	00006697          	auipc	a3,0x6
    80001344:	cc068693          	addi	a3,a3,-832 # 80007000 <_trampoline>
    80001348:	6605                	lui	a2,0x1
    8000134a:	040005b7          	lui	a1,0x4000
    8000134e:	15fd                	addi	a1,a1,-1
    80001350:	05b2                	slli	a1,a1,0xc
    80001352:	fffff097          	auipc	ra,0xfffff
    80001356:	1f6080e7          	jalr	502(ra) # 80000548 <mappages>
    8000135a:	02054863          	bltz	a0,8000138a <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    8000135e:	4719                	li	a4,6
    80001360:	05893683          	ld	a3,88(s2)
    80001364:	6605                	lui	a2,0x1
    80001366:	020005b7          	lui	a1,0x2000
    8000136a:	15fd                	addi	a1,a1,-1
    8000136c:	05b6                	slli	a1,a1,0xd
    8000136e:	8526                	mv	a0,s1
    80001370:	fffff097          	auipc	ra,0xfffff
    80001374:	1d8080e7          	jalr	472(ra) # 80000548 <mappages>
    80001378:	02054163          	bltz	a0,8000139a <proc_pagetable+0x76>
}
    8000137c:	8526                	mv	a0,s1
    8000137e:	60e2                	ld	ra,24(sp)
    80001380:	6442                	ld	s0,16(sp)
    80001382:	64a2                	ld	s1,8(sp)
    80001384:	6902                	ld	s2,0(sp)
    80001386:	6105                	addi	sp,sp,32
    80001388:	8082                	ret
    uvmfree(pagetable, 0);
    8000138a:	4581                	li	a1,0
    8000138c:	8526                	mv	a0,s1
    8000138e:	fffff097          	auipc	ra,0xfffff
    80001392:	638080e7          	jalr	1592(ra) # 800009c6 <uvmfree>
    return 0;
    80001396:	4481                	li	s1,0
    80001398:	b7d5                	j	8000137c <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    8000139a:	4681                	li	a3,0
    8000139c:	4605                	li	a2,1
    8000139e:	040005b7          	lui	a1,0x4000
    800013a2:	15fd                	addi	a1,a1,-1
    800013a4:	05b2                	slli	a1,a1,0xc
    800013a6:	8526                	mv	a0,s1
    800013a8:	fffff097          	auipc	ra,0xfffff
    800013ac:	366080e7          	jalr	870(ra) # 8000070e <uvmunmap>
    uvmfree(pagetable, 0);
    800013b0:	4581                	li	a1,0
    800013b2:	8526                	mv	a0,s1
    800013b4:	fffff097          	auipc	ra,0xfffff
    800013b8:	612080e7          	jalr	1554(ra) # 800009c6 <uvmfree>
    return 0;
    800013bc:	4481                	li	s1,0
    800013be:	bf7d                	j	8000137c <proc_pagetable+0x58>

00000000800013c0 <proc_freepagetable>:
{
    800013c0:	1101                	addi	sp,sp,-32
    800013c2:	ec06                	sd	ra,24(sp)
    800013c4:	e822                	sd	s0,16(sp)
    800013c6:	e426                	sd	s1,8(sp)
    800013c8:	e04a                	sd	s2,0(sp)
    800013ca:	1000                	addi	s0,sp,32
    800013cc:	84aa                	mv	s1,a0
    800013ce:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    800013d0:	4681                	li	a3,0
    800013d2:	4605                	li	a2,1
    800013d4:	040005b7          	lui	a1,0x4000
    800013d8:	15fd                	addi	a1,a1,-1
    800013da:	05b2                	slli	a1,a1,0xc
    800013dc:	fffff097          	auipc	ra,0xfffff
    800013e0:	332080e7          	jalr	818(ra) # 8000070e <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    800013e4:	4681                	li	a3,0
    800013e6:	4605                	li	a2,1
    800013e8:	020005b7          	lui	a1,0x2000
    800013ec:	15fd                	addi	a1,a1,-1
    800013ee:	05b6                	slli	a1,a1,0xd
    800013f0:	8526                	mv	a0,s1
    800013f2:	fffff097          	auipc	ra,0xfffff
    800013f6:	31c080e7          	jalr	796(ra) # 8000070e <uvmunmap>
  uvmfree(pagetable, sz);
    800013fa:	85ca                	mv	a1,s2
    800013fc:	8526                	mv	a0,s1
    800013fe:	fffff097          	auipc	ra,0xfffff
    80001402:	5c8080e7          	jalr	1480(ra) # 800009c6 <uvmfree>
}
    80001406:	60e2                	ld	ra,24(sp)
    80001408:	6442                	ld	s0,16(sp)
    8000140a:	64a2                	ld	s1,8(sp)
    8000140c:	6902                	ld	s2,0(sp)
    8000140e:	6105                	addi	sp,sp,32
    80001410:	8082                	ret

0000000080001412 <freeproc>:
{
    80001412:	1101                	addi	sp,sp,-32
    80001414:	ec06                	sd	ra,24(sp)
    80001416:	e822                	sd	s0,16(sp)
    80001418:	e426                	sd	s1,8(sp)
    8000141a:	1000                	addi	s0,sp,32
    8000141c:	84aa                	mv	s1,a0
  if(p->trapframe)
    8000141e:	6d28                	ld	a0,88(a0)
    80001420:	c509                	beqz	a0,8000142a <freeproc+0x18>
    kfree((void*)p->trapframe);
    80001422:	fffff097          	auipc	ra,0xfffff
    80001426:	bfa080e7          	jalr	-1030(ra) # 8000001c <kfree>
  p->trapframe = 0;
    8000142a:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    8000142e:	68a8                	ld	a0,80(s1)
    80001430:	c511                	beqz	a0,8000143c <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    80001432:	64ac                	ld	a1,72(s1)
    80001434:	00000097          	auipc	ra,0x0
    80001438:	f8c080e7          	jalr	-116(ra) # 800013c0 <proc_freepagetable>
  p->pagetable = 0;
    8000143c:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80001440:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80001444:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80001448:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    8000144c:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80001450:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80001454:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80001458:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    8000145c:	0004ac23          	sw	zero,24(s1)
}
    80001460:	60e2                	ld	ra,24(sp)
    80001462:	6442                	ld	s0,16(sp)
    80001464:	64a2                	ld	s1,8(sp)
    80001466:	6105                	addi	sp,sp,32
    80001468:	8082                	ret

000000008000146a <allocproc>:
{
    8000146a:	1101                	addi	sp,sp,-32
    8000146c:	ec06                	sd	ra,24(sp)
    8000146e:	e822                	sd	s0,16(sp)
    80001470:	e426                	sd	s1,8(sp)
    80001472:	e04a                	sd	s2,0(sp)
    80001474:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    80001476:	00008497          	auipc	s1,0x8
    8000147a:	00a48493          	addi	s1,s1,10 # 80009480 <proc>
    8000147e:	0000e917          	auipc	s2,0xe
    80001482:	a0290913          	addi	s2,s2,-1534 # 8000ee80 <tickslock>
    acquire(&p->lock);
    80001486:	8526                	mv	a0,s1
    80001488:	00005097          	auipc	ra,0x5
    8000148c:	524080e7          	jalr	1316(ra) # 800069ac <acquire>
    if(p->state == UNUSED) {
    80001490:	4c9c                	lw	a5,24(s1)
    80001492:	cf81                	beqz	a5,800014aa <allocproc+0x40>
      release(&p->lock);
    80001494:	8526                	mv	a0,s1
    80001496:	00005097          	auipc	ra,0x5
    8000149a:	5ca080e7          	jalr	1482(ra) # 80006a60 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    8000149e:	16848493          	addi	s1,s1,360
    800014a2:	ff2492e3          	bne	s1,s2,80001486 <allocproc+0x1c>
  return 0;
    800014a6:	4481                	li	s1,0
    800014a8:	a889                	j	800014fa <allocproc+0x90>
  p->pid = allocpid();
    800014aa:	00000097          	auipc	ra,0x0
    800014ae:	e34080e7          	jalr	-460(ra) # 800012de <allocpid>
    800014b2:	d888                	sw	a0,48(s1)
  p->state = USED;
    800014b4:	4785                	li	a5,1
    800014b6:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    800014b8:	fffff097          	auipc	ra,0xfffff
    800014bc:	c60080e7          	jalr	-928(ra) # 80000118 <kalloc>
    800014c0:	892a                	mv	s2,a0
    800014c2:	eca8                	sd	a0,88(s1)
    800014c4:	c131                	beqz	a0,80001508 <allocproc+0x9e>
  p->pagetable = proc_pagetable(p);
    800014c6:	8526                	mv	a0,s1
    800014c8:	00000097          	auipc	ra,0x0
    800014cc:	e5c080e7          	jalr	-420(ra) # 80001324 <proc_pagetable>
    800014d0:	892a                	mv	s2,a0
    800014d2:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    800014d4:	c531                	beqz	a0,80001520 <allocproc+0xb6>
  memset(&p->context, 0, sizeof(p->context));
    800014d6:	07000613          	li	a2,112
    800014da:	4581                	li	a1,0
    800014dc:	06048513          	addi	a0,s1,96
    800014e0:	fffff097          	auipc	ra,0xfffff
    800014e4:	c98080e7          	jalr	-872(ra) # 80000178 <memset>
  p->context.ra = (uint64)forkret;
    800014e8:	00000797          	auipc	a5,0x0
    800014ec:	db078793          	addi	a5,a5,-592 # 80001298 <forkret>
    800014f0:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    800014f2:	60bc                	ld	a5,64(s1)
    800014f4:	6705                	lui	a4,0x1
    800014f6:	97ba                	add	a5,a5,a4
    800014f8:	f4bc                	sd	a5,104(s1)
}
    800014fa:	8526                	mv	a0,s1
    800014fc:	60e2                	ld	ra,24(sp)
    800014fe:	6442                	ld	s0,16(sp)
    80001500:	64a2                	ld	s1,8(sp)
    80001502:	6902                	ld	s2,0(sp)
    80001504:	6105                	addi	sp,sp,32
    80001506:	8082                	ret
    freeproc(p);
    80001508:	8526                	mv	a0,s1
    8000150a:	00000097          	auipc	ra,0x0
    8000150e:	f08080e7          	jalr	-248(ra) # 80001412 <freeproc>
    release(&p->lock);
    80001512:	8526                	mv	a0,s1
    80001514:	00005097          	auipc	ra,0x5
    80001518:	54c080e7          	jalr	1356(ra) # 80006a60 <release>
    return 0;
    8000151c:	84ca                	mv	s1,s2
    8000151e:	bff1                	j	800014fa <allocproc+0x90>
    freeproc(p);
    80001520:	8526                	mv	a0,s1
    80001522:	00000097          	auipc	ra,0x0
    80001526:	ef0080e7          	jalr	-272(ra) # 80001412 <freeproc>
    release(&p->lock);
    8000152a:	8526                	mv	a0,s1
    8000152c:	00005097          	auipc	ra,0x5
    80001530:	534080e7          	jalr	1332(ra) # 80006a60 <release>
    return 0;
    80001534:	84ca                	mv	s1,s2
    80001536:	b7d1                	j	800014fa <allocproc+0x90>

0000000080001538 <userinit>:
{
    80001538:	1101                	addi	sp,sp,-32
    8000153a:	ec06                	sd	ra,24(sp)
    8000153c:	e822                	sd	s0,16(sp)
    8000153e:	e426                	sd	s1,8(sp)
    80001540:	1000                	addi	s0,sp,32
  p = allocproc();
    80001542:	00000097          	auipc	ra,0x0
    80001546:	f28080e7          	jalr	-216(ra) # 8000146a <allocproc>
    8000154a:	84aa                	mv	s1,a0
  initproc = p;
    8000154c:	00008797          	auipc	a5,0x8
    80001550:	aca7b223          	sd	a0,-1340(a5) # 80009010 <initproc>
  uvminit(p->pagetable, initcode, sizeof(initcode));
    80001554:	03400613          	li	a2,52
    80001558:	00007597          	auipc	a1,0x7
    8000155c:	4c858593          	addi	a1,a1,1224 # 80008a20 <initcode>
    80001560:	6928                	ld	a0,80(a0)
    80001562:	fffff097          	auipc	ra,0xfffff
    80001566:	296080e7          	jalr	662(ra) # 800007f8 <uvminit>
  p->sz = PGSIZE;
    8000156a:	6785                	lui	a5,0x1
    8000156c:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    8000156e:	6cb8                	ld	a4,88(s1)
    80001570:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80001574:	6cb8                	ld	a4,88(s1)
    80001576:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80001578:	4641                	li	a2,16
    8000157a:	00007597          	auipc	a1,0x7
    8000157e:	cbe58593          	addi	a1,a1,-834 # 80008238 <etext+0x238>
    80001582:	15848513          	addi	a0,s1,344
    80001586:	fffff097          	auipc	ra,0xfffff
    8000158a:	d44080e7          	jalr	-700(ra) # 800002ca <safestrcpy>
  p->cwd = namei("/");
    8000158e:	00007517          	auipc	a0,0x7
    80001592:	cba50513          	addi	a0,a0,-838 # 80008248 <etext+0x248>
    80001596:	00002097          	auipc	ra,0x2
    8000159a:	176080e7          	jalr	374(ra) # 8000370c <namei>
    8000159e:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    800015a2:	478d                	li	a5,3
    800015a4:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    800015a6:	8526                	mv	a0,s1
    800015a8:	00005097          	auipc	ra,0x5
    800015ac:	4b8080e7          	jalr	1208(ra) # 80006a60 <release>
}
    800015b0:	60e2                	ld	ra,24(sp)
    800015b2:	6442                	ld	s0,16(sp)
    800015b4:	64a2                	ld	s1,8(sp)
    800015b6:	6105                	addi	sp,sp,32
    800015b8:	8082                	ret

00000000800015ba <growproc>:
{
    800015ba:	1101                	addi	sp,sp,-32
    800015bc:	ec06                	sd	ra,24(sp)
    800015be:	e822                	sd	s0,16(sp)
    800015c0:	e426                	sd	s1,8(sp)
    800015c2:	e04a                	sd	s2,0(sp)
    800015c4:	1000                	addi	s0,sp,32
    800015c6:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    800015c8:	00000097          	auipc	ra,0x0
    800015cc:	c98080e7          	jalr	-872(ra) # 80001260 <myproc>
    800015d0:	892a                	mv	s2,a0
  sz = p->sz;
    800015d2:	652c                	ld	a1,72(a0)
    800015d4:	0005861b          	sext.w	a2,a1
  if(n > 0){
    800015d8:	00904f63          	bgtz	s1,800015f6 <growproc+0x3c>
  } else if(n < 0){
    800015dc:	0204cc63          	bltz	s1,80001614 <growproc+0x5a>
  p->sz = sz;
    800015e0:	1602                	slli	a2,a2,0x20
    800015e2:	9201                	srli	a2,a2,0x20
    800015e4:	04c93423          	sd	a2,72(s2)
  return 0;
    800015e8:	4501                	li	a0,0
}
    800015ea:	60e2                	ld	ra,24(sp)
    800015ec:	6442                	ld	s0,16(sp)
    800015ee:	64a2                	ld	s1,8(sp)
    800015f0:	6902                	ld	s2,0(sp)
    800015f2:	6105                	addi	sp,sp,32
    800015f4:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    800015f6:	9e25                	addw	a2,a2,s1
    800015f8:	1602                	slli	a2,a2,0x20
    800015fa:	9201                	srli	a2,a2,0x20
    800015fc:	1582                	slli	a1,a1,0x20
    800015fe:	9181                	srli	a1,a1,0x20
    80001600:	6928                	ld	a0,80(a0)
    80001602:	fffff097          	auipc	ra,0xfffff
    80001606:	2b0080e7          	jalr	688(ra) # 800008b2 <uvmalloc>
    8000160a:	0005061b          	sext.w	a2,a0
    8000160e:	fa69                	bnez	a2,800015e0 <growproc+0x26>
      return -1;
    80001610:	557d                	li	a0,-1
    80001612:	bfe1                	j	800015ea <growproc+0x30>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80001614:	9e25                	addw	a2,a2,s1
    80001616:	1602                	slli	a2,a2,0x20
    80001618:	9201                	srli	a2,a2,0x20
    8000161a:	1582                	slli	a1,a1,0x20
    8000161c:	9181                	srli	a1,a1,0x20
    8000161e:	6928                	ld	a0,80(a0)
    80001620:	fffff097          	auipc	ra,0xfffff
    80001624:	24a080e7          	jalr	586(ra) # 8000086a <uvmdealloc>
    80001628:	0005061b          	sext.w	a2,a0
    8000162c:	bf55                	j	800015e0 <growproc+0x26>

000000008000162e <fork>:
{
    8000162e:	7179                	addi	sp,sp,-48
    80001630:	f406                	sd	ra,40(sp)
    80001632:	f022                	sd	s0,32(sp)
    80001634:	ec26                	sd	s1,24(sp)
    80001636:	e84a                	sd	s2,16(sp)
    80001638:	e44e                	sd	s3,8(sp)
    8000163a:	e052                	sd	s4,0(sp)
    8000163c:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    8000163e:	00000097          	auipc	ra,0x0
    80001642:	c22080e7          	jalr	-990(ra) # 80001260 <myproc>
    80001646:	892a                	mv	s2,a0
  if((np = allocproc()) == 0){
    80001648:	00000097          	auipc	ra,0x0
    8000164c:	e22080e7          	jalr	-478(ra) # 8000146a <allocproc>
    80001650:	10050b63          	beqz	a0,80001766 <fork+0x138>
    80001654:	89aa                	mv	s3,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80001656:	04893603          	ld	a2,72(s2)
    8000165a:	692c                	ld	a1,80(a0)
    8000165c:	05093503          	ld	a0,80(s2)
    80001660:	fffff097          	auipc	ra,0xfffff
    80001664:	39e080e7          	jalr	926(ra) # 800009fe <uvmcopy>
    80001668:	04054663          	bltz	a0,800016b4 <fork+0x86>
  np->sz = p->sz;
    8000166c:	04893783          	ld	a5,72(s2)
    80001670:	04f9b423          	sd	a5,72(s3)
  *(np->trapframe) = *(p->trapframe);
    80001674:	05893683          	ld	a3,88(s2)
    80001678:	87b6                	mv	a5,a3
    8000167a:	0589b703          	ld	a4,88(s3)
    8000167e:	12068693          	addi	a3,a3,288
    80001682:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    80001686:	6788                	ld	a0,8(a5)
    80001688:	6b8c                	ld	a1,16(a5)
    8000168a:	6f90                	ld	a2,24(a5)
    8000168c:	01073023          	sd	a6,0(a4)
    80001690:	e708                	sd	a0,8(a4)
    80001692:	eb0c                	sd	a1,16(a4)
    80001694:	ef10                	sd	a2,24(a4)
    80001696:	02078793          	addi	a5,a5,32
    8000169a:	02070713          	addi	a4,a4,32
    8000169e:	fed792e3          	bne	a5,a3,80001682 <fork+0x54>
  np->trapframe->a0 = 0;
    800016a2:	0589b783          	ld	a5,88(s3)
    800016a6:	0607b823          	sd	zero,112(a5)
    800016aa:	0d000493          	li	s1,208
  for(i = 0; i < NOFILE; i++)
    800016ae:	15000a13          	li	s4,336
    800016b2:	a03d                	j	800016e0 <fork+0xb2>
    freeproc(np);
    800016b4:	854e                	mv	a0,s3
    800016b6:	00000097          	auipc	ra,0x0
    800016ba:	d5c080e7          	jalr	-676(ra) # 80001412 <freeproc>
    release(&np->lock);
    800016be:	854e                	mv	a0,s3
    800016c0:	00005097          	auipc	ra,0x5
    800016c4:	3a0080e7          	jalr	928(ra) # 80006a60 <release>
    return -1;
    800016c8:	5a7d                	li	s4,-1
    800016ca:	a069                	j	80001754 <fork+0x126>
      np->ofile[i] = filedup(p->ofile[i]);
    800016cc:	00003097          	auipc	ra,0x3
    800016d0:	868080e7          	jalr	-1944(ra) # 80003f34 <filedup>
    800016d4:	009987b3          	add	a5,s3,s1
    800016d8:	e388                	sd	a0,0(a5)
  for(i = 0; i < NOFILE; i++)
    800016da:	04a1                	addi	s1,s1,8
    800016dc:	01448763          	beq	s1,s4,800016ea <fork+0xbc>
    if(p->ofile[i])
    800016e0:	009907b3          	add	a5,s2,s1
    800016e4:	6388                	ld	a0,0(a5)
    800016e6:	f17d                	bnez	a0,800016cc <fork+0x9e>
    800016e8:	bfcd                	j	800016da <fork+0xac>
  np->cwd = idup(p->cwd);
    800016ea:	15093503          	ld	a0,336(s2)
    800016ee:	00002097          	auipc	ra,0x2
    800016f2:	834080e7          	jalr	-1996(ra) # 80002f22 <idup>
    800016f6:	14a9b823          	sd	a0,336(s3)
  safestrcpy(np->name, p->name, sizeof(p->name));
    800016fa:	4641                	li	a2,16
    800016fc:	15890593          	addi	a1,s2,344
    80001700:	15898513          	addi	a0,s3,344
    80001704:	fffff097          	auipc	ra,0xfffff
    80001708:	bc6080e7          	jalr	-1082(ra) # 800002ca <safestrcpy>
  pid = np->pid;
    8000170c:	0309aa03          	lw	s4,48(s3)
  release(&np->lock);
    80001710:	854e                	mv	a0,s3
    80001712:	00005097          	auipc	ra,0x5
    80001716:	34e080e7          	jalr	846(ra) # 80006a60 <release>
  acquire(&wait_lock);
    8000171a:	00008497          	auipc	s1,0x8
    8000171e:	94e48493          	addi	s1,s1,-1714 # 80009068 <wait_lock>
    80001722:	8526                	mv	a0,s1
    80001724:	00005097          	auipc	ra,0x5
    80001728:	288080e7          	jalr	648(ra) # 800069ac <acquire>
  np->parent = p;
    8000172c:	0329bc23          	sd	s2,56(s3)
  release(&wait_lock);
    80001730:	8526                	mv	a0,s1
    80001732:	00005097          	auipc	ra,0x5
    80001736:	32e080e7          	jalr	814(ra) # 80006a60 <release>
  acquire(&np->lock);
    8000173a:	854e                	mv	a0,s3
    8000173c:	00005097          	auipc	ra,0x5
    80001740:	270080e7          	jalr	624(ra) # 800069ac <acquire>
  np->state = RUNNABLE;
    80001744:	478d                	li	a5,3
    80001746:	00f9ac23          	sw	a5,24(s3)
  release(&np->lock);
    8000174a:	854e                	mv	a0,s3
    8000174c:	00005097          	auipc	ra,0x5
    80001750:	314080e7          	jalr	788(ra) # 80006a60 <release>
}
    80001754:	8552                	mv	a0,s4
    80001756:	70a2                	ld	ra,40(sp)
    80001758:	7402                	ld	s0,32(sp)
    8000175a:	64e2                	ld	s1,24(sp)
    8000175c:	6942                	ld	s2,16(sp)
    8000175e:	69a2                	ld	s3,8(sp)
    80001760:	6a02                	ld	s4,0(sp)
    80001762:	6145                	addi	sp,sp,48
    80001764:	8082                	ret
    return -1;
    80001766:	5a7d                	li	s4,-1
    80001768:	b7f5                	j	80001754 <fork+0x126>

000000008000176a <scheduler>:
{
    8000176a:	7139                	addi	sp,sp,-64
    8000176c:	fc06                	sd	ra,56(sp)
    8000176e:	f822                	sd	s0,48(sp)
    80001770:	f426                	sd	s1,40(sp)
    80001772:	f04a                	sd	s2,32(sp)
    80001774:	ec4e                	sd	s3,24(sp)
    80001776:	e852                	sd	s4,16(sp)
    80001778:	e456                	sd	s5,8(sp)
    8000177a:	e05a                	sd	s6,0(sp)
    8000177c:	0080                	addi	s0,sp,64
    8000177e:	8792                	mv	a5,tp
  int id = r_tp();
    80001780:	2781                	sext.w	a5,a5
  c->proc = 0;
    80001782:	00779a93          	slli	s5,a5,0x7
    80001786:	00008717          	auipc	a4,0x8
    8000178a:	8ca70713          	addi	a4,a4,-1846 # 80009050 <pid_lock>
    8000178e:	9756                	add	a4,a4,s5
    80001790:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    80001794:	00008717          	auipc	a4,0x8
    80001798:	8f470713          	addi	a4,a4,-1804 # 80009088 <cpus+0x8>
    8000179c:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    8000179e:	498d                	li	s3,3
        p->state = RUNNING;
    800017a0:	4b11                	li	s6,4
        c->proc = p;
    800017a2:	079e                	slli	a5,a5,0x7
    800017a4:	00008a17          	auipc	s4,0x8
    800017a8:	8aca0a13          	addi	s4,s4,-1876 # 80009050 <pid_lock>
    800017ac:	9a3e                	add	s4,s4,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    800017ae:	0000d917          	auipc	s2,0xd
    800017b2:	6d290913          	addi	s2,s2,1746 # 8000ee80 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800017b6:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800017ba:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800017be:	10079073          	csrw	sstatus,a5
    800017c2:	00008497          	auipc	s1,0x8
    800017c6:	cbe48493          	addi	s1,s1,-834 # 80009480 <proc>
    800017ca:	a03d                	j	800017f8 <scheduler+0x8e>
        p->state = RUNNING;
    800017cc:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    800017d0:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    800017d4:	06048593          	addi	a1,s1,96
    800017d8:	8556                	mv	a0,s5
    800017da:	00000097          	auipc	ra,0x0
    800017de:	640080e7          	jalr	1600(ra) # 80001e1a <swtch>
        c->proc = 0;
    800017e2:	020a3823          	sd	zero,48(s4)
      release(&p->lock);
    800017e6:	8526                	mv	a0,s1
    800017e8:	00005097          	auipc	ra,0x5
    800017ec:	278080e7          	jalr	632(ra) # 80006a60 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    800017f0:	16848493          	addi	s1,s1,360
    800017f4:	fd2481e3          	beq	s1,s2,800017b6 <scheduler+0x4c>
      acquire(&p->lock);
    800017f8:	8526                	mv	a0,s1
    800017fa:	00005097          	auipc	ra,0x5
    800017fe:	1b2080e7          	jalr	434(ra) # 800069ac <acquire>
      if(p->state == RUNNABLE) {
    80001802:	4c9c                	lw	a5,24(s1)
    80001804:	ff3791e3          	bne	a5,s3,800017e6 <scheduler+0x7c>
    80001808:	b7d1                	j	800017cc <scheduler+0x62>

000000008000180a <sched>:
{
    8000180a:	7179                	addi	sp,sp,-48
    8000180c:	f406                	sd	ra,40(sp)
    8000180e:	f022                	sd	s0,32(sp)
    80001810:	ec26                	sd	s1,24(sp)
    80001812:	e84a                	sd	s2,16(sp)
    80001814:	e44e                	sd	s3,8(sp)
    80001816:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001818:	00000097          	auipc	ra,0x0
    8000181c:	a48080e7          	jalr	-1464(ra) # 80001260 <myproc>
    80001820:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    80001822:	00005097          	auipc	ra,0x5
    80001826:	110080e7          	jalr	272(ra) # 80006932 <holding>
    8000182a:	c93d                	beqz	a0,800018a0 <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    8000182c:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    8000182e:	2781                	sext.w	a5,a5
    80001830:	079e                	slli	a5,a5,0x7
    80001832:	00008717          	auipc	a4,0x8
    80001836:	81e70713          	addi	a4,a4,-2018 # 80009050 <pid_lock>
    8000183a:	97ba                	add	a5,a5,a4
    8000183c:	0a87a703          	lw	a4,168(a5)
    80001840:	4785                	li	a5,1
    80001842:	06f71763          	bne	a4,a5,800018b0 <sched+0xa6>
  if(p->state == RUNNING)
    80001846:	4c98                	lw	a4,24(s1)
    80001848:	4791                	li	a5,4
    8000184a:	06f70b63          	beq	a4,a5,800018c0 <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000184e:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001852:	8b89                	andi	a5,a5,2
  if(intr_get())
    80001854:	efb5                	bnez	a5,800018d0 <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001856:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80001858:	00007917          	auipc	s2,0x7
    8000185c:	7f890913          	addi	s2,s2,2040 # 80009050 <pid_lock>
    80001860:	2781                	sext.w	a5,a5
    80001862:	079e                	slli	a5,a5,0x7
    80001864:	97ca                	add	a5,a5,s2
    80001866:	0ac7a983          	lw	s3,172(a5)
    8000186a:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    8000186c:	2781                	sext.w	a5,a5
    8000186e:	079e                	slli	a5,a5,0x7
    80001870:	00008597          	auipc	a1,0x8
    80001874:	81858593          	addi	a1,a1,-2024 # 80009088 <cpus+0x8>
    80001878:	95be                	add	a1,a1,a5
    8000187a:	06048513          	addi	a0,s1,96
    8000187e:	00000097          	auipc	ra,0x0
    80001882:	59c080e7          	jalr	1436(ra) # 80001e1a <swtch>
    80001886:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80001888:	2781                	sext.w	a5,a5
    8000188a:	079e                	slli	a5,a5,0x7
    8000188c:	97ca                	add	a5,a5,s2
    8000188e:	0b37a623          	sw	s3,172(a5)
}
    80001892:	70a2                	ld	ra,40(sp)
    80001894:	7402                	ld	s0,32(sp)
    80001896:	64e2                	ld	s1,24(sp)
    80001898:	6942                	ld	s2,16(sp)
    8000189a:	69a2                	ld	s3,8(sp)
    8000189c:	6145                	addi	sp,sp,48
    8000189e:	8082                	ret
    panic("sched p->lock");
    800018a0:	00007517          	auipc	a0,0x7
    800018a4:	9b050513          	addi	a0,a0,-1616 # 80008250 <etext+0x250>
    800018a8:	00005097          	auipc	ra,0x5
    800018ac:	bba080e7          	jalr	-1094(ra) # 80006462 <panic>
    panic("sched locks");
    800018b0:	00007517          	auipc	a0,0x7
    800018b4:	9b050513          	addi	a0,a0,-1616 # 80008260 <etext+0x260>
    800018b8:	00005097          	auipc	ra,0x5
    800018bc:	baa080e7          	jalr	-1110(ra) # 80006462 <panic>
    panic("sched running");
    800018c0:	00007517          	auipc	a0,0x7
    800018c4:	9b050513          	addi	a0,a0,-1616 # 80008270 <etext+0x270>
    800018c8:	00005097          	auipc	ra,0x5
    800018cc:	b9a080e7          	jalr	-1126(ra) # 80006462 <panic>
    panic("sched interruptible");
    800018d0:	00007517          	auipc	a0,0x7
    800018d4:	9b050513          	addi	a0,a0,-1616 # 80008280 <etext+0x280>
    800018d8:	00005097          	auipc	ra,0x5
    800018dc:	b8a080e7          	jalr	-1142(ra) # 80006462 <panic>

00000000800018e0 <yield>:
{
    800018e0:	1101                	addi	sp,sp,-32
    800018e2:	ec06                	sd	ra,24(sp)
    800018e4:	e822                	sd	s0,16(sp)
    800018e6:	e426                	sd	s1,8(sp)
    800018e8:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    800018ea:	00000097          	auipc	ra,0x0
    800018ee:	976080e7          	jalr	-1674(ra) # 80001260 <myproc>
    800018f2:	84aa                	mv	s1,a0
  acquire(&p->lock);
    800018f4:	00005097          	auipc	ra,0x5
    800018f8:	0b8080e7          	jalr	184(ra) # 800069ac <acquire>
  p->state = RUNNABLE;
    800018fc:	478d                	li	a5,3
    800018fe:	cc9c                	sw	a5,24(s1)
  sched();
    80001900:	00000097          	auipc	ra,0x0
    80001904:	f0a080e7          	jalr	-246(ra) # 8000180a <sched>
  release(&p->lock);
    80001908:	8526                	mv	a0,s1
    8000190a:	00005097          	auipc	ra,0x5
    8000190e:	156080e7          	jalr	342(ra) # 80006a60 <release>
}
    80001912:	60e2                	ld	ra,24(sp)
    80001914:	6442                	ld	s0,16(sp)
    80001916:	64a2                	ld	s1,8(sp)
    80001918:	6105                	addi	sp,sp,32
    8000191a:	8082                	ret

000000008000191c <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    8000191c:	7179                	addi	sp,sp,-48
    8000191e:	f406                	sd	ra,40(sp)
    80001920:	f022                	sd	s0,32(sp)
    80001922:	ec26                	sd	s1,24(sp)
    80001924:	e84a                	sd	s2,16(sp)
    80001926:	e44e                	sd	s3,8(sp)
    80001928:	1800                	addi	s0,sp,48
    8000192a:	89aa                	mv	s3,a0
    8000192c:	892e                	mv	s2,a1
  struct proc *p = myproc();
    8000192e:	00000097          	auipc	ra,0x0
    80001932:	932080e7          	jalr	-1742(ra) # 80001260 <myproc>
    80001936:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    80001938:	00005097          	auipc	ra,0x5
    8000193c:	074080e7          	jalr	116(ra) # 800069ac <acquire>
  release(lk);
    80001940:	854a                	mv	a0,s2
    80001942:	00005097          	auipc	ra,0x5
    80001946:	11e080e7          	jalr	286(ra) # 80006a60 <release>

  // Go to sleep.
  p->chan = chan;
    8000194a:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    8000194e:	4789                	li	a5,2
    80001950:	cc9c                	sw	a5,24(s1)

  sched();
    80001952:	00000097          	auipc	ra,0x0
    80001956:	eb8080e7          	jalr	-328(ra) # 8000180a <sched>

  // Tidy up.
  p->chan = 0;
    8000195a:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    8000195e:	8526                	mv	a0,s1
    80001960:	00005097          	auipc	ra,0x5
    80001964:	100080e7          	jalr	256(ra) # 80006a60 <release>
  acquire(lk);
    80001968:	854a                	mv	a0,s2
    8000196a:	00005097          	auipc	ra,0x5
    8000196e:	042080e7          	jalr	66(ra) # 800069ac <acquire>
}
    80001972:	70a2                	ld	ra,40(sp)
    80001974:	7402                	ld	s0,32(sp)
    80001976:	64e2                	ld	s1,24(sp)
    80001978:	6942                	ld	s2,16(sp)
    8000197a:	69a2                	ld	s3,8(sp)
    8000197c:	6145                	addi	sp,sp,48
    8000197e:	8082                	ret

0000000080001980 <wait>:
{
    80001980:	715d                	addi	sp,sp,-80
    80001982:	e486                	sd	ra,72(sp)
    80001984:	e0a2                	sd	s0,64(sp)
    80001986:	fc26                	sd	s1,56(sp)
    80001988:	f84a                	sd	s2,48(sp)
    8000198a:	f44e                	sd	s3,40(sp)
    8000198c:	f052                	sd	s4,32(sp)
    8000198e:	ec56                	sd	s5,24(sp)
    80001990:	e85a                	sd	s6,16(sp)
    80001992:	e45e                	sd	s7,8(sp)
    80001994:	e062                	sd	s8,0(sp)
    80001996:	0880                	addi	s0,sp,80
    80001998:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    8000199a:	00000097          	auipc	ra,0x0
    8000199e:	8c6080e7          	jalr	-1850(ra) # 80001260 <myproc>
    800019a2:	892a                	mv	s2,a0
  acquire(&wait_lock);
    800019a4:	00007517          	auipc	a0,0x7
    800019a8:	6c450513          	addi	a0,a0,1732 # 80009068 <wait_lock>
    800019ac:	00005097          	auipc	ra,0x5
    800019b0:	000080e7          	jalr	ra # 800069ac <acquire>
    havekids = 0;
    800019b4:	4b81                	li	s7,0
        if(np->state == ZOMBIE){
    800019b6:	4a15                	li	s4,5
    for(np = proc; np < &proc[NPROC]; np++){
    800019b8:	0000d997          	auipc	s3,0xd
    800019bc:	4c898993          	addi	s3,s3,1224 # 8000ee80 <tickslock>
        havekids = 1;
    800019c0:	4a85                	li	s5,1
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800019c2:	00007c17          	auipc	s8,0x7
    800019c6:	6a6c0c13          	addi	s8,s8,1702 # 80009068 <wait_lock>
    havekids = 0;
    800019ca:	875e                	mv	a4,s7
    for(np = proc; np < &proc[NPROC]; np++){
    800019cc:	00008497          	auipc	s1,0x8
    800019d0:	ab448493          	addi	s1,s1,-1356 # 80009480 <proc>
    800019d4:	a0bd                	j	80001a42 <wait+0xc2>
          pid = np->pid;
    800019d6:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    800019da:	000b0e63          	beqz	s6,800019f6 <wait+0x76>
    800019de:	4691                	li	a3,4
    800019e0:	02c48613          	addi	a2,s1,44
    800019e4:	85da                	mv	a1,s6
    800019e6:	05093503          	ld	a0,80(s2)
    800019ea:	fffff097          	auipc	ra,0xfffff
    800019ee:	118080e7          	jalr	280(ra) # 80000b02 <copyout>
    800019f2:	02054563          	bltz	a0,80001a1c <wait+0x9c>
          freeproc(np);
    800019f6:	8526                	mv	a0,s1
    800019f8:	00000097          	auipc	ra,0x0
    800019fc:	a1a080e7          	jalr	-1510(ra) # 80001412 <freeproc>
          release(&np->lock);
    80001a00:	8526                	mv	a0,s1
    80001a02:	00005097          	auipc	ra,0x5
    80001a06:	05e080e7          	jalr	94(ra) # 80006a60 <release>
          release(&wait_lock);
    80001a0a:	00007517          	auipc	a0,0x7
    80001a0e:	65e50513          	addi	a0,a0,1630 # 80009068 <wait_lock>
    80001a12:	00005097          	auipc	ra,0x5
    80001a16:	04e080e7          	jalr	78(ra) # 80006a60 <release>
          return pid;
    80001a1a:	a09d                	j	80001a80 <wait+0x100>
            release(&np->lock);
    80001a1c:	8526                	mv	a0,s1
    80001a1e:	00005097          	auipc	ra,0x5
    80001a22:	042080e7          	jalr	66(ra) # 80006a60 <release>
            release(&wait_lock);
    80001a26:	00007517          	auipc	a0,0x7
    80001a2a:	64250513          	addi	a0,a0,1602 # 80009068 <wait_lock>
    80001a2e:	00005097          	auipc	ra,0x5
    80001a32:	032080e7          	jalr	50(ra) # 80006a60 <release>
            return -1;
    80001a36:	59fd                	li	s3,-1
    80001a38:	a0a1                	j	80001a80 <wait+0x100>
    for(np = proc; np < &proc[NPROC]; np++){
    80001a3a:	16848493          	addi	s1,s1,360
    80001a3e:	03348463          	beq	s1,s3,80001a66 <wait+0xe6>
      if(np->parent == p){
    80001a42:	7c9c                	ld	a5,56(s1)
    80001a44:	ff279be3          	bne	a5,s2,80001a3a <wait+0xba>
        acquire(&np->lock);
    80001a48:	8526                	mv	a0,s1
    80001a4a:	00005097          	auipc	ra,0x5
    80001a4e:	f62080e7          	jalr	-158(ra) # 800069ac <acquire>
        if(np->state == ZOMBIE){
    80001a52:	4c9c                	lw	a5,24(s1)
    80001a54:	f94781e3          	beq	a5,s4,800019d6 <wait+0x56>
        release(&np->lock);
    80001a58:	8526                	mv	a0,s1
    80001a5a:	00005097          	auipc	ra,0x5
    80001a5e:	006080e7          	jalr	6(ra) # 80006a60 <release>
        havekids = 1;
    80001a62:	8756                	mv	a4,s5
    80001a64:	bfd9                	j	80001a3a <wait+0xba>
    if(!havekids || p->killed){
    80001a66:	c701                	beqz	a4,80001a6e <wait+0xee>
    80001a68:	02892783          	lw	a5,40(s2)
    80001a6c:	c79d                	beqz	a5,80001a9a <wait+0x11a>
      release(&wait_lock);
    80001a6e:	00007517          	auipc	a0,0x7
    80001a72:	5fa50513          	addi	a0,a0,1530 # 80009068 <wait_lock>
    80001a76:	00005097          	auipc	ra,0x5
    80001a7a:	fea080e7          	jalr	-22(ra) # 80006a60 <release>
      return -1;
    80001a7e:	59fd                	li	s3,-1
}
    80001a80:	854e                	mv	a0,s3
    80001a82:	60a6                	ld	ra,72(sp)
    80001a84:	6406                	ld	s0,64(sp)
    80001a86:	74e2                	ld	s1,56(sp)
    80001a88:	7942                	ld	s2,48(sp)
    80001a8a:	79a2                	ld	s3,40(sp)
    80001a8c:	7a02                	ld	s4,32(sp)
    80001a8e:	6ae2                	ld	s5,24(sp)
    80001a90:	6b42                	ld	s6,16(sp)
    80001a92:	6ba2                	ld	s7,8(sp)
    80001a94:	6c02                	ld	s8,0(sp)
    80001a96:	6161                	addi	sp,sp,80
    80001a98:	8082                	ret
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001a9a:	85e2                	mv	a1,s8
    80001a9c:	854a                	mv	a0,s2
    80001a9e:	00000097          	auipc	ra,0x0
    80001aa2:	e7e080e7          	jalr	-386(ra) # 8000191c <sleep>
    havekids = 0;
    80001aa6:	b715                	j	800019ca <wait+0x4a>

0000000080001aa8 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    80001aa8:	7139                	addi	sp,sp,-64
    80001aaa:	fc06                	sd	ra,56(sp)
    80001aac:	f822                	sd	s0,48(sp)
    80001aae:	f426                	sd	s1,40(sp)
    80001ab0:	f04a                	sd	s2,32(sp)
    80001ab2:	ec4e                	sd	s3,24(sp)
    80001ab4:	e852                	sd	s4,16(sp)
    80001ab6:	e456                	sd	s5,8(sp)
    80001ab8:	0080                	addi	s0,sp,64
    80001aba:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    80001abc:	00008497          	auipc	s1,0x8
    80001ac0:	9c448493          	addi	s1,s1,-1596 # 80009480 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    80001ac4:	4989                	li	s3,2
        p->state = RUNNABLE;
    80001ac6:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    80001ac8:	0000d917          	auipc	s2,0xd
    80001acc:	3b890913          	addi	s2,s2,952 # 8000ee80 <tickslock>
    80001ad0:	a821                	j	80001ae8 <wakeup+0x40>
        p->state = RUNNABLE;
    80001ad2:	0154ac23          	sw	s5,24(s1)
      }
      release(&p->lock);
    80001ad6:	8526                	mv	a0,s1
    80001ad8:	00005097          	auipc	ra,0x5
    80001adc:	f88080e7          	jalr	-120(ra) # 80006a60 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001ae0:	16848493          	addi	s1,s1,360
    80001ae4:	03248463          	beq	s1,s2,80001b0c <wakeup+0x64>
    if(p != myproc()){
    80001ae8:	fffff097          	auipc	ra,0xfffff
    80001aec:	778080e7          	jalr	1912(ra) # 80001260 <myproc>
    80001af0:	fea488e3          	beq	s1,a0,80001ae0 <wakeup+0x38>
      acquire(&p->lock);
    80001af4:	8526                	mv	a0,s1
    80001af6:	00005097          	auipc	ra,0x5
    80001afa:	eb6080e7          	jalr	-330(ra) # 800069ac <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    80001afe:	4c9c                	lw	a5,24(s1)
    80001b00:	fd379be3          	bne	a5,s3,80001ad6 <wakeup+0x2e>
    80001b04:	709c                	ld	a5,32(s1)
    80001b06:	fd4798e3          	bne	a5,s4,80001ad6 <wakeup+0x2e>
    80001b0a:	b7e1                	j	80001ad2 <wakeup+0x2a>
    }
  }
}
    80001b0c:	70e2                	ld	ra,56(sp)
    80001b0e:	7442                	ld	s0,48(sp)
    80001b10:	74a2                	ld	s1,40(sp)
    80001b12:	7902                	ld	s2,32(sp)
    80001b14:	69e2                	ld	s3,24(sp)
    80001b16:	6a42                	ld	s4,16(sp)
    80001b18:	6aa2                	ld	s5,8(sp)
    80001b1a:	6121                	addi	sp,sp,64
    80001b1c:	8082                	ret

0000000080001b1e <reparent>:
{
    80001b1e:	7179                	addi	sp,sp,-48
    80001b20:	f406                	sd	ra,40(sp)
    80001b22:	f022                	sd	s0,32(sp)
    80001b24:	ec26                	sd	s1,24(sp)
    80001b26:	e84a                	sd	s2,16(sp)
    80001b28:	e44e                	sd	s3,8(sp)
    80001b2a:	e052                	sd	s4,0(sp)
    80001b2c:	1800                	addi	s0,sp,48
    80001b2e:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001b30:	00008497          	auipc	s1,0x8
    80001b34:	95048493          	addi	s1,s1,-1712 # 80009480 <proc>
      pp->parent = initproc;
    80001b38:	00007a17          	auipc	s4,0x7
    80001b3c:	4d8a0a13          	addi	s4,s4,1240 # 80009010 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001b40:	0000d997          	auipc	s3,0xd
    80001b44:	34098993          	addi	s3,s3,832 # 8000ee80 <tickslock>
    80001b48:	a029                	j	80001b52 <reparent+0x34>
    80001b4a:	16848493          	addi	s1,s1,360
    80001b4e:	01348d63          	beq	s1,s3,80001b68 <reparent+0x4a>
    if(pp->parent == p){
    80001b52:	7c9c                	ld	a5,56(s1)
    80001b54:	ff279be3          	bne	a5,s2,80001b4a <reparent+0x2c>
      pp->parent = initproc;
    80001b58:	000a3503          	ld	a0,0(s4)
    80001b5c:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    80001b5e:	00000097          	auipc	ra,0x0
    80001b62:	f4a080e7          	jalr	-182(ra) # 80001aa8 <wakeup>
    80001b66:	b7d5                	j	80001b4a <reparent+0x2c>
}
    80001b68:	70a2                	ld	ra,40(sp)
    80001b6a:	7402                	ld	s0,32(sp)
    80001b6c:	64e2                	ld	s1,24(sp)
    80001b6e:	6942                	ld	s2,16(sp)
    80001b70:	69a2                	ld	s3,8(sp)
    80001b72:	6a02                	ld	s4,0(sp)
    80001b74:	6145                	addi	sp,sp,48
    80001b76:	8082                	ret

0000000080001b78 <exit>:
{
    80001b78:	7179                	addi	sp,sp,-48
    80001b7a:	f406                	sd	ra,40(sp)
    80001b7c:	f022                	sd	s0,32(sp)
    80001b7e:	ec26                	sd	s1,24(sp)
    80001b80:	e84a                	sd	s2,16(sp)
    80001b82:	e44e                	sd	s3,8(sp)
    80001b84:	e052                	sd	s4,0(sp)
    80001b86:	1800                	addi	s0,sp,48
    80001b88:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    80001b8a:	fffff097          	auipc	ra,0xfffff
    80001b8e:	6d6080e7          	jalr	1750(ra) # 80001260 <myproc>
    80001b92:	89aa                	mv	s3,a0
  if(p == initproc)
    80001b94:	00007797          	auipc	a5,0x7
    80001b98:	47c7b783          	ld	a5,1148(a5) # 80009010 <initproc>
    80001b9c:	0d050493          	addi	s1,a0,208
    80001ba0:	15050913          	addi	s2,a0,336
    80001ba4:	02a79363          	bne	a5,a0,80001bca <exit+0x52>
    panic("init exiting");
    80001ba8:	00006517          	auipc	a0,0x6
    80001bac:	6f050513          	addi	a0,a0,1776 # 80008298 <etext+0x298>
    80001bb0:	00005097          	auipc	ra,0x5
    80001bb4:	8b2080e7          	jalr	-1870(ra) # 80006462 <panic>
      fileclose(f);
    80001bb8:	00002097          	auipc	ra,0x2
    80001bbc:	3ce080e7          	jalr	974(ra) # 80003f86 <fileclose>
      p->ofile[fd] = 0;
    80001bc0:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    80001bc4:	04a1                	addi	s1,s1,8
    80001bc6:	01248563          	beq	s1,s2,80001bd0 <exit+0x58>
    if(p->ofile[fd]){
    80001bca:	6088                	ld	a0,0(s1)
    80001bcc:	f575                	bnez	a0,80001bb8 <exit+0x40>
    80001bce:	bfdd                	j	80001bc4 <exit+0x4c>
  begin_op();
    80001bd0:	00002097          	auipc	ra,0x2
    80001bd4:	eea080e7          	jalr	-278(ra) # 80003aba <begin_op>
  iput(p->cwd);
    80001bd8:	1509b503          	ld	a0,336(s3)
    80001bdc:	00001097          	auipc	ra,0x1
    80001be0:	53e080e7          	jalr	1342(ra) # 8000311a <iput>
  end_op();
    80001be4:	00002097          	auipc	ra,0x2
    80001be8:	f56080e7          	jalr	-170(ra) # 80003b3a <end_op>
  p->cwd = 0;
    80001bec:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    80001bf0:	00007497          	auipc	s1,0x7
    80001bf4:	47848493          	addi	s1,s1,1144 # 80009068 <wait_lock>
    80001bf8:	8526                	mv	a0,s1
    80001bfa:	00005097          	auipc	ra,0x5
    80001bfe:	db2080e7          	jalr	-590(ra) # 800069ac <acquire>
  reparent(p);
    80001c02:	854e                	mv	a0,s3
    80001c04:	00000097          	auipc	ra,0x0
    80001c08:	f1a080e7          	jalr	-230(ra) # 80001b1e <reparent>
  wakeup(p->parent);
    80001c0c:	0389b503          	ld	a0,56(s3)
    80001c10:	00000097          	auipc	ra,0x0
    80001c14:	e98080e7          	jalr	-360(ra) # 80001aa8 <wakeup>
  acquire(&p->lock);
    80001c18:	854e                	mv	a0,s3
    80001c1a:	00005097          	auipc	ra,0x5
    80001c1e:	d92080e7          	jalr	-622(ra) # 800069ac <acquire>
  p->xstate = status;
    80001c22:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    80001c26:	4795                	li	a5,5
    80001c28:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    80001c2c:	8526                	mv	a0,s1
    80001c2e:	00005097          	auipc	ra,0x5
    80001c32:	e32080e7          	jalr	-462(ra) # 80006a60 <release>
  sched();
    80001c36:	00000097          	auipc	ra,0x0
    80001c3a:	bd4080e7          	jalr	-1068(ra) # 8000180a <sched>
  panic("zombie exit");
    80001c3e:	00006517          	auipc	a0,0x6
    80001c42:	66a50513          	addi	a0,a0,1642 # 800082a8 <etext+0x2a8>
    80001c46:	00005097          	auipc	ra,0x5
    80001c4a:	81c080e7          	jalr	-2020(ra) # 80006462 <panic>

0000000080001c4e <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80001c4e:	7179                	addi	sp,sp,-48
    80001c50:	f406                	sd	ra,40(sp)
    80001c52:	f022                	sd	s0,32(sp)
    80001c54:	ec26                	sd	s1,24(sp)
    80001c56:	e84a                	sd	s2,16(sp)
    80001c58:	e44e                	sd	s3,8(sp)
    80001c5a:	1800                	addi	s0,sp,48
    80001c5c:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80001c5e:	00008497          	auipc	s1,0x8
    80001c62:	82248493          	addi	s1,s1,-2014 # 80009480 <proc>
    80001c66:	0000d997          	auipc	s3,0xd
    80001c6a:	21a98993          	addi	s3,s3,538 # 8000ee80 <tickslock>
    acquire(&p->lock);
    80001c6e:	8526                	mv	a0,s1
    80001c70:	00005097          	auipc	ra,0x5
    80001c74:	d3c080e7          	jalr	-708(ra) # 800069ac <acquire>
    if(p->pid == pid){
    80001c78:	589c                	lw	a5,48(s1)
    80001c7a:	01278d63          	beq	a5,s2,80001c94 <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80001c7e:	8526                	mv	a0,s1
    80001c80:	00005097          	auipc	ra,0x5
    80001c84:	de0080e7          	jalr	-544(ra) # 80006a60 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80001c88:	16848493          	addi	s1,s1,360
    80001c8c:	ff3491e3          	bne	s1,s3,80001c6e <kill+0x20>
  }
  return -1;
    80001c90:	557d                	li	a0,-1
    80001c92:	a829                	j	80001cac <kill+0x5e>
      p->killed = 1;
    80001c94:	4785                	li	a5,1
    80001c96:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    80001c98:	4c98                	lw	a4,24(s1)
    80001c9a:	4789                	li	a5,2
    80001c9c:	00f70f63          	beq	a4,a5,80001cba <kill+0x6c>
      release(&p->lock);
    80001ca0:	8526                	mv	a0,s1
    80001ca2:	00005097          	auipc	ra,0x5
    80001ca6:	dbe080e7          	jalr	-578(ra) # 80006a60 <release>
      return 0;
    80001caa:	4501                	li	a0,0
}
    80001cac:	70a2                	ld	ra,40(sp)
    80001cae:	7402                	ld	s0,32(sp)
    80001cb0:	64e2                	ld	s1,24(sp)
    80001cb2:	6942                	ld	s2,16(sp)
    80001cb4:	69a2                	ld	s3,8(sp)
    80001cb6:	6145                	addi	sp,sp,48
    80001cb8:	8082                	ret
        p->state = RUNNABLE;
    80001cba:	478d                	li	a5,3
    80001cbc:	cc9c                	sw	a5,24(s1)
    80001cbe:	b7cd                	j	80001ca0 <kill+0x52>

0000000080001cc0 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80001cc0:	7179                	addi	sp,sp,-48
    80001cc2:	f406                	sd	ra,40(sp)
    80001cc4:	f022                	sd	s0,32(sp)
    80001cc6:	ec26                	sd	s1,24(sp)
    80001cc8:	e84a                	sd	s2,16(sp)
    80001cca:	e44e                	sd	s3,8(sp)
    80001ccc:	e052                	sd	s4,0(sp)
    80001cce:	1800                	addi	s0,sp,48
    80001cd0:	84aa                	mv	s1,a0
    80001cd2:	892e                	mv	s2,a1
    80001cd4:	89b2                	mv	s3,a2
    80001cd6:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001cd8:	fffff097          	auipc	ra,0xfffff
    80001cdc:	588080e7          	jalr	1416(ra) # 80001260 <myproc>
  if(user_dst){
    80001ce0:	c08d                	beqz	s1,80001d02 <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    80001ce2:	86d2                	mv	a3,s4
    80001ce4:	864e                	mv	a2,s3
    80001ce6:	85ca                	mv	a1,s2
    80001ce8:	6928                	ld	a0,80(a0)
    80001cea:	fffff097          	auipc	ra,0xfffff
    80001cee:	e18080e7          	jalr	-488(ra) # 80000b02 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    80001cf2:	70a2                	ld	ra,40(sp)
    80001cf4:	7402                	ld	s0,32(sp)
    80001cf6:	64e2                	ld	s1,24(sp)
    80001cf8:	6942                	ld	s2,16(sp)
    80001cfa:	69a2                	ld	s3,8(sp)
    80001cfc:	6a02                	ld	s4,0(sp)
    80001cfe:	6145                	addi	sp,sp,48
    80001d00:	8082                	ret
    memmove((char *)dst, src, len);
    80001d02:	000a061b          	sext.w	a2,s4
    80001d06:	85ce                	mv	a1,s3
    80001d08:	854a                	mv	a0,s2
    80001d0a:	ffffe097          	auipc	ra,0xffffe
    80001d0e:	4ce080e7          	jalr	1230(ra) # 800001d8 <memmove>
    return 0;
    80001d12:	8526                	mv	a0,s1
    80001d14:	bff9                	j	80001cf2 <either_copyout+0x32>

0000000080001d16 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80001d16:	7179                	addi	sp,sp,-48
    80001d18:	f406                	sd	ra,40(sp)
    80001d1a:	f022                	sd	s0,32(sp)
    80001d1c:	ec26                	sd	s1,24(sp)
    80001d1e:	e84a                	sd	s2,16(sp)
    80001d20:	e44e                	sd	s3,8(sp)
    80001d22:	e052                	sd	s4,0(sp)
    80001d24:	1800                	addi	s0,sp,48
    80001d26:	892a                	mv	s2,a0
    80001d28:	84ae                	mv	s1,a1
    80001d2a:	89b2                	mv	s3,a2
    80001d2c:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001d2e:	fffff097          	auipc	ra,0xfffff
    80001d32:	532080e7          	jalr	1330(ra) # 80001260 <myproc>
  if(user_src){
    80001d36:	c08d                	beqz	s1,80001d58 <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    80001d38:	86d2                	mv	a3,s4
    80001d3a:	864e                	mv	a2,s3
    80001d3c:	85ca                	mv	a1,s2
    80001d3e:	6928                	ld	a0,80(a0)
    80001d40:	fffff097          	auipc	ra,0xfffff
    80001d44:	e4e080e7          	jalr	-434(ra) # 80000b8e <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80001d48:	70a2                	ld	ra,40(sp)
    80001d4a:	7402                	ld	s0,32(sp)
    80001d4c:	64e2                	ld	s1,24(sp)
    80001d4e:	6942                	ld	s2,16(sp)
    80001d50:	69a2                	ld	s3,8(sp)
    80001d52:	6a02                	ld	s4,0(sp)
    80001d54:	6145                	addi	sp,sp,48
    80001d56:	8082                	ret
    memmove(dst, (char*)src, len);
    80001d58:	000a061b          	sext.w	a2,s4
    80001d5c:	85ce                	mv	a1,s3
    80001d5e:	854a                	mv	a0,s2
    80001d60:	ffffe097          	auipc	ra,0xffffe
    80001d64:	478080e7          	jalr	1144(ra) # 800001d8 <memmove>
    return 0;
    80001d68:	8526                	mv	a0,s1
    80001d6a:	bff9                	j	80001d48 <either_copyin+0x32>

0000000080001d6c <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80001d6c:	715d                	addi	sp,sp,-80
    80001d6e:	e486                	sd	ra,72(sp)
    80001d70:	e0a2                	sd	s0,64(sp)
    80001d72:	fc26                	sd	s1,56(sp)
    80001d74:	f84a                	sd	s2,48(sp)
    80001d76:	f44e                	sd	s3,40(sp)
    80001d78:	f052                	sd	s4,32(sp)
    80001d7a:	ec56                	sd	s5,24(sp)
    80001d7c:	e85a                	sd	s6,16(sp)
    80001d7e:	e45e                	sd	s7,8(sp)
    80001d80:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80001d82:	00006517          	auipc	a0,0x6
    80001d86:	2c650513          	addi	a0,a0,710 # 80008048 <etext+0x48>
    80001d8a:	00004097          	auipc	ra,0x4
    80001d8e:	722080e7          	jalr	1826(ra) # 800064ac <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001d92:	00008497          	auipc	s1,0x8
    80001d96:	84648493          	addi	s1,s1,-1978 # 800095d8 <proc+0x158>
    80001d9a:	0000d917          	auipc	s2,0xd
    80001d9e:	23e90913          	addi	s2,s2,574 # 8000efd8 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001da2:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80001da4:	00006997          	auipc	s3,0x6
    80001da8:	51498993          	addi	s3,s3,1300 # 800082b8 <etext+0x2b8>
    printf("%d %s %s", p->pid, state, p->name);
    80001dac:	00006a97          	auipc	s5,0x6
    80001db0:	514a8a93          	addi	s5,s5,1300 # 800082c0 <etext+0x2c0>
    printf("\n");
    80001db4:	00006a17          	auipc	s4,0x6
    80001db8:	294a0a13          	addi	s4,s4,660 # 80008048 <etext+0x48>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001dbc:	00006b97          	auipc	s7,0x6
    80001dc0:	53cb8b93          	addi	s7,s7,1340 # 800082f8 <states.1805>
    80001dc4:	a00d                	j	80001de6 <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    80001dc6:	ed86a583          	lw	a1,-296(a3)
    80001dca:	8556                	mv	a0,s5
    80001dcc:	00004097          	auipc	ra,0x4
    80001dd0:	6e0080e7          	jalr	1760(ra) # 800064ac <printf>
    printf("\n");
    80001dd4:	8552                	mv	a0,s4
    80001dd6:	00004097          	auipc	ra,0x4
    80001dda:	6d6080e7          	jalr	1750(ra) # 800064ac <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001dde:	16848493          	addi	s1,s1,360
    80001de2:	03248163          	beq	s1,s2,80001e04 <procdump+0x98>
    if(p->state == UNUSED)
    80001de6:	86a6                	mv	a3,s1
    80001de8:	ec04a783          	lw	a5,-320(s1)
    80001dec:	dbed                	beqz	a5,80001dde <procdump+0x72>
      state = "???";
    80001dee:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001df0:	fcfb6be3          	bltu	s6,a5,80001dc6 <procdump+0x5a>
    80001df4:	1782                	slli	a5,a5,0x20
    80001df6:	9381                	srli	a5,a5,0x20
    80001df8:	078e                	slli	a5,a5,0x3
    80001dfa:	97de                	add	a5,a5,s7
    80001dfc:	6390                	ld	a2,0(a5)
    80001dfe:	f661                	bnez	a2,80001dc6 <procdump+0x5a>
      state = "???";
    80001e00:	864e                	mv	a2,s3
    80001e02:	b7d1                	j	80001dc6 <procdump+0x5a>
  }
}
    80001e04:	60a6                	ld	ra,72(sp)
    80001e06:	6406                	ld	s0,64(sp)
    80001e08:	74e2                	ld	s1,56(sp)
    80001e0a:	7942                	ld	s2,48(sp)
    80001e0c:	79a2                	ld	s3,40(sp)
    80001e0e:	7a02                	ld	s4,32(sp)
    80001e10:	6ae2                	ld	s5,24(sp)
    80001e12:	6b42                	ld	s6,16(sp)
    80001e14:	6ba2                	ld	s7,8(sp)
    80001e16:	6161                	addi	sp,sp,80
    80001e18:	8082                	ret

0000000080001e1a <swtch>:
    80001e1a:	00153023          	sd	ra,0(a0)
    80001e1e:	00253423          	sd	sp,8(a0)
    80001e22:	e900                	sd	s0,16(a0)
    80001e24:	ed04                	sd	s1,24(a0)
    80001e26:	03253023          	sd	s2,32(a0)
    80001e2a:	03353423          	sd	s3,40(a0)
    80001e2e:	03453823          	sd	s4,48(a0)
    80001e32:	03553c23          	sd	s5,56(a0)
    80001e36:	05653023          	sd	s6,64(a0)
    80001e3a:	05753423          	sd	s7,72(a0)
    80001e3e:	05853823          	sd	s8,80(a0)
    80001e42:	05953c23          	sd	s9,88(a0)
    80001e46:	07a53023          	sd	s10,96(a0)
    80001e4a:	07b53423          	sd	s11,104(a0)
    80001e4e:	0005b083          	ld	ra,0(a1)
    80001e52:	0085b103          	ld	sp,8(a1)
    80001e56:	6980                	ld	s0,16(a1)
    80001e58:	6d84                	ld	s1,24(a1)
    80001e5a:	0205b903          	ld	s2,32(a1)
    80001e5e:	0285b983          	ld	s3,40(a1)
    80001e62:	0305ba03          	ld	s4,48(a1)
    80001e66:	0385ba83          	ld	s5,56(a1)
    80001e6a:	0405bb03          	ld	s6,64(a1)
    80001e6e:	0485bb83          	ld	s7,72(a1)
    80001e72:	0505bc03          	ld	s8,80(a1)
    80001e76:	0585bc83          	ld	s9,88(a1)
    80001e7a:	0605bd03          	ld	s10,96(a1)
    80001e7e:	0685bd83          	ld	s11,104(a1)
    80001e82:	8082                	ret

0000000080001e84 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001e84:	1141                	addi	sp,sp,-16
    80001e86:	e406                	sd	ra,8(sp)
    80001e88:	e022                	sd	s0,0(sp)
    80001e8a:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001e8c:	00006597          	auipc	a1,0x6
    80001e90:	49c58593          	addi	a1,a1,1180 # 80008328 <states.1805+0x30>
    80001e94:	0000d517          	auipc	a0,0xd
    80001e98:	fec50513          	addi	a0,a0,-20 # 8000ee80 <tickslock>
    80001e9c:	00005097          	auipc	ra,0x5
    80001ea0:	a80080e7          	jalr	-1408(ra) # 8000691c <initlock>
}
    80001ea4:	60a2                	ld	ra,8(sp)
    80001ea6:	6402                	ld	s0,0(sp)
    80001ea8:	0141                	addi	sp,sp,16
    80001eaa:	8082                	ret

0000000080001eac <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001eac:	1141                	addi	sp,sp,-16
    80001eae:	e422                	sd	s0,8(sp)
    80001eb0:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001eb2:	00003797          	auipc	a5,0x3
    80001eb6:	6ee78793          	addi	a5,a5,1774 # 800055a0 <kernelvec>
    80001eba:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001ebe:	6422                	ld	s0,8(sp)
    80001ec0:	0141                	addi	sp,sp,16
    80001ec2:	8082                	ret

0000000080001ec4 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80001ec4:	1141                	addi	sp,sp,-16
    80001ec6:	e406                	sd	ra,8(sp)
    80001ec8:	e022                	sd	s0,0(sp)
    80001eca:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80001ecc:	fffff097          	auipc	ra,0xfffff
    80001ed0:	394080e7          	jalr	916(ra) # 80001260 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001ed4:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001ed8:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001eda:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    80001ede:	00005617          	auipc	a2,0x5
    80001ee2:	12260613          	addi	a2,a2,290 # 80007000 <_trampoline>
    80001ee6:	00005697          	auipc	a3,0x5
    80001eea:	11a68693          	addi	a3,a3,282 # 80007000 <_trampoline>
    80001eee:	8e91                	sub	a3,a3,a2
    80001ef0:	040007b7          	lui	a5,0x4000
    80001ef4:	17fd                	addi	a5,a5,-1
    80001ef6:	07b2                	slli	a5,a5,0xc
    80001ef8:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001efa:	10569073          	csrw	stvec,a3

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80001efe:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80001f00:	180026f3          	csrr	a3,satp
    80001f04:	e314                	sd	a3,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80001f06:	6d38                	ld	a4,88(a0)
    80001f08:	6134                	ld	a3,64(a0)
    80001f0a:	6585                	lui	a1,0x1
    80001f0c:	96ae                	add	a3,a3,a1
    80001f0e:	e714                	sd	a3,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80001f10:	6d38                	ld	a4,88(a0)
    80001f12:	00000697          	auipc	a3,0x0
    80001f16:	13868693          	addi	a3,a3,312 # 8000204a <usertrap>
    80001f1a:	eb14                	sd	a3,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80001f1c:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80001f1e:	8692                	mv	a3,tp
    80001f20:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001f22:	100026f3          	csrr	a3,sstatus

  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80001f26:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80001f2a:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001f2e:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001f32:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001f34:	6f18                	ld	a4,24(a4)
    80001f36:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80001f3a:	692c                	ld	a1,80(a0)
    80001f3c:	81b1                	srli	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    80001f3e:	00005717          	auipc	a4,0x5
    80001f42:	15270713          	addi	a4,a4,338 # 80007090 <userret>
    80001f46:	8f11                	sub	a4,a4,a2
    80001f48:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80001f4a:	577d                	li	a4,-1
    80001f4c:	177e                	slli	a4,a4,0x3f
    80001f4e:	8dd9                	or	a1,a1,a4
    80001f50:	02000537          	lui	a0,0x2000
    80001f54:	157d                	addi	a0,a0,-1
    80001f56:	0536                	slli	a0,a0,0xd
    80001f58:	9782                	jalr	a5
}
    80001f5a:	60a2                	ld	ra,8(sp)
    80001f5c:	6402                	ld	s0,0(sp)
    80001f5e:	0141                	addi	sp,sp,16
    80001f60:	8082                	ret

0000000080001f62 <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80001f62:	1101                	addi	sp,sp,-32
    80001f64:	ec06                	sd	ra,24(sp)
    80001f66:	e822                	sd	s0,16(sp)
    80001f68:	e426                	sd	s1,8(sp)
    80001f6a:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    80001f6c:	0000d497          	auipc	s1,0xd
    80001f70:	f1448493          	addi	s1,s1,-236 # 8000ee80 <tickslock>
    80001f74:	8526                	mv	a0,s1
    80001f76:	00005097          	auipc	ra,0x5
    80001f7a:	a36080e7          	jalr	-1482(ra) # 800069ac <acquire>
  ticks++;
    80001f7e:	00007517          	auipc	a0,0x7
    80001f82:	09a50513          	addi	a0,a0,154 # 80009018 <ticks>
    80001f86:	411c                	lw	a5,0(a0)
    80001f88:	2785                	addiw	a5,a5,1
    80001f8a:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80001f8c:	00000097          	auipc	ra,0x0
    80001f90:	b1c080e7          	jalr	-1252(ra) # 80001aa8 <wakeup>
  release(&tickslock);
    80001f94:	8526                	mv	a0,s1
    80001f96:	00005097          	auipc	ra,0x5
    80001f9a:	aca080e7          	jalr	-1334(ra) # 80006a60 <release>
}
    80001f9e:	60e2                	ld	ra,24(sp)
    80001fa0:	6442                	ld	s0,16(sp)
    80001fa2:	64a2                	ld	s1,8(sp)
    80001fa4:	6105                	addi	sp,sp,32
    80001fa6:	8082                	ret

0000000080001fa8 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80001fa8:	1101                	addi	sp,sp,-32
    80001faa:	ec06                	sd	ra,24(sp)
    80001fac:	e822                	sd	s0,16(sp)
    80001fae:	e426                	sd	s1,8(sp)
    80001fb0:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001fb2:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    80001fb6:	00074d63          	bltz	a4,80001fd0 <devintr+0x28>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000001L){
    80001fba:	57fd                	li	a5,-1
    80001fbc:	17fe                	slli	a5,a5,0x3f
    80001fbe:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80001fc0:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80001fc2:	06f70363          	beq	a4,a5,80002028 <devintr+0x80>
  }
}
    80001fc6:	60e2                	ld	ra,24(sp)
    80001fc8:	6442                	ld	s0,16(sp)
    80001fca:	64a2                	ld	s1,8(sp)
    80001fcc:	6105                	addi	sp,sp,32
    80001fce:	8082                	ret
     (scause & 0xff) == 9){
    80001fd0:	0ff77793          	andi	a5,a4,255
  if((scause & 0x8000000000000000L) &&
    80001fd4:	46a5                	li	a3,9
    80001fd6:	fed792e3          	bne	a5,a3,80001fba <devintr+0x12>
    int irq = plic_claim();
    80001fda:	00003097          	auipc	ra,0x3
    80001fde:	6ce080e7          	jalr	1742(ra) # 800056a8 <plic_claim>
    80001fe2:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80001fe4:	47a9                	li	a5,10
    80001fe6:	02f50763          	beq	a0,a5,80002014 <devintr+0x6c>
    } else if(irq == VIRTIO0_IRQ){
    80001fea:	4785                	li	a5,1
    80001fec:	02f50963          	beq	a0,a5,8000201e <devintr+0x76>
    return 1;
    80001ff0:	4505                	li	a0,1
    } else if(irq){
    80001ff2:	d8f1                	beqz	s1,80001fc6 <devintr+0x1e>
      printf("unexpected interrupt irq=%d\n", irq);
    80001ff4:	85a6                	mv	a1,s1
    80001ff6:	00006517          	auipc	a0,0x6
    80001ffa:	33a50513          	addi	a0,a0,826 # 80008330 <states.1805+0x38>
    80001ffe:	00004097          	auipc	ra,0x4
    80002002:	4ae080e7          	jalr	1198(ra) # 800064ac <printf>
      plic_complete(irq);
    80002006:	8526                	mv	a0,s1
    80002008:	00003097          	auipc	ra,0x3
    8000200c:	6c4080e7          	jalr	1732(ra) # 800056cc <plic_complete>
    return 1;
    80002010:	4505                	li	a0,1
    80002012:	bf55                	j	80001fc6 <devintr+0x1e>
      uartintr();
    80002014:	00005097          	auipc	ra,0x5
    80002018:	8b8080e7          	jalr	-1864(ra) # 800068cc <uartintr>
    8000201c:	b7ed                	j	80002006 <devintr+0x5e>
      virtio_disk_intr();
    8000201e:	00004097          	auipc	ra,0x4
    80002022:	b8e080e7          	jalr	-1138(ra) # 80005bac <virtio_disk_intr>
    80002026:	b7c5                	j	80002006 <devintr+0x5e>
    if(cpuid() == 0){
    80002028:	fffff097          	auipc	ra,0xfffff
    8000202c:	20c080e7          	jalr	524(ra) # 80001234 <cpuid>
    80002030:	c901                	beqz	a0,80002040 <devintr+0x98>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80002032:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80002036:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80002038:	14479073          	csrw	sip,a5
    return 2;
    8000203c:	4509                	li	a0,2
    8000203e:	b761                	j	80001fc6 <devintr+0x1e>
      clockintr();
    80002040:	00000097          	auipc	ra,0x0
    80002044:	f22080e7          	jalr	-222(ra) # 80001f62 <clockintr>
    80002048:	b7ed                	j	80002032 <devintr+0x8a>

000000008000204a <usertrap>:
{
    8000204a:	1101                	addi	sp,sp,-32
    8000204c:	ec06                	sd	ra,24(sp)
    8000204e:	e822                	sd	s0,16(sp)
    80002050:	e426                	sd	s1,8(sp)
    80002052:	e04a                	sd	s2,0(sp)
    80002054:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002056:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    8000205a:	1007f793          	andi	a5,a5,256
    8000205e:	ebb9                	bnez	a5,800020b4 <usertrap+0x6a>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002060:	00003797          	auipc	a5,0x3
    80002064:	54078793          	addi	a5,a5,1344 # 800055a0 <kernelvec>
    80002068:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    8000206c:	fffff097          	auipc	ra,0xfffff
    80002070:	1f4080e7          	jalr	500(ra) # 80001260 <myproc>
    80002074:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80002076:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002078:	14102773          	csrr	a4,sepc
    8000207c:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    8000207e:	142027f3          	csrr	a5,scause
  if (scause == 13 || scause == 15) { // Page fault load or store
    80002082:	ffd7f693          	andi	a3,a5,-3
    80002086:	4735                	li	a4,13
    80002088:	02e68e63          	beq	a3,a4,800020c4 <usertrap+0x7a>
  else if(scause == 8) {
    8000208c:	4721                	li	a4,8
    8000208e:	06e79363          	bne	a5,a4,800020f4 <usertrap+0xaa>
    if(p->killed)
    80002092:	551c                	lw	a5,40(a0)
    80002094:	ebb1                	bnez	a5,800020e8 <usertrap+0x9e>
    p->trapframe->epc += 4;
    80002096:	6cb8                	ld	a4,88(s1)
    80002098:	6f1c                	ld	a5,24(a4)
    8000209a:	0791                	addi	a5,a5,4
    8000209c:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000209e:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800020a2:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800020a6:	10079073          	csrw	sstatus,a5
    syscall();
    800020aa:	00000097          	auipc	ra,0x0
    800020ae:	2ee080e7          	jalr	750(ra) # 80002398 <syscall>
    800020b2:	a839                	j	800020d0 <usertrap+0x86>
    panic("usertrap: not from user mode");
    800020b4:	00006517          	auipc	a0,0x6
    800020b8:	29c50513          	addi	a0,a0,668 # 80008350 <states.1805+0x58>
    800020bc:	00004097          	auipc	ra,0x4
    800020c0:	3a6080e7          	jalr	934(ra) # 80006462 <panic>
  asm volatile("csrr %0, stval" : "=r" (x) );
    800020c4:	14302573          	csrr	a0,stval
      handle_pgfault(va); // Handle the page fault
    800020c8:	00004097          	auipc	ra,0x4
    800020cc:	c0e080e7          	jalr	-1010(ra) # 80005cd6 <handle_pgfault>
  if(p->killed)
    800020d0:	549c                	lw	a5,40(s1)
    800020d2:	e7a5                	bnez	a5,8000213a <usertrap+0xf0>
  usertrapret();
    800020d4:	00000097          	auipc	ra,0x0
    800020d8:	df0080e7          	jalr	-528(ra) # 80001ec4 <usertrapret>
}
    800020dc:	60e2                	ld	ra,24(sp)
    800020de:	6442                	ld	s0,16(sp)
    800020e0:	64a2                	ld	s1,8(sp)
    800020e2:	6902                	ld	s2,0(sp)
    800020e4:	6105                	addi	sp,sp,32
    800020e6:	8082                	ret
      exit(-1);
    800020e8:	557d                	li	a0,-1
    800020ea:	00000097          	auipc	ra,0x0
    800020ee:	a8e080e7          	jalr	-1394(ra) # 80001b78 <exit>
    800020f2:	b755                	j	80002096 <usertrap+0x4c>
  } else if ((which_dev = devintr()) != 0) {
    800020f4:	00000097          	auipc	ra,0x0
    800020f8:	eb4080e7          	jalr	-332(ra) # 80001fa8 <devintr>
    800020fc:	892a                	mv	s2,a0
    800020fe:	c501                	beqz	a0,80002106 <usertrap+0xbc>
  if(p->killed)
    80002100:	549c                	lw	a5,40(s1)
    80002102:	c3b1                	beqz	a5,80002146 <usertrap+0xfc>
    80002104:	a825                	j	8000213c <usertrap+0xf2>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002106:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    8000210a:	5890                	lw	a2,48(s1)
    8000210c:	00006517          	auipc	a0,0x6
    80002110:	26450513          	addi	a0,a0,612 # 80008370 <states.1805+0x78>
    80002114:	00004097          	auipc	ra,0x4
    80002118:	398080e7          	jalr	920(ra) # 800064ac <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    8000211c:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002120:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002124:	00006517          	auipc	a0,0x6
    80002128:	27c50513          	addi	a0,a0,636 # 800083a0 <states.1805+0xa8>
    8000212c:	00004097          	auipc	ra,0x4
    80002130:	380080e7          	jalr	896(ra) # 800064ac <printf>
    p->killed = 1;
    80002134:	4785                	li	a5,1
    80002136:	d49c                	sw	a5,40(s1)
  if(p->killed)
    80002138:	a011                	j	8000213c <usertrap+0xf2>
    8000213a:	4901                	li	s2,0
    exit(-1);
    8000213c:	557d                	li	a0,-1
    8000213e:	00000097          	auipc	ra,0x0
    80002142:	a3a080e7          	jalr	-1478(ra) # 80001b78 <exit>
  if(which_dev == 2)
    80002146:	4789                	li	a5,2
    80002148:	f8f916e3          	bne	s2,a5,800020d4 <usertrap+0x8a>
    yield();
    8000214c:	fffff097          	auipc	ra,0xfffff
    80002150:	794080e7          	jalr	1940(ra) # 800018e0 <yield>
    80002154:	b741                	j	800020d4 <usertrap+0x8a>

0000000080002156 <kerneltrap>:
{
    80002156:	7179                	addi	sp,sp,-48
    80002158:	f406                	sd	ra,40(sp)
    8000215a:	f022                	sd	s0,32(sp)
    8000215c:	ec26                	sd	s1,24(sp)
    8000215e:	e84a                	sd	s2,16(sp)
    80002160:	e44e                	sd	s3,8(sp)
    80002162:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002164:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002168:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    8000216c:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80002170:	1004f793          	andi	a5,s1,256
    80002174:	cb85                	beqz	a5,800021a4 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002176:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8000217a:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    8000217c:	ef85                	bnez	a5,800021b4 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    8000217e:	00000097          	auipc	ra,0x0
    80002182:	e2a080e7          	jalr	-470(ra) # 80001fa8 <devintr>
    80002186:	cd1d                	beqz	a0,800021c4 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002188:	4789                	li	a5,2
    8000218a:	06f50a63          	beq	a0,a5,800021fe <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    8000218e:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002192:	10049073          	csrw	sstatus,s1
}
    80002196:	70a2                	ld	ra,40(sp)
    80002198:	7402                	ld	s0,32(sp)
    8000219a:	64e2                	ld	s1,24(sp)
    8000219c:	6942                	ld	s2,16(sp)
    8000219e:	69a2                	ld	s3,8(sp)
    800021a0:	6145                	addi	sp,sp,48
    800021a2:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    800021a4:	00006517          	auipc	a0,0x6
    800021a8:	21c50513          	addi	a0,a0,540 # 800083c0 <states.1805+0xc8>
    800021ac:	00004097          	auipc	ra,0x4
    800021b0:	2b6080e7          	jalr	694(ra) # 80006462 <panic>
    panic("kerneltrap: interrupts enabled");
    800021b4:	00006517          	auipc	a0,0x6
    800021b8:	23450513          	addi	a0,a0,564 # 800083e8 <states.1805+0xf0>
    800021bc:	00004097          	auipc	ra,0x4
    800021c0:	2a6080e7          	jalr	678(ra) # 80006462 <panic>
    printf("scause %p\n", scause);
    800021c4:	85ce                	mv	a1,s3
    800021c6:	00006517          	auipc	a0,0x6
    800021ca:	24250513          	addi	a0,a0,578 # 80008408 <states.1805+0x110>
    800021ce:	00004097          	auipc	ra,0x4
    800021d2:	2de080e7          	jalr	734(ra) # 800064ac <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800021d6:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    800021da:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    800021de:	00006517          	auipc	a0,0x6
    800021e2:	23a50513          	addi	a0,a0,570 # 80008418 <states.1805+0x120>
    800021e6:	00004097          	auipc	ra,0x4
    800021ea:	2c6080e7          	jalr	710(ra) # 800064ac <printf>
    panic("kerneltrap");
    800021ee:	00006517          	auipc	a0,0x6
    800021f2:	24250513          	addi	a0,a0,578 # 80008430 <states.1805+0x138>
    800021f6:	00004097          	auipc	ra,0x4
    800021fa:	26c080e7          	jalr	620(ra) # 80006462 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    800021fe:	fffff097          	auipc	ra,0xfffff
    80002202:	062080e7          	jalr	98(ra) # 80001260 <myproc>
    80002206:	d541                	beqz	a0,8000218e <kerneltrap+0x38>
    80002208:	fffff097          	auipc	ra,0xfffff
    8000220c:	058080e7          	jalr	88(ra) # 80001260 <myproc>
    80002210:	4d18                	lw	a4,24(a0)
    80002212:	4791                	li	a5,4
    80002214:	f6f71de3          	bne	a4,a5,8000218e <kerneltrap+0x38>
    yield();
    80002218:	fffff097          	auipc	ra,0xfffff
    8000221c:	6c8080e7          	jalr	1736(ra) # 800018e0 <yield>
    80002220:	b7bd                	j	8000218e <kerneltrap+0x38>

0000000080002222 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80002222:	1101                	addi	sp,sp,-32
    80002224:	ec06                	sd	ra,24(sp)
    80002226:	e822                	sd	s0,16(sp)
    80002228:	e426                	sd	s1,8(sp)
    8000222a:	1000                	addi	s0,sp,32
    8000222c:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    8000222e:	fffff097          	auipc	ra,0xfffff
    80002232:	032080e7          	jalr	50(ra) # 80001260 <myproc>
  switch (n) {
    80002236:	4795                	li	a5,5
    80002238:	0497e163          	bltu	a5,s1,8000227a <argraw+0x58>
    8000223c:	048a                	slli	s1,s1,0x2
    8000223e:	00006717          	auipc	a4,0x6
    80002242:	22a70713          	addi	a4,a4,554 # 80008468 <states.1805+0x170>
    80002246:	94ba                	add	s1,s1,a4
    80002248:	409c                	lw	a5,0(s1)
    8000224a:	97ba                	add	a5,a5,a4
    8000224c:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    8000224e:	6d3c                	ld	a5,88(a0)
    80002250:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80002252:	60e2                	ld	ra,24(sp)
    80002254:	6442                	ld	s0,16(sp)
    80002256:	64a2                	ld	s1,8(sp)
    80002258:	6105                	addi	sp,sp,32
    8000225a:	8082                	ret
    return p->trapframe->a1;
    8000225c:	6d3c                	ld	a5,88(a0)
    8000225e:	7fa8                	ld	a0,120(a5)
    80002260:	bfcd                	j	80002252 <argraw+0x30>
    return p->trapframe->a2;
    80002262:	6d3c                	ld	a5,88(a0)
    80002264:	63c8                	ld	a0,128(a5)
    80002266:	b7f5                	j	80002252 <argraw+0x30>
    return p->trapframe->a3;
    80002268:	6d3c                	ld	a5,88(a0)
    8000226a:	67c8                	ld	a0,136(a5)
    8000226c:	b7dd                	j	80002252 <argraw+0x30>
    return p->trapframe->a4;
    8000226e:	6d3c                	ld	a5,88(a0)
    80002270:	6bc8                	ld	a0,144(a5)
    80002272:	b7c5                	j	80002252 <argraw+0x30>
    return p->trapframe->a5;
    80002274:	6d3c                	ld	a5,88(a0)
    80002276:	6fc8                	ld	a0,152(a5)
    80002278:	bfe9                	j	80002252 <argraw+0x30>
  panic("argraw");
    8000227a:	00006517          	auipc	a0,0x6
    8000227e:	1c650513          	addi	a0,a0,454 # 80008440 <states.1805+0x148>
    80002282:	00004097          	auipc	ra,0x4
    80002286:	1e0080e7          	jalr	480(ra) # 80006462 <panic>

000000008000228a <fetchaddr>:
{
    8000228a:	1101                	addi	sp,sp,-32
    8000228c:	ec06                	sd	ra,24(sp)
    8000228e:	e822                	sd	s0,16(sp)
    80002290:	e426                	sd	s1,8(sp)
    80002292:	e04a                	sd	s2,0(sp)
    80002294:	1000                	addi	s0,sp,32
    80002296:	84aa                	mv	s1,a0
    80002298:	892e                	mv	s2,a1
  struct proc *p = myproc();
    8000229a:	fffff097          	auipc	ra,0xfffff
    8000229e:	fc6080e7          	jalr	-58(ra) # 80001260 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    800022a2:	653c                	ld	a5,72(a0)
    800022a4:	02f4f863          	bgeu	s1,a5,800022d4 <fetchaddr+0x4a>
    800022a8:	00848713          	addi	a4,s1,8
    800022ac:	02e7e663          	bltu	a5,a4,800022d8 <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    800022b0:	46a1                	li	a3,8
    800022b2:	8626                	mv	a2,s1
    800022b4:	85ca                	mv	a1,s2
    800022b6:	6928                	ld	a0,80(a0)
    800022b8:	fffff097          	auipc	ra,0xfffff
    800022bc:	8d6080e7          	jalr	-1834(ra) # 80000b8e <copyin>
    800022c0:	00a03533          	snez	a0,a0
    800022c4:	40a00533          	neg	a0,a0
}
    800022c8:	60e2                	ld	ra,24(sp)
    800022ca:	6442                	ld	s0,16(sp)
    800022cc:	64a2                	ld	s1,8(sp)
    800022ce:	6902                	ld	s2,0(sp)
    800022d0:	6105                	addi	sp,sp,32
    800022d2:	8082                	ret
    return -1;
    800022d4:	557d                	li	a0,-1
    800022d6:	bfcd                	j	800022c8 <fetchaddr+0x3e>
    800022d8:	557d                	li	a0,-1
    800022da:	b7fd                	j	800022c8 <fetchaddr+0x3e>

00000000800022dc <fetchstr>:
{
    800022dc:	7179                	addi	sp,sp,-48
    800022de:	f406                	sd	ra,40(sp)
    800022e0:	f022                	sd	s0,32(sp)
    800022e2:	ec26                	sd	s1,24(sp)
    800022e4:	e84a                	sd	s2,16(sp)
    800022e6:	e44e                	sd	s3,8(sp)
    800022e8:	1800                	addi	s0,sp,48
    800022ea:	892a                	mv	s2,a0
    800022ec:	84ae                	mv	s1,a1
    800022ee:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    800022f0:	fffff097          	auipc	ra,0xfffff
    800022f4:	f70080e7          	jalr	-144(ra) # 80001260 <myproc>
  int err = copyinstr(p->pagetable, buf, addr, max);
    800022f8:	86ce                	mv	a3,s3
    800022fa:	864a                	mv	a2,s2
    800022fc:	85a6                	mv	a1,s1
    800022fe:	6928                	ld	a0,80(a0)
    80002300:	fffff097          	auipc	ra,0xfffff
    80002304:	91a080e7          	jalr	-1766(ra) # 80000c1a <copyinstr>
  if(err < 0)
    80002308:	00054763          	bltz	a0,80002316 <fetchstr+0x3a>
  return strlen(buf);
    8000230c:	8526                	mv	a0,s1
    8000230e:	ffffe097          	auipc	ra,0xffffe
    80002312:	fee080e7          	jalr	-18(ra) # 800002fc <strlen>
}
    80002316:	70a2                	ld	ra,40(sp)
    80002318:	7402                	ld	s0,32(sp)
    8000231a:	64e2                	ld	s1,24(sp)
    8000231c:	6942                	ld	s2,16(sp)
    8000231e:	69a2                	ld	s3,8(sp)
    80002320:	6145                	addi	sp,sp,48
    80002322:	8082                	ret

0000000080002324 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    80002324:	1101                	addi	sp,sp,-32
    80002326:	ec06                	sd	ra,24(sp)
    80002328:	e822                	sd	s0,16(sp)
    8000232a:	e426                	sd	s1,8(sp)
    8000232c:	1000                	addi	s0,sp,32
    8000232e:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002330:	00000097          	auipc	ra,0x0
    80002334:	ef2080e7          	jalr	-270(ra) # 80002222 <argraw>
    80002338:	c088                	sw	a0,0(s1)
  return 0;
}
    8000233a:	4501                	li	a0,0
    8000233c:	60e2                	ld	ra,24(sp)
    8000233e:	6442                	ld	s0,16(sp)
    80002340:	64a2                	ld	s1,8(sp)
    80002342:	6105                	addi	sp,sp,32
    80002344:	8082                	ret

0000000080002346 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    80002346:	1101                	addi	sp,sp,-32
    80002348:	ec06                	sd	ra,24(sp)
    8000234a:	e822                	sd	s0,16(sp)
    8000234c:	e426                	sd	s1,8(sp)
    8000234e:	1000                	addi	s0,sp,32
    80002350:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002352:	00000097          	auipc	ra,0x0
    80002356:	ed0080e7          	jalr	-304(ra) # 80002222 <argraw>
    8000235a:	e088                	sd	a0,0(s1)
  return 0;
}
    8000235c:	4501                	li	a0,0
    8000235e:	60e2                	ld	ra,24(sp)
    80002360:	6442                	ld	s0,16(sp)
    80002362:	64a2                	ld	s1,8(sp)
    80002364:	6105                	addi	sp,sp,32
    80002366:	8082                	ret

0000000080002368 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80002368:	1101                	addi	sp,sp,-32
    8000236a:	ec06                	sd	ra,24(sp)
    8000236c:	e822                	sd	s0,16(sp)
    8000236e:	e426                	sd	s1,8(sp)
    80002370:	e04a                	sd	s2,0(sp)
    80002372:	1000                	addi	s0,sp,32
    80002374:	84ae                	mv	s1,a1
    80002376:	8932                	mv	s2,a2
  *ip = argraw(n);
    80002378:	00000097          	auipc	ra,0x0
    8000237c:	eaa080e7          	jalr	-342(ra) # 80002222 <argraw>
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    return -1;
  return fetchstr(addr, buf, max);
    80002380:	864a                	mv	a2,s2
    80002382:	85a6                	mv	a1,s1
    80002384:	00000097          	auipc	ra,0x0
    80002388:	f58080e7          	jalr	-168(ra) # 800022dc <fetchstr>
}
    8000238c:	60e2                	ld	ra,24(sp)
    8000238e:	6442                	ld	s0,16(sp)
    80002390:	64a2                	ld	s1,8(sp)
    80002392:	6902                	ld	s2,0(sp)
    80002394:	6105                	addi	sp,sp,32
    80002396:	8082                	ret

0000000080002398 <syscall>:



void
syscall(void)
{
    80002398:	1101                	addi	sp,sp,-32
    8000239a:	ec06                	sd	ra,24(sp)
    8000239c:	e822                	sd	s0,16(sp)
    8000239e:	e426                	sd	s1,8(sp)
    800023a0:	e04a                	sd	s2,0(sp)
    800023a2:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    800023a4:	fffff097          	auipc	ra,0xfffff
    800023a8:	ebc080e7          	jalr	-324(ra) # 80001260 <myproc>
    800023ac:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    800023ae:	05853903          	ld	s2,88(a0)
    800023b2:	0a893783          	ld	a5,168(s2)
    800023b6:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    800023ba:	37fd                	addiw	a5,a5,-1
    800023bc:	02000713          	li	a4,32
    800023c0:	00f76f63          	bltu	a4,a5,800023de <syscall+0x46>
    800023c4:	00369713          	slli	a4,a3,0x3
    800023c8:	00006797          	auipc	a5,0x6
    800023cc:	0b878793          	addi	a5,a5,184 # 80008480 <syscalls>
    800023d0:	97ba                	add	a5,a5,a4
    800023d2:	639c                	ld	a5,0(a5)
    800023d4:	c789                	beqz	a5,800023de <syscall+0x46>
    p->trapframe->a0 = syscalls[num]();
    800023d6:	9782                	jalr	a5
    800023d8:	06a93823          	sd	a0,112(s2)
    800023dc:	a839                	j	800023fa <syscall+0x62>
  } else {
    printf("%d %s: unknown sys call %d\n",
    800023de:	15848613          	addi	a2,s1,344
    800023e2:	588c                	lw	a1,48(s1)
    800023e4:	00006517          	auipc	a0,0x6
    800023e8:	06450513          	addi	a0,a0,100 # 80008448 <states.1805+0x150>
    800023ec:	00004097          	auipc	ra,0x4
    800023f0:	0c0080e7          	jalr	192(ra) # 800064ac <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    800023f4:	6cbc                	ld	a5,88(s1)
    800023f6:	577d                	li	a4,-1
    800023f8:	fbb8                	sd	a4,112(a5)
  }
}
    800023fa:	60e2                	ld	ra,24(sp)
    800023fc:	6442                	ld	s0,16(sp)
    800023fe:	64a2                	ld	s1,8(sp)
    80002400:	6902                	ld	s2,0(sp)
    80002402:	6105                	addi	sp,sp,32
    80002404:	8082                	ret

0000000080002406 <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    80002406:	1101                	addi	sp,sp,-32
    80002408:	ec06                	sd	ra,24(sp)
    8000240a:	e822                	sd	s0,16(sp)
    8000240c:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    8000240e:	fec40593          	addi	a1,s0,-20
    80002412:	4501                	li	a0,0
    80002414:	00000097          	auipc	ra,0x0
    80002418:	f10080e7          	jalr	-240(ra) # 80002324 <argint>
    return -1;
    8000241c:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    8000241e:	00054963          	bltz	a0,80002430 <sys_exit+0x2a>
  exit(n);
    80002422:	fec42503          	lw	a0,-20(s0)
    80002426:	fffff097          	auipc	ra,0xfffff
    8000242a:	752080e7          	jalr	1874(ra) # 80001b78 <exit>
  return 0;  // not reached
    8000242e:	4781                	li	a5,0
}
    80002430:	853e                	mv	a0,a5
    80002432:	60e2                	ld	ra,24(sp)
    80002434:	6442                	ld	s0,16(sp)
    80002436:	6105                	addi	sp,sp,32
    80002438:	8082                	ret

000000008000243a <sys_getpid>:

uint64
sys_getpid(void)
{
    8000243a:	1141                	addi	sp,sp,-16
    8000243c:	e406                	sd	ra,8(sp)
    8000243e:	e022                	sd	s0,0(sp)
    80002440:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80002442:	fffff097          	auipc	ra,0xfffff
    80002446:	e1e080e7          	jalr	-482(ra) # 80001260 <myproc>
}
    8000244a:	5908                	lw	a0,48(a0)
    8000244c:	60a2                	ld	ra,8(sp)
    8000244e:	6402                	ld	s0,0(sp)
    80002450:	0141                	addi	sp,sp,16
    80002452:	8082                	ret

0000000080002454 <sys_fork>:

uint64
sys_fork(void)
{
    80002454:	1141                	addi	sp,sp,-16
    80002456:	e406                	sd	ra,8(sp)
    80002458:	e022                	sd	s0,0(sp)
    8000245a:	0800                	addi	s0,sp,16
  return fork();
    8000245c:	fffff097          	auipc	ra,0xfffff
    80002460:	1d2080e7          	jalr	466(ra) # 8000162e <fork>
}
    80002464:	60a2                	ld	ra,8(sp)
    80002466:	6402                	ld	s0,0(sp)
    80002468:	0141                	addi	sp,sp,16
    8000246a:	8082                	ret

000000008000246c <sys_wait>:

uint64
sys_wait(void)
{
    8000246c:	1101                	addi	sp,sp,-32
    8000246e:	ec06                	sd	ra,24(sp)
    80002470:	e822                	sd	s0,16(sp)
    80002472:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    80002474:	fe840593          	addi	a1,s0,-24
    80002478:	4501                	li	a0,0
    8000247a:	00000097          	auipc	ra,0x0
    8000247e:	ecc080e7          	jalr	-308(ra) # 80002346 <argaddr>
    80002482:	87aa                	mv	a5,a0
    return -1;
    80002484:	557d                	li	a0,-1
  if(argaddr(0, &p) < 0)
    80002486:	0007c863          	bltz	a5,80002496 <sys_wait+0x2a>
  return wait(p);
    8000248a:	fe843503          	ld	a0,-24(s0)
    8000248e:	fffff097          	auipc	ra,0xfffff
    80002492:	4f2080e7          	jalr	1266(ra) # 80001980 <wait>
}
    80002496:	60e2                	ld	ra,24(sp)
    80002498:	6442                	ld	s0,16(sp)
    8000249a:	6105                	addi	sp,sp,32
    8000249c:	8082                	ret

000000008000249e <sys_sbrk>:

uint64
sys_sbrk(void)
{
    8000249e:	7179                	addi	sp,sp,-48
    800024a0:	f406                	sd	ra,40(sp)
    800024a2:	f022                	sd	s0,32(sp)
    800024a4:	ec26                	sd	s1,24(sp)
    800024a6:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    800024a8:	fdc40593          	addi	a1,s0,-36
    800024ac:	4501                	li	a0,0
    800024ae:	00000097          	auipc	ra,0x0
    800024b2:	e76080e7          	jalr	-394(ra) # 80002324 <argint>
    800024b6:	87aa                	mv	a5,a0
    return -1;
    800024b8:	557d                	li	a0,-1
  if(argint(0, &n) < 0)
    800024ba:	0207c063          	bltz	a5,800024da <sys_sbrk+0x3c>
  
  addr = myproc()->sz;
    800024be:	fffff097          	auipc	ra,0xfffff
    800024c2:	da2080e7          	jalr	-606(ra) # 80001260 <myproc>
    800024c6:	4524                	lw	s1,72(a0)
  if(growproc(n) < 0)
    800024c8:	fdc42503          	lw	a0,-36(s0)
    800024cc:	fffff097          	auipc	ra,0xfffff
    800024d0:	0ee080e7          	jalr	238(ra) # 800015ba <growproc>
    800024d4:	00054863          	bltz	a0,800024e4 <sys_sbrk+0x46>
    return -1;
  return addr;
    800024d8:	8526                	mv	a0,s1
}
    800024da:	70a2                	ld	ra,40(sp)
    800024dc:	7402                	ld	s0,32(sp)
    800024de:	64e2                	ld	s1,24(sp)
    800024e0:	6145                	addi	sp,sp,48
    800024e2:	8082                	ret
    return -1;
    800024e4:	557d                	li	a0,-1
    800024e6:	bfd5                	j	800024da <sys_sbrk+0x3c>

00000000800024e8 <sys_sleep>:

uint64
sys_sleep(void)
{
    800024e8:	7139                	addi	sp,sp,-64
    800024ea:	fc06                	sd	ra,56(sp)
    800024ec:	f822                	sd	s0,48(sp)
    800024ee:	f426                	sd	s1,40(sp)
    800024f0:	f04a                	sd	s2,32(sp)
    800024f2:	ec4e                	sd	s3,24(sp)
    800024f4:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;


  if(argint(0, &n) < 0)
    800024f6:	fcc40593          	addi	a1,s0,-52
    800024fa:	4501                	li	a0,0
    800024fc:	00000097          	auipc	ra,0x0
    80002500:	e28080e7          	jalr	-472(ra) # 80002324 <argint>
    return -1;
    80002504:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80002506:	06054563          	bltz	a0,80002570 <sys_sleep+0x88>
  acquire(&tickslock);
    8000250a:	0000d517          	auipc	a0,0xd
    8000250e:	97650513          	addi	a0,a0,-1674 # 8000ee80 <tickslock>
    80002512:	00004097          	auipc	ra,0x4
    80002516:	49a080e7          	jalr	1178(ra) # 800069ac <acquire>
  ticks0 = ticks;
    8000251a:	00007917          	auipc	s2,0x7
    8000251e:	afe92903          	lw	s2,-1282(s2) # 80009018 <ticks>
  while(ticks - ticks0 < n){
    80002522:	fcc42783          	lw	a5,-52(s0)
    80002526:	cf85                	beqz	a5,8000255e <sys_sleep+0x76>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80002528:	0000d997          	auipc	s3,0xd
    8000252c:	95898993          	addi	s3,s3,-1704 # 8000ee80 <tickslock>
    80002530:	00007497          	auipc	s1,0x7
    80002534:	ae848493          	addi	s1,s1,-1304 # 80009018 <ticks>
    if(myproc()->killed){
    80002538:	fffff097          	auipc	ra,0xfffff
    8000253c:	d28080e7          	jalr	-728(ra) # 80001260 <myproc>
    80002540:	551c                	lw	a5,40(a0)
    80002542:	ef9d                	bnez	a5,80002580 <sys_sleep+0x98>
    sleep(&ticks, &tickslock);
    80002544:	85ce                	mv	a1,s3
    80002546:	8526                	mv	a0,s1
    80002548:	fffff097          	auipc	ra,0xfffff
    8000254c:	3d4080e7          	jalr	980(ra) # 8000191c <sleep>
  while(ticks - ticks0 < n){
    80002550:	409c                	lw	a5,0(s1)
    80002552:	412787bb          	subw	a5,a5,s2
    80002556:	fcc42703          	lw	a4,-52(s0)
    8000255a:	fce7efe3          	bltu	a5,a4,80002538 <sys_sleep+0x50>
  }
  release(&tickslock);
    8000255e:	0000d517          	auipc	a0,0xd
    80002562:	92250513          	addi	a0,a0,-1758 # 8000ee80 <tickslock>
    80002566:	00004097          	auipc	ra,0x4
    8000256a:	4fa080e7          	jalr	1274(ra) # 80006a60 <release>
  return 0;
    8000256e:	4781                	li	a5,0
}
    80002570:	853e                	mv	a0,a5
    80002572:	70e2                	ld	ra,56(sp)
    80002574:	7442                	ld	s0,48(sp)
    80002576:	74a2                	ld	s1,40(sp)
    80002578:	7902                	ld	s2,32(sp)
    8000257a:	69e2                	ld	s3,24(sp)
    8000257c:	6121                	addi	sp,sp,64
    8000257e:	8082                	ret
      release(&tickslock);
    80002580:	0000d517          	auipc	a0,0xd
    80002584:	90050513          	addi	a0,a0,-1792 # 8000ee80 <tickslock>
    80002588:	00004097          	auipc	ra,0x4
    8000258c:	4d8080e7          	jalr	1240(ra) # 80006a60 <release>
      return -1;
    80002590:	57fd                	li	a5,-1
    80002592:	bff9                	j	80002570 <sys_sleep+0x88>

0000000080002594 <sys_pgaccess>:


#ifdef LAB_PGTBL
int
sys_pgaccess(void)
{
    80002594:	1141                	addi	sp,sp,-16
    80002596:	e422                	sd	s0,8(sp)
    80002598:	0800                	addi	s0,sp,16
  // lab pgtbl: your code here.
  return 0;
}
    8000259a:	4501                	li	a0,0
    8000259c:	6422                	ld	s0,8(sp)
    8000259e:	0141                	addi	sp,sp,16
    800025a0:	8082                	ret

00000000800025a2 <sys_kill>:
#endif

uint64
sys_kill(void)
{
    800025a2:	1101                	addi	sp,sp,-32
    800025a4:	ec06                	sd	ra,24(sp)
    800025a6:	e822                	sd	s0,16(sp)
    800025a8:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    800025aa:	fec40593          	addi	a1,s0,-20
    800025ae:	4501                	li	a0,0
    800025b0:	00000097          	auipc	ra,0x0
    800025b4:	d74080e7          	jalr	-652(ra) # 80002324 <argint>
    800025b8:	87aa                	mv	a5,a0
    return -1;
    800025ba:	557d                	li	a0,-1
  if(argint(0, &pid) < 0)
    800025bc:	0007c863          	bltz	a5,800025cc <sys_kill+0x2a>
  return kill(pid);
    800025c0:	fec42503          	lw	a0,-20(s0)
    800025c4:	fffff097          	auipc	ra,0xfffff
    800025c8:	68a080e7          	jalr	1674(ra) # 80001c4e <kill>
}
    800025cc:	60e2                	ld	ra,24(sp)
    800025ce:	6442                	ld	s0,16(sp)
    800025d0:	6105                	addi	sp,sp,32
    800025d2:	8082                	ret

00000000800025d4 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    800025d4:	1101                	addi	sp,sp,-32
    800025d6:	ec06                	sd	ra,24(sp)
    800025d8:	e822                	sd	s0,16(sp)
    800025da:	e426                	sd	s1,8(sp)
    800025dc:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    800025de:	0000d517          	auipc	a0,0xd
    800025e2:	8a250513          	addi	a0,a0,-1886 # 8000ee80 <tickslock>
    800025e6:	00004097          	auipc	ra,0x4
    800025ea:	3c6080e7          	jalr	966(ra) # 800069ac <acquire>
  xticks = ticks;
    800025ee:	00007497          	auipc	s1,0x7
    800025f2:	a2a4a483          	lw	s1,-1494(s1) # 80009018 <ticks>
  release(&tickslock);
    800025f6:	0000d517          	auipc	a0,0xd
    800025fa:	88a50513          	addi	a0,a0,-1910 # 8000ee80 <tickslock>
    800025fe:	00004097          	auipc	ra,0x4
    80002602:	462080e7          	jalr	1122(ra) # 80006a60 <release>
  return xticks;
}
    80002606:	02049513          	slli	a0,s1,0x20
    8000260a:	9101                	srli	a0,a0,0x20
    8000260c:	60e2                	ld	ra,24(sp)
    8000260e:	6442                	ld	s0,16(sp)
    80002610:	64a2                	ld	s1,8(sp)
    80002612:	6105                	addi	sp,sp,32
    80002614:	8082                	ret

0000000080002616 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
    80002616:	7179                	addi	sp,sp,-48
    80002618:	f406                	sd	ra,40(sp)
    8000261a:	f022                	sd	s0,32(sp)
    8000261c:	ec26                	sd	s1,24(sp)
    8000261e:	e84a                	sd	s2,16(sp)
    80002620:	e44e                	sd	s3,8(sp)
    80002622:	1800                	addi	s0,sp,48
    80002624:	892a                	mv	s2,a0
    80002626:	89ae                	mv	s3,a1
  struct buf *b;

  acquire(&bcache.lock);
    80002628:	0000d517          	auipc	a0,0xd
    8000262c:	87050513          	addi	a0,a0,-1936 # 8000ee98 <bcache>
    80002630:	00004097          	auipc	ra,0x4
    80002634:	37c080e7          	jalr	892(ra) # 800069ac <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80002638:	00015497          	auipc	s1,0x15
    8000263c:	b184b483          	ld	s1,-1256(s1) # 80017150 <bcache+0x82b8>
    80002640:	00015797          	auipc	a5,0x15
    80002644:	ac078793          	addi	a5,a5,-1344 # 80017100 <bcache+0x8268>
    80002648:	02f48f63          	beq	s1,a5,80002686 <bget+0x70>
    8000264c:	873e                	mv	a4,a5
    8000264e:	a021                	j	80002656 <bget+0x40>
    80002650:	68a4                	ld	s1,80(s1)
    80002652:	02e48a63          	beq	s1,a4,80002686 <bget+0x70>
    if(b->dev == dev && b->blockno == blockno){
    80002656:	449c                	lw	a5,8(s1)
    80002658:	ff279ce3          	bne	a5,s2,80002650 <bget+0x3a>
    8000265c:	44dc                	lw	a5,12(s1)
    8000265e:	ff3799e3          	bne	a5,s3,80002650 <bget+0x3a>
      b->refcnt++;
    80002662:	40bc                	lw	a5,64(s1)
    80002664:	2785                	addiw	a5,a5,1
    80002666:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002668:	0000d517          	auipc	a0,0xd
    8000266c:	83050513          	addi	a0,a0,-2000 # 8000ee98 <bcache>
    80002670:	00004097          	auipc	ra,0x4
    80002674:	3f0080e7          	jalr	1008(ra) # 80006a60 <release>
      acquiresleep(&b->lock);
    80002678:	01048513          	addi	a0,s1,16
    8000267c:	00001097          	auipc	ra,0x1
    80002680:	736080e7          	jalr	1846(ra) # 80003db2 <acquiresleep>
      return b;
    80002684:	a8b9                	j	800026e2 <bget+0xcc>
    }
  }

  // Not cached.
  // Recycle the least recently used (LRU) unused buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002686:	00015497          	auipc	s1,0x15
    8000268a:	ac24b483          	ld	s1,-1342(s1) # 80017148 <bcache+0x82b0>
    8000268e:	00015797          	auipc	a5,0x15
    80002692:	a7278793          	addi	a5,a5,-1422 # 80017100 <bcache+0x8268>
    80002696:	00f48863          	beq	s1,a5,800026a6 <bget+0x90>
    8000269a:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    8000269c:	40bc                	lw	a5,64(s1)
    8000269e:	cf81                	beqz	a5,800026b6 <bget+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800026a0:	64a4                	ld	s1,72(s1)
    800026a2:	fee49de3          	bne	s1,a4,8000269c <bget+0x86>
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
    800026a6:	00006517          	auipc	a0,0x6
    800026aa:	eea50513          	addi	a0,a0,-278 # 80008590 <syscalls+0x110>
    800026ae:	00004097          	auipc	ra,0x4
    800026b2:	db4080e7          	jalr	-588(ra) # 80006462 <panic>
      b->dev = dev;
    800026b6:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    800026ba:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    800026be:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    800026c2:	4785                	li	a5,1
    800026c4:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800026c6:	0000c517          	auipc	a0,0xc
    800026ca:	7d250513          	addi	a0,a0,2002 # 8000ee98 <bcache>
    800026ce:	00004097          	auipc	ra,0x4
    800026d2:	392080e7          	jalr	914(ra) # 80006a60 <release>
      acquiresleep(&b->lock);
    800026d6:	01048513          	addi	a0,s1,16
    800026da:	00001097          	auipc	ra,0x1
    800026de:	6d8080e7          	jalr	1752(ra) # 80003db2 <acquiresleep>
}
    800026e2:	8526                	mv	a0,s1
    800026e4:	70a2                	ld	ra,40(sp)
    800026e6:	7402                	ld	s0,32(sp)
    800026e8:	64e2                	ld	s1,24(sp)
    800026ea:	6942                	ld	s2,16(sp)
    800026ec:	69a2                	ld	s3,8(sp)
    800026ee:	6145                	addi	sp,sp,48
    800026f0:	8082                	ret

00000000800026f2 <binit>:
{
    800026f2:	7179                	addi	sp,sp,-48
    800026f4:	f406                	sd	ra,40(sp)
    800026f6:	f022                	sd	s0,32(sp)
    800026f8:	ec26                	sd	s1,24(sp)
    800026fa:	e84a                	sd	s2,16(sp)
    800026fc:	e44e                	sd	s3,8(sp)
    800026fe:	e052                	sd	s4,0(sp)
    80002700:	1800                	addi	s0,sp,48
  initlock(&bcache.lock, "bcache");
    80002702:	00006597          	auipc	a1,0x6
    80002706:	ea658593          	addi	a1,a1,-346 # 800085a8 <syscalls+0x128>
    8000270a:	0000c517          	auipc	a0,0xc
    8000270e:	78e50513          	addi	a0,a0,1934 # 8000ee98 <bcache>
    80002712:	00004097          	auipc	ra,0x4
    80002716:	20a080e7          	jalr	522(ra) # 8000691c <initlock>
  bcache.head.prev = &bcache.head;
    8000271a:	00014797          	auipc	a5,0x14
    8000271e:	77e78793          	addi	a5,a5,1918 # 80016e98 <bcache+0x8000>
    80002722:	00015717          	auipc	a4,0x15
    80002726:	9de70713          	addi	a4,a4,-1570 # 80017100 <bcache+0x8268>
    8000272a:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    8000272e:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002732:	0000c497          	auipc	s1,0xc
    80002736:	77e48493          	addi	s1,s1,1918 # 8000eeb0 <bcache+0x18>
    b->next = bcache.head.next;
    8000273a:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    8000273c:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    8000273e:	00006a17          	auipc	s4,0x6
    80002742:	e72a0a13          	addi	s4,s4,-398 # 800085b0 <syscalls+0x130>
    b->next = bcache.head.next;
    80002746:	2b893783          	ld	a5,696(s2)
    8000274a:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    8000274c:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80002750:	85d2                	mv	a1,s4
    80002752:	01048513          	addi	a0,s1,16
    80002756:	00001097          	auipc	ra,0x1
    8000275a:	622080e7          	jalr	1570(ra) # 80003d78 <initsleeplock>
    bcache.head.next->prev = b;
    8000275e:	2b893783          	ld	a5,696(s2)
    80002762:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80002764:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002768:	45848493          	addi	s1,s1,1112
    8000276c:	fd349de3          	bne	s1,s3,80002746 <binit+0x54>
}
    80002770:	70a2                	ld	ra,40(sp)
    80002772:	7402                	ld	s0,32(sp)
    80002774:	64e2                	ld	s1,24(sp)
    80002776:	6942                	ld	s2,16(sp)
    80002778:	69a2                	ld	s3,8(sp)
    8000277a:	6a02                	ld	s4,0(sp)
    8000277c:	6145                	addi	sp,sp,48
    8000277e:	8082                	ret

0000000080002780 <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80002780:	1101                	addi	sp,sp,-32
    80002782:	ec06                	sd	ra,24(sp)
    80002784:	e822                	sd	s0,16(sp)
    80002786:	e426                	sd	s1,8(sp)
    80002788:	1000                	addi	s0,sp,32
  struct buf *b;

  b = bget(dev, blockno);
    8000278a:	00000097          	auipc	ra,0x0
    8000278e:	e8c080e7          	jalr	-372(ra) # 80002616 <bget>
    80002792:	84aa                	mv	s1,a0
  if(!b->valid) {
    80002794:	411c                	lw	a5,0(a0)
    80002796:	c799                	beqz	a5,800027a4 <bread+0x24>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    80002798:	8526                	mv	a0,s1
    8000279a:	60e2                	ld	ra,24(sp)
    8000279c:	6442                	ld	s0,16(sp)
    8000279e:	64a2                	ld	s1,8(sp)
    800027a0:	6105                	addi	sp,sp,32
    800027a2:	8082                	ret
    virtio_disk_rw(b, 0);
    800027a4:	4581                	li	a1,0
    800027a6:	00003097          	auipc	ra,0x3
    800027aa:	130080e7          	jalr	304(ra) # 800058d6 <virtio_disk_rw>
    b->valid = 1;
    800027ae:	4785                	li	a5,1
    800027b0:	c09c                	sw	a5,0(s1)
  return b;
    800027b2:	b7dd                	j	80002798 <bread+0x18>

00000000800027b4 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    800027b4:	1101                	addi	sp,sp,-32
    800027b6:	ec06                	sd	ra,24(sp)
    800027b8:	e822                	sd	s0,16(sp)
    800027ba:	e426                	sd	s1,8(sp)
    800027bc:	1000                	addi	s0,sp,32
    800027be:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800027c0:	0541                	addi	a0,a0,16
    800027c2:	00001097          	auipc	ra,0x1
    800027c6:	68a080e7          	jalr	1674(ra) # 80003e4c <holdingsleep>
    800027ca:	cd01                	beqz	a0,800027e2 <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    800027cc:	4585                	li	a1,1
    800027ce:	8526                	mv	a0,s1
    800027d0:	00003097          	auipc	ra,0x3
    800027d4:	106080e7          	jalr	262(ra) # 800058d6 <virtio_disk_rw>
}
    800027d8:	60e2                	ld	ra,24(sp)
    800027da:	6442                	ld	s0,16(sp)
    800027dc:	64a2                	ld	s1,8(sp)
    800027de:	6105                	addi	sp,sp,32
    800027e0:	8082                	ret
    panic("bwrite");
    800027e2:	00006517          	auipc	a0,0x6
    800027e6:	dd650513          	addi	a0,a0,-554 # 800085b8 <syscalls+0x138>
    800027ea:	00004097          	auipc	ra,0x4
    800027ee:	c78080e7          	jalr	-904(ra) # 80006462 <panic>

00000000800027f2 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    800027f2:	1101                	addi	sp,sp,-32
    800027f4:	ec06                	sd	ra,24(sp)
    800027f6:	e822                	sd	s0,16(sp)
    800027f8:	e426                	sd	s1,8(sp)
    800027fa:	e04a                	sd	s2,0(sp)
    800027fc:	1000                	addi	s0,sp,32
    800027fe:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002800:	01050913          	addi	s2,a0,16
    80002804:	854a                	mv	a0,s2
    80002806:	00001097          	auipc	ra,0x1
    8000280a:	646080e7          	jalr	1606(ra) # 80003e4c <holdingsleep>
    8000280e:	c92d                	beqz	a0,80002880 <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    80002810:	854a                	mv	a0,s2
    80002812:	00001097          	auipc	ra,0x1
    80002816:	5f6080e7          	jalr	1526(ra) # 80003e08 <releasesleep>

  acquire(&bcache.lock);
    8000281a:	0000c517          	auipc	a0,0xc
    8000281e:	67e50513          	addi	a0,a0,1662 # 8000ee98 <bcache>
    80002822:	00004097          	auipc	ra,0x4
    80002826:	18a080e7          	jalr	394(ra) # 800069ac <acquire>
  b->refcnt--;
    8000282a:	40bc                	lw	a5,64(s1)
    8000282c:	37fd                	addiw	a5,a5,-1
    8000282e:	0007871b          	sext.w	a4,a5
    80002832:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    80002834:	eb05                	bnez	a4,80002864 <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80002836:	68bc                	ld	a5,80(s1)
    80002838:	64b8                	ld	a4,72(s1)
    8000283a:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    8000283c:	64bc                	ld	a5,72(s1)
    8000283e:	68b8                	ld	a4,80(s1)
    80002840:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80002842:	00014797          	auipc	a5,0x14
    80002846:	65678793          	addi	a5,a5,1622 # 80016e98 <bcache+0x8000>
    8000284a:	2b87b703          	ld	a4,696(a5)
    8000284e:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    80002850:	00015717          	auipc	a4,0x15
    80002854:	8b070713          	addi	a4,a4,-1872 # 80017100 <bcache+0x8268>
    80002858:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    8000285a:	2b87b703          	ld	a4,696(a5)
    8000285e:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    80002860:	2a97bc23          	sd	s1,696(a5)
  }

  release(&bcache.lock);
    80002864:	0000c517          	auipc	a0,0xc
    80002868:	63450513          	addi	a0,a0,1588 # 8000ee98 <bcache>
    8000286c:	00004097          	auipc	ra,0x4
    80002870:	1f4080e7          	jalr	500(ra) # 80006a60 <release>
}
    80002874:	60e2                	ld	ra,24(sp)
    80002876:	6442                	ld	s0,16(sp)
    80002878:	64a2                	ld	s1,8(sp)
    8000287a:	6902                	ld	s2,0(sp)
    8000287c:	6105                	addi	sp,sp,32
    8000287e:	8082                	ret
    panic("brelse");
    80002880:	00006517          	auipc	a0,0x6
    80002884:	d4050513          	addi	a0,a0,-704 # 800085c0 <syscalls+0x140>
    80002888:	00004097          	auipc	ra,0x4
    8000288c:	bda080e7          	jalr	-1062(ra) # 80006462 <panic>

0000000080002890 <bpin>:

void
bpin(struct buf *b) {
    80002890:	1101                	addi	sp,sp,-32
    80002892:	ec06                	sd	ra,24(sp)
    80002894:	e822                	sd	s0,16(sp)
    80002896:	e426                	sd	s1,8(sp)
    80002898:	1000                	addi	s0,sp,32
    8000289a:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    8000289c:	0000c517          	auipc	a0,0xc
    800028a0:	5fc50513          	addi	a0,a0,1532 # 8000ee98 <bcache>
    800028a4:	00004097          	auipc	ra,0x4
    800028a8:	108080e7          	jalr	264(ra) # 800069ac <acquire>
  b->refcnt++;
    800028ac:	40bc                	lw	a5,64(s1)
    800028ae:	2785                	addiw	a5,a5,1
    800028b0:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800028b2:	0000c517          	auipc	a0,0xc
    800028b6:	5e650513          	addi	a0,a0,1510 # 8000ee98 <bcache>
    800028ba:	00004097          	auipc	ra,0x4
    800028be:	1a6080e7          	jalr	422(ra) # 80006a60 <release>
}
    800028c2:	60e2                	ld	ra,24(sp)
    800028c4:	6442                	ld	s0,16(sp)
    800028c6:	64a2                	ld	s1,8(sp)
    800028c8:	6105                	addi	sp,sp,32
    800028ca:	8082                	ret

00000000800028cc <bunpin>:

void
bunpin(struct buf *b) {
    800028cc:	1101                	addi	sp,sp,-32
    800028ce:	ec06                	sd	ra,24(sp)
    800028d0:	e822                	sd	s0,16(sp)
    800028d2:	e426                	sd	s1,8(sp)
    800028d4:	1000                	addi	s0,sp,32
    800028d6:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800028d8:	0000c517          	auipc	a0,0xc
    800028dc:	5c050513          	addi	a0,a0,1472 # 8000ee98 <bcache>
    800028e0:	00004097          	auipc	ra,0x4
    800028e4:	0cc080e7          	jalr	204(ra) # 800069ac <acquire>
  b->refcnt--;
    800028e8:	40bc                	lw	a5,64(s1)
    800028ea:	37fd                	addiw	a5,a5,-1
    800028ec:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800028ee:	0000c517          	auipc	a0,0xc
    800028f2:	5aa50513          	addi	a0,a0,1450 # 8000ee98 <bcache>
    800028f6:	00004097          	auipc	ra,0x4
    800028fa:	16a080e7          	jalr	362(ra) # 80006a60 <release>
}
    800028fe:	60e2                	ld	ra,24(sp)
    80002900:	6442                	ld	s0,16(sp)
    80002902:	64a2                	ld	s1,8(sp)
    80002904:	6105                	addi	sp,sp,32
    80002906:	8082                	ret

0000000080002908 <write_page_to_disk>:

/* NTU OS 2024 */
/* Write 4096 bytes page to the eight consecutive 512-byte blocks starting at blk. */
void write_page_to_disk(uint dev, char *page, uint blk) {
    80002908:	7179                	addi	sp,sp,-48
    8000290a:	f406                	sd	ra,40(sp)
    8000290c:	f022                	sd	s0,32(sp)
    8000290e:	ec26                	sd	s1,24(sp)
    80002910:	e84a                	sd	s2,16(sp)
    80002912:	e44e                	sd	s3,8(sp)
    80002914:	e052                	sd	s4,0(sp)
    80002916:	1800                	addi	s0,sp,48
    80002918:	89b2                	mv	s3,a2
  for (int i = 0; i < 8; i++) {
    8000291a:	892e                	mv	s2,a1
    8000291c:	6a05                	lui	s4,0x1
    8000291e:	9a2e                	add	s4,s4,a1
    // disk
    int offset = i * 512;
    int blk_idx = blk + i;
    struct buf *buffer = bget(ROOTDEV, blk_idx);
    80002920:	85ce                	mv	a1,s3
    80002922:	4505                	li	a0,1
    80002924:	00000097          	auipc	ra,0x0
    80002928:	cf2080e7          	jalr	-782(ra) # 80002616 <bget>
    8000292c:	84aa                	mv	s1,a0
    memmove(buffer->data, page + offset, 512);
    8000292e:	20000613          	li	a2,512
    80002932:	85ca                	mv	a1,s2
    80002934:	05850513          	addi	a0,a0,88
    80002938:	ffffe097          	auipc	ra,0xffffe
    8000293c:	8a0080e7          	jalr	-1888(ra) # 800001d8 <memmove>
    bwrite(buffer);
    80002940:	8526                	mv	a0,s1
    80002942:	00000097          	auipc	ra,0x0
    80002946:	e72080e7          	jalr	-398(ra) # 800027b4 <bwrite>
    brelse(buffer);
    8000294a:	8526                	mv	a0,s1
    8000294c:	00000097          	auipc	ra,0x0
    80002950:	ea6080e7          	jalr	-346(ra) # 800027f2 <brelse>
  for (int i = 0; i < 8; i++) {
    80002954:	2985                	addiw	s3,s3,1
    80002956:	20090913          	addi	s2,s2,512
    8000295a:	fd4913e3          	bne	s2,s4,80002920 <write_page_to_disk+0x18>
  }
}
    8000295e:	70a2                	ld	ra,40(sp)
    80002960:	7402                	ld	s0,32(sp)
    80002962:	64e2                	ld	s1,24(sp)
    80002964:	6942                	ld	s2,16(sp)
    80002966:	69a2                	ld	s3,8(sp)
    80002968:	6a02                	ld	s4,0(sp)
    8000296a:	6145                	addi	sp,sp,48
    8000296c:	8082                	ret

000000008000296e <read_page_from_disk>:

/* NTU OS 2024 */
/* Read 4096 bytes from the eight consecutive 512-byte blocks starting at blk into page. */
void read_page_from_disk(uint dev, char *page, uint blk) {
    8000296e:	7179                	addi	sp,sp,-48
    80002970:	f406                	sd	ra,40(sp)
    80002972:	f022                	sd	s0,32(sp)
    80002974:	ec26                	sd	s1,24(sp)
    80002976:	e84a                	sd	s2,16(sp)
    80002978:	e44e                	sd	s3,8(sp)
    8000297a:	e052                	sd	s4,0(sp)
    8000297c:	1800                	addi	s0,sp,48
    8000297e:	89b2                	mv	s3,a2
  for (int i = 0; i < 8; i++) {
    80002980:	892e                	mv	s2,a1
    80002982:	6a05                	lui	s4,0x1
    80002984:	9a2e                	add	s4,s4,a1
    int offset = i * 512;
    int blk_idx = blk + i;
    struct buf *buffer = bread(ROOTDEV, blk_idx);
    80002986:	85ce                	mv	a1,s3
    80002988:	4505                	li	a0,1
    8000298a:	00000097          	auipc	ra,0x0
    8000298e:	df6080e7          	jalr	-522(ra) # 80002780 <bread>
    80002992:	84aa                	mv	s1,a0
    memmove(page + offset, buffer->data, 512);
    80002994:	20000613          	li	a2,512
    80002998:	05850593          	addi	a1,a0,88
    8000299c:	854a                	mv	a0,s2
    8000299e:	ffffe097          	auipc	ra,0xffffe
    800029a2:	83a080e7          	jalr	-1990(ra) # 800001d8 <memmove>
    brelse(buffer);
    800029a6:	8526                	mv	a0,s1
    800029a8:	00000097          	auipc	ra,0x0
    800029ac:	e4a080e7          	jalr	-438(ra) # 800027f2 <brelse>
  for (int i = 0; i < 8; i++) {
    800029b0:	2985                	addiw	s3,s3,1
    800029b2:	20090913          	addi	s2,s2,512
    800029b6:	fd4918e3          	bne	s2,s4,80002986 <read_page_from_disk+0x18>
  }
}
    800029ba:	70a2                	ld	ra,40(sp)
    800029bc:	7402                	ld	s0,32(sp)
    800029be:	64e2                	ld	s1,24(sp)
    800029c0:	6942                	ld	s2,16(sp)
    800029c2:	69a2                	ld	s3,8(sp)
    800029c4:	6a02                	ld	s4,0(sp)
    800029c6:	6145                	addi	sp,sp,48
    800029c8:	8082                	ret

00000000800029ca <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    800029ca:	1101                	addi	sp,sp,-32
    800029cc:	ec06                	sd	ra,24(sp)
    800029ce:	e822                	sd	s0,16(sp)
    800029d0:	e426                	sd	s1,8(sp)
    800029d2:	1000                	addi	s0,sp,32
    800029d4:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    800029d6:	00d5d59b          	srliw	a1,a1,0xd
    800029da:	00015797          	auipc	a5,0x15
    800029de:	b9a7a783          	lw	a5,-1126(a5) # 80017574 <sb+0x1c>
    800029e2:	9dbd                	addw	a1,a1,a5
    800029e4:	00000097          	auipc	ra,0x0
    800029e8:	d9c080e7          	jalr	-612(ra) # 80002780 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    800029ec:	0074f713          	andi	a4,s1,7
    800029f0:	4785                	li	a5,1
    800029f2:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    800029f6:	14ce                	slli	s1,s1,0x33
    800029f8:	90d9                	srli	s1,s1,0x36
    800029fa:	00950733          	add	a4,a0,s1
    800029fe:	05874703          	lbu	a4,88(a4)
    80002a02:	00e7f6b3          	and	a3,a5,a4
    80002a06:	c285                	beqz	a3,80002a26 <bfree+0x5c>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    80002a08:	94aa                	add	s1,s1,a0
    80002a0a:	fff7c793          	not	a5,a5
    80002a0e:	8ff9                	and	a5,a5,a4
    80002a10:	04f48c23          	sb	a5,88(s1)
  //log_write(bp);
  brelse(bp);
    80002a14:	00000097          	auipc	ra,0x0
    80002a18:	dde080e7          	jalr	-546(ra) # 800027f2 <brelse>
}
    80002a1c:	60e2                	ld	ra,24(sp)
    80002a1e:	6442                	ld	s0,16(sp)
    80002a20:	64a2                	ld	s1,8(sp)
    80002a22:	6105                	addi	sp,sp,32
    80002a24:	8082                	ret
    panic("freeing free block");
    80002a26:	00006517          	auipc	a0,0x6
    80002a2a:	ba250513          	addi	a0,a0,-1118 # 800085c8 <syscalls+0x148>
    80002a2e:	00004097          	auipc	ra,0x4
    80002a32:	a34080e7          	jalr	-1484(ra) # 80006462 <panic>

0000000080002a36 <bzero>:
{
    80002a36:	1101                	addi	sp,sp,-32
    80002a38:	ec06                	sd	ra,24(sp)
    80002a3a:	e822                	sd	s0,16(sp)
    80002a3c:	e426                	sd	s1,8(sp)
    80002a3e:	1000                	addi	s0,sp,32
  bp = bread(dev, bno);
    80002a40:	00000097          	auipc	ra,0x0
    80002a44:	d40080e7          	jalr	-704(ra) # 80002780 <bread>
    80002a48:	84aa                	mv	s1,a0
  memset(bp->data, 0, BSIZE);
    80002a4a:	40000613          	li	a2,1024
    80002a4e:	4581                	li	a1,0
    80002a50:	05850513          	addi	a0,a0,88
    80002a54:	ffffd097          	auipc	ra,0xffffd
    80002a58:	724080e7          	jalr	1828(ra) # 80000178 <memset>
  brelse(bp);
    80002a5c:	8526                	mv	a0,s1
    80002a5e:	00000097          	auipc	ra,0x0
    80002a62:	d94080e7          	jalr	-620(ra) # 800027f2 <brelse>
}
    80002a66:	60e2                	ld	ra,24(sp)
    80002a68:	6442                	ld	s0,16(sp)
    80002a6a:	64a2                	ld	s1,8(sp)
    80002a6c:	6105                	addi	sp,sp,32
    80002a6e:	8082                	ret

0000000080002a70 <balloc>:
{
    80002a70:	711d                	addi	sp,sp,-96
    80002a72:	ec86                	sd	ra,88(sp)
    80002a74:	e8a2                	sd	s0,80(sp)
    80002a76:	e4a6                	sd	s1,72(sp)
    80002a78:	e0ca                	sd	s2,64(sp)
    80002a7a:	fc4e                	sd	s3,56(sp)
    80002a7c:	f852                	sd	s4,48(sp)
    80002a7e:	f456                	sd	s5,40(sp)
    80002a80:	f05a                	sd	s6,32(sp)
    80002a82:	ec5e                	sd	s7,24(sp)
    80002a84:	e862                	sd	s8,16(sp)
    80002a86:	e466                	sd	s9,8(sp)
    80002a88:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    80002a8a:	00015797          	auipc	a5,0x15
    80002a8e:	ad27a783          	lw	a5,-1326(a5) # 8001755c <sb+0x4>
    80002a92:	cbd1                	beqz	a5,80002b26 <balloc+0xb6>
    80002a94:	8baa                	mv	s7,a0
    80002a96:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80002a98:	00015b17          	auipc	s6,0x15
    80002a9c:	ac0b0b13          	addi	s6,s6,-1344 # 80017558 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002aa0:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    80002aa2:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002aa4:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80002aa6:	6c89                	lui	s9,0x2
    80002aa8:	a829                	j	80002ac2 <balloc+0x52>
    brelse(bp);
    80002aaa:	00000097          	auipc	ra,0x0
    80002aae:	d48080e7          	jalr	-696(ra) # 800027f2 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80002ab2:	015c87bb          	addw	a5,s9,s5
    80002ab6:	00078a9b          	sext.w	s5,a5
    80002aba:	004b2703          	lw	a4,4(s6)
    80002abe:	06eaf463          	bgeu	s5,a4,80002b26 <balloc+0xb6>
    bp = bread(dev, BBLOCK(b, sb));
    80002ac2:	41fad79b          	sraiw	a5,s5,0x1f
    80002ac6:	0137d79b          	srliw	a5,a5,0x13
    80002aca:	015787bb          	addw	a5,a5,s5
    80002ace:	40d7d79b          	sraiw	a5,a5,0xd
    80002ad2:	01cb2583          	lw	a1,28(s6)
    80002ad6:	9dbd                	addw	a1,a1,a5
    80002ad8:	855e                	mv	a0,s7
    80002ada:	00000097          	auipc	ra,0x0
    80002ade:	ca6080e7          	jalr	-858(ra) # 80002780 <bread>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002ae2:	004b2803          	lw	a6,4(s6)
    80002ae6:	000a849b          	sext.w	s1,s5
    80002aea:	8662                	mv	a2,s8
    80002aec:	0004891b          	sext.w	s2,s1
    80002af0:	fb04fde3          	bgeu	s1,a6,80002aaa <balloc+0x3a>
      m = 1 << (bi % 8);
    80002af4:	41f6579b          	sraiw	a5,a2,0x1f
    80002af8:	01d7d69b          	srliw	a3,a5,0x1d
    80002afc:	00c6873b          	addw	a4,a3,a2
    80002b00:	00777793          	andi	a5,a4,7
    80002b04:	9f95                	subw	a5,a5,a3
    80002b06:	00f997bb          	sllw	a5,s3,a5
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80002b0a:	4037571b          	sraiw	a4,a4,0x3
    80002b0e:	00e506b3          	add	a3,a0,a4
    80002b12:	0586c683          	lbu	a3,88(a3)
    80002b16:	00d7f5b3          	and	a1,a5,a3
    80002b1a:	cd91                	beqz	a1,80002b36 <balloc+0xc6>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002b1c:	2605                	addiw	a2,a2,1
    80002b1e:	2485                	addiw	s1,s1,1
    80002b20:	fd4616e3          	bne	a2,s4,80002aec <balloc+0x7c>
    80002b24:	b759                	j	80002aaa <balloc+0x3a>
  panic("balloc: out of blocks");
    80002b26:	00006517          	auipc	a0,0x6
    80002b2a:	aba50513          	addi	a0,a0,-1350 # 800085e0 <syscalls+0x160>
    80002b2e:	00004097          	auipc	ra,0x4
    80002b32:	934080e7          	jalr	-1740(ra) # 80006462 <panic>
        bp->data[bi/8] |= m;  // Mark block in use.
    80002b36:	972a                	add	a4,a4,a0
    80002b38:	8fd5                	or	a5,a5,a3
    80002b3a:	04f70c23          	sb	a5,88(a4)
        brelse(bp);
    80002b3e:	00000097          	auipc	ra,0x0
    80002b42:	cb4080e7          	jalr	-844(ra) # 800027f2 <brelse>
        bzero(dev, b + bi);
    80002b46:	85ca                	mv	a1,s2
    80002b48:	855e                	mv	a0,s7
    80002b4a:	00000097          	auipc	ra,0x0
    80002b4e:	eec080e7          	jalr	-276(ra) # 80002a36 <bzero>
}
    80002b52:	8526                	mv	a0,s1
    80002b54:	60e6                	ld	ra,88(sp)
    80002b56:	6446                	ld	s0,80(sp)
    80002b58:	64a6                	ld	s1,72(sp)
    80002b5a:	6906                	ld	s2,64(sp)
    80002b5c:	79e2                	ld	s3,56(sp)
    80002b5e:	7a42                	ld	s4,48(sp)
    80002b60:	7aa2                	ld	s5,40(sp)
    80002b62:	7b02                	ld	s6,32(sp)
    80002b64:	6be2                	ld	s7,24(sp)
    80002b66:	6c42                	ld	s8,16(sp)
    80002b68:	6ca2                	ld	s9,8(sp)
    80002b6a:	6125                	addi	sp,sp,96
    80002b6c:	8082                	ret

0000000080002b6e <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    80002b6e:	7179                	addi	sp,sp,-48
    80002b70:	f406                	sd	ra,40(sp)
    80002b72:	f022                	sd	s0,32(sp)
    80002b74:	ec26                	sd	s1,24(sp)
    80002b76:	e84a                	sd	s2,16(sp)
    80002b78:	e44e                	sd	s3,8(sp)
    80002b7a:	e052                	sd	s4,0(sp)
    80002b7c:	1800                	addi	s0,sp,48
    80002b7e:	892a                	mv	s2,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80002b80:	47ad                	li	a5,11
    80002b82:	04b7fe63          	bgeu	a5,a1,80002bde <bmap+0x70>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
    80002b86:	ff45849b          	addiw	s1,a1,-12
    80002b8a:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    80002b8e:	0ff00793          	li	a5,255
    80002b92:	08e7ee63          	bltu	a5,a4,80002c2e <bmap+0xc0>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    80002b96:	08052583          	lw	a1,128(a0)
    80002b9a:	c5ad                	beqz	a1,80002c04 <bmap+0x96>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    80002b9c:	00092503          	lw	a0,0(s2)
    80002ba0:	00000097          	auipc	ra,0x0
    80002ba4:	be0080e7          	jalr	-1056(ra) # 80002780 <bread>
    80002ba8:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80002baa:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    80002bae:	02049593          	slli	a1,s1,0x20
    80002bb2:	9181                	srli	a1,a1,0x20
    80002bb4:	058a                	slli	a1,a1,0x2
    80002bb6:	00b784b3          	add	s1,a5,a1
    80002bba:	0004a983          	lw	s3,0(s1)
    80002bbe:	04098d63          	beqz	s3,80002c18 <bmap+0xaa>
      a[bn] = addr = balloc(ip->dev);
      //log_write(bp);
    }
    brelse(bp);
    80002bc2:	8552                	mv	a0,s4
    80002bc4:	00000097          	auipc	ra,0x0
    80002bc8:	c2e080e7          	jalr	-978(ra) # 800027f2 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    80002bcc:	854e                	mv	a0,s3
    80002bce:	70a2                	ld	ra,40(sp)
    80002bd0:	7402                	ld	s0,32(sp)
    80002bd2:	64e2                	ld	s1,24(sp)
    80002bd4:	6942                	ld	s2,16(sp)
    80002bd6:	69a2                	ld	s3,8(sp)
    80002bd8:	6a02                	ld	s4,0(sp)
    80002bda:	6145                	addi	sp,sp,48
    80002bdc:	8082                	ret
    if((addr = ip->addrs[bn]) == 0)
    80002bde:	02059493          	slli	s1,a1,0x20
    80002be2:	9081                	srli	s1,s1,0x20
    80002be4:	048a                	slli	s1,s1,0x2
    80002be6:	94aa                	add	s1,s1,a0
    80002be8:	0504a983          	lw	s3,80(s1)
    80002bec:	fe0990e3          	bnez	s3,80002bcc <bmap+0x5e>
      ip->addrs[bn] = addr = balloc(ip->dev);
    80002bf0:	4108                	lw	a0,0(a0)
    80002bf2:	00000097          	auipc	ra,0x0
    80002bf6:	e7e080e7          	jalr	-386(ra) # 80002a70 <balloc>
    80002bfa:	0005099b          	sext.w	s3,a0
    80002bfe:	0534a823          	sw	s3,80(s1)
    80002c02:	b7e9                	j	80002bcc <bmap+0x5e>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    80002c04:	4108                	lw	a0,0(a0)
    80002c06:	00000097          	auipc	ra,0x0
    80002c0a:	e6a080e7          	jalr	-406(ra) # 80002a70 <balloc>
    80002c0e:	0005059b          	sext.w	a1,a0
    80002c12:	08b92023          	sw	a1,128(s2)
    80002c16:	b759                	j	80002b9c <bmap+0x2e>
      a[bn] = addr = balloc(ip->dev);
    80002c18:	00092503          	lw	a0,0(s2)
    80002c1c:	00000097          	auipc	ra,0x0
    80002c20:	e54080e7          	jalr	-428(ra) # 80002a70 <balloc>
    80002c24:	0005099b          	sext.w	s3,a0
    80002c28:	0134a023          	sw	s3,0(s1)
    80002c2c:	bf59                	j	80002bc2 <bmap+0x54>
  panic("bmap: out of range");
    80002c2e:	00006517          	auipc	a0,0x6
    80002c32:	9ca50513          	addi	a0,a0,-1590 # 800085f8 <syscalls+0x178>
    80002c36:	00004097          	auipc	ra,0x4
    80002c3a:	82c080e7          	jalr	-2004(ra) # 80006462 <panic>

0000000080002c3e <iget>:
{
    80002c3e:	7179                	addi	sp,sp,-48
    80002c40:	f406                	sd	ra,40(sp)
    80002c42:	f022                	sd	s0,32(sp)
    80002c44:	ec26                	sd	s1,24(sp)
    80002c46:	e84a                	sd	s2,16(sp)
    80002c48:	e44e                	sd	s3,8(sp)
    80002c4a:	e052                	sd	s4,0(sp)
    80002c4c:	1800                	addi	s0,sp,48
    80002c4e:	89aa                	mv	s3,a0
    80002c50:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    80002c52:	00015517          	auipc	a0,0x15
    80002c56:	92650513          	addi	a0,a0,-1754 # 80017578 <itable>
    80002c5a:	00004097          	auipc	ra,0x4
    80002c5e:	d52080e7          	jalr	-686(ra) # 800069ac <acquire>
  empty = 0;
    80002c62:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002c64:	00015497          	auipc	s1,0x15
    80002c68:	92c48493          	addi	s1,s1,-1748 # 80017590 <itable+0x18>
    80002c6c:	00016697          	auipc	a3,0x16
    80002c70:	3b468693          	addi	a3,a3,948 # 80019020 <log>
    80002c74:	a039                	j	80002c82 <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002c76:	02090b63          	beqz	s2,80002cac <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002c7a:	08848493          	addi	s1,s1,136
    80002c7e:	02d48a63          	beq	s1,a3,80002cb2 <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80002c82:	449c                	lw	a5,8(s1)
    80002c84:	fef059e3          	blez	a5,80002c76 <iget+0x38>
    80002c88:	4098                	lw	a4,0(s1)
    80002c8a:	ff3716e3          	bne	a4,s3,80002c76 <iget+0x38>
    80002c8e:	40d8                	lw	a4,4(s1)
    80002c90:	ff4713e3          	bne	a4,s4,80002c76 <iget+0x38>
      ip->ref++;
    80002c94:	2785                	addiw	a5,a5,1
    80002c96:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    80002c98:	00015517          	auipc	a0,0x15
    80002c9c:	8e050513          	addi	a0,a0,-1824 # 80017578 <itable>
    80002ca0:	00004097          	auipc	ra,0x4
    80002ca4:	dc0080e7          	jalr	-576(ra) # 80006a60 <release>
      return ip;
    80002ca8:	8926                	mv	s2,s1
    80002caa:	a03d                	j	80002cd8 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002cac:	f7f9                	bnez	a5,80002c7a <iget+0x3c>
    80002cae:	8926                	mv	s2,s1
    80002cb0:	b7e9                	j	80002c7a <iget+0x3c>
  if(empty == 0)
    80002cb2:	02090c63          	beqz	s2,80002cea <iget+0xac>
  ip->dev = dev;
    80002cb6:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80002cba:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    80002cbe:	4785                	li	a5,1
    80002cc0:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80002cc4:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    80002cc8:	00015517          	auipc	a0,0x15
    80002ccc:	8b050513          	addi	a0,a0,-1872 # 80017578 <itable>
    80002cd0:	00004097          	auipc	ra,0x4
    80002cd4:	d90080e7          	jalr	-624(ra) # 80006a60 <release>
}
    80002cd8:	854a                	mv	a0,s2
    80002cda:	70a2                	ld	ra,40(sp)
    80002cdc:	7402                	ld	s0,32(sp)
    80002cde:	64e2                	ld	s1,24(sp)
    80002ce0:	6942                	ld	s2,16(sp)
    80002ce2:	69a2                	ld	s3,8(sp)
    80002ce4:	6a02                	ld	s4,0(sp)
    80002ce6:	6145                	addi	sp,sp,48
    80002ce8:	8082                	ret
    panic("iget: no inodes");
    80002cea:	00006517          	auipc	a0,0x6
    80002cee:	92650513          	addi	a0,a0,-1754 # 80008610 <syscalls+0x190>
    80002cf2:	00003097          	auipc	ra,0x3
    80002cf6:	770080e7          	jalr	1904(ra) # 80006462 <panic>

0000000080002cfa <fsinit>:
fsinit(int dev) {
    80002cfa:	7179                	addi	sp,sp,-48
    80002cfc:	f406                	sd	ra,40(sp)
    80002cfe:	f022                	sd	s0,32(sp)
    80002d00:	ec26                	sd	s1,24(sp)
    80002d02:	e84a                	sd	s2,16(sp)
    80002d04:	e44e                	sd	s3,8(sp)
    80002d06:	1800                	addi	s0,sp,48
    80002d08:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80002d0a:	4585                	li	a1,1
    80002d0c:	00000097          	auipc	ra,0x0
    80002d10:	a74080e7          	jalr	-1420(ra) # 80002780 <bread>
    80002d14:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80002d16:	00015997          	auipc	s3,0x15
    80002d1a:	84298993          	addi	s3,s3,-1982 # 80017558 <sb>
    80002d1e:	02000613          	li	a2,32
    80002d22:	05850593          	addi	a1,a0,88
    80002d26:	854e                	mv	a0,s3
    80002d28:	ffffd097          	auipc	ra,0xffffd
    80002d2c:	4b0080e7          	jalr	1200(ra) # 800001d8 <memmove>
  brelse(bp);
    80002d30:	8526                	mv	a0,s1
    80002d32:	00000097          	auipc	ra,0x0
    80002d36:	ac0080e7          	jalr	-1344(ra) # 800027f2 <brelse>
  if(sb.magic != FSMAGIC)
    80002d3a:	0009a703          	lw	a4,0(s3)
    80002d3e:	102037b7          	lui	a5,0x10203
    80002d42:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80002d46:	02f71263          	bne	a4,a5,80002d6a <fsinit+0x70>
  initlog(dev, &sb);
    80002d4a:	00015597          	auipc	a1,0x15
    80002d4e:	80e58593          	addi	a1,a1,-2034 # 80017558 <sb>
    80002d52:	854a                	mv	a0,s2
    80002d54:	00001097          	auipc	ra,0x1
    80002d58:	cc2080e7          	jalr	-830(ra) # 80003a16 <initlog>
}
    80002d5c:	70a2                	ld	ra,40(sp)
    80002d5e:	7402                	ld	s0,32(sp)
    80002d60:	64e2                	ld	s1,24(sp)
    80002d62:	6942                	ld	s2,16(sp)
    80002d64:	69a2                	ld	s3,8(sp)
    80002d66:	6145                	addi	sp,sp,48
    80002d68:	8082                	ret
    panic("invalid file system");
    80002d6a:	00006517          	auipc	a0,0x6
    80002d6e:	8b650513          	addi	a0,a0,-1866 # 80008620 <syscalls+0x1a0>
    80002d72:	00003097          	auipc	ra,0x3
    80002d76:	6f0080e7          	jalr	1776(ra) # 80006462 <panic>

0000000080002d7a <iinit>:
{
    80002d7a:	7179                	addi	sp,sp,-48
    80002d7c:	f406                	sd	ra,40(sp)
    80002d7e:	f022                	sd	s0,32(sp)
    80002d80:	ec26                	sd	s1,24(sp)
    80002d82:	e84a                	sd	s2,16(sp)
    80002d84:	e44e                	sd	s3,8(sp)
    80002d86:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    80002d88:	00006597          	auipc	a1,0x6
    80002d8c:	8b058593          	addi	a1,a1,-1872 # 80008638 <syscalls+0x1b8>
    80002d90:	00014517          	auipc	a0,0x14
    80002d94:	7e850513          	addi	a0,a0,2024 # 80017578 <itable>
    80002d98:	00004097          	auipc	ra,0x4
    80002d9c:	b84080e7          	jalr	-1148(ra) # 8000691c <initlock>
  for(i = 0; i < NINODE; i++) {
    80002da0:	00015497          	auipc	s1,0x15
    80002da4:	80048493          	addi	s1,s1,-2048 # 800175a0 <itable+0x28>
    80002da8:	00016997          	auipc	s3,0x16
    80002dac:	28898993          	addi	s3,s3,648 # 80019030 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    80002db0:	00006917          	auipc	s2,0x6
    80002db4:	89090913          	addi	s2,s2,-1904 # 80008640 <syscalls+0x1c0>
    80002db8:	85ca                	mv	a1,s2
    80002dba:	8526                	mv	a0,s1
    80002dbc:	00001097          	auipc	ra,0x1
    80002dc0:	fbc080e7          	jalr	-68(ra) # 80003d78 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80002dc4:	08848493          	addi	s1,s1,136
    80002dc8:	ff3498e3          	bne	s1,s3,80002db8 <iinit+0x3e>
}
    80002dcc:	70a2                	ld	ra,40(sp)
    80002dce:	7402                	ld	s0,32(sp)
    80002dd0:	64e2                	ld	s1,24(sp)
    80002dd2:	6942                	ld	s2,16(sp)
    80002dd4:	69a2                	ld	s3,8(sp)
    80002dd6:	6145                	addi	sp,sp,48
    80002dd8:	8082                	ret

0000000080002dda <ialloc>:
{
    80002dda:	715d                	addi	sp,sp,-80
    80002ddc:	e486                	sd	ra,72(sp)
    80002dde:	e0a2                	sd	s0,64(sp)
    80002de0:	fc26                	sd	s1,56(sp)
    80002de2:	f84a                	sd	s2,48(sp)
    80002de4:	f44e                	sd	s3,40(sp)
    80002de6:	f052                	sd	s4,32(sp)
    80002de8:	ec56                	sd	s5,24(sp)
    80002dea:	e85a                	sd	s6,16(sp)
    80002dec:	e45e                	sd	s7,8(sp)
    80002dee:	0880                	addi	s0,sp,80
  for(inum = 1; inum < sb.ninodes; inum++){
    80002df0:	00014717          	auipc	a4,0x14
    80002df4:	77472703          	lw	a4,1908(a4) # 80017564 <sb+0xc>
    80002df8:	4785                	li	a5,1
    80002dfa:	04e7fa63          	bgeu	a5,a4,80002e4e <ialloc+0x74>
    80002dfe:	8aaa                	mv	s5,a0
    80002e00:	8bae                	mv	s7,a1
    80002e02:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    80002e04:	00014a17          	auipc	s4,0x14
    80002e08:	754a0a13          	addi	s4,s4,1876 # 80017558 <sb>
    80002e0c:	00048b1b          	sext.w	s6,s1
    80002e10:	0044d593          	srli	a1,s1,0x4
    80002e14:	018a2783          	lw	a5,24(s4)
    80002e18:	9dbd                	addw	a1,a1,a5
    80002e1a:	8556                	mv	a0,s5
    80002e1c:	00000097          	auipc	ra,0x0
    80002e20:	964080e7          	jalr	-1692(ra) # 80002780 <bread>
    80002e24:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80002e26:	05850993          	addi	s3,a0,88
    80002e2a:	00f4f793          	andi	a5,s1,15
    80002e2e:	079a                	slli	a5,a5,0x6
    80002e30:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    80002e32:	00099783          	lh	a5,0(s3)
    80002e36:	c785                	beqz	a5,80002e5e <ialloc+0x84>
    brelse(bp);
    80002e38:	00000097          	auipc	ra,0x0
    80002e3c:	9ba080e7          	jalr	-1606(ra) # 800027f2 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80002e40:	0485                	addi	s1,s1,1
    80002e42:	00ca2703          	lw	a4,12(s4)
    80002e46:	0004879b          	sext.w	a5,s1
    80002e4a:	fce7e1e3          	bltu	a5,a4,80002e0c <ialloc+0x32>
  panic("ialloc: no inodes");
    80002e4e:	00005517          	auipc	a0,0x5
    80002e52:	7fa50513          	addi	a0,a0,2042 # 80008648 <syscalls+0x1c8>
    80002e56:	00003097          	auipc	ra,0x3
    80002e5a:	60c080e7          	jalr	1548(ra) # 80006462 <panic>
      memset(dip, 0, sizeof(*dip));
    80002e5e:	04000613          	li	a2,64
    80002e62:	4581                	li	a1,0
    80002e64:	854e                	mv	a0,s3
    80002e66:	ffffd097          	auipc	ra,0xffffd
    80002e6a:	312080e7          	jalr	786(ra) # 80000178 <memset>
      dip->type = type;
    80002e6e:	01799023          	sh	s7,0(s3)
      brelse(bp);
    80002e72:	854a                	mv	a0,s2
    80002e74:	00000097          	auipc	ra,0x0
    80002e78:	97e080e7          	jalr	-1666(ra) # 800027f2 <brelse>
      return iget(dev, inum);
    80002e7c:	85da                	mv	a1,s6
    80002e7e:	8556                	mv	a0,s5
    80002e80:	00000097          	auipc	ra,0x0
    80002e84:	dbe080e7          	jalr	-578(ra) # 80002c3e <iget>
}
    80002e88:	60a6                	ld	ra,72(sp)
    80002e8a:	6406                	ld	s0,64(sp)
    80002e8c:	74e2                	ld	s1,56(sp)
    80002e8e:	7942                	ld	s2,48(sp)
    80002e90:	79a2                	ld	s3,40(sp)
    80002e92:	7a02                	ld	s4,32(sp)
    80002e94:	6ae2                	ld	s5,24(sp)
    80002e96:	6b42                	ld	s6,16(sp)
    80002e98:	6ba2                	ld	s7,8(sp)
    80002e9a:	6161                	addi	sp,sp,80
    80002e9c:	8082                	ret

0000000080002e9e <iupdate>:
{
    80002e9e:	1101                	addi	sp,sp,-32
    80002ea0:	ec06                	sd	ra,24(sp)
    80002ea2:	e822                	sd	s0,16(sp)
    80002ea4:	e426                	sd	s1,8(sp)
    80002ea6:	e04a                	sd	s2,0(sp)
    80002ea8:	1000                	addi	s0,sp,32
    80002eaa:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002eac:	415c                	lw	a5,4(a0)
    80002eae:	0047d79b          	srliw	a5,a5,0x4
    80002eb2:	00014597          	auipc	a1,0x14
    80002eb6:	6be5a583          	lw	a1,1726(a1) # 80017570 <sb+0x18>
    80002eba:	9dbd                	addw	a1,a1,a5
    80002ebc:	4108                	lw	a0,0(a0)
    80002ebe:	00000097          	auipc	ra,0x0
    80002ec2:	8c2080e7          	jalr	-1854(ra) # 80002780 <bread>
    80002ec6:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002ec8:	05850793          	addi	a5,a0,88
    80002ecc:	40d8                	lw	a4,4(s1)
    80002ece:	8b3d                	andi	a4,a4,15
    80002ed0:	071a                	slli	a4,a4,0x6
    80002ed2:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    80002ed4:	04449703          	lh	a4,68(s1)
    80002ed8:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80002edc:	04649703          	lh	a4,70(s1)
    80002ee0:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80002ee4:	04849703          	lh	a4,72(s1)
    80002ee8:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80002eec:	04a49703          	lh	a4,74(s1)
    80002ef0:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80002ef4:	44f8                	lw	a4,76(s1)
    80002ef6:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002ef8:	03400613          	li	a2,52
    80002efc:	05048593          	addi	a1,s1,80
    80002f00:	00c78513          	addi	a0,a5,12
    80002f04:	ffffd097          	auipc	ra,0xffffd
    80002f08:	2d4080e7          	jalr	724(ra) # 800001d8 <memmove>
  brelse(bp);
    80002f0c:	854a                	mv	a0,s2
    80002f0e:	00000097          	auipc	ra,0x0
    80002f12:	8e4080e7          	jalr	-1820(ra) # 800027f2 <brelse>
}
    80002f16:	60e2                	ld	ra,24(sp)
    80002f18:	6442                	ld	s0,16(sp)
    80002f1a:	64a2                	ld	s1,8(sp)
    80002f1c:	6902                	ld	s2,0(sp)
    80002f1e:	6105                	addi	sp,sp,32
    80002f20:	8082                	ret

0000000080002f22 <idup>:
{
    80002f22:	1101                	addi	sp,sp,-32
    80002f24:	ec06                	sd	ra,24(sp)
    80002f26:	e822                	sd	s0,16(sp)
    80002f28:	e426                	sd	s1,8(sp)
    80002f2a:	1000                	addi	s0,sp,32
    80002f2c:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002f2e:	00014517          	auipc	a0,0x14
    80002f32:	64a50513          	addi	a0,a0,1610 # 80017578 <itable>
    80002f36:	00004097          	auipc	ra,0x4
    80002f3a:	a76080e7          	jalr	-1418(ra) # 800069ac <acquire>
  ip->ref++;
    80002f3e:	449c                	lw	a5,8(s1)
    80002f40:	2785                	addiw	a5,a5,1
    80002f42:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002f44:	00014517          	auipc	a0,0x14
    80002f48:	63450513          	addi	a0,a0,1588 # 80017578 <itable>
    80002f4c:	00004097          	auipc	ra,0x4
    80002f50:	b14080e7          	jalr	-1260(ra) # 80006a60 <release>
}
    80002f54:	8526                	mv	a0,s1
    80002f56:	60e2                	ld	ra,24(sp)
    80002f58:	6442                	ld	s0,16(sp)
    80002f5a:	64a2                	ld	s1,8(sp)
    80002f5c:	6105                	addi	sp,sp,32
    80002f5e:	8082                	ret

0000000080002f60 <ilock>:
{
    80002f60:	1101                	addi	sp,sp,-32
    80002f62:	ec06                	sd	ra,24(sp)
    80002f64:	e822                	sd	s0,16(sp)
    80002f66:	e426                	sd	s1,8(sp)
    80002f68:	e04a                	sd	s2,0(sp)
    80002f6a:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80002f6c:	c115                	beqz	a0,80002f90 <ilock+0x30>
    80002f6e:	84aa                	mv	s1,a0
    80002f70:	451c                	lw	a5,8(a0)
    80002f72:	00f05f63          	blez	a5,80002f90 <ilock+0x30>
  acquiresleep(&ip->lock);
    80002f76:	0541                	addi	a0,a0,16
    80002f78:	00001097          	auipc	ra,0x1
    80002f7c:	e3a080e7          	jalr	-454(ra) # 80003db2 <acquiresleep>
  if(ip->valid == 0){
    80002f80:	40bc                	lw	a5,64(s1)
    80002f82:	cf99                	beqz	a5,80002fa0 <ilock+0x40>
}
    80002f84:	60e2                	ld	ra,24(sp)
    80002f86:	6442                	ld	s0,16(sp)
    80002f88:	64a2                	ld	s1,8(sp)
    80002f8a:	6902                	ld	s2,0(sp)
    80002f8c:	6105                	addi	sp,sp,32
    80002f8e:	8082                	ret
    panic("ilock");
    80002f90:	00005517          	auipc	a0,0x5
    80002f94:	6d050513          	addi	a0,a0,1744 # 80008660 <syscalls+0x1e0>
    80002f98:	00003097          	auipc	ra,0x3
    80002f9c:	4ca080e7          	jalr	1226(ra) # 80006462 <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002fa0:	40dc                	lw	a5,4(s1)
    80002fa2:	0047d79b          	srliw	a5,a5,0x4
    80002fa6:	00014597          	auipc	a1,0x14
    80002faa:	5ca5a583          	lw	a1,1482(a1) # 80017570 <sb+0x18>
    80002fae:	9dbd                	addw	a1,a1,a5
    80002fb0:	4088                	lw	a0,0(s1)
    80002fb2:	fffff097          	auipc	ra,0xfffff
    80002fb6:	7ce080e7          	jalr	1998(ra) # 80002780 <bread>
    80002fba:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002fbc:	05850593          	addi	a1,a0,88
    80002fc0:	40dc                	lw	a5,4(s1)
    80002fc2:	8bbd                	andi	a5,a5,15
    80002fc4:	079a                	slli	a5,a5,0x6
    80002fc6:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80002fc8:	00059783          	lh	a5,0(a1)
    80002fcc:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80002fd0:	00259783          	lh	a5,2(a1)
    80002fd4:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80002fd8:	00459783          	lh	a5,4(a1)
    80002fdc:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80002fe0:	00659783          	lh	a5,6(a1)
    80002fe4:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80002fe8:	459c                	lw	a5,8(a1)
    80002fea:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002fec:	03400613          	li	a2,52
    80002ff0:	05b1                	addi	a1,a1,12
    80002ff2:	05048513          	addi	a0,s1,80
    80002ff6:	ffffd097          	auipc	ra,0xffffd
    80002ffa:	1e2080e7          	jalr	482(ra) # 800001d8 <memmove>
    brelse(bp);
    80002ffe:	854a                	mv	a0,s2
    80003000:	fffff097          	auipc	ra,0xfffff
    80003004:	7f2080e7          	jalr	2034(ra) # 800027f2 <brelse>
    ip->valid = 1;
    80003008:	4785                	li	a5,1
    8000300a:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    8000300c:	04449783          	lh	a5,68(s1)
    80003010:	fbb5                	bnez	a5,80002f84 <ilock+0x24>
      panic("ilock: no type");
    80003012:	00005517          	auipc	a0,0x5
    80003016:	65650513          	addi	a0,a0,1622 # 80008668 <syscalls+0x1e8>
    8000301a:	00003097          	auipc	ra,0x3
    8000301e:	448080e7          	jalr	1096(ra) # 80006462 <panic>

0000000080003022 <iunlock>:
{
    80003022:	1101                	addi	sp,sp,-32
    80003024:	ec06                	sd	ra,24(sp)
    80003026:	e822                	sd	s0,16(sp)
    80003028:	e426                	sd	s1,8(sp)
    8000302a:	e04a                	sd	s2,0(sp)
    8000302c:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    8000302e:	c905                	beqz	a0,8000305e <iunlock+0x3c>
    80003030:	84aa                	mv	s1,a0
    80003032:	01050913          	addi	s2,a0,16
    80003036:	854a                	mv	a0,s2
    80003038:	00001097          	auipc	ra,0x1
    8000303c:	e14080e7          	jalr	-492(ra) # 80003e4c <holdingsleep>
    80003040:	cd19                	beqz	a0,8000305e <iunlock+0x3c>
    80003042:	449c                	lw	a5,8(s1)
    80003044:	00f05d63          	blez	a5,8000305e <iunlock+0x3c>
  releasesleep(&ip->lock);
    80003048:	854a                	mv	a0,s2
    8000304a:	00001097          	auipc	ra,0x1
    8000304e:	dbe080e7          	jalr	-578(ra) # 80003e08 <releasesleep>
}
    80003052:	60e2                	ld	ra,24(sp)
    80003054:	6442                	ld	s0,16(sp)
    80003056:	64a2                	ld	s1,8(sp)
    80003058:	6902                	ld	s2,0(sp)
    8000305a:	6105                	addi	sp,sp,32
    8000305c:	8082                	ret
    panic("iunlock");
    8000305e:	00005517          	auipc	a0,0x5
    80003062:	61a50513          	addi	a0,a0,1562 # 80008678 <syscalls+0x1f8>
    80003066:	00003097          	auipc	ra,0x3
    8000306a:	3fc080e7          	jalr	1020(ra) # 80006462 <panic>

000000008000306e <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    8000306e:	7179                	addi	sp,sp,-48
    80003070:	f406                	sd	ra,40(sp)
    80003072:	f022                	sd	s0,32(sp)
    80003074:	ec26                	sd	s1,24(sp)
    80003076:	e84a                	sd	s2,16(sp)
    80003078:	e44e                	sd	s3,8(sp)
    8000307a:	e052                	sd	s4,0(sp)
    8000307c:	1800                	addi	s0,sp,48
    8000307e:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80003080:	05050493          	addi	s1,a0,80
    80003084:	08050913          	addi	s2,a0,128
    80003088:	a021                	j	80003090 <itrunc+0x22>
    8000308a:	0491                	addi	s1,s1,4
    8000308c:	01248d63          	beq	s1,s2,800030a6 <itrunc+0x38>
    if(ip->addrs[i]){
    80003090:	408c                	lw	a1,0(s1)
    80003092:	dde5                	beqz	a1,8000308a <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    80003094:	0009a503          	lw	a0,0(s3)
    80003098:	00000097          	auipc	ra,0x0
    8000309c:	932080e7          	jalr	-1742(ra) # 800029ca <bfree>
      ip->addrs[i] = 0;
    800030a0:	0004a023          	sw	zero,0(s1)
    800030a4:	b7dd                	j	8000308a <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    800030a6:	0809a583          	lw	a1,128(s3)
    800030aa:	e185                	bnez	a1,800030ca <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    800030ac:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    800030b0:	854e                	mv	a0,s3
    800030b2:	00000097          	auipc	ra,0x0
    800030b6:	dec080e7          	jalr	-532(ra) # 80002e9e <iupdate>
}
    800030ba:	70a2                	ld	ra,40(sp)
    800030bc:	7402                	ld	s0,32(sp)
    800030be:	64e2                	ld	s1,24(sp)
    800030c0:	6942                	ld	s2,16(sp)
    800030c2:	69a2                	ld	s3,8(sp)
    800030c4:	6a02                	ld	s4,0(sp)
    800030c6:	6145                	addi	sp,sp,48
    800030c8:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    800030ca:	0009a503          	lw	a0,0(s3)
    800030ce:	fffff097          	auipc	ra,0xfffff
    800030d2:	6b2080e7          	jalr	1714(ra) # 80002780 <bread>
    800030d6:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    800030d8:	05850493          	addi	s1,a0,88
    800030dc:	45850913          	addi	s2,a0,1112
    800030e0:	a811                	j	800030f4 <itrunc+0x86>
        bfree(ip->dev, a[j]);
    800030e2:	0009a503          	lw	a0,0(s3)
    800030e6:	00000097          	auipc	ra,0x0
    800030ea:	8e4080e7          	jalr	-1820(ra) # 800029ca <bfree>
    for(j = 0; j < NINDIRECT; j++){
    800030ee:	0491                	addi	s1,s1,4
    800030f0:	01248563          	beq	s1,s2,800030fa <itrunc+0x8c>
      if(a[j])
    800030f4:	408c                	lw	a1,0(s1)
    800030f6:	dde5                	beqz	a1,800030ee <itrunc+0x80>
    800030f8:	b7ed                	j	800030e2 <itrunc+0x74>
    brelse(bp);
    800030fa:	8552                	mv	a0,s4
    800030fc:	fffff097          	auipc	ra,0xfffff
    80003100:	6f6080e7          	jalr	1782(ra) # 800027f2 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80003104:	0809a583          	lw	a1,128(s3)
    80003108:	0009a503          	lw	a0,0(s3)
    8000310c:	00000097          	auipc	ra,0x0
    80003110:	8be080e7          	jalr	-1858(ra) # 800029ca <bfree>
    ip->addrs[NDIRECT] = 0;
    80003114:	0809a023          	sw	zero,128(s3)
    80003118:	bf51                	j	800030ac <itrunc+0x3e>

000000008000311a <iput>:
{
    8000311a:	1101                	addi	sp,sp,-32
    8000311c:	ec06                	sd	ra,24(sp)
    8000311e:	e822                	sd	s0,16(sp)
    80003120:	e426                	sd	s1,8(sp)
    80003122:	e04a                	sd	s2,0(sp)
    80003124:	1000                	addi	s0,sp,32
    80003126:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80003128:	00014517          	auipc	a0,0x14
    8000312c:	45050513          	addi	a0,a0,1104 # 80017578 <itable>
    80003130:	00004097          	auipc	ra,0x4
    80003134:	87c080e7          	jalr	-1924(ra) # 800069ac <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80003138:	4498                	lw	a4,8(s1)
    8000313a:	4785                	li	a5,1
    8000313c:	02f70363          	beq	a4,a5,80003162 <iput+0x48>
  ip->ref--;
    80003140:	449c                	lw	a5,8(s1)
    80003142:	37fd                	addiw	a5,a5,-1
    80003144:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80003146:	00014517          	auipc	a0,0x14
    8000314a:	43250513          	addi	a0,a0,1074 # 80017578 <itable>
    8000314e:	00004097          	auipc	ra,0x4
    80003152:	912080e7          	jalr	-1774(ra) # 80006a60 <release>
}
    80003156:	60e2                	ld	ra,24(sp)
    80003158:	6442                	ld	s0,16(sp)
    8000315a:	64a2                	ld	s1,8(sp)
    8000315c:	6902                	ld	s2,0(sp)
    8000315e:	6105                	addi	sp,sp,32
    80003160:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80003162:	40bc                	lw	a5,64(s1)
    80003164:	dff1                	beqz	a5,80003140 <iput+0x26>
    80003166:	04a49783          	lh	a5,74(s1)
    8000316a:	fbf9                	bnez	a5,80003140 <iput+0x26>
    acquiresleep(&ip->lock);
    8000316c:	01048913          	addi	s2,s1,16
    80003170:	854a                	mv	a0,s2
    80003172:	00001097          	auipc	ra,0x1
    80003176:	c40080e7          	jalr	-960(ra) # 80003db2 <acquiresleep>
    release(&itable.lock);
    8000317a:	00014517          	auipc	a0,0x14
    8000317e:	3fe50513          	addi	a0,a0,1022 # 80017578 <itable>
    80003182:	00004097          	auipc	ra,0x4
    80003186:	8de080e7          	jalr	-1826(ra) # 80006a60 <release>
    itrunc(ip);
    8000318a:	8526                	mv	a0,s1
    8000318c:	00000097          	auipc	ra,0x0
    80003190:	ee2080e7          	jalr	-286(ra) # 8000306e <itrunc>
    ip->type = 0;
    80003194:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80003198:	8526                	mv	a0,s1
    8000319a:	00000097          	auipc	ra,0x0
    8000319e:	d04080e7          	jalr	-764(ra) # 80002e9e <iupdate>
    ip->valid = 0;
    800031a2:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    800031a6:	854a                	mv	a0,s2
    800031a8:	00001097          	auipc	ra,0x1
    800031ac:	c60080e7          	jalr	-928(ra) # 80003e08 <releasesleep>
    acquire(&itable.lock);
    800031b0:	00014517          	auipc	a0,0x14
    800031b4:	3c850513          	addi	a0,a0,968 # 80017578 <itable>
    800031b8:	00003097          	auipc	ra,0x3
    800031bc:	7f4080e7          	jalr	2036(ra) # 800069ac <acquire>
    800031c0:	b741                	j	80003140 <iput+0x26>

00000000800031c2 <iunlockput>:
{
    800031c2:	1101                	addi	sp,sp,-32
    800031c4:	ec06                	sd	ra,24(sp)
    800031c6:	e822                	sd	s0,16(sp)
    800031c8:	e426                	sd	s1,8(sp)
    800031ca:	1000                	addi	s0,sp,32
    800031cc:	84aa                	mv	s1,a0
  iunlock(ip);
    800031ce:	00000097          	auipc	ra,0x0
    800031d2:	e54080e7          	jalr	-428(ra) # 80003022 <iunlock>
  iput(ip);
    800031d6:	8526                	mv	a0,s1
    800031d8:	00000097          	auipc	ra,0x0
    800031dc:	f42080e7          	jalr	-190(ra) # 8000311a <iput>
}
    800031e0:	60e2                	ld	ra,24(sp)
    800031e2:	6442                	ld	s0,16(sp)
    800031e4:	64a2                	ld	s1,8(sp)
    800031e6:	6105                	addi	sp,sp,32
    800031e8:	8082                	ret

00000000800031ea <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    800031ea:	1141                	addi	sp,sp,-16
    800031ec:	e422                	sd	s0,8(sp)
    800031ee:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    800031f0:	411c                	lw	a5,0(a0)
    800031f2:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    800031f4:	415c                	lw	a5,4(a0)
    800031f6:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    800031f8:	04451783          	lh	a5,68(a0)
    800031fc:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80003200:	04a51783          	lh	a5,74(a0)
    80003204:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80003208:	04c56783          	lwu	a5,76(a0)
    8000320c:	e99c                	sd	a5,16(a1)
}
    8000320e:	6422                	ld	s0,8(sp)
    80003210:	0141                	addi	sp,sp,16
    80003212:	8082                	ret

0000000080003214 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003214:	457c                	lw	a5,76(a0)
    80003216:	0ed7e963          	bltu	a5,a3,80003308 <readi+0xf4>
{
    8000321a:	7159                	addi	sp,sp,-112
    8000321c:	f486                	sd	ra,104(sp)
    8000321e:	f0a2                	sd	s0,96(sp)
    80003220:	eca6                	sd	s1,88(sp)
    80003222:	e8ca                	sd	s2,80(sp)
    80003224:	e4ce                	sd	s3,72(sp)
    80003226:	e0d2                	sd	s4,64(sp)
    80003228:	fc56                	sd	s5,56(sp)
    8000322a:	f85a                	sd	s6,48(sp)
    8000322c:	f45e                	sd	s7,40(sp)
    8000322e:	f062                	sd	s8,32(sp)
    80003230:	ec66                	sd	s9,24(sp)
    80003232:	e86a                	sd	s10,16(sp)
    80003234:	e46e                	sd	s11,8(sp)
    80003236:	1880                	addi	s0,sp,112
    80003238:	8baa                	mv	s7,a0
    8000323a:	8c2e                	mv	s8,a1
    8000323c:	8ab2                	mv	s5,a2
    8000323e:	84b6                	mv	s1,a3
    80003240:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80003242:	9f35                	addw	a4,a4,a3
    return 0;
    80003244:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80003246:	0ad76063          	bltu	a4,a3,800032e6 <readi+0xd2>
  if(off + n > ip->size)
    8000324a:	00e7f463          	bgeu	a5,a4,80003252 <readi+0x3e>
    n = ip->size - off;
    8000324e:	40d78b3b          	subw	s6,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003252:	0a0b0963          	beqz	s6,80003304 <readi+0xf0>
    80003256:	4981                	li	s3,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80003258:	40000d13          	li	s10,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    8000325c:	5cfd                	li	s9,-1
    8000325e:	a82d                	j	80003298 <readi+0x84>
    80003260:	020a1d93          	slli	s11,s4,0x20
    80003264:	020ddd93          	srli	s11,s11,0x20
    80003268:	05890613          	addi	a2,s2,88
    8000326c:	86ee                	mv	a3,s11
    8000326e:	963a                	add	a2,a2,a4
    80003270:	85d6                	mv	a1,s5
    80003272:	8562                	mv	a0,s8
    80003274:	fffff097          	auipc	ra,0xfffff
    80003278:	a4c080e7          	jalr	-1460(ra) # 80001cc0 <either_copyout>
    8000327c:	05950d63          	beq	a0,s9,800032d6 <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80003280:	854a                	mv	a0,s2
    80003282:	fffff097          	auipc	ra,0xfffff
    80003286:	570080e7          	jalr	1392(ra) # 800027f2 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    8000328a:	013a09bb          	addw	s3,s4,s3
    8000328e:	009a04bb          	addw	s1,s4,s1
    80003292:	9aee                	add	s5,s5,s11
    80003294:	0569f763          	bgeu	s3,s6,800032e2 <readi+0xce>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80003298:	000ba903          	lw	s2,0(s7)
    8000329c:	00a4d59b          	srliw	a1,s1,0xa
    800032a0:	855e                	mv	a0,s7
    800032a2:	00000097          	auipc	ra,0x0
    800032a6:	8cc080e7          	jalr	-1844(ra) # 80002b6e <bmap>
    800032aa:	0005059b          	sext.w	a1,a0
    800032ae:	854a                	mv	a0,s2
    800032b0:	fffff097          	auipc	ra,0xfffff
    800032b4:	4d0080e7          	jalr	1232(ra) # 80002780 <bread>
    800032b8:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    800032ba:	3ff4f713          	andi	a4,s1,1023
    800032be:	40ed07bb          	subw	a5,s10,a4
    800032c2:	413b06bb          	subw	a3,s6,s3
    800032c6:	8a3e                	mv	s4,a5
    800032c8:	2781                	sext.w	a5,a5
    800032ca:	0006861b          	sext.w	a2,a3
    800032ce:	f8f679e3          	bgeu	a2,a5,80003260 <readi+0x4c>
    800032d2:	8a36                	mv	s4,a3
    800032d4:	b771                	j	80003260 <readi+0x4c>
      brelse(bp);
    800032d6:	854a                	mv	a0,s2
    800032d8:	fffff097          	auipc	ra,0xfffff
    800032dc:	51a080e7          	jalr	1306(ra) # 800027f2 <brelse>
      tot = -1;
    800032e0:	59fd                	li	s3,-1
  }
  return tot;
    800032e2:	0009851b          	sext.w	a0,s3
}
    800032e6:	70a6                	ld	ra,104(sp)
    800032e8:	7406                	ld	s0,96(sp)
    800032ea:	64e6                	ld	s1,88(sp)
    800032ec:	6946                	ld	s2,80(sp)
    800032ee:	69a6                	ld	s3,72(sp)
    800032f0:	6a06                	ld	s4,64(sp)
    800032f2:	7ae2                	ld	s5,56(sp)
    800032f4:	7b42                	ld	s6,48(sp)
    800032f6:	7ba2                	ld	s7,40(sp)
    800032f8:	7c02                	ld	s8,32(sp)
    800032fa:	6ce2                	ld	s9,24(sp)
    800032fc:	6d42                	ld	s10,16(sp)
    800032fe:	6da2                	ld	s11,8(sp)
    80003300:	6165                	addi	sp,sp,112
    80003302:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003304:	89da                	mv	s3,s6
    80003306:	bff1                	j	800032e2 <readi+0xce>
    return 0;
    80003308:	4501                	li	a0,0
}
    8000330a:	8082                	ret

000000008000330c <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    8000330c:	457c                	lw	a5,76(a0)
    8000330e:	10d7e363          	bltu	a5,a3,80003414 <writei+0x108>
{
    80003312:	7159                	addi	sp,sp,-112
    80003314:	f486                	sd	ra,104(sp)
    80003316:	f0a2                	sd	s0,96(sp)
    80003318:	eca6                	sd	s1,88(sp)
    8000331a:	e8ca                	sd	s2,80(sp)
    8000331c:	e4ce                	sd	s3,72(sp)
    8000331e:	e0d2                	sd	s4,64(sp)
    80003320:	fc56                	sd	s5,56(sp)
    80003322:	f85a                	sd	s6,48(sp)
    80003324:	f45e                	sd	s7,40(sp)
    80003326:	f062                	sd	s8,32(sp)
    80003328:	ec66                	sd	s9,24(sp)
    8000332a:	e86a                	sd	s10,16(sp)
    8000332c:	e46e                	sd	s11,8(sp)
    8000332e:	1880                	addi	s0,sp,112
    80003330:	8b2a                	mv	s6,a0
    80003332:	8c2e                	mv	s8,a1
    80003334:	8ab2                	mv	s5,a2
    80003336:	8936                	mv	s2,a3
    80003338:	8bba                	mv	s7,a4
  if(off > ip->size || off + n < off)
    8000333a:	00e687bb          	addw	a5,a3,a4
    8000333e:	0cd7ed63          	bltu	a5,a3,80003418 <writei+0x10c>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80003342:	00043737          	lui	a4,0x43
    80003346:	0cf76b63          	bltu	a4,a5,8000341c <writei+0x110>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    8000334a:	0c0b8363          	beqz	s7,80003410 <writei+0x104>
    8000334e:	4a01                	li	s4,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80003350:	40000d13          	li	s10,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80003354:	5cfd                	li	s9,-1
    80003356:	a82d                	j	80003390 <writei+0x84>
    80003358:	02099d93          	slli	s11,s3,0x20
    8000335c:	020ddd93          	srli	s11,s11,0x20
    80003360:	05848513          	addi	a0,s1,88
    80003364:	86ee                	mv	a3,s11
    80003366:	8656                	mv	a2,s5
    80003368:	85e2                	mv	a1,s8
    8000336a:	953a                	add	a0,a0,a4
    8000336c:	fffff097          	auipc	ra,0xfffff
    80003370:	9aa080e7          	jalr	-1622(ra) # 80001d16 <either_copyin>
    80003374:	05950d63          	beq	a0,s9,800033ce <writei+0xc2>
      brelse(bp);
      break;
    }
    //log_write(bp);
    brelse(bp);
    80003378:	8526                	mv	a0,s1
    8000337a:	fffff097          	auipc	ra,0xfffff
    8000337e:	478080e7          	jalr	1144(ra) # 800027f2 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003382:	01498a3b          	addw	s4,s3,s4
    80003386:	0129893b          	addw	s2,s3,s2
    8000338a:	9aee                	add	s5,s5,s11
    8000338c:	057a7663          	bgeu	s4,s7,800033d8 <writei+0xcc>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80003390:	000b2483          	lw	s1,0(s6)
    80003394:	00a9559b          	srliw	a1,s2,0xa
    80003398:	855a                	mv	a0,s6
    8000339a:	fffff097          	auipc	ra,0xfffff
    8000339e:	7d4080e7          	jalr	2004(ra) # 80002b6e <bmap>
    800033a2:	0005059b          	sext.w	a1,a0
    800033a6:	8526                	mv	a0,s1
    800033a8:	fffff097          	auipc	ra,0xfffff
    800033ac:	3d8080e7          	jalr	984(ra) # 80002780 <bread>
    800033b0:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    800033b2:	3ff97713          	andi	a4,s2,1023
    800033b6:	40ed07bb          	subw	a5,s10,a4
    800033ba:	414b86bb          	subw	a3,s7,s4
    800033be:	89be                	mv	s3,a5
    800033c0:	2781                	sext.w	a5,a5
    800033c2:	0006861b          	sext.w	a2,a3
    800033c6:	f8f679e3          	bgeu	a2,a5,80003358 <writei+0x4c>
    800033ca:	89b6                	mv	s3,a3
    800033cc:	b771                	j	80003358 <writei+0x4c>
      brelse(bp);
    800033ce:	8526                	mv	a0,s1
    800033d0:	fffff097          	auipc	ra,0xfffff
    800033d4:	422080e7          	jalr	1058(ra) # 800027f2 <brelse>
  }

  if(off > ip->size)
    800033d8:	04cb2783          	lw	a5,76(s6)
    800033dc:	0127f463          	bgeu	a5,s2,800033e4 <writei+0xd8>
    ip->size = off;
    800033e0:	052b2623          	sw	s2,76(s6)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    800033e4:	855a                	mv	a0,s6
    800033e6:	00000097          	auipc	ra,0x0
    800033ea:	ab8080e7          	jalr	-1352(ra) # 80002e9e <iupdate>

  return tot;
    800033ee:	000a051b          	sext.w	a0,s4
}
    800033f2:	70a6                	ld	ra,104(sp)
    800033f4:	7406                	ld	s0,96(sp)
    800033f6:	64e6                	ld	s1,88(sp)
    800033f8:	6946                	ld	s2,80(sp)
    800033fa:	69a6                	ld	s3,72(sp)
    800033fc:	6a06                	ld	s4,64(sp)
    800033fe:	7ae2                	ld	s5,56(sp)
    80003400:	7b42                	ld	s6,48(sp)
    80003402:	7ba2                	ld	s7,40(sp)
    80003404:	7c02                	ld	s8,32(sp)
    80003406:	6ce2                	ld	s9,24(sp)
    80003408:	6d42                	ld	s10,16(sp)
    8000340a:	6da2                	ld	s11,8(sp)
    8000340c:	6165                	addi	sp,sp,112
    8000340e:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003410:	8a5e                	mv	s4,s7
    80003412:	bfc9                	j	800033e4 <writei+0xd8>
    return -1;
    80003414:	557d                	li	a0,-1
}
    80003416:	8082                	ret
    return -1;
    80003418:	557d                	li	a0,-1
    8000341a:	bfe1                	j	800033f2 <writei+0xe6>
    return -1;
    8000341c:	557d                	li	a0,-1
    8000341e:	bfd1                	j	800033f2 <writei+0xe6>

0000000080003420 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80003420:	1141                	addi	sp,sp,-16
    80003422:	e406                	sd	ra,8(sp)
    80003424:	e022                	sd	s0,0(sp)
    80003426:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80003428:	4639                	li	a2,14
    8000342a:	ffffd097          	auipc	ra,0xffffd
    8000342e:	e26080e7          	jalr	-474(ra) # 80000250 <strncmp>
}
    80003432:	60a2                	ld	ra,8(sp)
    80003434:	6402                	ld	s0,0(sp)
    80003436:	0141                	addi	sp,sp,16
    80003438:	8082                	ret

000000008000343a <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    8000343a:	7139                	addi	sp,sp,-64
    8000343c:	fc06                	sd	ra,56(sp)
    8000343e:	f822                	sd	s0,48(sp)
    80003440:	f426                	sd	s1,40(sp)
    80003442:	f04a                	sd	s2,32(sp)
    80003444:	ec4e                	sd	s3,24(sp)
    80003446:	e852                	sd	s4,16(sp)
    80003448:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    8000344a:	04451703          	lh	a4,68(a0)
    8000344e:	4785                	li	a5,1
    80003450:	00f71a63          	bne	a4,a5,80003464 <dirlookup+0x2a>
    80003454:	892a                	mv	s2,a0
    80003456:	89ae                	mv	s3,a1
    80003458:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    8000345a:	457c                	lw	a5,76(a0)
    8000345c:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    8000345e:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003460:	e79d                	bnez	a5,8000348e <dirlookup+0x54>
    80003462:	a8a5                	j	800034da <dirlookup+0xa0>
    panic("dirlookup not DIR");
    80003464:	00005517          	auipc	a0,0x5
    80003468:	21c50513          	addi	a0,a0,540 # 80008680 <syscalls+0x200>
    8000346c:	00003097          	auipc	ra,0x3
    80003470:	ff6080e7          	jalr	-10(ra) # 80006462 <panic>
      panic("dirlookup read");
    80003474:	00005517          	auipc	a0,0x5
    80003478:	22450513          	addi	a0,a0,548 # 80008698 <syscalls+0x218>
    8000347c:	00003097          	auipc	ra,0x3
    80003480:	fe6080e7          	jalr	-26(ra) # 80006462 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003484:	24c1                	addiw	s1,s1,16
    80003486:	04c92783          	lw	a5,76(s2)
    8000348a:	04f4f763          	bgeu	s1,a5,800034d8 <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000348e:	4741                	li	a4,16
    80003490:	86a6                	mv	a3,s1
    80003492:	fc040613          	addi	a2,s0,-64
    80003496:	4581                	li	a1,0
    80003498:	854a                	mv	a0,s2
    8000349a:	00000097          	auipc	ra,0x0
    8000349e:	d7a080e7          	jalr	-646(ra) # 80003214 <readi>
    800034a2:	47c1                	li	a5,16
    800034a4:	fcf518e3          	bne	a0,a5,80003474 <dirlookup+0x3a>
    if(de.inum == 0)
    800034a8:	fc045783          	lhu	a5,-64(s0)
    800034ac:	dfe1                	beqz	a5,80003484 <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    800034ae:	fc240593          	addi	a1,s0,-62
    800034b2:	854e                	mv	a0,s3
    800034b4:	00000097          	auipc	ra,0x0
    800034b8:	f6c080e7          	jalr	-148(ra) # 80003420 <namecmp>
    800034bc:	f561                	bnez	a0,80003484 <dirlookup+0x4a>
      if(poff)
    800034be:	000a0463          	beqz	s4,800034c6 <dirlookup+0x8c>
        *poff = off;
    800034c2:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    800034c6:	fc045583          	lhu	a1,-64(s0)
    800034ca:	00092503          	lw	a0,0(s2)
    800034ce:	fffff097          	auipc	ra,0xfffff
    800034d2:	770080e7          	jalr	1904(ra) # 80002c3e <iget>
    800034d6:	a011                	j	800034da <dirlookup+0xa0>
  return 0;
    800034d8:	4501                	li	a0,0
}
    800034da:	70e2                	ld	ra,56(sp)
    800034dc:	7442                	ld	s0,48(sp)
    800034de:	74a2                	ld	s1,40(sp)
    800034e0:	7902                	ld	s2,32(sp)
    800034e2:	69e2                	ld	s3,24(sp)
    800034e4:	6a42                	ld	s4,16(sp)
    800034e6:	6121                	addi	sp,sp,64
    800034e8:	8082                	ret

00000000800034ea <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    800034ea:	711d                	addi	sp,sp,-96
    800034ec:	ec86                	sd	ra,88(sp)
    800034ee:	e8a2                	sd	s0,80(sp)
    800034f0:	e4a6                	sd	s1,72(sp)
    800034f2:	e0ca                	sd	s2,64(sp)
    800034f4:	fc4e                	sd	s3,56(sp)
    800034f6:	f852                	sd	s4,48(sp)
    800034f8:	f456                	sd	s5,40(sp)
    800034fa:	f05a                	sd	s6,32(sp)
    800034fc:	ec5e                	sd	s7,24(sp)
    800034fe:	e862                	sd	s8,16(sp)
    80003500:	e466                	sd	s9,8(sp)
    80003502:	1080                	addi	s0,sp,96
    80003504:	84aa                	mv	s1,a0
    80003506:	8b2e                	mv	s6,a1
    80003508:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    8000350a:	00054703          	lbu	a4,0(a0)
    8000350e:	02f00793          	li	a5,47
    80003512:	02f70363          	beq	a4,a5,80003538 <namex+0x4e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80003516:	ffffe097          	auipc	ra,0xffffe
    8000351a:	d4a080e7          	jalr	-694(ra) # 80001260 <myproc>
    8000351e:	15053503          	ld	a0,336(a0)
    80003522:	00000097          	auipc	ra,0x0
    80003526:	a00080e7          	jalr	-1536(ra) # 80002f22 <idup>
    8000352a:	89aa                	mv	s3,a0
  while(*path == '/')
    8000352c:	02f00913          	li	s2,47
  len = path - s;
    80003530:	4b81                	li	s7,0
  if(len >= DIRSIZ)
    80003532:	4cb5                	li	s9,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80003534:	4c05                	li	s8,1
    80003536:	a865                	j	800035ee <namex+0x104>
    ip = iget(ROOTDEV, ROOTINO);
    80003538:	4585                	li	a1,1
    8000353a:	4505                	li	a0,1
    8000353c:	fffff097          	auipc	ra,0xfffff
    80003540:	702080e7          	jalr	1794(ra) # 80002c3e <iget>
    80003544:	89aa                	mv	s3,a0
    80003546:	b7dd                	j	8000352c <namex+0x42>
      iunlockput(ip);
    80003548:	854e                	mv	a0,s3
    8000354a:	00000097          	auipc	ra,0x0
    8000354e:	c78080e7          	jalr	-904(ra) # 800031c2 <iunlockput>
      return 0;
    80003552:	4981                	li	s3,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80003554:	854e                	mv	a0,s3
    80003556:	60e6                	ld	ra,88(sp)
    80003558:	6446                	ld	s0,80(sp)
    8000355a:	64a6                	ld	s1,72(sp)
    8000355c:	6906                	ld	s2,64(sp)
    8000355e:	79e2                	ld	s3,56(sp)
    80003560:	7a42                	ld	s4,48(sp)
    80003562:	7aa2                	ld	s5,40(sp)
    80003564:	7b02                	ld	s6,32(sp)
    80003566:	6be2                	ld	s7,24(sp)
    80003568:	6c42                	ld	s8,16(sp)
    8000356a:	6ca2                	ld	s9,8(sp)
    8000356c:	6125                	addi	sp,sp,96
    8000356e:	8082                	ret
      iunlock(ip);
    80003570:	854e                	mv	a0,s3
    80003572:	00000097          	auipc	ra,0x0
    80003576:	ab0080e7          	jalr	-1360(ra) # 80003022 <iunlock>
      return ip;
    8000357a:	bfe9                	j	80003554 <namex+0x6a>
      iunlockput(ip);
    8000357c:	854e                	mv	a0,s3
    8000357e:	00000097          	auipc	ra,0x0
    80003582:	c44080e7          	jalr	-956(ra) # 800031c2 <iunlockput>
      return 0;
    80003586:	89d2                	mv	s3,s4
    80003588:	b7f1                	j	80003554 <namex+0x6a>
  len = path - s;
    8000358a:	40b48633          	sub	a2,s1,a1
    8000358e:	00060a1b          	sext.w	s4,a2
  if(len >= DIRSIZ)
    80003592:	094cd463          	bge	s9,s4,8000361a <namex+0x130>
    memmove(name, s, DIRSIZ);
    80003596:	4639                	li	a2,14
    80003598:	8556                	mv	a0,s5
    8000359a:	ffffd097          	auipc	ra,0xffffd
    8000359e:	c3e080e7          	jalr	-962(ra) # 800001d8 <memmove>
  while(*path == '/')
    800035a2:	0004c783          	lbu	a5,0(s1)
    800035a6:	01279763          	bne	a5,s2,800035b4 <namex+0xca>
    path++;
    800035aa:	0485                	addi	s1,s1,1
  while(*path == '/')
    800035ac:	0004c783          	lbu	a5,0(s1)
    800035b0:	ff278de3          	beq	a5,s2,800035aa <namex+0xc0>
    ilock(ip);
    800035b4:	854e                	mv	a0,s3
    800035b6:	00000097          	auipc	ra,0x0
    800035ba:	9aa080e7          	jalr	-1622(ra) # 80002f60 <ilock>
    if(ip->type != T_DIR){
    800035be:	04499783          	lh	a5,68(s3)
    800035c2:	f98793e3          	bne	a5,s8,80003548 <namex+0x5e>
    if(nameiparent && *path == '\0'){
    800035c6:	000b0563          	beqz	s6,800035d0 <namex+0xe6>
    800035ca:	0004c783          	lbu	a5,0(s1)
    800035ce:	d3cd                	beqz	a5,80003570 <namex+0x86>
    if((next = dirlookup(ip, name, 0)) == 0){
    800035d0:	865e                	mv	a2,s7
    800035d2:	85d6                	mv	a1,s5
    800035d4:	854e                	mv	a0,s3
    800035d6:	00000097          	auipc	ra,0x0
    800035da:	e64080e7          	jalr	-412(ra) # 8000343a <dirlookup>
    800035de:	8a2a                	mv	s4,a0
    800035e0:	dd51                	beqz	a0,8000357c <namex+0x92>
    iunlockput(ip);
    800035e2:	854e                	mv	a0,s3
    800035e4:	00000097          	auipc	ra,0x0
    800035e8:	bde080e7          	jalr	-1058(ra) # 800031c2 <iunlockput>
    ip = next;
    800035ec:	89d2                	mv	s3,s4
  while(*path == '/')
    800035ee:	0004c783          	lbu	a5,0(s1)
    800035f2:	05279763          	bne	a5,s2,80003640 <namex+0x156>
    path++;
    800035f6:	0485                	addi	s1,s1,1
  while(*path == '/')
    800035f8:	0004c783          	lbu	a5,0(s1)
    800035fc:	ff278de3          	beq	a5,s2,800035f6 <namex+0x10c>
  if(*path == 0)
    80003600:	c79d                	beqz	a5,8000362e <namex+0x144>
    path++;
    80003602:	85a6                	mv	a1,s1
  len = path - s;
    80003604:	8a5e                	mv	s4,s7
    80003606:	865e                	mv	a2,s7
  while(*path != '/' && *path != 0)
    80003608:	01278963          	beq	a5,s2,8000361a <namex+0x130>
    8000360c:	dfbd                	beqz	a5,8000358a <namex+0xa0>
    path++;
    8000360e:	0485                	addi	s1,s1,1
  while(*path != '/' && *path != 0)
    80003610:	0004c783          	lbu	a5,0(s1)
    80003614:	ff279ce3          	bne	a5,s2,8000360c <namex+0x122>
    80003618:	bf8d                	j	8000358a <namex+0xa0>
    memmove(name, s, len);
    8000361a:	2601                	sext.w	a2,a2
    8000361c:	8556                	mv	a0,s5
    8000361e:	ffffd097          	auipc	ra,0xffffd
    80003622:	bba080e7          	jalr	-1094(ra) # 800001d8 <memmove>
    name[len] = 0;
    80003626:	9a56                	add	s4,s4,s5
    80003628:	000a0023          	sb	zero,0(s4)
    8000362c:	bf9d                	j	800035a2 <namex+0xb8>
  if(nameiparent){
    8000362e:	f20b03e3          	beqz	s6,80003554 <namex+0x6a>
    iput(ip);
    80003632:	854e                	mv	a0,s3
    80003634:	00000097          	auipc	ra,0x0
    80003638:	ae6080e7          	jalr	-1306(ra) # 8000311a <iput>
    return 0;
    8000363c:	4981                	li	s3,0
    8000363e:	bf19                	j	80003554 <namex+0x6a>
  if(*path == 0)
    80003640:	d7fd                	beqz	a5,8000362e <namex+0x144>
  while(*path != '/' && *path != 0)
    80003642:	0004c783          	lbu	a5,0(s1)
    80003646:	85a6                	mv	a1,s1
    80003648:	b7d1                	j	8000360c <namex+0x122>

000000008000364a <dirlink>:
{
    8000364a:	7139                	addi	sp,sp,-64
    8000364c:	fc06                	sd	ra,56(sp)
    8000364e:	f822                	sd	s0,48(sp)
    80003650:	f426                	sd	s1,40(sp)
    80003652:	f04a                	sd	s2,32(sp)
    80003654:	ec4e                	sd	s3,24(sp)
    80003656:	e852                	sd	s4,16(sp)
    80003658:	0080                	addi	s0,sp,64
    8000365a:	892a                	mv	s2,a0
    8000365c:	8a2e                	mv	s4,a1
    8000365e:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80003660:	4601                	li	a2,0
    80003662:	00000097          	auipc	ra,0x0
    80003666:	dd8080e7          	jalr	-552(ra) # 8000343a <dirlookup>
    8000366a:	e93d                	bnez	a0,800036e0 <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000366c:	04c92483          	lw	s1,76(s2)
    80003670:	c49d                	beqz	s1,8000369e <dirlink+0x54>
    80003672:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003674:	4741                	li	a4,16
    80003676:	86a6                	mv	a3,s1
    80003678:	fc040613          	addi	a2,s0,-64
    8000367c:	4581                	li	a1,0
    8000367e:	854a                	mv	a0,s2
    80003680:	00000097          	auipc	ra,0x0
    80003684:	b94080e7          	jalr	-1132(ra) # 80003214 <readi>
    80003688:	47c1                	li	a5,16
    8000368a:	06f51163          	bne	a0,a5,800036ec <dirlink+0xa2>
    if(de.inum == 0)
    8000368e:	fc045783          	lhu	a5,-64(s0)
    80003692:	c791                	beqz	a5,8000369e <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003694:	24c1                	addiw	s1,s1,16
    80003696:	04c92783          	lw	a5,76(s2)
    8000369a:	fcf4ede3          	bltu	s1,a5,80003674 <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    8000369e:	4639                	li	a2,14
    800036a0:	85d2                	mv	a1,s4
    800036a2:	fc240513          	addi	a0,s0,-62
    800036a6:	ffffd097          	auipc	ra,0xffffd
    800036aa:	be6080e7          	jalr	-1050(ra) # 8000028c <strncpy>
  de.inum = inum;
    800036ae:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800036b2:	4741                	li	a4,16
    800036b4:	86a6                	mv	a3,s1
    800036b6:	fc040613          	addi	a2,s0,-64
    800036ba:	4581                	li	a1,0
    800036bc:	854a                	mv	a0,s2
    800036be:	00000097          	auipc	ra,0x0
    800036c2:	c4e080e7          	jalr	-946(ra) # 8000330c <writei>
    800036c6:	872a                	mv	a4,a0
    800036c8:	47c1                	li	a5,16
  return 0;
    800036ca:	4501                	li	a0,0
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800036cc:	02f71863          	bne	a4,a5,800036fc <dirlink+0xb2>
}
    800036d0:	70e2                	ld	ra,56(sp)
    800036d2:	7442                	ld	s0,48(sp)
    800036d4:	74a2                	ld	s1,40(sp)
    800036d6:	7902                	ld	s2,32(sp)
    800036d8:	69e2                	ld	s3,24(sp)
    800036da:	6a42                	ld	s4,16(sp)
    800036dc:	6121                	addi	sp,sp,64
    800036de:	8082                	ret
    iput(ip);
    800036e0:	00000097          	auipc	ra,0x0
    800036e4:	a3a080e7          	jalr	-1478(ra) # 8000311a <iput>
    return -1;
    800036e8:	557d                	li	a0,-1
    800036ea:	b7dd                	j	800036d0 <dirlink+0x86>
      panic("dirlink read");
    800036ec:	00005517          	auipc	a0,0x5
    800036f0:	fbc50513          	addi	a0,a0,-68 # 800086a8 <syscalls+0x228>
    800036f4:	00003097          	auipc	ra,0x3
    800036f8:	d6e080e7          	jalr	-658(ra) # 80006462 <panic>
    panic("dirlink");
    800036fc:	00005517          	auipc	a0,0x5
    80003700:	15450513          	addi	a0,a0,340 # 80008850 <syscalls+0x3d0>
    80003704:	00003097          	auipc	ra,0x3
    80003708:	d5e080e7          	jalr	-674(ra) # 80006462 <panic>

000000008000370c <namei>:

struct inode*
namei(char *path)
{
    8000370c:	1101                	addi	sp,sp,-32
    8000370e:	ec06                	sd	ra,24(sp)
    80003710:	e822                	sd	s0,16(sp)
    80003712:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80003714:	fe040613          	addi	a2,s0,-32
    80003718:	4581                	li	a1,0
    8000371a:	00000097          	auipc	ra,0x0
    8000371e:	dd0080e7          	jalr	-560(ra) # 800034ea <namex>
}
    80003722:	60e2                	ld	ra,24(sp)
    80003724:	6442                	ld	s0,16(sp)
    80003726:	6105                	addi	sp,sp,32
    80003728:	8082                	ret

000000008000372a <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    8000372a:	1141                	addi	sp,sp,-16
    8000372c:	e406                	sd	ra,8(sp)
    8000372e:	e022                	sd	s0,0(sp)
    80003730:	0800                	addi	s0,sp,16
    80003732:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80003734:	4585                	li	a1,1
    80003736:	00000097          	auipc	ra,0x0
    8000373a:	db4080e7          	jalr	-588(ra) # 800034ea <namex>
}
    8000373e:	60a2                	ld	ra,8(sp)
    80003740:	6402                	ld	s0,0(sp)
    80003742:	0141                	addi	sp,sp,16
    80003744:	8082                	ret

0000000080003746 <balloc_page>:

/* NTU OS 2024 */
/* Similar to balloc, except allocates eight consecutive free blocks. */
uint balloc_page(uint dev) {
    80003746:	715d                	addi	sp,sp,-80
    80003748:	e486                	sd	ra,72(sp)
    8000374a:	e0a2                	sd	s0,64(sp)
    8000374c:	fc26                	sd	s1,56(sp)
    8000374e:	f84a                	sd	s2,48(sp)
    80003750:	f44e                	sd	s3,40(sp)
    80003752:	f052                	sd	s4,32(sp)
    80003754:	ec56                	sd	s5,24(sp)
    80003756:	e85a                	sd	s6,16(sp)
    80003758:	e45e                	sd	s7,8(sp)
    8000375a:	0880                	addi	s0,sp,80
  for (int b = 0; b < sb.size; b += BPB) {
    8000375c:	00014797          	auipc	a5,0x14
    80003760:	e007a783          	lw	a5,-512(a5) # 8001755c <sb+0x4>
    80003764:	c3e9                	beqz	a5,80003826 <balloc_page+0xe0>
    80003766:	89aa                	mv	s3,a0
    80003768:	4a01                	li	s4,0
    struct buf *bp = bread(dev, BBLOCK(b, sb));
    8000376a:	00014a97          	auipc	s5,0x14
    8000376e:	deea8a93          	addi	s5,s5,-530 # 80017558 <sb>

    for (int bi = 0; bi < BPB && b + bi < sb.size; bi += 8) {
    80003772:	4b01                	li	s6,0
    80003774:	6909                	lui	s2,0x2
  for (int b = 0; b < sb.size; b += BPB) {
    80003776:	6b89                	lui	s7,0x2
    80003778:	a8b9                	j	800037d6 <balloc_page+0x90>
      uchar *bits = &bp->data[bi / 8];
      if (*bits == 0) {
        *bits |= 0xff; // Mark 8 consecutive blocks in use.
    8000377a:	97aa                	add	a5,a5,a0
    8000377c:	577d                	li	a4,-1
    8000377e:	04e78c23          	sb	a4,88(a5)
        //log_write(bp);
        brelse(bp);
    80003782:	fffff097          	auipc	ra,0xfffff
    80003786:	070080e7          	jalr	112(ra) # 800027f2 <brelse>

        for (int i = 0; i < 8; i += 1) {
    8000378a:	00848a1b          	addiw	s4,s1,8
        brelse(bp);
    8000378e:	8926                	mv	s2,s1
          bzero(dev, b + bi + i);
    80003790:	2981                	sext.w	s3,s3
    80003792:	0009059b          	sext.w	a1,s2
    80003796:	854e                	mv	a0,s3
    80003798:	fffff097          	auipc	ra,0xfffff
    8000379c:	29e080e7          	jalr	670(ra) # 80002a36 <bzero>
        for (int i = 0; i < 8; i += 1) {
    800037a0:	2905                	addiw	s2,s2,1
    800037a2:	ff4918e3          	bne	s2,s4,80003792 <balloc_page+0x4c>
    }

    brelse(bp);
  }
  panic("balloc_page: out of blocks");
}
    800037a6:	8526                	mv	a0,s1
    800037a8:	60a6                	ld	ra,72(sp)
    800037aa:	6406                	ld	s0,64(sp)
    800037ac:	74e2                	ld	s1,56(sp)
    800037ae:	7942                	ld	s2,48(sp)
    800037b0:	79a2                	ld	s3,40(sp)
    800037b2:	7a02                	ld	s4,32(sp)
    800037b4:	6ae2                	ld	s5,24(sp)
    800037b6:	6b42                	ld	s6,16(sp)
    800037b8:	6ba2                	ld	s7,8(sp)
    800037ba:	6161                	addi	sp,sp,80
    800037bc:	8082                	ret
    brelse(bp);
    800037be:	fffff097          	auipc	ra,0xfffff
    800037c2:	034080e7          	jalr	52(ra) # 800027f2 <brelse>
  for (int b = 0; b < sb.size; b += BPB) {
    800037c6:	014b87bb          	addw	a5,s7,s4
    800037ca:	00078a1b          	sext.w	s4,a5
    800037ce:	004aa703          	lw	a4,4(s5)
    800037d2:	04ea7a63          	bgeu	s4,a4,80003826 <balloc_page+0xe0>
    struct buf *bp = bread(dev, BBLOCK(b, sb));
    800037d6:	41fa579b          	sraiw	a5,s4,0x1f
    800037da:	0137d79b          	srliw	a5,a5,0x13
    800037de:	014787bb          	addw	a5,a5,s4
    800037e2:	40d7d79b          	sraiw	a5,a5,0xd
    800037e6:	01caa583          	lw	a1,28(s5)
    800037ea:	9dbd                	addw	a1,a1,a5
    800037ec:	854e                	mv	a0,s3
    800037ee:	fffff097          	auipc	ra,0xfffff
    800037f2:	f92080e7          	jalr	-110(ra) # 80002780 <bread>
    for (int bi = 0; bi < BPB && b + bi < sb.size; bi += 8) {
    800037f6:	004aa603          	lw	a2,4(s5)
    800037fa:	000a049b          	sext.w	s1,s4
    800037fe:	875a                	mv	a4,s6
    80003800:	fac4ffe3          	bgeu	s1,a2,800037be <balloc_page+0x78>
      uchar *bits = &bp->data[bi / 8];
    80003804:	41f7579b          	sraiw	a5,a4,0x1f
    80003808:	01d7d79b          	srliw	a5,a5,0x1d
    8000380c:	9fb9                	addw	a5,a5,a4
    8000380e:	4037d79b          	sraiw	a5,a5,0x3
      if (*bits == 0) {
    80003812:	00f506b3          	add	a3,a0,a5
    80003816:	0586c683          	lbu	a3,88(a3)
    8000381a:	d2a5                	beqz	a3,8000377a <balloc_page+0x34>
    for (int bi = 0; bi < BPB && b + bi < sb.size; bi += 8) {
    8000381c:	2721                	addiw	a4,a4,8
    8000381e:	24a1                	addiw	s1,s1,8
    80003820:	ff2710e3          	bne	a4,s2,80003800 <balloc_page+0xba>
    80003824:	bf69                	j	800037be <balloc_page+0x78>
  panic("balloc_page: out of blocks");
    80003826:	00005517          	auipc	a0,0x5
    8000382a:	e9250513          	addi	a0,a0,-366 # 800086b8 <syscalls+0x238>
    8000382e:	00003097          	auipc	ra,0x3
    80003832:	c34080e7          	jalr	-972(ra) # 80006462 <panic>

0000000080003836 <bfree_page>:

/* NTU OS 2024 */
/* Free 8 disk blocks allocated from balloc_page(). */
void bfree_page(int dev, uint blockno) {
    80003836:	1101                	addi	sp,sp,-32
    80003838:	ec06                	sd	ra,24(sp)
    8000383a:	e822                	sd	s0,16(sp)
    8000383c:	e426                	sd	s1,8(sp)
    8000383e:	1000                	addi	s0,sp,32
  if (blockno + 8 > sb.size) {
    80003840:	0085871b          	addiw	a4,a1,8
    80003844:	00014797          	auipc	a5,0x14
    80003848:	d187a783          	lw	a5,-744(a5) # 8001755c <sb+0x4>
    8000384c:	04e7ee63          	bltu	a5,a4,800038a8 <bfree_page+0x72>
    panic("bfree_page: blockno out of bound");
  }

  if ((blockno % 8) != 0) {
    80003850:	0075f793          	andi	a5,a1,7
    80003854:	e3b5                	bnez	a5,800038b8 <bfree_page+0x82>
    panic("bfree_page: blockno is not aligned");
  }

  int bi = blockno % BPB;
    80003856:	03359493          	slli	s1,a1,0x33
    8000385a:	90cd                	srli	s1,s1,0x33
  int b = blockno - bi;
    8000385c:	9d85                	subw	a1,a1,s1
  struct buf *bp = bread(dev, BBLOCK(b, sb));
    8000385e:	41f5d79b          	sraiw	a5,a1,0x1f
    80003862:	0137d79b          	srliw	a5,a5,0x13
    80003866:	9dbd                	addw	a1,a1,a5
    80003868:	40d5d59b          	sraiw	a1,a1,0xd
    8000386c:	00014797          	auipc	a5,0x14
    80003870:	d087a783          	lw	a5,-760(a5) # 80017574 <sb+0x1c>
    80003874:	9dbd                	addw	a1,a1,a5
    80003876:	fffff097          	auipc	ra,0xfffff
    8000387a:	f0a080e7          	jalr	-246(ra) # 80002780 <bread>
  uchar *bits = &bp->data[bi / 8];
    8000387e:	808d                	srli	s1,s1,0x3

  if (*bits != 0xff) {
    80003880:	009507b3          	add	a5,a0,s1
    80003884:	0587c703          	lbu	a4,88(a5)
    80003888:	0ff00793          	li	a5,255
    8000388c:	02f71e63          	bne	a4,a5,800038c8 <bfree_page+0x92>
    panic("bfree_page: data bits are invalid");
  }

  *bits = 0;
    80003890:	94aa                	add	s1,s1,a0
    80003892:	04048c23          	sb	zero,88(s1)
  //log_write(bp);
  brelse(bp);
    80003896:	fffff097          	auipc	ra,0xfffff
    8000389a:	f5c080e7          	jalr	-164(ra) # 800027f2 <brelse>
}
    8000389e:	60e2                	ld	ra,24(sp)
    800038a0:	6442                	ld	s0,16(sp)
    800038a2:	64a2                	ld	s1,8(sp)
    800038a4:	6105                	addi	sp,sp,32
    800038a6:	8082                	ret
    panic("bfree_page: blockno out of bound");
    800038a8:	00005517          	auipc	a0,0x5
    800038ac:	e3050513          	addi	a0,a0,-464 # 800086d8 <syscalls+0x258>
    800038b0:	00003097          	auipc	ra,0x3
    800038b4:	bb2080e7          	jalr	-1102(ra) # 80006462 <panic>
    panic("bfree_page: blockno is not aligned");
    800038b8:	00005517          	auipc	a0,0x5
    800038bc:	e4850513          	addi	a0,a0,-440 # 80008700 <syscalls+0x280>
    800038c0:	00003097          	auipc	ra,0x3
    800038c4:	ba2080e7          	jalr	-1118(ra) # 80006462 <panic>
    panic("bfree_page: data bits are invalid");
    800038c8:	00005517          	auipc	a0,0x5
    800038cc:	e6050513          	addi	a0,a0,-416 # 80008728 <syscalls+0x2a8>
    800038d0:	00003097          	auipc	ra,0x3
    800038d4:	b92080e7          	jalr	-1134(ra) # 80006462 <panic>

00000000800038d8 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    800038d8:	1101                	addi	sp,sp,-32
    800038da:	ec06                	sd	ra,24(sp)
    800038dc:	e822                	sd	s0,16(sp)
    800038de:	e426                	sd	s1,8(sp)
    800038e0:	e04a                	sd	s2,0(sp)
    800038e2:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    800038e4:	00015917          	auipc	s2,0x15
    800038e8:	73c90913          	addi	s2,s2,1852 # 80019020 <log>
    800038ec:	01892583          	lw	a1,24(s2)
    800038f0:	02892503          	lw	a0,40(s2)
    800038f4:	fffff097          	auipc	ra,0xfffff
    800038f8:	e8c080e7          	jalr	-372(ra) # 80002780 <bread>
    800038fc:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    800038fe:	02c92683          	lw	a3,44(s2)
    80003902:	cd34                	sw	a3,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    80003904:	02d05763          	blez	a3,80003932 <write_head+0x5a>
    80003908:	00015797          	auipc	a5,0x15
    8000390c:	74878793          	addi	a5,a5,1864 # 80019050 <log+0x30>
    80003910:	05c50713          	addi	a4,a0,92
    80003914:	36fd                	addiw	a3,a3,-1
    80003916:	1682                	slli	a3,a3,0x20
    80003918:	9281                	srli	a3,a3,0x20
    8000391a:	068a                	slli	a3,a3,0x2
    8000391c:	00015617          	auipc	a2,0x15
    80003920:	73860613          	addi	a2,a2,1848 # 80019054 <log+0x34>
    80003924:	96b2                	add	a3,a3,a2
    hb->block[i] = log.lh.block[i];
    80003926:	4390                	lw	a2,0(a5)
    80003928:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    8000392a:	0791                	addi	a5,a5,4
    8000392c:	0711                	addi	a4,a4,4
    8000392e:	fed79ce3          	bne	a5,a3,80003926 <write_head+0x4e>
  }
  bwrite(buf);
    80003932:	8526                	mv	a0,s1
    80003934:	fffff097          	auipc	ra,0xfffff
    80003938:	e80080e7          	jalr	-384(ra) # 800027b4 <bwrite>
  brelse(buf);
    8000393c:	8526                	mv	a0,s1
    8000393e:	fffff097          	auipc	ra,0xfffff
    80003942:	eb4080e7          	jalr	-332(ra) # 800027f2 <brelse>
}
    80003946:	60e2                	ld	ra,24(sp)
    80003948:	6442                	ld	s0,16(sp)
    8000394a:	64a2                	ld	s1,8(sp)
    8000394c:	6902                	ld	s2,0(sp)
    8000394e:	6105                	addi	sp,sp,32
    80003950:	8082                	ret

0000000080003952 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    80003952:	00015797          	auipc	a5,0x15
    80003956:	6fa7a783          	lw	a5,1786(a5) # 8001904c <log+0x2c>
    8000395a:	0af05d63          	blez	a5,80003a14 <install_trans+0xc2>
{
    8000395e:	7139                	addi	sp,sp,-64
    80003960:	fc06                	sd	ra,56(sp)
    80003962:	f822                	sd	s0,48(sp)
    80003964:	f426                	sd	s1,40(sp)
    80003966:	f04a                	sd	s2,32(sp)
    80003968:	ec4e                	sd	s3,24(sp)
    8000396a:	e852                	sd	s4,16(sp)
    8000396c:	e456                	sd	s5,8(sp)
    8000396e:	e05a                	sd	s6,0(sp)
    80003970:	0080                	addi	s0,sp,64
    80003972:	8b2a                	mv	s6,a0
    80003974:	00015a97          	auipc	s5,0x15
    80003978:	6dca8a93          	addi	s5,s5,1756 # 80019050 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000397c:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    8000397e:	00015997          	auipc	s3,0x15
    80003982:	6a298993          	addi	s3,s3,1698 # 80019020 <log>
    80003986:	a035                	j	800039b2 <install_trans+0x60>
      bunpin(dbuf);
    80003988:	8526                	mv	a0,s1
    8000398a:	fffff097          	auipc	ra,0xfffff
    8000398e:	f42080e7          	jalr	-190(ra) # 800028cc <bunpin>
    brelse(lbuf);
    80003992:	854a                	mv	a0,s2
    80003994:	fffff097          	auipc	ra,0xfffff
    80003998:	e5e080e7          	jalr	-418(ra) # 800027f2 <brelse>
    brelse(dbuf);
    8000399c:	8526                	mv	a0,s1
    8000399e:	fffff097          	auipc	ra,0xfffff
    800039a2:	e54080e7          	jalr	-428(ra) # 800027f2 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800039a6:	2a05                	addiw	s4,s4,1
    800039a8:	0a91                	addi	s5,s5,4
    800039aa:	02c9a783          	lw	a5,44(s3)
    800039ae:	04fa5963          	bge	s4,a5,80003a00 <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    800039b2:	0189a583          	lw	a1,24(s3)
    800039b6:	014585bb          	addw	a1,a1,s4
    800039ba:	2585                	addiw	a1,a1,1
    800039bc:	0289a503          	lw	a0,40(s3)
    800039c0:	fffff097          	auipc	ra,0xfffff
    800039c4:	dc0080e7          	jalr	-576(ra) # 80002780 <bread>
    800039c8:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    800039ca:	000aa583          	lw	a1,0(s5)
    800039ce:	0289a503          	lw	a0,40(s3)
    800039d2:	fffff097          	auipc	ra,0xfffff
    800039d6:	dae080e7          	jalr	-594(ra) # 80002780 <bread>
    800039da:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    800039dc:	40000613          	li	a2,1024
    800039e0:	05890593          	addi	a1,s2,88
    800039e4:	05850513          	addi	a0,a0,88
    800039e8:	ffffc097          	auipc	ra,0xffffc
    800039ec:	7f0080e7          	jalr	2032(ra) # 800001d8 <memmove>
    bwrite(dbuf);  // write dst to disk
    800039f0:	8526                	mv	a0,s1
    800039f2:	fffff097          	auipc	ra,0xfffff
    800039f6:	dc2080e7          	jalr	-574(ra) # 800027b4 <bwrite>
    if(recovering == 0)
    800039fa:	f80b1ce3          	bnez	s6,80003992 <install_trans+0x40>
    800039fe:	b769                	j	80003988 <install_trans+0x36>
}
    80003a00:	70e2                	ld	ra,56(sp)
    80003a02:	7442                	ld	s0,48(sp)
    80003a04:	74a2                	ld	s1,40(sp)
    80003a06:	7902                	ld	s2,32(sp)
    80003a08:	69e2                	ld	s3,24(sp)
    80003a0a:	6a42                	ld	s4,16(sp)
    80003a0c:	6aa2                	ld	s5,8(sp)
    80003a0e:	6b02                	ld	s6,0(sp)
    80003a10:	6121                	addi	sp,sp,64
    80003a12:	8082                	ret
    80003a14:	8082                	ret

0000000080003a16 <initlog>:
{
    80003a16:	7179                	addi	sp,sp,-48
    80003a18:	f406                	sd	ra,40(sp)
    80003a1a:	f022                	sd	s0,32(sp)
    80003a1c:	ec26                	sd	s1,24(sp)
    80003a1e:	e84a                	sd	s2,16(sp)
    80003a20:	e44e                	sd	s3,8(sp)
    80003a22:	1800                	addi	s0,sp,48
    80003a24:	892a                	mv	s2,a0
    80003a26:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80003a28:	00015497          	auipc	s1,0x15
    80003a2c:	5f848493          	addi	s1,s1,1528 # 80019020 <log>
    80003a30:	00005597          	auipc	a1,0x5
    80003a34:	d2058593          	addi	a1,a1,-736 # 80008750 <syscalls+0x2d0>
    80003a38:	8526                	mv	a0,s1
    80003a3a:	00003097          	auipc	ra,0x3
    80003a3e:	ee2080e7          	jalr	-286(ra) # 8000691c <initlock>
  log.start = sb->logstart;
    80003a42:	0149a583          	lw	a1,20(s3)
    80003a46:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    80003a48:	0109a783          	lw	a5,16(s3)
    80003a4c:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    80003a4e:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    80003a52:	854a                	mv	a0,s2
    80003a54:	fffff097          	auipc	ra,0xfffff
    80003a58:	d2c080e7          	jalr	-724(ra) # 80002780 <bread>
  log.lh.n = lh->n;
    80003a5c:	4d3c                	lw	a5,88(a0)
    80003a5e:	d4dc                	sw	a5,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    80003a60:	02f05563          	blez	a5,80003a8a <initlog+0x74>
    80003a64:	05c50713          	addi	a4,a0,92
    80003a68:	00015697          	auipc	a3,0x15
    80003a6c:	5e868693          	addi	a3,a3,1512 # 80019050 <log+0x30>
    80003a70:	37fd                	addiw	a5,a5,-1
    80003a72:	1782                	slli	a5,a5,0x20
    80003a74:	9381                	srli	a5,a5,0x20
    80003a76:	078a                	slli	a5,a5,0x2
    80003a78:	06050613          	addi	a2,a0,96
    80003a7c:	97b2                	add	a5,a5,a2
    log.lh.block[i] = lh->block[i];
    80003a7e:	4310                	lw	a2,0(a4)
    80003a80:	c290                	sw	a2,0(a3)
  for (i = 0; i < log.lh.n; i++) {
    80003a82:	0711                	addi	a4,a4,4
    80003a84:	0691                	addi	a3,a3,4
    80003a86:	fef71ce3          	bne	a4,a5,80003a7e <initlog+0x68>
  brelse(buf);
    80003a8a:	fffff097          	auipc	ra,0xfffff
    80003a8e:	d68080e7          	jalr	-664(ra) # 800027f2 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    80003a92:	4505                	li	a0,1
    80003a94:	00000097          	auipc	ra,0x0
    80003a98:	ebe080e7          	jalr	-322(ra) # 80003952 <install_trans>
  log.lh.n = 0;
    80003a9c:	00015797          	auipc	a5,0x15
    80003aa0:	5a07a823          	sw	zero,1456(a5) # 8001904c <log+0x2c>
  write_head(); // clear the log
    80003aa4:	00000097          	auipc	ra,0x0
    80003aa8:	e34080e7          	jalr	-460(ra) # 800038d8 <write_head>
}
    80003aac:	70a2                	ld	ra,40(sp)
    80003aae:	7402                	ld	s0,32(sp)
    80003ab0:	64e2                	ld	s1,24(sp)
    80003ab2:	6942                	ld	s2,16(sp)
    80003ab4:	69a2                	ld	s3,8(sp)
    80003ab6:	6145                	addi	sp,sp,48
    80003ab8:	8082                	ret

0000000080003aba <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    80003aba:	1101                	addi	sp,sp,-32
    80003abc:	ec06                	sd	ra,24(sp)
    80003abe:	e822                	sd	s0,16(sp)
    80003ac0:	e426                	sd	s1,8(sp)
    80003ac2:	e04a                	sd	s2,0(sp)
    80003ac4:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    80003ac6:	00015517          	auipc	a0,0x15
    80003aca:	55a50513          	addi	a0,a0,1370 # 80019020 <log>
    80003ace:	00003097          	auipc	ra,0x3
    80003ad2:	ede080e7          	jalr	-290(ra) # 800069ac <acquire>
  while(1){
    if(log.committing){
    80003ad6:	00015497          	auipc	s1,0x15
    80003ada:	54a48493          	addi	s1,s1,1354 # 80019020 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003ade:	4979                	li	s2,30
    80003ae0:	a039                	j	80003aee <begin_op+0x34>
      sleep(&log, &log.lock);
    80003ae2:	85a6                	mv	a1,s1
    80003ae4:	8526                	mv	a0,s1
    80003ae6:	ffffe097          	auipc	ra,0xffffe
    80003aea:	e36080e7          	jalr	-458(ra) # 8000191c <sleep>
    if(log.committing){
    80003aee:	50dc                	lw	a5,36(s1)
    80003af0:	fbed                	bnez	a5,80003ae2 <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003af2:	509c                	lw	a5,32(s1)
    80003af4:	0017871b          	addiw	a4,a5,1
    80003af8:	0007069b          	sext.w	a3,a4
    80003afc:	0027179b          	slliw	a5,a4,0x2
    80003b00:	9fb9                	addw	a5,a5,a4
    80003b02:	0017979b          	slliw	a5,a5,0x1
    80003b06:	54d8                	lw	a4,44(s1)
    80003b08:	9fb9                	addw	a5,a5,a4
    80003b0a:	00f95963          	bge	s2,a5,80003b1c <begin_op+0x62>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80003b0e:	85a6                	mv	a1,s1
    80003b10:	8526                	mv	a0,s1
    80003b12:	ffffe097          	auipc	ra,0xffffe
    80003b16:	e0a080e7          	jalr	-502(ra) # 8000191c <sleep>
    80003b1a:	bfd1                	j	80003aee <begin_op+0x34>
    } else {
      log.outstanding += 1;
    80003b1c:	00015517          	auipc	a0,0x15
    80003b20:	50450513          	addi	a0,a0,1284 # 80019020 <log>
    80003b24:	d114                	sw	a3,32(a0)
      release(&log.lock);
    80003b26:	00003097          	auipc	ra,0x3
    80003b2a:	f3a080e7          	jalr	-198(ra) # 80006a60 <release>
      break;
    }
  }
}
    80003b2e:	60e2                	ld	ra,24(sp)
    80003b30:	6442                	ld	s0,16(sp)
    80003b32:	64a2                	ld	s1,8(sp)
    80003b34:	6902                	ld	s2,0(sp)
    80003b36:	6105                	addi	sp,sp,32
    80003b38:	8082                	ret

0000000080003b3a <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80003b3a:	7139                	addi	sp,sp,-64
    80003b3c:	fc06                	sd	ra,56(sp)
    80003b3e:	f822                	sd	s0,48(sp)
    80003b40:	f426                	sd	s1,40(sp)
    80003b42:	f04a                	sd	s2,32(sp)
    80003b44:	ec4e                	sd	s3,24(sp)
    80003b46:	e852                	sd	s4,16(sp)
    80003b48:	e456                	sd	s5,8(sp)
    80003b4a:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80003b4c:	00015497          	auipc	s1,0x15
    80003b50:	4d448493          	addi	s1,s1,1236 # 80019020 <log>
    80003b54:	8526                	mv	a0,s1
    80003b56:	00003097          	auipc	ra,0x3
    80003b5a:	e56080e7          	jalr	-426(ra) # 800069ac <acquire>
  log.outstanding -= 1;
    80003b5e:	509c                	lw	a5,32(s1)
    80003b60:	37fd                	addiw	a5,a5,-1
    80003b62:	0007891b          	sext.w	s2,a5
    80003b66:	d09c                	sw	a5,32(s1)
  if(log.committing)
    80003b68:	50dc                	lw	a5,36(s1)
    80003b6a:	efb9                	bnez	a5,80003bc8 <end_op+0x8e>
    panic("log.committing");
  if(log.outstanding == 0){
    80003b6c:	06091663          	bnez	s2,80003bd8 <end_op+0x9e>
    do_commit = 1;
    log.committing = 1;
    80003b70:	00015497          	auipc	s1,0x15
    80003b74:	4b048493          	addi	s1,s1,1200 # 80019020 <log>
    80003b78:	4785                	li	a5,1
    80003b7a:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    80003b7c:	8526                	mv	a0,s1
    80003b7e:	00003097          	auipc	ra,0x3
    80003b82:	ee2080e7          	jalr	-286(ra) # 80006a60 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    80003b86:	54dc                	lw	a5,44(s1)
    80003b88:	06f04763          	bgtz	a5,80003bf6 <end_op+0xbc>
    acquire(&log.lock);
    80003b8c:	00015497          	auipc	s1,0x15
    80003b90:	49448493          	addi	s1,s1,1172 # 80019020 <log>
    80003b94:	8526                	mv	a0,s1
    80003b96:	00003097          	auipc	ra,0x3
    80003b9a:	e16080e7          	jalr	-490(ra) # 800069ac <acquire>
    log.committing = 0;
    80003b9e:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    80003ba2:	8526                	mv	a0,s1
    80003ba4:	ffffe097          	auipc	ra,0xffffe
    80003ba8:	f04080e7          	jalr	-252(ra) # 80001aa8 <wakeup>
    release(&log.lock);
    80003bac:	8526                	mv	a0,s1
    80003bae:	00003097          	auipc	ra,0x3
    80003bb2:	eb2080e7          	jalr	-334(ra) # 80006a60 <release>
}
    80003bb6:	70e2                	ld	ra,56(sp)
    80003bb8:	7442                	ld	s0,48(sp)
    80003bba:	74a2                	ld	s1,40(sp)
    80003bbc:	7902                	ld	s2,32(sp)
    80003bbe:	69e2                	ld	s3,24(sp)
    80003bc0:	6a42                	ld	s4,16(sp)
    80003bc2:	6aa2                	ld	s5,8(sp)
    80003bc4:	6121                	addi	sp,sp,64
    80003bc6:	8082                	ret
    panic("log.committing");
    80003bc8:	00005517          	auipc	a0,0x5
    80003bcc:	b9050513          	addi	a0,a0,-1136 # 80008758 <syscalls+0x2d8>
    80003bd0:	00003097          	auipc	ra,0x3
    80003bd4:	892080e7          	jalr	-1902(ra) # 80006462 <panic>
    wakeup(&log);
    80003bd8:	00015497          	auipc	s1,0x15
    80003bdc:	44848493          	addi	s1,s1,1096 # 80019020 <log>
    80003be0:	8526                	mv	a0,s1
    80003be2:	ffffe097          	auipc	ra,0xffffe
    80003be6:	ec6080e7          	jalr	-314(ra) # 80001aa8 <wakeup>
  release(&log.lock);
    80003bea:	8526                	mv	a0,s1
    80003bec:	00003097          	auipc	ra,0x3
    80003bf0:	e74080e7          	jalr	-396(ra) # 80006a60 <release>
  if(do_commit){
    80003bf4:	b7c9                	j	80003bb6 <end_op+0x7c>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003bf6:	00015a97          	auipc	s5,0x15
    80003bfa:	45aa8a93          	addi	s5,s5,1114 # 80019050 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80003bfe:	00015a17          	auipc	s4,0x15
    80003c02:	422a0a13          	addi	s4,s4,1058 # 80019020 <log>
    80003c06:	018a2583          	lw	a1,24(s4)
    80003c0a:	012585bb          	addw	a1,a1,s2
    80003c0e:	2585                	addiw	a1,a1,1
    80003c10:	028a2503          	lw	a0,40(s4)
    80003c14:	fffff097          	auipc	ra,0xfffff
    80003c18:	b6c080e7          	jalr	-1172(ra) # 80002780 <bread>
    80003c1c:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    80003c1e:	000aa583          	lw	a1,0(s5)
    80003c22:	028a2503          	lw	a0,40(s4)
    80003c26:	fffff097          	auipc	ra,0xfffff
    80003c2a:	b5a080e7          	jalr	-1190(ra) # 80002780 <bread>
    80003c2e:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    80003c30:	40000613          	li	a2,1024
    80003c34:	05850593          	addi	a1,a0,88
    80003c38:	05848513          	addi	a0,s1,88
    80003c3c:	ffffc097          	auipc	ra,0xffffc
    80003c40:	59c080e7          	jalr	1436(ra) # 800001d8 <memmove>
    bwrite(to);  // write the log
    80003c44:	8526                	mv	a0,s1
    80003c46:	fffff097          	auipc	ra,0xfffff
    80003c4a:	b6e080e7          	jalr	-1170(ra) # 800027b4 <bwrite>
    brelse(from);
    80003c4e:	854e                	mv	a0,s3
    80003c50:	fffff097          	auipc	ra,0xfffff
    80003c54:	ba2080e7          	jalr	-1118(ra) # 800027f2 <brelse>
    brelse(to);
    80003c58:	8526                	mv	a0,s1
    80003c5a:	fffff097          	auipc	ra,0xfffff
    80003c5e:	b98080e7          	jalr	-1128(ra) # 800027f2 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003c62:	2905                	addiw	s2,s2,1
    80003c64:	0a91                	addi	s5,s5,4
    80003c66:	02ca2783          	lw	a5,44(s4)
    80003c6a:	f8f94ee3          	blt	s2,a5,80003c06 <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    80003c6e:	00000097          	auipc	ra,0x0
    80003c72:	c6a080e7          	jalr	-918(ra) # 800038d8 <write_head>
    install_trans(0); // Now install writes to home locations
    80003c76:	4501                	li	a0,0
    80003c78:	00000097          	auipc	ra,0x0
    80003c7c:	cda080e7          	jalr	-806(ra) # 80003952 <install_trans>
    log.lh.n = 0;
    80003c80:	00015797          	auipc	a5,0x15
    80003c84:	3c07a623          	sw	zero,972(a5) # 8001904c <log+0x2c>
    write_head();    // Erase the transaction from the log
    80003c88:	00000097          	auipc	ra,0x0
    80003c8c:	c50080e7          	jalr	-944(ra) # 800038d8 <write_head>
    80003c90:	bdf5                	j	80003b8c <end_op+0x52>

0000000080003c92 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    80003c92:	1101                	addi	sp,sp,-32
    80003c94:	ec06                	sd	ra,24(sp)
    80003c96:	e822                	sd	s0,16(sp)
    80003c98:	e426                	sd	s1,8(sp)
    80003c9a:	e04a                	sd	s2,0(sp)
    80003c9c:	1000                	addi	s0,sp,32
    80003c9e:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    80003ca0:	00015917          	auipc	s2,0x15
    80003ca4:	38090913          	addi	s2,s2,896 # 80019020 <log>
    80003ca8:	854a                	mv	a0,s2
    80003caa:	00003097          	auipc	ra,0x3
    80003cae:	d02080e7          	jalr	-766(ra) # 800069ac <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    80003cb2:	02c92603          	lw	a2,44(s2)
    80003cb6:	47f5                	li	a5,29
    80003cb8:	06c7c563          	blt	a5,a2,80003d22 <log_write+0x90>
    80003cbc:	00015797          	auipc	a5,0x15
    80003cc0:	3807a783          	lw	a5,896(a5) # 8001903c <log+0x1c>
    80003cc4:	37fd                	addiw	a5,a5,-1
    80003cc6:	04f65e63          	bge	a2,a5,80003d22 <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    80003cca:	00015797          	auipc	a5,0x15
    80003cce:	3767a783          	lw	a5,886(a5) # 80019040 <log+0x20>
    80003cd2:	06f05063          	blez	a5,80003d32 <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    80003cd6:	4781                	li	a5,0
    80003cd8:	06c05563          	blez	a2,80003d42 <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003cdc:	44cc                	lw	a1,12(s1)
    80003cde:	00015717          	auipc	a4,0x15
    80003ce2:	37270713          	addi	a4,a4,882 # 80019050 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    80003ce6:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003ce8:	4314                	lw	a3,0(a4)
    80003cea:	04b68c63          	beq	a3,a1,80003d42 <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    80003cee:	2785                	addiw	a5,a5,1
    80003cf0:	0711                	addi	a4,a4,4
    80003cf2:	fef61be3          	bne	a2,a5,80003ce8 <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    80003cf6:	0621                	addi	a2,a2,8
    80003cf8:	060a                	slli	a2,a2,0x2
    80003cfa:	00015797          	auipc	a5,0x15
    80003cfe:	32678793          	addi	a5,a5,806 # 80019020 <log>
    80003d02:	963e                	add	a2,a2,a5
    80003d04:	44dc                	lw	a5,12(s1)
    80003d06:	ca1c                	sw	a5,16(a2)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    80003d08:	8526                	mv	a0,s1
    80003d0a:	fffff097          	auipc	ra,0xfffff
    80003d0e:	b86080e7          	jalr	-1146(ra) # 80002890 <bpin>
    log.lh.n++;
    80003d12:	00015717          	auipc	a4,0x15
    80003d16:	30e70713          	addi	a4,a4,782 # 80019020 <log>
    80003d1a:	575c                	lw	a5,44(a4)
    80003d1c:	2785                	addiw	a5,a5,1
    80003d1e:	d75c                	sw	a5,44(a4)
    80003d20:	a835                	j	80003d5c <log_write+0xca>
    panic("too big a transaction");
    80003d22:	00005517          	auipc	a0,0x5
    80003d26:	a4650513          	addi	a0,a0,-1466 # 80008768 <syscalls+0x2e8>
    80003d2a:	00002097          	auipc	ra,0x2
    80003d2e:	738080e7          	jalr	1848(ra) # 80006462 <panic>
    panic("log_write outside of trans");
    80003d32:	00005517          	auipc	a0,0x5
    80003d36:	a4e50513          	addi	a0,a0,-1458 # 80008780 <syscalls+0x300>
    80003d3a:	00002097          	auipc	ra,0x2
    80003d3e:	728080e7          	jalr	1832(ra) # 80006462 <panic>
  log.lh.block[i] = b->blockno;
    80003d42:	00878713          	addi	a4,a5,8
    80003d46:	00271693          	slli	a3,a4,0x2
    80003d4a:	00015717          	auipc	a4,0x15
    80003d4e:	2d670713          	addi	a4,a4,726 # 80019020 <log>
    80003d52:	9736                	add	a4,a4,a3
    80003d54:	44d4                	lw	a3,12(s1)
    80003d56:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    80003d58:	faf608e3          	beq	a2,a5,80003d08 <log_write+0x76>
  }
  release(&log.lock);
    80003d5c:	00015517          	auipc	a0,0x15
    80003d60:	2c450513          	addi	a0,a0,708 # 80019020 <log>
    80003d64:	00003097          	auipc	ra,0x3
    80003d68:	cfc080e7          	jalr	-772(ra) # 80006a60 <release>
}
    80003d6c:	60e2                	ld	ra,24(sp)
    80003d6e:	6442                	ld	s0,16(sp)
    80003d70:	64a2                	ld	s1,8(sp)
    80003d72:	6902                	ld	s2,0(sp)
    80003d74:	6105                	addi	sp,sp,32
    80003d76:	8082                	ret

0000000080003d78 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80003d78:	1101                	addi	sp,sp,-32
    80003d7a:	ec06                	sd	ra,24(sp)
    80003d7c:	e822                	sd	s0,16(sp)
    80003d7e:	e426                	sd	s1,8(sp)
    80003d80:	e04a                	sd	s2,0(sp)
    80003d82:	1000                	addi	s0,sp,32
    80003d84:	84aa                	mv	s1,a0
    80003d86:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80003d88:	00005597          	auipc	a1,0x5
    80003d8c:	a1858593          	addi	a1,a1,-1512 # 800087a0 <syscalls+0x320>
    80003d90:	0521                	addi	a0,a0,8
    80003d92:	00003097          	auipc	ra,0x3
    80003d96:	b8a080e7          	jalr	-1142(ra) # 8000691c <initlock>
  lk->name = name;
    80003d9a:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    80003d9e:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003da2:	0204a423          	sw	zero,40(s1)
}
    80003da6:	60e2                	ld	ra,24(sp)
    80003da8:	6442                	ld	s0,16(sp)
    80003daa:	64a2                	ld	s1,8(sp)
    80003dac:	6902                	ld	s2,0(sp)
    80003dae:	6105                	addi	sp,sp,32
    80003db0:	8082                	ret

0000000080003db2 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80003db2:	1101                	addi	sp,sp,-32
    80003db4:	ec06                	sd	ra,24(sp)
    80003db6:	e822                	sd	s0,16(sp)
    80003db8:	e426                	sd	s1,8(sp)
    80003dba:	e04a                	sd	s2,0(sp)
    80003dbc:	1000                	addi	s0,sp,32
    80003dbe:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003dc0:	00850913          	addi	s2,a0,8
    80003dc4:	854a                	mv	a0,s2
    80003dc6:	00003097          	auipc	ra,0x3
    80003dca:	be6080e7          	jalr	-1050(ra) # 800069ac <acquire>
  while (lk->locked) {
    80003dce:	409c                	lw	a5,0(s1)
    80003dd0:	cb89                	beqz	a5,80003de2 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    80003dd2:	85ca                	mv	a1,s2
    80003dd4:	8526                	mv	a0,s1
    80003dd6:	ffffe097          	auipc	ra,0xffffe
    80003dda:	b46080e7          	jalr	-1210(ra) # 8000191c <sleep>
  while (lk->locked) {
    80003dde:	409c                	lw	a5,0(s1)
    80003de0:	fbed                	bnez	a5,80003dd2 <acquiresleep+0x20>
  }
  lk->locked = 1;
    80003de2:	4785                	li	a5,1
    80003de4:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80003de6:	ffffd097          	auipc	ra,0xffffd
    80003dea:	47a080e7          	jalr	1146(ra) # 80001260 <myproc>
    80003dee:	591c                	lw	a5,48(a0)
    80003df0:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    80003df2:	854a                	mv	a0,s2
    80003df4:	00003097          	auipc	ra,0x3
    80003df8:	c6c080e7          	jalr	-916(ra) # 80006a60 <release>
}
    80003dfc:	60e2                	ld	ra,24(sp)
    80003dfe:	6442                	ld	s0,16(sp)
    80003e00:	64a2                	ld	s1,8(sp)
    80003e02:	6902                	ld	s2,0(sp)
    80003e04:	6105                	addi	sp,sp,32
    80003e06:	8082                	ret

0000000080003e08 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80003e08:	1101                	addi	sp,sp,-32
    80003e0a:	ec06                	sd	ra,24(sp)
    80003e0c:	e822                	sd	s0,16(sp)
    80003e0e:	e426                	sd	s1,8(sp)
    80003e10:	e04a                	sd	s2,0(sp)
    80003e12:	1000                	addi	s0,sp,32
    80003e14:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003e16:	00850913          	addi	s2,a0,8
    80003e1a:	854a                	mv	a0,s2
    80003e1c:	00003097          	auipc	ra,0x3
    80003e20:	b90080e7          	jalr	-1136(ra) # 800069ac <acquire>
  lk->locked = 0;
    80003e24:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003e28:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80003e2c:	8526                	mv	a0,s1
    80003e2e:	ffffe097          	auipc	ra,0xffffe
    80003e32:	c7a080e7          	jalr	-902(ra) # 80001aa8 <wakeup>
  release(&lk->lk);
    80003e36:	854a                	mv	a0,s2
    80003e38:	00003097          	auipc	ra,0x3
    80003e3c:	c28080e7          	jalr	-984(ra) # 80006a60 <release>
}
    80003e40:	60e2                	ld	ra,24(sp)
    80003e42:	6442                	ld	s0,16(sp)
    80003e44:	64a2                	ld	s1,8(sp)
    80003e46:	6902                	ld	s2,0(sp)
    80003e48:	6105                	addi	sp,sp,32
    80003e4a:	8082                	ret

0000000080003e4c <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80003e4c:	7179                	addi	sp,sp,-48
    80003e4e:	f406                	sd	ra,40(sp)
    80003e50:	f022                	sd	s0,32(sp)
    80003e52:	ec26                	sd	s1,24(sp)
    80003e54:	e84a                	sd	s2,16(sp)
    80003e56:	e44e                	sd	s3,8(sp)
    80003e58:	1800                	addi	s0,sp,48
    80003e5a:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80003e5c:	00850913          	addi	s2,a0,8
    80003e60:	854a                	mv	a0,s2
    80003e62:	00003097          	auipc	ra,0x3
    80003e66:	b4a080e7          	jalr	-1206(ra) # 800069ac <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80003e6a:	409c                	lw	a5,0(s1)
    80003e6c:	ef99                	bnez	a5,80003e8a <holdingsleep+0x3e>
    80003e6e:	4481                	li	s1,0
  release(&lk->lk);
    80003e70:	854a                	mv	a0,s2
    80003e72:	00003097          	auipc	ra,0x3
    80003e76:	bee080e7          	jalr	-1042(ra) # 80006a60 <release>
  return r;
}
    80003e7a:	8526                	mv	a0,s1
    80003e7c:	70a2                	ld	ra,40(sp)
    80003e7e:	7402                	ld	s0,32(sp)
    80003e80:	64e2                	ld	s1,24(sp)
    80003e82:	6942                	ld	s2,16(sp)
    80003e84:	69a2                	ld	s3,8(sp)
    80003e86:	6145                	addi	sp,sp,48
    80003e88:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    80003e8a:	0284a983          	lw	s3,40(s1)
    80003e8e:	ffffd097          	auipc	ra,0xffffd
    80003e92:	3d2080e7          	jalr	978(ra) # 80001260 <myproc>
    80003e96:	5904                	lw	s1,48(a0)
    80003e98:	413484b3          	sub	s1,s1,s3
    80003e9c:	0014b493          	seqz	s1,s1
    80003ea0:	bfc1                	j	80003e70 <holdingsleep+0x24>

0000000080003ea2 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80003ea2:	1141                	addi	sp,sp,-16
    80003ea4:	e406                	sd	ra,8(sp)
    80003ea6:	e022                	sd	s0,0(sp)
    80003ea8:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003eaa:	00005597          	auipc	a1,0x5
    80003eae:	90658593          	addi	a1,a1,-1786 # 800087b0 <syscalls+0x330>
    80003eb2:	00015517          	auipc	a0,0x15
    80003eb6:	2b650513          	addi	a0,a0,694 # 80019168 <ftable>
    80003eba:	00003097          	auipc	ra,0x3
    80003ebe:	a62080e7          	jalr	-1438(ra) # 8000691c <initlock>
}
    80003ec2:	60a2                	ld	ra,8(sp)
    80003ec4:	6402                	ld	s0,0(sp)
    80003ec6:	0141                	addi	sp,sp,16
    80003ec8:	8082                	ret

0000000080003eca <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80003eca:	1101                	addi	sp,sp,-32
    80003ecc:	ec06                	sd	ra,24(sp)
    80003ece:	e822                	sd	s0,16(sp)
    80003ed0:	e426                	sd	s1,8(sp)
    80003ed2:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80003ed4:	00015517          	auipc	a0,0x15
    80003ed8:	29450513          	addi	a0,a0,660 # 80019168 <ftable>
    80003edc:	00003097          	auipc	ra,0x3
    80003ee0:	ad0080e7          	jalr	-1328(ra) # 800069ac <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003ee4:	00015497          	auipc	s1,0x15
    80003ee8:	29c48493          	addi	s1,s1,668 # 80019180 <ftable+0x18>
    80003eec:	00016717          	auipc	a4,0x16
    80003ef0:	23470713          	addi	a4,a4,564 # 8001a120 <ftable+0xfb8>
    if(f->ref == 0){
    80003ef4:	40dc                	lw	a5,4(s1)
    80003ef6:	cf99                	beqz	a5,80003f14 <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003ef8:	02848493          	addi	s1,s1,40
    80003efc:	fee49ce3          	bne	s1,a4,80003ef4 <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80003f00:	00015517          	auipc	a0,0x15
    80003f04:	26850513          	addi	a0,a0,616 # 80019168 <ftable>
    80003f08:	00003097          	auipc	ra,0x3
    80003f0c:	b58080e7          	jalr	-1192(ra) # 80006a60 <release>
  return 0;
    80003f10:	4481                	li	s1,0
    80003f12:	a819                	j	80003f28 <filealloc+0x5e>
      f->ref = 1;
    80003f14:	4785                	li	a5,1
    80003f16:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80003f18:	00015517          	auipc	a0,0x15
    80003f1c:	25050513          	addi	a0,a0,592 # 80019168 <ftable>
    80003f20:	00003097          	auipc	ra,0x3
    80003f24:	b40080e7          	jalr	-1216(ra) # 80006a60 <release>
}
    80003f28:	8526                	mv	a0,s1
    80003f2a:	60e2                	ld	ra,24(sp)
    80003f2c:	6442                	ld	s0,16(sp)
    80003f2e:	64a2                	ld	s1,8(sp)
    80003f30:	6105                	addi	sp,sp,32
    80003f32:	8082                	ret

0000000080003f34 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80003f34:	1101                	addi	sp,sp,-32
    80003f36:	ec06                	sd	ra,24(sp)
    80003f38:	e822                	sd	s0,16(sp)
    80003f3a:	e426                	sd	s1,8(sp)
    80003f3c:	1000                	addi	s0,sp,32
    80003f3e:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80003f40:	00015517          	auipc	a0,0x15
    80003f44:	22850513          	addi	a0,a0,552 # 80019168 <ftable>
    80003f48:	00003097          	auipc	ra,0x3
    80003f4c:	a64080e7          	jalr	-1436(ra) # 800069ac <acquire>
  if(f->ref < 1)
    80003f50:	40dc                	lw	a5,4(s1)
    80003f52:	02f05263          	blez	a5,80003f76 <filedup+0x42>
    panic("filedup");
  f->ref++;
    80003f56:	2785                	addiw	a5,a5,1
    80003f58:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80003f5a:	00015517          	auipc	a0,0x15
    80003f5e:	20e50513          	addi	a0,a0,526 # 80019168 <ftable>
    80003f62:	00003097          	auipc	ra,0x3
    80003f66:	afe080e7          	jalr	-1282(ra) # 80006a60 <release>
  return f;
}
    80003f6a:	8526                	mv	a0,s1
    80003f6c:	60e2                	ld	ra,24(sp)
    80003f6e:	6442                	ld	s0,16(sp)
    80003f70:	64a2                	ld	s1,8(sp)
    80003f72:	6105                	addi	sp,sp,32
    80003f74:	8082                	ret
    panic("filedup");
    80003f76:	00005517          	auipc	a0,0x5
    80003f7a:	84250513          	addi	a0,a0,-1982 # 800087b8 <syscalls+0x338>
    80003f7e:	00002097          	auipc	ra,0x2
    80003f82:	4e4080e7          	jalr	1252(ra) # 80006462 <panic>

0000000080003f86 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80003f86:	7139                	addi	sp,sp,-64
    80003f88:	fc06                	sd	ra,56(sp)
    80003f8a:	f822                	sd	s0,48(sp)
    80003f8c:	f426                	sd	s1,40(sp)
    80003f8e:	f04a                	sd	s2,32(sp)
    80003f90:	ec4e                	sd	s3,24(sp)
    80003f92:	e852                	sd	s4,16(sp)
    80003f94:	e456                	sd	s5,8(sp)
    80003f96:	0080                	addi	s0,sp,64
    80003f98:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80003f9a:	00015517          	auipc	a0,0x15
    80003f9e:	1ce50513          	addi	a0,a0,462 # 80019168 <ftable>
    80003fa2:	00003097          	auipc	ra,0x3
    80003fa6:	a0a080e7          	jalr	-1526(ra) # 800069ac <acquire>
  if(f->ref < 1)
    80003faa:	40dc                	lw	a5,4(s1)
    80003fac:	06f05163          	blez	a5,8000400e <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    80003fb0:	37fd                	addiw	a5,a5,-1
    80003fb2:	0007871b          	sext.w	a4,a5
    80003fb6:	c0dc                	sw	a5,4(s1)
    80003fb8:	06e04363          	bgtz	a4,8000401e <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80003fbc:	0004a903          	lw	s2,0(s1)
    80003fc0:	0094ca83          	lbu	s5,9(s1)
    80003fc4:	0104ba03          	ld	s4,16(s1)
    80003fc8:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80003fcc:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80003fd0:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80003fd4:	00015517          	auipc	a0,0x15
    80003fd8:	19450513          	addi	a0,a0,404 # 80019168 <ftable>
    80003fdc:	00003097          	auipc	ra,0x3
    80003fe0:	a84080e7          	jalr	-1404(ra) # 80006a60 <release>

  if(ff.type == FD_PIPE){
    80003fe4:	4785                	li	a5,1
    80003fe6:	04f90d63          	beq	s2,a5,80004040 <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003fea:	3979                	addiw	s2,s2,-2
    80003fec:	4785                	li	a5,1
    80003fee:	0527e063          	bltu	a5,s2,8000402e <fileclose+0xa8>
    begin_op();
    80003ff2:	00000097          	auipc	ra,0x0
    80003ff6:	ac8080e7          	jalr	-1336(ra) # 80003aba <begin_op>
    iput(ff.ip);
    80003ffa:	854e                	mv	a0,s3
    80003ffc:	fffff097          	auipc	ra,0xfffff
    80004000:	11e080e7          	jalr	286(ra) # 8000311a <iput>
    end_op();
    80004004:	00000097          	auipc	ra,0x0
    80004008:	b36080e7          	jalr	-1226(ra) # 80003b3a <end_op>
    8000400c:	a00d                	j	8000402e <fileclose+0xa8>
    panic("fileclose");
    8000400e:	00004517          	auipc	a0,0x4
    80004012:	7b250513          	addi	a0,a0,1970 # 800087c0 <syscalls+0x340>
    80004016:	00002097          	auipc	ra,0x2
    8000401a:	44c080e7          	jalr	1100(ra) # 80006462 <panic>
    release(&ftable.lock);
    8000401e:	00015517          	auipc	a0,0x15
    80004022:	14a50513          	addi	a0,a0,330 # 80019168 <ftable>
    80004026:	00003097          	auipc	ra,0x3
    8000402a:	a3a080e7          	jalr	-1478(ra) # 80006a60 <release>
  }
}
    8000402e:	70e2                	ld	ra,56(sp)
    80004030:	7442                	ld	s0,48(sp)
    80004032:	74a2                	ld	s1,40(sp)
    80004034:	7902                	ld	s2,32(sp)
    80004036:	69e2                	ld	s3,24(sp)
    80004038:	6a42                	ld	s4,16(sp)
    8000403a:	6aa2                	ld	s5,8(sp)
    8000403c:	6121                	addi	sp,sp,64
    8000403e:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80004040:	85d6                	mv	a1,s5
    80004042:	8552                	mv	a0,s4
    80004044:	00000097          	auipc	ra,0x0
    80004048:	34c080e7          	jalr	844(ra) # 80004390 <pipeclose>
    8000404c:	b7cd                	j	8000402e <fileclose+0xa8>

000000008000404e <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    8000404e:	715d                	addi	sp,sp,-80
    80004050:	e486                	sd	ra,72(sp)
    80004052:	e0a2                	sd	s0,64(sp)
    80004054:	fc26                	sd	s1,56(sp)
    80004056:	f84a                	sd	s2,48(sp)
    80004058:	f44e                	sd	s3,40(sp)
    8000405a:	0880                	addi	s0,sp,80
    8000405c:	84aa                	mv	s1,a0
    8000405e:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80004060:	ffffd097          	auipc	ra,0xffffd
    80004064:	200080e7          	jalr	512(ra) # 80001260 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80004068:	409c                	lw	a5,0(s1)
    8000406a:	37f9                	addiw	a5,a5,-2
    8000406c:	4705                	li	a4,1
    8000406e:	04f76763          	bltu	a4,a5,800040bc <filestat+0x6e>
    80004072:	892a                	mv	s2,a0
    ilock(f->ip);
    80004074:	6c88                	ld	a0,24(s1)
    80004076:	fffff097          	auipc	ra,0xfffff
    8000407a:	eea080e7          	jalr	-278(ra) # 80002f60 <ilock>
    stati(f->ip, &st);
    8000407e:	fb840593          	addi	a1,s0,-72
    80004082:	6c88                	ld	a0,24(s1)
    80004084:	fffff097          	auipc	ra,0xfffff
    80004088:	166080e7          	jalr	358(ra) # 800031ea <stati>
    iunlock(f->ip);
    8000408c:	6c88                	ld	a0,24(s1)
    8000408e:	fffff097          	auipc	ra,0xfffff
    80004092:	f94080e7          	jalr	-108(ra) # 80003022 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80004096:	46e1                	li	a3,24
    80004098:	fb840613          	addi	a2,s0,-72
    8000409c:	85ce                	mv	a1,s3
    8000409e:	05093503          	ld	a0,80(s2)
    800040a2:	ffffd097          	auipc	ra,0xffffd
    800040a6:	a60080e7          	jalr	-1440(ra) # 80000b02 <copyout>
    800040aa:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    800040ae:	60a6                	ld	ra,72(sp)
    800040b0:	6406                	ld	s0,64(sp)
    800040b2:	74e2                	ld	s1,56(sp)
    800040b4:	7942                	ld	s2,48(sp)
    800040b6:	79a2                	ld	s3,40(sp)
    800040b8:	6161                	addi	sp,sp,80
    800040ba:	8082                	ret
  return -1;
    800040bc:	557d                	li	a0,-1
    800040be:	bfc5                	j	800040ae <filestat+0x60>

00000000800040c0 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    800040c0:	7179                	addi	sp,sp,-48
    800040c2:	f406                	sd	ra,40(sp)
    800040c4:	f022                	sd	s0,32(sp)
    800040c6:	ec26                	sd	s1,24(sp)
    800040c8:	e84a                	sd	s2,16(sp)
    800040ca:	e44e                	sd	s3,8(sp)
    800040cc:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    800040ce:	00854783          	lbu	a5,8(a0)
    800040d2:	c3d5                	beqz	a5,80004176 <fileread+0xb6>
    800040d4:	84aa                	mv	s1,a0
    800040d6:	89ae                	mv	s3,a1
    800040d8:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    800040da:	411c                	lw	a5,0(a0)
    800040dc:	4705                	li	a4,1
    800040de:	04e78963          	beq	a5,a4,80004130 <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    800040e2:	470d                	li	a4,3
    800040e4:	04e78d63          	beq	a5,a4,8000413e <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    800040e8:	4709                	li	a4,2
    800040ea:	06e79e63          	bne	a5,a4,80004166 <fileread+0xa6>
    ilock(f->ip);
    800040ee:	6d08                	ld	a0,24(a0)
    800040f0:	fffff097          	auipc	ra,0xfffff
    800040f4:	e70080e7          	jalr	-400(ra) # 80002f60 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    800040f8:	874a                	mv	a4,s2
    800040fa:	5094                	lw	a3,32(s1)
    800040fc:	864e                	mv	a2,s3
    800040fe:	4585                	li	a1,1
    80004100:	6c88                	ld	a0,24(s1)
    80004102:	fffff097          	auipc	ra,0xfffff
    80004106:	112080e7          	jalr	274(ra) # 80003214 <readi>
    8000410a:	892a                	mv	s2,a0
    8000410c:	00a05563          	blez	a0,80004116 <fileread+0x56>
      f->off += r;
    80004110:	509c                	lw	a5,32(s1)
    80004112:	9fa9                	addw	a5,a5,a0
    80004114:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80004116:	6c88                	ld	a0,24(s1)
    80004118:	fffff097          	auipc	ra,0xfffff
    8000411c:	f0a080e7          	jalr	-246(ra) # 80003022 <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    80004120:	854a                	mv	a0,s2
    80004122:	70a2                	ld	ra,40(sp)
    80004124:	7402                	ld	s0,32(sp)
    80004126:	64e2                	ld	s1,24(sp)
    80004128:	6942                	ld	s2,16(sp)
    8000412a:	69a2                	ld	s3,8(sp)
    8000412c:	6145                	addi	sp,sp,48
    8000412e:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80004130:	6908                	ld	a0,16(a0)
    80004132:	00000097          	auipc	ra,0x0
    80004136:	3c8080e7          	jalr	968(ra) # 800044fa <piperead>
    8000413a:	892a                	mv	s2,a0
    8000413c:	b7d5                	j	80004120 <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    8000413e:	02451783          	lh	a5,36(a0)
    80004142:	03079693          	slli	a3,a5,0x30
    80004146:	92c1                	srli	a3,a3,0x30
    80004148:	4725                	li	a4,9
    8000414a:	02d76863          	bltu	a4,a3,8000417a <fileread+0xba>
    8000414e:	0792                	slli	a5,a5,0x4
    80004150:	00015717          	auipc	a4,0x15
    80004154:	f7870713          	addi	a4,a4,-136 # 800190c8 <devsw>
    80004158:	97ba                	add	a5,a5,a4
    8000415a:	639c                	ld	a5,0(a5)
    8000415c:	c38d                	beqz	a5,8000417e <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    8000415e:	4505                	li	a0,1
    80004160:	9782                	jalr	a5
    80004162:	892a                	mv	s2,a0
    80004164:	bf75                	j	80004120 <fileread+0x60>
    panic("fileread");
    80004166:	00004517          	auipc	a0,0x4
    8000416a:	66a50513          	addi	a0,a0,1642 # 800087d0 <syscalls+0x350>
    8000416e:	00002097          	auipc	ra,0x2
    80004172:	2f4080e7          	jalr	756(ra) # 80006462 <panic>
    return -1;
    80004176:	597d                	li	s2,-1
    80004178:	b765                	j	80004120 <fileread+0x60>
      return -1;
    8000417a:	597d                	li	s2,-1
    8000417c:	b755                	j	80004120 <fileread+0x60>
    8000417e:	597d                	li	s2,-1
    80004180:	b745                	j	80004120 <fileread+0x60>

0000000080004182 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80004182:	715d                	addi	sp,sp,-80
    80004184:	e486                	sd	ra,72(sp)
    80004186:	e0a2                	sd	s0,64(sp)
    80004188:	fc26                	sd	s1,56(sp)
    8000418a:	f84a                	sd	s2,48(sp)
    8000418c:	f44e                	sd	s3,40(sp)
    8000418e:	f052                	sd	s4,32(sp)
    80004190:	ec56                	sd	s5,24(sp)
    80004192:	e85a                	sd	s6,16(sp)
    80004194:	e45e                	sd	s7,8(sp)
    80004196:	e062                	sd	s8,0(sp)
    80004198:	0880                	addi	s0,sp,80
  int r, ret = 0;

  if(f->writable == 0)
    8000419a:	00954783          	lbu	a5,9(a0)
    8000419e:	10078663          	beqz	a5,800042aa <filewrite+0x128>
    800041a2:	892a                	mv	s2,a0
    800041a4:	8aae                	mv	s5,a1
    800041a6:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    800041a8:	411c                	lw	a5,0(a0)
    800041aa:	4705                	li	a4,1
    800041ac:	02e78263          	beq	a5,a4,800041d0 <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    800041b0:	470d                	li	a4,3
    800041b2:	02e78663          	beq	a5,a4,800041de <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    800041b6:	4709                	li	a4,2
    800041b8:	0ee79163          	bne	a5,a4,8000429a <filewrite+0x118>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    800041bc:	0ac05d63          	blez	a2,80004276 <filewrite+0xf4>
    int i = 0;
    800041c0:	4981                	li	s3,0
    800041c2:	6b05                	lui	s6,0x1
    800041c4:	c00b0b13          	addi	s6,s6,-1024 # c00 <_entry-0x7ffff400>
    800041c8:	6b85                	lui	s7,0x1
    800041ca:	c00b8b9b          	addiw	s7,s7,-1024
    800041ce:	a861                	j	80004266 <filewrite+0xe4>
    ret = pipewrite(f->pipe, addr, n);
    800041d0:	6908                	ld	a0,16(a0)
    800041d2:	00000097          	auipc	ra,0x0
    800041d6:	22e080e7          	jalr	558(ra) # 80004400 <pipewrite>
    800041da:	8a2a                	mv	s4,a0
    800041dc:	a045                	j	8000427c <filewrite+0xfa>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    800041de:	02451783          	lh	a5,36(a0)
    800041e2:	03079693          	slli	a3,a5,0x30
    800041e6:	92c1                	srli	a3,a3,0x30
    800041e8:	4725                	li	a4,9
    800041ea:	0cd76263          	bltu	a4,a3,800042ae <filewrite+0x12c>
    800041ee:	0792                	slli	a5,a5,0x4
    800041f0:	00015717          	auipc	a4,0x15
    800041f4:	ed870713          	addi	a4,a4,-296 # 800190c8 <devsw>
    800041f8:	97ba                	add	a5,a5,a4
    800041fa:	679c                	ld	a5,8(a5)
    800041fc:	cbdd                	beqz	a5,800042b2 <filewrite+0x130>
    ret = devsw[f->major].write(1, addr, n);
    800041fe:	4505                	li	a0,1
    80004200:	9782                	jalr	a5
    80004202:	8a2a                	mv	s4,a0
    80004204:	a8a5                	j	8000427c <filewrite+0xfa>
    80004206:	00048c1b          	sext.w	s8,s1
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
    8000420a:	00000097          	auipc	ra,0x0
    8000420e:	8b0080e7          	jalr	-1872(ra) # 80003aba <begin_op>
      ilock(f->ip);
    80004212:	01893503          	ld	a0,24(s2)
    80004216:	fffff097          	auipc	ra,0xfffff
    8000421a:	d4a080e7          	jalr	-694(ra) # 80002f60 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    8000421e:	8762                	mv	a4,s8
    80004220:	02092683          	lw	a3,32(s2)
    80004224:	01598633          	add	a2,s3,s5
    80004228:	4585                	li	a1,1
    8000422a:	01893503          	ld	a0,24(s2)
    8000422e:	fffff097          	auipc	ra,0xfffff
    80004232:	0de080e7          	jalr	222(ra) # 8000330c <writei>
    80004236:	84aa                	mv	s1,a0
    80004238:	00a05763          	blez	a0,80004246 <filewrite+0xc4>
        f->off += r;
    8000423c:	02092783          	lw	a5,32(s2)
    80004240:	9fa9                	addw	a5,a5,a0
    80004242:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80004246:	01893503          	ld	a0,24(s2)
    8000424a:	fffff097          	auipc	ra,0xfffff
    8000424e:	dd8080e7          	jalr	-552(ra) # 80003022 <iunlock>
      end_op();
    80004252:	00000097          	auipc	ra,0x0
    80004256:	8e8080e7          	jalr	-1816(ra) # 80003b3a <end_op>

      if(r != n1){
    8000425a:	009c1f63          	bne	s8,s1,80004278 <filewrite+0xf6>
        // error from writei
        break;
      }
      i += r;
    8000425e:	013489bb          	addw	s3,s1,s3
    while(i < n){
    80004262:	0149db63          	bge	s3,s4,80004278 <filewrite+0xf6>
      int n1 = n - i;
    80004266:	413a07bb          	subw	a5,s4,s3
      if(n1 > max)
    8000426a:	84be                	mv	s1,a5
    8000426c:	2781                	sext.w	a5,a5
    8000426e:	f8fb5ce3          	bge	s6,a5,80004206 <filewrite+0x84>
    80004272:	84de                	mv	s1,s7
    80004274:	bf49                	j	80004206 <filewrite+0x84>
    int i = 0;
    80004276:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    80004278:	013a1f63          	bne	s4,s3,80004296 <filewrite+0x114>
  } else {
    panic("filewrite");
  }

  return ret;
}
    8000427c:	8552                	mv	a0,s4
    8000427e:	60a6                	ld	ra,72(sp)
    80004280:	6406                	ld	s0,64(sp)
    80004282:	74e2                	ld	s1,56(sp)
    80004284:	7942                	ld	s2,48(sp)
    80004286:	79a2                	ld	s3,40(sp)
    80004288:	7a02                	ld	s4,32(sp)
    8000428a:	6ae2                	ld	s5,24(sp)
    8000428c:	6b42                	ld	s6,16(sp)
    8000428e:	6ba2                	ld	s7,8(sp)
    80004290:	6c02                	ld	s8,0(sp)
    80004292:	6161                	addi	sp,sp,80
    80004294:	8082                	ret
    ret = (i == n ? n : -1);
    80004296:	5a7d                	li	s4,-1
    80004298:	b7d5                	j	8000427c <filewrite+0xfa>
    panic("filewrite");
    8000429a:	00004517          	auipc	a0,0x4
    8000429e:	54650513          	addi	a0,a0,1350 # 800087e0 <syscalls+0x360>
    800042a2:	00002097          	auipc	ra,0x2
    800042a6:	1c0080e7          	jalr	448(ra) # 80006462 <panic>
    return -1;
    800042aa:	5a7d                	li	s4,-1
    800042ac:	bfc1                	j	8000427c <filewrite+0xfa>
      return -1;
    800042ae:	5a7d                	li	s4,-1
    800042b0:	b7f1                	j	8000427c <filewrite+0xfa>
    800042b2:	5a7d                	li	s4,-1
    800042b4:	b7e1                	j	8000427c <filewrite+0xfa>

00000000800042b6 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    800042b6:	7179                	addi	sp,sp,-48
    800042b8:	f406                	sd	ra,40(sp)
    800042ba:	f022                	sd	s0,32(sp)
    800042bc:	ec26                	sd	s1,24(sp)
    800042be:	e84a                	sd	s2,16(sp)
    800042c0:	e44e                	sd	s3,8(sp)
    800042c2:	e052                	sd	s4,0(sp)
    800042c4:	1800                	addi	s0,sp,48
    800042c6:	84aa                	mv	s1,a0
    800042c8:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    800042ca:	0005b023          	sd	zero,0(a1)
    800042ce:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    800042d2:	00000097          	auipc	ra,0x0
    800042d6:	bf8080e7          	jalr	-1032(ra) # 80003eca <filealloc>
    800042da:	e088                	sd	a0,0(s1)
    800042dc:	c551                	beqz	a0,80004368 <pipealloc+0xb2>
    800042de:	00000097          	auipc	ra,0x0
    800042e2:	bec080e7          	jalr	-1044(ra) # 80003eca <filealloc>
    800042e6:	00aa3023          	sd	a0,0(s4)
    800042ea:	c92d                	beqz	a0,8000435c <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    800042ec:	ffffc097          	auipc	ra,0xffffc
    800042f0:	e2c080e7          	jalr	-468(ra) # 80000118 <kalloc>
    800042f4:	892a                	mv	s2,a0
    800042f6:	c125                	beqz	a0,80004356 <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    800042f8:	4985                	li	s3,1
    800042fa:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    800042fe:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80004302:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80004306:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    8000430a:	00004597          	auipc	a1,0x4
    8000430e:	4e658593          	addi	a1,a1,1254 # 800087f0 <syscalls+0x370>
    80004312:	00002097          	auipc	ra,0x2
    80004316:	60a080e7          	jalr	1546(ra) # 8000691c <initlock>
  (*f0)->type = FD_PIPE;
    8000431a:	609c                	ld	a5,0(s1)
    8000431c:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80004320:	609c                	ld	a5,0(s1)
    80004322:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80004326:	609c                	ld	a5,0(s1)
    80004328:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    8000432c:	609c                	ld	a5,0(s1)
    8000432e:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80004332:	000a3783          	ld	a5,0(s4)
    80004336:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    8000433a:	000a3783          	ld	a5,0(s4)
    8000433e:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80004342:	000a3783          	ld	a5,0(s4)
    80004346:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    8000434a:	000a3783          	ld	a5,0(s4)
    8000434e:	0127b823          	sd	s2,16(a5)
  return 0;
    80004352:	4501                	li	a0,0
    80004354:	a025                	j	8000437c <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80004356:	6088                	ld	a0,0(s1)
    80004358:	e501                	bnez	a0,80004360 <pipealloc+0xaa>
    8000435a:	a039                	j	80004368 <pipealloc+0xb2>
    8000435c:	6088                	ld	a0,0(s1)
    8000435e:	c51d                	beqz	a0,8000438c <pipealloc+0xd6>
    fileclose(*f0);
    80004360:	00000097          	auipc	ra,0x0
    80004364:	c26080e7          	jalr	-986(ra) # 80003f86 <fileclose>
  if(*f1)
    80004368:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    8000436c:	557d                	li	a0,-1
  if(*f1)
    8000436e:	c799                	beqz	a5,8000437c <pipealloc+0xc6>
    fileclose(*f1);
    80004370:	853e                	mv	a0,a5
    80004372:	00000097          	auipc	ra,0x0
    80004376:	c14080e7          	jalr	-1004(ra) # 80003f86 <fileclose>
  return -1;
    8000437a:	557d                	li	a0,-1
}
    8000437c:	70a2                	ld	ra,40(sp)
    8000437e:	7402                	ld	s0,32(sp)
    80004380:	64e2                	ld	s1,24(sp)
    80004382:	6942                	ld	s2,16(sp)
    80004384:	69a2                	ld	s3,8(sp)
    80004386:	6a02                	ld	s4,0(sp)
    80004388:	6145                	addi	sp,sp,48
    8000438a:	8082                	ret
  return -1;
    8000438c:	557d                	li	a0,-1
    8000438e:	b7fd                	j	8000437c <pipealloc+0xc6>

0000000080004390 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80004390:	1101                	addi	sp,sp,-32
    80004392:	ec06                	sd	ra,24(sp)
    80004394:	e822                	sd	s0,16(sp)
    80004396:	e426                	sd	s1,8(sp)
    80004398:	e04a                	sd	s2,0(sp)
    8000439a:	1000                	addi	s0,sp,32
    8000439c:	84aa                	mv	s1,a0
    8000439e:	892e                	mv	s2,a1
  acquire(&pi->lock);
    800043a0:	00002097          	auipc	ra,0x2
    800043a4:	60c080e7          	jalr	1548(ra) # 800069ac <acquire>
  if(writable){
    800043a8:	02090d63          	beqz	s2,800043e2 <pipeclose+0x52>
    pi->writeopen = 0;
    800043ac:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    800043b0:	21848513          	addi	a0,s1,536
    800043b4:	ffffd097          	auipc	ra,0xffffd
    800043b8:	6f4080e7          	jalr	1780(ra) # 80001aa8 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    800043bc:	2204b783          	ld	a5,544(s1)
    800043c0:	eb95                	bnez	a5,800043f4 <pipeclose+0x64>
    release(&pi->lock);
    800043c2:	8526                	mv	a0,s1
    800043c4:	00002097          	auipc	ra,0x2
    800043c8:	69c080e7          	jalr	1692(ra) # 80006a60 <release>
    kfree((char*)pi);
    800043cc:	8526                	mv	a0,s1
    800043ce:	ffffc097          	auipc	ra,0xffffc
    800043d2:	c4e080e7          	jalr	-946(ra) # 8000001c <kfree>
  } else
    release(&pi->lock);
}
    800043d6:	60e2                	ld	ra,24(sp)
    800043d8:	6442                	ld	s0,16(sp)
    800043da:	64a2                	ld	s1,8(sp)
    800043dc:	6902                	ld	s2,0(sp)
    800043de:	6105                	addi	sp,sp,32
    800043e0:	8082                	ret
    pi->readopen = 0;
    800043e2:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    800043e6:	21c48513          	addi	a0,s1,540
    800043ea:	ffffd097          	auipc	ra,0xffffd
    800043ee:	6be080e7          	jalr	1726(ra) # 80001aa8 <wakeup>
    800043f2:	b7e9                	j	800043bc <pipeclose+0x2c>
    release(&pi->lock);
    800043f4:	8526                	mv	a0,s1
    800043f6:	00002097          	auipc	ra,0x2
    800043fa:	66a080e7          	jalr	1642(ra) # 80006a60 <release>
}
    800043fe:	bfe1                	j	800043d6 <pipeclose+0x46>

0000000080004400 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80004400:	7159                	addi	sp,sp,-112
    80004402:	f486                	sd	ra,104(sp)
    80004404:	f0a2                	sd	s0,96(sp)
    80004406:	eca6                	sd	s1,88(sp)
    80004408:	e8ca                	sd	s2,80(sp)
    8000440a:	e4ce                	sd	s3,72(sp)
    8000440c:	e0d2                	sd	s4,64(sp)
    8000440e:	fc56                	sd	s5,56(sp)
    80004410:	f85a                	sd	s6,48(sp)
    80004412:	f45e                	sd	s7,40(sp)
    80004414:	f062                	sd	s8,32(sp)
    80004416:	ec66                	sd	s9,24(sp)
    80004418:	1880                	addi	s0,sp,112
    8000441a:	84aa                	mv	s1,a0
    8000441c:	8aae                	mv	s5,a1
    8000441e:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80004420:	ffffd097          	auipc	ra,0xffffd
    80004424:	e40080e7          	jalr	-448(ra) # 80001260 <myproc>
    80004428:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    8000442a:	8526                	mv	a0,s1
    8000442c:	00002097          	auipc	ra,0x2
    80004430:	580080e7          	jalr	1408(ra) # 800069ac <acquire>
  while(i < n){
    80004434:	0d405163          	blez	s4,800044f6 <pipewrite+0xf6>
    80004438:	8ba6                	mv	s7,s1
  int i = 0;
    8000443a:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    8000443c:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    8000443e:	21848c93          	addi	s9,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80004442:	21c48c13          	addi	s8,s1,540
    80004446:	a08d                	j	800044a8 <pipewrite+0xa8>
      release(&pi->lock);
    80004448:	8526                	mv	a0,s1
    8000444a:	00002097          	auipc	ra,0x2
    8000444e:	616080e7          	jalr	1558(ra) # 80006a60 <release>
      return -1;
    80004452:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80004454:	854a                	mv	a0,s2
    80004456:	70a6                	ld	ra,104(sp)
    80004458:	7406                	ld	s0,96(sp)
    8000445a:	64e6                	ld	s1,88(sp)
    8000445c:	6946                	ld	s2,80(sp)
    8000445e:	69a6                	ld	s3,72(sp)
    80004460:	6a06                	ld	s4,64(sp)
    80004462:	7ae2                	ld	s5,56(sp)
    80004464:	7b42                	ld	s6,48(sp)
    80004466:	7ba2                	ld	s7,40(sp)
    80004468:	7c02                	ld	s8,32(sp)
    8000446a:	6ce2                	ld	s9,24(sp)
    8000446c:	6165                	addi	sp,sp,112
    8000446e:	8082                	ret
      wakeup(&pi->nread);
    80004470:	8566                	mv	a0,s9
    80004472:	ffffd097          	auipc	ra,0xffffd
    80004476:	636080e7          	jalr	1590(ra) # 80001aa8 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    8000447a:	85de                	mv	a1,s7
    8000447c:	8562                	mv	a0,s8
    8000447e:	ffffd097          	auipc	ra,0xffffd
    80004482:	49e080e7          	jalr	1182(ra) # 8000191c <sleep>
    80004486:	a839                	j	800044a4 <pipewrite+0xa4>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80004488:	21c4a783          	lw	a5,540(s1)
    8000448c:	0017871b          	addiw	a4,a5,1
    80004490:	20e4ae23          	sw	a4,540(s1)
    80004494:	1ff7f793          	andi	a5,a5,511
    80004498:	97a6                	add	a5,a5,s1
    8000449a:	f9f44703          	lbu	a4,-97(s0)
    8000449e:	00e78c23          	sb	a4,24(a5)
      i++;
    800044a2:	2905                	addiw	s2,s2,1
  while(i < n){
    800044a4:	03495d63          	bge	s2,s4,800044de <pipewrite+0xde>
    if(pi->readopen == 0 || pr->killed){
    800044a8:	2204a783          	lw	a5,544(s1)
    800044ac:	dfd1                	beqz	a5,80004448 <pipewrite+0x48>
    800044ae:	0289a783          	lw	a5,40(s3)
    800044b2:	fbd9                	bnez	a5,80004448 <pipewrite+0x48>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    800044b4:	2184a783          	lw	a5,536(s1)
    800044b8:	21c4a703          	lw	a4,540(s1)
    800044bc:	2007879b          	addiw	a5,a5,512
    800044c0:	faf708e3          	beq	a4,a5,80004470 <pipewrite+0x70>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    800044c4:	4685                	li	a3,1
    800044c6:	01590633          	add	a2,s2,s5
    800044ca:	f9f40593          	addi	a1,s0,-97
    800044ce:	0509b503          	ld	a0,80(s3)
    800044d2:	ffffc097          	auipc	ra,0xffffc
    800044d6:	6bc080e7          	jalr	1724(ra) # 80000b8e <copyin>
    800044da:	fb6517e3          	bne	a0,s6,80004488 <pipewrite+0x88>
  wakeup(&pi->nread);
    800044de:	21848513          	addi	a0,s1,536
    800044e2:	ffffd097          	auipc	ra,0xffffd
    800044e6:	5c6080e7          	jalr	1478(ra) # 80001aa8 <wakeup>
  release(&pi->lock);
    800044ea:	8526                	mv	a0,s1
    800044ec:	00002097          	auipc	ra,0x2
    800044f0:	574080e7          	jalr	1396(ra) # 80006a60 <release>
  return i;
    800044f4:	b785                	j	80004454 <pipewrite+0x54>
  int i = 0;
    800044f6:	4901                	li	s2,0
    800044f8:	b7dd                	j	800044de <pipewrite+0xde>

00000000800044fa <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    800044fa:	715d                	addi	sp,sp,-80
    800044fc:	e486                	sd	ra,72(sp)
    800044fe:	e0a2                	sd	s0,64(sp)
    80004500:	fc26                	sd	s1,56(sp)
    80004502:	f84a                	sd	s2,48(sp)
    80004504:	f44e                	sd	s3,40(sp)
    80004506:	f052                	sd	s4,32(sp)
    80004508:	ec56                	sd	s5,24(sp)
    8000450a:	e85a                	sd	s6,16(sp)
    8000450c:	0880                	addi	s0,sp,80
    8000450e:	84aa                	mv	s1,a0
    80004510:	892e                	mv	s2,a1
    80004512:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80004514:	ffffd097          	auipc	ra,0xffffd
    80004518:	d4c080e7          	jalr	-692(ra) # 80001260 <myproc>
    8000451c:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    8000451e:	8b26                	mv	s6,s1
    80004520:	8526                	mv	a0,s1
    80004522:	00002097          	auipc	ra,0x2
    80004526:	48a080e7          	jalr	1162(ra) # 800069ac <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    8000452a:	2184a703          	lw	a4,536(s1)
    8000452e:	21c4a783          	lw	a5,540(s1)
    if(pr->killed){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004532:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004536:	02f71463          	bne	a4,a5,8000455e <piperead+0x64>
    8000453a:	2244a783          	lw	a5,548(s1)
    8000453e:	c385                	beqz	a5,8000455e <piperead+0x64>
    if(pr->killed){
    80004540:	028a2783          	lw	a5,40(s4)
    80004544:	ebc1                	bnez	a5,800045d4 <piperead+0xda>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004546:	85da                	mv	a1,s6
    80004548:	854e                	mv	a0,s3
    8000454a:	ffffd097          	auipc	ra,0xffffd
    8000454e:	3d2080e7          	jalr	978(ra) # 8000191c <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004552:	2184a703          	lw	a4,536(s1)
    80004556:	21c4a783          	lw	a5,540(s1)
    8000455a:	fef700e3          	beq	a4,a5,8000453a <piperead+0x40>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000455e:	09505263          	blez	s5,800045e2 <piperead+0xe8>
    80004562:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004564:	5b7d                	li	s6,-1
    if(pi->nread == pi->nwrite)
    80004566:	2184a783          	lw	a5,536(s1)
    8000456a:	21c4a703          	lw	a4,540(s1)
    8000456e:	02f70d63          	beq	a4,a5,800045a8 <piperead+0xae>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80004572:	0017871b          	addiw	a4,a5,1
    80004576:	20e4ac23          	sw	a4,536(s1)
    8000457a:	1ff7f793          	andi	a5,a5,511
    8000457e:	97a6                	add	a5,a5,s1
    80004580:	0187c783          	lbu	a5,24(a5)
    80004584:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004588:	4685                	li	a3,1
    8000458a:	fbf40613          	addi	a2,s0,-65
    8000458e:	85ca                	mv	a1,s2
    80004590:	050a3503          	ld	a0,80(s4)
    80004594:	ffffc097          	auipc	ra,0xffffc
    80004598:	56e080e7          	jalr	1390(ra) # 80000b02 <copyout>
    8000459c:	01650663          	beq	a0,s6,800045a8 <piperead+0xae>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800045a0:	2985                	addiw	s3,s3,1
    800045a2:	0905                	addi	s2,s2,1
    800045a4:	fd3a91e3          	bne	s5,s3,80004566 <piperead+0x6c>
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    800045a8:	21c48513          	addi	a0,s1,540
    800045ac:	ffffd097          	auipc	ra,0xffffd
    800045b0:	4fc080e7          	jalr	1276(ra) # 80001aa8 <wakeup>
  release(&pi->lock);
    800045b4:	8526                	mv	a0,s1
    800045b6:	00002097          	auipc	ra,0x2
    800045ba:	4aa080e7          	jalr	1194(ra) # 80006a60 <release>
  return i;
}
    800045be:	854e                	mv	a0,s3
    800045c0:	60a6                	ld	ra,72(sp)
    800045c2:	6406                	ld	s0,64(sp)
    800045c4:	74e2                	ld	s1,56(sp)
    800045c6:	7942                	ld	s2,48(sp)
    800045c8:	79a2                	ld	s3,40(sp)
    800045ca:	7a02                	ld	s4,32(sp)
    800045cc:	6ae2                	ld	s5,24(sp)
    800045ce:	6b42                	ld	s6,16(sp)
    800045d0:	6161                	addi	sp,sp,80
    800045d2:	8082                	ret
      release(&pi->lock);
    800045d4:	8526                	mv	a0,s1
    800045d6:	00002097          	auipc	ra,0x2
    800045da:	48a080e7          	jalr	1162(ra) # 80006a60 <release>
      return -1;
    800045de:	59fd                	li	s3,-1
    800045e0:	bff9                	j	800045be <piperead+0xc4>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800045e2:	4981                	li	s3,0
    800045e4:	b7d1                	j	800045a8 <piperead+0xae>

00000000800045e6 <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    800045e6:	df010113          	addi	sp,sp,-528
    800045ea:	20113423          	sd	ra,520(sp)
    800045ee:	20813023          	sd	s0,512(sp)
    800045f2:	ffa6                	sd	s1,504(sp)
    800045f4:	fbca                	sd	s2,496(sp)
    800045f6:	f7ce                	sd	s3,488(sp)
    800045f8:	f3d2                	sd	s4,480(sp)
    800045fa:	efd6                	sd	s5,472(sp)
    800045fc:	ebda                	sd	s6,464(sp)
    800045fe:	e7de                	sd	s7,456(sp)
    80004600:	e3e2                	sd	s8,448(sp)
    80004602:	ff66                	sd	s9,440(sp)
    80004604:	fb6a                	sd	s10,432(sp)
    80004606:	f76e                	sd	s11,424(sp)
    80004608:	0c00                	addi	s0,sp,528
    8000460a:	84aa                	mv	s1,a0
    8000460c:	dea43c23          	sd	a0,-520(s0)
    80004610:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80004614:	ffffd097          	auipc	ra,0xffffd
    80004618:	c4c080e7          	jalr	-948(ra) # 80001260 <myproc>
    8000461c:	892a                	mv	s2,a0

  begin_op();
    8000461e:	fffff097          	auipc	ra,0xfffff
    80004622:	49c080e7          	jalr	1180(ra) # 80003aba <begin_op>

  if((ip = namei(path)) == 0){
    80004626:	8526                	mv	a0,s1
    80004628:	fffff097          	auipc	ra,0xfffff
    8000462c:	0e4080e7          	jalr	228(ra) # 8000370c <namei>
    80004630:	c92d                	beqz	a0,800046a2 <exec+0xbc>
    80004632:	84aa                	mv	s1,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80004634:	fffff097          	auipc	ra,0xfffff
    80004638:	92c080e7          	jalr	-1748(ra) # 80002f60 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    8000463c:	04000713          	li	a4,64
    80004640:	4681                	li	a3,0
    80004642:	e5040613          	addi	a2,s0,-432
    80004646:	4581                	li	a1,0
    80004648:	8526                	mv	a0,s1
    8000464a:	fffff097          	auipc	ra,0xfffff
    8000464e:	bca080e7          	jalr	-1078(ra) # 80003214 <readi>
    80004652:	04000793          	li	a5,64
    80004656:	00f51a63          	bne	a0,a5,8000466a <exec+0x84>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    8000465a:	e5042703          	lw	a4,-432(s0)
    8000465e:	464c47b7          	lui	a5,0x464c4
    80004662:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80004666:	04f70463          	beq	a4,a5,800046ae <exec+0xc8>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    8000466a:	8526                	mv	a0,s1
    8000466c:	fffff097          	auipc	ra,0xfffff
    80004670:	b56080e7          	jalr	-1194(ra) # 800031c2 <iunlockput>
    end_op();
    80004674:	fffff097          	auipc	ra,0xfffff
    80004678:	4c6080e7          	jalr	1222(ra) # 80003b3a <end_op>
  }
  return -1;
    8000467c:	557d                	li	a0,-1
}
    8000467e:	20813083          	ld	ra,520(sp)
    80004682:	20013403          	ld	s0,512(sp)
    80004686:	74fe                	ld	s1,504(sp)
    80004688:	795e                	ld	s2,496(sp)
    8000468a:	79be                	ld	s3,488(sp)
    8000468c:	7a1e                	ld	s4,480(sp)
    8000468e:	6afe                	ld	s5,472(sp)
    80004690:	6b5e                	ld	s6,464(sp)
    80004692:	6bbe                	ld	s7,456(sp)
    80004694:	6c1e                	ld	s8,448(sp)
    80004696:	7cfa                	ld	s9,440(sp)
    80004698:	7d5a                	ld	s10,432(sp)
    8000469a:	7dba                	ld	s11,424(sp)
    8000469c:	21010113          	addi	sp,sp,528
    800046a0:	8082                	ret
    end_op();
    800046a2:	fffff097          	auipc	ra,0xfffff
    800046a6:	498080e7          	jalr	1176(ra) # 80003b3a <end_op>
    return -1;
    800046aa:	557d                	li	a0,-1
    800046ac:	bfc9                	j	8000467e <exec+0x98>
  if((pagetable = proc_pagetable(p)) == 0)
    800046ae:	854a                	mv	a0,s2
    800046b0:	ffffd097          	auipc	ra,0xffffd
    800046b4:	c74080e7          	jalr	-908(ra) # 80001324 <proc_pagetable>
    800046b8:	8baa                	mv	s7,a0
    800046ba:	d945                	beqz	a0,8000466a <exec+0x84>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800046bc:	e7042983          	lw	s3,-400(s0)
    800046c0:	e8845783          	lhu	a5,-376(s0)
    800046c4:	c7ad                	beqz	a5,8000472e <exec+0x148>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    800046c6:	4901                	li	s2,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800046c8:	4b01                	li	s6,0
    if((ph.vaddr % PGSIZE) != 0)
    800046ca:	6c85                	lui	s9,0x1
    800046cc:	fffc8793          	addi	a5,s9,-1 # fff <_entry-0x7ffff001>
    800046d0:	def43823          	sd	a5,-528(s0)
    800046d4:	a42d                	j	800048fe <exec+0x318>
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    800046d6:	00004517          	auipc	a0,0x4
    800046da:	12250513          	addi	a0,a0,290 # 800087f8 <syscalls+0x378>
    800046de:	00002097          	auipc	ra,0x2
    800046e2:	d84080e7          	jalr	-636(ra) # 80006462 <panic>
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    800046e6:	8756                	mv	a4,s5
    800046e8:	012d86bb          	addw	a3,s11,s2
    800046ec:	4581                	li	a1,0
    800046ee:	8526                	mv	a0,s1
    800046f0:	fffff097          	auipc	ra,0xfffff
    800046f4:	b24080e7          	jalr	-1244(ra) # 80003214 <readi>
    800046f8:	2501                	sext.w	a0,a0
    800046fa:	1aaa9963          	bne	s5,a0,800048ac <exec+0x2c6>
  for(i = 0; i < sz; i += PGSIZE){
    800046fe:	6785                	lui	a5,0x1
    80004700:	0127893b          	addw	s2,a5,s2
    80004704:	77fd                	lui	a5,0xfffff
    80004706:	01478a3b          	addw	s4,a5,s4
    8000470a:	1f897163          	bgeu	s2,s8,800048ec <exec+0x306>
    pa = walkaddr(pagetable, va + i);
    8000470e:	02091593          	slli	a1,s2,0x20
    80004712:	9181                	srli	a1,a1,0x20
    80004714:	95ea                	add	a1,a1,s10
    80004716:	855e                	mv	a0,s7
    80004718:	ffffc097          	auipc	ra,0xffffc
    8000471c:	dee080e7          	jalr	-530(ra) # 80000506 <walkaddr>
    80004720:	862a                	mv	a2,a0
    if(pa == 0)
    80004722:	d955                	beqz	a0,800046d6 <exec+0xf0>
      n = PGSIZE;
    80004724:	8ae6                	mv	s5,s9
    if(sz - i < PGSIZE)
    80004726:	fd9a70e3          	bgeu	s4,s9,800046e6 <exec+0x100>
      n = sz - i;
    8000472a:	8ad2                	mv	s5,s4
    8000472c:	bf6d                	j	800046e6 <exec+0x100>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    8000472e:	4901                	li	s2,0
  iunlockput(ip);
    80004730:	8526                	mv	a0,s1
    80004732:	fffff097          	auipc	ra,0xfffff
    80004736:	a90080e7          	jalr	-1392(ra) # 800031c2 <iunlockput>
  end_op();
    8000473a:	fffff097          	auipc	ra,0xfffff
    8000473e:	400080e7          	jalr	1024(ra) # 80003b3a <end_op>
  p = myproc();
    80004742:	ffffd097          	auipc	ra,0xffffd
    80004746:	b1e080e7          	jalr	-1250(ra) # 80001260 <myproc>
    8000474a:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    8000474c:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    80004750:	6785                	lui	a5,0x1
    80004752:	17fd                	addi	a5,a5,-1
    80004754:	993e                	add	s2,s2,a5
    80004756:	757d                	lui	a0,0xfffff
    80004758:	00a977b3          	and	a5,s2,a0
    8000475c:	e0f43423          	sd	a5,-504(s0)
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80004760:	6609                	lui	a2,0x2
    80004762:	963e                	add	a2,a2,a5
    80004764:	85be                	mv	a1,a5
    80004766:	855e                	mv	a0,s7
    80004768:	ffffc097          	auipc	ra,0xffffc
    8000476c:	14a080e7          	jalr	330(ra) # 800008b2 <uvmalloc>
    80004770:	8b2a                	mv	s6,a0
  ip = 0;
    80004772:	4481                	li	s1,0
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80004774:	12050c63          	beqz	a0,800048ac <exec+0x2c6>
  uvmclear(pagetable, sz-2*PGSIZE);
    80004778:	75f9                	lui	a1,0xffffe
    8000477a:	95aa                	add	a1,a1,a0
    8000477c:	855e                	mv	a0,s7
    8000477e:	ffffc097          	auipc	ra,0xffffc
    80004782:	352080e7          	jalr	850(ra) # 80000ad0 <uvmclear>
  stackbase = sp - PGSIZE;
    80004786:	7c7d                	lui	s8,0xfffff
    80004788:	9c5a                	add	s8,s8,s6
  for(argc = 0; argv[argc]; argc++) {
    8000478a:	e0043783          	ld	a5,-512(s0)
    8000478e:	6388                	ld	a0,0(a5)
    80004790:	c535                	beqz	a0,800047fc <exec+0x216>
    80004792:	e9040993          	addi	s3,s0,-368
    80004796:	f9040c93          	addi	s9,s0,-112
  sp = sz;
    8000479a:	895a                	mv	s2,s6
    sp -= strlen(argv[argc]) + 1;
    8000479c:	ffffc097          	auipc	ra,0xffffc
    800047a0:	b60080e7          	jalr	-1184(ra) # 800002fc <strlen>
    800047a4:	2505                	addiw	a0,a0,1
    800047a6:	40a90933          	sub	s2,s2,a0
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    800047aa:	ff097913          	andi	s2,s2,-16
    if(sp < stackbase)
    800047ae:	13896363          	bltu	s2,s8,800048d4 <exec+0x2ee>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    800047b2:	e0043d83          	ld	s11,-512(s0)
    800047b6:	000dba03          	ld	s4,0(s11)
    800047ba:	8552                	mv	a0,s4
    800047bc:	ffffc097          	auipc	ra,0xffffc
    800047c0:	b40080e7          	jalr	-1216(ra) # 800002fc <strlen>
    800047c4:	0015069b          	addiw	a3,a0,1
    800047c8:	8652                	mv	a2,s4
    800047ca:	85ca                	mv	a1,s2
    800047cc:	855e                	mv	a0,s7
    800047ce:	ffffc097          	auipc	ra,0xffffc
    800047d2:	334080e7          	jalr	820(ra) # 80000b02 <copyout>
    800047d6:	10054363          	bltz	a0,800048dc <exec+0x2f6>
    ustack[argc] = sp;
    800047da:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    800047de:	0485                	addi	s1,s1,1
    800047e0:	008d8793          	addi	a5,s11,8
    800047e4:	e0f43023          	sd	a5,-512(s0)
    800047e8:	008db503          	ld	a0,8(s11)
    800047ec:	c911                	beqz	a0,80004800 <exec+0x21a>
    if(argc >= MAXARG)
    800047ee:	09a1                	addi	s3,s3,8
    800047f0:	fb3c96e3          	bne	s9,s3,8000479c <exec+0x1b6>
  sz = sz1;
    800047f4:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800047f8:	4481                	li	s1,0
    800047fa:	a84d                	j	800048ac <exec+0x2c6>
  sp = sz;
    800047fc:	895a                	mv	s2,s6
  for(argc = 0; argv[argc]; argc++) {
    800047fe:	4481                	li	s1,0
  ustack[argc] = 0;
    80004800:	00349793          	slli	a5,s1,0x3
    80004804:	f9040713          	addi	a4,s0,-112
    80004808:	97ba                	add	a5,a5,a4
    8000480a:	f007b023          	sd	zero,-256(a5) # f00 <_entry-0x7ffff100>
  sp -= (argc+1) * sizeof(uint64);
    8000480e:	00148693          	addi	a3,s1,1
    80004812:	068e                	slli	a3,a3,0x3
    80004814:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80004818:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    8000481c:	01897663          	bgeu	s2,s8,80004828 <exec+0x242>
  sz = sz1;
    80004820:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    80004824:	4481                	li	s1,0
    80004826:	a059                	j	800048ac <exec+0x2c6>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80004828:	e9040613          	addi	a2,s0,-368
    8000482c:	85ca                	mv	a1,s2
    8000482e:	855e                	mv	a0,s7
    80004830:	ffffc097          	auipc	ra,0xffffc
    80004834:	2d2080e7          	jalr	722(ra) # 80000b02 <copyout>
    80004838:	0a054663          	bltz	a0,800048e4 <exec+0x2fe>
  p->trapframe->a1 = sp;
    8000483c:	058ab783          	ld	a5,88(s5)
    80004840:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    80004844:	df843783          	ld	a5,-520(s0)
    80004848:	0007c703          	lbu	a4,0(a5)
    8000484c:	cf11                	beqz	a4,80004868 <exec+0x282>
    8000484e:	0785                	addi	a5,a5,1
    if(*s == '/')
    80004850:	02f00693          	li	a3,47
    80004854:	a039                	j	80004862 <exec+0x27c>
      last = s+1;
    80004856:	def43c23          	sd	a5,-520(s0)
  for(last=s=path; *s; s++)
    8000485a:	0785                	addi	a5,a5,1
    8000485c:	fff7c703          	lbu	a4,-1(a5)
    80004860:	c701                	beqz	a4,80004868 <exec+0x282>
    if(*s == '/')
    80004862:	fed71ce3          	bne	a4,a3,8000485a <exec+0x274>
    80004866:	bfc5                	j	80004856 <exec+0x270>
  safestrcpy(p->name, last, sizeof(p->name));
    80004868:	4641                	li	a2,16
    8000486a:	df843583          	ld	a1,-520(s0)
    8000486e:	158a8513          	addi	a0,s5,344
    80004872:	ffffc097          	auipc	ra,0xffffc
    80004876:	a58080e7          	jalr	-1448(ra) # 800002ca <safestrcpy>
  oldpagetable = p->pagetable;
    8000487a:	050ab503          	ld	a0,80(s5)
  p->pagetable = pagetable;
    8000487e:	057ab823          	sd	s7,80(s5)
  p->sz = sz;
    80004882:	056ab423          	sd	s6,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80004886:	058ab783          	ld	a5,88(s5)
    8000488a:	e6843703          	ld	a4,-408(s0)
    8000488e:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80004890:	058ab783          	ld	a5,88(s5)
    80004894:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80004898:	85ea                	mv	a1,s10
    8000489a:	ffffd097          	auipc	ra,0xffffd
    8000489e:	b26080e7          	jalr	-1242(ra) # 800013c0 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    800048a2:	0004851b          	sext.w	a0,s1
    800048a6:	bbe1                	j	8000467e <exec+0x98>
    800048a8:	e1243423          	sd	s2,-504(s0)
    proc_freepagetable(pagetable, sz);
    800048ac:	e0843583          	ld	a1,-504(s0)
    800048b0:	855e                	mv	a0,s7
    800048b2:	ffffd097          	auipc	ra,0xffffd
    800048b6:	b0e080e7          	jalr	-1266(ra) # 800013c0 <proc_freepagetable>
  if(ip){
    800048ba:	da0498e3          	bnez	s1,8000466a <exec+0x84>
  return -1;
    800048be:	557d                	li	a0,-1
    800048c0:	bb7d                	j	8000467e <exec+0x98>
    800048c2:	e1243423          	sd	s2,-504(s0)
    800048c6:	b7dd                	j	800048ac <exec+0x2c6>
    800048c8:	e1243423          	sd	s2,-504(s0)
    800048cc:	b7c5                	j	800048ac <exec+0x2c6>
    800048ce:	e1243423          	sd	s2,-504(s0)
    800048d2:	bfe9                	j	800048ac <exec+0x2c6>
  sz = sz1;
    800048d4:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800048d8:	4481                	li	s1,0
    800048da:	bfc9                	j	800048ac <exec+0x2c6>
  sz = sz1;
    800048dc:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800048e0:	4481                	li	s1,0
    800048e2:	b7e9                	j	800048ac <exec+0x2c6>
  sz = sz1;
    800048e4:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800048e8:	4481                	li	s1,0
    800048ea:	b7c9                	j	800048ac <exec+0x2c6>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    800048ec:	e0843903          	ld	s2,-504(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800048f0:	2b05                	addiw	s6,s6,1
    800048f2:	0389899b          	addiw	s3,s3,56
    800048f6:	e8845783          	lhu	a5,-376(s0)
    800048fa:	e2fb5be3          	bge	s6,a5,80004730 <exec+0x14a>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    800048fe:	2981                	sext.w	s3,s3
    80004900:	03800713          	li	a4,56
    80004904:	86ce                	mv	a3,s3
    80004906:	e1840613          	addi	a2,s0,-488
    8000490a:	4581                	li	a1,0
    8000490c:	8526                	mv	a0,s1
    8000490e:	fffff097          	auipc	ra,0xfffff
    80004912:	906080e7          	jalr	-1786(ra) # 80003214 <readi>
    80004916:	03800793          	li	a5,56
    8000491a:	f8f517e3          	bne	a0,a5,800048a8 <exec+0x2c2>
    if(ph.type != ELF_PROG_LOAD)
    8000491e:	e1842783          	lw	a5,-488(s0)
    80004922:	4705                	li	a4,1
    80004924:	fce796e3          	bne	a5,a4,800048f0 <exec+0x30a>
    if(ph.memsz < ph.filesz)
    80004928:	e4043603          	ld	a2,-448(s0)
    8000492c:	e3843783          	ld	a5,-456(s0)
    80004930:	f8f669e3          	bltu	a2,a5,800048c2 <exec+0x2dc>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80004934:	e2843783          	ld	a5,-472(s0)
    80004938:	963e                	add	a2,a2,a5
    8000493a:	f8f667e3          	bltu	a2,a5,800048c8 <exec+0x2e2>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    8000493e:	85ca                	mv	a1,s2
    80004940:	855e                	mv	a0,s7
    80004942:	ffffc097          	auipc	ra,0xffffc
    80004946:	f70080e7          	jalr	-144(ra) # 800008b2 <uvmalloc>
    8000494a:	e0a43423          	sd	a0,-504(s0)
    8000494e:	d141                	beqz	a0,800048ce <exec+0x2e8>
    if((ph.vaddr % PGSIZE) != 0)
    80004950:	e2843d03          	ld	s10,-472(s0)
    80004954:	df043783          	ld	a5,-528(s0)
    80004958:	00fd77b3          	and	a5,s10,a5
    8000495c:	fba1                	bnez	a5,800048ac <exec+0x2c6>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    8000495e:	e2042d83          	lw	s11,-480(s0)
    80004962:	e3842c03          	lw	s8,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80004966:	f80c03e3          	beqz	s8,800048ec <exec+0x306>
    8000496a:	8a62                	mv	s4,s8
    8000496c:	4901                	li	s2,0
    8000496e:	b345                	j	8000470e <exec+0x128>

0000000080004970 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80004970:	7179                	addi	sp,sp,-48
    80004972:	f406                	sd	ra,40(sp)
    80004974:	f022                	sd	s0,32(sp)
    80004976:	ec26                	sd	s1,24(sp)
    80004978:	e84a                	sd	s2,16(sp)
    8000497a:	1800                	addi	s0,sp,48
    8000497c:	892e                	mv	s2,a1
    8000497e:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    80004980:	fdc40593          	addi	a1,s0,-36
    80004984:	ffffe097          	auipc	ra,0xffffe
    80004988:	9a0080e7          	jalr	-1632(ra) # 80002324 <argint>
    8000498c:	04054063          	bltz	a0,800049cc <argfd+0x5c>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80004990:	fdc42703          	lw	a4,-36(s0)
    80004994:	47bd                	li	a5,15
    80004996:	02e7ed63          	bltu	a5,a4,800049d0 <argfd+0x60>
    8000499a:	ffffd097          	auipc	ra,0xffffd
    8000499e:	8c6080e7          	jalr	-1850(ra) # 80001260 <myproc>
    800049a2:	fdc42703          	lw	a4,-36(s0)
    800049a6:	01a70793          	addi	a5,a4,26
    800049aa:	078e                	slli	a5,a5,0x3
    800049ac:	953e                	add	a0,a0,a5
    800049ae:	611c                	ld	a5,0(a0)
    800049b0:	c395                	beqz	a5,800049d4 <argfd+0x64>
    return -1;
  if(pfd)
    800049b2:	00090463          	beqz	s2,800049ba <argfd+0x4a>
    *pfd = fd;
    800049b6:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    800049ba:	4501                	li	a0,0
  if(pf)
    800049bc:	c091                	beqz	s1,800049c0 <argfd+0x50>
    *pf = f;
    800049be:	e09c                	sd	a5,0(s1)
}
    800049c0:	70a2                	ld	ra,40(sp)
    800049c2:	7402                	ld	s0,32(sp)
    800049c4:	64e2                	ld	s1,24(sp)
    800049c6:	6942                	ld	s2,16(sp)
    800049c8:	6145                	addi	sp,sp,48
    800049ca:	8082                	ret
    return -1;
    800049cc:	557d                	li	a0,-1
    800049ce:	bfcd                	j	800049c0 <argfd+0x50>
    return -1;
    800049d0:	557d                	li	a0,-1
    800049d2:	b7fd                	j	800049c0 <argfd+0x50>
    800049d4:	557d                	li	a0,-1
    800049d6:	b7ed                	j	800049c0 <argfd+0x50>

00000000800049d8 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    800049d8:	1101                	addi	sp,sp,-32
    800049da:	ec06                	sd	ra,24(sp)
    800049dc:	e822                	sd	s0,16(sp)
    800049de:	e426                	sd	s1,8(sp)
    800049e0:	1000                	addi	s0,sp,32
    800049e2:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    800049e4:	ffffd097          	auipc	ra,0xffffd
    800049e8:	87c080e7          	jalr	-1924(ra) # 80001260 <myproc>
    800049ec:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    800049ee:	0d050793          	addi	a5,a0,208 # fffffffffffff0d0 <end+0xffffffff7ffd8e90>
    800049f2:	4501                	li	a0,0
    800049f4:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    800049f6:	6398                	ld	a4,0(a5)
    800049f8:	cb19                	beqz	a4,80004a0e <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    800049fa:	2505                	addiw	a0,a0,1
    800049fc:	07a1                	addi	a5,a5,8
    800049fe:	fed51ce3          	bne	a0,a3,800049f6 <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80004a02:	557d                	li	a0,-1
}
    80004a04:	60e2                	ld	ra,24(sp)
    80004a06:	6442                	ld	s0,16(sp)
    80004a08:	64a2                	ld	s1,8(sp)
    80004a0a:	6105                	addi	sp,sp,32
    80004a0c:	8082                	ret
      p->ofile[fd] = f;
    80004a0e:	01a50793          	addi	a5,a0,26
    80004a12:	078e                	slli	a5,a5,0x3
    80004a14:	963e                	add	a2,a2,a5
    80004a16:	e204                	sd	s1,0(a2)
      return fd;
    80004a18:	b7f5                	j	80004a04 <fdalloc+0x2c>

0000000080004a1a <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    80004a1a:	715d                	addi	sp,sp,-80
    80004a1c:	e486                	sd	ra,72(sp)
    80004a1e:	e0a2                	sd	s0,64(sp)
    80004a20:	fc26                	sd	s1,56(sp)
    80004a22:	f84a                	sd	s2,48(sp)
    80004a24:	f44e                	sd	s3,40(sp)
    80004a26:	f052                	sd	s4,32(sp)
    80004a28:	ec56                	sd	s5,24(sp)
    80004a2a:	0880                	addi	s0,sp,80
    80004a2c:	89ae                	mv	s3,a1
    80004a2e:	8ab2                	mv	s5,a2
    80004a30:	8a36                	mv	s4,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80004a32:	fb040593          	addi	a1,s0,-80
    80004a36:	fffff097          	auipc	ra,0xfffff
    80004a3a:	cf4080e7          	jalr	-780(ra) # 8000372a <nameiparent>
    80004a3e:	892a                	mv	s2,a0
    80004a40:	12050f63          	beqz	a0,80004b7e <create+0x164>
    return 0;

  ilock(dp);
    80004a44:	ffffe097          	auipc	ra,0xffffe
    80004a48:	51c080e7          	jalr	1308(ra) # 80002f60 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80004a4c:	4601                	li	a2,0
    80004a4e:	fb040593          	addi	a1,s0,-80
    80004a52:	854a                	mv	a0,s2
    80004a54:	fffff097          	auipc	ra,0xfffff
    80004a58:	9e6080e7          	jalr	-1562(ra) # 8000343a <dirlookup>
    80004a5c:	84aa                	mv	s1,a0
    80004a5e:	c921                	beqz	a0,80004aae <create+0x94>
    iunlockput(dp);
    80004a60:	854a                	mv	a0,s2
    80004a62:	ffffe097          	auipc	ra,0xffffe
    80004a66:	760080e7          	jalr	1888(ra) # 800031c2 <iunlockput>
    ilock(ip);
    80004a6a:	8526                	mv	a0,s1
    80004a6c:	ffffe097          	auipc	ra,0xffffe
    80004a70:	4f4080e7          	jalr	1268(ra) # 80002f60 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80004a74:	2981                	sext.w	s3,s3
    80004a76:	4789                	li	a5,2
    80004a78:	02f99463          	bne	s3,a5,80004aa0 <create+0x86>
    80004a7c:	0444d783          	lhu	a5,68(s1)
    80004a80:	37f9                	addiw	a5,a5,-2
    80004a82:	17c2                	slli	a5,a5,0x30
    80004a84:	93c1                	srli	a5,a5,0x30
    80004a86:	4705                	li	a4,1
    80004a88:	00f76c63          	bltu	a4,a5,80004aa0 <create+0x86>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
    80004a8c:	8526                	mv	a0,s1
    80004a8e:	60a6                	ld	ra,72(sp)
    80004a90:	6406                	ld	s0,64(sp)
    80004a92:	74e2                	ld	s1,56(sp)
    80004a94:	7942                	ld	s2,48(sp)
    80004a96:	79a2                	ld	s3,40(sp)
    80004a98:	7a02                	ld	s4,32(sp)
    80004a9a:	6ae2                	ld	s5,24(sp)
    80004a9c:	6161                	addi	sp,sp,80
    80004a9e:	8082                	ret
    iunlockput(ip);
    80004aa0:	8526                	mv	a0,s1
    80004aa2:	ffffe097          	auipc	ra,0xffffe
    80004aa6:	720080e7          	jalr	1824(ra) # 800031c2 <iunlockput>
    return 0;
    80004aaa:	4481                	li	s1,0
    80004aac:	b7c5                	j	80004a8c <create+0x72>
  if((ip = ialloc(dp->dev, type)) == 0)
    80004aae:	85ce                	mv	a1,s3
    80004ab0:	00092503          	lw	a0,0(s2)
    80004ab4:	ffffe097          	auipc	ra,0xffffe
    80004ab8:	326080e7          	jalr	806(ra) # 80002dda <ialloc>
    80004abc:	84aa                	mv	s1,a0
    80004abe:	c529                	beqz	a0,80004b08 <create+0xee>
  ilock(ip);
    80004ac0:	ffffe097          	auipc	ra,0xffffe
    80004ac4:	4a0080e7          	jalr	1184(ra) # 80002f60 <ilock>
  ip->major = major;
    80004ac8:	05549323          	sh	s5,70(s1)
  ip->minor = minor;
    80004acc:	05449423          	sh	s4,72(s1)
  ip->nlink = 1;
    80004ad0:	4785                	li	a5,1
    80004ad2:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004ad6:	8526                	mv	a0,s1
    80004ad8:	ffffe097          	auipc	ra,0xffffe
    80004adc:	3c6080e7          	jalr	966(ra) # 80002e9e <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    80004ae0:	2981                	sext.w	s3,s3
    80004ae2:	4785                	li	a5,1
    80004ae4:	02f98a63          	beq	s3,a5,80004b18 <create+0xfe>
  if(dirlink(dp, name, ip->inum) < 0)
    80004ae8:	40d0                	lw	a2,4(s1)
    80004aea:	fb040593          	addi	a1,s0,-80
    80004aee:	854a                	mv	a0,s2
    80004af0:	fffff097          	auipc	ra,0xfffff
    80004af4:	b5a080e7          	jalr	-1190(ra) # 8000364a <dirlink>
    80004af8:	06054b63          	bltz	a0,80004b6e <create+0x154>
  iunlockput(dp);
    80004afc:	854a                	mv	a0,s2
    80004afe:	ffffe097          	auipc	ra,0xffffe
    80004b02:	6c4080e7          	jalr	1732(ra) # 800031c2 <iunlockput>
  return ip;
    80004b06:	b759                	j	80004a8c <create+0x72>
    panic("create: ialloc");
    80004b08:	00004517          	auipc	a0,0x4
    80004b0c:	d1050513          	addi	a0,a0,-752 # 80008818 <syscalls+0x398>
    80004b10:	00002097          	auipc	ra,0x2
    80004b14:	952080e7          	jalr	-1710(ra) # 80006462 <panic>
    dp->nlink++;  // for ".."
    80004b18:	04a95783          	lhu	a5,74(s2)
    80004b1c:	2785                	addiw	a5,a5,1
    80004b1e:	04f91523          	sh	a5,74(s2)
    iupdate(dp);
    80004b22:	854a                	mv	a0,s2
    80004b24:	ffffe097          	auipc	ra,0xffffe
    80004b28:	37a080e7          	jalr	890(ra) # 80002e9e <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80004b2c:	40d0                	lw	a2,4(s1)
    80004b2e:	00004597          	auipc	a1,0x4
    80004b32:	cfa58593          	addi	a1,a1,-774 # 80008828 <syscalls+0x3a8>
    80004b36:	8526                	mv	a0,s1
    80004b38:	fffff097          	auipc	ra,0xfffff
    80004b3c:	b12080e7          	jalr	-1262(ra) # 8000364a <dirlink>
    80004b40:	00054f63          	bltz	a0,80004b5e <create+0x144>
    80004b44:	00492603          	lw	a2,4(s2)
    80004b48:	00004597          	auipc	a1,0x4
    80004b4c:	ce858593          	addi	a1,a1,-792 # 80008830 <syscalls+0x3b0>
    80004b50:	8526                	mv	a0,s1
    80004b52:	fffff097          	auipc	ra,0xfffff
    80004b56:	af8080e7          	jalr	-1288(ra) # 8000364a <dirlink>
    80004b5a:	f80557e3          	bgez	a0,80004ae8 <create+0xce>
      panic("create dots");
    80004b5e:	00004517          	auipc	a0,0x4
    80004b62:	cda50513          	addi	a0,a0,-806 # 80008838 <syscalls+0x3b8>
    80004b66:	00002097          	auipc	ra,0x2
    80004b6a:	8fc080e7          	jalr	-1796(ra) # 80006462 <panic>
    panic("create: dirlink");
    80004b6e:	00004517          	auipc	a0,0x4
    80004b72:	cda50513          	addi	a0,a0,-806 # 80008848 <syscalls+0x3c8>
    80004b76:	00002097          	auipc	ra,0x2
    80004b7a:	8ec080e7          	jalr	-1812(ra) # 80006462 <panic>
    return 0;
    80004b7e:	84aa                	mv	s1,a0
    80004b80:	b731                	j	80004a8c <create+0x72>

0000000080004b82 <sys_dup>:
{
    80004b82:	7179                	addi	sp,sp,-48
    80004b84:	f406                	sd	ra,40(sp)
    80004b86:	f022                	sd	s0,32(sp)
    80004b88:	ec26                	sd	s1,24(sp)
    80004b8a:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80004b8c:	fd840613          	addi	a2,s0,-40
    80004b90:	4581                	li	a1,0
    80004b92:	4501                	li	a0,0
    80004b94:	00000097          	auipc	ra,0x0
    80004b98:	ddc080e7          	jalr	-548(ra) # 80004970 <argfd>
    return -1;
    80004b9c:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    80004b9e:	02054363          	bltz	a0,80004bc4 <sys_dup+0x42>
  if((fd=fdalloc(f)) < 0)
    80004ba2:	fd843503          	ld	a0,-40(s0)
    80004ba6:	00000097          	auipc	ra,0x0
    80004baa:	e32080e7          	jalr	-462(ra) # 800049d8 <fdalloc>
    80004bae:	84aa                	mv	s1,a0
    return -1;
    80004bb0:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    80004bb2:	00054963          	bltz	a0,80004bc4 <sys_dup+0x42>
  filedup(f);
    80004bb6:	fd843503          	ld	a0,-40(s0)
    80004bba:	fffff097          	auipc	ra,0xfffff
    80004bbe:	37a080e7          	jalr	890(ra) # 80003f34 <filedup>
  return fd;
    80004bc2:	87a6                	mv	a5,s1
}
    80004bc4:	853e                	mv	a0,a5
    80004bc6:	70a2                	ld	ra,40(sp)
    80004bc8:	7402                	ld	s0,32(sp)
    80004bca:	64e2                	ld	s1,24(sp)
    80004bcc:	6145                	addi	sp,sp,48
    80004bce:	8082                	ret

0000000080004bd0 <sys_read>:
{
    80004bd0:	7179                	addi	sp,sp,-48
    80004bd2:	f406                	sd	ra,40(sp)
    80004bd4:	f022                	sd	s0,32(sp)
    80004bd6:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004bd8:	fe840613          	addi	a2,s0,-24
    80004bdc:	4581                	li	a1,0
    80004bde:	4501                	li	a0,0
    80004be0:	00000097          	auipc	ra,0x0
    80004be4:	d90080e7          	jalr	-624(ra) # 80004970 <argfd>
    return -1;
    80004be8:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004bea:	04054163          	bltz	a0,80004c2c <sys_read+0x5c>
    80004bee:	fe440593          	addi	a1,s0,-28
    80004bf2:	4509                	li	a0,2
    80004bf4:	ffffd097          	auipc	ra,0xffffd
    80004bf8:	730080e7          	jalr	1840(ra) # 80002324 <argint>
    return -1;
    80004bfc:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004bfe:	02054763          	bltz	a0,80004c2c <sys_read+0x5c>
    80004c02:	fd840593          	addi	a1,s0,-40
    80004c06:	4505                	li	a0,1
    80004c08:	ffffd097          	auipc	ra,0xffffd
    80004c0c:	73e080e7          	jalr	1854(ra) # 80002346 <argaddr>
    return -1;
    80004c10:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004c12:	00054d63          	bltz	a0,80004c2c <sys_read+0x5c>
  return fileread(f, p, n);
    80004c16:	fe442603          	lw	a2,-28(s0)
    80004c1a:	fd843583          	ld	a1,-40(s0)
    80004c1e:	fe843503          	ld	a0,-24(s0)
    80004c22:	fffff097          	auipc	ra,0xfffff
    80004c26:	49e080e7          	jalr	1182(ra) # 800040c0 <fileread>
    80004c2a:	87aa                	mv	a5,a0
}
    80004c2c:	853e                	mv	a0,a5
    80004c2e:	70a2                	ld	ra,40(sp)
    80004c30:	7402                	ld	s0,32(sp)
    80004c32:	6145                	addi	sp,sp,48
    80004c34:	8082                	ret

0000000080004c36 <sys_write>:
{
    80004c36:	7179                	addi	sp,sp,-48
    80004c38:	f406                	sd	ra,40(sp)
    80004c3a:	f022                	sd	s0,32(sp)
    80004c3c:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004c3e:	fe840613          	addi	a2,s0,-24
    80004c42:	4581                	li	a1,0
    80004c44:	4501                	li	a0,0
    80004c46:	00000097          	auipc	ra,0x0
    80004c4a:	d2a080e7          	jalr	-726(ra) # 80004970 <argfd>
    return -1;
    80004c4e:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004c50:	04054163          	bltz	a0,80004c92 <sys_write+0x5c>
    80004c54:	fe440593          	addi	a1,s0,-28
    80004c58:	4509                	li	a0,2
    80004c5a:	ffffd097          	auipc	ra,0xffffd
    80004c5e:	6ca080e7          	jalr	1738(ra) # 80002324 <argint>
    return -1;
    80004c62:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004c64:	02054763          	bltz	a0,80004c92 <sys_write+0x5c>
    80004c68:	fd840593          	addi	a1,s0,-40
    80004c6c:	4505                	li	a0,1
    80004c6e:	ffffd097          	auipc	ra,0xffffd
    80004c72:	6d8080e7          	jalr	1752(ra) # 80002346 <argaddr>
    return -1;
    80004c76:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004c78:	00054d63          	bltz	a0,80004c92 <sys_write+0x5c>
  return filewrite(f, p, n);
    80004c7c:	fe442603          	lw	a2,-28(s0)
    80004c80:	fd843583          	ld	a1,-40(s0)
    80004c84:	fe843503          	ld	a0,-24(s0)
    80004c88:	fffff097          	auipc	ra,0xfffff
    80004c8c:	4fa080e7          	jalr	1274(ra) # 80004182 <filewrite>
    80004c90:	87aa                	mv	a5,a0
}
    80004c92:	853e                	mv	a0,a5
    80004c94:	70a2                	ld	ra,40(sp)
    80004c96:	7402                	ld	s0,32(sp)
    80004c98:	6145                	addi	sp,sp,48
    80004c9a:	8082                	ret

0000000080004c9c <sys_close>:
{
    80004c9c:	1101                	addi	sp,sp,-32
    80004c9e:	ec06                	sd	ra,24(sp)
    80004ca0:	e822                	sd	s0,16(sp)
    80004ca2:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    80004ca4:	fe040613          	addi	a2,s0,-32
    80004ca8:	fec40593          	addi	a1,s0,-20
    80004cac:	4501                	li	a0,0
    80004cae:	00000097          	auipc	ra,0x0
    80004cb2:	cc2080e7          	jalr	-830(ra) # 80004970 <argfd>
    return -1;
    80004cb6:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80004cb8:	02054463          	bltz	a0,80004ce0 <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    80004cbc:	ffffc097          	auipc	ra,0xffffc
    80004cc0:	5a4080e7          	jalr	1444(ra) # 80001260 <myproc>
    80004cc4:	fec42783          	lw	a5,-20(s0)
    80004cc8:	07e9                	addi	a5,a5,26
    80004cca:	078e                	slli	a5,a5,0x3
    80004ccc:	97aa                	add	a5,a5,a0
    80004cce:	0007b023          	sd	zero,0(a5)
  fileclose(f);
    80004cd2:	fe043503          	ld	a0,-32(s0)
    80004cd6:	fffff097          	auipc	ra,0xfffff
    80004cda:	2b0080e7          	jalr	688(ra) # 80003f86 <fileclose>
  return 0;
    80004cde:	4781                	li	a5,0
}
    80004ce0:	853e                	mv	a0,a5
    80004ce2:	60e2                	ld	ra,24(sp)
    80004ce4:	6442                	ld	s0,16(sp)
    80004ce6:	6105                	addi	sp,sp,32
    80004ce8:	8082                	ret

0000000080004cea <sys_fstat>:
{
    80004cea:	1101                	addi	sp,sp,-32
    80004cec:	ec06                	sd	ra,24(sp)
    80004cee:	e822                	sd	s0,16(sp)
    80004cf0:	1000                	addi	s0,sp,32
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004cf2:	fe840613          	addi	a2,s0,-24
    80004cf6:	4581                	li	a1,0
    80004cf8:	4501                	li	a0,0
    80004cfa:	00000097          	auipc	ra,0x0
    80004cfe:	c76080e7          	jalr	-906(ra) # 80004970 <argfd>
    return -1;
    80004d02:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004d04:	02054563          	bltz	a0,80004d2e <sys_fstat+0x44>
    80004d08:	fe040593          	addi	a1,s0,-32
    80004d0c:	4505                	li	a0,1
    80004d0e:	ffffd097          	auipc	ra,0xffffd
    80004d12:	638080e7          	jalr	1592(ra) # 80002346 <argaddr>
    return -1;
    80004d16:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004d18:	00054b63          	bltz	a0,80004d2e <sys_fstat+0x44>
  return filestat(f, st);
    80004d1c:	fe043583          	ld	a1,-32(s0)
    80004d20:	fe843503          	ld	a0,-24(s0)
    80004d24:	fffff097          	auipc	ra,0xfffff
    80004d28:	32a080e7          	jalr	810(ra) # 8000404e <filestat>
    80004d2c:	87aa                	mv	a5,a0
}
    80004d2e:	853e                	mv	a0,a5
    80004d30:	60e2                	ld	ra,24(sp)
    80004d32:	6442                	ld	s0,16(sp)
    80004d34:	6105                	addi	sp,sp,32
    80004d36:	8082                	ret

0000000080004d38 <sys_link>:
{
    80004d38:	7169                	addi	sp,sp,-304
    80004d3a:	f606                	sd	ra,296(sp)
    80004d3c:	f222                	sd	s0,288(sp)
    80004d3e:	ee26                	sd	s1,280(sp)
    80004d40:	ea4a                	sd	s2,272(sp)
    80004d42:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004d44:	08000613          	li	a2,128
    80004d48:	ed040593          	addi	a1,s0,-304
    80004d4c:	4501                	li	a0,0
    80004d4e:	ffffd097          	auipc	ra,0xffffd
    80004d52:	61a080e7          	jalr	1562(ra) # 80002368 <argstr>
    return -1;
    80004d56:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004d58:	10054e63          	bltz	a0,80004e74 <sys_link+0x13c>
    80004d5c:	08000613          	li	a2,128
    80004d60:	f5040593          	addi	a1,s0,-176
    80004d64:	4505                	li	a0,1
    80004d66:	ffffd097          	auipc	ra,0xffffd
    80004d6a:	602080e7          	jalr	1538(ra) # 80002368 <argstr>
    return -1;
    80004d6e:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004d70:	10054263          	bltz	a0,80004e74 <sys_link+0x13c>
  begin_op();
    80004d74:	fffff097          	auipc	ra,0xfffff
    80004d78:	d46080e7          	jalr	-698(ra) # 80003aba <begin_op>
  if((ip = namei(old)) == 0){
    80004d7c:	ed040513          	addi	a0,s0,-304
    80004d80:	fffff097          	auipc	ra,0xfffff
    80004d84:	98c080e7          	jalr	-1652(ra) # 8000370c <namei>
    80004d88:	84aa                	mv	s1,a0
    80004d8a:	c551                	beqz	a0,80004e16 <sys_link+0xde>
  ilock(ip);
    80004d8c:	ffffe097          	auipc	ra,0xffffe
    80004d90:	1d4080e7          	jalr	468(ra) # 80002f60 <ilock>
  if(ip->type == T_DIR){
    80004d94:	04449703          	lh	a4,68(s1)
    80004d98:	4785                	li	a5,1
    80004d9a:	08f70463          	beq	a4,a5,80004e22 <sys_link+0xea>
  ip->nlink++;
    80004d9e:	04a4d783          	lhu	a5,74(s1)
    80004da2:	2785                	addiw	a5,a5,1
    80004da4:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004da8:	8526                	mv	a0,s1
    80004daa:	ffffe097          	auipc	ra,0xffffe
    80004dae:	0f4080e7          	jalr	244(ra) # 80002e9e <iupdate>
  iunlock(ip);
    80004db2:	8526                	mv	a0,s1
    80004db4:	ffffe097          	auipc	ra,0xffffe
    80004db8:	26e080e7          	jalr	622(ra) # 80003022 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80004dbc:	fd040593          	addi	a1,s0,-48
    80004dc0:	f5040513          	addi	a0,s0,-176
    80004dc4:	fffff097          	auipc	ra,0xfffff
    80004dc8:	966080e7          	jalr	-1690(ra) # 8000372a <nameiparent>
    80004dcc:	892a                	mv	s2,a0
    80004dce:	c935                	beqz	a0,80004e42 <sys_link+0x10a>
  ilock(dp);
    80004dd0:	ffffe097          	auipc	ra,0xffffe
    80004dd4:	190080e7          	jalr	400(ra) # 80002f60 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80004dd8:	00092703          	lw	a4,0(s2)
    80004ddc:	409c                	lw	a5,0(s1)
    80004dde:	04f71d63          	bne	a4,a5,80004e38 <sys_link+0x100>
    80004de2:	40d0                	lw	a2,4(s1)
    80004de4:	fd040593          	addi	a1,s0,-48
    80004de8:	854a                	mv	a0,s2
    80004dea:	fffff097          	auipc	ra,0xfffff
    80004dee:	860080e7          	jalr	-1952(ra) # 8000364a <dirlink>
    80004df2:	04054363          	bltz	a0,80004e38 <sys_link+0x100>
  iunlockput(dp);
    80004df6:	854a                	mv	a0,s2
    80004df8:	ffffe097          	auipc	ra,0xffffe
    80004dfc:	3ca080e7          	jalr	970(ra) # 800031c2 <iunlockput>
  iput(ip);
    80004e00:	8526                	mv	a0,s1
    80004e02:	ffffe097          	auipc	ra,0xffffe
    80004e06:	318080e7          	jalr	792(ra) # 8000311a <iput>
  end_op();
    80004e0a:	fffff097          	auipc	ra,0xfffff
    80004e0e:	d30080e7          	jalr	-720(ra) # 80003b3a <end_op>
  return 0;
    80004e12:	4781                	li	a5,0
    80004e14:	a085                	j	80004e74 <sys_link+0x13c>
    end_op();
    80004e16:	fffff097          	auipc	ra,0xfffff
    80004e1a:	d24080e7          	jalr	-732(ra) # 80003b3a <end_op>
    return -1;
    80004e1e:	57fd                	li	a5,-1
    80004e20:	a891                	j	80004e74 <sys_link+0x13c>
    iunlockput(ip);
    80004e22:	8526                	mv	a0,s1
    80004e24:	ffffe097          	auipc	ra,0xffffe
    80004e28:	39e080e7          	jalr	926(ra) # 800031c2 <iunlockput>
    end_op();
    80004e2c:	fffff097          	auipc	ra,0xfffff
    80004e30:	d0e080e7          	jalr	-754(ra) # 80003b3a <end_op>
    return -1;
    80004e34:	57fd                	li	a5,-1
    80004e36:	a83d                	j	80004e74 <sys_link+0x13c>
    iunlockput(dp);
    80004e38:	854a                	mv	a0,s2
    80004e3a:	ffffe097          	auipc	ra,0xffffe
    80004e3e:	388080e7          	jalr	904(ra) # 800031c2 <iunlockput>
  ilock(ip);
    80004e42:	8526                	mv	a0,s1
    80004e44:	ffffe097          	auipc	ra,0xffffe
    80004e48:	11c080e7          	jalr	284(ra) # 80002f60 <ilock>
  ip->nlink--;
    80004e4c:	04a4d783          	lhu	a5,74(s1)
    80004e50:	37fd                	addiw	a5,a5,-1
    80004e52:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004e56:	8526                	mv	a0,s1
    80004e58:	ffffe097          	auipc	ra,0xffffe
    80004e5c:	046080e7          	jalr	70(ra) # 80002e9e <iupdate>
  iunlockput(ip);
    80004e60:	8526                	mv	a0,s1
    80004e62:	ffffe097          	auipc	ra,0xffffe
    80004e66:	360080e7          	jalr	864(ra) # 800031c2 <iunlockput>
  end_op();
    80004e6a:	fffff097          	auipc	ra,0xfffff
    80004e6e:	cd0080e7          	jalr	-816(ra) # 80003b3a <end_op>
  return -1;
    80004e72:	57fd                	li	a5,-1
}
    80004e74:	853e                	mv	a0,a5
    80004e76:	70b2                	ld	ra,296(sp)
    80004e78:	7412                	ld	s0,288(sp)
    80004e7a:	64f2                	ld	s1,280(sp)
    80004e7c:	6952                	ld	s2,272(sp)
    80004e7e:	6155                	addi	sp,sp,304
    80004e80:	8082                	ret

0000000080004e82 <sys_unlink>:
{
    80004e82:	7151                	addi	sp,sp,-240
    80004e84:	f586                	sd	ra,232(sp)
    80004e86:	f1a2                	sd	s0,224(sp)
    80004e88:	eda6                	sd	s1,216(sp)
    80004e8a:	e9ca                	sd	s2,208(sp)
    80004e8c:	e5ce                	sd	s3,200(sp)
    80004e8e:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80004e90:	08000613          	li	a2,128
    80004e94:	f3040593          	addi	a1,s0,-208
    80004e98:	4501                	li	a0,0
    80004e9a:	ffffd097          	auipc	ra,0xffffd
    80004e9e:	4ce080e7          	jalr	1230(ra) # 80002368 <argstr>
    80004ea2:	18054163          	bltz	a0,80005024 <sys_unlink+0x1a2>
  begin_op();
    80004ea6:	fffff097          	auipc	ra,0xfffff
    80004eaa:	c14080e7          	jalr	-1004(ra) # 80003aba <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80004eae:	fb040593          	addi	a1,s0,-80
    80004eb2:	f3040513          	addi	a0,s0,-208
    80004eb6:	fffff097          	auipc	ra,0xfffff
    80004eba:	874080e7          	jalr	-1932(ra) # 8000372a <nameiparent>
    80004ebe:	84aa                	mv	s1,a0
    80004ec0:	c979                	beqz	a0,80004f96 <sys_unlink+0x114>
  ilock(dp);
    80004ec2:	ffffe097          	auipc	ra,0xffffe
    80004ec6:	09e080e7          	jalr	158(ra) # 80002f60 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80004eca:	00004597          	auipc	a1,0x4
    80004ece:	95e58593          	addi	a1,a1,-1698 # 80008828 <syscalls+0x3a8>
    80004ed2:	fb040513          	addi	a0,s0,-80
    80004ed6:	ffffe097          	auipc	ra,0xffffe
    80004eda:	54a080e7          	jalr	1354(ra) # 80003420 <namecmp>
    80004ede:	14050a63          	beqz	a0,80005032 <sys_unlink+0x1b0>
    80004ee2:	00004597          	auipc	a1,0x4
    80004ee6:	94e58593          	addi	a1,a1,-1714 # 80008830 <syscalls+0x3b0>
    80004eea:	fb040513          	addi	a0,s0,-80
    80004eee:	ffffe097          	auipc	ra,0xffffe
    80004ef2:	532080e7          	jalr	1330(ra) # 80003420 <namecmp>
    80004ef6:	12050e63          	beqz	a0,80005032 <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    80004efa:	f2c40613          	addi	a2,s0,-212
    80004efe:	fb040593          	addi	a1,s0,-80
    80004f02:	8526                	mv	a0,s1
    80004f04:	ffffe097          	auipc	ra,0xffffe
    80004f08:	536080e7          	jalr	1334(ra) # 8000343a <dirlookup>
    80004f0c:	892a                	mv	s2,a0
    80004f0e:	12050263          	beqz	a0,80005032 <sys_unlink+0x1b0>
  ilock(ip);
    80004f12:	ffffe097          	auipc	ra,0xffffe
    80004f16:	04e080e7          	jalr	78(ra) # 80002f60 <ilock>
  if(ip->nlink < 1)
    80004f1a:	04a91783          	lh	a5,74(s2)
    80004f1e:	08f05263          	blez	a5,80004fa2 <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80004f22:	04491703          	lh	a4,68(s2)
    80004f26:	4785                	li	a5,1
    80004f28:	08f70563          	beq	a4,a5,80004fb2 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    80004f2c:	4641                	li	a2,16
    80004f2e:	4581                	li	a1,0
    80004f30:	fc040513          	addi	a0,s0,-64
    80004f34:	ffffb097          	auipc	ra,0xffffb
    80004f38:	244080e7          	jalr	580(ra) # 80000178 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004f3c:	4741                	li	a4,16
    80004f3e:	f2c42683          	lw	a3,-212(s0)
    80004f42:	fc040613          	addi	a2,s0,-64
    80004f46:	4581                	li	a1,0
    80004f48:	8526                	mv	a0,s1
    80004f4a:	ffffe097          	auipc	ra,0xffffe
    80004f4e:	3c2080e7          	jalr	962(ra) # 8000330c <writei>
    80004f52:	47c1                	li	a5,16
    80004f54:	0af51563          	bne	a0,a5,80004ffe <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    80004f58:	04491703          	lh	a4,68(s2)
    80004f5c:	4785                	li	a5,1
    80004f5e:	0af70863          	beq	a4,a5,8000500e <sys_unlink+0x18c>
  iunlockput(dp);
    80004f62:	8526                	mv	a0,s1
    80004f64:	ffffe097          	auipc	ra,0xffffe
    80004f68:	25e080e7          	jalr	606(ra) # 800031c2 <iunlockput>
  ip->nlink--;
    80004f6c:	04a95783          	lhu	a5,74(s2)
    80004f70:	37fd                	addiw	a5,a5,-1
    80004f72:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80004f76:	854a                	mv	a0,s2
    80004f78:	ffffe097          	auipc	ra,0xffffe
    80004f7c:	f26080e7          	jalr	-218(ra) # 80002e9e <iupdate>
  iunlockput(ip);
    80004f80:	854a                	mv	a0,s2
    80004f82:	ffffe097          	auipc	ra,0xffffe
    80004f86:	240080e7          	jalr	576(ra) # 800031c2 <iunlockput>
  end_op();
    80004f8a:	fffff097          	auipc	ra,0xfffff
    80004f8e:	bb0080e7          	jalr	-1104(ra) # 80003b3a <end_op>
  return 0;
    80004f92:	4501                	li	a0,0
    80004f94:	a84d                	j	80005046 <sys_unlink+0x1c4>
    end_op();
    80004f96:	fffff097          	auipc	ra,0xfffff
    80004f9a:	ba4080e7          	jalr	-1116(ra) # 80003b3a <end_op>
    return -1;
    80004f9e:	557d                	li	a0,-1
    80004fa0:	a05d                	j	80005046 <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    80004fa2:	00004517          	auipc	a0,0x4
    80004fa6:	8b650513          	addi	a0,a0,-1866 # 80008858 <syscalls+0x3d8>
    80004faa:	00001097          	auipc	ra,0x1
    80004fae:	4b8080e7          	jalr	1208(ra) # 80006462 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004fb2:	04c92703          	lw	a4,76(s2)
    80004fb6:	02000793          	li	a5,32
    80004fba:	f6e7f9e3          	bgeu	a5,a4,80004f2c <sys_unlink+0xaa>
    80004fbe:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004fc2:	4741                	li	a4,16
    80004fc4:	86ce                	mv	a3,s3
    80004fc6:	f1840613          	addi	a2,s0,-232
    80004fca:	4581                	li	a1,0
    80004fcc:	854a                	mv	a0,s2
    80004fce:	ffffe097          	auipc	ra,0xffffe
    80004fd2:	246080e7          	jalr	582(ra) # 80003214 <readi>
    80004fd6:	47c1                	li	a5,16
    80004fd8:	00f51b63          	bne	a0,a5,80004fee <sys_unlink+0x16c>
    if(de.inum != 0)
    80004fdc:	f1845783          	lhu	a5,-232(s0)
    80004fe0:	e7a1                	bnez	a5,80005028 <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004fe2:	29c1                	addiw	s3,s3,16
    80004fe4:	04c92783          	lw	a5,76(s2)
    80004fe8:	fcf9ede3          	bltu	s3,a5,80004fc2 <sys_unlink+0x140>
    80004fec:	b781                	j	80004f2c <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80004fee:	00004517          	auipc	a0,0x4
    80004ff2:	88250513          	addi	a0,a0,-1918 # 80008870 <syscalls+0x3f0>
    80004ff6:	00001097          	auipc	ra,0x1
    80004ffa:	46c080e7          	jalr	1132(ra) # 80006462 <panic>
    panic("unlink: writei");
    80004ffe:	00004517          	auipc	a0,0x4
    80005002:	88a50513          	addi	a0,a0,-1910 # 80008888 <syscalls+0x408>
    80005006:	00001097          	auipc	ra,0x1
    8000500a:	45c080e7          	jalr	1116(ra) # 80006462 <panic>
    dp->nlink--;
    8000500e:	04a4d783          	lhu	a5,74(s1)
    80005012:	37fd                	addiw	a5,a5,-1
    80005014:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80005018:	8526                	mv	a0,s1
    8000501a:	ffffe097          	auipc	ra,0xffffe
    8000501e:	e84080e7          	jalr	-380(ra) # 80002e9e <iupdate>
    80005022:	b781                	j	80004f62 <sys_unlink+0xe0>
    return -1;
    80005024:	557d                	li	a0,-1
    80005026:	a005                	j	80005046 <sys_unlink+0x1c4>
    iunlockput(ip);
    80005028:	854a                	mv	a0,s2
    8000502a:	ffffe097          	auipc	ra,0xffffe
    8000502e:	198080e7          	jalr	408(ra) # 800031c2 <iunlockput>
  iunlockput(dp);
    80005032:	8526                	mv	a0,s1
    80005034:	ffffe097          	auipc	ra,0xffffe
    80005038:	18e080e7          	jalr	398(ra) # 800031c2 <iunlockput>
  end_op();
    8000503c:	fffff097          	auipc	ra,0xfffff
    80005040:	afe080e7          	jalr	-1282(ra) # 80003b3a <end_op>
  return -1;
    80005044:	557d                	li	a0,-1
}
    80005046:	70ae                	ld	ra,232(sp)
    80005048:	740e                	ld	s0,224(sp)
    8000504a:	64ee                	ld	s1,216(sp)
    8000504c:	694e                	ld	s2,208(sp)
    8000504e:	69ae                	ld	s3,200(sp)
    80005050:	616d                	addi	sp,sp,240
    80005052:	8082                	ret

0000000080005054 <sys_open>:

uint64
sys_open(void)
{
    80005054:	7131                	addi	sp,sp,-192
    80005056:	fd06                	sd	ra,184(sp)
    80005058:	f922                	sd	s0,176(sp)
    8000505a:	f526                	sd	s1,168(sp)
    8000505c:	f14a                	sd	s2,160(sp)
    8000505e:	ed4e                	sd	s3,152(sp)
    80005060:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80005062:	08000613          	li	a2,128
    80005066:	f5040593          	addi	a1,s0,-176
    8000506a:	4501                	li	a0,0
    8000506c:	ffffd097          	auipc	ra,0xffffd
    80005070:	2fc080e7          	jalr	764(ra) # 80002368 <argstr>
    return -1;
    80005074:	54fd                	li	s1,-1
  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80005076:	0c054163          	bltz	a0,80005138 <sys_open+0xe4>
    8000507a:	f4c40593          	addi	a1,s0,-180
    8000507e:	4505                	li	a0,1
    80005080:	ffffd097          	auipc	ra,0xffffd
    80005084:	2a4080e7          	jalr	676(ra) # 80002324 <argint>
    80005088:	0a054863          	bltz	a0,80005138 <sys_open+0xe4>

  begin_op();
    8000508c:	fffff097          	auipc	ra,0xfffff
    80005090:	a2e080e7          	jalr	-1490(ra) # 80003aba <begin_op>

  if(omode & O_CREATE){
    80005094:	f4c42783          	lw	a5,-180(s0)
    80005098:	2007f793          	andi	a5,a5,512
    8000509c:	cbdd                	beqz	a5,80005152 <sys_open+0xfe>
    ip = create(path, T_FILE, 0, 0);
    8000509e:	4681                	li	a3,0
    800050a0:	4601                	li	a2,0
    800050a2:	4589                	li	a1,2
    800050a4:	f5040513          	addi	a0,s0,-176
    800050a8:	00000097          	auipc	ra,0x0
    800050ac:	972080e7          	jalr	-1678(ra) # 80004a1a <create>
    800050b0:	892a                	mv	s2,a0
    if(ip == 0){
    800050b2:	c959                	beqz	a0,80005148 <sys_open+0xf4>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    800050b4:	04491703          	lh	a4,68(s2)
    800050b8:	478d                	li	a5,3
    800050ba:	00f71763          	bne	a4,a5,800050c8 <sys_open+0x74>
    800050be:	04695703          	lhu	a4,70(s2)
    800050c2:	47a5                	li	a5,9
    800050c4:	0ce7ec63          	bltu	a5,a4,8000519c <sys_open+0x148>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    800050c8:	fffff097          	auipc	ra,0xfffff
    800050cc:	e02080e7          	jalr	-510(ra) # 80003eca <filealloc>
    800050d0:	89aa                	mv	s3,a0
    800050d2:	10050263          	beqz	a0,800051d6 <sys_open+0x182>
    800050d6:	00000097          	auipc	ra,0x0
    800050da:	902080e7          	jalr	-1790(ra) # 800049d8 <fdalloc>
    800050de:	84aa                	mv	s1,a0
    800050e0:	0e054663          	bltz	a0,800051cc <sys_open+0x178>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    800050e4:	04491703          	lh	a4,68(s2)
    800050e8:	478d                	li	a5,3
    800050ea:	0cf70463          	beq	a4,a5,800051b2 <sys_open+0x15e>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    800050ee:	4789                	li	a5,2
    800050f0:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    800050f4:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    800050f8:	0129bc23          	sd	s2,24(s3)
  f->readable = !(omode & O_WRONLY);
    800050fc:	f4c42783          	lw	a5,-180(s0)
    80005100:	0017c713          	xori	a4,a5,1
    80005104:	8b05                	andi	a4,a4,1
    80005106:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    8000510a:	0037f713          	andi	a4,a5,3
    8000510e:	00e03733          	snez	a4,a4
    80005112:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80005116:	4007f793          	andi	a5,a5,1024
    8000511a:	c791                	beqz	a5,80005126 <sys_open+0xd2>
    8000511c:	04491703          	lh	a4,68(s2)
    80005120:	4789                	li	a5,2
    80005122:	08f70f63          	beq	a4,a5,800051c0 <sys_open+0x16c>
    itrunc(ip);
  }

  iunlock(ip);
    80005126:	854a                	mv	a0,s2
    80005128:	ffffe097          	auipc	ra,0xffffe
    8000512c:	efa080e7          	jalr	-262(ra) # 80003022 <iunlock>
  end_op();
    80005130:	fffff097          	auipc	ra,0xfffff
    80005134:	a0a080e7          	jalr	-1526(ra) # 80003b3a <end_op>

  return fd;
}
    80005138:	8526                	mv	a0,s1
    8000513a:	70ea                	ld	ra,184(sp)
    8000513c:	744a                	ld	s0,176(sp)
    8000513e:	74aa                	ld	s1,168(sp)
    80005140:	790a                	ld	s2,160(sp)
    80005142:	69ea                	ld	s3,152(sp)
    80005144:	6129                	addi	sp,sp,192
    80005146:	8082                	ret
      end_op();
    80005148:	fffff097          	auipc	ra,0xfffff
    8000514c:	9f2080e7          	jalr	-1550(ra) # 80003b3a <end_op>
      return -1;
    80005150:	b7e5                	j	80005138 <sys_open+0xe4>
    if((ip = namei(path)) == 0){
    80005152:	f5040513          	addi	a0,s0,-176
    80005156:	ffffe097          	auipc	ra,0xffffe
    8000515a:	5b6080e7          	jalr	1462(ra) # 8000370c <namei>
    8000515e:	892a                	mv	s2,a0
    80005160:	c905                	beqz	a0,80005190 <sys_open+0x13c>
    ilock(ip);
    80005162:	ffffe097          	auipc	ra,0xffffe
    80005166:	dfe080e7          	jalr	-514(ra) # 80002f60 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    8000516a:	04491703          	lh	a4,68(s2)
    8000516e:	4785                	li	a5,1
    80005170:	f4f712e3          	bne	a4,a5,800050b4 <sys_open+0x60>
    80005174:	f4c42783          	lw	a5,-180(s0)
    80005178:	dba1                	beqz	a5,800050c8 <sys_open+0x74>
      iunlockput(ip);
    8000517a:	854a                	mv	a0,s2
    8000517c:	ffffe097          	auipc	ra,0xffffe
    80005180:	046080e7          	jalr	70(ra) # 800031c2 <iunlockput>
      end_op();
    80005184:	fffff097          	auipc	ra,0xfffff
    80005188:	9b6080e7          	jalr	-1610(ra) # 80003b3a <end_op>
      return -1;
    8000518c:	54fd                	li	s1,-1
    8000518e:	b76d                	j	80005138 <sys_open+0xe4>
      end_op();
    80005190:	fffff097          	auipc	ra,0xfffff
    80005194:	9aa080e7          	jalr	-1622(ra) # 80003b3a <end_op>
      return -1;
    80005198:	54fd                	li	s1,-1
    8000519a:	bf79                	j	80005138 <sys_open+0xe4>
    iunlockput(ip);
    8000519c:	854a                	mv	a0,s2
    8000519e:	ffffe097          	auipc	ra,0xffffe
    800051a2:	024080e7          	jalr	36(ra) # 800031c2 <iunlockput>
    end_op();
    800051a6:	fffff097          	auipc	ra,0xfffff
    800051aa:	994080e7          	jalr	-1644(ra) # 80003b3a <end_op>
    return -1;
    800051ae:	54fd                	li	s1,-1
    800051b0:	b761                	j	80005138 <sys_open+0xe4>
    f->type = FD_DEVICE;
    800051b2:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    800051b6:	04691783          	lh	a5,70(s2)
    800051ba:	02f99223          	sh	a5,36(s3)
    800051be:	bf2d                	j	800050f8 <sys_open+0xa4>
    itrunc(ip);
    800051c0:	854a                	mv	a0,s2
    800051c2:	ffffe097          	auipc	ra,0xffffe
    800051c6:	eac080e7          	jalr	-340(ra) # 8000306e <itrunc>
    800051ca:	bfb1                	j	80005126 <sys_open+0xd2>
      fileclose(f);
    800051cc:	854e                	mv	a0,s3
    800051ce:	fffff097          	auipc	ra,0xfffff
    800051d2:	db8080e7          	jalr	-584(ra) # 80003f86 <fileclose>
    iunlockput(ip);
    800051d6:	854a                	mv	a0,s2
    800051d8:	ffffe097          	auipc	ra,0xffffe
    800051dc:	fea080e7          	jalr	-22(ra) # 800031c2 <iunlockput>
    end_op();
    800051e0:	fffff097          	auipc	ra,0xfffff
    800051e4:	95a080e7          	jalr	-1702(ra) # 80003b3a <end_op>
    return -1;
    800051e8:	54fd                	li	s1,-1
    800051ea:	b7b9                	j	80005138 <sys_open+0xe4>

00000000800051ec <sys_mkdir>:

uint64
sys_mkdir(void)
{
    800051ec:	7175                	addi	sp,sp,-144
    800051ee:	e506                	sd	ra,136(sp)
    800051f0:	e122                	sd	s0,128(sp)
    800051f2:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    800051f4:	fffff097          	auipc	ra,0xfffff
    800051f8:	8c6080e7          	jalr	-1850(ra) # 80003aba <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    800051fc:	08000613          	li	a2,128
    80005200:	f7040593          	addi	a1,s0,-144
    80005204:	4501                	li	a0,0
    80005206:	ffffd097          	auipc	ra,0xffffd
    8000520a:	162080e7          	jalr	354(ra) # 80002368 <argstr>
    8000520e:	02054963          	bltz	a0,80005240 <sys_mkdir+0x54>
    80005212:	4681                	li	a3,0
    80005214:	4601                	li	a2,0
    80005216:	4585                	li	a1,1
    80005218:	f7040513          	addi	a0,s0,-144
    8000521c:	fffff097          	auipc	ra,0xfffff
    80005220:	7fe080e7          	jalr	2046(ra) # 80004a1a <create>
    80005224:	cd11                	beqz	a0,80005240 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80005226:	ffffe097          	auipc	ra,0xffffe
    8000522a:	f9c080e7          	jalr	-100(ra) # 800031c2 <iunlockput>
  end_op();
    8000522e:	fffff097          	auipc	ra,0xfffff
    80005232:	90c080e7          	jalr	-1780(ra) # 80003b3a <end_op>
  return 0;
    80005236:	4501                	li	a0,0
}
    80005238:	60aa                	ld	ra,136(sp)
    8000523a:	640a                	ld	s0,128(sp)
    8000523c:	6149                	addi	sp,sp,144
    8000523e:	8082                	ret
    end_op();
    80005240:	fffff097          	auipc	ra,0xfffff
    80005244:	8fa080e7          	jalr	-1798(ra) # 80003b3a <end_op>
    return -1;
    80005248:	557d                	li	a0,-1
    8000524a:	b7fd                	j	80005238 <sys_mkdir+0x4c>

000000008000524c <sys_mknod>:

uint64
sys_mknod(void)
{
    8000524c:	7135                	addi	sp,sp,-160
    8000524e:	ed06                	sd	ra,152(sp)
    80005250:	e922                	sd	s0,144(sp)
    80005252:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80005254:	fffff097          	auipc	ra,0xfffff
    80005258:	866080e7          	jalr	-1946(ra) # 80003aba <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    8000525c:	08000613          	li	a2,128
    80005260:	f7040593          	addi	a1,s0,-144
    80005264:	4501                	li	a0,0
    80005266:	ffffd097          	auipc	ra,0xffffd
    8000526a:	102080e7          	jalr	258(ra) # 80002368 <argstr>
    8000526e:	04054a63          	bltz	a0,800052c2 <sys_mknod+0x76>
     argint(1, &major) < 0 ||
    80005272:	f6c40593          	addi	a1,s0,-148
    80005276:	4505                	li	a0,1
    80005278:	ffffd097          	auipc	ra,0xffffd
    8000527c:	0ac080e7          	jalr	172(ra) # 80002324 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80005280:	04054163          	bltz	a0,800052c2 <sys_mknod+0x76>
     argint(2, &minor) < 0 ||
    80005284:	f6840593          	addi	a1,s0,-152
    80005288:	4509                	li	a0,2
    8000528a:	ffffd097          	auipc	ra,0xffffd
    8000528e:	09a080e7          	jalr	154(ra) # 80002324 <argint>
     argint(1, &major) < 0 ||
    80005292:	02054863          	bltz	a0,800052c2 <sys_mknod+0x76>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80005296:	f6841683          	lh	a3,-152(s0)
    8000529a:	f6c41603          	lh	a2,-148(s0)
    8000529e:	458d                	li	a1,3
    800052a0:	f7040513          	addi	a0,s0,-144
    800052a4:	fffff097          	auipc	ra,0xfffff
    800052a8:	776080e7          	jalr	1910(ra) # 80004a1a <create>
     argint(2, &minor) < 0 ||
    800052ac:	c919                	beqz	a0,800052c2 <sys_mknod+0x76>
    end_op();
    return -1;
  }
  iunlockput(ip);
    800052ae:	ffffe097          	auipc	ra,0xffffe
    800052b2:	f14080e7          	jalr	-236(ra) # 800031c2 <iunlockput>
  end_op();
    800052b6:	fffff097          	auipc	ra,0xfffff
    800052ba:	884080e7          	jalr	-1916(ra) # 80003b3a <end_op>
  return 0;
    800052be:	4501                	li	a0,0
    800052c0:	a031                	j	800052cc <sys_mknod+0x80>
    end_op();
    800052c2:	fffff097          	auipc	ra,0xfffff
    800052c6:	878080e7          	jalr	-1928(ra) # 80003b3a <end_op>
    return -1;
    800052ca:	557d                	li	a0,-1
}
    800052cc:	60ea                	ld	ra,152(sp)
    800052ce:	644a                	ld	s0,144(sp)
    800052d0:	610d                	addi	sp,sp,160
    800052d2:	8082                	ret

00000000800052d4 <sys_chdir>:

uint64
sys_chdir(void)
{
    800052d4:	7135                	addi	sp,sp,-160
    800052d6:	ed06                	sd	ra,152(sp)
    800052d8:	e922                	sd	s0,144(sp)
    800052da:	e526                	sd	s1,136(sp)
    800052dc:	e14a                	sd	s2,128(sp)
    800052de:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    800052e0:	ffffc097          	auipc	ra,0xffffc
    800052e4:	f80080e7          	jalr	-128(ra) # 80001260 <myproc>
    800052e8:	892a                	mv	s2,a0
  
  begin_op();
    800052ea:	ffffe097          	auipc	ra,0xffffe
    800052ee:	7d0080e7          	jalr	2000(ra) # 80003aba <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    800052f2:	08000613          	li	a2,128
    800052f6:	f6040593          	addi	a1,s0,-160
    800052fa:	4501                	li	a0,0
    800052fc:	ffffd097          	auipc	ra,0xffffd
    80005300:	06c080e7          	jalr	108(ra) # 80002368 <argstr>
    80005304:	04054b63          	bltz	a0,8000535a <sys_chdir+0x86>
    80005308:	f6040513          	addi	a0,s0,-160
    8000530c:	ffffe097          	auipc	ra,0xffffe
    80005310:	400080e7          	jalr	1024(ra) # 8000370c <namei>
    80005314:	84aa                	mv	s1,a0
    80005316:	c131                	beqz	a0,8000535a <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80005318:	ffffe097          	auipc	ra,0xffffe
    8000531c:	c48080e7          	jalr	-952(ra) # 80002f60 <ilock>
  if(ip->type != T_DIR){
    80005320:	04449703          	lh	a4,68(s1)
    80005324:	4785                	li	a5,1
    80005326:	04f71063          	bne	a4,a5,80005366 <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    8000532a:	8526                	mv	a0,s1
    8000532c:	ffffe097          	auipc	ra,0xffffe
    80005330:	cf6080e7          	jalr	-778(ra) # 80003022 <iunlock>
  iput(p->cwd);
    80005334:	15093503          	ld	a0,336(s2)
    80005338:	ffffe097          	auipc	ra,0xffffe
    8000533c:	de2080e7          	jalr	-542(ra) # 8000311a <iput>
  end_op();
    80005340:	ffffe097          	auipc	ra,0xffffe
    80005344:	7fa080e7          	jalr	2042(ra) # 80003b3a <end_op>
  p->cwd = ip;
    80005348:	14993823          	sd	s1,336(s2)
  return 0;
    8000534c:	4501                	li	a0,0
}
    8000534e:	60ea                	ld	ra,152(sp)
    80005350:	644a                	ld	s0,144(sp)
    80005352:	64aa                	ld	s1,136(sp)
    80005354:	690a                	ld	s2,128(sp)
    80005356:	610d                	addi	sp,sp,160
    80005358:	8082                	ret
    end_op();
    8000535a:	ffffe097          	auipc	ra,0xffffe
    8000535e:	7e0080e7          	jalr	2016(ra) # 80003b3a <end_op>
    return -1;
    80005362:	557d                	li	a0,-1
    80005364:	b7ed                	j	8000534e <sys_chdir+0x7a>
    iunlockput(ip);
    80005366:	8526                	mv	a0,s1
    80005368:	ffffe097          	auipc	ra,0xffffe
    8000536c:	e5a080e7          	jalr	-422(ra) # 800031c2 <iunlockput>
    end_op();
    80005370:	ffffe097          	auipc	ra,0xffffe
    80005374:	7ca080e7          	jalr	1994(ra) # 80003b3a <end_op>
    return -1;
    80005378:	557d                	li	a0,-1
    8000537a:	bfd1                	j	8000534e <sys_chdir+0x7a>

000000008000537c <sys_exec>:

uint64
sys_exec(void)
{
    8000537c:	7145                	addi	sp,sp,-464
    8000537e:	e786                	sd	ra,456(sp)
    80005380:	e3a2                	sd	s0,448(sp)
    80005382:	ff26                	sd	s1,440(sp)
    80005384:	fb4a                	sd	s2,432(sp)
    80005386:	f74e                	sd	s3,424(sp)
    80005388:	f352                	sd	s4,416(sp)
    8000538a:	ef56                	sd	s5,408(sp)
    8000538c:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    8000538e:	08000613          	li	a2,128
    80005392:	f4040593          	addi	a1,s0,-192
    80005396:	4501                	li	a0,0
    80005398:	ffffd097          	auipc	ra,0xffffd
    8000539c:	fd0080e7          	jalr	-48(ra) # 80002368 <argstr>
    return -1;
    800053a0:	597d                	li	s2,-1
  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    800053a2:	0c054a63          	bltz	a0,80005476 <sys_exec+0xfa>
    800053a6:	e3840593          	addi	a1,s0,-456
    800053aa:	4505                	li	a0,1
    800053ac:	ffffd097          	auipc	ra,0xffffd
    800053b0:	f9a080e7          	jalr	-102(ra) # 80002346 <argaddr>
    800053b4:	0c054163          	bltz	a0,80005476 <sys_exec+0xfa>
  }
  memset(argv, 0, sizeof(argv));
    800053b8:	10000613          	li	a2,256
    800053bc:	4581                	li	a1,0
    800053be:	e4040513          	addi	a0,s0,-448
    800053c2:	ffffb097          	auipc	ra,0xffffb
    800053c6:	db6080e7          	jalr	-586(ra) # 80000178 <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    800053ca:	e4040493          	addi	s1,s0,-448
  memset(argv, 0, sizeof(argv));
    800053ce:	89a6                	mv	s3,s1
    800053d0:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    800053d2:	02000a13          	li	s4,32
    800053d6:	00090a9b          	sext.w	s5,s2
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    800053da:	00391513          	slli	a0,s2,0x3
    800053de:	e3040593          	addi	a1,s0,-464
    800053e2:	e3843783          	ld	a5,-456(s0)
    800053e6:	953e                	add	a0,a0,a5
    800053e8:	ffffd097          	auipc	ra,0xffffd
    800053ec:	ea2080e7          	jalr	-350(ra) # 8000228a <fetchaddr>
    800053f0:	02054a63          	bltz	a0,80005424 <sys_exec+0xa8>
      goto bad;
    }
    if(uarg == 0){
    800053f4:	e3043783          	ld	a5,-464(s0)
    800053f8:	c3b9                	beqz	a5,8000543e <sys_exec+0xc2>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    800053fa:	ffffb097          	auipc	ra,0xffffb
    800053fe:	d1e080e7          	jalr	-738(ra) # 80000118 <kalloc>
    80005402:	85aa                	mv	a1,a0
    80005404:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80005408:	cd11                	beqz	a0,80005424 <sys_exec+0xa8>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    8000540a:	6605                	lui	a2,0x1
    8000540c:	e3043503          	ld	a0,-464(s0)
    80005410:	ffffd097          	auipc	ra,0xffffd
    80005414:	ecc080e7          	jalr	-308(ra) # 800022dc <fetchstr>
    80005418:	00054663          	bltz	a0,80005424 <sys_exec+0xa8>
    if(i >= NELEM(argv)){
    8000541c:	0905                	addi	s2,s2,1
    8000541e:	09a1                	addi	s3,s3,8
    80005420:	fb491be3          	bne	s2,s4,800053d6 <sys_exec+0x5a>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005424:	10048913          	addi	s2,s1,256
    80005428:	6088                	ld	a0,0(s1)
    8000542a:	c529                	beqz	a0,80005474 <sys_exec+0xf8>
    kfree(argv[i]);
    8000542c:	ffffb097          	auipc	ra,0xffffb
    80005430:	bf0080e7          	jalr	-1040(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005434:	04a1                	addi	s1,s1,8
    80005436:	ff2499e3          	bne	s1,s2,80005428 <sys_exec+0xac>
  return -1;
    8000543a:	597d                	li	s2,-1
    8000543c:	a82d                	j	80005476 <sys_exec+0xfa>
      argv[i] = 0;
    8000543e:	0a8e                	slli	s5,s5,0x3
    80005440:	fc040793          	addi	a5,s0,-64
    80005444:	9abe                	add	s5,s5,a5
    80005446:	e80ab023          	sd	zero,-384(s5)
  int ret = exec(path, argv);
    8000544a:	e4040593          	addi	a1,s0,-448
    8000544e:	f4040513          	addi	a0,s0,-192
    80005452:	fffff097          	auipc	ra,0xfffff
    80005456:	194080e7          	jalr	404(ra) # 800045e6 <exec>
    8000545a:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000545c:	10048993          	addi	s3,s1,256
    80005460:	6088                	ld	a0,0(s1)
    80005462:	c911                	beqz	a0,80005476 <sys_exec+0xfa>
    kfree(argv[i]);
    80005464:	ffffb097          	auipc	ra,0xffffb
    80005468:	bb8080e7          	jalr	-1096(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000546c:	04a1                	addi	s1,s1,8
    8000546e:	ff3499e3          	bne	s1,s3,80005460 <sys_exec+0xe4>
    80005472:	a011                	j	80005476 <sys_exec+0xfa>
  return -1;
    80005474:	597d                	li	s2,-1
}
    80005476:	854a                	mv	a0,s2
    80005478:	60be                	ld	ra,456(sp)
    8000547a:	641e                	ld	s0,448(sp)
    8000547c:	74fa                	ld	s1,440(sp)
    8000547e:	795a                	ld	s2,432(sp)
    80005480:	79ba                	ld	s3,424(sp)
    80005482:	7a1a                	ld	s4,416(sp)
    80005484:	6afa                	ld	s5,408(sp)
    80005486:	6179                	addi	sp,sp,464
    80005488:	8082                	ret

000000008000548a <sys_pipe>:

uint64
sys_pipe(void)
{
    8000548a:	7139                	addi	sp,sp,-64
    8000548c:	fc06                	sd	ra,56(sp)
    8000548e:	f822                	sd	s0,48(sp)
    80005490:	f426                	sd	s1,40(sp)
    80005492:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80005494:	ffffc097          	auipc	ra,0xffffc
    80005498:	dcc080e7          	jalr	-564(ra) # 80001260 <myproc>
    8000549c:	84aa                	mv	s1,a0

  if(argaddr(0, &fdarray) < 0)
    8000549e:	fd840593          	addi	a1,s0,-40
    800054a2:	4501                	li	a0,0
    800054a4:	ffffd097          	auipc	ra,0xffffd
    800054a8:	ea2080e7          	jalr	-350(ra) # 80002346 <argaddr>
    return -1;
    800054ac:	57fd                	li	a5,-1
  if(argaddr(0, &fdarray) < 0)
    800054ae:	0e054063          	bltz	a0,8000558e <sys_pipe+0x104>
  if(pipealloc(&rf, &wf) < 0)
    800054b2:	fc840593          	addi	a1,s0,-56
    800054b6:	fd040513          	addi	a0,s0,-48
    800054ba:	fffff097          	auipc	ra,0xfffff
    800054be:	dfc080e7          	jalr	-516(ra) # 800042b6 <pipealloc>
    return -1;
    800054c2:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    800054c4:	0c054563          	bltz	a0,8000558e <sys_pipe+0x104>
  fd0 = -1;
    800054c8:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    800054cc:	fd043503          	ld	a0,-48(s0)
    800054d0:	fffff097          	auipc	ra,0xfffff
    800054d4:	508080e7          	jalr	1288(ra) # 800049d8 <fdalloc>
    800054d8:	fca42223          	sw	a0,-60(s0)
    800054dc:	08054c63          	bltz	a0,80005574 <sys_pipe+0xea>
    800054e0:	fc843503          	ld	a0,-56(s0)
    800054e4:	fffff097          	auipc	ra,0xfffff
    800054e8:	4f4080e7          	jalr	1268(ra) # 800049d8 <fdalloc>
    800054ec:	fca42023          	sw	a0,-64(s0)
    800054f0:	06054863          	bltz	a0,80005560 <sys_pipe+0xd6>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800054f4:	4691                	li	a3,4
    800054f6:	fc440613          	addi	a2,s0,-60
    800054fa:	fd843583          	ld	a1,-40(s0)
    800054fe:	68a8                	ld	a0,80(s1)
    80005500:	ffffb097          	auipc	ra,0xffffb
    80005504:	602080e7          	jalr	1538(ra) # 80000b02 <copyout>
    80005508:	02054063          	bltz	a0,80005528 <sys_pipe+0x9e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    8000550c:	4691                	li	a3,4
    8000550e:	fc040613          	addi	a2,s0,-64
    80005512:	fd843583          	ld	a1,-40(s0)
    80005516:	0591                	addi	a1,a1,4
    80005518:	68a8                	ld	a0,80(s1)
    8000551a:	ffffb097          	auipc	ra,0xffffb
    8000551e:	5e8080e7          	jalr	1512(ra) # 80000b02 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80005522:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005524:	06055563          	bgez	a0,8000558e <sys_pipe+0x104>
    p->ofile[fd0] = 0;
    80005528:	fc442783          	lw	a5,-60(s0)
    8000552c:	07e9                	addi	a5,a5,26
    8000552e:	078e                	slli	a5,a5,0x3
    80005530:	97a6                	add	a5,a5,s1
    80005532:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80005536:	fc042503          	lw	a0,-64(s0)
    8000553a:	0569                	addi	a0,a0,26
    8000553c:	050e                	slli	a0,a0,0x3
    8000553e:	9526                	add	a0,a0,s1
    80005540:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    80005544:	fd043503          	ld	a0,-48(s0)
    80005548:	fffff097          	auipc	ra,0xfffff
    8000554c:	a3e080e7          	jalr	-1474(ra) # 80003f86 <fileclose>
    fileclose(wf);
    80005550:	fc843503          	ld	a0,-56(s0)
    80005554:	fffff097          	auipc	ra,0xfffff
    80005558:	a32080e7          	jalr	-1486(ra) # 80003f86 <fileclose>
    return -1;
    8000555c:	57fd                	li	a5,-1
    8000555e:	a805                	j	8000558e <sys_pipe+0x104>
    if(fd0 >= 0)
    80005560:	fc442783          	lw	a5,-60(s0)
    80005564:	0007c863          	bltz	a5,80005574 <sys_pipe+0xea>
      p->ofile[fd0] = 0;
    80005568:	01a78513          	addi	a0,a5,26
    8000556c:	050e                	slli	a0,a0,0x3
    8000556e:	9526                	add	a0,a0,s1
    80005570:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    80005574:	fd043503          	ld	a0,-48(s0)
    80005578:	fffff097          	auipc	ra,0xfffff
    8000557c:	a0e080e7          	jalr	-1522(ra) # 80003f86 <fileclose>
    fileclose(wf);
    80005580:	fc843503          	ld	a0,-56(s0)
    80005584:	fffff097          	auipc	ra,0xfffff
    80005588:	a02080e7          	jalr	-1534(ra) # 80003f86 <fileclose>
    return -1;
    8000558c:	57fd                	li	a5,-1
}
    8000558e:	853e                	mv	a0,a5
    80005590:	70e2                	ld	ra,56(sp)
    80005592:	7442                	ld	s0,48(sp)
    80005594:	74a2                	ld	s1,40(sp)
    80005596:	6121                	addi	sp,sp,64
    80005598:	8082                	ret
    8000559a:	0000                	unimp
    8000559c:	0000                	unimp
	...

00000000800055a0 <kernelvec>:
    800055a0:	7111                	addi	sp,sp,-256
    800055a2:	e006                	sd	ra,0(sp)
    800055a4:	e40a                	sd	sp,8(sp)
    800055a6:	e80e                	sd	gp,16(sp)
    800055a8:	ec12                	sd	tp,24(sp)
    800055aa:	f016                	sd	t0,32(sp)
    800055ac:	f41a                	sd	t1,40(sp)
    800055ae:	f81e                	sd	t2,48(sp)
    800055b0:	fc22                	sd	s0,56(sp)
    800055b2:	e0a6                	sd	s1,64(sp)
    800055b4:	e4aa                	sd	a0,72(sp)
    800055b6:	e8ae                	sd	a1,80(sp)
    800055b8:	ecb2                	sd	a2,88(sp)
    800055ba:	f0b6                	sd	a3,96(sp)
    800055bc:	f4ba                	sd	a4,104(sp)
    800055be:	f8be                	sd	a5,112(sp)
    800055c0:	fcc2                	sd	a6,120(sp)
    800055c2:	e146                	sd	a7,128(sp)
    800055c4:	e54a                	sd	s2,136(sp)
    800055c6:	e94e                	sd	s3,144(sp)
    800055c8:	ed52                	sd	s4,152(sp)
    800055ca:	f156                	sd	s5,160(sp)
    800055cc:	f55a                	sd	s6,168(sp)
    800055ce:	f95e                	sd	s7,176(sp)
    800055d0:	fd62                	sd	s8,184(sp)
    800055d2:	e1e6                	sd	s9,192(sp)
    800055d4:	e5ea                	sd	s10,200(sp)
    800055d6:	e9ee                	sd	s11,208(sp)
    800055d8:	edf2                	sd	t3,216(sp)
    800055da:	f1f6                	sd	t4,224(sp)
    800055dc:	f5fa                	sd	t5,232(sp)
    800055de:	f9fe                	sd	t6,240(sp)
    800055e0:	b77fc0ef          	jal	ra,80002156 <kerneltrap>
    800055e4:	6082                	ld	ra,0(sp)
    800055e6:	6122                	ld	sp,8(sp)
    800055e8:	61c2                	ld	gp,16(sp)
    800055ea:	7282                	ld	t0,32(sp)
    800055ec:	7322                	ld	t1,40(sp)
    800055ee:	73c2                	ld	t2,48(sp)
    800055f0:	7462                	ld	s0,56(sp)
    800055f2:	6486                	ld	s1,64(sp)
    800055f4:	6526                	ld	a0,72(sp)
    800055f6:	65c6                	ld	a1,80(sp)
    800055f8:	6666                	ld	a2,88(sp)
    800055fa:	7686                	ld	a3,96(sp)
    800055fc:	7726                	ld	a4,104(sp)
    800055fe:	77c6                	ld	a5,112(sp)
    80005600:	7866                	ld	a6,120(sp)
    80005602:	688a                	ld	a7,128(sp)
    80005604:	692a                	ld	s2,136(sp)
    80005606:	69ca                	ld	s3,144(sp)
    80005608:	6a6a                	ld	s4,152(sp)
    8000560a:	7a8a                	ld	s5,160(sp)
    8000560c:	7b2a                	ld	s6,168(sp)
    8000560e:	7bca                	ld	s7,176(sp)
    80005610:	7c6a                	ld	s8,184(sp)
    80005612:	6c8e                	ld	s9,192(sp)
    80005614:	6d2e                	ld	s10,200(sp)
    80005616:	6dce                	ld	s11,208(sp)
    80005618:	6e6e                	ld	t3,216(sp)
    8000561a:	7e8e                	ld	t4,224(sp)
    8000561c:	7f2e                	ld	t5,232(sp)
    8000561e:	7fce                	ld	t6,240(sp)
    80005620:	6111                	addi	sp,sp,256
    80005622:	10200073          	sret
    80005626:	00000013          	nop
    8000562a:	00000013          	nop
    8000562e:	0001                	nop

0000000080005630 <timervec>:
    80005630:	34051573          	csrrw	a0,mscratch,a0
    80005634:	e10c                	sd	a1,0(a0)
    80005636:	e510                	sd	a2,8(a0)
    80005638:	e914                	sd	a3,16(a0)
    8000563a:	6d0c                	ld	a1,24(a0)
    8000563c:	7110                	ld	a2,32(a0)
    8000563e:	6194                	ld	a3,0(a1)
    80005640:	96b2                	add	a3,a3,a2
    80005642:	e194                	sd	a3,0(a1)
    80005644:	4589                	li	a1,2
    80005646:	14459073          	csrw	sip,a1
    8000564a:	6914                	ld	a3,16(a0)
    8000564c:	6510                	ld	a2,8(a0)
    8000564e:	610c                	ld	a1,0(a0)
    80005650:	34051573          	csrrw	a0,mscratch,a0
    80005654:	30200073          	mret
	...

000000008000565a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000565a:	1141                	addi	sp,sp,-16
    8000565c:	e422                	sd	s0,8(sp)
    8000565e:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80005660:	0c0007b7          	lui	a5,0xc000
    80005664:	4705                	li	a4,1
    80005666:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80005668:	c3d8                	sw	a4,4(a5)
}
    8000566a:	6422                	ld	s0,8(sp)
    8000566c:	0141                	addi	sp,sp,16
    8000566e:	8082                	ret

0000000080005670 <plicinithart>:

void
plicinithart(void)
{
    80005670:	1141                	addi	sp,sp,-16
    80005672:	e406                	sd	ra,8(sp)
    80005674:	e022                	sd	s0,0(sp)
    80005676:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005678:	ffffc097          	auipc	ra,0xffffc
    8000567c:	bbc080e7          	jalr	-1092(ra) # 80001234 <cpuid>
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005680:	0085171b          	slliw	a4,a0,0x8
    80005684:	0c0027b7          	lui	a5,0xc002
    80005688:	97ba                	add	a5,a5,a4
    8000568a:	40200713          	li	a4,1026
    8000568e:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005692:	00d5151b          	slliw	a0,a0,0xd
    80005696:	0c2017b7          	lui	a5,0xc201
    8000569a:	953e                	add	a0,a0,a5
    8000569c:	00052023          	sw	zero,0(a0)
}
    800056a0:	60a2                	ld	ra,8(sp)
    800056a2:	6402                	ld	s0,0(sp)
    800056a4:	0141                	addi	sp,sp,16
    800056a6:	8082                	ret

00000000800056a8 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    800056a8:	1141                	addi	sp,sp,-16
    800056aa:	e406                	sd	ra,8(sp)
    800056ac:	e022                	sd	s0,0(sp)
    800056ae:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800056b0:	ffffc097          	auipc	ra,0xffffc
    800056b4:	b84080e7          	jalr	-1148(ra) # 80001234 <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    800056b8:	00d5179b          	slliw	a5,a0,0xd
    800056bc:	0c201537          	lui	a0,0xc201
    800056c0:	953e                	add	a0,a0,a5
  return irq;
}
    800056c2:	4148                	lw	a0,4(a0)
    800056c4:	60a2                	ld	ra,8(sp)
    800056c6:	6402                	ld	s0,0(sp)
    800056c8:	0141                	addi	sp,sp,16
    800056ca:	8082                	ret

00000000800056cc <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    800056cc:	1101                	addi	sp,sp,-32
    800056ce:	ec06                	sd	ra,24(sp)
    800056d0:	e822                	sd	s0,16(sp)
    800056d2:	e426                	sd	s1,8(sp)
    800056d4:	1000                	addi	s0,sp,32
    800056d6:	84aa                	mv	s1,a0
  int hart = cpuid();
    800056d8:	ffffc097          	auipc	ra,0xffffc
    800056dc:	b5c080e7          	jalr	-1188(ra) # 80001234 <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    800056e0:	00d5151b          	slliw	a0,a0,0xd
    800056e4:	0c2017b7          	lui	a5,0xc201
    800056e8:	97aa                	add	a5,a5,a0
    800056ea:	c3c4                	sw	s1,4(a5)
}
    800056ec:	60e2                	ld	ra,24(sp)
    800056ee:	6442                	ld	s0,16(sp)
    800056f0:	64a2                	ld	s1,8(sp)
    800056f2:	6105                	addi	sp,sp,32
    800056f4:	8082                	ret

00000000800056f6 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    800056f6:	1141                	addi	sp,sp,-16
    800056f8:	e406                	sd	ra,8(sp)
    800056fa:	e022                	sd	s0,0(sp)
    800056fc:	0800                	addi	s0,sp,16
  if(i >= NUM)
    800056fe:	479d                	li	a5,7
    80005700:	06a7c963          	blt	a5,a0,80005772 <free_desc+0x7c>
    panic("free_desc 1");
  if(disk.free[i])
    80005704:	00016797          	auipc	a5,0x16
    80005708:	8fc78793          	addi	a5,a5,-1796 # 8001b000 <disk>
    8000570c:	00a78733          	add	a4,a5,a0
    80005710:	6789                	lui	a5,0x2
    80005712:	97ba                	add	a5,a5,a4
    80005714:	0187c783          	lbu	a5,24(a5) # 2018 <_entry-0x7fffdfe8>
    80005718:	e7ad                	bnez	a5,80005782 <free_desc+0x8c>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    8000571a:	00451793          	slli	a5,a0,0x4
    8000571e:	00018717          	auipc	a4,0x18
    80005722:	8e270713          	addi	a4,a4,-1822 # 8001d000 <disk+0x2000>
    80005726:	6314                	ld	a3,0(a4)
    80005728:	96be                	add	a3,a3,a5
    8000572a:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    8000572e:	6314                	ld	a3,0(a4)
    80005730:	96be                	add	a3,a3,a5
    80005732:	0006a423          	sw	zero,8(a3)
  disk.desc[i].flags = 0;
    80005736:	6314                	ld	a3,0(a4)
    80005738:	96be                	add	a3,a3,a5
    8000573a:	00069623          	sh	zero,12(a3)
  disk.desc[i].next = 0;
    8000573e:	6318                	ld	a4,0(a4)
    80005740:	97ba                	add	a5,a5,a4
    80005742:	00079723          	sh	zero,14(a5)
  disk.free[i] = 1;
    80005746:	00016797          	auipc	a5,0x16
    8000574a:	8ba78793          	addi	a5,a5,-1862 # 8001b000 <disk>
    8000574e:	97aa                	add	a5,a5,a0
    80005750:	6509                	lui	a0,0x2
    80005752:	953e                	add	a0,a0,a5
    80005754:	4785                	li	a5,1
    80005756:	00f50c23          	sb	a5,24(a0) # 2018 <_entry-0x7fffdfe8>
  wakeup(&disk.free[0]);
    8000575a:	00018517          	auipc	a0,0x18
    8000575e:	8be50513          	addi	a0,a0,-1858 # 8001d018 <disk+0x2018>
    80005762:	ffffc097          	auipc	ra,0xffffc
    80005766:	346080e7          	jalr	838(ra) # 80001aa8 <wakeup>
}
    8000576a:	60a2                	ld	ra,8(sp)
    8000576c:	6402                	ld	s0,0(sp)
    8000576e:	0141                	addi	sp,sp,16
    80005770:	8082                	ret
    panic("free_desc 1");
    80005772:	00003517          	auipc	a0,0x3
    80005776:	12650513          	addi	a0,a0,294 # 80008898 <syscalls+0x418>
    8000577a:	00001097          	auipc	ra,0x1
    8000577e:	ce8080e7          	jalr	-792(ra) # 80006462 <panic>
    panic("free_desc 2");
    80005782:	00003517          	auipc	a0,0x3
    80005786:	12650513          	addi	a0,a0,294 # 800088a8 <syscalls+0x428>
    8000578a:	00001097          	auipc	ra,0x1
    8000578e:	cd8080e7          	jalr	-808(ra) # 80006462 <panic>

0000000080005792 <virtio_disk_init>:
{
    80005792:	1101                	addi	sp,sp,-32
    80005794:	ec06                	sd	ra,24(sp)
    80005796:	e822                	sd	s0,16(sp)
    80005798:	e426                	sd	s1,8(sp)
    8000579a:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    8000579c:	00003597          	auipc	a1,0x3
    800057a0:	11c58593          	addi	a1,a1,284 # 800088b8 <syscalls+0x438>
    800057a4:	00018517          	auipc	a0,0x18
    800057a8:	98450513          	addi	a0,a0,-1660 # 8001d128 <disk+0x2128>
    800057ac:	00001097          	auipc	ra,0x1
    800057b0:	170080e7          	jalr	368(ra) # 8000691c <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800057b4:	100017b7          	lui	a5,0x10001
    800057b8:	4398                	lw	a4,0(a5)
    800057ba:	2701                	sext.w	a4,a4
    800057bc:	747277b7          	lui	a5,0x74727
    800057c0:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    800057c4:	0ef71163          	bne	a4,a5,800058a6 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    800057c8:	100017b7          	lui	a5,0x10001
    800057cc:	43dc                	lw	a5,4(a5)
    800057ce:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800057d0:	4705                	li	a4,1
    800057d2:	0ce79a63          	bne	a5,a4,800058a6 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800057d6:	100017b7          	lui	a5,0x10001
    800057da:	479c                	lw	a5,8(a5)
    800057dc:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    800057de:	4709                	li	a4,2
    800057e0:	0ce79363          	bne	a5,a4,800058a6 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    800057e4:	100017b7          	lui	a5,0x10001
    800057e8:	47d8                	lw	a4,12(a5)
    800057ea:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800057ec:	554d47b7          	lui	a5,0x554d4
    800057f0:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    800057f4:	0af71963          	bne	a4,a5,800058a6 <virtio_disk_init+0x114>
  *R(VIRTIO_MMIO_STATUS) = status;
    800057f8:	100017b7          	lui	a5,0x10001
    800057fc:	4705                	li	a4,1
    800057fe:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005800:	470d                	li	a4,3
    80005802:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80005804:	4b94                	lw	a3,16(a5)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80005806:	c7ffe737          	lui	a4,0xc7ffe
    8000580a:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fd851f>
    8000580e:	8f75                	and	a4,a4,a3
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80005810:	2701                	sext.w	a4,a4
    80005812:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005814:	472d                	li	a4,11
    80005816:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005818:	473d                	li	a4,15
    8000581a:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    8000581c:	6705                	lui	a4,0x1
    8000581e:	d798                	sw	a4,40(a5)
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80005820:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80005824:	5bdc                	lw	a5,52(a5)
    80005826:	2781                	sext.w	a5,a5
  if(max == 0)
    80005828:	c7d9                	beqz	a5,800058b6 <virtio_disk_init+0x124>
  if(max < NUM)
    8000582a:	471d                	li	a4,7
    8000582c:	08f77d63          	bgeu	a4,a5,800058c6 <virtio_disk_init+0x134>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80005830:	100014b7          	lui	s1,0x10001
    80005834:	47a1                	li	a5,8
    80005836:	dc9c                	sw	a5,56(s1)
  memset(disk.pages, 0, sizeof(disk.pages));
    80005838:	6609                	lui	a2,0x2
    8000583a:	4581                	li	a1,0
    8000583c:	00015517          	auipc	a0,0x15
    80005840:	7c450513          	addi	a0,a0,1988 # 8001b000 <disk>
    80005844:	ffffb097          	auipc	ra,0xffffb
    80005848:	934080e7          	jalr	-1740(ra) # 80000178 <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    8000584c:	00015717          	auipc	a4,0x15
    80005850:	7b470713          	addi	a4,a4,1972 # 8001b000 <disk>
    80005854:	00c75793          	srli	a5,a4,0xc
    80005858:	2781                	sext.w	a5,a5
    8000585a:	c0bc                	sw	a5,64(s1)
  disk.desc = (struct virtq_desc *) disk.pages;
    8000585c:	00017797          	auipc	a5,0x17
    80005860:	7a478793          	addi	a5,a5,1956 # 8001d000 <disk+0x2000>
    80005864:	e398                	sd	a4,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    80005866:	00016717          	auipc	a4,0x16
    8000586a:	81a70713          	addi	a4,a4,-2022 # 8001b080 <disk+0x80>
    8000586e:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    80005870:	00016717          	auipc	a4,0x16
    80005874:	79070713          	addi	a4,a4,1936 # 8001c000 <disk+0x1000>
    80005878:	eb98                	sd	a4,16(a5)
    disk.free[i] = 1;
    8000587a:	4705                	li	a4,1
    8000587c:	00e78c23          	sb	a4,24(a5)
    80005880:	00e78ca3          	sb	a4,25(a5)
    80005884:	00e78d23          	sb	a4,26(a5)
    80005888:	00e78da3          	sb	a4,27(a5)
    8000588c:	00e78e23          	sb	a4,28(a5)
    80005890:	00e78ea3          	sb	a4,29(a5)
    80005894:	00e78f23          	sb	a4,30(a5)
    80005898:	00e78fa3          	sb	a4,31(a5)
}
    8000589c:	60e2                	ld	ra,24(sp)
    8000589e:	6442                	ld	s0,16(sp)
    800058a0:	64a2                	ld	s1,8(sp)
    800058a2:	6105                	addi	sp,sp,32
    800058a4:	8082                	ret
    panic("could not find virtio disk");
    800058a6:	00003517          	auipc	a0,0x3
    800058aa:	02250513          	addi	a0,a0,34 # 800088c8 <syscalls+0x448>
    800058ae:	00001097          	auipc	ra,0x1
    800058b2:	bb4080e7          	jalr	-1100(ra) # 80006462 <panic>
    panic("virtio disk has no queue 0");
    800058b6:	00003517          	auipc	a0,0x3
    800058ba:	03250513          	addi	a0,a0,50 # 800088e8 <syscalls+0x468>
    800058be:	00001097          	auipc	ra,0x1
    800058c2:	ba4080e7          	jalr	-1116(ra) # 80006462 <panic>
    panic("virtio disk max queue too short");
    800058c6:	00003517          	auipc	a0,0x3
    800058ca:	04250513          	addi	a0,a0,66 # 80008908 <syscalls+0x488>
    800058ce:	00001097          	auipc	ra,0x1
    800058d2:	b94080e7          	jalr	-1132(ra) # 80006462 <panic>

00000000800058d6 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    800058d6:	7159                	addi	sp,sp,-112
    800058d8:	f486                	sd	ra,104(sp)
    800058da:	f0a2                	sd	s0,96(sp)
    800058dc:	eca6                	sd	s1,88(sp)
    800058de:	e8ca                	sd	s2,80(sp)
    800058e0:	e4ce                	sd	s3,72(sp)
    800058e2:	e0d2                	sd	s4,64(sp)
    800058e4:	fc56                	sd	s5,56(sp)
    800058e6:	f85a                	sd	s6,48(sp)
    800058e8:	f45e                	sd	s7,40(sp)
    800058ea:	f062                	sd	s8,32(sp)
    800058ec:	ec66                	sd	s9,24(sp)
    800058ee:	e86a                	sd	s10,16(sp)
    800058f0:	1880                	addi	s0,sp,112
    800058f2:	892a                	mv	s2,a0
    800058f4:	8d2e                	mv	s10,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    800058f6:	00c52c83          	lw	s9,12(a0)
    800058fa:	001c9c9b          	slliw	s9,s9,0x1
    800058fe:	1c82                	slli	s9,s9,0x20
    80005900:	020cdc93          	srli	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    80005904:	00018517          	auipc	a0,0x18
    80005908:	82450513          	addi	a0,a0,-2012 # 8001d128 <disk+0x2128>
    8000590c:	00001097          	auipc	ra,0x1
    80005910:	0a0080e7          	jalr	160(ra) # 800069ac <acquire>
  for(int i = 0; i < 3; i++){
    80005914:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    80005916:	4c21                	li	s8,8
      disk.free[i] = 0;
    80005918:	00015b97          	auipc	s7,0x15
    8000591c:	6e8b8b93          	addi	s7,s7,1768 # 8001b000 <disk>
    80005920:	6b09                	lui	s6,0x2
  for(int i = 0; i < 3; i++){
    80005922:	4a8d                	li	s5,3
  for(int i = 0; i < NUM; i++){
    80005924:	8a4e                	mv	s4,s3
    80005926:	a051                	j	800059aa <virtio_disk_rw+0xd4>
      disk.free[i] = 0;
    80005928:	00fb86b3          	add	a3,s7,a5
    8000592c:	96da                	add	a3,a3,s6
    8000592e:	00068c23          	sb	zero,24(a3)
    idx[i] = alloc_desc();
    80005932:	c21c                	sw	a5,0(a2)
    if(idx[i] < 0){
    80005934:	0207c563          	bltz	a5,8000595e <virtio_disk_rw+0x88>
  for(int i = 0; i < 3; i++){
    80005938:	2485                	addiw	s1,s1,1
    8000593a:	0711                	addi	a4,a4,4
    8000593c:	25548063          	beq	s1,s5,80005b7c <virtio_disk_rw+0x2a6>
    idx[i] = alloc_desc();
    80005940:	863a                	mv	a2,a4
  for(int i = 0; i < NUM; i++){
    80005942:	00017697          	auipc	a3,0x17
    80005946:	6d668693          	addi	a3,a3,1750 # 8001d018 <disk+0x2018>
    8000594a:	87d2                	mv	a5,s4
    if(disk.free[i]){
    8000594c:	0006c583          	lbu	a1,0(a3)
    80005950:	fde1                	bnez	a1,80005928 <virtio_disk_rw+0x52>
  for(int i = 0; i < NUM; i++){
    80005952:	2785                	addiw	a5,a5,1
    80005954:	0685                	addi	a3,a3,1
    80005956:	ff879be3          	bne	a5,s8,8000594c <virtio_disk_rw+0x76>
    idx[i] = alloc_desc();
    8000595a:	57fd                	li	a5,-1
    8000595c:	c21c                	sw	a5,0(a2)
      for(int j = 0; j < i; j++)
    8000595e:	02905a63          	blez	s1,80005992 <virtio_disk_rw+0xbc>
        free_desc(idx[j]);
    80005962:	f9042503          	lw	a0,-112(s0)
    80005966:	00000097          	auipc	ra,0x0
    8000596a:	d90080e7          	jalr	-624(ra) # 800056f6 <free_desc>
      for(int j = 0; j < i; j++)
    8000596e:	4785                	li	a5,1
    80005970:	0297d163          	bge	a5,s1,80005992 <virtio_disk_rw+0xbc>
        free_desc(idx[j]);
    80005974:	f9442503          	lw	a0,-108(s0)
    80005978:	00000097          	auipc	ra,0x0
    8000597c:	d7e080e7          	jalr	-642(ra) # 800056f6 <free_desc>
      for(int j = 0; j < i; j++)
    80005980:	4789                	li	a5,2
    80005982:	0097d863          	bge	a5,s1,80005992 <virtio_disk_rw+0xbc>
        free_desc(idx[j]);
    80005986:	f9842503          	lw	a0,-104(s0)
    8000598a:	00000097          	auipc	ra,0x0
    8000598e:	d6c080e7          	jalr	-660(ra) # 800056f6 <free_desc>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80005992:	00017597          	auipc	a1,0x17
    80005996:	79658593          	addi	a1,a1,1942 # 8001d128 <disk+0x2128>
    8000599a:	00017517          	auipc	a0,0x17
    8000599e:	67e50513          	addi	a0,a0,1662 # 8001d018 <disk+0x2018>
    800059a2:	ffffc097          	auipc	ra,0xffffc
    800059a6:	f7a080e7          	jalr	-134(ra) # 8000191c <sleep>
  for(int i = 0; i < 3; i++){
    800059aa:	f9040713          	addi	a4,s0,-112
    800059ae:	84ce                	mv	s1,s3
    800059b0:	bf41                	j	80005940 <virtio_disk_rw+0x6a>
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];

  if(write)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    800059b2:	20058713          	addi	a4,a1,512
    800059b6:	00471693          	slli	a3,a4,0x4
    800059ba:	00015717          	auipc	a4,0x15
    800059be:	64670713          	addi	a4,a4,1606 # 8001b000 <disk>
    800059c2:	9736                	add	a4,a4,a3
    800059c4:	4685                	li	a3,1
    800059c6:	0ad72423          	sw	a3,168(a4)
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    800059ca:	20058713          	addi	a4,a1,512
    800059ce:	00471693          	slli	a3,a4,0x4
    800059d2:	00015717          	auipc	a4,0x15
    800059d6:	62e70713          	addi	a4,a4,1582 # 8001b000 <disk>
    800059da:	9736                	add	a4,a4,a3
    800059dc:	0a072623          	sw	zero,172(a4)
  buf0->sector = sector;
    800059e0:	0b973823          	sd	s9,176(a4)

  disk.desc[idx[0]].addr = (uint64) buf0;
    800059e4:	7679                	lui	a2,0xffffe
    800059e6:	963e                	add	a2,a2,a5
    800059e8:	00017697          	auipc	a3,0x17
    800059ec:	61868693          	addi	a3,a3,1560 # 8001d000 <disk+0x2000>
    800059f0:	6298                	ld	a4,0(a3)
    800059f2:	9732                	add	a4,a4,a2
    800059f4:	e308                	sd	a0,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    800059f6:	6298                	ld	a4,0(a3)
    800059f8:	9732                	add	a4,a4,a2
    800059fa:	4541                	li	a0,16
    800059fc:	c708                	sw	a0,8(a4)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    800059fe:	6298                	ld	a4,0(a3)
    80005a00:	9732                	add	a4,a4,a2
    80005a02:	4505                	li	a0,1
    80005a04:	00a71623          	sh	a0,12(a4)
  disk.desc[idx[0]].next = idx[1];
    80005a08:	f9442703          	lw	a4,-108(s0)
    80005a0c:	6288                	ld	a0,0(a3)
    80005a0e:	962a                	add	a2,a2,a0
    80005a10:	00e61723          	sh	a4,14(a2) # ffffffffffffe00e <end+0xffffffff7ffd7dce>

  disk.desc[idx[1]].addr = (uint64) b->data;
    80005a14:	0712                	slli	a4,a4,0x4
    80005a16:	6290                	ld	a2,0(a3)
    80005a18:	963a                	add	a2,a2,a4
    80005a1a:	05890513          	addi	a0,s2,88
    80005a1e:	e208                	sd	a0,0(a2)
  disk.desc[idx[1]].len = BSIZE;
    80005a20:	6294                	ld	a3,0(a3)
    80005a22:	96ba                	add	a3,a3,a4
    80005a24:	40000613          	li	a2,1024
    80005a28:	c690                	sw	a2,8(a3)
  if(write)
    80005a2a:	140d0063          	beqz	s10,80005b6a <virtio_disk_rw+0x294>
    disk.desc[idx[1]].flags = 0; // device reads b->data
    80005a2e:	00017697          	auipc	a3,0x17
    80005a32:	5d26b683          	ld	a3,1490(a3) # 8001d000 <disk+0x2000>
    80005a36:	96ba                	add	a3,a3,a4
    80005a38:	00069623          	sh	zero,12(a3)
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80005a3c:	00015817          	auipc	a6,0x15
    80005a40:	5c480813          	addi	a6,a6,1476 # 8001b000 <disk>
    80005a44:	00017517          	auipc	a0,0x17
    80005a48:	5bc50513          	addi	a0,a0,1468 # 8001d000 <disk+0x2000>
    80005a4c:	6114                	ld	a3,0(a0)
    80005a4e:	96ba                	add	a3,a3,a4
    80005a50:	00c6d603          	lhu	a2,12(a3)
    80005a54:	00166613          	ori	a2,a2,1
    80005a58:	00c69623          	sh	a2,12(a3)
  disk.desc[idx[1]].next = idx[2];
    80005a5c:	f9842683          	lw	a3,-104(s0)
    80005a60:	6110                	ld	a2,0(a0)
    80005a62:	9732                	add	a4,a4,a2
    80005a64:	00d71723          	sh	a3,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80005a68:	20058613          	addi	a2,a1,512
    80005a6c:	0612                	slli	a2,a2,0x4
    80005a6e:	9642                	add	a2,a2,a6
    80005a70:	577d                	li	a4,-1
    80005a72:	02e60823          	sb	a4,48(a2)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80005a76:	00469713          	slli	a4,a3,0x4
    80005a7a:	6114                	ld	a3,0(a0)
    80005a7c:	96ba                	add	a3,a3,a4
    80005a7e:	03078793          	addi	a5,a5,48
    80005a82:	97c2                	add	a5,a5,a6
    80005a84:	e29c                	sd	a5,0(a3)
  disk.desc[idx[2]].len = 1;
    80005a86:	611c                	ld	a5,0(a0)
    80005a88:	97ba                	add	a5,a5,a4
    80005a8a:	4685                	li	a3,1
    80005a8c:	c794                	sw	a3,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80005a8e:	611c                	ld	a5,0(a0)
    80005a90:	97ba                	add	a5,a5,a4
    80005a92:	4809                	li	a6,2
    80005a94:	01079623          	sh	a6,12(a5)
  disk.desc[idx[2]].next = 0;
    80005a98:	611c                	ld	a5,0(a0)
    80005a9a:	973e                	add	a4,a4,a5
    80005a9c:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80005aa0:	00d92223          	sw	a3,4(s2)
  disk.info[idx[0]].b = b;
    80005aa4:	03263423          	sd	s2,40(a2)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80005aa8:	6518                	ld	a4,8(a0)
    80005aaa:	00275783          	lhu	a5,2(a4)
    80005aae:	8b9d                	andi	a5,a5,7
    80005ab0:	0786                	slli	a5,a5,0x1
    80005ab2:	97ba                	add	a5,a5,a4
    80005ab4:	00b79223          	sh	a1,4(a5)

  __sync_synchronize();
    80005ab8:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80005abc:	6518                	ld	a4,8(a0)
    80005abe:	00275783          	lhu	a5,2(a4)
    80005ac2:	2785                	addiw	a5,a5,1
    80005ac4:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80005ac8:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80005acc:	100017b7          	lui	a5,0x10001
    80005ad0:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80005ad4:	00492703          	lw	a4,4(s2)
    80005ad8:	4785                	li	a5,1
    80005ada:	02f71163          	bne	a4,a5,80005afc <virtio_disk_rw+0x226>
    sleep(b, &disk.vdisk_lock);
    80005ade:	00017997          	auipc	s3,0x17
    80005ae2:	64a98993          	addi	s3,s3,1610 # 8001d128 <disk+0x2128>
  while(b->disk == 1) {
    80005ae6:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    80005ae8:	85ce                	mv	a1,s3
    80005aea:	854a                	mv	a0,s2
    80005aec:	ffffc097          	auipc	ra,0xffffc
    80005af0:	e30080e7          	jalr	-464(ra) # 8000191c <sleep>
  while(b->disk == 1) {
    80005af4:	00492783          	lw	a5,4(s2)
    80005af8:	fe9788e3          	beq	a5,s1,80005ae8 <virtio_disk_rw+0x212>
  }

  disk.info[idx[0]].b = 0;
    80005afc:	f9042903          	lw	s2,-112(s0)
    80005b00:	20090793          	addi	a5,s2,512
    80005b04:	00479713          	slli	a4,a5,0x4
    80005b08:	00015797          	auipc	a5,0x15
    80005b0c:	4f878793          	addi	a5,a5,1272 # 8001b000 <disk>
    80005b10:	97ba                	add	a5,a5,a4
    80005b12:	0207b423          	sd	zero,40(a5)
    int flag = disk.desc[i].flags;
    80005b16:	00017997          	auipc	s3,0x17
    80005b1a:	4ea98993          	addi	s3,s3,1258 # 8001d000 <disk+0x2000>
    80005b1e:	00491713          	slli	a4,s2,0x4
    80005b22:	0009b783          	ld	a5,0(s3)
    80005b26:	97ba                	add	a5,a5,a4
    80005b28:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80005b2c:	854a                	mv	a0,s2
    80005b2e:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80005b32:	00000097          	auipc	ra,0x0
    80005b36:	bc4080e7          	jalr	-1084(ra) # 800056f6 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80005b3a:	8885                	andi	s1,s1,1
    80005b3c:	f0ed                	bnez	s1,80005b1e <virtio_disk_rw+0x248>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80005b3e:	00017517          	auipc	a0,0x17
    80005b42:	5ea50513          	addi	a0,a0,1514 # 8001d128 <disk+0x2128>
    80005b46:	00001097          	auipc	ra,0x1
    80005b4a:	f1a080e7          	jalr	-230(ra) # 80006a60 <release>
}
    80005b4e:	70a6                	ld	ra,104(sp)
    80005b50:	7406                	ld	s0,96(sp)
    80005b52:	64e6                	ld	s1,88(sp)
    80005b54:	6946                	ld	s2,80(sp)
    80005b56:	69a6                	ld	s3,72(sp)
    80005b58:	6a06                	ld	s4,64(sp)
    80005b5a:	7ae2                	ld	s5,56(sp)
    80005b5c:	7b42                	ld	s6,48(sp)
    80005b5e:	7ba2                	ld	s7,40(sp)
    80005b60:	7c02                	ld	s8,32(sp)
    80005b62:	6ce2                	ld	s9,24(sp)
    80005b64:	6d42                	ld	s10,16(sp)
    80005b66:	6165                	addi	sp,sp,112
    80005b68:	8082                	ret
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    80005b6a:	00017697          	auipc	a3,0x17
    80005b6e:	4966b683          	ld	a3,1174(a3) # 8001d000 <disk+0x2000>
    80005b72:	96ba                	add	a3,a3,a4
    80005b74:	4609                	li	a2,2
    80005b76:	00c69623          	sh	a2,12(a3)
    80005b7a:	b5c9                	j	80005a3c <virtio_disk_rw+0x166>
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80005b7c:	f9042583          	lw	a1,-112(s0)
    80005b80:	20058793          	addi	a5,a1,512
    80005b84:	0792                	slli	a5,a5,0x4
    80005b86:	00015517          	auipc	a0,0x15
    80005b8a:	52250513          	addi	a0,a0,1314 # 8001b0a8 <disk+0xa8>
    80005b8e:	953e                	add	a0,a0,a5
  if(write)
    80005b90:	e20d11e3          	bnez	s10,800059b2 <virtio_disk_rw+0xdc>
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
    80005b94:	20058713          	addi	a4,a1,512
    80005b98:	00471693          	slli	a3,a4,0x4
    80005b9c:	00015717          	auipc	a4,0x15
    80005ba0:	46470713          	addi	a4,a4,1124 # 8001b000 <disk>
    80005ba4:	9736                	add	a4,a4,a3
    80005ba6:	0a072423          	sw	zero,168(a4)
    80005baa:	b505                	j	800059ca <virtio_disk_rw+0xf4>

0000000080005bac <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80005bac:	1101                	addi	sp,sp,-32
    80005bae:	ec06                	sd	ra,24(sp)
    80005bb0:	e822                	sd	s0,16(sp)
    80005bb2:	e426                	sd	s1,8(sp)
    80005bb4:	e04a                	sd	s2,0(sp)
    80005bb6:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80005bb8:	00017517          	auipc	a0,0x17
    80005bbc:	57050513          	addi	a0,a0,1392 # 8001d128 <disk+0x2128>
    80005bc0:	00001097          	auipc	ra,0x1
    80005bc4:	dec080e7          	jalr	-532(ra) # 800069ac <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80005bc8:	10001737          	lui	a4,0x10001
    80005bcc:	533c                	lw	a5,96(a4)
    80005bce:	8b8d                	andi	a5,a5,3
    80005bd0:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    80005bd2:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80005bd6:	00017797          	auipc	a5,0x17
    80005bda:	42a78793          	addi	a5,a5,1066 # 8001d000 <disk+0x2000>
    80005bde:	6b94                	ld	a3,16(a5)
    80005be0:	0207d703          	lhu	a4,32(a5)
    80005be4:	0026d783          	lhu	a5,2(a3)
    80005be8:	06f70163          	beq	a4,a5,80005c4a <virtio_disk_intr+0x9e>
    __sync_synchronize();
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80005bec:	00015917          	auipc	s2,0x15
    80005bf0:	41490913          	addi	s2,s2,1044 # 8001b000 <disk>
    80005bf4:	00017497          	auipc	s1,0x17
    80005bf8:	40c48493          	addi	s1,s1,1036 # 8001d000 <disk+0x2000>
    __sync_synchronize();
    80005bfc:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80005c00:	6898                	ld	a4,16(s1)
    80005c02:	0204d783          	lhu	a5,32(s1)
    80005c06:	8b9d                	andi	a5,a5,7
    80005c08:	078e                	slli	a5,a5,0x3
    80005c0a:	97ba                	add	a5,a5,a4
    80005c0c:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80005c0e:	20078713          	addi	a4,a5,512
    80005c12:	0712                	slli	a4,a4,0x4
    80005c14:	974a                	add	a4,a4,s2
    80005c16:	03074703          	lbu	a4,48(a4) # 10001030 <_entry-0x6fffefd0>
    80005c1a:	e731                	bnez	a4,80005c66 <virtio_disk_intr+0xba>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80005c1c:	20078793          	addi	a5,a5,512
    80005c20:	0792                	slli	a5,a5,0x4
    80005c22:	97ca                	add	a5,a5,s2
    80005c24:	7788                	ld	a0,40(a5)
    b->disk = 0;   // disk is done with buf
    80005c26:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80005c2a:	ffffc097          	auipc	ra,0xffffc
    80005c2e:	e7e080e7          	jalr	-386(ra) # 80001aa8 <wakeup>

    disk.used_idx += 1;
    80005c32:	0204d783          	lhu	a5,32(s1)
    80005c36:	2785                	addiw	a5,a5,1
    80005c38:	17c2                	slli	a5,a5,0x30
    80005c3a:	93c1                	srli	a5,a5,0x30
    80005c3c:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80005c40:	6898                	ld	a4,16(s1)
    80005c42:	00275703          	lhu	a4,2(a4)
    80005c46:	faf71be3          	bne	a4,a5,80005bfc <virtio_disk_intr+0x50>
  }

  release(&disk.vdisk_lock);
    80005c4a:	00017517          	auipc	a0,0x17
    80005c4e:	4de50513          	addi	a0,a0,1246 # 8001d128 <disk+0x2128>
    80005c52:	00001097          	auipc	ra,0x1
    80005c56:	e0e080e7          	jalr	-498(ra) # 80006a60 <release>
}
    80005c5a:	60e2                	ld	ra,24(sp)
    80005c5c:	6442                	ld	s0,16(sp)
    80005c5e:	64a2                	ld	s1,8(sp)
    80005c60:	6902                	ld	s2,0(sp)
    80005c62:	6105                	addi	sp,sp,32
    80005c64:	8082                	ret
      panic("virtio_disk_intr status");
    80005c66:	00003517          	auipc	a0,0x3
    80005c6a:	cc250513          	addi	a0,a0,-830 # 80008928 <syscalls+0x4a8>
    80005c6e:	00000097          	auipc	ra,0x0
    80005c72:	7f4080e7          	jalr	2036(ra) # 80006462 <panic>

0000000080005c76 <swap_page_from_pte>:
/* NTU OS 2024 */
/* Allocate eight consecutive disk blocks. */
/* Save the content of the physical page in the pte */
/* to the disk blocks and save the block-id into the */
/* pte. */
char *swap_page_from_pte(pte_t *pte) {
    80005c76:	7179                	addi	sp,sp,-48
    80005c78:	f406                	sd	ra,40(sp)
    80005c7a:	f022                	sd	s0,32(sp)
    80005c7c:	ec26                	sd	s1,24(sp)
    80005c7e:	e84a                	sd	s2,16(sp)
    80005c80:	e44e                	sd	s3,8(sp)
    80005c82:	1800                	addi	s0,sp,48
    80005c84:	89aa                	mv	s3,a0
  char *pa = (char*) PTE2PA(*pte);
    80005c86:	00053903          	ld	s2,0(a0)
    80005c8a:	00a95913          	srli	s2,s2,0xa
    80005c8e:	0932                	slli	s2,s2,0xc
  uint dp = balloc_page(ROOTDEV);
    80005c90:	4505                	li	a0,1
    80005c92:	ffffe097          	auipc	ra,0xffffe
    80005c96:	ab4080e7          	jalr	-1356(ra) # 80003746 <balloc_page>
    80005c9a:	0005049b          	sext.w	s1,a0

  write_page_to_disk(ROOTDEV, pa, dp); // write this page to disk
    80005c9e:	8626                	mv	a2,s1
    80005ca0:	85ca                	mv	a1,s2
    80005ca2:	4505                	li	a0,1
    80005ca4:	ffffd097          	auipc	ra,0xffffd
    80005ca8:	c64080e7          	jalr	-924(ra) # 80002908 <write_page_to_disk>
  *pte = (BLOCKNO2PTE(dp) | PTE_FLAGS(*pte) | PTE_S) & ~PTE_V;
    80005cac:	0009b783          	ld	a5,0(s3)
    80005cb0:	00a4949b          	slliw	s1,s1,0xa
    80005cb4:	1482                	slli	s1,s1,0x20
    80005cb6:	9081                	srli	s1,s1,0x20
    80005cb8:	1fe7f793          	andi	a5,a5,510
    80005cbc:	8cdd                	or	s1,s1,a5
    80005cbe:	2004e493          	ori	s1,s1,512
    80005cc2:	0099b023          	sd	s1,0(s3)

  return pa;
}
    80005cc6:	854a                	mv	a0,s2
    80005cc8:	70a2                	ld	ra,40(sp)
    80005cca:	7402                	ld	s0,32(sp)
    80005ccc:	64e2                	ld	s1,24(sp)
    80005cce:	6942                	ld	s2,16(sp)
    80005cd0:	69a2                	ld	s3,8(sp)
    80005cd2:	6145                	addi	sp,sp,48
    80005cd4:	8082                	ret

0000000080005cd6 <handle_pgfault>:

/* NTU OS 2024 */
/* Page fault handler */
int handle_pgfault(uint64 va) {
    80005cd6:	7179                	addi	sp,sp,-48
    80005cd8:	f406                	sd	ra,40(sp)
    80005cda:	f022                	sd	s0,32(sp)
    80005cdc:	ec26                	sd	s1,24(sp)
    80005cde:	e84a                	sd	s2,16(sp)
    80005ce0:	e44e                	sd	s3,8(sp)
    80005ce2:	1800                	addi	s0,sp,48
    80005ce4:	84aa                	mv	s1,a0
  /* Find the address that caused the fault */
  /* uint64 va = r_stval(); */

  /* TODO */
  struct proc *p = myproc();
    80005ce6:	ffffb097          	auipc	ra,0xffffb
    80005cea:	57a080e7          	jalr	1402(ra) # 80001260 <myproc>
  pagetable_t pagetable = p->pagetable;
    80005cee:	05053983          	ld	s3,80(a0)
  va = PGROUNDDOWN(va); // Align to page boundary
    80005cf2:	797d                	lui	s2,0xfffff
    80005cf4:	0124f933          	and	s2,s1,s2

  // Allocate a new physical page
  char *mem = kalloc();
    80005cf8:	ffffa097          	auipc	ra,0xffffa
    80005cfc:	420080e7          	jalr	1056(ra) # 80000118 <kalloc>
  if(mem == 0) {
    80005d00:	c90d                	beqz	a0,80005d32 <handle_pgfault+0x5c>
    80005d02:	84aa                	mv	s1,a0
      panic("handle_page_fault: kalloc failed");
  }

  // Zero out the new page
  memset(mem, 0, PGSIZE);
    80005d04:	6605                	lui	a2,0x1
    80005d06:	4581                	li	a1,0
    80005d08:	ffffa097          	auipc	ra,0xffffa
    80005d0c:	470080e7          	jalr	1136(ra) # 80000178 <memset>

  // Map the faulting virtual address to the new physical page
  if(mappages(pagetable, va, PGSIZE, (uint64)mem, PTE_U|PTE_R|PTE_W|PTE_X) != 0) {
    80005d10:	4779                	li	a4,30
    80005d12:	86a6                	mv	a3,s1
    80005d14:	6605                	lui	a2,0x1
    80005d16:	85ca                	mv	a1,s2
    80005d18:	854e                	mv	a0,s3
    80005d1a:	ffffb097          	auipc	ra,0xffffb
    80005d1e:	82e080e7          	jalr	-2002(ra) # 80000548 <mappages>
    80005d22:	e105                	bnez	a0,80005d42 <handle_pgfault+0x6c>
      kfree(mem);
      panic("handle_page_fault: mappages failed");
  }
}
    80005d24:	70a2                	ld	ra,40(sp)
    80005d26:	7402                	ld	s0,32(sp)
    80005d28:	64e2                	ld	s1,24(sp)
    80005d2a:	6942                	ld	s2,16(sp)
    80005d2c:	69a2                	ld	s3,8(sp)
    80005d2e:	6145                	addi	sp,sp,48
    80005d30:	8082                	ret
      panic("handle_page_fault: kalloc failed");
    80005d32:	00003517          	auipc	a0,0x3
    80005d36:	c0e50513          	addi	a0,a0,-1010 # 80008940 <syscalls+0x4c0>
    80005d3a:	00000097          	auipc	ra,0x0
    80005d3e:	728080e7          	jalr	1832(ra) # 80006462 <panic>
      kfree(mem);
    80005d42:	8526                	mv	a0,s1
    80005d44:	ffffa097          	auipc	ra,0xffffa
    80005d48:	2d8080e7          	jalr	728(ra) # 8000001c <kfree>
      panic("handle_page_fault: mappages failed");
    80005d4c:	00003517          	auipc	a0,0x3
    80005d50:	c1c50513          	addi	a0,a0,-996 # 80008968 <syscalls+0x4e8>
    80005d54:	00000097          	auipc	ra,0x0
    80005d58:	70e080e7          	jalr	1806(ra) # 80006462 <panic>

0000000080005d5c <sys_vmprint>:

/* NTU OS 2024 */
/* Entry of vmprint() syscall. */
uint64
sys_vmprint(void)
{
    80005d5c:	1141                	addi	sp,sp,-16
    80005d5e:	e406                	sd	ra,8(sp)
    80005d60:	e022                	sd	s0,0(sp)
    80005d62:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80005d64:	ffffb097          	auipc	ra,0xffffb
    80005d68:	4fc080e7          	jalr	1276(ra) # 80001260 <myproc>
  vmprint(p->pagetable);
    80005d6c:	6928                	ld	a0,80(a0)
    80005d6e:	ffffb097          	auipc	ra,0xffffb
    80005d72:	34e080e7          	jalr	846(ra) # 800010bc <vmprint>
  return 0;
}
    80005d76:	4501                	li	a0,0
    80005d78:	60a2                	ld	ra,8(sp)
    80005d7a:	6402                	ld	s0,0(sp)
    80005d7c:	0141                	addi	sp,sp,16
    80005d7e:	8082                	ret

0000000080005d80 <sys_madvise>:

/* NTU OS 2024 */
/* Entry of madvise() syscall. */
uint64
sys_madvise(void)
{
    80005d80:	1101                	addi	sp,sp,-32
    80005d82:	ec06                	sd	ra,24(sp)
    80005d84:	e822                	sd	s0,16(sp)
    80005d86:	1000                	addi	s0,sp,32

  uint64 addr;
  int length;
  int advise;

  if (argaddr(0, &addr) < 0) return -1;
    80005d88:	fe840593          	addi	a1,s0,-24
    80005d8c:	4501                	li	a0,0
    80005d8e:	ffffc097          	auipc	ra,0xffffc
    80005d92:	5b8080e7          	jalr	1464(ra) # 80002346 <argaddr>
    80005d96:	57fd                	li	a5,-1
    80005d98:	04054163          	bltz	a0,80005dda <sys_madvise+0x5a>
  if (argint(1, &length) < 0) return -1;
    80005d9c:	fe440593          	addi	a1,s0,-28
    80005da0:	4505                	li	a0,1
    80005da2:	ffffc097          	auipc	ra,0xffffc
    80005da6:	582080e7          	jalr	1410(ra) # 80002324 <argint>
    80005daa:	57fd                	li	a5,-1
    80005dac:	02054763          	bltz	a0,80005dda <sys_madvise+0x5a>
  if (argint(2, &advise) < 0) return -1;
    80005db0:	fe040593          	addi	a1,s0,-32
    80005db4:	4509                	li	a0,2
    80005db6:	ffffc097          	auipc	ra,0xffffc
    80005dba:	56e080e7          	jalr	1390(ra) # 80002324 <argint>
    80005dbe:	57fd                	li	a5,-1
    80005dc0:	00054d63          	bltz	a0,80005dda <sys_madvise+0x5a>

  int ret = madvise(addr, length, advise);
    80005dc4:	fe042603          	lw	a2,-32(s0)
    80005dc8:	fe442583          	lw	a1,-28(s0)
    80005dcc:	fe843503          	ld	a0,-24(s0)
    80005dd0:	ffffb097          	auipc	ra,0xffffb
    80005dd4:	efe080e7          	jalr	-258(ra) # 80000cce <madvise>
  return ret;
    80005dd8:	87aa                	mv	a5,a0
}
    80005dda:	853e                	mv	a0,a5
    80005ddc:	60e2                	ld	ra,24(sp)
    80005dde:	6442                	ld	s0,16(sp)
    80005de0:	6105                	addi	sp,sp,32
    80005de2:	8082                	ret

0000000080005de4 <sys_pgprint>:
#if defined(PG_REPLACEMENT_USE_FIFO) || defined(PG_REPLACEMENT_USE_LRU)
/* NTU OS 2024 */
/* Entry of pgprint() syscall. */
uint64
sys_pgprint(void)
{
    80005de4:	1141                	addi	sp,sp,-16
    80005de6:	e406                	sd	ra,8(sp)
    80005de8:	e022                	sd	s0,0(sp)
    80005dea:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80005dec:	ffffb097          	auipc	ra,0xffffb
    80005df0:	474080e7          	jalr	1140(ra) # 80001260 <myproc>
  pgprint();
    80005df4:	ffffb097          	auipc	ra,0xffffb
    80005df8:	0a2080e7          	jalr	162(ra) # 80000e96 <pgprint>
  return 0;
}
    80005dfc:	4501                	li	a0,0
    80005dfe:	60a2                	ld	ra,8(sp)
    80005e00:	6402                	ld	s0,0(sp)
    80005e02:	0141                	addi	sp,sp,16
    80005e04:	8082                	ret

0000000080005e06 <q_init>:
#include "riscv.h"
#include "spinlock.h"
#include "defs.h"
#include "proc.h"

void q_init(queue_t *q){
    80005e06:	1141                	addi	sp,sp,-16
    80005e08:	e422                	sd	s0,8(sp)
    80005e0a:	0800                	addi	s0,sp,16
	    q->size = 0;
    80005e0c:	00052023          	sw	zero,0(a0)
    for (int i = 0; i < PG_BUF_SIZE; i++) {
        q->bucket[i] = 0;
    80005e10:	00053423          	sd	zero,8(a0)
    80005e14:	00053823          	sd	zero,16(a0)
    80005e18:	00053c23          	sd	zero,24(a0)
    80005e1c:	02053023          	sd	zero,32(a0)
    80005e20:	02053423          	sd	zero,40(a0)
    80005e24:	02053823          	sd	zero,48(a0)
    80005e28:	02053c23          	sd	zero,56(a0)
    80005e2c:	04053023          	sd	zero,64(a0)
    }
}
    80005e30:	6422                	ld	s0,8(sp)
    80005e32:	0141                	addi	sp,sp,16
    80005e34:	8082                	ret

0000000080005e36 <q_push>:

int q_push(queue_t *q, uint64 e){
    80005e36:	1141                	addi	sp,sp,-16
    80005e38:	e422                	sd	s0,8(sp)
    80005e3a:	0800                	addi	s0,sp,16
	if (q->size < PG_BUF_SIZE) {
    80005e3c:	411c                	lw	a5,0(a0)
    80005e3e:	471d                	li	a4,7
    80005e40:	00f77663          	bgeu	a4,a5,80005e4c <q_push+0x16>
        q->bucket[q->size] = e;
        q->size++;
        return 1; // Success
    }
    return 0; // Failure: Queue is full
    80005e44:	4501                	li	a0,0
}
    80005e46:	6422                	ld	s0,8(sp)
    80005e48:	0141                	addi	sp,sp,16
    80005e4a:	8082                	ret
        q->bucket[q->size] = e;
    80005e4c:	02079713          	slli	a4,a5,0x20
    80005e50:	9301                	srli	a4,a4,0x20
    80005e52:	070e                	slli	a4,a4,0x3
    80005e54:	972a                	add	a4,a4,a0
    80005e56:	e70c                	sd	a1,8(a4)
        q->size++;
    80005e58:	2785                	addiw	a5,a5,1
    80005e5a:	c11c                	sw	a5,0(a0)
        return 1; // Success
    80005e5c:	4505                	li	a0,1
    80005e5e:	b7e5                	j	80005e46 <q_push+0x10>

0000000080005e60 <q_pop_idx>:

uint64 q_pop_idx(queue_t *q, int idx){
    80005e60:	1141                	addi	sp,sp,-16
    80005e62:	e422                	sd	s0,8(sp)
    80005e64:	0800                	addi	s0,sp,16
	if (idx >= 0 && idx < q->size) {
    80005e66:	0405c763          	bltz	a1,80005eb4 <q_pop_idx+0x54>
    80005e6a:	86aa                	mv	a3,a0
    80005e6c:	411c                	lw	a5,0(a0)
    80005e6e:	0005871b          	sext.w	a4,a1
        }
        q->size--;
        q->bucket[q->size] = 0; // Clear the last element
        return element;
    }
    return 0; // Failure or invalid index
    80005e72:	4501                	li	a0,0
	if (idx >= 0 && idx < q->size) {
    80005e74:	04f77163          	bgeu	a4,a5,80005eb6 <q_pop_idx+0x56>
        uint64 element = q->bucket[idx];
    80005e78:	00359613          	slli	a2,a1,0x3
    80005e7c:	9636                	add	a2,a2,a3
    80005e7e:	6608                	ld	a0,8(a2)
        for (int i = idx; i < q->size - 1; i++) {
    80005e80:	fff7881b          	addiw	a6,a5,-1
    80005e84:	0008089b          	sext.w	a7,a6
    80005e88:	01177c63          	bgeu	a4,a7,80005ea0 <q_pop_idx+0x40>
    80005e8c:	8732                	mv	a4,a2
            q->bucket[i] = q->bucket[i + 1];
    80005e8e:	0015879b          	addiw	a5,a1,1
    80005e92:	0007859b          	sext.w	a1,a5
    80005e96:	6b10                	ld	a2,16(a4)
    80005e98:	e710                	sd	a2,8(a4)
        for (int i = idx; i < q->size - 1; i++) {
    80005e9a:	0721                	addi	a4,a4,8
    80005e9c:	ff15e9e3          	bltu	a1,a7,80005e8e <q_pop_idx+0x2e>
        q->size--;
    80005ea0:	0106a023          	sw	a6,0(a3)
        q->bucket[q->size] = 0; // Clear the last element
    80005ea4:	02081793          	slli	a5,a6,0x20
    80005ea8:	9381                	srli	a5,a5,0x20
    80005eaa:	078e                	slli	a5,a5,0x3
    80005eac:	96be                	add	a3,a3,a5
    80005eae:	0006b423          	sd	zero,8(a3)
        return element;
    80005eb2:	a011                	j	80005eb6 <q_pop_idx+0x56>
    return 0; // Failure or invalid index
    80005eb4:	4501                	li	a0,0
}
    80005eb6:	6422                	ld	s0,8(sp)
    80005eb8:	0141                	addi	sp,sp,16
    80005eba:	8082                	ret

0000000080005ebc <q_empty>:

int q_empty(queue_t *q){
    80005ebc:	1141                	addi	sp,sp,-16
    80005ebe:	e422                	sd	s0,8(sp)
    80005ec0:	0800                	addi	s0,sp,16
	return q->size == 0;
    80005ec2:	4108                	lw	a0,0(a0)
}
    80005ec4:	00153513          	seqz	a0,a0
    80005ec8:	6422                	ld	s0,8(sp)
    80005eca:	0141                	addi	sp,sp,16
    80005ecc:	8082                	ret

0000000080005ece <q_full>:

int q_full(queue_t *q){
    80005ece:	1141                	addi	sp,sp,-16
    80005ed0:	e422                	sd	s0,8(sp)
    80005ed2:	0800                	addi	s0,sp,16
	return q->size == PG_BUF_SIZE;
    80005ed4:	4108                	lw	a0,0(a0)
    80005ed6:	1561                	addi	a0,a0,-8
}
    80005ed8:	00153513          	seqz	a0,a0
    80005edc:	6422                	ld	s0,8(sp)
    80005ede:	0141                	addi	sp,sp,16
    80005ee0:	8082                	ret

0000000080005ee2 <q_clear>:

int q_clear(queue_t *q){
    80005ee2:	1141                	addi	sp,sp,-16
    80005ee4:	e422                	sd	s0,8(sp)
    80005ee6:	0800                	addi	s0,sp,16
	q->size = 0;
    80005ee8:	00052023          	sw	zero,0(a0)
    for (int i = 0; i < PG_BUF_SIZE; i++) {
        q->bucket[i] = 0;
    80005eec:	00053423          	sd	zero,8(a0)
    80005ef0:	00053823          	sd	zero,16(a0)
    80005ef4:	00053c23          	sd	zero,24(a0)
    80005ef8:	02053023          	sd	zero,32(a0)
    80005efc:	02053423          	sd	zero,40(a0)
    80005f00:	02053823          	sd	zero,48(a0)
    80005f04:	02053c23          	sd	zero,56(a0)
    80005f08:	04053023          	sd	zero,64(a0)
    }
    return 1; // Indicate success
}
    80005f0c:	4505                	li	a0,1
    80005f0e:	6422                	ld	s0,8(sp)
    80005f10:	0141                	addi	sp,sp,16
    80005f12:	8082                	ret

0000000080005f14 <q_find>:

int q_find(queue_t *q, uint64 e){
    80005f14:	1141                	addi	sp,sp,-16
    80005f16:	e422                	sd	s0,8(sp)
    80005f18:	0800                	addi	s0,sp,16
	for (int i = 0; i < q->size; i++) {
    80005f1a:	4114                	lw	a3,0(a0)
    80005f1c:	c285                	beqz	a3,80005f3c <q_find+0x28>
    80005f1e:	00850793          	addi	a5,a0,8
    80005f22:	2681                	sext.w	a3,a3
    80005f24:	4501                	li	a0,0
        if (q->bucket[i] == e) {
    80005f26:	6398                	ld	a4,0(a5)
    80005f28:	00b70763          	beq	a4,a1,80005f36 <q_find+0x22>
	for (int i = 0; i < q->size; i++) {
    80005f2c:	2505                	addiw	a0,a0,1
    80005f2e:	07a1                	addi	a5,a5,8
    80005f30:	fed51be3          	bne	a0,a3,80005f26 <q_find+0x12>
            return i;
        }
    }
    return -1; // Element not found
    80005f34:	557d                	li	a0,-1
}
    80005f36:	6422                	ld	s0,8(sp)
    80005f38:	0141                	addi	sp,sp,16
    80005f3a:	8082                	ret
    return -1; // Element not found
    80005f3c:	557d                	li	a0,-1
    80005f3e:	bfe5                	j	80005f36 <q_find+0x22>

0000000080005f40 <timerinit>:
// which arrive at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    80005f40:	1141                	addi	sp,sp,-16
    80005f42:	e422                	sd	s0,8(sp)
    80005f44:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005f46:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    80005f4a:	0007869b          	sext.w	a3,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    80005f4e:	0037979b          	slliw	a5,a5,0x3
    80005f52:	02004737          	lui	a4,0x2004
    80005f56:	97ba                	add	a5,a5,a4
    80005f58:	0200c737          	lui	a4,0x200c
    80005f5c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005f60:	000f4637          	lui	a2,0xf4
    80005f64:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005f68:	95b2                	add	a1,a1,a2
    80005f6a:	e38c                	sd	a1,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    80005f6c:	00269713          	slli	a4,a3,0x2
    80005f70:	9736                	add	a4,a4,a3
    80005f72:	00371693          	slli	a3,a4,0x3
    80005f76:	00018717          	auipc	a4,0x18
    80005f7a:	08a70713          	addi	a4,a4,138 # 8001e000 <timer_scratch>
    80005f7e:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    80005f80:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    80005f82:	f310                	sd	a2,32(a4)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    80005f84:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    80005f88:	fffff797          	auipc	a5,0xfffff
    80005f8c:	6a878793          	addi	a5,a5,1704 # 80005630 <timervec>
    80005f90:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005f94:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80005f98:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005f9c:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    80005fa0:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80005fa4:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    80005fa8:	30479073          	csrw	mie,a5
}
    80005fac:	6422                	ld	s0,8(sp)
    80005fae:	0141                	addi	sp,sp,16
    80005fb0:	8082                	ret

0000000080005fb2 <start>:
{
    80005fb2:	1141                	addi	sp,sp,-16
    80005fb4:	e406                	sd	ra,8(sp)
    80005fb6:	e022                	sd	s0,0(sp)
    80005fb8:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005fba:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80005fbe:	7779                	lui	a4,0xffffe
    80005fc0:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffd85bf>
    80005fc4:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    80005fc6:	6705                	lui	a4,0x1
    80005fc8:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005fcc:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005fce:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    80005fd2:	ffffa797          	auipc	a5,0xffffa
    80005fd6:	35478793          	addi	a5,a5,852 # 80000326 <main>
    80005fda:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    80005fde:	4781                	li	a5,0
    80005fe0:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80005fe4:	67c1                	lui	a5,0x10
    80005fe6:	17fd                	addi	a5,a5,-1
    80005fe8:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80005fec:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80005ff0:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80005ff4:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80005ff8:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    80005ffc:	57fd                	li	a5,-1
    80005ffe:	83a9                	srli	a5,a5,0xa
    80006000:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80006004:	47bd                	li	a5,15
    80006006:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    8000600a:	00000097          	auipc	ra,0x0
    8000600e:	f36080e7          	jalr	-202(ra) # 80005f40 <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80006012:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    80006016:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    80006018:	823e                	mv	tp,a5
  asm volatile("mret");
    8000601a:	30200073          	mret
}
    8000601e:	60a2                	ld	ra,8(sp)
    80006020:	6402                	ld	s0,0(sp)
    80006022:	0141                	addi	sp,sp,16
    80006024:	8082                	ret

0000000080006026 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80006026:	715d                	addi	sp,sp,-80
    80006028:	e486                	sd	ra,72(sp)
    8000602a:	e0a2                	sd	s0,64(sp)
    8000602c:	fc26                	sd	s1,56(sp)
    8000602e:	f84a                	sd	s2,48(sp)
    80006030:	f44e                	sd	s3,40(sp)
    80006032:	f052                	sd	s4,32(sp)
    80006034:	ec56                	sd	s5,24(sp)
    80006036:	0880                	addi	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    80006038:	04c05663          	blez	a2,80006084 <consolewrite+0x5e>
    8000603c:	8a2a                	mv	s4,a0
    8000603e:	84ae                	mv	s1,a1
    80006040:	89b2                	mv	s3,a2
    80006042:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80006044:	5afd                	li	s5,-1
    80006046:	4685                	li	a3,1
    80006048:	8626                	mv	a2,s1
    8000604a:	85d2                	mv	a1,s4
    8000604c:	fbf40513          	addi	a0,s0,-65
    80006050:	ffffc097          	auipc	ra,0xffffc
    80006054:	cc6080e7          	jalr	-826(ra) # 80001d16 <either_copyin>
    80006058:	01550c63          	beq	a0,s5,80006070 <consolewrite+0x4a>
      break;
    uartputc(c);
    8000605c:	fbf44503          	lbu	a0,-65(s0)
    80006060:	00000097          	auipc	ra,0x0
    80006064:	78e080e7          	jalr	1934(ra) # 800067ee <uartputc>
  for(i = 0; i < n; i++){
    80006068:	2905                	addiw	s2,s2,1
    8000606a:	0485                	addi	s1,s1,1
    8000606c:	fd299de3          	bne	s3,s2,80006046 <consolewrite+0x20>
  }

  return i;
}
    80006070:	854a                	mv	a0,s2
    80006072:	60a6                	ld	ra,72(sp)
    80006074:	6406                	ld	s0,64(sp)
    80006076:	74e2                	ld	s1,56(sp)
    80006078:	7942                	ld	s2,48(sp)
    8000607a:	79a2                	ld	s3,40(sp)
    8000607c:	7a02                	ld	s4,32(sp)
    8000607e:	6ae2                	ld	s5,24(sp)
    80006080:	6161                	addi	sp,sp,80
    80006082:	8082                	ret
  for(i = 0; i < n; i++){
    80006084:	4901                	li	s2,0
    80006086:	b7ed                	j	80006070 <consolewrite+0x4a>

0000000080006088 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80006088:	7119                	addi	sp,sp,-128
    8000608a:	fc86                	sd	ra,120(sp)
    8000608c:	f8a2                	sd	s0,112(sp)
    8000608e:	f4a6                	sd	s1,104(sp)
    80006090:	f0ca                	sd	s2,96(sp)
    80006092:	ecce                	sd	s3,88(sp)
    80006094:	e8d2                	sd	s4,80(sp)
    80006096:	e4d6                	sd	s5,72(sp)
    80006098:	e0da                	sd	s6,64(sp)
    8000609a:	fc5e                	sd	s7,56(sp)
    8000609c:	f862                	sd	s8,48(sp)
    8000609e:	f466                	sd	s9,40(sp)
    800060a0:	f06a                	sd	s10,32(sp)
    800060a2:	ec6e                	sd	s11,24(sp)
    800060a4:	0100                	addi	s0,sp,128
    800060a6:	8b2a                	mv	s6,a0
    800060a8:	8aae                	mv	s5,a1
    800060aa:	8a32                	mv	s4,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    800060ac:	00060b9b          	sext.w	s7,a2
  acquire(&cons.lock);
    800060b0:	00020517          	auipc	a0,0x20
    800060b4:	09050513          	addi	a0,a0,144 # 80026140 <cons>
    800060b8:	00001097          	auipc	ra,0x1
    800060bc:	8f4080e7          	jalr	-1804(ra) # 800069ac <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    800060c0:	00020497          	auipc	s1,0x20
    800060c4:	08048493          	addi	s1,s1,128 # 80026140 <cons>
      if(myproc()->killed){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    800060c8:	89a6                	mv	s3,s1
    800060ca:	00020917          	auipc	s2,0x20
    800060ce:	10e90913          	addi	s2,s2,270 # 800261d8 <cons+0x98>
    }

    c = cons.buf[cons.r++ % INPUT_BUF];

    if(c == C('D')){  // end-of-file
    800060d2:	4c91                	li	s9,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    800060d4:	5d7d                	li	s10,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    800060d6:	4da9                	li	s11,10
  while(n > 0){
    800060d8:	07405863          	blez	s4,80006148 <consoleread+0xc0>
    while(cons.r == cons.w){
    800060dc:	0984a783          	lw	a5,152(s1)
    800060e0:	09c4a703          	lw	a4,156(s1)
    800060e4:	02f71463          	bne	a4,a5,8000610c <consoleread+0x84>
      if(myproc()->killed){
    800060e8:	ffffb097          	auipc	ra,0xffffb
    800060ec:	178080e7          	jalr	376(ra) # 80001260 <myproc>
    800060f0:	551c                	lw	a5,40(a0)
    800060f2:	e7b5                	bnez	a5,8000615e <consoleread+0xd6>
      sleep(&cons.r, &cons.lock);
    800060f4:	85ce                	mv	a1,s3
    800060f6:	854a                	mv	a0,s2
    800060f8:	ffffc097          	auipc	ra,0xffffc
    800060fc:	824080e7          	jalr	-2012(ra) # 8000191c <sleep>
    while(cons.r == cons.w){
    80006100:	0984a783          	lw	a5,152(s1)
    80006104:	09c4a703          	lw	a4,156(s1)
    80006108:	fef700e3          	beq	a4,a5,800060e8 <consoleread+0x60>
    c = cons.buf[cons.r++ % INPUT_BUF];
    8000610c:	0017871b          	addiw	a4,a5,1
    80006110:	08e4ac23          	sw	a4,152(s1)
    80006114:	07f7f713          	andi	a4,a5,127
    80006118:	9726                	add	a4,a4,s1
    8000611a:	01874703          	lbu	a4,24(a4)
    8000611e:	00070c1b          	sext.w	s8,a4
    if(c == C('D')){  // end-of-file
    80006122:	079c0663          	beq	s8,s9,8000618e <consoleread+0x106>
    cbuf = c;
    80006126:	f8e407a3          	sb	a4,-113(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    8000612a:	4685                	li	a3,1
    8000612c:	f8f40613          	addi	a2,s0,-113
    80006130:	85d6                	mv	a1,s5
    80006132:	855a                	mv	a0,s6
    80006134:	ffffc097          	auipc	ra,0xffffc
    80006138:	b8c080e7          	jalr	-1140(ra) # 80001cc0 <either_copyout>
    8000613c:	01a50663          	beq	a0,s10,80006148 <consoleread+0xc0>
    dst++;
    80006140:	0a85                	addi	s5,s5,1
    --n;
    80006142:	3a7d                	addiw	s4,s4,-1
    if(c == '\n'){
    80006144:	f9bc1ae3          	bne	s8,s11,800060d8 <consoleread+0x50>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80006148:	00020517          	auipc	a0,0x20
    8000614c:	ff850513          	addi	a0,a0,-8 # 80026140 <cons>
    80006150:	00001097          	auipc	ra,0x1
    80006154:	910080e7          	jalr	-1776(ra) # 80006a60 <release>

  return target - n;
    80006158:	414b853b          	subw	a0,s7,s4
    8000615c:	a811                	j	80006170 <consoleread+0xe8>
        release(&cons.lock);
    8000615e:	00020517          	auipc	a0,0x20
    80006162:	fe250513          	addi	a0,a0,-30 # 80026140 <cons>
    80006166:	00001097          	auipc	ra,0x1
    8000616a:	8fa080e7          	jalr	-1798(ra) # 80006a60 <release>
        return -1;
    8000616e:	557d                	li	a0,-1
}
    80006170:	70e6                	ld	ra,120(sp)
    80006172:	7446                	ld	s0,112(sp)
    80006174:	74a6                	ld	s1,104(sp)
    80006176:	7906                	ld	s2,96(sp)
    80006178:	69e6                	ld	s3,88(sp)
    8000617a:	6a46                	ld	s4,80(sp)
    8000617c:	6aa6                	ld	s5,72(sp)
    8000617e:	6b06                	ld	s6,64(sp)
    80006180:	7be2                	ld	s7,56(sp)
    80006182:	7c42                	ld	s8,48(sp)
    80006184:	7ca2                	ld	s9,40(sp)
    80006186:	7d02                	ld	s10,32(sp)
    80006188:	6de2                	ld	s11,24(sp)
    8000618a:	6109                	addi	sp,sp,128
    8000618c:	8082                	ret
      if(n < target){
    8000618e:	000a071b          	sext.w	a4,s4
    80006192:	fb777be3          	bgeu	a4,s7,80006148 <consoleread+0xc0>
        cons.r--;
    80006196:	00020717          	auipc	a4,0x20
    8000619a:	04f72123          	sw	a5,66(a4) # 800261d8 <cons+0x98>
    8000619e:	b76d                	j	80006148 <consoleread+0xc0>

00000000800061a0 <consputc>:
{
    800061a0:	1141                	addi	sp,sp,-16
    800061a2:	e406                	sd	ra,8(sp)
    800061a4:	e022                	sd	s0,0(sp)
    800061a6:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    800061a8:	10000793          	li	a5,256
    800061ac:	00f50a63          	beq	a0,a5,800061c0 <consputc+0x20>
    uartputc_sync(c);
    800061b0:	00000097          	auipc	ra,0x0
    800061b4:	564080e7          	jalr	1380(ra) # 80006714 <uartputc_sync>
}
    800061b8:	60a2                	ld	ra,8(sp)
    800061ba:	6402                	ld	s0,0(sp)
    800061bc:	0141                	addi	sp,sp,16
    800061be:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    800061c0:	4521                	li	a0,8
    800061c2:	00000097          	auipc	ra,0x0
    800061c6:	552080e7          	jalr	1362(ra) # 80006714 <uartputc_sync>
    800061ca:	02000513          	li	a0,32
    800061ce:	00000097          	auipc	ra,0x0
    800061d2:	546080e7          	jalr	1350(ra) # 80006714 <uartputc_sync>
    800061d6:	4521                	li	a0,8
    800061d8:	00000097          	auipc	ra,0x0
    800061dc:	53c080e7          	jalr	1340(ra) # 80006714 <uartputc_sync>
    800061e0:	bfe1                	j	800061b8 <consputc+0x18>

00000000800061e2 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800061e2:	1101                	addi	sp,sp,-32
    800061e4:	ec06                	sd	ra,24(sp)
    800061e6:	e822                	sd	s0,16(sp)
    800061e8:	e426                	sd	s1,8(sp)
    800061ea:	e04a                	sd	s2,0(sp)
    800061ec:	1000                	addi	s0,sp,32
    800061ee:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    800061f0:	00020517          	auipc	a0,0x20
    800061f4:	f5050513          	addi	a0,a0,-176 # 80026140 <cons>
    800061f8:	00000097          	auipc	ra,0x0
    800061fc:	7b4080e7          	jalr	1972(ra) # 800069ac <acquire>

  switch(c){
    80006200:	47d5                	li	a5,21
    80006202:	0af48663          	beq	s1,a5,800062ae <consoleintr+0xcc>
    80006206:	0297ca63          	blt	a5,s1,8000623a <consoleintr+0x58>
    8000620a:	47a1                	li	a5,8
    8000620c:	0ef48763          	beq	s1,a5,800062fa <consoleintr+0x118>
    80006210:	47c1                	li	a5,16
    80006212:	10f49a63          	bne	s1,a5,80006326 <consoleintr+0x144>
  case C('P'):  // Print process list.
    procdump();
    80006216:	ffffc097          	auipc	ra,0xffffc
    8000621a:	b56080e7          	jalr	-1194(ra) # 80001d6c <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    8000621e:	00020517          	auipc	a0,0x20
    80006222:	f2250513          	addi	a0,a0,-222 # 80026140 <cons>
    80006226:	00001097          	auipc	ra,0x1
    8000622a:	83a080e7          	jalr	-1990(ra) # 80006a60 <release>
}
    8000622e:	60e2                	ld	ra,24(sp)
    80006230:	6442                	ld	s0,16(sp)
    80006232:	64a2                	ld	s1,8(sp)
    80006234:	6902                	ld	s2,0(sp)
    80006236:	6105                	addi	sp,sp,32
    80006238:	8082                	ret
  switch(c){
    8000623a:	07f00793          	li	a5,127
    8000623e:	0af48e63          	beq	s1,a5,800062fa <consoleintr+0x118>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80006242:	00020717          	auipc	a4,0x20
    80006246:	efe70713          	addi	a4,a4,-258 # 80026140 <cons>
    8000624a:	0a072783          	lw	a5,160(a4)
    8000624e:	09872703          	lw	a4,152(a4)
    80006252:	9f99                	subw	a5,a5,a4
    80006254:	07f00713          	li	a4,127
    80006258:	fcf763e3          	bltu	a4,a5,8000621e <consoleintr+0x3c>
      c = (c == '\r') ? '\n' : c;
    8000625c:	47b5                	li	a5,13
    8000625e:	0cf48763          	beq	s1,a5,8000632c <consoleintr+0x14a>
      consputc(c);
    80006262:	8526                	mv	a0,s1
    80006264:	00000097          	auipc	ra,0x0
    80006268:	f3c080e7          	jalr	-196(ra) # 800061a0 <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    8000626c:	00020797          	auipc	a5,0x20
    80006270:	ed478793          	addi	a5,a5,-300 # 80026140 <cons>
    80006274:	0a07a703          	lw	a4,160(a5)
    80006278:	0017069b          	addiw	a3,a4,1
    8000627c:	0006861b          	sext.w	a2,a3
    80006280:	0ad7a023          	sw	a3,160(a5)
    80006284:	07f77713          	andi	a4,a4,127
    80006288:	97ba                	add	a5,a5,a4
    8000628a:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    8000628e:	47a9                	li	a5,10
    80006290:	0cf48563          	beq	s1,a5,8000635a <consoleintr+0x178>
    80006294:	4791                	li	a5,4
    80006296:	0cf48263          	beq	s1,a5,8000635a <consoleintr+0x178>
    8000629a:	00020797          	auipc	a5,0x20
    8000629e:	f3e7a783          	lw	a5,-194(a5) # 800261d8 <cons+0x98>
    800062a2:	0807879b          	addiw	a5,a5,128
    800062a6:	f6f61ce3          	bne	a2,a5,8000621e <consoleintr+0x3c>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    800062aa:	863e                	mv	a2,a5
    800062ac:	a07d                	j	8000635a <consoleintr+0x178>
    while(cons.e != cons.w &&
    800062ae:	00020717          	auipc	a4,0x20
    800062b2:	e9270713          	addi	a4,a4,-366 # 80026140 <cons>
    800062b6:	0a072783          	lw	a5,160(a4)
    800062ba:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    800062be:	00020497          	auipc	s1,0x20
    800062c2:	e8248493          	addi	s1,s1,-382 # 80026140 <cons>
    while(cons.e != cons.w &&
    800062c6:	4929                	li	s2,10
    800062c8:	f4f70be3          	beq	a4,a5,8000621e <consoleintr+0x3c>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    800062cc:	37fd                	addiw	a5,a5,-1
    800062ce:	07f7f713          	andi	a4,a5,127
    800062d2:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    800062d4:	01874703          	lbu	a4,24(a4)
    800062d8:	f52703e3          	beq	a4,s2,8000621e <consoleintr+0x3c>
      cons.e--;
    800062dc:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    800062e0:	10000513          	li	a0,256
    800062e4:	00000097          	auipc	ra,0x0
    800062e8:	ebc080e7          	jalr	-324(ra) # 800061a0 <consputc>
    while(cons.e != cons.w &&
    800062ec:	0a04a783          	lw	a5,160(s1)
    800062f0:	09c4a703          	lw	a4,156(s1)
    800062f4:	fcf71ce3          	bne	a4,a5,800062cc <consoleintr+0xea>
    800062f8:	b71d                	j	8000621e <consoleintr+0x3c>
    if(cons.e != cons.w){
    800062fa:	00020717          	auipc	a4,0x20
    800062fe:	e4670713          	addi	a4,a4,-442 # 80026140 <cons>
    80006302:	0a072783          	lw	a5,160(a4)
    80006306:	09c72703          	lw	a4,156(a4)
    8000630a:	f0f70ae3          	beq	a4,a5,8000621e <consoleintr+0x3c>
      cons.e--;
    8000630e:	37fd                	addiw	a5,a5,-1
    80006310:	00020717          	auipc	a4,0x20
    80006314:	ecf72823          	sw	a5,-304(a4) # 800261e0 <cons+0xa0>
      consputc(BACKSPACE);
    80006318:	10000513          	li	a0,256
    8000631c:	00000097          	auipc	ra,0x0
    80006320:	e84080e7          	jalr	-380(ra) # 800061a0 <consputc>
    80006324:	bded                	j	8000621e <consoleintr+0x3c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80006326:	ee048ce3          	beqz	s1,8000621e <consoleintr+0x3c>
    8000632a:	bf21                	j	80006242 <consoleintr+0x60>
      consputc(c);
    8000632c:	4529                	li	a0,10
    8000632e:	00000097          	auipc	ra,0x0
    80006332:	e72080e7          	jalr	-398(ra) # 800061a0 <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80006336:	00020797          	auipc	a5,0x20
    8000633a:	e0a78793          	addi	a5,a5,-502 # 80026140 <cons>
    8000633e:	0a07a703          	lw	a4,160(a5)
    80006342:	0017069b          	addiw	a3,a4,1
    80006346:	0006861b          	sext.w	a2,a3
    8000634a:	0ad7a023          	sw	a3,160(a5)
    8000634e:	07f77713          	andi	a4,a4,127
    80006352:	97ba                	add	a5,a5,a4
    80006354:	4729                	li	a4,10
    80006356:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    8000635a:	00020797          	auipc	a5,0x20
    8000635e:	e8c7a123          	sw	a2,-382(a5) # 800261dc <cons+0x9c>
        wakeup(&cons.r);
    80006362:	00020517          	auipc	a0,0x20
    80006366:	e7650513          	addi	a0,a0,-394 # 800261d8 <cons+0x98>
    8000636a:	ffffb097          	auipc	ra,0xffffb
    8000636e:	73e080e7          	jalr	1854(ra) # 80001aa8 <wakeup>
    80006372:	b575                	j	8000621e <consoleintr+0x3c>

0000000080006374 <consoleinit>:

void
consoleinit(void)
{
    80006374:	1141                	addi	sp,sp,-16
    80006376:	e406                	sd	ra,8(sp)
    80006378:	e022                	sd	s0,0(sp)
    8000637a:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    8000637c:	00002597          	auipc	a1,0x2
    80006380:	61458593          	addi	a1,a1,1556 # 80008990 <syscalls+0x510>
    80006384:	00020517          	auipc	a0,0x20
    80006388:	dbc50513          	addi	a0,a0,-580 # 80026140 <cons>
    8000638c:	00000097          	auipc	ra,0x0
    80006390:	590080e7          	jalr	1424(ra) # 8000691c <initlock>

  uartinit();
    80006394:	00000097          	auipc	ra,0x0
    80006398:	330080e7          	jalr	816(ra) # 800066c4 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    8000639c:	00013797          	auipc	a5,0x13
    800063a0:	d2c78793          	addi	a5,a5,-724 # 800190c8 <devsw>
    800063a4:	00000717          	auipc	a4,0x0
    800063a8:	ce470713          	addi	a4,a4,-796 # 80006088 <consoleread>
    800063ac:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    800063ae:	00000717          	auipc	a4,0x0
    800063b2:	c7870713          	addi	a4,a4,-904 # 80006026 <consolewrite>
    800063b6:	ef98                	sd	a4,24(a5)
}
    800063b8:	60a2                	ld	ra,8(sp)
    800063ba:	6402                	ld	s0,0(sp)
    800063bc:	0141                	addi	sp,sp,16
    800063be:	8082                	ret

00000000800063c0 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    800063c0:	7179                	addi	sp,sp,-48
    800063c2:	f406                	sd	ra,40(sp)
    800063c4:	f022                	sd	s0,32(sp)
    800063c6:	ec26                	sd	s1,24(sp)
    800063c8:	e84a                	sd	s2,16(sp)
    800063ca:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    800063cc:	c219                	beqz	a2,800063d2 <printint+0x12>
    800063ce:	08054663          	bltz	a0,8000645a <printint+0x9a>
    x = -xx;
  else
    x = xx;
    800063d2:	2501                	sext.w	a0,a0
    800063d4:	4881                	li	a7,0
    800063d6:	fd040693          	addi	a3,s0,-48

  i = 0;
    800063da:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    800063dc:	2581                	sext.w	a1,a1
    800063de:	00002617          	auipc	a2,0x2
    800063e2:	5e260613          	addi	a2,a2,1506 # 800089c0 <digits>
    800063e6:	883a                	mv	a6,a4
    800063e8:	2705                	addiw	a4,a4,1
    800063ea:	02b577bb          	remuw	a5,a0,a1
    800063ee:	1782                	slli	a5,a5,0x20
    800063f0:	9381                	srli	a5,a5,0x20
    800063f2:	97b2                	add	a5,a5,a2
    800063f4:	0007c783          	lbu	a5,0(a5)
    800063f8:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    800063fc:	0005079b          	sext.w	a5,a0
    80006400:	02b5553b          	divuw	a0,a0,a1
    80006404:	0685                	addi	a3,a3,1
    80006406:	feb7f0e3          	bgeu	a5,a1,800063e6 <printint+0x26>

  if(sign)
    8000640a:	00088b63          	beqz	a7,80006420 <printint+0x60>
    buf[i++] = '-';
    8000640e:	fe040793          	addi	a5,s0,-32
    80006412:	973e                	add	a4,a4,a5
    80006414:	02d00793          	li	a5,45
    80006418:	fef70823          	sb	a5,-16(a4)
    8000641c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    80006420:	02e05763          	blez	a4,8000644e <printint+0x8e>
    80006424:	fd040793          	addi	a5,s0,-48
    80006428:	00e784b3          	add	s1,a5,a4
    8000642c:	fff78913          	addi	s2,a5,-1
    80006430:	993a                	add	s2,s2,a4
    80006432:	377d                	addiw	a4,a4,-1
    80006434:	1702                	slli	a4,a4,0x20
    80006436:	9301                	srli	a4,a4,0x20
    80006438:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    8000643c:	fff4c503          	lbu	a0,-1(s1)
    80006440:	00000097          	auipc	ra,0x0
    80006444:	d60080e7          	jalr	-672(ra) # 800061a0 <consputc>
  while(--i >= 0)
    80006448:	14fd                	addi	s1,s1,-1
    8000644a:	ff2499e3          	bne	s1,s2,8000643c <printint+0x7c>
}
    8000644e:	70a2                	ld	ra,40(sp)
    80006450:	7402                	ld	s0,32(sp)
    80006452:	64e2                	ld	s1,24(sp)
    80006454:	6942                	ld	s2,16(sp)
    80006456:	6145                	addi	sp,sp,48
    80006458:	8082                	ret
    x = -xx;
    8000645a:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    8000645e:	4885                	li	a7,1
    x = -xx;
    80006460:	bf9d                	j	800063d6 <printint+0x16>

0000000080006462 <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    80006462:	1101                	addi	sp,sp,-32
    80006464:	ec06                	sd	ra,24(sp)
    80006466:	e822                	sd	s0,16(sp)
    80006468:	e426                	sd	s1,8(sp)
    8000646a:	1000                	addi	s0,sp,32
    8000646c:	84aa                	mv	s1,a0
  pr.locking = 0;
    8000646e:	00020797          	auipc	a5,0x20
    80006472:	d807a923          	sw	zero,-622(a5) # 80026200 <pr+0x18>
  printf("panic: ");
    80006476:	00002517          	auipc	a0,0x2
    8000647a:	52250513          	addi	a0,a0,1314 # 80008998 <syscalls+0x518>
    8000647e:	00000097          	auipc	ra,0x0
    80006482:	02e080e7          	jalr	46(ra) # 800064ac <printf>
  printf(s);
    80006486:	8526                	mv	a0,s1
    80006488:	00000097          	auipc	ra,0x0
    8000648c:	024080e7          	jalr	36(ra) # 800064ac <printf>
  printf("\n");
    80006490:	00002517          	auipc	a0,0x2
    80006494:	bb850513          	addi	a0,a0,-1096 # 80008048 <etext+0x48>
    80006498:	00000097          	auipc	ra,0x0
    8000649c:	014080e7          	jalr	20(ra) # 800064ac <printf>
  panicked = 1; // freeze uart output from other CPUs
    800064a0:	4785                	li	a5,1
    800064a2:	00003717          	auipc	a4,0x3
    800064a6:	b6f72d23          	sw	a5,-1158(a4) # 8000901c <panicked>
  for(;;)
    800064aa:	a001                	j	800064aa <panic+0x48>

00000000800064ac <printf>:
{
    800064ac:	7131                	addi	sp,sp,-192
    800064ae:	fc86                	sd	ra,120(sp)
    800064b0:	f8a2                	sd	s0,112(sp)
    800064b2:	f4a6                	sd	s1,104(sp)
    800064b4:	f0ca                	sd	s2,96(sp)
    800064b6:	ecce                	sd	s3,88(sp)
    800064b8:	e8d2                	sd	s4,80(sp)
    800064ba:	e4d6                	sd	s5,72(sp)
    800064bc:	e0da                	sd	s6,64(sp)
    800064be:	fc5e                	sd	s7,56(sp)
    800064c0:	f862                	sd	s8,48(sp)
    800064c2:	f466                	sd	s9,40(sp)
    800064c4:	f06a                	sd	s10,32(sp)
    800064c6:	ec6e                	sd	s11,24(sp)
    800064c8:	0100                	addi	s0,sp,128
    800064ca:	8a2a                	mv	s4,a0
    800064cc:	e40c                	sd	a1,8(s0)
    800064ce:	e810                	sd	a2,16(s0)
    800064d0:	ec14                	sd	a3,24(s0)
    800064d2:	f018                	sd	a4,32(s0)
    800064d4:	f41c                	sd	a5,40(s0)
    800064d6:	03043823          	sd	a6,48(s0)
    800064da:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    800064de:	00020d97          	auipc	s11,0x20
    800064e2:	d22dad83          	lw	s11,-734(s11) # 80026200 <pr+0x18>
  if(locking)
    800064e6:	020d9b63          	bnez	s11,8000651c <printf+0x70>
  if (fmt == 0)
    800064ea:	040a0263          	beqz	s4,8000652e <printf+0x82>
  va_start(ap, fmt);
    800064ee:	00840793          	addi	a5,s0,8
    800064f2:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    800064f6:	000a4503          	lbu	a0,0(s4)
    800064fa:	16050263          	beqz	a0,8000665e <printf+0x1b2>
    800064fe:	4481                	li	s1,0
    if(c != '%'){
    80006500:	02500a93          	li	s5,37
    switch(c){
    80006504:	07000b13          	li	s6,112
  consputc('x');
    80006508:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    8000650a:	00002b97          	auipc	s7,0x2
    8000650e:	4b6b8b93          	addi	s7,s7,1206 # 800089c0 <digits>
    switch(c){
    80006512:	07300c93          	li	s9,115
    80006516:	06400c13          	li	s8,100
    8000651a:	a82d                	j	80006554 <printf+0xa8>
    acquire(&pr.lock);
    8000651c:	00020517          	auipc	a0,0x20
    80006520:	ccc50513          	addi	a0,a0,-820 # 800261e8 <pr>
    80006524:	00000097          	auipc	ra,0x0
    80006528:	488080e7          	jalr	1160(ra) # 800069ac <acquire>
    8000652c:	bf7d                	j	800064ea <printf+0x3e>
    panic("null fmt");
    8000652e:	00002517          	auipc	a0,0x2
    80006532:	47a50513          	addi	a0,a0,1146 # 800089a8 <syscalls+0x528>
    80006536:	00000097          	auipc	ra,0x0
    8000653a:	f2c080e7          	jalr	-212(ra) # 80006462 <panic>
      consputc(c);
    8000653e:	00000097          	auipc	ra,0x0
    80006542:	c62080e7          	jalr	-926(ra) # 800061a0 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80006546:	2485                	addiw	s1,s1,1
    80006548:	009a07b3          	add	a5,s4,s1
    8000654c:	0007c503          	lbu	a0,0(a5)
    80006550:	10050763          	beqz	a0,8000665e <printf+0x1b2>
    if(c != '%'){
    80006554:	ff5515e3          	bne	a0,s5,8000653e <printf+0x92>
    c = fmt[++i] & 0xff;
    80006558:	2485                	addiw	s1,s1,1
    8000655a:	009a07b3          	add	a5,s4,s1
    8000655e:	0007c783          	lbu	a5,0(a5)
    80006562:	0007891b          	sext.w	s2,a5
    if(c == 0)
    80006566:	cfe5                	beqz	a5,8000665e <printf+0x1b2>
    switch(c){
    80006568:	05678a63          	beq	a5,s6,800065bc <printf+0x110>
    8000656c:	02fb7663          	bgeu	s6,a5,80006598 <printf+0xec>
    80006570:	09978963          	beq	a5,s9,80006602 <printf+0x156>
    80006574:	07800713          	li	a4,120
    80006578:	0ce79863          	bne	a5,a4,80006648 <printf+0x19c>
      printint(va_arg(ap, int), 16, 1);
    8000657c:	f8843783          	ld	a5,-120(s0)
    80006580:	00878713          	addi	a4,a5,8
    80006584:	f8e43423          	sd	a4,-120(s0)
    80006588:	4605                	li	a2,1
    8000658a:	85ea                	mv	a1,s10
    8000658c:	4388                	lw	a0,0(a5)
    8000658e:	00000097          	auipc	ra,0x0
    80006592:	e32080e7          	jalr	-462(ra) # 800063c0 <printint>
      break;
    80006596:	bf45                	j	80006546 <printf+0x9a>
    switch(c){
    80006598:	0b578263          	beq	a5,s5,8000663c <printf+0x190>
    8000659c:	0b879663          	bne	a5,s8,80006648 <printf+0x19c>
      printint(va_arg(ap, int), 10, 1);
    800065a0:	f8843783          	ld	a5,-120(s0)
    800065a4:	00878713          	addi	a4,a5,8
    800065a8:	f8e43423          	sd	a4,-120(s0)
    800065ac:	4605                	li	a2,1
    800065ae:	45a9                	li	a1,10
    800065b0:	4388                	lw	a0,0(a5)
    800065b2:	00000097          	auipc	ra,0x0
    800065b6:	e0e080e7          	jalr	-498(ra) # 800063c0 <printint>
      break;
    800065ba:	b771                	j	80006546 <printf+0x9a>
      printptr(va_arg(ap, uint64));
    800065bc:	f8843783          	ld	a5,-120(s0)
    800065c0:	00878713          	addi	a4,a5,8
    800065c4:	f8e43423          	sd	a4,-120(s0)
    800065c8:	0007b983          	ld	s3,0(a5)
  consputc('0');
    800065cc:	03000513          	li	a0,48
    800065d0:	00000097          	auipc	ra,0x0
    800065d4:	bd0080e7          	jalr	-1072(ra) # 800061a0 <consputc>
  consputc('x');
    800065d8:	07800513          	li	a0,120
    800065dc:	00000097          	auipc	ra,0x0
    800065e0:	bc4080e7          	jalr	-1084(ra) # 800061a0 <consputc>
    800065e4:	896a                	mv	s2,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800065e6:	03c9d793          	srli	a5,s3,0x3c
    800065ea:	97de                	add	a5,a5,s7
    800065ec:	0007c503          	lbu	a0,0(a5)
    800065f0:	00000097          	auipc	ra,0x0
    800065f4:	bb0080e7          	jalr	-1104(ra) # 800061a0 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800065f8:	0992                	slli	s3,s3,0x4
    800065fa:	397d                	addiw	s2,s2,-1
    800065fc:	fe0915e3          	bnez	s2,800065e6 <printf+0x13a>
    80006600:	b799                	j	80006546 <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    80006602:	f8843783          	ld	a5,-120(s0)
    80006606:	00878713          	addi	a4,a5,8
    8000660a:	f8e43423          	sd	a4,-120(s0)
    8000660e:	0007b903          	ld	s2,0(a5)
    80006612:	00090e63          	beqz	s2,8000662e <printf+0x182>
      for(; *s; s++)
    80006616:	00094503          	lbu	a0,0(s2)
    8000661a:	d515                	beqz	a0,80006546 <printf+0x9a>
        consputc(*s);
    8000661c:	00000097          	auipc	ra,0x0
    80006620:	b84080e7          	jalr	-1148(ra) # 800061a0 <consputc>
      for(; *s; s++)
    80006624:	0905                	addi	s2,s2,1
    80006626:	00094503          	lbu	a0,0(s2)
    8000662a:	f96d                	bnez	a0,8000661c <printf+0x170>
    8000662c:	bf29                	j	80006546 <printf+0x9a>
        s = "(null)";
    8000662e:	00002917          	auipc	s2,0x2
    80006632:	37290913          	addi	s2,s2,882 # 800089a0 <syscalls+0x520>
      for(; *s; s++)
    80006636:	02800513          	li	a0,40
    8000663a:	b7cd                	j	8000661c <printf+0x170>
      consputc('%');
    8000663c:	8556                	mv	a0,s5
    8000663e:	00000097          	auipc	ra,0x0
    80006642:	b62080e7          	jalr	-1182(ra) # 800061a0 <consputc>
      break;
    80006646:	b701                	j	80006546 <printf+0x9a>
      consputc('%');
    80006648:	8556                	mv	a0,s5
    8000664a:	00000097          	auipc	ra,0x0
    8000664e:	b56080e7          	jalr	-1194(ra) # 800061a0 <consputc>
      consputc(c);
    80006652:	854a                	mv	a0,s2
    80006654:	00000097          	auipc	ra,0x0
    80006658:	b4c080e7          	jalr	-1204(ra) # 800061a0 <consputc>
      break;
    8000665c:	b5ed                	j	80006546 <printf+0x9a>
  if(locking)
    8000665e:	020d9163          	bnez	s11,80006680 <printf+0x1d4>
}
    80006662:	70e6                	ld	ra,120(sp)
    80006664:	7446                	ld	s0,112(sp)
    80006666:	74a6                	ld	s1,104(sp)
    80006668:	7906                	ld	s2,96(sp)
    8000666a:	69e6                	ld	s3,88(sp)
    8000666c:	6a46                	ld	s4,80(sp)
    8000666e:	6aa6                	ld	s5,72(sp)
    80006670:	6b06                	ld	s6,64(sp)
    80006672:	7be2                	ld	s7,56(sp)
    80006674:	7c42                	ld	s8,48(sp)
    80006676:	7ca2                	ld	s9,40(sp)
    80006678:	7d02                	ld	s10,32(sp)
    8000667a:	6de2                	ld	s11,24(sp)
    8000667c:	6129                	addi	sp,sp,192
    8000667e:	8082                	ret
    release(&pr.lock);
    80006680:	00020517          	auipc	a0,0x20
    80006684:	b6850513          	addi	a0,a0,-1176 # 800261e8 <pr>
    80006688:	00000097          	auipc	ra,0x0
    8000668c:	3d8080e7          	jalr	984(ra) # 80006a60 <release>
}
    80006690:	bfc9                	j	80006662 <printf+0x1b6>

0000000080006692 <printfinit>:
    ;
}

void
printfinit(void)
{
    80006692:	1101                	addi	sp,sp,-32
    80006694:	ec06                	sd	ra,24(sp)
    80006696:	e822                	sd	s0,16(sp)
    80006698:	e426                	sd	s1,8(sp)
    8000669a:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    8000669c:	00020497          	auipc	s1,0x20
    800066a0:	b4c48493          	addi	s1,s1,-1204 # 800261e8 <pr>
    800066a4:	00002597          	auipc	a1,0x2
    800066a8:	31458593          	addi	a1,a1,788 # 800089b8 <syscalls+0x538>
    800066ac:	8526                	mv	a0,s1
    800066ae:	00000097          	auipc	ra,0x0
    800066b2:	26e080e7          	jalr	622(ra) # 8000691c <initlock>
  pr.locking = 1;
    800066b6:	4785                	li	a5,1
    800066b8:	cc9c                	sw	a5,24(s1)
}
    800066ba:	60e2                	ld	ra,24(sp)
    800066bc:	6442                	ld	s0,16(sp)
    800066be:	64a2                	ld	s1,8(sp)
    800066c0:	6105                	addi	sp,sp,32
    800066c2:	8082                	ret

00000000800066c4 <uartinit>:

void uartstart();

void
uartinit(void)
{
    800066c4:	1141                	addi	sp,sp,-16
    800066c6:	e406                	sd	ra,8(sp)
    800066c8:	e022                	sd	s0,0(sp)
    800066ca:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    800066cc:	100007b7          	lui	a5,0x10000
    800066d0:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    800066d4:	f8000713          	li	a4,-128
    800066d8:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    800066dc:	470d                	li	a4,3
    800066de:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    800066e2:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    800066e6:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    800066ea:	469d                	li	a3,7
    800066ec:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    800066f0:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    800066f4:	00002597          	auipc	a1,0x2
    800066f8:	2e458593          	addi	a1,a1,740 # 800089d8 <digits+0x18>
    800066fc:	00020517          	auipc	a0,0x20
    80006700:	b0c50513          	addi	a0,a0,-1268 # 80026208 <uart_tx_lock>
    80006704:	00000097          	auipc	ra,0x0
    80006708:	218080e7          	jalr	536(ra) # 8000691c <initlock>
}
    8000670c:	60a2                	ld	ra,8(sp)
    8000670e:	6402                	ld	s0,0(sp)
    80006710:	0141                	addi	sp,sp,16
    80006712:	8082                	ret

0000000080006714 <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    80006714:	1101                	addi	sp,sp,-32
    80006716:	ec06                	sd	ra,24(sp)
    80006718:	e822                	sd	s0,16(sp)
    8000671a:	e426                	sd	s1,8(sp)
    8000671c:	1000                	addi	s0,sp,32
    8000671e:	84aa                	mv	s1,a0
  push_off();
    80006720:	00000097          	auipc	ra,0x0
    80006724:	240080e7          	jalr	576(ra) # 80006960 <push_off>

  if(panicked){
    80006728:	00003797          	auipc	a5,0x3
    8000672c:	8f47a783          	lw	a5,-1804(a5) # 8000901c <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80006730:	10000737          	lui	a4,0x10000
  if(panicked){
    80006734:	c391                	beqz	a5,80006738 <uartputc_sync+0x24>
    for(;;)
    80006736:	a001                	j	80006736 <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80006738:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000673c:	0ff7f793          	andi	a5,a5,255
    80006740:	0207f793          	andi	a5,a5,32
    80006744:	dbf5                	beqz	a5,80006738 <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    80006746:	0ff4f793          	andi	a5,s1,255
    8000674a:	10000737          	lui	a4,0x10000
    8000674e:	00f70023          	sb	a5,0(a4) # 10000000 <_entry-0x70000000>

  pop_off();
    80006752:	00000097          	auipc	ra,0x0
    80006756:	2ae080e7          	jalr	686(ra) # 80006a00 <pop_off>
}
    8000675a:	60e2                	ld	ra,24(sp)
    8000675c:	6442                	ld	s0,16(sp)
    8000675e:	64a2                	ld	s1,8(sp)
    80006760:	6105                	addi	sp,sp,32
    80006762:	8082                	ret

0000000080006764 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    80006764:	00003717          	auipc	a4,0x3
    80006768:	8bc73703          	ld	a4,-1860(a4) # 80009020 <uart_tx_r>
    8000676c:	00003797          	auipc	a5,0x3
    80006770:	8bc7b783          	ld	a5,-1860(a5) # 80009028 <uart_tx_w>
    80006774:	06e78c63          	beq	a5,a4,800067ec <uartstart+0x88>
{
    80006778:	7139                	addi	sp,sp,-64
    8000677a:	fc06                	sd	ra,56(sp)
    8000677c:	f822                	sd	s0,48(sp)
    8000677e:	f426                	sd	s1,40(sp)
    80006780:	f04a                	sd	s2,32(sp)
    80006782:	ec4e                	sd	s3,24(sp)
    80006784:	e852                	sd	s4,16(sp)
    80006786:	e456                	sd	s5,8(sp)
    80006788:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    8000678a:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    8000678e:	00020a17          	auipc	s4,0x20
    80006792:	a7aa0a13          	addi	s4,s4,-1414 # 80026208 <uart_tx_lock>
    uart_tx_r += 1;
    80006796:	00003497          	auipc	s1,0x3
    8000679a:	88a48493          	addi	s1,s1,-1910 # 80009020 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    8000679e:	00003997          	auipc	s3,0x3
    800067a2:	88a98993          	addi	s3,s3,-1910 # 80009028 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    800067a6:	00594783          	lbu	a5,5(s2) # 10000005 <_entry-0x6ffffffb>
    800067aa:	0ff7f793          	andi	a5,a5,255
    800067ae:	0207f793          	andi	a5,a5,32
    800067b2:	c785                	beqz	a5,800067da <uartstart+0x76>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    800067b4:	01f77793          	andi	a5,a4,31
    800067b8:	97d2                	add	a5,a5,s4
    800067ba:	0187ca83          	lbu	s5,24(a5)
    uart_tx_r += 1;
    800067be:	0705                	addi	a4,a4,1
    800067c0:	e098                	sd	a4,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    800067c2:	8526                	mv	a0,s1
    800067c4:	ffffb097          	auipc	ra,0xffffb
    800067c8:	2e4080e7          	jalr	740(ra) # 80001aa8 <wakeup>
    
    WriteReg(THR, c);
    800067cc:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    800067d0:	6098                	ld	a4,0(s1)
    800067d2:	0009b783          	ld	a5,0(s3)
    800067d6:	fce798e3          	bne	a5,a4,800067a6 <uartstart+0x42>
  }
}
    800067da:	70e2                	ld	ra,56(sp)
    800067dc:	7442                	ld	s0,48(sp)
    800067de:	74a2                	ld	s1,40(sp)
    800067e0:	7902                	ld	s2,32(sp)
    800067e2:	69e2                	ld	s3,24(sp)
    800067e4:	6a42                	ld	s4,16(sp)
    800067e6:	6aa2                	ld	s5,8(sp)
    800067e8:	6121                	addi	sp,sp,64
    800067ea:	8082                	ret
    800067ec:	8082                	ret

00000000800067ee <uartputc>:
{
    800067ee:	7179                	addi	sp,sp,-48
    800067f0:	f406                	sd	ra,40(sp)
    800067f2:	f022                	sd	s0,32(sp)
    800067f4:	ec26                	sd	s1,24(sp)
    800067f6:	e84a                	sd	s2,16(sp)
    800067f8:	e44e                	sd	s3,8(sp)
    800067fa:	e052                	sd	s4,0(sp)
    800067fc:	1800                	addi	s0,sp,48
    800067fe:	89aa                	mv	s3,a0
  acquire(&uart_tx_lock);
    80006800:	00020517          	auipc	a0,0x20
    80006804:	a0850513          	addi	a0,a0,-1528 # 80026208 <uart_tx_lock>
    80006808:	00000097          	auipc	ra,0x0
    8000680c:	1a4080e7          	jalr	420(ra) # 800069ac <acquire>
  if(panicked){
    80006810:	00003797          	auipc	a5,0x3
    80006814:	80c7a783          	lw	a5,-2036(a5) # 8000901c <panicked>
    80006818:	c391                	beqz	a5,8000681c <uartputc+0x2e>
    for(;;)
    8000681a:	a001                	j	8000681a <uartputc+0x2c>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    8000681c:	00003797          	auipc	a5,0x3
    80006820:	80c7b783          	ld	a5,-2036(a5) # 80009028 <uart_tx_w>
    80006824:	00002717          	auipc	a4,0x2
    80006828:	7fc73703          	ld	a4,2044(a4) # 80009020 <uart_tx_r>
    8000682c:	02070713          	addi	a4,a4,32
    80006830:	02f71b63          	bne	a4,a5,80006866 <uartputc+0x78>
      sleep(&uart_tx_r, &uart_tx_lock);
    80006834:	00020a17          	auipc	s4,0x20
    80006838:	9d4a0a13          	addi	s4,s4,-1580 # 80026208 <uart_tx_lock>
    8000683c:	00002497          	auipc	s1,0x2
    80006840:	7e448493          	addi	s1,s1,2020 # 80009020 <uart_tx_r>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80006844:	00002917          	auipc	s2,0x2
    80006848:	7e490913          	addi	s2,s2,2020 # 80009028 <uart_tx_w>
      sleep(&uart_tx_r, &uart_tx_lock);
    8000684c:	85d2                	mv	a1,s4
    8000684e:	8526                	mv	a0,s1
    80006850:	ffffb097          	auipc	ra,0xffffb
    80006854:	0cc080e7          	jalr	204(ra) # 8000191c <sleep>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80006858:	00093783          	ld	a5,0(s2)
    8000685c:	6098                	ld	a4,0(s1)
    8000685e:	02070713          	addi	a4,a4,32
    80006862:	fef705e3          	beq	a4,a5,8000684c <uartputc+0x5e>
      uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80006866:	00020497          	auipc	s1,0x20
    8000686a:	9a248493          	addi	s1,s1,-1630 # 80026208 <uart_tx_lock>
    8000686e:	01f7f713          	andi	a4,a5,31
    80006872:	9726                	add	a4,a4,s1
    80006874:	01370c23          	sb	s3,24(a4)
      uart_tx_w += 1;
    80006878:	0785                	addi	a5,a5,1
    8000687a:	00002717          	auipc	a4,0x2
    8000687e:	7af73723          	sd	a5,1966(a4) # 80009028 <uart_tx_w>
      uartstart();
    80006882:	00000097          	auipc	ra,0x0
    80006886:	ee2080e7          	jalr	-286(ra) # 80006764 <uartstart>
      release(&uart_tx_lock);
    8000688a:	8526                	mv	a0,s1
    8000688c:	00000097          	auipc	ra,0x0
    80006890:	1d4080e7          	jalr	468(ra) # 80006a60 <release>
}
    80006894:	70a2                	ld	ra,40(sp)
    80006896:	7402                	ld	s0,32(sp)
    80006898:	64e2                	ld	s1,24(sp)
    8000689a:	6942                	ld	s2,16(sp)
    8000689c:	69a2                	ld	s3,8(sp)
    8000689e:	6a02                	ld	s4,0(sp)
    800068a0:	6145                	addi	sp,sp,48
    800068a2:	8082                	ret

00000000800068a4 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    800068a4:	1141                	addi	sp,sp,-16
    800068a6:	e422                	sd	s0,8(sp)
    800068a8:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    800068aa:	100007b7          	lui	a5,0x10000
    800068ae:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800068b2:	8b85                	andi	a5,a5,1
    800068b4:	cb91                	beqz	a5,800068c8 <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    800068b6:	100007b7          	lui	a5,0x10000
    800068ba:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
    800068be:	0ff57513          	andi	a0,a0,255
  } else {
    return -1;
  }
}
    800068c2:	6422                	ld	s0,8(sp)
    800068c4:	0141                	addi	sp,sp,16
    800068c6:	8082                	ret
    return -1;
    800068c8:	557d                	li	a0,-1
    800068ca:	bfe5                	j	800068c2 <uartgetc+0x1e>

00000000800068cc <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from trap.c.
void
uartintr(void)
{
    800068cc:	1101                	addi	sp,sp,-32
    800068ce:	ec06                	sd	ra,24(sp)
    800068d0:	e822                	sd	s0,16(sp)
    800068d2:	e426                	sd	s1,8(sp)
    800068d4:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    800068d6:	54fd                	li	s1,-1
    int c = uartgetc();
    800068d8:	00000097          	auipc	ra,0x0
    800068dc:	fcc080e7          	jalr	-52(ra) # 800068a4 <uartgetc>
    if(c == -1)
    800068e0:	00950763          	beq	a0,s1,800068ee <uartintr+0x22>
      break;
    consoleintr(c);
    800068e4:	00000097          	auipc	ra,0x0
    800068e8:	8fe080e7          	jalr	-1794(ra) # 800061e2 <consoleintr>
  while(1){
    800068ec:	b7f5                	j	800068d8 <uartintr+0xc>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    800068ee:	00020497          	auipc	s1,0x20
    800068f2:	91a48493          	addi	s1,s1,-1766 # 80026208 <uart_tx_lock>
    800068f6:	8526                	mv	a0,s1
    800068f8:	00000097          	auipc	ra,0x0
    800068fc:	0b4080e7          	jalr	180(ra) # 800069ac <acquire>
  uartstart();
    80006900:	00000097          	auipc	ra,0x0
    80006904:	e64080e7          	jalr	-412(ra) # 80006764 <uartstart>
  release(&uart_tx_lock);
    80006908:	8526                	mv	a0,s1
    8000690a:	00000097          	auipc	ra,0x0
    8000690e:	156080e7          	jalr	342(ra) # 80006a60 <release>
}
    80006912:	60e2                	ld	ra,24(sp)
    80006914:	6442                	ld	s0,16(sp)
    80006916:	64a2                	ld	s1,8(sp)
    80006918:	6105                	addi	sp,sp,32
    8000691a:	8082                	ret

000000008000691c <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    8000691c:	1141                	addi	sp,sp,-16
    8000691e:	e422                	sd	s0,8(sp)
    80006920:	0800                	addi	s0,sp,16
  lk->name = name;
    80006922:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80006924:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80006928:	00053823          	sd	zero,16(a0)
}
    8000692c:	6422                	ld	s0,8(sp)
    8000692e:	0141                	addi	sp,sp,16
    80006930:	8082                	ret

0000000080006932 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80006932:	411c                	lw	a5,0(a0)
    80006934:	e399                	bnez	a5,8000693a <holding+0x8>
    80006936:	4501                	li	a0,0
  return r;
}
    80006938:	8082                	ret
{
    8000693a:	1101                	addi	sp,sp,-32
    8000693c:	ec06                	sd	ra,24(sp)
    8000693e:	e822                	sd	s0,16(sp)
    80006940:	e426                	sd	s1,8(sp)
    80006942:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    80006944:	6904                	ld	s1,16(a0)
    80006946:	ffffb097          	auipc	ra,0xffffb
    8000694a:	8fe080e7          	jalr	-1794(ra) # 80001244 <mycpu>
    8000694e:	40a48533          	sub	a0,s1,a0
    80006952:	00153513          	seqz	a0,a0
}
    80006956:	60e2                	ld	ra,24(sp)
    80006958:	6442                	ld	s0,16(sp)
    8000695a:	64a2                	ld	s1,8(sp)
    8000695c:	6105                	addi	sp,sp,32
    8000695e:	8082                	ret

0000000080006960 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80006960:	1101                	addi	sp,sp,-32
    80006962:	ec06                	sd	ra,24(sp)
    80006964:	e822                	sd	s0,16(sp)
    80006966:	e426                	sd	s1,8(sp)
    80006968:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000696a:	100024f3          	csrr	s1,sstatus
    8000696e:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80006972:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80006974:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    80006978:	ffffb097          	auipc	ra,0xffffb
    8000697c:	8cc080e7          	jalr	-1844(ra) # 80001244 <mycpu>
    80006980:	5d3c                	lw	a5,120(a0)
    80006982:	cf89                	beqz	a5,8000699c <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80006984:	ffffb097          	auipc	ra,0xffffb
    80006988:	8c0080e7          	jalr	-1856(ra) # 80001244 <mycpu>
    8000698c:	5d3c                	lw	a5,120(a0)
    8000698e:	2785                	addiw	a5,a5,1
    80006990:	dd3c                	sw	a5,120(a0)
}
    80006992:	60e2                	ld	ra,24(sp)
    80006994:	6442                	ld	s0,16(sp)
    80006996:	64a2                	ld	s1,8(sp)
    80006998:	6105                	addi	sp,sp,32
    8000699a:	8082                	ret
    mycpu()->intena = old;
    8000699c:	ffffb097          	auipc	ra,0xffffb
    800069a0:	8a8080e7          	jalr	-1880(ra) # 80001244 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    800069a4:	8085                	srli	s1,s1,0x1
    800069a6:	8885                	andi	s1,s1,1
    800069a8:	dd64                	sw	s1,124(a0)
    800069aa:	bfe9                	j	80006984 <push_off+0x24>

00000000800069ac <acquire>:
{
    800069ac:	1101                	addi	sp,sp,-32
    800069ae:	ec06                	sd	ra,24(sp)
    800069b0:	e822                	sd	s0,16(sp)
    800069b2:	e426                	sd	s1,8(sp)
    800069b4:	1000                	addi	s0,sp,32
    800069b6:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    800069b8:	00000097          	auipc	ra,0x0
    800069bc:	fa8080e7          	jalr	-88(ra) # 80006960 <push_off>
  if(holding(lk))
    800069c0:	8526                	mv	a0,s1
    800069c2:	00000097          	auipc	ra,0x0
    800069c6:	f70080e7          	jalr	-144(ra) # 80006932 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800069ca:	4705                	li	a4,1
  if(holding(lk))
    800069cc:	e115                	bnez	a0,800069f0 <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800069ce:	87ba                	mv	a5,a4
    800069d0:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800069d4:	2781                	sext.w	a5,a5
    800069d6:	ffe5                	bnez	a5,800069ce <acquire+0x22>
  __sync_synchronize();
    800069d8:	0ff0000f          	fence
  lk->cpu = mycpu();
    800069dc:	ffffb097          	auipc	ra,0xffffb
    800069e0:	868080e7          	jalr	-1944(ra) # 80001244 <mycpu>
    800069e4:	e888                	sd	a0,16(s1)
}
    800069e6:	60e2                	ld	ra,24(sp)
    800069e8:	6442                	ld	s0,16(sp)
    800069ea:	64a2                	ld	s1,8(sp)
    800069ec:	6105                	addi	sp,sp,32
    800069ee:	8082                	ret
    panic("acquire");
    800069f0:	00002517          	auipc	a0,0x2
    800069f4:	ff050513          	addi	a0,a0,-16 # 800089e0 <digits+0x20>
    800069f8:	00000097          	auipc	ra,0x0
    800069fc:	a6a080e7          	jalr	-1430(ra) # 80006462 <panic>

0000000080006a00 <pop_off>:

void
pop_off(void)
{
    80006a00:	1141                	addi	sp,sp,-16
    80006a02:	e406                	sd	ra,8(sp)
    80006a04:	e022                	sd	s0,0(sp)
    80006a06:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80006a08:	ffffb097          	auipc	ra,0xffffb
    80006a0c:	83c080e7          	jalr	-1988(ra) # 80001244 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80006a10:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80006a14:	8b89                	andi	a5,a5,2
  if(intr_get())
    80006a16:	e78d                	bnez	a5,80006a40 <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80006a18:	5d3c                	lw	a5,120(a0)
    80006a1a:	02f05b63          	blez	a5,80006a50 <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    80006a1e:	37fd                	addiw	a5,a5,-1
    80006a20:	0007871b          	sext.w	a4,a5
    80006a24:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80006a26:	eb09                	bnez	a4,80006a38 <pop_off+0x38>
    80006a28:	5d7c                	lw	a5,124(a0)
    80006a2a:	c799                	beqz	a5,80006a38 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80006a2c:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80006a30:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80006a34:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80006a38:	60a2                	ld	ra,8(sp)
    80006a3a:	6402                	ld	s0,0(sp)
    80006a3c:	0141                	addi	sp,sp,16
    80006a3e:	8082                	ret
    panic("pop_off - interruptible");
    80006a40:	00002517          	auipc	a0,0x2
    80006a44:	fa850513          	addi	a0,a0,-88 # 800089e8 <digits+0x28>
    80006a48:	00000097          	auipc	ra,0x0
    80006a4c:	a1a080e7          	jalr	-1510(ra) # 80006462 <panic>
    panic("pop_off");
    80006a50:	00002517          	auipc	a0,0x2
    80006a54:	fb050513          	addi	a0,a0,-80 # 80008a00 <digits+0x40>
    80006a58:	00000097          	auipc	ra,0x0
    80006a5c:	a0a080e7          	jalr	-1526(ra) # 80006462 <panic>

0000000080006a60 <release>:
{
    80006a60:	1101                	addi	sp,sp,-32
    80006a62:	ec06                	sd	ra,24(sp)
    80006a64:	e822                	sd	s0,16(sp)
    80006a66:	e426                	sd	s1,8(sp)
    80006a68:	1000                	addi	s0,sp,32
    80006a6a:	84aa                	mv	s1,a0
  if(!holding(lk))
    80006a6c:	00000097          	auipc	ra,0x0
    80006a70:	ec6080e7          	jalr	-314(ra) # 80006932 <holding>
    80006a74:	c115                	beqz	a0,80006a98 <release+0x38>
  lk->cpu = 0;
    80006a76:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80006a7a:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    80006a7e:	0f50000f          	fence	iorw,ow
    80006a82:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    80006a86:	00000097          	auipc	ra,0x0
    80006a8a:	f7a080e7          	jalr	-134(ra) # 80006a00 <pop_off>
}
    80006a8e:	60e2                	ld	ra,24(sp)
    80006a90:	6442                	ld	s0,16(sp)
    80006a92:	64a2                	ld	s1,8(sp)
    80006a94:	6105                	addi	sp,sp,32
    80006a96:	8082                	ret
    panic("release");
    80006a98:	00002517          	auipc	a0,0x2
    80006a9c:	f7050513          	addi	a0,a0,-144 # 80008a08 <digits+0x48>
    80006aa0:	00000097          	auipc	ra,0x0
    80006aa4:	9c2080e7          	jalr	-1598(ra) # 80006462 <panic>
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
