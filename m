Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v5 6/9] PCI: Move resource distribution for a single bridge outside of the loop
Date: Mon, 16 Apr 2018 13:34:50 +0300
Message-Id: <20180416103453.46232-7-mika.westerberg@linux.intel.com>
In-Reply-To: <20180416103453.46232-1-mika.westerberg@linux.intel.com>
References: <20180416103453.46232-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is a special case where there is only single bridge on the bus. In
that case we just assign all resources to it. Currently this is done as
a part of the resource distribution loop but it does not have to be
there, and moving it outside actually improves readability.

While there we can add hotplug_bridges == 1 && normal_bridges == 0 to
the same block because they are dealt the same way.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/setup-bus.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index eb3059fb7f63..a1b63c7745d0 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1947,6 +1947,22 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	mmio_start = mmio_res->start;
 	mmio_pref_start = mmio_pref_res->start;
 
+	/*
+	 * There is only one bridge on the bus so it gets all available
+	 * resources which it can then distribute to the possible
+	 * hotplug bridges below.
+	 */
+	if ((hotplug_bridges == 0 && normal_bridges == 1) ||
+	    (hotplug_bridges == 1 && normal_bridges == 0)) {
+		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
+		if (dev->subordinate) {
+			pci_bus_distribute_available_resources(dev->subordinate,
+				add_list, available_io, available_mmio,
+				available_mmio_pref);
+		}
+		return;
+	}
+
 	/*
 	 * Go over devices on this bus and distribute the remaining
 	 * resource space between hotplug bridges.
@@ -1959,17 +1975,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 		if (!b)
 			continue;
 
-		if (!hotplug_bridges && normal_bridges == 1) {
-			/*
-			 * There is only one bridge on the bus (upstream
-			 * port) so it gets all available resources
-			 * which it can then distribute to the possible
-			 * hotplug bridges below.
-			 */
-			pci_bus_distribute_available_resources(b, add_list,
-				available_io, available_mmio,
-				available_mmio_pref);
-		} else if (dev->is_hotplug_bridge) {
+		if (dev->is_hotplug_bridge) {
 			resource_size_t io, mmio, mmio_pref;
 
 			/*
-- 
2.16.3

