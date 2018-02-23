Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60840 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbeBWIYo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Feb 2018 03:24:44 -0500
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
Subject: [PATCH v11 7/7] PCI/DPC: Enumerate the devices after DPC trigger event
Date: Fri, 23 Feb 2018 13:54:04 +0530
Message-Id: <1519374244-20539-8-git-send-email-poza@codeaurora.org>
In-Reply-To: <1519374244-20539-1-git-send-email-poza@codeaurora.org>
References: <1519374244-20539-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Implement error_resume callback in DPC so, after DPC trigger event
enumerates the devices beneath.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index e15bcda..751efc0 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -126,6 +126,21 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
 }
 
 /**
+ * dpc_error_resume - enumerate the devices beneath
+ * @dev: pointer to Root Port's pci_dev data structure
+ *
+ * Invoked by Port Bus driver during fatal recovery.
+ */
+static void dpc_error_resume(struct pci_dev *pdev)
+{
+	if (pci_wait_for_link(pdev, true)) {
+		pci_lock_rescan_remove();
+		pci_rescan_bus(pdev->bus);
+		pci_unlock_rescan_remove();
+	}
+}
+
+/**
  * dpc_reset_link - reset link DPC  routine
  * @dev: pointer to Root Port's pci_dev data structure
  *
@@ -364,6 +379,7 @@ static void dpc_remove(struct pcie_device *dev)
 	.probe		= dpc_probe,
 	.remove		= dpc_remove,
 	.reset_link     = dpc_reset_link,
+	.error_resume	= dpc_error_resume,
 };
 
 static int __init dpc_service_init(void)
diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
index 1ea4b9a..1e1bf98 100644
--- a/drivers/pci/pcie/pcie-err.c
+++ b/drivers/pci/pcie/pcie-err.c
@@ -236,6 +236,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev, int severity)
  * @state: error state
  * @error_mesg: message to print
  * @cb: callback to be broadcast
+ * @severity: error severity
  *
  * Invoked during error recovery process. Once being invoked, the content
  * of error severity will be broadcast to all downstream drivers in a
@@ -244,7 +245,8 @@ static pci_ers_result_t reset_link(struct pci_dev *dev, int severity)
 static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 	enum pci_channel_state state,
 	char *error_mesg,
-	int (*cb)(struct pci_dev *, void *))
+	int (*cb)(struct pci_dev *, void *),
+	int severity)
 {
 	struct aer_broadcast_data result_data;
 
@@ -256,6 +258,17 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 		result_data.result = PCI_ERS_RESULT_RECOVERED;
 
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		/* If DPC is triggered, call resume error handler
+		 * because, at this point we can safely assume that
+		 * link recovery has happened, this is only handled if
+		 * callback is resume, as this function can be called
+		 * with multiple callbacks.
+		 */
+		if ((severity == DPC_FATAL) &&
+		    (cb == report_resume)) {
+			cb(dev, NULL);
+			return PCI_ERS_RESULT_RECOVERED;
+		}
 		/*
 		 * If the error is reported by a bridge, we think this error
 		 * is related to the downstream link of the bridge, so we
@@ -305,7 +318,8 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
 	status = broadcast_error_message(dev,
 			state,
 			"error_detected",
-			report_error_detected);
+			report_error_detected,
+			severity);
 
 	if (severity == AER_FATAL ||
 	    severity == DPC_FATAL) {
@@ -321,7 +335,8 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
 		status = broadcast_error_message(dev,
 				state,
 				"mmio_enabled",
-				report_mmio_enabled);
+				report_mmio_enabled,
+				severity);
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
 		/*
@@ -332,7 +347,8 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
 		status = broadcast_error_message(dev,
 				state,
 				"slot_reset",
-				report_slot_reset);
+				report_slot_reset,
+				severity);
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED)
@@ -342,7 +358,8 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
 	broadcast_error_message(dev,
 				state,
 				"resume",
-				report_resume);
+				report_resume,
+				severity);
 
 	dev_info(&dev->dev, "Device recovery successful\n");
 	mutex_unlock(&pci_err_recovery_lock);
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
