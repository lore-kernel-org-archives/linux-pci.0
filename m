Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([69.164.217.139]:56351 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752376AbaJBEID (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Oct 2014 00:08:03 -0400
From: matt@masarand.com
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Matthew Minter <matt@masarand.com>
Subject: [PATCH 07/18] Delayed cris setup of PCI IRQs to bus scan time
Date: Thu,  2 Oct 2014 05:07:35 +0100
Message-Id: <1412222866-21068-8-git-send-email-matt@masarand.com>
In-Reply-To: <1412222866-21068-1-git-send-email-matt@masarand.com>
References: <1412222866-21068-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Matthew Minter <matt@masarand.com>

PCI IRQs are currently configured to be enabled once at boot in a
dedicated pass. This means that PCI devices which are hot-plugged after
boot time will not be given an IRQ, this patch-set fixes this by
registering the assignment function to be called later in the device
enable path.

Signed-off-by: Matthew Minter <matt@masarand.com>

---
 arch/cris/arch-v32/drivers/pci/bios.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/cris/arch-v32/drivers/pci/bios.c b/arch/cris/arch-v32/drivers/pci/bios.c
index 64a5fb9..d04ecc8 100644
--- a/arch/cris/arch-v32/drivers/pci/bios.c
+++ b/arch/cris/arch-v32/drivers/pci/bios.c
@@ -80,20 +80,16 @@ int pcibios_enable_resources(struct pci_dev *dev, int mask)
 	return 0;
 }
 
-int pcibios_enable_irq(struct pci_dev *dev)
+int pcibios_enable_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	dev->irq = EXT_INTR_VECT;
 	return 0;
 }
 
-int pcibios_enable_device(struct pci_dev *dev, int mask)
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
-	int err;
-
-	if ((err = pcibios_enable_resources(dev, mask)) < 0)
-		return err;
-
-	if (!dev->msi_enabled)
-		pcibios_enable_irq(dev);
+	bridge->swizzle_irq = NULL;
+	bridge->map_irq = pcibios_enable_irq;
 	return 0;
 }
+
-- 
2.1.0

