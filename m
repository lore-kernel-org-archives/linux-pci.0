Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0111.outbound.protection.outlook.com ([207.46.100.111]:6905
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752688AbaIVLMu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Sep 2014 07:12:50 -0400
From: Richard Zhu <r65037@freescale.com>
To: <linux-pci-owner@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <shawn.guo@freescale.com>,
	<festevam@gmail.com>, <l.stach@pengutronix.de>,
	Richard Zhu <r65037@freescale.com>
Subject: [PATCH v1 2/4] PCI: imx6: update dts and binding for imx6sx pcie
Date: Mon, 22 Sep 2014 18:45:03 +0800
Message-ID: <1411382705-15301-3-git-send-email-r65037@freescale.com>
In-Reply-To: <1411382705-15301-1-git-send-email-r65037@freescale.com>
References: <1411382705-15301-1-git-send-email-r65037@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

- imx6sx pcie has its own power regulator.
add the pcie power suppy into dts and binding.
- enable pcie on imx6sx soc.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  4 ++-
 arch/arm/boot/dts/imx6sx-sdb.dts                   | 13 +++++++++
 arch/arm/boot/dts/imx6sx.dtsi                      | 33 +++++++++++++---------
 arch/arm/mach-imx/Kconfig                          |  1 +
 4 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 9455fd0..d3b5704 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -4,7 +4,7 @@ This PCIe host controller is based on the Synopsis Designware PCIe IP
 and thus inherits all the common properties defined in designware-pcie.txt.
 
 Required properties:
-- compatible: "fsl,imx6q-pcie"
+- compatible: "fsl,imx6q-pcie", "fsl,imx6sx-pcie"
 - reg: base addresse and length of the pcie controller
 - interrupts: A list of interrupt outputs of the controller. Must contain an
   entry for each entry in the interrupt-names property.
@@ -12,6 +12,7 @@ Required properties:
 	- "msi": The interrupt that is asserted when an MSI is received
 - clock-names: Must include the following additional entries:
 	- "pcie_phy"
+- regulator: regulator used by imx6sx pcie module.
 
 Example:
 
@@ -35,4 +36,5 @@ Example:
 		                <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clks 144>, <&clks 206>, <&clks 189>;
 		clock-names = "pcie", "pcie_bus", "pcie_phy";
+		pcie-supply = <&reg_pcie>;
 	};
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
index a3980d9..2976913 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -251,6 +251,13 @@
 	};
 };
 
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio2 0 0>;
+	status = "okay";
+};
+
 &ssi2 {
 	status = "okay";
 };
@@ -365,6 +372,12 @@
 			>;
 		};
 
+		pinctrl_pcie: pciegrp {
+			fsl,pins = <
+				MX6SX_PAD_ENET1_COL__GPIO2_IO_0 0x17059
+			>;
+		};
+
 		pinctrl_vcc_sd3: vccsd3grp {
 			fsl,pins = <
 				MX6SX_PAD_KEY_COL1__GPIO2_IO_11		0x17059
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index f4b9da6..4911160 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -689,9 +689,11 @@
 			};
 
 			gpc: gpc@020dc000 {
-				compatible = "fsl,imx6sx-gpc", "fsl,imx6q-gpc";
+				compatible = "fsl,imx6sx-gpc",
+					     "fsl,imx6q-gpc", "syscon";
 				reg = <0x020dc000 0x4000>;
 				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+				pcie-supply = <&reg_pcie>;
 			};
 
 			iomuxc: iomuxc@020e0000 {
@@ -1188,20 +1190,23 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-				  /* configuration space */
-			ranges = <0x00000800 0 0x08f00000 0x08f00000 0 0x00080000
-				  /* downstream I/O */
-				  0x81000000 0 0          0x08f80000 0 0x00010000
-				  /* non-prefetchable memory */
-				  0x82000000 0 0x08000000 0x08000000 0 0x00f00000>;
+			ranges = <0x00000800 0 0x01f00000 0x08f00000 0 0x00080000 /* configuration space */
+				  0x81000000 0 0          0x08f80000 0 0x00010000 /* downstream I/O */
+				  0x82000000 0 0x01000000 0x08000000 0 0x00f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
-			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clks IMX6SX_CLK_PCIE_REF_125M>,
-				 <&clks IMX6SX_CLK_PCIE_AXI>,
-				 <&clks IMX6SX_CLK_LVDS1_OUT>,
-				 <&clks IMX6SX_CLK_DISPLAY_AXI>;
-			clock-names = "pcie_ref_125m", "pcie_axi",
-				      "lvds_gate", "display_axi";
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 2 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 3 &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX6SX_CLK_PCIE_AXI>,
+				 <&clks IMX6SX_CLK_DISPLAY_AXI>,
+				 <&clks IMX6SX_CLK_LVDS1_OUT>;
+			clock-names = "pcie", "pcie_phy", "pcie_bus";
+			pcie-supply = <&reg_pcie>;
 			status = "disabled";
 		};
 	};
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index be9a51a..0a055f0 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -718,6 +718,7 @@ config SOC_IMX6SL
 
 config SOC_IMX6SX
 	bool "i.MX6 SoloX support"
+	select PCI_DOMAINS if PCI
 	select PINCTRL_IMX6SX
 	select SOC_IMX6
 
-- 
1.9.1

