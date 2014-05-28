Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:50831 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbaE1Ovz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 May 2014 10:51:55 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 2/5] ARM: tegra: Add new PCIe regulator properties
Date: Wed, 28 May 2014 16:49:12 +0200
Message-Id: <1401288555-24197-3-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1401288555-24197-1-git-send-email-thierry.reding@gmail.com>
References: <1401288555-24197-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

These new properties more accurately reflect the real connections of the
boards and therefore make it easier to match them up with schematics.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- reword comment in Cardhu DTS

 arch/arm/boot/dts/tegra20-harmony.dts   | 10 +++++++++-
 arch/arm/boot/dts/tegra20-tamonten.dtsi |  7 +++++++
 arch/arm/boot/dts/tegra20-trimslice.dts |  8 ++++++++
 arch/arm/boot/dts/tegra30-beaver.dts    | 11 +++++++++++
 arch/arm/boot/dts/tegra30-cardhu.dtsi   | 10 ++++++++++
 5 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index f45aad688d9b..c8008247ead7 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -562,9 +562,17 @@
 	};
 
 	pcie-controller@80003000 {
+		status = "okay";
+
+		avdd-pex-supply = <&pci_vdd_reg>;
+		vdd-pex-supply = <&pci_vdd_reg>;
+		avdd-pex-pll-supply = <&pci_vdd_reg>;
+		avdd-plle-supply = <&pci_vdd_reg>;
+		vddio-pex-clk-supply = <&pci_clk_reg>;
+
+		/* deprecated */
 		pex-clk-supply = <&pci_clk_reg>;
 		vdd-supply = <&pci_vdd_reg>;
-		status = "okay";
 
 		pci@1,0 {
 			status = "okay";
diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
index a1b0d965757f..0e33577750ae 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
@@ -473,6 +473,13 @@
 	};
 
 	pcie-controller@80003000 {
+		avdd-pex-supply = <&pci_vdd_reg>;
+		vdd-pex-supply = <&pci_vdd_reg>;
+		avdd-pex-pll-supply = <&pci_vdd_reg>;
+		avdd-plle-supply = <&pci_vdd_reg>;
+		vddio-pex-clk-supply = <&pci_clk_reg>;
+
+		/* deprecated */
 		pex-clk-supply = <&pci_clk_reg>;
 		vdd-supply = <&pci_vdd_reg>;
 	};
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 216fa6d50c65..401b32e44369 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -318,6 +318,14 @@
 
 	pcie-controller@80003000 {
 		status = "okay";
+
+		avdd-pex-supply = <&pci_vdd_reg>;
+		vdd-pex-supply = <&pci_vdd_reg>;
+		avdd-pex-pll-supply = <&pci_vdd_reg>;
+		avdd-plle-supply = <&pci_vdd_reg>;
+		vddio-pex-clk-supply = <&pci_clk_reg>;
+
+		/* deprecated */
 		pex-clk-supply = <&pci_clk_reg>;
 		vdd-supply = <&pci_vdd_reg>;
 
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index 3189791a9289..d3ddfa067e7d 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -17,6 +17,17 @@
 
 	pcie-controller@00003000 {
 		status = "okay";
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
+		/* deprecated */
 		pex-clk-supply = <&sys_3v3_pexs_reg>;
 		vdd-supply = <&ldo1_reg>;
 		avdd-supply = <&ldo2_reg>;
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 0cf0848a82d8..636d62e27a6d 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -38,6 +38,16 @@
 
 	pcie-controller@00003000 {
 		status = "okay";
+
+		/* AVDD_PEXA and VDD_PEXA inputs are grounded on Cardhu. */
+		avdd-pexb-supply = <&ldo1_reg>;
+		vdd-pexb-supply = <&ldo1_reg>;
+		avdd-pex-pll-supply = <&ldo1_reg>;
+		hvdd-pex-supply = <&pex_hvdd_3v3_reg>;
+		vddio-pex-ctl-supply = <&sys_3v3_reg>;
+		avdd-plle-supply = <&ldo2_reg>;
+
+		/* deprecated */
 		pex-clk-supply = <&pex_hvdd_3v3_reg>;
 		vdd-supply = <&ldo1_reg>;
 		avdd-supply = <&ldo2_reg>;
-- 
1.9.2

