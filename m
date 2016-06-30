Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34702 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932282AbcF3Pha (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2016 11:37:30 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tn@semihalf.com>,
	Liviu Dudau <liviu.dudau@arm.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v2 1/2] PCI: Add new method for registering PCI hosts
Date: Thu, 30 Jun 2016 17:19:30 +0200
Message-Id: <20160630151931.29216-1-thierry.reding@gmail.com>
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

Changes in v2 (Thierry Reding):
- add a pci_host_bridge_init() helper that drivers can use to perform
  all the necessary steps to initialize the bridge
- rename pci_register_host() to pci_host_bridge_register() to reflect
  the naming used by other functions
- plug memory leak on registration failure

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/probe.c | 111 ++++++++++++++++++++++++++++++++--------------------
 include/linux/pci.h |   8 +++-
 2 files changed, 75 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 77f0bbb05c3f..ba40514acd32 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -521,19 +521,6 @@ static void pci_release_host_bridge_dev(struct device *dev)
 	kfree(bridge);
 }
 
-static struct pci_host_bridge *pci_alloc_host_bridge(struct pci_bus *b)
-{
-	struct pci_host_bridge *bridge;
-
-	bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
-	if (!bridge)
-		return NULL;
-
-	INIT_LIST_HEAD(&bridge->windows);
-	bridge->bus = b;
-	return bridge;
-}
-
 static const unsigned char pcix_bus_speed[] = {
 	PCI_SPEED_UNKNOWN,		/* 0 */
 	PCI_SPEED_66MHz_PCIX,		/* 1 */
@@ -2117,53 +2104,56 @@ void __weak pcibios_remove_bus(struct pci_bus *bus)
 {
 }
 
-struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+void pci_host_bridge_init(struct pci_host_bridge *bridge)
+{
+	INIT_LIST_HEAD(&bridge->windows);
+}
+EXPORT_SYMBOL_GPL(pci_host_bridge_init);
+
+int pci_host_bridge_register(struct pci_host_bridge *bridge)
 {
 	int error;
-	struct pci_host_bridge *bridge;
 	struct pci_bus *b, *b2;
 	struct resource_entry *window, *n;
+	LIST_HEAD(resources);
 	struct resource *res;
 	resource_size_t offset;
 	char bus_addr[64];
 	char *fmt;
+	struct device *parent = bridge->dev.parent;
 
 	b = pci_alloc_bus(NULL);
 	if (!b)
-		return NULL;
+		return -ENOMEM;
+	bridge->bus = b;
 
-	b->sysdata = sysdata;
-	b->ops = ops;
-	b->number = b->busn_res.start = bus;
+	/* temporarily move resources off the list */
+	list_splice_init(&bridge->windows, &resources);
+	b->sysdata = bridge->sysdata;
+	b->msi = bridge->msi;
+	b->ops = bridge->ops;
+	b->number = b->busn_res.start = bridge->busnr;
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 	b->domain_nr = pci_bus_find_domain_nr(b, parent);
 #endif
-	b2 = pci_find_bus(pci_domain_nr(b), bus);
+	b2 = pci_find_bus(pci_domain_nr(b), bridge->busnr);
 	if (b2) {
 		/* If we already got to this bus through a different bridge, ignore it */
 		dev_dbg(&b2->dev, "bus already known\n");
+		error = -EEXIST;
 		goto err_out;
 	}
 
-	bridge = pci_alloc_host_bridge(b);
-	if (!bridge)
-		goto err_out;
-
-	bridge->dev.parent = parent;
-	bridge->dev.release = pci_release_host_bridge_dev;
-	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
+	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b),
+		     bridge->busnr);
 	error = pcibios_root_bridge_prepare(bridge);
-	if (error) {
-		kfree(bridge);
+	if (error)
 		goto err_out;
-	}
 
 	error = device_register(&bridge->dev);
-	if (error) {
+	if (error)
 		put_device(&bridge->dev);
-		goto err_out;
-	}
+
 	b->bridge = get_device(&bridge->dev);
 	device_enable_async_suspend(b->bridge);
 	pci_set_bus_of_node(b);
@@ -2174,7 +2164,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 
 	b->dev.class = &pcibus_class;
 	b->dev.parent = b->bridge;
-	dev_set_name(&b->dev, "%04x:%02x", pci_domain_nr(b), bus);
+	dev_set_name(&b->dev, "%04x:%02x", pci_domain_nr(b), bridge->busnr);
 	error = device_register(&b->dev);
 	if (error)
 		goto class_dev_reg_err;
@@ -2190,12 +2180,12 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		printk(KERN_INFO "PCI host bridge to bus %s\n", dev_name(&b->dev));
 
 	/* Add initial resources to the bus */
-	resource_list_for_each_entry_safe(window, n, resources) {
+	resource_list_for_each_entry_safe(window, n, &resources) {
 		list_move_tail(&window->node, &bridge->windows);
 		res = window->res;
 		offset = window->offset;
 		if (res->flags & IORESOURCE_BUS)
-			pci_bus_insert_busn_res(b, bus, res->end);
+			pci_bus_insert_busn_res(b, bridge->busnr, res->end);
 		else
 			pci_bus_add_resource(b, res, 0);
 		if (offset) {
@@ -2215,16 +2205,16 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	list_add_tail(&b->node, &pci_root_buses);
 	up_write(&pci_bus_sem);
 
-	return b;
+	return 0;
 
 class_dev_reg_err:
 	put_device(&bridge->dev);
 	device_unregister(&bridge->dev);
 err_out:
 	kfree(b);
-	return NULL;
+	return error;
 }
-EXPORT_SYMBOL_GPL(pci_create_root_bus);
+EXPORT_SYMBOL_GPL(pci_host_bridge_register);
 
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max)
 {
@@ -2289,6 +2279,43 @@ void pci_bus_release_busn_res(struct pci_bus *b)
 			res, ret ? "can not be" : "is");
 }
 
+static struct pci_bus *pci_create_root_bus_msi(struct device *parent,
+		int bus, struct pci_ops *ops, void *sysdata,
+		struct list_head *resources, struct msi_controller *msi)
+{
+	struct pci_host_bridge *bridge;
+	int ret;
+
+	bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
+	if (!bridge)
+		return NULL;
+
+	pci_host_bridge_init(bridge);
+	bridge->dev.parent = parent;
+	bridge->dev.release = pci_release_host_bridge_dev;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+	bridge->sysdata = sysdata;
+	bridge->msi = msi;
+	list_splice_init(resources, &bridge->windows);
+
+	ret = pci_host_bridge_register(bridge);
+	if (ret) {
+		kfree(bridge);
+		return NULL;
+	}
+
+	return bridge->bus;
+}
+
+struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	return pci_create_root_bus_msi(parent, bus, ops, sysdata, resources,
+				       NULL);
+}
+EXPORT_SYMBOL_GPL(pci_create_root_bus);
+
 struct pci_bus *pci_scan_root_bus_msi(struct device *parent, int bus,
 		struct pci_ops *ops, void *sysdata,
 		struct list_head *resources, struct msi_controller *msi)
@@ -2304,12 +2331,10 @@ struct pci_bus *pci_scan_root_bus_msi(struct device *parent, int bus,
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
index 8badb664be00..5bf04e20c1cd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -405,10 +405,14 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
 
 struct pci_host_bridge {
 	struct device dev;
-	struct pci_bus *bus;		/* root bus */
+	struct pci_ops *ops;
+	void *sysdata;
+	int busnr;
+	struct pci_bus *bus;		/* points to root */
 	struct list_head windows;	/* resource_entry */
 	void (*release_fn)(struct pci_host_bridge *);
 	void *release_data;
+	struct msi_controller *msi;
 	unsigned int ignore_reset_delay:1;	/* for entire hierarchy */
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
@@ -817,6 +821,8 @@ struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
 				    struct list_head *resources);
+void pci_host_bridge_init(struct pci_host_bridge *bridge);
+int pci_host_bridge_register(struct pci_host_bridge *bridge);
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
 int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
 void pci_bus_release_busn_res(struct pci_bus *b);
-- 
2.8.3

