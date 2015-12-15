Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-omap@vger.kernel.org>, <tony@atomide.com>
CC: <bcousson@baylibre.com>, <kishon@ti.com>, <robh+dt@kernel.org>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linux@arm.linux.org.uk>, <rogerq@ti.com>, <nsekhar@ti.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<t-kristo@ti.com>
Subject: [PATCH v3 4/4] ARM: dts: <am4372/dra7/omap5>: Use "syscon-phy-power" instead of "ctrl-module"
Date: Tue, 15 Dec 2015 15:09:06 +0530
Message-ID: <1450172346-11890-5-git-send-email-kishon@ti.com>
In-Reply-To: <1450172346-11890-1-git-send-email-kishon@ti.com>
References: <1450172346-11890-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add "syscon-phy-power" property and remove the deprecated "ctrl-module"
property from SATA and USB PHY node. Also remove the unused control
module dt nodes.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi |   16 ++--------------
 arch/arm/boot/dts/dra7.dtsi   |   34 ++++------------------------------
 arch/arm/boot/dts/omap5.dtsi  |   26 +++-----------------------
 3 files changed, 9 insertions(+), 67 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index d83ff9c..f42d4a4 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -853,18 +853,6 @@
 			status = "disabled";
 		};
 
-		am43xx_control_usb2phy1: control-phy@44e10620 {
-			compatible = "ti,control-phy-usb2-am437";
-			reg = <0x44e10620 0x4>;
-			reg-names = "power";
-		};
-
-		am43xx_control_usb2phy2: control-phy@0x44e10628 {
-			compatible = "ti,control-phy-usb2-am437";
-			reg = <0x44e10628 0x4>;
-			reg-names = "power";
-		};
-
 		ocp2scp0: ocp2scp@483a8000 {
 			compatible = "ti,am437x-ocp2scp", "ti,omap-ocp2scp";
 			#address-cells = <1>;
@@ -875,7 +863,7 @@
 			usb2_phy1: phy@483a8000 {
 				compatible = "ti,am437x-usb2";
 				reg = <0x483a8000 0x8000>;
-				ctrl-module = <&am43xx_control_usb2phy1>;
+				syscon-phy-power = <&scm_conf 0x620>;
 				clocks = <&usb_phy0_always_on_clk32k>,
 					 <&usb_otg_ss0_refclk960m>;
 				clock-names = "wkupclk", "refclk";
@@ -894,7 +882,7 @@
 			usb2_phy2: phy@483e8000 {
 				compatible = "ti,am437x-usb2";
 				reg = <0x483e8000 0x8000>;
-				ctrl-module = <&am43xx_control_usb2phy2>;
+				syscon-phy-power = <&scm_conf 0x628>;
 				clocks = <&usb_phy1_always_on_clk32k>,
 					 <&usb_otg_ss1_refclk960m>;
 				clock-names = "wkupclk", "refclk";
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 41545f9..8ce37e4 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1170,14 +1170,6 @@
 			status = "disabled";
 		};
 
-		omap_control_sata: control-phy@4a002374 {
-			compatible = "ti,control-phy-pipe3";
-			reg = <0x4a002374 0x4>;
-			reg-names = "power";
-			clocks = <&sys_clkin1>;
-			clock-names = "sysclk";
-		};
-
 		/* OCP2SCP3 */
 		ocp2scp@4a090000 {
 			compatible = "ti,omap-ocp2scp";
@@ -1192,7 +1184,7 @@
 				      <0x4A096400 0x64>, /* phy_tx */
 				      <0x4A096800 0x40>; /* pll_ctrl */
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
-				ctrl-module = <&omap_control_sata>;
+				syscon-phy-power = <&scm_conf 0x374>;
 				clocks = <&sys_clkin1>, <&sata_ref_clk>;
 				clock-names = "sysclk", "refclk";
 				syscon-pllreset = <&scm_conf 0x3fc>;
@@ -1260,24 +1252,6 @@
 			clocks = <&sys_32k_ck>;
 		};
 
-		omap_control_usb2phy1: control-phy@4a002300 {
-			compatible = "ti,control-phy-usb2";
-			reg = <0x4a002300 0x4>;
-			reg-names = "power";
-		};
-
-		omap_control_usb3phy1: control-phy@4a002370 {
-			compatible = "ti,control-phy-pipe3";
-			reg = <0x4a002370 0x4>;
-			reg-names = "power";
-		};
-
-		omap_control_usb2phy2: control-phy@0x4a002e74 {
-			compatible = "ti,control-phy-usb2-dra7";
-			reg = <0x4a002e74 0x4>;
-			reg-names = "power";
-		};
-
 		/* OCP2SCP1 */
 		ocp2scp@4a080000 {
 			compatible = "ti,omap-ocp2scp";
@@ -1290,7 +1264,7 @@
 			usb2_phy1: phy@4a084000 {
 				compatible = "ti,omap-usb2";
 				reg = <0x4a084000 0x400>;
-				ctrl-module = <&omap_control_usb2phy1>;
+				syscon-phy-power = <&scm_conf 0x300>;
 				clocks = <&usb_phy1_always_on_clk32k>,
 					 <&usb_otg_ss1_refclk960m>;
 				clock-names =	"wkupclk",
@@ -1302,7 +1276,7 @@
 				compatible = "ti,dra7x-usb2-phy2",
 					     "ti,omap-usb2";
 				reg = <0x4a085000 0x400>;
-				ctrl-module = <&omap_control_usb2phy2>;
+				syscon-phy-power = <&scm_conf 0xe74>;
 				clocks = <&usb_phy2_always_on_clk32k>,
 					 <&usb_otg_ss2_refclk960m>;
 				clock-names =	"wkupclk",
@@ -1316,7 +1290,7 @@
 				      <0x4a084800 0x64>,
 				      <0x4a084c00 0x40>;
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
-				ctrl-module = <&omap_control_usb3phy1>;
+				syscon-phy-power = <&scm_conf 0x370>;
 				clocks = <&usb_phy3_always_on_clk32k>,
 					 <&sys_clkin1>,
 					 <&usb_otg_ss1_refclk960m>;
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 4c04389..f6d6d91 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -850,18 +850,6 @@
 			hw-caps-temp-alert;
 		};
 
-		omap_control_usb2phy: control-phy@4a002300 {
-			compatible = "ti,control-phy-usb2";
-			reg = <0x4a002300 0x4>;
-			reg-names = "power";
-		};
-
-		omap_control_usb3phy: control-phy@4a002370 {
-			compatible = "ti,control-phy-pipe3";
-			reg = <0x4a002370 0x4>;
-			reg-names = "power";
-		};
-
 		usb3: omap_dwc3@4a020000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss";
@@ -897,7 +885,7 @@
 			usb2_phy: usb2phy@4a084000 {
 				compatible = "ti,omap-usb2";
 				reg = <0x4a084000 0x7c>;
-				ctrl-module = <&omap_control_usb2phy>;
+				syscon-phy-power = <&scm_conf 0x300>;
 				clocks = <&usb_phy_cm_clk32k>, <&usb_otg_ss_refclk960m>;
 				clock-names = "wkupclk", "refclk";
 				#phy-cells = <0>;
@@ -909,7 +897,7 @@
 				      <0x4a084800 0x64>,
 				      <0x4a084c00 0x40>;
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
-				ctrl-module = <&omap_control_usb3phy>;
+				syscon-phy-power = <&scm_conf 0x370>;
 				clocks = <&usb_phy_cm_clk32k>,
 					 <&sys_clkin>,
 					 <&usb_otg_ss_refclk960m>;
@@ -965,14 +953,6 @@
 			#thermal-sensor-cells = <1>;
 		};
 
-		omap_control_sata: control-phy@4a002374 {
-			compatible = "ti,control-phy-pipe3";
-			reg = <0x4a002374 0x4>;
-			reg-names = "power";
-			clocks = <&sys_clkin>;
-			clock-names = "sysclk";
-		};
-
 		/* OCP2SCP3 */
 		ocp2scp@4a090000 {
 			compatible = "ti,omap-ocp2scp";
@@ -987,7 +967,7 @@
 				      <0x4A096400 0x64>, /* phy_tx */
 				      <0x4A096800 0x40>; /* pll_ctrl */
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
-				ctrl-module = <&omap_control_sata>;
+				syscon-phy-power = <&scm_conf 0x374>;
 				clocks = <&sys_clkin>, <&sata_ref_clk>;
 				clock-names = "sysclk", "refclk";
 				#phy-cells = <0>;
-- 
1.7.9.5

