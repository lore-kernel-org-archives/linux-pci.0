Return-Path: <linux-arch-owner@vger.kernel.org>
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
	Dave Hansen <dave.hansen@linux.intel.com>,
	Davidlohr Bueso <dbueso@suse.de>, david.vrabel@citrix.com,
	"H. Peter Anvin" <hpa@zytor.com>, jbeulich@suse.com,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Juergen Gross <jgross@suse.com>, konrad.wilk@oracle.com,
	linux-arch@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Stefan Bader <stefan.bader@canonical.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	venkatesh.pallipadi@intel.com,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <syrjala@sci.fi>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v9 5/8] PCI: Add pci_iomap_wc() variants
Date: Wed,  8 Jul 2015 18:54:16 -0700
Message-Id: <1436406859-1280-6-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1436406859-1280-1-git-send-email-mcgrof@do-not-panic.com>
References: <1436406859-1280-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

PCI BARs tell us whether prefetching is safe, but they don't say
anything about write combining (WC). WC changes ordering rules and
allows writes to be collapsed, so it's not safe in general to use it on
a prefetchable region.

Add pci_iomap_wc() and pci_iomap_wc_range() so drivers can take advantage
of write combining when they know it's safe.

On architectures that don't fully support WC, e.g., x86 without PAT,
drivers for legacy framebuffers may get some of the benefit by using
arch_phys_wc_add() in addition to pci_iomap_wc().  But arch_phys_wc_add()
is unreliable and should be avoided in general.  On x86, it uses MTRRs,
which are limited in number and size, so the results will vary based on
driver loading order.

The goals of adding pci_iomap_wc() are to:

- Give drivers an architecture-independent way to use WC so they can stop
  using interfaces like mtrr_add() (on x86, pci_iomap_wc() uses
  PAT when available).

- Move toward using _PAGE_CACHE_MODE_UC, not _PAGE_CACHE_MODE_UC_MINUS,
  on x86 on ioremap_nocache() (see de33c442ed2a ("x86 PAT: fix
  performance drop for glx, use UC minus for ioremap(), ioremap_nocache()
  and pci_mmap_page_range()").

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: benh@kernel.crashing.org
Cc: bhelgaas@google.com
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: david.vrabel@citrix.com
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: jbeulich@suse.com
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: konrad.wilk@oracle.com
Cc: linux-arch@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: Mel Gorman <mgorman@suse.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Roger Pau Monné <roger.pau@citrix.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Stefan Bader <stefan.bader@canonical.com>
Cc: Suresh Siddha <sbsiddha@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Toshi Kani <toshi.kani@hp.com>
Cc: venkatesh.pallipadi@intel.com
Cc: Ville Syrjälä <syrjala@sci.fi>
Cc: Vlastimil Babka <vbabka@suse.cz>
Link: http://lkml.kernel.org/r/1426893517-2511-6-git-send-email-mcgrof@do-not-panic.com
Link: http://lkml.kernel.org/r/1435195342-26879-6-git-send-email-mcgrof@do-not-panic.com
[ Move IORESOURCE_IO check up, space out statements for better readability. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 include/asm-generic/pci_iomap.h | 14 +++++++++
 lib/pci_iomap.c                 | 66 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
index 7389c87116a0..b1e17fcee2d0 100644
--- a/include/asm-generic/pci_iomap.h
+++ b/include/asm-generic/pci_iomap.h
@@ -15,9 +15,13 @@ struct pci_dev;
 #ifdef CONFIG_PCI
 /* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
 extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
+extern void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long max);
 extern void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
 				     unsigned long offset,
 				     unsigned long maxlen);
+extern void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
+					unsigned long offset,
+					unsigned long maxlen);
 /* Create a virtual mapping cookie for a port on a given PCI device.
  * Do not call this directly, it exists to make it easier for architectures
  * to override */
@@ -34,12 +38,22 @@ static inline void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned lon
 	return NULL;
 }
 
+static inline void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long max)
+{
+	return NULL;
+}
 static inline void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
 					    unsigned long offset,
 					    unsigned long maxlen)
 {
 	return NULL;
 }
+static inline void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
+					       unsigned long offset,
+					       unsigned long maxlen)
+{
+	return NULL;
+}
 #endif
 
 #endif /* __ASM_GENERIC_IO_H */
diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
index bcce5f149310..5f5d24d1d53f 100644
--- a/lib/pci_iomap.c
+++ b/lib/pci_iomap.c
@@ -52,6 +52,51 @@ void __iomem *pci_iomap_range(struct pci_dev *dev,
 EXPORT_SYMBOL(pci_iomap_range);
 
 /**
+ * pci_iomap_wc_range - create a virtual WC mapping cookie for a PCI BAR
+ * @dev: PCI device that owns the BAR
+ * @bar: BAR number
+ * @offset: map memory at the given offset in BAR
+ * @maxlen: max length of the memory to map
+ *
+ * Using this function you will get a __iomem address to your device BAR.
+ * You can access it using ioread*() and iowrite*(). These functions hide
+ * the details if this is a MMIO or PIO address space and will just do what
+ * you expect from them in the correct way. When possible write combining
+ * is used.
+ *
+ * @maxlen specifies the maximum length to map. If you want to get access to
+ * the complete BAR from offset to the end, pass %0 here.
+ * */
+void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
+				 int bar,
+				 unsigned long offset,
+				 unsigned long maxlen)
+{
+	resource_size_t start = pci_resource_start(dev, bar);
+	resource_size_t len = pci_resource_len(dev, bar);
+	unsigned long flags = pci_resource_flags(dev, bar);
+
+
+	if (flags & IORESOURCE_IO)
+		return NULL;
+
+	if (len <= offset || !start)
+		return NULL;
+
+	len -= offset;
+	start += offset;
+	if (maxlen && len > maxlen)
+		len = maxlen;
+
+	if (flags & IORESOURCE_MEM)
+		return ioremap_wc(start, len);
+
+	/* What? */
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(pci_iomap_wc_range);
+
+/**
  * pci_iomap - create a virtual mapping cookie for a PCI BAR
  * @dev: PCI device that owns the BAR
  * @bar: BAR number
@@ -70,4 +115,25 @@ void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
 	return pci_iomap_range(dev, bar, 0, maxlen);
 }
 EXPORT_SYMBOL(pci_iomap);
+
+/**
+ * pci_iomap_wc - create a virtual WC mapping cookie for a PCI BAR
+ * @dev: PCI device that owns the BAR
+ * @bar: BAR number
+ * @maxlen: length of the memory to map
+ *
+ * Using this function you will get a __iomem address to your device BAR.
+ * You can access it using ioread*() and iowrite*(). These functions hide
+ * the details if this is a MMIO or PIO address space and will just do what
+ * you expect from them in the correct way. When possible write combining
+ * is used.
+ *
+ * @maxlen specifies the maximum length to map. If you want to get access to
+ * the complete BAR without checking for its length first, pass %0 here.
+ * */
+void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long maxlen)
+{
+	return pci_iomap_wc_range(dev, bar, 0, maxlen);
+}
+EXPORT_SYMBOL_GPL(pci_iomap_wc);
 #endif /* CONFIG_PCI */
-- 
2.3.2.209.gd67f9d5.dirty

