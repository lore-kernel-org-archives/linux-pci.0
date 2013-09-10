Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.g1.pair.com ([66.39.3.162]:47172 "EHLO mail1.g1.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814Ab3IJEDU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 10 Sep 2013 00:03:20 -0400
From: Sean Cross <xobs@kosagi.com>
To: devicetree-discuss@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Sean Cross <xobs@kosagi.com>
Subject: [PATCH v2 2/3] ARM: imx6q: Add PCIe bits to GPR syscon definition
Date: Tue, 10 Sep 2013 03:37:51 +0000
Message-Id: <1378784272-6333-3-git-send-email-xobs@kosagi.com>
In-Reply-To: <1378784272-6333-1-git-send-email-xobs@kosagi.com>
References: <1378784272-6333-1-git-send-email-xobs@kosagi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCIe requires additional bits be defined for GPR8 and GPR12.

Signed-off-by: Sean Cross <xobs@kosagi.com>
---
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
index b6bdcd6..1bf1fe9 100644
--- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
+++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
@@ -241,6 +241,12 @@
 
 #define IMX6Q_GPR5_L2_CLK_STOP			BIT(8)
 
+#define IMX6Q_GPR8_TX_DEEMPH_GEN1		(0x3F << 0)
+#define IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB		(0x3F << 6)
+#define IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB		(0x3F << 12)
+#define IMX6Q_GPR8_TX_SWING_FULL		(0x7F << 18)
+#define IMX6Q_GPR8_TX_SWING_LOW			(0x7F << 25)
+
 #define IMX6Q_GPR9_TZASC2_BYP			BIT(1)
 #define IMX6Q_GPR9_TZASC1_BYP			BIT(0)
 
@@ -273,7 +279,9 @@
 #define IMX6Q_GPR12_ARMP_AHB_CLK_EN		BIT(26)
 #define IMX6Q_GPR12_ARMP_ATB_CLK_EN		BIT(25)
 #define IMX6Q_GPR12_ARMP_APB_CLK_EN		BIT(24)
+#define IMX6Q_GPR12_DEVICE_TYPE			(0xF << 12)
 #define IMX6Q_GPR12_PCIE_CTL_2			BIT(10)
+#define IMX6Q_GPR12_LOS_LEVEL			(0x1F << 4)
 
 #define IMX6Q_GPR13_SDMA_STOP_REQ		BIT(30)
 #define IMX6Q_GPR13_CAN2_STOP_REQ		BIT(29)
-- 
1.7.9.5

