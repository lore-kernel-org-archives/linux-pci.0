Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2949 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbdITGoy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Sep 2017 02:44:54 -0400
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 1/4] dt-bindings: pci: tegra: Document Tegra186 PCIe DT
Date: Wed, 20 Sep 2017 12:12:41 +0530
Message-ID: <1505889764-19397-2-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1505889764-19397-1-git-send-email-mmaddireddy@nvidia.com>
References: <1505889764-19397-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tegra186 PCIe controller DT properties has couple of differences
wrt Tegra210 PCIe, rest of the DT properties are same.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 .../bindings/pci/nvidia,tegra20-pcie.txt           | 134 ++++++++++++++++++++-
 1 file changed, 130 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
index 982a74ea6df9..753b67327373 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
@@ -1,10 +1,15 @@
 NVIDIA Tegra PCIe controller
 
 Required properties:
-- compatible: For Tegra20, must contain "nvidia,tegra20-pcie".  For Tegra30,
-  "nvidia,tegra30-pcie".  For Tegra124, must contain "nvidia,tegra124-pcie".
-  Otherwise, must contain "nvidia,<chip>-pcie", plus one of the above, where
-  <chip> is tegra132 or tegra210.
+- compatible: Must be:
+  - "nvidia,tegra20-pcie": for Tegra20
+  - "nvidia,tegra30-pcie": for Tegra30
+  - "nvidia,tegra124-pcie": for Tegra124 and Tegra132
+  - "nvidia,tegra210-pcie": for Tegra210
+  - "nvidia,tegra186-pcie": for Tegra186
+- power-domains: To ungate power partition by BPMP powergate driver. Must
+contain BPMP phandle and PCIe power partition ID. This is required only
+for Tegra186.
 - device_type: Must be "pci"
 - reg: A list of physical base address and length for each set of controller
   registers. Must contain an entry for each entry in the reg-names property.
@@ -124,6 +129,16 @@ Power supplies for Tegra210:
   - vddio-pex-ctl-supply: Power supply for PCIe control I/O partition. Must
     supply 1.8 V.
 
+Power supplies for Tegra186:
+- Required:
+  - dvdd-pex-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
+  - hvdd-pex-pll-supply: High-voltage supply for PLLE (shared with USB3). Must
+    supply 1.8 V.
+  - hvdd-pex-supply: High-voltage supply for PCIe I/O and PCIe output clocks.
+    Must supply 1.8 V.
+  - vddio-pexctl-aud-supply: Power supply for PCIe side band signals. Must
+    supply 1.8 V.
+
 Root ports are defined as subnodes of the PCIe controller node.
 
 Required properties:
@@ -546,3 +561,114 @@ Board DTS:
 			status = "okay";
 		};
 	};
+
+Tegra186:
+---------
+
+SoC DTSI:
+
+	pcie@10003000 {
+		compatible = "nvidia,tegra186-pcie";
+		power-domains = <&bpmp TEGRA186_POWER_DOMAIN_PCX>;
+		device_type = "pci";
+		reg = <0x0 0x10003000 0x0 0x00000800   /* PADS registers */
+		       0x0 0x10003800 0x0 0x00000800   /* AFI registers */
+		       0x0 0x40000000 0x0 0x10000000>; /* configuration space */
+		reg-names = "pads", "afi", "cs";
+
+		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
+		interrupt-names = "intr", "msi";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+
+		bus-range = <0x00 0xff>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		ranges = <0x82000000 0 0x10000000 0x0 0x10000000 0 0x00001000   /* port 0 configuration space */
+			  0x82000000 0 0x10001000 0x0 0x10001000 0 0x00001000   /* port 1 configuration space */
+			  0x82000000 0 0x10004000 0x0 0x10004000 0 0x00001000   /* port 2 configuration space */
+			  0x81000000 0 0x0        0x0 0x50000000 0 0x00010000   /* downstream I/O (64 KiB) */
+			  0x82000000 0 0x50100000 0x0 0x50100000 0 0x07F00000   /* non-prefetchable memory (127 MiB) */
+			  0xc2000000 0 0x58000000 0x0 0x58000000 0 0x28000000>; /* prefetchable memory (640 MiB) */
+
+		clocks = <&bpmp TEGRA186_CLK_AFI>,
+			 <&bpmp TEGRA186_CLK_PCIE>,
+			 <&bpmp TEGRA186_CLK_PLLE>;
+		clock-names = "afi", "pex", "pll_e";
+
+		resets = <&bpmp TEGRA186_RESET_AFI>,
+			 <&bpmp TEGRA186_RESET_PCIE>,
+			 <&bpmp TEGRA186_RESET_PCIEXCLK>;
+		reset-names = "afi", "pex", "pcie_x";
+
+		status = "disabled";
+
+		pci@1,0 {
+			device_type = "pci";
+			assigned-addresses = <0x82000800 0 0x10000000 0 0x1000>;
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
+			assigned-addresses = <0x82001000 0 0x10001000 0 0x1000>;
+			reg = <0x001000 0 0 0 0>;
+			status = "disabled";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+
+			nvidia,num-lanes = <1>;
+		};
+
+		pci@3,0 {
+			device_type = "pci";
+			assigned-addresses = <0x82001800 0 0x10004000 0 0x1000>;
+			reg = <0x001800 0 0 0 0>;
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
+	pcie@10003000 {
+		status = "okay";
+
+		dvdd-pex-supply = <&vdd_pex>;
+		hvdd-pex-pll-supply = <&vdd_1v8>;
+		hvdd-pex-supply = <&vdd_1v8>;
+		vddio-pexctl-aud-supply = <&vdd_1v8>;
+
+		pci@1,0 {
+			nvidia,num-lanes = <4>;
+			status = "okay";
+		};
+
+		pci@2,0 {
+			nvidia,num-lanes = <0>;
+			status = "disabled";
+		};
+
+		pci@3,0 {
+			nvidia,num-lanes = <1>;
+			status = "disabled";
+		};
+	};
-- 
2.1.4
