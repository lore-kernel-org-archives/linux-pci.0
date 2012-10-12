Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Tang Chen <tangchen@cn.fujitsu.com>
To: bhelgaas@google.com, lenb@kernel.org, yinghai@kernel.org,
	izumi.taku@jp.fujitsu.com, jiang.liu@huawei.com,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH] Fix a hard coding style when determining if a device is a container.
Date: Fri, 12 Oct 2012 14:55:16 +0800
Message-Id: <1350024916-3628-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

"ACPI0004","PNP0A05" and "PNP0A06" are all defined in array
container_device_ids[], so use it, but not the hard coding style.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 drivers/acpi/container.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 1f9f7d7..448c0e2 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -217,6 +217,7 @@ container_walk_namespace_cb(acpi_handle handle,
 {
 	char *hid = NULL;
 	struct acpi_device_info *info;
+	struct acpi_device_id *container_id;
 	acpi_status status;
 	int *action = context;
 
@@ -232,10 +233,13 @@ container_walk_namespace_cb(acpi_handle handle,
 		goto end;
 	}
 
-	if (strcmp(hid, "ACPI0004") && strcmp(hid, "PNP0A05") &&
-	    strcmp(hid, "PNP0A06")) {
-		goto end;
+	for (container_id = container_device_ids;
+	     container_id->id[0]; container_id++) {
+		if (!strcmp((char *)container_id->id, hid))
+			break;
 	}
+	if (!container_id->id[0])
+		goto end;
 
 	switch (*action) {
 	case INSTALL_NOTIFY_HANDLER:
-- 
1.7.1

