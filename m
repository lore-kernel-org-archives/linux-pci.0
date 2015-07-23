Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42149 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147AbbGWOti (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jul 2015 10:49:38 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>
Cc: linux-pci@vger.kernel.org, patchwork-lst@pengutronix.de
Subject: [PATCH v2 1/2] PCI: allow MSI chip providers to implement their own multivector MSI setup
Date: Thu, 23 Jul 2015 16:49:35 +0200
Message-Id: <1437662976-27188-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/msi.c   | 3 +++
 include/linux/msi.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index f66be868ad21..685a83c459c6 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -121,9 +121,12 @@ void __weak arch_teardown_msi_irq(unsigned int irq)
 
 int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
+	struct msi_controller *chip = pci_msi_controller(dev);
 	struct msi_desc *entry;
 	int ret;
 
+	if (chip && chip->setup_irqs)
+		return chip->setup_irqs(chip, dev, nvec, type);
 	/*
 	 * If an architecture wants to support multiple MSI, it needs to
 	 * override arch_setup_msi_irqs()
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 8ac4a68ffae2..50fefeb30236 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -114,6 +114,8 @@ struct msi_controller {
 
 	int (*setup_irq)(struct msi_controller *chip, struct pci_dev *dev,
 			 struct msi_desc *desc);
+	int (*setup_irqs)(struct msi_controller *chip, struct pci_dev *dev,
+			  int nvec, int type);
 	void (*teardown_irq)(struct msi_controller *chip, unsigned int irq);
 };
 
-- 
2.1.4

