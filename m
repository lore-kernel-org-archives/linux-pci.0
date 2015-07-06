Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:17417 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756361AbbGFXlV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2015 19:41:21 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	David Ahern <david.ahern@oracle.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 14/36] PCI: Separate must_add assigning to another function
Date: Mon,  6 Jul 2015 16:39:04 -0700
Message-Id: <1436225966-27247-15-git-send-email-yinghai@kernel.org>
In-Reply-To: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
References: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

__assign_resources_sorted() is getting too big if we put alt_size support
into it.  Split must_add assigning code out to another function.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 79 ++++++++++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 32cdc28..48f5616 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -422,6 +422,20 @@ static unsigned long pci_fail_res_type_mask(struct list_head *fail_head)
 
 static bool pci_need_to_release(unsigned long mask, struct resource *res)
 {
+	/*
+	 * Separate three resource type checking if we need to release
+	 * assigned resource after requested + add_size try.
+	 *	1. if there is io port assign fail, will release assigned
+	 *	   io port.
+	 *	2. if there is pref mmio assign fail, release assigned
+	 *	   pref mmio.
+	 *	   if assigned pref mmio's parent is non-pref mmio and there
+	 *	   is non-pref mmio assign fail, will release that assigned
+	 *	   pref mmio.
+	 *	3. if there is non-pref mmio assign fail or pref mmio
+	 *	   assigned fail, will release assigned non-pref mmio.
+	 */
+
 	if (res->flags & IORESOURCE_IO)
 		return !!(mask & IORESOURCE_IO);
 
@@ -443,50 +457,24 @@ static bool pci_need_to_release(unsigned long mask, struct resource *res)
 	return false;	/* should not get here */
 }
 
-static void __assign_resources_sorted(struct list_head *head,
-				 struct list_head *realloc_head,
-				 struct list_head *fail_head)
+static bool __assign_resources_must_add_sorted(struct list_head *head,
+				 struct list_head *realloc_head)
 {
-	/*
-	 * Should not assign requested resources at first.
-	 *   they could be adjacent, so later reassign can not reallocate
-	 *   them one by one in parent resource window.
-	 * Try to assign requested + add_size at beginning
-	 *  if could do that, could get out early.
-	 *  if could not do that, we still try to assign requested at first,
-	 *    then try to reassign add_size for some resources.
-	 *
-	 * Separate three resource type checking if we need to release
-	 * assigned resource after requested + add_size try.
-	 *	1. if there is io port assign fail, will release assigned
-	 *	   io port.
-	 *	2. if there is pref mmio assign fail, release assigned
-	 *	   pref mmio.
-	 *	   if assigned pref mmio's parent is non-pref mmio and there
-	 *	   is non-pref mmio assign fail, will release that assigned
-	 *	   pref mmio.
-	 *	3. if there is non-pref mmio assign fail or pref mmio
-	 *	   assigned fail, will release assigned non-pref mmio.
-	 */
 	LIST_HEAD(save_head);
 	LIST_HEAD(local_fail_head);
+	LIST_HEAD(local_alt_fail_head);
 	struct pci_dev_resource *save_res;
 	struct pci_dev_resource *dev_res, *tmp_res;
 	unsigned long fail_type;
 	resource_size_t add_align;
 	struct resource *res;
 
-	/* Check if optional add_size is there */
-	if (!realloc_head || list_empty(realloc_head))
-		goto requested_and_reassign;
-
 	/* Save original start, end, flags etc at first */
-	list_for_each_entry(dev_res, head, list) {
+	list_for_each_entry(dev_res, head, list)
 		if (add_to_list(&save_head, dev_res->dev, dev_res->res)) {
 			free_list(&save_head);
-			goto requested_and_reassign;
+			return false;
 		}
-	}
 
 	/* Update res in head list with add_size in realloc_head list */
 	list_for_each_entry(dev_res, head, list) {
@@ -525,7 +513,8 @@ static void __assign_resources_sorted(struct list_head *head,
 			remove_from_list(realloc_head, dev_res->res);
 		free_list(&save_head);
 		free_list(head);
-		return;
+
+		return true;
 	}
 
 	/* check failed type */
@@ -563,7 +552,31 @@ static void __assign_resources_sorted(struct list_head *head,
 	}
 	free_list(&save_head);
 
-requested_and_reassign:
+	return false;
+}
+
+static void __assign_resources_sorted(struct list_head *head,
+				 struct list_head *realloc_head,
+				 struct list_head *fail_head)
+{
+	/*
+	 * Should not assign requested resources at first.
+	 *   they could be adjacent, so later reassign can not reallocate
+	 *   them one by one in parent resource window.
+	 * Try to assign requested + add_size at beginning
+	 *  if could do that, could get out early.
+	 *  if could not do that, we still try to assign requested at first,
+	 *    then try to reassign add_size for some resources.
+	 */
+
+	LIST_HEAD(save_head);
+	LIST_HEAD(local_fail_head);
+
+	/* Check must+optional add */
+	if (realloc_head && !list_empty(realloc_head) &&
+	    __assign_resources_must_add_sorted(head, realloc_head))
+		return;
+
 	__sort_resources(head);
 
 	/* Satisfy the must-have resource requests */
-- 
1.8.4.5

