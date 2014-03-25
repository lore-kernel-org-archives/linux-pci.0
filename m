Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:29327 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752800AbaCYQ44 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Mar 2014 12:56:56 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Phil Edworthy <phil.edworthy@renesas.com>
In-Reply-To: <1395766604-30926-1-git-send-email-phil.edworthy@renesas.com>
References: <1395766604-30926-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1395766604-30926-7-git-send-email-phil.edworthy@renesas.com>
Date: Tue, 25 Mar 2014 16:56:41 +0000
Subject: [PATCH v5 6/9] ARM: shmobile: Add PCIe device tree nodes for R8A7790
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds the device tree nodes for R8A7790

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v5:
 - Renesas SoCs compatible string has peripheral before device name
 - Add PCIe bus clock reference
 - Add additional interrupt bindings
 - Use dma-ranges property to specify inbound memory regions
---
 arch/arm/boot/dts/r8a7790-lager.dts | 10 ++++++++++
 arch/arm/boot/dts/r8a7790.dtsi      | 24 ++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index a55c5f8..bbbcb63 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -139,6 +139,16 @@
 		states = <3300000 1
 			  1800000 0>;
 	};
+
+	clocks {
+		/* External PCIe bus clock - not used */
+		pcie_bus_clk: pcie_bus_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "pcie_bus";
+		};
+	};
 };
 
 &extal_clk {
diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index df9ec61..dbcea57 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -821,4 +821,28 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	pcie: pcie@fe000000 {
+		compatible = "renesas,pcie-r8a7790";
+		reg = <0 0xfe000000 0 0x80000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000
+			  0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
+			  0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
+			  0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
+		/* Map all possible DDR as inbound ranges */
+		dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000
+			      0x43000000 1 0x80000000 1 0x80000000 0 0x80000000>;
+		interrupts = <0 116 IRQ_TYPE_LEVEL_HIGH
+			      0 117 IRQ_TYPE_LEVEL_HIGH
+			      0 118 IRQ_TYPE_LEVEL_HIGH>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic 0 116 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_PCIE>, <&pcie_bus_clk>;
+		clock-names = "pcie", "pcie_bus";
+		status = "disabled";
+	};
 };
-- 
1.9.0

