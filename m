Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([125.16.236.1]:47729 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbcD0Mqg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2016 08:46:36 -0400
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Wed, 27 Apr 2016 18:16:34 +0530
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux-foundation.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	joro@8bytes.org, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	eric.auger@linaro.org, will.deacon@arm.com,
	gwshan@linux.vnet.ibm.com, David.Laight@ACULAB.COM,
	alistair@popple.id.au, ruscur@russell.cc,
	Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [PATCH 5/5] vfio-pci: Allow to mmap MSI-X table if interrupt remapping is supported
Date: Wed, 27 Apr 2016 20:43:30 +0800
Message-Id: <1461761010-5452-6-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch enables mmapping MSI-X tables if hardware supports
interrupt remapping which can ensure that a given pci device
can only shoot the MSIs assigned for it.

With MSI-X table mmapped, we also need to expose the
read/write interface which will be used to access MSI-X table.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/vfio/pci/vfio_pci.c      |    7 +++++--
 drivers/vfio/pci/vfio_pci_rdwr.c |    3 ++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 98059df..7eba77d 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -591,7 +591,9 @@ static long vfio_pci_ioctl(void *device_data,
 			    pci_resource_flags(pdev, info.index) &
 			    IORESOURCE_MEM && info.size >= PAGE_SIZE) {
 				info.flags |= VFIO_REGION_INFO_FLAG_MMAP;
-				if (info.index == vdev->msix_bar) {
+				if (info.index == vdev->msix_bar &&
+					!(pdev->bus->bus_flags &
+					PCI_BUS_FLAGS_MSI_REMAP)) {
 					ret = msix_sparse_mmap_cap(vdev, &caps);
 					if (ret)
 						return ret;
@@ -1023,7 +1025,8 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 	if (phys_len < PAGE_SIZE || req_start + req_len > phys_len)
 		return -EINVAL;
 
-	if (index == vdev->msix_bar) {
+	if (index == vdev->msix_bar &&
+		!(pdev->bus->bus_flags & PCI_BUS_FLAGS_MSI_REMAP)) {
 		/*
 		 * Disallow mmaps overlapping the MSI-X table; users don't
 		 * get to touch this directly.  We could find somewhere
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 5ffd1d9..dbf9cd0 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -164,7 +164,8 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_device *vdev, char __user *buf,
 	} else
 		io = vdev->barmap[bar];
 
-	if (bar == vdev->msix_bar) {
+	if (bar == vdev->msix_bar &&
+		!(pdev->bus->bus_flags & PCI_BUS_FLAGS_MSI_REMAP)) {
 		x_start = vdev->msix_offset;
 		x_end = vdev->msix_offset + vdev->msix_size;
 	}
-- 
1.7.9.5

