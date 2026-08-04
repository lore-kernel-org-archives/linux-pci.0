Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E304746DA
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869480; cv=none; b=XBVGZp6RfVa+HQLgRkCJS/zFHGddYl8UbgWmUquwggxmrnS52KgJKWwtkHI9n9n/SsmNKmq6IhPs6HAZQw3B2l4kkVxpJsW4LAmAYmiWzQOTADpOA5Ur7zXnI1CnqAmUzIfHTdnANmFLHo/IqlhGXGPWqLMchmBUJzS7+2rg6qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869480; c=relaxed/simple;
	bh=OaugovGo8M5rh58RDPkwKXsvwT8IoPdNluV2OPhfr0s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gjw4sZtLbvpB+2T4wSn0jtdtsxuwZH9vp31Z8s2AGjrqlZzWk3mxlsHnh54SrzOmewFFog8ML5/qBX5Kj08Lhar0Szol9TiSiPBv5pVAB94h0EG3xkhcgMNU2UH8Iz8EBNMFVELR+pNVQkQeF2d/dCW0XmOkv0WzUpwrbU3Y290=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fZ68KxaO; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fZ68KxaO"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d001671a54so2940035ad.2
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 11:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785869478; x=1786474278; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Bk0wJpGkJMlNuWfWqjZwkLVn4Nu2iokWTbQfTLl/80=;
        b=fZ68KxaOm5tZu/cbwRjC14KtHWg7rYobIAq3Th8H8Zt19sbeCPeR+a0Fb4ZY2AUc/O
         h7mhpyQ+nw6iBRsED423veUEQijZZMwVLsajMgeoeBNKmH4OGfZnLAlSX+JLU9fO0XjR
         lVZlglu6Mt+59Ie7/qbHngARlmHfRGrI0PjHy1uZqmVmneyeWRtpNFSkitFJqswICxqj
         LAFzf/VtTvO8ztQ3zyrj43Wo5RvMcxqB6OaHw20XX2B+0O6wgHioo/BCkVHJY4mZVu0c
         GGLgtN6yMeWFSegZS5TGXE0ElOuvPFxrwVgfbZiq4sk/BuFoaphSFJzBVZjAKN37W/bg
         iNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869478; x=1786474278;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Bk0wJpGkJMlNuWfWqjZwkLVn4Nu2iokWTbQfTLl/80=;
        b=AG3jeXZUS1s5X7EJECU6uASvzNTzuN+ovz2GZKmki4Like22V0xeA8BCWkX1O36WMZ
         6f5y8UsiV4aBpTw5NRSEist86f3882AJnQdppErg9PI6RqqxeZqDfmwvwaODOG17k0eJ
         HczxiuRc3AOLMWvNg+Rs8h0fcHsY/SJ0JUWHJ0YkWqFbnyshVHceifPeS35hkeuoJnJy
         9eNVZb99fRi0I4jBP4qrmIo4jze4m+TGO99vskUBBC107xkesBQ5r1NJEEuRbvmTlHb9
         SMiJCsY9sTq20QQxUAARUsfz0qxtsw2rVSIWmKkfpJbxCw+4nLL8wScDTvLDF+/nupwm
         L0jA==
X-Gm-Message-State: AOJu0YwQJ2ngw5jFtZugVOpy6vQQQuuUMyX8df2G7IymOr59X0rhSwMN
	wTj0fkaq5/jCUylXAUleFPp3x5L+tumMZu7pjrMqqoMAQBvhFXoTEy6G9f/VH3OaOprq4VkB0pc
	w1d3PqSn5RjkYa0j5XBhAmESc2T5VrO3NQRJfhHnYw+ghm/hXqqUcMThoGuasuDBgCSzsX1d2G/
	2EEJyPoCFYN7hc0ehbDtOPRuz1qCQDCfeZu6M=
X-Received: from pljs12.prod.google.com ([2002:a17:903:3bac:b0:2cc:61be:8bbb])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da82:b0:2cf:7bfe:6043
 with SMTP id d9443c01a7336-2d0ca949b71mr6594885ad.19.1785869477691; Tue, 04
 Aug 2026 11:51:17 -0700 (PDT)
Date: Tue,  4 Aug 2026 18:50:50 +0000
In-Reply-To: <20260804185050.2053672-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804185050.2053672-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804185050.2053672-6-praan@google.com>
Subject: [RFC PATCH v2 5/5] vfio/pci: Add revocation fence for ZONE_DEVICE DMABUFs
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

Implement a synchronization fence to safely revoke ZONE_DEVICE-backed
DMABUFs. Introduce a fence in vfio_pci_dma_buf_set_status(). The fence
waits for all struct page refcounts to drop to 1.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 55 ++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index b582e856ba7a..b4284b5cad03 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -4,6 +4,7 @@
 #include <linux/dma-buf-mapping.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/dma-resv.h>
+#include <linux/iopoll.h>
 #include <linux/sched.h>
 #include <uapi/linux/dma-buf.h>
 
@@ -745,6 +746,44 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
 	return ret;
 }
 
+static void vfio_pci_zone_device_wait_fence(struct vfio_pci_dma_buf *priv)
+{
+	unsigned int i;
+
+	if (!priv->zone_device_backed)
+		return;
+
+	/*
+	 * Fence: Wait for any active references to the ZONE_DEVICE
+	 * pages to be dropped. A refcount of 1 represents the base
+	 * ownership.
+	 */
+	for (i = 0; i < priv->nr_ranges; i++) {
+		unsigned long pfn = priv->phys_vec[i].paddr >> PAGE_SHIFT;
+		unsigned long npgs = PAGE_ALIGN(priv->phys_vec[i].len) >> PAGE_SHIFT;
+
+		while (npgs--) {
+			struct page *page = pfn_to_page(pfn++);
+			int count, ret;
+
+			/*
+			 * Poll page_count() and block indefinitely until all
+			 * refs drop to avoid DMA-after-free.
+			 */
+			do {
+				ret = read_poll_timeout(page_count, count,
+							(count == 1),
+							1000, 10000000,
+							false, page);
+				if (ret)
+					dev_warn(&priv->vdev->pdev->dev,
+						 "Waiting for GUP pins to drop on PFN 0x%lx... (importer hung?)\n",
+						 pfn - 1);
+			} while (ret);
+		}
+	}
+}
+
 /* Set the DMABUF's revocation status (OK or temporarily/permanently revoked) */
 static void vfio_pci_dma_buf_set_status(struct vfio_pci_dma_buf *priv,
 					enum vfio_pci_dma_buf_status new_status)
@@ -779,8 +818,24 @@ static void vfio_pci_dma_buf_set_status(struct vfio_pci_dma_buf *priv,
 		dma_resv_unlock(priv->dmabuf->resv);
 		kref_put(&priv->kref, vfio_pci_dma_buf_done);
 		wait_for_completion(&priv->comp);
+
+		/*
+		 * Note: Rmap Deadlocks
+		 * unmap_mapping_range() is safe to call here within memory_lock
+		 * despite the VMA being VM_MIXEDMAP. Because our ZONE_DEVICE pages
+		 * are allocated via devm_memremap_pages(), page->mapping is never
+		 * set which makes them invisible to rmap.
+		 *
+		 * If this changes in the future, this call must be factored outside
+		 * the memory_lock to prevent a 3-way circular deadlock:
+		 * (mmap_lock -> memory_lock -> i_mmap_rwsem).
+		 */
 		unmap_mapping_range(priv->dmabuf->file->f_mapping,
 				    0, 0, true);
+
+		/* Wait for all page refs to drop if ZONE_DEVICE registered */
+		vfio_pci_zone_device_wait_fence(priv);
+
 		/*
 		 * Re-arm the registered kref reference and the
 		 * completion so the post-revoke state matches the
-- 
2.55.0.571.g244d577d93-goog

