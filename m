Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11627 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbaDDOuO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Apr 2014 10:50:14 -0400
From: Thierry Reding <treding@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>
Subject: [RFC 2/5] ARM: tegra: Add new PCIe regulator properties
Date: Fri, 4 Apr 2014 16:49:26 +0200
Message-ID: <1396622969-17837-3-git-send-email-treding@nvidia.com>
In-Reply-To: <1396622969-17837-1-git-send-email-treding@nvidia.com>
References: <1396622969-17837-1-git-send-email-treding@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These new properties more accurately reflect the real connections of the
boards and therefore make it easier to match them up with schematics.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra20-harmony.dts   | 10 +++++++++-
 arch/arm/boot/dts/tegra20-tamonten.dtsi |  7 +++++++
 arch/arm/boot/dts/tegra20-trimslice.dts |  8 ++++++++
 arch/arm/boot/dts/tegra30-beaver.dts    | 11 +++++++++++
 arch/arm/boot/dts/tegra30-cardhu.dtsi   | 10 ++++++++++
 5 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index 3fb1f50f6d46..7d5d0aa1778a 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -561,9 +561,17 @@
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
index e93fe45b7803..b434ec1f278a 100644
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
index 0cf0848a82d8..55051a808ced 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -38,6 +38,16 @@
 
 	pcie-controller@00003000 {
 		status = "okay";
+
+		/* AVDD_PEXA and VDD_PEXA are grounded on Cardhu. */
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
1.9.1

