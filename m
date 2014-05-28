Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:50229 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282AbaE1OwD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 May 2014 10:52:03 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 5/5] ARM: tegra: Remove legacy PCIe power supply properties
Date: Wed, 28 May 2014 16:49:15 +0200
Message-Id: <1401288555-24197-6-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1401288555-24197-1-git-send-email-thierry.reding@gmail.com>
References: <1401288555-24197-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

These properties are deprecated and no longer of any use.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra20-harmony.dts   | 4 ----
 arch/arm/boot/dts/tegra20-tamonten.dtsi | 4 ----
 arch/arm/boot/dts/tegra20-trimslice.dts | 4 ----
 arch/arm/boot/dts/tegra30-beaver.dts    | 5 -----
 arch/arm/boot/dts/tegra30-cardhu.dtsi   | 5 -----
 5 files changed, 22 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index c8008247ead7..a37279af687c 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -570,10 +570,6 @@
 		avdd-plle-supply = <&pci_vdd_reg>;
 		vddio-pex-clk-supply = <&pci_clk_reg>;
 
-		/* deprecated */
-		pex-clk-supply = <&pci_clk_reg>;
-		vdd-supply = <&pci_vdd_reg>;
-
 		pci@1,0 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
index 0e33577750ae..a4914bba1a39 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
@@ -478,10 +478,6 @@
 		avdd-pex-pll-supply = <&pci_vdd_reg>;
 		avdd-plle-supply = <&pci_vdd_reg>;
 		vddio-pex-clk-supply = <&pci_clk_reg>;
-
-		/* deprecated */
-		pex-clk-supply = <&pci_clk_reg>;
-		vdd-supply = <&pci_vdd_reg>;
 	};
 
 	usb@c5008000 {
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 401b32e44369..5ad87979ab13 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -325,10 +325,6 @@
 		avdd-plle-supply = <&pci_vdd_reg>;
 		vddio-pex-clk-supply = <&pci_clk_reg>;
 
-		/* deprecated */
-		pex-clk-supply = <&pci_clk_reg>;
-		vdd-supply = <&pci_vdd_reg>;
-
 		pci@1,0 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index d3ddfa067e7d..cee8f2246fdb 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -27,11 +27,6 @@
 		vddio-pex-ctl-supply = <&sys_3v3_reg>;
 		hvdd-pex-supply = <&sys_3v3_pexs_reg>;
 
-		/* deprecated */
-		pex-clk-supply = <&sys_3v3_pexs_reg>;
-		vdd-supply = <&ldo1_reg>;
-		avdd-supply = <&ldo2_reg>;
-
 		pci@1,0 {
 			status = "okay";
 			nvidia,num-lanes = <2>;
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 636d62e27a6d..206379546244 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -47,11 +47,6 @@
 		vddio-pex-ctl-supply = <&sys_3v3_reg>;
 		avdd-plle-supply = <&ldo2_reg>;
 
-		/* deprecated */
-		pex-clk-supply = <&pex_hvdd_3v3_reg>;
-		vdd-supply = <&ldo1_reg>;
-		avdd-supply = <&ldo2_reg>;
-
 		pci@1,0 {
 			nvidia,num-lanes = <4>;
 		};
-- 
1.9.2

