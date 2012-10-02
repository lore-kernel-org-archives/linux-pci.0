Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:21993 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406Ab2JBGdK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2012 02:33:10 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 04/10] PCI: Use device_add for device and bus early
Date: Mon,  1 Oct 2012 23:33:02 -0700
Message-Id: <1349159588-15029-5-git-send-email-yinghai@kernel.org>
In-Reply-To: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Move out device registering out of pci_bus_add_devices, so we could
put new created pci devices in device tree early.

new pci_bus_add_devices will do the device_attach work to load pci drivers
instead.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/bus.c   |   34 ++--------------------------------
 drivers/pci/iov.c   |    7 -------
 drivers/pci/probe.c |   25 ++++++++++++++++++-------
 3 files changed, 20 insertions(+), 46 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 3144262..5b98505 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -179,12 +179,7 @@ static void pci_bus_attach_device(struct pci_dev *dev)
  */
 int pci_bus_add_device(struct pci_dev *dev)
 {
-	int retval;
-
 	pci_fixup_device(pci_fixup_final, dev);
-	retval = device_add(&dev->dev);
-	if (retval)
-		return retval;
 
 	pci_bus_attach_device(dev);
 	dev->is_added = 1;
@@ -201,21 +196,12 @@ int pci_bus_add_device(struct pci_dev *dev)
  */
 int pci_bus_add_child(struct pci_bus *bus)
 {
-	int retval;
-
-	if (bus->bridge)
-		bus->dev.parent = bus->bridge;
-
-	retval = device_add(&bus->dev);
-	if (retval)
-		return retval;
-
 	bus->is_added = 1;
 
 	/* Create legacy_io and legacy_mem files for this bus */
 	pci_create_legacy_files(bus);
 
-	return retval;
+	return 0;
 }
 
 /**
@@ -241,36 +227,20 @@ void pci_bus_add_devices(const struct pci_bus *bus)
 		if (dev->is_added)
 			continue;
 		retval = pci_bus_add_device(dev);
-		if (retval)
-			dev_err(&dev->dev, "Error adding device, continuing\n");
 	}
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		BUG_ON(!dev->is_added);
 
 		child = dev->subordinate;
-		/*
-		 * If there is an unattached subordinate bus, attach
-		 * it and then scan for unattached PCI devices.
-		 */
+
 		if (!child)
 			continue;
-		if (list_empty(&child->node)) {
-			down_write(&pci_bus_sem);
-			list_add_tail(&child->node, &dev->bus->children);
-			up_write(&pci_bus_sem);
-		}
 		pci_bus_add_devices(child);
 
-		/*
-		 * register the bus with sysfs as the parent is now
-		 * properly registered.
-		 */
 		if (child->is_added)
 			continue;
 		retval = pci_bus_add_child(child);
-		if (retval)
-			dev_err(&dev->dev, "Error adding bus, continuing\n");
 	}
 }
 
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index aeccc91..f286583 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -48,12 +48,7 @@ static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
 		return NULL;
 
 	pci_bus_insert_busn_res(child, busnr, busnr);
-	child->dev.parent = bus->bridge;
 	rc = pci_bus_add_child(child);
-	if (rc) {
-		pci_remove_bus(child);
-		return NULL;
-	}
 
 	return child;
 }
@@ -123,8 +118,6 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
 	virtfn->is_virtfn = 1;
 
 	rc = pci_bus_add_device(virtfn);
-	if (rc)
-		goto failed1;
 	sprintf(buf, "virtfn%u", id);
 	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
 	if (rc)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c3da8f5..c1b7292 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -616,6 +616,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 {
 	struct pci_bus *child;
 	int i;
+	int ret;
 
 	/*
 	 * Allocate a new bus, and inherit stuff from the parent..
@@ -630,8 +631,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 	child->bus_flags = parent->bus_flags;
 
 	/* initialize some portions of the bus device, but don't register it
-	 * now as the parent is not properly set up yet.  This device will get
-	 * registered later in pci_bus_add_devices()
+	 * now as the parent is not properly set up yet.
 	 */
 	child->dev.class = &pcibus_class;
 	dev_set_name(&child->dev, "%04x:%02x", pci_domain_nr(child), busnr);
@@ -645,11 +645,14 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 	child->primary = parent->busn_res.start;
 	child->busn_res.end = 0xff;
 
-	if (!bridge)
-		return child;
+	if (!bridge) {
+		child->dev.parent = parent->bridge;
+		goto add_dev;
+	}
 
 	child->self = bridge;
 	child->bridge = get_device(&bridge->dev);
+	child->dev.parent = child->bridge;
 	pci_set_bus_of_node(child);
 	pci_set_bus_speed(child);
 
@@ -660,6 +663,10 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 	}
 	bridge->subordinate = child;
 
+add_dev:
+	ret = device_add(&child->dev);
+	WARN_ON(ret < 0);
+
 	return child;
 }
 
@@ -1290,6 +1297,8 @@ static void pci_init_capabilities(struct pci_dev *dev)
 
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 {
+	int ret;
+
 	device_initialize(&dev->dev);
 	dev->dev.release = pci_release_dev;
 
@@ -1320,6 +1329,10 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	down_write(&pci_bus_sem);
 	list_add_tail(&dev->bus_list, &bus->devices);
 	up_write(&pci_bus_sem);
+
+	/* notifier could use pci capabilities */
+	ret = device_add(&dev->dev);
+	WARN_ON(ret < 0);
 }
 
 struct pci_dev *__ref pci_scan_single_device(struct pci_bus *bus, int devfn)
@@ -1638,13 +1651,13 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	char bus_addr[64];
 	char *fmt;
 
-
 	b = pci_alloc_bus();
 	if (!b)
 		return NULL;
 
 	b->sysdata = sysdata;
 	b->ops = ops;
+	b->number = b->busn_res.start = bus;
 	b2 = pci_find_bus(pci_domain_nr(b), bus);
 	if (b2) {
 		/* If we already got to this bus through a different bridge, ignore it */
@@ -1681,8 +1694,6 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	/* Create legacy_io and legacy_mem files for this bus */
 	pci_create_legacy_files(b);
 
-	b->number = b->busn_res.start = bus;
-
 	if (parent)
 		dev_info(parent, "PCI host bridge to bus %s\n", dev_name(&b->dev));
 	else
-- 
1.7.7

