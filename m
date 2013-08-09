Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:41220 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933939Ab3HIOtz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2013 10:49:55 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jason Cooper <jason@lakedaemon.net>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v6 10/14] ARM: tegra: Enable PCIe controller on Beaver
Date: Fri,  9 Aug 2013 16:49:28 +0200
Message-Id: <1376059772-16669-11-git-send-email-treding@nvidia.com>
In-Reply-To: <1376059772-16669-1-git-send-email-treding@nvidia.com>
References: <1376059772-16669-1-git-send-email-treding@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <thierry.reding@gmail.com>

PCIe lane 0 is connected to an onboard Gigabit Ethernet (RTL8168evl) and
lane 4 is routed to the board's miniPCIe slot.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra30-beaver.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index 87c5f7b..4d9fa31 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -10,6 +10,27 @@
 		reg = <0x80000000 0x7ff00000>;
 	};
 
+	pcie-controller {
+		status = "okay";
+		pex-clk-supply = <&sys_3v3_pexs_reg>;
+		vdd-supply = <&ldo1_reg>;
+		avdd-supply = <&ldo2_reg>;
+
+		pci@1,0 {
+			status = "okay";
+			nvidia,num-lanes = <4>;
+		};
+
+		pci@2,0 {
+			status = "okay";
+			nvidia,num-lanes = <1>;
+		};
+
+		pci@3,0 {
+			nvidia,num-lanes = <1>;
+		};
+	};
+
 	pinmux {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
-- 
1.8.3.4

