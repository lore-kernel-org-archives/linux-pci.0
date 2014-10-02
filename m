Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([69.164.217.139]:56359 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752383AbaJBEIG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Oct 2014 00:08:06 -0400
From: matt@masarand.com
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Matthew Minter <matt@masarand.com>
Subject: [PATCH 12/18] Delayed mn10300 setup of PCI IRQs to bus scan time
Date: Thu,  2 Oct 2014 05:07:40 +0100
Message-Id: <1412222866-21068-13-git-send-email-matt@masarand.com>
In-Reply-To: <1412222866-21068-1-git-send-email-matt@masarand.com>
References: <1412222866-21068-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Matthew Minter <matt@masarand.com>


PCI IRQs are being asigned during pcibios_irq_init currently, this causes
a problem by which hot-plug devices connected after boot will not recieve
an IRQ, this patch-set fixes this by registering the IRQ assignment
functions at boot, to then be called later by the device enable code.

Signed-off-by: Matthew Minter <matt@masarand.com>

---
 arch/mn10300/unit-asb2305/pci-asb2305.h |  5 +----
 arch/mn10300/unit-asb2305/pci-irq.c     | 25 +++++--------------------
 arch/mn10300/unit-asb2305/pci.c         | 21 ++++++++-------------
 3 files changed, 14 insertions(+), 37 deletions(-)

diff --git a/arch/mn10300/unit-asb2305/pci-asb2305.h b/arch/mn10300/unit-asb2305/pci-asb2305.h
index 9e17aca..fb520cf 100644
--- a/arch/mn10300/unit-asb2305/pci-asb2305.h
+++ b/arch/mn10300/unit-asb2305/pci-asb2305.h
@@ -67,9 +67,6 @@ struct irq_routing_table {
 } __attribute__((packed));
 
 extern unsigned int pcibios_irq_mask;
-
-extern void pcibios_irq_init(void);
-extern void pcibios_fixup_irqs(void);
-extern void pcibios_enable_irq(struct pci_dev *dev);
+extern int pci_map_irq(struct pci_dev *, u8 slot, u8 pin);
 
 #endif /* PCI_ASB2305_H */
diff --git a/arch/mn10300/unit-asb2305/pci-irq.c b/arch/mn10300/unit-asb2305/pci-irq.c
index fcb28ce..5be6fea 100644
--- a/arch/mn10300/unit-asb2305/pci-irq.c
+++ b/arch/mn10300/unit-asb2305/pci-irq.c
@@ -20,27 +20,12 @@
 #include <asm/smp.h>
 #include "pci-asb2305.h"
 
-void __init pcibios_irq_init(void)
+int pci_map_irq(struct pci_dev *, u8 slot, u8 pin)
 {
-}
-
-void __init pcibios_fixup_irqs(void)
-{
-	struct pci_dev *dev = NULL;
-	u8 line, pin;
+	u8 line;
 
-	for_each_pci_dev(dev) {
-		pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
-		if (pin) {
-			dev->irq = XIRQ1;
-			pci_write_config_byte(dev, PCI_INTERRUPT_LINE,
-					      dev->irq);
-		}
-		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &line);
-	}
-}
-
-void pcibios_enable_irq(struct pci_dev *dev)
-{
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+	dev->irq = XIRQ1;
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &line);
 }
diff --git a/arch/mn10300/unit-asb2305/pci.c b/arch/mn10300/unit-asb2305/pci.c
index 6b4339f..22f8786 100644
--- a/arch/mn10300/unit-asb2305/pci.c
+++ b/arch/mn10300/unit-asb2305/pci.c
@@ -377,13 +377,18 @@ static int __init pcibios_init(void)
 	pci_add_resource_offset(&resources, &pci_ioport_resource, io_offset);
 	pci_add_resource_offset(&resources, &pci_iomem_resource, mem_offset);
 	pci_scan_root_bus(NULL, 0, &pci_direct_ampci, NULL, &resources);
-
-	pcibios_irq_init();
-	pcibios_fixup_irqs();
 	pcibios_resource_survey();
 	return 0;
 }
 
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->swizzle_irq = NULL;
+	bridge->map_irq = pci_map_irq;
+	return 0;
+}
+
+
 arch_initcall(pcibios_init);
 
 char *__init pcibios_setup(char *str)
@@ -396,16 +401,6 @@ char *__init pcibios_setup(char *str)
 	return str;
 }
 
-int pcibios_enable_device(struct pci_dev *dev, int mask)
-{
-	int err;
-
-	err = pci_enable_resources(dev, mask);
-	if (err == 0)
-		pcibios_enable_irq(dev);
-	return err;
-}
-
 /*
  * disable the ethernet chipset
  */
-- 
2.1.0

