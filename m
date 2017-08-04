Return-Path: <linux-kernel-owner@vger.kernel.org>
From: <honghui.zhang@mediatek.com>
To: <bhelgaas@google.com>, <robh@kerenl.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>
CC: <honghui.zhang@mediatek.com>, <hongkun.cao@mediatek.com>,
        <youlin.pei@mediatek.com>, <yong.wu@mediatek.com>,
        <yt.shen@mediatek.com>, <sean.wang@mediatek.com>,
        <xinping.qian@mediatek.com>
Subject: [PATCH v3 4/6] dt-bindings: PCI: rename and cleanup MediaTek binding text
Date: Fri, 4 Aug 2017 20:06:40 +0800
Message-ID: <4209148bf2fa9bb981d44e8b0245141ccb25c23a.1501846816.git.honghui.zhang@mediatek.com>
In-Reply-To: <cover.1501846816.git.honghui.zhang@mediatek.com>
References: <cover.1501846816.git.honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Ryder Lee <ryder.lee@mediatek.com>

In order to accommodate other SoC generations, this patch updates filename
to make it more generic, regroups specific properties by SoCs, and removes
redundant descriptions.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 ...{mediatek,mt7623-pcie.txt => mediatek-pcie.txt} | 32 +++++++++++-----------
 1 file changed, 16 insertions(+), 16 deletions(-)
 rename Documentation/devicetree/bindings/pci/{mediatek,mt7623-pcie.txt => mediatek-pcie.txt} (90%)

diff --git a/Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
similarity index 90%
rename from Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt
rename to Documentation/devicetree/bindings/pci/mediatek-pcie.txt
index fe80dda..0fdcb15 100644
--- a/Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
@@ -1,18 +1,13 @@
-MediaTek Gen2 PCIe controller which is available on MT7623 series SoCs
-
-PCIe subsys supports single root complex (RC) with 3 Root Ports. Each root
-ports supports a Gen2 1-lane Link and has PIPE interface to PHY.
+MediaTek Gen2 PCIe controller
 
 Required properties:
-- compatible: Should contain "mediatek,mt7623-pcie".
+- compatible: Should contain one of the following strings:
+	"mediatek,mt2701-pcie"
+	"mediatek,mt7623-pcie"
 - device_type: Must be "pci"
 - reg: Base addresses and lengths of the PCIe controller.
 - #address-cells: Address representation for root ports (must be 3)
 - #size-cells: Size representation for root ports (must be 2)
-- #interrupt-cells: Size representation for interrupts (must be 1)
-- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
-  Please refer to the standard PCI bus binding document for a more detailed
-  explanation.
 - clocks: Must contain an entry for each entry in clock-names.
   See ../clocks/clock-bindings.txt for details.
 - clock-names: Must include the following entries:
@@ -20,12 +15,6 @@ Required properties:
   - sys_ck0 :for clock of Port0
   - sys_ck1 :for clock of Port1
   - sys_ck2 :for clock of Port2
-- resets: Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names: Must include the following entries:
-  - pcie-rst0 :port0 reset
-  - pcie-rst1 :port1 reset
-  - pcie-rst2 :port2 reset
 - phys: List of PHY specifiers (used by generic PHY framework).
 - phy-names : Must be "pcie-phy0", "pcie-phy1", "pcie-phyN".. based on the
   number of PHYs as specified in *phys* property.
@@ -34,6 +23,16 @@ Required properties:
 - bus-range: Range of bus numbers associated with this controller.
 - ranges: Ranges for the PCI memory and I/O regions.
 
+Required properties for MT7623/MT2701:
+- #interrupt-cells: Size representation for interrupts (must be 1)
+- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
+  Please refer to the standard PCI bus binding document for a more detailed
+  explanation.
+- resets: Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names: Must be "pcie-rst0", "pcie-rst1", "pcie-rstN".. based on the
+  number of root ports.
+
 In addition, the device tree node must have sub-nodes describing each
 PCIe port interface, having the following mandatory properties:
 
@@ -85,7 +84,8 @@ Examples:
 			 <&hifsys MT2701_HIFSYS_PCIE1_RST>,
 			 <&hifsys MT2701_HIFSYS_PCIE2_RST>;
 		reset-names = "pcie-rst0", "pcie-rst1", "pcie-rst2";
-		phys = <&pcie0_phy>, <&pcie1_phy>, <&pcie2_phy>;
+		phys = <&pcie0_phy PHY_TYPE_PCIE>, <&pcie1_phy PHY_TYPE_PCIE>,
+		       <&pcie2_phy PHY_TYPE_PCIE>;
 		phy-names = "pcie-phy0", "pcie-phy1", "pcie-phy2";
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_HIF>;
 		bus-range = <0x00 0xff>;
-- 
2.6.4
