Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:60558 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab3C0Ok6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2013 10:40:58 -0400
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
Subject: [PATCHv7 11/17] arm: mvebu: add PCIe Device Tree informations for Armada XP
Date: Wed, 27 Mar 2013 15:40:28 +0100
Message-Id: <1364395234-11195-12-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com>
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
 arch/arm/boot/dts/armada-xp-mv78230.dtsi |  104 +++++++++++++++++
 arch/arm/boot/dts/armada-xp-mv78260.dtsi |  122 +++++++++++++++++++
 arch/arm/boot/dts/armada-xp-mv78460.dtsi |  188 ++++++++++++++++++++++++++++++
 3 files changed, 414 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index f56c405..c2c7845 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -76,5 +76,109 @@
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
+			compatible = "marvell,armada-xp-pcie";
+			status = "disabled";
+			device_type = "pci";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			bus-range = <0x00 0xff>;
+
+			ranges = <0x82000000 0 0xd0040000 0xd0040000 0 0x00002000   /* Port 0.0 registers */
+				  0x82000000 0 0xd0042000 0xd0042000 0 0x00002000   /* Port 2.0 registers */
+				  0x82000000 0 0xd0044000 0xd0044000 0 0x00002000   /* Port 0.1 registers */
+				  0x82000000 0 0xd0048000 0xd0048000 0 0x00002000   /* Port 0.2 registers */
+				  0x82000000 0 0xd004c000 0xd004c000 0 0x00002000   /* Port 0.3 registers */
+				  0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
+				  0x81000000 0 0	  0xe8000000 0 0x00100000>; /* downstream I/O */
+
+			pcie@1,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0xd0040000 0 0x2000>;
+				reg = <0x0800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 58>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 5>;
+				status = "disabled";
+			};
+
+			pcie@2,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0xd0044000 0 0x2000>;
+				reg = <0x1000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 59>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <1>;
+				clocks = <&gateclk 6>;
+				status = "disabled";
+			};
+
+			pcie@3,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0xd0048000 0 0x2000>;
+				reg = <0x1800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 60>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <2>;
+				clocks = <&gateclk 7>;
+				status = "disabled";
+			};
+
+			pcie@4,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0xd004c000 0 0x2000>;
+				reg = <0x2000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 61>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <3>;
+				clocks = <&gateclk 8>;
+				status = "disabled";
+			};
+
+			pcie@9,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0xd0042000 0 0x2000>;
+				reg = <0x4800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 99>;
+				marvell,pcie-port = <2>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 26>;
+				status = "disabled";
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index f8f2b78..885bf22 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -96,5 +96,127 @@
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
+			compatible = "marvell,armada-xp-pcie";
+			status = "disabled";
+			device_type = "pci";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			bus-range = <0x00 0xff>;
+
+			ranges = <0x82000000 0 0xd0040000 0xd0040000 0 0x00002000   /* Port 0.0 registers */
+				  0x82000000 0 0xd0042000 0xd0042000 0 0x00002000   /* Port 2.0 registers */
+				  0x82000000 0 0xd0044000 0xd0044000 0 0x00002000   /* Port 0.1 registers */
+				  0x82000000 0 0xd0048000 0xd0048000 0 0x00002000   /* Port 0.2 registers */
+				  0x82000000 0 0xd004c000 0xd004c000 0 0x00002000   /* Port 0.3 registers */
+				  0x82000000 0 0xd0080000 0xd0080000 0 0x00002000   /* Port 1.0 registers */
+				  0x82000000 0 0xd0082000 0xd0082000 0 0x00002000   /* Port 3.0 registers */
+				  0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
+				  0x81000000 0 0	  0xe8000000 0 0x00100000>; /* downstream I/O */
+
+			pcie@1,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0xd0040000 0 0x2000>;
+				reg = <0x0800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 58>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 5>;
+				status = "disabled";
+			};
+
+			pcie@2,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0xd0044000 0 0x2000>;
+				reg = <0x1000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 59>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <1>;
+				clocks = <&gateclk 6>;
+				status = "disabled";
+			};
+
+			pcie@3,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0xd0048000 0 0x2000>;
+				reg = <0x1800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 60>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <2>;
+				clocks = <&gateclk 7>;
+				status = "disabled";
+			};
+
+			pcie@4,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0xd004c000 0 0x2000>;
+				reg = <0x2000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 61>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <3>;
+				clocks = <&gateclk 8>;
+				status = "disabled";
+			};
+
+			pcie@9,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0xd0042000 0 0x2000>;
+				reg = <0x4800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 99>;
+				marvell,pcie-port = <2>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 26>;
+				status = "disabled";
+			};
+
+			pcie@10,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0xd0082000 0 0x2000>;
+				reg = <0x5000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
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
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index 936c25d..23a5ac4 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -111,5 +111,193 @@
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
+			compatible = "marvell,armada-xp-pcie";
+			status = "disabled";
+			device_type = "pci";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			bus-range = <0x00 0xff>;
+
+			ranges = <0x82000000 0 0xd0040000 0xd0040000 0 0x00002000   /* Port 0.0 registers */
+				  0x82000000 0 0xd0042000 0xd0042000 0 0x00002000   /* Port 2.0 registers */
+				  0x82000000 0 0xd0044000 0xd0044000 0 0x00002000   /* Port 0.1 registers */
+				  0x82000000 0 0xd0048000 0xd0048000 0 0x00002000   /* Port 0.2 registers */
+				  0x82000000 0 0xd004c000 0xd004c000 0 0x00002000   /* Port 0.3 registers */
+				  0x82000000 0 0xd0080000 0xd0080000 0 0x00002000   /* Port 1.0 registers */
+				  0x82000000 0 0xd0082000 0xd0082000 0 0x00002000   /* Port 3.0 registers */
+				  0x82000000 0 0xd0084000 0xd0084000 0 0x00002000   /* Port 1.1 registers */
+				  0x82000000 0 0xd0088000 0xd0088000 0 0x00002000   /* Port 1.2 registers */
+				  0x82000000 0 0xd008c000 0xd008c000 0 0x00002000   /* Port 1.3 registers */
+				  0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
+				  0x81000000 0 0	  0xe8000000 0 0x00100000>; /* downstream I/O */
+
+			pcie@1,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0xd0040000 0 0x2000>;
+				reg = <0x0800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 58>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 5>;
+				status = "disabled";
+			};
+
+			pcie@2,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82001000 0 0xd0044000 0 0x2000>;
+				reg = <0x1000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 59>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <1>;
+				clocks = <&gateclk 6>;
+				status = "disabled";
+			};
+
+			pcie@3,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82001800 0 0xd0048000 0 0x2000>;
+				reg = <0x1800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 60>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <2>;
+				clocks = <&gateclk 7>;
+				status = "disabled";
+			};
+
+			pcie@4,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82002000 0 0xd004c000 0 0x2000>;
+				reg = <0x2000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 61>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <3>;
+				clocks = <&gateclk 8>;
+				status = "disabled";
+			};
+
+			pcie@5,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82002800 0 0xd0080000 0 0x2000>;
+				reg = <0x2800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 62>;
+				marvell,pcie-port = <1>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 9>;
+				status = "disabled";
+			};
+
+			pcie@6,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82003000 0 0xd0084000 0 0x2000>;
+				reg = <0x3000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 63>;
+				marvell,pcie-port = <1>;
+				marvell,pcie-lane = <1>;
+				clocks = <&gateclk 10>;
+				status = "disabled";
+			};
+
+			pcie@7,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82003800 0 0xd0088000 0 0x2000>;
+				reg = <0x3800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 64>;
+				marvell,pcie-port = <1>;
+				marvell,pcie-lane = <2>;
+				clocks = <&gateclk 11>;
+				status = "disabled";
+			};
+
+			pcie@8,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82004000 0 0xd008c000 0 0x2000>;
+				reg = <0x4000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 65>;
+				marvell,pcie-port = <1>;
+				marvell,pcie-lane = <3>;
+				clocks = <&gateclk 12>;
+				status = "disabled";
+			};
+			pcie@9,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82004800 0 0xd0042000 0 0x2000>;
+				reg = <0x4800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 99>;
+				marvell,pcie-port = <2>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 26>;
+				status = "disabled";
+			};
+
+			pcie@10,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82005000 0 0xd0082000 0 0x2000>;
+				reg = <0x5000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
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

