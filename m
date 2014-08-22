Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:53470 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754425AbaHVHpc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Aug 2014 03:45:32 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v2 1/5] PCI/MSI: Clean up the kobject in struct msi_desc
Date: Fri, 22 Aug 2014 16:07:56 +0800
Message-ID: <1408694880-8260-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1408694880-8260-1-git-send-email-wangyijing@huawei.com>
References: <1408694880-8260-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

commit 1c51b50c2995 using attributes to export MSI mode
instead of kobject. So clean up the kobject in struct
msi_desc.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/msi.c   |   11 -----------
 include/linux/msi.h |    2 --
 2 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 5a40516..e2aa74e 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -384,17 +384,6 @@ static void free_msi_irqs(struct pci_dev *dev)
 				iounmap(entry->mask_base);
 		}
 
-		/*
-		 * Its possible that we get into this path
-		 * When populate_msi_sysfs fails, which means the entries
-		 * were not registered with sysfs.  In that case don't
-		 * unregister them.
-		 */
-		if (entry->kobj.parent) {
-			kobject_del(&entry->kobj);
-			kobject_put(&entry->kobj);
-		}
-
 		list_del(&entry->list);
 		kfree(entry);
 	}
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 8103f32..8892d41 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -47,8 +47,6 @@ struct msi_desc {
 
 	/* Last set MSI message */
 	struct msi_msg msg;
-
-	struct kobject kobj;
 };
 
 /*
-- 
1.7.1

