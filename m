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
Subject: [PATCH 4/5] dt-bindings: PCI: cadence: Add DT bindings for Cadence PCIe endpoint controller
Date: Thu, 23 Nov 2017 16:01:49 +0100
Message-Id: <0a11e9742db04fd5b4bc08568b3ab5a056a0ef9d.1511439189.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
References: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
References: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch documents the DT bindings for the Cadence PCIe controller
when configured in endpoint mode.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
---
 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt    | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
new file mode 100644
index 000000000000..d4168d79cceb
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
@@ -0,0 +1,20 @@
+* Cadence PCIe endpoint controller
+
+Required properties:
+- compatible: should contain "cdns,cdns-pcie-ep" to identify the IP used.
+- reg: should contain the controller register base address and AXI interface
+  region base address respectively.
+- reg-names: Must be "reg" and "mem" respectively.
+
+Optional properties:
+- max-functions: maximum number of functions that can be configured.
+
+Example:
+
+	pci@fc000000 {
+		compatible = "cdns,cdns-pcie-ep";
+		reg = <0x0 0xfc000000 0x0 0x01000000>, /* Base Address */
+		      <0x0 0x80000000 0x0 0x40000000>; /* AXI region */
+		reg-names = "reg", "mem";
+		max-functions = /bits/ 8 <8>;
+	};
-- 
2.11.0
