Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36439 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264AbbLRMja (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Dec 2015 07:39:30 -0500
Received: by mail-wm0-f51.google.com with SMTP id p187so61874369wmp.1
        for <linux-pci@vger.kernel.org>; Fri, 18 Dec 2015 04:39:30 -0800 (PST)
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
To: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Russell King <linux@arm.linux.org.uk>,
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
Subject: [PATCH v5 4/5] ARM: dts: apq8064: add pcie devicetree node
Date: Fri, 18 Dec 2015 14:38:58 +0200
Message-Id: <1450442339-18765-5-git-send-email-stanimir.varbanov@linaro.org>
In-Reply-To: <1450442339-18765-1-git-send-email-stanimir.varbanov@linaro.org>
References: <1450442339-18765-1-git-send-email-stanimir.varbanov@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add the pcie dt node so that it can probe and used.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi |   36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 1a57278cb818..495807eab8f3 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -705,5 +705,41 @@
 			compatible = "qcom,tcsr-apq8064", "syscon";
 			reg = <0x1a400000 0x100>;
 		};
+
+		pcie: pci@1b500000 {
+			compatible = "qcom,pcie-apq8064", "snps,dw-pcie";
+			reg = <0x1b500000 0x1000
+			       0x1b502000 0x80
+			       0x1b600000 0x100
+			       0x0ff00000 0x100000>;
+			reg-names = "dbi", "elbi", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x81000000 0 0 0x0fe00000 0 0x00100000   /* I/O */
+				  0x82000000 0 0 0x08000000 0 0x07e00000>; /* memory */
+			interrupts = <GIC_SPI 238 IRQ_TYPE_NONE>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 36 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 37 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 38 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 39 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+			clocks = <&gcc PCIE_A_CLK>,
+				 <&gcc PCIE_H_CLK>,
+				 <&gcc PCIE_PHY_REF_CLK>;
+			clock-names = "core", "iface", "phy";
+			resets = <&gcc PCIE_ACLK_RESET>,
+				 <&gcc PCIE_HCLK_RESET>,
+				 <&gcc PCIE_POR_RESET>,
+				 <&gcc PCIE_PCI_RESET>,
+				 <&gcc PCIE_PHY_RESET>;
+			reset-names = "axi", "ahb", "por", "pci", "phy";
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.9.5

