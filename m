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
Subject: [PATCH v4 24/52] PCI: Better support for two alt_size
Date: Thu, 20 Aug 2015 23:20:39 -0700
Message-Id: <1440138067-4314-25-git-send-email-yinghai@kernel.org>
In-Reply-To: <1440138067-4314-1-git-send-email-yinghai@kernel.org>
References: <1440138067-4314-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Need to put aligned with max align before not aligned, to get
smaller alt_size.

For example:
alt align/size: 8M/9M, 4M/8M
before this patch we have 8M/20M.
After this patch we will have 8M/17M.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index baf9900..42552b2 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -58,6 +58,20 @@ static inline bool is_before(resource_size_t align1, resource_size_t size1,
 	return false;
 }
 
+static inline bool is_before_alt(resource_size_t align, resource_size_t size1,
+			     resource_size_t size2)
+{
+	resource_size_t size1_left, size2_left;
+
+	/*  aligned is before not aligned */
+	size1_left = size1 & (align - 1);
+	size2_left = size2 & (align - 1);
+	if (!size1_left && size2_left)
+		return true;
+
+	return false;
+}
+
 struct pci_dev_resource {
 	struct list_head list;
 	struct resource *res;
@@ -306,6 +320,42 @@ static void sort_resources(struct list_head *head)
 	}
 }
 
+static void sort_resources_alt(struct list_head *head)
+{
+	struct pci_dev_resource *res1, *tmp_res, *res2;
+	resource_size_t align = 0;
+
+
+	sort_resources(head);
+
+	/* get max align at first */
+	list_for_each_entry(res1, head, list) {
+		resource_size_t align1;
+
+		align1 = pci_resource_alignment(res1->dev, res1->res);
+		if (align1 > align)
+			align = align1;
+	}
+
+	list_for_each_entry_safe(res1, tmp_res, head, list) {
+		resource_size_t size1, size2;
+
+		size1 = resource_size(res1->res);
+
+		/* reorder it */
+		list_for_each_entry(res2, head, list) {
+			if (res2 == res1)
+				break;
+
+			size2 = resource_size(res2->res);
+			if (is_before_alt(align, size1, size2)) {
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
@@ -667,7 +717,7 @@ static void __assign_resources_alt_sorted(struct list_head *head,
 		res->end = res->start + alt_res->alt_size - 1;
 	}
 
-	sort_resources(head);
+	sort_resources_alt(head);
 	/* Satisfy the alt resource requests */
 	assign_requested_resources_sorted(head, &local_alt_fail_head);
 
@@ -1261,6 +1311,32 @@ static void sort_align_test(struct list_head *head)
 	}
 }
 
+static void sort_align_test_alt(struct list_head *head)
+{
+	struct align_test_res *res1, *tmp_res, *res2;
+	resource_size_t align = 0;
+
+	sort_align_test(head);
+
+	/* get max align at first */
+	list_for_each_entry(res1, head, list)
+		if (res1->align > align)
+			align = res1->align;
+
+	list_for_each_entry_safe(res1, tmp_res, head, list) {
+		/* reorder it */
+		list_for_each_entry(res2, head, list) {
+			if (res2 == res1)
+				break;
+
+			if (is_before_alt(align, res1->size, res2->size)) {
+				list_move_tail(&res1->list, &res2->list);
+				break;
+			}
+		}
+	}
+}
+
 static bool is_align_size_good(struct list_head *head,
 			resource_size_t min_align, resource_size_t size,
 			resource_size_t start)
@@ -1346,7 +1422,7 @@ static resource_size_t calculate_mem_alt_size(struct list_head *head,
 	if (count <= 1)
 		goto out;
 
-	sort_align_test(head);
+	sort_align_test_alt(head);
 
 	tmp = max(size, max_align);
 	order = __fls(count);
-- 
1.8.4.5

