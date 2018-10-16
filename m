Return-Path: <SRS0=JYfi=M4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272ADC169D4
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 10:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98D62089E
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 10:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98D62089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeJPSfA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:35:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44875 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727051AbeJPSe7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Oct 2018 14:34:59 -0400
X-UUID: 19b2a88564fc4911b0f23efd0632d4be-20181016
X-UUID: 19b2a88564fc4911b0f23efd0632d4be-20181016
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1573313564; Tue, 16 Oct 2018 18:45:06 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 16 Oct 2018 18:45:04 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 16 Oct 2018 18:44:57 +0800
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
Subject: [PATCH v9 6/9] PCI: mediatek: Fixup enable MSI logic by enable MSI after clock enabled
Date:   Tue, 16 Oct 2018 18:44:47 +0800
Message-ID: <1539686690-24068-7-git-send-email-honghui.zhang@mediatek.com>
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

The commit 43e6409db64d ("PCI: mediatek: Add MSI support for MT2712 and
MT7622") added MSI support but enable MSI in wrong place, clocks was not
enabled when enable MSI. This patch fix this issue by calling
mtk_pcie_enable_msi in mtk_pcie_startup_port_v2 since the clock was all
enabled at that time.

Fixes: 43e6409db64d ("PCI: mediatek: Add MSI support for MT2712 and MT7622")
Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 6967bb7..82d3d85 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -568,8 +568,6 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
 		ret = mtk_pcie_allocate_msi_domains(port);
 		if (ret)
 			return ret;
-
-		mtk_pcie_enable_msi(port);
 	}
 
 	return 0;
@@ -690,6 +688,9 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
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

