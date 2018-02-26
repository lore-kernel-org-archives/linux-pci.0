Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v3 4/5] ACPI / hotplug / PCI: Do not scan all bridges when native PCIe hotplug is used
Date: Mon, 26 Feb 2018 16:21:11 +0300
Message-Id: <20180226132112.81447-5-mika.westerberg@linux.intel.com>
In-Reply-To: <20180226132112.81447-1-mika.westerberg@linux.intel.com>
References: <20180226132112.81447-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When a system is using native PCIe hotplug for Thunderbolt and the
controller is not enabled for full RTD3 (runtime D3) it will be only
present in the system when there is a device connected. This pretty much
follows the BIOS assisted hotplug behaviour.

Thunderbolt host controller integrated PCIe switch has two additional
PCIe downstream ports that lead to NHI (Thunderbolt host controller) and
xHCI (USB 3 host controller) respectively. These downstream ports are
not marked being hotplug capable. Reason for that is to preserve
resources. Otherwise the OS would distribute remaining resources between
all downstream ports making these two ports consume too much resources
they don't really need (both NHI and xHCI only need 1 MB of MMIO space,
and no extra buses).

Now, because these ports are not marked being hotplug capable the OS
will not enable hotplug interrupt for them either and will not receive
interrupt when devices below them are hotplugged. Solution to this is
that the BIOS sends ACPI Notify() for the root port to notify the OS it
needs to rescan for added devices.

However, the current ACPI hotplug implementation scans the whole slot
regardless whether native PCIe is used or not and it expects that the
BIOS has configured bridge resources upfront. If that's not the case it
assigns resources using minimal allocation (everything currently found
just barely fit) preventing future extension. In addition to that, if
there is another native PCIe hotplug going on we may find the new PCIe
switch only partially ready (all links are not fully trained yet)
confusing PCIehp when it finally starts to enumerate new devices.

To make this work better with the native PCIe hotplug driver (PCIehp),
we let it to handle all slot management and resource allocation for
hotplug bridges and restrict ACPI hotplug to non-hotplug bridges.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/hotplug/acpiphp.h      |  1 +
 drivers/pci/hotplug/acpiphp_glue.c | 73 ++++++++++++++++++++++++++++++--------
 2 files changed, 59 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
index e438a2d734f2..8dcfd623ef1d 100644
--- a/drivers/pci/hotplug/acpiphp.h
+++ b/drivers/pci/hotplug/acpiphp.h
@@ -158,6 +158,7 @@ struct acpiphp_attention_info
 
 #define SLOT_ENABLED		(0x00000001)
 #define SLOT_IS_GOING_AWAY	(0x00000002)
+#define SLOT_IS_NATIVE		(0x00000004)
 
 /* function flags */
 
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index b45b375c0e6c..5efa21cdddc9 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -282,6 +282,9 @@ static acpi_status acpiphp_add_context(acpi_handle handle, u32 lvl, void *data,
 	slot->device = device;
 	INIT_LIST_HEAD(&slot->funcs);
 
+	if (pdev && pciehp_is_native(pdev))
+		slot->flags |= SLOT_IS_NATIVE;
+
 	list_add_tail(&slot->node, &bridge->slots);
 
 	/*
@@ -291,7 +294,7 @@ static acpi_status acpiphp_add_context(acpi_handle handle, u32 lvl, void *data,
 	 * expose slots to user space in those cases.
 	 */
 	if ((acpi_pci_check_ejectable(pbus, handle) || is_dock_device(adev))
-	    && !(pdev && pdev->is_hotplug_bridge && pciehp_is_native(pdev))) {
+	    && !(slot->flags & SLOT_IS_NATIVE && pdev->is_hotplug_bridge)) {
 		unsigned long long sun;
 		int retval;
 
@@ -430,6 +433,29 @@ static int acpiphp_rescan_slot(struct acpiphp_slot *slot)
 	return pci_scan_slot(slot->bus, PCI_DEVFN(slot->device, 0));
 }
 
+static void acpiphp_native_scan_bridge(struct pci_dev *bridge)
+{
+	struct pci_bus *bus = bridge->subordinate;
+	struct pci_dev *dev;
+	int max;
+
+	if (!bus)
+		return;
+
+	max = bus->busn_res.start;
+	/* Scan already configured non-hotplug bridges */
+	for_each_pci_bridge(dev, bus) {
+		if (!dev->is_hotplug_bridge)
+			max = pci_scan_bridge(bus, dev, max, 0);
+	}
+
+	/* Scan non-hotplug bridges that need to be reconfigured */
+	for_each_pci_bridge(dev, bus) {
+		if (!dev->is_hotplug_bridge)
+			max = pci_scan_bridge(bus, dev, max, 1);
+	}
+}
+
 /**
  * enable_slot - enable, configure a slot
  * @slot: slot to be enabled
@@ -442,25 +468,42 @@ static void enable_slot(struct acpiphp_slot *slot)
 	struct pci_dev *dev;
 	struct pci_bus *bus = slot->bus;
 	struct acpiphp_func *func;
-	int max, pass;
-	LIST_HEAD(add_list);
 
-	acpiphp_rescan_slot(slot);
-	max = acpiphp_max_busnr(bus);
-	for (pass = 0; pass < 2; pass++) {
+	if (slot->flags & SLOT_IS_NATIVE) {
+		/*
+		 * If native PCIe hotplug is used, it will take care of
+		 * hotplug slot management and resource allocation for
+		 * hotplug bridges. However, ACPI hotplug may still be
+		 * used for non-hotplug bridges to bring in additional
+		 * devices such as Thunderbolt host controller.
+		 */
 		for_each_pci_bridge(dev, bus) {
-			if (PCI_SLOT(dev->devfn) != slot->device)
-				continue;
-
-			max = pci_scan_bridge(bus, dev, max, pass);
-			if (pass && dev->subordinate) {
-				check_hotplug_bridge(slot, dev);
-				pcibios_resource_survey_bus(dev->subordinate);
-				__pci_bus_size_bridges(dev->subordinate, &add_list);
+			if (PCI_SLOT(dev->devfn) == slot->device)
+				acpiphp_native_scan_bridge(dev);
+		}
+		pci_assign_unassigned_bridge_resources(bus->self);
+	} else {
+		LIST_HEAD(add_list);
+		int max, pass;
+
+		acpiphp_rescan_slot(slot);
+		max = acpiphp_max_busnr(bus);
+		for (pass = 0; pass < 2; pass++) {
+			for_each_pci_bridge(dev, bus) {
+				if (PCI_SLOT(dev->devfn) != slot->device)
+					continue;
+
+				max = pci_scan_bridge(bus, dev, max, pass);
+				if (pass && dev->subordinate) {
+					check_hotplug_bridge(slot, dev);
+					pcibios_resource_survey_bus(dev->subordinate);
+					__pci_bus_size_bridges(dev->subordinate,
+							       &add_list);
+				}
 			}
 		}
+		__pci_bus_assign_resources(bus, &add_list, NULL);
 	}
-	__pci_bus_assign_resources(bus, &add_list, NULL);
 
 	acpiphp_sanitize_bus(bus);
 	pcie_bus_configure_settings(bus);
-- 
2.16.1

