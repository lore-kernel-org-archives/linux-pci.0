Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B8A28C871
	for <linux-pci@vger.kernel.org>; Sun,  8 Mar 2026 05:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772947797; cv=none; b=nONjPTHhyPFXjLUTpoRL3HP7rxoOdlcU6alyzYWfmyQrGFeCuz0ACWDUTI5Au9LCr5J2QVMABhAx+6RKEVpX4Zg25tUEpqeA7FsCvsuxbYoyZB/NLJOHEGqZwOxUeo3gut7SRszMoYkqMjIWseUvoAZkvaCkqShAGp36I5BEmSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772947797; c=relaxed/simple;
	bh=BikTPLI2Ckv6k5srQbc3J7S9p++bCtH634gcNNjl3a8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=h480/c8wfPCoufNdazgr+a093pl0pKO5QiAYnz8JrU/PkLyRc2cJVUuJ2mBrheonYVr6F21/W+ObXJolvuuQJn3PzWQWNaKEuVCyLbi+VTJzJ0Qdj0+SkaoPjF+Wy4e7/qsKtJUnXe6LG/pqAsSVeEKJPnfIVWFntcFvk7JZyNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4zh9Kt3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4zh9Kt3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772947795; x=1804483795;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BikTPLI2Ckv6k5srQbc3J7S9p++bCtH634gcNNjl3a8=;
  b=f4zh9Kt3q+MCpi1Du3SIXZkPq0tHMeLGi0Wc6EbNtwl8dD5xt0OiMrz4
   3vpPWnd40q6NkB9cccmvpL+dastN2p7B/XkhZeiuTd1DQWr3IIzoLN9ep
   dPL7hpafHNX6JYW/d1g57JBbaYRojBjpVKwgmD+Of9boK3cUfpEA9C9S0
   r1TbndBXQUXmRtFTcnpkoOC2SeBSP6R7gCQGuuECqZvkE+g5urRI8VpJY
   JJ3rYIWTorKRw+ZYKd+zZl7cG5MqXnv7UlR75n5fufvVC3DM3RWJWSIrM
   YXoSbqWEOLrvhzCEDLRGiOJsp+uasB2kMbxLy0gRUYR/jQB4aumSO0CBM
   Q==;
X-CSE-ConnectionGUID: +1rRq1SVSkar01n4x8yIEA==
X-CSE-MsgGUID: SGwFQG/hSgmH6AREXu43jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="73973807"
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="73973807"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 21:29:54 -0800
X-CSE-ConnectionGUID: PLcUSgDkSqSBvUz28Zq0Zw==
X-CSE-MsgGUID: gVegoJnpS+6m/fa68ut40g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="219363176"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 07 Mar 2026 21:29:53 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vz6i6-000000002vr-2wU2;
	Sun, 08 Mar 2026 05:29:50 +0000
Date: Sun, 08 Mar 2026 13:29:41 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:kwilczynski/static-sysfs-attributes] BUILD SUCCESS
 81a4eb86eda6221640ed7f21e47c489821229eef
Message-ID: <202603081334.b91RGVS6-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git kwilczynski/static-sysfs-attributes
branch HEAD: 81a4eb86eda6221640ed7f21e47c489821229eef  PCI/sysfs: Remove pci_create_legacy_files() and pci_sysfs_init()

elapsed time: 752m

configs tested: 225
configs skipped: 6

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
arc                   randconfig-001-20260308    gcc-11.5.0
arc                   randconfig-001-20260308    gcc-8.5.0
arc                   randconfig-002-20260308    gcc-10.5.0
arc                   randconfig-002-20260308    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260308    clang-17
arm                   randconfig-001-20260308    gcc-8.5.0
arm                   randconfig-002-20260308    gcc-8.5.0
arm                   randconfig-003-20260308    clang-18
arm                   randconfig-003-20260308    gcc-8.5.0
arm                   randconfig-004-20260308    clang-23
arm                   randconfig-004-20260308    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260308    clang-23
arm64                 randconfig-002-20260308    clang-23
arm64                 randconfig-003-20260308    clang-23
arm64                 randconfig-004-20260308    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260308    clang-23
csky                  randconfig-002-20260308    clang-23
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260308    clang-23
hexagon               randconfig-002-20260308    clang-16
hexagon               randconfig-002-20260308    clang-23
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260308    clang-20
i386        buildonly-randconfig-002-20260308    clang-20
i386        buildonly-randconfig-003-20260308    clang-20
i386        buildonly-randconfig-004-20260308    clang-20
i386        buildonly-randconfig-005-20260308    clang-20
i386        buildonly-randconfig-006-20260308    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-011-20260308    clang-20
i386                  randconfig-011-20260308    gcc-14
i386                  randconfig-012-20260308    clang-20
i386                  randconfig-013-20260308    clang-20
i386                  randconfig-013-20260308    gcc-14
i386                  randconfig-014-20260308    clang-20
i386                  randconfig-014-20260308    gcc-14
i386                  randconfig-015-20260308    clang-20
i386                  randconfig-015-20260308    gcc-14
i386                  randconfig-016-20260308    clang-20
i386                  randconfig-017-20260308    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260308    clang-19
loongarch             randconfig-001-20260308    clang-23
loongarch             randconfig-002-20260308    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                        mvme147_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                     decstation_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260308    clang-23
nios2                 randconfig-001-20260308    gcc-11.5.0
nios2                 randconfig-002-20260308    clang-23
nios2                 randconfig-002-20260308    gcc-11.5.0
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
parisc                randconfig-001-20260308    gcc-8.5.0
parisc                randconfig-002-20260308    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      pcm030_defconfig    clang-23
powerpc               randconfig-001-20260308    clang-23
powerpc               randconfig-001-20260308    gcc-8.5.0
powerpc               randconfig-002-20260308    gcc-8.5.0
powerpc64             randconfig-001-20260308    clang-23
powerpc64             randconfig-001-20260308    gcc-8.5.0
powerpc64             randconfig-002-20260308    clang-23
powerpc64             randconfig-002-20260308    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260308    gcc-12.5.0
riscv                 randconfig-001-20260308    gcc-14.3.0
riscv                 randconfig-002-20260308    clang-23
riscv                 randconfig-002-20260308    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260308    gcc-12.5.0
s390                  randconfig-002-20260308    gcc-12.5.0
s390                  randconfig-002-20260308    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260308    gcc-12.5.0
sh                    randconfig-001-20260308    gcc-15.2.0
sh                    randconfig-002-20260308    gcc-12.5.0
sh                    randconfig-002-20260308    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260308    gcc-15.2.0
sparc                 randconfig-002-20260308    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260308    gcc-15.2.0
sparc64               randconfig-002-20260308    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260308    gcc-15.2.0
um                    randconfig-002-20260308    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260308    clang-20
x86_64      buildonly-randconfig-002-20260308    clang-20
x86_64      buildonly-randconfig-003-20260308    clang-20
x86_64      buildonly-randconfig-003-20260308    gcc-14
x86_64      buildonly-randconfig-004-20260308    clang-20
x86_64      buildonly-randconfig-005-20260308    clang-20
x86_64      buildonly-randconfig-005-20260308    gcc-14
x86_64      buildonly-randconfig-006-20260308    clang-20
x86_64      buildonly-randconfig-006-20260308    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260308    gcc-14
x86_64                randconfig-002-20260308    gcc-14
x86_64                randconfig-003-20260308    gcc-14
x86_64                randconfig-004-20260308    gcc-14
x86_64                randconfig-005-20260308    gcc-14
x86_64                randconfig-006-20260308    gcc-14
x86_64                randconfig-011-20260308    clang-20
x86_64                randconfig-011-20260308    gcc-14
x86_64                randconfig-012-20260308    clang-20
x86_64                randconfig-012-20260308    gcc-14
x86_64                randconfig-013-20260308    clang-20
x86_64                randconfig-013-20260308    gcc-14
x86_64                randconfig-014-20260308    clang-20
x86_64                randconfig-014-20260308    gcc-14
x86_64                randconfig-015-20260308    clang-20
x86_64                randconfig-016-20260308    clang-20
x86_64                randconfig-071-20260308    gcc-14
x86_64                randconfig-072-20260308    gcc-14
x86_64                randconfig-073-20260308    gcc-14
x86_64                randconfig-074-20260308    gcc-14
x86_64                randconfig-075-20260308    gcc-14
x86_64                randconfig-076-20260308    gcc-14
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
xtensa                randconfig-001-20260308    gcc-15.2.0
xtensa                randconfig-002-20260308    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
