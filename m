Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:35144 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932143AbeCSIov (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Mar 2018 04:44:51 -0400
Date: Mon, 19 Mar 2018 09:44:48 +0100
From: Simon Horman <horms@verge.net.au>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci@vger.kernel.org,
        Dien Pham <dien.pham.ry@rvc.renesas.com>,
        Hien Dang <hien.dang.eb@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V4] PCI: rcar: Use runtime PM to control controller clock
Message-ID: <20180319084447.ce44arxneqd6i3bj@verge.net.au>
References: <20180318105209.5922-1-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180318105209.5922-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 18, 2018 at 11:52:09AM +0100, Marek Vasut wrote:
> From: Dien Pham <dien.pham.ry@rvc.renesas.com>
> 
> The controller clock can be switched off during suspend/resume,
> let runtime PM take care of that.
> 
> Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
> Signed-off-by: Hien Dang <hien.dang.eb@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org
> ---
> V2: - Reorder the fail path in rcar_pcie_probe() to cater for the
>       reordering of function calls in probe
>     - Dispose of fail_clk in rcar_pcie_get_resources()
> V3: - Fix up the failpath in probe function
> V4: - Rebase on recent linux-next
> ---
>  drivers/pci/host/pcie-rcar.c | 40 ++++++++++++----------------------------
>  1 file changed, 12 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index b4c4aad2cf66..93d59f15c589 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -142,7 +142,6 @@ struct rcar_pcie {
>  	void __iomem		*base;
>  	struct list_head	resources;
>  	int			root_bus_nr;
> -	struct clk		*clk;
>  	struct clk		*bus_clk;
>  	struct			rcar_msi msi;
>  };
> @@ -914,24 +913,14 @@ static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
>  	if (IS_ERR(pcie->base))
>  		return PTR_ERR(pcie->base);
>  
> -	pcie->clk = devm_clk_get(dev, "pcie");
> -	if (IS_ERR(pcie->clk)) {
> -		dev_err(dev, "cannot get platform clock\n");
> -		return PTR_ERR(pcie->clk);
> -	}
> -	err = clk_prepare_enable(pcie->clk);
> -	if (err)
> -		return err;
> -
>  	pcie->bus_clk = devm_clk_get(dev, "pcie_bus");
>  	if (IS_ERR(pcie->bus_clk)) {
>  		dev_err(dev, "cannot get pcie bus clock\n");
> -		err = PTR_ERR(pcie->bus_clk);
> -		goto fail_clk;
> +		return PTR_ERR(pcie->bus_clk);
>  	}
>  	err = clk_prepare_enable(pcie->bus_clk);
>  	if (err)
> -		goto fail_clk;
> +		return err;
>  
>  	i = irq_of_parse_and_map(dev->of_node, 0);
>  	if (!i) {
> @@ -953,8 +942,6 @@ static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
>  
>  err_map_reg:
>  	clk_disable_unprepare(pcie->bus_clk);
> -fail_clk:
> -	clk_disable_unprepare(pcie->clk);
>  
>  	return err;
>  }
> @@ -1124,22 +1111,22 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  	if (err)
>  		goto err_free_bridge;

This error path now calls pci_free_resource_list() and in this case
the path is taken if rcar_pcie_parse_request_of_pci_ranges() fails.
Is that ok?

>  
> +	pm_runtime_enable(pcie->dev);
> +	err = pm_runtime_get_sync(pcie->dev);
> +	if (err < 0) {
> +		dev_err(pcie->dev, "pm_runtime_get_sync failed\n");
> +		goto err_pm_disable;
> +	}
> +
>  	err = rcar_pcie_get_resources(pcie);
>  	if (err < 0) {
>  		dev_err(dev, "failed to request resources: %d\n", err);
> -		goto err_free_resource_list;
> +		goto err_pm_put;
>  	}
>  
>  	err = rcar_pcie_parse_map_dma_ranges(pcie, dev->of_node);
>  	if (err)
> -		goto err_free_resource_list;
> -
> -	pm_runtime_enable(dev);
> -	err = pm_runtime_get_sync(dev);
> -	if (err < 0) {
> -		dev_err(dev, "pm_runtime_get_sync failed\n");
> -		goto err_pm_disable;
> -	}
> +		goto err_pm_put;
>  
>  	/* Failure to get a link might just be that no cards are inserted */
>  	hw_init_fn = of_device_get_match_data(dev);
> @@ -1171,13 +1158,10 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  
>  err_pm_put:
>  	pm_runtime_put(dev);
> -
>  err_pm_disable:
>  	pm_runtime_disable(dev);
> -
> -err_free_resource_list:
> -	pci_free_resource_list(&pcie->resources);
>  err_free_bridge:
> +	pci_free_resource_list(&pcie->resources);
>  	pci_free_host_bridge(bridge);
>  
>  	return err;
> -- 
> 2.16.2
> 
