Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([69.164.217.139]:56328 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527AbaJBD7Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Oct 2014 23:59:24 -0400
From: matt@masarand.com
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Vality <matt@masarand.com>
Subject: [PATCH 13/18] Delayed sparc setup of PCI IRQs to bus scan time
Date: Thu,  2 Oct 2014 04:50:32 +0100
Message-Id: <1412221837-17452-14-git-send-email-matt@masarand.com>
In-Reply-To: <1412221837-17452-1-git-send-email-matt@masarand.com>
References: <1412221837-17452-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Vality <matt@masarand.com>

Currently sparc allocates PCI IRQs through several different methods
based on device. This is done during the boot stage and faces a draw-back
by which hot-plugged devices will not be allocated an IRQ, this is fixed
by registering IRQ allocation functions for later use during the device
enable path.

---
 arch/sparc/kernel/leon_pci.c | 12 +++++++++++-
 arch/sparc/kernel/pci.c      | 21 +++++++++++++++++----
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
index 899b720..1079eb7 100644
--- a/arch/sparc/kernel/leon_pci.c
+++ b/arch/sparc/kernel/leon_pci.c
@@ -13,6 +13,8 @@
 #include <asm/leon.h>
 #include <asm/leon_pci.h>
 
+int (*leon_pci_map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
+
 /* The LEON architecture does not rely on a BIOS or bootloader to setup
  * PCI for us. The Linux generic routines are used to setup resources,
  * reset values of configuration-space register settings are preserved.
@@ -36,7 +38,7 @@ void leon_pci_init(struct platform_device *ofdev, struct leon_pci_info *info)
 				     &resources);
 	if (root_bus) {
 		/* Setup IRQs of all devices using custom routines */
-		pci_fixup_irqs(pci_common_swizzle, info->map_irq);
+		leon_pci_map_irq = info->map_irq;
 
 		/* Assign devices with resources */
 		pci_assign_unassigned_resources();
@@ -45,6 +47,14 @@ void leon_pci_init(struct platform_device *ofdev, struct leon_pci_info *info)
 	}
 }
 
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->swizzle_irq = pci_common_swizzle;
+	bridge->map_irq = leon_pci_map_irq;
+	return 0;
+}
+
+
 void pcibios_fixup_bus(struct pci_bus *pbus)
 {
 	struct pci_dev *dev;
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index b36365f..7361c52 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -340,10 +340,6 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 	} else {
 		dev->hdr_type = PCI_HEADER_TYPE_NORMAL;
 		dev->rom_base_reg = PCI_ROM_ADDRESS;
-
-		dev->irq = sd->op->archdata.irqs[0];
-		if (dev->irq == 0xffffffff)
-			dev->irq = PCI_IRQ_NONE;
 	}
 
 	pci_parse_of_addrs(sd->op, node, dev);
@@ -356,6 +352,23 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 	return dev;
 }
 
+int pci_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	int irq;
+	struct platform_device *op = of_find_device_by_node(dev->sysdata);
+	irq = op->archdata.irqs[0];
+	if (irq == 0xffffffff)
+		irq = PCI_IRQ_NONE;
+	return irq;
+}
+
+int __weak pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->swizzle_irq = NULL;
+	bridge->map_irq = pci_map_irq;
+	return 0;
+}
+
 static void apb_calc_first_last(u8 map, u32 *first_p, u32 *last_p)
 {
 	u32 idx, first, last;
-- 
2.1.0

