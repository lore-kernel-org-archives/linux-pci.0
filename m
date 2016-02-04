Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [193.47.165.129] ([193.47.165.129]:33956 "EHLO mellanox.co.il"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755241AbcBDI3j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Feb 2016 03:29:39 -0500
From: Ilya Lesokhin <ilyal@mellanox.com>
To: kvm@vger.kernel.org, linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	noaos@mellanox.com, haggaie@mellanox.com, ogerlitz@mellanox.com,
	liranl@mellanox.com, ilyal@mellanox.com
Subject: [RFC V2 1/4] VFIO: Probe new devices in a live VFIO group with the VFIO driver
Date: Thu,  4 Feb 2016 10:28:54 +0200
Message-Id: <1454574537-123466-2-git-send-email-ilyal@mellanox.com>
In-Reply-To: <1454574537-123466-1-git-send-email-ilyal@mellanox.com>
References: <1454574537-123466-1-git-send-email-ilyal@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When a new device is added to a live VFIO group,
use driver_override to force the device to be probed by
the VFIO driver.

Signed-off-by: Ilya Lesokhin <ilyal@mellanox.com>
---
 drivers/vfio/vfio.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 563c510..176647e 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -504,6 +504,7 @@ static int vfio_dev_viable(struct device *dev, void *data)
 static int vfio_group_nb_add_dev(struct vfio_group *group, struct device *dev)
 {
 	struct vfio_device *device;
+	struct pci_dev *pdev;
 
 	/* Do we already know about it?  We shouldn't */
 	device = vfio_group_get_device(group, dev);
@@ -516,9 +517,20 @@ static int vfio_group_nb_add_dev(struct vfio_group *group, struct device *dev)
 	if (!atomic_read(&group->container_users))
 		return 0;
 
-	/* TODO Prevent device auto probing */
-	WARN("Device %s added to live group %d!\n", dev_name(dev),
-	     iommu_group_id(group->iommu_group));
+	if (dev_is_pci(dev)) {
+		/* a device that shares a group with another VFIO
+		 * device should also be probed by VFIO
+		 */
+		pdev = to_pci_dev(dev);
+		if (pdev->driver_override)
+			kfree(pdev->driver_override);
+
+		pdev->driver_override = kstrdup("vfio-pci", GFP_KERNEL);
+	} else {
+		/* TODO Prevent device auto probing */
+		WARN("Device %s added to live group %d!\n", dev_name(dev),
+		     iommu_group_id(group->iommu_group));
+	}
 
 	return 0;
 }
-- 
1.8.3.1

