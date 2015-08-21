Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:24353 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbbHUGWN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2015 02:22:13 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v4 19/52] PCI: Separate required+optional assigning to another function
Date: Thu, 20 Aug 2015 23:20:34 -0700
Message-Id: <1440138067-4314-20-git-send-email-yinghai@kernel.org>
In-Reply-To: <1440138067-4314-1-git-send-email-yinghai@kernel.org>
References: <1440138067-4314-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

__assign_resources_sorted() is getting too big if we put alt_size support
into it.  Split required+optional assigning code out to another function.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index e4b4b55..8195929 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -467,20 +467,9 @@ static void restore_resource(struct pci_dev_resource *save_res,
 	res->flags = save_res->flags;
 }
 
-static void __assign_resources_sorted(struct list_head *head,
-				 struct list_head *realloc_head,
-				 struct list_head *fail_head)
+static bool __assign_resources_required_optional_sorted(struct list_head *head,
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
-	 */
-
 	LIST_HEAD(save_head);
 	LIST_HEAD(local_fail_head);
 	struct pci_dev_resource *save_res;
@@ -489,12 +478,8 @@ static void __assign_resources_sorted(struct list_head *head,
 	resource_size_t add_align;
 	struct resource *res;
 
-	/* Check if optional add_size is there */
-	if (!realloc_head || list_empty(realloc_head))
-		goto requested_and_reassign;
-
 	if (!save_resources(head, &save_head))
-		goto requested_and_reassign;
+		return false;
 
 	/* Update res in head list with add_size in realloc_head list */
 	list_for_each_entry(dev_res, head, list) {
@@ -533,7 +518,8 @@ static void __assign_resources_sorted(struct list_head *head,
 			remove_from_list(realloc_head, dev_res->res);
 		free_list(&save_head);
 		free_list(head);
-		return;
+
+		return true;
 	}
 
 	/* check failed type */
@@ -568,7 +554,28 @@ static void __assign_resources_sorted(struct list_head *head,
 
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
+	 * Should not assign required resources at first.
+	 *   they could be adjacent, so later reassign can not reallocate
+	 *   them one by one in parent resource window.
+	 * Try to assign required + optional at beginning
+	 *  if could do that, could get out early.
+	 *  if could not do that, we still try to assign required at first,
+	 *    then try to reassign add_size for some resources.
+	 */
+
+	/* Check required+optional add */
+	if (realloc_head && !list_empty(realloc_head) &&
+	    __assign_resources_required_optional_sorted(head, realloc_head))
+		return;
+
 	sort_resources(head);
 
 	/* Satisfy the must-have resource requests */
-- 
1.8.4.5

