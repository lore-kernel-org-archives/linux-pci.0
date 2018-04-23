Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:8437 "EHLO
        wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755596AbeDWPXQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Apr 2018 11:23:16 -0400
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
Subject: [PATCH v14 4/9] PCI/PORTDRV: Implement generic find device
Date: Mon, 23 Apr 2018 11:23:08 -0400
Message-Id: <1524496993-29799-5-git-send-email-poza@codeaurora.org>
In-Reply-To: <1524496993-29799-1-git-send-email-poza@codeaurora.org>
References: <1524496993-29799-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch implements generic pcie_port_find_device() routine.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 419bdf3..06f4e11d 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -81,4 +81,6 @@ static inline void pcie_port_platform_notify(struct pci_dev *port, int *mask){}
 
 struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
 							u32 service);
+struct device *pcie_port_find_device(struct pci_dev *dev,
+				     u32 service);
 #endif /* _PORTDRV_H_ */
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 94de1fa..dd13cc8 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -25,6 +25,7 @@ bool pciehp_msi_disabled;
 
 struct portdrv_service_data {
 	struct pcie_port_service_driver *drv;
+	struct device *dev;
 	u32 service;
 };
 
@@ -432,12 +433,14 @@ static int find_service_iter(struct device *device, void *data)
 		service_driver = to_service_driver(device->driver);
 		if (service_driver->service == service) {
 			pdrvs->drv = service_driver;
+			pdrvs->dev = device;
 			return 1;
 		}
 	}
 
 	return 0;
 }
+
 /**
  * pcie_port_find_service - find the service driver
  * @dev: PCI Express port the service devices associated with
@@ -460,6 +463,27 @@ struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
 }
 
 /**
+ * pcie_port_find_device - find the struct device
+ * @dev: PCI Express port the service devices associated with
+ * @service: For the service to find
+ *
+ * Find PCI Express port service driver associated with given service
+ */
+struct  device *pcie_port_find_device(struct pci_dev *dev,
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
