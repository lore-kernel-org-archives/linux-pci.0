Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Subject: [PATCH v2 3/4] PCI/ERR: Do not do recovery if DPC service is active
Date: Fri, 29 Dec 2017 12:54:18 +0530
Message-Id: <1514532259-19383-4-git-send-email-poza@codeaurora.org>
In-Reply-To: <1514532259-19383-1-git-send-email-poza@codeaurora.org>
References: <1514532259-19383-1-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If AER attempts to do recovery for any device, and DPC is active on
any upstream port, AER should not do recovery, since it will be handled
by DPC

Change-Id: Ida507ce9145f420e35302db34e967f1b421e15c9
Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
index 858c94c..1991cc8 100644
--- a/drivers/pci/pcie/pcie-err.c
+++ b/drivers/pci/pcie/pcie-err.c
@@ -274,6 +274,22 @@ pci_ers_result_t pci_broadcast_error_message(struct pci_dev *dev,
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
@@ -287,9 +303,29 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
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
