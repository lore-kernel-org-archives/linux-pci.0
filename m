Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [PATCH v2 02/18] PCI: add struct pci_host_bridge and a list of all
	bridges found
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org
Date: Thu, 09 Feb 2012 19:36:31 -0700
Message-ID: <20120210023631.10311.37307.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com>
References: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds a list of all PCI host bridges we find and a way to look up
the host bridge from a pci_dev.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |   39 ++++++++++++++++++++++++++++++++++-----
 include/linux/pci.h |    5 +++++
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index da0d655..2ffe8a3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -15,6 +15,8 @@
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
 #define CARDBUS_RESERVE_BUSNR	3
 
+static LIST_HEAD(pci_host_bridges);
+
 /* Ugh.  Need to stop exporting this to modules. */
 LIST_HEAD(pci_root_buses);
 EXPORT_SYMBOL(pci_root_buses);
@@ -42,6 +44,23 @@ int no_pci_devices(void)
 }
 EXPORT_SYMBOL(no_pci_devices);
 
+static struct pci_host_bridge *pci_host_bridge(struct pci_dev *dev)
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
@@ -1526,20 +1545,23 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		struct pci_ops *ops, void *sysdata, struct list_head *resources)
 {
 	int error, i;
+	struct pci_host_bridge *bridge;
 	struct pci_bus *b, *b2;
 	struct device *dev;
 	struct pci_bus_resource *bus_res, *n;
 	struct resource *res;
 
+	bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
+	if (!bridge)
+		return NULL;
+
 	b = pci_alloc_bus();
 	if (!b)
-		return NULL;
+		goto err_bus;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev) {
-		kfree(b);
-		return NULL;
-	}
+	if (!dev)
+		goto err_dev;
 
 	b->sysdata = sysdata;
 	b->ops = ops;
@@ -1576,6 +1598,8 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 
 	b->number = b->secondary = bus;
 
+	bridge->bus = b;
+
 	/* Add initial resources to the bus */
 	list_for_each_entry_safe(bus_res, n, resources, list)
 		list_move_tail(&bus_res->list, &b->resources);
@@ -1591,6 +1615,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	}
 
 	down_write(&pci_bus_sem);
+	list_add_tail(&bridge->list, &pci_host_bridges);
 	list_add_tail(&b->node, &pci_root_buses);
 	up_write(&pci_bus_sem);
 
@@ -1600,11 +1625,15 @@ class_dev_reg_err:
 	device_unregister(dev);
 dev_reg_err:
 	down_write(&pci_bus_sem);
+	list_del(&bridge->list);
 	list_del(&b->node);
 	up_write(&pci_bus_sem);
 err_out:
 	kfree(dev);
+err_dev:
 	kfree(b);
+err_bus:
+	kfree(bridge);
 	return NULL;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a16b1df..dfb2b64 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -388,6 +388,11 @@ static inline void pci_add_saved_cap(struct pci_dev *pci_dev,
 	hlist_add_head(&new_cap->next, &pci_dev->saved_cap_space);
 }
 
+struct pci_host_bridge {
+	struct list_head list;
+	struct pci_bus *bus;		/* root bus */
+};
+
 /*
  * The first PCI_BRIDGE_RESOURCE_NUM PCI bus resources (those that correspond
  * to P2P or CardBus bridge windows) go in a table.  Additional ones (for

