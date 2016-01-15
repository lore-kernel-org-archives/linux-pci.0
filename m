Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([125.16.236.3]:44238 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889AbcAOHIE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jan 2016 02:08:04 -0500
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Fri, 15 Jan 2016 12:38:01 +0530
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, corbet@lwn.net, aik@ozlabs.ru,
	alex.williamson@redhat.com, benh@kernel.crashing.org,
	paulus@samba.org, mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 2/5] vfio-pci: Allow to mmap sub-page MMIO BARs if the mmio page is exclusive
Date: Fri, 15 Jan 2016 15:06:11 +0800
Message-Id: <1452841574-2781-3-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1452841574-2781-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1452841574-2781-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current vfio-pci implementation disallows to mmap
sub-page(size < PAGE_SIZE) MMIO BARs because these BARs' mmio
page may be shared with other BARs.

But we should allow to mmap these sub-page MMIO BARs if PCI
resource allocator can make sure these BARs' mmio page will
not be shared with other BARs.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/vfio/pci/vfio_pci.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 7e9f497..11fd0f0 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -552,7 +552,8 @@ static long vfio_pci_ioctl(void *device_data,
 				     VFIO_REGION_INFO_FLAG_WRITE;
 			if (IS_ENABLED(CONFIG_VFIO_PCI_MMAP) &&
 			    pci_resource_flags(pdev, info.index) &
-			    IORESOURCE_MEM && info.size >= PAGE_SIZE) {
+			    IORESOURCE_MEM && !pci_resources_share_page(pdev,
+			    info.index)) {
 				info.flags |= VFIO_REGION_INFO_FLAG_MMAP;
 				if (info.index == vdev->msix_bar) {
 					ret = msix_sparse_mmap_cap(vdev, &caps);
@@ -954,6 +955,10 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 		return -EINVAL;
 
 	phys_len = pci_resource_len(pdev, index);
+
+	if (!pci_resources_share_page(pdev, index))
+		phys_len = PAGE_ALIGN(phys_len);
+
 	req_len = vma->vm_end - vma->vm_start;
 	pgoff = vma->vm_pgoff &
 		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
-- 
1.7.9.5

