Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE96C282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 20:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790C2217D7
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 20:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gijr6Idu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfAXUPz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:15:55 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40801 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730290AbfAXUPs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jan 2019 15:15:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so3398377plq.7;
        Thu, 24 Jan 2019 12:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hBuyi7MnhBFPkQue57wvQ2snvLsFVgKYHU1ZRBZmGEE=;
        b=Gijr6IdubYBJb0SNS3TOQ2GUJ5FP3/myQf3m2/fyiET+5S2aCJivdIdx8InwfWVsSP
         1zOECre1F1G1Ibp10lSDjaSv9TgfEoZgHzAEu55kD2rZLMO61cskruCqYuYnaYcyYfzA
         RP97dqGzY+9UvvrNHa6LF1z5iGcANyyMhSKadoMI61gNXNFIq8Ymbscr3tb5z2dJRenB
         hNwjzU/mFc0rKCfGNg70Rk5mozxrawaVVPlIJH8nOffTUUvlIS5AV1wlUzVsibmd9ju7
         nfUGndAW7fEFxnhXGIOQF84YA8UUtTAUjR8WbR0VvMhnoz/7ZHgFbL9+k29SAmMhasL6
         sALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hBuyi7MnhBFPkQue57wvQ2snvLsFVgKYHU1ZRBZmGEE=;
        b=HbaV7y8kfdBV0s8ebdzS0FbyFEFZE/oZn+/rJrJM9J8fYwGsOTFibvjfMqf16DlvLy
         v1RHEiSPl6I1DiMK/ZKIWe5ip6d8qqrGXIuhAwNTP7cW4XRsRA/vbSpa0ZjXwMsZajwB
         j7iS0CsTTjxrdHst+djpAiFBWJacPrEaB+C6gnxdd9D2p7b23l0IEW4CrwOM2SyfNLrc
         F51wkJb6EvGi+omiXbKtDg2trPPqu2kYxp+WH1z070MNP9hd8SK4fJBqvQR0XfPGTPQa
         kkNHunFZraKUVwazAfK945LB3mvMnN6SdnJ/j0EW1Frjay/P9koQB3dpJYjbFiE9r4E2
         66Ow==
X-Gm-Message-State: AJcUukeGvn8yExD5bn6+O6GfBYAgBv/Omr93KTSWgURrbUURwBAftLKd
        O26LxCbT5tLW61SNyAC4rw8=
X-Google-Smtp-Source: ALg8bN5O9SegLqj1OAyYD0rM8/RFKfK4bxVfp41y5DC6ig2tYrXTThZ4KpmgQDTtxM5Tv1pz1vJSVg==
X-Received: by 2002:a17:902:142:: with SMTP id 60mr8203530plb.330.1548360947613;
        Thu, 24 Jan 2019 12:15:47 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id m65sm53062646pfg.180.2019.01.24.12.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 12:15:46 -0800 (PST)
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
Subject: [PATCH v6 4/4] PCI: imx6: Add support for i.MX8MQ
Date:   Thu, 24 Jan 2019 12:15:22 -0800
Message-Id: <20190124201522.8973-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124201522.8973-1-andrew.smirnov@gmail.com>
References: <20190124201522.8973-1-andrew.smirnov@gmail.com>
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
index 6aafec3fad00..adf7f2061890 100644
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
index 75ee0cd7af3b..dd9d8732f6ba 100644
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
@@ -276,6 +285,7 @@ static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 	pcie_phy_write(imx6_pcie, PHY_RX_OVRD_IN_LO, tmp);
 }
 
+#ifdef CONFIG_ARM
 /*  Added for PCI abort handling */
 static int imx6q_pcie_abort_handler(unsigned long addr,
 		unsigned int fsr, struct pt_regs *regs)
@@ -309,6 +319,7 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 
 	return 1;
 }
+#endif
 
 static int imx6_pcie_attach_pd(struct device *dev)
 {
@@ -353,6 +364,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
+	case IMX8MQ:
 		reset_control_assert(imx6_pcie->pciephy_reset);
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
@@ -387,10 +399,17 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
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
@@ -421,6 +440,19 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
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
@@ -497,6 +529,9 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	}
 
 	switch (imx6_pcie->drvdata->variant) {
+	case IMX8MQ:
+		reset_control_deassert(imx6_pcie->pciephy_reset);
+		break;
 	case IMX7D:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 		imx7d_pcie_wait_for_phy_pll_lock(imx6_pcie);
@@ -532,9 +567,37 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
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
@@ -570,8 +633,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 		break;
 	}
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-			IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT << 12);
+	imx6_pcie_configure_type(imx6_pcie);
 }
 
 static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
@@ -668,6 +730,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 				   IMX6Q_GPR12_PCIE_CTL_2);
 		break;
 	case IMX7D:
+	case IMX8MQ:
 		reset_control_deassert(imx6_pcie->apps_reset);
 		break;
 	}
@@ -1008,6 +1071,10 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
@@ -1115,6 +1182,9 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX7D] = {
 		.variant = IMX7D,
 	},
+	[IMX8MQ] = {
+		.variant = IMX8MQ,
+	},
 };
 
 static const struct of_device_id imx6_pcie_of_match[] = {
@@ -1122,6 +1192,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx6sx-pcie", .data = &drvdata[IMX6SX], },
 	{ .compatible = "fsl,imx6qp-pcie", .data = &drvdata[IMX6QP], },
 	{ .compatible = "fsl,imx7d-pcie",  .data = &drvdata[IMX7D],  },
+	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], } ,
 	{},
 };
 
@@ -1138,6 +1209,7 @@ static struct platform_driver imx6_pcie_driver = {
 
 static int __init imx6_pcie_init(void)
 {
+#ifdef CONFIG_ARM
 	/*
 	 * Since probe() can be deferred we need to make sure that
 	 * hook_fault_code is not called after __init memory is freed
@@ -1147,6 +1219,7 @@ static int __init imx6_pcie_init(void)
 	 */
 	hook_fault_code(8, imx6q_pcie_abort_handler, SIGBUS, 0,
 			"external abort on non-linefetch");
+#endif
 
 	return platform_driver_register(&imx6_pcie_driver);
 }
-- 
2.20.1

