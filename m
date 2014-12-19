Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53893 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbaLSKTq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Dec 2014 05:19:46 -0500
Message-ID: <1418984372.2558.1.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] PCI: imx6: Add power-supply support
From: Lucas Stach <l.stach@pengutronix.de>
To: Sean Cross <xobs@kosagi.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Shawn Guo <shawn.guo@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org, Richard Zhu <r65037@freescale.com>,
	Grant Likely <grant.likely@linaro.org>,
	linux-pci@vger.kernel.org, bunnie@kosagi.com
Date: Fri, 19 Dec 2014 11:19:32 +0100
In-Reply-To: <1418976617-833-2-git-send-email-xobs@kosagi.com>
References: <1418976617-833-1-git-send-email-xobs@kosagi.com>
	 <1418976617-833-2-git-send-email-xobs@kosagi.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, den 19.12.2014, 16:10 +0800 schrieb Sean Cross:
> Some PCIe ports gate power to the slot.  In order to prevent system lockup,
> these boards must enable power to the slot before attempting communication
> over the PCI bus.
> 
> Signed-off-by: Sean Cross <xobs@kosagi.com>
> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt       |  3 +++
>  drivers/pci/host/pci-imx6.c                          | 20 +++++++++++++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index 6fbba53..fe912bd 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -13,6 +13,9 @@ Required properties:
>  - clock-names: Must include the following additional entries:
>  	- "pcie_phy"
>  
> +Optional properties:
> +- power-supply: A regulator that controls power to the port

This is a way too generic name. In order to provide the functionality
you are intending, this regulator needs to supply the whole bus
(remember not every board has just a single slot). It should be named
accordingly.

So I would expect this to look something like the following:

bus-supply: A regulator that controls main power to every device on the
bus.

> +
>  Example:
>  
>  	pcie@0x01000000 {
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 69202d1..9c2140e 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -22,6 +22,7 @@
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/resource.h>
>  #include <linux/signal.h>
>  #include <linux/types.h>
> @@ -39,6 +40,7 @@ struct imx6_pcie {
>  	struct pcie_port	pp;
>  	struct regmap		*iomuxc_gpr;
>  	void __iomem		*mem_base;
> +	struct regulator	*power_reg;
>  };
>  
>  /* PCIe Root Complex registers (memory-mapped) */
> @@ -588,6 +590,19 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	/* Fetch power supply */
> +	imx6_pcie->power_reg = devm_regulator_get(&pdev->dev, "power");

Use devm_regulator_get_optional instead.

> +	if (IS_ERR(imx6_pcie->power_reg))
> +		imx6_pcie->power_reg = 0;

This can go away if you use the above, but really? 0 to a pointer? I
know it isn't invalid, but it's also bad style.

You must handle -EPROBE_DEFER here instead.

> +
> +	if (imx6_pcie->power_reg) {
> +		ret = regulator_enable(imx6_pcie->power_reg);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Unable to enable power regulator");
> +			return ret;
> +		}
> +	}
> +
I'm not really comfortable with enabling directly at probe time, but
given our failure paths are horrible enough as they are right now I
agree that this is the sanest solution for now.

But please move both enabling and disabling at failure into
imx6_add_pcie_port().

>  	/* Fetch clocks */
>  	imx6_pcie->pcie_phy = devm_clk_get(&pdev->dev, "pcie_phy");
>  	if (IS_ERR(imx6_pcie->pcie_phy)) {
> @@ -619,8 +634,11 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = imx6_add_pcie_port(pp, pdev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		if (imx6_pcie->power_reg)
> +			regulator_disable(imx6_pcie->power_reg);
>  		return ret;
> +	}
>  
>  	platform_set_drvdata(pdev, imx6_pcie);
>  	return 0;

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

