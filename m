Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0065.outbound.protection.outlook.com ([104.47.32.65]:63072
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751002AbeEVJIC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 May 2018 05:08:02 -0400
From: Alan Douglas <adouglas@cadence.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "cyrille.pitchen@free-electrons.com"
        <cyrille.pitchen@free-electrons.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: [PATCH 3/4] dt-bindings: PCI: cadence: Add DT bindings for optional
 PHYs
Date: Tue, 22 May 2018 09:08:01 +0000
Message-ID: <SN6PR07MB451213F202165D9733877828D8940@SN6PR07MB4512.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Alan Douglas <adouglas@cadence.com>

Update DT documentation to include optional PHYs for cadence PCIe
host and endpoint controllers.

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt   | 4 ++++
 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt b/=
Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
index 9a305237..e40c635 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
@@ -9,6 +9,8 @@ Required properties:
=20
 Optional properties:
 - max-functions: Maximum number of functions that can be configured (defau=
lt 1).
+- phys: From PHY bindings: List of Generic PHY phandles.
+- phy-names:  List of names to identify the PHY.
=20
 Example:
=20
@@ -19,4 +21,6 @@ pcie@fc000000 {
 	reg-names =3D "reg", "mem";
 	cdns,max-outbound-regions =3D <16>;
 	max-functions =3D /bits/ 8 <8>;
+	phys =3D <&ep_phy0 &ep_phy1>;
+	phy-names =3D "pcie-lane0","pcie-lane1";
 };
diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt =
b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
index 20a33f3..c0ca4c1 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
@@ -24,6 +24,8 @@ Optional properties:
   translations (default 32)
 - vendor-id: The PCI vendor ID (16 bits, default is design dependent)
 - device-id: The PCI device ID (16 bits, default is design dependent)
+- phys: From PHY bindings: List of Generic PHY phandles.
+- phy-names:  List of names to identify the PHY.
=20
 Example:
=20
--=20
2.2.2
