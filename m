Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:49668 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756286AbbGFXlH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2015 19:41:07 -0400
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
Subject: [PATCH 13/36] PCI: Add __add_to_list()
Date: Mon,  6 Jul 2015 16:39:03 -0700
Message-Id: <1436225966-27247-14-git-send-email-yinghai@kernel.org>
In-Reply-To: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
References: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

to take alt_size, alt_align, must_size, must align.

preparation patch for alt_size support.


Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 60 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ed5f632..32cdc28 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -66,6 +66,10 @@ struct pci_dev_resource {
 	resource_size_t end;
 	resource_size_t add_size;
 	resource_size_t min_align;
+	resource_size_t alt_size;
+	resource_size_t alt_align;
+	resource_size_t must_size;
+	resource_size_t must_align;
 	unsigned long flags;
 };
 
@@ -88,15 +92,17 @@ static void free_list(struct list_head *head)
  * @add_size:	additional size to be optionally added
  *              to the resource
  */
-static int add_to_list(struct list_head *head,
+static int __add_to_list(struct list_head *head,
 		 struct pci_dev *dev, struct resource *res,
-		 resource_size_t add_size, resource_size_t min_align)
+		 resource_size_t add_size, resource_size_t min_align,
+		 resource_size_t alt_size, resource_size_t alt_align,
+		 resource_size_t must_size, resource_size_t must_align)
 {
 	struct pci_dev_resource *tmp;
 
 	tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
 	if (!tmp) {
-		pr_warn("add_to_list: kmalloc() failed!\n");
+		pr_warn("__add_to_list: kmalloc() failed!\n");
 		return -ENOMEM;
 	}
 
@@ -107,12 +113,29 @@ static int add_to_list(struct list_head *head,
 	tmp->flags = res->flags;
 	tmp->add_size = add_size;
 	tmp->min_align = min_align;
+	tmp->alt_size = alt_size;
+	tmp->alt_align = alt_align;
+	tmp->must_size = must_size;
+	tmp->must_align = must_align;
 
 	list_add(&tmp->list, head);
 
 	return 0;
 }
 
+static int add_to_list(struct list_head *head,
+		 struct pci_dev *dev, struct resource *res)
+{
+	return __add_to_list(head, dev, res, 0, 0, 0, 0, 0, 0);
+}
+
+static int add_optional_to_list(struct list_head *head,
+		 struct pci_dev *dev, struct resource *res,
+		 resource_size_t add_size, resource_size_t min_align)
+{
+	return __add_to_list(head, dev, res, add_size, min_align, 0, 0, 0, 0);
+}
+
 static void remove_from_list(struct list_head *head,
 				 struct resource *res)
 {
@@ -373,9 +396,7 @@ static void assign_requested_resources_sorted(struct list_head *head,
 		if (resource_size(res) &&
 		    pci_assign_resource(dev_res->dev, idx)) {
 			if (fail_head)
-				add_to_list(fail_head, dev_res->dev, res,
-					    0 /* don't care */,
-					    0 /* don't care */);
+				add_to_list(fail_head, dev_res->dev, res);
 			reset_resource(res);
 		}
 	}
@@ -461,7 +482,7 @@ static void __assign_resources_sorted(struct list_head *head,
 
 	/* Save original start, end, flags etc at first */
 	list_for_each_entry(dev_res, head, list) {
-		if (add_to_list(&save_head, dev_res->dev, dev_res->res, 0, 0)) {
+		if (add_to_list(&save_head, dev_res->dev, dev_res->res)) {
 			free_list(&save_head);
 			goto requested_and_reassign;
 		}
@@ -1014,8 +1035,8 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	b_res->end = b_res->start + size0 - 1;
 	b_res->flags |= IORESOURCE_STARTALIGN;
 	if (size1 > size0 && realloc_head) {
-		add_to_list(realloc_head, bus->self, b_res, size1-size0,
-			    min_align);
+		__add_to_list(realloc_head, bus->self, b_res, size1 - size0,
+				min_align, 0, 0, size0, min_align);
 		dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window %pR to %pR add_size %llx\n",
 			   b_res, &bus->busn_res,
 			   (unsigned long long)size1-size0);
@@ -1212,7 +1233,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 				add_to_align_test_list(&align_test_add_list,
 							align, r_size);
 				r->end = r->start - 1;
-				add_to_list(realloc_head, dev, r, r_size, 0/* don't care */);
+				add_optional_to_list(realloc_head, dev, r,
+							r_size, align);
 				sum_add_size += r_size;
 				if (align > max_add_align)
 					max_add_align = align;
@@ -1285,8 +1307,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	b_res->end = size0 + min_align - 1;
 	b_res->flags |= IORESOURCE_STARTALIGN;
 	if (size1 > size0 && realloc_head) {
-		add_to_list(realloc_head, bus->self, b_res, size1 - size0,
-				min_add_align);
+		__add_to_list(realloc_head, bus->self, b_res, size1 - size0,
+				min_add_align, 0, 0, size0, min_align);
 		dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window %pR to %pR add_size %llx add_align %llx\n",
 			   b_res, &bus->busn_res,
 			   (unsigned long long) (size1 - size0),
@@ -1323,8 +1345,8 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 	b_res[0].flags |= IORESOURCE_IO | IORESOURCE_STARTALIGN;
 	if (realloc_head) {
 		b_res[0].end -= pci_cardbus_io_size;
-		add_to_list(realloc_head, bridge, b_res, pci_cardbus_io_size,
-				pci_cardbus_io_size);
+		add_optional_to_list(realloc_head, bridge, b_res,
+				pci_cardbus_io_size, pci_cardbus_io_size);
 	}
 
 handle_b_res_1:
@@ -1335,8 +1357,8 @@ handle_b_res_1:
 	b_res[1].flags |= IORESOURCE_IO | IORESOURCE_STARTALIGN;
 	if (realloc_head) {
 		b_res[1].end -= pci_cardbus_io_size;
-		add_to_list(realloc_head, bridge, b_res+1, pci_cardbus_io_size,
-				 pci_cardbus_io_size);
+		add_optional_to_list(realloc_head, bridge, b_res + 1,
+			 pci_cardbus_io_size, pci_cardbus_io_size);
 	}
 
 handle_b_res_2:
@@ -1373,7 +1395,7 @@ handle_b_res_2:
 				  IORESOURCE_STARTALIGN;
 		if (realloc_head) {
 			b_res[2].end -= pci_cardbus_mem_size;
-			add_to_list(realloc_head, bridge, b_res+2,
+			add_optional_to_list(realloc_head, bridge, b_res+2,
 				 pci_cardbus_mem_size, pci_cardbus_mem_size);
 		}
 
@@ -1389,8 +1411,8 @@ handle_b_res_3:
 	b_res[3].flags |= IORESOURCE_MEM | IORESOURCE_STARTALIGN;
 	if (realloc_head) {
 		b_res[3].end -= b_res_3_size;
-		add_to_list(realloc_head, bridge, b_res+3, b_res_3_size,
-				 pci_cardbus_mem_size);
+		add_optional_to_list(realloc_head, bridge, b_res+3,
+				b_res_3_size, pci_cardbus_mem_size);
 	}
 
 handle_done:
-- 
1.8.4.5

