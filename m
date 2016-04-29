Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:56850 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbcD2XCW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2016 19:02:22 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: catalin.marinas@arm.com, linux-pci@vger.kernel.org,
	will.deacon@arm.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>, ddaney@caviumnetworks.com,
	robert.richter@caviumnetworks.com, msalter@redhat.com,
	Liviu.Dudau@arm.com, jchandra@broadcom.com,
	linux-kernel@vger.kernel.org, hanjun.guo@linaro.org,
	Suravee.Suthikulpanit@amd.com,
	Thierry Reding <thierry.reding@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/3] [RFC] pci: add new method for register PCI hosts
Date: Sat, 30 Apr 2016 01:01:37 +0200
Message-Id: <1461970899-4150603-2-git-send-email-arnd@arndb.de>
In-Reply-To: <1461970899-4150603-1-git-send-email-arnd@arndb.de>
References: <1461970899-4150603-1-git-send-email-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch makes the existing 'pci_host_bridge' structure a proper device
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

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/probe.c | 100 ++++++++++++++++++++++++++++++----------------------
 include/linux/pci.h |   7 +++-
 2 files changed, 63 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ae7daeb83e21..fe9d9221b11e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -520,19 +520,6 @@ static void pci_release_host_bridge_dev(struct device *dev)
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
@@ -2108,51 +2095,47 @@ void __weak pcibios_remove_bus(struct pci_bus *bus)
 {
 }
 
-struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+int pci_register_host(struct pci_host_bridge *bridge)
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
 	pci_bus_assign_domain_nr(b, parent);
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
+	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bridge->busnr);
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
@@ -2163,7 +2146,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 
 	b->dev.class = &pcibus_class;
 	b->dev.parent = b->bridge;
-	dev_set_name(&b->dev, "%04x:%02x", pci_domain_nr(b), bus);
+	dev_set_name(&b->dev, "%04x:%02x", pci_domain_nr(b), bridge->busnr);
 	error = device_register(&b->dev);
 	if (error)
 		goto class_dev_reg_err;
@@ -2179,12 +2162,12 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
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
@@ -2204,16 +2187,16 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
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
+EXPORT_SYMBOL_GPL(pci_register_host);
 
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max)
 {
@@ -2278,6 +2261,39 @@ void pci_bus_release_busn_res(struct pci_bus *b)
 			res, ret ? "can not be" : "is");
 }
 
+static struct pci_bus * pci_create_root_bus_msi(struct device *parent,
+		int bus, struct pci_ops *ops, void *sysdata,
+		struct list_head *resources, struct msi_controller *msi)
+{
+	struct pci_host_bridge *bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
+	int ret;
+
+	if (!bridge)
+		return NULL;
+
+	bridge->dev.parent = parent;
+	bridge->dev.release = pci_release_host_bridge_dev;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+	bridge->sysdata = sysdata;
+	bridge->msi = msi;
+	list_splice_init(resources, &bridge->windows);
+
+	ret = pci_register_host(bridge);
+	if (ret)
+		return NULL;
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
@@ -2293,12 +2309,10 @@ struct pci_bus *pci_scan_root_bus_msi(struct device *parent, int bus,
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
index 81f070a47ee7..8bb5dff617a1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -400,10 +400,14 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
 
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
@@ -812,6 +816,7 @@ struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
 				    struct list_head *resources);
+int pci_register_host(struct pci_host_bridge *bridge);
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
 int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
 void pci_bus_release_busn_res(struct pci_bus *b);
-- 
2.7.0

