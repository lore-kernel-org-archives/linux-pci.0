Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42368 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbaJLO1x (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 12 Oct 2014 10:27:53 -0400
Message-ID: <1413124067.2459.12.camel@antimon.intern.lynxeye.de>
Subject: Re: [PATCH v5 4/9] PCI: imx6: add imx6sx pcie support
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <richard.zhu@freescale.com>
Cc: linux-pci@vger.kernel.org, shawn.guo@freescale.com,
	festevam@gmail.com, tharvey@gateworks.com,
	Richard Zhu <r65037@freescale.com>
Date: Sun, 12 Oct 2014 16:27:47 +0200
In-Reply-To: <1412919676-25344-5-git-send-email-richard.zhu@freescale.com>
References: <1412919676-25344-1-git-send-email-richard.zhu@freescale.com>
	 <1412919676-25344-5-git-send-email-richard.zhu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, den 10.10.2014, 13:41 +0800 schrieb Richard Zhu:
> From: Richard Zhu <r65037@freescale.com>
> 
> - imx6sx pcie has its own standalone pcie power supply.
> In order to turn on the imx6sx pcie power during
> initialization. Add the pcie regulator and the gpc regmap
> into the imx6sx pcie structure.
> - imx6sx pcie has the new added reset mechanism, add the
> reset operations into the initialization.
> - Register one PM call-back, enter/exit L2 state of the ASPM
> during system suspend/resume.
> - disp_axi clock is required by pcie inbound axi port actually.
> Add one more clock named pcie_inbound_axi for imx6sx pcie.

> Signed-off-by: Richard Zhu <richard.zhu@freescale.com>

In addition to Fabios comment I have one additional nitpick below and
also you didn't include all the feedback from the last round.

> ---
>  drivers/pci/host/pci-imx6.c | 161 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 143 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index eac96fb..5ece4e1 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -22,8 +22,10 @@
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
> @@ -35,11 +37,15 @@ struct imx6_pcie {
>  	int			reset_gpio;
>  	struct clk		*pcie_bus;
>  	struct clk		*pcie_phy;
> +	struct clk		*pcie_inbound_axi;
>  	struct clk		*pcie;
>  	struct pcie_port	pp;
>  	struct regmap		*iomuxc_gpr;
> +	struct regmap		*gpc_ips_reg;
> +	struct regulator	*pcie_phy_regulator;
>  	void __iomem		*mem_base;
>  };
> +static struct imx6_pcie *imx6_pcie;

Remove this static struct. I've already said on the last version that
this is completely backwards.

>  
>  /* PCIe Root Complex registers (memory-mapped) */
>  #define PCIE_RC_LCR				0x7c
> @@ -77,6 +83,18 @@ struct imx6_pcie {
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
> @@ -275,18 +293,29 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
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
> +		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
> +		if (ret) {
> +			dev_err(pp->dev, "unable to enable pcie clock\n");
> +			goto err_inbound_axi;
> +		}
> +
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				IMX6SX_GPR12_PCIE_TEST_PD, 0);
> +	} else {
> +		/* power up core phy and enable ref clock */
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				IMX6Q_GPR1_PCIE_TEST_PD, 0);
> +		/*
> +		 * the async reset input need ref clock to sync internally,
> +		 * when the ref clock comes after reset, internal synced
> +		 * reset time is too short , cannot meet the requirement.
> +		 * add one ~10us delay here.
> +		 */
> +		udelay(10);
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);

[...]

Please use IMX6Q_GPR1_PCIE_REF_CLK_EN instead of 1 << 16 here. I know
this is only moved code, but as you are touching it anyway this cleanup
should be folded in.


