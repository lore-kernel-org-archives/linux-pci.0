Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33538 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbaCEN0f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Mar 2014 08:26:35 -0500
From: Lucas Stach <l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-sh@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Shawn Guo <shawn.guo@linaro.org>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de
Subject: [PATCH v2 5/6] ARM: dts: imx6: add PCIe interrupt mapping properties
Date: Wed,  5 Mar 2014 14:25:50 +0100
Message-Id: <1394025951-32438-6-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As defined by the common PCI bindings.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2: drop blank lines
---
 arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index fb28b2ecb1db..c1c06d25decc 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -10,6 +10,8 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
 #include "skeleton.dtsi"
 
 / {
@@ -127,6 +129,12 @@
 				  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
 			interrupts = <0 123 0x04>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 2 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 3 &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clks 189>, <&clks 187>, <&clks 206>, <&clks 144>;
 			clock-names = "pcie_ref_125m", "sata_ref_100m", "lvds_gate", "pcie_axi";
 			status = "disabled";
-- 
1.9.0

