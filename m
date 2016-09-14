Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756946AbcINVSe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Sep 2016 17:18:34 -0400
Date: Wed, 14 Sep 2016 16:18:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] pcie-rcar: fix some checkpatch warnings
Message-ID: <20160914211829.GB16581@localhost>
References: <4686727.8sYr70Tb6R@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4686727.8sYr70Tb6R@wasted.cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 09, 2016 at 01:26:18AM +0300, Sergei Shtylyov wrote:
> The R-Car PCIe driver causes 13 warnings from scripts/checkpatch.pl --
> let's fix at least 10 easier ones:
> 
> - line over 80 characters;
> 
> - blank line missing after declarations;
> 
> - statements not starting on a tabstop.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied with Simon's ack to pci/host-rcar, thanks!

> ---
> The patch is against the 'next' branch of Bjorn Helgaas' 'pci.git' repo plus
> two patches  posted  earlier...
> 
>  drivers/pci/host/pcie-rcar.c |   29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> Index: pci/drivers/pci/host/pcie-rcar.c
> ===================================================================
> --- pci.orig/drivers/pci/host/pcie-rcar.c
> +++ pci/drivers/pci/host/pcie-rcar.c
> @@ -1034,12 +1034,16 @@ static int rcar_pcie_inbound_ranges(stru
>  		 * Set up 64-bit inbound regions as the range parser doesn't
>  		 * distinguish between 32 and 64-bit types.
>  		 */
> -		rcar_pci_write_reg(pcie, lower_32_bits(pci_addr), PCIEPRAR(idx));
> +		rcar_pci_write_reg(pcie, lower_32_bits(pci_addr),
> +				   PCIEPRAR(idx));
>  		rcar_pci_write_reg(pcie, lower_32_bits(cpu_addr), PCIELAR(idx));
> -		rcar_pci_write_reg(pcie, lower_32_bits(mask) | flags, PCIELAMR(idx));
> +		rcar_pci_write_reg(pcie, lower_32_bits(mask) | flags,
> +				   PCIELAMR(idx));
>  
> -		rcar_pci_write_reg(pcie, upper_32_bits(pci_addr), PCIEPRAR(idx+1));
> -		rcar_pci_write_reg(pcie, upper_32_bits(cpu_addr), PCIELAR(idx+1));
> +		rcar_pci_write_reg(pcie, upper_32_bits(pci_addr),
> +				   PCIEPRAR(idx + 1));
> +		rcar_pci_write_reg(pcie, upper_32_bits(cpu_addr),
> +				   PCIELAR(idx + 1));
>  		rcar_pci_write_reg(pcie, 0, PCIELAMR(idx + 1));
>  
>  		pci_addr += size;
> @@ -1088,6 +1092,7 @@ static int rcar_pcie_parse_map_dma_range
>  	/* Get the dma-ranges from DT */
>  	for_each_of_pci_range(&parser, &range) {
>  		u64 end = range.cpu_addr + range.size - 1;
> +
>  		dev_dbg(pcie->dev, "0x%08x 0x%016llx..0x%016llx -> 0x%016llx\n",
>  			range.flags, range.cpu_addr, end, range.pci_addr);
>  
> @@ -1101,9 +1106,12 @@ static int rcar_pcie_parse_map_dma_range
>  
>  static const struct of_device_id rcar_pcie_of_match[] = {
>  	{ .compatible = "renesas,pcie-r8a7779", .data = rcar_pcie_hw_init_h1 },
> -	{ .compatible = "renesas,pcie-rcar-gen2", .data = rcar_pcie_hw_init_gen2 },
> -	{ .compatible = "renesas,pcie-r8a7790", .data = rcar_pcie_hw_init_gen2 },
> -	{ .compatible = "renesas,pcie-r8a7791", .data = rcar_pcie_hw_init_gen2 },
> +	{ .compatible = "renesas,pcie-rcar-gen2",
> +	  .data = rcar_pcie_hw_init_gen2 },
> +	{ .compatible = "renesas,pcie-r8a7790",
> +	  .data = rcar_pcie_hw_init_gen2 },
> +	{ .compatible = "renesas,pcie-r8a7791",
> +	  .data = rcar_pcie_hw_init_gen2 },
>  	{ .compatible = "renesas,pcie-r8a7795", .data = rcar_pcie_hw_init },
>  	{},
>  };
> @@ -1116,7 +1124,8 @@ static int rcar_pcie_parse_request_of_pc
>  	resource_size_t iobase;
>  	struct resource_entry *win;
>  
> -	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pci->resources, &iobase);
> +	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pci->resources,
> +					       &iobase);
>  	if (err)
>  		return err;
>  
> @@ -1167,8 +1176,8 @@ static int rcar_pcie_probe(struct platfo
>  		return err;
>  	}
>  
> -	 err = rcar_pcie_parse_map_dma_ranges(pcie, pdev->dev.of_node);
> -	 if (err)
> +	err = rcar_pcie_parse_map_dma_ranges(pcie, pdev->dev.of_node);
> +	if (err)
>  		return err;
>  
>  	of_id = of_match_device(rcar_pcie_of_match, pcie->dev);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
