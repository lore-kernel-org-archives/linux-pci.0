Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F01A273D8D
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 05:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784179496; cv=none; b=sHb6tSDk5Cam/orMxmOL+GsBFTqvl/XcEGEhJ6iAblpiBsSH97ae8r5NZxq+YP3yQDLrS9FgOjdXcGfa42uUJ+IaOE0a1ZFEqE1bOgzVEcor2rKxCFo6ZSzIEELdMrgbBKrHLv+OMhzvAKfNw18P2aotImX/9yZn09AnQQ2i9y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784179496; c=relaxed/simple;
	bh=8bsbolKLecv0pPZli3H9pxY5ZFCzHu/Azrg8XcstevQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=B91v7WWSXIo1RhBWD6G6o0cyhz2khq46pqTj+rDYCvPjGn2PMaWLjxQ64hOUWCpI6KjqjaiU1Rg55ETke7Ah1hh4spPW8ZzZJ9cuMBT8si/fF+I4CrIEWw3HB7CP00zFo7hwxOWB9ffAL8dsdnT/ll6RvElzTlmxpUuTrgMfq60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UtF/CkHu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UtF/CkHu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784179493; x=1815715493;
  h=date:from:to:cc:subject:message-id;
  bh=8bsbolKLecv0pPZli3H9pxY5ZFCzHu/Azrg8XcstevQ=;
  b=UtF/CkHuX62L0RYmjiyu49C3sLcnnD/oXrMuoAF9uCnuCZo0++HALrly
   X+DQ4RyHQp2oIwCGjf9UCG6xJ26zyyYxP8xTZBtRpWmcX96tvIuVmVS2T
   pGDlu9AeTGQnvrxHUNXnOedx5hwKRErtx9tLvrjWJt5ECH6U/Ic3tZTE4
   CVbCHFecjfPyzpuds1wFfV3Bho9RflctqATY9ogexYN8aE98/oo1JJ5w0
   9dEfq73MsQU+kDtJEnp/daC0BOX3AOkKAq/LbdJ11Jm+sMIIO5eYTSgek
   a4mSU3hvAsb82HurQOLJe8BCMw9wMVd5KAKfKOBR1V5G2jRER7QWfiZYO
   g==;
X-CSE-ConnectionGUID: SKP/yZGwTj+K7tMeHi7JbQ==
X-CSE-MsgGUID: +BHNZfheTlGwy8ixEE0tcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84869258"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="84869258"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 22:24:52 -0700
X-CSE-ConnectionGUID: kBm2cgpPT1mn6zqJHspR5Q==
X-CSE-MsgGUID: zw0sHgo3Sa6p1dn/ICVz2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="252423228"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 15 Jul 2026 22:24:51 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wkEaX-00000000OL3-04sy;
	Thu, 16 Jul 2026 05:24:49 +0000
Date: Thu, 16 Jul 2026 13:23:48 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/xgene] BUILD SUCCESS
 4869db344e76c9adfb1d9654df442db5371fac71
Message-ID: <202607161337.Y06U1rdU-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/xgene
branch HEAD: 4869db344e76c9adfb1d9654df442db5371fac71  PCI: xgene: Drop unnecessary OF node reference

elapsed time: 842m

configs tested: 159
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260716    gcc-14.3.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260716    gcc-16.1.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                            randconfig-001    gcc-16.1.0
arm                   randconfig-001-20260716    gcc-8.5.0
arm                            randconfig-002    gcc-15.2.0
arm                   randconfig-002-20260716    clang-17
arm                            randconfig-003    clang-23
arm                   randconfig-003-20260716    gcc-12.5.0
arm                            randconfig-004    gcc-13.4.0
arm                   randconfig-004-20260716    clang-24
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260716    clang-23
arm64                 randconfig-002-20260716    clang-22
arm64                 randconfig-003-20260716    clang-23
arm64                 randconfig-004-20260716    gcc-12.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260716    gcc-12.5.0
csky                  randconfig-002-20260716    gcc-14.3.0
hexagon                          allmodconfig    clang-23
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-24
hexagon                        randconfig-001    clang-17
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260716    clang-22
i386        buildonly-randconfig-002-20260716    clang-22
i386        buildonly-randconfig-003-20260716    clang-22
i386        buildonly-randconfig-004-20260716    clang-22
i386        buildonly-randconfig-005-20260716    clang-22
i386        buildonly-randconfig-006-20260716    clang-22
i386                                defconfig    clang-22
i386                  randconfig-001-20260716    clang-22
i386                  randconfig-002-20260716    clang-22
i386                  randconfig-003-20260716    gcc-14
i386                  randconfig-004-20260716    gcc-14
i386                  randconfig-005-20260716    clang-22
i386                  randconfig-006-20260716    clang-22
i386                  randconfig-007-20260716    clang-22
i386                  randconfig-011-20260716    clang-22
i386                  randconfig-012-20260716    gcc-12
i386                  randconfig-013-20260716    clang-22
i386                  randconfig-014-20260716    gcc-12
i386                  randconfig-015-20260716    clang-22
i386                  randconfig-016-20260716    gcc-14
i386                  randconfig-017-20260716    clang-22
loongarch                        allmodconfig    clang-19
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260716    clang-20
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260716    gcc-15.2.0
parisc                randconfig-002-20260716    gcc-8.5.0
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-002-20260716    clang-19
powerpc64             randconfig-001-20260716    clang-22
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                          randconfig-001    gcc-13.4.0
riscv                 randconfig-001-20260716    gcc-14.3.0
riscv                          randconfig-002    clang-17
riscv                 randconfig-002-20260716    clang-17
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                           randconfig-001    gcc-15.2.0
s390                  randconfig-001-20260716    clang-23
s390                           randconfig-002    clang-18
s390                  randconfig-002-20260716    gcc-9.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-16.1.0
sh                             randconfig-001    gcc-14.3.0
sh                    randconfig-001-20260716    gcc-16.1.0
sh                             randconfig-002    gcc-9.5.0
sh                    randconfig-002-20260716    gcc-16.1.0
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260716    gcc-13.4.0
sparc                 randconfig-002-20260716    gcc-11.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64               randconfig-001-20260716    clang-23
sparc64               randconfig-002-20260716    clang-23
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260716    clang-23
um                    randconfig-002-20260716    gcc-14
um                           x86_64_defconfig    clang-24
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260716    clang-22
x86_64      buildonly-randconfig-002-20260716    gcc-14
x86_64      buildonly-randconfig-003-20260716    gcc-14
x86_64      buildonly-randconfig-004-20260716    gcc-14
x86_64      buildonly-randconfig-005-20260716    gcc-14
x86_64      buildonly-randconfig-006-20260716    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260716    gcc-12
x86_64                randconfig-002-20260716    gcc-14
x86_64                randconfig-003-20260716    clang-22
x86_64                randconfig-004-20260716    clang-22
x86_64                randconfig-005-20260716    clang-22
x86_64                randconfig-006-20260716    gcc-14
x86_64                randconfig-013-20260716    gcc-14
x86_64                randconfig-016-20260716    gcc-14
x86_64                randconfig-071-20260716    clang-22
x86_64                randconfig-072-20260716    clang-22
x86_64                randconfig-073-20260716    clang-22
x86_64                randconfig-074-20260716    gcc-14
x86_64                randconfig-075-20260716    clang-22
x86_64                randconfig-076-20260716    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260716    gcc-9.5.0
xtensa                randconfig-002-20260716    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
