Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B6CC67872
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 01:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE9420879
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 01:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE9420879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbeLNB0A (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:26:00 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:22115 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727901AbeLNBZz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Dec 2018 20:25:55 -0500
X-UUID: 05ce704fa55e47f891ad6b3062800876-20181214
X-UUID: 05ce704fa55e47f891ad6b3062800876-20181214
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2041086221; Fri, 14 Dec 2018 09:25:48 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Dec 2018 09:25:46 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 09:25:45 +0800
From:   <honghui.zhang@mediatek.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ryder.lee@mediatek.com>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>, <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <youlin.pei@mediatek.com>,
        <jianjun.wang@mediatek.com>,
        Honghui Zhang <honghui.zhang@mediatek.com>
Subject: [PATCH 2/4] dt-bindings: PCI: MediaTek: Remove un-used property
Date:   Fri, 14 Dec 2018 09:25:40 +0800
Message-ID: <1544750742-31419-3-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1544750742-31419-1-git-send-email-honghui.zhang@mediatek.com>
References: <1544750742-31419-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 476BBAF8048127866DD3CAE02BA0EED37B745FED16F4473F0C8DCC23C07537D52000:8
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

The "num-lanes" property is not used, remove it.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 Documentation/devicetree/bindings/pci/mediatek-pcie.txt | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
index 20227a8..92437a3 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
@@ -65,7 +65,6 @@ Required properties:
   explanation.
 - ranges: Sub-ranges distributed from the PCIe controller node. An empty
   property is sufficient.
-- num-lanes: Number of lanes to use for this port.
 
 Examples for MT7623:
 
@@ -118,7 +117,6 @@ Examples for MT7623:
 			interrupt-map-mask = <0 0 0 0>;
 			interrupt-map = <0 0 0 0 &sysirq GIC_SPI 193 IRQ_TYPE_LEVEL_LOW>;
 			ranges;
-			num-lanes = <1>;
 		};
 
 		pcie@1,0 {
@@ -129,7 +127,6 @@ Examples for MT7623:
 			interrupt-map-mask = <0 0 0 0>;
 			interrupt-map = <0 0 0 0 &sysirq GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
 			ranges;
-			num-lanes = <1>;
 		};
 
 		pcie@2,0 {
@@ -140,7 +137,6 @@ Examples for MT7623:
 			interrupt-map-mask = <0 0 0 0>;
 			interrupt-map = <0 0 0 0 &sysirq GIC_SPI 195 IRQ_TYPE_LEVEL_LOW>;
 			ranges;
-			num-lanes = <1>;
 		};
 	};
 
@@ -172,7 +168,6 @@ Examples for MT2712:
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges;
-			num-lanes = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
 					<0 0 0 2 &pcie_intc0 1>,
@@ -191,7 +186,6 @@ Examples for MT2712:
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges;
-			num-lanes = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
 					<0 0 0 2 &pcie_intc1 1>,
@@ -245,7 +239,6 @@ Examples for MT7622:
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges;
-			num-lanes = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
 					<0 0 0 2 &pcie_intc0 1>,
@@ -264,7 +257,6 @@ Examples for MT7622:
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges;
-			num-lanes = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
 					<0 0 0 2 &pcie_intc1 1>,
-- 
2.6.4

