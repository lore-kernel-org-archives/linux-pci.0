Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57542 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbeAPJ7M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jan 2018 04:59:12 -0500
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
Subject: [PATCH v4 4/5] PCI/DPC: Unify and plumb error handling into DPC
Date: Tue, 16 Jan 2018 15:28:42 +0530
Message-Id: <1516096723-8013-5-git-send-email-poza@codeaurora.org>
In-Reply-To: <1516096723-8013-1-git-send-email-poza@codeaurora.org>
References: <1516096723-8013-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current DPC driver does not do recovery, e.g. calling end-point's driver's
callbacks, which sanitize the sw.

DPC driver implements link_reset callback, and calls pci_do_recovery.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 2d976a6..31799f6 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -13,8 +13,12 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/pci_err.h>
 #include <linux/pcieport_if.h>
 #include "../pci.h"
+#include "portdrv.h"
+
+static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
 
 struct rp_pio_header_log_regs {
 	u32 dw0;
@@ -67,6 +71,60 @@ struct dpc_dev {
 	"Memory Request Completion Timeout",		 /* Bit Position 18 */
 };
 
+static int find_dpc_dev_iter(struct device *device, void *data)
+{
+	struct pcie_port_service_driver *service_driver;
+	struct device **dev;
+
+	dev = (struct device **) data;
+
+	if (device->bus == &pcie_port_bus_type && device->driver) {
+		service_driver = to_service_driver(device->driver);
+		if (service_driver->service == PCIE_PORT_SERVICE_DPC) {
+			*dev = device;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static struct device *pci_find_dpc_dev(struct pci_dev *pdev)
+{
+	struct device *dev = NULL;
+
+	device_for_each_child(&pdev->dev, &dev, find_dpc_dev_iter);
+
+	return dev;
+}
+
+static int find_dpc_service_iter(struct device *device, void *data)
+{
+	struct pcie_port_service_driver *service_driver, **drv;
+
+	drv = (struct pcie_port_service_driver **) data;
+
+	if (device->bus == &pcie_port_bus_type && device->driver) {
+		service_driver = to_service_driver(device->driver);
+		if (service_driver->service == PCIE_PORT_SERVICE_DPC) {
+			*drv = service_driver;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+struct pcie_port_service_driver *pci_find_dpc_service(struct pci_dev *dev)
+{
+	struct pcie_port_service_driver *drv = NULL;
+
+	device_for_each_child(&dev->dev, &drv, find_dpc_service_iter);
+
+	return drv;
+}
+EXPORT_SYMBOL(pci_find_dpc_service);
+
 static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
 {
 	unsigned long timeout = jiffies + HZ;
@@ -104,11 +162,23 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
 		dev_warn(dev, "Link state not disabled for DPC event\n");
 }
 
-static void interrupt_event_handler(struct work_struct *work)
+/**
+ * dpc_reset_link - reset link DPC  routine
+ * @dev: pointer to Root Port's pci_dev data structure
+ *
+ * Invoked by Port Bus driver when performing link reset at Root Port.
+ */
+static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 {
-	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
-	struct pci_dev *dev, *temp, *pdev = dpc->dev->port;
 	struct pci_bus *parent = pdev->subordinate;
+	struct pci_dev *dev, *temp;
+	struct dpc_dev *dpc;
+	struct pcie_device *pciedev;
+	struct device *devdpc;
+
+	devdpc = pci_find_dpc_dev(pdev);
+	pciedev = to_pcie_device(devdpc);
+	dpc = get_service_data(pciedev);
 
 	pci_lock_rescan_remove();
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
@@ -125,7 +195,7 @@ static void interrupt_event_handler(struct work_struct *work)
 
 	dpc_wait_link_inactive(dpc);
 	if (dpc->rp && dpc_wait_rp_inactive(dpc))
-		return;
+		return PCI_ERS_RESULT_DISCONNECT;
 	if (dpc->rp && dpc->rp_pio_status) {
 		pci_write_config_dword(pdev,
 				      dpc->cap_pos + PCI_EXP_DPC_RP_PIO_STATUS,
@@ -135,6 +205,17 @@ static void interrupt_event_handler(struct work_struct *work)
 
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS,
 		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static void interrupt_event_handler(struct work_struct *work)
+{
+	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
+	struct pci_dev *pdev = dpc->dev->port;
+
+	/* From DPC point of view error is always FATAL. */
+	pci_do_recovery(pdev, PCI_ERR_DPC_FATAL);
 }
 
 static void dpc_rp_pio_print_tlp_header(struct device *dev,
@@ -339,6 +420,7 @@ static void dpc_remove(struct pcie_device *dev)
 	.service	= PCIE_PORT_SERVICE_DPC,
 	.probe		= dpc_probe,
 	.remove		= dpc_remove,
+	.reset_link     = dpc_reset_link,
 };
 
 static int __init dpc_service_init(void)
diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
index 63566b1..14b9153 100644
--- a/drivers/pci/pcie/pcie-err.c
+++ b/drivers/pci/pcie/pcie-err.c
@@ -21,6 +21,8 @@
 #include <linux/pcieport_if.h>
 #include "portdrv.h"
 
+static DEFINE_MUTEX(pci_err_recovery_lock);
+
 struct pci_err_broadcast_data {
 	enum pci_channel_state state;
 	enum pci_ers_result result;
@@ -180,7 +182,7 @@ static pci_ers_result_t pci_default_reset_link(struct pci_dev *dev)
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-pci_ers_result_t pci_reset_link(struct pci_dev *dev)
+pci_ers_result_t pci_reset_link(struct pci_dev *dev, int severity)
 {
 	struct pci_dev *udev;
 	pci_ers_result_t status;
@@ -194,9 +196,17 @@ pci_ers_result_t pci_reset_link(struct pci_dev *dev)
 		udev = dev->bus->self;
 	}
 
+
+	/* Use the service driver of the component firstly */
+#if IS_ENABLED(CONFIG_PCIE_DPC)
+	if (severity == PCI_ERR_DPC_FATAL)
+		driver = pci_find_dpc_service(udev);
+#endif
 #if IS_ENABLED(CONFIG_PCIEAER)
-	/* Use the aer driver of the component firstly */
-	driver = pci_find_aer_service(udev);
+	if ((severity == PCI_ERR_AER_FATAL) ||
+	    (severity == PCI_ERR_AER_NONFATAL) ||
+	    (severity == PCI_ERR_AER_CORRECTABLE))
+		driver = pci_find_aer_service(udev);
 #endif
 
 	if (driver && driver->reset_link) {
@@ -284,7 +294,10 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
 	enum pci_channel_state state;
 
-	if (severity == PCI_ERR_AER_FATAL)
+	mutex_lock(&pci_err_recovery_lock);
+
+	if ((severity == PCI_ERR_AER_FATAL) ||
+	    (severity == PCI_ERR_DPC_FATAL))
 		state = pci_channel_io_frozen;
 	else
 		state = pci_channel_io_normal;
@@ -294,8 +307,9 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 			"error_detected",
 			pci_report_error_detected);
 
-	if (severity == PCI_ERR_AER_FATAL) {
-		result = pci_reset_link(dev);
+	if ((severity == PCI_ERR_AER_FATAL) ||
+	    (severity == PCI_ERR_DPC_FATAL)) {
+		result = pci_reset_link(dev, severity);
 		if (result != PCI_ERS_RESULT_RECOVERED)
 			goto failed;
 	}
@@ -327,9 +341,11 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 				pci_report_resume);
 
 	dev_info(&dev->dev, "Device recovery successful\n");
+	mutex_unlock(&pci_err_recovery_lock);
 	return;
 
 failed:
 	/* TODO: Should kernel panic here? */
+	mutex_unlock(&pci_err_recovery_lock);
 	dev_info(&dev->dev, "Device recovery failed\n");
 }
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 4f1992d..b013e24 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -80,4 +80,5 @@ static inline void pcie_port_platform_notify(struct pci_dev *port, int *mask){}
 #endif /* !CONFIG_ACPI */
 
 struct pcie_port_service_driver *pci_find_aer_service(struct pci_dev *dev);
+struct pcie_port_service_driver *pci_find_dpc_service(struct pci_dev *dev);
 #endif /* _PORTDRV_H_ */
diff --git a/include/linux/pci_err.h b/include/linux/pci_err.h
index 3710759..e253126 100644
--- a/include/linux/pci_err.h
+++ b/include/linux/pci_err.h
@@ -7,5 +7,7 @@
 #define PCI_ERR_AER_FATAL		1
 #define PCI_ERR_AER_CORRECTABLE		2
 
+#define PCI_ERR_DPC_FATAL		4
+
 void pci_do_recovery(struct pci_dev *dev, int severity);
 #endif /* _PCI_ERR_H_ */
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
