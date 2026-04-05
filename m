Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCCC36BCE2
	for <linux-pci@vger.kernel.org>; Sun,  5 Apr 2026 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775375885; cv=none; b=GeVDvp+6OZ7wTw0o7jxSkWys8gncLFEpOGlb5fnRcuFcbUxgCG1cjQOJnb/H3G0EmBBSnXawUuYQela32Y96RK+H1ifWkB/XkDchUqCPwTEzhUH4/SAHxtVa7eHiPcExPggZEZUOZflQqlilAmraW/ZE8ToQDGQj64wVw15skzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775375885; c=relaxed/simple;
	bh=bPwErxuGARw+emP7rOdhCF2hIkwSyqK3lqVxjpDN9bo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=H5VVtWXDl9tVflyzHd9mk3atWpKDL6PKLR3p0jDks18xVCybIhnFEiR4JiMKwK7zrXx3nQvncCLVWMu8B8zJD5h+8ssd6P1jHSHm+FcKhhS6PSz2hE7pP1X52ny/XGbM3ewsmHuPS/BvWPenEaqvjImZBmeEPV+MBEweV65kl5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/MArq4Q; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/MArq4Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775375883; x=1806911883;
  h=date:from:to:cc:subject:message-id;
  bh=bPwErxuGARw+emP7rOdhCF2hIkwSyqK3lqVxjpDN9bo=;
  b=V/MArq4QGOCvNLHtZqLdVPWynPLkZXdUvwV4f2s9KPveenpdg3jHYFpo
   wLUWdBOHzY0qUGRnmdAztOFe3pPlFUOUMD8G4idZr7mroswT8UXSoP1fy
   sD8OYjuZY9MRk6MSXs4Cj+x75fKUvzbs51sVtt1BCjJMy859z1rTA8tTD
   9ynYe2JRzvMr/kE11gl2pI37exdPd1Yp9P+aFQA8cLZHXj+mT6EIXrRpX
   f7GsGQ+j+HFXRcy3eGnLvMId32XdtVe5eSpu4BBGS/7G7wf0XN20SvubP
   TWS2sETeRrkGH436ljaBTDITB5zlU7/Z9gzZDsUulkfCo2ilQXxsDZaRd
   A==;
X-CSE-ConnectionGUID: dk53s2xmQuuPL/WWKnDzMw==
X-CSE-MsgGUID: rahJLdAvQ4CzXY5eBkLhiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11749"; a="80254840"
X-IronPort-AV: E=Sophos;i="6.23,161,1770624000"; 
   d="scan'208";a="80254840"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2026 00:58:00 -0700
X-CSE-ConnectionGUID: mYzHqzyVTsKdvs1mVEJV9w==
X-CSE-MsgGUID: HGjVaoIPRcWXvZroQNKUog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,161,1770624000"; 
   d="scan'208";a="224372213"
Received: from lkp-server01.sh.intel.com (HELO 3afb7d003cac) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 05 Apr 2026 00:57:59 -0700
Received: from kbuild by 3afb7d003cac with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w9IMn-000000001xd-0VeB;
	Sun, 05 Apr 2026 07:57:57 +0000
Date: Sun, 05 Apr 2026 15:57:13 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-tegra194] BUILD REGRESSION
 814f4e4b6cceda9e816fbeaf2a6a0f9b50b3f23a
Message-ID: <202604051501.dHKaMNV4-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-tegra194
branch HEAD: 814f4e4b6cceda9e816fbeaf2a6a0f9b50b3f23a  PCI: tegra194: Use aspm-l1-entry-delay-ns DT property for L1 entrance latency

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202604051407.AODe3ddZ-lkp@intel.com
    https://lore.kernel.org/oe-kbuild/202604050715.MA13IkPi-lkp@intel.com

    include/linux/compiler_types.h:699:38: error: call to '__compiletime_assert_468' declared with attribute error: min(( __builtin_constant_p(us) ? ((us) < 2 ? 0 : 63 - __builtin_clzll(us)) : (sizeof(us) <= 4) ? __ilog2_u32(us) : __ilog2_u64(us) ) + 1, 7U) signedness error
    include/linux/compiler_types.h:699:45: error: call to '__compiletime_assert_505' declared with attribute error: min(( __builtin_constant_p(us) ? ((us) < 2 ? 0 : 63 - __builtin_clzll(us)) : (sizeof(us) <= 4) ? __ilog2_u32(us) : __ilog2_u64(us) ) + 1, 7U) signedness error
    include/linux/compiler_types.h:699:45: error: call to '__compiletime_assert_538' declared with attribute error: min(( __builtin_constant_p(us) ? ((us) < 2 ? 0 : 63 - __builtin_clzll(us)) : (sizeof(us) <= 4) ? __ilog2_u32(us) : __ilog2_u64(us) ) + 1, 7U) signedness error
    include/linux/compiler_types.h:706:45: error: call to '__compiletime_assert_484' declared with attribute error: min(( __builtin_constant_p(us) ? ((us) < 2 ? 0 : 63 - __builtin_clzll(us)) : (sizeof(us) <= 4) ? __ilog2_u32(us) : __ilog2_u64(us) ) + 1, 7U) signedness error
    include/linux/compiler_types.h:706:45: error: call to '__compiletime_assert_485' declared with attribute error: min(( __builtin_constant_p(us) ? ((us) < 2 ? 0 : 63 - __builtin_clzll(us)) : (sizeof(us) <= 4) ? __ilog2_u32(us) : __ilog2_u64(us) ) + 1, 7U) signedness error
    include/linux/compiler_types.h:706:45: error: call to '__compiletime_assert_521' declared with attribute error: min(( __builtin_constant_p(us) ? ((us) < 2 ? 0 : 63 - __builtin_clzll(us)) : (sizeof(us) <= 4) ? __ilog2_u32(us) : __ilog2_u64(us) ) + 1, 7U) signedness error
    include/linux/compiler_types.h:706:45: error: call to '__compiletime_assert_527' declared with attribute error: min(( __builtin_constant_p(us) ? ((us) < 2 ? 0 : 63 - __builtin_clzll(us)) : (sizeof(us) <= 4) ? __ilog2_u32(us) : __ilog2_u64(us) ) + 1, 7U) signedness error
    include/linux/compiler_types.h:706:45: error: call to '__compiletime_assert_542' declared with attribute error: min(( __builtin_constant_p(us) ? ((us) < 2 ? 0 : 63 - __builtin_clzll(us)) : (sizeof(us) <= 4) ? __ilog2_u32(us) : __ilog2_u64(us) ) + 1, 7U) signedness error
    include/linux/compiler_types.h:706:45: error: call to '__compiletime_assert_568' declared with attribute error: min(( __builtin_constant_p(us) ? ((us) < 2 ? 0 : 63 - __builtin_clzll(us)) : (sizeof(us) <= 4) ? __ilog2_u32(us) : __ilog2_u64(us) ) + 1, 7U) signedness error

Unverified Error/Warning (likely false positive, kindly check if interested):

    drivers/pci/controller/dwc/pcie-tegra194.c:1150:29: error: call to '__compiletime_assert_520' declared with 'error' attribute: min(( __builtin_constant_p(us) ? ((us) < 2 ? 0 : 63 - __builtin_clzll(us)) : (sizeof(us) <= 4) ? __ilog2_u32(us) : __ilog2_u64(us) ) + 1, 7U) signedness error

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arc-allmodconfig
|   `-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:min((-__builtin_constant_p(us)-((us):__builtin_clzll(us)):(sizeof(us)-)-__ilog2_u32(us):__ilog2_u64(
|-- arc-allyesconfig
|   `-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:min((-__builtin_constant_p(us)-((us):__builtin_clzll(us)):(sizeof(us)-)-__ilog2_u32(us):__ilog2_u64(
|-- csky-allmodconfig
|   `-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:min((-__builtin_constant_p(us)-((us):__builtin_clzll(us)):(sizeof(us)-)-__ilog2_u32(us):__ilog2_u64(
|-- i386-allmodconfig
|   `-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:min((-__builtin_constant_p(us)-((us):__builtin_clzll(us)):(sizeof(us)-)-__ilog2_u32(us):__ilog2_u64(
|-- i386-allyesconfig
|   `-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:min((-__builtin_constant_p(us)-((us):__builtin_clzll(us)):(sizeof(us)-)-__ilog2_u32(us):__ilog2_u64(
|-- i386-buildonly-randconfig-004-20260405
|   `-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:min((-__builtin_constant_p(us)-((us):__builtin_clzll(us)):(sizeof(us)-)-__ilog2_u32(us):__ilog2_u64(
|-- mips-allmodconfig
|   `-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:min((-__builtin_constant_p(us)-((us):__builtin_clzll(us)):(sizeof(us)-)-__ilog2_u32(us):__ilog2_u64(
|-- mips-allyesconfig
|   `-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:min((-__builtin_constant_p(us)-((us):__builtin_clzll(us)):(sizeof(us)-)-__ilog2_u32(us):__ilog2_u64(
|-- openrisc-allmodconfig
|   `-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:min((-__builtin_constant_p(us)-((us):__builtin_clzll(us)):(sizeof(us)-)-__ilog2_u32(us):__ilog2_u64(
|-- parisc-allmodconfig
|   `-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:min((-__builtin_constant_p(us)-((us):__builtin_clzll(us)):(sizeof(us)-)-__ilog2_u32(us):__ilog2_u64(
|-- parisc-allyesconfig
|   `-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:min((-__builtin_constant_p(us)-((us):__builtin_clzll(us)):(sizeof(us)-)-__ilog2_u32(us):__ilog2_u64(
|-- powerpc-allmodconfig
|   `-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:min((-__builtin_constant_p(us)-((us):__builtin_clzll(us)):(sizeof(us)-)-__ilog2_u32(us):__ilog2_u64(
|-- powerpc-randconfig-002-20260405
|   `-- drivers-pci-controller-dwc-pcie-tegra194.c:error:call-to-__compiletime_assert_NNN-declared-with-error-attribute:min((-__builtin_constant_p(us)-((us):__builtin_clzll(us)):(sizeof(us)-)-__ilog2_u32(us):
|-- powerpc64-randconfig-r064-20260405
|   `-- drivers-pci-controller-dwc-pcie-tegra194.c:error:call-to-__compiletime_assert_NNN-declared-with-error-attribute:min((-__builtin_constant_p(us)-((us):__builtin_clzll(us)):(sizeof(us)-)-__ilog2_u32(us):
|-- powerpc64-randconfig-r131-20260405
|   `-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:min((-__builtin_constant_p(us)-((us):__builtin_clzll(us)):(sizeof(us)-)-__ilog2_u32(us):__ilog2_u64(
|-- riscv-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-tegra194.c:error:call-to-__compiletime_assert_NNN-declared-with-error-attribute:min((-__builtin_constant_p(us)-((us):__builtin_clzll(us)):(sizeof(us)-)-__ilog2_u32(us):
|-- sparc64-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-tegra194.c:error:call-to-__compiletime_assert_NNN-declared-with-error-attribute:min((-__builtin_constant_p(us)-((us):__builtin_clzll(us)):(sizeof(us)-)-__ilog2_u32(us):
|-- um-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-tegra194.c:error:call-to-__compiletime_assert_NNN-declared-with-error-attribute:min((-__builtin_constant_p(us)-((us):__builtin_clzll(us)):(sizeof(us)-)-__ilog2_u32(us):
|-- um-allyesconfig
|   `-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:min((-__builtin_constant_p(us)-((us):__builtin_clzll(us)):(sizeof(us)-)-__ilog2_u32(us):__ilog2_u64(
|-- x86_64-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-tegra194.c:error:call-to-__compiletime_assert_NNN-declared-with-error-attribute:min((-__builtin_constant_p(us)-((us):__builtin_clzll(us)):(sizeof(us)-)-__ilog2_u32(us):
|-- x86_64-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-tegra194.c:error:call-to-__compiletime_assert_NNN-declared-with-error-attribute:min((-__builtin_constant_p(us)-((us):__builtin_clzll(us)):(sizeof(us)-)-__ilog2_u32(us):
|-- x86_64-buildonly-randconfig-006-20260405
|   `-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:min((-__builtin_constant_p(us)-((us):__builtin_clzll(us)):(sizeof(us)-)-__ilog2_u32(us):__ilog2_u64(
`-- xtensa-allyesconfig
    `-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:min((-__builtin_constant_p(us)-((us):__builtin_clzll(us)):(sizeof(us)-)-__ilog2_u32(us):__ilog2_u64(

elapsed time: 735m

configs tested: 172
configs skipped: 6

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260405    clang-23
arc                   randconfig-002-20260405    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260405    clang-23
arm                   randconfig-002-20260405    clang-23
arm                   randconfig-003-20260405    clang-23
arm                   randconfig-004-20260405    clang-23
arm                        realview_defconfig    clang-16
arm                         socfpga_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260405    gcc-9.5.0
arm64                 randconfig-002-20260405    gcc-9.5.0
arm64                 randconfig-003-20260405    gcc-9.5.0
arm64                 randconfig-004-20260405    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260405    gcc-9.5.0
csky                  randconfig-002-20260405    gcc-9.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260405    clang-23
hexagon               randconfig-002-20260405    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260405    gcc-14
i386        buildonly-randconfig-002-20260405    gcc-14
i386        buildonly-randconfig-003-20260405    gcc-14
i386        buildonly-randconfig-004-20260405    gcc-14
i386        buildonly-randconfig-005-20260405    gcc-14
i386        buildonly-randconfig-006-20260405    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260405    gcc-14
i386                  randconfig-002-20260405    gcc-14
i386                  randconfig-003-20260405    gcc-14
i386                  randconfig-004-20260405    gcc-14
i386                  randconfig-005-20260405    gcc-14
i386                  randconfig-006-20260405    gcc-14
i386                  randconfig-007-20260405    gcc-14
i386                  randconfig-011-20260405    gcc-14
i386                  randconfig-012-20260405    gcc-14
i386                  randconfig-013-20260405    gcc-14
i386                  randconfig-014-20260405    gcc-14
i386                  randconfig-015-20260405    gcc-14
i386                  randconfig-016-20260405    gcc-14
i386                  randconfig-017-20260405    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260405    clang-23
loongarch             randconfig-002-20260405    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260405    clang-23
nios2                 randconfig-002-20260405    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260405    gcc-10.5.0
parisc                randconfig-002-20260405    gcc-10.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                 mpc837x_rdb_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260405    gcc-10.5.0
powerpc               randconfig-002-20260405    gcc-10.5.0
powerpc64             randconfig-001-20260405    gcc-10.5.0
powerpc64             randconfig-002-20260405    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260405    clang-23
riscv                 randconfig-002-20260405    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260405    clang-23
s390                  randconfig-002-20260405    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                             espt_defconfig    gcc-15.2.0
sh                    randconfig-001-20260405    clang-23
sh                    randconfig-002-20260405    clang-23
sh                        sh7757lcr_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260405    clang-23
sparc                 randconfig-002-20260405    clang-23
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260405    clang-23
sparc64               randconfig-002-20260405    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260405    clang-23
um                    randconfig-002-20260405    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260405    gcc-14
x86_64      buildonly-randconfig-002-20260405    gcc-14
x86_64      buildonly-randconfig-003-20260405    gcc-14
x86_64      buildonly-randconfig-004-20260405    gcc-14
x86_64      buildonly-randconfig-005-20260405    gcc-14
x86_64      buildonly-randconfig-006-20260405    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260405    clang-20
x86_64                randconfig-002-20260405    clang-20
x86_64                randconfig-003-20260405    clang-20
x86_64                randconfig-004-20260405    clang-20
x86_64                randconfig-005-20260405    clang-20
x86_64                randconfig-006-20260405    clang-20
x86_64                randconfig-011-20260405    gcc-14
x86_64                randconfig-012-20260405    gcc-14
x86_64                randconfig-013-20260405    gcc-14
x86_64                randconfig-014-20260405    gcc-14
x86_64                randconfig-015-20260405    gcc-14
x86_64                randconfig-016-20260405    gcc-14
x86_64                randconfig-071-20260405    gcc-14
x86_64                randconfig-072-20260405    gcc-14
x86_64                randconfig-073-20260405    gcc-14
x86_64                randconfig-074-20260405    gcc-14
x86_64                randconfig-075-20260405    gcc-14
x86_64                randconfig-076-20260405    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260405    clang-23
xtensa                randconfig-002-20260405    clang-23

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
