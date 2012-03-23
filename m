Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [RFC PATCH 06/11] ACPI,PCI: update ACPI<->PCI binding information when pci hotplug event happens
Date: Fri, 23 Mar 2012 22:58:22 +0800
Message-Id: <1332514707-9673-7-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com>
References: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When PCI hotplug event happens, the ACPI<->PCI binding relationship should be
updated. Otherwise the binding relationship may become stale and cause invalid
data access or wrong searching results. For example, thinking about following
sequences:
1. Function acpi_pci_bind() installs an ACPI PME event hanlder for the original
   PCI device (orig_device).
2. The orignal PCI device is replaced by a new PCI device, so orig_device
   destroyed and a new_device created.
3. The new PCI device triggers an ACPI PME event.
4. The registered PME event handle pci_acpi_wake_dev() still tries to access
   the orig_device, which may have already been released now.
5. Invalid memory access or event memory corruption.

The solution here is to update the binding relationship when PCI hotplug
event happens.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/acpi/pci_bind.c |  115 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 115 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
index 2ef0409..1dd6379 100644
--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
@@ -118,3 +118,118 @@ int acpi_pci_bind_root(struct acpi_device *device)
 
 	return 0;
 }
+
+static struct acpi_device *
+acpi_pci_bind_notify_check(struct pci_dev *pci_dev)
+{
+	acpi_handle handle;
+	struct acpi_device *device;
+
+	handle = DEVICE_ACPI_HANDLE(&pci_dev->dev);
+	if (handle == NULL || acpi_bus_get_device(handle, &device))
+		return NULL;
+
+	if (device && device->parent && device->parent->ops.bind) 
+		return device;
+
+	return NULL;
+}
+
+static void acpi_pci_bind_notify_dev_add(struct pci_dev *pci_dev)
+{
+	struct acpi_device *device;
+
+	device = acpi_pci_bind_notify_check(pci_dev);
+	if (device) {
+		pci_acpi_add_pm_notifier(device, pci_dev);
+		if (device->wakeup.flags.run_wake)
+			device_set_run_wake(&pci_dev->dev, true);
+	}
+}
+
+static void acpi_pci_bind_notify_dev_remove(struct pci_dev *pci_dev)
+{
+	struct acpi_device *device;
+
+	device = acpi_pci_bind_notify_check(pci_dev);
+	if (device) {
+		device_set_run_wake(&pci_dev->dev, false);
+		pci_acpi_remove_pm_notifier(device);
+	}
+}
+
+static void acpi_pci_bind_notify_bus_add(struct pci_bus *bus)
+{
+	acpi_handle handle;
+	struct acpi_device *device;
+
+	/* Skip root buses */
+	if (!bus->self)
+		return;
+
+	device = acpi_pci_bind_notify_check(bus->self);
+	if (device) {
+		/*
+		 * Install the 'bind' function to facilitate callbacks for
+		 * children of the P2P bridge.
+		 */
+		device->ops.bind = acpi_pci_bind;
+		device->ops.unbind = acpi_pci_unbind;
+
+		/* Evaluate and parse _PRT, if exists. */
+		if (ACPI_SUCCESS(acpi_get_handle(device->handle,
+						 METHOD_NAME__PRT, &handle)))
+			acpi_pci_irq_add_prt(device->handle, bus);
+	}
+}
+
+static void acpi_pci_bind_notify_bus_remove(struct pci_bus *bus)
+{
+	struct acpi_device *device;
+
+	/* Skip root buses */
+	if (!bus->self)
+		return;
+
+	device = acpi_pci_bind_notify_check(bus->self);
+	if (device) {
+		acpi_pci_irq_del_prt(bus);
+
+		device->ops.bind = NULL;
+		device->ops.unbind = NULL;
+	}
+}
+
+static int acpi_pci_bind_notify_fn(struct notifier_block *nb,
+				   unsigned long event, void *data)
+{
+	switch (event) {
+	case PCI_HP_EVENT_DEV_ADD:
+		acpi_pci_bind_notify_dev_add(data);
+		break;
+	case PCI_HP_EVENT_DEV_REMOVE:
+		acpi_pci_bind_notify_dev_remove(data);
+		break;
+	case PCI_HP_EVENT_BUS_ADD:
+		acpi_pci_bind_notify_bus_add(data);
+		break;
+	case PCI_HP_EVENT_BUS_REMOVE:
+		acpi_pci_bind_notify_bus_remove(data);
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block acpi_pci_bind_notifier = {
+	.notifier_call = &acpi_pci_bind_notify_fn,
+};
+
+static int __init acpi_pci_bind_init(void)
+{
+	return pci_register_hotplug_notifier(&acpi_pci_bind_notifier);
+}
+
+subsys_initcall(acpi_pci_bind_init);
-- 
1.7.5.4

