Return-Path: <linux-kernel-owner@vger.kernel.org>
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	linux-pci@vger.kernel.org, bhelgaas@google.com, tglx@linutronix.de
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v2 07/12] drivers:x86:pci: Make it possible to implement a PCI MSI IRQ Domain in a module.
Date: Fri, 11 Sep 2015 00:01:06 +0000
Message-Id: <1441929670-10058-8-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
References: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

The Linux kernel already has the concept of IRQ domain, wherein a component
can expose a set of IRQs which are managed by a particular interrupt controller
chip or other subsystem.  The PCI driver exposes the notion of an IRQ domain
for Message-Signaled Interrupts (MSI) from PCI Express devices.  This patch
exposes the functions which are necessary for making an MSI IRQ domain within
a module.

The same goal could be accomplished by building an MSI IRQ domain for Hyper-V
into the kernel itself, but this would have required pulling in a lot of other
code which currently exists in modules, and it seemed cleaner to avoid that.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 arch/x86/include/asm/msi.h    | 4 ++++
 arch/x86/kernel/apic/msi.c    | 5 +++--
 arch/x86/kernel/apic/vector.c | 2 ++
 drivers/pci/msi.c             | 2 ++
 kernel/irq/chip.c             | 1 +
 5 files changed, 12 insertions(+), 2 deletions(-)

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
index 1bbd0fe..b16d915 100644
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
index c7ad8ce..1aaa26d 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1119,6 +1119,7 @@ struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
 {
 	return to_pci_dev(desc->dev);
 }
+EXPORT_SYMBOL(msi_desc_to_pci_dev);
 
 void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
 {
@@ -1274,6 +1275,7 @@ struct irq_domain *pci_msi_create_irq_domain(struct device_node *node,
 	domain->bus_token = DOMAIN_BUS_PCI_MSI;
 	return domain;
 }
+EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
 
 /**
  * pci_msi_domain_alloc_irqs - Allocate interrupts for @dev in @domain
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 6e40a95..b0d9ecd 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -935,6 +935,7 @@ void irq_chip_ack_parent(struct irq_data *data)
 	data = data->parent_data;
 	data->chip->irq_ack(data);
 }
+EXPORT_SYMBOL_GPL(irq_chip_ack_parent);
 
 /**
  * irq_chip_mask_parent - Mask the parent interrupt
-- 
1.9.1

