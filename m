Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A3D368D5A;
	Thu,  2 Jul 2026 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783017734; cv=none; b=oGrhdecHV5oMHY5rAL3Slc+2MM1LhLg3nJz/4VWphuDKpO5NuhkEUypW8N5/77rfC4BsrCEKcHMAjBm5AKc8/LV13abAPWBi+xe4qWQfOTJyxpSCHH7HTX9SuMrvRJAIrVUhcxB5+N9vNOLvWqhViGNavzqNcXc3Dd40n7jAUao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783017734; c=relaxed/simple;
	bh=AnlbmVc7bp/EDu5i/7icvu+dEtDRGCrTIS/8BwF8+pY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TB8lf3PW+OWJswp5jMhzOEJ7MudnrsAl1gBkRl46c1SzmE5qqeaDA29Gv6H99w6NuayNNBIXMtyIY+XIYv1Z1eXvBy0hNLLic96U/JIfuzPh3uxYfpA8VSU4dx46t/whJkVLSEEhkZ74Z3y3ngeETX+4wwqI5Uui9+L7GflxOa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oay3GZcq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oay3GZcq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1161F00A3D;
	Thu,  2 Jul 2026 18:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783017732;
	bh=mSNaagGrGaEd7SbyyZ4Ns3brb6JZz2ddeOYEpwPmzWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oay3GZcqNn4Hv7Y+UbdXvC9TLgQHkXU1MI5/GIq6rHdjdLK6WHdhLhzu5xv99F2Wy
	 yQa0u1n5rN2ZcoXnC/3iqvoAFvBcNN6bPbzQkUDEUeSCUkDjTzKGAy2sKKweuLNEOm
	 XG/Ux3fxLGY9aiXj9Bs5adOOB/dJta7Je7U0j351CPpSilM99sBgXbcFAG2A0DoLlZ
	 oEjiCvYbfLdT3GCEiRB/uUvZLwVR33An3+6ioc4scujTp1GnvyJ7hMldpbP+Zia1PZ
	 39nMe9qmBJ2ZhoRhYtPDhsDV4DTlDLK4zdXTfe80OyzV4nORI0Y9KTR/8jACJMpXUZ
	 nFeQwF+aL0Mew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 4/4] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: dri-devel@lists.freedesktop.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260702181025.2694961-5-zhipingz@meta.com>
References: <20260702181025.2694961-1-zhipingz@meta.com>
 <20260702181025.2694961-5-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 18:42:12 +0000
Message-Id: <20260702184212.AD1161F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Failure to re-query PCIe TPH metadata upon DMA-buf invalidation

Pre-existing issues:
- [High] Memory leak of struct mlx5_st_idx_data in mlx5_st_dealloc_index()
--

commit e39795c3bd224c81bae70b87815075c4489e3f9e
Author: Zhiping Zhang <zhipingz@meta.com>
Subject: RDMA/mlx5: get tph for p2p access when registering dma-buf mr

This commit allows the mlx5 importer to query a dma-buf exporter's chosen
PCIe TLP Processing Hint (TPH) Steering Tag. It updates MR registration to
use this metadata for p2p access and program requester-side TPH on the
outbound mkey, falling back to no-TPH routing if unavailable.

> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
> index e6b74955d95dc..55216ae637614 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
[ ... ]
> @@ -903,6 +947,52 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_atta=
ch_ops =3D {
>  	.invalidate_mappings =3D mlx5_ib_dmabuf_invalidate_cb,
>  };
> =20
> +static void get_pci_tph_mr_dmabuf(struct mlx5_ib_dev *dev, struct dma_bu=
f *dmabuf,
> +				  u16 *st_index, u8 *ph)

[Severity: Medium]
When an unpinned DMA-buf MR is invalidated and then subsequently faulted ba=
ck
in via pagefault_dmabuf_mr() in drivers/infiniband/hw/mlx5/odp.c, the driver
calls ib_umem_dmabuf_map_pages() to map the pages, but it doesn't seem to
re-query the TPH metadata using get_pci_tph_mr_dmabuf() or
dma_buf_get_pci_tph().

Since the exporter might move the memory and change the preferred TPH steer=
ing
tag, does the driver need to re-evaluate the TPH metadata upon invalidation
and re-mapping to ensure DMA traffic isn't sent to a stale or suboptimal
NUMA node?

> +{
> +	u16 local_st_index;
> +	u16 steering_tag;
[ ... ]
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/lib/st.c
> index 997be91f0a135..bf14a7a6df15e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
[ ... ]
> @@ -152,8 +147,46 @@ int mlx5_st_alloc_index(struct mlx5_core_dev *dev, e=
num tph_mem_type mem_type,
>  	mutex_unlock(&st->lock);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(mlx5_st_alloc_index_by_tag);
[ ... ]
> +EXPORT_SYMBOL_GPL(mlx5_st_get_index);
> +
>  int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)
>  {
>  	struct mlx5_st_idx_data *idx_data;

[Severity: High]
This is a pre-existing issue, but I noticed it while reviewing this patch
since this patch broadens its exposure.

In mlx5_st_dealloc_index(), when the use count reaches zero:

	if (refcount_dec_and_test(&idx_data->usecount)) {
		xa_erase(&st->idx_xa, st_index);
		/* We leave PCI config space as was before, no mkey will refer to it */
	}

Is there a memory leak here? The dynamically allocated idx_data is erased f=
rom
the xarray but does not appear to be passed to kfree().

Since unprivileged users can repeatedly create and destroy MRs, could this
lead to kernel memory exhaustion over time?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702181025.2694=
961-1-zhipingz@meta.com?part=3D4
