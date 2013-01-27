Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:32312 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388Ab3A0TYW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Jan 2013 14:24:22 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Toshi Kani <toshi.kani@hp.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v3 12/22] PCI: Kill pci_root_buses in setup-bus
Date: Sun, 27 Jan 2013 11:23:39 -0800
Message-Id: <1359314629-18651-13-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359314629-18651-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQXHG01NjnYNDbC-KEpbcvY-q4pBe97CxTOGS7W4vZQBYQ@mail.gmail.com>
 <1359314629-18651-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace that with hotplug-safe version iteration.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7e8739e..8c0870b 100644
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
1.7.10.4

