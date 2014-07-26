Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:21684 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbaGZBX1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jul 2014 21:23:27 -0400
From: <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 3/3] PCI/MSI: Refactor msi_bus to support EP enable/disable MSI
Date: Sat, 26 Jul 2014 09:48:36 +0800
Message-ID: <1406339316-20163-4-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1406339316-20163-1-git-send-email-wangyijing@huawei.com>
References: <1406339316-20163-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Yijing Wang <wangyijing@huawei.com>

Msi_bus attribute is only valid for bridge device.
We can enable or disable MSI capability for a bus,
if we echo 1/0 > /sys/bus/pci/devices/$EP/msi_bus,
the action will be ignored. Sometime we need to
only enable/disable a device MSI, not all devices share
the same bus.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pci-sysfs.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

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

