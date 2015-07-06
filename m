Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:17856 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756224AbbGFXm3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2015 19:42:29 -0400
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
Subject: [PATCH 36/36] PCI: Don't set flags to 0 when assign resource fail
Date: Mon,  6 Jul 2015 16:39:26 -0700
Message-Id: <1436225966-27247-37-git-send-email-yinghai@kernel.org>
In-Reply-To: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
References: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

make flags take IORESOURCE_UNSET | IORESOURCE_DISABLED instead.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 52 +++++++++++++++++++++++++------------------------
 drivers/pci/setup-res.c | 11 +++++++++++
 2 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 9b27e15..e82655b 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -255,7 +255,8 @@ static void pdev_check_resources(struct pci_dev *dev,
 		if (r->flags & IORESOURCE_PCI_FIXED)
 			continue;
 
-		if (!(r->flags) || r->parent)
+		if (!r->flags || r->parent ||
+		    (r->flags & IORESOURCE_DISABLED))
 			continue;
 
 		r_align = __pci_resource_alignment(dev, r, realloc_head);
@@ -296,13 +297,6 @@ static void __dev_check_resources(struct pci_dev *dev,
 	pdev_check_resources(dev, realloc_head, head);
 }
 
-static inline void reset_resource(struct resource *res)
-{
-	res->start = 0;
-	res->end = 0;
-	res->flags = 0;
-}
-
 static void __sort_resources(struct list_head *head)
 {
 	struct pci_dev_resource *res1, *tmp_res, *res2;
@@ -387,7 +381,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 	list_for_each_entry_safe(add_res, tmp, realloc_head, list) {
 		res = add_res->res;
 		/* skip resource that has been reset */
-		if (!res->flags)
+		if (res->flags & IORESOURCE_DISABLED)
 			goto out;
 
 		/* skip this resource if not found in head list */
@@ -405,7 +399,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 			res->start = align;
 			res->end = res->start + add_size - 1;
 			if (pci_assign_resource(add_res->dev, idx))
-				reset_resource(res);
+				res->flags |= IORESOURCE_DISABLED;
 		} else {
 			/* could just assigned with alt, add difference ? */
 			if (r_size < add_res->must_size)
@@ -454,7 +448,7 @@ static void assign_requested_resources_sorted(struct list_head *head,
 		    pci_assign_resource(dev_res->dev, idx)) {
 			if (fail_head)
 				add_to_list(fail_head, dev_res->dev, res);
-			reset_resource(res);
+			res->flags |= IORESOURCE_DISABLED;
 		}
 	}
 }
@@ -672,7 +666,7 @@ static void __assign_resources_alt_sorted(struct list_head *head,
 			release_resource(dev_res->res);
 			/* put into fail list */
 			add_to_list(local_fail_head, dev_res->dev, res);
-			reset_resource(res);
+			res->flags |= IORESOURCE_DISABLED;
 		}
 
 		alt_res = res_to_dev_res(realloc_head, res);
@@ -716,7 +710,7 @@ static void __assign_resources_alt_sorted(struct list_head *head,
 		res->end = res->start + dev_res->must_size - 1;
 
 		add_to_list(local_fail_head, fail_res->dev, res);
-		reset_resource(res);
+		res->flags |= IORESOURCE_DISABLED;
 	}
 	free_list(&local_alt_fail_head);
 }
@@ -872,7 +866,7 @@ static void pci_setup_bridge_io(struct pci_dev *bridge)
 	/* Set up the top and bottom of the PCI I/O segment for this bus. */
 	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 0];
 	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (res->flags & IORESOURCE_IO) {
+	if ((res->flags & IORESOURCE_IO) && !(res->flags & IORESOURCE_UNSET)) {
 		pci_read_config_word(bridge, PCI_IO_BASE, &l);
 		io_base_lo = (region.start >> 8) & io_mask;
 		io_limit_lo = (region.end >> 8) & io_mask;
@@ -902,7 +896,8 @@ static void pci_setup_bridge_mmio(struct pci_dev *bridge)
 	/* Set up the top and bottom of the PCI Memory segment for this bus. */
 	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 1];
 	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (res->flags & IORESOURCE_MEM) {
+	if ((res->flags & IORESOURCE_MEM) &&
+	    !(res->flags & IORESOURCE_UNSET)) {
 		l = (region.start >> 16) & 0xfff0;
 		l |= region.end & 0xfff00000;
 		dev_info(&bridge->dev, "  bridge window %pR\n", res);
@@ -927,7 +922,8 @@ static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
 	bu = lu = 0;
 	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
 	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (res->flags & IORESOURCE_PREFETCH) {
+	if ((res->flags & IORESOURCE_PREFETCH) &&
+	    !(res->flags & IORESOURCE_UNSET)) {
 		l = (region.start >> 16) & 0xfff0;
 		l |= region.end & 0xfff00000;
 		if (res->flags & IORESOURCE_MEM_64) {
@@ -1046,6 +1042,7 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 
 	b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
 	b_res[1].flags |= IORESOURCE_MEM;
+	b_res[1].flags &= ~IORESOURCE_DISABLED;
 
 	pci_read_config_word(bridge, PCI_IO_BASE, &io);
 	if (!io) {
@@ -1053,8 +1050,10 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
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
@@ -1071,6 +1070,7 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 	}
 	if (pmem) {
 		b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH;
+		b_res[2].flags &= ~IORESOURCE_DISABLED;
 		if ((pmem & PCI_PREF_RANGE_TYPE_MASK) ==
 		    PCI_PREF_RANGE_TYPE_64) {
 			b_res[2].flags |= IORESOURCE_MEM_64;
@@ -1214,8 +1214,10 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 			struct resource *r = &dev->resource[i];
 			unsigned long r_size;
 
-			if (r->parent || !(r->flags & IORESOURCE_IO))
+			if (r->parent || !(r->flags & IORESOURCE_IO) ||
+			    (r->flags & IORESOURCE_DISABLED))
 				continue;
+
 			r_size = resource_size(r);
 
 			if (r_size < 0x400)
@@ -1244,7 +1246,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 		if (b_res->start || b_res->end)
 			dev_info(&bus->self->dev, "disabling bridge window %pR to %pR (unused)\n",
 				 b_res, &bus->busn_res);
-		b_res->flags = 0;
+		b_res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
 		return;
 	}
 
@@ -1513,7 +1515,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 
 			if (r->parent || ((flags & mask) != type &&
 					  (flags & mask) != type2 &&
-					  (flags & mask) != type3))
+					  (flags & mask) != type3) ||
+			    (r->flags & IORESOURCE_DISABLED))
 				continue;
 
 			r_size = resource_size(r);
@@ -1534,7 +1537,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			if (align > (1ULL<<37)) { /*128 Gb*/
 				dev_warn(&dev->dev, "disabling BAR %d: %pR (bad alignment %#llx)\n",
 					i, r, (unsigned long long) align);
-				r->flags = 0;
+				r->flags |= IORESOURCE_UNSET |
+					    IORESOURCE_DISABLED;
 				continue;
 			}
 
@@ -1622,7 +1626,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 		if (b_res->start || b_res->end)
 			dev_info(&bus->self->dev, "disabling bridge window %pR to %pR (unused)\n",
 				 b_res, &bus->busn_res);
-		b_res->flags = 0;
+		b_res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
 		return 0;
 	}
 	b_res->start = min_align;
@@ -2024,7 +2028,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 		/* keep the old size */
 		r->end = resource_size(r) - 1;
 		r->start = 0;
-		r->flags = 0;
+		r->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
 
 		/* avoiding touch the one without PREF */
 		if (type & IORESOURCE_PREFETCH)
@@ -2284,7 +2288,6 @@ again:
 		res->end = fail_res->end;
 		res->flags = fail_res->flags;
 		if (fail_res->dev->subordinate) {
-			res->flags = 0;
 			/* last or third times and later */
 			if (tried_times + 1 == pci_try_num ||
 			    tried_times + 1 > 2) {
@@ -2372,7 +2375,6 @@ again:
 		res->end = fail_res->end;
 		res->flags = fail_res->flags;
 		if (fail_res->dev->subordinate) {
-			res->flags = 0;
 			/* last time */
 			res->start = 0;
 			res->end = res->start - 1;
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 26aedde..2a5cddc 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -371,6 +371,17 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
 			continue;
 
 		if (r->flags & IORESOURCE_UNSET) {
+			/* bridge BAR could be disabled one by one */
+			if (dev->subordinate && i >= PCI_BRIDGE_RESOURCES &&
+						i <= PCI_BRIDGE_RESOURCE_END)
+				continue;
+
+#ifdef CONFIG_PCI_IOV
+			/* SRIOV ? */
+			if (i >= PCI_IOV_RESOURCES && i <= PCI_IOV_RESOURCE_END)
+				continue;
+#endif
+
 			dev_err(&dev->dev, "can't enable device: BAR %d %pR not assigned\n",
 				i, r);
 			return -EINVAL;
-- 
1.8.4.5

