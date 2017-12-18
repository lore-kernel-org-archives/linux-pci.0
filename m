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
Subject: [PATCH v2 8/9] dt-bindings: PCI: cadence: Add DT bindings for Cadence PCIe endpoint controller
Date: Mon, 18 Dec 2017 19:16:08 +0100
Message-Id: <e3cba0ecfa9189153e7dd7589dd63814315b3d87.1513620412.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
References: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
References: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch documents the DT bindings for the Cadence PCIe controller
when configured in endpoint mode.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
---
 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt  | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
new file mode 100644
index 000000000000..fc41fee25e26
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
@@ -0,0 +1,23 @@
+* Cadence PCIe endpoint controller
+
+Required properties:
+- compatible: Should contain "cdns,cdns-pcie-ep" to identify the IP used.
+- reg: Should contain the controller register base address and AXI interface
+  region base address respectively.
+- reg-names: Must be "reg" and "mem" respectively.
+
+Optional properties:
+- cdns,max-outbound-regions: Set to maximum number of outbound regions
+  (default 32).
+- max-functions: Maximum number of functions that can be configured (default 1).
+
+Example:
+
+pcie@fc000000 {
+	compatible = "cdns,cdns-pcie-ep";
+	reg = <0x0 0xfc000000 0x0 0x01000000>,
+	      <0x0 0x80000000 0x0 0x40000000>;
+	reg-names = "reg", "mem";
+	cdns,max-outbound-regions = <16>;
+	max-functions = /bits/ 8 <8>;
+};
-- 
2.11.0
