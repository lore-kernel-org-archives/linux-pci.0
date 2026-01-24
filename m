Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF01B181334
	for <linux-pci@vger.kernel.org>; Sat, 24 Jan 2026 04:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769229528; cv=none; b=HEj5rxP0GAzgHXhvhW3nE5og8T+V2rHaU7c0L6gEUDxuz4sa7C4P058LLznfvRF4GEwraGCjQ2xjic5LmW+LLxB7OhxJE5FkACH2yq1kPsDTnb2GniZhE/1wHGVnYb84sSATrQ98oniSDb2fA7Q5uxzxzyAeVzL+alviirhCWsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769229528; c=relaxed/simple;
	bh=Z63zko094y6YFM/kuQIIll8JLZt+4sRydmJbRwgh+2E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Roj6GmMyYGWIqsm4LreEEyMD+vh0tC6SpaUdCb8JZ/WlJ8Fk7Ir9j+GU1+1emUNhB05+5JlcOjUaVOhsiFyrQCmtWN1MvPOD6P7PBcchFxLHoKNu87yt8Q4sDhAE+GqmdijEWlU8kZGkTpm8Lp4BAQYQ7MOSkTZkmudIH0xG+sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZysgF85c; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZysgF85c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769229527; x=1800765527;
  h=date:from:to:cc:subject:message-id;
  bh=Z63zko094y6YFM/kuQIIll8JLZt+4sRydmJbRwgh+2E=;
  b=ZysgF85cNgt+3i4pJ/efpqTTRiyAmlzoOYmAiVtxE/ZTcJbLoZBifjQU
   I5Dw0gCwTDR27gOvGExtJ3GdDRZzxRFkVcebgZqCy76vQ1JR3ZWOutKHd
   LaFyChi2MLW9BrhiEtBBKRqE3sJ0DXzc6x6ZWljAv2sypScDWTSkPHo8C
   XwCLHf8mZm1J5cuFAAO86KtxHsF4d72B8pcZGIrniq37UWPPzpGGfuwN5
   0hgQ7Zjjfr3Jye0mJnR5YJl6OKYzpInqbZ72c5BYBhJo5DNp/KDNCGpQ0
   1zl+JV4Jath+BLmxBWZRd+NvyLdrKLVW+7Y2Z/qt8aaRUaW8Bua3VfKU6
   A==;
X-CSE-ConnectionGUID: +kgRDHG1TwaOWoBDCvJReA==
X-CSE-MsgGUID: N73LEYzcSH+foxoVEUr+nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="73065837"
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="73065837"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 20:38:46 -0800
X-CSE-ConnectionGUID: xxAWBUxITZSl6EugibWKAw==
X-CSE-MsgGUID: u5bzngWXTF+eKgTY2GKg1w==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 23 Jan 2026 20:38:44 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjVQ2-00000000UpE-2hX3;
	Sat, 24 Jan 2026 04:38:42 +0000
Date: Sat, 24 Jan 2026 12:38:17 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 0ecd890e3cf54a0586247b9a384702703277e4fd
Message-ID: <202601241211.sU8bA8Dj-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: 0ecd890e3cf54a0586247b9a384702703277e4fd  PCI: dwc: Rename dw_pcie_rp::has_msi_ctrl to dw_pcie_rp::use_imsi_rx for clarity

elapsed time: 1243m

configs tested: 305
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              alldefconfig    clang-22
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                        nsim_700_defconfig    gcc-15.2.0
arc                   randconfig-001-20260123    gcc-10.5.0
arc                   randconfig-001-20260123    gcc-8.5.0
arc                   randconfig-001-20260124    clang-18
arc                   randconfig-002-20260123    gcc-10.5.0
arc                   randconfig-002-20260123    gcc-8.5.0
arc                   randconfig-002-20260124    clang-18
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                         assabet_defconfig    clang-22
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                          gemini_defconfig    gcc-15.2.0
arm                          pxa168_defconfig    gcc-15.2.0
arm                   randconfig-001-20260123    clang-18
arm                   randconfig-001-20260123    gcc-10.5.0
arm                   randconfig-001-20260124    clang-18
arm                   randconfig-002-20260123    clang-22
arm                   randconfig-002-20260123    gcc-10.5.0
arm                   randconfig-002-20260124    clang-18
arm                   randconfig-003-20260123    gcc-10.5.0
arm                   randconfig-003-20260124    clang-18
arm                   randconfig-004-20260123    gcc-10.5.0
arm                   randconfig-004-20260123    gcc-15.2.0
arm                   randconfig-004-20260124    clang-18
arm                        spear3xx_defconfig    gcc-15.2.0
arm                           tegra_defconfig    gcc-15.2.0
arm                    vt8500_v6_v7_defconfig    gcc-15.2.0
arm64                            alldefconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260123    gcc-15.2.0
arm64                 randconfig-001-20260124    gcc-15.2.0
arm64                 randconfig-002-20260123    gcc-13.4.0
arm64                 randconfig-002-20260123    gcc-15.2.0
arm64                 randconfig-002-20260124    gcc-15.2.0
arm64                 randconfig-003-20260123    gcc-10.5.0
arm64                 randconfig-003-20260123    gcc-15.2.0
arm64                 randconfig-003-20260124    gcc-15.2.0
arm64                 randconfig-004-20260123    gcc-13.4.0
arm64                 randconfig-004-20260123    gcc-15.2.0
arm64                 randconfig-004-20260124    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260123    gcc-15.2.0
csky                  randconfig-001-20260124    gcc-15.2.0
csky                  randconfig-002-20260123    gcc-15.2.0
csky                  randconfig-002-20260124    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260124    gcc-15.2.0
hexagon               randconfig-002-20260124    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260123    clang-20
i386        buildonly-randconfig-001-20260124    gcc-14
i386        buildonly-randconfig-002-20260123    clang-20
i386        buildonly-randconfig-002-20260123    gcc-14
i386        buildonly-randconfig-002-20260124    gcc-14
i386        buildonly-randconfig-003-20260123    clang-20
i386        buildonly-randconfig-003-20260123    gcc-14
i386        buildonly-randconfig-003-20260124    gcc-14
i386        buildonly-randconfig-004-20260123    clang-20
i386        buildonly-randconfig-004-20260123    gcc-14
i386        buildonly-randconfig-004-20260124    gcc-14
i386        buildonly-randconfig-005-20260123    clang-20
i386        buildonly-randconfig-005-20260124    gcc-14
i386        buildonly-randconfig-006-20260123    clang-20
i386        buildonly-randconfig-006-20260124    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260123    gcc-14
i386                  randconfig-001-20260124    gcc-14
i386                  randconfig-002-20260123    gcc-14
i386                  randconfig-002-20260124    gcc-14
i386                  randconfig-003-20260123    gcc-14
i386                  randconfig-003-20260124    gcc-14
i386                  randconfig-004-20260123    gcc-14
i386                  randconfig-004-20260124    gcc-14
i386                  randconfig-005-20260123    gcc-14
i386                  randconfig-005-20260124    gcc-14
i386                  randconfig-006-20260123    gcc-14
i386                  randconfig-006-20260124    gcc-14
i386                  randconfig-007-20260123    gcc-14
i386                  randconfig-007-20260124    gcc-14
i386                  randconfig-011-20260123    clang-20
i386                  randconfig-011-20260124    clang-20
i386                  randconfig-012-20260123    clang-20
i386                  randconfig-012-20260124    clang-20
i386                  randconfig-013-20260123    clang-20
i386                  randconfig-013-20260124    clang-20
i386                  randconfig-014-20260123    clang-20
i386                  randconfig-014-20260124    clang-20
i386                  randconfig-015-20260123    clang-20
i386                  randconfig-015-20260124    clang-20
i386                  randconfig-016-20260123    clang-20
i386                  randconfig-016-20260124    clang-20
i386                  randconfig-017-20260123    clang-20
i386                  randconfig-017-20260124    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260124    gcc-15.2.0
loongarch             randconfig-002-20260124    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                       m5475evb_defconfig    gcc-15.2.0
m68k                          multi_defconfig    clang-22
m68k                           virt_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                      maltaaprp_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260124    gcc-15.2.0
nios2                 randconfig-002-20260124    gcc-15.2.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260123    gcc-12.5.0
parisc                randconfig-001-20260124    gcc-8.5.0
parisc                randconfig-002-20260123    gcc-12.5.0
parisc                randconfig-002-20260124    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                   currituck_defconfig    clang-22
powerpc                 linkstation_defconfig    gcc-15.2.0
powerpc                   motionpro_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260123    gcc-12.5.0
powerpc               randconfig-001-20260124    gcc-8.5.0
powerpc               randconfig-002-20260123    gcc-12.5.0
powerpc               randconfig-002-20260124    gcc-8.5.0
powerpc                     taishan_defconfig    clang-22
powerpc64             randconfig-001-20260123    gcc-12.5.0
powerpc64             randconfig-001-20260124    gcc-8.5.0
powerpc64             randconfig-002-20260123    gcc-12.5.0
powerpc64             randconfig-002-20260124    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260124    gcc-8.5.0
riscv                 randconfig-002-20260124    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260124    gcc-8.5.0
s390                  randconfig-002-20260124    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                        edosk7705_defconfig    gcc-15.2.0
sh                          kfr2r09_defconfig    clang-22
sh                            migor_defconfig    gcc-15.2.0
sh                    randconfig-001-20260124    gcc-8.5.0
sh                    randconfig-002-20260124    gcc-8.5.0
sh                           sh2007_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260123    gcc-13.4.0
sparc                 randconfig-001-20260123    gcc-15.2.0
sparc                 randconfig-001-20260124    gcc-13.4.0
sparc                 randconfig-002-20260123    gcc-13.4.0
sparc                 randconfig-002-20260123    gcc-8.5.0
sparc                 randconfig-002-20260124    gcc-13.4.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260123    gcc-13.4.0
sparc64               randconfig-001-20260124    gcc-13.4.0
sparc64               randconfig-002-20260123    gcc-12.5.0
sparc64               randconfig-002-20260123    gcc-13.4.0
sparc64               randconfig-002-20260124    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260123    gcc-13.4.0
um                    randconfig-001-20260123    gcc-14
um                    randconfig-001-20260124    gcc-13.4.0
um                    randconfig-002-20260123    clang-22
um                    randconfig-002-20260123    gcc-13.4.0
um                    randconfig-002-20260124    gcc-13.4.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           alldefconfig    gcc-15.2.0
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260123    clang-20
x86_64      buildonly-randconfig-002-20260123    clang-20
x86_64      buildonly-randconfig-003-20260123    clang-20
x86_64      buildonly-randconfig-004-20260123    clang-20
x86_64      buildonly-randconfig-005-20260123    clang-20
x86_64      buildonly-randconfig-006-20260123    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260123    gcc-14
x86_64                randconfig-001-20260124    gcc-13
x86_64                randconfig-002-20260123    gcc-14
x86_64                randconfig-002-20260124    gcc-13
x86_64                randconfig-003-20260123    gcc-14
x86_64                randconfig-003-20260124    gcc-13
x86_64                randconfig-004-20260123    gcc-14
x86_64                randconfig-004-20260124    gcc-13
x86_64                randconfig-005-20260123    gcc-14
x86_64                randconfig-005-20260124    gcc-13
x86_64                randconfig-006-20260123    gcc-14
x86_64                randconfig-006-20260124    gcc-13
x86_64                randconfig-011-20260123    gcc-13
x86_64                randconfig-011-20260123    gcc-14
x86_64                randconfig-011-20260124    gcc-12
x86_64                randconfig-012-20260123    gcc-14
x86_64                randconfig-012-20260124    gcc-12
x86_64                randconfig-013-20260123    clang-20
x86_64                randconfig-013-20260123    gcc-14
x86_64                randconfig-013-20260124    gcc-12
x86_64                randconfig-014-20260123    gcc-14
x86_64                randconfig-014-20260124    gcc-12
x86_64                randconfig-015-20260123    gcc-14
x86_64                randconfig-015-20260124    gcc-12
x86_64                randconfig-016-20260123    gcc-13
x86_64                randconfig-016-20260123    gcc-14
x86_64                randconfig-016-20260124    gcc-12
x86_64                randconfig-071-20260123    clang-20
x86_64                randconfig-071-20260124    gcc-14
x86_64                randconfig-072-20260123    clang-20
x86_64                randconfig-072-20260124    gcc-14
x86_64                randconfig-073-20260123    clang-20
x86_64                randconfig-073-20260124    gcc-14
x86_64                randconfig-074-20260123    clang-20
x86_64                randconfig-074-20260124    gcc-14
x86_64                randconfig-075-20260123    clang-20
x86_64                randconfig-075-20260124    gcc-14
x86_64                randconfig-076-20260123    clang-20
x86_64                randconfig-076-20260124    gcc-14
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
xtensa                randconfig-001-20260123    gcc-11.5.0
xtensa                randconfig-001-20260123    gcc-13.4.0
xtensa                randconfig-001-20260124    gcc-13.4.0
xtensa                randconfig-002-20260123    gcc-13.4.0
xtensa                randconfig-002-20260124    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
