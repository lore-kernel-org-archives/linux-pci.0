Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:42358 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934462Ab3FSQ4c (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2013 12:56:32 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCHv3 04/11] of: pci: add registry of MSI chips
Date: Wed, 19 Jun 2013 18:56:12 +0200
Message-Id: <1371660979-21588-5-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit adds a very basic registry of msi_chip structures, so that
an IRQ controller driver can register an msi_chip, and a PCIe host
controller can find it, based on a 'struct device_node'.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/of/of_pci.c    | 22 ++++++++++++++++++++++
 include/linux/msi.h    |  2 ++
 include/linux/of_pci.h |  4 ++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 42c687a..ca12db8 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -89,3 +89,25 @@ int of_pci_parse_bus_range(struct device_node *node, struct resource *res)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_pci_parse_bus_range);
+
+static LIST_HEAD(msi_chip_list);
+static DEFINE_MUTEX(msi_chip_mutex);
+
+void of_msi_chip_add(struct msi_chip *chip)
+{
+	mutex_lock(&msi_chip_mutex);
+	list_add(&chip->link, &msi_chip_list);
+	mutex_unlock(&msi_chip_mutex);
+}
+
+struct msi_chip *of_msi_chip_find_by_node(struct device_node *of_node)
+{
+	struct msi_chip *c;
+	list_for_each_entry(c, &msi_chip_list, link) {
+		if (c->of_node == of_node &&
+		    of_property_read_bool(c->of_node, "msi-controller"))
+			return c;
+	}
+
+	return NULL;
+}
diff --git a/include/linux/msi.h b/include/linux/msi.h
index e3a137d..8b930c3 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -74,6 +74,8 @@ void default_restore_msi_irqs(struct pci_dev *dev, int irq);
 struct msi_chip {
 	struct module *owner;
 	struct device *dev;
+	struct device_node *of_node;
+	struct list_head link;
 
 	int (*setup_irq)(struct msi_chip *chip, struct pci_dev *dev,
 			 struct msi_desc *desc);
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 7a04826..6e88189 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -2,6 +2,7 @@
 #define __OF_PCI_H
 
 #include <linux/pci.h>
+#include <linux/msi.h>
 
 struct pci_dev;
 struct of_irq;
@@ -13,4 +14,7 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
 int of_pci_get_devfn(struct device_node *np);
 int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
 
+void of_msi_chip_add(struct msi_chip *chip);
+struct msi_chip *of_msi_chip_find_by_node(struct device_node *of_node);
+
 #endif
-- 
1.8.1.2

