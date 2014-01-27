Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54391 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753347AbaA0AcV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 26 Jan 2014 19:32:21 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Aaron Lu <aaron.lu@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 8/11] ACPI / hotplug / PCI: Simplify hotplug_event()
Date: Mon, 27 Jan 2014 01:43:28 +0100
Message-ID: <11500769.PNC7NPuez9@vostro.rjw.lan>
In-Reply-To: <2217793.001RY6hKlo@vostro.rjw.lan>
References: <2217793.001RY6hKlo@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

A few lines of code can be cut from hotplug_event() by defining
and initializing the slot variable at the top of the function,
so do that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |   19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
@@ -810,6 +810,7 @@ static void hotplug_event(acpi_handle ha
 {
 	struct acpiphp_context *context = data;
 	struct acpiphp_func *func = &context->func;
+	struct acpiphp_slot *slot = func->slot;
 	struct acpiphp_bridge *bridge;
 	char objname[64];
 	struct acpi_buffer buffer = { .length = sizeof(objname),
@@ -830,14 +831,11 @@ static void hotplug_event(acpi_handle ha
 		pr_debug("%s: Bus check notify on %s\n", __func__, objname);
 		pr_debug("%s: re-enumerating slots under %s\n",
 			 __func__, objname);
-		if (bridge) {
+		if (bridge)
 			acpiphp_check_bridge(bridge);
-		} else {
-			struct acpiphp_slot *slot = func->slot;
+		else if (!(slot->flags & SLOT_IS_GOING_AWAY))
+			enable_slot(slot);
 
-			if (!(slot->flags & SLOT_IS_GOING_AWAY))
-				enable_slot(slot);
-		}
 		break;
 
 	case ACPI_NOTIFY_DEVICE_CHECK:
@@ -845,12 +843,7 @@ static void hotplug_event(acpi_handle ha
 		pr_debug("%s: Device check notify on %s\n", __func__, objname);
 		if (bridge) {
 			acpiphp_check_bridge(bridge);
-		} else {
-			struct acpiphp_slot *slot = func->slot;
-
-			if (slot->flags & SLOT_IS_GOING_AWAY)
-				break;
-
+		} else if (!(slot->flags & SLOT_IS_GOING_AWAY)) {
 			/*
 			 * Check if anything has changed in the slot and rescan
 			 * from the parent if that's the case.
@@ -863,7 +856,7 @@ static void hotplug_event(acpi_handle ha
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		/* request device eject */
 		pr_debug("%s: Device eject notify on %s\n", __func__, objname);
-		acpiphp_disable_and_eject_slot(func->slot);
+		acpiphp_disable_and_eject_slot(slot);
 		break;
 	}
 

