Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:56373 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751237AbcDRIxT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2016 04:53:19 -0400
Message-ID: <1460969596.2331.4.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/3] PCI: imx6: Use enum instead of bool for variant
 indicator
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	gary.bisson@boundarydevices.com
Date: Mon, 18 Apr 2016 10:53:16 +0200
In-Reply-To: <1460958677-10604-1-git-send-email-andrew.smirnov@gmail.com>
References: <1460958677-10604-1-git-send-email-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Sonntag, den 17.04.2016, 22:51 -0700 schrieb Andrey Smirnov:
> Use enumerated type instead of a boolean flag to specify the variant of
> the PCIe IP block (6Q, 6SX, etc). This patch has zero functional impact,
> however it makes the code easier to extend for the case of more than 2
> possible variants of an IP block (of which there are).
> 
This is the right thing to do, but I'm not yet satisfied with the
implementation.

> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
> 
> Changes since v1:
> 
> 	- Patchset is rebased against
>           https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-imx6
> 
> 	- DTS files changes moved into a separate patch
> 
> 
>  drivers/pci/host/pci-imx6.c | 126 +++++++++++++++++++++++++-------------------
>  1 file changed, 71 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 0f6d630..c570bbb 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -31,6 +31,11 @@
>  
>  #define to_imx6_pcie(x)	container_of(x, struct imx6_pcie, pp)
>  
> +enum imx6_pcie_variants {
> +	IMX6Q,
> +	IMX6SX
> +};
> +
>  struct imx6_pcie {
>  	struct gpio_desc	*reset_gpio;
>  	struct clk		*pcie_bus;
> @@ -39,7 +44,7 @@ struct imx6_pcie {
>  	struct clk		*pcie;
>  	struct pcie_port	pp;
>  	struct regmap		*iomuxc_gpr;
> -	bool			is_imx6sx;
> +	enum imx6_pcie_variants variant;
>  	void __iomem		*mem_base;
>  	u32			tx_deemph_gen1;
>  	u32			tx_deemph_gen2_3p5db;
> @@ -238,7 +243,8 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
>  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
>  	u32 val, gpr1, gpr12;
>  
> -	if (imx6_pcie->is_imx6sx) {
> +	switch (imx6_pcie->variant) {
> +	case IMX6SX:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
>  				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
> @@ -246,72 +252,80 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
>  				   IMX6SX_GPR5_PCIE_BTNRST_RESET,
>  				   IMX6SX_GPR5_PCIE_BTNRST_RESET);
> -		return 0;
> -	}
> -
> -	/*
> -	 * If the bootloader already enabled the link we need some special
> -	 * handling to get the core back into a state where it is safe to
> -	 * touch it for configuration.  As there is no dedicated reset signal
> -	 * wired up for MX6QDL, we need to manually force LTSSM into "detect"
> -	 * state before completely disabling LTSSM, which is a prerequisite
> -	 * for core configuration.
> -	 *
> -	 * If both LTSSM_ENABLE and REF_SSP_ENABLE are active we have a strong
> -	 * indication that the bootloader activated the link.
> -	 */
> -	regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1, &gpr1);
> -	regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, &gpr12);
> -
> -	if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
> -	    (gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
> -		val = readl(pp->dbi_base + PCIE_PL_PFLR);
> -		val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
> -		val |= PCIE_PL_PFLR_FORCE_LINK;
> -		writel(val, pp->dbi_base + PCIE_PL_PFLR);
> +		break;
> +	case IMX6Q:
> +		/*
> +		 * If the bootloader already enabled the link we need some special
> +		 * handling to get the core back into a state where it is safe to
> +		 * touch it for configuration.  As there is no dedicated reset signal
> +		 * wired up for MX6QDL, we need to manually force LTSSM into "detect"
> +		 * state before completely disabling LTSSM, which is a prerequisite
> +		 * for core configuration.
> +		 *
> +		 * If both LTSSM_ENABLE and REF_SSP_ENABLE are active we have a strong
> +		 * indication that the bootloader activated the link.
> +		 */
> +		regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1, &gpr1);
> +		regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, &gpr12);
> +
> +		if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
> +		    (gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
> +			val = readl(pp->dbi_base + PCIE_PL_PFLR);
> +			val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
> +			val |= PCIE_PL_PFLR_FORCE_LINK;
> +			writel(val, pp->dbi_base + PCIE_PL_PFLR);
> +
> +			regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +					   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
> +		}
>  
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				   IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
> +		break;
> +	default:
> +		BUG();

Don't do this. BUG() is always a potential kernel DoS and especially if
it depends on external data like the devicetree.

Please remove the default case, without it the compiler will warn if we
ever forget to update one of those switch statements for another
variant.

>  	}
>  
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -			IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -			IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
> -
>  	return 0;
>  }
>  
>  static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  {
>  	struct pcie_port *pp = &imx6_pcie->pp;
> -	int ret;
> +	int ret = 0;
>  
> -	if (imx6_pcie->is_imx6sx) {
> +	switch (imx6_pcie->variant) {
> +	case IMX6SX:
>  		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
>  		if (ret) {
>  			dev_err(pp->dev, "unable to enable pcie_axi clock\n");
> -			return ret;
> +			break;
>  		}
>  
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
> -		return ret;
> +		break;
> +	case IMX6Q:
> +		/* power up core phy and enable ref clock */
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				   IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> +		/*
> +		 * the async reset input need ref clock to sync internally,
> +		 * when the ref clock comes after reset, internal synced
> +		 * reset time is too short, cannot meet the requirement.
> +		 * add one ~10us delay here.
> +		 */
> +		udelay(10);
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
> +		break;
> +	default:
> +		BUG();

Same comment as above.

>  	}
>  
> -	/* power up core phy and enable ref clock */
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> -	/*
> -	 * the async reset input need ref clock to sync internally,
> -	 * when the ref clock comes after reset, internal synced
> -	 * reset time is too short, cannot meet the requirement.
> -	 * add one ~10us delay here.
> -	 */
> -	udelay(10);
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
> -	return 0;
> +	return ret;
>  }
>  
>  static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
> @@ -353,7 +367,7 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
>  		gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 1);
>  	}
>  
> -	if (imx6_pcie->is_imx6sx)
> +	if (imx6_pcie->variant == IMX6SX)
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
>  				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
>  
> @@ -374,11 +388,10 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
>  {
>  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
>  
> -	if (imx6_pcie->is_imx6sx) {
> +	if (imx6_pcie->variant == IMX6SX)
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
>  				   IMX6SX_GPR12_PCIE_RX_EQ_2);
> -	}
>  
>  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  			IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
> @@ -585,8 +598,11 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  	pp = &imx6_pcie->pp;
>  	pp->dev = &pdev->dev;
>  
> -	imx6_pcie->is_imx6sx = of_device_is_compatible(pp->dev->of_node,
> -						       "fsl,imx6sx-pcie");
> +	if (of_device_is_compatible(pp->dev->of_node,
> +				    "fsl,imx6sx-pcie"))
> +		imx6_pcie->variant = IMX6SX;
> +	else
> +		imx6_pcie->variant = IMX6Q;

Please use of_match_data for this.

>  
>  	/* Added for PCI abort handling */
>  	hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
> @@ -623,7 +639,7 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(imx6_pcie->pcie);
>  	}
>  
> -	if (imx6_pcie->is_imx6sx) {
> +	if (imx6_pcie->variant == IMX6SX) {
>  		imx6_pcie->pcie_inbound_axi = devm_clk_get(&pdev->dev,
>  							   "pcie_inbound_axi");
>  		if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {


