Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01683C282DB
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 05:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9481218AC
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 05:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfBAFgV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 00:36:21 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:26463 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725826AbfBAFgU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Feb 2019 00:36:20 -0500
X-UUID: 6302292f14b149d6a4a6ffc0f457fe2d-20190201
X-UUID: 6302292f14b149d6a4a6ffc0f457fe2d-20190201
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 25183322; Fri, 01 Feb 2019 13:36:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 13:36:11 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 13:36:11 +0800
From:   <honghui.zhang@mediatek.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ryder.lee@mediatek.com>
CC:     <rafael.j.wysocki@intel.com>, <fred@fredlawl.com>,
        <poza@codeaurora.org>, <youlin.pei@mediatek.com>,
        <jianjun.wang@mediatek.com>,
        Honghui Zhang <honghui.zhang@mediatek.com>
Subject: [PATCH v3 2/2] PCI: mediatek: Enlarge PCIe2AHB window size to support 4GB DRAM
Date:   Fri, 1 Feb 2019 13:36:07 +0800
Message-ID: <1548999367-11733-3-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1548999367-11733-1-git-send-email-honghui.zhang@mediatek.com>
References: <1548999367-11733-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

The PCIE_AXI_WINDOW0 defines the translate window size for the request
from EP side. Request outside of this window will be treated as
unsupported request.

Enlarge this window size from fls(0xffffffff) to 2^33 to support 8GB
translate address range then EP DMA is capable of fully access 4GB
DRAM range(physical DRAM is start from 0x40000000).

Reported-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index c42fe5c..0b6c728 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -90,6 +90,12 @@
 #define AHB2PCIE_SIZE(x)	((x) & GENMASK(4, 0))
 #define PCIE_AXI_WINDOW0	0x448
 #define WIN_ENABLE		BIT(7)
+/*
+ * Define PCIe to AHB window size as 2^33 to support max 8GB address space
+ * translate, support least 4GB DRAM size access from EP DMA(physical DRAM
+ * start from 0x40000000).
+ */
+#define PCIE2AHB_SIZE	0x21
 
 /* PCIe V2 configuration transaction header */
 #define PCIE_CFG_HEADER0	0x460
@@ -713,7 +719,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	writel(val, port->base + PCIE_AHB_TRANS_BASE0_H);
 
 	/* Set PCIe to AXI translation memory space.*/
-	val = fls(0xffffffff) | WIN_ENABLE;
+	val = PCIE2AHB_SIZE | WIN_ENABLE;
 	writel(val, port->base + PCIE_AXI_WINDOW0);
 
 	return 0;
-- 
2.6.4

