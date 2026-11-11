Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425063;
	b=LrP3gpxO+9Ivu+ANqR4tQn4MjVsNyzouidoUNiOpsAmHSJ3CaYsHvGtdwQrnQ3Ro2p5h
	 1ngQ7NCF+m5s6er00XQRTf6EXuFyozbKm88qhotbvM1X/NRdR27749C47VkuCkD+t3CzA
	 FePuU+6631lCmYydWhxFX8i7piglqMd6wEIcVWoE0yORuAV8tpmQ52hBsj5zRdEtbtlkO
	 xDSnP01PaA61UlCYgdNxl3HS2XHFbutPO2/qqtZI3lZxY51dVyVuWmUrkDALmtXFqrWOh
	 N0CX9W7dfCHHsc/qIxCqRicAQ/BFRFQnfr6Y066Og6dlR3NKZjvzV6thPzV30KRo2sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=GZrkVSPnOLbwhYzrPljddPiSGOm8sAR0nI/sR9X9KfM=;
	b=BZ98NQfKImaTKXGXLfPnzNP3LmI5FjddM331DaEkGcT4Yg/ZQx2EcyGMl6gPFbr/ZoW3
	 1gtIIolO9IVhax+EgmSv0fMA7+VxfWsVivZHg9w9mF+8nsIJnqCkCVZzfNwexOpfIqHPT
	 /bHTRzJMXA+vbVvmEA5bq+dCvpJ35ry8AkoFRCTAwOr2pWwnHoy4YB57ccRaaCjxWJn7Y
	 PpJscO2wcmJcZr6H7aojhDgq1bVutqdcdiN0PIZUPBua5+X83C+5aIx9tdVAeyJYp38BQ
	 2RyNiqBmPh3PBfOj148WgUKs0lmp8mtCxginVoH6kWMCq4KIkPouOrLH/HDTYBQ4wrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=C8mJidRl;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFB7606B5E5
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 19:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AFB7606B5E5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=C8mJidRl
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4ea2c058e67so3962044b6e.1
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 11:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794425062; x=1795029862; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GZrkVSPnOLbwhYzrPljddPiSGOm8sAR0nI/sR9X9KfM=;
        b=C8mJidRloxlSfZbT6vz1c4ZNIn+miuKpjO2mPIxJ1PT/KnTuIZ3U1UGeEJKxQl3bI0
         EYvIa2/QIpzwaxDrjivW3Y73fFtq6G/Ska0GFJhtdxumBfEPZd3qejbghifrtttYw90x
         rf47GmsJUp7ipGL8m72MwqJMJpHvg5RRshIDEpbZm6nttL9298GyyRtlK2XUEDzueh6C
         //8cVyO1I6cqy0k+v2dqglVMOUdferTx8y0HlXQzJfwcs+tf/QI7NpPoeH3Fm63HlHSe
         lA4lKR+ySUQSFGM15MKxl6yKTjwAk+FRtubeC/4iTVxNKZSGc3H7e9C52oxp102WBmUb
         PkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794425062; x=1795029862;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GZrkVSPnOLbwhYzrPljddPiSGOm8sAR0nI/sR9X9KfM=;
        b=RAQnLM/sYTlS4vZwFxeOkvy9ZenPLER+0CPmysby1Sk/B4+xRkORPIiGN0J4XYbFhS
         pWg/D5BJwu4YCiL0Ck3iNK1ekfE6FoXkcQT4hTbE4Wywp7ZzICUhbSnK04ZkbjeR1AJt
         WFSxJ3ZhJ8ZM22eAp5x31i3faBy23aRokbP2aRURHoVWngvUs5UIB2SbOWza79RDZ6nR
         iYEROmDeHKgHirzPPgjN+y5UMcHbu0ZS1ymKMMo/WDnmLNYmEUV5rd2VjZ4FrRjJ/MtL
         CC+XhU31fssr9ve2bzb+IkXLiSRyZFAxA323gsRRS/u4EPPjwH7Okfw76tJzCexQl1vQ
         F0yg==
X-Forwarded-Encrypted: i=1; AL+hErHZelBtNJSlo+n2y4PVCXMnwTstrlTX3QEu+CWGCbr31hmDHz4X/6+VRs46Wers8ujDjtkukMS6jsY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LXjpNPL0qPu0D6yOUwvx2xGdUilITILFL/2DcvZFb3pqTo2D5
	kj4RqnEIf71ieKukQIeRbNvY11Eo73pD5vHOe+Ja4Zu1UjvMbDHBO1lb/BSPuvQGjdqv54SbvF6
	8mQfggKnVNp03nw==
X-Received: from ilbec1.prod.google.com ([2002:a05:6e02:4701:b0:527:120b:a51d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:191f:b0:53f:3c0e:c74b with SMTP id 5614622812f47-56b93447ed4mr3152606b6e.9.1794425061950;
 Wed, 11 Nov 2026 11:24:21 -0800 (PST)
Date: Wed, 11 Nov 2026 19:24:09 +0000
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
Message-ID: <20261111192411.4133780-6-dmatlack@google.com>
Subject: [RFC PATCH 5/7] vfio: selftests: Add iommu_map_file() helper
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

Add iommu_map_file() and __iommu_map_file() to map a file descriptor
(such as a memfd or VFIO PCI dma-buf) into an iommufd IOAS via
IOMMU_IOAS_MAP_FILE. Also skip regions without a host virtual address in
__iommu_hva2iova(), since file-backed DMA mappings do not require one.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../vfio/lib/include/libvfio/iommu.h          |  9 ++++++
 tools/testing/selftests/vfio/lib/iommu.c      | 29 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index e9a3386a4719..2b39c49e66da 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -42,6 +42,15 @@ static inline void iommu_map(struct iommu *iommu, struct dma_region *region)
 	VFIO_ASSERT_EQ(__iommu_map(iommu, region), 0);
 }
 
+int __iommu_map_file(struct iommu *iommu, int fd, u64 file_offset,
+		     struct dma_region *region);
+
+static inline void iommu_map_file(struct iommu *iommu, int fd, u64 file_offset,
+				  struct dma_region *region)
+{
+	VFIO_ASSERT_EQ(__iommu_map_file(iommu, fd, file_offset, region), 0);
+}
+
 int __iommu_unmap(struct iommu *iommu, struct dma_region *region, u64 *unmapped);
 
 static inline void iommu_unmap(struct iommu *iommu, struct dma_region *region)
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index b6f3c5c84e01..ba602685f892 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -71,6 +71,9 @@ int __iommu_hva2iova(struct iommu *iommu, void *vaddr, iova_t *iova)
 	struct dma_region *region;
 
 	list_for_each_entry(region, &iommu->dma_regions, link) {
+		if (!region->vaddr)
+			continue;
+
 		if (vaddr < region->vaddr)
 			continue;
 
@@ -149,6 +152,32 @@ int __iommu_map(struct iommu *iommu, struct dma_region *region)
 	return 0;
 }
 
+int __iommu_map_file(struct iommu *iommu, int fd, u64 file_offset,
+		     struct dma_region *region)
+{
+	struct iommu_ioas_map_file args = {
+		.size = sizeof(args),
+		.flags = IOMMU_IOAS_MAP_READABLE |
+			 IOMMU_IOAS_MAP_WRITEABLE |
+			 IOMMU_IOAS_MAP_FIXED_IOVA,
+		.ioas_id = iommu->ioas_id,
+		.fd = fd,
+		.start = file_offset,
+		.length = region->size,
+		.iova = region->iova,
+	};
+
+	if (!iommu->iommufd)
+		return -EOPNOTSUPP;
+
+	if (ioctl(iommu->iommufd, IOMMU_IOAS_MAP_FILE, &args))
+		return -errno;
+
+	list_add(&region->link, &iommu->dma_regions);
+
+	return 0;
+}
+
 static int __vfio_iommu_unmap(int fd, u64 iova, u64 size, u32 flags, u64 *unmapped)
 {
 	struct vfio_iommu_type1_dma_unmap args = {
-- 
2.56.0.567.gdb80ae8cd5-goog

