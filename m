Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9848C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 08:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C727C218AC
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 08:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbfAaICI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:02:08 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:53311 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726341AbfAaICG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2019 03:02:06 -0500
X-UUID: 939512b1174b4934a81b08c41571bdb5-20190131
X-UUID: 939512b1174b4934a81b08c41571bdb5-20190131
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 432288136; Thu, 31 Jan 2019 16:01:59 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 31 Jan 2019 16:01:58 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 16:01:57 +0800
From:   <honghui.zhang@mediatek.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ryder.lee@mediatek.com>
CC:     <rafael.j.wysocki@intel.com>, <fred@fredlawl.com>,
        <poza@codeaurora.org>, <youlin.pei@mediatek.com>,
        <jianjun.wang@mediatek.com>,
        Honghui Zhang <honghui.zhang@mediatek.com>
Subject: [PATCH v2 2/2] PCI: mediatek: Enlarge PCIe2AHB window size to support 4GB DRAM
Date:   Thu, 31 Jan 2019 16:01:53 +0800
Message-ID: <1548921713-5355-3-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1548921713-5355-1-git-send-email-honghui.zhang@mediatek.com>
References: <1548921713-5355-1-git-send-email-honghui.zhang@mediatek.com>
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
index 01126b8..60326c4 100644
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

