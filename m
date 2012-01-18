Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f74.google.com ([209.85.213.74]:41705 "EHLO
	mail-yw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755688Ab2ARAfI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2012 19:35:08 -0500
Received: by yhjj52 with SMTP id j52so536644yhj.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Jan 2012 16:35:08 -0800 (PST)
Subject: [PATCH 2/4] PCI: add struct pci_host_bridge and pci_scan_host_bridge()
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Tue, 17 Jan 2012 17:35:07 -0700
Message-ID: <20120118003507.467.40594.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120118003335.467.71863.stgit@bhelgaas.mtv.corp.google.com>
References: <20120118003335.467.71863.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds a struct pci_host_bridge so the PCI core can keep track of
generic attributes like the subordinate bus number range and the
resources available to that PCI device tree.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |   20 +++++++++++++++
 2 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e282580..434475c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -15,6 +15,8 @@
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
 #define CARDBUS_RESERVE_BUSNR	3
 
+LIST_HEAD(pci_host_bridges);
+
 /* Ugh.  Need to stop exporting this to modules. */
 LIST_HEAD(pci_root_buses);
 EXPORT_SYMBOL(pci_root_buses);
@@ -42,6 +44,23 @@ int no_pci_devices(void)
 }
 EXPORT_SYMBOL(no_pci_devices);
 
+struct pci_host_bridge *pci_host_bridge(struct pci_dev *dev)
+{
+	struct pci_bus *bus;
+	struct pci_host_bridge *bridge;
+
+	bus = dev->bus;
+	while (bus->parent)
+		bus = bus->parent;
+
+	list_for_each_entry(bridge, &pci_host_bridges, list) {
+		if (bridge->bus == bus)
+			return bridge;
+	}
+
+	return NULL;
+}
+
 /*
  * PCI Bus Class
  */
@@ -1664,6 +1683,56 @@ struct pci_bus * __devinit pci_scan_bus(int bus, struct pci_ops *ops,
 }
 EXPORT_SYMBOL(pci_scan_bus);
 
+/*
+ * Use pci_scan_host_bridge() instead, unless there's some reason you have
+ * to run code between pci_scan_child_bus() and pci_bus_add_devices().
+ */
+struct pci_host_bridge *pci_create_host_bridge(struct device *parent,
+		int domain, struct resource *subordinate,
+		struct list_head *resources, struct pci_ops *ops,
+		void *sysdata)
+{
+	struct pci_host_bridge *bridge;
+
+	bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
+	if (!bridge)
+		return NULL;
+
+	bridge->subordinate = subordinate;
+	bridge->bus = pci_create_root_bus(parent, subordinate->start, ops, sysdata,
+					  resources);
+	if (!bridge->bus) {
+		kfree(bridge);
+		return NULL;
+	}
+
+	down_write(&pci_bus_sem);
+	list_add_tail(&bridge->list, &pci_host_bridges);
+	up_write(&pci_bus_sem);
+
+	return bridge;
+}
+
+struct pci_host_bridge *pci_scan_host_bridge(struct device *parent,
+		int domain, struct resource *subordinate,
+		struct list_head *resources, struct pci_ops *ops,
+		void *sysdata)
+{
+	struct pci_host_bridge *bridge;
+	struct pci_bus *bus;
+
+	bridge = pci_create_host_bridge(parent, domain, subordinate, resources,
+					ops, sysdata);
+	if (!bridge)
+		return NULL;
+
+	bus = bridge->bus;
+	bus->subordinate = pci_scan_child_bus(bus);
+	pci_bus_add_devices(bus);
+	return bridge;
+}
+
+
 #ifdef CONFIG_HOTPLUG
 /**
  * pci_rescan_bus - scan a PCI bus for devices.
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a16b1df..f642bca 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -388,6 +388,12 @@ static inline void pci_add_saved_cap(struct pci_dev *pci_dev,
 	hlist_add_head(&new_cap->next, &pci_dev->saved_cap_space);
 }
 
+struct pci_host_bridge {
+	struct list_head list;
+	struct resource *subordinate;	/* bus number aperture */
+	struct pci_bus *bus;		/* root bus */
+};
+
 /*
  * The first PCI_BRIDGE_RESOURCE_NUM PCI bus resources (those that correspond
  * to P2P or CardBus bridge windows) go in a table.  Additional ones (for
@@ -637,6 +643,7 @@ extern struct bus_type pci_bus_type;
 
 /* Do NOT directly access these two variables, unless you are arch specific pci
  * code, or pci core code. */
+extern struct list_head pci_host_bridges;
 extern struct list_head pci_root_buses;	/* list of all known PCI buses */
 /* Some device drivers need know if pci is initiated */
 extern int no_pci_devices(void);
@@ -668,6 +675,19 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 struct pci_bus * __devinit pci_scan_root_bus(struct device *parent, int bus,
 					     struct pci_ops *ops, void *sysdata,
 					     struct list_head *resources);
+struct pci_host_bridge *pci_create_host_bridge(struct device *parent,
+					       int domain,
+					       struct resource *subordinate,
+					       struct list_head *resources,
+					       struct pci_ops *ops,
+					       void *sysdata);
+struct pci_host_bridge *pci_scan_host_bridge(struct device *parent,
+					     int domain,
+					     struct resource *subordinate,
+					     struct list_head *resources,
+					     struct pci_ops *ops,
+					     void *sysdata);
+struct pci_host_bridge *pci_host_bridge(struct pci_dev *dev);
 struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev,
 				int busnr);
 void pcie_update_link_speed(struct pci_bus *bus, u16 link_status);

