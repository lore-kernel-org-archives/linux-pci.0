Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:46708 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbbLKFH5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Dec 2015 00:07:57 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v9 25/60] PCI: Use correct align for optional only resources during sorting
Date: Thu, 10 Dec 2015 21:06:21 -0800
Message-Id: <1449810416-2950-26-git-send-email-yinghai@kernel.org>
In-Reply-To: <1449810416-2950-1-git-send-email-yinghai@kernel.org>
References: <1449810416-2950-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

During sorting before assign, we only put resource with non-zero align
in the sorted list, so for optional resources that required size is 0 and
only have optional parts, we need to have correct align.

While treating SRIOV as optional resources, we always read alignment for
SRIOV bars every time, so they are ok.
Hotplug bridge resources are using STARTALIGN so it is ok when size is 0
if we have correct start for them.

Later we want to treat the ROM BAR as optional resource, and it has
SIZEALIGN, so align=size will be 0. We need to find a way to get align
for them.

We can use optional resource align instead in that case, and it
is ok for SRIOV path and hotplug bridge resource path.

We need to pass realloc list from sizing stage to sorting stage, and
get entry from realloc list and calculate align from the entry.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=81431
Reported-by: TJ <linux@iam.tj>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6f6cf25..31334a1 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -145,9 +145,42 @@ static resource_size_t get_res_add_align(struct list_head *head,
 	return dev_res->min_align;
 }
 
+static resource_size_t __pci_resource_alignment(
+				struct pci_dev *dev,
+				struct resource *r,
+				struct list_head *realloc_head)
+{
+	resource_size_t r_align = pci_resource_alignment(dev, r);
+	resource_size_t orig_start, orig_end;
+	struct pci_dev_resource *dev_res;
+
+	if (r_align || !realloc_head)
+		return r_align;
+
+	dev_res = res_to_dev_res(realloc_head, r);
+	if (!dev_res || !dev_res->add_size)
+		return r_align;
+
+	orig_start = r->start;
+	orig_end = r->end;
+	r->end += dev_res->add_size;
+	if ((r->flags & IORESOURCE_STARTALIGN)) {
+		resource_size_t r_size = resource_size(r);
+
+		r->start = dev_res->min_align;
+		r->end = r->start + r_size - 1;
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
 
@@ -165,7 +198,7 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 		if (!(r->flags) || r->parent)
 			continue;
 
-		r_align = pci_resource_alignment(dev, r);
+		r_align = __pci_resource_alignment(dev, r, realloc_head);
 		if (!r_align) {
 			dev_warn(&dev->dev, "BAR %d: %pR has bogus alignment\n",
 				 i, r);
@@ -183,8 +216,9 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 		list_for_each_entry(dev_res, head, list) {
 			resource_size_t align;
 
-			align = pci_resource_alignment(dev_res->dev,
-							 dev_res->res);
+			align = __pci_resource_alignment(dev_res->dev,
+							 dev_res->res,
+							 realloc_head);
 
 			if (r_align > align) {
 				n = &dev_res->list;
@@ -197,6 +231,7 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 }
 
 static void __dev_sort_resources(struct pci_dev *dev,
+				 struct list_head *realloc_head,
 				 struct list_head *head)
 {
 	u16 class = dev->class >> 8;
@@ -213,7 +248,7 @@ static void __dev_sort_resources(struct pci_dev *dev,
 			return;
 	}
 
-	pdev_sort_resources(dev, head);
+	pdev_sort_resources(dev, realloc_head, head);
 }
 
 static inline void reset_resource(struct resource *res)
@@ -507,7 +542,7 @@ static void pdev_assign_resources_sorted(struct pci_dev *dev,
 {
 	LIST_HEAD(head);
 
-	__dev_sort_resources(dev, &head);
+	__dev_sort_resources(dev, add_head, &head);
 	__assign_resources_sorted(&head, add_head, fail_head);
 
 }
@@ -520,7 +555,7 @@ static void pbus_assign_resources_sorted(const struct pci_bus *bus,
 	LIST_HEAD(head);
 
 	list_for_each_entry(dev, &bus->devices, bus_list)
-		__dev_sort_resources(dev, &head);
+		__dev_sort_resources(dev, realloc_head, &head);
 
 	__assign_resources_sorted(&head, realloc_head, fail_head);
 }
-- 
1.8.4.5

