Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: akpm@linux-foundation.org
Cc: bp@suse.de, mingo@elte.hu, syrjala@sci.fi,
	ville.syrjala@linux.intel.com, luto@amacapital.net,
	tomi.valkeinen@ti.com, mst@redhat.com, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-pci@vger.kernel.org, airlied@redhat.com,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Rob Clark <robdclark@gmail.com>,
	Mathias Krause <minipli@googlemail.com>,
	Andrzej Hajda <a.hajda@samsung.com>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH v5 3/3] video: fbdev: atyfb: use arch_phys_wc_add() and ioremap_wc()
Date: Wed, 24 Jun 2015 18:34:20 -0700
Message-Id: <1435196060-27350-4-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1435196060-27350-1-git-send-email-mcgrof@do-not-panic.com>
References: <1435196060-27350-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This driver uses strong UC for the MMIO region, and ioremap_wc()
for the framebuffer to whitelist for the WC MTRR what can be changed
to WC. On PAT systems we don't need the MTRR call so just use
arch_phys_wc_add() there, this lets us remove all those ifdefs.
Lets also be consistent and use ioremap_wc() for ATARI as well.

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
Cc: Toshi Kani <toshi.kani@hp.com>
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
Cc: Ville Syrjälä <syrjala@sci.fi>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Mathias Krause <minipli@googlemail.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Borislav Petkov <bp@suse.de>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 drivers/video/fbdev/aty/atyfb.h      |  4 +---
 drivers/video/fbdev/aty/atyfb_base.c | 36 +++++++-----------------------------
 2 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb.h b/drivers/video/fbdev/aty/atyfb.h
index 89ec439..63c4842 100644
--- a/drivers/video/fbdev/aty/atyfb.h
+++ b/drivers/video/fbdev/aty/atyfb.h
@@ -182,9 +182,7 @@ struct atyfb_par {
 	unsigned long irq_flags;
 	unsigned int irq;
 	spinlock_t int_lock;
-#ifdef CONFIG_MTRR
-	int mtrr_aper;
-#endif
+	int wc_cookie;
 	u32 mem_cntl;
 	struct crtc saved_crtc;
 	union aty_pll saved_pll;
diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 546f5af..96c605c 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -98,9 +98,6 @@
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/backlight.h>
 #endif
-#ifdef CONFIG_MTRR
-#include <asm/mtrr.h>
-#endif
 
 /*
  * Debug flags.
@@ -303,9 +300,7 @@ static struct fb_ops atyfb_ops = {
 };
 
 static bool noaccel;
-#ifdef CONFIG_MTRR
 static bool nomtrr;
-#endif
 static int vram;
 static int pll;
 static int mclk;
@@ -2628,17 +2623,13 @@ static int aty_init(struct fb_info *info)
 		aty_st_le32(BUS_CNTL, aty_ld_le32(BUS_CNTL, par) |
 			    BUS_APER_REG_DIS, par);
 
-#ifdef CONFIG_MTRR
-	par->mtrr_aper = -1;
-	if (!nomtrr) {
+	if (!nomtrr)
 		/*
 		 * Only the ioremap_wc()'d area will get WC here
 		 * since ioremap_uc() was used on the entire PCI BAR.
 		 */
-		par->mtrr_aper = mtrr_add(par->res_start, par->res_size,
-					  MTRR_TYPE_WRCOMB, 1);
-	}
-#endif
+		par->wc_cookie = arch_phys_wc_add(par->res_start,
+						  par->res_size);
 
 	info->fbops = &atyfb_ops;
 	info->pseudo_palette = par->pseudo_palette;
@@ -2766,13 +2757,8 @@ aty_init_exit:
 	/* restore video mode */
 	aty_set_crtc(par, &par->saved_crtc);
 	par->pll_ops->set_pll(info, &par->saved_pll);
+	arch_phys_wc_del(par->wc_cookie);
 
-#ifdef CONFIG_MTRR
-	if (par->mtrr_aper >= 0) {
-		mtrr_del(par->mtrr_aper, 0, 0);
-		par->mtrr_aper = -1;
-	}
-#endif
 	return ret;
 }
 
@@ -3660,7 +3646,8 @@ static int __init atyfb_atari_probe(void)
 		 * Map the video memory (physical address given)
 		 * to somewhere in the kernel address space.
 		 */
-		info->screen_base = ioremap(phys_vmembase[m64_num], phys_size[m64_num]);
+		info->screen_base = ioremap_wc(phys_vmembase[m64_num],
+					       phys_size[m64_num]);
 		info->fix.smem_start = (unsigned long)info->screen_base; /* Fake! */
 		par->ati_regbase = ioremap(phys_guiregbase[m64_num], 0x10000) +
 						0xFC00ul;
@@ -3726,13 +3713,8 @@ static void atyfb_remove(struct fb_info *info)
 	if (M64_HAS(MOBIL_BUS))
 		aty_bl_exit(info->bl_dev);
 #endif
+	arch_phys_wc_del(par->wc_cookie);
 
-#ifdef CONFIG_MTRR
-	if (par->mtrr_aper >= 0) {
-		mtrr_del(par->mtrr_aper, 0, 0);
-		par->mtrr_aper = -1;
-	}
-#endif
 #ifndef __sparc__
 	if (par->ati_regbase)
 		iounmap(par->ati_regbase);
@@ -3848,10 +3830,8 @@ static int __init atyfb_setup(char *options)
 	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!strncmp(this_opt, "noaccel", 7)) {
 			noaccel = 1;
-#ifdef CONFIG_MTRR
 		} else if (!strncmp(this_opt, "nomtrr", 6)) {
 			nomtrr = 1;
-#endif
 		} else if (!strncmp(this_opt, "vram:", 5))
 			vram = simple_strtoul(this_opt + 5, NULL, 0);
 		else if (!strncmp(this_opt, "pll:", 4))
@@ -4021,7 +4001,5 @@ module_param(comp_sync, int, 0);
 MODULE_PARM_DESC(comp_sync, "Set composite sync signal to low (0) or high (1)");
 module_param(mode, charp, 0);
 MODULE_PARM_DESC(mode, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
-#ifdef CONFIG_MTRR
 module_param(nomtrr, bool, 0);
 MODULE_PARM_DESC(nomtrr, "bool: disable use of MTRR registers");
-#endif
-- 
2.3.2.209.gd67f9d5.dirty

