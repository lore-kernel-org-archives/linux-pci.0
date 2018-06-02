Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: [PATCH v1 1/2] PCI: shpchp: Use dev_printk() for OSHP-related
 messages
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Date: Sat, 02 Jun 2018 00:42:06 -0500
Message-ID: <152791812599.257724.10989340037255897378.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152791788214.257724.13044360353832574147.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152791788214.257724.13044360353832574147.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Use dev_printk() for messages related to requesting control of SHPC hotplug
via the OSHP method.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/acpi_pcihp.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
index 7cc50cfef9c6..597d22aeefc1 100644
--- a/drivers/pci/hotplug/acpi_pcihp.c
+++ b/drivers/pci/hotplug/acpi_pcihp.c
@@ -96,7 +96,7 @@ int acpi_get_hp_hw_control_from_firmware(struct pci_dev *pdev)
 	if (!handle) {
 		/*
 		 * This hotplug controller was not listed in the ACPI name
-		 * space at all. Try to get acpi handle of parent pci bus.
+		 * space at all. Try to get ACPI handle of parent PCI bus.
 		 */
 		struct pci_bus *pbus;
 		for (pbus = pdev->bus; pbus; pbus = pbus->parent) {
@@ -108,8 +108,8 @@ int acpi_get_hp_hw_control_from_firmware(struct pci_dev *pdev)
 
 	while (handle) {
 		acpi_get_name(handle, ACPI_FULL_PATHNAME, &string);
-		dbg("Trying to get hotplug control for %s\n",
-		    (char *)string.pointer);
+		pci_info(pdev, "Requesting control of SHPC hotplug via OSHP (%s)\n",
+			 (char *)string.pointer);
 		status = acpi_run_oshp(handle);
 		if (ACPI_SUCCESS(status))
 			goto got_one;
@@ -121,13 +121,12 @@ int acpi_get_hp_hw_control_from_firmware(struct pci_dev *pdev)
 			break;
 	}
 no_control:
-	dbg("Cannot get control of hotplug hardware for pci %s\n",
-	    pci_name(pdev));
+	pci_info(pdev, "Cannot get control of SHPC hotplug\n");
 	kfree(string.pointer);
 	return -ENODEV;
 got_one:
-	dbg("Gained control for hotplug HW for pci %s (%s)\n",
-	    pci_name(pdev), (char *)string.pointer);
+	pci_info(pdev, "Gained control of SHPC hotplug (%s)\n",
+		 (char *)string.pointer);
 	kfree(string.pointer);
 	return 0;
 }

