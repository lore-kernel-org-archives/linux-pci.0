Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:35842 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752345AbdHJGfP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2017 02:35:15 -0400
From: <honghui.zhang@mediatek.com>
To: <bhelgaas@google.com>, <robh@kerenl.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>
CC: <honghui.zhang@mediatek.com>, <hongkun.cao@mediatek.com>,
        <youlin.pei@mediatek.com>, <yong.wu@mediatek.com>,
        <yt.shen@mediatek.com>, <sean.wang@mediatek.com>,
        <xinping.qian@mediatek.com>
Subject: [PATCH v4 7/7] dt-bindings: PCI: add support for mt2712 and mt7622
Date: Thu, 10 Aug 2017 14:35:00 +0800
Message-ID: <c07881ccefc370fdd9d7b626b3e625c16240fad2.1502336769.git.honghui.zhang@mediatek.com>
In-Reply-To: <cover.1502336769.git.honghui.zhang@mediatek.com>
References: <cover.1502336769.git.honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Ryder Lee <ryder.lee@mediatek.com>

Add controller support for mt2712/mt7622 and update related
properities.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/mediatek-pcie.txt      | 168 ++++++++++++++++++++-
 1 file changed, 161 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
index 0fdcb15..2e81742 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
@@ -3,18 +3,31 @@ MediaTek Gen2 PCIe controller
 Required properties:
 - compatible: Should contain one of the following strings:
 	"mediatek,mt2701-pcie"
+	"mediatek,mt2712-pcie"
+	"mediatek,mt7622-pcie"
 	"mediatek,mt7623-pcie"
 - device_type: Must be "pci"
-- reg: Base addresses and lengths of the PCIe controller.
+- reg: Base addresses and lengths of the PCIe subsys and root ports.
+- reg-names: Names of the above areas to use during resource look-up.
 - #address-cells: Address representation for root ports (must be 3)
 - #size-cells: Size representation for root ports (must be 2)
 - clocks: Must contain an entry for each entry in clock-names.
   See ../clocks/clock-bindings.txt for details.
-- clock-names: Must include the following entries:
-  - free_ck :for reference clock of PCIe subsys
-  - sys_ck0 :for clock of Port0
-  - sys_ck1 :for clock of Port1
-  - sys_ck2 :for clock of Port2
+- clock-names:
+  Mandatory entries:
+   - sys_ckN :transaction layer and data link layer clock
+  Required entries for MT2701/MT7623:
+   - free_ck :for reference clock of PCIe subsys
+  Required entries for MT2712/MT7622:
+   - ahb_ckN :AHB slave interface operating clock for CSR access and RC
+	      initiated MMIO access
+  Required entries for MT7622:
+   - axi_ckN :application layer MMIO channel operating clock
+   - aux_ckN :pe2_mac_bridge and pe2_mac_core operating clock when
+	      pcie_mac_ck/pcie_pipe_ck is turned off
+   - obff_ckN :OBFF functional block operating clock
+   - pipe_ckN :LTSSM and PHY/MAC layer operating clock
+  where N starting from 0 to one less than the number of root ports.
 - phys: List of PHY specifiers (used by generic PHY framework).
 - phy-names : Must be "pcie-phy0", "pcie-phy1", "pcie-phyN".. based on the
   number of PHYs as specified in *phys* property.
@@ -33,6 +46,10 @@ Required properties for MT7623/MT2701:
 - reset-names: Must be "pcie-rst0", "pcie-rst1", "pcie-rstN".. based on the
   number of root ports.
 
+Required properties for MT2712/MT7622:
+-interrupts: A list of interrupt outputs of the controller, must have one
+	     entry for each PCIe port
+
 In addition, the device tree node must have sub-nodes describing each
 PCIe port interface, having the following mandatory properties:
 
@@ -50,7 +67,7 @@ Required properties:
   property is sufficient.
 - num-lanes: Number of lanes to use for this port.
 
-Examples:
+Examples for MT7623:
 
 	hifsys: syscon@1a000000 {
 		compatible = "mediatek,mt7623-hifsys",
@@ -68,6 +85,7 @@ Examples:
 		      <0 0x1a142000 0 0x1000>, /* Port0 registers */
 		      <0 0x1a143000 0 0x1000>, /* Port1 registers */
 		      <0 0x1a144000 0 0x1000>; /* Port2 registers */
+		reg-names = "subsys", "port0", "port1", "port2";
 		#address-cells = <3>;
 		#size-cells = <2>;
 		#interrupt-cells = <1>;
@@ -128,3 +146,139 @@ Examples:
 			num-lanes = <1>;
 		};
 	};
+
+Examples for MT2712:
+	pcie: pcie@11700000 {
+		compatible = "mediatek,mt2712-pcie";
+		device_type = "pci";
+		reg = <0 0x11700000 0 0x1000>,
+		      <0 0x112ff000 0 0x1000>;
+		reg-names = "port0", "port1";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&topckgen CLK_TOP_PE2_MAC_P0_SEL>,
+			 <&topckgen CLK_TOP_PE2_MAC_P1_SEL>,
+			 <&pericfg CLK_PERI_PCIE0>,
+			 <&pericfg CLK_PERI_PCIE1>;
+		clock-names = "sys_ck0", "sys_ck1", "ahb_ck0", "ahb_ck1";
+		phys = <&pcie0_phy PHY_TYPE_PCIE>, <&pcie1_phy PHY_TYPE_PCIE>;
+		phy-names = "pcie-phy0", "pcie-phy1";
+		bus-range = <0x00 0xff>;
+		ranges = <0x82000000 0 0x20000000  0x0 0x20000000  0 0x10000000>;
+
+		pcie0: pcie@0,0 {
+			device_type = "pci";
+			reg = <0x0000 0 0 0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges;
+			num-lanes = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+					<0 0 0 2 &pcie_intc0 1>,
+					<0 0 0 3 &pcie_intc0 2>,
+					<0 0 0 4 &pcie_intc0 3>;
+			pcie_intc0: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		pcie1: pcie@1,0 {
+			device_type = "pci";
+			reg = <0x0800 0 0 0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges;
+			num-lanes = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+					<0 0 0 2 &pcie_intc1 1>,
+					<0 0 0 3 &pcie_intc1 2>,
+					<0 0 0 4 &pcie_intc1 3>;
+			pcie_intc1: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+	};
+
+Examples for MT7622:
+	pcie: pcie@1a140000 {
+		compatible = "mediatek,mt7622-pcie";
+		device_type = "pci";
+		reg = <0 0x1a140000 0 0x1000>,
+		      <0 0x1a143000 0 0x1000>,
+		      <0 0x1a145000 0 0x1000>;
+		reg-names = "subsys", "port0", "port1";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pciesys CLK_PCIE_P0_MAC_EN>,
+			 <&pciesys CLK_PCIE_P1_MAC_EN>,
+			 <&pciesys CLK_PCIE_P0_AHB_EN>,
+			 <&pciesys CLK_PCIE_P1_AHB_EN>,
+			 <&pciesys CLK_PCIE_P0_AUX_EN>,
+			 <&pciesys CLK_PCIE_P1_AUX_EN>,
+			 <&pciesys CLK_PCIE_P0_AXI_EN>,
+			 <&pciesys CLK_PCIE_P1_AXI_EN>,
+			 <&pciesys CLK_PCIE_P0_OBFF_EN>,
+			 <&pciesys CLK_PCIE_P1_OBFF_EN>,
+			 <&pciesys CLK_PCIE_P0_PIPE_EN>,
+			 <&pciesys CLK_PCIE_P1_PIPE_EN>;
+		clock-names = "sys_ck0", "sys_ck1", "ahb_ck0", "ahb_ck1",
+			      "aux_ck0", "aux_ck1", "axi_ck0", "axi_ck1",
+			      "obff_ck0", "obff_ck1", "pipe_ck0", "pipe_ck1";
+		phys = <&pcie0_phy PHY_TYPE_PCIE>, <&pcie1_phy PHY_TYPE_PCIE>;
+		phy-names = "pcie-phy0", "pcie-phy1";
+		power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
+		bus-range = <0x00 0xff>;
+		ranges = <0x82000000 0 0x20000000  0x0 0x20000000  0 0x10000000>;
+
+		pcie0: pcie@0,0 {
+			device_type = "pci";
+			reg = <0x0000 0 0 0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges;
+			num-lanes = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+					<0 0 0 2 &pcie_intc0 1>,
+					<0 0 0 3 &pcie_intc0 2>,
+					<0 0 0 4 &pcie_intc0 3>;
+			pcie_intc0: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		pcie1: pcie@1,0 {
+			device_type = "pci";
+			reg = <0x0800 0 0 0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges;
+			num-lanes = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+					<0 0 0 2 &pcie_intc1 1>,
+					<0 0 0 3 &pcie_intc1 2>,
+					<0 0 0 4 &pcie_intc1 3>;
+			pcie_intc1: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+	};
-- 
2.6.4
