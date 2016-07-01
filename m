Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:41413 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbcGAB1I (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2016 21:27:08 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	Doug Anderson <dianders@chromium.org>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 1/2] Documentation: bindings: add dt doc for Rockchip PCIe controller
Date: Fri,  1 Jul 2016 09:24:49 +0800
Message-Id: <1467336290-11282-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds a binding that describes the Rockchip PCIe controller
found on Rockchip SoCs PCIe interface.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v4:
- fix example of adding intermediate interrupt controller for pcie
  legacy interrrupt

Changes in v3:
- fix example dts code suggested by Rob and Marc
- remove driver's behaviour of regulator

Changes in v2:
- fix lots clk/reset stuff suggested by Heiko
- remove msi-parent and add msi-map suggested by Marc
- drop phy related stuff
- some others minor fixes

 .../devicetree/bindings/pci/rockchip-pcie.txt      | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
new file mode 100644
index 0000000..8092fc5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
@@ -0,0 +1,91 @@
+* Rockchip AXI PCIe Root Port Bridge DT description
+
+Required properties:
+- #address-cells: Address representation for root ports, set to <3>
+- #size-cells: Size representation for root ports, set to <2>
+- #interrupt-cells: specifies the number of cells needed to encode an
+		interrupt source. The value must be 1.
+- compatible: Should contain "rockchip,rk3399-pcie"
+- reg: Two register ranges as listed in the reg-names property
+- reg-names: Must include the following names
+	- "axi-base"
+	- "apb-base"
+- clocks: Must contain an entry for each entry in clock-names.
+		See ../clocks/clock-bindings.txt for details.
+- clock-names: Must include the following entries:
+	- "aclk"
+	- "aclk-perf"
+	- "hclk"
+	- "pm"
+- msi-map: Maps a Requester ID to an MSI controller and associated.
+		See ./pci-msi.txt
+- phys: From PHY bindings: Phandle for the Generic PHY for PCIe.
+- phy-names:  MUST be "pcie-phy".
+- interrupts: Three interrupt entries must be specified.
+- interrupt-names: Must include the following names
+	- "sys"
+	- "legacy"
+	- "client"
+- resets: Must contain five entries for each entry in reset-names.
+	   See ../reset/reset.txt for details.
+- reset-names: Must include the following names
+	- "core"
+	- "mgmt"
+	- "mgmt-sticky"
+	- "pipe"
+- pinctrl-names : The pin control state names
+- pinctrl-0: The "default" pinctrl state
+- interrupt-map-mask and interrupt-map: standard PCI properties
+- interrupt-controller: identifies the node as an interrupt controller
+
+Optional Property:
+- ep-gpios: contain the entry for pre-reset gpio
+- num-lanes: number of lanes to use
+- vpcie3v3-supply: The phandle to the 3.3v regulator to use for pcie.
+- vpcie1v8-supply: The phandle to the 1.8v regulator to use for pcie.
+- vpcie0v9-supply: The phandle to the 0.9v regulator to use for pcie.
+
+Example:
+
+pcie0: pcie@f8000000 {
+	compatible = "rockchip,rk3399-pcie";
+	#address-cells = <3>;
+	#size-cells = <2>;
+	clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
+		 <&cru PCLK_PCIE>, <&cru SCLK_PCIE_PM>;
+	clock-names = "aclk", "aclk-perf",
+		      "hclk", "pm";
+	bus-range = <0x0 0x1>;
+	interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "sys", "legacy", "client";
+	assigned-clocks = <&cru SCLK_PCIEPHY_REF>;
+	assigned-clock-parents = <&cru SCLK_PCIEPHY_REF100M>;
+	assigned-clock-rates = <100000000>;
+	ep-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
+	ranges = <0x83000000 0x0 0xfa000000 0x0 0xfa000000 0x0 0x600000
+		  0x81000000 0x0 0xfa600000 0x0 0xfa600000 0x0 0x100000>;
+	num-lanes = <4>;
+	msi-map = <0x0 &its 0x0 0x1000>;
+	reg = < 0x0 0xf8000000 0x0 0x2000000 >, < 0x0 0xfd000000 0x0 0x1000000 >;
+	reg-names = "axi-base", "apb-base";
+	resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
+		 <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE>;
+	reset-names = "core", "mgmt", "mgmt-sticky", "pipe";
+	phys = <&pcie_phy>;
+	phy-names = "pcie-phy";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_clkreq>;
+	#interrupt-cells = <1>;
+	interrupt-controller;
+	interrupt-map-mask = <0 0 0 7>;
+	interrupt-map = <0 0 0 1 &pcie0_intc 1>,
+			<0 0 0 2 &pcie0_intc 2>,
+			<0 0 0 3 &pcie0_intc 3>,
+			<0 0 0 4 &pcie0_intc 4>;
+	pcie0_intc: interrupt-controller {
+		interrupt-controller;
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+	};
+};
-- 
2.3.7


