Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E004E1DE3DC;
	Wed,  1 Apr 2026 04:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775016644; cv=none; b=l4csMBuD66GiFgmMOE0i5rVOLcPR3k/yrxBqIZTIeqcYvo9VYsULNFudEITgaS+DyVD+XB4zFsZonSPV3WJVgXLB5iyPPRXhkjT8EFmyQPZ0Ejpd/4/b72DeUcvnfDMfdEGkukURyZAnLx0QOF3gVwrxvJOZo/1ZThMuqqRZPzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775016644; c=relaxed/simple;
	bh=M3OXStmL1cePRFOkz0tJjaQlJFUPvHusToITRj48o48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCjBA+S/IT8mdNbyWlasVVz3pl7IXaDYnDetFHwIvSwGcBNvqPIFlR7zS3lKLa6n2inP5MdVD31KmrPKoX0GZd1B7FPra5a5TZuyVO1E864OAvjkByXXD6uIHVG2Icoooatql/3l1b4rfQLatfayTbKxLOmBgBAoa0hNQbOyL7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bB+QicMr; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bB+QicMr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775016642; x=1806552642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M3OXStmL1cePRFOkz0tJjaQlJFUPvHusToITRj48o48=;
  b=bB+QicMrBL8GZ00p25kuxWgyN4/LPAVW8S7bpUCFrwsOONhONTIYu0vN
   VbMupIiqO+ESimwRDJlF0moM4LYZwYD2bRIlBZeT/nw+XAl/qvD0wqdqz
   TULszGqvUwTyzkyQuKkooNmuYZUEjQauoC3nJBrm7uhjrN3AEEHh9BG3p
   giQs6T3qnbbmFvOyenDx0qXXJaspoqNfTVjIVeNWuNBp37dnAnKlmLRTw
   FPc0jgH8VvvnyWlDYzF6aktRoZlL6GmthWVu/gq9kOqJ6CsENECQ61uay
   UeSe3lEp54D9+qnzcl79H1zbFnVqdGWgXE4ks9V8MCKL/4InYjmzUnNuz
   g==;
X-CSE-ConnectionGUID: XyOWmbc9S+ajlR4pQ6ZMPw==
X-CSE-MsgGUID: I+cOpM/+RAm0Nn/ZHFaZlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="78638794"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="78638794"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 21:10:41 -0700
X-CSE-ConnectionGUID: uqtPI94cS4OAafsD3P2hKw==
X-CSE-MsgGUID: JUIOx9YFSrijQbjR1Ypalw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="230976723"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 31 Mar 2026 21:10:36 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7muX-000000004m2-3ahq;
	Wed, 01 Apr 2026 04:10:33 +0000
Date: Wed, 1 Apr 2026 12:10:07 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>,
	Eckert.Florian@googlemail.com, ms@dev.tdt.de
Subject: Re: [PATCH v2 4/7] PCI: intel-gw: Add start_link callback function
Message-ID: <202604011157.4RiSNWVi-lkp@intel.com>
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
config: arm64-randconfig-001-20260401 (https://download.01.org/0day-ci/archive/20260401/202604011157.4RiSNWVi-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260401/202604011157.4RiSNWVi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604011157.4RiSNWVi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-intel-gw.c:329:1: warning: unused label 'err' [-Wunused-label]
     329 | err:
         | ^~~~
   1 warning generated.


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
