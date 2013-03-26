Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:55911 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879Ab3CZVRA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 17:17:00 -0400
Date: Tue, 26 Mar 2013 22:16:54 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: Re: [RFCv1 07/11] irqchip: armada-370-xp: add MSI support to
 interrupt controller driver
Message-ID: <20130326221654.34bce6d7@skate>
In-Reply-To: <20130326180245.GA22775@obsidianresearch.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1364316746-8702-8-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130326180245.GA22775@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Tue, 26 Mar 2013 12:02:45 -0600, Jason Gunthorpe wrote:

> > This commit introduces the support for the MSI interrupts in the
> > armada-370-xp interrupt controller driver. It registers an IRQ
> > domain associated with the 'msi' node in the Device Tree, which the
> > PCI controller will refer to in a followup commit.
> 
> I've got some MSI stuff working on Kirkwood using the doorbells, so I
> can confirm this general approach works in HW.
> 
> What do you think it would take to extend this to other Marvell SOCs?

A bit of time. It is on my list to use the PCIe driver on Kirkwood and
other Marvell SoCs as well.

> BTW, in my testing on Kirkwood I found that register ..40010 in the
> PEX had to be set to the internal register base to make this work. Did
> you find something similar?

The original code I used was prepared by Lior Amsalem, and it seems
like it was not needed, maybe because the bootloader had already
configured the PCIe interfaces. I'll have a look to see if those
registers already contain the right values, but certainly it would be
safer if the PCIe driver was setting their value. Not a big deal to
fix, I believe.

> > The MSI interrupts use the 16 high doorbells, and are therefore
> > notified using IRQ1 of the main interrupt controller.
> 
> I was initially a bit surprised this was the high doorbell bits, but I
> checked and it is right, the 16 bit MSI maps to the high two bytes in
> the 32 bit MemWr TLP.

Right. The low 8 bits are used for the IPIs, and the high 16 bits are
used for MSIs. I think it has been chosen to be like this because then
we have two different interrupt numbers for the IPIs and the MSIs,
which make the thing easy to handle in the IRQ controller driver.

> FWIW, MSI-X is not restricted to 16 bits, so if you can detect from
> the PCI layer if it is setting up MSI or MSI-X you could allocate low
> bits first to MSI-X and high bits first to MSI, increasing the number
> of available MSI/MSI-X vectors.

This could be an improvement. There are also other, non-per-CPU,
doorbell interrupts that could potentially be used. Can we consider
this a possible improvement, and not something that is fundamentally
necessary? For now, I'm trying to get the current feature set merged,
and not necessarily to extend it to cover all possible features of the
hardware.

> > +   - marvell,doorbell: Gives the physical address at which PCIe
> > +     devices should write to signal an MSI interrupt.
> 
> Why is this necessary? Can't the doorbell register physical address be
> computed by the driver? AFAIK there is no possibility for address
> translation on SOC inbound TLPs.

It is the responsibility of the PCIe driver to prepare the 'struct
msi_msg', which contains the physical address at which the PCIe device
should write to trigger an MSI. But this physical address is part of
the interrupt controller registers, so there is no way for the PCIe
driver to magically know about it.

Please see the code where we're using this:
https://github.com/MISL-EBU-System-SW/mainline-public/blob/marvell-pcie-msi-v1/drivers/pci/host/pci-mvebu.c#L844.

If you think this physical address can be "computed" by the driver, I'm
all open to suggestions.

> Thinking about it a bit, maybe less magic code is needed here, be
> explicit about the available interrupts in the DT:
> 
> pcie-controller {
>    msi-interrupts = <0xd0020a04 (1<<16) &msi 16
>                      0xd0020a04 (1<<17) &msi 17
>                      [..]
>    msi-x-interrupts = <0xd0020a04 (1<<1) &msi 1
>                        0xd0020a04 (1<<2) &msi 2
>                        [..]
> 
> There is a better chance of that supporting other Marvell SOCs.. Not
> sure, just throwing it out there.

Isn't that very verbose, to list each and every MSI interrupt, bit per
bit? I'm fine with doing that (except maybe implement both MSI and
MSI-X support, I'd like to stick with the current feature set for now),
but it sounds like a lot more code in the DT and a lot more code in the
driver to parse this... just to get the exact same feature.

Arnd, what is your feeling about this suggestion?

> Regarding the sub node, I'm not sure it should be necessary. You
> don't need to differentiate the MSI vs non-MSI case in the doorbell
> register at the interrupt controller level. Eg this ..
>   
> > +#ifdef CONFIG_PCI_MSI
> > +static struct irq_chip armada_370_xp_msi_irq_chip = {
> > +	.name = "armada_370_xp_msi_irq",
> > +	.irq_enable = unmask_msi_irq,
> > +	.irq_disable = mask_msi_irq,
> > +	.irq_mask = mask_msi_irq,
> > +	.irq_unmask = unmask_msi_irq,
> > +};
> 
> .. isn't necessary for doorbell. With MSI cases on other archs there
> is no local MSI interrupt controller, the MSI MemWr TLP directly
> creates an interrupt at the CPU. This requires using the *_msi_irq
> functions to control the interrupt at the source, since there is no
> control at the destination.
> 
> However, Marvell's doorbell can be controlled at the destination, so
> it is better to handle it that way, especially since it creates
> symmetry with the IPI usage.

Hum, ok. But the MSI and IPI are handled quite differently: MSIs have
to call handle_IRQ(), while IPIs have to call handle_IPI(), so you'd
still have to distinguish between IPIs and MSIs. In the current driver,
IPIs don't have an associated irq_chip structure.

> I used:
>        priv->gc = irq_alloc_generic_chip("kirkwood_doorbell_irq", 1,
>                                    irq_base, priv->base,
>                                    handle_fasteoi_irq);
>        [..]				  
>        ct->regs.mask = 4;
>        ct->regs.eoi = 0;
>        ct->chip.irq_eoi = irq_gc_eoi_inv;
>        ct->chip.irq_mask = irq_gc_mask_clr_bit;
>        ct->chip.irq_unmask = irq_gc_mask_set_bit;
> 
> Which should work correctly for the IPI and MSI cases. The
> handle_fasteoi_irq is important.

I don't understand how this can end up calling handle_IPI() when IPIs
are raised. There are no IPIs on Kirkwood, so are you sure the Kirkwood
logic can apply to the SMP case of Armada XP, which requires IPIs?

> >  #ifdef CONFIG_SMP
> >  void armada_mpic_send_doorbell(const struct cpumask *mask,
> > unsigned int irq) {
> > @@ -220,12 +280,39 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
> >  		if (irqnr > 1022)
> >  			break;
> >  
> > -		if (irqnr > 0) {
> > +		if (irqnr > 1) {
> >  			irqnr =
> > irq_find_mapping(armada_370_xp_mpic_domain, irqnr);
> >  			handle_IRQ(irqnr, regs);
> >  			continue;
> >  		}
> > +
> > +#ifdef CONFIG_PCI_MSI
> > +		/* MSI handling */
> > +		if (irqnr == 1) {
> > +			u32 msimask, msinr;
> > +
> > +			msimask = readl_relaxed(per_cpu_int_base +
> > +
> > ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS)
> > +				& PCI_MSI_DOORBELL_MASK;
> > +
> > +			writel(~PCI_MSI_DOORBELL_MASK,
> > per_cpu_int_base +
> > +			       ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
> 
> Be careful here, the ordering of the EOI in relation to the handler is
> important. If you use my stuff from above then the MSI and IPI cases
> are identical and the core code handles ack'ing the doorbell via
> irq_eoi at the right moment, you can just uniformly iterate over all
> 32 bits and there is no need to care if it is MSI or IPI.

Again, I don't see how it's possible to not care whether it's MSI or
IPI. IPIs have to call handle_IPI() which is a ARM-specific call, and I
don't understand how handle_fasteoi_irq() would end up calling
handle_IPI().

> Also, I'm not super familiar with the irq stuff, but is
> irq_find_mapping the best way? Most of the drivers I looked at used
> irq_alloc_descs to get a contiguous range of irq numbers and then just
> used a simple offset in the handle_irq...

I'll let Arnd answer this one, but I'm pretty sure that using IRQ
domains is the way to go. The fact that a number of drivers don't yet
use IRQ domains is maybe just because they haven't been converted yet.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
