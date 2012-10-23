Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:21036 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756903Ab2JWNLy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Oct 2012 09:11:54 -0400
From: Tang Chen <tangchen@cn.fujitsu.com>
To: yinghai@kernel.org, bhelgaas@google.com, lenb@kernel.org,
	jiang.liu@huawei.com, izumi.taku@jp.fujitsu.com,
	isimatu.yasuaki@jp.fujitsu.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Use kacpi_hotplug_wq to handle container hotplug event.
Date: Tue, 23 Oct 2012 21:10:38 +0800
Message-Id: <1350997839-13260-2-git-send-email-tangchen@cn.fujitsu.com>
In-Reply-To: <1350997839-13260-1-git-send-email-tangchen@cn.fujitsu.com>
References: <1350997839-13260-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
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
 drivers/acpi/container.c |   44 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 1f9f7d7..643657a 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -72,8 +72,36 @@ static struct acpi_driver acpi_container_driver = {
 		},
 };
 
+struct acpi_container_hp_work {
+	struct work_struct work;
+	acpi_handle handle;
+	u32 type;
+	void *context;
+};
+
 /*******************************************************************/
 
+static void alloc_acpi_container_hp_work(acpi_handle handle, u32 type,
+					void *context,
+					void (*func)(struct work_struct *work))
+{
+	struct acpi_container_hp_work *hp_work;
+	int ret;
+
+	hp_work = kmalloc(sizeof(*hp_work), GFP_KERNEL);
+	if (!hp_work)
+		return;
+
+	hp_work->handle = handle;
+	hp_work->type = type;
+	hp_work->context = context;
+
+	INIT_WORK(&hp_work->work, func);
+	ret = queue_work(kacpi_hotplug_wq, &hp_work->work);
+	if (!ret)
+		kfree(hp_work);
+}
+
 static int is_device_present(acpi_handle handle)
 {
 	acpi_handle temp;
@@ -152,14 +180,21 @@ static int container_device_add(struct acpi_device **device, acpi_handle handle)
 	return result;
 }
 
-static void container_notify_cb(acpi_handle handle, u32 type, void *context)
+static void __container_notify_cb(struct work_struct *work)
 {
 	struct acpi_device *device = NULL;
 	int result;
 	int present;
 	acpi_status status;
+	struct acpi_container_hp_work *hp_work;
+	acpi_handle handle;
+	u32 type;
 	u32 ost_code = ACPI_OST_SC_NON_SPECIFIC_FAILURE; /* default */
 
+	hp_work = container_of(work, struct acpi_container_hp_work, work);
+	handle = hp_work->handle;
+	type = hp_work->type;
+
 	switch (type) {
 	case ACPI_NOTIFY_BUS_CHECK:
 		/* Fall through */
@@ -211,6 +246,13 @@ static void container_notify_cb(acpi_handle handle, u32 type, void *context)
 	return;
 }
 
+static void container_notify_cb(acpi_handle handle, u32 type,
+				void *context)
+{
+	alloc_acpi_container_hp_work(handle, type, context,
+				__container_notify_cb);
+}
+
 static acpi_status
 container_walk_namespace_cb(acpi_handle handle,
 			    u32 lvl, void *context, void **rv)
-- 
1.7.1

