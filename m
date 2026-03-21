Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3136DCE1
	for <linux-pci@vger.kernel.org>; Sat, 21 Mar 2026 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774086348; cv=none; b=NybURW/h1uevfih+/9YUJulWX2FSfugH7GfIA6iBPQ9/f/Wu4ZJIoll8/paU9jzXB+RccUPJ3U5MTQaWUE3CmFbCIZNlimmyLbafVVOL2hfAgBHc1OF2IaRLpvWrF/R/S0H1yoOaez8HNlAwDQET9aE4HNGwTgs751hRZaB+AaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774086348; c=relaxed/simple;
	bh=Gc/pW26r+bLFNcQW4Igpa1WMxMWVLSUHGJvtQrJd9xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeDGozL3EBvzOMX9p5ua/QQoqy+buLtEpdRD1iHjeVdwOLglg/PI60qG+WJ7ZVBTrPOM53tuYc4CXXxmnWnJRTegAJExRMafH06utikeClykL3FduFYyeF2bYxgQfCSXdie693EizOk2my4hfrym/XbZoD9jntlVAgqwV1c3TxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GPuCtV2Y; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPuCtV2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774086346; x=1805622346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gc/pW26r+bLFNcQW4Igpa1WMxMWVLSUHGJvtQrJd9xE=;
  b=GPuCtV2YLDUW227gqsDv879xi0Wr+g7zX3WgvSudSMHDvum+Re19Nouj
   bVM6+/XFioezYVXkHO/M/9hl39ZZWt+t+qYBHkZ1FOy1id5uQYSJsCKOO
   vbB4BhbLLwnbshXyUkL5wsoSTIIwas9noBqbLSAK2olUKMgTZsAsngeJw
   JY4LgAQgqteDr17wS4OV8uCVIogA8i0kx4vBKEH5k9nAYHilfOZWcGgCp
   0zvKKjvJ7CFSzSGvesQfrH2eWGYJY1WFvdsXY2seGooxmK0V6NH3hLOVG
   2KiFgyQEpRA9AxIgtMInR7R/RR9r3UeadHTBmp8NGk5SuFIKxf30gOi+m
   A==;
X-CSE-ConnectionGUID: Swh8DYlXQTCM01OQQnnVwQ==
X-CSE-MsgGUID: WLnAySB7Qki/sC/kh9Qe4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="75188818"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="75188818"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 02:45:45 -0700
X-CSE-ConnectionGUID: NYIO40y7QWKXRT35ae7z0w==
X-CSE-MsgGUID: dGcJ8lefQ6GDjFabGWV6lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="222764786"
Received: from lkp-server02.sh.intel.com (HELO d7fefbca0d04) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 21 Mar 2026 02:45:41 -0700
Received: from kbuild by d7fefbca0d04 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3stn-000000000Yd-1BCS;
	Sat, 21 Mar 2026 09:45:39 +0000
Date: Sat, 21 Mar 2026 17:44:59 +0800
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
Message-ID: <202603211715.0eQRORig-lkp@intel.com>
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
config: s390-randconfig-001-20260321 (https://download.01.org/0day-ci/archive/20260321/202603211715.0eQRORig-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260321/202603211715.0eQRORig-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603211715.0eQRORig-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/cadence/pcie-cadence-host-common.c: In function 'cdns_pcie_host_wait_for_link':
>> drivers/pci/controller/cadence/pcie-cadence-host-common.c:56:37: error: 'PCIE_LINK_WAIT_MAX_RETRIES' undeclared (first use in this function)
      56 |         for (retries = 0; retries < PCIE_LINK_WAIT_MAX_RETRIES; retries++) {
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/cadence/pcie-cadence-host-common.c:56:37: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/pci/controller/cadence/pcie-cadence-host-common.c:61:30: error: 'PCIE_LINK_WAIT_US_MIN' undeclared (first use in this function)
      61 |                 usleep_range(PCIE_LINK_WAIT_US_MIN, PCIE_LINK_WAIT_US_MAX);
         |                              ^~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/cadence/pcie-cadence-host-common.c:61:53: error: 'PCIE_LINK_WAIT_US_MAX' undeclared (first use in this function)
      61 |                 usleep_range(PCIE_LINK_WAIT_US_MIN, PCIE_LINK_WAIT_US_MAX);
         |                                                     ^~~~~~~~~~~~~~~~~~~~~


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
