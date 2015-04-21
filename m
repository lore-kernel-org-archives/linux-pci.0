Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og123.obsmtp.com ([64.18.0.198]:59496 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751186AbbDUEFh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Apr 2015 00:05:37 -0400
Received: by pdbqa5 with SMTP id qa5so228765126pdb.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2015 21:05:36 -0700 (PDT)
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>,
	Duc Dang <dhdang@apm.com>
Subject: [PATCH v5 2/4] arm64: dts: Add the device tree entry for the APM X-Gene PCIe MSI node
Date: Mon, 20 Apr 2015 21:04:22 -0700
Message-Id: <227f8c75e04110e279b78512924742ba7c7fe5fc.1429586144.git.dhdang@apm.com>
In-Reply-To: <cover.1429586144.git.dhdang@apm.com>
References: <cover.1429586144.git.dhdang@apm.com>
In-Reply-To: <cover.1429586144.git.dhdang@apm.com>
References: <55310050.7000003@arm.com> <cover.1429586144.git.dhdang@apm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is single MSI block in X-Gene v1 SOC which serves all 5 PCIe ports.

Signed-off-by: Duc Dang <dhdang@apm.com>
Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index f1ad9c2..4b719c9 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -354,6 +354,28 @@
 			};
 		};
 
+		msi: msi@79000000 {
+			compatible = "apm,xgene1-msi";
+			msi-controller;
+			reg = <0x00 0x79000000 0x0 0x900000>;
+			interrupts = <  0x0 0x10 0x4
+					0x0 0x11 0x4
+					0x0 0x12 0x4
+					0x0 0x13 0x4
+					0x0 0x14 0x4
+					0x0 0x15 0x4
+					0x0 0x16 0x4
+					0x0 0x17 0x4
+					0x0 0x18 0x4
+					0x0 0x19 0x4
+					0x0 0x1a 0x4
+					0x0 0x1b 0x4
+					0x0 0x1c 0x4
+					0x0 0x1d 0x4
+					0x0 0x1e 0x4
+					0x0 0x1f 0x4>;
+		};
+
 		pcie0: pcie@1f2b0000 {
 			status = "disabled";
 			device_type = "pci";
@@ -375,6 +397,7 @@
 					 0x0 0x0 0x0 0x4 &gic 0x0 0xc5 0x1>;
 			dma-coherent;
 			clocks = <&pcie0clk 0>;
+			msi-parent = <&msi>;
 		};
 
 		pcie1: pcie@1f2c0000 {
@@ -398,6 +421,7 @@
 					 0x0 0x0 0x0 0x4 &gic 0x0 0xcb 0x1>;
 			dma-coherent;
 			clocks = <&pcie1clk 0>;
+			msi-parent = <&msi>;
 		};
 
 		pcie2: pcie@1f2d0000 {
@@ -421,6 +445,7 @@
 					 0x0 0x0 0x0 0x4 &gic 0x0 0xd1 0x1>;
 			dma-coherent;
 			clocks = <&pcie2clk 0>;
+			msi-parent = <&msi>;
 		};
 
 		pcie3: pcie@1f500000 {
@@ -444,6 +469,7 @@
 					 0x0 0x0 0x0 0x4 &gic 0x0 0xd7 0x1>;
 			dma-coherent;
 			clocks = <&pcie3clk 0>;
+			msi-parent = <&msi>;
 		};
 
 		pcie4: pcie@1f510000 {
@@ -467,6 +493,7 @@
 					 0x0 0x0 0x0 0x4 &gic 0x0 0xdd 0x1>;
 			dma-coherent;
 			clocks = <&pcie4clk 0>;
+			msi-parent = <&msi>;
 		};
 
 		serial0: serial@1c020000 {
-- 
1.9.1

