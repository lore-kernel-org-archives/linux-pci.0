Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36372 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757247AbbGUAOR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jul 2015 20:14:17 -0400
Received: by iehx8 with SMTP id x8so49638981ieh.3
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2015 17:14:16 -0700 (PDT)
Subject: [PATCH v2 03/11] PCI: Embed ATS info directly into struct pci_dev
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: iommu@lists.linux-foundation.org,
	Gregor Dick <gdick@solarflare.com>
Date: Mon, 20 Jul 2015 19:14:13 -0500
Message-ID: <20150721001413.28145.38246.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pci_ats struct is small and will get smaller, so I don't think it's
worth allocating it separately from the pci_dev struct.

Embed the ATS fields directly into struct pci_dev.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/ats.c       |   61 ++++++++++++++++-------------------------------
 drivers/pci/remove.c    |    1 -
 include/linux/pci-ats.h |   10 +-------
 include/linux/pci.h     |    8 ++++--
 4 files changed, 27 insertions(+), 53 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 2026f53..690ae6e 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -21,29 +21,15 @@ static void ats_alloc_one(struct pci_dev *dev)
 {
 	int pos;
 	u16 cap;
-	struct pci_ats *ats;
 
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS);
 	if (!pos)
 		return;
 
-	ats = kzalloc(sizeof(*ats), GFP_KERNEL);
-	if (!ats) {
-		dev_warn(&dev->dev, "can't allocate space for ATS state\n");
-		return;
-	}
-
-	ats->pos = pos;
-	pci_read_config_word(dev, pos + PCI_ATS_CAP, &cap);
-	ats->qdep = PCI_ATS_CAP_QDEP(cap) ? PCI_ATS_CAP_QDEP(cap) :
+	dev->ats_cap = pos;
+	pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CAP, &cap);
+	dev->ats_qdep = PCI_ATS_CAP_QDEP(cap) ? PCI_ATS_CAP_QDEP(cap) :
 					    PCI_ATS_MAX_QDEP;
-	dev->ats = ats;
-}
-
-static void ats_free_one(struct pci_dev *dev)
-{
-	kfree(dev->ats);
-	dev->ats = NULL;
 }
 
 void pci_ats_init(struct pci_dev *dev)
@@ -51,11 +37,6 @@ void pci_ats_init(struct pci_dev *dev)
 	ats_alloc_one(dev);
 }
 
-void pci_ats_free(struct pci_dev *dev)
-{
-	ats_free_one(dev);
-}
-
 /**
  * pci_enable_ats - enable the ATS capability
  * @dev: the PCI device
@@ -67,9 +48,9 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 {
 	u16 ctrl;
 
-	BUG_ON(dev->ats && dev->ats->is_enabled);
+	BUG_ON(dev->ats_cap && dev->ats_enabled);
 
-	if (!dev->ats)
+	if (!dev->ats_cap)
 		return -EINVAL;
 
 	if (ps < PCI_ATS_MIN_STU)
@@ -83,17 +64,17 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 	if (dev->is_virtfn) {
 		struct pci_dev *pdev = dev->physfn;
 
-		if (pdev->ats->stu != ps)
+		if (pdev->ats_stu != ps)
 			return -EINVAL;
 
-		atomic_inc(&pdev->ats->ref_cnt);  /* count enabled VFs */
+		atomic_inc(&pdev->ats_ref_cnt);  /* count enabled VFs */
 	} else {
-		dev->ats->stu = ps;
-		ctrl |= PCI_ATS_CTRL_STU(dev->ats->stu - PCI_ATS_MIN_STU);
+		dev->ats_stu = ps;
+		ctrl |= PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
 	}
-	pci_write_config_word(dev, dev->ats->pos + PCI_ATS_CTRL, ctrl);
+	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
 
-	dev->ats->is_enabled = 1;
+	dev->ats_enabled = 1;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_enable_ats);
@@ -106,22 +87,22 @@ void pci_disable_ats(struct pci_dev *dev)
 {
 	u16 ctrl;
 
-	BUG_ON(!dev->ats || !dev->ats->is_enabled);
+	BUG_ON(!dev->ats_cap || !dev->ats_enabled);
 
-	if (atomic_read(&dev->ats->ref_cnt))
+	if (atomic_read(&dev->ats_ref_cnt))
 		return;		/* VFs still enabled */
 
 	if (dev->is_virtfn) {
 		struct pci_dev *pdev = dev->physfn;
 
-		atomic_dec(&pdev->ats->ref_cnt);
+		atomic_dec(&pdev->ats_ref_cnt);
 	}
 
-	pci_read_config_word(dev, dev->ats->pos + PCI_ATS_CTRL, &ctrl);
+	pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, &ctrl);
 	ctrl &= ~PCI_ATS_CTRL_ENABLE;
-	pci_write_config_word(dev, dev->ats->pos + PCI_ATS_CTRL, ctrl);
+	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
 
-	dev->ats->is_enabled = 0;
+	dev->ats_enabled = 0;
 }
 EXPORT_SYMBOL_GPL(pci_disable_ats);
 
@@ -136,8 +117,8 @@ void pci_restore_ats_state(struct pci_dev *dev)
 
 	ctrl = PCI_ATS_CTRL_ENABLE;
 	if (!dev->is_virtfn)
-		ctrl |= PCI_ATS_CTRL_STU(dev->ats->stu - PCI_ATS_MIN_STU);
-	pci_write_config_word(dev, dev->ats->pos + PCI_ATS_CTRL, ctrl);
+		ctrl |= PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
+	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
 }
 EXPORT_SYMBOL_GPL(pci_restore_ats_state);
 
@@ -158,8 +139,8 @@ int pci_ats_queue_depth(struct pci_dev *dev)
 	if (dev->is_virtfn)
 		return 0;
 
-	if (dev->ats)
-		return dev->ats->qdep;
+	if (dev->ats_cap)
+		return dev->ats_qdep;
 
 	return -ENODEV;
 }
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 27617b8..8a280e9 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -26,7 +26,6 @@ static void pci_stop_dev(struct pci_dev *dev)
 		dev->is_added = 0;
 	}
 
-	pci_ats_free(dev);
 	if (dev->bus->self)
 		pcie_aspm_exit_link_state(dev);
 }
diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index e2dcc2f..5d81d47 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -4,14 +4,6 @@
 #include <linux/pci.h>
 
 /* Address Translation Service */
-struct pci_ats {
-	int pos;        /* capability position */
-	int stu;        /* Smallest Translation Unit */
-	int qdep;       /* Invalidate Queue Depth */
-	atomic_t ref_cnt; /* number of VFs with ATS enabled */
-	unsigned int is_enabled:1;      /* Enable bit is set */
-};
-
 #ifdef CONFIG_PCI_ATS
 
 int pci_enable_ats(struct pci_dev *dev, int ps);
@@ -26,7 +18,7 @@ int pci_ats_queue_depth(struct pci_dev *dev);
  */
 static inline int pci_ats_enabled(struct pci_dev *dev)
 {
-	return dev->ats && dev->ats->is_enabled;
+	return dev->ats_cap && dev->ats_enabled;
 }
 
 #else /* CONFIG_PCI_ATS */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1817819..8bc16b5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -343,6 +343,7 @@ struct pci_dev {
 	unsigned int	msi_enabled:1;
 	unsigned int	msix_enabled:1;
 	unsigned int	ari_enabled:1;	/* ARI forwarding */
+	unsigned int	ats_enabled:1;	/* Address Translation Service */
 	unsigned int	is_managed:1;
 	unsigned int    needs_freset:1; /* Dev requires fundamental reset */
 	unsigned int	state_saved:1;
@@ -375,7 +376,10 @@ struct pci_dev {
 		struct pci_sriov *sriov;	/* SR-IOV capability related */
 		struct pci_dev *physfn;	/* the PF this VF is associated with */
 	};
-	struct pci_ats	*ats;	/* Address Translation Service */
+	int		ats_cap;	/* ATS Capability offset */
+	int		ats_stu;	/* ATS Smallest Translation Unit */
+	int		ats_qdep;	/* ATS Invalidate Queue Depth */
+	atomic_t	ats_ref_cnt;	/* number of VFs with ATS enabled */
 #endif
 	phys_addr_t rom; /* Physical address of ROM if it's not from the BAR */
 	size_t romlen; /* Length of ROM if it's not from the BAR */
@@ -1297,10 +1301,8 @@ void ht_destroy_irq(unsigned int irq);
 #ifdef CONFIG_PCI_ATS
 /* Address Translation Service */
 void pci_ats_init(struct pci_dev *dev);
-void pci_ats_free(struct pci_dev *dev);
 #else
 static inline void pci_ats_init(struct pci_dev *dev) { }
-static inline void pci_ats_free(struct pci_dev *dev) { }
 #endif
 
 void pci_cfg_access_lock(struct pci_dev *dev);

