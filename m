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
	Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: [PATCH v5 2/3] video: fbdev: atyfb: replace MTRR UC hole with strong UC
Date: Wed, 24 Jun 2015 18:34:19 -0700
Message-Id: <1435196060-27350-3-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1435196060-27350-1-git-send-email-mcgrof@do-not-panic.com>
References: <1435196060-27350-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Replace a WC MTRR call followed by a UC MTRR "hole" call
with a single WC MTRR call and use strong UC to protect
the MMIO region and account for the device's architecture
and MTRR size requirements.

The atyfb driver relies on two overlapping MTRRs. It
does this to account for the fact that on some devices
it has the MMIO region bundled together with the framebuffer
on the same PCI BAR and the hardware requirement on
MTRRs on both base and size to be powers of two. In the
atyfb driver's case in the worst case the PCI BAR is
of 16 MiB while the MMIO region is on the last 4 KiB of
the same PCI BAR. If we use just one MTRR for WC we can
only end up with an 8 MiB or 16 MiB framebuffer. Using a
16 MiB WC framebuffer area is unacceptable since we need
the MMIO region to not be write-combined. An 8 MiB WC
framebuffer option does not let use quite a bit of framebuffer
space, it would reduce the resolution capability of the device
considerably. An alternative is to use many MTRRs but on
some systems that could mean not having not enough MTRRs
to cover the framebuffer. The current driver solution is
to issue a 16 MiB WC MTRR followed by a 4 KiB UC MTRR on
the last 4 KiB. Its worth mentioning and documenting that
the current ioremap*() strategy as well: the first ioremap()
is used only for the MMIO region, a second ioremap() call
is used for the framebuffer *and* the MMIO region, the MMIO
region then ends up mmap'd twice. Two ioremap() calls are
used since in some situations the framebuffer actually ends
up on a separate auxiliary PCI BAR, but this is not always
true, in the worst case the PCI BAR is shared for both
MMIO and the framebuffer. By allowing overlapping ioremap()
calls the driver enables two types of devices with one
simple ioremap() strategy.

For non PAT systems:

As per Intel SDM "11.5.2.1 Selecting Memory Types for Pentium
Pro and Pentium II Processors" [0] the effect of a WC MTRR for
a region with page attribute settings set to PCD=1, PWT=1
(Linux _PAGE_CACHE_MODE_UC) will render the effective memory
type to UC. A WC MTRR for a region with page attribute settings
set to PCD=1, PWT=0 (Linux _PAGE_CACHE_MODE_UC_MINUS) will render
the effective memory type to WC *but* yet this is considered
implementation defined -- that is, "system designers are
encouraged to avoid these implementation-defined combinations".
A WC MTRR for a region with page attribute settings set to
PCD=0, PWT=1 (Linux _PAGE_CACHE_MODE_WC) will render the
effective memory type to WC *but* this is also implementation
defined. Such is the case for non-PAT systems.

For PAT systems:

As per Intel SDM "11.5.2.2 Selecting Memory Types for Pentium
III and More Recent Processor Families" the ffect of a WC MTRR
for a region with a PAT entry value of UC will be UC. The effect
of a WC MTRR on a region with a PAT entry UC- will be WC. The
effect of a WC MTRR on a regoin with PAT entry WC is WC.

This can all be summarized in the following table:

----------------------------------------------------------------------
MTRR Non-PAT   PAT    Linux ioremap value        Effective memory type
----------------------------------------------------------------------
                                                  Non-PAT |  PAT
     PAT
     |PCD
     ||PWT
     |||
WC   000      WB      _PAGE_CACHE_MODE_WB            WC   |   WC
WC   001      WC      _PAGE_CACHE_MODE_WC            WC*  |   WC
WC   010      UC-     _PAGE_CACHE_MODE_UC_MINUS      WC*  |   UC
WC   011      UC      _PAGE_CACHE_MODE_UC            UC   |   UC
----------------------------------------------------------------------

 (*) denotes implementation defined

By default Linux today defaults both and ioremap_nocache()
to use _PAGE_CACHE_MODE_UC_MINUS. On x86 ioremap() aliases
ioremap_nocache(). The preferred value for Linux by may soon
change however, the goal is to use _PAGE_CACHE_MODE_UC by
default in the future.

We can use ioremap_uc() to set PCD=1, PWT=1 on non-PAT systems
and use a PAT value of UC for PAT systems. This will ensure the
same settings are in place regardless of what Linux decides to
use by default later and to not regress our MTRR strategy since
the effective memory type will differ depending on the value used.
Using a WC MTRR on such an area will be nullified. This technique
can be used to protect the MMIO region in this driver's case and
address the restrictions of the device's architecture as well as
restrictions set upon us by powers of 2 when using MTRRs.

This allows us to replace the two MTRR calls with a single
16 MiB WC MTRR and use page-attribute settings for non-PAT
and PAT entry values for PAT systems to ensure the
appropriate effective memory type won't have a write-combined
effect on the MMIO region on both non-PAT and PAT systems.
The framebuffer area will be sure to get the write-combined
effective memory type by white-listing it with ioremap_wc().

We ensure the desired effective memory types are set by:

0) Using one ioremap_uc() for the MMIO region alone.
   This will set the page attribute settings for the MMIO
   region to PCD=1, PWT=1 for non-PAT systems while using a
   strong UC value on PAT systems.

1) Fixing the framebuffer ioremap'd area to exclude the
   MMIO region and using ioremap_wc() instead to whitelist
   the area we want for write-combining.

On both cases an implementation defined (as per above table)
effective memory type of WC is used for the framebuffer for
non-PAT systems.

[0] https://www-ssl.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-manual-325462.pdf

Cc: Toshi Kani <toshi.kani@hp.com>
Cc: Suresh Siddha <sbsiddha@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
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
 drivers/video/fbdev/aty/atyfb.h      |  1 -
 drivers/video/fbdev/aty/atyfb_base.c | 36 ++++++++++++++----------------------
 2 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb.h b/drivers/video/fbdev/aty/atyfb.h
index 1f39a62..89ec439 100644
--- a/drivers/video/fbdev/aty/atyfb.h
+++ b/drivers/video/fbdev/aty/atyfb.h
@@ -184,7 +184,6 @@ struct atyfb_par {
 	spinlock_t int_lock;
 #ifdef CONFIG_MTRR
 	int mtrr_aper;
-	int mtrr_reg;
 #endif
 	u32 mem_cntl;
 	struct crtc saved_crtc;
diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 8025624..546f5af 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -2630,21 +2630,13 @@ static int aty_init(struct fb_info *info)
 
 #ifdef CONFIG_MTRR
 	par->mtrr_aper = -1;
-	par->mtrr_reg = -1;
 	if (!nomtrr) {
-		/* Cover the whole resource. */
+		/*
+		 * Only the ioremap_wc()'d area will get WC here
+		 * since ioremap_uc() was used on the entire PCI BAR.
+		 */
 		par->mtrr_aper = mtrr_add(par->res_start, par->res_size,
 					  MTRR_TYPE_WRCOMB, 1);
-		if (par->mtrr_aper >= 0 && !par->aux_start) {
-			/* Make a hole for mmio. */
-			par->mtrr_reg = mtrr_add(par->res_start + 0x800000 -
-						 GUI_RESERVE, GUI_RESERVE,
-						 MTRR_TYPE_UNCACHABLE, 1);
-			if (par->mtrr_reg < 0) {
-				mtrr_del(par->mtrr_aper, 0, 0);
-				par->mtrr_aper = -1;
-			}
-		}
 	}
 #endif
 
@@ -2776,10 +2768,6 @@ aty_init_exit:
 	par->pll_ops->set_pll(info, &par->saved_pll);
 
 #ifdef CONFIG_MTRR
-	if (par->mtrr_reg >= 0) {
-		mtrr_del(par->mtrr_reg, 0, 0);
-		par->mtrr_reg = -1;
-	}
 	if (par->mtrr_aper >= 0) {
 		mtrr_del(par->mtrr_aper, 0, 0);
 		par->mtrr_aper = -1;
@@ -3466,7 +3454,11 @@ static int atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info,
 	}
 
 	info->fix.mmio_start = raddr;
-	par->ati_regbase = ioremap(info->fix.mmio_start, 0x1000);
+	/*
+	 * By using strong UC we force the MTRR to never have an
+	 * effect on the MMIO region on both non-PAT and PAT systems.
+	 */
+	par->ati_regbase = ioremap_uc(info->fix.mmio_start, 0x1000);
 	if (par->ati_regbase == NULL)
 		return -ENOMEM;
 
@@ -3491,7 +3483,10 @@ static int atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info,
 	info->fix.smem_start = addr;
 	info->fix.smem_len = 0x800000;
 
-	info->screen_base = ioremap(info->fix.smem_start, info->fix.smem_len);
+	aty_fudge_framebuffer_len(info);
+
+	info->screen_base = ioremap_wc(info->fix.smem_start,
+				       info->fix.smem_len);
 	if (info->screen_base == NULL) {
 		ret = -ENOMEM;
 		goto atyfb_setup_generic_fail;
@@ -3563,6 +3558,7 @@ static int atyfb_pci_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 	}
 	par = info->par;
+	par->bus_type = PCI;
 	info->fix = atyfb_fix;
 	info->device = &pdev->dev;
 	par->pci_id = pdev->device;
@@ -3732,10 +3728,6 @@ static void atyfb_remove(struct fb_info *info)
 #endif
 
 #ifdef CONFIG_MTRR
-	if (par->mtrr_reg >= 0) {
-		mtrr_del(par->mtrr_reg, 0, 0);
-		par->mtrr_reg = -1;
-	}
 	if (par->mtrr_aper >= 0) {
 		mtrr_del(par->mtrr_aper, 0, 0);
 		par->mtrr_aper = -1;
-- 
2.3.2.209.gd67f9d5.dirty

