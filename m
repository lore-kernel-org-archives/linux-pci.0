Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:57806 "EHLO
	hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbaFXW6j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jun 2014 18:58:39 -0400
Date: Wed, 25 Jun 2014 00:58:35 +0200
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: DRI mailing list <dri-devel@lists.freedesktop.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Dave Airlie <airlied@linux.ie>,
	Matthew Garrett <matthew.garrett@nebula.com>,
	Anibal Francisco Martinez Cortina <linuxkid.zeuz@gmail.com>
Subject: [PATCH 2/2 v2] x86, ia64: Merge common vga fixup code
Message-ID: <20140625005835.0c6b7ed6@neptune.home>
In-Reply-To: <20140625005501.7ff7e982@neptune.home>
References: <20140514224339.7f8be3a9@neptune.home>
	<20140527234255.GJ11907@google.com>
	<20140602201650.35f0e936@neptune.home>
	<20140602201926.4d476818@neptune.home>
	<20140625005501.7ff7e982@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The fixup code for PCI VGA devices in ia64 and x86 is mostly identical.

Merge it into a single function called from both sides.

The common code is moved to vgaarb.c which makes in dependant on
CONFIG_VGA_ARB.

Tested-by: Anibal Francisco Martinez Cortina <linuxkid.zeuz@gmail.com>
Cc: Matthew Garrett <matthew.garrett@nebula.com>
Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>
---

Changes since v1:
  Added Tested-by, Cc

 arch/ia64/pci/fixup.c    | 77 ++----------------------------------------------
 arch/x86/pci/fixup.c     | 76 +----------------------------------------------
 drivers/gpu/vga/vgaarb.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/vgaarb.h   | 37 +++++++++++++++++++++++
 4 files changed, 116 insertions(+), 149 deletions(-)

diff --git a/arch/ia64/pci/fixup.c b/arch/ia64/pci/fixup.c
index 9ed5bef..5df22f9 100644
--- a/arch/ia64/pci/fixup.c
+++ b/arch/ia64/pci/fixup.c
@@ -9,85 +9,14 @@
 
 #include <asm/machvec.h>
 
-/*
- * Fixup to mark boot BIOS video selected by BIOS before it changes
- *
- * From information provided by "Jon Smirl" <jonsmirl@gmail.com>
- *
- * The standard boot ROM sequence for an x86 machine uses the BIOS
- * to select an initial video card for boot display. This boot video
- * card will have it's BIOS copied to C0000 in system RAM.
- * IORESOURCE_ROM_SHADOW is used to associate the boot video
- * card with this copy. On laptops this copy has to be used since
- * the main ROM may be compressed or combined with another image.
- * See pci_map_rom() for use of this flag. Before marking the device
- * with IORESOURCE_ROM_SHADOW check if a vga_default_device is already set
- * by either arch cde or vga-arbitration, if so only apply the fixup to this
- * already determined primary video card.
- */
-
-static void pci_fixup_video(struct pci_dev *pdev)
+static void pci_ia64_fixup_video(struct pci_dev *pdev)
 {
-	struct pci_dev *bridge;
-	struct pci_bus *bus;
-	u16 config;
-
 	if ((strcmp(ia64_platform_name, "dig") != 0)
 	    && (strcmp(ia64_platform_name, "hpzx1")  != 0))
 		return;
 	/* Maybe, this machine supports legacy memory map. */
 
-	if (!vga_default_device()) {
-		resource_size_t start, end;
-		int i;
-
-		/* Does firmware framebuffer belong to us? */
-		for (i=0; i < DEVICE_COUNT_RESOURCE; i++) {
-			if (!(pci_resource_flags(pdev, i) & IORESOURCE_MEM))
-				continue;
-
-			start = pci_resource_start(pdev, i);
-			end  = pci_resource_end(pdev, i);
-
-			if (!start || !end)
-				continue;
-
-			if (screen_info.lfb_base >= start &&
-				(screen_info.lfb_base + screen_info.lfb_size) < end)
-				vga_set_default_device(pdev);
-		}
-	}
-
-	/* Is VGA routed to us? */
-	bus = pdev->bus;
-	while (bus) {
-		bridge = bus->self;
-
-		/*
-		 * From information provided by
-		 * "David Miller" <davem@davemloft.net>
-		 * The bridge control register is valid for PCI header
-		 * type BRIDGE, or CARDBUS. Host to PCI controllers use
-		 * PCI header type NORMAL.
-		 */
-		if (bridge
-		    &&((bridge->hdr_type == PCI_HEADER_TYPE_BRIDGE)
-		       ||(bridge->hdr_type == PCI_HEADER_TYPE_CARDBUS))) {
-			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL,
-						&config);
-			if (!(config & PCI_BRIDGE_CTL_VGA))
-				return;
-		}
-		bus = bus->parent;
-	}
-	if (!vga_default_device() || pdev == vga_default_device()) {
-		pci_read_config_word(pdev, PCI_COMMAND, &config);
-		if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
-			pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
-			dev_printk(KERN_DEBUG, &pdev->dev, "Boot video device\n");
-			vga_set_default_device(pdev);
-		}
-	}
+	pci_fixup_video(pdev);
 }
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
-				PCI_CLASS_DISPLAY_VGA, 8, pci_fixup_video);
+				PCI_CLASS_DISPLAY_VGA, 8, pci_ia64_fixup_video);
diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 7246cf2..b599847 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -302,81 +302,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PB1,	pcie_r
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC,	pcie_rootport_aspm_quirk);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC1,	pcie_rootport_aspm_quirk);
 
-/*
- * Fixup to mark boot BIOS video selected by BIOS before it changes
- *
- * From information provided by "Jon Smirl" <jonsmirl@gmail.com>
- *
- * The standard boot ROM sequence for an x86 machine uses the BIOS
- * to select an initial video card for boot display. This boot video
- * card will have it's BIOS copied to C0000 in system RAM.
- * IORESOURCE_ROM_SHADOW is used to associate the boot video
- * card with this copy. On laptops this copy has to be used since
- * the main ROM may be compressed or combined with another image.
- * See pci_map_rom() for use of this flag. Before marking the device
- * with IORESOURCE_ROM_SHADOW check if a vga_default_device is already set
- * by either arch cde or vga-arbitration, if so only apply the fixup to this
- * already determined primary video card.
- */
-
-static void pci_fixup_video(struct pci_dev *pdev)
-{
-	struct pci_dev *bridge;
-	struct pci_bus *bus;
-	u16 config;
-
-	if (!vga_default_device()) {
-		resource_size_t start, end;
-		int i;
-
-		/* Does firmware framebuffer belong to us? */
-		for (i=0; i < DEVICE_COUNT_RESOURCE; i++) {
-			if (!(pci_resource_flags(pdev, i) & IORESOURCE_MEM))
-				continue;
-
-			start = pci_resource_start(pdev, i);
-			end  = pci_resource_end(pdev, i);
-
-			if (!start || !end)
-				continue;
-
-			if (screen_info.lfb_base >= start &&
-				(screen_info.lfb_base + screen_info.lfb_size) < end)
-				vga_set_default_device(pdev);
-		}
-	}
-
-	/* Is VGA routed to us? */
-	bus = pdev->bus;
-	while (bus) {
-		bridge = bus->self;
-
-		/*
-		 * From information provided by
-		 * "David Miller" <davem@davemloft.net>
-		 * The bridge control register is valid for PCI header
-		 * type BRIDGE, or CARDBUS. Host to PCI controllers use
-		 * PCI header type NORMAL.
-		 */
-		if (bridge
-		    && ((bridge->hdr_type == PCI_HEADER_TYPE_BRIDGE)
-		       || (bridge->hdr_type == PCI_HEADER_TYPE_CARDBUS))) {
-			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL,
-						&config);
-			if (!(config & PCI_BRIDGE_CTL_VGA))
-				return;
-		}
-		bus = bus->parent;
-	}
-	if (!vga_default_device() || pdev == vga_default_device()) {
-		pci_read_config_word(pdev, PCI_COMMAND, &config);
-		if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
-			pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
-			dev_printk(KERN_DEBUG, &pdev->dev, "Boot video device\n");
-			vga_set_default_device(pdev);
-		}
-	}
-}
+/* pci_fixup_video shared in vgaarb.c */
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
 				PCI_CLASS_DISPLAY_VGA, 8, pci_fixup_video);
 
diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index af02597..f0fbdf6 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -149,6 +149,81 @@ void vga_set_default_device(struct pci_dev *pdev)
 }
 #endif
 
+/*
+ * Fixup to mark boot BIOS video selected by BIOS before it changes
+ *
+ * From information provided by "Jon Smirl" <jonsmirl@gmail.com>
+ *
+ * The standard boot ROM sequence for an x86 machine uses the BIOS
+ * to select an initial video card for boot display. This boot video
+ * card will have it's BIOS copied to C0000 in system RAM.
+ * IORESOURCE_ROM_SHADOW is used to associate the boot video
+ * card with this copy. On laptops this copy has to be used since
+ * the main ROM may be compressed or combined with another image.
+ * See pci_map_rom() for use of this flag. Before marking the device
+ * with IORESOURCE_ROM_SHADOW check if a vga_default_device is already set
+ * by either arch cde or vga-arbitration, if so only apply the fixup to this
+ * already determined primary video card.
+ */
+
+void pci_fixup_video(struct pci_dev *pdev)
+{
+	struct pci_dev *bridge;
+	struct pci_bus *bus;
+	u16 config;
+
+	if (!vga_default_device()) {
+		resource_size_t start, end;
+		int i;
+
+		for (i=0; i < DEVICE_COUNT_RESOURCE; i++) {
+			if (!(pci_resource_flags(pdev, i) & IORESOURCE_MEM))
+				continue;
+
+			start = pci_resource_start(pdev, i);
+			end  = pci_resource_end(pdev, i);
+
+			if (!start || !end)
+				continue;
+
+			if (screen_info.lfb_base >= start &&
+				(screen_info.lfb_base + screen_info.lfb_size) < end)
+				vga_set_default_device(pdev);
+		}
+	}
+
+	/* Is VGA routed to us? */
+	bus = pdev->bus;
+	while (bus) {
+		bridge = bus->self;
+
+		/*
+		 * From information provided by
+		 * "David Miller" <davem@davemloft.net>
+		 * The bridge control register is valid for PCI header
+		 * type BRIDGE, or CARDBUS. Host to PCI controllers use
+		 * PCI header type NORMAL.
+		 */
+		if (bridge
+		    && ((bridge->hdr_type == PCI_HEADER_TYPE_BRIDGE)
+		       || (bridge->hdr_type == PCI_HEADER_TYPE_CARDBUS))) {
+			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL,
+						&config);
+			if (!(config & PCI_BRIDGE_CTL_VGA))
+				return;
+		}
+		bus = bus->parent;
+	}
+	if (!vga_default_device() || pdev == vga_default_device()) {
+		pci_read_config_word(pdev, PCI_COMMAND, &config);
+		if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
+			pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
+			dev_printk(KERN_DEBUG, &pdev->dev, "Boot video device\n");
+			vga_set_default_device(pdev);
+		}
+	}
+}
+
 static inline void vga_irq_set_state(struct vga_device *vgadev, bool state)
 {
 	if (vgadev->irq_set_state)
diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
index 2c02f3a..6518460 100644
--- a/include/linux/vgaarb.h
+++ b/include/linux/vgaarb.h
@@ -162,6 +162,43 @@ extern void vga_put(struct pci_dev *pdev, unsigned int rsrc);
 #define vga_put(pdev, rsrc)
 #endif
 
+/**
+ *     pci_fixup_video
+ *
+ *     This can be called by arch PCI to fixup boot VGA tagging
+ *     of VGA PCI devices (e.g. for X86, IA64)
+ *
+ *     This code was initially spread/duplicated across:
+ *     - X86 PCI-fixup
+ *     - IA64 PCI-fixup
+ *     - EFI_FB
+ *
+ *     * PCI-fixup part:
+ *     Fixup to mark boot BIOS video selected by BIOS before it changes
+ *
+ *     From information provided by "Jon Smirl" <jonsmirl@gmail.com>
+ *
+ *     The standard boot ROM sequence for an x86 machine uses the BIOS
+ *     to select an initial video card for boot display. This boot video
+ *     card will have it's BIOS copied to C0000 in system RAM.
+ *     IORESOURCE_ROM_SHADOW is used to associate the boot video
+ *     card with this copy. On laptops this copy has to be used since
+ *     the main ROM may be compressed or combined with another image.
+ *     See pci_map_rom() for use of this flag. IORESOURCE_ROM_SHADOW
+ *     is marked here since the boot video device will be the only enabled
+ *     video device at this point.
+ *
+ *     * EFI_FB part:
+ *     Some EFI-based system (e.g. Intel-Macs from Apple) do not setup
+ *     shadow Video-BIOS and thus can only be detected by framebuffer
+ *     IO memory range. Flag the corresponding GPU as boot_vga.
+ */
+
+#if defined(CONFIG_VGA_ARB)
+void pci_fixup_video(struct pci_dev *pdev);
+#else
+static inline void pci_fixup_video(struct pci_dev *pdev) { }
+#endif
 
 /**
  *     vga_default_device
-- 
1.8.5.5

