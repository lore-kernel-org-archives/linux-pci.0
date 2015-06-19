Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: arnd@arndb.de
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xensource.com, linux-fbdev@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Andy Lutomirski <luto@amacapital.net>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH v7 1/9] pci: add pci_ioremap_wc_bar()
Date: Fri, 19 Jun 2015 15:08:24 -0700
Message-Id: <1434751712-24333-2-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This lets drivers take advantage of PAT when available. This
should help with the transition of converting video drivers over
to ioremap_wc() to help with the goal of eventually using
_PAGE_CACHE_UC over _PAGE_CACHE_UC_MINUS on x86 on
ioremap_nocache() (de33c442e titled "x86 PAT: fix performance
drop for glx, use UC minus for ioremap(), ioremap_nocache() and
pci_mmap_page_range()")

Cc: Toshi Kani <toshi.kani@hp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
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
Cc: Mel Gorman <mgorman@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Borislav Petkov <bp@suse.de>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 drivers/pci/pci.c   | 14 ++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0008c95..fdae37b 100644
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
 
 #define PCI_FIND_CAP_TTL	48
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c0dd4ab..1193975 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1657,6 +1657,7 @@ static inline void pci_mmcfg_late_init(void) { }
 int pci_ext_cfg_avail(void);
 
 void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar);
+void __iomem *pci_ioremap_wc_bar(struct pci_dev *pdev, int bar);
 
 #ifdef CONFIG_PCI_IOV
 int pci_iov_virtfn_bus(struct pci_dev *dev, int id);
-- 
2.3.2.209.gd67f9d5.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
Please read the FAQ at  http://www.tux.org/lkml/
