Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-fa0-f74.google.com ([209.85.161.74]:64882 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755894Ab2HOUku (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Aug 2012 16:40:50 -0400
Received: by faem1 with SMTP id m1so6125fae.1
        for <linux-pci@vger.kernel.org>; Wed, 15 Aug 2012 13:40:48 -0700 (PDT)
Date: Wed, 15 Aug 2012 14:40:47 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, shangw@linux.vnet.ibm.com
Subject: Re: [PATCH] pci: cleanup on confusing variable name for
 pci_create_root_bus
Message-ID: <20120815204047.GA18925@google.com>
References: <1339398558-2562-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339398558-2562-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 11, 2012 at 03:09:18PM +0800, Wei Yang wrote:
> Since there are serverail *bridge* in this function, it would be a little
> confusion.
> 
> Rename the local variable *bridge* to *host_bridge* for easy reading.
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Reviewed-by: Gavin Shan <shangw@linux.vnet.ibm.com>

pci_create_root_bus() has changed somewhat since you posted this patch.
I refreshed it and also changed some other occurrences, resulting in
the following patch.  I'll apply it if it looks OK to you.

Bjorn

commit a634940588f3469b1efa883db1a8a66c3f84c06c
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed Aug 15 14:24:25 2012 -0600

    PCI: Use "host_bridge" for pci_host_bridge variable names
    
    Rename local pci_host_bridge variables from "bridge" to "host_bridge"
    to distinguish them from PCI-to-PCI bridges.
    
    Based-on-patch-by: Wei Yang <weiyang@linux.vnet.ibm.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index a68dc61..6677528 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -27,12 +27,12 @@ static struct pci_host_bridge *find_pci_host_bridge(struct pci_dev *dev)
 	return to_pci_host_bridge(bus->bridge);
 }
 
-void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
+void pci_set_host_bridge_release(struct pci_host_bridge *host_bridge,
 				 void (*release_fn)(struct pci_host_bridge *),
 				 void *release_data)
 {
-	bridge->release_fn = release_fn;
-	bridge->release_data = release_data;
+	host_bridge->release_fn = release_fn;
+	host_bridge->release_data = release_data;
 }
 
 static bool resource_contains(struct resource *res1, struct resource *res2)
@@ -43,11 +43,11 @@ static bool resource_contains(struct resource *res1, struct resource *res2)
 void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			     struct resource *res)
 {
-	struct pci_host_bridge *bridge = find_pci_host_bridge(dev);
+	struct pci_host_bridge *host_bridge = find_pci_host_bridge(dev);
 	struct pci_host_bridge_window *window;
 	resource_size_t offset = 0;
 
-	list_for_each_entry(window, &bridge->windows, list) {
+	list_for_each_entry(window, &host_bridge->windows, list) {
 		if (resource_type(res) != resource_type(window->res))
 			continue;
 
@@ -71,11 +71,11 @@ static bool region_contains(struct pci_bus_region *region1,
 void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 			     struct pci_bus_region *region)
 {
-	struct pci_host_bridge *bridge = find_pci_host_bridge(dev);
+	struct pci_host_bridge *host_bridge = find_pci_host_bridge(dev);
 	struct pci_host_bridge_window *window;
 	resource_size_t offset = 0;
 
-	list_for_each_entry(window, &bridge->windows, list) {
+	list_for_each_entry(window, &host_bridge->windows, list) {
 		struct pci_bus_region bus_region;
 
 		if (resource_type(res) != resource_type(window->res))
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6c143b4..5d084b6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -467,15 +467,15 @@ static struct pci_bus * pci_alloc_bus(void)
 
 static struct pci_host_bridge *pci_alloc_host_bridge(struct pci_bus *b)
 {
-	struct pci_host_bridge *bridge;
+	struct pci_host_bridge *host_bridge;
 
-	bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
-	if (bridge) {
-		INIT_LIST_HEAD(&bridge->windows);
-		bridge->bus = b;
+	host_bridge = kzalloc(sizeof(*host_bridge), GFP_KERNEL);
+	if (host_bridge) {
+		INIT_LIST_HEAD(&host_bridge->windows);
+		host_bridge->bus = b;
 	}
 
-	return bridge;
+	return host_bridge;
 }
 
 static unsigned char pcix_bus_speed[] = {
@@ -1179,14 +1179,14 @@ int pci_cfg_space_size(struct pci_dev *dev)
 
 static void pci_release_bus_bridge_dev(struct device *dev)
 {
-	struct pci_host_bridge *bridge = to_pci_host_bridge(dev);
+	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dev);
 
-	if (bridge->release_fn)
-		bridge->release_fn(bridge);
+	if (host_bridge->release_fn)
+		host_bridge->release_fn(host_bridge);
 
-	pci_free_resource_list(&bridge->windows);
+	pci_free_resource_list(&host_bridge->windows);
 
-	kfree(bridge);
+	kfree(host_bridge);
 }
 
 struct pci_dev *alloc_pci_dev(void)
@@ -1636,7 +1636,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		struct pci_ops *ops, void *sysdata, struct list_head *resources)
 {
 	int error;
-	struct pci_host_bridge *bridge;
+	struct pci_host_bridge *host_bridge;
 	struct pci_bus *b, *b2;
 	struct pci_host_bridge_window *window, *n;
 	struct resource *res;
@@ -1658,17 +1658,17 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		goto err_out;
 	}
 
-	bridge = pci_alloc_host_bridge(b);
-	if (!bridge)
+	host_bridge = pci_alloc_host_bridge(b);
+	if (!host_bridge)
 		goto err_out;
 
-	bridge->dev.parent = parent;
-	bridge->dev.release = pci_release_bus_bridge_dev;
-	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
-	error = device_register(&bridge->dev);
+	host_bridge->dev.parent = parent;
+	host_bridge->dev.release = pci_release_bus_bridge_dev;
+	dev_set_name(&host_bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
+	error = device_register(&host_bridge->dev);
 	if (error)
 		goto bridge_dev_reg_err;
-	b->bridge = get_device(&bridge->dev);
+	b->bridge = get_device(&host_bridge->dev);
 	device_enable_async_suspend(b->bridge);
 	pci_set_bus_of_node(b);
 
@@ -1694,7 +1694,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 
 	/* Add initial resources to the bus */
 	list_for_each_entry_safe(window, n, resources, list) {
-		list_move_tail(&window->list, &bridge->windows);
+		list_move_tail(&window->list, &host_bridge->windows);
 		res = window->res;
 		offset = window->offset;
 		if (res->flags & IORESOURCE_BUS)
@@ -1721,10 +1721,10 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	return b;
 
 class_dev_reg_err:
-	put_device(&bridge->dev);
-	device_unregister(&bridge->dev);
+	put_device(&host_bridge->dev);
+	device_unregister(&host_bridge->dev);
 bridge_dev_reg_err:
-	kfree(bridge);
+	kfree(host_bridge);
 err_out:
 	kfree(b);
 	return NULL;
