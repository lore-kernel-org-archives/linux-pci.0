Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:48615 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbaLHBW1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 7 Dec 2014 20:22:27 -0500
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 8 Dec 2014 11:22:25 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 47382357805C
	for <linux-pci@vger.kernel.org>; Mon,  8 Dec 2014 12:22:22 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sB81MLnJ35389490
	for <linux-pci@vger.kernel.org>; Mon, 8 Dec 2014 12:22:22 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sB81MKXk009995
	for <linux-pci@vger.kernel.org>; Mon, 8 Dec 2014 12:22:21 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: alex.williamson@redhat.com, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH] vfio-pci: Fix the check on pci device type in vfio_pci_probe()
Date: Mon,  8 Dec 2014 09:22:18 +0800
Message-Id: <1418001738-7010-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current vfio-pci just supports normal pci device, so vfio_pci_probe() will
return if the pci device is not a normal device. While current code makes a
mistake. PCI_HEADER_TYPE is the offset in configuration space of the device
type, but we use this value to mask the type value.

This patch adds a function to check whether the pci device is a normal type
and use it in vfio_pci_probe().

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/vfio/pci/vfio_pci.c |    4 +---
 include/linux/pci.h         |   11 +++++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 9558da3..f82bf62 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -839,13 +839,11 @@ static const struct vfio_device_ops vfio_pci_ops = {
 
 static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	u8 type;
 	struct vfio_pci_device *vdev;
 	struct iommu_group *group;
 	int ret;
 
-	pci_read_config_byte(pdev, PCI_HEADER_TYPE, &type);
-	if ((type & PCI_HEADER_TYPE) != PCI_HEADER_TYPE_NORMAL)
+	if (!pci_is_normal(pdev))
 		return -EINVAL;
 
 	group = iommu_group_get(&pdev->dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 48d1f98..2027f66 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -519,6 +519,17 @@ static inline bool pci_is_bridge(struct pci_dev *dev)
 		dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
 }
 
+/**
+ * pci_is_normal - check if the PCI device is a normal device
+ * @dev: PCI device
+ *
+ * Return true if the PCI device is a normal device
+ */
+static inline bool pci_is_normal(struct pci_dev *dev)
+{
+	return dev->hdr_type == PCI_HEADER_TYPE_NORMAL;
+}
+
 static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
 {
 	dev = pci_physfn(dev);
-- 
1.7.9.5

