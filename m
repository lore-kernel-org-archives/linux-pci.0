Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC6C30E0E5;
	Fri, 31 Jul 2026 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785534503; cv=none; b=Cesjkq9njgBspb0jgyzpImVM2iObQfdNiglUayZ/ziE4Xc20+F0ODvAjJiWsYu+c8GjN+EZ68ycWeN3I/9GYXanHl2Z14O7JuL3AiC19WytkIcFrqbtKOSWgdjLf/anapwXEf+IJ7WD+GlxNKZhuL92JqA0rgOtKhIbYc6YR9aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785534503; c=relaxed/simple;
	bh=3/NClTxe5VbcldsiokUIagkgtDvo4dUkfxuvqCYWDzE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JMF9fG7HuaFAPc1iKh/IGsA4x6GcT/Su46cqs0vL/K5Da6TbC4vrfDG8PchfqHekMVToGVE+jpzkKhQ5HdmSNVvbkPMwb3576Hw28QGxqvH4dCfNNUmkc87xzMB6FrcGTYJBhtzMVzjsrSqfDprFbc0qWqKMIO5yRb5+WlKbA4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ote8amyE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ote8amyE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9AA1F00AC4;
	Fri, 31 Jul 2026 21:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785534501;
	bh=Ohai3lT/v4Dkr4FfRr2MhoK5iDfHPwKo7V8NpbjUEzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ote8amyEjyBOij/3z6FwasSVDdvFOGIoSZjkfWGPINYpVJ3I6QFyCu/n/foiRRwt3
	 xle8IeoISAvtWCDyCIUMDmxBgtc0RYsvHkwwnSS/ep5bsfBshFz/kmrCTv2ntbKver
	 jclGs8VYIoGQpgtEGheSaJTmemnhCTKRLAnzpYfiCMXft3WsypvbZ7WjXJVZJWrXlI
	 nwyvkoYbLa30yfp+6YsLOPw3OqgJd4SO/251XWOpvFx/2I94KeqrgRvGhZLaycxddE
	 VoczJjle02DL/4Rx3DVn+eWaJrAViSFocv6VGzr8yJcTwvefZMhLmntaXnPAMMuTti
	 HWRuKBaq3ZqCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 5/5] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260731211601.3033906-6-zhipingz@meta.com>
References: <20260731211601.3033906-1-zhipingz@meta.com>
 <20260731211601.3033906-6-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 21:48:20 +0000
Message-Id: <20260731214821.2A9AA1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] mlx5_st_dealloc_index leaks the idx_data struct when erasing it fr=
om the xarray.
--

--- Patch [5]: [PATCH v13 5/5] RDMA/mlx5: get tph for p2p access when regis=
tering dma-buf mr ---
commit cb1e1bfb29faeb4a7f3d550176e3590d73486a3e
Author: Zhiping Zhang <zhipingz@meta.com>

RDMA/mlx5: get tph for p2p access when registering dma-buf mr

This commit wires up mlx5_ib to query the exporter's chosen PCIe TLP
Processing Hint (TPH) Steering Tag at MR registration time for peer-to-peer
DMA access. It translates the exporter-provided steering tags into local ST
entries or uses default routing if no hint is available.

> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
> index 00e13028762ae..fdd7d94bd4aa4 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -167,6 +168,61 @@ static int get_unchangeable_access_flags(struct mlx5=
_ib_dev *dev,
>  #define MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK GENMASK_ULL(23, 16)
>  #define MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK GENMASK_ULL(15, 0)
> =20
> +static u8 mlx5_ib_tph_key_ph(u8 ph)
> +{
> +	if (ph =3D=3D MLX5_IB_NO_PH || ph =3D=3D 0)
> +		ph ^=3D MLX5_IB_NO_PH;
> +
> +	return ph;
> +}
> +
> +static int mlx5_ib_get_st_handle_ref(struct mlx5_ib_dev *dev, u16 st_ind=
ex)
> +{
> +	if (st_index =3D=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
> +		return 0;
> +
> +	return mlx5_st_get_index(dev->mdev, st_index);
> +}
> +
> +static void mlx5_ib_put_st_index_ref(struct mlx5_ib_dev *dev, u16 st_ind=
ex)
> +{
> +	if (st_index =3D=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
> +		return;
> +
> +	mlx5_st_dealloc_index(dev->mdev, st_index);

[Severity: High]
This is a pre-existing issue, but this patch introduces a new, heavily-exer=
cised
reachable path for it.

Does mlx5_st_dealloc_index() leak the mlx5_st_idx_data struct when erasing =
it
from the xarray?

When a steering tag's reference count drops to zero, the entry is removed v=
ia
xa_erase():

drivers/net/ethernet/mellanox/mlx5/core/lib/st.c:mlx5_st_dealloc_index() {
    ...
	if (refcount_dec_and_test(&idx_data->usecount)) {
		xa_erase(&st->idx_xa, st_index);
		/* We leave PCI config space as was before, no mkey will refer to it */
	}
    ...
}

However, the underlying idx_data pointer is not freed with kfree(idx_data).

Because the next time the same tag is requested, a new struct is allocated =
via
kzalloc_obj() in mlx5_st_alloc_index_by_tag(), won't repeated allocations a=
nd
deallocations lead to an unbounded kernel memory leak?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731211601.3033=
906-1-zhipingz@meta.com?part=3D5
