Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:56035 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753994AbeE1IvG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 May 2018 04:51:06 -0400
Date: Mon, 28 May 2018 10:51:02 +0200
From: Simon Horman <horms@verge.net.au>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 1/6] PCI: rcar: Pull bus clock enable/disable from
 rcar_pcie_get_resources()
Message-ID: <20180528085101.b4ietevu2rralhwc@verge.net.au>
References: <20180524143624.26718-1-marek.vasut+renesas@gmail.com>
 <20180524143624.26718-2-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180524143624.26718-2-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 24, 2018 at 04:36:19PM +0200, Marek Vasut wrote:
> The rcar_pcie_get_resources() is another misnomer with a side effect.
> The function does not only get resources, but also enables/disables bus
> clock. This is forgotten in the probe() function though and if anything
> in probe() fails after rcar_pcie_get_resources() is called, the bus
> clock are never disabled.
> 
> This patch pulls the clock handling out of the rcar_pcie_get_resources()
> and enables clock after all the resources were requested. Moreover, this
> patch also always disables the clock in case of failure.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: No change
> V3: No change
> V4: Rebase on top of Lorenzo's pci/rcar, fix up the rebase breakage
>     induced by patches therein


Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/pci/host/pcie-rcar.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index 8d161563bce8..0879880f7975 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -946,32 +946,22 @@ static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
>  		dev_err(dev, "cannot get pcie bus clock\n");
>  		return PTR_ERR(pcie->bus_clk);
>  	}
> -	err = clk_prepare_enable(pcie->bus_clk);
> -	if (err)
> -		return err;
>  
>  	i = irq_of_parse_and_map(dev->of_node, 0);
>  	if (!i) {
>  		dev_err(dev, "cannot get platform resources for msi interrupt\n");
> -		err = -ENOENT;
> -		goto err_map_reg;
> +		return -ENOENT;
>  	}
>  	pcie->msi.irq1 = i;
>  
>  	i = irq_of_parse_and_map(dev->of_node, 1);
>  	if (!i) {
>  		dev_err(dev, "cannot get platform resources for msi interrupt\n");
> -		err = -ENOENT;
> -		goto err_map_reg;
> +		return -ENOENT;
>  	}
>  	pcie->msi.irq2 = i;
>  
>  	return 0;
> -
> -err_map_reg:
> -	clk_disable_unprepare(pcie->bus_clk);
> -
> -	return err;
>  }
>  
>  static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
> @@ -1115,22 +1105,28 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  		goto err_pm_put;
>  	}
>  
> +	err = clk_prepare_enable(pcie->bus_clk);
> +	if (err) {
> +		dev_err(dev, "failed to enable bus clock: %d\n", err);
> +		goto err_pm_put;
> +	}
> +
>  	err = rcar_pcie_parse_map_dma_ranges(pcie, dev->of_node);
>  	if (err)
> -		goto err_pm_put;
> +		goto err_clk_disable;
>  
>  	phy_init_fn = of_device_get_match_data(dev);
>  	err = phy_init_fn(pcie);
>  	if (err) {
>  		dev_err(dev, "failed to init PCIe PHY\n");
> -		goto err_pm_put;
> +		goto err_clk_disable;
>  	}
>  
>  	/* Failure to get a link might just be that no cards are inserted */
>  	if (rcar_pcie_hw_init(pcie)) {
>  		dev_info(dev, "PCIe link down\n");
>  		err = -ENODEV;
> -		goto err_pm_put;
> +		goto err_clk_disable;
>  	}
>  
>  	data = rcar_pci_read_reg(pcie, MACSR);
> @@ -1142,16 +1138,19 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  			dev_err(dev,
>  				"failed to enable MSI support: %d\n",
>  				err);
> -			goto err_pm_put;
> +			goto err_clk_disable;
>  		}
>  	}
>  
>  	err = rcar_pcie_enable(pcie);
>  	if (err)
> -		goto err_pm_put;
> +		goto err_clk_disable;
>  
>  	return 0;
>  
> +err_clk_disable:
> +	clk_disable_unprepare(pcie->bus_clk);
> +
>  err_pm_put:
>  	pm_runtime_put(dev);
>  
> -- 
> 2.16.2
> 
