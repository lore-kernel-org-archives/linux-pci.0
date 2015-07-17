Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34079 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbbGQVcD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2015 17:32:03 -0400
Received: by oigd21 with SMTP id d21so36094289oig.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2015 14:32:03 -0700 (PDT)
Subject: [PATCH 2/8] PCI: Embed ATS info directly into struct pci_dev
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gregor Dick <gdick@solarflare.com>
Date: Fri, 17 Jul 2015 16:32:00 -0500
Message-ID: <20150717213200.18379.96435.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There are only 33 bits of information in the pci_ats struct, and we
previously allocated it dynamically and maintained a pointer to it from the
pci_dev struct.

Move the ATS fields into struct pci_dev so we don't need the pointer and we
don't have to allocate anything extra.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/ats.c       |   53 ++++++++++++++++-------------------------------
 include/linux/pci-ats.h |    9 +-------
 include/linux/pci.h     |    7 ++++--
 3 files changed, 23 insertions(+), 46 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 923759f..2f1fb9c 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -21,27 +21,15 @@ static void ats_alloc_one(struct pci_dev *dev)
 {
 	int pos;
 	u16 cap;
-	struct pci_ats *ats;
 
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS);
 	if (!pos)
 		return;
 
-	ats = kzalloc(sizeof(*ats), GFP_KERNEL);
-	if (!ats)
-		return;
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
@@ -49,11 +37,6 @@ void pci_ats_init(struct pci_dev *dev)
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
@@ -65,9 +48,9 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 {
 	u16 ctrl;
 
-	BUG_ON(dev->ats && dev->ats->is_enabled);
+	BUG_ON(dev->ats_cap && dev->ats_enabled);
 
-	if (!dev->ats)
+	if (!dev->ats_cap)
 		return -EINVAL;
 
 	if (ps < PCI_ATS_MIN_STU)
@@ -77,15 +60,15 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 	if (dev->is_virtfn) {
 		struct pci_dev *pdev = dev->physfn;
 
-		if (pdev->ats->stu != ps)
+		if (pdev->ats_stu != ps)
 			return -EINVAL;
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
@@ -98,13 +81,13 @@ void pci_disable_ats(struct pci_dev *dev)
 {
 	u16 ctrl;
 
-	BUG_ON(!dev->ats || !dev->ats->is_enabled);
+	BUG_ON(!dev->ats_cap || !dev->ats_enabled);
 
-	pci_read_config_word(dev, dev->ats->pos + PCI_ATS_CTRL, &ctrl);
+	pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, &ctrl);
 	ctrl &= ~PCI_ATS_CTRL_ENABLE;
-	pci_write_config_word(dev, dev->ats->pos + PCI_ATS_CTRL, ctrl);
+	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
 
-	dev->ats->is_enabled = 0;
+	dev->ats_enabled = 0;
 }
 EXPORT_SYMBOL_GPL(pci_disable_ats);
 
@@ -119,8 +102,8 @@ void pci_restore_ats_state(struct pci_dev *dev)
 
 	ctrl = PCI_ATS_CTRL_ENABLE;
 	if (!dev->is_virtfn)
-		ctrl |= PCI_ATS_CTRL_STU(dev->ats->stu - PCI_ATS_MIN_STU);
-	pci_write_config_word(dev, dev->ats->pos + PCI_ATS_CTRL, ctrl);
+		ctrl |= PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
+	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
 }
 EXPORT_SYMBOL_GPL(pci_restore_ats_state);
 
@@ -141,8 +124,8 @@ int pci_ats_queue_depth(struct pci_dev *dev)
 	if (dev->is_virtfn)
 		return 0;
 
-	if (dev->ats)
-		return dev->ats->qdep;
+	if (dev->ats_cap)
+		return dev->ats_qdep;
 
 	return -ENODEV;
 }
diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index d2e8170..5d81d47 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -4,13 +4,6 @@
 #include <linux/pci.h>
 
 /* Address Translation Service */
-struct pci_ats {
-	int pos;        /* capability position */
-	int stu;        /* Smallest Translation Unit */
-	int qdep;       /* Invalidate Queue Depth */
-	unsigned int is_enabled:1;      /* Enable bit is set */
-};
-
 #ifdef CONFIG_PCI_ATS
 
 int pci_enable_ats(struct pci_dev *dev, int ps);
@@ -25,7 +18,7 @@ int pci_ats_queue_depth(struct pci_dev *dev);
  */
 static inline int pci_ats_enabled(struct pci_dev *dev)
 {
-	return dev->ats && dev->ats->is_enabled;
+	return dev->ats_cap && dev->ats_enabled;
 }
 
 #else /* CONFIG_PCI_ATS */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5c277f1..ba4a23b 100644
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
@@ -375,7 +376,9 @@ struct pci_dev {
 		struct pci_sriov *sriov;	/* SR-IOV capability related */
 		struct pci_dev *physfn;	/* the PF this VF is associated with */
 	};
-	struct pci_ats	*ats;	/* Address Translation Service */
+	int		ats_cap;	/* ATS Capability offset */
+	int		ats_stu;	/* ATS Smallest Translation Unit */
+	int		ats_qdep;	/* ATS Invalidate Queue Depth */
 #endif
 	phys_addr_t rom; /* Physical address of ROM if it's not from the BAR */
 	size_t romlen; /* Length of ROM if it's not from the BAR */
@@ -1297,10 +1300,8 @@ void ht_destroy_irq(unsigned int irq);
 #ifdef CONFIG_PCI_ATS
 /* Address Translation Service */
 void pci_ats_init(struct pci_dev *dev);
-void pci_ats_free(struct pci_dev *dev);
 #else
 static inline void pci_ats_init(struct pci_dev *) { }
-static inline void pci_ats_free(struct pci_dev *) { }
 #endif
 
 void pci_cfg_access_lock(struct pci_dev *dev);

