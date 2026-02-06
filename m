Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD631E991B
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 02:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770345402; cv=none; b=hgvaUlajlsJIY3n9srMWD0bKZqRekYkk3SunpGQU/zPgtYDfVOKQvRg4WDul+83i9Jn3AhW+41IWuShwbECCT7XJYMR+oobYDA7icjiOfOZOC/3z7UOnDehHVwnQsxh9KMnzoVKv8htq//5BZ0DV4N5B522GXhwQ+7HteA7aWeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770345402; c=relaxed/simple;
	bh=CaffL2cRnJgsBNaRr0frPYGvuBx7gRO+AYawjd9F0YY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZcGJOwC9fFwkXyXfplC09uqM/E5ho9V3Vpg1H1IM8eba7tfWDJe8nYk/i6wQtldj3eAUPFgqy8F7MVT6DeWfKNx/bWMuaWcKBh1zHzi/uH07h3733BFj5lVYQo+BN6nrDl3UcPULkrcWw8BRJIDau0kGMwPdYQkwj7/9Zi3BQg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hg2mGR2t; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hg2mGR2t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770345402; x=1801881402;
  h=date:from:to:cc:subject:message-id;
  bh=CaffL2cRnJgsBNaRr0frPYGvuBx7gRO+AYawjd9F0YY=;
  b=Hg2mGR2t+5+AaEEWORxGT6hVsrNtv5T48xaJOxJOinCPFeDk2gvOvqbk
   SLyimIKwT9rEQgFSJPlqfZmUe/asiuRh3VlbQ87SveszwcBNKluqFKGJm
   zckX/YYTB0UkD7R+BEm2eYIVyTxUcJFAfYRxgdq3WfAk8mh6gIhdYRUTf
   CgdaMuRkIzW74Uu6/KZ7LKINQaAfvG8KLXA1Tg40II4Q6ZtqZWXmtMYiO
   mORArr1Tt4l40zt9cun8ltWhHayOedExiaXj2g7jCqRDNMqXA/zRnvK2M
   XhwWYcNMQoq4cREl+Tfn3fJJhGyiHVPiP/49e7TK7bZeMPMilKJpc5jnX
   w==;
X-CSE-ConnectionGUID: 0sZT/xxhTm63rPJds1ArKg==
X-CSE-MsgGUID: +vYl4An0QNCCez5sIBqs1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="75410136"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="75410136"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 18:36:42 -0800
X-CSE-ConnectionGUID: 9UVxUagNSIGpguxlFrZXhg==
X-CSE-MsgGUID: MSJ/hTocRHOAmv+AzUqvUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="241414717"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 05 Feb 2026 18:36:40 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1voBi1-00000000kNU-3gXE;
	Fri, 06 Feb 2026 02:36:37 +0000
Date: Fri, 06 Feb 2026 10:36:09 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 43d324eeb08c3dd9fff7eb9a2c617afd3b96e65c
Message-ID: <202602061001.XPpuceK5-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: 43d324eeb08c3dd9fff7eb9a2c617afd3b96e65c  PCI: dwc: Fix missing iATU setup when ECAM is enabled

elapsed time: 810m

configs tested: 254
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
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260205    gcc-8.5.0
arc                   randconfig-001-20260206    gcc-8.5.0
arc                   randconfig-002-20260205    gcc-8.5.0
arc                   randconfig-002-20260206    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                          ep93xx_defconfig    clang-22
arm                   randconfig-001-20260205    clang-22
arm                   randconfig-001-20260206    gcc-8.5.0
arm                   randconfig-002-20260205    gcc-8.5.0
arm                   randconfig-002-20260206    gcc-8.5.0
arm                   randconfig-003-20260205    clang-22
arm                   randconfig-003-20260206    gcc-8.5.0
arm                   randconfig-004-20260205    gcc-8.5.0
arm                   randconfig-004-20260206    gcc-8.5.0
arm                           sunxi_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260206    gcc-13.4.0
arm64                 randconfig-001-20260206    gcc-14.3.0
arm64                 randconfig-002-20260206    clang-18
arm64                 randconfig-002-20260206    gcc-13.4.0
arm64                 randconfig-003-20260206    clang-22
arm64                 randconfig-003-20260206    gcc-13.4.0
arm64                 randconfig-004-20260206    gcc-13.4.0
arm64                 randconfig-004-20260206    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260206    gcc-13.4.0
csky                  randconfig-001-20260206    gcc-15.2.0
csky                  randconfig-002-20260206    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260206    clang-22
hexagon               randconfig-002-20260206    clang-22
i386                             alldefconfig    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260206    clang-20
i386        buildonly-randconfig-002-20260206    clang-20
i386        buildonly-randconfig-003-20260206    clang-20
i386        buildonly-randconfig-004-20260206    clang-20
i386        buildonly-randconfig-005-20260206    clang-20
i386        buildonly-randconfig-006-20260206    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260206    gcc-14
i386                  randconfig-002-20260206    gcc-12
i386                  randconfig-002-20260206    gcc-14
i386                  randconfig-003-20260206    gcc-14
i386                  randconfig-004-20260206    gcc-14
i386                  randconfig-005-20260206    gcc-14
i386                  randconfig-006-20260206    gcc-14
i386                  randconfig-007-20260206    gcc-14
i386                  randconfig-011-20260206    clang-20
i386                  randconfig-012-20260206    clang-20
i386                  randconfig-012-20260206    gcc-14
i386                  randconfig-013-20260206    clang-20
i386                  randconfig-013-20260206    gcc-14
i386                  randconfig-014-20260206    clang-20
i386                  randconfig-015-20260206    clang-20
i386                  randconfig-016-20260206    clang-20
i386                  randconfig-017-20260206    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260206    clang-22
loongarch             randconfig-002-20260206    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                  cavium_octeon_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260206    clang-22
nios2                 randconfig-002-20260206    clang-22
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
parisc                randconfig-001-20260206    gcc-8.5.0
parisc                randconfig-002-20260206    gcc-12.5.0
parisc                randconfig-002-20260206    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                 canyonlands_defconfig    clang-22
powerpc                  iss476-smp_defconfig    clang-22
powerpc                      pmac32_defconfig    clang-22
powerpc               randconfig-001-20260206    gcc-8.5.0
powerpc               randconfig-002-20260206    clang-20
powerpc               randconfig-002-20260206    gcc-8.5.0
powerpc64             randconfig-001-20260206    clang-22
powerpc64             randconfig-001-20260206    gcc-8.5.0
powerpc64             randconfig-002-20260206    gcc-10.5.0
powerpc64             randconfig-002-20260206    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260205    clang-19
riscv                 randconfig-001-20260206    clang-22
riscv                 randconfig-002-20260205    clang-22
riscv                 randconfig-002-20260206    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260205    clang-18
s390                  randconfig-001-20260206    clang-22
s390                  randconfig-002-20260205    clang-22
s390                  randconfig-002-20260206    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260205    gcc-15.2.0
sh                    randconfig-001-20260206    clang-22
sh                    randconfig-002-20260205    gcc-10.5.0
sh                    randconfig-002-20260206    clang-22
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260205    gcc-15.2.0
sparc                 randconfig-001-20260206    gcc-12.5.0
sparc                 randconfig-002-20260205    gcc-12.5.0
sparc                 randconfig-002-20260206    gcc-12.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260205    gcc-8.5.0
sparc64               randconfig-001-20260206    gcc-12.5.0
sparc64               randconfig-002-20260205    gcc-8.5.0
sparc64               randconfig-002-20260206    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260205    clang-22
um                    randconfig-001-20260206    gcc-12.5.0
um                    randconfig-002-20260205    gcc-13
um                    randconfig-002-20260206    gcc-12.5.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260206    gcc-14
x86_64      buildonly-randconfig-002-20260206    gcc-14
x86_64      buildonly-randconfig-003-20260206    gcc-14
x86_64      buildonly-randconfig-004-20260206    gcc-14
x86_64      buildonly-randconfig-005-20260206    gcc-14
x86_64      buildonly-randconfig-006-20260206    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260206    clang-20
x86_64                randconfig-001-20260206    gcc-14
x86_64                randconfig-002-20260206    gcc-14
x86_64                randconfig-003-20260206    gcc-14
x86_64                randconfig-004-20260206    clang-20
x86_64                randconfig-004-20260206    gcc-14
x86_64                randconfig-005-20260206    gcc-14
x86_64                randconfig-006-20260206    clang-20
x86_64                randconfig-006-20260206    gcc-14
x86_64                randconfig-011-20260205    clang-20
x86_64                randconfig-011-20260206    gcc-14
x86_64                randconfig-012-20260205    gcc-14
x86_64                randconfig-012-20260206    gcc-14
x86_64                randconfig-013-20260205    gcc-14
x86_64                randconfig-013-20260206    gcc-14
x86_64                randconfig-014-20260205    clang-20
x86_64                randconfig-014-20260206    gcc-14
x86_64                randconfig-015-20260205    gcc-14
x86_64                randconfig-015-20260206    gcc-14
x86_64                randconfig-016-20260205    clang-20
x86_64                randconfig-016-20260206    gcc-14
x86_64                randconfig-071-20260206    gcc-14
x86_64                randconfig-072-20260206    clang-20
x86_64                randconfig-072-20260206    gcc-14
x86_64                randconfig-073-20260206    gcc-14
x86_64                randconfig-074-20260206    gcc-14
x86_64                randconfig-075-20260206    clang-20
x86_64                randconfig-075-20260206    gcc-14
x86_64                randconfig-076-20260206    gcc-14
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
xtensa                  cadence_csp_defconfig    clang-22
xtensa                randconfig-001-20260205    gcc-8.5.0
xtensa                randconfig-001-20260206    gcc-12.5.0
xtensa                randconfig-002-20260205    gcc-12.5.0
xtensa                randconfig-002-20260206    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
