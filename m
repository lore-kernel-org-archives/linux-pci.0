Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49589 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756811Ab2DKQ3U (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Apr 2012 12:29:20 -0400
Received: by pbcun15 with SMTP id un15so1417734pbc.19
        for <linux-pci@vger.kernel.org>; Wed, 11 Apr 2012 09:29:20 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: correctly detect ACPI PCI host bridge objects
Date: Thu, 12 Apr 2012 00:27:03 +0800
Message-Id: <1334161623-4834-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The code in pci_root_hp.c depends on function acpi_is_root_bridge()
to check whether an ACPI object is a PCI host bridge or not.
If an ACPI device hasn't been created for the ACPI object yet,
function acpi_is_root_bridge() will return false even if the object
is a PCI host bridge object. That behavior will cause two issues:
1) No ACPI notification handler installed for PCI host bridges absent
   at startup, so hotplug events for those bridges won't be handled.
2) rescan_root_bridge() can't reenumerate offlined PCI host bridges
   because the ACPI devices have been already destroyed.

So introduce acpi_match_object_ids() to correctly detect PCI host bridges.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
It applies to Yinghai's tree at
git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-root-bus-hotplug
---
 drivers/acpi/pci_root_hp.c |   15 +++++++++++++--
 drivers/acpi/scan.c        |   28 ++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h    |    2 ++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_root_hp.c b/drivers/acpi/pci_root_hp.c
index e16b53d..34cf1b7 100644
--- a/drivers/acpi/pci_root_hp.c
+++ b/drivers/acpi/pci_root_hp.c
@@ -19,6 +19,12 @@ struct acpi_root_bridge {
 	u32 flags;
 };
 
+static const struct acpi_device_id root_device_ids[] = {
+	{"PNP0A03", 0},
+	{"PNP0A08", 0},
+	{"", 0},
+};
+
 /* bridge flags */
 #define ROOT_BRIDGE_HAS_EJ0	(0x00000002)
 #define ROOT_BRIDGE_HAS_PS3	(0x00000080)
@@ -232,6 +238,11 @@ static void handle_hotplug_event_root(acpi_handle handle, u32 type,
 				_handle_hotplug_event_root);
 }
 
+static bool acpi_is_root_bridge_object(acpi_handle handle)
+{
+	return !!acpi_match_object_ids(handle, root_device_ids);
+}
+
 static acpi_status __init
 find_root_bridges(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
@@ -240,7 +251,7 @@ find_root_bridges(acpi_handle handle, u32 lvl, void *context, void **rv)
 				      .pointer = objname };
 	int *count = (int *)context;
 
-	if (!acpi_is_root_bridge(handle))
+	if (!acpi_is_root_bridge_object(handle))
 		return AE_OK;
 
 	(*count)++;
@@ -273,7 +284,7 @@ subsys_initcall(acpi_pci_root_hp_init);
 static acpi_status
 rescan_root_bridge(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
-	if (!acpi_is_root_bridge(handle))
+	if (!acpi_is_root_bridge_object(handle))
 		return AE_OK;
 
 	handle_root_bridge_insertion(handle);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 767e2dc..53e95f5 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -272,6 +272,34 @@ int acpi_match_device_ids(struct acpi_device *device,
 }
 EXPORT_SYMBOL(acpi_match_device_ids);
 
+int acpi_match_object_ids(acpi_handle handle, const struct acpi_device_id *ids)
+{
+	int i, count;
+	acpi_status status;
+	struct acpica_device_id *hids;
+	const struct acpi_device_id *id;
+	struct acpi_device_info *info = NULL;
+
+	status = acpi_get_object_info(handle, &info);
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	hids = info->compatible_id_list.ids;
+	count = info->compatible_id_list.count;
+	for (id = ids; id->id[0]; id++)
+		for (i = 0; i < count; i++)
+			if (!strncmp((char *)id->id, hids[i].string,
+				     ACPI_ID_LEN)) {
+				kfree(info);
+				return 1;
+			}
+
+	kfree(info);
+
+	return 0;
+}
+EXPORT_SYMBOL(acpi_match_object_ids);
+
 static void acpi_free_ids(struct acpi_device *device)
 {
 	struct acpi_hardware_id *id, *tmp;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index cb4f402..0d990b7 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -342,6 +342,8 @@ int acpi_bus_start(struct acpi_device *device);
 acpi_status acpi_bus_get_ejd(acpi_handle handle, acpi_handle * ejd);
 int acpi_match_device_ids(struct acpi_device *device,
 			  const struct acpi_device_id *ids);
+int acpi_match_object_ids(acpi_handle handle,
+			  const struct acpi_device_id *ids);
 int acpi_create_dir(struct acpi_device *);
 void acpi_remove_dir(struct acpi_device *);
 
-- 
1.7.5.4

