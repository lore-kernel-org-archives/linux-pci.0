Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41043 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751858AbdH1OXN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2017 10:23:13 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        patchwork-lst@pengutronix.de, kernel@pengutronix.de
Subject: [PATCH 3/3] ARM: dts: imx6qdl: remove MSI irq line
Date: Mon, 28 Aug 2017 16:23:07 +0200
Message-Id: <20170828142307.30061-4-l.stach@pengutronix.de>
In-Reply-To: <20170828142307.30061-1-l.stach@pengutronix.de>
References: <20170828142307.30061-1-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The DWC PCIe host controller doesn't support MSI and legacy IRQs at
the same time. If the MSI controller is in use (which is always the case,
as PCIe port serives are using MSI IRQs when available), legacy endpoint
devices are unable to raise an IRQ.

Remove the MSI irq line to inhibit the MSI controller from being used,
which is a much better default, as most enpoint devices are able to fall
back to legacy PCIe IRQs, if MSI are not available.

Systems which are validated to work in MSI only mode can opt-in to use
the MSI controller by adding back the MSI irq line in the board DT.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index a9723b94bafa..0f47a9d4024e 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -209,8 +209,6 @@
 			ranges = <0x81000000 0 0          0x01f80000 0 0x00010000 /* downstream I/O */
 				  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
-			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &gpc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.11.0
