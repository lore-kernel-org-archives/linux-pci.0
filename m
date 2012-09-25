Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:42852 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924Ab2IYI0s (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 04:26:48 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 19/29] PCI: kill pci_root_buses in setup-bus
Date: Tue, 25 Sep 2012 01:26:20 -0700
Message-Id: <1348561590-28067-20-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 1e808ca..9737185 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1318,12 +1318,12 @@ static int __init pci_bus_get_depth(struct pci_bus *bus)
 static int __init pci_get_max_depth(void)
 {
 	int depth = 0;
-	struct pci_bus *bus;
+	struct pci_host_bridge *host_bridge = NULL;
 
-	list_for_each_entry(bus, &pci_root_buses, node) {
+	for_each_pci_host_bridge(host_bridge) {
 		int ret;
 
-		ret = pci_bus_get_depth(bus);
+		ret = pci_bus_get_depth(host_bridge->bus);
 		if (ret > depth)
 			depth = ret;
 	}
@@ -1393,6 +1393,7 @@ void __init
 pci_assign_unassigned_resources(void)
 {
 	struct pci_bus *bus;
+	struct pci_host_bridge *host_bridge = NULL;
 	LIST_HEAD(realloc_head); /* list of resources that
 					want additional resources */
 	struct list_head *add_list = NULL;
@@ -1423,12 +1424,13 @@ again:
 		add_list = &realloc_head;
 	/* Depth first, calculate sizes and alignments of all
 	   subordinate buses. */
-	list_for_each_entry(bus, &pci_root_buses, node)
-		__pci_bus_size_bridges(bus, add_list);
+	for_each_pci_host_bridge(host_bridge)
+		__pci_bus_size_bridges(host_bridge->bus, add_list);
 
 	/* Depth last, allocate resources and update the hardware. */
-	list_for_each_entry(bus, &pci_root_buses, node)
-		__pci_bus_assign_resources(bus, add_list, &fail_head);
+	for_each_pci_host_bridge(host_bridge)
+		__pci_bus_assign_resources(host_bridge->bus, add_list,
+						 &fail_head);
 	if (add_list)
 		BUG_ON(!list_empty(add_list));
 	tried_times++;
@@ -1480,12 +1482,12 @@ again:
 
 enable_and_dump:
 	/* Depth last, update the hardware. */
-	list_for_each_entry(bus, &pci_root_buses, node)
-		pci_enable_bridges(bus);
+	for_each_pci_host_bridge(host_bridge)
+		pci_enable_bridges(host_bridge->bus);
 
 	/* dump the resource on buses */
-	list_for_each_entry(bus, &pci_root_buses, node)
-		pci_bus_dump_resources(bus);
+	for_each_pci_host_bridge(host_bridge)
+		pci_bus_dump_resources(host_bridge->bus);
 }
 
 void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
-- 
1.7.7

