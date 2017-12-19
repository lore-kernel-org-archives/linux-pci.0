Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:47582 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbdLSWNT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Dec 2017 17:13:19 -0500
Date: Tue, 19 Dec 2017 23:13:15 +0100
From: Niklas Cassel <niklas.cassel@axis.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/18] PCI: dwc: Use the DMA-API to get the MSI address
Message-ID: <20171219221315.GA15489@axis.com>
References: <20171120133222.27771-1-niklas.cassel@axis.com>
 <20171120133222.27771-2-niklas.cassel@axis.com>
 <20171219101918.GA18921@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171219101918.GA18921@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 19, 2017 at 10:19:18AM +0000, Lorenzo Pieralisi wrote:
> On Mon, Nov 20, 2017 at 02:32:04PM +0100, Niklas Cassel wrote:
> > Use the DMA-API to get the MSI address. This address will be written to
> > our PCI config space and to the register which determines which AXI
> > address the DWC IP will spoof for incoming MSI irqs.
> > 
> > Since it is a PCIe endpoint device, rather than the CPU, that is supposed
> > to write to the MSI address, the proper way to get the MSI address is by
> > using the DMA API, not by using virt_to_phys().
> > 
> > Using virt_to_phys() might work on some systems, but using the DMA API
> > should work on all systems.
> > 
> > This is essentially the same thing as allocating a buffer in a driver
> > to which the endpoint will write to. To do this, we use the DMA API.
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > ---
> >  drivers/pci/dwc/pcie-designware-host.c | 15 ++++++++++++---
> >  drivers/pci/dwc/pcie-designware.h      |  3 ++-
> >  2 files changed, 14 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> > index 81e2157a7cfb..33b52fe98a01 100644
> > --- a/drivers/pci/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/dwc/pcie-designware-host.c
> > @@ -83,10 +83,19 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
> >  
> >  void dw_pcie_msi_init(struct pcie_port *pp)
> >  {
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct device *dev = pci->dev;
> > +	struct page *page;
> >  	u64 msi_target;
> >  
> > -	pp->msi_data = __get_free_pages(GFP_KERNEL, 0);
> > -	msi_target = virt_to_phys((void *)pp->msi_data);
> > +	page = alloc_page(GFP_KERNEL | GFP_DMA32);
> 
> See this thread about GFP_DMA32:
> 
> https://patchwork.ozlabs.org/patch/834864/
> 
> I need to look back at this set earlier versions, I do not know why
> you change the allocation flags but GFP_DMA32 may not provide what
> you need - I think you should either remove it or provide a
> justification for it given the discussion above.
> 
> Lorenzo

Hello Lorenzo,

I agree, if we want to change this so that the MSI address is guaranteed
to be in the first 4 GB (since some PCIe endpoints only support 32-bit
MSI), we should do so in a separate patch.

Further more, according to the discussion you linked, any such patch
should consider using GFP_DMA instead of GFP_DMA32, since the
ZONE_DMA32 to ZONE_DMA fallback (in case CONFIG_ZONE_DMA32 is not
set) seems to be broken (and has been for several years).

I will submit a new patch set version where I drop GFP_DMA32.


Regards,
Niklas
