Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF612ED16D
	for <linux-pci@vger.kernel.org>; Sat, 21 Mar 2026 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774088340; cv=none; b=ppw1PdvYnvi8ddQPPQmAiV7t4ogAC0bGasMvgQV6+n6UQIX67DAH8x8/HZcCxUyepY39YhbvJpCZa2rfdyngVTlyt2ExNqxPTDxVgN2cZSS4M2btjjX2UULjDJCS/YVkAO438mhzRglpbtEPWOp45/eZ43eYhq3EJ/1hwYe6vFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774088340; c=relaxed/simple;
	bh=28Et5Nv824cl726MlD4oJ6zdqdgOjWEgBQftxHELV7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CN8M6gItwWKJ+qJ4TNw+WuaBxaDLIljRJlPmbjPRv7y9RGXrg/Ct942ePXstRcJ3BH4U5cdRt5ZvfN87D/or1Hw0dTOW3I1PUNZmE1oYjf7xoJH9+N74VR6dIJFMTvnjsw/31UEomh8KM/dWhZQeZ7DusAhWrvIuJpchRl9rgn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eSyqrbxp; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eSyqrbxp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774088337; x=1805624337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=28Et5Nv824cl726MlD4oJ6zdqdgOjWEgBQftxHELV7U=;
  b=eSyqrbxpXY1h2FDw8VHY/uFwD95ZnkqG/Toq2GeXlhH9LddQydOfIv+k
   2zDj5y0l88p5eKh/1QXpHgJcnKTSytGRXfEZmBSr58qr1jcxwmTUFWRzv
   mz4hT5F7HNrAgwZuOir+cKTwzFEhx/BLEs7qPKIsFmGzNnj1P+pOsAXvg
   meT9TGJmYydSCyZUw7oHpdubNxIgBWPRE6cd/QnlwPuqBPPTSC6JovcNA
   CDKEgDnyBrgd6DZ/vFtia7DqljCKMjpkqVNvnux0MZK/hVaq2UdHsZbc4
   jo6IYWHvYSZm+oqFQk700fSTbboktnmUBO5pVizbKY5WO4hXKPHRnjXXz
   w==;
X-CSE-ConnectionGUID: 6x/Xn8eKR7GS3BzdpVCgWw==
X-CSE-MsgGUID: ELlfKmIKTYi0XtIbGiJ7wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="62722897"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="62722897"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 03:18:56 -0700
X-CSE-ConnectionGUID: And9ipSCTYCft0eOmiWOzw==
X-CSE-MsgGUID: 9hOQOglDTuCIBbalt/Bgmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="254022110"
Received: from lkp-server02.sh.intel.com (HELO d7fefbca0d04) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 21 Mar 2026 03:18:53 -0700
Received: from kbuild by d7fefbca0d04 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3tPq-000000000aj-1Ftq;
	Sat, 21 Mar 2026 10:18:46 +0000
Date: Sat, 21 Mar 2026 18:17:42 +0800
From: kernel test robot <lkp@intel.com>
To: Thierry Reding <thierry.reding@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Michal Simek <monstr@monstr.eu>,
	Kevin Xie <kevin.xie@starfivetech.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Use standard wait times for PCIe link monitoring
Message-ID: <202603211832.idChNb3Y-lkp@intel.com>
References: <20260320224044.2569907-1-thierry.reding@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320224044.2569907-1-thierry.reding@kernel.org>

Hi Thierry,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v7.0-rc4 next-20260320]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thierry-Reding/PCI-Use-standard-wait-times-for-PCIe-link-monitoring/20260321-100847
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260320224044.2569907-1-thierry.reding%40kernel.org
patch subject: [PATCH] PCI: Use standard wait times for PCIe link monitoring
config: s390-randconfig-r071-20260321 (https://download.01.org/0day-ci/archive/20260321/202603211832.idChNb3Y-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 4abb927bacf37f18f6359a41639a6d1b3bffffb5)
smatch: v0.5.0-9004-gb810ac53
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260321/202603211832.idChNb3Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603211832.idChNb3Y-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/cadence/pcie-cadence-host-common.c:56:30: error: use of undeclared identifier 'PCIE_LINK_WAIT_MAX_RETRIES'
      56 |         for (retries = 0; retries < PCIE_LINK_WAIT_MAX_RETRIES; retries++) {
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/cadence/pcie-cadence-host-common.c:61:16: error: use of undeclared identifier 'PCIE_LINK_WAIT_US_MIN'
      61 |                 usleep_range(PCIE_LINK_WAIT_US_MIN, PCIE_LINK_WAIT_US_MAX);
         |                              ^~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/cadence/pcie-cadence-host-common.c:61:39: error: use of undeclared identifier 'PCIE_LINK_WAIT_US_MAX'
      61 |                 usleep_range(PCIE_LINK_WAIT_US_MIN, PCIE_LINK_WAIT_US_MAX);
         |                                                     ^~~~~~~~~~~~~~~~~~~~~
   3 errors generated.


vim +/PCIE_LINK_WAIT_MAX_RETRIES +56 drivers/pci/controller/cadence/pcie-cadence-host-common.c

    48	
    49	int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie,
    50					 cdns_pcie_linkup_func pcie_link_up)
    51	{
    52		struct device *dev = pcie->dev;
    53		int retries;
    54	
    55		/* Check if the link is up or not */
  > 56		for (retries = 0; retries < PCIE_LINK_WAIT_MAX_RETRIES; retries++) {
    57			if (pcie_link_up(pcie)) {
    58				dev_info(dev, "Link up\n");
    59				return 0;
    60			}
  > 61			usleep_range(PCIE_LINK_WAIT_US_MIN, PCIE_LINK_WAIT_US_MAX);
    62		}
    63	
    64		return -ETIMEDOUT;
    65	}
    66	EXPORT_SYMBOL_GPL(cdns_pcie_host_wait_for_link);
    67	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
