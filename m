Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37205 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755337AbcAZPtl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jan 2016 10:49:41 -0500
Date: Tue, 26 Jan 2016 16:48:25 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Chen Fan <chen.fan.fnst@cn.fujitsu.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rjw@rjwysocki.net, lenb@kernel.org, izumi.taku@jp.fujitsu.com,
	wency@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com,
	ddaney.cavm@gmail.com, okaya@codeaurora.org, bhelgaas@google.com,
	jiang.liu@linux.intel.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix unavailable irq number 255 reported by
 BIOS
In-Reply-To: <20160126152221.GB9279@localhost>
Message-ID: <alpine.DEB.2.11.1601261628450.3886@nanos>
References: <1453705178-27389-1-git-send-email-chen.fan.fnst@cn.fujitsu.com> <20160125205803.GA10272@localhost> <alpine.DEB.2.11.1601260825510.3886@nanos> <20160126152221.GB9279@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 26 Jan 2016, Bjorn Helgaas wrote:
> On Tue, Jan 26, 2016 at 09:26:29AM +0100, Thomas Gleixner wrote:
> > And why would this be x86 specific? PCI3.0 is architecture independent, right?
> 
> Yes, PCI is mostly arch-independent, but Interrupt Line is
> arch-specific, and the corner case of it being 255 is only mentioned
> in an x86-specific footnote.  We can improve the comment.

Yes please :)
 
> > The proper solution here is to flag that this device does not have an
> > interrupt connected and act accordingly in the device driver, i.e. do not call
> > request_irq() in the first place.
> 
> This is the crux of the problem.  As far as I know, PCI doesn't have
> a flag to indicate that dev->irq is a wire that's not connected, so
> there's no generic way for a driver to know whether it should call
> request_irq().

Ok.
 
> We could add one, of course, but that only helps in the drivers we
> update.  It'd be nice if we could figure out a way to fix this
> without having to touch all the drivers.

Hmm.
 
> I think any driver that uses line-based interrupts can potentially
> fail if the platform uses Interrupt Line == 255 to indicate that the
> line is not connected.  If another driver happens to be using IRQ 255,
> request_irq() may fail as it does here.  Otherwise, I suspect
> request_irq() will return success, but the driver won't get any
> interrupts.

Right. So we could certainly do something like this INVALID_IRQ thingy, but
that looks a bit weird. What would request_irq() return?

If it returns success, then drivers might make the wrong decision. If it
returns an error code, then the i801 one works, but we might have to fix
others anyway.

I think it's better to have a software flag in pci_dev to indicate that there
is no irq line and fix up the (probably few) affected drivers so they avoid
calling request_irq() and take the right action.

> > No. NR_IRQS cannot be used at all if sparse irqs are enabled. 
> 
> Ah, thanks, this is a critical piece I missed.  There *are* a few
> places where we do define or use NR_IRQS when CONFIG_SPARSE_IRQ=y.  Do
> these need updates?
> 
>   include/asm-generic/irq.h defines NR_IRQS if not defined yet
>   arch/arm/include/asm/irq.h defines NR_IRQS to NR_IRQS_LEGACY
>   arch/arm/kernel/irq.c uses NR_IRQS
>   arch/sh/include/asm/irq.h defines NR_IRQS to 8

These defines are used for preallocating interrupt descriptors in early
boot. That was invented to help migrating to sparse irq.

>   kernel/irq/internals.h uses NR_IRQS to define IRQ_BITMAP_BITS

Right, that's probably pointless, but harmless.

> > Nothing in any generic code is supposed to rely on NR_IRQS.
>  
> I guess that means these uses are suspect:
> 
>   $ git grep -w NR_IRQS | grep -v "^arch" | grep -v "^kernel" | grep -v "^drivers/irqchip" | grep -v "^include"
>   drivers/input/keyboard/lpc32xx-keys.c:	if (irq < 0 || irq >= NR_IRQS) {
>   drivers/mtd/nand/lpc32xx_mlc.c:	if ((host->irq < 0) || (host->irq >= NR_IRQS)) {
>   drivers/net/hamradio/scc.c:static struct irqflags { unsigned char used : 1; } Ivec[NR_IRQS];
>   drivers/pcmcia/pcmcia_resource.c:		if (irq > NR_IRQS)
>   drivers/tty/serial/apbuart.c:	if (ser->irq < 0 || ser->irq >= NR_IRQS)
>   drivers/tty/serial/ar933x_uart.c:	if (ser->irq < 0 || ser->irq >= NR_IRQS)
>   drivers/tty/serial/lantiq.c:	if (ser->irq < 0 || ser->irq >= NR_IRQS)
>   drivers/tty/serial/m32r_sio.c:static struct irq_info irq_lists[NR_IRQS];

Indeed.

Thanks,

	tglx

