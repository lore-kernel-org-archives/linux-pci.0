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
Subject: [PATCH v10 35/59] PCI: Add __add_to_list()
Date: Wed, 24 Feb 2016 18:12:26 -0800
Message-Id: <1456366370-28995-36-git-send-email-yinghai@kernel.org>
In-Reply-To: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For alt_size support, we will add more entries to realloc list.

Add new __add_to_list() to take alt_size, alt_align.

And simplify add_to_list() not to take add/alt input.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 51 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 664a89b..34b5eb3 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -66,6 +66,8 @@ struct pci_dev_resource {
 	resource_size_t end;
 	resource_size_t add_size;
 	resource_size_t min_align;
+	resource_size_t alt_size;
+	resource_size_t alt_align;
 	unsigned long flags;
 };
 
@@ -88,15 +90,16 @@ static void free_list(struct list_head *head)
  * @add_size:	additional size to be optionally added
  *              to the resource
  */
-static int add_to_list(struct list_head *head,
+static int __add_to_list(struct list_head *head,
 		 struct pci_dev *dev, struct resource *res,
-		 resource_size_t add_size, resource_size_t min_align)
+		 resource_size_t add_size, resource_size_t min_align,
+		 resource_size_t alt_size, resource_size_t alt_align)
 {
 	struct pci_dev_resource *tmp;
 
 	tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
 	if (!tmp) {
-		pr_warn("add_to_list: kmalloc() failed!\n");
+		pr_warn("__add_to_list: kmalloc() failed!\n");
 		return -ENOMEM;
 	}
 
@@ -107,12 +110,20 @@ static int add_to_list(struct list_head *head,
 	tmp->flags = res->flags;
 	tmp->add_size = add_size;
 	tmp->min_align = min_align;
+	tmp->alt_size = alt_size;
+	tmp->alt_align = alt_align;
 
 	list_add(&tmp->list, head);
 
 	return 0;
 }
 
+static int add_to_list(struct list_head *head,
+		 struct pci_dev *dev, struct resource *res)
+{
+	return __add_to_list(head, dev, res, 0, 0, 0, 0);
+}
+
 static void remove_from_list(struct list_head *head,
 				 struct resource *res)
 {
@@ -378,9 +389,7 @@ static void assign_requested_resources_sorted(struct list_head *head,
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
@@ -466,7 +475,7 @@ static void __assign_resources_sorted(struct list_head *head,
 
 	/* Save original start, end, flags etc at first */
 	list_for_each_entry(dev_res, head, list) {
-		if (add_to_list(&save_head, dev_res->dev, dev_res->res, 0, 0)) {
+		if (add_to_list(&save_head, dev_res->dev, dev_res->res)) {
 			free_list(&save_head);
 			goto requested_and_reassign;
 		}
@@ -1057,8 +1066,8 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	b_res->end = b_res->start + size0 - 1;
 	b_res->flags |= IORESOURCE_STARTALIGN;
 	if (size1 > size0 && realloc_head) {
-		add_to_list(realloc_head, bus->self, b_res, size1-size0,
-			    min_align);
+		__add_to_list(realloc_head, bus->self, b_res,
+			      size1 - size0, min_align, 0, 0);
 		dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window %pR to %pR add_size %llx\n",
 			   b_res, &bus->busn_res,
 			   (unsigned long long)size1-size0);
@@ -1262,7 +1271,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 				add_to_align_test_list(&align_test_add_list,
 							align, r_size);
 				r->end = r->start - 1;
-				add_to_list(realloc_head, dev, r, r_size, 0/* don't care */);
+				__add_to_list(realloc_head, dev, r,
+					      r_size, align, 0, 0);
 				sum_add_size += r_size;
 				if (align > max_add_align)
 					max_add_align = align;
@@ -1333,8 +1343,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	b_res->end = size0 + min_align - 1;
 	b_res->flags |= IORESOURCE_STARTALIGN;
 	if (size1 > size0 && realloc_head) {
-		add_to_list(realloc_head, bus->self, b_res, size1 - size0,
-				min_add_align);
+		__add_to_list(realloc_head, bus->self, b_res, size1 - size0,
+				min_add_align, 0, 0);
 		dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window %pR to %pR add_size %llx add_align %llx\n",
 			   b_res, &bus->busn_res,
 			   (unsigned long long) (size1 - size0),
@@ -1371,8 +1381,8 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 	b_res[0].flags |= IORESOURCE_IO | IORESOURCE_STARTALIGN;
 	if (realloc_head) {
 		b_res[0].end -= pci_cardbus_io_size;
-		add_to_list(realloc_head, bridge, b_res, pci_cardbus_io_size,
-				pci_cardbus_io_size);
+		__add_to_list(realloc_head, bridge, b_res,
+			      pci_cardbus_io_size, pci_cardbus_io_size, 0, 0);
 	}
 
 handle_b_res_1:
@@ -1383,8 +1393,8 @@ handle_b_res_1:
 	b_res[1].flags |= IORESOURCE_IO | IORESOURCE_STARTALIGN;
 	if (realloc_head) {
 		b_res[1].end -= pci_cardbus_io_size;
-		add_to_list(realloc_head, bridge, b_res+1, pci_cardbus_io_size,
-				 pci_cardbus_io_size);
+		__add_to_list(realloc_head, bridge, b_res + 1,
+			      pci_cardbus_io_size, pci_cardbus_io_size, 0, 0);
 	}
 
 handle_b_res_2:
@@ -1421,8 +1431,9 @@ handle_b_res_2:
 				  IORESOURCE_STARTALIGN;
 		if (realloc_head) {
 			b_res[2].end -= pci_cardbus_mem_size;
-			add_to_list(realloc_head, bridge, b_res+2,
-				 pci_cardbus_mem_size, pci_cardbus_mem_size);
+			__add_to_list(realloc_head, bridge, b_res + 2,
+				pci_cardbus_mem_size, pci_cardbus_mem_size,
+				0, 0);
 		}
 
 		/* reduce that to half */
@@ -1437,8 +1448,8 @@ handle_b_res_3:
 	b_res[3].flags |= IORESOURCE_MEM | IORESOURCE_STARTALIGN;
 	if (realloc_head) {
 		b_res[3].end -= b_res_3_size;
-		add_to_list(realloc_head, bridge, b_res+3, b_res_3_size,
-				 pci_cardbus_mem_size);
+		__add_to_list(realloc_head, bridge, b_res + 3,
+				b_res_3_size, pci_cardbus_mem_size, 0, 0);
 	}
 
 handle_done:
-- 
1.8.4.5
