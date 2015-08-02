Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:28183 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486AbbHBBGd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 1 Aug 2015 21:06:33 -0400
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	linux-pci@vger.kernel.org, bhelgaas@google.com, tglx@linutronix.de
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH 3/4] drivers:x86:pci: Make it possible to implement a PCI MSI IRQ Domain in a module.
Date: Sun,  2 Aug 2015 00:54:48 +0000
Message-Id: <1438476889-19220-4-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1438476889-19220-1-git-send-email-jakeo@microsoft.com>
References: <1438476889-19220-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

The Linux kernel already has the concept of IRQ domain, wherein a component
can expose a set of IRQs which are managed by a particular interrupt controller
chip or other subsystem.  The PCI driver exposes the notion of an IRQ domain
for Message-Signaled Interrupts (MSI) from PCI Express devices.  This patch
exposes the functions which are necessary to do this within a module, rather
than just linked into the kernel itself.

I felt it made more sense to deliver an MSI IRQ domain as a module both so that
the code wouldn't be loaded except when needed and also because the driver
which needs this (which is the next patch in this series) is a module and itself
depends on another module.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 arch/x86/kernel/apic/vector.c | 2 ++
 drivers/pci/msi.c             | 1 +
 kernel/irq/chip.c             | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index f47069e..67f7e68 100644
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
index 566de05..b118be1 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1276,6 +1276,7 @@ struct irq_domain *pci_msi_create_irq_domain(struct device_node *node,
 
 	return msi_create_irq_domain(node, info, parent);
 }
+EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
 
 /**
  * pci_msi_domain_alloc_irqs - Allocate interrupts for @dev in @domain
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 76f199d..3c82c44 100644
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

