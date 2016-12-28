Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:59040 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbcL1KfD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Dec 2016 05:35:03 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, kishon@ti.com, jingoohan1@gmail.com,
        vivek.gautam@codeaurora.org, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, cpgs@samsung.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 3/4] Documetation: binding: modify the exynos5440 pcie binding
Date: Wed, 28 Dec 2016 19:34:53 +0900
Message-id: <20161228103454.26467-4-jh80.chung@samsung.com>
In-reply-to: <20161228103454.26467-1-jh80.chung@samsung.com>
References: <20161228103454.26467-1-jh80.chung@samsung.com>
 <CGME20161228103455epcas5p2b3ea563efc00c776e77477ab3c778bb1@epcas5p2.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

According to using PHY framework, modified the exynos5440-pcie binding.
And use "config" property to follow the designware-pcie binding.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 .../bindings/pci/samsung,exynos5440-pcie.txt       | 29 +++++++++++++---------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt b/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
index 4f9d23d..51f6214 100644
--- a/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
@@ -5,10 +5,15 @@ and thus inherits all the common properties defined in designware-pcie.txt.
 
 Required properties:
 - compatible: "samsung,exynos5440-pcie"
-- reg: base addresses and lengths of the pcie controller,
-	the phy controller, additional register for the phy controller.
+- reg: base addresses and lengths of the pcie controller
 - interrupts: A list of interrupt outputs for level interrupt,
 	pulse interrupt, special interrupt.
+- phys: From PHY binding. Phandle for the Generic PHY.
+	Refer to Documentation/devicetree/bindings/phy/samsung-phy.txt
+- phy-names: Must be "pcie-phy".
+
+Other common properties refer to
+	Documentation/devicetree/binding/pci/designware-pcie.txt
 
 Example:
 
@@ -16,18 +21,18 @@ SoC specific DT Entry:
 
 	pcie@290000 {
 		compatible = "samsung,exynos5440-pcie", "snps,dw-pcie";
-		reg = <0x290000 0x1000
-			0x270000 0x1000
-			0x271000 0x40>;
+		reg = <0x290000 0x1000>, <0x40000000 0x100>;
+		reg-names = "elbi", "config";
 		interrupts = <0 20 0>, <0 21 0>, <0 22 0>;
 		clocks = <&clock 28>, <&clock 27>;
 		clock-names = "pcie", "pcie_bus";
 		#address-cells = <3>;
 		#size-cells = <2>;
 		device_type = "pci";
-		ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00001000   /* configuration space */
-			  0x81000000 0 0	  0x40001000 0 0x00010000   /* downstream I/O */
+		ranges = <0x81000000 0 0	  0x40001000 0 0x00010000   /* downstream I/O */
 			  0x82000000 0 0x40011000 0x40011000 0 0x1ffef000>; /* non-prefetchable memory */
+		phys = <&pcie_phy0>;
+		phy-names = "pcie-phy";
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
 		interrupt-map = <0 0 0 0 &gic GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
@@ -36,17 +41,17 @@ SoC specific DT Entry:
 
 	pcie@2a0000 {
 		compatible = "samsung,exynos5440-pcie", "snps,dw-pcie";
-		reg = <0x2a0000 0x1000
-			0x272000 0x1000
-			0x271040 0x40>;
+		reg = <0x2a0000 0x1000>, <0x60000000 0x1000>;
+		reg-names = "elbi", "config";
 		interrupts = <0 23 0>, <0 24 0>, <0 25 0>;
 		clocks = <&clock 29>, <&clock 27>;
 		clock-names = "pcie", "pcie_bus";
 		#address-cells = <3>;
 		#size-cells = <2>;
 		device_type = "pci";
-		ranges = <0x00000800 0 0x60000000 0x60000000 0 0x00001000   /* configuration space */
-			  0x81000000 0 0	  0x60001000 0 0x00010000   /* downstream I/O */
+		phys = <&pcie_phy1>;
+		phy-names = "pcie-phy";
+		ranges = <0x81000000 0 0	  0x60001000 0 0x00010000   /* downstream I/O */
 			  0x82000000 0 0x60011000 0x60011000 0 0x1ffef000>; /* non-prefetchable memory */
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
-- 
2.10.2

