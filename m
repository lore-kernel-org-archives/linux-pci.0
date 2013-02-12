Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:45981 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933376Ab3BLQ3w (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2013 11:29:52 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: [PATCH 27/32] arm: mvebu: add PCIe Device Tree informations for Armada XP
Date: Tue, 12 Feb 2013 17:29:01 +0100
Message-Id: <1360686546-24277-28-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
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
 arch/arm/boot/dts/armada-xp-mv78230.dtsi |   99 ++++++++++++++++++
 arch/arm/boot/dts/armada-xp-mv78260.dtsi |  114 ++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-mv78460.dtsi |  167 ++++++++++++++++++++++++++++++
 3 files changed, 380 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index e041f42..39344d1 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -70,5 +70,104 @@
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
+			pcie@0,0 {
+				device_type = "pciex";
+				reg = <0x0800 0 0xd0040000 0 0x2000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 58>;
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
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 59>;
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
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 60>;
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
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 61>;
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
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 99>;
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
index 9e23bd8..1b4db26 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -90,5 +90,119 @@
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
+			pcie@0,0 {
+				device_type = "pciex";
+				reg = <0x0800 0 0xd0040000 0 0x2000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 58>;
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
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 59>;
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
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 60>;
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
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 61>;
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
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 99>;
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
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 103>;
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
index 9659661..0673f77 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -105,5 +105,172 @@
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
+			pcie@0,0 {
+				device_type = "pciex";
+				reg = <0x0800 0 0xd0040000 0 0x2000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 58>;
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
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 59>;
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
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 60>;
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
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 61>;
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
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 62>;
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
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 63>;
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
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 64>;
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
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 65>;
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
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 99>;
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
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 103>;
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

