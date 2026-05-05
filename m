Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA923D332E
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778011355; cv=none; b=Lp4nEm7wAaPqSQ9pycWjjklJ35MeUwoMTyOkLl4bPO/+ZbAjA4aWSBJmiX+1IqEJPM5RQAghI+Yop/IKrSfGp/7Jgr/fLmGK7MwpShrR87YIxFjnemZz7NaXpLBPpeg43jI+8QHTHu2/Z6QYDi5jAq72UDiDlnnZ9HpWPw8StL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778011355; c=relaxed/simple;
	bh=WsLj4AqffpEleYaJBEm2RxsuhleciIDLwIr9Aw9ag+4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=swX9W80Pt4jWASwyknFTQnk2ZYCBoyUWxY8l+ST1th/9SMBPu8rQ4fOkLEXLfyPUqQ+6cRs6ltYb/3O43xguTmp2W+/LURB8Mf6t6hJdwWHxjhkBv5dNfHw/4W9GMSa2/qMpjY+iYSaHmtvIlQyeTjrp0isZg6u73Q2EGQKl3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DEgISslV; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DEgISslV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778011351; x=1809547351;
  h=date:from:to:cc:subject:message-id;
  bh=WsLj4AqffpEleYaJBEm2RxsuhleciIDLwIr9Aw9ag+4=;
  b=DEgISslVvbxRe76FYbNXNRCaJUmP1kw2CqDdjRgKOUgQ8/Tx0Q89dWHM
   IfU2oxv/usLjcbFl5y+d5i9fz4l7WaAR+HvE6e0psQj9aOLkZrAfx1ks+
   px/L/9pjqTwaIgS1QjUQmAINwV7PYEIsMplZfSDEQDM7Kli5ya2mLprQm
   vo7e68CJ0JgDcST0jLg9cxNXNu3jN4i7m5WT70R2aqyJjyCu7JWY6pwIc
   95NFXr72AHKOg+ZzO4lHG/9fUIw64lTehem5yOQK42jb1B1h40E97N3TL
   Ur+FEbxBx3FqOE3g56Jr6FuzmdDuYCz+XxelCkebQVn0F8PWhByuPHHjA
   Q==;
X-CSE-ConnectionGUID: bOHLpOvOQvCir3T0jKkGWw==
X-CSE-MsgGUID: axbT9o49QSqlrLtsYdFDDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78606918"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="78606918"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 13:02:31 -0700
X-CSE-ConnectionGUID: hVjOCDutS5yEuOCcK62mIw==
X-CSE-MsgGUID: BjzYlm0uTsGnMNzQEy3csw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="235776990"
Received: from lkp-server01.sh.intel.com (HELO 9ec114424ce8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 05 May 2026 13:02:30 -0700
Received: from kbuild by 9ec114424ce8 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wKLyN-000000000QJ-2173;
	Tue, 05 May 2026 20:02:27 +0000
Date: Wed, 06 May 2026 04:01:45 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 f5aa9712549104741ec9dfadd0fa680e8c24fde5
Message-ID: <202605060435.Jl6cfbUw-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: f5aa9712549104741ec9dfadd0fa680e8c24fde5  misc: pci_endpoint_test: remove dead BAR read before doorbell trigger

elapsed time: 1053m

configs tested: 312
configs skipped: 29

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
arc                   randconfig-001-20260505    gcc-8.5.0
arc                   randconfig-001-20260506    gcc-12.5.0
arc                   randconfig-002-20260505    gcc-8.5.0
arc                   randconfig-002-20260506    gcc-12.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                          exynos_defconfig    clang-23
arm                            mmp2_defconfig    gcc-15.2.0
arm                   randconfig-001-20260505    gcc-8.5.0
arm                   randconfig-001-20260506    gcc-12.5.0
arm                   randconfig-002-20260505    gcc-8.5.0
arm                   randconfig-002-20260506    gcc-12.5.0
arm                   randconfig-003-20260505    gcc-8.5.0
arm                   randconfig-003-20260506    gcc-12.5.0
arm                   randconfig-004-20260505    gcc-8.5.0
arm                   randconfig-004-20260506    gcc-12.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260505    gcc-14.3.0
arm64                 randconfig-001-20260506    gcc-15.2.0
arm64                 randconfig-002-20260505    gcc-14.3.0
arm64                 randconfig-002-20260506    gcc-15.2.0
arm64                 randconfig-003-20260505    gcc-14.3.0
arm64                 randconfig-003-20260506    gcc-15.2.0
arm64                 randconfig-004-20260505    gcc-14.3.0
arm64                 randconfig-004-20260506    gcc-15.2.0
csky                             alldefconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260505    gcc-14.3.0
csky                  randconfig-001-20260506    gcc-15.2.0
csky                  randconfig-002-20260505    gcc-14.3.0
csky                  randconfig-002-20260506    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260505    clang-23
hexagon               randconfig-001-20260505    gcc-11.5.0
hexagon               randconfig-001-20260506    clang-23
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260505    clang-23
hexagon               randconfig-002-20260505    gcc-11.5.0
hexagon               randconfig-002-20260506    clang-23
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260505    gcc-14
i386        buildonly-randconfig-001-20260506    clang-20
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260505    gcc-14
i386        buildonly-randconfig-002-20260506    clang-20
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260505    gcc-14
i386        buildonly-randconfig-003-20260506    clang-20
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260505    gcc-14
i386        buildonly-randconfig-004-20260506    clang-20
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260505    gcc-14
i386        buildonly-randconfig-005-20260506    clang-20
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260505    gcc-14
i386        buildonly-randconfig-006-20260506    clang-20
i386                                defconfig    gcc-15.2.0
i386                           randconfig-001    clang-20
i386                  randconfig-001-20260505    clang-20
i386                  randconfig-001-20260505    gcc-14
i386                  randconfig-001-20260506    gcc-14
i386                           randconfig-002    clang-20
i386                  randconfig-002-20260505    clang-20
i386                  randconfig-002-20260505    gcc-14
i386                  randconfig-002-20260506    gcc-14
i386                           randconfig-003    clang-20
i386                  randconfig-003-20260505    clang-20
i386                  randconfig-003-20260506    gcc-14
i386                           randconfig-004    clang-20
i386                  randconfig-004-20260505    clang-20
i386                  randconfig-004-20260505    gcc-14
i386                  randconfig-004-20260506    gcc-14
i386                           randconfig-005    clang-20
i386                  randconfig-005-20260505    clang-20
i386                  randconfig-005-20260506    gcc-14
i386                           randconfig-006    clang-20
i386                  randconfig-006-20260505    clang-20
i386                  randconfig-006-20260506    gcc-14
i386                           randconfig-007    clang-20
i386                  randconfig-007-20260505    clang-20
i386                  randconfig-007-20260505    gcc-14
i386                  randconfig-007-20260506    gcc-14
i386                  randconfig-011-20260505    clang-20
i386                  randconfig-011-20260506    clang-20
i386                  randconfig-012-20260505    clang-20
i386                  randconfig-012-20260506    clang-20
i386                  randconfig-013-20260505    clang-20
i386                  randconfig-013-20260506    clang-20
i386                  randconfig-014-20260505    clang-20
i386                  randconfig-014-20260506    clang-20
i386                  randconfig-015-20260505    clang-20
i386                  randconfig-015-20260506    clang-20
i386                  randconfig-016-20260505    clang-20
i386                  randconfig-016-20260506    clang-20
i386                  randconfig-017-20260505    clang-20
i386                  randconfig-017-20260506    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260505    clang-23
loongarch             randconfig-001-20260505    gcc-11.5.0
loongarch             randconfig-001-20260506    clang-23
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260505    clang-23
loongarch             randconfig-002-20260505    gcc-11.5.0
loongarch             randconfig-002-20260506    clang-23
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
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260505    clang-23
nios2                 randconfig-001-20260505    gcc-11.5.0
nios2                 randconfig-001-20260506    clang-23
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260505    clang-23
nios2                 randconfig-002-20260505    gcc-11.5.0
nios2                 randconfig-002-20260506    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc         de0_nano_multicore_defconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                generic-32bit_defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-14.3.0
parisc                randconfig-001-20260505    gcc-14.3.0
parisc                randconfig-001-20260506    gcc-13.4.0
parisc                         randconfig-002    gcc-14.3.0
parisc                randconfig-002-20260505    gcc-14.3.0
parisc                randconfig-002-20260506    gcc-13.4.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                        randconfig-001    gcc-14.3.0
powerpc               randconfig-001-20260505    gcc-14.3.0
powerpc               randconfig-001-20260506    gcc-13.4.0
powerpc                        randconfig-002    gcc-14.3.0
powerpc               randconfig-002-20260505    gcc-14.3.0
powerpc               randconfig-002-20260506    gcc-13.4.0
powerpc                     tqm8541_defconfig    clang-23
powerpc64                      randconfig-001    gcc-14.3.0
powerpc64             randconfig-001-20260505    gcc-14.3.0
powerpc64             randconfig-001-20260506    gcc-13.4.0
powerpc64                      randconfig-002    gcc-14.3.0
powerpc64             randconfig-002-20260505    gcc-14.3.0
powerpc64             randconfig-002-20260506    gcc-13.4.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260505    gcc-10.5.0
riscv                 randconfig-001-20260506    gcc-8.5.0
riscv                 randconfig-002-20260506    gcc-8.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260505    gcc-10.5.0
s390                  randconfig-001-20260506    gcc-8.5.0
s390                  randconfig-002-20260505    gcc-10.5.0
s390                  randconfig-002-20260506    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260505    gcc-10.5.0
sh                    randconfig-001-20260506    gcc-8.5.0
sh                    randconfig-002-20260505    gcc-10.5.0
sh                    randconfig-002-20260506    gcc-8.5.0
sh                          urquell_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-15.2.0
sparc                 randconfig-001-20260505    gcc-15.2.0
sparc                          randconfig-002    gcc-15.2.0
sparc                 randconfig-002-20260505    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-15.2.0
sparc64               randconfig-001-20260505    gcc-15.2.0
sparc64                        randconfig-002    gcc-15.2.0
sparc64               randconfig-002-20260505    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-15.2.0
um                    randconfig-001-20260505    gcc-15.2.0
um                             randconfig-002    gcc-15.2.0
um                    randconfig-002-20260505    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260505    clang-20
x86_64      buildonly-randconfig-001-20260506    clang-20
x86_64      buildonly-randconfig-002-20260505    clang-20
x86_64      buildonly-randconfig-002-20260506    clang-20
x86_64      buildonly-randconfig-003-20260505    clang-20
x86_64      buildonly-randconfig-003-20260505    gcc-14
x86_64      buildonly-randconfig-003-20260506    clang-20
x86_64      buildonly-randconfig-004-20260505    clang-20
x86_64      buildonly-randconfig-004-20260506    clang-20
x86_64      buildonly-randconfig-005-20260505    clang-20
x86_64      buildonly-randconfig-005-20260505    gcc-14
x86_64      buildonly-randconfig-005-20260506    clang-20
x86_64      buildonly-randconfig-006-20260505    clang-20
x86_64      buildonly-randconfig-006-20260505    gcc-14
x86_64      buildonly-randconfig-006-20260506    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260505    clang-20
x86_64                randconfig-001-20260506    clang-20
x86_64                randconfig-002-20260505    clang-20
x86_64                randconfig-002-20260506    clang-20
x86_64                randconfig-003-20260505    clang-20
x86_64                randconfig-003-20260506    clang-20
x86_64                randconfig-004-20260505    clang-20
x86_64                randconfig-004-20260506    clang-20
x86_64                randconfig-005-20260505    clang-20
x86_64                randconfig-005-20260506    clang-20
x86_64                randconfig-006-20260505    clang-20
x86_64                randconfig-006-20260506    clang-20
x86_64                         randconfig-011    clang-20
x86_64                randconfig-011-20260505    clang-20
x86_64                randconfig-011-20260506    clang-20
x86_64                         randconfig-012    clang-20
x86_64                randconfig-012-20260505    clang-20
x86_64                randconfig-012-20260506    clang-20
x86_64                         randconfig-013    clang-20
x86_64                randconfig-013-20260505    clang-20
x86_64                randconfig-013-20260506    clang-20
x86_64                         randconfig-014    clang-20
x86_64                randconfig-014-20260505    clang-20
x86_64                randconfig-014-20260506    clang-20
x86_64                         randconfig-015    clang-20
x86_64                randconfig-015-20260505    clang-20
x86_64                randconfig-015-20260506    clang-20
x86_64                         randconfig-016    clang-20
x86_64                randconfig-016-20260505    clang-20
x86_64                randconfig-016-20260506    clang-20
x86_64                         randconfig-071    clang-20
x86_64                randconfig-071-20260505    clang-20
x86_64                randconfig-071-20260505    gcc-14
x86_64                randconfig-071-20260506    clang-20
x86_64                         randconfig-072    clang-20
x86_64                randconfig-072-20260505    clang-20
x86_64                randconfig-072-20260506    clang-20
x86_64                         randconfig-073    clang-20
x86_64                randconfig-073-20260505    clang-20
x86_64                randconfig-073-20260505    gcc-14
x86_64                randconfig-073-20260506    clang-20
x86_64                         randconfig-074    clang-20
x86_64                randconfig-074-20260505    clang-20
x86_64                randconfig-074-20260505    gcc-14
x86_64                randconfig-074-20260506    clang-20
x86_64                         randconfig-075    clang-20
x86_64                randconfig-075-20260505    clang-20
x86_64                randconfig-075-20260506    clang-20
x86_64                         randconfig-076    clang-20
x86_64                randconfig-076-20260505    clang-20
x86_64                randconfig-076-20260506    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                         randconfig-001    gcc-15.2.0
xtensa                randconfig-001-20260505    gcc-15.2.0
xtensa                         randconfig-002    gcc-15.2.0
xtensa                randconfig-002-20260505    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
