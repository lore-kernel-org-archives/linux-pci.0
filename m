Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42080 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933146AbbLOJkL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Dec 2015 04:40:11 -0500
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
Subject: [PATCH v3 2/4] ARM: dts: dra7: Use "syscon-phy-power" and "syscon-pcs" in PCIe PHY node
Date: Tue, 15 Dec 2015 15:09:04 +0530
Message-ID: <1450172346-11890-3-git-send-email-kishon@ti.com>
In-Reply-To: <1450172346-11890-1-git-send-email-kishon@ti.com>
References: <1450172346-11890-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add "syscon-phy-power" property and "syscon-pcs" property which can
be used to perform the control module initializations and remove
the deprecated "ctrl-module" property from PCIe PHY dt nodes.

Phandle to "sysclk" clock node is also added to the PCIe PHY node
since some of the syscon initializations is based on system clock
frequency.

Since "omap_control_pcie1phy" and "omap_control_pcie2phy" devicetree
nodes are no longer used, remove it.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |   33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index e38f63f..156d735 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1204,16 +1204,18 @@
 				reg = <0x4a094000 0x80>, /* phy_rx */
 				      <0x4a094400 0x64>; /* phy_tx */
 				reg-names = "phy_rx", "phy_tx";
-				ctrl-module = <&omap_control_pcie1phy>;
+				syscon-phy-power = <&scm_conf_pcie 0x1c>;
+				syscon-pcs = <&scm_conf_pcie 0x10>;
 				clocks = <&dpll_pcie_ref_ck>,
 					 <&dpll_pcie_ref_m2ldo_ck>,
 					 <&optfclk_pciephy1_32khz>,
 					 <&optfclk_pciephy1_clk>,
 					 <&optfclk_pciephy1_div_clk>,
-					 <&optfclk_pciephy_div>;
+					 <&optfclk_pciephy_div>,
+					 <&sys_clkin1>;
 				clock-names = "dpll_ref", "dpll_ref_m2",
 					      "wkupclk", "refclk",
-					      "div-clk", "phy-div";
+					      "div-clk", "phy-div", "sysclk";
 				#phy-cells = <0>;
 			};
 
@@ -1222,16 +1224,18 @@
 				reg = <0x4a095000 0x80>, /* phy_rx */
 				      <0x4a095400 0x64>; /* phy_tx */
 				reg-names = "phy_rx", "phy_tx";
-				ctrl-module = <&omap_control_pcie2phy>;
+				syscon-phy-power = <&scm_conf_pcie 0x20>;
+				syscon-pcs = <&scm_conf_pcie 0x10>;
 				clocks = <&dpll_pcie_ref_ck>,
 					 <&dpll_pcie_ref_m2ldo_ck>,
 					 <&optfclk_pciephy2_32khz>,
 					 <&optfclk_pciephy2_clk>,
 					 <&optfclk_pciephy2_div_clk>,
-					 <&optfclk_pciephy_div>;
+					 <&optfclk_pciephy_div>,
+					 <&sys_clkin1>;
 				clock-names = "dpll_ref", "dpll_ref_m2",
 					      "wkupclk", "refclk",
-					      "div-clk", "phy-div";
+					      "div-clk", "phy-div", "sysclk";
 				#phy-cells = <0>;
 				status = "disabled";
 			};
@@ -1247,23 +1251,6 @@
 			ti,hwmods = "sata";
 		};
 
-		omap_control_pcie1phy: control-phy@0x4a003c40 {
-			compatible = "ti,control-phy-pcie";
-			reg = <0x4a003c40 0x4>, <0x4a003c14 0x4>, <0x4a003c34 0x4>;
-			reg-names = "power", "control_sma", "pcie_pcs";
-			clocks = <&sys_clkin1>;
-			clock-names = "sysclk";
-		};
-
-		omap_control_pcie2phy: control-pcie@0x4a003c44 {
-			compatible = "ti,control-phy-pcie";
-			reg = <0x4a003c44 0x4>, <0x4a003c14 0x4>, <0x4a003c34 0x4>;
-			reg-names = "power", "control_sma", "pcie_pcs";
-			clocks = <&sys_clkin1>;
-			clock-names = "sysclk";
-			status = "disabled";
-		};
-
 		rtc: rtc@48838000 {
 			compatible = "ti,am3352-rtc";
 			reg = <0x48838000 0x100>;
-- 
1.7.9.5

