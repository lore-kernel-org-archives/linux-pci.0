Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDB039E9D6;
	Wed, 10 Jun 2026 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106306; cv=none; b=bne0Ji6U4DpAVctQCvbt7TkPxnM/ltZcs4LPM/Xbx2FSTjxreOapQgqZcNLvsQmsc3rho7a1ST428VEEIIh8IuLnIQ04q1guL6Anj6RFvm/MQLgsHQ+jmLUB0Z+U8yIQsMSenPc7j+dJyqjjYoybIW58aBk8yLv6XnY73Sx6zDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106306; c=relaxed/simple;
	bh=OTkUa/zGo32ZAgcw3U58zpcSoiBQxlo+aFvyuJ7oHSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oL65+WltcjFSrM0GcxQxGEUqC6JjXcApxL9EaGY1SLN2/yC0LurMUtFfti7jv9sP5EGOmuOx6Jg8pQobvCoBLLXykQlsVMZMSvc2XGiXnCNBybmPIjHrUnLdQASpk/KnxY3/Cdpm8XQen/40hhx0uqjFJQ7u4wfDscHg7KeAoPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=Y+ffWGv8; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="Y+ffWGv8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1781106303;
	bh=Y5kBW1vxNXDE6JRXBcV0sBowQzBU5fXbOfu7RYwBVRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+ffWGv868slujFWV5zuulzhwGAZ1Q7EKf6Y6XNIJbaFt1u9yxffsBQ39HrQOX6+c
	 KsDoBkSz4VxRFqLvhhuV4gGj90D10geNMa8k7tLgPDrOIEc/IolNDUEdkBnRBaVhFG
	 oRXzTmhY8M2JapiGu8m9qjM7omF2pIK5F2vrNATXUQB5zW/jTOR3IsSSletWuLG3uR
	 xX68poepfetCcscEVEgOSHevmtBSLBkknXbeZ+iYcv5lFPegkC1bQMpVul48HXICAI
	 6bQBnf4PWaIN5phsfoB4KWtEKTiDS3oQr6/+0VG1YMTgNe60pPaDeE3yRN4loTWdGE
	 ycrpjf7MGkCYw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4gb98G16N4z4x98;
	Thu, 11 Jun 2026 01:45:01 +1000 (AEST)
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
Subject: [PATCH v3 9/9] vfio/pci: Add mmap() attributes to DMABUF feature
Date: Wed, 10 Jun 2026 16:43:23 +0100
Message-ID: <20260610154327.37758-10-matt@ozlabs.org>
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

A new VFIO feature, VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR, is added to
set CPU-facing memory type attributes for a DMABUF exported from
vfio-pci.  These are used for subsequent mmap()s of the buffer.

There are two attributes supported:
 - The default, VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_NC
 - VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_WC, which results in WC
   PTEs for the DMABUF's BAR region.

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/vfio/pci/vfio_pci_core.c   |  2 ++
 drivers/vfio/pci/vfio_pci_dmabuf.c | 57 +++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h   | 14 ++++++++
 include/uapi/linux/vfio.h          | 27 ++++++++++++++
 4 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 064906b25467..dc9c6f479e2c 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1575,6 +1575,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_DMA_BUF_REVOKE:
 		return vfio_pci_core_feature_dma_buf_revoke(vdev, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR:
+		return vfio_pci_core_feature_dma_buf_memattr(vdev, flags, arg, argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index b47411992ab6..58b769e65ab8 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -51,7 +51,10 @@ static int vfio_pci_dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *
 	 * contained within the DMABUF size before calling this.
 	 */
 
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	if (READ_ONCE(priv->memattr) == VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_WC)
+		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	else
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
 
 	/* See comments in vfio_pci_core_mmap() re VM_ALLOW_ANY_UNCACHED. */
@@ -468,6 +471,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	priv->vdev = vdev;
 	priv->nr_ranges = get_dma_buf.nr_ranges;
 	priv->size = length;
+	priv->memattr = VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_NC;
 	ret = vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
 					     get_dma_buf.region_index,
 					     priv->phys_vec, dma_ranges,
@@ -755,6 +759,57 @@ int vfio_pci_core_feature_dma_buf_revoke(
 		}
 	}
 
+out_put_buf:
+	dma_buf_put(dmabuf);
+
+	return ret;
+}
+
+int vfio_pci_core_feature_dma_buf_memattr(
+	struct vfio_pci_core_device *vdev, u32 flags,
+	struct vfio_device_feature_dma_buf_memattr __user *arg,
+	size_t argsz)
+{
+	struct vfio_device_feature_dma_buf_memattr db_attr;
+	struct vfio_pci_dma_buf *priv;
+	struct dma_buf *dmabuf;
+	int ret;
+
+	if (!vdev->pci_ops || !vdev->pci_ops->get_dmabuf_phys)
+		return -EOPNOTSUPP;
+
+	ret = vfio_check_feature(flags, argsz,
+				 VFIO_DEVICE_FEATURE_SET,
+				 sizeof(db_attr));
+	if (ret != 1)
+		return ret;
+
+	if (copy_from_user(&db_attr, arg, sizeof(db_attr)))
+		return -EFAULT;
+
+	dmabuf = dma_buf_get(db_attr.dmabuf_fd);
+	if (IS_ERR(dmabuf))
+		return PTR_ERR(dmabuf);
+
+	/* Verify DMABUF: see comments in vfio_pci_dma_buf_revoke() */
+	priv = dmabuf->priv;
+	if (dmabuf->ops != &vfio_pci_dmabuf_ops ||
+	    READ_ONCE(priv->vdev) != vdev) {
+		ret = -ENODEV;
+		goto out_put_buf;
+	}
+
+	switch (db_attr.memattr) {
+	case VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_NC:
+	case VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_WC:
+		WRITE_ONCE(priv->memattr, db_attr.memattr);
+		ret = 0;
+		break;
+
+	default:
+		ret = -ENOENT;
+	}
+
 out_put_buf:
 	dma_buf_put(dmabuf);
 
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 3c2f2575b670..3ec8b62194f3 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -41,6 +41,7 @@ struct vfio_pci_dma_buf {
 	struct kref kref;
 	struct completion comp;
 	unsigned long vma_pgoff_adjust;
+	u32 memattr;
 	enum vfio_pci_dma_buf_status status;
 };
 
@@ -158,6 +159,10 @@ int vfio_pci_core_feature_dma_buf_revoke(
 	struct vfio_pci_core_device *vdev, u32 flags,
 	struct vfio_device_feature_dma_buf_revoke __user *arg,
 	size_t argsz);
+int vfio_pci_core_feature_dma_buf_memattr(
+	struct vfio_pci_core_device *vdev, u32 flags,
+	struct vfio_device_feature_dma_buf_memattr __user *arg,
+	size_t argsz);
 #else
 static inline int
 vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
@@ -166,6 +171,7 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 {
 	return -ENOTTY;
 }
+
 static inline int vfio_pci_core_feature_dma_buf_revoke(
 	struct vfio_pci_core_device *vdev, u32 flags,
 	struct vfio_device_feature_dma_buf_revoke __user *arg,
@@ -173,6 +179,14 @@ static inline int vfio_pci_core_feature_dma_buf_revoke(
 {
 	return -ENOTTY;
 }
+
+static inline int vfio_pci_core_feature_dma_buf_memattr(
+	struct vfio_pci_core_device *vdev, u32 flags,
+	struct vfio_device_feature_dma_buf_memattr __user *arg,
+	size_t argsz)
+{
+	return -ENOTTY;
+}
 #endif
 
 #endif
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 697c0bb4b9bc..ab30b89399d0 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1554,6 +1554,33 @@ struct vfio_device_feature_dma_buf_revoke {
 	__s32	dmabuf_fd;
 };
 
+/**
+ * Given a dma_buf fd previously created by
+ * VFIO_DEVICE_FEATURE_DMA_BUF, SET the memory attribute that will be
+ * used by future mmap()s of that fd.  SETting a new attribute does
+ * not affect existing VMAs.
+ *
+ * The default, if no previous SET has been performed, is NC.
+ *
+ * Return: 0 on success, -1 and errno is set on failure:
+ *
+ *  EBADF, EINVAL: dmabuf_fd is not a DMABUF fd.
+ *  ENODEV: The dmabuf_fd does not match this VFIO device.
+ *  ENOENT: The given memattr is not supported.
+ */
+#define VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR 14
+
+/* Valid memory attributes for the memattr field */
+enum vfio_device_dma_buf_memattr {
+	VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_NC = 0, /* pgprot_noncached */
+	VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_WC = 1, /* pgprot_writecombine */
+};
+
+struct vfio_device_feature_dma_buf_memattr {
+	__s32	dmabuf_fd;
+	__u32	memattr;
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.50.1 (Apple Git-155)

