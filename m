Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32849 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbcBNUxe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 14 Feb 2016 15:53:34 -0500
Received: by mail-wm0-f65.google.com with SMTP id c200so12572595wme.0
        for <linux-pci@vger.kernel.org>; Sun, 14 Feb 2016 12:53:33 -0800 (PST)
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lee Jones <lee.jones@linaro.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, linux-pci@vger.kernel.org
Subject: [PATCH 1/2] ARM: imx6sx: Add PCIe register definitions for iomuxc gpr
Date: Sun, 14 Feb 2016 21:52:43 +0100
Message-Id: <1455483164-13755-2-git-send-email-chf.fritz@googlemail.com>
In-Reply-To: <1455483164-13755-1-git-send-email-chf.fritz@googlemail.com>
References: <1455483164-13755-1-git-send-email-chf.fritz@googlemail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds macros to define masks and bits for imx6sx
PCIe registers. This is based on a patch by Richard Zhu.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
index 558a485..93d859b 100644
--- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
+++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
@@ -422,6 +422,12 @@
 #define IMX6SX_GPR5_VADC_TO_CSI_CAPTURE_EN_MASK		(0x1 << 26)
 #define IMX6SX_GPR5_VADC_TO_CSI_CAPTURE_EN_ENABLE	(0x1 << 26)
 #define IMX6SX_GPR5_VADC_TO_CSI_CAPTURE_EN_DISABLE	(0x0 << 26)
+#define IMX6SX_GPR5_PCIE_BTNRST_MASK			(0x1 << 19)
+#define IMX6SX_GPR5_PCIE_BTNRST_RESET			(0x1 << 19)
+#define IMX6SX_GPR5_PCIE_BTNRST_RELEASE		(0x0 << 19)
+#define IMX6SX_GPR5_PCIE_PERST_MASK			(0x1 << 18)
+#define IMX6SX_GPR5_PCIE_PERST_RESET			(0x1 << 18)
+#define IMX6SX_GPR5_PCIE_PERST_RELEASE			(0x0 << 18)
 #define IMX6SX_GPR5_CSI1_MUX_CTRL_MASK			(0x3 << 4)
 #define IMX6SX_GPR5_CSI1_MUX_CTRL_EXT_PIN		(0x0 << 4)
 #define IMX6SX_GPR5_CSI1_MUX_CTRL_CVD			(0x1 << 4)
@@ -435,6 +441,15 @@
 #define IMX6SX_GPR5_DISP_MUX_DCIC1_LVDS			(0x1 << 1)
 #define IMX6SX_GPR5_DISP_MUX_DCIC1_MASK			(0x1 << 1)
 
+#define IMX6SX_GPR12_PCIE_TEST_POWERDOWN_MASK		(0x1 << 30)
+#define IMX6SX_GPR12_PCIE_TEST_POWERDOWN_ENABLE	(0x1 << 30)
+#define IMX6SX_GPR12_PCIE_TEST_POWERDOWN_DISABLE	(0x0 << 30)
+#define IMX6SX_GPR12_PCIE_PM_TURNOFF_MASK		(0x1 << 16)
+#define IMX6SX_GPR12_PCIE_PM_TURNOFF_OFF		(0x1 << 16)
+#define IMX6SX_GPR12_PCIE_PM_TURNOFF_RELEASE		(0x0 << 16)
+#define IMX6SX_GPR12_PCIE_RX_EQ_MASK			(0x7 << 0)
+#define IMX6SX_GPR12_PCIE_RX_EQ_2			(0x2 << 0)
+
 /* For imx6ul iomux gpr register field define */
 #define IMX6UL_GPR1_ENET1_CLK_DIR		(0x1 << 17)
 #define IMX6UL_GPR1_ENET2_CLK_DIR		(0x1 << 18)
-- 
2.1.4

