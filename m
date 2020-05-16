Return-Path: <SRS0=A99F=66=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A52FC433DF
	for <linux-pci@archiver.kernel.org>; Sat, 16 May 2020 07:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7BC8207E8
	for <linux-pci@archiver.kernel.org>; Sat, 16 May 2020 07:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgEPHBe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 16 May 2020 03:01:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4849 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725275AbgEPHBe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 16 May 2020 03:01:34 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E58D0C61545F6251853A;
        Sat, 16 May 2020 15:01:31 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Sat, 16 May 2020 15:01:24 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <huangdaode@huawei.com>
Subject: [PATCH] PCI/PME: Add missing field documentation
Date:   Sat, 16 May 2020 15:00:14 +0800
Message-ID: <1589612414-61682-1-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Suppress following warning when compiling with W=1:

drivers/pci/pcie/pme.c:414: warning: Function parameter or member 'srv'
not described in 'pcie_pme_resume'
drivers/pci/pcie/pme.c:437: warning: Function parameter or member 'srv'
not described in 'pcie_pme_remove'

Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/pci/pcie/pme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index f38e6c1..6a32970 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -408,7 +408,7 @@ static int pcie_pme_suspend(struct pcie_device *srv)
 
 /**
  * pcie_pme_resume - Resume PCIe PME service device.
- * @srv - PCIe service device to resume.
+ * @srv: PCIe service device to resume.
  */
 static int pcie_pme_resume(struct pcie_device *srv)
 {
@@ -431,7 +431,7 @@ static int pcie_pme_resume(struct pcie_device *srv)
 
 /**
  * pcie_pme_remove - Prepare PCIe PME service device for removal.
- * @srv - PCIe service device to remove.
+ * @srv: PCIe service device to remove.
  */
 static void pcie_pme_remove(struct pcie_device *srv)
 {
-- 
2.7.4

