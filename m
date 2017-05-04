Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Ryder Lee <ryder.lee@mediatek.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 2/2] dt-bindings: pcie: Add documentation for Mediatek PCIe
Date: Thu, 4 May 2017 17:32:56 +0800
Message-ID: <1493890376-6713-3-git-send-email-ryder.lee@mediatek.com>
In-Reply-To: <1493890376-6713-1-git-send-email-ryder.lee@mediatek.com>
References: <1493890376-6713-1-git-send-email-ryder.lee@mediatek.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Red Hung <red.hung@mediatek.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ryder Lee <ryder.lee@mediatek.com>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Add documentation for PCIe host driver available in MT7623
series SoCs.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../bindings/pci/mediatek,mt7623-pcie.txt          | 149 +++++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt
new file mode 100644
index 0000000..9c5d5a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt
@@ -0,0 +1,149 @@
+Mediatek Gen2 PCIe controller which is available on MT7623 series SoCs
+
+PCIe subsys supports single root complex (RC) with 3 Root Ports. Each root
+ports supports a Gen2 1-lane Link and has PIPE interface to PHY.
+
+Required properties:
+- compatible: Should contain "mediatek,mt7623-pcie".
+- device_type: Must be "pci"
+- reg: Base addresses and lengths of the PCIe controller.
+- #address-cells: Address representation for root ports (must be 3)
+- #size-cells: Size representation for root ports (must be 2)
+- #interrupt-cells: Size representation for interrupts (must be 1)
+- interrupts: Three interrupt outputs of the controller. Must contain an
+  entry for each entry in the interrupt-names property.
+- interrupt-names: Must include the following names
+  - "pcie-int0"
+  - "pcie-int1"
+  - "pcie-int2"
+- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
+  Please refer to the standard PCI bus binding document for a more detailed
+  explanation.
+- clocks: Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names: Must include the following entries:
+  - free_ck :for reference clock of PCIe subsys
+  - sys_ck0 :for clock of Port0
+  - sys_ck1 :for clock of Port1
+  - sys_ck2 :for clock of Port2
+- resets: Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names: Must include the following entries:
+  - pcie-rst0 :port0 reset
+  - pcie-rst1 :port1 reset
+  - pcie-rst2 :port2 reset
+- phys: list of PHY specifiers (used by generic PHY framework).
+- phy-names : must be "pcie-phy0", "pcie-phy1", "pcie-phyN".. based on the
+  number of PHYs as specified in *phys* property.
+- power-domains: A phandle and power domain specifier pair to the power domain
+  which is responsible for collapsing and restoring power to the peripheral.
+- bus-range: Range of bus numbers associated with this controller.
+- ranges:
+  - The first three entries are expected to translate the addresses for the root
+    port registers, which are referenced by the assigned-addresses property of
+    the root port nodes (see below).
+  - The remaining entries setup the mapping for the standard I/O and memory
+	regions.
+  Please refer to the standard PCI bus binding document for a more detailed
+  explanation.
+
+In addition, the device tree node must have sub-nodes describing each
+PCIe port interface, having the following mandatory properties:
+
+Required properties:
+- device_type: Must be "pci"
+- assigned-addresses: Address and size of the port configuration registers
+- reg: Only the first four bytes are used to refer to the correct bus number
+  and device number.
+- #address-cells: Must be 3
+- #size-cells: Must be 2
+- #interrupt-cells: Must be 1
+- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
+  Please refer to the standard PCI bus binding document for a more detailed
+  explanation.
+- ranges: Sub-ranges distributed from the PCIe controller node. An empty
+  property is sufficient.
+- num-lanes: Number of lanes to use for this port.
+
+Examples:
+
+	hifsys: syscon@1a000000 {
+		compatible = "mediatek,mt7623-hifsys", "syscon";
+		reg = <0 0x1a000000 0 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
+	pcie: pcie-controller@1a140000 {
+		compatible = "mediatek,mt7623-pcie";
+		device_type = "pci";
+		reg = <0 0x1a140000 0 0x1000>; /* PCIe shared registers */
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 195 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "pcie-int0", "pcie-int1", "pcie-int2";
+		interrupt-map-mask = <0xf800 0 0 0>;
+		interrupt-map = <0x0000 0 0 0 &gic GIC_SPI 193 IRQ_TYPE_NONE>,
+				 <0x0800 0 0 0 &gic GIC_SPI 194 IRQ_TYPE_NONE>,
+			     <0x1000 0 0 0 &gic GIC_SPI 195 IRQ_TYPE_NONE>;
+		clocks = <&topckgen CLK_TOP_ETHIF_SEL>,
+			     <&hifsys CLK_HIFSYS_PCIE0>,
+				 <&hifsys CLK_HIFSYS_PCIE1>,
+				 <&hifsys CLK_HIFSYS_PCIE2>;
+		clock-names = "free_ck", "sys_ck0", "sys_ck1", "sys_ck2";
+		resets = <&hifsys MT2701_HIFSYS_PCIE0_RST>,
+			     <&hifsys MT2701_HIFSYS_PCIE1_RST>,
+			     <&hifsys MT2701_HIFSYS_PCIE2_RST>;
+		reset-names = "pcie-rst0", "pcie-rst1", "pcie-rst2";
+		phys = <&pcie0_phy>, <&pcie1_phy>, <&pcie2_phy>;
+		phy-names = "pcie-phy0", "pcie-phy1", "pcie-phy2";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_HIF>;
+		bus-range = <0x00 0xff>;
+		ranges = <0x82000000 0 0x1a142000 0 0x1a142000 0 0x1000 /* Port0 registers */
+			  0x82000000 0 0x1a143000 0 0x1a143000 0 0x1000 /* Port1 registers */
+			  0x82000000 0 0x1a144000 0 0x1a144000 0 0x1000 /* Port2 registers */
+			  0x81000000 0 0x1a160000 0 0x1a160000 0 0x00010000 /* I/O space */
+			  0x83000000 0 0x60000000 0 0x60000000 0 0x10000000>;	/* memory space */
+
+		pcie@1,0 {
+			device_type = "pci";
+			assigned-addresses = <0x82000000 0 0x1a142000 0 0x1000>;
+			reg = <0x0000 0 0 0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 193 IRQ_TYPE_NONE>;
+			ranges;
+			num-lanes = <1>;
+		};
+
+		pcie@2,0 {
+			device_type = "pci";
+			assigned-addresses = <0x82000800 0 0x1a143000 0 0x1000>;
+			reg = <0x0800 0 0 0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 194 IRQ_TYPE_NONE>;
+			ranges;
+			num-lanes = <1>;
+		};
+
+		pcie@3,0 {
+			device_type = "pci";
+			assigned-addresses = <0x82001000 0 0x1a144000 0 0x1000>;
+			reg = <0x1000 0 0 0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 195 IRQ_TYPE_NONE>;
+			ranges;
+			num-lanes = <1>;
+		};
+	};
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
