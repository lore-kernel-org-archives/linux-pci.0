Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D0A40F8D5;
	Wed,  1 Jul 2026 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782926006; cv=none; b=FUSpsPsg+EJ0G8jM0orbKs5WibzCXRY3nlWosiOxAy7/WG7mrweihMwuW5uzLwaHGsLBdCKCYF2HTTau9zli0fRsbPpGyOK0laqx9WbWuvZ2Zo/4/Mfr5T9G2O2+Sg0HaYhjV9vbmA+luhE3/lABgvXOK9OWMKIDnz2bOb1EGuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782926006; c=relaxed/simple;
	bh=7shcfILlQHpn3RK+z05IB2hcB5m0XwGoUBdJas+q/wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NsqiXm4yCfxjWX1UWeMZ5E5h2DNnGae/wiA2BHroUvRyZfNzg6/1aSRG2p2S1ZWCPB/ZKayf7vcFU9quoJ6WTwJRUitXooE+CCLR0MTLngTBt2bWMirMUS7tlwiy5xVRsShUiC+v2Skv3xAZKgtL4Kt+NDxvcX++gKvPY1+PEKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=JWxxffrP; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="JWxxffrP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1782926003;
	bh=/uVRHgA7nXW28m4RgK4Zw047pkYRUUcytvwZFTaeF0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JWxxffrPznvVpmC+n0KgMFvYBMA0NzKGzXvOBrbwGW5V5syX5omsJATyKUMuMPE4A
	 E5YKjzciz0gJ+EcBL2M5L7eEGoEwOhysx79S5/QxPBoZeubYWN7OsbZm7ZpmnaYMMV
	 +Itm2pvGkLYfmLGhbV2adzGOSOC5it9ChBdg6LlxM0CouY7Z2Mk4yTskcb7KaUOqa/
	 HBBc7MIs+A2eh8T1SAnHdcxGRpH8yp18oa/iDczE4qdX48BQiFzop5JGD8WYmafVX2
	 30eePbWboivRdJ6AZunm0K8Dxe4U8gBQvBfXDM4+YRZLH3kMoge8GDCoVjNXaqniXC
	 sy/rHE5zYMfzQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4gr66V5CKPz58lT;
	Thu, 02 Jul 2026 03:13:22 +1000 (AEST)
From: Matt Evans <matt@ozlabs.org>
To: Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Mastro <amastro@fb.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pranjal Shrivastava <praan@google.com>
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
Subject: [PATCH v4 06/10] vfio/pci: Provide a user-facing name for BAR mappings
Date: Wed,  1 Jul 2026 18:12:18 +0100
Message-ID: <20260701171245.90111-7-matt@ozlabs.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701171245.90111-1-matt@ozlabs.org>
References: <20260701171245.90111-1-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since converting BAR mmap()s to using DMABUFs, we lose the original
device path in /proc/<pid>/maps, lsof, etc.  Generate a debug-oriented
synthetic 'filename' based on the cdev, plus BDF, plus resource index.

This applies only to BAR mappings via the VFIO device fd, as
explicitly-exported DMABUFs are named by userspace via the
DMA_BUF_SET_NAME ioctl.

Signed-off-by: Matt Evans <matt@ozlabs.org>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index ca8a04d4629a..08c56e2803ad 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -4,6 +4,7 @@
 #include <linux/dma-buf-mapping.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/dma-resv.h>
+#include <uapi/linux/dma-buf.h>
 
 #include "vfio_pci_priv.h"
 
@@ -486,6 +487,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
 {
 	struct vfio_pci_dma_buf *priv;
 	unsigned long vma_pgoff = vma->vm_pgoff & (VFIO_PCI_OFFSET_MASK >> PAGE_SHIFT);
+	char *bufname;
 	int ret;
 
 	priv = kzalloc_obj(*priv);
@@ -498,6 +500,15 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
 		goto err_free_priv;
 	}
 
+	bufname = kasprintf(GFP_KERNEL, "%s:%s/%x",
+			    dev_name(&vdev->vdev.device), pci_name(vdev->pdev),
+			    res_index);
+
+	if (!bufname) {
+		ret = -ENOMEM;
+		goto err_free_phys;
+	}
+
 	/*
 	 * The DMABUF begins from the mmap()'s BAR offset, i.e. the
 	 * start of the VMA corresponds to byte 0 of the DMABUF and
@@ -516,7 +527,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
 	priv->provider = pcim_p2pdma_provider(vdev->pdev, res_index);
 	if (!priv->provider) {
 		ret = -EINVAL;
-		goto err_free_phys;
+		goto err_free_name;
 	}
 
 	priv->phys_vec[0].paddr = phys_start + ((u64)vma_pgoff << PAGE_SHIFT);
@@ -524,7 +535,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
 
 	ret = vfio_pci_dmabuf_export(vdev, priv, O_CLOEXEC | O_RDWR);
 	if (ret)
-		goto err_free_phys;
+		goto err_free_name;
 
 	/*
 	 * Ownership of the DMABUF file transfers to the VMA so that
@@ -539,8 +550,15 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
 	vma->vm_file = priv->dmabuf->file;
 	vma->vm_private_data = priv;
 
+	spin_lock(&priv->dmabuf->name_lock);
+	kfree(priv->dmabuf->name);
+	priv->dmabuf->name = bufname;
+	spin_unlock(&priv->dmabuf->name_lock);
+
 	return 0;
 
+err_free_name:
+	kfree(bufname);
 err_free_phys:
 	kfree(priv->phys_vec);
 err_free_priv:
-- 
2.50.1 (Apple Git-155)

