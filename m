Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59922 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeBWIYU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Feb 2018 03:24:20 -0500
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
Subject: [PATCH v11 1/7] PCI/AER: Rename error recovery to generic pci naming
Date: Fri, 23 Feb 2018 13:53:58 +0530
Message-Id: <1519374244-20539-2-git-send-email-poza@codeaurora.org>
In-Reply-To: <1519374244-20539-1-git-send-email-poza@codeaurora.org>
References: <1519374244-20539-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch renames error recovery to generic name with pci prefix

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index a4bfea5..aeb83a0 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -478,7 +478,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
 }
 
 /**
- * do_recovery - handle nonfatal/fatal error recovery process
+ * pcie_do_recovery - handle nonfatal/fatal error recovery process
  * @dev: pointer to a pci_dev data structure of agent detecting an error
  * @severity: error severity type
  *
@@ -486,7 +486,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
  * error detected message to all downstream drivers within a hierarchy in
  * question and return the returned code.
  */
-static void do_recovery(struct pci_dev *dev, int severity)
+static void pcie_do_recovery(struct pci_dev *dev, int severity)
 {
 	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
 	enum pci_channel_state state;
@@ -566,7 +566,7 @@ static void handle_error_source(struct pcie_device *aerdev,
 			pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS,
 					info->status);
 	} else
-		do_recovery(dev, info->severity);
+		pcie_do_recovery(dev, info->severity);
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -631,7 +631,7 @@ static void aer_recover_work_func(struct work_struct *work)
 		}
 		cper_print_aer(pdev, entry.severity, entry.regs);
 		if (entry.severity != AER_CORRECTABLE)
-			do_recovery(pdev, entry.severity);
+			pcie_do_recovery(pdev, entry.severity);
 		pci_dev_put(pdev);
 	}
 }
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
