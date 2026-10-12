Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AE9397694;
	Mon, 12 Oct 2026 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791797883; cv=none; b=O/pv1z3nzZTan6Xg12qWaglXqB1TQYbbqyM2C7R07VpArRawX2I0pgQ/M8Q8xXkEOdBFH6P+X5cgeM3I75Qfs+Pa59IgExDacLD2ZAUfB0Ge576tt5ElSrKifvZ5QtXoQtBBCaqiWV1BcpqLt53m7MvV9PkrNR1Yfc4VdqoYFZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791797883; c=relaxed/simple;
	bh=/qeI+mcky6POL+dlz67XlDlJlP/m1BDsglDrCc5muCs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rZdJ1/cU5tZHt71ZVJN3b0bOIb/d2k06ZE88rbaEbGQIygwTyL3wHc3kCTwwIpMcsIYnI/ysoqVepkHIcPqQjT/Q8oxXAEYkj9s5Yiq2XRiIPBbQCnsUoz6bVS7zQHX4EV844trci0+g1gW1jr5DpOqAghyIk6expYIwqwaPJO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVUsClFs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVUsClFs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2418B1F0089B;
	Mon, 12 Oct 2026 09:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791797881;
	bh=0C26uGtxqGDVfiyGSgCVeY4+duEFxvfuAlVAP2wPEcs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=JVUsClFsxTuCO4Jmd/9nLXrOUsWXPkEOYrHSWzLp38vEwjWv6WeveWcOoSAiqD+B7
	 iX7iS8E2mZWedWmZdX7CIAkLrcRPOWzzHNhK9PviT4ai91qeuWwwwH9FH+yDgS4Hwh
	 v0AKgicoMJ5QsJxyFN5cBUoNcPr/dx0KskoGKRVv7sD+PjZ+dC54aPEEtzPXT3PnZC
	 hE2jzEmeYQrptnVWB6sNTpEh+EUjWI2HrWgpnoFqJ5wSn5WJKETtmGBXWr5zTQq8ve
	 6irzeFMcu1iQTEpLcu9SeEKi23bSH4YEnt2UX60BwUeND8Pnj3R8PTJcAO5JTJWcBI
	 O+0nwsD7XMWMg==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: sashiko-reviews@lists.linux.dev, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 13/16] iommufd/viommu: Select vIOMMU operations
 before allocation
In-Reply-To: <sashiko-outbox-163690@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-14-aneesh.kumar@kernel.org>
 <sashiko-outbox-163690@kernel.org>
Date: Mon, 12 Oct 2026 15:07:57 +0530
Message-ID: <yq5azewj45u2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Critical] iommu: type confusion in iommufd_viommu_alloc_ioctl() parent domain
> - [High] iommu: dead code because amd_iommu_alloc_domain_nested is not assigned
> - [Low] iommu: missing viommu_type validation in amd_iommufd_get_viommu_ops
> --
>
> commit ea74b8b169fc38edaee15fa883c362684ddec72d
> Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Subject: iommufd/viommu: Select vIOMMU operations before allocation
>
> This commit introduces a new get_viommu_ops callback to select vIOMMU
> operations based on the device and requested type before allocation. It
> moves the size and initialization callbacks into iommufd_viommu_ops and
> converts multiple physical IOMMU drivers to use the new interface.
>
>> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
>> index 52300b867c1f2..c1e132382adc7 100644
>> --- a/drivers/iommu/amd/iommufd.c
>> +++ b/drivers/iommu/amd/iommufd.c
>> @@ -32,13 +32,21 @@ void *amd_iommufd_hw_info(struct device *dev, u32 *length, enum iommu_hw_info_ty
>>  	return hwinfo;
>>  }
>>  
>> -size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type viommu_type)
>> +static size_t amd_iommufd_get_viommu_size(struct device *dev,
>> +		enum iommu_viommu_type viommu_type)
>>  {
>>  	return VIOMMU_STRUCT_SIZE(struct amd_iommu_viommu, core);
>>  }
>>  
>> -int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
>> -			    const struct iommu_user_data *user_data)
>> +const struct iommufd_viommu_ops *
>> +amd_iommufd_get_viommu_ops(struct device *dev, enum iommu_viommu_type viommu_type)
>> +{
>> +	return &amd_viommu_ops;
>> +}
>
> [Severity: Low]
> Does this function need to validate the requested viommu_type?
>
> Currently, amd_iommufd_get_viommu_ops() unconditionally returns the ops
> structure without checking the type argument. If a user requests an arbitrary
> type like IOMMU_VIOMMU_TYPE_ARM_SMMUV3 on an AMD device, the core iommufd
> framework might track the vIOMMU under a mismatched architectural type
> identifier.
>
> The ARM and selftest backends appear to validate this argument against their
> supported hardware types before returning the operations.
>
> [ ... ]
>

No vIOMMU type has been added for any IOMMU other than Arm. The
documentation also considers IOMMU_VIOMMU_TYPE_DEFAULT reserved.

>> @@ -73,5 +79,7 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
>>   * struct iommufd_viommu_ops - vIOMMU specific operations
>>   */
>>  static const struct iommufd_viommu_ops amd_viommu_ops = {
>> +	.get_viommu_size = amd_iommufd_get_viommu_size,
>> +	.viommu_init = amd_iommufd_viommu_init,
>>  	.destroy = amd_iommufd_viommu_destroy,
>>  };
>
> [Severity: High]
> Is the alloc_domain_nested callback missing from this operations structure?
>
> The commit message and comments in amd_iommu_alloc_domain_nested() indicate
> it should be assigned to the viommu operations. However, it is omitted here.
>
> If a user attempts to allocate an AMD nested domain using IOMMU_HWPT_ALLOC,
> won't the core framework reject it with -EOPNOTSUPP because
> viommu->ops->alloc_domain_nested is NULL?
>

It is unclear whether nested domain support is fully integrated for AMD.
I see amd_iommu_alloc_domain_nested(), but cannot find any callers.

>> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
>> index f3d5b5a7eb4a4..e95138ae71d5b 100644
>> --- a/drivers/iommu/iommufd/viommu.c
>> +++ b/drivers/iommu/iommufd/viommu.c
> [ ... ]
>> @@ -103,16 +105,12 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
>>  	 */
>>  	viommu->iommu_dev = iommu_dev;
>>  
>> -	rc = ops->viommu_init(viommu, hwpt_paging->common.domain,
>> +	rc = ops->viommu_init(viommu, idev->dev,
>> +			      hwpt_paging->common.domain,
>>  			      user_data.len ? &user_data : NULL);
>
> [Severity: Critical]
> Is there a missing check to ensure the domain is owned by the same driver
> before passing it to viommu_init?
>


The viommu_init callback needs to perform this check. For example, the
Arm implementation does:

	ret = arm_smmu_validate_parent(smmu, parent_domain);
	if (ret)
		return ret;



> In iommufd_viommu_alloc_ioctl(), hwpt_paging->common.domain is passed directly
> to the device driver's viommu_init callback. Unlike in
> iommufd_hw_pagetable_alloc() which checks if parent->common.domain->owner
> matches the ops, this check appears to be omitted here.
>
> If a user allocates a paging HWPT for a mock device, and then calls
> IOMMU_VIOMMU_ALLOC passing an AMD device ID but the mock HWPT ID, could the
> receiving driver blindly cast the mismatched domain? For instance, AMD's
> viommu_init uses to_pdomain() on the parent domain. This looks like it could
> lead to type confusion and out-of-bounds accesses on the domain structure.
>

-aneesh
