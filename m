Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44650 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754382AbeGCJAZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jul 2018 05:00:25 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: endpoint: Fix NULL pointer dereference error when CONFIGFS is disabled
Date: Tue, 3 Jul 2018 14:30:17 +0530
Message-ID: <20180703090017.22734-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

commit ef1433f717a2c63747a519d86965d73 ("PCI: endpoint: Create configfs
entry for each pci_epf_device_id table entry") while adding configfs
entry for each pci_epf_device_id table entry introduced a NULL pointer
dereference error when CONFIG_PCI_ENDPOINT_CONFIGFS is not enabled.
Fix it here.

Fixes: ef1433f717a2c63747a519d86965d73 ("PCI: endpoint: Create configfs
entry for each pci_epf_device_id table entry")

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 62 ++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 523a8cab3bfb..7fe1930d6589 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -137,25 +137,60 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar)
 }
 EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
 
-/**
- * pci_epf_unregister_driver() - unregister the PCI EPF driver
- * @driver: the PCI EPF driver that has to be unregistered
- *
- * Invoke to unregister the PCI EPF driver.
- */
-void pci_epf_unregister_driver(struct pci_epf_driver *driver)
+static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
 {
 	struct config_group *group;
 
+	if (!IS_ENABLED(CONFIG_PCI_ENDPOINT_CONFIGFS))
+		return;
+
 	mutex_lock(&pci_epf_mutex);
 	list_for_each_entry(group, &driver->epf_group, group_entry)
 		pci_ep_cfs_remove_epf_group(group);
 	list_del(&driver->epf_group);
 	mutex_unlock(&pci_epf_mutex);
+}
+
+/**
+ * pci_epf_unregister_driver() - unregister the PCI EPF driver
+ * @driver: the PCI EPF driver that has to be unregistered
+ *
+ * Invoke to unregister the PCI EPF driver.
+ */
+void pci_epf_unregister_driver(struct pci_epf_driver *driver)
+{
+	pci_epf_remove_cfs(driver);
 	driver_unregister(&driver->driver);
 }
 EXPORT_SYMBOL_GPL(pci_epf_unregister_driver);
 
+static int pci_epf_add_cfs(struct pci_epf_driver *driver)
+{
+	struct config_group *group;
+	const struct pci_epf_device_id *id;
+
+	if (!IS_ENABLED(CONFIG_PCI_ENDPOINT_CONFIGFS))
+		return 0;
+
+	INIT_LIST_HEAD(&driver->epf_group);
+
+	id = driver->id_table;
+	while (id->name[0]) {
+		group = pci_ep_cfs_add_epf_group(id->name);
+		if (IS_ERR(group)) {
+			pci_epf_remove_cfs(driver);
+			return PTR_ERR(group);
+		}
+
+		mutex_lock(&pci_epf_mutex);
+		list_add_tail(&group->group_entry, &driver->epf_group);
+		mutex_unlock(&pci_epf_mutex);
+		id++;
+	}
+
+	return 0;
+}
+
 /**
  * __pci_epf_register_driver() - register a new PCI EPF driver
  * @driver: structure representing PCI EPF driver
@@ -167,8 +202,6 @@ int __pci_epf_register_driver(struct pci_epf_driver *driver,
 			      struct module *owner)
 {
 	int ret;
-	struct config_group *group;
-	const struct pci_epf_device_id *id;
 
 	if (!driver->ops)
 		return -EINVAL;
@@ -183,16 +216,7 @@ int __pci_epf_register_driver(struct pci_epf_driver *driver,
 	if (ret)
 		return ret;
 
-	INIT_LIST_HEAD(&driver->epf_group);
-
-	id = driver->id_table;
-	while (id->name[0]) {
-		group = pci_ep_cfs_add_epf_group(id->name);
-		mutex_lock(&pci_epf_mutex);
-		list_add_tail(&group->group_entry, &driver->epf_group);
-		mutex_unlock(&pci_epf_mutex);
-		id++;
-	}
+	pci_epf_add_cfs(driver);
 
 	return 0;
 }
-- 
2.17.1
