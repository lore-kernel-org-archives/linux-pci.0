Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:48136 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529Ab2F2GsF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 Jun 2012 02:48:05 -0400
Received: from /spool/local
	by e2.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Fri, 29 Jun 2012 02:48:05 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q5T6m1GT9830866
	for <linux-pci@vger.kernel.org>; Fri, 29 Jun 2012 02:48:01 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q5TCIqbo011746
	for <linux-pci@vger.kernel.org>; Fri, 29 Jun 2012 08:18:53 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: bhelgaas@google.com, yinghai@kernel.org, benh@kernel.crashing.org,
	linuxram@us.ibm.com, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 7/7] pci: resource assignment based on p2p alignment
Date: Fri, 29 Jun 2012 14:47:50 +0800
Message-Id: <4a82175568f1ed2ca4e5c1842365943ebf261931.1340949637.git.shangw@linux.vnet.ibm.com>
In-Reply-To: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
References: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
In-Reply-To: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
References: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch changes function pbus_size_io() and pbus_size_mem() to
do resource (I/O, memory and prefetchable memory) reassignment
based on the minimal alignments from the p2p bridge.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 8fa2d4b..52b60af 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -710,6 +710,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO);
 	unsigned long size = 0, size0 = 0, size1 = 0;
 	resource_size_t children_add_size = 0;
+	resource_size_t io_align;
 
 	if (!b_res)
  		return;
@@ -735,13 +736,15 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 				children_add_size += get_res_add_size(realloc_head, r);
 		}
 	}
+
+	io_align = pci_align_boundary(bus, IORESOURCE_IO);
 	size0 = calculate_iosize(size, min_size, size1,
-			resource_size(b_res), 4096);
+			resource_size(b_res), io_align);
 	if (children_add_size > add_size)
 		add_size = children_add_size;
 	size1 = (!realloc_head || (realloc_head && !add_size)) ? size0 :
 		calculate_iosize(size, min_size, add_size + size1,
-			resource_size(b_res), 4096);
+			resource_size(b_res), io_align);
 	if (!size0 && !size1) {
 		if (b_res->start || b_res->end)
 			dev_info(&bus->self->dev, "disabling bridge window "
@@ -751,11 +754,11 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 		return;
 	}
 	/* Alignment of the IO window is always 4K */
-	b_res->start = 4096;
+	b_res->start = io_align;
 	b_res->end = b_res->start + size0 - 1;
 	b_res->flags |= IORESOURCE_STARTALIGN;
 	if (size1 > size0 && realloc_head) {
-		add_to_list(realloc_head, bus->self, b_res, size1-size0, 4096);
+		add_to_list(realloc_head, bus->self, b_res, size1-size0, io_align);
 		dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window "
 				 "%pR to [bus %02x-%02x] add_size %lx\n", b_res,
 				 bus->secondary, bus->subordinate, size1-size0);
@@ -785,10 +788,15 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	struct resource *b_res = find_free_bus_resource(bus, type);
 	unsigned int mem64_mask = 0;
 	resource_size_t children_add_size = 0;
+	resource_size_t mem_align;
+	int mem_align_shift;
 
 	if (!b_res)
 		return 0;
 
+	mem_align = pci_align_boundary(bus, type);
+	mem_align_shift = __ffs(mem_align);
+
 	memset(aligns, 0, sizeof(aligns));
 	max_order = 0;
 	size = 0;
@@ -818,8 +826,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 #endif
 			/* For bridges size != alignment */
 			align = pci_resource_alignment(dev, r);
-			order = __ffs(align) - 20;
-			if (order > 11) {
+			order = __ffs(align) - mem_align_shift;
+			if (order > (11 - (mem_align_shift - 20))) {
 				dev_warn(&dev->dev, "disabling BAR %d: %pR "
 					 "(bad alignment %#llx)\n", i, r,
 					 (unsigned long long) align);
@@ -846,7 +854,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	for (order = 0; order <= max_order; order++) {
 		resource_size_t align1 = 1;
 
-		align1 <<= (order + 20);
+		align1 <<= (order + mem_align_shift);
 
 		if (!align)
 			min_align = align1;
-- 
1.7.9.5

