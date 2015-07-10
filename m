Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34498 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbbGJBbh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jul 2015 21:31:37 -0400
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
	Andrzej Hajda <a.hajda@samsung.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Davidlohr Bueso <dbueso@suse.de>, Ingo Molnar <mingo@elte.hu>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mathias Krause <minipli@googlemail.com>,
	Mel Gorman <mgorman@suse.de>, Rob Clark <robdclark@gmail.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v6 2/4] drivers/video/fbdev/atyfb: Clarify ioremap() base and length used
Date: Thu,  9 Jul 2015 18:24:57 -0700
Message-Id: <1436491499-3289-3-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1436491499-3289-1-git-send-email-mcgrof@do-not-panic.com>
References: <1436491499-3289-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Adjust the ioremap() call for the framebuffer to use the same values we
later use for the framebuffer. This will make it easier to review the
next change.

The size of the framebuffer varies but since this is for PCI we *know*
this defaults to 0x800000. atyfb_setup_generic() is *only* used on PCI
probe.

No functional change.

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
Cc: airlied@redhat.com
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: benh@kernel.crashing.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: Mathias Krause <minipli@googlemail.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: mst@redhat.com
Cc: Rob Clark <robdclark@gmail.com>
Cc: Suresh Siddha <sbsiddha@gmail.com>
Cc: syrjala@sci.fi
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Toshi Kani <toshi.kani@hp.com>
Cc: Ville Syrjälä <syrjala@sci.fi>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/video/fbdev/aty/atyfb_base.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 16936bb1f865..513e58df9d3f 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -3489,7 +3489,21 @@ static int atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info,
 
 	/* Map in frame buffer */
 	info->fix.smem_start = addr;
-	info->screen_base = ioremap(addr, 0x800000);
+
+	/*
+	 * The framebuffer is not always 8 MiB that's just the size of the
+	 * PCI BAR. We temporarily abuse smem_len here to store the size
+	 * of the BAR. aty_init() will later correct it to match the actual
+	 * framebuffer size.
+	 *
+	 * On devices that don't have the auxiliary register aperture, the
+	 * registers are housed at the top end of the framebuffer PCI BAR.
+	 * aty_fudge_framebuffer_len() is used to reduce smem_len to not
+	 * overlap with the registers.
+	 */
+	info->fix.smem_len = 0x800000;
+
+	info->screen_base = ioremap(info->fix.smem_start, info->fix.smem_len);
 	if (info->screen_base == NULL) {
 		ret = -ENOMEM;
 		goto atyfb_setup_generic_fail;
-- 
2.3.2.209.gd67f9d5.dirty

