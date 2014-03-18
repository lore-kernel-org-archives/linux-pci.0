Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:34837 "EHLO
	hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728AbaCRRLu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Mar 2014 13:11:50 -0400
Date: Tue, 18 Mar 2014 18:05:19 +0100
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To: <dri-devel@lists.freedesktop.org>
Cc: David Herrmann <dh.herrmann@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Airlie <airlied@linux.ie>,
	Peter Jones <pjones@redhat.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>, matt.fleming@intel.com,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [RFC patch v3] x86: Improve boot_vga/vga_default_device() for EFI
Message-ID: <20140318180519.102f7988@neptune.home>
In-Reply-To: <20131218194655.044563d2@neptune.home>
References: <20131125205441.5046e0cb@neptune.home>
	<20131130145222.292c3f9f@neptune.home>
	<CANq1E4SqmFiOJx7o9fNq=s-RGqv-Gz8fb3mUMs1s-mD3JkdSGA@mail.gmail.com>
	<CANq1E4TZOu9D_uZQATK3LsyGjV8jBW17j4_jJ9QvP1T_R7mBkQ@mail.gmail.com>
	<20131218194655.044563d2@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

With commit b4aa0163056b6c70029b6e8619ce07c274351f42 Matthew Garret
introduced a efifb vga_default_device() so that EFI systems that do not
load shadow VBIOS or setup VGA get proper value for boot_vga PCI sysfs
attribute on the corresponding PCI device.

Xorg is refusing to detect devices when boot_vga=0 which is the case on
some EFI system (e.g. MacBookAir2,1). Xorg detects the GPU and finds
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
 arch/ia64/pci/fixup.c      | 56 ++++-----------------------------------------
 arch/x86/include/asm/vga.h |  6 -----
 arch/x86/pci/fixup.c       | 53 +-----------------------------------------
 drivers/gpu/vga/vgaarb.c   | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/video/efifb.c      | 38 -------------------------------
 include/linux/vgaarb.h     | 37 ++++++++++++++++++++++++++++++
 6 files changed, 99 insertions(+), 148 deletions(-)

diff --git a/arch/ia64/pci/fixup.c b/arch/ia64/pci/fixup.c
index 5dc969d..b036423 100644
--- a/arch/ia64/pci/fixup.c
+++ b/arch/ia64/pci/fixup.c
@@ -5,65 +5,17 @@
 
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/vgaarb.h>
 
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
- * See pci_map_rom() for use of this flag. IORESOURCE_ROM_SHADOW
- * is marked here since the boot video device will be the only enabled
- * video device at this point.
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
 
-	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
-		return;
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
-	pci_read_config_word(pdev, PCI_COMMAND, &config);
-	if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
-		pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
-		dev_printk(KERN_DEBUG, &pdev->dev, "Boot video device\n");
-	}
+	pci_fixup_video(pdev);
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_video);
+DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA, 8, pci_ia64_fixup_video);
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
index bca9e85..22a4fbe 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -302,58 +302,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PB1,	pcie_r
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
- * See pci_map_rom() for use of this flag. IORESOURCE_ROM_SHADOW
- * is marked here since the boot video device will be the only enabled
- * video device at this point.
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
-	pci_read_config_word(pdev, PCI_COMMAND, &config);
-	if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
-		pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
-		dev_printk(KERN_DEBUG, &pdev->dev, "Boot video device\n");
-		if (!vga_default_device())
-			vga_set_default_device(pdev);
-	}
-}
+/* pci_fixup_video shared in vgaarb.c */
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
 				PCI_CLASS_DISPLAY_VGA, 8, pci_fixup_video);
 
diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index af02597..3ab9e35 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -149,6 +149,63 @@ void vga_set_default_device(struct pci_dev *pdev)
 }
 #endif
 
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
+	pci_read_config_word(pdev, PCI_COMMAND, &config);
+	if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
+		pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
+		dev_printk(KERN_DEBUG, &pdev->dev, "Boot video device\n");
+		if (!vga_default_device())
+			vga_set_default_device(pdev);
+	}
+}
+
 static inline void vga_irq_set_state(struct vga_device *vgadev, bool state)
 {
 	if (vgadev->irq_set_state)
diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
index cd7c0df..954465e 100644
--- a/drivers/video/efifb.c
+++ b/drivers/video/efifb.c
@@ -19,8 +19,6 @@
 
 static bool request_mem_succeeded = false;
 
-static struct pci_dev *default_vga;
-
 static struct fb_var_screeninfo efifb_defined = {
 	.activate		= FB_ACTIVATE_NOW,
 	.height			= -1,
@@ -85,18 +83,6 @@ static struct fb_ops efifb_ops = {
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
@@ -127,30 +113,6 @@ static int efifb_setup(char *options)
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
