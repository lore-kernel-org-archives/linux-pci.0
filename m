Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:4736 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369Ab3AODOz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2013 22:14:55 -0500
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Yu Zhao <yu.zhao@intel.com>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Scott Murray <scott@spiteful.org>,
	Yinghai Lu <yinghai@kernel.org>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH -v3 6/7] PCI,sgihp: use bus->devices list intead of traditional traversal
Date: Tue, 15 Jan 2013 11:12:21 +0800
Message-ID: <1358219542-16880-7-git-send-email-wangyijing@huawei.com>
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
 drivers/pci/hotplug/sgi_hotplug.c |   40 +++++++++++++++---------------------
 1 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/hotplug/sgi_hotplug.c b/drivers/pci/hotplug/sgi_hotplug.c
index f64ca92..45966b8 100644
--- a/drivers/pci/hotplug/sgi_hotplug.c
+++ b/drivers/pci/hotplug/sgi_hotplug.c
@@ -334,7 +334,7 @@ static int enable_slot(struct hotplug_slot *bss_hotplug_slot)
 	struct slot *slot = bss_hotplug_slot->private;
 	struct pci_bus *new_bus = NULL;
 	struct pci_dev *dev;
-	int func, num_funcs;
+	int num_funcs;
 	int new_ppb = 0;
 	int rc;
 	char *ssdt = NULL;
@@ -381,29 +381,23 @@ static int enable_slot(struct hotplug_slot *bss_hotplug_slot)
 	 * to the Linux PCI interface and tell the drivers
 	 * about them.
 	 */
-	for (func = 0; func < num_funcs;  func++) {
-		dev = pci_get_slot(slot->pci_bus,
-				   PCI_DEVFN(slot->device_num + 1,
-					     PCI_FUNC(func)));
-		if (dev) {
-			/* Need to do slot fixup on PPB before fixup of children
-			 * (PPB's pcidev_info needs to be in pcidev_info list
-			 * before child's SN_PCIDEV_INFO() call to setup
-			 * pdi_host_pcidev_info).
-			 */
-			pcibios_fixup_device_resources(dev);
-			if (SN_ACPI_BASE_SUPPORT())
-				sn_acpi_slot_fixup(dev);
-			else
-				sn_io_slot_fixup(dev);
-			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-				pci_hp_add_bridge(dev);
-				if (dev->subordinate) {
-					new_bus = dev->subordinate;
-					new_ppb = 1;
-				}
+	list_for_each_entry(dev, &slot->pci_bus->devices, bus_list) {
+		/* Need to do slot fixup on PPB before fixup of children
+		 * (PPB's pcidev_info needs to be in pcidev_info list
+		 * before child's SN_PCIDEV_INFO() call to setup
+		 * pdi_host_pcidev_info).
+	 */
+		pcibios_fixup_device_resources(dev);
+		if (SN_ACPI_BASE_SUPPORT())
+			sn_acpi_slot_fixup(dev);
+		else
+			sn_io_slot_fixup(dev);
+		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+			pci_hp_add_bridge(dev);
+			if (dev->subordinate) {
+				new_bus = dev->subordinate;
+				new_ppb = 1;
 			}
-			pci_dev_put(dev);
 		}
 	}
 
-- 
1.7.1


