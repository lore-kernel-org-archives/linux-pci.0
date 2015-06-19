Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: arnd@arndb.de
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xensource.com, linux-fbdev@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	venkatesh.pallipadi@intel.com,
	Stefan Bader <stefan.bader@canonical.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
	konrad.wilk@oracle.com, ville.syrjala@linux.intel.com,
	david.vrabel@citrix.com, jbeulich@suse.com,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Subject: [PATCH v7 6/9] lib: devres: add pcim_iomap_wc() variants
Date: Fri, 19 Jun 2015 15:08:29 -0700
Message-Id: <1434751712-24333-7-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Now that we have pci_iomap_wc() add the respective devres helpers.

Cc: Toshi Kani <toshi.kani@hp.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Suresh Siddha <sbsiddha@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: venkatesh.pallipadi@intel.com
Cc: Stefan Bader <stefan.bader@canonical.com>
Cc: Ville Syrjälä <syrjala@sci.fi>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Borislav Petkov <bp@suse.de>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: konrad.wilk@oracle.com
Cc: ville.syrjala@linux.intel.com
Cc: david.vrabel@citrix.com
Cc: jbeulich@suse.com
Cc: Roger Pau Monné <roger.pau@citrix.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 include/linux/pci.h |  2 ++
 lib/devres.c        | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1193975..5ff15c1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1609,9 +1609,11 @@ static inline void pci_dev_specific_enable_acs(struct pci_dev *dev) { }
 #endif
 
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
+void __iomem *pcim_iomap_wc(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
+int pcim_iomap_wc_regions(struct pci_dev *pdev, int mask, const char *name);
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name);
 void pcim_iounmap_regions(struct pci_dev *pdev, int mask);
diff --git a/lib/devres.c b/lib/devres.c
index fbe2aac..d59a2b9 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -304,6 +304,30 @@ void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen)
 EXPORT_SYMBOL(pcim_iomap);
 
 /**
+ * pcim_iomap_wc - Managed pcim_iomap_wc()
+ * @pdev: PCI device to iomap for
+ * @bar: BAR to iomap
+ * @maxlen: Maximum length of iomap
+ *
+ * Managed pci_iomap_wc().  Map is automatically unmapped on driver
+ * detach.
+ */
+void __iomem *pcim_iomap_wc(struct pci_dev *pdev, int bar, unsigned long maxlen)
+{
+	void __iomem **tbl;
+
+	BUG_ON(bar >= PCIM_IOMAP_MAX);
+
+	tbl = (void __iomem **)pcim_iomap_table(pdev);
+	if (!tbl || tbl[bar])	/* duplicate mappings not allowed */
+		return NULL;
+
+	tbl[bar] = pci_iomap_wc(pdev, bar, maxlen);
+	return tbl[bar];
+}
+EXPORT_SYMBOL_GPL(pcim_iomap_wc);
+
+/**
  * pcim_iounmap - Managed pci_iounmap()
  * @pdev: PCI device to iounmap for
  * @addr: Address to unmap
@@ -383,6 +407,60 @@ int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name)
 EXPORT_SYMBOL(pcim_iomap_regions);
 
 /**
+ * pcim_iomap_wc_regions - Request and iomap PCI BARs with write-combining
+ * @pdev: PCI device to map IO resources for
+ * @mask: Mask of BARs to request and iomap
+ * @name: Name used when requesting regions
+ *
+ * Request and iomap regions specified by @mask with a preference for
+ * write-combining.
+ */
+int pcim_iomap_wc_regions(struct pci_dev *pdev, int mask, const char *name)
+{
+	void __iomem * const *iomap;
+	int i, rc;
+
+	iomap = pcim_iomap_table(pdev);
+	if (!iomap)
+		return -ENOMEM;
+
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+		unsigned long len;
+
+		if (!(mask & (1 << i)))
+			continue;
+
+		rc = -EINVAL;
+		len = pci_resource_len(pdev, i);
+		if (!len)
+			goto err_inval;
+
+		rc = pci_request_region(pdev, i, name);
+		if (rc)
+			goto err_inval;
+
+		rc = -ENOMEM;
+		if (!pcim_iomap_wc(pdev, i, 0))
+			goto err_region;
+	}
+
+	return 0;
+
+ err_region:
+	pci_release_region(pdev, i);
+ err_inval:
+	while (--i >= 0) {
+		if (!(mask & (1 << i)))
+			continue;
+		pcim_iounmap(pdev, iomap[i]);
+		pci_release_region(pdev, i);
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(pcim_iomap_wc_regions);
+
+/**
  * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
  * @pdev: PCI device to map IO resources for
  * @mask: Mask of BARs to iomap
-- 
2.3.2.209.gd67f9d5.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
Please read the FAQ at  http://www.tux.org/lkml/
