Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 18/30] ACPI / hotplug / PCI: Rework namespace scanning and trimming routines
Date: Thu, 18 Jul 2013 01:27:19 +0200
Message-ID: <2665100.NNuj40D6yN@vostro.rjw.lan>
In-Reply-To: <2366394.4EoP1MXmG2@vostro.rjw.lan>
References: <26431283.HJCKsss0rt@vostro.rjw.lan> <3718119.FLASu5DBx8@vostro.rjw.lan> <2366394.4EoP1MXmG2@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The acpiphp_bus_trim() and acpiphp_bus_add() functions need not
return error codes that are never checked, so redefine them and
simplify them a bit.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |   52 +++++++++----------------------------
 1 file changed, 13 insertions(+), 39 deletions(-)

Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
@@ -540,53 +540,27 @@ static unsigned char acpiphp_max_busnr(s
 	return max;
 }
 
-
 /**
- * acpiphp_bus_add - add a new bus to acpi subsystem
- * @func: acpiphp_func of the bridge
+ * acpiphp_bus_trim - Trim device objects in an ACPI namespace subtree.
+ * @handle: ACPI device object handle to start from.
  */
-static int acpiphp_bus_add(struct acpiphp_func *func)
+static void acpiphp_bus_trim(acpi_handle handle)
 {
-	acpi_handle handle = func_to_handle(func);
-	struct acpi_device *device;
-	int ret_val;
-
-	if (!acpi_bus_get_device(handle, &device)) {
-		dbg("bus exists... trim\n");
-		/* this shouldn't be in here, so remove
-		 * the bus then re-add it...
-		 */
-		acpi_bus_trim(device);
-	}
-
-	ret_val = acpi_bus_scan(handle);
-	if (!ret_val)
-		ret_val = acpi_bus_get_device(handle, &device);
-
-	if (ret_val)
-		dbg("error adding bus, %x\n", -ret_val);
+	struct acpi_device *adev = NULL;
 
-	return ret_val;
+	acpi_bus_get_device(handle, &adev);
+	if (adev)
+		acpi_bus_trim(adev);
 }
 
-
 /**
- * acpiphp_bus_trim - trim a bus from acpi subsystem
- * @handle: handle to acpi namespace
+ * acpiphp_bus_add - Scan ACPI namespace subtree.
+ * @handle: ACPI object handle to start the scan from.
  */
-static int acpiphp_bus_trim(acpi_handle handle)
+static void acpiphp_bus_add(acpi_handle handle)
 {
-	struct acpi_device *device;
-	int retval;
-
-	retval = acpi_bus_get_device(handle, &device);
-	if (retval) {
-		dbg("acpi_device not found\n");
-		return retval;
-	}
-
-	acpi_bus_trim(device);
-	return 0;
+	acpiphp_bus_trim(handle);
+	acpi_bus_scan(handle);
 }
 
 static void acpiphp_set_acpi_region(struct acpiphp_slot *slot)
@@ -649,7 +623,7 @@ static int __ref enable_device(struct ac
 		goto err_exit;
 
 	list_for_each_entry(func, &slot->funcs, sibling)
-		acpiphp_bus_add(func);
+		acpiphp_bus_add(func_to_handle(func));
 
 	num = pci_scan_slot(bus, PCI_DEVFN(slot->device, 0));
 	if (num == 0) {

