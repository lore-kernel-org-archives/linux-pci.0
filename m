Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.g1.pair.com ([66.39.3.162]:60673 "EHLO mail1.g1.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734Ab3GAHkB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 1 Jul 2013 03:40:01 -0400
From: Sean Cross <xobs@kosagi.com>
To: devicetree-discuss@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Sean Cross <xobs@kosagi.com>
Subject: [PATCH 4/4] ARM i.MX6: Add PCI Express to device tree
Date: Mon,  1 Jul 2013 07:15:47 +0000
Message-Id: <1372662947-27160-5-git-send-email-xobs@kosagi.com>
In-Reply-To: <1372662947-27160-1-git-send-email-xobs@kosagi.com>
References: <1372662947-27160-1-git-send-email-xobs@kosagi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a PCI Express port to the i.MX6 device tree using interrupts, clocks,
and memory ranges appropriate for the device.

Signed-off-by: Sean Cross <xobs@kosagi.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 9e8296e..4b5facb 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -654,6 +654,18 @@
 				status = "disabled";
 			};
 
+			pcie: pcie@01ffc000 {
+				compatible = "fsl,imx6q-pcie";
+				reg = <0x01ffc000 0x4000>,
+				      <0x01000000 0x100000>,
+				      <0x01100000 0xe00000>,
+				      <0x01f00000 0xfc000>;
+				interrupts = <0 122 0x04>;
+				clocks = <&clks 186>, <&clks 189>, <&clks 196>, <&clks 198>, <&clks 144>;
+				clock-names = "sata_ref", "pcie_ref_125m", "lvds1_sel", "lvds1", "pcie_axi";
+				status = "disabled";
+			};
+
 			mlb@0218c000 {
 				reg = <0x0218c000 0x4000>;
 				interrupts = <0 53 0x04 0 117 0x04 0 126 0x04>;
-- 
1.7.9.5

