Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7C5C282D8
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 16:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50E22086C
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 16:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfBAQ76 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:59:58 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35440 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfBAQ76 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Feb 2019 11:59:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3331B15BE;
        Fri,  1 Feb 2019 08:59:58 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFCEF3F71E;
        Fri,  1 Feb 2019 08:59:55 -0800 (PST)
Date:   Fri, 1 Feb 2019 16:59:50 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Trent Piepho <tpiepho@impinj.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 2/4] PCI: imx6: Mark PHY functions as i.MX6 specific
Message-ID: <20190201165950.GA22887@e107981-ln.cambridge.arm.com>
References: <20190124201522.8973-1-andrew.smirnov@gmail.com>
 <20190124201522.8973-3-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124201522.8973-3-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 24, 2019 at 12:15:20PM -0800, Andrey Smirnov wrote:
> PCIE PHY IP block on i.MX7D differs from the one used on i.MX6 family,
> so none of the code in current implementation of imx6_setup_phy_mpll()
> is applicable.

So :) ? Add a conclusive statement to the commit log.

Lorenzo

> Tested-by: Trent Piepho <tpiepho@impinj.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
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
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index efff3d5e9162..c55d93c1187d 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -41,8 +41,11 @@ enum imx6_pcie_variants {
>  	IMX7D,
>  };
>  
> +#define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
> +
>  struct imx6_pcie_drvdata {
>  	enum imx6_pcie_variants variant;
> +	u32 flags;
>  };
>  
>  struct imx6_pcie {
> @@ -256,6 +259,9 @@ static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
>  {
>  	u32 tmp;
>  
> +	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
> +		return;
> +
>  	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
>  	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
>  		PHY_RX_OVRD_IN_LO_RX_PLL_EN);
> @@ -573,6 +579,9 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
>  	int mult, div;
>  	u32 val;
>  
> +	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
> +		return 0;
> +
>  	switch (phy_rate) {
>  	case 125000000:
>  		/*
> @@ -1088,12 +1097,15 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
>  static const struct imx6_pcie_drvdata drvdata[] = {
>  	[IMX6Q] = {
>  		.variant = IMX6Q,
> +		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
>  	},
>  	[IMX6SX] = {
>  		.variant = IMX6SX,
> +		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
>  	},
>  	[IMX6QP] = {
>  		.variant = IMX6QP,
> +		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
>  	},
>  	[IMX7D] = {
>  		.variant = IMX7D,
> -- 
> 2.20.1
> 
