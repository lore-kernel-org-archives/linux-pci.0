Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1453246656.28109.81.camel@redhat.com>
Subject: Re: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
From: Mark Salter <msalter@redhat.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: Graeme Gregory <gg@slimlogic.co.uk>, linaro-acpi@lists.linaro.org,
	linux-pci@vger.kernel.org, will.deacon@arm.com,
	okaya@codeaurora.org, wangyijing@huawei.com,
	Lorenzo.Pieralisi@arm.com, Tomasz Nowicki <tn@semihalf.com>,
	ddaney@caviumnetworks.com, linux-acpi@vger.kernel.org,
	robert.richter@caviumnetworks.com, catalin.marinas@arm.com,
	jcm@redhat.com, arnd@arndb.de, Stefano.Stabellini@eu.citrix.com,
	Liviu.Dudau@arm.com, bhelgaas@google.com, tglx@linutronix.de,
	mw@semihalf.com, linux-arm-kernel@lists.infradead.org,
	jchandra@broadcom.com, rjw@rjwysocki.net,
	linux-kernel@vger.kernel.org, hanjun.guo@linaro.org,
	Suravee.Suthikulpanit@amd.com, jiang.liu@linux.intel.com
Date: Tue, 19 Jan 2016 18:37:36 -0500
In-Reply-To: <20160119204015.GS19062@n2100.arm.linux.org.uk>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
	 <20160114134440.GA8520@xora-haswell.xora.org.uk>
	 <1452780100.28109.3.camel@redhat.com>
	 <20160114141501.GC8520@xora-haswell.xora.org.uk>
	 <1452781481.28109.8.camel@redhat.com>
	 <20160115121231.GD8520@xora-haswell.xora.org.uk>
	 <20160118140405.GC11384@xora-haswell.xora.org.uk>
	 <20160119202513.GC6510@localhost>
	 <20160119204015.GS19062@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2016-01-19 at 20:40 +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 19, 2016 at 02:25:13PM -0600, Bjorn Helgaas wrote:
> > On Mon, Jan 18, 2016 at 02:04:05PM +0000, Graeme Gregory wrote:
> > > After some private debugging with Mark it turned out that the difference
> > > between our configurations was I did not have.
> > > 
> > > CONFIG_DMA_CMA=y
> > > 
> > > With this enabled then the card works without coherent mask hack.
> > 
> > I didn't follow the whole discussion here, but is this a case where
> > the driver could fail more gracefully than it did?  Can we do anything
> > to make this easier for the next person who trips over the same problem?
> 
> I've not followed the discussion at all, but reading what was in the
> quoted parts of the mail makes me somewhat suspicious.
> 
> The way PCI drivers (or in fact any driver) are supposed to work is:
> 
> - the bus code sets up a default mask (32-bit DMA in the case of PCI)
> - the driver calls dma_set_mask() or similar function with the mask
>   the _driver_ wants to use.  Arch DMA code decides whether the mask
>   can be supported, and if it can, it re-sets the DMA mask.  If the
>   mask can't be supported, it returns an error.
> 
> The driver is doing things correctly:
> 
>         if ((sizeof(dma_addr_t) > 4) &&
>             !pci_set_dma_mask(pdev, DMA_BIT_MASK(64)) && use_dac) {
>                 tp->cp_cmd |= PCIDAC;
>                 dev->features |= NETIF_F_HIGHDMA;
>         } else {
>                 rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> 
> which says: if the size of a DMA address supports 64-bit, and we can
> set a 64-bit DMA address mask (iow, the platform allows it), and
> we're permitted to use DAC, use DAC, otherwise try to set a 32-bit
> DMA mask.
> 
> It shouldn't matter one bit what the mask is before that point.
> 
> However, what the driver fails to do is to deal with the coherent
> mask - it appears to be missing a call to pci_set_consistent_dma_mask().
> That may be where the issue is.

It is.

The driver works with devicetree because of_dma_configure() sets up dma
and coherent mask for PCI devices based on root bridge info in the DT.
So the driver gets by without setting coherent mask explicitly. In the
ACPI case, the coherent mask doesn't get set because there isn't DMA
info in the ACPI tables (I think IORT table/IOMMU support will add this
in the future). Using CONFIG_DMA_CMA avoids the issue by allowing CMA
memory to be used for DMA while avoiding a check against coherent mask.

> 
> It may be worth doing what I did with the DMA API, and introducing
> pci_set_mask_and_coherent() which sets both masks together - which
> will probably allow some PCI driver code to be simplified.
> 


