Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tang Chen <tangchen@cn.fujitsu.com>
To: yinghai@kernel.org, bhelgaas@google.com, lenb@kernel.org,
	jiang.liu@huawei.com, izumi.taku@jp.fujitsu.com,
	isimatu.yasuaki@jp.fujitsu.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] Use kacpi_hotplug_wq to handle container hotplug event.
Date: Wed, 31 Oct 2012 15:27:50 +0800
Message-Id: <1351668471-31436-3-git-send-email-tangchen@cn.fujitsu.com>
In-Reply-To: <1351668471-31436-1-git-send-email-tangchen@cn.fujitsu.com>
References: <1351668471-31436-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As the comments in __acpi_os_execute() said:

	We can't run hotplug code in keventd_wq/kacpid_wq/kacpid_notify_wq
	because the hotplug code may call driver .remove() functions,
	which invoke flush_scheduled_work/acpi_os_wait_events_complete
	to flush these workqueues.

we should keep the hotplug code in kacpi_hotplug_wq.

But we have the following call series in kernel now:
        acpi_ev_queue_notify_request()
        |--> acpi_os_execute()
             |--> __acpi_os_execute(type, function, context, 0)

The last parameter 0 makes the container_notify_cb() executed in
kacpi_notify_wq or kacpid_wq. So, we need to put the real hotplug code
into kacpi_hotplug_wq.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 drivers/acpi/container.c |   34 ++++++++++++++++++++++++++++++----
 1 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 69e2d6b..a10eee6 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -35,6 +35,7 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/container.h>
+#include <acpi/acpiosxf.h>
 
 #define PREFIX "ACPI: "
 
@@ -165,14 +166,22 @@ static int container_device_add(struct acpi_device **device, acpi_handle handle)
 	return result;
 }
 
-static void container_notify_cb(acpi_handle handle, u32 type, void *context)
+/* This function is of type acpi_osd_exec_callback */
+static void _container_notify_cb(void *context)
 {
 	struct acpi_device *device = NULL;
 	int result;
 	int present;
 	acpi_status status;
+	struct acpi_hp_cb_data *cb_data;
+	acpi_handle handle;
+	u32 type;
 	u32 ost_code = ACPI_OST_SC_NON_SPECIFIC_FAILURE; /* default */
 
+	cb_data = (struct acpi_hp_cb_data *)context;
+	handle = cb_data->handle;
+	type = cb_data->type;
+
 	switch (type) {
 	case ACPI_NOTIFY_BUS_CHECK:
 		/* Fall through */
@@ -188,7 +197,7 @@ static void container_notify_cb(acpi_handle handle, u32 type, void *context)
 				/* device exist and this is a remove request */
 				device->flags.eject_pending = 1;
 				kobject_uevent(&device->dev.kobj, KOBJ_OFFLINE);
-				return;
+				goto out;
 			}
 			break;
 		}
@@ -210,20 +219,37 @@ static void container_notify_cb(acpi_handle handle, u32 type, void *context)
 		if (!acpi_bus_get_device(handle, &device) && device) {
 			device->flags.eject_pending = 1;
 			kobject_uevent(&device->dev.kobj, KOBJ_OFFLINE);
-			return;
+			goto out;
 		}
 		break;
 
 	default:
 		/* non-hotplug event; possibly handled by other handler */
-		return;
+		goto out;
 	}
 
 	/* Inform firmware that the hotplug operation has completed */
 	(void) acpi_evaluate_hotplug_ost(handle, type, ost_code, NULL);
+
+out:
+	kfree(context);		/* allocated in container_notify_cb */
 	return;
 }
 
+static void container_notify_cb(acpi_handle handle, u32 type,
+				void *context)
+{
+	/*
+	 * Currently the code adds all hotplug events to the kacpid_wq
+	 * queue when it should add hotplug events to the kacpi_hotplug_wq.
+	 * The proper way to fix this is to reorganize the code so that
+	 * drivers (dock, etc.) do not call acpi_os_execute(), etc.
+	 * For now just re-add this work to the kacpi_hotplug_wq so we
+	 * don't deadlock on hotplug actions.
+	 */
+	acpi_hp_cb_execute(handle, type, context, _container_notify_cb);
+}
+
 static acpi_status
 container_walk_namespace_cb(acpi_handle handle,
 			    u32 lvl, void *context, void **rv)
-- 
1.7.1

