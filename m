Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD39C64E7C
	for <linux-pci@archiver.kernel.org>; Fri, 20 Nov 2020 07:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48961223AC
	for <linux-pci@archiver.kernel.org>; Fri, 20 Nov 2020 07:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgKTHoh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 20 Nov 2020 02:44:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7707 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgKTHoV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Nov 2020 02:44:21 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CcpT80MYWzkc4n;
        Fri, 20 Nov 2020 15:43:56 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Nov 2020 15:44:08 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH] PCI: fix use-after-free in pci_register_host_bridge
Date:   Fri, 20 Nov 2020 15:48:48 +0800
Message-ID: <20201120074848.31418-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When put_device(&bridge->dev) being called, kfree(bridge) is inside
of release function, so the following device_del would cause a
use-after-free bug.

Fixes: 37d6a0a6f470 ("PCI: Add pci_register_host_bridge() interface")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4289030b0..82292e87e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -991,8 +991,8 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	return 0;
 
 unregister:
-	put_device(&bridge->dev);
 	device_del(&bridge->dev);
+	put_device(&bridge->dev);
 
 free:
 	kfree(bus);
-- 
2.23.0

