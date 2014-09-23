Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:53432 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbaIWFDS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Sep 2014 01:03:18 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v3 3/9] PCI/MSI: Change msi_bus attribute to support enable/disable MSI for EP
Date: Tue, 23 Sep 2014 13:27:24 +0800
Message-ID: <1411450050-1510-4-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1411450050-1510-1-git-send-email-wangyijing@huawei.com>
References: <1411450050-1510-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Msi_bus attribute is only valid for bridge device.
We can enable or disable MSI capability for a bus,
if we echo 1/0 > /sys/bus/pci/devices/$EP/msi_bus,
the action will be ignored. Sometime we need to
only enable/disable a EP device MSI capability,
not all devices share the same bus.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 Documentation/ABI/testing/sysfs-bus-pci |    9 +++++++++
 drivers/pci/pci-sysfs.c                 |   12 ++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 6615fda..edc4e8d 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -65,6 +65,15 @@ Description:
 		force a rescan of all PCI buses in the system, and
 		re-discover previously removed devices.
 
+What:		/sys/bus/pci/devices/.../msi_bus
+Date:		September 2014
+Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
+Description:
+		Writing a zero value to this attribute will turn off
+		MSI capability for device. If device is a bridge, all
+		child devices under the bridge will be set to no MSI.
+		Drivers need to be reloaded to valid the new setting.
+
 What:		/sys/bus/pci/devices/.../msi_irqs/
 Date:		September, 2011
 Contact:	Neil Horman <nhorman@tuxdriver.com>
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9ff0a90..b199ad9 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -251,11 +251,9 @@ static ssize_t msi_bus_show(struct device *dev, struct device_attribute *attr,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	if (!pdev->subordinate)
-		return 0;
-
-	return sprintf(buf, "%u\n",
-		       !(pdev->subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI));
+	return sprintf(buf, "%u\n", pdev->subordinate ?
+		       !(pdev->subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI)
+			   : !pdev->no_msi);
 }
 
 static ssize_t msi_bus_store(struct device *dev, struct device_attribute *attr,
@@ -278,8 +276,10 @@ static ssize_t msi_bus_store(struct device *dev, struct device_attribute *attr,
 	 * Maybe devices without subordinate buses shouldn't have this
 	 * attribute in the first place?
 	 */
-	if (!pdev->subordinate)
+	if (!pdev->subordinate) {
+		pdev->no_msi = !val;
 		return count;
+	}
 
 	/* Is the flag going to change, or keep the value it already had? */
 	if (!(pdev->subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI) ^
-- 
1.7.1

