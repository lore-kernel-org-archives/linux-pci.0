Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890220;
	b=qUrpdFYcQgFJHEyJPokvaJyjxMle6ZDZygv6WNuP+3G7Ya7NwETl/gCNjWAmPzz34Isk
	 O3X7UrdNyQRTLG5KMdBxo2xNOYW4GsXz6/F58kxYA+BLAmkG7bBnES2kfZq4J1RTYu8Nd
	 IuI7gbhMGLSsTQvcruJGN/kdHBbaMgFGsOQKPBY60Fl5tcRmh669ghGlfx7x91mJp54iZ
	 DtTHlrxhmh7pVj2YBqbHgT8bwNEDkTtqiPosqxfAfpPm/W3qlhBOVy3XwuW3MX+SLPHVZ
	 KAHSGDTrn7sOfgPUBOGFCNNYZ645P/09UHqoF8YB27KR1/j6NmCYYjkUST4sRI6RvBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890220;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=zngDh/hn+d+IfbRxuQD9941zh0dh76DUZmGv37oN1yw=;
	b=HzMLGIqqVn2//dkvQAT22iGKMMeJt7UDh7uxzsQpUygD+qtPFM9tCQx9xfJhWIcVcFwz
	 J5gars6JiHHJjX8YepJ8imlv2pLLYGboWD+nHUPbNvP2MBcMeAmhAvEC6Xjy3sKdeWhFP
	 LQYPG0KEDK4FVLFn5tTeuix7rKExdFGmQS4yFwo1WwVJ3YO/F8SMkG4PXtLN3V2Gk7AHU
	 PiBhR3SvD3lRgsBp6ikLCyDy3Ytoj4yLutedNRb+OZZisQ2YUq6D154s2sEj0l5z46GiO
	 6nk402WnkMZlGr60ggNieF8eVbmK5cfo6xBHazWkSJps2WnrlCb4p5mnPZl3FKYNNWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CaH54igg;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B667606A333;
	Thu,  5 Nov 2026 14:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B667606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CaH54igg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793890220; x=1825426220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pR76mBghhXMOKm2t2fE0Nbyxh5lA9YdTCI2eN6g0oNY=;
  b=CaH54iggLRDvQu+fJy5qc9rHlSnF6nsEVdBBbu3Ar6gIvJuB8AHBpkPM
   kCA7K7QuaiBsHFbRWy9TTYTaWKa3D7Zt92JuZ/ksDLmMqCKsttD1DpZom
   pkVIgwhUNfwLRm54cVXI0rSfvLC036msgNFCu8F4xD0jLJU64AJ8/51Qu
   6BabFNr6P1nwSVwlm3ZlksDHdPa8gS8Nm3pLNYVRLO9CytwaN93oP88zt
   CMOm2lBojG4H/vZuJGRvjmXoCkdBqh1xbiG8vEPM9udN0dDqdjQTboPRM
   QleP0cr+b4qYN72v4nHfL9cyupgrhozEzja8wYoOC23dG7xOG85PP0/Ux
   g==;
X-CSE-ConnectionGUID: Upc1HOLNSC+zVEVTogBspw==
X-CSE-MsgGUID: 1Mq3vmUnT22ZxrH0dNtgfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2551306"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2551306"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 06:50:19 -0800
X-CSE-ConnectionGUID: /dk8MTNSRPGYLMVUiJXO/Q==
X-CSE-MsgGUID: pVjBF9RvTTCjveglukFKDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7151193"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 05 Nov 2026 06:50:13 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOyn4-00000000mLb-00W9;
	Thu, 05 Nov 2026 14:50:10 +0000
Date: Thu, 5 Nov 2026 22:49:53 +0800
From: kernel test robot <lkp@intel.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
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
Message-ID: <202611052227.TxHIjde3-lkp@intel.com>
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
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20261105/202611052227.TxHIjde3-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261105/202611052227.TxHIjde3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611052227.TxHIjde3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iommu/amd/iommufd.c:81:40: warning: unused variable 'amd_viommu_ops' [-Wunused-const-variable]
      81 | static const struct iommufd_viommu_ops amd_viommu_ops = {
         |                                        ^~~~~~~~~~~~~~
   1 warning generated.


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
