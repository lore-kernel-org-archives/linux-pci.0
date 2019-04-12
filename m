Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E98C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 16:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA95A20850
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 16:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfDLQRO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:17:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57265 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfDLQRN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2019 12:17:13 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hEyrY-00043D-05; Fri, 12 Apr 2019 18:17:12 +0200
Message-ID: <1555085831.11529.38.camel@pengutronix.de>
Subject: Re: [PATCH v3 10/11] PCI: imx6: Use flags to indicate support for
 suspend
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-pci@vger.kernel.org
Date:   Fri, 12 Apr 2019 18:17:11 +0200
In-Reply-To: <20190401042547.14067-11-andrew.smirnov@gmail.com>
References: <20190401042547.14067-1-andrew.smirnov@gmail.com>
         <20190401042547.14067-11-andrew.smirnov@gmail.com>
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

Am Sonntag, den 31.03.2019, 21:25 -0700 schrieb Andrey Smirnov:
> Now that driver data has flags variable that can be used to indicate
> quirks/features supported we can switch the code to use it instead of
> having a special function that does so based on variant alone. No
> functional change intended.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 9c658ef55aa4..c9431a8a7ca1 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -52,6 +52,7 @@ enum imx6_pcie_variants {
>  
> >  #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
> >  #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
> > +#define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
>  
>  struct imx6_pcie_drvdata {
> >  	enum imx6_pcie_variants variant;
> @@ -973,17 +974,11 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
> >  	}
>  }
>  
> -static inline bool imx6_pcie_supports_suspend(struct imx6_pcie *imx6_pcie)
> -{
> > -	return (imx6_pcie->drvdata->variant == IMX7D ||
> > -		imx6_pcie->drvdata->variant == IMX6SX);
> -}
> -
>  static int imx6_pcie_suspend_noirq(struct device *dev)
>  {
> >  	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
>  
> > -	if (!imx6_pcie_supports_suspend(imx6_pcie))
> > +	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_SUPPORTS_SUSPEND))
> >  		return 0;
>  
> >  	imx6_pcie_pm_turnoff(imx6_pcie);
> @@ -999,7 +994,7 @@ static int imx6_pcie_resume_noirq(struct device *dev)
> >  	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> >  	struct pcie_port *pp = &imx6_pcie->pci->pp;
>  
> > -	if (!imx6_pcie_supports_suspend(imx6_pcie))
> > +	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_SUPPORTS_SUSPEND))
> >  		return 0;
>  
> >  	imx6_pcie_assert_core_reset(imx6_pcie);
> @@ -1229,7 +1224,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  	[IMX6SX] = {
> >  		.variant = IMX6SX,
> >  		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
> > -			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
> > +			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
> > +			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> >  	},
> >  	[IMX6QP] = {
> >  		.variant = IMX6QP,
> @@ -1238,6 +1234,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  	},
> >  	[IMX7D] = {
> >  		.variant = IMX7D,
> > +		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> >  	},
> >  	[IMX8MQ] = {
> >  		.variant = IMX8MQ,
