Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36816 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751318AbcDRI7T (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2016 04:59:19 -0400
Message-ID: <1460969956.2331.5.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/3] PCI: imx6: Implement reset sequence for i.MX6+
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	gary.bisson@boundarydevices.com
Date: Mon, 18 Apr 2016 10:59:16 +0200
In-Reply-To: <1460958677-10604-2-git-send-email-andrew.smirnov@gmail.com>
References: <1460958677-10604-1-git-send-email-andrew.smirnov@gmail.com>
	 <1460958677-10604-2-git-send-email-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Sonntag, den 17.04.2016, 22:51 -0700 schrieb Andrey Smirnov:
> I.MX6+ has a dedicated bit for reseting PCIe core, which should be used
> instead of a regular reset sequence since using the latter will hang the
> SoC.
> 
> This commit is based on c34068d48273e24d392d9a49a38be807954420ed from
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
> 
> Changes since v1:
> 
> 	- Patchset is rebased against
>           https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-imx6
> 
> 	- DTS files changes moved into a separate patch
> 
>  drivers/pci/host/pci-imx6.c                 | 28 ++++++++++++++++++++++++++--
>  include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |  1 +
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index c570bbb..834c5b8 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -33,7 +33,8 @@
>  
>  enum imx6_pcie_variants {
>  	IMX6Q,
> -	IMX6SX
> +	IMX6SX,
> +	IMX6QP,
>  };
>  
>  struct imx6_pcie {
> @@ -253,6 +254,11 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
>  				   IMX6SX_GPR5_PCIE_BTNRST_RESET,
>  				   IMX6SX_GPR5_PCIE_BTNRST_RESET);
>  		break;
> +	case IMX6QP:
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				   IMX6Q_GPR1_PCIE_SW_RST,
> +				   IMX6Q_GPR1_PCIE_SW_RST);
> +		break;
>  	case IMX6Q:
>  		/*
>  		 * If the bootloader already enabled the link we need some special
> @@ -307,6 +313,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
>  		break;
> +	case IMX6QP: 		/* FALLTHROUGH */
>  	case IMX6Q:
>  		/* power up core phy and enable ref clock */
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> @@ -367,9 +374,22 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
>  		gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 1);
>  	}
>  
> -	if (imx6_pcie->variant == IMX6SX)
> +	switch (imx6_pcie->variant) {
> +	case IMX6SX:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
>  				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
> +		break;
> +	case IMX6QP:
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				   IMX6Q_GPR1_PCIE_SW_RST, 0);
> +
> +		usleep_range(200, 500);
> +		break;
> +	case IMX6Q:		/* Nothing to do */
> +		break;
> +	default:
> +		BUG();
> +	}
>  
>  	return 0;
>  
> @@ -601,6 +621,9 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  	if (of_device_is_compatible(pp->dev->of_node,
>  				    "fsl,imx6sx-pcie"))
>  		imx6_pcie->variant = IMX6SX;
> +	else if (of_device_is_compatible(pp->dev->of_node,
> +					 "fsl,imx6qp-pcie"))
> +		imx6_pcie->variant = IMX6QP;
>  	else
>  		imx6_pcie->variant = IMX6Q;
>  
> @@ -697,6 +720,7 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
>  static const struct of_device_id imx6_pcie_of_match[] = {
>  	{ .compatible = "fsl,imx6q-pcie", },
>  	{ .compatible = "fsl,imx6sx-pcie", },
> +	{ .compatible = "fsl,imx6qp-pcie", },

New DT compatibles must be documented in
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt.

Otherwise same comments as on the first patch.

>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, imx6_pcie_of_match);
> diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> index 238c8db..5b08e3c 100644
> --- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> +++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> @@ -95,6 +95,7 @@
>  #define IMX6Q_GPR0_DMAREQ_MUX_SEL0_IOMUX	BIT(0)
>  
>  #define IMX6Q_GPR1_PCIE_REQ_MASK		(0x3 << 30)
> +#define IMX6Q_GPR1_PCIE_SW_RST			BIT(29)
>  #define IMX6Q_GPR1_PCIE_EXIT_L1			BIT(28)
>  #define IMX6Q_GPR1_PCIE_RDY_L23			BIT(27)
>  #define IMX6Q_GPR1_PCIE_ENTER_L1		BIT(26)


