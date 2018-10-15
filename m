Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694D3C28CF8
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 05:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4F5204FD
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 05:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4F5204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeJON2u (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 09:28:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:15915 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726667AbeJON2u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Oct 2018 09:28:50 -0400
X-UUID: a8a49d1024c048c08b9483a95b9b2f35-20181015
X-UUID: a8a49d1024c048c08b9483a95b9b2f35-20181015
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 699156771; Mon, 15 Oct 2018 13:44:55 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 15 Oct 2018 13:44:53 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 15 Oct 2018 13:44:52 +0800
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
Subject: [PATCH v7 4/9] PCI: mediatek: Convert to use pci_host_probe()
Date:   Mon, 15 Oct 2018 13:44:42 +0800
Message-ID: <1539582287-9171-5-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1539582287-9171-1-git-send-email-honghui.zhang@mediatek.com>
References: <1539582287-9171-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0C1245066352060978BBCC10F29C80A30DBFB5A7362A87711876ABD1A6658F902000:8
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
---
 drivers/pci/controller/pcie-mediatek.c | 37 ++++++++--------------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 59fdb60..ead6005 100644
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

