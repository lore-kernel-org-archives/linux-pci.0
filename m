Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36244 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbbJWFF5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:05:57 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 15/29] cris/PCI: Defer IRQ assignment to device enable time
Date: Fri, 23 Oct 2015 06:03:48 +0100
Message-Id: <1445576642-29624-16-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI IRQs are currently configured to be enabled once at boot in a
dedicated pass. This means that PCI devices which are hot-plugged after
boot time will not be given an IRQ, this patch-set fixes this by
registering the assignment function to be called later in the device
enable path.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 arch/cris/arch-v32/drivers/pci/bios.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/cris/arch-v32/drivers/pci/bios.c b/arch/cris/arch-v32/drivers/pci/bios.c
index 64a5fb9..2b7b79f 100644
--- a/arch/cris/arch-v32/drivers/pci/bios.c
+++ b/arch/cris/arch-v32/drivers/pci/bios.c
@@ -80,9 +80,10 @@ int pcibios_enable_resources(struct pci_dev *dev, int mask)
 	return 0;
 }
 
-int pcibios_enable_irq(struct pci_dev *dev)
+int pcibios_enable_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
-	dev->irq = EXT_INTR_VECT;
+	if (!dev->msi_enabled)
+		dev->irq = EXT_INTR_VECT;
 	return 0;
 }
 
@@ -92,8 +93,11 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 
 	if ((err = pcibios_enable_resources(dev, mask)) < 0)
 		return err;
+	return 0;
+}
 
-	if (!dev->msi_enabled)
-		pcibios_enable_irq(dev);
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->map_irq = pcibios_enable_irq;
 	return 0;
 }
-- 
2.6.2

