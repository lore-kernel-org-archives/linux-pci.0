Return-Path: <SRS0=cLGU=C7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEB6C4727C
	for <linux-pci@archiver.kernel.org>; Tue, 22 Sep 2020 02:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3D721941
	for <linux-pci@archiver.kernel.org>; Tue, 22 Sep 2020 02:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgIVCfC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Sep 2020 22:35:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39604 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728517AbgIVCfB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Sep 2020 22:35:01 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 36AD0C912F799C99530C;
        Tue, 22 Sep 2020 10:34:59 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 22 Sep 2020 10:34:51 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <bhelgaas@google.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] PCI/ACPI: update kernel-doc line comments
Date:   Tue, 22 Sep 2020 10:32:25 +0800
Message-ID: <1600741945-38474-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update kernel-doc line comments to fix warnings reported by make W=1.
drivers/acpi/pci_root.c:71: warning: Function parameter or
member 'handle' not described in 'acpi_is_root_bridge'

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/acpi/pci_root.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index f90e841..8b81280 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -62,7 +62,7 @@ static DEFINE_MUTEX(osc_lock);
 
 /**
  * acpi_is_root_bridge - determine whether an ACPI CA node is a PCI root bridge
- * @handle - the ACPI CA node in question.
+ * @handle:  the ACPI CA node in question.
  *
  * Note: we could make this API take a struct acpi_device * instead, but
  * for now, it's more convenient to operate on an acpi_handle.
-- 
2.7.4

