Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7141AC7112A
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 08:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E902086A
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 08:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E902086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeJOPxb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:53:31 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:5739 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726764AbeJOPxb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Oct 2018 11:53:31 -0400
X-UUID: b976cc221a1146d2850bc604aa247955-20181015
X-UUID: b976cc221a1146d2850bc604aa247955-20181015
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1885654133; Mon, 15 Oct 2018 16:09:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 15 Oct 2018 16:09:11 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 15 Oct 2018 16:09:10 +0800
From:   <honghui.zhang@mediatek.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ryder.lee@mediatek.com>
CC:     <ulf.hansson@linaro.org>, <marc.zyngier@arm.com>,
        <matthias.bgg@gmail.com>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <honghui.zhang@mediatek.com>, <youlin.pei@mediatek.com>,
        <yt.shen@mediatek.com>, <jianjun.wang@mediatek.com>,
        <yong.wu@mediatek.com>
Subject: [PATCH v8 8/9] PCI: mediatek: Save the GIC IRQ in mtk_pcie_port
Date:   Mon, 15 Oct 2018 16:08:59 +0800
Message-ID: <1539590940-13355-9-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1539590940-13355-1-git-send-email-honghui.zhang@mediatek.com>
References: <1539590940-13355-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

Need to save the PCIe's GIC IRQ for dispose_irq, this is a prepare
patch for add mediatek PCIe module support to tear down the IRQ, no
functional changed.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 42cf2a4..daba78f 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -162,6 +162,7 @@ struct mtk_pcie_soc {
  * @phy: pointer to PHY control block
  * @lane: lane count
  * @slot: port slot
+ * @irq: GIC irq
  * @irq_domain: legacy INTx IRQ domain
  * @inner_domain: inner IRQ domain
  * @msi_domain: MSI IRQ domain
@@ -182,6 +183,7 @@ struct mtk_pcie_port {
 	struct phy *phy;
 	u32 lane;
 	u32 slot;
+	int irq;
 	struct irq_domain *irq_domain;
 	struct irq_domain *inner_domain;
 	struct irq_domain *msi_domain;
@@ -620,7 +622,7 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
 	struct mtk_pcie *pcie = port->pcie;
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	int err, irq;
+	int err;
 
 	err = mtk_pcie_init_irq_domain(port, node);
 	if (err) {
@@ -628,8 +630,9 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
 		return err;
 	}
 
-	irq = platform_get_irq(pdev, port->slot);
-	irq_set_chained_handler_and_data(irq, mtk_pcie_intr_handler, port);
+	port->irq = platform_get_irq(pdev, port->slot);
+	irq_set_chained_handler_and_data(port->irq,
+					 mtk_pcie_intr_handler, port);
 
 	return 0;
 }
-- 
2.6.4

