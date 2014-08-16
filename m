Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:42650 "EHLO
	hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbaHPRb7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 16 Aug 2014 13:31:59 -0400
Date: Sat, 16 Aug 2014 19:30:39 +0200
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To: Andreas Noever <andreas.noever@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Dave Airlie <airlied@linux.ie>,
	Matthew Garrett <matthew.garrett@nebula.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/2] x86, ia64: Don't default to first video device
Message-ID: <20140816193039.76304abb@neptune.home>
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

For dual-GPU Apple computers above above change represents a regression
as code in efifb did forcefully override vga_default_device while the
merge did not (changed ordering of actions).

This stops setting default_vga_device when applying
IORESOURCE_ROM_SHADOW (only doing so for the detected boot GPU) and
updates logging of boot video device selection, in vgaarb which covers
VGA text-mode booting and first half of pci_fixup_video which covers
framebuffer mode (EFI, VESA).

By setting IORESOURCE_ROM_SHADOW only on effective boot GPU we also
corrects a longstanding complaint from intel driver as reported by
Andreas:
  > Does setting the ROM_SHADOW flag on (possibly) the wrong device
  > have any effect?
  Yes it does. Removing the line changes a long standing
    i915 0000:00:02.0: Invalid ROM contents
  into a
    i915 0000:00:02.0: BAR 6: can't assign [??? 0x00000000 flags
    0x20000000] (bogus alignment).
  The first is logged at KERN_ERR while the second is at KERN_INFO.

Reported-By: Andreas Noever <andreas.noever@gmail.com>
Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: stable@vger.kernel.org # v3.5+
---
Must be applied to stable when upstream commit
20cde694027e7477cc532833e38ab9fcaa83fb64, which is marked for
stable, gets applied.

Can be applied without patch 1/2 from this series though dropped
#ifndefs will cause this patch not to apply cleanly.


 arch/ia64/pci/fixup.c    | 9 +++++----
 arch/x86/pci/fixup.c     | 9 +++++----
 drivers/gpu/vga/vgaarb.c | 4 +++-
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/ia64/pci/fixup.c b/arch/ia64/pci/fixup.c
index ec73b2c..05198f8 100644
--- a/arch/ia64/pci/fixup.c
+++ b/arch/ia64/pci/fixup.c
@@ -54,8 +54,10 @@ static void pci_fixup_video(struct pci_dev *pdev)
 				continue;
 
 			if (screen_info.lfb_base >= start &&
-			    (screen_info.lfb_base + screen_info.lfb_size) < end)
+			    (screen_info.lfb_base + screen_info.lfb_size) < end) {
+				dev_printk(KERN_DEBUG, &pdev->dev, "Boot video device\n");
 				vga_set_default_device(pdev);
+			}
 		}
 	}
 
@@ -79,12 +81,11 @@ static void pci_fixup_video(struct pci_dev *pdev)
 		}
 		bus = bus->parent;
 	}
-	if (!vga_default_device() || pdev == vga_default_device()) {
+	if (pdev == vga_default_device()) {
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
index c61ea57..5b392d2 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -342,8 +342,10 @@ static void pci_fixup_video(struct pci_dev *pdev)
 				continue;
 
 			if (screen_info.lfb_base >= start &&
-			    (screen_info.lfb_base + screen_info.lfb_size) < end)
+			    (screen_info.lfb_base + screen_info.lfb_size) < end) {
+				dev_printk(KERN_DEBUG, &pdev->dev, "Boot video device\n");
 				vga_set_default_device(pdev);
+			}
 		}
 	}
 
@@ -367,12 +369,11 @@ static void pci_fixup_video(struct pci_dev *pdev)
 		}
 		bus = bus->parent;
 	}
-	if (!vga_default_device() || pdev == vga_default_device()) {
+	if (pdev == vga_default_device()) {
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
index 257674d..c6eeed5 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -580,8 +580,10 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
 	 * by default if arch doesn't have it's own hook
 	 */
 	if (vga_default == NULL &&
-	    ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK))
+	    ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)) {
+		pr_info("vgaarb: Boot video device: PCI:%s\n", pci_name(pdev));
 		vga_set_default_device(pdev);
+	}
 
 	vga_arbiter_check_bridge_sharing(vgadev);
 
-- 
1.8.5.5

