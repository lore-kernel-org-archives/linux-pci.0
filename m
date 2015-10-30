Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:11681 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932949AbbJ3VMD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2015 17:12:03 -0400
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	tglx@redhat.com, haiyangz@microsoft.com, marc.zyngier@arm.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v5 3/7] PCI: Make it possible to implement a PCI MSI IRQ Domain in a module.
Date: Fri, 30 Oct 2015 21:11:11 +0000
Message-Id: <1446239475-49480-4-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1446239475-49480-1-git-send-email-jakeo@microsoft.com>
References: <1446239475-49480-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

The Linux kernel already has the concpet of IRQ domain, whereing a component
can expose a set of IRQs which are managed by a particular interrupt controller
chip or other subsystem. The PCI driver exposes the notion of an IRQ domain
for Message-Signaled Interrupts (MSI) from PCI Express devices. This patch
exposes the functions which are necessary for making an MSI IRQ domain within
a module.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 arch/x86/include/asm/msi.h    | 4 ++++
 arch/x86/kernel/apic/msi.c    | 5 +++--
 arch/x86/kernel/apic/vector.c | 2 ++
 drivers/pci/msi.c             | 4 ++++
 kernel/irq/chip.c             | 1 +
 kernel/irq/irqdomain.c        | 2 ++
 6 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/msi.h b/arch/x86/include/asm/msi.h
index 93724cc..e8b7924 100644
--- a/arch/x86/include/asm/msi.h
+++ b/arch/x86/include/asm/msi.h
@@ -1,7 +1,11 @@
 #ifndef _ASM_X86_MSI_H
 #define _ASM_X86_MSI_H
 #include <asm/hw_irq.h>
+#include <asm/irqdomain.h>
 
 typedef struct irq_alloc_info msi_alloc_info_t;
 
+int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
+		    msi_alloc_info_t *arg);
+
 #endif /* _ASM_X86_MSI_H */
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 5f1feb6..bdb28fc 100644
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
@@ -113,6 +113,7 @@ static int pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_msi_prepare);
 
 static void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
 {
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 836d11b..f3ac5e1 100644
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
index 53e4632..3915a99 100644
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
index 1520645..2414775 100644
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
index 22aa961..174d7e0 100644
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
-- 
1.9.1

