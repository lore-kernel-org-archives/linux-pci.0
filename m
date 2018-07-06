Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 6 Jul 2018 09:13:14 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 2/3] PCI: mvebu: Convert to use pci_host_bridge directly
Message-ID: <20180706091314.2f221c4b@windsurf>
In-Reply-To: <20180705162357.GB13716@red-moon>
References: <20180629091007.31069-1-thomas.petazzoni@bootlin.com>
 <20180629091007.31069-3-thomas.petazzoni@bootlin.com>
 <20180705162357.GB13716@red-moon>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Nadav Haklai <nadavh@marvell.com>, Russell King <linux@arm.linux.org.uk>,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hello Lorenzo,

Thanks for your review and feedback!

On Thu, 5 Jul 2018 17:23:57 +0100, Lorenzo Pieralisi wrote:
> On Fri, Jun 29, 2018 at 11:10:06AM +0200, Thomas Petazzoni wrote:
> 
> [...]
> 
> > +	pcie->mem.name = "PCI MEM";
> > +	pci_add_resource_offset(&pcie->resources, &pcie->mem, 0);  
> 
> Nit: pci_add_resource() would do.

Actually on this one, I wasn't sure of my conversion. The original
(i.e current) code is:

-	if (resource_size(&pcie->realio) != 0)
-		pci_add_resource_offset(&sys->resources, &pcie->realio,
-					sys->io_offset);
-
-	pci_add_resource_offset(&sys->resources, &pcie->mem, sys->mem_offset);
-	pci_add_resource(&sys->resources, &pcie->busn);

I'm not sure what sys->io_offset and sys->mem_offset are. I dumped
them, they are both zero, and reading the ARM PCI code, I couldn't see
how they would be different than zero.

Is my understanding correct ?

> >  	pcie->nports = i;
> >  
> > -	for (i = 0; i < (IO_SPACE_LIMIT - SZ_64K); i += SZ_64K)
> > -		pci_ioremap_io(i, pcie->io.start + i);  
> 
> Mmmm..I think that arch/arm let the mach override the mapping attributes
> for MVEBU (for some platforms) so replacing this with
> pci_remap_iospace() may trigger a regression, we need to investigate.

Ah, that's a *very* good point. We do override the mapping attributes
on Armada 370/XP, in
https://elixir.bootlin.com/linux/latest/source/arch/arm/mach-mvebu/coherency.c#L177.

What is your preference ? We stick to pci_ioremap_io(), or we do
something to extend pci_remap_iospace() to cover this situation ?

In general, I like the current trend of having PCI be more like other
bus subsystems, where the code really is located in drivers/pci/, and
not spread across architectures in various arch/<foo>/ folders.

> Also, I do not know why the loop above does not pay attention to the
> real IO space resource size, whether that's on purpose or just a left
> over.

This code was added by me in commit
31e45ec3a4e73dcbeb51e03ab559812ba3e82cc2, which explains the rationale
behind this change. Since we're doing this at probe time, we have no
idea how much I/O space each PCI endpoint will require, and the Device
Tree binding for this PCI controller doesn't give the size of the I/O
space for each PCI port.

On this Marvell platforms, there are two indirections between the
virtual addresses and the actual access to the device:

  virtual address  -->  physical address  --> "MBus address"
                 ^^^^^^^                 ^^^^^^
                   MMU                  MBus windows

The pci_ioremap_io() configures the MMU, of course. But this is not
sufficient for the I/O space of a particular device to be accessible: a
MBus window has to be created. And those MBus window have a minimal
size of 64 KB anyway.

Therefore, calling pci_ioremap_io() with an hardcoded 64 KB is not a
big deal. It consumes a few more PTEs indeed, but that's about it: the
IO space will anyway be backed by a 64 KB MBus window, even if the PCI
endpoint actually uses less of that.

Does that make sense ? I suggest you have a look at the DT binding for
pci-mvebu to understand a bit more the whole thing.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
