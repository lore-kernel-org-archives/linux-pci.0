Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v3 21/51] PCI: Move saved required resource list out of must+optional assigning
Date: Mon, 27 Jul 2015 16:29:39 -0700
Message-Id: <1438039809-24957-22-git-send-email-yinghai@kernel.org>
In-Reply-To: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We will need to share that saved list for alt_size support.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 64ef516..1c0b4c5 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -456,6 +456,9 @@ static bool __has_addon(struct list_head *head,
 	int add_count = 0;
 	struct pci_dev_resource *dev_res, *tmp_res;
 
+	if (!realloc_head)
+		return false;
+
 	/* check if we have add really */
 	list_for_each_entry(dev_res, head, list) {
 		tmp_res = res_to_dev_res(realloc_head, dev_res->res);
@@ -492,9 +495,9 @@ static void restore_resource(struct pci_dev_resource *save_res,
 }
 
 static bool __assign_resources_must_add_sorted(struct list_head *head,
+				 struct list_head *save_head,
 				 struct list_head *realloc_head)
 {
-	LIST_HEAD(save_head);
 	LIST_HEAD(local_fail_head);
 	struct pci_dev_resource *save_res;
 	struct pci_dev_resource *dev_res, *tmp_res;
@@ -502,12 +505,6 @@ static bool __assign_resources_must_add_sorted(struct list_head *head,
 	resource_size_t add_align, add_size;
 	struct resource *res;
 
-	if (!__has_addon(head, realloc_head))
-		return false;
-
-	if (!save_resources(head, &save_head))
-		return false;
-
 	/* Update res in head list with add_size in realloc_head list */
 	list_for_each_entry(dev_res, head, list) {
 		res = dev_res->res;
@@ -548,7 +545,6 @@ static bool __assign_resources_must_add_sorted(struct list_head *head,
 		/* Remove head list from realloc_head list */
 		list_for_each_entry(dev_res, head, list)
 			remove_from_list(realloc_head, dev_res->res);
-		free_list(&save_head);
 		free_list(head);
 
 		return true;
@@ -562,7 +558,7 @@ static bool __assign_resources_must_add_sorted(struct list_head *head,
 		if (res->parent && !pci_need_to_release(fail_type, res)) {
 			/* remove it from realloc_head list */
 			remove_from_list(realloc_head, res);
-			remove_from_list(&save_head, res);
+			remove_from_list(save_head, res);
 			list_del(&dev_res->list);
 			kfree(dev_res);
 		}
@@ -581,11 +577,9 @@ static bool __assign_resources_must_add_sorted(struct list_head *head,
 		}
 	}
 	/* Restore start/end/flags from saved list */
-	list_for_each_entry(save_res, &save_head, list)
+	list_for_each_entry(save_res, save_head, list)
 		restore_resource(save_res, save_res->res);
 
-	free_list(&save_head);
-
 	return false;
 }
 
@@ -603,16 +597,24 @@ static void __assign_resources_sorted(struct list_head *head,
 	 *    then try to reassign add_size for some resources.
 	 */
 
+	LIST_HEAD(save_head);
+
 	/* Check must+optional add */
-	if (realloc_head &&
-	    __assign_resources_must_add_sorted(head, realloc_head))
+	if (__has_addon(head, realloc_head) &&
+	    save_resources(head, &save_head) &&
+	    __assign_resources_must_add_sorted(head, &save_head,
+					       realloc_head)) {
+		free_list(&save_head);
 		return;
+	}
 
 	__sort_resources(head);
 
 	/* Satisfy the must-have resource requests */
 	assign_requested_resources_sorted(head, fail_head);
 
+	free_list(&save_head);
+
 	/* Try to satisfy any additional optional resource
 		requests */
 	if (realloc_head)
-- 
1.8.4.5

