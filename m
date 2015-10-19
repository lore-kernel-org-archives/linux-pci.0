Return-Path: <linux-kernel-owner@vger.kernel.org>
From: WingMan Kwok <w-kwok2@ti.com>
To: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<kishon@ti.com>, <rogerq@ti.com>, <m-karicheri2@ti.com>,
	<bhelgaas@google.com>, <ssantosh@kernel.org>,
	<linux@arm.linux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: WingMan Kwok <w-kwok2@ti.com>
Subject: [PATCH v1] ARM: keystone: dts: add PCI serdes driver bindings
Date: Mon, 19 Oct 2015 14:58:00 -0400
Message-ID: <1445281080-14818-1-git-send-email-w-kwok2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds the serdes phy driver dts bindings
for the keystone PCIe host driver.

v1:
	- addresses the following review comments
		1. https://lkml.org/lkml/2015/10/19/264
		2. https://lkml.org/lkml/2015/10/15/895

Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
---
 arch/arm/boot/dts/k2e.dtsi      |   10 ++++++++++
 arch/arm/boot/dts/keystone.dtsi |   10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/k2e.dtsi b/arch/arm/boot/dts/k2e.dtsi
index 675fb8e..5f7cc0a 100644
--- a/arch/arm/boot/dts/k2e.dtsi
+++ b/arch/arm/boot/dts/k2e.dtsi
@@ -86,6 +86,15 @@
 			gpio,syscon-dev = <&devctrl 0x240>;
 		};
 
+		pcie1_phy: phy@2326000 {
+			#phy-cells = <0>;
+			compatible = "ti,keystone-serdes-pcie";
+			reg = <0x02326000 0x4000>;
+			link-rate-kbps = <5000000>;
+			num-lanes = <2>;
+			status = "disabled";
+		};
+
 		pcie1: pcie@21020000 {
 			compatible = "ti,keystone-pcie","snps,dw-pcie";
 			clocks = <&clkpcie1>;
@@ -99,6 +108,7 @@
 			status = "disabled";
 			device_type = "pci";
 			num-lanes = <2>;
+			phys = <&pcie1_phy>;
 
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 72816d6..5c7c58a 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -275,6 +275,15 @@
 			ti,syscon-dev = <&devctrl 0x2a0>;
 		};
 
+		pcie0_phy: phy@2320000 {
+			#phy-cells = <0>;
+			compatible = "ti,keystone-serdes-pcie";
+			reg = <0x02320000 0x4000>;
+			link-rate-kbps = <5000000>;
+			num-lanes = <2>;
+			status = "disabled";
+		};
+
 		pcie0: pcie@21800000 {
 			compatible = "ti,keystone-pcie", "snps,dw-pcie";
 			clocks = <&clkpcie>;
@@ -288,6 +297,7 @@
 			status = "disabled";
 			device_type = "pci";
 			num-lanes = <2>;
+			phys = <&pcie0_phy>;
 
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
-- 
1.7.9.5

