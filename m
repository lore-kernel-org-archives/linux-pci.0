Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Subject: [PATCH 16/36] PCI: Add alt_size allocation support
Date: Mon,  6 Jul 2015 16:39:06 -0700
Message-Id: <1436225966-27247-17-git-send-email-yinghai@kernel.org>
In-Reply-To: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
References: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On system with several pcie switches, BIOS allocate very tight resources
to the bar, and it is not aligned to min_align as kernel allocation code.

For example:
	02:03.0---0c:00.0---0d:04.0---18:00.0
18:00.0 need 0x10000000, and 0x00010000.
BIOS only allocate 0x10100000 to 0d:04.0 and above bridges.
Later after using /sys to remove 0c:00.0, rescan with /sys/bus/pci/rescan
can not allocate 0x18000000 to 0c:00.0.

another example:
00:1c.0-[02-21]----00.0-[03-21]--+-01.0-[04-12]----00.0-[05-12]----19.0-[06-12]----00.0
                                 +-05.0-[13]--
                                 +-07.0-[14-20]----00.0-[15-20]--+-08.0-[16]--+-00.0
                                 |                               |            \-00.1
                                 |                               +-14.0-[17]----00.0
                                 |                               \-19.0-[18-20]----00.0
                                 \-09.0-[21]--
06:00.0 need 0x4000000 and 0x800000.
BIOS only allocate 0x4800000 to 05:19.0 and 04:00.0.
when 05:19.0 get removed via /sys, and rescan will /sys/bus/pci/rescan
will fail.
 pci 0000:05:19.0: BAR 14: no space for [mem size 0x06000000]
 pci 0000:05:19.0: BAR 14: failed to assign [mem size 0x06000000]
 pci 0000:06:00.0: BAR 2: no space for [mem size 0x04000000 64bit]
 pci 0000:06:00.0: BAR 2: failed to assign [mem size 0x04000000 64bit]
 pci 0000:06:00.0: BAR 0: no space for [mem size 0x00800000]
 pci 0000:06:00.0: BAR 0: failed to assign [mem size 0x00800000]
current code try to use align 0x2000000 and size 0x6000000, but parent
bridge only have 0x4800000.

Introduce alt_align/alt_size and store in realloc list in addition to
addon info, and will try it after min_align/min_size allocation fails.

The alt_align is max_align, and alt_size is aligned size with bridge
minimum window alignment.

on my test setup:
	00:1c.7---61:00.0---62:00.0
62:00.0 needs 0x800000 and 0x20000.
and 00:1c.7 only have 9M allocated for mmio, with this patch we have

 pci 0000:61:00.0: bridge window [mem 0x00400000-0x00ffffff] to [bus 62] add_size 0 add_align 0 alt_size 900000 alt_align 800000 must_size c00000 must_align 400000
 pci 0000:61:00.0: BAR 14: no space for [mem size 0x00c00000]
 pci 0000:61:00.0: BAR 14: failed to assign [mem size 0x00c00000]
 pci 0000:61:00.0: BAR 14: assigned [mem 0xdf000000-0xdf8fffff]
 pci 0000:62:00.0: BAR 0: assigned [mem 0xdf000000-0xdf7fffff pref]
 pci 0000:62:00.0: BAR 1: assigned [mem 0xdf800000-0xdf81ffff]
 pci 0000:61:00.0: PCI bridge to [bus 62]
 pci 0000:61:00.0:   bridge window [io  0x6000-0x6fff]
 pci 0000:61:00.0:   bridge window [mem 0xdf000000-0xdf8fffff]
 pci 0000:00:1c.7: PCI bridge to [bus 61-68]
 pci 0000:00:1c.7:   bridge window [io  0x6000-0x6fff]
 pci 0000:00:1c.7:   bridge window [mem 0xdf000000-0xdf8fffff]

so for 61:00.0 first try with 12M fails, and second try with 9M the
alt_size works. Later 62:00.0 get correct resource allocated too.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=100451
Reported-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 192 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 175 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index e2aedac..c0090d4 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -331,7 +331,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 {
 	struct resource *res;
 	struct pci_dev_resource *add_res, *tmp;
-	resource_size_t add_size, align;
+	resource_size_t add_size, align, r_size;
 	int idx;
 
 	list_for_each_entry_safe(add_res, tmp, realloc_head, list) {
@@ -347,12 +347,19 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 		idx = res - &add_res->dev->resource[0];
 		add_size = add_res->add_size;
 		align = add_res->min_align;
-		if (!resource_size(res)) {
+		if (!add_size || !align) /* alt_size only */
+			goto out;
+
+		r_size = resource_size(res);
+		if (!r_size) {
 			res->start = align;
 			res->end = res->start + add_size - 1;
 			if (pci_assign_resource(add_res->dev, idx))
 				reset_resource(res);
 		} else {
+			/* could just assigned with alt, add difference ? */
+			if (r_size < add_res->must_size)
+				add_size += add_res->must_size - r_size;
 			res->flags |= add_res->flags &
 				 (IORESOURCE_STARTALIGN|IORESOURCE_SIZEALIGN);
 			if (pci_reassign_resource(add_res->dev, idx,
@@ -393,7 +400,7 @@ static void assign_requested_resources_sorted(struct list_head *head,
 	list_for_each_entry(dev_res, head, list) {
 		res = dev_res->res;
 		idx = res - &dev_res->dev->resource[0];
-		if (resource_size(res) &&
+		if (!res->parent && resource_size(res) &&
 		    pci_assign_resource(dev_res->dev, idx)) {
 			if (fail_head)
 				add_to_list(fail_head, dev_res->dev, res);
@@ -435,7 +442,6 @@ static bool pci_need_to_release(unsigned long mask, struct resource *res)
 	 *	3. if there is non-pref mmio assign fail or pref mmio
 	 *	   assigned fail, will release assigned non-pref mmio.
 	 */
-
 	if (res->flags & IORESOURCE_IO)
 		return !!(mask & IORESOURCE_IO);
 
@@ -573,6 +579,98 @@ static bool __assign_resources_must_add_sorted(struct list_head *head,
 	return false;
 }
 
+static void __assign_resources_alt_sorted(struct list_head *head,
+				 struct list_head *realloc_head,
+				 struct list_head *local_fail_head)
+{
+	LIST_HEAD(save_head);
+	LIST_HEAD(local_alt_fail_head);
+	struct pci_dev_resource *dev_res;
+	struct pci_dev_resource *alt_res, *fail_res;
+	unsigned long fail_type;
+	struct resource *res;
+	int alt_count = 0;
+
+	/* check if we have alt really */
+	list_for_each_entry(dev_res, head, list) {
+		res = dev_res->res;
+		alt_res = res_to_dev_res(realloc_head, res);
+		if (!alt_res || !alt_res->alt_size)
+			continue;
+
+		if (alt_res->must_size == alt_res->alt_size)
+			continue;
+
+		alt_count++;
+	}
+	if (!alt_count)
+		return;
+
+	/* check failed type */
+	fail_type = pci_fail_res_type_mask(local_fail_head);
+	/* release resource with same type that failes */
+	list_for_each_entry(dev_res, head, list) {
+		res = dev_res->res;
+		if (res->parent) {
+			if (!pci_need_to_release(fail_type, res))
+				continue;
+
+			dev_printk(KERN_DEBUG, &dev_res->dev->dev,
+				   "BAR %d: released %pR\n",
+				   (int)(res - &dev_res->dev->resource[0]),
+				   res);
+			release_resource(dev_res->res);
+			/* put into fail list */
+			add_to_list(local_fail_head, dev_res->dev, res);
+			reset_resource(res);
+		}
+
+		alt_res = res_to_dev_res(realloc_head, res);
+		if (!alt_res || !alt_res->alt_size)
+			continue;
+
+		fail_res = res_to_dev_res(local_fail_head, res);
+		if (!fail_res)  /* should not happen */
+			continue;
+
+		res->flags = fail_res->flags;
+		if (res->flags & IORESOURCE_STARTALIGN)
+			res->start = alt_res->alt_align;
+		else
+			res->start = 0;
+		res->end = res->start + alt_res->alt_size - 1;
+	}
+
+	__sort_resources(head);
+	/* Satisfy the alt resource requests */
+	assign_requested_resources_sorted(head, &local_alt_fail_head);
+
+	/* update local fail list */
+	list_for_each_entry(dev_res, head, list)
+		if (dev_res->res->parent)
+			remove_from_list(local_fail_head, dev_res->res);
+	list_for_each_entry(fail_res, local_fail_head, list)
+		remove_from_list(&local_alt_fail_head, fail_res->res);
+	list_for_each_entry(fail_res, &local_alt_fail_head, list) {
+		res = fail_res->res;
+		dev_res = res_to_dev_res(realloc_head, res);
+		if (!dev_res)  /* should not happen */
+			continue;
+
+		/* change res back must and save to fail list */
+		res->flags = fail_res->flags;
+		if (res->flags & IORESOURCE_STARTALIGN)
+			res->start = dev_res->must_align;
+		else
+			res->start = 0;
+		res->end = res->start + dev_res->must_size - 1;
+
+		add_to_list(local_fail_head, fail_res->dev, res);
+		reset_resource(res);
+	}
+	free_list(&local_alt_fail_head);
+}
+
 static void __assign_resources_sorted(struct list_head *head,
 				 struct list_head *realloc_head,
 				 struct list_head *fail_head)
@@ -589,6 +687,7 @@ static void __assign_resources_sorted(struct list_head *head,
 
 	LIST_HEAD(save_head);
 	LIST_HEAD(local_fail_head);
+	LIST_HEAD(local_alt_fail_head);
 
 	/* Check must+optional add */
 	if (realloc_head &&
@@ -598,12 +697,22 @@ static void __assign_resources_sorted(struct list_head *head,
 	__sort_resources(head);
 
 	/* Satisfy the must-have resource requests */
-	assign_requested_resources_sorted(head, fail_head);
+	assign_requested_resources_sorted(head, &local_fail_head);
 
-	/* Try to satisfy any additional optional resource
-		requests */
+	/* alt  */
+	if (realloc_head && !list_empty(&local_fail_head))
+		__assign_resources_alt_sorted(head, realloc_head,
+					      &local_fail_head);
+
+	/* Try to satisfy any additional optional resource requests */
 	if (realloc_head)
 		reassign_resources_sorted(realloc_head, head);
+
+	if (fail_head)
+		list_splice_tail(&local_fail_head, fail_head);
+	else
+		free_list(&local_fail_head);
+
 	free_list(head);
 }
 
@@ -1241,10 +1350,14 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 					mask | IORESOURCE_PREFETCH, type);
 	LIST_HEAD(align_test_list);
 	LIST_HEAD(align_test_add_list);
+	resource_size_t alt_size = 0, alt_align = 0;
+	resource_size_t window_align;
 
 	if (!b_res)
 		return -ENOSPC;
 
+	window_align = window_alignment(bus, b_res->flags);
+
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
 
@@ -1289,6 +1402,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 
 			if (realloc_head) {
 				resource_size_t add_r_size, add_align;
+				struct pci_dev_resource *dev_res;
 
 				add_r_size = get_res_add_size(realloc_head, r);
 				add_align = get_res_add_align(realloc_head, r);
@@ -1301,19 +1415,39 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 				sum_add_size += r_size + add_r_size;
 				if (add_align > max_add_align)
 					max_add_align = add_align;
+
+				dev_res = res_to_dev_res(realloc_head, r);
+				if (dev_res && dev_res->alt_size) {
+					alt_size += dev_res->alt_size;
+					if (alt_align < dev_res->alt_align)
+						alt_align = dev_res->alt_align;
+				}
 			}
 		}
 	}
 
-	max_align = max(max_align, window_alignment(bus, b_res->flags));
+	max_align = max(max_align, window_align);
 	if (size || min_size) {
 		min_align = calculate_mem_align(&align_test_list, max_align,
-				 size, window_alignment(bus, b_res->flags));
+						size, window_align);
 		size0 = calculate_memsize(size, min_size,
 				  resource_size(b_res), min_align);
 	}
 	free_align_test_list(&align_test_list);
 
+	if (size0 && realloc_head) {
+		if (!alt_size) {
+			alt_align = max_align;
+			alt_size = calculate_memsize(size, min_size,
+						     0, window_align);
+		}
+		/* must is better ? */
+		if (alt_size >= size0) {
+			alt_align = min_align;
+			alt_size = size0;
+		}
+	}
+
 	if (sum_add_size == size)
 		sum_add_size = add_size;
 	else if (add_size > sum_add_size - size)
@@ -1321,7 +1455,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	if (sum_add_size > size && realloc_head) {
 		min_add_align = calculate_mem_align(&align_test_add_list,
 					max_add_align, sum_add_size,
-					window_alignment(bus, b_res->flags));
+					window_align);
 		size1 = calculate_memsize(sum_add_size, min_size,
 				 resource_size(b_res), min_add_align);
 	}
@@ -1337,13 +1471,37 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	b_res->start = min_align;
 	b_res->end = size0 + min_align - 1;
 	b_res->flags |= IORESOURCE_STARTALIGN;
-	if (size1 > size0 && realloc_head) {
-		__add_to_list(realloc_head, bus->self, b_res, size1 - size0,
-				min_add_align, 0, 0, size0, min_align);
-		dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window %pR to %pR add_size %llx add_align %llx\n",
-			   b_res, &bus->busn_res,
-			   (unsigned long long) (size1 - size0),
-			   (unsigned long long) min_add_align);
+	if (realloc_head) {
+		resource_size_t final_add_size = 0;
+
+		if (size1 > size0)
+			final_add_size = size1 - size0;
+		else
+			min_add_align = 0;
+
+		/*
+		 * realloc list include three type entries
+		 * 1. optional only:
+		 *      add_size != 0, alt_size == 0, must_size == 0
+		 * 2. must only:
+		 *      add_size == 0, alt_size != 0, alt_size <= must_size
+		 * 3. must + optional:
+		 *      add_size != 0, alt_size != 0, alt_size <= must_size
+		 */
+		if (final_add_size || alt_size) {
+			__add_to_list(realloc_head, bus->self, b_res,
+				      final_add_size, min_add_align,
+				      alt_size, alt_align, size0, min_align);
+			dev_printk(KERN_DEBUG, &bus->self->dev,
+				   "bridge window %pR to %pR add_size %llx add_align %llx alt_size %llx alt_align %llx must_size %llx must_align %llx\n",
+				   b_res, &bus->busn_res,
+				   (unsigned long long)final_add_size,
+				   (unsigned long long)min_add_align,
+				   (unsigned long long)alt_size,
+				   (unsigned long long)alt_align,
+				   (unsigned long long)size0,
+				   (unsigned long long)min_align);
+		}
 	}
 	return 0;
 }
-- 
1.8.4.5

