Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Mario.Limonciello@dell.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] PCI: Do not allocate more buses than available in parent
Date: Tue, 26 Sep 2017 17:17:14 +0300
Message-Id: <20170926141720.25067-2-mika.westerberg@linux.intel.com>
In-Reply-To: <20170926141720.25067-1-mika.westerberg@linux.intel.com>
References: <20170926141720.25067-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

One can ask more buses to be reserved for hotplug bridges by passing
pci=hpbussize=N in the kernel command line. However, if the parent bus
does not have enough bus space available we still create child bus with
the requested number of subordinate buses.

In the example below hpbussize is set to one more than we have available
buses in the root port:

  pci 0000:07:00.0: [8086:1578] type 01 class 0x060400
  pci 0000:07:00.0: calling pci_fixup_transparent_bridge+0x0/0x20
  pci 0000:07:00.0: supports D1 D2
  pci 0000:07:00.0: PME# supported from D0 D1 D2 D3hot D3cold
  pci 0000:07:00.0: PME# disabled
  pci 0000:07:00.0: scanning [bus 00-00] behind bridge, pass 0
  pci 0000:07:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
  pci 0000:07:00.0: scanning [bus 00-00] behind bridge, pass 1
  pci_bus 0000:08: busn_res: can not insert [bus 08-ff] under [bus 07-3f] (conflicts with (null) [bus 07-3f])
  pci_bus 0000:08: scanning bus
  ...
  pci_bus 0000:0a: bus scan returning with max=40
  pci_bus 0000:0a: busn_res: [bus 0a-ff] end is updated to 40
  pci_bus 0000:0a: [bus 0a-40] partially hidden behind bridge 0000:07 [bus 07-3f]
  pci_bus 0000:08: bus scan returning with max=40
  pci_bus 0000:08: busn_res: [bus 08-ff] end is updated to 40

Instead of allowing this we limit the subordinate number to be less than
or equal the maximum subordinate number allocated for the parent bus (if
it has any).

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/probe.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ff94b69738a8..f285cd74088e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1076,7 +1076,8 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 			child = pci_add_new_bus(bus, dev, max+1);
 			if (!child)
 				goto out;
-			pci_bus_insert_busn_res(child, max+1, 0xff);
+			pci_bus_insert_busn_res(child, max+1,
+						bus->busn_res.end);
 		}
 		max++;
 		buses = (buses & 0xff000000)
@@ -2433,6 +2434,10 @@ unsigned int pci_scan_child_bus(struct pci_bus *bus)
 	if (bus->self && bus->self->is_hotplug_bridge && pci_hotplug_bus_size) {
 		if (max - bus->busn_res.start < pci_hotplug_bus_size - 1)
 			max = bus->busn_res.start + pci_hotplug_bus_size - 1;
+
+		/* Do not allocate more buses than we have room left */
+		if (max > bus->busn_res.end)
+			max = bus->busn_res.end;
 	}
 
 	/*
-- 
2.14.1
