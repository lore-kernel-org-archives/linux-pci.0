Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:54772 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935768AbdIZORz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Sep 2017 10:17:55 -0400
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
Subject: [PATCH 3/7] PCI: Distribute available buses to hotplug capable PCIe downstream ports
Date: Tue, 26 Sep 2017 17:17:16 +0300
Message-Id: <20170926141720.25067-4-mika.westerberg@linux.intel.com>
In-Reply-To: <20170926141720.25067-1-mika.westerberg@linux.intel.com>
References: <20170926141720.25067-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
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
allocated bus space equally between hotplug capable PCIe downstream
ports to make sure there is enough bus space for extending the
hierarchy later on.

While there update kernel docs of the affected functions.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/hotplug-pci.c |  13 +++++-
 drivers/pci/probe.c       | 114 ++++++++++++++++++++++++++++++++++++++--------
 include/linux/pci.h       |  19 ++++++--
 3 files changed, 123 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/hotplug-pci.c b/drivers/pci/hotplug-pci.c
index c68366cee6b7..deb06fe22b26 100644
--- a/drivers/pci/hotplug-pci.c
+++ b/drivers/pci/hotplug-pci.c
@@ -8,6 +8,7 @@ int pci_hp_add_bridge(struct pci_dev *dev)
 {
 	struct pci_bus *parent = dev->bus;
 	int pass, busnr, start = parent->busn_res.start;
+	unsigned int available_buses = 0;
 	int end = parent->busn_res.end;
 
 	for (busnr = start; busnr <= end; busnr++) {
@@ -19,8 +20,18 @@ int pci_hp_add_bridge(struct pci_dev *dev)
 				pci_name(dev));
 		return -1;
 	}
+
+	/*
+	 * In case of PCIe the hierarchy can be extended through hotplug
+	 * capable downstream ports. Distribute the available bus
+	 * numbers between them to make extending the chain possible.
+	 */
+	if (pci_is_pcie(dev))
+		available_buses = end - busnr;
+
 	for (pass = 0; pass < 2; pass++)
-		busnr = pci_scan_bridge(parent, dev, busnr, pass);
+		busnr = pci_scan_bridge_extend(parent, dev, busnr,
+					       available_buses, pass);
 	if (!dev->subordinate)
 		return -1;
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f285cd74088e..ae0bf3c807f5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -960,6 +960,17 @@ static void pci_enable_crs(struct pci_dev *pdev)
 }
 
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
@@ -969,7 +980,8 @@ static void pci_enable_crs(struct pci_dev *pdev)
  * them, we proceed to assigning numbers to the remaining buses in
  * order to avoid overlaps between old and new bus numbers.
  */
-int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
+int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev, int max,
+			   unsigned int available_buses, int pass)
 {
 	struct pci_bus *child;
 	int is_cardbus = (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS);
@@ -1080,6 +1092,9 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 						bus->busn_res.end);
 		}
 		max++;
+		if (available_buses)
+			available_buses--;
+
 		buses = (buses & 0xff000000)
 		      | ((unsigned int)(child->primary)     <<  0)
 		      | ((unsigned int)(child->busn_res.start)   <<  8)
@@ -1101,7 +1116,7 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 
 		if (!is_cardbus) {
 			child->bridge_ctl = bctl;
-			max = pci_scan_child_bus(child);
+			max = pci_scan_child_bus_extend(child, available_buses);
 		} else {
 			/*
 			 * For CardBus bridges, we leave 4 bus numbers
@@ -1169,7 +1184,7 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 
 	return max;
 }
-EXPORT_SYMBOL(pci_scan_bridge);
+EXPORT_SYMBOL(pci_scan_bridge_extend);
 
 /*
  * Read interrupt line and base address registers.
@@ -2397,9 +2412,24 @@ void __weak pcibios_fixup_bus(struct pci_bus *bus)
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
+ * equally between hotplug capable bridges to allow future extension of
+ * the hierarchy.
+ */
+unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
+				       unsigned int available_buses)
 {
-	unsigned int devfn, pass, max = bus->busn_res.start;
+	unsigned int used_buses, hotplug_bridges = 0;
+	unsigned int start = bus->busn_res.start;
+	unsigned int devfn, cmax, max = start;
 	struct pci_dev *dev;
 
 	dev_dbg(&bus->dev, "scanning bus\n");
@@ -2409,7 +2439,8 @@ unsigned int pci_scan_child_bus(struct pci_bus *bus)
 		pci_scan_slot(bus, devfn);
 
 	/* Reserve buses for SR-IOV capability. */
-	max += pci_iov_bus_range(bus);
+	used_buses = pci_iov_bus_range(bus);
+	max += used_buses;
 
 	/*
 	 * After performing arch-dependent fixup of the bus, look behind
@@ -2421,23 +2452,68 @@ unsigned int pci_scan_child_bus(struct pci_bus *bus)
 		bus->is_added = 1;
 	}
 
-	for (pass = 0; pass < 2; pass++)
-		list_for_each_entry(dev, &bus->devices, bus_list) {
-			if (pci_is_bridge(dev))
-				max = pci_scan_bridge(bus, dev, max, pass);
+	/*
+	 * First pass. Bridges that are already configured. We don't touch
+	 * these unless they are misconfigured (which we will do in second
+	 * pass).
+	 */
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (pci_is_bridge(dev)) {
+			/*
+			 * Calculate how many hotplug bridges there are on
+			 * this bus. We will distribute the additional
+			 * available buses between them.
+			 */
+			if (dev->is_hotplug_bridge)
+				hotplug_bridges++;
+
+			cmax = max;
+			max = pci_scan_bridge_extend(bus, dev, max, 0, 0);
+			used_buses += cmax - max;
+		}
+	}
+
+	/* Second pass. Bridges that need to be configured. */
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (pci_is_bridge(dev)) {
+			unsigned int buses = 0;
+
+			if (pcie_upstream_port(dev)) {
+				/* Upstream port gets all available buses */
+				buses = available_buses;
+			} else if (dev->is_hotplug_bridge) {
+				/*
+				 * Distribute the extra buses between
+				 * hotplug bridges if any.
+				 */
+				buses = available_buses / hotplug_bridges;
+				buses = min(buses, available_buses - used_buses);
+			}
+
+			cmax = max;
+			max = pci_scan_bridge_extend(bus, dev, cmax, buses, 1);
+			used_buses += max - cmax;
 		}
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
@@ -2450,7 +2526,7 @@ unsigned int pci_scan_child_bus(struct pci_bus *bus)
 	dev_dbg(&bus->dev, "bus scan returning with max=%02x\n", max);
 	return max;
 }
-EXPORT_SYMBOL_GPL(pci_scan_child_bus);
+EXPORT_SYMBOL_GPL(pci_scan_child_bus_extend);
 
 /**
  * pcibios_root_bridge_prepare - Platform-specific host bridge setup.
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4397692be538..c9b34c2de0fb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -909,7 +909,14 @@ static inline void pci_dev_assign_slot(struct pci_dev *dev) { }
 int pci_scan_slot(struct pci_bus *bus, int devfn);
 struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus);
-unsigned int pci_scan_child_bus(struct pci_bus *bus);
+unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
+				       unsigned int available_buses);
+
+static inline unsigned int pci_scan_child_bus(struct pci_bus *bus)
+{
+	return pci_scan_child_bus_extend(bus, 0);
+}
+
 void pci_bus_add_device(struct pci_dev *dev);
 void pci_read_bridge_bases(struct pci_bus *child);
 struct resource *pci_find_parent_resource(const struct pci_dev *dev,
@@ -1292,8 +1299,14 @@ int pci_add_dynid(struct pci_driver *drv,
 		  unsigned long driver_data);
 const struct pci_device_id *pci_match_id(const struct pci_device_id *ids,
 					 struct pci_dev *dev);
-int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
-		    int pass);
+int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev, int max,
+			   unsigned int available_buses, int pass);
+
+static inline int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev,
+				  int max, int pass)
+{
+	return pci_scan_bridge_extend(bus, dev, max, 0, pass);
+}
 
 void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 		  void *userdata);
-- 
2.14.1
