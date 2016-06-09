Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [193.47.165.129] ([193.47.165.129]:38877 "EHLO mellanox.co.il"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751180AbcFIMOA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 9 Jun 2016 08:14:00 -0400
From: Ilya Lesokhin <ilyal@mellanox.com>
To: kvm@vger.kernel.org, linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	noaos@mellanox.com, haggaie@mellanox.com, ogerlitz@mellanox.com,
	liranl@mellanox.com, ilyal@mellanox.com
Subject: [PATCH 1/4] VFIO: Probe new devices in a live VFIO group with the VFIO driver
Date: Thu,  9 Jun 2016 15:09:29 +0300
Message-Id: <1465474173-53960-2-git-send-email-ilyal@mellanox.com>
In-Reply-To: <1465474173-53960-1-git-send-email-ilyal@mellanox.com>
References: <1465474173-53960-1-git-send-email-ilyal@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When a new device is added to a live VFIO group,
use driver_override to force the device to be probed by
the VFIO driver.

Signed-off-by: Ilya Lesokhin <ilyal@mellanox.com>
---
 drivers/vfio/vfio.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 6fd6fa5..32bc1b4 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -646,6 +646,7 @@ static int vfio_dev_viable(struct device *dev, void *data)
 static int vfio_group_nb_add_dev(struct vfio_group *group, struct device *dev)
 {
 	struct vfio_device *device;
+	struct pci_dev *pdev;
 
 	/* Do we already know about it?  We shouldn't */
 	device = vfio_group_get_device(group, dev);
@@ -658,10 +659,19 @@ static int vfio_group_nb_add_dev(struct vfio_group *group, struct device *dev)
 	if (!atomic_read(&group->container_users))
 		return 0;
 
-	/* TODO Prevent device auto probing */
-	WARN(1, "Device %s added to live group %d!\n", dev_name(dev),
-	     iommu_group_id(group->iommu_group));
-
+	if (dev_is_pci(dev)) {
+		/* a device that shares a group with another VFIO
+		 * device should also be probed by VFIO
+		 */
+		pdev = to_pci_dev(dev);
+		if (pdev->driver_override)
+			kfree(pdev->driver_override);
+		pdev->driver_override = kstrdup("vfio-pci", GFP_KERNEL);
+	} else {
+		/* TODO Prevent device auto probing */
+		WARN(1, "Device %s added to live group %d!\n", dev_name(dev),
+		     iommu_group_id(group->iommu_group));
+	}
 	return 0;
 }
 
-- 
1.8.3.1

