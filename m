Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36248 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbbJWFF6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:05:58 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 16/29] frv/PCI: Defer IRQ assignment to device enable time
Date: Fri, 23 Oct 2015 06:03:49 +0100
Message-Id: <1445576642-29624-17-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI IRQs are being assigned during the frv pcibios phase. This causes
devices which are not connected at boot but are later hot-plugged
to not receive an IRQ. This patch set causes the pcibios to instead
register an IRQ assignment function which is called during the enable
device path to apply to all devices.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 arch/frv/mb93090-mb00/pci-frv.h |  1 -
 arch/frv/mb93090-mb00/pci-irq.c | 24 ++++++++++++------------
 arch/frv/mb93090-mb00/pci-vdk.c |  1 -
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/frv/mb93090-mb00/pci-frv.h b/arch/frv/mb93090-mb00/pci-frv.h
index d51992f..1537700 100644
--- a/arch/frv/mb93090-mb00/pci-frv.h
+++ b/arch/frv/mb93090-mb00/pci-frv.h
@@ -28,5 +28,4 @@ extern struct pci_ops *__nongpreldata pci_root_ops;
 extern unsigned int pcibios_irq_mask;
 
 void pcibios_irq_init(void);
-void pcibios_fixup_irqs(void);
 void pcibios_enable_irq(struct pci_dev *dev);
diff --git a/arch/frv/mb93090-mb00/pci-irq.c b/arch/frv/mb93090-mb00/pci-irq.c
index 1c35c93..2fde211 100644
--- a/arch/frv/mb93090-mb00/pci-irq.c
+++ b/arch/frv/mb93090-mb00/pci-irq.c
@@ -40,19 +40,19 @@ void __init pcibios_irq_init(void)
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
-	}
+	int irq;
+
+	irq = pci_bus0_irq_routing[PCI_SLOT(dev->devfn)][pin - 1];
+	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
+	return irq;
+}
+
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->map_irq = pcibios_map_irq;
+	return 0;
 }
 
 void pcibios_enable_irq(struct pci_dev *dev)
diff --git a/arch/frv/mb93090-mb00/pci-vdk.c b/arch/frv/mb93090-mb00/pci-vdk.c
index f211839..22d59ed 100644
--- a/arch/frv/mb93090-mb00/pci-vdk.c
+++ b/arch/frv/mb93090-mb00/pci-vdk.c
@@ -387,7 +387,6 @@ int __init pcibios_init(void)
 	bus = pci_scan_root_bus(NULL, 0, pci_root_ops, NULL, &resources);
 
 	pcibios_irq_init();
-	pcibios_fixup_irqs();
 	pcibios_resource_survey();
 	if (!bus)
 		return 0;
-- 
2.6.2

