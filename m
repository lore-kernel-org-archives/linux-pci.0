Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8587BC10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 16:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C9C20850
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 16:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfDLQMz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:12:55 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36115 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfDLQMz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2019 12:12:55 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hEynN-0003Rp-Iu; Fri, 12 Apr 2019 18:12:53 +0200
Message-ID: <1555085573.11529.36.camel@pengutronix.de>
Subject: Re: [PATCH v3 08/11] PCI: imx6: Simplify pcie_phy_poll_ack()
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
Date:   Fri, 12 Apr 2019 18:12:53 +0200
In-Reply-To: <20190401042547.14067-9-andrew.smirnov@gmail.com>
References: <20190401042547.14067-1-andrew.smirnov@gmail.com>
         <20190401042547.14067-9-andrew.smirnov@gmail.com>
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
> Simplify pcie_phy_poll_ack() by incorporating shifting into constant
> definition and convert the code to use 'bool'. No functional change
> intended.
> 
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
>  drivers/pci/controller/dwc/pci-imx6.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index a49e5e491e12..7c3ffb751002 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -112,7 +112,7 @@ struct imx6_pcie {
> >  #define PCIE_PHY_CTRL_RD		BIT(19)
>  
>  #define PCIE_PHY_STAT (PL_OFFSET + 0x110)
> -#define PCIE_PHY_STAT_ACK_LOC 16
> > +#define PCIE_PHY_STAT_ACK		BIT(16)
>  
> >  #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
>  
> @@ -151,16 +151,16 @@ struct imx6_pcie {
> >  #define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
> >  #define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
>  
> -static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int exp_val)
> +static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)

This looks like only going half the way to me. The parameter type is
changed to bool, but the callers still use 0 and 1 directly. If we use
bool here the callers should be changed to true/false.

>  {
>  	struct dw_pcie *pci = imx6_pcie->pci;
> -	u32 val;
> +	bool val;
>  	u32 max_iterations = 10;
>  	u32 wait_counter = 0;
>  
>  	do {
> -		val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
> -		val = (val >> PCIE_PHY_STAT_ACK_LOC) & 0x1;
> +		val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT) &
> +			PCIE_PHY_STAT_ACK;

I think this needs to be
val = !!(dw_pcie_readl_dbi(pci, PCIE_PHY_STAT) & PCIE_PHY_STAT_ACK);
as the ACK bit isn't shifted down into bit position 0 anymore.

>  		wait_counter++;
>  
> >  		if (val == exp_val)
