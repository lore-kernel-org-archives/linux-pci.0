Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:48727 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbdJMQrZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2017 12:47:25 -0400
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Niklas Cassel'" <niklas.cassel@axis.com>,
        "'Joao Pinto'" <Joao.Pinto@synopsys.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>
Cc: "'Niklas Cassel'" <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20171013160914.3220-1-niklas.cassel@axis.com> <20171013160914.3220-2-niklas.cassel@axis.com>
In-Reply-To: <20171013160914.3220-2-niklas.cassel@axis.com>
Subject: Re: [PATCH 01/10] PCI: dwc: use DMA-API for allocating MSI data
Date: Fri, 13 Oct 2017 12:47:22 -0400
Message-ID: <000101d34442$f1740840$d45c18c0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, October 13, 2017 12:09 PM, Niklas Cassel wrote:
> 
> Since it is a PCIe endpoint device, rather than the CPU, that is supposed
> to write to this location, the proper way to get the address to this this
> location is really to use the DMA API, rather than virt_to_phys.
> 
> Using virt_to_phys might work on some systems, but by using the DMA API,
> we know that it will work on all systems.
> 
> This is essentially the same thing as allocating a buffer in a driver,
> to which the endpoint will write to. To do this, we use the DMA API.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/pci/dwc/pcie-designware-host.c | 23 ++++++++++++++++-------
>  drivers/pci/dwc/pcie-designware.h      |  3 ++-
>  2 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-host.c
> b/drivers/pci/dwc/pcie-designware-host.c
> index 81e2157a7cfb..f6d152ea2a03 100644
> --- a/drivers/pci/dwc/pcie-designware-host.c
> +++ b/drivers/pci/dwc/pcie-designware-host.c
> @@ -83,16 +83,25 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
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
> +	pp->msi_data = dma_map_page(dev, page, 0, PAGE_SIZE,
> DMA_FROM_DEVICE);
> +	if (dma_mapping_error(dev, pp->msi_data)) {
> +		dev_err(dev, "failed to map msi data\n");
> +		__free_page(page);
> +		return;
> +	}
> +	msi_target = (u64)pp->msi_data;
> 
>  	/* program the msi_data */
>  	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
> -			    (u32)(msi_target & 0xffffffff));
> +			    lower_32_bits(msi_target));
>  	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
> -			    (u32)(msi_target >> 32 & 0xffffffff));
> +			    upper_32_bits(msi_target));
>  }
> 
>  static void dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
> @@ -187,10 +196,10 @@ static void dw_msi_setup_msg(struct pcie_port *pp,
> unsigned int irq, u32 pos)
>  	if (pp->ops->get_msi_addr)
>  		msi_target = pp->ops->get_msi_addr(pp);
>  	else
> -		msi_target = virt_to_phys((void *)pp->msi_data);
> +		msi_target = (u64)pp->msi_data;
> 
> -	msg.address_lo = (u32)(msi_target & 0xffffffff);
> -	msg.address_hi = (u32)(msi_target >> 32 & 0xffffffff);
> +	msg.address_lo = lower_32_bits(msi_target);
> +	msg.address_hi = upper_32_bits(msi_target);
> 
>  	if (pp->ops->get_msi_data)
>  		msg.data = pp->ops->get_msi_data(pp, pos);
> diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-
> designware.h
> index e5d9d77b778e..547352a317f8 100644
> --- a/drivers/pci/dwc/pcie-designware.h
> +++ b/drivers/pci/dwc/pcie-designware.h
> @@ -17,6 +17,7 @@
>  #include <linux/irq.h>
>  #include <linux/msi.h>
>  #include <linux/pci.h>
> +#include <linux/dma-mapping.h>

If possible, please add this header in alphabetical order.

Best regards,
Jingoo Han

> 
>  #include <linux/pci-epc.h>
>  #include <linux/pci-epf.h>
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
> 2.11.0
