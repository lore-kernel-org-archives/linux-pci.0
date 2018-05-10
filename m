Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752104AbeEJWJR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 May 2018 18:09:17 -0400
Subject: [PATCH 1/2] PCI: Reorder quirks infrastructure code
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Thu, 10 May 2018 17:09:14 -0500
Message-ID: <152599015450.234504.15171062726904355260.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152599011048.234504.9006188618412032582.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152599011048.234504.9006188618412032582.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

The infrastructure that applies PCI quirks was buried in the middle of the
quirks themselves (at one time it was probably at the end of the file, but
new quirks tend to be added at the end of the file).  Move it all to the
top of the file so it's easy to find.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/quirks.c |  314 +++++++++++++++++++++++++-------------------------
 1 file changed, 156 insertions(+), 158 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 2990ad1e7c99..0f2b117cc59c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -30,6 +30,162 @@
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
 
+static ktime_t fixup_debug_start(struct pci_dev *dev,
+				 void (*fn)(struct pci_dev *dev))
+{
+	if (initcall_debug)
+		pci_info(dev, "calling  %pF @ %i\n", fn, task_pid_nr(current));
+
+	return ktime_get();
+}
+
+static void fixup_debug_report(struct pci_dev *dev, ktime_t calltime,
+			       void (*fn)(struct pci_dev *dev))
+{
+	ktime_t delta, rettime;
+	unsigned long long duration;
+
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
+	if (initcall_debug || duration > 10000)
+		pci_info(dev, "%pF took %lld usecs\n", fn, duration);
+}
+
+static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
+			  struct pci_fixup *end)
+{
+	ktime_t calltime;
+
+	for (; f < end; f++)
+		if ((f->class == (u32) (dev->class >> f->class_shift) ||
+		     f->class == (u32) PCI_ANY_ID) &&
+		    (f->vendor == dev->vendor ||
+		     f->vendor == (u16) PCI_ANY_ID) &&
+		    (f->device == dev->device ||
+		     f->device == (u16) PCI_ANY_ID)) {
+			calltime = fixup_debug_start(dev, f->hook);
+			f->hook(dev);
+			fixup_debug_report(dev, calltime, f->hook);
+		}
+}
+
+extern struct pci_fixup __start_pci_fixups_early[];
+extern struct pci_fixup __end_pci_fixups_early[];
+extern struct pci_fixup __start_pci_fixups_header[];
+extern struct pci_fixup __end_pci_fixups_header[];
+extern struct pci_fixup __start_pci_fixups_final[];
+extern struct pci_fixup __end_pci_fixups_final[];
+extern struct pci_fixup __start_pci_fixups_enable[];
+extern struct pci_fixup __end_pci_fixups_enable[];
+extern struct pci_fixup __start_pci_fixups_resume[];
+extern struct pci_fixup __end_pci_fixups_resume[];
+extern struct pci_fixup __start_pci_fixups_resume_early[];
+extern struct pci_fixup __end_pci_fixups_resume_early[];
+extern struct pci_fixup __start_pci_fixups_suspend[];
+extern struct pci_fixup __end_pci_fixups_suspend[];
+extern struct pci_fixup __start_pci_fixups_suspend_late[];
+extern struct pci_fixup __end_pci_fixups_suspend_late[];
+
+static bool pci_apply_fixup_final_quirks;
+
+void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
+{
+	struct pci_fixup *start, *end;
+
+	switch (pass) {
+	case pci_fixup_early:
+		start = __start_pci_fixups_early;
+		end = __end_pci_fixups_early;
+		break;
+
+	case pci_fixup_header:
+		start = __start_pci_fixups_header;
+		end = __end_pci_fixups_header;
+		break;
+
+	case pci_fixup_final:
+		if (!pci_apply_fixup_final_quirks)
+			return;
+		start = __start_pci_fixups_final;
+		end = __end_pci_fixups_final;
+		break;
+
+	case pci_fixup_enable:
+		start = __start_pci_fixups_enable;
+		end = __end_pci_fixups_enable;
+		break;
+
+	case pci_fixup_resume:
+		start = __start_pci_fixups_resume;
+		end = __end_pci_fixups_resume;
+		break;
+
+	case pci_fixup_resume_early:
+		start = __start_pci_fixups_resume_early;
+		end = __end_pci_fixups_resume_early;
+		break;
+
+	case pci_fixup_suspend:
+		start = __start_pci_fixups_suspend;
+		end = __end_pci_fixups_suspend;
+		break;
+
+	case pci_fixup_suspend_late:
+		start = __start_pci_fixups_suspend_late;
+		end = __end_pci_fixups_suspend_late;
+		break;
+
+	default:
+		/* stupid compiler warning, you would think with an enum... */
+		return;
+	}
+	pci_do_fixups(dev, start, end);
+}
+EXPORT_SYMBOL(pci_fixup_device);
+
+static int __init pci_apply_final_quirks(void)
+{
+	struct pci_dev *dev = NULL;
+	u8 cls = 0;
+	u8 tmp;
+
+	if (pci_cache_line_size)
+		printk(KERN_DEBUG "PCI: CLS %u bytes\n",
+		       pci_cache_line_size << 2);
+
+	pci_apply_fixup_final_quirks = true;
+	for_each_pci_dev(dev) {
+		pci_fixup_device(pci_fixup_final, dev);
+		/*
+		 * If arch hasn't set it explicitly yet, use the CLS
+		 * value shared by all PCI devices.  If there's a
+		 * mismatch, fall back to the default value.
+		 */
+		if (!pci_cache_line_size) {
+			pci_read_config_byte(dev, PCI_CACHE_LINE_SIZE, &tmp);
+			if (!cls)
+				cls = tmp;
+			if (!tmp || cls == tmp)
+				continue;
+
+			printk(KERN_DEBUG "PCI: CLS mismatch (%u != %u), using %u bytes\n",
+			       cls << 2, tmp << 2,
+			       pci_dfl_cache_line_size << 2);
+			pci_cache_line_size = pci_dfl_cache_line_size;
+		}
+	}
+
+	if (!pci_cache_line_size) {
+		printk(KERN_DEBUG "PCI: CLS %u bytes, default %u\n",
+		       cls << 2, pci_dfl_cache_line_size << 2);
+		pci_cache_line_size = cls ? cls : pci_dfl_cache_line_size;
+	}
+
+	return 0;
+}
+fs_initcall_sync(pci_apply_final_quirks);
+
 /*
  * Decoding should be disabled for a PCI device during BAR sizing to avoid
  * conflict. But doing so may cause problems on host bridge and perhaps other
@@ -2981,28 +3137,6 @@ static void quirk_intel_ntb(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0e08, quirk_intel_ntb);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0e0d, quirk_intel_ntb);
 
-static ktime_t fixup_debug_start(struct pci_dev *dev,
-				 void (*fn)(struct pci_dev *dev))
-{
-	if (initcall_debug)
-		pci_info(dev, "calling  %pF @ %i\n", fn, task_pid_nr(current));
-
-	return ktime_get();
-}
-
-static void fixup_debug_report(struct pci_dev *dev, ktime_t calltime,
-			       void (*fn)(struct pci_dev *dev))
-{
-	ktime_t delta, rettime;
-	unsigned long long duration;
-
-	rettime = ktime_get();
-	delta = ktime_sub(rettime, calltime);
-	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
-	if (initcall_debug || duration > 10000)
-		pci_info(dev, "%pF took %lld usecs\n", fn, duration);
-}
-
 /*
  * Some BIOS implementations leave the Intel GPU interrupts enabled,
  * even though no one is handling them (f.e. i915 driver is never loaded).
@@ -3397,142 +3531,6 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
 			       quirk_apple_wait_for_thunderbolt);
 #endif
 
-static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
-			  struct pci_fixup *end)
-{
-	ktime_t calltime;
-
-	for (; f < end; f++)
-		if ((f->class == (u32) (dev->class >> f->class_shift) ||
-		     f->class == (u32) PCI_ANY_ID) &&
-		    (f->vendor == dev->vendor ||
-		     f->vendor == (u16) PCI_ANY_ID) &&
-		    (f->device == dev->device ||
-		     f->device == (u16) PCI_ANY_ID)) {
-			calltime = fixup_debug_start(dev, f->hook);
-			f->hook(dev);
-			fixup_debug_report(dev, calltime, f->hook);
-		}
-}
-
-extern struct pci_fixup __start_pci_fixups_early[];
-extern struct pci_fixup __end_pci_fixups_early[];
-extern struct pci_fixup __start_pci_fixups_header[];
-extern struct pci_fixup __end_pci_fixups_header[];
-extern struct pci_fixup __start_pci_fixups_final[];
-extern struct pci_fixup __end_pci_fixups_final[];
-extern struct pci_fixup __start_pci_fixups_enable[];
-extern struct pci_fixup __end_pci_fixups_enable[];
-extern struct pci_fixup __start_pci_fixups_resume[];
-extern struct pci_fixup __end_pci_fixups_resume[];
-extern struct pci_fixup __start_pci_fixups_resume_early[];
-extern struct pci_fixup __end_pci_fixups_resume_early[];
-extern struct pci_fixup __start_pci_fixups_suspend[];
-extern struct pci_fixup __end_pci_fixups_suspend[];
-extern struct pci_fixup __start_pci_fixups_suspend_late[];
-extern struct pci_fixup __end_pci_fixups_suspend_late[];
-
-static bool pci_apply_fixup_final_quirks;
-
-void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
-{
-	struct pci_fixup *start, *end;
-
-	switch (pass) {
-	case pci_fixup_early:
-		start = __start_pci_fixups_early;
-		end = __end_pci_fixups_early;
-		break;
-
-	case pci_fixup_header:
-		start = __start_pci_fixups_header;
-		end = __end_pci_fixups_header;
-		break;
-
-	case pci_fixup_final:
-		if (!pci_apply_fixup_final_quirks)
-			return;
-		start = __start_pci_fixups_final;
-		end = __end_pci_fixups_final;
-		break;
-
-	case pci_fixup_enable:
-		start = __start_pci_fixups_enable;
-		end = __end_pci_fixups_enable;
-		break;
-
-	case pci_fixup_resume:
-		start = __start_pci_fixups_resume;
-		end = __end_pci_fixups_resume;
-		break;
-
-	case pci_fixup_resume_early:
-		start = __start_pci_fixups_resume_early;
-		end = __end_pci_fixups_resume_early;
-		break;
-
-	case pci_fixup_suspend:
-		start = __start_pci_fixups_suspend;
-		end = __end_pci_fixups_suspend;
-		break;
-
-	case pci_fixup_suspend_late:
-		start = __start_pci_fixups_suspend_late;
-		end = __end_pci_fixups_suspend_late;
-		break;
-
-	default:
-		/* stupid compiler warning, you would think with an enum... */
-		return;
-	}
-	pci_do_fixups(dev, start, end);
-}
-EXPORT_SYMBOL(pci_fixup_device);
-
-
-static int __init pci_apply_final_quirks(void)
-{
-	struct pci_dev *dev = NULL;
-	u8 cls = 0;
-	u8 tmp;
-
-	if (pci_cache_line_size)
-		printk(KERN_DEBUG "PCI: CLS %u bytes\n",
-		       pci_cache_line_size << 2);
-
-	pci_apply_fixup_final_quirks = true;
-	for_each_pci_dev(dev) {
-		pci_fixup_device(pci_fixup_final, dev);
-		/*
-		 * If arch hasn't set it explicitly yet, use the CLS
-		 * value shared by all PCI devices.  If there's a
-		 * mismatch, fall back to the default value.
-		 */
-		if (!pci_cache_line_size) {
-			pci_read_config_byte(dev, PCI_CACHE_LINE_SIZE, &tmp);
-			if (!cls)
-				cls = tmp;
-			if (!tmp || cls == tmp)
-				continue;
-
-			printk(KERN_DEBUG "PCI: CLS mismatch (%u != %u), using %u bytes\n",
-			       cls << 2, tmp << 2,
-			       pci_dfl_cache_line_size << 2);
-			pci_cache_line_size = pci_dfl_cache_line_size;
-		}
-	}
-
-	if (!pci_cache_line_size) {
-		printk(KERN_DEBUG "PCI: CLS %u bytes, default %u\n",
-		       cls << 2, pci_dfl_cache_line_size << 2);
-		pci_cache_line_size = cls ? cls : pci_dfl_cache_line_size;
-	}
-
-	return 0;
-}
-
-fs_initcall_sync(pci_apply_final_quirks);
-
 /*
  * Following are device-specific reset methods which can be used to
  * reset a single function if other methods (e.g. FLR, PM D0->D3) are
