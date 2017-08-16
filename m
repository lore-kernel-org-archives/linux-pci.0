Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:33447 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752330AbdHPNqL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2017 09:46:11 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Tony Lindgren <tony@atomide.com>
CC: <kishon@ti.com>, <nsekhar@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 08/10] ARM: dts: dra72-evm: Add pinmux configuration for MMC
Date: Wed, 16 Aug 2017 19:15:06 +0530
Message-ID: <20170816134508.8887-9-kishon@ti.com>
In-Reply-To: <20170816134508.8887-1-kishon@ti.com>
References: <20170816134508.8887-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Include dra72x-mmc-iodelay.dtsi which has pinmux and IODelay
configuration values for the various MMC modes for dra72 SoC
and use it in the pinctrl properties of MMC devicetree
nodes present in dra72-evm.dts.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 99fdb3d8445b..c572693b1665 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -6,6 +6,7 @@
  * published by the Free Software Foundation.
  */
 #include "dra72-evm-common.dtsi"
+#include "dra72x-mmc-iodelay.dtsi"
 / {
 	model = "TI DRA722";
 
@@ -55,9 +56,22 @@
 };
 
 &mmc1 {
+	pinctrl-names = "default", "hs", "sdr12", "sdr25", "sdr50", "ddr50", "sdr104";
+	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-1 = <&mmc1_pins_hs>;
+	pinctrl-2 = <&mmc1_pins_sdr12>;
+	pinctrl-3 = <&mmc1_pins_sdr25>;
+	pinctrl-4 = <&mmc1_pins_sdr50>;
+	pinctrl-5 = <&mmc1_pins_ddr50_rev10>;
+	pinctrl-6 = <&mmc1_pins_sdr104 &mmc1_iodelay_sdr104_rev10_conf>;
 	vqmmc-supply = <&ldo1_reg>;
 };
 
 &mmc2 {
+	pinctrl-names = "default", "hs", "ddr_1_8v", "hs200_1_8v";
+	pinctrl-0 = <&mmc2_pins_default>;
+	pinctrl-1 = <&mmc2_pins_hs>;
+	pinctrl-2 = <&mmc2_pins_ddr_rev10>;
+	pinctrl-3 = <&mmc2_pins_hs200 &mmc2_iodelay_hs200_rev10_conf>;
 	vmmc-supply = <&evm_1v8_sw>;
 };
-- 
2.11.0
