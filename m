Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0115.outbound.protection.outlook.com ([65.55.169.115]:35382
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751292AbaJJGLs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Oct 2014 02:11:48 -0400
From: Richard Zhu <richard.zhu@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <shawn.guo@freescale.com>, <festevam@gmail.com>,
	<l.stach@pengutronix.de>, <tharvey@gateworks.com>,
	Richard Zhu <r65037@freescale.com>,
	Richard Zhu <richard.zhu@freescale.com>
Subject: [PATCH v5 8/9] ARM: imx6sx: add imx6sx pcie related gpr bits definitions
Date: Fri, 10 Oct 2014 13:41:15 +0800
Message-ID: <1412919676-25344-9-git-send-email-richard.zhu@freescale.com>
In-Reply-To: <1412919676-25344-1-git-send-email-richard.zhu@freescale.com>
References: <1412919676-25344-1-git-send-email-richard.zhu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Richard Zhu <r65037@freescale.com>

Signed-off-by: Richard Zhu <richard.zhu@freescale.com>
---
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
index ff44374..3273b87 100644
--- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
+++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
@@ -301,6 +301,7 @@
 #define IMX6Q_GPR12_DEVICE_TYPE			(0xf << 12)
 #define IMX6Q_GPR12_PCIE_CTL_2			BIT(10)
 #define IMX6Q_GPR12_LOS_LEVEL			(0x1f << 4)
+#define IMX6Q_GPR12_LOS_LEVEL_9			(0x9 << 4)
 
 #define IMX6Q_GPR13_SDMA_STOP_REQ		BIT(30)
 #define IMX6Q_GPR13_CAN2_STOP_REQ		BIT(29)
@@ -395,4 +396,12 @@
 #define IMX6SL_GPR1_FEC_CLOCK_MUX1_SEL_MASK    (0x3 << 17)
 #define IMX6SL_GPR1_FEC_CLOCK_MUX2_SEL_MASK    (0x1 << 14)
 
+/* For imx6sx iomux gpr register field define */
+#define IMX6SX_GPR5_PCIE_BTNRST			BIT(19)
+#define IMX6SX_GPR5_PCIE_PERST			BIT(18)
+
+#define IMX6SX_GPR12_PCIE_PM_TURN_OFF		BIT(16)
+#define IMX6SX_GPR12_PCIE_TEST_PD		BIT(30)
+#define IMX6SX_GPR12_RX_EQ_MASK			(0x7 << 0)
+#define IMX6SX_GPR12_RX_EQ_2			(0x2 << 0)
 #endif /* __LINUX_IMX6Q_IOMUXC_GPR_H */
-- 
1.9.1

