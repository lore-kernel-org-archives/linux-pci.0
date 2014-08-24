Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:45204 "EHLO
	hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbaHXVKC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 24 Aug 2014 17:10:02 -0400
Date: Sun, 24 Aug 2014 23:09:53 +0200
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To: Andreas Noever <andreas.noever@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	Matthew Garrett <matthew.garrett@nebula.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2 v2] vgaarb: Don't default exclusively to first video
 device with mem+io
Message-ID: <20140824230953.7c04890f@neptune.home>
In-Reply-To: <20140823130624.06ecc057@neptune.home>
References: <20140514224339.7f8be3a9@neptune.home>
	<20140625005501.7ff7e982@neptune.home>
	<20140705171503.GC6247@google.com>
	<CAMxnaaXxAZAJAdr5AYYRZC_xKFCuyrfY=qpJu8x+P-S+osm5vw@mail.gmail.com>
	<CAMxnaaXGQe4vg9cY5e2KZBnG4F-z49OriwxEGUE-DCE6MKUryQ@mail.gmail.com>
	<20140810112654.1bf684d6@neptune.home>
	<CAMxnaaUsd+XHppMmPMXdFL13d1-OhLzoH_yjv_9abOx_uP=_Ug@mail.gmail.com>
	<20140810183411.19370721@neptune.home>
	<CAMxnaaVNpiSZmhQsHa_ZHJckgzG+xHyOL6hOT3Ts8GdcGN_A9g@mail.gmail.com>
	<20140816192135.34260115@neptune.home>
	<CAMxnaaWQoX9KMQVCKHTkeqSxGEybz5u1qU6AVBqzW3+mj_nJHQ@mail.gmail.com>
	<20140820075508.74f5b622@pluto>
	<20140820091152.76cd4e1a@pluto>
	<CAMxnaaUodONkqmdPWedN-Q1qheHiJAScFcG_XbX1--ZmiOQZDg@mail.gmail.com>
	<20140821233435.19a9cffa@neptune.home>
	<CAErSpo6D1B+dPLrYoAF4OA1KeWuW8VZW2_RR5jB1GbCRo+6vHg@mail.gmail.com>
	<20140822082324.12cb6e93@pluto>
	<CAMxnaaU9EiMcne-aQjS1sY1Orn6xGbVHEnd057ogcZ77p74Y=Q@mail.gmail.com>
	<20140823130624.06ecc057@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

With commit 20cde694027e boot video device detection was moved from
efifb to x86 and ia64 pci/fixup.c.

For dual-GPU Apple computers above change represents a regression as
code in efifb did forcefully override vga_default_device while the
merge did not (vgaarb happens prior to PCI fixup).

To improve on initial device selection by vgaarb (it cannot know if
PCI device not behind bridges see/decode legacy VGA I/O or not), move
the screen_info based check from pci_video_fixup to vgaarb's init
function and use it to refine/override decision taken while adding
the individual PCI VGA devices.
This way PCI fixup has no reason to adjust vga_default_device
anymore but can depend on its value for flagging shadowed VBIOS.

This has the nice benefit of removing duplicated code but does
introduce a #if defined() block in vgaarb.
Not all architectures have screen_info and would cause compile to
fail without it.

Reported-By: Andreas Noever <andreas.noever@gmail.com>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: stable@vger.kernel.org # v3.5+
Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>
---
Andreas, does this work properly for you, including the improvement
on i915 complaint about VBIOS going from KERN_ERR to KERN_INFO?


Other arches using PCI and vgaarb that have screen_info may want
to be added to the #if defined() block or even introduce a new
CONFIG_HAVE_SCREEN_INFO or similar...


 arch/ia64/pci/fixup.c    | 24 +-----------------------
 arch/x86/pci/fixup.c     | 24 +-----------------------
 drivers/gpu/vga/vgaarb.c | 38 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 39 insertions(+), 47 deletions(-)

diff --git a/arch/ia64/pci/fixup.c b/arch/ia64/pci/fixup.c
index ec73b2c..fc505d5 100644
--- a/arch/ia64/pci/fixup.c
+++ b/arch/ia64/pci/fixup.c
@@ -38,27 +38,6 @@ static void pci_fixup_video(struct pci_dev *pdev)
 		return;
 	/* Maybe, this machine supports legacy memory map. */
 
-	if (!vga_default_device()) {
-		resource_size_t start, end;
-		int i;
-
-		/* Does firmware framebuffer belong to us? */
-		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
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
-			    (screen_info.lfb_base + screen_info.lfb_size) < end)
-				vga_set_default_device(pdev);
-		}
-	}
-
 	/* Is VGA routed to us? */
 	bus = pdev->bus;
 	while (bus) {
@@ -83,8 +62,7 @@ static void pci_fixup_video(struct pci_dev *pdev)
 		pci_read_config_word(pdev, PCI_COMMAND, &config);
 		if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
 			pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
-			dev_printk(KERN_DEBUG, &pdev->dev, "Boot video device\n");
-			vga_set_default_device(pdev);
+			dev_printk(KERN_DEBUG, &pdev->dev, "Video device with shadowed ROM\n");
 		}
 	}
 }
diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index c61ea57..9a2b710 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -326,27 +326,6 @@ static void pci_fixup_video(struct pci_dev *pdev)
 	struct pci_bus *bus;
 	u16 config;
 
-	if (!vga_default_device()) {
-		resource_size_t start, end;
-		int i;
-
-		/* Does firmware framebuffer belong to us? */
-		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
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
-			    (screen_info.lfb_base + screen_info.lfb_size) < end)
-				vga_set_default_device(pdev);
-		}
-	}
-
 	/* Is VGA routed to us? */
 	bus = pdev->bus;
 	while (bus) {
@@ -371,8 +350,7 @@ static void pci_fixup_video(struct pci_dev *pdev)
 		pci_read_config_word(pdev, PCI_COMMAND, &config);
 		if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
 			pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
-			dev_printk(KERN_DEBUG, &pdev->dev, "Boot video device\n");
-			vga_set_default_device(pdev);
+			dev_printk(KERN_DEBUG, &pdev->dev, "Video device with shadowed ROM\n");
 		}
 	}
 }
diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index d2077f0..cffdff9 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -41,6 +41,7 @@
 #include <linux/poll.h>
 #include <linux/miscdevice.h>
 #include <linux/slab.h>
+#include <linux/screen_info.h>
 
 #include <linux/uaccess.h>
 
@@ -585,8 +586,11 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
 	 */
 #ifndef __ARCH_HAS_VGA_DEFAULT_DEVICE
 	if (vga_default == NULL &&
-	    ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK))
+	    ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)) {
+		pr_info("vgaarb: setting as boot device: PCI:%s\n",
+			pci_name(pdev));
 		vga_set_default_device(pdev);
+	}
 #endif
 
 	vga_arbiter_check_bridge_sharing(vgadev);
@@ -1320,6 +1324,38 @@ static int __init vga_arb_device_init(void)
 	pr_info("vgaarb: loaded\n");
 
 	list_for_each_entry(vgadev, &vga_list, list) {
+#if defined(CONFIG_X86) || defined(CONFIG_IA64)
+		/* Override I/O based detection done by vga_arbiter_add_pci_device()
+		 * as it may take the wrong device (e.g. on Apple system under EFI).
+		 *
+		 * Select the device owning the boot framebuffer if there is one.
+		 */
+		resource_size_t start, end;
+		int i;
+
+		/* Does firmware framebuffer belong to us? */
+		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+			if (!(pci_resource_flags(vgadev->pdev, i) & IORESOURCE_MEM))
+				continue;
+
+			start = pci_resource_start(vgadev->pdev, i);
+			end  = pci_resource_end(vgadev->pdev, i);
+
+			if (!start || !end)
+				continue;
+
+			if (screen_info.lfb_base < start ||
+			    (screen_info.lfb_base + screen_info.lfb_size) >= end)
+				continue;
+			if (!vga_default_device())
+				pr_info("vgaarb: setting as boot device: PCI:%s\n",
+					pci_name(vgadev->pdev));
+			else if (vgadev->pdev != vga_default_device())
+				pr_info("vgaarb: overriding boot device: PCI:%s\n",
+					pci_name(vgadev->pdev));
+			vga_set_default_device(vgadev->pdev);
+		}
+#endif
 		if (vgadev->bridge_has_one_vga)
 			pr_info("vgaarb: bridge control possible %s\n", pci_name(vgadev->pdev));
 		else
-- 
1.8.5.5

