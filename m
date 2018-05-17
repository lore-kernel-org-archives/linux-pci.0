Return-Path: <SRS0=92Ow=IE=qualcomm.com=poza@kernel.org>
Return-Path: <SRS0=92Ow=IE=qualcomm.com=poza@kernel.org>
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>,
	Keith Busch <keith.busch@intel.com>,
	Wei Zhang <wzhang@fb.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v17 5/9] PCI/portdrv: Add generic pcie_port_find_service()
Date: Thu, 17 May 2018 03:43:07 -0400
Message-Id: <1526542991-5291-6-git-send-email-poza@codeaurora.org>
In-Reply-To: <1526542991-5291-1-git-send-email-poza@codeaurora.org>
References: <1526542991-5291-1-git-send-email-poza@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

Add generic pcie_port_find_service() routine.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>
Reviewed-by: Keith Busch <keith.busch@intel.com>

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 4fa1ee4..fdfc474 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -228,32 +228,6 @@ static bool find_source_device(struct pci_dev *parent,
 	return true;
 }
 
-static int find_aer_service_iter(struct device *device, void *data)
-{
-	struct pcie_port_service_driver *service_driver, **drv;
-
-	drv = (struct pcie_port_service_driver **) data;
-
-	if (device->bus == &pcie_port_bus_type && device->driver) {
-		service_driver = to_service_driver(device->driver);
-		if (service_driver->service == PCIE_PORT_SERVICE_AER) {
-			*drv = service_driver;
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
-struct pcie_port_service_driver *find_aer_service(struct pci_dev *dev)
-{
-	struct pcie_port_service_driver *drv = NULL;
-
-	device_for_each_child(&dev->dev, &drv, find_aer_service_iter);
-
-	return drv;
-}
-
 /**
  * handle_error_source - handle logging error into an event log
  * @aerdev: pointer to pcie_device data structure of the root port
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 307120b..a1668e9 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -194,10 +194,8 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
 		udev = dev->bus->self;
 	}
 
-#if IS_ENABLED(CONFIG_PCIEAER)
 	/* Use the aer driver of the component firstly */
-	driver = find_aer_service(udev);
-#endif
+	driver = pcie_port_find_service(udev, PCIE_PORT_SERVICE_AER);
 
 	if (driver && driver->reset_link) {
 		status = driver->reset_link(udev);
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 47c9824..ba6c963 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -112,5 +112,6 @@ static inline bool pcie_pme_no_msi(void) { return false; }
 static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
 #endif /* !CONFIG_PCIE_PME */
 
-struct pcie_port_service_driver *find_aer_service(struct pci_dev *dev);
+struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
+							u32 service);
 #endif /* _PORTDRV_H_ */
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index c9c0663..e5bbf08 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -18,6 +18,10 @@
 
 #include "../pci.h"
 #include "portdrv.h"
+struct portdrv_service_data {
+	struct pcie_port_service_driver *drv;
+	u32 service;
+};
 
 /**
  * release_pcie_device - free PCI Express port service device structure
@@ -398,6 +402,46 @@ static int remove_iter(struct device *dev, void *data)
 	return 0;
 }
 
+static int find_service_iter(struct device *device, void *data)
+{
+	struct pcie_port_service_driver *service_driver;
+	struct portdrv_service_data *pdrvs;
+	u32 service;
+
+	pdrvs = (struct portdrv_service_data *) data;
+	service = pdrvs->service;
+
+	if (device->bus == &pcie_port_bus_type && device->driver) {
+		service_driver = to_service_driver(device->driver);
+		if (service_driver->service == service) {
+			pdrvs->drv = service_driver;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+/**
+ * pcie_port_find_service - find the service driver
+ * @dev: PCI Express port the service is associated with
+ * @service: Service to find
+ *
+ * Find PCI Express port service driver associated with given service
+ */
+struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
+							u32 service)
+{
+	struct pcie_port_service_driver *drv;
+	struct portdrv_service_data pdrvs;
+
+	pdrvs.drv = NULL;
+	pdrvs.service = service;
+	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
+
+	drv = pdrvs.drv;
+	return drv;
+}
+
 /**
  * pcie_port_device_remove - unregister PCI Express port service devices
  * @dev: PCI Express port the service devices to unregister are associated with
-- 
2.7.4
