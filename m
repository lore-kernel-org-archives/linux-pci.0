Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:35306 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933147Ab3HGWFD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Aug 2013 18:05:03 -0400
Date: Thu, 8 Aug 2013 00:04:43 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCHv7 07/13] irqdomain: add function to find a MSI
 irq_domain
Message-ID: <20130808000443.17f57875@skate>
In-Reply-To: <1375908620.9300.3.camel@pasglop>
References: <1375867954-2320-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1375867954-2320-8-git-send-email-thomas.petazzoni@free-electrons.com>
	<1375908620.9300.3.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Benjamin Herrenschmidt,

On Thu, 08 Aug 2013 06:50:20 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2013-08-07 at 11:32 +0200, Thomas Petazzoni wrote:
> > Now that an irq_domain can be associated to a msi_chip structure, a
> > given PCIe driver will want to find this irq_domain, based on the
> > Device Tree node of the interrupt controller, as pointed by the
> > 'msi-controller' DT property.
> 
> I still don't quite understand why you have to do all that.
> 
> > However, since on those platforms a single piece of hardware,
> > represented by a single DT node can provide both a "normal" IRQ domain
> > and a MSI-type IRQ domain, we need separate lookup functions to
> > distinguish them.
> 
> At least on power we have cases where an mpic does both MSIs and LSIs,
> we have the XICS that happily mixes both in a single large domain,
> etc... and never needed any of that.
> 
> I don't quite understand what problem that stuff is trying to solve
> really. Are you trying to avoid having an added MSI bitmap allocator for
> the MSI side of the PIC and use the irq domain stuff both as your virq
> and your hwirq allocator ?

Yes. Originally, the allocator was in the driver, but Grant Likely
suggested that it should be done by the irqdomain code itself. If
needed, I can dig the link, but I already gave you the pointers to each
iteration of this patch series, and the comment from Grant is
definitely part of one of those threads.

Basically, the PCIe driver in drivers/pci/host/pci-mvebu.c needs to
give the Linux PCI core a pointer to a msi_chip, which contains
operations to setup/teardown an MSI irq.

On Marvell platforms, it's directly the main interrupt controller that
provides the MSI mechanism. So the msi_chip is created and handled by
the drivers/irqchip/irq-armada-370-xp.c driver. It implements the
->setup_irq() and ->teardown_irq() operations of the msi_chip
structure, using irq_domain functions, as Grant suggested that the
irq_domain infrastructure should be used instead of having another
bitmap allocator in each MSI driver.

Then, we need to "connect" the PCI driver and the IRQ driver. Arnd
Bergmann suggested that the DT should look like this:

	mpic {
		interrupt-controller;
		msi-controller;
		...
	};

	pcie-controller {
		msi-parent = <&mpic>;
		...
	};

So, the pcie-controller needs to be able, from a DT node pointer to
"mpic" to get the corresponding msi_chip. The way to do this has gone
through different steps over the different iteration of the patch
series:

 (1) A small registry in drivers/pci that associates a device_node*
     with a msi_chip*. The IRQ driver registers the msi_chip* with the
     corresponding device_node*, and the PCI driver lookups the right
     msi_chip* using the device_node* pointer by the 'msi-parent'
     property.

     Bjorn Helgaas disliked that and suggested that the registry should
     be in drivers/of/

 (2) The same registry was moved to drivers/of/, with the same
     principle, except that the functions were renamed to match the
     conventions of drivers/of/.

     Rob Herring (drivers/of maintainer) ACKed this approach. However,
     later, Grant Likely came in the discussion and NAKed this
     approach, and suggested instead that the irq_domain should be
     associated with the msi_chip directly.

 (3) The current approach, where irq_domain contains a pointer to the
     msi_chip. So the PCI driver can look up an irq_domain using the
     device_node* pointer to by its 'msi-parent' property. However,
     there are *two* irq_domain that are related to the same 'mpic'
     node: the irq_domain for normal interrupts, and the irq_domain for
     MSI interrupts. And they should not be confused together. This is
     what this patch does: it makes sure that irq_find_host() matches
     only "normal irq_domain", while irq_find_msi_host() matches only
     "MSI irq_domain".

Again, this has been discussed at lengths in the previous iterations,
for which I already gave you all the links, as you requested in a
private e-mail. It'd be great if this discussion was read seriously,
because I really have the feeling we are restarting from zero on this
whole MSI thing...

Thanks,

Thomas Petazzoni
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
