Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:64668 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754752AbbKLPds convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 12 Nov 2015 10:33:48 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Magnus <magnus.damm@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: PCIe host controller behind IOMMU on ARM
Date: Thu, 12 Nov 2015 15:33:41 +0000
Message-ID: <PS1PR06MB11802B4278C95E3808EEBDD5F5120@PS1PR06MB1180.apcprd06.prod.outlook.com>
References: <PS1PR06MB11807CBE8EB2AC6B0158D2B5F52A0@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <20151111182456.GV963@e106497-lin.cambridge.arm.com>
 <PS1PR06MB118013A957CFFDF129430C58F5120@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <6255198.JqytBn7T9E@wuerfel>
In-Reply-To: <6255198.JqytBn7T9E@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On 12 November 2015 09:49, Arnd Bergmann wrote:
> On Thursday 12 November 2015 09:26:33 Phil Edworthy wrote:
> > On 11 November 2015 18:25, LIviu wrote:
> > > On Mon, Nov 09, 2015 at 12:32:13PM +0000, Phil Edworthy wrote:
> 
> > > I think you're mixing things a bit or not explaining them very well. Having the
> > > PCIe controller limited to 32-bit AXI does not mean that the PCIe bus cannot
> > > carry 64-bit addresses. It depends on how they get translated by the host
> bridge
> > > or its associated ATS block. I can't see why you can't have a setup where
> > > the CPU addresses are 32-bit but the PCIe bus addresses are all 64-bit.
> > > You just have to be careful on how you setup your mem64 ranges so that
> they
> > > don't
> > > overlap with the 32-bit ranges when translated.
> > From a HW point of view I agree that we can setup the PCI host bridge such that
> > it uses 64-bit PCI address, with 32-bit cpu addresses. Though in practice doesn't
> > this mean that the dma ops used by card drivers has to be provided by our PCI
> > host bridge driver so we can apply the translation to those PCI addresses?
> > This comes back to my point below about how to do this. Adding a bus notifier
> > to do this may be too late, and arm64 doesn't implement set_dma_ops().
> >
> > > And no, you should not limit at the card driver the DMA_BIT_MASK() unless
> the
> > > card is not capable of supporting more than 32-bit addresses.
> > If there was infrastructure that checked all parents dma-ranges when the
> > dma_set_mask() function is called as Arnd pointed out, this would nicely solve
> > the problem.
> 
> of_dma_configure calls of_dma_get_range to do all this for the PCIe host,
> and then calls arch_setup_dma_ops() so the architecture specific code can
> enforce the limits in dma_set_mask and pick an appropriate set of dma
> operations. The missing part is in the implementation of arch_setup_dma_ops,
> which currently happily ignores the base and limit.
I don't think it's as simple as that, though I could be wrong!

First off, of_dma_configure() sets a default coherent_dma_mask to 4GiB.
This default is set for the 'platform soc' device. For my own testing I increased
this to DMA_BIT_MASK(63). Note that setting it to DMA_BIT_MASK(64) causes
boot failure that I haven't looked into.

Then pci_device_add() sets the devices coherent_dma_mask to 4GiB before
calling of_pci_dma_configure(). I assume it does this on the basis that this is a
good default for PCI drivers that don't call dma_set_mask().
So if arch_setup_dma_ops() walks up the parents to limit the mask, you'll hit
this mask.

Finally, dma_set_mask_and_coherent() is called from the PCI card driver
but it doesn't check the parents dma masks either.

Thanks
Phil

