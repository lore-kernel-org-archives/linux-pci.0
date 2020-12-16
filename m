Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A816C4361B
	for <linux-pci@archiver.kernel.org>; Wed, 16 Dec 2020 13:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E158A233EA
	for <linux-pci@archiver.kernel.org>; Wed, 16 Dec 2020 13:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgLPNUD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Dec 2020 08:20:03 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9217 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgLPNUD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Dec 2020 08:20:03 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CwwgB2RfQzkbqL;
        Wed, 16 Dec 2020 21:18:30 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Wed, 16 Dec 2020 21:19:12 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <minghuan.Lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
        <robh@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] pci/controller/dwc: convert comma to semicolon
Date:   Wed, 16 Dec 2020 21:19:44 +0800
Message-ID: <20201216131944.14990-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/pci/controller/dwc/pci-layerscape-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index 84206f265e54..917ba8d254fc 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -178,7 +178,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = pcie->drvdata->dw_pcie_ops;
 
-	ls_epc->bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4),
+	ls_epc->bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4);
 
 	pcie->pci = pci;
 	pcie->ls_epc = ls_epc;
-- 
2.22.0

