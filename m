Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:45827 "EHLO
	hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204Ab3K3Nw2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 30 Nov 2013 08:52:28 -0500
Date: Sat, 30 Nov 2013 14:52:22 +0100
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To: dri-devel@lists.freedesktop.org
Cc: Dave Airlie <airlied@linux.ie>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Peter Jones <pjones@redhat.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Matthew Garrett <mjg@redhat.com>, matt.fleming@intel.com,
	hpa@zytor.com, David Herrmann <dh.herrmann@gmail.com>
Subject: [RFC patch v2] x86: Improve boot_vga/vga_default_device() for EFI
Message-ID: <20131130145222.292c3f9f@neptune.home>
In-Reply-To: <20131125205441.5046e0cb@neptune.home>
References: <20131125205441.5046e0cb@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

With commit b4aa0163056b6c70029b6e8619ce07c274351f42 Matthew Garret
introduced a efifb vga_default_device() so that EFI systems that do not
load shadow VBIOS or setup VGA get proper value for boot_vga PCI sysfs
attribute on the corresponding PCI device.

Xorg is refusing to detect devices when boot_vga=0 which is the case
on some EFI system (e.g. MacBookAir2,1). Xorg detects the GPU and finds
the dri device but then bails out with "no devices detected".

With introduction of sysfb/simplefb/simpledrm efifb is getting obsolete
while having native drivers for the GPU also makes selecting sysfb/efifb
optional.

Remove the efifb implementation of vga_default_device() and initialize
vgaarb's vga_default_device() with the PCI GPU that matches boot
screen_info in x86's pci_fixup_video().

Notes:
- Other architectures with PCI GPU might need a similar fixup.
- If CONFIG_VGA_ARB is unset vga_default_device() is only available
  as a stub that returns NULL, making this adjustment insufficient.
  Unsetting CONFIG_VGA_ARB requires CONFIG_EXPERT=y though.

Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>
---
 arch/x86/include/asm/vga.h |  6 ------
 arch/x86/pci/fixup.c       | 21 +++++++++++++++++++++
 drivers/video/efifb.c      | 38 --------------------------------------
 3 files changed, 21 insertions(+), 44 deletions(-)

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
index f5809fa..440343e 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -6,6 +6,7 @@
 #include <linux/dmi.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/screen_info.h>
 #include <linux/vgaarb.h>
 #include <asm/pci_x86.h>
 
@@ -323,6 +324,26 @@ static void pci_fixup_video(struct pci_dev *pdev)
 	struct pci_bus *bus;
 	u16 config;
 
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
 	/* Is VGA routed to us? */
 	bus = pdev->bus;
 	while (bus) {
diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
index 7f9ff75..fb3fb50 100644
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
 
