Return-Path: <linux-acpi-owner@vger.kernel.org>
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
Subject: [Patch v1 3/3] ACPI: kill field 'ignore' in acpi_hotplug_profile
Date: Sat, 18 Jan 2014 10:48:17 +0800
Message-Id: <1390013297-23462-3-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1390013297-23462-1-git-send-email-jiang.liu@linux.intel.com>
References: <1390013297-23462-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Field 'ignore' in acpi_hotplug_profile is introduced by "ca499fc87ed945
ACPI / hotplug: Fix conflicted PCI bridge notify handlers" to support
PCI host bridge hotplug. Now it's useless, so kill it.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/scan.c     |    2 +-
 include/acpi/acpi_bus.h |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index d83e0ff..b932ae6 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1776,7 +1776,7 @@ static void acpi_scan_init_hotplug(acpi_handle handle, int type)
 	 */
 	list_for_each_entry(hwid, &pnp.ids, list) {
 		handler = acpi_scan_match_handler(hwid->id, NULL);
-		if (handler && !handler->hotplug.ignore) {
+		if (handler) {
 			acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
 					acpi_hotplug_notify_cb, handler);
 			break;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 09a73bd..d1f6ebd 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -100,7 +100,6 @@ enum acpi_hotplug_mode {
 struct acpi_hotplug_profile {
 	struct kobject kobj;
 	bool enabled:1;
-	bool ignore:1;
 	enum acpi_hotplug_mode mode;
 };
 
-- 
1.7.10.4

