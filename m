Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:44331 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014Ab3FFQlq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2013 12:41:46 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>
Subject: [PATCH v2 8/8] arm: mvebu: link PCIe controllers to the MSI controller
Date: Thu,  6 Jun 2013 18:41:28 +0200
Message-Id: <1370536888-8871-9-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit adjusts the Armada 370 and Armada XP PCIe controllers
Device Tree informations to reference their MSI controller. In the
case of this platform, the MSI controller is implemented by the MPIC.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi        | 1 +
 arch/arm/boot/dts/armada-xp-mv78230.dtsi | 1 +
 arch/arm/boot/dts/armada-xp-mv78260.dtsi | 1 +
 arch/arm/boot/dts/armada-xp-mv78460.dtsi | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index aee2b18..3c4e6d7 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -178,6 +178,7 @@
 				#address-cells = <3>;
 				#size-cells = <2>;
 
+				msi-parent = <&mpic>;
 				bus-range = <0x00 0xff>;
 
 				reg = <0x40000 0x2000>, <0x80000 0x2000>;
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
index f4029f0..bc63783 100644
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

