Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:46061 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899AbaLWC62 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Dec 2014 21:58:28 -0500
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 23 Dec 2014 12:58:25 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: alex.williamson@redhat.com, bhelgaas@google.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V2] vfio-pci: Fix the check on pci device type in vfio_pci_probe()
Date: Tue, 23 Dec 2014 10:58:07 +0800
Message-Id: <1419303487-9077-1-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <20141223011622.GA6035@richard>
References: <20141223011622.GA6035@richard>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current vfio-pci just supports normal pci device, so vfio_pci_probe() will
return if the pci device is not a normal device. While current code makes a
mistake. PCI_HEADER_TYPE is the offset in configuration space of the device
type, but we use this value to mask the type value.

This patch fixs this by do the check directly on the pci_dev->hdr_type.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

V2:
   * Fix the problem by checking pci_dev->hdr_type

---
 drivers/vfio/pci/vfio_pci.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 9558da3..2f8a055 100644
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
+	if (pdev->hdr_type != PCI_HEADER_TYPE_NORMAL)
 		return -EINVAL;
 
 	group = iommu_group_get(&pdev->dev);
-- 
1.7.9.5

