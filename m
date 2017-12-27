Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44316 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752036AbdL0KU4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Dec 2017 05:20:56 -0500
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH 4/4] PCI/DPC: Enumerate the devices after DPC trigger event
Date: Wed, 27 Dec 2017 15:50:22 +0530
Message-Id: <1514370022-4431-5-git-send-email-poza@codeaurora.org>
In-Reply-To: <1514370022-4431-1-git-send-email-poza@codeaurora.org>
References: <1514370022-4431-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Implement error_resume callback in DPC, which, after DPC trigger event
enumerates the devices beneath.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index e7ced58..78e557f 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -161,6 +161,43 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
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
@@ -419,6 +456,7 @@ static void dpc_remove(struct pcie_device *dev)
 	.service	= PCIE_PORT_SERVICE_DPC,
 	.probe		= dpc_probe,
 	.remove		= dpc_remove,
+	.error_resume	= dpc_error_resume,
 	.reset_link     = dpc_reset_link,
 };
 
diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
index 1f01e76..9c4377c 100644
--- a/drivers/pci/pcie/pcie-err.c
+++ b/drivers/pci/pcie/pcie-err.c
@@ -231,7 +231,8 @@ pci_ers_result_t pci_reset_link(struct pci_dev *dev, int severity)
 pci_ers_result_t pci_broadcast_error_message(struct pci_dev *dev,
 	enum pci_channel_state state,
 	char *error_mesg,
-	int (*cb)(struct pci_dev *, void *))
+	int (*cb)(struct pci_dev *, void *),
+	int severity)
 {
 	struct pci_err_broadcast_data result_data;
 
@@ -243,6 +244,15 @@ pci_ers_result_t pci_broadcast_error_message(struct pci_dev *dev,
 		result_data.result = PCI_ERS_RESULT_RECOVERED;
 
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		/* If DPC is triggered, call resume error hanlder
+		 * because, at this point we can safely assume that
+		 * link recovery has happened.
+		 */
+		if ((severity == PCI_ERR_DPC_FATAL) &&
+			(cb == pci_report_resume)) {
+			cb(dev, NULL);
+			return PCI_ERS_RESULT_RECOVERED;
+		}
 		/*
 		 * If the error is reported by a bridge, we think this error
 		 * is related to the downstream link of the bridge, so we
@@ -328,7 +338,8 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 	status = pci_broadcast_error_message(dev,
 			state,
 			"error_detected",
-			pci_report_error_detected);
+			pci_report_error_detected,
+			severity);
 
 	if ((severity == PCI_ERR_AER_FATAL) ||
 	    (severity == PCI_ERR_DPC_FATAL)) {
@@ -337,11 +348,15 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 			goto failed;
 	}
 
+	if (severity == PCI_ERR_DPC_FATAL)
+		goto resume;
+
 	if (status == PCI_ERS_RESULT_CAN_RECOVER)
 		status = pci_broadcast_error_message(dev,
 				state,
 				"mmio_enabled",
-				pci_report_mmio_enabled);
+				pci_report_mmio_enabled,
+				severity);
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
 		/*
@@ -352,16 +367,19 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 		status = pci_broadcast_error_message(dev,
 				state,
 				"slot_reset",
-				pci_report_slot_reset);
+				pci_report_slot_reset,
+				severity);
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED)
 		goto failed;
 
+resume:
 	pci_broadcast_error_message(dev,
 				state,
 				"resume",
-				pci_report_resume);
+				pci_report_resume,
+				severity);
 
 	dev_info(&dev->dev, "Device recovery successful\n");
 	mutex_unlock(&pci_err_recovery_lock);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 123ee15..46e2526 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2010,7 +2010,8 @@ static inline resource_size_t pci_iov_resource_size(struct pci_dev *dev, int res
 pci_ers_result_t pci_broadcast_error_message(struct pci_dev *dev,
 					enum pci_channel_state state,
 					char *error_mesg,
-					int (*cb)(struct pci_dev *, void *));
+					int (*cb)(struct pci_dev *, void *),
+					int severity);
 int pci_report_mmio_enabled(struct pci_dev *dev, void *data);
 int pci_report_slot_reset(struct pci_dev *dev, void *data);
 int pci_report_resume(struct pci_dev *dev, void *data);
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
