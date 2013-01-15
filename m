Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:49198 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754869Ab3AODPj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2013 22:15:39 -0500
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Yu Zhao <yu.zhao@intel.com>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Scott Murray <scott@spiteful.org>,
	Yinghai Lu <yinghai@kernel.org>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH -v3 4/7] PCI,pciehp: use bus->devices list intead of traditional traversal
Date: Tue, 15 Jan 2013 11:12:19 +0800
Message-ID: <1358219542-16880-5-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1358219542-16880-1-git-send-email-wangyijing@huawei.com>
References: <1358219542-16880-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

pciehp driver traverses pci function deivces by for(fn = 0; fn < 8; fn++) to
configure every pci device when enable or disable slot.
If the pci device to be add/remove is an ARI device, this traversal may
miss some function device configuration, because ari device function
number is up to 255. This patch fix this problem by traversing bus->devices
list to configure pci device.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/hotplug/pciehp_pci.c |   46 ++++++++++++++------------------------
 1 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 09cecaf..0cc1977 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -39,7 +39,7 @@ int pciehp_configure_device(struct slot *p_slot)
 	struct pci_dev *dev;
 	struct pci_dev *bridge = p_slot->ctrl->pcie->port;
 	struct pci_bus *parent = bridge->subordinate;
-	int num, fn;
+	int num;
 	struct controller *ctrl = p_slot->ctrl;
 
 	dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
@@ -57,28 +57,18 @@ int pciehp_configure_device(struct slot *p_slot)
 		return -ENODEV;
 	}
 
-	for (fn = 0; fn < 8; fn++) {
-		dev = pci_get_slot(parent, PCI_DEVFN(0, fn));
-		if (!dev)
-			continue;
+	list_for_each_entry(dev, &parent->devices, bus_list)
 		if ((dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) ||
 				(dev->hdr_type == PCI_HEADER_TYPE_CARDBUS))
 			pci_hp_add_bridge(dev);
-		pci_dev_put(dev);
-	}
-
+
 	pci_assign_unassigned_bridge_resources(bridge);
 
-	for (fn = 0; fn < 8; fn++) {
-		dev = pci_get_slot(parent, PCI_DEVFN(0, fn));
-		if (!dev)
-			continue;
-		if ((dev->class >> 16) == PCI_BASE_CLASS_DISPLAY) {
-			pci_dev_put(dev);
+	list_for_each_entry(dev, &parent->devices, bus_list) {
+		if ((dev->class >> 16) == PCI_BASE_CLASS_DISPLAY)
 			continue;
-		}
+
 		pci_configure_slot(dev);
-		pci_dev_put(dev);
 	}
 
 	pci_bus_add_devices(parent);
@@ -89,9 +79,9 @@ int pciehp_configure_device(struct slot *p_slot)
 int pciehp_unconfigure_device(struct slot *p_slot)
 {
 	int ret, rc = 0;
-	int j;
 	u8 bctl = 0;
 	u8 presence = 0;
+	struct pci_dev *dev, *temp;
 	struct pci_bus *parent = p_slot->ctrl->pcie->port->subordinate;
 	u16 command;
 	struct controller *ctrl = p_slot->ctrl;
@@ -102,33 +92,31 @@ int pciehp_unconfigure_device(struct slot *p_slot)
 	if (ret)
 		presence = 0;
 
-	for (j = 0; j < 8; j++) {
-		struct pci_dev *temp = pci_get_slot(parent, PCI_DEVFN(0, j));
-		if (!temp)
-			continue;
-		if (temp->hdr_type == PCI_HEADER_TYPE_BRIDGE && presence) {
-			pci_read_config_byte(temp, PCI_BRIDGE_CONTROL, &bctl);
+	list_for_each_entry_safe(dev, temp, &parent->devices, bus_list) {
+		pci_dev_get(dev);
+		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE && presence) {
+			pci_read_config_byte(dev, PCI_BRIDGE_CONTROL, &bctl);
 			if (bctl & PCI_BRIDGE_CTL_VGA) {
 				ctrl_err(ctrl,
 					 "Cannot remove display device %s\n",
-					 pci_name(temp));
-				pci_dev_put(temp);
+					 pci_name(dev));
+				pci_dev_put(dev);
 				rc = -EINVAL;
 				break;
 			}
 		}
-		pci_stop_and_remove_bus_device(temp);
+		pci_stop_and_remove_bus_device(dev);
 		/*
 		 * Ensure that no new Requests will be generated from
 		 * the device.
 		 */
 		if (presence) {
-			pci_read_config_word(temp, PCI_COMMAND, &command);
+			pci_read_config_word(dev, PCI_COMMAND, &command);
 			command &= ~(PCI_COMMAND_MASTER | PCI_COMMAND_SERR);
 			command |= PCI_COMMAND_INTX_DISABLE;
-			pci_write_config_word(temp, PCI_COMMAND, command);
+			pci_write_config_word(dev, PCI_COMMAND, command);
 		}
-		pci_dev_put(temp);
+		pci_dev_put(dev);
 	}
 
 	return rc;
-- 
1.7.1


