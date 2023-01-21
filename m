Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2D1C25B50
	for <linux-pci@archiver.kernel.org>; Sat, 21 Jan 2023 17:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjAURFo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 21 Jan 2023 12:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjAURFn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 21 Jan 2023 12:05:43 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55D122ED65;
        Sat, 21 Jan 2023 09:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=JUlxToNzLBO0BKABG4
        CCXq4vQiINYrAipFSJIvdZQcM=; b=kWm1lWo8N8f9gVUi88v0p+PHYQlj5vu4IA
        qJDDrKagGhjqXqqgH/FMN46WcckBstMUdXvqj+8AA1+4PRLGehIkcOHwkp7PkHQu
        Pfu9clrz/fGeS0SKdETbn/1niy621zjVnr63zrmExT63z0/VOUIgINdJzyNtPzIE
        mG4aYGFEg=
Received: from localhost.localdomain (unknown [114.105.143.48])
        by zwqz-smtp-mta-g4-2 (Coremail) with SMTP id _____wBH_WAWG8xjy+a7BA--.27008S4;
        Sun, 22 Jan 2023 01:04:42 +0800 (CST)
From:   Lizhe <sensor1010@163.com>
To:     bhelgaas@google.com, tglx@linutronix.de, darwi@linutronix.de,
        jgg@ziepe.ca, maz@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhe <sensor1010@163.com>
Subject: [PATCH v1] drivers/msi.c : use devm_ioremap replace ioremap
Date:   Sat, 21 Jan 2023 09:04:20 -0800
Message-Id: <20230121170420.8681-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wBH_WAWG8xjy+a7BA--.27008S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFW3ZFW5Aw47Kr18uw4Uurg_yoWxuFc_ur
        WkZw4fArWqyry8Ca4FyrWfZry29a4kuFWkuF10qasIkw1S9wnxGFyDur1ktayDuwn7Gay5
        J39Fgr1UuF48AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZBMK3UUUUU==
X-Originating-IP: [114.105.143.48]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBlw-9q2I0X6gNTgAAss
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

use devm_ioremap replace ioremap

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/pci/msi/msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 1f716624ca56..184eca85b88b 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -566,7 +566,7 @@ static void __iomem *msix_map_region(struct pci_dev *dev,
 	table_offset &= PCI_MSIX_TABLE_OFFSET;
 	phys_addr = pci_resource_start(dev, bir) + table_offset;
 
-	return ioremap(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
+	return devm_ioremap(&dev->dev, phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
 }
 
 /**
-- 
2.17.1

