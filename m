Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0146.outbound.protection.outlook.com ([65.55.169.146]:40864
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752492AbaJTFzt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Oct 2014 01:55:49 -0400
From: Richard Zhu <richard.zhu@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <shawn.guo@freescale.com>, <festevam@gmail.com>,
	<l.stach@pengutronix.de>, <tharvey@gateworks.com>,
	<m-karicheri2@ti.com>, Richard Zhu <r65037@freescale.com>,
	Richard Zhu <richard.zhu@freescale.com>
Subject: [PATCH v8 8/9] ARM: imx6sx: Add syscon into gpc dts
Date: Mon, 20 Oct 2014 13:25:23 +0800
Message-ID: <1413782724-30795-9-git-send-email-richard.zhu@freescale.com>
In-Reply-To: <1413782724-30795-1-git-send-email-richard.zhu@freescale.com>
References: <1413782724-30795-1-git-send-email-richard.zhu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Richard Zhu <r65037@freescale.com>

In order to manipulate gpc bits for imx6sx
pcie in driver, add syscon into gpc dts

Signed-off-by: Richard Zhu <richard.zhu@freescale.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 0dfeade..88d7fd7 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -689,7 +689,8 @@
 			};
 
 			gpc: gpc@020dc000 {
-				compatible = "fsl,imx6sx-gpc", "fsl,imx6q-gpc";
+				compatible = "fsl,imx6sx-gpc",
+					     "fsl,imx6q-gpc", "syscon";
 				reg = <0x020dc000 0x4000>;
 				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			};
-- 
1.9.1

