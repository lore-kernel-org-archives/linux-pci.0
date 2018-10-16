Return-Path: <SRS0=JYfi=M4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74926C18DF5
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 10:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA9B21486
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 10:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA9B21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbeJPSey (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:34:54 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:54051 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727051AbeJPSex (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Oct 2018 14:34:53 -0400
X-UUID: 37acdab3121c4a26b78c348a3754dc42-20181016
X-UUID: 37acdab3121c4a26b78c348a3754dc42-20181016
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 91992662; Tue, 16 Oct 2018 18:44:57 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 16 Oct 2018 18:44:56 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 16 Oct 2018 18:44:55 +0800
From:   <honghui.zhang@mediatek.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ryder.lee@mediatek.com>
CC:     <ulf.hansson@linaro.org>, <marc.zyngier@arm.com>,
        <matthias.bgg@gmail.com>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <honghui.zhang@mediatek.com>, <youlin.pei@mediatek.com>,
        <yt.shen@mediatek.com>, <jianjun.wang@mediatek.com>
Subject: [PATCH v9 4/9] PCI: mediatek: Convert to use pci_host_probe()
Date:   Tue, 16 Oct 2018 18:44:45 +0800
Message-ID: <1539686690-24068-5-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1539686690-24068-1-git-send-email-honghui.zhang@mediatek.com>
References: <1539686690-24068-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

Part of mtk_pcie_register_host is an open-coded version of
pci_host_probe(). So instead of duplicating this code, use
pci_host_probe() directly and remove mtk_pcie_register_host.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 37 ++++++++--------------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 6080b29..9f12b17 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -1121,34 +1121,6 @@ static int mtk_pcie_request_resources(struct mtk_pcie *pcie)
 	return 0;
 }
 
-static int mtk_pcie_register_host(struct pci_host_bridge *host)
-{
-	struct mtk_pcie *pcie = pci_host_bridge_priv(host);
-	struct pci_bus *child;
-	int err;
-
-	host->busnr = pcie->busn.start;
-	host->dev.parent = pcie->dev;
-	host->ops = pcie->soc->ops;
-	host->map_irq = of_irq_parse_and_map_pci;
-	host->swizzle_irq = pci_common_swizzle;
-	host->sysdata = pcie;
-
-	err = pci_scan_root_bus_bridge(host);
-	if (err < 0)
-		return err;
-
-	pci_bus_size_bridges(host->bus);
-	pci_bus_assign_resources(host->bus);
-
-	list_for_each_entry(child, &host->bus->children, node)
-		pcie_bus_configure_settings(child);
-
-	pci_bus_add_devices(host->bus);
-
-	return 0;
-}
-
 static int mtk_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1175,7 +1147,14 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	if (err)
 		goto put_resources;
 
-	err = mtk_pcie_register_host(host);
+	host->busnr = pcie->busn.start;
+	host->dev.parent = pcie->dev;
+	host->ops = pcie->soc->ops;
+	host->map_irq = of_irq_parse_and_map_pci;
+	host->swizzle_irq = pci_common_swizzle;
+	host->sysdata = pcie;
+
+	err = pci_host_probe(host);
 	if (err)
 		goto put_resources;
 
-- 
2.6.4

