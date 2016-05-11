Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
	nikunj@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com,
	kevin.tian@intel.com, Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [PATCH v2] vfio-pci: Allow to mmap sub-page MMIO BARs if the mmio page is exclusive
Date: Wed, 11 May 2016 19:34:19 +0800
Message-Id: <1462966459-12459-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current vfio-pci implementation disallows to mmap
sub-page(size < PAGE_SIZE) MMIO BARs because these BARs' mmio
page may be shared with other BARs. This will cause some
performance issues when we passthrough a PCI device with
this kind of BARs. Guest will be not able to handle the mmio
accesses to the BARs which leads to mmio emulations in host.

However, not all sub-page BARs will share page with other BARs.
We should allow to mmap the sub-page MMIO BARs which we can
make sure will not share page with other BARs.

This patch adds support for this case. And we try to add some
dummy resources to reserve the remaind of the page which
hot-add device's BAR might be assigned into.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/vfio/pci/vfio_pci.c         |   85 ++++++++++++++++++++++++++++++++---
 drivers/vfio/pci/vfio_pci_private.h |    8 ++++
 2 files changed, 86 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 98059df..33282b8 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -110,16 +110,77 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
 	return (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
 }
 
+static bool vfio_pci_bar_mmap_supported(struct vfio_pci_device *vdev, int index)
+{
+	struct resource *res = vdev->pdev->resource + index;
+	struct vfio_pci_dummy_resource *dummy_res1 = NULL;
+	struct vfio_pci_dummy_resource *dummy_res2 = NULL;
+
+	if (IS_ENABLED(CONFIG_VFIO_PCI_MMAP) && res->flags & IORESOURCE_MEM &&
+		resource_size(res) > 0) {
+		if (resource_size(res) >= PAGE_SIZE)
+			return true;
+
+		if ((res->start & ~PAGE_MASK)) {
+			/*
+			 * Add a dummy resource to reserve the portion
+			 * before res->start in exclusive page in case
+			 * that hot-add device's bar is assigned into it.
+			 */
+			dummy_res1 = kzalloc(sizeof(*dummy_res1), GFP_KERNEL);
+			dummy_res1->resource.start = res->start & PAGE_MASK;
+			dummy_res1->resource.end = res->start - 1;
+			dummy_res1->resource.flags = res->flags;
+			if (request_resource(res->parent,
+						&dummy_res1->resource)) {
+				kfree(dummy_res1);
+				return false;
+			}
+			dummy_res1->index = index;
+			list_add(&dummy_res1->res_next,
+					&vdev->dummy_resources_list);
+		}
+		if (((res->end + 1) & ~PAGE_MASK)) {
+			/*
+			 * Add a dummy resource to reserve the portion
+			 * after res->end.
+			 */
+			dummy_res2 = kzalloc(sizeof(*dummy_res2), GFP_KERNEL);
+			dummy_res2->resource.start = res->end + 1;
+			dummy_res2->resource.end = (res->start & PAGE_MASK) +
+							PAGE_SIZE - 1;
+			dummy_res2->resource.flags = res->flags;
+			if (request_resource(res->parent,
+						&dummy_res2->resource)) {
+				if (dummy_res1) {
+					list_del(&dummy_res1->res_next);
+					release_resource(&dummy_res1->resource);
+					kfree(dummy_res1);
+				}
+				kfree(dummy_res2);
+				return false;
+			}
+			dummy_res2->index = index;
+			list_add(&dummy_res2->res_next,
+					&vdev->dummy_resources_list);
+		}
+		return true;
+	}
+	return false;
+}
+
 static void vfio_pci_try_bus_reset(struct vfio_pci_device *vdev);
 static void vfio_pci_disable(struct vfio_pci_device *vdev);
 
 static int vfio_pci_enable(struct vfio_pci_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
-	int ret;
+	int ret, bar;
 	u16 cmd;
 	u8 msix_pos;
 
+	INIT_LIST_HEAD(&vdev->dummy_resources_list);
+
 	pci_set_power_state(pdev, PCI_D0);
 
 	/* Don't allow our initial saved state to include busmaster */
@@ -183,12 +244,17 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
 		}
 	}
 
+	for (bar = PCI_STD_RESOURCES; bar <= PCI_STD_RESOURCE_END; bar++) {
+		vdev->bar_mmap_supported[bar] =
+				vfio_pci_bar_mmap_supported(vdev, bar);
+	}
 	return 0;
 }
 
 static void vfio_pci_disable(struct vfio_pci_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
+	struct vfio_pci_dummy_resource *dummy_res, *tmp;
 	int i, bar;
 
 	/* Stop the device from further DMA */
@@ -217,6 +283,13 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
 		vdev->barmap[bar] = NULL;
 	}
 
+	list_for_each_entry_safe(dummy_res, tmp,
+				 &vdev->dummy_resources_list, res_next) {
+		list_del(&dummy_res->res_next);
+		release_resource(&dummy_res->resource);
+		kfree(dummy_res);
+	}
+
 	vdev->needs_reset = true;
 
 	/*
@@ -587,9 +660,7 @@ static long vfio_pci_ioctl(void *device_data,
 
 			info.flags = VFIO_REGION_INFO_FLAG_READ |
 				     VFIO_REGION_INFO_FLAG_WRITE;
-			if (IS_ENABLED(CONFIG_VFIO_PCI_MMAP) &&
-			    pci_resource_flags(pdev, info.index) &
-			    IORESOURCE_MEM && info.size >= PAGE_SIZE) {
+			if (vdev->bar_mmap_supported[info.index]) {
 				info.flags |= VFIO_REGION_INFO_FLAG_MMAP;
 				if (info.index == vdev->msix_bar) {
 					ret = msix_sparse_mmap_cap(vdev, &caps);
@@ -1011,16 +1082,16 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 		return -EINVAL;
 	if (index >= VFIO_PCI_ROM_REGION_INDEX)
 		return -EINVAL;
-	if (!(pci_resource_flags(pdev, index) & IORESOURCE_MEM))
+	if (!vdev->bar_mmap_supported[index])
 		return -EINVAL;
 
-	phys_len = pci_resource_len(pdev, index);
+	phys_len = PAGE_ALIGN(pci_resource_len(pdev, index));
 	req_len = vma->vm_end - vma->vm_start;
 	pgoff = vma->vm_pgoff &
 		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
 	req_start = pgoff << PAGE_SHIFT;
 
-	if (phys_len < PAGE_SIZE || req_start + req_len > phys_len)
+	if (req_start + req_len > phys_len)
 		return -EINVAL;
 
 	if (index == vdev->msix_bar) {
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index 8a7d546..a4233a8 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -57,9 +57,16 @@ struct vfio_pci_region {
 	u32				flags;
 };
 
+struct vfio_pci_dummy_resource {
+	struct resource		resource;
+	int			index;
+	struct list_head	res_next;
+};
+
 struct vfio_pci_device {
 	struct pci_dev		*pdev;
 	void __iomem		*barmap[PCI_STD_RESOURCE_END + 1];
+	bool			bar_mmap_supported[PCI_STD_RESOURCE_END + 1];
 	u8			*pci_config_map;
 	u8			*vconfig;
 	struct perm_bits	*msi_perm;
@@ -87,6 +94,7 @@ struct vfio_pci_device {
 	int			refcnt;
 	struct eventfd_ctx	*err_trigger;
 	struct eventfd_ctx	*req_trigger;
+	struct list_head	dummy_resources_list;
 };
 
 #define is_intx(vdev) (vdev->irq_type == VFIO_PCI_INTX_IRQ_INDEX)
-- 
1.7.9.5
