Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425062;
	b=uOiu/52QPJMXukSQZXb+sBIpIUD4ufQdvAx0ojtfkuq9htS4P2LAt9ODceufMRVQynQk
	 6GQLNprTBq9KP3BSziMTR1NOD8luO4cm686Vd+8vz5zVSgbTSpHHflT6MAwCKUtVLFuGR
	 4KReIfn0Pv2xXHSj/Pcg/BqdQhf4n008qafSiIQvczhJpYxTW6W9dXViCNd070xfONC3o
	 7PS9Fvrp7YR5ub5HiJyuxX5+1zDnki/RmwnYktjcAYtBCrHO0n+TLjC9kCfu78TNK7DnE
	 PcsCElooEjOFZYU1BVEQTw3CI85y0xDwDhH0WY3yQWy/tLwLpu5ef8/amkZVaAdee9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=9sL5fqWbHi6g8R+z+W0YnlVdwW61K08vu/pGLyPlBpM=;
	b=V9zCFcIPV+D0XvfXMFX3mKr4KEUPXh0wmixr6tx1U4/4bpTE6jVJ6OlltWpKCiqD2RhK
	 eJUNNwOxfqvoLlvthdEWFWdjue9+kwi0QkU+WYR3qAToP7jr8UaCZLjXi6eYwwZKZY02F
	 dlg+LAgHsiYxDqnED4YFsMv3QwtyBPaXqKFiVlnc+ZfFjfrdS95ZEJLbPJqSf309jzghV
	 KnM+oaPN+IK+ZJEgiKMZW/7LTmZ1M3gTdr9GXN4Vm380WdEXtXRs8us84/flVnpR+HT2D
	 MneZWClR4WloPo8AhQrhX7mSVEm4C+sxbobTnaspuqLNXvx61UegRdTnJs3amzsTMfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pZTOcxAM;
	arc=none smtp.remote-ip=209.85.160.69
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E454060A3801
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 19:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E454060A3801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pZTOcxAM
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-4a72bcd6599so3447467fac.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 11:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794425061; x=1795029861; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9sL5fqWbHi6g8R+z+W0YnlVdwW61K08vu/pGLyPlBpM=;
        b=pZTOcxAMe2HFmz+bPshkgOR+7KO8iHxJ+wj3Rb1mEHykp8ygXHT1yX/VZuKQEzNyFZ
         OxzCcEtd8wsygn6pbQtVKusfgOYUdMPixogPaHOp93IVkrj6RYyVIgGsUsjc8Tyu89vS
         9WTbfZpYCQHLnbKoC9o8fA8m6ivSKeiw48VhetF/qY+RnFeAXz91CqaQCXAG9qE+NcSL
         LU+e+nnwoZhhBCX21HvZEklDzQxLNbCBbCR7AOJ72AE794mG2MjWDQtVBGcLvM6Tch/b
         9Fk71tqKxbDj8x8gleLdF0UWF/JCtrJgc12gX45P8vYPoLBi4ijOxEBv8bvv1SThw3Lp
         iJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794425061; x=1795029861;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9sL5fqWbHi6g8R+z+W0YnlVdwW61K08vu/pGLyPlBpM=;
        b=rwnaKbbcHkQoL3SuFNrbmaX53HRgxSjpvDArfOPAcv1r7OuE2WQHm8UfYwp3WyDcSi
         wtyrOaIOkVi1LOyQG5GjIv3WF6S4zl9jId6Ng1sAb9zZbe3JDRaVYTNFkn0DgG10h77F
         /NVBQlHDCcJLiag0DwaGKxI/zF52DeQYiipptk5HOUzfCfev0nu/kCp4TrlkNuHpwinc
         0NzaZjWzdvwnc4W8B9IKKzkCboGXCPBJ5joklHI8yFhTvQ0L1oMsj6+u04N5Ve35eFHM
         E+cH71HHC42Ff42rdes0oiMJgJdE6HlxJqngodCEFyWI2gqiwuAVDI54/MqqTEvc8MS9
         qVag==
X-Forwarded-Encrypted: i=1; AL+hErH/6VcAnnYIefT5zCOi2Lo7G33zeQJu4vZeKKxTrzDNjguj2frsmiSnZzYk10thn14R304IadKCYNI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cHAG1gURA1++FJA+xID+lhIKlSNWfTPLjQV58T3iT6KEFc8Uz
	yNEO7fWEtrJnWNyHDZBXTgO4BFvt3AwWY1OjGvX9VURNvUUyXVCfBOIt2DSdHYTAgSgnrOf7BKj
	YCnP35f6wB8rYmA==
X-Received: from oabus13.prod.google.com ([2002:a05:6870:df8d:b0:4ad:8f23:4d1b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:1644:b0:49e:f7c:fa52 with SMTP id 586e51a60fabf-4ae46ba7423mr2997611fac.36.1794425060739;
 Wed, 11 Nov 2026 11:24:20 -0800 (PST)
Date: Wed, 11 Nov 2026 19:24:08 +0000
In-Reply-To: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111192411.4133780-5-dmatlack@google.com>
Subject: [RFC PATCH 4/7] vfio: selftests: Add vfio_pci_dmabuf_create() helper
From: David Matlack <dmatlack@google.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Matt Evans <mattev@meta.com>, 
	Matt Evans <matt@ozlabs.org>, Mina Almasry <almasrymina@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add vfio_pci_dmabuf_create() and __vfio_pci_dmabuf_create() to export a
VFIO PCI region range as a dma-buf fd via VFIO_DEVICE_FEATURE_DMA_BUF,
and preserve -errno on failure in vfio_device_feature_ioctl().

Native iommufd maps device MMIO BARs for peer-to-peer DMA via dma-buf
file descriptors rather than VM_PFNMAP virtual addresses.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../lib/include/libvfio/vfio_pci_device.h     |  5 +++
 .../selftests/vfio/lib/vfio_pci_device.c      | 33 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 19d458adba1a..fd130f680a2d 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -172,6 +172,11 @@ static inline bool vfio_pci_device_match(struct vfio_pci_device *device,
 bool vfio_pci_find_mem_bar(struct vfio_pci_device *device, u64 min_size,
 			   struct vfio_pci_mem_bar *mem_bar);
 
+int __vfio_pci_dmabuf_create(struct vfio_pci_device *device, u32 region_index,
+			     u64 offset, u64 length, u32 open_flags);
+int vfio_pci_dmabuf_create(struct vfio_pci_device *device, u32 region_index,
+			   u64 offset, u64 length, u32 open_flags);
+
 const char *vfio_pci_get_cdev_path(const char *bdf);
 
 void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf);
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 9840463594ab..eca6eb13d7f0 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -153,11 +153,44 @@ static int vfio_device_feature_ioctl(int fd, u32 flags, void *data,
 	feature->flags = flags;
 
 	ret = ioctl(fd, VFIO_DEVICE_FEATURE, feature);
+	if (ret < 0)
+		ret = -errno;
 	free(feature);
 
 	return ret;
 }
 
+int __vfio_pci_dmabuf_create(struct vfio_pci_device *device, u32 region_index,
+			     u64 offset, u64 length, u32 open_flags)
+{
+	u8 buf[sizeof(struct vfio_device_feature_dma_buf) +
+	       sizeof(struct vfio_region_dma_range)] = {};
+	struct vfio_device_feature_dma_buf *dma_buf = (void *)buf;
+
+	dma_buf->region_index = region_index;
+	dma_buf->open_flags = open_flags;
+	dma_buf->nr_ranges = 1;
+	dma_buf->dma_ranges[0].offset = offset;
+	dma_buf->dma_ranges[0].length = length;
+
+	return vfio_device_feature_ioctl(device->fd,
+					 VFIO_DEVICE_FEATURE_GET |
+					 VFIO_DEVICE_FEATURE_DMA_BUF,
+					 buf, sizeof(buf));
+}
+
+int vfio_pci_dmabuf_create(struct vfio_pci_device *device, u32 region_index,
+			   u64 offset, u64 length, u32 open_flags)
+{
+	int fd;
+
+	fd = __vfio_pci_dmabuf_create(device, region_index, offset, length,
+				      open_flags);
+	VFIO_ASSERT_GE(fd, 0, "VFIO_DEVICE_FEATURE_DMA_BUF failed: %d\n", fd);
+
+	return fd;
+}
+
 static void vfio_device_feature_set(int fd, u16 feature, void *data, size_t data_size)
 {
 	u32 flags = VFIO_DEVICE_FEATURE_SET | feature;
-- 
2.56.0.567.gdb80ae8cd5-goog

