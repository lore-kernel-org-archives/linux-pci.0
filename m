Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A12F2571D7
	for <linux-pci@vger.kernel.org>; Sat,  9 May 2026 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778340521; cv=none; b=RQ18rHK5nm2APjOHEHr7RHsUlq1IUlBFJMbJkeWy6h+ZD/IvYY+DLznIj9wo0yxG87gy/+w4N0giDaMAhv7+Y516itpaFG6wU2KAVMBGYUQGvjuklpk+BC8Kl8/1eyrgG4/diK/bwQCe8NBEynLggUd22uAXdWyhb8PF19Vph08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778340521; c=relaxed/simple;
	bh=XdCZ9SGcGPlYT1PJHxu4Bl5ibKGRNV5mkotAWo4Rlac=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bacxuh09CHV70vj2ePQ71LDRJ2deOWWo81UB+zcVzkS8GAsbo5mdMoJwcvjxA2ALeRNBLjXoE/LqfbbQH8cryQuB4/RP+3eB0saBkOiYkB6SJ2q3VdvnGKiG2/nWNGOMLRPguYvpD1y1STKOqwj+30CssWEnR79kVQCBig0d3QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7nAQxXw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7nAQxXw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778340518; x=1809876518;
  h=date:from:to:cc:subject:message-id;
  bh=XdCZ9SGcGPlYT1PJHxu4Bl5ibKGRNV5mkotAWo4Rlac=;
  b=a7nAQxXwC1IjnS5Y/EAoN5TIZWNsMnBHtqaq5xMRgQwYnJyFWeUibDkI
   BxBO4ehsjfzC4aeF2csAmbzjXuszZZJ3jLWmJakRU/ZNyJx7+npCqb/uX
   4Top3RP54Ksup02ZmuOBH+dym51MoAdSaR2x8z7mbCZuOXdSAv6btu90I
   Szp6OW+NxL91Mp3ujBVqw4H7i8vyL9Z/vs4WUpj+g6iF2PgL61VLrsAoL
   D/Z4aK4HWCGa4wbE1pnoEwSRviOKQjHbdFHRW3vixj/OkkwrrIMwLnGdQ
   0tRTfTgM+oO7/INEGpORPK0nhEJB9Aghm7cJQaox0aBNm47LKhydJ96WW
   w==;
X-CSE-ConnectionGUID: XMwDDzTSQEKUOtB3n6kxdA==
X-CSE-MsgGUID: bpVig24ITDqjTtRCKHgOeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="79478451"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="79478451"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 08:28:37 -0700
X-CSE-ConnectionGUID: +VWgyT+6RWmFm9odyf2uqg==
X-CSE-MsgGUID: +CTgdLROTpaLxBDwzP2Y+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="236972594"
Received: from lkp-server01.sh.intel.com (HELO 82327192134e) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 09 May 2026 08:28:36 -0700
Received: from kbuild by 82327192134e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wLjbV-0000000017H-3IES;
	Sat, 09 May 2026 15:28:33 +0000
Date: Sat, 09 May 2026 23:27:44 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:rom] BUILD SUCCESS
 538796b807fcfb81b2ce40cc97a614fd8588feb5
Message-ID: <202605092338.wYpHJaYW-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git rom
branch HEAD: 538796b807fcfb81b2ce40cc97a614fd8588feb5  PCI: Check ROM header and data structure addr before accessing

elapsed time: 762m

configs tested: 264
configs skipped: 59

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
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260509    gcc-8.5.0
arc                   randconfig-001-20260509    gcc-9.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260509    gcc-8.5.0
arc                   randconfig-002-20260509    gcc-9.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260509    gcc-8.5.0
arm                   randconfig-001-20260509    gcc-9.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260509    gcc-8.5.0
arm                   randconfig-002-20260509    gcc-9.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260509    gcc-8.5.0
arm                   randconfig-003-20260509    gcc-9.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260509    gcc-8.5.0
arm                   randconfig-004-20260509    gcc-9.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260509    gcc-10.5.0
arm64                 randconfig-002-20260509    gcc-10.5.0
arm64                 randconfig-003-20260509    gcc-10.5.0
arm64                 randconfig-004-20260509    gcc-10.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260509    gcc-10.5.0
csky                  randconfig-002-20260509    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260509    clang-17
hexagon               randconfig-001-20260509    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260509    clang-17
hexagon               randconfig-002-20260509    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260509    gcc-14
i386        buildonly-randconfig-002-20260509    gcc-14
i386        buildonly-randconfig-003-20260509    gcc-14
i386        buildonly-randconfig-004-20260509    gcc-14
i386        buildonly-randconfig-005-20260509    gcc-14
i386        buildonly-randconfig-006-20260509    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260509    clang-20
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260509    clang-20
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260509    clang-20
i386                  randconfig-004-20260509    clang-20
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260509    clang-20
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260509    clang-20
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260509    clang-20
i386                  randconfig-007-20260509    gcc-14
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260509    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260509    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260509    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260509    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260509    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260509    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260509    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260509    clang-17
loongarch             randconfig-001-20260509    gcc-11.5.0
loongarch             randconfig-001-20260509    gcc-15.2.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260509    clang-17
loongarch             randconfig-002-20260509    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                        m5407c3_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          eyeq5_defconfig    gcc-15.2.0
mips                           ip32_defconfig    clang-23
mips                    maltaup_xpa_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260509    clang-17
nios2                 randconfig-001-20260509    gcc-11.5.0
nios2                 randconfig-001-20260509    gcc-15.2.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260509    clang-17
nios2                 randconfig-002-20260509    gcc-11.5.0
nios2                 randconfig-002-20260509    gcc-15.2.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-11.5.0
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-11.5.0
parisc                randconfig-001-20260509    gcc-11.5.0
parisc                         randconfig-002    gcc-11.5.0
parisc                randconfig-002-20260509    gcc-11.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                       eiger_defconfig    clang-23
powerpc                      ppc64e_defconfig    gcc-15.2.0
powerpc                        randconfig-001    gcc-11.5.0
powerpc               randconfig-001-20260509    gcc-11.5.0
powerpc                        randconfig-002    gcc-11.5.0
powerpc               randconfig-002-20260509    gcc-11.5.0
powerpc64                      randconfig-001    gcc-11.5.0
powerpc64             randconfig-001-20260509    gcc-11.5.0
powerpc64                      randconfig-002    gcc-11.5.0
powerpc64             randconfig-002-20260509    gcc-11.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260509    clang-23
riscv                 randconfig-002-20260509    clang-23
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260509    clang-23
s390                  randconfig-002-20260509    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                        dreamcast_defconfig    gcc-15.2.0
sh                    randconfig-001-20260509    clang-23
sh                    randconfig-002-20260509    clang-23
sh                             shx3_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    clang-23
sparc                 randconfig-001-20260509    clang-23
sparc                          randconfig-002    clang-23
sparc                 randconfig-002-20260509    clang-23
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    clang-23
sparc64               randconfig-001-20260509    clang-23
sparc64                        randconfig-002    clang-23
sparc64               randconfig-002-20260509    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    clang-23
um                    randconfig-001-20260509    clang-23
um                             randconfig-002    clang-23
um                    randconfig-002-20260509    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260509    clang-20
x86_64      buildonly-randconfig-002-20260509    clang-20
x86_64      buildonly-randconfig-003-20260509    clang-20
x86_64      buildonly-randconfig-004-20260509    clang-20
x86_64      buildonly-randconfig-005-20260509    clang-20
x86_64      buildonly-randconfig-006-20260509    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                         randconfig-001    clang-20
x86_64                         randconfig-001    gcc-14
x86_64                randconfig-001-20260509    clang-20
x86_64                randconfig-001-20260509    gcc-14
x86_64                         randconfig-002    clang-20
x86_64                         randconfig-002    gcc-14
x86_64                randconfig-002-20260509    clang-20
x86_64                randconfig-002-20260509    gcc-14
x86_64                         randconfig-003    clang-20
x86_64                randconfig-003-20260509    clang-20
x86_64                randconfig-003-20260509    gcc-14
x86_64                         randconfig-004    clang-20
x86_64                randconfig-004-20260509    clang-20
x86_64                randconfig-004-20260509    gcc-14
x86_64                         randconfig-005    clang-20
x86_64                         randconfig-005    gcc-14
x86_64                randconfig-005-20260509    clang-20
x86_64                randconfig-005-20260509    gcc-14
x86_64                         randconfig-006    clang-20
x86_64                randconfig-006-20260509    clang-20
x86_64                randconfig-006-20260509    gcc-14
x86_64                randconfig-011-20260509    gcc-14
x86_64                randconfig-012-20260509    gcc-14
x86_64                randconfig-013-20260509    gcc-14
x86_64                randconfig-014-20260509    gcc-14
x86_64                randconfig-015-20260509    gcc-14
x86_64                randconfig-016-20260509    gcc-14
x86_64                randconfig-071-20260509    clang-20
x86_64                randconfig-071-20260509    gcc-14
x86_64                randconfig-072-20260509    clang-20
x86_64                randconfig-072-20260509    gcc-14
x86_64                randconfig-073-20260509    clang-20
x86_64                randconfig-074-20260509    clang-20
x86_64                randconfig-075-20260509    clang-20
x86_64                randconfig-076-20260509    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-11.5.0
xtensa                         randconfig-001    clang-23
xtensa                randconfig-001-20260509    clang-23
xtensa                         randconfig-002    clang-23
xtensa                randconfig-002-20260509    clang-23

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
