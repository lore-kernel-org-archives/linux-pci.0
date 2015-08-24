Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36676 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbbHXTNq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Aug 2015 15:13:46 -0400
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
	Dave Airlie <airlied@redhat.com>,
	Davidlohr Bueso <dbueso@suse.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Juergen Gross <jgross@suse.com>, Mel Gorman <mgorman@suse.de>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <syrjala@sci.fi>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v4 01/11] PCI: Add pci_ioremap_wc_bar()
Date: Mon, 24 Aug 2015 12:13:23 -0700
Message-Id: <1440443613-13696-2-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1440443613-13696-1-git-send-email-mcgrof@do-not-panic.com>
References: <1440443613-13696-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This lets drivers take advantage of PAT when available. It should help
with the transition of converting video drivers over to ioremap_wc()
to help with the goal of eventually using _PAGE_CACHE_UC over
_PAGE_CACHE_UC_MINUS on x86 on ioremap_nocache(), see:

  de33c442ed2a ("x86 PAT: fix performance drop for glx, use UC minus for ioremap(),
		ioremap_nocache() and pci_mmap_page_range()")

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: benh@kernel.crashing.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: Mel Gorman <mgorman@suse.de>
Cc: mst@redhat.com
Cc: Suresh Siddha <sbsiddha@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Toshi Kani <toshi.kani@hp.com>
Cc: Ville Syrjälä <syrjala@sci.fi>
Cc: Vlastimil Babka <vbabka@suse.cz>
Link: http://lkml.kernel.org/r/1435195342-26879-2-git-send-email-mcgrof@do-not-panic.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/pci/pci.c   | 14 ++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8037c27beb05..33867b8a4bc9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -138,6 +138,20 @@ void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
 	return ioremap_nocache(res->start, resource_size(res));
 }
 EXPORT_SYMBOL_GPL(pci_ioremap_bar);
+
+void __iomem *pci_ioremap_wc_bar(struct pci_dev *pdev, int bar)
+{
+	/*
+	 * Make sure the BAR is actually a memory resource, not an IO resource
+	 */
+	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM)) {
+		WARN_ON(1);
+		return NULL;
+	}
+	return ioremap_wc(pci_resource_start(pdev, bar),
+			  pci_resource_len(pdev, bar));
+}
+EXPORT_SYMBOL_GPL(pci_ioremap_wc_bar);
 #endif
 
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 88bee285b93d..2b2d7d44c21a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1701,6 +1701,7 @@ static inline void pci_mmcfg_late_init(void) { }
 int pci_ext_cfg_avail(void);
 
 void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar);
+void __iomem *pci_ioremap_wc_bar(struct pci_dev *pdev, int bar);
 
 #ifdef CONFIG_PCI_IOV
 int pci_iov_virtfn_bus(struct pci_dev *dev, int id);
-- 
2.4.3

