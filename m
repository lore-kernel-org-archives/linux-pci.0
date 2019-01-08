Return-Path: <SRS0=3dpc=PQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF99C43387
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 08:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481522070B
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 08:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfAHIVr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:21:47 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34779 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfAHIVr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jan 2019 03:21:47 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1ggmdn-0003rq-Kv; Tue, 08 Jan 2019 09:21:39 +0100
Message-ID: <1546935698.3580.21.camel@pengutronix.de>
Subject: Re: [PATCH v4 3/4] PCI: imx6: Convert DIRECT_SPEED_CHANGE quirk
 code to use a flag
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Date:   Tue, 08 Jan 2019 09:21:38 +0100
In-Reply-To: <20190104165335.13205-4-andrew.smirnov@gmail.com>
References: <20190104165335.13205-1-andrew.smirnov@gmail.com>
         <20190104165335.13205-4-andrew.smirnov@gmail.com>
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

Am Freitag, den 04.01.2019, 08:53 -0800 schrieb Andrey Smirnov:
> Both i.MX7D and i.MX8MQ have the same behaviour when it comes to
> clearing DIRECT_SPEED_CHANGE bit when no speed change occur. To
> account for that change the code handling that to use a generic flag
> instead of checking IP block variant.
> 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index c55d93c1187d..75ee0cd7af3b 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -42,6 +42,7 @@ enum imx6_pcie_variants {
>  };
>  
> >  #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
> > +#define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
>  
>  struct imx6_pcie_drvdata {
> >  	enum imx6_pcie_variants variant;
> @@ -711,7 +712,8 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
> >  		tmp |= PORT_LOGIC_SPEED_CHANGE;
> >  		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
>  
> > -		if (imx6_pcie->drvdata->variant != IMX7D) {
> > +		if (imx6_pcie->drvdata->flags &
> > +		    IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE) {
> >  			/*
> >  			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
> >  			 * from i.MX6 family when no link speed transition
> @@ -1097,15 +1099,18 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
>  static const struct imx6_pcie_drvdata drvdata[] = {
> >  	[IMX6Q] = {
> >  		.variant = IMX6Q,
> > -		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
> > +		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
> > +			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
> >  	},
> >  	[IMX6SX] = {
> >  		.variant = IMX6SX,
> > -		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
> > +		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
> > +			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
> >  	},
> >  	[IMX6QP] = {
> >  		.variant = IMX6QP,
> > -		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
> > +		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
> > +			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
> >  	},
> >  	[IMX7D] = {
> >  		.variant = IMX7D,
