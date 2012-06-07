Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:45861 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756Ab2FGCL4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jun 2012 22:11:56 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Thu, 7 Jun 2012 02:02:55 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q572BesM49348674
	for <linux-pci@vger.kernel.org>; Thu, 7 Jun 2012 12:11:40 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q572Be2M030627
	for <linux-pci@vger.kernel.org>; Thu, 7 Jun 2012 12:11:40 +1000
Date: Thu, 7 Jun 2012 10:11:37 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com
Subject: [PATCH] rename the local variable *bridge* to *host_bridge* in
 pci_create_root_bus.
Message-ID: <20120607021137.GA6802@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since there are serverail *bridge* in this function, it would be a
little confusion.
        
Rename it for easy reading.


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


