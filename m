Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36257 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbbJWFGA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:06:00 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 18/29] microblaze/PCI: Defer IRQ assignment to device enable time
Date: Fri, 23 Oct 2015 06:03:51 +0100
Message-Id: <1445576642-29624-19-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently microblaze assigns PCI IRQs during the pcibios phase, this means
that devices connected after boot will not be assigned an IRQ, instead the
boot code now registers IRQ assignment functions to be called later by the
device enable code paths.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 arch/microblaze/pci/pci-common.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index ae838ed..99ea108 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -855,12 +855,15 @@ void pcibios_setup_bus_devices(struct pci_bus *bus)
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
+	bridge->map_irq = of_irq_parse_and_map_pci;
+	return 0;
+}
+
 void pcibios_fixup_bus(struct pci_bus *bus)
 {
 	/* When called from the generic PCI probe, read PCI<->PCI bridge
-- 
2.6.2

