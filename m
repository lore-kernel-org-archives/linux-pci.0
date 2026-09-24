Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9194A3841;
	Thu, 24 Sep 2026 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263376; cv=none; b=PbOSieDGDfvPuvWKLDvForSVYH7oU0C0uU6GRIL4jIcBA7Q01UeuladyAc7GuJ5QMV49J2M332g0FxWLIghkfr4kQRf3i3R/YpZLmenBp3FsevWTNW/sp9NqYbz1VZiBybuj8KN68e74eFjQlPYCuqtC/Xies2vi7QZpRHc8aGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263376; c=relaxed/simple;
	bh=7JL+qa9hNFD6qeX1TKpUtFfu6JzeJ/h5x20nAYGNF6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ey4QtQO5kCETekxSoPV4GV2UkZSqqngbKvUYwtyAc5toylW3l5eF4K640kF8E2fMk5IUkdPlUNBjBJ16bPOXqCuUzyZyn1vFOgkGUmn7Fcakzpi/LygYM/S9eDGysbxyMW9Cl1D0Az6ZcvsskHBTb8GM2KzVKo+s9UNvEueyWIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=NhybU7HI; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="NhybU7HI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1790263343;
	bh=0sagcOOLG7wQZUKq2hLO41gAkPP1PUX5/rGYV30dCd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NhybU7HIvQh5XUX8QY4wTtywMC9DMrsvYa74GIrt/RwmPE25j18vblOu5OhycDC4Q
	 a0Wn+7KHEX0Vh1SvBGHoSUJA+yivFOqucy5S2eIsn1P1efniKImpAq2XfydxoOV+fZ
	 0dYCfXaAciqMOoribcuqPkDzjIbE2dmo6CXLOv1plooklVUUDWHCff+xVdtMNuY6ze
	 0wrDFPKNt0gZopVvL1XpWyBoDTyfhGp7vbrgucs+X80RbgmI+jbfBsMcfnCOpChKoF
	 TS+Zk9RbVg+RzZy9iLA28P88uuBuygMphVPvFDu0qqCNvY3dwbOlw+J6xU1XaY3JFA
	 JC3EJlazx5n7A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hrHdB68HKz4w9T;
	Fri, 25 Sep 2026 01:22:22 +1000 (AEST)
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
Subject: [PATCH v7 7/9] vfio/pci: Clean up BAR zap and revocation
Date: Thu, 24 Sep 2026 16:21:50 +0100
Message-ID: <20260924152159.49702-8-matt@ozlabs.org>
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

Previously, vfio_pci_zap_bars() (and the wrapper
vfio_pci_zap_and_down_write_memory_lock()) calls were paired with
calls to vfio_pci_dma_buf_move().

This commit replaces them with a unified new function,
vfio_pci_revoke_bars() containing both the vfio_pci_dma_buf_move() and
the unmap_mapping_range(), making it harder for callers to omit one.
It adds a wrapper, vfio_pci_lock_revoke_bars(), which takes the write
memory_lock before zapping, and adds a new vfio_pci_unrevoke_bars()
for the re-enable path.

As of "vfio/pci: Convert BAR mmap() to use a DMABUF", the zap via
unmap_mapping_range() is no longer performed for vfio-pci since the
DMABUFs used for BAR mappings already zap PTEs when the
vfio_pci_dma_buf_move() occurs.

However, it must be assumed that VFIO drivers which override the .mmap
op could create mappings _not_ backed by DMABUFs.  So, the zap is
still performed on revoke if .mmap is overridden, using a new
zap_bars_on_revoke flag.  A driver can explicitly opt out; the flag is
cleared by the hisi_acc_vfio_pci driver, since its .mmap just wraps
vfio_pci_core_mmap() and so still uses DMABUFs.

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 14 +++-
 drivers/vfio/pci/vfio_pci_config.c            | 30 +++-----
 drivers/vfio/pci/vfio_pci_core.c              | 75 +++++++++++++------
 drivers/vfio/pci/vfio_pci_priv.h              |  3 +-
 include/linux/vfio_pci_core.h                 |  1 +
 5 files changed, 82 insertions(+), 41 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 86362ec424a5..14622556355e 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1564,6 +1564,7 @@ static int hisi_acc_vfio_pci_migrn_init_dev(struct vfio_device *core_vdev)
 	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
 	struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
 	struct hisi_qm *pf_qm = hisi_acc_get_pf_qm(pdev);
+	int ret;
 
 	hisi_acc_vdev->vf_id = pci_iov_vf_id(pdev) + 1;
 	hisi_acc_vdev->pf_qm = pf_qm;
@@ -1575,7 +1576,18 @@ static int hisi_acc_vfio_pci_migrn_init_dev(struct vfio_device *core_vdev)
 	core_vdev->migration_flags = VFIO_MIGRATION_STOP_COPY | VFIO_MIGRATION_PRE_COPY;
 	core_vdev->mig_ops = &hisi_acc_vfio_pci_migrn_state_ops;
 
-	return vfio_pci_core_init_dev(core_vdev);
+	ret = vfio_pci_core_init_dev(core_vdev);
+	if (ret)
+		return ret;
+	/*
+	 * hisi_acc_vfio_pci_mmap() calls down to
+	 * vfio_pci_core_mmap(), so BAR mappings are still
+	 * DMABUF-backed.  They don't require a zap on revoke, so opt
+	 * out:
+	 */
+	hisi_acc_vdev->core_device.zap_bars_on_revoke = false;
+
+	return 0;
 }
 
 static const struct vfio_device_ops hisi_acc_vfio_pci_migrn_ops = {
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 9914f3ac69ae..cef337f4e8f2 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -590,12 +590,10 @@ static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
 		virt_mem = !!(le16_to_cpu(*virt_cmd) & PCI_COMMAND_MEMORY);
 		new_mem = !!(new_cmd & PCI_COMMAND_MEMORY);
 
-		if (!new_mem) {
-			vfio_pci_zap_and_down_write_memory_lock(vdev);
-			vfio_pci_dma_buf_move(vdev, true);
-		} else {
+		if (!new_mem)
+			vfio_pci_lock_revoke_bars(vdev);
+		else
 			down_write(&vdev->memory_lock);
-		}
 
 		/*
 		 * If the user is writing mem/io enable (new_mem/io) and we
@@ -631,7 +629,7 @@ static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
 		*virt_cmd |= cpu_to_le16(new_cmd & mask);
 
 		if (__vfio_pci_memory_enabled(vdev))
-			vfio_pci_dma_buf_move(vdev, false);
+			vfio_pci_unrevoke_bars(vdev);
 		up_write(&vdev->memory_lock);
 	}
 
@@ -712,16 +710,14 @@ static int __init init_pci_cap_basic_perm(struct perm_bits *perm)
 static void vfio_lock_and_set_power_state(struct vfio_pci_core_device *vdev,
 					  pci_power_t state)
 {
-	if (state >= PCI_D3hot) {
-		vfio_pci_zap_and_down_write_memory_lock(vdev);
-		vfio_pci_dma_buf_move(vdev, true);
-	} else {
+	if (state >= PCI_D3hot)
+		vfio_pci_lock_revoke_bars(vdev);
+	else
 		down_write(&vdev->memory_lock);
-	}
 
 	vfio_pci_set_power_state(vdev, state);
 	if (__vfio_pci_memory_enabled(vdev))
-		vfio_pci_dma_buf_move(vdev, false);
+		vfio_pci_unrevoke_bars(vdev);
 	up_write(&vdev->memory_lock);
 }
 
@@ -908,11 +904,10 @@ static int vfio_exp_config_write(struct vfio_pci_core_device *vdev, int pos,
 						 &cap);
 
 		if (!ret && (cap & PCI_EXP_DEVCAP_FLR)) {
-			vfio_pci_zap_and_down_write_memory_lock(vdev);
-			vfio_pci_dma_buf_move(vdev, true);
+			vfio_pci_lock_revoke_bars(vdev);
 			pci_try_reset_function(vdev->pdev);
 			if (__vfio_pci_memory_enabled(vdev))
-				vfio_pci_dma_buf_move(vdev, false);
+				vfio_pci_unrevoke_bars(vdev);
 			up_write(&vdev->memory_lock);
 		}
 	}
@@ -993,11 +988,10 @@ static int vfio_af_config_write(struct vfio_pci_core_device *vdev, int pos,
 						&cap);
 
 		if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_TP)) {
-			vfio_pci_zap_and_down_write_memory_lock(vdev);
-			vfio_pci_dma_buf_move(vdev, true);
+			vfio_pci_lock_revoke_bars(vdev);
 			pci_try_reset_function(vdev->pdev);
 			if (__vfio_pci_memory_enabled(vdev))
-				vfio_pci_dma_buf_move(vdev, false);
+				vfio_pci_unrevoke_bars(vdev);
 			up_write(&vdev->memory_lock);
 		}
 	}
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index cb0e4865d110..986852b1d44f 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -376,8 +376,7 @@ static int vfio_pci_runtime_pm_entry(struct vfio_pci_core_device *vdev,
 	 * The vdev power related flags are protected with 'memory_lock'
 	 * semaphore.
 	 */
-	vfio_pci_zap_and_down_write_memory_lock(vdev);
-	vfio_pci_dma_buf_move(vdev, true);
+	vfio_pci_lock_revoke_bars(vdev);
 
 	if (vdev->pm_runtime_engaged) {
 		up_write(&vdev->memory_lock);
@@ -463,7 +462,7 @@ static void vfio_pci_runtime_pm_exit(struct vfio_pci_core_device *vdev)
 	down_write(&vdev->memory_lock);
 	__vfio_pci_runtime_pm_exit(vdev);
 	if (__vfio_pci_memory_enabled(vdev))
-		vfio_pci_dma_buf_move(vdev, false);
+		vfio_pci_unrevoke_bars(vdev);
 	up_write(&vdev->memory_lock);
 }
 
@@ -532,7 +531,7 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
 		vdev->pm_wake_eventfd_ctx = NULL;
 		__vfio_pci_runtime_pm_exit(vdev);
 		if (__vfio_pci_memory_enabled(vdev))
-			vfio_pci_dma_buf_move(vdev, false);
+			vfio_pci_unrevoke_bars(vdev);
 		eventfd_signal(ctx);
 		eventfd_ctx_put(ctx);
 	}
@@ -1319,6 +1318,8 @@ static int vfio_pci_ioctl_set_irqs(struct vfio_pci_core_device *vdev,
 	return ret;
 }
 
+static void vfio_pci_revoke_bars(struct vfio_pci_core_device *vdev);
+
 static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
 				void __user *arg)
 {
@@ -1327,7 +1328,7 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
 	if (!vdev->reset_works)
 		return -EINVAL;
 
-	vfio_pci_zap_and_down_write_memory_lock(vdev);
+	down_write(&vdev->memory_lock);
 
 	/*
 	 * This function can be invoked while the power state is non-D0. If
@@ -1337,13 +1338,18 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
 	 * have NoSoftRst-, the reset function can cause the PCI config space
 	 * reset without restoring the original state (saved locally in
 	 * 'vdev->pm_save').
+	 *
+	 * The zap is done after making the device accessible in D0,
+	 * because a DMABUF importer could access the device as part
+	 * of its revocation cleanup.
 	 */
 	vfio_pci_set_power_state(vdev, PCI_D0);
 
-	vfio_pci_dma_buf_move(vdev, true);
+	vfio_pci_revoke_bars(vdev);
+
 	ret = pci_try_reset_function(vdev->pdev);
 	if (__vfio_pci_memory_enabled(vdev))
-		vfio_pci_dma_buf_move(vdev, false);
+		vfio_pci_unrevoke_bars(vdev);
 	up_write(&vdev->memory_lock);
 
 	return ret;
@@ -1713,20 +1719,37 @@ ssize_t vfio_pci_core_write(struct vfio_device *core_vdev, const char __user *bu
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_write);
 
-static void vfio_pci_zap_bars(struct vfio_pci_core_device *vdev)
+static void vfio_pci_revoke_bars(struct vfio_pci_core_device *vdev)
 {
-	struct vfio_device *core_vdev = &vdev->vdev;
-	loff_t start = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_BAR0_REGION_INDEX);
-	loff_t end = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_ROM_REGION_INDEX);
-	loff_t len = end - start;
+	lockdep_assert_held_write(&vdev->memory_lock);
+	vfio_pci_dma_buf_move(vdev, true);
 
-	unmap_mapping_range(core_vdev->inode->i_mapping, start, len, true);
+	/*
+	 * If a driver could possibly create BAR mappings in the
+	 * vdev's address_space, do an additional zap on revoke.  See
+	 * vfio_pci_core_init_dev().
+	 */
+	if (vdev->zap_bars_on_revoke) {
+		struct vfio_device *core_vdev = &vdev->vdev;
+		loff_t start = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_BAR0_REGION_INDEX);
+		loff_t end = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_ROM_REGION_INDEX);
+		loff_t len = end - start;
+
+		unmap_mapping_range(core_vdev->inode->i_mapping,
+				    start, len, true);
+	}
 }
 
-void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev)
+void vfio_pci_lock_revoke_bars(struct vfio_pci_core_device *vdev)
 {
 	down_write(&vdev->memory_lock);
-	vfio_pci_zap_bars(vdev);
+	vfio_pci_revoke_bars(vdev);
+}
+
+void vfio_pci_unrevoke_bars(struct vfio_pci_core_device *vdev)
+{
+	lockdep_assert_held_write(&vdev->memory_lock);
+	vfio_pci_dma_buf_move(vdev, false);
 }
 
 u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev)
@@ -2224,6 +2247,16 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 	init_rwsem(&vdev->dmabuf_lock);
 	xa_init(&vdev->ctx);
 
+	/*
+	 * If a driver overrides .mmap, it has to be assumed that it
+	 * might not use the DMABUF-backed core mmap; this flag
+	 * enables a zap at revoke time.  A driver can opt out by
+	 * clearing this flag at init, if their .mmap override calls
+	 * down to vfio_pci_core_mmap().
+	 */
+	if (vdev->vdev.ops->mmap != vfio_pci_core_mmap)
+		vdev->zap_bars_on_revoke = true;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_init_dev);
@@ -2591,9 +2624,10 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 		}
 
 		/*
-		 * Take the memory write lock for each device and zap BAR
-		 * mappings to prevent the user accessing the device while in
-		 * reset.  Locking multiple devices is prone to deadlock,
+		 * Take the memory write lock for each device and
+		 * zap/revoke BAR mappings to prevent the user (or
+		 * peers) accessing the device while in reset.
+		 * Locking multiple devices is prone to deadlock,
 		 * runaway and unwind if we hit contention.
 		 */
 		if (!down_write_trylock(&vdev->memory_lock)) {
@@ -2601,8 +2635,7 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 			break;
 		}
 
-		vfio_pci_dma_buf_move(vdev, true);
-		vfio_pci_zap_bars(vdev);
+		vfio_pci_revoke_bars(vdev);
 	}
 
 	if (!list_entry_is_head(vdev,
@@ -2632,7 +2665,7 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 	list_for_each_entry_from_reverse(vdev, &dev_set->device_list,
 					 vdev.dev_set_list) {
 		if (vdev->vdev.open_count && __vfio_pci_memory_enabled(vdev))
-			vfio_pci_dma_buf_move(vdev, false);
+			vfio_pci_unrevoke_bars(vdev);
 		up_write(&vdev->memory_lock);
 	}
 
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index ef6aabb9f5a4..f11b31f8953c 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -83,7 +83,8 @@ void vfio_config_free(struct vfio_pci_core_device *vdev);
 int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev,
 			     pci_power_t state);
 
-void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev);
+void vfio_pci_lock_revoke_bars(struct vfio_pci_core_device *vdev);
+void vfio_pci_unrevoke_bars(struct vfio_pci_core_device *vdev);
 u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev);
 void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev,
 					u16 cmd);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index f99b152edcca..44891fdb7c76 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -129,6 +129,7 @@ struct vfio_pci_core_device {
 	bool			disable_idle_d3:1;
 	bool			nointxmask:1;
 	bool			disable_vga:1;
+	bool			zap_bars_on_revoke:1;
 	/* Flags modified at runtime - dedicated storage unit */
 	bool			needs_reset;
 	bool			pm_intx_masked;
-- 
2.50.1 (Apple Git-155)

