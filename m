Return-Path: <SRS0=ex/N=MK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1419FC43382
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 10:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD62C2173D
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 10:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD62C2173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbeI1Q14 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:27:56 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:62385 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729333AbeI1Q1z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Sep 2018 12:27:55 -0400
X-UUID: 40f70a36181d4a17a67098141df29031-20180928
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1744052678; Fri, 28 Sep 2018 18:04:50 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Sep 2018 18:04:48 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Sep 2018 18:04:47 +0800
From:   <honghui.zhang@mediatek.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ryder.lee@mediatek.com>
CC:     <ulf.hansson@linaro.org>, <marc.zyngier@arm.com>,
        <matthias.bgg@gmail.com>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <honghui.zhang@mediatek.com>, <youlin.pei@mediatek.com>,
        <yt.shen@mediatek.com>, <sean.wang@mediatek.com>
Subject: [PATCH v5 6/9] PCI: mediatek: Enable msi after clock enabled
Date:   Fri, 28 Sep 2018 18:04:37 +0800
Message-ID: <1538129080-8206-7-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1538129080-8206-1-git-send-email-honghui.zhang@mediatek.com>
References: <1538129080-8206-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D8223F1D09969A57176FA1E72EF699335B46AA4019E13A4D49B56E091B1765BB2000:8
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

The clocks was not enabled when enable MSI. This patch fix this
issue by calling mtk_pcie_enable_msi in mtk_pcie_startup_port_v2
since the clock was all enabled at that time.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index d150be1..be38b38 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -572,8 +572,6 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
 		ret = mtk_pcie_allocate_msi_domains(port);
 		if (ret)
 			return ret;
-
-		mtk_pcie_enable_msi(port);
 	}
 
 	return 0;
@@ -694,6 +692,9 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	val &= ~INTX_MASK;
 	writel(val, port->base + PCIE_INT_MASK);
 
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		mtk_pcie_enable_msi(port);
+
 	/* Set AHB to PCIe translation windows */
 	size = mem->end - mem->start;
 	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
-- 
2.6.4

