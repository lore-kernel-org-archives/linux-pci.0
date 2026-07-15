Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9158A4508F8;
	Wed, 15 Jul 2026 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137696; cv=none; b=QcLyDvRJn9UYsXBboSZwxqpG/JFedRnCAFQpsqFm79V6AzOWLgsQiSVDGcg8Iuvpz8LTJiJ+zjslQ+DdNDkfV7NgLpSAUNFp47TsLbOMEACUCIa64sRZVf+TtUcCd8dPLrw2VWCGEVAOzGM8pui+edGcH6ub3wxRF/Oo2VRgya4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137696; c=relaxed/simple;
	bh=1tElFt/f0HD62o3wSdIlZpdqIz1cLH90wsIkvp9ET7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAjZnI26bbvqAkvz5aJT+Wy22Jh/ynhhDeYQjlm7CRYPNxs1/TFBN/o8L6xGn+fbFhRESRA8f1bK6DnNZpNtiL25tmdEmsnunuDB7cXJMLPrS0muE/MEFIyPI8uNx8l6uBjy+8w48xJTlDqy1iZscQyzAe3huNT1i7aBtVbj1YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=w8YuR/Vl; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="w8YuR/Vl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1784137691;
	bh=dh9wHD/MgJucgfEcoh16s1AY3xGDOpi3U5qAKOyp2SY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w8YuR/VlCHror5XOV3a00cpUhjCH2L2w8PNbl314Gwaewg4QImRW4SMNyzhZtexCG
	 RNp80QOiUcKS2vGWLG4VSOKpl78HuXyzZfe25bvcbnHfINu29dDk0esm/agyxEdvcl
	 N4b+n4lB8I0SUnA+NHTlePSTpPDJhD75vgrMfiJq1qPyIs9bhPiDXVLay2NMxWk60Q
	 2N8Xo/qvw2VJQUnRKwo/sWjVrODq1y/mr4aoLpogK/oVI5ygKBDkf5vrh00O5pKu91
	 BWYejghOyxHeowVJulwTak6PMGUbF49sUyurLEMsDs3bDf4XxweFo5ix3FEAK6lfc2
	 uhbY+LZHzhxyw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4h0kDB2d8Lz4wCH;
	Thu, 16 Jul 2026 03:48:10 +1000 (AEST)
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
Subject: [PATCH v5 4/9] vfio/pci: Add a helper to create a DMABUF for a BAR-map VMA
Date: Wed, 15 Jul 2026 18:47:27 +0100
Message-ID: <20260715174737.15287-5-matt@ozlabs.org>
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

This helper, vfio_pci_core_mmap_prep_dmabuf(), creates a single-range
DMABUF for the purpose of mapping a PCI BAR.  This is used in a future
commit by VFIO's ordinary mmap() path.

This function transfers ownership of the VFIO device fd to the
DMABUF, which fput()s when it's released.

Refactor the existing vfio_pci_core_feature_dma_buf() to split out
export code common to the two paths, VFIO_DEVICE_FEATURE_DMA_BUF and
this new VFIO_BAR mmap().

Signed-off-by: Matt Evans <matt@ozlabs.org>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 142 +++++++++++++++++++++++------
 drivers/vfio/pci/vfio_pci_priv.h   |   5 +
 2 files changed, 117 insertions(+), 30 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index 7c047400dfd1..74c02794bfe2 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -82,6 +82,8 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
 		up_write(&priv->vdev->memory_lock);
 		vfio_device_put_registration(&priv->vdev->vdev);
 	}
+	if (priv->vfile)
+		fput(priv->vfile);
 	kfree(priv->phys_vec);
 	kfree(priv);
 }
@@ -233,6 +235,45 @@ int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *priv,
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
+	down_write(&vdev->memory_lock);
+	dma_resv_lock(priv->dmabuf->resv, NULL);
+	priv->revoked = !__vfio_pci_memory_enabled(vdev);
+	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
+	dma_resv_unlock(priv->dmabuf->resv);
+	up_write(&vdev->memory_lock);
+
+	return 0;
+}
+
 /*
  * This is a temporary "private interconnect" between VFIO DMABUF and iommufd.
  * It allows the two co-operating drivers to exchange the physical address of
@@ -351,7 +392,6 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 {
 	struct vfio_device_feature_dma_buf get_dma_buf = {};
 	struct vfio_region_dma_range *dma_ranges;
-	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 	struct vfio_pci_dma_buf *priv;
 	size_t length;
 	int ret;
@@ -411,34 +451,9 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
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
-	down_write(&vdev->memory_lock);
-	dma_resv_lock(priv->dmabuf->resv, NULL);
-	priv->revoked = !__vfio_pci_memory_enabled(vdev);
-	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
-	dma_resv_unlock(priv->dmabuf->resv);
-	up_write(&vdev->memory_lock);
-
 	/*
 	 * dma_buf_fd() consumes the reference, when the file closes the dmabuf
 	 * will be released.
@@ -449,8 +464,6 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 
 	return ret;
 
-err_dev_put:
-	vfio_device_put_registration(&vdev->vdev);
 err_free_phys:
 	kfree(priv->phys_vec);
 err_free_priv:
@@ -460,6 +473,75 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	return ret;
 }
 
+int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
+				   struct vm_area_struct *vma,
+				   u64 phys_start, u64 req_len,
+				   unsigned int res_index)
+{
+	struct vfio_pci_dma_buf *priv;
+	unsigned long vma_pgoff = vma->vm_pgoff & (VFIO_PCI_OFFSET_MASK >> PAGE_SHIFT);
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
+	 * The DMABUF begins from the mmap()'s BAR offset, i.e. the
+	 * start of the VMA corresponds to byte 0 of the DMABUF and
+	 * byte (vma_pgoff << PAGE_SHIFT) of the BAR.
+	 *
+	 * vfio_pci_dma_buf_find_pfn() reverses this offset using
+	 * vma_pgoff_adjust, so that ultimately a fault's offset from
+	 * the start of the _VMA_ has a consistent usage whether the
+	 * VMA originates from an mmap() of the VFIO device here or a
+	 * direct DMABUF mmap().
+	 */
+	priv->vdev = vdev;
+	priv->size = req_len;
+	priv->nr_ranges = 1;
+	priv->vma_pgoff_adjust = vma_pgoff;
+	priv->provider = pcim_p2pdma_provider(vdev->pdev, res_index);
+	if (!priv->provider) {
+		ret = -EINVAL;
+		goto err_free_phys;
+	}
+
+	priv->phys_vec[0].paddr = phys_start + ((u64)vma_pgoff << PAGE_SHIFT);
+	priv->phys_vec[0].len = priv->size;
+
+	ret = vfio_pci_dmabuf_export(vdev, priv, O_CLOEXEC | O_RDWR);
+	if (ret)
+		goto err_free_phys;
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
+err_free_phys:
+	kfree(priv->phys_vec);
+err_free_priv:
+	kfree(priv);
+	return ret;
+}
+
 void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
 {
 	struct vfio_pci_dma_buf *priv;
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index c8f6f959056a..06dc0fd3e230 100644
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
@@ -133,6 +134,10 @@ int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *vpdmabuf,
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
2.50.1 (Apple Git-155)

