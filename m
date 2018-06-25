Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0043.outbound.protection.outlook.com ([104.47.37.43]:32547
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753076AbeFYIbm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jun 2018 04:31:42 -0400
From: Alan Douglas <adouglas@cadence.com>
To: <bhelgaas@google.com>, <kishon@ti.com>, <lorenzo.pieralisi@arm.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, Alan Douglas <adouglas@cadence.com>
Subject: [PATCH 3/5] dt-bindings: PCI: cadence: Add DT bindings for optional PHYs
Date: Mon, 25 Jun 2018 09:30:51 +0100
Message-ID: <1529915453-4633-4-git-send-email-adouglas@cadence.com>
In-Reply-To: <1529915453-4633-1-git-send-email-adouglas@cadence.com>
References: <1529915453-4633-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Update DT documentation to include optional PHYs for cadence PCIe
host and endpoint controllers.

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt  |    5 +++++
 .../bindings/pci/cdns,cdns-pcie-host.txt           |    6 ++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
index 9a30523..4a0475e 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
@@ -9,6 +9,9 @@ Required properties:
 
 Optional properties:
 - max-functions: Maximum number of functions that can be configured (default 1).
+- phys: From PHY bindings: List of Generic PHY phandles. One per lane if more
+  than one in the list.  If only one PHY listed it must manage all lanes. 
+- phy-names:  List of names to identify the PHY.
 
 Example:
 
@@ -19,4 +22,6 @@ pcie@fc000000 {
 	reg-names = "reg", "mem";
 	cdns,max-outbound-regions = <16>;
 	max-functions = /bits/ 8 <8>;
+	phys = <&ep_phy0 &ep_phy1>;
+	phy-names = "pcie-lane0","pcie-lane1";
 };
diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
index 20a33f3..91de69c 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
@@ -24,6 +24,9 @@ Optional properties:
   translations (default 32)
 - vendor-id: The PCI vendor ID (16 bits, default is design dependent)
 - device-id: The PCI device ID (16 bits, default is design dependent)
+- phys: From PHY bindings: List of Generic PHY phandles. One per lane if more
+  than one in the list.  If only one PHY listed it must manage all lanes. 
+- phy-names:  List of names to identify the PHY.
 
 Example:
 
@@ -57,4 +60,7 @@ pcie@fb000000 {
 	interrupt-map-mask = <0x0 0x0 0x0  0x7>;
 
 	msi-parent = <&its_pci>;
+
+	phys = <&pcie_phy0>;
+	phy-names = "pcie-phy";
 };
-- 
1.7.1
