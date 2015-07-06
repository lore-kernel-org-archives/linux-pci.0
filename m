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
Subject: [PATCH 03/36] PCI: Use correct align for optional only resources during sorting for resource allocation
Date: Mon,  6 Jul 2015 16:38:53 -0700
Message-Id: <1436225966-27247-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
References: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

During sorting before assign, we only put resource with non-zero align
in the sorted list, so for optional resources that must part is 0 and only
have addon parts, we need to have correct align.

Use addon resource align instead in that case.

Sorted list will contain must res align/size to 0/0 to hold spot for
optional resources.

And later we will treat the ROM BAR as optional resource with this support.

The patch will pass realloc_head from sizing stage to sorting stage, and
get entry from realloc and calculate align from the entry.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=81431
Reported-by: TJ <linux@iam.tj>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 45 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 247d8fe..9f4c477 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -145,9 +145,38 @@ static resource_size_t get_res_add_align(struct list_head *head,
 	return dev_res->min_align;
 }
 
+static resource_size_t __pci_resource_alignment(
+				struct pci_dev *dev,
+				struct resource *r,
+				struct list_head *realloc_head)
+{
+	resource_size_t r_align = pci_resource_alignment(dev, r);
+	resource_size_t orig_start, orig_end;
+
+	if (r_align || !realloc_head)
+		return r_align;
+
+	orig_start = r->start;
+	orig_end = r->end;
+	r->end += get_res_add_size(realloc_head, r);
+	if ((r->flags & IORESOURCE_STARTALIGN)) {
+		resource_size_t r_size = resource_size(r);
+		resource_size_t add_align = get_res_add_align(realloc_head, r);
+
+		r->start = add_align;
+		r->end = add_align + r_size - 1;
+	}
+	r_align = pci_resource_alignment(dev, r);
+	r->start = orig_start;
+	r->end = orig_end;
+
+	return r_align;
+}
 
 /* Sort resources by alignment */
-static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
+static void pdev_sort_resources(struct pci_dev *dev,
+				 struct list_head *realloc_head,
+				 struct list_head *head)
 {
 	int i;
 
@@ -165,7 +194,7 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 		if (!(r->flags) || r->parent)
 			continue;
 
-		r_align = pci_resource_alignment(dev, r);
+		r_align = __pci_resource_alignment(dev, r, realloc_head);
 		if (!r_align) {
 			dev_warn(&dev->dev, "BAR %d: %pR has bogus alignment\n",
 				 i, r);
@@ -183,8 +212,9 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 		list_for_each_entry(dev_res, head, list) {
 			resource_size_t align;
 
-			align = pci_resource_alignment(dev_res->dev,
-							 dev_res->res);
+			align = __pci_resource_alignment(dev_res->dev,
+							 dev_res->res,
+							 realloc_head);
 
 			if (r_align > align) {
 				n = &dev_res->list;
@@ -197,6 +227,7 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 }
 
 static void __dev_sort_resources(struct pci_dev *dev,
+				 struct list_head *realloc_head,
 				 struct list_head *head)
 {
 	u16 class = dev->class >> 8;
@@ -213,7 +244,7 @@ static void __dev_sort_resources(struct pci_dev *dev,
 			return;
 	}
 
-	pdev_sort_resources(dev, head);
+	pdev_sort_resources(dev, realloc_head, head);
 }
 
 static inline void reset_resource(struct resource *res)
@@ -501,7 +532,7 @@ static void pdev_assign_resources_sorted(struct pci_dev *dev,
 {
 	LIST_HEAD(head);
 
-	__dev_sort_resources(dev, &head);
+	__dev_sort_resources(dev, add_head, &head);
 	__assign_resources_sorted(&head, add_head, fail_head);
 
 }
@@ -514,7 +545,7 @@ static void pbus_assign_resources_sorted(const struct pci_bus *bus,
 	LIST_HEAD(head);
 
 	list_for_each_entry(dev, &bus->devices, bus_list)
-		__dev_sort_resources(dev, &head);
+		__dev_sort_resources(dev, realloc_head, &head);
 
 	__assign_resources_sorted(&head, realloc_head, fail_head);
 }
-- 
1.8.4.5

