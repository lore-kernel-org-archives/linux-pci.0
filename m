Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38275 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760095AbbLCNgL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2015 08:36:11 -0500
Received: by wmec201 with SMTP id c201so22433485wme.1
        for <linux-pci@vger.kernel.org>; Thu, 03 Dec 2015 05:36:10 -0800 (PST)
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
To: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 2/5] DT: PCI: qcom: Document PCIe devicetree bindings
Date: Thu,  3 Dec 2015 15:35:21 +0200
Message-Id: <1449149725-27607-3-git-send-email-stanimir.varbanov@linaro.org>
In-Reply-To: <1449149725-27607-1-git-send-email-stanimir.varbanov@linaro.org>
References: <1449149725-27607-1-git-send-email-stanimir.varbanov@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Stanimir Varbanov <svarbanov@mm-sol.com>

Document Qualcomm PCIe driver devicetree bindings.

Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.txt          |  233 ++++++++++++++++++++
 1 file changed, 233 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
new file mode 100644
index 000000000000..6d71ee2e335d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -0,0 +1,233 @@
+* Qualcomm PCI express root complex
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: Value should contain
+			- "qcom,pcie-ipq8064" for ipq8064
+			- "qcom,pcie-apq8064" for apq8064
+			- "qcom,pcie-apq8084" for apq8084
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Register ranges as listed in the reg-names property
+
+- reg-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: Must include the following entries
+			- "parf"   Qualcomm specific registers
+			- "dbi"	   Designware PCIe registers
+			- "elbi"   External local bus interface registers
+			- "config" PCIe configuration space
+
+- device_type:
+	Usage: required
+	Value type: <string>
+	Definition: Should be "pci". As specified in designware-pcie.txt
+
+- #address-cells:
+	Usage: required
+	Value type: <u32>
+	Definition: Should be set to 3. As specified in designware-pcie.txt
+
+- #size-cells:
+	Usage: required
+	Value type: <u32>
+	Definition: Should be set 2. As specified in designware-pcie.txt
+
+- ranges:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: As specified in designware-pcie.txt
+
+- interrupts:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: MSI interrupt
+
+- interrupt-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: Should contain "msi"
+
+- #interrupt-cells:
+	Usage: required
+	Value type: <u32>
+	Definition: Should be 1. As specified in designware-pcie.txt
+
+- interrupt-map-mask:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: As specified in designware-pcie.txt
+
+- interrupt-map:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: As specified in designware-pcie.txt
+
+- clocks:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: List of phandle and clock specifier pairs as listed
+		    in clock-names property
+
+- clock-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "iface"	Configuration AHB clock
+
+- clock-names:
+	Usage: required for ipq/apq8064
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "core"	Clocks the pcie hw block
+			- "phy"		Clocks the pcie PHY block
+- clock-names:
+	Usage: required for apq8084
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "aux"		Auxiliary (AUX) clock
+			- "bus_master"	Master AXI clock
+			- "bus_slave"	Slave AXI clock
+- resets:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: List of phandle and reset specifier pairs as listed
+		    in reset-names property
+
+- reset-names:
+	Usage: required for ipq/apq8064
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "axi"  AXI reset
+			- "ahb"  AHB reset
+			- "por"  POR reset
+			- "pci"  PCI reset
+			- "phy"  PHY reset
+
+- reset-names:
+	Usage: required for apq8084
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "core" Core reset
+
+- power-domains:
+	Usage: required for apq8084
+	Value type: <prop-encoded-array>
+	Definition: A phandle and power domain specifier pair to the
+		    power domain which is responsible for collapsing
+		    and restoring power to the peripheral
+
+- vdda-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: A phandle to the core analog power supply
+
+- vdda_phy-supply:
+	Usage: required for ipq/apq8064
+	Value type: <phandle>
+	Definition: A phandle to the analog power supply for PHY
+
+- vdda_refclk-supply:
+	Usage: required for ipq/apq8064
+	Value type: <phandle>
+	Definition: A phandle to the analog power supply for IC which generates
+		    reference clock
+
+- phys:
+	Usage: required for apq8084
+	Value type: <phandle>
+	Definition: List of phandle(s) as listed in phy-names property
+
+- phy-names:
+	Usage: required for apq8084
+	Value type: <stringlist>
+	Definition: Should contain "pciephy"
+
+- <name>-gpios:
+	Usage: optional
+	Value type: <prop-encoded-array>
+	Definition: List of phandle and gpio specifier pairs. Should contain
+			- "perst-gpios"	PCIe endpoint reset signal line
+			- "wake-gpios"	PCIe endpoint wake signal line
+
+* Example for ipq/apq8064
+	pcie@1b500000 {
+		compatible = "qcom,pcie-apq8064", "qcom,pcie-ipq8064", "snps,dw-pcie";
+		reg = <0x1b500000 0x1000
+		       0x1b502000 0x80
+		       0x1b600000 0x100
+		       0x0ff00000 0x100000>;
+		reg-names = "dbi", "elbi", "parf", "config";
+		device_type = "pci";
+		linux,pci-domain = <0>;
+		bus-range = <0x00 0xff>;
+		num-lanes = <1>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges = <0x81000000 0 0 0x0fe00000 0 0x00100000   /* I/O */
+			  0x82000000 0 0 0x08000000 0 0x07e00000>; /* memory */
+		interrupts = <GIC_SPI 238 IRQ_TYPE_NONE>;
+		interrupt-names = "msi";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &intc 0 36 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+				<0 0 0 2 &intc 0 37 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+				<0 0 0 3 &intc 0 38 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+				<0 0 0 4 &intc 0 39 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+		clocks = <&gcc PCIE_A_CLK>,
+			 <&gcc PCIE_H_CLK>,
+			 <&gcc PCIE_PHY_CLK>;
+		clock-names = "core", "iface", "phy";
+		resets = <&gcc PCIE_ACLK_RESET>,
+			 <&gcc PCIE_HCLK_RESET>,
+			 <&gcc PCIE_POR_RESET>,
+			 <&gcc PCIE_PCI_RESET>,
+			 <&gcc PCIE_PHY_RESET>;
+		reset-names = "axi", "ahb", "por", "pci", "phy";
+		pinctrl-0 = <&pcie_pins_default>;
+		pinctrl-names = "default";
+	};
+
+* Example for apq8084
+	pcie0@fc520000 {
+		compatible = "qcom,pcie-apq8084", "snps,dw-pcie";
+		reg = <0xfc520000 0x2000>,
+		      <0xff000000 0x1000>,
+		      <0xff001000 0x1000>,
+		      <0xff002000 0x2000>;
+		reg-names = "parf", "dbi", "elbi", "config";
+		device_type = "pci";
+		linux,pci-domain = <0>;
+		bus-range = <0x00 0xff>;
+		num-lanes = <1>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges = <0x81000000 0 0          0xff200000 0 0x00100000   /* I/O */
+			  0x82000000 0 0x00300000 0xff300000 0 0x00d00000>; /* memory */
+		interrupts = <GIC_SPI 243 IRQ_TYPE_NONE>;
+		interrupt-names = "msi";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &intc 0 244 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+				<0 0 0 2 &intc 0 245 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+				<0 0 0 3 &intc 0 247 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+				<0 0 0 4 &intc 0 248 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+		clocks = <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+			 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+			 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+			 <&gcc GCC_PCIE_0_AUX_CLK>;
+		clock-names = "iface", "master_bus", "slave_bus", "aux";
+		resets = <&gcc GCC_PCIE_0_BCR>;
+		reset-names = "core";
+		power-domains = <&gcc PCIE0_GDSC>;
+		vdda-supply = <&pma8084_l3>;
+		phys = <&pciephy0>;
+		phy-names = "pciephy";
+		perst-gpio = <&tlmm 70 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&pcie0_pins_default>;
+		pinctrl-names = "default";
+	};
-- 
1.7.9.5

