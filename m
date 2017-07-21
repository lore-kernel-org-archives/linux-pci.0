Return-Path: <linux-kernel-owner@vger.kernel.org>
From: <honghui.zhang@mediatek.com>
To: <bhelgaas@google.com>, <robh+dt@kerenl.org>,
        <matthias.bgg@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>
CC: <honghui.zhang@mediatek.com>, <hongkun.cao@mediatek.com>,
        <youlin.pei@mediatek.com>, <yong.wu@mediatek.com>,
        <yt.shen@mediatek.com>, <sean.wang@mediatek.com>,
        <xinping.qian@mediatek.com>
Subject: [PATCH 5/5] dt-bindings: PCI: add support for new generation controller
Date: Fri, 21 Jul 2017 10:32:47 +0800
Message-ID: <3b449a88bd2f57ee005674d0161192ee01167e5a.1500601172.git.honghui.zhang@mediatek.com>
In-Reply-To: <cover.1500601172.git.honghui.zhang@mediatek.com>
References: <cover.1500601172.git.honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Ryder Lee <ryder.lee@mediatek.com>

Add support for MediaTek new generation controller and update related
properities.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 .../devicetree/bindings/pci/mediatek-pcie.txt      | 84 ++++++++++++++++++++--
 1 file changed, 79 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
index 294f4a3..a1f3767 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
@@ -4,17 +4,27 @@ Required properties:
 - compatible: Should contain one of the following string:
 	"mediatek,mt7623-pcie"
 	"mediatek,mt2701-pcie"
+	"mediatek,generic-pcie-v2"
 - device_type: Must be "pci"
-- reg: Base addresses and lengths of the PCIe controller.
+- reg: Base addresses and lengths of the PICe subsys and root ports.
+- reg-names: Names of the above areas to use during resource look-up.
 - #address-cells: Address representation for root ports (must be 3)
 - #size-cells: Size representation for root ports (must be 2)
 - clocks: Must contain an entry for each entry in clock-names.
   See ../clocks/clock-bindings.txt for details.
 - clock-names: Must include the following entries:
   - free_ck :for reference clock of PCIe subsys
-  - sys_ck0 :for clock of Port0
-  - sys_ck1 :for clock of Port1
-  - sys_ck2 :for clock of Port2
+  - sys_ckN :transaction layer and data link layer clock
+  The "sys_ck" might be divided into the following parts in some v2 chips:
+    - ahb_ckN :AHB slave interface operating clock for CSR access and RC
+	       initiated MMIO access
+    - axi_ckN :application layer MMIO channel operating clock
+    - aux_ckN :pe2_mac_bridge and pe2_mac_core operating clock when
+	       pcie_mac_ck/pcie_pipe_ck is turned off
+    - obff_ckN :OBFF functional block operating clock
+    - pipe_ckN :pe2_mac_bridge and pe2_mac_core operating clock when
+		pcie_mac_ck/pcie_pipe_ck is turned off
+  where N starting from 0 to the maximum number of root ports.
 - phys: List of PHY specifiers (used by generic PHY framework).
 - phy-names : Must be "pcie-phy0", "pcie-phy1", "pcie-phyN".. based on the
   number of PHYs as specified in *phys* property.
@@ -33,6 +43,9 @@ Required properties for MT7623/MT2701:
 - reset-names: Must be "pcie-rst0", "pcie-rst1", "pcie-rstN".. based on the
   number of root ports.
 
+Required properties for mediatek generic-pcie-v2:
+-interrupts: A list of interrupt outputs of the controller.
+
 In addition, the device tree node must have sub-nodes describing each
 PCIe port interface, having the following mandatory properties:
 
@@ -50,7 +63,7 @@ Required properties:
   property is sufficient.
 - num-lanes: Number of lanes to use for this port.
 
-Examples:
+Examples for mt7623:
 
 	hifsys: syscon@1a000000 {
 		compatible = "mediatek,mt7623-hifsys",
@@ -68,6 +81,7 @@ Examples:
 		      <0 0x1a142000 0 0x1000>, /* Port0 registers */
 		      <0 0x1a143000 0 0x1000>, /* Port1 registers */
 		      <0 0x1a144000 0 0x1000>; /* Port2 registers */
+		reg-names = "subsys", "port0", "port1", "port2";
 		#address-cells = <3>;
 		#size-cells = <2>;
 		#interrupt-cells = <1>;
@@ -127,3 +141,63 @@ Examples:
 			num-lanes = <1>;
 		};
 	};
+
+Examples for mt2712:
+	pcie: pcie@0x11700000 {
+		compatible = "mediatek,generic-pcie-v2";
+		device_type = "pci";
+		reg = <0 0x11700000 0 0x1000>,
+		      <0 0x112FF000 0 0x1000>;
+		reg-names = "port0", "port1";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&pericfg CLK_PERI_PCIE0>,
+			 <&pericfg CLK_PERI_PCIE1>,
+			 <&topckgen CLK_TOP_PE2_MAC_P0_SEL>,
+			 <&topckgen CLK_TOP_PE2_MAC_P1_SEL>;
+		clock-names = "sys_ck0", "sys_ck1", "ahb0", "ahb1";
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
