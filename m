Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:57767 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754858Ab3LIWi3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2013 17:38:29 -0500
Received: by mail-qc0-f182.google.com with SMTP id e16so3222626qcx.13
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2013 14:38:28 -0800 (PST)
Date: Mon, 9 Dec 2013 15:38:24 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: marex@denx.de, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH 2/2] PCI: imx6: Remove unneeded 'goto err'
Message-ID: <20131209223824.GD2135@google.com>
References: <1385955575-25270-1-git-send-email-festevam@gmail.com>
 <1385955575-25270-2-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385955575-25270-2-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 02, 2013 at 01:39:35AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> There is no need to use 'goto err' as we can directly return the errors.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Since there's no functional change, I also applied this one to
pci/host-imx6 for v3.14.  I agree that leaving the DABT handler installed
is a bug and should be fixed by another patch.

Bjorn

> ---
>  drivers/pci/host/pci-imx6.c | 34 ++++++++++++----------------------
>  1 file changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 5002e23..9fc1cb6 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -427,10 +427,8 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  
>  	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	pp->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_base);
> -	if (IS_ERR(pp->dbi_base)) {
> -		ret = PTR_ERR(pp->dbi_base);
> -		goto err;
> -	}
> +	if (IS_ERR(pp->dbi_base))
> +		return PTR_ERR(pp->dbi_base);
>  
>  	/* Fetch GPIOs */
>  	imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
> @@ -444,7 +442,7 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  				"PCIe reset");
>  	if (ret) {
>  		dev_err(&pdev->dev, "unable to get reset gpio\n");
> -		goto err;
> +		return ret;
>  	}
>  
>  	imx6_pcie->power_on_gpio = of_get_named_gpio(np, "power-on-gpio", 0);
> @@ -455,7 +453,7 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  					"PCIe power enable");
>  		if (ret) {
>  			dev_err(&pdev->dev, "unable to get power-on gpio\n");
> -			goto err;
> +			return ret;
>  		}
>  	}
>  
> @@ -467,7 +465,7 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  					"PCIe wake up");
>  		if (ret) {
>  			dev_err(&pdev->dev, "unable to get wake-up gpio\n");
> -			goto err;
> +			return ret;
>  		}
>  	}
>  
> @@ -479,7 +477,7 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  					"PCIe disable endpoint");
>  		if (ret) {
>  			dev_err(&pdev->dev, "unable to get disable-ep gpio\n");
> -			goto err;
> +			return ret;
>  		}
>  	}
>  
> @@ -488,32 +486,28 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  	if (IS_ERR(imx6_pcie->lvds_gate)) {
>  		dev_err(&pdev->dev,
>  			"lvds_gate clock select missing or invalid\n");
> -		ret = PTR_ERR(imx6_pcie->lvds_gate);
> -		goto err;
> +		return PTR_ERR(imx6_pcie->lvds_gate);
>  	}
>  
>  	imx6_pcie->sata_ref_100m = devm_clk_get(&pdev->dev, "sata_ref_100m");
>  	if (IS_ERR(imx6_pcie->sata_ref_100m)) {
>  		dev_err(&pdev->dev,
>  			"sata_ref_100m clock source missing or invalid\n");
> -		ret = PTR_ERR(imx6_pcie->sata_ref_100m);
> -		goto err;
> +		return PTR_ERR(imx6_pcie->sata_ref_100m);
>  	}
>  
>  	imx6_pcie->pcie_ref_125m = devm_clk_get(&pdev->dev, "pcie_ref_125m");
>  	if (IS_ERR(imx6_pcie->pcie_ref_125m)) {
>  		dev_err(&pdev->dev,
>  			"pcie_ref_125m clock source missing or invalid\n");
> -		ret = PTR_ERR(imx6_pcie->pcie_ref_125m);
> -		goto err;
> +		return PTR_ERR(imx6_pcie->pcie_ref_125m);
>  	}
>  
>  	imx6_pcie->pcie_axi = devm_clk_get(&pdev->dev, "pcie_axi");
>  	if (IS_ERR(imx6_pcie->pcie_axi)) {
>  		dev_err(&pdev->dev,
>  			"pcie_axi clock source missing or invalid\n");
> -		ret = PTR_ERR(imx6_pcie->pcie_axi);
> -		goto err;
> +		return PTR_ERR(imx6_pcie->pcie_axi);
>  	}
>  
>  	/* Grab GPR config register range */
> @@ -521,19 +515,15 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
>  	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
>  		dev_err(&pdev->dev, "unable to find iomuxc registers\n");
> -		ret = PTR_ERR(imx6_pcie->iomuxc_gpr);
> -		goto err;
> +		return PTR_ERR(imx6_pcie->iomuxc_gpr);
>  	}
>  
>  	ret = imx6_add_pcie_port(pp, pdev);
>  	if (ret < 0)
> -		goto err;
> +		return ret;
>  
>  	platform_set_drvdata(pdev, imx6_pcie);
>  	return 0;
> -
> -err:
> -	return ret;
>  }
>  
>  static const struct of_device_id imx6_pcie_of_match[] = {
> -- 
> 1.8.1.2
> 
