Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793262109;
	b=uL+YNe1GhY0ChXjHnEeMWrXPW1/YmHFwppKZpsCpmR5Tw8qe2Y9KMGwJAMf3eKzVWn9T
	 AZA0rntMjYaZ8o0NqTNetp43JvBC3UVAhY3iR25KCKFvmyA2S4Uixd8ej0kBt92HEknwO
	 Nye19Cmxpviaso+xfaTgJAzQrdgIdBT9SVN7GvJBAqBglJoZujyVGTpquIXgrpv+Cst4c
	 NzhXd35chv8PoCFeV6mruNqk6yvCBvoZSy0rL69NTJo45v62bOUBhY64lMgYDU0Mq4Tg/
	 mF8m3QIXSRz7zNFsSG30/QmhcXbmOWZU2+pErFbx8zLeicY2IN5K2GL0Sv6Ovh4ha/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793262109;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=xPmA0pkfhdgm8CaJDGdf7BEDZGYIBrL6KWwLvFembQY=;
	b=dAwHK1Z6FphkKqtk2qt8Mn32Bk3Hbp6VAeS6BzQz2ft1AVt9MEqxESb0bPxrfAM+I356
	 zXrI8UU9/n/Am/fVxcjRthx+ahmyHn+tnOvcBj2Q9QqOFLIOCbbl2hykDd8kva2pVyunI
	 5nWOoiHWaALOa7CQV3nSggf9DqNhe6zVTe3WfkskUk4+BjscykzHcY26i6ejdjZQWB8M7
	 P0DdVq1LPKVg7RRd+ggJVVmAgNMnO4zI1yVewy4vc+o+n8IA1Xh77m7nsGnwYLyivk9oM
	 QyeAm+Peu8OSohwdZn67+0wIVNnfp3S4Ih8RPoOTVHna//UMleZT3WYdAhCXWVcgJjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j+VpPybF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E574606A32C;
	Thu, 29 Oct 2026 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j+VpPybF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026C61F01825;
	Thu, 29 Oct 2026 08:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793262109;
	bh=xPmA0pkfhdgm8CaJDGdf7BEDZGYIBrL6KWwLvFembQY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=j+VpPybF6IZFS02jOwPLDCU/oqxnF36kGt/r+uuygcDVDakU+jtz7x6bM47p1LBbB
	 A5DkDZENUbYysQ/lFizuVu9Jakcxi+LatcRtyxMktaYn959Xd+jSu1xzh4Rp3ldkxj
	 0jCC1apEtCbQ36cK51x6ekx5Wo0w+S5PmzaPF8liLzSuNORTHrw6cWAgnVidD/keCF
	 FCXGBZqw8jA/6Ea+//8GN+Qh/ttyFLzrNrOPiNntT4aDom9QwKVkPs1pzNdWRumSjR
	 WBqj5BQVS7ec/2NdB5VXi7EpvUmfgTm+GtkQwFSADEIhzS9z94STGRqVROt2AYgnCb
	 mE3Omf6VbU3Dg==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Alexey Kardashevskiy <aik@amd.com>
Cc: iommu@lists.linux.dev, Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 13/16] iommufd/viommu: Select vIOMMU operations
 before allocation
In-Reply-To: <179321444125.2412245.13201160469751061592.b4-review@b4>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-14-aneesh.kumar@kernel.org>
 <179321444125.2412245.13201160469751061592.b4-review@b4>
Date: Thu, 29 Oct 2026 13:51:37 +0530
Message-ID: <yq5a7bj0c3xq.fsf@kernel.org>
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

Jason Gunthorpe <jgg@nvidia.com> writes:

>> [ ... 62 lines skipped ... ]
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
> This needs to fail not retain the broken behavior if this is getting
> touched..
>

Do you mean return NULL until we add an AMD-specific type equivalent to
IOMMU_VIOMMU_TYPE_ARM_SMMUV3?

modified    drivers/iommu/amd/iommufd.c
@@ -41,7 +41,7 @@ static size_t amd_iommufd_get_viommu_size(struct device *dev,
 const struct iommufd_viommu_ops *
 amd_iommufd_get_viommu_ops(struct device *dev, enum iommu_viommu_type viommu_type)
 {
-	return &amd_viommu_ops;
+	return NULL:
 }
 
 int amd_iommufd_viommu_init(struct iommufd_viommu *viommu,


Alexey,

Could you look at this and suggest the AMD equivalent of
arm_smmu_get_viommu_ops()? We could add it as part of this patch.


-aneesh
