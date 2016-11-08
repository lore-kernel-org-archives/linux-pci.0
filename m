Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V5 1/3] ARM64 LPC: Indirect ISA port IO introduced
Date: Tue, 08 Nov 2016 17:09:59 +0100
Message-ID: <13493313.OkuDZEY5WO@wuerfel>
In-Reply-To: <20161108120323.GC15297@leverpostej>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-2-git-send-email-yuanzhichang@hisilicon.com>
 <20161108120323.GC15297@leverpostej>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
 gabriele.paoloni@huawei.com, benh@kernel.crashing.org, will.deacon@arm.com,
 linuxarm@huawei.com, lorenzo.pieralisi@arm.com, xuwei5@hisilicon.com,
 linux-serial@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, minyard@acm.org, marc.zyngier@arm.com,
 liviu.dudau@arm.com, john.garry@huawei.com, olof@lixom.net, robh+dt@kernel.org,
 bhelgaas@google.com, kantyzc@163.com, zhichang.yuan02@gmail.com,
 linux-kernel@vger.kernel.org, "zhichang.yuan" <yuanzhichang@hisilicon.com>,
 zourongrong@gmail.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, November 8, 2016 12:03:23 PM CET Mark Rutland wrote:
> On Tue, Nov 08, 2016 at 11:47:07AM +0800, zhichang.yuan wrote:
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

Actually PowerPC has a vaguely similar mechanism.

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

I think it is rather unlikely that we have to deal with multiple
instances in the future, it's more likely that future platforms
won't have any I/O ports at all, which is why I was advocating for
simplicity here.

> > +type in##bw(unsigned long addr)						\
> > +{									\
> > +	if (!arm64_extio_ops || arm64_extio_ops->start > addr ||	\
> > +			arm64_extio_ops->end < addr)			\
> > +		return read##bw(PCI_IOBASE + addr);			\
> > +	return arm64_extio_ops->pfin ?					\
> > +		arm64_extio_ops->pfin(arm64_extio_ops->devpara,		\
> > +			addr, sizeof(type)) : -1;			\
> > +}									\
> > +									\
> > +void out##bw(type value, unsigned long addr)				\
> > +{									\
> > +	if (!arm64_extio_ops || arm64_extio_ops->start > addr ||	\
> > +			arm64_extio_ops->end < addr)			\
> > +		write##bw(value, PCI_IOBASE + addr);			\
> > +	else								\
> > +		if (arm64_extio_ops->pfout)				\
> > +			arm64_extio_ops->pfout(arm64_extio_ops->devpara,\
> > +				addr, value, sizeof(type));		\
> > +}									\
> > +									\
> > +void ins##bw(unsigned long addr, void *buffer, unsigned int count)	\
> > +{									\
> > +	if (!arm64_extio_ops || arm64_extio_ops->start > addr ||	\
> > +			arm64_extio_ops->end < addr)			\
> > +		reads##bw(PCI_IOBASE + addr, buffer, count);		\
> > +	else								\
> > +		if (arm64_extio_ops->pfins)				\
> > +			arm64_extio_ops->pfins(arm64_extio_ops->devpara,\
> > +				addr, buffer, sizeof(type), count);	\
> > +}									\
> > +									\
> > +void outs##bw(unsigned long addr, const void *buffer, unsigned int count)	\
> > +{									\
> > +	if (!arm64_extio_ops || arm64_extio_ops->start > addr ||	\
> > +			arm64_extio_ops->end < addr)			\
> > +		writes##bw(PCI_IOBASE + addr, buffer, count);		\
> > +	else								\
> > +		if (arm64_extio_ops->pfouts)				\
> > +			arm64_extio_ops->pfouts(arm64_extio_ops->devpara,\
> > +				addr, buffer, sizeof(type), count);	\
> > +}
> > +
> 
> So all PCI I/O will be slowed down by irrelevant checks when this is
> enabled?

I don't see a better alternative. I earlier suggested having these
out of line so we don't grow the object code too much when it is
enabled.

Performance of PIO accessors is not an issue here though, any bus
access will by definition be orders of magnitude slower than the
added branches and dereferences here.

> [...]
> 
> > +static inline void arm64_set_extops(struct extio_ops *ops)
> > +{
> > +	if (ops)
> > +		WRITE_ONCE(arm64_extio_ops, ops);
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

Agreed, this looks wrong.

	Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
