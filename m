Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168EDC43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 09:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18CA20871
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 09:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="tCSYtkCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18CA20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbeKSUFG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:05:06 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:55762 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbeKSUFB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Nov 2018 15:05:01 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 33CC15C25F9;
        Mon, 19 Nov 2018 10:41:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1542620513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i4TpWC2DMbaL/fOfU3naqFlMzwKBvf1XxMdWzvsN8uQ=;
        b=tCSYtkCcQhg5k+YkvD/rPKOGtroi6eYVVannkL6bp/Suw8pF3n+Vsmll8iuAJEqlmV/zly
        gNzRbdf1ED9nsrXMsVLN62euZBBqt/9DQdxlIqLs6ELWPzPx5yHUEYzwse4gPgdNEEO1kH
        ak/W4Kq3T6TehD1ckUQ45riWMKU5uek=
From:   Stefan Agner <stefan@agner.ch>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        l.stach@pengutronix.de, tpiepho@impinj.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/2] PCI: imx6: limit DBI register length
Date:   Mon, 19 Nov 2018 10:41:44 +0100
Message-Id: <20181119094144.4127-2-stefan@agner.ch>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119094144.4127-1-stefan@agner.ch>
References: <20181119094144.4127-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Define the length of the DBI registers. This makes sure that
the kernel does not access registers beyond that point, avoiding
the following abort on a i.MX 6Quad:
  # cat /sys/devices/soc0/soc/1ffc000.pcie/pci0000\:00/0000\:00\:00.0/config
  [  100.021433] Unhandled fault: imprecise external abort (0x1406) at 0xb6ea7000
  ...
  [  100.056423] PC is at dw_pcie_read+0x50/0x84
  [  100.060790] LR is at dw_pcie_rd_own_conf+0x44/0x48
  ...

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/pci/controller/dwc/pci-imx6.c | 51 +++++++++++++++++++--------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4a9a673b4777..8c96af414dac 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -39,6 +39,11 @@ enum imx6_pcie_variants {
 	IMX7D,
 };
 
+struct imx6_pcie_drvdata {
+	enum imx6_pcie_variants variant;
+	int			dbi_length;
+};
+
 struct imx6_pcie {
 	struct dw_pcie		*pci;
 	int			reset_gpio;
@@ -50,7 +55,6 @@ struct imx6_pcie {
 	struct regmap		*iomuxc_gpr;
 	struct reset_control	*pciephy_reset;
 	struct reset_control	*apps_reset;
-	enum imx6_pcie_variants variant;
 	u32			tx_deemph_gen1;
 	u32			tx_deemph_gen2_3p5db;
 	u32			tx_deemph_gen2_6db;
@@ -58,6 +62,7 @@ struct imx6_pcie {
 	u32			tx_swing_low;
 	int			link_gen;
 	struct regulator	*vpcie;
+	const struct imx6_pcie_drvdata *drvdata;
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
@@ -285,7 +290,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct device *dev = imx6_pcie->pci->dev;
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 		reset_control_assert(imx6_pcie->pciephy_reset);
 		reset_control_assert(imx6_pcie->apps_reset);
@@ -327,7 +332,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	struct device *dev = pci->dev;
 	int ret = 0;
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
 		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
 		if (ret) {
@@ -430,7 +435,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 					!imx6_pcie->gpio_active_high);
 	}
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 		imx7d_pcie_wait_for_phy_pll_lock(imx6_pcie);
@@ -468,7 +473,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
@@ -560,7 +565,7 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 	dw_pcie_writel_dbi(pci, PCIE_RC_LCR, tmp);
 
 	/* Start LTSSM. */
-	if (imx6_pcie->variant == IMX7D)
+	if (imx6_pcie->drvdata->variant == IMX7D)
 		reset_control_deassert(imx6_pcie->apps_reset);
 	else
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
@@ -585,7 +590,7 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 		tmp |= PORT_LOGIC_SPEED_CHANGE;
 		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
 
-		if (imx6_pcie->variant != IMX7D) {
+		if (imx6_pcie->drvdata->variant != IMX7D) {
 			/*
 			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
 			 * from i.MX6 family when no link speed transition
@@ -703,8 +708,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	pci->ops = &dw_pcie_ops;
 
 	imx6_pcie->pci = pci;
-	imx6_pcie->variant =
-		(enum imx6_pcie_variants)of_device_get_match_data(dev);
+	imx6_pcie->drvdata = of_device_get_match_data(dev);
 
 	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
@@ -748,7 +752,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(imx6_pcie->pcie);
 	}
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
 		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
 							   "pcie_inbound_axi");
@@ -776,6 +780,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		break;
 	}
 
+	pci->dbi_length = imx6_pcie->drvdata->dbi_length;
+
 	/* Grab GPR config register range */
 	imx6_pcie->iomuxc_gpr =
 		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
@@ -835,11 +841,28 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 	imx6_pcie_assert_core_reset(imx6_pcie);
 }
 
+static const struct imx6_pcie_drvdata imx6q_pcie_drvdata = {
+	.variant = IMX6Q,
+	.dbi_length = 0x15c,
+};
+
+static const struct imx6_pcie_drvdata imx6sx_pcie_drvdata = {
+	.variant = IMX6SX,
+};
+
+static const struct imx6_pcie_drvdata imx6qp_pcie_drvdata = {
+	.variant = IMX6QP,
+};
+
+static const struct imx6_pcie_drvdata imx7d_pcie_drvdata = {
+	.variant = IMX7D,
+};
+
 static const struct of_device_id imx6_pcie_of_match[] = {
-	{ .compatible = "fsl,imx6q-pcie",  .data = (void *)IMX6Q,  },
-	{ .compatible = "fsl,imx6sx-pcie", .data = (void *)IMX6SX, },
-	{ .compatible = "fsl,imx6qp-pcie", .data = (void *)IMX6QP, },
-	{ .compatible = "fsl,imx7d-pcie",  .data = (void *)IMX7D,  },
+	{ .compatible = "fsl,imx6q-pcie",  .data = &imx6q_pcie_drvdata,  },
+	{ .compatible = "fsl,imx6sx-pcie", .data = &imx6sx_pcie_drvdata, },
+	{ .compatible = "fsl,imx6qp-pcie", .data = &imx6qp_pcie_drvdata, },
+	{ .compatible = "fsl,imx7d-pcie",  .data = &imx7d_pcie_drvdata,  },
 	{},
 };
 
-- 
2.19.1

