Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:36658 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752189AbdBMI0T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2017 03:26:19 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com, javier@osg.samsung.com, kgene@kernel.org,
        linux-samsung-soc@vger.kernel.org, cpgs@samsung.com,
        niyas.ahmed@samsung.com, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, kishon@ti.com,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        vivek.gautam@codeaurora.org, robh+dt@kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH V3 1/4] Documetation: samsung-phy: add the exynos-pcie-phy
 binding
Date: Mon, 13 Feb 2017 17:26:10 +0900
Message-id: <20170213082613.19628-2-jh80.chung@samsung.com>
In-reply-to: <20170213082613.19628-1-jh80.chung@samsung.com>
References: <20170213082613.19628-1-jh80.chung@samsung.com>
 <CGME20170213082615epcas5p21fa62201d4d610608e286fcfce97118d@epcas5p2.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adds the exynos-pcie-phy binding for Exynos PCIe PHY.
This is for using generic PHY framework.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changelog on V3:
- None

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
