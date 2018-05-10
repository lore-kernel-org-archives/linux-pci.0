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
Subject: [PATCH v6 04/12] PCI: Make pciehp_is_native() stricter
Date: Thu, 10 May 2018 21:28:36 +0300
Message-Id: <20180510182844.77349-5-mika.westerberg@linux.intel.com>
In-Reply-To: <20180510182844.77349-1-mika.westerberg@linux.intel.com>
References: <20180510182844.77349-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently pciehp_is_native() returns true for any PCI device in a
hierarchy where _OSC says we can use pciehp. This is not correct because
there may be bridges without PCI_EXP_SLTCAP_HPC capability and those
should be managed by acpiphp instead.

Improve pciehp_is_native() to return true only if the given bridge is
actually expected to be handled by pciehp. In any other case return
false instead to let acpiphp handle those.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pci-acpi.c      | 28 ++++++++++++++++------------
 drivers/pci/pcie/portdrv.h  |  2 --
 include/linux/pci.h         |  2 ++
 include/linux/pci_hotplug.h |  4 ++--
 4 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 1abdbf267c19..d3114f3a7ab8 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -370,26 +370,30 @@ EXPORT_SYMBOL_GPL(pci_get_hp_params);
 
 /**
  * pciehp_is_native - Check whether a hotplug port is handled by the OS
- * @pdev: Hotplug port to check
+ * @bridge: Hotplug port to check
  *
- * Walk up from @pdev to the host bridge, obtain its cached _OSC Control Field
- * and return the value of the "PCI Express Native Hot Plug control" bit.
- * On failure to obtain the _OSC Control Field return %false.
+ * Returns true if the given @bridge is handled by the native PCIe hotplug
+ * driver.
  */
-bool pciehp_is_native(struct pci_dev *pdev)
+bool pciehp_is_native(struct pci_dev *bridge)
 {
-	struct acpi_pci_root *root;
-	acpi_handle handle;
+	const struct pci_host_bridge *host;
+	u32 slot_cap;
 
-	handle = acpi_find_root_bridge_handle(pdev);
-	if (!handle)
+	if (!pciehp_available())
+		return false;
+	if (!bridge)
 		return false;
 
-	root = acpi_pci_find_root(handle);
-	if (!root)
+	pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
+	if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
 		return false;
 
-	return root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
+	if (pcie_ports_native)
+		return true;
+
+	host = pci_find_host_bridge(bridge->bus);
+	return host->native_pcie_hotplug;
 }
 
 /**
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index d0c6783dbfe3..aa542dc10d23 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -11,8 +11,6 @@
 
 #include <linux/compiler.h>
 
-extern bool pcie_ports_native;
-
 /* Service Type */
 #define PCIE_PORT_SERVICE_PME_SHIFT	0	/* Power Management Event */
 #define PCIE_PORT_SERVICE_PME		(1 << PCIE_PORT_SERVICE_PME_SHIFT)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 359a197d0310..2f6689a14e8d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1451,8 +1451,10 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
 
 #ifdef CONFIG_PCIEPORTBUS
 extern bool pcie_ports_disabled;
+extern bool pcie_ports_native;
 #else
 #define pcie_ports_disabled	true
+#define pcie_ports_native	false
 #endif
 
 #ifdef CONFIG_PCIEASPM
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index 46fb90b5164b..ee2b1674a601 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -162,7 +162,7 @@ struct hotplug_params {
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
 int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp);
-bool pciehp_is_native(struct pci_dev *pdev);
+bool pciehp_is_native(struct pci_dev *bridge);
 int acpi_get_hp_hw_control_from_firmware(struct pci_dev *dev, u32 flags);
 int acpi_pci_check_ejectable(struct pci_bus *pbus, acpi_handle handle);
 int acpi_pci_detect_ejectable(acpi_handle handle);
@@ -172,7 +172,7 @@ static inline int pci_get_hp_params(struct pci_dev *dev,
 {
 	return -ENODEV;
 }
-static inline bool pciehp_is_native(struct pci_dev *pdev) { return true; }
+static inline bool pciehp_is_native(struct pci_dev *bridge) { return true; }
 #endif
 
 #ifdef CONFIG_HOTPLUG_PCI_PCIE
-- 
2.17.0

