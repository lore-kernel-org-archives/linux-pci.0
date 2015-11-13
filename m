Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:62123 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753039AbbKMNDT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 13 Nov 2015 08:03:19 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Magnus <magnus.damm@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: PCIe host controller behind IOMMU on ARM
Date: Fri, 13 Nov 2015 13:03:11 +0000
Message-ID: <PS1PR06MB11801D6BBC939517912BE185F5110@PS1PR06MB1180.apcprd06.prod.outlook.com>
References: <PS1PR06MB11807CBE8EB2AC6B0158D2B5F52A0@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <6255198.JqytBn7T9E@wuerfel>
 <PS1PR06MB11802B4278C95E3808EEBDD5F5120@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <4169020.aC5VXkILQm@wuerfel>
In-Reply-To: <4169020.aC5VXkILQm@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On 12 November 2015 16:17, Arnd Bergmann wrote:
> On Thursday 12 November 2015 15:33:41 Phil Edworthy wrote:
> > On 12 November 2015 09:49, Arnd Bergmann wrote:
> > > On Thursday 12 November 2015 09:26:33 Phil Edworthy wrote:
> > > > On 11 November 2015 18:25, LIviu wrote:
> > > > > On Mon, Nov 09, 2015 at 12:32:13PM +0000, Phil Edworthy wrote:
> > >
> > > of_dma_configure calls of_dma_get_range to do all this for the PCIe host,
> > > and then calls arch_setup_dma_ops() so the architecture specific code can
> > > enforce the limits in dma_set_mask and pick an appropriate set of dma
> > > operations. The missing part is in the implementation of
> arch_setup_dma_ops,
> > > which currently happily ignores the base and limit.
> > I don't think it's as simple as that, though I could be wrong!
> >
> > First off, of_dma_configure() sets a default coherent_dma_mask to 4GiB.
> > This default is set for the 'platform soc' device. For my own testing I increased
> > this to DMA_BIT_MASK(63). Note that setting it to DMA_BIT_MASK(64) causes
> > boot failure that I haven't looked into.
> 
> Most platform devices actually need the 32-bit mask, so we intentionally
> followed what PCI does here and default to that and require platform drivers
> to explicitly ask for a larger mask if they need it.
Ok, that makes sense.


> > Then pci_device_add() sets the devices coherent_dma_mask to 4GiB before
> > calling of_pci_dma_configure(). I assume it does this on the basis that this is a
> > good default for PCI drivers that don't call dma_set_mask().
> > So if arch_setup_dma_ops() walks up the parents to limit the mask, you'll hit
> > this mask.
> 
> arch_setup_dma_ops() does not walk up the hierarchy, of_dma_configure()
> does this before calling arch_setup_dma_ops(). The PCI devices start out
> with the 32-bit mask, but the limit should be whatever PCI host uses.
Ok, so of_dma_configure() could walk up the tree and restrict the dma
mask to whatever parents limit it to. Then it could be overridden by
a dma-ranges entry in the DT node, right?
If so, one problem I can see is PCI controllers already use the
dma-ranges binding but with 3 address cells since it also specifies
the PCI address range.

I noticed that of_dma_get_range() skips straight to the parent node.
Shouldn't it attempt to get the dma-ranges for the device's node
first? I mean most hardware is limited by the peripheral's
capabilities, not the bus. If fact, of_dma_get_range() gets the number
of address and size cells from the device node, but gets the dma-ranges
from the parent. That seems a little odd to me.

The only other problem I can see is that currently all PCI drivers can
try to set their dma mask to 64 bits. At the moment that succeeds
because there are no checks. Until devices using them have their DTs
updated with dma-ranges, we would be limiting them to a 32 bit mask. I
guess that's not much of an issue in practice.


> > Finally, dma_set_mask_and_coherent() is called from the PCI card driver
> > but it doesn't check the parents dma masks either.
> 
> The way I think this should work is that arch_setup_dma_ops() stores the
> allowed mask in the struct device, and that dma_set_mask compares the
> mask against that.
That makes sense.

Thanks for your help,
Phil
