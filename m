Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:44284 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304Ab3FFQll (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2013 12:41:41 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>
Subject: [PATCH v2 2/8] PCI: Add registry of MSI chips
Date: Thu,  6 Jun 2013 18:41:22 +0200
Message-Id: <1370536888-8871-3-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit adds a very basic registry of msi_chip structures, so that
an IRQ controller driver can register an msi_chip, and a PCIe host
controller can find it, based on a 'struct device_node'.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/msi.c   | 25 +++++++++++++++++++++++++
 include/linux/msi.h | 11 +++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 4dafac6..0f177ee 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -20,6 +20,7 @@
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 #include "pci.h"
 
@@ -70,6 +71,30 @@ int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
 # define HAVE_DEFAULT_MSI_SETUP_IRQS
 #endif
 
+#ifdef CONFIG_OF
+static LIST_HEAD(msi_chip_list);
+static DEFINE_MUTEX(msi_chip_mutex);
+
+void msi_chip_add(struct msi_chip *chip)
+{
+	mutex_lock(&msi_chip_mutex);
+	list_add(&chip->link, &msi_chip_list);
+	mutex_unlock(&msi_chip_mutex);
+}
+
+struct msi_chip *msi_chip_find_by_of_node(struct device_node *of_node)
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
+#endif
+
 #ifdef HAVE_DEFAULT_MSI_SETUP_IRQS
 int default_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 4633529..a1a6084 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -61,6 +61,8 @@ int arch_msi_check_device(struct pci_dev* dev, int nvec, int type);
 struct msi_chip {
 	struct module *owner;
 	struct device *dev;
+	struct device_node *of_node;
+	struct list_head link;
 
 	int (*setup_irq)(struct msi_chip *chip, struct pci_dev *dev,
 			 struct msi_desc *desc);
@@ -69,4 +71,13 @@ struct msi_chip {
 			    int nvec, int type);
 };
 
+#if defined(CONFIG_PCI_MSI) && defined(CONFIG_OF)
+void msi_chip_add(struct msi_chip *chip);
+struct msi_chip *msi_chip_find_by_of_node(struct device_node *of_node);
+#else
+static inline void msi_chip_add(struct msi_chip *chip) {}
+static inline struct msi_chip *
+msi_chip_find_by_of_node(struct device_node *of_node) { return NULL; }
+#endif
+
 #endif /* LINUX_MSI_H */
-- 
1.8.1.2

