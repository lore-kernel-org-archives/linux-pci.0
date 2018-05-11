Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Subject: [PATCH v16 3/9] PCI/AER: Handle ERR_FATAL with removal and re-enumeration of devices
Date: Fri, 11 May 2018 06:43:22 -0400
Message-Id: <1526035408-31328-4-git-send-email-poza@codeaurora.org>
In-Reply-To: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
References: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch alters the behavior of handling of ERR_FATAL, where removal
of devices is initiated, followed by reset link, followed by
re-enumeration.

So the errors are handled in a different way as follows:
ERR_NONFATAL => call driver recovery entry points
ERR_FATAL    => remove and re-enumerate

please refer to Documentation/PCI/pci-error-recovery.txt for more details.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
Reviewed-by: Keith Busch <keith.busch@intel.com>

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 0ea5acc..649dd1f 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/kfifo.h>
 #include "aerdrv.h"
+#include "../../pci.h"
 
 #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
 				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
@@ -475,35 +476,84 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
 }
 
 /**
- * do_recovery - handle nonfatal/fatal error recovery process
+ * do_fatal_recovery - handle fatal error recovery process
+ * @dev: pointer to a pci_dev data structure of agent detecting an error
+ *
+ * Invoked when an error is fatal. Once being invoked, removes the devices
+ * benetah this AER agent, followed by reset link e.g. secondary bus reset
+ * followed by re-enumeration of devices.
+ */
+
+static void do_fatal_recovery(struct pci_dev *dev)
+{
+	struct pci_dev *udev;
+	struct pci_bus *parent;
+	struct pci_dev *pdev, *temp;
+	pci_ers_result_t result = PCI_ERS_RESULT_RECOVERED;
+	struct aer_broadcast_data result_data;
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
+
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		/*
+		 * If the error is reported by a bridge, we think this error
+		 * is related to the downstream link of the bridge, so we
+		 * do error recovery on all subordinates of the bridge instead
+		 * of the bridge and clear the error status of the bridge.
+		 */
+		pci_walk_bus(dev->subordinate, report_resume, &result_data);
+		pci_cleanup_aer_uncorrect_error_status(dev);
+	}
+
+	if (result == PCI_ERS_RESULT_RECOVERED) {
+		if (pcie_wait_for_link(udev, true))
+			pci_rescan_bus(udev->bus);
+	} else {
+		pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
+		pci_info(dev, "AER: Device recovery failed\n");
+	}
+
+	pci_unlock_rescan_remove();
+}
+
+/**
+ * do_nonfatal_recovery - handle nonfatal error recovery process
  * @dev: pointer to a pci_dev data structure of agent detecting an error
- * @severity: error severity type
  *
  * Invoked when an error is nonfatal/fatal. Once being invoked, broadcast
  * error detected message to all downstream drivers within a hierarchy in
  * question and return the returned code.
  */
-static void do_recovery(struct pci_dev *dev, int severity)
+static void do_nonfatal_recovery(struct pci_dev *dev)
 {
-	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
+	pci_ers_result_t status;
 	enum pci_channel_state state;
 
-	if (severity == AER_FATAL)
-		state = pci_channel_io_frozen;
-	else
-		state = pci_channel_io_normal;
+	state = pci_channel_io_normal;
 
 	status = broadcast_error_message(dev,
 			state,
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
@@ -562,8 +612,10 @@ static void handle_error_source(struct pcie_device *aerdev,
 		if (pos)
 			pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS,
 					info->status);
-	} else
-		do_recovery(dev, info->severity);
+	} else if (info->severity == AER_NONFATAL)
+		do_nonfatal_recovery(dev);
+	else if (info->severity == AER_FATAL)
+		do_fatal_recovery(dev);
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -627,8 +679,10 @@ static void aer_recover_work_func(struct work_struct *work)
 			continue;
 		}
 		cper_print_aer(pdev, entry.severity, entry.regs);
-		if (entry.severity != AER_CORRECTABLE)
-			do_recovery(pdev, entry.severity);
+		if (entry.severity == AER_NONFATAL)
+			do_nonfatal_recovery(pdev);
+		else if (entry.severity == AER_FATAL)
+			do_fatal_recovery(pdev);
 		pci_dev_put(pdev);
 	}
 }
-- 
2.7.4
