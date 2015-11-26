Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:11020 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645AbbKZWhJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2015 17:37:09 -0500
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Marc Zyngier <marc.zyngier@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>, Ray Jui <rjui@broadcom.com>
Subject: [PATCH v3 5/5] ARM: dts: Enable MSI support for Broadcom Cygnus
Date: Thu, 26 Nov 2015 14:37:10 -0800
Message-ID: <1448577430-16428-6-git-send-email-rjui@broadcom.com>
In-Reply-To: <1448577430-16428-1-git-send-email-rjui@broadcom.com>
References: <1448577430-16428-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enable MSI support for Broadcom Cygnus platforms

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Pramod KUMAR <pramodku@broadcom.com>
Reviewed-by: Vikram Prakash <vikramp@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 2778533..789b519 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -162,6 +162,17 @@
 				  0x82000000 0 0x20000000 0x20000000 0 0x04000000>;
 
 			status = "disabled";
+
+			msi-parent = <&msi0>;
+			msi0: msi@18012000 {
+				compatible = "brcm,iproc-msi";
+				msi-controller;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 96 IRQ_TYPE_NONE>,
+					     <GIC_SPI 97 IRQ_TYPE_NONE>,
+					     <GIC_SPI 98 IRQ_TYPE_NONE>,
+					     <GIC_SPI 99 IRQ_TYPE_NONE>;
+			};
 		};
 
 		pcie1: pcie@18013000 {
@@ -183,6 +194,17 @@
 				  0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
 
 			status = "disabled";
+
+			msi-parent = <&msi1>;
+			msi1: msi@18013000 {
+				compatible = "brcm,iproc-msi";
+				msi-controller;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 102 IRQ_TYPE_NONE>,
+					     <GIC_SPI 103 IRQ_TYPE_NONE>,
+					     <GIC_SPI 104 IRQ_TYPE_NONE>,
+					     <GIC_SPI 105 IRQ_TYPE_NONE>;
+			};
 		};
 
 		uart0: serial@18020000 {
-- 
1.9.1

