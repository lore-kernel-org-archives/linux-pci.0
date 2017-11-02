Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:26843 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934073AbdKBD4J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Nov 2017 23:56:09 -0400
From: changbin.du@intel.com
To: bhelgaas@google.com
Cc: tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@intel.com>
Subject: [PATCH] PCI: Fail pci_map_rom if the PCI ROM is invalid
Date: Thu,  2 Nov 2017 11:48:42 +0800
Message-Id: <1509594522-6841-1-git-send-email-changbin.du@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Changbin Du <changbin.du@intel.com>

If we detected a invalid PCI ROM (e.g. Invalid PCI ROM header signature),
we should unmap it immediately and fail. It doesn't make any sense that
return a mapped area with size of 0.

I have seen this case on Intel GVTg vGPU, which have no vbios. It will
not cause a real problem, but we should skip it as early as possible.

Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 drivers/pci/rom.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index b6edb18..1f5e6af 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -147,12 +147,8 @@ void __iomem *pci_map_rom(struct pci_dev *pdev, size_t *size)
 		return NULL;
 
 	rom = ioremap(start, *size);
-	if (!rom) {
-		/* restore enable if ioremap fails */
-		if (!(res->flags & IORESOURCE_ROM_ENABLE))
-			pci_disable_rom(pdev);
-		return NULL;
-	}
+	if (!rom)
+		goto err_ioremap;
 
 	/*
 	 * Try to find the true size of the ROM since sometimes the PCI window
@@ -160,7 +156,18 @@ void __iomem *pci_map_rom(struct pci_dev *pdev, size_t *size)
 	 * True size is important if the ROM is going to be copied.
 	 */
 	*size = pci_get_rom_size(pdev, rom, *size);
+	if (!*size)
+		goto invalid_rom;
+
 	return rom;
+
+invalid_rom:
+	iounmap(rom);
+err_ioremap:
+	/* restore enable if ioremap fails */
+	if (!(res->flags & IORESOURCE_ROM_ENABLE))
+		pci_disable_rom(pdev);
+	return NULL;
 }
 EXPORT_SYMBOL(pci_map_rom);
 
-- 
2.7.4
