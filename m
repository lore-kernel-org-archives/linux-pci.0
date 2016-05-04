Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:33421 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbcEDLyh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2016 07:54:37 -0400
From: Niklas Cassel <niklas.cassel@axis.com>
To: <niklass@axis.com>, <jespern@axis.com>, <robh+dt@kernel.org>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>
CC: <linux-arm-kernel@axis.com>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: pci: add DT binding for Axis ARTPEC-6 PCIe controller
Date: Wed, 4 May 2016 13:54:17 +0200
Message-ID: <1462362857-27481-1-git-send-email-niklass@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Niklas Cassel <niklas.cassel@axis.com>

This commit adds the Device Tree binding documentation that allows to
describe the PCIe controller found in the Axis ARTPEC-6 SoC.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 .../devicetree/bindings/pci/axis,artpec6-pcie.txt  | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
new file mode 100644
index 0000000..fdac2a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
@@ -0,0 +1,45 @@
+* Axis ARTPEC-6 PCIe interface
+
+This PCIe host controller is based on the Synopsis Designware PCIe IP
+and thus inherits all the common properties defined in designware-pcie.txt.
+
+Required properties:
+- compatible: "axis,artpec6-pcie", "snps,dw-pcie"
+- reg: base addresses and lengths of the pcie controller (DBI),
+	the phy controller, and configuration address space.
+- reg-names: Must include the following entries:
+	- "dbi"
+	- "phy"
+	- "config"
+- interrupts: A list of interrupt outputs of the controller. Must contain an
+  entry for each entry in the interrupt-names property.
+- interrupt-names: Must include the following entries:
+	- "msi": The interrupt that is asserted when an MSI is received
+- syscon: Should contain a link to the syscon device node.
+
+Example:
+
+	pcie@f8050000 {
+		compatible = "axis,artpec6-pcie", "snps,dw-pcie";
+		reg = <0xf8050000 0x2000
+		       0xf8040000 0x1000
+		       0xc0000000 0x1000>;
+		reg-names = "dbi", "phy", "config";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+			  /* downstream I/O */
+		ranges = <0x81000000 0 0	  0xc0001000 0 0x00010000
+			  /* non-prefetchable memory */
+			  0x82000000 0 0xc0011000 0xc0011000 0 0x1ffef000>;
+		num-lanes = <2>;
+		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "msi";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &intc GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+		                <0 0 0 2 &intc GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+		                <0 0 0 3 &intc GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+		                <0 0 0 4 &intc GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+		syscon = <&syscon>;
+	};
-- 
2.1.4

