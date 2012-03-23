Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60748 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757070Ab2CWPBj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Mar 2012 11:01:39 -0400
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [RFC PATCH 02/11] PCI: introduce pci_bus_get()/pci_bus_put() to hide implementation details
Date: Fri, 23 Mar 2012 22:58:18 +0800
Message-Id: <1332514707-9673-3-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com>
References: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce pci_bus_get()/pci_bus_put() to hide implementation details

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/acpi/pci_slot.c            |    4 ++--
 drivers/pci/bus.c                  |   15 +++++++++++++++
 drivers/pci/hotplug/acpiphp_glue.c |    4 ++--
 include/linux/pci.h                |    2 ++
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
index e50e31a..323797a 100644
--- a/drivers/acpi/pci_slot.c
+++ b/drivers/acpi/pci_slot.c
@@ -166,7 +166,7 @@ register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
 	list_add(&slot->list, &slot_list);
 	mutex_unlock(&slot_list_lock);
 
-	get_device(&pci_bus->dev);
+	pci_bus_get(pci_bus);
 
 	dbg("pci_slot: %p, pci_bus: %x, device: %d, name: %s\n",
 		pci_slot, pci_bus->number, device, name);
@@ -322,7 +322,7 @@ acpi_pci_slot_remove(acpi_handle handle)
 			list_del(&slot->list);
 			pbus = slot->pci_slot->bus;
 			pci_destroy_slot(slot->pci_slot);
-			put_device(&pbus->dev);
+			pci_bus_put(pbus);
 			kfree(slot);
 		}
 	}
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 672ffc8..2803120 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -35,6 +35,21 @@ void pci_add_resource_offset(struct list_head *resources, struct resource *res,
 }
 EXPORT_SYMBOL(pci_add_resource_offset);
 
+struct pci_bus *pci_bus_get(struct pci_bus *bus)
+{
+	if (bus)
+		get_device(&bus->dev);
+	return bus;
+}
+EXPORT_SYMBOL(pci_bus_get);
+
+void pci_bus_put(struct pci_bus *bus)
+{
+	if (bus)
+		put_device(&bus->dev);
+}
+EXPORT_SYMBOL(pci_bus_put);
+
 void pci_add_resource(struct list_head *resources, struct resource *res)
 {
 	pci_add_resource_offset(resources, res, 0);
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 9d781a7..11155ef 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -397,7 +397,7 @@ static void add_p2p_bridge(acpi_handle *handle)
 	 * removed via PCI core logical hotplug. The ref pins the bus
 	 * (which we access during module unload).
 	 */
-	get_device(&bridge->pci_bus->dev);
+	pci_bus_get(bridge->pci_bus);
 
 	init_bridge_misc(bridge);
 	return;
@@ -527,7 +527,7 @@ static void cleanup_bridge(struct acpiphp_bridge *bridge)
 	 * Only P2P bridges have a pci_dev
 	 */
 	if (bridge->pci_dev)
-		put_device(&bridge->pci_bus->dev);
+		pci_bus_put(bridge->pci_bus);
 
 	pci_dev_put(bridge->pci_dev);
 	list_del(&bridge->list);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 161f6c0..427ea42 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -933,6 +933,8 @@ int pci_request_selected_regions_exclusive(struct pci_dev *, int, const char *);
 void pci_release_selected_regions(struct pci_dev *, int);
 
 /* drivers/pci/bus.c */
+struct pci_bus *pci_bus_get(struct pci_bus *bus);
+void pci_bus_put(struct pci_bus *bus);
 void pci_add_resource(struct list_head *resources, struct resource *res);
 void pci_add_resource_offset(struct list_head *resources, struct resource *res,
 			     resource_size_t offset);
-- 
1.7.5.4

