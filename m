Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49181C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 15:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224B42077C
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 15:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfDLP4z (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:56:55 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58607 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfDLP4z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2019 11:56:55 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hEyXt-0001OB-C5; Fri, 12 Apr 2019 17:56:53 +0200
Message-ID: <1555084613.11529.33.camel@pengutronix.de>
Subject: Re: [PATCH v3 06/11] PCI: imx6: Make use of BIT() in constant
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
Date:   Fri, 12 Apr 2019 17:56:53 +0200
In-Reply-To: <20190401042547.14067-7-andrew.smirnov@gmail.com>
References: <20190401042547.14067-1-andrew.smirnov@gmail.com>
         <20190401042547.14067-7-andrew.smirnov@gmail.com>
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
> Avoid using explicit left shifts and convert various definitions to
> use BIT() instead. No functional change intended.
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
>  drivers/pci/controller/dwc/pci-imx6.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index bb95a3273ca2..b1f30b94fb30 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -118,14 +118,14 @@ struct imx6_pcie {
>  
>  /* PHY registers (not memory-mapped) */
> >  #define PCIE_PHY_ATEOVRD			0x10
> > -#define  PCIE_PHY_ATEOVRD_EN			(0x1 << 2)
> > +#define  PCIE_PHY_ATEOVRD_EN			BIT(2)
> >  #define  PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT	0
> >  #define  PCIE_PHY_ATEOVRD_REF_CLKDIV_MASK	0x1
>  
> >  #define PCIE_PHY_MPLL_OVRD_IN_LO		0x11
> >  #define  PCIE_PHY_MPLL_MULTIPLIER_SHIFT		2
> >  #define  PCIE_PHY_MPLL_MULTIPLIER_MASK		0x7f
> > -#define  PCIE_PHY_MPLL_MULTIPLIER_OVRD		(0x1 << 9)
> > +#define  PCIE_PHY_MPLL_MULTIPLIER_OVRD		BIT(9)
>  
>  #define PCIE_PHY_RX_ASIC_OUT 0x100D
> >  #define PCIE_PHY_RX_ASIC_OUT_VALID	(1 << 0)
> @@ -148,8 +148,8 @@ struct imx6_pcie {
> >  #define PCIE_PHY_CMN_REG26_ATT_MODE	0xBC
>  
>  #define PHY_RX_OVRD_IN_LO 0x1005
> -#define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
> -#define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
> > +#define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
> > +#define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
>  
>  static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int exp_val)
>  {
