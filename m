Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:22281 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753579AbaATNOB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jan 2014 08:14:01 -0500
Date: 20 Jan 2014 08:13:59 -0500
Message-ID: <20140120131359.26728.qmail@science.horizon.com>
From: "George Spelvin" <linux@horizon.com>
To: acooks@gmail.com, linux-ide@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH] Quirk for buggy dma source tags with Intel IOMMU.
Cc: linux@horizon.com
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is requried for me to get a Marvell 9172 SATA controller working
with VT-d.

Andrew Cooks wrote the original; see
https://bugzilla.kernel.org/show_bug.cgi?id=42679#c22

Without it, I see the same symptoms as in that bug report:
the device is recognized, but probing the attached disk fails.

I massaged it a bit to fit my personal idea of "cleaner".
The biggest logic change is the elimination of the fn_mapped
variable from quirk_map_multi_requester_ids.

I also got rid of the "fn_map << fn" logic (which is never false).

I can vouch for quirk_map_multi_requester_ids working in my case;
I can't speak for quirk_map_requester_id.

Who do I nudge about actually getting some variant of this merged?

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 43b9bfea48..4695865051 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1677,6 +1677,111 @@ static int domain_context_mapping_one(struct dmar_domain *domain, int segment,
 	return 0;
 }
 
+static void iommu_detach_dev(struct intel_iommu *iommu, u8 bus, u8 devfn);
+
+static void quirk_unmap_multi_requesters(struct pci_dev *pdev, u8 fn_map)
+{
+	int fn;
+	struct intel_iommu *iommu = device_to_iommu(pci_domain_nr(pdev->bus),
+						pdev->bus->number, pdev->devfn);
+
+	/* something must be seriously wrong if we can't lookup the iommu. */
+	BUG_ON(!iommu);
+
+	fn_map &= ~(1<<PCI_FUNC(pdev->devfn));	/* Skip the normal case */
+
+	for (fn = 0; fn_map >> fn; fn++) {
+		if (fn_map & (1<<fn)) {
+			iommu_detach_dev(iommu,
+					pdev->bus->number,
+					PCI_DEVFN(PCI_SLOT(pdev->devfn), fn));
+			dev_dbg(&pdev->dev,
+				"requester id quirk; ghost func %d unmapped",
+				fn);
+		}
+	}
+}
+
+/* For quirky devices that use multiple requester ids. */
+static int quirk_map_multi_requester_ids(struct dmar_domain *domain,
+		struct pci_dev *pdev,
+		int translation)
+{
+	int fn, err = 0;
+	u8 fn_map = pci_multi_requesters(pdev);
+
+	/* this is the common, non-quirky case. */
+	if (!fn_map)
+		return 0;
+
+	fn_map &= ~(1<<PCI_FUNC(pdev->devfn));	/* Skip the normal case */
+
+	for (fn = 0; fn_map >> fn; fn++) {
+		if (fn_map & (1<<fn)) {
+			err = domain_context_mapping_one(domain,
+					pci_domain_nr(pdev->bus),
+					pdev->bus->number,
+					PCI_DEVFN(PCI_SLOT(pdev->devfn), fn),
+					translation);
+			if (err) {
+				dev_err(&pdev->dev,
+					"mapping ghost func %d failed", fn);
+				quirk_unmap_multi_requesters(pdev,
+					fn_map & ((1<<fn)-1));
+				return err;
+			}
+			dev_dbg(&pdev->dev,
+				"requester id quirk; ghost func %d mapped", fn);
+		}
+	}
+	return 0;
+}
+
+
+static void quirk_unmap_requester_id(struct pci_dev *pdev)
+{
+	u8 devfn = pci_requester(pdev);
+	struct intel_iommu *iommu = device_to_iommu(pci_domain_nr(pdev->bus),
+						pdev->bus->number, pdev->devfn);
+
+	/* something must be seriously wrong if we can't lookup the iommu. */
+	BUG_ON(!iommu);
+
+
+	if (pdev->devfn == devfn)
+		return;
+
+	iommu_detach_dev(iommu,	pdev->bus->number, devfn);
+	dev_dbg(&pdev->dev, "requester id quirk; bugged device unmapped");
+}
+
+static int quirk_map_requester_id(struct dmar_domain *domain,
+		struct pci_dev *pdev,
+		int translation)
+{
+	u8 devfn = pci_requester(pdev);
+	int err;
+
+	dev_dbg(&pdev->dev,
+		"checking for incorrect pci requester id quirk...");
+
+	if (pdev->devfn == devfn)
+		return 0;
+
+	err = domain_context_mapping_one(domain, pci_domain_nr(pdev->bus),
+			pdev->bus->number, devfn, translation);
+	if (err) {
+		dev_err(&pdev->dev,
+			"requester id quirk: mapping dev %02x:%02x.%d failed",
+			pdev->bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn));
+		return err;
+	}
+	dev_dbg(&pdev->dev,
+		"requester id quirk; dmar context entry added: %02x:%02x.%d",
+		pdev->bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn));
+	return 0;
+}
+
 static int
 domain_context_mapping(struct dmar_domain *domain, struct pci_dev *pdev,
 			int translation)
@@ -1690,6 +1795,16 @@ domain_context_mapping(struct dmar_domain *domain, struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
+	/* quirk for devices using multiple pci requester ids */
+	ret = quirk_map_multi_requester_ids(domain, pdev, translation);
+	if (ret)
+		return ret;
+
+	/* quirk for devices single incorrect pci requester id */
+	ret = quirk_map_requester_id(domain, pdev, translation);
+	if (ret)
+		return ret;
+
 	/* dependent device mapping */
 	tmp = pci_find_upstream_pcie_bridge(pdev);
 	if (!tmp)
@@ -3802,6 +3917,9 @@ static void domain_remove_one_dev_info(struct dmar_domain *domain,
 			iommu_disable_dev_iotlb(info);
 			iommu_detach_dev(iommu, info->bus, info->devfn);
 			iommu_detach_dependent_devices(iommu, pdev);
+			quirk_unmap_multi_requesters(pdev,
+						pci_multi_requesters(pdev));
+			quirk_unmap_requester_id(pdev);
 			free_devinfo_mem(info);
 
 			spin_lock_irqsave(&device_domain_lock, flags);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 3a02717473..500edde3d3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3336,6 +3336,10 @@ static struct pci_dev *pci_func_0_dma_source(struct pci_dev *dev)
 	return pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
 }
 
+/* Table of source functions for real devices. The DMA requests for the
+ * device are tagged with a different real function as source. This is
+ * relevant to multifunction devices.
+ */
 static const struct pci_dev_dma_source {
 	u16 vendor;
 	u16 device;
@@ -3362,7 +3366,8 @@ static const struct pci_dev_dma_source {
  * the device doing the DMA, but sometimes hardware is broken and will
  * tag the DMA as being sourced from a different device.  This function
  * allows that translation.  Note that the reference count of the
- * returned device is incremented on all paths.
+ * returned device is incremented on all paths. Translation is done when
+ * the device is added to an IOMMU group.
  */
 struct pci_dev *pci_get_dma_source(struct pci_dev *dev)
 {
@@ -3423,6 +3428,144 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
 #endif
 }
 
+/* Table of multiple (ghost) source functions. Devices that may need this quirk
+ * show the following behaviour:
+ * 1. the device may use multiple PCI requester IDs during operation,
+ *     (eg. one pci transaction uses xx:yy.0, the next uses xx:yy.1)
+ * 2. the requester ID may not match a known device.
+ *     (eg. lspci does not show xx:yy.1 to be present)
+ *
+ * The bitmap contains all of the functions "in use" by the device.
+ * See  https://bugzilla.redhat.com/show_bug.cgi?id=757166,
+ * https://bugzilla.kernel.org/show_bug.cgi?id=42679
+ * https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1089768
+ */
+static const struct pci_dev_dma_multi_source_map {
+	u16 vendor;
+	u16 device;
+	u8 func_map;	/* bit map. lsb is fn 0. */
+} pci_dev_dma_multi_source_map[] = {
+	 /* Reported by Patrick Bregman
+	  * https://bugzilla.redhat.com/show_bug.cgi?id=863653 */
+	{ PCI_VENDOR_ID_MARVELL_EXT, 0x9120, (1<<0)|(1<<1)},
+
+	/* Reported by  Paweł Żak, Korneliusz Jarzębski, Daniel Mayer
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=42679 and by
+	 * Justin Piszcz  https://lkml.org/lkml/2012/11/24/94 */
+	{ PCI_VENDOR_ID_MARVELL_EXT, 0x9123, (1<<0)|(1<<1)},
+
+	/* Used in a patch by Ying Chu
+	 * https://bugzilla.redhat.com/show_bug.cgi?id=757166 */
+	{ PCI_VENDOR_ID_MARVELL_EXT, 0x9125, (1<<0)|(1<<1)},
+
+	/* Reported by Robert Cicconetti
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=42679 and by
+	 * Fernando https://bugzilla.redhat.com/show_bug.cgi?id=757166 */
+	{ PCI_VENDOR_ID_MARVELL_EXT, 0x9128, (1<<0)|(1<<1)},
+
+	/* Reported by Stijn Tintel
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=42679 */
+	{ PCI_VENDOR_ID_MARVELL_EXT, 0x9130, (1<<0)|(1<<1)},
+
+	/* Reported by Gaudenz Steinlin
+	 * https://lkml.org/lkml/2013/3/5/288 */
+	{ PCI_VENDOR_ID_MARVELL_EXT, 0x9143, (1<<0)|(1<<1)},
+
+	/* Reported by Andrew Cooks
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=42679 */
+	{ PCI_VENDOR_ID_MARVELL_EXT, 0x9172, (1<<0)|(1<<1)},
+
+	{ 0 }
+};
+
+/*
+ * The mapping of quirky requester ids is used when the device driver sets up
+ * dma, if iommu is enabled.
+ */
+u8 pci_multi_requesters(struct pci_dev *dev)
+{
+	const struct pci_dev_dma_multi_source_map *i;
+
+	for (i = pci_dev_dma_multi_source_map; i->func_map; i++) {
+		if ((i->vendor == dev->vendor ||
+		     i->vendor == (u16)PCI_ANY_ID) &&
+		    (i->device == dev->device ||
+		     i->device == (u16)PCI_ANY_ID)) {
+			return i->func_map;
+		}
+	}
+	return 0;
+}
+
+/* These are one-to-one translations for devices that use a single incorrect
+ * requester ID. The requester id may not be the BDF of a real device.
+ */
+static const struct pci_dev_dma_source_map {
+	u16 vendor;
+	u16 device;
+	u8  devfn;
+	u8  dma_devfn;
+} pci_dev_dma_source_map[] = {
+
+	/* Ricoh IEEE 1394 Controller */
+	{
+		PCI_VENDOR_ID_RICOH,
+		0xe832,
+		PCI_DEVFN(0x00, 3),
+		PCI_DEVFN(0x00, 0)
+	},
+
+	/* Nils Caspar - Adaptec 3405
+	 * http://www.mail-archive.com/centos@centos.org/msg90986.html
+	 * Jonathan McCune
+	 * http://old-list-archives.xen.org/archives/html/xen-users/2010-04/msg00535.html */
+	{
+		PCI_VENDOR_ID_ADAPTEC2,
+		0x028b,
+		PCI_DEVFN(0x0e, 0),
+		PCI_DEVFN(0x01, 0)
+	},
+
+	/* Mateusz Murawski - LSI SAS based MegaRAID
+	 * https://lkml.org/lkml/2011/9/12/104
+	 * M. Nunberg - Dell PERC 5/i Integrated RAID Controller
+	 * http://lists.xen.org/archives/html/xen-devel/2010-05/msg01563.html */
+	{
+		PCI_VENDOR_ID_LSI_LOGIC,
+		0x0411,
+		PCI_DEVFN(0x0e, 0),
+		PCI_DEVFN(0x08, 0)
+	},
+
+	/* Steven Dake, Markus Stockhausen - Mellanox 26428
+	 * https://bugzilla.redhat.com/show_bug.cgi?id=713774
+	 * Note: mellanox uses decimal product numbers, convert to hex for PCI
+	 * device ID. ie. 26428 == 0x673c */
+	{
+		PCI_VENDOR_ID_MELLANOX,
+		0x673c,
+		PCI_DEVFN(0x00, 0),
+		PCI_DEVFN(0x00, 6)
+	},
+
+	{ 0 }
+};
+
+u8 pci_requester(struct pci_dev *dev)
+{
+	const struct pci_dev_dma_source_map *i;
+
+	for (i = pci_dev_dma_source_map; i->devfn; i++) {
+		if ((i->vendor == dev->vendor) &&
+		    (i->device == dev->device) &&
+		    (i->devfn == dev->devfn)) {
+			return i->dma_devfn;
+		}
+	}
+	return dev->devfn;
+}
+
+
 static const struct pci_dev_acs_enabled {
 	u16 vendor;
 	u16 device;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a13d6825e5..3214fd2514 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1632,6 +1632,8 @@ enum pci_fixup_pass {
 #ifdef CONFIG_PCI_QUIRKS
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);
 struct pci_dev *pci_get_dma_source(struct pci_dev *dev);
+u8 pci_multi_requesters(struct pci_dev *dev);
+u8 pci_requester(struct pci_dev *dev);
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 #else
 static inline void pci_fixup_device(enum pci_fixup_pass pass,
@@ -1640,6 +1642,14 @@ static inline struct pci_dev *pci_get_dma_source(struct pci_dev *dev)
 {
 	return pci_dev_get(dev);
 }
+u8 pci_multi_requesters(struct pci_dev *dev)
+{
+	return 0;
+}
+u8 pci_requester(struct pci_dev *dev)
+{
+	return dev->devfn;
+}
 static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
 					       u16 acs_flags)
 {
