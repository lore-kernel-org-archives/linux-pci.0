Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PCI / hotplug / ACPI: Get rid of check_sub_bridges()
Date: Tue, 16 Jul 2013 02:31:15 +0200
Message-ID: <59738946.aKFnLHMEA1@vostro.rjw.lan>
In-Reply-To: <20130714070828.GS4898@intel.com>
References: <1373735399-28055-1-git-send-email-mika.westerberg@linux.intel.com> <3395919.UaDiFX78Zn@vostro.rjw.lan> <20130714070828.GS4898@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sunday, July 14, 2013 10:08:28 AM Mika Westerberg wrote:
> On Sat, Jul 13, 2013 at 11:47:26PM +0200, Rafael J. Wysocki wrote:
> > On Saturday, July 13, 2013 08:09:59 PM Mika Westerberg wrote:
> > > Now that acpiphp_check_bridge() always enumerates devices behind the
> > > bridge, there is no need to do that for each sub-bridge anymore like it is
> > > done in the current ACPI-based PCI hotplug code. Given this we don't need
> > > check_sub_bridges() anymore and can drop the function completely.
> > > 
> > > This also simplifies the ACPIPHP code a bit.
> > > 
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > ---
> > > This applies on top of v3.10 with Rafael's ACPIPHP + Thunderbolt series
> > > applied:
> > >
> > 
> > OK, I added it to my bleeding-edge branch along with this series:
> > 
> > > 	http://www.spinics.net/lists/linux-acpi/msg44480.html
> > 
> > rebased on top of some previous ACPI cleanup commits.  I needed to make some
> > changes in the process (and fixed up some breakage reported by the auto build
> > testing), hopefully I didn't break anything.  If you're in an adventurous mood,
> > testing would be welcome. ;-)  [That already includes the majority of 3.11
> > material from Linus, though, so unexpected breakage elsewhere may happen.]
> 
> Tried the bleeding-edge branch on both of our test machines and Thunderbolt
> still works fine.

Can you please apply the appended patch on top of the current
linux-pm.git/bleeding-edge and check if things still work then on the test
systems?

Rafael


---
 drivers/pci/hotplug/acpiphp_glue.c |   42 ++++++++++++++++++++++++++++++++++++-
 drivers/pci/remove.c               |   20 -----------------
 include/linux/pci.h                |    1 
 3 files changed, 41 insertions(+), 22 deletions(-)

Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
@@ -46,6 +46,7 @@
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
 #include <linux/pci-acpi.h>
+#include <linux/pm_runtime.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
@@ -680,6 +681,45 @@ static unsigned int get_slot_status(stru
 }
 
 /**
+ * trim_stale_devices - remove PCI devices that are not responding.
+ * @dev: PCI device to start walking the hierarchy from.
+ */
+static void trim_stale_devices(struct pci_dev *dev)
+{
+	acpi_handle handle = ACPI_HANDLE(&dev->dev);
+	struct pci_bus *bus = dev->subordinate;
+	bool alive = false;
+
+	if (handle) {
+		acpi_status status;
+		unsigned long long sta;
+
+		status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
+		alive = ACPI_SUCCESS(status) && sta == ACPI_STA_ALL;
+	}
+	if (!alive) {
+		u32 v;
+
+		/* Check if the device responds. */
+		alive = pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &v, 0);
+	}
+	if (!alive) {
+		pci_stop_and_remove_bus_device(dev);
+		if (handle)
+			acpiphp_bus_trim(handle);
+	} else if (bus) {
+		struct pci_dev *child, *tmp;
+
+		/* The device is a bridge. so check the bus below it. */
+		pm_runtime_get_sync(&dev->dev);
+		list_for_each_entry_safe(child, tmp, &bus->devices, bus_list)
+			trim_stale_devices(child);
+
+		pm_runtime_put(&dev->dev);
+	}
+}
+
+/**
  * acpiphp_check_bridge - re-enumerate devices
  * @bridge: where to begin re-enumeration
  *
@@ -701,7 +741,7 @@ static void acpiphp_check_bridge(struct
 			list_for_each_entry_safe(dev, tmp, &bus->devices,
 						 bus_list)
 				if (PCI_SLOT(dev->devfn) == slot->device)
-					pci_trim_stale_devices(dev);
+					trim_stale_devices(dev);
 
 			/* configure all functions */
 			enable_slot(slot);
Index: linux-pm/drivers/pci/remove.c
===================================================================
--- linux-pm.orig/drivers/pci/remove.c
+++ linux-pm/drivers/pci/remove.c
@@ -112,26 +112,6 @@ void pci_stop_and_remove_bus_device(stru
 }
 EXPORT_SYMBOL(pci_stop_and_remove_bus_device);
 
-/**
- * pci_trim_stale_devices - remove PCI devices that are not responding
- * @dev: the device to start walking the hierarchy from
- */
-void pci_trim_stale_devices(struct pci_dev *dev)
-{
-	struct pci_bus *bus = dev->subordinate;
-	struct pci_dev *child, *tmp;
-	bool alive;
-	u32 val;
-
-	/* check if the device responds */
-	alive = pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &val, 0);
-	if (!alive)
-		pci_stop_and_remove_bus_device(dev);
-	else if (bus)
-		list_for_each_entry_safe(child, tmp, &bus->devices, bus_list)
-			pci_trim_stale_devices(child);
-}
-
 void pci_stop_root_bus(struct pci_bus *bus)
 {
 	struct pci_dev *child, *tmp;
Index: linux-pm/include/linux/pci.h
===================================================================
--- linux-pm.orig/include/linux/pci.h
+++ linux-pm/include/linux/pci.h
@@ -755,7 +755,6 @@ struct pci_dev *pci_dev_get(struct pci_d
 void pci_dev_put(struct pci_dev *dev);
 void pci_remove_bus(struct pci_bus *b);
 void pci_stop_and_remove_bus_device(struct pci_dev *dev);
-void pci_trim_stale_devices(struct pci_dev *dev);
 void pci_stop_root_bus(struct pci_bus *bus);
 void pci_remove_root_bus(struct pci_bus *bus);
 void pci_setup_cardbus(struct pci_bus *bus);


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
