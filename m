Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:20097 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbaJ0CDQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 26 Oct 2014 22:03:16 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <wangyijing@huawei.com>, <linux-pci@vger.kernel.org>,
	David Vrabel <david.vrabel@citrix.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	<xen-devel@lists.xenproject.org>
Subject: [PATCH 1/3] x86/xen: Introduce a global flag to fix the MSI mask bug
Date: Mon, 27 Oct 2014 10:44:36 +0800
Message-ID: <1414377878-23497-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1414377878-23497-1-git-send-email-wangyijing@huawei.com>
References: <1414377878-23497-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 0e4ccb1505a9 ("PCI: Add x86_msi.msi_mask_irq() and msix_mask_irq()")
fixed MSI mask bug which may cause kernel crash. But the commit
made MSI code complex. Introduce a new global flag "pci_msi_ignore_mask"
to ignore MSI/MSI-X to fix this issue, it's a cleaner solution.
And the commit 0e4ccb1505a9 will be reverted in the later patch.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: David Vrabel <david.vrabel@citrix.com>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: xen-devel@lists.xenproject.org
---
 arch/x86/pci/xen.c  |    2 ++
 drivers/pci/msi.c   |    7 ++++++-
 include/linux/msi.h |    1 +
 3 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 093f5f4..5ef62ed 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -427,6 +427,7 @@ int __init pci_xen_init(void)
 	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
 	x86_msi.msi_mask_irq = xen_nop_msi_mask_irq;
 	x86_msi.msix_mask_irq = xen_nop_msix_mask_irq;
+	pci_msi_ignore_mask = 1;
 #endif
 	return 0;
 }
@@ -508,6 +509,7 @@ int __init pci_xen_initial_domain(void)
 	x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
 	x86_msi.msi_mask_irq = xen_nop_msi_mask_irq;
 	x86_msi.msix_mask_irq = xen_nop_msix_mask_irq;
+	pci_msi_ignore_mask = 1;
 #endif
 	xen_setup_acpi_sci();
 	__acpi_register_gsi = acpi_register_gsi_xen;
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 38511d9..ecb5f54 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -23,6 +23,7 @@
 #include "pci.h"
 
 static int pci_msi_enable = 1;
+int pci_msi_ignore_mask;
 
 #define msix_table_size(flags)	((flags & PCI_MSIX_FLAGS_QSIZE) + 1)
 
@@ -166,7 +167,7 @@ u32 default_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
 {
 	u32 mask_bits = desc->masked;
 
-	if (!desc->msi_attrib.maskbit)
+	if (pci_msi_ignore_mask || !desc->msi_attrib.maskbit)
 		return 0;
 
 	mask_bits &= ~mask;
@@ -198,6 +199,10 @@ u32 default_msix_mask_irq(struct msi_desc *desc, u32 flag)
 	u32 mask_bits = desc->masked;
 	unsigned offset = desc->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE +
 						PCI_MSIX_ENTRY_VECTOR_CTRL;
+
+	if (pci_msi_ignore_mask)
+		return 0;
+
 	mask_bits &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
 	if (flag)
 		mask_bits |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 44f4746..86dc501 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -10,6 +10,7 @@ struct msi_msg {
 	u32	data;		/* 16 bits of msi message data */
 };
 
+extern int pci_msi_ignore_mask;
 /* Helper functions */
 struct irq_data;
 struct msi_desc;
-- 
1.7.1

