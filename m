Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0115.outbound.protection.outlook.com ([157.56.111.115]:58795
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751607AbaI2FdY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 29 Sep 2014 01:33:24 -0400
From: Richard Zhu <r65037@freescale.com>
To: <linux-pci-owner@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <shawn.guo@freescale.com>,
	<festevam@gmail.com>, <l.stach@pengutronix.de>,
	<tharvey@gateworks.com>, Richard Zhu <r65037@freescale.com>
Subject: [PATCH v3 6/9] PCI: imx6: enable pcie on imx6sx sdb board
Date: Mon, 29 Sep 2014 13:03:14 +0800
Message-ID: <1411966997-27118-7-git-send-email-r65037@freescale.com>
In-Reply-To: <1411966997-27118-1-git-send-email-r65037@freescale.com>
References: <1411966997-27118-1-git-send-email-r65037@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 arch/arm/boot/dts/imx6sx-sdb.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
index a3980d9..2976913 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -251,6 +251,13 @@
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
@@ -365,6 +372,12 @@
 			>;
 		};
 
+		pinctrl_pcie: pciegrp {
+			fsl,pins = <
+				MX6SX_PAD_ENET1_COL__GPIO2_IO_0 0x17059
+			>;
+		};
+
 		pinctrl_vcc_sd3: vccsd3grp {
 			fsl,pins = <
 				MX6SX_PAD_KEY_COL1__GPIO2_IO_11		0x17059
-- 
1.9.1

