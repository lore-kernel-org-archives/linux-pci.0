Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:36577 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754422Ab3DRI7H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 18 Apr 2013 04:59:07 -0400
Message-ID: <516FB578.7090802@cn.fujitsu.com>
Date: Thu, 18 Apr 2013 16:57:28 +0800
From: Gu Zheng <guz.fnst@cn.fujitsu.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>,
	tangchen <tangchen@cn.fujitsu.com>,
	"'Lin Feng'" <linfeng@cn.fujitsu.com>,
	li guang <lig.fnst@cn.fujitsu.com>
Subject: [PATCH 1/3] PCI: take a reference on the bus object when we capture
 the struct pci_bus pointer
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>From 067ec31ba1cb52c78c24196d5dea5ab0cb86dd9b Mon Sep 17 00:00:00 2001
From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Date: Thu, 18 Apr 2013 16:51:48 +0900
Subject: [PATCH 1/3] PCI: take a reference on the bus object when we capture the struct pci_bus pointer

Take a reference on the bus object when we alloc a pci device on a target pci bus, in order to keep
the pci bus valid during the lifetime of devices downstream from it. And introduce pci_bus_get()/pci_bus_put()
to hide pci_bus' reference management.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
Reviewed-by: Tang Chen <tangchen@cn.fujitsu.com>
Reviewed-by: Li Guang <lig.fnst@cn.fujitsu.com>
---
 arch/powerpc/kernel/pci_of_scan.c |    2 +-
 drivers/pci/bus.c                 |   14 ++++++++++++++
 drivers/pci/iov.c                 |    4 +++-
 drivers/pci/probe.c               |    2 +-
 include/linux/pci.h               |    3 +++
 5 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 2a67e9b..9e0f6fd 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -137,7 +137,7 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 
 	pr_debug("    create device, devfn: %x, type: %s\n", devfn, type);
 
-	dev->bus = bus;
+	dev->bus = pci_bus_get(bus);
 	dev->dev.of_node = of_node_get(node);
 	dev->dev.parent = bus->bridge;
 	dev->dev.bus = &pci_bus_type;
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 8647dc6..8e812bb 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -17,6 +17,20 @@
 #include <linux/slab.h>
 
 #include "pci.h"
+struct pci_bus *pci_bus_get(struct pci_bus *bus)
+{
+	if (bus)
+		get_device(&bus->dev);
+	return bus;
+}
+EXPORT_SYMBOL(pci_bus_get);
+
+void pci_bus_put(struct pci_bus *bus)
+{
+	if (bus)
+		put_device(&bus->dev);
+}
+EXPORT_SYMBOL(pci_bus_put);
 
 void pci_add_resource_offset(struct list_head *resources, struct resource *res,
 			     resource_size_t offset)
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ee599f2..18798a7 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -73,6 +73,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
 	u64 size;
 	char buf[VIRTFN_ID_LEN];
 	struct pci_dev *virtfn;
+	struct pci_bus *bus;
 	struct resource *res;
 	struct pci_sriov *iov = dev->sriov;
 
@@ -81,7 +82,8 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
 		return -ENOMEM;
 
 	mutex_lock(&iov->dev->sriov->lock);
-	virtfn->bus = virtfn_add_bus(dev->bus, virtfn_bus(dev, id));
+	bus = virtfn_add_bus(dev->bus, virtfn_bus(dev, id));
+	virtfn->bus = pci_bus_get(bus);
 	if (!virtfn->bus) {
 		kfree(virtfn);
 		mutex_unlock(&iov->dev->sriov->lock);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b494066..44a6f7d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1265,7 +1265,7 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	if (!dev)
 		return NULL;
 
-	dev->bus = bus;
+	dev->bus = pci_bus_get(bus);
 	dev->devfn = devfn;
 	dev->vendor = l & 0xffff;
 	dev->device = (l >> 16) & 0xffff;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 710067f..c4d064d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1000,6 +1000,9 @@ int pci_request_selected_regions_exclusive(struct pci_dev *, int, const char *);
 void pci_release_selected_regions(struct pci_dev *, int);
 
 /* drivers/pci/bus.c */
+extern struct pci_bus *pci_bus_get(struct pci_bus *);
+extern void pci_bus_put(struct pci_bus *);
+
 void pci_add_resource(struct list_head *resources, struct resource *res);
 void pci_add_resource_offset(struct list_head *resources, struct resource *res,
 			     resource_size_t offset);
-- 
1.7.1

