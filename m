Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E7C4BC03C
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782929450; cv=none; b=i93ia+PMMFns6rmhVbmZjsyxDTQC7uUGrao19lfP6XHYvNRQe/TUlQIX4VB4+BZG4wuG8ouY5TgXhxwh1PMRAHeYPlXHxRCzcGP2LoSWCQX0Hj8tODgWkoq9Xe62s5nqoRGWumd1GkOfqOb9vwD1vhojB+GRp4HhWfBQPsjTC+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782929450; c=relaxed/simple;
	bh=4OOMxtc7W234TC7FjLRxJh1R5vTjBHJp8gbmFeFZkSI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EYqylIo+smj9VzKsoP/RzDri3jChluTBPlB8yXTmEQAR2K99mrZCyjyhyvZRUSU8TanzV6GooKIQ/JDai1t0MOlw8AOenASj29XkRmmwppAnKG5XrKvMLlS+b4yhT4sMRkR1YBDi6mHycQN3rZpAKGAdnMlEqDYvdVL5ob7FDkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JnLGpC29; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JnLGpC29"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782929449; x=1814465449;
  h=date:from:to:cc:subject:message-id;
  bh=4OOMxtc7W234TC7FjLRxJh1R5vTjBHJp8gbmFeFZkSI=;
  b=JnLGpC291k4mMsTO9oO0K8M00B3SNh8UlISDozMY7PWDefwDDlS6bC/1
   QbtQUf5s9OzmqGdlzvGmR2ZdO+P9wzKp2Ccy4L3Uym76kKq9NS6yF8qOp
   9gkrlBm7X9eK2UVrFgWsFzhg9jP+51YUAmJa019hOxoqwW8LpUWhr61EH
   z/A6n8ORryBQ+u5Az1K0kqq6NT1dB2dCDNLHR5hm333Z7Qb4C7EUQD4zD
   zaELnLRmzFleWFqTm5v/ABJH26rMwt3ANa8O+scS09MyEQ9Pqytdqdhta
   44OuzY+6Ik0Ect6eMwEqCSsElT6QHN4ufwLpOILyn5I8dh8u82gmdIkPC
   w==;
X-CSE-ConnectionGUID: ZPQN73Q5QjWK4MikFvUFxw==
X-CSE-MsgGUID: AcfXD2/oQXuhJ3Ng948WbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83725572"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="83725572"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 11:10:48 -0700
X-CSE-ConnectionGUID: KL/a/YJyT0+zJjbJ36/FkA==
X-CSE-MsgGUID: mjJgHQUqTQyzNNn8wiOsJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="256219895"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 01 Jul 2026 11:10:45 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wezOT-000000009XB-1U79;
	Wed, 01 Jul 2026 18:10:41 +0000
Date: Thu, 02 Jul 2026 02:10:01 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 8fb2ca9b9d3c82b8629c7331da6684bf269c60fb
Message-ID: <202607020251.K9pmd6Hq-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: 8fb2ca9b9d3c82b8629c7331da6684bf269c60fb  MAINTAINERS: Drop Karthikeyan Mitran from MOBIVEIL PCIE entry

elapsed time: 724m

configs tested: 307
configs skipped: 2

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
arc                         haps_hs_defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-16.1.0
arc                   randconfig-001-20260701    gcc-12.5.0
arc                   randconfig-001-20260701    gcc-16.1.0
arc                   randconfig-001-20260702    gcc-8.5.0
arc                            randconfig-002    gcc-16.1.0
arc                   randconfig-002-20260701    gcc-12.5.0
arc                   randconfig-002-20260701    gcc-16.1.0
arc                   randconfig-002-20260702    gcc-8.5.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                            randconfig-001    gcc-16.1.0
arm                   randconfig-001-20260701    gcc-12.5.0
arm                   randconfig-001-20260701    gcc-16.1.0
arm                   randconfig-001-20260702    gcc-8.5.0
arm                            randconfig-002    gcc-16.1.0
arm                   randconfig-002-20260701    gcc-12.5.0
arm                   randconfig-002-20260701    gcc-16.1.0
arm                   randconfig-002-20260702    gcc-8.5.0
arm                            randconfig-003    gcc-16.1.0
arm                   randconfig-003-20260701    gcc-12.5.0
arm                   randconfig-003-20260701    gcc-16.1.0
arm                   randconfig-003-20260702    gcc-8.5.0
arm                            randconfig-004    gcc-16.1.0
arm                   randconfig-004-20260701    gcc-12.5.0
arm                   randconfig-004-20260701    gcc-16.1.0
arm                   randconfig-004-20260702    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    gcc-12.5.0
arm64                 randconfig-001-20260701    gcc-12.5.0
arm64                          randconfig-002    gcc-12.5.0
arm64                 randconfig-002-20260701    gcc-12.5.0
arm64                          randconfig-003    gcc-12.5.0
arm64                 randconfig-003-20260701    gcc-12.5.0
arm64                          randconfig-004    gcc-12.5.0
arm64                 randconfig-004-20260701    gcc-12.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    gcc-12.5.0
csky                  randconfig-001-20260701    gcc-12.5.0
csky                           randconfig-002    gcc-12.5.0
csky                  randconfig-002-20260701    gcc-12.5.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260701    clang-23
hexagon               randconfig-001-20260701    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260701    clang-23
hexagon               randconfig-002-20260701    gcc-11.5.0
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260701    clang-22
i386        buildonly-randconfig-001-20260702    clang-22
i386        buildonly-randconfig-002-20260701    clang-22
i386        buildonly-randconfig-002-20260702    clang-22
i386        buildonly-randconfig-003-20260701    clang-22
i386        buildonly-randconfig-003-20260702    clang-22
i386        buildonly-randconfig-004-20260701    clang-22
i386        buildonly-randconfig-004-20260702    clang-22
i386        buildonly-randconfig-005-20260701    clang-22
i386        buildonly-randconfig-005-20260702    clang-22
i386        buildonly-randconfig-006-20260701    clang-22
i386        buildonly-randconfig-006-20260702    clang-22
i386                                defconfig    gcc-16.1.0
i386                           randconfig-001    clang-22
i386                  randconfig-001-20260701    clang-22
i386                           randconfig-002    clang-22
i386                  randconfig-002-20260701    clang-22
i386                           randconfig-003    clang-22
i386                  randconfig-003-20260701    clang-22
i386                           randconfig-004    clang-22
i386                  randconfig-004-20260701    clang-22
i386                           randconfig-005    clang-22
i386                  randconfig-005-20260701    clang-22
i386                           randconfig-006    clang-22
i386                  randconfig-006-20260701    clang-22
i386                           randconfig-007    clang-22
i386                  randconfig-007-20260701    clang-22
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260701    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260701    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260701    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260701    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260701    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260701    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260701    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260701    clang-23
loongarch             randconfig-001-20260701    gcc-11.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260701    clang-23
loongarch             randconfig-002-20260701    gcc-11.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                       m5329evb_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                        omega2p_defconfig    clang-17
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260701    clang-23
nios2                 randconfig-001-20260701    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260701    clang-23
nios2                 randconfig-002-20260701    gcc-11.5.0
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    clang-17
parisc                randconfig-001-20260701    clang-17
parisc                         randconfig-002    clang-17
parisc                randconfig-002-20260701    clang-17
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                     asp8347_defconfig    clang-23
powerpc                        randconfig-001    clang-17
powerpc               randconfig-001-20260701    clang-17
powerpc                        randconfig-002    clang-17
powerpc               randconfig-002-20260701    clang-17
powerpc                     redwood_defconfig    clang-23
powerpc64                      randconfig-001    clang-17
powerpc64             randconfig-001-20260701    clang-17
powerpc64                      randconfig-002    clang-17
powerpc64             randconfig-002-20260701    clang-17
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260701    clang-23
riscv                 randconfig-002-20260701    clang-23
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260701    clang-23
s390                  randconfig-002-20260701    clang-23
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260701    clang-23
sh                    randconfig-002-20260701    clang-23
sh                           se7206_defconfig    gcc-16.1.0
sh                           se7750_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-13.4.0
sparc                 randconfig-001-20260701    gcc-13.4.0
sparc                          randconfig-002    gcc-13.4.0
sparc                 randconfig-002-20260701    gcc-13.4.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-13.4.0
sparc64               randconfig-001-20260701    gcc-13.4.0
sparc64                        randconfig-002    gcc-13.4.0
sparc64               randconfig-002-20260701    gcc-13.4.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-13.4.0
um                    randconfig-001-20260701    gcc-13.4.0
um                             randconfig-002    gcc-13.4.0
um                    randconfig-002-20260701    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    clang-22
x86_64      buildonly-randconfig-001-20260701    clang-22
x86_64      buildonly-randconfig-001-20260702    clang-22
x86_64               buildonly-randconfig-002    clang-22
x86_64      buildonly-randconfig-002-20260701    clang-22
x86_64      buildonly-randconfig-002-20260702    clang-22
x86_64               buildonly-randconfig-003    clang-22
x86_64      buildonly-randconfig-003-20260701    clang-22
x86_64      buildonly-randconfig-003-20260702    clang-22
x86_64               buildonly-randconfig-004    clang-22
x86_64      buildonly-randconfig-004-20260701    clang-22
x86_64      buildonly-randconfig-004-20260702    clang-22
x86_64               buildonly-randconfig-005    clang-22
x86_64      buildonly-randconfig-005-20260701    clang-22
x86_64      buildonly-randconfig-005-20260702    clang-22
x86_64               buildonly-randconfig-006    clang-22
x86_64      buildonly-randconfig-006-20260701    clang-22
x86_64      buildonly-randconfig-006-20260702    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-001    clang-22
x86_64                randconfig-001-20260701    clang-22
x86_64                randconfig-001-20260701    gcc-14
x86_64                randconfig-001-20260702    clang-22
x86_64                         randconfig-002    clang-22
x86_64                randconfig-002-20260701    clang-22
x86_64                randconfig-002-20260701    gcc-14
x86_64                randconfig-002-20260702    clang-22
x86_64                         randconfig-003    clang-22
x86_64                randconfig-003-20260701    clang-22
x86_64                randconfig-003-20260701    gcc-14
x86_64                randconfig-003-20260702    clang-22
x86_64                         randconfig-004    clang-22
x86_64                randconfig-004-20260701    clang-22
x86_64                randconfig-004-20260701    gcc-14
x86_64                randconfig-004-20260702    clang-22
x86_64                         randconfig-005    clang-22
x86_64                randconfig-005-20260701    clang-22
x86_64                randconfig-005-20260701    gcc-14
x86_64                randconfig-005-20260702    clang-22
x86_64                         randconfig-006    clang-22
x86_64                randconfig-006-20260701    clang-22
x86_64                randconfig-006-20260701    gcc-14
x86_64                randconfig-006-20260702    clang-22
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260701    gcc-14
x86_64                         randconfig-012    gcc-14
x86_64                randconfig-012-20260701    gcc-14
x86_64                         randconfig-013    gcc-14
x86_64                randconfig-013-20260701    gcc-14
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260701    gcc-14
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260701    gcc-14
x86_64                         randconfig-016    gcc-14
x86_64                randconfig-016-20260701    gcc-14
x86_64                         randconfig-071    gcc-14
x86_64                randconfig-071-20260701    gcc-14
x86_64                         randconfig-072    gcc-14
x86_64                randconfig-072-20260701    gcc-14
x86_64                         randconfig-073    gcc-14
x86_64                randconfig-073-20260701    gcc-14
x86_64                         randconfig-074    gcc-14
x86_64                randconfig-074-20260701    gcc-14
x86_64                         randconfig-075    gcc-14
x86_64                randconfig-075-20260701    gcc-14
x86_64                         randconfig-076    gcc-14
x86_64                randconfig-076-20260701    gcc-14
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
xtensa                         randconfig-001    gcc-13.4.0
xtensa                randconfig-001-20260701    gcc-13.4.0
xtensa                         randconfig-002    gcc-13.4.0
xtensa                randconfig-002-20260701    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
