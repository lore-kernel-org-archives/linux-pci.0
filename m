Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v3 1/5] PCI: Make sure all bridges reserve at least one bus number
Date: Mon, 26 Feb 2018 16:21:08 +0300
Message-Id: <20180226132112.81447-2-mika.westerberg@linux.intel.com>
In-Reply-To: <20180226132112.81447-1-mika.westerberg@linux.intel.com>
References: <20180226132112.81447-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When distributing extra buses between hotplug bridges we need to make
sure each bridge reserve at least one bus number, even if there is
currently nothing connected to it. For instance ACPI hotplug may bring
in additional devices to non-hotplug bridges later on.

Here is what happens on one system when a Thunderbolt device is plugged in:

  pci 0000:01:00.0: PCI bridge to [bus 02-39]
  ...
  pci_bus 0000:04: [bus 04-39] extended by 0x35
  pci_bus 0000:04: bus scan returning with max=39
  pci_bus 0000:04: busn_res: [bus 04-39] end is updated to 39
  pci 0000:02:02.0: scanning [bus 00-00] behind bridge, pass 1
  pci_bus 0000:3a: scanning bus
  pci_bus 0000:3a: bus scan returning with max=3a
  pci_bus 0000:3a: busn_res: [bus 3a] end is updated to 3a
  pci_bus 0000:3a: [bus 3a] partially hidden behind bridge 0000:02 [bus 02-39]
  pci_bus 0000:3a: [bus 3a] partially hidden behind bridge 0000:01 [bus 01-39]
  pci_bus 0000:02: bus scan returning with max=3a
  pci_bus 0000:02: busn_res: [bus 02-39] end can not be updated to 3a

Resulting 'lspci -t' output looks like this:

  +-1b.0-[01-39]----00.0-[02-3a]--+-00.0-[03]----00.0
                                  +-01.0-[04-39]--
                                  \-02.0-[3a]----00.0

The device behind downstream port at 02:02 is the integrated xHCI (USB 3
host controller) and is not fully accessible because the hotplug bridge
is reserving too many bus numbers.

To make sure we don't run out of bus numbers for non-hotplug bridges reserve
one bus number for them upfront before distributing buses for hotplug bridges.

Fixes: 1c02ea810065 ("PCI: Distribute available buses to hotplug-capable bridges")
Reported-by: Mario Limonciello <mario.limonciello@dell.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/probe.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ef5377438a1e..6cefd47556e3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2561,7 +2561,10 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 	for_each_pci_bridge(dev, bus) {
 		cmax = max;
 		max = pci_scan_bridge_extend(bus, dev, max, 0, 0);
-		used_buses += cmax - max;
+		/* Reserve one bus for each bridge */
+		used_buses++;
+		if (cmax - max > 1)
+			used_buses += cmax - max - 1;
 	}
 
 	/* Scan bridges that need to be reconfigured */
@@ -2584,12 +2587,14 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 			 * bridges if any.
 			 */
 			buses = available_buses / hotplug_bridges;
-			buses = min(buses, available_buses - used_buses);
+			buses = min(buses, available_buses - used_buses + 1);
 		}
 
 		cmax = max;
 		max = pci_scan_bridge_extend(bus, dev, cmax, buses, 1);
-		used_buses += max - cmax;
+		/* One bus is already accounted so don't add it again */
+		if (max - cmax > 1)
+			used_buses += max - cmax - 1;
 	}
 
 	/*
-- 
2.16.1

