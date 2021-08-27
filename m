Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846FBC4320E
	for <linux-pci@archiver.kernel.org>; Fri, 27 Aug 2021 02:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB7360F92
	for <linux-pci@archiver.kernel.org>; Fri, 27 Aug 2021 02:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244052AbhH0C1o (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 26 Aug 2021 22:27:44 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:41644 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231641AbhH0C1o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Aug 2021 22:27:44 -0400
X-UUID: c2c8aed9563249638ed22e1b9c31ec59-20210827
X-UUID: c2c8aed9563249638ed22e1b9c31ec59-20210827
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 73569141; Fri, 27 Aug 2021 10:26:53 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 27 Aug 2021 10:26:52 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Aug 2021 10:26:51 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        <Rex-BC.Chen@mediatek.com>, <TingHan.Shen@mediatek.com>
Subject: [PATCH v2] dt-bindings: PCI: mediatek-gen3: Add support for MT8195
Date:   Fri, 27 Aug 2021 10:26:38 +0800
Message-ID: <20210827022638.3573-1-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MT8195 is an ARM platform SoC which has the same PCIe IP with MT8192.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index 742206dbd965..93e09c3029b7 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -48,7 +48,9 @@ allOf:
 
 properties:
   compatible:
-    const: mediatek,mt8192-pcie
+    enum:
+      - mediatek,mt8192-pcie
+      - mediatek,mt8195-pcie
 
   reg:
     maxItems: 1
-- 
2.18.0

