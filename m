Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60263 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754468AbcE3Nkj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 May 2016 09:40:39 -0400
Received: from pps.filterd (m0075420.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u4UDeVNX026481
	for <linux-pci@vger.kernel.org>; Mon, 30 May 2016 09:40:38 -0400
Message-Id: <201605301340.u4UDeVNX026481@mx0a-001b2d01.pphosted.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0a-001b2d01.pphosted.com with ESMTP id 238j3ypsxq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 30 May 2016 09:40:36 -0400
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Mon, 30 May 2016 23:39:02 +1000
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux-foundation.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	joro@8bytes.org, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	eric.auger@linaro.org, will.deacon@arm.com,
	gwshan@linux.vnet.ibm.com, alistair@popple.id.au,
	ruscur@russell.cc, kevin.tian@intel.com, David.Laight@ACULAB.COM
Subject: [PATCH v2 6/6] vfio-pci: Allow to expose MSI-X table to userspace if interrupt remapping is enabled
Date: Mon, 30 May 2016 21:32:13 +0800
In-Reply-To: <1464615133-12050-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1464615133-12050-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch tries to expose MSI-X tables to userspace if hardware
enables interrupt remapping. This capability can ensure that a
given PCI device can only shoot the MSIs assigned for it. That
means a userspace driver could never hurt other devices or system
by writing to the exposed MSI-X table directly.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/vfio/pci/vfio_pci.c      |   17 ++++++++++++++---
 drivers/vfio/pci/vfio_pci_rdwr.c |    3 ++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 188b1ff..6bae388 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -487,8 +487,12 @@ static int msix_sparse_mmap_cap(struct vfio_pci_device *vdev,
 
 	end = pci_resource_len(vdev->pdev, vdev->msix_bar);
 
-	/* If MSI-X table is aligned to the start or end, only one area */
-	if (((vdev->msix_offset & PAGE_MASK) == 0) ||
+	/*
+	 * If MSI-X table is allowed to mmap because of the capability
+	 * of IRQ remapping or aligned to the start or end, only one area
+	 */
+	if ((vdev->pdev->bus->bus_flags & PCI_BUS_FLAGS_MSI_REMAP) ||
+	    ((vdev->msix_offset & PAGE_MASK) == 0) ||
 	    (PAGE_ALIGN(vdev->msix_offset + vdev->msix_size) >= end))
 		nr_areas = 1;
 
@@ -503,6 +507,12 @@ static int msix_sparse_mmap_cap(struct vfio_pci_device *vdev,
 			      struct vfio_region_info_cap_sparse_mmap, header);
 	sparse->nr_areas = nr_areas;
 
+	if (vdev->pdev->bus->bus_flags & PCI_BUS_FLAGS_MSI_REMAP) {
+		sparse->areas[i].offset = 0;
+		sparse->areas[i].size = end;
+		return 0;
+	}
+
 	if (vdev->msix_offset & PAGE_MASK) {
 		sparse->areas[i].offset = 0;
 		sparse->areas[i].size = vdev->msix_offset & PAGE_MASK;
@@ -1061,7 +1071,8 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
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

