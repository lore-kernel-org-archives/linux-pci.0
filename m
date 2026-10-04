Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475EF392823
	for <linux-pci@vger.kernel.org>; Sun,  4 Oct 2026 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791125846; cv=none; b=M0Z4f906YcPLnp1C3kKhL5qlv5Xy4qGJEJ4d2tAtPyfwL6aAWhwn6T93LTQtffr8MEZOY+A5pooJ40PZKLu3wr6e0EkE0S4lOXByj02gBrSjGjBqEAeSwlh+9PISnQKmTT4bxYFJZLqy7mvrmQDwGrmTD/54f5DRb9sDHGpX/E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791125846; c=relaxed/simple;
	bh=jKRDeQWHATNQKguOq+DACJaAb5fWymP47mTILZgh/pw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XJjrC0gcfULCNGdskjCcK9w91y2YlCvv0MMyoXYklGmYay0wk649R2FICbPtE6ETWtqoB7iCt3oIlmt90IJKudPGDkNvXSB71g/iEz/ZGJ8qUqYpBx1yEL55GhYtUsUyqI6gAfFfLzNzKKFMx/SPQO4TRBYq51sMV7v4d6Fab9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cfW+upAc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cfW+upAc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791125842; x=1822661842;
  h=date:from:to:cc:subject:message-id;
  bh=jKRDeQWHATNQKguOq+DACJaAb5fWymP47mTILZgh/pw=;
  b=cfW+upAcXHqbFQ+F1gGuO3j2tXvLajngenslrTaO/9p1//V+vVMcUB39
   4+/PlD8hhNbWpUjh7x/rXRu3NTR1GoKdW4BCZ/Zp8Ok+sNzj9DYACH1FM
   kfMuy6OGwkhJfd5Q00iR4QiEqE4HTCw5wYgaiopXWu+29RYFGTPPUgNpN
   PfpPjnkayxQe0hyWR68uj+INRr7VeeP7QfQa969/K0IFkas73CwXKXZAi
   JtEVPGp/hd0NpPERI12DUZfAhLt23c1qDaim/AxwBSbjo02TBi182bI+D
   GGEiSNbLyOdxjeW3Dlkge1rjdQqCKdcQcBw/iEeutrK6yEPMOx83GvgSa
   Q==;
X-CSE-ConnectionGUID: CkjSettlS5mAU5jNv/NEXQ==
X-CSE-MsgGUID: lnyFIRScSeyN30r9vfG9JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="94524592"
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; 
   d="scan'208";a="94524592"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 07:57:18 -0700
X-CSE-ConnectionGUID: ww61SwTSSHGfFlJVdNpdkw==
X-CSE-MsgGUID: AYkCI+9SRoCWIdNc5Jnbqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; 
   d="scan'208";a="284698988"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 04 Oct 2026 07:57:16 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xDNeL-00000000Uoj-3IxK;
	Sun, 04 Oct 2026 14:57:13 +0000
Date: Sun, 04 Oct 2026 22:56:54 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-pci@vger.kernel.org
Subject: [pci:next 20/29]
 drivers/pci/controller/dwc/pcie-rcar-gen4.c:307:30: error: use of undeclared
 identifier 'PCIE_PORT_LANE_SKEW'
Message-ID: <202610042255.a8dle5HM-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
head:   372b7a0d9c7c0cb724b259db9d39c785ad9dec74
commit: 9bab7146bd9ef2700f42d705d8e01d7d95362d0f [20/29] Merge branch 'pci/controller/dwc-rcar-gen4'
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20261004/202610042255.a8dle5HM-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 5f609f950d2e80addf5566623013db68394334db)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261004/202610042255.a8dle5HM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610042255.a8dle5HM-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-rcar-gen4.c:307:30: error: use of undeclared identifier 'PCIE_PORT_LANE_SKEW'
     307 |         val = dw_pcie_readl_dbi(dw, PCIE_PORT_LANE_SKEW);
         |                                     ^~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-rcar-gen4.c:311:25: error: use of undeclared identifier 'PCIE_PORT_LANE_SKEW'
     311 |         dw_pcie_writel_dbi(dw, PCIE_PORT_LANE_SKEW, val);
         |                                ^~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-rcar-gen4.c:338:30: error: use of undeclared identifier 'PCIE_PORT_LANE_SKEW'
     338 |         val = dw_pcie_readl_dbi(dw, PCIE_PORT_LANE_SKEW);
         |                                     ^~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-rcar-gen4.c:342:25: error: use of undeclared identifier 'PCIE_PORT_LANE_SKEW'
     342 |         dw_pcie_writel_dbi(dw, PCIE_PORT_LANE_SKEW, val);
         |                                ^~~~~~~~~~~~~~~~~~~
   4 errors generated.


vim +/PCIE_PORT_LANE_SKEW +307 drivers/pci/controller/dwc/pcie-rcar-gen4.c

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
