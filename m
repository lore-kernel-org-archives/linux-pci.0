Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8276A48A2C7
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784129432; cv=none; b=f7ohc1eStWe5FP+R3VWwleR4+KL/XpJTHndmi9/O+1IeY6+LClnf9kSuHM2PyKo8QqCUJoUBJnTs72rX+VZEF1dKGQYPl3/zeymfMeVpAN/cz2POrXI/Hb3+AEmCGfPrcbDsbJdg+CMy2O4Dw86uXfKGYA8myDOe79d7Px8zB8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784129432; c=relaxed/simple;
	bh=/BZyiiSgGu566Au2HMYrJbk0DQbqzkYnZJ2aSPUE7ho=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QOMlyP2ei7XzUDar8cE2Cf1/CiYmizH4ngO0Ok/l15nElV6VGJRmluvoKyJPHQoggbrtprzPHC3Cisrojnz6p6Nh4fh4CPXr93WL6eICMcGT4PTriNxnUXMTyoBXuyDTweqM5rR8j9boNlQ+nesAU2XxljCI8CqvkKBGB8hCH7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VnKXqPeq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VnKXqPeq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784129430; x=1815665430;
  h=date:from:to:cc:subject:message-id;
  bh=/BZyiiSgGu566Au2HMYrJbk0DQbqzkYnZJ2aSPUE7ho=;
  b=VnKXqPeq9l1Fj+91RZjFnqBkRd0dNd94ff8Ln44Zd2KtVJsf7rGKWSAS
   BhTej4ivXYZ7//1DMcGYRBSsuqSz6ME45CmOc6y9QQBMrkEIpOj8YWlDB
   D9AWpVk742pG6QdTNDSeg9z98CFEq4wcVCbj6ZaYhHycNLu0hyM39IqaZ
   DE/uRGD5r0AC/W6KWkxbvEk3ibKBLlBewJZYcyBvNSb6YTcKVlEmXRCIZ
   Jp0xN6pidddUhlFUktDqvqrqvFWaEVjXC9TPyiFdnX/qjpaGcoXNSjwMH
   vW24j9DKJx6jV8Q0OEwUvYD4AhzAvrfmIWgki53Nv03BHCqFqHjqrxJw9
   w==;
X-CSE-ConnectionGUID: FX28xa/zRnum6QGy23xX/A==
X-CSE-MsgGUID: pnJ9+HOYSyuaE4sN7cc1eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95912907"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="95912907"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 08:30:28 -0700
X-CSE-ConnectionGUID: tS/25JPHSYiitxBAdBM2dw==
X-CSE-MsgGUID: ujkvqgEWSH2j1eZWo/ElWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="280646125"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 15 Jul 2026 08:30:26 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wk1Z2-00000000NmA-29RF;
	Wed, 15 Jul 2026 15:30:24 +0000
Date: Wed, 15 Jul 2026 23:29:45 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 e290be3134994f8b84c9d0026666d4f146131d86
Message-ID: <202607152331.ZJxFQQ0l-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: e290be3134994f8b84c9d0026666d4f146131d86  Documentation: PCI: Fix sysfs-bus-pci typo

elapsed time: 1280m

configs tested: 285
configs skipped: 15

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
arc                            randconfig-001    gcc-10.5.0
arc                   randconfig-001-20260715    gcc-10.5.0
arc                            randconfig-002    gcc-10.5.0
arc                   randconfig-002-20260715    gcc-10.5.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                         bcm2835_defconfig    clang-17
arm                                 defconfig    gcc-16.1.0
arm                             pxa_defconfig    gcc-16.1.0
arm                            randconfig-001    gcc-10.5.0
arm                   randconfig-001-20260715    gcc-10.5.0
arm                            randconfig-002    gcc-10.5.0
arm                   randconfig-002-20260715    gcc-10.5.0
arm                            randconfig-003    gcc-10.5.0
arm                   randconfig-003-20260715    gcc-10.5.0
arm                            randconfig-004    gcc-10.5.0
arm                   randconfig-004-20260715    gcc-10.5.0
arm                         socfpga_defconfig    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260715    clang-23
arm64                 randconfig-001-20260715    gcc-16.1.0
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260715    clang-23
arm64                 randconfig-002-20260715    gcc-16.1.0
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260715    gcc-16.1.0
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260715    clang-23
arm64                 randconfig-004-20260715    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260715    clang-23
csky                  randconfig-001-20260715    gcc-16.1.0
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260715    clang-23
csky                  randconfig-002-20260715    gcc-16.1.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260715    gcc-11.5.0
hexagon               randconfig-001-20260715    gcc-16.1.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260715    gcc-11.5.0
hexagon               randconfig-002-20260715    gcc-16.1.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                 buildonly-randconfig-001    clang-22
i386        buildonly-randconfig-001-20260715    clang-22
i386                 buildonly-randconfig-002    clang-22
i386        buildonly-randconfig-002-20260715    clang-22
i386                 buildonly-randconfig-003    clang-22
i386        buildonly-randconfig-003-20260715    clang-22
i386                 buildonly-randconfig-004    clang-22
i386        buildonly-randconfig-004-20260715    clang-22
i386                 buildonly-randconfig-005    clang-22
i386        buildonly-randconfig-005-20260715    clang-22
i386                 buildonly-randconfig-006    clang-22
i386        buildonly-randconfig-006-20260715    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260715    clang-22
i386                  randconfig-002-20260715    clang-22
i386                  randconfig-003-20260715    clang-22
i386                  randconfig-004-20260715    clang-22
i386                  randconfig-005-20260715    clang-22
i386                  randconfig-006-20260715    clang-22
i386                  randconfig-007-20260715    clang-22
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260715    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260715    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260715    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260715    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260715    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260715    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260715    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260715    gcc-11.5.0
loongarch             randconfig-001-20260715    gcc-16.1.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260715    gcc-11.5.0
loongarch             randconfig-002-20260715    gcc-16.1.0
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
mips                      maltaaprp_defconfig    clang-17
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260715    gcc-11.5.0
nios2                 randconfig-001-20260715    gcc-16.1.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260715    gcc-11.5.0
nios2                 randconfig-002-20260715    gcc-16.1.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    clang-23
parisc                randconfig-001-20260715    clang-23
parisc                         randconfig-002    clang-23
parisc                randconfig-002-20260715    clang-23
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                 linkstation_defconfig    clang-23
powerpc                        randconfig-001    clang-23
powerpc               randconfig-001-20260715    clang-23
powerpc                        randconfig-002    clang-23
powerpc               randconfig-002-20260715    clang-23
powerpc64                      randconfig-001    clang-23
powerpc64             randconfig-001-20260715    clang-23
powerpc64                      randconfig-002    clang-23
powerpc64             randconfig-002-20260715    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-15.2.0
riscv                 randconfig-001-20260715    gcc-15.2.0
riscv                          randconfig-002    gcc-15.2.0
riscv                 randconfig-002-20260715    gcc-15.2.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-15.2.0
s390                  randconfig-001-20260715    gcc-15.2.0
s390                           randconfig-002    gcc-15.2.0
s390                  randconfig-002-20260715    gcc-15.2.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-15.2.0
sh                    randconfig-001-20260715    gcc-15.2.0
sh                             randconfig-002    gcc-15.2.0
sh                    randconfig-002-20260715    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-16.1.0
sparc                 randconfig-001-20260715    gcc-16.1.0
sparc                          randconfig-002    gcc-16.1.0
sparc                 randconfig-002-20260715    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-16.1.0
sparc64               randconfig-001-20260715    gcc-16.1.0
sparc64                        randconfig-002    gcc-16.1.0
sparc64               randconfig-002-20260715    gcc-16.1.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-16.1.0
um                    randconfig-001-20260715    gcc-16.1.0
um                             randconfig-002    gcc-16.1.0
um                    randconfig-002-20260715    gcc-16.1.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    gcc-14
x86_64      buildonly-randconfig-001-20260715    gcc-14
x86_64               buildonly-randconfig-002    gcc-14
x86_64      buildonly-randconfig-002-20260715    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260715    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260715    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260715    gcc-14
x86_64               buildonly-randconfig-006    gcc-14
x86_64      buildonly-randconfig-006-20260715    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260715    clang-22
x86_64                randconfig-002-20260715    clang-22
x86_64                randconfig-003-20260715    clang-22
x86_64                randconfig-004-20260715    clang-22
x86_64                randconfig-004-20260715    gcc-14
x86_64                randconfig-005-20260715    clang-22
x86_64                randconfig-006-20260715    clang-22
x86_64                randconfig-006-20260715    gcc-14
x86_64                         randconfig-011    clang-22
x86_64                randconfig-011-20260715    clang-22
x86_64                         randconfig-012    clang-22
x86_64                randconfig-012-20260715    clang-22
x86_64                         randconfig-013    clang-22
x86_64                randconfig-013-20260715    clang-22
x86_64                         randconfig-014    clang-22
x86_64                randconfig-014-20260715    clang-22
x86_64                         randconfig-015    clang-22
x86_64                randconfig-015-20260715    clang-22
x86_64                         randconfig-016    clang-22
x86_64                randconfig-016-20260715    clang-22
x86_64                         randconfig-071    gcc-14
x86_64                randconfig-071-20260715    gcc-14
x86_64                         randconfig-072    gcc-14
x86_64                randconfig-072-20260715    gcc-14
x86_64                         randconfig-073    gcc-14
x86_64                randconfig-073-20260715    gcc-14
x86_64                         randconfig-074    gcc-14
x86_64                randconfig-074-20260715    gcc-14
x86_64                         randconfig-075    gcc-14
x86_64                randconfig-075-20260715    gcc-14
x86_64                         randconfig-076    gcc-14
x86_64                randconfig-076-20260715    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                               rhel-9.4    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                          rhel-9.4-func    gcc-14
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                    rhel-9.4-kselftests    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0
xtensa                generic_kc705_defconfig    gcc-16.1.0
xtensa                          iss_defconfig    gcc-16.1.0
xtensa                         randconfig-001    gcc-16.1.0
xtensa                randconfig-001-20260715    gcc-16.1.0
xtensa                         randconfig-002    gcc-16.1.0
xtensa                randconfig-002-20260715    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
