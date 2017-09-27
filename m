Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12987 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752088AbdI0MAr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2017 08:00:47 -0400
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <mperttunen@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V2 3/4] arm64: tegra: Add PCIe node for Tegra186
Date: Wed, 27 Sep 2017 17:28:36 +0530
Message-ID: <1506513517-25870-4-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1506513517-25870-1-git-send-email-mmaddireddy@nvidia.com>
References: <1506513517-25870-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tegra186 has three PCIe controllers, which can be operated
in 401, 211 or 111 lane combinations. Add DT support for
PCIe controllers.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
Tested-by: Mikko Perttunen <mperttunen@nvidia.com>
---
V2: No change in this patch
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 82 ++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 0b0552c9f7dd..9edf2a839e5d 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -443,6 +443,7 @@
 		shmem = <&cpu_bpmp_tx &cpu_bpmp_rx>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
+		#power-domain-cells = <1>;
 
 		bpmp_i2c: i2c {
 			compatible = "nvidia,tegra186-bpmp-i2c";
@@ -465,4 +466,85 @@
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		interrupt-parent = <&gic>;
 	};
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
+
+	};
 };
-- 
2.1.4
