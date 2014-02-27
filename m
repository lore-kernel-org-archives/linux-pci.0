Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55866 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535AbaB0Qlv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Feb 2014 11:41:51 -0500
From: Lucas Stach <l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	Richard Zhu <r65037@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de
Subject: [PATCH v3 1/3] PCI: designware: split samsung and fsl bindings
Date: Thu, 27 Feb 2014 17:41:43 +0100
Message-Id: <1393519305-15128-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The glue around the core designware IP is
significantly different between the Exynos and
i.MX, which is reflected in the DT bindings.

Note that this patch doesn't change any bindings,
but just alters the documentation to match reality
of deployed DTs and kernels.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 .../devicetree/bindings/pci/designware-pcie.txt    | 69 +--------------------
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     | 38 ++++++++++++
 .../bindings/pci/samsung,exynos5440-pcie.txt       | 70 ++++++++++++++++++++++
 3 files changed, 109 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index d6fae13ff062..8274c80fe874 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -1,15 +1,7 @@
 * Synopsys Designware PCIe interface
 
 Required properties:
-- compatible: should contain "snps,dw-pcie" to identify the
-	core, plus an identifier for the specific instance, such
-	as "samsung,exynos5440-pcie" or "fsl,imx6q-pcie".
-- reg: base addresses and lengths of the pcie controller,
-	the phy controller, additional register for the phy controller.
-- interrupts: interrupt values for level interrupt,
-	pulse interrupt, special interrupt.
-- clocks: from common clock binding: handle to pci clock.
-- clock-names: from common clock binding: should be "pcie" and "pcie_bus".
+- compatible: should contain "snps,dw-pcie" to identify the core.
 - #address-cells: set to <3>
 - #size-cells: set to <2>
 - device_type: set to "pci"
@@ -22,62 +14,3 @@ Required properties:
 
 Optional properties:
 - reset-gpio: gpio pin number of power good signal
-
-Optional properties for fsl,imx6q-pcie
-- power-on-gpio: gpio pin number of power-enable signal
-- wake-up-gpio: gpio pin number of incoming wakeup signal
-- disable-gpio: gpio pin number of outgoing rfkill/endpoint disable signal
-
-Example:
-
-SoC specific DT Entry:
-
-	pcie@290000 {
-		compatible = "samsung,exynos5440-pcie", "snps,dw-pcie";
-		reg = <0x290000 0x1000
-			0x270000 0x1000
-			0x271000 0x40>;
-		interrupts = <0 20 0>, <0 21 0>, <0 22 0>;
-		clocks = <&clock 28>, <&clock 27>;
-		clock-names = "pcie", "pcie_bus";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00001000   /* configuration space */
-			  0x81000000 0 0	  0x40001000 0 0x00010000   /* downstream I/O */
-			  0x82000000 0 0x40011000 0x40011000 0 0x1ffef000>; /* non-prefetchable memory */
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0x0 0 &gic 53>;
-		num-lanes = <4>;
-	};
-
-	pcie@2a0000 {
-		compatible = "samsung,exynos5440-pcie", "snps,dw-pcie";
-		reg = <0x2a0000 0x1000
-			0x272000 0x1000
-			0x271040 0x40>;
-		interrupts = <0 23 0>, <0 24 0>, <0 25 0>;
-		clocks = <&clock 29>, <&clock 27>;
-		clock-names = "pcie", "pcie_bus";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		ranges = <0x00000800 0 0x60000000 0x60000000 0 0x00001000   /* configuration space */
-			  0x81000000 0 0	  0x60001000 0 0x00010000   /* downstream I/O */
-			  0x82000000 0 0x60011000 0x60011000 0 0x1ffef000>; /* non-prefetchable memory */
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0x0 0 &gic 56>;
-		num-lanes = <4>;
-	};
-
-Board specific DT Entry:
-
-	pcie@290000 {
-		reset-gpio = <&pin_ctrl 5 0>;
-	};
-
-	pcie@2a0000 {
-		reset-gpio = <&pin_ctrl 22 0>;
-	};
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
new file mode 100644
index 000000000000..aade8d29314c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -0,0 +1,38 @@
+* Freescale i.MX6 PCIe interface
+
+This PCIe host controller is based on the Synopsis Designware PCIe IP
+and thus inherits all the common properties defined in designware-pcie.txt.
+
+Required properties:
+- compatible: "fsl,imx6q-pcie"
+- reg: base addresse and length of the pcie controller
+- interrupts: Must contain interrupt handle for controller INTA output.
+- clocks: Must contain an entry for each entry in clock-names.
+	See ../clocks/clock-bindings.txt for details.
+- clock-names: Must include the following entries: 
+	- "pcie_ref_125m"
+	- "sata_ref_100m"
+	- "lvds_gate"
+	- "pcie_axi"
+
+Optional properties:
+- power-on-gpio: gpio pin number of power-enable signal
+- wake-up-gpio:  gpio pin number of incoming wakeup signal
+- disable-gpio:  gpio pin number of outgoing rfkill/endpoint disable signal
+
+Example:
+
+	pcie@0x01000000 {
+		compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
+		reg = <0x01ffc000 0x4000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x00000800 0 0x01f00000 0x01f00000 0 0x00080000
+			  0x81000000 0 0          0x01f80000 0 0x00010000
+			  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>;
+		num-lanes = <1>;
+		interrupts = <0 123 0x04>;
+		clocks = <&clks 189>, <&clks 187>, <&clks 206>, <&clks 144>;
+		clock-names = "pcie_ref_125m", "sata_ref_100m", "lvds_gate", "pcie_axi";
+	};
diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt b/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
new file mode 100644
index 000000000000..47e862126c05
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
@@ -0,0 +1,70 @@
+* Samsung Exynos 5440 PCIe interface
+
+This PCIe host controller is based on the Synopsis Designware PCIe IP
+and thus inherits all the common properties defined in designware-pcie.txt.
+
+Required properties:
+- compatible: "samsung,exynos5440-pcie"
+- reg: base addresses and lengths of the pcie controller,
+	the phy controller, additional register for the phy controller.
+- interrupts: A list of interrupt outputs for level interrupt,
+	pulse interrupt, special interrupt.
+- clocks: Must contain an entry for each entry in clock-names.
+	See ../clocks/clock-bindings.txt for details.
+- clock-names: Must include the following entries: 
+	- "pcie"
+	- "pcie_bus"
+
+Example:
+
+SoC specific DT Entry:
+
+	pcie@290000 {
+		compatible = "samsung,exynos5440-pcie", "snps,dw-pcie";
+		reg = <0x290000 0x1000
+			0x270000 0x1000
+			0x271000 0x40>;
+		interrupts = <0 20 0>, <0 21 0>, <0 22 0>;
+		clocks = <&clock 28>, <&clock 27>;
+		clock-names = "pcie", "pcie_bus";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00001000   /* configuration space */
+			  0x81000000 0 0	  0x40001000 0 0x00010000   /* downstream I/O */
+			  0x82000000 0 0x40011000 0x40011000 0 0x1ffef000>; /* non-prefetchable memory */
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0x0 0 &gic 53>;
+		num-lanes = <4>;
+	};
+
+	pcie@2a0000 {
+		compatible = "samsung,exynos5440-pcie", "snps,dw-pcie";
+		reg = <0x2a0000 0x1000
+			0x272000 0x1000
+			0x271040 0x40>;
+		interrupts = <0 23 0>, <0 24 0>, <0 25 0>;
+		clocks = <&clock 29>, <&clock 27>;
+		clock-names = "pcie", "pcie_bus";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x00000800 0 0x60000000 0x60000000 0 0x00001000   /* configuration space */
+			  0x81000000 0 0	  0x60001000 0 0x00010000   /* downstream I/O */
+			  0x82000000 0 0x60011000 0x60011000 0 0x1ffef000>; /* non-prefetchable memory */
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0x0 0 &gic 56>;
+		num-lanes = <4>;
+	};
+
+Board specific DT Entry:
+
+	pcie@290000 {
+		reset-gpio = <&pin_ctrl 5 0>;
+	};
+
+	pcie@2a0000 {
+		reset-gpio = <&pin_ctrl 22 0>;
+	};
-- 
1.8.5.3

