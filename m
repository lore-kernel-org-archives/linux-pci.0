Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56584C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 15:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DE62077C
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 15:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfDLP4U (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:56:20 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44017 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfDLP4U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2019 11:56:20 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hEyXK-0001Kl-Vn; Fri, 12 Apr 2019 17:56:18 +0200
Message-ID: <1555084578.11529.32.camel@pengutronix.de>
Subject: Re: [PATCH v3 05/11] PCI: dwc: imx6: Share PHY debug register
 definitions
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
Date:   Fri, 12 Apr 2019 17:56:18 +0200
In-Reply-To: <20190401042547.14067-6-andrew.smirnov@gmail.com>
References: <20190401042547.14067-1-andrew.smirnov@gmail.com>
         <20190401042547.14067-6-andrew.smirnov@gmail.com>
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
> Both pcie-designware.c and pci-imx6.c contain custom definitions for
> PHY debug registers R0/R1 and on top of that there's already a
> definition for R0 in pcie-designware.h. Move all of the definitions to
> pcie-designware.h. No functional change intended.
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
>  drivers/pci/controller/dwc/pci-imx6.c        |  6 ++----
>  drivers/pci/controller/dwc/pcie-designware.c | 12 +++---------
>  drivers/pci/controller/dwc/pcie-designware.h |  3 +++
>  3 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 92c40c250a34..bb95a3273ca2 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -103,8 +103,6 @@ struct imx6_pcie {
>  
>  /* PCIe Port Logic registers (memory-mapped) */
>  #define PL_OFFSET 0x700
> -#define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
> -#define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
>  
>  #define PCIE_PHY_CTRL (PL_OFFSET + 0x114)
>  #define PCIE_PHY_CTRL_DATA_LOC 0
> @@ -839,8 +837,8 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
>  
>  err_reset_phy:
> >  	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
> > -		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R0),
> > -		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1));
> > +		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
> > +		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
> >  	imx6_pcie_reset_phy(imx6_pcie);
> >  	return ret;
>  }
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 31f6331ca46f..086e87a40316 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -14,12 +14,6 @@
>  
>  #include "pcie-designware.h"
>  
> -/* PCIe Port Logic registers */
> > -#define PLR_OFFSET			0x700
> > -#define PCIE_PHY_DEBUG_R1		(PLR_OFFSET + 0x2c)
> > -#define PCIE_PHY_DEBUG_R1_LINK_UP	(0x1 << 4)
> > -#define PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING	(0x1 << 29)
> -
>  int dw_pcie_read(void __iomem *addr, int size, u32 *val)
>  {
> >  	if (!IS_ALIGNED((uintptr_t)addr, size)) {
> @@ -334,9 +328,9 @@ int dw_pcie_link_up(struct dw_pcie *pci)
> >  	if (pci->ops->link_up)
> >  		return pci->ops->link_up(pci);
>  
> > -	val = readl(pci->dbi_base + PCIE_PHY_DEBUG_R1);
> > -	return ((val & PCIE_PHY_DEBUG_R1_LINK_UP) &&
> > -		(!(val & PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING)));
> > +	val = readl(pci->dbi_base + PCIE_PORT_DEBUG1);
> > +	return ((val & PCIE_PORT_DEBUG1_LINK_UP) &&
> > +		(!(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING)));
>  }
>  
>  void dw_pcie_setup(struct dw_pcie *pci)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 377f4c0b52da..662bb9082c76 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -41,6 +41,9 @@
> >  #define PCIE_PORT_DEBUG0		0x728
> >  #define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
> >  #define PORT_LOGIC_LTSSM_STATE_L0	0x11
> > +#define PCIE_PORT_DEBUG1		0x72C
> > +#define PCIE_PORT_DEBUG1_LINK_UP		(0x1 << 4)
> > +#define PCIE_PORT_DEBUG1_LINK_IN_TRAINING	(0x1 << 29)
>  
> >  #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
> >  #define PORT_LOGIC_SPEED_CHANGE		BIT(17)
