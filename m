Return-Path: <SRS0=UeAH=N3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C74C43441
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 12:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFBE2087A
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 12:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFBE2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeKPWh5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:37:57 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50668 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbeKPWh5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Nov 2018 17:37:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 622B980D;
        Fri, 16 Nov 2018 04:25:47 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91D313F718;
        Fri, 16 Nov 2018 04:25:44 -0800 (PST)
Date:   Fri, 16 Nov 2018 12:25:41 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] PCI: imx: Add multi-pd support
Message-ID: <20181116122541.GD3228@e107981-ln.cambridge.arm.com>
References: <cover.1539020938.git.leonard.crestez@nxp.com>
 <ee0c4ecb4b6bd26f548096e7be90a07d181d50ee.1539020938.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee0c4ecb4b6bd26f548096e7be90a07d181d50ee.1539020938.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 08, 2018 at 06:06:21PM +0000, Leonard Crestez wrote:
> On some chips the PCIE and PCIE_PHY blocks are in separate power domains
> which can be power-gated independently. The pci driver needs to handle
> this by keeping both domain active.
> 
> This is intended for imx6sx where PCIE is in DISPLAY and PCIE_PHY in
> it's own domain. Defining the DISPLAY domain requires a way for pcie to
> keep it active or it will break when displays are off.
> 
> The power-domains on imx6sx are meant to look like this:
> 	power-domains = <&pd_disp>, <&pd_pci>;
> 	power-domain-names = "pcie", "pcie_phy";
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 48 +++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

I expect Shawn to pick the whole series up and therefore I am dropping
this series from the PCI tree.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 6171171db1fc..a482f86b02e6 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -25,10 +25,12 @@
>  #include <linux/resource.h>
>  #include <linux/signal.h>
>  #include <linux/types.h>
>  #include <linux/interrupt.h>
>  #include <linux/reset.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
>  
>  #include "pcie-designware.h"
>  
>  #define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
>  
> @@ -57,10 +59,15 @@ struct imx6_pcie {
>  	u32			tx_deemph_gen2_6db;
>  	u32			tx_swing_full;
>  	u32			tx_swing_low;
>  	int			link_gen;
>  	struct regulator	*vpcie;
> +
> +	/* power domain for pcie */
> +	struct device		*pd_pcie;
> +	/* power domain for pcie phy */
> +	struct device		*pd_pcie_phy;
>  };
>  
>  /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
>  #define PHY_PLL_LOCK_WAIT_MAX_RETRIES	2000
>  #define PHY_PLL_LOCK_WAIT_USLEEP_MIN	50
> @@ -290,10 +297,47 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
>  	}
>  
>  	return 1;
>  }
>  
> +static int imx6_pcie_attach_pd(struct device *dev)
> +{
> +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> +	struct device_link *link;
> +
> +	/* Do nothing when in a single power domain */
> +	if (dev->pm_domain)
> +		return 0;
> +
> +	imx6_pcie->pd_pcie = dev_pm_domain_attach_by_name(dev, "pcie");
> +	if (IS_ERR(imx6_pcie->pd_pcie))
> +		return PTR_ERR(imx6_pcie->pd_pcie);
> +	link = device_link_add(dev, imx6_pcie->pd_pcie,
> +			DL_FLAG_STATELESS |
> +			DL_FLAG_PM_RUNTIME |
> +			DL_FLAG_RPM_ACTIVE);
> +	if (IS_ERR(link)) {
> +		dev_err(dev, "Failed to add device_link to pcie pd: %ld\n", PTR_ERR(link));
> +		return PTR_ERR(link);
> +	}
> +
> +	imx6_pcie->pd_pcie_phy = dev_pm_domain_attach_by_name(dev, "pcie_phy");
> +	if (IS_ERR(imx6_pcie->pd_pcie_phy))
> +		return PTR_ERR(imx6_pcie->pd_pcie_phy);
> +
> +	device_link_add(dev, imx6_pcie->pd_pcie_phy,
> +			DL_FLAG_STATELESS |
> +			DL_FLAG_PM_RUNTIME |
> +			DL_FLAG_RPM_ACTIVE);
> +	if (IS_ERR(link)) {
> +		dev_err(dev, "Failed to add device_link to pcie_phy pd: %ld\n", PTR_ERR(link));
> +		return PTR_ERR(link);
> +	}
> +
> +	return 0;
> +}
> +
>  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  {
>  	struct device *dev = imx6_pcie->pci->dev;
>  
>  	switch (imx6_pcie->variant) {
> @@ -1013,10 +1057,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		imx6_pcie->vpcie = NULL;
>  	}
>  
>  	platform_set_drvdata(pdev, imx6_pcie);
>  
> +	ret = imx6_pcie_attach_pd(dev);
> +	if (ret)
> +		return ret;
> +
>  	ret = imx6_add_pcie_port(imx6_pcie, pdev);
>  	if (ret < 0)
>  		return ret;
>  
>  	return 0;
> -- 
> 2.17.1
> 
