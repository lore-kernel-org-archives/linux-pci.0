Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:52827 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966247AbdADMf3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2017 07:35:29 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, kishon@ti.com, jingoohan1@gmail.com,
        vivek.gautam@codeaurora.org, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, cpgs@samsung.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH V2 3/5] Documetation: binding: modify the exynos5440 pcie
 binding
Date: Wed, 04 Jan 2017 21:34:33 +0900
Message-id: <20170104123435.30740-4-jh80.chung@samsung.com>
In-reply-to: <20170104123435.30740-1-jh80.chung@samsung.com>
References: <20170104123435.30740-1-jh80.chung@samsung.com>
 <CGME20170104123436epcas1p1040f1e074748fabe58af52eb0b833713@epcas1p1.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

According to using PHY framework, updates the exynos5440-pcie binding.
For maintaining backward compatibility, leaves the current dt-binding.
(It should be deprecated.)

Recommends to use the Phy Framework and "config" property to follow
the designware-pcie binding.
If you use the old way, can see "mssing *config* reg space" message.
Because the getting configuration space address from range is old way.

NOTE: When use the "config" property, first name of 'reg-names' must be
set to "elbi". Otherwise driver can't maintain the backward capability.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
Changelog on V2:
- Describes more commit message
- Fixes the typos
- Adds the new example for using PHY framework
- Deprecated the old dt-binding description
- Removes 'phy-names'

 .../bindings/pci/samsung,exynos5440-pcie.txt       | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt b/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
index 4f9d23d..1d0af0e 100644
--- a/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
@@ -7,8 +7,19 @@ Required properties:
 - compatible: "samsung,exynos5440-pcie"
 - reg: base addresses and lengths of the pcie controller,
 	the phy controller, additional register for the phy controller.
+	(Registers for the phy controller are DEPRECATED.
+	 Use the PHY framework.)
+- reg-names : First name should be set to "elbi".
+	And use the "config" instead of getting the confgiruation address space
+	from "ranges".
+	NOTE: When use the "config" property, reg-names must be set.
 - interrupts: A list of interrupt outputs for level interrupt,
 	pulse interrupt, special interrupt.
+- phys: From PHY binding. Phandle for the Generic PHY.
+	Refer to Documentation/devicetree/bindings/phy/samsung-phy.txt
+
+Other common properties refer to
+	Documentation/devicetree/binding/pci/designware-pcie.txt
 
 Example:
 
@@ -54,6 +65,24 @@ SoC specific DT Entry:
 		num-lanes = <4>;
 	};
 
+With using PHY framework:
+	pcie_phy0: pcie-phy@270000 {
+		...
+		reg = <0x270000 0x1000>, <0x271000 0x40>;
+		regn-names = "phy", "block";
+		...
+	};
+
+	pcie@290000 {
+		...
+		reg = <0x290000 0x1000>, <0x40000000 0x1000>;
+		reg-names = "elbi", "config";
+		phys = <&pcie_phy0>;
+		ranges = <0x81000000 0 0	  0x60001000 0 0x00010000
+			  0x82000000 0 0x60011000 0x60011000 0 0x1ffef000>;
+		...
+	};
+
 Board specific DT Entry:
 
 	pcie@290000 {
-- 
2.10.2

