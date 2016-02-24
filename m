Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44163 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752247AbcBXToM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Feb 2016 14:44:12 -0500
Subject: [PATCH v4 3/6] PCI: Add support for multiple DMA aliases
To: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org
Date: Wed, 24 Feb 2016 13:44:06 -0600
Message-ID: <20160224194406.7585.17447.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>

<Insert changelog here>
---
 drivers/iommu/iommu.c |   17 ++++++++++-------
 drivers/pci/pci.c     |   11 +++++++++--
 drivers/pci/probe.c   |    1 +
 drivers/pci/search.c  |   14 +++++++++-----
 include/linux/pci.h   |    4 +---
 5 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0e3b009..a214e19 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -659,9 +659,15 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
 	return NULL;
 }
 
+static bool dma_alias_is_enabled(struct pci_dev *dev, u8 devfn)
+{
+	return dev->dma_alias_mask &&
+	       test_bit(devfn, dev->dma_alias_mask);
+}
+
 /*
- * Look for aliases to or from the given device for exisiting groups.  The
- * dma_alias_devfn only supports aliases on the same bus, therefore the search
+ * Look for aliases to or from the given device for existing groups. DMA
+ * aliases are only supported on the same bus, therefore the search
  * space is quite small (especially since we're really only looking at pcie
  * device, and therefore only expect multiple slots on the root complex or
  * downstream switch ports).  It's conceivable though that a pair of
@@ -686,11 +692,8 @@ static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
 			continue;
 
 		/* We alias them or they alias us */
-		if (((pdev->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
-		     pdev->dma_alias_devfn == tmp->devfn) ||
-		    ((tmp->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
-		     tmp->dma_alias_devfn == pdev->devfn)) {
-
+		if (dma_alias_is_enabled(pdev, tmp->devfn) ||
+		    dma_alias_is_enabled(tmp, pdev->devfn)) {
 			group = get_pci_alias_group(tmp, devfns);
 			if (group) {
 				pci_dev_put(tmp);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8b0a637..eb4dd49 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4578,8 +4578,15 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
  */
 void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
 {
-	dev->dma_alias_devfn = PCI_DEVFN(PCI_SLOT(dev->devfn), 0);
-	dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
+	if (!dev->dma_alias_mask)
+		dev->dma_alias_mask = kcalloc(BITS_TO_LONGS(U8_MAX),
+					      sizeof(long), GFP_KERNEL);
+	if (!dev->dma_alias_mask) {
+		dev_warn(&dev->dev, "Unable to allocate DMA alias mask\n");
+		return;
+	}
+
+	set_bit(devfn, dev->dma_alias_mask);
 	dev_info(&dev->dev, "Enabling fixed DMA alias to %02x.%d\n",
 		 PCI_SLOT(devfn), PCI_FUNC(devfn));
 }
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
index 27df4a6..d9e0c84 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -172,8 +172,6 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_ASSIGNED = (__force pci_dev_flags_t) (1 << 2),
 	/* Flag for quirk use to store if quirk-specific ACS is enabled */
 	PCI_DEV_FLAGS_ACS_ENABLED_QUIRK = (__force pci_dev_flags_t) (1 << 3),
-	/* Flag to indicate the device uses dma_alias_devfn */
-	PCI_DEV_FLAGS_DMA_ALIAS_DEVFN = (__force pci_dev_flags_t) (1 << 4),
 	/* Use a PCIe-to-PCI bridge alias even if !pci_is_pcie */
 	PCI_DEV_FLAG_PCIE_BRIDGE_ALIAS = (__force pci_dev_flags_t) (1 << 5),
 	/* Do not use bus resets for device */
@@ -279,7 +277,7 @@ struct pci_dev {
 	u8		rom_base_reg;	/* which config register controls the ROM */
 	u8		pin;		/* which interrupt pin this device uses */
 	u16		pcie_flags_reg;	/* cached PCIe Capabilities Register */
-	u8		dma_alias_devfn;/* devfn of DMA alias, if any */
+	unsigned long	*dma_alias_mask;/* mask of enabled devfn aliases */
 
 	struct pci_driver *driver;	/* which driver has allocated this device */
 	u64		dma_mask;	/* Mask of the bits of bus address this

