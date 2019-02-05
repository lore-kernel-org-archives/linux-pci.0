Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7C1C282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 09:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3574C2080D
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 09:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfBEJsE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:48:04 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56307 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfBEJsE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Feb 2019 04:48:04 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gqxKk-0002hS-S1; Tue, 05 Feb 2019 10:48:02 +0100
Message-ID: <1549360082.2544.36.camel@pengutronix.de>
Subject: Re: [PATCH v2 3/3] PCI: imx: Add workaround for e10728, IMX7d PCIe
 PLL failure
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Trent Piepho <tpiepho@impinj.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Date:   Tue, 05 Feb 2019 10:48:02 +0100
In-Reply-To: <20190205001721.18639-4-tpiepho@impinj.com>
References: <20190205001721.18639-1-tpiepho@impinj.com>
         <20190205001721.18639-4-tpiepho@impinj.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Dienstag, den 05.02.2019, 00:17 +0000 schrieb Trent Piepho:
> This implements the workound described in the NXP IMX7d erratum e10728.
> 
> Initial VCO oscillation may fail under corner conditions such as cold
> temperature.  It causes PCIe PLL to fail to lock in the initialization
> phase, which results in the PCIe link failing to come up.
> 
> The workaround is to disable Duty-cycle Corrector (DCC) calibration
> after G_RST.
> 
> To do this it is necessary to gain access to the undocumented and
> currently unused PCIe PHY register bank.  A new device tree node of type
> "fsl,imx7d-pcie-phy" is created for the PHY block and the existing PCIe
> device uses a phandle named "fsl,imx7d-pcie-phy" to point to it.
> 
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 57 +++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 80f843030e36..06dd6aa927d4 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/of_gpio.h>
>  #include <linux/of_device.h>
> +#include <linux/of_address.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> @@ -61,6 +62,7 @@ struct imx6_pcie {
> > >  	u32			tx_swing_low;
> > >  	int			link_gen;
> > >  	struct regulator	*vpcie;
> > > +	void __iomem		*phy_base;
>  
> >  	/* power domain for pcie */
> > >  	struct device		*pd_pcie;
> @@ -117,6 +119,23 @@ struct imx6_pcie {
>  #define PCIE_PHY_RX_ASIC_OUT 0x100D
> >  #define PCIE_PHY_RX_ASIC_OUT_VALID	(1 << 0)
>  
> +/* iMX7 PCIe PHY registers */
> > +#define PCIE_PHY_CMN_REG4		0x14
> +/* These are probably the bits that *aren't* DCC_FB_EN */
> > +#define PCIE_PHY_CMN_REG4_DCC_FB_EN	0x29
> +
> > +#define PCIE_PHY_CMN_REG15	        0x54
> > +#define PCIE_PHY_CMN_REG15_DLY_4	BIT(2)
> > +#define PCIE_PHY_CMN_REG15_PLL_PD	BIT(5)
> > +#define PCIE_PHY_CMN_REG15_OVRD_PLL_PD	BIT(7)
> +
> > +#define PCIE_PHY_CMN_REG24		0x90
> > +#define PCIE_PHY_CMN_REG24_RX_EQ	BIT(6)
> > +#define PCIE_PHY_CMN_REG24_RX_EQ_SEL	BIT(3)
> +
> > +#define PCIE_PHY_CMN_REG26		0x98
> > +#define PCIE_PHY_CMN_REG26_ATT_MODE	0xBC
> +
>  #define PHY_RX_OVRD_IN_LO 0x1005
>  #define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
>  #define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
> @@ -490,6 +509,26 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
> >  	switch (imx6_pcie->variant) {
> >  	case IMX7D:
> >  		reset_control_deassert(imx6_pcie->pciephy_reset);
> +
> > +		/* Workaround for ERR010728, failure of PCI-e PLL VCO to
> > +		 * oscillate, especially when cold.  This turns off "Duty-cycle
> > +		 * Corrector" and other mysterious undocumented things.
> > +		 */
> > +		if (likely(imx6_pcie->phy_base)) {
> > +			/* De-assert DCC_FB_EN */
> > +			writel(PCIE_PHY_CMN_REG4_DCC_FB_EN,
> > +			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG4);
> > +			/* Assert RX_EQS and RX_EQS_SEL */
> > +			writel(PCIE_PHY_CMN_REG24_RX_EQ_SEL
> > +				| PCIE_PHY_CMN_REG24_RX_EQ,
> > +			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG24);
> > +			/* Assert ATT_MODE */
> > +			writel(PCIE_PHY_CMN_REG26_ATT_MODE,
> > +			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG26);
> > +		} else {
> > +			dev_warn(dev, "DT lacks imx7d-pcie-phy, unable to apply ERR010728 workaround\n");
> > +		}
> +
> >  		imx7d_pcie_wait_for_phy_pll_lock(imx6_pcie);
> >  		break;
> >  	case IMX6SX:
> @@ -919,6 +958,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  	struct device *dev = &pdev->dev;
> >  	struct dw_pcie *pci;
> >  	struct imx6_pcie *imx6_pcie;
> > +	struct device_node *np;
> >  	struct resource *dbi_base;
> >  	struct device_node *node = dev->of_node;
> >  	int ret;
> @@ -939,6 +979,23 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  	imx6_pcie->variant =
> >  		(enum imx6_pcie_variants)of_device_get_match_data(dev);
>  
> > +	/* Find the PHY if one is defined, only imx7d uses it */
> > +	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
> > +	if (np) {
> > +		struct resource res;
> +
> > +		ret = of_address_to_resource(np, 0, &res);
> > +		if (ret) {
> > +			dev_err(dev, "Unable to map PCIe PHY\n");
> > +			return ret;
> > +		}
> > +		imx6_pcie->phy_base = devm_ioremap_resource(dev, &res);
> > +		if (IS_ERR(imx6_pcie->phy_base)) {
> > +			dev_err(dev, "Unable to map PCIe PHY\n");
> > +			return PTR_ERR(imx6_pcie->phy_base);
> > +		}
> > +	}
> +
> >  	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
> >  	if (IS_ERR(pci->dbi_base))
