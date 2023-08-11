Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47911C001DB
	for <linux-pci@archiver.kernel.org>; Fri, 11 Aug 2023 10:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjHKK7A (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Aug 2023 06:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjHKK67 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2023 06:58:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630BBC3
        for <linux-pci@vger.kernel.org>; Fri, 11 Aug 2023 03:58:59 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RMgjz0Ql5zrSYB;
        Fri, 11 Aug 2023 18:57:43 +0800 (CST)
Received: from huawei.com (10.175.113.25) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 18:58:56 +0800
From:   Zheng Zengkai <zhengzengkai@huawei.com>
To:     <bhelgaas@google.com>, <logang@deltatee.com>
CC:     <linux-pci@vger.kernel.org>, <wangxiongfeng2@huawei.com>,
        <zhengzengkai@huawei.com>
Subject: [PATCH -next] PCI/P2PDMA: Use pci_dev_id() to simplify the code
Date:   Fri, 11 Aug 2023 19:10:57 +0800
Message-ID: <20230811111057.31900-1-zhengzengkai@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI core API pci_dev_id() can be used to get the BDF number for a pci
device. We don't need to compose it manually. Use pci_dev_id() to
simplify the code a little bit.

Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
---
 drivers/pci/p2pdma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 6cd98ffca198..ec04d0ed157b 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -532,8 +532,7 @@ static bool host_bridge_whitelist(struct pci_dev *a, struct pci_dev *b,
 
 static unsigned long map_types_idx(struct pci_dev *client)
 {
-	return (pci_domain_nr(client->bus) << 16) |
-		(client->bus->number << 8) | client->devfn;
+	return (pci_domain_nr(client->bus) << 16) | pci_dev_id(client);
 }
 
 /*
-- 
2.20.1

