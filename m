Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:31265 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381Ab2JBGdK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2012 02:33:10 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 02/10] ACPI: use device drivers_autoprobe to delay loading acpi drivers
Date: Mon,  1 Oct 2012 23:33:00 -0700
Message-Id: <1349159588-15029-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current acpi driver for pci_root is working like this way for hotplug:

	acpi try to enumberate acpi device and create acpi_device for pci_root
	and loading driver for it, and that drivers .add aka acpi_pci_root_add
	calls pci_acpi_scan_root to enumerate pci devices but not add those pci
	devices into device tree to prevent drivers for pci devices get probed.

	Later .start aka acpi_pci_root_start will call pci_bus_add_devices to
	add pci devices into the tree to make drivers for pci devices get
	attached or probed.

The reason for that .add must get back for pci_root, so could create acpi_device
for other pci_devices. otherwise adding the pci device tree early than
acpi_device will cause binding for acpi/pci failing becuse pci_device can not find acpi_dev that is not created yet.

booting path is working becasue driver for acpi driver is registered later,
that means all acpi_device get created at first, and later when acpi_driver
get registered, and .add get called, that probe pci devices, when pci devices
is found, it could find acpi_device and binding will be ok, even
pci_add_bus_devices in done in acpi_pci_root_add.

That .start design is broken, and it will leave pci devices out of device tree
for a while.

We could use device drivers_autoprobe and acpi_bus_type notifier to control
the process to make sure for hot adding path, will have all acpi_device get
created, then attach acpi driver for acpi_device for pci_root.
That will make the path more like booting path.

After that we could remove the workaround .start in acpi driver ops.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/acpi/scan.c |   48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 5dfec09..67785da 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1451,6 +1451,20 @@ static int acpi_bus_scan(acpi_handle handle, struct acpi_bus_ops *ops,
 		return -ENODEV;
 }
 
+static void acpi_bus_attach(struct acpi_device *dev)
+{
+	struct acpi_device *child;
+	int ret;
+
+	ret = device_attach(&dev->dev);
+	/* make rescan working ? */
+	dev->dev.drivers_autoprobe = true;
+	WARN_ON(ret < 0);
+
+	list_for_each_entry(child, &dev->children, node)
+		acpi_bus_attach(child);
+}
+
 /*
  * acpi_bus_add and acpi_bus_start
  *
@@ -1468,11 +1482,17 @@ acpi_bus_add(struct acpi_device **child,
 	     struct acpi_device *parent, acpi_handle handle, int type)
 {
 	struct acpi_bus_ops ops;
+	int result;
 
 	memset(&ops, 0, sizeof(ops));
 	ops.acpi_op_add = 1;
 
-	return acpi_bus_scan(handle, &ops, child);
+	result = acpi_bus_scan(handle, &ops, child);
+
+	if (*child)
+		acpi_bus_attach(*child);
+
+	return result;
 }
 EXPORT_SYMBOL(acpi_bus_add);
 
@@ -1610,3 +1630,29 @@ int __init acpi_scan_init(void)
 
 	return result;
 }
+
+static int acpi_hp_notifier(struct notifier_block *nb,
+				 unsigned long event, void *data)
+{
+	struct device *dev = data;
+
+	switch (event) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		dev->drivers_autoprobe = false;
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block acpi_hp_nb = {
+	.notifier_call = &acpi_hp_notifier,
+};
+
+static int __init acpi_hp_init(void)
+{
+	return bus_register_notifier(&acpi_bus_type,
+					 &acpi_hp_nb);
+}
+
+fs_initcall(acpi_hp_init);
-- 
1.7.7

