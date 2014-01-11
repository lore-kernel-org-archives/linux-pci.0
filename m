Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:39885 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbaAKB2Q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jan 2014 20:28:16 -0500
Received: by mail-pa0-f41.google.com with SMTP id fb1so3883705pad.28
        for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2014 17:28:16 -0800 (PST)
Subject: [PATCH v2 12/12] PCI: Cleanup pci.h whitespace
To: Stephen Hemminger <stephen@networkplumber.org>,
	linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yu Zhao <yu.zhao@intel.com>
Date: Fri, 10 Jan 2014 18:28:12 -0700
Message-ID: <20140111012812.14505.87236.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Put empty or trivial inline stub functions on one line when they fit.  No
functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci.h |   41 ++++++++++-------------------------------
 1 file changed, 10 insertions(+), 31 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9da6a0cf2776..55ecc0aae669 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1151,35 +1151,21 @@ pci_enable_msi_block_auto(struct pci_dev *dev, unsigned int *maxvec)
 	return -1;
 }
 
-static inline void pci_msi_shutdown(struct pci_dev *dev)
-{ }
-static inline void pci_disable_msi(struct pci_dev *dev)
-{ }
+static inline void pci_msi_shutdown(struct pci_dev *dev) { }
+static inline void pci_disable_msi(struct pci_dev *dev) { }
 
-static inline int pci_msix_table_size(struct pci_dev *dev)
-{
-	return 0;
-}
+static inline int pci_msix_table_size(struct pci_dev *dev) { return 0; }
 static inline int pci_enable_msix(struct pci_dev *dev,
 				  struct msix_entry *entries, int nvec)
 {
 	return -1;
 }
 
-static inline void pci_msix_shutdown(struct pci_dev *dev)
-{ }
-static inline void pci_disable_msix(struct pci_dev *dev)
-{ }
-
-static inline void msi_remove_pci_irq_vectors(struct pci_dev *dev)
-{ }
-
-static inline void pci_restore_msi_state(struct pci_dev *dev)
-{ }
-static inline int pci_msi_enabled(void)
-{
-	return 0;
-}
+static inline void pci_msix_shutdown(struct pci_dev *dev) { }
+static inline void pci_disable_msix(struct pci_dev *dev) { }
+static inline void msi_remove_pci_irq_vectors(struct pci_dev *dev) { }
+static inline void pci_restore_msi_state(struct pci_dev *dev) { }
+static inline int pci_msi_enabled(void) { return 0; }
 #endif
 
 #ifdef CONFIG_PCIEPORTBUS
@@ -1233,15 +1219,8 @@ void pci_cfg_access_unlock(struct pci_dev *dev);
 extern int pci_domains_supported;
 #else
 enum { pci_domains_supported = 0 };
-static inline int pci_domain_nr(struct pci_bus *bus)
-{
-	return 0;
-}
-
-static inline int pci_proc_domain(struct pci_bus *bus)
-{
-	return 0;
-}
+static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
+static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
 #endif /* CONFIG_PCI_DOMAINS */
 
 /* some architectures require additional setup to direct VGA traffic */

