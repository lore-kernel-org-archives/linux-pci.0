Return-Path: <SRS0=cvZd=QJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDF2C282DA
	for <linux-pci@archiver.kernel.org>; Sat,  2 Feb 2019 00:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CF321872
	for <linux-pci@archiver.kernel.org>; Sat,  2 Feb 2019 00:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U23DCKQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfBBAPi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:15:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44078 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfBBAPh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Feb 2019 19:15:37 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so3672244pgr.11;
        Fri, 01 Feb 2019 16:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nSRUQnVI9WIETg7K/wATyf0nSEPKuobaySZ5tG4KrzQ=;
        b=U23DCKQ0ly4TuQ9pT7CE74m/k1GlfzX/bW2MG9LipuZzG2TzI4aOle8JtYbo52EwSc
         zN6A+S2+RnDK2eY85VrRDLrAc+4lbhnYQOZUy888dV+XPNj3WKZktcMKR0UQdSd61TI+
         L96uhArX//LsnSlj19wl9+p5g6lQN+c10R9MuBqVpF9GdwToLdDumSk9xxd/RO57tdke
         RsyXWbQSKGdRcL09jba3MMcql5vrm4TR0ThunAPdzDQs8n6+1mhILxNdqExc3b+mNiKd
         A/aRbqHJqLxfHmP3AvsvLcYspIzWNFoGY/6dMsOM7o98SoNMQdMJpAgLN8whAwY8+8wU
         XJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nSRUQnVI9WIETg7K/wATyf0nSEPKuobaySZ5tG4KrzQ=;
        b=kpx6J2xxmwKIkeRCgoNpiQkhoTOxJQPYWPd4zJKZSQsld/ujeiQ+jMIT++kta7ia+/
         jkW3JAwF2gp28WSvJnStg/QnWYc4IYipBnGoIZeqURmU44zHZJn66ls4Z7g8lQv+Eglp
         FigD0884FwxxBgo5W5BNiphQs8+jjBIX9rqcMtWp/G7EDb/MIE6fuMnKVpVF1rhltTOG
         9AdA6Uzu2GdHTE7I/OD846Eo92TIdIZNYWMg4AV/nkfUUbiIJk3UbwuSqmRS5KnbLHLI
         SxyaM81im6zdSCFq1UQMZqANalEPry5937yRDcfsPohGSOTU8Aazdad0RMqpsIf7F/g4
         L/Qw==
X-Gm-Message-State: AHQUAuYT8DHQ+btniARt1GOjzIbbKYxoJEfUUptF+sPfOtzKDubJb7iR
        K1zVAGLpOjo20Lkc6/9AaUM=
X-Google-Smtp-Source: AHgI3IayhMP0Hp5oBha9Xf8gbjLnQ0tWuPWUL7D9LWxbpKSLeGUD7rjJxNMyzkDW7v+Ba6NRm4vWIA==
X-Received: by 2002:a63:ee4c:: with SMTP id n12mr4282607pgk.21.1549066536384;
        Fri, 01 Feb 2019 16:15:36 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id w6sm28374545pga.72.2019.02.01.16.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 16:15:35 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v7 1/4] PCI: imx6: Introduce drvdata
Date:   Fri,  1 Feb 2019 16:15:20 -0800
Message-Id: <20190202001523.12517-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190202001523.12517-1-andrew.smirnov@gmail.com>
References: <20190202001523.12517-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce driver data struct. This will simplify handling of device
specific differences.

Signed-off-by: Stefan Agner <stefan@agner.ch>
[andrew.smirnov@gmail.com reformatted drvdata, to simplify future diffs]
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/dwc/pci-imx6.c | 56 ++++++++++++++++++---------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 52e47dac028f..1e940ba7e4c4 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -41,6 +41,10 @@ enum imx6_pcie_variants {
 	IMX7D,
 };
 
+struct imx6_pcie_drvdata {
+	enum imx6_pcie_variants variant;
+};
+
 struct imx6_pcie {
 	struct dw_pcie		*pci;
 	int			reset_gpio;
@@ -53,7 +57,6 @@ struct imx6_pcie {
 	struct reset_control	*pciephy_reset;
 	struct reset_control	*apps_reset;
 	struct reset_control	*turnoff_reset;
-	enum imx6_pcie_variants variant;
 	u32			tx_deemph_gen1;
 	u32			tx_deemph_gen2_3p5db;
 	u32			tx_deemph_gen2_6db;
@@ -66,6 +69,7 @@ struct imx6_pcie {
 	struct device		*pd_pcie;
 	/* power domain for pcie phy */
 	struct device		*pd_pcie_phy;
+	const struct imx6_pcie_drvdata *drvdata;
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
@@ -339,7 +343,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct device *dev = imx6_pcie->pci->dev;
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 		reset_control_assert(imx6_pcie->pciephy_reset);
 		reset_control_assert(imx6_pcie->apps_reset);
@@ -381,7 +385,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	struct device *dev = pci->dev;
 	int ret = 0;
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
 		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
 		if (ret) {
@@ -484,7 +488,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 					!imx6_pcie->gpio_active_high);
 	}
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 		imx7d_pcie_wait_for_phy_pll_lock(imx6_pcie);
@@ -522,7 +526,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
@@ -644,7 +648,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX6Q:
 	case IMX6SX:
 	case IMX6QP:
@@ -697,7 +701,7 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 		tmp |= PORT_LOGIC_SPEED_CHANGE;
 		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
 
-		if (imx6_pcie->variant != IMX7D) {
+		if (imx6_pcie->drvdata->variant != IMX7D) {
 			/*
 			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
 			 * from i.MX6 family when no link speed transition
@@ -794,7 +798,7 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
 	case IMX6QP:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
@@ -820,7 +824,7 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
 	}
 
 	/* Others poke directly at IOMUXC registers */
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
@@ -850,7 +854,7 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 	clk_disable_unprepare(imx6_pcie->pcie_phy);
 	clk_disable_unprepare(imx6_pcie->pcie_bus);
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
 		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
 		break;
@@ -866,8 +870,8 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 
 static inline bool imx6_pcie_supports_suspend(struct imx6_pcie *imx6_pcie)
 {
-	return (imx6_pcie->variant == IMX7D ||
-		imx6_pcie->variant == IMX6SX);
+	return (imx6_pcie->drvdata->variant == IMX7D ||
+		imx6_pcie->drvdata->variant == IMX6SX);
 }
 
 static int imx6_pcie_suspend_noirq(struct device *dev)
@@ -933,8 +937,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	pci->ops = &dw_pcie_ops;
 
 	imx6_pcie->pci = pci;
-	imx6_pcie->variant =
-		(enum imx6_pcie_variants)of_device_get_match_data(dev);
+	imx6_pcie->drvdata = of_device_get_match_data(dev);
 
 	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
@@ -978,7 +981,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(imx6_pcie->pcie);
 	}
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
 		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
 							   "pcie_inbound_axi");
@@ -1084,11 +1087,26 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 	imx6_pcie_assert_core_reset(imx6_pcie);
 }
 
+static const struct imx6_pcie_drvdata drvdata[] = {
+	[IMX6Q] = {
+		.variant = IMX6Q,
+	},
+	[IMX6SX] = {
+		.variant = IMX6SX,
+	},
+	[IMX6QP] = {
+		.variant = IMX6QP,
+	},
+	[IMX7D] = {
+		.variant = IMX7D,
+	},
+};
+
 static const struct of_device_id imx6_pcie_of_match[] = {
-	{ .compatible = "fsl,imx6q-pcie",  .data = (void *)IMX6Q,  },
-	{ .compatible = "fsl,imx6sx-pcie", .data = (void *)IMX6SX, },
-	{ .compatible = "fsl,imx6qp-pcie", .data = (void *)IMX6QP, },
-	{ .compatible = "fsl,imx7d-pcie",  .data = (void *)IMX7D,  },
+	{ .compatible = "fsl,imx6q-pcie",  .data = &drvdata[IMX6Q],  },
+	{ .compatible = "fsl,imx6sx-pcie", .data = &drvdata[IMX6SX], },
+	{ .compatible = "fsl,imx6qp-pcie", .data = &drvdata[IMX6QP], },
+	{ .compatible = "fsl,imx7d-pcie",  .data = &drvdata[IMX7D],  },
 	{},
 };
 
-- 
2.20.1

