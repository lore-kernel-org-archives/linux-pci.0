Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8186D3B6BF4;
	Thu, 24 Sep 2026 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263381; cv=none; b=MlY0EWSFk2Pv+NHtFY4ayp5VeEEhfIEGQmZJg5dHVFBUPDWVTzG4M4m0QVfDnVpYmoWqZI8AQJf5INvS5fRoNJWe97B3vbxsE7vHryKDBbjx26Nl/R71d2UqRy4K15wtvfKR/8K+gurJTUY73va6VbNHe2pUDU77s6f+T0Lo1vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263381; c=relaxed/simple;
	bh=/4PfY3mQ7emDttcrII6Yklhd41NtHlMEsKPwp/S1IBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+ySN9ayB3F4rf2PbWo5dxinvLc8iEZ/3+dR+tvCQ7Vv2zxrf2teyGT07yynIGv1TcMedABa5XKdX/rzVfCTGnbYjUAI3JrjOmR/vAQCYID6vxIQRJFc6DOcxtivj/Goj8BHQKnBWNqEiDOYKXpFd9SyABJ5JnYQX9RLtaKo1OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=J6eLNRnI; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="J6eLNRnI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1790263348;
	bh=ER/KY8UXfK8c0VQTmavxRmsDF4Dsrqaymely51IlP6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J6eLNRnIRK4irpejH6jGmi62M1Y6MOTTFtN4rmRU//uOedVrDHlDlW8bbw2g0DSD6
	 BIdxsKBgQcfP2zvt8SXtZGCZFstEKnsBJqZFzxBdmay5C32k7rPv8+YF+MwLyMJlKN
	 Qb1zIjZVzrocdR9ONbQA5H1bR4XL9WYLSEcYtFk2CjSgVsvAeh5/PoBK7VHuF+Gnxv
	 jmE+cqXwTsiWnwPPBW2wiSPH4BGJwqa+PM8mo85RJpz4WwRsszuiIvzU+/12PFrhct
	 fcDxXeSv2buIXEYWyJZYQLYQdbRhEiLFiABfKs6nnCuJDeYID3ZmnVNBdNO6OxGwpx
	 IAoxp5UycGprw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hrHdH47j4z4w0Q;
	Fri, 25 Sep 2026 01:22:27 +1000 (AEST)
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
Subject: [PATCH v7 8/9] vfio/pci: Support mmap() of a VFIO DMABUF
Date: Thu, 24 Sep 2026 16:21:51 +0100
Message-ID: <20260924152159.49702-9-matt@ozlabs.org>
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

A VFIO DMABUF can export a subset of a BAR to userspace by fd; add
support for mmap() of this fd.  This provides another route for a
process to map BARs, in which the process can only map a specific
subset of a BAR represented by the exported DMABUF.

mmap() support enables userspace drivers to safely delegate BAR
sub-ranges to other processes by sharing a DMABUF fd, without having
to share the (omnipotent) VFIO device fd with them.

Since the main VFIO BAR mmap() is now DMABUF-aware, the new mmap() reuses
the existing vm_ops.

The lifecycle of an exported DMABUF remains decoupled from that of the
device fd it came from, i.e. the device fd could be closed with DMABUF
VMAs present, meaning a fault on a VMA could happen concurrently with
vfio_pci_dma_buf_cleanup().

To deal with this scenario, the fault handler now temporarily takes a
VFIO device registration to ensure the vdev remains valid, and then
vdev locks can be taken.

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/vfio/pci/vfio_pci_core.c   | 84 ++++++++++++++++++++++++++----
 drivers/vfio/pci/vfio_pci_dmabuf.c | 47 +++++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h   |  1 +
 3 files changed, 123 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 986852b1d44f..d38210d1c5c4 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -13,6 +13,8 @@
 #include <linux/aperture.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
+#include <linux/dma-buf.h>
+#include <linux/dma-resv.h>
 #include <linux/eventfd.h>
 #include <linux/file.h>
 #include <linux/interrupt.h>
@@ -1804,21 +1806,79 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 
 	/*
-	 * We can rely on the existence of both a DMABUF (priv) and
-	 * the VFIO device it was exported from (vdev).  This fault's
-	 * VMA was established using vfio_pci_core_mmap_prep_dmabuf()
-	 * which transfers ownership of the VFIO device fd to the
-	 * DMABUF, and so the VFIO device is held open because the
-	 * VMA's vm_file (DMABUF) is open.
+	 * The only thing this can rely on is that the DMABUF relating
+	 * to the VMA's vm_file exists (priv).
 	 *
-	 * Since vfio_pci_dma_buf_cleanup() cannot have happened,
-	 * vdev must be valid; we can take vdev locks.
+	 * A DMABUF for a VFIO device fd mmap() holds a reference to
+	 * the original VFIO device fd, but an explicitly-exported
+	 * DMABUF does not.  The original fd might have closed,
+	 * meaning this fault can race with
+	 * vfio_pci_dma_buf_cleanup(), meaning the buffer could have
+	 * been revoked (in which case priv->vdev might be NULL), and
+	 * the VFIO device registration might have been dropped.
+	 *
+	 * With the goal of taking vdev locks in a world where vdev
+	 * might not still exist:
+	 *
+	 * 1. Take the resv lock on the DMABUF:
+	 *  - If racing cleanup got in first, the buffer is revoked;
+	 *    stop/exit if so.
+	 *  - If we got in first, the buffer is not revoked so vdev is
+	 *    non-NULL, accessible, and cleanup _has not yet put the
+	 *    VFIO device registration_.  So, the device refcount must
+	 *    be >0.
+	 *
+	 * 2. Take vfio_device registration (refcount guaranteed >0
+	 *    hereafter).
+	 *
+	 * 3. Unlock the DMABUF's resv lock:
+	 *  - A racing cleanup can now complete.
+	 *  - But, the device refcount >0, meaning the vfio_device
+	 *    (and vfio_pcie_core device vdev) have not yet been
+	 *    freed.  vdev is accessible, even if the DMABUF has been
+	 *    revoked or cleanup has happened, because
+	 *    vfio_unregister_group_dev() can't complete.
+	 *
+	 * 4. Take the vdev->memory_lock then vdev->dmabuf_lock:
+	 *  - Either the DMABUF is usable, or has been cleaned up.
+	 *  - It's not necessary to also take the resv lock, because
+	 *    the status/vdev can't change while dmabuf_lock is held.
+	 *  - Test the DMABUF revocation status again: if it was
+	 *    revoked between 1 and 4, return a SIGBUS. Otherwise,
+	 *    return a PFN.
+	 *
+	 * 5. Unlock, done.
 	 */
+
+	dma_resv_lock(priv->dmabuf->resv, NULL);
+
+	if (priv->revoked) {
+		pr_debug_ratelimited("%s VA 0x%lx, pgoff 0x%lx: DMABUF revoked/cleaned up\n",
+				     __func__, vmf->address, vma->vm_pgoff);
+		dma_resv_unlock(priv->dmabuf->resv);
+		return VM_FAULT_SIGBUS;
+	}
+
+	/* If the buffer isn't revoked, vdev is valid */
 	vdev = priv->vdev;
 
+	if (!vfio_device_try_get_registration(&vdev->vdev)) {
+		/*
+		 * If vdev != NULL (above), the registration should
+		 * already be >0 and so this try_get should never
+		 * fail.
+		 */
+		dev_warn_ratelimited(&vdev->pdev->dev,
+				     "%s: Unexpected registration failure\n",
+				     __func__);
+		dma_resv_unlock(priv->dmabuf->resv);
+		return VM_FAULT_SIGBUS;
+	}
+	dma_resv_unlock(priv->dmabuf->resv);
+
 	/* memory_lock for vfio_pci_vmf_insert_pfn() */
 	down_read(&vdev->memory_lock);
-	/* Test revocation status under dmabuf_lock */
+	/* Re-test revocation status under dmabuf_lock */
 	down_read(&vdev->dmabuf_lock);
 	if (!priv->revoked) {
 		int pres = vfio_pci_dma_buf_find_pfn(vdev, priv, vma,
@@ -1839,6 +1899,7 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 			    __func__, order, pfn, vmf->address,
 			    vma->vm_pgoff, (unsigned int)ret);
 
+	vfio_device_put_registration(&vdev->vdev);
 	return ret;
 }
 
@@ -1854,6 +1915,11 @@ static const struct vm_operations_struct vfio_pci_mmap_ops = {
 #endif
 };
 
+void vfio_pci_set_vma_ops(struct vm_area_struct *vma)
+{
+	vma->vm_ops = &vfio_pci_mmap_ops;
+}
+
 int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma)
 {
 	struct vfio_pci_core_device *vdev =
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index 617afb7de00f..c0a48d17c829 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -27,6 +27,50 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
 
 	return 0;
 }
+
+static int vfio_pci_dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
+{
+	struct vfio_pci_dma_buf *priv = dmabuf->priv;
+
+	/*
+	 * dma_buf_mmap_internal() has asserted that the VMA is
+	 * contained within the DMABUF size before calling this.
+	 *
+	 * Also, if we observe that the buffer is revoked now then
+	 * refuse the mmap().  This is a belt-and-braces early failure
+	 * to ease debugging a revoked buffer being used.  Userspace
+	 * might also race an mmap() against an explicit revocation,
+	 * or an action causing a revoke; race scenarios are still
+	 * safe because the fault handler ultimately prevents access
+	 * to a revoked buffer if it isn't caught here.
+	 */
+	if (priv->revoked)
+		return -ENODEV;
+	/*
+	 * Make clear that anything with an offset adjustment is
+	 * explicitly unsupported, as vfio_pci_dma_buf_find_pfn()
+	 * maths would underflow; this doesn't happen through the
+	 * regular DMABUF export path used with this mmap().  A DMABUF
+	 * implicitly created for BAR mmap could have adjust > 0, but
+	 * these can't currently be re-opened and mmap()ed again.
+	 * Catch here in case that assumption ever changes.
+	 */
+	if (priv->vma_pgoff_adjust)
+		return -EINVAL;
+	if ((vma->vm_flags & VM_SHARED) == 0)
+		return -EINVAL;
+
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
+
+	/* See comments in vfio_pci_core_mmap() re VM_ALLOW_ANY_UNCACHED. */
+	vm_flags_set(vma, VM_ALLOW_ANY_UNCACHED | VM_IO | VM_PFNMAP |
+		     VM_DONTEXPAND | VM_DONTDUMP);
+	vma->vm_private_data = priv;
+	vfio_pci_set_vma_ops(vma);
+
+	return 0;
+}
 #else
 static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
 				   struct dma_buf_attachment *attachment)
@@ -104,6 +148,9 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
 
 static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
 	.attach = vfio_pci_dma_buf_attach,
+#ifdef CONFIG_VFIO_PCI_DMABUF
+	.mmap = vfio_pci_dma_buf_mmap,
+#endif
 	.map_dma_buf = vfio_pci_dma_buf_map,
 	.unmap_dma_buf = vfio_pci_dma_buf_unmap,
 	.release = vfio_pci_dma_buf_release,
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index f11b31f8953c..32d520cac52f 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -151,6 +151,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
 				   unsigned int res_index);
 void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev);
 void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked);
+void vfio_pci_set_vma_ops(struct vm_area_struct *vma);
 
 #ifdef CONFIG_VFIO_PCI_DMABUF
 int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
-- 
2.50.1 (Apple Git-155)

