Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([69.164.217.139]:56329 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbaJBD7Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Oct 2014 23:59:24 -0400
From: matt@masarand.com
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Matthew Minter <matt@masarand.com>
Subject: [PATCH 10/18] Delayed microblaze setup of PCI IRQs to bus scan time
Date: Thu,  2 Oct 2014 04:50:29 +0100
Message-Id: <1412221837-17452-11-git-send-email-matt@masarand.com>
In-Reply-To: <1412221837-17452-1-git-send-email-matt@masarand.com>
References: <1412221837-17452-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Matthew Minter <matt@masarand.com>

Currently microblaze assigns PCI IRQs during the pcibios phase, this means
that devices connected after boot will not be assigned an IRQ, instead the
boot code now registers IRQ assignment functions to be called later by the
device enable code paths.

---
 arch/microblaze/pci/pci-common.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 9037914..6843b34 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -850,12 +850,16 @@ void pcibios_setup_bus_devices(struct pci_bus *bus)
 		 * code and is needed by the DMA init
 		 */
 		set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
-
-		/* Read default IRQs and fixup if necessary */
-		dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
 	}
 }
 
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->swizzle_irq = NULL;
+	bridge->map_irq = of_irq_parse_and_map_pci;
+	return 0;
+}
+
 void pcibios_fixup_bus(struct pci_bus *bus)
 {
 	/* When called from the generic PCI probe, read PCI<->PCI bridge
-- 
2.1.0

