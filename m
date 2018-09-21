Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3504FC433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DFF206B7
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Vct+aCZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DFF206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389657AbeIUQPj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:15:39 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35388 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389559AbeIUQPi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2018 12:15:38 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8LAP2MC030867;
        Fri, 21 Sep 2018 05:25:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537525502;
        bh=G6U5swdLtcxz5b7VzXF2rNiaT43Ewb5qqlJuWNULZ/c=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Vct+aCZK3/TP7Gy127AtJeTTOnKxpcSkLgnHhs+L6Hm3itokCGMUAILJ3lytbEkfr
         jZMDOd1fuTtGnicF1aaP4h5oNglLkMj+fThi/NaMEk4JJOnLximKFMmwNL9tfPbw+U
         8WCV+CdgexjeiOLmKWjR9HdvYr8lNhasGioTdSeg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAP2JM020796;
        Fri, 21 Sep 2018 05:25:02 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 21
 Sep 2018 05:25:01 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 21 Sep 2018 05:25:01 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAMEtd032280;
        Fri, 21 Sep 2018 05:24:57 -0500
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
        <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>
Subject: [RFC PATCH 35/40] ARM: dts: keystone-k2e: Use the updated binding to describe PCIe in k2e
Date:   Fri, 21 Sep 2018 15:51:50 +0530
Message-ID: <20180921102155.22839-36-kishon@ti.com>
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

Use the updated binding to describe PCIe in k2e. (The older binding has
never worked in upstream kernel since serdes driver was never upstreamed).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/keystone-k2e.dtsi | 15 ++++++++-------
 arch/arm/boot/dts/keystone.dtsi     | 18 ++++++++++++++----
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-k2e.dtsi b/arch/arm/boot/dts/keystone-k2e.dtsi
index 085e7326ea8e..d9945d600c95 100644
--- a/arch/arm/boot/dts/keystone-k2e.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e.dtsi
@@ -136,20 +136,21 @@
 		};
 
 		pcie1: pcie@21020000 {
-			compatible = "ti,keystone-pcie","snps,dw-pcie";
+			compatible = "ti,keystone-pcie", "snps,dw-pcie";
+			reg =  <0x21020000 0x1000>, <0x21021000 0x1000>, <0x21022000 0x1000>;
+			reg-names = "app", "dbics", "config";
 			clocks = <&clkpcie1>;
-			clock-names = "pcie";
+			clock-names = "fck";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			reg =  <0x21021000 0x2000>, <0x21020000 0x1000>, <0x02620128 4>;
-			ranges = <0x82000000 0 0x60000000 0x60000000
-				  0 0x10000000>;
-
+			ranges = <0x82000000 0 0x60000000 0x60000000 0 0x10000000>;
+			ti,syscon-pcie-id = <&pcie_devid>;
+			ti,syscon-pcie-mode = <&pcie_mode>;
 			status = "disabled";
 			device_type = "pci";
 			num-lanes = <2>;
+			num-viewport = <32>;
 			bus-range = <0x00 0xff>;
-
 			/* error interrupt */
 			interrupts = <GIC_SPI 385 IRQ_TYPE_EDGE_RISING>;
 			#interrupt-cells = <1>;
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index c298675a29a5..0245fe854367 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -93,6 +93,16 @@
 			#size-cells = <1>;
 			ranges = <0x0 0x02620000 0x1000>;
 
+			pcie_devid: pcie-devid@128 {
+				compatible = "syscon";
+				reg = <0x00000128 0x4>;
+			};
+
+			pcie_mode: pcie-mode@14c {
+				compatible = "syscon";
+				reg = <0x0000014c 0x4>;
+			};
+
 			kirq0: keystone_irq@2a0 {
 				compatible = "ti,keystone-irq";
 				reg = <0x2a0 0x4>;
@@ -297,13 +307,13 @@
 
 		pcie0: pcie@21800000 {
 			compatible = "ti,keystone-pcie", "snps,dw-pcie";
+			reg =  <0x21800000 0x1000>, <0x21801000 0x1000>, <0x21802000 0x1000>;
+			reg-names = "app", "dbics", "config";
 			clocks = <&clkpcie>;
-			clock-names = "pcie";
+			clock-names = "fck";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			reg =  <0x21801000 0x2000>, <0x21800000 0x1000>, <0x02620128 4>;
-			ranges = <0x82000000 0 0x50000000 0x50000000
-				  0 0x10000000>;
+			ranges = <0x82000000 0 0x50000000 0x50000000 0 0x10000000>;
 
 			status = "disabled";
 			device_type = "pci";
-- 
2.17.1

