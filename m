Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521A947AF61
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869473; cv=none; b=ZrMo010fnGY0aFww0q3yEqj9ZGFjK0oA1EmS1zbKnIB3ubb8f1Wo21r9MQpU0dOldf6h+nMkWZoGvOZFj9iH8CRPEJzbcMPQHSmIvgidSUGHcKHoD79Ei42K4iLdwo8TVKmHRewCO7nHrPhtMb5LQUUPs9tAAo5Kvr/vlB5g3Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869473; c=relaxed/simple;
	bh=Ou2tVB8Q+yupGdPWWOxQVJQIDcQOWDiehp4QhnvMwYM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mXh1vMPtvyafTTy73kDPJKR51gFcYJbkJ0iP+0X39I2qKN4ZA0Dg1jmtNF6ktb3PdX+h1/Frq0RAOWEFBNQcWKFnpYcXHSPtDp8e7dUqnFbgkNMy3W9ojvODZSMYvOW5R9/2uTSETG4fHnZkF3roGt4RRLI/WfuibF4GxEWCkog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EZk8IF3l; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EZk8IF3l"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f283baf1fso117300a91.3
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 11:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785869470; x=1786474270; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ZHDS1bDmePexnQc1y4ZiUVE4FDmrL6+107/+IDkhio=;
        b=EZk8IF3lvbdgyFJPcGORW1dKC4H6zHlGDXLxK+uRUsjW/oM/JwSkIfjBnYJ5H7a7gf
         lKKLPrhwDl46kofSqo0xRG/3khDXS7LYdo5JJrY/zNoR8B6XYrSb+ElPS/P7qHCidvT4
         LwGV2yBRGXg8Xh+1FYI/VfkDBneMzKbg3yq6cZzwKda6MWX08/UBNYfbI+VoZzxx4GAA
         0a4kjHvxpryqoVTOoJ5a1KWqdU+1aUMq6rMFyco5LqXhyo5LH9eUcwuqo0nGCFKt1SUa
         wO4zVWd01lhnow11FuE+w6G/AN0ZnoG+gb3bh5Ey2yw4SbA7XB9MqQGD+8xjtN2iaKxR
         26og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869470; x=1786474270;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ZHDS1bDmePexnQc1y4ZiUVE4FDmrL6+107/+IDkhio=;
        b=L2CzzCulhj8JyREcdy34p6CbRfO4S7s02Oa6XdESGUkMLQSltAC6+f2/kDiKR+44iD
         FwKWc/7ern0fnYckdwKEq4eIo9YHapSW+x54+xtb/UAegz7/ZmHLNqBSD3naiAz7Kgus
         3r1MSsoRILfqbhTrmdj3M1Atrp92pNKz9dDmfepgYgsB8oycEfUY3QEzVuzDmhjMUSbD
         AqvnY80MSWd6tsfhl51Pm/l7yz5jNrcqj2QFU9Bv2924OLpSaqCUTaBecKB8aHJqaZlc
         YlJipm1pJ+nGNk8zd3EB2GmGpJWwahKheRU3Wg61aU2xxUWTvqrxdknnuhgubzzHj2jt
         lhLw==
X-Gm-Message-State: AOJu0YzIDwyiqhxv7DP26/Q1LcM64iA3zAFv84FZ8FYoRBLjdy+YP8Rg
	d5mqB+hutmvIahfbgngcI1YBQUt97QfpinBfr24pdvu414o4Ki+bYUIzaiIMt8SRX2Syh0zTWOI
	VcZ0PaXmKKvY3woGWh1GtySvksZZgaxXb7fSv1aE1Ejt1h9OxDqqGNLm6/TlEB1ahDgBfzNZoSw
	e6w8LnFbfqGLspBsyIooPIo6VT4r1g9VvbNk0=
X-Received: from dlec14-n2.prod.google.com ([2002:a05:701b:428e:20b0:13d:2d28:797d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:55c7:b0:383:f52b:d616
 with SMTP id 98e67ed59e1d1-3903c592495mr940815a91.10.1785869469975; Tue, 04
 Aug 2026 11:51:09 -0700 (PDT)
Date: Tue,  4 Aug 2026 18:50:47 +0000
In-Reply-To: <20260804185050.2053672-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804185050.2053672-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804185050.2053672-3-praan@google.com>
Subject: [RFC PATCH v2 2/5] vfio/pci: Implement ZONE_DEVICE registration for DMABUFs
From: Pranjal Shrivastava <praan@google.com>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Pranjal Shrivastava <praan@google.com>, Ankit Agrawal <ankita@nvidia.com>, Matt Evans <mattev@meta.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Shivaji Kant <shivajikant@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Unnati Sachan <unnatisachan@google.com>
Content-Type: text/plain; charset="UTF-8"

When a DMABUF is requested with the VFIO_DMA_BUF_FLAG_ZONE_DEVICE_BACKED
flag is requested during DMABUF export, invoke pci_p2pdma_add_resource()
to register the target BAR with the ZONE_DEVICE framework. This allocates
the underlying struct page metadata. Add internal state tracking for
ZONE_DEVICE-backed DMABUF exports. Add p2p_struct_page_bars, a bitmask to
track PCI BARs that have been registered. Add a zone_device_backed flag
to track whether a specific DMABUF contains page-backed memory.

Introduce a new Kconfig option, VFIO_PCI_DMABUF_ZONE_DEVICE to handle
the dependency on PCI_P2PDMA without clobbering existing dependencies.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/vfio/pci/Kconfig           | 11 ++++++
 drivers/vfio/pci/vfio_pci_dmabuf.c | 55 +++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h   |  1 +
 include/linux/vfio_pci_core.h      |  1 +
 4 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 67a2ae1fbc04..c9cd04a16297 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -61,6 +61,17 @@ config VFIO_PCI_DMABUF
 	def_bool y if PCI_P2PDMA
 	depends on VFIO_PCI_CORE
 
+config VFIO_PCI_DMABUF_ZONE_DEVICE
+	bool "VFIO PCI DMABUF ZONE_DEVICE page-backed export support"
+	depends on VFIO_PCI_DMABUF
+	depends on PCI_P2PDMA
+	help
+	  Say Y here to enable optional struct page backing (ZONE_DEVICE)
+	  for VFIO exported DMABUFs. This is required to support peer-to-peer
+	  (P2P) DMA transactions with subsystems that rely on page metadata.
+
+	  If unsure, say N.
+
 source "drivers/vfio/pci/mlx5/Kconfig"
 
 source "drivers/vfio/pci/ism/Kconfig"
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index 36bf07530840..900ac1851c9f 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -427,6 +427,41 @@ static int validate_dmabuf_input(struct vfio_device_feature_dma_buf *dma_buf,
 	return 0;
 }
 
+#ifdef CONFIG_VFIO_PCI_DMABUF_ZONE_DEVICE
+static int vfio_pci_dma_buf_alloc_struct_pages(struct vfio_pci_core_device *vdev,
+					       struct vfio_device_feature_dma_buf *dma_buf)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	u32 bar_index = dma_buf->region_index;
+	int ret;
+
+	if (vdev->p2p_struct_page_bars & (1 << bar_index))
+		return 0;
+
+	/*
+	 * Allocate vmemmap (struct pages) for the ENTIRE BAR, even if the
+	 * specific DMABUF only exports a partial slice of it. This prevents
+	 * vmemmap fragmentation and ensures that any subsequent slice exports
+	 * from the same BAR get struct page backing instantly.
+	 */
+	ret = pci_p2pdma_add_resource(pdev, bar_index, 0, 0);
+	if (ret) {
+		if (ret != -EEXIST)
+			return ret;
+	}
+
+	vdev->p2p_struct_page_bars |= (1 << bar_index);
+
+	return 0;
+}
+#else
+static inline int vfio_pci_dma_buf_alloc_struct_pages(struct vfio_pci_core_device *vdev,
+						      struct vfio_device_feature_dma_buf *dma_buf)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 				  struct vfio_device_feature_dma_buf __user *arg,
 				  size_t argsz)
@@ -448,7 +483,8 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	if (copy_from_user(&get_dma_buf, arg, sizeof(get_dma_buf)))
 		return -EFAULT;
 
-	if (!get_dma_buf.nr_ranges || get_dma_buf.flags)
+	if (!get_dma_buf.nr_ranges ||
+	    (get_dma_buf.flags & ~VFIO_DMA_BUF_FLAG_ZONE_DEVICE_BACKED))
 		return -EINVAL;
 
 	/*
@@ -468,6 +504,21 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	if (ret)
 		goto err_free_ranges;
 
+	if (get_dma_buf.flags & VFIO_DMA_BUF_FLAG_ZONE_DEVICE_BACKED) {
+		/*
+		 * Serialize the allocation and the page initialization.
+		 * Holding the memory_lock here prevents a race where a
+		 * concurrent ioctl bypasses the allocation + init, handing
+		 * a DMABUF to the user before the ZONE_DEVICE registration
+		 * is completed successfully.
+		 */
+		down_write(&vdev->memory_lock);
+		ret = vfio_pci_dma_buf_alloc_struct_pages(vdev, &get_dma_buf);
+		up_write(&vdev->memory_lock);
+		if (ret)
+			goto err_free_ranges;
+	}
+
 	priv = kzalloc_obj(*priv);
 	if (!priv) {
 		ret = -ENOMEM;
@@ -480,6 +531,8 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	}
 
 	priv->vdev = vdev;
+	if (get_dma_buf.flags & VFIO_DMA_BUF_FLAG_ZONE_DEVICE_BACKED)
+		priv->zone_device_backed = 1;
 	priv->nr_ranges = get_dma_buf.nr_ranges;
 	priv->size = length;
 	ret = vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 8741abd04461..d0bf5c118793 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -42,6 +42,7 @@ struct vfio_pci_dma_buf {
 	struct completion comp;
 	unsigned long vma_pgoff_adjust;
 	enum vfio_pci_dma_buf_status status;
+	u8 zone_device_backed : 1;
 };
 
 bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index e2b4252e7c3f..c28f06bae302 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -135,6 +135,7 @@ struct vfio_pci_core_device {
 	bool			pm_runtime_engaged;
 	bool			sriov_active;
 	bool			zap_bars_on_revoke;
+	u8			p2p_struct_page_bars;
 	struct pci_saved_state	*pci_saved_state;
 	struct pci_saved_state	*pm_save;
 	int			ioeventfds_nr;
-- 
2.55.0.571.g244d577d93-goog

