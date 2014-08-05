Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:64038 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957AbaHEQME (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Aug 2014 12:12:04 -0400
Received: by mail-we0-f169.google.com with SMTP id u56so1281236wes.28
        for <linux-pci@vger.kernel.org>; Tue, 05 Aug 2014 09:12:03 -0700 (PDT)
From: matthew_minter@xyratex.com
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: matthew_minter <matthew_minter@xyratex.com>
Subject: [PATCH 09/22] Added (untested) support to microblaze architecture to accomodate new irq init code
Date: Tue,  5 Aug 2014 17:11:10 +0100
Message-Id: <1407255083-9356-10-git-send-email-matthew_minter@xyratex.com>
In-Reply-To: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
References: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: matthew_minter <matthew_minter@xyratex.com>

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
2.0.4

