Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	joro@8bytes.org, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	eric.auger@linaro.org, will.deacon@arm.com,
	gwshan@linux.vnet.ibm.com, alistair@popple.id.au,
	ruscur@russell.cc, Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC v6 10/10] vfio-pci: Allow to mmap MSI-X table if interrupt remapping is supported
Date: Mon, 18 Apr 2016 19:04:03 +0800
Message-Id: <1460977443-29405-3-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1460977443-29405-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1460977443-29405-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
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
index dc1779c..b08abe0 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -635,7 +635,9 @@ static long vfio_pci_ioctl(void *device_data,
 				     VFIO_REGION_INFO_FLAG_WRITE;
 			if (vdev->bar_mmap_supported[info.index]) {
 				info.flags |= VFIO_REGION_INFO_FLAG_MMAP;
-				if (info.index == vdev->msix_bar) {
+				if (info.index == vdev->msix_bar &&
+					!(pdev->bus->bus_flags &
+					PCI_BUS_FLAGS_MSI_REMAP)) {
 					ret = msix_sparse_mmap_cap(vdev, &caps);
 					if (ret)
 						return ret;
@@ -1067,7 +1069,8 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 	if (req_start + req_len > phys_len)
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
