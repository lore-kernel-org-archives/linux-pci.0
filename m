Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0083.outbound.protection.outlook.com ([104.47.41.83]:35878
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750747AbcIMExL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Sep 2016 00:53:11 -0400
From: Po Liu <po.liu@nxp.com>
To: <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        Rob Herring <robh@kernel.org>, Roy Zang <roy.zang@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Stuart Yoder <stuart.yoder@nxp.com>,
        Yang-Leo Li <leoyang.li@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Minghuan Lian <minghuan.lian@nxp.com>,
        Murali Karicheri <m-karicheri2@ti.com>, Po Liu <po.liu@nxp.com>
Subject: [PATCH v5 2/3] arm64/dts: add pcie aer interrupt-name property in the dts
Date: Tue, 13 Sep 2016 12:40:58 +0800
Message-ID: <1473741659-17618-2-git-send-email-po.liu@nxp.com>
In-Reply-To: <1473741659-17618-1-git-send-email-po.liu@nxp.com>
References: <1472625442-23309-2-git-send-email-po.liu@nxp.com>
 <1473741659-17618-1-git-send-email-po.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some platforms(NXP Layerscape for example) aer interrupt was not
MSI/MSI-X/INTx but using interrupt line independently. This patch
add a "aer" interrupt-names for aer interrupt.

With the interrupt-names "aer", code could probe aer interrupt line
for pcie root port, replace the aer interrupt service irq.

This is intend to fixup the Layerscape platforms which aer interrupt
was not MSI/MSI-X/INTx, but using interrupt line independently.

Signed-off-by: Po Liu <po.liu@nxp.com>
---
changes for v5:
	- Seperate arm and arm64 dts modification into two patches

 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 18 +++++++++---------
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 16 ++++++++--------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index e669fbd..654071d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -527,9 +527,9 @@
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 118 0x4>, /* controller interrupt */
-				     <0 117 0x4>; /* PME interrupt */
-			interrupt-names = "intr", "pme";
+			interrupts = <0 117 0x4>, /* PME interrupt */
+					 <0 118 0x4>; /* aer interrupt */
+			interrupt-names = "pme", "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -552,9 +552,9 @@
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 128 0x4>,
-				     <0 127 0x4>;
-			interrupt-names = "intr", "pme";
+			interrupts = <0 127 0x4>,
+					 <0 128 0x4>;
+			interrupt-names = "pme", "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -577,9 +577,9 @@
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 			       0x50 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 162 0x4>,
-				     <0 161 0x4>;
-			interrupt-names = "intr", "pme";
+			interrupts = <0 161 0x4>,
+					 <0 162 0x4>;
+			interrupt-names = "pme", "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index 21023a3..58844e8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -583,8 +583,8 @@
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x10 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 108 0x4>; /* Level high type */
-			interrupt-names = "intr";
+			interrupts = <0 108 0x4>; /* aer interrupt */
+			interrupt-names = "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -607,8 +607,8 @@
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 			       0x12 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 113 0x4>; /* Level high type */
-			interrupt-names = "intr";
+			interrupts = <0 113 0x4>; /* aer interrupt */
+			interrupt-names = "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -631,8 +631,8 @@
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 			       0x14 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 118 0x4>; /* Level high type */
-			interrupt-names = "intr";
+			interrupts = <0 118 0x4>; /* aer interrupt */
+			interrupt-names = "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -655,8 +655,8 @@
 			reg = <0x00 0x03700000 0x0 0x00100000   /* controller registers */
 			       0x16 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 123 0x4>; /* Level high type */
-			interrupt-names = "intr";
+			interrupts = <0 123 0x4>; /* aer interrupt */
+			interrupt-names = "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-- 
2.1.0.27.g96db324

