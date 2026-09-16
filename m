Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3264B04B1
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561297; cv=none; b=kcPelerS72z389FchD0c2+vJWtqRYd5H4JZca0lK06WxhDxqvOC26TQyXhk8GcyRynsrJboR37jk+iQnW+CJPhjNTs42DFzUXAsZd9qVG/1YaFdZ4eA4gu5Lpf0gsStmCG/kvN9UVbNn+mlEJ5om+w9udKeGkv9RcqOqAqIC+5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561297; c=relaxed/simple;
	bh=bnOejlbNUpCo8KDAeFxH6prO+ooAPSeRZf5Zci20rtc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JPMeLXt87b3WC1dkrR0hF2bcbfr9cChVlsJAkMyUPVRpF9a/FZPUj589HuGFoUKW+QMUtjBFDx42SB6ACHVyq6JO8cSN20JlRgvucOmIMcNAV6V/hreELKw7/4TN6xQ1A19rHPF6UEdduSPXkvYlW7yJuxcpDNHrqlkeml9Hs3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFKFN0/R; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFKFN0/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789561295; x=1821097295;
  h=date:from:to:cc:subject:message-id;
  bh=bnOejlbNUpCo8KDAeFxH6prO+ooAPSeRZf5Zci20rtc=;
  b=aFKFN0/RDtXTOx65vVZ5+qUuiA8wpitC8ewVCqR9+Bsv+RYb4TyKAQhE
   nTlA0zVWVBB8wecGB/pMsolHKV4edKJj6PIu8QlGSbsSFHgw2q3W1KIZX
   p8U5MokCW9k0hfrBzq8+/q+VLBTuDrjO4Jnzz3OtF7i0FoZXeEHufZH+x
   l1OU7Lr6lrCczr/8BD4yj/9PfUnZByZ0yg+urYtgivT37AAqa6cLf4+v6
   rR+gm/3OmJZOD1wK+iGSYn5clOvCszOyiHq/LTa8AUrjhv5PThcZRvTys
   EWtsS8AAgbfz1GnJdZAewIiWuJeSatcgGKHowKsj/aFpIINUj3NZnEdPs
   w==;
X-CSE-ConnectionGUID: 0Z39jKHJQ5u+RdEHRWzvkw==
X-CSE-MsgGUID: Ky1pTjpYQdChMCWbZapy4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90145511"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90145511"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 05:21:31 -0700
X-CSE-ConnectionGUID: AKTmX1MeTmSDnruGtTI0vA==
X-CSE-MsgGUID: I2uaUX1gStirCpzb3DaS4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="276854768"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 16 Sep 2026 05:21:30 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x6odj-0000000063z-3MPV;
	Wed, 16 Sep 2026 12:21:27 +0000
Date: Wed, 16 Sep 2026 20:20:47 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aspm] BUILD SUCCESS
 5b2d6122ae06f1452d307f95729bdbcbcf9cfb87
Message-ID: <202609162044.MmRjvmPj-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aspm
branch HEAD: 5b2d6122ae06f1452d307f95729bdbcbcf9cfb87  wifi: ath10k: Use pci_{enable/disable}_link_state() APIs to enable/disable ASPM states

elapsed time: 2320m

configs tested: 287
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
alpha                randconfig-r063-20260915    gcc-8.5.0
arc                              allmodconfig    clang-24
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-24
arc                                 defconfig    gcc-16.1.0
arc                 nsimosci_hs_smp_defconfig    clang-20
arc                   randconfig-001-20260916    clang-24
arc                   randconfig-002-20260916    clang-24
arc                  randconfig-r062-20260915    gcc-8.5.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-24
arm                                 defconfig    gcc-16.1.0
arm                           h3600_defconfig    gcc-16.1.0
arm                      integrator_defconfig    gcc-16.1.0
arm                         lpc32xx_defconfig    gcc-16.1.0
arm                   randconfig-001-20260916    clang-24
arm                   randconfig-002-20260916    clang-24
arm                   randconfig-003-20260916    clang-24
arm                   randconfig-004-20260916    clang-24
arm                  randconfig-r051-20260915    clang-19
arm                  randconfig-r052-20260915    gcc-9.5.0
arm                  randconfig-r062-20260915    clang-24
arm                  randconfig-r133-20260916    gcc-16.1.0 sparse
arm                           tegra_defconfig    clang-20
arm64                            allmodconfig    clang-24
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260916    gcc-16.1.0
arm64                 randconfig-002-20260916    gcc-16.1.0
arm64                 randconfig-003-20260916    gcc-16.1.0
arm64                 randconfig-004-20260916    gcc-16.1.0
arm64                randconfig-r062-20260915    gcc-8.5.0
arm64                randconfig-r072-20260915    gcc-11.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260916    gcc-16.1.0
csky                  randconfig-002-20260916    gcc-16.1.0
csky                 randconfig-r111-20260916    clang-24 sparse
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260916    gcc-16.1.0
hexagon               randconfig-002-20260916    gcc-16.1.0
hexagon              randconfig-r054-20260915    clang-17
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260916    clang-22
i386        buildonly-randconfig-002-20260916    clang-22
i386        buildonly-randconfig-003-20260916    clang-22
i386        buildonly-randconfig-004-20260916    clang-22
i386        buildonly-randconfig-005-20260916    clang-22
i386        buildonly-randconfig-006-20260916    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260916    gcc-14
i386                  randconfig-002-20260916    gcc-14
i386                  randconfig-003-20260916    gcc-14
i386                  randconfig-004-20260916    gcc-14
i386                  randconfig-005-20260916    gcc-14
i386                  randconfig-006-20260916    gcc-14
i386                  randconfig-007-20260916    gcc-14
i386                  randconfig-011-20260916    clang-22
i386                  randconfig-012-20260916    clang-22
i386                  randconfig-013-20260916    clang-22
i386                  randconfig-014-20260916    clang-22
i386                  randconfig-015-20260916    clang-22
i386                  randconfig-016-20260916    clang-22
i386                  randconfig-017-20260916    clang-22
i386                  randconfig-051-20260915    clang-22
i386                  randconfig-052-20260915    clang-22
i386                  randconfig-053-20260915    clang-22
i386                  randconfig-054-20260915    clang-22
i386                  randconfig-061-20260916    clang-22 sparse
i386                  randconfig-062-20260916    clang-22 sparse
i386                  randconfig-063-20260916    clang-22 sparse
i386                  randconfig-141-20260915    clang-22
i386                 randconfig-r051-20260915    clang-17
i386                 randconfig-r051-20260915    gcc-9.5.0
i386                 randconfig-r112-20260916    clang-24 sparse
i386                 randconfig-r131-20260916    gcc-16.1.0 sparse
loongarch                        allmodconfig    clang-24
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-24
loongarch             randconfig-001-20260916    gcc-16.1.0
loongarch             randconfig-002-20260916    gcc-16.1.0
loongarch            randconfig-r053-20260915    clang-19
loongarch            randconfig-r072-20260915    gcc-16.1.0
loongarch            randconfig-r111-20260916    gcc-12.5.0 sparse
loongarch            randconfig-r121-20260916    gcc-12.5.0 sparse
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-24
m68k                                defconfig    clang-24
m68k                          hp300_defconfig    gcc-16.1.0
m68k                       m5329evb_defconfig    clang-20
m68k                 randconfig-r051-20260915    gcc-8.5.0
m68k                 randconfig-r053-20260915    gcc-8.5.0
m68k                 randconfig-r061-20260915    clang-24
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-24
microblaze           randconfig-r053-20260915    gcc-9.5.0
microblaze           randconfig-r073-20260915    gcc-8.5.0
microblaze           randconfig-r121-20260916    clang-24 sparse
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                         cobalt_defconfig    gcc-16.1.0
mips                           ip22_defconfig    gcc-16.1.0
mips                 randconfig-r054-20260915    gcc-9.5.0
mips                 randconfig-r063-20260915    gcc-8.5.0
mips                 randconfig-r064-20260915    gcc-8.5.0
mips                 randconfig-r073-20260915    gcc-16.1.0
mips                 randconfig-r113-20260916    clang-24 sparse
mips                 randconfig-r123-20260916    gcc-12.5.0 sparse
mips                           rs90_defconfig    gcc-16.1.0
mips                        vocore2_defconfig    clang-20
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-24
nios2                               defconfig    clang-24
nios2                 randconfig-001-20260916    gcc-16.1.0
nios2                 randconfig-002-20260916    gcc-16.1.0
nios2                randconfig-r053-20260915    clang-17
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-24
openrisc                            defconfig    gcc-16.1.0
openrisc             randconfig-r071-20260915    gcc-14.3.0
openrisc             randconfig-r123-20260916    clang-24 sparse
openrisc             randconfig-r134-20260916    gcc-16.1.0 sparse
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-24
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260916    clang-24
parisc                randconfig-002-20260916    clang-24
parisc               randconfig-r052-20260915    clang-17
parisc               randconfig-r052-20260915    clang-19
parisc               randconfig-r052-20260915    gcc-8.5.0
parisc               randconfig-r054-20260915    gcc-8.5.0
parisc               randconfig-r122-20260916    gcc-12.5.0 sparse
parisc               randconfig-r132-20260916    gcc-11.5.0 sparse
parisc64                         alldefconfig    clang-20
parisc64                            defconfig    clang-24
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-24
powerpc                        cell_defconfig    gcc-16.1.0
powerpc                   currituck_defconfig    clang-20
powerpc                     ksi8560_defconfig    gcc-16.1.0
powerpc                 linkstation_defconfig    gcc-16.1.0
powerpc                     mpc512x_defconfig    clang-20
powerpc               randconfig-001-20260916    clang-24
powerpc               randconfig-002-20260916    clang-24
powerpc              randconfig-r063-20260915    clang-24
powerpc              randconfig-r064-20260915    clang-24
powerpc              randconfig-r071-20260915    clang-24
powerpc              randconfig-r072-20260915    gcc-9.5.0
powerpc              randconfig-r113-20260916    clang-24 sparse
powerpc              randconfig-r113-20260916    gcc-12.5.0 sparse
powerpc              randconfig-r122-20260916    clang-24 sparse
powerpc                         wii_defconfig    gcc-16.1.0
powerpc64             randconfig-001-20260916    clang-24
powerpc64             randconfig-002-20260916    clang-24
powerpc64            randconfig-r054-20260915    clang-19
powerpc64            randconfig-r071-20260915    gcc-10.5.0
powerpc64            randconfig-r112-20260916    gcc-12.5.0 sparse
powerpc64            randconfig-r122-20260916    clang-24 sparse
riscv                            allmodconfig    clang-24
riscv                             allnoconfig    clang-24
riscv                            allyesconfig    clang-24
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260916    gcc-16.1.0
riscv                 randconfig-002-20260916    gcc-16.1.0
riscv                randconfig-r053-20260915    clang-24
riscv                randconfig-r064-20260915    gcc-8.5.0
riscv                randconfig-r072-20260915    clang-19
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-24
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260916    gcc-16.1.0
s390                  randconfig-002-20260916    gcc-16.1.0
s390                 randconfig-r064-20260915    gcc-13
s390                 randconfig-r064-20260915    gcc-8.5.0
s390                 randconfig-r073-20260915    clang-19
s390                 randconfig-r133-20260916    gcc-11.5.0 sparse
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-24
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                ecovec24-romimage_defconfig    gcc-16.1.0
sh                          kfr2r09_defconfig    gcc-16.1.0
sh                          lboxre2_defconfig    gcc-16.1.0
sh                    randconfig-001-20260916    gcc-16.1.0
sh                    randconfig-002-20260916    gcc-16.1.0
sh                   randconfig-r054-20260915    clang-24
sh                   randconfig-r123-20260916    clang-24 sparse
sh                          sdk7786_defconfig    clang-20
sh                           se7751_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-24
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260916    gcc-14.3.0
sparc                 randconfig-002-20260916    gcc-14.3.0
sparc                randconfig-r061-20260915    gcc-8.5.0
sparc                randconfig-r063-20260915    gcc-13
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260916    gcc-14.3.0
sparc64               randconfig-002-20260916    gcc-14.3.0
sparc64              randconfig-r061-20260915    gcc-8.5.0
sparc64              randconfig-r071-20260915    gcc-15.2.0
sparc64              randconfig-r112-20260916    clang-24 sparse
sparc64              randconfig-r134-20260916    gcc-11.5.0 sparse
um                               allmodconfig    clang-17
um                                allnoconfig    clang-24
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260916    gcc-14.3.0
um                    randconfig-002-20260916    gcc-14.3.0
um                   randconfig-r052-20260915    clang-24
um                   randconfig-r072-20260915    clang-17
um                   randconfig-r121-20260916    clang-24 sparse
um                   randconfig-r132-20260916    gcc-16.1.0 sparse
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-24
x86_64      buildonly-randconfig-001-20260916    clang-22
x86_64      buildonly-randconfig-002-20260916    clang-22
x86_64      buildonly-randconfig-003-20260916    clang-22
x86_64      buildonly-randconfig-004-20260916    clang-22
x86_64      buildonly-randconfig-005-20260916    clang-22
x86_64      buildonly-randconfig-006-20260916    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260916    clang-22
x86_64                randconfig-002-20260916    clang-22
x86_64                randconfig-003-20260916    clang-22
x86_64                randconfig-004-20260916    clang-22
x86_64                randconfig-005-20260916    clang-22
x86_64                randconfig-006-20260916    clang-22
x86_64                randconfig-011-20260916    gcc-14
x86_64                randconfig-012-20260916    gcc-14
x86_64                randconfig-013-20260916    gcc-14
x86_64                randconfig-014-20260916    gcc-14
x86_64                randconfig-015-20260916    gcc-14
x86_64                randconfig-016-20260916    gcc-14
x86_64                randconfig-071-20260916    gcc-14
x86_64                randconfig-072-20260916    gcc-14
x86_64                randconfig-073-20260916    gcc-14
x86_64                randconfig-074-20260916    gcc-14
x86_64                randconfig-075-20260916    gcc-14
x86_64                randconfig-076-20260916    gcc-14
x86_64                randconfig-101-20260915    clang-22
x86_64                randconfig-102-20260915    clang-22
x86_64                randconfig-103-20260915    clang-22
x86_64                randconfig-104-20260915    clang-22
x86_64                randconfig-121-20260916    clang-22 sparse
x86_64                randconfig-122-20260916    clang-22 sparse
x86_64                randconfig-123-20260916    clang-22 sparse
x86_64                randconfig-161-20260915    clang-22
x86_64               randconfig-r061-20260915    gcc-13
x86_64               randconfig-r063-20260915    gcc-8.5.0
x86_64               randconfig-r073-20260915    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    clang-22
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-24
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260916    gcc-14.3.0
xtensa                randconfig-002-20260916    gcc-14.3.0
xtensa               randconfig-r051-20260915    clang-24
xtensa               randconfig-r061-20260915    gcc-8.5.0
xtensa               randconfig-r062-20260915    gcc-13
xtensa               randconfig-r111-20260916    clang-24 sparse
xtensa               randconfig-r131-20260916    gcc-11.5.0 sparse
xtensa                    smp_lx200_defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
