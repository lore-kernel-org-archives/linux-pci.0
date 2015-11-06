Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9052 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757670AbbKFWmA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 6 Nov 2015 17:42:00 -0500
From: Keith Busch <keith.busch@intel.com>
To: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCHv4 3/6] Export msi and irq functions for module use
Date: Fri,  6 Nov 2015 15:35:43 -0700
Message-Id: <1446849346-8242-4-git-send-email-keith.busch@intel.com>
In-Reply-To: <1446849346-8242-1-git-send-email-keith.busch@intel.com>
References: <1446849346-8242-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/msi.c      | 2 ++
 kernel/irq/irqdomain.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 4a7da3c..5fb932b 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1119,6 +1119,7 @@ struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
 {
 	return to_pci_dev(desc->dev);
 }
+EXPORT_SYMBOL_GPL(msi_desc_to_pci_dev);
 
 void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
 {
@@ -1278,6 +1279,7 @@ struct irq_domain *pci_msi_create_irq_domain(struct device_node *node,
 	domain->bus_token = DOMAIN_BUS_PCI_MSI;
 	return domain;
 }
+EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
 
 /**
  * pci_msi_domain_alloc_irqs - Allocate interrupts for @dev in @domain
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index dc9d27c..43f503f 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -955,6 +955,7 @@ void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
 	__irq_set_handler(virq, handler, 0, handler_name);
 	irq_set_handler_data(virq, handler_data);
 }
+EXPORT_SYMBOL(irq_domain_set_info);
 
 /**
  * irq_domain_reset_irq_data - Clear hwirq, chip and chip_data in @irq_data
-- 
2.6.2.307.g37023ba

