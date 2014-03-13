Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:62461 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281AbaCMRkS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Mar 2014 13:40:18 -0400
Received: by mail-pa0-f47.google.com with SMTP id lj1so1433124pab.20
        for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2014 10:40:18 -0700 (PDT)
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
Subject: [PATCH 1/2] ARM: DT: fix gic interrupt controller documentation
Date: Thu, 13 Mar 2014 10:40:04 -0700
Message-Id: <1394732405-2260-2-git-send-email-tharvey@gateworks.com>
In-Reply-To: <1394732405-2260-1-git-send-email-tharvey@gateworks.com>
References: <1394732405-2260-1-git-send-email-tharvey@gateworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When using interrupt-maps, the size of a map entry is #address-cells +
 #interrupt-cells for the parent interrupt controller.  For the ARM GIC
address-cells should be 0 as this is not used.

This patch fixes the example by correctly specifying #address-cells = 0.

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
 Documentation/devicetree/bindings/arm/gic.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
index bae0d87..b59ff1f 100644
--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -55,7 +55,7 @@ Example:
 	intc: interrupt-controller@fff11000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
-		#address-cells = <1>;
+		#address-cells = <0>;
 		interrupt-controller;
 		reg = <0xfff11000 0x1000>,
 		      <0xfff10100 0x100>;
-- 
1.8.3.2

