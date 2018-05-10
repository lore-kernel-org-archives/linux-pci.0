Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v6 09/12] PCI: Move resource distribution for a single bridge outside of the loop
Date: Thu, 10 May 2018 21:28:41 +0300
Message-Id: <20180510182844.77349-10-mika.westerberg@linux.intel.com>
In-Reply-To: <20180510182844.77349-1-mika.westerberg@linux.intel.com>
References: <20180510182844.77349-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is a special case where there is only single bridge on the bus. In
that case we just assign all resources to it. Currently this is done as
a part of the resource distribution loop but it does not have to be
there, and moving it outside actually improves readability because we
can then save one indent level in the loop.

While there we can add hotplug_bridges == 1 && normal_bridges == 0 to
the same block because they are dealt the same way.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/setup-bus.c | 82 ++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 072784f55ea5..79b1824e83b4 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1942,57 +1942,57 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 			remaining_mmio_pref -= resource_size(res);
 	}
 
+	/*
+	 * There is only one bridge on the bus so it gets all available
+	 * resources which it can then distribute to the possible
+	 * hotplug bridges below.
+	 */
+	if (hotplug_bridges + normal_bridges == 1) {
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
 	 */
 	for_each_pci_bridge(dev, bus) {
+		resource_size_t align, io, mmio, mmio_pref;
 		struct pci_bus *b;
 
 		b = dev->subordinate;
-		if (!b)
+		if (!b || !dev->is_hotplug_bridge)
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
-			resource_size_t align, io, mmio, mmio_pref;
-
-			/*
-			 * Distribute available extra resources equally
-			 * between hotplug-capable downstream ports
-			 * taking alignment into account.
-			 *
-			 * Here hotplug_bridges is always != 0.
-			 */
-			align = pci_resource_alignment(bridge, io_res);
-			io = div64_ul(available_io, hotplug_bridges);
-			io = min(ALIGN(io, align), remaining_io);
-			remaining_io -= io;
-
-			align = pci_resource_alignment(bridge, mmio_res);
-			mmio = div64_ul(available_mmio, hotplug_bridges);
-			mmio = min(ALIGN(mmio, align), remaining_mmio);
-			remaining_mmio -= mmio;
-
-			align = pci_resource_alignment(bridge, mmio_pref_res);
-			mmio_pref = div64_ul(available_mmio_pref,
-					     hotplug_bridges);
-			mmio_pref = min(ALIGN(mmio_pref, align),
-					remaining_mmio_pref);
-			remaining_mmio_pref -= mmio_pref;
-
-			pci_bus_distribute_available_resources(b, add_list, io,
-							       mmio, mmio_pref);
-		}
+		/*
+		 * Distribute available extra resources equally between
+		 * hotplug-capable downstream ports taking alignment into
+		 * account.
+		 *
+		 * Here hotplug_bridges is always != 0.
+		 */
+		align = pci_resource_alignment(bridge, io_res);
+		io = div64_ul(available_io, hotplug_bridges);
+		io = min(ALIGN(io, align), remaining_io);
+		remaining_io -= io;
+
+		align = pci_resource_alignment(bridge, mmio_res);
+		mmio = div64_ul(available_mmio, hotplug_bridges);
+		mmio = min(ALIGN(mmio, align), remaining_mmio);
+		remaining_mmio -= mmio;
+
+		align = pci_resource_alignment(bridge, mmio_pref_res);
+		mmio_pref = div64_ul(available_mmio_pref, hotplug_bridges);
+		mmio_pref = min(ALIGN(mmio_pref, align), remaining_mmio_pref);
+		remaining_mmio_pref -= mmio_pref;
+
+		pci_bus_distribute_available_resources(b, add_list, io, mmio,
+						       mmio_pref);
 	}
 }
 
-- 
2.17.0

