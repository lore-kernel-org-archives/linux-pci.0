Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:37910 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757286AbbGUAPH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jul 2015 20:15:07 -0400
Received: by iggf3 with SMTP id f3so94280548igg.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2015 17:15:06 -0700 (PDT)
Subject: [PATCH v2 09/11] PCI: Move ATS declarations to linux/pci.h so
 they're all together
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: iommu@lists.linux-foundation.org,
	Gregor Dick <gdick@solarflare.com>
Date: Mon, 20 Jul 2015 19:15:03 -0500
Message-ID: <20150721001503.28145.54521.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Move ATS declarations to linux/pci.h so they're all in one place.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/pci-ats.h |   41 -----------------------------------------
 include/linux/pci.h     |   10 +++++++++-
 2 files changed, 9 insertions(+), 42 deletions(-)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 5d81d47..57e0b82 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -3,47 +3,6 @@
 
 #include <linux/pci.h>
 
-/* Address Translation Service */
-#ifdef CONFIG_PCI_ATS
-
-int pci_enable_ats(struct pci_dev *dev, int ps);
-void pci_disable_ats(struct pci_dev *dev);
-int pci_ats_queue_depth(struct pci_dev *dev);
-
-/**
- * pci_ats_enabled - query the ATS status
- * @dev: the PCI device
- *
- * Returns 1 if ATS capability is enabled, or 0 if not.
- */
-static inline int pci_ats_enabled(struct pci_dev *dev)
-{
-	return dev->ats_cap && dev->ats_enabled;
-}
-
-#else /* CONFIG_PCI_ATS */
-
-static inline int pci_enable_ats(struct pci_dev *dev, int ps)
-{
-	return -ENODEV;
-}
-
-static inline void pci_disable_ats(struct pci_dev *dev)
-{
-}
-
-static inline int pci_ats_queue_depth(struct pci_dev *dev)
-{
-	return -ENODEV;
-}
-
-static inline int pci_ats_enabled(struct pci_dev *dev)
-{
-	return 0;
-}
-
-#endif /* CONFIG_PCI_ATS */
-
 #ifdef CONFIG_PCI_PRI
 
 int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 238b77e..307f96a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1301,8 +1301,16 @@ void ht_destroy_irq(unsigned int irq);
 #ifdef CONFIG_PCI_ATS
 /* Address Translation Service */
 void pci_ats_init(struct pci_dev *dev);
+int pci_enable_ats(struct pci_dev *dev, int ps);
+void pci_disable_ats(struct pci_dev *dev);
+int pci_ats_queue_depth(struct pci_dev *dev);
+static inline int pci_ats_enabled(struct pci_dev *dev) { return dev->ats_cap && dev->ats_enabled; }
 #else
-static inline void pci_ats_init(struct pci_dev *dev) { }
+static inline void pci_ats_init(struct pci_dev *d) { }
+static inline int pci_enable_ats(struct pci_dev *d, int ps) { return -ENODEV; }
+static inline void pci_disable_ats(struct pci_dev *d) { }
+static inline int pci_ats_queue_depth(struct pci_dev *d) { return -ENODEV; }
+static inline int pci_ats_enabled(struct pci_dev *d) { return 0; }
 #endif
 
 void pci_cfg_access_lock(struct pci_dev *dev);

