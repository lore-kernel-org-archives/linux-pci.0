Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46141 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbaI2KSq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Sep 2014 06:18:46 -0400
Message-ID: <1411985921.2625.13.camel@pengutronix.de>
Subject: Re: [PATCH v3 7/9] PCI: imx6: add imx6sx pcie support
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <r65037@freescale.com>
Cc: linux-pci-owner@vger.kernel.org, linux-pci@vger.kernel.org,
	shawn.guo@freescale.com, festevam@gmail.com, tharvey@gateworks.com
Date: Mon, 29 Sep 2014 12:18:41 +0200
In-Reply-To: <1411966997-27118-8-git-send-email-r65037@freescale.com>
References: <1411966997-27118-1-git-send-email-r65037@freescale.com>
	 <1411966997-27118-8-git-send-email-r65037@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 29.09.2014, 13:03 +0800 schrieb Richard Zhu:
> - imx6sx pcie has its own standalone pcie power supply.
> In order to turn on the imx6sx pcie power during
> initialization. Add the pcie regulator and the gpc regmap
> into the imx6sx pcie structure.
> - imx6sx pcie has the new added reset mechanism, add the
> reset operations into the initialization.
> - Register one PM call-back, enter/exit L2 state of the ASPM
> during system suspend/resume.
> - disp_axi clock is required by pcie inbound axi port actually.
> Add one more clock for imx6sx pcie.
> 
> Signed-off-by: Richard Zhu <r65037@freescale.com>
> ---
>  drivers/pci/host/pci-imx6.c | 162 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 144 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index eac96fb..be953aa 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -18,12 +18,16 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
>  #include <linux/module.h>
> +#include <linux/of_address.h>

Why do you need this include?

> +#include <linux/of_device.h>
>  #include <linux/of_gpio.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/resource.h>
>  #include <linux/signal.h>
> +#include <linux/syscore_ops.h>
>  #include <linux/types.h>
>  #include <linux/interrupt.h>
>  
> @@ -35,11 +39,15 @@ struct imx6_pcie {
>  	int			reset_gpio;
>  	struct clk		*pcie_bus;
>  	struct clk		*pcie_phy;
> +	struct clk		*disp_axi;

This needs a more descriptive name, just like the binding.

>  	struct clk		*pcie;
>  	struct pcie_port	pp;
>  	struct regmap		*iomuxc_gpr;
> +	struct regmap		*gpc_ips_reg;
> +	struct regulator	*pcie_regulator;
>  	void __iomem		*mem_base;
>  };
> +static struct imx6_pcie *imx6_pcie;
>  
>  /* PCIe Root Complex registers (memory-mapped) */
>  #define PCIE_RC_LCR				0x7c
> @@ -77,6 +85,18 @@ struct imx6_pcie {
>  #define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
>  #define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
>  
> +/* GPC PCIE PHY bit definitions */
> +#define GPC_CNTR			0
> +#define GPC_CNTR_PCIE_PHY_PUP_REQ	BIT(7)
> +
> +static inline bool is_imx6sx_pcie(struct imx6_pcie *imx6_pcie)
> +{
> +	struct pcie_port *pp = &imx6_pcie->pp;
> +	struct device_node *np = pp->dev->of_node;
> +
> +	return of_device_is_compatible(np, "fsl,imx6sx-pcie");
> +}
> +
>  static int pcie_phy_poll_ack(void __iomem *dbi_base, int exp_val)
>  {
>  	u32 val;
> @@ -275,18 +295,29 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
>  		goto err_pcie;
>  	}
>  
> -	/* power up core phy and enable ref clock */
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> -	/*
> -	 * the async reset input need ref clock to sync internally,
> -	 * when the ref clock comes after reset, internal synced
> -	 * reset time is too short , cannot meet the requirement.
> -	 * add one ~10us delay here.
> -	 */
> -	udelay(10);
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
> +	if (is_imx6sx_pcie(imx6_pcie)) {
> +		ret = clk_prepare_enable(imx6_pcie->disp_axi);
> +		if (ret) {
> +			dev_err(pp->dev, "unable to enable pcie clock\n");
> +			goto err_disp;
> +		}
> +
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				IMX6SX_GPR12_PCIE_TEST_PD, 0 << 30);
> +	} else {
> +		/* power up core phy and enable ref clock */
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> +		/*
> +		 * the async reset input need ref clock to sync internally,
> +		 * when the ref clock comes after reset, internal synced
> +		 * reset time is too short , cannot meet the requirement.
> +		 * add one ~10us delay here.
> +		 */
> +		udelay(10);
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
> +	}
>  
>  	/* allow the clocks to stabilize */
>  	usleep_range(200, 500);
> @@ -297,8 +328,19 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
>  		msleep(100);
>  		gpio_set_value(imx6_pcie->reset_gpio, 1);
>  	}
> +
> +	/*
> +	 * Release the PCIe PHY reset here, that we have set in
> +	 * imx6_pcie_init_phy() now
> +	 */
> +	if (is_imx6sx_pcie(imx6_pcie))
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
> +				IMX6SX_GPR5_PCIE_BTNRST, 0 << 19);
> +
>  	return 0;
>  
> +err_disp:
> +	clk_disable_unprepare(imx6_pcie->pcie);
>  err_pcie:
>  	clk_disable_unprepare(imx6_pcie->pcie_bus);
>  err_pcie_bus:
> @@ -311,6 +353,26 @@ err_pcie_phy:
>  static void imx6_pcie_init_phy(struct pcie_port *pp)
>  {
>  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
> +	int ret;
> +
> +	/* Power up the separate domain available on i.MX6SX */
> +	if (is_imx6sx_pcie(imx6_pcie)) {
> +		/* Force PCIe PHY reset */
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
> +				IMX6SX_GPR5_PCIE_BTNRST,
> +				IMX6SX_GPR5_PCIE_BTNRST);
> +
> +		regmap_update_bits(imx6_pcie->gpc_ips_reg, GPC_CNTR,
> +				GPC_CNTR_PCIE_PHY_PUP_REQ,
> +				GPC_CNTR_PCIE_PHY_PUP_REQ);
> +		regulator_set_voltage(imx6_pcie->pcie_regulator,
> +				1100000, 1100000);
> +		ret = regulator_enable(imx6_pcie->pcie_regulator);
> +		if (ret)
> +			dev_info(pp->dev, "failed to enable pcie regulator.\n");
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				IMX6SX_GPR12_RX_EQ_MASK, IMX6SX_GPR12_RX_EQ_2);
> +	}
>  
>  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  			IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
> @@ -319,7 +381,7 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
>  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  			IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT << 12);
>  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -			IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
> +			IMX6Q_GPR12_LOS_LEVEL, IMX6Q_GPR12_LOS_LEVEL_9);
>  
>  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
>  			IMX6Q_GPR8_TX_DEEMPH_GEN1, 0 << 0);
> @@ -377,7 +439,8 @@ static int imx6_pcie_start_link(struct pcie_port *pp)
>  
>  	/* Start LTSSM. */
>  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
> +			IMX6Q_GPR12_PCIE_CTL_2,
> +			IMX6Q_GPR12_PCIE_CTL_2);
>  
>  	ret = imx6_pcie_wait_for_link(pp);
>  	if (ret)
> @@ -553,9 +616,50 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int pci_imx_suspend(void)
> +{
> +	if (is_imx6sx_pcie(imx6_pcie)) {
> +		/* PM_TURN_OFF */
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
> +				IMX6SX_GPR12_PCIE_PM_TURN_OFF);
> +		udelay(10);
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				IMX6SX_GPR12_PCIE_PM_TURN_OFF, 0 << 16);

Just use 0 as the last argument. Those shifts aren't adding anything and
I would like to get rid of them long term, so please don't introduce new
ones.

> +	}
> +
> +	return 0;
> +}
> +
> +static void pci_imx_resume(void)
> +{
> +	struct pcie_port *pp = &imx6_pcie->pp;
> +
> +	if (is_imx6sx_pcie(imx6_pcie)) {
> +		/* Reset iMX6SX PCIe */
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
> +				IMX6SX_GPR5_PCIE_PERST, IMX6SX_GPR5_PCIE_PERST);
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
> +				IMX6SX_GPR5_PCIE_PERST, 0 << 18);
> +		/*
> +		 * controller maybe turn off, re-configure again
> +		 */
> +		dw_pcie_setup_rc(pp);
> +
> +		if (IS_ENABLED(CONFIG_PCI_MSI))
> +			dw_pcie_msi_cfg_restore(pp);
> +	}
> +}
> +
> +static struct syscore_ops pci_imx_syscore_ops = {
> +	.suspend = pci_imx_suspend,
> +	.resume = pci_imx_resume,
> +};
> +#endif
> +
>  static int __init imx6_pcie_probe(struct platform_device *pdev)
>  {
> -	struct imx6_pcie *imx6_pcie;
>  	struct pcie_port *pp;
>  	struct device_node *np = pdev->dev.of_node;
>  	struct resource *dbi_base;
> @@ -610,9 +714,27 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(imx6_pcie->pcie);
>  	}
>  
> -	/* Grab GPR config register range */
> -	imx6_pcie->iomuxc_gpr =
> -		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> +	if (is_imx6sx_pcie(imx6_pcie)) {
> +		imx6_pcie->disp_axi = devm_clk_get(&pdev->dev, "disp_axi");
> +		if (IS_ERR(imx6_pcie->disp_axi)) {
> +			dev_err(&pdev->dev,
> +				"pcie clock source missing or invalid\n");
> +			return PTR_ERR(imx6_pcie->disp_axi);
> +		}
> +
> +		imx6_pcie->pcie_regulator = devm_regulator_get(pp->dev,
> +				"pcie_phy");
> +
> +		imx6_pcie->iomuxc_gpr =
> +			 syscon_regmap_lookup_by_compatible
> +			 ("fsl,imx6sx-iomuxc-gpr");
> +		imx6_pcie->gpc_ips_reg =
> +			 syscon_regmap_lookup_by_compatible("fsl,imx6sx-gpc");
> +	} else {
> +		imx6_pcie->iomuxc_gpr =
> +			syscon_regmap_lookup_by_compatible
> +			("fsl,imx6q-iomuxc-gpr");
> +	}
>  	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
>  		dev_err(&pdev->dev, "unable to find iomuxc registers\n");
>  		return PTR_ERR(imx6_pcie->iomuxc_gpr);
> @@ -623,6 +745,9 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	platform_set_drvdata(pdev, imx6_pcie);
> +#ifdef CONFIG_PM_SLEEP
> +	register_syscore_ops(&pci_imx_syscore_ops);
> +#endif
>  	return 0;
>  }
>  
> @@ -636,6 +761,7 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
>  
>  static const struct of_device_id imx6_pcie_of_match[] = {
>  	{ .compatible = "fsl,imx6q-pcie", },
> +	{ .compatible = "fsl,imx6sx-pcie", },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, imx6_pcie_of_match);

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

