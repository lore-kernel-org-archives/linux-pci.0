Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:49130 "EHLO
	hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbaHPRb6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 16 Aug 2014 13:31:58 -0400
Date: Sat, 16 Aug 2014 19:25:16 +0200
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To: Andreas Noever <andreas.noever@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Dave Airlie <airlied@linux.ie>,
	Matthew Garrett <matthew.garrett@nebula.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] vgaarb: Drop obsolete #ifndef
 __ARCH_HAS_VGA_DEFAULT_DEVICE
Message-ID: <20140816192516.43d762d2@neptune.home>
In-Reply-To: <20140816192135.34260115@neptune.home>
References: <20140514224339.7f8be3a9@neptune.home>
	<20140527234255.GJ11907@google.com>
	<20140602201650.35f0e936@neptune.home>
	<20140602201926.4d476818@neptune.home>
	<20140625005501.7ff7e982@neptune.home>
	<20140705171503.GC6247@google.com>
	<CAMxnaaXxAZAJAdr5AYYRZC_xKFCuyrfY=qpJu8x+P-S+osm5vw@mail.gmail.com>
	<CAMxnaaXGQe4vg9cY5e2KZBnG4F-z49OriwxEGUE-DCE6MKUryQ@mail.gmail.com>
	<20140810112654.1bf684d6@neptune.home>
	<CAMxnaaUsd+XHppMmPMXdFL13d1-OhLzoH_yjv_9abOx_uP=_Ug@mail.gmail.com>
	<20140810183411.19370721@neptune.home>
	<CAMxnaaVNpiSZmhQsHa_ZHJckgzG+xHyOL6hOT3Ts8GdcGN_A9g@mail.gmail.com>
	<20140816192135.34260115@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

With commit 20cde694027e boot video device detection was moved from
efifb to x86 and ia64 pci/fixup.c.

Remove the left-over #ifndef check that will allways match since
the corresponding arch-specific define is gone with above patch.

Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: stable@vger.kernel.org # v3.5+
---
May be applied to stable as cleanup for upstream commit
20cde694027e7477cc532833e38ab9fcaa83fb64 which is marked for
stable.

 drivers/gpu/vga/vgaarb.c | 8 --------
 include/linux/vgaarb.h   | 2 --
 2 files changed, 10 deletions(-)

diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index d2077f0..257674d 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -112,10 +112,8 @@ both:
 	return 1;
 }
 
-#ifndef __ARCH_HAS_VGA_DEFAULT_DEVICE
 /* this is only used a cookie - it should not be dereferenced */
 static struct pci_dev *vga_default;
-#endif
 
 static void vga_arb_device_card_gone(struct pci_dev *pdev);
 
@@ -131,7 +129,6 @@ static struct vga_device *vgadev_find(struct pci_dev *pdev)
 }
 
 /* Returns the default VGA device (vgacon's babe) */
-#ifndef __ARCH_HAS_VGA_DEFAULT_DEVICE
 struct pci_dev *vga_default_device(void)
 {
 	return vga_default;
@@ -147,7 +144,6 @@ void vga_set_default_device(struct pci_dev *pdev)
 	pci_dev_put(vga_default);
 	vga_default = pci_dev_get(pdev);
 }
-#endif
 
 static inline void vga_irq_set_state(struct vga_device *vgadev, bool state)
 {
@@ -583,11 +579,9 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
 	/* Deal with VGA default device. Use first enabled one
 	 * by default if arch doesn't have it's own hook
 	 */
-#ifndef __ARCH_HAS_VGA_DEFAULT_DEVICE
 	if (vga_default == NULL &&
 	    ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK))
 		vga_set_default_device(pdev);
-#endif
 
 	vga_arbiter_check_bridge_sharing(vgadev);
 
@@ -621,10 +615,8 @@ static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
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

