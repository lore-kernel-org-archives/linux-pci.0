Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:4733 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab3AODOz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2013 22:14:55 -0500
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Yu Zhao <yu.zhao@intel.com>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Scott Murray <scott@spiteful.org>,
	Yinghai Lu <yinghai@kernel.org>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH -v3 7/7] PCI,shpchp: use bus->devices list instead of traditional traversal
Date: Tue, 15 Jan 2013 11:12:22 +0800
Message-ID: <1358219542-16880-8-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1358219542-16880-1-git-send-email-wangyijing@huawei.com>
References: <1358219542-16880-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Use bus->devices list to traverse the pci function devices when
configure or unconfigure the slot like other pci hotplug drivers.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/hotplug/shpchp_pci.c |   16 +++-------------
 1 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp_pci.c b/drivers/pci/hotplug/shpchp_pci.c
index c627ed9..0eda985 100644
--- a/drivers/pci/hotplug/shpchp_pci.c
+++ b/drivers/pci/hotplug/shpchp_pci.c
@@ -40,7 +40,7 @@ int __ref shpchp_configure_device(struct slot *p_slot)
 	struct controller *ctrl = p_slot->ctrl;
 	struct pci_dev *bridge = ctrl->pci_dev;
 	struct pci_bus *parent = bridge->subordinate;
-	int num, fn;
+	int num;
 
 	dev = pci_get_slot(parent, PCI_DEVFN(p_slot->device, 0));
 	if (dev) {
@@ -57,25 +57,15 @@ int __ref shpchp_configure_device(struct slot *p_slot)
 		return -ENODEV;
 	}
 
-	for (fn = 0; fn < 8; fn++) {
-		dev = pci_get_slot(parent, PCI_DEVFN(p_slot->device, fn));
-		if (!dev)
-			continue;
+	list_for_each_entry(dev, &parent->devices, bus_list)
 		if ((dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) ||
 		    (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS))
 			pci_hp_add_bridge(dev);
-		pci_dev_put(dev);
-	}
 
 	pci_assign_unassigned_bridge_resources(bridge);
 
-	for (fn = 0; fn < 8; fn++) {
-		dev = pci_get_slot(parent, PCI_DEVFN(p_slot->device, fn));
-		if (!dev)
-			continue;
+	list_for_each_entry(dev, &parent->devices, bus_list)
 		pci_configure_slot(dev);
-		pci_dev_put(dev);
-	}
 
 	pci_bus_add_devices(parent);
 
-- 
1.7.1


