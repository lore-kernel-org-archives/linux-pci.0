Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60926 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbdKIUrV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Nov 2017 15:47:21 -0500
From: Pawandeep Oza <poza@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH 3/4] PCI/portdrv: Implement interface to query the registered service
Date: Fri, 10 Nov 2017 02:16:38 +0530
Message-Id: <1510260399-14886-4-git-send-email-poza@codeaurora.org>
In-Reply-To: <1510260399-14886-1-git-send-email-poza@codeaurora.org>
References: <1510260399-14886-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Oza Pawandeep <poza@codeaurora.org>

This patch implements query service interface. So that, any port service
driver can query to know, if the service is active or not.

When multiple service drivers try to take actions, these service drivers
could race or could have conflict of interest.

For e.g. when DPC is enabled, AER should not attempt recovery.

The interface walks up the parent till root bridge, and if any of the
downstream port has DPC service active, it stops there, since DPC will be
removing all the devices beneath.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 6bfe986..63fa57a 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -490,6 +490,30 @@ static int pcie_port_remove_service(struct device *dev)
 }
 
 /**
+ * pcie_port_service_query - query if particula port service is enabled.
+ * dev: pcie device
+ * @port service: PCI express port service
+ */
+int pcie_port_query_service(struct pci_dev *dev, u32 port_service)
+{
+	struct pcie_device *pdev;
+	struct pci_dev *parent, *this = dev;
+
+	do {
+		list_for_each_entry(pdev, &this->service_list, slist) {
+			if (pdev->service == port_service)
+				return 1;
+		}
+		parent = pci_upstream_bridge(this);
+		this = parent;
+	} while (parent && pci_is_pcie(parent));
+
+	return 0;
+}
+EXPORT_SYMBOL(pcie_port_query_service);
+
+
+/**
  * pcie_port_shutdown_service - shut down given PCI Express port service
  * @dev: PCI Express port service device to handle
  *
diff --git a/include/linux/pcieport_if.h b/include/linux/pcieport_if.h
index 9d05621..bb8febb 100644
--- a/include/linux/pcieport_if.h
+++ b/include/linux/pcieport_if.h
@@ -68,5 +68,5 @@ struct pcie_port_service_driver {
 
 int pcie_port_service_register(struct pcie_port_service_driver *new);
 void pcie_port_service_unregister(struct pcie_port_service_driver *new);
-
+int pcie_port_query_service(struct pci_dev *dev, u32 port_service);
 #endif /* _PCIEPORT_IF_H_ */
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
