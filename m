Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Marc Zyngier <marc.zyngier@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>, Ray Jui <rjui@broadcom.com>
Subject: [PATCH v5 5/5] ARM: dts: Enable MSI support for Broadcom Cygnus
Date: Fri, 4 Dec 2015 09:35:02 -0800
Message-ID: <1449250502-10679-6-git-send-email-rjui@broadcom.com>
In-Reply-To: <1449250502-10679-1-git-send-email-rjui@broadcom.com>
References: <1449250502-10679-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
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

