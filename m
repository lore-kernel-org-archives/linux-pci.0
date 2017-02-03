Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:41831 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdBCQ1Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2017 11:27:16 -0500
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI/msi: remove pci_msi_domain_{alloc,free}_irqs
Date: Fri,  3 Feb 2017 17:27:05 +0100
Message-Id: <20170203162705.5182-3-hch@lst.de>
In-Reply-To: <20170203162705.5182-1-hch@lst.de>
References: <20170203162705.5182-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just call the msi_* version directly instead of having trivial wrappers
for one or two callsites.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/apic/msi.c |  2 +-
 drivers/pci/msi.c          | 30 ++----------------------------
 include/linux/msi.h        |  3 ---
 3 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 015bbf30e3e3..c61aec7e65f4 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -82,7 +82,7 @@ int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	if (domain == NULL)
 		return -ENOSYS;
 
-	return pci_msi_domain_alloc_irqs(domain, dev, nvec, type);
+	return msi_domain_alloc_irqs(domain, &dev->dev, nvec);
 }
 
 void native_teardown_msi_irq(unsigned int irq)
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 4f2996bd5c6a..3ba99adb8b40 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -57,7 +57,7 @@ static int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 
 	domain = pci_msi_get_domain(dev);
 	if (domain && irq_domain_is_hierarchy(domain))
-		return pci_msi_domain_alloc_irqs(domain, dev, nvec, type);
+		return msi_domain_alloc_irqs(domain, &dev->dev, nvec);
 
 	return arch_setup_msi_irqs(dev, nvec, type);
 }
@@ -68,7 +68,7 @@ static void pci_msi_teardown_msi_irqs(struct pci_dev *dev)
 
 	domain = pci_msi_get_domain(dev);
 	if (domain && irq_domain_is_hierarchy(domain))
-		pci_msi_domain_free_irqs(domain, dev);
+		msi_domain_free_irqs(domain, &dev->dev);
 	else
 		arch_teardown_msi_irqs(dev);
 }
@@ -1481,32 +1481,6 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
 
-/**
- * pci_msi_domain_alloc_irqs - Allocate interrupts for @dev in @domain
- * @domain:	The interrupt domain to allocate from
- * @dev:	The device for which to allocate
- * @nvec:	The number of interrupts to allocate
- * @type:	Unused to allow simpler migration from the arch_XXX interfaces
- *
- * Returns:
- * A virtual interrupt number or an error code in case of failure
- */
-int pci_msi_domain_alloc_irqs(struct irq_domain *domain, struct pci_dev *dev,
-			      int nvec, int type)
-{
-	return msi_domain_alloc_irqs(domain, &dev->dev, nvec);
-}
-
-/**
- * pci_msi_domain_free_irqs - Free interrupts for @dev in @domain
- * @domain:	The interrupt domain
- * @dev:	The device for which to free interrupts
- */
-void pci_msi_domain_free_irqs(struct irq_domain *domain, struct pci_dev *dev)
-{
-	msi_domain_free_irqs(domain, &dev->dev);
-}
-
 static int get_msi_id_cb(struct pci_dev *pdev, u16 alias, void *data)
 {
 	u32 *pa = data;
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 18b8566b3ce3..1b6f3ebbe876 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -316,9 +316,6 @@ void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg);
 struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct msi_domain_info *info,
 					     struct irq_domain *parent);
-int pci_msi_domain_alloc_irqs(struct irq_domain *domain, struct pci_dev *dev,
-			      int nvec, int type);
-void pci_msi_domain_free_irqs(struct irq_domain *domain, struct pci_dev *dev);
 irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
 					  struct msi_desc *desc);
 int pci_msi_domain_check_cap(struct irq_domain *domain,
-- 
2.11.0
