Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A373AFCEF
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203196; cv=none; b=YcC2m3KVZb+vCs4ILgDcduM/vY+3taqfwOSN5WozFigvyqKzMo7lA01789M7nnwvm+548pRfPgJXof5PdlNVbB6pmg9ZfSfzkmDOCTC/uyeNic4nziB4wQSZBHugMmo55qbu/42LwrU1r4Zh1+/uAplal8lOyB3cYKh7yWcROf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203196; c=relaxed/simple;
	bh=4iRGnq24gu2dObEwLFwLMxZ7GHsPekDAjYXglgexG4s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uOvOtS/K7jnvBYURoIYEDPQBthWlXKDw21OiNrbBFWOlVDONGVByxca3EmkMM4SMIxzQhibqbMEw00wRGi+UGQDzz0ehzo3OI3n+CKUIPsSI6mIqhYaQeSBYAyDcXAr779BhjEV1NFuyo0e2rC3kGdSyHT4KY5mttZg0n4GhD3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RdcY8nFT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RdcY8nFT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779203194; x=1810739194;
  h=date:from:to:cc:subject:message-id;
  bh=4iRGnq24gu2dObEwLFwLMxZ7GHsPekDAjYXglgexG4s=;
  b=RdcY8nFT3YXNuP166+qtplI+ihZ423yh19WLmpofvgumMMd9f4lR90ln
   R8moFB8fC+/Kd2r9jGWfxS9wENNSUM0i3kjix+jE1acoy1b1iBu0d0gq+
   2WoU/rfYGSuwgcj0HKCNm+B77KsNe2PxS4jCqSN9mErbRhdGdB3WeX9If
   MuJz3A4RwZHyocssThSGVRSNlFGs5uzFDysIYdE7aD59isOVDIG0XG6Ts
   nMrUvnLMl+p++DO2U4xhEXjGV3nJH7gxBGokGMqfs6BQ1QW5t6jaPhyOW
   5ds2fqDfW2aEBkKA8/W49KkSsKL4YrJULRZRcr7rY9eL3a17dy/FzIW+V
   w==;
X-CSE-ConnectionGUID: ZVcZUZ4vS2eKl0dbyjusDQ==
X-CSE-MsgGUID: CAZf0lIeSIexiYZ4EuFCGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="105543312"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="105543312"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 08:06:33 -0700
X-CSE-ConnectionGUID: ECTeYB+kSvKkXU8g5tQVDQ==
X-CSE-MsgGUID: +bw51c4rTEeJW1KaAjkk/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="277905708"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 19 May 2026 08:06:32 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPM1d-000000001Eo-1bXv;
	Tue, 19 May 2026 15:06:29 +0000
Date: Tue, 19 May 2026 23:04:15 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-imx6] BUILD SUCCESS
 250eea5c06f5291603612cdf0c60326db4e19141
Message-ID: <202605192306.rUKd1gho-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-imx6
branch HEAD: 250eea5c06f5291603612cdf0c60326db4e19141  PCI: imx6: Parse 'reset-gpios' in Root Port nodes

elapsed time: 943m

configs tested: 267
configs skipped: 4

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
arc                   randconfig-001-20260519    clang-23
arc                   randconfig-001-20260519    gcc-8.5.0
arc                   randconfig-001-20260519    gcc-9.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260519    clang-23
arc                   randconfig-002-20260519    gcc-10.5.0
arc                   randconfig-002-20260519    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                        clps711x_defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                       multi_v4t_defconfig    clang-16
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260519    clang-23
arm                   randconfig-001-20260519    gcc-8.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260519    clang-23
arm                   randconfig-002-20260519    gcc-8.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260519    clang-23
arm                   randconfig-003-20260519    gcc-8.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260519    clang-23
arm                   randconfig-004-20260519    gcc-8.5.0
arm                       spear13xx_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260519    gcc-8.5.0
arm64                 randconfig-002-20260519    gcc-8.5.0
arm64                 randconfig-003-20260519    gcc-8.5.0
arm64                 randconfig-004-20260519    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260519    gcc-8.5.0
csky                  randconfig-002-20260519    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260519    clang-23
hexagon               randconfig-001-20260519    gcc-10.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260519    clang-23
hexagon               randconfig-002-20260519    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260519    gcc-12
i386        buildonly-randconfig-002-20260519    gcc-12
i386        buildonly-randconfig-003-20260519    gcc-12
i386        buildonly-randconfig-004-20260519    gcc-12
i386        buildonly-randconfig-005-20260519    gcc-12
i386        buildonly-randconfig-006-20260519    gcc-12
i386                                defconfig    gcc-15.2.0
i386                           randconfig-001    gcc-14
i386                  randconfig-001-20260519    gcc-14
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260519    gcc-14
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260519    gcc-14
i386                           randconfig-004    gcc-14
i386                  randconfig-004-20260519    gcc-14
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260519    gcc-14
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260519    gcc-14
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260519    gcc-14
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260519    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260519    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260519    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260519    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260519    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260519    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260519    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260519    clang-18
loongarch             randconfig-001-20260519    gcc-10.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260519    gcc-10.5.0
loongarch             randconfig-002-20260519    gcc-15.2.0
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
mips                     cu1000-neo_defconfig    gcc-15.2.0
nios2                         10m50_defconfig    gcc-11.5.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260519    gcc-10.5.0
nios2                 randconfig-001-20260519    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260519    gcc-10.5.0
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
parisc                         randconfig-001    gcc-8.5.0
parisc                randconfig-001-20260519    gcc-8.5.0
parisc                         randconfig-002    gcc-8.5.0
parisc                randconfig-002-20260519    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                        randconfig-001    gcc-8.5.0
powerpc               randconfig-001-20260519    gcc-8.5.0
powerpc                        randconfig-002    gcc-8.5.0
powerpc               randconfig-002-20260519    gcc-8.5.0
powerpc64                      randconfig-001    gcc-8.5.0
powerpc64             randconfig-001-20260519    gcc-8.5.0
powerpc64                      randconfig-002    gcc-8.5.0
powerpc64             randconfig-002-20260519    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                          randconfig-001    gcc-13.4.0
riscv                 randconfig-001-20260519    gcc-13.4.0
riscv                          randconfig-002    gcc-13.4.0
riscv                 randconfig-002-20260519    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                           randconfig-001    gcc-13.4.0
s390                  randconfig-001-20260519    gcc-13.4.0
s390                           randconfig-002    gcc-13.4.0
s390                  randconfig-002-20260519    gcc-13.4.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                          landisk_defconfig    gcc-15.2.0
sh                             randconfig-001    gcc-13.4.0
sh                    randconfig-001-20260519    gcc-13.4.0
sh                             randconfig-002    gcc-13.4.0
sh                    randconfig-002-20260519    gcc-13.4.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-14.3.0
sparc                 randconfig-001-20260519    gcc-14.3.0
sparc                          randconfig-002    gcc-14.3.0
sparc                 randconfig-002-20260519    gcc-14.3.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-14.3.0
sparc64               randconfig-001-20260519    gcc-14.3.0
sparc64                        randconfig-002    gcc-14.3.0
sparc64               randconfig-002-20260519    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-14.3.0
um                    randconfig-001-20260519    gcc-14.3.0
um                             randconfig-002    gcc-14.3.0
um                    randconfig-002-20260519    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260519    gcc-14
x86_64      buildonly-randconfig-002-20260519    gcc-14
x86_64      buildonly-randconfig-003-20260519    gcc-14
x86_64      buildonly-randconfig-004-20260519    gcc-14
x86_64      buildonly-randconfig-005-20260519    gcc-14
x86_64      buildonly-randconfig-006-20260519    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260519    clang-20
x86_64                randconfig-002-20260519    clang-20
x86_64                randconfig-003-20260519    clang-20
x86_64                randconfig-004-20260519    clang-20
x86_64                randconfig-005-20260519    clang-20
x86_64                randconfig-006-20260519    clang-20
x86_64                         randconfig-011    clang-20
x86_64                randconfig-011-20260519    clang-20
x86_64                         randconfig-012    clang-20
x86_64                randconfig-012-20260519    clang-20
x86_64                         randconfig-013    clang-20
x86_64                randconfig-013-20260519    clang-20
x86_64                         randconfig-014    clang-20
x86_64                randconfig-014-20260519    clang-20
x86_64                         randconfig-015    clang-20
x86_64                randconfig-015-20260519    clang-20
x86_64                         randconfig-016    clang-20
x86_64                randconfig-016-20260519    clang-20
x86_64                randconfig-071-20260519    gcc-14
x86_64                randconfig-072-20260519    gcc-14
x86_64                randconfig-073-20260519    gcc-14
x86_64                randconfig-074-20260519    gcc-14
x86_64                randconfig-075-20260519    gcc-14
x86_64                randconfig-076-20260519    gcc-14
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
xtensa                         randconfig-001    gcc-14.3.0
xtensa                randconfig-001-20260519    gcc-14.3.0
xtensa                         randconfig-002    gcc-14.3.0
xtensa                randconfig-002-20260519    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
