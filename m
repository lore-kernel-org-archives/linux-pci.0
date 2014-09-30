Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0134.outbound.protection.outlook.com ([157.56.110.134]:56640
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752043AbaI3KHJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 30 Sep 2014 06:07:09 -0400
From: Richard Zhu <r65037@freescale.com>
To: <linux-pci-owner@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <shawn.guo@freescale.com>,
	<festevam@gmail.com>, <l.stach@pengutronix.de>,
	<tharvey@gateworks.com>, Richard Zhu <r65037@freescale.com>
Subject: [PATCH v4 06/10] ARM: imx6qdl: enable pcie on imx6qdl sabreauto
Date: Tue, 30 Sep 2014 17:36:40 +0800
Message-ID: <1412069804-17162-7-git-send-email-r65037@freescale.com>
In-Reply-To: <1412069804-17162-1-git-send-email-r65037@freescale.com>
References: <1412069804-17162-1-git-send-email-r65037@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

- enable pcie on imx6qdl sabreauto boards.

Signed-off-by: Richard Zhu <r65037@freescale.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 009abd6..d6040a5 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -410,6 +410,10 @@
 	};
 };
 
+&pcie {
+	status = "okay";
+};
+
 &pwm3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
-- 
1.9.1

