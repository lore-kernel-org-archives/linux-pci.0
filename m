Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0131.outbound.protection.outlook.com ([65.55.169.131]:19409
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750990AbaJJGLr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Oct 2014 02:11:47 -0400
From: Richard Zhu <richard.zhu@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <shawn.guo@freescale.com>, <festevam@gmail.com>,
	<l.stach@pengutronix.de>, <tharvey@gateworks.com>,
	Richard Zhu <r65037@freescale.com>,
	Richard Zhu <richard.zhu@freescale.com>
Subject: [PATCH v5 9/9] ARM: imx6sx: enable pcie on imx6sx sdb board
Date: Fri, 10 Oct 2014 13:41:16 +0800
Message-ID: <1412919676-25344-10-git-send-email-richard.zhu@freescale.com>
In-Reply-To: <1412919676-25344-1-git-send-email-richard.zhu@freescale.com>
References: <1412919676-25344-1-git-send-email-richard.zhu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Richard Zhu <r65037@freescale.com>

Signed-off-by: Richard Zhu <richard.zhu@freescale.com>
---
 arch/arm/boot/dts/imx6sx-sdb.dts | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
index a3980d9..e538ceb 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -90,6 +90,19 @@
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 		};
+
+		reg_pcie: regulator@4 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_pcie_reg>;
+			regulator-name = "MPCIE_3V3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio2 1 0>;
+			regulator-always-on;
+			enable-active-high;
+		};
 	};
 
 	sound {
@@ -251,6 +264,13 @@
 	};
 };
 
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio2 0 0>;
+	status = "okay";
+};
+
 &ssi2 {
 	status = "okay";
 };
@@ -365,6 +385,18 @@
 			>;
 		};
 
+		pinctrl_pcie: pciegrp {
+			fsl,pins = <
+				MX6SX_PAD_ENET1_COL__GPIO2_IO_0 0x17059
+			>;
+		};
+
+		pinctrl_pcie_reg: pciereggrp {
+			fsl,pins = <
+				MX6SX_PAD_ENET1_CRS__GPIO2_IO_1	0x17059
+			>;
+		};
+
 		pinctrl_vcc_sd3: vccsd3grp {
 			fsl,pins = <
 				MX6SX_PAD_KEY_COL1__GPIO2_IO_11		0x17059
-- 
1.9.1

