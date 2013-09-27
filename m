Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qe0-f48.google.com ([209.85.128.48]:55295 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476Ab3I0UkK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2013 16:40:10 -0400
Received: by mail-qe0-f48.google.com with SMTP id nd7so2235438qeb.35
        for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2013 13:40:09 -0700 (PDT)
From: Paulo Zanoni <przanoni@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, jbarnes@virtuousgeek.org,
	Paulo Zanoni <paulo.r.zanoni@intel.com>
Subject: [bug report] pci/msi: only free msi_desc if the kobj refcount is zero
Date: Fri, 27 Sep 2013 17:39:45 -0300
Message-Id: <1380314385-1552-1-git-send-email-przanoni@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Paulo Zanoni <paulo.r.zanoni@intel.com>

The msi_desc structure embeds a kobject. One of the nice features
about kobjects is that they're reference counted, so we can never
predict when we can kfree() them. Because of this, according to
Documentation/kobject.txt, we should only release the kobject
containers at the release() function: because only at that point we
know the refcount is zero.

But this is not what currently happens: we kfree() the msi_desc
structure unconditionally at free_msi_irqs(). The code seems to assume
that no one gets the kobject, so at free_msi_irqs() we just call
kobject_put() and then kfree(). But if we use the shiny new
CONFIG_DEBUG_KOBJECT_RELEASE option, all kobject put() operations will
be added to a delayed work queue, and the current free_msi_irqs()
function will kfree(entry) before entry->kobj refcount is really 0.

To complicate everything a little bit more, it seems that we keep
using struct msi_desc for a while even when the kobject creation
fails, so unconditionally freeing the struct at msi_kobj_release
doesn't seem possible with the current code.

So what this patch does is to create entry->kobj_valid and then free
the msi_desc struct at msi_kobj_release() if kobj_valid, or free it at
free_msi_irqs() if it's not valid. While this patch seems to solve the
problem for me, my fear is that on the cases where the kobject is
really valid, there will be a period of time after free_msi_irqs() and
before msi_kobj_release() where the msi_desc struct is partially
uninitialized. So if code holding the kobject reference tries to
access any of the fields that were cleared at free_msi_irqs() we'll
have bugs that are even harder to catch. So perhaps my patch is just
completely wrong and needs to be replaced with proper code. If this is
the case, I would suggest to fully move the msi_desc deinitialization
code to msi_kobj_release. So feel free to discard this patch and write
your own fixes for the bug :)

The backtraces from CONFIG_DEBUG_KOBJECT_RELEASE can be reproduced by
unloading i915.ko. I am also seeing some messages from e1000e.ko
related to MSI IRQs, but this patch doesn't seem to solve them: which
suggests my fix is not the best thing to do.

This patch was written against the Intel Graphics 3.12.0-rc2 tree.

Signed-off-by: Paulo Zanoni <paulo.r.zanoni@intel.com>
---
 drivers/pci/msi.c   | 15 +++++++++++----
 include/linux/msi.h |  2 ++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index d5f90d6..103bfc0 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -380,13 +380,13 @@ static void free_msi_irqs(struct pci_dev *dev)
 		 * were not registered with sysfs.  In that case don't
 		 * unregister them.
 		 */
-		if (entry->kobj.parent) {
+		if (entry->kobj_valid) {
 			kobject_del(&entry->kobj);
 			kobject_put(&entry->kobj);
+		} else {
+			list_del(&entry->list);
+			kfree(entry);
 		}
-
-		list_del(&entry->list);
-		kfree(entry);
 	}
 }
 
@@ -509,6 +509,11 @@ static void msi_kobj_release(struct kobject *kobj)
 	struct msi_desc *entry = to_msi_desc(kobj);
 
 	pci_dev_put(entry->dev);
+
+	if (entry->kobj_valid) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
 }
 
 static struct kobj_type msi_irq_ktype = {
@@ -534,6 +539,7 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 		pci_dev_get(pdev);
 		ret = kobject_init_and_add(kobj, &msi_irq_ktype, NULL,
 				     "%u", entry->irq);
+		entry->kobj_valid = true;
 		if (ret)
 			goto out_unroll;
 
@@ -546,6 +552,7 @@ out_unroll:
 	list_for_each_entry(entry, &pdev->msi_list, list) {
 		if (!count)
 			break;
+		entry->kobj_valid = false;
 		kobject_del(&entry->kobj);
 		kobject_put(&entry->kobj);
 		count--;
diff --git a/include/linux/msi.h b/include/linux/msi.h
index b17ead8..2aa19de 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -48,6 +48,8 @@ struct msi_desc {
 	struct msi_msg msg;
 
 	struct kobject kobj;
+	/* Prevents msi_desc from being freed if kobj is not valid. */
+	bool kobj_valid;
 };
 
 /*
-- 
1.8.3.1

