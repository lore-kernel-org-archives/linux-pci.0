Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA851F192E;
	Tue,  6 Oct 2026 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791315443; cv=none; b=M6+cbL7rR+/N+ZXZMPa81c3kGbNX9PnEphpoMzSR4dyMEt3gyrD4p4FPH4BhipElsc9/PnpGPnGvoRenBC3SRrv198D5QbZQRI/ODg97RPn1yT8OZLS+IVgXMRpIoehzmj3ZE5w8J+sOtMkBbR0oX2Z5zpoONI7tBn8hMXUJjZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791315443; c=relaxed/simple;
	bh=Y8sjx8r9BWUSPR+4f0RBbd9DHPU/IMo+KYWhZk0+DwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTsxyd/3Vu5XGWf5wtrfYMehvUcHNKQz9EdiK4hceo/o/vNcnI3ZV4vI/yvTeFqWLjVHptlMlLj/6CzcPlhjbLEm0qd5a3Qwp9CQiyh7VBTWOCTu/Hdbm5IhghzBP6tlEJed4smyv8QLEJ40TnW2oqvOYFGmM8eaLu32eH5zClw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=rGHfAbz8; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="rGHfAbz8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1791315436;
	bh=7uUGcNmN/KD5RKDPXTOjP0ez1RlhX94GpUbG1fYp7uM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rGHfAbz89Cxsd7OUvQ3yGhs1twZTOssBLte9cFYx+rNb2hU/TOoGHRqlOWwZarR0P
	 1w20Q95l0lPeiwCqfyuXzOGL26h1dLkyjhyBNT15CUAMge/Y4EKd6pbQ/47+hlGNyD
	 dLupICjkhDMM+3zZCa/y0tM9gcysnMOFzPYSEBrC1oo40UHDrfJ+u6Qcyc6WM3xJ0H
	 rjjqQVAYQdnwAten8K8XS4R2IONSr7elzFqXCV95ntuZe4FP7TaPTxTrK9rU0TWWVi
	 WstUsjzHE1J2fPr5kJk2SqITiagE85uentu2io090UfsetiTOtAG6qvrztvcOHpx9i
	 Yvswt+gMC37uQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hzmjl3DFYz4wB7;
	Wed, 07 Oct 2026 06:37:15 +1100 (AEDT)
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
Subject: [PATCH v8 5/9] vfio/pci: Add a helper to create a DMABUF for a BAR-map VMA
Date: Tue,  6 Oct 2026 20:36:33 +0100
Message-ID: <20261006193643.76330-6-matt@ozlabs.org>
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

This helper, vfio_pci_core_mmap_prep_dmabuf(), creates a single-range
DMABUF for the purpose of mapping a PCI BAR.  This is used in a future
commit by VFIO's ordinary mmap() path.

This function transfers ownership of the VFIO device fd to the
DMABUF, which fput()s when it's released.

Refactor the existing vfio_pci_core_feature_dma_buf() to split out
export code common to the two paths, VFIO_DEVICE_FEATURE_DMA_BUF and
this new VFIO_BAR mmap().

By exchanging the VMA file, we lose the original device path in
/proc/<pid>/maps, lsof, etc.  Generate a debug-oriented synthetic
'filename' for BAR mappings based on the BDF, plus resource index.
(This does not apply to explicitly-exported DMABUFs which are named by
DMA_BUF_SET_NAME.)

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 209 ++++++++++++++++++++++-------
 drivers/vfio/pci/vfio_pci_priv.h   |   5 +
 2 files changed, 169 insertions(+), 45 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index 9f10b10fc436..fd3ee2f5c5e8 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -3,6 +3,7 @@
  */
 #include <linux/dma-buf-mapping.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/dma-buf.h>
 #include <linux/dma-resv.h>
 
 #include "vfio_pci_priv.h"
@@ -82,6 +83,8 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
 		up_write(&priv->vdev->dmabuf_lock);
 		vfio_device_put_registration(&priv->vdev->vdev);
 	}
+	if (priv->vfile)
+		fput(priv->vfile);
 	kfree(priv->phys_vec);
 	kfree(priv);
 }
@@ -246,6 +249,165 @@ int vfio_pci_dma_buf_find_pfn(struct vfio_pci_core_device *vdev,
 	return ret;
 }
 
+/*
+ * Create a DMABUF corresponding to priv, add it to vdev->dmabufs list
+ * for tracking (meaning cleanup or revocation will zap it), and take
+ * a vfio_device registration.
+ */
+static int vfio_pci_dmabuf_export(struct vfio_pci_core_device *vdev,
+				  struct vfio_pci_dma_buf *priv, u32 flags)
+{
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+
+	if (!vfio_device_try_get_registration(&vdev->vdev))
+		return -ENODEV;
+
+	exp_info.ops = &vfio_pci_dmabuf_ops;
+	exp_info.size = priv->size;
+	exp_info.flags = flags;
+	exp_info.priv = priv;
+
+	priv->dmabuf = dma_buf_export(&exp_info);
+	if (IS_ERR(priv->dmabuf)) {
+		vfio_device_put_registration(&vdev->vdev);
+		return PTR_ERR(priv->dmabuf);
+	}
+
+	kref_init(&priv->kref);
+	init_completion(&priv->comp);
+
+	/* dma_buf_put() now frees priv */
+	INIT_LIST_HEAD(&priv->dmabufs_elm);
+
+	/*
+	 * dmabuf_lock synchronises access (R) or updates (W) to the
+	 * vdev->dmabufs list and to bars_revoked (see below).  The
+	 * revocation state of DMABUF elements in the list is written
+	 * holding both dmabuf_lock(W) and resv, and tested with
+	 * either.
+	 *
+	 * (memory_lock, if held ->) dmabuf_lock -> resv
+	 *
+	 * NOTE: memory_lock is strictly avoided here, to avoid a
+	 * dependency on memory_lock when mmap_lock is held, when
+	 * mmap() leads to export.  vfio-pci variant drivers are
+	 * permitted to hold memory_lock across actions that might
+	 * fault (such as user access); a deadlock could result when
+	 * that fault path attempts to take mmap_lock (if held by an
+	 * export waiting for memory_lock).
+	 *
+	 * vdev->bars_revoked tracks the BAR revocation status updated
+	 * via vfio_pci_dma_buf_move(), so the initial DMABUF state
+	 * follows the same criteria that later update the DMABUF
+	 * state (BAR zap, etc.).
+	 */
+	lockdep_assert_not_held(&vdev->memory_lock);
+
+	down_write(&vdev->dmabuf_lock);
+	dma_resv_lock(priv->dmabuf->resv, NULL);
+	priv->revoked = vdev->bars_revoked;
+	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
+	dma_resv_unlock(priv->dmabuf->resv);
+	up_write(&vdev->dmabuf_lock);
+
+	return 0;
+}
+
+int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
+				   struct vm_area_struct *vma,
+				   u64 phys_start, u64 req_len,
+				   unsigned int res_index)
+{
+	struct vfio_pci_dma_buf *priv;
+	unsigned long vma_pgoff = vma->vm_pgoff & (VFIO_PCI_OFFSET_MASK >> PAGE_SHIFT);
+	char *bufname;
+	int ret;
+
+	priv = kzalloc_obj(*priv);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->phys_vec = kzalloc_obj(*priv->phys_vec);
+	if (!priv->phys_vec) {
+		ret = -ENOMEM;
+		goto err_free_priv;
+	}
+
+	/*
+	 * Debug name: The absolute maximum size of the name
+	 * ('vfio:ffffffff:ff:1f.7/5') fits within DMA_BUF_NAME_LEN.
+	 */
+	bufname = kasprintf(GFP_KERNEL, "vfio:%s/%x",
+			    pci_name(vdev->pdev),
+			    res_index);
+
+	if (!bufname) {
+		ret = -ENOMEM;
+		goto err_free_phys;
+	}
+
+	/*
+	 * The DMABUF begins from the mmap()'s BAR offset, i.e. the
+	 * start of the VMA corresponds to byte 0 of the DMABUF and
+	 * byte (vma_pgoff << PAGE_SHIFT) of the BAR.
+	 *
+	 * vfio_pci_dma_buf_find_pfn() reverses this offset using
+	 * vma_pgoff_adjust, so that ultimately a fault's offset from
+	 * the start of the _VMA_ has a consistent usage whether the
+	 * VMA originates from an mmap() of the VFIO device here or a
+	 * direct DMABUF mmap().  Note vma_pgoff_adjust also includes
+	 * the encoded VFIO region index, which cancels out the index
+	 * encoded in vm_pgoff.
+	 */
+	priv->vdev = vdev;
+	priv->size = req_len;
+	priv->nr_ranges = 1;
+	priv->vma_pgoff_adjust = vma->vm_pgoff;
+
+	priv->provider = pcim_p2pdma_provider(vdev->pdev, res_index);
+	if (!priv->provider) {
+		ret = -EINVAL;
+		goto err_free_name;
+	}
+
+	priv->phys_vec[0].paddr = phys_start + ((u64)vma_pgoff << PAGE_SHIFT);
+	priv->phys_vec[0].len = priv->size;
+
+	ret = vfio_pci_dmabuf_export(vdev, priv, O_RDWR);
+	if (ret)
+		goto err_free_name;
+
+	if (dma_buf_set_name(priv->dmabuf, bufname)) {
+		dev_dbg_ratelimited(&vdev->pdev->dev,
+				    "Failed to set map name '%s'\n",
+				    bufname);
+		kfree(bufname);
+	}
+
+	/*
+	 * Ownership of the DMABUF file transfers to the VMA so that
+	 * other users can locate the DMABUF via a VA.  Ownership of
+	 * the original VFIO device file being mmap()ed transfers to
+	 * priv, and is put when the DMABUF is released.  This
+	 * intentionally does not use get_file()/vma_set_file()
+	 * because the references are already held, and ownership
+	 * moves.
+	 */
+	priv->vfile = vma->vm_file;
+	vma->vm_file = priv->dmabuf->file;
+	vma->vm_private_data = priv;
+
+	return 0;
+
+err_free_name:
+	kfree(bufname);
+err_free_phys:
+	kfree(priv->phys_vec);
+err_free_priv:
+	kfree(priv);
+	return ret;
+}
+
 /*
  * This is a temporary "private interconnect" between VFIO DMABUF and iommufd.
  * It allows the two co-operating drivers to exchange the physical address of
@@ -364,7 +526,6 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 {
 	struct vfio_device_feature_dma_buf get_dma_buf = {};
 	struct vfio_region_dma_range *dma_ranges;
-	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 	struct vfio_pci_dma_buf *priv;
 	size_t length;
 	int ret;
@@ -424,49 +585,9 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	kfree(dma_ranges);
 	dma_ranges = NULL;
 
-	if (!vfio_device_try_get_registration(&vdev->vdev)) {
-		ret = -ENODEV;
+	ret = vfio_pci_dmabuf_export(vdev, priv, get_dma_buf.open_flags);
+	if (ret)
 		goto err_free_phys;
-	}
-
-	exp_info.ops = &vfio_pci_dmabuf_ops;
-	exp_info.size = priv->size;
-	exp_info.flags = get_dma_buf.open_flags;
-	exp_info.priv = priv;
-
-	priv->dmabuf = dma_buf_export(&exp_info);
-	if (IS_ERR(priv->dmabuf)) {
-		ret = PTR_ERR(priv->dmabuf);
-		goto err_dev_put;
-	}
-
-	kref_init(&priv->kref);
-	init_completion(&priv->comp);
-
-	/* dma_buf_put() now frees priv */
-	INIT_LIST_HEAD(&priv->dmabufs_elm);
-
-	/*
-	 * dmabuf_lock synchronises access (R) or updates (W) to the
-	 * vdev->dmabufs list and to bars_revoked (see below).  The
-	 * revocation state of DMABUF elements in the list is written
-	 * holding both dmabuf_lock(W) and resv, and tested with
-	 * either.
-	 *
-	 * dmabuf_lock -> resv
-	 *
-	 * vdev->bars_revoked tracks the BAR revocation status updated
-	 * via vfio_pci_dma_buf_move(), so the initial DMABUF state
-	 * follows the same criteria that later update the DMABUF
-	 * state (BAR zap, etc.).
-	 */
-	down_write(&vdev->dmabuf_lock);
-	dma_resv_lock(priv->dmabuf->resv, NULL);
-	priv->revoked = vdev->bars_revoked;
-	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
-	dma_resv_unlock(priv->dmabuf->resv);
-	up_write(&vdev->dmabuf_lock);
-
 	/*
 	 * dma_buf_fd() consumes the reference, when the file closes the dmabuf
 	 * will be released.
@@ -477,8 +598,6 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 
 	return ret;
 
-err_dev_put:
-	vfio_device_put_registration(&vdev->vdev);
 err_free_phys:
 	kfree(priv->phys_vec);
 err_free_priv:
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 786df3a81d9d..66a5ae19082d 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -30,6 +30,7 @@ struct vfio_pci_dma_buf {
 	size_t size;
 	struct phys_vec *phys_vec;
 	struct p2pdma_provider *provider;
+	struct file *vfile;
 	u32 nr_ranges;
 	struct kref kref;
 	struct completion comp;
@@ -143,6 +144,10 @@ int vfio_pci_dma_buf_find_pfn(struct vfio_pci_core_device *vdev,
 			      unsigned long address,
 			      unsigned int order,
 			      unsigned long *out_pfn);
+int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
+				   struct vm_area_struct *vma,
+				   u64 phys_start, u64 req_len,
+				   unsigned int res_index);
 
 #ifdef CONFIG_VFIO_PCI_DMABUF
 int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
-- 
2.47.3

