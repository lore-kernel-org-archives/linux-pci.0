Return-Path: <SRS0=ToWj=PL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45138C43387
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 03:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EACD204EC
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 03:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfACDFl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 2 Jan 2019 22:05:41 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42215 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbfACDFk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Jan 2019 22:05:40 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 10DC520D0CC70;
        Thu,  3 Jan 2019 11:05:38 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Thu, 3 Jan 2019 11:05:31 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Yue Wang <yue.wang@Amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Kevin Hilman" <khilman@baylibre.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-pci@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] PCI: amlogic: Use PTR_ERR_OR_ZERO
Date:   Thu, 3 Jan 2019 03:12:18 +0000
Message-ID: <1546485138-142830-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pci/controller/dwc/pci-meson.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 241ebe0..51cf20c 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -181,10 +181,7 @@ static int meson_pcie_get_mems(struct platform_device *pdev,
 
 	/* Meson SoC has two PCI controllers use same phy register*/
 	mp->mem_res.phy_base = meson_pcie_get_mem_shared(pdev, mp, "phy");
-	if (IS_ERR(mp->mem_res.phy_base))
-		return PTR_ERR(mp->mem_res.phy_base);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(mp->mem_res.phy_base);
 }
 
 static void meson_pcie_power_on(struct meson_pcie *mp)
@@ -258,10 +255,7 @@ static int meson_pcie_probe_clocks(struct meson_pcie *mp)
 		return PTR_ERR(res->general_clk);
 
 	res->clk = meson_pcie_probe_clock(dev, "pcie", 0);
-	if (IS_ERR(res->clk))
-		return PTR_ERR(res->clk);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(res->clk);
 }
 
 static inline void meson_elb_writel(struct meson_pcie *mp, u32 val, u32 reg)





