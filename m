Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [RFC PATCH 03/11] PCI: clean up root bridge related logic in acpiphp driver
Date: Fri, 23 Mar 2012 22:58:19 +0800
Message-Id: <1332514707-9673-4-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com>
References: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changeset
4f30793 PCI, acpiphp: Separate out hot-add support of pci host bridge
tries to remove all PCI host bridge related code from acpiphp driver.
There's still some code for PCI host bridge hotplug left in
acpiphp_glue.c, clean it up.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |   89 ++----------------------------------
 1 files changed, 4 insertions(+), 85 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 11155ef..003a6d5 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -1040,67 +1040,9 @@ static void acpiphp_sanitize_bus(struct pci_bus *bus)
 	}
 }
 
-/* Program resources in newly inserted bridge */
-static int acpiphp_configure_bridge (acpi_handle handle)
-{
-	struct pci_bus *bus;
-	struct pci_dev *pdev = acpi_get_pci_dev(handle);
-
-	bus = pdev->subordinate;
-	pci_dev_put(pdev);
-
-	pci_bus_size_bridges(bus);
-	pci_bus_assign_resources(bus);
-	acpiphp_sanitize_bus(bus);
-	acpiphp_set_hpp_values(bus);
-	pci_enable_bridges(bus);
-	return 0;
-}
-
-static void handle_bridge_insertion(acpi_handle handle, u32 type)
-{
-	struct acpi_device *device, *pdevice;
-	acpi_handle phandle;
-
-	if ((type != ACPI_NOTIFY_BUS_CHECK) &&
-			(type != ACPI_NOTIFY_DEVICE_CHECK)) {
-		err("unexpected notification type %d\n", type);
-		return;
-	}
-
-	acpi_get_parent(handle, &phandle);
-	if (acpi_bus_get_device(phandle, &pdevice)) {
-		dbg("no parent device, assuming NULL\n");
-		pdevice = NULL;
-	}
-	if (acpi_bus_add(&device, pdevice, handle, ACPI_BUS_TYPE_DEVICE)) {
-		err("cannot add bridge to acpi list\n");
-		return;
-	}
-	if (!acpiphp_configure_bridge(handle) &&
-		!acpi_bus_start(device))
-		add_bridge(handle);
-	else
-		err("cannot configure and start bridge\n");
-
-}
-
 /*
  * ACPI event handlers
  */
-
-static acpi_status
-count_sub_bridges(acpi_handle handle, u32 lvl, void *context, void **rv)
-{
-	int *count = (int *)context;
-	struct acpiphp_bridge *bridge;
-
-	bridge = acpiphp_handle_to_bridge(handle);
-	if (bridge)
-		(*count)++;
-	return AE_OK ;
-}
-
 static acpi_status
 check_sub_bridges(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
@@ -1125,8 +1067,6 @@ static void _handle_hotplug_event_bridge(struct work_struct *work)
 	char objname[64];
 	struct acpi_buffer buffer = { .length = sizeof(objname),
 				      .pointer = objname };
-	struct acpi_device *device;
-	int num_sub_bridges = 0;
 	struct acpi_hp_work *hp_work;
 	acpi_handle handle;
 	u32 type;
@@ -1134,23 +1074,7 @@ static void _handle_hotplug_event_bridge(struct work_struct *work)
 	hp_work = container_of(work, struct acpi_hp_work, work);
 	handle = hp_work->handle;
 	type = hp_work->type;
-
-	if (acpi_bus_get_device(handle, &device)) {
-		/* This bridge must have just been physically inserted */
-		handle_bridge_insertion(handle, type);
-		goto out;
-	}
-
-	bridge = acpiphp_handle_to_bridge(handle);
-	if (type == ACPI_NOTIFY_BUS_CHECK) {
-		acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, ACPI_UINT32_MAX,
-			count_sub_bridges, NULL, &num_sub_bridges, NULL);
-	}
-
-	if (!bridge && !num_sub_bridges) {
-		err("cannot get bridge info\n");
-		goto out;
-	}
+	bridge = (struct acpiphp_bridge *)hp_work->context;
 
 	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
 
@@ -1163,9 +1087,8 @@ static void _handle_hotplug_event_bridge(struct work_struct *work)
 				__func__, objname);
 			acpiphp_check_bridge(bridge);
 		}
-		if (num_sub_bridges)
-			acpi_walk_namespace(ACPI_TYPE_DEVICE, handle,
-				ACPI_UINT32_MAX, check_sub_bridges, NULL, NULL, NULL);
+		acpi_walk_namespace(ACPI_TYPE_DEVICE, handle,
+			ACPI_UINT32_MAX, check_sub_bridges, NULL, NULL, NULL);
 		break;
 
 	case ACPI_NOTIFY_DEVICE_CHECK:
@@ -1210,7 +1133,6 @@ static void _handle_hotplug_event_bridge(struct work_struct *work)
 		break;
 	}
 
-out:
 	kfree(hp_work); /* allocated in handle_hotplug_event_bridge */
 }
 
@@ -1245,17 +1167,14 @@ static void _handle_hotplug_event_func(struct work_struct *work)
 	struct acpi_hp_work *hp_work;
 	acpi_handle handle;
 	u32 type;
-	void *context;
 
 	hp_work = container_of(work, struct acpi_hp_work, work);
 	handle = hp_work->handle;
 	type = hp_work->type;
-	context = hp_work->context;
+	func = (struct acpiphp_func *)hp_work->context;
 
 	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
 
-	func = (struct acpiphp_func *)context;
-
 	switch (type) {
 	case ACPI_NOTIFY_BUS_CHECK:
 		/* bus re-enumerate */
-- 
1.7.5.4

