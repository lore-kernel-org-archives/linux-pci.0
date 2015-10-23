Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36271 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303AbbJWFGE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:06:04 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 22/29] sparc/PCI: Defer IRQ assignment to device enable time
Date: Fri, 23 Oct 2015 06:03:55 +0100
Message-Id: <1445576642-29624-23-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently sparc allocates PCI IRQs through several different methods
based on device. This is done during the boot stage and faces a draw-back
by which hot-plugged devices will not be allocated an IRQ, this is fixed
by registering IRQ allocation functions for later use during the device
enable path.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 arch/sparc/kernel/leon_pci.c | 12 ++++++++++--
 arch/sparc/kernel/pci.c      | 23 +++++++++++++++++++----
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
index 4371f72..ca11fb8 100644
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
@@ -39,14 +41,20 @@ void leon_pci_init(struct platform_device *ofdev, struct leon_pci_info *info)
 		return;
 	}
 
-	/* Setup IRQs of all devices using custom routines */
-	pci_fixup_irqs(pci_common_swizzle, info->map_irq);
+	leon_pci_map_irq = info->map_irq;
 
 	/* Assign devices with resources */
 	pci_assign_unassigned_resources();
 	pci_bus_add_devices(root_bus);
 }
 
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->swizzle_irq = pci_common_swizzle;
+	bridge->map_irq = leon_pci_map_irq;
+	return 0;
+}
+
 void pcibios_fixup_bus(struct pci_bus *pbus)
 {
 	struct pci_dev *dev;
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index b91d7f1..4841066 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -335,10 +335,6 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 	} else {
 		dev->hdr_type = PCI_HEADER_TYPE_NORMAL;
 		dev->rom_base_reg = PCI_ROM_ADDRESS;
-
-		dev->irq = sd->op->archdata.irqs[0];
-		if (dev->irq == 0xffffffff)
-			dev->irq = PCI_IRQ_NONE;
 	}
 
 	pci_parse_of_addrs(sd->op, node, dev);
@@ -351,6 +347,25 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 	return dev;
 }
 
+int pci_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	int irq;
+	struct platform_device *op = of_find_device_by_node(dev->sysdata);
+
+	irq = op->archdata.irqs[0];
+	if (irq == 0xffffffff)
+		irq = PCI_IRQ_NONE;
+	return irq;
+}
+
+#ifndef CONFIG_LEON_PCI
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->map_irq = pci_map_irq;
+	return 0;
+}
+#endif
+
 static void apb_calc_first_last(u8 map, u32 *first_p, u32 *last_p)
 {
 	u32 idx, first, last;
-- 
2.6.2

