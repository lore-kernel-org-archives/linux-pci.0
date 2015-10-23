Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36220 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbbJWFFv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:05:51 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 09/29] x86/pci: Pass pin into pcibios_lookup_irq rather than look it up
Date: Fri, 23 Oct 2015 06:03:42 +0100
Message-Id: <1445576642-29624-10-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pcibios_lookup_irq currently looks up the pci interrupt pin manually.
However all callers now have that information stored already.
Therefore pass the pin in rather than look it up.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 arch/x86/pci/irq.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 15c507b..7032798 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -876,9 +876,8 @@ static struct irq_info *pirq_get_info(struct pci_dev *dev)
 	return NULL;
 }
 
-static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
+static int pcibios_lookup_irq(struct pci_dev *dev, u8 pin, int assign)
 {
-	u8 pin;
 	struct irq_info *info;
 	int i, pirq, newirq;
 	int irq = 0;
@@ -888,7 +887,6 @@ static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
 	char *msg = NULL;
 
 	/* Find IRQ pin */
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (!pin) {
 		dev_dbg(&dev->dev, "no interrupt pin\n");
 		return 0;
@@ -1049,7 +1047,7 @@ int pcibios_fixup_irq(struct pci_dev *dev, u8 pin)
 	/*
 	 * Still no IRQ? Try to lookup one...
 	 */
-	if (!irq && pcibios_lookup_irq(dev, 0))
+	if (!irq && pcibios_lookup_irq(dev, pin, 0))
 		irq = dev->irq;
 
 	return irq;
@@ -1206,7 +1204,7 @@ static int pirq_enable_irq(struct pci_dev *dev)
 	u8 pin = 0;
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
-	if (pin && !pcibios_lookup_irq(dev, 1)) {
+	if (pin && !pcibios_lookup_irq(dev, pin, 1)) {
 		char *msg = "";
 
 		if (!io_apic_assign_pci_irqs && dev->irq)
-- 
2.6.2

