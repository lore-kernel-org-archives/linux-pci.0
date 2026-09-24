Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932C44A0EF1;
	Thu, 24 Sep 2026 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263348; cv=none; b=AjydOwCClaAQTtwDAxyn4erBGC96wnNsU4ZRKLi2mgmsxn9+fYarLn/p7oPbSxNPUAhcOmoxtuIc8bXYd70LITHHU0f769YHNFv2lxmh2AIciHwoYk3Zl2Dg35M2BRkB5s047lSHyknU83Myv9kKxWEpfTxFHrzUsOOrJfuEb8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263348; c=relaxed/simple;
	bh=ezlzSOUHgpZK0dAcZsvnMlqq8vUFEavpyz5MDK+9Fy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3NQaNL8elo8RnyMSfwI/pNpJNd6/rSSQdnH86KP7UiW/qsNEDuP/nRZf7jTm5qaPJDZlAHRJlYrNMqw3zCMnUxI5PII/cZk8M6o5w7Q6tu1XCk8S20RKgAq8g5Yw32WXVJGZPMZewPuy3Qv0RppoJrbhc3uGMPgLwMzhrvP0Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=Qz3gnf0r; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="Qz3gnf0r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1790263314;
	bh=V4bT6QQrpl1qVat6dN2utOKpKwESjAKUGxUpph+ijfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qz3gnf0raqw4TIFYyG5UgijKIVzNMnwgn9OkL4ZigQQaWyhXD1kheV88UJ4R0fTnu
	 xAbnGQbqXl5aoRr5RO8iygHH8qIMODKWd0ufP4+YqMcckLKSkt7Glfb6nh8uyO71c5
	 iIVMPJMNxeeJXQmlRxwVuZzKYZuhhlVOT0tasspqeBr8mdljw6+bYDfPyTP4i9xqDh
	 dY+SDSvcO6PwSR6SDcuFYIKWFbUMYa3WzVI0ZtVDPvPX/xT4m16pHKkV5ZjtK58vGr
	 FxKEYqFec57k0GcZI+Qrqeyz6gPDCbYDCJWJBA1jtxKwUl5dLHCkWUC2xPeQ/LrK1X
	 RZDQHc5Ct8UGA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hrHcd6Ldnz4w0Q;
	Fri, 25 Sep 2026 01:21:53 +1000 (AEST)
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
Subject: [PATCH v7 1/9] vfio/pci: Remove DMABUF export dependency on vdev->memory_lock
Date: Thu, 24 Sep 2026 16:21:44 +0100
Message-ID: <20260924152159.49702-2-matt@ozlabs.org>
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

The VFIO_DEVICE_FEATURE_DMA_BUF export previously used
vdev->memory_lock to protect VFIO's list of exported DMABUFs
(vdev->dmabufs) and their revocation status.  When adding a new
export, memory_lock was taken for write.

A future commit will refactor DMABUF export into a function used from
mmap(), which would create a new mmap_lock -> memory_lock dependency.

In preparation, this commit introduces a vdev->dmabuf_lock that
protects the dmabufs list, per-DMABUF revocation state, and a new
bars_revoked flag.  The flag tracks the device-wide BAR revocation
state set via vfio_pci_dma_buf_move() under dmabuf_lock, removing the
test of __vfio_pci_memory_enabled() and dependency on
vdev->memory_lock.

This is a cleanup currently, but allows the future export path to
avoid holding memory_lock under mmap_lock and a therefore avoid a
deadlock scenario (a fault handler attempting to take mmap_lock in a
vfio-pci variant driver thread that holds memory_lock, vs another
thread doing an mmap/export holding them both in the other order).

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/vfio/pci/vfio_pci_core.c   |  2 ++
 drivers/vfio/pci/vfio_pci_dmabuf.c | 30 +++++++++++++++++++++++++-----
 include/linux/vfio_pci_core.h      |  2 ++
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 6757054e9d87..1f6066107831 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -663,6 +663,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 		vdev->has_vga = true;
 
 	vfio_pci_core_map_bars(vdev);
+	vdev->bars_revoked = false;
 
 	return 0;
 
@@ -2197,6 +2198,7 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 		return ret;
 	INIT_LIST_HEAD(&vdev->dmabufs);
 	init_rwsem(&vdev->memory_lock);
+	init_rwsem(&vdev->dmabuf_lock);
 	xa_init(&vdev->ctx);
 
 	return 0;
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index c16f460c01d6..847ee5cc78e7 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -90,9 +90,9 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
 	 * The refcount prevents both.
 	 */
 	if (priv->vdev) {
-		down_write(&priv->vdev->memory_lock);
+		down_write(&priv->vdev->dmabuf_lock);
 		list_del_init(&priv->dmabufs_elm);
-		up_write(&priv->vdev->memory_lock);
+		up_write(&priv->vdev->dmabuf_lock);
 		vfio_device_put_registration(&priv->vdev->vdev);
 	}
 	kfree(priv->phys_vec);
@@ -305,12 +305,27 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 
 	/* dma_buf_put() now frees priv */
 	INIT_LIST_HEAD(&priv->dmabufs_elm);
-	down_write(&vdev->memory_lock);
+
+	/*
+	 * dmabuf_lock synchronises access (R) or updates (W) to the
+	 * vdev->dmabufs list and to bars_revoked (see below).  The
+	 * revocation state of DMABUF elements in the list is written
+	 * holding both dmabuf_lock(W) and resv, and tested with
+	 * either.
+	 *
+	 * dmabuf_lock -> resv
+	 *
+	 * vdev->bars_revoked tracks the BAR revocation status updated
+	 * via vfio_pci_dma_buf_move(), so the initial DMABUF state
+	 * follows the same criteria that later update the DMABUF
+	 * state (BAR zap, etc.).
+	 */
+	down_write(&vdev->dmabuf_lock);
 	dma_resv_lock(priv->dmabuf->resv, NULL);
-	priv->revoked = !__vfio_pci_memory_enabled(vdev);
+	priv->revoked = vdev->bars_revoked;
 	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
 	dma_resv_unlock(priv->dmabuf->resv);
-	up_write(&vdev->memory_lock);
+	up_write(&vdev->dmabuf_lock);
 
 	/*
 	 * dma_buf_fd() consumes the reference, when the file closes the dmabuf
@@ -340,6 +355,8 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
 
 	lockdep_assert_held_write(&vdev->memory_lock);
 
+	down_write(&vdev->dmabuf_lock);
+	vdev->bars_revoked = revoked;
 	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
 		if (!get_file_active(&priv->dmabuf->file))
 			continue;
@@ -375,6 +392,7 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
 		}
 		fput(priv->dmabuf->file);
 	}
+	up_write(&vdev->dmabuf_lock);
 }
 
 void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
@@ -393,6 +411,7 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
 	 */
 	vfio_pci_dma_buf_move(vdev, true);
 
+	down_write(&vdev->dmabuf_lock);
 	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
 		if (!get_file_active(&priv->dmabuf->file))
 			continue;
@@ -402,5 +421,6 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
 		vfio_device_put_registration(&vdev->vdev);
 		fput(priv->dmabuf->file);
 	}
+	up_write(&vdev->dmabuf_lock);
 	up_write(&vdev->memory_lock);
 }
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 9a1674c152aa..f99b152edcca 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -134,6 +134,7 @@ struct vfio_pci_core_device {
 	bool			pm_intx_masked;
 	bool			pm_runtime_engaged;
 	bool			sriov_active;
+	bool			bars_revoked;
 	struct pci_saved_state	*pci_saved_state;
 	struct pci_saved_state	*pm_save;
 	int			ioeventfds_nr;
@@ -148,6 +149,7 @@ struct vfio_pci_core_device {
 	struct vfio_pci_core_device	*sriov_pf_core_dev;
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
+	struct rw_semaphore	dmabuf_lock;
 	struct list_head	dmabufs;
 };
 
-- 
2.50.1 (Apple Git-155)

