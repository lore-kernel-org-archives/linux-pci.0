Return-Path: <SRS0=vBCh=MJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A32C43382
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 06:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194AD2156D
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 06:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194AD2156D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeI0NAM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Sep 2018 09:00:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13134 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727097AbeI0NAM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Sep 2018 09:00:12 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2C0188831A52C;
        Thu, 27 Sep 2018 14:43:29 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Thu, 27 Sep 2018 14:43:20 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] PCI: hotplug: Use kmemdup rather than duplicating its implementation in pnv_php_add_devtree()
Date:   Thu, 27 Sep 2018 06:52:21 +0000
Message-ID: <1538031141-138417-1-git-send-email-yuehaibing@huawei.com>
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

Use kmemdup rather than duplicating its implementation

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pci/hotplug/pnv_php.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 5070620..ee54f5b 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -275,14 +275,13 @@ static int pnv_php_add_devtree(struct pnv_php_slot *php_slot)
 		goto free_fdt1;
 	}
 
-	fdt = kzalloc(fdt_totalsize(fdt1), GFP_KERNEL);
+	fdt = kmemdup(fdt1, fdt_totalsize(fdt1), GFP_KERNEL);
 	if (!fdt) {
 		ret = -ENOMEM;
 		goto free_fdt1;
 	}
 
 	/* Unflatten device tree blob */
-	memcpy(fdt, fdt1, fdt_totalsize(fdt1));
 	dt = of_fdt_unflatten_tree(fdt, php_slot->dn, NULL);
 	if (!dt) {
 		ret = -EINVAL;



