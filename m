Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0135.outbound.protection.outlook.com ([157.56.110.135]:27635
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751386AbaJJGLr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Oct 2014 02:11:47 -0400
From: Richard Zhu <richard.zhu@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <shawn.guo@freescale.com>, <festevam@gmail.com>,
	<l.stach@pengutronix.de>, <tharvey@gateworks.com>,
	Richard Zhu <r65037@freescale.com>,
	Richard Zhu <richard.zhu@freescale.com>
Subject: [PATCH v5 7/9] ARM: imx6sx: add syscon into gpc dts
Date: Fri, 10 Oct 2014 13:41:14 +0800
Message-ID: <1412919676-25344-8-git-send-email-richard.zhu@freescale.com>
In-Reply-To: <1412919676-25344-1-git-send-email-richard.zhu@freescale.com>
References: <1412919676-25344-1-git-send-email-richard.zhu@freescale.com>
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
index eefedba..0c3822e 100644
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

