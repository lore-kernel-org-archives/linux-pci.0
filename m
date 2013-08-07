Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59127 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932347Ab3HGJeS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Aug 2013 05:34:18 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCHv7 13/13] ARM: mvebu: link PCIe controllers to the MSI controller
Date: Wed,  7 Aug 2013 11:32:34 +0200
Message-Id: <1375867954-2320-14-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1375867954-2320-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375867954-2320-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit adjusts the Armada 370 and Armada XP PCIe controllers
Device Tree informations to reference their MSI controller. In the
case of this platform, the MSI controller is implemented by the MPIC.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Daniel Price <daniel.price@gmail.com>
---
 arch/arm/boot/dts/armada-370.dtsi        | 1 +
 arch/arm/boot/dts/armada-xp-mv78230.dtsi | 1 +
 arch/arm/boot/dts/armada-xp-mv78260.dtsi | 1 +
 arch/arm/boot/dts/armada-xp-mv78460.dtsi | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index fa3dfc6..a60018d 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -178,6 +178,7 @@
 				#address-cells = <3>;
 				#size-cells = <2>;
 
+				msi-parent = <&mpic>;
 				bus-range = <0x00 0xff>;
 
 				ranges = <0x82000000 0 0x40000 0x40000 0 0x00002000   /* Port 0.0 registers */
diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index f8eaa38..4a9a305 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -91,6 +91,7 @@
 #address-cells = <3>;
 #size-cells = <2>;
 
+				msi-parent = <&mpic>;
 				bus-range = <0x00 0xff>;
 
 				ranges = <0x82000000 0 0x40000 0x40000 0 0x00002000   /* Port 0.0 registers */
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 2d9335d..dd23e96 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -111,6 +111,7 @@
 				#address-cells = <3>;
 				#size-cells = <2>;
 
+				msi-parent = <&mpic>;
 				bus-range = <0x00 0xff>;
 
 				ranges = <0x82000000 0 0x40000 0x40000 0 0x00002000   /* Port 0.0 registers */
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index c7b1f4d..77db2bc 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -127,6 +127,7 @@
 				#address-cells = <3>;
 				#size-cells = <2>;
 
+				msi-parent = <&mpic>;
 				bus-range = <0x00 0xff>;
 
 				ranges = <0x82000000 0 0x40000 0x40000 0 0x00002000   /* Port 0.0 registers */
-- 
1.8.1.2

