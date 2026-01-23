Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74443286A7;
	Fri, 23 Jan 2026 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176505; cv=none; b=rZas7PLFGku7Vc514B8BeA8dfEE06645TKX2N9PhTmeVOp/RLxaLY7BT1vPmxss7sDgrTPjk3A1/7cyX4PuQU+eYwL+nKQ8nvwwjKy3eMRhtuVEDms2Tevfzqd7pcYfanyxCl1O5Lbt7JugjCiJfrQd36ycjCSSHLBz6EHz00+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176505; c=relaxed/simple;
	bh=0pgF0pbLibHfPkijHatzQ2gp7eE59gKjVslQpkFcBf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxoLYfPjT75AFxtaJUZ7X45zPoA+I6YAGL5eGYv3e3ufgeq1REH7K1uplZpcXUbzPPDRf4c7bqnQDhfGg2lJ7YOW6nwZELMNoDDd2j3jOvqbu3L1VixmWk2Nk54nVXFRA0KCaI7dwbcHDIdEVPv94jIohW1WdfVDZeH4+E7QGH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QaulnBsD; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QaulnBsD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769176504; x=1800712504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0pgF0pbLibHfPkijHatzQ2gp7eE59gKjVslQpkFcBf4=;
  b=QaulnBsDNQLzOh303ZIJcTpBAVMpgPymYywyeJbAkUY2gsNrSV6G9F07
   8yOCtS54yiNzbvZJ4jKgxu9xDNTHXSOSMUX24XB+dz2yof1kq/lXr1IUa
   XLl+xFl9/7z6iCCw2Vg9HSgD0e/uYgNJBwRXOs7+gb0oyhnZiIdd3be5c
   C9abgWy96LK4FjqCKep7COsCYnnE1utwwv5/57zoZdfngWJvlGHYK5iq8
   eIYT/at+II61efvnBx3H5GcWRPQzzflwwlutgFzSZvD9QDUnoBizZG82v
   FNkXl1OYj4bnoIPi0UJd8hKTjeKWsnY/OEk8MTObUhm6eyz0yMTzCWDbM
   Q==;
X-CSE-ConnectionGUID: R6thWyd5TY6pRN4H71t+/g==
X-CSE-MsgGUID: X1p3O3UyThK49Kvxprhtjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="81146429"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="81146429"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 05:55:03 -0800
X-CSE-ConnectionGUID: Emh/K4QUTkeV6CigTQXAOg==
X-CSE-MsgGUID: HCITQHeMQieupCXSbQeVOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="237683224"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 23 Jan 2026 05:54:57 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjHck-00000000Tza-3qjZ;
	Fri, 23 Jan 2026 13:54:54 +0000
Date: Fri, 23 Jan 2026 21:54:07 +0800
From: kernel test robot <lkp@intel.com>
To: smadhavan@nvidia.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, ming.li@zohomail.com,
	rrichter@amd.com, Smita.KoralahalliChannabasappa@amd.com,
	linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, smadhavan@nvidia.com, vaslot@nvidia.com,
	vsethi@nvidia.com, sdonthineni@nvidia.com, vidyas@nvidia.com,
	mochs@nvidia.com, jsequeira@nvidia.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 04/10] PCI: add CXL reset method
Message-ID: <202601232148.jndyojSY-lkp@intel.com>
References: <20260120222610.2227109-5-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120222610.2227109-5-smadhavan@nvidia.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.19-rc6]
[cannot apply to next-20260122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/smadhavan-nvidia-com/cxl-move-DVSEC-defines-to-cxl-pci-header/20260121-071852
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260120222610.2227109-5-smadhavan%40nvidia.com
patch subject: [PATCH v4 04/10] PCI: add CXL reset method
config: openrisc-allmodconfig (https://download.01.org/0day-ci/archive/20260123/202601232148.jndyojSY-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260123/202601232148.jndyojSY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601232148.jndyojSY-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/cxl/pci.c:1085:6: error: redefinition of 'cxl_is_type2_device'
    1085 | bool cxl_is_type2_device(struct pci_dev *pdev)
         |      ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/cxl/pci.c:11:
   include/linux/pci.h:1474:20: note: previous definition of 'cxl_is_type2_device' with type 'bool(struct pci_dev *)' {aka '_Bool(struct pci_dev *)'}
    1474 | static inline bool cxl_is_type2_device(struct pci_dev *dev)
         |                    ^~~~~~~~~~~~~~~~~~~


vim +/cxl_is_type2_device +1085 drivers/cxl/pci.c

2905cb5236cba6 Dan Williams       2022-11-29  1084  
b345d117d51557 Srirangan Madhavan 2026-01-20 @1085  bool cxl_is_type2_device(struct pci_dev *pdev)
b345d117d51557 Srirangan Madhavan 2026-01-20  1086  {
b345d117d51557 Srirangan Madhavan 2026-01-20  1087  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
b345d117d51557 Srirangan Madhavan 2026-01-20  1088  
b345d117d51557 Srirangan Madhavan 2026-01-20  1089  	if (!cxlds)
b345d117d51557 Srirangan Madhavan 2026-01-20  1090  		return false;
b345d117d51557 Srirangan Madhavan 2026-01-20  1091  
b345d117d51557 Srirangan Madhavan 2026-01-20  1092  	return cxlds->type == CXL_DEVTYPE_DEVMEM;
b345d117d51557 Srirangan Madhavan 2026-01-20  1093  }
b345d117d51557 Srirangan Madhavan 2026-01-20  1094  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
