Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9E9C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 08:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F099F218D2
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 08:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfAaICE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:02:04 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:9831 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725855AbfAaICE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2019 03:02:04 -0500
X-UUID: 4951c54a53204df580ce47673a529fe7-20190131
X-UUID: 4951c54a53204df580ce47673a529fe7-20190131
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1053852584; Thu, 31 Jan 2019 16:01:59 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 31 Jan 2019 16:01:56 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 16:01:56 +0800
From:   <honghui.zhang@mediatek.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ryder.lee@mediatek.com>
CC:     <rafael.j.wysocki@intel.com>, <fred@fredlawl.com>,
        <poza@codeaurora.org>, <youlin.pei@mediatek.com>,
        <jianjun.wang@mediatek.com>,
        Honghui Zhang <honghui.zhang@mediatek.com>
Subject: [PATCH v2 1/2] PCI: mediatek: Use resource_size function on resource object
Date:   Thu, 31 Jan 2019 16:01:52 +0800
Message-ID: <1548921713-5355-2-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1548921713-5355-1-git-send-email-honghui.zhang@mediatek.com>
References: <1548921713-5355-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 35E5A7B92BE2FA1A7C5DE91269123E30A57F6697C5DE280A9D1E796F540EA96F2000:8
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

scripts/coccinelle/api/resource_size.cocci complain about the
following warning:

pcie-mediatek.c:720:13-16: WARNING: Suspicious code. resource_size is maybe missing with mem

Use resource_size(mem) instead of mem->end - mem->start to eliminate the
complain. Since the MMIO window size for both MT2712 and MT7622 are all
0x1000_0000, this change also fix the AHB2PCIe window size smaller than
HW MMIO window size issue by change the values of fls(size) from
fls(0xfff_ffff) to fls(0x1000_0000).

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 55e471c..01126b8 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -654,7 +654,6 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	struct resource *mem = &pcie->mem;
 	const struct mtk_pcie_soc *soc = port->pcie->soc;
 	u32 val;
-	size_t size;
 	int err;
 
 	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
@@ -706,8 +705,8 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 		mtk_pcie_enable_msi(port);
 
 	/* Set AHB to PCIe translation windows */
-	size = mem->end - mem->start;
-	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
+	val = lower_32_bits(mem->start)
+	      | AHB2PCIE_SIZE(fls(resource_size(mem)));
 	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
 
 	val = upper_32_bits(mem->start);
-- 
2.6.4

