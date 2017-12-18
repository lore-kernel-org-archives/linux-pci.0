Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
To: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org
Cc: adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: [PATCH v2 5/9] dt-bindings: PCI: cadence: Add DT bindings for Cadence PCIe host controller
Date: Mon, 18 Dec 2017 19:16:05 +0100
Message-Id: <ee768eb717027e335d51313ef95bdd0399e54468.1513620412.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
References: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
References: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Scott Telford <stelford@cadence.com>

This patch adds documentation for the DT bindings of the Cadence PCIe
controller when configured in host (Root Complex) mode.

Signed-off-by: Scott Telford <stelford@cadence.com>
Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
---
 .../bindings/pci/cdns,cdns-pcie-host.txt           | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
new file mode 100644
index 000000000000..20a33f38f69d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
@@ -0,0 +1,60 @@
+* Cadence PCIe host controller
+
+This PCIe controller inherits the base properties defined in
+host-generic-pci.txt.
+
+Required properties:
+- compatible: Should contain "cdns,cdns-pcie-host" to identify the IP used.
+- reg: Should contain the controller register base address, PCIe configuration
+  window base address, and AXI interface region base address respectively.
+- reg-names: Must be "reg", "cfg" and "mem" respectively.
+- #address-cells: Set to <3>
+- #size-cells: Set to <2>
+- device_type: Set to "pci"
+- ranges: Ranges for the PCI memory and I/O regions
+- #interrupt-cells: Set to <1>
+- interrupt-map-mask and interrupt-map: Standard PCI properties to define the
+  mapping of the PCIe interface to interrupt numbers.
+
+Optional properties:
+- cdns,max-outbound-regions: Set to maximum number of outbound regions
+  (default 32)
+- cdns,no-bar-match-nbits: Set into the no BAR match register to configure the
+  number of least significant bits kept during inbound (PCIe -> AXI) address
+  translations (default 32)
+- vendor-id: The PCI vendor ID (16 bits, default is design dependent)
+- device-id: The PCI device ID (16 bits, default is design dependent)
+
+Example:
+
+pcie@fb000000 {
+	compatible = "cdns,cdns-pcie-host";
+	device_type = "pci";
+	#address-cells = <3>;
+	#size-cells = <2>;
+	bus-range = <0x0 0xff>;
+	linux,pci-domain = <0>;
+	cdns,max-outbound-regions = <16>;
+	cdns,no-bar-match-nbits = <32>;
+	vendor-id = /bits/ 16 <0x17cd>;
+	device-id = /bits/ 16 <0x0200>;
+
+	reg = <0x0 0xfb000000  0x0 0x01000000>,
+	      <0x0 0x41000000  0x0 0x00001000>,
+	      <0x0 0x40000000  0x0 0x04000000>;
+	reg-names = "reg", "cfg", "mem";
+
+	ranges = <0x02000000 0x0 0x42000000  0x0 0x42000000  0x0 0x1000000>,
+		 <0x01000000 0x0 0x43000000  0x0 0x43000000  0x0 0x0010000>;
+
+	#interrupt-cells = <0x1>;
+
+	interrupt-map = <0x0 0x0 0x0  0x1  &gic  0x0 0x0 0x0 14 0x1
+			 0x0 0x0 0x0  0x2  &gic  0x0 0x0 0x0 15 0x1
+			 0x0 0x0 0x0  0x3  &gic  0x0 0x0 0x0 16 0x1
+			 0x0 0x0 0x0  0x4  &gic  0x0 0x0 0x0 17 0x1>;
+
+	interrupt-map-mask = <0x0 0x0 0x0  0x7>;
+
+	msi-parent = <&its_pci>;
+};
-- 
2.11.0
