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
Subject: [PATCH v11 36/60] PCI: Add __add_to_list()
Date: Thu,  7 Apr 2016 17:15:49 -0700
Message-Id: <1460074573-7481-37-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
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
index 7865e44..efa6d4e 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -65,6 +65,8 @@ struct pci_dev_resource {
 	resource_size_t end;
 	resource_size_t add_size;
 	resource_size_t min_align;
+	resource_size_t alt_size;
+	resource_size_t alt_align;
 	unsigned long flags;
 };
 
@@ -87,15 +89,16 @@ static void free_list(struct list_head *head)
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
 
@@ -106,12 +109,20 @@ static int add_to_list(struct list_head *head,
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
@@ -377,9 +388,7 @@ static void assign_requested_resources_sorted(struct list_head *head,
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
@@ -465,7 +474,7 @@ static void __assign_resources_sorted(struct list_head *head,
 
 	/* Save original start, end, flags etc at first */
 	list_for_each_entry(dev_res, head, list) {
-		if (add_to_list(&save_head, dev_res->dev, dev_res->res, 0, 0)) {
+		if (add_to_list(&save_head, dev_res->dev, dev_res->res)) {
 			free_list(&save_head);
 			goto requested_and_reassign;
 		}
@@ -1056,8 +1065,8 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
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
@@ -1261,7 +1270,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 				add_to_align_test_list(&align_test_add_list,
 							align, r_size);
 				r->end = r->start - 1;
-				add_to_list(realloc_head, dev, r, r_size, 0/* don't care */);
+				__add_to_list(realloc_head, dev, r,
+					      r_size, align, 0, 0);
 				sum_add_size += r_size;
 				if (align > max_add_align)
 					max_add_align = align;
@@ -1332,8 +1342,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
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
@@ -1370,8 +1380,8 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 	b_res[0].flags |= IORESOURCE_IO | IORESOURCE_STARTALIGN;
 	if (realloc_head) {
 		b_res[0].end -= pci_cardbus_io_size;
-		add_to_list(realloc_head, bridge, b_res, pci_cardbus_io_size,
-				pci_cardbus_io_size);
+		__add_to_list(realloc_head, bridge, b_res,
+			      pci_cardbus_io_size, pci_cardbus_io_size, 0, 0);
 	}
 
 handle_b_res_1:
@@ -1382,8 +1392,8 @@ handle_b_res_1:
 	b_res[1].flags |= IORESOURCE_IO | IORESOURCE_STARTALIGN;
 	if (realloc_head) {
 		b_res[1].end -= pci_cardbus_io_size;
-		add_to_list(realloc_head, bridge, b_res+1, pci_cardbus_io_size,
-				 pci_cardbus_io_size);
+		__add_to_list(realloc_head, bridge, b_res + 1,
+			      pci_cardbus_io_size, pci_cardbus_io_size, 0, 0);
 	}
 
 handle_b_res_2:
@@ -1420,8 +1430,9 @@ handle_b_res_2:
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
@@ -1436,8 +1447,8 @@ handle_b_res_3:
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
