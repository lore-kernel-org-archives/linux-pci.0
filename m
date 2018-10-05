Return-Path: <SRS0=s+SA=MR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C586C00449
	for <linux-pci@archiver.kernel.org>; Fri,  5 Oct 2018 10:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456952084D
	for <linux-pci@archiver.kernel.org>; Fri,  5 Oct 2018 10:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456952084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbeJER0e (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Oct 2018 13:26:34 -0400
Received: from foss.arm.com ([217.140.101.70]:49580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbeJER0d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Oct 2018 13:26:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8E4480D;
        Fri,  5 Oct 2018 03:28:23 -0700 (PDT)
Received: from red-moon (red-moon.emea.arm.com [10.4.13.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 474C33F5A0;
        Fri,  5 Oct 2018 03:28:21 -0700 (PDT)
Date:   Fri, 5 Oct 2018 11:29:06 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] PCI: imx: Add PME_Turn_Off support
Message-ID: <20181005102906.GA25651@red-moon>
References: <cover.1538670431.git.leonard.crestez@nxp.com>
 <37d60fe2119361381a6a81f439fa1c3ad29db45e.1538670431.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37d60fe2119361381a6a81f439fa1c3ad29db45e.1538670431.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 04, 2018 at 04:34:30PM +0000, Leonard Crestez wrote:
> When the root complex suspends it must send a PME_Turn_Off TLP.
> Implement this by asserting the "turnoff" reset.
> 
> On imx7d this functionality is part of the SRC and exposed through the
> linux reset-controller subsystem. On imx6 equivalent bits are in the
> IOMUXC GPR area which the imx6-pcie driver accesses directly.

Nit: I am merging the series, please define what SRC and GPR are so
that I can update the commit log accordingly, it must be clear to
anyone reading it.

Thanks,
Lorenzo

> This is only for imx7d right now but it's deliberately implemented as an
> optional reset, ignoring the chip variant:
> * Older dtbs won't have this reset so it will be ignored.
> * Future chips might also expose this as a reset controller.
> 
> For example imx8m (not yet supported) has the exact same
> PCIE_CTRL_APPS_TURNOFF bit in the same location.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 6ba16fd1373c..2bf80f1ad852 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -50,10 +50,11 @@ struct imx6_pcie {
>  	struct clk		*pcie_inbound_axi;
>  	struct clk		*pcie;
>  	struct regmap		*iomuxc_gpr;
>  	struct reset_control	*pciephy_reset;
>  	struct reset_control	*apps_reset;
> +	struct reset_control	*turnoff_reset;
>  	enum imx6_pcie_variants variant;
>  	u32			tx_deemph_gen1;
>  	u32			tx_deemph_gen2_3p5db;
>  	u32			tx_deemph_gen2_6db;
>  	u32			tx_swing_full;
> @@ -812,10 +813,25 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
>  	default:
>  		dev_err(dev, "ltssm_disable not supported\n");
>  	}
>  }
>  
> +static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
> +{
> +	reset_control_assert(imx6_pcie->turnoff_reset);
> +	reset_control_deassert(imx6_pcie->turnoff_reset);
> +
> +	/*
> +	 * Components with an upstream port must respond to
> +	 * PME_Turn_Off with PME_TO_Ack but we can't check.
> +	 *
> +	 * The standard recommends a 1-10ms timeout after which to
> +	 * proceed anyway as if acks were received.
> +	 */
> +	usleep_range(1000, 10000);
> +}
> +
>  static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
>  {
>  	clk_disable_unprepare(imx6_pcie->pcie);
>  	clk_disable_unprepare(imx6_pcie->pcie_phy);
>  	clk_disable_unprepare(imx6_pcie->pcie_bus);
> @@ -832,10 +848,11 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
>  	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
>  
>  	if (imx6_pcie->variant != IMX7D)
>  		return 0;
>  
> +	imx6_pcie_pm_turnoff(imx6_pcie);
>  	imx6_pcie_clk_disable(imx6_pcie);
>  	imx6_pcie_ltssm_disable(dev);
>  
>  	return 0;
>  }
> @@ -959,10 +976,17 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		break;
>  	default:
>  		break;
>  	}
>  
> +	/* Grab turnoff reset */
> +	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
> +	if (IS_ERR(imx6_pcie->turnoff_reset)) {
> +		dev_err(dev, "Failed to get TURNOFF reset control\n");
> +		return PTR_ERR(imx6_pcie->turnoff_reset);
> +	}
> +
>  	/* Grab GPR config register range */
>  	imx6_pcie->iomuxc_gpr =
>  		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
>  	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
>  		dev_err(dev, "unable to find iomuxc registers\n");
> -- 
> 2.17.1
> 
