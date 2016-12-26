Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:53265 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbcLZFUf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Dec 2016 00:20:35 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, javier@osg.samsung.com, kishon@ti.com,
        will.deacon@arm.com, catalin.marinas@arm.com, cpgs@samsung.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC PATCH 2/6] Documetation: samsung-phy: add the exynos-pcie-phy
 binding
Date: Mon, 26 Dec 2016 14:20:25 +0900
Message-id: <20161226052029.10552-3-jh80.chung@samsung.com>
In-reply-to: <20161226052029.10552-1-jh80.chung@samsung.com>
References: <20161226052029.10552-1-jh80.chung@samsung.com>
 <CGME20161226052030epcas1p40f87c865223a9ad8cd0cd1d6e4d54b32@epcas1p4.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adds the exynos-pcie-phy binding for Exynos PCIe PHY.
This is for using generic PHY framework.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 .../devicetree/bindings/phy/samsung-phy.txt         | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/samsung-phy.txt b/Documentation/devicetree/bindings/phy/samsung-phy.txt
index 9872ba8..eb1085e 100644
--- a/Documentation/devicetree/bindings/phy/samsung-phy.txt
+++ b/Documentation/devicetree/bindings/phy/samsung-phy.txt
@@ -191,3 +191,24 @@ Example:
 		usbdrdphy0 = &usb3_phy0;
 		usbdrdphy1 = &usb3_phy1;
 	};
+
+Samsung Exynos SoC series PCIe PHY controller
+--------------------------------------------------
+Required properties:
+- compatible : Should be set to "samsung,exynos5433-pcie-phy"
+- #phy-cells : must be zero
+- reg : a list of registers usd by phy driver
+
+Optional properites:
+-samsung,pmureg-phandle	- handle to syscon used to control PMU registers
+-samsung,fsys-sysreg	- handle to syscon used to control the system registers
+
+Example:
+	pcie_phy: pcie-phy@15680000 {
+		#phy-cells = <0>;
+		compatible = "samsung,exynos5433-pcie-phy";
+		reg = <0x15680000 0x1000>;
+		samsung,pmureg-phandle = <&pmu_system_controller>;
+		samsung,fsys-sysreg = <&syscon_fsys>;
+		status = "okay";
+	};
-- 
2.10.2

