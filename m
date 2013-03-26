Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:50975 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981Ab3CZVzu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Mar 2013 17:55:50 -0400
Date: Tue, 26 Mar 2013 15:55:46 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
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
Message-ID: <20130326215546.GA8650@obsidianresearch.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364316746-8702-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130326180245.GA22775@obsidianresearch.com>
 <20130326221654.34bce6d7@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130326221654.34bce6d7@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 26, 2013 at 10:16:54PM +0100, Thomas Petazzoni wrote:

> > FWIW, MSI-X is not restricted to 16 bits, so if you can detect from
> > the PCI layer if it is setting up MSI or MSI-X you could allocate low
> > bits first to MSI-X and high bits first to MSI, increasing the number
> > of available MSI/MSI-X vectors.
> 
> This could be an improvement. There are also other, non-per-CPU,
> doorbell interrupts that could potentially be used. Can we consider
> this a possible improvement, and not something that is fundamentally
> necessary? For now, I'm trying to get the current feature set merged,
> and not necessarily to extend it to cover all possible features of the
> hardware.

A major point of MSI is to be able to direct interrupts on a CPU by
CPU basis. Looks like XP has per-cpu and all-cpu doorbell bits?

Combined with this:

> It is the responsibility of the PCIe driver to prepare the 'struct
> msi_msg', which contains the physical address at which the PCIe device
> should write to trigger an MSI. But this physical address is part of

Makes me think the split of responsibility created by moving the MSI
ops into the PCI host structure is not correct.

The PCIe host driver just seems to get in the way, it has no knowledge
it is adding to the process.

irqchip knows:
 - what the physical address of the doorbell is
 - how to construct an address that is per-cpu or all-cpu
 - which bits in the doorbell registers are allocated and which are
   free

pci has none of that info.

Looking at this some more, there is tonnes of stuff in linux that when
a PCI MSI is allocated a special IRQ number is created for it that has
special properties - eg set_affinity on that number actually goes into
the MSI table and changes it.

The cleanest would be to keep the doorbell driver purely related to
the doorbell and when a request for a PCI MSI comes in allocate a new
irq_chip (like arch/x86/kernel/apic/io_apic.c does) that has all the
special PCI stuff and chain it to the proper bit in the doorbell. 

Optimizing to remove function calls from the interrupt stack could
happen later.

> > However, Marvell's doorbell can be controlled at the destination, so
> > it is better to handle it that way, especially since it creates
> > symmetry with the IPI usage.
> 
> Hum, ok. But the MSI and IPI are handled quite differently: MSIs have
> to call handle_IRQ(), while IPIs have to call handle_IPI(), so you'd
> still have to distinguish between IPIs and MSIs. In the current driver,
> IPIs don't have an associated irq_chip structure.

Once you have a proper generic interrupt driver you can go ahead and
use request_irq to grab N bits of the doorbell register and assign
them to a handler that only calls handle_IPI(ipinr,get_irq_regs()).

It is not necessary to keep IPI and the irqchip driver convoluted
together.

> Again, I don't see how it's possible to not care whether it's MSI or
> IPI. IPIs have to call handle_IPI() which is a ARM-specific call, and I
> don't understand how handle_fasteoi_irq() would end up calling
> handle_IPI().

- The main IRQ vector is entered, it decodes the main cause register
  and calls the handler for the doorbell
- The doorbell handler is setup as a chained handler and it uses
  handle_fasteoi_irq to enter into armada_370_xp_handle_irq
- armada_370_xp_handle_irq then runs through all bits and calls their
  handlers
- the handler for IPI bits is associated with the IPI handler that
  simply calls handle_IPI(...)

handle_fasteoi_irq acks's and clears the handled bits in the doorbell
register at the proper time.

> I'll let Arnd answer this one, but I'm pretty sure that using IRQ
> domains is the way to go. The fact that a number of drivers don't yet
> use IRQ domains is maybe just because they haven't been converted yet.

Maybe, but they have irq domain code as well.. I'm curious about the
answer too :)

Jason
