Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36227 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbbJWFFx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:05:53 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 11/29] powerpc/pci: Defer IRQ assignment to device enable time
Date: Fri, 23 Oct 2015 06:03:44 +0100
Message-Id: <1445576642-29624-12-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The powerpc PCI init code is currently initialising PCI device IRQ during
the boot time pcibios phase. This results in devices which are connected
after boot time not being asigned IRQs which can cause various problems.

This patch as part of its set fixes this be moving the IRQ initialisation
into the PCI device enable code path so that it is run for boot time and
hot-plugged devices alike.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 arch/powerpc/kernel/pci-common.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 7587b2a..4189f50 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -231,7 +231,7 @@ struct pci_controller* pci_find_hose_for_OF_device(struct device_node* node)
  * If the interrupt is used, then gets the interrupt line from the
  * openfirmware and sets it in the pci_dev and pci_config line.
  */
-static int pci_read_irq_line(struct pci_dev *pci_dev)
+static int pci_read_irq_line(struct pci_dev *pci_dev, u8 pin)
 {
 	struct of_phandle_args oirq;
 	unsigned int virq;
@@ -243,7 +243,7 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
 #endif
 	/* Try to get a mapping from the device-tree */
 	if (of_irq_parse_pci(pci_dev, &oirq)) {
-		u8 line, pin;
+		u8 line;
 
 		/* If that fails, lets fallback to what is in the config
 		 * space and map that through the default controller. We
@@ -252,10 +252,6 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
 		 * either provide a proper interrupt tree or don't use this
 		 * function.
 		 */
-		if (pci_read_config_byte(pci_dev, PCI_INTERRUPT_PIN, &pin))
-			return -1;
-		if (pin == 0)
-			return -1;
 		if (pci_read_config_byte(pci_dev, PCI_INTERRUPT_LINE, &line) ||
 		    line == 0xff || line == 0) {
 			return -1;
@@ -280,9 +276,16 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
 
 	pr_debug(" Mapped to linux irq %d\n", virq);
 
-	pci_dev->irq = virq;
+	return virq;
+}
 
-	return 0;
+static int pci_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	/* Read default IRQs and fixup if necessary */
+	dev->irq = pci_read_irq_line(dev, pin);
+	if (ppc_md.pci_irq_fixup)
+		ppc_md.pci_irq_fixup(dev);
+	return dev->irq;
 }
 
 /*
@@ -784,6 +787,7 @@ int pci_proc_domain(struct pci_bus *bus)
 
 int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
+	bridge->map_irq = pci_map_irq;
 	if (ppc_md.pcibios_root_bridge_prepare)
 		return ppc_md.pcibios_root_bridge_prepare(bridge);
 
@@ -983,11 +987,6 @@ static void pcibios_setup_device(struct pci_dev *dev)
 	phb = pci_bus_to_host(dev->bus);
 	if (phb->controller_ops.dma_dev_setup)
 		phb->controller_ops.dma_dev_setup(dev);
-
-	/* Read default IRQs and fixup if necessary */
-	pci_read_irq_line(dev);
-	if (ppc_md.pci_irq_fixup)
-		ppc_md.pci_irq_fixup(dev);
 }
 
 int pcibios_add_device(struct pci_dev *dev)
-- 
2.6.2

