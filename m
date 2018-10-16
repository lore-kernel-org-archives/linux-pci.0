Return-Path: <SRS0=JYfi=M4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8D5C18DF5
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 10:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA4320881
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 10:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA4320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeJPSev (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:34:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47939 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726711AbeJPSeu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Oct 2018 14:34:50 -0400
X-UUID: 9972e47779f74a1f891f351d8d5e67c0-20181016
X-UUID: 9972e47779f74a1f891f351d8d5e67c0-20181016
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 176357168; Tue, 16 Oct 2018 18:44:57 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 16 Oct 2018 18:44:55 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 16 Oct 2018 18:44:54 +0800
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
Subject: [PATCH v9 3/9] PCI: mediatek: Remove the redundant dev->pm_domain check
Date:   Tue, 16 Oct 2018 18:44:44 +0800
Message-ID: <1539686690-24068-4-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1539686690-24068-1-git-send-email-honghui.zhang@mediatek.com>
References: <1539686690-24068-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 049BB0D034F28D2EB207ED42B7158FC94D19B1ACAE6161BAFF5085BB518D7D192000:8
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

It's no needed to check whether device have pm_domain attached before
calling the pm_runtime_XXX interface, remove it.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 288b8e2..6080b29 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -225,10 +225,8 @@ static void mtk_pcie_subsys_powerdown(struct mtk_pcie *pcie)
 
 	clk_disable_unprepare(pcie->free_ck);
 
-	if (dev->pm_domain) {
-		pm_runtime_put_sync(dev);
-		pm_runtime_disable(dev);
-	}
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
 }
 
 static void mtk_pcie_port_free(struct mtk_pcie_port *port)
@@ -998,10 +996,8 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
 		pcie->free_ck = NULL;
 	}
 
-	if (dev->pm_domain) {
-		pm_runtime_enable(dev);
-		pm_runtime_get_sync(dev);
-	}
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
 
 	/* enable top level clock */
 	err = clk_prepare_enable(pcie->free_ck);
@@ -1013,10 +1009,8 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
 	return 0;
 
 err_free_ck:
-	if (dev->pm_domain) {
-		pm_runtime_put_sync(dev);
-		pm_runtime_disable(dev);
-	}
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
 
 	return err;
 }
-- 
2.6.4

