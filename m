Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35403 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbbGJB3Z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jul 2015 21:29:25 -0400
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: mingo@kernel.org
Cc: bp@suse.de, tomi.valkeinen@ti.com, airlied@redhat.com,
	arnd@arndb.de, dan.j.williams@intel.com, hch@lst.de,
	luto@amacapital.net, hpa@zytor.com, tglx@linutronix.de,
	geert@linux-m68k.org, ralf@linux-mips.org, hmh@hmh.eng.br,
	ross.zwisler@linux.intel.com, akpm@linux-foundation.org,
	jgross@suse.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
	tj@kernel.org, x86@kernel.org, mst@redhat.com, toshi.kani@hp.com,
	stefan.bader@canonical.com, syrjala@sci.fi,
	ville.syrjala@linux.intel.com, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Mathias Krause <minipli@googlemail.com>
Subject: [PATCH v6 1/4] drivers/video/fbdev/atyfb: Carve out framebuffer length fudging into a helper
Date: Thu,  9 Jul 2015 18:24:56 -0700
Message-Id: <1436491499-3289-2-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1436491499-3289-1-git-send-email-mcgrof@do-not-panic.com>
References: <1436491499-3289-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

The size of the framebuffer to be used needs to be fudged to account for
the different type of devices that are out there. This captures what is
required to do well, we'll reuse this later.

This has no functional changes.

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Mathias Krause <minipli@googlemail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Link: http://lkml.kernel.org/r/1435251019-32421-1-git-send-email-mcgrof@do-not-panic.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/video/fbdev/aty/atyfb_base.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 8789e487b96e..16936bb1f865 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -427,6 +427,20 @@ static struct {
 #endif /* CONFIG_FB_ATY_CT */
 };
 
+/*
+ * Last page of 8 MB (4 MB on ISA) aperture is MMIO,
+ * unless the auxiliary register aperture is used.
+ */
+static void aty_fudge_framebuffer_len(struct fb_info *info)
+{
+	struct atyfb_par *par = (struct atyfb_par *) info->par;
+
+	if (!par->aux_start &&
+	    (info->fix.smem_len == 0x800000 ||
+	     (par->bus_type == ISA && info->fix.smem_len == 0x400000)))
+		info->fix.smem_len -= GUI_RESERVE;
+}
+
 static int correct_chipset(struct atyfb_par *par)
 {
 	u8 rev;
@@ -2603,14 +2617,7 @@ static int aty_init(struct fb_info *info)
 	if (par->pll_ops->resume_pll)
 		par->pll_ops->resume_pll(info, &par->pll);
 
-	/*
-	 * Last page of 8 MB (4 MB on ISA) aperture is MMIO,
-	 * unless the auxiliary register aperture is used.
-	 */
-	if (!par->aux_start &&
-	    (info->fix.smem_len == 0x800000 ||
-	     (par->bus_type == ISA && info->fix.smem_len == 0x400000)))
-		info->fix.smem_len -= GUI_RESERVE;
+	aty_fudge_framebuffer_len(info);
 
 	/*
 	 * Disable register access through the linear aperture
-- 
2.3.2.209.gd67f9d5.dirty

