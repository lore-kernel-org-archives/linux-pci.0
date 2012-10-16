Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:10214 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389Ab2JPHLo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Oct 2012 03:11:44 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Yu Zhao <yu.zhao@intel.com>,
	<kernel.openeuler@huawei.com>
CC: <linux-pci@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v2 3/3] PCI, pciehp: ARI device hotplug support
Date: Tue, 16 Oct 2012 15:10:20 +0800
Message-ID: <1350371420-7888-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1350371420-7888-1-git-send-email-wangyijing@huawei.com>
References: <1350371420-7888-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

ARI device supports up to 256 Functions, pciehp now only scan and configure
Functions from 0 to 7, this patch fix this problem for ARI device hotplug.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/hotplug/pciehp_pci.c |   40 ++++++++++++++++++++++++++-----------
 1 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 09cecaf..b37e8a0 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -39,7 +39,7 @@ int pciehp_configure_device(struct slot *p_slot)
 	struct pci_dev *dev;
 	struct pci_dev *bridge = p_slot->ctrl->pcie->port;
 	struct pci_bus *parent = bridge->subordinate;
-	int num, fn;
+	int num, fn = 0;
 	struct controller *ctrl = p_slot->ctrl;
 
 	dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
@@ -56,21 +56,31 @@ int pciehp_configure_device(struct slot *p_slot)
 		ctrl_err(ctrl, "No new device found\n");
 		return -ENODEV;
 	}
-
-	for (fn = 0; fn < 8; fn++) {
-		dev = pci_get_slot(parent, PCI_DEVFN(0, fn));
+
+	do {
+		if (pci_ari_enabled(parent))
+			dev = pci_get_slot(parent, fn);
+		else
+			dev = pci_get_slot(parent, PCI_DEVFN(0, fn));
+
+		fn = pci_next_fn(parent, PCI_DEVFN(0, fn));
 		if (!dev)
 			continue;
 		if ((dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) ||
 				(dev->hdr_type == PCI_HEADER_TYPE_CARDBUS))
 			pci_hp_add_bridge(dev);
 		pci_dev_put(dev);
-	}
+	} while (fn);
 
 	pci_assign_unassigned_bridge_resources(bridge);
 
-	for (fn = 0; fn < 8; fn++) {
-		dev = pci_get_slot(parent, PCI_DEVFN(0, fn));
+	do {
+		if (pci_ari_enabled(parent))
+			dev = pci_get_slot(parent, fn);
+		else
+			dev = pci_get_slot(parent, PCI_DEVFN(0, fn));
+
+		fn = pci_next_fn(parent, PCI_DEVFN(0, fn));
 		if (!dev)
 			continue;
 		if ((dev->class >> 16) == PCI_BASE_CLASS_DISPLAY) {
@@ -79,7 +89,7 @@ int pciehp_configure_device(struct slot *p_slot)
 		}
 		pci_configure_slot(dev);
 		pci_dev_put(dev);
-	}
+	} while (fn);
 
 	pci_bus_add_devices(parent);
 
@@ -89,21 +99,27 @@ int pciehp_configure_device(struct slot *p_slot)
 int pciehp_unconfigure_device(struct slot *p_slot)
 {
 	int ret, rc = 0;
-	int j;
+	int fn = 0;
 	u8 bctl = 0;
 	u8 presence = 0;
 	struct pci_bus *parent = p_slot->ctrl->pcie->port->subordinate;
 	u16 command;
 	struct controller *ctrl = p_slot->ctrl;
+	struct pci_dev *temp;
 
 	ctrl_dbg(ctrl, "%s: domain:bus:dev = %04x:%02x:00\n",
 		 __func__, pci_domain_nr(parent), parent->number);
 	ret = pciehp_get_adapter_status(p_slot, &presence);
 	if (ret)
 		presence = 0;
+
+	do {
+		if (pci_ari_enabled(parent))
+			temp = pci_get_slot(parent, fn);
+		else
+			temp = pci_get_slot(parent, PCI_DEVFN(0, fn));
 
-	for (j = 0; j < 8; j++) {
-		struct pci_dev *temp = pci_get_slot(parent, PCI_DEVFN(0, j));
+		fn = pci_next_fn(parent, PCI_DEVFN(0, fn));
 		if (!temp)
 			continue;
 		if (temp->hdr_type == PCI_HEADER_TYPE_BRIDGE && presence) {
@@ -129,7 +145,7 @@ int pciehp_unconfigure_device(struct slot *p_slot)
 			pci_write_config_word(temp, PCI_COMMAND, command);
 		}
 		pci_dev_put(temp);
-	}
+	} while (fn);
 
 	return rc;
 }
-- 
1.7.1


