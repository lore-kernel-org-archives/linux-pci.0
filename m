Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859B0ECE562
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404DB206B7
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R7EMEBgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404DB206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390071AbeIUQP5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:15:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46610 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389559AbeIUQP4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2018 12:15:56 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8LAPKjm008199;
        Fri, 21 Sep 2018 05:25:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537525520;
        bh=Hx6wSR+rqqvmzg8ziF4Yx5EsYxtHEdd50Pac9BsuRBs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=R7EMEBgb9B0+Tb+i5yYrhikXNmCTxmD+OAmLGddR1d4DD7gT7qD0i2383LRd5E5m9
         XwZ/1n46wHBzjRTBnhkzlHZ2gvq5NpQPZ/yeug7w3cs4JvdQLTlXq3cn9TpjhsOB27
         mwgFMeNtl5cVkD15JSg0VV5DFeD+/E4NwRUtrmhg=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAPKil032372;
        Fri, 21 Sep 2018 05:25:20 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 21
 Sep 2018 05:25:20 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 21 Sep 2018 05:25:20 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAMEth032280;
        Fri, 21 Sep 2018 05:25:15 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <Gustavo.Pimentel@synopsys.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 39/40] arm64: dts: k3-am6: Add SERDES DT node
Date:   Fri, 21 Sep 2018 15:51:54 +0530
Message-ID: <20180921102155.22839-40-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add DT node for SERDES0 and SERDES1.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 46 ++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 4379c370f6f8..b08d15fa110e 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -4,11 +4,25 @@
  *
  * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
  */
+#include <dt-bindings/phy/phy-am654-serdes.h>
 
 &cbass_main {
 	scm_conf: scm_conf@100000 {
 		compatible = "syscon", "simple-mfd";
 		reg = <0 0x00100000 0 0x1c000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x00100000 0x1c000>;
+
+		serdes0_clk: serdes_clk@4080 {
+			compatible = "syscon";
+			reg = <0x00004080 0x4>;
+		};
+
+		serdes1_clk: serdes_clk@4090 {
+			compatible = "syscon";
+			reg = <0x00004090 0x4>;
+		};
 
 		serdes_mux: mux-controller {
 			compatible = "mmio-mux";
@@ -53,6 +67,38 @@
 		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	serdes0: serdes@900000 {
+		compatible = "ti,phy-am654-serdes";
+		reg = <0x0 0x900000 0x0 0x2000>;
+		reg-names = "serdes";
+		#phy-cells = <2>;
+		power-domains = <&k3_pds 153>;
+		clocks = <&k3_clks 153 4>, <&k3_clks 153 1>, <&serdes1 AM654_SERDES_LO_REFCLK>;
+		clock-output-names = "serdes0_cmu_refclk", "serdes0_lo_refclk", "serdes0_ro_refclk";
+		assigned-clocks = <&k3_clks 153 4>, <&serdes0 AM654_SERDES_CMU_REFCLK>;
+		assigned-clock-parents = <&k3_clks 153 8>, <&k3_clks 153 4>;
+		ti,serdes-clk = <&serdes0_clk>;
+		#clock-cells = <1>;
+		mux-controls = <&serdes_mux 0>;
+		status = "disabled";
+	};
+
+	serdes1: serdes@910000 {
+		compatible = "ti,phy-am654-serdes";
+		reg = <0x0 0x910000 0x0 0x2000>;
+		reg-names = "serdes";
+		#phy-cells = <2>;
+		power-domains = <&k3_pds 154>;
+		clocks = <&serdes0 AM654_SERDES_RO_REFCLK>, <&k3_clks 154 1>, <&k3_clks 154 5>;
+		clock-output-names = "serdes1_cmu_refclk", "serdes1_lo_refclk", "serdes1_ro_refclk";
+		assigned-clocks = <&k3_clks 154 5>, <&serdes1 AM654_SERDES_CMU_REFCLK>;
+		assigned-clock-parents = <&k3_clks 154 9>, <&k3_clks 154 5>;
+		ti,serdes-clk = <&serdes1_clk>;
+		#clock-cells = <1>;
+		mux-controls = <&serdes_mux 1>;
+		status = "disabled";
+	};
+
 	main_uart0: serial@2800000 {
 		compatible = "ti,am654-uart";
 		reg = <0x00 0x02800000 0x00 0x100>;
-- 
2.17.1

