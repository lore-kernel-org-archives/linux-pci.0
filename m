Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/2] dt-bindings: pci: add UniPhier PCIe host controller
 description
Date: Wed,  5 Sep 2018 11:32:10 +0900
Message-Id: <1536114731-28630-2-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1536114731-28630-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1536114731-28630-1-git-send-email-hayashi.kunihiko@socionext.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jassi Brar <jaswinder.singh@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Add DT bindings for PCIe controller implemented in UniPhier SoCs when
configured in Root Complex (host) mode. This controller is based on
the Designware PCIe Core.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../devicetree/bindings/pci/uniphier-pcie.txt      | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
new file mode 100644
index 0000000..ea63f78
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
@@ -0,0 +1,78 @@
+Socionext UniPhier PCI-express host controller bindings
+
+This describes the devicetree bindings for PCI-express host controller
+implemented on Socionext UniPhier SoCs.
+
+UniPhier PCI-express host controller is based on the Synopsys DesignWare
+PCI core. It shares common functions with the PCIe DesignWare core driver
+and inherits common properties defined in
+Documentation/devicetree/bindings/pci/designware-pcie.txt.
+
+Required properties:
+- compatible: Should be "socionext,uniphier-pcie".
+- reg: Specifies offset and length of the register set for the device.
+	According to the reg-names, appropriate register sets are required.
+- reg-names: Must include the following entries:
+    "dbi"    - controller configuration registers
+    "link"   - SoC-specific glue layer registers
+    "config" - PCIe configuration space
+- clocks: A phandle to the clock gate for PCIe glue layer including
+	the host controller.
+- resets: A phandle to the reset line for PCIe glue layer including
+	the host controller.
+- interrupts: A list of interrupt specifiers. According to the
+	interrupt-names, appropriate interrupts are required.
+- interrupt-names: Must include the following entries:
+    "dma"    - DMA interrupt
+    "msi"    - MSI interrupt
+    "intx"   - Legacy INTA/B/C/D interrupt
+
+Optional properties:
+- phys: A phandle to generic PCIe PHY. According to the phy-names, appropriate
+	phys are required.
+- phy-names: Must be "pcie-phy".
+
+Required sub-node:
+- interrupt-controller: Specifies interrupt controller for legacy PCI
+	interrupts. The node name isn't important.
+
+Required properties for interrupt-controller:
+- interrupt-controller: identifies the node as an interrupt controller.
+- #interrupt-cells: specifies the number of cells needed to encode an
+	interrupt source. The value must be 1.
+
+Example:
+
+	pcie: pcie@66000000 {
+		compatible = "socionext,uniphier-pcie", "snps,dw-pcie";
+		status = "disabled";
+		reg-names = "dbi", "link", "config";
+		reg = <0x66000000 0x1000>, <0x66010000 0x10000>,
+		      <0x2fff0000 0x10000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		clocks = <&sys_clk 24>;
+		resets = <&sys_rst 24>;
+		num-lanes = <1>;
+		num-viewport = <1>;
+		bus-range = <0x0 0xff>;
+		device_type = "pci";
+		ranges =
+		/* downstream I/O */
+			<0x81000000 0 0x00000000  0x2ffe0000  0 0x00010000
+		/* non-prefetchable memory */
+			 0x82000000 0 0x00000000  0x20000000  0 0x0ffe0000>;
+		#interrupt-cells = <1>;
+		interrupt-names = "dma", "msi", "intx";
+		interrupts = <0 224 4>, <0 225 4>, <0 226 4>;
+		interrupt-map-mask = <0 0 0  7>;
+		interrupt-map = <0 0 0  1  &pcie_intc 0>,	/* INTA */
+				<0 0 0  2  &pcie_intc 1>,	/* INTB */
+				<0 0 0  3  &pcie_intc 2>,	/* INTC */
+				<0 0 0  4  &pcie_intc 3>;	/* INTD */
+
+		pcie_intc: interrupt-controller {
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+	};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
