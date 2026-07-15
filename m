Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACD5443E3F;
	Wed, 15 Jul 2026 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784139150; cv=none; b=j7U7xf9ZpLMyACdy5fNyI7knmoupr0LRYsvOqIrLvAy4/sYNqKkbB8q2VD/Rs+IjxkuOhbGUrJ/s0pnbRttuAYC2tdywBS2eJ1SFjQq5oCqia8gN9nTitfB7TGGJIKE9uJ4qRvP0hlLoM2ZvazAIzXkervk0FeSpdyk8Lr/CVnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784139150; c=relaxed/simple;
	bh=lDU099XlB0soKgRZsLw0ZoH5d5cv7bcVoQ8k+IRJzSw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iGEJ/JywWELaswu4plPg4KjMRC3X4QZnawn9whuuF2M8PFSAU1FqfeZX8jqAzw8hG1Aj+/xwWBhSxZpuvmLmNBo4shraXrnA2yuMR42qK1VoWlbU2ls2rzpgOnQUKL6+NzM67B7OtGaRlEAl/Gructhdxkbchl7AQ8vkuB+IrMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jysgfjE9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jysgfjE9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AD81F000E9;
	Wed, 15 Jul 2026 18:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784139149;
	bh=AyLvbPnD6vvkc0DU5Cso7RJBdGRUiEC2i1WT040e7oQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jysgfjE95vS0O7Ol1RAlJ8yUFtMkNNXnHkgEoqyCVuSAHuJR8pMRGqDrzuuivENs4
	 64RyU+fU8er+43aowBWde5IyorWe82qUHLpn95lyhmqyg82/8z6Hs9XxLAfcVxtUY9
	 LZ6keT28/Wu3gFFj59YkRSQvwlxrwhyjQuMdxFMVIzw6JAYkWZknAYvm8fHss/HSHl
	 T3/3BMFpaRzFOyztBZ0mfHth4U8rCMuOUdx3L4J6MnjmM51vXe2HZbFU7ebkAtwjnN
	 1wFCxGbkxwnsrkb4Y7tGye+ykkqz/7eATnkfxZN0dCFoEfshSpPQeXx2/5u55pRkSm
	 iD3tS52X6qvww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/9] vfio/pci: Add a helper to create a DMABUF for a
 BAR-map VMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Evans" <matt@ozlabs.org>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, kvm@vger.kernel.org
In-Reply-To: <20260715174737.15287-5-matt@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-5-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:12:28 +0000
Message-Id: <20260715181228.D1AD81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing bounds check on `res_index` before calling `pcim_p2pdma_=
provider()` leads to out-of-bounds array access.
--

--- Patch [4]: [PATCH v5 4/9] vfio/pci: Add a helper to create a DMABUF for=
 a BAR-map VMA ---
commit 733300e7a6e7bd6d5e79581e31e2eac09e4e5c22
Author: Matt Evans <matt@ozlabs.org>

vfio/pci: Add a helper to create a DMABUF for a BAR-map VMA

This commit adds a helper function, vfio_pci_core_mmap_prep_dmabuf(), to
create a single-range DMABUF for mapping a PCI BAR. It also refactors the
existing vfio_pci_core_feature_dma_buf() to extract common export logic.

> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
> index 7c047400dfd16..74c02794bfe28 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c

[ ... ]

> @@ -460,6 +473,75 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_co=
re_device *vdev, u32 flags,
>  	return ret;
>  }
> =20
> +int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
> +				   struct vm_area_struct *vma,
> +				   u64 phys_start, u64 req_len,
> +				   unsigned int res_index)
> +{
> +	struct vfio_pci_dma_buf *priv;

[ ... ]

> +	priv->vdev =3D vdev;
> +	priv->size =3D req_len;
> +	priv->nr_ranges =3D 1;
> +	priv->vma_pgoff_adjust =3D vma_pgoff;
> +	priv->provider =3D pcim_p2pdma_provider(vdev->pdev, res_index);

[Severity: Medium]
Is a bounds check needed on res_index before calling pcim_p2pdma_provider()?

If a caller passes an index like VFIO_PCI_ROM_REGION_INDEX (6) or higher,=20
pcim_p2pdma_provider() will index the mem[PCI_STD_NUM_BARS] array out of
bounds, returning an invalid pointer.=20

This invalid pointer could later be dereferenced by pci_p2pdma_map_type()=20
in dma_buf_phys_vec_to_sgt(), which might lead to memory corruption or cras=
hes.

> +	if (!priv->provider) {
> +		ret =3D -EINVAL;
> +		goto err_free_phys;
> +	}
> +
> +	priv->phys_vec[0].paddr =3D phys_start + ((u64)vma_pgoff << PAGE_SHIFT);
> +	priv->phys_vec[0].len =3D priv->size;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715174737.1528=
7-1-matt@ozlabs.org?part=3D4
