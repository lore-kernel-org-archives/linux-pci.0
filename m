Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: [PATCH] ACPI / hotplug / PCI: Fix error code path in acpiphp_enumerate_slots()
Date: Fri, 11 Oct 2013 01:47:23 +0200
Message-ID: <2737842.bynDuCj2Fi@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

One of the error code paths in acpiphp_enumerate_slots() is missing
a pci_dev_put(bridge->pci_dev) call, so add it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is new in 3.12-rc.

---
 drivers/pci/hotplug/acpiphp_glue.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
@@ -1007,6 +1007,7 @@ void acpiphp_enumerate_slots(struct pci_
 		if (WARN_ON(!context)) {
 			mutex_unlock(&acpiphp_context_lock);
 			put_device(&bus->dev);
+			pci_dev_put(bridge->pci_dev);
 			kfree(bridge);
 			return;
 		}

