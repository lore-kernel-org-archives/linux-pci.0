Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076439;
	b=pXFuZ5xOnVtreeuSIvFJhmG0Tfc5t5FNa3CrgejSEcKcBOhDCBWgqzC7Nlmw9VZiSuwm
	 vqiHXi6PZiAXr/t0HGdG+TaogxPD28fAOzcvuKosweK7twKslrvqf69BktjKbQccwLSCf
	 nUUzbBS+A3tIj6lGtv9OHM0memijTrkY/u4mG9xobEgRTKnRTwgfoAia42yKHw5IacN26
	 uo4ShDKJ7wr1t66/u+mDJFI4fitZPfwQCndWH93pZ6rDCI8JgG9731LPExiUwdkJBhvva
	 GqDBufjoeBB28wKyVjtvfa7lP/dajNuVIfQ4RGkOYG+3HM/WCsuisKIQ5EsxvwJYGxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076439;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=PMrsBwYkwF4lRQixoD6GmLUuDmMJwcXbQNklWixiPYY=;
	b=dLyTZ67ghZIpecdsst+taU5IpgFQBg5zTEri4CPNdPL1qASFbwETDuLSmy9Rxn8SkM4t
	 WnLV+VzQT05tJPbhOUYdTeiwol9VCqVTbrtaoKVN5LTlw2X5KxjkVRtXdTR2ZRc6oUjVD
	 ojGsJHdJec8YTPwsEM2kcJWduNMNuL5sqfndmvi9HAgN+69htaZeqcMbw6KYG68H6Pqs2
	 z2oa3s4vg7vlhGq4BlrfjtiHTEYlVpDIRLAQs0TRVk9DzVeBYB7Eyz6dPmQGV55GJv+Iu
	 H7bTLc2+r64y2f+4JYnJ+HulhVnc+xlsOCmHrI5AiWOQ39XT3V4BVaWCn+qNJDcrZCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MhCpE6IV;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916FD606A320;
	Thu, 19 Nov 2026 08:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 916FD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MhCpE6IV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795076438; x=1826612438;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9KLe5HS8+v0UjG8/agQdaNXieDfCo4rAsBW39hUTfiw=;
  b=MhCpE6IVUQi453qtqdRyrSXG/26Sft4QobWAG1Zj34Ob+FWfs6Mw3dXT
   BO4DEotisnX0HyF0S+BxMBMARKTkjvTvel5bUWy4beOPL1kpIkC1OCh1g
   xie9jcNdxKxV+NU/P1QMaRY1bsDR4K1bj7ABcDI74b7MnQQcEVbX32oxU
   k4Jy+hHtBhl89P5VnOey/KQxbcZ4n1gEcl5tAwuYkxcJVSWDEvqpscyQ1
   FPMEiqQDLnFAk8bSRAMmOciZglc7rym7PXYpecHnmsh/oIOH9SDfxrPdL
   C6ta+TuoGL0hRxT9BRAvfnzJbl4BqYBAcBFrxbRZVwpPT+L+zlUhIH5YT
   g==;
X-CSE-ConnectionGUID: e0kjaluvQHSlwOYiEaUUHw==
X-CSE-MsgGUID: /yDbsTOLTqeS4cSzJiHMJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3835414"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3835414"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 00:20:37 -0800
X-CSE-ConnectionGUID: IzMi4v08SVeQv6CuN/UB0w==
X-CSE-MsgGUID: OTFciINxRMykl5tNJdMoKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10732774"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 00:20:29 -0800
Message-ID: <46da9589-3243-4cc0-bb59-7ac40116165a@linux.intel.com>
Date: Thu, 19 Nov 2026 16:20:27 +0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Alex Williamson <alex@shazbot.org>,
 Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
 Nicolin Chen <nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Samuel Ortiz <sameo@rivosinc.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Steven Price <steven.price@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Xu Yilun <yilun.xu@linux.intel.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, iommu@lists.linux.dev,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-tegra@vger.kernel.org, patches@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v9 05/13] iommufd/viommu: Keep a reference to the KVM file
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 linux-coco@lists.linux.dev
References: <20261116081935.85372-1-aneesh.kumar@kernel.org>
 <20261116081935.85372-6-aneesh.kumar@kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261116081935.85372-6-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/16/2026 4:19 PM, Aneesh Kumar K.V (Arm) wrote:
> From: Nicolin Chen<nicolinc@nvidia.com>
> 
> The TSM vDevice operations need access to the KVM associated with the
> device's vIOMMU. Save the device's KVM file in the iommufd_viommu when the
> vIOMMU is allocated, and take a file reference so it remains valid for the
> lifetime of the vIOMMU.
> 
> Release the reference when the vIOMMU is destroyed.
> 
> Reject vdevice allocation when the device's KVM association differs from
> the vIOMMU's, including when only one has a KVM association. Allow
> allocation when both associations are NULL.
> 
> Based on an original patch by
> Shameer Kolothum<shameerali.kolothum.thodi@huawei.com>
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Reviewed-by: Jacob Pan<jacob.pan@linux.microsoft.com>
> [nicolinc: hold kvm's users_count]
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> [aneesh.kumar: Switch to use kvm_file]
> Cc: Jason Gunthorpe<jgg@ziepe.ca>
> Cc: Kevin Tian<kevin.tian@intel.com>
> Cc: Joerg Roedel<joro@8bytes.org>
> Cc: Will Deacon<will@kernel.org>
> Cc: Robin Murphy<robin.murphy@arm.com>
> Cc:iommu@lists.linux.dev
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Aneesh Kumar K.V (Arm)<aneesh.kumar@kernel.org>
> ---
>   drivers/iommu/iommufd/viommu.c | 10 ++++++++++
>   include/linux/iommufd.h        |  1 +
>   2 files changed, 11 insertions(+)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
