Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:38997 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753028AbcC0JbU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Mar 2016 05:31:20 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Hanna Hawa <hannah@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Yehuda Yitschak <yehuday@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 1/2] dt-bindings: pci: add DT binding for Marvell Armada 7K/8K PCIe controller
Date: Sun, 27 Mar 2016 11:30:57 +0200
Message-Id: <1459071058-18328-2-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1459071058-18328-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1459071058-18328-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit adds the Device Tree binding documentation that allows to
describe the PCIe controller found in Marvell Armada 7K/8K SoCs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/pci/pci-armada8k.txt       | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-armada8k.txt

diff --git a/Documentation/devicetree/bindings/pci/pci-armada8k.txt b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
new file mode 100644
index 0000000..577de5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
@@ -0,0 +1,41 @@
+* Marvell Armada 7K/8K PCIe interface
+
+This PCIe host controller is based on the Synopsis Designware PCIe IP
+and thus inherits all the common properties defined in designware-pcie.txt.
+
+Required properties:
+- compatible: "marvell,armada8k-pcie"
+- reg: must contain two register regions
+   - the control register region
+   - the config space region
+- reg-names:
+   - "ctrl" for the control register region
+   - "config" for the config space region
+- interrupts: Interrupt specifier for the PCIe controler
+- clock-names: May contain the following entries:
+	- "main", for the main clock, shared by several PCIe ports
+	- "port", for the port clock
+
+Example:
+
+	pcie@f2600000 {
+		compatible = "marvell,armada8k-pcie", "snps,dw-pcie";
+		reg = <0 0xf2600000 0 0x10000>, <0 0xf6f00000 0 0x80000>;
+		reg-names = "ctrl", "config";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		dma-coherent;
+
+		bus-range = <0 0xff>;
+		ranges = <0x81000000 0 0xf9000000 0  0xf9000000 0 0x10000	/* downstream I/O */
+			  0x82000000 0 0xf6000000 0  0xf6000000 0 0xf00000>;	/* non-prefetchable memory */
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		num-lanes = <1>;
+		clocks = <&cpm_syscon0 1 14>, <&cpm_syscon0 1 13>;
+		clock-names = "main", "port";
+		status = "disabled";
+	};
-- 
2.6.4

