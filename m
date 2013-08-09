Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:54602 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933927Ab3HIOtw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2013 10:49:52 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jason Cooper <jason@lakedaemon.net>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v6 08/14] ARM: tegra: Add Tegra30 PCIe support
Date: Fri,  9 Aug 2013 16:49:26 +0200
Message-Id: <1376059772-16669-9-git-send-email-treding@nvidia.com>
In-Reply-To: <1376059772-16669-1-git-send-email-treding@nvidia.com>
References: <1376059772-16669-1-git-send-email-treding@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add the top-level pcie-controller node for the Tegra30 SoC. Tegra30 has
three root ports that can use different lane layouts.

Signed-off-by: Jay Agarwal <jagarwal@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v5:
- use symbolic constants for interrupts and clocks

 arch/arm/boot/dts/tegra30.dtsi | 70 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index d8783f0..c8facca 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -16,6 +16,76 @@
 		serial4 = &uarte;
 	};
 
+	pcie-controller {
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
+		bus-range = <0x00 0xff>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		ranges = <0x82000000 0 0x00000000 0x00000000 0 0x00001000   /* port 0 configuration space */
+			  0x82000000 0 0x00001000 0x00001000 0 0x00001000   /* port 1 configuration space */
+			  0x82000000 0 0x00004000 0x00004000 0 0x00001000   /* port 2 configuration space */
+			  0x81000000 0 0          0x02000000 0 0x00010000   /* downstream I/O */
+			  0x82000000 0 0x20000000 0x20000000 0 0x10000000   /* non-prefetchable memory */
+			  0xc2000000 0 0x30000000 0x30000000 0 0x10000000>; /* prefetchable memory */
+
+		clocks = <&tegra_car TEGRA30_CLK_PCIE>,
+			 <&tegra_car TEGRA30_CLK_AFI>,
+			 <&tegra_car TEGRA30_CLK_PCIEX>,
+			 <&tegra_car TEGRA30_CLK_PLL_E>,
+			 <&tegra_car TEGRA30_CLK_CML0>;
+		clock-names = "pex", "afi", "pcie_xclk", "pll_e", "cml";
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
 	host1x {
 		compatible = "nvidia,tegra30-host1x", "simple-bus";
 		reg = <0x50000000 0x00024000>;
-- 
1.8.3.4

