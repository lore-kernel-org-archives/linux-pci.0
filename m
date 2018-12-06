Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76667C04EB9
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 07:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A09F214DB
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 07:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zx0QwkvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A09F214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbeLFHgC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:36:02 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38932 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbeLFHgB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Dec 2018 02:36:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so11381417pld.6;
        Wed, 05 Dec 2018 23:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JsopjK7zH4q0Nw3Raq1i3v5Oy+hMRXGd6aNhJXLKDOo=;
        b=Zx0QwkvGqWvYleO5YxHykENoT/IEMpl+za83/8wJymnkSutF939Yo4l7ViwUNF0kwS
         IEJ0i7P860TG6PDGERo4b9fIUAKbDlE8CJ3DGRL9oKhmibtsqKxtrATGoJpXOvi+FJ4X
         vQQxOMkOsL8lJV8mFw/8AqmCYcH/Yn6tJgLTFFUG2n5CvfL846rczzdrzVOVjJK1vRgp
         P5F9ZR4V7lrd1meBqHXwS2vtVP5qdfrHaXWyKwGYVQUaneFze0nlY9DkAghiX3d8jPyG
         mMS0y61HGb3joqMEcgWjrcJjce7bhf/TIMh8g+fOOzvUmhCiOB4+CzHhWeNVQ7fNCGXS
         rn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JsopjK7zH4q0Nw3Raq1i3v5Oy+hMRXGd6aNhJXLKDOo=;
        b=ZKQaFCZIrHZ3cJWXf0oVIdxn5gm+AWXupMk+P+Qmhc9SEduQ8UL31vYvEH0Qe2iL2E
         lKBfiqU/rghYyo8JRFC4sB9mAf8iL1Hs5JJm40tIB27HRcluNw+W08+XNTIdzxGteuXL
         33fxOsQ4zzr9RAmBuU3zF7u773aZXViK/12F+LxS3cALHOTikKkq5wLJMtqIXzOzux/M
         zFMFhoR0SZZ+WfWOY9FU9pJCvUaGscPmy5z79IQ4j0OmEfHcW9MlPZr50QiYH43F0eja
         LMqP6KLVN624KmNbhC5QQbeXZ2i4pdgBL82JLVGah02tNnDLObVw3vKJOh2FpVfAd+UJ
         HMuw==
X-Gm-Message-State: AA+aEWawnkxB5ii/ZA065ioGSzFvO1toVtYSuLccBH156Nu/98KsTlKG
        ERbMaS4UwWsaQJbACCC/CI6qJOKY
X-Google-Smtp-Source: AFSGD/W6GT9BTMXIBVJ1TrwhN0cnpSbhXZYZErwUM56TeiXs4JlLvPEtWZ1mBFL1f6Ml31IHTJQ8LQ==
X-Received: by 2002:a17:902:8541:: with SMTP id d1mr27811877plo.205.1544081759584;
        Wed, 05 Dec 2018 23:35:59 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id v15sm33035894pfn.94.2018.12.05.23.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 23:35:58 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>, bhelgaas@google.com,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 3/3] PCI: imx: Add support for i.MX8MQ
Date:   Wed,  5 Dec 2018 23:35:45 -0800
Message-Id: <20181206073545.10967-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206073545.10967-1-andrew.smirnov@gmail.com>
References: <20181206073545.10967-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add code needed to support i.MX8MQ variant.

Cc: bhelgaas@google.com
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: cphealy@gmail.com
Cc: l.stach@pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 .../bindings/pci/fsl,imx6q-pcie.txt           |  6 +-
 drivers/pci/controller/dwc/Kconfig            |  2 +-
 drivers/pci/controller/dwc/pci-imx6.c         | 85 +++++++++++++++++--
 3 files changed, 86 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index f37494d5a7be..40b46d11e7e7 100644
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
@@ -43,7 +44,7 @@ Additional required properties for imx6sx-pcie:
 	- "pcie_inbound_axi"
 - power-domains: Must be set to a phandle pointing to the PCIE_PHY power domain
 
-Additional required properties for imx7d-pcie:
+Additional required properties for imx7d-pcie and imx8mq-pcie:
 - power-domains: Must be set to a phandle pointing to PCIE_PHY power domain
 - resets: Must contain phandles to PCIe-related reset lines exposed by SRC
   IP block
@@ -52,6 +53,9 @@ Additional required properties for imx7d-pcie:
 	       - "apps"
 	       - "turnoff"
 
+Additional required properties for imx8mq-pcie:
+- fsl,controller-id: Logical ID of a given PCIE controller. PCIE1 is 0, PCIE2 is 1;
+
 Example:
 
 	pcie@01000000 {
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 91b0194240a5..2b139acccf32 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -90,7 +90,7 @@ config PCI_EXYNOS
 
 config PCI_IMX6
 	bool "Freescale i.MX6 PCIe controller"
-	depends on SOC_IMX6Q || (ARM && COMPILE_TEST)
+	depends on SOC_IMX8MQ || SOC_IMX6Q || (ARM && COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 3c3002861d25..326f71698ac2 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -8,6 +8,7 @@
  * Author: Sean Cross <xobs@kosagi.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
@@ -30,6 +31,11 @@
 
 #include "pcie-designware.h"
 
+#define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
+#define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN	BIT(10)
+#define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
+#define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
+
 #define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
 
 enum imx6_pcie_variants {
@@ -37,6 +43,7 @@ enum imx6_pcie_variants {
 	IMX6SX,
 	IMX6QP,
 	IMX7D,
+	IMX8MQ,
 };
 
 struct imx6_pcie {
@@ -48,6 +55,7 @@ struct imx6_pcie {
 	struct clk		*pcie_inbound_axi;
 	struct clk		*pcie;
 	struct regmap		*iomuxc_gpr;
+	u32			controller_id;
 	struct reset_control	*pciephy_reset;
 	struct reset_control	*apps_reset;
 	struct reset_control	*turnoff_reset;
@@ -245,7 +253,8 @@ static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
 	u32 tmp;
 
-	if (imx6_pcie->variant == IMX7D)
+	if (imx6_pcie->variant == IMX7D ||
+	    imx6_pcie->variant == IMX8MQ)
 		return;
 
 	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
@@ -261,6 +270,7 @@ static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 	pcie_phy_write(imx6_pcie, PHY_RX_OVRD_IN_LO, tmp);
 }
 
+#ifdef CONFIG_ARM
 /*  Added for PCI abort handling */
 static int imx6q_pcie_abort_handler(unsigned long addr,
 		unsigned int fsr, struct pt_regs *regs)
@@ -294,6 +304,7 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 
 	return 1;
 }
+#endif
 
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 {
@@ -301,6 +312,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 
 	switch (imx6_pcie->variant) {
 	case IMX7D:
+	case IMX8MQ: /* FALLTHROUGH */
 		reset_control_assert(imx6_pcie->pciephy_reset);
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
@@ -339,6 +351,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct device *dev = pci->dev;
+	unsigned int offset;
 	int ret = 0;
 
 	switch (imx6_pcie->variant) {
@@ -369,6 +382,29 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 		break;
 	case IMX7D:
 		break;
+	case IMX8MQ:
+		switch (imx6_pcie->controller_id) {
+		case 0:
+			offset = IOMUXC_GPR14;
+			break;
+		case 1:
+			offset = IOMUXC_GPR16;
+			break;
+		default:
+			return -EINVAL;
+		}
+
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
@@ -445,6 +481,9 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	}
 
 	switch (imx6_pcie->variant) {
+	case IMX8MQ:
+		reset_control_deassert(imx6_pcie->pciephy_reset);
+		break;
 	case IMX7D:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 		imx7d_pcie_wait_for_phy_pll_lock(imx6_pcie);
@@ -482,7 +521,34 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
+	unsigned int mask, val, offset;
+
+	mask = IMX6Q_GPR12_DEVICE_TYPE;
+	val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT);
+
 	switch (imx6_pcie->variant) {
+	case IMX8MQ:
+		switch (imx6_pcie->controller_id) {
+		case 0:
+			offset = IOMUXC_GPR14;
+			break;
+		case 1:
+			offset = IOMUXC_GPR16;
+			mask = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE;
+			val  = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+					  PCI_EXP_TYPE_ROOT_PORT);
+			break;
+		default:
+			return;
+		}
+		/*
+		 * TODO: Currently this code assumes external
+		 * oscillator is being used
+		 */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+				   IMX8MQ_GPR_PCIE_REF_USE_PAD,
+				   IMX8MQ_GPR_PCIE_REF_USE_PAD);
+		break;
 	case IMX7D:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
@@ -518,8 +584,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 		break;
 	}
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-			IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT << 12);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
 }
 
 static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
@@ -528,7 +593,8 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 	int mult, div;
 	u32 val;
 
-	if (imx6_pcie->variant == IMX7D)
+	if (imx6_pcie->variant == IMX7D ||
+	    imx6_pcie->variant == IMX8MQ)
 		return 0;
 
 	switch (phy_rate) {
@@ -616,6 +682,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 				   IMX6Q_GPR12_PCIE_CTL_2);
 		break;
 	case IMX7D:
+	case IMX8MQ:		/* FALLTHROUGH */
 		reset_control_deassert(imx6_pcie->apps_reset);
 		break;
 	}
@@ -870,6 +937,10 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	imx6_pcie->variant =
 		(enum imx6_pcie_variants)of_device_get_match_data(dev);
 
+	if (of_property_read_u32(node, "fsl,controller-id",
+				 &imx6_pcie->controller_id))
+		imx6_pcie->controller_id = 0;
+
 	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
 	if (IS_ERR(pci->dbi_base))
@@ -921,7 +992,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
 		}
 		break;
-	case IMX7D:
+	case IMX8MQ:
+	case IMX7D:		/* FALLTHROUGH */
 		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev,
 									    "pciephy");
 		if (IS_ERR(imx6_pcie->pciephy_reset)) {
@@ -1011,6 +1083,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx6sx-pcie", .data = (void *)IMX6SX, },
 	{ .compatible = "fsl,imx6qp-pcie", .data = (void *)IMX6QP, },
 	{ .compatible = "fsl,imx7d-pcie",  .data = (void *)IMX7D,  },
+	{ .compatible = "fsl,imx8mq-pcie", .data = (void *)IMX8MQ, } ,
 	{},
 };
 
@@ -1027,6 +1100,7 @@ static struct platform_driver imx6_pcie_driver = {
 
 static int __init imx6_pcie_init(void)
 {
+#ifdef CONFIG_ARM
 	/*
 	 * Since probe() can be deferred we need to make sure that
 	 * hook_fault_code is not called after __init memory is freed
@@ -1036,6 +1110,7 @@ static int __init imx6_pcie_init(void)
 	 */
 	hook_fault_code(8, imx6q_pcie_abort_handler, SIGBUS, 0,
 			"external abort on non-linefetch");
+#endif
 
 	return platform_driver_register(&imx6_pcie_driver);
 }
-- 
2.19.1

