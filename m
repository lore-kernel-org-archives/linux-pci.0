Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D092C346A01;
	Mon, 22 Jun 2026 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782155363; cv=none; b=ufJAiuxgUmCsJVZw3BKx4P1F3J9mSBU+lnUwCt7UefaXMgEdMfy3ka5Gtdi+ETRrk+W599OgiaS5nZ/am84drEVF0iNcJlbBqqxU6hu7naBkoJdgkcmhdWhCcdmRLGLgjopcONhNITRT917RYrfdtCLlp9u+dSUvbFbT71YdJhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782155363; c=relaxed/simple;
	bh=ignz6eQq6wkV0sI2ABcjpx+KMVQtCPG1BECMG49RH/I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fYEejkmSdQhRb4uSa2cWF7yy6sFCom6MZq+xS9L1RKrEAGL73qYRTyvEJsEi4rOe5+QwGCgyR2P1q/U5Gdby24hh1WQvC7Gpca6/PC2k7hBKLfWsVT46I8MmAAsSvrYDdJ7lJMISPoxMzkneIjqZv5NOJ+xQ2cFXikqNIl7I3Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezjO4EsJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezjO4EsJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE6B1F000E9;
	Mon, 22 Jun 2026 19:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782155362;
	bh=KIT/ERZTCyq8yFnbihT7w6olaM/rBcuMBNT11CWeBDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ezjO4EsJus6vLBAEm4LeOtsk+vpozt2kWLg+5ENOwP+ATFwmwMZf18MWp5H1ecEql
	 mwJOYuHdaCqRLXFJZQWfoAafbeFHPx8OJQAYEnXMaUIAzT+0zMkx53+62OmDULxlXG
	 PinbQa8mgUTJHlihsvYONc6sWpxvq3si29jsMnQ58N7VvHWPjknwr1QMdPNmWJQ+9n
	 ng1cu2w2CIMVtS2lrleJMJRyg4vhK8uaMAYUXxxGlTko5bmg9QVIz/PY3RxzQpZq99
	 2qFTApJhaRP5V7lH1y7yWoi5ewa+MGL0EHq7mQrhBc8BWej8DY/aGZfnsEbuBpcxw/
	 mkpK0sD7u0SEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/4] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260622184211.2229399-5-zhipingz@meta.com>
References: <20260622184211.2229399-1-zhipingz@meta.com>
 <20260622184211.2229399-5-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 19:09:21 +0000
Message-Id: <20260622190922.4AE6B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Missing ST index reference acquisition in `create_real_mr` fallbac=
k path causes a refcount underflow upon MR destruction.
- [Medium] TPH hints for pooled MRs (FRMRs) are stored in metadata but neve=
r programmed into the hardware Memory Key Context.

Pre-existing issues:
- [High] Deallocating an ST index leaks the `mlx5_st_idx_data` structure in=
 `mlx5_st_dealloc_index`.
--

commit 0757112498e4ebc4a6ffc6fad46c40d302a22056
Author: Zhiping Zhang <zhipingz@meta.com>

RDMA/mlx5: get tph for p2p access when registering dma-buf mr
   =20
This patch wires up mlx5_ib to query the exporter's chosen PCIe TLP Process=
ing
Hint (TPH) Steering Tag at MR registration time for p2p access. It uses this
metadata to program requester-side TPH on the outbound mkey and translates
exporter-provided steering tags into local ST entries.

> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
> index e6b74955d95dc..7aced3f554561 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c

[ ... ]

> @@ -335,6 +364,7 @@ static int mlx5r_build_frmr_key(struct ib_device *dev=
ice,
>  		get_unchangeable_access_flags(dev, in->access_flags);
>  	out->vendor_key =3D in->vendor_key;
>  	out->num_dma_blocks =3D in->num_dma_blocks;
> +	out->kernel_vendor_key =3D in->kernel_vendor_key;
> =20
>  	return 0;
>  }

[Severity: Medium]
While the steering tag and processing hint are stored inside the pool key h=
ere,
is there any code that actually extracts these values to program the pcie_t=
ph_en
bit or steering tag into the hardware Memory Key Context during FRMR creati=
on or
UMR WQE posting?

It appears that pooled MRs silently fall back to default non-TPH routing.

[ ... ]

> @@ -755,6 +788,12 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd=
, struct ib_umem *umem,
> =20
>  	xlt_with_umr =3D mlx5r_umr_can_load_pas(dev, umem->length);
>  	if (xlt_with_umr) {
> +		err =3D mlx5_ib_get_frmr_st_handle_ref(dev, st_index);
> +		if (err) {
> +			ib_umem_release(umem);
> +			return ERR_PTR(err);
> +		}
> +
>  		mr =3D alloc_cacheable_mr(pd, umem, iova, access_flags,
>  					MLX5_MKC_ACCESS_MODE_MTT,
>  					st_index, ph);
> @@ -769,6 +808,8 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd,=
 struct ib_umem *umem,
>  		mutex_unlock(&dev->slow_path_mutex);
>  	}

[Severity: High]
Does this create a refcount underflow for the ST index?

In the else branch (when xlt_with_umr is false), reg_create() is called
and embeds st_index into the MR's kernel_vendor_key, but it misses calling
mlx5_ib_get_frmr_st_handle_ref() to acquire a reference for the steering tag
index.=20

Later, mlx5r_handle_mkey_cleanup() unconditionally extracts st_index and
decrements its reference count via mlx5_ib_put_frmr_st_handle_ref(). Droppi=
ng
a reference that was never acquired can lead to a refcount underflow and
premature deallocation.

[ ... ]

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/lib/st.c
> index 997be91f0a135..bf14a7a6df15e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> @@ -92,23 +92,18 @@ void mlx5_st_destroy(struct mlx5_core_dev *dev)
>  	kfree(st);
>  }
> =20
> -int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem=
_type,
> -			unsigned int cpu_uid, u16 *st_index)
> +int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev, u16 tag,
> +			       u16 *st_index)
>  {
>  	struct mlx5_st_idx_data *idx_data;

[Severity: High]
This is a pre-existing issue, but does this lead to a memory leak when
deallocating an ST index?

In mlx5_st_alloc_index_by_tag() (or previously mlx5_st_alloc_index()), a new
struct mlx5_st_idx_data object is dynamically allocated with kzalloc_obj() =
and
inserted into the st->idx_xa XArray.=20

However, in mlx5_st_dealloc_index(), when the reference count drops to zero=
, the
entry is removed from the XArray using xa_erase():

    if (refcount_dec_and_test(&idx_data->usecount)) {
        xa_erase(&st->idx_xa, st_index);
        /* We leave PCI config space as was before, no mkey will refer to i=
t */
    }

The dynamically allocated idx_data pointer is never freed with kfree(). Bec=
ause
userspace can repeatedly trigger this leak by creating and destroying DMA h=
ints,
can this serve as a DoS memory exhaustion vector?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622184211.2229=
399-1-zhipingz@meta.com?part=3D4
