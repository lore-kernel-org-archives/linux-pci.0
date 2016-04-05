Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51975 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754001AbcDEVbW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 5 Apr 2016 17:31:22 -0400
Date: Tue, 5 Apr 2016 16:31:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, l.stach@pengutronix.de,
	Richard.Zhu@freescale.com, khalasa@piap.pl, ynezz@true.cz,
	linux-pci@vger.kernel.org, tharvey@gateworks.com,
	Fabio Estevam <fabio.estevam@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] Revert "PCI: imx6: Add support for active-low reset
 GPIO"
Message-ID: <20160405213117.GD15353@localhost>
References: <1459201536-5558-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1459201536-5558-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Fabio,

On Mon, Mar 28, 2016 at 06:45:36PM -0300, Fabio Estevam wrote:
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

Applied with acks from Tim and Lucas to for-linus for v4.6, thanks!

If I understand correctly, the revert fixes Gateworks Ventana, but
breaks Toradex Apalis Ixora.  It would be really nice to get Petr's
patches to fix that system in at the same time.  Looks like we just
need a minor documentation update there?

Bjorn

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
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
