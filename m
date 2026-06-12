Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59849404BCF;
	Fri, 12 Jun 2026 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781282799; cv=none; b=HtoyC5/WMxE7y9hwrnAxLXjdx6NZF6RgVXbW7hZ999+W+lD9HH7uk3rshERxkyMwMqHv7gfa6/NxAV5UAme3Veh70/VQss+UBqkW0LPTbG0DGJiCwexafgm1H/m795dXjA8bu7GgcWTvm86uuWaolnVS/9vR12QxIJPb206CKPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781282799; c=relaxed/simple;
	bh=97H6GBfxd6XhqBULPCTuxLrbdbAfcvXXuiz93QslRh8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eQWrdT0+gL1E9+L+QxCNIjdKQu5BtBiLnHjcXSgRCOhaWFXYKGG7hJSzi7fKgZqiwoBiueoFSd88pEYmNpHhns+KkX97hlEJFAFx9GvLE9n9UUgGqX2niapqXoOE+PuyLWSmrx8YHRmIjfrnTAQFJPYOQsSywym9Hou3bQMHtW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohr2UhVv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohr2UhVv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092181F00A3E;
	Fri, 12 Jun 2026 16:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781282793;
	bh=1nY1pHPKgHRMmy1WoJ9Er1KDAoChru83MJwkm9RXwfE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ohr2UhVvwiEZJgsdjwG4+LjBYDp7T48ZFHLlUqpcQSjBJkXgg3ogo3DQuCrX5vTUf
	 7MM0GglyMMlcl+ZwYRfIaC1DKIk8rmaQwgcek/xLXLBBDc+YWyghujbXlxVg1b1/iv
	 jb2fnYiKc6/w459q1NMhhJ8gRBpj7P8DdsGpvQqMB19i7YdC0zCJ72WHVupLrBefMm
	 BUj1DF8Fem2RGsdGJQgwXEAhaS/LahJm5NZF2XkqGUPKkGekxRc5hBVHBtFVCYzxsy
	 e9PtxyefdIVR8OAKCMLpuUS8l9fmyM4VDSsFMJI81tjVsltMwuDmVXz8/Kts1CkLxq
	 GKR2vDU0zijkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/5] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260611161546.4075580-6-zhipingz@meta.com>
References: <20260611161546.4075580-6-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 16:46:32 +0000
Message-Id: <20260612164633.092181F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Unconditional release of ST index reference during MR cleanup =
leads to refcount underflow and WARN_ON_ONCE for ST index 0.
- [High] Pre-allocated FRMR pool handles via `ib_frmr_pools_set_pinned` fai=
l to acquire ST index references, leading to underflow on destruction.

Pre-existing issues:
- [High] Off-by-one array index in `mlx5r_create_mkeys` error path destroys=
 the wrong mkey and leaks successful allocations.
- [High] Hardware mkeys created during pinned pool expansion are leaked if =
pushing them to the pool queue fails.
--

commit b05f2090a2616db2c2747f4768f18e80acf1a2d2
Author: Zhiping Zhang <zhipingz@meta.com>
Date:   Thu Jun 11 16:11:20 2026 +0000

    RDMA/mlx5: get tph for p2p access when registering dma-buf mr
   =20
    Query dma-buf TPH metadata when registering a dma-buf MR for peer-to-
    peer access to a PCIe endpoint and use it to program requester-side TPH
    on the outbound mkey. If the exporter has no metadata, fall back to the
    existing no-TPH path.

> diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/co=
re/frmr_pools.c
> index 5e992ff3d7cff..61a77847118e6 100644
> --- a/drivers/infiniband/core/frmr_pools.c
> +++ b/drivers/infiniband/core/frmr_pools.c
> @@ -92,7 +92,8 @@ static void destroy_all_handles_in_queue(struct ib_devi=
ce *device,
>  	u32 count;
> =20
>  	while (pop_frmr_handles_page(pool, queue, &page, &count)) {
> -		pools->pool_ops->destroy_frmrs(device, page->handles, count);
> +		pools->pool_ops->destroy_frmrs(device, &pool->key,
> +					       page->handles, count);
>  		kfree(page);
>  	}
>  }

[Severity: High]
This is a pre-existing issue, but can hardware mkeys be permanently leaked
during pinned pool expansion?

If push_handle_to_queue_locked() fails inside ib_frmr_pools_set_pinned():

ib_frmr_pools_set_pinned()
   ret =3D pools->pool_ops->create_frmrs(device, key, handles, needed_handl=
es);
   for (i =3D 0; i < needed_handles; i++) {
       ret =3D push_handle_to_queue_locked(&pool->queue, handles[i]);
       if (ret)
           goto end;
   }

The array is freed, but the un-pushed hardware mkeys (from index i to
needed_handles - 1) do not appear to be cleaned up or tracked anywhere.

[ ... ]

> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
> index 14c1aec1edbbc..3ca4b36deecfc 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c

[ ... ]

> @@ -273,7 +304,8 @@ static int mlx5r_create_mkeys(struct ib_device *devic=
e, struct ib_frmr_key *key,
> =20
>  	st_index =3D key->kernel_vendor_key &
>  		   MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK;
> -	ph =3D key->kernel_vendor_key & MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK;
> +	ph =3D (key->kernel_vendor_key & MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK) >>
> +	     MLX5_FRMR_POOLS_KERNEL_KEY_PH_SHIFT;

[Severity: High]
This is a pre-existing issue, but does the error path here destroy the wrong
mkey and leak the successful allocations?

If mlx5_core_create_mkey() fails at loop index i, the code jumps to free_in:

free_in:
    kfree(in);
    if (err)
        for (; i > 0; i--)
            mlx5_core_destroy_mkey(dev->mdev, handles[i]);

Because the loop evaluates i > 0, executes for handles[i], and then
decrements, it will destroy the handle at index i (which just failed and is
invalid) and terminate before reaching index 0. Are successfully created
handles (like handles[0]) silently leaked?

[ ... ]

> @@ -311,6 +344,9 @@ static void mlx5r_destroy_mkeys(struct ib_device *dev=
ice, u32 *handles,
>  			pr_warn_ratelimited(
>  				"mlx5_ib: failed to destroy mkey %d: %d",
>  				handles[i], err);
> +		else
> +			mlx5_ib_put_frmr_st_handle_ref(dev,
> +						       key->kernel_vendor_key);
>  	}
>  }

[Severity: High]
Does this improperly drop ST index references for pre-allocated pool handle=
s?

Pre-allocated FRMR pool handles via ib_frmr_pools_set_pinned() directly call
create_frmrs() to program the hardware but do not appear to acquire the ST
index reference for them. When these handles are later destroyed during
pool aging or teardown, dropping the reference unconditionally here could
result in a deterministic refcount underflow for whichever ST index is
encoded in the key.

[ ... ]

> @@ -1419,6 +1520,8 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_ib=
_mr *mr)
>  		dma_resv_unlock(
>  			to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv);
>  	}
> +	if (!ret)
> +		mlx5_ib_mr_put_frmr_st_handle_ref(mr);
>  	return ret;
>  }

[Severity: Critical]
Could this unconditional release cause a refcount underflow and WARN_ON_ONCE
for ST index 0?

In mlx5_mr_cache_alloc(), kernel_vendor_key is explicitly initialized to 0.
Similarly, MRs created via reg_create() remain with 0 from kzalloc, and no
ST reference is ever acquired.=20

When these MRs are deregistered and hit this cleanup path,
mlx5_ib_put_frmr_st_handle_ref() extracts 0 and forwards it to
mlx5_st_dealloc_index(). Since 0 does not match the sentinel
MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX (which is 0xFFFF), it causes an
unbalanced refcount_dec_and_test() for ST index 0. Can this corrupt
legitimate PCIe endpoint steering tags?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611161546.4075=
580-1-zhipingz@meta.com?part=3D5
