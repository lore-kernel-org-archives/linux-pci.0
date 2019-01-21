Return-Path: <SRS0=cv1o=P5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61C1C7112F
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 11:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67B120870
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 11:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfAULLO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:11:14 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:36359 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727152AbfAULLN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jan 2019 06:11:13 -0500
X-UUID: 31da44e5a0dc41b788e001276bb13134-20190121
X-UUID: 31da44e5a0dc41b788e001276bb13134-20190121
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1579646082; Mon, 21 Jan 2019 19:11:08 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 21 Jan 2019 19:11:06 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 21 Jan 2019 19:11:06 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <ryder.lee@mediatek.com>,
        <mark.rutland@arm.com>
CC:     <matthias.bgg@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <honghui.zhang@mediatek.com>, <youlin.pei@mediatek.com>,
        <jianjun.wang@mediatek.com>
Subject: [v1,1/2] dt-bindings: PCI: Add support for MT7629
Date:   Mon, 21 Jan 2019 19:11:01 +0800
Message-ID: <1548069062-12430-2-git-send-email-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1548069062-12430-1-git-send-email-jianjun.wang@mediatek.com>
References: <1548069062-12430-1-git-send-email-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MT7629 is an ARM platform Soc which has the same PCIe IP with MT7622.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 Documentation/devicetree/bindings/pci/mediatek-pcie.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
index 92437a366e5f..7468d666763a 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
@@ -6,6 +6,7 @@ Required properties:
 	"mediatek,mt2712-pcie"
 	"mediatek,mt7622-pcie"
 	"mediatek,mt7623-pcie"
+	"mediatek,mt7629-pcie"
 - device_type: Must be "pci"
 - reg: Base addresses and lengths of the PCIe subsys and root ports.
 - reg-names: Names of the above areas to use during resource lookup.
-- 
2.20.1

