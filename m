Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41367 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755325AbcDFJlg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2016 05:41:36 -0400
Message-ID: <1459935692.2256.26.camel@pengutronix.de>
Subject: Re: [PATCH v4] PCI: imx6: add dt prop for link gen, default to gen1
From: Lucas Stach <l.stach@pengutronix.de>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Zhu Richard <Richard.Zhu@freescale.com>,
	Akshay Bhat <akshay.bhat@timesys.com>,
	Rob Herring <robh+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Date: Wed, 06 Apr 2016 11:41:32 +0200
In-Reply-To: <1459873754-31410-1-git-send-email-tharvey@gateworks.com>
References: <1459873754-31410-1-git-send-email-tharvey@gateworks.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Dienstag, den 05.04.2016, 09:29 -0700 schrieb Tim Harvey:
> Freescale has stated [1] that the LVDS clock source of the IMX6 does not pass
> the PCI Gen2 clock jitter test, therefore unless an external Gen2 compliant
> external clock source is present and supplied back to the IMX6 PCIe core
> via LVDS CLK1/CLK2 you can not claim Gen2 compliance.
> 
> Add a dt property to specify gen1 vs gen2 and check this before allowing
> a Gen2 link.
> 
> We default to Gen1 if the property is not present because at this time there
> are no IMX6 boards in mainline that 'input' a clock on LVDS CLK1/CLK2.
> 
> In order to be Gen2 compliant on IMX6 you need to:
>  - have a Gen2 compliant external clock generator and route that clock back
>    to either LVDS CLK1 or LVDS CLK2 as an input.
>    (see IMX6SX-SabreSD reference design)
>  - specify this clock in the pcie node in the dt
>    (ie IMX6QDL_CLK_LVDS1_IN or IMX6QDL_CLK_LVDS2_IN instead of
>     IMX6QDL_CLK_LVDS1_GATE which configures it as a CLK output)
> 
> [1] https://community.freescale.com/message/453209
> 
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Zhu Richard <Richard.Zhu@freescale.com>
> Cc: Akshay Bhat <akshay.bhat@timesys.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

One nit below. Maybe Bjorn can fix this up while applying, otherwise if
you need to resend you may carry the blow tag.

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> v4:
>  - rebase against linux-pci/master
>  - add fsl vendor prefix to dt prop
> 
> v3:
>  - added note in dt bindings doc that we limit to gen1 unless this is specified
>    as gen2 capable
>  - move property to imx6 pcie phy instead of designware core
>  - don't use &ret as temp storage as of_property_read_u32() doesn't change the
>    outval if property isn't found
> v2:
>  - moved dt property to designware core
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  4 ++++
>  drivers/pci/host/pci-imx6.c                        | 24 +++++++++++++++-------
>  2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index 3be80c6..b92fafb 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -19,6 +19,10 @@ Optional properties:
>  - fsl,tx-deemph-gen2-6db: Gen2 (6db) De-emphasis value. Default: 20
>  - fsl,tx-swing-full: Gen2 TX SWING FULL value. Default: 127
>  - fsl,tx-swing-low: TX launch amplitude swing_low value. Default: 127
> +- fsl,max-link-speed: Specify PCI gen for link capability. Must be '2' for
> +  gen2, otherwise will default to gen1. Note that the IMX6 LVDS clock outputs
> +  do not meet gen2 jitter requirements and thus for gen2 capability a gen2
> +  compliant clock generator should be used and configured.
>  
>  Example:
>  
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index eb5a275..9656ac7 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -44,6 +44,7 @@ struct imx6_pcie {
>  	u32			tx_deemph_gen2_6db;
>  	u32			tx_swing_full;
>  	u32			tx_swing_low;
> +	int			link_gen;
>  };
>  
>  /* PCIe Root Complex registers (memory-mapped) */
> @@ -417,11 +418,15 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
>  		goto err_reset_phy;
>  	}
>  
> -	/* Allow Gen2 mode after the link is up. */
> -	tmp = readl(pp->dbi_base + PCIE_RC_LCR);
> -	tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
> -	tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2;
> -	writel(tmp, pp->dbi_base + PCIE_RC_LCR);
> +	if (imx6_pcie->link_gen == 2) {
> +		/* Allow Gen2 mode after the link is up. */
> +		tmp = readl(pp->dbi_base + PCIE_RC_LCR);
> +		tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
> +		tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2;
> +		writel(tmp, pp->dbi_base + PCIE_RC_LCR);
> +	} else {
> +		dev_info(pp->dev, "Link: Gen2 disabled\n");
> +	}
>  
>  	/*
>  	 * Start Directed Speed Change so the best possible speed both link
> @@ -445,8 +450,7 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
>  	}
>  
>  	tmp = readl(pp->dbi_base + PCIE_RC_LCSR);
> -	dev_dbg(pp->dev, "Link up, Gen=%i\n", (tmp >> 16) & 0xf);
> -
> +	dev_info(pp->dev, "Link up, Gen%i\n", (tmp >> 16) & 0xf);
>  	return 0;
>  
>  err_reset_phy:
> @@ -598,6 +602,12 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  				 &imx6_pcie->tx_swing_low))
>  		imx6_pcie->tx_swing_low = 127;
>  
> +	/* Limit link speed */
> +	ret = of_property_read_u32(pp->dev->of_node, "fsl,max-link-speed",
> +				   &imx6_pcie->link_gen);
> +	if (ret)
> +		imx6_pcie->link_gen = -1;

The binding specifies that if the property is absent, it will default to
Gen1, so I would like to see this reflected here by setting the link_gen
to 1, not -1.

> +
>  	ret = imx6_add_pcie_port(pp, pdev);
>  	if (ret < 0)
>  		return ret;


