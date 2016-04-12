Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35020 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbcDLEid (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Apr 2016 00:38:33 -0400
Date: Mon, 11 Apr 2016 23:38:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>,
	linux-pci@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org
Subject: Re: [PATCH v4 0/6] PCI: Support multiple DMA aliases
Message-ID: <20160412043828.GA11361@localhost>
References: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 24, 2016 at 01:43:32PM -0600, Bjorn Helgaas wrote:
> This is a revision of Jacek's v3 posting:
> http://lkml.kernel.org/r/1454152012-46337-1-git-send-email-jacek.lawrynowicz@intel.com
> 
> The changes from v3 are:
> 
>   - Split into smaller patches for reviewability
>   - Move printk when adding DMA alias
>   - Change dma_alias_is_enabled() interface to take two pci_devs
>   - Rename dma_alias_is_enabled() to indicate PCI context
> 
> The only remaining thing I want to sort out is the dma_alias_is_enabled()
> vs pci_for_each_dma_alias() question Alex raised.  I'll respond to the
> relevant part of the patch in this series with my specific questions.
> 
> ---
> 
> Bjorn Helgaas (1):
>       PCI: Rename dma_alias_is_enabled() to pci_devs_are_dma_aliases()
> 
> Jacek Lawrynowicz (5):
>       PCI: Add pci_add_dma_alias() to abstract implementation
>       PCI: Move informational printk to pci_add_dma_alias()
>       PCI: Add support for multiple DMA aliases
>       pci: Add DMA alias quirk for mic_x200_dma
>       PCI: Squash pci_dev_flags to remove holes

I applied this series to pci/ntb for v4.7.  It got a little confusing
with v5 versions of a couple patches posted, and a couple issues Alex
found, so here's the series as applied:

commit f0af9593372abfde34460aa1250e670cc535a7d8
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed Feb 24 13:43:45 2016 -0600

    PCI: Add pci_add_dma_alias() to abstract implementation
    
    Add a pci_add_dma_alias() interface to encapsulate the details of adding an
    alias.  No functional change intended.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 25e0327..1162118 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4578,6 +4578,20 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
 	return 0;
 }
 
+/**
+ * pci_add_dma_alias - Add a DMA devfn alias for a device
+ * @dev: the PCI device for which alias is added
+ * @devfn: alias slot and function
+ *
+ * This helper encodes 8-bit devfn as bit number in dma_alias_mask.
+ * It should be called early, preferably as PCI fixup header quirk.
+ */
+void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
+{
+	dev->dma_alias_devfn = devfn;
+	dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
+}
+
 bool pci_device_is_present(struct pci_dev *pdev)
 {
 	u32 v;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8e67802..e45a7a8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3610,10 +3610,8 @@ int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 
 static void quirk_dma_func0_alias(struct pci_dev *dev)
 {
-	if (PCI_FUNC(dev->devfn) != 0) {
-		dev->dma_alias_devfn = PCI_DEVFN(PCI_SLOT(dev->devfn), 0);
-		dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
-	}
+	if (PCI_FUNC(dev->devfn) != 0)
+		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
 }
 
 /*
@@ -3626,10 +3624,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe476, quirk_dma_func0_alias);
 
 static void quirk_dma_func1_alias(struct pci_dev *dev)
 {
-	if (PCI_FUNC(dev->devfn) != 1) {
-		dev->dma_alias_devfn = PCI_DEVFN(PCI_SLOT(dev->devfn), 1);
-		dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
-	}
+	if (PCI_FUNC(dev->devfn) != 1)
+		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 1));
 }
 
 /*
@@ -3696,11 +3692,10 @@ static void quirk_fixed_dma_alias(struct pci_dev *dev)
 
 	id = pci_match_id(fixed_dma_alias_tbl, dev);
 	if (id) {
-		dev->dma_alias_devfn = id->driver_data;
-		dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
+		pci_add_dma_alias(dev, id->driver_data);
 		dev_info(&dev->dev, "Enabling fixed DMA alias to %02x.%d\n",
-			 PCI_SLOT(dev->dma_alias_devfn),
-			 PCI_FUNC(dev->dma_alias_devfn));
+			 PCI_SLOT(id->driver_data),
+			 PCI_FUNC(id->driver_data));
 	}
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 004b813..7e70190 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1988,6 +1988,7 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
 }
 #endif
 
+void pci_add_dma_alias(struct pci_dev *dev, u8 devfn);
 int pci_for_each_dma_alias(struct pci_dev *pdev,
 			   int (*fn)(struct pci_dev *pdev,
 				     u16 alias, void *data), void *data);

commit 48c830809ce6e143781172c03a9794cb66802b31
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed Feb 24 13:43:54 2016 -0600

    PCI: Move informational printk to pci_add_dma_alias()
    
    One of the quirks that adds DMA aliases logs an informational message in
    dmesg.  Move that to pci_add_dma_alias() so all users log the message
    consistently.  No functional change intended (except extra message).
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1162118..c82ebd0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4590,6 +4590,8 @@ void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
 {
 	dev->dma_alias_devfn = devfn;
 	dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
+	dev_info(&dev->dev, "Enabling fixed DMA alias to %02x.%d\n",
+		 PCI_SLOT(devfn), PCI_FUNC(devfn));
 }
 
 bool pci_device_is_present(struct pci_dev *pdev)
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e45a7a8..7559e40 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3691,12 +3691,8 @@ static void quirk_fixed_dma_alias(struct pci_dev *dev)
 	const struct pci_device_id *id;
 
 	id = pci_match_id(fixed_dma_alias_tbl, dev);
-	if (id) {
+	if (id)
 		pci_add_dma_alias(dev, id->driver_data);
-		dev_info(&dev->dev, "Enabling fixed DMA alias to %02x.%d\n",
-			 PCI_SLOT(id->driver_data),
-			 PCI_FUNC(id->driver_data));
-	}
 }
 
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ADAPTEC2, 0x0285, quirk_fixed_dma_alias);

commit 338c3149a221527e202ee26b1e35f76c965bb6c0
Author: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
Date:   Thu Mar 3 15:38:02 2016 +0100

    PCI: Add support for multiple DMA aliases
    
    Solve IOMMU support issues with PCIe non-transparent bridges that use
    Requester ID look-up tables (RID-LUT), e.g., the PEX8733.
    
    The NTB connects devices in two independent PCI domains.  Devices separated
    by the NTB are not able to discover each other.  A PCI packet being
    forwared from one domain to another has to have its RID modified so it
    appears on correct bus and completions are forwarded back to the original
    domain through the NTB.  The RID is translated using a preprogrammed table
    (LUT) and the PCI packet propagates upstream away from the NTB.  If the
    destination system has IOMMU enabled, the packet will be discarded because
    the new RID is unknown to the IOMMU.  Adding a DMA alias for the new RID
    allows IOMMU to properly recognize the packet.
    
    Each device behind the NTB has a unique RID assigned in the RID-LUT.  The
    current DMA alias implementation supports only a single alias, so it's not
    possible to support mutiple devices behind the NTB when IOMMU is enabled.
    
    Enable all possible aliases on a given bus (256) that are stored in a
    bitset.  Alias devfn is directly translated to a bit number.  The bitset is
    not allocated for devices that have no need for DMA aliases.
    
    More details can be found in the following article:
    http://www.plxtech.com/files/pdf/technical/expresslane/RTC_Enabling%20MulitHostSystemDesigns.pdf
    
    Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
    Acked-by: David Woodhouse <David.Woodhouse@intel.com>
    Acked-by: Joerg Roedel <jroedel@suse.de>

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index bfd4f7c..1b49e94 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -660,8 +660,8 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
 }
 
 /*
- * Look for aliases to or from the given device for exisiting groups.  The
- * dma_alias_devfn only supports aliases on the same bus, therefore the search
+ * Look for aliases to or from the given device for existing groups. DMA
+ * aliases are only supported on the same bus, therefore the search
  * space is quite small (especially since we're really only looking at pcie
  * device, and therefore only expect multiple slots on the root complex or
  * downstream switch ports).  It's conceivable though that a pair of
@@ -686,11 +686,7 @@ static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
 			continue;
 
 		/* We alias them or they alias us */
-		if (((pdev->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
-		     pdev->dma_alias_devfn == tmp->devfn) ||
-		    ((tmp->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
-		     tmp->dma_alias_devfn == pdev->devfn)) {
-
+		if (pci_devs_are_dma_aliases(pdev, tmp)) {
 			group = get_pci_alias_group(tmp, devfns);
 			if (group) {
 				pci_dev_put(tmp);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c82ebd0..0b90c21 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4588,12 +4588,27 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
  */
 void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
 {
-	dev->dma_alias_devfn = devfn;
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
 
+bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2)
+{
+	return (dev1->dma_alias_mask &&
+		test_bit(dev2->devfn, dev1->dma_alias_mask)) ||
+	       (dev2->dma_alias_mask &&
+		test_bit(dev1->devfn, dev2->dma_alias_mask));
+}
+
 bool pci_device_is_present(struct pci_dev *pdev)
 {
 	u32 v;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8004f67..ae7daeb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1537,6 +1537,7 @@ static void pci_release_dev(struct device *dev)
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
index 7e70190..5581d05 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -166,8 +166,6 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_ASSIGNED = (__force pci_dev_flags_t) (1 << 2),
 	/* Flag for quirk use to store if quirk-specific ACS is enabled */
 	PCI_DEV_FLAGS_ACS_ENABLED_QUIRK = (__force pci_dev_flags_t) (1 << 3),
-	/* Flag to indicate the device uses dma_alias_devfn */
-	PCI_DEV_FLAGS_DMA_ALIAS_DEVFN = (__force pci_dev_flags_t) (1 << 4),
 	/* Use a PCIe-to-PCI bridge alias even if !pci_is_pcie */
 	PCI_DEV_FLAG_PCIE_BRIDGE_ALIAS = (__force pci_dev_flags_t) (1 << 5),
 	/* Do not use bus resets for device */
@@ -273,7 +271,7 @@ struct pci_dev {
 	u8		rom_base_reg;	/* which config register controls the ROM */
 	u8		pin;		/* which interrupt pin this device uses */
 	u16		pcie_flags_reg;	/* cached PCIe Capabilities Register */
-	u8		dma_alias_devfn;/* devfn of DMA alias, if any */
+	unsigned long	*dma_alias_mask;/* mask of enabled devfn aliases */
 
 	struct pci_driver *driver;	/* which driver has allocated this device */
 	u64		dma_mask;	/* Mask of the bits of bus address this
@@ -1989,6 +1987,7 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
 #endif
 
 void pci_add_dma_alias(struct pci_dev *dev, u8 devfn);
+bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2);
 int pci_for_each_dma_alias(struct pci_dev *pdev,
 			   int (*fn)(struct pci_dev *pdev,
 				     u16 alias, void *data), void *data);

commit 8e6b62b5dc00bee0bd1f6fada928969159b8083a
Author: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
Date:   Thu Mar 3 15:53:20 2016 +0100

    PCI: Add DMA alias quirk for mic_x200_dma
    
    The MIC x200 NTB forwards DMA transactions upstream using multiple alien
    RIDs.  These RIDs have to be added as aliases to the DMA device to allow
    buffer access when the IOMMU is enabled.
    
    Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
    Acked-by: David Woodhouse <David.Woodhouse@intel.com>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7559e40..5cccc78 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3725,6 +3725,20 @@ DECLARE_PCI_FIXUP_HEADER(0x1283, 0x8892, quirk_use_pcie_bridge_dma_alias);
 DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, quirk_use_pcie_bridge_dma_alias);
 
 /*
+ * MIC x200 NTB forwards PCIe traffic using multiple alien RIDs. They have to
+ * be added as aliases to the DMA device in order to allow buffer access
+ * when IOMMU is enabled. Following devfns have to match RIT-LUT table
+ * programmed in the EEPROM.
+ */
+static void quirk_mic_x200_dma_alias(struct pci_dev *pdev)
+{
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x10, 0x0));
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x11, 0x0));
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x12, 0x3));
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2264, quirk_mic_x200_dma_alias);
+
+/*
  * Intersil/Techwell TW686[4589]-based video capture cards have an empty (zero)
  * class code.  Fix it.
  */
