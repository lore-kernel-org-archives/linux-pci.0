Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51359 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026AbaARCro (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 17 Jan 2014 21:47:44 -0500
From: Jiang Liu <jiang.liu@linux.intel.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Robert Moore <robert.moore@intel.com>,
	Lv Zheng <lv.zheng@intel.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devel@acpica.org
Subject: [Patch v1 1/3] ACPI: add callback prepare() into acpi_hotplug_handler
Date: Sat, 18 Jan 2014 10:48:15 +0800
Message-Id: <1390013297-23462-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add callback prepare() into acpi_hotplug_handler, which will get called
at the very beginning of ACPI hotplug event handler. The ACPI core will
ignore the event if prepare() returns NOTIFY_STOP.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/scan.c     |    4 ++++
 include/acpi/acpi_bus.h |    1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fd39459..6b0f419 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -392,6 +392,10 @@ static void acpi_hotplug_notify_cb(acpi_handle handle, u32 type, void *data)
 	struct acpi_device *adev;
 	acpi_status status;
 
+	if (handler->prepare &&
+	    handler->prepare(handle, type, data) == NOTIFY_STOP)
+		return;
+
 	if (!handler->hotplug.enabled)
 		return acpi_hotplug_unsupported(handle, type);
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index ddabed1..09a73bd 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -113,6 +113,7 @@ static inline struct acpi_hotplug_profile *to_acpi_hotplug_profile(
 struct acpi_scan_handler {
 	const struct acpi_device_id *ids;
 	struct list_head list_node;
+	int (*prepare)(acpi_handle handle, u32 type, void *context);
 	int (*attach)(struct acpi_device *dev, const struct acpi_device_id *id);
 	void (*detach)(struct acpi_device *dev);
 	struct acpi_hotplug_profile hotplug;
-- 
1.7.10.4

