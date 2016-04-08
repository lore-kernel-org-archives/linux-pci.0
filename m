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
Subject: [PATCH v11 44/60] PCI: Add alt_size ressource allocation support
Date: Thu,  7 Apr 2016 17:15:57 -0700
Message-Id: <1460074573-7481-45-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On system with several pcie switches, BIOS allocate very tight resources
to the bridge bar, and it is not aligned to min_align as kernel allocation
code.

For example:
  02:03.0---0c:00.0---0d:04.0---18:00.0

  18:00.0 need 0x10000000, and 0x00010000.
BIOS only allocate 0x10100000 to 0d:04.0 and above bridges.
Later after using /sys/bus/pci/devices/0000:0c:00.0/remove to remove 0c:00.0,
rescan with /sys/bus/pci/rescan can not allocate 0x18000000 to 0c:00.0.
as current min_align solution will need 0x18000000.

Another example:
  00:1c.0---02:00.0---03:01.0---04:00.0---05:19.0---06:00.0

  06:00.0 need 0x4000000 and 0x800000.
BIOS only allocate 0x4800000 to 05:19.0 and 04:00.0.
when 05:19.0 get removed via /sys/bus/pci/devices/0000:05:19.0/remove,
rescan with /sys/bus/pci/rescan will fail.
 pci 0000:05:19.0: BAR 14: no space for [mem size 0x06000000]
 pci 0000:05:19.0: BAR 14: failed to assign [mem size 0x06000000]
 pci 0000:06:00.0: BAR 2: no space for [mem size 0x04000000 64bit]
 pci 0000:06:00.0: BAR 2: failed to assign [mem size 0x04000000 64bit]
 pci 0000:06:00.0: BAR 0: no space for [mem size 0x00800000]
 pci 0000:06:00.0: BAR 0: failed to assign [mem size 0x00800000]
current code try to use align 0x2000000 and size 0x6000000, but parent
bridge only have 0x4800000.

Introduce alt_align/alt_size and store them in realloc list in addition
to addon info, and will try it after min_align/min_size allocation fails.

The alt_align is max_align, and alt_size is aligned size with bridge
minimum window alignment.

On my test setup:
  00:1c.7---61:00.0---62:00.0

  62:00.0 needs 0x800000 and 0x20000, and 00:1c.7 only have 9M allocated
for mmio, with this patch we have

 pci 0000:61:00.0: bridge window [mem 0x00400000-0x00ffffff] to [bus 62]
   add_size 0 add_align 0 alt_size 900000 alt_align 800000
   req_size c00000 req_align 400000
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

So for 61:00.0 first try with 12M fails, and second try with 9M the
alt_size works. Later 62:00.0 get correct resource allocated too.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=100451
Reported-by: Yijing Wang <wangyijing@huawei.com>
Tested-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 203 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 191 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6c58b4a..f3e9873 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -322,7 +322,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 {
 	struct resource *res;
 	struct pci_dev_resource *add_res, *tmp;
-	resource_size_t add_size, align;
+	resource_size_t add_size, align, r_size;
 	int idx;
 
 	list_for_each_entry_safe(add_res, tmp, realloc_head, list) {
@@ -338,12 +338,23 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
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
+			resource_size_t size;
+
+			size = add_res->end - add_res->start + 1;
+			if (r_size < size)
+				add_size += size - r_size;
+
 			res->flags |= add_res->flags &
 				 (IORESOURCE_STARTALIGN|IORESOURCE_SIZEALIGN);
 			if (pci_reassign_resource(add_res->dev, idx,
@@ -582,6 +593,104 @@ static bool __assign_resources_required_optional_sorted(struct list_head *head,
 	return false;
 }
 
+static bool __has_alt(struct list_head *head,
+		    struct list_head *realloc_head)
+{
+	int alt_count = 0;
+	struct pci_dev_resource *dev_res, *alt_res;
+
+	if (!realloc_head)
+		return false;
+
+	/* check if we have alt really */
+	list_for_each_entry(dev_res, head, list) {
+		alt_res = res_to_dev_res(realloc_head, dev_res->res);
+		if (!alt_res || !alt_res->alt_size)
+			continue;
+
+		alt_count++;
+	}
+
+	if (!alt_count)
+		return false;
+
+	return true;
+}
+
+static void __assign_resources_alt_sorted(struct list_head *head,
+				 struct list_head *save_head,
+				 struct list_head *realloc_head,
+				 struct list_head *local_fail_head)
+{
+	LIST_HEAD(local_alt_fail_head);
+	struct pci_dev_resource *dev_res;
+	struct pci_dev_resource *alt_res, *fail_res, *save_res;
+	unsigned long fail_type;
+	struct resource *res;
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
+			/*
+			 * have to use saved info, as resource that does not
+			 * have addon/alt is not in realloc list.
+			 */
+			save_res = res_to_dev_res(save_head, res);
+			if (!save_res)
+				continue;
+
+			dev_printk(KERN_DEBUG, &dev_res->dev->dev,
+				   "BAR %d: released %pR\n",
+				   (int)(res - &dev_res->dev->resource[0]),
+				   res);
+			release_resource(dev_res->res);
+			restore_resource(save_res, res);
+		} else {
+			/* restore fail one */
+			fail_res = res_to_dev_res(local_fail_head, res);
+			if (fail_res) {
+				restore_resource(fail_res, res);
+				remove_from_list(local_fail_head, res);
+			}
+		}
+
+		alt_res = res_to_dev_res(realloc_head, res);
+		if (!alt_res || !alt_res->alt_size)
+			continue;
+
+		/* change res to alt */
+		if (res->flags & IORESOURCE_STARTALIGN)
+			res->start = alt_res->alt_align;
+		else
+			res->start = 0;
+		res->end = res->start + alt_res->alt_size - 1;
+	}
+
+	sort_resources(head);
+	/* Satisfy the alt resource requests */
+	assign_requested_resources_sorted(head, &local_alt_fail_head);
+
+	/* update local fail list */
+	list_for_each_entry(fail_res, &local_alt_fail_head, list) {
+		res = fail_res->res;
+		dev_res = res_to_dev_res(realloc_head, res);
+		/* change res back to required */
+		if (dev_res && dev_res->alt_size)
+			restore_resource(dev_res, res);
+
+		if (!res_to_dev_res(local_fail_head, res))
+			add_to_list(local_fail_head, fail_res->dev, res);
+		reset_resource(res);
+	}
+	free_list(&local_alt_fail_head);
+}
+
 static void __assign_resources_sorted(struct list_head *head,
 				 struct list_head *realloc_head,
 				 struct list_head *fail_head)
@@ -597,6 +706,8 @@ static void __assign_resources_sorted(struct list_head *head,
 	 */
 
 	LIST_HEAD(save_head);
+	LIST_HEAD(local_fail_head);
+	bool has_alt;
 
 	/* Check required+optional add */
 	if (has_addon(head, realloc_head) &&
@@ -609,15 +720,29 @@ static void __assign_resources_sorted(struct list_head *head,
 
 	sort_resources(head);
 
+	has_alt = __has_alt(head, realloc_head);
+	if (has_alt && list_empty(&save_head))
+		save_resources(head, &save_head);
+
 	/* Satisfy the must-have resource requests */
-	assign_requested_resources_sorted(head, fail_head);
+	assign_requested_resources_sorted(head, &local_fail_head);
+
+	if (has_alt && !list_empty(&local_fail_head) && !list_empty(&save_head))
+		__assign_resources_alt_sorted(head, &save_head,
+					      realloc_head,
+					      &local_fail_head);
 
 	free_list(&save_head);
 
-	/* Try to satisfy any additional optional resource
-		requests */
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
 
@@ -1293,6 +1418,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 					mask | IORESOURCE_PREFETCH, type);
 	LIST_HEAD(align_test_list);
 	LIST_HEAD(align_test_add_list);
+	resource_size_t alt_size = 0, alt_align = 0;
 	resource_size_t window_align;
 
 	if (!b_res)
@@ -1351,6 +1477,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 
 			if (realloc_head) {
 				resource_size_t add_r_size, add_align;
+				struct pci_dev_resource *dev_res;
 
 				add_r_size = get_res_add_size(realloc_head, r);
 				add_align = get_res_add_align(realloc_head, r);
@@ -1363,6 +1490,17 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 				sum_add_size += r_size + add_r_size;
 				if (add_align > max_add_align)
 					max_add_align = add_align;
+
+				dev_res = res_to_dev_res(realloc_head, r);
+				if (dev_res && dev_res->alt_size) {
+					alt_size += dev_res->alt_size;
+					if (alt_align < dev_res->alt_align)
+						alt_align = dev_res->alt_align;
+				} else if (r_size > 1) {
+					alt_size += r_size;
+					if (alt_align < align)
+						alt_align = align;
+				}
 			}
 		}
 	}
@@ -1376,6 +1514,17 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	}
 	free_align_test_list(&align_test_list);
 
+	if (size0 && realloc_head) {
+		alt_align = max(alt_align, window_align);
+		alt_size = calculate_memsize(alt_size, min_size,
+					     0, window_align);
+		/* required is better ? */
+		if (alt_size >= size0) {
+			alt_align = 0;
+			alt_size = 0;
+		}
+	}
+
 	if (sum_add_size < min_sum_size)
 		sum_add_size = min_sum_size;
 	if (sum_add_size > size && realloc_head) {
@@ -1397,13 +1546,43 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	b_res->start = min_align;
 	b_res->end = size0 + min_align - 1;
 	b_res->flags |= IORESOURCE_STARTALIGN;
-	if (size1 > size0 && realloc_head) {
-		__add_to_list(realloc_head, bus->self, b_res, size1 - size0,
-				min_add_align, 0, 0);
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
+		 *    add_size != 0, alt_size == 0, req_size == 0
+		 * 2. required only with smaller alt_size.
+		 *    add_size == 0, alt_size != 0, req_size > alt_size
+		 * 3. required + optional:
+		 *    add_size != 0, alt_size < req_size, req_size != 0
+		 *
+		 * So there is no req_size != 0, and alt_size == req_size.
+		 * in that case, we already set alt_size = 0.
+		 *
+		 * req_align/req_size is not stored directly, and we
+		 * have dev_res start/end/flags instead.
+		 */
+		if (final_add_size || alt_size) {
+			__add_to_list(realloc_head, bus->self, b_res,
+				      final_add_size, min_add_align,
+				      alt_size, alt_align);
+			dev_printk(KERN_DEBUG, &bus->self->dev,
+				   "bridge window %pR to %pR add_size %llx add_align %llx alt_size %llx alt_align %llx req_size %llx req_align %llx\n",
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
