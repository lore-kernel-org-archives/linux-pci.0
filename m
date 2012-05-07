Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:50524 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757663Ab2EGU3k (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 May 2012 16:29:40 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 3/7] PCI, shpchp: Simplify configure_device
Date: Mon,  7 May 2012 13:29:12 -0700
Message-Id: <1336422556-4124-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1336422556-4124-1-git-send-email-yinghai@kernel.org>
References: <1336422556-4124-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For child p2p bridge hotplug support should use pci_scan_bridge instead.

Make it more simillar to pciehp, just use pci_hp_add_bridge()

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/hotplug/shpchp_pci.c |   45 ++++++++++++-------------------------
 1 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp_pci.c b/drivers/pci/hotplug/shpchp_pci.c
index df7e4bf..c627ed9 100644
--- a/drivers/pci/hotplug/shpchp_pci.c
+++ b/drivers/pci/hotplug/shpchp_pci.c
@@ -37,9 +37,10 @@
 int __ref shpchp_configure_device(struct slot *p_slot)
 {
 	struct pci_dev *dev;
-	struct pci_bus *parent = p_slot->ctrl->pci_dev->subordinate;
-	int num, fn;
 	struct controller *ctrl = p_slot->ctrl;
+	struct pci_dev *bridge = ctrl->pci_dev;
+	struct pci_bus *parent = bridge->subordinate;
+	int num, fn;
 
 	dev = pci_get_slot(parent, PCI_DEVFN(p_slot->device, 0));
 	if (dev) {
@@ -61,39 +62,23 @@ int __ref shpchp_configure_device(struct slot *p_slot)
 		if (!dev)
 			continue;
 		if ((dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) ||
-				(dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)) {
-			/* Find an unused bus number for the new bridge */
-			struct pci_bus *child;
-			unsigned char busnr, start = parent->secondary;
-			unsigned char end = parent->subordinate;
-			for (busnr = start; busnr <= end; busnr++) {
-				if (!pci_find_bus(pci_domain_nr(parent),
-							busnr))
-					break;
-			}
-			if (busnr > end) {
-				ctrl_err(ctrl,
-					 "No free bus for hot-added bridge\n");
-				pci_dev_put(dev);
-				continue;
-			}
-			child = pci_add_new_bus(parent, dev, busnr);
-			if (!child) {
-				ctrl_err(ctrl, "Cannot add new bus for %s\n",
-					 pci_name(dev));
-				pci_dev_put(dev);
-				continue;
-			}
-			child->subordinate = pci_do_scan_bus(child);
-			pci_bus_size_bridges(child);
-		}
+		    (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS))
+			pci_hp_add_bridge(dev);
+		pci_dev_put(dev);
+	}
+
+	pci_assign_unassigned_bridge_resources(bridge);
+
+	for (fn = 0; fn < 8; fn++) {
+		dev = pci_get_slot(parent, PCI_DEVFN(p_slot->device, fn));
+		if (!dev)
+			continue;
 		pci_configure_slot(dev);
 		pci_dev_put(dev);
 	}
 
-	pci_bus_assign_resources(parent);
 	pci_bus_add_devices(parent);
-	pci_enable_bridges(parent);
+
 	return 0;
 }
 
-- 
1.7.7

