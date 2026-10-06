Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4377946E007;
	Tue,  6 Oct 2026 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791315444; cv=none; b=NxtpxGIQ3GElkVyWgKtesQDsfYqMTFgXHU+yGVaCfxZMJqWfvdwLLgMZ89bNVegpDgaSgomeGKrfqA4SEZnI2uHQLwPckdzAS4j8X5n7jFvISaT21m6qdCWJ0gGiyGskCoLd+d1L6BSbLUzPcEQC0Xh8s0txxS9FTArgu33I0Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791315444; c=relaxed/simple;
	bh=Z1MVgq9C9XW6AXUyf9BybtUtFrR/2YoPP5GW6Yeyp/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjE4rILl0jc0B1C71e69Pgrlb8qCCq2jG41EHrYok3bmTKl7+ln7OR8lG+3p7RUVIDX2imL7zLx33gwK56dLUzyN+Gu92uyCPftDIn2XcWIr9Ae14b7rONl/oq2A4B3yGUM2biLkMWpdpBY/50JdWsiTIaejyjPflR4tnytzxOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=PWZ5mFtm; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="PWZ5mFtm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1791315440;
	bh=MUwKY6iy3UnhLX1Nmr6Wc5KrMMCK3nIKh1+Lu5UWdvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PWZ5mFtmKZUVbpgqMuHQkadTSfzyZ80U4DgfVtEt5JaJ1RJV11haM7EfcN70rsK2T
	 pmfdlW3rZJaZhT9PPtsTF+hjfGIlFuwn/9qa3S6zPJ7leBq74ZJLV7iLpoGNMwc1LL
	 nEcwyJ43SSW06im/wyemoBS7itPpbN+dKqQcv6JN1AyNxFW04zm7vR40Z1S7mXxnvb
	 eqwFv+zyBoq6WJ+F4gvZei1SEXcsj8lUbu7I1mdpvfz9pH1ejSxsL+jxa7GHsGA84o
	 snaSFH98tbJP8SAnu9eDQ9cq9S1iyy8YJyOL2Y4xs2OCNYyXckDXVvxtDGobIIWv9a
	 oLBuuPA1R6Gsw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hzmjq5tCpz4wJQ;
	Wed, 07 Oct 2026 06:37:19 +1100 (AEDT)
From: Matt Evans <matt@ozlabs.org>
To: Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Mastro <amastro@fb.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
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
Subject: [PATCH v8 6/9] vfio/pci: Convert BAR mmap() to use a DMABUF
Date: Tue,  6 Oct 2026 20:36:34 +0100
Message-ID: <20261006193643.76330-7-matt@ozlabs.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261006193643.76330-1-matt@ozlabs.org>
References: <20261006193643.76330-1-matt@ozlabs.org>
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

CONFIG_VFIO_PCI_CORE now unconditionally selects
CONFIG_DMA_SHARED_BUFFER.  The CONFIG_VFIO_PCI_DMABUF feature
conditionally includes support for VFIO_DEVICE_FEATURE_DMA_BUF,
depending on the availability of CONFIG_PCI_P2PDMA.

When the DMABUF feature is not present, DMABUFs are used internally
for the BAR mappings.  In this case, DMABUF attach is prohibited (and
the requirement for a P2PDMA provider is relaxed).

Signed-off-by: Matt Evans <matt@ozlabs.org>
Tested-by: Alex Mastro <amastro@fb.com>
Reviewed-by: Alex Mastro <amastro@fb.com>
---
 drivers/vfio/pci/Kconfig           |  4 +-
 drivers/vfio/pci/Makefile          |  3 +-
 drivers/vfio/pci/vfio_pci_core.c   | 71 ++++++++++++++++++------------
 drivers/vfio/pci/vfio_pci_dmabuf.c | 24 +++++++++-
 drivers/vfio/pci/vfio_pci_priv.h   | 11 +----
 5 files changed, 73 insertions(+), 40 deletions(-)

diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 296bf01e185e..c6d6fb09af86 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -6,6 +6,7 @@ config VFIO_PCI_CORE
 	tristate
 	select VFIO_VIRQFD
 	select IRQ_BYPASS_MANAGER
+	select DMA_SHARED_BUFFER
 
 config VFIO_PCI_INTX
 	def_bool y if !S390
@@ -56,7 +57,8 @@ config VFIO_PCI_ZDEV_KVM
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
index e170cdc7ac92..cb0e4865d110 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1748,18 +1748,6 @@ void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev, u16 c
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
@@ -1787,23 +1775,46 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 					   unsigned int order)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct vfio_pci_core_device *vdev = vma->vm_private_data;
-	unsigned long addr = vmf->address & ~((PAGE_SIZE << order) - 1);
-	unsigned long pgoff = linear_page_delta(vma, addr);
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
+	 * vdev must be valid; we can take vdev locks.
+	 */
+	vdev = priv->vdev;
+
+	/* memory_lock for vfio_pci_vmf_insert_pfn() */
+	down_read(&vdev->memory_lock);
+	/* Test revocation status under dmabuf_lock */
+	down_read(&vdev->dmabuf_lock);
+	if (!priv->revoked) {
+		int pres = vfio_pci_dma_buf_find_pfn(vdev, priv, vma,
+						     vmf->address,
+						     order, &pfn);
+
+		if (pres == 0)
+			ret = vfio_pci_vmf_insert_pfn(vdev, vmf,
+						      pfn, order);
+		else if (pres == -ERANGE)
+			ret = VM_FAULT_FALLBACK;
 	}
+	up_read(&vdev->dmabuf_lock);
+	up_read(&vdev->memory_lock);
 
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
@@ -1828,6 +1839,7 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 	unsigned int index;
 	u64 phys_len, req_len, pgoff, req_start;
 	void __iomem *bar_io;
+	int ret;
 
 	index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
 
@@ -1867,7 +1879,12 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
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
index fd3ee2f5c5e8..617afb7de00f 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -10,6 +10,7 @@
 
 MODULE_IMPORT_NS("DMA_BUF");
 
+#ifdef CONFIG_VFIO_PCI_DMABUF
 static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
 				   struct dma_buf_attachment *attachment)
 {
@@ -26,6 +27,18 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
 
 	return 0;
 }
+#else
+static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
+				   struct dma_buf_attachment *attachment)
+{
+	/*
+	 * Explicit export can't occur without the DMABUF feature, but
+	 * DMABUFs are implicitly created for BAR mappings.  An
+	 * .attach that fails prevents dma_buf_attach().
+	 */
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_VFIO_PCI_DMABUF */
 
 static void vfio_pci_dma_buf_done(struct kref *kref)
 {
@@ -364,8 +377,13 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
 	priv->nr_ranges = 1;
 	priv->vma_pgoff_adjust = vma->vm_pgoff;
 
+	/*
+	 * The provider can be NULL _iff_ the DMABUF feature isn't
+	 * supported, because it's only used by DMABUF import and
+	 * attach is prohibited if the feature isn't present.
+	 */
 	priv->provider = pcim_p2pdma_provider(vdev->pdev, res_index);
-	if (!priv->provider) {
+	if (IS_ENABLED(CONFIG_VFIO_PCI_DMABUF) && !priv->provider) {
 		ret = -EINVAL;
 		goto err_free_name;
 	}
@@ -408,6 +426,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
 	return ret;
 }
 
+#ifdef CONFIG_VFIO_PCI_DMABUF
 /*
  * This is a temporary "private interconnect" between VFIO DMABUF and iommufd.
  * It allows the two co-operating drivers to exchange the physical address of
@@ -606,6 +625,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	kfree(dma_ranges);
 	return ret;
 }
+#endif /* CONFIG_VFIO_PCI_DMABUF */
 
 void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
 {
@@ -632,6 +652,8 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
 			if (revoked) {
 				kref_put(&priv->kref, vfio_pci_dma_buf_done);
 				wait_for_completion(&priv->comp);
+				unmap_mapping_range(priv->dmabuf->file->f_mapping,
+						    0, 0, true);
 				/*
 				 * Re-arm the registered kref reference and the
 				 * completion so the post-revoke state matches the
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 66a5ae19082d..ef6aabb9f5a4 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -148,13 +148,13 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
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
@@ -163,13 +163,6 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
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
2.47.3

