Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36361 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbbGIBys (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jul 2015 21:54:48 -0400
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
	Juergen Gross <jgross@suse.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Rob Clark <robdclark@gmail.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v9 4/8] drivers/video/fbdev/gxt4500: Use pci_ioremap_wc_bar() to map framebuffer
Date: Wed,  8 Jul 2015 18:54:15 -0700
Message-Id: <1436406859-1280-5-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1436406859-1280-1-git-send-email-mcgrof@do-not-panic.com>
References: <1436406859-1280-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

The driver doesn't use mtrr_add() or arch_phys_wc_add() but since we
know the framebuffer is isolated already on an ioremap() we can take
advantage of write combining for performance where possible.

In this case there are a few motivations for this:

a) Take advantage of PAT when available.

b) Help with the goal of eventually using _PAGE_CACHE_UC over
   _PAGE_CACHE_UC_MINUS on x86 on ioremap_nocache() (see commit
   de33c442e titled "x86 PAT: fix performance drop for glx,
   use UC minus for ioremap(), ioremap_nocache() and
   pci_mmap_page_range()").

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
Cc: Juergen Gross <jgross@suse.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: mst@redhat.com
Cc: Rob Clark <robdclark@gmail.com>
Cc: Suresh Siddha <sbsiddha@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: toshi.kani@hp.com
Link: http://lkml.kernel.org/r/1435195342-26879-5-git-send-email-mcgrof@do-not-panic.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/video/fbdev/gxt4500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/gxt4500.c b/drivers/video/fbdev/gxt4500.c
index 135d78a02588..f19133a80e8c 100644
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

