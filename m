Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59003 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbaC1QxH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Mar 2014 12:53:07 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	Sean Cross <xobs@kosagi.com>, Marek Vasut <marex@denx.de>,
	Richard Zhu <r65037@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Tim Harvey <tharvey@gateworks.com>, kernel@pengutronix.de
Subject: [PATCH 3/8] ARM: dts: imx6: update pcie to bring in line with new binding
Date: Fri, 28 Mar 2014 17:52:54 +0100
Message-Id: <1396025579-14344-4-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The new bindings drops one clock, renames the others and
drops the old interrupt mapping.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index c1c06d25decc..1ea1adb6d8c6 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -128,15 +128,16 @@
 				  0x81000000 0 0          0x01f80000 0 0x00010000 /* downstream I/O */
 				  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
-			interrupts = <0 123 0x04>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
 			                <0 0 0 2 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
 			                <0 0 0 3 &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
 			                <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clks 189>, <&clks 187>, <&clks 206>, <&clks 144>;
-			clock-names = "pcie_ref_125m", "sata_ref_100m", "lvds_gate", "pcie_axi";
+			clocks = <&clks 144>, <&clks 206>, <&clks 189>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy";
 			status = "disabled";
 		};
 
-- 
1.9.0

