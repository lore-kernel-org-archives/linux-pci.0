Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] ACPI / hotplug / PCI: Eliminate acpiphp_dev_to_bridge()
Date: Mon, 14 Jul 2014 22:34:41 +0200
Message-ID: <1740704.38rBxHAFD3@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since acpiphp_dev_to_bridge() is only called by acpiphp_check_host_bridge(),
move the code from it to that function directly which reduces the call
chain depth and makes the code slightly easier to follow.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |   24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
@@ -369,20 +369,6 @@ static acpi_status acpiphp_add_context(a
 	return AE_OK;
 }
 
-static struct acpiphp_bridge *acpiphp_dev_to_bridge(struct acpi_device *adev)
-{
-	struct acpiphp_bridge *bridge = NULL;
-
-	acpi_lock_hp_context();
-	if (adev->hp) {
-		bridge = to_acpiphp_root_context(adev->hp)->root_bridge;
-		if (bridge)
-			get_bridge(bridge);
-	}
-	acpi_unlock_hp_context();
-	return bridge;
-}
-
 static void cleanup_bridge(struct acpiphp_bridge *bridge)
 {
 	struct acpiphp_slot *slot;
@@ -753,9 +739,15 @@ static void acpiphp_sanitize_bus(struct
 
 void acpiphp_check_host_bridge(struct acpi_device *adev)
 {
-	struct acpiphp_bridge *bridge;
+	struct acpiphp_bridge *bridge = NULL;
 
-	bridge = acpiphp_dev_to_bridge(adev);
+	acpi_lock_hp_context();
+	if (adev->hp) {
+		bridge = to_acpiphp_root_context(adev->hp)->root_bridge;
+		if (bridge)
+			get_bridge(bridge);
+	}
+	acpi_unlock_hp_context();
 	if (bridge) {
 		pci_lock_rescan_remove();
 

