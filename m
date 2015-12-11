Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v9 44/60] PCI: Add support for more than two alt_size entries under same bridge
Date: Thu, 10 Dec 2015 21:06:40 -0800
Message-Id: <1449810416-2950-45-git-send-email-yinghai@kernel.org>
In-Reply-To: <1449810416-2950-1-git-send-email-yinghai@kernel.org>
References: <1449810416-2950-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When we have two bridges under parent bridge, and each child
bridge has alt_size, we need to increase parent alt_size to make
sure it could fit all alt entries.

In the patch, we first select one big size, and then keep reducing
the size and retrying to get the minimum value for alt_size.

For example, two bridges:
  one have 8M/8M, and 1M/1M children res.
  one have 4M/4M, and 1M/1M children res.

Then we have child pridges alt_align/alt_size: 8M/9M, 4M/5M.
Before this patch, parent bridge alt_align/alt_size is 8M/14M
that is wrong, as it can not fit two alt entries at all.
With this patch	parent bridge alt_align/alt_size: 8M/17M.
               8M            16M   20M   24M
  |------------|-------------|-----|-----|
	       8M			   25M
	       |---------------------------|
			       17M
               |---9M----------|   |-5M----|


At same time, child bridges required align/size: 4M/12M, 2M/6M.
and prarent bridge required align/size: 4M/20M.

So at last, we use 8M/17M as parent bridge alt_align/alt_size.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=100451
Reported-by: Yijing Wang <wangyijing@huawei.com>
Tested-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 51c3b3d..9c9d9de 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1373,6 +1373,47 @@ out:
 	return good_align;
 }
 
+static resource_size_t calculate_mem_alt_size(struct list_head *head,
+				resource_size_t max_align, resource_size_t size,
+				resource_size_t align_low)
+{
+	struct align_test_res *p;
+	resource_size_t tmp;
+	resource_size_t good_size, bad_size;
+	int count = 0, order;
+
+	good_size = ALIGN(size, align_low);
+
+	list_for_each_entry(p, head, list)
+		count++;
+
+	if (count <= 1)
+		goto out;
+
+	sort_align_test(head);
+
+	tmp = max(size, max_align);
+	order = __fls(count);
+	if ((1ULL << order) < count)
+		order++;
+	good_size = ALIGN((tmp << order), align_low);
+	bad_size = ALIGN(size, align_low) - align_low;
+	size = good_size;
+	while (size > bad_size) {
+		/* check if align/size fit all entries */
+		if (is_align_size_good(head, max_align, size, 0))
+			good_size = size;
+		else
+			bad_size = size;
+
+		size = bad_size + ((good_size - bad_size) >> 1);
+		size = round_down(size, align_low);
+	}
+
+out:
+	return good_size;
+}
+
 static inline bool is_optional(int i)
 {
 
@@ -1419,6 +1460,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 					mask | IORESOURCE_PREFETCH, type);
 	LIST_HEAD(align_test_list);
 	LIST_HEAD(align_test_add_list);
+	LIST_HEAD(align_test_alt_list);
 	resource_size_t alt_size = 0, alt_align = 0;
 	resource_size_t window_align;
 
@@ -1494,10 +1536,17 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 
 				dev_res = res_to_dev_res(realloc_head, r);
 				if (dev_res && dev_res->alt_size) {
+					add_to_align_test_list(
+						&align_test_alt_list,
+						dev_res->alt_align,
+						dev_res->alt_size);
 					alt_size += dev_res->alt_size;
 					if (alt_align < dev_res->alt_align)
 						alt_align = dev_res->alt_align;
 				} else if (r_size > 1) {
+					add_to_align_test_list(
+						&align_test_alt_list,
+						align, r_size);
 					alt_size += r_size;
 					if (alt_align < align)
 						alt_align = align;
@@ -1517,14 +1566,17 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 
 	if (size0 && realloc_head) {
 		alt_align = max(alt_align, window_align);
-		alt_size = calculate_memsize(alt_size, min_size,
-					     0, window_align);
+		/* need to increase size to fit more alt */
+		alt_size = calculate_mem_alt_size(&align_test_alt_list,
+						  alt_align, alt_size,
+						  window_align);
 		/* required is better ? */
 		if (alt_size >= size0) {
 			alt_align = 0;
 			alt_size = 0;
 		}
 	}
+	free_align_test_list(&align_test_alt_list);
 
 	if (sum_add_size < min_sum_size)
 		sum_add_size = min_sum_size;
-- 
1.8.4.5

