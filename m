Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:43512 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752197AbcLZFUi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Dec 2016 00:20:38 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, javier@osg.samsung.com, kishon@ti.com,
        will.deacon@arm.com, catalin.marinas@arm.com, cpgs@samsung.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC PATCH 3/6] ARM64: dts: exynos5433: add the pcie_phy node for PCIe
Date: Mon, 26 Dec 2016 14:20:26 +0900
Message-id: <20161226052029.10552-4-jh80.chung@samsung.com>
In-reply-to: <20161226052029.10552-1-jh80.chung@samsung.com>
References: <20161226052029.10552-1-jh80.chung@samsung.com>
 <CGME20161226052031epcas5p451b1352d6c8c5205a69246c2994b9506@epcas5p4.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

To use the generic PHY framework, adds the pcie_phy node.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 64226d5..2a15f18 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -805,6 +805,11 @@
 			reg = <0x145f0000 0x1038>;
 		};
 
+		syscon_fsys: syscon@156f0000 {
+			compatible = "syscon";
+			reg = <0x156f0000 0x1044>;
+		};
+
 		gsc_0: video-scaler@13C00000 {
 			compatible = "samsung,exynos5433-gsc";
 			reg = <0x13c00000 0x1000>;
@@ -1443,6 +1448,15 @@
 				status = "disabled";
 			};
 		};
+
+		pcie_phy: pcie-phy@15680000 {
+			#phy-cells = <0>;
+			compatible = "samsung,exynos5433-pcie-phy";
+			reg = <0x15680000 0x1000>;
+			samsung,pmureg-phandle = <&pmu_system_controller>;
+			samsung,fsys-sysreg = <&syscon_fsys>;
+			status = "okay";
+		};
 	};
 
 	timer: timer {
-- 
2.10.2

