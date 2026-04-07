Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A844D37647E
	for <linux-pci@vger.kernel.org>; Tue,  7 Apr 2026 03:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775534378; cv=none; b=HG9LvQJxzrdEnpJ3WkTXQBhgYjwd/z8B94lJQ4M+sq65csRe8wcbempQXXVEc7wq862gb2tfZ9DQreb10xVfjrNHrUTXt1O9ME5cp4RVky6cB7TSzxqA8HuZcCfDVdTeT+OYk3YbsmbcvcVRVsEXaKZCNgipOcQPZnR1Sjh+DQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775534378; c=relaxed/simple;
	bh=bs4ZahIMWJZW/wTLo1PQIM+tebHc/w5EM0a1rOQ7YRg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=POxSDrAx7iwcxCdRcgeJwn4wvMMQuoo6gOmBukvfGtOchQRD9XROFYVRf6PGc7d6QiWWbPdKDUuQmN3T3ds217jo6B0FGuFjQdzdyQDVOV8vxcu/z+iSmbRwMkPhlZ8WH1vYL0sUrhKXNO+U83lLCOiEju5Zg8+APMx9h9PFuTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DexTzurT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DexTzurT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775534378; x=1807070378;
  h=date:from:to:cc:subject:message-id;
  bh=bs4ZahIMWJZW/wTLo1PQIM+tebHc/w5EM0a1rOQ7YRg=;
  b=DexTzurTrvbJSr0sAVXfBUXw1D1etNRkgFTKVJ17tS0X2CaqZw+8E8Bt
   qSOVUA4RbdzeEMh/7wV5qiwOsjSqF3C1TP3S+sHiL1Tw+B8ZASiEnmhI3
   ZOvPxsY4uD59pc5WW4r5cTsKB6XJUaL3ikSLr7vMh/TarhLKKC+n22tlj
   pNv06fHoM/dWugYLPDZugfroVEzmc1zAJNiefv7vcY7Ku15gIiutzuhyb
   Zkxob0MjPaEnAw1LpVMOPwxQNckaWtD3eC9YjvDDKwh3ZIiISYFAkcynk
   ZpOVMjkTBgwInoyTWUYhnRKptBdGlMtmH2ee6yvEuWsbJLQnMgyGvSz74
   A==;
X-CSE-ConnectionGUID: gE6EsNJSSsqavY6qUQQM5A==
X-CSE-MsgGUID: 3k79RAlBQ6CVVwvxiRQ/bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76369613"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="76369613"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 20:59:37 -0700
X-CSE-ConnectionGUID: kO4g5r1RQaywQoAtgNXcjQ==
X-CSE-MsgGUID: ortnPMxKREy5F0mFJHUwFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="232091430"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 06 Apr 2026 20:59:36 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w9xbB-0000000006n-1Ovg;
	Tue, 07 Apr 2026 03:59:33 +0000
Date: Tue, 07 Apr 2026 11:58:58 +0800
From: kernel test robot <lkp@intel.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
 Manivannan Sadhasivam <mani@kernel.org>
Subject: [pci:controller/dwc-tegra194 22/22]
 include/linux/compiler_types.h:706:45: error: call to
 '__compiletime_assert_485' declared with attribute error: min((
 __builtin_constant_p(us) ? ((us) < 2 ? 0 : 63 - __builtin_clzll(us)) :
 (sizeof(us) <= 4) ? __ilog2_u32(us) : __ilog2_u64(us) ) + 1, 7U) s...
Message-ID: <202604051407.AODe3ddZ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-tegra194
head:   814f4e4b6cceda9e816fbeaf2a6a0f9b50b3f23a
commit: 814f4e4b6cceda9e816fbeaf2a6a0f9b50b3f23a [22/22] PCI: tegra194: Use aspm-l1-entry-delay-ns DT property for L1 entrance latency
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20260405/202604051407.AODe3ddZ-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260405/202604051407.AODe3ddZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604051407.AODe3ddZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/pci/controller/dwc/pcie-tegra194.c: In function 'tegra_pcie_dw_parse_dt':
>> include/linux/compiler_types.h:706:45: error: call to '__compiletime_assert_485' declared with attribute error: min(( __builtin_constant_p(us) ? ((us) < 2 ? 0 : 63 - __builtin_clzll(us)) : (sizeof(us) <= 4) ? __ilog2_u32(us) : __ilog2_u64(us) ) + 1, 7U) signedness error
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:687:25: note: in definition of macro '__compiletime_assert'
     687 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:93:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      93 |         BUILD_BUG_ON_MSG(!__types_ok(ux, uy),           \
         |         ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:98:9: note: in expansion of macro '__careful_cmp_once'
      98 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:105:25: note: in expansion of macro '__careful_cmp'
     105 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-tegra194.c:1150:43: note: in expansion of macro 'min'
    1150 |                 pcie->aspm_l1_enter_lat = min(ilog2(us) + 1, 7U);
         |                                           ^~~


vim +/__compiletime_assert_485 +706 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  692  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  693  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  694  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  695  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  696  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  697   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  698   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  699   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  700   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  701   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  702   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  703   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  704   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  705  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @706  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  707  

:::::: The code at line 706 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
