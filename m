Return-Path: <SRS0=P0ok=QT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BCDC282CA
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 09:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C70D2186A
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 09:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfBLJgP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:36:15 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41945 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfBLJgO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2019 04:36:14 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gtUU3-0001IR-Ng; Tue, 12 Feb 2019 10:36:07 +0100
Message-ID: <1549964166.2546.21.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] PCI: imx6: Add code to request/control "pcie_aux"
 clock for i.MX8MQ
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org
Date:   Tue, 12 Feb 2019 10:36:06 +0100
In-Reply-To: <20190212015108.16952-3-andrew.smirnov@gmail.com>
References: <20190212015108.16952-1-andrew.smirnov@gmail.com>
         <20190212015108.16952-3-andrew.smirnov@gmail.com>
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

Am Montag, den 11.02.2019, 17:51 -0800 schrieb Andrey Smirnov:
> PCIe IP block has additional clock, "pcie_aux", that needs to be
> controlled by the driver. Add code to support that.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 7cdf8f9ab244..1a7031782846 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -65,6 +65,7 @@ struct imx6_pcie {
>  	struct clk		*pcie_phy;
>  	struct clk		*pcie_inbound_axi;
>  	struct clk		*pcie;
> +	struct clk		*pcie_aux;
>  	struct regmap		*iomuxc_gpr;
>  	u32			controller_id;
>  	struct reset_control	*pciephy_reset;
> @@ -421,6 +422,12 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  	case IMX7D:
>  		break;
>  	case IMX8MQ:
> +		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
> +		if (ret) {
> +			dev_err(dev, "unable to enable pcie_aux clock\n");
> +			break;
> +		}
> +
>  		offset = imx6_pcie_grp_offset(imx6_pcie);
>  		/*
>  		 * Set the over ride low and enabled
> @@ -904,6 +911,9 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
>  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
>  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
>  		break;
> +	case IMX8MQ:
> +		clk_disable_unprepare(imx6_pcie->pcie_aux);
> +		break;
>  	default:
>  		break;
>  	}
> @@ -1049,6 +1059,12 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  			dev_err(dev, "Failed to get PCIE APPS reset control\n");
>  			return PTR_ERR(imx6_pcie->apps_reset);
>  		}
> +
> +		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
> +		if (IS_ERR(imx6_pcie->pcie_aux)) {
> +			dev_err(dev, "pcie_aux clock source missing or invalid\n");
> +			return PTR_ERR(imx6_pcie->pcie_aux);
> +		}
>  		break;
>  	default:
>  		break;
