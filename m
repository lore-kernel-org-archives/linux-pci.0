Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from stargate.chelsio.com ([67.207.115.98]:30844 "EHLO
	stargate3.asicdesigners.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752857AbbJROtr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 18 Oct 2015 10:49:47 -0400
From: Hariprasad Shenai <hariprasad@chelsio.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, leedom@chelsio.com,
	nirranjan@chelsio.com, Hariprasad Shenai <hariprasad@chelsio.com>
Subject: [PATCH] pci: Add pci quirk to turnoff Nosnoop and Relaxed Ordering
Date: Sun, 18 Oct 2015 19:55:04 +0530
Message-Id: <1445178304-14855-1-git-send-email-hariprasad@chelsio.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some devices violate the PCI Specification regarding echoing the Root
Port Transaction Layer Packet Request (TLP) No Snoop and Relaxed
Ordering Attributes into the TLP Response. The PCI Specification
"encourages" compliant Root Port implementation to drop such
malformed TLP Responses leading to device access timeouts. Many Root Port
implementations accept such malformed TLP Responses and a few more
strict implementations do drop them.

For devices which fail this part of the PCI Specification, we need to
traverse up the PCI Chain to the Root Port and turn off the Enable No
Snoop and Enable Relaxed Ordering bits in the Root Port's PCI-Express
Device Control register. This does affect all other devices which
are downstream of that Root Port.

Note that Configuration Space accesses are never supposed to have TLP
Attributes, so we're safe waiting till after any Configuration Space
accesses to do the Root Port "fixup".

Based on original work by Casey Leedom <leedom@chelsio.com>

Signed-off-by: Hariprasad Shenai <hariprasad@chelsio.com>
---
 drivers/pci/pci.c    | 28 ++++++++++++++++++++++++++
 drivers/pci/quirks.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |  1 +
 3 files changed, 85 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6a9a111..3ce202b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -458,6 +458,34 @@ struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 EXPORT_SYMBOL(pci_find_parent_resource);
 
 /**
+ * pci_find_root_pcie_port - return PCI-E Root Port
+ * @dev: PCI device to query
+ *
+ * Traverses up the parent chain and return the PCI-E Root Port PCI Device
+ * for a given PCI Device.
+ */
+struct pci_dev *pci_find_root_pcie_port(const struct pci_dev *dev)
+{
+	struct pci_bus *bus = dev->bus;
+	struct pci_dev *highest_pcie_bridge = NULL;
+
+	while (bus) {
+		struct pci_dev *bridge = bus->self;
+
+		if (!bridge || !bridge->pcie_cap)
+			break;
+		highest_pcie_bridge = bridge;
+		bus = bus->parent;
+	}
+
+	if (!highest_pcie_bridge)
+		dev_warn(&dev->dev, "Can't find Root Port\n");
+
+	return highest_pcie_bridge;
+}
+EXPORT_SYMBOL(pci_find_root_pcie_port);
+
+/**
  * pci_wait_for_pending - wait for @mask bit(s) to clear in status word @pos
  * @dev: the PCI device to operate on
  * @pos: config space offset of status word
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6a30252..f860956 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3692,6 +3692,62 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6869, PCI_CLASS_NOT_DEFINED, 8,
 			      quirk_tw686x_class);
 
 /*
+ * Some devices violate the PCI Specification regarding echoing the Root
+ * Port Transaction Layer Packet Request (TLP) No Snoop and Relaxed
+ * Ordering Attributes into the TLP Response.  The PCI Specification
+ * "encourages" compliant Root Port implementation to drop such malformed
+ * TLP Responses leading to device access timeouts.  Many Root Port
+ * implementations accept such malformed TLP Responses and a few more strict
+ * implementations do drop them.
+ *
+ * For devices which fail this part of the PCI Specification, we need to
+ * traverse up the PCI Chain to the Root Port and turn off the Enable No
+ * Snoop and Enable Relaxed Ordering bits in the Root Port's PCI-Express
+ * Device Control register.  This does affect all other devices which are
+ * downstream of that Root Port but since No Snoop and Relaxed ordering are
+ * "Performance Hints," we're okay with that ...
+ *
+ * Note that Configuration Space accesses are never supposed to have TLP
+ * Attributes, so we're safe waiting till after any Configuration Space
+ * accesses to do the Root Port "fixup" ...
+ */
+static void quirk_disable_root_port_attributes(struct pci_dev *pdev)
+{
+	struct pci_dev *root_port = pci_find_root_pcie_port(pdev);
+
+	if (!root_port) {
+		dev_warn(&pdev->dev, "Can't find Root Port to disable No Snoop/Relaxed Ordering\n");
+		return;
+	}
+
+	dev_info(&pdev->dev, "Disabling No Snoop/Relaxed Ordering on Root Port %s\n",
+		 dev_name(&root_port->dev));
+	pcie_capability_clear_and_set_word(root_port,
+					   PCI_EXP_DEVCTL,
+					   PCI_EXP_DEVCTL_RELAX_EN |
+					   PCI_EXP_DEVCTL_NOSNOOP_EN,
+					   0);
+}
+
+/*
+ * The Chelsio T5 chip fails to return the Root Port's TLP Attributes in
+ * its TLP responses to the Root Port.
+ */
+static void quirk_chelsio_T5_disable_root_port_attributes(struct pci_dev *pdev)
+{
+	/*
+	 * This mask/compare operation selects for Physical Function 4 on a
+	 * T5.  We only need to fix up the Root Port once for any of the
+	 * PFs.  PF[0..3] have PCI Device IDs of 0x50xx, but PF4 is uniquely
+	 * 0x54xx so we use that one,
+	 */
+	if ((pdev->device & 0xff00) == 0x5400)
+		quirk_disable_root_port_attributes(pdev);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
+			 quirk_chelsio_T5_disable_root_port_attributes);
+
+/*
  * AMD has indicated that the devices below do not support peer-to-peer
  * in any system where they are found in the southbridge with an AMD
  * IOMMU in the system.  Multifunction devices that do not support
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e90eb22..5b4d7cc 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -820,6 +820,7 @@ void pci_bus_add_device(struct pci_dev *dev);
 void pci_read_bridge_bases(struct pci_bus *child);
 struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 					  struct resource *res);
+struct pci_dev *pci_find_root_pcie_port(const struct pci_dev *dev);
 u8 pci_swizzle_interrupt_pin(const struct pci_dev *dev, u8 pin);
 int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
 u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
-- 
2.3.4

