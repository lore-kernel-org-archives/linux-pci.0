Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>,
	Duc Dang <dhdang@apm.com>
Subject: [PATCH v8 1/4] documentation: dts: Add the device tree binding for APM X-Gene v1 PCIe MSI device tree node
Date: Fri, 22 May 2015 11:41:09 -0700
Message-Id: <4422f356934b17a2086889b642bde4d441814569.1432318289.git.dhdang@apm.com>
In-Reply-To: <cover.1432318289.git.dhdang@apm.com>
References: <cover.1432318289.git.dhdang@apm.com>
In-Reply-To: <cover.1432318289.git.dhdang@apm.com>
References: <20150520101605.205eee40@arm.com> <cover.1432318289.git.dhdang@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

X-Gene v1 PCIe MSI controller block provides PCIE MSI functionality for 5 X-Gene v1
PCIE ports

The driver for this binding is under 'drivers/pci/host/pci-xgene-msi.c'

Signed-off-by: Duc Dang <dhdang@apm.com>
Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
 .../devicetree/bindings/pci/xgene-pci-msi.txt      | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xgene-pci-msi.txt

diff --git a/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt b/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
new file mode 100644
index 0000000..36d881c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
@@ -0,0 +1,68 @@
+* AppliedMicro X-Gene v1 PCIe MSI controller
+
+Required properties:
+
+- compatible: should be "apm,xgene1-msi" to identify
+	      X-Gene v1 PCIe MSI controller block.
+- msi-controller: indicates that this is X-Gene v1 PCIe MSI controller node
+- reg: physical base address (0x79000000) and length (0x900000) for controller
+       registers. These registers include the MSI termination address and data
+       registers as well as the MSI interrupt status registers.
+- reg-names: not required
+- interrupts: A list of 16 interrupt outputs of the controller, starting from
+	      interrupt number 0x10 to 0x1f.
+- interrupt-names: not required
+
+Each PCIe node needs to have property msi-parent that points to msi controller node
+
+Examples:
+
+SoC DTSI:
+
+	+ MSI node:
+	msi@79000000 {
+		compatible = "apm,xgene1-msi";
+		msi-controller;
+		reg = <0x00 0x79000000 0x0 0x900000>;
+		interrupts = 	<0x0 0x10 0x4>
+				<0x0 0x11 0x4>
+				<0x0 0x12 0x4>
+				<0x0 0x13 0x4>
+				<0x0 0x14 0x4>
+				<0x0 0x15 0x4>
+				<0x0 0x16 0x4>
+				<0x0 0x17 0x4>
+				<0x0 0x18 0x4>
+				<0x0 0x19 0x4>
+				<0x0 0x1a 0x4>
+				<0x0 0x1b 0x4>
+				<0x0 0x1c 0x4>
+				<0x0 0x1d 0x4>
+				<0x0 0x1e 0x4>
+				<0x0 0x1f 0x4>;
+	};
+
+	+ PCIe controller node with msi-parent property pointing to MSI node:
+	pcie0: pcie@1f2b0000 {
+		status = "disabled";
+		device_type = "pci";
+		compatible = "apm,xgene-storm-pcie", "apm,xgene-pcie";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = < 0x00 0x1f2b0000 0x0 0x00010000   /* Controller registers */
+			0xe0 0xd0000000 0x0 0x00040000>; /* PCI config space */
+		reg-names = "csr", "cfg";
+		ranges = <0x01000000 0x00 0x00000000 0xe0 0x10000000 0x00 0x00010000   /* io */
+			  0x02000000 0x00 0x80000000 0xe1 0x80000000 0x00 0x80000000>; /* mem */
+		dma-ranges = <0x42000000 0x80 0x00000000 0x80 0x00000000 0x00 0x80000000
+			      0x42000000 0x00 0x00000000 0x00 0x00000000 0x80 0x00000000>;
+		interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+		interrupt-map = <0x0 0x0 0x0 0x1 &gic 0x0 0xc2 0x1
+				 0x0 0x0 0x0 0x2 &gic 0x0 0xc3 0x1
+				 0x0 0x0 0x0 0x3 &gic 0x0 0xc4 0x1
+				 0x0 0x0 0x0 0x4 &gic 0x0 0xc5 0x1>;
+		dma-coherent;
+		clocks = <&pcie0clk 0>;
+		msi-parent= <&msi>;
+	};
-- 
1.9.1

