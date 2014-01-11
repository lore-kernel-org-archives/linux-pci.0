Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:63213 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbaAKB2I (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jan 2014 20:28:08 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so5102126pbc.26
        for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2014 17:28:07 -0800 (PST)
Subject: [PATCH v2 11/12] PCI: Reorder pci.h so actual interfaces come
 before stubs
To: Stephen Hemminger <stephen@networkplumber.org>,
	linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yu Zhao <yu.zhao@intel.com>
Date: Fri, 10 Jan 2014 18:28:05 -0700
Message-ID: <20140111012804.14505.28679.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Consistently use the:

    #ifdef CONFIG_PCI_FOO
    int pci_foo(...);
    #else
    static inline int pci_foo(...) { return -1; }
    #endif

pattern, instead of sometimes using "#ifndef CONFIG_PCI_FOO".

No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci.h |   43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 169ef1944d14..9da6a0cf2776 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1127,7 +1127,19 @@ struct msix_entry {
 };
 
 
-#ifndef CONFIG_PCI_MSI
+#ifdef CONFIG_PCI_MSI
+int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec);
+int pci_enable_msi_block_auto(struct pci_dev *dev, unsigned int *maxvec);
+void pci_msi_shutdown(struct pci_dev *dev);
+void pci_disable_msi(struct pci_dev *dev);
+int pci_msix_table_size(struct pci_dev *dev);
+int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec);
+void pci_msix_shutdown(struct pci_dev *dev);
+void pci_disable_msix(struct pci_dev *dev);
+void msi_remove_pci_irq_vectors(struct pci_dev *dev);
+void pci_restore_msi_state(struct pci_dev *dev);
+int pci_msi_enabled(void);
+#else
 static inline int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec)
 {
 	return -1;
@@ -1168,18 +1180,6 @@ static inline int pci_msi_enabled(void)
 {
 	return 0;
 }
-#else
-int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec);
-int pci_enable_msi_block_auto(struct pci_dev *dev, unsigned int *maxvec);
-void pci_msi_shutdown(struct pci_dev *dev);
-void pci_disable_msi(struct pci_dev *dev);
-int pci_msix_table_size(struct pci_dev *dev);
-int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec);
-void pci_msix_shutdown(struct pci_dev *dev);
-void pci_disable_msix(struct pci_dev *dev);
-void msi_remove_pci_irq_vectors(struct pci_dev *dev);
-void pci_restore_msi_state(struct pci_dev *dev);
-int pci_msi_enabled(void);
 #endif
 
 #ifdef CONFIG_PCIEPORTBUS
@@ -1190,10 +1190,10 @@ extern bool pcie_ports_auto;
 #define pcie_ports_auto		false
 #endif
 
-#ifndef CONFIG_PCIEASPM
-static inline bool pcie_aspm_support_enabled(void) { return false; }
-#else
+#ifdef CONFIG_PCIEASPM
 bool pcie_aspm_support_enabled(void);
+#else
+static inline bool pcie_aspm_support_enabled(void) { return false; }
 #endif
 
 #ifdef CONFIG_PCIEAER
@@ -1204,15 +1204,12 @@ static inline void pci_no_aer(void) { }
 static inline bool pci_aer_available(void) { return false; }
 #endif
 
-#ifndef CONFIG_PCIE_ECRC
-static inline void pcie_set_ecrc_checking(struct pci_dev *dev)
-{
-	return;
-}
-static inline void pcie_ecrc_get_policy(char *str) {};
-#else
+#ifdef CONFIG_PCIE_ECRC
 void pcie_set_ecrc_checking(struct pci_dev *dev);
 void pcie_ecrc_get_policy(char *str);
+#else
+static inline void pcie_set_ecrc_checking(struct pci_dev *dev) { }
+static inline void pcie_ecrc_get_policy(char *str) { }
 #endif
 
 #define pci_enable_msi(pdev)	pci_enable_msi_block(pdev, 1)

