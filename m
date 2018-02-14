Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:65074 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S966631AbeBND2F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Feb 2018 22:28:05 -0500
From: Ryder Lee <ryder.lee@mediatek.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] dt-bindings: PCI: MediaTek: fix dtc warnings
Date: Wed, 14 Feb 2018 11:27:58 +0800
Message-ID: <9940757fe2889f46d0de214c5f277bf3c2074205.1518577579.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

dtc recently added PCI bus checks. Fix these warnings:

Warning (pci_bridge): Node /pcie@1a140000/pcie@0,0 missing bus-range for PCI bridge
Warning (pci_bridge): Node /pcie@1a140000/pcie@1,0 missing bus-range for PCI bridge
Warning (pci_bridge): Node /pcie@1a140000/pcie@2,0 missing bus-range for PCI bridge
Warning (unit_address_format): Failed prerequisite 'pci_bridge'
Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 Documentation/devicetree/bindings/pci/mediatek-pcie.txt | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
index 3a6ce55..20227a8 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
@@ -78,7 +78,7 @@ Examples for MT7623:
 		#reset-cells = <1>;
 	};
 
-	pcie: pcie-controller@1a140000 {
+	pcie: pcie@1a140000 {
 		compatible = "mediatek,mt7623-pcie";
 		device_type = "pci";
 		reg = <0 0x1a140000 0 0x1000>, /* PCIe shared registers */
@@ -111,7 +111,6 @@ Examples for MT7623:
 			  0x83000000 0 0x60000000 0 0x60000000 0 0x10000000>;	/* memory space */
 
 		pcie@0,0 {
-			device_type = "pci";
 			reg = <0x0000 0 0 0 0>;
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -123,7 +122,6 @@ Examples for MT7623:
 		};
 
 		pcie@1,0 {
-			device_type = "pci";
 			reg = <0x0800 0 0 0 0>;
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -135,7 +133,6 @@ Examples for MT7623:
 		};
 
 		pcie@2,0 {
-			device_type = "pci";
 			reg = <0x1000 0 0 0 0>;
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -148,6 +145,7 @@ Examples for MT7623:
 	};
 
 Examples for MT2712:
+
 	pcie: pcie@11700000 {
 		compatible = "mediatek,mt2712-pcie";
 		device_type = "pci";
@@ -169,7 +167,6 @@ Examples for MT2712:
 		ranges = <0x82000000 0 0x20000000  0x0 0x20000000  0 0x10000000>;
 
 		pcie0: pcie@0,0 {
-			device_type = "pci";
 			reg = <0x0000 0 0 0 0>;
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -189,7 +186,6 @@ Examples for MT2712:
 		};
 
 		pcie1: pcie@1,0 {
-			device_type = "pci";
 			reg = <0x0800 0 0 0 0>;
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -210,6 +206,7 @@ Examples for MT2712:
 	};
 
 Examples for MT7622:
+
 	pcie: pcie@1a140000 {
 		compatible = "mediatek,mt7622-pcie";
 		device_type = "pci";
@@ -243,7 +240,6 @@ Examples for MT7622:
 		ranges = <0x82000000 0 0x20000000  0x0 0x20000000  0 0x10000000>;
 
 		pcie0: pcie@0,0 {
-			device_type = "pci";
 			reg = <0x0000 0 0 0 0>;
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -263,7 +259,6 @@ Examples for MT7622:
 		};
 
 		pcie1: pcie@1,0 {
-			device_type = "pci";
 			reg = <0x0800 0 0 0 0>;
 			#address-cells = <3>;
 			#size-cells = <2>;
-- 
1.9.1
