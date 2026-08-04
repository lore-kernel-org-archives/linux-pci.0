Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A0A4483AD
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869479; cv=none; b=MX92env09TypEb1VWLxfS0GjUhuwlDrfdeQXtoODmWnukI0SIUsPyblnRKAROXm7AtTO3FwKIAoSf3KBBCbaWh7YmZ5YouZSliOklwWlKBPLhrWDzjhQud654hkpdk+qCiDhq5BdkX45TWFKIP5pQTEUbqdiluYzMfeSWvq0L30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869479; c=relaxed/simple;
	bh=/pi0kNXNY1h1pfxpiwUj6T06M1fqxSotc6q0idZPb1E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WH07XEIIDILVLubz3gXmEVfEbMptIfab9w6JeQpTlYOeRKz7IRUMGaV4SzA9VeqX+Cry1b5+lGUpTL35DA/A0a5Es2iJd/V5JvGRb91D6eA+VBfso1hB1tZeM06MySmqv0HpOyOhkdmxlbjRpZzeBM9XmwFiJs7NB0JyZXHKQVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r7NToLc2; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r7NToLc2"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e1da97175so180863b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 11:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785869473; x=1786474273; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6S00Ge/ZDy4xJEvv5eN0PZrlFX4UFgt2/k8ihNKAOGs=;
        b=r7NToLc206L8dkkIq/zyZt4LEG/oj1/vjEU+dV2kdHLgIViXtVxjBXt4utVsjYPnkg
         GxOahNhBqnXoK1qG7AjVt25/deKwt3kNftL44X81bN/C9aQGHTsjdJafvs6aS6WQtkYW
         9okE9Vti/5ca7kCR7NnUSWbbpQEDOq8T0/Iucgmbr4kIyP+6fEq0hZw9hXFMbFvh+MBc
         ms42DINkwgPbSLdodwpJZobm5JVcwbDE/9j7tGiq+AkFtVURqzG5cHMARe+FX+GJCTeF
         KXX2L0muy/dvchat20y512DiOXDm6sgHN46yTxQeNrfxNnwPNf1KAeIK5cXAJBfG1oHN
         o7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869473; x=1786474273;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6S00Ge/ZDy4xJEvv5eN0PZrlFX4UFgt2/k8ihNKAOGs=;
        b=kIo4oVhj2YxSk/Em6rwg8doZwFwWURJppXyAmlY15IYXy1825lYIkdjF3mvASGDeuS
         bPc/pxIUj7SLLjUW1aPQMn4nRGkszzhpJR3w5C3cZcVqWuFMjfAiYiRJolZz+veKQK55
         DSiGfObJf4FUv8kRtEwOneSKik+oXytYPZQXFm6wDAfAX94b/26kcNroL7feyUrJvHS9
         XVxoskrgDyBa+p1v3uNp7bw8rMYQ9DOSrwTk8Q0AJYNWp99eJjG6Dn52t9cH2Zqwsbxz
         CdcTEeQCRvXs0CwueaLVmR7H8lguhRwND24jcj3p2mThXdfZyh1DqgSA8gpBvcAn6zoj
         RYIw==
X-Gm-Message-State: AOJu0YzaWC3g1kitZ7/PQstvM/K8ykpVov1Tx0NxmaI/PkQVhaGXbTkt
	wU65gF7nEAvLsj1kEYMEvT/GupOQ0lNqXyBJmWHGoGMH4Pw6cRhByKkm3zidjI+8jC8Uv0kgqnX
	M1KvKXMRfYAxMOS4ILEFDlTtVpYljzvRI/molxwZ6hbpmvPhEZzsDmFooWhDxIk7/xa/9SUXw3H
	24QoFy11f4+y79M9bD6aNslwu+JDWR3yuJ8pU=
X-Received: from pgvm5.prod.google.com ([2002:a65:62c5:0:b0:cb5:3dd0:cdbd])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:348d:b0:842:706e:ad43
 with SMTP id d2e1a72fcca58-84f2e0ccba3mr802967b3a.33.1785869472550; Tue, 04
 Aug 2026 11:51:12 -0700 (PDT)
Date: Tue,  4 Aug 2026 18:50:48 +0000
In-Reply-To: <20260804185050.2053672-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804185050.2053672-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804185050.2053672-4-praan@google.com>
Subject: [RFC PATCH v2 3/5] vfio/pci: Implement page-backed .map_dma_buf handler
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

When a DMABUF is backed by ZONE_DEVICE pages, the standard raw PFN
scatterlist builder (dma_buf_phys_vec_to_sgt) cannot be used because
it explicitly drops page metadata pointers. Implement a map_dma_buf
helper that loops through existing contiguous physical ranges and
generates SGL entries directly via sg_set_page while maps using the
standard dma_map_sgtable. Implement a corresponding .unmap_dma_buf as
well.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 81 ++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index 900ac1851c9f..b936da3bcada 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -55,6 +55,7 @@ static int vfio_pci_dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *
 	/* See comments in vfio_pci_core_mmap() re VM_ALLOW_ANY_UNCACHED. */
 	vm_flags_set(vma, VM_ALLOW_ANY_UNCACHED | VM_IO | VM_PFNMAP |
 		     VM_DONTEXPAND | VM_DONTDUMP);
+
 	vma->vm_private_data = priv;
 	vfio_pci_set_vma_ops(vma);
 
@@ -70,6 +71,66 @@ static void vfio_pci_dma_buf_done(struct kref *kref)
 	complete(&priv->comp);
 }
 
+/*
+ * For ZONE_DEVICE-backed DMABUFs, populate the scatterlist with struct page
+ * pointers so that dma_map_sgtable() can detect MEMORY_DEVICE_PCI_P2PDMA and
+ * perform peer-to-peer DMA mappings for importing devices.
+ */
+static struct sg_table *
+vfio_pci_dma_buf_map_page_backed(struct dma_buf_attachment *attachment,
+				 enum dma_data_direction dir)
+{
+	struct vfio_pci_dma_buf *priv = attachment->dmabuf->priv;
+	struct sg_table *sgt;
+	struct scatterlist *sgl;
+	unsigned int nents = 0;
+	int i, ret;
+
+	for (i = 0; i < priv->nr_ranges; i++) {
+		unsigned int added = DIV_ROUND_UP(priv->phys_vec[i].len,
+						 (UINT_MAX & PAGE_MASK));
+
+		if (check_add_overflow(nents, added, &nents))
+			return ERR_PTR(-EOVERFLOW);
+	}
+
+	sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
+	if (!sgt)
+		return ERR_PTR(-ENOMEM);
+
+	ret = sg_alloc_table(sgt, nents, GFP_KERNEL);
+	if (ret) {
+		kfree(sgt);
+		return ERR_PTR(ret);
+	}
+
+	sgl = sgt->sgl;
+	for (i = 0; i < priv->nr_ranges; i++) {
+		size_t range_len = priv->phys_vec[i].len;
+		unsigned long pfn = priv->phys_vec[i].paddr >> PAGE_SHIFT;
+
+		while (range_len > 0) {
+			unsigned int chunk_len = min_t(size_t, range_len, (UINT_MAX & PAGE_MASK));
+			struct page *page = pfn_to_page(pfn);
+
+			sg_set_page(sgl, page, chunk_len, 0);
+			sgl = sg_next(sgl);
+
+			range_len -= chunk_len;
+			pfn += chunk_len >> PAGE_SHIFT;
+		}
+	}
+
+	ret = dma_map_sgtable(attachment->dev, sgt, dir, 0);
+	if (ret) {
+		sg_free_table(sgt);
+		kfree(sgt);
+		return ERR_PTR(ret);
+	}
+
+	return sgt;
+}
+
 static struct sg_table *
 vfio_pci_dma_buf_map(struct dma_buf_attachment *attachment,
 		     enum dma_data_direction dir)
@@ -82,9 +143,14 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attachment,
 	if (priv->status != VFIO_PCI_DMABUF_OK)
 		return ERR_PTR(-ENODEV);
 
-	ret = dma_buf_phys_vec_to_sgt(attachment, priv->provider,
-				      priv->phys_vec, priv->nr_ranges,
-				      priv->size, dir);
+	if (priv->zone_device_backed) {
+		ret = vfio_pci_dma_buf_map_page_backed(attachment, dir);
+	} else {
+		ret = dma_buf_phys_vec_to_sgt(attachment, priv->provider,
+					      priv->phys_vec, priv->nr_ranges,
+					      priv->size, dir);
+	}
+
 	if (IS_ERR(ret))
 		return ret;
 
@@ -100,7 +166,14 @@ static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment,
 
 	dma_resv_assert_held(priv->dmabuf->resv);
 
-	dma_buf_free_sgt(attachment, sgt, dir);
+	if (priv->zone_device_backed) {
+		dma_unmap_sgtable(attachment->dev, sgt, dir, 0);
+		sg_free_table(sgt);
+		kfree(sgt);
+	} else {
+		dma_buf_free_sgt(attachment, sgt, dir);
+	}
+
 	kref_put(&priv->kref, vfio_pci_dma_buf_done);
 }
 
-- 
2.55.0.571.g244d577d93-goog

