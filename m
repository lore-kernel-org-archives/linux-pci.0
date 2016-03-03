Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 11/12] PCI: Remove unused IORESOURCE_ROM_COPY and
 IORESOURCE_ROM_BIOS_COPY
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
Date: Thu, 03 Mar 2016 10:55:18 -0600
Message-ID: <20160303165518.3025.86484.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The IORESOURCE_ROM_COPY and IORESOURCE_ROM_BIOS_COPY bits are unused.
Remove them and code that depends on them.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/remove.c   |    1 -
 drivers/pci/rom.c      |   31 +------------------------------
 include/linux/ioport.h |    2 --
 3 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 8a280e9..6b66329 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -7,7 +7,6 @@ static void pci_free_resources(struct pci_dev *dev)
 {
 	int i;
 
-	pci_cleanup_rom(dev);
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		struct resource *res = dev->resource + i;
 		if (res->parent)
diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index 2a07f34..06663d3 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -128,12 +128,6 @@ void __iomem *pci_map_rom(struct pci_dev *pdev, size_t *size)
 	loff_t start;
 	void __iomem *rom;
 
-	if (res->flags & (IORESOURCE_ROM_COPY | IORESOURCE_ROM_BIOS_COPY)) {
-		*size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
-		return (void __iomem *)(unsigned long)
-			pci_resource_start(pdev, PCI_ROM_RESOURCE);
-	}
-
 	/* assign the ROM an address if it doesn't have one */
 	if (res->parent == NULL && pci_assign_resource(pdev, PCI_ROM_RESOURCE))
 		return NULL;
@@ -150,8 +144,7 @@ void __iomem *pci_map_rom(struct pci_dev *pdev, size_t *size)
 	rom = ioremap(start, *size);
 	if (!rom) {
 		/* restore enable if ioremap fails */
-		if (!(res->flags & (IORESOURCE_ROM_ENABLE |
-				    IORESOURCE_ROM_COPY)))
+		if (!(res->flags & IORESOURCE_ROM_ENABLE))
 			pci_disable_rom(pdev);
 		return NULL;
 	}
@@ -177,9 +170,6 @@ void pci_unmap_rom(struct pci_dev *pdev, void __iomem *rom)
 {
 	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
 
-	if (res->flags & (IORESOURCE_ROM_COPY | IORESOURCE_ROM_BIOS_COPY))
-		return;
-
 	iounmap(rom);
 
 	/* Disable again before continuing */
@@ -189,25 +179,6 @@ void pci_unmap_rom(struct pci_dev *pdev, void __iomem *rom)
 EXPORT_SYMBOL(pci_unmap_rom);
 
 /**
- * pci_cleanup_rom - free the ROM copy created by pci_map_rom_copy
- * @pdev: pointer to pci device struct
- *
- * Free the copied ROM if we allocated one.
- */
-void pci_cleanup_rom(struct pci_dev *pdev)
-{
-	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
-
-	if (res->flags & IORESOURCE_ROM_COPY) {
-		kfree((void *)(unsigned long)res->start);
-		res->flags |= IORESOURCE_UNSET;
-		res->flags &= ~IORESOURCE_ROM_COPY;
-		res->start = 0;
-		res->end = 0;
-	}
-}
-
-/**
  * pci_platform_rom - provides a pointer to any ROM image provided by the
  * platform
  * @pdev: pointer to pci device struct
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 2cf1667..29a6deb 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -99,8 +99,6 @@ struct resource {
 /* PCI ROM control bits (IORESOURCE_BITS) */
 #define IORESOURCE_ROM_ENABLE		(1<<0)	/* ROM is enabled, same as PCI_ROM_ADDRESS_ENABLE */
 #define IORESOURCE_ROM_SHADOW		(1<<1)	/* Use RAM image, not ROM BAR */
-#define IORESOURCE_ROM_COPY		(1<<2)	/* ROM is alloc'd copy, resource field overlaid */
-#define IORESOURCE_ROM_BIOS_COPY	(1<<3)	/* ROM is BIOS copy, resource field overlaid */
 
 /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
 #define IORESOURCE_PCI_FIXED		(1<<4)	/* Do not move resource */
