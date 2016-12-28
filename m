Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, kishon@ti.com, jingoohan1@gmail.com,
        vivek.gautam@codeaurora.org, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, cpgs@samsung.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/4] Documetation: samsung-phy: add the exynos-pcie-phy binding
Date: Wed, 28 Dec 2016 19:34:52 +0900
Message-id: <20161228103454.26467-3-jh80.chung@samsung.com>
In-reply-to: <20161228103454.26467-1-jh80.chung@samsung.com>
References: <20161228103454.26467-1-jh80.chung@samsung.com>
 <CGME20161228103455epcas5p2acc54945d70ac45b2ce2cd4f6ad4b875@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adds the exynos-pcie-phy binding for Exynos PCIe PHY.
This is for using generic PHY framework.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 .../devicetree/bindings/phy/samsung-phy.txt        | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/samsung-phy.txt b/Documentation/devicetree/bindings/phy/samsung-phy.txt
index 9872ba8..1cbc15f 100644
--- a/Documentation/devicetree/bindings/phy/samsung-phy.txt
+++ b/Documentation/devicetree/bindings/phy/samsung-phy.txt
@@ -191,3 +191,26 @@ Example:
 		usbdrdphy0 = &usb3_phy0;
 		usbdrdphy1 = &usb3_phy1;
 	};
+
+Samsung Exynos SoC series PCIe PHY controller
+--------------------------------------------------
+Required properties:
+- compatible : Should be set to "samsung,exynos5440-pcie-phy"
+- #phy-cells : Must be zero
+- reg : a register used by phy driver.
+
+Required properies for child node:
+- reg : a block register used by phy driver.
+
+Example:
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
-- 
2.10.2
