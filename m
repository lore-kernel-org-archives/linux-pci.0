Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:44985 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499AbaCMRkV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Mar 2014 13:40:21 -0400
Received: by mail-pa0-f48.google.com with SMTP id hz1so1433328pad.35
        for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2014 10:40:20 -0700 (PDT)
From: Tim Harvey <tharvey@gateworks.com>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Thierry Reding <thierry.reding@gmail.com>,
	Ben Dooks <ben-linux@fluff.org>,
	linux-tegra <linux-tegra@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Grant Likely <grant.likely@linaro.org>
Subject: [PATCH 2/2] ARM: dts: imx: fix invalid #address-cells value
Date: Thu, 13 Mar 2014 10:40:05 -0700
Message-Id: <1394732405-2260-3-git-send-email-tharvey@gateworks.com>
In-Reply-To: <1394732405-2260-1-git-send-email-tharvey@gateworks.com>
References: <1394732405-2260-1-git-send-email-tharvey@gateworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The invalid value of #address-cells in the imx6 pcie host controller node
causes of_irq_parse_raw() to incorrectly advance through an interrupt-map
table of more than one interrupt.

This patch resolves this issue and allows proper interrupt mapping for an
imx6 pcie host connected to a P2P bridge when using legacy interrupts.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: linux-tegra <linux-tegra@vger.kernel.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Grant Likely <grant.likely@linaro.org>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index af8d28d..2285299 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -49,7 +49,7 @@
 	intc: interrupt-controller@00a01000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
-		#address-cells = <1>;
+		#address-cells = <0>;
 		#size-cells = <1>;
 		interrupt-controller;
 		reg = <0x00a01000 0x1000>,
-- 
1.8.3.2

