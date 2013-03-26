Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:48588 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753451Ab3CZW1D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Mar 2013 18:27:03 -0400
Date: Tue, 26 Mar 2013 16:26:56 -0600
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
Message-ID: <20130326222656.GB8650@obsidianresearch.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364316746-8702-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130326180245.GA22775@obsidianresearch.com>
 <20130326221654.34bce6d7@skate>
 <20130326215546.GA8650@obsidianresearch.com>
 <20130326230656.3326e187@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130326230656.3326e187@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 26, 2013 at 11:06:56PM +0100, Thomas Petazzoni wrote:

> > The PCIe host driver just seems to get in the way, it has no knowledge
> > it is adding to the process.
> > 
> > irqchip knows:
> >  - what the physical address of the doorbell is
> >  - how to construct an address that is per-cpu or all-cpu
> >  - which bits in the doorbell registers are allocated and which are
> >    free
> > 
> > pci has none of that info.
> 
> Wait, wait. Did you look at the Tegra PCIe driver? In the Tegra case,
> the MSI stuff is handled completely by the PCIe unit, and does not need
> the special interaction with the IRQ controller driver that I need.

Yes, but only briefly. It doesn't matter if the mechanisms are in the
PCI-E register block or someplace else. If irqchip is providing the
interface then the PCI-E driver would have to also instantiate an
irqchip block.

This is no different from what would be required to handle INTx on
Marvell, the PCI-E driver would have to create a chained irqchip from
the PEX interrupt and decode the cause register into INTA/B/C/D.

> > > Again, I don't see how it's possible to not care whether it's MSI or
> > > IPI. IPIs have to call handle_IPI() which is a ARM-specific call, and I
> > > don't understand how handle_fasteoi_irq() would end up calling
> > > handle_IPI().
> > 
> > - The main IRQ vector is entered, it decodes the main cause register
> >   and calls the handler for the doorbell
> > - The doorbell handler is setup as a chained handler and it uses
> >   handle_fasteoi_irq to enter into armada_370_xp_handle_irq
> > - armada_370_xp_handle_irq then runs through all bits and calls their
> >   handlers
> > - the handler for IPI bits is associated with the IPI handler that
> >   simply calls handle_IPI(...)
> > 
> > handle_fasteoi_irq acks's and clears the handled bits in the doorbell
> > register at the proper time.
> 
> Could you propose some code that implements this? The existing code
> works fine, and is modeled after what the GIC IRQ driver is doing. I
> don't say what you're proposing is not interesting, but just that it
> looks like every time I come with some code, you're suggesting me to
> 'reinvent' the whole world, and you've never come up with some code to
> help in a direction or another.

I'll send you my doorbell driver for Kirkwood - it doesn't attempt to
generically solve the MSI problem, but the basic template shows how to
wire up the doorbell concept to irqchip's generic code, and it works
in the MSI role with lots of rather ugly hacking..

The XP driver is taking some small shortcuts because it only uses the
doorbell for IPI..

Jason
