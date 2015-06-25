Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35960 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbbFYBoZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2015 21:44:25 -0400
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: bp@suse.de
Cc: mingo@kernel.org, arnd@arndb.de, bhelgaas@google.com,
	luto@amacapital.net, akpm@linux-foundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	tomi.valkeinen@ti.com, mst@redhat.com, toshi.kani@hp.com,
	linux-fbdev@vger.kernel.org, xen-devel@lists.xensource.com,
	benh@kernel.crashing.org, "Luis R. Rodriguez" <mcgrof@suse.com>,
	Rob Clark <robdclark@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jingoo Han <jg1.han@samsung.com>,
	"Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Subject: [PATCH v8 9/9] video: fbdev: vt8623fb: use arch_phys_wc_add() and pci_iomap_wc()
Date: Wed, 24 Jun 2015 18:22:22 -0700
Message-Id: <1435195342-26879-10-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1435195342-26879-1-git-send-email-mcgrof@do-not-panic.com>
References: <1435195342-26879-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This driver uses the same area for MTRR as for the ioremap().
Convert the driver from using the x86 specific MTRR code to
the architecture agnostic arch_phys_wc_add(). arch_phys_wc_add()
will avoid MTRR if write-combining is available, in order to
take advantage of that also ensure the ioremap'd area is requested
as write-combining.

There are a few motivations for this:

a) Take advantage of PAT when available

b) Help bury MTRR code away, MTRR is architecture specific and on
   x86 its replaced by PAT

c) Help with the goal of eventually using _PAGE_CACHE_UC over
   _PAGE_CACHE_UC_MINUS on x86 on ioremap_nocache() (see commit
   de33c442e titled "x86 PAT: fix performance drop for glx,
   use UC minus for ioremap(), ioremap_nocache() and
   pci_mmap_page_range()")

The conversion done is expressed by the following Coccinelle
SmPL patch, it additionally required manual intervention to
address all the #ifdery and removal of redundant things which
arch_phys_wc_add() already addresses such as verbose message
about when MTRR fails and doing nothing when we didn't get
an MTRR.

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

Generated-by: Coccinelle SmPL
Cc: Rob Clark <robdclark@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Suresh Siddha <sbsiddha@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 drivers/video/fbdev/vt8623fb.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/video/fbdev/vt8623fb.c b/drivers/video/fbdev/vt8623fb.c
index ea7f056..60f24828 100644
--- a/drivers/video/fbdev/vt8623fb.c
+++ b/drivers/video/fbdev/vt8623fb.c
@@ -26,13 +26,9 @@
 #include <linux/console.h> /* Why should fb driver call console functions? because console_lock() */
 #include <video/vga.h>
 
-#ifdef CONFIG_MTRR
-#include <asm/mtrr.h>
-#endif
-
 struct vt8623fb_info {
 	char __iomem *mmio_base;
-	int mtrr_reg;
+	int wc_cookie;
 	struct vgastate state;
 	struct mutex open_lock;
 	unsigned int ref_count;
@@ -99,10 +95,7 @@ static struct svga_timing_regs vt8623_timing_regs     = {
 /* Module parameters */
 
 static char *mode_option = "640x480-8@60";
-
-#ifdef CONFIG_MTRR
 static int mtrr = 1;
-#endif
 
 MODULE_AUTHOR("(c) 2006 Ondrej Zajicek <santiago@crfreenet.org>");
 MODULE_LICENSE("GPL");
@@ -112,11 +105,8 @@ module_param(mode_option, charp, 0644);
 MODULE_PARM_DESC(mode_option, "Default video mode ('640x480-8@60', etc)");
 module_param_named(mode, mode_option, charp, 0);
 MODULE_PARM_DESC(mode, "Default video mode e.g. '648x480-8@60' (deprecated)");
-
-#ifdef CONFIG_MTRR
 module_param(mtrr, int, 0444);
 MODULE_PARM_DESC(mtrr, "Enable write-combining with MTRR (1=enable, 0=disable, default=1)");
-#endif
 
 
 /* ------------------------------------------------------------------------- */
@@ -710,7 +700,7 @@ static int vt8623_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	info->fix.mmio_len = pci_resource_len(dev, 1);
 
 	/* Map physical IO memory address into kernel space */
-	info->screen_base = pci_iomap(dev, 0, 0);
+	info->screen_base = pci_iomap_wc(dev, 0, 0);
 	if (! info->screen_base) {
 		rc = -ENOMEM;
 		dev_err(info->device, "iomap for framebuffer failed\n");
@@ -781,12 +771,9 @@ static int vt8623_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
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
 
@@ -816,13 +803,7 @@ static void vt8623_pci_remove(struct pci_dev *dev)
 	if (info) {
 		struct vt8623fb_info *par = info->par;
 
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
 
-- 
2.3.2.209.gd67f9d5.dirty

