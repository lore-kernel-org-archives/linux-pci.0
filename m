Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:56039 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176Ab3CZVhx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 17:37:53 -0400
Date: Tue, 26 Mar 2013 22:37:48 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
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
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: Re: [RFCv1 07/11] irqchip: armada-370-xp: add MSI support to
 interrupt controller driver
Message-ID: <20130326223748.242f0046@skate>
In-Reply-To: <201303262110.15582.arnd@arndb.de>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<201303261838.23246.arnd@arndb.de>
	<20130326214613.30fbdddf@skate>
	<201303262110.15582.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Arnd Bergmann,

On Tue, 26 Mar 2013 21:10:15 +0000, Arnd Bergmann wrote:

> > To which children? Only to the main-intc children? If so,
> > armada_370_xp_mpic_of_init() would be called with a 'device_node *'
> > that points to the main-intc, correct? Then it would have to go back up
> > in the Device Tree to find the msi node? It's doable of course, but
> > sounds strange, no?
> 
> I was thinking of registering two init functions as well.

But then which of the two init functions would do the of_iomap() (or
whatever ioremap()ing function you use) ?

Remember, the very reason what we have *one* driver for both interrupt
controllers is because the registers are completely mixed. So to me
it's really the case of *one* device providing *two* features, like a
device that would be both an Ethernet interface and a SPI controller.
You have a single ->probe() function that gets called when the device
is detected, and this ->probe() function registers both an Ethernet
interface and a SPI controller.

To me, the case we have here is really identical: we have one single set
of registers that provide multiple features.

> > To me, the topology of the hardware is really that a single device
> > provides two features: the main interrupt controller and the MSI
> > interrupt controller. But I will adapt to whatever DT binding you
> > propose.
> 
> My preference would be to have no sub-nodes but rather make the
> code deal with an interrupt controller that has an interrupt domain
> for regular IRQs but can also handle MSI.

Hum, ok.

> > > I still wonder if the real solution shouldn't instead be to make the
> > > irq domain code MSI aware. For instance, you don't really need a
> > > cell to describe an interrupt because the interrupt number is
> > > not a hardware property. So an MSI using device doesn't really
> > > needs an "msis" or "interrupts" property, just an "msi-parent",
> > > and we can add code to handle as a separate domain even if you
> > > have a single device node that can do both level and message
> > > interrupts.
> > 
> > So the msi-parent property should point to the single mpic node? But
> > then the IRQ domain for MSI cannot be registered on this single MPIC
> > node. Then, what would be the first argument of:
> > 
> >         armada_370_xp_msi_domain =
> >                 irq_domain_add_linear(msi_node, PCI_MSI_DOORBELL_NR,
> >                                       &armada_370_xp_msi_irq_ops, NULL);
> > 
> > and how would the PCIe driver get a pointer to this IRQ domain? (In the
> > currently proposed code, it just does a irq_find_host(), which sounded
> > very simple and straightforward).
> 
> I guess one way would be to have a single domain that is responsible
> for the controller and handles both MSI and legacy interrupts. That
> could probably be done without changes to the interrupt domain code.
> 
> Another option would be to add an irq_domain_add_msi() function that
> creates a domain which is also tied to the same device node but does
> not interact with it when going through the legacy interrupts.
> You could then add a matching msi_find_host() or irq_find_msi_host()
> function to return the domain.

This option seems doable. Not sure yet how to do it exactly, but at
least I understand the idea.

> > To clarify: I really don't mind reworking the code, but unfortunately
> > "make the IRQ domain code MSI aware" is too vague for me to understand
> > the direction you're thinking of.
> 
> I don't have specific code in mind yet, mainly playing around with the
> possibilities for now.

Sure, I understand. But I also don't have specific ideas: the current
code works fine for me, and I don't find it really ugly. So if you don't
point me in the direction that you think would make the code less ugly,
then I'm lost.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
