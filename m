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
Subject: [PATCH v2 05/49] PCI: Optimize bus align/size calculation for optional during sizing
Date: Tue, 14 Jul 2015 15:46:36 -0700
Message-Id: <1436914040-13206-6-git-send-email-yinghai@kernel.org>
In-Reply-To: <1436914040-13206-1-git-send-email-yinghai@kernel.org>
References: <1436914040-13206-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current add_align always use max align, that make must+optional
to get allocated more than needed in some cases.

Now we have new calculate_mem_align, we could use it for add_align
calculation.

Need to create separated list for must+optional align/size info.

After that we can get smaller add_align/size, we have more chance
to make must+optional to get allocated.

The result for bridge that have Intel 4x10g card installed.

 pci 0000:20:03.2: bridge window [mem 0x00000000-0x000fffff 64bit pref]
	to [bus 2a-31] calculate_mem for must
 ===========BEGIN========================
 align/size:
   00800000/00800000
   00800000/00800000
   00800000/00800000
   00800000/00800000
   00008000/00008000
   00008000/00008000
   00008000/00008000
   00008000/00008000
 old min_align/min_size: 00400000/02400000
     min_align/min_size: 00400000/02400000
 ===========END========================

 pci 0000:20:03.2: bridge window [mem 0x00000000-0x000fffff 64bit pref]
	to [bus 2a-31] calculate_mem for add
 ===========BEGIN========================
 align/size:
   00800000/00800000
   00800000/00800000
   00800000/00800000
   00800000/00800000
   00010000/00200000
   00010000/00200000
   00010000/00200000
   00010000/00200000
   00008000/00008000
   00008000/00008000
   00008000/00008000
   00008000/00008000
   00004000/00080000
   00004000/00080000
   00004000/00080000
   00004000/00080000
 old min_align/min_size: 00800000/03000000
     min_align/min_size: 00100000/02b00000
 ===========END========================

so must align/size: 0x400000/0x2400000, and
 new must+optional align/size: 0x100000/0x2b00000, and it is better
than old must+optional align/size: 0x800000/0x3000000

Link: https://bugzilla.kernel.org/show_bug.cgi?id=81431
Reported-by: TJ <linux@iam.tj>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 82 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ecdf011..4c7f25f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -901,7 +901,6 @@ static resource_size_t calculate_iosize(resource_size_t size,
 
 static resource_size_t calculate_memsize(resource_size_t size,
 		resource_size_t min_size,
-		resource_size_t size1,
 		resource_size_t old_size,
 		resource_size_t align)
 {
@@ -911,7 +910,7 @@ static resource_size_t calculate_memsize(resource_size_t size,
 		old_size = 0;
 	if (size < old_size)
 		size = old_size;
-	size = ALIGN(size + size1, align);
+	size = ALIGN(size, align);
 	return size;
 }
 
@@ -1174,44 +1173,45 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			 struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
-	resource_size_t min_align, align, size, size0, size1;
-	resource_size_t max_align = 0;
+	resource_size_t min_align = 0, min_add_align = 0;
+	resource_size_t max_align = 0, max_add_align = 0;
+	resource_size_t size = 0, size0 = 0, size1 = 0, sum_add_size = 0;
 	struct resource *b_res = find_free_bus_resource(bus,
 					mask | IORESOURCE_PREFETCH, type);
-	resource_size_t children_add_size = 0;
-	resource_size_t children_add_align = 0;
-	resource_size_t add_align = 0;
 	LIST_HEAD(align_test_list);
+	LIST_HEAD(align_test_add_list);
 
 	if (!b_res)
 		return -ENOSPC;
 
-	size = 0;
-
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
 
 		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 			struct resource *r = &dev->resource[i];
-			resource_size_t r_size;
+			resource_size_t r_size, align;
 
 			if (r->parent || ((r->flags & mask) != type &&
 					  (r->flags & mask) != type2 &&
 					  (r->flags & mask) != type3))
 				continue;
+
 			r_size = resource_size(r);
+			align = pci_resource_alignment(dev, r);
 #ifdef CONFIG_PCI_IOV
 			/* put SRIOV requested res to the optional list */
 			if (realloc_head && i >= PCI_IOV_RESOURCES &&
 					i <= PCI_IOV_RESOURCE_END) {
-				add_align = max(pci_resource_alignment(dev, r), add_align);
+				add_to_align_test_list(&align_test_add_list,
+							align, r_size);
 				r->end = r->start - 1;
 				add_to_list(realloc_head, dev, r, r_size, 0/* don't care */);
-				children_add_size += r_size;
+				sum_add_size += r_size;
+				if (align > max_add_align)
+					max_add_align = align;
 				continue;
 			}
 #endif
-			align = pci_resource_alignment(dev, r);
 			if (align > (1ULL<<37)) { /*128 Gb*/
 				dev_warn(&dev->dev, "disabling BAR %d: %pR (bad alignment %#llx)\n",
 					i, r, (unsigned long long) align);
@@ -1219,33 +1219,52 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 				continue;
 			}
 
-			if (r_size > 1)
+			if (r_size > 1) {
 				add_to_align_test_list(&align_test_list,
 							align, r_size);
-			size += r_size;
-			if (align > max_align)
-				max_align = align;
+				size += r_size;
+				if (align > max_align)
+					max_align = align;
+			}
 
 			if (realloc_head) {
-				children_add_size += get_res_add_size(realloc_head, r);
-				children_add_align = get_res_add_align(realloc_head, r);
-				add_align = max(add_align, children_add_align);
+				resource_size_t add_r_size, add_align;
+
+				add_r_size = get_res_add_size(realloc_head, r);
+				add_align = get_res_add_align(realloc_head, r);
+				/* no add on ? */
+				if (add_align < align)
+					add_align = align;
+				add_to_align_test_list(&align_test_add_list,
+							add_align,
+							r_size + add_r_size);
+				sum_add_size += r_size + add_r_size;
+				if (add_align > max_add_align)
+					max_add_align = add_align;
 			}
 		}
 	}
 
 	max_align = max(max_align, window_alignment(bus, b_res->flags));
-	min_align = calculate_mem_align(&align_test_list, max_align, size,
-					window_alignment(bus, b_res->flags));
-	size0 = calculate_memsize(size, min_size, 0,
+	if (size || min_size) {
+		min_align = calculate_mem_align(&align_test_list, max_align,
+				 size, window_alignment(bus, b_res->flags));
+		size0 = calculate_memsize(size, min_size,
 				  resource_size(b_res), min_align);
+	}
 	free_align_test_list(&align_test_list);
-	add_align = max(min_align, add_align);
-	if (children_add_size > add_size)
-		add_size = children_add_size;
-	size1 = (!realloc_head || (realloc_head && !add_size)) ? size0 :
-		calculate_memsize(size, min_size, add_size,
-				resource_size(b_res), add_align);
+
+	if ((sum_add_size - size) < add_size)
+		sum_add_size = size + add_size;
+	if (sum_add_size > size && realloc_head) {
+		min_add_align = calculate_mem_align(&align_test_add_list,
+					max_add_align, sum_add_size,
+					window_alignment(bus, b_res->flags));
+		size1 = calculate_memsize(sum_add_size, min_size,
+				 resource_size(b_res), min_add_align);
+	}
+	free_align_test_list(&align_test_add_list);
+
 	if (!size0 && !size1) {
 		if (b_res->start || b_res->end)
 			dev_info(&bus->self->dev, "disabling bridge window %pR to %pR (unused)\n",
@@ -1257,11 +1276,12 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	b_res->end = size0 + min_align - 1;
 	b_res->flags |= IORESOURCE_STARTALIGN;
 	if (size1 > size0 && realloc_head) {
-		add_to_list(realloc_head, bus->self, b_res, size1-size0, add_align);
+		add_to_list(realloc_head, bus->self, b_res, size1 - size0,
+				min_add_align);
 		dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window %pR to %pR add_size %llx add_align %llx\n",
 			   b_res, &bus->busn_res,
 			   (unsigned long long) (size1 - size0),
-			   (unsigned long long) add_align);
+			   (unsigned long long) min_add_align);
 	}
 	return 0;
 }
-- 
1.8.4.5

