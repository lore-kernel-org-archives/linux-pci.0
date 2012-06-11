Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57151 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755176Ab2FKPFi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jun 2012 11:05:38 -0400
From: Thierry Reding <thierry.reding@avionic-design.de>
To: linux-tegra@vger.kernel.org
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH v2 09/10] ARM: tegra: harmony: Initialize PCIe from DT
Date: Mon, 11 Jun 2012 17:05:17 +0200
Message-Id: <1339427118-32263-10-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

With the device tree support in place, probe the PCIe controller from
the device tree and remove the corresponding workaround in the board
file.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

---
Changes in v2:
- new patch
---
 arch/arm/boot/dts/tegra-harmony.dts    |   19 +++++++++++++++++--
 arch/arm/mach-tegra/board-dt-tegra20.c |   14 --------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
index c98aa2a..1dc907f 100644
--- a/arch/arm/boot/dts/tegra-harmony.dts
+++ b/arch/arm/boot/dts/tegra-harmony.dts
@@ -276,7 +276,7 @@
 		status = "okay";
 		clock-frequency = <400000>;
 
-		tps6586x@34 {
+		pmu: tps6586x@34 {
 			compatible = "ti,tps6586x";
 			reg = <0x34>;
 			interrupts = <0 88 0x4>;
@@ -306,7 +306,7 @@
 					regulator-always-on;
 				};
 
-				ldo0 {
+				pci_clk_reg: ldo0 {
 					regulator-name = "PCIE CLK";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
@@ -364,6 +364,21 @@
 		nvidia,invert-interrupt;
 	};
 
+	pci_vdd_reg: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "PCIE VDD";
+		regulator-min-microvolt = <1050000>;
+		regulator-max-microvolt = <1050000>;
+		enable-active-high;
+		gpio = <&pmu 2 0>;
+	};
+
+	pci {
+		pex-clk-supply = <&pci_clk_reg>;
+		vdd-supply = <&pci_vdd_reg>;
+		status = "okay";
+	};
+
 	usb@c5000000 {
 		status = "okay";
 	};
diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index a9a54e6..c7b6ae2 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -131,17 +131,6 @@ static void __init trimslice_init(void)
 }
 #endif
 
-#ifdef CONFIG_MACH_HARMONY
-static void __init harmony_init(void)
-{
-	int ret;
-
-	ret = harmony_pcie_init();
-	if (ret)
-		pr_err("harmony_pcie_init() failed: %d\n", ret);
-}
-#endif
-
 #ifdef CONFIG_MACH_PAZ00
 static void __init paz00_init(void)
 {
@@ -156,9 +145,6 @@ static struct {
 #ifdef CONFIG_MACH_TRIMSLICE
 	{ "compulab,trimslice", trimslice_init },
 #endif
-#ifdef CONFIG_MACH_HARMONY
-	{ "nvidia,harmony", harmony_init },
-#endif
 #ifdef CONFIG_MACH_PAZ00
 	{ "compal,paz00", paz00_init },
 #endif
-- 
1.7.10.4

