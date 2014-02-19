Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Tejun Heo <tj@kernel.org>,
	Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 1/9] ACPI / hotplug / PCI: Do not clear event callback pointer for docks
Date: Wed, 19 Feb 2014 02:27:01 +0100
Message-ID: <2117607.1Rv04qGaoi@vostro.rjw.lan>
In-Reply-To: <3011875.q18rCmXyYX@vostro.rjw.lan>
References: <3011875.q18rCmXyYX@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After recent changes adding dock station handling to the ACPI hotplug
core, it is not necessary to clear the .event() pointer in the
ACPIPHP device hotplug context for dock stations any more, so don't
do that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |    7 -------
 1 file changed, 7 deletions(-)

Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
@@ -307,13 +307,6 @@ static acpi_status acpiphp_add_context(a
 	if (acpi_has_method(handle, "_STA"))
 		newfunc->flags |= FUNC_HAS_STA;
 
-	/*
-	 * Dock stations' notify handler should be used for dock devices instead
-	 * of the common one, so clear hp.event in their contexts.
-	 */
-	if (acpi_has_method(handle, "_DCK"))
-		context->hp.event = NULL;
-
 	acpi_unlock_hp_context();
 
 	/* search for objects that share the same slot */

