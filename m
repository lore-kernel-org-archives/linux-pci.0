Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0102.outbound.protection.outlook.com ([207.46.100.102]:58097
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750768AbaI2FdU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 29 Sep 2014 01:33:20 -0400
From: Richard Zhu <r65037@freescale.com>
To: <linux-pci-owner@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <shawn.guo@freescale.com>,
	<festevam@gmail.com>, <l.stach@pengutronix.de>,
	<tharvey@gateworks.com>, Richard Zhu <r65037@freescale.com>
Subject: [PATCH v3 2/9] PCI: imx6: enable pcie on imx6qdl sabreauto
Date: Mon, 29 Sep 2014 13:03:10 +0800
Message-ID: <1411966997-27118-3-git-send-email-r65037@freescale.com>
In-Reply-To: <1411966997-27118-1-git-send-email-r65037@freescale.com>
References: <1411966997-27118-1-git-send-email-r65037@freescale.com>
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

