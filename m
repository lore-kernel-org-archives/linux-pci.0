Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI/msi: remove unused default PCI IRQ domain code
Date: Wed,  8 Feb 2017 18:17:43 +0100
Message-Id: <20170208171744.17100-2-hch@lst.de>
In-Reply-To: <20170208171744.17100-1-hch@lst.de>
References: <20170208171744.17100-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_msi_create_default_irq_domain is never called in the whole tree, so
remove it as well as all the supporting code for a default PCI MSI domain.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/msi.c   | 50 ++------------------------------------------------
 include/linux/msi.h |  3 ---
 2 files changed, 2 insertions(+), 51 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 50c5003295ca..9de17f17a5d2 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -32,30 +32,11 @@ int pci_msi_ignore_mask;
 #define msix_table_size(flags)	((flags & PCI_MSIX_FLAGS_QSIZE) + 1)
 
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
-static struct irq_domain *pci_msi_default_domain;
-static DEFINE_MUTEX(pci_msi_domain_lock);
-
-struct irq_domain * __weak arch_get_pci_msi_domain(struct pci_dev *dev)
-{
-	return pci_msi_default_domain;
-}
-
-static struct irq_domain *pci_msi_get_domain(struct pci_dev *dev)
-{
-	struct irq_domain *domain;
-
-	domain = dev_get_msi_domain(&dev->dev);
-	if (domain)
-		return domain;
-
-	return arch_get_pci_msi_domain(dev);
-}
-
 static int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
 	struct irq_domain *domain;
 
-	domain = pci_msi_get_domain(dev);
+	domain = dev_get_msi_domain(&dev->dev);
 	if (domain && irq_domain_is_hierarchy(domain))
 		return pci_msi_domain_alloc_irqs(domain, dev, nvec, type);
 
@@ -66,7 +47,7 @@ static void pci_msi_teardown_msi_irqs(struct pci_dev *dev)
 {
 	struct irq_domain *domain;
 
-	domain = pci_msi_get_domain(dev);
+	domain = dev_get_msi_domain(&dev->dev);
 	if (domain && irq_domain_is_hierarchy(domain))
 		pci_msi_domain_free_irqs(domain, dev);
 	else
@@ -1507,33 +1488,6 @@ void pci_msi_domain_free_irqs(struct irq_domain *domain, struct pci_dev *dev)
 	msi_domain_free_irqs(domain, &dev->dev);
 }
 
-/**
- * pci_msi_create_default_irq_domain - Create a default MSI interrupt domain
- * @fwnode:	Optional fwnode of the interrupt controller
- * @info:	MSI domain info
- * @parent:	Parent irq domain
- *
- * Returns: A domain pointer or NULL in case of failure. If successful
- * the default PCI/MSI irqdomain pointer is updated.
- */
-struct irq_domain *pci_msi_create_default_irq_domain(struct fwnode_handle *fwnode,
-		struct msi_domain_info *info, struct irq_domain *parent)
-{
-	struct irq_domain *domain;
-
-	mutex_lock(&pci_msi_domain_lock);
-	if (pci_msi_default_domain) {
-		pr_err("PCI: default irq domain for PCI MSI has already been created.\n");
-		domain = NULL;
-	} else {
-		domain = pci_msi_create_irq_domain(fwnode, info, parent);
-		pci_msi_default_domain = domain;
-	}
-	mutex_unlock(&pci_msi_domain_lock);
-
-	return domain;
-}
-
 static int get_msi_id_cb(struct pci_dev *pdev, u16 alias, void *data)
 {
 	u32 *pa = data;
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 0db320b7bb15..18b8566b3ce3 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -319,9 +319,6 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 int pci_msi_domain_alloc_irqs(struct irq_domain *domain, struct pci_dev *dev,
 			      int nvec, int type);
 void pci_msi_domain_free_irqs(struct irq_domain *domain, struct pci_dev *dev);
-struct irq_domain *pci_msi_create_default_irq_domain(struct fwnode_handle *fwnode,
-		 struct msi_domain_info *info, struct irq_domain *parent);
-
 irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
 					  struct msi_desc *desc);
 int pci_msi_domain_check_cap(struct irq_domain *domain,
-- 
2.11.0
