Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F8FC10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 16:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A2620850
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 16:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfDLQP1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:15:27 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34051 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfDLQP0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2019 12:15:26 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hEypp-0003kY-6L; Fri, 12 Apr 2019 18:15:25 +0200
Message-ID: <1555085724.11529.37.camel@pengutronix.de>
Subject: Re: [PATCH v3 09/11] PCI: imx6: Restrict PHY register data to 16-bit
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
Date:   Fri, 12 Apr 2019 18:15:24 +0200
In-Reply-To: <20190401042547.14067-10-andrew.smirnov@gmail.com>
References: <20190401042547.14067-1-andrew.smirnov@gmail.com>
         <20190401042547.14067-10-andrew.smirnov@gmail.com>
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
> PHY registers on i.MX6 are 16-bit wide, so we can get rid of explicit
> masking if we restrict pcie_phy_read/pcie_phy_write to use 'u16'
> instead of 'int'. No functional change intended.
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
>  drivers/pci/controller/dwc/pci-imx6.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 7c3ffb751002..9c658ef55aa4 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -195,10 +195,10 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
>  }
>  
>  /* Read from the 16-bit PCIe PHY control registers (not memory-mapped) */
> -static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
> +static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, u16 *data)
>  {
> >  	struct dw_pcie *pci = imx6_pcie->pci;
> > -	u32 val, phy_ctl;
> > +	u32 phy_ctl;
> >  	int ret;
>  
> >  	ret = pcie_phy_wait_ack(imx6_pcie, addr);
> @@ -213,8 +213,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
> >  	if (ret)
> >  		return ret;
>  
> > -	val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
> > -	*data = val & 0xffff;
> > +	*data = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
>  
> >  	/* deassert Read signal */
> >  	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, 0x00);
> @@ -222,7 +221,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
> >  	return pcie_phy_poll_ack(imx6_pcie, 0);
>  }
>  
> -static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
> +static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
>  {
> >  	struct dw_pcie *pci = imx6_pcie->pci;
> >  	u32 var;
> @@ -279,7 +278,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
>  
>  static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
>  {
> > -	u32 tmp;
> > +	u16 tmp;
>  
> >  	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
> >  		return;
> @@ -675,7 +674,7 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
>  {
> >  	unsigned long phy_rate = clk_get_rate(imx6_pcie->pcie_phy);
> >  	int mult, div;
> > -	u32 val;
> > +	u16 val;
>  
> >  	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
> >  		return 0;
