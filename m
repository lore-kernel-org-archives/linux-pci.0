Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from alexa-out.qualcomm.com ([129.46.98.28]:50400 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751808AbeECFEE (ORCPT
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
Subject: [PATCH v15 3/9] PCI/AER: Handle ERR_FATAL with removal and re-enumeration of devices
Date: Thu,  3 May 2018 01:03:52 -0400
Message-Id: <1525323838-1735-4-git-send-email-poza@codeaurora.org>
In-Reply-To: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
References: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch alters the behavior of handling of ERR_FATAL, where removal
of devices is initiated, followed by reset link, followed by
re-enumeration.

So the errors are handled in a different way as follows:
ERR_NONFATAL => call driver recovery entry points
ERR_FATAL    => remove and re-enumerate

please refer to Documentation/PCI/pci-error-recovery.txt for more details.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 779b387..206f590 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -330,6 +330,13 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
 	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
 
+	/*
+	 * This function is called only on ERR_FATAL now, and since
+	 * the pci_report_resume is called only in ERR_NONFATAL case,
+	 * the clearing part has to be taken care here.
+	 */
+	aer_error_resume(dev);
+
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 0ea5acc..655d4e8 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/kfifo.h>
 #include "aerdrv.h"
+#include "../../pci.h"
 
 #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
 				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
@@ -474,6 +475,44 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
 	return status;
 }
 
+static pci_ers_result_t do_fatal_recovery(struct pci_dev *dev, int severity)
+{
+	struct pci_dev *udev;
+	struct pci_bus *parent;
+	struct pci_dev *pdev, *temp;
+	pci_ers_result_t result = PCI_ERS_RESULT_RECOVERED;
+
+	if (severity == AER_FATAL)
+		pci_cleanup_aer_uncorrect_error_status(dev);
+
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
+		udev = dev;
+	else
+		udev = dev->bus->self;
+
+	parent = udev->subordinate;
+	pci_lock_rescan_remove();
+	list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
+				 bus_list) {
+		pci_dev_get(pdev);
+		pci_dev_set_disconnected(pdev, NULL);
+		if (pci_has_subordinate(pdev))
+			pci_walk_bus(pdev->subordinate,
+				     pci_dev_set_disconnected, NULL);
+		pci_stop_and_remove_bus_device(pdev);
+		pci_dev_put(pdev);
+	}
+
+	result = reset_link(udev);
+	if (result == PCI_ERS_RESULT_RECOVERED)
+		if (pcie_wait_for_link(udev, true))
+			pci_rescan_bus(udev->bus);
+
+	pci_unlock_rescan_remove();
+
+	return result;
+}
+
 /**
  * do_recovery - handle nonfatal/fatal error recovery process
  * @dev: pointer to a pci_dev data structure of agent detecting an error
@@ -485,11 +524,15 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
  */
 static void do_recovery(struct pci_dev *dev, int severity)
 {
-	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
+	pci_ers_result_t status;
 	enum pci_channel_state state;
 
-	if (severity == AER_FATAL)
-		state = pci_channel_io_frozen;
+	if (severity == AER_FATAL) {
+		status = do_fatal_recovery(dev, severity);
+		if (status != PCI_ERS_RESULT_RECOVERED)
+			goto failed;
+		return;
+	}
 	else
 		state = pci_channel_io_normal;
 
@@ -498,12 +541,6 @@ static void do_recovery(struct pci_dev *dev, int severity)
 			"error_detected",
 			report_error_detected);
 
-	if (severity == AER_FATAL) {
-		result = reset_link(dev);
-		if (result != PCI_ERS_RESULT_RECOVERED)
-			goto failed;
-	}
-
 	if (status == PCI_ERS_RESULT_CAN_RECOVER)
 		status = broadcast_error_message(dev,
 				state,
-- 
2.7.4
