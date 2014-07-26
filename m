Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:47012 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbaGZBXZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jul 2014 21:23:25 -0400
From: <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: [PATCH 1/3] PCI/MSI: Clean up the kobject in struct msi_desc
Date: Sat, 26 Jul 2014 09:48:34 +0800
Message-ID: <1406339316-20163-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1406339316-20163-1-git-send-email-wangyijing@huawei.com>
References: <1406339316-20163-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Yijing Wang <wangyijing@huawei.com>

commit 1c51b50c299 exported MSI mode using attributes
instead of kobject. So clean up the kobject in struct
msi_desc.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
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

