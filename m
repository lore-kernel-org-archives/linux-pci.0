Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026AE471415
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869480; cv=none; b=MPFfjgEPR0Wml+xEF4TpL0GhOWCyS6ZNkFmXvL7/K04XI4TjQzRZCkY9o76e4MQSgZSY9sOEEQ1923LKjLGA0eN28PWeFJxv8jubJrf79Cdn8BRmiFPF3A5HiJUvnvqX+FjLW6ltzFP+optxvzlWRZqIWLlQysgAYy09dpH6nQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869480; c=relaxed/simple;
	bh=86B3BBLW8NnxL8U0IAZgS6A8MjKZ1A/OLEY6LvzwoLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l8s+1BXlrX4OenPAM9oGXvykHYKs7LIw19y9GyUV6xGRLUq+/5moTO1EuiTQUbMrEZ41N0q5wI8Pyi+0eewZIsZ4ww+4r3OVNUDXt8AKTG/M9yNvgM90bEcv9FSJlfPGC8ovcS6NvIXDnR3q2WaaKrP5ylqkgV1MudeMiT63yvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IyubcPC1; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IyubcPC1"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ca124bf0189so1034874a12.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 11:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785869475; x=1786474275; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t6VEXazL8yheZxsIS8BkIrSzpg52BXjB99hyFiWVn2Y=;
        b=IyubcPC1lYxmgzhckYH+EPszSFP/J5UjnfqJVucRYaJ768WAPgWL6DciZ19cRwqYg3
         IOSAb3Ea2v9H3OwUG8xd7FyoKubDWyz4UJoeNCf2ErjkbOXd7hU4d8lI2OflKyldxWxW
         r9iRPvd9j1GoezGYssYhwEs4oEQgDBrHvgypHaWXC1ADSktmJptidD5MfeFVyj3y73Qo
         yAF5cbSAOJzBkteyqcYly9g1VNin2bvgCF2SDqTlfKr/RLOk0hdF/AnqCBkfD8bESe2y
         cGKzs3yCPNblQlQltmSDNvsQP90hwGOG/7zpvNZeFA3ZUkNbBCMQ6ztSKy2nyqCT3XpC
         pC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869475; x=1786474275;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t6VEXazL8yheZxsIS8BkIrSzpg52BXjB99hyFiWVn2Y=;
        b=RLMtEBoP1br5N08swDBbGAjT4UGm1hBa5CthsDf9O/YJOg+alEOVFe7nId/a+EsBPs
         RRRXgGdZmYR8O1vD3XKfglk6JS30S/+sRusY7S38hurNLz1BmlBr+L0nokpTYOIYL8hl
         pcX8WM5URETh3lhhem/V2uFGXouD2LzKUHFbka65wxLze/LGXlHW1JxegvgDLNskNe4e
         c5Nj7LAvJT/s110WGH5B0hRMb48EPydfoYvRMBGfzZeQ3YsQy5+FRDLQysoafQGw2+4+
         jwHwb1dQqvc1f75CRn7Unf6ugk3BTIAtT7TfrXF7v7ZFQGxgcZnct/Z0FXr3W8/tDrfc
         gkkg==
X-Gm-Message-State: AOJu0YxSESQZv4yQ5cey+VCMdEptNwFmLFTKR2DQcCi8ouv6C5CaBrFm
	3lTLHOKGE6JTZSgEyMtLb0F+NuPfIw4tBKCsDW+iLkSGnAMKKTmzqOF+/ACuSnH5TSrK3KkfZjs
	cvzjXPhbsRoH0LYb6I8cI3cIgRbKwU9YLSwmGn9fbSlA0Z0BMo6hgZ7Qou6FVdOPtVhPFC68laK
	aLSfzKK7IClkGuYrYPuEGOqbD463hQ4xhLj+8=
X-Received: from plbke7.prod.google.com ([2002:a17:903:3407:b0:2c6:a078:41f8])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c08:b0:2cc:bdb9:3c04
 with SMTP id d9443c01a7336-2d08ab5dc5cmr53683795ad.17.1785869475101; Tue, 04
 Aug 2026 11:51:15 -0700 (PDT)
Date: Tue,  4 Aug 2026 18:50:49 +0000
In-Reply-To: <20260804185050.2053672-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804185050.2053672-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804185050.2053672-5-praan@google.com>
Subject: [RFC PATCH v2 4/5] vfio/pci: Add .mmap handler for page-backed DMABUFs
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

Implement mmap and a corresponding page fault handler for ZONE_DEVICE
backed DMABUFs. Set VM_MIXEDMAP for page-backed VMAs and introduce the
vfio_pci_vmf_insert_page() helper to insert struct page pointers into
the user PTEs.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c   | 39 +++++++++++++++++++++++++++---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 22 +++++++++++++++--
 include/linux/vfio_pci_core.h      |  3 +++
 3 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 9ca99a5a61c3..f5c2912c3ffc 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1790,6 +1790,34 @@ vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_vmf_insert_pfn);
 
+vm_fault_t vfio_pci_vmf_insert_page(struct vfio_pci_core_device *vdev,
+				    struct vm_fault *vmf,
+				    unsigned long pfn,
+				    unsigned int order)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct page *page;
+
+	lockdep_assert_held_read(&vdev->memory_lock);
+
+	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev))
+		return VM_FAULT_SIGBUS;
+
+	/* vmf_insert_page only supports 0-order pages */
+	if (order > 0)
+		return VM_FAULT_FALLBACK;
+
+	if (WARN_ON_ONCE(!pfn_valid(pfn)))
+		return VM_FAULT_SIGBUS;
+
+	page = pfn_to_page(pfn);
+
+	if (vma->vm_flags & VM_WRITE)
+		return vmf_insert_page_mkwrite(vmf, page, false);
+
+	return vmf_insert_page(vma, vmf->address, page);
+}
+
 static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 					   unsigned int order)
 {
@@ -1877,11 +1905,14 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 							     vmf->address,
 							     order, &pfn);
 
-			if (pres == 0)
-				ret = vfio_pci_vmf_insert_pfn(vdev, vmf,
-							      pfn, order);
-			else if (pres == -EAGAIN)
+			if (pres == 0) {
+				if (priv->zone_device_backed)
+					ret = vfio_pci_vmf_insert_page(vdev, vmf, pfn, order);
+				else
+					ret = vfio_pci_vmf_insert_pfn(vdev, vmf, pfn, order);
+			} else if (pres == -EAGAIN) {
 				ret = VM_FAULT_FALLBACK;
+			}
 		}
 	}
 
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index b936da3bcada..b582e856ba7a 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -4,6 +4,7 @@
 #include <linux/dma-buf-mapping.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/dma-resv.h>
+#include <linux/sched.h>
 #include <uapi/linux/dma-buf.h>
 
 #include "vfio_pci_priv.h"
@@ -53,8 +54,14 @@ static int vfio_pci_dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *
 	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
 
 	/* See comments in vfio_pci_core_mmap() re VM_ALLOW_ANY_UNCACHED. */
-	vm_flags_set(vma, VM_ALLOW_ANY_UNCACHED | VM_IO | VM_PFNMAP |
-		     VM_DONTEXPAND | VM_DONTDUMP);
+	if (priv->zone_device_backed) {
+		/* VM_MIXEDMAP is required for ZONE_DEVICE pages */
+		vm_flags_set(vma, VM_ALLOW_ANY_UNCACHED | VM_MIXEDMAP |
+			     VM_DONTEXPAND | VM_DONTDUMP);
+	} else {
+		vm_flags_set(vma, VM_ALLOW_ANY_UNCACHED | VM_IO | VM_PFNMAP |
+			     VM_DONTEXPAND | VM_DONTDUMP);
+	}
 
 	vma->vm_private_data = priv;
 	vfio_pci_set_vma_ops(vma);
@@ -521,6 +528,17 @@ static int vfio_pci_dma_buf_alloc_struct_pages(struct vfio_pci_core_device *vdev
 	if (ret) {
 		if (ret != -EEXIST)
 			return ret;
+	} else {
+		/* Initialise the refcount for the freshly allocated page. */
+		unsigned long pfn = pci_resource_start(pdev, bar_index) >> PAGE_SHIFT;
+		unsigned long npgs = pci_resource_len(pdev, bar_index) >> PAGE_SHIFT;
+
+		while (npgs--) {
+			set_page_count(pfn_to_page(pfn++), 1);
+			/* Yield the CPU periodically on large BARs to prevent soft lockups */
+			if (unlikely((npgs & 4095) == 0))
+				cond_resched();
+		}
 	}
 
 	vdev->p2p_struct_page_bars |= (1 << bar_index);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index c28f06bae302..778671194b24 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -187,6 +187,9 @@ ssize_t vfio_pci_core_write(struct vfio_device *core_vdev, const char __user *bu
 vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
 				   struct vm_fault *vmf, unsigned long pfn,
 				   unsigned int order);
+vm_fault_t vfio_pci_vmf_insert_page(struct vfio_pci_core_device *vdev,
+				    struct vm_fault *vmf, unsigned long pfn,
+				    unsigned int order);
 int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma);
 void vfio_pci_core_request(struct vfio_device *core_vdev, unsigned int count);
 int vfio_pci_core_match(struct vfio_device *core_vdev, char *buf);
-- 
2.55.0.571.g244d577d93-goog

