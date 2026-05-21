Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECC9346FA7
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779354635; cv=none; b=XRxMAR79dWkYZYuPlhLP/xKGkSBW7iUZSDJSpXI5xM5HmzqXhwM82qv6VCHfLqxJjQN9Tm9KS2K9V65cuGVulGyWILz0SP9J5nttJc1DT4thg6hnq7Zi/Z3kmAzpPKHyfmurahwm1iimhDHjeMXmjlVnb+eI3kIuj/yke5L7/5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779354635; c=relaxed/simple;
	bh=/ZHmwtRvZFKxc07vCBMBH4VZYdY64xRTDxLoAZ7NSuk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=if+DKBAgNZt3C3Hx7DrW9hCQNQemaONCPCBQlFH6Z7d7kCZ3ErDVARb2F3rHxcWsqbY4NENoManbznVuRhOtBJGfN6PzCfe5624QjYahmVpq1gxfZBTILekI9pKzLJq8KdZl/s8CBSdObvW1IiHWv3bsCwbtR74Au2mU4rkMkvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hfMttm04; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hfMttm04"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779354634; x=1810890634;
  h=date:from:to:cc:subject:message-id;
  bh=/ZHmwtRvZFKxc07vCBMBH4VZYdY64xRTDxLoAZ7NSuk=;
  b=hfMttm04vgmLrno/L68ozEp45dkhXh8qST07nZ0phFlCenCbLCjejvjV
   Vx3kXue0JY54cmadrxfRC3eUZ6iqebrOxd8V4qlNPKlS0srUEuul6c5XM
   KGyvAIQV+KPKA1kI1zWC4otJKS/7XSykH2skePSi0ZzIZHUU6GUX7aA8L
   O3b1R+++dk2oa1MWVJ5kzjRvgvBJcVcRlp+Fs3r4PTzqhQe2jwnShcrIf
   Ding3qYgmjXQAu2+N+qTQarcnuC7af6FNupVfoJI4joXwKSDXEsmA9gBc
   Ird2vYEDLEN3afahS0SFWwmdQqQwNo2sNxYMR9vEo9hfM1zHDXW9qk0nz
   g==;
X-CSE-ConnectionGUID: h2cupBqPQBG08ZVaZwiPuA==
X-CSE-MsgGUID: 9N1p5G4ZRSqAMWvB8bX38Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80323901"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="80323901"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 02:10:34 -0700
X-CSE-ConnectionGUID: 2pIfNtviRPGNL6QaTRGFEA==
X-CSE-MsgGUID: KE8q23X7TnWSaUy8wRKm6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="239620693"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 21 May 2026 02:10:32 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPzO1-000000004ip-0yQ7;
	Thu, 21 May 2026 09:08:39 +0000
Date: Thu, 21 May 2026 17:07:31 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 6b96e84b16c1e731a33d448badcdf557c201f867
Message-ID: <202605211723.YKVuVGqk-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 6b96e84b16c1e731a33d448badcdf557c201f867  Merge branch 'pci/misc'

elapsed time: 765m

configs tested: 212
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260521    gcc-8.5.0
arc                   randconfig-002-20260521    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                      footbridge_defconfig    clang-17
arm                   randconfig-001-20260521    gcc-8.5.0
arm                   randconfig-002-20260521    gcc-8.5.0
arm                   randconfig-003-20260521    gcc-8.5.0
arm                   randconfig-004-20260521    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260521    gcc-8.5.0
arm64                 randconfig-002-20260521    gcc-8.5.0
arm64                 randconfig-003-20260521    gcc-8.5.0
arm64                 randconfig-004-20260521    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260521    gcc-8.5.0
csky                  randconfig-002-20260521    gcc-8.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260521    gcc-11.5.0
hexagon               randconfig-002-20260521    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260521    clang-20
i386        buildonly-randconfig-002-20260521    clang-20
i386        buildonly-randconfig-003-20260521    clang-20
i386        buildonly-randconfig-004-20260521    clang-20
i386        buildonly-randconfig-005-20260521    clang-20
i386        buildonly-randconfig-006-20260521    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260521    clang-20
i386                  randconfig-002-20260521    clang-20
i386                  randconfig-003-20260521    clang-20
i386                  randconfig-004-20260521    clang-20
i386                  randconfig-005-20260521    clang-20
i386                  randconfig-006-20260521    clang-20
i386                  randconfig-007-20260521    clang-20
i386                  randconfig-011-20260521    gcc-14
i386                  randconfig-012-20260521    gcc-14
i386                  randconfig-013-20260521    gcc-14
i386                  randconfig-014-20260521    gcc-14
i386                  randconfig-015-20260521    gcc-14
i386                  randconfig-016-20260521    gcc-14
i386                  randconfig-017-20260521    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260521    gcc-11.5.0
loongarch             randconfig-002-20260521    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                         rt305x_defconfig    clang-23
nios2                         10m50_defconfig    gcc-11.5.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260521    gcc-11.5.0
nios2                 randconfig-002-20260521    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260521    gcc-12.5.0
parisc                randconfig-002-20260521    gcc-12.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      mgcoge_defconfig    clang-23
powerpc                 mpc837x_rdb_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260521    gcc-12.5.0
powerpc               randconfig-002-20260521    gcc-12.5.0
powerpc                    sam440ep_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260521    gcc-12.5.0
powerpc64             randconfig-002-20260521    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260521    gcc-15.2.0
riscv                 randconfig-002-20260521    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260521    gcc-15.2.0
s390                  randconfig-002-20260521    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260521    gcc-15.2.0
sh                    randconfig-002-20260521    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260521    gcc-8.5.0
sparc                 randconfig-002-20260521    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260521    gcc-8.5.0
sparc64               randconfig-002-20260521    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260521    gcc-8.5.0
um                    randconfig-002-20260521    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260521    clang-20
x86_64      buildonly-randconfig-002-20260521    clang-20
x86_64      buildonly-randconfig-003-20260521    clang-20
x86_64      buildonly-randconfig-004-20260521    clang-20
x86_64      buildonly-randconfig-005-20260521    clang-20
x86_64      buildonly-randconfig-006-20260521    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260521    clang-20
x86_64                randconfig-002-20260521    clang-20
x86_64                randconfig-003-20260521    clang-20
x86_64                randconfig-004-20260521    clang-20
x86_64                randconfig-005-20260521    clang-20
x86_64                randconfig-006-20260521    clang-20
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260521    gcc-14
x86_64                         randconfig-012    gcc-14
x86_64                randconfig-012-20260521    gcc-14
x86_64                         randconfig-013    gcc-14
x86_64                randconfig-013-20260521    gcc-14
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260521    gcc-14
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260521    gcc-14
x86_64                         randconfig-016    gcc-14
x86_64                randconfig-016-20260521    gcc-14
x86_64                         randconfig-071    clang-20
x86_64                randconfig-071-20260521    clang-20
x86_64                         randconfig-072    clang-20
x86_64                randconfig-072-20260521    clang-20
x86_64                         randconfig-073    clang-20
x86_64                randconfig-073-20260521    clang-20
x86_64                         randconfig-074    clang-20
x86_64                randconfig-074-20260521    clang-20
x86_64                         randconfig-075    clang-20
x86_64                randconfig-075-20260521    clang-20
x86_64                         randconfig-076    clang-20
x86_64                randconfig-076-20260521    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260521    gcc-8.5.0
xtensa                randconfig-002-20260521    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
