Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0130.outbound.protection.outlook.com ([157.56.110.130]:33566
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750961AbaIVKCf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Sep 2014 06:02:35 -0400
From: Richard Zhu <r65037@freescale.com>
To: <linux-pci-owner@vger.kernel.org>
CC: <stable@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<l.stach@pengutronix.de>, Richard Zhu <r65037@freescale.com>
Subject: [PATCH RFC 1/2] PCI: imx6: enable pcie on imx6qdl sabresd and sabreauto
Date: Mon, 22 Sep 2014 17:01:37 +0800
Message-ID: <1411376498-14653-2-git-send-email-r65037@freescale.com>
In-Reply-To: <1411376498-14653-1-git-send-email-r65037@freescale.com>
References: <1411376498-14653-1-git-send-email-r65037@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

- enable pcie support on imx6qdl sabresd and asbreauto boards.
- sabresd board has the pcie power on and reset gpios, but
sabreauto doesn't have these two gpios.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 4 ++++
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi   | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 009abd6..d6040a5 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -410,6 +410,10 @@
 	};
 };
 
+&pcie {
+	status = "okay";
+};
+
 &pwm3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index ec43dde..c2d3224 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -396,6 +396,7 @@
 
 		pinctrl_pcie: pciegrp {
 			fsl,pins = <
+				MX6QDL_PAD_EIM_D19__GPIO3_IO19	0x80000000
 				MX6QDL_PAD_GPIO_17__GPIO7_IO12	0x80000000
 			>;
 		};
@@ -502,6 +503,7 @@
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
+	power-on-gpio = <&gpio3 19 0>;
 	reset-gpio = <&gpio7 12 0>;
 	status = "okay";
 };
-- 
1.9.1

