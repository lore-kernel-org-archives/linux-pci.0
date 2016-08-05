Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62401 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S934728AbcHEAkK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Aug 2016 20:40:10 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Airlie <airlied@linux.ie>
Subject: [PATCH] ACPI / hotplug / PCI: Runtime resume bridges before bus rescans
Date: Fri, 05 Aug 2016 02:38:44 +0200
Message-ID: <5356594.Wd8M8VygiD@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If a PCI bridge (or PCIe port) that is runtime-suspended gets an
ACPI hotplug notification, such as a bus check, it has to be resumed
before re-scanning the devices below it, or those devices will not
be accessible and will be treated as hot-removed.

Make that happen and let the bridge suspend again after the bus
below it has been re-scanned.

This is a replacement for commit 16468c783cb4 (ACPI / hotplug / PCI:
Runtime resume bridge before rescan) that has been reverted,
because it introduced a system resume regression (due to missing
bridge->pci_dev checks that are necessary in case the notification
is targeted at the host bridge) and it is necessary for the code
added by commit 006d44e49a25 (PCI: Add runtime PM support for PCIe
ports) to work as expected.

Tested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
@@ -675,6 +675,9 @@ static void acpiphp_check_bridge(struct
 	if (bridge->is_going_away)
 		return;
 
+	if (bridge->pci_dev)
+		pm_runtime_get_sync(&bridge->pci_dev->dev);
+
 	list_for_each_entry(slot, &bridge->slots, node) {
 		struct pci_bus *bus = slot->bus;
 		struct pci_dev *dev, *tmp;
@@ -694,6 +697,9 @@ static void acpiphp_check_bridge(struct
 			disable_slot(slot);
 		}
 	}
+
+	if (bridge->pci_dev)
+		pm_runtime_put(&bridge->pci_dev->dev);
 }
 
 /*

