Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42935 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753645AbcC3N3J (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2016 09:29:09 -0400
Message-ID: <1459344542.2565.44.camel@pengutronix.de>
Subject: Re: [PATCH v2] Revert "PCI: imx6: Add support for active-low reset
 GPIO"
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, Richard.Zhu@freescale.com, khalasa@piap.pl,
	ynezz@true.cz, linux-pci@vger.kernel.org, tharvey@gateworks.com,
	Fabio Estevam <fabio.estevam@nxp.com>, stable@vger.kernel.org
Date: Wed, 30 Mar 2016 15:29:02 +0200
In-Reply-To: <1459201536-5558-1-git-send-email-festevam@gmail.com>
References: <1459201536-5558-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 28.03.2016, 18:45 -0300 schrieb Fabio Estevam:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Commit 5c5fb40de8f14 ("PCI: imx6: Add support for active-low reset GPIO")
> cause regressions on some boards like MX6 Gateworks Ventana, for example.
> 
> The reason for the breakage is that this commit sets the gpio polarity
> in the wrong logic level.
> 
> Also, the commit log is wrong because active-low reset GPIO is what the
> driver used to support since the beginning.
> 
> So keep the old behavior that ignores the gpio polarity specified in
> the device tree and treat the PCI reset GPIO as active-low.
> 
> Cc: <stable@vger.kernel.org> # 4.5
> Reported-by: Krzysztof Hałasa <khalasa@piap.pl>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

We need to keep compatibility to existing DTs that are setting the GPIO
active polarity in the wrong way, so this revert is correct:

Acked-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> Changes since v1:
> - Improve wording of commit log (Tim)
> 
>  drivers/pci/host/pci-imx6.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index eb5a275..2f817fa 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -32,7 +32,7 @@
>  #define to_imx6_pcie(x)	container_of(x, struct imx6_pcie, pp)
>  
>  struct imx6_pcie {
> -	struct gpio_desc	*reset_gpio;
> +	int			reset_gpio;
>  	struct clk		*pcie_bus;
>  	struct clk		*pcie_phy;
>  	struct clk		*pcie;
> @@ -309,10 +309,10 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
>  	usleep_range(200, 500);
>  
>  	/* Some boards don't have PCIe reset GPIO. */
> -	if (imx6_pcie->reset_gpio) {
> -		gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 0);
> +	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> +		gpio_set_value_cansleep(imx6_pcie->reset_gpio, 0);
>  		msleep(100);
> -		gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 1);
> +		gpio_set_value_cansleep(imx6_pcie->reset_gpio, 1);
>  	}
>  	return 0;
>  
> @@ -523,6 +523,7 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  {
>  	struct imx6_pcie *imx6_pcie;
>  	struct pcie_port *pp;
> +	struct device_node *np = pdev->dev.of_node;
>  	struct resource *dbi_base;
>  	struct device_node *node = pdev->dev.of_node;
>  	int ret;
> @@ -544,8 +545,15 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(pp->dbi_base);
>  
>  	/* Fetch GPIOs */
> -	imx6_pcie->reset_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
> -							GPIOD_OUT_LOW);
> +	imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
> +	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> +		ret = devm_gpio_request_one(&pdev->dev, imx6_pcie->reset_gpio,
> +					    GPIOF_OUT_INIT_LOW, "PCIe reset");
> +		if (ret) {
> +			dev_err(&pdev->dev, "unable to get reset gpio\n");
> +			return ret;
> +		}
> +	}
>  
>  	/* Fetch clocks */
>  	imx6_pcie->pcie_phy = devm_clk_get(&pdev->dev, "pcie_phy");


