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
Subject: [PATCH v10 11/59] PCI: Check pref compatible bit for mem64 resource of PCIe device
Date: Wed, 24 Feb 2016 18:12:02 -0800
Message-Id: <1456366370-28995-12-git-send-email-yinghai@kernel.org>
In-Reply-To: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
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
Then set pref compatible bit for claim/sizing/assign for 64bit mem resource
on that pcie device.

Fixes: commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows to fit in upstream windows")
Link: http://lkml.kernel.org/r/CAE9FiQU1gJY1LYrxs+ma5LCTEEe4xmtjRG0aXJ9K_Tsu+m9Wuw@mail.gmail.com
Reported-by: David Ahern <david.ahern@oracle.com>
Tested-by: David Ahern <david.ahern@oracle.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=81431
Tested-by: TJ <linux@iam.tj>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Tested-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 drivers/pci/pci.c       | 10 ++++++----
 drivers/pci/pci.h       |  2 ++
 drivers/pci/probe.c     | 33 +++++++++++++++++++++++++++++++++
 drivers/pci/setup-bus.c | 23 +++++++++++++++++++----
 drivers/pci/setup-res.c |  4 ++++
 include/linux/pci.h     |  1 +
 6 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index db4025f..d1a74e5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -416,7 +416,7 @@ int pci_find_ht_capability(struct pci_dev *dev, int ht_cap)
 EXPORT_SYMBOL_GPL(pci_find_ht_capability);
 
 static struct resource *pci_find_bus_resource(const struct pci_bus *bus,
-					      struct resource *res)
+					      struct resource *res, int flags)
 {
 	struct resource *r;
 	int i;
@@ -431,7 +431,7 @@ static struct resource *pci_find_bus_resource(const struct pci_bus *bus,
 			 * not, the allocator made a mistake.
 			 */
 			if (r->flags & IORESOURCE_PREFETCH &&
-			    !(res->flags & IORESOURCE_PREFETCH))
+			    !(flags & IORESOURCE_PREFETCH))
 				return NULL;
 
 			/*
@@ -459,7 +459,9 @@ static struct resource *pci_find_bus_resource(const struct pci_bus *bus,
 struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 					  struct resource *res)
 {
-	return pci_find_bus_resource(dev->bus, res);
+	int flags = pci_resource_pref_compatible(dev, res);
+
+	return pci_find_bus_resource(dev->bus, res, flags);
 }
 EXPORT_SYMBOL(pci_find_parent_resource);
 
@@ -469,7 +471,7 @@ struct resource *pci_find_root_bus_resource(struct pci_bus *bus,
 	while (bus->parent)
 		bus = bus->parent;
 
-	return pci_find_bus_resource(bus, res);
+	return pci_find_bus_resource(bus, res, res->flags);
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9a1660f..220bd0e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -335,4 +335,6 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 }
 #endif
 
+int pci_resource_pref_compatible(const struct pci_dev *dev,
+				 struct resource *res);
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6d7ab9b..2c3e264 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1697,6 +1697,36 @@ static void pci_dma_configure(struct pci_dev *dev)
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
@@ -1727,6 +1757,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	/* Initialize various capabilities */
 	pci_init_capabilities(dev);
 
+	/* After pcie_cap is assigned */
+	pci_set_on_all_pcie_path(dev);
+
 	/*
 	 * Add the device to our list of discovered devices
 	 * and the bus list for fixup functions, etc.
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7796d0a..17f10b3 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -739,6 +739,20 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
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
@@ -1036,11 +1050,12 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
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
index 604011e..d5b3970 100644
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
index dd603a668..ca8d70a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -311,6 +311,7 @@ struct pci_dev {
 						   powered on/off by the
 						   corresponding bridge */
 	unsigned int	ignore_hotplug:1;	/* Ignore hotplug events */
+	unsigned int	on_all_pcie_path:1;	/* up to host-bridge all pcie */
 	unsigned int	d3_delay;	/* D3->D0 transition time in ms */
 	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
 
-- 
1.8.4.5
