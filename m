Return-Path: <SRS0=5Mj4=3M=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF74C33CAA
	for <linux-pci@archiver.kernel.org>; Thu, 23 Jan 2020 08:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8886A2467E
	for <linux-pci@archiver.kernel.org>; Thu, 23 Jan 2020 08:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgAWIiL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 23 Jan 2020 03:38:11 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45432 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726061AbgAWIiL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Jan 2020 03:38:11 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7B111BDC48797FA0B04B;
        Thu, 23 Jan 2020 16:38:08 +0800 (CST)
Received: from linux-ioko.site (10.78.228.23) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 23 Jan 2020 16:38:00 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <helgaas@kernel.org>, <keith.busch@intel.com>
CC:     <linux-pci@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH] PCI/AER: Fix the uninitialized aer_fifo
Date:   Thu, 23 Jan 2020 16:26:31 +0800
Message-ID: <1579767991-103898-1-git-send-email-liudongdong3@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.78.228.23]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Current code do not call INIT_KFIFO() to init aer_fifo. This will lead to
kfifo_put() sometimes return 0. This means the fifo was full. In fact, it
is not. It is easy to reproduce the problem by using aer_inject.
aer_inject -s :82:00.0 multiple-corr-nonfatal
The content of multiple-corr-nonfatal file is as below.
AER
COR RCVR
HL 0 1 2 3
AER
UNCOR POISON_TLP
HL 4 5 6 7

Fixes: 27c1ce8bbed7 ("PCI/AER: Use kfifo for tracking events instead of reimplementing it")
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 drivers/pci/pcie/aer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 1ca86f2..4a818b0 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1445,6 +1445,7 @@ static int aer_probe(struct pcie_device *dev)
 		return -ENOMEM;
 
 	rpc->rpd = port;
+	INIT_KFIFO(rpc->aer_fifo);
 	set_service_data(dev, rpc);
 
 	status = devm_request_threaded_irq(device, dev->irq, aer_irq, aer_isr,
-- 
1.9.1

