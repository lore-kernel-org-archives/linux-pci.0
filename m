Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33767 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbbGQVcv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2015 17:32:51 -0400
Received: by obbgp5 with SMTP id gp5so73126930obb.0
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2015 14:32:51 -0700 (PDT)
Subject: [PATCH 8/8] PCI: Move ATS declarations to linux/pci.h so they're
 all together
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gregor Dick <gdick@solarflare.com>
Date: Fri, 17 Jul 2015 16:32:47 -0500
Message-ID: <20150717213247.18379.66315.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Move ATS declarations to linux/pci.h so they're all in one place.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci-ats.h |   41 -----------------------------------------
 include/linux/pci.h     |    8 ++++++++
 2 files changed, 8 insertions(+), 41 deletions(-)

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
index 1997853..744a5e9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1300,8 +1300,16 @@ void ht_destroy_irq(unsigned int irq);
 #ifdef CONFIG_PCI_ATS
 /* Address Translation Service */
 void pci_ats_init(struct pci_dev *dev);
+int pci_enable_ats(struct pci_dev *dev, int ps);
+void pci_disable_ats(struct pci_dev *dev);
+int pci_ats_queue_depth(struct pci_dev *dev);
+static inline int pci_ats_enabled(struct pci_dev *dev) { return dev->ats_enabled; }
 #else
 static inline void pci_ats_init(struct pci_dev *) { }
+static inline int pci_enable_ats(struct pci_dev *, int) { return -ENODEV; }
+static inline void pci_disable_ats(struct pci_dev *) { }
+static inline int pci_ats_queue_depth(struct pci_dev *) { return -ENODEV; }
+static inline int pci_ats_enabled(struct pci_dev *dev) { return 0; }
 #endif
 
 void pci_cfg_access_lock(struct pci_dev *dev);

