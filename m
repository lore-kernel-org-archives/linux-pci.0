Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DD9C46463
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 16:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3F42087E
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 16:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="WfDF4nlg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3F42087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbeKUD0k (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:26:40 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:50596 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeKUD0k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Nov 2018 22:26:40 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id F33F05C0172;
        Tue, 20 Nov 2018 17:56:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1542732990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=izxxjrW3sg+VZOPgXxJDhft8yeDtXZ3e3KUIwflbTp8=;
        b=WfDF4nlgk4Ufo9/e7Yoijp+BFtRH566+xg/Q8yoQ/XxVCA+zs3DEp4w/yJCCHoE9f8pD2t
        +2trbsnm/IVbioYep2Jj7dzARVr0WXK0G/lUgCPq3sa5h8hOiCkuiXtlI9uQOMxZvMElTQ
        oH7BRNjGoQVF5aYEKIA8a+FbhHbEQRA=
From:   Stefan Agner <stefan@agner.ch>
To:     lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, l.stach@pengutronix.de,
        tpiepho@impinj.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH v3 1/2] PCI: imx6: introduce drvdata
Date:   Tue, 20 Nov 2018 17:56:25 +0100
Message-Id: <20181120165626.26424-1-stefan@agner.ch>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce driver data struct. This will simplify handling of device
specific differences.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
Changes in v2:
- Split drvdata introduction in a separate patch
- Use an array instead of individual struct imx6_pcie_drvdata declarations
Changes in v3:
- Rebase on pci/dwc

 drivers/pci/controller/dwc/pci-imx6.c | 46 ++++++++++++++++-----------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 69f86234f7c0..cdcf54ff30fb 100644
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
@@ -53,7 +57,7 @@ struct imx6_pcie {
 	struct reset_control	*pciephy_reset;
 	struct reset_control	*apps_reset;
 	struct reset_control	*turnoff_reset;
-	enum imx6_pcie_variants variant;
+	const struct imx6_pcie_drvdata *drvdata;
 	u32			tx_deemph_gen1;
 	u32			tx_deemph_gen2_3p5db;
 	u32			tx_deemph_gen2_6db;
@@ -340,7 +344,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct device *dev = imx6_pcie->pci->dev;
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 		reset_control_assert(imx6_pcie->pciephy_reset);
 		reset_control_assert(imx6_pcie->apps_reset);
@@ -382,7 +386,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	struct device *dev = pci->dev;
 	int ret = 0;
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
 		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
 		if (ret) {
@@ -485,7 +489,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 					!imx6_pcie->gpio_active_high);
 	}
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 		imx7d_pcie_wait_for_phy_pll_lock(imx6_pcie);
@@ -523,7 +527,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
@@ -645,7 +649,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX6Q:
 	case IMX6SX:
 	case IMX6QP:
@@ -698,7 +702,7 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 		tmp |= PORT_LOGIC_SPEED_CHANGE;
 		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
 
-		if (imx6_pcie->variant != IMX7D) {
+		if (imx6_pcie->drvdata->variant != IMX7D) {
 			/*
 			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
 			 * from i.MX6 family when no link speed transition
@@ -801,7 +805,7 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
 	case IMX6QP:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
@@ -836,7 +840,7 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 	clk_disable_unprepare(imx6_pcie->pcie_phy);
 	clk_disable_unprepare(imx6_pcie->pcie_bus);
 
-	if (imx6_pcie->variant == IMX7D) {
+	if (imx6_pcie->drvdata->variant == IMX7D) {
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
@@ -847,7 +851,7 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
 
-	if (imx6_pcie->variant != IMX7D)
+	if (imx6_pcie->drvdata->variant != IMX7D)
 		return 0;
 
 	imx6_pcie_pm_turnoff(imx6_pcie);
@@ -863,7 +867,7 @@ static int imx6_pcie_resume_noirq(struct device *dev)
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
 	struct pcie_port *pp = &imx6_pcie->pci->pp;
 
-	if (imx6_pcie->variant != IMX7D)
+	if (imx6_pcie->drvdata->variant != IMX7D)
 		return 0;
 
 	imx6_pcie_assert_core_reset(imx6_pcie);
@@ -905,8 +909,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	pci->ops = &dw_pcie_ops;
 
 	imx6_pcie->pci = pci;
-	imx6_pcie->variant =
-		(enum imx6_pcie_variants)of_device_get_match_data(dev);
+	imx6_pcie->drvdata = of_device_get_match_data(dev);
 
 	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
@@ -950,7 +953,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(imx6_pcie->pcie);
 	}
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
 		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
 							   "pcie_inbound_axi");
@@ -1048,11 +1051,18 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 	imx6_pcie_assert_core_reset(imx6_pcie);
 }
 
+static const struct imx6_pcie_drvdata drvdata[] = {
+	[IMX6Q] = { .variant = IMX6Q },
+	[IMX6SX] = { .variant = IMX6SX },
+	[IMX6QP] = { .variant = IMX6QP },
+	[IMX7D] = { .variant = IMX7D },
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
2.19.1

