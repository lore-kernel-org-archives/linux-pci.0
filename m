Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:13643 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbaJ0CEf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 26 Oct 2014 22:04:35 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <wangyijing@huawei.com>, <linux-pci@vger.kernel.org>,
	David Vrabel <david.vrabel@citrix.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	<xen-devel@lists.xenproject.org>
Subject: [PATCH 2/3] x86/xen: Revert "PCI: Add x86_msi.msi_mask_irq() and msix_mask_irq()"
Date: Mon, 27 Oct 2014 10:44:37 +0800
Message-ID: <1414377878-23497-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1414377878-23497-1-git-send-email-wangyijing@huawei.com>
References: <1414377878-23497-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 0e4ccb1505a9 ("PCI: Add x86_msi.msi_mask_irq() and msix_mask_irq()")
introduced two __weak arch functions arch_msix_mask_irq() and
arch_msi_mask_irq() to work around a bug when running xen in x86.
These two functions made msi code more complex. We have introduced
a global flag to ignore MSI mask to fix the issue in previous patch,
so we can revert the commit safely. This patch is also preparation
to use MSI chip framework instead of weak arch MSI functions in all
platforms. Because s390 MSI also use default_msi_mask_irq() functions
introduced by commit 0e4ccb1505a9. We keep default_msi_mask_irq()
and default_msix_mask_irq() temporarily. They will be removed in later
patch.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: David Vrabel <david.vrabel@citrix.com>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: xen-devel@lists.xenproject.org
---
 arch/x86/include/asm/x86_init.h |    3 ---
 arch/x86/kernel/x86_init.c      |   10 ----------
 arch/x86/pci/xen.c              |   13 +------------
 drivers/pci/msi.c               |   22 ++++++----------------
 include/linux/msi.h             |    6 ++++--
 5 files changed, 11 insertions(+), 43 deletions(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index e45e4da..f58a9c7 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -172,7 +172,6 @@ struct x86_platform_ops {
 
 struct pci_dev;
 struct msi_msg;
-struct msi_desc;
 
 struct x86_msi_ops {
 	int (*setup_msi_irqs)(struct pci_dev *dev, int nvec, int type);
@@ -183,8 +182,6 @@ struct x86_msi_ops {
 	void (*teardown_msi_irqs)(struct pci_dev *dev);
 	void (*restore_msi_irqs)(struct pci_dev *dev);
 	int  (*setup_hpet_msi)(unsigned int irq, unsigned int id);
-	u32 (*msi_mask_irq)(struct msi_desc *desc, u32 mask, u32 flag);
-	u32 (*msix_mask_irq)(struct msi_desc *desc, u32 flag);
 };
 
 struct IO_APIC_route_entry;
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index e48b674..234b072 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -116,8 +116,6 @@ struct x86_msi_ops x86_msi = {
 	.teardown_msi_irqs	= default_teardown_msi_irqs,
 	.restore_msi_irqs	= default_restore_msi_irqs,
 	.setup_hpet_msi		= default_setup_hpet_msi,
-	.msi_mask_irq		= default_msi_mask_irq,
-	.msix_mask_irq		= default_msix_mask_irq,
 };
 
 /* MSI arch specific hooks */
@@ -140,14 +138,6 @@ void arch_restore_msi_irqs(struct pci_dev *dev)
 {
 	x86_msi.restore_msi_irqs(dev);
 }
-u32 arch_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
-{
-	return x86_msi.msi_mask_irq(desc, mask, flag);
-}
-u32 arch_msix_mask_irq(struct msi_desc *desc, u32 flag)
-{
-	return x86_msi.msix_mask_irq(desc, flag);
-}
 #endif
 
 struct x86_io_apic_ops x86_io_apic_ops = {
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 5ef62ed..466b978 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -394,14 +394,7 @@ static void xen_teardown_msi_irq(unsigned int irq)
 {
 	xen_destroy_irq(irq);
 }
-static u32 xen_nop_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
-{
-	return 0;
-}
-static u32 xen_nop_msix_mask_irq(struct msi_desc *desc, u32 flag)
-{
-	return 0;
-}
+
 #endif
 
 int __init pci_xen_init(void)
@@ -425,8 +418,6 @@ int __init pci_xen_init(void)
 	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
 	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
 	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
-	x86_msi.msi_mask_irq = xen_nop_msi_mask_irq;
-	x86_msi.msix_mask_irq = xen_nop_msix_mask_irq;
 	pci_msi_ignore_mask = 1;
 #endif
 	return 0;
@@ -507,8 +498,6 @@ int __init pci_xen_initial_domain(void)
 	x86_msi.setup_msi_irqs = xen_initdom_setup_msi_irqs;
 	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
 	x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
-	x86_msi.msi_mask_irq = xen_nop_msi_mask_irq;
-	x86_msi.msix_mask_irq = xen_nop_msix_mask_irq;
 	pci_msi_ignore_mask = 1;
 #endif
 	xen_setup_acpi_sci();
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index ecb5f54..805c7d8 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -163,7 +163,7 @@ static inline __attribute_const__ u32 msi_mask(unsigned x)
  * reliably as devices without an INTx disable bit will then generate a
  * level IRQ which will never be cleared.
  */
-u32 default_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
+u32 __msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
 {
 	u32 mask_bits = desc->masked;
 
@@ -177,14 +177,9 @@ u32 default_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
 	return mask_bits;
 }
 
-__weak u32 arch_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
-{
-	return default_msi_mask_irq(desc, mask, flag);
-}
-
 static void msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
 {
-	desc->masked = arch_msi_mask_irq(desc, mask, flag);
+	desc->masked = __msi_mask_irq(desc, mask, flag);
 }
 
 /*
@@ -194,7 +189,7 @@ static void msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
  * file.  This saves a few milliseconds when initialising devices with lots
  * of MSI-X interrupts.
  */
-u32 default_msix_mask_irq(struct msi_desc *desc, u32 flag)
+u32 __msix_mask_irq(struct msi_desc *desc, u32 flag)
 {
 	u32 mask_bits = desc->masked;
 	unsigned offset = desc->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE +
@@ -211,14 +206,9 @@ u32 default_msix_mask_irq(struct msi_desc *desc, u32 flag)
 	return mask_bits;
 }
 
-__weak u32 arch_msix_mask_irq(struct msi_desc *desc, u32 flag)
-{
-	return default_msix_mask_irq(desc, flag);
-}
-
 static void msix_mask_irq(struct msi_desc *desc, u32 flag)
 {
-	desc->masked = arch_msix_mask_irq(desc, flag);
+	desc->masked = __msix_mask_irq(desc, flag);
 }
 
 static void msi_set_mask_bit(struct irq_data *data, u32 flag)
@@ -873,7 +863,7 @@ void pci_msi_shutdown(struct pci_dev *dev)
 	/* Return the device with MSI unmasked as initial states */
 	mask = msi_mask(desc->msi_attrib.multi_cap);
 	/* Keep cached state to be restored */
-	arch_msi_mask_irq(desc, mask, ~mask);
+	__msi_mask_irq(desc, mask, ~mask);
 
 	/* Restore dev->irq to its default pin-assertion irq */
 	dev->irq = desc->msi_attrib.default_irq;
@@ -971,7 +961,7 @@ void pci_msix_shutdown(struct pci_dev *dev)
 	/* Return the device with MSI-X masked as initial states */
 	list_for_each_entry(entry, &dev->msi_list, list) {
 		/* Keep cached states to be restored */
-		arch_msix_mask_irq(entry, 1);
+		__msix_mask_irq(entry, 1);
 	}
 
 	msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 86dc501..f6630a5 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -22,6 +22,8 @@ void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void read_msi_msg(unsigned int irq, struct msi_msg *msg);
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
 void write_msi_msg(unsigned int irq, struct msi_msg *msg);
+u32 __msix_mask_irq(struct msi_desc *desc, u32 flag);
+u32 __msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag);
 
 struct msi_desc {
 	struct {
@@ -62,8 +64,8 @@ void arch_restore_msi_irqs(struct pci_dev *dev);
 
 void default_teardown_msi_irqs(struct pci_dev *dev);
 void default_restore_msi_irqs(struct pci_dev *dev);
-u32 default_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag);
-u32 default_msix_mask_irq(struct msi_desc *desc, u32 flag);
+#define default_msi_mask_irq  __msi_mask_irq
+#define default_msix_mask_irq  __msix_mask_irq
 
 struct msi_chip {
 	struct module *owner;
-- 
1.7.1

