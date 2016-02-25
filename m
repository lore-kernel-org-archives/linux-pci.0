Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33507 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933034AbcBYOsT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Feb 2016 09:48:19 -0500
Received: by mail-wm0-f66.google.com with SMTP id c200so3895271wme.0
        for <linux-pci@vger.kernel.org>; Thu, 25 Feb 2016 06:48:19 -0800 (PST)
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lee Jones <lee.jones@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/2] MFD: imx6sx: Add PCIe register definitions for iomuxc gpr
Date: Thu, 25 Feb 2016 15:47:48 +0100
Message-Id: <1456411669-4699-2-git-send-email-chf.fritz@googlemail.com>
In-Reply-To: <1456411669-4699-1-git-send-email-chf.fritz@googlemail.com>
References: <1456411669-4699-1-git-send-email-chf.fritz@googlemail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds macros to define masks and bits for imx6sx
PCIe registers. This is based on a patch by Richard Zhu.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
index 558a485..238c8db 100644
--- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
+++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
@@ -422,6 +422,7 @@
 #define IMX6SX_GPR5_VADC_TO_CSI_CAPTURE_EN_MASK		(0x1 << 26)
 #define IMX6SX_GPR5_VADC_TO_CSI_CAPTURE_EN_ENABLE	(0x1 << 26)
 #define IMX6SX_GPR5_VADC_TO_CSI_CAPTURE_EN_DISABLE	(0x0 << 26)
+#define IMX6SX_GPR5_PCIE_BTNRST_RESET			BIT(19)
 #define IMX6SX_GPR5_CSI1_MUX_CTRL_MASK			(0x3 << 4)
 #define IMX6SX_GPR5_CSI1_MUX_CTRL_EXT_PIN		(0x0 << 4)
 #define IMX6SX_GPR5_CSI1_MUX_CTRL_CVD			(0x1 << 4)
@@ -435,6 +436,10 @@
 #define IMX6SX_GPR5_DISP_MUX_DCIC1_LVDS			(0x1 << 1)
 #define IMX6SX_GPR5_DISP_MUX_DCIC1_MASK			(0x1 << 1)
 
+#define IMX6SX_GPR12_PCIE_TEST_POWERDOWN		BIT(30)
+#define IMX6SX_GPR12_PCIE_RX_EQ_MASK			(0x7 << 0)
+#define IMX6SX_GPR12_PCIE_RX_EQ_2			(0x2 << 0)
+
 /* For imx6ul iomux gpr register field define */
 #define IMX6UL_GPR1_ENET1_CLK_DIR		(0x1 << 17)
 #define IMX6UL_GPR1_ENET2_CLK_DIR		(0x1 << 18)
-- 
2.1.4

