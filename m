Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sh2.amlogic.com ([58.32.228.45]:7417 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbeH3MN6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Aug 2018 08:13:58 -0400
From: Hanjie Lin <hanjie.lin@amlogic.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Yue Wang <yue.wang@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: PCI: meson: add DT bindings for Amlogic Meson PCIe controller
Date: Thu, 30 Aug 2018 16:13:48 +0800
Message-ID: <1535616829-167936-2-git-send-email-hanjie.lin@amlogic.com>
In-Reply-To: <1535616829-167936-1-git-send-email-hanjie.lin@amlogic.com>
References: <1535616829-167936-1-git-send-email-hanjie.lin@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Yue Wang <yue.wang@amlogic.com>

The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
PCI core. This patch adds documentation for the DT bindings in Meson PCIe
controller.

Signed-off-by: Yue Wang <yue.wang@amlogic.com>
Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
---
 .../devicetree/bindings/pci/amlogic,meson-pcie.txt | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
new file mode 100644
index 0000000..12b18f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
@@ -0,0 +1,70 @@
+Amlogic Meson AXG DWC PCIE SoC controller
+
+Amlogic Meson PCIe host controller is based on the Synopsys DesignWare PCI core.
+It shares common functions with the PCIe DesignWare core driver and
+inherits common properties defined in
+Documentation/devicetree/bindings/pci/designware-pci.txt.
+
+Additional properties are described here:
+
+Required properties:
+- compatible:
+	should contain "amlogic,axg-pcie" to identify the core.
+- reg:
+	should contain the configuration address space.
+- reg-names: Must be
+	- "elbi"	External local bus interface registers
+	- "cfg"		Meson specific registers
+	- "phy"		Meson PCIE PHY registers
+	- "config"	PCIe configuration space
+- reset-gpios: The GPIO to generate PCIe PERST# assert and deassert signal.
+- clocks: Must contain an entry for each entry in clock-names.
+- clock-names: Must include the following entries:
+	- "pclk"       PCIe GEN 100M PLL clock
+	- "port"       PCIe_x(A or B) RC clock gate
+	- "general"    PCIe Phy clock
+	- "mipi"       PCIe_x(A or B) 100M ref clock gate
+- resets: phandle to the reset lines.
+- reset-names: must contain "phy" "port" and "apb"
+       - "phy"         Share PHY reset
+       - "port"        Port A or B reset
+       - "apb"         Share APB reset
+- device_type:
+	should be "pci". As specified in designware-pcie.txt
+
+
+Example configuration:
+
+	pcie: pcie@f9800000 {
+			compatible = "amlogic,axg-pcie", "snps,dw-pcie";
+			reg = <0x0 0xf9800000 0x0 0x400000
+					0x0 0xff646000 0x0 0x2000
+					0x0 0xff644000 0x0 0x2000
+					0x0 0xf9f00000 0x0 0x100000>;
+			reg-names = "elbi", "cfg", "phy", "config";
+			reset-gpios = <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;
+			interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
+			bus-range = <0x0 0xff>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x82000000 0 0 0x0 0xf9c00000 0 0x00300000>;
+
+			clocks = <&clkc CLKID_USB
+					&clkc CLKID_MIPI_ENABLE
+					&clkc CLKID_PCIE_A
+					&clkc CLKID_PCIE_CML_EN0>;
+			clock-names = "general",
+					"mipi",
+					"pclk",
+					"port";
+			resets = <&reset RESET_PCIE_PHY>,
+				<&reset RESET_PCIE_A>,
+				<&reset RESET_PCIE_APB>;
+			reset-names = "phy",
+					"port",
+					"apb";
+	};
-- 
2.7.4
