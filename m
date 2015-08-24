Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: mingo@kernel.org
Cc: bp@suse.de, bhelgaas@google.com, tomi.valkeinen@ti.com,
	airlied@linux.ie, linux-fbdev@vger.kernel.org, luto@amacapital.net,
	vinod.koul@intel.com, dan.j.williams@intel.com, toshi.kani@hp.com,
	benh@kernel.crashing.org, mst@redhat.com,
	akpm@linux-foundation.org, daniel.vetter@ffwll.ch,
	konrad.wilk@oracle.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	xen-devel@lists.xensource.com,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Benoit Taine <benoit.taine@lip6.fr>,
	Dave Airlie <airlied@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Juergen Gross <jgross@suse.com>,
	Rob Clark <robdclark@gmail.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 02/11] drivers/video/fbdev/i740fb: Use arch_phys_wc_add() and pci_ioremap_wc_bar()
Date: Mon, 24 Aug 2015 12:13:24 -0700
Message-Id: <1440443613-13696-3-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1440443613-13696-1-git-send-email-mcgrof@do-not-panic.com>
References: <1440443613-13696-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Convert the driver from using the x86-specific MTRR code to the
architecture-agnostic arch_phys_wc_add(). It will avoid MTRR if
write-combining is available, in order to take advantage of that also
ensure the ioremapped area is requested as write-combining.

There are a few motivations for this:

a) Take advantage of PAT when available

b) Help bury MTRR code away, MTRR is architecture-specific and on
   x86 it is being replaced by PAT.

c) Help with the goal of eventually using _PAGE_CACHE_UC over
   _PAGE_CACHE_UC_MINUS on x86 on ioremap_nocache() (see commit
   de33c442e titled "x86 PAT: fix performance drop for glx,
   use UC minus for ioremap(), ioremap_nocache() and
   pci_mmap_page_range()")

The conversion done is expressed by the following Coccinelle SmPL
patch, it additionally required manual intervention to address all the
ifdeffery and removal of redundant things which arch_phys_wc_add()
already addresses such as verbose message about when MTRR fails and
doing nothing when we didn't get an MTRR.

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
Cc: Benoit Taine <benoit.taine@lip6.fr>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: mst@redhat.com
Cc: Rob Clark <robdclark@gmail.com>
Cc: Suresh Siddha <sbsiddha@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: toshi.kani@hp.com
Link: http://lkml.kernel.org/r/1435195342-26879-3-git-send-email-mcgrof@do-not-panic.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/video/fbdev/i740fb.c | 35 ++++++-----------------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/video/fbdev/i740fb.c b/drivers/video/fbdev/i740fb.c
index a2b4204b42bb..452e1163ad02 100644
--- a/drivers/video/fbdev/i740fb.c
+++ b/drivers/video/fbdev/i740fb.c
@@ -27,24 +27,15 @@
 #include <linux/console.h>
 #include <video/vga.h>
 
-#ifdef CONFIG_MTRR
-#include <asm/mtrr.h>
-#endif
-
 #include "i740_reg.h"
 
 static char *mode_option;
-
-#ifdef CONFIG_MTRR
 static int mtrr = 1;
-#endif
 
 struct i740fb_par {
 	unsigned char __iomem *regs;
 	bool has_sgram;
-#ifdef CONFIG_MTRR
-	int mtrr_reg;
-#endif
+	int wc_cookie;
 	bool ddc_registered;
 	struct i2c_adapter ddc_adapter;
 	struct i2c_algo_bit_data ddc_algo;
@@ -1040,7 +1031,7 @@ static int i740fb_probe(struct pci_dev *dev, const struct pci_device_id *ent)
 		goto err_request_regions;
 	}
 
-	info->screen_base = pci_ioremap_bar(dev, 0);
+	info->screen_base = pci_ioremap_wc_bar(dev, 0);
 	if (!info->screen_base) {
 		dev_err(info->device, "error remapping base\n");
 		ret = -ENOMEM;
@@ -1144,13 +1135,9 @@ static int i740fb_probe(struct pci_dev *dev, const struct pci_device_id *ent)
 
 	fb_info(info, "%s frame buffer device\n", info->fix.id);
 	pci_set_drvdata(dev, info);
-#ifdef CONFIG_MTRR
-	if (mtrr) {
-		par->mtrr_reg = -1;
-		par->mtrr_reg = mtrr_add(info->fix.smem_start,
-				info->fix.smem_len, MTRR_TYPE_WRCOMB, 1);
-	}
-#endif
+	if (mtrr)
+		par->wc_cookie = arch_phys_wc_add(info->fix.smem_start,
+						  info->fix.smem_len);
 	return 0;
 
 err_reg_framebuffer:
@@ -1177,13 +1164,7 @@ static void i740fb_remove(struct pci_dev *dev)
 
 	if (info) {
 		struct i740fb_par *par = info->par;
-
-#ifdef CONFIG_MTRR
-		if (par->mtrr_reg >= 0) {
-			mtrr_del(par->mtrr_reg, 0, 0);
-			par->mtrr_reg = -1;
-		}
-#endif
+		arch_phys_wc_del(par->wc_cookie);
 		unregister_framebuffer(info);
 		fb_dealloc_cmap(&info->cmap);
 		if (par->ddc_registered)
@@ -1287,10 +1268,8 @@ static int  __init i740fb_setup(char *options)
 	while ((opt = strsep(&options, ",")) != NULL) {
 		if (!*opt)
 			continue;
-#ifdef CONFIG_MTRR
 		else if (!strncmp(opt, "mtrr:", 5))
 			mtrr = simple_strtoul(opt + 5, NULL, 0);
-#endif
 		else
 			mode_option = opt;
 	}
@@ -1327,7 +1306,5 @@ MODULE_DESCRIPTION("fbdev driver for Intel740");
 module_param(mode_option, charp, 0444);
 MODULE_PARM_DESC(mode_option, "Default video mode ('640x480-8@60', etc)");
 
-#ifdef CONFIG_MTRR
 module_param(mtrr, int, 0444);
 MODULE_PARM_DESC(mtrr, "Enable write-combining with MTRR (1=enable, 0=disable, default=1)");
-#endif
-- 
2.4.3

