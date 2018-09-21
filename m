Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6D5ECE561
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 02:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0D62086E
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 02:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0D62086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388722AbeIUIac (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 04:30:32 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47745 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726103AbeIUIab (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Sep 2018 04:30:31 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F090333123DED;
        Fri, 21 Sep 2018 10:43:49 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Fri, 21 Sep 2018 10:43:44 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <devel@linuxdriverproject.org>, <linux-pci@vger.kernel.org>,
        <netdev@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH RESEND] PCI: hv: Fix return value check in hv_pci_assign_slots()
Date:   Fri, 21 Sep 2018 02:53:17 +0000
Message-ID: <1537498397-191756-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1537425631-28460-1-git-send-email-weiyongjun1@huawei.com>
References: <1537425631-28460-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In case of error, the function pci_create_slot() returns ERR_PTR() and
never returns NULL. The NULL test in the return value check should be
replaced with IS_ERR().

Fixes: a15f2c08c708 ("PCI: hv: support reporting serial number as slot information")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
Since the orig patch is merged from net tree, cc netdev@vger.kernel.org
---
 drivers/pci/controller/pci-hyperv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index ee80e79..9ba4d12 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1484,8 +1484,10 @@ static void hv_pci_assign_slots(struct hv_pcibus_device *hbus)
 		snprintf(name, SLOT_NAME_SIZE, "%u", hpdev->desc.ser);
 		hpdev->pci_slot = pci_create_slot(hbus->pci_bus, slot_nr,
 					  name, NULL);
-		if (!hpdev->pci_slot)
+		if (IS_ERR(hpdev->pci_slot)) {
 			pr_warn("pci_create slot %s failed\n", name);
+			hpdev->pci_slot = NULL;
+		}
 	}
 }

