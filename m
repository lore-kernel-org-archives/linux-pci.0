Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35269 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758457Ab2CWPC1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Mar 2012 11:02:27 -0400
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [RFC PATCH 07/11] ACPI,PCI: update ACPI slots when PCI hotplug event happens
Date: Fri, 23 Mar 2012 22:58:23 +0800
Message-Id: <1332514707-9673-8-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com>
References: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When a PCI bus is removed, all ACPI slots associated with that
bus should be destroyed. Otherwise the ACPI slot device may
cause invalide memory access to the destroyed PCI bus.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/acpi/pci_slot.c |   77 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
index 323797a..0b67c13 100644
--- a/drivers/acpi/pci_slot.c
+++ b/drivers/acpi/pci_slot.c
@@ -32,6 +32,7 @@
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include <linux/pci-acpi.h>
 #include <linux/dmi.h>
 
 static bool debug;
@@ -145,6 +146,21 @@ register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
 	if (device < 0)
 		return AE_OK;
 
+	/*
+	 * Slots may have already been created for PCI slots under
+	 * hot-added PCI host bridges.
+	 */
+	mutex_lock(&slot_list_lock);
+	list_for_each_entry(slot, &slot_list, list) {
+		pci_slot = slot->pci_slot;
+		if (pci_slot && pci_slot->bus == pci_bus &&
+		    pci_slot->number == device) {
+			mutex_unlock(&slot_list_lock);
+			return AE_OK;
+		}
+	}
+	mutex_unlock(&slot_list_lock);
+
 	slot = kmalloc(sizeof(*slot), GFP_KERNEL);
 	if (!slot) {
 		err("%s: cannot allocate memory\n", __func__);
@@ -354,17 +370,78 @@ static struct dmi_system_id acpi_pci_slot_dmi_table[] __initdata = {
 	{}
 };
 
+static void acpi_pci_slot_notify_bus_add(struct pci_bus *bus)
+{
+	acpi_handle handle;
+	struct callback_args context;
+
+	/* Skip root buses */
+	if (!bus->self)
+		return;
+
+	context.pci_bus = bus;
+	context.user_function = register_slot;
+	context.root_handle = acpi_find_root_bridge_handle(bus->self);
+	handle = acpi_pci_get_bridge_handle(bus);
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, (u32)1,
+			    register_slot, NULL, &context, NULL);
+}
+
+static void acpi_pci_slot_notify_bus_remove(struct pci_bus *bus)
+{
+	struct acpi_pci_slot *slot, *tmp;
+
+	/* Skip root buses */
+	if (!bus->self)
+		return;
+
+	mutex_lock(&slot_list_lock);
+	list_for_each_entry_safe(slot, tmp, &slot_list, list) {
+		if (slot->pci_slot && slot->pci_slot->bus == bus) {
+			list_del(&slot->list);
+			pci_destroy_slot(slot->pci_slot);
+			put_device(&bus->dev);
+			kfree(slot);
+		}
+	}
+	mutex_unlock(&slot_list_lock);
+}
+
+static int acpi_pci_slot_notify_fn(struct notifier_block *nb,
+				   unsigned long event, void *data)
+{
+	switch (event) {
+	case PCI_HP_EVENT_BUS_ADD:
+		acpi_pci_slot_notify_bus_add(data);
+		break;
+	case PCI_HP_EVENT_BUS_REMOVE:
+		acpi_pci_slot_notify_bus_remove(data);
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block acpi_pci_slot_notifier = {
+	.notifier_call = &acpi_pci_slot_notify_fn,
+};
+
 static int __init
 acpi_pci_slot_init(void)
 {
 	dmi_check_system(acpi_pci_slot_dmi_table);
 	acpi_pci_register_driver(&acpi_pci_slot_driver);
+	pci_register_hotplug_notifier(&acpi_pci_slot_notifier);
+
 	return 0;
 }
 
 static void __exit
 acpi_pci_slot_exit(void)
 {
+	pci_unregister_hotplug_notifier(&acpi_pci_slot_notifier);
 	acpi_pci_unregister_driver(&acpi_pci_slot_driver);
 }
 
-- 
1.7.5.4

