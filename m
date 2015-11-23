Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34323 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233AbbKWJ3t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Nov 2015 04:29:49 -0500
Received: by wmvv187 with SMTP id v187so151095863wmv.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2015 01:29:48 -0800 (PST)
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
To: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 6/6] ARM: dts: ifc6410: enable pcie dt node for this board
Date: Mon, 23 Nov 2015 11:29:03 +0200
Message-Id: <c197002de845b07e4980b203f2fbd28469ee1ce8.1448270813.git.stanimir.varbanov@linaro.org>
In-Reply-To: <cover.1448270813.git.stanimir.varbanov@linaro.org>
References: <cover.1448270813.git.stanimir.varbanov@linaro.org>
In-Reply-To: <cover.1448270813.git.stanimir.varbanov@linaro.org>
References: <cover.1448270813.git.stanimir.varbanov@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enable pcie dt node and fill pcie dt node with regulator, pinctrl
and reset gpio, to use the pcie on the ifc6410 board.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index 11ac608b6d50..bdee36a9b418 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -47,6 +47,18 @@
 					bias-disable;
 				};
 			};
+
+			pcie0_pins: pcie0_pinmux {
+				mux {
+					pins = "gpio27";
+					function = "gpio";
+				};
+				conf {
+					pins = "gpio27";
+					drive-strength = <12>;
+					bias-disable;
+				};
+			};
 		};
 
 		rpm@108000 {
@@ -123,6 +135,10 @@
 				pm8921_lvs1: lvs1 {
 					bias-pull-down;
 				};
+
+				pm8921_lvs6: lvs6 {
+					bias-pull-down;
+				};
 			};
 		};
 
@@ -231,6 +247,16 @@
 			status = "okay";
 		};
 
+		pci@1b500000 {
+			status = "ok";
+			vdda-supply = <&pm8921_s3>;
+			vdda_phy-supply = <&pm8921_lvs6>;
+			vdda_refclk-supply = <&ext_3p3v>;
+			pinctrl-0 = <&pcie0_pins>;
+			pinctrl-names = "default";
+			perst-gpio = <&tlmm_pinmux 27 GPIO_ACTIVE_LOW>;
+		};
+
 		qcom,ssbi@500000 {
 			pmic@0 {
 				gpio@150 {
-- 
1.7.9.5

