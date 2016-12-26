Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:53148 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752564AbcLZFUk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Dec 2016 00:20:40 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, javier@osg.samsung.com, kishon@ti.com,
        will.deacon@arm.com, catalin.marinas@arm.com, cpgs@samsung.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC PATCH 6/6] ARM64: exynos: add the pcie node for TM2
Date: Mon, 26 Dec 2016 14:20:29 +0900
Message-id: <20161226052029.10552-7-jh80.chung@samsung.com>
In-reply-to: <20161226052029.10552-1-jh80.chung@samsung.com>
References: <20161226052029.10552-1-jh80.chung@samsung.com>
 <CGME20161226052031epcas1p43a300fe9e59c2af410c48861cd8554d1@epcas1p4.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add the Exxynos5433 pcie node for TM2.
This pcie device is used for supporting WiFi.

And some gpios are already requested from pinctrl. so it doesn't need to
initialize.
GPJ2-0 is used for supplying to WiFi PCIe chip.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi |  7 +++++++
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 11 +++++++++--
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 23 ++++++++++++++++++++++
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
index ad71247..3e8b728 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
@@ -183,6 +183,13 @@
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
+
+	pcie_wlanen: pcie-wlanen {
+		samsung,pins = "gpj2-0";
+		samsung,pin-function = <0>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <3>;
+	};
 };
 
 &pinctrl_finger {
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
index f21bdc2..c84a2ad 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
@@ -737,6 +737,15 @@
 	bus-width = <4>;
 };
 
+&pcie {
+	assigned-clocks = <&cmu_fsys CLK_MOUT_SCLK_PCIE_100_USER>,
+			<&cmu_top CLK_MOUT_SCLK_PCIE_100>;
+	assigned-clock-parents = <&cmu_top CLK_SCLK_PCIE_100_FSYS>,
+			<&cmu_top CLK_MOUT_BUS_PLL_USER>;
+	assigned-clock-rates = <0>, <100000000>;
+	status = "okay";
+};
+
 &pinctrl_alive {
 	pinctrl-names = "default";
 	pinctrl-0 = <&initial_alive>;
@@ -836,7 +845,6 @@
 	pinctrl-0 = <&initial_ese>;
 
 	initial_ese: initial-state {
-		PIN(IN, gpj2-0, DOWN, LV1);
 		PIN(IN, gpj2-1, DOWN, LV1);
 		PIN(IN, gpj2-2, DOWN, LV1);
 	};
@@ -851,7 +859,6 @@
 		PIN(IN, gpr3-1, DOWN, LV1);
 		PIN(IN, gpr3-2, DOWN, LV1);
 		PIN(IN, gpr3-3, DOWN, LV1);
-		PIN(IN, gpr3-7, NONE, LV1);
 	};
 };
 
diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 2a15f18..da287f4 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1457,6 +1457,29 @@
 			samsung,fsys-sysreg = <&syscon_fsys>;
 			status = "okay";
 		};
+
+		pcie: pcie@15700000 {
+			compatible = "samsung,exynos5433-pcie", "snps,dw-pcie";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "intr";
+			clocks = <&cmu_fsys CLK_PCIE>,
+			       <&cmu_fsys CLK_PCLK_PCIE_PHY>;
+			clock-names = "pcie", "pcie_bus";
+			num-lanes = <1>;
+			pinctrl-names = "default";
+			phys = <&pcie_phy>;
+			phy-names = "pcie-phy";
+			pinctrl-0 = <&pcie_bus &pcie_wlanen>;
+			reg = <0x156b0000 0x1000>, <0x15700000 0x1000>,
+			    <0x0c000000 0x1000>;
+			reg-names = "elbi", "dbi", "config";
+			ranges = <0x81000000 0 0	  0x0c001000 0 0x00010000
+				  0x82000000 0 0x0c011000 0x0c011000 0 0x3feefff>;
+			status = "disabled";
+		};
 	};
 
 	timer: timer {
-- 
2.10.2

