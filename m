Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:58363 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624Ab3A1S5S (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 13:57:18 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH v2 22/27] arm: mvebu: add PCIe Device Tree informations for Armada XP
Date: Mon, 28 Jan 2013 19:56:31 +0100
Message-Id: <1359399397-29729-23-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Armada XP SoCs have multiple PCIe interfaces. The MV78230 has 2
PCIe units (one 4x or quad 1x, the other 1x only), the MV78260 has 3
PCIe units (two 4x or quad 1x and one 4x/1x), the MV78460 has 4 PCIe
units (two 4x or quad 1x and two 4x/1x). We therefore add the
necessary Device Tree informations to make those PCIe interfaces
usable.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi |   92 ++++++++++++++++++
 arch/arm/boot/dts/armada-xp-mv78260.dtsi |  105 +++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-mv78460.dtsi |  150 ++++++++++++++++++++++++++++++
 3 files changed, 347 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index e041f42..6abb0ff 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -70,5 +70,97 @@
 			#interrupts-cells = <2>;
 			interrupts = <87>, <88>, <89>;
 		};
+
+		/*
+		 * MV78230 has 2 PCIe units Gen2.0: One unit can be
+		 * configured as x4 or quad x1 lanes. One unit is
+		 * x4/x1.
+		 */
+		pcie-controller {
+			compatible = "marvell,armada-370-xp-pcie";
+			status = "disabled";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+
+			bus-range = <0x00 0xff>;
+
+			ranges = <0x00000800 0 0xd0040000 0xd0040000 0 0x00002000   /* port 0.0 registers */
+			          0x00004800 0 0xd0042000 0xd0042000 0 0x00002000   /* port 2.0 registers */
+			          0x00001000 0 0xd0044000 0xd0044000 0 0x00002000   /* port 0.1 registers */
+			          0x00001800 0 0xd0048000 0xd0048000 0 0x00002000   /* port 0.2 registers */
+			          0x00002000 0 0xd004C000 0xd004C000 0 0x00002000   /* port 0.3 registers */
+				  0x81000000 0 0	  0xc0000000 0 0x00010000   /* downstream I/O */
+				  0x82000000 0 0	  0xc1000000 0 0x08000000>; /* non-prefetchable memory */
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 1>;
+			interrupt-map = <0x0800 0 0 1 &mpic 58 1
+				         0x1000 0 0 1 &mpic 59 1
+					 0x1800 0 0 1 &mpic 60 1
+					 0x2000 0 0 1 &mpic 61 1
+					 0x4800 0 0 1 &mpic 99 1>;
+
+			pcie@0,0 {
+				device_type = "pciex";
+				reg = <0x0800 0 0xd0040000 0 0x2000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <0>;
+				interrupts = <1>;
+				clocks = <&gateclk 5>;
+				status = "disabled";
+			};
+
+			pcie@0,1 {
+				device_type = "pciex";
+				reg = <0x1000 0 0xd0044000 0 0x2000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <1>;
+				interrupts = <1>;
+				clocks = <&gateclk 6>;
+				status = "disabled";
+			};
+
+			pcie@0,2 {
+				device_type = "pciex";
+				reg = <0x1800 0 0xd0048000 0 0x2000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <2>;
+				interrupts = <1>;
+				clocks = <&gateclk 7>;
+				status = "disabled";
+			};
+
+			pcie@0,3 {
+				device_type = "pciex";
+				reg = <0x2000 0 0xd004C000 0 0xC000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <3>;
+				interrupts = <1>;
+				clocks = <&gateclk 8>;
+				status = "disabled";
+			};
+
+			pcie@2,0 {
+				device_type = "pciex";
+				reg = <0x4800 0 0xd0042000 0 0x2000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				marvell,pcie-port = <2>;
+				marvell,pcie-lane = <0>;
+				interrupts = <1>;
+				clocks = <&gateclk 26>;
+				status = "disabled";
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 9e23bd8..ab8c593 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -90,5 +90,110 @@
 				clocks = <&gateclk 1>;
 				status = "disabled";
 		};
+
+		/*
+		 * MV78260 has 3 PCIe units Gen2.0: Two units can be
+		 * configured as x4 or quad x1 lanes. One unit is
+		 * x4/x1.
+		 */
+		pcie-controller {
+			compatible = "marvell,armada-370-xp-pcie";
+			status = "disabled";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			bus-range = <0x00 0xff>;
+
+			ranges = <0x00000800 0 0xd0040000 0xd0040000 0 0x00002000   /* port 0.0 registers */
+			          0x00004800 0 0xd0042000 0xd0042000 0 0x00002000   /* port 2.0 registers */
+			          0x00001000 0 0xd0044000 0xd0044000 0 0x00002000   /* port 0.1 registers */
+			          0x00001800 0 0xd0048000 0xd0048000 0 0x00002000   /* port 0.2 registers */
+			          0x00002000 0 0xd004C000 0xd004C000 0 0x00002000   /* port 0.3 registers */
+			          0x00005000 0 0xd0082000 0xd0082000 0 0x00002000   /* port 3.0 registers */
+				  0x81000000 0 0	  0xc0000000 0 0x00010000   /* downstream I/O */
+				  0x82000000 0 0	  0xc1000000 0 0x08000000>; /* non-prefetchable memory */
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 1>;
+			interrupt-map = <0x0800 0 0 1 &mpic 58 1
+				         0x1000 0 0 1 &mpic 59 1
+					 0x1800 0 0 1 &mpic 60 1
+					 0x2000 0 0 1 &mpic 61 1
+					 0x4800 0 0 1 &mpic 99 1
+					 0x5000 0 0 1 &mpic 103 1>;
+
+			pcie@0,0 {
+				device_type = "pciex";
+				reg = <0x0800 0 0xd0040000 0 0x2000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <0>;
+				interrupts = <1>;
+				clocks = <&gateclk 5>;
+				status = "disabled";
+			};
+
+			pcie@0,1 {
+				device_type = "pciex";
+				reg = <0x1000 0 0xd0044000 0 0x2000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <1>;
+				interrupts = <1>;
+				clocks = <&gateclk 6>;
+				status = "disabled";
+			};
+
+			pcie@0,2 {
+				device_type = "pciex";
+				reg = <0x1800 0 0xd0048000 0 0x2000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <2>;
+				interrupts = <1>;
+				clocks = <&gateclk 7>;
+				status = "disabled";
+			};
+
+			pcie@0,3 {
+				device_type = "pciex";
+				reg = <0x2000 0 0xd004C000 0 0xC000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <3>;
+				interrupts = <1>;
+				clocks = <&gateclk 8>;
+				status = "disabled";
+			};
+
+			pcie@2,0 {
+				device_type = "pciex";
+				reg = <0x4800 0 0xd0042000 0 0x2000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				marvell,pcie-port = <2>;
+				marvell,pcie-lane = <0>;
+				interrupts = <1>;
+				clocks = <&gateclk 26>;
+				status = "disabled";
+			};
+
+			pcie@3,0 {
+				device_type = "pciex";
+				reg = <0x5000 0 0xd0082000 0 0x2000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				marvell,pcie-port = <3>;
+				marvell,pcie-lane = <0>;
+				interrupts = <1>;
+				clocks = <&gateclk 27>;
+				status = "disabled";
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index 9659661..00c69aa 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -105,5 +105,155 @@
 				clocks = <&gateclk 1>;
 				status = "disabled";
 		};
+
+		/*
+		 * MV78460 has 4 PCIe units Gen2.0: Two units can be
+		 * configured as x4 or quad x1 lanes. Two units are
+		 * x4/x1.
+		 */
+		pcie-controller {
+			compatible = "marvell,armada-370-xp-pcie";
+			status = "disabled";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			bus-range = <0x00 0xff>;
+
+			ranges = <0x00000800 0 0xd0040000 0xd0040000 0 0x00002000   /* port 0.0 registers */
+			          0x00004800 0 0xd0042000 0xd0042000 0 0x00002000   /* port 2.0 registers */
+			          0x00001000 0 0xd0044000 0xd0044000 0 0x00002000   /* port 0.1 registers */
+			          0x00001800 0 0xd0048000 0xd0048000 0 0x00002000   /* port 0.2 registers */
+			          0x00002000 0 0xd004C000 0xd004C000 0 0x00002000   /* port 0.3 registers */
+				  0x00002800 0 0xd0080000 0xd0080000 0 0x00002000   /* port 1.0 registers */
+			          0x00005000 0 0xd0082000 0xd0082000 0 0x00002000   /* port 3.0 registers */
+				  0x00003000 0 0xd0084000 0xd0084000 0 0x00002000   /* port 1.1 registers */
+				  0x00003800 0 0xd0088000 0xd0088000 0 0x00002000   /* port 1.2 registers */
+				  0x00004000 0 0xd008C000 0xd008C000 0 0x00002000   /* port 1.3 registers */
+				  0x81000000 0 0	  0xc0000000 0 0x00100000   /* downstream I/O */
+				  0x82000000 0 0	  0xc1000000 0 0x08000000>; /* non-prefetchable memory */
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 1>;
+			interrupt-map = <0x0800 0 0 1 &mpic 58
+				         0x1000 0 0 1 &mpic 59
+					 0x1800 0 0 1 &mpic 60
+					 0x2000 0 0 1 &mpic 61
+					 0x2800 0 0 1 &mpic 62
+				         0x3000 0 0 1 &mpic 63
+					 0x3800 0 0 1 &mpic 64
+					 0x4000 0 0 1 &mpic 65
+					 0x4800 0 0 1 &mpic 99
+					 0x5000 0 0 1 &mpic 103>;
+
+			pcie@0,0 {
+				device_type = "pciex";
+				reg = <0x0800 0 0xd0040000 0 0x2000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 5>;
+				status = "disabled";
+			};
+
+			pcie@0,1 {
+				device_type = "pciex";
+				reg = <0x1000 0 0xd0044000 0 0x2000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <1>;
+				clocks = <&gateclk 6>;
+				status = "disabled";
+			};
+
+			pcie@0,2 {
+				device_type = "pciex";
+				reg = <0x1800 0 0xd0048000 0 0x2000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <2>;
+				clocks = <&gateclk 7>;
+				status = "disabled";
+			};
+
+			pcie@0,3 {
+				device_type = "pciex";
+				reg = <0x2000 0 0xd004C000 0 0xC000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <3>;
+				clocks = <&gateclk 8>;
+				status = "disabled";
+			};
+
+			pcie@1,0 {
+				device_type = "pciex";
+				reg = <0x2800 0 0xd0080000 0 0x2000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				marvell,pcie-port = <1>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 9>;
+				status = "disabled";
+			};
+
+			pcie@1,1 {
+				device_type = "pciex";
+				reg = <0x3000 0 0xd0084000 0 0x2000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				marvell,pcie-port = <1>;
+				marvell,pcie-lane = <1>;
+				clocks = <&gateclk 10>;
+				status = "disabled";
+			};
+
+			pcie@1,2 {
+				device_type = "pciex";
+				reg = <0x3800 0 0xd0088000 0 0x2000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				marvell,pcie-port = <1>;
+				marvell,pcie-lane = <2>;
+				clocks = <&gateclk 11>;
+				status = "disabled";
+			};
+
+			pcie@1,3 {
+				device_type = "pciex";
+				reg = <0x4000 0 0xd008C000 0 0x2000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				marvell,pcie-port = <1>;
+				marvell,pcie-lane = <3>;
+				clocks = <&gateclk 12>;
+				status = "disabled";
+			};
+			pcie@2,0 {
+				device_type = "pciex";
+				reg = <0x4800 0 0xd0042000 0 0x2000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				marvell,pcie-port = <2>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 26>;
+				status = "disabled";
+			};
+
+			pcie@3,0 {
+				device_type = "pciex";
+				reg = <0x5000 0 0xd0082000 0 0x2000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				marvell,pcie-port = <3>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 27>;
+				status = "disabled";
+			};
+		};
 	};
  };
-- 
1.7.9.5

