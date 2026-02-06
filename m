Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615F93043D7
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 22:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770417443; cv=none; b=abh3rsftdhl2/jr5YDytNDN6fLXxHIga4bhppeI2uLthkrSofLJl+4y1pKvE33RPJ4nGiopUgvpriYK3Q2Xn66qvlWhijTHcQLSgCA8VXaqJb1RhLUE6XCY8D5MfsEmIUxHDBOpLXaYTklzCJloqCfZpz3c2ZcMjoYYqipbLLh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770417443; c=relaxed/simple;
	bh=4hAVxyoh9ayhI2WFjONOmSo5xwgv+ccNEPRmyPLH4C4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LmFUjX6j62nq+y0cff+IXEq0qTf/Cu7gLmfQrHofPQ42e17w06XBkxdbcvBmNlne6WY9TykVxL5WpALvGRG65oYzcEhnFzgKMFcJIFBBVBorocVKwxNm+REZm868ypm+o7d2XYK7afbXRvUNlviC6+vo3+k5LDZO8krghYrmhcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLMwq37Z; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLMwq37Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770417442; x=1801953442;
  h=date:from:to:cc:subject:message-id;
  bh=4hAVxyoh9ayhI2WFjONOmSo5xwgv+ccNEPRmyPLH4C4=;
  b=gLMwq37ZEXh26KEmANWLBcu1dXmTcNNiQYPAULSCOUE5RoAZ1cwbHnk7
   JKUG8XtXwm79FjkztSL38Ix/TU5MjC3f9VkphtAjwD3K0xlvoIFm23ymX
   q2sTIAMzf6svCpe2kw1P/xskdLIoSn6WDR7TeDIfBlXi4AcZ49eB4G4s3
   fzUQqXFREGiE9dfDqi+tmJ9w+FqNepMHKVp5tES9ggfZpHqAVA/NbuFbj
   MaumLUZ79lcaahl2Bh4Wtef3cGcUnYFi8bEjmxdu2/moUlAOtHtut74Ib
   U8YoCYGY8SiJkEBW2RLM25E0ikaeCx+4pyVvSMrW6OJCU9bvqOrPL/skc
   w==;
X-CSE-ConnectionGUID: ZvtKWRuVQtOL+dvxv/poCA==
X-CSE-MsgGUID: e36dHl6VTYCUgyYzN2UfFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="82999077"
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="82999077"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 14:37:21 -0800
X-CSE-ConnectionGUID: XKawq0BzQSuUl7zkZmR8pg==
X-CSE-MsgGUID: WvsfjlKpRsytOeNkensjDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="215509767"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 06 Feb 2026 14:37:20 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1voURy-00000000lEG-0JYB;
	Fri, 06 Feb 2026 22:37:18 +0000
Date: Sat, 07 Feb 2026 06:36:39 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:wip/2602-mani-acs-v2] BUILD SUCCESS
 51690fa2a5776423e7f583b8a6baf89e403d3d35
Message-ID: <202602070631.2cFmYwUV-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git wip/2602-mani-acs-v2
branch HEAD: 51690fa2a5776423e7f583b8a6baf89e403d3d35  PCI: Extend the pci_disable_broken_acs_cap() quirk for one more IDT switch

elapsed time: 1224m

configs tested: 293
configs skipped: 3

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
arc                              allyesconfig    gcc-15.2.0
arc                          axs101_defconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                        nsimosci_defconfig    gcc-15.2.0
arc                   randconfig-001-20260206    gcc-8.5.0
arc                   randconfig-001-20260207    gcc-8.5.0
arc                   randconfig-002-20260206    gcc-8.5.0
arc                   randconfig-002-20260207    gcc-8.5.0
arc                           tb10x_defconfig    gcc-15.2.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                       aspeed_g4_defconfig    gcc-15.2.0
arm                        clps711x_defconfig    clang-22
arm                     davinci_all_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                            dove_defconfig    gcc-15.2.0
arm                          exynos_defconfig    clang-22
arm                        keystone_defconfig    gcc-11.5.0
arm                         lpc18xx_defconfig    gcc-11.5.0
arm                         lpc18xx_defconfig    gcc-15.2.0
arm                       multi_v4t_defconfig    clang-22
arm                        multi_v5_defconfig    gcc-15.2.0
arm                        mvebu_v7_defconfig    clang-22
arm                   randconfig-001-20260206    gcc-8.5.0
arm                   randconfig-001-20260207    gcc-8.5.0
arm                   randconfig-002-20260206    gcc-8.5.0
arm                   randconfig-002-20260207    gcc-8.5.0
arm                   randconfig-003-20260206    gcc-8.5.0
arm                   randconfig-003-20260207    gcc-8.5.0
arm                   randconfig-004-20260206    gcc-8.5.0
arm                   randconfig-004-20260207    gcc-8.5.0
arm                         s5pv210_defconfig    gcc-15.2.0
arm                           sama5_defconfig    clang-22
arm                          sp7021_defconfig    clang-22
arm                         vf610m4_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260206    gcc-13.4.0
arm64                 randconfig-001-20260207    gcc-15.2.0
arm64                 randconfig-002-20260206    gcc-13.4.0
arm64                 randconfig-002-20260207    gcc-15.2.0
arm64                 randconfig-003-20260206    gcc-13.4.0
arm64                 randconfig-003-20260207    gcc-15.2.0
arm64                 randconfig-004-20260206    gcc-13.4.0
arm64                 randconfig-004-20260207    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260206    gcc-13.4.0
csky                  randconfig-001-20260207    gcc-15.2.0
csky                  randconfig-002-20260206    gcc-13.4.0
csky                  randconfig-002-20260207    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260206    clang-22
hexagon               randconfig-001-20260207    clang-22
hexagon               randconfig-002-20260206    clang-22
hexagon               randconfig-002-20260207    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260206    clang-20
i386        buildonly-randconfig-001-20260207    clang-20
i386        buildonly-randconfig-002-20260206    clang-20
i386        buildonly-randconfig-002-20260207    clang-20
i386        buildonly-randconfig-003-20260206    clang-20
i386        buildonly-randconfig-003-20260207    clang-20
i386        buildonly-randconfig-004-20260206    clang-20
i386        buildonly-randconfig-004-20260207    clang-20
i386        buildonly-randconfig-005-20260206    clang-20
i386        buildonly-randconfig-005-20260207    clang-20
i386        buildonly-randconfig-006-20260206    clang-20
i386        buildonly-randconfig-006-20260207    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260206    gcc-14
i386                  randconfig-001-20260207    clang-20
i386                  randconfig-002-20260206    gcc-14
i386                  randconfig-002-20260207    clang-20
i386                  randconfig-003-20260206    gcc-14
i386                  randconfig-003-20260207    clang-20
i386                  randconfig-004-20260206    gcc-14
i386                  randconfig-004-20260207    clang-20
i386                  randconfig-005-20260206    gcc-14
i386                  randconfig-005-20260207    clang-20
i386                  randconfig-006-20260206    gcc-14
i386                  randconfig-006-20260207    clang-20
i386                  randconfig-007-20260206    gcc-14
i386                  randconfig-007-20260207    clang-20
i386                  randconfig-011-20260206    clang-20
i386                  randconfig-012-20260206    clang-20
i386                  randconfig-013-20260206    clang-20
i386                  randconfig-014-20260206    clang-20
i386                  randconfig-015-20260206    clang-20
i386                  randconfig-016-20260206    clang-20
i386                  randconfig-017-20260206    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260206    clang-22
loongarch             randconfig-001-20260207    clang-22
loongarch             randconfig-002-20260206    clang-22
loongarch             randconfig-002-20260207    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                          amiga_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                          hp300_defconfig    gcc-15.2.0
m68k                           sun3_defconfig    gcc-11.5.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath25_defconfig    clang-22
mips                  decstation_64_defconfig    clang-22
mips                           gcw0_defconfig    clang-22
mips                           ip27_defconfig    gcc-15.2.0
mips                           ip32_defconfig    clang-22
mips                           ip32_defconfig    gcc-15.2.0
mips                      maltaaprp_defconfig    clang-22
mips                  maltasmvp_eva_defconfig    gcc-15.2.0
mips                          rb532_defconfig    clang-22
nios2                         3c120_defconfig    gcc-11.5.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260206    clang-22
nios2                 randconfig-001-20260207    clang-22
nios2                 randconfig-002-20260206    clang-22
nios2                 randconfig-002-20260207    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.2.0
openrisc                  or1klitex_defconfig    gcc-15.2.0
parisc                           alldefconfig    clang-22
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260206    gcc-8.5.0
parisc                randconfig-001-20260207    gcc-14.3.0
parisc                randconfig-002-20260206    gcc-8.5.0
parisc                randconfig-002-20260207    gcc-14.3.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                      arches_defconfig    gcc-15.2.0
powerpc                      chrp32_defconfig    clang-22
powerpc                    gamecube_defconfig    clang-22
powerpc                 mpc832x_rdb_defconfig    clang-22
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc                 mpc837x_rdb_defconfig    gcc-15.2.0
powerpc                     powernv_defconfig    gcc-15.2.0
powerpc                      ppc44x_defconfig    clang-22
powerpc                      ppc6xx_defconfig    gcc-11.5.0
powerpc               randconfig-001-20260206    gcc-8.5.0
powerpc               randconfig-001-20260207    gcc-14.3.0
powerpc               randconfig-002-20260206    gcc-8.5.0
powerpc               randconfig-002-20260207    gcc-14.3.0
powerpc                      tqm8xx_defconfig    gcc-11.5.0
powerpc                         wii_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260206    gcc-8.5.0
powerpc64             randconfig-001-20260207    gcc-14.3.0
powerpc64             randconfig-002-20260206    gcc-8.5.0
powerpc64             randconfig-002-20260207    gcc-14.3.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260206    clang-22
riscv                 randconfig-001-20260207    clang-18
riscv                 randconfig-002-20260206    clang-22
riscv                 randconfig-002-20260207    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260206    clang-22
s390                  randconfig-001-20260207    clang-18
s390                  randconfig-002-20260206    clang-22
s390                  randconfig-002-20260207    clang-18
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                             espt_defconfig    gcc-15.2.0
sh                    randconfig-001-20260206    clang-22
sh                    randconfig-001-20260207    clang-18
sh                    randconfig-002-20260206    clang-22
sh                    randconfig-002-20260207    clang-18
sh                      rts7751r2d1_defconfig    gcc-15.2.0
sh                           se7343_defconfig    gcc-15.2.0
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sh                        sh7763rdp_defconfig    gcc-15.2.0
sh                  sh7785lcr_32bit_defconfig    clang-22
sh                        sh7785lcr_defconfig    gcc-15.2.0
sh                            shmin_defconfig    gcc-15.2.0
sh                             shx3_defconfig    gcc-15.2.0
sh                              ul2_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260206    gcc-12.5.0
sparc                 randconfig-001-20260207    gcc-15.2.0
sparc                 randconfig-002-20260206    gcc-12.5.0
sparc                 randconfig-002-20260207    gcc-15.2.0
sparc64                          alldefconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260206    gcc-12.5.0
sparc64               randconfig-001-20260207    gcc-15.2.0
sparc64               randconfig-002-20260206    gcc-12.5.0
sparc64               randconfig-002-20260207    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260206    gcc-12.5.0
um                    randconfig-001-20260207    gcc-15.2.0
um                    randconfig-002-20260206    gcc-12.5.0
um                    randconfig-002-20260207    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260206    gcc-14
x86_64      buildonly-randconfig-001-20260207    gcc-14
x86_64      buildonly-randconfig-002-20260206    gcc-14
x86_64      buildonly-randconfig-002-20260207    gcc-14
x86_64      buildonly-randconfig-003-20260206    gcc-14
x86_64      buildonly-randconfig-003-20260207    gcc-14
x86_64      buildonly-randconfig-004-20260206    gcc-14
x86_64      buildonly-randconfig-004-20260207    gcc-14
x86_64      buildonly-randconfig-005-20260206    gcc-14
x86_64      buildonly-randconfig-005-20260207    gcc-14
x86_64      buildonly-randconfig-006-20260206    gcc-14
x86_64      buildonly-randconfig-006-20260207    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260206    gcc-14
x86_64                randconfig-001-20260207    clang-20
x86_64                randconfig-002-20260206    gcc-14
x86_64                randconfig-002-20260207    clang-20
x86_64                randconfig-003-20260206    gcc-14
x86_64                randconfig-003-20260207    clang-20
x86_64                randconfig-004-20260206    gcc-14
x86_64                randconfig-004-20260207    clang-20
x86_64                randconfig-005-20260206    gcc-14
x86_64                randconfig-005-20260207    clang-20
x86_64                randconfig-006-20260206    gcc-14
x86_64                randconfig-006-20260207    clang-20
x86_64                randconfig-011-20260206    gcc-14
x86_64                randconfig-012-20260206    gcc-14
x86_64                randconfig-013-20260206    gcc-14
x86_64                randconfig-014-20260206    gcc-14
x86_64                randconfig-015-20260206    gcc-14
x86_64                randconfig-016-20260206    gcc-14
x86_64                randconfig-071-20260206    gcc-14
x86_64                randconfig-072-20260206    gcc-14
x86_64                randconfig-073-20260206    gcc-14
x86_64                randconfig-074-20260206    gcc-14
x86_64                randconfig-075-20260206    gcc-14
x86_64                randconfig-076-20260206    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                  audio_kc705_defconfig    clang-22
xtensa                  nommu_kc705_defconfig    gcc-11.5.0
xtensa                randconfig-001-20260206    gcc-12.5.0
xtensa                randconfig-001-20260207    gcc-15.2.0
xtensa                randconfig-002-20260206    gcc-12.5.0
xtensa                randconfig-002-20260207    gcc-15.2.0
xtensa                    smp_lx200_defconfig    clang-22
xtensa                    smp_lx200_defconfig    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
