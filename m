Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:35231 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757211AbcDHATN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 20:19:13 -0400
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
Subject: [PATCH v11 12/60] PCI: Check pref compatible bit for mem64 resource of PCIe device
Date: Thu,  7 Apr 2016 17:15:25 -0700
Message-Id: <1460074573-7481-13-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We still get "no compatible bridge window" warning on sparc T5-8
after we add support for 64bit resource parsing for root bus.

 PCI: scan_bus[/pci@300/pci@1/pci@0/pci@6] bus no 8
 PCI: Claiming 0000:00:01.0: Resource 15: 0000800100000000..00008004afffffff [220c]
 PCI: Claiming 0000:01:00.0: Resource 15: 0000800100000000..00008004afffffff [220c]
 PCI: Claiming 0000:02:04.0: Resource 15: 0000800100000000..000080012fffffff [220c]
 PCI: Claiming 0000:03:00.0: Resource 15: 0000800100000000..000080012fffffff [220c]
 PCI: Claiming 0000:04:06.0: Resource 14: 0000800100000000..000080010fffffff [220c]
 PCI: Claiming 0000:05:00.0: Resource 0: 0000800100000000..0000800100001fff [204]
 pci 0000:05:00.0: can't claim BAR 0 [mem 0x800100000000-0x800100001fff]: no compatible bridge window

All the bridges 64-bit resource have pref bit, but the device resource does not
have pref set, then we can not find parent for the device resource,
as we can not put non-pref mmio under pref mmio.

According to pcie spec errta
https://www.pcisig.com/specifications/pciexpress/base2/PCIe_Base_r2.1_Errata_08Jun10.pdf
page 13, in some case it is ok to mark some as pref.

Mark if the entire path from the host to the adapter is over PCI Express.
Set pref compatible bit for claim/sizing/assign for 64bit mem resource
on that pcie device.

-v2: set pref for mmio 64 when whole path is PCI Express, according to David Miller.
-v3: don't set pref directly, change to UNDER_PREF, and set PREF before
     sizing and assign resource, and cleart PREF afterwards. requested by BenH.
-v4: use on_all_pcie_path device flag instead.
-v6: update after pci_find_bus_resource() change

Fixes: commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows to fit in upstream windows")
Link: http://lkml.kernel.org/r/CAE9FiQU1gJY1LYrxs+ma5LCTEEe4xmtjRG0aXJ9K_Tsu+m9Wuw@mail.gmail.com
Reported-by: David Ahern <david.ahern@oracle.com>
Tested-by: David Ahern <david.ahern@oracle.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=81431
Tested-by: TJ <linux@iam.tj>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Tested-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 arch/sparc/kernel/pci.c        |  2 +-
 arch/sparc/kernel/pci_common.c |  2 +-
 drivers/pci/pci.c              |  8 +++++---
 drivers/pci/pci.h              |  2 ++
 drivers/pci/probe.c            | 33 +++++++++++++++++++++++++++++++++
 drivers/pci/setup-bus.c        | 23 +++++++++++++++++++----
 drivers/pci/setup-res.c        |  4 ++++
 include/linux/pci.h            |  3 ++-
 8 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 9415abc..e46e739 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -761,7 +761,7 @@ static int __pci_mmap_make_offset_bus(struct pci_dev *pdev, struct vm_area_struc
 	bus = pdev->bus;
 	while (bus->parent)
 		bus = bus->parent;
-	root_bus_res = pci_find_bus_resource(bus, &res);
+	root_bus_res = pci_find_bus_resource(bus, &res, res.flags);
 	if (!root_bus_res)
 		return -EINVAL;
 
diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
index 1ebc7ff..6f206a1 100644
--- a/arch/sparc/kernel/pci_common.c
+++ b/arch/sparc/kernel/pci_common.c
@@ -343,7 +343,7 @@ static void pci_register_region(struct pci_bus *bus, const char *name,
 	region.start = rstart;
 	region.end = rstart + size - 1UL;
 	pcibios_bus_to_resource(bus, res, &region);
-	bus_res = pci_find_bus_resource(bus, res);
+	bus_res = pci_find_bus_resource(bus, res, res->flags);
 	if (!bus_res) {
 		kfree(res);
 		return;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 313dea5..bd72df3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -415,7 +415,7 @@ int pci_find_ht_capability(struct pci_dev *dev, int ht_cap)
 EXPORT_SYMBOL_GPL(pci_find_ht_capability);
 
 struct resource *pci_find_bus_resource(const struct pci_bus *bus,
-					struct resource *res)
+					struct resource *res, int flags)
 {
 	struct resource *r;
 	int i;
@@ -430,7 +430,7 @@ struct resource *pci_find_bus_resource(const struct pci_bus *bus,
 			 * not, the allocator made a mistake.
 			 */
 			if (r->flags & IORESOURCE_PREFETCH &&
-			    !(res->flags & IORESOURCE_PREFETCH))
+			    !(flags & IORESOURCE_PREFETCH))
 				return NULL;
 
 			/*
@@ -458,7 +458,9 @@ struct resource *pci_find_bus_resource(const struct pci_bus *bus,
 struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 					  struct resource *res)
 {
-	return pci_find_bus_resource(dev->bus, res);
+	int flags = pci_resource_pref_compatible(dev, res);
+
+	return pci_find_bus_resource(dev->bus, res, flags);
 }
 EXPORT_SYMBOL(pci_find_parent_resource);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d0fb934..90e6e3e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -335,4 +335,6 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 }
 #endif
 
+int pci_resource_pref_compatible(const struct pci_dev *dev,
+				 struct resource *res);
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8004f67..48e6f29 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1731,6 +1731,36 @@ static void pci_dma_configure(struct pci_dev *dev)
 	pci_put_host_bridge_device(bridge);
 }
 
+static bool pci_up_path_over_pcie(struct pci_bus *bus)
+{
+	if (pci_is_root_bus(bus))
+		return true;
+
+	if (bus->self && !pci_is_pcie(bus->self))
+		return false;
+
+	return pci_up_path_over_pcie(bus->parent);
+}
+
+/*
+ * According to
+ * https://www.pcisig.com/specifications/pciexpress/base2/PCIe_Base_r2.1_Errata_08Jun10.pdf
+ * page 13, system firmware could put some 64bit non-pref under 64bit pref,
+ * on some cases.
+ * Let's mark if entire path from the host to the adapter is over PCI
+ * Express. later will use that compute pref compaitable bit.
+ */
+static void pci_set_on_all_pcie_path(struct pci_dev *dev)
+{
+	if (!pci_is_pcie(dev))
+		return;
+
+	if (!pci_up_path_over_pcie(dev->bus))
+		return;
+
+	dev->on_all_pcie_path = 1;
+}
+
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 {
 	int ret;
@@ -1761,6 +1791,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	/* Initialize various capabilities */
 	pci_init_capabilities(dev);
 
+	/* After pcie_cap is assigned */
+	pci_set_on_all_pcie_path(dev);
+
 	/*
 	 * Add the device to our list of discovered devices
 	 * and the bus list for fixup functions, etc.
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 55641a3..b3b1565 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -738,6 +738,20 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
 	return -EINVAL;
 }
 
+int pci_resource_pref_compatible(const struct pci_dev *dev,
+				 struct resource *res)
+{
+	if (res->flags & IORESOURCE_PREFETCH)
+		return res->flags;
+
+	if ((res->flags & IORESOURCE_MEM) &&
+	    (res->flags & IORESOURCE_MEM_64) &&
+	    dev->on_all_pcie_path)
+		return res->flags | IORESOURCE_PREFETCH;
+
+	return res->flags;
+}
+
 /* Check whether the bridge supports optional I/O and
    prefetchable memory ranges. If not, the respective
    base/limit registers must be read-only and read as 0. */
@@ -1035,11 +1049,12 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 			struct resource *r = &dev->resource[i];
 			resource_size_t r_size;
+			int flags = pci_resource_pref_compatible(dev, r);
 
-			if (r->parent || (r->flags & IORESOURCE_PCI_FIXED) ||
-			    ((r->flags & mask) != type &&
-			     (r->flags & mask) != type2 &&
-			     (r->flags & mask) != type3))
+			if (r->parent || (flags & IORESOURCE_PCI_FIXED) ||
+			    ((flags & mask) != type &&
+			     (flags & mask) != type2 &&
+			     (flags & mask) != type3))
 				continue;
 			r_size = resource_size(r);
 #ifdef CONFIG_PCI_IOV
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 66c4d8f..f741fed 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -257,15 +257,19 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 static int _pci_assign_resource(struct pci_dev *dev, int resno,
 				resource_size_t size, resource_size_t min_align)
 {
+	struct resource *res = dev->resource + resno;
+	int old_flags = res->flags;
 	struct pci_bus *bus;
 	int ret;
 
+	res->flags = pci_resource_pref_compatible(dev, res);
 	bus = dev->bus;
 	while ((ret = __pci_assign_resource(bus, dev, resno, size, min_align))) {
 		if (!bus->parent || !bus->self->transparent)
 			break;
 		bus = bus->parent;
 	}
+	res->flags = old_flags;
 
 	return ret;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 795b4c7..1527735 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -305,6 +305,7 @@ struct pci_dev {
 						   powered on/off by the
 						   corresponding bridge */
 	unsigned int	ignore_hotplug:1;	/* Ignore hotplug events */
+	unsigned int	on_all_pcie_path:1;	/* up to host-bridge all pcie */
 	unsigned int	d3_delay;	/* D3->D0 transition time in ms */
 	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
 
@@ -808,7 +809,7 @@ void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
 void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
 			     struct pci_bus_region *region);
 struct resource *pci_find_bus_resource(const struct pci_bus *bus,
-					struct resource *res);
+					struct resource *res, int flags);
 void pcibios_scan_specific_bus(int busn);
 struct pci_bus *pci_find_bus(int domain, int busnr);
 void pci_bus_add_devices(const struct pci_bus *bus);
-- 
1.8.4.5

