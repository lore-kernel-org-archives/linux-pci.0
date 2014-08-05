Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:51758 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754005AbaHEQME (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Aug 2014 12:12:04 -0400
Received: by mail-wi0-f171.google.com with SMTP id hi2so7292539wib.16
        for <linux-pci@vger.kernel.org>; Tue, 05 Aug 2014 09:12:01 -0700 (PDT)
From: matthew_minter@xyratex.com
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: matthew_minter <matthew_minter@xyratex.com>
Subject: [PATCH 05/22] Added (untested) support to frv architecture to accomodate new irq init code
Date: Tue,  5 Aug 2014 17:11:06 +0100
Message-Id: <1407255083-9356-6-git-send-email-matthew_minter@xyratex.com>
In-Reply-To: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
References: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: matthew_minter <matthew_minter@xyratex.com>

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
2.0.4

