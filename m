Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:23698 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770AbbJHVkc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2015 17:40:32 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v7 59/60] PCI: Don't set flags to 0 when assign resource fail
Date: Thu,  8 Oct 2015 14:39:18 -0700
Message-Id: <1444340359-8011-60-git-send-email-yinghai@kernel.org>
In-Reply-To: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We want to keep resource flags instead of clearing it after resource
allocation fails.

Make flags take IORESOURCE_UNSET | IORESOURCE_DISABLED instead.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/bus.c       |  2 +-
 drivers/pci/setup-bus.c | 45 +++++++++++++++++++++++----------------------
 drivers/pci/setup-res.c |  3 ++-
 3 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 0859e77..69f1b5e 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -140,7 +140,7 @@ static int pci_bus_alloc_from_region(struct pci_bus *bus, struct resource *res,
 	type_mask |= IORESOURCE_TYPE_BITS;
 
 	pci_bus_for_each_resource(bus, r, i) {
-		if (!r)
+		if (!r || resource_disabled(r))
 			continue;
 
 		/* type_mask must match */
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 23318bd..22ee1a1 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -264,13 +264,6 @@ static void __dev_assign_resources_prepare(struct pci_dev *dev,
 	pdev_assign_resources_prepare(dev, realloc_head, head);
 }
 
-static inline void reset_resource(struct resource *res)
-{
-	res->start = 0;
-	res->end = 0;
-	res->flags = 0;
-}
-
 static void sort_resources(struct list_head *head)
 {
 	struct pci_dev_resource *res1, *tmp_res, *res2;
@@ -337,7 +330,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 			res->start = align;
 			res->end = res->start + add_size - 1;
 			if (pci_assign_resource(add_res->dev, idx))
-				reset_resource(res);
+				res->flags |= IORESOURCE_DISABLED;
 		} else {
 			/* could just assigned with alt, add difference ? */
 			resource_size_t size;
@@ -391,7 +384,7 @@ static void assign_requested_resources_sorted(struct list_head *head,
 		    pci_assign_resource(dev_res->dev, idx)) {
 			if (fail_head)
 				add_to_list(fail_head, dev_res->dev, res);
-			reset_resource(res);
+			res->flags |= IORESOURCE_DISABLED;
 		}
 	}
 }
@@ -677,7 +670,7 @@ static void __assign_resources_alt_sorted(struct list_head *head,
 
 		if (!res_to_dev_res(local_fail_head, res))
 			add_to_list(local_fail_head, fail_res->dev, res);
-		reset_resource(res);
+		res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
 	}
 	free_list(&local_alt_fail_head);
 }
@@ -843,7 +836,7 @@ static void pci_setup_bridge_io(struct pci_dev *bridge)
 	/* Set up the top and bottom of the PCI I/O segment for this bus. */
 	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 0];
 	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (res->flags & IORESOURCE_IO) {
+	if ((res->flags & IORESOURCE_IO) && !(res->flags & IORESOURCE_UNSET)) {
 		pci_read_config_word(bridge, PCI_IO_BASE, &l);
 		io_base_lo = (region.start >> 8) & io_mask;
 		io_limit_lo = (region.end >> 8) & io_mask;
@@ -873,7 +866,8 @@ static void pci_setup_bridge_mmio(struct pci_dev *bridge)
 	/* Set up the top and bottom of the PCI Memory segment for this bus. */
 	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 1];
 	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (res->flags & IORESOURCE_MEM) {
+	if ((res->flags & IORESOURCE_MEM) &&
+	    !(res->flags & IORESOURCE_UNSET)) {
 		l = (region.start >> 16) & 0xfff0;
 		l |= region.end & 0xfff00000;
 		dev_info(&bridge->dev, "  bridge window %pR\n", res);
@@ -898,7 +892,8 @@ static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
 	bu = lu = 0;
 	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
 	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (res->flags & IORESOURCE_PREFETCH) {
+	if ((res->flags & IORESOURCE_PREFETCH) &&
+	    !(res->flags & IORESOURCE_UNSET)) {
 		l = (region.start >> 16) & 0xfff0;
 		l |= region.end & 0xfff00000;
 		if (res->flags & IORESOURCE_MEM_64) {
@@ -1028,6 +1023,7 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 
 	b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
 	b_res[1].flags |= IORESOURCE_MEM;
+	b_res[1].flags &= ~IORESOURCE_DISABLED;
 
 	pci_read_config_word(bridge, PCI_IO_BASE, &io);
 	if (!io) {
@@ -1035,8 +1031,10 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 		pci_read_config_word(bridge, PCI_IO_BASE, &io);
 		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
 	}
-	if (io)
+	if (io) {
 		b_res[0].flags |= IORESOURCE_IO;
+		b_res[0].flags &= ~IORESOURCE_DISABLED;
+	}
 
 	/*  DECchip 21050 pass 2 errata: the bridge may miss an address
 	    disconnect boundary by one PCI data phase.
@@ -1053,6 +1051,7 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 	}
 	if (pmem) {
 		b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH;
+		b_res[2].flags &= ~IORESOURCE_DISABLED;
 		if ((pmem & PCI_PREF_RANGE_TYPE_MASK) ==
 		    PCI_PREF_RANGE_TYPE_64) {
 			b_res[2].flags |= IORESOURCE_MEM_64;
@@ -1198,8 +1197,10 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 			struct resource *r = &dev->resource[i];
 			unsigned long r_size, r_add_size;
 
-			if (r->parent || !(r->flags & IORESOURCE_IO))
+			if (r->parent || !(r->flags & IORESOURCE_IO) ||
+			    resource_disabled(r))
 				continue;
+
 			r_size = resource_size(r);
 
 			if (r_size < 0x400)
@@ -1240,7 +1241,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 		if (b_res->start || b_res->end)
 			dev_info(&bus->self->dev, "disabling bridge window %pR to %pR (unused)\n",
 				 b_res, &bus->busn_res);
-		b_res->flags = 0;
+		b_res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
 		return;
 	}
 
@@ -1532,7 +1533,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 
 			if (r->parent || ((flags & mask) != type &&
 					  (flags & mask) != type2 &&
-					  (flags & mask) != type3))
+					  (flags & mask) != type3) ||
+			    resource_disabled(r))
 				continue;
 
 			r_size = resource_size(r);
@@ -1553,7 +1555,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			if (align > (1ULL<<37)) { /*128 Gb*/
 				dev_warn(&dev->dev, "disabling BAR %d: %pR (bad alignment %#llx)\n",
 					i, r, (unsigned long long) align);
-				r->flags = 0;
+				r->flags |= IORESOURCE_UNSET |
+					    IORESOURCE_DISABLED;
 				continue;
 			}
 
@@ -1650,7 +1653,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 		if (b_res->start || b_res->end)
 			dev_info(&bus->self->dev, "disabling bridge window %pR to %pR (unused)\n",
 				 b_res, &bus->busn_res);
-		b_res->flags = 0;
+		b_res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
 		return 0;
 	}
 
@@ -2067,7 +2070,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 		/* keep the old size */
 		r->end = resource_size(r) - 1;
 		r->start = 0;
-		r->flags = 0;
+		r->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
 
 		/* avoiding touch the one without PREF */
 		if (type & IORESOURCE_PREFETCH)
@@ -2336,7 +2339,6 @@ again:
 
 		restore_resource(fail_res, res);
 		if (fail_res->dev->subordinate) {
-			res->flags = 0;
 			/* last or third times and later */
 			if (tried_times + 1 == pci_try_num ||
 			    tried_times + 1 > 2)
@@ -2420,7 +2422,6 @@ again:
 
 		restore_resource(fail_res, res);
 		if (fail_res->dev->subordinate) {
-			res->flags = 0;
 			/* last time */
 			reset_bridge_resource_size(fail_res->dev, res);
 		}
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 55caf7a..d17f23c 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -364,7 +364,8 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
 
 		r = &dev->resource[i];
 
-		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
+		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)) ||
+		    resource_disabled(r))
 			continue;
 		if ((i == PCI_ROM_RESOURCE) &&
 				(!(r->flags & IORESOURCE_ROM_ENABLE)))
-- 
1.8.4.5

