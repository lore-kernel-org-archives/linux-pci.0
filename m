Return-Path: <SRS0=sfZ0=I6=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=sfZ0=I6=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 12 Jun 2018 14:01:48 +0530
From: poza@codeaurora.org
To: Ray Jui <ray.jui@broadcom.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v2 5/5] PCI: iproc: Reduce inbound/outbound mapping print
 level
In-Reply-To: <1528762867-16823-6-git-send-email-ray.jui@broadcom.com>
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <1528762867-16823-6-git-send-email-ray.jui@broadcom.com>
Message-ID: <f38e325f6d2e280e0a5f63183042746a@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-06-12 05:51, Ray Jui wrote:
> Reduce inbound/outbound mapping print level from dev_info to
> dev_dbg. This reduces the console logs during Linux boot process
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/pci/host/pcie-iproc.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc.c 
> b/drivers/pci/host/pcie-iproc.c
> index 59be1e0..3160e93 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -880,14 +880,14 @@ static inline int iproc_pcie_ob_write(struct
> iproc_pcie *pcie, int window_idx,
>  	writel(lower_32_bits(pci_addr), pcie->base + omap_offset);
>  	writel(upper_32_bits(pci_addr), pcie->base + omap_offset + 4);
> 
> -	dev_info(dev, "ob window [%d]: offset 0x%x axi %pap pci %pap\n",
> -		 window_idx, oarr_offset, &axi_addr, &pci_addr);
> -	dev_info(dev, "oarr lo 0x%x oarr hi 0x%x\n",
> -		 readl(pcie->base + oarr_offset),
> -		 readl(pcie->base + oarr_offset + 4));
> -	dev_info(dev, "omap lo 0x%x omap hi 0x%x\n",
> -		 readl(pcie->base + omap_offset),
> -		 readl(pcie->base + omap_offset + 4));
> +	dev_dbg(dev, "ob window [%d]: offset 0x%x axi %pap pci %pap\n",
> +		window_idx, oarr_offset, &axi_addr, &pci_addr);
> +	dev_dbg(dev, "oarr lo 0x%x oarr hi 0x%x\n",
> +		readl(pcie->base + oarr_offset),
> +		readl(pcie->base + oarr_offset + 4));
> +	dev_dbg(dev, "omap lo 0x%x omap hi 0x%x\n",
> +		readl(pcie->base + omap_offset),
> +		readl(pcie->base + omap_offset + 4));
> 
>  	return 0;
>  }
> @@ -1054,8 +1054,8 @@ static int iproc_pcie_ib_write(struct iproc_pcie
> *pcie, int region_idx,
>  	    iproc_pcie_reg_is_invalid(imap_offset))
>  		return -EINVAL;
> 
> -	dev_info(dev, "ib region [%d]: offset 0x%x axi %pap pci %pap\n",
> -		 region_idx, iarr_offset, &axi_addr, &pci_addr);
> +	dev_dbg(dev, "ib region [%d]: offset 0x%x axi %pap pci %pap\n",
> +		region_idx, iarr_offset, &axi_addr, &pci_addr);
> 
>  	/*
>  	 * Program the IARR registers.  The upper 32-bit IARR register is
> @@ -1065,9 +1065,9 @@ static int iproc_pcie_ib_write(struct iproc_pcie
> *pcie, int region_idx,
>  	       pcie->base + iarr_offset);
>  	writel(upper_32_bits(pci_addr), pcie->base + iarr_offset + 4);
> 
> -	dev_info(dev, "iarr lo 0x%x iarr hi 0x%x\n",
> -		 readl(pcie->base + iarr_offset),
> -		 readl(pcie->base + iarr_offset + 4));
> +	dev_dbg(dev, "iarr lo 0x%x iarr hi 0x%x\n",
> +		readl(pcie->base + iarr_offset),
> +		readl(pcie->base + iarr_offset + 4));
> 
>  	/*
>  	 * Now program the IMAP registers.  Each IARR region may have one or
> @@ -1081,10 +1081,10 @@ static int iproc_pcie_ib_write(struct
> iproc_pcie *pcie, int region_idx,
>  		writel(upper_32_bits(axi_addr),
>  		       pcie->base + imap_offset + ib_map->imap_addr_offset);
> 
> -		dev_info(dev, "imap window [%d] lo 0x%x hi 0x%x\n",
> -			 window_idx, readl(pcie->base + imap_offset),
> -			 readl(pcie->base + imap_offset +
> -			       ib_map->imap_addr_offset));
> +		dev_dbg(dev, "imap window [%d] lo 0x%x hi 0x%x\n",
> +			window_idx, readl(pcie->base + imap_offset),
> +			readl(pcie->base + imap_offset +
> +			      ib_map->imap_addr_offset));
> 
>  		imap_offset += ib_map->imap_window_offset;
>  		axi_addr += size;

Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
