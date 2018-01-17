Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Subject: [PATCH v5 3/4] PCI/DPC: Unify and plumb error handling into DPC
Date: Wed, 17 Jan 2018 16:07:17 +0530
Message-Id: <1516185438-31556-4-git-send-email-poza@codeaurora.org>
In-Reply-To: <1516185438-31556-1-git-send-email-poza@codeaurora.org>
References: <1516185438-31556-1-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current DPC driver does not do recovery, e.g. calling end-point's driver's
callbacks, which sanitize the sw.

DPC driver implements link_reset callback, and calls pci_do_recovery.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 2d976a6..ed916765 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -13,8 +13,12 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/dpc.h>
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
+	pci_do_recovery(pdev, DPC_FATAL);
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
index a532fe0..8ce1de1 100644
--- a/drivers/pci/pcie/pcie-err.c
+++ b/drivers/pci/pcie/pcie-err.c
@@ -17,9 +17,12 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/aer.h>
+#include <linux/dpc.h>
 #include <linux/pcieport_if.h>
 #include "portdrv.h"
 
+static DEFINE_MUTEX(pci_err_recovery_lock);
+
 struct aer_broadcast_data {
 	enum pci_channel_state state;
 	enum pci_ers_result result;
@@ -179,7 +182,7 @@ static pci_ers_result_t default_reset_link(struct pci_dev *dev)
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-static pci_ers_result_t reset_link(struct pci_dev *dev)
+static pci_ers_result_t reset_link(struct pci_dev *dev, int severity)
 {
 	struct pci_dev *udev;
 	pci_ers_result_t status;
@@ -193,9 +196,17 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
 		udev = dev->bus->self;
 	}
 
+
+	/* Use the service driver of the component firstly */
+#if IS_ENABLED(CONFIG_PCIE_DPC)
+	if (severity == DPC_FATAL)
+		driver = pci_find_dpc_service(udev);
+#endif
 #if IS_ENABLED(CONFIG_PCIEAER)
-	/* Use the aer driver of the component firstly */
-	driver = pci_find_aer_service(udev);
+	if ((severity == AER_FATAL) ||
+	    (severity == AER_NONFATAL) ||
+	    (severity == AER_CORRECTABLE))
+		driver = pci_find_aer_service(udev);
 #endif
 
 	if (driver && driver->reset_link) {
@@ -283,7 +294,10 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
 	enum pci_channel_state state;
 
-	if (severity == AER_FATAL)
+	mutex_lock(&pci_err_recovery_lock);
+
+	if ((severity == AER_FATAL) ||
+	    (severity == DPC_FATAL))
 		state = pci_channel_io_frozen;
 	else
 		state = pci_channel_io_normal;
@@ -293,8 +307,9 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 			"error_detected",
 			report_error_detected);
 
-	if (severity == AER_FATAL) {
-		result = reset_link(dev);
+	if ((severity == AER_FATAL) ||
+	    (severity == DPC_FATAL)) {
+		result = reset_link(dev, severity);
 		if (result != PCI_ERS_RESULT_RECOVERED)
 			goto failed;
 	}
@@ -326,9 +341,11 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 				report_resume);
 
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
diff --git a/include/linux/dpc.h b/include/linux/dpc.h
new file mode 100644
index 0000000..2019ce4
--- /dev/null
+++ b/include/linux/dpc.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _DPC_H_
+#define _DPC_H_
+
+#define DPC_FATAL		4
+
+#endif //_DPC_H_
+
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
