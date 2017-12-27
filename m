Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44148 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbdL0KUw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Dec 2017 05:20:52 -0500
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
Subject: [PATCH 3/4] PCI/ERR: Do not do recovery if DPC service is active
Date: Wed, 27 Dec 2017 15:50:21 +0530
Message-Id: <1514370022-4431-4-git-send-email-poza@codeaurora.org>
In-Reply-To: <1514370022-4431-1-git-send-email-poza@codeaurora.org>
References: <1514370022-4431-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If AER attempts to do recovery for any device, and DPC is active on
any upstream port, AER should not do recovery, since it will be handled
by DPC

Change-Id: Ida507ce9145f420e35302db34e967f1b421e15c9
Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
index 8bac584..1f01e76 100644
--- a/drivers/pci/pcie/pcie-err.c
+++ b/drivers/pci/pcie/pcie-err.c
@@ -267,6 +267,22 @@ pci_ers_result_t pci_broadcast_error_message(struct pci_dev *dev,
 	return result_data.result;
 }
 
+/*
+ * pcie_port_upstream_bridge - returns immediate upstream bridge.
+ * dev: pcie device
+ */
+static struct pci_dev *pcie_port_upstream_bridge(struct pci_dev *dev)
+{
+	struct pci_dev *parent;
+
+	parent = pci_upstream_bridge(dev);
+
+	if (parent && pci_is_pcie(parent))
+		return parent;
+
+	return NULL;
+}
+
 /**
  * pci_do_recovery - handle nonfatal/fatal error recovery process
  * @dev: pointer to a pci_dev data structure of agent detecting an error
@@ -280,9 +296,29 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 {
 	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
 	enum pci_channel_state state;
+	struct pcie_port_service_driver *driver;
+	struct pci_dev *pdev = dev;
 
 	mutex_lock(&pci_err_recovery_lock);
 
+	if (severity != PCI_ERR_DPC_FATAL) {
+		/*
+		 * DPC service could be running in RP
+		 * or any upstream switch.
+		 */
+		do {
+			driver = pci_find_dpc_service(pdev);
+			if (driver) {
+				dev_printk(KERN_NOTICE, &dev->dev,
+				"AER: Recovery to be done by DPC %s\n",
+				pci_name(dev));
+				mutex_unlock(&pci_err_recovery_lock);
+				return;
+			}
+		pdev = pcie_port_upstream_bridge(dev);
+		} while (pdev);
+	}
+
 	if ((severity == PCI_ERR_AER_FATAL) ||
 	    (severity == PCI_ERR_DPC_FATAL))
 		state = pci_channel_io_frozen;
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
