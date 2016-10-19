Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:44441 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbcJSOKX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2016 10:10:23 -0400
Message-Id: <8cdc97858833c5925f1226084dd2cd9d98e92fb0.1476875113.git.lukas@wunner.de>
In-Reply-To: <cover.1476875113.git.lukas@wunner.de>
References: <cover.1476875113.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 19 Oct 2016 16:07:13 +0200
Subject: [PATCH 8/9] ACPI / hotplug / PCI: Make
 device_is_managed_by_native_pciehp() public
To: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Keith Busch <keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We're about to add runtime PM of hotplug ports, but we need to restrict
it to ports that are handled natively by the OS:  If they're handled by
the firmware (which is the case for Thunderbolt on non-Macs), things
would break if the OS put the ports into D3hot behind the firmware's
back.

To determine if a hotplug port is handled natively, one has to walk up
from the port to the root bridge and check the cached _OSC Control Field
for the value of the "PCI Express Native Hot Plug control" bit.  There's
already a function to do that, device_is_managed_by_native_pciehp(),
but it's private to drivers/pci/hotplug/acpiphp_glue.c and only compiled
in if CONFIG_HOTPLUG_PCI_ACPI is enabled.

Make it public and move it to drivers/pci/pci-acpi.c, so that it is
available in the more general CONFIG_ACPI case.

The function contains a check if the device in question is a hotplug
port and returns false if it's not.  The caller we're going to add
doesn't need this as it only calls the function if it actually *is* a
hotplug port.  Move the check out of the function into the single
existing caller.

Give the function a shorter name and add some kerneldoc and polish.

No functional change intended.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/acpiphp_glue.c | 28 +---------------------------
 drivers/pci/pci-acpi.c             | 24 ++++++++++++++++++++++++
 include/linux/pci_hotplug.h        |  2 ++
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index b286a56..5ed2dca 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -222,32 +222,6 @@ static void acpiphp_post_dock_fixup(struct acpi_device *adev)
 	acpiphp_let_context_go(context);
 }
 
-/* Check whether the PCI device is managed by native PCIe hotplug driver */
-static bool device_is_managed_by_native_pciehp(struct pci_dev *pdev)
-{
-	acpi_handle tmp;
-	struct acpi_pci_root *root;
-
-	/* Check whether the PCIe port supports native PCIe hotplug */
-	if (!pdev->is_hotplug_bridge)
-		return false;
-
-	/*
-	 * Check whether native PCIe hotplug has been enabled for
-	 * this PCIe hierarchy.
-	 */
-	tmp = acpi_find_root_bridge_handle(pdev);
-	if (!tmp)
-		return false;
-	root = acpi_pci_find_root(tmp);
-	if (!root)
-		return false;
-	if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
-		return false;
-
-	return true;
-}
-
 /**
  * acpiphp_add_context - Add ACPIPHP context to an ACPI device object.
  * @handle: ACPI handle of the object to add a context to.
@@ -331,7 +305,7 @@ static acpi_status acpiphp_add_context(acpi_handle handle, u32 lvl, void *data,
 	 * expose slots to user space in those cases.
 	 */
 	if ((acpi_pci_check_ejectable(pbus, handle) || is_dock_device(adev))
-	    && !(pdev && device_is_managed_by_native_pciehp(pdev))) {
+	    && !(pdev && pdev->is_hotplug_bridge && pciehp_is_native(pdev))) {
 		unsigned long long sun;
 		int retval;
 
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index d966d47..ed3daa8 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -294,6 +294,30 @@ int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp)
 EXPORT_SYMBOL_GPL(pci_get_hp_params);
 
 /**
+ * pciehp_is_native - Check whether a hotplug port is handled by the OS
+ * @pdev: Hotplug port to check
+ *
+ * Walk up from @pdev to the host bridge, obtain its cached _OSC Control Field
+ * and return the value of the "PCI Express Native Hot Plug control" bit.
+ * On failure to obtain the _OSC Control Field return %false.
+ */
+bool pciehp_is_native(struct pci_dev *pdev)
+{
+	struct acpi_pci_root *root;
+	acpi_handle handle;
+
+	handle = acpi_find_root_bridge_handle(pdev);
+	if (!handle)
+		return false;
+
+	root = acpi_pci_find_root(handle);
+	if (!root)
+		return false;
+
+	return root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
+}
+
+/**
  * pci_acpi_wake_bus - Root bus wakeup notification fork function.
  * @work: Work item to handle.
  */
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index 8c78950..2e855af 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -176,6 +176,7 @@ struct hotplug_params {
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
 int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp);
+bool pciehp_is_native(struct pci_dev *pdev);
 int acpi_get_hp_hw_control_from_firmware(struct pci_dev *dev, u32 flags);
 int acpi_pci_check_ejectable(struct pci_bus *pbus, acpi_handle handle);
 int acpi_pci_detect_ejectable(acpi_handle handle);
@@ -185,5 +186,6 @@ static inline int pci_get_hp_params(struct pci_dev *dev,
 {
 	return -ENODEV;
 }
+static inline bool pciehp_is_native(struct pci_dev *pdev) { return true; }
 #endif
 #endif
-- 
2.9.3

