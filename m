Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B142AD35
	for <linux-pci@vger.kernel.org>; Sun,  4 Oct 2026 05:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791091856; cv=none; b=QU1ExGAafh6L2QK8NS7DNeTNmxng+nr1Nw1rseJvOqS+JZnlRlXhQy9RfAKUbo3QKBETl9r7Ke/T1xrsJgizKLceerM8ILZEUdeNqEQHPgo9lw2cj+IzCnOX+kfVJUCTzkE4Dol4PTmpn4GlHrS3j6FnLb+ep/VZyW9wmxXZdBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791091856; c=relaxed/simple;
	bh=7Gb7MGKqBO+2KqqtILC8TFqZYMH+WPssjmPaUD16WyA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BsEBK6GQ4lQ4OMXUTJAAJ/6ccXiMc03ogolCIEbFUcqbsh0u3oqq9G608A8n1iDrC038Z4+5Q31dG3xa7/z1b5q1rfBYVSkzU2SKc/O2vn1fkmDjNK9XggWxxw+Xt1qFDdRHfSCN/Eypepfv4e4ecP9krqbwPubtlIPS+hr+29U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7u9j774; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7u9j774"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791091853; x=1822627853;
  h=date:from:to:cc:subject:message-id;
  bh=7Gb7MGKqBO+2KqqtILC8TFqZYMH+WPssjmPaUD16WyA=;
  b=O7u9j774VSiSXEgvzv1j/Z3OlszJT6UwbnB/e5QiCQf/xtHwG9UVY0tL
   AGj9aHqky/KKpyk5Qn35rzb/Os1HCgdyEhC+z2julpuMMZk3IIUGJOfXf
   A4vAiO7CI093ewHzFR6MyLJ7+g61gfpl/v82NHijw7KvxKZj9cF7/IsUJ
   L8rgZKPCgQOjslEvcUsGWZGKqAk8tNcTwR6IgTC04d8VXKd8MBUAUZJvs
   xHbZzo+eD1lh7lIAHAlLW3FtKTIduPESiB7sBCNRbvPncUcRl9k6F5MQK
   7PZoxSY2THHsy66bA7CVhFRxMBa3UbMOK/VbjK/8UbtTLR3G94/n1OqRy
   A==;
X-CSE-ConnectionGUID: XqDCxRH4TmeE8tvKdAiJ0w==
X-CSE-MsgGUID: RUtqahOnQTahDC44V9stJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="91660329"
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="91660329"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 22:30:52 -0700
X-CSE-ConnectionGUID: 8P1PlRmISG+AVw07E3TW4g==
X-CSE-MsgGUID: B34Vu2kRRe28CiFdtDIk9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="276625771"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 03 Oct 2026 22:30:50 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xDEoC-00000000UVp-1rGP;
	Sun, 04 Oct 2026 05:30:48 +0000
Date: Sun, 04 Oct 2026 13:30:21 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org
Subject: [pci:next 20/29]
 drivers/pci/controller/dwc/pcie-rcar-gen4.c:307:37: error:
 'PCIE_PORT_LANE_SKEW' undeclared; did you mean 'PORT_LANE_SKEW'?
Message-ID: <202610041359.Iv8zjxRh-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
head:   372b7a0d9c7c0cb724b259db9d39c785ad9dec74
commit: 9bab7146bd9ef2700f42d705d8e01d7d95362d0f [20/29] Merge branch 'pci/controller/dwc-rcar-gen4'
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20261004/202610041359.Iv8zjxRh-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261004/202610041359.Iv8zjxRh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610041359.Iv8zjxRh-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-rcar-gen4.c: In function 'rcar_gen4_v4h_v4m_pcie_init':
>> drivers/pci/controller/dwc/pcie-rcar-gen4.c:307:37: error: 'PCIE_PORT_LANE_SKEW' undeclared (first use in this function); did you mean 'PORT_LANE_SKEW'?
     307 |         val = dw_pcie_readl_dbi(dw, PCIE_PORT_LANE_SKEW);
         |                                     ^~~~~~~~~~~~~~~~~~~
         |                                     PORT_LANE_SKEW
   drivers/pci/controller/dwc/pcie-rcar-gen4.c:307:37: note: each undeclared identifier is reported only once for each function it appears in
   drivers/pci/controller/dwc/pcie-rcar-gen4.c: In function 'rcar_gen5_pcie_init':
   drivers/pci/controller/dwc/pcie-rcar-gen4.c:338:37: error: 'PCIE_PORT_LANE_SKEW' undeclared (first use in this function); did you mean 'PORT_LANE_SKEW'?
     338 |         val = dw_pcie_readl_dbi(dw, PCIE_PORT_LANE_SKEW);
         |                                     ^~~~~~~~~~~~~~~~~~~
         |                                     PORT_LANE_SKEW


vim +307 drivers/pci/controller/dwc/pcie-rcar-gen4.c

0d0c551011df45 Yoshihiro Shimoda 2023-10-18  294  
eeeb72fab4a569 Marek Vasut       2026-09-21  295  static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_gen4_pcie *rcar)
eeeb72fab4a569 Marek Vasut       2026-09-21  296  {
eeeb72fab4a569 Marek Vasut       2026-09-21  297  	struct dw_pcie *dw = &rcar->dw;
eeeb72fab4a569 Marek Vasut       2026-09-21  298  	u32 val;
eeeb72fab4a569 Marek Vasut       2026-09-21  299  	int ret;
eeeb72fab4a569 Marek Vasut       2026-09-21  300  
eeeb72fab4a569 Marek Vasut       2026-09-21  301  	/* R-Car Gen4 common initialization. */
eeeb72fab4a569 Marek Vasut       2026-09-21  302  	ret = rcar_gen4_pcie_common_init(rcar);
eeeb72fab4a569 Marek Vasut       2026-09-21  303  	if (ret)
eeeb72fab4a569 Marek Vasut       2026-09-21  304  		return ret;
eeeb72fab4a569 Marek Vasut       2026-09-21  305  
eeeb72fab4a569 Marek Vasut       2026-09-21  306  	/* R-Car V4H and V4M specific additional initialization. */
eeeb72fab4a569 Marek Vasut       2026-09-21 @307  	val = dw_pcie_readl_dbi(dw, PCIE_PORT_LANE_SKEW);
eeeb72fab4a569 Marek Vasut       2026-09-21  308  	val &= ~PORT_LANE_SKEW_INSERT_MASK;
eeeb72fab4a569 Marek Vasut       2026-09-21  309  	if (dw->num_lanes < 4)
eeeb72fab4a569 Marek Vasut       2026-09-21  310  		val |= BIT(6);
eeeb72fab4a569 Marek Vasut       2026-09-21  311  	dw_pcie_writel_dbi(dw, PCIE_PORT_LANE_SKEW, val);
eeeb72fab4a569 Marek Vasut       2026-09-21  312  
eeeb72fab4a569 Marek Vasut       2026-09-21  313  	val = readl(rcar->base + PCIEPWRMNGCTRL);
eeeb72fab4a569 Marek Vasut       2026-09-21  314  	val |= APP_CLK_REQ_N | APP_CLK_PM_EN;
eeeb72fab4a569 Marek Vasut       2026-09-21  315  	writel(val, rcar->base + PCIEPWRMNGCTRL);
eeeb72fab4a569 Marek Vasut       2026-09-21  316  
eeeb72fab4a569 Marek Vasut       2026-09-21  317  	return 0;
eeeb72fab4a569 Marek Vasut       2026-09-21  318  }
eeeb72fab4a569 Marek Vasut       2026-09-21  319  

:::::: The code at line 307 was first introduced by commit
:::::: eeeb72fab4a569c1cc547c9bf220c808dd37f83d PCI: rcar-gen4: Rework .additional_common_init() into .init()

:::::: TO: Marek Vasut <marek.vasut+renesas@mailbox.org>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
