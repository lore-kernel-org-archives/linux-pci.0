Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:23298 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbaD3BM2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Apr 2014 21:12:28 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	amirv@mellanox.com, Or Gerlitz <ogerlitz@mellanox.com>,
	eugenia@mellanox.com, Guo Chao <yan@linux.vnet.ibm.com>,
	talal@mellanox.com, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] PCI: don't update bridge resource flags according to children
Date: Tue, 29 Apr 2014 18:11:55 -0700
Message-Id: <1398820315-27425-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

After
	PCI: Try best to allocate pref mmio 64bit above 4g
We don't need to check if children support 64bit, and update
bridge resource flags anymore.
As the new code check size and assign according exact type.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/setup-bus.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

Index: linux-2.6/drivers/pci/setup-bus.c
===================================================================
--- linux-2.6.orig/drivers/pci/setup-bus.c
+++ linux-2.6/drivers/pci/setup-bus.c
@@ -926,7 +926,6 @@ static int pbus_size_mem(struct pci_bus
 	int order, max_order;
 	struct resource *b_res = find_free_bus_resource(bus,
 					 mask | IORESOURCE_PREFETCH, type);
-	unsigned int mem64_mask = 0;
 	resource_size_t children_add_size = 0;
 
 	if (!b_res)
@@ -936,9 +935,6 @@ static int pbus_size_mem(struct pci_bus
 	max_order = 0;
 	size = 0;
 
-	mem64_mask = b_res->flags & IORESOURCE_MEM_64;
-	b_res->flags &= ~IORESOURCE_MEM_64;
-
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
 
@@ -980,7 +976,6 @@ static int pbus_size_mem(struct pci_bus
 				aligns[order] += align;
 			if (order > max_order)
 				max_order = order;
-			mem64_mask &= r->flags & IORESOURCE_MEM_64;
 
 			if (realloc_head)
 				children_add_size += get_res_add_size(realloc_head, r);
@@ -1005,7 +1000,7 @@ static int pbus_size_mem(struct pci_bus
 	}
 	b_res->start = min_align;
 	b_res->end = size0 + min_align - 1;
-	b_res->flags |= IORESOURCE_STARTALIGN | mem64_mask;
+	b_res->flags |= IORESOURCE_STARTALIGN;
 	if (size1 > size0 && realloc_head) {
 		add_to_list(realloc_head, bus->self, b_res, size1-size0, min_align);
 		dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window "
