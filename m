Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:50289 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab3ENNIA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 May 2013 09:08:00 -0400
From: Kevin Hao <haokexin@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>
Subject: [PATCH 1/2] PCI: make pcibios_bus_to_resource return either success or failure
Date: Tue, 14 May 2013 21:07:55 +0800
Message-ID: <1368536876-27307-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1368536876-27307-1-git-send-email-haokexin@gmail.com>
References: <1368536876-27307-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In some cases we need to make sure whether the address translation is
success or failure. So add a bool return value for this function.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/pci/host-bridge.c | 5 ++++-
 include/linux/pci.h       | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index a68dc61..a31885f 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -68,12 +68,13 @@ static bool region_contains(struct pci_bus_region *region1,
 	return region1->start <= region2->start && region1->end >= region2->end;
 }
 
-void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+bool pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 			     struct pci_bus_region *region)
 {
 	struct pci_host_bridge *bridge = find_pci_host_bridge(dev);
 	struct pci_host_bridge_window *window;
 	resource_size_t offset = 0;
+	bool ret = false;
 
 	list_for_each_entry(window, &bridge->windows, list) {
 		struct pci_bus_region bus_region;
@@ -86,11 +87,13 @@ void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 
 		if (region_contains(&bus_region, region)) {
 			offset = window->offset;
+			ret = true;
 			break;
 		}
 	}
 
 	res->start = region->start + offset;
 	res->end = region->end + offset;
+	return ret;
 }
 EXPORT_SYMBOL(pcibios_bus_to_resource);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3a24e4f..ea5fb61 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -714,7 +714,7 @@ void pci_fixup_cardbus(struct pci_bus *);
 
 void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			     struct resource *res);
-void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+bool pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 			     struct pci_bus_region *region);
 void pcibios_scan_specific_bus(int busn);
 struct pci_bus *pci_find_bus(int domain, int busnr);
-- 
1.8.1.4

