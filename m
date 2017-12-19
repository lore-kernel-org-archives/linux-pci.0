Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761763AbdLSKSg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Dec 2017 05:18:36 -0500
Date: Tue, 19 Dec 2017 10:19:18 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/18] PCI: dwc: Use the DMA-API to get the MSI address
Message-ID: <20171219101918.GA18921@red-moon>
References: <20171120133222.27771-1-niklas.cassel@axis.com>
 <20171120133222.27771-2-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171120133222.27771-2-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 20, 2017 at 02:32:04PM +0100, Niklas Cassel wrote:
> Use the DMA-API to get the MSI address. This address will be written to
> our PCI config space and to the register which determines which AXI
> address the DWC IP will spoof for incoming MSI irqs.
> 
> Since it is a PCIe endpoint device, rather than the CPU, that is supposed
> to write to the MSI address, the proper way to get the MSI address is by
> using the DMA API, not by using virt_to_phys().
> 
> Using virt_to_phys() might work on some systems, but using the DMA API
> should work on all systems.
> 
> This is essentially the same thing as allocating a buffer in a driver
> to which the endpoint will write to. To do this, we use the DMA API.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/pci/dwc/pcie-designware-host.c | 15 ++++++++++++---
>  drivers/pci/dwc/pcie-designware.h      |  3 ++-
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> index 81e2157a7cfb..33b52fe98a01 100644
> --- a/drivers/pci/dwc/pcie-designware-host.c
> +++ b/drivers/pci/dwc/pcie-designware-host.c
> @@ -83,10 +83,19 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  
>  void dw_pcie_msi_init(struct pcie_port *pp)
>  {
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct device *dev = pci->dev;
> +	struct page *page;
>  	u64 msi_target;
>  
> -	pp->msi_data = __get_free_pages(GFP_KERNEL, 0);
> -	msi_target = virt_to_phys((void *)pp->msi_data);
> +	page = alloc_page(GFP_KERNEL | GFP_DMA32);

See this thread about GFP_DMA32:

https://patchwork.ozlabs.org/patch/834864/

I need to look back at this set earlier versions, I do not know why
you change the allocation flags but GFP_DMA32 may not provide what
you need - I think you should either remove it or provide a
justification for it given the discussion above.

Lorenzo

> +	pp->msi_data = dma_map_page(dev, page, 0, PAGE_SIZE, DMA_FROM_DEVICE);
> +	if (dma_mapping_error(dev, pp->msi_data)) {
> +		dev_err(dev, "failed to map MSI data\n");
> +		__free_page(page);
> +		return;
> +	}
> +	msi_target = (u64)pp->msi_data;
>  
>  	/* program the msi_data */
>  	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
> @@ -187,7 +196,7 @@ static void dw_msi_setup_msg(struct pcie_port *pp, unsigned int irq, u32 pos)
>  	if (pp->ops->get_msi_addr)
>  		msi_target = pp->ops->get_msi_addr(pp);
>  	else
> -		msi_target = virt_to_phys((void *)pp->msi_data);
> +		msi_target = (u64)pp->msi_data;
>  
>  	msg.address_lo = (u32)(msi_target & 0xffffffff);
>  	msg.address_hi = (u32)(msi_target >> 32 & 0xffffffff);
> diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
> index e5d9d77b778e..ecdede68522a 100644
> --- a/drivers/pci/dwc/pcie-designware.h
> +++ b/drivers/pci/dwc/pcie-designware.h
> @@ -14,6 +14,7 @@
>  #ifndef _PCIE_DESIGNWARE_H
>  #define _PCIE_DESIGNWARE_H
>  
> +#include <linux/dma-mapping.h>
>  #include <linux/irq.h>
>  #include <linux/msi.h>
>  #include <linux/pci.h>
> @@ -168,7 +169,7 @@ struct pcie_port {
>  	const struct dw_pcie_host_ops *ops;
>  	int			msi_irq;
>  	struct irq_domain	*irq_domain;
> -	unsigned long		msi_data;
> +	dma_addr_t		msi_data;
>  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
>  };
>  
> -- 
> 2.14.2
> 
