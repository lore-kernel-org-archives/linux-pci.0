Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36585 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbbFSWTa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2015 18:19:30 -0400
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: arnd@arndb.de
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xensource.com, linux-fbdev@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Rob Clark <robdclark@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
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
Subject: [PATCH v7 4/9] video: fbdev: gxt4500: use pci_ioremap_wc_bar() for framebuffer
Date: Fri, 19 Jun 2015 15:08:27 -0700
Message-Id: <1434751712-24333-5-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

The driver doesn't use mtrr_add() or arch_phys_wc_add() but
since we know the framebuffer is isolated already on an
ioremap() we can take advantage of write combining for
performance where possible.

In this case there are a few motivations for this:

a) Take advantage of PAT when available

b) Help with the goal of eventually using _PAGE_CACHE_UC over
   _PAGE_CACHE_UC_MINUS on x86 on ioremap_nocache() (see commit
   de33c442e titled "x86 PAT: fix performance drop for glx,
   use UC minus for ioremap(), ioremap_nocache() and
   pci_mmap_page_range()")

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
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
 drivers/video/fbdev/gxt4500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/gxt4500.c b/drivers/video/fbdev/gxt4500.c
index 135d78a..f19133a 100644
--- a/drivers/video/fbdev/gxt4500.c
+++ b/drivers/video/fbdev/gxt4500.c
@@ -662,7 +662,7 @@ static int gxt4500_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	info->fix.smem_start = fb_phys;
 	info->fix.smem_len = pci_resource_len(pdev, 1);
-	info->screen_base = pci_ioremap_bar(pdev, 1);
+	info->screen_base = pci_ioremap_wc_bar(pdev, 1);
 	if (!info->screen_base) {
 		dev_err(&pdev->dev, "gxt4500: cannot map framebuffer\n");
 		goto err_unmap_regs;
-- 
2.3.2.209.gd67f9d5.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
