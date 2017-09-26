Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2567 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935880AbdIZORz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
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
Subject: [PATCH 4/7] PCI: Distribute available resources to hotplug capable PCIe downstream ports
Date: Tue, 26 Sep 2017 17:17:17 +0300
Message-Id: <20170926141720.25067-5-mika.westerberg@linux.intel.com>
In-Reply-To: <20170926141720.25067-1-mika.westerberg@linux.intel.com>
References: <20170926141720.25067-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The same problem that we have with bus space, applies to other resources
as well. Linux only allocates the minimal amount of resources so that
the devices currently present barely fit there. This prevents extending
the chain later on because the resource windows allocated for hotplug
downstream ports are too small.

Here we follow what we already did for bus number and assign all
available extra resources to hotplug capable PCIe downstream ports. This
makes it possible to extend the hierarchy later.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 169 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 958da7db9033..5df6cbcfbf54 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1853,6 +1853,167 @@ void __init pci_assign_unassigned_resources(void)
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
+	struct resource *io_res, *mmio_res, *mmio_pref_res;
+	struct pci_dev *dev, *bridge = bus->self;
+	unsigned int hotplug_bridges = 0;
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
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		const struct resource *res;
+
+		if (!pci_is_bridge(dev))
+			continue;
+
+		/* Keep track how many hotplug bridges this bus has */
+		if (dev->is_hotplug_bridge) {
+			hotplug_bridges++;
+		} else {
+			/*
+			 * Reduce the available resource space by what
+			 * the bridge and devices below it occupy.
+			 */
+			res = &dev->resource[PCI_BRIDGE_RESOURCES + 0];
+			if (!res->parent && available_io > resource_size(res))
+				remaining_io -= resource_size(res);
+
+			res = &dev->resource[PCI_BRIDGE_RESOURCES + 1];
+			if (!res->parent && available_mmio > resource_size(res))
+				remaining_mmio -= resource_size(res);
+
+			res = &dev->resource[PCI_BRIDGE_RESOURCES + 2];
+			if (!res->parent &&
+			    available_mmio_pref > resource_size(res))
+				remaining_mmio_pref -= resource_size(res);
+		}
+	}
+
+	/*
+	 * Go over devices on this bus and distribute the remaining
+	 * resource space between hotplug bridges.
+	 */
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *b;
+
+		b = dev->subordinate;
+		if (!b || !pci_is_bridge(dev))
+			continue;
+
+		if (pcie_upstream_port(dev)) {
+			/*
+			 * Upstream port gets all resources directly
+			 * from the downstream port.
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
@@ -1867,6 +2028,14 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 
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
2.14.1
