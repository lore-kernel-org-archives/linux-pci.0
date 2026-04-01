Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5111A683D;
	Wed,  1 Apr 2026 03:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775015142; cv=none; b=pVVUFS4o9GqKPXLTXUcuSq7oKm+wlGR4y4Rse/zBZ8/X6RlAbfEOTc/1Hqs8MSBi2c5oMWX1w0Y9JLdtsapSpBmnnQ9Zlg6Qyht7MDUinsa3mvg2xLtEXMtzgw8OhG16Rj6nLJkGfDMRQppQKx29Ii+/i+QSQFXq6YE8uMW93WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775015142; c=relaxed/simple;
	bh=ypzChen/APZaYREYqY0FTxXaNoFqzn+YyqaLO/85AEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkJJVOO95dYnSclQFucd8Q//BgbGlUyBRcmLICC4ztw75WOXDfzsa9zXbI0iizWtTpVGdHmV8QH32YFfc9XTBhOLgZrsjCjUruWUnOAdhLwrZlaIwa9XqA5JxAByYwbVbhof1LsU8TdNPSfKfoxF1ei+8sDapCcsu1VjvdHCw3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cfw0ElOw; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cfw0ElOw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775015140; x=1806551140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ypzChen/APZaYREYqY0FTxXaNoFqzn+YyqaLO/85AEM=;
  b=Cfw0ElOwmGA7cwpqpVtcxv0a8u52FN5dCPWYVUR+Vy3iZFfdgRWIjjPs
   rGGTL4lUxb4RRlR4ZwqKF07jWt4eHUU7Cy3+U5E9fKsfLGq+9cWcD01Ob
   k3s6dqupUvbTMbL1NqtRyqojKP0T+xs2gXUqg9KQMaGAepV3Zp/fpWlAD
   QrVnvMBX2S9YKt43Q9v+Ysc3FjCFM/zARg44NQ9rxbtXjErtKch1sXcro
   t/cRevG5gF2KoKKfGKGnAAuiKxK32pSHjyr5SFXlX92ufaLucjuQmXm8Z
   iRi9FLD7lIQ0a8MEHZ+EcV2LHisLYb4wgQNlpEAY4pIRV5jxNWb9m3ffl
   g==;
X-CSE-ConnectionGUID: PniGJ3PASdC3KLXjVQxUeQ==
X-CSE-MsgGUID: JhaZoIvfRqCFvb1UyTrZ7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75927024"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="75927024"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 20:45:39 -0700
X-CSE-ConnectionGUID: Xr/oDAxrSRK913lgv8Q1cA==
X-CSE-MsgGUID: YmgKI/o0QhmnasCBknDZlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="249771239"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 31 Mar 2026 20:45:36 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7mWL-000000004l0-00pL;
	Wed, 01 Apr 2026 03:45:33 +0000
Date: Wed, 1 Apr 2026 11:45:17 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Eckert <fe@dev.tdt.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Sajid Dalvi <sdalvi@google.com>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rahul Tanwar <rtanwar@maxlinear.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Florian Eckert <fe@dev.tdt.de>, Eckert.Florian@googlemail.com,
	ms@dev.tdt.de
Subject: Re: [PATCH v2 4/7] PCI: intel-gw: Add start_link callback function
Message-ID: <202604011153.Qo18yHpp-lkp@intel.com>
References: <20260330-pcie-intel-gw-v2-4-8bd07367a298@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330-pcie-intel-gw-v2-4-8bd07367a298@dev.tdt.de>

Hi Florian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on f338e77383789c0cae23ca3d48adcc5e9e137e3c]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Eckert/PCI-intel-gw-Remove-unused-define/20260401-051352
base:   f338e77383789c0cae23ca3d48adcc5e9e137e3c
patch link:    https://lore.kernel.org/r/20260330-pcie-intel-gw-v2-4-8bd07367a298%40dev.tdt.de
patch subject: [PATCH v2 4/7] PCI: intel-gw: Add start_link callback function
config: sparc-randconfig-002-20260401 (https://download.01.org/0day-ci/archive/20260401/202604011153.Qo18yHpp-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260401/202604011153.Qo18yHpp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604011153.Qo18yHpp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-intel-gw.c: In function 'intel_pcie_host_setup':
>> drivers/pci/controller/dwc/pcie-intel-gw.c:329:1: warning: label 'err' defined but not used [-Wunused-label]
    err:
    ^~~


vim +/err +329 drivers/pci/controller/dwc/pcie-intel-gw.c

6cbd614d1f7c81 Florian Eckert 2026-03-30  296  
733770d4a2bea0 Fan Fei        2021-12-22  297  static int intel_pcie_host_setup(struct intel_pcie *pcie)
ed22aaaede44f6 Dilip Kota     2019-12-09  298  {
ed22aaaede44f6 Dilip Kota     2019-12-09  299  	int ret;
733770d4a2bea0 Fan Fei        2021-12-22  300  	struct dw_pcie *pci = &pcie->pci;
ed22aaaede44f6 Dilip Kota     2019-12-09  301  
733770d4a2bea0 Fan Fei        2021-12-22  302  	intel_pcie_core_rst_assert(pcie);
733770d4a2bea0 Fan Fei        2021-12-22  303  	intel_pcie_device_rst_assert(pcie);
733770d4a2bea0 Fan Fei        2021-12-22  304  	intel_pcie_core_rst_deassert(pcie);
ed22aaaede44f6 Dilip Kota     2019-12-09  305  
1927e1ec66a6ee Florian Eckert 2026-03-30  306  	/* Controller clock must be provided earlier than PHY */
733770d4a2bea0 Fan Fei        2021-12-22  307  	ret = clk_prepare_enable(pcie->core_clk);
ed22aaaede44f6 Dilip Kota     2019-12-09  308  	if (ret) {
733770d4a2bea0 Fan Fei        2021-12-22  309  		dev_err(pcie->pci.dev, "Core clock enable failed: %d\n", ret);
ed22aaaede44f6 Dilip Kota     2019-12-09  310  		goto clk_err;
ed22aaaede44f6 Dilip Kota     2019-12-09  311  	}
ed22aaaede44f6 Dilip Kota     2019-12-09  312  
1cc9a559993a4a Rob Herring    2020-11-05  313  	pci->atu_base = pci->dbi_base + 0xC0000;
1cc9a559993a4a Rob Herring    2020-11-05  314  
1927e1ec66a6ee Florian Eckert 2026-03-30  315  	ret = phy_init(pcie->phy);
1927e1ec66a6ee Florian Eckert 2026-03-30  316  	if (ret)
1927e1ec66a6ee Florian Eckert 2026-03-30  317  		goto phy_err;
1927e1ec66a6ee Florian Eckert 2026-03-30  318  
733770d4a2bea0 Fan Fei        2021-12-22  319  	intel_pcie_ltssm_disable(pcie);
733770d4a2bea0 Fan Fei        2021-12-22  320  	intel_pcie_link_setup(pcie);
1cc9a559993a4a Rob Herring    2020-11-05  321  	intel_pcie_init_n_fts(pci);
ce06bf570390fb Serge Semin    2022-06-24  322  
1cc9a559993a4a Rob Herring    2020-11-05  323  	dw_pcie_upconfig_setup(pci);
1cc9a559993a4a Rob Herring    2020-11-05  324  
4db57fd92a7d2d Florian Eckert 2026-03-30  325  	intel_pcie_core_irq_enable(pcie);
ed22aaaede44f6 Dilip Kota     2019-12-09  326  
ed22aaaede44f6 Dilip Kota     2019-12-09  327  	return 0;
ed22aaaede44f6 Dilip Kota     2019-12-09  328  
1927e1ec66a6ee Florian Eckert 2026-03-30 @329  err:
1927e1ec66a6ee Florian Eckert 2026-03-30  330  	phy_exit(pcie->phy);
1927e1ec66a6ee Florian Eckert 2026-03-30  331  phy_err:
733770d4a2bea0 Fan Fei        2021-12-22  332  	clk_disable_unprepare(pcie->core_clk);
ed22aaaede44f6 Dilip Kota     2019-12-09  333  clk_err:
733770d4a2bea0 Fan Fei        2021-12-22  334  	intel_pcie_core_rst_assert(pcie);
ed22aaaede44f6 Dilip Kota     2019-12-09  335  
ed22aaaede44f6 Dilip Kota     2019-12-09  336  	return ret;
ed22aaaede44f6 Dilip Kota     2019-12-09  337  }
ed22aaaede44f6 Dilip Kota     2019-12-09  338  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
