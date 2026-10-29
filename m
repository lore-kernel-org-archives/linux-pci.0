Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793255175;
	b=nFleB6lFyEZAa6vBOrBGKo+mvVnZpBOyIHbRUJdbBkX+Hh9t5mwLvDHrEH3Vw9IPPNv+
	 FH39btr8IsZGqkZyWBz9MRnXzddM+EXAHE66UPM6degi70CQP1eIfq9yMfW/pB3+0who1
	 lJbXgWS8XPArzNSKQaJMNuIuegMgonM8/GOX6K1YzStuthZPiZ2nAS6A7zZrU0mmvMUG0
	 19dHEzTNrhRY1vQamghmiNEI6DsA9w2tQJI6BGJq2L7kHel/3bt35RaalWNg9idwvdsS7
	 OtiAyvJyTBIFoWx6sAJ3A+GHJU5qYFTwc6c1xuT63k23Z+AKH0ExM7qWkb+fSgbo/BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793255175;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=SBYN8nHbrvBKRMqi5RXO8B9e5Gvye9Fzno6hvtSji7Y=;
	b=oxIYZeGth3YlcQh7zM8yebVoNBuicykXOCNvyAfoaT817EXISCHaOLDphcvMQ667dXO9
	 GaakrMLfESvGZ13Yxxdxbdlk433JMFAG/neSMnGasTqaWSB0qm9uUDNXAxz1gBY8UuTYs
	 wLFDJFmwZDl5BHUy0LqNCzdIFwvdmVoxFLU9Fd5sxts6iHGs7hxpSBZd3tv8BdgLHRlIt
	 k7AzyhdU9m+iPYcZWh7kzHh62HaLVQk4aVpeNVLmnn5kBTFmKr5vqDWLhirWIIGyT7KK8
	 IRfVATrPqlUCfJb86TjL/10nEsAAw6jL+Nlm4ku7PZG3hDmgcTCECSTBl7EI1nyCWzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Uy6EMYl/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3256606A31A;
	Thu, 29 Oct 2026 06:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uy6EMYl/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE471F01825;
	Thu, 29 Oct 2026 06:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793255174;
	bh=SBYN8nHbrvBKRMqi5RXO8B9e5Gvye9Fzno6hvtSji7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Uy6EMYl/aUxbNk06a+gjS6GHbd/oi5C01+fRiJ3cltkIJv5OTsod38EsQWy7t7dBn
	 NDZucBRCnlRrE4FcJs6mzCXn0iaHWOA6wKxFqhnUCvzeBY/iWWhXk9rPwjvD+faOvY
	 7alUHiUmpBfPf8UWXje9fuyNYk2uOhOSqHViqFIToW9yyC98wxQiuMSwJCGyTPqjZi
	 aBcbxR8E/UhECkrsVez64c5FKzV2tPz4fSYDyuznvLSCdvwJv/jyozbljN64q8rKF3
	 RcC2WNFaDQDWyZ/AQKfhOM37vh9iY4cN7X1OogpQxyUPUKsonl3f93IY/HFPy4WMMr
	 Vs+MMJgJNexVg==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: iommu@lists.linux.dev, Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
	linux-tegra@vger.kernel.org, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v7 08/16] iommufd/viommu: Keep a reference to the KVM file
In-Reply-To: <20261014105913.00001217@linux.microsoft.com>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-9-aneesh.kumar@kernel.org>
 <20261014105913.00001217@linux.microsoft.com>
Date: Thu, 29 Oct 2026 11:56:02 +0530
Message-ID: <yq5aecd9aupx.fsf@kernel.org>
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

Jacob Pan <jacob.pan@linux.microsoft.com> writes:

> Hi Aneesh,
>
> On Thu,  8 Oct 2026 11:29:47 +0530
> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
>
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> 
>> The TSM vDevice operations need access to the KVM associated with the
>> device's vIOMMU. Save the device's KVM file in the iommufd_viommu
>> when the vIOMMU is allocated, and take a file reference so it remains
>> valid for the lifetime of the vIOMMU.
>> 
>> Release the reference when the vIOMMU is destroyed.
>> 
>> Based on an original patch by
>> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>> 
>> [nicolinc: hold kvm's users_count]
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>> [aneesh.kumar: Switch to use kvm_file]
>> Cc: jgg@ziepe.ca
>> Cc: kevin.tian@intel.com
>> Cc: joro@8bytes.org
>> Cc: will@kernel.org
>> Cc: robin.murphy@arm.com
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>  drivers/iommu/iommufd/viommu.c | 5 +++++
>>  include/linux/iommufd.h        | 1 +
>>  2 files changed, 6 insertions(+)
>> 
>> diff --git a/drivers/iommu/iommufd/viommu.c
>> b/drivers/iommu/iommufd/viommu.c index f7951057a1e5..b7489ed259bd
>> 100644 --- a/drivers/iommu/iommufd/viommu.c
>> +++ b/drivers/iommu/iommufd/viommu.c
>> @@ -1,6 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0-only
>>  /* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
>>   */
>> +#include <linux/file.h>
>>  #include "iommufd_private.h"
>>  
>>  void iommufd_viommu_destroy(struct iommufd_object *obj)
>> @@ -11,6 +12,8 @@ void iommufd_viommu_destroy(struct iommufd_object
>> *obj) if (viommu->ops && viommu->ops->destroy)
>>  		viommu->ops->destroy(viommu);
>>  	refcount_dec(&viommu->hwpt->common.obj.users);
>> +	if (viommu->kvm_file)
>> +		fput(viommu->kvm_file);
>>  	xa_destroy(&viommu->vdevs);
>>  }
>>  
>> @@ -82,6 +85,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd
>> *ucmd) }
>>  
>>  	xa_init(&viommu->vdevs);
>> +	if (idev->kvm_file)
>> +		viommu->kvm_file = get_file(idev->kvm_file);
> So kvm_file will persist inside viommu even when no more vdevice exists
> under the viommu. In that case, don't we need to check idev->kvm_file
> matches viommu->kvm_file during vdevice allocation?
>
> Otherwise, it appears possible to associate a device belonging to a
> different KVM VM with the existing vIOMMU, no?
>

Agreed. I will add the below.

modified    drivers/iommu/iommufd/viommu.c
@@ -212,6 +212,11 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_viommu;
 	}
 
+	if (idev->kvm_file != viommu->kvm_file) {
+		rc = -EINVAL;
+		goto out_put_idev;
+	}
+
 	if (viommu->iommu_dev) {
 		iommu_dev = iommufd_device_get_iommu_dev(idev);
 		if (!iommu_dev || viommu->iommu_dev != iommu_dev) {



-aneesh
