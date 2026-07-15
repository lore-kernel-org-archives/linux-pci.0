Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8904BCAD1;
	Wed, 15 Jul 2026 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137699; cv=none; b=P/kokICHyBN9fbceZrpms0pyYi0ImsQjEc7BraigLLoZEijFVPHaU7eCmAL/i7kbOym6eKU3aF/VX8Aiohoa4yiBNm/UGTQD9weB87srJzU2cpm3K5loFBRGsbx+MPBe23yzoC0eS0duoW+LPX/pL9uE8hsbO9DAhSti2yH7hYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137699; c=relaxed/simple;
	bh=uwugQTICfAdrvl9pSqDFJrNxDq2FbB33G0kOz/aWmeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUKEpK1by6Fw1XY3oN65FGcmVen7NGhFQDYsl9wIr+mvkenqVl5mvstG5QFVNM21FewGbHkWYKZgYgTieH9feiaBoB2TZY8oDfWdMzcNeOzSO4afYh62P2btNv6Z7mcpTJN8SWb62zXRyLG29RrrJ31jy8vQLeJtEMJZq+kORwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=Lps9PLSk; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="Lps9PLSk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1784137695;
	bh=zLtgI9mUT3BSIn0bA1SVS3D4N4JhCvXWqIe3I68fvhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lps9PLSkF6JTUd1ZHuPgF2mvBQdOYsEHdUiLCwHq4Ot1v9k3Ls8OOhiGwESowDi3R
	 xbb7WIO39gIZwTVGx5nn57sHiVaccctllAtQJns8h1Zphh9zH+523QczmYi9tDc2yE
	 jFu7MbHsaxmOnW7hhmfa+2csPnKhw+A68SrSYmH7oEez+Mu5LXA3CI7vgO3DCG8h1p
	 2mNwWjbmMkvJEtl+oOkzFUvzImTAsoUbzmP4riCTiM9oq1jIrI4Bl7fV5oUTywS9ty
	 5NnL1d22RfWFTTR2lVzo/rrfBg49HkA4HgL7IifptGRwwaGgLNvgPWCqVxr4VPBjM7
	 kIhxNKKT3gfCA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4h0kDG6xkKz4wCC;
	Thu, 16 Jul 2026 03:48:14 +1000 (AEST)
From: Matt Evans <matt@ozlabs.org>
To: Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Mastro <amastro@fb.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pranjal Shrivastava <praan@google.com>,
	Longfang Liu <liulongfang@huawei.com>
Cc: Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 5/9] vfio/pci: Convert BAR mmap() to use a DMABUF
Date: Wed, 15 Jul 2026 18:47:28 +0100
Message-ID: <20260715174737.15287-6-matt@ozlabs.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260715174737.15287-1-matt@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the VFIO device fd fops->mmap to create a DMABUF representing
the BAR mapping, and make the VMA fault handler look up PFNs from the
corresponding DMABUF.  This supports future code mmap()ing BAR
DMABUFs, and iommufd work to support Type1 P2P.

First, vfio_pci_core_mmap() uses the new
vfio_pci_core_mmap_prep_dmabuf() helper to export a DMABUF
representing a single BAR range.  Then, the vfio_pci_mmap_huge_fault()
callback is updated to understand revoked buffers, and uses the new
vfio_pci_dma_buf_find_pfn() helper to determine the PFN for a given
fault address.

Now that the VFIO DMABUFs can be mmap()ed, vfio_pci_dma_buf_move()
zaps PTEs (used on the revocation and cleanup paths).

CONFIG_VFIO_PCI_CORE now unconditionally depends on
CONFIG_DMA_SHARED_BUFFER and CONFIG_PCI_P2PDMA_CORE.  The
CONFIG_VFIO_PCI_DMABUF feature conditionally includes support for
VFIO_DEVICE_FEATURE_DMA_BUF, depending on the availability of
CONFIG_PCI_P2PDMA.

Signed-off-by: Matt Evans <matt@ozlabs.org>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/vfio/pci/Kconfig           |  5 ++-
 drivers/vfio/pci/Makefile          |  3 +-
 drivers/vfio/pci/vfio_pci_core.c   | 67 ++++++++++++++++++------------
 drivers/vfio/pci/vfio_pci_dmabuf.c | 12 ++++++
 drivers/vfio/pci/vfio_pci_priv.h   | 11 +----
 5 files changed, 59 insertions(+), 39 deletions(-)

diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 296bf01e185e..67a2ae1fbc04 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -6,6 +6,8 @@ config VFIO_PCI_CORE
 	tristate
 	select VFIO_VIRQFD
 	select IRQ_BYPASS_MANAGER
+	select PCI_P2PDMA_CORE
+	select DMA_SHARED_BUFFER
 
 config VFIO_PCI_INTX
 	def_bool y if !S390
@@ -56,7 +58,8 @@ config VFIO_PCI_ZDEV_KVM
 	  To enable s390x KVM vfio-pci extensions, say Y.
 
 config VFIO_PCI_DMABUF
-	def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
+	def_bool y if PCI_P2PDMA
+	depends on VFIO_PCI_CORE
 
 source "drivers/vfio/pci/mlx5/Kconfig"
 
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 6138f1bf241d..881452ea89be 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -1,8 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
+vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o vfio_pci_dmabuf.o
 vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
-vfio-pci-core-$(CONFIG_VFIO_PCI_DMABUF) += vfio_pci_dmabuf.o
 obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
 
 vfio-pci-y := vfio_pci.o
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3f11a9624b9c..adce779c722c 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1739,18 +1739,6 @@ void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev, u16 c
 	up_write(&vdev->memory_lock);
 }
 
-static unsigned long vma_to_pfn(struct vm_area_struct *vma)
-{
-	struct vfio_pci_core_device *vdev = vma->vm_private_data;
-	int index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
-	u64 pgoff;
-
-	pgoff = vma->vm_pgoff &
-		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
-
-	return (pci_resource_start(vdev->pdev, index) >> PAGE_SHIFT) + pgoff;
-}
-
 vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
 				   struct vm_fault *vmf,
 				   unsigned long pfn,
@@ -1778,23 +1766,42 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 					   unsigned int order)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct vfio_pci_core_device *vdev = vma->vm_private_data;
-	unsigned long addr = vmf->address & ~((PAGE_SIZE << order) - 1);
-	unsigned long pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
-	unsigned long pfn = vma_to_pfn(vma) + pgoff;
-	vm_fault_t ret = VM_FAULT_FALLBACK;
-
-	if (is_aligned_for_order(vma, addr, pfn, order)) {
-		scoped_guard(rwsem_read, &vdev->memory_lock)
-			ret = vfio_pci_vmf_insert_pfn(vdev, vmf, pfn, order);
+	struct vfio_pci_dma_buf *priv = vma->vm_private_data;
+	struct vfio_pci_core_device *vdev;
+	unsigned long pfn = 0;
+	vm_fault_t ret = VM_FAULT_SIGBUS;
+
+	/*
+	 * We can rely on the existence of both a DMABUF (priv) and
+	 * the VFIO device it was exported from (vdev).  This fault's
+	 * VMA was established using vfio_pci_core_mmap_prep_dmabuf()
+	 * which transfers ownership of the VFIO device fd to the
+	 * DMABUF, and so the VFIO device is held open because the
+	 * VMA's vm_file (DMABUF) is open.
+	 *
+	 * Since vfio_pci_dma_buf_cleanup() cannot have happened,
+	 * vdev must be valid; we can take memory_lock.
+	 */
+	vdev = priv->vdev;
+
+	scoped_guard(rwsem_read, &vdev->memory_lock) {
+		if (!priv->revoked) {
+			int pres = vfio_pci_dma_buf_find_pfn(priv, vma,
+							     vmf->address,
+							     order, &pfn);
+
+			if (pres == 0)
+				ret = vfio_pci_vmf_insert_pfn(vdev, vmf,
+							      pfn, order);
+			else if (pres == -EAGAIN)
+				ret = VM_FAULT_FALLBACK;
+		}
 	}
 
 	dev_dbg_ratelimited(&vdev->pdev->dev,
-			   "%s(,order = %d) BAR %ld page offset 0x%lx: 0x%x\n",
-			    __func__, order,
-			    vma->vm_pgoff >>
-				(VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT),
-			    pgoff, (unsigned int)ret);
+			    "%s(order = %d) PFN 0x%lx, VA 0x%lx, pgoff 0x%lx: 0x%x\n",
+			    __func__, order, pfn, vmf->address,
+			    vma->vm_pgoff, (unsigned int)ret);
 
 	return ret;
 }
@@ -1819,6 +1826,7 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 	unsigned int index;
 	u64 phys_len, req_len, pgoff, req_start;
 	void __iomem *bar_io;
+	int ret;
 
 	index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
 
@@ -1858,7 +1866,12 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 	if (IS_ERR(bar_io))
 		return PTR_ERR(bar_io);
 
-	vma->vm_private_data = vdev;
+	ret = vfio_pci_core_mmap_prep_dmabuf(vdev, vma,
+					     pci_resource_start(pdev, index),
+					     req_len, index);
+	if (ret)
+		return ret;
+
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
 
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index 74c02794bfe2..46b3cf5dc94b 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -9,6 +9,7 @@
 
 MODULE_IMPORT_NS("DMA_BUF");
 
+#ifdef CONFIG_VFIO_PCI_DMABUF
 static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
 				   struct dma_buf_attachment *attachment)
 {
@@ -25,6 +26,7 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
 
 	return 0;
 }
+#endif /* CONFIG_VFIO_PCI_DMABUF */
 
 static void vfio_pci_dma_buf_done(struct kref *kref)
 {
@@ -89,7 +91,9 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
 }
 
 static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
+#ifdef CONFIG_VFIO_PCI_DMABUF
 	.attach = vfio_pci_dma_buf_attach,
+#endif
 	.map_dma_buf = vfio_pci_dma_buf_map,
 	.unmap_dma_buf = vfio_pci_dma_buf_unmap,
 	.release = vfio_pci_dma_buf_release,
@@ -274,6 +278,7 @@ static int vfio_pci_dmabuf_export(struct vfio_pci_core_device *vdev,
 	return 0;
 }
 
+#ifdef CONFIG_VFIO_PCI_DMABUF
 /*
  * This is a temporary "private interconnect" between VFIO DMABUF and iommufd.
  * It allows the two co-operating drivers to exchange the physical address of
@@ -472,6 +477,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	kfree(dma_ranges);
 	return ret;
 }
+#endif /* CONFIG_VFIO_PCI_DMABUF */
 
 int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
 				   struct vm_area_struct *vma,
@@ -547,6 +553,10 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
 	struct vfio_pci_dma_buf *priv;
 	struct vfio_pci_dma_buf *tmp;
 
+	/*
+	 * Holding memory_lock ensures a racing VMA fault observes
+	 * priv->revoked properly.
+	 */
 	lockdep_assert_held_write(&vdev->memory_lock);
 
 	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
@@ -565,6 +575,8 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
 			if (revoked) {
 				kref_put(&priv->kref, vfio_pci_dma_buf_done);
 				wait_for_completion(&priv->comp);
+				unmap_mapping_range(priv->dmabuf->file->f_mapping,
+						    0, 0, true);
 				/*
 				 * Re-arm the registered kref reference and the
 				 * completion so the post-revoke state matches the
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 06dc0fd3e230..d38e1b98b2e9 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -138,13 +138,13 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
 				   struct vm_area_struct *vma,
 				   u64 phys_start, u64 req_len,
 				   unsigned int res_index);
+void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev);
+void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked);
 
 #ifdef CONFIG_VFIO_PCI_DMABUF
 int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 				  struct vfio_device_feature_dma_buf __user *arg,
 				  size_t argsz);
-void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev);
-void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked);
 #else
 static inline int
 vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
@@ -153,13 +153,6 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 {
 	return -ENOTTY;
 }
-static inline void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
-{
-}
-static inline void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev,
-					 bool revoked)
-{
-}
 #endif
 
 #endif
-- 
2.50.1 (Apple Git-155)

