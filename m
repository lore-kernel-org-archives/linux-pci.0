Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFC9C282CC
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 14:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260A72177B
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 14:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C8ABvh6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfBHOOU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:14:20 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33588 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfBHOOU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Feb 2019 09:14:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id f24-v6so3156481ljk.0
        for <linux-pci@vger.kernel.org>; Fri, 08 Feb 2019 06:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+3yYWh2yzm0MsMqQ7oV264nJe7w3uw5W9igo6Bl8cqg=;
        b=C8ABvh6GRj5r0K84jlEybZtsv5f7MXjuRqeifX57tTZmwcJ9VqtBjcvjSDlHXsSs7/
         KvXpSTLa1d64dtDaRzC5VHQY58Qqc71ajAmQpkwA1ZN9iknraZn+ydIkgDXa+Nj5MwIx
         zR67Kdp8cms2ZcVzodnzYc8R/cWDV5AShCG4oTgB3Iy407WIAUzm4gmvcVImnX41eDVL
         Kj2AgQznMY7a/TggGeJyYEx1Pyu97AjV8H0YKOMAXemImD7G/K4VlGCOLiqcngUUpKlP
         GZoFLSF426u/eMvTh+Sa5Io0u3KBwUvxnq1JYf8kmaP6UZ+SdoMtv8F7LsrhbGY21vly
         ld3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+3yYWh2yzm0MsMqQ7oV264nJe7w3uw5W9igo6Bl8cqg=;
        b=Q0pUFQrT8ASerxRp+ezBKtjB3MYTxVjCUtTjIr3PWNseVoObON4Z30r1NxSW7I8Dg7
         18lwvWEN+c0LokJpeKK4zTZFeNg5ZxKlP2+zdmonWaevg+WFpNt4H5OWNtErSgXqDNMU
         /h5DQPYS//a75ECd7ZJlNy9UB2CNHZQC4PdDRxqN2BEQiJx3Huk+eOSamw+iiyPxnNV1
         R4V+bUP7VjEwZGOwIjx4bcyjdFPbX2mwYRfa0MsPFsPDWl1fQTjSlTZKIVbDsuyaDgn/
         32eumDt8laGzHdMH9n9KUSb1h1G6gVong+QxGc9bfbo19ZxRisZhlK5fjJC9gTV6IOM2
         aNog==
X-Gm-Message-State: AHQUAuZ9DBptHHSBzj7FA4u7KTh9yeCPf5GCZWxusB11bUcthGkQTmXv
        cRMLc2qey8fjHHBU9aOWZh3LvA==
X-Google-Smtp-Source: AHgI3IYPzzBOwvsVigq73ISMD7FXLNPXQkJzsIKQ8tAt2pJzkLHtw64FjPYqkuIVVKAvzW1aW74lwA==
X-Received: by 2002:a2e:9786:: with SMTP id y6-v6mr1988296lji.53.1549635256855;
        Fri, 08 Feb 2019 06:14:16 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id f16-v6sm397035lji.88.2019.02.08.06.14.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 08 Feb 2019 06:14:16 -0800 (PST)
Date:   Fri, 8 Feb 2019 15:14:13 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Brown <david.brown@linaro.org>,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/7] phy: qcom: Add Qualcomm PCIe2 PHY driver
Message-ID: <20190208141413.GB773@centauri.lan>
References: <20190125234509.26419-1-bjorn.andersson@linaro.org>
 <20190125234509.26419-4-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125234509.26419-4-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 25, 2019 at 03:45:05PM -0800, Bjorn Andersson wrote:
> The Qualcomm PCIe2 PHY is based on design from Synopsys and found in
> several different platforms where the QMP PHY isn't used.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/phy/qualcomm/Kconfig          |   8 +
>  drivers/phy/qualcomm/Makefile         |   1 +
>  drivers/phy/qualcomm/phy-qcom-pcie2.c | 331 ++++++++++++++++++++++++++
>  3 files changed, 340 insertions(+)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-pcie2.c
> 
> diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
> index 32f7d34eb784..0edb5316972f 100644
> --- a/drivers/phy/qualcomm/Kconfig
> +++ b/drivers/phy/qualcomm/Kconfig
> @@ -24,6 +24,14 @@ config PHY_QCOM_IPQ806X_SATA
>  	depends on OF
>  	select GENERIC_PHY
>  
> +config PHY_QCOM_PCIE2
> +	tristate "Qualcomm PCIe PHY Driver"

Perhaps "Qualcomm PCIe2 PHY Driver" or "Qualcomm PCIe Gen2 PHY Driver"
as that is more descriptive.

> +	depends on OF && COMMON_CLK && (ARCH_QCOM || COMPILE_TEST)
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the Qualcomm PCIe PHY, used with the Synopsys
> +	  based PCIe controller.
> +
>  config PHY_QCOM_QMP
>  	tristate "Qualcomm QMP PHY Driver"
>  	depends on OF && COMMON_CLK && (ARCH_QCOM || COMPILE_TEST)
> diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
> index c56efd3af205..283251d6a5d9 100644
> --- a/drivers/phy/qualcomm/Makefile
> +++ b/drivers/phy/qualcomm/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_PHY_ATH79_USB)		+= phy-ath79-usb.o
>  obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)	+= phy-qcom-apq8064-sata.o
>  obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)	+= phy-qcom-ipq806x-sata.o
> +obj-$(CONFIG_PHY_QCOM_PCIE2)		+= phy-qcom-pcie2.o
>  obj-$(CONFIG_PHY_QCOM_QMP)		+= phy-qcom-qmp.o
>  obj-$(CONFIG_PHY_QCOM_QUSB2)		+= phy-qcom-qusb2.o
>  obj-$(CONFIG_PHY_QCOM_UFS)		+= phy-qcom-ufs.o
> diff --git a/drivers/phy/qualcomm/phy-qcom-pcie2.c b/drivers/phy/qualcomm/phy-qcom-pcie2.c
> new file mode 100644
> index 000000000000..2fa891c18b6f
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-pcie2.c
> @@ -0,0 +1,331 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2014-2017, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2019, Linaro Ltd.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clk.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +
> +#include <dt-bindings/phy/phy.h>
> +
> +#define PCIE20_PARF_PHY_STTS         0x3c
> +#define PCIE2_PHY_RESET_CTRL         0x44
> +#define PCIE20_PARF_PHY_REFCLK_CTRL2 0xa0
> +#define PCIE20_PARF_PHY_REFCLK_CTRL3 0xa4
> +#define PCIE20_PARF_PCS_SWING_CTRL1  0x88
> +#define PCIE20_PARF_PCS_SWING_CTRL2  0x8c
> +#define PCIE20_PARF_PCS_DEEMPH1      0x74
> +#define PCIE20_PARF_PCS_DEEMPH2      0x78
> +#define PCIE20_PARF_PCS_DEEMPH3      0x7c
> +#define PCIE20_PARF_CONFIGBITS       0x84
> +#define PCIE20_PARF_PHY_CTRL3        0x94
> +#define PCIE20_PARF_PCS_CTRL         0x80
> +
> +#define TX_AMP_VAL                   120
> +#define PHY_RX0_EQ_GEN1_VAL          0
> +#define PHY_RX0_EQ_GEN2_VAL          4
> +#define TX_DEEMPH_GEN1_VAL           24
> +#define TX_DEEMPH_GEN2_3_5DB_VAL     26
> +#define TX_DEEMPH_GEN2_6DB_VAL       36
> +#define PHY_TX0_TERM_OFFST_VAL       0
> +
> +struct qcom_phy {
> +	struct device *dev;
> +	void __iomem *base;
> +
> +	struct regulator_bulk_data vregs[2];
> +
> +	struct reset_control *phy_reset;
> +	struct reset_control *pipe_reset;
> +	struct clk *pipe_clk;
> +};
> +
> +static int qcom_pcie2_phy_init(struct phy *phy)
> +{
> +	struct qcom_phy *qphy = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = reset_control_deassert(qphy->phy_reset);
> +	if (ret) {
> +		dev_err(qphy->dev, "cannot deassert pipe reset\n");
> +		return ret;
> +	}
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(qphy->vregs), qphy->vregs);
> +	if (ret)
> +		reset_control_assert(qphy->phy_reset);
> +
> +	return ret;
> +}
> +
> +static int qcom_pcie2_phy_power_on(struct phy *phy)
> +{
> +	struct qcom_phy *qphy = phy_get_drvdata(phy);
> +	int ret;
> +	u32 val;
> +
> +	/* Program REF_CLK source */
> +	val = readl(qphy->base + PCIE20_PARF_PHY_REFCLK_CTRL2);
> +	val &= ~BIT(1);
> +	writel(val, qphy->base + PCIE20_PARF_PHY_REFCLK_CTRL2);
> +
> +	usleep_range(1000, 2000);
> +
> +	/* Don't use PAD for refclock */
> +	val = readl(qphy->base + PCIE20_PARF_PHY_REFCLK_CTRL2);
> +	val &= ~BIT(0);
> +	writel(val, qphy->base + PCIE20_PARF_PHY_REFCLK_CTRL2);
> +
> +	/* Program SSP ENABLE */
> +	val = readl(qphy->base + PCIE20_PARF_PHY_REFCLK_CTRL3);
> +	val |= BIT(0);
> +	writel(val, qphy->base + PCIE20_PARF_PHY_REFCLK_CTRL3);
> +
> +	usleep_range(1000, 2000);
> +
> +	/* Assert Phy SW Reset */
> +	val = readl(qphy->base + PCIE2_PHY_RESET_CTRL);
> +	val |= BIT(0);
> +	writel(val, qphy->base + PCIE2_PHY_RESET_CTRL);
> +
> +	/* Program Tx Amplitude */
> +	val = readl(qphy->base + PCIE20_PARF_PCS_SWING_CTRL1);
> +	val &= ~0x7f;
> +	val |= TX_AMP_VAL;
> +	writel(val, qphy->base + PCIE20_PARF_PCS_SWING_CTRL1);
> +
> +	val = readl(qphy->base + PCIE20_PARF_PCS_SWING_CTRL2);
> +	val &= ~0x7f;
> +	val |= TX_AMP_VAL;
> +	writel(val, qphy->base + PCIE20_PARF_PCS_SWING_CTRL2);
> +
> +	/* Program De-Emphasis */
> +	val = readl(qphy->base + PCIE20_PARF_PCS_DEEMPH1);
> +	val &= ~0x3f;
> +	val |= TX_DEEMPH_GEN2_6DB_VAL;
> +	writel(val, qphy->base + PCIE20_PARF_PCS_DEEMPH1);
> +
> +	val = readl(qphy->base + PCIE20_PARF_PCS_DEEMPH2);
> +	val &= ~0x3f;
> +	val |= TX_DEEMPH_GEN2_3_5DB_VAL;
> +	writel(val, qphy->base + PCIE20_PARF_PCS_DEEMPH2);
> +
> +	val = readl(qphy->base + PCIE20_PARF_PCS_DEEMPH3);
> +	val &= ~0x3f;
> +	val |= TX_DEEMPH_GEN1_VAL;
> +	writel(val, qphy->base + PCIE20_PARF_PCS_DEEMPH3);
> +
> +	/* Program Rx_Eq */
> +	val = readl(qphy->base + PCIE20_PARF_CONFIGBITS);
> +	val &= ~0x7;
> +	val |= PHY_RX0_EQ_GEN2_VAL;
> +	writel(val, qphy->base + PCIE20_PARF_CONFIGBITS);
> +
> +	/* Program Tx0_term_offset */
> +	val = readl(qphy->base + PCIE20_PARF_PHY_CTRL3);
> +	val &= ~0x1f;
> +	val |= PHY_TX0_TERM_OFFST_VAL;
> +	writel(val, qphy->base + PCIE20_PARF_PHY_CTRL3);
> +
> +	/* disable Tx2Rx Loopback */
> +	val = readl(qphy->base + PCIE20_PARF_PCS_CTRL);
> +	val &= ~BIT(1);
> +	writel(val, qphy->base + PCIE20_PARF_PCS_CTRL);
> +
> +	/* De-assert Phy SW Reset */
> +	val = readl(qphy->base + PCIE2_PHY_RESET_CTRL);
> +	val &= ~BIT(0);
> +	writel(val, qphy->base + PCIE2_PHY_RESET_CTRL);
> +
> +	usleep_range(1000, 2000);
> +
> +	ret = reset_control_deassert(qphy->pipe_reset);
> +	if (ret) {
> +		dev_err(qphy->dev, "cannot deassert pipe reset\n");
> +		goto out;
> +	}
> +
> +	clk_set_rate(qphy->pipe_clk, 250000000);
> +
> +	ret = clk_prepare_enable(qphy->pipe_clk);
> +	if (ret) {
> +		dev_err(qphy->dev, "failed to enable pipe clock\n");
> +		goto out;
> +	}
> +
> +	ret = readl_poll_timeout(qphy->base + PCIE20_PARF_PHY_STTS, val,
> +				 !(val & BIT(0)), 1000, 10);
> +	if (ret)
> +		dev_err(qphy->dev, "phy initialization failed\n");
> +
> +out:
> +	return ret;
> +}
> +
> +static int qcom_pcie2_phy_power_off(struct phy *phy)
> +{
> +	struct qcom_phy *qphy = phy_get_drvdata(phy);
> +	u32 val;
> +
> +	val = readl(qphy->base + PCIE2_PHY_RESET_CTRL);
> +	val |= BIT(0);
> +	writel(val, qphy->base + PCIE2_PHY_RESET_CTRL);
> +
> +	clk_disable_unprepare(qphy->pipe_clk);
> +	reset_control_assert(qphy->pipe_reset);
> +
> +	return 0;
> +}
> +
> +static int qcom_pcie2_phy_exit(struct phy *phy)
> +{
> +	struct qcom_phy *qphy = phy_get_drvdata(phy);
> +
> +	regulator_bulk_disable(ARRAY_SIZE(qphy->vregs), qphy->vregs);
> +	reset_control_assert(qphy->phy_reset);
> +
> +	return 0;
> +}
<> +
> +static const struct phy_ops qcom_pcie2_ops = {
> +	.init = qcom_pcie2_phy_init,
> +	.power_on = qcom_pcie2_phy_power_on,
> +	.power_off = qcom_pcie2_phy_power_off,
> +	.exit = qcom_pcie2_phy_exit,
> +	.owner = THIS_MODULE,
> +};
> +
> +/*
> + * Register a fixed rate pipe clock.
> + *
> + * The <s>_pipe_clksrc generated by PHY goes to the GCC that gate
> + * controls it. The <s>_pipe_clk coming out of the GCC is requested
> + * by the PHY driver for its operations.
> + * We register the <s>_pipe_clksrc here. The gcc driver takes care
> + * of assigning this <s>_pipe_clksrc as parent to <s>_pipe_clk.
> + * Below picture shows this relationship.
> + *
> + *         +---------------+
> + *         |   PHY block   |<<---------------------------------------+
> + *         |               |                                         |
> + *         |   +-------+   |                   +-----+               |
> + *   I/P---^-->|  PLL  |---^--->pipe_clksrc--->| GCC |--->pipe_clk---+
> + *    clk  |   +-------+   |                   +-----+
> + *         +---------------+
> + */
> +static int phy_pipe_clk_register(struct qcom_phy *qphy)

Perhaps rename this function to

phy_pipe_clksrc_register()

since it is that clock that we register here.

With those two minor nits:
Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>

> +{
> +	struct device_node *np = qphy->dev->of_node;
> +	struct clk_fixed_rate *fixed;
> +	struct clk_init_data init = { };
> +	int ret;
> +
> +	ret = of_property_read_string(np, "clock-output-names", &init.name);
> +	if (ret) {
> +		dev_err(qphy->dev, "%s: No clock-output-names\n", np->name);
> +		return ret;
> +	}
> +
> +	fixed = devm_kzalloc(qphy->dev, sizeof(*fixed), GFP_KERNEL);
> +	if (!fixed)
> +		return -ENOMEM;
> +
> +	init.ops = &clk_fixed_rate_ops;
> +
> +	/* controllers using QMP phys use 250MHz pipe clock interface */
> +	fixed->fixed_rate = 250000000;
> +	fixed->hw.init = &init;
> +
> +	return devm_clk_hw_register(qphy->dev, &fixed->hw);
> +}
> +
> +static int qcom_pcie2_phy_probe(struct platform_device *pdev)
> +{
> +	struct phy_provider *phy_provider;
> +	struct qcom_phy *qphy;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	struct phy *phy;
> +	int ret;
> +
> +	qphy = devm_kzalloc(dev, sizeof(*qphy), GFP_KERNEL);
> +	if (!qphy)
> +		return -ENOMEM;
> +
> +	qphy->dev = dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	qphy->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(qphy->base))
> +		return PTR_ERR(qphy->base);
> +
> +	ret = phy_pipe_clk_register(qphy);
> +	if (ret) {
> +		dev_err(dev, "failed to register pipe_clk\n");
> +		return ret;
> +	}
> +
> +	qphy->vregs[0].supply = "vdda-vp";
> +	qphy->vregs[1].supply = "vdda-vph";
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(qphy->vregs), qphy->vregs);
> +	if (ret < 0)
> +		return ret;
> +
> +	qphy->pipe_clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(qphy->pipe_clk)) {
> +		dev_err(dev, "failed to acquire pipe clock\n");
> +		return PTR_ERR(qphy->pipe_clk);
> +	}
> +
> +	qphy->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
> +	if (IS_ERR(qphy->phy_reset)) {
> +		dev_err(dev, "failed to acquire phy reset\n");
> +		return PTR_ERR(qphy->phy_reset);
> +	}
> +
> +	qphy->pipe_reset = devm_reset_control_get_exclusive(dev, "pipe");
> +	if (IS_ERR(qphy->pipe_reset)) {
> +		dev_err(dev, "failed to acquire pipe reset\n");
> +		return PTR_ERR(qphy->pipe_reset);
> +	}
> +
> +	phy = devm_phy_create(dev, dev->of_node, &qcom_pcie2_ops);
> +	if (IS_ERR(phy)) {
> +		dev_err(dev, "failed to create phy\n");
> +		return PTR_ERR(phy);
> +	}
> +
> +	phy_set_drvdata(phy, qphy);
> +
> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (IS_ERR(phy_provider))
> +		dev_err(dev, "failed to register phy provider\n");
> +
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static const struct of_device_id qcom_pcie2_phy_match_table[] = {
> +	{ .compatible = "qcom,pcie2-phy" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, qcom_pcie2_phy_match_table);
> +
> +static struct platform_driver qcom_pcie2_phy_driver = {
> +	.probe = qcom_pcie2_phy_probe,
> +	.driver = {
> +		.name = "qcom-pcie2-phy",
> +		.of_match_table = qcom_pcie2_phy_match_table,
> +	},
> +};
> +
> +module_platform_driver(qcom_pcie2_phy_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm PCIe PHY driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.18.0
> 
