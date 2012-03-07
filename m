Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f74.google.com ([209.85.215.74]:59100 "EHLO
	mail-lpp01m010-f74.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030745Ab2CGWdX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Mar 2012 17:33:23 -0500
Received: by laai8 with SMTP id i8so246734laa.1
        for <linux-pci@vger.kernel.org>; Wed, 07 Mar 2012 14:33:22 -0800 (PST)
Subject: [PATCH v3 15/34] PCI: add struct pci_host_bridge and a list of all
	bridges found
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 07 Mar 2012 15:33:20 -0700
Message-ID: <20120307223320.25669.75545.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds a list of all PCI host bridges we find and a way to look up
the host bridge from a pci_dev.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |   39 ++++++++++++++++++++++++++++++++++-----
 include/linux/pci.h |    5 +++++
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e4c0d1c..3a30023 100644
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
@@ -1544,20 +1563,23 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
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
@@ -1594,6 +1616,8 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 
 	b->number = b->secondary = bus;
 
+	bridge->bus = b;
+
 	/* Add initial resources to the bus */
 	list_for_each_entry_safe(bus_res, n, resources, list)
 		list_move_tail(&bus_res->list, &b->resources);
@@ -1609,6 +1633,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	}
 
 	down_write(&pci_bus_sem);
+	list_add_tail(&bridge->list, &pci_host_bridges);
 	list_add_tail(&b->node, &pci_root_buses);
 	up_write(&pci_bus_sem);
 
@@ -1618,11 +1643,15 @@ class_dev_reg_err:
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
index bcaa51c..2c946b3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -368,6 +368,11 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
 	return (pdev->error_state != pci_channel_io_normal);
 }
 
+struct pci_host_bridge {
+	struct list_head list;
+	struct pci_bus *bus;		/* root bus */
+};
+
 /*
  * The first PCI_BRIDGE_RESOURCE_NUM PCI bus resources (those that correspond
  * to P2P or CardBus bridge windows) go in a table.  Additional ones (for

