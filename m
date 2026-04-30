Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326D4407572
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777569839; cv=none; b=AUBn6nbzwyymdime1fVyHE2HV9Og6L+sWrBGPfI9J4bfO1dvJeLiSZU4GSF2H9NsWPTI4aPR45KT5UnocTIsJgdhU07ufVrzB2M7ZQBouR5Go1NQBZ7LhWvsZN7Q2a+RyjSbRJKQYzhPfBTRnbYaK94aXglNny9Z6HFNX7LLups=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777569839; c=relaxed/simple;
	bh=6Aq1kwRQI9BkisOksGJTHw/XidkZNjUNFHZx3pBi9XI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mb2GY4+Aft5K9sJ3bO/4iHKqeZz0eqC9lWVjXMo+P2IH4ny4XGmnWdmlZT/KzkrkzHzJocjI5Shi8ino/PELDuzpJ6PmF/sGu9ofypw5artSgAMYGeE5sLo7ncxLVPLCJYcICF+GL05P8OgxQA9vgPM1cNIVVfPy/ePAqI4njeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DCXVgf5Y; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCXVgf5Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777569837; x=1809105837;
  h=date:from:to:cc:subject:message-id;
  bh=6Aq1kwRQI9BkisOksGJTHw/XidkZNjUNFHZx3pBi9XI=;
  b=DCXVgf5Yu0QPqKrjRSHAGiQbHJILC84CtFH7BuRdIJHSEeSk04BzlMKC
   qK8lv0oCkR5j/rnJxj9uzD402InN8Ucg7zEQAjzNvv/ttE9zllJ/A1CvS
   RtnCXJRiNl0S5LZYJHSFjka70mAGhwHhahbX6D6hg4As/azaTiRrCdfQv
   ItMw0u9SkymfeGW3bcz4+hwUlRh878xMkriXNuZ0Rji+5ssAbyx5taW42
   D2IBEqtqwjqVJKbNEZHZUSLj+Cz/jrPgOw2Hju5l5mPzB8LG+L0l+7r9I
   o8W6aWfIyfvKWmaBh1x8bX/piubZ9ZmnOBPLnK3Ax43y/pBgoEAiMODhM
   g==;
X-CSE-ConnectionGUID: sQvZ8DrLQvKQPs+YGfMUVw==
X-CSE-MsgGUID: OsWkJJndT36p9dnyi3TzyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="77560010"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="77560010"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 10:23:56 -0700
X-CSE-ConnectionGUID: NM1xycTBSbWwXyolu5ge+A==
X-CSE-MsgGUID: S5+gEOoMRUuagK209YfN2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="234531202"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 30 Apr 2026 10:23:54 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIV7A-00000000CjQ-17SE;
	Thu, 30 Apr 2026 17:23:52 +0000
Date: Fri, 01 May 2026 01:23:51 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pwrctrl] BUILD SUCCESS
 95c4920701dfca6a8cf4986112898382fa7afc0f
Message-ID: <202605010142.OLz0wRxe-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pwrctrl
branch HEAD: 95c4920701dfca6a8cf4986112898382fa7afc0f  PCI/pwrctrl: Do not try to power on/off devices that don't need pwrctrl

elapsed time: 4296m

configs tested: 167
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260430    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260430    gcc-8.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260430    gcc-8.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260430    gcc-8.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260430    gcc-8.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260430    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260430    clang-23
arm64                 randconfig-002-20260430    clang-23
arm64                 randconfig-003-20260430    clang-23
arm64                 randconfig-004-20260430    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260430    clang-23
csky                  randconfig-002-20260430    clang-23
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260430    gcc-14.3.0
hexagon               randconfig-002-20260430    gcc-14.3.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260430    gcc-14
i386        buildonly-randconfig-002-20260430    gcc-14
i386        buildonly-randconfig-003-20260430    gcc-14
i386        buildonly-randconfig-004-20260430    gcc-14
i386        buildonly-randconfig-005-20260430    gcc-14
i386        buildonly-randconfig-006-20260430    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260430    clang-20
i386                  randconfig-002-20260430    clang-20
i386                  randconfig-003-20260430    clang-20
i386                  randconfig-004-20260430    clang-20
i386                  randconfig-005-20260430    clang-20
i386                  randconfig-006-20260430    clang-20
i386                  randconfig-007-20260430    clang-20
i386                  randconfig-011-20260430    clang-20
i386                  randconfig-012-20260430    clang-20
i386                  randconfig-013-20260430    clang-20
i386                  randconfig-014-20260430    clang-20
i386                  randconfig-015-20260430    clang-20
i386                  randconfig-016-20260430    clang-20
i386                  randconfig-017-20260430    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260430    gcc-14.3.0
loongarch             randconfig-002-20260430    gcc-14.3.0
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
nios2                 randconfig-001-20260430    gcc-14.3.0
nios2                 randconfig-002-20260430    gcc-14.3.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
openrisc                 simple_smp_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260430    gcc-13.4.0
parisc                randconfig-002-20260430    gcc-13.4.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260430    gcc-13.4.0
powerpc               randconfig-002-20260430    gcc-13.4.0
powerpc64             randconfig-001-20260430    gcc-13.4.0
powerpc64             randconfig-002-20260430    gcc-13.4.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                          randconfig-001    clang-23
riscv                 randconfig-001-20260430    clang-23
riscv                          randconfig-002    clang-23
riscv                 randconfig-002-20260430    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                           randconfig-001    clang-23
s390                  randconfig-001-20260430    clang-23
s390                           randconfig-002    clang-23
s390                  randconfig-002-20260430    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                             randconfig-001    clang-23
sh                    randconfig-001-20260430    clang-23
sh                             randconfig-002    clang-23
sh                    randconfig-002-20260430    clang-23
sh                           se7206_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260430    gcc-14
x86_64      buildonly-randconfig-002-20260430    gcc-14
x86_64      buildonly-randconfig-003-20260430    gcc-14
x86_64      buildonly-randconfig-004-20260430    gcc-14
x86_64      buildonly-randconfig-005-20260430    gcc-14
x86_64      buildonly-randconfig-006-20260430    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-011-20260430    clang-20
x86_64                randconfig-012-20260430    clang-20
x86_64                randconfig-013-20260430    clang-20
x86_64                randconfig-014-20260430    clang-20
x86_64                randconfig-015-20260430    clang-20
x86_64                randconfig-016-20260430    clang-20
x86_64                randconfig-071-20260430    gcc-14
x86_64                randconfig-072-20260430    gcc-14
x86_64                randconfig-073-20260430    gcc-14
x86_64                randconfig-074-20260430    gcc-14
x86_64                randconfig-075-20260430    gcc-14
x86_64                randconfig-076-20260430    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
