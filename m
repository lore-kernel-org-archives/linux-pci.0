Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8333DEF5
	for <linux-pci@vger.kernel.org>; Sat,  7 Feb 2026 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770460842; cv=none; b=YlEQD+AAwjbxDC/hABEe/8WdKCLC0X8ZszfhCLuFh3FGWtPWeqoQ9yiVG9dxbgM1oKBj3nNeXcLHspZnCTrx9U1Tl1yp8HU8K6PcGqGrJT/pDEfmCACBcHFq8qFa+zyMBi/Uvf0LsxiCw1+x42FSu0KRUarpySsDiGRhm/s6YkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770460842; c=relaxed/simple;
	bh=jtlb6g+YjLhv+CztXc3FrbHWDtmM3ncLo/cUAPsVtAI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rubN7ex97aNsHj9hNBqSyQbsVyLLWO6hB6VgvPq3mlW29tY1NtOkBjfAp4E4iWoxRN8o8X8Zlw9i7vvvxlmwxrvEvN1fqgaKCZyFQ/rKqpNLj2x6NegYr1InJ0gwXu821E5TEdcLw+QbOj8kKtJfD/RSbcmHd5e+e80/uj7QFm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KduBDt38; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KduBDt38"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770460842; x=1801996842;
  h=date:from:to:cc:subject:message-id;
  bh=jtlb6g+YjLhv+CztXc3FrbHWDtmM3ncLo/cUAPsVtAI=;
  b=KduBDt38okbfhJpwzAbN2lyt1cB2Vx09tr60ezaLlRZ6RKfZ2cjnIUZ0
   LIYrLRUc2hLjTW3abT6AtBFbNevpClKAm0E7WscngnFmitqj6gd+7y6B8
   5hO45JKZzTypiSWFbNBHxvf4jcFU9Wvs5JZ1gZmKMU9XJLMagQX3MYGlR
   WnsNLbfvJOdRN945PXzZutOj0EpE4DycUbyW7lQE5hc8VbhWjeERLTeto
   x+pAv3szGBBRdfjwc+gFN8IZxdOvn4PYjVXkjinNPmVnyveDX6RlterMy
   LKhvMTGhhOsfZl+AcciwqqUVgwf3Hw9Kd6zUA7uq6V9K0AIw2vgvadm+j
   w==;
X-CSE-ConnectionGUID: TZZ6Q4Q2SrO7Ys9Gv6pgAA==
X-CSE-MsgGUID: AH8Oob4HSD6IVqD4zrvNjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="82288347"
X-IronPort-AV: E=Sophos;i="6.21,278,1763452800"; 
   d="scan'208";a="82288347"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2026 02:40:41 -0800
X-CSE-ConnectionGUID: g1dLxpqaQiGPT31YUXvKlw==
X-CSE-MsgGUID: GZqSTPqoTV2C7MZalp0RMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,278,1763452800"; 
   d="scan'208";a="211148427"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 07 Feb 2026 02:40:41 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vofjy-00000000laM-01Ci;
	Sat, 07 Feb 2026 10:40:38 +0000
Date: Sat, 07 Feb 2026 18:39:50 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 2ecc1bf14e2fdaff78bd1b8e7ed3dba336a3fad5
Message-ID: <202602071842.tUIHSpIr-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: 2ecc1bf14e2fdaff78bd1b8e7ed3dba336a3fad5  PCI: Don't claim disabled bridge windows

elapsed time: 728m

configs tested: 210
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.2.0
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                          axs101_defconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                         haps_hs_defconfig    gcc-15.2.0
arc                   randconfig-001-20260207    gcc-8.5.0
arc                   randconfig-002-20260207    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                     am200epdkit_defconfig    gcc-15.2.0
arm                        clps711x_defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                          exynos_defconfig    gcc-15.2.0
arm                      footbridge_defconfig    gcc-15.2.0
arm                       imx_v6_v7_defconfig    gcc-15.2.0
arm                         mv78xx0_defconfig    gcc-15.2.0
arm                          pxa3xx_defconfig    gcc-15.2.0
arm                   randconfig-001-20260207    gcc-8.5.0
arm                   randconfig-002-20260207    gcc-8.5.0
arm                   randconfig-003-20260207    gcc-8.5.0
arm                   randconfig-004-20260207    gcc-8.5.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260207    gcc-15.2.0
arm64                 randconfig-002-20260207    gcc-15.2.0
arm64                 randconfig-003-20260207    gcc-15.2.0
arm64                 randconfig-004-20260207    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260207    gcc-15.2.0
csky                  randconfig-002-20260207    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260207    clang-22
hexagon               randconfig-002-20260207    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260207    clang-20
i386        buildonly-randconfig-002-20260207    clang-20
i386        buildonly-randconfig-003-20260207    clang-20
i386        buildonly-randconfig-004-20260207    clang-20
i386        buildonly-randconfig-005-20260207    clang-20
i386        buildonly-randconfig-006-20260207    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260207    clang-20
i386                  randconfig-002-20260207    clang-20
i386                  randconfig-003-20260207    clang-20
i386                  randconfig-004-20260207    clang-20
i386                  randconfig-005-20260207    clang-20
i386                  randconfig-006-20260207    clang-20
i386                  randconfig-007-20260207    clang-20
i386                  randconfig-011-20260207    clang-20
i386                  randconfig-012-20260207    clang-20
i386                  randconfig-013-20260207    clang-20
i386                  randconfig-014-20260207    clang-20
i386                  randconfig-015-20260207    clang-20
i386                  randconfig-016-20260207    clang-20
i386                  randconfig-017-20260207    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260207    clang-22
loongarch             randconfig-002-20260207    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                        m5407c3_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath25_defconfig    clang-22
mips                      maltasmvp_defconfig    gcc-15.2.0
mips                          rb532_defconfig    clang-22
nios2                            alldefconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260207    clang-22
nios2                 randconfig-002-20260207    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260207    gcc-14.3.0
parisc                randconfig-002-20260207    gcc-14.3.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      chrp32_defconfig    clang-22
powerpc                     ep8248e_defconfig    gcc-15.2.0
powerpc                        icon_defconfig    gcc-15.2.0
powerpc                     mpc512x_defconfig    gcc-15.2.0
powerpc                     mpc5200_defconfig    gcc-15.2.0
powerpc                 mpc832x_rdb_defconfig    gcc-15.2.0
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc                      ppc44x_defconfig    clang-22
powerpc               randconfig-001-20260207    gcc-14.3.0
powerpc               randconfig-002-20260207    gcc-14.3.0
powerpc                     redwood_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260207    gcc-14.3.0
powerpc64             randconfig-002-20260207    gcc-14.3.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_virt_defconfig    gcc-15.2.0
riscv                 randconfig-001-20260207    clang-18
riscv                 randconfig-002-20260207    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260207    clang-18
s390                  randconfig-002-20260207    clang-18
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                        edosk7705_defconfig    gcc-15.2.0
sh                          landisk_defconfig    gcc-15.2.0
sh                    randconfig-001-20260207    clang-18
sh                    randconfig-002-20260207    clang-18
sh                           se7712_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260207    gcc-15.2.0
sparc                 randconfig-002-20260207    gcc-15.2.0
sparc                       sparc64_defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260207    gcc-15.2.0
sparc64               randconfig-002-20260207    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260207    gcc-15.2.0
um                    randconfig-002-20260207    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260207    gcc-14
x86_64      buildonly-randconfig-002-20260207    gcc-14
x86_64      buildonly-randconfig-003-20260207    gcc-14
x86_64      buildonly-randconfig-004-20260207    gcc-14
x86_64      buildonly-randconfig-005-20260207    gcc-14
x86_64      buildonly-randconfig-006-20260207    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260207    clang-20
x86_64                randconfig-002-20260207    clang-20
x86_64                randconfig-003-20260207    clang-20
x86_64                randconfig-004-20260207    clang-20
x86_64                randconfig-005-20260207    clang-20
x86_64                randconfig-006-20260207    clang-20
x86_64                randconfig-011-20260207    gcc-14
x86_64                randconfig-012-20260207    gcc-14
x86_64                randconfig-013-20260207    gcc-14
x86_64                randconfig-014-20260207    gcc-14
x86_64                randconfig-015-20260207    gcc-14
x86_64                randconfig-016-20260207    gcc-14
x86_64                randconfig-071-20260207    gcc-14
x86_64                randconfig-072-20260207    gcc-14
x86_64                randconfig-073-20260207    gcc-14
x86_64                randconfig-074-20260207    gcc-14
x86_64                randconfig-075-20260207    gcc-14
x86_64                randconfig-076-20260207    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20260207    gcc-15.2.0
xtensa                randconfig-002-20260207    gcc-15.2.0
xtensa                    smp_lx200_defconfig    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
