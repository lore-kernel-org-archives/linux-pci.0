Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH RESEND v4 2/9] PCI: Take bridge window alignment into account when distributing resources
Date: Tue,  3 Apr 2018 17:52:18 +0300
Message-Id: <20180403145225.22371-3-mika.westerberg@linux.intel.com>
In-Reply-To: <20180403145225.22371-1-mika.westerberg@linux.intel.com>
References: <20180403145225.22371-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When hot-adding a PCIe switch the way we currently distribute resources
does not always work well because devices connected to the switch might
need to have their MMIO resources aligned to something else than the
default 1 MB boundary. For example Intel Gigabit ET2 quad port server
adapter includes PCIe switch leading to 4 x GbE NIC devices that want
to have their MMIO resources aligned to 2 MB boundary instead.

The current resource distribution code does not take this alignment into
account and might try to add too much resources for the extension
hotplug bridge(s). The resulting bridge window is too big which makes
the resource assignment operation fail, and we are left with a bridge
window with minimal amount (1 MB) of MMIO space.

Here is what happens when an Intel Gigabit ET2 quad port server adapter
is hot-added:

  pci 0000:39:00.0: BAR 14: assigned [mem 0x53300000-0x6a0fffff]
                                          ^^^^^^^^^^
  pci 0000:3a:01.0: BAR 14: assigned [mem 0x53400000-0x547fffff]
                                          ^^^^^^^^^^
The above shows that the downstream bridge (3a:01.0) window is aligned
to 2 MB instead of 1 MB as is the upstream bridge (39:00.0) window. The
remaining MMIO space (0x15a00000) is assigned to the hotplug bridge
(3a:04.0) but it fails:

  pci 0000:3a:04.0: BAR 14: no space for [mem size 0x15a00000]
  pci 0000:3a:04.0: BAR 14: failed to assign [mem size 0x15a00000]

The MMIO resource is calculated as follows:

  start = 0x54800000
  end = 0x54800000 + 0x15a00000 - 1 = 0x6a1fffff

This results bridge window [mem 0x54800000 - 0x6a1fffff] and it ends
after the upstream bridge window [mem 0x53300000-0x6a0fffff] explaining
the above failure. Because of this Linux falls back to the default
allocation of 1 MB as can be seen from 'lspci' output:

 39:00.0 Memory behind bridge: 53300000-6a0fffff [size=366M]
   3a:01.0 Memory behind bridge: 53400000-547fffff [size=20M]
   3a:04.0 Memory behind bridge: 53300000-533fffff [size=1M]

The hotplug bridge 3a:04.0 only occupies 1 MB MMIO window which is
clearly not enough for extending the PCIe topology later if more devices
are to be hot-added.

Fix this by substracting properly aligned non-hotplug downstream bridge
window size from the remaining resources used for extension. After this
change the resource allocation looks like:

  39:00.0 Memory behind bridge: 53300000-6a0fffff [size=366M]
    3a:01.0 Memory behind bridge: 53400000-547fffff [size=20M]
    3a:04.0 Memory behind bridge: 54800000-6a0fffff [size=345M]

This matches the expectation. All the extra MMIO resource space (345 MB)
is allocated to the extension hotplug bridge (3a:04.0).

Fixes: 1a5767725cec ("PCI: Distribute available resources to hotplug-capable bridges")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
2.16.2

