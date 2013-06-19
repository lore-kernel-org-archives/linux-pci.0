Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:42344 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934462Ab3FSQ4b (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2013 12:56:31 -0400
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
Subject: [PATCHv3 03/11] PCI: Introduce new MSI chip infrastructure
Date: Wed, 19 Jun 2013 18:56:11 +0200
Message-Id: <1371660979-21588-4-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <thierry.reding@avionic-design.de>

The new struct msi_chip is used to associated an MSI controller with a
PCI bus. It is automatically handed down from the root to its children
during bus enumeration.

This patch provides default (weak) implementations for the architecture-
specific MSI functions (arch_setup_msi_irq(), arch_teardown_msi_irq()
and arch_msi_check_device()) which check if a PCI device's bus has an
attached MSI chip and forward the call appropriately.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/msi.c   | 22 ++++++++++++++++++++++
 drivers/pci/probe.c |  1 +
 include/linux/msi.h | 11 +++++++++++
 include/linux/pci.h |  1 +
 4 files changed, 35 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 4bc0c8f..dc357e9 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -32,6 +32,19 @@ static int pci_msi_enable = 1;
 
 int default_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 {
+	struct msi_chip *chip = dev->bus->msi;
+
+	if (chip && chip->setup_irq) {
+		int err;
+
+		err = chip->setup_irq(chip, dev, desc);
+		if (err < 0)
+			return err;
+
+		irq_set_chip_data(desc->irq, chip);
+		return err;
+	}
+
 	return -EINVAL;
 }
 
@@ -42,6 +55,10 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 
 void default_teardown_msi_irq(unsigned int irq)
 {
+	struct msi_chip *chip = irq_get_chip_data(irq);
+
+	if (chip && chip->teardown_irq)
+		chip->teardown_irq(chip, irq);
 }
 
 void __weak arch_teardown_msi_irq(unsigned int irq)
@@ -51,6 +68,11 @@ void __weak arch_teardown_msi_irq(unsigned int irq)
 
 int default_msi_check_device(struct pci_dev *dev, int nvec, int type)
 {
+	struct msi_chip *chip = dev->bus->msi;
+
+	if (chip && chip->check_device)
+		return chip->check_device(chip, dev, nvec, type);
+
 	return 0;
 }
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 70f10fa..c8591e4 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -634,6 +634,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 
 	child->parent = parent;
 	child->ops = parent->ops;
+	child->msi = parent->msi;
 	child->sysdata = parent->sysdata;
 	child->bus_flags = parent->bus_flags;
 
diff --git a/include/linux/msi.h b/include/linux/msi.h
index e792a3f..e3a137d 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -71,4 +71,15 @@ int default_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
 void default_teardown_msi_irqs(struct pci_dev *dev);
 void default_restore_msi_irqs(struct pci_dev *dev, int irq);
 
+struct msi_chip {
+	struct module *owner;
+	struct device *dev;
+
+	int (*setup_irq)(struct msi_chip *chip, struct pci_dev *dev,
+			 struct msi_desc *desc);
+	void (*teardown_irq)(struct msi_chip *chip, unsigned int irq);
+	int (*check_device)(struct msi_chip *chip, struct pci_dev *dev,
+			    int nvec, int type);
+};
+
 #endif /* LINUX_MSI_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3a24e4f..7ffc012 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -432,6 +432,7 @@ struct pci_bus {
 	struct resource busn_res;	/* bus numbers routed to this bus */
 
 	struct pci_ops	*ops;		/* configuration access functions */
+	struct msi_chip	*msi;		/* MSI controller */
 	void		*sysdata;	/* hook for sys-specific extension */
 	struct proc_dir_entry *procdir;	/* directory entry in /proc/bus/pci */
 
-- 
1.8.1.2

