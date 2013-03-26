Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:54280 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446Ab3CZQwn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 12:52:43 -0400
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
Subject: [RFCv1 10/11] arm: mvebu: enable MSI support in DT
Date: Tue, 26 Mar 2013 17:52:25 +0100
Message-Id: <1364316746-8702-11-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that the Marvell EBU PCIe driver supports MSI, we can adjust the
Device Tree for the Armada 370 and Armada XP SoCs so that the PCIe
controller nodes point to the MSI interrupt controller using the
'msi-parent' property.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi        |    1 +
 arch/arm/boot/dts/armada-xp-mv78230.dtsi |    1 +
 arch/arm/boot/dts/armada-xp-mv78260.dtsi |    1 +
 arch/arm/boot/dts/armada-xp-mv78460.dtsi |    1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index a23a74f..e9cda70 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -161,6 +161,7 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 
+			msi-parent = <&msi>;
 			bus-range = <0x00 0xff>;
 
 			reg = <0xd0040000 0x2000>, <0xd0080000 0x2000>;
diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 4b05815..0e0c891 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -90,6 +90,7 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 
+			msi-parent = <&msi>;
 			bus-range = <0x00 0xff>;
 
 			reg = <0xd0040000 0x2000>, <0xd0042000 0x2000>,
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index ee6c269..1db9da0 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -110,6 +110,7 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 
+			msi-parent = <&msi>;
 			bus-range = <0x00 0xff>;
 
 			reg = <0xd0040000 0x2000>, <0xd0042000 0x2000>,
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index ba54990..1263269 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -125,6 +125,7 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 
+			msi-parent = <&msi>;
 			bus-range = <0x00 0xff>;
 
 			reg = <0xd0040000 0x2000>, <0xd0042000 0x2000>,
-- 
1.7.9.5

