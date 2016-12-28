Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:52468 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbcL1KfA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Dec 2016 05:35:00 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, kishon@ti.com, jingoohan1@gmail.com,
        vivek.gautam@codeaurora.org, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, cpgs@samsung.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 4/4] ARM: dts: exynos5440: support the phy-pcie node for pcie
Date: Wed, 28 Dec 2016 19:34:54 +0900
Message-id: <20161228103454.26467-5-jh80.chung@samsung.com>
In-reply-to: <20161228103454.26467-1-jh80.chung@samsung.com>
References: <20161228103454.26467-1-jh80.chung@samsung.com>
 <CGME20161228103455epcas5p2cd50c2389ac3dd49eecb3218ff1dbb16@epcas5p2.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add phy-pcie node for using Exynos5440 pcie.
And some properies are changed to generic usage.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 arch/arm/boot/dts/exynos5440.dtsi | 44 ++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 2a2e570..deb2504 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -290,11 +290,34 @@
 		clock-names = "usbhost";
 	};
 
+	pcie_phy0: pcie-phy@270000 {
+		#phy-cells = <0>;
+		compatible = "samsung,exynos5440-pcie-phy";
+		reg = <0x270000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		block@271000 {
+			reg = <0x271000 0x40>;
+		};
+	};
+
+	pcie_phy1: pcie-phy@272000 {
+		#phy-cells = <0>;
+		compatible = "samsung,exynos5440-pcie-phy";
+		reg = <0x272000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		block@271040 {
+			reg = <0x271040 0x40>;
+		};
+	};
+
 	pcie_0: pcie@290000 {
 		compatible = "samsung,exynos5440-pcie", "snps,dw-pcie";
-		reg = <0x290000 0x1000
-			0x270000 0x1000
-			0x271000 0x40>;
+		reg = <0x290000 0x1000>, <0x40000000 0x1000>;
+		reg-names = "elbi", "config";
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
@@ -303,8 +326,9 @@
 		#address-cells = <3>;
 		#size-cells = <2>;
 		device_type = "pci";
-		ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00001000   /* configuration space */
-			  0x81000000 0 0	  0x40001000 0 0x00010000   /* downstream I/O */
+		pyhs = <&pcie_phy0>;
+		phys = "pcie-phy";
+		ranges = <0x81000000 0 0	  0x40001000 0 0x00010000   /* downstream I/O */
 			  0x82000000 0 0x40011000 0x40011000 0 0x1ffef000>; /* non-prefetchable memory */
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
@@ -315,9 +339,8 @@
 
 	pcie_1: pcie@2a0000 {
 		compatible = "samsung,exynos5440-pcie", "snps,dw-pcie";
-		reg = <0x2a0000 0x1000
-			0x272000 0x1000
-			0x271040 0x40>;
+		reg = <0x2a0000 0x1000>, <0x60000000 0x1000>;
+		reg-names = "elbi", "config";
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
@@ -326,8 +349,9 @@
 		#address-cells = <3>;
 		#size-cells = <2>;
 		device_type = "pci";
-		ranges = <0x00000800 0 0x60000000 0x60000000 0 0x00001000   /* configuration space */
-			  0x81000000 0 0	  0x60001000 0 0x00010000   /* downstream I/O */
+		pyhs = <&pcie_phy1>;
+		phys = "pcie-phy";
+		ranges = <0x81000000 0 0	  0x60001000 0 0x00010000   /* downstream I/O */
 			  0x82000000 0 0x60011000 0x60011000 0 0x1ffef000>; /* non-prefetchable memory */
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
-- 
2.10.2

