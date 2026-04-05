Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B4C339863
	for <linux-pci@vger.kernel.org>; Sun,  5 Apr 2026 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775376243; cv=none; b=ImoEMWeXh08H9A0g3YpEllzBPv0ry16QChHTazhUEej7DHXyAJr+hcHjfkAwMyPIttnr2UZwX005/3d32PDZu3Uho+A37iGXOUgdAeLpQPYQ0myuwWzz/Gb20iAhr2wwBY0W2AgFJvbw8GUrAMuM/RAIixcNf+IL+ebckSFEDL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775376243; c=relaxed/simple;
	bh=soI7zTw35aYwvv4+lpJqUlnOaBuStzZubzBYGuCNUOA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fegdTQVYoCn3H7a19JRecOlXPWekK09t6pvu8rgOz+/VNDQP6pbx6YivBkycJHJv3ynoHwYnsXcRt3xHCunAmzNPTukPkPDAgyd5Xf928x5iSOeO7HDHXRfpI/NRhW7r8foffwlWPSYggcU5hvt0U7bhN0nSUzWLHCQ3ylkVcxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jgza6dk0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jgza6dk0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775376242; x=1806912242;
  h=date:from:to:cc:subject:message-id;
  bh=soI7zTw35aYwvv4+lpJqUlnOaBuStzZubzBYGuCNUOA=;
  b=jgza6dk0MjiomWEiPG4Iv6tD5XzXbstAOQcoqU+w57T0OywigWGko3Ne
   OFGRyTsRdOQFzDbhriXwDTl81RT/5D1PNlzdBAIywvPvYqI1RVgjrDrQ8
   xRdYJ4rp5TSplxO2ZPIL3wmt9CqMA0QhXAOd9iQUFp1PcAPq2fHF5eJ9T
   0YFQusu22TSvb1OTSjw+tiK6Efa9Utvj1JNUt9x7O2Cqx1ffE6v0l62hg
   W41+5BNOLncgRLxn9Ja2YACxWCEnvuAMq98AJpL4y/c6G2XoKSnjR8YvI
   PhUqfNK0HQ0mrKVAK/gMySic+fTU20V1IPYh8cy6wNy9GiMLRjHNkJMaY
   g==;
X-CSE-ConnectionGUID: ugrYpGiWRESmA/XFmFL0VQ==
X-CSE-MsgGUID: UoL/k9u/SXyRSPCM791+CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11749"; a="86993775"
X-IronPort-AV: E=Sophos;i="6.23,161,1770624000"; 
   d="scan'208";a="86993775"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2026 01:04:01 -0700
X-CSE-ConnectionGUID: VCkQLW+ERyGbILr9JMM1EA==
X-CSE-MsgGUID: RDc+snzrSLCTt94W4nRP2A==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 3afb7d003cac) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 05 Apr 2026 01:04:00 -0700
Received: from kbuild by 3afb7d003cac with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w9ISc-000000001zh-1Div;
	Sun, 05 Apr 2026 08:03:58 +0000
Date: Sun, 05 Apr 2026 16:03:12 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/aspeed] BUILD SUCCESS
 c54d5f5b33990f2649c20f35407f340bcadb8a53
Message-ID: <202604051603.hzETXFGR-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/aspeed
branch HEAD: c54d5f5b33990f2649c20f35407f340bcadb8a53  PCI: aspeed: Fix IRQ domain leak on platform_get_irq() failure

elapsed time: 742m

configs tested: 172
configs skipped: 6

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
arc                   randconfig-001-20260405    clang-23
arc                   randconfig-002-20260405    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260405    clang-23
arm                   randconfig-002-20260405    clang-23
arm                   randconfig-003-20260405    clang-23
arm                   randconfig-004-20260405    clang-23
arm                        realview_defconfig    clang-16
arm                         socfpga_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260405    gcc-9.5.0
arm64                 randconfig-002-20260405    gcc-9.5.0
arm64                 randconfig-003-20260405    gcc-9.5.0
arm64                 randconfig-004-20260405    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260405    gcc-9.5.0
csky                  randconfig-002-20260405    gcc-9.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260405    clang-23
hexagon               randconfig-002-20260405    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260405    gcc-14
i386        buildonly-randconfig-002-20260405    gcc-14
i386        buildonly-randconfig-003-20260405    gcc-14
i386        buildonly-randconfig-004-20260405    gcc-14
i386        buildonly-randconfig-005-20260405    gcc-14
i386        buildonly-randconfig-006-20260405    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260405    gcc-14
i386                  randconfig-002-20260405    gcc-14
i386                  randconfig-003-20260405    gcc-14
i386                  randconfig-004-20260405    gcc-14
i386                  randconfig-005-20260405    gcc-14
i386                  randconfig-006-20260405    gcc-14
i386                  randconfig-007-20260405    gcc-14
i386                  randconfig-011-20260405    gcc-14
i386                  randconfig-012-20260405    gcc-14
i386                  randconfig-013-20260405    gcc-14
i386                  randconfig-014-20260405    gcc-14
i386                  randconfig-015-20260405    gcc-14
i386                  randconfig-016-20260405    gcc-14
i386                  randconfig-017-20260405    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260405    clang-23
loongarch             randconfig-002-20260405    clang-23
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
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260405    clang-23
nios2                 randconfig-002-20260405    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260405    gcc-10.5.0
parisc                randconfig-002-20260405    gcc-10.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                 mpc837x_rdb_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260405    gcc-10.5.0
powerpc               randconfig-002-20260405    gcc-10.5.0
powerpc64             randconfig-001-20260405    gcc-10.5.0
powerpc64             randconfig-002-20260405    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260405    clang-23
riscv                 randconfig-002-20260405    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260405    clang-23
s390                  randconfig-002-20260405    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                             espt_defconfig    gcc-15.2.0
sh                    randconfig-001-20260405    clang-23
sh                    randconfig-002-20260405    clang-23
sh                        sh7757lcr_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260405    clang-23
sparc                 randconfig-002-20260405    clang-23
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260405    clang-23
sparc64               randconfig-002-20260405    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260405    clang-23
um                    randconfig-002-20260405    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260405    gcc-14
x86_64      buildonly-randconfig-002-20260405    gcc-14
x86_64      buildonly-randconfig-003-20260405    gcc-14
x86_64      buildonly-randconfig-004-20260405    gcc-14
x86_64      buildonly-randconfig-005-20260405    gcc-14
x86_64      buildonly-randconfig-006-20260405    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260405    clang-20
x86_64                randconfig-002-20260405    clang-20
x86_64                randconfig-003-20260405    clang-20
x86_64                randconfig-004-20260405    clang-20
x86_64                randconfig-005-20260405    clang-20
x86_64                randconfig-006-20260405    clang-20
x86_64                randconfig-011-20260405    gcc-14
x86_64                randconfig-012-20260405    gcc-14
x86_64                randconfig-013-20260405    gcc-14
x86_64                randconfig-014-20260405    gcc-14
x86_64                randconfig-015-20260405    gcc-14
x86_64                randconfig-016-20260405    gcc-14
x86_64                randconfig-071-20260405    gcc-14
x86_64                randconfig-072-20260405    gcc-14
x86_64                randconfig-073-20260405    gcc-14
x86_64                randconfig-074-20260405    gcc-14
x86_64                randconfig-075-20260405    gcc-14
x86_64                randconfig-076-20260405    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260405    clang-23
xtensa                randconfig-002-20260405    clang-23

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
