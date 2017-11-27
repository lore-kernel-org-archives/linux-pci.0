Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752845AbdK0Qyg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Nov 2017 11:54:36 -0500
Date: Mon, 27 Nov 2017 16:55:05 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kishon@ti.com,
        Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] PCI: designware-ep: Fix find_first_zero_bit()
 usage
Message-ID: <20171127165505.GB3435@red-moon>
References: <20171127154955.22214-1-niklas.cassel@axis.com>
 <20171127154955.22214-2-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171127154955.22214-2-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 27, 2017 at 04:49:53PM +0100, Niklas Cassel wrote:
> find_first_zero_bit()'s parameter 'size' is defined in bits,
> not in bytes.
> 
> find_first_zero_bit() was called with size in bytes rather than bits,
> which thus defined a too low upper limit, causing
> dw_pcie_ep_inbound_atu() to assign iatu index #4 to both bar 4
> and bar 5, which made bar 5 overwrite the settings set by bar 4.

Same comments about past tense usage.

> Fix this by using bitmaps with a static upper limit (MAX_IATUS).

I think that given that we have the size from FW (num_ib/ob_windows),
you should allocate them dynamically (sorry for asking another respin).

> 256 was chosen since according to the databook, that is the

Nit: I think "datasheet" is more appropriate than "databook" here.

> maximum number of iATUs supported by the IP.
> 
> Additionally, make sure that ep->num_ob_windows and ep->num_ib_windows,
> which are obtained from device tree, are less than the maximum number of

s/less/smaller

> iATUs (MAX_IATUS).
> 
> Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/pci/dwc/pcie-designware-ep.c | 22 ++++++++++++++--------
>  drivers/pci/dwc/pcie-designware.h    |  7 +++++--
>  2 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> index d53d5f168363..8b14e7db5487 100644
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
> @@ -298,12 +296,20 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		dev_err(dev, "unable to read *num-ib-windows* property\n");
>  		return ret;
>  	}
> +	if (ep->num_ib_windows > MAX_IATUS) {
> +		dev_err(dev, "invalid *num-ib-windows*\n");
> +		return -EINVAL;
> +	}
>  
>  	ret = of_property_read_u32(np, "num-ob-windows", &ep->num_ob_windows);
>  	if (ret < 0) {
>  		dev_err(dev, "unable to read *num-ob-windows* property\n");
>  		return ret;
>  	}
> +	if (ep->num_ob_windows > MAX_IATUS) {
> +		dev_err(dev, "invalid *num-ob-windows*\n");
> +		return -EINVAL;
> +	}
>  
>  	addr = devm_kzalloc(dev, sizeof(phys_addr_t) * ep->num_ob_windows,
>  			    GFP_KERNEL);
> diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
> index e5d9d77b778e..189f45264c2a 100644
> --- a/drivers/pci/dwc/pcie-designware.h
> +++ b/drivers/pci/dwc/pcie-designware.h
> @@ -113,6 +113,9 @@
>  #define MAX_MSI_IRQS			32
>  #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
>  
> +/* Maximum number of inbound/outbound iATUs */
> +#define MAX_IATUS			256
> +
>  struct pcie_port;
>  struct dw_pcie;
>  struct dw_pcie_ep;
> @@ -192,8 +195,8 @@ struct dw_pcie_ep {
>  	size_t			page_size;
>  	u8			bar_to_atu[6];
>  	phys_addr_t		*outbound_addr;
> -	unsigned long		ib_window_map;
> -	unsigned long		ob_window_map;
> +	DECLARE_BITMAP(ib_window_map, MAX_IATUS);
> +	DECLARE_BITMAP(ob_window_map, MAX_IATUS);

Only comment I have on the patch is, make the bitmap dynamic ie allocate
them using eg:

ib_window_map = kzalloc(BITS_TO_LONG(num_ib_windows) * sizeof(long),
GFP_KERNEL);

it is a common pattern in the kernel. I just do not like preallocating
static arrays if we know the real size.

It is correct to check the number of ib/ob windows parsed from DT
against MAX_IATUS, since that's a HW limitation therefore a FW (DT)
bug if they are exceeded.

find_first_zero_bit() should use num_ib/ob_windows as size parameter
(ie current patch is correct).

Thanks,
Lorenzo

>  	u32			num_ib_windows;
>  	u32			num_ob_windows;
>  };
> -- 
> 2.14.2
> 
