Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>,
        Peter Anemone <peter.anemone@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH] ACPI / hotplug / PCI: Don't scan for non-hotplug bridges if slot is not bridge
Date: Wed, 19 Sep 2018 14:32:47 +0300
Message-Id: <20180919113247.4274-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

HP 6730b laptop has an ethernet NIC connected to one of the PCIe root
ports. The root ports itself are native PCIe hotplug capable. Now,
during boot after PCI devices are scanned the BIOS triggers ACPI bus
check directly to the NIC:

  [    0.942239] ACPI: \_SB_.PCI0.RP06.NIC_: Bus check in hotplug_event()

It is not clear why it is sending bus check but regardless the ACPI
hotplug notify handler calls enable_slot() directly (instead of going
through acpiphp_check_bridge() as there is no bridge) which ends up
handling special case for non-hotplug bridges with native PCIe hotplug.
This results a crash of some kind but the reporter only sees black
screen so it is hard to figure out the exact spot and what actually
happens. Based on few fix proposals it was tracked to crash somewhere
inside pci_assign_unassigned_bridge_resources().

In any case we should not really be in that special branch at all
because the ACPI notify happened to a slot that is not a PCI bridge (it
is just a regular PCI device).

Fix this so that we only go to that special branch if we are calling
enable_slot() for a bridge (e.g the ACPI notification was for the bridge).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=201127
Fixes: 84c8b58ed3ad ACPI / hotplug / PCI: Don't scan bridges managed by native hotplug
Reported-by: Peter Anemone <peter.anemone@gmail.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index ef0b1b6ba86f..fa2d82ae6ccd 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -457,17 +457,20 @@ static void acpiphp_native_scan_bridge(struct pci_dev *bridge)
 /**
  * enable_slot - enable, configure a slot
  * @slot: slot to be enabled
+ * @bridge: Bridge if the hotplug was directly to the bridge. %NULL
+ *	    otherwise.
  *
  * This function should be called per *physical slot*,
  * not per each slot object in ACPI namespace.
  */
-static void enable_slot(struct acpiphp_slot *slot)
+static void enable_slot(struct acpiphp_slot *slot,
+			const struct acpiphp_bridge *bridge)
 {
 	struct pci_dev *dev;
 	struct pci_bus *bus = slot->bus;
 	struct acpiphp_func *func;
 
-	if (bus->self && hotplug_is_native(bus->self)) {
+	if (bridge && bus->self && hotplug_is_native(bus->self)) {
 		/*
 		 * If native hotplug is used, it will take care of hotplug
 		 * slot management and resource allocation for hotplug
@@ -701,7 +704,7 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
 					trim_stale_devices(dev);
 
 			/* configure all functions */
-			enable_slot(slot);
+			enable_slot(slot, bridge);
 		} else {
 			disable_slot(slot);
 		}
@@ -785,7 +788,7 @@ static void hotplug_event(u32 type, struct acpiphp_context *context)
 		if (bridge)
 			acpiphp_check_bridge(bridge);
 		else if (!(slot->flags & SLOT_IS_GOING_AWAY))
-			enable_slot(slot);
+			enable_slot(slot, NULL);
 
 		break;
 
@@ -973,7 +976,7 @@ int acpiphp_enable_slot(struct acpiphp_slot *slot)
 
 	/* configure all functions */
 	if (!(slot->flags & SLOT_ENABLED))
-		enable_slot(slot);
+		enable_slot(slot, NULL);
 
 	pci_unlock_rescan_remove();
 	return 0;
-- 
2.18.0
