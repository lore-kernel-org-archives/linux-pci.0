Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:35717 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751722AbcF3Jcz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2016 05:32:55 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Hanna Hawa <hannah@marvell.com>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Marcin Wojtas <mw@semihalf.com>, Victor Gu <xigu@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH v3 1/3] dt-bindings: add DT binding for the Aardvark PCIe controller
Date: Thu, 30 Jun 2016 11:32:30 +0200
Message-Id: <1467279152-5717-2-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1467279152-5717-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1467279152-5717-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit adds the documentation for the Device Tree binding used to
describe the Aardvark PCIe controller, found on Marvell Armada 3700
ARM64 SoCs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/pci/aardvark-pci.txt       | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/aardvark-pci.txt

diff --git a/Documentation/devicetree/bindings/pci/aardvark-pci.txt b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
new file mode 100644
index 0000000..bbcd9f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
@@ -0,0 +1,56 @@
+Aardvark PCIe controller
+
+This PCIe controller is used on the Marvell Armada 3700 ARM64 SoC.
+
+The Device Tree node describing an Aardvark PCIe controller must
+contain the following properties:
+
+ - compatible: Should be "marvell,armada-3700-pcie"
+ - reg: range of registers for the PCIe controller
+ - interrupts: the interrupt line of the PCIe controller
+ - #address-cells: set to <3>
+ - #size-cells: set to <2>
+ - device_type: set to "pci"
+ - ranges: ranges for the PCI memory and I/O regions
+ - #interrupt-cells: set to <1>
+ - msi-controller: indicates that the PCIe controller can itself
+   handle MSI interrupts
+ - msi-parent: pointer to the MSI controller to be used
+ - interrupt-map-mask and interrupt-map: standard PCI properties to
+   define the mapping of the PCIe interface to interrupt numbers.
+ - bus-range: PCI bus numbers covered
+
+In addition, the Device Tree describing an Aardvark PCIe controller
+must include a sub-node that describes the legacy interrupt controller
+built into the PCIe controller. This sub-node must have the following
+properties:
+
+ - interrupt-controller
+ - #interrupt-cells: set to <1>
+
+Example:
+
+	pcie0: pcie@d0070000 {
+		compatible = "marvell,armada-3700-pcie";
+		device_type = "pci";
+		status = "disabled";
+		reg = <0 0xd0070000 0 0x20000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x00 0xff>;
+		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+		#interrupt-cells = <1>;
+		msi-controller;
+		msi-parent = <&pcie0>;
+		ranges = <0x82000000 0 0xe8000000   0 0xe8000000 0 0x1000000 /* Port 0 MEM */
+			  0x81000000 0 0xe9000000   0 0xe9000000 0 0x10000>; /* Port 0 IO*/
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie_intc 0>,
+				<0 0 0 2 &pcie_intc 1>,
+				<0 0 0 3 &pcie_intc 2>,
+				<0 0 0 4 &pcie_intc 3>;
+		pcie_intc: interrupt-controller {
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+	};
-- 
2.7.4

