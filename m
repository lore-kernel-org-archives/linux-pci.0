Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:31292 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382Ab2JBGdM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2012 02:33:12 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH 06/10] PCI, ACPI: Move hot add root bus conf code to acpi_pci_root_add
Date: Mon,  1 Oct 2012 23:33:04 -0700
Message-Id: <1349159588-15029-7-git-send-email-yinghai@kernel.org>
In-Reply-To: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It is safe before we really put those pci devices in the tree.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc:Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/pci_root.c |   31 ++++++++++++++++---------------
 1 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 75643ce..e63a58d 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -506,6 +506,7 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	acpi_status status;
 	int result;
 	struct acpi_pci_root *root;
+	struct acpi_pci_driver *driver;
 	acpi_handle handle;
 	u32 flags;
 
@@ -607,6 +608,21 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	if (device->wakeup.flags.run_wake)
 		device_set_run_wake(root->bus->bridge, true);
 
+	if (system_state != SYSTEM_BOOTING) {
+		pcibios_resource_survey_bus(root->bus);
+		pci_assign_unassigned_bus_resources(root->bus);
+	}
+
+	mutex_lock(&acpi_pci_root_lock);
+	list_for_each_entry(driver, &acpi_pci_drivers, node)
+		if (driver->add)
+			driver->add(root);
+	mutex_unlock(&acpi_pci_root_lock);
+
+	/* need to after hot-added ioapic is registered */
+	if (system_state != SYSTEM_BOOTING)
+		pci_enable_bridges(root->bus);
+
 	return 0;
 
 out_del_root:
@@ -621,22 +637,7 @@ end:
 static int acpi_pci_root_start(struct acpi_device *device)
 {
 	struct acpi_pci_root *root = acpi_driver_data(device);
-	struct acpi_pci_driver *driver;
-
-	if (system_state != SYSTEM_BOOTING) {
-		pcibios_resource_survey_bus(root->bus);
-		pci_assign_unassigned_bus_resources(root->bus);
-	}
 
-	mutex_lock(&acpi_pci_root_lock);
-	list_for_each_entry(driver, &acpi_pci_drivers, node)
-		if (driver->add)
-			driver->add(root);
-	mutex_unlock(&acpi_pci_root_lock);
-
-	/* need to after hot-added ioapic is registered */
-	if (system_state != SYSTEM_BOOTING)
-		pci_enable_bridges(root->bus);
 
 	pci_bus_add_devices(root->bus);
 
-- 
1.7.7

