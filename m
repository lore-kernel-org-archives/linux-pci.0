Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:42786 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757125AbcDHATJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 20:19:09 -0400
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
Subject: [PATCH v11 27/60] PCI: Optimize bus min_align/size calculation during sizing
Date: Thu,  7 Apr 2016 17:15:40 -0700
Message-Id: <1460074573-7481-28-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

During bus mmio resource sizing stage, current code try to get alignment as
small as possible and use that to align size to get final size. But it does
not handle resource that size is bigger than alignment in optimal way, kernel
only use max alignment for them.

For example:
 When we have resources with align/size: 1M/2M, 512M/512M,
 current code will have bus resource min_align/size: 512M/1024M,
 but optimal value should be 256M/768M, as we can fit them into
 [256M,768M) or [512M,1280M) instead of [512M,1536M).

 0M        256M        512M       768M       1024M      1280M
 |----------|-----------|----------|----------|----------|----------|
when we have [256M,1024M)
            |---------------------------------|
            |-2M-|      |---512M--------------|
when we have [512M,1280M)
                        |--------------------------------|
                        |---512M--------------|-2M-|

For following cases that we have resource size that is bigger
than resource alignment:
1. SRIOV bar.
2. PCI bridges with children that need several MMIOs that are more than 1M.

We can keep on trying to allocate children devices resources from range
[offset, offset + aligned_size) and offset is aligned with half min_align.
If it sucesses, we can use that half min_align as new min_align.

After this patch, we get:
 align/size: 1M/2M, 2M/4M, 4M/8M, 8M/16M
 new min_align/min_size: 4M/32M, and original is 8M/32M

 align/size: 1M/2M, 2M/4M, 4M/8M
 new min_align/min_size: 2M/14M, and original is 4M/16M

 align/size: 1M/2M, 512M/512M
 new min_align/min_size: 256M/768M, and original is 512M/1024M

The real result from one system with one pcie card that has
four functions that support sriov:
 children resources with align/size:
   00800000/00800000, 00800000/00800000, 00800000/00800000,
   00800000/00800000, 00010000/00200000, 00010000/00200000,
   00010000/00200000, 00010000/00200000, 00008000/00008000,
   00008000/00008000, 00008000/00008000, 00008000/00008000,
   00004000/00080000, 00004000/00080000, 00004000/00080000,
   00004000/00080000
for the bridge:
With original code we have min_align/min_size: 00400000/02c00000,
and with this patch we have min_align/min_size: 00100000/02b00000
So min_align will be 1M instead of 4M and we even have smaller size.

-v2: Need to check more offset with every min_alignment.
-v3: skip r_size <= 1 for optional only bridge resources.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=81431
Reported-by: TJ <linux@iam.tj>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 195 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 157 insertions(+), 38 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 544f518..3051bb7 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -29,6 +29,34 @@
 
 unsigned int pci_flags;
 
+static inline bool is_before(resource_size_t align1, resource_size_t size1,
+			     resource_size_t align2, resource_size_t size2)
+{
+	resource_size_t size1_left, size2_left;
+
+	/* big align is before small align */
+	if (align1 > align2)
+		return true;
+
+	/*
+	 * for same align:
+	 *   aligned is before not aligned
+	 *   for not aligned, big remainder is before small remainder
+	 */
+	if (align1 == align2) {
+		size1_left = size1 & (align1 - 1);
+		if (!size1_left)
+			size1_left = align1;
+		size2_left = size2 & (align2 - 1);
+		if (!size2_left)
+			size2_left = align2;
+		if (size1_left > size2_left)
+			return true;
+	}
+
+	return false;
+}
+
 struct pci_dev_resource {
 	struct list_head list;
 	struct resource *res;
@@ -1041,26 +1069,125 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	}
 }
 
-static inline resource_size_t calculate_mem_align(resource_size_t *aligns,
-						  int max_order)
+struct align_test_res {
+	struct list_head list;
+	struct resource res;
+	resource_size_t size;
+	resource_size_t align;
+};
+
+static void free_align_test_list(struct list_head *head)
 {
-	resource_size_t align = 0;
-	resource_size_t min_align = 0;
-	int order;
+	struct align_test_res *p, *tmp;
 
-	for (order = 0; order <= max_order; order++) {
-		resource_size_t align1 = 1;
+	list_for_each_entry_safe(p, tmp, head, list) {
+		list_del(&p->list);
+		kfree(p);
+	}
+}
 
-		align1 <<= (order + 20);
+static int add_to_align_test_list(struct list_head *head,
+				  resource_size_t align, resource_size_t size)
+{
+	struct align_test_res *tmp;
+
+	tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	tmp->align = align;
+	tmp->size = size;
+
+	list_add_tail(&tmp->list, head);
+
+	return 0;
+}
+
+static void sort_align_test(struct list_head *head)
+{
+	struct align_test_res *res1, *tmp_res, *res2;
 
-		if (!align)
-			min_align = align1;
-		else if (ALIGN(align + min_align, min_align) < align1)
-			min_align = align1 >> 1;
-		align += aligns[order];
+	list_for_each_entry_safe(res1, tmp_res, head, list) {
+		/* reorder it */
+		list_for_each_entry(res2, head, list) {
+			if (res2 == res1)
+				break;
+
+			if (is_before(res1->align, res1->size,
+				      res2->align, res2->size)) {
+				list_move_tail(&res1->list, &res2->list);
+				break;
+			}
+		}
+	}
+}
+
+static bool is_align_size_good(struct list_head *head,
+			resource_size_t min_align, resource_size_t size,
+			resource_size_t start)
+{
+	struct align_test_res *p;
+	struct resource root;
+
+	memset(&root, 0, sizeof(root));
+	root.start = start;
+	root.end = start + size - 1;
+
+	list_for_each_entry(p, head, list)
+		memset(&p->res, 0, sizeof(p->res));
+
+	list_for_each_entry(p, head, list)
+		if (allocate_resource(&root, &p->res, p->size,
+				0, (resource_size_t)-1ULL,
+				p->align, NULL, NULL))
+			return false;
+
+	return true;
+}
+
+static resource_size_t calculate_mem_align(struct list_head *head,
+				resource_size_t max_align, resource_size_t size,
+				resource_size_t align_low)
+{
+	struct align_test_res *p;
+	resource_size_t min_align, good_align, aligned_size, start;
+	int count = 0;
+
+	if (max_align <= align_low) {
+		good_align = align_low;
+		goto out;
 	}
 
-	return min_align;
+	good_align = max_align;
+
+	list_for_each_entry(p, head, list)
+		count++;
+
+	if (count <= 1)
+		goto out;
+
+	sort_align_test(head);
+
+	do {
+		/* check if we can use smaller align */
+		min_align = good_align >> 1;
+		aligned_size = ALIGN(size, min_align);
+
+		/* need to make sure every offset work */
+		for (start = min_align; start < max_align; start += min_align) {
+			/* checked already with last align ? */
+			if (!(start & (good_align - 1)))
+				continue;
+
+			if (!is_align_size_good(head, min_align, aligned_size,
+					       start))
+				goto out;
+		}
+		good_align = min_align;
+	} while (min_align > align_low);
+
+out:
+	return good_align;
 }
 
 /**
@@ -1090,19 +1217,17 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 {
 	struct pci_dev *dev;
 	resource_size_t min_align, align, size, size0, size1;
-	resource_size_t aligns[18];	/* Alignments from 1Mb to 128Gb */
-	int order, max_order;
+	resource_size_t max_align = 0;
 	struct resource *b_res = find_free_bus_resource(bus,
 					mask | IORESOURCE_PREFETCH, type);
 	resource_size_t children_add_size = 0;
 	resource_size_t children_add_align = 0;
 	resource_size_t add_align = 0;
+	LIST_HEAD(align_test_list);
 
 	if (!b_res)
 		return -ENOSPC;
 
-	memset(aligns, 0, sizeof(aligns));
-	max_order = 0;
 	size = 0;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
@@ -1130,29 +1255,20 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 				continue;
 			}
 #endif
-			/*
-			 * aligns[0] is for 1MB (since bridge memory
-			 * windows are always at least 1MB aligned), so
-			 * keep "order" from being negative for smaller
-			 * resources.
-			 */
 			align = pci_resource_alignment(dev, r);
-			order = __ffs(align) - 20;
-			if (order < 0)
-				order = 0;
-			if (order >= ARRAY_SIZE(aligns)) {
+			if (align > (1ULL<<37)) { /*128 Gb*/
 				dev_warn(&dev->dev, "disabling BAR %d: %pR (bad alignment %#llx)\n",
-					 i, r, (unsigned long long) align);
+					i, r, (unsigned long long) align);
 				r->flags = 0;
 				continue;
 			}
+
+			if (r_size > 1)
+				add_to_align_test_list(&align_test_list,
+							align, r_size);
 			size += r_size;
-			/* Exclude ranges with size > align from
-			   calculation of the alignment. */
-			if (r_size == align)
-				aligns[order] += align;
-			if (order > max_order)
-				max_order = order;
+			if (align > max_align)
+				max_align = align;
 
 			if (realloc_head) {
 				children_add_size += get_res_add_size(realloc_head, r);
@@ -1162,9 +1278,12 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 		}
 	}
 
-	min_align = calculate_mem_align(aligns, max_order);
-	min_align = max(min_align, window_alignment(bus, b_res->flags));
-	size0 = calculate_memsize(size, min_size, 0, resource_size(b_res), min_align);
+	max_align = max(max_align, window_alignment(bus, b_res->flags));
+	min_align = calculate_mem_align(&align_test_list, max_align, size,
+					window_alignment(bus, b_res->flags));
+	size0 = calculate_memsize(size, min_size, 0,
+				  resource_size(b_res), min_align);
+	free_align_test_list(&align_test_list);
 	add_align = max(min_align, add_align);
 	if (children_add_size > add_size)
 		add_size = children_add_size;
-- 
1.8.4.5

