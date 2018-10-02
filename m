Return-Path: <SRS0=XHdA=MO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DF3C43143
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 13:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553C6206B2
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 13:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553C6206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732571AbeJBUc5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:32:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38288 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731269AbeJBUcv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Oct 2018 16:32:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E46DA18A;
        Tue,  2 Oct 2018 06:49:23 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.Emea.Arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73B623F5A0;
        Tue,  2 Oct 2018 06:49:21 -0700 (PDT)
Date:   Tue, 2 Oct 2018 14:49:18 +0100
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
        Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI: imx: Add PME_Turn_Off support
Message-ID: <20181002134918.GC27736@e107981-ln.cambridge.arm.com>
References: <cover.1538423063.git.leonard.crestez@nxp.com>
 <1cf53d188657bba7df06ad417eb2a65160238196.1538423063.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cf53d188657bba7df06ad417eb2a65160238196.1538423063.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 01, 2018 at 10:53:48PM +0300, Leonard Crestez wrote:
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
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

I need an ACK from Lucas on this patch to merge this series; also, if
you can keep versioning your patch series please it would be easier for
me to track them, I understand the patches content changed over time but
that's for future postings too.

Thanks,
Lorenzo

> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 6ba16fd1373c..13cb1a200442 100644
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
> @@ -812,10 +813,16 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
>  	default:
>  		dev_err(dev, "ltssm_disable not supported\n");
>  	}
>  }
>  
> +static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
> +{
> +	reset_control_assert(imx6_pcie->turnoff_reset);
> +	reset_control_deassert(imx6_pcie->turnoff_reset);
> +}
> +
>  static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
>  {
>  	clk_disable_unprepare(imx6_pcie->pcie);
>  	clk_disable_unprepare(imx6_pcie->pcie_phy);
>  	clk_disable_unprepare(imx6_pcie->pcie_bus);
> @@ -832,10 +839,11 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
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
> @@ -959,10 +967,17 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
