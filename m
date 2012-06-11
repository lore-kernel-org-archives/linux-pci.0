Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:41904 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483Ab2FKHJb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jun 2012 03:09:31 -0400
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 11 Jun 2012 12:39:28 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q5B79QCv10486020
	for <linux-pci@vger.kernel.org>; Mon, 11 Jun 2012 12:39:26 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q5BCd1NP009138
	for <linux-pci@vger.kernel.org>; Mon, 11 Jun 2012 18:09:01 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: shangw@linux.vnet.ibm.com, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH] pci: cleanup on confusing variable name for pci_create_root_bus
Date: Mon, 11 Jun 2012 15:09:18 +0800
Message-Id: <1339398558-2562-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since there are serverail *bridge* in this function, it would be a little
confusion.

Rename the local variable *bridge* to *host_bridge* for easy reading.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Reviewed-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/probe.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5e1ca3c..2cc6eef 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1648,7 +1648,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		struct pci_ops *ops, void *sysdata, struct list_head *resources)
 {
 	int error;
-	struct pci_host_bridge *bridge;
+	struct pci_host_bridge *host_bridge;
 	struct pci_bus *b, *b2;
 	struct device *dev;
 	struct pci_host_bridge_window *window, *n;
@@ -1657,8 +1657,8 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	char bus_addr[64];
 	char *fmt;
 
-	bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
-	if (!bridge)
+	host_bridge = kzalloc(sizeof(*host_bridge), GFP_KERNEL);
+	if (!host_bridge)
 		return NULL;
 
 	b = pci_alloc_bus();
@@ -1704,8 +1704,8 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 
 	b->number = b->secondary = bus;
 
-	bridge->bus = b;
-	INIT_LIST_HEAD(&bridge->windows);
+	host_bridge->bus = b;
+	INIT_LIST_HEAD(&host_bridge->windows);
 
 	if (parent)
 		dev_info(parent, "PCI host bridge to bus %s\n", dev_name(&b->dev));
@@ -1714,7 +1714,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 
 	/* Add initial resources to the bus */
 	list_for_each_entry_safe(window, n, resources, list) {
-		list_move_tail(&window->list, &bridge->windows);
+		list_move_tail(&window->list, &host_bridge->windows);
 		res = window->res;
 		offset = window->offset;
 		pci_bus_add_resource(b, res, 0);
@@ -1732,7 +1732,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	}
 
 	down_write(&pci_bus_sem);
-	list_add_tail(&bridge->list, &pci_host_bridges);
+	list_add_tail(&host_bridge->list, &pci_host_bridges);
 	list_add_tail(&b->node, &pci_root_buses);
 	up_write(&pci_bus_sem);
 
@@ -1742,7 +1742,7 @@ class_dev_reg_err:
 	device_unregister(dev);
 dev_reg_err:
 	down_write(&pci_bus_sem);
-	list_del(&bridge->list);
+	list_del(&host_bridge->list);
 	list_del(&b->node);
 	up_write(&pci_bus_sem);
 err_out:
@@ -1750,7 +1750,7 @@ err_out:
 err_dev:
 	kfree(b);
 err_bus:
-	kfree(bridge);
+	kfree(host_bridge);
 	return NULL;
 }
 
-- 
1.7.4.1

