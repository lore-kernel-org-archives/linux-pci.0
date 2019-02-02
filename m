Return-Path: <SRS0=cvZd=QJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F27C282D8
	for <linux-pci@archiver.kernel.org>; Sat,  2 Feb 2019 00:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6765720863
	for <linux-pci@archiver.kernel.org>; Sat,  2 Feb 2019 00:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nchCTLIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfBBAPt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:15:49 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44832 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfBBAPm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Feb 2019 19:15:42 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so4006219pfh.11;
        Fri, 01 Feb 2019 16:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+V3m+R4Z9ojnTs9h00XX9PhmXqogAjMhmuyUa8cKNeo=;
        b=nchCTLIJNLEGiaMsFjhng8Srf/qrwT110j633Xud76hhQA2xR0aKltgVTn+5TkHxAV
         Gt6aI+4sR8ixTNU8GOCJ34SDqvu/s0GJEun8dsrRixl2prVJ+65jZqONegsHyqrt45GQ
         IvW6FhafDCPZbErDcW9rgkcBhCt7iAxYk9vKSsu9Q2ONYqXBoIgZecaVotvztBDb9FSp
         7i4Gy+NQYrISP7mNdtSJRunt5w2uiNXozTJR3zMSP2TrpTl1XRlX5Ilw2EIYXMAs2Dgi
         kUm0zGyS4Yhy3RFZLmxJFvbNMNHNQ1WzNutJrykurAcmvMhfEcX/lbC52BgScFfYvccS
         xX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+V3m+R4Z9ojnTs9h00XX9PhmXqogAjMhmuyUa8cKNeo=;
        b=kjgqGEWdMRk4LlNN1fM5vKUO74HyFZtLOjyj5AgZrszFQfu3PekrZp0pQBQSWr0zLH
         N3f0k8sKh/tZmK4wsERsZZ6s6kyUwuAsTrwfkVu8V2VfgZfHp3cFp+xwIEklapRm1u1e
         0NEE3e8BUcju5LuntN+y2FoMScNdnOKUIL/RB1Y2jN8XALmXFVXFcLcn43xQyHKTtVa3
         pgC5febXXwKY+TSLXadmGMZDMzYfT0c5y6pU+FppPSIiE/Q+lDwjpTA3IC471eUaVdud
         RbscBYp40IMrLtrfNrSDqiGx8zJdq6TWaEsFrk0w7fLaUbq0KPCtAdUi94nd2tqbFjtn
         dOmA==
X-Gm-Message-State: AHQUAuY6KJNPjUhIv4DmZIRBoCmjwRlnxcqfQLbIa0q/lhZiC8JhkgVt
        APvs2Z6JzY9OPIPC4uVroPU=
X-Google-Smtp-Source: AHgI3Ib7ckfWoX+1YXRgfJMiGV3ZTWlircVFiXnvYU6kpG+/1GnxNkcq97ZJJ60zdyS6tD7ub7uvyw==
X-Received: by 2002:a63:a002:: with SMTP id r2mr4325154pge.212.1549066541270;
        Fri, 01 Feb 2019 16:15:41 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id w6sm28374545pga.72.2019.02.01.16.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 16:15:40 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v7 4/4] PCI: imx6: Add support for i.MX8MQ
Date:   Fri,  1 Feb 2019 16:15:23 -0800
Message-Id: <20190202001523.12517-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190202001523.12517-1-andrew.smirnov@gmail.com>
References: <20190202001523.12517-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add code needed to support i.MX8MQ variant.

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
 .../bindings/pci/fsl,imx6q-pcie.txt           |  3 +-
 drivers/pci/controller/dwc/Kconfig            |  4 +-
 drivers/pci/controller/dwc/pci-imx6.c         | 77 ++++++++++++++++++-
 3 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index d514c1f2365f..920ca93870a8 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -9,6 +9,7 @@ Required properties:
 	- "fsl,imx6sx-pcie",
 	- "fsl,imx6qp-pcie"
 	- "fsl,imx7d-pcie"
+	- "fsl,imx8mq-pcie"
 - reg: base address and length of the PCIe controller
 - interrupts: A list of interrupt outputs of the controller. Must contain an
   entry for each entry in the interrupt-names property.
@@ -45,7 +46,7 @@ Additional required properties for imx6sx-pcie:
   PCIE_PHY power domains
 - power-domain-names: Must be "pcie", "pcie_phy"
 
-Additional required properties for imx7d-pcie:
+Additional required properties for imx7d-pcie and imx8mq-pcie:
 - power-domains: Must be set to a phandle pointing to PCIE_PHY power domain
 - resets: Must contain phandles to PCIe-related reset lines exposed by SRC
   IP block
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 548c58223868..6ea74b1c0d94 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -89,8 +89,8 @@ config PCI_EXYNOS
 	select PCIE_DW_HOST
 
 config PCI_IMX6
-	bool "Freescale i.MX6/7 PCIe controller"
-	depends on SOC_IMX6Q || SOC_IMX7D || (ARM && COMPILE_TEST)
+	bool "Freescale i.MX6/7/8 PCIe controller"
+	depends on SOC_IMX6Q || SOC_IMX7D || (ARM64 && ARCH_MXC) || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 11b73d733dae..c1d434ba3642 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -8,6 +8,7 @@
  * Author: Sean Cross <xobs@kosagi.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
@@ -32,6 +33,12 @@
 
 #include "pcie-designware.h"
 
+#define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
+#define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN	BIT(10)
+#define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
+#define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
+#define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
+
 #define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
 
 enum imx6_pcie_variants {
@@ -39,6 +46,7 @@ enum imx6_pcie_variants {
 	IMX6SX,
 	IMX6QP,
 	IMX7D,
+	IMX8MQ,
 };
 
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
@@ -58,6 +66,7 @@ struct imx6_pcie {
 	struct clk		*pcie_inbound_axi;
 	struct clk		*pcie;
 	struct regmap		*iomuxc_gpr;
+	u32			controller_id;
 	struct reset_control	*pciephy_reset;
 	struct reset_control	*apps_reset;
 	struct reset_control	*turnoff_reset;
@@ -275,6 +284,7 @@ static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 	pcie_phy_write(imx6_pcie, PHY_RX_OVRD_IN_LO, tmp);
 }
 
+#ifdef CONFIG_ARM
 /*  Added for PCI abort handling */
 static int imx6q_pcie_abort_handler(unsigned long addr,
 		unsigned int fsr, struct pt_regs *regs)
@@ -308,6 +318,7 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 
 	return 1;
 }
+#endif
 
 static int imx6_pcie_attach_pd(struct device *dev)
 {
@@ -352,6 +363,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
+	case IMX8MQ:
 		reset_control_assert(imx6_pcie->pciephy_reset);
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
@@ -386,10 +398,17 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 	}
 }
 
+static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
+{
+	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ);
+	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
+}
+
 static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct device *dev = pci->dev;
+	unsigned int offset;
 	int ret = 0;
 
 	switch (imx6_pcie->drvdata->variant) {
@@ -420,6 +439,19 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 		break;
 	case IMX7D:
 		break;
+	case IMX8MQ:
+		offset = imx6_pcie_grp_offset(imx6_pcie);
+		/*
+		 * Set the over ride low and enabled
+		 * make sure that REF_CLK is turned on.
+		 */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
+				   0);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
+				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
+		break;
 	}
 
 	return ret;
@@ -496,6 +528,9 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	}
 
 	switch (imx6_pcie->drvdata->variant) {
+	case IMX8MQ:
+		reset_control_deassert(imx6_pcie->pciephy_reset);
+		break;
 	case IMX7D:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 		imx7d_pcie_wait_for_phy_pll_lock(imx6_pcie);
@@ -531,9 +566,37 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	}
 }
 
+static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
+{
+	unsigned int mask, val;
+
+	if (imx6_pcie->drvdata->variant == IMX8MQ &&
+	    imx6_pcie->controller_id == 1) {
+		mask   = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE;
+		val    = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+				    PCI_EXP_TYPE_ROOT_PORT);
+	} else {
+		mask = IMX6Q_GPR12_DEVICE_TYPE;
+		val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE,
+				  PCI_EXP_TYPE_ROOT_PORT);
+	}
+
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
+}
+
 static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
 	switch (imx6_pcie->drvdata->variant) {
+	case IMX8MQ:
+		/*
+		 * TODO: Currently this code assumes external
+		 * oscillator is being used
+		 */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				   imx6_pcie_grp_offset(imx6_pcie),
+				   IMX8MQ_GPR_PCIE_REF_USE_PAD,
+				   IMX8MQ_GPR_PCIE_REF_USE_PAD);
+		break;
 	case IMX7D:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
@@ -569,8 +632,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 		break;
 	}
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-			IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT << 12);
+	imx6_pcie_configure_type(imx6_pcie);
 }
 
 static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
@@ -667,6 +729,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 				   IMX6Q_GPR12_PCIE_CTL_2);
 		break;
 	case IMX7D:
+	case IMX8MQ:
 		reset_control_deassert(imx6_pcie->apps_reset);
 		break;
 	}
@@ -1002,6 +1065,10 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		}
 		break;
 	case IMX7D:
+	case IMX8MQ:
+		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
+			imx6_pcie->controller_id = 1;
+
 		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev,
 									    "pciephy");
 		if (IS_ERR(imx6_pcie->pciephy_reset)) {
@@ -1117,6 +1184,9 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX7D] = {
 		.variant = IMX7D,
 	},
+	[IMX8MQ] = {
+		.variant = IMX8MQ,
+	},
 };
 
 static const struct of_device_id imx6_pcie_of_match[] = {
@@ -1124,6 +1194,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx6sx-pcie", .data = &drvdata[IMX6SX], },
 	{ .compatible = "fsl,imx6qp-pcie", .data = &drvdata[IMX6QP], },
 	{ .compatible = "fsl,imx7d-pcie",  .data = &drvdata[IMX7D],  },
+	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], } ,
 	{},
 };
 
@@ -1140,6 +1211,7 @@ static struct platform_driver imx6_pcie_driver = {
 
 static int __init imx6_pcie_init(void)
 {
+#ifdef CONFIG_ARM
 	/*
 	 * Since probe() can be deferred we need to make sure that
 	 * hook_fault_code is not called after __init memory is freed
@@ -1149,6 +1221,7 @@ static int __init imx6_pcie_init(void)
 	 */
 	hook_fault_code(8, imx6q_pcie_abort_handler, SIGBUS, 0,
 			"external abort on non-linefetch");
+#endif
 
 	return platform_driver_register(&imx6_pcie_driver);
 }
-- 
2.20.1

