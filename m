Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Rui Wang <rui.y.wang@intel.com>
To: tglx@linutronix.de, rjw@rjwysocki.net, tony.luck@intel.com,
	bhelgaas@google.com
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rui.y.wang@intel.com
Subject: [PATCH 1/2] x86/ioapic: Support hot-removal of IOAPICs present during boot
Date: Tue,  7 Jun 2016 15:21:12 +0800
Message-Id: <1465284073-354-2-git-send-email-rui.y.wang@intel.com>
In-Reply-To: <1465284073-354-1-git-send-email-rui.y.wang@intel.com>
References: <1465284073-354-1-git-send-email-rui.y.wang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

IOAPICs present during system boot aren't added to ioapic_list,
thus are unable to be hot-removed. Fix it by calling
acpi_ioapic_add() during root bus enumeration.

Signed-off-by: Rui Wang <rui.y.wang@intel.com>
---
 drivers/acpi/internal.h | 2 --
 drivers/acpi/ioapic.c   | 7 ++++---
 drivers/acpi/pci_root.c | 2 +-
 drivers/pci/setup-bus.c | 5 ++++-
 include/linux/acpi.h    | 3 +++
 5 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 1e6833a..898f314 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -33,10 +33,8 @@ int acpi_sysfs_init(void);
 void acpi_container_init(void);
 void acpi_memory_hotplug_init(void);
 #ifdef	CONFIG_ACPI_HOTPLUG_IOAPIC
-int acpi_ioapic_add(struct acpi_pci_root *root);
 int acpi_ioapic_remove(struct acpi_pci_root *root);
 #else
-static inline int acpi_ioapic_add(struct acpi_pci_root *root) { return 0; }
 static inline int acpi_ioapic_remove(struct acpi_pci_root *root) { return 0; }
 #endif
 #ifdef CONFIG_ACPI_DOCK
diff --git a/drivers/acpi/ioapic.c b/drivers/acpi/ioapic.c
index ccdc8db..0f272e2 100644
--- a/drivers/acpi/ioapic.c
+++ b/drivers/acpi/ioapic.c
@@ -189,16 +189,17 @@ exit:
 	return AE_OK;
 }
 
-int acpi_ioapic_add(struct acpi_pci_root *root)
+int acpi_ioapic_add(acpi_handle root_handle)
 {
 	acpi_status status, retval = AE_OK;
 
-	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, root->device->handle,
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, root_handle,
 				     UINT_MAX, handle_ioapic_add, NULL,
-				     root->device->handle, (void **)&retval);
+				     root_handle, (void **)&retval);
 
 	return ACPI_SUCCESS(status) && ACPI_SUCCESS(retval) ? 0 : -ENODEV;
 }
+EXPORT_SYMBOL_GPL(acpi_ioapic_add);
 
 int acpi_ioapic_remove(struct acpi_pci_root *root)
 {
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index ae3fe4e..53f5965 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -614,7 +614,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
 	if (hotadd) {
 		pcibios_resource_survey_bus(root->bus);
 		pci_assign_unassigned_root_bus_resources(root->bus);
-		acpi_ioapic_add(root);
+		acpi_ioapic_add(root->device->handle);
 	}
 
 	pci_lock_rescan_remove();
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7796d0a..2f71167 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -26,6 +26,7 @@
 #include <linux/cache.h>
 #include <linux/slab.h>
 #include <asm-generic/pci-bridge.h>
+#include <linux/acpi.h>
 #include "pci.h"
 
 unsigned int pci_flags;
@@ -1780,8 +1781,10 @@ void __init pci_assign_unassigned_resources(void)
 {
 	struct pci_bus *root_bus;
 
-	list_for_each_entry(root_bus, &pci_root_buses, node)
+	list_for_each_entry(root_bus, &pci_root_buses, node) {
 		pci_assign_unassigned_root_bus_resources(root_bus);
+		acpi_ioapic_add(ACPI_HANDLE(root_bus->bridge));
+	}
 }
 
 void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 06ed7e5..ca4d22f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -269,6 +269,9 @@ int acpi_unmap_cpu(int cpu);
 
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
 int acpi_get_ioapic_id(acpi_handle handle, u32 gsi_base, u64 *phys_addr);
+int acpi_ioapic_add(acpi_handle root);
+#else
+static inline int acpi_ioapic_add(acpi_handle root) { return 0; }
 #endif
 
 int acpi_register_ioapic(acpi_handle handle, u64 phys_addr, u32 gsi_base);
-- 
1.8.3.1

