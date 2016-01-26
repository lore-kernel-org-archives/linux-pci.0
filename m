Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33487 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932758AbcAZI1o (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jan 2016 03:27:44 -0500
Date: Tue, 26 Jan 2016 09:26:29 +0100 (CET)
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
In-Reply-To: <20160125205803.GA10272@localhost>
Message-ID: <alpine.DEB.2.11.1601260825510.3886@nanos>
References: <1453705178-27389-1-git-send-email-chen.fan.fnst@cn.fujitsu.com> <20160125205803.GA10272@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 25 Jan 2016, Bjorn Helgaas wrote:
> On Mon, Jan 25, 2016 at 02:59:38PM +0800, Chen Fan wrote:

> > i801_smbus 0000:00:1f.3: PCI INT C: no GSI
> > i801_smbus 0000:00:1f.3: Failed to allocate irq 255: -16
> > i801_smbus: probe of 0000:00:1f.3 failed with error -16

The current code does not not fail when the interrupt request fails. It
reports it and clears the IRQ feature flag.

> > @@ -436,7 +437,15 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
> >  	 * driver reported one, then use it. Exit in any case.
> >  	 */
> >  	if (gsi < 0) {
> > -		if (acpi_isa_register_gsi(dev))
> > +#ifdef CONFIG_X86
> > +		/*
> > +		 * The Interrupt Line value of 0xff is defined to mean "unknown"
> > +		 * or "no connection" (PCI 3.0, Section 6.2.4, footnote on page
> > +		 * 223), using ~0U as invalid IRQ.
> > +		 */

And why would this be x86 specific? PCI3.0 is architecture independent, right?

> > +		dev->irq = (dev->irq == 0xff) ? IRQ_INVALID : dev->irq;
> 
> It's much simpler and clearer to write:
> 
>   if (dev->irq == 0xff)
>     dev->irq = IRQ_INVALID;

I do not understand that IRQ_INVALID business at all.

> > +#endif
> > +		if (!irq_is_valid(dev->irq) || acpi_isa_register_gsi(dev))
> >  			dev_warn(&dev->dev, "PCI INT %c: no GSI\n",
> >  				 pin_name(pin));
> >  

The existing code already drops into this place because 
acpi_isa_register_gsi() fails.

> > i801_smbus 0000:00:1f.3: PCI INT C: no GSI

What extra value does that !irq_is_valid() provide?

And how does setting dev->irq to ~0U prevent that request_irq() is called in
the i801 device driver? Not at all, AFAICT. It will just fail with a different
error.

So the whole 'fix' relies on the fact that irq ~0U does not exist (at least
not today) and therefor the false sharing with some other driver using irq 255
will not happen.

Relying on undocumented behaviour is not a fix, that's voodoo programming.

The proper solution here is to flag that this device does not have an
interrupt connected and act accordingly in the device driver, i.e. do not call
request_irq() in the first place.

> > +static inline bool irq_is_valid(unsigned int irq)
> > +{
> > +#ifdef CONFIG_X86
> > +	if (irq == IRQ_INVALID)
> > +		return false;
> > +#endif
> > +	return true;
> > +}
> 
> I don't like the x86 ifdef.  I'd prefer:
> 
>   static inline bool irq_valid(unsigned int irq)
>   {
>     if (irq < NR_IRQS)
>       return true;
>     return false;
>   }
>
> This could be used in many of the places that currently use NR_IRQS.

No. NR_IRQS cannot be used at all if sparse irqs are enabled. Nothing in any
generic code is supposed to rely on NR_IRQS.

Thanks,

	tglx

