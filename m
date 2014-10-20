Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [157.56.110.130] ([157.56.110.130]:39828 "EHLO
	na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752096AbaJTCve (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 19 Oct 2014 22:51:34 -0400
From: Richard Zhu <richard.zhu@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <shawn.guo@freescale.com>, <festevam@gmail.com>,
	<l.stach@pengutronix.de>, <tharvey@gateworks.com>,
	Richard Zhu <r65037@freescale.com>,
	Richard Zhu <richard.zhu@freescale.com>
Subject: [PATCH v7 10/13] ARM: imx6qdl: Enable pcie on imx6qdl sabreauto
Date: Mon, 20 Oct 2014 10:19:13 +0800
Message-ID: <1413771556-32212-11-git-send-email-richard.zhu@freescale.com>
In-Reply-To: <1413771556-32212-1-git-send-email-richard.zhu@freescale.com>
References: <1413771556-32212-1-git-send-email-richard.zhu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Richard Zhu <r65037@freescale.com>

- enable pcie on imx6qdl sabreauto boards.

Signed-off-by: Richard Zhu <richard.zhu@freescale.com>
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

