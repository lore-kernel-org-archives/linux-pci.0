Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35443 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750801AbcKYK5W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2016 05:57:22 -0500
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tn@semihalf.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v4 01/10] PCI: Add new method for registering PCI hosts
Date: Fri, 25 Nov 2016 11:57:09 +0100
Message-Id: <20161125105718.3866-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

This patch makes the existing pci_host_bridge structure a proper device
that is usable by PCI host drivers in a more standard way. In addition
to the existing pci_scan_bus, pci_scan_root_bus, pci_scan_root_bus_msi,
and pci_create_root_bus interfaces, this unfortunately means having to
add yet another interface doing basically the same thing, and add some
extra code in the initial step.

However, this time it's more likely to be extensible enough that we
won't have to do another one again in the future, and we should be
able to reduce code much more as a result.

The main idea is to pull the allocation of 'struct pci_host_bridge' out
of the registration, and let individual host drivers and architecture
code fill the members before calling the registration function.

There are a number of things we can do based on this:

* Use a single memory allocation for the driver-specific structure
  and the generic PCI host bridge
* consolidate the contents of driver specific structures by moving
  them into pci_host_bridge
* Add a consistent interface for removing a PCI host bridge again
  when unloading a host driver module
* Replace the architecture specific __weak pcibios_* functions with
  callbacks in a pci_host_bridge device
* Move common boilerplate code from host drivers into the generic
  function, based on contents of the structure
* Extend pci_host_bridge with additional members when needed without
  having to add arguments to pci_scan_*.
* Move members of struct pci_bus into pci_host_bridge to avoid
  having lots of identical copies.

As mentioned in a previous email, one open question is whether we want
to export a function for allocating a pci_host_bridge device in
combination with the per-device structure or let the driver itself
call kzalloc.

Changes in v3 (Thierry Reding):
- swap out pci_host_bridge_init() for pci_alloc_host_bridge() with an
  extra parameter specifying the size of the driver's private data
- rename pci_host_bridge_register() to pci_register_host_bridge() for
  more consistency with existing functions
- split patches into smaller chunks to make diff more readable

Changes in v2 (Thierry Reding):
- add a pci_host_bridge_init() helper that drivers can use to perform
  all the necessary steps to initialize the bridge
- rename pci_register_host() to pci_host_bridge_register() to reflect
  the naming used by other functions
- plug memory leak on registration failure

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/probe.c | 238 +++++++++++++++++++++++++++++++---------------------
 include/linux/pci.h |   4 +
 2 files changed, 145 insertions(+), 97 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 104c46d53121..99f503c3ab81 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -521,7 +521,7 @@ static void pci_release_host_bridge_dev(struct device *dev)
 	kfree(bridge);
 }
 
-static struct pci_host_bridge *pci_alloc_host_bridge(struct pci_bus *b)
+static struct pci_host_bridge *pci_alloc_host_bridge(void)
 {
 	struct pci_host_bridge *bridge;
 
@@ -530,7 +530,7 @@ static struct pci_host_bridge *pci_alloc_host_bridge(struct pci_bus *b)
 		return NULL;
 
 	INIT_LIST_HEAD(&bridge->windows);
-	bridge->bus = b;
+
 	return bridge;
 }
 
@@ -717,6 +717,122 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
 	dev_set_msi_domain(&bus->dev, d);
 }
 
+static int pci_register_host_bridge(struct pci_host_bridge *bridge)
+{
+	struct device *parent = bridge->dev.parent;
+	struct resource_entry *window, *n;
+	struct pci_bus *bus, *b;
+	resource_size_t offset;
+	LIST_HEAD(resources);
+	struct resource *res;
+	char addr[64], *fmt;
+	const char *name;
+	int err;
+
+	bus = pci_alloc_bus(NULL);
+	if (!bus)
+		return -ENOMEM;
+
+	bridge->bus = bus;
+
+	/* temporarily move resources off the list */
+	list_splice_init(&bridge->windows, &resources);
+	bus->sysdata = bridge->sysdata;
+	bus->msi = bridge->msi;
+	bus->ops = bridge->ops;
+	bus->number = bus->busn_res.start = bridge->busnr;
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+	bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
+#endif
+
+	b = pci_find_bus(pci_domain_nr(bus), bridge->busnr);
+	if (b) {
+		/* If we already got to this bus through a different bridge, ignore it */
+		dev_dbg(&b->dev, "bus already known\n");
+		err = -EEXIST;
+		goto free;
+	}
+
+	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(bus),
+		     bridge->busnr);
+
+	err = pcibios_root_bridge_prepare(bridge);
+	if (err)
+		goto free;
+
+	err = device_register(&bridge->dev);
+	if (err)
+		put_device(&bridge->dev);
+
+	bus->bridge = get_device(&bridge->dev);
+	device_enable_async_suspend(bus->bridge);
+	pci_set_bus_of_node(bus);
+	pci_set_bus_msi_domain(bus);
+
+	if (!parent)
+		set_dev_node(bus->bridge, pcibus_to_node(bus));
+
+	bus->dev.class = &pcibus_class;
+	bus->dev.parent = bus->bridge;
+
+	dev_set_name(&bus->dev, "%04x:%02x", pci_domain_nr(bus), bus->number);
+	name = dev_name(&bus->dev);
+
+	err = device_register(&bus->dev);
+	if (err)
+		goto unregister;
+
+	pcibios_add_bus(bus);
+
+	/* Create legacy_io and legacy_mem files for this bus */
+	pci_create_legacy_files(bus);
+
+	if (parent)
+		dev_info(parent, "PCI host bridge to bus %s\n", name);
+	else
+		pr_info("PCI host bridge to bus %s\n", name);
+
+	/* Add initial resources to the bus */
+	resource_list_for_each_entry_safe(window, n, &resources) {
+		list_move_tail(&window->node, &bridge->windows);
+		offset = window->offset;
+		res = window->res;
+
+		if (res->flags & IORESOURCE_BUS)
+			pci_bus_insert_busn_res(bus, bus->number, res->end);
+		else
+			pci_bus_add_resource(bus, res, 0);
+
+		if (offset) {
+			if (resource_type(res) == IORESOURCE_IO)
+				fmt = " (bus address [%#06llx-%#06llx])";
+			else
+				fmt = " (bus address [%#010llx-%#010llx])";
+
+			snprintf(addr, sizeof(addr), fmt,
+				 (unsigned long long)(res->start - offset),
+				 (unsigned long long)(res->end - offset));
+		} else
+			addr[0] = '\0';
+
+		dev_info(&bus->dev, "root bus resource %pR%s\n", res, addr);
+	}
+
+	down_write(&pci_bus_sem);
+	list_add_tail(&bus->node, &pci_root_buses);
+	up_write(&pci_bus_sem);
+
+	return 0;
+
+unregister:
+	put_device(&bridge->dev);
+	device_unregister(&bridge->dev);
+
+free:
+	kfree(bus);
+	return err;
+}
+
 static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 					   struct pci_dev *bridge, int busnr)
 {
@@ -2156,113 +2272,43 @@ void __weak pcibios_remove_bus(struct pci_bus *bus)
 {
 }
 
-struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+static struct pci_bus *pci_create_root_bus_msi(struct device *parent,
+		int bus, struct pci_ops *ops, void *sysdata,
+		struct list_head *resources, struct msi_controller *msi)
 {
 	int error;
 	struct pci_host_bridge *bridge;
-	struct pci_bus *b, *b2;
-	struct resource_entry *window, *n;
-	struct resource *res;
-	resource_size_t offset;
-	char bus_addr[64];
-	char *fmt;
-
-	b = pci_alloc_bus(NULL);
-	if (!b)
-		return NULL;
 
-	b->sysdata = sysdata;
-	b->ops = ops;
-	b->number = b->busn_res.start = bus;
-#ifdef CONFIG_PCI_DOMAINS_GENERIC
-	b->domain_nr = pci_bus_find_domain_nr(b, parent);
-#endif
-	b2 = pci_find_bus(pci_domain_nr(b), bus);
-	if (b2) {
-		/* If we already got to this bus through a different bridge, ignore it */
-		dev_dbg(&b2->dev, "bus already known\n");
-		goto err_out;
-	}
-
-	bridge = pci_alloc_host_bridge(b);
+	bridge = pci_alloc_host_bridge();
 	if (!bridge)
-		goto err_out;
+		return NULL;
 
 	bridge->dev.parent = parent;
 	bridge->dev.release = pci_release_host_bridge_dev;
-	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
-	error = pcibios_root_bridge_prepare(bridge);
-	if (error) {
-		kfree(bridge);
-		goto err_out;
-	}
-
-	error = device_register(&bridge->dev);
-	if (error) {
-		put_device(&bridge->dev);
-		goto err_out;
-	}
-	b->bridge = get_device(&bridge->dev);
-	device_enable_async_suspend(b->bridge);
-	pci_set_bus_of_node(b);
-	pci_set_bus_msi_domain(b);
 
-	if (!parent)
-		set_dev_node(b->bridge, pcibus_to_node(b));
-
-	b->dev.class = &pcibus_class;
-	b->dev.parent = b->bridge;
-	dev_set_name(&b->dev, "%04x:%02x", pci_domain_nr(b), bus);
-	error = device_register(&b->dev);
-	if (error)
-		goto class_dev_reg_err;
+	list_splice_init(resources, &bridge->windows);
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+	bridge->msi = msi;
 
-	pcibios_add_bus(b);
-
-	/* Create legacy_io and legacy_mem files for this bus */
-	pci_create_legacy_files(b);
-
-	if (parent)
-		dev_info(parent, "PCI host bridge to bus %s\n", dev_name(&b->dev));
-	else
-		printk(KERN_INFO "PCI host bridge to bus %s\n", dev_name(&b->dev));
-
-	/* Add initial resources to the bus */
-	resource_list_for_each_entry_safe(window, n, resources) {
-		list_move_tail(&window->node, &bridge->windows);
-		res = window->res;
-		offset = window->offset;
-		if (res->flags & IORESOURCE_BUS)
-			pci_bus_insert_busn_res(b, bus, res->end);
-		else
-			pci_bus_add_resource(b, res, 0);
-		if (offset) {
-			if (resource_type(res) == IORESOURCE_IO)
-				fmt = " (bus address [%#06llx-%#06llx])";
-			else
-				fmt = " (bus address [%#010llx-%#010llx])";
-			snprintf(bus_addr, sizeof(bus_addr), fmt,
-				 (unsigned long long) (res->start - offset),
-				 (unsigned long long) (res->end - offset));
-		} else
-			bus_addr[0] = '\0';
-		dev_info(&b->dev, "root bus resource %pR%s\n", res, bus_addr);
-	}
+	error = pci_register_host_bridge(bridge);
+	if (error < 0)
+		goto err_out;
 
-	down_write(&pci_bus_sem);
-	list_add_tail(&b->node, &pci_root_buses);
-	up_write(&pci_bus_sem);
+	return bridge->bus;
 
-	return b;
-
-class_dev_reg_err:
-	put_device(&bridge->dev);
-	device_unregister(&bridge->dev);
 err_out:
-	kfree(b);
+	kfree(bridge);
 	return NULL;
 }
+
+struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	return pci_create_root_bus_msi(parent, bus, ops, sysdata, resources,
+				       NULL);
+}
 EXPORT_SYMBOL_GPL(pci_create_root_bus);
 
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max)
@@ -2343,12 +2389,10 @@ struct pci_bus *pci_scan_root_bus_msi(struct device *parent, int bus,
 			break;
 		}
 
-	b = pci_create_root_bus(parent, bus, ops, sysdata, resources);
+	b = pci_create_root_bus_msi(parent, bus, ops, sysdata, resources, msi);
 	if (!b)
 		return NULL;
 
-	b->msi = msi;
-
 	if (!found) {
 		dev_info(&b->dev,
 		 "No busn resource found for root bus, will use [bus %02x-ff]\n",
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 30d6c162e053..ff16e44d8f84 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -420,9 +420,13 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
 struct pci_host_bridge {
 	struct device dev;
 	struct pci_bus *bus;		/* root bus */
+	struct pci_ops *ops;
+	void *sysdata;
+	int busnr;
 	struct list_head windows;	/* resource_entry */
 	void (*release_fn)(struct pci_host_bridge *);
 	void *release_data;
+	struct msi_controller *msi;
 	unsigned int ignore_reset_delay:1;	/* for entire hierarchy */
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
-- 
2.10.2

