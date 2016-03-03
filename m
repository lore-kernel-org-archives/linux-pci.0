Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48318 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932764AbcCCQyS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Mar 2016 11:54:18 -0500
Subject: [PATCH v1 03/12] PCI: Don't enable/disable ROM BAR if we're using a
 RAM shadow copy
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
	Tony Luck <tony.luck@intel.com>,
	DRI <dri-devel@lists.freedesktop.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Bruno =?utf-8?q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
	Daniel Stone <daniel@fooishbar.org>,
	Alex Deucher <alexdeucher@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ville =?utf-8?b?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Date: Thu, 03 Mar 2016 10:54:14 -0600
Message-ID: <20160303165414.3025.75102.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If we're using a RAM shadow copy instead of the ROM BAR, we don't need to
touch the ROM BAR enable bit.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/rom.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index 9eaca39..5da8d06 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -24,13 +24,17 @@
  */
 int pci_enable_rom(struct pci_dev *pdev)
 {
-	struct resource *res = pdev->resource + PCI_ROM_RESOURCE;
+	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
 	struct pci_bus_region region;
 	u32 rom_addr;
 
 	if (!res->flags)
 		return -1;
 
+	/* Nothing to enable if we're using a shadow copy in RAM */
+	if (res->flags & IORESOURCE_ROM_SHADOW)
+		return 0;
+
 	pcibios_resource_to_bus(pdev->bus, &region, res);
 	pci_read_config_dword(pdev, pdev->rom_base_reg, &rom_addr);
 	rom_addr &= ~PCI_ROM_ADDRESS_MASK;
@@ -49,7 +53,12 @@ EXPORT_SYMBOL_GPL(pci_enable_rom);
  */
 void pci_disable_rom(struct pci_dev *pdev)
 {
+	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
 	u32 rom_addr;
+
+	if (res->flags & IORESOURCE_ROM_SHADOW)
+		return;
+
 	pci_read_config_dword(pdev, pdev->rom_base_reg, &rom_addr);
 	rom_addr &= ~PCI_ROM_ADDRESS_ENABLE;
 	pci_write_config_dword(pdev, pdev->rom_base_reg, rom_addr);
@@ -154,7 +163,6 @@ void __iomem *pci_map_rom(struct pci_dev *pdev, size_t *size)
 	if (!rom) {
 		/* restore enable if ioremap fails */
 		if (!(res->flags & (IORESOURCE_ROM_ENABLE |
-				    IORESOURCE_ROM_SHADOW |
 				    IORESOURCE_ROM_COPY)))
 			pci_disable_rom(pdev);
 		return NULL;
@@ -186,8 +194,8 @@ void pci_unmap_rom(struct pci_dev *pdev, void __iomem *rom)
 
 	iounmap(rom);
 
-	/* Disable again before continuing, leave enabled if pci=rom */
-	if (!(res->flags & (IORESOURCE_ROM_ENABLE | IORESOURCE_ROM_SHADOW)))
+	/* Disable again before continuing */
+	if (!(res->flags & IORESOURCE_ROM_ENABLE))
 		pci_disable_rom(pdev);
 }
 EXPORT_SYMBOL(pci_unmap_rom);

