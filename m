Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36628 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbbGIBzB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jul 2015 21:55:01 -0400
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: mingo@kernel.org
Cc: bp@suse.de, arnd@arndb.de, bhelgaas@google.com,
	luto@amacapital.net, akpm@linux-foundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	tomi.valkeinen@ti.com, mst@redhat.com, toshi.kani@hp.com,
	linux-fbdev@vger.kernel.org, xen-devel@lists.xensource.com,
	benh@kernel.crashing.org, "Luis R. Rodriguez" <mcgrof@suse.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Juergen Gross <jgross@suse.com>,
	"Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
	Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v9 7/8] drivers/video/fbdev/s3fb: Use arch_phys_wc_add() and pci_iomap_wc()
Date: Wed,  8 Jul 2015 18:54:18 -0700
Message-Id: <1436406859-1280-8-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1436406859-1280-1-git-send-email-mcgrof@do-not-panic.com>
References: <1436406859-1280-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This driver uses the same area for MTRR as for the ioremap().

Convert the driver from using the x86-specific MTRR code to the
architecture-agnostic arch_phys_wc_add(). It will avoid MTRRs if
write-combining is available. In order to take advantage of that
also ensure the ioremapped area is requested as write-combining.

There are a few motivations for this:

a) Take advantage of PAT when available.

b) Help bury MTRR code away, MTRR is architecture-specific and on
   x86 it is being replaced by PAT.

c) Help with the goal of eventually using _PAGE_CACHE_UC over
   _PAGE_CACHE_UC_MINUS on x86 on ioremap_nocache() (see commit
   de33c442e titled "x86 PAT: fix performance drop for glx,
   use UC minus for ioremap(), ioremap_nocache() and
   pci_mmap_page_range()").

The conversion done is expressed by the following Coccinelle
SmPL patch, it additionally required manual intervention to
address all the ifdeffery and removal of redundant things which
arch_phys_wc_add() already addresses such as verbose message about
when MTRR fails and doing nothing when we didn't get an MTRR.

@ mtrr_found @
expression index, base, size;
@@

-index = mtrr_add(base, size, MTRR_TYPE_WRCOMB, 1);
+index = arch_phys_wc_add(base, size);

@ mtrr_rm depends on mtrr_found @
expression mtrr_found.index, mtrr_found.base, mtrr_found.size;
@@

-mtrr_del(index, base, size);
+arch_phys_wc_del(index);

@ mtrr_rm_zero_arg depends on mtrr_found @
expression mtrr_found.index;
@@

-mtrr_del(index, 0, 0);
+arch_phys_wc_del(index);

@ mtrr_rm_fb_info depends on mtrr_found @
struct fb_info *info;
expression mtrr_found.index;
@@

-mtrr_del(index, info->fix.smem_start, info->fix.smem_len);
+arch_phys_wc_del(index);

@ ioremap_replace_nocache depends on mtrr_found @
struct fb_info *info;
expression base, size;
@@

-info->screen_base = ioremap_nocache(base, size);
+info->screen_base = ioremap_wc(base, size);

@ ioremap_replace_default depends on mtrr_found @
struct fb_info *info;
expression base, size;
@@

-info->screen_base = ioremap(base, size);
+info->screen_base = ioremap_wc(base, size);

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: benh@kernel.crashing.org
Cc: bhelgaas@google.com
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: mst@redhat.com
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Suresh Siddha <sbsiddha@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: toshi.kani@hp.com
Link: http://lkml.kernel.org/r/1435195342-26879-9-git-send-email-mcgrof@do-not-panic.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/video/fbdev/s3fb.c | 35 ++++++-----------------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/video/fbdev/s3fb.c b/drivers/video/fbdev/s3fb.c
index f0ae61a37f04..13b109073c63 100644
--- a/drivers/video/fbdev/s3fb.c
+++ b/drivers/video/fbdev/s3fb.c
@@ -28,13 +28,9 @@
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 
-#ifdef CONFIG_MTRR
-#include <asm/mtrr.h>
-#endif
-
 struct s3fb_info {
 	int chip, rev, mclk_freq;
-	int mtrr_reg;
+	int wc_cookie;
 	struct vgastate state;
 	struct mutex open_lock;
 	unsigned int ref_count;
@@ -154,11 +150,7 @@ static const struct svga_timing_regs s3_timing_regs     = {
 
 
 static char *mode_option;
-
-#ifdef CONFIG_MTRR
 static int mtrr = 1;
-#endif
-
 static int fasttext = 1;
 
 
@@ -170,11 +162,8 @@ module_param(mode_option, charp, 0444);
 MODULE_PARM_DESC(mode_option, "Default video mode ('640x480-8@60', etc)");
 module_param_named(mode, mode_option, charp, 0444);
 MODULE_PARM_DESC(mode, "Default video mode ('640x480-8@60', etc) (deprecated)");
-
-#ifdef CONFIG_MTRR
 module_param(mtrr, int, 0444);
 MODULE_PARM_DESC(mtrr, "Enable write-combining with MTRR (1=enable, 0=disable, default=1)");
-#endif
 
 module_param(fasttext, int, 0644);
 MODULE_PARM_DESC(fasttext, "Enable S3 fast text mode (1=enable, 0=disable, default=1)");
@@ -1168,7 +1157,7 @@ static int s3_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	info->fix.smem_len = pci_resource_len(dev, 0);
 
 	/* Map physical IO memory address into kernel space */
-	info->screen_base = pci_iomap(dev, 0, 0);
+	info->screen_base = pci_iomap_wc(dev, 0, 0);
 	if (! info->screen_base) {
 		rc = -ENOMEM;
 		dev_err(info->device, "iomap for framebuffer failed\n");
@@ -1365,12 +1354,9 @@ static int s3_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	/* Record a reference to the driver data */
 	pci_set_drvdata(dev, info);
 
-#ifdef CONFIG_MTRR
-	if (mtrr) {
-		par->mtrr_reg = -1;
-		par->mtrr_reg = mtrr_add(info->fix.smem_start, info->fix.smem_len, MTRR_TYPE_WRCOMB, 1);
-	}
-#endif
+	if (mtrr)
+		par->wc_cookie = arch_phys_wc_add(info->fix.smem_start,
+						  info->fix.smem_len);
 
 	return 0;
 
@@ -1405,14 +1391,7 @@ static void s3_pci_remove(struct pci_dev *dev)
 
 	if (info) {
 		par = info->par;
-
-#ifdef CONFIG_MTRR
-		if (par->mtrr_reg >= 0) {
-			mtrr_del(par->mtrr_reg, 0, 0);
-			par->mtrr_reg = -1;
-		}
-#endif
-
+		arch_phys_wc_del(par->wc_cookie);
 		unregister_framebuffer(info);
 		fb_dealloc_cmap(&info->cmap);
 
@@ -1551,10 +1530,8 @@ static int  __init s3fb_setup(char *options)
 
 		if (!*opt)
 			continue;
-#ifdef CONFIG_MTRR
 		else if (!strncmp(opt, "mtrr:", 5))
 			mtrr = simple_strtoul(opt + 5, NULL, 0);
-#endif
 		else if (!strncmp(opt, "fasttext:", 9))
 			fasttext = simple_strtoul(opt + 9, NULL, 0);
 		else
-- 
2.3.2.209.gd67f9d5.dirty

