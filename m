Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479EBC10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 15:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D1D20693
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 15:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfDLPxj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:53:39 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46353 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfDLPxi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2019 11:53:38 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hEyUj-0000q7-CN; Fri, 12 Apr 2019 17:53:37 +0200
Message-ID: <1555084415.11529.29.camel@pengutronix.de>
Subject: Re: [PATCH v3 02/11] PCI: imx6: Remove redundant debug tracing
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 12 Apr 2019 17:53:35 +0200
In-Reply-To: <20190401042547.14067-3-andrew.smirnov@gmail.com>
References: <20190401042547.14067-1-andrew.smirnov@gmail.com>
         <20190401042547.14067-3-andrew.smirnov@gmail.com>
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
> All calls to imx6_pcie_wait_for_link() share the same error path and
> the state of PHY debug registers will already be printed there.

With this change we can drop imx6_pcie_wait_for_link altogether, as
it's now just wrapper around dw_pcie_wait_for_link that pulls out the
dw_pcie struct from imx6_pcie. Both callers have dw_pcie already
available, so there is no point in keeping this function.

Regards,
Lucas

> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index fb0b29e5b1f0..7582d0b2fbe7 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -726,16 +726,9 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
>  static int imx6_pcie_wait_for_link(struct imx6_pcie *imx6_pcie)
>  {
> >  	struct dw_pcie *pci = imx6_pcie->pci;
> > -	struct device *dev = pci->dev;
>  
> >  	/* check if the link is up or not */
> > -	if (!dw_pcie_wait_for_link(pci))
> > -		return 0;
> -
> > -	dev_dbg(dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
> > -		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R0),
> > -		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1));
> > -	return -ETIMEDOUT;
> > +	return dw_pcie_wait_for_link(pci);
>  }
>  
>  static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
