Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32963 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751261AbcKYK56 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2016 05:57:58 -0500
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tn@semihalf.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v4 10/10] arm64: tegra: Enable PCIe on Jetson TX1
Date: Fri, 25 Nov 2016 11:57:18 +0100
Message-Id: <20161125105718.3866-10-thierry.reding@gmail.com>
In-Reply-To: <20161125105718.3866-1-thierry.reding@gmail.com>
References: <20161125105718.3866-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

Enable the x4 PCIe and M.2 Key E slots on Jetson TX1. The Key E slot is
currently untested due to lack of hardware.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
index 983775e637a4..4c1ea7a08d43 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
@@ -7,6 +7,32 @@
 	model = "NVIDIA Jetson TX1 Developer Kit";
 	compatible = "nvidia,p2371-2180", "nvidia,tegra210";
 
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
+
 	host1x@50000000 {
 		dsi@54300000 {
 			status = "okay";
-- 
2.10.2

