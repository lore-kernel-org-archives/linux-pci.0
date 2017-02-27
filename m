Return-Path: <SRS0=KDlv=2I=intel.com=rui.y.wang@kernel.org>
Return-Path: <SRS0=KDlv=2I=intel.com=rui.y.wang@kernel.org>
From: Rui Wang <rui.y.wang@intel.com>
To: helgaas@kernel.org,
	tglx@linutronix.de,
	rjw@rjwysocki.net
Cc: tony.luck@intel.com,
	bhelgaas@google.com,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rui.y.wang@intel.com,
	x86@kernel.org
Subject: [PATCH 2/2] x86/ioapic: Split IOAPIC hot-removal into two steps
Date: Mon, 27 Feb 2017 22:15:44 +0800
Message-Id: <1488204944-27189-3-git-send-email-rui.y.wang@intel.com>
In-Reply-To: <1488204944-27189-1-git-send-email-rui.y.wang@intel.com>
References: <1488204944-27189-1-git-send-email-rui.y.wang@intel.com>
List-ID: <linux-pci.vger.kernel.org>

The hot-removal of IOAPIC is broken into two parts: the PCI part and
the ACPI part. The PCI part releases PCI resources before the PCI bus
is gone, and the ACPI part is moved to a stage later than the hot-removal
of the PCI root bus, so that the IOAPIC driver is able to hook the
pcibios_release_device() of every PCI device under the same parent root
bus, before the IOAPIC is hot-removed. This makes it possible for the
IOAPIC to free any IRQ resource previously unable to get freed.

Signed-off-by: Rui Wang <rui.y.wang@intel.com>
---
 drivers/acpi/internal.h |  1 +
 drivers/acpi/ioapic.c   | 22 ++++++++++++++++------
 drivers/acpi/pci_root.c |  4 ++--
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 219b90b..b2e3416 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -41,6 +41,7 @@ static inline void acpi_amba_init(void) {}
 void acpi_container_init(void);
 void acpi_memory_hotplug_init(void);
 #ifdef	CONFIG_ACPI_HOTPLUG_IOAPIC
+void pci_ioapic_remove(struct acpi_pci_root *root);
 int acpi_ioapic_remove(struct acpi_pci_root *root);
 #else
 static inline int acpi_ioapic_remove(struct acpi_pci_root *root) { return 0; }
diff --git a/drivers/acpi/ioapic.c b/drivers/acpi/ioapic.c
index 6d7ce6e..1120dfd6 100644
--- a/drivers/acpi/ioapic.c
+++ b/drivers/acpi/ioapic.c
@@ -206,24 +206,34 @@ int acpi_ioapic_add(acpi_handle root_handle)
 	return ACPI_SUCCESS(status) && ACPI_SUCCESS(retval) ? 0 : -ENODEV;
 }
 
-int acpi_ioapic_remove(struct acpi_pci_root *root)
+void pci_ioapic_remove(struct acpi_pci_root *root)
 {
-	int retval = 0;
 	struct acpi_pci_ioapic *ioapic, *tmp;
 
 	mutex_lock(&ioapic_list_lock);
 	list_for_each_entry_safe(ioapic, tmp, &ioapic_list, list) {
 		if (root->device->handle != ioapic->root_handle)
 			continue;
-
-		if (acpi_unregister_ioapic(ioapic->handle, ioapic->gsi_base))
-			retval = -EBUSY;
-
 		if (ioapic->pdev) {
 			pci_release_region(ioapic->pdev, 0);
 			pci_disable_device(ioapic->pdev);
 			pci_dev_put(ioapic->pdev);
 		}
+	}
+	mutex_unlock(&ioapic_list_lock);
+}
+
+int acpi_ioapic_remove(struct acpi_pci_root *root)
+{
+	int retval = 0;
+	struct acpi_pci_ioapic *ioapic, *tmp;
+
+	mutex_lock(&ioapic_list_lock);
+	list_for_each_entry_safe(ioapic, tmp, &ioapic_list, list) {
+		if (root->device->handle != ioapic->root_handle)
+			continue;
+		if (acpi_unregister_ioapic(ioapic->handle, ioapic->gsi_base))
+			retval = -EBUSY;
 		if (ioapic->res.flags && ioapic->res.parent)
 			release_resource(&ioapic->res);
 		list_del(&ioapic->list);
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index bf601d4..919be0a 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -648,12 +648,12 @@ static void acpi_pci_root_remove(struct acpi_device *device)
 
 	pci_stop_root_bus(root->bus);
 
-	WARN_ON(acpi_ioapic_remove(root));
-
+	pci_ioapic_remove(root);
 	device_set_run_wake(root->bus->bridge, false);
 	pci_acpi_remove_bus_pm_notifier(device);
 
 	pci_remove_root_bus(root->bus);
+	WARN_ON(acpi_ioapic_remove(root));
 
 	dmar_device_remove(device->handle);
 
-- 
1.8.3.1
