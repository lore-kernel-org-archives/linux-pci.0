Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F0330B513;
	Tue, 27 Jan 2026 11:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769511872; cv=none; b=Q9zpgr1iGWXkaCWJPYvI6SMDpx+Zy2P783F2RcWLpTEWwgA5RGVO8BrFIEwMjIkQTguPVySGAUq3EcFLDVjQgYhINz2tvJGrfSnJ6uLmmCXkbO1nHrjxD7ji0LPeB1KJ02ODLdGbZt5N1m2zO7tIGwPyOVN8lv7xRyT4rRdGJz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769511872; c=relaxed/simple;
	bh=hcNFbRwWXyNuUcgV9NqJ56BTo6+9jM0oRj/0D8krTs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Agwpx3ZsSlmKcyYCwIriCzidSyPF9aqRduY07wt1HcPJ3/W7CcQOg10INrpC/UxOLEdGge3/wJDGlkUg9sspeFTZhfw8uxHZxTW3ngEsYzXZFHWJtVQc7I9HRWHwx8Iup80f6xqfpN9xm4RVL7Ef8CT+s7jluEfEHlnZw5EGto0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=clmcdXRD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="clmcdXRD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769511871; x=1801047871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hcNFbRwWXyNuUcgV9NqJ56BTo6+9jM0oRj/0D8krTs8=;
  b=clmcdXRDkavbBRnI2dnIhIuSQTWpy8Sn0FmclPN0MdztmL3++552Hmue
   8qpR7lhMpBImGkcnxH7IdyxjP8fep/AbWCxqDDqlFtioqjIEgGSu3TL+U
   N48qQwgcEsJOs1MIPDMoElWk3Zo+lPE3B2dhT+fGZyv2P+G8N+ej3CbgZ
   GA6PZbYsjwV+ibBlOYtDynuZbwug/5OGfOhCVW1N1QIjsxPDbXp0sEtRP
   58gxwHJAYSp8B1XuY4rW1kneoK3s7rGvUJ7VZTH6+D/whns4Rd2TZnddu
   HqGg5MLYCt9t41YCaaUoFOd6HgPUu4P/9coJwjQfDB3ONXAEHEqCRKwK9
   g==;
X-CSE-ConnectionGUID: PRkz6KMTRg646Gs8y4cIVw==
X-CSE-MsgGUID: F1coqlCnSwe4e64cH1Q8Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70607917"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="70607917"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 03:04:24 -0800
X-CSE-ConnectionGUID: MFut99sNQTOlh98Y5aQntw==
X-CSE-MsgGUID: IvtFVNSWTeK/ZrvKKnDoWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="207846222"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 27 Jan 2026 03:04:20 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkgrq-00000000YOK-0gMV;
	Tue, 27 Jan 2026 11:04:18 +0000
Date: Tue, 27 Jan 2026 19:04:01 +0800
From: kernel test robot <lkp@intel.com>
To: Koichiro Den <den@valinux.co.jp>, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, Frank.Li@nxp.com
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Add helper to query integrated dw-edma
 register window
Message-ID: <202601271859.mmq8t4xv-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.19-rc7 next-20260126]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Koichiro-Den/PCI-dwc-Add-helper-to-query-integrated-dw-edma-register-window/20260126-152209
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260126071550.3233631-2-den%40valinux.co.jp
patch subject: [PATCH 1/2] PCI: dwc: Add helper to query integrated dw-edma register window
config: parisc-randconfig-001-20260127 (https://download.01.org/0day-ci/archive/20260127/202601271859.mmq8t4xv-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260127/202601271859.mmq8t4xv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601271859.mmq8t4xv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-designware.c: In function 'dwc_pcie_edma_get_reg_window':
   drivers/pci/controller/dwc/pcie-designware.c:1358:14: error: implicit declaration of function 'epc_get_drvdata'; did you mean 'epf_get_drvdata'? [-Werror=implicit-function-declaration]
    1358 |         ep = epc_get_drvdata(epc);
         |              ^~~~~~~~~~~~~~~
         |              epf_get_drvdata
>> drivers/pci/controller/dwc/pcie-designware.c:1358:12: warning: assignment to 'struct dw_pcie_ep *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1358 |         ep = epc_get_drvdata(epc);
         |            ^
   cc1: some warnings being treated as errors


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
