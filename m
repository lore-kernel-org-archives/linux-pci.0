Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44897 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbbAEJqQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jan 2015 04:46:16 -0500
Message-ID: <1420451161.3024.5.camel@pengutronix.de>
Subject: Re: [PATCH v2 3/4] PCI: imx6: Add power-supply support
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
Date: Mon, 05 Jan 2015 10:46:01 +0100
In-Reply-To: <1419237127-21763-4-git-send-email-xobs@kosagi.com>
References: <1419237127-21763-1-git-send-email-xobs@kosagi.com>
	 <1419237127-21763-4-git-send-email-xobs@kosagi.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 22.12.2014, 16:32 +0800 schrieb Sean Cross:
> Some PCIe ports gate power to the slot.  In order to prevent system lockup,
> these boards must enable power to the slot before attempting communication
> over the PCI bus.
> 
> Signed-off-by: Sean Cross <xobs@kosagi.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  3 +++
>  drivers/pci/host/pci-imx6.c                        | 27 ++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index 6fbba53..a806b68 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -13,6 +13,9 @@ Required properties:
>  - clock-names: Must include the following additional entries:
>  	- "pcie_phy"
>  
> +Optional properties:
> +- bus-supply: A regulator that controls power to the entire bus
> +
>  Example:
>  
>  	pcie@0x01000000 {
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 69202d1..8e4f957 100644
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
> +	struct regulator	*bus_supply;
>  };
>  
>  /* PCIe Root Complex registers (memory-mapped) */
> @@ -523,6 +525,7 @@ static struct pcie_host_ops imx6_pcie_host_ops = {
>  static int __init imx6_add_pcie_port(struct pcie_port *pp,
>  			struct platform_device *pdev)
>  {
> +	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
>  	int ret;
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> @@ -544,9 +547,22 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
>  	pp->root_bus_nr = -1;
>  	pp->ops = &imx6_pcie_host_ops;
>  
> +	if (imx6_pcie->bus_supply) {
> +		ret = regulator_enable(imx6_pcie->bus_supply);
> +		if (ret) {
> +			dev_err(pp->dev,
> +				"unable to enable bus supply: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	ret = dw_pcie_host_init(pp);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to initialize host\n");
> +
> +		if (imx6_pcie->bus_supply)
> +			regulator_disable(imx6_pcie->bus_supply);
> +
>  		return ret;
>  	}
>  
> @@ -588,6 +604,17 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	/* Fetch bus supply */
> +	imx6_pcie->bus_supply = devm_regulator_get_optional(&pdev->dev, "bus");
> +	if (IS_ERR(imx6_pcie->bus_supply)) {
> +		ret = PTR_ERR(imx6_pcie->bus_supply);
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
> +
> +		dev_err(&pdev->dev, "unable to get bus-supply\n");
> +		return ret;
> +	}
> +
>  	/* Fetch clocks */
>  	imx6_pcie->pcie_phy = devm_clk_get(&pdev->dev, "pcie_phy");
>  	if (IS_ERR(imx6_pcie->pcie_phy)) {

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

