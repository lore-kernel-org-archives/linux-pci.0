Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0085.outbound.protection.outlook.com ([104.47.32.85]:59584
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751214AbeEVNdP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 May 2018 09:33:15 -0400
From: Alan Douglas <adouglas@cadence.com>
To: <bhelgaas@google.com>, <kishon@ti.com>,
        <lorenzo.pieralisi@arm.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <linux-kernel@vger.kernel.com>,
        <cyrille.pitchen@free-electrons.com>,
        "Alan Douglas" <adouglas@cadence.com>
Subject: [RESEND PATCH 3/4] dt-bindings: PCI: cadence: Add DT bindings for optional PHYs
Date: Tue, 22 May 2018 14:32:32 +0100
Message-ID: <1526995952-22031-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Update DT documentation to include optional PHYs for cadence PCIe
host and endpoint controllers.

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt   | 4 ++++
 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
index 9a305237..e40c635 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
@@ -9,6 +9,8 @@ Required properties:
 
 Optional properties:
 - max-functions: Maximum number of functions that can be configured (default 1).
+- phys: From PHY bindings: List of Generic PHY phandles.
+- phy-names:  List of names to identify the PHY.
 
 Example:
 
@@ -19,4 +21,6 @@ pcie@fc000000 {
 	reg-names = "reg", "mem";
 	cdns,max-outbound-regions = <16>;
 	max-functions = /bits/ 8 <8>;
+	phys = <&ep_phy0 &ep_phy1>;
+	phy-names = "pcie-lane0","pcie-lane1";
 };
diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
index 20a33f3..c0ca4c1 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
@@ -24,6 +24,8 @@ Optional properties:
   translations (default 32)
 - vendor-id: The PCI vendor ID (16 bits, default is design dependent)
 - device-id: The PCI device ID (16 bits, default is design dependent)
+- phys: From PHY bindings: List of Generic PHY phandles.
+- phy-names:  List of names to identify the PHY.
 
 Example:
 
-- 
2.2.2
