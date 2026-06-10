Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF8E42B750;
	Wed, 10 Jun 2026 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106264; cv=none; b=YkJj8fvcnOp4jSIi0gE4QGzq7m7IqQJoCTGT6ufQKP0aYFkA3VTHBPYKH2Y4tAz9glOwmN1Dsk+0b9/EiE8r6M9pGJHLries97/e9BFgfYuGAUScnNQufv9G0D+V2Ofpokj0zfu6/6skZdtCmBynkb57JQrXfgeKhI56JS/5ZE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106264; c=relaxed/simple;
	bh=vvHwUM969pxhlv8p892fwH2hHbmokwsZALZtN4J64uU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIAnDDRGTxaTFlZnBEJEd7ts1RCaiI/35Qvjr4vwBMLF6zb9nAUahG8GVGZL/hgsKC0Bm5Qd2ZdL9miRBTn4//ea+J3n4gUbEZvE36UazMEhRDTI6rq6GOxnOF1aoD9M7w7gPqtIILpH/wnljQxQPuCACnVfIpYr7F6h42KEUwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=c7/gL6/8; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="c7/gL6/8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1781106260;
	bh=w/QAqKguf1tBu4JVWM0U3HzW91S/9/oIXFw2nXYa4AQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c7/gL6/87xKEVcXHWFSgW0fCjjZAWBsU2vsMec1Vz+XdxeBWipVAY/Cw/bSf5CFQU
	 dkMoxxIUT7TNEoz/fP8d6nfbqPYFA3tNmKDzK94faccw8lE+4msv3LcXHmFDJQnkOA
	 FK/fxOsHNRZzUXP+UG6zuNjM73Gf/J0P5RqDW5r3SzbVGEnDvLmbZNqUo99CtOH5tR
	 RnGgunIBpRBMuJ8OM0xgqqaZH/yYzTpgCbpfetH/H5cYvyEbojGbLUnD/rKAfQluWb
	 yH0Oj4j0AzTBRv0H1nrWjohC4Kaa9zjajDJdfSD4X3qE6Q1LPbxo1u8BNmBUVRpD67
	 aiV0rWHGPQShg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4gb97R2TZXz4wST;
	Thu, 11 Jun 2026 01:44:19 +1000 (AEST)
From: Matt Evans <matt@ozlabs.org>
To: Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Mastro <amastro@fb.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>
Cc: Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 2/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
Date: Wed, 10 Jun 2026 16:43:16 +0100
Message-ID: <20260610154327.37758-3-matt@ozlabs.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260610154327.37758-1-matt@ozlabs.org>
References: <20260610154327.37758-1-matt@ozlabs.org>
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

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 137 ++++++++++++++++++++++++++---
 drivers/vfio/pci/vfio_pci_priv.h   |  20 +++++
 2 files changed, 144 insertions(+), 13 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index c16f460c01d6..9e5e865f6fb6 100644
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
@@ -106,6 +93,130 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
 	.release = vfio_pci_dma_buf_release,
 };
 
+int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *priv,
+			      struct vm_area_struct *vma,
+			      unsigned long address,
+			      unsigned int order,
+			      unsigned long *out_pfn)
+{
+	/*
+	 * Given a VMA (start, end, pgoffs) and a fault address,
+	 * search the corresponding DMABUF's phys_vec[] to find the
+	 * range representing the address's offset into the VMA, and
+	 * its PFN.
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
+	 * - The page would cross the edge of the VMA
+	 * - The page isn't entirely contained within a range
+	 * - We find a range, but the final PFN isn't aligned to the
+	 *   requested order.
+	 *
+	 * (Upon failure, the caller is expected to try again with a
+	 * smaller order; the tests above will always succeed for
+	 * order=0 as the limit case.)
+	 *
+	 * It's suboptimal if DMABUFs are created with neigbouring
+	 * ranges that are physically contiguous, since hugepages
+	 * can't straddle range boundaries.  (The construction of the
+	 * ranges vector should merge such ranges.)
+	 *
+	 * Finally, vma_pgoff_adjust is used for a DMABUF representing
+	 * a VFIO BAR mmap, which is created from the start of the
+	 * offset region.
+	 */
+
+	const unsigned long pagesize = PAGE_SIZE << order;
+	unsigned long vma_off = ((vma->vm_pgoff - priv->vma_pgoff_adjust) <<
+				 PAGE_SHIFT) & VFIO_PCI_OFFSET_MASK;
+	unsigned long rounded_page_addr = ALIGN_DOWN(address, pagesize);
+	unsigned long rounded_page_end = rounded_page_addr + pagesize;
+	unsigned long page_buf_offset;
+	unsigned long page_buf_offset_end;
+	unsigned long range_buf_offset = 0;
+	unsigned int i;
+
+	if (rounded_page_addr < vma->vm_start || rounded_page_end > vma->vm_end) {
+		if (order > 0)
+			return -EAGAIN;
+
+		/* A fault address outside of the VMA is absurd. */
+		WARN(1, "Fault addr 0x%lx outside VMA 0x%lx-0x%lx\n",
+		     address, vma->vm_start, vma->vm_end);
+		return -EFAULT;
+	}
+
+	/*
+	 * page_buff_offset[_end] is the span of DMABUF offsets
+	 * corresponding to the faulting page:
+	 */
+	if (unlikely(check_add_overflow(rounded_page_addr - vma->vm_start,
+					vma_off, &page_buf_offset) ||
+		     check_add_overflow(page_buf_offset, pagesize,
+					&page_buf_offset_end)))
+		return -EFAULT;
+
+	for (i = 0; i < priv->nr_ranges; i++) {
+		size_t range_len = priv->phys_vec[i].len;
+		phys_addr_t range_start = priv->phys_vec[i].paddr;
+
+		/*
+		 * If the current range starts after the page's span,
+		 * this and any future range won't match.  Bail early.
+		 */
+		if (page_buf_offset_end <= range_buf_offset)
+			break;
+
+		if (page_buf_offset >= range_buf_offset &&
+		    page_buf_offset_end <= range_buf_offset + range_len) {
+			/*
+			 * The faulting page is wholly contained
+			 * within the span represented by the range.
+			 * Validate PFN alignment for the order:
+			 */
+			unsigned long pfn = (range_start + page_buf_offset -
+					     range_buf_offset) / PAGE_SIZE;
+
+			if (IS_ALIGNED(pfn, 1 << order)) {
+				*out_pfn = pfn;
+				return 0;
+			}
+			/* Retry with smaller order */
+			return -EAGAIN;
+		}
+		range_buf_offset += range_len;
+	}
+
+	/*
+	 * A hugepage straddling a range boundary will fail to match a
+	 * range, but the address will (eventually) match when retried
+	 * with a smaller page.
+	 */
+	if (order > 0)
+		return -EAGAIN;
+
+	/*
+	 * If we get here, the address fell outside of the span
+	 * represented by the (concatenated) ranges.  Setup of a
+	 * mapping must ensure that the VMA is <= the total size of
+	 * the ranges, so this should never happen.  But, if it does,
+	 * force SIGBUS for the access and warn.
+	 */
+	WARN_ONCE(1, "No range for addr 0x%lx, order %d: VMA 0x%lx-0x%lx pgoff 0x%lx, %u ranges, size 0x%zx\n",
+		  address, order, vma->vm_start, vma->vm_end, vma->vm_pgoff,
+		  priv->nr_ranges, priv->size);
+
+	return -EFAULT;
+}
+
 /*
  * This is a temporary "private interconnect" between VFIO DMABUF and iommufd.
  * It allows the two co-operating drivers to exchange the physical address of
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index fca9d0dfac90..c8f6f959056a 100644
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
 
@@ -114,6 +128,12 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
 	return (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
 }
 
+int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *vpdmabuf,
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

