Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:45863 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756977AbcDHAc5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 20:32:57 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v11 30/60] PCI: Reorder resources list for required/optional resources
Date: Thu,  7 Apr 2016 17:15:43 -0700
Message-Id: <1460074573-7481-31-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We try to allocate required+optional before allocate required only and
expand with optional.

At first we update size and alignment for required+optional resource.
And after that we reorder them with new alignment, but current we only
do that STARTALIGN ones.

For SIZEALIGN type resource, after add back add_size, the alignment
get changed, so need to do sorting like STARTALIGN type resources.

Also we need to reorder the sorting back after we restore
resource to required only when required+optional fail to allocate for all.

So move out the reordering code from the loop to separated function,
and call it two times accordingly.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 62 +++++++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f6b7b8f..aed62cc 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -285,6 +285,31 @@ static inline void reset_resource(struct resource *res)
 	res->flags = 0;
 }
 
+static void sort_resources(struct list_head *head)
+{
+	struct pci_dev_resource *res1, *tmp_res, *res2;
+
+	list_for_each_entry_safe(res1, tmp_res, head, list) {
+		resource_size_t align1, size1, align2, size2;
+
+		align1 = pci_resource_alignment(res1->dev, res1->res);
+		size1 = resource_size(res1->res);
+
+		/* reorder it */
+		list_for_each_entry(res2, head, list) {
+			if (res2 == res1)
+				break;
+
+			align2 = pci_resource_alignment(res2->dev, res2->res);
+			size2 = resource_size(res2->res);
+			if (is_before(align1, size1, align2, size2)) {
+				list_move_tail(&res1->list, &res2->list);
+				break;
+			}
+		}
+	}
+}
+
 /**
  * reassign_resources_sorted() - satisfy any additional resource requests
  *
@@ -453,9 +478,9 @@ static void __assign_resources_sorted(struct list_head *head,
 	LIST_HEAD(save_head);
 	LIST_HEAD(local_fail_head);
 	struct pci_dev_resource *save_res;
-	struct pci_dev_resource *dev_res, *tmp_res, *dev_res2;
+	struct pci_dev_resource *dev_res, *tmp_res;
 	unsigned long fail_type;
-	resource_size_t add_align, align;
+	resource_size_t add_align;
 
 	/* Check if optional add_size is there */
 	if (!realloc_head || list_empty(realloc_head))
@@ -470,47 +495,32 @@ static void __assign_resources_sorted(struct list_head *head,
 	}
 
 	/* Update res in head list with add_size in realloc_head list */
-	list_for_each_entry_safe(dev_res, tmp_res, head, list) {
+	list_for_each_entry(dev_res, head, list) {
 		dev_res->res->end += get_res_add_size(realloc_head,
 							dev_res->res);
 
 		/*
 		 * There are two kinds of additional resources in the list:
-		 * 1. bridge resource  -- IORESOURCE_STARTALIGN
-		 * 2. SR-IOV resource   -- IORESOURCE_SIZEALIGN
-		 * Here just fix the additional alignment for bridge
+		 * 1. bridge resource with IORESOURCE_STARTALIGN
+		 *    need to update start to change alignment
+		 * 2. resource with IORESOURCE_SIZEALIGN
+		 *    update size above already change alignment.
 		 */
 		if (!(dev_res->res->flags & IORESOURCE_STARTALIGN))
 			continue;
 
 		add_align = get_res_add_align(realloc_head, dev_res->res);
 
-		/*
-		 * The "head" list is sorted by the alignment to make sure
-		 * resources with bigger alignment will be assigned first.
-		 * After we change the alignment of a dev_res in "head" list,
-		 * we need to reorder the list by alignment to make it
-		 * consistent.
-		 */
-		if (add_align > dev_res->res->start) {
+		if (add_align) {
 			resource_size_t r_size = resource_size(dev_res->res);
 
 			dev_res->res->start = add_align;
 			dev_res->res->end = add_align + r_size - 1;
-
-			list_for_each_entry(dev_res2, head, list) {
-				align = pci_resource_alignment(dev_res2->dev,
-							       dev_res2->res);
-				if (add_align > align) {
-					list_move_tail(&dev_res->list,
-						       &dev_res2->list);
-					break;
-				}
-			}
 		}
-
 	}
 
+	sort_resources(head);
+
 	/* Try updated head list with add_size added */
 	assign_requested_resources_sorted(head, &local_fail_head);
 
@@ -552,6 +562,8 @@ static void __assign_resources_sorted(struct list_head *head,
 	}
 	free_list(&save_head);
 
+	sort_resources(head);
+
 requested_and_reassign:
 	/* Satisfy the must-have resource requests */
 	assign_requested_resources_sorted(head, fail_head);
-- 
1.8.4.5

