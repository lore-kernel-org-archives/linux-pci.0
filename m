Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C206AECE562
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0082154B
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BAU5Bher"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0082154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389722AbeIUQPv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:15:51 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54806 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389559AbeIUQPv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2018 12:15:51 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8LAPFDA033166;
        Fri, 21 Sep 2018 05:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537525515;
        bh=o42oR+cPzXSXz2nnwYCWDDPfzIB1x+eMkvxWlBXLaII=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BAU5Bherd0RDmlZd6/0Drqx+b9lQiiTTq5eEYnRpobjX3keF+XiPkNf22MDpU3+1q
         Xz7ve5boMmrp0nBAAcxFzeFVHLlrLc+Z3zRb8AR2BUUNi57o4T2A5khWfCDKuqH5aL
         6WDd6CLU5+RNSROmPoCVPGjBMvJVHSlMGhQHfxf0=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAPFqM021583;
        Fri, 21 Sep 2018 05:25:15 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 21
 Sep 2018 05:25:15 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 21 Sep 2018 05:25:15 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAMEtg032280;
        Fri, 21 Sep 2018 05:25:11 -0500
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
Subject: [RFC PATCH 38/40] arm64: dts: k3-am6: Add mux-controller dt node required for muxing SERDES
Date:   Fri, 21 Sep 2018 15:51:53 +0530
Message-ID: <20180921102155.22839-39-kishon@ti.com>
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

Add mux-controller dt node as a child node of scm_conf. This is
required for muxing SERDES between USB, PCIe and ICSS2 SGMII. While
at that also add "simple-mfd" compatible string to scm_conf dt node
so that mux-controller device gets created.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 957c9125a453..4379c370f6f8 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -7,8 +7,15 @@
 
 &cbass_main {
 	scm_conf: scm_conf@100000 {
-		compatible = "syscon";
+		compatible = "syscon", "simple-mfd";
 		reg = <0 0x00100000 0 0x1c000>;
+
+		serdes_mux: mux-controller {
+			compatible = "mmio-mux";
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x4080 0x3>, /* SERDES0 lane select */
+					<0x4090 0x3>; /* SERDES1 lane select */
+		};
 	};
 
 	gic500: interrupt-controller@1800000 {
-- 
2.17.1

