Return-Path: <SRS0=TeuG=ZK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE9EC432C0
	for <linux-pci@archiver.kernel.org>; Mon, 18 Nov 2019 11:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351442073A
	for <linux-pci@archiver.kernel.org>; Mon, 18 Nov 2019 11:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfKRLUs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:20:48 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48620 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726490AbfKRLUs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Nov 2019 06:20:48 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 559CB6E9C59D89360F2A;
        Mon, 18 Nov 2019 19:20:46 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 18 Nov 2019
 19:20:37 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <jingoohan1@gmail.com>, <lorenzo.pieralisi@arm.com>,
        <andrew.murray@arm.com>, <bhelgaas@google.com>, <kgene@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] PCI: exynos: Use PTR_ERR_OR_ZERO() to simplify code
Date:   Mon, 18 Nov 2019 19:28:00 +0800
Message-ID: <1574076480-50196-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixes coccicheck warning:

drivers/pci/controller/dwc/pci-exynos.c:95:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 14a6ba4..6c9509d 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -92,10 +92,7 @@ static int exynos5440_pcie_get_mem_resources(struct platform_device *pdev,

 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ep->mem_res->elbi_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(ep->mem_res->elbi_base))
-		return PTR_ERR(ep->mem_res->elbi_base);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(ep->mem_res->elbi_base);
 }

 static int exynos5440_pcie_get_clk_resources(struct exynos_pcie *ep)
--
2.7.4

