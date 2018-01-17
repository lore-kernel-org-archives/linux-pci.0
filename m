Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50990 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752626AbeAQKhu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jan 2018 05:37:50 -0500
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
Subject: [PATCH v5 4/4] PCI/DPC: Enumerate the devices after DPC trigger event
Date: Wed, 17 Jan 2018 16:07:18 +0530
Message-Id: <1516185438-31556-5-git-send-email-poza@codeaurora.org>
In-Reply-To: <1516185438-31556-1-git-send-email-poza@codeaurora.org>
References: <1516185438-31556-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Implement error_resume callback in DPC so, after DPC trigger event
enumerates the devices beneath.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index ed916765..f99adcae 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -162,6 +162,43 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
 		dev_warn(dev, "Link state not disabled for DPC event\n");
 }
 
+static bool dpc_wait_link_active(struct pci_dev *pdev)
+{
+	unsigned long timeout = jiffies + HZ;
+	u16 lnk_status;
+	bool ret = true;
+
+	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
+
+	while (!(lnk_status & PCI_EXP_LNKSTA_DLLLA) &&
+					!time_after(jiffies, timeout)) {
+		msleep(10);
+		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
+	}
+
+	if (!(lnk_status & PCI_EXP_LNKSTA_DLLLA)) {
+		dev_warn(&pdev->dev, "Link state not enabled after DPC event\n");
+		ret = false;
+	}
+
+	return ret;
+}
+
+/**
+ * dpc_error_resume - enumerate the devices beneath
+ * @dev: pointer to Root Port's pci_dev data structure
+ *
+ * Invoked by Port Bus driver during nonfatal recovery.
+ */
+static void dpc_error_resume(struct pci_dev *pdev)
+{
+	if (dpc_wait_link_active(pdev)) {
+		pci_lock_rescan_remove();
+		pci_rescan_bus(pdev->bus);
+		pci_unlock_rescan_remove();
+	}
+}
+
 /**
  * dpc_reset_link - reset link DPC  routine
  * @dev: pointer to Root Port's pci_dev data structure
@@ -420,6 +457,7 @@ static void dpc_remove(struct pcie_device *dev)
 	.service	= PCIE_PORT_SERVICE_DPC,
 	.probe		= dpc_probe,
 	.remove		= dpc_remove,
+	.error_resume	= dpc_error_resume,
 	.reset_link     = dpc_reset_link,
 };
 
diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
index 8ce1de1..de72b0a 100644
--- a/drivers/pci/pcie/pcie-err.c
+++ b/drivers/pci/pcie/pcie-err.c
@@ -236,6 +236,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev, int severity)
  * @state: error state
  * @error_mesg: message to print
  * @cb: callback to be broadcasted
+ * @severity: error severity
  *
  * Invoked during error recovery process. Once being invoked, the content
  * of error severity will be broadcasted to all downstream drivers in a
@@ -244,7 +245,8 @@ static pci_ers_result_t reset_link(struct pci_dev *dev, int severity)
 static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 	enum pci_channel_state state,
 	char *error_mesg,
-	int (*cb)(struct pci_dev *, void *))
+	int (*cb)(struct pci_dev *, void *),
+	int severity)
 {
 	struct aer_broadcast_data result_data;
 
@@ -256,6 +258,15 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 		result_data.result = PCI_ERS_RESULT_RECOVERED;
 
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		/* If DPC is triggered, call resume error hanlder
+		 * because, at this point we can safely assume that
+		 * link recovery has happened.
+		 */
+		if ((severity == DPC_FATAL) &&
+			(cb == report_resume)) {
+			cb(dev, NULL);
+			return PCI_ERS_RESULT_RECOVERED;
+		}
 		/*
 		 * If the error is reported by a bridge, we think this error
 		 * is related to the downstream link of the bridge, so we
@@ -305,7 +316,8 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 	status = broadcast_error_message(dev,
 			state,
 			"error_detected",
-			report_error_detected);
+			report_error_detected,
+			severity);
 
 	if ((severity == AER_FATAL) ||
 	    (severity == DPC_FATAL)) {
@@ -318,7 +330,8 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 		status = broadcast_error_message(dev,
 				state,
 				"mmio_enabled",
-				report_mmio_enabled);
+				report_mmio_enabled,
+				severity);
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
 		/*
@@ -329,7 +342,8 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 		status = broadcast_error_message(dev,
 				state,
 				"slot_reset",
-				report_slot_reset);
+				report_slot_reset,
+				severity);
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED)
@@ -338,7 +352,8 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
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
