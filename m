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
Subject: [PATCH v11 4/7] PCI/DPC: Unify and plumb error handling into DPC
Date: Fri, 23 Feb 2018 13:54:01 +0530
Message-Id: <1519374244-20539-5-git-send-email-poza@codeaurora.org>
In-Reply-To: <1519374244-20539-1-git-send-email-poza@codeaurora.org>
References: <1519374244-20539-1-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current DPC driver does not do recovery, e.g. calling end-point's driver's
callbacks, which sanitize the sw.

DPC driver implements link_reset callback, and calls pcie_do_recovery.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index abc514e..f8575da 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -343,6 +343,8 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 void pci_enable_acs(struct pci_dev *dev);
 
 /* PCI error reporting and recovery */
+#define DPC_FATAL	4
+
 void pcie_do_recovery(struct pci_dev *dev, int severity);
 
 #ifdef CONFIG_PCIEASPM
diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 38e40c6..5c01c63 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -13,6 +13,7 @@
 #include <linux/pcieport_if.h>
 #include "../pci.h"
 #include "aer/aerdrv.h"
+#include "portdrv.h"
 
 struct dpc_dev {
 	struct pcie_device	*dev;
@@ -45,6 +46,58 @@ struct dpc_dev {
 	"Memory Request Completion Timeout",		 /* Bit Position 18 */
 };
 
+static int find_dpc_dev_iter(struct device *device, void *data)
+{
+	struct pcie_port_service_driver *service_driver;
+	struct device **dev = (struct device **) data;;
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
+	struct pcie_port_service_driver *service_driver;
+	struct pcie_port_service_driver **drv =
+		(struct pcie_port_service_driver **) data;
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
+EXPORT_SYMBOL_GPL(pci_find_dpc_service);
+
 static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
 {
 	unsigned long timeout = jiffies + HZ;
@@ -82,12 +135,25 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
 		dev_warn(dev, "Link state not disabled for DPC event\n");
 }
 
-static void dpc_work(struct work_struct *work)
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
-	u16 cap = dpc->cap_pos, ctl;
+	struct pci_dev *dev, *temp;
+	struct dpc_dev *dpc;
+	struct pcie_device *pciedev;
+	struct device *devdpc;
+	u16 cap, ctl;
+
+	devdpc = pci_find_dpc_dev(pdev);
+	pciedev = to_pcie_device(devdpc);
+	dpc = get_service_data(pciedev);
+	cap = dpc->cap_pos;
 
 	pci_lock_rescan_remove();
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
@@ -104,21 +170,31 @@ static void dpc_work(struct work_struct *work)
 
 	dpc_wait_link_inactive(dpc);
 	if (dpc->rp_extensions && dpc_wait_rp_inactive(dpc))
-		return;
+		return PCI_ERS_RESULT_DISCONNECT;
 	if (dpc->rp_extensions && dpc->rp_pio_status) {
 		pci_write_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS,
 				       dpc->rp_pio_status);
 		dpc->rp_pio_status = 0;
 	}
 
-	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
+	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS,
 		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_CTL, &ctl);
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_CTL,
-			      ctl | PCI_EXP_DPC_CTL_INT_EN);
+				ctl | PCI_EXP_DPC_CTL_INT_EN);
+
+	return PCI_ERS_RESULT_RECOVERED;
 }
 
+static void dpc_work(struct work_struct *work)
+{
+	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
+	struct pci_dev *pdev = dpc->dev->port;
+
+	/* From DPC point of view error is always FATAL. */
+	pcie_do_recovery(pdev, DPC_FATAL);
+}
 static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 {
 	struct device *dev = &dpc->dev->device;
@@ -297,6 +373,7 @@ static void dpc_remove(struct pcie_device *dev)
 	.service	= PCIE_PORT_SERVICE_DPC,
 	.probe		= dpc_probe,
 	.remove		= dpc_remove,
+	.reset_link     = dpc_reset_link,
 };
 
 static int __init dpc_service_init(void)
diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
index f830975..1ea4b9a 100644
--- a/drivers/pci/pcie/pcie-err.c
+++ b/drivers/pci/pcie/pcie-err.c
@@ -19,6 +19,7 @@
 #include <linux/aer.h>
 #include <linux/pcieport_if.h>
 #include "portdrv.h"
+#include "./../pci.h"
 
 static DEFINE_MUTEX(pci_err_recovery_lock);
 
@@ -181,7 +182,7 @@ static pci_ers_result_t default_reset_link(struct pci_dev *dev)
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-static pci_ers_result_t reset_link(struct pci_dev *dev)
+static pci_ers_result_t reset_link(struct pci_dev *dev, int severity)
 {
 	struct pci_dev *udev;
 	pci_ers_result_t status;
@@ -195,9 +196,17 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
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
+	if (severity == AER_FATAL ||
+	    severity == AER_NONFATAL ||
+	    severity == AER_CORRECTABLE)
+		driver = pci_find_aer_service(udev);
 #endif
 
 	if (driver && driver->reset_link) {
@@ -287,7 +296,8 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
 
 	mutex_lock(&pci_err_recovery_lock);
 
-	if (severity == AER_FATAL)
+	if (severity == AER_FATAL ||
+	    severity == DPC_FATAL)
 		state = pci_channel_io_frozen;
 	else
 		state = pci_channel_io_normal;
@@ -297,10 +307,14 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
 			"error_detected",
 			report_error_detected);
 
-	if (severity == AER_FATAL) {
-		result = reset_link(dev);
+	if (severity == AER_FATAL ||
+	    severity == DPC_FATAL) {
+		result = reset_link(dev, severity);
 		if (result != PCI_ERS_RESULT_RECOVERED)
 			goto failed;
+		else if (severity == DPC_FATAL)
+			goto resume;
+
 	}
 
 	if (status == PCI_ERS_RESULT_CAN_RECOVER)
@@ -324,6 +338,7 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
 	if (status != PCI_ERS_RESULT_RECOVERED)
 		goto failed;
 
+resume:
 	broadcast_error_message(dev,
 				state,
 				"resume",
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 4f1992d..b013e24 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -80,4 +80,5 @@ static inline void pcie_port_platform_notify(struct pci_dev *port, int *mask){}
 #endif /* !CONFIG_ACPI */
 
 struct pcie_port_service_driver *pci_find_aer_service(struct pci_dev *dev);
+struct pcie_port_service_driver *pci_find_dpc_service(struct pci_dev *dev);
 #endif /* _PORTDRV_H_ */
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
