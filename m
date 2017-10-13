Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:5357 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752932AbdJMSf4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Oct 2017 14:35:56 -0400
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
Subject: [PATCH v2 5/8] PCI: Distribute available resources to hotplug capable bridges
Date: Fri, 13 Oct 2017 21:35:45 +0300
Message-Id: <20171013183548.68283-6-mika.westerberg@linux.intel.com>
In-Reply-To: <20171013183548.68283-1-mika.westerberg@linux.intel.com>
References: <20171013183548.68283-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The same problem that we have with bus space, applies to other resources
as well. Linux only allocates the minimal amount of resources so that
the devices currently present barely fit there. This prevents extending
the chain later on because the resource windows allocated for hotplug
downstream ports are too small.

Here we follow what we already did for bus number and assign all
available extra resources to hotplug capable bridges. This makes it
possible to extend the hierarchy later.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 177 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7ca03407404c..7b85342ad3c3 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1853,6 +1853,175 @@ void __init pci_assign_unassigned_resources(void)
 	}
 }
 
+static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
+			struct list_head *add_list, resource_size_t available)
+{
+	struct pci_dev_resource *dev_res;
+
+	if (res->parent)
+		return;
+
+	if (resource_size(res) >= available)
+		return;
+
+	dev_res = res_to_dev_res(add_list, res);
+	if (!dev_res)
+		return;
+
+	/* Is there room to extend the window */
+	if (available - resource_size(res) <= dev_res->add_size)
+		return;
+
+	dev_res->add_size = available - resource_size(res);
+	dev_dbg(&bridge->dev, "bridge window %pR extended by %pa\n", res,
+		&dev_res->add_size);
+}
+
+static void pci_bus_distribute_available_resources(struct pci_bus *bus,
+	struct list_head *add_list, resource_size_t available_io,
+	resource_size_t available_mmio, resource_size_t available_mmio_pref)
+{
+	resource_size_t remaining_io, remaining_mmio, remaining_mmio_pref;
+	unsigned int normal_bridges = 0, hotplug_bridges = 0;
+	struct resource *io_res, *mmio_res, *mmio_pref_res;
+	struct pci_dev *dev, *bridge = bus->self;
+
+	io_res = &bridge->resource[PCI_BRIDGE_RESOURCES + 0];
+	mmio_res = &bridge->resource[PCI_BRIDGE_RESOURCES + 1];
+	mmio_pref_res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
+
+	/*
+	 * Update additional resource list (add_list) to fill all the
+	 * extra resource space available for this port except the space
+	 * calculated in __pci_bus_size_bridges() which covers all the
+	 * devices currently connected to the port and below.
+	 */
+	extend_bridge_window(bridge, io_res, add_list, available_io);
+	extend_bridge_window(bridge, mmio_res, add_list, available_mmio);
+	extend_bridge_window(bridge, mmio_pref_res, add_list,
+			     available_mmio_pref);
+
+	/*
+	 * Calculate the total amount of extra resource space we can
+	 * pass the to bridges below this one. This is basically the
+	 * extra space substracted by the minimal required space for the
+	 * non-hotplug bridges.
+	 */
+	remaining_io = available_io;
+	remaining_mmio = available_mmio;
+	remaining_mmio_pref = available_mmio_pref;
+
+	/*
+	 * Calculate how many hotplug bridges and normal bridges there
+	 * are on this bus. We will distribute the additional available
+	 * resources between hotplug bridges.
+	 */
+	for_each_pci_bridge(dev, bus) {
+		if (dev->is_hotplug_bridge)
+			hotplug_bridges++;
+		else
+			normal_bridges++;
+	}
+
+	for_each_pci_bridge(dev, bus) {
+		const struct resource *res;
+
+		if (dev->is_hotplug_bridge)
+			continue;
+
+		/*
+		 * Reduce the available resource space by what the
+		 * bridge and devices below it occupy.
+		 */
+		res = &dev->resource[PCI_BRIDGE_RESOURCES + 0];
+		if (!res->parent && available_io > resource_size(res))
+			remaining_io -= resource_size(res);
+
+		res = &dev->resource[PCI_BRIDGE_RESOURCES + 1];
+		if (!res->parent && available_mmio > resource_size(res))
+			remaining_mmio -= resource_size(res);
+
+		res = &dev->resource[PCI_BRIDGE_RESOURCES + 2];
+		if (!res->parent && available_mmio_pref > resource_size(res))
+			remaining_mmio_pref -= resource_size(res);
+	}
+
+	/*
+	 * Go over devices on this bus and distribute the remaining
+	 * resource space between hotplug bridges.
+	 */
+	for_each_pci_bridge(dev, bus) {
+		struct pci_bus *b;
+
+		b = dev->subordinate;
+		if (!b)
+			continue;
+
+		if (!hotplug_bridges && normal_bridges == 1) {
+			/*
+			 * There is only one bridge on the bus (upstream
+			 * port) so it gets all available resources
+			 * which it can then distribute to the possible
+			 * hotplug bridges below.
+			 */
+			pci_bus_distribute_available_resources(b, add_list,
+				available_io, available_mmio,
+				available_mmio_pref);
+		} else if (dev->is_hotplug_bridge) {
+			resource_size_t align, io, mmio, mmio_pref;
+
+			/*
+			 * Distribute available extra resources equally
+			 * between hotplug capable downstream ports
+			 * taking alignment into account.
+			 *
+			 * Here hotplug_bridges is always != 0.
+			 */
+			align = pci_resource_alignment(bridge, io_res);
+			io = div64_ul(available_io, hotplug_bridges);
+			io = min(ALIGN(io, align), remaining_io);
+			remaining_io -= io;
+
+			align = pci_resource_alignment(bridge, mmio_res);
+			mmio = div64_ul(available_mmio, hotplug_bridges);
+			mmio = min(ALIGN(mmio, align), remaining_mmio);
+			remaining_mmio -= mmio;
+
+			align = pci_resource_alignment(bridge, mmio_pref_res);
+			mmio_pref = div64_ul(available_mmio_pref,
+					     hotplug_bridges);
+			mmio_pref = min(ALIGN(mmio_pref, align),
+					remaining_mmio_pref);
+			remaining_mmio_pref -= mmio_pref;
+
+			pci_bus_distribute_available_resources(b, add_list, io,
+							       mmio, mmio_pref);
+		}
+	}
+}
+
+static void
+pci_bridge_distribute_available_resources(struct pci_dev *bridge,
+					  struct list_head *add_list)
+{
+	resource_size_t available_io, available_mmio, available_mmio_pref;
+	const struct resource *res;
+
+	if (!bridge->is_hotplug_bridge)
+		return;
+
+	/* Take the initial extra resources from the hotplug port */
+	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 0];
+	available_io = resource_size(res);
+	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 1];
+	available_mmio = resource_size(res);
+	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
+	available_mmio_pref = resource_size(res);
+
+	pci_bus_distribute_available_resources(bridge->subordinate,
+		add_list, available_io, available_mmio, available_mmio_pref);
+}
+
 void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 {
 	struct pci_bus *parent = bridge->subordinate;
@@ -1867,6 +2036,14 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 
 again:
 	__pci_bus_size_bridges(parent, &add_list);
+
+	/*
+	 * Distribute remaining resources (if any) equally between
+	 * hotplug bridges below. This makes it possible to extend the
+	 * hierarchy later without running out of resources.
+	 */
+	pci_bridge_distribute_available_resources(bridge, &add_list);
+
 	__pci_bridge_assign_resources(bridge, &add_list, &fail_head);
 	BUG_ON(!list_empty(&add_list));
 	tried_times++;
-- 
2.14.2
