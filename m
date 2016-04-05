Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54038 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760592AbcDEV4k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 5 Apr 2016 17:56:40 -0400
Date: Tue, 5 Apr 2016 16:56:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lee Jones <lee.jones@linaro.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] PCI: imx6: Add initial imx6sx support
Message-ID: <20160405215625.GF15353@localhost>
References: <1456411669-4699-1-git-send-email-chf.fritz@googlemail.com>
 <1456411669-4699-3-git-send-email-chf.fritz@googlemail.com>
 <20160311175850.GA4725@localhost>
 <1457911590.16725.37.camel@googlemail.com>
 <1457911870.16725.42.camel@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457911870.16725.42.camel@googlemail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 14, 2016 at 12:31:10AM +0100, Christoph Fritz wrote:
> Add initial PCIe support for the imx6 SoC derivate imx6sx.  PCI MSI support
> is untested as the necessary suspend/resume quirk is not included in this
> patch.
> 
> This patch is heavily based on patches by Richard Zhu.
> 
> [bhelgaas: factor out refclk enable, fix adjacent typos in imx6q-pcie.txt]
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> Acked-by: Richard Zhu <Richard.Zhu@freescale.com>
> Acked-by: Lucas Stach <l.stach@pengutronix.de>

Applied to pci/host-imx6 for v4.7, thanks!

> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  8 +++-
>  drivers/pci/host/pci-imx6.c                        | 53 ++++++++++++++++++++++
>  2 files changed, 59 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index 6fbba53..6ee4439 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -4,8 +4,8 @@ This PCIe host controller is based on the Synopsis Designware PCIe IP
>  and thus inherits all the common properties defined in designware-pcie.txt.
>  
>  Required properties:
> -- compatible: "fsl,imx6q-pcie"
> -- reg: base addresse and length of the pcie controller
> +- compatible: "fsl,imx6q-pcie", "fsl,imx6sx-pcie"
> +- reg: base address and length of the PCIe controller
>  - interrupts: A list of interrupt outputs of the controller. Must contain an
>    entry for each entry in the interrupt-names property.
>  - interrupt-names: Must include the following entries:
> @@ -13,6 +13,10 @@ Required properties:
>  - clock-names: Must include the following additional entries:
>  	- "pcie_phy"
>  
> +Additional required properties for imx6sx-pcie:
> +- clock names: Must include the following additional entries:
> +	- "pcie_inbound_axi"
> +
>  Example:
>  
>  	pcie@0x01000000 {
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 4e0e47f..fa3a544 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -35,9 +35,11 @@ struct imx6_pcie {
>  	struct gpio_desc	*reset_gpio;
>  	struct clk		*pcie_bus;
>  	struct clk		*pcie_phy;
> +	struct clk		*pcie_inbound_axi;
>  	struct clk		*pcie;
>  	struct pcie_port	pp;
>  	struct regmap		*iomuxc_gpr;
> +	bool			is_imx6sx;
>  	void __iomem		*mem_base;
>  };
>  
> @@ -231,6 +233,17 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
>  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
>  	u32 val, gpr1, gpr12;
>  
> +	if (imx6_pcie->is_imx6sx) {
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
> +				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
> +		/* Force PCIe PHY reset */
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
> +				   IMX6SX_GPR5_PCIE_BTNRST_RESET,
> +				   IMX6SX_GPR5_PCIE_BTNRST_RESET);
> +		return 0;
> +	}
> +
>  	/*
>  	 * If the bootloader already enabled the link we need some special
>  	 * handling to get the core back into a state where it is safe to
> @@ -266,6 +279,21 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
>  
>  static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  {
> +	struct pcie_port *pp = &imx6_pcie->pp;
> +	int ret;
> +
> +	if (imx6_pcie->is_imx6sx) {
> +		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
> +		if (ret) {
> +			dev_err(pp->dev, "unable to enable pcie_axi clock\n");
> +			return ret;
> +		}
> +
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
> +		return ret;
> +	}
> +
>  	/* power up core phy and enable ref clock */
>  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>  			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> @@ -319,6 +347,11 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
>  		msleep(100);
>  		gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 1);
>  	}
> +
> +	if (imx6_pcie->is_imx6sx)
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
> +				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
> +
>  	return 0;
>  
>  err_ref_clk:
> @@ -336,6 +369,12 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
>  {
>  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
>  
> +	if (imx6_pcie->is_imx6sx) {
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
> +				   IMX6SX_GPR12_PCIE_RX_EQ_2);
> +	}
> +
>  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  			IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
>  
> @@ -554,6 +593,9 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  	pp = &imx6_pcie->pp;
>  	pp->dev = &pdev->dev;
>  
> +	imx6_pcie->is_imx6sx = of_device_is_compatible(pp->dev->of_node,
> +						       "fsl,imx6sx-pcie");
> +
>  	/* Added for PCI abort handling */
>  	hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
>  		"imprecise external abort");
> @@ -589,6 +631,16 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(imx6_pcie->pcie);
>  	}
>  
> +	if (imx6_pcie->is_imx6sx) {
> +		imx6_pcie->pcie_inbound_axi = devm_clk_get(&pdev->dev,
> +							   "pcie_inbound_axi");
> +		if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {
> +			dev_err(&pdev->dev,
> +				"pcie_incbound_axi clock missing or invalid\n");
> +			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
> +		}
> +	}
> +
>  	/* Grab GPR config register range */
>  	imx6_pcie->iomuxc_gpr =
>  		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> @@ -615,6 +667,7 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
>  
>  static const struct of_device_id imx6_pcie_of_match[] = {
>  	{ .compatible = "fsl,imx6q-pcie", },
> +	{ .compatible = "fsl,imx6sx-pcie", },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, imx6_pcie_of_match);
> -- 
> 2.1.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
