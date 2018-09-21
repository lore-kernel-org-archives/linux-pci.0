Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A28BECE562
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF12521547
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CEDLZ0Y5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF12521547
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390152AbeIUQQC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:16:02 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35424 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389559AbeIUQQB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2018 12:16:01 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8LAPOaA030920;
        Fri, 21 Sep 2018 05:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537525524;
        bh=XDj+mFJD+CB99IbCn09zPB+O+0SrSz7pxE0ENLfnd3U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CEDLZ0Y5yKRNRb+NyrPFti9OQvBLmegwPFs4roceFaJrWIMJ+N2ZZtiXa6cJp/zIG
         P3TxQT7KsyhmKqx08V1g3FKTVRTFY0xPBQPkVvbbNnNS8O8vaP+bpcwkCw2FPM7Ojz
         WWn2N7D4s9daIrSNzlQgN4wzWf6R2+vQOVpcc3Cc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAPORG021767;
        Fri, 21 Sep 2018 05:25:24 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 21
 Sep 2018 05:25:24 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 21 Sep 2018 05:25:24 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAMEti032280;
        Fri, 21 Sep 2018 05:25:20 -0500
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
Subject: [RFC PATCH 40/40] arm64: dts: k3-am6: Add Root Complex PCIe dt node
Date:   Fri, 21 Sep 2018 15:51:55 +0530
Message-ID: <20180921102155.22839-41-kishon@ti.com>
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

Add Root Complex PCIe dt node.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 83 ++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65.dtsi      |  1 +
 2 files changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index b08d15fa110e..0a5d74a8eef4 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -14,6 +14,21 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x00100000 0x1c000>;
 
+		pcie0_mode: pcie-mode@4060 {
+			compatible = "syscon";
+			reg = <0x00004060 0x4>;
+		};
+
+		pcie1_mode: pcie-mode@4070 {
+			compatible = "syscon";
+			reg = <0x00004070 0x4>;
+		};
+
+		pcie_devid: pcie-devid@210 {
+			compatible = "syscon";
+			reg = <0x00000210 0x4>;
+		};
+
 		serdes0_clk: serdes_clk@4080 {
 			compatible = "syscon";
 			reg = <0x00004080 0x4>;
@@ -128,4 +143,72 @@
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
 	};
+
+	pcie0_rc: pcie@5500000 {
+		compatible = "ti,am654-pcie-rc";
+		reg =  <0x0 0x5500000 0x0 0x1000>, <0x0 0x5501000 0x0 0x1000>, <0x0 0x10000000 0x0 0x2000>, <0x0 0x5506000 0x0 0x1000>;
+		reg-names = "app", "dbics", "config", "atu";
+		power-domains = <&k3_pds 120>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges = <0x81000000 0 0          0x0 0x10020000 0 0x00010000
+			  0x82000000 0 0x10030000 0x0 0x10030000 0 0x07FD0000>;
+		ti,syscon-pcie-id = <&pcie_devid>;
+		ti,syscon-pcie-mode = <&pcie0_mode>;
+		bus-range = <0x0 0xff>;
+		device_type = "pci";
+		num-lanes = <1>;
+		num-ob-windows = <16>;
+		num-viewport = <16>;
+		interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie0_intc 0>, /* INT A */
+				<0 0 0 2 &pcie0_intc 0>, /* INT B */
+				<0 0 0 3 &pcie0_intc 0>, /* INT C */
+				<0 0 0 4 &pcie0_intc 0>; /* INT D */
+		msi-map = <0x0 &gic_its 0x0 0x10000>;
+		status = "disabled";
+
+		pcie0_intc: legacy-interrupt-controller@1 {
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>;
+		};
+	};
+
+	pcie1_rc: pcie@5600000 {
+		compatible = "ti,am654-pcie-rc";
+		reg =  <0x0 0x5600000 0x0 0x1000>, <0x0 0x5601000 0x0 0x1000>, <0x0 0x18000000 0x0 0x2000>, <0x0 0x5606000 0x0 0x1000>;
+		reg-names = "app", "dbics", "config", "atu";
+		power-domains = <&k3_pds 121>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges = <0x81000000 0 0          0x0   0x18020000 0 0x00010000
+			  0x82000000 0 0x18030000 0x0   0x18030000 0 0x07FD0000>;
+		ti,syscon-pcie-id = <&pcie_devid>;
+		ti,syscon-pcie-mode = <&pcie1_mode>;
+		bus-range = <0x0 0xff>;
+		status = "disabled";
+		device_type = "pci";
+		num-lanes = <1>;
+		num-ob-windows = <16>;
+		num-viewport = <16>;
+		interrupts = <GIC_SPI 355 IRQ_TYPE_EDGE_RISING>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie1_intc 0>, /* INT A */
+				<0 0 0 2 &pcie1_intc 0>, /* INT B */
+				<0 0 0 3 &pcie1_intc 0>, /* INT C */
+				<0 0 0 4 &pcie1_intc 0>; /* INT D */
+		msi-map = <0x0 &gic_its 0x10000 0x10000>;
+
+		pcie1_intc: legacy-interrupt-controller@1 {
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 343 IRQ_TYPE_EDGE_RISING>;
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
index 3d4bf369d030..b87081765894 100644
--- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
@@ -61,6 +61,7 @@
 			 <0x00 0x00900000 0x00 0x00900000 0x00 0x00012000>, /* serdes */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0af02400>, /* Most peripherals */
 			 <0x00 0x30800000 0x00 0x30800000 0x00 0x0bc00000>, /* MAIN NAVSS */
+			 <0x00 0x10000000 0x00 0x10000000 0x00 0x10000000>, /* PCIe DAT */
 			 /* MCUSS Range */
 			 <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>,
 			 <0x00 0x40200000 0x00 0x40200000 0x00 0x00900100>,
-- 
2.17.1

