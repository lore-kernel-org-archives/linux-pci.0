Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A1CC282C2
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 12:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF79221721
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 12:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfBGMbk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:31:40 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36246 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfBGMbj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Feb 2019 07:31:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33E0AA78;
        Thu,  7 Feb 2019 04:31:39 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 008E83F675;
        Thu,  7 Feb 2019 04:31:37 -0800 (PST)
Date:   Thu, 7 Feb 2019 12:31:32 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2 3/3] PCI: imx: Add workaround for e10728, IMX7d PCIe
 PLL failure
Message-ID: <20190207123132.GA21111@e107981-ln.cambridge.arm.com>
References: <20190205001721.18639-1-tpiepho@impinj.com>
 <20190205001721.18639-4-tpiepho@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205001721.18639-4-tpiepho@impinj.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 05, 2019 at 12:17:41AM +0000, Trent Piepho wrote:
> This implements the workound described in the NXP IMX7d erratum e10728.
> 
> Initial VCO oscillation may fail under corner conditions such as cold
> temperature.  It causes PCIe PLL to fail to lock in the initialization
> phase, which results in the PCIe link failing to come up.
> 
> The workaround is to disable Duty-cycle Corrector (DCC) calibration
> after G_RST.
> 
> To do this it is necessary to gain access to the undocumented and
> currently unused PCIe PHY register bank.  A new device tree node of type
> "fsl,imx7d-pcie-phy" is created for the PHY block and the existing PCIe
> device uses a phandle named "fsl,imx7d-pcie-phy" to point to it.
> 
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 57 +++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 80f843030e36..06dd6aa927d4 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/of_gpio.h>
>  #include <linux/of_device.h>
> +#include <linux/of_address.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> @@ -61,6 +62,7 @@ struct imx6_pcie {
>  	u32			tx_swing_low;
>  	int			link_gen;
>  	struct regulator	*vpcie;
> +	void __iomem		*phy_base;
>  
>  	/* power domain for pcie */
>  	struct device		*pd_pcie;
> @@ -117,6 +119,23 @@ struct imx6_pcie {
>  #define PCIE_PHY_RX_ASIC_OUT 0x100D
>  #define PCIE_PHY_RX_ASIC_OUT_VALID	(1 << 0)
>  
> +/* iMX7 PCIe PHY registers */
> +#define PCIE_PHY_CMN_REG4		0x14
> +/* These are probably the bits that *aren't* DCC_FB_EN */
> +#define PCIE_PHY_CMN_REG4_DCC_FB_EN	0x29
> +
> +#define PCIE_PHY_CMN_REG15	        0x54
> +#define PCIE_PHY_CMN_REG15_DLY_4	BIT(2)
> +#define PCIE_PHY_CMN_REG15_PLL_PD	BIT(5)
> +#define PCIE_PHY_CMN_REG15_OVRD_PLL_PD	BIT(7)
> +
> +#define PCIE_PHY_CMN_REG24		0x90
> +#define PCIE_PHY_CMN_REG24_RX_EQ	BIT(6)
> +#define PCIE_PHY_CMN_REG24_RX_EQ_SEL	BIT(3)
> +
> +#define PCIE_PHY_CMN_REG26		0x98
> +#define PCIE_PHY_CMN_REG26_ATT_MODE	0xBC
> +
>  #define PHY_RX_OVRD_IN_LO 0x1005
>  #define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
>  #define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
> @@ -490,6 +509,26 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	switch (imx6_pcie->variant) {
>  	case IMX7D:
>  		reset_control_deassert(imx6_pcie->pciephy_reset);
> +
> +		/* Workaround for ERR010728, failure of PCI-e PLL VCO to
> +		 * oscillate, especially when cold.  This turns off "Duty-cycle
> +		 * Corrector" and other mysterious undocumented things.
> +		 */
> +		if (likely(imx6_pcie->phy_base)) {

Nit: this is not a fast-path, so this branch performance is hardly
relevant.

> +			/* De-assert DCC_FB_EN */
> +			writel(PCIE_PHY_CMN_REG4_DCC_FB_EN,
> +			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG4);
> +			/* Assert RX_EQS and RX_EQS_SEL */
> +			writel(PCIE_PHY_CMN_REG24_RX_EQ_SEL
> +				| PCIE_PHY_CMN_REG24_RX_EQ,
> +			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG24);
> +			/* Assert ATT_MODE */
> +			writel(PCIE_PHY_CMN_REG26_ATT_MODE,
> +			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG26);
> +		} else {
> +			dev_warn(dev, "DT lacks imx7d-pcie-phy, unable to apply ERR010728 workaround\n");

It is a nit but the warning log is not necessarily true ie you may not
have a mapped address for other reasons as well. It is up to you but I
would change the log message.

Thanks,
Lorenzo

> +		}
> +
>  		imx7d_pcie_wait_for_phy_pll_lock(imx6_pcie);
>  		break;
>  	case IMX6SX:
> @@ -919,6 +958,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct dw_pcie *pci;
>  	struct imx6_pcie *imx6_pcie;
> +	struct device_node *np;
>  	struct resource *dbi_base;
>  	struct device_node *node = dev->of_node;
>  	int ret;
> @@ -939,6 +979,23 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	imx6_pcie->variant =
>  		(enum imx6_pcie_variants)of_device_get_match_data(dev);
>  
> +	/* Find the PHY if one is defined, only imx7d uses it */
> +	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
> +	if (np) {
> +		struct resource res;
> +
> +		ret = of_address_to_resource(np, 0, &res);
> +		if (ret) {
> +			dev_err(dev, "Unable to map PCIe PHY\n");
> +			return ret;
> +		}
> +		imx6_pcie->phy_base = devm_ioremap_resource(dev, &res);
> +		if (IS_ERR(imx6_pcie->phy_base)) {
> +			dev_err(dev, "Unable to map PCIe PHY\n");
> +			return PTR_ERR(imx6_pcie->phy_base);
> +		}
> +	}
> +
>  	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
>  	if (IS_ERR(pci->dbi_base))
> -- 
> 2.14.4
> 
