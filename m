Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44302EEE60;
	Tue, 13 Oct 2026 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882712; cv=none; b=IVh7W/p78qD6otVp2tF+ugEI4iDV0ePeigqrC3VhUOzs/C8y7Nzr3uyXXwOQSzZCpopRQfR84iWSdXUtu+k0QaEKi7DMS/mBzJm2FSrtI4hH6Dcdfzn69gl/UIWJZyxxm80naPLBIE6zv1rlN8TAlGtsd9+4tC3Adg8e9P62Gvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882712; c=relaxed/simple;
	bh=1GDEdYYiTGxrYqK/ynxihYv50FV3RVHXamEOPKTbEmY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=shaZ75owZsU+11C3KYFwVluj2E3kJARwcwnzfE38A0JmRCNTrRJRk2cSZQrgdNq87u4K2aHy1OZVTyzoIQYz2cCd5OGXd2y+rmsgzsXTidQcduY62XbVzZjaA3XABHtx5S/0qpuJX3moLBwYBHSV5bqAJmKjq0S5581k17Y4QY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+CmNDNm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+CmNDNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8591F000FF;
	Tue, 13 Oct 2026 09:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791882711;
	bh=/dPrLzH4NXCTERzYwyjyTc4ohsgaQKqLbZfNj0bQRMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=e+CmNDNm3jmp6bRulMaLPV48yxWsHF78sjT3i2w2kVLtU5qiNU03SDD2TVH/RS1gZ
	 33rOTWPp2Yf4BaGN0qM20fHspQWSIUWXgR0XkY60QNTfcJAAzd6I28HNS3y5+Terbz
	 HmP1ku4zb9gQbEyKr2zo/f/rz9u3MVx8W86xh0PMOin5dVx5I5vb1zrPAVBxDYBXOf
	 r/eQ4nVCSUVBwTGTIVxCnG6NXr2kw/u54zcDb7/2QUtWsKVZaUfadFICTXDbD/+B1X
	 LlGy5RfhOd7TqFepg4Q38Q2V9ZGgH4FyxRDi45NaerpQDJxl07ircU6/ZL6BHuEskC
	 Z82R2aERMdW2g==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: sashiko-reviews@lists.linux.dev, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 13/16] iommufd/viommu: Select vIOMMU operations
 before allocation
In-Reply-To: <20261012130516.GL13920@nvidia.com>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-14-aneesh.kumar@kernel.org>
 <sashiko-outbox-163690@kernel.org> <yq5azewj45u2.fsf@kernel.org>
 <20261012130516.GL13920@nvidia.com>
Date: Tue, 13 Oct 2026 14:41:46 +0530
Message-ID: <yq5aik36q819.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Mon, Oct 12, 2026 at 03:07:57PM +0530, Aneesh Kumar K.V wrote:
>> > Currently, amd_iommufd_get_viommu_ops() unconditionally returns the ops
>> > structure without checking the type argument. If a user requests an arbitrary
>> > type like IOMMU_VIOMMU_TYPE_ARM_SMMUV3 on an AMD device, the core iommufd
>> > framework might track the vIOMMU under a mismatched architectural type
>> > identifier.
>> >
>> > The ARM and selftest backends appear to validate this argument against their
>> > supported hardware types before returning the operations.
>> >
>> 
>> No vIOMMU type has been added for any IOMMU other than Arm. The
>> documentation also considers IOMMU_VIOMMU_TYPE_DEFAULT reserved.
>
> This is a bug in the AMD driver we need to fix, send a patch? It
> should only accept DEFAULT, not every type.
>

But the comment says "Reserved"

 * @IOMMU_VIOMMU_TYPE_DEFAULT: Reserved for future use

What is unclear is what using that type on Arm means. Does it imply
IOMMU_VIOMMU_TYPE_ARM_SMMUV3?.

>
>> >> @@ -73,5 +79,7 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
>> >>   * struct iommufd_viommu_ops - vIOMMU specific operations
>> >>   */
>> >>  static const struct iommufd_viommu_ops amd_viommu_ops = {
>> >> +	.get_viommu_size = amd_iommufd_get_viommu_size,
>> >> +	.viommu_init = amd_iommufd_viommu_init,
>> >>  	.destroy = amd_iommufd_viommu_destroy,
>> >>  };
>> >
>> > [Severity: High]
>> > Is the alloc_domain_nested callback missing from this operations structure?
>> >
>> > The commit message and comments in amd_iommu_alloc_domain_nested() indicate
>> > it should be assigned to the viommu operations. However, it is omitted here.
>> >
>> > If a user attempts to allocate an AMD nested domain using IOMMU_HWPT_ALLOC,
>> > won't the core framework reject it with -EOPNOTSUPP because
>> > viommu->ops->alloc_domain_nested is NULL?
>> >
>> 
>> It is unclear whether nested domain support is fully integrated for AMD.
>> I see amd_iommu_alloc_domain_nested(), but cannot find any callers.
>
> There is a series on the list to complete more of this, it is fine the
> way you have it.
>
>
>> >> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
>> >> index f3d5b5a7eb4a4..e95138ae71d5b 100644
>> >> --- a/drivers/iommu/iommufd/viommu.c
>> >> +++ b/drivers/iommu/iommufd/viommu.c
>> > [ ... ]
>> >> @@ -103,16 +105,12 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
>> >>  	 */
>> >>  	viommu->iommu_dev = iommu_dev;
>> >>  
>> >> -	rc = ops->viommu_init(viommu, hwpt_paging->common.domain,
>> >> +	rc = ops->viommu_init(viommu, idev->dev,
>> >> +			      hwpt_paging->common.domain,
>> >>  			      user_data.len ? &user_data : NULL);
>> >
>> > [Severity: Critical]
>> > Is there a missing check to ensure the domain is owned by the same driver
>> > before passing it to viommu_init?
>> 
>> The viommu_init callback needs to perform this check. For example, the
>> Arm implementation does:
>
> No, the check is missing. If a domain is being used then the core code
> needs to check it, not the driver.
>
> When the ops is first obtained it should be checked along with the
> domain to be sure it is compatible.
>
> The NULL parent domain on the TSM path should be enforced in the core
> code since there is nothing to check there.
>

So, if IOMMUFD_VIOMMU_NO_HWPT is not set, the HWPT must have been
created with IOMMU_HWPT_ALLOC_NEST_PARENT, and its domain owner must
match iommu_dev->ops?

Something like:

	idev = iommufd_get_device(ucmd, cmd->dev_id);
	iommu_dev = iommufd_device_get_iommu_dev(idev);

	if (ops->flags & IOMMUFD_VIOMMU_NO_HWPT) {
		if (cmd->hwpt_id) {
			rc = -EINVAL;
			goto out_put_idev;
		}
	} else {
		hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
		if (IS_ERR(hwpt_paging)) {
			rc = PTR_ERR(hwpt_paging);
			goto out_put_idev;
		}
		if (!hwpt_paging->nest_parent || !iommu_dev ||
		    hwpt_paging->common.domain->owner != iommu_dev->ops) {
			rc = -EINVAL;
			goto out_put_hwpt;
		}
	}

-aneesh
