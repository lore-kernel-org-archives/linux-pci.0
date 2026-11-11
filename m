Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426462;
	b=eX/74oaWGFO3+HZWGttgu+wkEmfytP7UldpqtG4yFs+4FF3HqPibQdVY8uvNu2YolMBj
	 7742cON81N59vxQLD2b+S1Pqxu61qV/db3ugd9QmoDH6wiiugveobRU21WRMulKP9+JqG
	 pudP9CdaiPzPyxlPKhwanh2VGUuk70tqRNM6/Hm1ZKSorSPqzEIokV9TL6OFCcFhaPdiE
	 0VZIh0v/Cl9kbj75s0D0M2/J4y3wc77Npoc68OevsmVNgIluUe8ATc2OHLkTFrakbqwwx
	 4Nx3NFfQLpO5JWe8T+OawWP3fo/PTsKf2H+yC0c0Murmh0BiPo5plYjrjK+XmDIDZhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426462;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PWVL6bvXnxNkJSOKiby5JwyMlo6cVWinxz0qfpmIGeM=;
	b=AV8NpTZS9/eHEQcU4wzI8iz33qqmBiZiQI0RWUSO98+/8PAzxZLDpm4ebITvBCZfYYVB
	 eLpEwxDMsqtHRjqL7jYCHeh8SSRPZjqPj0jgrSkuBn+KYgSG4vNz6tlyCRS0pabXBLAJD
	 xLYK1KFYZ2E3dBCOWeMeiJTuXF4f5ran07TUT3pxySyRZz9SPdabmxdlQBimSEmSNY0WV
	 RmoEdWQ3tPxWxjpm1Za+velEe21Q8tfw3t1so5ESiaI47eqrOBP36J96/lNXF61HH4GVg
	 6gWyj7viPro+qnoFm4r1IJeXQChsVrM+lHU0i8rTJrTxM9w36VwcwSB8dCG27KNHI/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EZnbWUUB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C073F606A321;
	Wed, 11 Nov 2026 19:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EZnbWUUB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2741F00A05;
	Wed, 11 Nov 2026 19:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426462;
	bh=PWVL6bvXnxNkJSOKiby5JwyMlo6cVWinxz0qfpmIGeM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EZnbWUUB3SGpbufZQth3XkFseKjF6chyyQRo3wuQVgSVKHPKY/l2ZOt64e0KpnJSK
	 Qvo30j5Vsa22wrFXr91mqkv7rmPzlCuDk69WYStgPgjUG5Q8o+8RvJnoQna9FPnEb7
	 NTcB4HCJAJl7rG9y4IaHzbFbRQDEcHdQOaOpiCc804xXaBJVV3UtJPZGOhEXFA7/5/
	 l4zmr4igPsiPXByDCGfV/efXTEB3mRf40oszv+sonwMDNuo/Z8TERF86xc/n2o5Qmg
	 Pz+HHF9DuOxFdEho4ezEenaIJT4QjIERQeIhTFYiZCfCuNpI1LrDAWF61cidZlTUor
	 buyxfgMbVyDsg==
Message-ID: <sashiko-outbox-209593@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7/7] vfio: selftests: Add P2P DMA selftest
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, dri-devel@lists.freedesktop.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261111192411.4133780-8-dmatlack@google.com>
References: <20261111192411.4133780-1-dmatlack@google.com>
 <20261111192411.4133780-8-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 19:47:41 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] vfio: selftests: missing -ENOTTY skip check for
  __vfio_pci_dmabuf_create()
--

commit 3d8e1bca27abb87842a5dfc06a0cde5ad88fe0fb
Author: David Matlack <dmatlack@google.com>

vfio: selftests: Add P2P DMA selftest

This commit adds vfio_pci_p2pdma_test to validate peer-to-peer DMA between
an initiator device and a target device's memory BAR across supported IOMMU
modes, including dmabuf revocation.

> diff --git a/tools/testing/selftests/vfio/vfio_pci_p2pdma_test.c b/tools/=
testing/selftests/vfio/vfio_pci_p2pdma_test.c
> new file mode 100644
> index 0000000000000..43e1537076ad1
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/vfio_pci_p2pdma_test.c
[ ... ]
> +FIXTURE_SETUP(vfio_pci_p2pdma_test)
> +{
[ ... ]
> +	if (self->iommu->iommufd) {
> +		u32 bar_idx =3D self->mem_bar.bar->info.index;
> +
> +		self->dmabuf_fd =3D __vfio_pci_dmabuf_create(self->target,
> +							   bar_idx,
> +							   self->mem_bar.offset,
> +							   bar_map_size,
> +							   O_RDWR | O_CLOEXEC);
> +		if (self->dmabuf_fd =3D=3D -EOPNOTSUPP)
> +			SKIP(return, "Kernel does not support VFIO_DEVICE_FEATURE_DMA_BUF");
> +		ASSERT_GE(self->dmabuf_fd, 0);

[Severity: Medium]
Should this check also skip when self->dmabuf_fd is -ENOTTY?  When
CONFIG_VFIO_PCI_DMABUF is disabled (or on kernels predating
VFIO_DEVICE_FEATURE_DMA_BUF), the vfio_pci_core_feature_dma_buf() stub and
vfio_pci_core_ioctl_feature() return -ENOTTY rather than -EOPNOTSUPP,
causing the iommufd test variants to fail at ASSERT_GE() instead of
skipping.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111192411.4133=
780-1-dmatlack@google.com?part=3D7
