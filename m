Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD93535CB83
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 06:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769062843; cv=none; b=QW3jSu+ZC1PYLYkwWMVMwdpCswocjFvhXxrjcE/KC5HiKNbtqPCSSD0nG9F2NebxS9NeGrAtParBRBHwT6jT6m/ugIk3I2adKP3yR69+l+P/zb/2tr9ckWx93WMZRpqmk8bPaGWzaWNF3sjXKjOEKhJVc+2XR+BwciQsj/3RxAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769062843; c=relaxed/simple;
	bh=HFPBH2xuty7Jhh3wI8K/djjTz4Zju/c2j0ASDSGlRKI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=chaS5t/kcw0VZqOg8jeXrBVEmbFKyma1Ij27kuSmKpdxRnC1miSFeOLETY2o+K5P8/6z6tEZ99H+wxBz66P9qxF2RwNTLhZ0WXYSlgSKr3X/ZZMkgYS/2b5e/R3p8bn7/3n/j64zW8DKPIBuT6XDxdpmrolTb/FNKLbdQOxrSaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LV7JEGaT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LV7JEGaT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769062842; x=1800598842;
  h=date:from:to:cc:subject:message-id;
  bh=HFPBH2xuty7Jhh3wI8K/djjTz4Zju/c2j0ASDSGlRKI=;
  b=LV7JEGaTcolMPdyL4wWlI5+5y6MC9lIw0bO+UUuH5WPvhn5HqKQD6c+f
   2XjsXjvUjuxn1Az6nvoFYV81txXf5Hiiuhhs25HZrj6mrXgRSjky/3rX9
   5fsWKiw5wyiDUhnLro8ltqVjnbVTD/XH+7wYxNbIKjBQjAUTZpX5is0JZ
   S4bpKgmve4pv7DCIll1v2f55CkHJoPcCNj3MAfMkHf0QEQqIIyeYHYOZn
   xg0ygQ3v4Iq8TLV0EsSaGsv3tGdmRFhkE5azvOMnE5MZQ2AsOUtW5pW6/
   qgwrL0BpO6PQlQIeZ54V8PVxl7WrHs9J7rZL0eQLERsP/gWkow5rOVj/M
   w==;
X-CSE-ConnectionGUID: rlPgdgtrQA28EvhKnBpl8A==
X-CSE-MsgGUID: Gibo7bTDSN6wWO7pAgOH0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="80922331"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="80922331"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 22:20:41 -0800
X-CSE-ConnectionGUID: Z81LdHmPRu+Y5KiEqMNyVQ==
X-CSE-MsgGUID: yD2YiUyiQn6NsSMtMXY9kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="206459895"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 21 Jan 2026 22:20:40 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vio3Y-00000000SW1-4ACj;
	Thu, 22 Jan 2026 06:20:36 +0000
Date: Thu, 22 Jan 2026 14:20:08 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 57dfeba6dbb4fe3f20665a491d0ba690294abb37
Message-ID: <202601221403.2zI8KSuJ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 57dfeba6dbb4fe3f20665a491d0ba690294abb37  PCI: Fix Resizable BAR restore order

elapsed time: 730m

configs tested: 203
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-15.2.0
arc                   randconfig-001-20260122    gcc-15.2.0
arc                   randconfig-002-20260122    gcc-15.2.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                         axm55xx_defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                         mv78xx0_defconfig    gcc-15.2.0
arm                   randconfig-001-20260122    gcc-15.2.0
arm                   randconfig-002-20260122    gcc-15.2.0
arm                   randconfig-003-20260122    gcc-15.2.0
arm                   randconfig-004-20260122    gcc-15.2.0
arm                        spear3xx_defconfig    clang-22
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260122    gcc-15.2.0
arm64                 randconfig-002-20260122    gcc-15.2.0
arm64                 randconfig-003-20260122    gcc-15.2.0
arm64                 randconfig-004-20260122    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260122    gcc-15.2.0
csky                  randconfig-002-20260122    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260122    gcc-15.2.0
hexagon               randconfig-002-20260122    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260122    clang-20
i386        buildonly-randconfig-002-20260122    clang-20
i386        buildonly-randconfig-003-20260122    clang-20
i386        buildonly-randconfig-004-20260122    clang-20
i386        buildonly-randconfig-005-20260122    clang-20
i386        buildonly-randconfig-006-20260122    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-011-20260122    clang-20
i386                  randconfig-012-20260122    clang-20
i386                  randconfig-013-20260122    clang-20
i386                  randconfig-014-20260122    clang-20
i386                  randconfig-015-20260122    clang-20
i386                  randconfig-016-20260122    clang-20
i386                  randconfig-017-20260122    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260122    gcc-15.2.0
loongarch             randconfig-002-20260122    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                            mac_defconfig    gcc-15.2.0
m68k                        mvme147_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                       bmips_be_defconfig    gcc-15.2.0
mips                  cavium_octeon_defconfig    gcc-15.2.0
mips                     cu1000-neo_defconfig    gcc-15.2.0
mips                        maltaup_defconfig    gcc-15.2.0
mips                       rbtx49xx_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260122    gcc-15.2.0
nios2                 randconfig-002-20260122    gcc-15.2.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260122    gcc-10.5.0
parisc                randconfig-002-20260122    gcc-10.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                    amigaone_defconfig    clang-22
powerpc                       eiger_defconfig    gcc-15.2.0
powerpc                          g5_defconfig    clang-22
powerpc                       holly_defconfig    clang-22
powerpc                      mgcoge_defconfig    clang-22
powerpc               randconfig-001-20260122    gcc-10.5.0
powerpc               randconfig-002-20260122    gcc-10.5.0
powerpc                     tqm8541_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260122    gcc-10.5.0
powerpc64             randconfig-002-20260122    gcc-10.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260122    clang-18
riscv                 randconfig-002-20260122    clang-18
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260122    clang-18
s390                  randconfig-002-20260122    clang-18
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                          r7780mp_defconfig    clang-22
sh                    randconfig-001-20260122    clang-18
sh                    randconfig-002-20260122    clang-18
sh                           sh2007_defconfig    gcc-15.2.0
sh                   sh7724_generic_defconfig    clang-22
sh                   sh7724_generic_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260122    gcc-8.5.0
sparc                 randconfig-002-20260122    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260122    gcc-8.5.0
sparc64               randconfig-002-20260122    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260122    gcc-8.5.0
um                    randconfig-002-20260122    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           alldefconfig    gcc-15.2.0
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260122    clang-20
x86_64      buildonly-randconfig-002-20260122    clang-20
x86_64      buildonly-randconfig-003-20260122    clang-20
x86_64      buildonly-randconfig-004-20260122    clang-20
x86_64      buildonly-randconfig-005-20260122    clang-20
x86_64      buildonly-randconfig-006-20260122    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260122    clang-20
x86_64                randconfig-002-20260122    clang-20
x86_64                randconfig-003-20260122    clang-20
x86_64                randconfig-004-20260122    clang-20
x86_64                randconfig-005-20260122    clang-20
x86_64                randconfig-006-20260122    clang-20
x86_64                randconfig-011-20260122    clang-20
x86_64                randconfig-012-20260122    clang-20
x86_64                randconfig-013-20260122    clang-20
x86_64                randconfig-014-20260122    clang-20
x86_64                randconfig-015-20260122    clang-20
x86_64                randconfig-016-20260122    clang-20
x86_64                randconfig-071-20260122    clang-20
x86_64                randconfig-072-20260122    clang-20
x86_64                randconfig-073-20260122    clang-20
x86_64                randconfig-074-20260122    clang-20
x86_64                randconfig-075-20260122    clang-20
x86_64                randconfig-076-20260122    clang-20
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
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260122    gcc-8.5.0
xtensa                randconfig-002-20260122    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
