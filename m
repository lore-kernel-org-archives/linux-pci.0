Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713A23C1D76;
	Thu,  8 Oct 2026 06:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440840; cv=none; b=f3u8FSC/VVAEy7aJ9vquEdmVgxIU89tqEZ+dJjAGl+Qz2WS5/NZAy8LBRXAQQseiyKTSOHkv6tGaAItFbQ32LMDbxbjPpQsxo6dMFsciQ6j9xgR2bYWW5qs4WXJowhXZnt9Kic96b7O4haiO3Nb6fiO8R7IkcU5HSjXObIr2Ri8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440840; c=relaxed/simple;
	bh=Jrw91qcEJRqfJtA4yFThPK8yCWe6l97xZe4SSxiCIKw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aNcF2WaJUP1ZWZy4TtfAmQA28E+Qnp8D5LyBmppaVU65lvSukJCI/wVtp+6E0D1DTDupW59DzKmb7Wx7mdV1P8ELbaIoRONdJY50HkmCSoI/V3RplZDlHgyewMsSs8v5i56cwjQlYfJy+WXqh61BHH7GBPzRlk/o7dslUQVJmHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOUYRpDc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOUYRpDc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5311F00893;
	Thu,  8 Oct 2026 06:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791440833;
	bh=hxUFojCl5cG86MeBCZaYdnoHG8wxs+FufUnUZFJV+FI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EOUYRpDc4ZIqVJijkO8WLJK5/V2+WMzZyay1p2gSbKEGpvgA03uegA+Gzm0U+jf92
	 bm2XZEahURWUun/IbWQrts7aEVhnfo4Z5UjGxzPeh0Cg1Kux5xpbh8E/A5LR00pXcp
	 SMebxu0xJlyvP8x1ZnWvnY1nkJwEywf3NuOj3TOUaiccN6J24WR+dt7k+6Vlt8wM+9
	 fH5TlNzA6AlrpYSmniDOwu/yKwVD/nTGgRZ5Y6mLE8IqFX7JsXQze4NnVOxoKjf9/G
	 vrpCgfmXdU1Cz826JKfPbEJAk0IcT+3CtHH73zutGSakXNTqi7Dn22DRT7waRwkMn7
	 DAmaklcmDJIsw==
Message-ID: <sashiko-outbox-163690@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/16] iommufd/viommu: Select vIOMMU operations
 before allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261008055955.4014342-14-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-14-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:27:12 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] iommu: type confusion in iommufd_viommu_alloc_ioctl() parent d=
omain
- [High] iommu: dead code because amd_iommu_alloc_domain_nested is not assi=
gned
- [Low] iommu: missing viommu_type validation in amd_iommufd_get_viommu_ops
--

commit ea74b8b169fc38edaee15fa883c362684ddec72d
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Subject: iommufd/viommu: Select vIOMMU operations before allocation

This commit introduces a new get_viommu_ops callback to select vIOMMU
operations based on the device and requested type before allocation. It
moves the size and initialization callbacks into iommufd_viommu_ops and
converts multiple physical IOMMU drivers to use the new interface.

> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
> index 52300b867c1f2..c1e132382adc7 100644
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
> +	return &amd_viommu_ops;
> +}

[Severity: Low]
Does this function need to validate the requested viommu_type?

Currently, amd_iommufd_get_viommu_ops() unconditionally returns the ops
structure without checking the type argument. If a user requests an arbitra=
ry
type like IOMMU_VIOMMU_TYPE_ARM_SMMUV3 on an AMD device, the core iommufd
framework might track the vIOMMU under a mismatched architectural type
identifier.

The ARM and selftest backends appear to validate this argument against their
supported hardware types before returning the operations.

[ ... ]

> @@ -73,5 +79,7 @@ static void amd_iommufd_viommu_destroy(struct iommufd_v=
iommu *viommu)
>   * struct iommufd_viommu_ops - vIOMMU specific operations
>   */
>  static const struct iommufd_viommu_ops amd_viommu_ops =3D {
> +	.get_viommu_size =3D amd_iommufd_get_viommu_size,
> +	.viommu_init =3D amd_iommufd_viommu_init,
>  	.destroy =3D amd_iommufd_viommu_destroy,
>  };

[Severity: High]
Is the alloc_domain_nested callback missing from this operations structure?

The commit message and comments in amd_iommu_alloc_domain_nested() indicate
it should be assigned to the viommu operations. However, it is omitted here.

If a user attempts to allocate an AMD nested domain using IOMMU_HWPT_ALLOC,
won't the core framework reject it with -EOPNOTSUPP because
viommu->ops->alloc_domain_nested is NULL?

> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viomm=
u.c
> index f3d5b5a7eb4a4..e95138ae71d5b 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
[ ... ]
> @@ -103,16 +105,12 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd =
*ucmd)
>  	 */
>  	viommu->iommu_dev =3D iommu_dev;
> =20
> -	rc =3D ops->viommu_init(viommu, hwpt_paging->common.domain,
> +	rc =3D ops->viommu_init(viommu, idev->dev,
> +			      hwpt_paging->common.domain,
>  			      user_data.len ? &user_data : NULL);

[Severity: Critical]
Is there a missing check to ensure the domain is owned by the same driver
before passing it to viommu_init?

In iommufd_viommu_alloc_ioctl(), hwpt_paging->common.domain is passed direc=
tly
to the device driver's viommu_init callback. Unlike in
iommufd_hw_pagetable_alloc() which checks if parent->common.domain->owner
matches the ops, this check appears to be omitted here.

If a user allocates a paging HWPT for a mock device, and then calls
IOMMU_VIOMMU_ALLOC passing an AMD device ID but the mock HWPT ID, could the
receiving driver blindly cast the mismatched domain? For instance, AMD's
viommu_init uses to_pdomain() on the parent domain. This looks like it could
lead to type confusion and out-of-bounds accesses on the domain structure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008055955.4014=
342-1-aneesh.kumar@kernel.org?part=3D13
