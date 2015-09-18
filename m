Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58972 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754913AbbIRPMm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2015 11:12:42 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	linux-pci@vger.kernel.org, kernel@pengutronix.de,
	patchwork-lst@pengutronix.de
Subject: [PATCH v5 1/5] PCI: Add msi_controller setup_irqs() method for special multivector setup
Date: Fri, 18 Sep 2015 17:12:35 +0200
Message-Id: <1442589159-28201-2-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1442589159-28201-1-git-send-email-l.stach@pengutronix.de>
References: <1442589159-28201-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a msi_controller setup_irqs() method so MSI chip providers can
implement their own multivector MSI setup.

[bhelgaas: changelog]
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Pratyush Anand <pratyush.anand@gmail.com>
---
 drivers/pci/msi.c   | 3 +++
 include/linux/msi.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index d4497141d083..74319f497656 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -105,9 +105,12 @@ void __weak arch_teardown_msi_irq(unsigned int irq)
 
 int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
+	struct msi_controller *chip = dev->bus->msi;
 	struct msi_desc *entry;
 	int ret;
 
+	if (chip && chip->setup_irqs)
+		return chip->setup_irqs(chip, dev, nvec, type);
 	/*
 	 * If an architecture wants to support multiple MSI, it needs to
 	 * override arch_setup_msi_irqs()
diff --git a/include/linux/msi.h b/include/linux/msi.h
index ad939d0ba816..0be5db110bfa 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -163,6 +163,8 @@ struct msi_controller {
 
 	int (*setup_irq)(struct msi_controller *chip, struct pci_dev *dev,
 			 struct msi_desc *desc);
+	int (*setup_irqs)(struct msi_controller *chip, struct pci_dev *dev,
+			  int nvec, int type);
 	void (*teardown_irq)(struct msi_controller *chip, unsigned int irq);
 };
 
-- 
2.5.1

