Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39713 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753028AbbDMGKi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 13 Apr 2015 02:10:38 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dimitri Sivanich <sivanich@sgi.com>, x86@kernel.org,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Cohen <david.a.cohen@linux.intel.com>,
	Sander Eikelenboom <linux@eikelenboom.it>,
	David Vrabel <david.vrabel@citrix.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch Part1 v8 04/37] x86/MSI: Use new irqdomain interfaces to allocate/free IRQ
Date: Mon, 13 Apr 2015 14:11:26 +0800
Message-Id: <1428905519-23704-5-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1428905519-23704-1-git-send-email-jiang.liu@linux.intel.com>
References: <1428905519-23704-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use new irqdomain interfaces to allocate/free IRQ for PCI MSI, so we
could kill GENERIC_IRQ_LEGACY_ALLOC_HWIRQ later.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Link: http://lkml.kernel.org/r/1416894816-23245-5-git-send-email-jiang.liu@linux.intel.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/msi.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index d6ba2d660dc5..76cc2c902176 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -14,6 +14,7 @@
 #include <linux/dmar.h>
 #include <linux/hpet.h>
 #include <linux/msi.h>
+#include <linux/irqdomain.h>
 #include <asm/msidef.h>
 #include <asm/hpet.h>
 #include <asm/hw_irq.h>
@@ -146,23 +147,20 @@ int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc,
 int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
 	struct msi_desc *msidesc;
-	unsigned int irq;
-	int node, ret;
+	int irq, ret;
 
 	/* Multiple MSI vectors only supported with interrupt remapping */
 	if (type == PCI_CAP_ID_MSI && nvec > 1)
 		return 1;
 
-	node = dev_to_node(&dev->dev);
-
 	list_for_each_entry(msidesc, &dev->msi_list, list) {
-		irq = irq_alloc_hwirq(node);
-		if (!irq)
+		irq = irq_domain_alloc_irqs(NULL, 1, NUMA_NO_NODE, NULL);
+		if (irq <= 0)
 			return -ENOSPC;
 
 		ret = setup_msi_irq(dev, msidesc, irq, 0);
 		if (ret < 0) {
-			irq_free_hwirq(irq);
+			irq_domain_free_irqs(irq, 1);
 			return ret;
 		}
 
@@ -172,7 +170,7 @@ int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 
 void native_teardown_msi_irq(unsigned int irq)
 {
-	irq_free_hwirq(irq);
+	irq_domain_free_irqs(irq, 1);
 }
 
 #ifdef CONFIG_DMAR_TABLE
-- 
1.7.10.4

