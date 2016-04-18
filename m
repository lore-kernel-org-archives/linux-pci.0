Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38745 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbcDROvt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2016 10:51:49 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: pci: tegra: Update for per-lane PHYs
Date: Mon, 18 Apr 2016 16:51:44 +0200
Message-Id: <1460991105-22861-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

The XUSB pad controller allows PCIe lanes to be controlled individually,
providing fine-grained control over their power state. Previous attempts
at describing the XUSB pad controller in DT had erroneously assumed that
all PCIe lanes were driven by the same PHY, and hence the PCI host
controller would reference only a single PHY.

Moving to a representation of per-lane PHYs requires that the operating
system driver for the PCI host controller have access to the set of PHY
devices that make up the connection of each root port in order to power
up and down all of the lanes as necessary.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v5:
- add per-SoC examples to clarify what properties are relevant on each
  generation
- clarify the rationale for moving the per-lane PHYs

Changes in v4:
- add additional lanes subnode when dereferencing PHYs from the XUSB pad
  controller to reflect changes in its binding

 .../bindings/pci/nvidia,tegra20-pcie.txt           | 224 ++++++++++++++++++++-
 1 file changed, 219 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
index 75321ae23c08..b8cc395fffea 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
@@ -60,11 +60,14 @@ Required properties:
   - afi
   - pcie_x
 
-Required properties on Tegra124 and later:
+Required properties on Tegra124 and later (deprecated):
 - phys: Must contain an entry for each entry in phy-names.
 - phy-names: Must include the following entries:
   - pcie
 
+These properties are deprecated in favour of per-lane PHYs define in each of
+the root ports (see below).
+
 Power supplies for Tegra20:
 - avdd-pex-supply: Power supply for analog PCIe logic. Must supply 1.05 V.
 - vdd-pex-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
@@ -122,11 +125,22 @@ Required properties:
   - Root port 0 uses 4 lanes, root port 1 is unused.
   - Both root ports use 2 lanes.
 
-Example:
+Required properties for Tegra124 and later:
+- phys: Must contain an phandle to a PHY for each entry in phy-names.
+- phy-names: Must include an entry for each active lane. Note that the number
+  of entries does not have to (though usually will) be equal to the specified
+  number of lanes in the nvidia,num-lanes property. Entries are of the form
+  "pcie-N": where N ranges from 0 to the value specified in nvidia,num-lanes.
+
+Examples:
+=========
+
+Tegra20:
+--------
 
 SoC DTSI:
 
-	pcie-controller {
+	pcie-controller@80003000 {
 		compatible = "nvidia,tegra20-pcie";
 		device_type = "pci";
 		reg = <0x80003000 0x00000800   /* PADS registers */
@@ -186,10 +200,9 @@ SoC DTSI:
 		};
 	};
 
-
 Board DTS:
 
-	pcie-controller {
+	pcie-controller@80003000 {
 		status = "okay";
 
 		vdd-supply = <&pci_vdd_reg>;
@@ -222,3 +235,204 @@ if a device on the PCI bus provides a non-probeable bus such as I2C or SPI,
 device nodes need to be added in order to allow the bus' children to be
 instantiated at the proper location in the operating system's device tree (as
 illustrated by the optional nodes in the example above).
+
+Tegra30:
+--------
+
+SoC DTSI:
+
+	pcie-controller@00003000 {
+		compatible = "nvidia,tegra30-pcie";
+		device_type = "pci";
+		reg = <0x00003000 0x00000800   /* PADS registers */
+		       0x00003800 0x00000200   /* AFI registers */
+		       0x10000000 0x10000000>; /* configuration space */
+		reg-names = "pads", "afi", "cs";
+		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH   /* controller interrupt */
+			      GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
+		interrupt-names = "intr", "msi";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &intc GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+
+		bus-range = <0x00 0xff>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		ranges = <0x82000000 0 0x00000000 0x00000000 0 0x00001000   /* port 0 configuration space */
+			  0x82000000 0 0x00001000 0x00001000 0 0x00001000   /* port 1 configuration space */
+			  0x82000000 0 0x00004000 0x00004000 0 0x00001000   /* port 2 configuration space */
+			  0x81000000 0 0          0x02000000 0 0x00010000   /* downstream I/O */
+			  0x82000000 0 0x20000000 0x20000000 0 0x08000000   /* non-prefetchable memory */
+			  0xc2000000 0 0x28000000 0x28000000 0 0x18000000>; /* prefetchable memory */
+
+		clocks = <&tegra_car TEGRA30_CLK_PCIE>,
+			 <&tegra_car TEGRA30_CLK_AFI>,
+			 <&tegra_car TEGRA30_CLK_PLL_E>,
+			 <&tegra_car TEGRA30_CLK_CML0>;
+		clock-names = "pex", "afi", "pll_e", "cml";
+		resets = <&tegra_car 70>,
+			 <&tegra_car 72>,
+			 <&tegra_car 74>;
+		reset-names = "pex", "afi", "pcie_x";
+		status = "disabled";
+
+		pci@1,0 {
+			device_type = "pci";
+			assigned-addresses = <0x82000800 0 0x00000000 0 0x1000>;
+			reg = <0x000800 0 0 0 0>;
+			status = "disabled";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+
+			nvidia,num-lanes = <2>;
+		};
+
+		pci@2,0 {
+			device_type = "pci";
+			assigned-addresses = <0x82001000 0 0x00001000 0 0x1000>;
+			reg = <0x001000 0 0 0 0>;
+			status = "disabled";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+
+			nvidia,num-lanes = <2>;
+		};
+
+		pci@3,0 {
+			device_type = "pci";
+			assigned-addresses = <0x82001800 0 0x00004000 0 0x1000>;
+			reg = <0x001800 0 0 0 0>;
+			status = "disabled";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+
+			nvidia,num-lanes = <2>;
+		};
+	};
+
+Board DTS:
+
+	pcie-controller@00003000 {
+		status = "okay";
+
+		avdd-pexa-supply = <&ldo1_reg>;
+		vdd-pexa-supply = <&ldo1_reg>;
+		avdd-pexb-supply = <&ldo1_reg>;
+		vdd-pexb-supply = <&ldo1_reg>;
+		avdd-pex-pll-supply = <&ldo1_reg>;
+		avdd-plle-supply = <&ldo1_reg>;
+		vddio-pex-ctl-supply = <&sys_3v3_reg>;
+		hvdd-pex-supply = <&sys_3v3_pexs_reg>;
+
+		pci@1,0 {
+			status = "okay";
+		};
+
+		pci@3,0 {
+			status = "okay";
+		};
+	};
+
+Tegra124:
+---------
+
+SoC DTSI:
+
+	pcie-controller@01003000 {
+		compatible = "nvidia,tegra124-pcie";
+		device_type = "pci";
+		reg = <0x0 0x01003000 0x0 0x00000800   /* PADS registers */
+		       0x0 0x01003800 0x0 0x00000800   /* AFI registers */
+		       0x0 0x02000000 0x0 0x10000000>; /* configuration space */
+		reg-names = "pads", "afi", "cs";
+		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+			     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
+		interrupt-names = "intr", "msi";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+
+		bus-range = <0x00 0xff>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		ranges = <0x82000000 0 0x01000000 0x0 0x01000000 0 0x00001000   /* port 0 configuration space */
+			  0x82000000 0 0x01001000 0x0 0x01001000 0 0x00001000   /* port 1 configuration space */
+			  0x81000000 0 0x0        0x0 0x12000000 0 0x00010000   /* downstream I/O (64 KiB) */
+			  0x82000000 0 0x13000000 0x0 0x13000000 0 0x0d000000   /* non-prefetchable memory (208 MiB) */
+			  0xc2000000 0 0x20000000 0x0 0x20000000 0 0x20000000>; /* prefetchable memory (512 MiB) */
+
+		clocks = <&tegra_car TEGRA124_CLK_PCIE>,
+			 <&tegra_car TEGRA124_CLK_AFI>,
+			 <&tegra_car TEGRA124_CLK_PLL_E>,
+			 <&tegra_car TEGRA124_CLK_CML0>;
+		clock-names = "pex", "afi", "pll_e", "cml";
+		resets = <&tegra_car 70>,
+			 <&tegra_car 72>,
+			 <&tegra_car 74>;
+		reset-names = "pex", "afi", "pcie_x";
+		status = "disabled";
+
+		pci@1,0 {
+			device_type = "pci";
+			assigned-addresses = <0x82000800 0 0x01000000 0 0x1000>;
+			reg = <0x000800 0 0 0 0>;
+			status = "disabled";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+
+			nvidia,num-lanes = <2>;
+		};
+
+		pci@2,0 {
+			device_type = "pci";
+			assigned-addresses = <0x82001000 0 0x01001000 0 0x1000>;
+			reg = <0x001000 0 0 0 0>;
+			status = "disabled";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+
+			nvidia,num-lanes = <1>;
+		};
+	};
+
+Board DTS:
+
+	pcie-controller@01003000 {
+		status = "okay";
+
+		avddio-pex-supply = <&vdd_1v05_run>;
+		dvddio-pex-supply = <&vdd_1v05_run>;
+		avdd-pex-pll-supply = <&vdd_1v05_run>;
+		hvdd-pex-supply = <&vdd_3v3_lp0>;
+		hvdd-pex-pll-e-supply = <&vdd_3v3_lp0>;
+		vddio-pex-ctl-supply = <&vdd_3v3_lp0>;
+		avdd-pll-erefe-supply = <&avdd_1v05_run>;
+
+		/* Mini PCIe */
+		pci@1,0 {
+			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-4}>;
+			phy-names = "pcie-0";
+			status = "okay";
+		};
+
+		/* Gigabit Ethernet */
+		pci@2,0 {
+			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-2}>;
+			phy-names = "pcie-0";
+			status = "okay";
+		};
+	};
-- 
2.8.0

