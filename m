Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43152 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbbJOO2B (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2015 10:28:01 -0400
From: WingMan Kwok <w-kwok2@ti.com>
To: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<kishon@ti.com>, <rogerq@ti.com>, <m-karicheri2@ti.com>,
	<bhelgaas@google.com>, <ssantosh@kernel.org>,
	<linux@arm.linux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: WingMan Kwok <w-kwok2@ti.com>
Subject: [PATCH] ARM: keystone: dts: add PCI serdes driver bindings
Date: Thu, 15 Oct 2015 10:27:10 -0400
Message-ID: <1444919230-30932-1-git-send-email-w-kwok2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds the required PCI serdes bindings whcih can then be
enabled by setting the corresponding statuses to "ok" in order to
configure and start the PCI serdes.

This patch depends on the updates to the Keystone PCIe host driver
and common serdes driver patch series that is submitted separately.

Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
---
 arch/arm/boot/dts/k2e.dtsi      |   21 +++++++++++++++++++++
 arch/arm/boot/dts/keystone.dtsi |   21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/k2e.dtsi b/arch/arm/boot/dts/k2e.dtsi
index 675fb8e..3b36575 100644
--- a/arch/arm/boot/dts/k2e.dtsi
+++ b/arch/arm/boot/dts/k2e.dtsi
@@ -86,6 +86,16 @@
 			gpio,syscon-dev = <&devctrl 0x240>;
 		};
 
+		pcie1_phy: pciephy@2326000 {
+			#phy-cells = <0>;
+			compatible = "ti,keystone-serdes-pcie";
+			reg = <0x02326000 0x4000>;
+			reg-names = "serdes";
+			link-rate-kbps = <5000000>;
+			num-lanes = <2>;
+			status = "disabled";
+		};
+
 		pcie1: pcie@21020000 {
 			compatible = "ti,keystone-pcie","snps,dw-pcie";
 			clocks = <&clkpcie1>;
@@ -130,6 +140,17 @@
 					<GIC_SPI 375 IRQ_TYPE_EDGE_RISING>,
 					<GIC_SPI 376 IRQ_TYPE_EDGE_RISING>;
 			};
+
+			/* PCIE phy */
+			serdeses {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				serdes@0 {
+					reg = <0>;
+					phys = <&pcie1_phy>;
+				};
+			};
+
 		};
 
 		mdio: mdio@24200f00 {
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 72816d6..6566cc4 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -275,6 +275,16 @@
 			ti,syscon-dev = <&devctrl 0x2a0>;
 		};
 
+		pcie0_phy: pciephy@2320000 {
+			#phy-cells = <0>;
+			compatible = "ti,keystone-serdes-pcie";
+			reg = <0x02320000 0x4000>;
+			reg-names = "serdes";
+			link-rate-kbps = <5000000>;
+			num-lanes = <2>;
+			status = "disabled";
+		};
+
 		pcie0: pcie@21800000 {
 			compatible = "ti,keystone-pcie", "snps,dw-pcie";
 			clocks = <&clkpcie>;
@@ -319,6 +329,17 @@
 					<GIC_SPI 28 IRQ_TYPE_EDGE_RISING>,
 					<GIC_SPI 29 IRQ_TYPE_EDGE_RISING>;
 			};
+
+			/* PCIE phy */
+			serdeses {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				serdes@0 {
+					reg = <0>;
+					phys = <&pcie0_phy>;
+				};
+			};
+
 		};
 	};
 };
-- 
1.7.9.5

