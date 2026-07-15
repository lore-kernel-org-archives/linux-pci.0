Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406154B8DF7;
	Wed, 15 Jul 2026 17:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137704; cv=none; b=Fl9bVzhidm4UtRCp7jECuWf+nGb6oIwcyfccm3uIUCEnTr6sfQb1Ck3lVOSk9PZD0HW7/PCS0dTOQOq8NonlH9n7ToKIZnPeSzAwDiQhJrjtGwGi78Gj0FePGQkcR7KC7kD51NX6gtuXCC3DOBXeejRpWvMm0DBzI4xib1yVVnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137704; c=relaxed/simple;
	bh=6LZgKMmkYjFRBzmjr2YBs+EvhOt9EISp4sBE6VBi5go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MiWoEUTITDuoeRle0h73COh4Sww/uLF0aUAGNpiuciL2lQW6B4mehDF+A/HoKXpvgmVByEkYOGSJILG6WK+lugXGzcLZLf4lv2uWCvPmRgIlzlgAtVEJcS+2F9DnWyyCEquu3qLHIWRJJO+EjsmWBe9lyWAGgKFWz5hz0p/ZibQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=NBm5LAeG; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="NBm5LAeG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1784137700;
	bh=S4yvVhd4segS5bNIQO9q6OScsB0g9zWVml9R9MFW9Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NBm5LAeGHqKWbz0gNKtD6ohMNo9zh2qT+iwC86PbhY+D3gata01U4sPFYywI5NP+h
	 TGeFjSzr9UZfokkV5nIYDY/6Q5hGqXhEYxJsi+iEq7J9xO2B2AgroTJ4dVZbocJiZy
	 jEbnd2gLLjbvAaId6JSeQZ/tW7NItMKto+tlt3AvcAPct5CryNUI6ALFN4YD/S9GiQ
	 9ywtcxjMwMCS1uDkBxsF4tHqATj1dT/IQVCJtCx6lwByKPeApfMDN0A0Oj86v8j+c4
	 C1kNxTuwfo2X4UGVkKm0/0fD/UKQiZLmA1xtHXdZJ3SXzK/ZHXPWmLi5K+/frUwvuT
	 7jzLjnMYYjHhA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4h0kDM496sz4wCH;
	Thu, 16 Jul 2026 03:48:19 +1000 (AEST)
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
Subject: [PATCH v5 6/9] vfio/pci: Provide a user-facing name for BAR mappings
Date: Wed, 15 Jul 2026 18:47:29 +0100
Message-ID: <20260715174737.15287-7-matt@ozlabs.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260715174737.15287-1-matt@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
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
index 46b3cf5dc94b..51606ff3cdc6 100644
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

