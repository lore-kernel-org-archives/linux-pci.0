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
Subject: [PATCH v17 6/9] PCI/portdrv: Add generic pcie_port_find_device()
Date: Thu, 17 May 2018 03:43:08 -0400
Message-Id: <1526542991-5291-7-git-send-email-poza@codeaurora.org>
In-Reply-To: <1526542991-5291-1-git-send-email-poza@codeaurora.org>
References: <1526542991-5291-1-git-send-email-poza@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

Add generic pcie_port_find_device() routine.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>
Reviewed-by: Keith Busch <keith.busch@intel.com>

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index ba6c963..896608a 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -114,4 +114,6 @@ static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
 
 struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
 							u32 service);
+struct device *pcie_port_find_device(struct pci_dev *dev,
+				     u32 service);
 #endif /* _PORTDRV_H_ */
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index e5bbf08..a5b3b3a 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -20,6 +20,7 @@
 #include "portdrv.h"
 struct portdrv_service_data {
 	struct pcie_port_service_driver *drv;
+	struct device *dev;
 	u32 service;
 };
 
@@ -415,6 +416,7 @@ static int find_service_iter(struct device *device, void *data)
 		service_driver = to_service_driver(device->driver);
 		if (service_driver->service == service) {
 			pdrvs->drv = service_driver;
+			pdrvs->dev = device;
 			return 1;
 		}
 	}
@@ -443,6 +445,27 @@ struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
 }
 
 /**
+ * pcie_port_find_device - find the struct device
+ * @dev: PCI Express port the service is associated with
+ * @service: For the service to find
+ *
+ * Find the struct device associated with given service on a pci_dev
+ */
+struct device *pcie_port_find_device(struct pci_dev *dev,
+				      u32 service)
+{
+	struct device *device;
+	struct portdrv_service_data pdrvs;
+
+	pdrvs.dev = NULL;
+	pdrvs.service = service;
+	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
+
+	device = pdrvs.dev;
+	return device;
+}
+
+/**
  * pcie_port_device_remove - unregister PCI Express port service devices
  * @dev: PCI Express port the service devices to unregister are associated with
  *
-- 
2.7.4
