Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:35478 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933206AbcFJPyn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2016 11:54:43 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Hanna Hawa <hannah@marvell.com>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH v2 3/3] arm64: dts: marvell: Aardvark PCIe support for Armada 3700
Date: Fri, 10 Jun 2016 17:54:16 +0200
Message-Id: <1465574056-8787-4-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1465574056-8787-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1465574056-8787-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit adds the SoC-level description of the PCIe controller found
on the Marvell Armada 3700, and also enables this PCIe controller on the
development board for this SoC.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts |  5 +++++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi   | 25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index 86110a6..1372e9a6 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -76,3 +76,8 @@
 &usb3 {
 	status = "okay";
 };
+
+/* CON17 (PCIe) / CON12 (mini-PCIe) */
+&pcie0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 9e2efb8..8a9cae9 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -141,5 +141,30 @@
 				      <0x1d40000 0x40000>; /* GICR */
 			};
 		};
+
+		pcie0: pcie@d0070000 {
+			compatible = "marvell,armada-3700-pcie";
+			device_type = "pci";
+			status = "disabled";
+			reg = <0 0xd0070000 0 0x20000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x00 0xff>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <1>;
+			msi-parent = <&pcie0>;
+			msi-controller;
+			ranges = <0x82000000 0 0xe8000000   0 0xe8000000 0 0x1000000 /* Port 0 MEM */
+				  0x81000000 0 0xe9000000   0 0xe9000000 0 0x10000>; /* Port 0 IO*/
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc 0>,
+					<0 0 0 2 &pcie_intc 1>,
+					<0 0 0 3 &pcie_intc 2>,
+					<0 0 0 4 &pcie_intc 3>;
+			pcie_intc: interrupt-controller {
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
 	};
 };
-- 
2.7.4

