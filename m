Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Oza Pawandeep <poza@codeaurora.org>
To: linux-pci@vger.kernel.org,
	okaya@codeaurora.org,
	timur@codeaurora.org
Subject: [PATCH v2 3/4] PCI/portdrv: Implement interface to query the
 registered service
Date: Wed, 15 Nov 2017 10:26:47 +0530
Message-Id: <1510721808-27164-4-git-send-email-poza@codeaurora.org>
In-Reply-To: <1510721808-27164-1-git-send-email-poza@codeaurora.org>
References: <1510721808-27164-1-git-send-email-poza@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Oza Pawandeep <poza@codeaurora.org>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dongdong Liu <liudongdong3@huawei.com>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This patch implements query service interface. So that, any port service
driver can query to know, if the service is active or not.

When multiple service drivers try to take actions, these service drivers
could race or could have conflict of interest.

For e.g. when DPC is enabled, AER should not attempt recovery.

The other interface walks up the parent till root bridge, so that on each
pci_dev service can be queried.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 6bfe986..c7681d9 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -490,6 +490,40 @@ static int pcie_port_remove_service(struct device *dev)
 }
 
 /**
+ * pcie_port_query_service - query the associated port service.
+ * dev: pcie device
+ * @port service: PCI express port service
+ */
+bool pcie_port_query_service(struct pci_dev *dev, u32 port_service)
+{
+	struct pcie_device *pdev;
+
+	list_for_each_entry(pdev, &dev->service_list, slist) {
+		if (pdev->service == port_service)
+			return true;
+	}
+	return false;
+}
+EXPORT_SYMBOL(pcie_port_query_service);
+
+/**
+ * pcie_port_upstream_bridge - returns immediate upstream bridge.
+ * dev: pcie device
+ */
+struct pci_dev *pcie_port_upstream_bridge(struct pci_dev *dev)
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
+EXPORT_SYMBOL(pcie_port_upstream_bridge);
+
+/**
  * pcie_port_shutdown_service - shut down given PCI Express port service
  * @dev: PCI Express port service device to handle
  *
diff --git a/include/linux/pcieport_if.h b/include/linux/pcieport_if.h
index 9d05621..8322443 100644
--- a/include/linux/pcieport_if.h
+++ b/include/linux/pcieport_if.h
@@ -68,5 +68,6 @@ struct pcie_port_service_driver {
 
 int pcie_port_service_register(struct pcie_port_service_driver *new);
 void pcie_port_service_unregister(struct pcie_port_service_driver *new);
-
+bool pcie_port_query_service(struct pci_dev *dev, u32 port_service);
+struct pci_dev *pcie_port_upstream_bridge(struct pci_dev *dev);
 #endif /* _PCIEPORT_IF_H_ */
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
