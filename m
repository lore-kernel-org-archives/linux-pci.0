Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:35420 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753558AbaCMJu2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Mar 2014 05:50:28 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Phil Edworthy <phil.edworthy@renesas.com>
In-Reply-To: <1394704208-7490-1-git-send-email-phil.edworthy@renesas.com>
References: <1394704208-7490-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1394704208-7490-8-git-send-email-phil.edworthy@renesas.com>
Date: Thu, 13 Mar 2014 09:50:06 +0000
Subject: [PATCH 7/9] ARM: shmobile: Add PCIe device tree nodes for R8A7791 Koelsch
 board
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds the device tree nodes for the R8A7791 Koelsch board

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts |    4 ++++
 arch/arm/boot/dts/r8a7791.dtsi        |   19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index e24fed9..17c953f 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -352,3 +352,7 @@
 		spi-cpha;
 	};
 };
+
+&pcie {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index ccfba57..915a5a6 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -836,4 +836,23 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	pcie: pcie@fe000000 {
+		compatible = "renesas,r8a7791-pcie";
+		reg = <0 0xfe000000 0 0x80000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000
+			  0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
+			  0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
+			  0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
+		interrupts = <0 116 IRQ_TYPE_LEVEL_HIGH>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic 0 116 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7791_CLK_PCIE>;
+		clock-names = "pcie";
+		status = "disabled";
+	};
 };
-- 
1.7.9.5

