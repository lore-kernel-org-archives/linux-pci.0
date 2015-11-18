Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Marc Zyngier <marc.zyngier@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>, Ray Jui <rjui@broadcom.com>
Subject: [PATCH 5/5] ARM: dts: Enable MSI support for Broadcom Cygnus
Date: Tue, 17 Nov 2015 16:31:55 -0800
Message-ID: <1447806715-30043-6-git-send-email-rjui@broadcom.com>
In-Reply-To: <1447806715-30043-1-git-send-email-rjui@broadcom.com>
References: <1447806715-30043-1-git-send-email-rjui@broadcom.com>
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
 arch/arm/boot/dts/bcm-cygnus.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 2778533..bae1ac2 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -162,6 +162,19 @@
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
+				brcm,num-eq-region = <1>;
+				brcm,num-msi-msg-region = <1>;
+			};
 		};
 
 		pcie1: pcie@18013000 {
@@ -183,6 +196,19 @@
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
+				brcm,num-eq-region = <1>;
+				brcm,num-msi-msg-region = <1>;
+			};
 		};
 
 		uart0: serial@18020000 {
-- 
1.9.1

