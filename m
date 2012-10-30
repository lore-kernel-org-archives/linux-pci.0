Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:26208 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964822Ab2J3RnY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Oct 2012 13:43:24 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 7/8] PCI, ACPI: delete root bus prt during hot remove path
Date: Tue, 30 Oct 2012 10:42:44 -0700
Message-Id: <1351618965-16761-8-git-send-email-yinghai@kernel.org>
In-Reply-To: <1351618965-16761-1-git-send-email-yinghai@kernel.org>
References: <20121030040237.GA10472@google.com>
 <1351618965-16761-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

corresponding to add path.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/acpi/pci_root.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index aed0953..a27cbb57 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -664,6 +664,8 @@ static int acpi_pci_root_start(struct acpi_device *device)
 
 static int acpi_pci_root_remove(struct acpi_device *device, int type)
 {
+	acpi_status status;
+	acpi_handle handle;
 	struct acpi_pci_root *root = acpi_driver_data(device);
 	struct acpi_pci_driver *driver;
 
@@ -678,6 +680,10 @@ static int acpi_pci_root_remove(struct acpi_device *device, int type)
 	device_set_run_wake(root->bus->bridge, false);
 	pci_acpi_remove_bus_pm_notifier(device);
 
+	status = acpi_get_handle(device->handle, METHOD_NAME__PRT, &handle);
+	if (ACPI_SUCCESS(status))
+		acpi_pci_irq_del_prt(root->bus);
+
 	pci_remove_root_bus(root->bus);
 
 	mutex_lock(&acpi_pci_root_lock);
-- 
1.7.7

