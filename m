Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869889;
	b=s4zSAxSnlSRTI1q8nSU5p20vOQ6lBwBy+bMI+nRQZ2g9UqmyhoytjqykDMl/HvfPLMhW
	 JIvqtrlzqfTVCdQ1mPEIeiU6ZtlDf7OJT4KZha+9f+7yR1Pa2CSzH8M3kRbEmji+61/Jw
	 y6ffj7gIDwBF4w3DZuCNOBxgOl44bP8O3x8/iMviFhKMwqkPOfvei2A3vLXXm4FwMCPpD
	 wxbwEJ5gwDtTRiTjHCF2w4H6ixZSajZyI4g0t/E2H1rS2/XooCGDn5dRbSjA2JpviEpDv
	 sFw0NUa7GlVI9oT7B0ZfuAeV9Oj7gQuOxznNp6xoQJ5cxvf0t1B8E/ATbd9sjAmxE/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869889;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=rmEfX5MB+z5qNLqON5R/iyjm6saIez2uOt9Qp74A9Mo=;
	b=LsfATkcA5KlNq4i6x7qA4TIu91oj5E4Qv7HblP3bFZx5n26aDCEciYvBy8KaRwtOIPIN
	 EetF2F38+x5jitoQLbpau5v96Z5LcV+kbxkKRRyMx+1ZszKe3RIW2QKlDoKMm4WkF9xp1
	 TCkcPoi1Cuopa0VF9FmEeLH5RNnS4V2jFJtUSuAokVTxtY+pyhzzc7HP1rcpV0uEOXzO9
	 gjAJr7IsSbJEngdmtx52uS9N4adxLnvhsO7FB5vj7OH0LaD7SYZ8JcU81S+U8ZgI5FwfL
	 j7hGY7jOFWv5lt22LJujiW6oz+BTXUXZUfEoMDpc1i3dwrffyaXG7oOHmGszB/FC1Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P+2tYmMy;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2816606A33A;
	Thu,  5 Nov 2026 09:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2816606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P+2tYmMy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793869889; x=1825405889;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cA9g6szely6p7/mFb90LkK3gklsmstrV8QekqHlOipY=;
  b=P+2tYmMyUSf4p5PoC1acENJHQYSEczQP/b7OdiGGPdIxXwKqWDQJ7Ovc
   sqi/kh8L/JU0sSpYYxrfi+qEN2bAeURH07vn3nlzcGfiTIv4K8Pf1s53k
   bV/+qpd7CtgB9CN33Y+FdyO8e2yDhTiuy40Gu2eHlCGUA9Ws+9IaLg8bN
   IJtPpXcA0OFMLpyOsXqK39bIBY4RFJRENWbhoAt5uUvvgkMeDoI4EfPUT
   27hr9IkFbxOEOxND7jcQ4ExLzdsOzv8K5qek9dP9PA4SA9mMGvBVHV1Yv
   P+7rJ/+Ng7y68ApQ+Tqc/ox54hOnPpDr+mwht8g0NcPRCTTvb5wy391YC
   Q==;
X-CSE-ConnectionGUID: cyvgK7g9RlyEywpyz0k05Q==
X-CSE-MsgGUID: 2EvrRD9PR7We7pIsj5KJZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2533676"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2533676"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 01:11:25 -0800
X-CSE-ConnectionGUID: FZgqFD1XTuezdhmfpzDg0g==
X-CSE-MsgGUID: sBnwJd+kSPi601QzmYFddg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6970208"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 01:11:17 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOtV3-00000000lzN-1PRo;
	Thu, 05 Nov 2026 09:11:13 +0000
Date: Thu, 5 Nov 2026 17:10:56 +0800
From: kernel test robot <lkp@intel.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 11/15] iommufd/viommu: Select vIOMMU operations before
 allocation
Message-ID: <202611051602.nH0L0uqs-lkp@intel.com>
References: <20261104161632.3547423-12-aneesh.kumar@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104161632.3547423-12-aneesh.kumar@kernel.org>

Hi Aneesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4]

url:    https://github.com/intel-lab-lkp/linux/commits/Aneesh-Kumar-K-V-Arm/PCI-TSM-Move-core-code-into-its-own-directory/20261104-214618
base:   6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
patch link:    https://lore.kernel.org/r/20261104161632.3547423-12-aneesh.kumar%40kernel.org
patch subject: [PATCH v8 11/15] iommufd/viommu: Select vIOMMU operations before allocation
config: x86_64-buildonly-randconfig-1001-20261105 (https://download.01.org/0day-ci/archive/20261105/202611051602.nH0L0uqs-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261105/202611051602.nH0L0uqs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611051602.nH0L0uqs-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iommu/amd/iommufd.c:81:40: warning: 'amd_viommu_ops' defined but not used [-Wunused-const-variable=]
      81 | static const struct iommufd_viommu_ops amd_viommu_ops = {
         |                                        ^~~~~~~~~~~~~~


vim +/amd_viommu_ops +81 drivers/iommu/amd/iommufd.c

757d2b1fdf5b7d6 Suravee Suthikulpanit 2026-01-15  76  
757d2b1fdf5b7d6 Suravee Suthikulpanit 2026-01-15  77  /*
757d2b1fdf5b7d6 Suravee Suthikulpanit 2026-01-15  78   * See include/linux/iommufd.h
757d2b1fdf5b7d6 Suravee Suthikulpanit 2026-01-15  79   * struct iommufd_viommu_ops - vIOMMU specific operations
757d2b1fdf5b7d6 Suravee Suthikulpanit 2026-01-15  80   */
757d2b1fdf5b7d6 Suravee Suthikulpanit 2026-01-15 @81  static const struct iommufd_viommu_ops amd_viommu_ops = {

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
