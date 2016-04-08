Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Subject: [PATCH v11 35/60] PCI: Simplify res reference using in __assign_resources_sorted()
Date: Thu,  7 Apr 2016 17:15:48 -0700
Message-Id: <1460074573-7481-36-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There are couples of dev_res->res reference, to make code more readable
use res instead of dev_res->res directly.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index b22eb5f..7865e44 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -457,6 +457,7 @@ static void __assign_resources_sorted(struct list_head *head,
 	struct pci_dev_resource *dev_res, *tmp_res;
 	unsigned long fail_type;
 	resource_size_t add_align;
+	struct resource *res;
 
 	/* Check if optional add_size is there */
 	if (!realloc_head || list_empty(realloc_head))
@@ -472,8 +473,8 @@ static void __assign_resources_sorted(struct list_head *head,
 
 	/* Update res in head list with add_size in realloc_head list */
 	list_for_each_entry(dev_res, head, list) {
-		dev_res->res->end += get_res_add_size(realloc_head,
-							dev_res->res);
+		res = dev_res->res;
+		res->end += get_res_add_size(realloc_head, res);
 
 		/*
 		 * There are two kinds of additional resources in the list:
@@ -482,16 +483,16 @@ static void __assign_resources_sorted(struct list_head *head,
 		 * 2. resource with IORESOURCE_SIZEALIGN
 		 *    update size above already change alignment.
 		 */
-		if (!(dev_res->res->flags & IORESOURCE_STARTALIGN))
+		if (!(res->flags & IORESOURCE_STARTALIGN))
 			continue;
 
-		add_align = get_res_add_align(realloc_head, dev_res->res);
+		add_align = get_res_add_align(realloc_head, res);
 
 		if (add_align) {
-			resource_size_t r_size = resource_size(dev_res->res);
+			resource_size_t r_size = resource_size(res);
 
-			dev_res->res->start = add_align;
-			dev_res->res->end = add_align + r_size - 1;
+			res->start = add_align;
+			res->end = add_align + r_size - 1;
 		}
 	}
 
@@ -513,21 +514,21 @@ static void __assign_resources_sorted(struct list_head *head,
 	/* check failed type */
 	fail_type = pci_fail_res_type_mask(&local_fail_head);
 	/* remove not need to be released assigned res from head list etc */
-	list_for_each_entry_safe(dev_res, tmp_res, head, list)
-		if (dev_res->res->parent &&
-		    !pci_need_to_release(fail_type, dev_res->res)) {
+	list_for_each_entry_safe(dev_res, tmp_res, head, list) {
+		res = dev_res->res;
+		if (res->parent && !pci_need_to_release(fail_type, res)) {
 			/* remove it from realloc_head list */
-			remove_from_list(realloc_head, dev_res->res);
-			remove_from_list(&save_head, dev_res->res);
+			remove_from_list(realloc_head, res);
+			remove_from_list(&save_head, res);
 			list_del(&dev_res->list);
 			kfree(dev_res);
 		}
+	}
 
 	free_list(&local_fail_head);
 	/* Release assigned resource */
 	list_for_each_entry(dev_res, head, list) {
-		struct resource *res = dev_res->res;
-
+		res = dev_res->res;
 		if (res->parent) {
 			dev_printk(KERN_DEBUG, &dev_res->dev->dev,
 				   "BAR %d: released %pR\n",
@@ -538,8 +539,7 @@ static void __assign_resources_sorted(struct list_head *head,
 	}
 	/* Restore start/end/flags from saved list */
 	list_for_each_entry(save_res, &save_head, list) {
-		struct resource *res = save_res->res;
-
+		res = save_res->res;
 		res->start = save_res->start;
 		res->end = save_res->end;
 		res->flags = save_res->flags;
-- 
1.8.4.5
