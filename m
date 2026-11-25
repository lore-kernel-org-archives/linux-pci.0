Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604107;
	b=Eag3NqaZsB/5eJlAiNm/0+JpMEAXUEn4ikpbSC5m2Uwq55OZSM2wkPe8pEg63gSv0E2d
	 oI4DsqrEe98MHbtpBmFWqfS0d6Ih5P08HS0vl1w54MQK3PQYfmuo6WouuEIXL0ZeKN+my
	 VVDFGt4+ZA6JejRzPBlTRtVXcHtew6ghy46W1X6k0sIi+zieff6EXDkOJjNJ3J8/sYutX
	 dBrlUd08lkDIGGnFHmuCzd/m2BxIfQnh7y9wFp/rGS34IPIHKJPqXgllauJOV4cPpvrhT
	 W0EH6/d8wwq6McLV8iYARSgWHbCo5A4FpPomKpfM8tQMVpwbBJzJAJyzEogINq/gELQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604107;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=NsAO75n96Ze3m0+3oaGJR2V2PBPYbdcEUlt+8IPXnr8=;
	b=2jQ6kNWEp0EnxIETpDUd8NYSVB31Rwx8vsNND2vtqDOMKRXlkSFuxzVJYGh/iwD8LAwP
	 HcSMWUD0ku6VgzyAjjOSmk3xh0JWvDa4hHYIexGW1T3EexLmiK9Clu3dwHDw01dl5MsdH
	 pPOPxqgeG5ePDeitgXHOelt+uWQATIXPgWA5WqNleHvQpPMbXZhPToNDCjun0w74hn56E
	 KKPUfvy1K0eXG1pLzze6EvZ2YKy5wjgJgISzxiLQPS4Z4Y9fIHrqkfe0xXqZyUEjyc+wh
	 /3M4kM4a9wBF/R/SqV3UmgrG3LWjCQUhds+YWkvIT+sR5rPZsr29t2bzwfKM2reUAOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fta+NdPi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3121B606A331;
	Wed, 25 Nov 2026 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fta+NdPi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D8A1F000C6;
	Wed, 25 Nov 2026 10:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795604106;
	bh=NsAO75n96Ze3m0+3oaGJR2V2PBPYbdcEUlt+8IPXnr8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Fta+NdPi9AjkXDcK9wh4IZMGGAVqWvozyEStv8nEhA4FByUHMSafuaxDZTyfkKyuB
	 xNsX14X/gHO/MYH/ft8uJrSFmKKLbWdMttkVQHHw9JMkDjYzdyfYOos4FhmD/02asv
	 ee7KaipYl8+Cu2lGb03fwJZyqdaPbvGCXY2bbbA4xm/WIuKnGADLO4/r1FAIrdX0ZG
	 MeWMn0UIyfN3tnobWnViu5HqvnylVucZ41eAbIRuH3/cWTDCCJ7miusSgKN2IIuR8z
	 tGLC24u2P+/FpBOrFp7KBovKEG4hz5K+s5iyPya/FrEgqXV7UNHX9U51XP8IiTWApJ
	 0e+UVnNDB8DgA==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v10 15/18] iommufd/viommu: Allow PCI TSM backends to
 provide vIOMMU operations
In-Reply-To: <sashiko-outbox-232909@kernel.org>
References: <20261125081121.379481-1-aneesh.kumar@kernel.org>
 <20261125081121.379481-16-aneesh.kumar@kernel.org>
 <sashiko-outbox-232909@kernel.org>
Date: Wed, 25 Nov 2026 16:25:01 +0530
Message-ID: <yq5acxrt9o56.fsf@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] iommufd: mix of __free() and goto error handling in
>   iommufd_viommu_alloc_ioctl()
> --
>
> commit c23c0e750868729bcf5c18f6b9904e0a5d226915
> Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>
> iommufd/viommu: Allow PCI TSM backends to provide vIOMMU operations
>
> This commit allows VIOMMU_ALLOC to query PCI TSM backends for vIOMMU
> operations before falling back to the physical IOMMU driver, and tracks
> TSM-backed vIOMMU instances in struct iommufd_viommu.
>
>> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
>> index dab499d24c453..909ef86f39a98 100644
>> --- a/drivers/iommu/iommufd/viommu.c
>> +++ b/drivers/iommu/iommufd/viommu.c
> [ ... ]
>> @@ -44,20 +48,38 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
>>  	if (IS_ERR(idev))
>>  		return PTR_ERR(idev);
>>  
>> -	iommu_dev = iommufd_device_get_iommu_dev(idev);
>> -	if (!iommu_dev) {
>> -		rc = -EOPNOTSUPP;
>> +	struct tsm_dev *tsm_dev __free(tsm_put_device) = tsm_get_device(idev->dev);
>> +	if (IS_ERR(tsm_dev)) {
>> +		rc = PTR_ERR(tsm_dev);
>>  		goto out_put_idev;
>>  	}
>> -	if (!iommu_dev->ops->get_viommu_ops) {
>> -		rc = -EOPNOTSUPP;
>> +
>> +	if (tsm_dev)
>> +		ops = tsm_viommu_get_ops(tsm_dev, idev->dev, cmd->type);
>> +	else
>> +		ops = NULL;
>> +
>> +	if (IS_ERR(ops)) {
>> +		rc = PTR_ERR(ops);
>>  		goto out_put_idev;
>>  	}
>> -	ops = iommu_dev->ops->get_viommu_ops(idev->dev, cmd->type);
>> +
>>  	if (!ops) {
>> -		rc = -EOPNOTSUPP;
>> -		goto out_put_idev;
>> +		tsm_put_device(no_free_ptr(tsm_dev));
>> +
>> +		iommu_dev = iommufd_device_get_iommu_dev(idev);
>> +		if (!iommu_dev || !iommu_dev->ops->get_viommu_ops) {
>> +			rc = -EOPNOTSUPP;
>> +			goto out_put_idev;
>> +		}
>> +
>> +		ops = iommu_dev->ops->get_viommu_ops(idev->dev, cmd->type);
>> +		if (!ops) {
>> +			rc = -EOPNOTSUPP;
>> +			goto out_put_idev;
>> +		}
>>  	}
>
> [Severity: Low]
> This isn't a bug, but iommufd_viommu_alloc_ioctl() mixes a scope-based
> __free(tsm_put_device) variable with goto-based error handling
> (out_put_hwpt and out_put_idev), which violates the kernel Cleanup API
> convention and causes out_put_idev to release idev before tsm_dev is
> released at function exit.  Could tsm_dev be released via a goto label or
> all resources in this function converted to __free()?
>

I fixed this in a separate patch but missed folding in the change. I
will fold it into the next revision.

-aneesh
