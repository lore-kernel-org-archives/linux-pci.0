Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C2B220F38
	for <linux-pci@vger.kernel.org>; Sat,  4 Apr 2026 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775300661; cv=none; b=LE/TYv++tLVeuIjqVNafJeHY57P7W8jCE83r6azVIsOiUBHwsH7J5Mb+4JMOi42XCErR99fqzau4HLZk8l6H6x8uwf7IcwiAnjF37iyDnp6IZT/vNGlzFxF+S1Py1O2Fl/K06i6heCeBf5Nj3m7fVjmMIio7ku0Uadvv5qSNsfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775300661; c=relaxed/simple;
	bh=wcm/4Dd+Dp11XpHVqHisBY35yvsgqAub4AQBa/JZrw4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nspTDjeTjCXzM0FMB2KWrAH1/2GSnfWiiMKZJ1VjpG5TtC63yLALOgrnXZtSzG3pdnSCAlWybHEh84GQGpsaFRNPz9KDf7YQzOj3+neMdgZ6Xg2NsrDEj7FIZnjwWDcwXKMr1Em3lOvo8MaCvXTGUyqmT4UM5Kx/9e2u3zB5lBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nALbntYi; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nALbntYi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775300660; x=1806836660;
  h=date:from:to:cc:subject:message-id;
  bh=wcm/4Dd+Dp11XpHVqHisBY35yvsgqAub4AQBa/JZrw4=;
  b=nALbntYi6ExRC86rBGdgEtVXQeXPTkKaGhcRt6NA5hhbBXG50svSXOZ+
   EMG2MUvqxwjcn7Q8wEcs4V67ErusmHY2Ye4Z1dLBzJ3ooK/Nj8B8+AAdu
   rXvNEffeFPsiKCiq/i8+9/11p/eA2K9ub9/x/W4BmKUwRDSOpTBU3JS5J
   o29R/RhvVS53ORuk9fb3QjeaLpVBBRIvtaYVfTzEXouwteW3fkNZdES0w
   IGTj2W1Pb30pPCNhdT3vz/YADIGKuN0aW0g53ISw4idhdbxBnAAsIgF4I
   EP5aOeiGXZhVu3+SMItwW5JytkBx7e6Qp5Sh9H4XtKdYpMrrdnciREzwY
   w==;
X-CSE-ConnectionGUID: KUOqihALQ6uRm8f0QAYGoQ==
X-CSE-MsgGUID: NXwnyMGfSem/iK9Y+YR0FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="87411233"
X-IronPort-AV: E=Sophos;i="6.23,159,1770624000"; 
   d="scan'208";a="87411233"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2026 04:04:20 -0700
X-CSE-ConnectionGUID: dDtNRsU1RqC7qXeH4OScgg==
X-CSE-MsgGUID: uA2xToiCScyIgfUOoCE2+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,159,1770624000"; 
   d="scan'208";a="224645564"
Received: from lkp-server01.sh.intel.com (HELO 3afb7d003cac) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 04 Apr 2026 04:04:17 -0700
Received: from kbuild by 3afb7d003cac with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w8ynW-000000000eL-3n2F;
	Sat, 04 Apr 2026 11:04:14 +0000
Date: Sat, 04 Apr 2026 19:03:48 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:atomics] BUILD SUCCESS
 8e69214402397fcbb17f25ac5acb178195aca4bc
Message-ID: <202604041940.stoCNmkH-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git atomics
branch HEAD: 8e69214402397fcbb17f25ac5acb178195aca4bc  PCI: Update PCIe spec references for AtomicOps

elapsed time: 803m

configs tested: 188
configs skipped: 2

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
arc                   randconfig-001-20260404    gcc-15.2.0
arc                   randconfig-002-20260404    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260404    gcc-15.2.0
arm                   randconfig-002-20260404    gcc-15.2.0
arm                   randconfig-003-20260404    gcc-15.2.0
arm                   randconfig-004-20260404    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260404    gcc-15.2.0
arm64                 randconfig-002-20260404    gcc-15.2.0
arm64                 randconfig-003-20260404    gcc-15.2.0
arm64                 randconfig-004-20260404    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260404    gcc-15.2.0
csky                  randconfig-002-20260404    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260404    gcc-15.2.0
hexagon               randconfig-002-20260404    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260404    clang-20
i386        buildonly-randconfig-002-20260404    clang-20
i386        buildonly-randconfig-003-20260404    clang-20
i386        buildonly-randconfig-004-20260404    clang-20
i386        buildonly-randconfig-005-20260404    clang-20
i386        buildonly-randconfig-006-20260404    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260404    clang-20
i386                  randconfig-002-20260404    clang-20
i386                  randconfig-003-20260404    clang-20
i386                  randconfig-004-20260404    clang-20
i386                  randconfig-005-20260404    clang-20
i386                  randconfig-006-20260404    clang-20
i386                  randconfig-007-20260404    clang-20
i386                  randconfig-011-20260404    clang-20
i386                  randconfig-012-20260404    clang-20
i386                  randconfig-013-20260404    clang-20
i386                  randconfig-014-20260404    clang-20
i386                  randconfig-015-20260404    clang-20
i386                  randconfig-016-20260404    clang-20
i386                  randconfig-017-20260404    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260404    gcc-15.2.0
loongarch             randconfig-002-20260404    gcc-15.2.0
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
mips                        omega2p_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260404    gcc-15.2.0
nios2                 randconfig-002-20260404    gcc-15.2.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260404    gcc-10.5.0
parisc                randconfig-002-20260404    gcc-10.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc                    mvme5100_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260404    gcc-10.5.0
powerpc               randconfig-002-20260404    gcc-10.5.0
powerpc64             randconfig-001-20260404    gcc-10.5.0
powerpc64             randconfig-002-20260404    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260404    clang-20
riscv                 randconfig-002-20260404    clang-20
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260404    clang-20
s390                  randconfig-002-20260404    clang-20
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260404    clang-20
sh                    randconfig-002-20260404    clang-20
sh                           se7751_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260404    clang-20
sparc                 randconfig-002-20260404    clang-20
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260404    clang-20
sparc64               randconfig-002-20260404    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260404    clang-20
um                    randconfig-002-20260404    clang-20
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260404    gcc-13
x86_64      buildonly-randconfig-002-20260404    gcc-13
x86_64      buildonly-randconfig-003-20260404    gcc-13
x86_64      buildonly-randconfig-004-20260404    gcc-13
x86_64      buildonly-randconfig-005-20260404    gcc-13
x86_64      buildonly-randconfig-006-20260404    gcc-13
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260404    gcc-14
x86_64                randconfig-002-20260404    gcc-14
x86_64                randconfig-003-20260404    gcc-14
x86_64                randconfig-004-20260404    gcc-14
x86_64                randconfig-005-20260404    gcc-14
x86_64                randconfig-006-20260404    gcc-14
x86_64                randconfig-011-20260404    gcc-14
x86_64                randconfig-012-20260404    gcc-14
x86_64                randconfig-013-20260404    gcc-14
x86_64                randconfig-014-20260404    gcc-14
x86_64                randconfig-015-20260404    gcc-14
x86_64                randconfig-016-20260404    gcc-14
x86_64                randconfig-071-20260404    gcc-14
x86_64                randconfig-072-20260404    gcc-14
x86_64                randconfig-073-20260404    gcc-14
x86_64                randconfig-074-20260404    gcc-14
x86_64                randconfig-075-20260404    gcc-14
x86_64                randconfig-076-20260404    gcc-14
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
xtensa                randconfig-001-20260404    clang-20
xtensa                randconfig-002-20260404    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
