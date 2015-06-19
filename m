Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: arnd@arndb.de
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xensource.com, linux-fbdev@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Andy Lutomirski <luto@amacapital.net>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH v7 3/9] video: fbdev: kyrofb: use arch_phys_wc_add() and pci_ioremap_wc_bar()
Date: Fri, 19 Jun 2015 15:08:26 -0700
Message-Id: <1434751712-24333-4-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

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
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
 drivers/video/fbdev/kyro/fbdev.c | 33 +++++++++++----------------------
 include/video/kyro.h             |  4 +---
 2 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
index 65041e1..5bb0153 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -22,9 +22,6 @@
 #include <linux/pci.h>
 #include <asm/io.h>
 #include <linux/uaccess.h>
-#ifdef CONFIG_MTRR
-#include <asm/mtrr.h>
-#endif
 
 #include <video/kyro.h>
 
@@ -84,9 +81,7 @@ static device_info_t deviceInfo;
 static char *mode_option = NULL;
 static int nopan = 0;
 static int nowrap = 1;
-#ifdef CONFIG_MTRR
 static int nomtrr = 0;
-#endif
 
 /* PCI driver prototypes */
 static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
@@ -570,10 +565,8 @@ static int __init kyrofb_setup(char *options)
 			nopan = 1;
 		} else if (strcmp(this_opt, "nowrap") == 0) {
 			nowrap = 1;
-#ifdef CONFIG_MTRR
 		} else if (strcmp(this_opt, "nomtrr") == 0) {
 			nomtrr = 1;
-#endif
 		} else {
 			mode_option = this_opt;
 		}
@@ -691,17 +684,16 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	currentpar->regbase = deviceInfo.pSTGReg =
 		ioremap_nocache(kyro_fix.mmio_start, kyro_fix.mmio_len);
+	if (!currentpar->regbase)
+		goto out_free_fb;
 
-	info->screen_base = ioremap_nocache(kyro_fix.smem_start,
-					    kyro_fix.smem_len);
+	info->screen_base = pci_ioremap_wc_bar(pdev, 0);
+	if (!info->screen_base)
+		goto out_unmap_regs;
 
-#ifdef CONFIG_MTRR
 	if (!nomtrr)
-		currentpar->mtrr_handle =
-			mtrr_add(kyro_fix.smem_start,
-				 kyro_fix.smem_len,
-				 MTRR_TYPE_WRCOMB, 1);
-#endif
+		currentpar->wc_cookie = arch_phys_wc_add(kyro_fix.smem_start,
+							 kyro_fix.smem_len);
 
 	kyro_fix.ypanstep	= nopan ? 0 : 1;
 	kyro_fix.ywrapstep	= nowrap ? 0 : 1;
@@ -745,8 +737,10 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 
 out_unmap:
-	iounmap(currentpar->regbase);
 	iounmap(info->screen_base);
+out_unmap_regs:
+	iounmap(currentpar->regbase);
+out_free_fb:
 	framebuffer_release(info);
 
 	return -EINVAL;
@@ -770,12 +764,7 @@ static void kyrofb_remove(struct pci_dev *pdev)
 	iounmap(info->screen_base);
 	iounmap(par->regbase);
 
-#ifdef CONFIG_MTRR
-	if (par->mtrr_handle)
-		mtrr_del(par->mtrr_handle,
-			 info->fix.smem_start,
-			 info->fix.smem_len);
-#endif
+	arch_phys_wc_del(par->wc_cookie);
 
 	unregister_framebuffer(info);
 	framebuffer_release(info);
diff --git a/include/video/kyro.h b/include/video/kyro.h
index c563968..b958c2e 100644
--- a/include/video/kyro.h
+++ b/include/video/kyro.h
@@ -35,9 +35,7 @@ struct kyrofb_info {
 	/* Useful to hold depth here for Linux */
 	u8 PIXDEPTH;
 
-#ifdef CONFIG_MTRR
-	int mtrr_handle;
-#endif
+	int wc_cookie;
 };
 
 extern int kyro_dev_init(void);
-- 
2.3.2.209.gd67f9d5.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
Please read the FAQ at  http://www.tux.org/lkml/
