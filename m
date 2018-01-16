Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57268 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbeAPJ7E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jan 2018 04:59:04 -0500
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
Subject: [PATCH v4 2/5] PCI/ERR: Rename error reporting to generic pci naming
Date: Tue, 16 Jan 2018 15:28:40 +0530
Message-Id: <1516096723-8013-3-git-send-email-poza@codeaurora.org>
In-Reply-To: <1516096723-8013-1-git-send-email-poza@codeaurora.org>
References: <1516096723-8013-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch renames error reporting to generic function with pci prefix

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 4fda843..5ed9575 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -285,7 +285,7 @@ static void handle_error_source(struct pcie_device *aerdev,
 			pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS,
 					info->status);
 	} else
-		do_recovery(dev, info->severity);
+		pci_do_recovery(dev, info->severity);
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -349,7 +349,7 @@ static void aer_recover_work_func(struct work_struct *work)
 			continue;
 		}
 		cper_print_aer(pdev, entry.severity, entry.regs);
-		do_recovery(pdev, entry.severity);
+		pci_do_recovery(pdev, entry.severity);
 		pci_dev_put(pdev);
 	}
 }
diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
index 76e66bb..5792a9f 100644
--- a/drivers/pci/pcie/pcie-err.c
+++ b/drivers/pci/pcie/pcie-err.c
@@ -20,12 +20,12 @@
 #include <linux/pcieport_if.h>
 #include "portdrv.h"
 
-struct aer_broadcast_data {
+struct pci_err_broadcast_data {
 	enum pci_channel_state state;
 	enum pci_ers_result result;
 };
 
-pci_ers_result_t merge_result(enum pci_ers_result orig,
+pci_ers_result_t pci_merge_result(enum pci_ers_result orig,
 				  enum pci_ers_result new)
 {
 	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
@@ -50,13 +50,13 @@ pci_ers_result_t merge_result(enum pci_ers_result orig,
 	return orig;
 }
 
-int report_mmio_enabled(struct pci_dev *dev, void *data)
+int pci_report_mmio_enabled(struct pci_dev *dev, void *data)
 {
 	pci_ers_result_t vote;
 	const struct pci_error_handlers *err_handler;
-	struct aer_broadcast_data *result_data;
+	struct pci_err_broadcast_data *result_data;
 
-	result_data = (struct aer_broadcast_data *) data;
+	result_data = (struct pci_err_broadcast_data *) data;
 
 	device_lock(&dev->dev);
 	if (!dev->driver ||
@@ -66,19 +66,19 @@ int report_mmio_enabled(struct pci_dev *dev, void *data)
 
 	err_handler = dev->driver->err_handler;
 	vote = err_handler->mmio_enabled(dev);
-	result_data->result = merge_result(result_data->result, vote);
+	result_data->result = pci_merge_result(result_data->result, vote);
 out:
 	device_unlock(&dev->dev);
 	return 0;
 }
 
-int report_slot_reset(struct pci_dev *dev, void *data)
+int pci_report_slot_reset(struct pci_dev *dev, void *data)
 {
 	pci_ers_result_t vote;
 	const struct pci_error_handlers *err_handler;
-	struct aer_broadcast_data *result_data;
+	struct pci_err_broadcast_data *result_data;
 
-	result_data = (struct aer_broadcast_data *) data;
+	result_data = (struct pci_err_broadcast_data *) data;
 
 	device_lock(&dev->dev);
 	if (!dev->driver ||
@@ -88,13 +88,13 @@ int report_slot_reset(struct pci_dev *dev, void *data)
 
 	err_handler = dev->driver->err_handler;
 	vote = err_handler->slot_reset(dev);
-	result_data->result = merge_result(result_data->result, vote);
+	result_data->result = pci_merge_result(result_data->result, vote);
 out:
 	device_unlock(&dev->dev);
 	return 0;
 }
 
-int report_resume(struct pci_dev *dev, void *data)
+int pci_report_resume(struct pci_dev *dev, void *data)
 {
 	const struct pci_error_handlers *err_handler;
 
@@ -113,13 +113,13 @@ int report_resume(struct pci_dev *dev, void *data)
 	return 0;
 }
 
-int report_error_detected(struct pci_dev *dev, void *data)
+int pci_report_error_detected(struct pci_dev *dev, void *data)
 {
 	pci_ers_result_t vote;
 	const struct pci_error_handlers *err_handler;
-	struct aer_broadcast_data *result_data;
+	struct pci_err_broadcast_data *result_data;
 
-	result_data = (struct aer_broadcast_data *) data;
+	result_data = (struct pci_err_broadcast_data *) data;
 
 	device_lock(&dev->dev);
 	dev->error_state = result_data->state;
@@ -160,26 +160,26 @@ int report_error_detected(struct pci_dev *dev, void *data)
 		vote = err_handler->error_detected(dev, result_data->state);
 	}
 
-	result_data->result = merge_result(result_data->result, vote);
+	result_data->result = pci_merge_result(result_data->result, vote);
 	device_unlock(&dev->dev);
 	return 0;
 }
 
 /**
- * default_reset_link - default reset function
+ * pci_default_reset_link - default reset function
  * @dev: pointer to pci_dev data structure
  *
  * Invoked when performing link reset on a Downstream Port or a
  * Root Port with no aer driver.
  */
-static pci_ers_result_t default_reset_link(struct pci_dev *dev)
+static pci_ers_result_t pci_default_reset_link(struct pci_dev *dev)
 {
 	pci_reset_bridge_secondary_bus(dev);
 	dev_printk(KERN_DEBUG, &dev->dev, "downstream link has been reset\n");
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-pci_ers_result_t reset_link(struct pci_dev *dev)
+pci_ers_result_t pci_reset_link(struct pci_dev *dev)
 {
 	struct pci_dev *udev;
 	pci_ers_result_t status;
@@ -201,7 +201,7 @@ pci_ers_result_t reset_link(struct pci_dev *dev)
 	if (driver && driver->reset_link) {
 		status = driver->reset_link(udev);
 	} else if (udev->has_secondary_link) {
-		status = default_reset_link(udev);
+		status = pci_default_reset_link(udev);
 	} else {
 		dev_printk(KERN_DEBUG, &dev->dev,
 			"no link-reset support at upstream device %s\n",
@@ -220,7 +220,7 @@ pci_ers_result_t reset_link(struct pci_dev *dev)
 }
 
 /**
- * broadcast_error_message - handle message broadcast to downstream drivers
+ * pci_broadcast_error_message - handle message broadcast to downstream drivers
  * @dev: pointer to from where in a hierarchy message is broadcasted down
  * @state: error state
  * @error_mesg: message to print
@@ -230,16 +230,16 @@ pci_ers_result_t reset_link(struct pci_dev *dev)
  * of error severity will be broadcasted to all downstream drivers in a
  * hierarchy in question.
  */
-pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
+pci_ers_result_t pci_broadcast_error_message(struct pci_dev *dev,
 	enum pci_channel_state state,
 	char *error_mesg,
 	int (*cb)(struct pci_dev *, void *))
 {
-	struct aer_broadcast_data result_data;
+	struct pci_err_broadcast_data result_data;
 
 	dev_printk(KERN_DEBUG, &dev->dev, "broadcast %s message\n", error_mesg);
 	result_data.state = state;
-	if (cb == report_error_detected)
+	if (cb == pci_report_error_detected)
 		result_data.result = PCI_ERS_RESULT_CAN_RECOVER;
 	else
 		result_data.result = PCI_ERS_RESULT_RECOVERED;
@@ -251,10 +251,10 @@ pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 		 * do error recovery on all subordinates of the bridge instead
 		 * of the bridge and clear the error status of the bridge.
 		 */
-		if (cb == report_error_detected)
+		if (cb == pci_report_error_detected)
 			dev->error_state = state;
 		pci_walk_bus(dev->subordinate, cb, &result_data);
-		if (cb == report_resume) {
+		if (cb == pci_report_resume) {
 			pci_cleanup_aer_uncorrect_error_status(dev);
 			dev->error_state = pci_channel_io_normal;
 		}
@@ -270,7 +270,7 @@ pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 }
 
 /**
- * do_recovery - handle nonfatal/fatal error recovery process
+ * pci_do_recovery - handle nonfatal/fatal error recovery process
  * @dev: pointer to a pci_dev data structure of agent detecting an error
  * @severity: error severity type
  *
@@ -278,7 +278,7 @@ pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
  * error detected message to all downstream drivers within a hierarchy in
  * question and return the returned code.
  */
-void do_recovery(struct pci_dev *dev, int severity)
+void pci_do_recovery(struct pci_dev *dev, int severity)
 {
 	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
 	enum pci_channel_state state;
@@ -288,22 +288,22 @@ void do_recovery(struct pci_dev *dev, int severity)
 	else
 		state = pci_channel_io_normal;
 
-	status = broadcast_error_message(dev,
+	status = pci_broadcast_error_message(dev,
 			state,
 			"error_detected",
-			report_error_detected);
+			pci_report_error_detected);
 
 	if (severity == AER_FATAL) {
-		result = reset_link(dev);
+		result = pci_reset_link(dev);
 		if (result != PCI_ERS_RESULT_RECOVERED)
 			goto failed;
 	}
 
 	if (status == PCI_ERS_RESULT_CAN_RECOVER)
-		status = broadcast_error_message(dev,
+		status = pci_broadcast_error_message(dev,
 				state,
 				"mmio_enabled",
-				report_mmio_enabled);
+				pci_report_mmio_enabled);
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
 		/*
@@ -311,19 +311,19 @@ void do_recovery(struct pci_dev *dev, int severity)
 		 * functions to reset slot before calling
 		 * drivers' slot_reset callbacks?
 		 */
-		status = broadcast_error_message(dev,
+		status = pci_broadcast_error_message(dev,
 				state,
 				"slot_reset",
-				report_slot_reset);
+				pci_report_slot_reset);
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED)
 		goto failed;
 
-	broadcast_error_message(dev,
+	pci_broadcast_error_message(dev,
 				state,
 				"resume",
-				report_resume);
+				pci_report_resume);
 
 	dev_info(&dev->dev, "Device recovery successful\n");
 	return;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 46fd243..babcd89 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1998,7 +1998,7 @@ static inline resource_size_t pci_iov_resource_size(struct pci_dev *dev, int res
 void pci_hp_remove_module_link(struct pci_slot *pci_slot);
 #endif
 
-void do_recovery(struct pci_dev *dev, int severity);
+void pci_do_recovery(struct pci_dev *dev, int severity);
 
 /**
  * pci_pcie_cap - get the saved PCIe capability offset
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
