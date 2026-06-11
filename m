Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3384D3A6B76;
	Thu, 11 Jun 2026 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209562; cv=none; b=fhbg2/KPwN2sKSXOz7GRY3zYfFi3s9htyfG7PqR5K/5c9xEaEufjTSdkjmyxVKQGgsju4pqRNB2pPKeQzl3kEY3OGLEIgkejy5NsY+ul1sn25s/DcQ75yduSI4zQ9qGf4ILBx0IELhSH/rZ/zwhvO+MKsj54sYaR8GZH+yawC7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209562; c=relaxed/simple;
	bh=9auOMoPvpNl3avIAPuLdCMF2oDh8LZqoDQV7EUI3m/A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hZczV1lhR/jxmhDnrnkedL1kL4zOx6anaOL2lBDuQ57PgRBaze9kqzvbnVISn0VhC/9CJGwQZJD0DqAppvSw2jq567znGHE0s6Io1OoHKzEiFxXQYMhKavei7NZWfMU0rMFlmMBW9UMKu02ku82Bz+t+j2oEJ+QTjPWqTOtDcoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n08kEcPg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n08kEcPg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EF21F000E9;
	Thu, 11 Jun 2026 20:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781209559;
	bh=STvMrLJffPmLGT5LWmY4jKECc2USvp9zYePXFiZNp4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n08kEcPg891VJZRixmwP3PrrS7CmKR2fJk9T+OrNKBfK4NZd4SRU4LObMeNBKUJ8+
	 cJp40gK5iEk728cnGeo8Pvy+IcElt3MKd0ZXHa0SjV6xJJfNhLBYJ1MA1lxJbgfWFO
	 OSHM4pocYqZgcxLwt9gcOLGxNQPOjtBAjhZ9XG1mLou+7SHO/gb0VgWRyJTbykAgKp
	 BM1cea6nSXIA3b8h0RutTSJNf+MaVSbpW4gE86xlFWDYEngbJ/zfxZ1yjpRt7D/gd6
	 fc+80lls4Un/ZHzr6HrR4eRFOuihgiKauxVem4sbI4YHAFPspXnd+A+OF4zjMtwroO
	 JwKgAjm1NcWnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/5] net/mlx5: free mlx5_st_idx_data on final dealloc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260610193158.2614209-2-zhipingz@meta.com>
References: <20260610193158.2614209-2-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 20:25:58 +0000
Message-Id: <20260611202559.80EF21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Out-of-bounds read in UVERBS_METHOD_DMAH_ALLOC handler due to =
missing bounds check on user-supplied cpu_id.
--

commit efb72743b37fe4c5005fca2d75b36ef50832bc6c
Author: Zhiping Zhang <zhipingz@meta.com>

net/mlx5: free mlx5_st_idx_data on final dealloc
   =20
When the last reference to an ST table entry is dropped,
mlx5_st_dealloc_index() removed the entry from idx_xa but leaked the
backing mlx5_st_idx_data allocation. Repeated alloc/dealloc cycles
therefore accumulate one struct mlx5_st_idx_data per cycle.
   =20
Free idx_data after the xa_erase() so the lifetime of the bookkeeping
struct matches the lifetime of the ST entry it tracks.
   =20
Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/lib/st.c
> index 997be91f0a135..7cedc348790db 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> @@ -175,6 +175,7 @@ int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, =
u16 st_index)
> =20
>  	if (refcount_dec_and_test(&idx_data->usecount)) {
>  		xa_erase(&st->idx_xa, st_index);
> +		kfree(idx_data);
>  		/* We leave PCI config space as was before, no mkey will refer to it */
>  	}
> =20

[Severity: Critical]
This is a pre-existing issue, but does
UVERBS_HANDLER(UVERBS_METHOD_DMAH_ALLOC) in
drivers/infiniband/core/uverbs_std_types_dmah.c lack bounds checking on the
untrusted user-supplied dmah->cpu_id?

drivers/infiniband/core/uverbs_std_types_dmah.c:UVERBS_HANDLER(UVERBS_METHO=
D_DMAH_ALLOC)() {
    ...
		ret =3D uverbs_copy_from(&dmah->cpu_id, attrs,
				       UVERBS_ATTR_ALLOC_DMAH_CPU_ID);
		if (ret)
			goto err;

		if (!cpumask_test_cpu(dmah->cpu_id, current->cpus_ptr)) {
			ret =3D -EPERM;
			goto err;
		}
    ...
}

The dmah->cpu_id is copied directly from an untrusted uverbs attribute
without value validation.

Since cpumask_check only emits a warning if the CPU ID is out of bounds and
does not cap the value, could test_bit compute a bit offset far outside the
bounds of current->cpus_ptr?

Can an attacker exploit this to read unmapped kernel memory (causing a kern=
el
panic) or infer the contents of kernel memory by observing whether the
syscall succeeds or fails with -EPERM?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610193158.2614=
209-1-zhipingz@meta.com?part=3D1
