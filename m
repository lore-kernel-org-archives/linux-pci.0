Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [RFC PATCH v1 03/18] PCI: add struct pci_host_bridge_window with
	CPU/bus address offset
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org
Date: Mon, 30 Jan 2012 09:57:24 -0700
Message-ID: <20120130165724.3231.19165.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
References: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some PCI host bridges apply an address offset, so bus addresses on PCI are
different from CPU addresses.  This patch adds a way for architectures to
tell the PCI core about this offset.  For example:

    LIST_HEAD(resources);
    pci_add_resource_offset(&resources, host->io_space, host->io_offset);
    pci_add_resource_offset(&resources, host->mem_space, host->mem_offset);
    pci_scan_root_bus(parent, bus, ops, sysdata, &resources);
---
 drivers/pci/bus.c   |   30 +++++++++++++++++++-----------
 drivers/pci/probe.c |   26 ++++++++++++++++----------
 include/linux/pci.h |    9 +++++++++
 3 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 398f5d8..4ce5ef2 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -18,28 +18,36 @@
 
 #include "pci.h"
 
-void pci_add_resource(struct list_head *resources, struct resource *res)
+void pci_add_resource_offset(struct list_head *resources, struct resource *res,
+			     resource_size_t offset)
 {
-	struct pci_bus_resource *bus_res;
+	struct pci_host_bridge_window *window;
 
-	bus_res = kzalloc(sizeof(struct pci_bus_resource), GFP_KERNEL);
-	if (!bus_res) {
-		printk(KERN_ERR "PCI: can't add bus resource %pR\n", res);
+	window = kzalloc(sizeof(struct pci_host_bridge_window), GFP_KERNEL);
+	if (!window) {
+		printk(KERN_ERR "PCI: can't add host bridge window %pR\n", res);
 		return;
 	}
 
-	bus_res->res = res;
-	list_add_tail(&bus_res->list, resources);
+	window->res = res;
+	window->offset = offset;
+	list_add_tail(&window->list, resources);
+}
+EXPORT_SYMBOL(pci_add_resource_offset);
+
+void pci_add_resource(struct list_head *resources, struct resource *res)
+{
+	pci_add_resource_offset(resources, res, 0);
 }
 EXPORT_SYMBOL(pci_add_resource);
 
 void pci_free_resource_list(struct list_head *resources)
 {
-	struct pci_bus_resource *bus_res, *tmp;
+	struct pci_host_bridge_window *window, *tmp;
 
-	list_for_each_entry_safe(bus_res, tmp, resources, list) {
-		list_del(&bus_res->list);
-		kfree(bus_res);
+	list_for_each_entry_safe(window, tmp, resources, list) {
+		list_del(&window->list);
+		kfree(window);
 	}
 }
 EXPORT_SYMBOL(pci_free_resource_list);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2ffe8a3..4c28aec 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1544,12 +1544,12 @@ unsigned int __devinit pci_scan_child_bus(struct pci_bus *bus)
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		struct pci_ops *ops, void *sysdata, struct list_head *resources)
 {
-	int error, i;
+	int error;
 	struct pci_host_bridge *bridge;
 	struct pci_bus *b, *b2;
 	struct device *dev;
-	struct pci_bus_resource *bus_res, *n;
-	struct resource *res;
+	struct pci_host_bridge_window *window, *n;
+	char offset_text[40];
 
 	bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
 	if (!bridge)
@@ -1599,19 +1599,25 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	b->number = b->secondary = bus;
 
 	bridge->bus = b;
-
-	/* Add initial resources to the bus */
-	list_for_each_entry_safe(bus_res, n, resources, list)
-		list_move_tail(&bus_res->list, &b->resources);
+	INIT_LIST_HEAD(&bridge->windows);
 
 	if (parent)
 		dev_info(parent, "PCI host bridge to bus %s\n", dev_name(&b->dev));
 	else
 		printk(KERN_INFO "PCI host bridge to bus %s\n", dev_name(&b->dev));
 
-	pci_bus_for_each_resource(b, res, i) {
-		if (res)
-			dev_info(&b->dev, "root bus resource %pR\n", res);
+	/* Add initial resources to the bus */
+	list_for_each_entry_safe(window, n, resources, list) {
+		list_move_tail(&window->list, &bridge->windows);
+		pci_bus_add_resource(b, window->res, 0);
+		if (window->offset)
+			snprintf(offset_text, sizeof(offset_text),
+				 " (bus offset %#llx)",
+				 (unsigned long long) window->offset);
+		else
+			offset_text[0] = '\0';
+		dev_info(&b->dev, "root bus resource %pR%s\n", window->res,
+			 offset_text);
 	}
 
 	down_write(&pci_bus_sem);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index dfb2b64..35ef2d1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -388,9 +388,16 @@ static inline void pci_add_saved_cap(struct pci_dev *pci_dev,
 	hlist_add_head(&new_cap->next, &pci_dev->saved_cap_space);
 }
 
+struct pci_host_bridge_window {
+	struct list_head list;
+	struct resource *res;		/* host bridge aperture (CPU address) */
+	resource_size_t offset;		/* bus address + offset = CPU address */
+};
+
 struct pci_host_bridge {
 	struct list_head list;
 	struct pci_bus *bus;		/* root bus */
+	struct list_head windows;	/* pci_host_bridge_windows */
 };
 
 /*
@@ -919,6 +926,8 @@ void pci_release_selected_regions(struct pci_dev *, int);
 
 /* drivers/pci/bus.c */
 void pci_add_resource(struct list_head *resources, struct resource *res);
+void pci_add_resource_offset(struct list_head *resources, struct resource *res,
+			     resource_size_t offset);
 void pci_free_resource_list(struct list_head *resources);
 void pci_bus_add_resource(struct pci_bus *bus, struct resource *res, unsigned int flags);
 struct resource *pci_bus_resource_n(const struct pci_bus *bus, int n);

