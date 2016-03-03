Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48370 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932764AbcCCQy0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Mar 2016 11:54:26 -0500
Subject: [PATCH v1 04/12] PCI: Set ROM shadow location in arch code,
 not in PCI core
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
Date: Thu, 03 Mar 2016 10:54:22 -0600
Message-ID: <20160303165422.3025.63656.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

IORESOURCE_ROM_SHADOW means there is a copy of a device's option ROM in
RAM.  The existence of such a copy and its location are arch-specific.
Previously the IORESOURCE_ROM_SHADOW flag was set in arch code, but the
0xC0000-0xDFFFF location was hard-coded into the PCI core.

If we're using a shadow copy in RAM, disable the ROM BAR and release the
address space it was consuming.  Move the location information from the PCI
core to the arch code that sets IORESOURCE_ROM_SHADOW.  Save the location
of the RAM copy in the struct resource for PCI_ROM_RESOURCE.

After this change, pci_map_rom() will call pci_assign_resource() and
pci_enable_rom() for these IORESOURCE_ROM_SHADOW resources, which we did
not do before.  This is safe because:

  - pci_assign_resource() will do nothing because the resource is marked
    IORESOURCE_PCI_FIXED, which means we can't move it, and

  - pci_enable_rom() will not turn on the ROM BAR's enable bit because the
    resource is marked IORESOURCE_ROM_SHADOW, which means it is in RAM
    rather than in PCI memory space.

Storing the location in the struct resource means "lspci" will show the
shadow location, not the value from the ROM BAR.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/ia64/pci/fixup.c  |   22 ++++++++++++++++------
 arch/x86/pci/fixup.c   |   22 ++++++++++++++++------
 drivers/pci/rom.c      |   11 -----------
 include/linux/ioport.h |    2 +-
 4 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/arch/ia64/pci/fixup.c b/arch/ia64/pci/fixup.c
index fd9ceff..41caa99 100644
--- a/arch/ia64/pci/fixup.c
+++ b/arch/ia64/pci/fixup.c
@@ -17,14 +17,14 @@
  *
  * The standard boot ROM sequence for an x86 machine uses the BIOS
  * to select an initial video card for boot display. This boot video
- * card will have it's BIOS copied to C0000 in system RAM.
+ * card will have its BIOS copied to 0xC0000 in system RAM.
  * IORESOURCE_ROM_SHADOW is used to associate the boot video
  * card with this copy. On laptops this copy has to be used since
  * the main ROM may be compressed or combined with another image.
  * See pci_map_rom() for use of this flag. Before marking the device
  * with IORESOURCE_ROM_SHADOW check if a vga_default_device is already set
- * by either arch cde or vga-arbitration, if so only apply the fixup to this
- * already determined primary video card.
+ * by either arch code or vga-arbitration; if so only apply the fixup to this
+ * already-determined primary video card.
  */
 
 static void pci_fixup_video(struct pci_dev *pdev)
@@ -32,6 +32,7 @@ static void pci_fixup_video(struct pci_dev *pdev)
 	struct pci_dev *bridge;
 	struct pci_bus *bus;
 	u16 config;
+	struct resource *res;
 
 	if ((strcmp(ia64_platform_name, "dig") != 0)
 	    && (strcmp(ia64_platform_name, "hpzx1")  != 0))
@@ -61,9 +62,18 @@ static void pci_fixup_video(struct pci_dev *pdev)
 	if (!vga_default_device() || pdev == vga_default_device()) {
 		pci_read_config_word(pdev, PCI_COMMAND, &config);
 		if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
-			pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW |
-				IORESOURCE_PCI_FIXED;
-			dev_printk(KERN_DEBUG, &pdev->dev, "Video device with shadowed ROM\n");
+			res = &pdev->resource[PCI_ROM_RESOURCE];
+
+			pci_disable_rom(pdev);
+			if (res->parent)
+				release_resource(res);
+
+			res->start = 0xC0000;
+			res->end = res->start + 0x20000 - 1;
+			res->flags = IORESOURCE_MEM | IORESOURCE_ROM_SHADOW |
+				     IORESOURCE_PCI_FIXED;
+			dev_info(&pdev->dev, "Video device with shadowed ROM at %pR\n",
+				 res);
 		}
 	}
 }
diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index dac027c..b7de192 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -297,14 +297,14 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC1,	pcie_r
  *
  * The standard boot ROM sequence for an x86 machine uses the BIOS
  * to select an initial video card for boot display. This boot video
- * card will have it's BIOS copied to C0000 in system RAM.
+ * card will have its BIOS copied to 0xC0000 in system RAM.
  * IORESOURCE_ROM_SHADOW is used to associate the boot video
  * card with this copy. On laptops this copy has to be used since
  * the main ROM may be compressed or combined with another image.
  * See pci_map_rom() for use of this flag. Before marking the device
  * with IORESOURCE_ROM_SHADOW check if a vga_default_device is already set
- * by either arch cde or vga-arbitration, if so only apply the fixup to this
- * already determined primary video card.
+ * by either arch code or vga-arbitration; if so only apply the fixup to this
+ * already-determined primary video card.
  */
 
 static void pci_fixup_video(struct pci_dev *pdev)
@@ -312,6 +312,7 @@ static void pci_fixup_video(struct pci_dev *pdev)
 	struct pci_dev *bridge;
 	struct pci_bus *bus;
 	u16 config;
+	struct resource *res;
 
 	/* Is VGA routed to us? */
 	bus = pdev->bus;
@@ -336,9 +337,18 @@ static void pci_fixup_video(struct pci_dev *pdev)
 	if (!vga_default_device() || pdev == vga_default_device()) {
 		pci_read_config_word(pdev, PCI_COMMAND, &config);
 		if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
-			pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW |
-				IORESOURCE_PCI_FIXED;
-			dev_printk(KERN_DEBUG, &pdev->dev, "Video device with shadowed ROM\n");
+			res = &pdev->resource[PCI_ROM_RESOURCE];
+
+			pci_disable_rom(pdev);
+			if (res->parent)
+				release_resource(res);
+
+			res->start = 0xC0000;
+			res->end = res->start + 0x20000 - 1;
+			res->flags = IORESOURCE_MEM | IORESOURCE_ROM_SHADOW |
+				     IORESOURCE_PCI_FIXED;
+			dev_info(&pdev->dev, "Video device with shadowed ROM at %pR\n",
+				 res);
 		}
 	}
 }
diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index 5da8d06..80e82b1 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -128,16 +128,6 @@ void __iomem *pci_map_rom(struct pci_dev *pdev, size_t *size)
 	loff_t start;
 	void __iomem *rom;
 
-	/*
-	 * IORESOURCE_ROM_SHADOW set on x86, x86_64 and IA64 supports legacy
-	 * memory map if the VGA enable bit of the Bridge Control register is
-	 * set for embedded VGA.
-	 */
-	if (res->flags & IORESOURCE_ROM_SHADOW) {
-		/* primary video rom always starts here */
-		start = (loff_t)0xC0000;
-		*size = 0x20000; /* cover C000:0 through E000:0 */
-	} else {
 		if (res->flags &
 			(IORESOURCE_ROM_COPY | IORESOURCE_ROM_BIOS_COPY)) {
 			*size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
@@ -157,7 +147,6 @@ void __iomem *pci_map_rom(struct pci_dev *pdev, size_t *size)
 			if (pci_enable_rom(pdev))
 				return NULL;
 		}
-	}
 
 	rom = ioremap(start, *size);
 	if (!rom) {
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 24bea08..2cf1667 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -98,7 +98,7 @@ struct resource {
 
 /* PCI ROM control bits (IORESOURCE_BITS) */
 #define IORESOURCE_ROM_ENABLE		(1<<0)	/* ROM is enabled, same as PCI_ROM_ADDRESS_ENABLE */
-#define IORESOURCE_ROM_SHADOW		(1<<1)	/* ROM is copy at C000:0 */
+#define IORESOURCE_ROM_SHADOW		(1<<1)	/* Use RAM image, not ROM BAR */
 #define IORESOURCE_ROM_COPY		(1<<2)	/* ROM is alloc'd copy, resource field overlaid */
 #define IORESOURCE_ROM_BIOS_COPY	(1<<3)	/* ROM is BIOS copy, resource field overlaid */
 

