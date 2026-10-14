Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3D852D2C9;
	Wed, 14 Oct 2026 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792000771; cv=none; b=GCsWrcQa22t4ZwUtYEYCwLrcY/hclNYD0tinEw8hkFFsMWuNxJmbF5pC/fNftPSp8Cm3ThXJr/vNPxDK5cBJS38nSsZmVF3U/ZVXpbTzbFZkTurP0dD418IfGSOVi+M7SqFCrzp3sYXjq9LT5sLVon4gswB9u6DAOZ7+z1DBOTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792000771; c=relaxed/simple;
	bh=xvrU7+OQe2cN+5nepJqt1T1xTdMTt8Ci1AZBLgoDkjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGgWihXod2br6w+fExmdNL9u7pnt7MyZBM199/ZQ8XqFxjnCeJ9qJDuB9viS3N2l5cxcOyMLmfWUgO01qAH6fTBUV15Vj2MuczfpryDphLX+Y2tSNdc375HdcNRVKkw/sQzoUTFiBsc0hI/KzsRqebeYAuxgmKbTbXWjXzKhU1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=axoF8r+6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="axoF8r+6"
Received: from localhost (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id BE38B20B7166;
	Wed, 14 Oct 2026 10:59:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BE38B20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792000765;
	bh=w+LHJC/NB4yRzWoWwokMMEzOhdTsVA9ERhh/Ya3fyko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=axoF8r+6w476cU0VGnnpnAmwmzXLi4bAV8TsfQtae96LkE3UE0UZC6O3c5c/ntdql
	 eYvWFE3Uu7XqgcwhPPlZBwc4Nr6xACMFBQ+1papQUDT8vJHb9XQBWWus4QC50y/B7E
	 w0dvyC+VBWj+UHjxKlTKAyFWiS0KwTtKwKFICy9c=
Date: Wed, 14 Oct 2026 10:59:13 -0700
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
 linux-tegra@vger.kernel.org, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v7 08/16] iommufd/viommu: Keep a reference to the KVM
 file
Message-ID: <20261014105913.00001217@linux.microsoft.com>
In-Reply-To: <20261008055955.4014342-9-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
	<20261008055955.4014342-9-aneesh.kumar@kernel.org>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Aneesh,

On Thu,  8 Oct 2026 11:29:47 +0530
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
> Based on an original patch by
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> 
> [nicolinc: hold kvm's users_count]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> [aneesh.kumar: Switch to use kvm_file]
> Cc: jgg@ziepe.ca
> Cc: kevin.tian@intel.com
> Cc: joro@8bytes.org
> Cc: will@kernel.org
> Cc: robin.murphy@arm.com
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/iommufd/viommu.c | 5 +++++
>  include/linux/iommufd.h        | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/viommu.c
> b/drivers/iommu/iommufd/viommu.c index f7951057a1e5..b7489ed259bd
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
So kvm_file will persist inside viommu even when no more vdevice exists
under the viommu. In that case, don't we need to check idev->kvm_file
matches viommu->kvm_file during vdevice allocation?

Otherwise, it appears possible to associate a device belonging to a
different KVM VM with the existing vIOMMU, no?

>  	viommu->type = cmd->type;
>  	viommu->ictx = ucmd->ictx;
>  	viommu->hwpt = hwpt_paging;
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index 0a0bb4abfbd2..3267717f676d 100644
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
