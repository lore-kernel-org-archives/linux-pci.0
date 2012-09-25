Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH 08/29] PCI, ACPI: Remove acpi_find_bridge_device for acpi_bus_type
Date: Tue, 25 Sep 2012 01:26:09 -0700
Message-Id: <1348561590-28067-9-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now all acpi_bus_typs definitions have bus assigned, so remove not needed code.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/glue.c |   20 ++------------------
 1 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 3079634..db6b625 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -72,22 +72,6 @@ static struct acpi_bus_type *acpi_get_bus_type(struct bus_type *type)
 	return ret;
 }
 
-static int acpi_find_bridge_device(struct device *dev, acpi_handle * handle)
-{
-	struct acpi_bus_type *tmp;
-	int ret = -ENODEV;
-
-	down_read(&bus_type_sem);
-	list_for_each_entry(tmp, &bus_type_list, list) {
-		if (tmp->find_bridge && !tmp->find_bridge(dev, handle)) {
-			ret = 0;
-			break;
-		}
-	}
-	up_read(&bus_type_sem);
-	return ret;
-}
-
 /* Get device's handler per its address under its parent */
 struct acpi_find_child {
 	acpi_handle handle;
@@ -211,10 +195,10 @@ static int acpi_platform_notify(struct device *dev)
 	int ret = -EINVAL;
 
 	if (!dev->bus) {
-		/* bridge devices genernally haven't bus */
-		ret = acpi_find_bridge_device(dev, &handle);
+		DBG("No bus is set for %s\n", dev_name(dev));
 		goto end;
 	}
+
 	type = acpi_get_bus_type(dev->bus);
 	if (!type) {
 		DBG("No ACPI bus support for %s\n", dev_name(dev));
-- 
1.7.7

