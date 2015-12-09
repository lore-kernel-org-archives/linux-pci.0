Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:9475 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527AbbLIWzZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Dec 2015 17:55:25 -0500
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	tglx@linutronix.de, haiyangz@microsoft.com, marc.zyngier@arm.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v9 3/7] PCI: Make it possible to implement a PCI MSI IRQ Domain in a module.
Date: Wed,  9 Dec 2015 22:54:53 +0000
Message-Id: <1449701697-6366-4-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1449701697-6366-1-git-send-email-jakeo@microsoft.com>
References: <1449701697-6366-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

The Linux kernel already has the concpet of IRQ domain, wherein a
component can expose a set of IRQs which are managed by a particular
interrupt controller chip or other subsystem. The PCI driver exposes
the notion of an IRQ domain for Message-Signaled Interrupts (MSI) from
PCI Express devices. This patch exposes the functions which are
necessary for making an MSI IRQ domain within a module.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 arch/x86/include/asm/msi.h    | 6 ++++++
 arch/x86/kernel/apic/msi.c    | 8 +++++---
 arch/x86/kernel/apic/vector.c | 2 ++
 drivers/pci/msi.c             | 4 ++++
 kernel/irq/chip.c             | 1 +
 kernel/irq/irqdomain.c        | 4 ++++
 6 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/msi.h b/arch/x86/include/asm/msi.h
index 93724cc..eb4b09b 100644
--- a/arch/x86/include/asm/msi.h
+++ b/arch/x86/include/asm/msi.h
@@ -1,7 +1,13 @@
 #ifndef _ASM_X86_MSI_H
 #define _ASM_X86_MSI_H
 #include <asm/hw_irq.h>
+#include <asm/irqdomain.h>
 
 typedef struct irq_alloc_info msi_alloc_info_t;
 
+int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
+		    msi_alloc_info_t *arg);
+
+void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc);
+
 #endif /* _ASM_X86_MSI_H */
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 5f1feb6..ade2532 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -96,8 +96,8 @@ static irq_hw_number_t pci_msi_get_hwirq(struct msi_domain_info *info,
 	return arg->msi_hwirq;
 }
 
-static int pci_msi_prepare(struct irq_domain *domain, struct device *dev,
-			   int nvec, msi_alloc_info_t *arg)
+int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
+		    msi_alloc_info_t *arg)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct msi_desc *desc = first_pci_msi_entry(pdev);
@@ -113,11 +113,13 @@ static int pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_msi_prepare);
 
-static void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
 {
 	arg->msi_hwirq = pci_msi_domain_calc_hwirq(arg->msi_dev, desc);
 }
+EXPORT_SYMBOL_GPL(pci_msi_set_desc);
 
 static struct msi_domain_ops pci_msi_domain_ops = {
 	.get_hwirq	= pci_msi_get_hwirq,
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 861bc59..908cb37 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -29,6 +29,7 @@ struct apic_chip_data {
 };
 
 struct irq_domain *x86_vector_domain;
+EXPORT_SYMBOL_GPL(x86_vector_domain);
 static DEFINE_RAW_SPINLOCK(vector_lock);
 static cpumask_var_t vector_cpumask;
 static struct irq_chip lapic_controller;
@@ -66,6 +67,7 @@ struct irq_cfg *irqd_cfg(struct irq_data *irq_data)
 
 	return data ? &data->cfg : NULL;
 }
+EXPORT_SYMBOL_GPL(irqd_cfg);
 
 struct irq_cfg *irq_cfg(unsigned int irq)
 {
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7eaa4c8..7a0df3f 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -257,6 +257,7 @@ void pci_msi_mask_irq(struct irq_data *data)
 {
 	msi_set_mask_bit(data, 1);
 }
+EXPORT_SYMBOL_GPL(pci_msi_mask_irq);
 
 /**
  * pci_msi_unmask_irq - Generic irq chip callback to unmask PCI/MSI interrupts
@@ -266,6 +267,7 @@ void pci_msi_unmask_irq(struct irq_data *data)
 {
 	msi_set_mask_bit(data, 0);
 }
+EXPORT_SYMBOL_GPL(pci_msi_unmask_irq);
 
 void default_restore_msi_irqs(struct pci_dev *dev)
 {
@@ -1126,6 +1128,7 @@ struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
 {
 	return to_pci_dev(desc->dev);
 }
+EXPORT_SYMBOL(msi_desc_to_pci_dev);
 
 void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
 {
@@ -1285,6 +1288,7 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 	domain->bus_token = DOMAIN_BUS_PCI_MSI;
 	return domain;
 }
+EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
 
 /**
  * pci_msi_domain_alloc_irqs - Allocate interrupts for @dev in @domain
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 05e29de..5797909 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -950,6 +950,7 @@ void irq_chip_ack_parent(struct irq_data *data)
 	data = data->parent_data;
 	data->chip->irq_ack(data);
 }
+EXPORT_SYMBOL_GPL(irq_chip_ack_parent);
 
 /**
  * irq_chip_mask_parent - Mask the parent interrupt
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 22aa961..aa6ac44 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -60,6 +60,7 @@ struct fwnode_handle *irq_domain_alloc_fwnode(void *data)
 	fwid->fwnode.type = FWNODE_IRQCHIP;
 	return &fwid->fwnode;
 }
+EXPORT_SYMBOL_GPL(irq_domain_alloc_fwnode);
 
 /**
  * irq_domain_free_fwnode - Free a non-OF-backed fwnode_handle
@@ -77,6 +78,7 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode)
 	kfree(fwid->name);
 	kfree(fwid);
 }
+EXPORT_SYMBOL_GPL(irq_domain_free_fwnode);
 
 /**
  * __irq_domain_add() - Allocate a new irq_domain data structure
@@ -1013,6 +1015,7 @@ struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(irq_domain_get_irq_data);
 
 /**
  * irq_domain_set_hwirq_and_chip - Set hwirq and irqchip of @virq at @domain
@@ -1343,6 +1346,7 @@ struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
 
 	return (irq_data && irq_data->domain == domain) ? irq_data : NULL;
 }
+EXPORT_SYMBOL_GPL(irq_domain_get_irq_data);
 
 /**
  * irq_domain_set_info - Set the complete data for a @virq in @domain
-- 
1.9.1

