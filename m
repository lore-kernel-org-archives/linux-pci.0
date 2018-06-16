Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:35335 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932554AbeFPTdQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:33:16 -0400
Message-Id: <a85cfc8b6dc0a52e2f1d84e806e277adde9c1a5b.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 24/32] PCI: portdrv: Deduplicate PM callback iterator
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace suspend_iter() and resume_iter() with a single function pm_iter()
to allow addition of port service callbacks for further power management
phases without having to add another iterator each time.

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pcie/portdrv_core.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index e0261ad4bcdd..13a248575a14 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -353,14 +353,19 @@ int pcie_port_device_register(struct pci_dev *dev)
 }
 
 #ifdef CONFIG_PM
-static int suspend_iter(struct device *dev, void *data)
+typedef int (*pcie_pm_callback_t)(struct pcie_device *);
+
+static int pm_iter(struct device *dev, void *data)
 {
 	struct pcie_port_service_driver *service_driver;
+	size_t offset = *(size_t *)data;
+	pcie_pm_callback_t cb;
 
 	if ((dev->bus == &pcie_port_bus_type) && dev->driver) {
 		service_driver = to_service_driver(dev->driver);
-		if (service_driver->suspend)
-			service_driver->suspend(to_pcie_device(dev));
+		cb = *(pcie_pm_callback_t *)((void *)service_driver + offset);
+		if (cb)
+			return cb(to_pcie_device(dev));
 	}
 	return 0;
 }
@@ -371,20 +376,8 @@ static int suspend_iter(struct device *dev, void *data)
  */
 int pcie_port_device_suspend(struct device *dev)
 {
-	return device_for_each_child(dev, NULL, suspend_iter);
-}
-
-static int resume_iter(struct device *dev, void *data)
-{
-	struct pcie_port_service_driver *service_driver;
-
-	if ((dev->bus == &pcie_port_bus_type) &&
-	    (dev->driver)) {
-		service_driver = to_service_driver(dev->driver);
-		if (service_driver->resume)
-			service_driver->resume(to_pcie_device(dev));
-	}
-	return 0;
+	size_t off = offsetof(struct pcie_port_service_driver, suspend);
+	return device_for_each_child(dev, &off, pm_iter);
 }
 
 /**
@@ -393,7 +386,8 @@ static int resume_iter(struct device *dev, void *data)
  */
 int pcie_port_device_resume(struct device *dev)
 {
-	return device_for_each_child(dev, NULL, resume_iter);
+	size_t off = offsetof(struct pcie_port_service_driver, resume);
+	return device_for_each_child(dev, &off, pm_iter);
 }
 #endif /* PM */
 
-- 
2.17.1
