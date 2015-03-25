Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0111.outbound.protection.outlook.com ([157.56.110.111]:19271
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751916AbbCYHOw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Mar 2015 03:14:52 -0400
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Jingoo Han" <jg1.han@samsung.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>
Subject: [PATCH] arm/dts/ls1021a: Add PCIe dts node
Date: Wed, 25 Mar 2015 14:42:38 +0800
Message-ID: <1427265761-31828-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c70bb27..2f9556e 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -405,5 +405,53 @@
 			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
 		};
+
+		pcie@3400000 {
+			compatible = "fsl,ls1021a-pcie", "snps,dw-pcie";
+			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
+			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
+			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
+			interrupt-names = "intr", "pme";
+			fsl,pcie-scfg = <&scfg 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			num-lanes = <4>;
+			bus-range = <0x0 0xff>;
+			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
+				  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0000 0 0 1 &gic GIC_SPI 91  IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pcie@3500000 {
+			compatible = "fsl,ls1021a-pcie", "snps,dw-pcie";
+			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
+			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
+			interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "intr", "pme";
+			fsl,pcie-scfg = <&scfg 1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			num-lanes = <2>;
+			bus-range = <0x0 0xff>;
+			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */
+				  0x82000000 0x0 0x40000000 0x48 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0000 0 0 1 &gic GIC_SPI 92  IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 };
-- 
1.9.1

