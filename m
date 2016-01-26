Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:54451 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933294AbcAZKcJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Jan 2016 05:32:09 -0500
From: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	dwmw2@infradead.org, jroedel@suse.de, jacek.lawrynowicz@intel.com
Subject: [PATCH v2 1/2] pci: Add support for multiple DMA aliases
Date: Tue, 26 Jan 2016 11:31:49 +0100
Message-Id: <1453804310-12946-1-git-send-email-jacek.lawrynowicz@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch solves IOMMU support issues with PCIe non-transparent bridges
that use Requester ID look-up tables (LUT), e.g. PEX8733. Before exiting
the bridge, packet's RID is rewritten according to LUT programmed by
a driver. Modified packets are then passed to a destination bus and
processed upstream. The problem is that such packets seem to come from
non-existent nodes that are hidden behind NTB and are not discoverable
by a destination node, so IOMMU discards them. Adding DMA alias for a
given LUT entry allows IOMMU to create a proper mapping that enables
inter-node communication.

The current DMA alias implementation supports only single alias, so it's
not possible to connect more than two nodes when IOMMU is enabled. This
implementation enables all possible aliases on a given bus (256) that
are stored in a bitset. Alias devfn is directly translated to a bit
number. The bitset is not allocated for devices that have no need for
DMA aliases.

More details can be found in following article:
http://www.plxtech.com/files/pdf/technical/expresslane/RTC_Enabling%20MulitHostSystemDesigns.pdf

Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
---
 drivers/iommu/iommu.c | 11 ++++-------
 drivers/pci/pci.c     | 28 ++++++++++++++++++++++++++++
 drivers/pci/pci.h     |  2 ++
 drivers/pci/probe.c   |  1 +
 drivers/pci/quirks.c  | 16 +++++++---------
 drivers/pci/search.c  | 14 +++++++++-----
 include/linux/pci.h   | 15 ++++++++-------
 7 files changed, 59 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0e3b009..93a89ed 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -660,8 +660,8 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
 }
 
 /*
- * Look for aliases to or from the given device for exisiting groups.  The
- * dma_alias_devfn only supports aliases on the same bus, therefore the search
+ * Look for aliases to or from the given device for exisiting groups. DMA
+ * aliases are only supported on the same bus, therefore the search
  * space is quite small (especially since we're really only looking at pcie
  * device, and therefore only expect multiple slots on the root complex or
  * downstream switch ports).  It's conceivable though that a pair of
@@ -686,11 +686,8 @@ static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
 			continue;
 
 		/* We alias them or they alias us */
-		if (((pdev->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
-		     pdev->dma_alias_devfn == tmp->devfn) ||
-		    ((tmp->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
-		     tmp->dma_alias_devfn == pdev->devfn)) {
-
+		if (pci_dma_alias_is_enabled(pdev, tmp->devfn) ||
+		    pci_dma_alias_is_enabled(tmp, pdev->devfn)) {
 			group = get_pci_alias_group(tmp, devfns);
 			if (group) {
 				pci_dev_put(tmp);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 602eb42..f114068 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4568,6 +4568,34 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
 	return 0;
 }
 
+/**
+ * pci_enable_dma_alias - Allows to set multiple devfn aliases for given device
+ * @dev: the PCI device for which alias is added
+ * @devfn: alias slot and function
+ *
+ * This helper encodes 8-bit devfn as bit number in dma_alias_mask.
+ * It should be called early, preferably as PCI fixup header quirk.
+ */
+void pci_enable_dma_alias(struct pci_dev *dev, u8 devfn)
+{
+	if (!dev->dma_alias_mask)
+		dev->dma_alias_mask = kcalloc(BITS_TO_LONGS(U8_MAX),
+					      sizeof(long), GFP_KERNEL);
+	if (!dev->dma_alias_mask) {
+		dev_warn(&dev->dev, "Unable to allocate DMA alias mask.\n");
+		return;
+	}
+	if (dev->dma_alias_mask)
+		set_bit(devfn, dev->dma_alias_mask);
+}
+
+bool pci_dma_alias_is_enabled(struct pci_dev *dev, u8 devfn)
+{
+	return dev->dma_alias_mask &&
+	       test_bit(devfn, dev->dma_alias_mask);
+}
+EXPORT_SYMBOL_GPL(pci_dma_alias_is_enabled);
+
 bool pci_device_is_present(struct pci_dev *pdev)
 {
 	u32 v;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9a1660f..c31c1a5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -335,4 +335,6 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 }
 #endif
 
+void pci_enable_dma_alias(struct pci_dev *dev, u8 devfn);
+
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6d7ab9b..23fc397 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1503,6 +1503,7 @@ static void pci_release_dev(struct device *dev)
 	pcibios_release_device(pci_dev);
 	pci_bus_put(pci_dev->bus);
 	kfree(pci_dev->driver_override);
+	kfree(pci_dev->dma_alias_mask);
 	kfree(pci_dev);
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0575a1e..b094061 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -25,6 +25,7 @@
 #include <linux/sched.h>
 #include <linux/ktime.h>
 #include <linux/mm.h>
+#include <linux/iommu.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
 
@@ -3582,8 +3583,7 @@ int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 static void quirk_dma_func0_alias(struct pci_dev *dev)
 {
 	if (PCI_FUNC(dev->devfn) != 0) {
-		dev->dma_alias_devfn = PCI_DEVFN(PCI_SLOT(dev->devfn), 0);
-		dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
+		pci_enable_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
 	}
 }
 
@@ -3598,8 +3598,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe476, quirk_dma_func0_alias);
 static void quirk_dma_func1_alias(struct pci_dev *dev)
 {
 	if (PCI_FUNC(dev->devfn) != 1) {
-		dev->dma_alias_devfn = PCI_DEVFN(PCI_SLOT(dev->devfn), 1);
-		dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
+		pci_enable_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 1));
 	}
 }
 
@@ -3667,11 +3666,10 @@ static void quirk_fixed_dma_alias(struct pci_dev *dev)
 
 	id = pci_match_id(fixed_dma_alias_tbl, dev);
 	if (id) {
-		dev->dma_alias_devfn = id->driver_data;
-		dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
-		dev_info(&dev->dev, "Enabling fixed DMA alias to %02x.%d\n",
-			 PCI_SLOT(dev->dma_alias_devfn),
-			 PCI_FUNC(dev->dma_alias_devfn));
+		pci_enable_dma_alias(dev, id->driver_data);
+		dev_info(&dev->dev, "Enabling fixed DMA alias to %02lx.%ld\n",
+			 PCI_SLOT(id->driver_data),
+			 PCI_FUNC(id->driver_data));
 	}
 }
 
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index a20ce7d..33e0f03 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -40,11 +40,15 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 	 * If the device is broken and uses an alias requester ID for
 	 * DMA, iterate over that too.
 	 */
-	if (unlikely(pdev->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN)) {
-		ret = fn(pdev, PCI_DEVID(pdev->bus->number,
-					 pdev->dma_alias_devfn), data);
-		if (ret)
-			return ret;
+	if (unlikely(pdev->dma_alias_mask)) {
+		u8 devfn;
+
+		for_each_set_bit(devfn, pdev->dma_alias_mask, U8_MAX) {
+			ret = fn(pdev, PCI_DEVID(pdev->bus->number, devfn),
+				 data);
+			if (ret)
+				return ret;
+		}
 	}
 
 	for (bus = pdev->bus; !pci_is_root_bus(bus); bus = bus->parent) {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 27df4a6..6c9e9e6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -172,16 +172,14 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_ASSIGNED = (__force pci_dev_flags_t) (1 << 2),
 	/* Flag for quirk use to store if quirk-specific ACS is enabled */
 	PCI_DEV_FLAGS_ACS_ENABLED_QUIRK = (__force pci_dev_flags_t) (1 << 3),
-	/* Flag to indicate the device uses dma_alias_devfn */
-	PCI_DEV_FLAGS_DMA_ALIAS_DEVFN = (__force pci_dev_flags_t) (1 << 4),
 	/* Use a PCIe-to-PCI bridge alias even if !pci_is_pcie */
-	PCI_DEV_FLAG_PCIE_BRIDGE_ALIAS = (__force pci_dev_flags_t) (1 << 5),
+	PCI_DEV_FLAG_PCIE_BRIDGE_ALIAS = (__force pci_dev_flags_t) (1 << 4),
 	/* Do not use bus resets for device */
-	PCI_DEV_FLAGS_NO_BUS_RESET = (__force pci_dev_flags_t) (1 << 6),
+	PCI_DEV_FLAGS_NO_BUS_RESET = (__force pci_dev_flags_t) (1 << 5),
 	/* Do not use PM reset even if device advertises NoSoftRst- */
-	PCI_DEV_FLAGS_NO_PM_RESET = (__force pci_dev_flags_t) (1 << 7),
+	PCI_DEV_FLAGS_NO_PM_RESET = (__force pci_dev_flags_t) (1 << 6),
 	/* Get VPD from function 0 VPD */
-	PCI_DEV_FLAGS_VPD_REF_F0 = (__force pci_dev_flags_t) (1 << 8),
+	PCI_DEV_FLAGS_VPD_REF_F0 = (__force pci_dev_flags_t) (1 << 7),
 };
 
 enum pci_irq_reroute_variant {
@@ -279,7 +277,7 @@ struct pci_dev {
 	u8		rom_base_reg;	/* which config register controls the ROM */
 	u8		pin;		/* which interrupt pin this device uses */
 	u16		pcie_flags_reg;	/* cached PCIe Capabilities Register */
-	u8		dma_alias_devfn;/* devfn of DMA alias, if any */
+	unsigned long	*dma_alias_mask;/* mask of enabled devfn aliases */
 
 	struct pci_driver *driver;	/* which driver has allocated this device */
 	u64		dma_mask;	/* Mask of the bits of bus address this
@@ -1238,6 +1236,7 @@ resource_size_t pcibios_iov_resource_alignment(struct pci_dev *dev, int resno);
 
 int pci_set_vga_state(struct pci_dev *pdev, bool decode,
 		      unsigned int command_bits, u32 flags);
+
 /* kmem_cache style wrapper around pci_alloc_consistent() */
 
 #include <linux/pci-dma.h>
@@ -1965,6 +1964,8 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 			   int (*fn)(struct pci_dev *pdev,
 				     u16 alias, void *data), void *data);
 
+bool pci_dma_alias_is_enabled(struct pci_dev *dev, u8 devfn);
+
 /* helper functions for operation of device flag */
 static inline void pci_set_dev_assigned(struct pci_dev *pdev)
 {
-- 
2.1.4

