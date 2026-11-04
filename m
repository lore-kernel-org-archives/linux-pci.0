Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810164;
	b=J7/xGyC8uP0QFu8YH8QjE6bntI23KujeYpLKqzTeU1CCrWwWTXRSfK0yofD2rTQ4LPqW
	 VuRZTQuPxIdnNR9xUzBTNBPb9JKSndGx7mmU8iIL6PjqmJIhDTgiYKuwVEIwK/9tVNw5x
	 PDsx32iEYLpGEraXmMykrP8/nlwjz34+EJ3LT+pMO5DYGeoX/6jn9GMsIIAxjup5vg+Mr
	 HQjsE3nxr2CRAwKrNLydduqMu1mgZ5DhYBeXCIkahCT4FyGUSAtdAXV3VnXCh/WfIMqi6
	 USucBlrh7KK6lU4jIqurBYWYXaE6gM0XlPIdWFlrt3hQNnVLxE/ai/qy0rx66ajTCUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810164;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=M+FVUGQeTnDaP8dcVVOqRxcNzHLQ2s/YnEy8ffSa8ug=;
	b=yQUcPj+Bt5umwYMjBENepZdKYy7kYoIrAxpn62uxqedA0l7luXwZDzqfI8dJZ+ezwFqp
	 Q17uA8ZhPGMazHOLcKKofGlWnZjtjqXdlJecArhZMzdWgYW8Oz7ctfvxZGCmH9bTKQwyX
	 JQeLQTF25xcywG6iJ6hEi+v7IBrY9TOXWprTKvHtmS8Jqmij2wxLOFRIbUgzqRSEC6KaP
	 3lhTNy+GWr9is/eKfLtT4DYSCfyfgnkX9PcX7NgxKR4IUmZbyWR2c4pFMbqf2WHeeqqmb
	 6oQ4YuYsOM7k5Ow7x2UwwvTew4B0Mh10f3TJ5xg/LUkNW0P4orAmhZbbdoB2noyE+kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=i4i+j7cT;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A9D606A32C;
	Wed,  4 Nov 2026 16:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1A9D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=i4i+j7cT
Received: from localhost (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9C34420B7169;
	Wed,  4 Nov 2026 08:35:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9C34420B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793810147;
	bh=M+FVUGQeTnDaP8dcVVOqRxcNzHLQ2s/YnEy8ffSa8ug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i4i+j7cTR141SF+ryi2A1rilwpQLlb1tWKZCllB4w4XggXR2rgpH/PKKL5oXWsGME
	 lUINehj74XCkboWP0/L1izrZBW2klf+04xYS6ecyyUJlqckWhiCPuAG6I0kD0nY7oS
	 O5loheQsjIK3IuR1x6djo8hJJCGWR7oEGE+iZLH8=
Date: Wed, 4 Nov 2026 08:35:45 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, Alex Williamson <alex@shazbot.org>, Alexey
 Kardashevskiy <aik@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Joerg
 Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>, Jonathan
 Hunter <jonathanh@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Krishna
 Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Nicolin Chen
 <nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Samuel Ortiz
 <sameo@rivosinc.com>, Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>, Steven Price
 <steven.price@arm.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thierry Reding <thierry.reding@kernel.org>, Vasant Hegde
 <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, Xu Yilun
 <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-tegra@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v8 07/15] iommufd/viommu: Keep a reference to the KVM
 file
Message-ID: <20261104083545.00003624@linux.microsoft.com>
In-Reply-To: <20261104161632.3547423-8-aneesh.kumar@kernel.org>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
	<20261104161632.3547423-8-aneesh.kumar@kernel.org>
Organization: LSG
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Aneesh,

On Wed,  4 Nov 2026 21:46:24 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> The TSM vDevice operations need access to the KVM associated with the
> device's vIOMMU. Save the device's KVM file in the iommufd_viommu
> when the vIOMMU is allocated, and take a file reference so it remains
> valid for the lifetime of the vIOMMU.
> 
> Release the reference when the vIOMMU is destroyed.
> 
> Reject vdevice allocation when the device's KVM association differs
> from the vIOMMU's, including when only one has a KVM association.
> Allow allocation when both associations are NULL.
> 
> Based on an original patch by
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> 
> [nicolinc: hold kvm's users_count]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> [aneesh.kumar: Switch to use kvm_file]
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/iommufd/viommu.c | 10 ++++++++++
>  include/linux/iommufd.h        |  1 +
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/viommu.c
> b/drivers/iommu/iommufd/viommu.c index f7951057a1e5..0dbd382eeb98
> 100644 --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
>   */
> +#include <linux/file.h>
>  #include "iommufd_private.h"
>  
>  void iommufd_viommu_destroy(struct iommufd_object *obj)
> @@ -11,6 +12,8 @@ void iommufd_viommu_destroy(struct iommufd_object
> *obj) if (viommu->ops && viommu->ops->destroy)
>  		viommu->ops->destroy(viommu);
>  	refcount_dec(&viommu->hwpt->common.obj.users);
> +	if (viommu->kvm_file)
> +		fput(viommu->kvm_file);
>  	xa_destroy(&viommu->vdevs);
>  }
>  
> @@ -82,6 +85,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd
> *ucmd) }
>  
>  	xa_init(&viommu->vdevs);
> +	if (idev->kvm_file)
> +		viommu->kvm_file = get_file(idev->kvm_file);
>  	viommu->type = cmd->type;
>  	viommu->ictx = ucmd->ictx;
>  	viommu->hwpt = hwpt_paging;
> @@ -171,6 +176,11 @@ int iommufd_vdevice_alloc_ioctl(struct
> iommufd_ucmd *ucmd) goto out_put_viommu;
>  	}
>  
> +	if (idev->kvm_file != viommu->kvm_file) {
> +		rc = -EINVAL;
> +		goto out_put_idev;
> +	}
> +
>  	iommu_dev = iommufd_device_get_iommu_dev(idev);
>  	if (!iommu_dev || viommu->iommu_dev != iommu_dev) {
>  		rc = -EINVAL;
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index b03ce0187454..c15d80f611b9 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -103,6 +103,7 @@ struct iommufd_viommu {
>  	struct iommufd_ctx *ictx;
>  	struct iommu_device *iommu_dev;
>  	struct iommufd_hwpt_paging *hwpt;
> +	struct file *kvm_file;
>  
>  	const struct iommufd_viommu_ops *ops;
>  
Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>

We may need to enable non-kvm file (such as mshv) eventually, but
until then this looks good to me.
