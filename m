Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:53265 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754047AbcLZFUm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Dec 2016 00:20:42 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, javier@osg.samsung.com, kishon@ti.com,
        will.deacon@arm.com, catalin.marinas@arm.com, cpgs@samsung.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC PATCH 5/6] Documentation: pci: add the exynos5433-pcie binding
Date: Mon, 26 Dec 2016 14:20:28 +0900
Message-id: <20161226052029.10552-6-jh80.chung@samsung.com>
In-reply-to: <20161226052029.10552-1-jh80.chung@samsung.com>
References: <20161226052029.10552-1-jh80.chung@samsung.com>
 <CGME20161226052031epcas5p4f151c41189f7b3811979ca1e10aab1be@epcas5p4.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 .../devicetree/bindings/pci/exynos5433-pcie.txt    | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/exynos5433-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/exynos5433-pcie.txt b/Documentation/devicetree/bindings/pci/exynos5433-pcie.txt
new file mode 100644
index 0000000..932a847
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/exynos5433-pcie.txt
@@ -0,0 +1,36 @@
+* Samsung Exynos5433 PCIe interface
+
+This PCIe host controller is based on the Synopsis Designware PCIe IP
+and thus inherits all the common properties defined in designware-pcie.txt.
+
+Required properties:
+- compatible: "samsung,exynos5433-pcie"
+- reg: base addresses and lengths of the pcie controller,
+	the phy controller, additional register for the phy controller.
+- reg-names: Must be "elbi", "phy" and "dbi" for each regs
+- interrupt-names: Must be "intr" for legacy interrupt pin.
+
+Other common properites refer to
+	Documentation/devicetree/binding/pci/designware-pcie.txt
+
+Example:
+
+	pcie: pcie@15700000 {
+		compatible ="samsung,exynos5433-pcie", "snps,dw-pcie";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "intr";
+		clocks = <&cmu_fsys CLK_PCIE>, <&cmu_fsys CLK_PCLK_PCIE_PHY>;
+		clock-names = "pcie", "pcie_bus";
+		num-lanes = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_bus>;
+		reg = <0x156b0000 0x1000>, <0x15680000 0x1000>,
+		    <0x15700000 0x1000>, <0x0c000000 0x1000>;
+		reg-names = "elbi", "phy", "dbi", "config";
+		ranges = <0x81000000 0 0	  0x0c001000 0 0x00010000
+			  0x82000000 0 0x0c011000 0x0c011000 0 0x3feefff>;
+		status = "disabled";
+	};
-- 
2.10.2

