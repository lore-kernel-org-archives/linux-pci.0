Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29333347535
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781276876; cv=none; b=F1NDlIcCjG1l0oq6VBki5fgFzdQHm6VaBHL1COapaE4K1FMaSH09jY3mbpC1IsILXkiQ5S9OXko8K/e0CyMbBn3zxRNO3qjA1rr2caow/n22Hy7Ef7H4dyQh15WTtwMMKPbGPoYKf9EKrHRykH1G279K1Birsqh/TYLMxbR/QCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781276876; c=relaxed/simple;
	bh=Mrc07P0RGG3AeAE/7g1BBXm/9th4F28O5z022biKdeg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pcLezjiVNWz/quL3iNVx0sT8QUIzdkWnI1SuZoCv0aO+WATL1I84Ah2B7bi3R1AiaZq5/HrSfb9pnCzKCm4AJtJElHG4znI3rA3KYOdr0o78q1W7ddkBY8qd7+QlPnncQnI1Exd18P9Nc5w/Ift+prGFPq+1ZnoPsa8JMpBFnQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cYwzBxoc; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cYwzBxoc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781276873; x=1812812873;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Mrc07P0RGG3AeAE/7g1BBXm/9th4F28O5z022biKdeg=;
  b=cYwzBxoctOlwAawAP7ufABFcTzZGX5EQqzqVeBcK5C/87rj/s+Xn7KWa
   5sE46yvvxnJGuHws1b1yozMmMXUbbdgsyeqh2nrflCIFOfVfNuFYLWi49
   G1bShJak4BOzzmMUUZStoEGxAbe2Ymi7eAbrhQCYATqr7UQxB5DT0fn6V
   d0kJJVQomjbGiKKW3CK8fxZqvdFRE/C4BZNY6MYW576eR85DpNKS2hss7
   y7MkpdMvjcLz5exnUTyLdkF/XyXQ66VEI+9BUkHPIEv8uoaOnB5BzD4Fw
   U7mregsuPI7GQhblmUeHk5Fr+ZnAgXyGNeCffhBGewfH1ODtUPTL1WYnn
   Q==;
X-CSE-ConnectionGUID: 2e2nOi+NQTKmN3DT/pkkEQ==
X-CSE-MsgGUID: 88IB6D/9QoKoczc5d67M4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82169257"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="82169257"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 08:07:52 -0700
X-CSE-ConnectionGUID: mQv43arUT8SroDYP6rLo+g==
X-CSE-MsgGUID: KUK/qYRCTGydAVByprEoig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="245737715"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 12 Jun 2026 08:07:49 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wY3U3-00000000Ov1-2Zbx;
	Fri, 12 Jun 2026 15:07:47 +0000
Date: Fri, 12 Jun 2026 23:07:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:procfs] BUILD SUCCESS
 9ed4269f24b232922501bc9cffd45867284fb7f2
Message-ID: <202606122352.kBfxd5By-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git procfs
branch HEAD: 9ed4269f24b232922501bc9cffd45867284fb7f2  PCI/proc: Fix race between pci_proc_init() and pci_bus_add_device()

elapsed time: 798m

configs tested: 255
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                        nsim_700_defconfig    gcc-16.1.0
arc                   randconfig-001-20260612    gcc-13.4.0
arc                   randconfig-002-20260612    gcc-13.4.0
arc                   randconfig-002-20260612    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260612    gcc-11.5.0
arm                   randconfig-001-20260612    gcc-13.4.0
arm                   randconfig-002-20260612    gcc-10.5.0
arm                   randconfig-002-20260612    gcc-13.4.0
arm                   randconfig-003-20260612    gcc-11.5.0
arm                   randconfig-003-20260612    gcc-13.4.0
arm                   randconfig-004-20260612    gcc-13.4.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260612    gcc-13.4.0
arm64                 randconfig-002-20260612    clang-23
arm64                 randconfig-002-20260612    gcc-13.4.0
arm64                 randconfig-003-20260612    gcc-13.4.0
arm64                 randconfig-003-20260612    gcc-9.5.0
arm64                 randconfig-004-20260612    gcc-11.5.0
arm64                 randconfig-004-20260612    gcc-13.4.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260612    gcc-11.5.0
csky                  randconfig-001-20260612    gcc-13.4.0
csky                  randconfig-002-20260612    gcc-13.4.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    clang-23
hexagon               randconfig-001-20260612    clang-23
hexagon                        randconfig-002    clang-23
hexagon               randconfig-002-20260612    clang-23
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                                defconfig    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260612    clang-22
i386                  randconfig-001-20260612    gcc-14
i386                  randconfig-002-20260612    clang-22
i386                  randconfig-003-20260612    clang-22
i386                  randconfig-003-20260612    gcc-14
i386                  randconfig-004-20260612    clang-22
i386                  randconfig-004-20260612    gcc-14
i386                  randconfig-005-20260612    clang-22
i386                  randconfig-006-20260612    clang-22
i386                  randconfig-007-20260612    clang-22
i386                  randconfig-007-20260612    gcc-12
i386                           randconfig-011    clang-22
i386                  randconfig-011-20260612    clang-22
i386                           randconfig-012    clang-22
i386                  randconfig-012-20260612    clang-22
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260612    clang-22
i386                           randconfig-014    clang-22
i386                  randconfig-014-20260612    clang-22
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260612    clang-22
i386                  randconfig-015-20260612    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260612    clang-22
i386                  randconfig-016-20260612    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260612    clang-22
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    clang-23
loongarch             randconfig-001-20260612    clang-23
loongarch                      randconfig-002    gcc-16.1.0
loongarch             randconfig-002-20260612    gcc-16.1.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260612    gcc-11.5.0
nios2                          randconfig-002    gcc-8.5.0
nios2                 randconfig-002-20260612    gcc-11.5.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-23
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-8.5.0
parisc                randconfig-001-20260612    gcc-12.5.0
parisc                         randconfig-002    gcc-12.5.0
parisc                randconfig-002-20260612    gcc-14.3.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                      ppc64e_defconfig    gcc-16.1.0
powerpc                        randconfig-001    gcc-10.5.0
powerpc                        randconfig-002    gcc-8.5.0
powerpc64                      randconfig-001    clang-16
powerpc64             randconfig-001-20260612    gcc-8.5.0
powerpc64                      randconfig-002    clang-23
powerpc64             randconfig-002-20260612    gcc-11.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260612    gcc-11.5.0
riscv                 randconfig-001-20260612    gcc-13.4.0
riscv                 randconfig-002-20260612    clang-23
riscv                 randconfig-002-20260612    gcc-11.5.0
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260612    clang-23
s390                  randconfig-001-20260612    gcc-11.5.0
s390                  randconfig-002-20260612    gcc-11.5.0
s390                  randconfig-002-20260612    gcc-8.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-23
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-16.1.0
sh                    randconfig-001-20260612    gcc-11.5.0
sh                    randconfig-002-20260612    gcc-11.5.0
sh                    randconfig-002-20260612    gcc-13.4.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260612    gcc-8.5.0
sparc                 randconfig-002-20260612    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260612    gcc-8.5.0
sparc64               randconfig-002-20260612    gcc-8.5.0
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260612    gcc-8.5.0
um                    randconfig-002-20260612    gcc-8.5.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    gcc-14
x86_64      buildonly-randconfig-001-20260612    clang-22
x86_64      buildonly-randconfig-001-20260612    gcc-14
x86_64               buildonly-randconfig-002    gcc-14
x86_64      buildonly-randconfig-002-20260612    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260612    clang-22
x86_64      buildonly-randconfig-003-20260612    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260612    clang-22
x86_64      buildonly-randconfig-004-20260612    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260612    clang-22
x86_64      buildonly-randconfig-005-20260612    gcc-14
x86_64               buildonly-randconfig-006    gcc-14
x86_64      buildonly-randconfig-006-20260612    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260612    clang-22
x86_64                randconfig-002-20260612    clang-22
x86_64                randconfig-003-20260612    clang-22
x86_64                randconfig-004-20260612    clang-22
x86_64                randconfig-005-20260612    clang-22
x86_64                randconfig-006-20260612    clang-22
x86_64                randconfig-011-20260612    gcc-14
x86_64                randconfig-012-20260612    clang-22
x86_64                randconfig-013-20260612    clang-22
x86_64                randconfig-014-20260612    gcc-14
x86_64                randconfig-015-20260612    gcc-14
x86_64                randconfig-016-20260612    gcc-14
x86_64                         randconfig-071    gcc-14
x86_64                randconfig-071-20260612    gcc-14
x86_64                         randconfig-072    gcc-14
x86_64                randconfig-072-20260612    gcc-12
x86_64                randconfig-072-20260612    gcc-14
x86_64                         randconfig-073    clang-22
x86_64                randconfig-073-20260612    clang-22
x86_64                randconfig-073-20260612    gcc-14
x86_64                         randconfig-074    gcc-14
x86_64                randconfig-074-20260612    clang-22
x86_64                randconfig-074-20260612    gcc-14
x86_64                         randconfig-075    gcc-13
x86_64                randconfig-075-20260612    clang-22
x86_64                randconfig-075-20260612    gcc-14
x86_64                         randconfig-076    clang-22
x86_64                randconfig-076-20260612    clang-22
x86_64                randconfig-076-20260612    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260612    gcc-8.5.0
xtensa                randconfig-002-20260612    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
