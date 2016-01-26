Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51294 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965534AbcAZPWc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Jan 2016 10:22:32 -0500
Date: Tue, 26 Jan 2016 09:22:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Chen Fan <chen.fan.fnst@cn.fujitsu.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rjw@rjwysocki.net, lenb@kernel.org, izumi.taku@jp.fujitsu.com,
	wency@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com,
	ddaney.cavm@gmail.com, okaya@codeaurora.org, bhelgaas@google.com,
	jiang.liu@linux.intel.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix unavailable irq number 255 reported by BIOS
Message-ID: <20160126152221.GB9279@localhost>
References: <1453705178-27389-1-git-send-email-chen.fan.fnst@cn.fujitsu.com>
 <20160125205803.GA10272@localhost>
 <alpine.DEB.2.11.1601260825510.3886@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.11.1601260825510.3886@nanos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 26, 2016 at 09:26:29AM +0100, Thomas Gleixner wrote:
> On Mon, 25 Jan 2016, Bjorn Helgaas wrote:
> > On Mon, Jan 25, 2016 at 02:59:38PM +0800, Chen Fan wrote:
> 
> > > i801_smbus 0000:00:1f.3: PCI INT C: no GSI
> > > i801_smbus 0000:00:1f.3: Failed to allocate irq 255: -16
> > > i801_smbus: probe of 0000:00:1f.3 failed with error -16
> 
> The current code does not not fail when the interrupt request fails. It
> reports it and clears the IRQ feature flag.
> 
> > > @@ -436,7 +437,15 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
> > >  	 * driver reported one, then use it. Exit in any case.
> > >  	 */
> > >  	if (gsi < 0) {
> > > -		if (acpi_isa_register_gsi(dev))
> > > +#ifdef CONFIG_X86
> > > +		/*
> > > +		 * The Interrupt Line value of 0xff is defined to mean "unknown"
> > > +		 * or "no connection" (PCI 3.0, Section 6.2.4, footnote on page
> > > +		 * 223), using ~0U as invalid IRQ.
> > > +		 */
> 
> And why would this be x86 specific? PCI3.0 is architecture independent, right?

Yes, PCI is mostly arch-independent, but Interrupt Line is
arch-specific, and the corner case of it being 255 is only mentioned
in an x86-specific footnote.  We can improve the comment.

> > > +		dev->irq = (dev->irq == 0xff) ? IRQ_INVALID : dev->irq;
> > 
> > It's much simpler and clearer to write:
> > 
> >   if (dev->irq == 0xff)
> >     dev->irq = IRQ_INVALID;
> 
> I do not understand that IRQ_INVALID business at all.
> 
> > > +#endif
> > > +		if (!irq_is_valid(dev->irq) || acpi_isa_register_gsi(dev))
> > >  			dev_warn(&dev->dev, "PCI INT %c: no GSI\n",
> > >  				 pin_name(pin));
> > >  
> 
> The existing code already drops into this place because 
> acpi_isa_register_gsi() fails.
> 
> > > i801_smbus 0000:00:1f.3: PCI INT C: no GSI
> 
> What extra value does that !irq_is_valid() provide?
> 
> And how does setting dev->irq to ~0U prevent that request_irq() is called in
> the i801 device driver? Not at all, AFAICT. It will just fail with a different
> error.
> 
> So the whole 'fix' relies on the fact that irq ~0U does not exist (at least
> not today) and therefor the false sharing with some other driver using irq 255
> will not happen.
> 
> Relying on undocumented behaviour is not a fix, that's voodoo programming.
> 
> The proper solution here is to flag that this device does not have an
> interrupt connected and act accordingly in the device driver, i.e. do not call
> request_irq() in the first place.

This is the crux of the problem.  As far as I know, PCI doesn't have
a flag to indicate that dev->irq is a wire that's not connected, so
there's no generic way for a driver to know whether it should call
request_irq().

We could add one, of course, but that only helps in the drivers we
update.  It'd be nice if we could figure out a way to fix this
without having to touch all the drivers.

I think any driver that uses line-based interrupts can potentially
fail if the platform uses Interrupt Line == 255 to indicate that the
line is not connected.  If another driver happens to be using IRQ 255,
request_irq() may fail as it does here.  Otherwise, I suspect
request_irq() will return success, but the driver won't get any
interrupts.

> > I don't like the x86 ifdef.  I'd prefer:
> > 
> >   static inline bool irq_valid(unsigned int irq)
> >   {
> >     if (irq < NR_IRQS)
> >       return true;
> >     return false;
> >   }
> >
> > This could be used in many of the places that currently use NR_IRQS.
> 
> No. NR_IRQS cannot be used at all if sparse irqs are enabled. 

Ah, thanks, this is a critical piece I missed.  There *are* a few
places where we do define or use NR_IRQS when CONFIG_SPARSE_IRQ=y.  Do
these need updates?

  include/asm-generic/irq.h defines NR_IRQS if not defined yet
  arch/arm/include/asm/irq.h defines NR_IRQS to NR_IRQS_LEGACY
  arch/arm/kernel/irq.c uses NR_IRQS
  arch/sh/include/asm/irq.h defines NR_IRQS to 8
  kernel/irq/internals.h uses NR_IRQS to define IRQ_BITMAP_BITS

> Nothing in any
> generic code is supposed to rely on NR_IRQS.

I guess that means these uses are suspect:

  $ git grep -w NR_IRQS | grep -v "^arch" | grep -v "^kernel" | grep -v "^drivers/irqchip" | grep -v "^include"
  drivers/input/keyboard/lpc32xx-keys.c:	if (irq < 0 || irq >= NR_IRQS) {
  drivers/mtd/nand/lpc32xx_mlc.c:	if ((host->irq < 0) || (host->irq >= NR_IRQS)) {
  drivers/net/hamradio/scc.c:static struct irqflags { unsigned char used : 1; } Ivec[NR_IRQS];
  drivers/pcmcia/pcmcia_resource.c:		if (irq > NR_IRQS)
  drivers/tty/serial/apbuart.c:	if (ser->irq < 0 || ser->irq >= NR_IRQS)
  drivers/tty/serial/ar933x_uart.c:	if (ser->irq < 0 || ser->irq >= NR_IRQS)
  drivers/tty/serial/lantiq.c:	if (ser->irq < 0 || ser->irq >= NR_IRQS)
  drivers/tty/serial/m32r_sio.c:static struct irq_info irq_lists[NR_IRQS];

Bjorn
