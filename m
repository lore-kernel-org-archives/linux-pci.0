Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3E4C43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 11:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322CA20672
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 11:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322CA20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390867AbeKVWR7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:17:59 -0500
Received: from foss.arm.com ([217.140.101.70]:46264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732166AbeKVWR7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Nov 2018 17:17:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E64AF361A;
        Thu, 22 Nov 2018 03:38:58 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 448B43F5A0;
        Thu, 22 Nov 2018 03:38:56 -0800 (PST)
Date:   Thu, 22 Nov 2018 11:38:53 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2] PCI: imx: Add imx6sx suspend/resume support
Message-ID: <20181122113853.GB11952@e107981-ln.cambridge.arm.com>
References: <984fcef6d928632241a4a3bce41e2645a304d335.1541598751.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <984fcef6d928632241a4a3bce41e2645a304d335.1541598751.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 07, 2018 at 01:57:03PM +0000, Leonard Crestez wrote:
> Enable PCI suspend/resume support on imx6sx socs. This is similar to
> imx7d with a few differences:
> 
> * The PM_Turn_Off bit is exposed through an IOMUX GPR, like all other
> pcie control bits on 6sx.
> * The pcie_inbound_axi clk needs to be turned off in suspend. On resume
> it is restored via resume -> deassert_core_reset -> enable_ref_clk.
> 
> Most of the resume logic is shared with the initial reset after probe.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> 
> ---
> Changes since v1:
> * Use a switch statement in imx6_pcie_pm_turnoff. The DT-based turnoff
> path is still an if statement.
> * Did not split imx6_pcie_clk_disable or call it from other paths, this
> would bring complications and is somewhat unrelated.
> * See v1 comments: https://lore.kernel.org/patchwork/patch/996806/
> 
>  drivers/pci/controller/dwc/pci-imx6.c       | 44 ++++++++++++++++++---
>  include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |  1 +
>  2 files changed, 40 insertions(+), 5 deletions(-)

I request Richard/Lucas ACK in order to merge this patch.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 2cbef2d7c207..54625569d0bc 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -771,41 +771,75 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
>  	}
>  }
>  
>  static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
>  {
> -	reset_control_assert(imx6_pcie->turnoff_reset);
> -	reset_control_deassert(imx6_pcie->turnoff_reset);
> +	struct device *dev = imx6_pcie->pci->dev;
> +
> +	/* Some variants have a turnoff reset in DT */
> +	if (imx6_pcie->turnoff_reset) {
> +		reset_control_assert(imx6_pcie->turnoff_reset);
> +		reset_control_deassert(imx6_pcie->turnoff_reset);
> +		goto pm_turnoff_sleep;
> +	}
> +
> +	/* Others poke directly at IOMUXC registers */
> +	switch (imx6_pcie->variant) {
> +	case IMX6SX:
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
> +				IMX6SX_GPR12_PCIE_PM_TURN_OFF);
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				IMX6SX_GPR12_PCIE_PM_TURN_OFF, 0);
> +		break;
> +	default:
> +		dev_err(dev, "PME_Turn_Off not implemented\n");
> +		return;
> +	}
>  
>  	/*
>  	 * Components with an upstream port must respond to
>  	 * PME_Turn_Off with PME_TO_Ack but we can't check.
>  	 *
>  	 * The standard recommends a 1-10ms timeout after which to
>  	 * proceed anyway as if acks were received.
>  	 */
> +pm_turnoff_sleep:
>  	usleep_range(1000, 10000);
>  }
>  
>  static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
>  {
>  	clk_disable_unprepare(imx6_pcie->pcie);
>  	clk_disable_unprepare(imx6_pcie->pcie_phy);
>  	clk_disable_unprepare(imx6_pcie->pcie_bus);
>  
> -	if (imx6_pcie->variant == IMX7D) {
> +	switch (imx6_pcie->variant) {
> +	case IMX6SX:
> +		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> +		break;
> +	case IMX7D:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
>  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> +		break;
> +	default:
> +		break;
>  	}
>  }
>  
> +static inline bool imx6_pcie_supports_suspend(struct imx6_pcie *imx6_pcie)
> +{
> +	return (imx6_pcie->variant == IMX7D ||
> +		imx6_pcie->variant == IMX6SX);
> +}
> +
>  static int imx6_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
>  
> -	if (imx6_pcie->variant != IMX7D)
> +	if (!imx6_pcie_supports_suspend(imx6_pcie))
>  		return 0;
>  
>  	imx6_pcie_pm_turnoff(imx6_pcie);
>  	imx6_pcie_clk_disable(imx6_pcie);
>  	imx6_pcie_ltssm_disable(dev);
> @@ -817,11 +851,11 @@ static int imx6_pcie_resume_noirq(struct device *dev)
>  {
>  	int ret;
>  	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
>  	struct pcie_port *pp = &imx6_pcie->pci->pp;
>  
> -	if (imx6_pcie->variant != IMX7D)
> +	if (!imx6_pcie_supports_suspend(imx6_pcie))
>  		return 0;
>  
>  	imx6_pcie_assert_core_reset(imx6_pcie);
>  	imx6_pcie_init_phy(imx6_pcie);
>  	imx6_pcie_deassert_core_reset(imx6_pcie);
> diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> index 6c1ad160ed87..c1b25f5e386d 100644
> --- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> +++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> @@ -438,10 +438,11 @@
>  #define IMX6SX_GPR5_DISP_MUX_DCIC1_LCDIF1		(0x0 << 1)
>  #define IMX6SX_GPR5_DISP_MUX_DCIC1_LVDS			(0x1 << 1)
>  #define IMX6SX_GPR5_DISP_MUX_DCIC1_MASK			(0x1 << 1)
>  
>  #define IMX6SX_GPR12_PCIE_TEST_POWERDOWN		BIT(30)
> +#define IMX6SX_GPR12_PCIE_PM_TURN_OFF			BIT(16)
>  #define IMX6SX_GPR12_PCIE_RX_EQ_MASK			(0x7 << 0)
>  #define IMX6SX_GPR12_PCIE_RX_EQ_2			(0x2 << 0)
>  
>  /* For imx6ul iomux gpr register field define */
>  #define IMX6UL_GPR1_ENET1_CLK_DIR		(0x1 << 17)
> -- 
> 2.17.1
> 
