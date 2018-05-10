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
Subject: [PATCH v6 01/12] PCI: Take all bridges into account when calculating bus numbers for extension
Date: Thu, 10 May 2018 21:28:33 +0300
Message-Id: <20180510182844.77349-2-mika.westerberg@linux.intel.com>
In-Reply-To: <20180510182844.77349-1-mika.westerberg@linux.intel.com>
References: <20180510182844.77349-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When distributing extra buses between hotplug bridges for future
extension we currently fail to take into account the fact that there
might be non-hotplug bridges on the bus after the hotplug bridges. In
this particular system we have following topology:

  01:00.0 --+- 02:00.0 -- Thunderbolt host controller
            +- 02:01.0 (HotPlug+)
            \- 02:02.0 -- xHCI host controller

Now, pci_scan_child_bus_extend() is supposed to distribute remaining bus
numbers to the hotplug bridge at 02:01.0 but only after all bridges on
that bus have been been accounted for. Since we don't check upfront that
there will be another non-hotplug bridge after the hotplug bridge
02:01.0 it will inadvertently extend over the bus space of the
non-hotplug bridge:

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
                             ^^   +-01.0-[04-39]--
                                  \-02.0-[3a]----00.0
                                          ^^
The xHCI host controller (3a:00.0) behind downstream bridge at 02:02.0
is not usable anymore.

To fix this reserve at least one bus for each bridge during scanning of
already configured bridges. Then we use this information in the second
scan to correct the available extra bus space for hotplug bridges.

After this change the 'lspci -t' output is what is expected:

  +-1b.0-[01-39]----00.0-[02-39]--+-00.0-[03]----00.0
                                  +-01.0-[04-38]--
                                  \-02.0-[39]----00.0

Fixes: 1c02ea810065 ("PCI: Distribute available buses to hotplug-capable bridges")
Reported-by: Mario Limonciello <mario.limonciello@dell.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/probe.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac91b6fd0bcd..7c34a2ccb514 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2638,7 +2638,14 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 	for_each_pci_bridge(dev, bus) {
 		cmax = max;
 		max = pci_scan_bridge_extend(bus, dev, max, 0, 0);
-		used_buses += cmax - max;
+		/*
+		 * Reserve one bus for each bridge now to avoid
+		 * extending hotplug bridges too much during the second
+		 * scan below.
+		 */
+		used_buses++;
+		if (cmax - max > 1)
+			used_buses += cmax - max - 1;
 	}
 
 	/* Scan bridges that need to be reconfigured */
@@ -2661,12 +2668,14 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
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
2.17.0

