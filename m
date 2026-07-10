Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33643155A5D
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 01:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783646383; cv=none; b=kMtmI2jHZs7Lr8D5M2eoEyHuREvJrSOuMK9RqFzdL1usalXChV5bLpVicaG1DHDIG1HPXzB2SuyoTgYMNftmYbMb6WI2Sb8YDCJQE9O2PYQeHo4/W+Jit/wm886toWHC6pOCZhg4bdpjePHfxKZFTX44x3xkOpgdPNEsVkKbXEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783646383; c=relaxed/simple;
	bh=dc6IkdI0dyM2D/JKNxiLrsoaKRu5Hqjku6VV/6plOd8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XfiCXLmF5FApNO7OzNBDyr/hy8J5sq1yuZUZ2FFtDuLUEUPD0FtJSLVnGUS1fVdAXhRl9/vhKk+Hn3eVAnVbuFl9VFfYDPUKfO0czmkps+3ZCJO4h+ckfo7Hm3V15Hp7vG+JDg4R3O1Wu2HSo7kf7pD56FKRSmRNSJDRQYDTDJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0vEd4J/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0vEd4J/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783646381; x=1815182381;
  h=date:from:to:cc:subject:message-id;
  bh=dc6IkdI0dyM2D/JKNxiLrsoaKRu5Hqjku6VV/6plOd8=;
  b=T0vEd4J/rg+cSa9pMb2QUjvWo7jdBxZW6d/EImXi0pY7T4ay8RboZLsI
   uP1pWj0rGCLDXdVYk97t3OfakGA4++iOCPiZP/Pu/v016H0p4S6Ovb6jg
   x2oFr0m92co+1WnJXI5bjoqCl+xlknum67EjQLrsoYHcOo5yWSW8PrL24
   2Nf7grbO4Cm9AuKkM2PON169eIcm+3U4v0MHi/RjaiLBJMWjE4S9DrKuM
   RS4tgG+OSXQ5vx6Ue5HeOLAp4IpB33/dOJAyrkWTji3K59mcDWrrOWeDL
   Axfo18Q10leBXEAw4DnGHI60sBH3EtKJsE2m5cNqsDgc6N8XEdmDys7n9
   g==;
X-CSE-ConnectionGUID: FxwJJ2hEQ1K83/71SR4eoA==
X-CSE-MsgGUID: /lUU7k6GTtajzxiirgZWgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83322742"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83322742"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 18:19:41 -0700
X-CSE-ConnectionGUID: G/LEyOuGQ6mFV9+UQ2EGkg==
X-CSE-MsgGUID: VIQu+rTlQaSo+iu+UvyYeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="253008942"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 09 Jul 2026 18:19:39 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1whztw-00000000ILX-0K16;
	Fri, 10 Jul 2026 01:19:36 +0000
Date: Fri, 10 Jul 2026 09:19:26 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-rcar-gen4] BUILD REGRESSION
 14e8394423ffd4fd28884ec8b4d5ba15be6e7e0d
Message-ID: <202607100905.JpwyogVK-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-rcar-gen4
branch HEAD: 14e8394423ffd4fd28884ec8b4d5ba15be6e7e0d  irqchip/gic-v3: Add Renesas R-Car Gen4 erratum workaround

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202607100310.iQw5m9Uo-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202607100424.xo06gLTB-lkp@intel.com

    include/linux/irqchip/arm-gic-v3.h:605:10: fatal error: 'asm/arch_gicv3.h' file not found
    include/linux/irqchip/arm-gic-v3.h:605:10: fatal error: asm/arch_gicv3.h: No such file or directory

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h:No-such-file-or-directory
|-- alpha-randconfig-r053-20260710
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h:No-such-file-or-directory
|-- arc-allmodconfig
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h:No-such-file-or-directory
|-- arc-allyesconfig
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h:No-such-file-or-directory
|-- csky-allmodconfig
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h:No-such-file-or-directory
|-- i386-allmodconfig
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h:No-such-file-or-directory
|-- i386-allyesconfig
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h:No-such-file-or-directory
|-- loongarch-randconfig-002-20260710
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h-file-not-found
|-- loongarch-randconfig-r072-20260710
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h:No-such-file-or-directory
|-- microblaze-allyesconfig
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h:No-such-file-or-directory
|-- mips-allmodconfig
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h:No-such-file-or-directory
|-- mips-allyesconfig
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h:No-such-file-or-directory
|-- openrisc-allmodconfig
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h:No-such-file-or-directory
|-- parisc-allmodconfig
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h:No-such-file-or-directory
|-- parisc-allyesconfig
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h:No-such-file-or-directory
|-- parisc-randconfig-001-20260710
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h:No-such-file-or-directory
|-- parisc-randconfig-r071-20260709
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h:No-such-file-or-directory
|-- powerpc-allmodconfig
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h:No-such-file-or-directory
|-- powerpc-randconfig-001-20260710
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h:No-such-file-or-directory
|-- powerpc-randconfig-r063-20260710
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h-file-not-found
|-- powerpc64-randconfig-001-20260710
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h-file-not-found
|-- powerpc64-randconfig-002-20260709
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h-file-not-found
|-- riscv-allmodconfig
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h-file-not-found
|-- riscv-allyesconfig
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h-file-not-found
|-- riscv-randconfig-001-20260710
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h-file-not-found
|-- s390-allmodconfig
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h-file-not-found
|-- s390-allyesconfig
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h:No-such-file-or-directory
|-- s390-randconfig-r134-20260710
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h-file-not-found
|-- sparc-randconfig-001-20260709
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h:No-such-file-or-directory
|-- sparc64-allmodconfig
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h-file-not-found
|-- um-allmodconfig
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h-file-not-found
|-- um-allyesconfig
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h:No-such-file-or-directory
|-- um-randconfig-001
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h-file-not-found
|-- um-randconfig-002-20260709
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h-file-not-found
|-- x86_64-allmodconfig
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h-file-not-found
|-- x86_64-allyesconfig
|   `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h-file-not-found
`-- xtensa-allyesconfig
    `-- include-linux-irqchip-arm-gic-v3.h:fatal-error:asm-arch_gicv3.h:No-such-file-or-directory

elapsed time: 726m

configs tested: 315
configs skipped: 5

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
arc                            randconfig-001    gcc-16.1.0
arc                   randconfig-001-20260709    gcc-16.1.0
arc                   randconfig-001-20260710    clang-23
arc                            randconfig-002    gcc-16.1.0
arc                   randconfig-002-20260709    gcc-16.1.0
arc                   randconfig-002-20260710    clang-23
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                          ep93xx_defconfig    clang-23
arm                            randconfig-001    gcc-16.1.0
arm                   randconfig-001-20260709    gcc-16.1.0
arm                   randconfig-001-20260710    clang-23
arm                            randconfig-002    gcc-16.1.0
arm                   randconfig-002-20260709    gcc-16.1.0
arm                   randconfig-002-20260710    clang-23
arm                            randconfig-003    gcc-16.1.0
arm                   randconfig-003-20260709    gcc-16.1.0
arm                   randconfig-003-20260710    clang-23
arm                            randconfig-004    gcc-16.1.0
arm                   randconfig-004-20260709    gcc-16.1.0
arm                   randconfig-004-20260710    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260709    gcc-16.1.0
arm64                 randconfig-001-20260710    gcc-10.5.0
arm64                 randconfig-002-20260709    gcc-16.1.0
arm64                 randconfig-002-20260710    gcc-10.5.0
arm64                 randconfig-003-20260709    gcc-16.1.0
arm64                 randconfig-003-20260710    gcc-10.5.0
arm64                 randconfig-004-20260709    gcc-16.1.0
arm64                 randconfig-004-20260710    gcc-10.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260709    gcc-16.1.0
csky                  randconfig-001-20260710    gcc-10.5.0
csky                  randconfig-002-20260709    gcc-16.1.0
csky                  randconfig-002-20260710    gcc-10.5.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260709    clang-18
hexagon               randconfig-001-20260710    gcc-12.5.0
hexagon               randconfig-002-20260709    clang-18
hexagon               randconfig-002-20260710    gcc-12.5.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260709    gcc-14
i386        buildonly-randconfig-001-20260710    clang-22
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260709    gcc-14
i386        buildonly-randconfig-002-20260710    clang-22
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260709    gcc-14
i386        buildonly-randconfig-003-20260710    clang-22
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260709    gcc-14
i386        buildonly-randconfig-004-20260710    clang-22
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260709    gcc-14
i386        buildonly-randconfig-005-20260710    clang-22
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260709    gcc-14
i386        buildonly-randconfig-006-20260710    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260709    gcc-14
i386                  randconfig-001-20260710    clang-22
i386                  randconfig-002-20260709    gcc-14
i386                  randconfig-002-20260710    clang-22
i386                  randconfig-003-20260709    gcc-14
i386                  randconfig-003-20260710    clang-22
i386                  randconfig-004-20260709    gcc-14
i386                  randconfig-004-20260710    clang-22
i386                  randconfig-005-20260709    gcc-14
i386                  randconfig-005-20260710    clang-22
i386                  randconfig-006-20260709    gcc-14
i386                  randconfig-006-20260710    clang-22
i386                  randconfig-007-20260709    gcc-14
i386                  randconfig-007-20260710    clang-22
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260709    gcc-14
i386                  randconfig-011-20260710    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260709    gcc-14
i386                  randconfig-012-20260710    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260709    gcc-14
i386                  randconfig-013-20260710    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260709    gcc-14
i386                  randconfig-014-20260710    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260709    gcc-14
i386                  randconfig-015-20260710    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260709    gcc-14
i386                  randconfig-016-20260710    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260709    gcc-14
i386                  randconfig-017-20260710    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260709    clang-18
loongarch             randconfig-001-20260710    gcc-12.5.0
loongarch             randconfig-002-20260709    clang-18
loongarch             randconfig-002-20260710    gcc-12.5.0
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
nios2                         10m50_defconfig    gcc-11.5.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260709    clang-18
nios2                 randconfig-001-20260710    gcc-12.5.0
nios2                 randconfig-002-20260709    clang-18
nios2                 randconfig-002-20260710    gcc-12.5.0
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    clang-23
parisc                randconfig-001-20260709    clang-23
parisc                randconfig-001-20260710    clang-17
parisc                         randconfig-002    clang-23
parisc                randconfig-002-20260709    clang-23
parisc                randconfig-002-20260710    clang-17
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                 mpc836x_rdk_defconfig    clang-23
powerpc                       ppc64_defconfig    clang-17
powerpc                     rainier_defconfig    gcc-16.1.0
powerpc                        randconfig-001    clang-23
powerpc               randconfig-001-20260709    clang-23
powerpc               randconfig-001-20260710    clang-17
powerpc                        randconfig-002    clang-23
powerpc               randconfig-002-20260709    clang-23
powerpc               randconfig-002-20260710    clang-17
powerpc64                      randconfig-001    clang-23
powerpc64             randconfig-001-20260709    clang-23
powerpc64             randconfig-001-20260710    clang-17
powerpc64                      randconfig-002    clang-23
powerpc64             randconfig-002-20260709    clang-23
powerpc64             randconfig-002-20260710    clang-17
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    clang-22
riscv                 randconfig-001-20260709    clang-22
riscv                 randconfig-001-20260710    clang-17
riscv                          randconfig-002    clang-22
riscv                 randconfig-002-20260709    clang-22
riscv                 randconfig-002-20260710    clang-17
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    clang-22
s390                  randconfig-001-20260709    clang-22
s390                  randconfig-001-20260710    clang-17
s390                           randconfig-002    clang-22
s390                  randconfig-002-20260709    clang-22
s390                  randconfig-002-20260710    clang-17
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    clang-22
sh                    randconfig-001-20260709    clang-22
sh                    randconfig-001-20260710    clang-17
sh                             randconfig-002    clang-22
sh                    randconfig-002-20260709    clang-22
sh                    randconfig-002-20260710    clang-17
sh                   sh7724_generic_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-8.5.0
sparc                 randconfig-001-20260709    gcc-8.5.0
sparc                          randconfig-002    gcc-8.5.0
sparc                 randconfig-002-20260709    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-8.5.0
sparc64               randconfig-001-20260709    gcc-8.5.0
sparc64                        randconfig-002    gcc-8.5.0
sparc64               randconfig-002-20260709    gcc-8.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-8.5.0
um                    randconfig-001-20260709    gcc-8.5.0
um                             randconfig-002    gcc-8.5.0
um                    randconfig-002-20260709    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260709    clang-22
x86_64      buildonly-randconfig-001-20260710    clang-22
x86_64      buildonly-randconfig-002-20260709    clang-22
x86_64      buildonly-randconfig-002-20260710    clang-22
x86_64      buildonly-randconfig-003-20260709    clang-22
x86_64      buildonly-randconfig-003-20260710    clang-22
x86_64      buildonly-randconfig-004-20260709    clang-22
x86_64      buildonly-randconfig-004-20260710    clang-22
x86_64      buildonly-randconfig-005-20260709    clang-22
x86_64      buildonly-randconfig-005-20260710    clang-22
x86_64      buildonly-randconfig-006-20260709    clang-22
x86_64      buildonly-randconfig-006-20260710    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-001    clang-22
x86_64                randconfig-001-20260709    clang-22
x86_64                randconfig-001-20260710    gcc-14
x86_64                         randconfig-002    clang-22
x86_64                randconfig-002-20260709    clang-22
x86_64                randconfig-002-20260710    gcc-14
x86_64                         randconfig-003    clang-22
x86_64                randconfig-003-20260709    clang-22
x86_64                randconfig-003-20260710    gcc-14
x86_64                         randconfig-004    clang-22
x86_64                randconfig-004-20260709    clang-22
x86_64                randconfig-004-20260710    gcc-14
x86_64                         randconfig-005    clang-22
x86_64                randconfig-005-20260709    clang-22
x86_64                randconfig-005-20260710    gcc-14
x86_64                         randconfig-006    clang-22
x86_64                randconfig-006-20260709    clang-22
x86_64                randconfig-006-20260710    gcc-14
x86_64                randconfig-011-20260709    gcc-14
x86_64                randconfig-011-20260710    clang-22
x86_64                randconfig-011-20260710    gcc-14
x86_64                randconfig-012-20260709    gcc-14
x86_64                randconfig-012-20260710    clang-22
x86_64                randconfig-012-20260710    gcc-14
x86_64                randconfig-013-20260709    gcc-14
x86_64                randconfig-013-20260710    clang-22
x86_64                randconfig-014-20260709    gcc-14
x86_64                randconfig-014-20260710    clang-22
x86_64                randconfig-015-20260709    gcc-14
x86_64                randconfig-015-20260710    clang-22
x86_64                randconfig-015-20260710    gcc-14
x86_64                randconfig-016-20260709    gcc-14
x86_64                randconfig-016-20260710    clang-22
x86_64                         randconfig-071    clang-22
x86_64                randconfig-071-20260709    clang-22
x86_64                randconfig-071-20260710    gcc-14
x86_64                         randconfig-072    clang-22
x86_64                randconfig-072-20260709    clang-22
x86_64                randconfig-072-20260710    gcc-14
x86_64                         randconfig-073    clang-22
x86_64                randconfig-073-20260709    clang-22
x86_64                randconfig-073-20260710    gcc-14
x86_64                         randconfig-074    clang-22
x86_64                randconfig-074-20260709    clang-22
x86_64                randconfig-074-20260710    gcc-14
x86_64                         randconfig-075    clang-22
x86_64                randconfig-075-20260709    clang-22
x86_64                randconfig-075-20260710    gcc-14
x86_64                         randconfig-076    clang-22
x86_64                randconfig-076-20260709    clang-22
x86_64                randconfig-076-20260710    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260709    gcc-8.5.0
xtensa                         randconfig-002    gcc-8.5.0
xtensa                randconfig-002-20260709    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
