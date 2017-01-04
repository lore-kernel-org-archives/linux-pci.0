Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:40049 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966663AbdADMf5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2017 07:35:57 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, kishon@ti.com, jingoohan1@gmail.com,
        vivek.gautam@codeaurora.org, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, cpgs@samsung.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH V2 1/5] Documetation: samsung-phy: add the exynos-pcie-phy
 binding
Date: Wed, 04 Jan 2017 21:34:31 +0900
Message-id: <20170104123435.30740-2-jh80.chung@samsung.com>
In-reply-to: <20170104123435.30740-1-jh80.chung@samsung.com>
References: <20170104123435.30740-1-jh80.chung@samsung.com>
 <CGME20170104123436epcas1p1d3d840e4ade396a60ce690b09d486990@epcas1p1.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adds the exynos-pcie-phy binding for Exynos PCIe PHY.
This is for using generic PHY framework.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
Changelog on V2:
- Remove the child node.
- Add 2nd address to the parent reg prop.

 Documentation/devicetree/bindings/phy/samsung-phy.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/samsung-phy.txt b/Documentation/devicetree/bindings/phy/samsung-phy.txt
index 9872ba8..ab80bfe 100644
--- a/Documentation/devicetree/bindings/phy/samsung-phy.txt
+++ b/Documentation/devicetree/bindings/phy/samsung-phy.txt
@@ -191,3 +191,20 @@ Example:
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
+	- First is for phy register, second is for block register.
+- reg-names : Must be set to "phy" and "block".
+
+Example:
+	pcie_phy0: pcie-phy@270000 {
+		#phy-cells = <0>;
+		compatible = "samsung,exynos5440-pcie-phy";
+		reg = <0x270000 0x1000>, <0x271000 0x40>;
+		reg-names = "phy", "block";
+	};
-- 
2.10.2

