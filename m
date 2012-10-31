Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:33923 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932447Ab2JaH3K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 31 Oct 2012 03:29:10 -0400
From: Tang Chen <tangchen@cn.fujitsu.com>
To: yinghai@kernel.org, bhelgaas@google.com, lenb@kernel.org,
	jiang.liu@huawei.com, izumi.taku@jp.fujitsu.com,
	isimatu.yasuaki@jp.fujitsu.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] Improve container_notify_cb() to support container hot-remove.
Date: Wed, 31 Oct 2012 15:27:51 +0800
Message-Id: <1351668471-31436-4-git-send-email-tangchen@cn.fujitsu.com>
In-Reply-To: <1351668471-31436-1-git-send-email-tangchen@cn.fujitsu.com>
References: <1351668471-31436-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch introduces a new function container_device_remove() to do
the container hot-remove job. It works like the following:

1. call acpi_bus_trim(device, 0) to stop the container device,
   which means to unbind ACPI drivers first before remove devices.
   (This feature is introduced by Lu Yinghai:
    http://www.spinics.net/lists/linux-pci/msg17667.html)
2. generate the KOBJ_OFFLINE uevent. (Did I do this correct ?)
3. call acpi_bus_hot_remove_device(), which will call acpi_bus_trim(device, 1)
   to remove the container.

This patch is based on Lu Yinghai's work.
git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-split-pci-root-hp-2

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 drivers/acpi/container.c |   63 ++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index a10eee6..4abec98 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -166,6 +166,32 @@ static int container_device_add(struct acpi_device **device, acpi_handle handle)
 	return result;
 }
 
+static int container_device_remove(struct acpi_device *device)
+{
+	int ret;
+	struct acpi_eject_event *ej_event;
+
+	/* stop container device at first */
+	ret = acpi_bus_trim(device, 0);
+	pr_debug("acpi_bus_trim stop return %x\n", ret);
+	if (ret)
+		return ret;
+
+	/* send the uevent before remove the device */
+	kobject_uevent(&device->dev.kobj, KOBJ_OFFLINE);
+
+	ej_event = kmalloc(sizeof(*ej_event), GFP_KERNEL);
+	if (!ej_event)
+		return -ENOMEM;
+
+	ej_event->device = device;
+	ej_event->event = ACPI_NOTIFY_EJECT_REQUEST;
+
+	acpi_bus_hot_remove_device(ej_event);
+
+	return 0;
+}
+
 /* This function is of type acpi_osd_exec_callback */
 static void _container_notify_cb(void *context)
 {
@@ -182,6 +208,9 @@ static void _container_notify_cb(void *context)
 	handle = cb_data->handle;
 	type = cb_data->type;
 
+	present = is_device_present(handle);
+	status = acpi_bus_get_device(handle, &device);
+
 	switch (type) {
 	case ACPI_NOTIFY_BUS_CHECK:
 		/* Fall through */
@@ -190,13 +219,16 @@ static void _container_notify_cb(void *context)
 		       (type == ACPI_NOTIFY_BUS_CHECK) ?
 		       "ACPI_NOTIFY_BUS_CHECK" : "ACPI_NOTIFY_DEVICE_CHECK");
 
-		present = is_device_present(handle);
-		status = acpi_bus_get_device(handle, &device);
 		if (!present) {
 			if (ACPI_SUCCESS(status)) {
 				/* device exist and this is a remove request */
-				device->flags.eject_pending = 1;
-				kobject_uevent(&device->dev.kobj, KOBJ_OFFLINE);
+				result = container_device_remove(device);
+				if (result) {
+					dev_warn(&device->dev, "%s: Failed to "
+						"remove container\n",
+						__func__);
+					break;
+				}
 				goto out;
 			}
 			break;
@@ -207,7 +239,9 @@ static void _container_notify_cb(void *context)
 
 		result = container_device_add(&device, handle);
 		if (result) {
-			printk(KERN_WARNING "Failed to add container\n");
+			dev_warn(&device->dev,
+				"%s: Failed to add container\n",
+				__func__);
 			break;
 		}
 
@@ -216,12 +250,21 @@ static void _container_notify_cb(void *context)
 		break;
 
 	case ACPI_NOTIFY_EJECT_REQUEST:
-		if (!acpi_bus_get_device(handle, &device) && device) {
-			device->flags.eject_pending = 1;
-			kobject_uevent(&device->dev.kobj, KOBJ_OFFLINE);
-			goto out;
+		printk(KERN_WARNING "Container driver received %s event\n",
+			"ACPI_NOTIFY_EJECT_REQUEST");
+
+		if (!present || ACPI_FAILURE(status) || !device)
+			break;
+
+		result = container_device_remove(device);
+		if (result) {
+			dev_warn(&device->dev,
+				"%s: Failed to remove container\n",
+				__func__);
+			break;
 		}
-		break;
+
+		goto out;
 
 	default:
 		/* non-hotplug event; possibly handled by other handler */
-- 
1.7.1

