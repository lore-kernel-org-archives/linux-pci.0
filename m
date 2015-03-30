Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58698 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbbC3KzU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2015 06:55:20 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v4 1/2] PCI: add helper function to find root port for device
Date: Mon, 30 Mar 2015 12:55:12 +0200
Message-Id: <1427712913-13678-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds a simple way to get the root port a given device
is connected to.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v2: new patch in v2
v3: rename to pci_find_rootport to fit better with other API
v4: - rename to make it obvious that this function is PCIe specific
    - fixes wrong assumption about what is a root bus in the presence
      virtual buses
---
 drivers/pci/search.c | 20 ++++++++++++++++++++
 include/linux/pci.h  |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index a20ce7d5e2a7..d7c599103ae1 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -384,3 +384,23 @@ int pci_dev_present(const struct pci_device_id *ids)
 	return 0;
 }
 EXPORT_SYMBOL(pci_dev_present);
+
+/**
+ * pcie_find_root_port - Returns the root port the given device is connected to.
+ * @dev: PCI device for which the root port should be found.
+ */
+struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
+{
+	struct pci_bus *bus = dev->bus;
+
+	/* if this device is located on the root bus, it is a root port */
+	if (pci_is_root_bus(bus))
+		return dev;
+
+	/* walk up the PCI hierarchy to the first level below the root */
+	while (bus->parent && bus->parent->parent)
+		bus = bus->parent;
+
+	return bus->self;
+}
+EXPORT_SYMBOL(pcie_find_root_port);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 211e9da8a7d7..308c71081034 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -844,6 +844,7 @@ static inline struct pci_dev *pci_get_bus_and_slot(unsigned int bus,
 }
 struct pci_dev *pci_get_class(unsigned int class, struct pci_dev *from);
 int pci_dev_present(const struct pci_device_id *ids);
+struct pci_dev *pcie_find_root_port(struct pci_dev *dev);
 
 int pci_bus_read_config_byte(struct pci_bus *bus, unsigned int devfn,
 			     int where, u8 *val);
-- 
2.1.4

