Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:51417 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933983AbaCUKdB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Mar 2014 06:33:01 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	devicetree@vger.kernel.org
In-Reply-To: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1395397968-6242-6-git-send-email-phil.edworthy@renesas.com>
Date: Fri, 21 Mar 2014 10:32:44 +0000
Subject: [PATCH v4 5/9] dt-bindings: pci: rcar pcie device tree bindings
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds the bindings for the rcar PCIE driver. The driver
resides under drivers/pci/host/pcie-rcar.c

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci.txt | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci.txt

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
new file mode 100644
index 0000000..0e219b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
@@ -0,0 +1,40 @@
+* Renesas RCar PCIe interface
+
+Required properties:
+- compatible: should contain one of the following
+	"renesas,r8a7779-pcie", "renesas,r8a7790-pcie", "renesas,r8a7791-pcie"
+- reg: base addresses and lengths of the pcie controller.
+- #address-cells: set to <3>
+- #size-cells: set to <2>
+- device_type: set to "pci"
+- ranges: ranges for the PCI memory and I/O regions
+- interrupts: interrupt values for MSI interrupt
+- #interrupt-cells: set to <1>
+- interrupt-map-mask and interrupt-map: standard PCI properties
+	to define the mapping of the PCIe interface to interrupt
+	numbers.
+- clocks: from common clock binding: handle to pci clock.
+- clock-names: from common clock binding: should be "pcie"
+
+Example:
+
+SoC specific DT Entry:
+
+	pcie: pcie@0x01000000 {
+		compatible = "renesas,r8a7790-pcie";
+		reg = <0 0xfe000000 0 0x80000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000
+			  0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
+			  0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
+			  0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
+		interrupts = <0 116 4>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic 0 116 4>;
+		clocks = <&mstp3_clks R8A7790_CLK_PCIE>;
+		clock-names = "pcie";
+		status = "disabled";
+	};
-- 
1.9.0

