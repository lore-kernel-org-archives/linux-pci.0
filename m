Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:29225 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756268AbbJAF7s (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2015 01:59:48 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v6 46/53] PCI: Check pref compatible bit for mem64 resource of PCIe device
Date: Wed, 30 Sep 2015 22:53:20 -0700
Message-Id: <1443678807-786-47-git-send-email-yinghai@kernel.org>
In-Reply-To: <1443678807-786-1-git-send-email-yinghai@kernel.org>
References: <1443678807-786-1-git-send-email-yinghai@kernel.org>
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
as we can not put non-pref mem under pref mem.

According to pcie spec errta
https://www.pcisig.com/specifications/pciexpress/base2/PCIe_Base_r2.1_Errata_08Jun10.pdf
page 13, in some case it is ok to mark some as pref.

Mark if the entire path from the host to the adapter is over PCI Express.
Then set pref compatible bit for claim/sizing/assign for 64bit mem resource
on that pcie device.

-v2: set pref for mmio 64 when whole path is PCI Express, according to David Miller.
-v3: don't set pref directly, change to UNDER_PREF, and set PREF before
     sizing and assign resource, and cleart PREF afterwards. requested by BenH.
-v4: use on_all_pcie_path device flag instead.

Fixes: commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows to fit in upstream windows")
Link: http://lkml.kernel.org/r/CAE9FiQU1gJY1LYrxs+ma5LCTEEe4xmtjRG0aXJ9K_Tsu+m9Wuw@mail.gmail.com
Reported-by: David Ahern <david.ahern@oracle.com>
Tested-by: David Ahern <david.ahern@oracle.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=81431
Tested-by: TJ <linux@iam.tj>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/pci.c       |  3 ++-
 drivers/pci/pci.h       |  2 ++
 drivers/pci/probe.c     | 33 +++++++++++++++++++++++++++++++++
 drivers/pci/setup-bus.c | 21 ++++++++++++++++++---
 drivers/pci/setup-res.c |  4 ++++
 include/linux/pci.h     |  1 +
 6 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6a9a111..f951cfb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -425,6 +425,7 @@ EXPORT_SYMBOL_GPL(pci_find_ht_capability);
 struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 					  struct resource *res)
 {
+	int flags = pci_resource_pref_compatible(dev, res);
 	const struct pci_bus *bus = dev->bus;
 	struct resource *r;
 	int i;
@@ -439,7 +440,7 @@ struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 			 * not, the allocator made a mistake.
 			 */
 			if (r->flags & IORESOURCE_PREFETCH &&
-			    !(res->flags & IORESOURCE_PREFETCH))
+			    !(flags & IORESOURCE_PREFETCH))
 				return NULL;
 
 			/*
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9dc42b6..c34c2aa 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -339,4 +339,6 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 
 struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
 
+int pci_resource_pref_compatible(const struct pci_dev *dev,
+				 struct resource *res);
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c8cc0e62..9eb9e30 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1628,6 +1628,36 @@ static void pci_set_msi_domain(struct pci_dev *dev)
 				   dev_get_msi_domain(&dev->bus->dev));
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
@@ -1658,6 +1688,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	/* Initialize various capabilities */
 	pci_init_capabilities(dev);
 
+	/* After pcie_cap is assigned */
+	pci_set_on_all_pcie_path(dev);
+
 	/*
 	 * Add the device to our list of discovered devices
 	 * and the bus list for fixup functions, etc.
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 173c83f..86900ac 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -978,6 +978,20 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
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
@@ -1490,10 +1504,11 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 			struct resource *r = &dev->resource[i];
 			resource_size_t r_size, align;
+			int flags = pci_resource_pref_compatible(dev, r);
 
-			if (r->parent || ((r->flags & mask) != type &&
-					  (r->flags & mask) != type2 &&
-					  (r->flags & mask) != type3))
+			if (r->parent || ((flags & mask) != type &&
+					  (flags & mask) != type2 &&
+					  (flags & mask) != type3))
 				continue;
 
 			r_size = resource_size(r);
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 232f925..b19aa5b 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -250,15 +250,19 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
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
index acb9c56..66969bb 100644
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

