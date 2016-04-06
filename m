Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41678 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933798AbcDFJtL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2016 05:49:11 -0400
Message-ID: <1459936100.2256.30.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] PCI: imx6: Add reset-gpio-active-high boolean
 property to DT
From: Lucas Stach <l.stach@pengutronix.de>
To: Petr =?UTF-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Russell King <linux@arm.linux.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Tim Harvey <tharvey@gateworks.com>,
	Krzysztof =?UTF-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Fabio Estevam <festevam@gmail.com>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>, stefan@agner.ch
Date: Wed, 06 Apr 2016 11:48:20 +0200
In-Reply-To: <1459935244-10077-1-git-send-email-ynezz@true.cz>
References: <CAOMZO5AnN4_RrA4bksWNmioAP1PCBT1Ax4of_OnoCvG+VXgDUQ@mail.gmail.com>
	 <1459935244-10077-1-git-send-email-ynezz@true.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, den 06.04.2016, 11:34 +0200 schrieb Petr Štetiar:
> We need that property in order to make the Toradex Apalis SoMs working
> without breaking old DTBs. On Apalis SoMs the GPIO1_IO28 used to PCIe
> reset is not connected directly to PERST# PCIe signal, but it's ORed
> with RESETBMCU coming off the PMIC, and thus is inverted, active-high.
> 
I don't think the commit message should contain references to the
specific board, as the board implementation is unrelated to the PCIe
change.

Please just explain why the added property is necessary and why it is
done this way.

> Signed-off-by: Petr Štetiar <ynezz@true.cz>
> ---
>  Changes since v1:
>   
>   * Added documentation of reset-gpio and reset-gpio-active-high DT properties
>   * Removed unnecessary double negation of GPIO value
> 
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt |  5 +++++
>  drivers/pci/host/pci-imx6.c                              | 14 +++++++++++---
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index 3be80c6..23ecb47 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -19,6 +19,11 @@ Optional properties:
>  - fsl,tx-deemph-gen2-6db: Gen2 (6db) De-emphasis value. Default: 20
>  - fsl,tx-swing-full: Gen2 TX SWING FULL value. Default: 127
>  - fsl,tx-swing-low: TX launch amplitude swing_low value. Default: 127
> +- reset-gpio: Should specify the GPIO for PHY reset. Its not polarity aware
> +  and defaults to active-low reset sequence (L=reset state, H=operation state).

This is not a PHY reset GPIO. It's a GPIO controlling the PCI bus device
reset signal.

> +- reset-gpio-active-high: If present then the reset sequence using the GPIO
> +  specified in the "reset-gpio" property is reversed (H=reset state,
> +  L=operation state).
>  
>  Example:
>  
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 2f817fa..17f4cc3 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -33,6 +33,7 @@
>  
>  struct imx6_pcie {
>  	int			reset_gpio;
> +	bool			gpio_active_high;
>  	struct clk		*pcie_bus;
>  	struct clk		*pcie_phy;
>  	struct clk		*pcie;
> @@ -310,9 +311,11 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
>  
>  	/* Some boards don't have PCIe reset GPIO. */
>  	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> -		gpio_set_value_cansleep(imx6_pcie->reset_gpio, 0);
> +		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> +					imx6_pcie->gpio_active_high);
>  		msleep(100);
> -		gpio_set_value_cansleep(imx6_pcie->reset_gpio, 1);
> +		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> +					!imx6_pcie->gpio_active_high);
>  	}
>  	return 0;
>  
> @@ -546,9 +549,14 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  
>  	/* Fetch GPIOs */
>  	imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
> +	imx6_pcie->gpio_active_high = of_property_read_bool(np,
> +						"reset-gpio-active-high");
>  	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
>  		ret = devm_gpio_request_one(&pdev->dev, imx6_pcie->reset_gpio,
> -					    GPIOF_OUT_INIT_LOW, "PCIe reset");
> +				imx6_pcie->gpio_active_high ?
> +					GPIOF_OUT_INIT_HIGH :
> +					GPIOF_OUT_INIT_LOW,
> +				"PCIe reset");
>  		if (ret) {
>  			dev_err(&pdev->dev, "unable to get reset gpio\n");
>  			return ret;


