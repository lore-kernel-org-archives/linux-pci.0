Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF8432B99F;
	Tue, 27 Jan 2026 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769497925; cv=none; b=ONS9rjzdvNklHk/0gpB53KpmVD+hiRMcX6HDtc4TUCGsgqFiwlUO70U76q6BrvMuJZlrmHF0ah7FXIzEbXfHH4LH6S58p800E1k3mvJEkPiCH23xbtCxUJx3yVJDFgN0rJA+yUAKOVmQuTRftYtpU/MVSkHMP2+EKFZbRX3cVfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769497925; c=relaxed/simple;
	bh=2Qd9XEtpHBydFVVajsCBLmayruLHcQ+ZWqi4LLtEbFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRugR2i8MvlC6cDG59R3Aoy5mhMrskQ6MtEIGrqTgFRhcvJ+6THPjQCVW+3u44YGNqX+bvFldHRnzDUhYvQuk9NinINYBa7nlbeGK+Zfr7/CvaKZGHRkjaOmlUlmwssq21vNJe2cGtR8nwtu5oNTF8WdXq0VBPl934NL1mI0bAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C5cjzp3E; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C5cjzp3E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769497924; x=1801033924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Qd9XEtpHBydFVVajsCBLmayruLHcQ+ZWqi4LLtEbFc=;
  b=C5cjzp3Eo9psv+gU3G6NRTtRzcD0ep6wRnW9NLzOBkQZuvuv6TPgSvD2
   ETJ4tKWDvB1aYu3ye/wF5s1SaYt1VUZdUXKuOHQy6WNHvilNJJX6aqdVA
   eBwgim89uFYJmBToTtOUZHET3K58d090kRsK7KxHb9UtaVyxvOwi+s9K/
   zwJz5MYF93NrvThLseXS/cA9jd0q/bAT/A1fkoPkzj73lsLBWAXO5TNqr
   F/sjHG8DVdOC6HZGoeYK/ZCKNYeEkiFRGLuT+R80Gtb/oy/sL5ue6Kf/D
   WzORvxASBBnR7Kx+bjq2PDr6CC5RsmYtpMbp1iVdR/AuS0pdq8oPQB2Ui
   w==;
X-CSE-ConnectionGUID: aKQeNtwoT6angOONtaMm8Q==
X-CSE-MsgGUID: MgJK5Z2ASLqJv2m5yMvl+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="58259851"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="58259851"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 23:12:03 -0800
X-CSE-ConnectionGUID: eCkwl3AcRp23gsnn0PaD4Q==
X-CSE-MsgGUID: WFwduOm1TTet8heOIz16mg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 26 Jan 2026 23:12:01 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkdF0-00000000Y5K-2Xwm;
	Tue, 27 Jan 2026 07:11:58 +0000
Date: Tue, 27 Jan 2026 15:11:10 +0800
From: kernel test robot <lkp@intel.com>
To: Koichiro Den <den@valinux.co.jp>, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, Frank.Li@nxp.com
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Add helper to query integrated dw-edma
 register window
Message-ID: <202601271506.INKGUWyt-lkp@intel.com>
References: <20260126071550.3233631-2-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126071550.3233631-2-den@valinux.co.jp>

Hi Koichiro,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.19-rc7 next-20260126]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Koichiro-Den/PCI-dwc-Add-helper-to-query-integrated-dw-edma-register-window/20260126-152209
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260126071550.3233631-2-den%40valinux.co.jp
patch subject: [PATCH 1/2] PCI: dwc: Add helper to query integrated dw-edma register window
config: um-randconfig-r071-20260127 (https://download.01.org/0day-ci/archive/20260127/202601271506.INKGUWyt-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260127/202601271506.INKGUWyt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601271506.INKGUWyt-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-designware.c: In function 'dwc_pcie_edma_get_reg_window':
>> drivers/pci/controller/dwc/pcie-designware.c:1358:14: error: implicit declaration of function 'epc_get_drvdata'; did you mean 'epf_get_drvdata'? [-Wimplicit-function-declaration]
    1358 |         ep = epc_get_drvdata(epc);
         |              ^~~~~~~~~~~~~~~
         |              epf_get_drvdata
>> drivers/pci/controller/dwc/pcie-designware.c:1358:12: error: assignment to 'struct dw_pcie_ep *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1358 |         ep = epc_get_drvdata(epc);
         |            ^


vim +1358 drivers/pci/controller/dwc/pcie-designware.c

  1348	
  1349	int dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
  1350					 resource_size_t *sz)
  1351	{
  1352		struct dw_pcie_ep *ep;
  1353		struct dw_pcie *pci;
  1354	
  1355		if (!epc || !phys || !sz)
  1356			return -EINVAL;
  1357	
> 1358		ep = epc_get_drvdata(epc);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
