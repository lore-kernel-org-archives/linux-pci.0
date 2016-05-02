Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46628 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754709AbcEBTh6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 2 May 2016 15:37:58 -0400
Date: Mon, 2 May 2016 14:37:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	gary.bisson@boundarydevices.com
Subject: Re: [PATCH v3 1/3] PCI: imx6: Use enum instead of bool for variant
 indicator
Message-ID: <20160502193751.GJ24851@localhost>
References: <1461167131-26025-1-git-send-email-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461167131-26025-1-git-send-email-andrew.smirnov@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 20, 2016 at 08:45:29AM -0700, Andrey Smirnov wrote:
> Use enumerated type instead of a boolean flag to specify the variant of
> the PCIe IP block (6Q, 6SX, etc). This patch has zero functional impact,
> however it makes the code easier to extend for the case of more than 2
> possible variants of an IP block (of which there are).
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Applied with Fabio's Reviewed-by and Gary's Tested-by to pci/host-imx6
for v4.7, thanks, Andrey!  Also, thank you Fabio, Gary, and Lucas for
reviewing and testing.

> ---
> 
> Changes since v2:
> 	- Removed default clause in all introduced switch statements
> 	- Switched to using of_device_get_match_data instead of
>           explicit of_device_is_compatible checks
> 	- Added a mention of the new DT compatibility string in the documentation
> 
> Changes since v1:
> 
> 	- Patchset is rebased against
>           https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-imx6
> 
> 	- DTS files changes moved into a separate patch
> 
>  drivers/pci/host/pci-imx6.c | 124 ++++++++++++++++++++++++--------------------
>  1 file changed, 67 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 0f6d630..a77e7fd 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -19,6 +19,7 @@
>  #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
>  #include <linux/module.h>
>  #include <linux/of_gpio.h>
> +#include <linux/of_device.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> @@ -31,6 +32,11 @@
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
> @@ -39,7 +45,7 @@ struct imx6_pcie {
>  	struct clk		*pcie;
>  	struct pcie_port	pp;
>  	struct regmap		*iomuxc_gpr;
> -	bool			is_imx6sx;
> +	enum imx6_pcie_variants variant;
>  	void __iomem		*mem_base;
>  	u32			tx_deemph_gen1;
>  	u32			tx_deemph_gen2_3p5db;
> @@ -238,7 +244,8 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
>  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
>  	u32 val, gpr1, gpr12;
>  
> -	if (imx6_pcie->is_imx6sx) {
> +	switch (imx6_pcie->variant) {
> +	case IMX6SX:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
>  				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
> @@ -246,72 +253,76 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
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
> @@ -353,7 +364,7 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
>  		gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 1);
>  	}
>  
> -	if (imx6_pcie->is_imx6sx)
> +	if (imx6_pcie->variant == IMX6SX)
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
>  				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
>  
> @@ -374,11 +385,10 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
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
> @@ -585,8 +595,8 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  	pp = &imx6_pcie->pp;
>  	pp->dev = &pdev->dev;
>  
> -	imx6_pcie->is_imx6sx = of_device_is_compatible(pp->dev->of_node,
> -						       "fsl,imx6sx-pcie");
> +	imx6_pcie->variant =
> +		(enum imx6_pcie_variants)of_device_get_match_data(&pdev->dev);
>  
>  	/* Added for PCI abort handling */
>  	hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
> @@ -623,7 +633,7 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(imx6_pcie->pcie);
>  	}
>  
> -	if (imx6_pcie->is_imx6sx) {
> +	if (imx6_pcie->variant == IMX6SX) {
>  		imx6_pcie->pcie_inbound_axi = devm_clk_get(&pdev->dev,
>  							   "pcie_inbound_axi");
>  		if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {
> @@ -679,8 +689,8 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id imx6_pcie_of_match[] = {
> -	{ .compatible = "fsl,imx6q-pcie", },
> -	{ .compatible = "fsl,imx6sx-pcie", },
> +	{ .compatible = "fsl,imx6q-pcie",  .data = (void *)IMX6Q,  },
> +	{ .compatible = "fsl,imx6sx-pcie", .data = (void *)IMX6SX, },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, imx6_pcie_of_match);
> -- 
> 2.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
