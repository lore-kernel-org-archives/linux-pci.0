Return-Path: <rui.y.wang@intel.com>
Return-Path: <rui.y.wang@intel.com>
From: Rui Wang <rui.y.wang@intel.com>
To: helgaas@kernel.org,
	tglx@linutronix.de,
	rjw@rjwysocki.net
Cc: tony.luck@intel.com,
	bhelgaas@google.com,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rui.y.wang@intel.com
Subject: [PATCH v3 1/5] x86/ioapic: Change prototype of acpi_ioapic_add()
Date: Wed, 10 Aug 2016 12:01:54 +0800
Message-Id: <1470801718-29004-2-git-send-email-rui.y.wang@intel.com>
In-Reply-To: <1470801718-29004-1-git-send-email-rui.y.wang@intel.com>
References: <1470801718-29004-1-git-send-email-rui.y.wang@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Change the argument of acpi_ioapic_add() to a generic ACPI handle, and
move its prototype from drivers/acpi/internal.h to include/linux/acpi.h
so that it can be called from outside the pci_root driver.

Signed-off-by: Rui Wang <rui.y.wang@intel.com>
---
 drivers/acpi/internal.h | 2 --
 drivers/acpi/ioapic.c   | 6 +++---
 drivers/acpi/pci_root.c | 2 +-
 include/linux/acpi.h    | 6 ++++++
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 940218f..f26fc1d 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -40,10 +40,8 @@ int acpi_sysfs_init(void);
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
index ccdc8db..2449377 100644
--- a/drivers/acpi/ioapic.c
+++ b/drivers/acpi/ioapic.c
@@ -189,13 +189,13 @@ exit:
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
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index d144168..b07eda1 100644
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
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4d8452c..c9a596b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -751,6 +751,12 @@ static inline int acpi_reconfig_notifier_unregister(struct notifier_block *nb)
 
 #endif	/* !CONFIG_ACPI */
 
+#ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
+int acpi_ioapic_add(acpi_handle root);
+#else
+static inline int acpi_ioapic_add(acpi_handle root) { return 0; }
+#endif
+
 #ifdef CONFIG_ACPI
 void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state,
 			       u32 pm1a_ctrl,  u32 pm1b_ctrl));
-- 
1.8.3.1
