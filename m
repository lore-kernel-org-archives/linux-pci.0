Return-Path: <SRS0=kgUF=MQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3889DC64EB8
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 09:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B822098A
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 09:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B822098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeJDPwZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:52:25 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58417 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbeJDPwZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Oct 2018 11:52:25 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1g7zUH-0000su-Bp; Thu, 04 Oct 2018 11:00:01 +0200
Message-ID: <1538643596.3515.5.camel@pengutronix.de>
Subject: Re: [PATCH 4/4] PCI: imx: Add PME_Turn_Off support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 04 Oct 2018 10:59:56 +0200
In-Reply-To: <1cf53d188657bba7df06ad417eb2a65160238196.1538423063.git.leonard.crestez@nxp.com>
References: <cover.1538423063.git.leonard.crestez@nxp.com>
         <1cf53d188657bba7df06ad417eb2a65160238196.1538423063.git.leonard.crestez@nxp.com>
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

Am Montag, den 01.10.2018, 22:53 +0300 schrieb Leonard Crestez:
> When the root complex suspends it must send a PME_Turn_Off TLP.
> Implement this by asserting the "turnoff" reset.
> 
> On imx7d this is functionality is part of the SRC and exposed through
> the linux reset-controller subsystem. On imx6 equivalent bits are in the
> IOMUXC GPR area which the imx6-pcie driver accesses directly.
> 
> This is only for imx7d right now but it's deliberately implemented as an
> optional reset, ignoring the chip variant:
> * Older dtbs won't have this reset so it will be ignored.
> * Future chips might also expose this as a reset controller.
> 
> For example imx8m (not yet supported) has the exact same
> PCIE_CTRL_APPS_TURNOFF bit in the same location.
> 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 6ba16fd1373c..13cb1a200442 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -50,10 +50,11 @@ struct imx6_pcie {
> > >  	struct clk		*pcie_inbound_axi;
> > >  	struct clk		*pcie;
> > >  	struct regmap		*iomuxc_gpr;
> > >  	struct reset_control	*pciephy_reset;
> > >  	struct reset_control	*apps_reset;
> > > +	struct reset_control	*turnoff_reset;
> >  	enum imx6_pcie_variants variant;
> > >  	u32			tx_deemph_gen1;
> > >  	u32			tx_deemph_gen2_3p5db;
> > >  	u32			tx_deemph_gen2_6db;
> > >  	u32			tx_swing_full;
> @@ -812,10 +813,16 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
> >  	default:
> >  		dev_err(dev, "ltssm_disable not supported\n");
> >  	}
>  }
>  
> +static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
> +{
> > +	reset_control_assert(imx6_pcie->turnoff_reset);
> +	reset_control_deassert(imx6_pcie->turnoff_reset);

I'm a bit surprised to see no timing requirements here. I would have
expected that there is a minimum time from asserting the reset, so the
turnoff message gets transmitted to the EP before the clocks are
stopped.

Regards,
Lucas

> +}
> +
>  static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
>  {
> >  	clk_disable_unprepare(imx6_pcie->pcie);
> >  	clk_disable_unprepare(imx6_pcie->pcie_phy);
> >  	clk_disable_unprepare(imx6_pcie->pcie_bus);
> @@ -832,10 +839,11 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
> >  	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
>  
> >  	if (imx6_pcie->variant != IMX7D)
> >  		return 0;
>  
> > +	imx6_pcie_pm_turnoff(imx6_pcie);
> >  	imx6_pcie_clk_disable(imx6_pcie);
> >  	imx6_pcie_ltssm_disable(dev);
>  
> >  	return 0;
>  }
> @@ -959,10 +967,17 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  		break;
> >  	default:
> >  		break;
> >  	}
>  
> > +	/* Grab turnoff reset */
> > +	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
> > +	if (IS_ERR(imx6_pcie->turnoff_reset)) {
> > +		dev_err(dev, "Failed to get TURNOFF reset control\n");
> > +		return PTR_ERR(imx6_pcie->turnoff_reset);
> > +	}
> +
> >  	/* Grab GPR config register range */
> >  	imx6_pcie->iomuxc_gpr =
> >  		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> >  	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
> >  		dev_err(dev, "unable to find iomuxc registers\n");
