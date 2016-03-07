Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([125.16.236.3]:57940 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbcCGHt4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2016 02:49:56 -0500
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Mon, 7 Mar 2016 13:19:52 +0530
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, corbet@lwn.net, aik@ozlabs.ru,
	alex.williamson@redhat.com, benh@kernel.crashing.org,
	paulus@samba.org, mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC PATCH v4 6/7] vfio-pci: Allow to mmap MSI-X table if IOMMU_CAP_INTR_REMAP was set
Date: Mon,  7 Mar 2016 15:48:37 +0800
Message-Id: <1457336918-3893-7-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1457336918-3893-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1457336918-3893-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current vfio-pci implementation disallows to mmap MSI-X
table in case that user get to touch this directly.

But we should allow to mmap these MSI-X tables if IOMMU
supports interrupt remapping which can ensure that a
given pci device can only shoot the MSIs assigned for it.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/vfio/pci/vfio_pci.c      |    8 +++++---
 drivers/vfio/pci/vfio_pci_rdwr.c |    4 +++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 49d7a69..d6f4788 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -592,13 +592,14 @@ static long vfio_pci_ioctl(void *device_data,
 			    IORESOURCE_MEM && !pci_resources_share_page(pdev,
 			    info.index)) {
 				info.flags |= VFIO_REGION_INFO_FLAG_MMAP;
-				if (info.index == vdev->msix_bar) {
+				if (!iommu_capable(pdev->dev.bus,
+					IOMMU_CAP_INTR_REMAP) &&
+					info.index == vdev->msix_bar) {
 					ret = msix_sparse_mmap_cap(vdev, &caps);
 					if (ret)
 						return ret;
 				}
 			}
-
 			break;
 		case VFIO_PCI_ROM_REGION_INDEX:
 		{
@@ -1029,7 +1030,8 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 	if (phys_len < PAGE_SIZE || req_start + req_len > phys_len)
 		return -EINVAL;
 
-	if (index == vdev->msix_bar) {
+	if (!iommu_capable(pdev->dev.bus, IOMMU_CAP_INTR_REMAP) &&
+		index == vdev->msix_bar) {
 		/*
 		 * Disallow mmaps overlapping the MSI-X table; users don't
 		 * get to touch this directly.  We could find somewhere
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 5ffd1d9..1c46c29 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -18,6 +18,7 @@
 #include <linux/uaccess.h>
 #include <linux/io.h>
 #include <linux/vgaarb.h>
+#include <linux/iommu.h>
 
 #include "vfio_pci_private.h"
 
@@ -164,7 +165,8 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_device *vdev, char __user *buf,
 	} else
 		io = vdev->barmap[bar];
 
-	if (bar == vdev->msix_bar) {
+	if (!iommu_capable(pdev->dev.bus, IOMMU_CAP_INTR_REMAP) &&
+		bar == vdev->msix_bar) {
 		x_start = vdev->msix_offset;
 		x_end = vdev->msix_offset + vdev->msix_size;
 	}
-- 
1.7.9.5

