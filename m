Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 29/30] ACPI / hotplug / PCI: Clean up bridge_mutex usage
Date: Thu, 18 Jul 2013 01:35:45 +0200
Message-ID: <1699392.oW1xlocqas@vostro.rjw.lan>
In-Reply-To: <2366394.4EoP1MXmG2@vostro.rjw.lan>
References: <26431283.HJCKsss0rt@vostro.rjw.lan> <3718119.FLASu5DBx8@vostro.rjw.lan> <2366394.4EoP1MXmG2@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Do not acquire bridge_mutex around the addition of a slot to its
bridge's list of slots and arount the addition of a function to
its slot's list of functions, because that doesn't help anything
right now (those lists are walked without any locking anyway).

However, acquire bridge_mutex around the list walk in
acpiphp_remove_slots() and use list_for_each_entry() there,
because we terminate the walk as soon as we find the first matching
entry.  This prevents that list walk from colliding with bridge
addition and removal.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
@@ -323,9 +323,7 @@ static acpi_status register_slot(acpi_ha
 	INIT_LIST_HEAD(&slot->funcs);
 	mutex_init(&slot->crit_sect);
 
-	mutex_lock(&bridge_mutex);
 	list_add_tail(&slot->node, &bridge->slots);
-	mutex_unlock(&bridge_mutex);
 
 	/* Register slots for ejectable funtions only. */
 	if (acpi_pci_check_ejectable(pbus, handle)  || is_dock_device(handle)) {
@@ -355,9 +353,7 @@ static acpi_status register_slot(acpi_ha
 
  slot_found:
 	newfunc->slot = slot;
-	mutex_lock(&bridge_mutex);
 	list_add_tail(&newfunc->sibling, &slot->funcs);
-	mutex_unlock(&bridge_mutex);
 
 	if (pci_bus_read_dev_vendor_id(pbus, PCI_DEVFN(device, function),
 				       &val, 60*1000))
@@ -1025,17 +1021,21 @@ void acpiphp_enumerate_slots(struct pci_
 /* Destroy hotplug slots associated with the PCI bus */
 void acpiphp_remove_slots(struct pci_bus *bus)
 {
-	struct acpiphp_bridge *bridge, *tmp;
+	struct acpiphp_bridge *bridge;
 
 	if (acpiphp_disabled)
 		return;
 
-	list_for_each_entry_safe(bridge, tmp, &bridge_list, list)
+	mutex_lock(&bridge_mutex);
+	list_for_each_entry(bridge, &bridge_list, list)
 		if (bridge->pci_bus == bus) {
+			mutex_unlock(&bridge_mutex);
 			cleanup_bridge(bridge);
 			put_bridge(bridge);
-			break;
+			return;
 		}
+
+	mutex_unlock(&bridge_mutex);
 }
 
 /**

