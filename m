Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:34129 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751336AbdJXUEz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Oct 2017 16:04:55 -0400
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To: alex.williamson@redhat.com
Cc: Liang-Min Wang <liang-min.wang@intel.com>, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, alexander.h.duyck@intel.com
Subject: [PATCH] Enable SR-IOV instantiation through /sys file
Date: Tue, 24 Oct 2017 13:04:26 -0700
Message-Id: <20171024200426.62811-1-jeffrey.t.kirsher@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Liang-Min Wang <liang-min.wang@intel.com>

When a SR-IOV supported device is bound with vfio-pci, the driver
could not create SR-IOV instance through /sys/bus/pci/devices/...
/sriov_numvfs. This patch re-activates this capability for a PCIe 
device that supports SR-IOV and is bound with vfio-pci.ko. 

Signed-off-by: Liang-Min Wang <liang-min.wang@intel.com>
---
 drivers/vfio/pci/vfio_pci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index f041b1a6cf66..8fbd362607e1 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1256,6 +1256,7 @@ static void vfio_pci_remove(struct pci_dev *pdev)
 	if (!vdev)
 		return;
 
+	pci_disable_sriov(pdev);
 	vfio_iommu_group_put(pdev->dev.iommu_group, &pdev->dev);
 	kfree(vdev->region);
 	kfree(vdev);
@@ -1303,12 +1304,23 @@ static const struct pci_error_handlers vfio_err_handlers = {
 	.error_detected = vfio_pci_aer_err_detected,
 };
 
+static int vfio_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	if (!num_vfs) {
+		pci_disable_sriov(pdev);
+		return 0;
+	}
+
+	return pci_enable_sriov(pdev, num_vfs);
+}
+
 static struct pci_driver vfio_pci_driver = {
 	.name		= "vfio-pci",
 	.id_table	= NULL, /* only dynamic ids */
 	.probe		= vfio_pci_probe,
 	.remove		= vfio_pci_remove,
 	.err_handler	= &vfio_err_handlers,
+	.sriov_configure = vfio_sriov_configure,
 };
 
 struct vfio_devices {
-- 
2.14.2
