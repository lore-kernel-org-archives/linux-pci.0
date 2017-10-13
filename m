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
Subject: [PATCH v2 4/8] PCI: Distribute available buses to hotplug capable bridges
Date: Fri, 13 Oct 2017 21:35:44 +0300
Message-Id: <20171013183548.68283-5-mika.westerberg@linux.intel.com>
In-Reply-To: <20171013183548.68283-1-mika.westerberg@linux.intel.com>
References: <20171013183548.68283-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

System BIOS sometimes allocates extra bus space for hotplug capable PCIe
root/downstream ports. This space is needed if the device plugged to the
port will have more hotplug capable downstream ports. A good example of
this is Thunderbolt. Each Thunderbolt device contains a PCIe switch and
one or more hotplug capable PCIe downstream ports where the daisy chain
can be extended.

Currently Linux only allocates minimal bus space to make sure all the
enumerated devices barely fit there. The BIOS reserved extra space is
not taken into consideration at all. Because of this we run out of bus
space pretty quickly when more PCIe devices are attached to hotplug
downstream ports in order to extend the chain.

This modifies PCI core so that we distribute the available BIOS
allocated bus space equally between hotplug capable bridges to make sure
there is enough bus space for extending the hierarchy later on.

While there update kernel docs of the affected functions.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/probe.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 138 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 32921f6f21b6..4a1ac6c55aee 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -959,7 +959,21 @@ static void pci_enable_crs(struct pci_dev *pdev)
 					 PCI_EXP_RTCTL_CRSSVE);
 }
 
+static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
+					      unsigned int available_buses);
+
 /*
+ * pci_scan_bridge_extend() - Scan buses behind a bridge
+ * @bus: Parent bus the bridge is on
+ * @dev: Bridge itself
+ * @max: Starting subordinate number of buses behind this bridge
+ * @available_buses: Total number of buses available for this bridge and
+ *		     the devices below. After the minimal bus space has
+ *		     been allocated the remaining buses will be
+ *		     distributed equally between hotplug capable bridges.
+ * @pass: Either %0 (scan already configured bridges) or %1 (scan bridges
+ *        that need to be reconfigured.
+ *
  * If it's a bridge, configure it and scan the bus behind it.
  * For CardBus bridges, we don't scan behind as the devices will
  * be handled by the bridge driver itself.
@@ -969,7 +983,9 @@ static void pci_enable_crs(struct pci_dev *pdev)
  * them, we proceed to assigning numbers to the remaining buses in
  * order to avoid overlaps between old and new bus numbers.
  */
-int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
+static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
+				  int max, unsigned int available_buses,
+				  int pass)
 {
 	struct pci_bus *child;
 	int is_cardbus = (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS);
@@ -1080,6 +1096,9 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 						bus->busn_res.end);
 		}
 		max++;
+		if (available_buses)
+			available_buses--;
+
 		buses = (buses & 0xff000000)
 		      | ((unsigned int)(child->primary)     <<  0)
 		      | ((unsigned int)(child->busn_res.start)   <<  8)
@@ -1101,7 +1120,7 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 
 		if (!is_cardbus) {
 			child->bridge_ctl = bctl;
-			max = pci_scan_child_bus(child);
+			max = pci_scan_child_bus_extend(child, available_buses);
 		} else {
 			/*
 			 * For CardBus bridges, we leave 4 bus numbers
@@ -1169,6 +1188,28 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 
 	return max;
 }
+
+/*
+ * pci_scan_bridge() - Scan buses behind a bridge
+ * @bus: Parent bus the bridge is on
+ * @dev: Bridge itself
+ * @max: Starting subordinate number of buses behind this bridge
+ * @pass: Either %0 (scan already configured bridges) or %1 (scan bridges
+ *        that need to be reconfigured.
+ *
+ * If it's a bridge, configure it and scan the bus behind it.
+ * For CardBus bridges, we don't scan behind as the devices will
+ * be handled by the bridge driver itself.
+ *
+ * We need to process bridges in two passes -- first we scan those
+ * already configured by the BIOS and after we are done with all of
+ * them, we proceed to assigning numbers to the remaining buses in
+ * order to avoid overlaps between old and new bus numbers.
+ */
+int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
+{
+	return pci_scan_bridge_extend(bus, dev, max, 0, pass);
+}
 EXPORT_SYMBOL(pci_scan_bridge);
 
 /*
@@ -2397,9 +2438,24 @@ void __weak pcibios_fixup_bus(struct pci_bus *bus)
        /* nothing to do, expected to be removed in the future */
 }
 
-unsigned int pci_scan_child_bus(struct pci_bus *bus)
+/**
+ * pci_scan_child_bus_extend() - Scan devices below a bus
+ * @bus: Bus to scan for devices
+ * @available_buses: Total number of buses available (%0 does not try to
+ *		     extend beyond the minimal)
+ *
+ * Scans devices below @bus including subordinate buses. Returns new
+ * subordinate number including all the found devices. Passing
+ * @available_buses causes the remaining bus space to be distributed
+ * equally between hotplug capable bridges to allow future extension of the
+ * hierarchy.
+ */
+static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
+					      unsigned int available_buses)
 {
-	unsigned int devfn, max = bus->busn_res.start;
+	unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
+	unsigned int start = bus->busn_res.start;
+	unsigned int devfn, cmax, max = start;
 	struct pci_dev *dev;
 
 	dev_dbg(&bus->dev, "scanning bus\n");
@@ -2409,7 +2465,8 @@ unsigned int pci_scan_child_bus(struct pci_bus *bus)
 		pci_scan_slot(bus, devfn);
 
 	/* Reserve buses for SR-IOV capability. */
-	max += pci_iov_bus_range(bus);
+	used_buses = pci_iov_bus_range(bus);
+	max += used_buses;
 
 	/*
 	 * After performing arch-dependent fixup of the bus, look behind
@@ -2421,29 +2478,73 @@ unsigned int pci_scan_child_bus(struct pci_bus *bus)
 		bus->is_added = 1;
 	}
 
+	/*
+	 * Calculate how many hotplug bridges and normal bridges there
+	 * are on this bus. We will distribute the additional available
+	 * buses between hotplug bridges.
+	 */
+	for_each_pci_bridge(dev, bus) {
+		if (dev->is_hotplug_bridge)
+			hotplug_bridges++;
+		else
+			normal_bridges++;
+	}
+
 	/*
 	 * Scan bridges that are already configured. We don't touch them
 	 * unless they are misconfigured (which will be done in the second
 	 * scan below).
 	 */
-	for_each_pci_bridge(dev, bus)
-		max = pci_scan_bridge(bus, dev, max, 0);
+	for_each_pci_bridge(dev, bus) {
+		cmax = max;
+		max = pci_scan_bridge_extend(bus, dev, max, 0, 0);
+		used_buses += cmax - max;
+	}
 
 	/* Scan bridges that need to be reconfigured */
-	for_each_pci_bridge(dev, bus)
-		max = pci_scan_bridge(bus, dev, max, 1);
+	for_each_pci_bridge(dev, bus) {
+		unsigned int buses = 0;
+
+		if (!hotplug_bridges && normal_bridges == 1) {
+			/*
+			 * There is only one bridge on the bus (upstream
+			 * port) so it gets all available buses which it
+			 * can then distribute to the possible hotplug
+			 * bridges below.
+			 */
+			buses = available_buses;
+		} else if (dev->is_hotplug_bridge) {
+			/*
+			 * Distribute the extra buses between hotplug
+			 * bridges if any.
+			 */
+			buses = available_buses / hotplug_bridges;
+			buses = min(buses, available_buses - used_buses);
+		}
+
+		cmax = max;
+		max = pci_scan_bridge_extend(bus, dev, cmax, buses, 1);
+		used_buses += max - cmax;
+	}
 
 	/*
 	 * Make sure a hotplug bridge has at least the minimum requested
-	 * number of buses.
+	 * number of buses but allow it to grow up to the maximum available
+	 * bus number of there is room.
 	 */
-	if (bus->self && bus->self->is_hotplug_bridge && pci_hotplug_bus_size) {
-		if (max - bus->busn_res.start < pci_hotplug_bus_size - 1)
-			max = bus->busn_res.start + pci_hotplug_bus_size - 1;
-
-		/* Do not allocate more buses than we have room left */
-		if (max > bus->busn_res.end)
-			max = bus->busn_res.end;
+	if (bus->self && bus->self->is_hotplug_bridge) {
+		used_buses = max_t(unsigned int, available_buses,
+				   pci_hotplug_bus_size - 1);
+		if (max - start < used_buses) {
+			max = start + used_buses;
+
+			/* Do not allocate more buses than we have room left */
+			if (max > bus->busn_res.end)
+				max = bus->busn_res.end;
+
+			dev_dbg(&bus->dev, "%pR extended by %#02x\n",
+				&bus->busn_res, max - start);
+		}
 	}
 
 	/*
@@ -2456,6 +2557,18 @@ unsigned int pci_scan_child_bus(struct pci_bus *bus)
 	dev_dbg(&bus->dev, "bus scan returning with max=%02x\n", max);
 	return max;
 }
+
+/**
+ * pci_scan_child_bus() - Scan devices below a bus
+ * @bus: Bus to scan for devices
+ *
+ * Scans devices below @bus including subordinate buses. Returns new
+ * subordinate number including all the found devices.
+ */
+unsigned int pci_scan_child_bus(struct pci_bus *bus)
+{
+	return pci_scan_child_bus_extend(bus, 0);
+}
 EXPORT_SYMBOL_GPL(pci_scan_child_bus);
 
 /**
@@ -2753,6 +2866,7 @@ int pci_hp_add_bridge(struct pci_dev *dev)
 {
 	struct pci_bus *parent = dev->bus;
 	int busnr, start = parent->busn_res.start;
+	unsigned int available_buses = 0;
 	int end = parent->busn_res.end;
 
 	for (busnr = start; busnr <= end; busnr++) {
@@ -2768,8 +2882,14 @@ int pci_hp_add_bridge(struct pci_dev *dev)
 	/* Scan bridges that are already configured */
 	busnr = pci_scan_bridge(parent, dev, busnr, 0);
 
+	/*
+	 * Distribute the available bus numbers between hotplug capable
+	 * bridges to make extending the chain later possible.
+	 */
+	available_buses = end - busnr;
+
 	/* Scan bridges that need to be reconfigured */
-	pci_scan_bridge(parent, dev, busnr, 1);
+	pci_scan_bridge_extend(parent, dev, busnr, available_buses, 1);
 
 	if (!dev->subordinate)
 		return -1;
-- 
2.14.2
