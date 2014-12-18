Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51475 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbaLRTLr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Dec 2014 14:11:47 -0500
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 1/2] PCI: add helper function to find root port for device
Date: Thu, 18 Dec 2014 20:11:42 +0100
Message-Id: <1418929903-8506-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds a simple way to get the root port a given device
is connected to.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v2: new patch in v2
---
 drivers/pci/search.c | 20 ++++++++++++++++++++
 include/linux/pci.h  |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index a81f413083e4..c3ae1c52c7cf 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -385,3 +385,23 @@ int pci_dev_present(const struct pci_device_id *ids)
 	return 0;
 }
 EXPORT_SYMBOL(pci_dev_present);
+
+/**
+ * pci_get_rootport - Returns the root port the given device is connected to.
+ * @dev: PCI device for which the root port should be found.
+ */
+struct pci_dev *pci_get_rootport(struct pci_dev *dev)
+{
+	struct pci_bus *bus = dev->bus;
+
+	/* If there is no bridge on the bus the passed device is a root port. */
+	if (!bus->self)
+		return dev;
+
+	/* Walk up the PCI hierarchy to the first level below the root. */
+	while (bus->parent && bus->parent->self)
+		bus = bus->parent;
+
+	return bus->self;
+}
+EXPORT_SYMBOL(pci_get_rootport);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4c8ac5fcc224..05442db50cad 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -843,6 +843,7 @@ static inline struct pci_dev *pci_get_bus_and_slot(unsigned int bus,
 }
 struct pci_dev *pci_get_class(unsigned int class, struct pci_dev *from);
 int pci_dev_present(const struct pci_device_id *ids);
+struct pci_dev *pci_get_rootport(struct pci_dev *dev);
 
 int pci_bus_read_config_byte(struct pci_bus *bus, unsigned int devfn,
 			     int where, u8 *val);
-- 
2.1.3

