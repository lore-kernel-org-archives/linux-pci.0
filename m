Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:56134 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940Ab3CZVr2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 17:47:28 -0400
Date: Tue, 26 Mar 2013 22:47:13 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
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
Message-ID: <20130326224713.04c85cd3@skate>
In-Reply-To: <201303262131.45410.arnd@arndb.de>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130326180245.GA22775@obsidianresearch.com>
	<20130326221654.34bce6d7@skate>
	<201303262131.45410.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Arnd Bergmann,

On Tue, 26 Mar 2013 21:31:45 +0000, Arnd Bergmann wrote:
> On Tuesday 26 March 2013, Thomas Petazzoni wrote:
> > > FWIW, MSI-X is not restricted to 16 bits, so if you can detect from
> > > the PCI layer if it is setting up MSI or MSI-X you could allocate low
> > > bits first to MSI-X and high bits first to MSI, increasing the number
> > > of available MSI/MSI-X vectors.
> > 
> > This could be an improvement. There are also other, non-per-CPU,
> > doorbell interrupts that could potentially be used. Can we consider
> > this a possible improvement, and not something that is fundamentally
> > necessary? For now, I'm trying to get the current feature set merged,
> > and not necessarily to extend it to cover all possible features of the
> > hardware.
> 
> If we are extending the DT binding for the current feature, we should
> at least think about how it would look like for future extensions, to
> make sure it won't be fundamentally incompatible.

Sure.

> > > > +   - marvell,doorbell: Gives the physical address at which PCIe
> > > > +     devices should write to signal an MSI interrupt.
> > > 
> > > Why is this necessary? Can't the doorbell register physical address be
> > > computed by the driver? AFAIK there is no possibility for address
> > > translation on SOC inbound TLPs.
> > 
> > It is the responsibility of the PCIe driver to prepare the 'struct
> > msi_msg', which contains the physical address at which the PCIe device
> > should write to trigger an MSI. But this physical address is part of
> > the interrupt controller registers, so there is no way for the PCIe
> > driver to magically know about it.
> 
> If we introduce an irq_find_msi_host() interface, we can also introduce
> an interface to return the doorbell register, or more. I suppose
> we could actually have a generic version of your mvebu_pcie_setup_msi_irq()
> function that looks up the domain from the device node and calls
> a new irq_domain_ops function, which allocates a free MSI hwirq number,
> creates a mapping for it, and fills out a struct msi_msg with the
> doorbell register and data.

Ok, sounds like a plan. I must admit I'm not very familiar with the IRQ
domain code, but I guess I should take this as an opportunity to become
a little bit more familiar :)

> > > Thinking about it a bit, maybe less magic code is needed here, be
> > > explicit about the available interrupts in the DT:
> > > 
> > > pcie-controller {
> > >    msi-interrupts = <0xd0020a04 (1<<16) &msi 16
> > >                      0xd0020a04 (1<<17) &msi 17
> > >                      [..]
> > >    msi-x-interrupts = <0xd0020a04 (1<<1) &msi 1
> > >                        0xd0020a04 (1<<2) &msi 2
> > >                        [..]
> > > 
> > > There is a better chance of that supporting other Marvell SOCs.. Not
> > > sure, just throwing it out there.
> > 
> > Isn't that very verbose, to list each and every MSI interrupt, bit per
> > bit? I'm fine with doing that (except maybe implement both MSI and
> > MSI-X support, I'd like to stick with the current feature set for now),
> > but it sounds like a lot more code in the DT and a lot more code in the
> > driver to parse this... just to get the exact same feature.
> > 
> > Arnd, what is your feeling about this suggestion?
> 
> I think we should only need an msi-parent property and let the details
> be handled by the irq driver.

Ok. Having the irq driver allocate the MSI interrupt number as you
suggested above seems a good idea.

> > > Also, I'm not super familiar with the irq stuff, but is
> > > irq_find_mapping the best way? Most of the drivers I looked at used
> > > irq_alloc_descs to get a contiguous range of irq numbers and then just
> > > used a simple offset in the handle_irq...
> > 
> > I'll let Arnd answer this one, but I'm pretty sure that using IRQ
> > domains is the way to go. The fact that a number of drivers don't yet
> > use IRQ domains is maybe just because they haven't been converted yet.
> 
> Yes, irq_find_mapping is what we should be using here.

Ok, thanks.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
