Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CD32D1F44
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 00:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778719178; cv=none; b=W8tC0ELz2CaNnvIwpadbGsDlVGGh/fogO4GIHISYyI2oW4WU3PXZ3bjmhGDVEEUDl55zLFvZQmVK62adlsaxaLFfu1aZe8eLhLurOD96GUJ6ICzB/1dlbVBcEYvjxeQWrLzYa14knEthK6DBiwiR1hUYVcdIN3EfdohqxI7TqWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778719178; c=relaxed/simple;
	bh=YLuCkPVaXzuTJiDoZ125Ok8dadZxlKDubk/Qc4d+GEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P1ONk7DG0PENyQubRD/kGvugvF/1lpn/80AQEQItQPu93JqXWxnct3VxfdaWHKAA9pl8RVkKllV52m2GO7KvubV2ml05ytsE/zBYFbGhUDEp4LmxEvOlC/jkEhHpwwSO/oo/OF8HmzTgVXi8yEeungG5/RqPGAbaosRd0XnsTJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uG5PjWVJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uG5PjWVJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDEDC19425;
	Thu, 14 May 2026 00:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778719178;
	bh=YLuCkPVaXzuTJiDoZ125Ok8dadZxlKDubk/Qc4d+GEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=uG5PjWVJ91Cg5ZG1UP4X1SguU3tLOvLuOS93OAgoBQNNItWS9yV1i9ECvDABKMtIJ
	 x2mpwuLWgoHkv6gDsvh8crPltFDbI85F8u/IRcSlfMhDyoMMyIylhneSP5QKM3XBN4
	 Bpq4q+rajiYY1cLeV/Qs6hfuLrlXhm3JC4R8NG20QutyHxAJsqmwSkK65DtwHkxKC/
	 URKhpwCEufIvUMQn4r9bvyumAXmOUaJWFlbsDOmOg8d47mI30EglURhp9Xj8pdKsSZ
	 f6Bn6lmgUfCVGX68TxfjdfKYza5olY/FdTMHzbj0hagRrz9AMUAXAbD/aiCzZsoKd/
	 YOrVMbZ6w6cjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260512184755.4137227-3-zhipingz@meta.com>
References: <20260512184755.4137227-3-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 00:39:37 +0000
Message-Id: <20260514003938.8BDEDC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Use-after-handoff / Race condition of MR object after pushing to F=
RMR pool
- [High] Memory leak of `mlx5_st_idx_data` in `mlx5_st_dealloc_index()`
--

commit 2db4c0c9ad5981da4be78d996f10a6b611b880e0
Author: Zhiping Zhang <zhipingz@meta.com>
RDMA/mlx5: get tph for p2p access when registering dma-buf mr

This commit queries dma-buf TPH metadata when registering a dma-buf MR for
peer-to-peer access and translates the raw steering tag into an mlx5 ST
index. It also tracks the per-MR ownership of the allocated mlx5 ST index
on the MR and releases it once the firmware mkey no longer references it.

> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
> index 3b6da45061a55..84d570f7cafb9 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
[ ... ]
> @@ -1378,8 +1439,15 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_i=
b_mr *mr)
>  	int ret;
> =20
>  	if (mr->ibmr.frmr.pool && !mlx5_umr_revoke_mr_with_lock(mr) &&
> -	    !ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr))
> +	    !ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr)) {
> +		/*
> +		 * The mkey has been revoked: firmware no longer references
> +		 * dmabuf_st_index, so release it before this mr re-enters
> +		 * the FRMR cache for reuse by another registration.
> +		 */
> +		mlx5_ib_mr_put_dmabuf_st(mr);
>  		return 0;
> +	}

Does this introduce a race condition with MR reuse?

If ib_frmr_pool_push() succeeds, the MR is immediately inserted into the
FRMR pool and becomes available for concurrent reuse by other threads.
However, the boolean short-circuit evaluation causes
mlx5_ib_mr_put_dmabuf_st(mr) to execute after the push completes.

If another thread pops the MR and begins reinitialization before
mlx5_ib_mr_put_dmabuf_st(mr) executes, could the original thread read and
modify the newly owned MR state concurrently? This seems like it could
result in freeing the wrong steering tag index and corrupting the MR state.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/lib/st.c
> index 997be91f0a135..c5058557c7f03 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
[ ... ]
> @@ -152,6 +147,20 @@ int mlx5_st_alloc_index(struct mlx5_core_dev *dev, e=
num tph_mem_type mem_type,
>  	mutex_unlock(&st->lock);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(mlx5_st_alloc_index_by_tag);
> +
> +int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem=
_type,
> +			unsigned int cpu_uid, u16 *st_index)
> +{
> +	u16 tag;
> +	int ret;
> +
> +	ret =3D pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
> +	if (ret)
> +		return ret;
> +
> +	return mlx5_st_alloc_index_by_tag(dev, tag, st_index);
> +}
>  EXPORT_SYMBOL_GPL(mlx5_st_alloc_index);
> =20
>  int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)

While looking at these changes which tie the ST allocation to the MR
lifecycle, it appears there is a pre-existing memory leak in
mlx5_st_dealloc_index():

drivers/net/ethernet/mellanox/mlx5/core/lib/st.c:mlx5_st_dealloc_index() {
	if (refcount_dec_and_test(&idx_data->usecount)) {
		xa_erase(&st->idx_xa, st_index);
	}
}

When the reference count drops to 0, xa_erase() is called to remove the
element from the XArray, but the underlying pointer is never freed with
kfree().

Because this patch introduces per-MR allocation and deallocation of ST
indices tied to the lifetime of dma-buf MRs, could a user space application
repeatedly register and deregister dmabuf MRs to silently leak kernel
memory and eventually exhaust system memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512184755.4137=
227-1-zhipingz@meta.com?part=3D2
