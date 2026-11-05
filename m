Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881543;
	b=kaW5AFudlFPjSkHKfu+pkQ7yAALMOVqIVvLQUYRlWhkta/JSXr9KyPg7BNUACRpnokHK
	 nKK6FNXS4MZ+fANimLnP9G+v8Tu4+W27DTjgQj49nSkKCZZ8JSPyjzX+WRD9sVdLlu4H3
	 qx+lu12yfWXIlB7Z3Q+6/7M8D1l7BfBccWTftw7Jf7nMMHBgx7uw7nUMqmUrUxDKEo0Ku
	 eIe3YkffTWwbbaRdLYfhXTa1KyP3ruhwHctZTmfQHEq6jVd37I04UNqAB/kl9q5NOV+dV
	 pvJn8eMVvBPWj54lS5g5K0KpY/dMfu320Gge96Fy1UoNPhaVJqaC6ULrFxf130BeMUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881543;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ZSqGuWJBbHfF/m30cj+yySLDnLihqLhP2KpRjJlvDzk=;
	b=WHVLrxNk3B6g2xAAzHq71BKfzofUCGPh9AFP9M8y4yCexUu1BWxhnAbT+10N7k6uYRAr
	 a7n2jCfNcn8SkJxHQyJixav23t2mJCi8Npk1IRddDD7t8X35HejBeIvIupDbawCCgfLQr
	 8NOFsLONa4YJL47Go6ObhCO8cT1yJkWffURvoTWURtf9RCLxOGtSI0S+8m2ViFhIIFnWG
	 nVsPeyyv8Rg/GVZn4LD3xmHnyHL6YddVOkrDR7p0y1WdgEZApRQGC/ZhKnEigjfkU3+F9
	 uui9hN4+qupvFHMK4IQbqBcmq5yWV1HrYqJvlZRLe5LbmQeaFYi6gL24GI2J2I0ajTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kfxrwzy5;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E5A606D814;
	Thu,  5 Nov 2026 12:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64E5A606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kfxrwzy5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793881542; x=1825417542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hULj/pENj1t0ZvVqG5iuX9V9t0+YHM1767U5NdVTqL8=;
  b=kfxrwzy5V7y5TV1PzWdqrxuI+TxSG64UhMazkPQPEtTFcXJTlDEOYPmM
   tm6SqraMNgl4X0TJ5Kmwcu8m1rBhXv/AOzLjQ4PGdrjG9utGE4o1E6Wrh
   mJv2EZuuLOnd7Re7iokMkMDFptMoIJeKgnDEhn2iWwlzU9iogXwwKByqH
   1RgtUL5VwWOuxWW4xQ1ywsWG94Ap9UXugM1BA9D3HUf7G51YjOEtMKior
   y/uP64pjKbl+DR6qSterZnfa+pJWN+Hd4MHJiq+g12bQQGlrJfMG/uMfM
   hqWXxPTQcLvilTPR7kylvNGTAp1FNJGT7Y1niCpJVDHvTfZEw2oVKZnIy
   Q==;
X-CSE-ConnectionGUID: clmhmv1mTpSG6p6s+cF2lg==
X-CSE-MsgGUID: FGSC63FZTA+ZXoYgXssieg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2551244"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2551244"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 04:25:41 -0800
X-CSE-ConnectionGUID: oFa3uUGWSeuMY0Gq5/nLlg==
X-CSE-MsgGUID: WKcOzA8qSq+TnJol5dU2yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="8760659"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa012.fm.intel.com with ESMTP; 05 Nov 2026 04:25:34 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOwX4-00000000mBP-1ah2;
	Thu, 05 Nov 2026 12:25:30 +0000
Date: Thu, 5 Nov 2026 20:24:42 +0800
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
Subject: Re: [PATCH v8 01/15] PCI/TSM: Move core code into its own directory
Message-ID: <202611052018.S2OsLHjD-lkp@intel.com>
References: <20261104161632.3547423-2-aneesh.kumar@kernel.org>
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
In-Reply-To: <20261104161632.3547423-2-aneesh.kumar@kernel.org>

Hi Aneesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4]

url:    https://github.com/intel-lab-lkp/linux/commits/Aneesh-Kumar-K-V-Arm/PCI-TSM-Move-core-code-into-its-own-directory/20261104-214618
base:   6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
patch link:    https://lore.kernel.org/r/20261104161632.3547423-2-aneesh.kumar%40kernel.org
patch subject: [PATCH v8 01/15] PCI/TSM: Move core code into its own directory
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20261105/202611052018.S2OsLHjD-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 812626a41399a1d464a0d69627ab45c83b8ebfb9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261105/202611052018.S2OsLHjD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611052018.S2OsLHjD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/tsm/core.c:31:12: warning: variable 'pci_tsm_devsec_count' set but not used [-Wunused-but-set-global]
      31 | static int pci_tsm_devsec_count;
         |            ^
   1 warning generated.


vim +/pci_tsm_devsec_count +31 drivers/pci/tsm/core.c

3225f52cde56f4 drivers/pci/tsm.c Dan Williams 2025-10-31  25  
3225f52cde56f4 drivers/pci/tsm.c Dan Williams 2025-10-31  26  /*
3225f52cde56f4 drivers/pci/tsm.c Dan Williams 2025-10-31  27   * Count of TSMs registered that support physical link operations vs device
3225f52cde56f4 drivers/pci/tsm.c Dan Williams 2025-10-31  28   * security state management.
3225f52cde56f4 drivers/pci/tsm.c Dan Williams 2025-10-31  29   */
3225f52cde56f4 drivers/pci/tsm.c Dan Williams 2025-10-31  30  static int pci_tsm_link_count;
3225f52cde56f4 drivers/pci/tsm.c Dan Williams 2025-10-31 @31  static int pci_tsm_devsec_count;
3225f52cde56f4 drivers/pci/tsm.c Dan Williams 2025-10-31  32  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
