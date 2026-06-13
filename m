Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869A52E11D2
	for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2026 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781377691; cv=none; b=mcv4fTm8OTH356+8ZSBTaAq3u6UqkqKqMkU2qlHeigUem7idkxnCzbpinA22qygTzlT1XVieF8LuEg8KkQ3e5aVvHt4WV3Qtnci58KD5ZOgVTy7xMs+7KSXxY9iU+THmQNViCkiXC5UZB9s3hJDMV7RXz/tN6Cr4J38WHgI+zRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781377691; c=relaxed/simple;
	bh=EpGROdqjQUfi43WhLOJ+008s7OtVuEpF7pM5sK3hoNA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cGAGNAcWmIW3BhGWfknpyzjuOvVW7yQmpDXa6PX4Thu5V10FSIKVkedStxEc9qYejJpzDc+l2r+yS3h079vZ1dtpJ3n/d16mcn5euoWpiNAGnvqopsP3E1CPUtGJgwAPcNK+MD/2wG08weyQCoSsXRO2fhqglFEEv2S+tTucoGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4jQzGrr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4jQzGrr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781377689; x=1812913689;
  h=date:from:to:cc:subject:message-id;
  bh=EpGROdqjQUfi43WhLOJ+008s7OtVuEpF7pM5sK3hoNA=;
  b=C4jQzGrrzFH+QckZX2ZNpoMmrZ8GW0U4MGHOfrBgVqbOn4NBRv8hsAWH
   BpZlxI99YYWy/8jp9LP+cjXyZUAoaYIGAvN36UD/kXuL/nWN+eVhn9MGk
   Ow3hMP7PjQEoAOaotfy6KWNEElAa1bf/q7nBEt9aUaATmcENmtJQwH5/M
   YHnedkFmnnt7gEV8NwU1RBhov/F6aQ+saZulxMgc+/qFPQxvN69S7+E+Y
   PaB5UeFEhDcFoRFLXwYrfnXTNA5DTFWLbj7r5Vl6jQ9C+ym1Osfo1mdYI
   Luyt/0DcaEYqYctdsCj7wg9GeG6/D3UlFOkMtsE8wtSvZTgWj+FiqzcJN
   A==;
X-CSE-ConnectionGUID: RQ2lNDlrR8WSOvmydebTnA==
X-CSE-MsgGUID: yFPQT7DdSiaw03nGV6GGzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="93568064"
X-IronPort-AV: E=Sophos;i="6.24,203,1774335600"; 
   d="scan'208";a="93568064"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 12:08:09 -0700
X-CSE-ConnectionGUID: BJfH9ap6SR6QeBfNFSJJHw==
X-CSE-MsgGUID: ZNUgOq75TEqeboWNsaYtlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,203,1774335600"; 
   d="scan'208";a="242957280"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 13 Jun 2026 12:08:08 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wYTi9-00000000QC2-3DVV;
	Sat, 13 Jun 2026 19:08:05 +0000
Date: Sun, 14 Jun 2026 03:07:45 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 d898796a8e7ed8528c775f33da056e9978c4c248
Message-ID: <202606140333.tJKBMZNS-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: d898796a8e7ed8528c775f33da056e9978c4c248  MAINTAINERS: Add Frank Li as PCI endpoint reviewer

elapsed time: 952m

configs tested: 293
configs skipped: 6

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
arc                   randconfig-001-20260613    gcc-12.5.0
arc                   randconfig-001-20260614    gcc-11.5.0
arc                   randconfig-002-20260613    gcc-12.5.0
arc                   randconfig-002-20260613    gcc-14.3.0
arc                   randconfig-002-20260614    gcc-11.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260613    gcc-12.5.0
arm                   randconfig-001-20260613    gcc-8.5.0
arm                   randconfig-001-20260614    gcc-11.5.0
arm                   randconfig-002-20260613    clang-17
arm                   randconfig-002-20260613    gcc-12.5.0
arm                   randconfig-002-20260614    gcc-11.5.0
arm                   randconfig-003-20260613    clang-23
arm                   randconfig-003-20260613    gcc-12.5.0
arm                   randconfig-003-20260614    gcc-11.5.0
arm                   randconfig-004-20260613    clang-23
arm                   randconfig-004-20260613    gcc-12.5.0
arm                   randconfig-004-20260614    gcc-11.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    gcc-16.1.0
arm64                 randconfig-001-20260613    gcc-16.1.0
arm64                          randconfig-002    gcc-16.1.0
arm64                 randconfig-002-20260613    gcc-16.1.0
arm64                          randconfig-003    gcc-16.1.0
arm64                 randconfig-003-20260613    gcc-16.1.0
arm64                          randconfig-004    gcc-16.1.0
arm64                 randconfig-004-20260613    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    gcc-16.1.0
csky                  randconfig-001-20260613    gcc-16.1.0
csky                           randconfig-002    gcc-16.1.0
csky                  randconfig-002-20260613    gcc-16.1.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260613    clang-23
hexagon               randconfig-001-20260614    clang-17
hexagon               randconfig-002-20260613    clang-23
hexagon               randconfig-002-20260614    clang-17
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260613    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260613    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260613    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260613    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260613    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260613    gcc-14
i386                                defconfig    gcc-16.1.0
i386                           randconfig-001    clang-22
i386                  randconfig-001-20260613    clang-22
i386                  randconfig-001-20260613    gcc-14
i386                           randconfig-002    clang-22
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260613    clang-22
i386                           randconfig-003    clang-22
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260613    clang-22
i386                  randconfig-003-20260613    gcc-14
i386                           randconfig-004    clang-22
i386                  randconfig-004-20260613    clang-22
i386                           randconfig-005    clang-22
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260613    clang-22
i386                           randconfig-006    clang-22
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260613    clang-22
i386                  randconfig-006-20260613    gcc-14
i386                           randconfig-007    clang-22
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260613    clang-22
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260613    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260613    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260613    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260613    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260613    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260613    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260613    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260613    clang-18
loongarch             randconfig-001-20260613    clang-23
loongarch             randconfig-001-20260614    clang-17
loongarch             randconfig-002-20260613    clang-23
loongarch             randconfig-002-20260614    clang-17
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                   sb1250_swarm_defconfig    gcc-16.1.0
mips                        vocore2_defconfig    clang-20
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260613    clang-23
nios2                 randconfig-001-20260613    gcc-11.5.0
nios2                 randconfig-001-20260614    clang-17
nios2                 randconfig-002-20260613    clang-23
nios2                 randconfig-002-20260613    gcc-10.5.0
nios2                 randconfig-002-20260614    clang-17
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    clang-23
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-15.2.0
parisc                randconfig-001-20260613    gcc-15.2.0
parisc                         randconfig-002    gcc-15.2.0
parisc                randconfig-002-20260613    gcc-15.2.0
parisc64                            defconfig    clang-23
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                 canyonlands_defconfig    clang-22
powerpc                  mpc885_ads_defconfig    clang-23
powerpc                        randconfig-001    gcc-15.2.0
powerpc               randconfig-001-20260613    gcc-15.2.0
powerpc                        randconfig-002    gcc-15.2.0
powerpc               randconfig-002-20260613    gcc-15.2.0
powerpc64                      randconfig-001    gcc-15.2.0
powerpc64             randconfig-001-20260613    gcc-15.2.0
powerpc64                      randconfig-002    gcc-15.2.0
powerpc64             randconfig-002-20260613    gcc-15.2.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-10.5.0
riscv                 randconfig-001-20260613    gcc-10.5.0
riscv                 randconfig-001-20260614    gcc-9.5.0
riscv                          randconfig-002    gcc-10.5.0
riscv                 randconfig-002-20260613    gcc-10.5.0
riscv                 randconfig-002-20260614    gcc-9.5.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-10.5.0
s390                  randconfig-001-20260613    gcc-10.5.0
s390                  randconfig-001-20260614    gcc-9.5.0
s390                           randconfig-002    gcc-10.5.0
s390                  randconfig-002-20260613    gcc-10.5.0
s390                  randconfig-002-20260614    gcc-9.5.0
s390                       zfcpdump_defconfig    clang-22
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    clang-23
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                          r7780mp_defconfig    gcc-16.1.0
sh                             randconfig-001    gcc-10.5.0
sh                    randconfig-001-20260613    gcc-10.5.0
sh                    randconfig-001-20260614    gcc-9.5.0
sh                             randconfig-002    gcc-10.5.0
sh                    randconfig-002-20260613    gcc-10.5.0
sh                    randconfig-002-20260614    gcc-9.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260613    gcc-13.4.0
sparc                 randconfig-002-20260613    gcc-13.4.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260613    gcc-13.4.0
sparc64               randconfig-002-20260613    gcc-13.4.0
um                               allmodconfig    clang-17
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260613    gcc-13.4.0
um                    randconfig-002-20260613    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260613    clang-22
x86_64      buildonly-randconfig-002-20260613    clang-22
x86_64      buildonly-randconfig-003-20260613    clang-22
x86_64      buildonly-randconfig-004-20260613    clang-22
x86_64      buildonly-randconfig-005-20260613    clang-22
x86_64      buildonly-randconfig-006-20260613    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260613    clang-22
x86_64                randconfig-002-20260613    clang-22
x86_64                randconfig-003-20260613    clang-22
x86_64                randconfig-004-20260613    clang-22
x86_64                randconfig-005-20260613    clang-22
x86_64                randconfig-006-20260613    clang-22
x86_64                randconfig-011-20260613    clang-22
x86_64                randconfig-011-20260613    gcc-13
x86_64                randconfig-012-20260613    clang-22
x86_64                randconfig-013-20260613    clang-22
x86_64                randconfig-014-20260613    clang-22
x86_64                randconfig-015-20260613    clang-22
x86_64                randconfig-016-20260613    clang-22
x86_64                randconfig-016-20260613    gcc-14
x86_64                         randconfig-071    gcc-13
x86_64                randconfig-071-20260613    clang-22
x86_64                randconfig-071-20260613    gcc-13
x86_64                         randconfig-072    gcc-13
x86_64                randconfig-072-20260613    clang-22
x86_64                randconfig-072-20260613    gcc-13
x86_64                         randconfig-073    gcc-13
x86_64                randconfig-073-20260613    clang-22
x86_64                randconfig-073-20260613    gcc-13
x86_64                         randconfig-074    gcc-13
x86_64                randconfig-074-20260613    clang-22
x86_64                randconfig-074-20260613    gcc-13
x86_64                         randconfig-075    gcc-13
x86_64                randconfig-075-20260613    clang-22
x86_64                randconfig-075-20260613    gcc-13
x86_64                         randconfig-076    gcc-13
x86_64                randconfig-076-20260613    clang-22
x86_64                randconfig-076-20260613    gcc-13
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260613    gcc-13.4.0
xtensa                randconfig-002-20260613    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
