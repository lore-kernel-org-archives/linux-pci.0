Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v7 06/12] PCI: Request control of native SHPC hotplug similarly to pciehp
Date: Thu, 17 May 2018 12:28:57 +0300
Message-Id: <20180517092903.43701-7-mika.westerberg@linux.intel.com>
In-Reply-To: <20180517092903.43701-1-mika.westerberg@linux.intel.com>
References: <20180517092903.43701-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that the SHPC driver is converted to builtin we can change the way
SHPC control is requested to follow more closely what we do for pciehp.
We then take advantege of the newly introduced host->native_shpc_hotplug
in acpi_get_hp_hw_control_from_firmware() to determine whether OSHP
needs to be evaluated.

In addition provide two new functions that can be used to query whether
native SHPC driver is expected to handle hotplug of a given bridge or
not, following what we do for pciehp.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/pci_root.c           |  4 ++++
 drivers/pci/hotplug/acpi_pcihp.c  | 34 +++++++++++--------------------
 drivers/pci/hotplug/shpchp.h      | 11 ----------
 drivers/pci/hotplug/shpchp_core.c |  2 +-
 drivers/pci/pci-acpi.c            | 21 +++++++++++++++++++
 drivers/pci/probe.c               |  1 +
 include/linux/pci.h               |  1 +
 include/linux/pci_hotplug.h       | 15 +++++++++++++-
 8 files changed, 54 insertions(+), 35 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 02ab96f00952..da04502b4c0b 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -477,6 +477,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 
 	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
 		control |= OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
+	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
+		control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
 	if (pci_aer_available()) {
 		if (aer_acpi_firmware_first())
 			dev_info(&device->dev,
@@ -903,6 +905,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	host_bridge = to_pci_host_bridge(bus->bridge);
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
 		host_bridge->native_pcie_hotplug = 0;
+	if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
+		host_bridge->native_shpc_hotplug = 0;
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_AER_CONTROL))
 		host_bridge->native_aer = 0;
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_PME_CONTROL))
diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
index c9816166978e..678c03944bb7 100644
--- a/drivers/pci/hotplug/acpi_pcihp.c
+++ b/drivers/pci/hotplug/acpi_pcihp.c
@@ -62,23 +62,18 @@ static acpi_status acpi_run_oshp(acpi_handle handle)
 
 /**
  * acpi_get_hp_hw_control_from_firmware
- * @dev: the pci_dev of the bridge that has a hotplug controller
- * @flags: requested control bits for _OSC
+ * @pdev: the pci_dev of the bridge that has a hotplug controller
  *
  * Attempt to take hotplug control from firmware.
  */
-int acpi_get_hp_hw_control_from_firmware(struct pci_dev *pdev, u32 flags)
+int acpi_get_hp_hw_control_from_firmware(struct pci_dev *pdev)
 {
+	const struct pci_host_bridge *host;
+	const struct acpi_pci_root *root;
 	acpi_status status;
 	acpi_handle chandle, handle;
 	struct acpi_buffer string = { ACPI_ALLOCATE_BUFFER, NULL };
 
-	flags &= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
-	if (!flags) {
-		err("Invalid flags %u specified!\n", flags);
-		return -EINVAL;
-	}
-
 	/*
 	 * Per PCI firmware specification, we should run the ACPI _OSC
 	 * method to get control of hotplug hardware before using it. If
@@ -88,19 +83,14 @@ int acpi_get_hp_hw_control_from_firmware(struct pci_dev *pdev, u32 flags)
 	 * OSHP within the scope of the hotplug controller and its parents,
 	 * up to the host bridge under which this controller exists.
 	 */
-	handle = acpi_find_root_bridge_handle(pdev);
-	if (handle) {
-		acpi_get_name(handle, ACPI_FULL_PATHNAME, &string);
-		dbg("Trying to get hotplug control for %s\n",
-				(char *)string.pointer);
-		status = acpi_pci_osc_control_set(handle, &flags, flags);
-		if (ACPI_SUCCESS(status))
-			goto got_one;
-		if (status == AE_SUPPORT)
-			goto no_control;
-		kfree(string.pointer);
-		string = (struct acpi_buffer){ ACPI_ALLOCATE_BUFFER, NULL };
-	}
+	host = pci_find_host_bridge(pdev->bus);
+	if (host->native_shpc_hotplug)
+		return 0;
+
+	/* If the there is _OSC we should not evaluate OSHP */
+	root = acpi_pci_find_root(ACPI_HANDLE(&host->dev));
+	if (root->osc_support_set)
+		goto no_control;
 
 	handle = ACPI_HANDLE(&pdev->dev);
 	if (!handle) {
diff --git a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
index c55730b61c9a..9675ab757323 100644
--- a/drivers/pci/hotplug/shpchp.h
+++ b/drivers/pci/hotplug/shpchp.h
@@ -173,17 +173,6 @@ static inline const char *slot_name(struct slot *slot)
 	return hotplug_slot_name(slot->hotplug_slot);
 }
 
-#ifdef CONFIG_ACPI
-#include <linux/pci-acpi.h>
-static inline int get_hp_hw_control_from_firmware(struct pci_dev *dev)
-{
-	u32 flags = OSC_PCI_SHPC_NATIVE_HP_CONTROL;
-	return acpi_get_hp_hw_control_from_firmware(dev, flags);
-}
-#else
-#define get_hp_hw_control_from_firmware(dev) (0)
-#endif
-
 struct ctrl_reg {
 	volatile u32 base_offset;
 	volatile u32 slot_avail1;
diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index 1f0f96908b5a..47decc9b3bb3 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -277,7 +277,7 @@ static int is_shpc_capable(struct pci_dev *dev)
 		return 1;
 	if (!pci_find_capability(dev, PCI_CAP_ID_SHPC))
 		return 0;
-	if (get_hp_hw_control_from_firmware(dev))
+	if (acpi_get_hp_hw_control_from_firmware(dev))
 		return 0;
 	return 1;
 }
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 2fd96d008960..f3ed699108bf 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -394,6 +394,27 @@ bool pciehp_is_native(struct pci_dev *bridge)
 	return host->native_pcie_hotplug;
 }
 
+/**
+ * shpchp_is_native - Check whether a hotplug port is handled by the OS
+ * @bridge: Hotplug port to check
+ *
+ * Returns true if the given @bridge is handled by the native SHPC hotplug
+ * driver.
+ */
+bool shpchp_is_native(struct pci_dev *bridge)
+{
+	const struct pci_host_bridge *host;
+
+	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC) || !bridge)
+		return false;
+
+	if (!pci_find_capability(bridge, PCI_CAP_ID_SHPC))
+		return false;
+
+	host = pci_find_host_bridge(bridge->bus);
+	return host->native_shpc_hotplug;
+}
+
 /**
  * pci_acpi_wake_bus - Root bus wakeup notification fork function.
  * @context: Device wakeup context.
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a6c3b8d30f8f..cd28ab122748 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -553,6 +553,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 	 */
 	bridge->native_aer = 1;
 	bridge->native_pcie_hotplug = 1;
+	bridge->native_shpc_hotplug = 1;
 	bridge->native_pme = 1;
 
 	return bridge;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2f6689a14e8d..038c6d2d4ff4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -472,6 +472,7 @@ struct pci_host_bridge {
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */
 	unsigned int	native_aer:1;		/* OS may use PCIe AER */
 	unsigned int	native_pcie_hotplug:1;	/* OS may use PCIe hotplug */
+	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
 	unsigned int	native_pme:1;		/* OS may use PCIe PME */
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index 3f32575d1ce8..a8b1b99adb45 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -163,7 +163,8 @@ struct hotplug_params {
 #include <linux/acpi.h>
 int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp);
 bool pciehp_is_native(struct pci_dev *bridge);
-int acpi_get_hp_hw_control_from_firmware(struct pci_dev *dev, u32 flags);
+bool shpchp_is_native(struct pci_dev *bridge);
+int acpi_get_hp_hw_control_from_firmware(struct pci_dev *bridge);
 int acpi_pci_check_ejectable(struct pci_bus *pbus, acpi_handle handle);
 int acpi_pci_detect_ejectable(acpi_handle handle);
 #else
@@ -173,5 +174,17 @@ static inline int pci_get_hp_params(struct pci_dev *dev,
 	return -ENODEV;
 }
 static inline bool pciehp_is_native(struct pci_dev *bridge) { return true; }
+static inline bool shpchp_is_native(struct pci_dev *bridge) { return true; }
+
+static inline int acpi_get_hp_hw_control_from_firmware(struct pci_dev *bridge)
+{
+	return 0;
+}
 #endif
+
+static inline bool hotplug_is_native(struct pci_dev *bridge)
+{
+	return pciehp_is_native(bridge) || shpchp_is_native(bridge);
+}
+
 #endif
-- 
2.17.0

