Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793812489;
	b=ib/CYvN0raXNyQGEN8xn1dEtuZnR2nwFiUkF2jG9n5UILwKW440sGlXlnp6p99M45Eu6
	 mPMTf2fiuBO6y/thG7xESY/5YF0DNZOEgRymc/lhlAZ6hbuYMTP+Vq5yUqkP8cx0w/d5F
	 0yizMPpPaEnDKiWKJVkTE6/gJRQxCKGu/CDYSUzpGMUKD98YcGnhZJd0QI5wKSt7BsUwA
	 GdZugaH/VIH8Tr4Y4TYiX0aIJIxCb8cyZWQddEPk24BveyXPPCw0B6c/ovWG44KKdBArP
	 yOTpv0OtdbPL4ZtumbKxYDb+qukctnc1CNLGVgsBzyS4iCc9VDdTDnezbBFNmOtHSag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812489;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zBLuS7KcvPPvzcqFzftdFFUuKuWQXxuUALMNA6Kj5gE=;
	b=uAcgcNKTMgQ3oDMUyvRpcj8GRVVPLEWfETORra+euqBHBnS1YMtVFF5+gr/YPDS2SG6P
	 h3NavI/zTAGPN3/f+Zp/7YxvDVsnyk5xtZzL5lt6cRqfQSzx78z0xR4RCXHkFw+l4h2BO
	 iB049rxXHRKzEMQTRpS0D9ofycHKL/C7AzgF12e8SdItC0l4/COpNTe/St3Y9TlLJDJ6E
	 4oXJS8UlM71fMDpD0o4xAI7kQnDv1U54V0dMtq5dgIG0F3Ztmc1NO9HhS+xe4Q9oTmT9s
	 Z1alWgYRdtNJaeKrzrg0iGBN4bsBx3Z/p/7puj5ueUYNtHOcjoPsVJt6LXUtKBk3G8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Po8/B4ic";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F069A606A31B;
	Wed,  4 Nov 2026 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Po8/B4ic
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AB41F000C1;
	Wed,  4 Nov 2026 17:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793812488;
	bh=zBLuS7KcvPPvzcqFzftdFFUuKuWQXxuUALMNA6Kj5gE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Po8/B4icTWM2pnJAtqtQF7uhCxATjmvzfCfV8HJV0dq3yAAHRIU9eDWu3A19bZdA0
	 wH3Aq4fGxdUWMvWJ7UORHhrsHbFt3JzW8OT/5eyOf7klqK4J0XiCYetIDdQkLTAYKx
	 shsYzSy/uCtqbnh8hUVX2yVERllMBvoHmsuzZMmzXi4M32TZ8ezmfEFd1BzWNwDOyT
	 LnQ7GdKsqEjZLdPce9aEnrbRq+QPF1nP24CzgXoKKgexM8WLVGa7Rzb0tyjKtjYbO/
	 mnOO5tQEBpFsnMPc9ErJPR/bmz2VIGo0UykIWMN4JyYZarQcLwidgRH6YEcve6nE24
	 UHXfmBLMEX7dQ==
Message-ID: <sashiko-outbox-197747@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/15] iommufd/viommu: Select vIOMMU operations
 before allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261104161632.3547423-12-aneesh.kumar@kernel.org>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-12-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 17:14:47 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] iommu/amd: unreferenced amd_viommu_ops after amd_iommufd_get_viommu=
_ops()
--

commit 7d905a9d1ce6388259ae73f7d0cf19d414cd5da4
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

iommufd/viommu: Select vIOMMU operations before allocation

This commit adds iommu_ops::get_viommu_ops() to select vIOMMU operations
before allocation and moves get_viommu_size() and viommu_init() into
struct iommufd_viommu_ops across the IOMMUFD core and backend drivers.

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
> diff --git a/drivers/iommu/amd/iommufd.h b/drivers/iommu/amd/iommufd.h
> index 62e9e1bebfbe5..0d8e7c0902cff 100644
> --- a/drivers/iommu/amd/iommufd.h
> +++ b/drivers/iommu/amd/iommufd.h
> @@ -8,13 +8,16 @@
> =20
>  #if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
>  void *amd_iommufd_hw_info(struct device *dev, u32 *length, enum iommu_hw=
_info_type *type);
> -size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu=
_type viommu_type);
> -int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_=
domain *parent,
> -			    const struct iommu_user_data *user_data);
> +const struct iommufd_viommu_ops *
> +amd_iommufd_get_viommu_ops(struct device *dev,
> +		enum iommu_viommu_type viommu_type);
> +int amd_iommufd_viommu_init(struct iommufd_viommu *viommu,
> +		struct device *dev, struct iommu_domain *parent,
> +		const struct iommu_user_data *user_data);
>  #else
>  #define amd_iommufd_hw_info NULL
>  #define amd_iommufd_viommu_init NULL
> -#define amd_iommufd_get_viommu_size NULL
> +#define amd_iommufd_get_viommu_ops NULL
>  #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
> =20
>  #endif /* AMD_IOMMUFD_H */

[Severity: Low]
With viommu->ops =3D &amd_viommu_ops removed from amd_iommufd_viommu_init()
and amd_iommufd_get_viommu_ops() unconditionally returning NULL,
amd_viommu_ops in drivers/iommu/amd/iommufd.c has no remaining references.

When building with CONFIG_AMD_IOMMU_IOMMUFD=3Dy, won't this trigger
-Wunused-const-variable warnings on amd_viommu_ops under W=3D1 (and Clang
-Wunused-function warnings on its static callbacks)?

Also, since amd_iommufd_viommu_init() is no longer referenced from
drivers/iommu/amd/iommu.c, should it be made static in
drivers/iommu/amd/iommufd.c and removed from drivers/iommu/amd/iommufd.h,
with amd_viommu_ops marked __maybe_unused while AMD vIOMMU allocation is
disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104161632.3547=
423-1-aneesh.kumar@kernel.org?part=3D11
