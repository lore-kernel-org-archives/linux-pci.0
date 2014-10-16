Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48141 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbaJPKyM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Oct 2014 06:54:12 -0400
Message-ID: <1413456849.2165.13.camel@antimon.intern.lynxeye.de>
Subject: Re: [PATCH v6 09/13] PCI: imx6: Add imx6sx pcie support
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <richard.zhu@freescale.com>
Cc: linux-pci@vger.kernel.org, shawn.guo@freescale.com,
	festevam@gmail.com, tharvey@gateworks.com,
	Richard Zhu <r65037@freescale.com>
Date: Thu, 16 Oct 2014 12:54:09 +0200
In-Reply-To: <1413445963-24706-10-git-send-email-richard.zhu@freescale.com>
References: <1413445963-24706-1-git-send-email-richard.zhu@freescale.com>
	 <1413445963-24706-10-git-send-email-richard.zhu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, den 16.10.2014, 15:52 +0800 schrieb Richard Zhu:
> From: Richard Zhu <r65037@freescale.com>
> 
> - imx6sx pcie has its own standalone pcie power supply.
> In order to turn on the imx6sx pcie power during
> initialization. Add the pcie regulator and the gpc regmap
> into the imx6sx pcie structure.
> - imx6sx pcie has the new added reset mechanism, add the
> reset operations into the initialization.
> - register one PM call-back, enter/exit L2 state during
> system suspend/resume.
> use noirq pm_ops instead of the general pm_ops in dev_pm_ops,
> since cfg read/write may occurs after suspend and before resume.
> do msi store/re-store in suspend/resume callbacks, since
> controller maybe turned off, and these msi cfg maybe lost
> in suspend.
> - disp_axi clock is required by pcie inbound axi port actually.
> Add one more clock named pcie_inbound_axi for imx6sx pcie.
> - host init maybe failed, return negative value when
> there is a failure in the host init.
> 
> Signed-off-by: Richard Zhu <richard.zhu@freescale.com>
> ---
>  drivers/pci/host/pci-imx6.c | 204 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 183 insertions(+), 21 deletions(-)
> 
[...]
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int pci_imx_suspend_noirq(struct device *dev)
> +{
> +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> +	struct pcie_port *pp = &imx6_pcie->pp;
> +
> +	if (is_imx6sx_pcie(imx6_pcie)) {
> +		if (IS_ENABLED(CONFIG_PCI_MSI))
> +			dw_pcie_msi_cfg_store(pp);
> +
> +		/* PM_TURN_OFF */
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
> +				IMX6SX_GPR12_PCIE_PM_TURN_OFF);
> +		udelay(10);
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				IMX6SX_GPR12_PCIE_PM_TURN_OFF, 0);
> +		clk_disable_unprepare(imx6_pcie->pcie);
> +		clk_disable_unprepare(imx6_pcie->pcie_bus);
> +		clk_disable_unprepare(imx6_pcie->pcie_phy);
> +		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> +	}
> +
> +	return 0;
> +}
> +
> +static int pci_imx_resume_noirq(struct device *dev)
> +{
> +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> +	struct pcie_port *pp = &imx6_pcie->pp;
> +
> +	if (is_imx6sx_pcie(imx6_pcie)) {
> +		clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
> +		clk_prepare_enable(imx6_pcie->pcie_bus);
> +		clk_prepare_enable(imx6_pcie->pcie_phy);
> +		clk_prepare_enable(imx6_pcie->pcie);
> +
> +		/* Reset iMX6SX PCIe */
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
> +				IMX6SX_GPR5_PCIE_PERST, IMX6SX_GPR5_PCIE_PERST);
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
> +				IMX6SX_GPR5_PCIE_PERST, 0);
> +		/*
> +		 * controller maybe turn off, re-configure again
> +		 */
> +		dw_pcie_setup_rc(pp);
> +
> +		if (IS_ENABLED(CONFIG_PCI_MSI))
> +			dw_pcie_msi_cfg_restore(pp);
> +
> +		/* RESET EP */
> +		gpio_set_value(imx6_pcie->reset_gpio, 0);
> +		udelay(10);

You are violating the spec here: "When PERST# is asserted it must remain
active for a minimum of 100 us (Tperst)." Also you probably want to put
the EP in reset at suspend and only release the reset in the resume
path.

> +		gpio_set_value(imx6_pcie->reset_gpio, 1);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops pci_imx_pm_ops = {
> +	.suspend_noirq = pci_imx_suspend_noirq,
> +	.resume_noirq = pci_imx_resume_noirq,
> +	.freeze_noirq = pci_imx_suspend_noirq,
> +	.thaw_noirq = pci_imx_resume_noirq,
> +	.poweroff_noirq = pci_imx_suspend_noirq,
> +	.restore_noirq = pci_imx_resume_noirq,
> +};
> +#endif
> +
>  static int __init imx6_pcie_probe(struct platform_device *pdev)
>  {
>  	struct imx6_pcie *imx6_pcie;
> @@ -610,9 +751,28 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(imx6_pcie->pcie);
>  	}
>  
> -	/* Grab GPR config register range */
> -	imx6_pcie->iomuxc_gpr =
> -		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> +	if (is_imx6sx_pcie(imx6_pcie)) {
> +		imx6_pcie->pcie_inbound_axi = devm_clk_get(&pdev->dev,
> +				"pcie_inbound_axi");
> +		if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {
> +			dev_err(&pdev->dev,
> +				"pcie clock source missing or invalid\n");
> +			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
> +		}
> +
> +		imx6_pcie->pcie_phy_regulator = devm_regulator_get(pp->dev,
> +				"pcie-phy");
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
> @@ -636,6 +796,7 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
>  
>  static const struct of_device_id imx6_pcie_of_match[] = {
>  	{ .compatible = "fsl,imx6q-pcie", },
> +	{ .compatible = "fsl,imx6sx-pcie", },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, imx6_pcie_of_match);
> @@ -645,6 +806,7 @@ static struct platform_driver imx6_pcie_driver = {
>  		.name	= "imx6q-pcie",
>  		.owner	= THIS_MODULE,
>  		.of_match_table = imx6_pcie_of_match,
> +		.pm = &pci_imx_pm_ops,
>  	},
>  	.shutdown = imx6_pcie_shutdown,
>  };


