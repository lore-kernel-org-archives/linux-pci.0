Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:39760 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759568AbcBYCSp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2016 21:18:45 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v10 42/59] PCI: Move saved required resource list out of required+optional assigning
Date: Wed, 24 Feb 2016 18:12:33 -0800
Message-Id: <1456366370-28995-43-git-send-email-yinghai@kernel.org>
In-Reply-To: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We will need to share saved required list for alt_size support, so move
it out from required+optional assigning.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 2f5e4d1..94015c2 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -456,6 +456,9 @@ static bool has_addon(struct list_head *head,
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
 
 static bool __assign_resources_required_optional_sorted(struct list_head *head,
+				 struct list_head *save_head,
 				 struct list_head *realloc_head)
 {
-	LIST_HEAD(save_head);
 	LIST_HEAD(local_fail_head);
 	struct pci_dev_resource *save_res;
 	struct pci_dev_resource *dev_res, *tmp_res;
@@ -502,12 +505,6 @@ static bool __assign_resources_required_optional_sorted(struct list_head *head,
 	resource_size_t add_align, add_size;
 	struct resource *res;
 
-	if (!has_addon(head, realloc_head))
-		return false;
-
-	if (!save_resources(head, &save_head))
-		return false;
-
 	/* Update res in head list with add_size in realloc_head list */
 	list_for_each_entry(dev_res, head, list) {
 		res = dev_res->res;
@@ -548,7 +545,6 @@ static bool __assign_resources_required_optional_sorted(struct list_head *head,
 		/* Remove head list from realloc_head list */
 		list_for_each_entry(dev_res, head, list)
 			remove_from_list(realloc_head, dev_res->res);
-		free_list(&save_head);
 		free_list(head);
 
 		return true;
@@ -562,7 +558,7 @@ static bool __assign_resources_required_optional_sorted(struct list_head *head,
 		if (res->parent && !pci_need_to_release(fail_type, res)) {
 			/* remove it from realloc_head list */
 			remove_from_list(realloc_head, res);
-			remove_from_list(&save_head, res);
+			remove_from_list(save_head, res);
 			list_del(&dev_res->list);
 			kfree(dev_res);
 		}
@@ -581,11 +577,9 @@ static bool __assign_resources_required_optional_sorted(struct list_head *head,
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
 	/* Check required+optional add */
-	if (realloc_head &&
-	    __assign_resources_required_optional_sorted(head, realloc_head))
+	if (has_addon(head, realloc_head) &&
+	    save_resources(head, &save_head) &&
+	    __assign_resources_required_optional_sorted(head, &save_head,
+					       realloc_head)) {
+		free_list(&save_head);
 		return;
+	}
 
 	sort_resources(head);
 
 	/* Satisfy the must-have resource requests */
 	assign_requested_resources_sorted(head, fail_head);
 
+	free_list(&save_head);
+
 	/* Try to satisfy any additional optional resource
 		requests */
 	if (realloc_head)
-- 
1.8.4.5

