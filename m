Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:63406 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933296AbcINOYM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2016 10:24:12 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, devicetree@vger.kernel.org,
        lorenzo.pieralisi@arm.com, benh@kernel.crashing.org,
        minyard@acm.org, linux-pci@vger.kernel.org,
        gabriele.paoloni@huawei.com, john.garry@huawei.com,
        will.deacon@arm.com, xuwei5@hisilicon.com,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        zourongrong@gmail.com, liviu.dudau@arm.com, kantyzc@163.com,
        zhichang.yuan02@gmail.com
Subject: Re: [PATCH V3 1/4] ARM64 LPC: Indirect ISA port IO introduced
Date: Wed, 14 Sep 2016 16:23:39 +0200
Message-ID: <5264074.nuyDhEuOR4@wuerfel>
In-Reply-To: <57D95BBC.9030405@hisilicon.com>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com> <8337589.pzGt0MZ9xn@wuerfel> <57D95BBC.9030405@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, September 14, 2016 10:16:28 PM CEST zhichang.yuan wrote:
> > 
> > No need to guard includes with an #ifdef.
> If remove #ifdef here, extio.h should not contain any function external declarations whose definitions are in
> extio.c compiled only when CONFIG_ARM64_INDIRECT_PIO is yes.
 
There is no problem with making declarations visible for functions that
are not part of the kernel, we do that all the time.

> >> +#define BUILDS_RW(bwl, type)                                                \
> >> +static inline void reads##bwl(const volatile void __iomem *addr,    \
> >> +                            void *buffer, unsigned int count)       \
> >> +{                                                                   \
> >> +    if (count) {                                                    \
> >> +            type *buf = buffer;                                     \
> >> +                                                                    \
> >> +            do {                                                    \
> >> +                    type x = __raw_read##bwl(addr);                 \
> >> +                    *buf++ = x;                                     \
> >> +            } while (--count);                                      \
> >> +    }                                                               \
> >> +}                                                                   \
> >> +                                                                    \
> >> +static inline void writes##bwl(volatile void __iomem *addr,         \
> >> +                            const void *buffer, unsigned int count) \
> >> +{                                                                   \
> >> +    if (count) {                                                    \
> >> +            const type *buf = buffer;                               \
> >> +                                                                    \
> >> +            do {                                                    \
> >> +                    __raw_write##bwl(*buf++, addr);                 \
> >> +            } while (--count);                                      \
> >> +    }                                                               \
> >> +}
> >> +
> >> +BUILDS_RW(b, u8)
> > 
> > Why is this in here?
> the readsb/writesb are defined in asm-generic/io.h which is included later, but the redefined insb/outsb need
> to call them. Without these readsb/writesb definition before insb/outsb redefined, compile error occur.
> 
> It seems that copy all the definitions of "asm-generic/io.h" is not a good idea, so I move the definitions of
> those function needed here....
> 
> Ok. I think your idea below defining in(s)/out(s) in a c file can solve this issue.
> 
> #ifdef CONFIG_ARM64_INDIRECT_PIO
> #define inb inb
> extern u8 inb(unsigned long addr);
> 
> #define outb outb
> extern void outb(u8 value, unsigned long addr);
> 
> #define insb insb
> extern void insb(unsigned long addr, void *buffer, unsigned int count);
> 
> #define outsb outsb
> extern void outsb(unsigned long addr, const void *buffer, unsigned int count);
> #endif
> 
> and definitions of all these functions are in extio.c :
> 
> u8 inb(unsigned long addr)
> {
>         if (!arm64_extio_ops || arm64_extio_ops->start > addr ||
>                         arm64_extio_ops->end < addr)
>                 return readb(PCI_IOBASE + addr);
>         else
>                 return arm64_extio_ops->pfin ?
>                         arm64_extio_ops->pfin(arm64_extio_ops->devpara,
>                                 addr + arm64_extio_ops->ptoffset, NULL,
>                                 sizeof(u8), 1) : -1;
> }
> .....

Yes, sounds good.

> >> @@ -149,6 +185,60 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
> >>  #define IO_SPACE_LIMIT              (PCI_IO_SIZE - 1)
> >>  #define PCI_IOBASE          ((void __iomem *)PCI_IO_START)
> >>  
> >> +
> >> +/*
> >> + * redefine the in(s)b/out(s)b for indirect-IO.
> >> + */
> >> +#define inb inb
> >> +static inline u8 inb(unsigned long addr)
> >> +{
> >> +#ifdef CONFIG_ARM64_INDIRECT_PIO
> >> +    if (arm64_extio_ops && arm64_extio_ops->start <= addr &&
> >> +                    addr <= arm64_extio_ops->end)
> >> +            return extio_inb(addr);
> >> +#endif
> >> +    return readb(PCI_IOBASE + addr);
> >> +}
> >> +
> > 
> > Looks ok, but you only seem to do this for the 8-bit
> > accessors, when it should be done for 16-bit and 32-bit
> > ones as well for consistency.
> Hip06 LPC only support 8-bit I/O operations on the designated port.

That is an interesting limitation. Maybe still call the extio operations
and have them do WARN_ON_ONCE() instead?

If you get a driver that calls inw/outw on the range that is owned
by the LPC bus, you otherwise get an unhandled page fault in kernel
space, which is not as nice.

> >> diff --git a/drivers/bus/extio.c b/drivers/bus/extio.c
> >> new file mode 100644
> >> index 0000000..1e7a9c5
> >> --- /dev/null
> >> +++ b/drivers/bus/extio.c
> >> @@ -0,0 +1,66 @@
> > 
> > This is in a globally visible directory
> > 
> >> +
> >> +struct extio_ops *arm64_extio_ops;
> > 
> > But the identifier uses an architecture specific prefix. Either
> > move the whole file into arch/arm64, or make the naming so that
> > it can be used for everything.
> 
> I perfer to move the whole file into arch/arm64, extio.h will be moved to arch/arm64/include/asm;

Ok, that simplifies it a lot, you can just do everything in asm/io.h then.

	Arnd
