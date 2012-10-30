Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1050.oracle.com ([156.151.31.82]:50995 "EHLO
	userp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965022Ab2J3RpY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Oct 2012 13:45:24 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 4/8] PCI, ACPI: assign unassigned resource for hot add root bus
Date: Tue, 30 Oct 2012 10:42:41 -0700
Message-Id: <1351618965-16761-5-git-send-email-yinghai@kernel.org>
In-Reply-To: <1351618965-16761-1-git-send-email-yinghai@kernel.org>
References: <20121030040237.GA10472@google.com>
 <1351618965-16761-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

After we get hot-added ioapic registered.
pci_enable_bridges will try to enable ioapic irq for pci bridges.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/acpi/pci_root.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index bce469c..27adbfd 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -644,12 +644,19 @@ static int acpi_pci_root_start(struct acpi_device *device)
 	struct acpi_pci_root *root = acpi_driver_data(device);
 	struct acpi_pci_driver *driver;
 
+	if (system_state != SYSTEM_BOOTING)
+		pci_assign_unassigned_bus_resources(root->bus);
+
 	mutex_lock(&acpi_pci_root_lock);
 	list_for_each_entry(driver, &acpi_pci_drivers, node)
 		if (driver->add)
 			driver->add(root);
 	mutex_unlock(&acpi_pci_root_lock);
 
+	/* need to after hot-added ioapic is registered */
+	if (system_state != SYSTEM_BOOTING)
+		pci_enable_bridges(root->bus);
+
 	pci_bus_add_devices(root->bus);
 
 	return 0;
-- 
1.7.7

