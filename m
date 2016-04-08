Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:37933 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932559AbcDHA1h (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 20:27:37 -0400
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
Subject: [PATCH v11 59/60] PCI: Don't set flags to 0 when assign resource fail
Date: Thu,  7 Apr 2016 17:16:12 -0700
Message-Id: <1460074573-7481-60-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We want to keep resource flags instead of clearing it after resource
allocation fails.

Make flags take IORESOURCE_UNSET | IORESOURCE_DISABLED instead.

-v2: add missing UNSET for _alt retore to required path.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/bus.c       |  2 +-
 drivers/pci/setup-bus.c | 45 +++++++++++++++++++++++----------------------
 drivers/pci/setup-res.c |  3 ++-
 3 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 200fdac..f357fb8 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -142,7 +142,7 @@ static int pci_bus_alloc_from_region(struct pci_bus *bus, struct resource *res,
 	pci_bus_for_each_resource(bus, r, i) {
 		resource_size_t min_used = min;
 
-		if (!r)
+		if (!r || resource_disabled(r))
 			continue;
 
 		/* type_mask must match */
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index c77c204..d07ba87 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -263,13 +263,6 @@ static void __dev_assign_resources_prepare(struct pci_dev *dev,
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
@@ -336,7 +329,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 			res->start = align;
 			res->end = res->start + add_size - 1;
 			if (pci_assign_resource(add_res->dev, idx))
-				reset_resource(res);
+				res->flags |= IORESOURCE_DISABLED;
 		} else {
 			/* could just assigned with alt, add difference ? */
 			resource_size_t size;
@@ -390,7 +383,7 @@ static void assign_requested_resources_sorted(struct list_head *head,
 		    pci_assign_resource(dev_res->dev, idx)) {
 			if (fail_head)
 				add_to_list(fail_head, dev_res->dev, res);
-			reset_resource(res);
+			res->flags |= IORESOURCE_DISABLED;
 		}
 	}
 }
@@ -676,7 +669,7 @@ static void __assign_resources_alt_sorted(struct list_head *head,
 
 		if (!res_to_dev_res(local_fail_head, res))
 			add_to_list(local_fail_head, fail_res->dev, res);
-		reset_resource(res);
+		res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
 	}
 	free_list(&local_alt_fail_head);
 }
@@ -842,7 +835,7 @@ static void pci_setup_bridge_io(struct pci_dev *bridge)
 	/* Set up the top and bottom of the PCI I/O segment for this bus. */
 	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 0];
 	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (res->flags & IORESOURCE_IO) {
+	if ((res->flags & IORESOURCE_IO) && !(res->flags & IORESOURCE_UNSET)) {
 		pci_read_config_word(bridge, PCI_IO_BASE, &l);
 		io_base_lo = (region.start >> 8) & io_mask;
 		io_limit_lo = (region.end >> 8) & io_mask;
@@ -872,7 +865,8 @@ static void pci_setup_bridge_mmio(struct pci_dev *bridge)
 	/* Set up the top and bottom of the PCI Memory segment for this bus. */
 	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 1];
 	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (res->flags & IORESOURCE_MEM) {
+	if ((res->flags & IORESOURCE_MEM) &&
+	    !(res->flags & IORESOURCE_UNSET)) {
 		l = (region.start >> 16) & 0xfff0;
 		l |= region.end & 0xfff00000;
 		dev_info(&bridge->dev, "  bridge window %pR\n", res);
@@ -897,7 +891,8 @@ static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
 	bu = lu = 0;
 	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
 	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (res->flags & IORESOURCE_PREFETCH) {
+	if ((res->flags & IORESOURCE_PREFETCH) &&
+	    !(res->flags & IORESOURCE_UNSET)) {
 		l = (region.start >> 16) & 0xfff0;
 		l |= region.end & 0xfff00000;
 		if (res->flags & IORESOURCE_MEM_64) {
@@ -1027,6 +1022,7 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 
 	b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
 	b_res[1].flags |= IORESOURCE_MEM;
+	b_res[1].flags &= ~IORESOURCE_DISABLED;
 
 	pci_read_config_word(bridge, PCI_IO_BASE, &io);
 	if (!io) {
@@ -1034,8 +1030,10 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
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
@@ -1052,6 +1050,7 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 	}
 	if (pmem) {
 		b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH;
+		b_res[2].flags &= ~IORESOURCE_DISABLED;
 		if ((pmem & PCI_PREF_RANGE_TYPE_MASK) ==
 		    PCI_PREF_RANGE_TYPE_64) {
 			b_res[2].flags |= IORESOURCE_MEM_64;
@@ -1197,8 +1196,10 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 			struct resource *r = &dev->resource[i];
 			unsigned long r_size, r_add_size;
 
-			if (r->parent || !(r->flags & IORESOURCE_IO))
+			if (r->parent || !(r->flags & IORESOURCE_IO) ||
+			    resource_disabled(r))
 				continue;
+
 			r_size = resource_size(r);
 
 			if (r_size < 0x400)
@@ -1239,7 +1240,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 		if (b_res->start || b_res->end)
 			dev_info(&bus->self->dev, "disabling bridge window %pR to %pR (unused)\n",
 				 b_res, &bus->busn_res);
-		b_res->flags = 0;
+		b_res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
 		return;
 	}
 
@@ -1532,7 +1533,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			if (r->parent || (flags & IORESOURCE_PCI_FIXED) ||
 			    ((flags & mask) != type &&
 			     (flags & mask) != type2 &&
-			     (flags & mask) != type3))
+			     (flags & mask) != type3) ||
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
 
@@ -2110,7 +2113,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 		/* keep the old size */
 		r->end = resource_size(r) - 1;
 		r->start = 0;
-		r->flags = 0;
+		r->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
 
 		/* avoiding touch the one without PREF */
 		if (type & IORESOURCE_PREFETCH)
@@ -2379,7 +2382,6 @@ again:
 
 		restore_resource(fail_res, res);
 		if (fail_res->dev->subordinate) {
-			res->flags = 0;
 			/* last or third times and later */
 			if (tried_times + 1 == pci_try_num ||
 			    tried_times + 1 > 2)
@@ -2463,7 +2465,6 @@ again:
 
 		restore_resource(fail_res, res);
 		if (fail_res->dev->subordinate) {
-			res->flags = 0;
 			/* last time */
 			reset_bridge_resource_size(fail_res->dev, res);
 		}
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 2f901f7..a3e683d 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -377,7 +377,8 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
 
 		r = &dev->resource[i];
 
-		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
+		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)) ||
+		    resource_disabled(r))
 			continue;
 		if ((i == PCI_ROM_RESOURCE) &&
 				(!(r->flags & IORESOURCE_ROM_ENABLE)))
-- 
1.8.4.5

