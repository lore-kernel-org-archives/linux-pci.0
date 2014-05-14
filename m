Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:60105 "EHLO
	hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbaENUxS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 May 2014 16:53:18 -0400
Date: Wed, 14 May 2014 22:43:39 +0200
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: DRI mailing list <dri-devel@lists.freedesktop.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Dave Airlie <airlied@linux.ie>
Subject: [Patch] x86, ia64, efifb: Move boot_vga fixup from pci to vgaarb
Message-ID: <20140514224339.7f8be3a9@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

With commit b4aa0163056b6c70029b6e8619ce07c274351f42 Matthew Garret
introduced a efifb vga_default_device() so that EFI systems that do not
load shadow VBIOS or setup VGA get proper value for boot_vga PCI sysfs
attribute on the corresponding PCI device.

Xorg is refusing to autodetect devices when boot_vga=0 which is the case
on some EFI system (e.g. MacBookAir2,1). Xorg detects the GPU and finds
the dri device but then bails out with "no devices detected".

With introduction of sysfb/simplefb/simpledrm efifb is getting obsolete
while having native drivers for the GPU also makes selecting
sysfb/efifb optional.

Remove the efifb implementation of vga_default_device() and initialize
vgaarb's vga_default_device() with the PCI GPU that matches boot
screen_info in pci_fixup_video() [x86 and ia64 pci_fixup_video merged
into common function in vgaarb.c].

Other architectures with PCI GPU might need a similar fixup.

Note: If CONFIG_VGA_ARB is unset vga_default_device() is only available
      as a stub that returns NULL, making this adjustment insufficient.
      In addition, with the merge of x86/ia64 fixup code, this would
      also result in disabled fixup.
      Unsetting CONFIG_VGA_ARB requires CONFIG_EXPERT=y though.

Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>
---
This is ported to changes in pci/fixup.c that landed in 3.15-rcs.

Is this fine to go in, if so who will take it?

I got no feedback on my last respin (on top of 3.14 a couple of weeks ago,
which added moving the ia64 pci boot_vga fixup).
I've been running this revision for a week or so on 3.15-rc kernels here
(mostly EFI-enabled system, the mentioned MBA as wells as non-Apple systems
where the patch was not required).


 arch/ia64/pci/fixup.c       | 56 ++-------------------------------
 arch/x86/include/asm/vga.h  |  6 ----
 arch/x86/pci/fixup.c        | 55 +--------------------------------
 drivers/gpu/vga/vgaarb.c    | 75 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/video/fbdev/efifb.c | 38 -----------------------
 include/linux/vgaarb.h      | 37 ++++++++++++++++++++++
 6 files changed, 116 insertions(+), 151 deletions(-)

diff --git a/arch/ia64/pci/fixup.c b/arch/ia64/pci/fixup.c
index eee069a..5df22f9 100644
--- a/arch/ia64/pci/fixup.c
+++ b/arch/ia64/pci/fixup.c
@@ -9,64 +9,14 @@
 
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
diff --git a/arch/x86/include/asm/vga.h b/arch/x86/include/asm/vga.h
index 44282fb..c4b9dc2 100644
--- a/arch/x86/include/asm/vga.h
+++ b/arch/x86/include/asm/vga.h
@@ -17,10 +17,4 @@
 #define vga_readb(x) (*(x))
 #define vga_writeb(x, y) (*(y) = (x))
 
-#ifdef CONFIG_FB_EFI
-#define __ARCH_HAS_VGA_DEFAULT_DEVICE
-extern struct pci_dev *vga_default_device(void);
-extern void vga_set_default_device(struct pci_dev *pdev);
-#endif
-
 #endif /* _ASM_X86_VGA_H */
diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 94ae9ae..b599847 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -302,60 +302,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PB1,	pcie_r
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
diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index ae9618f..a033180 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -19,8 +19,6 @@
 
 static bool request_mem_succeeded = false;
 
-static struct pci_dev *default_vga;
-
 static struct fb_var_screeninfo efifb_defined = {
 	.activate		= FB_ACTIVATE_NOW,
 	.height			= -1,
@@ -84,18 +82,6 @@ static struct fb_ops efifb_ops = {
 	.fb_imageblit	= cfb_imageblit,
 };
 
-struct pci_dev *vga_default_device(void)
-{
-	return default_vga;
-}
-
-EXPORT_SYMBOL_GPL(vga_default_device);
-
-void vga_set_default_device(struct pci_dev *pdev)
-{
-	default_vga = pdev;
-}
-
 static int efifb_setup(char *options)
 {
 	char *this_opt;
@@ -126,30 +112,6 @@ static int efifb_setup(char *options)
 		}
 	}
 
-	for_each_pci_dev(dev) {
-		int i;
-
-		if ((dev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
-			continue;
-
-		for (i=0; i < DEVICE_COUNT_RESOURCE; i++) {
-			resource_size_t start, end;
-
-			if (!(pci_resource_flags(dev, i) & IORESOURCE_MEM))
-				continue;
-
-			start = pci_resource_start(dev, i);
-			end  = pci_resource_end(dev, i);
-
-			if (!start || !end)
-				continue;
-
-			if (screen_info.lfb_base >= start &&
-			    (screen_info.lfb_base + screen_info.lfb_size) < end)
-				default_vga = dev;
-		}
-	}
-
 	return 0;
 }
 
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
