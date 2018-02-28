Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45278 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932812AbeB1RFB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Feb 2018 12:05:01 -0500
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
Subject: [PATCH v12 6/6] PCI/DPC: Enumerate the devices after DPC trigger event
Date: Wed, 28 Feb 2018 22:34:17 +0530
Message-Id: <1519837457-3596-7-git-send-email-poza@codeaurora.org>
In-Reply-To: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Implement error_resume callback in DPC so, after DPC trigger event
enumerates the devices beneath.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 9f1c983..d439bfd 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -237,7 +237,8 @@ static pci_ers_result_t reset_link(struct pci_dev *dev, int severity)
 static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 	enum pci_channel_state state,
 	char *error_mesg,
-	int (*cb)(struct pci_dev *, void *))
+	int (*cb)(struct pci_dev *, void *),
+	int severity)
 {
 	struct aer_broadcast_data result_data;
 
@@ -249,6 +250,17 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 		result_data.result = PCI_ERS_RESULT_RECOVERED;
 
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		/* If DPC is triggered, call resume error handler
+		 * because, at this point we can safely assume that
+		 * link recovery has happened, this is only handled if
+		 * callback is resume, as this function can be called
+		 * with multiple callbacks.
+		 */
+		if ((severity == DPC_FATAL) &&
+			(cb == report_resume)) {
+			cb(dev, NULL);
+			return PCI_ERS_RESULT_RECOVERED;
+		}
 		/*
 		 * If the error is reported by a bridge, we think this error
 		 * is related to the downstream link of the bridge, so we
@@ -296,7 +308,8 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
 	status = broadcast_error_message(dev,
 			state,
 			"error_detected",
-			report_error_detected);
+			report_error_detected,
+			severity);
 
 	if ((severity == AER_FATAL) ||
 	    (severity == DPC_FATAL)) {
@@ -311,7 +324,8 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
 		status = broadcast_error_message(dev,
 				state,
 				"mmio_enabled",
-				report_mmio_enabled);
+				report_mmio_enabled,
+				severity);
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
 		/*
@@ -322,7 +336,8 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
 		status = broadcast_error_message(dev,
 				state,
 				"slot_reset",
-				report_slot_reset);
+				report_slot_reset,
+				severity);
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED)
@@ -332,7 +347,8 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
 	broadcast_error_message(dev,
 				state,
 				"resume",
-				report_resume);
+				report_resume,
+				severity);
 
 	dev_info(&dev->dev, "Device recovery successful\n");
 	return;
diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 8e1553b..fb6bbd3 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -101,9 +101,24 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
 }
 
 /**
- * dpc_reset_link - reset link DPC routine
+ * dpc_error_resume - enumerate the devices beneath
  * @pdev: pointer to Root Port's pci_dev data structure
  *
+ * Invoked by Port Bus driver during fatal recovery.
+ */
+static void dpc_error_resume(struct pci_dev *pdev)
+{
+	if (pcie_wait_for_link(pdev, true)) {
+		pci_lock_rescan_remove();
+		pci_rescan_bus(pdev->bus);
+		pci_unlock_rescan_remove();
+	}
+}
+
+/**
+ * dpc_reset_link - reset link DPC routine
+ * @dev: pointer to Root Port's pci_dev data structure
+ *
  * Invoked by Port Bus driver when performing link reset at Root Port.
  */
 static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
@@ -338,6 +353,7 @@ static void dpc_remove(struct pcie_device *dev)
 	.service	= PCIE_PORT_SERVICE_DPC,
 	.probe		= dpc_probe,
 	.remove		= dpc_remove,
+	.error_resume	= dpc_error_resume,
 	.reset_link     = dpc_reset_link,
 };
 
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
