Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([69.164.217.139]:56352 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752395AbaJBEID (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Oct 2014 00:08:03 -0400
From: matt@masarand.com
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Matthew Minter <matt@masarand.com>
Subject: [PATCH 08/18] Delayed frv setup of PCI IRQs to bus scan time
Date: Thu,  2 Oct 2014 05:07:36 +0100
Message-Id: <1412222866-21068-9-git-send-email-matt@masarand.com>
In-Reply-To: <1412222866-21068-1-git-send-email-matt@masarand.com>
References: <1412222866-21068-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Matthew Minter <matt@masarand.com>

PCI IRQs are being assigned during the frv pcibios phase. This causes
devices which are not connected at boot but are later hot-plugged
to not receive an IRQ. This patch set causes the pcibios to instead
register an IRQ assignment function which is called during the enable
device path to apply to all devices.

Signed-off-by: Matthew Minter <matt@masarand.com>

---
 arch/frv/mb93090-mb00/pci-frv.h |  1 -
 arch/frv/mb93090-mb00/pci-irq.c | 28 +++++++++++++++++-----------
 arch/frv/mb93090-mb00/pci-vdk.c |  1 -
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/frv/mb93090-mb00/pci-frv.h b/arch/frv/mb93090-mb00/pci-frv.h
index a7e487fe..492b56d 100644
--- a/arch/frv/mb93090-mb00/pci-frv.h
+++ b/arch/frv/mb93090-mb00/pci-frv.h
@@ -36,5 +36,4 @@ extern struct pci_ops *__nongpreldata pci_root_ops;
 extern unsigned int pcibios_irq_mask;
 
 void pcibios_irq_init(void);
-void pcibios_fixup_irqs(void);
 void pcibios_enable_irq(struct pci_dev *dev);
diff --git a/arch/frv/mb93090-mb00/pci-irq.c b/arch/frv/mb93090-mb00/pci-irq.c
index 1c35c93..3463e30 100644
--- a/arch/frv/mb93090-mb00/pci-irq.c
+++ b/arch/frv/mb93090-mb00/pci-irq.c
@@ -40,19 +40,25 @@ void __init pcibios_irq_init(void)
 {
 }
 
-void __init pcibios_fixup_irqs(void)
+int pcibios_map_irq(struct pci_dev *dev, uint8_t slot, uint8_t pin)
 {
-	struct pci_dev *dev = NULL;
-	uint8_t line, pin;
-
-	for_each_pci_dev(dev) {
-		pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
-		if (pin) {
-			dev->irq = pci_bus0_irq_routing[PCI_SLOT(dev->devfn)][pin - 1];
-			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
-		}
-		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &line);
+	uint8_t line;
+	int irq;
+
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+	if (pin) {
+		irq = pci_bus0_irq_routing[PCI_SLOT(dev->devfn)][pin - 1];
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 	}
+	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &line);
+	return irq;
+}
+
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->swizzle_irq = NULL;
+	bridge->map_irq = pcibios_map_irq;
+	return 0;
 }
 
 void pcibios_enable_irq(struct pci_dev *dev)
diff --git a/arch/frv/mb93090-mb00/pci-vdk.c b/arch/frv/mb93090-mb00/pci-vdk.c
index efa5d65..86657a7 100644
--- a/arch/frv/mb93090-mb00/pci-vdk.c
+++ b/arch/frv/mb93090-mb00/pci-vdk.c
@@ -386,7 +386,6 @@ int __init pcibios_init(void)
 	pci_scan_root_bus(NULL, 0, pci_root_ops, NULL, &resources);
 
 	pcibios_irq_init();
-	pcibios_fixup_irqs();
 	pcibios_resource_survey();
 
 	return 0;
-- 
2.1.0

