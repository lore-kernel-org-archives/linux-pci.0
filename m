Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Aaron Lu <aaron.lu@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: [PATCH 6/24][Resend] ACPI / hotplug / PCI: Simplify disable_slot()
Date: Tue, 04 Feb 2014 00:20:18 +0100
Message-ID: <2631964.LdI8Nm3YsY@vostro.rjw.lan>
In-Reply-To: <7532948.aJNUotNMpR@vostro.rjw.lan>
References: <2217793.001RY6hKlo@vostro.rjw.lan> <20140203104408.GQ18029@intel.com> <7532948.aJNUotNMpR@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After recent PCI core changes related to the rescan/remove locking,
the ACPIPHP's disable_slot() function is only called under the
general PCI rescan/remove lock, so it doesn't have to use
dev_in_slot() any more to avoid race conditions.  Make it simply
walk the devices on the bus and drop the ones in the slot being
disabled and drop dev_in_slot() which has no more users.

Moreover, to avoid problems described in the changelog of commit
29ed1f29b68a (PCI: pciehp: Fix null pointer deref when hot-removing
SR-IOV device), make disable_slot() carry out the list walk in
reverse order.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |   28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
@@ -625,32 +625,15 @@ static void __ref enable_slot(struct acp
 	}
 }
 
-/* return first device in slot, acquiring a reference on it */
-static struct pci_dev *dev_in_slot(struct acpiphp_slot *slot)
-{
-	struct pci_bus *bus = slot->bus;
-	struct pci_dev *dev;
-	struct pci_dev *ret = NULL;
-
-	down_read(&pci_bus_sem);
-	list_for_each_entry(dev, &bus->devices, bus_list)
-		if (PCI_SLOT(dev->devfn) == slot->device) {
-			ret = pci_dev_get(dev);
-			break;
-		}
-	up_read(&pci_bus_sem);
-
-	return ret;
-}
-
 /**
  * disable_slot - disable a slot
  * @slot: ACPI PHP slot
  */
 static void disable_slot(struct acpiphp_slot *slot)
 {
+	struct pci_bus *bus = slot->bus;
+	struct pci_dev *dev, *prev;
 	struct acpiphp_func *func;
-	struct pci_dev *pdev;
 
 	/*
 	 * enable_slot() enumerates all functions in this device via
@@ -658,10 +641,9 @@ static void disable_slot(struct acpiphp_
 	 * methods (_EJ0, etc.) or not.  Therefore, we remove all functions
 	 * here.
 	 */
-	while ((pdev = dev_in_slot(slot))) {
-		pci_stop_and_remove_bus_device(pdev);
-		pci_dev_put(pdev);
-	}
+	list_for_each_entry_safe_reverse(dev, prev, &bus->devices, bus_list)
+		if (PCI_SLOT(dev->devfn) == slot->device)
+			pci_stop_and_remove_bus_device(dev);
 
 	list_for_each_entry(func, &slot->funcs, sibling)
 		acpiphp_bus_trim(func_to_handle(func));

