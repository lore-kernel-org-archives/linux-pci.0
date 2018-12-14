Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE60EC67872
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 01:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4AA2075B
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 01:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4AA2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbeLNB0D (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:26:03 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:55811 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728927AbeLNB0C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Dec 2018 20:26:02 -0500
X-UUID: 42e937a1b6194ef0802b405786a2c17d-20181214
X-UUID: 42e937a1b6194ef0802b405786a2c17d-20181214
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 956507524; Fri, 14 Dec 2018 09:25:49 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Dec 2018 09:25:48 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 09:25:47 +0800
From:   <honghui.zhang@mediatek.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ryder.lee@mediatek.com>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>, <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <youlin.pei@mediatek.com>,
        <jianjun.wang@mediatek.com>,
        Honghui Zhang <honghui.zhang@mediatek.com>
Subject: [PATCH 4/4] arm64: dts: mt7622: Remove un-used property for PCIe
Date:   Fri, 14 Dec 2018 09:25:42 +0800
Message-ID: <1544750742-31419-5-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1544750742-31419-1-git-send-email-honghui.zhang@mediatek.com>
References: <1544750742-31419-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 879A224954563394A6F87C97A25AF00FB82AA502720284E2262449B230922BF52000:8
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

The "num-lanes" property for PCIe is not used, remove it.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index de2c47bd..f619eb5 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -750,7 +750,6 @@
 			ranges;
 			status = "disabled";
 
-			num-lanes = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
 					<0 0 0 2 &pcie_intc0 1>,
@@ -771,7 +770,6 @@
 			ranges;
 			status = "disabled";
 
-			num-lanes = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
 					<0 0 0 2 &pcie_intc1 1>,
-- 
2.6.4

