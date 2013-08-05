Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:34388 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755217Ab3HEIze (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Aug 2013 04:55:34 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Rafael <rjw@sisk.pl>,
	Oliver Neukum <oneukum@suse.de>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Paul Bolle <pebolle@tiscali.nl>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH -v5 6/6] PCI,pciehp: identify device change during suspend
Date: Mon, 5 Aug 2013 16:54:58 +0800
Message-ID: <1375692898-27476-7-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1375692898-27476-1-git-send-email-wangyijing@huawei.com>
References: <1375692898-27476-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If device was removed from slot and reinsert a new device during
suspend, pciehp can not identify the physical device change now.
So the old driver .resume() method will be called for the new device,
this is bad. If device support device serial number capability,
we can identify this by DSN. So the reasonable way is first remove
the old device, then enable the new device.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Cc: Paul Bolle <pebolle@tiscali.nl>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Oliver Neukum <oneukum@suse.de>
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/hotplug/pciehp_core.c |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 7fe9dbd..7c6e4a6 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -301,6 +301,8 @@ static int pciehp_resume (struct pcie_device *dev)
 	struct controller *ctrl;
 	struct slot *slot;
 	struct pci_bus *pbus = dev->port->subordinate;
+	struct pci_dev *pdev;
+	int ret = 0;
 	u8 status;
 
 	ctrl = get_service_data(dev);
@@ -313,8 +315,33 @@ static int pciehp_resume (struct pcie_device *dev)
 	/* Check if slot is occupied */
 	pciehp_get_adapter_status(slot, &status);
 	if (status) {
-		if (list_empty(&pbus->devices))
+		if (list_empty(&pbus->devices)) {
 			pciehp_enable_slot(slot);
+			return 0;
+		}
+
+		pdev = pci_get_slot(pbus, PCI_DEVFN(0, 0));
+		if (!pdev)
+			return 0;
+		ret = pci_serial_number_changed(pdev);
+		pci_dev_put(pdev);
+		if (ret) {
+			/*
+			 * first power off slot, avoid the old driver
+			 * .remove() method touch the new hardware
+			 */
+			if (POWER_CTRL(ctrl)) {
+				ret = pciehp_power_off_slot(slot);
+				if (ret) {
+					ctrl_err(ctrl,
+						"Issue of Slot Disable command failed\n");
+					return 0;
+				}
+				msleep(1000);
+				pciehp_unconfigure_device(slot);
+				pciehp_enable_slot(slot);
+			}
+		}
 	} else if (!list_empty(&pbus->devices)) {
 		pciehp_disable_slot(slot);
 	}
-- 
1.7.1


