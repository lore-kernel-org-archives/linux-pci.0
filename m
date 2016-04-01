Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ibawizard.net ([82.208.49.253]:56493 "EHLO
	mengele.ibawizard.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbcDAMuw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Apr 2016 08:50:52 -0400
From: =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
To: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Russell King <linux@arm.linux.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Tim Harvey <tharvey@gateworks.com>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	Fabio Estevam <festevam@gmail.com>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>, stefan@agner.ch,
	=?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
Subject: [PATCH 1/2] ARM: dts: imx6: Fix PCIe reset gpio polarity on Toradex Apalis Ixora
Date: Fri,  1 Apr 2016 14:41:47 +0200
Message-Id: <1459514508-8557-2-git-send-email-ynezz@true.cz>
In-Reply-To: <1459514508-8557-1-git-send-email-ynezz@true.cz>
References: <1459514508-8557-1-git-send-email-ynezz@true.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adding reset-gpio-active-high boolean DT binding property, which we need
to make PCIe working on Apalis SoMs and not break old DTBs. While at it,
I've fixed comment and GPIO polarity.

On Apalis SoMs the GPIO1_IO28 used to PCIe reset is not connected
directly to PERST# PCIe signal, but it's ORed with RESETBMCU coming off
the PMIC, and thus is inverted, active-high.

Signed-off-by: Petr Štetiar <ynezz@true.cz>
---
 arch/arm/boot/dts/imx6q-apalis-ixora.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index 2cba82d..4b533cb 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -174,8 +174,9 @@
 };
 
 &pcie {
-	/* active-low meaning opposite of regular PERST# active-low polarity */
-	reset-gpio = <&gpio1 28 GPIO_ACTIVE_LOW>;
+	/* active-high meaning opposite of regular PERST# active-low polarity */
+	reset-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+	reset-gpio-active-high;
 	status = "okay";
 };
 
-- 
1.9.1

