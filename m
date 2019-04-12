Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53B8C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 15:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6BF20869
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 15:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfDLP7H (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:59:07 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49931 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfDLP7H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2019 11:59:07 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hEya1-0001Vw-I8; Fri, 12 Apr 2019 17:59:05 +0200
Message-ID: <1555084745.11529.34.camel@pengutronix.de>
Subject: Re: [PATCH v3 07/11] PCI: imx6: Simplify bit operations in PHY
 functions
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
Date:   Fri, 12 Apr 2019 17:59:05 +0200
In-Reply-To: <20190401042547.14067-8-andrew.smirnov@gmail.com>
References: <20190401042547.14067-1-andrew.smirnov@gmail.com>
         <20190401042547.14067-8-andrew.smirnov@gmail.com>
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
> Simplify the code by incorporating left shifts into constant
> defnitions as well as using FIELD_PREP/GENMASK. No functional change
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
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 28 +++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index b1f30b94fb30..a49e5e491e12 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -105,11 +105,11 @@ struct imx6_pcie {
>  #define PL_OFFSET 0x700
>  
>  #define PCIE_PHY_CTRL (PL_OFFSET + 0x114)
> -#define PCIE_PHY_CTRL_DATA_LOC 0
> -#define PCIE_PHY_CTRL_CAP_ADR_LOC 16
> -#define PCIE_PHY_CTRL_CAP_DAT_LOC 17
> -#define PCIE_PHY_CTRL_WR_LOC 18
> -#define PCIE_PHY_CTRL_RD_LOC 19
> > +#define PCIE_PHY_CTRL_DATA(x)		FIELD_PREP(GENMASK(15, 0), (x))
> > +#define PCIE_PHY_CTRL_CAP_ADR		BIT(16)
> > +#define PCIE_PHY_CTRL_CAP_DAT		BIT(17)
> > +#define PCIE_PHY_CTRL_WR		BIT(18)
> > +#define PCIE_PHY_CTRL_RD		BIT(19)
>  
>  #define PCIE_PHY_STAT (PL_OFFSET + 0x110)
>  #define PCIE_PHY_STAT_ACK_LOC 16
> @@ -178,17 +178,17 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
> >  	u32 val;
> >  	int ret;
>  
> > -	val = addr << PCIE_PHY_CTRL_DATA_LOC;
> > +	val = PCIE_PHY_CTRL_DATA(addr);
> >  	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
>  
> > -	val |= (0x1 << PCIE_PHY_CTRL_CAP_ADR_LOC);
> > +	val |= PCIE_PHY_CTRL_CAP_ADR;
> >  	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
>  
> >  	ret = pcie_phy_poll_ack(imx6_pcie, 1);
> >  	if (ret)
> >  		return ret;
>  
> > -	val = addr << PCIE_PHY_CTRL_DATA_LOC;
> > +	val = PCIE_PHY_CTRL_DATA(addr);
> >  	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
>  
> >  	return pcie_phy_poll_ack(imx6_pcie, 0);
> @@ -206,7 +206,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
> >  		return ret;
>  
> >  	/* assert Read signal */
> > -	phy_ctl = 0x1 << PCIE_PHY_CTRL_RD_LOC;
> > +	phy_ctl = PCIE_PHY_CTRL_RD;
> >  	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, phy_ctl);
>  
> >  	ret = pcie_phy_poll_ack(imx6_pcie, 1);
> @@ -234,11 +234,11 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
> >  	if (ret)
> >  		return ret;
>  
> > -	var = data << PCIE_PHY_CTRL_DATA_LOC;
> > +	var = PCIE_PHY_CTRL_DATA(data);
> >  	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
>  
> >  	/* capture data */
> > -	var |= (0x1 << PCIE_PHY_CTRL_CAP_DAT_LOC);
> > +	var |= PCIE_PHY_CTRL_CAP_DAT;
> >  	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
>  
> >  	ret = pcie_phy_poll_ack(imx6_pcie, 1);
> @@ -246,7 +246,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
> >  		return ret;
>  
> >  	/* deassert cap data */
> > -	var = data << PCIE_PHY_CTRL_DATA_LOC;
> > +	var = PCIE_PHY_CTRL_DATA(data);
> >  	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
>  
> >  	/* wait for ack de-assertion */
> @@ -255,7 +255,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
> >  		return ret;
>  
> >  	/* assert wr signal */
> > -	var = 0x1 << PCIE_PHY_CTRL_WR_LOC;
> > +	var = PCIE_PHY_CTRL_WR;
> >  	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
>  
> >  	/* wait for ack */
> @@ -264,7 +264,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
> >  		return ret;
>  
> >  	/* deassert wr signal */
> > -	var = data << PCIE_PHY_CTRL_DATA_LOC;
> > +	var = PCIE_PHY_CTRL_DATA(data);
> >  	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
>  
> >  	/* wait for ack de-assertion */
