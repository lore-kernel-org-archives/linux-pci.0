Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795595339;
	b=jsDO1daKo8ay6xlvwod3lgg9OEsDzvHPm7Z6cHHmq0y+EMFurluKPZ8j8j9oqHtqUku7
	 NZZ/NSETKoLA3J/NdgrfFzPVlum+rXeZ/o6fRaFw5E1gdoG0gh7jXByo2tKton2pp+8Vx
	 GfLbv23So1iJx1vskOOFCJBuGoOVsILXuiQqIc5MRIlzp5eakqCL678YCujuYeVIGoucP
	 JCrGhLAvroJPEt6U8JUKewv6d83wIjE9bwXUDQznOyoc7+VgPN9B4is3tfdbjbZJPnBv0
	 4MruB0eAvTwPcxJOnbU03YlbZV6bbulJahvJvsOK9shTYOXmnRRDdlJnFua1Ql1RgVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795595339;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ySq06g5cxa7re1sjzz84ApYAVrUTfHGeIEBLoePNFOI=;
	b=FAvCStL5BPBjG+2ovlCmQ/3xN4FxBXQybDlFYEmt2m7p9q8ztGy9Q/WcLnIdBq3NEdt8
	 s6D+ntHtpwhJIXEc8eDqnrZsh9t8yYkQKyib48MKQ626waknp5OmALnQClvO/rLs/3Nrs
	 8ESuQ2/cBrQJgZUtnpz7XC+PbT1MHzYR4r5vve74gI4eaCcrIEZOydGDJBAlMCg9ZO5dW
	 rZNeZEXthYBRYK1r8vanh4x461mxYDt1SoNKXLwByqNnpPPw7vI7iyitKtPZDBXUsPLU4
	 1OoOcZV0GFKUnPpRaW+p/ladYdlmi+LTMVvi0G2AAE2tDyGYwJvAiUWZIrAYhVJxNZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZnEvNRoT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC5E606A31E;
	Wed, 25 Nov 2026 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZnEvNRoT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CA51F000CF;
	Wed, 25 Nov 2026 08:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795595338;
	bh=ySq06g5cxa7re1sjzz84ApYAVrUTfHGeIEBLoePNFOI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZnEvNRoT62t0t2kSUS3fDeh4HQ0IQjNb1V3XT/Gew+/TQ1xvOVxnUHt8VuEYN6ozo
	 KfCTThjayApqItcudi4OZ0hQJ3MuxL/s2z4GZ5Y51QDJB4BApK56ey3/+FKbgMdD7M
	 yJskjex9tJP3qGoprJseFjoGzbC4mi4vXxB2wUIMLxhdyER/xETaejG3RlAWyi10EX
	 QdVcVtXw4I+0+KKOAk98lFdja7YcFBxskbkwWTbZee7sox5pK/tO3/t4B0vI+NW6CP
	 VyTwHQI3qzTFXLctegX8P/lDW4VBuRURZ3WSQ/tvFOJoDuiDdIqgBrAQp/sI/H7Ont
	 95Hrlm6mWtOCQ==
Message-ID: <sashiko-outbox-232900@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 12/18] iommufd/viommu: Select vIOMMU operations
 before allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261125081121.379481-13-aneesh.kumar@kernel.org>
References: <20261125081121.379481-1-aneesh.kumar@kernel.org>
 <20261125081121.379481-13-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 08:28:57 +0000
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
- [Low] iommu/amd: unreferenced amd_viommu_ops in
  drivers/iommu/amd/iommufd.c
--

commit 20918297bf65ffa4cc97b5bf68fa703d00f55ba5
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

iommufd/viommu: Select vIOMMU operations before allocation

This commit adds iommu_ops::get_viommu_ops() to select vIOMMU operations
before allocation, moves get_viommu_size and viommu_init into
iommufd_viommu_ops, and converts AMD, Arm SMMUv3, Tegra CMDQV, and the
selftest backend to the new interface.

> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
> index 52300b867c1f2..dcbe80fcb8c70 100644
> --- a/drivers/iommu/amd/iommufd.c
> +++ b/drivers/iommu/amd/iommufd.c
> @@ -32,13 +32,21 @@ void *amd_iommufd_hw_info(struct device *dev, u32 *le=
ngth, enum iommu_hw_info_ty
>  	return hwinfo;
>  }
> =20
> -size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu=
_type viommu_type)
> +static size_t amd_iommufd_get_viommu_size(struct device *dev,
> +		enum iommu_viommu_type viommu_type)
>  {
>  	return VIOMMU_STRUCT_SIZE(struct amd_iommu_viommu, core);
>  }
> =20
> -int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_=
domain *parent,
> -			    const struct iommu_user_data *user_data)
> +const struct iommufd_viommu_ops *
> +amd_iommufd_get_viommu_ops(struct device *dev, enum iommu_viommu_type vi=
ommu_type)
> +{
> +	return NULL;
> +}
> +
> +int amd_iommufd_viommu_init(struct iommufd_viommu *viommu,
> +		struct device *dev, struct iommu_domain *parent,
> +		const struct iommu_user_data *user_data)
>  {
>  	unsigned long flags;
>  	struct protection_domain *pdom =3D to_pdomain(parent);
> @@ -47,8 +55,6 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viom=
mu, struct iommu_domain *
>  	xa_init_flags(&aviommu->gdomid_array, XA_FLAGS_ALLOC1);
>  	aviommu->parent =3D pdom;
> =20
> -	viommu->ops =3D &amd_viommu_ops;
> -
>  	spin_lock_irqsave(&pdom->lock, flags);
>  	list_add(&aviommu->pdom_list, &pdom->viommu_list);
>  	spin_unlock_irqrestore(&pdom->lock, flags);
> @@ -73,5 +79,7 @@ static void amd_iommufd_viommu_destroy(struct iommufd_v=
iommu *viommu)
>   * struct iommufd_viommu_ops - vIOMMU specific operations
>   */
>  static const struct iommufd_viommu_ops amd_viommu_ops =3D {
> +	.get_viommu_size =3D amd_iommufd_get_viommu_size,
> +	.viommu_init =3D amd_iommufd_viommu_init,
>  	.destroy =3D amd_iommufd_viommu_destroy,
>  };

[Severity: Low]
As reported by kernel test robot on v8 [1], does leaving amd_viommu_ops
unreferenced trigger a -Wunused-const-variable warning when building with
W=3D1?

Removing viommu->ops =3D &amd_viommu_ops from amd_iommufd_viommu_init() and
returning NULL from amd_iommufd_get_viommu_ops() leaves amd_viommu_ops with
no references in drivers/iommu/amd/iommufd.c.  Also,
amd_iommufd_viommu_init() is no longer used outside this file and can be
made static instead of being declared in drivers/iommu/amd/iommufd.h.

[1] https://lore.kernel.org/r/202611051602.nH0L0uqs-lkp@intel.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125081121.3794=
81-1-aneesh.kumar@kernel.org?part=3D12
