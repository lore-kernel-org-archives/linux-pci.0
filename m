Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:57315 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1162420AbaDCHGH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Apr 2014 03:06:07 -0400
Date: Thu, 3 Apr 2014 14:50:39 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Lucas Stach <l.stach@pengutronix.de>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	Sean Cross <xobs@kosagi.com>, Marek Vasut <marex@denx.de>,
	Richard Zhu <r65037@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Tim Harvey <tharvey@gateworks.com>, <kernel@pengutronix.de>
Subject: Re: [PATCH 4/8] PCI: imx6: use new clock names
Message-ID: <20140403065037.GJ2801@dragon>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
 <1396025579-14344-5-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1396025579-14344-5-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 28, 2014 at 05:52:55PM +0100, Lucas Stach wrote:
> As defined in the new binding.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/host/pci-imx6.c | 74 ++++++++++++++++++---------------------------
>  1 file changed, 29 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index ee082509b0ba..71730bbcd9a2 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
...
> @@ -583,32 +574,25 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Fetch clocks */
> -	imx6_pcie->lvds_gate = devm_clk_get(&pdev->dev, "lvds_gate");
> -	if (IS_ERR(imx6_pcie->lvds_gate)) {
> -		dev_err(&pdev->dev,
> -			"lvds_gate clock select missing or invalid\n");
> -		return PTR_ERR(imx6_pcie->lvds_gate);
> -	}
> -
> -	imx6_pcie->sata_ref_100m = devm_clk_get(&pdev->dev, "sata_ref_100m");
> -	if (IS_ERR(imx6_pcie->sata_ref_100m)) {
> +	imx6_pcie->pcie_phy = devm_clk_get(&pdev->dev, "pcie_phy");
> +	if (IS_ERR(imx6_pcie->pcie_phy)) {

Won't this break the existing DTBs?

Shawn

>  		dev_err(&pdev->dev,
> -			"sata_ref_100m clock source missing or invalid\n");
> -		return PTR_ERR(imx6_pcie->sata_ref_100m);
> +			"pcie_phy clock source missing or invalid\n");
> +		return PTR_ERR(imx6_pcie->pcie_phy);
>  	}
>  
> -	imx6_pcie->pcie_ref_125m = devm_clk_get(&pdev->dev, "pcie_ref_125m");
> -	if (IS_ERR(imx6_pcie->pcie_ref_125m)) {
> +	imx6_pcie->pcie_bus = devm_clk_get(&pdev->dev, "pcie_bus");
> +	if (IS_ERR(imx6_pcie->pcie_bus)) {
>  		dev_err(&pdev->dev,
> -			"pcie_ref_125m clock source missing or invalid\n");
> -		return PTR_ERR(imx6_pcie->pcie_ref_125m);
> +			"pcie_bus clock source missing or invalid\n");
> +		return PTR_ERR(imx6_pcie->pcie_bus);
>  	}
>  
> -	imx6_pcie->pcie_axi = devm_clk_get(&pdev->dev, "pcie_axi");
> -	if (IS_ERR(imx6_pcie->pcie_axi)) {
> +	imx6_pcie->pcie = devm_clk_get(&pdev->dev, "pcie");
> +	if (IS_ERR(imx6_pcie->pcie)) {
>  		dev_err(&pdev->dev,
> -			"pcie_axi clock source missing or invalid\n");
> -		return PTR_ERR(imx6_pcie->pcie_axi);
> +			"pcie clock source missing or invalid\n");
> +		return PTR_ERR(imx6_pcie->pcie);
>  	}
>  
>  	/* Grab GPR config register range */
> -- 
> 1.9.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

