Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:36692 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932745AbcDHAWi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 20:22:38 -0400
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
Subject: [PATCH v11 56/60] PCI: Add debug print out for min_align and alt_size
Date: Thu,  7 Apr 2016 17:16:09 -0700
Message-Id: <1460074573-7481-57-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Put all print out for all children align/size and result align/size
together.

We can print out device name at same time with min_align/alt_size
calculation.

So we can shut off debug print out from get_res_add_size() and
get_res_add_align().

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 76 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 56 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index c282b86..bd74349 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -158,11 +158,6 @@ static resource_size_t get_res_add_size(struct list_head *head,
 	if (!dev_res || !dev_res->add_size)
 		return 0;
 
-	dev_printk(KERN_DEBUG, &dev_res->dev->dev,
-		   "BAR %d: %pR get_res_add_size add_size   %#llx\n",
-		   (int)(res - &dev_res->dev->resource[0]),
-		   res, (unsigned long long)dev_res->add_size);
-
 	return dev_res->add_size;
 }
 
@@ -175,11 +170,6 @@ static resource_size_t get_res_add_align(struct list_head *head,
 	if (!dev_res || !dev_res->min_align)
 		return 0;
 
-	dev_printk(KERN_DEBUG, &dev_res->dev->dev,
-		   "BAR %d: %pR get_res_add_align min_align %#llx\n",
-		   (int)(res - &dev_res->dev->resource[0]),
-		   res, (unsigned long long)dev_res->min_align);
-
 	return dev_res->min_align;
 }
 
@@ -1270,6 +1260,8 @@ struct align_test_res {
 	struct resource res;
 	resource_size_t size;
 	resource_size_t align;
+	struct device *dev;
+	int idx;
 };
 
 static void free_align_test_list(struct list_head *head)
@@ -1283,7 +1275,8 @@ static void free_align_test_list(struct list_head *head)
 }
 
 static int add_to_align_test_list(struct list_head *head,
-				  resource_size_t align, resource_size_t size)
+				  resource_size_t align, resource_size_t size,
+				  struct device *dev, int idx)
 {
 	struct align_test_res *tmp;
 
@@ -1293,6 +1286,8 @@ static int add_to_align_test_list(struct list_head *head,
 
 	tmp->align = align;
 	tmp->size = size;
+	tmp->dev = dev;
+	tmp->idx = idx;
 
 	list_add_tail(&tmp->list, head);
 
@@ -1358,6 +1353,19 @@ static resource_size_t calculate_mem_align(struct list_head *head,
 	resource_size_t min_align, good_align, aligned_size, start;
 	int count = 0;
 
+	list_for_each_entry(p, head, list)
+		count++;
+
+	printk(KERN_DEBUG "  ===========BEGIN===calculate_mem_align========\n");
+	if (count) {
+		printk(KERN_DEBUG "  align/size:\n");
+		list_for_each_entry(p, head, list)
+			dev_printk(KERN_DEBUG, p->dev,
+				   "BAR %d:     %08llx/%08llx\n", p->idx,
+				   (unsigned long long)p->align,
+				   (unsigned long long)p->size);
+	}
+
 	if (max_align <= align_low) {
 		good_align = align_low;
 		goto out;
@@ -1365,9 +1373,6 @@ static resource_size_t calculate_mem_align(struct list_head *head,
 
 	good_align = max_align;
 
-	list_for_each_entry(p, head, list)
-		count++;
-
 	if (count <= 1)
 		goto out;
 
@@ -1392,6 +1397,11 @@ static resource_size_t calculate_mem_align(struct list_head *head,
 	} while (min_align > align_low);
 
 out:
+	printk(KERN_DEBUG "      min_align/aligned_size: %08llx/%08llx\n",
+			(unsigned long long)good_align,
+			(unsigned long long)ALIGN(size, good_align));
+	printk(KERN_DEBUG "  ===========END===calculate_mem_align==========\n");
+
 	return good_align;
 }
 
@@ -1409,6 +1419,16 @@ static resource_size_t calculate_mem_alt_size(struct list_head *head,
 	list_for_each_entry(p, head, list)
 		count++;
 
+	printk(KERN_DEBUG "  ===========BEGIN===calculate_mem_alt_size=====\n");
+	if (count) {
+		printk(KERN_DEBUG "  align/size:\n");
+		list_for_each_entry(p, head, list)
+			dev_printk(KERN_DEBUG, p->dev,
+				   "BAR %d:     %08llx/%08llx\n", p->idx,
+				   (unsigned long long)p->align,
+				   (unsigned long long)p->size);
+	}
+
 	if (count <= 1)
 		goto out;
 
@@ -1433,6 +1453,11 @@ static resource_size_t calculate_mem_alt_size(struct list_head *head,
 	}
 
 out:
+	printk(KERN_DEBUG "   alt_align/alt_size: %08llx/%08llx\n",
+			(unsigned long long)max_align,
+			(unsigned long long)good_size);
+	printk(KERN_DEBUG "  ===========END===calculate_mem_alt_size=======\n");
+
 	return good_size;
 }
 
@@ -1515,7 +1540,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			/* put SRIOV/ROM res to realloc list */
 			if (realloc_head && is_optional(i)) {
 				add_to_align_test_list(&align_test_add_list,
-							align, r_size);
+						align, r_size, &dev->dev, i);
 				r->end = r->start - 1;
 				__add_to_list(realloc_head, dev, r,
 					      r_size, align, 0, 0);
@@ -1534,7 +1559,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 
 			if (r_size > 1) {
 				add_to_align_test_list(&align_test_list,
-							align, r_size);
+						align, r_size, &dev->dev, i);
 				size += r_size;
 				if (align > max_align)
 					max_align = align;
@@ -1551,7 +1576,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 					add_align = align;
 				add_to_align_test_list(&align_test_add_list,
 							add_align,
-							r_size + add_r_size);
+							r_size + add_r_size,
+							&dev->dev, i);
 				sum_add_size += r_size + add_r_size;
 				if (add_align > max_add_align)
 					max_add_align = add_align;
@@ -1561,14 +1587,14 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 					add_to_align_test_list(
 						&align_test_alt_list,
 						dev_res->alt_align,
-						dev_res->alt_size);
+						dev_res->alt_size, &dev->dev, i);
 					alt_size += dev_res->alt_size;
 					if (alt_align < dev_res->alt_align)
 						alt_align = dev_res->alt_align;
 				} else if (r_size > 1) {
 					add_to_align_test_list(
 						&align_test_alt_list,
-						align, r_size);
+						align, r_size, &dev->dev, i);
 					alt_size += r_size;
 					if (alt_align < align)
 						alt_align = align;
@@ -1579,6 +1605,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 
 	max_align = max(max_align, window_align);
 	if (size || min_size) {
+		dev_printk(KERN_DEBUG, &bus->self->dev,
+			   "BAR %d: bridge window %pR to %pR calculate_mem for MUST\n",
+			   (int)(b_res - &bus->self->resource[0]), b_res, &bus->busn_res);
 		min_align = calculate_mem_align(&align_test_list, max_align,
 						size, window_align);
 		size0 = calculate_size(size, min_size,
@@ -1588,6 +1617,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 
 	if (size0 && realloc_head) {
 		alt_align = max(alt_align, window_align);
+		dev_printk(KERN_DEBUG, &bus->self->dev,
+			   "BAR %d: bridge window %pR to %pR calculate_mem for ALT\n",
+			   (int)(b_res - &bus->self->resource[0]), b_res, &bus->busn_res);
 		/* need to increase size to fit more alt */
 		alt_size = calculate_mem_alt_size(&align_test_alt_list,
 						  alt_align, alt_size,
@@ -1603,6 +1635,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	if (sum_add_size < min_sum_size)
 		sum_add_size = min_sum_size;
 	if (sum_add_size > size && realloc_head) {
+		dev_printk(KERN_DEBUG, &bus->self->dev,
+			   "BAR %d: bridge window %pR to %pR calculate_mem for ADD\n",
+			   (int)(b_res - &bus->self->resource[0]), b_res, &bus->busn_res);
 		min_add_align = calculate_mem_align(&align_test_add_list,
 					max_add_align, sum_add_size,
 					window_align);
@@ -1660,7 +1695,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 				      final_add_size, min_add_align,
 				      alt_size, alt_align);
 			dev_printk(KERN_DEBUG, &bus->self->dev,
-				   "bridge window %pR to %pR add_size %llx add_align %llx alt_size %llx alt_align %llx req_size %llx req_align %llx\n",
+				   "BAR %d: bridge window %pR to %pR add_size %llx add_align %llx alt_size %llx alt_align %llx req_size %llx req_align %llx\n",
+				   (int)(b_res - &bus->self->resource[0]),
 				   b_res, &bus->busn_res,
 				   (unsigned long long)final_add_size,
 				   (unsigned long long)min_add_align,
-- 
1.8.4.5

