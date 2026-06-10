Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656AA423A64
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104746; cv=none; b=hOkZyFa0DGNFoQoFcL6G0tQ+0WPXCOaJJ9y5eiLQVM16k0bGV3N6Of8sk3GCwnO10imEZEtatX5Y15f7uSikGIApNBHcLYiVMw2hk/p0EKHScp9vW5CWju9hF5M86EVAyuHVXA5rtMcLS+Rz5CXJcxqbpwWrJpAcAqBAXHshZQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104746; c=relaxed/simple;
	bh=W26xzmE+jrRyJeg4sgHUoiNG1TPKjNOWHbVy/H0Zo3Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bv4SrYkuLSfmZ9bNRs5wSn4EHwKT05ikFVOLUI4vCdCI4RpNdddm73svy+OdxQSqfbsqrFajmMIn/mxSayXNkwtJWJj5ota5sW23kN7kuQDEU3VczLz4cwIbwIig48KUvw5XcknlcOHNUN3vWcG+ZV2XEdJCgYAGMO3O/RvrA6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gDqR0h5T; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gDqR0h5T"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bfdd99f6b7so98295925ad.0
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 08:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781104743; x=1781709543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eqTJwQH8YsAF6LO/DgujemeBJs4CWAElVi/rnkffuXw=;
        b=gDqR0h5TorA42u8xiUG/9P0ak940+YeUImN5hBFzeqf3InpBnnrExXV80RjAdGBpcE
         3xJY8YxuATi4cNYhM+FC3DwuCgq46XfL3rzxwudUyHztNzIf8cilc//K9sxpaJj0qbHM
         PALRkLdoGiwtPAT/g5xVXTOUARkADrfDOHuCsYlVCANKa/k9tdZpYy63uBX17LMPW4E5
         vJ2SZI+5wVgoZiKTvOb2HF3IoK2HBenB8mdxtQSzb1n5O9c8ohvno6rU6bq8qcpf+cJg
         dNLgJuUqUko68emGDnZXEHUD0o76tJt283ttwvdwD27vv2chdJRhaTBJKbSVTgMXys01
         Oowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104743; x=1781709543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eqTJwQH8YsAF6LO/DgujemeBJs4CWAElVi/rnkffuXw=;
        b=PtHHvWgs+Ho+Ko/nNJRpJdTvaXZ1YaUxq8bOenP+HMXaBjY9trXhnHH9Nobw7RcMTw
         FF1tpk4SbrWqo/zsqNCbe0K9iikyC+DAQ+Y+sumra1yshsuLUyjJSUDSAkUUfTpCRZWh
         RSaNz9GVtJWLvXZR/JoB6hdAYNGYVhgnMG9HJ1o+6TvOWixg5Jy6gpkcyP5MG+CkpFd0
         n7Ym68h+hF0aJg/XW1zZ2yIuS8bo9fc2oLNe8M9aUc6EFxXLvUEaj6qVEBgZiENzQYlE
         T1AzvdN8/G345RqEd9T9JT0uhvh+aUo4lNnBdncjVihqYLtOmdquCzBISpCacDDoHWlR
         mZ+w==
X-Gm-Message-State: AOJu0YxND3TU5JDEE/9UW+4mbNBIuENgLIWHJKqRPxZjGyzYajVkt11/
	/m3C3ASC2d4oWE2LnG1wWm/Z5YHM76CIlYo3s2939IhXA6XAYYaj+Ap5wELSRy77P0IYM40EbZN
	3bkSTH7Oqp5eCcjT+blMWBQcs/RBMqA2IFDo7mS3W+q1fmQfFTwH6rBFUCwwWaIR47R5M7iL71f
	s6adF96sClUW462Of6VUQDMQXTvnc7smQOsZ0=
X-Received: from plby21.prod.google.com ([2002:a17:902:ed55:b0:2c1:9d1:eeb0])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:291:b0:2c0:c940:dc32
 with SMTP id d9443c01a7336-2c1e821dde8mr301857195ad.16.1781104742341; Wed, 10
 Jun 2026 08:19:02 -0700 (PDT)
Date: Wed, 10 Jun 2026 15:18:51 +0000
In-Reply-To: <20260610151853.3608948-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610151853.3608948-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610151853.3608948-4-praan@google.com>
Subject: [RFC PATCH 3/5] vfio/pci: Block mmap & dmabuf export for
 ZONE_DEVICE-registered BARs
From: Pranjal Shrivastava <praan@google.com>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Pranjal Shrivastava <praan@google.com>, Ankit Agrawal <ankita@nvidia.com>, Matt Evans <mattev@meta.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Shivaji Kant <shivajikant@google.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Update vfio_pci_core_mmap() &  vfio_pci_core_feature_dma_buf() to
enforce mutual exclusivity with ZONE_DEVICE P2P registration.

If a BAR has been registered for native P2P (via
VFIO_DEVICE_FEATURE_P2P_REGISTER), subsequent requests to mmap the BAR
or export it as a DMABUF are rejected with -EBUSY.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c   | 7 +++++++
 drivers/vfio/pci/vfio_pci_dmabuf.c | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 1e922e3aaeb3..9cf494b765e7 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1828,6 +1828,13 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 	if (!vdev->bar_mmap_supported[index])
 		return -EINVAL;
 
+	if (vdev->p2p_registered_bars & (1 << index)) {
+		pci_warn(vdev->pdev,
+			 "BAR %d registered for P2P. Use sysfs to allocate\n",
+			 index);
+		return -EBUSY;
+	}
+
 	phys_len = PAGE_ALIGN(pci_resource_len(pdev, index));
 	req_len = vma->vm_end - vma->vm_start;
 	pgoff = vma->vm_pgoff &
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index c16f460c01d6..6635a8681291 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -251,6 +251,12 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	    IS_ERR(vfio_pci_core_get_iomap(vdev, get_dma_buf.region_index)))
 		return -ENODEV;
 
+	if (vdev->p2p_registered_bars & (1 << get_dma_buf.region_index)) {
+		pci_warn(vdev->pdev, "BAR %d registered for native P2P. Use sysfs for allocation.\n",
+			 get_dma_buf.region_index);
+		return -EBUSY;
+	}
+
 	dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
 				       sizeof(*dma_ranges));
 	if (IS_ERR(dma_ranges))
-- 
2.54.0.1099.g489fc7bff1-goog

