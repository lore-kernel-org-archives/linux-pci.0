Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D51C65BAE
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 01:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3232F20879
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 01:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3232F20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbeLNBZz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:25:55 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:46181 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727638AbeLNBZy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Dec 2018 20:25:54 -0500
X-UUID: 01e388c211be4746a3e9218d664d41fa-20181214
X-UUID: 01e388c211be4746a3e9218d664d41fa-20181214
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2026839957; Fri, 14 Dec 2018 09:25:47 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Dec 2018 09:25:46 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 09:25:44 +0800
From:   <honghui.zhang@mediatek.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ryder.lee@mediatek.com>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>, <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <youlin.pei@mediatek.com>,
        <jianjun.wang@mediatek.com>,
        Honghui Zhang <honghui.zhang@mediatek.com>
Subject: [PATCH 1/4] PCI: mediatek: Remove un-used variant in struct mtk_pcie_port
Date:   Fri, 14 Dec 2018 09:25:39 +0800
Message-ID: <1544750742-31419-2-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1544750742-31419-1-git-send-email-honghui.zhang@mediatek.com>
References: <1544750742-31419-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

The "lane" variant in struct mtk_pcie_port is not used, remove it.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 6917aec..e307166 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -161,7 +161,6 @@ struct mtk_pcie_soc {
  * @obff_ck: pointer to OBFF functional block operating clock
  * @pipe_ck: pointer to LTSSM and PHY/MAC layer operating clock
  * @phy: pointer to PHY control block
- * @lane: lane count
  * @slot: port slot
  * @irq: GIC irq
  * @irq_domain: legacy INTx IRQ domain
@@ -182,7 +181,6 @@ struct mtk_pcie_port {
 	struct clk *obff_ck;
 	struct clk *pipe_ck;
 	struct phy *phy;
-	u32 lane;
 	u32 slot;
 	int irq;
 	struct irq_domain *irq_domain;
@@ -895,12 +893,6 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
 	if (!port)
 		return -ENOMEM;
 
-	err = of_property_read_u32(node, "num-lanes", &port->lane);
-	if (err) {
-		dev_err(dev, "missing num-lanes property\n");
-		return err;
-	}
-
 	snprintf(name, sizeof(name), "port%d", slot);
 	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
 	port->base = devm_ioremap_resource(dev, regs);
-- 
2.6.4

