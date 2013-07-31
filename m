Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41609 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759802Ab3GaNmK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 31 Jul 2013 09:42:10 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, alexander.h.duyck@intel.com,
	ddutile@redhat.com
Subject: [PATCH] pci: adjust return values for error cases of IOV functions
Date: Wed, 31 Jul 2013 15:41:28 +0200
Message-Id: <1375278088-31260-1-git-send-email-sassmann@kpanic.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changing the return value to -ENOSYS if a device is not physical PCI function.
Also have pci_sriov_get_totalvfs() return 0 in the error cae to make the
behaviour consistent whether CONFIG_PCI_IOV is enabled or not.
Some comment fixes.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 drivers/pci/iov.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index de8ffac..1fc9942 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -324,7 +324,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 
 		if (!pdev->is_physfn) {
 			pci_dev_put(pdev);
-			return -ENODEV;
+			return -ENOSYS;
 		}
 
 		rc = sysfs_create_link(&dev->dev.kobj,
@@ -662,7 +662,7 @@ int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
 	might_sleep();
 
 	if (!dev->is_physfn)
-		return -ENODEV;
+		return -ENOSYS;
 
 	return sriov_enable(dev, nr_virtfn);
 }
@@ -722,7 +722,7 @@ EXPORT_SYMBOL_GPL(pci_num_vf);
  * @dev: the PCI device
  *
  * Returns number of VFs belonging to this device that are assigned to a guest.
- * If device is not a physical function returns -ENODEV.
+ * If device is not a physical function returns 0.
  */
 int pci_vfs_assigned(struct pci_dev *dev)
 {
@@ -767,12 +767,15 @@ EXPORT_SYMBOL_GPL(pci_vfs_assigned);
  * device's mutex held.
  *
  * Returns 0 if PF is an SRIOV-capable device and
- * value of numvfs valid. If not a PF with VFS, return -EINVAL;
+ * value of numvfs valid. If not a PF return -ENOSYS;
+ * if numvfs is invalid return -EINVAL;
  * if VFs already enabled, return -EBUSY.
  */
 int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
 {
-	if (!dev->is_physfn || (numvfs > dev->sriov->total_VFs))
+	if (!dev->is_physfn)
+		return -ENOSYS;
+	if (numvfs > dev->sriov->total_VFs)
 		return -EINVAL;
 
 	/* Shouldn't change if VFs already enabled */
@@ -786,17 +789,17 @@ int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
 EXPORT_SYMBOL_GPL(pci_sriov_set_totalvfs);
 
 /**
- * pci_sriov_get_totalvfs -- get total VFs supported on this devic3
+ * pci_sriov_get_totalvfs -- get total VFs supported on this device
  * @dev: the PCI PF device
  *
  * For a PCIe device with SRIOV support, return the PCIe
  * SRIOV capability value of TotalVFs or the value of driver_max_VFs
- * if the driver reduced it.  Otherwise, -EINVAL.
+ * if the driver reduced it.  Otherwise 0.
  */
 int pci_sriov_get_totalvfs(struct pci_dev *dev)
 {
 	if (!dev->is_physfn)
-		return -EINVAL;
+		return 0;
 
 	if (dev->sriov->driver_max_VFs)
 		return dev->sriov->driver_max_VFs;
-- 
1.8.3.1

