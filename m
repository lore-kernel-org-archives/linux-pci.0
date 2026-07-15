Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F86F4C8FEB;
	Wed, 15 Jul 2026 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137718; cv=none; b=GcgLArB3TOf5thkExBnlMKrgJKNGdcIM7xLzLmiucjZG4O2Og8qijy87VcXzS+XpFidKcb7McKPwq1x9Cm5pApys34ObS+ApsJaspU48vqmSI/lgdkD8MZHqgax+D1osT2NI6SsubpLNsG1GpaIwWo/0AGM+se1W9KQAeHLGTDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137718; c=relaxed/simple;
	bh=cJeTbkDuz0ZAW7FfVgCAgDl2CrmHOTVGixoorH18VQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=heeGmXiXs07iDOs2YITvjD8JKecPPOeWZSb6PVF1ALui5u0zx8eqYGR3Q6ZF8976wLJ/2GQlUSOM/9Do73Gbf7aWEyBckDBHB0m3/cy7CSLwwWJ1vyVe79f6NthcCF0thfY6g20OiJHL63USVtTmiq2u1LH/utDvrmNW5H53blY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=meVllOTc; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="meVllOTc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1784137714;
	bh=pTQJGThb4edVbg5j3j/NZn6qcrGrxNFu94JuNXgxYKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=meVllOTcTqfjtFMBJHiY8J+OfMU1exZVz7i+6TP+5/+ULib6A4KvV+rkxOhz8U+8f
	 296IM+RkPGxXCJyT2gkPJvbiMAQ41ShQE7oi1XNggwUiN0goTt4TXAvOzBWTvf3IBH
	 MMAI1KdCytN0Q1d6zrv7kpsY0/laTwFuPmD/min+jcW3cyV1fhCHQCJ3Tmg5tGGT7a
	 owjEjwTsywtpGF84Q5HMNwXvxthalKjELMwRuze8ocHBIbIjaHPjsH1THdEtLskVVG
	 oC2SkGnuIvc/CZyk4v0SkYnejT9h0+DT5FC8GRMvdaKKPLiZy+GraPpd11Ip+5ZFUE
	 Pa/HU3dsroLTA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4h0kDd2v5Rz4wCK;
	Thu, 16 Jul 2026 03:48:33 +1000 (AEST)
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
Subject: [PATCH v5 9/9] vfio/pci: Permanently revoke a DMABUF on request
Date: Wed, 15 Jul 2026 18:47:32 +0100
Message-ID: <20260715174737.15287-10-matt@ozlabs.org>
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

Expand the VFIO DMABUF revocation state to three states:
Not revoked, temporarily revoked, and permanently revoked.

The first two are for existing transient revocation, e.g. across a
function reset, and the DMABUF is put into the last in response to a
new VFIO feature VFIO_DEVICE_FEATURE_DMA_BUF_REVOKE.

VFIO_DEVICE_FEATURE_DMA_BUF_REVOKE passes a DMABUF by fd and requests
that the DMABUF is permanently revoked.  On success, it's guaranteed
that the buffer can never be imported/attached/mmap()ed in future,
that dynamic imports have been cleanly detached, and that all mappings
have been made inaccessible/PTEs zapped.

This is useful for lifecycle management, to reclaim VFIO PCI BAR
ranges previously delegated to a subordinate client process: by
revoking, the driver process can ensure that the loaned resources are
made inaccessible when the client is deemed "done".  The original
DMABUF is defunct, and BAR resources can then be safely re-exported
for use by new clients.

Refactor the revocation code out of vfio_pci_dma_buf_move() to a
function common to move and the new feature request path.  Note: this
now only calls dma_buf_invalidate_mappings()/dma_resv_wait_timeout()
on the revoke path, whereas vfio_pci_dma_buf_move() originally called
them for both revoke and (unnecessarily) un-revoke.

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/vfio/pci/vfio_pci_core.c   |   6 +-
 drivers/vfio/pci/vfio_pci_dmabuf.c | 166 ++++++++++++++++++++++-------
 drivers/vfio/pci/vfio_pci_priv.h   |  19 +++-
 include/uapi/linux/vfio.h          |  25 +++++
 4 files changed, 174 insertions(+), 42 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index ef93fbd5f1b6..0fa855ba537e 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1633,6 +1633,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_DMA_BUF:
 		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_DMA_BUF_REVOKE:
+		return vfio_pci_core_feature_dma_buf_revoke(vdev, flags, arg, argsz);
 	default:
 		return -ENOTTY;
 	}
@@ -1844,7 +1846,7 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 
 	dma_resv_lock(priv->dmabuf->resv, NULL);
 
-	if (priv->revoked) {
+	if (priv->status != VFIO_PCI_DMABUF_OK) {
 		pr_debug_ratelimited("%s VA 0x%lx, pgoff 0x%lx: DMABUF revoked/cleaned up\n",
 				     __func__, vmf->address, vma->vm_pgoff);
 		dma_resv_unlock(priv->dmabuf->resv);
@@ -1869,7 +1871,7 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 
 	scoped_guard(rwsem_read, &vdev->memory_lock) {
 		/* Revocation status must be re-read, under memory_lock */
-		if (!priv->revoked) {
+		if (priv->status == VFIO_PCI_DMABUF_OK) {
 			int pres = vfio_pci_dma_buf_find_pfn(priv, vma,
 							     vmf->address,
 							     order, &pfn);
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index ccfe861f88b6..36bf07530840 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -19,7 +19,7 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
 	if (!attachment->peer2peer)
 		return -EOPNOTSUPP;
 
-	if (priv->revoked)
+	if (priv->status != VFIO_PCI_DMABUF_OK)
 		return -ENODEV;
 
 	if (!dma_buf_attach_revocable(attachment))
@@ -44,7 +44,7 @@ static int vfio_pci_dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *
 	 * still safe because the fault handler ultimately prevents
 	 * access to a revoked buffer if it isn't caught here.
 	 */
-	if (READ_ONCE(priv->revoked))
+	if (READ_ONCE(priv->status) != VFIO_PCI_DMABUF_OK)
 		return -ENODEV;
 	if ((vma->vm_flags & VM_SHARED) == 0)
 		return -EINVAL;
@@ -79,7 +79,7 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attachment,
 
 	dma_resv_assert_held(priv->dmabuf->resv);
 
-	if (priv->revoked)
+	if (priv->status != VFIO_PCI_DMABUF_OK)
 		return ERR_PTR(-ENODEV);
 
 	ret = dma_buf_phys_vec_to_sgt(attachment, priv->provider,
@@ -305,7 +305,8 @@ static int vfio_pci_dmabuf_export(struct vfio_pci_core_device *vdev,
 	INIT_LIST_HEAD(&priv->dmabufs_elm);
 	down_write(&vdev->memory_lock);
 	dma_resv_lock(priv->dmabuf->resv, NULL);
-	priv->revoked = !__vfio_pci_memory_enabled(vdev);
+	priv->status = __vfio_pci_memory_enabled(vdev) ? VFIO_PCI_DMABUF_OK :
+		VFIO_PCI_DMABUF_TEMP_REVOKED;
 	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
 	dma_resv_unlock(priv->dmabuf->resv);
 	up_write(&vdev->memory_lock);
@@ -336,7 +337,7 @@ int vfio_pci_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
 		return -EOPNOTSUPP;
 
 	priv = attachment->dmabuf->priv;
-	if (priv->revoked)
+	if (priv->status != VFIO_PCI_DMABUF_OK)
 		return -ENODEV;
 
 	/* More than one range to iommufd will require proper DMABUF support */
@@ -600,6 +601,59 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
 	return ret;
 }
 
+/* Set the DMABUF's revocation status (OK or temporarily/permanently revoked) */
+static void vfio_pci_dma_buf_set_status(struct vfio_pci_dma_buf *priv,
+					enum vfio_pci_dma_buf_status new_status)
+{
+	bool was_revoked;
+
+	lockdep_assert_held_write(&priv->vdev->memory_lock);
+
+	if (priv->status == VFIO_PCI_DMABUF_PERM_REVOKED ||
+	    priv->status == new_status)
+		return;
+
+	dma_resv_lock(priv->dmabuf->resv, NULL);
+	was_revoked = (priv->status == VFIO_PCI_DMABUF_TEMP_REVOKED);
+
+	if (new_status != VFIO_PCI_DMABUF_OK) {
+		priv->status = new_status; /* Temp or permanently revoked */
+
+		if (was_revoked) {
+			/*
+			 * TEMP_REVOKED is being upgraded to
+			 * PERM_REVOKED.  The buffer is already gone,
+			 * don't wait on it again.
+			 */
+			dma_resv_unlock(priv->dmabuf->resv);
+			return;
+		}
+		dma_buf_invalidate_mappings(priv->dmabuf);
+		dma_resv_wait_timeout(priv->dmabuf->resv,
+				      DMA_RESV_USAGE_BOOKKEEP, false,
+				      MAX_SCHEDULE_TIMEOUT);
+		dma_resv_unlock(priv->dmabuf->resv);
+		kref_put(&priv->kref, vfio_pci_dma_buf_done);
+		wait_for_completion(&priv->comp);
+		unmap_mapping_range(priv->dmabuf->file->f_mapping,
+				    0, 0, true);
+		/*
+		 * Re-arm the registered kref reference and the
+		 * completion so the post-revoke state matches the
+		 * post-creation state.  An un-revoke followed by a
+		 * new mapping needs the kref to be non-zero before
+		 * kref_get(), and vfio_pci_dma_buf_cleanup()
+		 * delegates its drain back through this revoke
+		 * path on a possibly-already-revoked dma-buf.
+		 */
+		kref_init(&priv->kref);
+		reinit_completion(&priv->comp);
+	} else {
+		priv->status = VFIO_PCI_DMABUF_OK;
+		dma_resv_unlock(priv->dmabuf->resv);
+	}
+}
+
 void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
 {
 	struct vfio_pci_dma_buf *priv;
@@ -607,45 +661,16 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
 
 	/*
 	 * Holding memory_lock ensures a racing VMA fault observes
-	 * priv->revoked properly.
+	 * priv->status properly.
 	 */
 	lockdep_assert_held_write(&vdev->memory_lock);
 
 	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
 		if (!get_file_active(&priv->dmabuf->file))
 			continue;
-
-		if (priv->revoked != revoked) {
-			dma_resv_lock(priv->dmabuf->resv, NULL);
-			if (revoked)
-				priv->revoked = true;
-			dma_buf_invalidate_mappings(priv->dmabuf);
-			dma_resv_wait_timeout(priv->dmabuf->resv,
-					      DMA_RESV_USAGE_BOOKKEEP, false,
-					      MAX_SCHEDULE_TIMEOUT);
-			dma_resv_unlock(priv->dmabuf->resv);
-			if (revoked) {
-				kref_put(&priv->kref, vfio_pci_dma_buf_done);
-				wait_for_completion(&priv->comp);
-				unmap_mapping_range(priv->dmabuf->file->f_mapping,
-						    0, 0, true);
-				/*
-				 * Re-arm the registered kref reference and the
-				 * completion so the post-revoke state matches the
-				 * post-creation state.  An un-revoke followed by a
-				 * new mapping needs the kref to be non-zero before
-				 * kref_get(), and vfio_pci_dma_buf_cleanup()
-				 * delegates its drain back through this revoke
-				 * path on a possibly-already-revoked dma-buf.
-				 */
-				kref_init(&priv->kref);
-				reinit_completion(&priv->comp);
-			} else {
-				dma_resv_lock(priv->dmabuf->resv, NULL);
-				priv->revoked = false;
-				dma_resv_unlock(priv->dmabuf->resv);
-			}
-		}
+		vfio_pci_dma_buf_set_status(priv, revoked ?
+					    VFIO_PCI_DMABUF_TEMP_REVOKED :
+					    VFIO_PCI_DMABUF_OK);
 		fput(priv->dmabuf->file);
 	}
 }
@@ -671,9 +696,72 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
 			continue;
 
 		list_del_init(&priv->dmabufs_elm);
-		priv->vdev = NULL;
+		WRITE_ONCE(priv->vdev, NULL);
 		vfio_device_put_registration(&vdev->vdev);
 		fput(priv->dmabuf->file);
 	}
 	up_write(&vdev->memory_lock);
 }
+
+#ifdef CONFIG_VFIO_PCI_DMABUF
+int vfio_pci_core_feature_dma_buf_revoke(
+	struct vfio_pci_core_device *vdev, u32 flags,
+	struct vfio_device_feature_dma_buf_revoke __user *arg,
+	size_t argsz)
+{
+	struct vfio_device_feature_dma_buf_revoke db_revoke;
+	struct vfio_pci_dma_buf *priv;
+	struct dma_buf *dmabuf;
+	int ret;
+
+	if (!vdev->pci_ops || !vdev->pci_ops->get_dmabuf_phys)
+		return -EOPNOTSUPP;
+
+	ret = vfio_check_feature(flags, argsz,
+				 VFIO_DEVICE_FEATURE_SET,
+				 sizeof(db_revoke));
+	if (ret != 1)
+		return ret;
+
+	if (copy_from_user(&db_revoke, arg, sizeof(db_revoke)))
+		return -EFAULT;
+
+	dmabuf = dma_buf_get(db_revoke.dmabuf_fd);
+	if (IS_ERR(dmabuf))
+		return PTR_ERR(dmabuf);
+
+	priv = dmabuf->priv;
+	/*
+	 * Sanity-check the DMABUF is really a vfio_pci_dma_buf _and_
+	 * relates to the VFIO device it was provided with.
+	 *
+	 * If the DMABUF relates to this vdev then priv->vdev is
+	 * stable because this open fd prevents cleanup.
+	 *
+	 * If it relates to a different vdev, reading priv->vdev might
+	 * race with a concurrent cleanup on that device.  But if so,
+	 * it points to a non-matching vdev or NULL and is unusable
+	 * either way.
+	 */
+	if (dmabuf->ops != &vfio_pci_dmabuf_ops ||
+	    READ_ONCE(priv->vdev) != vdev) {
+		ret = -ENODEV;
+		goto out_put_buf;
+	}
+
+	scoped_guard(rwsem_write, &vdev->memory_lock) {
+		if (priv->status == VFIO_PCI_DMABUF_PERM_REVOKED) {
+			ret = -EBADFD;
+		} else {
+			vfio_pci_dma_buf_set_status(priv,
+						    VFIO_PCI_DMABUF_PERM_REVOKED);
+			ret = 0;
+		}
+	}
+
+out_put_buf:
+	dma_buf_put(dmabuf);
+
+	return ret;
+}
+#endif /* CONFIG_VFIO_PCI_DMABUF */
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index c3fa35381679..8741abd04461 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -23,6 +23,12 @@ struct vfio_pci_ioeventfd {
 	bool			test_mem;
 };
 
+enum vfio_pci_dma_buf_status {
+	VFIO_PCI_DMABUF_OK = 0,
+	VFIO_PCI_DMABUF_TEMP_REVOKED = 1,
+	VFIO_PCI_DMABUF_PERM_REVOKED = 2,
+};
+
 struct vfio_pci_dma_buf {
 	struct dma_buf *dmabuf;
 	struct vfio_pci_core_device *vdev;
@@ -35,7 +41,7 @@ struct vfio_pci_dma_buf {
 	struct kref kref;
 	struct completion comp;
 	unsigned long vma_pgoff_adjust;
-	u8 revoked : 1;
+	enum vfio_pci_dma_buf_status status;
 };
 
 bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev);
@@ -147,6 +153,10 @@ void vfio_pci_set_vma_ops(struct vm_area_struct *vma);
 int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 				  struct vfio_device_feature_dma_buf __user *arg,
 				  size_t argsz);
+int vfio_pci_core_feature_dma_buf_revoke(
+	struct vfio_pci_core_device *vdev, u32 flags,
+	struct vfio_device_feature_dma_buf_revoke __user *arg,
+	size_t argsz);
 #else
 static inline int
 vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
@@ -155,6 +165,13 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 {
 	return -ENOTTY;
 }
+static inline int vfio_pci_core_feature_dma_buf_revoke(
+	struct vfio_pci_core_device *vdev, u32 flags,
+	struct vfio_device_feature_dma_buf_revoke __user *arg,
+	size_t argsz)
+{
+	return -ENOTTY;
+}
 #endif
 
 #endif
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..cbe03e5d1009 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1534,6 +1534,31 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
 
+/**
+ * Given a dma_buf fd previously exported from the same device by
+ * VFIO_DEVICE_FEATURE_DMA_BUF, a SET of this feature requests that
+ * access to the corresponding DMABUF is immediately and permanently
+ * revoked.  On successful return, the buffer is not accessible
+ * through any mmap() or dma-buf import.  The buffer is permanently
+ * disabled, and VFIO refuses all map, mmap, attach, etc. requests.
+ *
+ * Return: 0 on success, -1 and errno is set on failure:
+ *
+ *  EBADF, EINVAL: dmabuf_fd is not a DMABUF fd.
+ *  EOPNOTSUPP: The VFIO device does not support DMABUF export.
+ *  ENODEV: The device supports export but dmabuf_fd was exported
+ *          from a different device.
+ *  EBADFD: The DMABUF is already revoked.
+ *
+ * Additionally, common errors can occur: EFAULT accessing the struct,
+ * or EINVAL requesting an unsupported feature op.
+ */
+#define VFIO_DEVICE_FEATURE_DMA_BUF_REVOKE 13
+
+struct vfio_device_feature_dma_buf_revoke {
+	__s32	dmabuf_fd;
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.50.1 (Apple Git-155)

