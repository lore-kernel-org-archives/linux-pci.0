Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:31269 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389Ab2JBGdK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2012 02:33:10 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 03/10] PCI: prepare to use device drivers_autoprobe to delay attach drivers
Date: Mon,  1 Oct 2012 23:33:01 -0700
Message-Id: <1349159588-15029-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now pci enumerate the pci devices later and later use pci_bus_add_devices to
add them to devices and probe pci devices.

The reason for that two steps, want to do pci_assign_unassigned_resources
for hot add pci devices before pci drivers get loaded.

That step would leave pci devices out of devices tree for a while, and we
can not use bus iterator to loop pci devices.

We could device drivers_autoprobe and pci_bus_type notifier to delay pci
driver loading instead of keep of pci device out of device tree.

The patch add notifier to split out device attach out of device_add.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/bus.c     |   11 +++++++++++
 drivers/pci/hotplug.c |   25 +++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 6fe2115..3144262 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -160,6 +160,16 @@ pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
 
 void __weak pcibios_resource_survey_bus(struct pci_bus *bus) { }
 
+static void pci_bus_attach_device(struct pci_dev *dev)
+{
+	int ret;
+
+	ret = device_attach(&dev->dev);
+	/* make rescan working ? */
+	dev->dev.drivers_autoprobe = true;
+	WARN_ON(ret < 0);
+}
+
 /**
  * pci_bus_add_device - add a single device
  * @dev: device to add
@@ -176,6 +186,7 @@ int pci_bus_add_device(struct pci_dev *dev)
 	if (retval)
 		return retval;
 
+	pci_bus_attach_device(dev);
 	dev->is_added = 1;
 	pci_proc_attach_device(dev);
 	pci_create_sysfs_dev_files(dev);
diff --git a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
index 2b5352a..3983934 100644
--- a/drivers/pci/hotplug.c
+++ b/drivers/pci/hotplug.c
@@ -35,3 +35,28 @@ int pci_uevent(struct device *dev, struct kobj_uevent_env *env)
 		return -ENOMEM;
 	return 0;
 }
+
+static int pci_hp_notifier(struct notifier_block *nb,
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
+static struct notifier_block pci_hp_nb = {
+	.notifier_call = &pci_hp_notifier,
+};
+
+static int __init pci_hp_init(void)
+{
+	return bus_register_notifier(&pci_bus_type, &pci_hp_nb);
+}
+
+fs_initcall(pci_hp_init);
-- 
1.7.7

