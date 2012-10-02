Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH 09/10] PCI, ACPI: using acpi/pci bind path for pci_host_bridge
Date: Mon,  1 Oct 2012 23:33:07 -0700
Message-Id: <1349159588-15029-10-git-send-email-yinghai@kernel.org>
In-Reply-To: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now pci_dev is using:
	pci_bus_add_device
		==> device_add
			==> platform_notify aka acpi_platform_notify
				==> acpi_bind_one
					==> acpi_pci_bind_notify

pci_host_bridge calling till to acpi_bind_one but not in acpi_pci_bind_notify
because acpi_pci_bind_notify only handle pci_dev.

Extend acpi_pci_bind_notify to handle pci_host_bridge.

After that, We could remove same calling in acpi_pci_root_add and
acpi_pci_root_remove.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/pci_bind.c |   59 +++++++++++++++++++++++++++++++---------------
 drivers/acpi/pci_root.c |   21 ----------------
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
index aac7f9a..b59a5df 100644
--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
@@ -35,33 +35,59 @@
 #define _COMPONENT		ACPI_PCI_COMPONENT
 ACPI_MODULE_NAME("pci_bind");
 
-static int acpi_pci_unbind(struct acpi_device *acpi_dev, struct pci_dev *dev)
+static int acpi_pci_unbind(struct acpi_device *acpi_dev, struct device *dev)
 {
+	struct pci_dev *pdev = NULL;
+	struct pci_bus *bus = NULL;
+
+	if (dev_is_pci(dev)) {
+		pdev = to_pci_dev(dev);
+		if (pdev->subordinate)
+			bus = pdev->subordinate;
+	} else
+			bus = to_pci_host_bridge(dev)->bus;
+
 	if (acpi_dev) {
-		device_set_run_wake(&dev->dev, false);
-		pci_acpi_remove_pm_notifier(acpi_dev);
+		device_set_run_wake(dev, false);
+		if (pdev)
+			pci_acpi_remove_pm_notifier(acpi_dev);
+		else
+			pci_acpi_remove_bus_pm_notifier(acpi_dev);
 	}
 
-	if (dev->subordinate)
-		acpi_pci_irq_del_prt(dev->subordinate);
+	if (bus)
+		acpi_pci_irq_del_prt(bus);
 
 	return 0;
 }
 
-static int acpi_pci_bind(struct acpi_device *acpi_dev, struct pci_dev *dev)
+static int acpi_pci_bind(struct acpi_device *acpi_dev, struct device *dev)
 {
 	acpi_status status;
-	struct pci_bus *bus;
+	struct pci_dev *pdev = NULL;
+	struct pci_bus *bus = NULL;
 	acpi_handle tmp_hdl;
 	acpi_handle handle;
 
+	if (dev_is_pci(dev)) {
+		pdev = to_pci_dev(dev);
+		if (pdev->subordinate)
+			bus = pdev->subordinate;
+		else
+			bus = pdev->bus;
+	} else
+			bus = to_pci_host_bridge(dev)->bus;
+
 	if (acpi_dev) {
-		pci_acpi_add_pm_notifier(acpi_dev, dev);
+		if (pdev)
+			pci_acpi_add_pm_notifier(acpi_dev, pdev);
+		else
+			pci_acpi_add_bus_pm_notifier(acpi_dev, bus);
 		if (acpi_dev->wakeup.flags.run_wake)
-			device_set_run_wake(&dev->dev, true);
+			device_set_run_wake(dev, true);
 		handle = acpi_dev->handle;
 	} else
-		handle = DEVICE_ACPI_HANDLE(&dev->dev);
+		handle = DEVICE_ACPI_HANDLE(dev);
 
 	/*
 	 * Evaluate and parse _PRT, if exists.  This code allows parsing of
@@ -72,13 +98,8 @@ static int acpi_pci_bind(struct acpi_device *acpi_dev, struct pci_dev *dev)
 	 * TBD: Can _PRTs exist within the scope of non-bridge PCI devices?
 	 */
 	status = acpi_get_handle(handle, METHOD_NAME__PRT, &tmp_hdl);
-	if (ACPI_SUCCESS(status)) {
-		if (dev->subordinate)
-			bus = dev->subordinate;
-		else
-			bus = dev->bus;
+	if (ACPI_SUCCESS(status))
 		acpi_pci_irq_add_prt(handle, bus);
-	}
 
 	return 0;
 }
@@ -86,10 +107,10 @@ static int acpi_pci_bind(struct acpi_device *acpi_dev, struct pci_dev *dev)
 void acpi_pci_bind_notify(struct acpi_device *acpi_dev, struct device *dev,
 			  bool bind)
 {
-	if (dev_is_pci(dev)) {
+	if (dev_is_pci(dev) || dev_is_pci_host_bridge(dev)) {
 		if (bind)
-			acpi_pci_bind(acpi_dev, to_pci_dev(dev));
+			acpi_pci_bind(acpi_dev, dev);
 		else
-			acpi_pci_unbind(acpi_dev, to_pci_dev(dev));
+			acpi_pci_unbind(acpi_dev, dev);
 	}
 }
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 8134f72..725ec10 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -505,7 +505,6 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	int result;
 	struct acpi_pci_root *root;
 	struct acpi_pci_driver *driver;
-	acpi_handle handle;
 	u32 flags;
 
 	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
@@ -591,21 +590,8 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 		goto out_del_root;
 	}
 
-	/*
-	 * PCI Routing Table
-	 * -----------------
-	 * Evaluate and parse _PRT, if exists.
-	 */
-	status = acpi_get_handle(device->handle, METHOD_NAME__PRT, &handle);
-	if (ACPI_SUCCESS(status))
-		result = acpi_pci_irq_add_prt(device->handle, root->bus);
-
 	acpi_pci_root_osc_control_set(root);
 
-	pci_acpi_add_bus_pm_notifier(device, root->bus);
-	if (device->wakeup.flags.run_wake)
-		device_set_run_wake(root->bus->bridge, true);
-
 	if (system_state != SYSTEM_BOOTING) {
 		pcibios_resource_survey_bus(root->bus);
 		pci_assign_unassigned_bus_resources(root->bus);
@@ -649,13 +635,6 @@ static int acpi_pci_root_remove(struct acpi_device *device, int type)
 			driver->remove(root);
 	mutex_unlock(&acpi_pci_root_lock);
 
-	device_set_run_wake(root->bus->bridge, false);
-	pci_acpi_remove_bus_pm_notifier(device);
-
-	status = acpi_get_handle(device->handle, METHOD_NAME__PRT, &handle);
-	if (ACPI_SUCCESS(status))
-		acpi_pci_irq_del_prt(root->bus);
-
 	pci_remove_root_bus(root->bus);
 
 	mutex_lock(&acpi_pci_root_lock);
-- 
1.7.7

