Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35986 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934AbbKXNzi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2015 08:55:38 -0500
Message-ID: <1448373334.3689.33.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: imx6: Fix reset-gpio to work with active low GPIO
From: Lucas Stach <l.stach@pengutronix.de>
To: Petr =?UTF-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <Richard.Zhu@freescale.com>
Date: Tue, 24 Nov 2015 14:55:34 +0100
In-Reply-To: <1447687147-19436-1-git-send-email-ynezz@true.cz>
References: <1447687147-19436-1-git-send-email-ynezz@true.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Petr,

sorry for the delay in reviewing this.

Am Montag, den 16.11.2015, 16:19 +0100 schrieb Petr Štetiar:
> It's currently not possible to use reset-gpio on board where the GPIO is
> active low as the code incorrectly assumes, that reset-gpio will be
> always active high.
> 
I see the need for this change, but I'm not completely happy with the
implementation.

> In my case the broken behavior was observed on Toradex Apalis SoM with
> Ixora base board.
> 
> Signed-off-by: Petr Štetiar <ynezz@true.cz>
> ---
>  drivers/pci/host/pci-imx6.c |   15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index fdb9536..cd7ed71 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -293,9 +293,11 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
>  
>  	/* Some boards don't have PCIe reset GPIO. */
>  	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> -		gpio_set_value(imx6_pcie->reset_gpio, 0);
> +		struct gpio_desc *gd = gpio_to_desc(imx6_pcie->reset_gpio);
> +
> +		gpiod_set_value(gd, 0);
>  		msleep(100);
> -		gpio_set_value(imx6_pcie->reset_gpio, 1);
> +		gpiod_set_value(gd, 1);
>  	}
>  	return 0;
>  
> @@ -559,6 +561,8 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  	struct pcie_port *pp;
>  	struct device_node *np = pdev->dev.of_node;
>  	struct resource *dbi_base;
> +	enum of_gpio_flags of_flags;
> +	int flags = GPIOF_OUT_INIT_LOW;
>  	int ret;
>  
>  	imx6_pcie = devm_kzalloc(&pdev->dev, sizeof(*imx6_pcie), GFP_KERNEL);
> @@ -578,10 +582,13 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(pp->dbi_base);
>  
>  	/* Fetch GPIOs */
> -	imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
> +	imx6_pcie->reset_gpio = of_get_named_gpio_flags(np, "reset-gpio", 0,
> +	

Rather than adding all this complexity to this function, this should
really be switched over to the descriptor based GPIO interface as a
whole. So the above should become a single call to
"devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW)" and the dependent
code changed accordingly.

Regards,
Lucas

> 						&of_flags);
>  	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> +		if (of_flags & OF_GPIO_ACTIVE_LOW)
> +			flags |= GPIOF_ACTIVE_LOW;
>  		ret = devm_gpio_request_one(&pdev->dev, imx6_pcie->reset_gpio,
> -					    GPIOF_OUT_INIT_LOW, "PCIe reset");
> +					    flags, "PCIe reset");
>  		if (ret) {
>  			dev_err(&pdev->dev, "unable to get reset gpio\n");
>  			return ret;

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

