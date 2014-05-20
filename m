Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:48931 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbaETDpy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 May 2014 23:45:54 -0400
Received: by mail-ie0-f181.google.com with SMTP id ar20so209155iec.40
        for <linux-pci@vger.kernel.org>; Mon, 19 May 2014 20:45:54 -0700 (PDT)
Subject: [PATCH v10 1/4] PCI: Restrict 64-bit prefetchable bridge windows to
 64-bit resources
To: Yinghai Lu <yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: talal@mellanox.com, Wei Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	amirv@mellanox.com, eugenia@mellanox.com,
	Guo Chao <yan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>
Date: Mon, 19 May 2014 21:45:52 -0600
Message-ID: <20140520034551.11972.38303.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140520033233.11972.49094.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140520033233.11972.49094.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Yinghai Lu <yinghai@kernel.org>

This patch changes the way we handle 64-bit prefetchable bridge windows to
make it more likely that we can assign space to all devices.

Previously we put all prefetchable resources in the prefetchable bridge
window.  If any of those resources was 32-bit only, we restricted the
window to be below 4GB.

After this patch, we only put 64-bit prefetchable resources in a 64-bit
prefetchable window.  We put all 32-bit prefetchable resources in the
non-prefetchable window, even if there are no 64-bit prefetchable
resources.

With the previous approach, if there was a 32-bit prefetchable resource
behind a bridge, we forced the bridge's prefetchable window below 4GB,
which meant that even if there was plenty of space above 4GB available, we
couldn't use it, and assignment of large 64-bit resources could fail, as
in the bugzilla below.

The new strategy is:

  1) If there is a 64-bit prefetchable window, we put only 64-bit
     prefetchable resources in it.  Any 32-bit prefetchable resources go in
     the non-prefetchable window.

  2) If there is a 32-bit prefetchable window, we put both 32- and 64-bit
     prefetchable resources in it.

  3) If there is no prefetchable window, all MMIO resources go in the
     non-prefetchable window.

This reduces performance for 32-bit prefetchable resources below a bridge
with a 64-bit prefetchable window.  We previously assigned prefetchable
space, but now we'll assign non-prefetchable space.  This is the case even
if there are no 64-bit prefetchable resources, or if they would all fit
below 4GB.  In those cases, the old strategy would work and would have
better performance.

[bhelgaas: write changelog, add bugzilla link, fold in mem64_mask removal]
Link: https://bugzilla.kernel.org/show_bug.cgi?id=74151
Tested-by: Guo Chao <yan@linux.vnet.ibm.com>
Tested-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-bus.c |  150 +++++++++++++++++++++++++++++++----------------
 drivers/pci/setup-res.c |   20 ++++++
 2 files changed, 117 insertions(+), 53 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 5516657386a0..589f2261ab0e 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -713,12 +713,11 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
    bus resource of a given type. Note: we intentionally skip
    the bus resources which have already been assigned (that is,
    have non-NULL parent resource). */
-static struct resource *find_free_bus_resource(struct pci_bus *bus, unsigned long type)
+static struct resource *find_free_bus_resource(struct pci_bus *bus,
+			 unsigned long type_mask, unsigned long type)
 {
 	int i;
 	struct resource *r;
-	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM |
-				  IORESOURCE_PREFETCH;
 
 	pci_bus_for_each_resource(bus, r, i) {
 		if (r == &ioport_resource || r == &iomem_resource)
@@ -815,7 +814,8 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 		resource_size_t add_size, struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
-	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO);
+	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO,
+							IORESOURCE_IO);
 	resource_size_t size = 0, size0 = 0, size1 = 0;
 	resource_size_t children_add_size = 0;
 	resource_size_t min_align, align;
@@ -907,6 +907,8 @@ static inline resource_size_t calculate_mem_align(resource_size_t *aligns,
  * @bus : the bus
  * @mask: mask the resource flag, then compare it with type
  * @type: the type of free resource from bridge
+ * @type2: second match type
+ * @type3: third match type
  * @min_size : the minimum memory window that must to be allocated
  * @add_size : additional optional memory window
  * @realloc_head : track the additional memory window on this list
@@ -915,16 +917,17 @@ static inline resource_size_t calculate_mem_align(resource_size_t *aligns,
  * guarantees that all child resources fit in this size.
  */
 static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
-			 unsigned long type, resource_size_t min_size,
-			resource_size_t add_size,
-			struct list_head *realloc_head)
+			 unsigned long type, unsigned long type2,
+			 unsigned long type3,
+			 resource_size_t min_size, resource_size_t add_size,
+			 struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
 	resource_size_t min_align, align, size, size0, size1;
 	resource_size_t aligns[14];	/* Alignments from 1Mb to 8Gb */
 	int order, max_order;
-	struct resource *b_res = find_free_bus_resource(bus, type);
-	unsigned int mem64_mask = 0;
+	struct resource *b_res = find_free_bus_resource(bus,
+					mask | IORESOURCE_PREFETCH, type);
 	resource_size_t children_add_size = 0;
 
 	if (!b_res)
@@ -934,9 +937,6 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	max_order = 0;
 	size = 0;
 
-	mem64_mask = b_res->flags & IORESOURCE_MEM_64;
-	b_res->flags &= ~IORESOURCE_MEM_64;
-
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
 
@@ -944,7 +944,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			struct resource *r = &dev->resource[i];
 			resource_size_t r_size;
 
-			if (r->parent || (r->flags & mask) != type)
+			if (r->parent || ((r->flags & mask) != type &&
+					  (r->flags & mask) != type2 &&
+					  (r->flags & mask) != type3))
 				continue;
 			r_size = resource_size(r);
 #ifdef CONFIG_PCI_IOV
@@ -976,7 +978,6 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 				aligns[order] += align;
 			if (order > max_order)
 				max_order = order;
-			mem64_mask &= r->flags & IORESOURCE_MEM_64;
 
 			if (realloc_head)
 				children_add_size += get_res_add_size(realloc_head, r);
@@ -1001,7 +1002,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	}
 	b_res->start = min_align;
 	b_res->end = size0 + min_align - 1;
-	b_res->flags |= IORESOURCE_STARTALIGN | mem64_mask;
+	b_res->flags |= IORESOURCE_STARTALIGN;
 	if (size1 > size0 && realloc_head) {
 		add_to_list(realloc_head, bus->self, b_res, size1-size0, min_align);
 		dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window "
@@ -1117,8 +1118,9 @@ void __ref __pci_bus_size_bridges(struct pci_bus *bus,
 			struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
-	unsigned long mask, prefmask;
+	unsigned long mask, prefmask, type2 = 0, type3 = 0;
 	resource_size_t additional_mem_size = 0, additional_io_size = 0;
+	struct resource *b_res;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct pci_bus *b = dev->subordinate;
@@ -1163,15 +1165,37 @@ void __ref __pci_bus_size_bridges(struct pci_bus *bus,
 		   has already been allocated by arch code, try
 		   non-prefetchable range for both types of PCI memory
 		   resources. */
+		b_res = &bus->self->resource[PCI_BRIDGE_RESOURCES];
 		mask = IORESOURCE_MEM;
 		prefmask = IORESOURCE_MEM | IORESOURCE_PREFETCH;
-		if (pbus_size_mem(bus, prefmask, prefmask,
+		if (b_res[2].flags & IORESOURCE_MEM_64) {
+			prefmask |= IORESOURCE_MEM_64;
+			if (pbus_size_mem(bus, prefmask, prefmask,
+				  prefmask, prefmask,
 				  realloc_head ? 0 : additional_mem_size,
-				  additional_mem_size, realloc_head))
-			mask = prefmask; /* Success, size non-prefetch only. */
-		else
-			additional_mem_size += additional_mem_size;
-		pbus_size_mem(bus, mask, IORESOURCE_MEM,
+				  additional_mem_size, realloc_head)) {
+					/*
+					 * Success, with pref mmio64,
+					 * next will size non-pref or
+					 * non-mmio64 */
+					mask = prefmask;
+					type2 = prefmask & ~IORESOURCE_MEM_64;
+					type3 = prefmask & ~IORESOURCE_PREFETCH;
+			}
+		}
+		if (!type2) {
+			prefmask &= ~IORESOURCE_MEM_64;
+			if (pbus_size_mem(bus, prefmask, prefmask,
+					 prefmask, prefmask,
+					 realloc_head ? 0 : additional_mem_size,
+					 additional_mem_size, realloc_head)) {
+				/* Success, next will size non-prefetch. */
+				mask = prefmask;
+			} else
+				additional_mem_size += additional_mem_size;
+			type2 = type3 = IORESOURCE_MEM;
+		}
+		pbus_size_mem(bus, mask, IORESOURCE_MEM, type2, type3,
 				realloc_head ? 0 : additional_mem_size,
 				additional_mem_size, realloc_head);
 		break;
@@ -1257,42 +1281,66 @@ static void __ref __pci_bridge_assign_resources(const struct pci_dev *bridge,
 static void pci_bridge_release_resources(struct pci_bus *bus,
 					  unsigned long type)
 {
-	int idx;
-	bool changed = false;
-	struct pci_dev *dev;
+	struct pci_dev *dev = bus->self;
 	struct resource *r;
 	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM |
-				  IORESOURCE_PREFETCH;
+				  IORESOURCE_PREFETCH | IORESOURCE_MEM_64;
+	unsigned old_flags = 0;
+	struct resource *b_res;
+	int idx = 1;
 
-	dev = bus->self;
-	for (idx = PCI_BRIDGE_RESOURCES; idx <= PCI_BRIDGE_RESOURCE_END;
-	     idx++) {
-		r = &dev->resource[idx];
-		if ((r->flags & type_mask) != type)
-			continue;
-		if (!r->parent)
-			continue;
-		/*
-		 * if there are children under that, we should release them
-		 *  all
-		 */
-		release_child_resources(r);
-		if (!release_resource(r)) {
-			dev_printk(KERN_DEBUG, &dev->dev,
-				 "resource %d %pR released\n", idx, r);
-			/* keep the old size */
-			r->end = resource_size(r) - 1;
-			r->start = 0;
-			r->flags = 0;
-			changed = true;
-		}
-	}
+	b_res = &dev->resource[PCI_BRIDGE_RESOURCES];
+
+	/*
+	 *     1. if there is io port assign fail, will release bridge
+	 *	  io port.
+	 *     2. if there is non pref mmio assign fail, release bridge
+	 *	  nonpref mmio.
+	 *     3. if there is 64bit pref mmio assign fail, and bridge pref
+	 *	  is 64bit, release bridge pref mmio.
+	 *     4. if there is pref mmio assign fail, and bridge pref is
+	 *	  32bit mmio, release bridge pref mmio
+	 *     5. if there is pref mmio assign fail, and bridge pref is not
+	 *	  assigned, release bridge nonpref mmio.
+	 */
+	if (type & IORESOURCE_IO)
+		idx = 0;
+	else if (!(type & IORESOURCE_PREFETCH))
+		idx = 1;
+	else if ((type & IORESOURCE_MEM_64) &&
+		 (b_res[2].flags & IORESOURCE_MEM_64))
+		idx = 2;
+	else if (!(b_res[2].flags & IORESOURCE_MEM_64) &&
+		 (b_res[2].flags & IORESOURCE_PREFETCH))
+		idx = 2;
+	else
+		idx = 1;
+
+	r = &b_res[idx];
+
+	if (!r->parent)
+		return;
+
+	/*
+	 * if there are children under that, we should release them
+	 *  all
+	 */
+	release_child_resources(r);
+	if (!release_resource(r)) {
+		type = old_flags = r->flags & type_mask;
+		dev_printk(KERN_DEBUG, &dev->dev, "resource %d %pR released\n",
+					PCI_BRIDGE_RESOURCES + idx, r);
+		/* keep the old size */
+		r->end = resource_size(r) - 1;
+		r->start = 0;
+		r->flags = 0;
 
-	if (changed) {
 		/* avoiding touch the one without PREF */
 		if (type & IORESOURCE_PREFETCH)
 			type = IORESOURCE_PREFETCH;
 		__pci_setup_bridge(bus, type);
+		/* for next child res under same bridge */
+		r->flags = old_flags;
 	}
 }
 
@@ -1471,7 +1519,7 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 	LIST_HEAD(fail_head);
 	struct pci_dev_resource *fail_res;
 	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM |
-				  IORESOURCE_PREFETCH;
+				  IORESOURCE_PREFETCH | IORESOURCE_MEM_64;
 	int pci_try_num = 1;
 	enum enable_type enable_local;
 
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 7eed671d5586..2473f091a9cc 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -211,15 +211,31 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 
 	/* First, try exact prefetching match.. */
 	ret = pci_bus_alloc_resource(bus, res, size, align, min,
-				     IORESOURCE_PREFETCH,
+				     IORESOURCE_PREFETCH | IORESOURCE_MEM_64,
 				     pcibios_align_resource, dev);
 
-	if (ret < 0 && (res->flags & IORESOURCE_PREFETCH)) {
+	if (ret < 0 &&
+	    (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) ==
+	     (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) {
+		/*
+		 * That failed.
+		 *
+		 * Try 32bit pref
+		 */
+		ret = pci_bus_alloc_resource(bus, res, size, align, min,
+					     IORESOURCE_PREFETCH,
+					     pcibios_align_resource, dev);
+	}
+
+	if (ret < 0 &&
+	    (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64))) {
 		/*
 		 * That failed.
 		 *
 		 * But a prefetching area can handle a non-prefetching
 		 * window (it will just not perform as well).
+		 *
+		 * Also can put 64bit under 32bit range. (below 4g).
 		 */
 		ret = pci_bus_alloc_resource(bus, res, size, align, min, 0,
 					     pcibios_align_resource, dev);

