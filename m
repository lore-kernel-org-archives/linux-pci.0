Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:33687 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab3C0SFN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2013 14:05:13 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: [RFC PATCHv1 4/5] arm: kirkwood: add SoC-level Device Tree data for PCIe interfaces
Date: Wed, 27 Mar 2013 19:05:03 +0100
Message-Id: <1364407504-13524-5-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1364407504-13524-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364407504-13524-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit adds Device Tree details to enable the PCIe interfaces on
Kirkwood.

Note: this commit is not correct. The 6281 Kirkwood has only one PCIe
interface, and the 6282 has two PCIe interfaces, so this Device Tree
change will require some modifications to take this into account.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood.dtsi |   49 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 2c738d9..3d2cb12 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -19,6 +19,7 @@
 	ocp@f1000000 {
 		compatible = "simple-bus";
 		ranges = <0x00000000 0xf1000000 0x4000000
+		          0xe0000000 0xe0000000 0x8100000 /* PCIE */
 		          0xf5000000 0xf5000000 0x0000400>;
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -201,5 +202,53 @@
 			clocks = <&gate_clk 4>;
 			status = "disabled";
 		};
+
+		pcie-controller {
+			compatible = "marvell,kirkwood-pcie";
+			status = "disabled";
+			device_type = "pci";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			bus-range = <0x00 0xff>;
+
+			ranges = <0x82000000 0 0x00040000 0x00040000 0 0x00002000   /* Port 0.0 registers */
+			          0x82000000 0 0x00044000 0x00044000 0 0x00002000   /* Port 1.0 registers */
+				  0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
+			          0x81000000 0 0          0xe8000000 0 0x00100000>; /* downstream I/O */
+
+			pcie@1,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0x00040000 0 0x2000>;
+				reg = <0x0800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &intc 9>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gate_clk 2>;
+				status = "disabled";
+			};
+
+			pcie@2,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82001000 0 0x00044000 0 0x2000>;
+				reg = <0x1000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &intc 10>;
+				marvell,pcie-port = <1>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gate_clk 18>;
+				status = "disabled";
+			};
+		};
 	};
 };
-- 
1.7.9.5

