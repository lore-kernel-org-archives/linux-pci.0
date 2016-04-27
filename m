Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58283 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753855AbcD0WWa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 27 Apr 2016 18:22:30 -0400
From: Alexander Graf <agraf@suse.de>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] arm64: Relocate screen_info.lfb_base on PCI BAR allocation
Date: Thu, 28 Apr 2016 00:22:24 +0200
Message-Id: <1461795744-28837-1-git-send-email-agraf@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When booting with efifb, we get a frame buffer address passed into the system.
This address can be backed by any device, including PCI devices.

PCI devices can have their BARs mapped to various places inside the PCI window
though. Linux makes use of that on early boot and usually maps PCI BARs wherever
it thinks makes sense.

If we now load the efifb driver after that BAR map has happened, the frame
buffer address we received may be invalid, because it was in a BAR map before
Linux modified it.

To work around that issue, this patch introduces a BAR mapping callback that
gets called every time Linux (re)allocates a BAR. That way our arm64 efi code
can check whether the frame buffer is inside the old map and adjust it to
the new one.

With this and the efifb patches applied, I can successfully see efifb output
even after Linux remapped BARs.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/arm64/kernel/efi.c | 40 +++++++++++++++++++++++++++++++++++++++-
 drivers/pci/setup-res.c | 29 +++++++++++++++++++++++++++++
 include/linux/pci.h     |  8 ++++++++
 3 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 56a76b6..3612110 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/platform_device.h>
+#include <linux/pci.h>
 
 #include <asm/cacheflush.h>
 #include <asm/efi.h>
@@ -213,6 +214,41 @@ static __init void reserve_regions(void)
 	set_bit(EFI_MEMMAP, &efi.flags);
 }
 
+#ifdef CONFIG_PCI
+static bool efi_pci_overlaps_efifb(struct pci_bar_update_info *update_info)
+{
+	/* is the screen_info frame buffer inside the pci BAR? */
+	if (screen_info.lfb_base >= update_info->old_start &&
+	    (screen_info.lfb_base + screen_info.lfb_size) <=
+	     (update_info->old_start + update_info->size))
+		return true;
+
+	return false;
+}
+
+static int efi_pci_notifier(struct notifier_block *self,
+			    unsigned long cmd, void *v)
+{
+	struct pci_bar_update_info *update_info = v;
+
+	/*
+	 * When we reallocate a BAR that contains our frame buffer, set the
+	 * screen_info base to where it belongs
+	 */
+	if (efi_pci_overlaps_efifb(update_info)) {
+		u64 diff = (update_info->new_start - update_info->old_start);
+		screen_info.lfb_base += diff;
+	}
+
+	return NOTIFY_OK;
+}
+static struct notifier_block efi_pci_notifier_block = {
+	.notifier_call = efi_pci_notifier,
+};
+#else
+#define pci_notify_on_update_resource(a)
+#endif
+
 void __init efi_init_fdt(void *fdt)
 {
 	struct efi_fdt_params params;
@@ -246,8 +282,10 @@ void __init efi_init_fdt(void *fdt)
 	reserve_regions();
 	early_memunmap(memmap.map, params.mmap_size);
 
-	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI)
+	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI) {
+		pci_notify_on_update_resource(&efi_pci_notifier_block);
 		memblock_reserve(screen_info.lfb_base, screen_info.lfb_size);
+	}
 }
 
 static int __init register_gop_device(void)
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 604011e..d5c24fc 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -23,8 +23,10 @@
 #include <linux/ioport.h>
 #include <linux/cache.h>
 #include <linux/slab.h>
+#include <linux/notifier.h>
 #include "pci.h"
 
+static RAW_NOTIFIER_HEAD(bar_update_chain);
 
 void pci_update_resource(struct pci_dev *dev, int resno)
 {
@@ -35,6 +37,9 @@ void pci_update_resource(struct pci_dev *dev, int resno)
 	int reg;
 	enum pci_bar_type type;
 	struct resource *res = dev->resource + resno;
+	struct pci_bar_update_info update_info;
+	struct pci_bus_region update_reg;
+	struct resource update_res;
 
 	if (dev->is_virtfn) {
 		dev_warn(&dev->dev, "can't update VF BAR%d\n", resno);
@@ -77,6 +82,22 @@ void pci_update_resource(struct pci_dev *dev, int resno)
 	}
 
 	/*
+	 * Fetch the old BAR location from the device, so we can notify
+	 * users of that BAR that its location is changing.
+	 */
+	pci_read_config_dword(dev, reg, &check);
+	update_reg.start = check & PCI_BASE_ADDRESS_MEM_MASK;
+	if (check & PCI_BASE_ADDRESS_MEM_TYPE_64) {
+		pci_read_config_dword(dev, reg, &check);
+		update_reg.start |= ((u64)check) << 32;
+	}
+	update_info.size = region.end - region.start;
+	update_reg.end = update_reg.start + update_info.size;
+	pcibios_bus_to_resource(dev->bus, &update_res, &update_reg);
+	update_info.old_start = update_res.start;
+	update_info.new_start = res->start;
+
+	/*
 	 * We can't update a 64-bit BAR atomically, so when possible,
 	 * disable decoding so that a half-updated BAR won't conflict
 	 * with another device.
@@ -108,6 +129,14 @@ void pci_update_resource(struct pci_dev *dev, int resno)
 
 	if (disable)
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
+
+	/* Tell interested parties that the BAR mapping changed */
+	raw_notifier_call_chain(&bar_update_chain, 0, &update_info);
+}
+
+int pci_notify_on_update_resource(struct notifier_block *nb)
+{
+        return raw_notifier_chain_register(&bar_update_chain, nb);
 }
 
 int pci_claim_resource(struct pci_dev *dev, int resource)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c061250..04a430e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -30,6 +30,7 @@
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/resource_ext.h>
+#include <linux/notifier.h>
 #include <uapi/linux/pci.h>
 
 #include <linux/pci_ids.h>
@@ -1037,6 +1038,13 @@ int pci_select_bars(struct pci_dev *dev, unsigned long flags);
 bool pci_device_is_present(struct pci_dev *pdev);
 void pci_ignore_hotplug(struct pci_dev *dev);
 
+struct pci_bar_update_info {
+	u64 old_start;
+	u64 new_start;
+	u64 size;
+};
+int pci_notify_on_update_resource(struct notifier_block *nb);
+
 /* ROM control related routines */
 int pci_enable_rom(struct pci_dev *pdev);
 void pci_disable_rom(struct pci_dev *pdev);
-- 
1.8.5.6

