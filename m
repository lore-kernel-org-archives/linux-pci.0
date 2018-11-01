Return-Path: <SRS0=Nkm2=NM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB6AC6786F
	for <linux-pci@archiver.kernel.org>; Thu,  1 Nov 2018 10:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699DF205F4
	for <linux-pci@archiver.kernel.org>; Thu,  1 Nov 2018 10:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 699DF205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeKATFS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:05:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52935 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbeKATFS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Nov 2018 15:05:18 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gI9oW-00005O-KK; Thu, 01 Nov 2018 11:02:56 +0100
Message-ID: <1541066574.3593.1.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: imx: Add imx6sx suspend/resume support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 01 Nov 2018 11:02:54 +0100
In-Reply-To: <AM0PR04MB42907F7BFDBF9648381DED49EECD0@AM0PR04MB4290.eurprd04.prod.outlook.com>
References: <e57884e2dbc429918db81662ddbafe22c472385c.1539019758.git.leonard.crestez@nxp.com>
         <AM0PR04MB42907F7BFDBF9648381DED49EECD0@AM0PR04MB4290.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Leonard,

On Wed, 2018-10-31 at 11:02 +0000, Leonard Crestez wrote:
> On 10/8/2018 8:38 PM, Leonard Crestez wrote:
> > Enable PCI suspend/resume support on imx6sx socs. This is similar to
> > imx7d with a few differences:
> > 
> > * The PM_Turn_Off bit is exposed through an IOMUX GPR, like all other
> > pcie control bits on 6sx.
> > * The pcie_inbound_axi clk needs to be turned off in suspend. On resume
> > it is restored via resume -> deassert_core_reset -> enable_ref_clk.
> > 
> > Most of the resume logic is shared with the initial reset after probe.
> > 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> 
> This is a gentle reminder that this patch was posted ~3 weeks ago and 
> there is yet no reply. It's a mostly straight-forward extension of imx7d 
> pci suspend/resume support to a different SOC.
> 
> Lucas/Philipp: can you please take a brief look?

This is a bit out of my wheelhouse, but I'll try my best.

> > ---
> >   drivers/pci/controller/dwc/pci-imx6.c       | 40 ++++++++++++++++++---
> >   include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |  1 +
> >   2 files changed, 36 insertions(+), 5 deletions(-)
> > 
> > Patch is again linux-next, meant to apply here:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/log/?h=pci/dwc
> > 
> > This is quite an old patch, mostly did it to prove that imx7d suspend
> > support is indeed generic.
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 2cbef2d7c207..6171171db1fc 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -771,12 +771,29 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
> >   	}
> >   }
> >   
> >   static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
> >   {
> > -	reset_control_assert(imx6_pcie->turnoff_reset);
> > -	reset_control_deassert(imx6_pcie->turnoff_reset);
> > +	struct device *dev = imx6_pcie->pci->dev;
> > +
> > +	/*
> > +	 * Some variants have a turnoff reset in DT while
> > +	 * others poke at iomuxc registers.
> > +	 */
> > +	if (imx6_pcie->turnoff_reset) {
> > +		reset_control_assert(imx6_pcie->turnoff_reset);
> > +		reset_control_deassert(imx6_pcie->turnoff_reset);
> > +	} else if (imx6_pcie->variant == IMX6SX) {
> > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > +				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
> > +				IMX6SX_GPR12_PCIE_PM_TURN_OFF);
> > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > +				IMX6SX_GPR12_PCIE_PM_TURN_OFF, 0);
> > +	} else {
> > +		dev_err(dev, "PME_Turn_Off not implemented\n");
> > +		return;
> > +	}

I'd use switch(imx6_pcie->variant) for consistency with the other places
where different variants need to be handled separately.

> >   
> >   	/*
> >   	 * Components with an upstream port must respond to
> >   	 * PME_Turn_Off with PME_TO_Ack but we can't check.
> >   	 *
> > @@ -790,22 +807,35 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
> >   {
> >   	clk_disable_unprepare(imx6_pcie->pcie);
> >   	clk_disable_unprepare(imx6_pcie->pcie_phy);
> >   	clk_disable_unprepare(imx6_pcie->pcie_bus);
> >   
> > -	if (imx6_pcie->variant == IMX7D) {
> > +	switch (imx6_pcie->variant) {
> > +	case IMX6SX:
> > +		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> > +		break;
> > +	case IMX7D:
> >   		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> >   				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> >   				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> > +		break;
> > +	default:
> > +		break;
> >   	}

This disables the ref clock. Should this be split into a separate
function imx6_pcie_disable_ref_clk() for symmetry with the already
existing imx6_pcie_enable_ref_clk() ?

That could then also be used to disable pcie_inbound_axi in the error
path of imx6_pcie_deassert_core_reset().

> >   }
> >   
> > +static inline bool imx6_pcie_supports_suspend(struct imx6_pcie *imx6_pcie)
> > +{
> > +	return (imx6_pcie->variant == IMX7D ||
> > +		imx6_pcie->variant == IMX6SX);
> > +}
> > +
> >   static int imx6_pcie_suspend_noirq(struct device *dev)
> >   {
> >   	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> >   
> > -	if (imx6_pcie->variant != IMX7D)
> > +	if (!imx6_pcie_supports_suspend(imx6_pcie))
> >   		return 0;
> >   
> >   	imx6_pcie_pm_turnoff(imx6_pcie);
> >   	imx6_pcie_clk_disable(imx6_pcie);
> >   	imx6_pcie_ltssm_disable(dev);
> > @@ -817,11 +847,11 @@ static int imx6_pcie_resume_noirq(struct device *dev)
> >   {
> >   	int ret;
> >   	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> >   	struct pcie_port *pp = &imx6_pcie->pci->pp;
> >   
> > -	if (imx6_pcie->variant != IMX7D)
> > +	if (!imx6_pcie_supports_suspend(imx6_pcie))
> >   		return 0;
> >   
> >   	imx6_pcie_assert_core_reset(imx6_pcie);
> >   	imx6_pcie_init_phy(imx6_pcie);
> >   	imx6_pcie_deassert_core_reset(imx6_pcie);
> > diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> > index 6c1ad160ed87..c1b25f5e386d 100644
> > --- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> > +++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> > @@ -438,10 +438,11 @@
> >   #define IMX6SX_GPR5_DISP_MUX_DCIC1_LCDIF1		(0x0 << 1)
> >   #define IMX6SX_GPR5_DISP_MUX_DCIC1_LVDS			(0x1 << 1)
> >   #define IMX6SX_GPR5_DISP_MUX_DCIC1_MASK			(0x1 << 1)
> >   
> >   #define IMX6SX_GPR12_PCIE_TEST_POWERDOWN		BIT(30)
> > +#define IMX6SX_GPR12_PCIE_PM_TURN_OFF			BIT(16)
> >   #define IMX6SX_GPR12_PCIE_RX_EQ_MASK			(0x7 << 0)
> >   #define IMX6SX_GPR12_PCIE_RX_EQ_2			(0x2 << 0)
> >   
> >   /* For imx6ul iomux gpr register field define */
> >   #define IMX6UL_GPR1_ENET1_CLK_DIR		(0x1 << 17)
> > 

regards
Philipp
