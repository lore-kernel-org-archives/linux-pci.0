Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35584 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752942AbcKYK5k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2016 05:57:40 -0500
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tn@semihalf.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v4 05/10] dt-bindings: pci: tegra: Add Tegra210 support
Date: Fri, 25 Nov 2016 11:57:13 +0100
Message-Id: <20161125105718.3866-5-thierry.reding@gmail.com>
In-Reply-To: <20161125105718.3866-1-thierry.reding@gmail.com>
References: <20161125105718.3866-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

Add support for the PCI host controller found on Tegra210 SoCs. It is
very similar to the variant found on Tegra124, with a couple of small
differences regarding the power supplies.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/pci/nvidia,tegra20-pcie.txt           | 110 +++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
index b8cc395fffea..982a74ea6df9 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
@@ -110,6 +110,20 @@ Power supplies for Tegra124:
   - avdd-pll-erefe-supply: Power supply for PLLE (shared with USB3). Must
     supply 1.05 V.
 
+Power supplies for Tegra210:
+- Required:
+  - avdd-pll-uerefe-supply: Power supply for PLLE (shared with USB3). Must
+    supply 1.05 V.
+  - hvddio-pex-supply: High-voltage supply for PCIe I/O and PCIe output
+    clocks. Must supply 1.8 V.
+  - dvddio-pex-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
+  - dvdd-pex-pll-supply: Power supply for dedicated (internal) PCIe PLL. Must
+    supply 1.05 V.
+  - hvdd-pex-pll-e-supply: High-voltage supply for PLLE (shared with USB3).
+    Must supply 3.3 V.
+  - vddio-pex-ctl-supply: Power supply for PCIe control I/O partition. Must
+    supply 1.8 V.
+
 Root ports are defined as subnodes of the PCIe controller node.
 
 Required properties:
@@ -436,3 +450,99 @@ Board DTS:
 			status = "okay";
 		};
 	};
+
+Tegra210:
+---------
+
+SoC DTSI:
+
+	pcie-controller@01003000 {
+		compatible = "nvidia,tegra210-pcie";
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
+		clocks = <&tegra_car TEGRA210_CLK_PCIE>,
+			 <&tegra_car TEGRA210_CLK_AFI>,
+			 <&tegra_car TEGRA210_CLK_PLL_E>,
+			 <&tegra_car TEGRA210_CLK_CML0>;
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
+			nvidia,num-lanes = <4>;
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
+		avdd-pll-uerefe-supply = <&avdd_1v05_pll>;
+		hvddio-pex-supply = <&vdd_1v8>;
+		dvddio-pex-supply = <&vdd_pex_1v05>;
+		dvdd-pex-pll-supply = <&vdd_pex_1v05>;
+		hvdd-pex-pll-e-supply = <&vdd_1v8>;
+		vddio-pex-ctl-supply = <&vdd_1v8>;
+
+		pci@1,0 {
+			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-0}>,
+			       <&{/padctl@7009f000/pads/pcie/lanes/pcie-1}>,
+			       <&{/padctl@7009f000/pads/pcie/lanes/pcie-2}>,
+			       <&{/padctl@7009f000/pads/pcie/lanes/pcie-3}>;
+			phy-names = "pcie-0", "pcie-1", "pcie-2", "pcie-3";
+			status = "okay";
+		};
+
+		pci@2,0 {
+			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-4}>;
+			phy-names = "pcie-0";
+			status = "okay";
+		};
+	};
-- 
2.10.2

