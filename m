Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:42211 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754910Ab1LGIxy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2011 03:53:54 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 3/5] PCI: Using add_list in pcie hotplug path.
Date: Wed,  7 Dec 2011 00:53:02 -0800
Message-Id: <1323247984-15281-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
References: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We need add size for hot plug path when pluging in hotplug chassis without cards.
-v2: change descriptions. make it can be applied after
	pci: Check bridge resources after resource allocation.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/setup-bus.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/pci/setup-bus.c
===================================================================
--- linux-2.6.orig/drivers/pci/setup-bus.c
+++ linux-2.6/drivers/pci/setup-bus.c
@@ -327,13 +327,14 @@ requested_and_reassign:
 }
 
 static void pdev_assign_resources_sorted(struct pci_dev *dev,
+				 struct resource_list_x *add_head,
 				 struct resource_list_x *fail_head)
 {
 	struct resource_list head;
 
 	head.next = NULL;
 	__dev_sort_resources(dev, &head);
-	__assign_resources_sorted(&head, NULL, fail_head);
+	__assign_resources_sorted(&head, add_head, fail_head);
 
 }
 
@@ -1003,17 +1004,19 @@ void __ref pci_bus_assign_resources(cons
 EXPORT_SYMBOL(pci_bus_assign_resources);
 
 static void __ref __pci_bridge_assign_resources(const struct pci_dev *bridge,
+					 struct resource_list_x *add_head,
 					 struct resource_list_x *fail_head)
 {
 	struct pci_bus *b;
 
-	pdev_assign_resources_sorted((struct pci_dev *)bridge, fail_head);
+	pdev_assign_resources_sorted((struct pci_dev *)bridge,
+					 add_head, fail_head);
 
 	b = bridge->subordinate;
 	if (!b)
 		return;
 
-	__pci_bus_assign_resources(b, NULL, fail_head);
+	__pci_bus_assign_resources(b, add_head, fail_head);
 
 	switch (bridge->class >> 8) {
 	case PCI_CLASS_BRIDGE_PCI:
@@ -1288,6 +1291,8 @@ enable_and_dump:
 void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 {
 	struct pci_bus *parent = bridge->subordinate;
+	struct resource_list_x add_list; /* list of resources that
+					want additional resources */
 	int tried_times = 0;
 	struct resource_list_x head, *list;
 	int retval;
@@ -1295,11 +1300,12 @@ void pci_assign_unassigned_bridge_resour
 				  IORESOURCE_PREFETCH;
 
 	head.next = NULL;
+	add_list.next = NULL;
 
 again:
-	pci_bus_size_bridges(parent);
-	__pci_bridge_assign_resources(bridge, &head);
-
+	__pci_bus_size_bridges(parent, &add_list);
+	__pci_bridge_assign_resources(bridge, &add_list, &head);
+	BUG_ON(add_list.next);
 	tried_times++;
 
 	if (!head.next)
