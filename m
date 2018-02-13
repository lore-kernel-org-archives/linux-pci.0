Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 2/5] PCI: Take bridge window alignment into account when distributing resources
Date: Tue, 13 Feb 2018 19:31:57 +0300
Message-Id: <20180213163200.8787-3-mika.westerberg@linux.intel.com>
In-Reply-To: <20180213163200.8787-1-mika.westerberg@linux.intel.com>
References: <20180213163200.8787-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When connecting a Thunderbolt endpoint which itself has internal PCIe
switch (not the integrated one) the way we currently distribute
resources does not always work well because devices below non-hotplug
bridges might need to have their MMIO resources aligned to something
else than 1 MB boundary. As an example connecting a server grade 4-port
GbE add in card adds another PCIe switch leading to GbE devices that
want to have their MMIO resources aligned to 2 MB boundary instead.

Current resource distribution code does not take this alignment into
account and might try to add too much resources for the extension
hotplug bridges. The resulting bridge window is then too big which makes
Linux to re-allocate minimal amount of resources, making future
extension impossible.

Make this work better by substracting properly aligned non-hotplug
downstream bridge window size from the remaining resources.

Fixes: 1a5767725cec ("PCI: Distribute available resources to hotplug-capable bridges")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/setup-bus.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 3cce29a069e6..f1e6172734f0 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1882,6 +1882,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	resource_size_t available_mmio, resource_size_t available_mmio_pref)
 {
 	resource_size_t remaining_io, remaining_mmio, remaining_mmio_pref;
+	resource_size_t io_start, mmio_start, mmio_pref_start;
 	unsigned int normal_bridges = 0, hotplug_bridges = 0;
 	struct resource *io_res, *mmio_res, *mmio_pref_res;
 	struct pci_dev *dev, *bridge = bus->self;
@@ -1946,11 +1947,16 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 			remaining_mmio_pref -= resource_size(res);
 	}
 
+	io_start = io_res->start;
+	mmio_start = mmio_res->start;
+	mmio_pref_start = mmio_pref_res->start;
+
 	/*
 	 * Go over devices on this bus and distribute the remaining
 	 * resource space between hotplug bridges.
 	 */
 	for_each_pci_bridge(dev, bus) {
+		resource_size_t align;
 		struct pci_bus *b;
 
 		b = dev->subordinate;
@@ -1968,7 +1974,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 				available_io, available_mmio,
 				available_mmio_pref);
 		} else if (dev->is_hotplug_bridge) {
-			resource_size_t align, io, mmio, mmio_pref;
+			resource_size_t io, mmio, mmio_pref;
 
 			/*
 			 * Distribute available extra resources equally
@@ -1981,11 +1987,13 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 			io = div64_ul(available_io, hotplug_bridges);
 			io = min(ALIGN(io, align), remaining_io);
 			remaining_io -= io;
+			io_start += io;
 
 			align = pci_resource_alignment(bridge, mmio_res);
 			mmio = div64_ul(available_mmio, hotplug_bridges);
 			mmio = min(ALIGN(mmio, align), remaining_mmio);
 			remaining_mmio -= mmio;
+			mmio_start += mmio;
 
 			align = pci_resource_alignment(bridge, mmio_pref_res);
 			mmio_pref = div64_ul(available_mmio_pref,
@@ -1993,9 +2001,40 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 			mmio_pref = min(ALIGN(mmio_pref, align),
 					remaining_mmio_pref);
 			remaining_mmio_pref -= mmio_pref;
+			mmio_pref_start += mmio_pref;
 
 			pci_bus_distribute_available_resources(b, add_list, io,
 							       mmio, mmio_pref);
+		} else {
+			/*
+			 * For normal bridges, track start of the parent
+			 * bridge window to make sure we align the
+			 * remaining space which is distributed to the
+			 * hotplug bridges properly.
+			 */
+			resource_size_t aligned;
+			struct resource *res;
+
+			res = &dev->resource[PCI_BRIDGE_RESOURCES + 0];
+			io_start += resource_size(res);
+			aligned = ALIGN(io_start,
+					pci_resource_alignment(dev, res));
+			if (aligned > io_start)
+				remaining_io -= aligned - io_start;
+
+			res = &dev->resource[PCI_BRIDGE_RESOURCES + 1];
+			mmio_start += resource_size(res);
+			aligned = ALIGN(mmio_start,
+					pci_resource_alignment(dev, res));
+			if (aligned > mmio_start)
+				remaining_mmio -= aligned - mmio_start;
+
+			res = &dev->resource[PCI_BRIDGE_RESOURCES + 2];
+			mmio_pref_start += resource_size(res);
+			aligned = ALIGN(mmio_pref_start,
+					pci_resource_alignment(dev, res));
+			if (aligned > mmio_pref_start)
+				remaining_mmio_pref -= aligned - mmio_pref_start;
 		}
 	}
 }
-- 
2.15.1

