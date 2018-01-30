Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:47810 "EHLO
        5.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754164AbeA3VKG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jan 2018 16:10:06 -0500
Received: from player168.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id 5B96197410
        for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2018 22:00:23 +0100 (CET)
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
To: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org
Cc: adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: [PATCH v6 10/11] dt-bindings: PCI: cadence: Add DT bindings for Cadence PCIe endpoint controller
Date: Tue, 30 Jan 2018 21:56:58 +0100
Message-Id: <ea57d2ffbf426d3fbaf5af8a90d6664d06fd617b.1517343502.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
References: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
References: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch documents the DT bindings for the Cadence PCIe controller
when configured in endpoint mode.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt  | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
new file mode 100644
index 000000000000..9a305237fa6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
@@ -0,0 +1,22 @@
+* Cadence PCIe endpoint controller
+
+Required properties:
+- compatible: Should contain "cdns,cdns-pcie-ep" to identify the IP used.
+- reg: Should contain the controller register base address and AXI interface
+  region base address respectively.
+- reg-names: Must be "reg" and "mem" respectively.
+- cdns,max-outbound-regions: Set to maximum number of outbound regions
+
+Optional properties:
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
