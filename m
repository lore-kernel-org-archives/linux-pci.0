Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:4758 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab3AODO5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2013 22:14:57 -0500
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Yu Zhao <yu.zhao@intel.com>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Scott Murray <scott@spiteful.org>,
	Yinghai Lu <yinghai@kernel.org>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH -v3 5/7] PCI,cpcihp: use bus->devices list instead of traditional traversal
Date: Tue, 15 Jan 2013 11:12:20 +0800
Message-ID: <1358219542-16880-6-git-send-email-wangyijing@huawei.com>
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
 drivers/pci/hotplug/cpci_hotplug_pci.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/hotplug/cpci_hotplug_pci.c b/drivers/pci/hotplug/cpci_hotplug_pci.c
index dcc75c7..9329642 100644
--- a/drivers/pci/hotplug/cpci_hotplug_pci.c
+++ b/drivers/pci/hotplug/cpci_hotplug_pci.c
@@ -252,8 +252,8 @@ int cpci_led_off(struct slot* slot)
 
 int __ref cpci_configure_slot(struct slot *slot)
 {
+	struct pci_dev *dev;
 	struct pci_bus *parent;
-	int fn;
 
 	dbg("%s - enter", __func__);
 
@@ -282,18 +282,11 @@ int __ref cpci_configure_slot(struct slot *slot)
 	}
 	parent = slot->dev->bus;
 
-	for (fn = 0; fn < 8; fn++) {
-		struct pci_dev *dev;
-
-		dev = pci_get_slot(parent,
-				   PCI_DEVFN(PCI_SLOT(slot->devfn), fn));
-		if (!dev)
-			continue;
+	list_for_each_entry(dev, &parent->devices, bus_list)
 		if ((dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) ||
 		    (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS))
 			pci_hp_add_bridge(dev);
-		pci_dev_put(dev);
-	}
+
 
 	pci_assign_unassigned_bridge_resources(parent->self);
 
-- 
1.7.1


