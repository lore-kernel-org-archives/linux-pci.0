Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Keith Busch <keith.busch@intel.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-pci@vger.kernel.org
Subject: [RFC PATCH 1/2] x86: PCI bus specific MSI operations
Date: Thu, 27 Aug 2015 16:39:05 -0600
Message-Id: <1440715146-16578-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1440715146-16578-1-git-send-email-keith.busch@intel.com>
References: <1440715146-16578-1-git-send-email-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds struct x86_msi_ops to x86's PCI sysdata. This gives a
host bridge driver the option to provide alternate MSI Data Register
and MSI-X Table Entry programming for devices in PCI domains that do
not subscribe to usual "IOAPIC" format.

Signed-off-by: Keith Busch <keith.busch@intel.com>
CC: Bryan Veal <bryan.e.veal@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: x86@kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-pci@vger.kernel.org
---
 arch/x86/include/asm/pci.h |    3 +++
 arch/x86/kernel/x86_init.c |   19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 4625943..98f3802 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -20,6 +20,9 @@ struct pci_sysdata {
 #ifdef CONFIG_X86_64
 	void		*iommu;		/* IOMMU private data */
 #endif
+#ifdef CONFIG_PCI_MSI
+	struct x86_msi_ops *msi_ops;
+#endif
 };
 
 extern int pci_routeirq;
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 3839628..416de84 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -118,21 +118,40 @@ struct x86_msi_ops x86_msi = {
 /* MSI arch specific hooks */
 int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
+	struct pci_sysdata *sysdata = dev->bus->sysdata;
+
+	if (sysdata && sysdata->msi_ops && sysdata->msi_ops->setup_msi_irqs)
+		return sysdata->msi_ops->setup_msi_irqs(dev, nvec, type);
 	return x86_msi.setup_msi_irqs(dev, nvec, type);
 }
 
 void arch_teardown_msi_irqs(struct pci_dev *dev)
 {
+	struct pci_sysdata *sysdata = dev->bus->sysdata;
+
+	if (sysdata && sysdata->msi_ops && sysdata->msi_ops->teardown_msi_irqs)
+		return sysdata->msi_ops->teardown_msi_irqs(dev);
 	x86_msi.teardown_msi_irqs(dev);
 }
 
 void arch_teardown_msi_irq(unsigned int irq)
 {
+	struct msi_desc *desc =  irq_get_msi_desc(irq);
+	struct pci_sysdata *sysdata = NULL;
+
+	if (desc)
+		sysdata = desc->dev->bus->sysdata;
+	if (sysdata && sysdata->msi_ops && sysdata->msi_ops->teardown_msi_irq)
+		return sysdata->msi_ops->teardown_msi_irq(irq);
 	x86_msi.teardown_msi_irq(irq);
 }
 
 void arch_restore_msi_irqs(struct pci_dev *dev)
 {
+	struct pci_sysdata *sysdata = dev->bus->sysdata;
+
+	if (sysdata && sysdata->msi_ops && sysdata->msi_ops->restore_msi_irqs)
+		return sysdata->msi_ops->restore_msi_irqs(dev);
 	x86_msi.restore_msi_irqs(dev);
 }
 #endif
-- 
1.7.10.4

