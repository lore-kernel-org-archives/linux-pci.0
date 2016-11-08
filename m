Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1478647002.7430.69.camel@kernel.crashing.org>
Subject: Re: [PATCH V5 1/3] ARM64 LPC: Indirect ISA port IO introduced
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mark Rutland <mark.rutland@arm.com>, "zhichang.yuan"
 <yuanzhichang@hisilicon.com>
Date: Wed, 09 Nov 2016 10:16:42 +1100
In-Reply-To: <20161108120323.GC15297@leverpostej>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-2-git-send-email-yuanzhichang@hisilicon.com>
 <20161108120323.GC15297@leverpostej>
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: gabriele.paoloni@huawei.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linuxarm@huawei.com, lorenzo.pieralisi@arm.com, arnd@arndb.de,
 xuwei5@hisilicon.com, linux-serial@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, minyard@acm.org, marc.zyngier@arm.com,
 liviu.dudau@arm.com, john.garry@huawei.com, zourongrong@gmail.com,
 robh+dt@kernel.org, bhelgaas@google.com, kantyzc@163.com,
 zhichang.yuan02@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, olof@lixom.net
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2016-11-08 at 12:03 +0000, Mark Rutland wrote:
> On Tue, Nov 08, 2016 at 11:47:07AM +0800, zhichang.yuan wrote:
> > 
> > For arm64, there is no I/O space as other architectural platforms, such as
> > X86. Most I/O accesses are achieved based on MMIO. But for some arm64 SoCs,
> > such as Hip06, when accessing some legacy ISA devices connected to LPC, those
> > known port addresses are used to control the corresponding target devices, for
> > example, 0x2f8 is for UART, 0xe4 is for ipmi-bt. It is different from the
> > normal MMIO mode in using.
> 
> This has nothing to do with arm64. Hardware with this kind of indirect
> bus access could be integrated with a variety of CPU architectures. It
> simply hasn't been, yet.

On some ppc's we also use similar indirect access methods for IOs. We
have a generic infrastructure for re-routing some memory or IO regions
to hooks.

On POWER8, our PCIe doesn't do IO at all, but we have an LPC bus behind
firmware calls ;-) We use that infrastructure to plumb in the LPC bus.

> > To drive these devices, this patch introduces a method named indirect-IO.
> > In this method the in/out pair in arch/arm64/include/asm/io.h will be
> > redefined. When upper layer drivers call in/out with those known legacy port
> > addresses to access the peripherals, the hooking functions corrresponding to
> > those target peripherals will be called. Through this way, those upper layer
> > drivers which depend on in/out can run on Hip06 without any changes.
> 
> As above, this has nothing to do with arm64, and as such, should live in
> generic code, exactly as we would do if we had higher-level ISA
> accessor ops.
> 
> Regardless, given the multi-instance case, I don't think this is
> sufficient in general (and I think we need higher-level ISA accessors
> to handle the indirection).

Multi-instance with IO is tricky to do generically because archs already
have all sort of hacks to deal with the fact that inb/outb don't require
an explicit ioremap, so an IO resource can take all sort of shape depending
on the arch.

Overall it boils down to applying some kind of per-instance "offset" to
the IO port number though.

> [...]
> 
> > 
> > diff --git a/arch/arm64/include/asm/extio.h b/arch/arm64/include/asm/extio.h
> > new file mode 100644
> > index 0000000..6ae0787
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/extio.h
> 
> > 
> > +#ifndef __LINUX_EXTIO_H
> > +#define __LINUX_EXTIO_H
> 
> This doesn't match the file naming, __ASM_EXTIO_H would be consistent
> with other arm64 headers.
> 
> > 
> > +
> > +struct extio_ops {
> > > > +	unsigned long start;/* inclusive, sys io addr */
> > > > +	unsigned long end;/* inclusive, sys io addr */
> 
> Please put whitespace before inline comments.
> 
> [...]
> 
> > 
> > > > +type in##bw(unsigned long addr)						\
> > > > +{									\
> > > > > > +	if (!arm64_extio_ops || arm64_extio_ops->start > addr ||	\
> > > > > > +			arm64_extio_ops->end < addr)			\
> > > > > > +		return read##bw(PCI_IOBASE + addr);			\
> > > > > > +	return arm64_extio_ops->pfin ?					\
> > > > > > +		arm64_extio_ops->pfin(arm64_extio_ops->devpara,		\
> > > > > > +			addr, sizeof(type)) : -1;			\
> > > > +}									\
> > > > +									\
> > > > +void out##bw(type value, unsigned long addr)				\
> > > > +{									\
> > > > > > +	if (!arm64_extio_ops || arm64_extio_ops->start > addr ||	\
> > > > > > +			arm64_extio_ops->end < addr)			\
> > > > > > +		write##bw(value, PCI_IOBASE + addr);			\
> > > > > > +	else								\
> > > > > > +		if (arm64_extio_ops->pfout)				\
> > > > +			arm64_extio_ops->pfout(arm64_extio_ops->devpara,\
> > > > > > +				addr, value, sizeof(type));		\
> > > > +}									\
> > > > +									\
> > > > +void ins##bw(unsigned long addr, void *buffer, unsigned int count)	\
> > > > +{									\
> > > > > > +	if (!arm64_extio_ops || arm64_extio_ops->start > addr ||	\
> > > > > > +			arm64_extio_ops->end < addr)			\
> > > > > > +		reads##bw(PCI_IOBASE + addr, buffer, count);		\
> > > > > > +	else								\
> > > > > > +		if (arm64_extio_ops->pfins)				\
> > > > +			arm64_extio_ops->pfins(arm64_extio_ops->devpara,\
> > > > > > +				addr, buffer, sizeof(type), count);	\
> > > > +}									\
> > > > +									\
> > > > +void outs##bw(unsigned long addr, const void *buffer, unsigned int count)	\
> > > > +{									\
> > > > > > +	if (!arm64_extio_ops || arm64_extio_ops->start > addr ||	\
> > > > > > +			arm64_extio_ops->end < addr)			\
> > > > > > +		writes##bw(PCI_IOBASE + addr, buffer, count);		\
> > > > > > +	else								\
> > > > > > +		if (arm64_extio_ops->pfouts)				\
> > > > +			arm64_extio_ops->pfouts(arm64_extio_ops->devpara,\
> > > > > > +				addr, buffer, sizeof(type), count);	\
> > +}
> > +
> 
> So all PCI I/O will be slowed down by irrelevant checks when this is
> enabled?
> 
> [...]
> 
> > 
> > +static inline void arm64_set_extops(struct extio_ops *ops)
> > +{
> > > > +	if (ops)
> > > > +		WRITE_ONCE(arm64_extio_ops, ops);
> > +}
> 
> Why WRITE_ONCE()?
> 
> Is this not protected/propagated by some synchronisation mechanism?
> 
> WRITE_ONCE() is not sufficient to ensure that this is consistently
> observed by readers, and regardless, I don't see READ_ONCE() anywhere in
> this patch.
> 
> This looks very suspicious.
> 
> Thanks,
> Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
