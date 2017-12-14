Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:29838 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbdLNLDp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 06:03:45 -0500
Subject: Re: [PATCH v4 1/3] PCI: designware-ep: Fix find_first_zero_bit()
 usage
To: Niklas Cassel <niklas.cassel@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20171212141634.5985-1-niklas.cassel@axis.com>
 <20171212141634.5985-2-niklas.cassel@axis.com>
CC: Niklas Cassel <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <00193d24-8625-0080-9c1f-a85b0432064a@ti.com>
Date: Thu, 14 Dec 2017 16:33:33 +0530
MIME-Version: 1.0
In-Reply-To: <20171212141634.5985-2-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Tuesday 12 December 2017 07:46 PM, Niklas Cassel wrote:
> find_first_zero_bit()'s parameter 'size' is defined in bits,
> not in bytes.
> 
> find_first_zero_bit() is called with size in bytes rather than bits,
> which thus defines a too low upper limit, causing
> dw_pcie_ep_inbound_atu() to assign iatu index #4 to both bar 4
> and bar 5, which makes bar 5 overwrite the settings set by bar 4.
> 
> Since the sizes of the bitmaps are known, dynamically allocate the
> bitmaps, and use the correct size when calling find_first_zero_bit().
> 
> Additionally, make sure that ep->num_ob_windows and ep->num_ib_windows,
> which are obtained from device tree, are smaller than the maximum number
> of iATUs (MAX_IATU_IN/MAX_IATU_OUT).
> 
> Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/pcie-designware-ep.c | 34 ++++++++++++++++++++++++++--------
>  drivers/pci/dwc/pcie-designware.h    |  8 ++++++--
>  2 files changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> index d53d5f168363..d5eb143040e3 100644
> --- a/drivers/pci/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> @@ -70,8 +70,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, enum pci_barno bar,
>  	u32 free_win;
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
> -	free_win = find_first_zero_bit(&ep->ib_window_map,
> -				       sizeof(ep->ib_window_map));
> +	free_win = find_first_zero_bit(ep->ib_window_map, ep->num_ib_windows);
>  	if (free_win >= ep->num_ib_windows) {
>  		dev_err(pci->dev, "no free inbound window\n");
>  		return -EINVAL;
> @@ -85,7 +84,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, enum pci_barno bar,
>  	}
>  
>  	ep->bar_to_atu[bar] = free_win;
> -	set_bit(free_win, &ep->ib_window_map);
> +	set_bit(free_win, ep->ib_window_map);
>  
>  	return 0;
>  }
> @@ -96,8 +95,7 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, phys_addr_t phys_addr,
>  	u32 free_win;
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
> -	free_win = find_first_zero_bit(&ep->ob_window_map,
> -				       sizeof(ep->ob_window_map));
> +	free_win = find_first_zero_bit(ep->ob_window_map, ep->num_ob_windows);
>  	if (free_win >= ep->num_ob_windows) {
>  		dev_err(pci->dev, "no free outbound window\n");
>  		return -EINVAL;
> @@ -106,7 +104,7 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, phys_addr_t phys_addr,
>  	dw_pcie_prog_outbound_atu(pci, free_win, PCIE_ATU_TYPE_MEM,
>  				  phys_addr, pci_addr, size);
>  
> -	set_bit(free_win, &ep->ob_window_map);
> +	set_bit(free_win, ep->ob_window_map);
>  	ep->outbound_addr[free_win] = phys_addr;
>  
>  	return 0;
> @@ -121,7 +119,7 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, enum pci_barno bar)
>  	dw_pcie_ep_reset_bar(pci, bar);
>  
>  	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_INBOUND);
> -	clear_bit(atu_index, &ep->ib_window_map);
> +	clear_bit(atu_index, ep->ib_window_map);
>  }
>  
>  static int dw_pcie_ep_set_bar(struct pci_epc *epc, enum pci_barno bar,
> @@ -175,7 +173,7 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, phys_addr_t addr)
>  		return;
>  
>  	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_OUTBOUND);
> -	clear_bit(atu_index, &ep->ob_window_map);
> +	clear_bit(atu_index, ep->ob_window_map);
>  }
>  
>  static int dw_pcie_ep_map_addr(struct pci_epc *epc, phys_addr_t addr,
> @@ -298,12 +296,32 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		dev_err(dev, "unable to read *num-ib-windows* property\n");
>  		return ret;
>  	}
> +	if (ep->num_ib_windows > MAX_IATU_IN) {
> +		dev_err(dev, "invalid *num-ib-windows*\n");
> +		return -EINVAL;
> +	}
>  
>  	ret = of_property_read_u32(np, "num-ob-windows", &ep->num_ob_windows);
>  	if (ret < 0) {
>  		dev_err(dev, "unable to read *num-ob-windows* property\n");
>  		return ret;
>  	}
> +	if (ep->num_ob_windows > MAX_IATU_OUT) {
> +		dev_err(dev, "invalid *num-ob-windows*\n");
> +		return -EINVAL;
> +	}
> +
> +	ep->ib_window_map = devm_kzalloc(dev, sizeof(long) *
> +					 BITS_TO_LONGS(ep->num_ib_windows),
> +					 GFP_KERNEL);
> +	if (!ep->ib_window_map)
> +		return -ENOMEM;
> +
> +	ep->ob_window_map = devm_kzalloc(dev, sizeof(long) *
> +					 BITS_TO_LONGS(ep->num_ob_windows),
> +					 GFP_KERNEL);
> +	if (!ep->ob_window_map)
> +		return -ENOMEM;
>  
>  	addr = devm_kzalloc(dev, sizeof(phys_addr_t) * ep->num_ob_windows,
>  			    GFP_KERNEL);
> diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
> index e5d9d77b778e..e6fd0b024b21 100644
> --- a/drivers/pci/dwc/pcie-designware.h
> +++ b/drivers/pci/dwc/pcie-designware.h
> @@ -113,6 +113,10 @@
>  #define MAX_MSI_IRQS			32
>  #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
>  
> +/* Maximum number of inbound/outbound iATUs */
> +#define MAX_IATU_IN			256
> +#define MAX_IATU_OUT			256
> +
>  struct pcie_port;
>  struct dw_pcie;
>  struct dw_pcie_ep;
> @@ -192,8 +196,8 @@ struct dw_pcie_ep {
>  	size_t			page_size;
>  	u8			bar_to_atu[6];
>  	phys_addr_t		*outbound_addr;
> -	unsigned long		ib_window_map;
> -	unsigned long		ob_window_map;
> +	unsigned long		*ib_window_map;
> +	unsigned long		*ob_window_map;
>  	u32			num_ib_windows;
>  	u32			num_ob_windows;
>  };
> 
