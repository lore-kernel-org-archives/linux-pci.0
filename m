Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:49692 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693Ab3FFRMg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2013 13:12:36 -0400
Received: by mail-pd0-f179.google.com with SMTP id q11so3596697pdj.24
        for <linux-pci@vger.kernel.org>; Thu, 06 Jun 2013 10:12:36 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI: make PCI host bridge/bus creating and destroying logic symmetric
Date: Fri,  7 Jun 2013 01:10:09 +0800
Message-Id: <1370538609-28903-2-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1370538609-28903-1-git-send-email-jiang.liu@huawei.com>
References: <1370538609-28903-1-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <CAErSpo4AFxSqUfxbw60B8XVk3XxtYfRcLyWDy=yPb0fURV=BQg@mail.gmail.com>
References: <CAErSpo4AFxSqUfxbw60B8XVk3XxtYfRcLyWDy=yPb0fURV=BQg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch makes PCI host bridge/bus creating and destroying logic
symmetric by using device_initialize()/device_add()/device_del()/put_device()
pairs as discussed in thread at:
http://comments.gmane.org/gmane.linux.kernel.pci/22073

It also fixes a bug in error recovery path in pci_create_root_bus()
which may kfree() an in-use host bridge object.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c  | 92 +++++++++++++++++++++++-----------------------------
 drivers/pci/remove.c |  3 +-
 2 files changed, 42 insertions(+), 53 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2f81a0a..9e9cdfe 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -470,7 +470,7 @@ void pci_read_bridge_bases(struct pci_bus *child)
 	}
 }
 
-static struct pci_bus * pci_alloc_bus(void)
+static struct pci_bus *pci_alloc_bus(struct pci_ops *ops, void *sd, int bus)
 {
 	struct pci_bus *b;
 
@@ -483,10 +483,32 @@ static struct pci_bus * pci_alloc_bus(void)
 		INIT_LIST_HEAD(&b->resources);
 		b->max_bus_speed = PCI_SPEED_UNKNOWN;
 		b->cur_bus_speed = PCI_SPEED_UNKNOWN;
+		b->sysdata = sd;
+		b->ops = ops;
+		b->number = bus;
+		b->busn_res.start = bus;
+		b->busn_res.end = 0xff;
+		b->busn_res.flags = IORESOURCE_BUS;
+		b->dev.class = &pcibus_class;
+		dev_set_name(&b->dev, "%04x:%02x", pci_domain_nr(b), bus);
+		device_initialize(&b->dev);
 	}
+
 	return b;
 }
 
+static void pci_release_host_bridge_dev(struct device *dev)
+{
+	struct pci_host_bridge *bridge = to_pci_host_bridge(dev);
+
+	if (bridge->release_fn)
+		bridge->release_fn(bridge);
+
+	pci_free_resource_list(&bridge->windows);
+
+	kfree(bridge);
+}
+
 static struct pci_host_bridge *pci_alloc_host_bridge(struct pci_bus *b)
 {
 	struct pci_host_bridge *bridge;
@@ -495,6 +517,10 @@ static struct pci_host_bridge *pci_alloc_host_bridge(struct pci_bus *b)
 	if (bridge) {
 		INIT_LIST_HEAD(&bridge->windows);
 		bridge->bus = b;
+		bridge->dev.release = pci_release_host_bridge_dev;
+		dev_set_name(&bridge->dev, "pci%04x:%02x",
+			     pci_domain_nr(b), b->number);
+		device_initialize(&bridge->dev);
 	}
 
 	return bridge;
@@ -647,28 +673,13 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 	/*
 	 * Allocate a new bus, and inherit stuff from the parent..
 	 */
-	child = pci_alloc_bus();
+	child = pci_alloc_bus(parent->ops, parent->sysdata, busnr);
 	if (!child)
 		return NULL;
 
 	child->parent = parent;
-	child->ops = parent->ops;
-	child->sysdata = parent->sysdata;
 	child->bus_flags = parent->bus_flags;
-
-	/* initialize some portions of the bus device, but don't register it
-	 * now as the parent is not properly set up yet.
-	 */
-	child->dev.class = &pcibus_class;
-	dev_set_name(&child->dev, "%04x:%02x", pci_domain_nr(child), busnr);
-
-	/*
-	 * Set up the primary, secondary and subordinate
-	 * bus numbers.
-	 */
-	child->number = child->busn_res.start = busnr;
 	child->primary = parent->busn_res.start;
-	child->busn_res.end = 0xff;
 
 	if (!bridge) {
 		child->dev.parent = parent->bridge;
@@ -689,7 +700,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 	bridge->subordinate = child;
 
 add_dev:
-	ret = device_register(&child->dev);
+	ret = device_add(&child->dev);
 	WARN_ON(ret < 0);
 
 	pcibios_add_bus(child);
@@ -1208,18 +1219,6 @@ int pci_cfg_space_size(struct pci_dev *dev)
 	return PCI_CFG_SPACE_SIZE;
 }
 
-static void pci_release_bus_bridge_dev(struct device *dev)
-{
-	struct pci_host_bridge *bridge = to_pci_host_bridge(dev);
-
-	if (bridge->release_fn)
-		bridge->release_fn(bridge);
-
-	pci_free_resource_list(&bridge->windows);
-
-	kfree(bridge);
-}
-
 struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
@@ -1707,13 +1706,10 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	char bus_addr[64];
 	char *fmt;
 
-	b = pci_alloc_bus();
+	b = pci_alloc_bus(ops, sysdata, bus);
 	if (!b)
 		return NULL;
 
-	b->sysdata = sysdata;
-	b->ops = ops;
-	b->number = b->busn_res.start = bus;
 	b2 = pci_find_bus(pci_domain_nr(b), bus);
 	if (b2) {
 		/* If we already got to this bus through a different bridge, ignore it */
@@ -1726,30 +1722,21 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		goto err_out;
 
 	bridge->dev.parent = parent;
-	bridge->dev.release = pci_release_bus_bridge_dev;
-	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
 	error = pcibios_root_bridge_prepare(bridge);
-	if (error) {
-		kfree(bridge);
-		goto err_out;
-	}
+	if (error)
+		goto bridge_dev_reg_err;
+
+	error = device_add(&bridge->dev);
+	if (error)
+		goto bridge_dev_reg_err;
 
-	error = device_register(&bridge->dev);
-	if (error) {
-		kfree(bridge);
-		goto err_out;
-	}
 	b->bridge = get_device(&bridge->dev);
 	device_enable_async_suspend(b->bridge);
 	pci_set_bus_of_node(b);
-
 	if (!parent)
 		set_dev_node(b->bridge, pcibus_to_node(b));
-
-	b->dev.class = &pcibus_class;
 	b->dev.parent = b->bridge;
-	dev_set_name(&b->dev, "%04x:%02x", pci_domain_nr(b), bus);
-	error = device_register(&b->dev);
+	error = device_add(&b->dev);
 	if (error)
 		goto class_dev_reg_err;
 
@@ -1792,10 +1779,11 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	return b;
 
 class_dev_reg_err:
+	device_del(&bridge->dev);
+bridge_dev_reg_err:
 	put_device(&bridge->dev);
-	device_unregister(&bridge->dev);
 err_out:
-	kfree(b);
+	put_device(&b->dev);
 	return NULL;
 }
 
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 8fc54b7..b0ce875 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -52,7 +52,8 @@ void pci_remove_bus(struct pci_bus *bus)
 	up_write(&pci_bus_sem);
 	pci_remove_legacy_files(bus);
 	pcibios_remove_bus(bus);
-	device_unregister(&bus->dev);
+	device_del(&bus->dev);
+	put_device(&bus->dev);
 }
 EXPORT_SYMBOL(pci_remove_bus);
 
-- 
1.8.1.2

