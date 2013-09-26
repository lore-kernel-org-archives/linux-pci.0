Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]:33192
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753951Ab3IZDXi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Sep 2013 23:23:38 -0400
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Sean Cross <xobs@kosagi.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Zhu Richard-R65037 <r65037@freescale.com>,
	<tharvey@gateworks.com>, Shawn Guo <shawn.guo@linaro.org>,
	Frank Li <lznuaa@gmail.com>
Subject: [PATCH v7 1/2] ARM: imx6q: Add PCIe bits to GPR syscon definition
Date: Thu, 26 Sep 2013 11:24:46 +0800
Message-ID: <1380165887-13506-2-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org>
References: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Sean Cross <xobs@kosagi.com>

PCIe requires additional bits be defined for GPR8 and GPR12.

Signed-off-by: Sean Cross <xobs@kosagi.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
index 7086b22..b6d36b3 100644
--- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
+++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
@@ -241,6 +241,12 @@
 
 #define IMX6Q_GPR5_L2_CLK_STOP			BIT(8)
 
+#define IMX6Q_GPR8_TX_SWING_LOW			(0x7f << 25)
+#define IMX6Q_GPR8_TX_SWING_FULL		(0x7f << 18)
+#define IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB		(0x3f << 12)
+#define IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB		(0x3f << 6)
+#define IMX6Q_GPR8_TX_DEEMPH_GEN1		(0x3f << 0)
+
 #define IMX6Q_GPR9_TZASC2_BYP			BIT(1)
 #define IMX6Q_GPR9_TZASC1_BYP			BIT(0)
 
@@ -273,7 +279,9 @@
 #define IMX6Q_GPR12_ARMP_AHB_CLK_EN		BIT(26)
 #define IMX6Q_GPR12_ARMP_ATB_CLK_EN		BIT(25)
 #define IMX6Q_GPR12_ARMP_APB_CLK_EN		BIT(24)
+#define IMX6Q_GPR12_DEVICE_TYPE			(0xf << 12)
 #define IMX6Q_GPR12_PCIE_CTL_2			BIT(10)
+#define IMX6Q_GPR12_LOS_LEVEL			(0x1f << 4)
 
 #define IMX6Q_GPR13_SDMA_STOP_REQ		BIT(30)
 #define IMX6Q_GPR13_CAN2_STOP_REQ		BIT(29)
-- 
1.7.9.5


