Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:44010 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753007Ab2FRW6P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 18 Jun 2012 18:58:15 -0400
Message-ID: <1340060143.2372.50.camel@pasglop>
Subject: Re: [PATCH v3 1/2] powerpc/PCI: move DMA & IRQ init to device_add()
 notification path
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>,
	Michal Simek <monstr@monstr.eu>,
	microblaze-uclinux@itee.uq.edu.au, linux-pci@vger.kernel.org,
	Jesse Larrew <jlarrew@linux.vnet.ibm.com>,
	jbarnes@virtuousgeek.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linuxppc-dev@lists.ozlabs.org
Date: Tue, 19 Jun 2012 08:55:43 +1000
In-Reply-To: <CAErSpo6mbzqMuewBySk5kA8E9RwOVZqOEcnM4Hy541B3pta9SQ@mail.gmail.com>
References: <20120523222635.24276.80023.stgit@bhelgaas.mtv.corp.google.com>
	 <20120523223700.24276.76804.stgit@bhelgaas.mtv.corp.google.com>
	 <CAErSpo6mbzqMuewBySk5kA8E9RwOVZqOEcnM4Hy541B3pta9SQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2012-06-18 at 15:06 -0600, Bjorn Helgaas wrote:
> We're moving the CardBus IRQ config from before pci_bus_add_devices()
> to after.  I see why you did that: we're proposing to do the powerpc
> DMA & IRQ setup in pci_bus_add_devices(), so we don't want to have the
> powerpc IRQ init clobber the CardBus IRQ config.
> 
> But a driver can claim the device as soon as we call
> pci_bus_add_devices(), so we're potentially changing dev->irq after a
> driver has already looked at it, which sounds like a bug.
> 
> There are only five possibilities for powerpc pci_irq_fixup:
> 
>       ppc47x_pci_irq_fixup
>       mpc85xx_cds_pci_irq_fixup
>       maple_pci_irq_fixup
>       pmac_pci_irq_fixup
>       rtas_msi_pci_irq_fixup
> 
> If these were normal PCI header quirks instead, they could run
> earlier, and we wouldn't need to move this
> cardbus_config_irq_and_cls() call.  Is it possible to make these
> quirks, Ben?

Wait ... why are those fixups relevant ? They have to run after
pci_read_irq_line() (which should have been called pcibios_read_irq_line
really) but that's fine, we call both back to back....

The problem has to do with the fact that we setup pdev->irq inside
pci_bus_add_devices() with the new proposed code (the fixup itself is
just a detail).

You want cardbus to "quirk" the irq after that's been fixed up... maybe
that's a case for moving cardbus_config_irq_and_cls() to
pci_enable_device() ? Or add another hook inside
pci_bus_add_devices()...

Cheers,
Ben.


