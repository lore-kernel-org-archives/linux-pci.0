Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36172 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757286AbbGUAPP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jul 2015 20:15:15 -0400
Received: by igbij6 with SMTP id ij6so95449502igb.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2015 17:15:14 -0700 (PDT)
Subject: [PATCH v2 10/11] PCI: Stop caching ATS Invalidate Queue Depth
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: iommu@lists.linux-foundation.org,
	Gregor Dick <gdick@solarflare.com>
Date: Mon, 20 Jul 2015 19:15:11 -0500
Message-ID: <20150721001511.28145.29144.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Stop caching the Invalidate Queue Depth in struct pci_dev.
pci_ats_queue_depth() is typically called only once per device, and it
returns a fixed value per-device, so callers who need the value frequently
can cache it themselves.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/ats.c   |    9 ++++-----
 include/linux/pci.h |    1 -
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 67524a7..bdb1383 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -20,16 +20,12 @@
 void pci_ats_init(struct pci_dev *dev)
 {
 	int pos;
-	u16 cap;
 
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS);
 	if (!pos)
 		return;
 
 	dev->ats_cap = pos;
-	pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CAP, &cap);
-	dev->ats_qdep = PCI_ATS_CAP_QDEP(cap) ? PCI_ATS_CAP_QDEP(cap) :
-					    PCI_ATS_MAX_QDEP;
 }
 
 /**
@@ -131,13 +127,16 @@ EXPORT_SYMBOL_GPL(pci_restore_ats_state);
  */
 int pci_ats_queue_depth(struct pci_dev *dev)
 {
+	u16 cap;
+
 	if (!dev->ats_cap)
 		return -EINVAL;
 
 	if (dev->is_virtfn)
 		return 0;
 
-	return dev->ats_qdep;
+	pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CAP, &cap);
+	return PCI_ATS_CAP_QDEP(cap) ? PCI_ATS_CAP_QDEP(cap) : PCI_ATS_MAX_QDEP;
 }
 EXPORT_SYMBOL_GPL(pci_ats_queue_depth);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 307f96a..4b484fd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -378,7 +378,6 @@ struct pci_dev {
 	};
 	u16		ats_cap;	/* ATS Capability offset */
 	u8		ats_stu;	/* ATS Smallest Translation Unit */
-	u8		ats_qdep;	/* ATS Invalidate Queue Depth */
 	atomic_t	ats_ref_cnt;	/* number of VFs with ATS enabled */
 #endif
 	phys_addr_t rom; /* Physical address of ROM if it's not from the BAR */

