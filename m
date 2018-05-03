Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sabertooth01.qualcomm.com ([65.197.215.72]:11756 "EHLO
        sabertooth01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeECFEE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 May 2018 01:04:04 -0400
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH v15 4/9] PCI/AER: Rename error recovery to generic PCI naming
Date: Thu,  3 May 2018 01:03:53 -0400
Message-Id: <1525323838-1735-5-git-send-email-poza@codeaurora.org>
In-Reply-To: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
References: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch renames error recovery to generic name with pcie prefix

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
Reviewed-by: Keith Busch <keith.busch@intel.com>

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index cec9d8c..22a9589 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -353,6 +353,9 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 
 void pci_enable_acs(struct pci_dev *dev);
 
+/* PCI error reporting and recovery */
+void pcie_do_recovery(struct pci_dev *dev, int severity);
+
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 655d4e8..be4ee3b 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -475,7 +475,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
 	return status;
 }
 
-static pci_ers_result_t do_fatal_recovery(struct pci_dev *dev, int severity)
+static pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev, int severity)
 {
 	struct pci_dev *udev;
 	struct pci_bus *parent;
@@ -514,7 +514,7 @@ static pci_ers_result_t do_fatal_recovery(struct pci_dev *dev, int severity)
 }
 
 /**
- * do_recovery - handle nonfatal/fatal error recovery process
+ * pcie_do_recovery - handle nonfatal/fatal error recovery process
  * @dev: pointer to a pci_dev data structure of agent detecting an error
  * @severity: error severity type
  *
@@ -522,13 +522,13 @@ static pci_ers_result_t do_fatal_recovery(struct pci_dev *dev, int severity)
  * error detected message to all downstream drivers within a hierarchy in
  * question and return the returned code.
  */
-static void do_recovery(struct pci_dev *dev, int severity)
+void pcie_do_recovery(struct pci_dev *dev, int severity)
 {
 	pci_ers_result_t status;
 	enum pci_channel_state state;
 
 	if (severity == AER_FATAL) {
-		status = do_fatal_recovery(dev, severity);
+		status = pcie_do_fatal_recovery(dev, severity);
 		if (status != PCI_ERS_RESULT_RECOVERED)
 			goto failed;
 		return;
@@ -600,7 +600,7 @@ static void handle_error_source(struct pcie_device *aerdev,
 			pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS,
 					info->status);
 	} else
-		do_recovery(dev, info->severity);
+		pcie_do_recovery(dev, info->severity);
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -665,7 +665,7 @@ static void aer_recover_work_func(struct work_struct *work)
 		}
 		cper_print_aer(pdev, entry.severity, entry.regs);
 		if (entry.severity != AER_CORRECTABLE)
-			do_recovery(pdev, entry.severity);
+			pcie_do_recovery(pdev, entry.severity);
 		pci_dev_put(pdev);
 	}
 }
-- 
2.7.4
