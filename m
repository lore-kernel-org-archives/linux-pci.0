Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35058 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbaANRPX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2014 12:15:23 -0500
Received: by mail-ig0-f179.google.com with SMTP id c10so2121359igq.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 09:15:22 -0800 (PST)
Received: from localhost ([172.29.122.186])
        by mx.google.com with ESMTPSA id f5sm2089360igc.4.2014.01.14.09.15.21
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Jan 2014 09:15:21 -0800 (PST)
Subject: [PATCH 1/2] PCI: Reorder so actual code comes before stubs
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 14 Jan 2014 10:15:20 -0700
Message-ID: <20140114171520.9148.72643.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140114171308.9148.47907.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140114171308.9148.47907.stgit@bhelgaas-glaptop.roam.corp.google.com>
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
 drivers/pci/pci-label.c |   57 +++++++++++++++++++++--------------------------
 include/linux/pci.h     |   46 +++++++++++++++++++-------------------
 2 files changed, 48 insertions(+), 55 deletions(-)

diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index d51f45aa669e..6f5d343d251c 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -34,21 +34,7 @@
 
 #define	DEVICE_LABEL_DSM	0x07
 
-#ifndef CONFIG_DMI
-
-static inline int
-pci_create_smbiosname_file(struct pci_dev *pdev)
-{
-	return -1;
-}
-
-static inline void
-pci_remove_smbiosname_file(struct pci_dev *pdev)
-{
-}
-
-#else
-
+#ifdef CONFIG_DMI
 enum smbios_attr_enum {
 	SMBIOS_ATTR_NONE = 0,
 	SMBIOS_ATTR_LABEL_SHOW,
@@ -156,31 +142,20 @@ pci_remove_smbiosname_file(struct pci_dev *pdev)
 {
 	sysfs_remove_group(&pdev->dev.kobj, &smbios_attr_group);
 }
-
-#endif
-
-#ifndef CONFIG_ACPI
-
-static inline int
-pci_create_acpi_index_label_files(struct pci_dev *pdev)
-{
-	return -1;
-}
-
+#else
 static inline int
-pci_remove_acpi_index_label_files(struct pci_dev *pdev)
+pci_create_smbiosname_file(struct pci_dev *pdev)
 {
 	return -1;
 }
 
-static inline bool
-device_has_dsm(struct device *dev)
+static inline void
+pci_remove_smbiosname_file(struct pci_dev *pdev)
 {
-	return false;
 }
+#endif
 
-#else
-
+#ifdef CONFIG_ACPI
 static const char device_label_dsm_uuid[] = {
 	0xD0, 0x37, 0xC9, 0xE5, 0x53, 0x35, 0x7A, 0x4D,
 	0x91, 0x17, 0xEA, 0x4D, 0x19, 0xC3, 0x43, 0x4D
@@ -364,6 +339,24 @@ pci_remove_acpi_index_label_files(struct pci_dev *pdev)
 	sysfs_remove_group(&pdev->dev.kobj, &acpi_attr_group);
 	return 0;
 }
+#else
+static inline int
+pci_create_acpi_index_label_files(struct pci_dev *pdev)
+{
+	return -1;
+}
+
+static inline int
+pci_remove_acpi_index_label_files(struct pci_dev *pdev)
+{
+	return -1;
+}
+
+static inline bool
+device_has_dsm(struct device *dev)
+{
+	return false;
+}
 #endif
 
 void pci_create_firmware_label_files(struct pci_dev *pdev)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index eba7764b1586..39a3609c8cda 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1149,7 +1149,22 @@ struct msix_entry {
 };
 
 
-#ifndef CONFIG_PCI_MSI
+#ifdef CONFIG_PCI_MSI
+int pci_msi_vec_count(struct pci_dev *dev);
+int pci_enable_msi_block(struct pci_dev *dev, int nvec);
+void pci_msi_shutdown(struct pci_dev *dev);
+void pci_disable_msi(struct pci_dev *dev);
+int pci_msix_vec_count(struct pci_dev *dev);
+int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec);
+void pci_msix_shutdown(struct pci_dev *dev);
+void pci_disable_msix(struct pci_dev *dev);
+void msi_remove_pci_irq_vectors(struct pci_dev *dev);
+void pci_restore_msi_state(struct pci_dev *dev);
+int pci_msi_enabled(void);
+int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec);
+int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
+			  int minvec, int maxvec);
+#else
 static inline int pci_msi_vec_count(struct pci_dev *dev)
 {
 	return -ENOSYS;
@@ -1200,21 +1215,6 @@ static inline int pci_enable_msix_range(struct pci_dev *dev,
 {
 	return -ENOSYS;
 }
-#else
-int pci_msi_vec_count(struct pci_dev *dev);
-int pci_enable_msi_block(struct pci_dev *dev, int nvec);
-void pci_msi_shutdown(struct pci_dev *dev);
-void pci_disable_msi(struct pci_dev *dev);
-int pci_msix_vec_count(struct pci_dev *dev);
-int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec);
-void pci_msix_shutdown(struct pci_dev *dev);
-void pci_disable_msix(struct pci_dev *dev);
-void msi_remove_pci_irq_vectors(struct pci_dev *dev);
-void pci_restore_msi_state(struct pci_dev *dev);
-int pci_msi_enabled(void);
-int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec);
-int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
-			  int minvec, int maxvec);
 #endif
 
 #ifdef CONFIG_PCIEPORTBUS
@@ -1225,10 +1225,10 @@ extern bool pcie_ports_auto;
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
@@ -1239,15 +1239,15 @@ static inline void pci_no_aer(void) { }
 static inline bool pci_aer_available(void) { return false; }
 #endif
 
-#ifndef CONFIG_PCIE_ECRC
+#ifdef CONFIG_PCIE_ECRC
+void pcie_set_ecrc_checking(struct pci_dev *dev);
+void pcie_ecrc_get_policy(char *str);
+#else
 static inline void pcie_set_ecrc_checking(struct pci_dev *dev)
 {
 	return;
 }
 static inline void pcie_ecrc_get_policy(char *str) {};
-#else
-void pcie_set_ecrc_checking(struct pci_dev *dev);
-void pcie_ecrc_get_policy(char *str);
 #endif
 
 #define pci_enable_msi(pdev)	pci_enable_msi_block(pdev, 1)

