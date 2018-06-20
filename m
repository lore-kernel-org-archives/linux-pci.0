Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20585 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933433AbeFTVfX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Jun 2018 17:35:23 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 4/7] PCI/AER: API for obtaining AER information
Date: Wed, 20 Jun 2018 15:38:30 -0600
Message-Id: <20180620213833.25072-4-keith.busch@intel.com>
In-Reply-To: <20180620213833.25072-1-keith.busch@intel.com>
References: <20180620213833.25072-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This exports some commone AER functions and structures for other drivers
to use. Since this is making the function externally visible, appending
"aer_" prefix to the function name.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer.c | 30 +++++-------------------------
 include/linux/aer.h    | 24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e88386af28..0a60275f0582 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -31,26 +31,6 @@
 #include "portdrv.h"
 
 #define AER_ERROR_SOURCES_MAX		100
-#define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
-
-struct aer_err_info {
-	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
-	int error_dev_num;
-
-	unsigned int id:16;
-
-	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
-	unsigned int __pad1:5;
-	unsigned int multi_error_valid:1;
-
-	unsigned int first_error:5;
-	unsigned int __pad2:2;
-	unsigned int tlp_header_valid:1;
-
-	unsigned int status;		/* COR/UNCOR Error Status */
-	unsigned int mask;		/* COR/UNCOR Error Mask */
-	struct aer_header_log_regs tlp;	/* TLP Header */
-};
 
 struct aer_err_source {
 	unsigned int status;
@@ -547,7 +527,7 @@ static void __aer_print_error(struct pci_dev *dev,
 	}
 }
 
-static void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
+void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	int layer, agent;
 	int id = ((dev->bus->number << 8) | dev->devfn);
@@ -876,7 +856,7 @@ EXPORT_SYMBOL_GPL(aer_recover_queue);
 #endif
 
 /**
- * get_device_error_info - read error status from dev and store it to info
+ * aer_get_device_error_info - read error status from dev and store it to info
  * @dev: pointer to the device expected to have a error record
  * @info: pointer to structure to store the error record
  *
@@ -884,7 +864,7 @@ EXPORT_SYMBOL_GPL(aer_recover_queue);
  *
  * Note that @info is reused among all error devices. Clear fields properly.
  */
-static int get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
+int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 {
 	int pos, temp;
 
@@ -942,11 +922,11 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
 
 	/* Report all before handle them, not to lost records by reset etc. */
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
-		if (get_device_error_info(e_info->dev[i], e_info))
+		if (aer_get_device_error_info(e_info->dev[i], e_info))
 			aer_print_error(e_info->dev[i], e_info);
 	}
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
-		if (get_device_error_info(e_info->dev[i], e_info))
+		if (aer_get_device_error_info(e_info->dev[i], e_info))
 			handle_error_source(e_info->dev[i], e_info);
 	}
 }
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 514bffa11dbb..58fa04cc7407 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -40,6 +40,27 @@ struct aer_capability_regs {
 	u16 uncor_err_source;
 };
 
+#define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
+
+struct aer_err_info {
+	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
+	int error_dev_num;
+
+	unsigned int id:16;
+
+	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
+	unsigned int __pad1:5;
+	unsigned int multi_error_valid:1;
+
+	unsigned int first_error:5;
+	unsigned int __pad2:2;
+	unsigned int tlp_header_valid:1;
+
+	unsigned int status;		/* COR/UNCOR Error Status */
+	unsigned int mask;		/* COR/UNCOR Error Mask */
+	struct aer_header_log_regs tlp;	/* TLP Header */
+};
+
 #if defined(CONFIG_PCIEAER)
 /* PCIe port driver needs this function to enable AER */
 int pci_enable_pcie_error_reporting(struct pci_dev *dev);
@@ -65,6 +86,9 @@ static inline int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 }
 #endif
 
+int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
+void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
+
 void cper_print_aer(struct pci_dev *dev, int aer_severity,
 		    struct aer_capability_regs *aer);
 int cper_severity_to_aer(int cper_severity);
-- 
2.14.3
