Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75C0C18DF5
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 14:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7AC206B2
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 14:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7AC206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbeKUBF4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:05:56 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44153 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeKUBF4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Nov 2018 20:05:56 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gP78a-0008Jm-46; Tue, 20 Nov 2018 15:36:24 +0100
Message-ID: <1542724583.2508.15.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/3] PCI: imx6: introduce drvdata
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Stefan Agner <stefan@agner.ch>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, tpiepho@impinj.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 20 Nov 2018 15:36:23 +0100
In-Reply-To: <20181120132705.6917-2-stefan@agner.ch>
References: <20181120132705.6917-1-stefan@agner.ch>
         <20181120132705.6917-2-stefan@agner.ch>
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

Am Dienstag, den 20.11.2018, 14:27 +0100 schrieb Stefan Agner:
> Introduce driver data struct. This will simplify handling of device
> specific differences.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> Changes in v2:
> - Split drvdata introduction in a separate patch
> - Use an array instead of individual struct imx6_pcie_drvdata declarations
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 38 +++++++++++++++++----------
>  1 file changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 4a9a673b4777..7ac1a639fe91 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -39,6 +39,10 @@ enum imx6_pcie_variants {
> >  	IMX7D,
>  };
>  
> +struct imx6_pcie_drvdata {
> > +	enum imx6_pcie_variants variant;
> +};
> +
>  struct imx6_pcie {
> > >  	struct dw_pcie		*pci;
> > >  	int			reset_gpio;
> @@ -50,7 +54,6 @@ struct imx6_pcie {
> > >  	struct regmap		*iomuxc_gpr;
> > >  	struct reset_control	*pciephy_reset;
> > >  	struct reset_control	*apps_reset;
> > -	enum imx6_pcie_variants variant;
> > >  	u32			tx_deemph_gen1;
> > >  	u32			tx_deemph_gen2_3p5db;
> > >  	u32			tx_deemph_gen2_6db;
> @@ -58,6 +61,7 @@ struct imx6_pcie {
> > >  	u32			tx_swing_low;
> > >  	int			link_gen;
> > >  	struct regulator	*vpcie;
> > +	const struct imx6_pcie_drvdata *drvdata;
>  };
>  
>  /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
> @@ -285,7 +289,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  {
> >  	struct device *dev = imx6_pcie->pci->dev;
>  
> > -	switch (imx6_pcie->variant) {
> > +	switch (imx6_pcie->drvdata->variant) {
> >  	case IMX7D:
> >  		reset_control_assert(imx6_pcie->pciephy_reset);
> >  		reset_control_assert(imx6_pcie->apps_reset);
> @@ -327,7 +331,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
> >  	struct device *dev = pci->dev;
> >  	int ret = 0;
>  
> > -	switch (imx6_pcie->variant) {
> > +	switch (imx6_pcie->drvdata->variant) {
> >  	case IMX6SX:
> >  		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
> >  		if (ret) {
> @@ -430,7 +434,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
> >  					!imx6_pcie->gpio_active_high);
> >  	}
>  
> > -	switch (imx6_pcie->variant) {
> > +	switch (imx6_pcie->drvdata->variant) {
> >  	case IMX7D:
> >  		reset_control_deassert(imx6_pcie->pciephy_reset);
> >  		imx7d_pcie_wait_for_phy_pll_lock(imx6_pcie);
> @@ -468,7 +472,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  
>  static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
>  {
> > -	switch (imx6_pcie->variant) {
> > +	switch (imx6_pcie->drvdata->variant) {
> >  	case IMX7D:
> >  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> >  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
> @@ -560,7 +564,7 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
> >  	dw_pcie_writel_dbi(pci, PCIE_RC_LCR, tmp);
>  
> >  	/* Start LTSSM. */
> > -	if (imx6_pcie->variant == IMX7D)
> > +	if (imx6_pcie->drvdata->variant == IMX7D)
> >  		reset_control_deassert(imx6_pcie->apps_reset);
> >  	else
> >  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> @@ -585,7 +589,7 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
> >  		tmp |= PORT_LOGIC_SPEED_CHANGE;
> >  		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
>  
> > -		if (imx6_pcie->variant != IMX7D) {
> > +		if (imx6_pcie->drvdata->variant != IMX7D) {
> >  			/*
> >  			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
> >  			 * from i.MX6 family when no link speed transition
> @@ -703,8 +707,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  	pci->ops = &dw_pcie_ops;
>  
> >  	imx6_pcie->pci = pci;
> > -	imx6_pcie->variant =
> > -		(enum imx6_pcie_variants)of_device_get_match_data(dev);
> > +	imx6_pcie->drvdata = of_device_get_match_data(dev);
>  
> >  	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
> @@ -748,7 +751,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  		return PTR_ERR(imx6_pcie->pcie);
> >  	}
>  
> > -	switch (imx6_pcie->variant) {
> > +	switch (imx6_pcie->drvdata->variant) {
> >  	case IMX6SX:
> >  		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
> >  							   "pcie_inbound_axi");
> @@ -835,11 +838,18 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
> >  	imx6_pcie_assert_core_reset(imx6_pcie);
>  }
>  
> +static const struct imx6_pcie_drvdata drvdata[] = {
> > +	[IMX6Q] = { .variant = IMX6Q },
> > +	[IMX6SX] = { .variant = IMX6SX },
> > +	[IMX6QP] = { .variant = IMX6QP },
> > +	[IMX7D] = { .variant = IMX7D },
> +};
> +
>  static const struct of_device_id imx6_pcie_of_match[] = {
> > -	{ .compatible = "fsl,imx6q-pcie",  .data = (void *)IMX6Q,  },
> > -	{ .compatible = "fsl,imx6sx-pcie", .data = (void *)IMX6SX, },
> > -	{ .compatible = "fsl,imx6qp-pcie", .data = (void *)IMX6QP, },
> > -	{ .compatible = "fsl,imx7d-pcie",  .data = (void *)IMX7D,  },
> > +	{ .compatible = "fsl,imx6q-pcie",  .data = &drvdata[IMX6Q],  },
> > +	{ .compatible = "fsl,imx6sx-pcie", .data = &drvdata[IMX6SX], },
> > +	{ .compatible = "fsl,imx6qp-pcie", .data = &drvdata[IMX6QP], },
> > +	{ .compatible = "fsl,imx7d-pcie",  .data = &drvdata[IMX7D],  },
> >  	{},
>  };
>  
