Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36266 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300AbbJWFGC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:06:02 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 20/29] mn10300: Defer PCI IRQ assignment to device enable time
Date: Fri, 23 Oct 2015 06:03:53 +0100
Message-Id: <1445576642-29624-21-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI IRQs are being assigned during pcibios_irq_init currently, this causes
a problem by which hot-plug devices connected after boot will not recieve
an IRQ, this patch-set fixes this by registering the IRQ assignment
functions at boot, to then be called later by the device enable code.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 arch/mn10300/unit-asb2305/pci-asb2305.h |  5 +----
 arch/mn10300/unit-asb2305/pci-irq.c     | 24 ++++--------------------
 arch/mn10300/unit-asb2305/pci.c         | 11 ++++++-----
 3 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/arch/mn10300/unit-asb2305/pci-asb2305.h b/arch/mn10300/unit-asb2305/pci-asb2305.h
index 96c484b..b7d5526 100644
--- a/arch/mn10300/unit-asb2305/pci-asb2305.h
+++ b/arch/mn10300/unit-asb2305/pci-asb2305.h
@@ -60,9 +60,6 @@ struct irq_routing_table {
 } __attribute__((packed));
 
 extern unsigned int pcibios_irq_mask;
-
-extern void pcibios_irq_init(void);
-extern void pcibios_fixup_irqs(void);
-extern void pcibios_enable_irq(struct pci_dev *dev);
+extern int pci_map_irq(struct pci_dev *, u8 slot, u8 pin);
 
 #endif /* PCI_ASB2305_H */
diff --git a/arch/mn10300/unit-asb2305/pci-irq.c b/arch/mn10300/unit-asb2305/pci-irq.c
index fcb28ce..d7d2ce9 100644
--- a/arch/mn10300/unit-asb2305/pci-irq.c
+++ b/arch/mn10300/unit-asb2305/pci-irq.c
@@ -20,27 +20,11 @@
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
+	dev->irq = XIRQ1;
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &line);
 }
diff --git a/arch/mn10300/unit-asb2305/pci.c b/arch/mn10300/unit-asb2305/pci.c
index 3dfe2d3..37a22a5 100644
--- a/arch/mn10300/unit-asb2305/pci.c
+++ b/arch/mn10300/unit-asb2305/pci.c
@@ -375,14 +375,17 @@ static int __init pcibios_init(void)
 	bus = pci_scan_root_bus(NULL, 0, &pci_direct_ampci, NULL, &resources);
 	if (!bus)
 		return 0;
-
-	pcibios_irq_init();
-	pcibios_fixup_irqs();
 	pcibios_resource_survey();
 	pci_bus_add_devices(bus);
 	return 0;
 }
 
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->map_irq = pci_map_irq;
+	return 0;
+}
+
 arch_initcall(pcibios_init);
 
 char *__init pcibios_setup(char *str)
@@ -400,8 +403,6 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	int err;
 
 	err = pci_enable_resources(dev, mask);
-	if (err == 0)
-		pcibios_enable_irq(dev);
 	return err;
 }
 
-- 
2.6.2

