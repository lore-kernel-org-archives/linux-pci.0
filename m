Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41629 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751546AbeDIWCH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Apr 2018 18:02:07 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex_Gagniuc@Dellteam.com, Scott Bauer <scott.bauer@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 1/4] PCI/AER: Remove unused parameters
Date: Mon,  9 Apr 2018 16:04:41 -0600
Message-Id: <20180409220444.6632-2-keith.busch@intel.com>
In-Reply-To: <20180409220444.6632-1-keith.busch@intel.com>
References: <20180409220444.6632-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer/aerdrv_core.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 0ea5acc40323..a533ea25e52c 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -541,15 +541,12 @@ static void do_recovery(struct pci_dev *dev, int severity)
 
 /**
  * handle_error_source - handle logging error into an event log
- * @aerdev: pointer to pcie_device data structure of the root port
  * @dev: pointer to pci_dev data structure of error source device
  * @info: comprehensive error information
  *
  * Invoked when an error being detected by Root Port.
  */
-static void handle_error_source(struct pcie_device *aerdev,
-	struct pci_dev *dev,
-	struct aer_err_info *info)
+static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
 	int pos;
 
@@ -695,8 +692,7 @@ static int get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 	return 1;
 }
 
-static inline void aer_process_err_devices(struct pcie_device *p_device,
-			struct aer_err_info *e_info)
+static inline void aer_process_err_devices(struct aer_err_info *e_info)
 {
 	int i;
 
@@ -707,7 +703,7 @@ static inline void aer_process_err_devices(struct pcie_device *p_device,
 	}
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
 		if (get_device_error_info(e_info->dev[i], e_info))
-			handle_error_source(p_device, e_info->dev[i], e_info);
+			handle_error_source(e_info->dev[i], e_info);
 	}
 }
 
@@ -738,7 +734,7 @@ static void aer_isr_one_error(struct pcie_device *p_device,
 		aer_print_port_info(p_device->port, e_info);
 
 		if (find_source_device(p_device->port, e_info))
-			aer_process_err_devices(p_device, e_info);
+			aer_process_err_devices(e_info);
 	}
 
 	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
@@ -757,7 +753,7 @@ static void aer_isr_one_error(struct pcie_device *p_device,
 		aer_print_port_info(p_device->port, e_info);
 
 		if (find_source_device(p_device->port, e_info))
-			aer_process_err_devices(p_device, e_info);
+			aer_process_err_devices(e_info);
 	}
 }
 
-- 
2.14.3
