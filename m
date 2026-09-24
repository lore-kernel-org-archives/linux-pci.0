Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1998949BD94;
	Thu, 24 Sep 2026 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263363; cv=none; b=shPXll435Z7gKCv2Gk4ecCyK47boEVBRM04BMvtoVwTrkFKQoXWnaoByfnq/qKdVZrHEAwP6BruPS47npoaNVOQzy7ZwxsXxtXM8INS0cW2oRhBwJg+k1p6jX4SocC7nAeUjaJZGc88Jp++pZ4p9feUZXfua2dJPbU4Rfp2hngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263363; c=relaxed/simple;
	bh=ti09iLjan1lub5PtRW9F5bme4llHh6c5Z6FxcwxWJnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVzviu0Ex4TgkQG0T5RSENLR++nbLyrghp6dEj+RAnZU+/xXIkfZCmU0DgujSYDvLn729vulEUzYjlZEgxEGg9U8VohJD24gUdGdNrWfLzV6IU4coK2dFnBpjMoKrGsxKYZPUQo9SxU7vMGovT9OVsJLDLVj/0eWHQKGob3iiX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=IfiWBZkI; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="IfiWBZkI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1790263329;
	bh=2hfLjPdxZvWAnglqWg5lr8oKc51YF6nnmzKD9ypXwJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IfiWBZkIzNTibp/oG87ianrXKSx7gqRugTD5e4EezKZ8nhj2KaP/dqU1gwon8++pH
	 ebkt41D5VXMGCYk+L9JQyVpUUYw5AVyh00gCPSAKdb7YJhHvXrfWfax+/R6sVBWXDL
	 DcR/oplQKADncGxRQw+wIxkAs7gxfEX74KD4+G1tWOhwuSIRKGRm2i5pztoAKswZd6
	 GN3GHZjzvzkanXUKWcp5Kfc7rSrsfDuro5JnMXAr9BYtVt2APWzy8s6duCWVUg4i7w
	 qoGMYNOXMgaNSXxUnmEgILv3CFyN54Ptgl79WtRyoF73CI7XmoYMKZ8/8l6+tpfwle
	 IMbKcQHpShe6w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hrHcw33kBz4w0Q;
	Fri, 25 Sep 2026 01:22:08 +1000 (AEST)
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
Subject: [PATCH v7 4/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
Date: Thu, 24 Sep 2026 16:21:47 +0100
Message-ID: <20260924152159.49702-5-matt@ozlabs.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260924152159.49702-1-matt@ozlabs.org>
References: <20260924152159.49702-1-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vfio_pci_dma_buf_find_pfn(), which a VMA fault handler can use to
find a PFN.

This supports multi-range DMABUFs, which typically would be used to
represent scattered spans but might even represent overlapping or
aliasing spans of PFNs.

Because this is intended to be used in vfio_pci_core.c, we also need
to expose the struct vfio_pci_dma_buf in the vfio_pci_priv.h header.

This move also adds a new member, vma_pgoff_adjust; this is consumed
by vfio_pci_dma_buf_find_pfn(), but will be set in a future commit.
Add it now to reduce the number of functions touched by later commits.

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 166 ++++++++++++++++++++++++++---
 drivers/vfio/pci/vfio_pci_priv.h   |  21 ++++
 2 files changed, 174 insertions(+), 13 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index 847ee5cc78e7..9f10b10fc436 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -9,19 +9,6 @@
 
 MODULE_IMPORT_NS("DMA_BUF");
 
-struct vfio_pci_dma_buf {
-	struct dma_buf *dmabuf;
-	struct vfio_pci_core_device *vdev;
-	struct list_head dmabufs_elm;
-	size_t size;
-	struct phys_vec *phys_vec;
-	struct p2pdma_provider *provider;
-	u32 nr_ranges;
-	struct kref kref;
-	struct completion comp;
-	u8 revoked : 1;
-};
-
 static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
 				   struct dma_buf_attachment *attachment)
 {
@@ -106,6 +93,159 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
 	.release = vfio_pci_dma_buf_release,
 };
 
+int vfio_pci_dma_buf_find_pfn(struct vfio_pci_core_device *vdev,
+			      struct vfio_pci_dma_buf *priv,
+			      struct vm_area_struct *vma,
+			      unsigned long fault_addr,
+			      unsigned int order,
+			      unsigned long *out_pfn)
+{
+	/*
+	 * Given a VMA (start, end, pgoffs) and a fault address,
+	 * search the corresponding DMABUF's phys_vec[] to find the
+	 * range representing the address's offset into the VMA, and
+	 * its PFN.  vdev must be the device that the DMABUF priv was
+	 * exported from; vdev->dmabuf_lock must be held, and priv
+	 * must not be revoked.
+	 *
+	 * The phys_vec[] ranges represent contiguous spans of VAs
+	 * upwards from the buffer offset 0; the actual PFNs might be
+	 * in any order, overlap/alias, etc.  Calculate an offset of
+	 * the desired page given VMA start/pgoff and address, then
+	 * search upwards from 0 to find which span contains it.
+	 *
+	 * On success, a valid PFN for a page sized by 'order' is
+	 * returned into out_pfn.
+	 *
+	 * Failure occurs if:
+	 * - A hugepage would cross the edge of the VMA,
+	 * - A hugepage isn't entirely contained within a range
+	 *   (including where it straddles the boundary between
+	 *   ranges),
+	 * - We find a range, but the final PFN isn't aligned to the
+	 *   requested order.
+	 *
+	 * Upon failure, -ERANGE is returned and the caller is
+	 * expected to try again with a smaller order, which will
+	 * eventually succeed.
+	 *
+	 * It's suboptimal if DMABUFs are created with neighbouring
+	 * ranges that are physically contiguous, since hugepages
+	 * can't straddle range boundaries.  (The construction of the
+	 * ranges should merge them in this case.)
+	 *
+	 * Finally, vma_pgoff_adjust is used with a DMABUF created for
+	 * a VFIO BAR mmap: a BAR mapped with vm_pgoff > 0 creates a
+	 * DMABUF such that byte 0 of the VMA corresponds to byte 0 of
+	 * the DMABUF and byte 'vm_pgoff << PAGE_SHIFT' into the BAR.
+	 * To avoid double-offsetting in this scenario, subtracting
+	 * vma_pgoff_adjust from this (non-zero) vm_pgoff generates
+	 * the effective offset.  This also removes the VFIO region
+	 * index encoded in vm_pgoff for VFIO BAR mmaps.
+	 */
+
+	const unsigned long pagesize = PAGE_SIZE << order;
+	unsigned long vma_off = (vma->vm_pgoff - priv->vma_pgoff_adjust) <<
+				 PAGE_SHIFT;
+	unsigned long rounded_page_addr = ALIGN_DOWN(fault_addr, pagesize);
+	unsigned long rounded_page_end = rounded_page_addr + pagesize;
+	unsigned long fault_offset;
+	unsigned long fault_offset_end;
+	unsigned long range_start_offset = 0;
+	unsigned int i;
+	int ret;
+
+	if (unlikely(!vdev))
+		return -ENODEV;
+
+	/* This prevents the dmabuf revocation state from changing under us */
+	lockdep_assert_held(&vdev->dmabuf_lock);
+
+	if (unlikely(priv->vdev != vdev || priv->revoked))
+		return -ENODEV;
+
+	if (rounded_page_addr < vma->vm_start || rounded_page_end > vma->vm_end) {
+		if (order > 0)
+			return -ERANGE;
+
+		/* A fault address outside of the VMA is absurd. */
+		dev_warn_ratelimited(
+			&vdev->pdev->dev,
+			"Fault addr 0x%lx outside VMA 0x%lx-0x%lx\n",
+			fault_addr, vma->vm_start, vma->vm_end);
+		return -EFAULT;
+	}
+
+	/*
+	 * fault_offset[_end] is the span within the DMABUF
+	 * corresponding to the faulting page:
+	 */
+	if (unlikely(check_add_overflow(rounded_page_addr - vma->vm_start,
+					vma_off, &fault_offset) ||
+		     check_add_overflow(fault_offset, pagesize,
+					&fault_offset_end)))
+		return -EFAULT;
+
+	/*
+	 * Iterate over ranges in the buffer, summing their lengths:
+	 * range_start_offset represents the current range's starting
+	 * offset in the buffer (from 0 upwards).
+	 *
+	 * A failure for order == 0 is unexpected, and triggers a
+	 * fault/warn.
+	 */
+	ret = (order == 0) ? -EFAULT : -ERANGE;
+
+	for (i = 0; i < priv->nr_ranges; i++) {
+		size_t range_len = priv->phys_vec[i].len;
+
+		/* Early exit if range starts after the page end */
+		if (fault_offset_end <= range_start_offset)
+			break;
+
+		if (fault_offset >= range_start_offset &&
+		    fault_offset_end <= range_start_offset + range_len) {
+			/*
+			 * The faulting page is wholly contained
+			 * within the span represented by this range,
+			 * so validate PFN alignment for the order.
+			 * The if() condition ensures the pfn
+			 * arithmetic won't overflow.
+			 */
+			unsigned long pfn =
+				((fault_offset - range_start_offset) +
+				 priv->phys_vec[i].paddr) >> PAGE_SHIFT;
+
+			if (IS_ALIGNED(pfn, 1 << order)) {
+				*out_pfn = pfn;
+				ret = 0;
+			}
+			/*
+			 * Else order > 0; ERANGE retries with smaller
+			 * order
+			 */
+			break;
+		}
+		range_start_offset += range_len;
+	}
+
+	if (order == 0 && ret != 0)
+		/*
+		 * The address fell outside of the span represented by
+		 * the (concatenated) ranges.  As setup of a mapping
+		 * ensures that the VMA is <= the total size of the
+		 * ranges this should never happen.  If it does, warn
+		 * and SIGBUS.
+		 */
+		dev_warn_ratelimited(
+			&vdev->pdev->dev,
+			"No range for addr 0x%lx, order %d: VMA 0x%lx-0x%lx pgoff 0x%lx, %u ranges, size 0x%zx\n",
+			fault_addr, order, vma->vm_start, vma->vm_end,
+			vma->vm_pgoff, priv->nr_ranges, priv->size);
+
+	return ret;
+}
+
 /*
  * This is a temporary "private interconnect" between VFIO DMABUF and iommufd.
  * It allows the two co-operating drivers to exchange the physical address of
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 4e7162234a2e..786df3a81d9d 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -23,6 +23,20 @@ struct vfio_pci_ioeventfd {
 	bool			test_mem;
 };
 
+struct vfio_pci_dma_buf {
+	struct dma_buf *dmabuf;
+	struct vfio_pci_core_device *vdev;
+	struct list_head dmabufs_elm;
+	size_t size;
+	struct phys_vec *phys_vec;
+	struct p2pdma_provider *provider;
+	u32 nr_ranges;
+	struct kref kref;
+	struct completion comp;
+	unsigned long vma_pgoff_adjust;
+	u8 revoked : 1;
+};
+
 bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev);
 void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev);
 
@@ -123,6 +137,13 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
 	return (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
 }
 
+int vfio_pci_dma_buf_find_pfn(struct vfio_pci_core_device *vdev,
+			      struct vfio_pci_dma_buf *priv,
+			      struct vm_area_struct *vma,
+			      unsigned long address,
+			      unsigned int order,
+			      unsigned long *out_pfn);
+
 #ifdef CONFIG_VFIO_PCI_DMABUF
 int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 				  struct vfio_device_feature_dma_buf __user *arg,
-- 
2.50.1 (Apple Git-155)

