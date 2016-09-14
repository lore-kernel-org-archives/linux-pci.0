Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Zhichang Yuan <yuanzhichang@hisilicon.com>,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
        benh@kernel.crashing.org, minyard@acm.org,
        linux-pci@vger.kernel.org, gabriele.paoloni@huawei.com,
        john.garry@huawei.com, will.deacon@arm.com, xuwei5@hisilicon.com,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        zourongrong@gmail.com, liviu.dudau@arm.com, kantyzc@163.com,
        zhichang.yuan02@gmail.com
Subject: Re: [PATCH V3 1/4] ARM64 LPC: Indirect ISA port IO introduced
Date: Wed, 14 Sep 2016 14:24:30 +0200
Message-ID: <8337589.pzGt0MZ9xn@wuerfel>
In-Reply-To: <1473855354-150093-2-git-send-email-yuanzhichang@hisilicon.com>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com> <1473855354-150093-2-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, September 14, 2016 8:15:51 PM CEST Zhichang Yuan wrote:
> From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
> 
> For arm64, there is no I/O space as other architectural platforms, such as
> X86. Most I/O accesses are achieved based on MMIO. But for some arm64 SoCs,
> such as Hip06, when accessing some legacy ISA devices connected to LPC, those
> known port addresses are used to control the corresponding target devices, for
> example, 0x2f8 is for UART, 0xe4 is for ipmi-bt. It is different from the
> normal MMIO mode in using.
> 
> To drive these devices, this patch introduces a method named indirect-IO.
> In this method the in/out pair in arch/arm64/include/asm/io.h will be
> redefined. When upper layer drivers call in/out with those known legacy port
> addresses to access the peripherals, the hooking functions corrresponding to
> those target peripherals will be called. Through this way, those upper layer
> drivers which depend on in/out can run on Hip06 without any changes.
> 
> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>

Looks ok overall, but I have a couple of comments for details.

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index bc3f00f..9579479 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -161,6 +161,12 @@ config ARCH_MMAP_RND_COMPAT_BITS_MIN
>  config ARCH_MMAP_RND_COMPAT_BITS_MAX
>         default 16
>  
> +config ARM64_INDIRECT_PIO
> +	def_bool n

'def_bool n' is the same as the shorter and more common 'bool'.

> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index 9b6e408..d3acf1f 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -34,6 +34,10 @@
>  
>  #include <xen/xen.h>
>  
> +#ifdef CONFIG_ARM64_INDIRECT_PIO
> +#include <linux/extio.h>
> +#endif

No need to guard includes with an #ifdef.

> +#define BUILDS_RW(bwl, type)						\
> +static inline void reads##bwl(const volatile void __iomem *addr,	\
> +				void *buffer, unsigned int count)	\
> +{									\
> +	if (count) {							\
> +		type *buf = buffer;					\
> +									\
> +		do {							\
> +			type x = __raw_read##bwl(addr);			\
> +			*buf++ = x;					\
> +		} while (--count);					\
> +	}								\
> +}									\
> +									\
> +static inline void writes##bwl(volatile void __iomem *addr,		\
> +				const void *buffer, unsigned int count)	\
> +{									\
> +	if (count) {							\
> +		const type *buf = buffer;				\
> +									\
> +		do {							\
> +			__raw_write##bwl(*buf++, addr);			\
> +		} while (--count);					\
> +	}								\
> +}
> +
> +BUILDS_RW(b, u8)

Why is this in here?

> @@ -149,6 +185,60 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
>  #define IO_SPACE_LIMIT		(PCI_IO_SIZE - 1)
>  #define PCI_IOBASE		((void __iomem *)PCI_IO_START)
>  
> +
> +/*
> + * redefine the in(s)b/out(s)b for indirect-IO.
> + */
> +#define inb inb
> +static inline u8 inb(unsigned long addr)
> +{
> +#ifdef CONFIG_ARM64_INDIRECT_PIO
> +	if (arm64_extio_ops && arm64_extio_ops->start <= addr &&
> +			addr <= arm64_extio_ops->end)
> +		return extio_inb(addr);
> +#endif
> +	return readb(PCI_IOBASE + addr);
> +}
> +

Looks ok, but you only seem to do this for the 8-bit
accessors, when it should be done for 16-bit and 32-bit
ones as well for consistency.

> diff --git a/drivers/bus/extio.c b/drivers/bus/extio.c
> new file mode 100644
> index 0000000..1e7a9c5
> --- /dev/null
> +++ b/drivers/bus/extio.c
> @@ -0,0 +1,66 @@

This is in a globally visible directory

> +
> +struct extio_ops *arm64_extio_ops;

But the identifier uses an architecture specific prefix. Either
move the whole file into arch/arm64, or make the naming so that
it can be used for everything.

> +u8 __weak extio_inb(unsigned long addr)
> +{
> +	return arm64_extio_ops->pfin ?
> +		arm64_extio_ops->pfin(arm64_extio_ops->devpara,
> +			addr + arm64_extio_ops->ptoffset, NULL,
> +			sizeof(u8), 1) : -1;
> +}

No need for the __weak attribute, just make sure that the
code is always built-in when needed.

Also, it doesn't seem necessary to have an extern function if
all it does is call the one callback that you have already 
checked earlier. Either put it all into the inline
definition in asm/io.h, or put it all into the extern
version like this.

#ifdef CONFIG_ARM64_INDIRECT_PIO /* otherwise use default from asm-generic */
#define inb inb
extern u8 inb(unsigned long addr);
#endif

u8 inb(unsigned long addr)
{
	if (arm64_extio_ops && arm64_extio_ops->start <= addr &&
			addr <= arm64_extio_ops->end)
		arm64_extio_ops->pfin(arm64_extio_ops->devpara,addr + arm64_extio_ops->ptoffset, NULL,sizeof(u8), 1) : -1;
	return extio_inb(addr);
}

> +#define inb inb
> +static inline u8 inb(unsigned long addr)
> +{
> +#ifdef CONFIG_ARM64_INDIRECT_PIO
> +	if (arm64_extio_ops && arm64_extio_ops->start <= addr &&
> +			addr <= arm64_extio_ops->end)
> +		return extio_inb(addr);
> +#endif
> +	return readb(PCI_IOBASE + addr);
> +}

> diff --git a/include/linux/extio.h b/include/linux/extio.h
> new file mode 100644
> index 0000000..08d1fca
> --- /dev/null
> +++ b/include/linux/extio.h
> @@ -0,0 +1,49 @@
> +/*
> + * Copyright (C) 2016 Hisilicon Limited, All Rights Reserved.
> + * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
> + * Author: Zou Rongrong <@huawei.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef __LINUX_EXTIO_H
> +#define __LINUX_EXTIO_H
> +
> +
> +typedef u64 (*inhook)(void *devobj, unsigned long ptaddr, void *inbuf,
> +				size_t dlen, unsigned int count);
> +typedef void (*outhook)(void *devobj, unsigned long ptaddr,
> +				const void *outbuf, size_t dlen,
> +				unsigned int count);

I would drop the typedef and just declare the types directly in the
only place that references them.

	Arnd
