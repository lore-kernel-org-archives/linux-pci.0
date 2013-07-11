Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17547 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755864Ab3GKVDz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 11 Jul 2013 17:03:55 -0400
Subject: [RFC PATCH v2 1/2] pci: Create PCIe requester ID interface
To: bhelgaas@google.com
From: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, joro@8bytes.org,
	iommu@lists.linux-foundation.org, acooks@gmail.com,
	ddutile@redhat.com, dwmw2@infradead.org
Date: Thu, 11 Jul 2013 15:03:27 -0600
Message-ID: <20130711210326.1701.56478.stgit@bling.home>
In-Reply-To: <20130711204439.1701.90503.stgit@bling.home>
References: <20130711204439.1701.90503.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This provides interfaces for drivers to discover the visible PCIe
requester ID for a device, for things like IOMMU setup, and iterate
over the device chain from requestee to requester, including DMA
quirks at each step.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/search.c |  198 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |    7 ++
 2 files changed, 205 insertions(+)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index d0627fa..4759c02 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -18,6 +18,204 @@ DECLARE_RWSEM(pci_bus_sem);
 EXPORT_SYMBOL_GPL(pci_bus_sem);
 
 /*
+ * pci_has_pcie_requester_id - Does @dev have a PCIe requester ID
+ * @dev: device to test
+ */
+static bool pci_has_pcie_requester_id(struct pci_dev *dev)
+{
+	/*
+	 * XXX There's no indicator of the bus type, conventional PCI vs
+	 * PCI-X vs PCI-e, but we assume that a caller looking for a PCIe
+	 * requester ID is a native PCIe based system (such as VT-d or
+	 * AMD-Vi).  It's common that PCIe root complex devices do not
+	 * include a PCIe capability, but we can assume they are PCIe
+	 * devices based on their topology.
+	 */
+	if (pci_is_pcie(dev) || pci_is_root_bus(dev->bus))
+		return true;
+
+	/*
+	 * PCI-X devices have a requester ID, but the bridge may still take
+	 * ownership of transactions and create a requester ID.  We therefore
+	 * assume that the PCI-X requester ID is not the same one used on PCIe.
+	 */
+
+#ifdef CONFIG_PCI_QUIRKS
+	/*
+	 * Quirk for PCIe-to-PCI bridges which do not expose a PCIe capability.
+	 * If the device is a bridge, look to the next device upstream of it.
+	 * If that device is PCIe and not a PCIe-to-PCI bridge, then by
+	 * deduction, the device must be PCIe and therefore has a requester ID.
+	 */
+	if (dev->subordinate) {
+		struct pci_dev *parent = dev->bus->self;
+
+		if (pci_is_pcie(parent) &&
+		    pci_pcie_type(parent) != PCI_EXP_TYPE_PCI_BRIDGE)
+			return true;
+	}
+#endif
+
+	return false;
+}
+
+/*
+ * pci_has_visible_pcie_requester_id - Can @bridge see @dev's requester ID?
+ * @dev: requester device
+ * @bridge: upstream bridge (or NULL for root bus)
+ */
+static bool pci_has_visible_pcie_requester_id(struct pci_dev *dev,
+					      struct pci_dev *bridge)
+{
+	/*
+	 * The entire path must be tested, if any step does not have a
+	 * requester ID, the chain is broken.  This allows us to support
+	 * topologies with PCIe requester ID gaps, ex: PCIe-PCI-PCIe
+	 */
+	while (dev != bridge) {
+		if (!pci_has_pcie_requester_id(dev))
+			return false;
+
+		if (pci_is_root_bus(dev->bus))
+			return !bridge; /* false if we don't hit @bridge */
+
+		dev = dev->bus->self;
+	}
+
+	return true;
+}
+
+/*
+ * Legacy PCI bridges within a root complex (ex. Intel 82801) report
+ * a different requester ID than a standard PCIe-to-PCI bridge.  Instead
+ * of using (subordinate << 8 | 0) the use (bus << 8 | devfn), like a
+ * standard PCIe endpoint.  This function detects them.
+ *
+ * XXX Is this Intel vendor ID specific?
+ */
+static bool pci_bridge_uses_endpoint_requester(struct pci_dev *bridge)
+{
+	if (!pci_is_pcie(bridge) && pci_is_root_bus(bridge->bus))
+		return true;
+
+	return false;
+}
+
+#define PCI_REQUESTER_ID(dev)	(((dev)->bus->number << 8) | (dev)->devfn)
+#define PCI_BRIDGE_REQUESTER_ID(dev)	((dev)->subordinate->number << 8)
+
+/*
+ * pci_get_visible_pcie_requester - Get requester and requester ID for
+ *                                  @requestee below @bridge
+ * @requestee: requester device
+ * @bridge: upstream bridge (or NULL for root bus)
+ * @requester_id: location to store requester ID or NULL
+ */
+struct pci_dev *pci_get_visible_pcie_requester(struct pci_dev *requestee,
+					       struct pci_dev *bridge,
+					       u16 *requester_id)
+{
+	struct pci_dev *requester = requestee;
+
+	while (requester != bridge) {
+		requester = pci_get_dma_source(requester);
+		pci_dev_put(requester); /* XXX skip ref cnt */
+
+		if (pci_has_visible_pcie_requester_id(requester, bridge))
+			break;
+
+		if (pci_is_root_bus(requester->bus))
+			return NULL; /* @bridge not parent to @requestee */
+
+		requester = requester->bus->self;
+	}
+
+	if (requester_id) {
+		if (requester->bus != requestee->bus &&
+		    !pci_bridge_uses_endpoint_requester(requester))
+			*requester_id = PCI_BRIDGE_REQUESTER_ID(requester);
+		else
+			*requester_id = PCI_REQUESTER_ID(requester);
+	}
+
+	return requester;
+}
+
+static int pci_do_requester_callback(struct pci_dev **dev,
+				     int (*fn)(struct pci_dev *,
+					       u16 id, void *),
+				     void *data)
+{
+	struct pci_dev *dma_dev;
+	int ret;
+
+	ret = fn(*dev, PCI_REQUESTER_ID(*dev), data);
+	if (ret)
+		return ret;
+
+	dma_dev = pci_get_dma_source(*dev);
+	pci_dev_put(dma_dev); /* XXX skip ref cnt */
+	if (dma_dev == *dev)
+		return 0;
+
+	ret = fn(dma_dev, PCI_REQUESTER_ID(dma_dev), data);
+	if (ret)
+		return ret;
+
+	*dev = dma_dev;
+	return 0;
+}
+
+/*
+ * pcie_for_each_requester - Call callback @fn on each devices and DMA source
+ *                           from @requestee to the PCIe requester ID visible
+ *                           to @bridge.
+ * @requestee: Starting device
+ * @bridge: upstream bridge (or NULL for root bus)
+ * @fn: callback function
+ * @data: data to pass to callback
+ */
+int pcie_for_each_requester(struct pci_dev *requestee, struct pci_dev *bridge,
+			    int (*fn)(struct pci_dev *, u16 id, void *),
+			    void *data)
+{
+	struct pci_dev *requester;
+	struct pci_dev *dev = requestee;
+	int ret = 0;
+
+	requester = pci_get_visible_pcie_requester(requestee, bridge, NULL);
+	if (!requester)
+		return -EINVAL;
+
+	do {
+		ret = pci_do_requester_callback(&dev, fn, data);
+		if (ret)
+			return ret;
+
+		if (dev == requester)
+			return 0;
+
+		/*
+		 * We always consider root bus devices to have a visible
+		 * requester ID, therefore this should never be true.
+		 */
+		BUG_ON(pci_is_root_bus(dev->bus));
+
+		dev = dev->bus->self;
+
+	} while (dev != requester);
+
+	/*
+	 * If we've made it here, @requester is a bridge upstream from
+	 * @requestee.
+	 */
+	if (pci_bridge_uses_endpoint_requester(requester))
+		return pci_do_requester_callback(&requester, fn, data);
+
+	return fn(requester, PCI_BRIDGE_REQUESTER_ID(requester), data);
+}
+
+/*
  * find the upstream PCIe-to-PCI bridge of a PCI device
  * if the device is PCIE, return NULL
  * if the device isn't connected to a PCIe bridge (that is its parent is a
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3a24e4f..94e81d1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1873,6 +1873,13 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
 }
 #endif
 
+struct pci_dev *pci_get_visible_pcie_requester(struct pci_dev *requestee,
+					       struct pci_dev *bridge,
+					       u16 *requester_id);
+int pcie_for_each_requester(struct pci_dev *requestee, struct pci_dev *bridge,
+			    int (*fn)(struct pci_dev *, u16 id, void *),
+			    void *data);
+
 /**
  * pci_find_upstream_pcie_bridge - find upstream PCIe-to-PCI bridge of a device
  * @pdev: the PCI device

