Return-Path: <SRS0=mKlk=QB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFB2C282C6
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 23:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB308218CD
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 23:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mv2+dkNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbfAYXp4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:45:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33763 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729657AbfAYXps (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jan 2019 18:45:48 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so4841645pgu.0
        for <linux-pci@vger.kernel.org>; Fri, 25 Jan 2019 15:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xkiykm+iIdEw+kUjDsxAkLCG9M3FjlogGZBSkl9Jpc8=;
        b=Mv2+dkNbL0k5DvH4k0022xpt2XmaRAc3I/c6yTkAlZO7gKJ9L1CsGKCt5dboV0533Z
         R0GkYbcpI3KBHaiYUAWvyyBviw84fMv5m12TT23GTWp3SzRW8jBm/hFEZUkWMw73mLjX
         /uhHkroDHqfm+09j17kps0INpuekC0NcqagDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xkiykm+iIdEw+kUjDsxAkLCG9M3FjlogGZBSkl9Jpc8=;
        b=lt7yHcE61WrmzkrNo/A28z1tEezx+he7UbHuhTMqvRwvpC7MEeEtG7Sx3GhmqdodLh
         /cFDAAOPmUAmD1ryRpUNlDC2BfdNM8lVdpLFMSocCX5skVHIwzpxk5e3grAlJiBrEdoq
         Ons71UTEyhL3nGtDkTFJ5e1qKOuvSBE8udbaz+gyWIrOBVMjz+nSd6MEK8JOYUYSuSVK
         Q9WdPdpCJemLPpsUfXGAjWMnMS9QNyO4C2hq6Wo7bgqTLXudoEivBJLokZCLm8RSdBwH
         be7u/T3eMFXLvFudk2eRsBZeXv4HPENKOdY8lh3CrHBoIwldVtzbiEz7++kA9xxawrT0
         GPpA==
X-Gm-Message-State: AJcUukdsZ1EWLJNXBssYiYNKabQ3pNDxlPF2lomcdcP060jOpIz8jyIB
        EaqSms/ELDT3IM3jLw78Jqn+MjpQUAU=
X-Google-Smtp-Source: ALg8bN47AyVWb2dmcHkZlYj6kIGia/aaDXfvewhjgOacXE/URcaisUDG81MuFD5ZdZSylHKCrRt2Xg==
X-Received: by 2002:a63:24c2:: with SMTP id k185mr11426478pgk.406.1548459946951;
        Fri, 25 Jan 2019 15:45:46 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y9sm32950302pfi.74.2019.01.25.15.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 15:45:46 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        David Brown <david.brown@linaro.org>,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 7/7] arm64: dts: qcom: qcs404: Add PCIe related nodes
Date:   Fri, 25 Jan 2019 15:45:09 -0800
Message-Id: <20190125234509.26419-8-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190125234509.26419-1-bjorn.andersson@linaro.org>
References: <20190125234509.26419-1-bjorn.andersson@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The QCS404 has a PCIe2 PHY and a Qualcomm PCIe controller, add these to
the platform dtsi and enable them for the EVB with the perst gpio
and analog supplies defined.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 25 +++++++++
 arch/arm64/boot/dts/qcom/qcs404.dtsi     | 67 ++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 50b3589c7f15..579ddaf4f5fa 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -21,6 +21,22 @@
 	};
 };
 
+&pcie {
+	status = "ok";
+
+	perst-gpio = <&tlmm 43 GPIO_ACTIVE_LOW>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&perst_state>;
+};
+
+&pcie_phy {
+	status = "ok";
+
+	vdda-vp-supply = <&vreg_l3_1p05>;
+	vdda-vph-supply = <&vreg_l5_1p8>;
+};
+
 &remoteproc_adsp {
 	status = "ok";
 };
@@ -137,6 +153,15 @@
 };
 
 &tlmm {
+	perst_state: perst {
+		pins = "gpio43";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+
 	sdc1_on: sdc1-on {
 		clk {
 			pins = "sdc1_clk";
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 76699435c8bd..7b219865ba7e 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -3,6 +3,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-qcs404.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -377,6 +378,7 @@
 			compatible = "qcom,gcc-qcs404";
 			reg = <0x01800000 0x80000>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 
 			assigned-clocks = <&gcc GCC_APSS_AHB_CLK_SRC>;
 			assigned-clock-rates = <19200000>;
@@ -405,6 +407,21 @@
 			#interrupt-cells = <4>;
 		};
 
+		pcie_phy: phy@7786000 {
+			compatible = "qcom,qcs404-pcie2-phy", "qcom,pcie2-phy";
+			reg = <0x07786000 0xb8>;
+
+			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
+			resets = <&gcc GCC_PCIEPHY_0_PHY_BCR>,
+				 <&gcc GCC_PCIE_0_PIPE_ARES>;
+			reset-names = "phy", "pipe";
+
+			clock-output-names = "pcie_0_pipe_clk";
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
 		sdcc1: sdcc@7804000 {
 			compatible = "qcom,sdhci-msm-v5";
 			reg = <0x07804000 0x1000>, <0x7805000 0x1000>;
@@ -771,6 +788,56 @@
 				status = "disabled";
 			};
 		};
+
+		pcie: pci@10000000 {
+			compatible = "qcom,pcie-qcs404", "snps,dw-pcie";
+			reg =  <0x10000000 0xf1d
+				0x10000f20 0xa8
+				0x07780000 0x2000
+				0x10001000 0x2000>;
+			reg-names = "dbi", "elbi", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x81000000 0 0          0x10003000 0 0x00010000   /* I/O */
+				  0x82000000 0 0x10013000 0x10013000 0 0x007ed000>; /* memory */
+
+			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+			clocks = <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>;
+			clock-names = "iface", "aux", "master_bus", "slave_bus";
+
+			resets = <&gcc GCC_PCIE_0_AXI_MASTER_ARES>,
+				 <&gcc GCC_PCIE_0_AXI_SLAVE_ARES>,
+				 <&gcc GCC_PCIE_0_AXI_MASTER_STICKY_ARES>,
+				 <&gcc GCC_PCIE_0_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE_0_BCR>,
+				 <&gcc GCC_PCIE_0_AHB_ARES>;
+			reset-names = "axi_m",
+				      "axi_s",
+				      "axi_m_sticky",
+				      "pipe_sticky",
+				      "pwr",
+				      "ahb";
+
+			phys = <&pcie_phy>;
+			phy-names = "pciephy";
+
+			status = "disabled";
+		};
 	};
 
 	timer {
-- 
2.18.0

