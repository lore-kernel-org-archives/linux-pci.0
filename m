Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0078.outbound.protection.outlook.com ([157.56.110.78]:31332
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751037AbbGaKPe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 31 Jul 2015 06:15:34 -0400
From: Ley Foon Tan <lftan@altera.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Ley Foon Tan <lftan@altera.com>, <lftan.linux@gmail.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 4/5] Documentation: dt-bindings: pci: altera pcie device tree binding
Date: Fri, 31 Jul 2015 18:15:14 +0800
Message-ID: <1438337715-22594-5-git-send-email-lftan@altera.com>
In-Reply-To: <1438337715-22594-1-git-send-email-lftan@altera.com>
References: <1438337715-22594-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds the bindings for Altera PCIe host controller driver and
Altera PCIe MSI driver.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 .../devicetree/bindings/pci/altera-pcie-msi.txt    | 27 ++++++++++++
 .../devicetree/bindings/pci/altera-pcie.txt        | 49 ++++++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
 create mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/altera-pcie-msi.txt b/Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
new file mode 100644
index 0000000..7f330c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
@@ -0,0 +1,27 @@
+* Altera PCIe MSI controller
+
+Required properties:
+- compatible:	should contain "altr,msi-1.0"
+- reg:		specifies the physical base address of the controller and
+		the length of the memory mapped region.
+- reg-names:	Must include the following entries:
+		"csr": CSR registers
+		"vector_slave": vectors region
+-interrupts:	specifies the interrupt source of the parent interrupt
+		controller. The format of the interrupt specifier depends on the
+		parent interrupt controller.
+- num-vectors:	Number of vectors, range 1 to 32.
+- msi-controller:	indicates that this is MSI controller node
+
+
+Example
+msi0: msi@0xFF200000 {
+	compatible = "altr,msi-1.0";
+	reg = <0xFF200000 0x00000010
+		0xFF200010 0x00000080>;
+	reg-names = "csr", "vector_slave";
+	interrupt-parent = <&hps_0_arm_gic_0>;
+	interrupts = <0 42 4>;
+	msi-controller = <1>;
+	num-vectors = <32>;
+};
diff --git a/Documentation/devicetree/bindings/pci/altera-pcie.txt b/Documentation/devicetree/bindings/pci/altera-pcie.txt
new file mode 100644
index 0000000..54c45f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/altera-pcie.txt
@@ -0,0 +1,49 @@
+* Altera PCIe controller
+
+Required properties:
+- compatible :	should contain "altr,pcie-root-port-1.0"
+- reg:		A list of physical base address and length for TXS and CRA.
+- reg-names:	Must include the following entries:
+		"Txs": TXS region
+		"Cra": Control register access region
+-interrupts:	specifies the interrupt source of the parent interrupt controller.
+		The format of the interrupt specifier depends on the parent interrupt
+		controller.
+- device_type:	must be "pci"
+- #address-cells:	set to <3>
+- #size-cells:	set to <2>
+- #interrupt-cells:	set to <1>
+- ranges:		Describes the translation of addresses for root ports and standard
+		PCI regions.
+- interrupt-map-mask and interrupt-map: standard PCI properties
+	to define the mapping of the PCIe interface to interrupt
+	numbers.
+
+Optional properties:
+- msi-parent:	Link to the hardware entity that serves as the MSI controller for this PCIe
+		controller.
+- bus-range:	PCI bus numbers covered
+
+Example
+	pcie_0: pcie@0xc00000000 {
+		compatible = "altr,pcie-root-port-1.0";
+		reg = <0xc0000000 0x20000000>,
+			<0xff220000 0x00004000>;
+		reg-names = "Txs", "Cra";
+		interrupt-parent = <&hps_0_arm_gic_0>;
+		interrupts = <0 40 4>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		bus-range = <0x0 0xFF>;
+		device_type = "pci";
+		msi-parent = <&msi_to_gic_gen_0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie_0 1>,
+			            <0 0 0 2 &pcie_0 2>,
+			            <0 0 0 3 &pcie_0 3>,
+			            <0 0 0 4 &pcie_0 4>;
+		ranges = <0x82000000 0x00000000 0xc0000000 0xc0000000 0x00000000 0x10000000
+			    0x82000000 0x00000000 0xd0000000 0xd0000000 0x00000000 0x10000000>;
+	};
-- 
1.8.2.1

