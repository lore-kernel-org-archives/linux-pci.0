Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:51362 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752459AbeERQ4g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 May 2018 12:56:36 -0400
From: Christoph Hellwig <hch@lst.de>
To: bhelgaas@google.com
Cc: arjan@linux.intel.com, keith.busch@linux.intel.com,
        jthumshirn@suse.de, ming.lei@redhat.com, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH] PCI/sysfs: do not allow enabling/disabling a device with a driver
Date: Fri, 18 May 2018 18:56:24 +0200
Message-Id: <20180518165624.13993-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Manpulating the enable_cnt behind the back of the driver will wreck
complete havok with the kernel state, so disallow it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/pci-sysfs.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 366d93af051d..788a200fb2dc 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -288,13 +288,16 @@ static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (!val) {
-		if (pci_is_enabled(pdev))
-			pci_disable_device(pdev);
-		else
-			result = -EIO;
-	} else
+	device_lock(dev);
+	if (dev->driver)
+		result = -EBUSY;
+	else if (val)
 		result = pci_enable_device(pdev);
+	else if (pci_is_enabled(pdev))
+		pci_disable_device(pdev);
+	else
+		result = -EIO;
+	device_unlock(dev);
 
 	return result < 0 ? result : count;
 }
-- 
2.17.0
