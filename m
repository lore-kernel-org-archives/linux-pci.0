Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI/msi: remove unused function pci_msi_create_default_irq_domain
Date: Fri,  3 Feb 2017 17:27:04 +0100
Message-Id: <20170203162705.5182-2-hch@lst.de>
In-Reply-To: <20170203162705.5182-1-hch@lst.de>
References: <20170203162705.5182-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/msi.c   | 27 ---------------------------
 include/linux/msi.h |  3 ---
 2 files changed, 30 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 50c5003295ca..4f2996bd5c6a 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1507,33 +1507,6 @@ void pci_msi_domain_free_irqs(struct irq_domain *domain, struct pci_dev *dev)
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
