Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:53417 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbaIWFDQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Sep 2014 01:03:16 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v3 5/9] PCI/MSI: Remove unused function get_cached_msi_msg()
Date: Tue, 23 Sep 2014 13:27:26 +0800
Message-ID: <1411450050-1510-6-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1411450050-1510-1-git-send-email-wangyijing@huawei.com>
References: <1411450050-1510-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now no one uses get_cached_msi_msg(), remove it.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c   |    7 -------
 include/linux/msi.h |    1 -
 2 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 0d0f163..fa66e2f 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -306,13 +306,6 @@ void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 	*msg = entry->msg;
 }
 
-void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
-{
-	struct msi_desc *entry = irq_get_msi_desc(irq);
-
-	__get_cached_msi_msg(entry, msg);
-}
-
 void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	if (entry->dev->current_state != PCI_D0) {
diff --git a/include/linux/msi.h b/include/linux/msi.h
index fff7201..3fae781 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -19,7 +19,6 @@ void __read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void read_msi_msg(unsigned int irq, struct msi_msg *msg);
-void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
 void write_msi_msg(unsigned int irq, struct msi_msg *msg);
 
 struct msi_desc {
-- 
1.7.1

