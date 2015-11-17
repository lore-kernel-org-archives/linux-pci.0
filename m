Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58155 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859AbbKQRDA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 17 Nov 2015 12:03:00 -0500
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 1/3] drivers: pci: add generic code to claim bus resources
Date: Tue, 17 Nov 2015 17:03:56 +0000
Message-Id: <1447779838-15585-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI core code contains a set of functions, eg:

pci_assign_unassigned_bus_resources()

that allow to assign the PCI resources for a given bus after
enumeration.

On systems where the PCI BARs are immutable (ie they must not and can
not be assigned), PCI resources must be claimed in order to be
validated and inserted in the PCI resources tree, but there is no generic
PCI kernel function for that purpose and the resource claiming is
implemented in an arch specific fashion which resulted in arches
implementations that contain duplicated code.

This patch, based on the ia64 resource claiming arch implementation,
implements a set of functions in core PCI code that provides a PCI core
interface for resources claiming for a given PCI bus hierarchy, paving
the way for further resource claiming consolidation across architectures.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h     |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 1723ac1..9054541 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1424,6 +1424,48 @@ void pci_bus_assign_resources(const struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_bus_assign_resources);
 
+static void pci_claim_device_resources(struct pci_dev *dev)
+{
+	int i;
+
+	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
+		struct resource *r = &dev->resource[i];
+
+		if (!r->flags || r->parent)
+			continue;
+
+		pci_claim_resource(dev, i);
+	}
+}
+
+static void pci_claim_bridge_resources(struct pci_dev *dev)
+{
+	int i;
+
+	for (i = PCI_BRIDGE_RESOURCES; i < PCI_NUM_RESOURCES; i++) {
+		struct resource *r = &dev->resource[i];
+
+		if (!r->flags || r->parent)
+			continue;
+
+		pci_claim_bridge_resource(dev, i);
+	}
+}
+
+void pci_bus_claim_resources(struct pci_bus *b)
+{
+	struct pci_dev *dev;
+
+	if (b->self) {
+		pci_read_bridge_bases(b);
+		pci_claim_bridge_resources(b->self);
+	}
+
+	list_for_each_entry(dev, &b->devices, bus_list)
+		pci_claim_device_resources(dev);
+}
+EXPORT_SYMBOL(pci_bus_claim_resources);
+
 static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
 					  struct list_head *add_head,
 					  struct list_head *fail_head)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e828e7b..28ce9c5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1110,6 +1110,7 @@ ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void
 /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
 resource_size_t pcibios_retrieve_fw_addr(struct pci_dev *dev, int idx);
 void pci_bus_assign_resources(const struct pci_bus *bus);
+void pci_bus_claim_resources(struct pci_bus *bus);
 void pci_bus_size_bridges(struct pci_bus *bus);
 int pci_claim_resource(struct pci_dev *, int);
 int pci_claim_bridge_resource(struct pci_dev *bridge, int i);
-- 
2.5.1

