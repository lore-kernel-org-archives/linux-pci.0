Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:38925 "EHLO
	hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117AbaHXVNU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 24 Aug 2014 17:13:20 -0400
Date: Sun, 24 Aug 2014 23:13:15 +0200
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To: Andreas Noever <andreas.noever@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	Matthew Garrett <matthew.garrett@nebula.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2 v2] vgaarb: Drop obsolete #ifndef
Message-ID: <20140824231315.648a4cf6@neptune.home>
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

Remove the left-over #ifndef check that will allways match since
the corresponding arch-specific define is gone with above patch.

Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>
CC: Matthew Garrett <matthew.garrett@nebula.com>
---

No fundamental change from previous iteration, just reversed the
patch ordering and dropped the stable@ tag as this is just clean-up.


 drivers/gpu/vga/vgaarb.c | 8 --------
 include/linux/vgaarb.h   | 2 --
 2 files changed, 10 deletions(-)

diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index cffdff9..fb28314 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -113,10 +113,8 @@ both:
 	return 1;
 }
 
-#ifndef __ARCH_HAS_VGA_DEFAULT_DEVICE
 /* this is only used a cookie - it should not be dereferenced */
 static struct pci_dev *vga_default;
-#endif
 
 static void vga_arb_device_card_gone(struct pci_dev *pdev);
 
@@ -132,7 +130,6 @@ static struct vga_device *vgadev_find(struct pci_dev *pdev)
 }
 
 /* Returns the default VGA device (vgacon's babe) */
-#ifndef __ARCH_HAS_VGA_DEFAULT_DEVICE
 struct pci_dev *vga_default_device(void)
 {
 	return vga_default;
@@ -148,7 +145,6 @@ void vga_set_default_device(struct pci_dev *pdev)
 	pci_dev_put(vga_default);
 	vga_default = pci_dev_get(pdev);
 }
-#endif
 
 static inline void vga_irq_set_state(struct vga_device *vgadev, bool state)
 {
@@ -584,14 +580,12 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
 	/* Deal with VGA default device. Use first enabled one
 	 * by default if arch doesn't have it's own hook
 	 */
-#ifndef __ARCH_HAS_VGA_DEFAULT_DEVICE
 	if (vga_default == NULL &&
 	    ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)) {
 		pr_info("vgaarb: setting as boot device: PCI:%s\n",
 			pci_name(pdev));
 		vga_set_default_device(pdev);
 	}
-#endif
 
 	vga_arbiter_check_bridge_sharing(vgadev);
 
@@ -625,10 +619,8 @@ static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
 		goto bail;
 	}
 
-#ifndef __ARCH_HAS_VGA_DEFAULT_DEVICE
 	if (vga_default == pdev)
 		vga_set_default_device(NULL);
-#endif
 
 	if (vgadev->decodes & (VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM))
 		vga_decode_count--;
diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
index 2c02f3a..c37bd4d 100644
--- a/include/linux/vgaarb.h
+++ b/include/linux/vgaarb.h
@@ -182,7 +182,6 @@ extern void vga_put(struct pci_dev *pdev, unsigned int rsrc);
  *     vga_get()...
  */
 
-#ifndef __ARCH_HAS_VGA_DEFAULT_DEVICE
 #ifdef CONFIG_VGA_ARB
 extern struct pci_dev *vga_default_device(void);
 extern void vga_set_default_device(struct pci_dev *pdev);
@@ -190,7 +189,6 @@ extern void vga_set_default_device(struct pci_dev *pdev);
 static inline struct pci_dev *vga_default_device(void) { return NULL; };
 static inline void vga_set_default_device(struct pci_dev *pdev) { };
 #endif
-#endif
 
 /**
  *     vga_conflicts
-- 
1.8.5.5

