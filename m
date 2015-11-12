Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Magnus <magnus.damm@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: PCIe host controller behind IOMMU on ARM
Date: Thu, 12 Nov 2015 17:16:41 +0100
Message-ID: <4169020.aC5VXkILQm@wuerfel>
In-Reply-To: <PS1PR06MB11802B4278C95E3808EEBDD5F5120@PS1PR06MB1180.apcprd06.prod.outlook.com>
References: <PS1PR06MB11807CBE8EB2AC6B0158D2B5F52A0@PS1PR06MB1180.apcprd06.prod.outlook.com> <6255198.JqytBn7T9E@wuerfel> <PS1PR06MB11802B4278C95E3808EEBDD5F5120@PS1PR06MB1180.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 12 November 2015 15:33:41 Phil Edworthy wrote:
> On 12 November 2015 09:49, Arnd Bergmann wrote:
> > On Thursday 12 November 2015 09:26:33 Phil Edworthy wrote:
> > > On 11 November 2015 18:25, LIviu wrote:
> > > > On Mon, Nov 09, 2015 at 12:32:13PM +0000, Phil Edworthy wrote:
> > 
> > of_dma_configure calls of_dma_get_range to do all this for the PCIe host,
> > and then calls arch_setup_dma_ops() so the architecture specific code can
> > enforce the limits in dma_set_mask and pick an appropriate set of dma
> > operations. The missing part is in the implementation of arch_setup_dma_ops,
> > which currently happily ignores the base and limit.
> I don't think it's as simple as that, though I could be wrong!
> 
> First off, of_dma_configure() sets a default coherent_dma_mask to 4GiB.
> This default is set for the 'platform soc' device. For my own testing I increased
> this to DMA_BIT_MASK(63). Note that setting it to DMA_BIT_MASK(64) causes
> boot failure that I haven't looked into.

Most platform devices actually need the 32-bit mask, so we intentionally
followed what PCI does here and default to that and require platform drivers
to explicitly ask for a larger mask if they need it.

> Then pci_device_add() sets the devices coherent_dma_mask to 4GiB before
> calling of_pci_dma_configure(). I assume it does this on the basis that this is a
> good default for PCI drivers that don't call dma_set_mask().
> So if arch_setup_dma_ops() walks up the parents to limit the mask, you'll hit
> this mask.

arch_setup_dma_ops() does not walk up the hierarchy, of_dma_configure()
does this before calling arch_setup_dma_ops(). The PCI devices start out
with the 32-bit mask, but the limit should be whatever PCI host uses.

> Finally, dma_set_mask_and_coherent() is called from the PCI card driver
> but it doesn't check the parents dma masks either.

The way I think this should work is that arch_setup_dma_ops() stores the
allowed mask in the struct device, and that dma_set_mask compares the
mask against that.

	Arnd
