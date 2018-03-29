Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:25110 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeC2JhM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Mar 2018 05:37:12 -0400
Subject: Re: [PATCH v5 02/12] PCI: endpoint: Simplify
 epc->ops->set_bar()/pci_epc_set_bar()
To: Niklas Cassel <niklas.cassel@axis.com>,
        <cyrille.pitchen@free-electrons.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Niklas Cassel <niklass@axis.com>,
        John Keeping <john@metanate.com>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
 <20180328115018.31921-3-niklas.cassel@axis.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <3b8cd898-14c7-676d-61ab-d931047a5d2e@ti.com>
Date: Thu, 29 Mar 2018 15:06:47 +0530
MIME-Version: 1.0
In-Reply-To: <20180328115018.31921-3-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 28 March 2018 05:20 PM, Niklas Cassel wrote:
> Add barno and flags to struct epf_bar.
> That way we can simplify epc->ops->set_bar()/pci_epc_set_bar()
> by passing a struct *epf_bar instead of a whole lot of arguments.
> 
> This is needed so that epc->ops->set_bar() implementations can
> modify BAR flags. Will be utilized in a succeeding patch.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> It is not trivial to convert the bar_size + bar_flags +
> struct pci_epf->bar member array to an array of struct resources,
> since we need to be able to store the addresses returned
> by dma_alloc_coherent(), which is of type dma_addr_t.
> struct resource uses resource_size_t, which is defined as phys_addr_t.
> E.g. ARTPEC-7 uses 64-bit dma_addr_t, but only 32-bit phys_addr_t.
> 
>  drivers/pci/cadence/pcie-cadence-ep.c         |  9 ++++++---
>  drivers/pci/dwc/pcie-designware-ep.c          |  8 +++++---
>  drivers/pci/endpoint/functions/pci-epf-test.c |  8 ++------
>  drivers/pci/endpoint/pci-epc-core.c           | 10 ++++------
>  drivers/pci/endpoint/pci-epf-core.c           |  4 ++++
>  include/linux/pci-epc.h                       |  6 ++----
>  include/linux/pci-epf.h                       |  2 ++
>  7 files changed, 25 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadence/pcie-cadence-ep.c
> index 3c3a97743453..cef36cd6b710 100644
> --- a/drivers/pci/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/cadence/pcie-cadence-ep.c
> @@ -77,16 +77,19 @@ static int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
>  	return 0;
>  }
>  
> -static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, enum pci_barno bar,
> -				dma_addr_t bar_phys, size_t size, int flags)
> +static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
> +				struct pci_epf_bar *epf_bar)
>  {
>  	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct cdns_pcie *pcie = &ep->pcie;
> +	dma_addr_t bar_phys = epf_bar->phys_addr;
> +	enum pci_barno bar = epf_bar->barno;
> +	int flags = epf_bar->flags;
>  	u32 addr0, addr1, reg, cfg, b, aperture, ctrl;
>  	u64 sz;
>  
>  	/* BAR size is 2^(aperture + 7) */
> -	sz = max_t(size_t, size, CDNS_PCIE_EP_MIN_APERTURE);
> +	sz = max_t(size_t, epf_bar->size, CDNS_PCIE_EP_MIN_APERTURE);
>  	/*
>  	 * roundup_pow_of_two() returns an unsigned long, which is not suited
>  	 * for 64bit values.
> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> index 9236b998327f..5a0bb53c795c 100644
> --- a/drivers/pci/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> @@ -117,12 +117,14 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no,
>  }
>  
>  static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
> -			      enum pci_barno bar,
> -			      dma_addr_t bar_phys, size_t size, int flags)
> +			      struct pci_epf_bar *epf_bar)
>  {
>  	int ret;
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	enum pci_barno bar = epf_bar->barno;
> +	size_t size = epf_bar->size;
> +	int flags = epf_bar->flags;
>  	enum dw_pcie_as_type as_type;
>  	u32 reg = PCI_BASE_ADDRESS_0 + (4 * bar);
>  
> @@ -131,7 +133,7 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
>  	else
>  		as_type = DW_PCIE_AS_IO;
>  
> -	ret = dw_pcie_ep_inbound_atu(ep, bar, bar_phys, as_type);
> +	ret = dw_pcie_ep_inbound_atu(ep, bar, epf_bar->phys_addr, as_type);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index f6c0c59b1bc8..91274779e59f 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -358,7 +358,6 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>  
>  static int pci_epf_test_set_bar(struct pci_epf *epf)
>  {
> -	int flags;
>  	int bar;
>  	int ret;
>  	struct pci_epf_bar *epf_bar;
> @@ -370,14 +369,11 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
>  	for (bar = BAR_0; bar <= BAR_5; bar++) {
>  		epf_bar = &epf->bar[bar];
>  
> -		flags = PCI_BASE_ADDRESS_SPACE_MEMORY;
> -		flags |= upper_32_bits(epf_bar->size) ?
> +		epf_bar->flags |= upper_32_bits(epf_bar->size) ?
>  			PCI_BASE_ADDRESS_MEM_TYPE_64 :
>  			PCI_BASE_ADDRESS_MEM_TYPE_32;
>  
> -		ret = pci_epc_set_bar(epc, epf->func_no, bar,
> -				      epf_bar->phys_addr,
> -				      epf_bar->size, flags);
> +		ret = pci_epc_set_bar(epc, epf->func_no, epf_bar);
>  		if (ret) {
>  			pci_epf_free_space(epf, epf_test->reg[bar], bar);
>  			dev_err(dev, "failed to set BAR%d\n", bar);
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index e245bba0ab53..784e33d6f229 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -300,14 +300,12 @@ EXPORT_SYMBOL_GPL(pci_epc_clear_bar);
>   * pci_epc_set_bar() - configure BAR in order for host to assign PCI addr space
>   * @epc: the EPC device on which BAR has to be configured
>   * @func_no: the endpoint function number in the EPC device
> - * @bar: the BAR number that has to be configured
> - * @size: the size of the addr space
> - * @flags: specify memory allocation/io allocation/32bit address/64 bit address
> + * @epf_bar: the struct epf_bar that contains the BAR information
>   *
>   * Invoke to configure the BAR of the endpoint device.
>   */
> -int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, enum pci_barno bar,
> -		    dma_addr_t bar_phys, size_t size, int flags)
> +int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
> +		    struct pci_epf_bar *epf_bar)
>  {
>  	int ret;
>  	unsigned long irq_flags;
> @@ -319,7 +317,7 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, enum pci_barno bar,
>  		return 0;
>  
>  	spin_lock_irqsave(&epc->lock, irq_flags);
> -	ret = epc->ops->set_bar(epc, func_no, bar, bar_phys, size, flags);
> +	ret = epc->ops->set_bar(epc, func_no, epf_bar);
>  	spin_unlock_irqrestore(&epc->lock, irq_flags);
>  
>  	return ret;
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 59ed29e550e9..465b5f058b6d 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -98,6 +98,8 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar)
>  
>  	epf->bar[bar].phys_addr = 0;
>  	epf->bar[bar].size = 0;
> +	epf->bar[bar].barno = 0;
> +	epf->bar[bar].flags = 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_epf_free_space);
>  
> @@ -126,6 +128,8 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar)
>  
>  	epf->bar[bar].phys_addr = phys_addr;
>  	epf->bar[bar].size = size;
> +	epf->bar[bar].barno = bar;
> +	epf->bar[bar].flags = PCI_BASE_ADDRESS_SPACE_MEMORY;
>  
>  	return space;
>  }
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index a1a5e5df0f66..75bae8aabbf9 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -39,8 +39,7 @@ struct pci_epc_ops {
>  	int	(*write_header)(struct pci_epc *epc, u8 func_no,
>  				struct pci_epf_header *hdr);
>  	int	(*set_bar)(struct pci_epc *epc, u8 func_no,
> -			   enum pci_barno bar,
> -			   dma_addr_t bar_phys, size_t size, int flags);
> +			   struct pci_epf_bar *epf_bar);
>  	void	(*clear_bar)(struct pci_epc *epc, u8 func_no,
>  			     enum pci_barno bar);
>  	int	(*map_addr)(struct pci_epc *epc, u8 func_no,
> @@ -127,8 +126,7 @@ void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf);
>  int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
>  			 struct pci_epf_header *hdr);
>  int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
> -		    enum pci_barno bar,
> -		    dma_addr_t bar_phys, size_t size, int flags);
> +		    struct pci_epf_bar *epf_bar);
>  void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no, int bar);
>  int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
>  		     phys_addr_t phys_addr,
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index e897bf076701..f7d6f4883f8b 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -97,6 +97,8 @@ struct pci_epf_driver {
>  struct pci_epf_bar {
>  	dma_addr_t	phys_addr;
>  	size_t		size;
> +	enum pci_barno	barno;
> +	int		flags;
>  };
>  
>  /**
> 
