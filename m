Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:60044 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbbKMOAP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Nov 2015 09:00:15 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Magnus <magnus.damm@gmail.com>,
	Will Deacon <will.deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>
Subject: Re: PCIe host controller behind IOMMU on ARM
Date: Fri, 13 Nov 2015 14:59:40 +0100
Message-ID: <4744053.Iz6Y8QJQYF@wuerfel>
In-Reply-To: <PS1PR06MB11801D6BBC939517912BE185F5110@PS1PR06MB1180.apcprd06.prod.outlook.com>
References: <PS1PR06MB11807CBE8EB2AC6B0158D2B5F52A0@PS1PR06MB1180.apcprd06.prod.outlook.com> <4169020.aC5VXkILQm@wuerfel> <PS1PR06MB11801D6BBC939517912BE185F5110@PS1PR06MB1180.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 13 November 2015 13:03:11 Phil Edworthy wrote:
> 
> > > Then pci_device_add() sets the devices coherent_dma_mask to 4GiB before
> > > calling of_pci_dma_configure(). I assume it does this on the basis that this is a
> > > good default for PCI drivers that don't call dma_set_mask().
> > > So if arch_setup_dma_ops() walks up the parents to limit the mask, you'll hit
> > > this mask.
> > 
> > arch_setup_dma_ops() does not walk up the hierarchy, of_dma_configure()
> > does this before calling arch_setup_dma_ops(). The PCI devices start out
> > with the 32-bit mask, but the limit should be whatever PCI host uses.
> Ok, so of_dma_configure() could walk up the tree and restrict the dma
> mask to whatever parents limit it to. Then it could be overridden by
> a dma-ranges entry in the DT node, right?

No, the dma-ranges properties tell you what the allowed masks are,
this is what of_dma_configure() looks at.

> If so, one problem I can see is PCI controllers already use the
> dma-ranges binding but with 3 address cells since it also specifies
> the PCI address range.
> 
> I noticed that of_dma_get_range() skips straight to the parent node.
> Shouldn't it attempt to get the dma-ranges for the device's node
> first?

No, the dma-ranges explain the capabilities of the bus, this is
what you have to look at. The device itself may have additional
restrictions, but those are what the driver knows based on the
compatibility value when it passes the device specific mask into
dma_set_mask()

> I mean most hardware is limited by the peripheral's
> capabilities, not the bus. If fact, of_dma_get_range() gets the number
> of address and size cells from the device node, but gets the dma-ranges
> from the parent. That seems a little odd to me.

of_dma_get_range() calls of_n_addr_cells()/of_n_size_cells(), which get
the #address-cells/#size-cells property from the parent device (except
for the root, which is special).

> The only other problem I can see is that currently all PCI drivers can
> try to set their dma mask to 64 bits. At the moment that succeeds
> because there are no checks.

Right, this is the main bug we need to fix.

> Until devices using them have their DTs
> updated with dma-ranges, we would be limiting them to a 32 bit mask. I
> guess that's not much of an issue in practice.

Correct. I've tried to tell everyone about this when they added device
nodes for DMA capable devices. In most cases, they want 32-bit masks
anyway.

	Arnd
